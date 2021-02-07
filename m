Return-Path: <SRS0=Xhap=HJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386DFC433DB
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 09:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BB264E41
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 09:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BB264E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9326E6E5A9;
	Sun,  7 Feb 2021 09:12:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D398C6E5A9
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Feb 2021 09:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3mjzT01cM4dGTz7ayzUTvKIRFl9MPyrqmRtJvZ29KAadsp3xwsozNikzsiL00/ATItIL5JZ0cVQzv5dKkB7m8Ei84zjdZWW+cBK7h9On+221I3T26J7vE2IV4Vroz4DARiOMHgbuFbL9q9kDbU5Wx5PPoT+AoSaG6bUe7qjED/CnRas8UYTrso/veit1UkEtLa3UpI5TvgKkHERdAV4aK819DHGrc3l07laJu4/lDkCbpiEGNtv85xISBmEHqZL4NlYiuwhfv6tdpPKn5MP6KUGwMUbWdjCbDwlmr1TszSPfF6j/6IdqMehWhS6Wua8McETeAsfjkBRDxbxEN2Xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57noBrZkj6PAUxXDU+Tay6D9JOsUMZ3HLJcLWIWS3M0=;
 b=GPldreHWq3YglDXTWW9fK4zdaaBMZmY7tPQ/QLF24BpI6BLGGRgin2PAM4CpXKgSob+BELwX6u4Y7wTXw0limB/xJkZc1Wek0fah29UmLr+x0g8GIUqi6Jcjn97gq6JBjmAhnpJkds8bptZ8n/L6sathER1E5tGU79OoENg4MgXglW5dNqC4PPp/Avxm+fequvOOPyw0ZAAR7ybuenqBg/34IBcifHIXVfd5hq20dehE6hcQT83roN5rtlgcPqFIxLD93P0C6uyOrju2peUHmuWYCVArNTk1AG6vgeZFzD+fvVpTtnChf/qmLfcZTKh3x0StOffdiKTX6xD5J1FvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57noBrZkj6PAUxXDU+Tay6D9JOsUMZ3HLJcLWIWS3M0=;
 b=1c4MlNaYzMF1InezkYoCxrsu+eW6QA2/VF7dvlEsxtgcYbBC2GVzqhtFJ2JKrHQnR1id6uMLarE7c5uJqdtA/s/7xw7nR+wBd5UaDshu3OMREyfy3oXJ/k/klVGgcS0le41HVWgvwU5l4hnzQfhov8lVKNTChXb7Ptp9rcxp19w=
Received: from CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Sun, 7 Feb
 2021 09:12:23 +0000
Received: from CH2PR12MB4890.namprd12.prod.outlook.com
 ([fe80::1dc7:1e93:5f14:be8a]) by CH2PR12MB4890.namprd12.prod.outlook.com
 ([fe80::1dc7:1e93:5f14:be8a%4]) with mapi id 15.20.3825.030; Sun, 7 Feb 2021
 09:12:23 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable gpu recovery for dimgrey_cavefish
Thread-Topic: [PATCH] drm/amdgpu: enable gpu recovery for dimgrey_cavefish
Thread-Index: AQHW/S6R5uSSDOFeA0GwUmqV2eEosKpMZ6fg
Date: Sun, 7 Feb 2021 09:12:23 +0000
Message-ID: <CH2PR12MB489092A5B5392C2B31154C71EAB09@CH2PR12MB4890.namprd12.prod.outlook.com>
References: <20210207085213.24012-1-tao.zhou1@amd.com>
In-Reply-To: <20210207085213.24012-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=86a9e647-5552-426a-8764-d775c099d5eb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-07T09:09:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1df76fc2-c3ad-4c0d-c7f3-08d8cb487ae7
x-ms-traffictypediagnostic: CH2PR12MB4293:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB42935FB111FFD5054476ED06EAB09@CH2PR12MB4293.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lodiuhYkG95+y+zkrbIaJ0K/Q1RVcHWTlRlikmEokWl6NlXOHrXtcmJQrBXjg30lW3PcYyoihuUD4/cW8Rxx6gSH96EwOiw+qITdafJ0O54f7d/zUswgeuIapIE5pCL3iCCIma5iuG6dGU9q/cJSGryTpF6Gq8mhO9DykEmlZVv1ujb4VAU88lLqqYq6dOEXrFckBXBlZRuxqDjHuhlEGR4LcLdvV4S0/Udthw27I54EZiQCT5nbenryJNFWEd2JkphFeukIcmjb4MCKn+IexHN380ZkuQg+yvaIiiOmwiIgze0Mf/oHEm1K8WInCPmZYGtHYv5I3DdTvot2C3qE7By7wVNQRwbRnjdE0tnTSaMzWi+D85tEdTqlVeSkFh8VfajqD+KRAYLQNGsE1NXpvwgQlopXqH+j84crYK+eneesM/1kL15jDtmOcw1NyvDn9XcsIndVwgJFbH9NbGpO7b1abEetZuhgNXXKFwriO4ape0zz3SX8R92acfAvrFiBrjdBqkIHnvJG/9Vx0jeF1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4890.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(478600001)(8936002)(55016002)(9686003)(2906002)(66446008)(316002)(64756008)(86362001)(110136005)(53546011)(26005)(6506007)(71200400001)(186003)(76116006)(33656002)(8676002)(66476007)(66946007)(52536014)(5660300002)(7696005)(83380400001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XC4T9iufl6HH9KqM3MVQ3Ee1ZF/aGMod3pJ4BfhyQ8uj3AsYqOC4dJhe9kp7?=
 =?us-ascii?Q?3QE0xB43VFGS0bWoj5T7Zirn/PU0aAj6IoafYDGCw5f/4ReeyihrFVSMM4dD?=
 =?us-ascii?Q?H+bnfQMuUoUp4cVCi2aO/1uA81nw/kpXl0zfjUzUSRB1DYN3L0fJXxP/YtdY?=
 =?us-ascii?Q?xAxoZHdgdd59nuHnIXEBjwR2wMMR0wj6onIHnAIDdQfU9VYp16U9wgm4nhgv?=
 =?us-ascii?Q?6c9OgHz8FrTYbcH0ZUXPBy3gqQTIL5k54l+A8gSQtA+FTqI7a5M6Y5CR4t0/?=
 =?us-ascii?Q?mXeD3EQjzfFvvKEj+Uyc8k5CiBcR7Kgq0Zm324wPDfA9oZlucFcbWAMfWh8i?=
 =?us-ascii?Q?7lTSjN+q6QmZQtCGUwiyioKlBkCO8OWbYOQKw2uj7Z/sotB+sSjWnZ30ne/I?=
 =?us-ascii?Q?KynKfwohKbK3CUvxQAEA+DylHcYYfVYbgO37thGemJjRLRWLsm1o7vKAWJVo?=
 =?us-ascii?Q?616SGlYJt0aaFbgjdvoPBPa+WZ3J4LDIYdmBeUjw5JYbtNDvtWtZAiR5gYqp?=
 =?us-ascii?Q?Ko70vc1yu2v5NKmbQ9WcK9OMcFf1EMWXFaPpmfwa8989hmJPZsCLnMoTNnbk?=
 =?us-ascii?Q?ZTgqaUFqdMk+l/+oSCK640DF4AfC/kk7SrTiiAEX6FJ86LC+ytPWrsCg15y4?=
 =?us-ascii?Q?CxyGLLSMib+JSK0OKiOz0iM0Xm0JbNsIQS6jRkckKjVei/JPmTYSaAWMI2ai?=
 =?us-ascii?Q?G7hTAuz+0pWuWFqw21t2F9OAOch4pIhVBF8FleB9pP55XuDgzoUTgFEdbH2w?=
 =?us-ascii?Q?7QowLKZpv8SNIcbT6QLLsipuAT1l7jwScJbsnnBqIHLQ7aLJfzcGHkWG5Nhb?=
 =?us-ascii?Q?ZILQjI2B2bCf93Ctx/Wq2bM8EJ9E3bEDVzBr1cGrWRsOkjUeQl5t6WxtJpsT?=
 =?us-ascii?Q?oU892+KwzBlEUo3LZCfLSwkSdQelX9VjVgNaQbuxpe3IvXBZBR4lqu+v2WxZ?=
 =?us-ascii?Q?hOPgP7cZ57xx5itigBf8uD4xcEq7cmxUEr0XkKtLfxWF3/HyabLfhZoofCLS?=
 =?us-ascii?Q?C2oF9sxminRGCnQ8Vb2nAEY48lcb929HgMo3agz3Mn2HPnaS7YMvlHiKtIKq?=
 =?us-ascii?Q?4xKyOQgcxUBYQBTjrPsph/UBMFnXtAZHvCt8fK0Ov6mj9ugmvb3+LeRgxBgh?=
 =?us-ascii?Q?TsGm1R5st6GK35j1b3xz5I2E9SGPezLfo/HsPU/+nQeIoTj9PCsUWb1jphYk?=
 =?us-ascii?Q?ktXjCwfM5pMh4k/vj85GOh1UK10DpZn9m1IQKEk1aVTSS5/pHU3eGNt/3l1A?=
 =?us-ascii?Q?27MjxQ3tsa2Zy+1bN/jYp9eIXoVcath551iFOsKQdfvRSSHk6nFOqScIFXGY?=
 =?us-ascii?Q?fBN9lDvghx/uS4t2JKKg7oR1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4890.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df76fc2-c3ad-4c0d-c7f3-08d8cb487ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 09:12:23.2481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqovvrC1DXkNJLVKXFrPcbn5USAB+HOhIKTLQPEKi5rI+opd5CkUH4sfB0Q80aILWh05JBWcsXhs3jJ9lvhvSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Sunday, February 7, 2021 4:52 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: enable gpu recovery for dimgrey_cavefish

As dimgrey_cavefish driver is stable enough, set gpu recovery as default in HW hang for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fbd57482bce5..4a7f6c9bcd0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4209,6 +4209,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 case CHIP_NAVI12:
 case CHIP_SIENNA_CICHLID:
 case CHIP_NAVY_FLOUNDER:
+case CHIP_DIMGREY_CAVEFISH:
 break;
 default:
 goto disabled;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA1CC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 05:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A243A64FDD
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 05:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A243A64FDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6164D6E9BF;
	Wed, 10 Mar 2021 05:17:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552A16E9BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 05:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzWwTp/A2OC4WOu8sT64UfuGiGd+TdnYTOOvg3590VFyBv8+18GSQjJVedDgbXRCXE1JxQTlwxgAOmByP+lpI39TE0JFggVON9K6DBbb8xrQsB/mUzLQq8f9urmDOwfBaUA0JnBXMDiV1iTHyGaS+Pkcp0jv2QKhemQiRG9Z8ZeuwF2VXo39BUy6GbUgT+GLfE2W65agE15MxXpwAGP7JwvGMnT7IsYUmWpfHbgygNsE0DumVNVr0SM7APKPeEUkzJbiF7IbzOGRpYhQtxcQELA46RBk4l84Hgk1UcZY/hNdDBTA1LD9YBxEHNMtTEQWeQgvFSOMn7LfkpztQyTU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoxNXI6aD2suHduRjfMqyRkgsXZ/dTy8DcGfkaSZ0WM=;
 b=QkFd0LoSQW0bE+6g6KBQEi0FY3AVB86jUy+R5VzLAc1Wmsuq7pEdyHJVfz/R9fAihCxJsKg9PcrD6UBGH5mAb5csJ2viKG1Rl85l3FUQE0kSLmsdcBao2tQxozYV7GbjlDfiNkK+CtXIK/FJoWZ0yPERANKJXKi6Kftv6KpQ4TgHd1djD7u1xPYiXPs/ngU0+6z6/IDuhjUT6mi/55oF49yINtiaCCu39a5iFfOX3c9ciBIRPsiXUPOPUO/8yzgMYAoPxfoGNhcVV4ZNnZFOmSz/iK0ybxOZka3BGDh2bFnlfk6IiJWS3u6XC0kVQDKs1UQB7pnXegScZPIidCeVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoxNXI6aD2suHduRjfMqyRkgsXZ/dTy8DcGfkaSZ0WM=;
 b=GRSS26E1Ozise6As8ZuA6yuYHI6OxgFgVcclfaw749BRsn1wC2ILaCtfBw4rMvUi82EqykqlqrJQF32LsuA2+tSeDB31mDWg1+3qwm6s9DHN9JBRECdGlhTOTthrbkysXxHxvHiWYQLO9SDuLYGqLlUlzDnOSCw++QeqiWTKSLE=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Wed, 10 Mar 2021 05:17:49 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 05:17:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: skip query VFCT table for headless ASICs
Thread-Topic: [PATCH 2/2] drm/amdgpu: skip query VFCT table for headless ASICs
Thread-Index: AQHXFWc6ksHCCcReIU6eQqHT1uQFJKp8rlZA
Date: Wed, 10 Mar 2021 05:17:48 +0000
Message-ID: <DM6PR12MB40753B0F1BECA8E0C4725084FC919@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210310043807.2248045-1-Feifei.Xu@amd.com>
 <20210310043807.2248045-2-Feifei.Xu@amd.com>
In-Reply-To: <20210310043807.2248045-2-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T05:17:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=db242478-ae4d-4010-8e3a-ac5c496ad8b1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f5d98d5-93d7-4d11-6bff-08d8e383d8c1
x-ms-traffictypediagnostic: DM6PR12MB4217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42173189F78CF0B629613B36FC919@DM6PR12MB4217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+P8iroiIWQZt962iClDJKCErv+Stn+FFhB0vp7BZH9YkPvYrIXJPkNALUpXcU+sqBM8l5qSLhQQrxoX1RKA77SJM3cFYs+S0AzVtAbSgv1YRl1FsDgKTqnwR5i5q7Og3jiVoIgg/CEe4f9ifk6MMsKyXpzf5QnHV3p2OtLwGYeqpj7HLSXohsA2kWNLbibPqiXwSTTw1gAx8MLfpBWr1pFz268LBn2Bzzp5rFA7nrPvVzyGtJeqqw2oVBTDr5g2O/Hk/D2TyY8WW8m5360Ke0NVdFmfY/iW+YMuFxn6Lz1Pr+opHW3+5zbqF1Cdq5jBjC4uYjLj70DKygyv6rY0y2CptB9UVvL2WqP2lUlxHas9ibQvIiE7flVHiFs931wu4NynJ27n8y91tU/hajAozR/3d7UnJn+6P+9qrqNM5hqMtxiu20V0ImJasZQ5uFrSqBgXjw9Q/oH62EnTdJea8K52WzYs8jhprSuRqwdpsBbtliqAlpKh0/eCN77nxMafeaksQ2y4v5jioGOD0rslVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(4326008)(53546011)(55016002)(186003)(86362001)(6506007)(2906002)(8676002)(9686003)(316002)(110136005)(8936002)(52536014)(66446008)(64756008)(66476007)(66946007)(66556008)(33656002)(83380400001)(76116006)(478600001)(7696005)(26005)(5660300002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?J6v2GbWYQbQt0oEza+idhdpkM1kmivPbRsYchBBWRNPrryFxThHzx20J+Iar?=
 =?us-ascii?Q?5ErvH65zcPfQ1J8UfhSpDhByxc1QmTHMobXsj4clzWgd3aK4HFReJp5MgeDS?=
 =?us-ascii?Q?lz4ksAvful3SRDUYx3gJlLOmTJKe77bO/eHeGHDj89qCOhL7bpLA9iLqGxZq?=
 =?us-ascii?Q?asXVi5+v6iLnQHIS2Dahk5daw6sU0BHX5NVJ8/3SoVN6sRn3/vdMNX5ri7zO?=
 =?us-ascii?Q?eZa0PYxBu55yJvq9GzdeOL8fYrvyLh+lKbHXYrDrx8wn9CSO7eg8BUC/H5xp?=
 =?us-ascii?Q?AmeDuLDIYfAiEKa22bucp9j7zqWcXA1vmJWcRLodkU2KpeMcnADLUu1Qvnz4?=
 =?us-ascii?Q?92vwnaxGDYWhAXYAhjYNP7hqZwjVAWItLxMO4mzFaI9AEvMuvV6mw7eSylUE?=
 =?us-ascii?Q?YuLpRuTSZ5ALmfw42PwkYFCpDMJT+2B/eLFJmcm++jgr/C3oSt3386igotPu?=
 =?us-ascii?Q?wQumS9xww/yBCSbe4Qq0dUdq0NSgK/EW1Ujf9cEs2/lF+M8FNzvjGRILj5pr?=
 =?us-ascii?Q?s156ytoxWDHMAUcvWZR+368KVAC/Nkb0HgTBEeGrNMPB4dbp7ih64hSi8D7+?=
 =?us-ascii?Q?MQhZZq8ge7FW24ODwRsPwRP1m/yj86+som818MEtBoblN4bCTVF63Ig0+Muz?=
 =?us-ascii?Q?z1JHx3QpuF/2nzkTW/Kun1GSgl4vw9/AQuY9ANTno/1TyPlbk9ER8BCH9lnX?=
 =?us-ascii?Q?QaL1S8SZ4lO/LjRs1T11jdWgFLuNgbRhBM38FsXAPDPL6MiAzFoa5A3Jg46B?=
 =?us-ascii?Q?cC9zqvIehBAzc4i9xuAkdZH6UwDUG5NE3BCeELXgbWOY5QUeVnYF+A6Obr0t?=
 =?us-ascii?Q?QDymXyHncISEIsGKkrFC2e4VwgjdfzGD0h4QiuKMorg9kg/sb58Ba9l73eJE?=
 =?us-ascii?Q?jUVNyNNvHwmqFS/pshAvHVAg22yrEfq0UzOnTuvJ6raj0cCoEcQvtedr1ksd?=
 =?us-ascii?Q?PxlTroerkohSgO30a0t17ugyxNOa+/pgm3YPF9x7TwLnrW0Rx6klLwjszGof?=
 =?us-ascii?Q?GJUp48FB4Z4WhVID0dz4Sc3YmsESDjGHLpQiER4fv4vc4JIewyoLxBww1NdM?=
 =?us-ascii?Q?YnrXZWVywP8SQmwVkIjHecaE4YfufwejPyg+1W8J5FdVQ0RbCTBgHeSUQrM4?=
 =?us-ascii?Q?v/CDZ247FWFipV3DIX4HiOpfcIumn1o69TEkAjTpgO7kHfNONui8aqKoUIn0?=
 =?us-ascii?Q?TCgmD596hP1xjXl2k+aI8z4xu4ud9cpPXA2jOEjRB9d2yb81S+RO9yRNlgJK?=
 =?us-ascii?Q?c/8uDmkyygZFJbR/2dAzBNyg4bYrrF00IUK8rslAHxtvWR0ttWK/z3qwTsYC?=
 =?us-ascii?Q?oNzxoso175pubO9h164fvRVT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5d98d5-93d7-4d11-6bff-08d8e383d8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 05:17:48.9023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PC24Mu22CmKzOHoL9/vafCQLmN1qlkh4boPkivZ6w+jtYPLmtNF9dG8G4E3KTvmZaOys9uwfw1UWGwVymWs3Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com> 
Sent: Wednesday, March 10, 2021 12:38
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: skip query VFCT table for headless ASICs

There will be no GOP driver to copy vbios image to VFCT table for headless ASICs. Thus skip VFCT.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f454a6bd0ed6..03739774beca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -427,7 +427,7 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
 		goto success;
 	}
 
-	if (amdgpu_acpi_vfct_bios(adev)) {
+	if (!amdgpu_device_is_headless(adev) && amdgpu_acpi_vfct_bios(adev)) {
 		dev_info(adev->dev, "Fetched VBIOS from VFCT\n");
 		goto success;
 	}
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

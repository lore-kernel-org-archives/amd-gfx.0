Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4476C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 02:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6111722515
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 02:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6111722515
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D806A89A0E;
	Tue,  5 Jan 2021 02:09:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3000C89A0E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 02:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acC//k7E3aMcyoAbqlb3MDE49EIT+1MhORl5OnSdNBO9BTQ1ziPuvscXraUbgnSjqoOPrDjv0AzXm6c5Udli+JaXRulUtfuq2Y9h682HMqXplPn1iIRBET+9FT8Non8SyIcCgffQrB/opgJPEBrDCVKBEz2dYFibVXfW2U02+KPZLuPoDkPJsRHCEM0lCKhkEqimaeZ0kxKb0uW5UkTYNsAsDcS+gT4KAApIzpSJK6cCg4ZJpVusyPGitHDGD4ZYRxTrNlVx7d9PTnSN7+oa/pSV09kg++NHv9+gJU+rZiH6zLzVP1kHngHWqTCT0poUMGd4Uh/FnRpAqijCB/1IBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/kPUeoFL9qo/aDc6PeFBaeiA5hIY2k2WzsYELpGLLY=;
 b=jSCYqIY8CCmo0BytgOof7donIpWhje81ZWBCSfEqnm9XcbURLk+z4cSFfQUhBz9oma99DwMJYOnZiVZX4Q41CbYahrQq8qVmOqCS2BWQkNGjEZghcMWR+sNM0KG6aEajU2LwMD/IidgTXAKX4/1dCapTmw65tlbzk6f/Ap/YPm6brVP2YoPRTBIDIAYUt2Z3+nqsNI8KrTBUKbjM3ASbKLkKvviB3DgKcfho47dM6/pLO3mmekZTPSloX/9XI61NNuWhdJNw7HNbeX6BkJ7defTDQqMZ8lcwOjyw66yNcn9vG682Z72MP7cGFr86EM6yyw0DTLO8gpUFogyY7M7VQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/kPUeoFL9qo/aDc6PeFBaeiA5hIY2k2WzsYELpGLLY=;
 b=aAplRO5HwdenB3OAalq4q55lvZAdh0y6fmEcOhP/XL3Uu0sfJEh8JmV+h80+Re1nwEf08+o7dD+7I4r2Bb7Y5lR3Izt42424i4/nK0FIitkRaFTEnauNxu7Skl8yFI1+HSes93HgliYtgIlhxG6vEaaXX2GJh94MW/9by9JtOUE=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 02:09:25 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 02:09:24 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix issue no bad_pages after umc ue injection
Thread-Topic: [PATCH] drm/amdgpu: Fix issue no bad_pages after umc ue injection
Thread-Index: AQHW4v3G7KJNy6PU8Um+e7UieUmqQKoYSRHw
Date: Tue, 5 Jan 2021 02:09:24 +0000
Message-ID: <CY4PR12MB1287FE7748FF774E25DB5014F1D10@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210105005722.1210-1-Dennis.Li@amd.com>
In-Reply-To: <20210105005722.1210-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-05T02:07:33Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2fe83e7b-a71a-41f9-8a48-000064765962;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2021-01-05T02:09:21Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d1a7b708-eb67-4c3f-91b9-0000caf5206a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10c272a6-2adc-4a28-d8d7-08d8b11eec85
x-ms-traffictypediagnostic: CY4PR12MB1752:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1752F72A50DA6CB87C5D65F0F1D10@CY4PR12MB1752.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlv8rocrCpRyhMl5I+Wyfc8jVf6r7+aREe1y2fHuxqKbZByKSs+cCDrtYUTcbDrnlaZ4MiNnUJ7RTSwG3dJt2NTQKWi+K+gi3KzMfhiA5QZpX/7KNaS3qhgB2ArGdJVj3UVe5r/XjQLfTVYQ5D9oKmRQLOkl+B4EEixEOuD3D0yWdZrmtvXJ8ClPmzprVlxrR+Ym9w1WTk18cKXmF7rVETmB+Mitd41EKvFbB7dd8wnxWWcC25N4KmN4xrxcs4yC8pFNzWFSVTt+8Q5+urlzb5ufpzlo2ozsT6FhNLH76n/YhKJJnp05sYxZQRrIUa+8PzK+6hiLjoIL3m1WPfymevJ62kcpiwyJzVOo1I7QrEZ3QV69d0CR+XY0v9UJgueECV2tWcLVzUgPIbiM/GdPAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(76116006)(2906002)(5660300002)(4326008)(186003)(83380400001)(26005)(33656002)(86362001)(7696005)(71200400001)(110136005)(478600001)(66556008)(66476007)(6506007)(64756008)(52536014)(66946007)(66446008)(55016002)(53546011)(316002)(6636002)(9686003)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Mi5kKUChAGJou6vY0jpeMMv3LQYRQbr/ZnANCfKhUvBTlCCcpbLPtNvSGEgw?=
 =?us-ascii?Q?t+qQzI6FeLhraYW9UGSCCdAuFbHQNfHET8zGOu6DOE6KyXpbsDGQhrxpjG5c?=
 =?us-ascii?Q?mED0yotfG1xI6p92SwnVzl71JXk6sIDo1hnJqG1BXEh2XTsoh4TB/D8ooLsp?=
 =?us-ascii?Q?cZGkGRJ0HgpAjImshtONFTNRwUKHCGktqCyz8prhmf2R8ja+jUGIPLW8BwD/?=
 =?us-ascii?Q?fiYRo9l/fAS3PUYnDUEXl/kxspYbo+HyR+BFb7f6rH/KxYG9d2aqXmT69gLA?=
 =?us-ascii?Q?mK+947ZIRH1emN5ZZ/2RcRilpLxZ3Qnv2Dl0E1t892tpzPsQH4EyAw3lrkxc?=
 =?us-ascii?Q?LVKPZ4Tx9BoLRiaor5RLtP3Srqx22cqbjyUXAnjJkw+ECVqv6n9M7KVojsT4?=
 =?us-ascii?Q?4Ay7dF/njp+P/hTlbrJNDVo5yrOZfKAzxFR3DfV1NR94+U5MxYAu0+m1MhLl?=
 =?us-ascii?Q?9/UccCgToFmGV/soe6WJ+dxwYiDTWexkNHJ/ccOOqIyuJQpUCOZY8fbCGq1F?=
 =?us-ascii?Q?6bqLGp1paZro0HAJRHjSYRz3yTm1kfqjdMXOV7K8ycF68Z9lQ6d0fmoBa3Lg?=
 =?us-ascii?Q?sQeorp8g/vx4dz3/q9n+n/DNjz9siBJSmmk6Ht39WqbRLXAkBtwXtTsq7xrG?=
 =?us-ascii?Q?3QDFSTX0obD6jJ3uE5kDf+y6yKt25VfK9v1/49FwIiPOwiuOvxcHPrU//v78?=
 =?us-ascii?Q?LsFHFju/pp3mm/M9ceWi93j5YcBJC5bOHSFojdSohVNjeHZlLWUSoFH14VKv?=
 =?us-ascii?Q?rQts1YMGd1XrRG5FeTA6e8zHRBg+4U57Ce/05pJvBUrWb/23htmVaSTNBUDj?=
 =?us-ascii?Q?5Mc4d8ulYeGRsBzB7q1p3Il40CsGloY/ol2kRhydKfazQp1JqGeXwT7zjc9E?=
 =?us-ascii?Q?iyuDREtQTHKvz4HwRJOgnfjkg09laQ8A8GalZbzsUzzF5FtZRyWsyVW5oqHr?=
 =?us-ascii?Q?YA7Sz+OFivvaXLVoVqfPV4xRga54nSKKdDRvY80uib6H9+SbObL4jtiWoBwT?=
 =?us-ascii?Q?1V6n?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c272a6-2adc-4a28-d8d7-08d8b11eec85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 02:09:24.7155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZdttUmOsMRna1kV48zMkdhXY2xJiXxxmTg8AhCFENCkx5EdrWu/VbuDh0q9z1+wbUlShjsjh4sElubrgKrpPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Modifying subject to "fix no bad page issue after umc ue injection" is better.

With above fixed, the patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Tuesday, January 5, 2021 8:57 AM
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Fix issue no bad_pages after umc ue injection

old code wrongly used the bad page status as the function return value, which cause amdgpu_ras_badpages_read always return failed.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..82e952696d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1518,7 +1518,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
 	int i = 0;
-	int ret = 0;
+	int ret = 0, status;
 
 	if (!con || !con->eh_data || !bps || !count)
 		return -EINVAL;
@@ -1543,12 +1543,12 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			.size = AMDGPU_GPU_PAGE_SIZE,
 			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 		};
-		ret = amdgpu_vram_mgr_query_page_status(
+		status = amdgpu_vram_mgr_query_page_status(
 				ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
 				data->bps[i].retired_page);
-		if (ret == -EBUSY)
+		if (status == -EBUSY)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
-		else if (ret == -ENOENT)
+		else if (status == -ENOENT)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_FAULT;
 	}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

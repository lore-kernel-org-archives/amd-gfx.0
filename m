Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9F1C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 04:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B9964EF8
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 04:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B9964EF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E556E48B;
	Thu,  4 Mar 2021 04:55:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760055.outbound.protection.outlook.com [40.107.76.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA5D6E48B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 04:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lzx4i8r8huvAt+6HSDNwezTQ97zKq1JUviALQrEhobLKdqKE5q8nnG/s5AaUQ2a6PbzqSfq/JIHakgr9YSd9ctQ5M0emTmg458IsfNJiTRrtU+b09FomHtUup6A2xHGvl3MZPavozJvpyTmzx8yOlQn6RdbfUTstWJUVpHzqxRhneSLu+qkMj/6iLM33q60skvUOztnDwLa03LJGj6CyRvfWs8lOAQHDlj9woN9DqLrlQR/tF61B+2Mz2QmX0oYwV/HfS2LfkVcpu+FJP8LuhB/Na6jCq9L7s1tTjc2Eqhvs7D2J/M89Bbb/Z+yPyamIxXf/RSc4gIwQcczrrZddtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UMGIoOczsUT78xvJgNVfw02M3jkvDW3ZPsfBrXu3iE=;
 b=PmuMb+kbnreS38H9EeOuIeGYPQM62qD+DHNTPNB4KqHK67t/zxU20jc5sI4aryTyvjXuNXGtiOBinPjJMbR/B/PaAuPtrAYJ21FeZXf3iLRRE2Fiid8u1G0mdIvl/P1y7Z8VhXCxMkihQxykHqCoH6onQgeY7rgcgV8R8jqnVqHLEMh2vUGnIRgZC463uR3UnjXM49eHOdI8cbmsyt5WSYMX+r3/aWZftOCseZVt2y6jkeZQPHu24Vx2p4K2kQQVai/oVaozjIvGYcS6vnCdDFtrMI66QjJ6u/WQ/B0s/V+QWn/+hzj4aDC5tlFD2KSKhXsdZ6StV7QHAg9U2IpO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UMGIoOczsUT78xvJgNVfw02M3jkvDW3ZPsfBrXu3iE=;
 b=UAAdKmbbRtLYXEElrJnbSzhc1qgBD8b0ro46tC7heKLNA0f+fzXgZH0x0tikcwAD/9h+7TJQ+iaFC3m5bhMqQD7BFO8+pxKpdI1q6WkTKgMqXYHXgrvAuI8byTZJMkDR1ZAv9STVIzyKKJ0dFrB4BFFh2RndU+aQmfFFBVc5ZIw=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 04:55:15 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 04:55:15 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "alexdeucher@gmail.com"
 <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Topic: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Index: AQHXELJzYwZbbv1lFk+3Q7lNHI0x/6pzQ48Q
Date: Thu, 4 Mar 2021 04:55:15 +0000
Message-ID: <DM6PR12MB4603750721C24810B5735DC6FE979@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210304045413.38603-1-Feifei.Xu@amd.com>
In-Reply-To: <20210304045413.38603-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d15cbdbb-293c-42a3-8cf2-3dcf32e23f3e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-04T04:54:37Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae5a6afe-c82e-464e-32e5-08d8dec9b361
x-ms-traffictypediagnostic: DM6PR12MB4217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4217A885E179A1E9F151DF5AFE979@DM6PR12MB4217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBF5ed2P9oVqJwjaCbSHqvwdOMIzauvLsEmBR+75B1e3p+9wVehYLBXBllEtYHLtULFPMx4D/Oc5gqTk96VXRnJhHXmXeD5qj7TNETMN+gW/pL+0cZ3WHuieNJCz4+7fBm1VbmxH2AeLYKMP85xYAmKNPUmGabAJlGyg4FCn7DlHXynTmLZtpPYoxeRryWK/PMoMrhpk1NVirL7G94DeWK8i4l84tDlXBLsevMafuLYwaLREJI8dqq6UWkANiQl6VOZjpdluGREPotIGJmeaNbHgtKt76p4BTn9hgTh5cLdHuaIi4pyFlmKJFwt5Ly4zgEfj81jIzCuCr0DpP94epkuQVwNFwlIkO+88jFleHq7qHxu16lj6H3FSpY+K7h5vfNMqOOvRJDGZGPx4fuJ9EbSEZsqtvxjhrwyjBW0poJTg4edYVcWx2Anh1ikJChI6a1uL9jPAFWoAlbisLJfwvDVKsqpuFtIX9Uzd3OoZRWtc7iQliomLpARc98McpPSdDdl6OaZTO7xwVsm1ej3wsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(316002)(52536014)(66556008)(66946007)(64756008)(66446008)(66476007)(110136005)(5660300002)(76116006)(478600001)(4326008)(71200400001)(8936002)(83380400001)(2906002)(186003)(8676002)(9686003)(55016002)(26005)(86362001)(53546011)(6506007)(33656002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VCOO5K2ah2WqELd3sCAtvE98Hkr0sqsjLby7RLixhmgaHeynE6qw4mEKkCMM?=
 =?us-ascii?Q?ScgyDy0DYZHdjwkJqlQVVJnB2lVeEJxa72DgHvRyEFKGVKHMF4R2jOTDmsUh?=
 =?us-ascii?Q?e9oM23ls48IVOnubriGze4KAFt2C/dCh4Z0Tim4BkbY4nVORleMYLrQ7oCNj?=
 =?us-ascii?Q?EU0XaoKtFgKa2cWg0qpQ7acXugMSbGpGKkTzRpS/q/tzeAzG8C4KIvpXnBc3?=
 =?us-ascii?Q?zX7w0ZgVVkP9R3WRKSv22hvRfFpKSZZ4ujH9LrwVK2XPUDHoHY1xk1a1kiCS?=
 =?us-ascii?Q?k2OmHzrOPYPJspIXOxWOJX6b0/AW5a4UaLge6diC2n/MV6mFBnHDBuN5g00O?=
 =?us-ascii?Q?HHY9NMgOKM58M5ga6Xdp8J4aBbi+eLrbwsMcaWbx+l7Q347FSBep4ULWUmv8?=
 =?us-ascii?Q?pgPr2oB19IWzFpT6E7caOc4GDEmn4jBR9C7uXxRzQUC6s7yUjrRvCwuErZoi?=
 =?us-ascii?Q?j3B9OA+cAY3MXAgU9K+OD60Pz1+SPMHYFFhkdo5nlBcF9gChRKNNq/2l14Xf?=
 =?us-ascii?Q?OP9jLzMYvqB/2rKyFoNXyARPlRVIg1Ph8aLUE4zWi6FEVUOE/v5FvwoCI8qs?=
 =?us-ascii?Q?5SbibHhzvLDafcU5ayl5/rn0W0qy05b2uytV3FzhGYLhVvs7QwPSZJ1S4htJ?=
 =?us-ascii?Q?Sqe+uHHpqJb/0OdK3npxtg0byGw0VVzx9SOOvpmnZsDEIdxOxa0U3qK29Noy?=
 =?us-ascii?Q?xEurAbL/hnWW8PrgeXHzfTB4ejtqss6rmYHCtd3dUpE3WYht+fdMja3+sVPq?=
 =?us-ascii?Q?z04rQ1qV050U/MBxGQW0iT+emniGNeudsU887Y1mOEWvo45XpXHjjjS4rXk7?=
 =?us-ascii?Q?qXBYTKQfMiF2kcqJ/etUTo7r7E7Y1HY2OPPnoIy1pgNEoDMrfrEZhKXUG6ZE?=
 =?us-ascii?Q?YGRQcPjCw09EmawG8cU58y3vdb5S3FdxXz+18dXoAQKGcCeOGZt9CMfwmsXX?=
 =?us-ascii?Q?oSDh1NhOsRpBSH20AwYc7GGMkXcgQe5Nft9pd//nroRaIaqCXrVjhaqtb5qN?=
 =?us-ascii?Q?IGUKavt3qzpHH738yb3XlSSzjVZxMCP0dJuyCXW8szs2nty+AfH1q1PGvoQx?=
 =?us-ascii?Q?HJGFOKkXR6uPqrQFq1vsGM40J2gFePzVKbYCp6kivEen+dS8zJUCJOKcfhc1?=
 =?us-ascii?Q?Yu3ZuzKWbt0huIcSQVPKB/n6gJ+ucFSt68C+btHd5eiLJ7mCm3U5/uiXDHLi?=
 =?us-ascii?Q?rDRwVbh6npP6gBCJhrJWMPKvYe7yWu/gmIRpeBH5JbQdeKTfFD0Kyh6TVwyv?=
 =?us-ascii?Q?jeXjLsYxCrbJ1thPTs8prVDV3M9LaiDS78SR6KIuahVXRH2z2QXngGFtPXul?=
 =?us-ascii?Q?buDxc6xS4bEafpuBu6FHdVjX?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5a6afe-c82e-464e-32e5-08d8dec9b361
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 04:55:15.1190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvJ0vOI4+MJpxMvOMX1oOJIa3Xug7lSR6H6YjZJ0kIDSKc3B7Cms7+ptxNQm8zHl
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Modified the coding style error. And resend. Thanks.

Thanks,
Feifei

-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com>
Sent: Thursday, March 4, 2021 12:54 PM
To: amd-gfx@lists.freedesktop.org; alexdeucher@gmail.com
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.

SDMA 4_x asics share the same MGCG/MGLS setting.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3bede8a70d7e..0280e8f589d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2271,21 +2271,11 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
 if (amdgpu_sriov_vf(adev))
 return 0;

-switch (adev->asic_type) {
-case CHIP_VEGA10:
-case CHIP_VEGA12:
-case CHIP_VEGA20:
-case CHIP_RAVEN:
-case CHIP_ARCTURUS:
-case CHIP_RENOIR:
-case CHIP_ALDEBARAN:
+if (adev->asic_type >= CHIP_VEGA10) {
 sdma_v4_0_update_medium_grain_clock_gating(adev,
 state == AMD_CG_STATE_GATE);
 sdma_v4_0_update_medium_grain_light_sleep(adev,
 state == AMD_CG_STATE_GATE);
-break;
-default:
-break;
 }
 return 0;
 }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

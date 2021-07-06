Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5690C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 04:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFA36198A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 04:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFA36198A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C57B98976D;
	Tue,  6 Jul 2021 04:04:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 607CC8976D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 04:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb6j97tnQAQcsxwNO4uxkKkE2zGUzlcb0G/qStfi4MZvRVWsU9vk5ia1N7n1iZb3ikMEowY/Qs2ZaVfx6FqMFs5+HPvd3Bts4jBw0ugta8bEZeCrRRbhEzVkc49/DFKvZTlBQeS5Jb+rLUzTCV2GrWOnWy9saicVDTd3ad3TJpH88vuJppykWaxStp/kLI34KqoYQhJZqjpzUWrCYEhJqdNaF6b2MqlB8vGhblu9ogHM29ZGPKzV4tBq8U2FTx9a1b+LJh51LTJS7DjdE8Tux9Fpp0/6rzZJahaKGhwbQVEnN+Lc3A3AbLuN2eayGYYTWFGWWkD8iMskFnWB+FJ1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW+ktI1sN+HjDVL4mx+wasrV7aBjU6n1krFN7xKV+xU=;
 b=K1GpZAWQPIhjW/30lel/iirZhuu9SMLwopkdLlIFK2ibvl9JSKT6QQRWuTFvQfP9r9Hyb4aC8WIk+NvZq639CjM9H4e84rkygXWm4+RD9XGS/zNkcEMk71ny0zhay7PLDCjmcKmA8zDcckcrdl9EmJizA+pc0mDa8w5bDqgL5DQzwLpvEZIhXJLJa6OadCJA580ICFfLGvEMkHiE4H/4hJSUlnK1HHjVYsf8sPvtFSVj20UpoQAbbVF9AmVNkFZDxQtQkaGPa9U40mGHjqLI8fSF+cVn/EgWMU6fjYbDGwFDRRb4FeUTuBmXEBtD2HUoUQvZdHabBUzu5vks3FRLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW+ktI1sN+HjDVL4mx+wasrV7aBjU6n1krFN7xKV+xU=;
 b=u/qwuidGmhV5pd1/Zl/c1OFo8CBtoDgzX8Q0vSaQ4ktV/dKlAvSstf5KrE2/DyObjoDWoWpHOygIiw39IZXAb0jaFafWCbwFEB20RHG1LOUtkEBPSQCXzZd+AjsiLVzbl/DYOUwwd9R0bp9GYGJIz9tT183OXtkXoGWOCELil/4=
Received: from BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 by BY5PR12MB5511.namprd12.prod.outlook.com (2603:10b6:a03:1d8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Tue, 6 Jul
 2021 04:04:00 +0000
Received: from BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::b123:6491:dff1:e2b9]) by BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::b123:6491:dff1:e2b9%9]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 04:03:59 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] SWDEV-291099 - Use a percise function name
Thread-Topic: [PATCH] SWDEV-291099 - Use a percise function name
Thread-Index: AQHXcYfn8viLWLnAO0GcwgnZImQvOas1Ueog
Date: Tue, 6 Jul 2021 04:03:59 +0000
Message-ID: <BY5PR12MB55576636F260F5C2286924F1EA1B9@BY5PR12MB5557.namprd12.prod.outlook.com>
References: <20210705102400.5406-1-Roy.Sun@amd.com>
In-Reply-To: <20210705102400.5406-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=cf52d59b-bafe-4864-8989-bbf59152f5c7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-06T03:53:32Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e34b9103-9a2c-4be0-91ed-08d94033159a
x-ms-traffictypediagnostic: BY5PR12MB5511:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5511AFB040855DD76B6DA059EA1B9@BY5PR12MB5511.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NKilVWnRtgeiWGspfvBTfvHloeoY4UXY3obFXK09GqE38uj0MN8wZ15jOKDv+3CQterizd/FmMMSLesmoS76VOpszxE4wsDDDLRvfNS/KwI4QA3w8EQYpqBVCib5mL+1rWMexZpNytjDjIEc17bh/mGpi68nXrW0trSRsM92oyKgpa0Q0Yr5iTcPj4YwhaW0OMf7/ILDNwPDrAfo7HfAr3B9PR8P2wFKf1K6ZQxkBe+lwG9ZwstYyjOBtw+BgzQXRWA9UA+qXUtliJyxPEBxTLnqulTi//ri4bwb4Hs1fam/5SYNkx8A6OyPrAeKe/UlZ/HmeORX0KAYhzjzXBZqdmXTtDp4v8PhSkid8cVtKjsB+ODXOr+cHvQsgcLm22geaMZqHeFfunjpHyXLG9IXT+uHajiGGzldZu2f1zA7bn1j2jR+USoaF4nUrZXTaoAizfxZQXwMcsMXGNa/xy83W7PYsFGpVLfuTT2lCJ6Xqe5SlnfBaMwMObYzRU6FCmREJpOoQKYkQoRgugYrgGLlh2e/t8PuLkVjxhXV/GyxUwBSPSaX3SlHfJKrje76P8WPr4e0aTPXkyNu3i+/Fk9HRv7c8dfVho//IZwXuy1ddm2Iy4WJyANNKJRfg1WWbpgw/1+QRbI+Zqz2X4Qc+VnPjw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(110136005)(9686003)(7696005)(55016002)(66556008)(8936002)(5660300002)(4326008)(66476007)(26005)(33656002)(64756008)(8676002)(66946007)(186003)(38100700002)(966005)(52536014)(2906002)(478600001)(83380400001)(76116006)(122000001)(53546011)(45080400002)(66446008)(71200400001)(6506007)(86362001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z4ds5nuE3zWXuYPEMzKvBq1NJYir/r0masJUHQ3tZwe9J8ZoAPGR5o9sDd3f?=
 =?us-ascii?Q?ChSVocRVN6imtgsHCS1QP2LU49pOfc9nWIJui3xvqXehLYiKHIjPCl611vwL?=
 =?us-ascii?Q?8MPU9LNPxk0rtMJ4tLrMvqMcc3t6UKi0wLXEg7G7U8UQ7wfkJdcgCpeqy8uk?=
 =?us-ascii?Q?xAYLBBkraMKXn04w7Nc/hCWR/laPD40vcaKApIY/13ReBwRxH9ki31zhIJd3?=
 =?us-ascii?Q?uZf5kyHYccbDZzzXD61g02ju+olsagV/86zxQUbAaiPjytx9P16BgtUh8jJq?=
 =?us-ascii?Q?3VApi5wqocsQuwcRHc0NIGWG0a6EYaRi6qQI0Xc0HC5PYMeTHgJEMaJJA7IE?=
 =?us-ascii?Q?pB+TSjnZ9RF0rdnI9DmzpKjF+HC35l0+hgu9qVf0AlELLFoAAaKIHEajaQtc?=
 =?us-ascii?Q?5KzrR3hHWR7H266b8reqNTfkMMt/JO1W5I+ZrNjFXAs3azmZcM9rnjFBUnLp?=
 =?us-ascii?Q?bmaltZmEhkwioXUdo4AE4z66etyeUGtzDQCPpJTtfph0OtyQxDcThsCnGdH1?=
 =?us-ascii?Q?uFHxLUBvbBSJu5bch9/dPxMDpBHq2SZsa5ZcFwNiqc/mu920QAuITL2EQI4b?=
 =?us-ascii?Q?GgVfpBsa4tpyJyW7LC0r+I9mQ9kckQJLvc3Ihq4t8/R85rN4+Hvk1CPy/KA7?=
 =?us-ascii?Q?T6vKgw8cfIb4A4h353Rmz6uArCbj9MEs+k7A2BQu/dLYMPWymgb0SnIbwcun?=
 =?us-ascii?Q?jNi7zkgBdsnPGJ4F2wx9v6hHCIPM6hE/KM8WBeG8849CrVAXwVdAt6d9Q8ev?=
 =?us-ascii?Q?yxW9FumlgfynrhyebHxuyEkCZ9CeezMfXB8EaH0Uz/cTMOzdljtwgibhoo8q?=
 =?us-ascii?Q?0f+T9hFEQNxUkKD3NiPAq0z52k/2pC5JaL9TKKL/h5aF3iC2vNDktUgJAyxq?=
 =?us-ascii?Q?swzymr7O/AdmdZkPdpSH/6+d+I+QzFFynFYwFXUVdb3tZoTRJ8lcN3PkQb2K?=
 =?us-ascii?Q?CC/T+UgbI3yfg3Z2Hn+Ep5xW0gHNObYVOB54pqsmWMf982MD1xtwk4drhPd0?=
 =?us-ascii?Q?zplgv4n4xpSyALK4mBIIEqzSnsf3cJFWzSs5zYtfI8+gwb6lKXQaDIR3pE6V?=
 =?us-ascii?Q?54UmCYyg0ySWVQgMft3eRE26Dv0XiKlOKxFH15nrM4HYcVcrtqvj/Aq2wJaO?=
 =?us-ascii?Q?mSFStqsjRtsvkAXXUEA4VGQAtMe4vkP0/QY0fGGNNJHP92riEr4mcA+TS431?=
 =?us-ascii?Q?+AxelHlRQbAmHGR0rIWCd4MzqbFPR/DvePX2lIr4npg/x7ClM1UHbKAvQT95?=
 =?us-ascii?Q?NEYGZ9XaVAVUfG9IuS9Oxvgh4B4kCCdYjwWtH9bHem91UiOaHhCloCllZoGi?=
 =?us-ascii?Q?km0H8Q3qa+rd5EtwS6wXcL8o?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34b9103-9a2c-4be0-91ed-08d94033159a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 04:03:59.8332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUae8zcIOKcuRuj0UFDh/2WR6Iej6kHNe90/I3InTybwEpv1PQkjKs1/qOGPBHyBW+qv8aqPgIiQ6W4k8UeJtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5511
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
Cc: "Sun, Roy" <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Internal ticket number is not appropriate to appear in upstream patch, and percise->precise in the subject?

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Roy Sun
Sent: Monday, July 5, 2021 6:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sun, Roy <Roy.Sun@amd.com>
Subject: [PATCH] SWDEV-291099 - Use a percise function name

The callback functions are used for SRIOV read/write instead of just for rlcg read/write

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eb1f3f42e00b..aa94ad0e9973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -508,7 +508,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
            adev->gfx.rlc.funcs &&
            adev->gfx.rlc.funcs->is_rlcg_access_range) {
                if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-                       return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0, 0);
+                       return adev->gfx.rlc.funcs->sriov_wreg(adev, reg, v, 0, 0);
        } else {
                writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 7a4775ab6804..00afd0dcae86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,8 +127,8 @@ struct amdgpu_rlc_funcs {
        void (*reset)(struct amdgpu_device *adev);
        void (*start)(struct amdgpu_device *adev);
        void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
-       void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
-       u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip);
+       void (*sriov_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
+       u32 (*sriov_rreg)(struct amdgpu_device *adev, u32 offset, u32
+acc_flags, u32 hwip);
        bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);  };

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 705fa3027199..c9b68a8611d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8269,8 +8269,8 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
        .reset = gfx_v10_0_rlc_reset,
        .start = gfx_v10_0_rlc_start,
        .update_spm_vmid = gfx_v10_0_update_spm_vmid,
-       .rlcg_wreg = gfx_v10_rlcg_wreg,
-       .rlcg_rreg = gfx_v10_rlcg_rreg,
+       .sriov_wreg = gfx_v10_rlcg_wreg,
+       .sriov_rreg = gfx_v10_rlcg_rreg,
        .is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,  };

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 044076ec1d03..1c9b8b37fd3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5131,7 +5131,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
        .reset = gfx_v9_0_rlc_reset,
        .start = gfx_v9_0_rlc_start,
        .update_spm_vmid = gfx_v9_0_update_spm_vmid,
-       .rlcg_wreg = gfx_v9_0_rlcg_wreg,
+       .sriov_wreg = gfx_v9_0_rlcg_wreg,
        .is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,  };

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 0eeb5e073be8..8a9ca87d8663 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -28,13 +28,13 @@
 #define SOC15_REG_OFFSET(ip, inst, reg)        (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)

 #define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
-       ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->rlcg_wreg) ? \
-        adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
+       ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->sriov_wreg) ? \
+        adev->gfx.rlc.funcs->sriov_wreg(adev, reg, value, flag, hwip) : \
         WREG32(reg, value))

 #define __RREG32_SOC15_RLC__(reg, flag, hwip) \
-       ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->rlcg_rreg) ? \
-        adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
+       ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->sriov_rreg) ? \
+        adev->gfx.rlc.funcs->sriov_rreg(adev, reg, flag, hwip) : \
         RREG32(reg))

 #define WREG32_FIELD15(ip, idx, reg, field, val)       \
--
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7Ca650fc09bcc248267ef708d93f9f07e9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637610774548095481%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=uzS4qz4rogYQ0oh8lKp0wL4LKFJExTHFHuWskNQ07sM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE58CA0EDC
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 02:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7986210E33D;
	Mon, 18 Aug 2025 02:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDHYouDh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35FC10E33D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 02:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpEiDzkSjp1F5N2/hZudfcCNDbdbLxz9GzSKE2upJ2xfky4Zg3pyW7uzGJ4v81gVlsC0cOyqaUBVBOvoEKwj7tlZv/EwS6PqRBjDjU2ePiaGHAKrRtzdBjdjq6tsoOgr4FSz9gT+dkAOqJ0lwBkCRYWliuYKjssp7q0nu2QwWl2IIv2oJWIxDIfZWzHrRs64sfyznn1+nqAYUERdYv+JOFq0ZU4JP+2J+RiI1PZfNstqBJc5/1es76SLShMJkuQyL6M7KTXZFI5xyNCH9Kz55KigR0hkJywpucKDr55ubffnDCFf2Yn+j4fvXtkzUOo498mkCeosgEPPHZtE+b/ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrOrepia3KBrlL+wgugTt9VE0cyDshD8naYcEhXT6og=;
 b=jSiBVc8MeRIIcsGFvsccIMHaUZvbfjIHUdJ2gbRmEDQ500cX7cJ9aT/wVW9tfKnu2/4bquk1ugNv+YXZUq5wWjb9ZTqOF7BFj3uZHEqfTuw07MpBimEdLIT7kfXvxayopQxIuC9/UWVFk41VssGMmN7lFD7BecW0ICe/AAlu+mjc+Dqdvjd93vux450ZCKgvUddIpQDmL0BXaZvwZClgGY5vVODXYKKO+Ozf+wvMIPHGq/tHtvcHHVEk1SiBErMEGnJc5d02Xv6LAYk4eoLQsOIv8Wj1oua83zwzjYhVZluRr6F5lVhFixjQQxvEw7ZEeM56KoRHeLJr4IJQfCf73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrOrepia3KBrlL+wgugTt9VE0cyDshD8naYcEhXT6og=;
 b=UDHYouDhJHk2tEeqCqDSn92c6seCwdj6nDZElgsrzrGHllCB9fjCEOglEN3deLvu1e6C0Efw4rP/yoh3ubEy/jbqGGYY1vx6qs7IH8k0E7ejIT4txXgAedtaoMQV//NfkW75w9bmTBE6Ii5kN6h0vCWvElupd0Lc9NMVCihTDwg=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY1PR12MB9676.namprd12.prod.outlook.com (2603:10b6:930:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 02:02:36 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 02:02:36 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add vf critical region check for poison
 injection
Thread-Topic: [PATCH] drm/amdgpu: Add vf critical region check for poison
 injection
Thread-Index: AQHcDdY7lciVo4MypUGhFpoko/+OZLRnqprQ
Date: Mon, 18 Aug 2025 02:02:35 +0000
Message-ID: <CH2PR12MB42159E06358B5D1FF76526D3FC31A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20250815111711.114228-1-xiang.liu@amd.com>
In-Reply-To: <20250815111711.114228-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-18T01:55:14.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CY1PR12MB9676:EE_
x-ms-office365-filtering-correlation-id: cade473f-0cd9-47bc-b2e4-08ddddfb4d50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1C8PcZOoK7mEvGmVu+eJJrUnfi25rka58ZdMb+jxI/oFzpgLs3DRvISXU4mR?=
 =?us-ascii?Q?FwLROKCMTZxfM18YLsAYgHzxDUdHcl272J9tWHW/DAOqTwluyoJH8pTfa+Kc?=
 =?us-ascii?Q?NJU97X/UP0BR7z148KeonNtdcDvMbxqsyG4FgqVcgx7sUbUcFfG1/qyCa/ma?=
 =?us-ascii?Q?af/NiZdg1sLCw2QJfcGVOkP6QojLxMqOm4pCU1ejW8Z8ahlMA7rulbz0fh6s?=
 =?us-ascii?Q?P2x0E8/KAtNMC3eH6vpCvBo1TF5Aw3ldUZ76ZRjGZDYn56QmeFbgVbshsjUw?=
 =?us-ascii?Q?iQQlMuTK+hl0T2NIS55DjuaBF+ReYbcZYz9Ch4zqCjeS/4KqW0VYcN6JGLSP?=
 =?us-ascii?Q?jxZ7zKh8ahOASm4qQGpu3XfvgTou6nyrIAosNJr121zc4fSP9w0WH2Bgoiuc?=
 =?us-ascii?Q?rBzKIQej9bbH1qOSJbAFUAPHTM1SGvUgUuZB6jpSTukW2u0BEvBubv+6ru8C?=
 =?us-ascii?Q?uyZoT0VsBHEh5RTrmsw4LglY+SJIBCfPUdEmWzQNSMq6KJ9sjGDaBu5BI6pr?=
 =?us-ascii?Q?gDJc8gaA5aRLAeSZqdUIMjE91CnY5sNtZiQkOrzETOSHegAgEyavm2XcQYdx?=
 =?us-ascii?Q?JEmeBOY7Hz9GTtPSrVcKFkhVGNXtTwMzqQ1bD8VulyoSfhr0gmGNBSSh2CNf?=
 =?us-ascii?Q?wWWuuKhAIWdDPNB0Rzofdrg2czAFfCAANOV6WEfNmItmK2VNdmYaBrtBcYhD?=
 =?us-ascii?Q?lvtoYr5wcOYYziAkI/5vdXbFmwyUfhy4JkBs3sq22WOt30rZ4EiDXKPR/Cxd?=
 =?us-ascii?Q?Qdvp5SfHiNZZKq2c9Sh7WGlhXhDW0zi7duR8Wxt1XWKyq8VkNWUCUx4I2DxM?=
 =?us-ascii?Q?RPwh/JX3bbsGkqDpix9DmsDYX4emaK19n63wJFAi83Dwpfb5krG1g6RxD9Jf?=
 =?us-ascii?Q?TM5SJVImpcTbmGUzeJd56neKxC8MuCd8lVLBAg+iHEV+0mZCv6Nj1rD3KOWK?=
 =?us-ascii?Q?whFgwPIT2jjcRfDyoGHGAOIy+Vn/TpvXKpmvdzubPdsfvaFzD4OpEASGKPef?=
 =?us-ascii?Q?xnSuR8eTzQPaUu+W6IkyXAz/4ggyvXJNlxUaVO0+4L/eP27xGo+3tkYozLvE?=
 =?us-ascii?Q?LzPR/MmfDQ+TO6Io3AOOnZMKyCZNSUVD8nGAA5M64LxjUurK5ypRrB7nqR35?=
 =?us-ascii?Q?BUcg5PE+gk7sCIW1lp7dZNb++Uw5WiNizRMT8XHEGlY0kTEWM9Co1U4i4aIX?=
 =?us-ascii?Q?jPhwPv1Ov+4Ql4E5yNXUOJ87GQ50kRvvR6XchFW9r1hUTpoey8cEsXZobm/+?=
 =?us-ascii?Q?3LDMDCJPx+/imf1WfkjQ+WRtRkZvjGSoecscKKLK2I40Lo2Q6FjVCzYVTPDs?=
 =?us-ascii?Q?6yfXhomBkkr1DdFBaUI8bOiljZ6MO+8wj8nR/m/p0H08zGrtIgEaeZH350NK?=
 =?us-ascii?Q?i/dHaK4S97O/sRH2KkJdxPYtjh4EaqzzMgldJGXT+M07DqSWLlIWfsHAc+qn?=
 =?us-ascii?Q?8Dkw5cSfIZVo3mTkvDWZ8T9QnT9Q5Utv4EaRgwOV1wzMAbL2VLBQuObTMKM8?=
 =?us-ascii?Q?x19P/LPYmQptPvE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5kuiP5O1OFkFX+jCUzJIOfs762iMxg9UUsPcDWSYlP47GSaj0E8sf0VaP6Mo?=
 =?us-ascii?Q?b4qJ7EwTKav3/eBJDjK9atPwYyZxKCTRU+69riI7MRKlLzZpsM0qVkByFEYP?=
 =?us-ascii?Q?YQHYCd+ZlmUtJGbGcSFmE7ea6evAlGfdBgHGHon8xMF3XcY+VG1OLvj+PuG3?=
 =?us-ascii?Q?ArREFJGw0NwckzUmkzqMuP8nxfcW2esOH5g1HCtLUwHWMSjIIhjp7E2KvbKS?=
 =?us-ascii?Q?m9l18VcEte+sMpClJcHhMMd1tuU6xZeqNlZwSQ48KkjU9ZFJKZ6eeWBMU6uU?=
 =?us-ascii?Q?Fuk7o02w40I9jKO5vmB638RWw/nAqaRN7EA4TPN741brCqkrnbfHtmTSrFYn?=
 =?us-ascii?Q?ThUX+EDs43qzh0uTZaJoKkLWYuGboBSKcotdWIfGpIXcnyj6ixNZabvC9it5?=
 =?us-ascii?Q?yIJGm8UOSMA5QJiSVpdE+4N16XrCQaXirquNGOpJRdlONyoEyq3qyk8GaLrz?=
 =?us-ascii?Q?nEhF53i5G9cQvqe62Q2rtX4xHG5GZbe4MpjGXHE4QkjNTDpzEGqwtNKKX22K?=
 =?us-ascii?Q?2PrrIjRvIAjrQ+8dSll0byDGzEAkeqRB1x72cBDIunfyFrISWBZ7fq8M46JA?=
 =?us-ascii?Q?RZfqR+VOP8s1s542M6dShjOWh8Q4+sIRFnOmork6+m7omvpNh9agsiUt/nta?=
 =?us-ascii?Q?ov2VPxGeGlfj22VHS0KkRH1hbiuYLV52NOeBfJsm2eMZATdgC8jEw7ti7g6i?=
 =?us-ascii?Q?BTJQ8uHCU1Qe5IKpGgpm0eDarMEOMqZQhnkNRSTDtrqVPRl4IJLH1YshAdwS?=
 =?us-ascii?Q?1W+tX1ylquve0yTJ6iyEFNKbPlIbxEMH/xRHU5oekrJrJYwMc/qVl0euM1uo?=
 =?us-ascii?Q?F4xWEF+xkEUZrt1Ss3tU1DtrzBtk9u9DvrTl6DEo88sxTKz+K4KB8H8dkK+R?=
 =?us-ascii?Q?Cpmv83ZTYupzaUoiYw3HoG/1hizg4GOQ9isAUiRZtGtIudSezaxpa5RWOR8t?=
 =?us-ascii?Q?aEyeOdRzNMPaQy72Lx+aJ0W0SkHgTrivEeotKpWix+YclxkO34jAm5fN7BLK?=
 =?us-ascii?Q?nF25+6YN6xLjyY+hQBj5mgdp0OKOIAc4KDUylsDi9EhY8Xz+Y2NymQXydZJh?=
 =?us-ascii?Q?qQQ7vXoOWwSRKyOfJ1CfjbBNO5TAWTCG1FJQOlMkI5iBJ7KEnR7u1qvxEchG?=
 =?us-ascii?Q?LokIWt1Ofbay23ByJfuVREnkEbMsyVViT3YG8JXvKz0xu/6xAFUsVAgloAlq?=
 =?us-ascii?Q?QEVrLgL/A6UCgZvQJe2pZBZsXBbroKkPdiuYlG+lt+vYDrcbk/ABAYCBh+MG?=
 =?us-ascii?Q?JFvyfAYvA3PF7LAhUrpE3q0Og6adP32sAiBdC+RLBhoQr5sHWuLV39EKQjNk?=
 =?us-ascii?Q?cQRDhCBb3YGDlBp8bpC3VqEVw9Kt7mk4Mqv6qxZXW73sk3uzVGPpClQpKlwx?=
 =?us-ascii?Q?wFhWG386o5wHO+t4ymQdVMP/p0eUl9qWt9YKRLoS8Pp/5ocU7ZltST+qP2FO?=
 =?us-ascii?Q?MAnVlhUmQ2SLahW98Ic3fUfdlY6NmXpwGk1+gsIKtgGb3Gyaj7SAVLpgm2Wm?=
 =?us-ascii?Q?I5uMXvozNrk0O/cOJeUU5axpKGIvKDi79PrC6L9O6mV12YsYjCzjMdHtn3Yb?=
 =?us-ascii?Q?+0Cqy2wtHCq94owHN70=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cade473f-0cd9-47bc-b2e4-08ddddfb4d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 02:02:35.9718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxGJWoazFj5CWRTdfFZN6yDccQMUNIaS5c3LVtRSQfg3m9z3rCWYoW/Z2Nea9ifae91FApLYvKDWITuEEPEyBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9676
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

The address needs to check should be passed to PF for UMC address conversio=
n.
It is invalid for VF to directly convert the address into retired addresses=
.

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Friday, August 15, 2025 7:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Add vf critical region check for poison inject=
ion

Check poison injection address whether in vbios or data exchange region to =
aviod hitting vf critical region in SRIOV.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b00cbb927ca8..158aa4ac9327 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -212,6 +212,31 @@ static int amdgpu_reserve_page_direct(struct amdgpu_de=
vice *adev, uint64_t addre
        return 0;
 }

+static int amdgpu_check_vf_critical_region(struct amdgpu_device *adev,
+u64 pa) {
+       u64 offset, size;
+
+       if (!amdgpu_sriov_vf(adev))
+               return 0;
+
+       /* check pa whether in vbios and data exchange region */
+       offset =3D adev->gmc.mc_vram_size + (AMD_SRIOV_MSG_VBIOS_OFFSET << =
10);
+       size =3D (AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB << 10) +
+              (AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB << 10);
+
+       /*
+        * Add an additional 4MB to critical range as we cannot reserve all=
ocations
+        * done during guest sw init
+        */
+       if (amdgpu_ip_version(adev, UMC_HWIP, 0) =3D=3D IP_VERSION(6, 7, 0)=
)
+               size +=3D (0x1000 << 10);
+
+       if (pa >=3D offset && pa < offset + size)
+               return -EACCES;
+
+       return 0;
+}
+
 static int amdgpu_check_address_validity(struct amdgpu_device *adev,
                        uint64_t address, uint64_t flags)
 {
@@ -223,16 +248,25 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,
        if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
                return 0;

-       if ((address >=3D adev->gmc.mc_vram_size) ||
-           (address >=3D RAS_UMC_INJECT_ADDR_LIMIT))
+       if (!amdgpu_sriov_vf(adev) && ((address >=3D adev->gmc.mc_vram_size=
) ||
+           (address >=3D RAS_UMC_INJECT_ADDR_LIMIT)))
                return -EFAULT;

+       if (amdgpu_sriov_vf(adev) && adev->umc.ras && adev->umc.ras->get_re=
tire_flip_bits)
+               adev->umc.ras->get_retire_flip_bits(adev);
+
        count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
                                address, page_pfns, ARRAY_SIZE(page_pfns));
        if (count <=3D 0)
                return -EPERM;

        for (i =3D 0; i < count; i++) {
+               if (amdgpu_sriov_vf(adev)) {
+                       ret =3D amdgpu_check_vf_critical_region(adev, addre=
ss);
+                       if (ret)
+                               return ret;
+               }
+
                memset(&blk_info, 0, sizeof(blk_info));
                ret =3D amdgpu_vram_mgr_query_address_block_info(&adev->mma=
n.vram_mgr,
                                        page_pfns[i] << AMDGPU_GPU_PAGE_SHI=
FT, &blk_info);
--
2.34.1


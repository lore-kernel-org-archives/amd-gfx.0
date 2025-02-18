Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6163C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 07:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5A510E3A2;
	Tue, 18 Feb 2025 07:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZTT1acpb";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF6410E3A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 07:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vq7uVStr6ZNZ+DlYX/jIIGLAB0CanvIC0k/zTzuwUzXFfmr4zSolxPNtNu+3pLmyXn9QtzQpFCzV5brC/pZ8knxfR5iBPfDXxldFSrupWDdF/PYxCNUx8jYXwkDa22RvrKKhRBxz3x0Y3ywnORKpi8oMphEa3UlV6crC1XIT/lOv8P+baVU2GJRGkW60Wb0lUIebY7uZJBHlqCbjYAJJWWWF7fwFoZF08kVTP11xxxGJd28Dc3WY0fGPaK75ej7t30JMFG7G1sOGedlImjnugunShRveWP4Mi+eN4aqQ3Roxocc3yXhnI7etMhDaLrmWR7YXO5GzeDvWTlwKjSeMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TDPp9D1u+qKwCIT/jRaTlcRNTQmHSW9gXSoLrFw5AU=;
 b=AElpG3339kxRbMZiciq+1ZV6el/XWQTIeN06enq+YDgpgvs0UOTRbcslTJQYslpgh42haEFs51/c84c14AXiX9XJv8+cnzIhoMRQoBjZeWs84myRFGSo6a78DiLZAndH81s8id7uJTeqMmJYmjRO96qUG3qLOG+6tGO20kwkUKCeGGIi2GNQv1xMsri6bc15XL+2xaDGQzJ6XnDtYwyLxA4JOfO+cpc86Mtd1N6QpCBLNUkVtqn+qTqdQEjXSWd0qfpAYmwY+ZuysWWg0t6m8uRAKDt6N29hBjuXxZuda+aiDAL0UdYAtW/nEAnI/GLbl7O02y0nbD+xrbFCpSUHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TDPp9D1u+qKwCIT/jRaTlcRNTQmHSW9gXSoLrFw5AU=;
 b=ZTT1acpbLWdVOrY4gnvhiuAzORy8m+sgAnVfyNYIupP/s4yKaTffyZr/bs0ny96UEDUpWsTv/4voaQlBO+gs4ruUgEa/eOLsxirTqJTvP8rteP7W89z6pF3RDURXL5zJlIv4Y2+uxF/UqMO1u6BuXazXD3f6Wc0OqRsNAJfgmB8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 07:23:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 07:23:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lin, Amber"
 <Amber.Lin@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use firmware supported NPS modes
Thread-Topic: [PATCH] drm/amdgpu: Use firmware supported NPS modes
Thread-Index: AQHbfheuHQ3GZpMUlUWmg3alwcqQWrNMr94w
Date: Tue, 18 Feb 2025 07:23:53 +0000
Message-ID: <BN9PR12MB5257D3516CFD14CC4C82E41CFCFA2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250213130308.2028349-1-lijo.lazar@amd.com>
In-Reply-To: <20250213130308.2028349-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3fa5ddbf-e3a7-49b7-81a2-76438070b59e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-18T07:23:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7318:EE_
x-ms-office365-filtering-correlation-id: 71f189d0-f8a9-4e01-81ec-08dd4fed3293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VbelBRtnQjKbKI+u+XCWce2v65cRQRnR8jd/mSDjcbGumwZpsDDAH5Hj92SB?=
 =?us-ascii?Q?WtPICtCp/1x+3jMNtu85WFcROSjcHZc4lJ75XN3coFPCWzD0+cB9jJIKdyZD?=
 =?us-ascii?Q?Ird2iIHD+BxvLr7tqy+Al+TnuCS8aWllH1pFTNsbppMNKEHVkbmTxCV6TCwZ?=
 =?us-ascii?Q?ELI9M3AurBafkSujxS00kLDIQz9Zcm3/AerD+7vtVBhK7NNteQ8vMyRZMm3o?=
 =?us-ascii?Q?sRhn8cVSBm9UFcIBsbOl+CoNBMqTuLrwL9KwZTMtIvKZ3ABp18W6H950lzew?=
 =?us-ascii?Q?od/WXTKkxL9yY7Px11ugrFvgGqDgkLLXXtvo30wuYd0K2NuhFsgg34BmTVuA?=
 =?us-ascii?Q?RSh2mgP7L7cFhZBX3hJHpU00hSL/NRlJUm5JqYmfdpQW1FqFFmg+9U4qWw95?=
 =?us-ascii?Q?uURXyi1AKRwN1PKt+/lM6PsiwUwP82IP+fnbjGvwhS3CTuH1W6E5LaWrvG84?=
 =?us-ascii?Q?4YYqB8YEpeC5K62lA4W6NZLFyyI5iYg9+4VpiUjjIDMMXZXTIyBSExIWfKH0?=
 =?us-ascii?Q?9VDOyS9LAkoZ3DmhZiep69AQvKfQHtW6tGqT3XB4DyRugMMf2PlTHf+LejIz?=
 =?us-ascii?Q?uLoX4UvQD3QNj3ZbEndyVhehhQaHxL6lSXtij++7fX7VWs8u7lj5KheN4W38?=
 =?us-ascii?Q?bIDt/rL7mhkyYlXPLeSI9Pz9cpBNyRpJhZeBmqDQjcAS+Bp5ylDOiwQ0glXv?=
 =?us-ascii?Q?WKaIIBAFyQi/wpccmOMMyclj5qw5ooQ8sZvpbk0xTmtw48qd7O0y3zs3b4cY?=
 =?us-ascii?Q?5hlidFsnu2CvWVHGC9erzdgEdd8VyDS4/uBnPDLf3YzSOr+C4vtLGwujGINV?=
 =?us-ascii?Q?UDOPET8b7AR9D+8lHVEkKo4v+BQyeDoe5/TmwI2aOaJGoh+gxdg/SUuKNY7w?=
 =?us-ascii?Q?84iM+KfM3vjbcj6GOFmAgHXMj0rgow7HsCNFBdOr14MlnWf1sVK0+JdcNK1d?=
 =?us-ascii?Q?+g8rdlugq1ZfGC/igpb5gwgBAper/EdipxbP2UJSMyBLJjSXM//AABKa7Hwa?=
 =?us-ascii?Q?0nc70ueylWPZ2BDgtGACAfSe0gYj2P2pGVEJVPNyqEbiGRaRX8N44XDZ8Ksl?=
 =?us-ascii?Q?/QM9zgGpaaVs8TlhO2kmTYxHYNNISqSMKC1WxxYSh2oJL1WQQk+Gj6v7Eee3?=
 =?us-ascii?Q?R9z49yvKIZo8hakoqBY/WEtqHmcNk7Dq9QeZK5aVFPL62KMo+Tt9MR9jwVWP?=
 =?us-ascii?Q?H4ODAcXA4cQO8mfBZ7g7oF3x8gNhDEfGYFdh74lDXklywVm4cPjNw2nzif7p?=
 =?us-ascii?Q?2nj8/ErGUa8Tm5prwVo06OGAsf2FSDz3kQgJtA7i0MJJsHJmNvn54I1xpwq8?=
 =?us-ascii?Q?NZ9Hu0pd74Y20OyTdwUzJv9QTsg8/+ZnhWVTAejjmIb9vmccyVLR7P4LXGls?=
 =?us-ascii?Q?SPrlcci2acaxaq7a+aMUG3aGWnA/lFa1FUmLy2b/QyjySrDHRJadizOr9NSV?=
 =?us-ascii?Q?efQ99zl7u7rQGyLoPiE5aNghO56vmcYi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G2leffrrsuL2rh14SFrESmZo8Bg96tRnqPyaRmEsV8FfrhLHYlqrTk8rdtXg?=
 =?us-ascii?Q?AsY6ps2uiQr6gO+OLHMkkb5igmYDh6PoTe0skFgh0C+Q3GCmqA3H1doZI0mp?=
 =?us-ascii?Q?7eyO+UtGxosYcMKd4s4p8vNQuSBtys8rUR/rnGeE51PFb3bO2K/i/YdEZyrA?=
 =?us-ascii?Q?FwaDkK9M3ZqLA57joxu4HPPRgbrYF9adOAvKvspwO/nHEwBz8SJ5Yy7afAoe?=
 =?us-ascii?Q?NC0oAUsvCLMiixR4XJzW4Sgs7Fjle9mezqQga+83oeuLF1UddZZuwGQQP1ld?=
 =?us-ascii?Q?3GKwRkOmd8RZzBOwavVwEZS8EMMI2NcLLAd5Cqv0i+3VNLakDM45uIdatlsW?=
 =?us-ascii?Q?CHVGnqFga6ulyvIsaowIw3/LuQkxtWpLNjA2Or3RJni2vgq5T6ZEpddLeBKk?=
 =?us-ascii?Q?QBmosPzV+3mNbhO4GVrYDs8Tn/HbV/spdH2FfKf0kE2XggG26uuMOKjrrGaX?=
 =?us-ascii?Q?6XaxPoJV33pNhYpqCEFiJ+m/Zfp2xBHTeTfVq2lOyXcJWjCnaP+0Yp4y7+M+?=
 =?us-ascii?Q?fEpoE0bblJ2zdyyAfmmHyKF3igfA2Qk75tQ7vt+uIHXfX4vDUKQVmXTjRP2R?=
 =?us-ascii?Q?+NQ/9fuMY92yqA+t/Vd2h1Lp+0p9iZzlx8++K6TjYjtEUAQJS3o/APQ2upqp?=
 =?us-ascii?Q?nTDgSh/rTbAvN5bReTXnQjcwkubk1QMD2iG6JfIAkviLEy9ohYw814U79XbX?=
 =?us-ascii?Q?yrj0D3s02aId3hJ6qYqukiaRc8m20mZH6JxAmGiXQV+Kxfxp+tCnA9zpsj+D?=
 =?us-ascii?Q?yXwcEmX1tMsJ9hZptMKHi4llHI+RT/Qmc+edHKabOChp1Ul3dNuCDfzu8T6Z?=
 =?us-ascii?Q?++Y07U/jjMBguwnFzfs7rAOTITac/s/QOrAGsr5LVf9o7iyhnzPvJsOBaZy/?=
 =?us-ascii?Q?haxo19GPrSjBYXctuf0DYNg3ewliAgDodnml8MPpyJMiU/ZxCbUDy8fthRT2?=
 =?us-ascii?Q?oKXH+RNHfv8llIZruKZnb02BGjMrCwq0toAOXQ9qw92twuuG6+jWO2/qmQeQ?=
 =?us-ascii?Q?d8olwpRgHh2e4fYMJqKFYcQ+wnLuxfCPvMkEBOkordOED74arno524QuzX/j?=
 =?us-ascii?Q?jIpmhMi5ZMzPfV5Z/ZaoZUwi/uYo+KVetvPBGc66oaiUd/FD5QWMNCfciwAp?=
 =?us-ascii?Q?vIXvgJL0d4SjdzhfamraAueiRtjQ1M5hcVM8Qlcm2ZpMlx52Im2pQhDrR/5a?=
 =?us-ascii?Q?fVNycqvmkTDgj81CFNIH6qx/XtIj/Ek3iZh89x3D5vScKAI7TTXYEMd6N+Zt?=
 =?us-ascii?Q?zL/c556aIgnf5ebgJGzhrry6/U0izIe48sEmsCFj+PM272PPIElBoP4KcSGK?=
 =?us-ascii?Q?b8c9+LLwhqF1MHwjQVQrTR0qzDAuLLBKC+kjxLXMIegIbwC4eAtqjOm+RKoB?=
 =?us-ascii?Q?iIfXKWSxeOzeUnl7StMmL28CUS2+670xmX9jDB0MuWgPwgzzKrrssdCTgOXF?=
 =?us-ascii?Q?qlW3H/iCxuujzhdPTOYs4CK2gBiWpUzskPw3aNdMl9cdoOxYOTTS3snquWGJ?=
 =?us-ascii?Q?I/XbEu6LLOQCf/KlCKxgzsj3fa9Tjt4aJzyTRgSQkl+Liyel2XlYmiUN0EgO?=
 =?us-ascii?Q?29ZV0ApKGYwpE/Sg5kg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f189d0-f8a9-4e01-81ec-08dd4fed3293
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 07:23:53.0432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0icBsJxcs+3seHezQ5+KoPtSUKqCJDgDdZ1MMB/1h9nzyE1yfpEGpC0olUU/MHjIZwIHiQq5VI5rk3D6YLc7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, February 13, 2025 21:03
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Lin, Amber <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: Use firmware supported NPS modes

If firmware supported NPS modes are available through CAP register, use tho=
se values for supported NPS modes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 36 +++++++++++++++++++--------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 2aa87fdf715f..4f3ce6d22386 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1594,23 +1594,39 @@ static void gmc_v9_0_set_xgmi_ras_funcs(struct amdg=
pu_device *adev)

 static void gmc_v9_0_init_nps_details(struct amdgpu_device *adev)  {
+       enum amdgpu_memory_partition mode;
+       uint32_t supp_modes;
+       int i;
+
        adev->gmc.supported_nps_modes =3D 0;

        if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
                return;

-       /*TODO: Check PSP version also which supports NPS switch. Otherwise=
 keep
+       mode =3D gmc_v9_0_get_memory_partition(adev, &supp_modes);
+
+       /* Mode detected by hardware and supported modes available */
+       if ((mode !=3D UNKNOWN_MEMORY_PARTITION_MODE) && supp_modes) {
+               for (i =3D AMDGPU_NPS1_PARTITION_MODE;
+                    supp_modes && i <=3D AMDGPU_NPS8_PARTITION_MODE; i++) =
{
+                       if (supp_modes & BIT(i - 1))
+                               adev->gmc.supported_nps_modes |=3D BIT(i);
+                       supp_modes &=3D supp_modes - 1;
+               }
+       } else {
+               /*TODO: Check PSP version also which supports NPS switch. O=
therwise
+keep
         * supported modes as 0.
         */
-       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-       case IP_VERSION(9, 4, 3):
-       case IP_VERSION(9, 4, 4):
-               adev->gmc.supported_nps_modes =3D
-                       BIT(AMDGPU_NPS1_PARTITION_MODE) |
-                       BIT(AMDGPU_NPS4_PARTITION_MODE);
-               break;
-       default:
-               break;
+               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+               case IP_VERSION(9, 4, 3):
+               case IP_VERSION(9, 4, 4):
+                       adev->gmc.supported_nps_modes =3D
+                               BIT(AMDGPU_NPS1_PARTITION_MODE) |
+                               BIT(AMDGPU_NPS4_PARTITION_MODE);
+                       break;
+               default:
+                       break;
+               }
        }
 }

--
2.25.1


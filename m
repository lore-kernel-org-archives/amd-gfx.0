Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBB2CD342C
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 04:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD2910E056;
	Thu,  7 May 2026 04:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QNukNYRW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C111210E056
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 04:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nu/+r+y4xoNGVqrdEy50pLICyrMgP59FZ2IKUFCNhZlvll/Nynhfh1clBdu2oxUoRtv6PShQd9jleEKcW2b84RkdYyw1M3Eod9LtLVa8fSVycU5bz0gM7p7ayTzT2h9ewl+JJbaIiwTISNyFnRoAIGZkPa3nzrG5KtWhW74JM6tWpAvzGKy1EBF0l95718OhERlcQG64FL32qe0t4DFLu/rSorMOarhnNl4gUKwwdvkHOL37VxeWH5LIxu7dZD1kmNQa8jZfZxtXYPODNytliqzcro+bZ/ElXakUo1vnSzbimXP4LZpWUmYC8PJXazrYabXerNVXYXhpPHbwevU+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95glKPSX0GbsT4U38uvtXuIiex5g28wxMn9ll2rPEIo=;
 b=LufaQE+fsFAreTdjOtwVUTDRuMV7QP+k+s4vMrdoNC+A3eLAcirItP75V8YmzW4CuswLTT2TGBLnklj8WObmtz4Nf9f1cAVe27cz8HJZTNqQNdzOrFkCr3jSQse4vsEyfNGDCvk+f/qnUhWpCUMthR27sL8Eb9TUZe94jhHzIOxdjyGUmuJhJxtj1TK5AQA5z/9PaKLh5imemVvZaL1m/Lq5btkPu9hUnxyoZuJnSz0zT3rRVUm4pVtgE6mLiuuOvOX4AZh+0IjgJOmT0JEi9F6peNfsinS6mETvkubIoDreHrLFi1KF8It7CvORK5IyjY8JhTsAKQL6BbCwUrLx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95glKPSX0GbsT4U38uvtXuIiex5g28wxMn9ll2rPEIo=;
 b=QNukNYRW7dvxONPCyx7NMve20B7nr5BdehXiecBFqWu77qX9nc0NPkWnDrE2e+Qf/5DKixPyp+mYkpOBeu9IIVu3koIHN2NVgXgvauJj5c+6//2u9mrD3zeGQWs6FESHeDoRro0QNJCNa2jR9kaD0AtuMU2423SoSoifrSMQT74=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 04:37:35 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::2f1e:82be:7d62:8457]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::2f1e:82be:7d62:8457%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 04:37:35 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Li, Chong(Alan)" <Chong.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Sync the pf2vf structure between guest and
 host
Thread-Topic: [PATCH] drm/amdgpu: Sync the pf2vf structure between guest and
 host
Thread-Index: AQHc3Tps58Z1lLOpi0iLUHcfo9ygN7YB+6OQ
Date: Thu, 7 May 2026 04:37:35 +0000
Message-ID: <PH0PR12MB541766B1BD4F2623F3208EC58F3C2@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20260506092559.546713-1-chongli2@amd.com>
In-Reply-To: <20260506092559.546713-1-chongli2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-07T04:36:18.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|CY5PR12MB6455:EE_
x-ms-office365-filtering-correlation-id: e337150d-d20f-4f5d-7668-08deabf25c58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: CHNM2OG4qQ9/waxQvzfSlTqR/1RNAlbhHsh6/9aLhQU1bGKej2uSGeKHKNROjsRiEH60UzgxeMg9VblF1EHDZ4EPoBpOrqE8mtWeQ591VuZn0MmfLOD61BGdbAcn+vKOxFUDB9racVCI+E7apcRhMq4BOFvr6jwNLq+NO2qzGpNDEJuAQs8rvLfaNZ8fLAWwarVhWs/QRBRcfXbuiev+Zx3dh6yR7DeU0lHpILd5wgym20myWGFUiQDp9uMwXEjtQSbyxJfJZy67RvP+bqv2S1NotTIcVBENHsts5qgDW9Jpk7QLGIcW9Iha2EzXPBN+e+gdbMg+O9ZLQhBc3CS1gahmnttlmuGdvfMw0jb/0oeyzEEZIQ8KZ9XLXV9RSh+cm2sgeovCfb2nNfcMUmjhhdfmPn9Mv1MbtCu3pxZzzTU5LFcd7RfkgLmhY32IWSEyxWCmlmnGLTAteLzmJNtdj/XlXXrMJPoeWtNL02uIReeOB+LmwjZrzXIsNUnozl5NneA6RalWoVqFfF9JIT/5ys402S0fXqTNHzwBd7fSYJPWfW1m626ml9+03BQp5cZZ5PhdYrpA0v7tspAs4GSDXiVblLNtt/iqc2zjGN+ku6yKHllCU058vfrdjiepLPtYKAYP7LYsU99MJ5TTlhsI2GnYKQvLYeALxxJM4KbfNdHCfJsYmIsqgOyfhkqdsoXVIGYfBOmHH9rRLVou1pKUsqtyZxGlDN6YjkDv3pQ/ZpIXvUeUEA6tRSNK89qvXyrf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7j9HDXHx4XHCz5Edz7mjhigAGLSsoPIRYv5PJUDEK7gZFzLLOm1vq8QTBm+v?=
 =?us-ascii?Q?pOBmrQMVlncUk/U+2F53WVO4wZ5/IJD0WlFj68vCjwegq8zDgroMrk3NoyyT?=
 =?us-ascii?Q?20tmLnZP4phhxZBFi21Pu10lci8kvz3Nt86DTqPgnDqgikbpZka+6lhy1mnv?=
 =?us-ascii?Q?C32R/xB1lPrQtOjmhurJEjOsF+pfQUP0n2U+H5k8wzSIOj5hMs/2EwWFN6PA?=
 =?us-ascii?Q?/xEGayW9ffnAinX0Bezo39Mwjw+L13z8E+T1JxmnnEc1NV81z8RDpaldAA4t?=
 =?us-ascii?Q?/MPr5oZyZ0id+tlnOh3KGX6HjpFgVhy1Yf6wbmXZZaJTUj3lPAXUF6O7r+QY?=
 =?us-ascii?Q?mzDd8tCgd4xYtDz3V+DdiwBxiIox09lT9Fh+upnHrNPs0ukA7Uw6goGGPnYo?=
 =?us-ascii?Q?lxMshHTyWrKL/+KaXMgZn5lh+Z7DRcyQGXzGCwnDInTyYXUvVoHbMZNYHtje?=
 =?us-ascii?Q?4MunlPGg8DejkyZj+zGT6LwhkRJStzpFrIiFs1cVDqkK9nK2rqXYU+OkRm8G?=
 =?us-ascii?Q?Si/TW8VGsXrcn0NTH/lkCl9zsLsJUzRMrpC2wiL8Ey79CIG6ASOBK1GmR8ZI?=
 =?us-ascii?Q?aKYCbXDh0BpxBiFJqSBODjzCoB7BYq/6fvORInOtEM+qHyUnzO32wmpdeQTc?=
 =?us-ascii?Q?f6v3ph264mUK0d+/sjmR+nIZoBfw40za6EMtRWjqrsiaeO0qRsdnbQADSjbe?=
 =?us-ascii?Q?A87Rw7aVxNrqBIud5YlMAv/88OsFgRcfVOnmisgyJfHmYPvnB/PejPJ4gKAX?=
 =?us-ascii?Q?h/3czdTYCXSRR2K/FHl2E6XYyVjRG1jvWv/Xo7uz+vgtCfF5UeWN6HP6VZ5Q?=
 =?us-ascii?Q?mZ66SMjp2EXoTat6LgxglHHfyfeKaxzCQtVDUxHu2OHcFcgr2y3PVcYOmACi?=
 =?us-ascii?Q?ndi1UmGIdDFr223xFAy3gcnGV8aHzElMSUfPissZeqYBUCh4TUf/hfFBUmLT?=
 =?us-ascii?Q?OyBG0nWhlY4EWkitcgyHo8j6mtV5GDYHd32nezdiRUWKrA0X4pDNGRoST7UR?=
 =?us-ascii?Q?46TmfLbolMUcHbmIj/lBh6VDTaf+XymUmSnkox/gD15SuMMTQfFHWehblQgd?=
 =?us-ascii?Q?dek1+Lf9GjCQVa5fhDZvKtVIYmYekGFsFuJQ3pYcvtGDWEobltSruoWGCT2K?=
 =?us-ascii?Q?9ukbZIeyzpkI8dkrg+jI3+ozrDZTRkrGkbdsjwKltJPrOW7p3J2UXFKtLyj/?=
 =?us-ascii?Q?nOGUR93h1Xly3wMBFo47WRuBiMehWYkSRiMbep6nI0n8EyCebdL7FSNYlH8L?=
 =?us-ascii?Q?mwgRGnGzx4m1lhwGE35B6upirr34i8Meeujc2PebiVweit5x4x6fJ/PcL4WG?=
 =?us-ascii?Q?qA5eB9CPutzqzvhFApTaeCysvQ2Ep4EZ+zzjirXWvyvOWMSNmgrANy8v4pzh?=
 =?us-ascii?Q?nEeZme0BffDIgQM8eu2iRgZER/0QvW4dPxuKruE66OHmjrSATPtMgckP+MY1?=
 =?us-ascii?Q?J84sGd6u1H9LgIrhqdm/Zd3fZEA3HTreJ4e5tjcgLGdqa2r32MSPFDNavoeb?=
 =?us-ascii?Q?wceNlQaRmCszuB3HF0G1kPZWr2Lj6QTGW13o6iuaIuNFHNb+D5ATVwezBAlS?=
 =?us-ascii?Q?Qv1Kiin0OhegliEuNUpFkTWARSxpL8W0p2NC15FngGdrBbkjyk82kgqupNRG?=
 =?us-ascii?Q?Qd9arOKYJy7FPFcxkhVG6GJ/8hcHbJHUgdyKXqKapihSODLXtOhYuYzAfFrZ?=
 =?us-ascii?Q?r1X5EWLavXiizYOK8Jhn/buFipxKNqMnUFM2Scv/IEYOjAeG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e337150d-d20f-4f5d-7668-08deabf25c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 04:37:35.2820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZApZbM6bhRpmin/DNZF50yfzu7VLi2TrGV8gTrNcllpIMjEkoLoq7A1W1D/D7uR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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

AMD General

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

Emily Deng
Best Wishes



>-----Original Message-----
>From: Li, Chong(Alan) <Chong.Li@amd.com>
>Sent: Wednesday, May 6, 2026 5:26 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
><HaiJun.Chang@amd.com>; Li, Chong(Alan) <Chong.Li@amd.com>
>Subject: [PATCH] drm/amdgpu: Sync the pf2vf structure between guest and ho=
st
>
>There are gaps in the pf2vf message structure between the guest driver and=
 the host
>driver.
>
>The pf2vf message info structure must be kept in sync between both sides t=
o ensure
>correct interpretation of fields.
>
>Signed-off-by: chong li <chongli2@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  4 ++++
> drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 13 +++++++++++--
> 2 files changed, 15 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>index 9da0c6e9b869..d563deec0916 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>@@ -163,6 +163,8 @@ enum AMDGIM_FEATURE_FLAG {
>       AMDGIM_FEATURE_RAS_CPER =3D (1 << 11),
>       AMDGIM_FEATURE_XGMI_TA_EXT_PEER_LINK =3D (1 << 12),
>       AMDGIM_FEATURE_XGMI_CONNECTED_TO_CPU =3D (1 << 13),
>+      AMDGIM_FEATURE_PTL_SUPPORT =3D (1 << 14),
>+      AMDGIM_FEATURE_UNITID_SUPPORT =3D (1 << 15),
> };
>
> enum AMDGIM_REG_ACCESS_FLAG {
>@@ -441,6 +443,8 @@ static inline bool is_virtual_machine(void)
>       ((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
>#define amdgpu_sriov_is_mes_info_enable(adev) \
>       ((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
>+#define amdgpu_sriov_is_unitid_support(adev) \
>+      ((adev)->virt.gim_feature & AMDGIM_FEATURE_UNITID_SUPPORT)
>
> #define amdgpu_virt_xgmi_migrate_enabled(adev) \
>       ((adev)->virt.is_xgmi_node_migrate_enabled && (adev)-
>>gmc.xgmi.node_segment_size !=3D 0) diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>index 847cfd1fd004..9dcf0b07d513 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>@@ -162,7 +162,9 @@ union amd_sriov_msg_feature_flags {
>               uint32_t ras_cper               : 1;
>               uint32_t xgmi_ta_ext_peer_link  : 1;
>               uint32_t xgmi_connected_to_cpu  : 1;
>-              uint32_t reserved               : 18;
>+              uint32_t ptl_support            : 1;
>+              uint32_t unitid_support         : 1;
>+              uint32_t reserved               : 16;
>       } flags;
>       uint32_t all;
> };
>@@ -256,7 +258,7 @@ struct amd_sriov_msg_pf2vf_info_header {
>       uint32_t reserved[2];
> };
>
>-#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (55)
>+#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (59)
> struct amd_sriov_msg_pf2vf_info {
>       /* header contains size and version */
>       struct amd_sriov_msg_pf2vf_info_header header; @@ -314,6 +316,13 @@
>struct amd_sriov_msg_pf2vf_info {
>       uint32_t more_bp;       //Reserved for future use.
>       union amd_sriov_ras_caps ras_en_caps;
>       union amd_sriov_ras_caps ras_telemetry_en_caps;
>+      /* PTL status response for guest */
>+      uint32_t ptl_enabled;        // PTL enable status: 0=3Ddisabled, 1=
=3Denabled
>+      uint32_t ptl_pref_format1;   // Current preferred format 1
>+      uint32_t ptl_pref_format2;   // Current preferred format 2
>+      /* unit ID assigned by host; vf_idx [0..254] maps to unitid [1..255=
] (0 =3D pf) */
>+      uint8_t unitid;
>+      uint8_t padding[3];  //use the 3 bytes to align
>
>       /* reserved */
>       uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
>--
>2.48.1


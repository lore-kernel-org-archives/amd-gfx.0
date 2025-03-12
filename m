Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C1CC28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 03:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9134B10E5FA;
	Wed, 12 Mar 2025 03:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CcNW3TbF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2D210E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 03:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmMuF26BhWxAneCTF+DJBUAowBh2kd79VYlgGCLStkyiws3h4kAg3rpKSYZR1ZpYmmJiAaeAn6Vl3hvFATHYc5kXZp4gTOI3WBZiR8mV6X9Alo0isZ8GIQ0SPO/FfkOicXNLnE6jNUj+y2I93w9YQzXK7PH+ZJnORbBJzPqARPaBpQz4R/VBV2hujHNUZiI3RHNeq3eFA9mMiru71Mr/iH9nKzm03oYpv66kp+76N+nybXGjC3W3pzhwHiGftnPcOnWE2okxzGfs7w1e3QRI1NA3H13Kcm/epWMAQGb3HTTaK6Wd+KNm9mMziynLr3spKiOwb9TWwYIH9cnpmovD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wB45YaoKqDIBNJv4/eIRsnGNKQeXUVn/9jyPn7TjXsU=;
 b=bav7fwx2XIGC3jG9BGWJyZcZXs4y3HYI65WEZtbF7+Ay9QL3krbfdJqaFHMwMfNRI2HNCRmDvH2vw8A760TT2167yEGPD1MWf+ByFa2AT13COTZRymaZbjmzqZwZnUhAnOASC74zUFfZzWNPjV0GF0Im3oXZ/fpJc0oaSNFQn67/Os7ghNvZWX/mFuGRH2gpCEuEZArHV81I45Ola8b7wqzX2ozZYj14voicVnA4xzDeeYSPmBOK7Izlut9Vps02Aq6Y27UFazhidFbtg+WxQho/qmX6mCyAN1B6bL8mCC2klFaHI7RriPwaj2DcRvtSBQwPp20drD33W6TyHpBcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB45YaoKqDIBNJv4/eIRsnGNKQeXUVn/9jyPn7TjXsU=;
 b=CcNW3TbFBmBeSxaDRcGyYRwXem/M8lr+OpS+fuLFI9lVf7Hyo+r0QKvBC2Wh4DnSjNELvlos6eHIzQCQ/v+Dc4sZmlF/cwgE9iAtcV0XR4Booq1fcdroThfD1kouVttM5DbFk/f3iHp5mZp46RNzdziEpc/cpmvPJXPwYWGYrmg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 03:57:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 03:57:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable ras ta if module param
 amdgpu_ras_enable = 0
Thread-Topic: [PATCH] drm/amdgpu: disable ras ta if module param
 amdgpu_ras_enable = 0
Thread-Index: AQHbkvEjgG9ZrnFnb0um/hiyaLvvcrNu33fQ
Date: Wed, 12 Mar 2025 03:57:50 +0000
Message-ID: <BN9PR12MB52572622A634B082BCE746BEFCD02@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250312015018.1547060-1-kevinyang.wang@amd.com>
In-Reply-To: <20250312015018.1547060-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8e73100e-2e1d-44a8-a6f8-9163caadfcbf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T03:56:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS5PPF78FC67EBA:EE_
x-ms-office365-filtering-correlation-id: af39e89e-7e85-45d2-6b7d-08dd611a0f50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PsjU6hIh8TH7kkktCRV1fxzwHXuu6F2iehlnMYR396RUoHJcaWPGFKGAT5k2?=
 =?us-ascii?Q?AVHoL8VwKpeu8sEvAmG4YCzw0npxk68p66VThUNeCEYigYuGylTkwOdRmbMg?=
 =?us-ascii?Q?vrsRzJs+xrlawH0XNqA8jMz5iuCb9/jL9y55fJCmFvzql1fYyrVqAKoaHVtm?=
 =?us-ascii?Q?lPvVwra14MIHdjhfzdJ3eTjaFBQIDHKtP+RW/n/Mbl8a3CQ5hwFZVM/qr8I3?=
 =?us-ascii?Q?1oU+nT45gRH0625CEj2uSG0Fq5TNdUZeDRaw+I6XDRoc0eR+SLQThS6JM+EU?=
 =?us-ascii?Q?TAqf9Ri/oGVSIOcTSOPjONWUDquIpwafC0cr5Xjxa8HnYs4kyPXNS1RTPw3Q?=
 =?us-ascii?Q?32MsnaD+dUU8PcLOIB2xuji8gfLuZC5KWverQ2D8hgwplgsKbDIzJoEAnJuU?=
 =?us-ascii?Q?QNMaWdJJijFTe6SL1MNOQGcyEEaSWxiTKt7VO73dhYbuHPCeZZH9x+VP2Idl?=
 =?us-ascii?Q?0aU8hK5YAixDPOhuDto4qi7fF5e9xR4APSLtBhoPV9+7tBfwvgBElINrldWi?=
 =?us-ascii?Q?os0SYewQtdGKN/5nR1pSYvlst5XEL7OT83397aSZ1MtOhaNXMf/QtXqqFqVj?=
 =?us-ascii?Q?6je4CAXre81TzZSwGpzA/O7xl09eN/NixOJOLBXKoSWfgumuLrfhH1m/BEx9?=
 =?us-ascii?Q?FU8UpjQ9ZC1Wz4IS/G1uGN/iHsmgckN3nXiqJmF3ivW7k0KSHjJecnXZPRfi?=
 =?us-ascii?Q?8J22ZzlyjoPPlduIEhnmygn4cfiz7WehbVFMMGwpxvc7XL/FTegMSz0aBEIU?=
 =?us-ascii?Q?U+bm0ixKKUZLMYyHDGV200trszlIzJkWUmze/tnL4YmtNezlEGjlYj4obXGA?=
 =?us-ascii?Q?onB7dNW+h59OtfqWtNJb14pXuMvaDXm3iV19pRj3PPhlEHjq9SP/xs4V79Mk?=
 =?us-ascii?Q?fWSaV4hfkimuWpaRx3oTsS6Se24LnVRsnZQrVn6KYanezQJ+ItdiPz22ancB?=
 =?us-ascii?Q?dtHF5NcPTfYjR7VCyuvs00Ov9xDAxlTp4RDnEW+nvQpVE50HrrzORJMZyGcY?=
 =?us-ascii?Q?yBO2/a82XiJKwAnCe+99eohIdd1/gDEQDyhOMcRAAEQvKdjg6pI4GCxyFWJG?=
 =?us-ascii?Q?c2OwKWR5EkHcjRzHjkAfoNOYrDYgBGD5RQVRE7ggtOs1gwFvQ2gLaQbjoKgL?=
 =?us-ascii?Q?kg7quF6t0t/213eWss/lf3fXTR1YT7+n6Befqb4U9wrUdhYHdSoXEzbFBHff?=
 =?us-ascii?Q?tJiAjaaw3Sde5kpyaMs2/oOTBlTRK+VDni+DzUHkPiFoUkovcNEA9E+fqx89?=
 =?us-ascii?Q?LdZDYdBreHjSHxHVCEkBOsUoseUtNDIRZWyNAIxeB+lkkp3Nb5lpleJ1Tq8P?=
 =?us-ascii?Q?chsqdaX3LL+HXugqt1QaWvScaH5DkDiJ95S8EHDgUbjuvpkJ0PjX49+B4CIK?=
 =?us-ascii?Q?X5X5m8xPO+pTGLjeTaeC/VU2Or6yrC0RLPHME2hQy05h2HZCEgyMhA5VDoz5?=
 =?us-ascii?Q?UqLM/YUevDx6N7g/50Y9JQz+edZWu5Iw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ig49Rf4NO5o6rAT6F2qfT8mSGBF0a913m/kz5MH0tCR28rE9I0Yd9AkilxbS?=
 =?us-ascii?Q?WukozO7NdJ6xzj/FgRCY+rpPsx1VLWzRmRLMNN4PJvAkiJ2i12xuRimwVWaS?=
 =?us-ascii?Q?hX948KfvQEK6L3fKr44DvfPVxTZU8b7mLgwx4yjnC89lVQdu8xmh7RlfD+Hr?=
 =?us-ascii?Q?4ENqJkNteheQ8MbP6SyckLBsDic7aD2gWQTKQ3eaLSEB+zcbm6klrX09BI3U?=
 =?us-ascii?Q?ZIpPnFDJ2rMH8zpSwtlR39ilE6Qu2Vh+vscnKdgeDIOfE+C7pbbBEAzi7Zat?=
 =?us-ascii?Q?/zd8joAR1at2+bOZsJ5R4xgjBLEW4h0LPCX3pAmP8W+jRz+n8c0P47R3Ga/l?=
 =?us-ascii?Q?1mDllJIkd81ffRWmu8HSdhhJbpmE9s3U/EMZRFL16Ff9BpaBIH6RCuM3+f0q?=
 =?us-ascii?Q?QhyN9a8zPt2jq1794sOla6eO1k78+VIWf1RKCQ/5gF1jf1YQ6kTQfdJOeodP?=
 =?us-ascii?Q?hp0LI8QOPECjDenT8j4mc2SyZMHdewcQo1C/L2pY/jkf4BI8WzTEJ+bM4kGX?=
 =?us-ascii?Q?OCcbEwvMspVQtDiXv+XbPa+MYhkU78oNkVgeg2fRNBumfuipVYUxEqdqo5Lw?=
 =?us-ascii?Q?kxSackT57akWjneq5+Vdng7WrhKVqW6+/PDhnz3SW95q2iszCdCieFKl1FpC?=
 =?us-ascii?Q?qgK6MJVhlJAROZG3Rl2H4H37aSbU1rSCXjOpQNsgZUD5nECY3Ovy4jH1jknL?=
 =?us-ascii?Q?FrlF0lJNGj2fpo6BPEod6fCy9HGi0GFqtyX5KXBYGKc3Bx4cTSA3WIv4It6c?=
 =?us-ascii?Q?jJ1IzEI2ljJQUNr8ytRE2MGIsiCrh6kthMZ921vfz1it/Jvb/KiRed7VT6W/?=
 =?us-ascii?Q?d51rQkwuN74XkoWHLEd2WYUznGMSkXDdmZrNtN/OXl6ZAA82zqjEfN08hWvF?=
 =?us-ascii?Q?AERYulfADUnKWAnPQMwnOuT1/BL/nhlYzYqhEDKu1qGjiNOtCfeGMJ1qxscV?=
 =?us-ascii?Q?Hm9F2blLARLMNMzTppfaKswyHBYnrcJTVA9lThFaWIL6Z3GiPKQCaRSjkKZk?=
 =?us-ascii?Q?mUk3ZCOcKLVRNH0wzwDiu1KIUNGMmC7YoXMpsmv1qbnGLsDv4gx3btdGGvzx?=
 =?us-ascii?Q?8PkEL0jY9Rci2DBEYLrAaGnkU1kyZrqnrngPAQb2vStWbktp0+sQgj+9LF9u?=
 =?us-ascii?Q?1jmrM9FRw8pkCRQJJAlEb2mAvO5hN3Hs0NbcaSJV5HdrmKz0lDAx3V+So0Ji?=
 =?us-ascii?Q?SE0YnCr7Lzu+dNxf8+IwZzg/NcR3xbiEvtrO+mIUM8dyyy2Ibiwckqo0avPq?=
 =?us-ascii?Q?hf0iMzlVTnpvfAwjZi6Vtuw3FFxvDn3jw5Cviifw4ICdNxsD32CeDpB+/0+/?=
 =?us-ascii?Q?OH2jwBhQOvdWjl/DOEHJmpRFO0FPxNq+JohXtJMAR7h32TzsA53/IYKs9Igk?=
 =?us-ascii?Q?7IiXZwvFDKflHqAC2SSEG7EuJqp/0FDausLFTTJ6jANcSPhyfMR5/MJu/w9g?=
 =?us-ascii?Q?qZQsCZoSOzNINvDCl/Vj4mZpd0UqXhyfCBeX9oM7IA1GTod64hk1/0V3PKy5?=
 =?us-ascii?Q?+p3L9YjYvtwGFHfMB5bQqN2sixAa36nq8wFbLmFtsMUC8WV/Bl/8uIKlkygi?=
 =?us-ascii?Q?XYeOKsC+rbHQ2C+XkHy9D0/93sV/0dUvY7Z8c4wy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af39e89e-7e85-45d2-6b7d-08dd611a0f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 03:57:51.0071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gaopVEtngJvmLhgXY6vDOQcBSTeu68P4EaLf3VQIPlPBhYEg/FSA5PlxrKeo31YG7HYROcu1E0Ldc8oB8tIUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA
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

Let's not do that. Ras ta should still be functioning to forward disable fe=
ature command even software ras is disabled by ras_enable.

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, March 12, 2025 09:50
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: disable ras ta if module param amdgpu_ras_enab=
le =3D 0

remove unnecessary ra ta laods if the module parameter is specified.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 79dad75bd0e7..f4309e79b85c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1752,7 +1752,7 @@ int psp_ras_terminate(struct psp_context *psp)
        /*
         * TODO: bypass the terminate in sriov for now
         */
-       if (amdgpu_sriov_vf(psp->adev))
+       if (amdgpu_sriov_vf(psp->adev) || !amdgpu_ras_enable)
                return 0;

        if (!psp->ras_context.context.initialized)
@@ -1777,7 +1777,7 @@ int psp_ras_initialize(struct psp_context *psp)
        /*
         * TODO: bypass the initialize in sriov for now
         */
-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev) || !amdgpu_ras_enable)
                return 0;

        if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
--
2.34.1


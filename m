Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F117FD4920E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 05:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C0210E047;
	Tue, 19 Nov 2024 05:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="erzY68eU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C7910E047
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 05:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXio0Jf1gDJWXU8iD4ISrwuMpdKC+LuBEVLaL5ZGYViFobqVY5x4o0HN99MuOINvko5i9JK5/Trf8Oid3Is1yaHQWB6Nz79G0bo0AaB0Duc3jOMACA6jvHLcYCI5NWGHXjJWlQ4NL+AAuOss5g91hX4bUDjVESneiaLr+xTvkdryOlqFgPLf5o76uO9sCfs07mDHuTs41D9nWCk20ysKBA5FMuHnAjj/ZfKezF8BGIeBBYNf76O+sNepCJMG+KFBmg0VogKELBBvctMZ8FAigBnfrhoTUKc22k0FrpDqKAQ+NvMzL+Bt+EbnP2gwHen9hsK1F8lNMaXGgLMYlGWrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+jIb8Qrt4KIOeMA+k06sjjJL3+TeGgRIzLY51hoh7A=;
 b=xvywG7KP5PJPLpvQrkYtWwv0XIrUCTr3tMxkOh7cxfonLFDz76WHW43Z19Knp0TBTRxRKe7HGYML9bEMNvciGAMA2pe6JkyPhp9NMSQYT13WsplkcbKKCufqGpFgdh7YG2ICYfXRxKn/+w36jXkfqcRwlpvcVt6SwJ43N6YNfafsXoxy5v9AW9CpvO70DAAmtYPzlLji3JWMx5a5QbebXDtnPT7OOADy+9j8D/751d1GEEVcXFp69FVPHm9iVt5OxDvFsWg1uM3d8KU9t4dBQ2M+wHGGlhIxQnLHnJ12XOQ45e7ASQXQtQAcwEsC+fYeCQoe/tex0w1aM3piR+8vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+jIb8Qrt4KIOeMA+k06sjjJL3+TeGgRIzLY51hoh7A=;
 b=erzY68eU6R5puKnAAL7esk50NYop47Bg29GURIMqyuI8fBvQS52KesKadKjrIIjawkJBJwy3+aW1Wbb+g51qbzmwQMCUTNswGhOPJJCRgLO6h8UXpM+ulio1XuOhxrvzRHx2QWmUvRfcDHoaykyVqbAG9gNgdjCxZ+lzKS5BfVw=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 05:55:37 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 05:55:37 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: add gen5 display to the user on smu
 v14.0.2/3
Thread-Topic: [PATCH] drm/amdgpu/pm: add gen5 display to the user on smu
 v14.0.2/3
Thread-Index: AQHbOjEAMSKRKjgMIESw8BSh5grL+bK+GtFw
Date: Tue, 19 Nov 2024 05:55:37 +0000
Message-ID: <DM4PR12MB601281D78805D3E8898DC9BB82202@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <20241119031231.434471-1-kenneth.feng@amd.com>
In-Reply-To: <20241119031231.434471-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=20af2f95-213f-4c40-a6ad-4cfa0bbe7c3b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-19T05:55:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|DS0PR12MB8247:EE_
x-ms-office365-filtering-correlation-id: 271d5280-4b67-4c0a-eb2b-08dd085eca86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZukZnm98vfWixoAyGwf2FPMu6zMb+YqkeKweI7eGEO6yEHMFc5b2l8pcKjF9?=
 =?us-ascii?Q?l+3qhzwPdfitSrlJ1HUqCHuPcFzIZMSJQrCS4ANpoHEo4x5J2mv4ipUOBPfT?=
 =?us-ascii?Q?/ezUV0Ucv6xDtRKLzd6x6FPcz+0rwocZiLJibHxbod4k16G/SmnRAXTgNn5A?=
 =?us-ascii?Q?qJCKup8zx2NfeaSrYbCs9XTri3qzqsbLwEbZR83W4+sP97xYnv+igXY+J6Rr?=
 =?us-ascii?Q?LPBEIlvTEbc5NbXCOhA3Ky/8Y+YvYLQARdrGl7eaOZKd/OkwZX9MZL21Kpjl?=
 =?us-ascii?Q?8CbJ9HMt7+XjVkiK9OaSD2h++8XF0lGJw0B3UN9bMySZEOrhKbapwoiEHtL7?=
 =?us-ascii?Q?8J5soph+4XCV/cYrVw9ViZgOgeKioJIcepV9bBFG0p65cjvXWN6ydgC3Dfyi?=
 =?us-ascii?Q?gYIWEQ+rg+qP/+PESjoxpQOnM9KjZQUNdWDD1vyaqc+YVFnzcR14myRamJX+?=
 =?us-ascii?Q?EOtkichQoDiuZ5pYMebJbjqjj8T6/bpooCjErlu28GAx7mKX7kn2CoJrALP1?=
 =?us-ascii?Q?BgxzODipcCZgF3Vje3GEWVjORtZPtgFNEP44ccQajW+R07W1A3VIjGO8hTgs?=
 =?us-ascii?Q?UV5WaNgewyRhFRkKHlRVotyJ7Qe43rlpUorc35NTy/Xrs2XpuDckHZgfF5zb?=
 =?us-ascii?Q?QMMp1tkHb+fucuYWuE503Vr41E5/5L3obTzbjKTJk3wrKgHh/2HNb3YkXBdY?=
 =?us-ascii?Q?rYH0i3JVsJYkZaeEU0PB9rcqNpKCAmfSpWw12SdVCP8+W4e7ecHzTyYoXr5u?=
 =?us-ascii?Q?AhJyWeJrXGWg671qnaB81TxNWmxMsk1ekmodvnq55HNFnM3XSVrxHxz8QdbS?=
 =?us-ascii?Q?RyFvdVhQ4zhm1A1RURV2GLlHV/F7nKYFXNM9T/bLUaY9cyX/hzb0kaZRvNCm?=
 =?us-ascii?Q?l8d81aG54Ci6/Qvc12lYp0sCRrqPIjat29AqAF4kydrBRxQ265xoLrBSUasn?=
 =?us-ascii?Q?RLF40tQrwRf84xqjhE7zFIDLMszkHxx8SuPxEqUGWNoq6nEAMAnJHJCkmy79?=
 =?us-ascii?Q?va2ZgR0EdtquPi1KgCzra3WA7HaVYNFrLu7gcpUfgje7IYy2x0jOoLyOYz+K?=
 =?us-ascii?Q?NH09pBWMa11iINSwUhu15AGyDkDa593ft36CChOGUwGJ8bQz3EwxV5zy3lsT?=
 =?us-ascii?Q?lurXcAoFVkGU5ewa/FkD2+lgJSSWN//4eGKuYAv0F0MJ7DmH9xXcd/DfC0Pp?=
 =?us-ascii?Q?k1Dey8aL7o5fUJpfST/PSKdYgXqAFRPZFFGf8Qk4IIZufjmsTACWIjWCB7/r?=
 =?us-ascii?Q?drE6rfYy5nc2LgGo+4jVXcPPwEdwZcp0F7GvzNNOwZWlk38bgHAkD9PH+37t?=
 =?us-ascii?Q?v7MLeiUQeIZpHQ+emQY0ICvs/hPqt/Tita529Cqf1ueBM/xkMN69cdY5/kBP?=
 =?us-ascii?Q?nGQs8GE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NV2uBttJn7phU20AxLlAOHqzdp6vhotYMBaFfrR1UXb/HZC98O0cEOmGPh0r?=
 =?us-ascii?Q?u2uur4lONFL44kwx2QZKajJeIP8eo1ftaNPgeePBVRRSzrjXFBiZtlp+iX9b?=
 =?us-ascii?Q?ckVAOA6ry/YQKznu6ffJTPN4TL9+cLPzXKrRWyJqyOJSFzsqC5opkLCvDVxN?=
 =?us-ascii?Q?YP18Uv31+5Z+2xkPCeABGfQXyMPhMPA7r8rEnCdRra/IfXBid6FssOncpZ71?=
 =?us-ascii?Q?2HlymdkvXPYWUJBdzGy4l+XmdoWVZAW+ZDJKLuZnp+rOrpPwCHL7OJzbKLID?=
 =?us-ascii?Q?su36ty9OPO+RZRgHFJ7HXkgI08OYyywRG8kNmRtVHAPs2vZ6qmpL2i7vmVeS?=
 =?us-ascii?Q?JvZCpEtOrnOS/6esotodFXFvINFbirBuCbro6280s/F7MaxEZtm9NNzl4Uh6?=
 =?us-ascii?Q?qnOk0CL3LRcmvRtUP+QkMPCwwpuqGqiyM2ToDqRzPjwq8ubhMEyCvsi7XYmp?=
 =?us-ascii?Q?FSFG1M9LkIv9AwGkon9tulUaE4LlULs3v6nWgstneGCoAl0ajGZycdSw/O3u?=
 =?us-ascii?Q?5YgR4DJaFa/a2tlc/iVoRihH+NCWMEPEp2jtCCAbyEEMgwboxv+y+LTssgH3?=
 =?us-ascii?Q?2MrDyU3DhWoW3FPT5tniO6dq4gsQ4BwRaG45A35GlxHKFlwhs3l3N3oX0yxa?=
 =?us-ascii?Q?ERM1aWq1c07OFkTG1IU99C6y7RZvWT1nTJRVSFukYoGMvHld+gmm65OWlsRU?=
 =?us-ascii?Q?ptiqxbgkhoywrFWPkDzTBWbBugS1NV9l2Y6nurEYLSUPg0aFhBf+0DqkP/yu?=
 =?us-ascii?Q?gzLQl53T+/9gMs20pR4AGIgtzIxZXap9tgE56vaRP4jdsNFPntoidu3tQFbI?=
 =?us-ascii?Q?tWNfFLhx9TC1U5uxJNgFUL9SBBvqjyKrCM4GOHZ1s5ZqvqJO9g9RV3Mm6yIm?=
 =?us-ascii?Q?CXIddC9dgydLcaUPaU+qqsEbHXVR5/pJWhtL1+Q25nuSY/VHTV53qwaBALIl?=
 =?us-ascii?Q?5pEE/Xasp59n6MA2lHK3qBUhJCbIQu/OP8w/4A7n88CPS/YOpxeAIfLBvogq?=
 =?us-ascii?Q?QWbG1jZV05fGN4rt57P+slKjh7KNwsqbhtqFn/R/or/mwrCJ191c4P7O/lq/?=
 =?us-ascii?Q?5Mdj5dahuv1uckidgVPnz67MLV+90STSPk0JppJWCMhrUz92jYN0QXhsMBat?=
 =?us-ascii?Q?mqjqiXxVc99nrwEbirUc/PDI9OL6ya4O+dthfiEq0ZnomYQqEZYEbNS1tWuk?=
 =?us-ascii?Q?CQH8g9mR1kEnMkYSFm99Bl9f+jAl1AUZ2E5+LB8KpcuaoBUk9Jzb1Uu8Zt/W?=
 =?us-ascii?Q?oKIaLia6MWS0gfu4KjpJnmHF1h41p/HKOQYt+w2tsmd9baFvR9ZEc1I4XwYU?=
 =?us-ascii?Q?TYyDAeMTw4zFeoEpTaHiNBw/eAhZMmWChk69KFybKsvPgA2GE0n+Gv5NL0nL?=
 =?us-ascii?Q?/WqFmY+eFJoOiCJef1LIbk83TI3TulwByJYS9lkwfcCTR2EPBDcPb5c6n5TV?=
 =?us-ascii?Q?b1sOjbbUCNRg9J8bB8lUdHcUR6F2nZKOTHkxbLClSZZXYi0e0vvVy9BdPwyg?=
 =?us-ascii?Q?Bx7WGGvlROXwN7RaCH4VgP6EfO2xgo7GjElU9o+9snf4JABUGRu4WRaLH3vU?=
 =?us-ascii?Q?2zLxl3nsVRkxrAP5Yjg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271d5280-4b67-4c0a-eb2b-08dd085eca86
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 05:55:37.4193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtiIAj6D861exxqhWPTwN2T1VpyRSixG6yksJ6+HTudfW8YL1wxMuLRs4QgsJosh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Tuesday, November 19, 2024 11:13
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amdgpu/pm: add gen5 display to the user on smu v14.0.2=
/3

add gen5 display to the user on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 8 ++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 6 ++++--
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index c3a6b6f20455..5cba64996cdb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1714,7 +1714,9 @@ static int smu_smc_hw_setup(struct smu_context *smu)
                return ret;
        }

-       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
+       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5)
+               pcie_gen =3D 4;
+       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4=
)
                pcie_gen =3D 3;
        else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3=
)
                pcie_gen =3D 2;
@@ -1727,7 +1729,9 @@ static int smu_smc_hw_setup(struct smu_context *smu)
         * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
         * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
         */
-       if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
+       if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X32)
+               pcie_width =3D 7;
+       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
                pcie_width =3D 6;
        else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
                pcie_width =3D 5;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v14_0.h
index 0546b02e198d..29a4583db873 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -53,7 +53,7 @@
 #define CTF_OFFSET_MEM                 5

 extern const int decoded_link_speed[5]; -extern const int decoded_link_wid=
th[7];
+extern const int decoded_link_width[8];

 #define DECODE_GEN_SPEED(gen_speed_idx)                (decoded_link_speed=
[gen_speed_idx])
 #define DECODE_LANE_WIDTH(lane_width_idx)      (decoded_link_width[lane_wi=
dth_idx])
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 5460f8e62264..4d083f7f772e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -49,7 +49,7 @@
 #define regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0_BASE_IDX   0

 const int decoded_link_speed[5] =3D {1, 2, 3, 4, 5}; -const int decoded_li=
nk_width[7] =3D {0, 1, 2, 4, 8, 12, 16};
+const int decoded_link_width[8] =3D {0, 1, 2, 4, 8, 12, 16, 32};
 /*
  * DO NOT use these for err/warn/info/debug messages.
  * Use dev_err, dev_warn, dev_info and dev_dbg instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..5e2629219280 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1173,13 +1173,15 @@ static int smu_v14_0_2_print_clk_levels(struct smu_=
context *smu,
                                        (pcie_table->pcie_gen[i] =3D=3D 0) =
? "2.5GT/s," :
                                        (pcie_table->pcie_gen[i] =3D=3D 1) =
? "5.0GT/s," :
                                        (pcie_table->pcie_gen[i] =3D=3D 2) =
? "8.0GT/s," :
-                                       (pcie_table->pcie_gen[i] =3D=3D 3) =
? "16.0GT/s," : "",
+                                       (pcie_table->pcie_gen[i] =3D=3D 3) =
? "16.0GT/s," :
+                                       (pcie_table->pcie_gen[i] =3D=3D 4) =
? "32.0GT/s," : "",
                                        (pcie_table->pcie_lane[i] =3D=3D 1)=
 ? "x1" :
                                        (pcie_table->pcie_lane[i] =3D=3D 2)=
 ? "x2" :
                                        (pcie_table->pcie_lane[i] =3D=3D 3)=
 ? "x4" :
                                        (pcie_table->pcie_lane[i] =3D=3D 4)=
 ? "x8" :
                                        (pcie_table->pcie_lane[i] =3D=3D 5)=
 ? "x12" :
-                                       (pcie_table->pcie_lane[i] =3D=3D 6)=
 ? "x16" : "",
+                                       (pcie_table->pcie_lane[i] =3D=3D 6)=
 ? "x16" :
+                                       (pcie_table->pcie_lane[i] =3D=3D 7)=
 ? "x32" : "",
                                        pcie_table->clk_freq[i],
                                        (gen_speed =3D=3D DECODE_GEN_SPEED(=
pcie_table->pcie_gen[i])) &&
                                        (lane_width =3D=3D DECODE_LANE_WIDT=
H(pcie_table->pcie_lane[i])) ?
--
2.34.1


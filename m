Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC1EC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 08:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7204D10E301;
	Thu, 20 Jun 2024 08:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O5u8wY2h";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBBF10E301
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 08:30:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehCfM4vF9V6sc0B5KBfNI7Lq1ThdRS03pqek2SVP3LlGwZOh5JhvJ8036nBRENfBqyH8piNjwBKsfHNM6NcziJ0ih0aD+hRDvI08uc8uWbYnNNoCyR4DM8+IEglm5jFmL0/S3I32+f/n6tLRNPYEokdCqQgMo3HeEEX54CFkBOWY7WtNGf01FGORkiBAqEclJ/Gw81FpjiJGxWPwvbHZknDAc0ooUVSHB9RtxMngONEKS80XWayKgpQQfHDa2VILtGwRrRa1iXiprHice+oIgKm/veOy/p9OYg6ewTs8ofrNP9AmOBsUHxZFxqrs7eZIxMuUS+z3QepxddbOGpfr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBIKwand2qq1shYHoKd2i0JaqmFQ3Qys3yVVE7JBiaI=;
 b=m69VCmLwv+earer9HOCSb1n2mGHiHfz1RcieZKoPsFddNppkzbBNjGfU8nv7xFXkskTxpCT5R+z34zNaNeYdxa1+xYL1pJAtQ7dNcpQQiGwYluyiYO3acY2fHrQmAWLwxKUdPlJCC545ZuIOdNWEkcY5ld5f0nB9mmm5ptqVhF3ZA+Ufc12QTaG1AsWk/xKLSMHfFfRFi8Yr0en+9wsPaZP/z4/xi7ROo2bYTWcu1KmYtqTaFEPhF/37SLTb1G9rnJYH+iIR73UbjBUsV6aBvA8K1RHK1WFP1UAN0VQeFMGHo1yyt1VJRsZgS+JtvK2e2VuhevjnrSEoHiC+LcNG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBIKwand2qq1shYHoKd2i0JaqmFQ3Qys3yVVE7JBiaI=;
 b=O5u8wY2hJyaCgEsEFwG+TSxkpaML+DZBBvPdkPAsO542NleeUVfJuxZloUbtp6Bytu9/S56zHZ2sdQW/O3YIv+KTWlpDrVku+lQUaIHw2PhlmahzGEIsT1JXssgXpekNsFoEO2aQaQIAAK2wmkEUd1cG3+uCOGoyXuMRN3vozxE=
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Thu, 20 Jun 2024 08:30:22 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 08:30:22 +0000
From: "Jian, Jane" <Jane.Jian@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: part I - normalize registers as local xcc to
 read/write under sriov in TLB
Thread-Topic: [PATCH] drm/amdgpu: part I - normalize registers as local xcc to
 read/write under sriov in TLB
Thread-Index: AQHawmYxs6WoUaWdwEyf2mnRvs1cBrHQUmDA
Date: Thu, 20 Jun 2024 08:30:21 +0000
Message-ID: <PH0PR12MB5481FA3F031247E1205CF74FFFC82@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240619163147.1706778-1-Jane.Jian@amd.com>
In-Reply-To: <20240619163147.1706778-1-Jane.Jian@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=facb06e7-5ff9-41d2-a903-29d3c12d7fb0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-20T08:26:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6256:EE_
x-ms-office365-filtering-correlation-id: 88251fb9-095c-4c02-219a-08dc910339c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?4SCuMpkSshVttXpU1azcp8pUoFkl1h+C/KLqa7L5YN1FRHvfRbs7BV1xLmTs?=
 =?us-ascii?Q?RCaJPvqLB9cPRHnjy6HhoRHsEEfp9Z5KtmAGWrrKWApxXAbVGiHJwuikwSpX?=
 =?us-ascii?Q?dkCYqjIbwvi+LX1rrajLaDXekOUcTZEgX4DZ4RlkvNMAkyoxPlpzeSeq7k1y?=
 =?us-ascii?Q?E9dtNJNuI1MogWqvms7bZI1GLIh+pGfcEvAx0Il4H4qpJUnyeP3o0maxhaeO?=
 =?us-ascii?Q?KbbRjxYe+gUPEpeQVyt2InrIjAWAHRsU7t/K3/MsKwwgl2S6HtHe7ml6lv7p?=
 =?us-ascii?Q?uapDnrexysSi53Ks7qUbF7qBGDOfeeHFHxl0Src4K0hbjiofVinDaCLA0Gpb?=
 =?us-ascii?Q?qtnE+EzlfqU4vDp5c3W01x2MSyk6R1sYpyhz07lsVY/4iVtG/vNNcNR3a5tQ?=
 =?us-ascii?Q?gB3uG4XGSRU8rVBpie3gyTktJ5WQexCg16VBPYfQcHxXBaZmy7jMeEV1+D6K?=
 =?us-ascii?Q?0nLxadjf/s2Ly/G+C6O9ks3rP43xX1SEPowV/R8mzZeZVXCvdgWbbRUohYnQ?=
 =?us-ascii?Q?nsrSeqN/dfZLU9532i6SDzwCbnf235vSYnlpckvvp5i5uxfVIdwL1c3Wi6bH?=
 =?us-ascii?Q?KraB4P4UJxQqGdWneuPCsgzC1Ixhtt5ZV0Ypua6/ernOn3DbrwB6Su+S1ZNB?=
 =?us-ascii?Q?mg7cbi6hQRiDFC1fvT8nPEgMwERHvZELJ1O4M9ET8m/S7eEuIzs/KxQEXALj?=
 =?us-ascii?Q?I8ITesaZ6DvoV47zlEZo7rLe3Rron/TajkqSn95nO+SeqZ4VzErbmo7FaO18?=
 =?us-ascii?Q?ITmozz9VMan/ZFAQM5MqkL90tiimG+IOwatvDlJxC7VikFjCMdbLbTG0CiU7?=
 =?us-ascii?Q?mVNPld+Ct1v5CnUvfcpRP7pZX3N/t6JZbHM6Yl9871fHR9XCp+0tn+tyHJoQ?=
 =?us-ascii?Q?ZrutusGSxxUf8nrzCchHv+9Db7kE8OvygGgDYZyVzm2e3hxBSM+u/Ko0LQT6?=
 =?us-ascii?Q?+U4GSfl4rjjXrEsTRB5Sg5EzIc/yLrXc4wzoxuqhtVG3gb3i/zpuAy8WQ1Sh?=
 =?us-ascii?Q?py2y1svtbW3CXEseYeCPiEqfEpDMPClM8rwXflHnLC0/b1zOHDI5ui8jNOGt?=
 =?us-ascii?Q?qPuzjr13Leyjn4pNlduir9z1uL2SzAidsBTTBDGOGXlDNDh+5LGeZMA78BaH?=
 =?us-ascii?Q?wNXi5CuRCCgynHwFN1s8JKvX0Q9Ep55c+elmHALVVsolK8LrURHmeTa5pXJQ?=
 =?us-ascii?Q?EQbDd9XtY4gYsG5dKLwPm7GetFUJ4ssKRAZc3+OSJrdShqp1vflT6dsGP8fl?=
 =?us-ascii?Q?53AkA1U2Y0DziKuaGnHKfwViVHcM8Oo7E/kn6x9Jx7exyWcMVeL5Yt4L5C+v?=
 =?us-ascii?Q?Isu5ejg6nz+KrApkNUATuNsqs52RrKyCtIHrfKYFX7B7KHCPlIzyCsbc1ec4?=
 =?us-ascii?Q?n7Ifi10=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mj8TRVqAhADNrClijkNLCvkKybGsreaUKIwI6Uw/45HYICwTCfmCg9PISd2H?=
 =?us-ascii?Q?iVQpZ6Ukn5FDu/AeQiA1JNYXkrI8kpg2xhKq7RtdVMfyudplWoZI9cMwqIUx?=
 =?us-ascii?Q?fWk/LZtyT+k5igXN4/rFAryEApYf0IAlPuhnLiUq0D+5vwIh3V91Dlz3fdgb?=
 =?us-ascii?Q?+fO9Tje/hY4qG4FqvKZ+jQH6RC/QF4AYAxguraj+eePqWOkcF/dJghzqNfnT?=
 =?us-ascii?Q?WLCRKNLc/7W0B9dKMCA1KkHc8Bgd1KJHcCfA31bJXd6IaWyG8PG65hlHMxrf?=
 =?us-ascii?Q?yBx94NZyv9OZrCjWwaXno7GEovRZs8d5tsXArFlFV1yRQNENEhU1koR0Qp3t?=
 =?us-ascii?Q?csNnYEKWhGBqhhsC252iuhHn2hMDIgqfoWgndga47XnbrtypkFPQlZsh4R3Z?=
 =?us-ascii?Q?W80y+hPEAViSaWoC4E59ppW8zrSvXgDtX7N3FqqVZwJBpRjAp1LQYdGRAZbz?=
 =?us-ascii?Q?NBtOqFD3Of4dFC9+eBUZXkgw3motjETtf9Wc7nlqEWvZgmZfLiBnPbizOKrB?=
 =?us-ascii?Q?bSttFvgTzAJ0CTYHnyBzpyEsUdKWgnLC/aFoPeB/NjRBqd5qLu+ocj3DGRuO?=
 =?us-ascii?Q?kJlJdw0NAWtz4rtHxI3LAtdHEQ7+aOJcyDzIUCZtk2fuywKxf8iAUffTwc2V?=
 =?us-ascii?Q?FmqQrijK39iuNRh/rxxWq38o2RyqSRDY9elf6H1qEqSANU+2vlfDefHPObAf?=
 =?us-ascii?Q?P26B0tCEibKIteTl7m6NIOGwqlh/5WQDmC7Hdhw3mrBIRZq+yJ2TZjRd5+W+?=
 =?us-ascii?Q?wxLSNVBZVfr/O06a+eXLhb6syUZzDWVdScDhSpXTaSCSftCnTg5/YNlP2/Ke?=
 =?us-ascii?Q?GOJX/qV188SC/VxYjxb6Xj/sGaCb15xme2lG5FQckxwow7+EPXxnJE03ry4X?=
 =?us-ascii?Q?Qb0BJY0E8jg8fSynnfXKQwZ7uSvtBHdTVjXFbOEHLr5pMzBiaUef2AbjovJs?=
 =?us-ascii?Q?FLozSjykgPS4fNNqYr5xDL2SeR4VWbp8Db/gwuhJjOFUGeB9lhjH2kTzy6Td?=
 =?us-ascii?Q?mKjFAbBjhjE3ZtJgaNroMiMB2FPMKgyruHlgJCPFGAep/BiE8YM/ZZrH/Ck3?=
 =?us-ascii?Q?jms/NxCG+yZJAM3IWWid9ftFeBTb5DCke/RgqsTDWKxiasOsmKWaTdnPDqsJ?=
 =?us-ascii?Q?rs611IHsym2ozDjN+CGd95vFiVCNe3FeLUjDmPI9MlEYoXx0vNOyL7V4DKJo?=
 =?us-ascii?Q?NzslRFd5xWtZM5vkfIHWikyh9xNzsiVP1gdwuywBvzuyNtqSobKSLOikY7hE?=
 =?us-ascii?Q?pJf1Zm2+ncZALynIfwCe06mGgXRJVdkXBjKknKuFJ9BJuj8rSbejg7emTEaM?=
 =?us-ascii?Q?Ez1ata74mWlliLsSYf51a2xstHyIwUKo4qSMTx8IKVQS/YLiG8g6e14N0sa9?=
 =?us-ascii?Q?qOT+bpmQoeqdqDXmpbEaxAUm5rFAN/KFEw53td9sCr4L8USJsl84TfSgrt1a?=
 =?us-ascii?Q?LdG6mTazy9x3M+7PYxlNqJf8XlK4bI642vnXfuEgzq3pGbCosmGt87kftzPX?=
 =?us-ascii?Q?bM0f9oq+dp5Qt5ZctiAxYr2eOEeZZFtOhNnURVmjw5LjPwAL7PANfvCxU1lD?=
 =?us-ascii?Q?gJ5umeYphwshjvMpXxM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88251fb9-095c-4c02-219a-08dc910339c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 08:30:21.9481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybOlNq5QaWxvWLtu9hWAAu4J0SPSbPGKbLF8LvNzs6veS/l9ZBtC8GSUSjGaASnO+ALXtqb4MyekLbK9i+mJvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
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

Ping for this.
Thanks,
Jane

-----Original Message-----
From: Jane Jian <Jane.Jian@amd.com>
Sent: Thursday, June 20, 2024 12:32 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Jian, Jane <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: part I - normalize registers as local xcc to r=
ead/write under sriov in TLB

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher=
 bit violation RLCG will mask xcd out and always assume it's accessing its =
own xcd

[TODO]
later will add the normalization in sriovw/rreg after fixing bugs

v2
rename the normalized macro, add ip block type for further use

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  5 ++++-
 6 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 083f353cff6e..eb2e7312bf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -636,6 +636,8 @@ struct amdgpu_asic_funcs {
        ssize_t (*get_reg_state)(struct amdgpu_device *adev,
                                 enum amdgpu_reg_state reg_state, void *buf=
,
                                 size_t max_size);
+       /* normalize offset to keep in lower 16-bit */
+       u32 (*normalize_reg_offset)(u32 hwip, u32 offset);
 };

 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index 2c9a0aa41e2d..9b4bea2ca7df 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -1085,3 +1085,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_de=
vice *adev,

        return size;
 }
+
+u32 aqua_vanjaram_normalize_reg_offset(u32 hwip, u32 offset) {
+       u32 normalized_offset;
+
+       switch (hwip) {
+       case GC_HWIP:
+               normalized_offset =3D offset & 0xffff;
+               break;
+       default:
+               normalized_offset =3D offset;
+               break;
+       }
+
+       return normalized_offset;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 88b4644f8e96..1d24e19f304d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,14 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
         */
        if (adev->gfx.kiq[inst].ring.sched.ready &&
            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-               uint32_t req =3D hub->vm_inv_eng0_req + hub->eng_distance *=
 eng;
-               uint32_t ack =3D hub->vm_inv_eng0_ack + hub->eng_distance *=
 eng;
+
+               /* Select lower 16 bits to write in local xcc
+                * for MMHUB it uses xcc0, NO cross AID reg offset
+                */
+               if (AMDGPU_IS_GFXHUB(vmhub)) {
+                       req =3D NORMALIZE_XCC_REG_OFFSET(GC, req);
+                       ack =3D NORMALIZE_XCC_REG_OFFSET(GC, ack);
+               }

                amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
                                                 1 << vmid, inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 8d16dacdc172..e6e61fc77080 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -927,6 +927,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asi=
c_funcs =3D
        .query_video_codecs =3D &soc15_query_video_codecs,
        .encode_ext_smn_addressing =3D &aqua_vanjaram_encode_ext_smn_addres=
sing,
        .get_reg_state =3D &aqua_vanjaram_get_reg_state,
+       .normalize_reg_offset =3D &aqua_vanjaram_normalize_reg_offset,
 };

 static int soc15_common_early_init(void *handle) diff --git a/drivers/gpu/=
drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 282584a48be0..f1e974604e3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -124,4 +124,5 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_devic=
e *adev,  void vega10_doorbell_index_init(struct amdgpu_device *adev);  voi=
d vega20_doorbell_index_init(struct amdgpu_device *adev);  void aqua_vanjar=
am_doorbell_index_init(struct amdgpu_device *adev);
+u32 aqua_vanjaram_normalize_reg_offset(u32 hwip, u32 offset);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/am=
d/amdgpu/soc15_common.h
index 242b24f73c17..ddf0aad51821 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,7 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
        WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + =
mca_base + (idx * 8), val)

-#endif
+#define NORMALIZE_XCC_REG_OFFSET(ip, offset) \
+       ((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) =
? \
+       adev->asic_funcs->normalize_reg_offset(ip##_HWIP, offset) : offset)
+#endif
\ No newline at end of file
--
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7A9C2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 08:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB76110E1D7;
	Tue,  9 Jul 2024 08:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SCWDcDkk";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690E910E1D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 08:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaWr5m15mP4efhXGYVC5Hfh3sTYEVihJ1Wd61gHfEI5fMkZ8+uIazjefqbTQGWEDsiOkVvhSit5eLf71qv2wbVujrdks3ECtdKLDViIBMeCsYcFBrG3dTlQoVHmdAQ/biARE0M25eImUd/wuIlUTmkqCH5K4ksBxRmZI0Uq8YnTZKfso/bZXV3bCxpOTVkNA5FEljDz2bvMt25eulJ1th47zbLzaX6+CptKLIrIK2YwhPNAMxzNwyxwHr9SZIHVUHaE15maa2Viipm4zTJJVciu40dLqF47IPxaVITOGtjdaPR2XuT6sg7mHgxCxS6TltKzfhmyT32e6QGsYyY5rRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PFpf9+gCiM1CoghHO0H9VdGys8QtyEl1ZsR+bpuSLc=;
 b=BU6sS/hank7C4rTf/vdZ9jsxbV5lNpWw5ZqsVwjRK8RIM777mK4yIJgT4Q2PwzlL/1oWRE1tMcAV/8gTi1bMB+Zpo7e8ylqVreXm6YorfvWFvpP3kady3K1IcfYeUD9xLEHb5+eGquj/xjQKvFpA5qsCjIwA6mkApzJif3o6SXihTfGYk883Dm7XT72T0CeXC9HN66fkBRWquUVV5VdRXkmbaQ9L5vsD9y5lgNltd3aFimVt6+IrpTciXxeAcHtn378Rvypv1INfJzX9UBPJ1Xjh5lWTYYTq/lVfPrvuHfZy9ptTjKg7oKhQ0WmPw7wV9XjREt9dDKm8oB/8Co7dng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PFpf9+gCiM1CoghHO0H9VdGys8QtyEl1ZsR+bpuSLc=;
 b=SCWDcDkky8UsyuGd1OrqSvRSHL4wdvecK3Bd0N3clx+LY4B1iQ6XMcvf3uBo8Pjj4tvMrurRQ/bjSqy+k5wZ0XJSLnxWWcQy+3Kbw2LfswuBIsZDMh/VB3o59niPLuZjGz44t6JMvC+kWYuNnJ1BmLGSxxyfHHNnk8pHd9HlhRc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:29:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:29:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Thadvai, Satya"
 <Satya.Thadvai@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Shi,
 Lianjie" <Lianjie.Shi@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Initialize VF partition mode
Thread-Topic: [PATCH] drm/amdgpu: Initialize VF partition mode
Thread-Index: AQHa0b9XfADh4BxkxU+G6qU/DIUEfbHuEItQ
Date: Tue, 9 Jul 2024 08:29:06 +0000
Message-ID: <BN9PR12MB52570B1177BAE6A1D672A491FCDB2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240709051729.1364475-1-lijo.lazar@amd.com>
In-Reply-To: <20240709051729.1364475-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0dd9cee2-4adf-4a0d-93f6-ce8174ecdc8a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-09T08:28:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CYXPR12MB9277:EE_
x-ms-office365-filtering-correlation-id: 32a1415a-5121-4458-4399-08dc9ff1326f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?sfKlHFdMa3dl0jyCDErNbd42AG9JUHKnDGKmwIpu1fP/avcCx6B2BBYD20xc?=
 =?us-ascii?Q?Wcev5Mf7oWrDz4puogUpx4RzKFqj0E7eqx1SzdVVp92P0BaqJxqSFXmD4p8B?=
 =?us-ascii?Q?F36IGXNZMLvgYoN43Yg8ShRlOMed+P7I/imV2258IARh9Zlm8zaKLXNnBkAC?=
 =?us-ascii?Q?bZX4OYBx09G1RBXO8tG/RWKKXTFSeJLegRfLWo/cqzY6WTvbktdK6bYVbDCn?=
 =?us-ascii?Q?8moNPV4zXZEV+POIg3f5A5hsR+BvyUeReAcASPABkfjTfN8DRktbm3X68/9e?=
 =?us-ascii?Q?lMhVVPv9P1eob5gm7OXbMj62eHLmdyqmugJe/xA0/5gSvnne2awgFpMvS1Hb?=
 =?us-ascii?Q?JrXwjmYMplai29EPB+UyKSPDQI6FKQAnexToxcE3OLkPbkgC9HOOvSACKrPO?=
 =?us-ascii?Q?GLXJ+tVzc8EO3mhMU1pF0LLrFPsaG57uUWpzMC/vnOoUyNjYjicHfGdofQKK?=
 =?us-ascii?Q?mrAPukbhld7fDtO6n3kN+5DeaSRcCyqesL9H7Y/No9t8VfqTsWbqgBB72nYj?=
 =?us-ascii?Q?+N1uwqKQjN1izRWmKSzPBGr8cpmGn4i5t+aapNq92lBOZ9wTNRCuwsKTUs0s?=
 =?us-ascii?Q?5So/8AZ86SGmbbQUdh89GyaQ4eWqd4bWMyXPk1SVGsVxCbnDFdFbG/oxpfv6?=
 =?us-ascii?Q?D9P4RwF4gD9rh1aOWRYi0ov2w3u5jdMuVsOOvpRFcXjJ5ucxjE+NsVyhgt7c?=
 =?us-ascii?Q?UqwVDYiqBnyeP86n1G5qe5S85n6rSpEYbMDlnHo23VaauTFnSlCc1cw96yXU?=
 =?us-ascii?Q?jCSTjXnRgDVrRu5VMBw0PLTfKXZo2FQY4SvQPlCokJ2Z7823o0+Of5tW4qkW?=
 =?us-ascii?Q?W2Gh3fRgUY8Sirk7zdJeP1hhd5E+vijmSYMYG2ZhwXmZSICjWq68ETsKmLnA?=
 =?us-ascii?Q?MEU2DyA81Rr6ytywFx7ffd4+JyRbz2IxNGFIm5+WjkunZFphuD5UFNkKDuz1?=
 =?us-ascii?Q?rUAuX7BnGuPrtXVo1ZZhyt47Po6H3uM0YJhT/HXR9GXbQw9aJxZ1XVCVIoFR?=
 =?us-ascii?Q?dF0ULULwljcFiXuPNIFyt0aTksELzlAfdA4G6j/ICIxwhieplj67WYqYpRUj?=
 =?us-ascii?Q?g+/Ho1kjXt9+kXN/AMyXW7ii0hw9xQRFQZaF8EQ0Xy9mVw8BW/YSRILzi8DO?=
 =?us-ascii?Q?UwI131Cs6rn/bniWTUbzE5gkHnVB2hZDskhIqSwPadqGtIU0nc1rKr9h/Zoi?=
 =?us-ascii?Q?nu9l4atPS1bSeepEAIx6fwdqvaKBMHXDja2HcuCDOTsobpsIubxWYSN/PW0N?=
 =?us-ascii?Q?/A4oR1P6uNB6gopVCF5giAieDU1q4EcJblTO1Zn8mHSXDEo/qRY9j5L3sIAA?=
 =?us-ascii?Q?r4XtBjVZtS/svpuP2Naf2LEW6HMhURuSNLDmOE/qHTeT/Eu+FrHigYYWpsdN?=
 =?us-ascii?Q?AZadqVxvzUvwtoziGhU2/xW/l0UGBDi1WpXNH9loKfaMev8oNA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3HwZ4ipvAonQkSOwL1Hg0k+h1i77+22BxmTGtVlqdc2+OaNR0GbqMCYsIj6b?=
 =?us-ascii?Q?+AE9RCRERi0P+frXhbIw7BP4/3MVnt4o8uyGfO+7kZtSOstfgdAF9QY98qu8?=
 =?us-ascii?Q?BDq6zJy8yfvwQo3l4ko8TKzPP2Q4MAAYYOCmBdnEWqZ2m1yWtg+liUVe3IY5?=
 =?us-ascii?Q?0zmcg8+U7ZUUso4KsnikOlBIWzpU9nI7YLHUzGqnyB2PQMrGGSClcP8LepIe?=
 =?us-ascii?Q?LhrRbCDLBVOsqtomnVeImWnuxhi2mTXclgJv1xgXVqOckXLLlBABWYrasws3?=
 =?us-ascii?Q?BhB2qjHslucXY8tlrI/cwhOezHOvm8wUMEaGl5V0UUKy2W83RHnub7Ol7E/j?=
 =?us-ascii?Q?f5v0QUGglRIzQCgphqOmg8WtCHoPkaMwzPa0RI3Svf+K+dF8qwod352YrSpM?=
 =?us-ascii?Q?+bIPoWwsjS7dtC0JAqkB1kAZcZUa5ONpUxjcMWdOdHm98dBedr7xCSNSp7JW?=
 =?us-ascii?Q?oHEvZ1+p4gdSUx6Mnmb/pYRSkmqZRi8xHeTHmwrJYm99XFhI902f40RPFiG1?=
 =?us-ascii?Q?vZf1oZyQ7zidcwrJqxg8KTJxOnYpnCBc5VnMs0/Sl73MTNudIM18ehAkHRkM?=
 =?us-ascii?Q?4SwsdHs2ao+0UJDyjYCrLbBc3WHx8L+Y33tVIvWgfPP4sc9ECaUQ1CqnKfi8?=
 =?us-ascii?Q?Jr//EPgfr9h2oIGgGHhEdNPcFYB6v28flZ4QKKalt14fTv3WuRdaaBynZ6ZC?=
 =?us-ascii?Q?ydoeahC6XR5dJPQIDV1awBtLpV7k+GtDbFgi6k7z25m54hkgUleUjE1FdrIx?=
 =?us-ascii?Q?Qsy33XI1nzfhIbrY8mpPHGUSESlqtWFKjNK4lxEBiiYl2J7QCRs4yra/wbyj?=
 =?us-ascii?Q?uWnpUZO9SpbU/0OZx0xYCJIlW6Xaljp4RYwIxJmbmBUgS9dsNXRXHcfvuiuG?=
 =?us-ascii?Q?IxllVym1pbzFAxfiGoin2reigWzESjTP0O89iu//9CZitEHdAF+j2Fxyu8sJ?=
 =?us-ascii?Q?GnLwiJfg2IRce/geaye7RkdU33/B7sJIIMP9ZQmSRU3kSD7Dd4fSSracSS/n?=
 =?us-ascii?Q?s5OeG+1ZFgJkMS7ATnI8nzRRoALINrejIW/Xady6Kj62FkRr/pg8YfaK5TNP?=
 =?us-ascii?Q?Z32Mf3DuLu7JPCNsXHo4RsOZbOZIHIbgMjONFewse1kSAMOKWzJm2KivDv4z?=
 =?us-ascii?Q?rdvCEt92gZ1q7eTsfKZyyWfeRT7tBVldT40Be53fNJpFFv3F7HTz64n2sn6l?=
 =?us-ascii?Q?i9j864UBr21OZbQ5v/hZtCc/3eHUrIp5J/NZSp+l7pQPXb85MqC8NNGoSh7G?=
 =?us-ascii?Q?oUiVHYDkxhYdSqz0DU2x72uvFiXSve1vNPc7AQhl2n1hbkTwRoFBtoLgMQed?=
 =?us-ascii?Q?g427Eq4MAPNObyh8dSit6lD636f9+3GKr+33fuxL+OLETgOhNa+Nfahsg2yd?=
 =?us-ascii?Q?34EOrPYZetvtYAInaXHSBxEYwWe78wLyRC4dpWy1ot45wOfD6CoAOKJ08Ouo?=
 =?us-ascii?Q?hSxrCL4W4+fRGLxcwXSncw/eBtk1gnMYRjaSSyIF40mAZisU90DvTt6/ve85?=
 =?us-ascii?Q?shmsSR/qoT1SdbmOR68MC7Eit7nF9HTLL78tIUeW9lpOBo0tq7b9TZHlLbz7?=
 =?us-ascii?Q?HLNCxxHOUZ22mYJIfCGpo2oghqcv6ij7a4ZgN9Xw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a1415a-5121-4458-4399-08dc9ff1326f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 08:29:06.1725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKt5Po3RgOp141OUKQ2C7rSb1W9MbqB7Qb0xDeLkrTXn+z5MWOtBdBDZJCFu/fZvXY89mdmfKpbw5UvG9rVrvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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
Sent: Tuesday, July 9, 2024 13:17
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Thadvai, Satya <Satya.Thadvai@amd.com>; Chang, HaiJun <Hai=
Jun.Chang@amd.com>; Shi, Lianjie <Lianjie.Shi@amd.com>
Subject: [PATCH] drm/amdgpu: Initialize VF partition mode

For SOCs with GFX v9.4.3, a VF may have multiple compute partitions.
Fetch the partition information during init and initialize partition nodes.=
 There is no support to switch partition mode in VF mode, hence disable the=
 same.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 12 ++++--
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 50 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 37 +++++++++++++---
 4 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index 6b0416777c5b..ddda94e49db4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -297,6 +297,7 @@ struct amdgpu_gfx_funcs {
        int (*switch_partition_mode)(struct amdgpu_device *adev,
                                     int num_xccs_per_xcp);
        int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_no=
de);
+       int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
 };

 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index 2b99eed5ba19..a6d456ec6aeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -219,7 +219,8 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_m=
gr *xcp_mgr, u32 flags)  {
        int mode;

-       if (xcp_mgr->mode =3D=3D AMDGPU_XCP_MODE_NONE)
+       if (!amdgpu_sriov_vf(xcp_mgr->adev) &&
+           xcp_mgr->mode =3D=3D AMDGPU_XCP_MODE_NONE)
                return xcp_mgr->mode;

        if (!xcp_mgr->funcs || !xcp_mgr->funcs->query_partition_mode)
@@ -228,6 +229,12 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_=
mgr *xcp_mgr, u32 flags)
        if (!(flags & AMDGPU_XCP_FL_LOCKED))
                mutex_lock(&xcp_mgr->xcp_lock);
        mode =3D xcp_mgr->funcs->query_partition_mode(xcp_mgr);
+
+       /* First time query for VF, set the mode here */
+       if (amdgpu_sriov_vf(xcp_mgr->adev) &&
+           xcp_mgr->mode =3D=3D AMDGPU_XCP_MODE_NONE)
+               xcp_mgr->mode =3D mode;
+
        if (xcp_mgr->mode !=3D AMDGPU_XCP_MODE_TRANS && mode !=3D xcp_mgr->=
mode)
                dev_WARN(
                        xcp_mgr->adev->dev,
@@ -282,8 +289,7 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int=
 init_mode,  {
        struct amdgpu_xcp_mgr *xcp_mgr;

-       if (!xcp_funcs || !xcp_funcs->switch_partition_mode ||
-           !xcp_funcs->get_ip_details)
+       if (!xcp_funcs || !xcp_funcs->get_ip_details)
                return -EINVAL;

        xcp_mgr =3D kzalloc(sizeof(*xcp_mgr), GFP_KERNEL); diff --git a/dri=
vers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_v=
anjaram.c
index 2c9a0aa41e2d..228fd4dd32f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -304,13 +304,56 @@ u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_i=
d)
        return ext_offset;
 }

+static enum amdgpu_gfx_partition
+__aqua_vanjaram_calc_xcp_mode(struct amdgpu_xcp_mgr *xcp_mgr) {
+       struct amdgpu_device *adev =3D xcp_mgr->adev;
+       int num_xcc, num_xcc_per_xcp =3D 0, mode =3D 0;
+
+       num_xcc =3D NUM_XCC(xcp_mgr->adev->gfx.xcc_mask);
+       if (adev->gfx.funcs->get_xccs_per_xcp)
+               num_xcc_per_xcp =3D adev->gfx.funcs->get_xccs_per_xcp(adev)=
;
+       if ((num_xcc_per_xcp) && (num_xcc % num_xcc_per_xcp =3D=3D 0))
+               mode =3D num_xcc / num_xcc_per_xcp;
+
+       if (num_xcc_per_xcp =3D=3D 1)
+               return AMDGPU_CPX_PARTITION_MODE;
+
+       switch (mode) {
+       case 1:
+               return AMDGPU_SPX_PARTITION_MODE;
+       case 2:
+               return AMDGPU_DPX_PARTITION_MODE;
+       case 3:
+               return AMDGPU_TPX_PARTITION_MODE;
+       case 4:
+               return AMDGPU_QPX_PARTITION_MODE;
+       default:
+               return AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+       }
+
+       return AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+}
+
 static int aqua_vanjaram_query_partition_mode(struct amdgpu_xcp_mgr *xcp_m=
gr)  {
-       enum amdgpu_gfx_partition mode =3D AMDGPU_UNKNOWN_COMPUTE_PARTITION=
_MODE;
+       enum amdgpu_gfx_partition derv_mode,
+               mode =3D AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
        struct amdgpu_device *adev =3D xcp_mgr->adev;

-       if (adev->nbio.funcs->get_compute_partition_mode)
+       derv_mode =3D __aqua_vanjaram_calc_xcp_mode(xcp_mgr);
+
+       if (amdgpu_sriov_vf(adev))
+               return derv_mode;
+
+       if (adev->nbio.funcs->get_compute_partition_mode) {
                mode =3D adev->nbio.funcs->get_compute_partition_mode(adev)=
;
+               if (mode !=3D derv_mode)
+                       dev_warn(
+                               adev->dev,
+                               "Mismatch in compute partition mode - repor=
ted : %d derived : %d",
+                               mode, derv_mode);
+       }

        return mode;
 }
@@ -624,6 +667,9 @@ static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_dev=
ice *adev)  {
        int ret;

+       if (amdgpu_sriov_vf(adev))
+               aqua_vanjaram_xcp_funcs.switch_partition_mode =3D NULL;
+
        ret =3D amdgpu_xcp_mgr_init(adev, AMDGPU_UNKNOWN_COMPUTE_PARTITION_=
MODE, 1,
                                  &aqua_vanjaram_xcp_funcs);
        if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c908e585b9ec..20ea6cb01edf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -652,6 +652,15 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_=
device *adev,
        soc15_grbm_select(adev, me, pipe, q, vm, GET_INST(GC, xcc_id));  }

+static int gfx_v9_4_3_get_xccs_per_xcp(struct amdgpu_device *adev) {
+       u32 xcp_ctl;
+
+       /* Value is expected to be the same on all, fetch from first instan=
ce */
+       xcp_ctl =3D RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HYP_XCP_CTL);
+
+       return REG_GET_FIELD(xcp_ctl, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP); }

 static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
                                                int num_xccs_per_xcp)
@@ -706,6 +715,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_fun=
cs =3D {
        .select_me_pipe_q =3D &gfx_v9_4_3_select_me_pipe_q,
        .switch_partition_mode =3D &gfx_v9_4_3_switch_compute_partition,
        .ih_node_to_logical_xcc =3D &gfx_v9_4_3_ih_to_xcc_inst,
+       .get_xccs_per_xcp =3D &gfx_v9_4_3_get_xccs_per_xcp,
 };

 static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle, @@ -2050,=
18 +2060,31 @@ static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *ad=
ev, int xcc_id)

 static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)  {
-       int r =3D 0, i, num_xcc;
+       int r =3D 0, i, num_xcc, num_xcp, num_xcc_per_xcp;
+
+       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       if (amdgpu_sriov_vf(adev)) {
+               enum amdgpu_gfx_partition mode;

-       if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
-                                           AMDGPU_XCP_FL_NONE) =3D=3D
-           AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
-               r =3D amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
-                                                    amdgpu_user_partt_mode=
);
+               mode =3D amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+                                                      AMDGPU_XCP_FL_NONE);
+               if (mode =3D=3D AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+                       return -EINVAL;
+               num_xcc_per_xcp =3D gfx_v9_4_3_get_xccs_per_xcp(adev);
+               adev->gfx.num_xcc_per_xcp =3D num_xcc_per_xcp;
+               num_xcp =3D num_xcc / num_xcc_per_xcp;
+               r =3D amdgpu_xcp_init(adev->xcp_mgr, num_xcp, mode);

+       } else {
+               if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+                                                   AMDGPU_XCP_FL_NONE) =3D=
=3D
+                   AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+                       r =3D amdgpu_xcp_switch_partition_mode(
+                               adev->xcp_mgr, amdgpu_user_partt_mode);
+       }
        if (r)
                return r;

-       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
        for (i =3D 0; i < num_xcc; i++) {
                r =3D gfx_v9_4_3_xcc_cp_resume(adev, i);
                if (r)
--
2.25.1


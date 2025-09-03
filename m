Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD08CA100C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBAD10E431;
	Wed,  3 Sep 2025 08:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aUduzzz2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13AB10E431
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:08:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMXzU5IREjC4oul8vRrf6mK4Gzj/GdagNCuYWVIeX047GkU9y6FfxPOv1mLanurRN3RDGChNO5i+2cnwazE+Vn1wNRzODSmAXlnMZEXinM4s5P70Uhm4hdqLpklOtsVb1Ic+986YoQ4pt3czD7759QJooCQG0y0kB7drIJA95s4yhxiSPU3etVWVJ5N/8qTixYbJHr/UK4SGHJNGUKb8lCukBX8R9bijlm3pnsAN/dqoLioRRmW2DKS2Xu7SxMudmXNRPUpCv9cGHZzrY8TWUUMugbiasJdhWvHgfVKnAFmr3kICk9agChvnLjc7fS4p4kQ5T1VfdxQl+eYJwN08aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6zx5hdHPDhPdtCvACPGm3AxsQUKwO35kFdyVWwuZec=;
 b=Y8xxjWYrlH5TRgcfa/EyNu3i1Mtd84yG5dYbHZ1nB+16uWB671SZm6RfMMDwOm2d3cPQ9QGSJElbLe80RzqVGTAMhgo82eWDyWsZWMmUTz7LiH8DOfGz5GjBmBqtM+zLXD0d9Ibkrkau4m2nEqtQqs4KSrOvHxuQpnIIYixrrLvHBHXVv9XauIG0DDeq/srt8JNuN3JOD64SrnVVnaQByT1LWxvOFPTn50H/VXJGTxOA3D/eVDPl46IJb/7/VR3FNBOteg1aE+saZUyZzf/5wzEpU8C5avZbSSlefx2++35IHMl5vr0NAiCqtcmMAt/8wCjUIBAEsU5wV7pmyqBn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6zx5hdHPDhPdtCvACPGm3AxsQUKwO35kFdyVWwuZec=;
 b=aUduzzz2ZYMogJNJMv7ipUcS85xPPrzk1RQzO1gwYXGbhTCysrMPikYegYhaSuk58Z0MC+n3EnkFbj0U4IPXaftdguyAMbbAia63cEKbh0TiU2yUhRExMq3dFwUriENHvTsL/ALGoI66pogLN0Yt3o191CNG8PbVxlK64Cg0oBc=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 08:08:43 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 08:08:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: refine amdgpu pm sysfs node error code
Thread-Topic: [PATCH] drm/amd/pm: refine amdgpu pm sysfs node error code
Thread-Index: AQHcHJ0SREsQEHn1u0iQ0lwKDCBw87SBCaqAgAAQKvA=
Date: Wed, 3 Sep 2025 08:08:42 +0000
Message-ID: <PH7PR12MB5997399E91B15D53F6F1F8398201A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250903063517.1352079-1-kevinyang.wang@amd.com>
 <DS0PR12MB780463AE30F8CBF2C1E65DCB9701A@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB780463AE30F8CBF2C1E65DCB9701A@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-03T07:07:06.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB8105:EE_
x-ms-office365-filtering-correlation-id: 9c22dabe-8862-4f8b-e04b-08ddeac118fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Z1lfxtP7DwYuznA61KK9zhZQSAIcXm6UK+WP2xpuhE+/k/EQ+WsSeHFSK+fy?=
 =?us-ascii?Q?hAvsA0+ubHP6k2d4fttPyoDeodvqkJUeuymQU3kf66tPkAsJmjqhLC8mXhFi?=
 =?us-ascii?Q?Bys5evpjirE1mSk8PUvLF4cVcUKaceuoVMspCNFzsaxixS11nl3jmImw6eWF?=
 =?us-ascii?Q?TuZr8Isq1x9r9hOPHuVkqL19R2T8IyHC2mXc/Pg+KLx4TJkHi2reB/xoMfkP?=
 =?us-ascii?Q?XcyGNvhLMM2uqy/J82o16JUga8DVmLKMtAgQfbgdpOJd6yB8f62Lb1NdbOqU?=
 =?us-ascii?Q?O6F8YzF557z0z9R6MrLIGC+LqUI0pG3V9fA0yi3De8XR6/0gzThtKBKmSuBr?=
 =?us-ascii?Q?3HaXm9p5eHI4GOSxEvMXMZVXYvQA68kT4bPc+bamUHsYjNgej/S0RhyZtC2o?=
 =?us-ascii?Q?9cYmWzavs8kkW8hVuZX0xLFZAjnblUos3y4YmqbLe3X2c7Ag8yuJWnj5btJz?=
 =?us-ascii?Q?l2i7fJ3x52aJfvq0uhTCZE+xsnJ+LPtwwfCg/yuj5Gtn+eprhmUMwcyLLz+q?=
 =?us-ascii?Q?iEgBDFmn5t/Hu1y/Cx92bJfvsYNbAktzy/z2t9jvjS2oc97kw8PXisH2Ia/f?=
 =?us-ascii?Q?Wq3SaOk7vkfLwU8MxkPuuZQJgX/EXl5xX1lYHvyPsW3w/VZk3Y0U9K+pISCW?=
 =?us-ascii?Q?cRHAIxVXcxtLs+hOr1ZegGOXNGB0QmP8sSBdmWuCsJ3v1u/xIPHxkKEtFQBI?=
 =?us-ascii?Q?sDUYS8sJtD/ws4muZEzJ22Wis0Ow7Ap5UclnelKgKSPzMmvgWUsYfep9ovbB?=
 =?us-ascii?Q?YWid0HFfod2fb5i1ATyG/jDPUBarBA5DvxRlAwzyQy5u6zZWaRtP3rvT/gnf?=
 =?us-ascii?Q?k+Vuga7/Zc0A7xbZ2rAQU36aKq7HB34TYd9C8KEDEBVxHvLb8UgcrCpEvQZ8?=
 =?us-ascii?Q?bBw5qhUjkMqUlUlGnFHw3UMbCzwmLzENG481neP9vSAzmOoDzlFbX4W31as6?=
 =?us-ascii?Q?5i0a3SLQVvLpcqMr/SbQ3FU4pdktWsc/A25HIWlIeLGyPKoQTm0PC57wXeUQ?=
 =?us-ascii?Q?t0J/c1QJmy6xqtU5im99EvTgAWh9Dbx9fvxz2wcSME1pT7Hauus+H6njLiDt?=
 =?us-ascii?Q?SpugiwoxFZkOH/Hffichc5uZl3Si2agZTI2e1Qq3U31hWZT/Dd2lgSFqjScA?=
 =?us-ascii?Q?8VoAbX4sZDHgBvvpYzpSnR1NE0+2nWLIU588r+eCc46EoKKHTSNVudlPklx1?=
 =?us-ascii?Q?0ffk2hediYvVHb62uBbLlTlOKpFh4Mna0ao64CYkBctltfR8T7yqWUqcpsKc?=
 =?us-ascii?Q?9+EPeQmRhr1H03ovv9dnqR1msaBl8zgtegj3jzSxx+BNlX7a4MNThypIVUJ5?=
 =?us-ascii?Q?SlqNZhOge6x3unRj0i+8JtWgE3dxGM1owLMVIem3LyU783gPUeDh3Hbf4DXq?=
 =?us-ascii?Q?dCiTw+1KN30ayZ1pp3P/7G0g8KLAh2ZOe8ngi3AXQK2TqELcAdv+V1CrN++o?=
 =?us-ascii?Q?sOQQJBvGWykolM3bnvjmFrC4MHV9PFLc1v3e9R+QyVjO04TOat77qFS0WQoz?=
 =?us-ascii?Q?ddqjXW+Z3M5Itwc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yiK+LncNvqbZTp+G/A6Si48awFhFiIke7AfY9SDAxSRHHu6sH/7RfBhIt2Qz?=
 =?us-ascii?Q?wWldKwBNCh/6xGRNK47YFFcsfb2bh8KR4oj1NsC568rAYJvvqyCYdl4bgC4p?=
 =?us-ascii?Q?fq0GPHg6MkaLriwyUOjaFdMT/T9BVuwHtcVfy4vcWdKiTq0Iieopqpnv3b7i?=
 =?us-ascii?Q?vbcpel+OX+Lwkgz0CbmPYfCYoMbv86xj/sTiVE3Pis1fYpjxX6aC0sVZcqXL?=
 =?us-ascii?Q?Z0ji8tq+aDTLBFZQ5HfDykWfRzAOPxXBSrNXQf4Smr+Ugrzjcx6DZ87wkPZw?=
 =?us-ascii?Q?RpV3Tzh3938vgwWR/k9E10UN3yZi2L6ewANEPMe8iEFMkMmV/GtAaZgRZTC9?=
 =?us-ascii?Q?4VXm0u/lE3zHweyRMVW4vg8YC7XNXk72ugJKgD1TeaGJKOajCHx2UJBdL51y?=
 =?us-ascii?Q?KJ1NdFzON56P5omILsmRl13grWQFaElHTbJimq1iISyhnURjaxChVAGY5XmN?=
 =?us-ascii?Q?RC74qwOtoO/zpGEZJ3qpljodwLnj2ZXSJ9WHYIIYOqBY0jQm2TSxc/ISZQ6t?=
 =?us-ascii?Q?TYgX12DH9wBXTtjQ9KssZsUjM4Lv3ILXndsqlSOAv7SpF3MKqjYKioiU3Jen?=
 =?us-ascii?Q?ejMK7B2zs1DgNTxVqnl0oeuzOArxtshuUEOBE1I2tbeJvjU6CPgk5eS6J/Yg?=
 =?us-ascii?Q?g+5eNSECeUqgWjQFcWWhdLzuQaVZhxKQNcv6zSAHVbE8P/wkfwIzUr/FkvNt?=
 =?us-ascii?Q?mJcUHx9DFfeyghIz+rBcMURh2ta0n00KfEdpy8gw+FMwZ9231w4xxXVmMIpK?=
 =?us-ascii?Q?Sj4Ec/8C2cUUYCuOIxCofK8EIOiPOBJ0+7qYxsNenWPQotYsrwXxgfFWBbMU?=
 =?us-ascii?Q?lHL+UMQ/honh44FvM/2UGjTWgpBWMAEXBBtSg9hP++P4Rt3wKjlosyfkgZBo?=
 =?us-ascii?Q?bpw5VCgMG2el8xP6+ATn27TJz0+BVCtf6o4EQthM0INL7QtF12ac4G0QduzS?=
 =?us-ascii?Q?lHoqCSXrT59pj2ZoWpDOW+5YTS/uKBFKjec6UM1a+EfeBAZ6BR8QSUQjuT2i?=
 =?us-ascii?Q?LCY1KsBxoZLG031OrXwyjQtpr5X6uoawOOVHrxebxHP4Q7O8G77I05ehLsRc?=
 =?us-ascii?Q?B0EjYuqzkXmmJENdc/lZIuhRZ+hWnvSRjgwHASShLsp9osCLkAkIwmEAqsxv?=
 =?us-ascii?Q?fvdfz4bHg1aR6vG2FM15DYrImL7zISNKMFXJv/m+QHy6Oz/N52+auJm42E1B?=
 =?us-ascii?Q?Z1Z/1R7laEKjRK2L5hk0X8uG5wYF7Rj8C7wnWbQVIJ3lEFE4uscViGDdHOyx?=
 =?us-ascii?Q?ZnsCmloVlGQGvAl9405MtMmiVYH0m6OWTr0sNgyzPbV6Y9AJmxR8XCHYB9IJ?=
 =?us-ascii?Q?UTI9esOWf3B+KQl+GBg9LjilQ2TreEv76ndbJTghnlmevTHymQp7B/v6EaC9?=
 =?us-ascii?Q?pFBoAF+Kfmr0VPIlGc35JDKwzKGulL/caXw6bNc67sMBZjzKfijw+Z9ef19m?=
 =?us-ascii?Q?vcnttID4g1O4kqi1YUNC86DgL5TslzImFCrucufGjEHhcB9XGFZ9FTBBy0wo?=
 =?us-ascii?Q?6FkfaHvxncdBej4NpO0NLhAwysWK3noxDo/qALyO7fSZDvzmSJXOCdrST/rO?=
 =?us-ascii?Q?4rVLh2wF+UyL3Hsm9MM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c22dabe-8862-4f8b-e04b-08ddeac118fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 08:08:42.5118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoZmo2VjJO0E566UF+AiSV08mRtlsYHtvFkkggzN97eOsrHkjPRtbqAajbDJY0lv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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

[Public]

let me send another patch to unified error code to -EBUSY to distinguish th=
e return value of runpm -EPERM.

Best Regards,
Kevin
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 3, 2025 3:08 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: refine amdgpu pm sysfs node error code

[Public]

I don't think it requires two separate error codes. The error scenario is d=
evice cannot be accessed at this point of time (that's regardless of suspen=
d or while device is undergoing reset).

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, September 3, 2025 12:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd/pm: refine amdgpu pm sysfs node error code

Returns different error codes based on the scenario to help the user app un=
derstand the AMDGPU device status when an exception occurs.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 0906bff864cb..6b1de23c26e3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -110,9 +110,10 @@ static int amdgpu_pm_dev_state_check(struct amdgpu_dev=
ice *adev, bool runpm)
        bool runpm_check =3D runpm ? adev->in_runpm : false;

        if (amdgpu_in_reset(adev))
-               return -EPERM;
+               return -EBUSY;
+
        if (adev->in_suspend && !runpm_check)
-               return -EPERM;
+               return -ENODEV;

        return 0;
 }
--
2.34.1



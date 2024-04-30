Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB57AC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 15:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41EA511204B;
	Tue, 30 Apr 2024 15:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jc24NYbT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 455D811204B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 15:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqzsHzpffJyS6T2oGartNVr00mGEz4pCM9pFReTePkkVOIBNzSiAhBh1dO0QaKhJIF5Y630PQN17aRywEfr1IPDvg/RJQcBYFOx8rF77xmMgnyTr6mA3fX90Be16MJ5nJDX6p9GSklStO50xqV4yptP4ZIXMYW5b2dY406Iowjf928KZ7IMzdFsfo2L3u/Wux26Hha8yp9l1Km2wodTZYAe4HIXJRSZCQkjy5XMt/nm8Ak5W8MwqIN6uLnJoLJRNJSnYlh6iCna+e/wKm9k4SagW6IemP6DzR5mboT20yBSNIrnb8ql6BfGYB1D0WlOH4NtPW5glAdukPchNnU43Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt2ieSxDKHkA27S69q4Zixcp+V9iy9oGBJYW2ncrKuY=;
 b=g7hRpcVyLLosqcLuLc9cKb75RNJtEqGuDmIyqRvhsQEw4Qy2HE/pYdA/NEvyOibFnz5d7y4bC3daJayC1gfbTid9nt+sFLX7TZVidY/KfCLYuLIFOSe2xYIHG+K6vCdVMtkYoiyCOoDPuxBMa2ppHKgY7Av7rf5GCwRldP2bMddmZCJusd0gJe8oLc1uLYGCm2AWr9DKkinY/YOHnQi5FEjmKyF6oja9PFSJrTsdvH5C6GaB8KQL/UiLk7ia+sju1CaYkv+Js5mLYvBITkip2ls7mybjUOamGRfUkojvx+4Yq+cIbGvtm29fzSOqexrr1/p6ggtuobVZPtWUpU06rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt2ieSxDKHkA27S69q4Zixcp+V9iy9oGBJYW2ncrKuY=;
 b=jc24NYbTc+MgxfVs/nGuWOztnUjI03FLOyuqGAt890nIbN8WFHwfxoCXiJEUMtnUKTKv2x69H1zkvUBlQjXGieWWd/KHVjHsdLAOQbqRAkvpd9iA41xOMIx8d+dMD9qb8zN9TWIh+YUEhzjUg7oRZ0+bzTht4psvy2zH7WZ1k3I=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 15:15:02 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 15:15:02 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Wenjing" <Wenjing.Liu@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] drm/amd/display: Remove redundant NULL check in
 dcn10_set_input_transfer_func
Thread-Topic: [PATCH v2] drm/amd/display: Remove redundant NULL check in
 dcn10_set_input_transfer_func
Thread-Index: AQHaleef4Os8QHetZUyi6VVlE4jXR7GA9lmX
Date: Tue, 30 Apr 2024 15:15:01 +0000
Message-ID: <CH0PR12MB52848D4AD7F27780975C6C808B1A2@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20240424013431.2125336-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240424013431.2125336-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-30T15:15:01.358Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|DS7PR12MB5981:EE_
x-ms-office365-filtering-correlation-id: 89f89f22-d540-4e26-9c07-08dc69284e9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?DfAh8gMZptRiUmsAn+ATO3SZnoBuW3ASVK4ZA2jSaM750O1sHoL1A6+9yd5c?=
 =?us-ascii?Q?iSUAKwzlM2GmZWqRCVkuy8byg6DYVqfjIw7YbTH++f00YUruLpw/kc+TdOLm?=
 =?us-ascii?Q?+vbZUs23gUQf0gFoqhbDKLmnQvd7UQ/PuWAyJnNI7EEYYJAOoSOg26fWkZLV?=
 =?us-ascii?Q?S0gKOyTqTIxXEyt45FucuCV1ZH/BQ9/b2EOIjlcyzNFKI3zr85IxEq14w/OR?=
 =?us-ascii?Q?lM+URVRAOI+fF7FIYVySp9XXivsOd8D2O4/l5cMdOAWQBrla6h3jugX3MBTX?=
 =?us-ascii?Q?vSdle6nuO9nWr3FfCyrdpG2x9fockUiwG0xv1K5v4wN1nUfnVA7PrS70Mlv8?=
 =?us-ascii?Q?n1XEpUuJcrB2ybQD/liP01R2n98nU5epBX1aqI6Ccsub6bqWDox8D5ozOGgg?=
 =?us-ascii?Q?j5Sw4/+rbpjUw+sICXkNePSmGQWowxMmFWwPowfo03za5VqfzTXZHTZ3Gb7p?=
 =?us-ascii?Q?7LkqxfX49ZSBfBy24i7gNVd/mXdf3t+tbOmdt2RUgRU90XDoDNHk88ufY/4s?=
 =?us-ascii?Q?jJJc6lP1pr2CxTYidX7y9B95/CTAkgfn8L4CmGSSGzDLrz9T7UqKWyLbYPk8?=
 =?us-ascii?Q?6tW0y34rCH0KhdrP+QvLgfJwesE1YMjCXsdiIckFxQahEoYSkrFv744RRjat?=
 =?us-ascii?Q?coQcoycLzdS3DNo+wnMb5v6PXRgrBsz1fbs7kKZp8PdJfwUNgBq+KZTk+Fk9?=
 =?us-ascii?Q?jDLfr3Ve+NywzHdYN+lf6wHgFn9qaPga00DjWSp90dl24W1LccHJGQoiC9bU?=
 =?us-ascii?Q?bAxc7BnLmRbR7MMeyIucHsPx7QIywGjU7tw6z7439+f0v8oX0taPfGV912Kq?=
 =?us-ascii?Q?CDi2IvTYlssVAWYVLMrzFgMOygdF2SVC8j8ErSHHTxWDwqHrAZKgyrJ2Xri9?=
 =?us-ascii?Q?Mps5Uf7GeUTEWX5JcMPutpGlY42fKsWDFcHPm/BfwmVN24mxA3NQbbtmw0PL?=
 =?us-ascii?Q?ZYQvb0GD08KJzqAlHcKQ5El+SBJHDxd4ds0fS2ezTKmtLClYyNSY76NnLJtP?=
 =?us-ascii?Q?abcuIv9kjQ5YVeWEKXGMshZKI+XAwzYtqBwDR918rJMiWpWLMfCSM2UQKBqB?=
 =?us-ascii?Q?GTiOZPmkbR6Tr7r9rMRcofgxbhvTOHS3PkHKK8kK2VPIN4CQlxpCmsvjZkCB?=
 =?us-ascii?Q?Gc4a03dfc9BRTKFCiwZHawtpENP0KESqRd3n4OwE9RDKCtQ7x/T7SW3gbDET?=
 =?us-ascii?Q?KbUkPUmhE759yoAHdLiSyCj4GFgL0pHZGcCRTWIvfeqIwsZOKpWO56WfWJSd?=
 =?us-ascii?Q?e5Z320BXM7oklFAE9f9udxmzx0AAVM5PIr786TBtf5zHWWoWBWX2h0oMioFQ?=
 =?us-ascii?Q?PVtWr6parQpm69zwNAgAOsDnbneCBR8djepyw+3BJwmCOg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H3xpedE4a6bjrRda1Iamib7vT4I6hMX/dET/gNDHdwgf166sqiZlRkiIsVYa?=
 =?us-ascii?Q?3kQg+WS733swKgU6R+jURNbkCUgXjdoki72vP6rEQv4L+jCVHBkCJ2KIoE+q?=
 =?us-ascii?Q?rNeYTs2dAtMAPQgL3mjEKOmA7myHAu/WpnICHwkQkbSnsW0NjuF3h5l8tpG2?=
 =?us-ascii?Q?S0AENzTlf0GnEvo5ITC2oPeFfOlFqNZY7/FJWi5PwHQr/4sgCL4FHEr3s6Nm?=
 =?us-ascii?Q?W3aE92yDyKZOytEIhqNAhH6/Y/2ogkYltqgkjZqnUla2M8QIX3azqUVzV4Kw?=
 =?us-ascii?Q?t328xLpPerrbk4oxF5l42N9RGFxxk+yklX3ocfnA4KCiu6PM6EGMM7qYkLBa?=
 =?us-ascii?Q?KTB52LDetwRJ55FLwy7xjHrTLfJigSfy+WIBrhrkCjHJWyRRLcCGe9711xtD?=
 =?us-ascii?Q?rmKTHwONiZi+QSUUxAWpsN36+3VfTA/whiISoErL/gkkbEJC/NREDf5oL30l?=
 =?us-ascii?Q?L4BBb/Q67jlszdxjYrYW5YUUkgcayDT7gTUGrn1kreCGvieR5Qzc05PF0adx?=
 =?us-ascii?Q?yzTiQdyE0OxXogDXj5N2VjbtrDhYsdFLuwaTF+IlxJoN/2Bf3fn4MWb1DF6Q?=
 =?us-ascii?Q?7KdehnQkIyS9FTqjfetZd8GeiMMzcf4ATlDMwsafGGGrfIdUPOF8sQgBTKiR?=
 =?us-ascii?Q?qVWt5YuBH/oaS/oDtPzlXjXm7tl+4hi9kt3sEst4PwRiRbWiwOrOWlogIoAg?=
 =?us-ascii?Q?rndExR9BYEMqngqW2IddssvbI49c8EIdbrdbApCXPOMy0vZzuslxjJaBy2lJ?=
 =?us-ascii?Q?+AfCJb2VpVgcKuPDO0/pjgYsofz3x07X1ThP3OUWWnFnWqS4IAU52SBfnzhz?=
 =?us-ascii?Q?ZNDarZ9stot+abzwOMar70/6wDL1nhonqQW/5T7zMoip+8Zn629lgvsLAduf?=
 =?us-ascii?Q?Vg8gRw1KxIbeXOoXMl8cy12bVpr7ld96B05zw9SjeQPDhTIz+seUrxDiaAyK?=
 =?us-ascii?Q?/UNLTrBXGu0Z7Vth4kDuzAtahktxlX7TPvg2JfnaAECVA8Ef4I7SvvuHFBqE?=
 =?us-ascii?Q?Cmk5BegGAzqZq+564x5Ryz3dN9yO0hQgTCTgNIF5DBW1rG6otr5tmS/hc8RF?=
 =?us-ascii?Q?yxG3Do/gRz1zG/mTXAvIZP5HTVMjA/ooKJ2MLyHfSn3bWbuDtSrfuXAUQodm?=
 =?us-ascii?Q?T/O6T3NReIZ7xAxbtOGTd4tXB3Xtx9i1YBx2GysFSixz2zfQpoRCOH7bYQgg?=
 =?us-ascii?Q?D7gxXcFBD7YmhH8EeJ6lwOPnrF1Ki5+Q4EYxApYnvsb+kgof9RB8k39p6AZQ?=
 =?us-ascii?Q?5Fmysvy+oFFzV5fIoDz8S0rd1o/DywyjH7HDW0Kcbr1Z1Kbp8vVxqoEgm9gY?=
 =?us-ascii?Q?cTtQJzlUxC63RR8FSvy4UENq8rrrcfwmJ+ytLa3AeKQIs2+Jr4vF7ubNc7Q3?=
 =?us-ascii?Q?XlG8xvKq5RC37ll5cyK6qFzXegPvreiEgN3mtDWHMHVTzXngrJgQLatav3cF?=
 =?us-ascii?Q?1c8reRWscf7TQjt/SHJ9bakqOLbBQyHcIFoB7Lmpghbp3iRR3O/l49Y4U6BG?=
 =?us-ascii?Q?Jq52By/jsz0PYnfXzFj58oz5Yg6oyW8Wze+H2fxy8sbpHkeQgtmyYA09NBit?=
 =?us-ascii?Q?POI9TFb0mYOap+s/1zI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB52848D4AD7F27780975C6C808B1A2CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f89f22-d540-4e26-9c07-08dc69284e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 15:15:01.7973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JR8ri/nnDdfSwOMHavvEKRyqTPWn1dObcIPXDkEVTS02xRv4I9o9LVK0yobYTWn1zCuUwlpk6YaTAz6lizkPgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
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

--_000_CH0PR12MB52848D4AD7F27780975C6C808B1A2CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Jay
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Tuesday, April 23, 2024 9:34 PM
To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabi=
ndo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liu, Wenjing <Wenjing.Liu@amd=
.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Lee, Alvin <Alvin.=
Lee2@amd.com>; Li, Roman <Roman.Li@amd.com>; Wu, Hersen <hersenxs.wu@amd.co=
m>; Hung, Alex <Alex.Hung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com=
>; Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] drm/amd/display: Remove redundant NULL check in dcn10_s=
et_input_transfer_func

This commit removes an unnecessary NULL check in the
`dcn10_set_input_transfer_func` function in the `dcn10_hwseq.c` file.
The variable `tf` is assigned the address of
`plane_state->in_transfer_func` unconditionally, so it can never be
`NULL`. Therefore, the check `if (tf =3D=3D NULL)` is unnecessary and has
been removed.

Fixes the below smatch warning:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1839 dcn1=
0_set_input_transfer_func() warn: address of 'plane_state->in_transfer_func=
' is non-NULL

Fixes: 285a7054bf81 ("drm/amd/display: Remove plane and stream pointers fro=
m dc scratch")
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
  - s/dcn20/dcn10 in commit title

 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/driv=
ers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 32a07ab74c51..f258914a4838 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1837,9 +1837,7 @@ bool dcn10_set_input_transfer_func(struct dc *dc, str=
uct pipe_ctx *pipe_ctx,
                         && dce_use_lut(plane_state->format))
                 dpp_base->funcs->dpp_program_input_lut(dpp_base, &plane_st=
ate->gamma_correction);

-       if (tf =3D=3D NULL)
-               dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE=
_BYPASS);
-       else if (tf->type =3D=3D TF_TYPE_PREDEFINED) {
+       if (tf->type =3D=3D TF_TYPE_PREDEFINED) {
                 switch (tf->tf) {
                 case TRANSFER_FUNCTION_SRGB:
                         dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEG=
AMMA_MODE_HW_sRGB);
--
2.34.1


--_000_CH0PR12MB52848D4AD7F27780975C6C808B1A2CH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" style=3D"color: inherit; background-color: inherit;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 23, 2024 9:34 PM<br>
<b>To:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aura=
bindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Liu, Wenji=
ng &lt;Wenjing.Liu@amd.com&gt;; Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@=
amd.com&gt;; Lee, Alvin &lt;Alvin.Lee2@amd.com&gt;; Li, Roman
 &lt;Roman.Li@amd.com&gt;; Wu, Hersen &lt;hersenxs.wu@amd.com&gt;; Hung, Al=
ex &lt;Alex.Hung@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt=
;; Dan Carpenter &lt;dan.carpenter@linaro.org&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/display: Remove redundant NULL check in =
dcn10_set_input_transfer_func</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This commit removes an unnecessary NULL check in t=
he<br>
`dcn10_set_input_transfer_func` function in the `dcn10_hwseq.c` file.<br>
The variable `tf` is assigned the address of<br>
`plane_state-&gt;in_transfer_func` unconditionally, so it can never be<br>
`NULL`. Therefore, the check `if (tf =3D=3D NULL)` is unnecessary and has<b=
r>
been removed.<br>
<br>
Fixes the below smatch warning:<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1839 dcn1=
0_set_input_transfer_func() warn: address of 'plane_state-&gt;in_transfer_f=
unc' is non-NULL<br>
<br>
Fixes: 285a7054bf81 (&quot;drm/amd/display: Remove plane and stream pointer=
s from dc scratch&quot;)<br>
Cc: Wenjing Liu &lt;wenjing.liu@amd.com&gt;<br>
Cc: Tom Chung &lt;chiahsuan.chung@amd.com&gt;<br>
Cc: Alvin Lee &lt;alvin.lee2@amd.com&gt;<br>
Cc: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
Cc: Roman Li &lt;roman.li@amd.com&gt;<br>
Cc: Hersen Wu &lt;hersenxs.wu@amd.com&gt;<br>
Cc: Alex Hung &lt;alex.hung@amd.com&gt;<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
Suggested-by: Dan Carpenter &lt;dan.carpenter@linaro.org&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
v2:<br>
&nbsp; - s/dcn20/dcn10 in commit title<br>
<br>
&nbsp;drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 4 +---<br>
&nbsp;1 file changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/driv=
ers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c<br>
index 32a07ab74c51..f258914a4838 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c<br>
@@ -1837,9 +1837,7 @@ bool dcn10_set_input_transfer_func(struct dc *dc, str=
uct pipe_ctx *pipe_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
&amp; dce_use_lut(plane_state-&gt;format))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dpp_base-&gt;funcs-&gt;dpp_program_input_lut(dpp_base=
, &amp;plane_state-&gt;gamma_correction);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tf =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dpp_base-&gt;funcs-&gt;dpp_set_degamma(dpp_base, IPP_DEGAMMA_MOD=
E_BYPASS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (tf-&gt;type =3D=3D TF_TYPE_P=
REDEFINED) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tf-&gt;type =3D=3D TF_TYPE_PREDEF=
INED) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (tf-&gt;tf) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case TRANSFER_FUNCTION_SRGB:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp_b=
ase-&gt;funcs-&gt;dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_HW_sRGB);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB52848D4AD7F27780975C6C808B1A2CH0PR12MB5284namp_--

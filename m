Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB04AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 06:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2086D10E16C;
	Mon, 19 Aug 2024 06:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PcuKagUJ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DEBB10E16C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 06:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxWw8Q81Rkeaq7xJISojX+kP1R3XqeFResjEwhREMtwUmPQY0U8yIOqoB500+oTfx7wVBWDFyBqtOSREErPMECBBBnZuhNq4ALmBZXzxNZJJI9QOfSMHBz5Jkl4fIKyJGEOQLvbR57HXehEx/e2udoQU+cmiO03BkvhRX/q2U3VrBH9ee8ysONZvBuQuvQtB2rR1GYdNSnia6UT/V9BOnlnyyOn5TKl5Fwa94/u8xD5tB9o+tX8irPcha9LK2X/HSFbHWT5Af7loCbuRzNUiDZosCQoAgQ5I6Wj5mIjw1cvKKihLkeg87T7nX64jGcrVloKmF25ktx0uN0TIyDqakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lwPeZ17cD8gtNo3MAPeSPLhV5bEYTx4RDOPd2NeVPk=;
 b=j0zQlQkrql2e/n5DHSm88BkUL5Mzr+KPCO/cnY9535Y8wQxmwPHCue8Yl+sJHU7ruABZ05e0i3QeoPE5tkMV3MVPF6kvn0KpQZ4ncNaxXRLIkNbpqs0nul3ADh1nX3My/Tyw2SjE9CBqv5/kKhmwND3uMuUjo4mYLqEbGndle164l3zbGT1emNSX8VB6A1+wtEvdmaF30BT7V2ARcBKu0OAlOUrFwmGYBNKm+cORlcIwuMbl1jvRuZSHp/migWCLuCuG/5NswKA7aKnHnTrlp9DVoKuxCAMjqhGbBJVfQbSxmO7WByKOQ2K3Fl9OrmeFlCGXSsPi+f610ZBPBXonNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lwPeZ17cD8gtNo3MAPeSPLhV5bEYTx4RDOPd2NeVPk=;
 b=PcuKagUJWTMVoTSlLmGeKbAMmNsBX2jwUfhcOGlLy7QH466gYuvQ+SnkzuSSZZmgCkAX9BRK+d4M9BerI8BnJP6jCy7dPqvflSeBwr1D7h2WTngkHsVe090PNhA33UR0IRwto9ofaPXEE9zluBl5LUFYsuSP9tAJPTZ+ty5z/hs=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 06:17:06 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 06:17:06 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: allow use kiq to do hdp flush under sriov
Thread-Topic: [PATCH] drm/amd/amdgpu: allow use kiq to do hdp flush under sriov
Thread-Index: AQHa8eroAUDTXgh/rkaJUsPGXvVRsbIuC8UQ
Date: Mon, 19 Aug 2024 06:17:05 +0000
Message-ID: <PH0PR12MB54171A8F16C422CCB5D61FDF8F8C2@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20240819034937.1181639-1-Victor.Zhao@amd.com>
In-Reply-To: <20240819034937.1181639-1-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=94589d67-5050-44ac-892c-e6f688f89b66;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-19T05:22:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SJ2PR12MB9192:EE_
x-ms-office365-filtering-correlation-id: 0abb0e73-e054-4346-78eb-08dcc0168c8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aQitR3gDmkn/leHcqR6Fv4SGI18TcxpCyIFRg/x24oiBaIlYF0WI8cgmm7lO?=
 =?us-ascii?Q?QggVysYJP4gCBNYZXkC5sBwMUs7XfoTtwYnQBOsQ6kr/whTC5cMCDH20LUVr?=
 =?us-ascii?Q?2NNgUtmNKGj1Ar6D2NAlG0s3J22D0TIjwqzgfquOJG7xshSyF51Bq40ZGjN0?=
 =?us-ascii?Q?hRYCw0IovzqLyrCc9Z2HNCUdkJ7xV49gKmmFNfxGc5X9X5k83NH2RFj5dsQU?=
 =?us-ascii?Q?8aSko1co++YgMPau8aJ2nX66eEI1I0SIxxX5ZJRZ2Ypy1IGAOpeV3UqtAOgk?=
 =?us-ascii?Q?pj3QFj6caZkwzGaVlNUr4TKO5Jr3onl7raLs8dsUG5KuWoe5qVLOM5e8jc/q?=
 =?us-ascii?Q?0zBlDRbNl0x7a3X72n7TQsJBlaj4B9j6U6TrMuvQRJMd+KiHIwcMV20ntFCx?=
 =?us-ascii?Q?wDtZLiXkQEa+ZOgAgkhhH43WPhTvdwk2dSYJf2/OORnt09qQBlWPDrN85Ttd?=
 =?us-ascii?Q?zpLcPfYxYK7U6vTfcJdie5adieeoYEx8b0gsmIG12JnK4I/si35ohlCr4EfE?=
 =?us-ascii?Q?lEdeaK+dhQSjbk7gXBIcF2C3cQEEeKnFYNMRiX0V1m/L/V1J0sKZGZ2pF7Lt?=
 =?us-ascii?Q?yKljSvZymx8pQd8D6+HLdRGV364O/y7Uuyed2MzgprfGXBq+qddEZi4KVp2Z?=
 =?us-ascii?Q?cPHR7Rkzx0h6U6gI+evjYEU+X+W2Gfadfh6xFy8WZ0qhSxa5XRMVOQ58yG70?=
 =?us-ascii?Q?Ypi+MC1gG6sAO1IlCXc0WUvJ6Jfxo37ikWyi3mIrc8714EO0ydhXIeEh9zKL?=
 =?us-ascii?Q?LpU6bqeCARKBq6xqEFpSbkepj3fgl5TPKICd7lVlzOou47nuH08ZlX0g5kBD?=
 =?us-ascii?Q?pfA6/ZsQlsLu79G6nIoKNlmGTES59FKYP7pf8MTG3oKUUo1hbAPhPlIclnW2?=
 =?us-ascii?Q?mpAz5hVPOC/7gYva1c0+LSB5MEcYxTlziApw0XDm+Uf9PhHZ4pBItFgL7gDD?=
 =?us-ascii?Q?iNxmkc02bOMBshfAJMA3dfuaOeJ1nHwI5X2cy6LspEHThbcV5qXuVpTDUdds?=
 =?us-ascii?Q?+U2vpRsy9ULqrAL5IWbc8mpfxkgV4A3+lOLe2aMoPN9hWFesIfFiotIUGEg0?=
 =?us-ascii?Q?8jy2UwOkOKdLce4oBIkCT6enVStvfs1o8Y4wskovKIUr+3puVmLKb3bzu29D?=
 =?us-ascii?Q?4GQfgY4XXb0GdKs9RMvPeY1qlHZWqoRnLXBBeSs8BxCcVheAwVS+ZAsyigOO?=
 =?us-ascii?Q?+BD6BvwWOn/PeqpFOQEb/9O5LUYLZM+T78BCyiV7a7eu+A1FRpvtK0R71seq?=
 =?us-ascii?Q?wh9UZrtAYLt8LH7hrVYnpplIk+Zi+R4JXHjMeOKlxtfcrN9QLTt97oSrhM6P?=
 =?us-ascii?Q?9AUHhAyG86jwnpfwtE0MX3Id098J/ejvHlmKiME2qRAfw1g6e7y1yeMarMQj?=
 =?us-ascii?Q?Fy6OJvg+D4ue286Kq9DvNzdQFJmKE9fdXNZFZyOSm7wqZXnu0g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XKT84VOyF6HLsotqWJGFmABT4Oqeo0H+mMkLYCRfYxqcAeCawLGZXsq5pcAX?=
 =?us-ascii?Q?LTxMDh444lFWBOXk8c+9GQAinjiVbZ2qQSdicDn6DrUZU6RSjuNpzd9l5Pey?=
 =?us-ascii?Q?E+VZMKmWaoanEqOar+Dy1u6Ae/Dj5WAqrkZlcqKPQ4DOA7s/dyj2KHshFBZt?=
 =?us-ascii?Q?xhE8MWZuo/Xr4GWTYPCGmaP48Cr8DayMQ+zV/IvrE/47wTBd2h5z4PFwJtvJ?=
 =?us-ascii?Q?6Gy6Titv2A35IJj/K83Pmq3aHV4KKFY556PkJhABoJodA6atLpNta/AuzM7f?=
 =?us-ascii?Q?Pfw/CsIBkLUqHwW/AUaE2NzhwrPx4czvv1HchcgHsG8PrVwsYZ3UGP/1Nmzd?=
 =?us-ascii?Q?kWoulT2flrVMjar43Lz0SWIFyVrnbHAa/3n2e9c0Y6Yd16LFX7qTgIvoZSwq?=
 =?us-ascii?Q?8LY+hCIr8fSbwnVRfnA3gUoC+oZxfeqAcoGj9EhlOmi3DnZQzpJmD1KJosE4?=
 =?us-ascii?Q?paXOqc12ReIyTvLyHEnrurvmDV3KDPFyLT/rIgN0nH92mDcUNilE/HJ+DW/5?=
 =?us-ascii?Q?ZMMKZ8PoNVTENwaQJ8+ZGCyrGocl0LhvaaLSV8Wuz415LPSlonbKCfKBNq/X?=
 =?us-ascii?Q?rC0sehVEG7Yp5uDY3a6Ng4TOdod8pG7GGrrmuoQGxzsVpcgQIp7RbXYnRbQX?=
 =?us-ascii?Q?hfWLhJt9EidonibazJBCkwhVBZb9F/U7gCnQIIVoULzQ6Ws71vRlvvU0yicJ?=
 =?us-ascii?Q?oR7C7qKzwQ9LpyF2pSjJKM1IiatlrhLMi8VRzZwGkzP6HyfuCPAoa7jM5aY1?=
 =?us-ascii?Q?p89b+duvOM0JwfLJG41hJo5FLP5DucgWS3io9I8g6tLXqJkFgLY1O6n0RNa0?=
 =?us-ascii?Q?Y2JDzfq+a0l+0DblpqPNQkkLr8uPGW8hAZUPtVnTV9VT5e0v6pz5TwmQAcQ8?=
 =?us-ascii?Q?BWzaTx5JIWaEaQkejUUgO1qu0POGEcNOU73ZV4n5/ynRX+QWqb4/OqQe1Y4U?=
 =?us-ascii?Q?j5xL/OcnEy5tCEcLgzsdctZzTWYaJMNOaQmzYarKxUcfIFEZ1+nvsMiO90lk?=
 =?us-ascii?Q?QSJg1iN2dSHJAlJs6T7EbMh6B2wVRZkNgBPAOI5n8F803Y+lfmyfZdzCwdqS?=
 =?us-ascii?Q?El/6hCUHM7aUGO4H0b02c28fWVGH09OmUwfbzVzFKf4uVNKRh64IXYYQ7lxY?=
 =?us-ascii?Q?nF/o8OIeqK8LF7+OgUp8l3t83VRZ0QGfJTBDyldYAm+ic6twpf0kN8YZzaJU?=
 =?us-ascii?Q?Zc0oJEPGv8OYWYBuieZqs53LviUfURqKaCuP7UY2d+xJSpcnmhJV4nxieyXW?=
 =?us-ascii?Q?RaA3IwoHWDKIAyx6iUNcH/VJmswVLg5jWgBi7/lOQLOmgE0wMejlEeRT+u30?=
 =?us-ascii?Q?Vd6wYjt6hcR2sTCPpdsqanUlwcrN434Z5ezTlzmUDCSG0s7Q6jHTjqxT6QwS?=
 =?us-ascii?Q?QjnT5zOar1e4KR/FOS0s5kuIY0+qzi/Ua3zUCInnSV0HNpFLOqjnfPj4AYye?=
 =?us-ascii?Q?r0wonSiaiDwVnqU7Z9X/PpqQ9nQzjqOBB2N4wniT2HtMMFdQTZkEibPK+oWV?=
 =?us-ascii?Q?0EUZURtlAH9X9iC4YD6Y3MZ2AOh+ONs4OiiOTkv6PWr9psFmUBeuW0guPySl?=
 =?us-ascii?Q?+aUowMk9IwxS1KMuo+I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abb0e73-e054-4346-78eb-08dcc0168c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 06:17:05.9104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBgHJ64IEHGDNOhI9RBm/fwoVxDDXfd9teAfeFSzCeQByGzEJW8vsWgNxneFGfHq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor
>Zhao
>Sent: Monday, August 19, 2024 11:50 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>; Zhao, Victor
><Victor.Zhao@amd.com>
>Subject: [PATCH] drm/amd/amdgpu: allow use kiq to do hdp flush under sriov
>
>when use cpu to do page table update under sriov runtime, since mmio
>access is blocked, kiq has to be used to flush hdp.
>
>change WREG32_NO_KIQ to WREG32 to allow kiq.
>
>Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 2 +-
>drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c | 2 +-
>drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c | 2 +-
>drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c | 2 +-
> 4 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
>b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
>index 077c6d920e27..e019249883fb 100644
>--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
>@@ -41,7 +41,7 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device
>*adev,
>                               struct amdgpu_ring *ring)
> {
>       if (!ring || !ring->funcs->emit_wreg)
>-              WREG32_NO_KIQ((adev->rmmio_remap.reg_offset +
>KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>+              WREG32((adev->rmmio_remap.reg_offset +
>+KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>       else
>               amdgpu_ring_emit_wreg(ring, (adev-
>>rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
>2, 0);  } diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
>b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
>index a9ea23fa0def..ed7facacf2fe 100644
>--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
>@@ -32,7 +32,7 @@ static void hdp_v5_0_flush_hdp(struct amdgpu_device
>*adev,
>                               struct amdgpu_ring *ring)
> {
>       if (!ring || !ring->funcs->emit_wreg)
>-              WREG32_NO_KIQ((adev->rmmio_remap.reg_offset +
>KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>+              WREG32((adev->rmmio_remap.reg_offset +
>+KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>       else
>               amdgpu_ring_emit_wreg(ring, (adev-
>>rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
>2, 0);  } diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
>b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
>index ab06c2b4b20b..33736d361dd0 100644
>--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
>@@ -35,7 +35,7 @@ static void hdp_v6_0_flush_hdp(struct amdgpu_device
>*adev,
>                               struct amdgpu_ring *ring)
> {
>       if (!ring || !ring->funcs->emit_wreg)
>-              WREG32_NO_KIQ((adev->rmmio_remap.reg_offset +
>KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>+              WREG32((adev->rmmio_remap.reg_offset +
>+KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>       else
>               amdgpu_ring_emit_wreg(ring, (adev-
>>rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
>2, 0);  } diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
>b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
>index 8d7d0813e331..1c99bb09e2a1 100644
>--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
>@@ -32,7 +32,7 @@ static void hdp_v7_0_flush_hdp(struct amdgpu_device
>*adev,
>                               struct amdgpu_ring *ring)
> {
>       if (!ring || !ring->funcs->emit_wreg)
>-              WREG32_NO_KIQ((adev->rmmio_remap.reg_offset +
>KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>+              WREG32((adev->rmmio_remap.reg_offset +
>+KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>       else
>               amdgpu_ring_emit_wreg(ring, (adev-
>>rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
>2, 0);  }
>--
>2.34.1


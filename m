Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F00CCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 10:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA9F10E135;
	Fri, 10 Oct 2025 10:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vyQTniJu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5FB810E135
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 10:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNiVzhV9DBriF6Hx2yDrIIJGKQ253Gael9Cg5WHwIKSS8MnnIB2QFXm35X/ioMUbWoJk3oTVU52wFgIKtSSn04YjlN98jWFo9NbBWq6kOqXF/DnOgzU3Nvx5tmAAOinOQXltKPLxwkFvgTaWp/oCkFxH9a7EX1+ipmFj9Rkb4D7uwaA4Em468imE7BAEwPhUebmqcP4epAcGWlQpXPgpvJyYWJ0ryY6iJ8jMnutmCBXFSd3bcc8GH9h3SvlNxspueeeChuxK6Ynwtk0uTC/pOt8okesJFsuAsdEeobq9LiCzkyosRZYFUUodqZrGY3B7ICSLtzLD5h8G7YDT57JgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlqJi3snUmJFUIShHRdwtSccOdkx+8TbG91TflUA7w4=;
 b=aRVger3J2xO8n3dYZufVIHdUwRpdByNcPgvc9mqo2DO07WTbl3mnuqAsVVQXrE0nsPR4fctsjsNsJsrG2dog4FNX8aLPunE+CDbqlfhd8jTChPN+AIvGcjFl6FYSvYnVoDtRqK+IiiJXj3n7vgNM8gz6hCzAQHTp4HdZkXQquVZCzlzUARRxGbvEjFaYMg4uWnnuEqHFK6FpfqLjf7I0SbhqFUQlUw6wwxn4RyHAgqo2KaPE/aBYPh9I+ofa65ts8GMXNsp9tH6xx0EEOhMThinw0wLi/pp4daK18fSq4QI5gKYS5HAmO1ZvcyVBkfJdsIq3ozcGivJHo7LHG6dBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlqJi3snUmJFUIShHRdwtSccOdkx+8TbG91TflUA7w4=;
 b=vyQTniJuav+voMOmpGcA53MYmqgVpiCZrk0PQLGSBIHvvqbWO+eeCfAC1E8mkJDyutTpMkmazoJSuPMvDrQiWyVDp5Z4AMw0lgebMCmdXQFFf1KOVQHv0E4+Vmcwz45JaFxQZHnUmbbW4HLsEozEt2sXIBORCL0kT+SFuKseRi4=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 10:33:31 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 10:33:30 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>
Subject: RE: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
 critical region in SRIOV
Thread-Topic: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
 critical region in SRIOV
Thread-Index: AQHcOaBvxBXtU6MfnkKclKs2SNbShbS7Dnyg
Date: Fri, 10 Oct 2025 10:33:30 +0000
Message-ID: <DS0PR12MB780487DBC50E6D72F7E9BD7D97EFA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251010044309.11822-1-yunru.pan@amd.com>
 <20251010044309.11822-4-yunru.pan@amd.com>
In-Reply-To: <20251010044309.11822-4-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-10T08:35:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|PH7PR12MB6859:EE_
x-ms-office365-filtering-correlation-id: 10e1b148-b00c-4b84-c28d-08de07e874dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ug5w0NXtbyMc4DwqLfyz1TlSSnwJUsnyg0GFzzVXE7LXbNWlyX7lg9xvOOr6?=
 =?us-ascii?Q?cBXBavAwB+jzN/myp/meV7Q2Ok6rqQvkz8L776G6ePZQl+Dt6hpVVkrwuUIM?=
 =?us-ascii?Q?jjJVrp79VNYSSPfpdHPU8CiC5n7NUuNyPOCBhwj7DeM2GySi9LhgLIFly5SI?=
 =?us-ascii?Q?pyOHoGxGFkwCA2RKxjvpbclBRB1Fzkx/ElE6c2T+c35A5z2vSLGpQ5YPXtMd?=
 =?us-ascii?Q?rsBu2KT4iovFI8SVCCdYgNT+8sgt1EF6bRwgm6Pc6nX1U8tXfTLDxIqm2DXa?=
 =?us-ascii?Q?YUuepKR07+bhZzH3s1Hh1Bg98d/pJh6tBvsbeaajwzqkH/c9shYLtEaJ/L0u?=
 =?us-ascii?Q?KqEbp5s4hOJtH1fEpcGLvkHS+1MsHJ9qPN3ROfPR+9EMS+YmVzCGrmoszK0t?=
 =?us-ascii?Q?rPyerVUt4GkBmxX0h6wBYEKAKcvB2MoIwSx/l3QBTZtDX6rsZo/smrYSbgVd?=
 =?us-ascii?Q?y+xXGvs+mfmdVAE2u+Yc5vjjQEjXKkWKfslvrHpr7E4pXONDDqQ8VPVk8Glz?=
 =?us-ascii?Q?/I4Ss86nvDmf46ESLlQFPYcwU9SqROdpKnkhhjhqpoZUxTXCWG/DHhEZjZea?=
 =?us-ascii?Q?fKvAYIsxqeQHngp584qjWbgetSs4LljJsL+oe5/15b7IIhhJqx6LCLcCWtgt?=
 =?us-ascii?Q?N+/OyaiV8FtSaSXEISlAh4NboRf39RXWWdwwf8VKGz1I/QLgJFT815trf5IG?=
 =?us-ascii?Q?Kvt9JjvQ5nCMTfDMTnEV4OrX/IfapYpfNFzYFT5I8q5FSDK4ToLhpiSXvDme?=
 =?us-ascii?Q?YVgdfyx0/64HT/ZavYB9cKTpRMhsl2Joanbz2smtOWsSPiKqH6XkIm/RzEI1?=
 =?us-ascii?Q?d/En9swsGq2794Gy97PM4cak4H5w05TphHVy7PYVHDeYtzFeS9eUb5m1F5fT?=
 =?us-ascii?Q?NHkQOBAZRNACbMpUi58iQbWuh7Fe8dT9s9NZpRQ5Iw3sj4+qhplkGJtvIgZO?=
 =?us-ascii?Q?hzJtof9Ij9HnpShO1bxdcabKeTpyQzOfdVDJ+bEJlQuy4a+8VXywKzoHVUC6?=
 =?us-ascii?Q?EUVbW2N2H7vkufmGE+b2kkZzBJ94gLOr+IquhIEFo+YAOa6ZwQvBDUMqW/BI?=
 =?us-ascii?Q?w+fjunV3IBwhxEmHjvsI6Gi1eva79BZ/7kIX3i6A8OHcSZ7mmH1PnFWkgmkh?=
 =?us-ascii?Q?Iuegqs2QB1+SvumerxrHHJbZZ6tj774+NsEBE0kwglunq/V8oinXutoJfAdi?=
 =?us-ascii?Q?9C1JVGUVz3CmVCjafGY6EV0DuQVSm1zrVI0cyDfGHY0z17MxX6pWhmTMzbwa?=
 =?us-ascii?Q?cP7bYTa4OsdPQLcztKN8RZ38NCXeNWoZwoZVyLhC/XNmYlgN+4ld7Tx8rKz6?=
 =?us-ascii?Q?8SPGhBZzY/zPqV6BXLsyI3TtJeEX53YyZqQ4ggNIdpS2yEKm+DkStdmoncmK?=
 =?us-ascii?Q?9T5kTZjv2HHD52IqkhJWfA98O0Og+WZz6/r3JlRsKWF/AZfQLYp9ZpgL5EQq?=
 =?us-ascii?Q?5ghJlv8C9H12X0Eh+NFWfevv1Vgsoq/TgiLv5bclqwfNj8fmSJWY0KxU/8ad?=
 =?us-ascii?Q?H4l8/4fztYDL+mMtRzP5GPP3Lg+UKjq/e8b6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9bDP2U/TbYLtf0xbhtHRX3XyP6S/D3NvAxHFSNoiTlp8wvlrNj5t7yf2V8ST?=
 =?us-ascii?Q?ERCQvgAQSjeNpEJa2jlGUEVuzMs83DNv2Q2PnPN/qEXRAT29Z2jqZoXXLmwM?=
 =?us-ascii?Q?P5EB2MNapF97XE1wqm83Y/pdkkXzaqTQfhWNYvurStzncyBbBNw9B5BZjkES?=
 =?us-ascii?Q?9ga2oey66iDgLnD2LgkRevmsZSWEmT7PqDsd6g6X27J7akEy8MTZMaVmOoH5?=
 =?us-ascii?Q?bgUnTj/iqshOO5YqXk/+enbd/LA4J92WnnXojCxEI7NV5yNYzAlrD4By5YtL?=
 =?us-ascii?Q?YTSDn/Z2wYbjow+5dAWbjhbyEcigJI+fvTKg78kIT3AoLUMBBPkpuPQsZZqq?=
 =?us-ascii?Q?0AfyCEqCLTCQ5HWAxfmy9dH7bRT+WJT3i8G2045jbw8xLxLUAygeIf1NzowF?=
 =?us-ascii?Q?0DAsz+sxqAd6s53nVgPI8hsMSky/NLlZLZ3F0t3tsjeRwZgjs+2+FtgGRQ/u?=
 =?us-ascii?Q?O5gZ402XEx15o6fM4ClMU6k/zPmCeJtiz0PK/5XMp5zjwXh02ZZaWGGrCttF?=
 =?us-ascii?Q?8qkCqINF4rjDR2QyvfofdH9qrjeIBE/0ICce+z1aqjWy5/v9410IWPdXgznY?=
 =?us-ascii?Q?ty5Oj5qaXBNe+ZuMaP0LFkeyPMRD3UrzZK9JFeh3FNqqRKf3IUvhJlxDcjI8?=
 =?us-ascii?Q?PQroaQscs1XGgCXns428vQ5gOF/kiqgJBqxUiAZERmIM4zhuiINWsYgM7Fwn?=
 =?us-ascii?Q?NNmcVVM4zyfjNnIbujhYPfR1EUNOMgJcz6Vm+EeSVn3Zsiu9JbTBdfc+6Uvr?=
 =?us-ascii?Q?RIbl3BhhigFmsgcbluV93yQ5K5kpUIF7l/Fu0lACefTysG335zd/d6tseR17?=
 =?us-ascii?Q?pY82lS/gyIouEwrIMylFIdFD7wakA0d12zTgNNWRz35VwHH5lBGjrsOxL1Vo?=
 =?us-ascii?Q?xXWPw+EkYnInDWAAEjNf5S3r4qXVQG/DphlZRQp6frKKKRcNhY3tkMjpUVA6?=
 =?us-ascii?Q?vsWFd1Uis5v9fFBDcERAoJ0scXWBjBtHBsAmM4H0LnDQcCETb+oCvPVUluyz?=
 =?us-ascii?Q?NPjwvi3swoOQbA0Psnj5MtJzv45y1InXuIENjPEEUfQc8rlHxkRBbQFQvk15?=
 =?us-ascii?Q?9dC2Ams3BekVj5H6Ia6T/giQQtyrOWwi5CnqKQjimXw0xFiEhx7tSfB7sqCq?=
 =?us-ascii?Q?HUd3FdeK5jpSeEgE/nHtcaaI2EdXOoMybWGZ+IRMKimZgFuO0F4s+ZbLSl5w?=
 =?us-ascii?Q?g0QMnWt8rSi5dD2ui55h9PxpAWV00FD6hRiKLT3c1A4wXzxgvA8tEOKW/zOv?=
 =?us-ascii?Q?7pAeAi/cDpjm55lDpNoYVM6NJA3VgiR8lHOjaUZ0GBwtSu7m8tF7hfFeI01L?=
 =?us-ascii?Q?jKyUV00dZCJ4MYKuJRS3k3aWXjYNOsF4n5foYm/CdJS/durBAoxTuLDq4cuW?=
 =?us-ascii?Q?9rmE29tkHS7bhF9mILeoezDEfxhaOFdhOk7lxvXgURjIgNiK6pSlCGwzFOgL?=
 =?us-ascii?Q?kv8HVV94excWtsigdcXOqfqzw+TscY1FqwNXbcNX1PYcEyRq4UnRPw7OMpT6?=
 =?us-ascii?Q?7gsvXOVDIaIxuxR1b+AfFkG9ni6EtgFsb/05bvauqCGWWPGP8oi9FKELlNsT?=
 =?us-ascii?Q?hEpxj4Bzpe69A0USb+4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e1b148-b00c-4b84-c28d-08de07e874dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 10:33:30.7236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jX4KuWpetV/ptflw4lOf9wAP2Pn8j0oBwPmNRmiynmC5qa6wGSVIZaygE+s2C7bQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859
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

>-----Original Message-----
>From: Pan, Ellen <Yunru.Pan@amd.com>
>Sent: Friday, October 10, 2025 10:13 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chan, Hing
>Pong <Jeffrey.Chan@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
>Subject: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic critica=
l
>region in SRIOV
>
>- During guest driver init, asa VFs receive PF msg to
>       init dynamic critical region(v2), VFs reuse fw_vram_usage_*
>        from ttm to store critical region tables in a 5MB chunk.
>
>Signed-off-by: Ellen Pan <yunru.pan@amd.com>
>---
> .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 29 ++++++++--------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 33 +++++++++++--------
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  9 +++++
> 3 files changed, 44 insertions(+), 27 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>index c7d32fb216e4..636385c80f64 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>@@ -181,19 +181,22 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct
>amdgpu_device *adev)
>       u8 frev, crev;
>       int usage_bytes =3D 0;
>
>-      if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev,
>&data_offset)) {
>-              if (frev =3D=3D 2 && crev =3D=3D 1) {
>-                      fw_usage_v2_1 =3D
>-                              (struct vram_usagebyfirmware_v2_1 *)(ctx->b=
ios
>+ data_offset);
>-                      amdgpu_atomfirmware_allocate_fb_v2_1(adev,
>-                                      fw_usage_v2_1,
>-                                      &usage_bytes);
>-              } else if (frev >=3D 2 && crev >=3D 2) {
>-                      fw_usage_v2_2 =3D
>-                              (struct vram_usagebyfirmware_v2_2 *)(ctx->b=
ios
>+ data_offset);
>-                      amdgpu_atomfirmware_allocate_fb_v2_2(adev,
>-                                      fw_usage_v2_2,
>-                                      &usage_bytes);
>+      /* Skip atomfirmware allocation for SRIOV VFs when dynamic crit reg=
n is
>enabled */
>+      if (!(amdgpu_sriov_vf(adev) && adev-
>>virt.is_dynamic_crit_regn_enabled)) {
>+              if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev,
>&crev, &data_offset)) {
>+                      if (frev =3D=3D 2 && crev =3D=3D 1) {
>+                              fw_usage_v2_1 =3D
>+                                      (struct vram_usagebyfirmware_v2_1
>*)(ctx->bios + data_offset);
>+                              amdgpu_atomfirmware_allocate_fb_v2_1(adev,
>+                                              fw_usage_v2_1,
>+                                              &usage_bytes);
>+                      } else if (frev >=3D 2 && crev >=3D 2) {
>+                              fw_usage_v2_2 =3D
>+                                      (struct vram_usagebyfirmware_v2_2
>*)(ctx->bios + data_offset);
>+                              amdgpu_atomfirmware_allocate_fb_v2_2(adev,
>+                                              fw_usage_v2_2,
>+                                              &usage_bytes);
>+                      }
>               }
>       }
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>index 96bd0185f936..c0810c53703c 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>@@ -1943,23 +1943,28 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>       if (r)
>               return r;
>
>-      /*
>-       *The reserved vram for driver must be pinned to the specified
>-       *place on the VRAM, so reserve it early.
>-       */
>-      r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
>-      if (r)
>-              return r;
>-
>-      /*
>-       * only NAVI10 and onwards ASIC support for IP discovery.
>-       * If IP discovery enabled, a block of memory should be
>-       * reserved for IP discovey.
>+      /* For VFs with dynamic critical regions (v2), fw_reserve_vram is a=
lready
>+       * reserved, so no additional memory reservation is required below.
>        */
>-      if (adev->mman.discovery_bin) {
>-              r =3D amdgpu_ttm_reserve_tmr(adev);
>+      if (!amdgpu_sriov_vf(adev) || (adev->virt.req_init_data_ver !=3D
>GPU_CRIT_REGION_V2)) {
>+              /*
>+               * The reserved VRAM for the driver must be pinned to a spe=
cific
>+               * location in VRAM, so reserve it early.
>+               */
>+              r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
>               if (r)
>                       return r;
[lijo]

Since you are skipping FW usage tables, isn't drv_vram_usage_size expected =
to be 0 anyway? The discovery one below will need a separate check though f=
or now.

Thanks,
Lijo

>+
>+              /*
>+               * only NAVI10 and later ASICs support IP discovery.
>+               * If IP discovery is enabled, a block of memory should be
>+               * reserved for it.
>+               */
>+              if (adev->mman.discovery_bin) {
>+                      r =3D amdgpu_ttm_reserve_tmr(adev);
>+                      if (r)
>+                              return r;
>+              }
>       }
>
>       /* allocate memory as required for VGA diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>index 6eca5e8a7375..461e83728594 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>@@ -940,6 +940,15 @@ int amdgpu_virt_init_critical_region(struct
>amdgpu_device *adev)
>               adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =3D
>                       init_data_hdr->bad_page_size_in_kb;
>
>+              /* reserved memory starts from crit region base offset with=
 the
>size of 5MB */
>+              adev->mman.fw_vram_usage_start_offset =3D adev-
>>virt.crit_regn.offset;
>+              adev->mman.fw_vram_usage_size =3D adev->virt.crit_regn.size=
_kb
><< 10;
>+              dev_info(adev->dev,
>+                      "critical region v%d requested to reserve memory st=
art at
>%08x with %d KB.\n",
>+                        init_data_hdr->version,
>+                        adev->mman.fw_vram_usage_start_offset,
>+                        adev->mman.fw_vram_usage_size >> 10);
>+
>               adev->virt.is_dynamic_crit_regn_enabled =3D true;
>               break;
>       default:
>--
>2.34.1


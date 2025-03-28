Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F5AC3600B
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 03:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A719E10E96F;
	Fri, 28 Mar 2025 03:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WDIm901o";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2048A10E96F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 03:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI63HHSVKnGDWlOQAlHDJKMqApEw0R/CJRPDdgyiXICF7hDQGOw0dwnUN+Ty1H4gFC4Q/VushO8smTwM628b/DOu102R298uLxBhPKZmlrcHCKsGF3KPCveYfERSZ6M18C9rgR7ZmBIzNWVch2yTd5QzgalSTxN5yLAjtinat1I8fRC+uayxMqlcP3VF0BH7w21aD40qOudIgx/r6ulLN888uTgVkhj7wUPFvD7fIFiQ/vbeNB/maZTr9tOQu+oabRiIzQ/DyGm3zab6FZSdrhfuJ5Gys1MiA0mfnQ+29RchZ/zdNTOl53otom6hjGSGejysGm8bnnrhxfi+N+V+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MKjRriviMUj8kTqU52YO3xLZBDxrGuJYEnS2Yh0Wdo=;
 b=JS2jD8vaHBsqw8vY4vGZ+gdtLO71bclxtoUcBh4L57/wLW/Aun6HSSd11gwu2Y/5m7y1irRTzks8TBqpUX3am7+SgKhGjEebbSRVpDA6ygh4rKH8Wvg3zSxeAp1HnaPqMVPY3dQ3MRtvVwAqU4te/lbOqNgPoyfFuE9ixU+roz8UQbhjvKtomGp6CoaYw9s2zef0FkM6SAiIGEwxpvU/emDwwTNfu5bGBIstp3y7GTlrIAvOQjVlOn/V56T94F5h6apo4sVKY44sFoceA02hpctfRuzICfjM+W7gl113ATsGbPK2sxRWB/DMv9svynt4fC5LRIdXNGYumaxP7ywK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MKjRriviMUj8kTqU52YO3xLZBDxrGuJYEnS2Yh0Wdo=;
 b=WDIm901onGeQQs5t3hcn2X+GGYiSqqtyVqkOGXgqHETdttHwhWi4cMhtYJx0o3AgQo5zfozMKF+J3AQl1C3b/4SbjWBI1lLMd8Oxrcg0/L36TelMsN6y68Zfhjjmeq7vSjBeyh6J+QTgDXA682BFNEsjCD7CVRaafl6Pz1ZUhIU=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 03:01:19 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 03:01:19 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Belanger, David" <David.Belanger@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>
Subject: RE: [PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9
Thread-Topic: [PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9
Thread-Index: AQHbnzB1Zi1rnj87JUuv/4GMy23MUrOH3PTw
Date: Fri, 28 Mar 2025 03:01:19 +0000
Message-ID: <DM4PR12MB51526786ED1FBA6D0ABEE87FE3A02@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250327155339.1756101-1-jonathan.kim@amd.com>
In-Reply-To: <20250327155339.1756101-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=adc35b02-de58-43ce-b03e-a5d9622a2452;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-28T03:01:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH7PR12MB8793:EE_
x-ms-office365-filtering-correlation-id: 2ef4955d-7ab7-4d8b-3e77-08dd6da4d054
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WGs2hY4WNsBW8PpdGktmBUn1SuG94xrTzmFRUXQW+19Z5sEylmBxGQ+xWvEj?=
 =?us-ascii?Q?eErc5iBRPEy/lPjGKjjeV554gJfTeQnU0PBG10u3639X00M7L/QsAP3FGLa2?=
 =?us-ascii?Q?brfpOEbCu8o/87oo7MQglXqfJcP2p/EN51ZUDw/ub5lsyyUcNOt3sHWk5Mw4?=
 =?us-ascii?Q?05HXJmpUPt3YWzbdRQAmtDCVmw+9pjKCuBkaH1OypTSPdE/jf11/nV9k34LE?=
 =?us-ascii?Q?Z7nbubHCK7V5q0HDEBrK1+b3A16A2xHwVjIu96K+lnUPqxBWGar1lh8Hyzp5?=
 =?us-ascii?Q?N+PtCt5sKr5g1rI59otYbj9Khl+lv/ATPyREftkoJdhjnjgOyhwPHdprZPzE?=
 =?us-ascii?Q?RmVTGALfpYcrCTQiTuOrKlz67hSTD8OcV8tZ49S5mrwkLCkcahVa5zBmJKCP?=
 =?us-ascii?Q?AbLls7E4+rwFzJr9k2N9QS/9QLhG/c6vJ+njiUf3oemjOs4xg1tmO5bibIkc?=
 =?us-ascii?Q?gLz5Ina8699MCkOhUX00WDPabKlp/cxrxLoGC42OTzC4hk8H74ZXiPbODuVw?=
 =?us-ascii?Q?MgeZjhGuc7vtS5EtnrCkGkV6EwhAIDfkopr8D/OIEfMQ089IaUeur30Io0R+?=
 =?us-ascii?Q?hwSecjy9+a+9ogOKEBDOw3+n0FDYd4z/yWZEnKiszmkBxyTmWfO7vQxA20HX?=
 =?us-ascii?Q?Jg6ErVxGT5QDJ6+F4Iw9LZCK3gAUueThUTo3h/Ggb/DPFimaJioWsP40whsO?=
 =?us-ascii?Q?o4EWFZky6DiEIPUDsQ+5R6+PwnlSKJv+fut4O0nu6jTM5bXb/qcVdar7RpOR?=
 =?us-ascii?Q?cHqw/bRQtMLH4Z/RcX0O5Ri2Hw3IBDGVyxDJjbQaZCFl+vgQ10aeuf9yWBnZ?=
 =?us-ascii?Q?PPsLeOUdKbmeXaIJWfOnANBcy9fCpgphqhB5rwbWetWR/eYyn+LobBssLXJl?=
 =?us-ascii?Q?XzO8AtfeqXuw5EOF+8mqxDY+4uX4G6xJ/lX9LdOAPB8a4+APn0/P9O1lgW0t?=
 =?us-ascii?Q?VLzGVlV9GRfRM8kpPoDZiOhgFCJZjunCv2YmVLjueeV6XJJ3mIgFvzFPt5zN?=
 =?us-ascii?Q?ChB8MJWlDWxzczpkiGi4+MDdaxt9HvQ735f3IKWJE/5pK+8VZQAWLBHiYHHn?=
 =?us-ascii?Q?q7F2to5T7ADNhuqO5DBcQZRi0pykPje+ctKtzSlVxx+eJ9OwBzkL5xvJhJ5B?=
 =?us-ascii?Q?hjt74mxQ5kAsnTK1XAMK/njmZX0mWhWX1de4y8yFlIHz6EKvW621P1lnPiSx?=
 =?us-ascii?Q?Pt1QsBKrSzg2n3gsnvIe7Sfi2zRKZdSntzVoCFs5yoDwMzC1zCmKPJSK+BcP?=
 =?us-ascii?Q?BLrEnXjzk8ONXcI9044Gsy8s/XYBvciusmp4PXiE6201gJZ4oKUcBmq+wBXX?=
 =?us-ascii?Q?20U40K+DCFPJT3/P8yjcTVGycuH63gUwoqBQ9WRSGT2Ye4UHuYQLb7gcPX88?=
 =?us-ascii?Q?OhAy+I7mKCmkrODORHsh1OhNueeh96MoZ3dM9p1LOpHeq7Y6FXGEIz+fi9p3?=
 =?us-ascii?Q?neEh3v0HCOM37ET/FYgIzhGLIN1QI1ql?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q23UJRr158t8RptIKCli90rVwKPwZa4yY8Vs1LjdsdQjRbCyth5t+/K1D/Oq?=
 =?us-ascii?Q?baHURgp6zVNigI12KsfmhdV82J9eoYMpAXZSF1ZBLDm5qavWI8r1nyi65m8m?=
 =?us-ascii?Q?avcDJSJ40LEcHd3NAQ4R2OshpD7oVaLNhL+P7o4UEHcR1GGqzzZ1jLBUVS6p?=
 =?us-ascii?Q?Li2rfndazRVJZnPPbLwB7payfAV7uyEO+METFZeaN6Ton6b1XV8P998HCems?=
 =?us-ascii?Q?7//mzTWl2PDjVwC7uYG0ZEjv9FeAtHOcdb+gznKKuUhSJsHDbTG7Ds3pByYE?=
 =?us-ascii?Q?Qt/JJJplg5gkKgZH5uM5LG1wGVNv5iQAZSKTfcefZ5tYev5ojrJxC9PqcSKq?=
 =?us-ascii?Q?k7GdOOXluGNnF9m8KHoLRRaP/i6z6J9z09X0VTy9J5cPuxLZTOqqJOSwwgu9?=
 =?us-ascii?Q?hsYD2QRISNbYHlrSh9Gr8rToBjpAhScikQP/qftc5YEeSIzsIz1f732UT2ck?=
 =?us-ascii?Q?bD6FjH2B3l4xEnvbY6Mp5RiVFt0jje0nnxYm4HMKNfHzfQ11oEiZs24SJFA8?=
 =?us-ascii?Q?ttLbcfL4WuCO/+H+bnV567O5WnJfCFRAmFp2ZnYvTwPdtyrrK0/YcZeje1Ny?=
 =?us-ascii?Q?+ZwREg7HuBRnmqQwk/dNav5oxKTIKRtokJPIvg0h7DuN/XWgUPhgcE1vkqJF?=
 =?us-ascii?Q?Bj7SF9yxioXiMPkGs7IMP08k42YMPzgCeoROCjiBCf80Irqn7+k5X3Vxvum5?=
 =?us-ascii?Q?JJh8zK7G1hFpHwP5hn37K9sv9fnwgWz/0/saPHIU4q6eO7uwB1p0Mt2SxeeS?=
 =?us-ascii?Q?DIFbo3ETW3pW/kSv1UZQxr/t/DbzdVnj9qrINvQSZjUoNzNigvV9asYsB53R?=
 =?us-ascii?Q?Gt6bim1hLae13R0EVLR8kqqkP14iNl7izi+lssB3F1J7jQ/UiqWuOiVfw3gh?=
 =?us-ascii?Q?qr8zIKx2cibDMKbA6sdKPHRdTrqmOcOUQ6VpSwEZjJWRmi/qFIbsSgcJDSBS?=
 =?us-ascii?Q?12udVnbNBo3CqGbtI5gmp3+pBxmWWHU7YirNpgmQS3QhkH9JjTr4DzeZ0R5T?=
 =?us-ascii?Q?eFam52T5ITvGhD8S04QOSxxmrvn7Pp8nv577/2XTzZbZE2WMSfXrHYM29Jyv?=
 =?us-ascii?Q?m3sY4JnfFyarTQDKqB6Vwf+RjGtkwOeU+m68OjUgL8W5GAe6+ma0BYaEW4QS?=
 =?us-ascii?Q?u0h6MW0PQj4W43181vHiDLQUaYFOHngKczoDDQUpmD3A4X/P2nlMtHgIItwy?=
 =?us-ascii?Q?4AENhV0E4eFt+HMm58azJHdtQvAl1FopSzk1tySCYNhGr4uzNR50VN8DFGLu?=
 =?us-ascii?Q?NkbYOq0MU8xr6OLtMxb+yVKt20YVcmmvry1tdyNvakeK9qvT1HxbDQJNjmo7?=
 =?us-ascii?Q?g/pK6SD8cBwWHv77RQMSUVAINOkTYs09cQUkrS2bBu2t1JPwuZ6fxM5vDH9+?=
 =?us-ascii?Q?eUaaBBIbp7+5NZVISuYqCxSvXohPKk0RDaljVovxbFu8KQUnbPLPWgXYcbVj?=
 =?us-ascii?Q?zVJTa0/y7KNnGAwcNZSJKpfejqW/IGwFpIhXlpmhLXrobnkXQx6T1sQEUMKe?=
 =?us-ascii?Q?Fcf+Ra2vkS0z3YIllgtqMqz0WPcnygeocBPSycbsbRUctWFHkFJwQTA6Sw/Z?=
 =?us-ascii?Q?gTsR2UvUGSKXNgjYBGk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef4955d-7ab7-4d8b-3e77-08dd6da4d054
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 03:01:19.3383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZNUEAd4QOljwwyZGYsDQneI2cl2Jr1/x/IUCQ/XzFld0RBebr4di6Mk96IwgraCgWxrn79fLb0dZ1j/flMvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jonathan=
 Kim
Sent: Thursday, March 27, 2025 11:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Belanger, David <David.Belanger@amd.com>; Kasiviswanathan, Harish <Hari=
sh.Kasiviswanathan@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9

ASICs post GFX 9 are being flagged as SDMA per queue reset supported in the=
 KGD but KFD and scheduler FW currently have no support.
Limit SDMA queue reset capabilities to GFX 9.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index e477d7509646..993eef5a4983 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1983,9 +1983,6 @@ static void kfd_topology_set_capabilities(struct kfd_=
topology_device *dev)
        if (kfd_dbg_has_ttmps_always_setup(dev->gpu))
                dev->node_props.debug_prop |=3D HSA_DBG_DISPATCH_INFO_ALWAY=
S_VALID;

-       if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QU=
EUE)
-               dev->node_props.capability2 |=3D HSA_CAP2_PER_SDMA_QUEUE_RE=
SET_SUPPORTED;
-
        if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
                if (KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(9, 4, 3) ||
                    KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(9, 4, 4)) @@=
 -2002,6 +1999,9 @@ static void kfd_topology_set_capabilities(struct kfd_to=
pology_device *dev)
                                HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATION=
S_SUPPORTED;

                dev->node_props.capability |=3D HSA_CAP_PER_QUEUE_RESET_SUP=
PORTED;
+
+               if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYP=
E_PER_QUEUE)
+                       dev->node_props.capability2 |=3D
+HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
        } else {
                dev->node_props.debug_prop |=3D HSA_DBG_WATCH_ADDR_MASK_LO_=
BIT_GFX10 |
                                        HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
--
2.34.1


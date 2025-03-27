Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883A9C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027D610E163;
	Thu, 27 Mar 2025 20:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWgfz5QT";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C1A10E163
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8b3sh2G3HQBiDEA+9NJXhT5GHMWiEyoTVvPiiFJSJyZkyFAoz3XKmnBF+UjWD2ioIzi8jinQv/uuKmF8kha6rJDfFbSRyPvXJ/TCwRCxXBDHGstauEg+n3U+JesEYvb/r0EO/JMSVRVdrW6t8pK4HyHBd9+gwR8ZTi/T7FgC2VMInz3l3iOt4FgM3zvORS4M2LELPrpXBA/eO3wRACCkhuHMmfPVkIa1YepUHfZQqPdl8a311BPwPB078SryaB7W85kj8XkBXDQQYbI6PcEsr+Ts6O7wJOCgi7XXYwk+DC0y+UX1KL+lwVztZ1oEBBd/LBOnO19SRu1B8ZG6+OPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqwOFqc3Qz767i6h5pe/LyASZXYf952B//q6keVZoF4=;
 b=MEoWUKxvTGpvdY1f1pbZeRLb8yXuCR9/Gugp+JN1xZzSEwZyJfjnq5qLtYJZxNT7iaeGBBoBSwmU8/mbbC8k+1TxDQig4lKWOxKl85UUbcYARpU4bYjM6LLTFnIYCTnAQmg41FlBH6dr0IfDx2Z6kzJpsXr3uBE0U2JcaLL/IZJcAk5pDnwizkBGSIMguqdH9BcAE9ftn7tgI96oZ9jfcR83S/7sqn+L+YP9zIXAPv8xwilkrdo4mfIC1BnawsMOED804bqIHQpyHCXITyRCD2aGqg38AS3GuDG2LuYwqz8wYZjWv5RPsUdfW3NIb/7JWdgrZOSLVZQ3jgtp2SbGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqwOFqc3Qz767i6h5pe/LyASZXYf952B//q6keVZoF4=;
 b=NWgfz5QTewjdt0dHvxAYDr7LZvpvCliRDShqoQ6ChO5zastgVHXdDgzVKIvvi/fFgr3WTiTCrlQFeOozKYjqjMjz0yj1vI8XAmS53T04CAA5y0vZJNi+tugUCperAOyoOtFnt35obItZX0orMeFpceLs83QU6UTMoah34/kq+e8=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 20:24:46 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 20:24:46 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Belanger, David" <David.Belanger@amd.com>
Subject: RE: [PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9
Thread-Topic: [PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9
Thread-Index: AQHbnzBvDKIDs5qZ7064viw9O1fCoLOHbb2w
Date: Thu, 27 Mar 2025 20:24:46 +0000
Message-ID: <CY8PR12MB70995BEF7929E814094DEA928CA12@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250327155339.1756101-1-jonathan.kim@amd.com>
In-Reply-To: <20250327155339.1756101-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5455658c-20e5-431a-a964-79b87f3dc710;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-27T20:23:42Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DM4PR12MB6232:EE_
x-ms-office365-filtering-correlation-id: 68a87cd2-90d8-4b55-ebd8-08dd6d6d6a99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2CcQwqx33fJemfVq4J7YXZAT+0Drc2VxH1IsEeA00Aywq8SXkz773ggcSXav?=
 =?us-ascii?Q?L/d12GpZcJ4AxmfEa2i7gn8glSm9tyzo5FqtAxJJhKbDXr62Oy3O9yvmk/2+?=
 =?us-ascii?Q?KQtVlyFoj+tNc+Ikj4vtHA/R/jGm2/LRpgYmCYznjHp1WBN2H2XNl2+3bjv+?=
 =?us-ascii?Q?snZyu+f6Edt+s2m4ynpkFhpWYQHwQXD9fphmoMRaR9t3l7ZTqsopmDj9P9FY?=
 =?us-ascii?Q?4cDcNG4z2PZEBiUThzjmiMKYfg6HWhc60fiej41SE1EhZD6zHrIdJ7euKmNu?=
 =?us-ascii?Q?vi17Uzsz1c9Bln6NW579R4KKMKB7qgxA13XwJmeAkYjsLpGarJP/+zHN8GYP?=
 =?us-ascii?Q?CiDF15j5TVeqxlVGp7P3TWqvJ9BFgmPtI7FgKEqcGoan8+1X4eBF1fpTFxK9?=
 =?us-ascii?Q?7YC+9+FIwv85O8KeuTlcn+CmBDtWfqmajr/7jRSWDJaq9bnxMajK21JTcphq?=
 =?us-ascii?Q?GuggNrWuhrAomgchV5+pwAeY/i0t7GAlHBz/UmeNVLBtn7gCS2m2DUaIOfEp?=
 =?us-ascii?Q?Byq6UXBj1YrBRpJjI1gHDjQMgjKcNfBs4AZlvSHvvvZbcgBAkY7KrvsQdyuO?=
 =?us-ascii?Q?i0BPugJaLkx8yugcbfu2c7IGV1uxouxUf9yDT8qET50o705C/JLzxoHURmZ1?=
 =?us-ascii?Q?DBpFRDHaqTGWMOqN+7qyIR9f3VsoxOkdUeArsskct4YKTh3lRHHB2hOz6LSn?=
 =?us-ascii?Q?xMtUe9wZkN2Hx0/sqXxElqElI7hAFsazXKoj2Z8R2m/6o/ZsyDk0EQNFCsjd?=
 =?us-ascii?Q?7wl3hpf0BBRh2fRvsvmobXSoXqFgdc2uZjlG4QMdyPRYv7qoJR8wUaOPZcWZ?=
 =?us-ascii?Q?KF/M6VqgLZSvVh/jzMTMCjTvlnHJQcOTdu7vyPJWumfa6E7h3+iLxBLR/1xV?=
 =?us-ascii?Q?5T2Lt16i3bG9BfoK1nMDYF0zzqcZVwlm2kBlW9Jvw/rSHdGgjou0is+LX870?=
 =?us-ascii?Q?djsq8lsGlZrxqchlJ/grDXlXpzLbyhAbaBTweBB9Cmr3ozTVGkcrqDkxB3On?=
 =?us-ascii?Q?6Ylyde4Qy05uF+Rwat/FTiIgSeveqHaGrTOFjjzRxV875AYvDGABUF5jMA/N?=
 =?us-ascii?Q?DrilBCm+ZPOrgBAD8dGolm4w7sFOfHlpNJ1v5+GzLusd2HrEcsIwneb91ORO?=
 =?us-ascii?Q?x0CblEwjTqIMmdvKRJp7V3Qw3Ba/myvhz3iq/3axPlzZh0rZJHqic+qD1Kz3?=
 =?us-ascii?Q?GHoI+R1lVfvLGvTBE+Ecpb8UGMrxrRNdTzYRWHu5b+tARJquc4Hm1u7c518q?=
 =?us-ascii?Q?9msm9Gw7DDzH5rcgTxOe5WhUTTGBiKv3PWYmMMRgIInyv6G3U7pFQHXG+yjs?=
 =?us-ascii?Q?qyxS0WdhohR3/BUdLyGIhaX1El8khgrdHLWMY6MieEXjwSd5T0LhGICBEU8p?=
 =?us-ascii?Q?SeR++HKWf7tYACs0CM0cAB/tzHFVmrsyfjnGJ+A8gfURKEy0kcBu9C8Rl0Tn?=
 =?us-ascii?Q?Hx1YgTpQmuirus+mZBIF1G/6TsIFQQcQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gn+IT0uvG1JDsMEPEnv2zTdYRfcsyE/t0Qgwc64Q79spEc046GvlyOMTVH3p?=
 =?us-ascii?Q?ZaHN53qqjodri8Nkw1ChVfm7yQSJQK9/M2JS3ejA5hRg8SjgLhe25oxh0TlY?=
 =?us-ascii?Q?sIVma3fZ31p23r2Sv/qI2R75aWbdVCzmzPZHNJBPgzTZUZ/jwnqltMMNDxmz?=
 =?us-ascii?Q?KAQQ6dXurrKFpK58eIqOMwH+rMs0Me315HcxOq+vmy2drC39XHp0gGQ0neYg?=
 =?us-ascii?Q?SgCWwtHVpEyTY1bdN2leAs/A76QSzE98/c4rYi5sLRxXD0OsvnYyhcI7RLZu?=
 =?us-ascii?Q?cIA0/xjmAQEJFL7IVzTJFk0E+jZuV3GHL1G5budoEii/I67qs6tIN0ZCNT+4?=
 =?us-ascii?Q?RjSDFDQHOnwFegbk83Xwt+rkqAUhTrkC7d/pwBmWmU5/N6T/Q3eLvnuljWxL?=
 =?us-ascii?Q?BWxrQUO07VZonKsq/LlthsBqZfpqCYSnVtVK63qrwPNUc3NWyH+0UQPxUvNR?=
 =?us-ascii?Q?HsdtO50rlt1nraRasQOf6BMdRhhF5hbusYcr1Qqp9gw37IHUWin1S00GtRmQ?=
 =?us-ascii?Q?1z67arRIeEQtmFqlzBCHyoGv5A352Rkzgfrk1vSuH98ZSqDay5B6NQ/m+iKa?=
 =?us-ascii?Q?OIxPPobvWLLl5ouhkAczj0y2gaLyYy1ivwV++8KoZ5S6vdjtMeRI0Vu7LAjR?=
 =?us-ascii?Q?8sdyhh2UWJTT4my4i2KkBLkjKmLIYTj2jv7iVaVSTnghwbKMxTmYu3F8DbnH?=
 =?us-ascii?Q?rLLMtYfyX2DPWF3XV2v977jYz1w2IHP3aX6Aq9HZhn/jl7S7zVIKSlgPtN2u?=
 =?us-ascii?Q?yd4NMRHd+L3LB/j5tPf2+4jMS0p4eBPPhmRsEMyjGm6qjJriluoJCospWe2J?=
 =?us-ascii?Q?pzKT9X1lbl15xdloQZ2w9Cf+APpjY72AyPHnczhclcRgLu9lCB/jZJHLkKsY?=
 =?us-ascii?Q?KD2aK668C+pVZmvQPnaUb30snU6JooofMConGpvYsFsWz5ROqdRaNsULkUwC?=
 =?us-ascii?Q?9kJX9iqOmSmUS+IqPB2QINZrbzvresT6PXAqWQApKT2TszQkhHVPECUlSj+d?=
 =?us-ascii?Q?ADBrCTNabW/F6e+K0AzaIjN98V8af7rLvsPm01qjP+8LxASwjYtWBZzPGYzy?=
 =?us-ascii?Q?QJFSxwoAeim+Y4biUIOnkIds9DZUZRKj+SNvuxQA/AJtPqjJv8CcvI4wf38F?=
 =?us-ascii?Q?FTI/nP4l4jlOEcBRxJ/AaCCeOWV/YlZB8nIrdP89Sg8X/nbxB/TfI6zi54m+?=
 =?us-ascii?Q?vE66eL1oNHOwkI8VjzYmjDqBDQxnCqt73S8qEnS3JSleI8t/FFxSeoTzjwU/?=
 =?us-ascii?Q?7GJJDEhbzcB/38plQrLYGIDAr6FPfqteRg7ainClpuZV6TIrjaty5KINT7+5?=
 =?us-ascii?Q?r5mcXADI+OXwv4If6KSVMVrhhC4wVS9LSjXTtRg+TyJjFGp64GO7xUKiEKSP?=
 =?us-ascii?Q?UiPE9OMuihwilmWWq6aHl+M/BFhLN8RpKP+HazJd4DRwMRIXg24uq+NM+oxq?=
 =?us-ascii?Q?2f7lBr305IJjbcGezKeJYtcpSWgJq4tTLx5WUwu4hmVtn7RRg2Uih8zLTCf/?=
 =?us-ascii?Q?8QFbJRHm3FR8tjYm4nNJnJQak20pOUimhcfIFaEfUY7Q0Fgi+fm0i0FpdzPm?=
 =?us-ascii?Q?R0uFj1Lj6hrsQw/IlwQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a87cd2-90d8-4b55-ebd8-08dd6d6d6a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 20:24:46.3203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGWqikNTCSPbyGSbTavRvWt9i35HpjuFnI6u+Pfia5G+hgDl8Zff3ox7ha0Nlq5RMYymkJBHgTvPeWMRkN6/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
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

Please add fixes tag, with that
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Thursday, March 27, 2025 11:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Belanger, David <David.Belanger@amd.com>; Kasiviswanathan, Harish <Hari=
sh.Kasiviswanathan@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9

ASICs post GFX 9 are being flagged as SDMA per queue reset supported
in the KGD but KFD and scheduler FW currently have no support.
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
                    KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(9, 4, 4))
@@ -2002,6 +1999,9 @@ static void kfd_topology_set_capabilities(struct kfd_=
topology_device *dev)
                                HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATION=
S_SUPPORTED;

                dev->node_props.capability |=3D HSA_CAP_PER_QUEUE_RESET_SUP=
PORTED;
+
+               if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYP=
E_PER_QUEUE)
+                       dev->node_props.capability2 |=3D HSA_CAP2_PER_SDMA_=
QUEUE_RESET_SUPPORTED;
        } else {
                dev->node_props.debug_prop |=3D HSA_DBG_WATCH_ADDR_MASK_LO_=
BIT_GFX10 |
                                        HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
--
2.34.1


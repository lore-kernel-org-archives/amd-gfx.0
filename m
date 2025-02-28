Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33B6C282C1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 06:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBAD10EC0C;
	Fri, 28 Feb 2025 06:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ahgCv+u";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D301310EC0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 06:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=do8l7nFDizDMdxX83FRowdNogSLmMQJaTp37iIig2C7pNqpCIY3RP9OSEU7LzBkvLTtGOlyxKZYs+DciNQxeoFSw8OQgodtmzbZSVWCf3pOCLX8GO01vXkMN4qmDCC1YWa4PIGNr2MHI1VOeuBAoMwsCQACXnOMEg8R5PaYNxxEE67liDFXVP8TN1rs18V69yAiKJCZ63T9sNOQHaQ2WaY5fEsR6mMkqr11weiZtAJL2wN1sKWVyBbETBNHRYHp8UFWo5+OLqfsaN8YUd3uF4bHjh9CFoCu+9Mg8rBe4c6A6xG0qzAbbeXjr/z9qjU4OOK5bFuxDnqNkNBZy53bW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQTWamQzuVgE6VRwSmlDTeVyQ6UiDq42+rXZXF6BdxA=;
 b=uO8t4dpVSa8pBkKAxKvvZ5gaJZgD6EMhPrimnQ7jLXwpzRge03xN3m4Vqg92d3oZMm++yMo9aU//Nw4PhZHIZ0yRImdC0Ixz5G565ZGIM16z46S1gqS2l45AZgLlMbG1nW7srUoLxJ9rkjN/anXBpOG+D8ubB8Penc/A623asD90gjo5AYEUOKm/FeQowurrUeqvHVJyuk7wyjyZMhtaI2LqJwZFFK8rgtgT39A5ujay9h5T9nBl7/hj/JW2EmZmQpiIy+dZLKB8FXZEehAyQnIflNCUNpYxtBihvb687JKEXUxsTPIeQidUo53Wdq0Ms2jYHJhetSsyUe3SFpFMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQTWamQzuVgE6VRwSmlDTeVyQ6UiDq42+rXZXF6BdxA=;
 b=5ahgCv+uP/wILJWwP/2ybKiuP4TW+UJV3eS5UiStGejiRMvvbIfjnoupivSmx9aNdMJt3xPukmwSzxVOqcAtK3v4jezFx4cg3c8BLvaE5oV/psOFTRaiSZ2DtRU5kHzyLUfKaDx4gjlgl4DT7aS/KzC+XL2C0EgQJuFugpA9/UQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 06:00:41 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 06:00:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yi, Tony" <Tony.Yi@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Liu,
 Xiang(Dean)" <Xiang.Liu@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Thread-Index: AQHbiSozFVQlihwf2kqJo33/uGOPkrNcOAiA
Date: Fri, 28 Feb 2025 06:00:40 +0000
Message-ID: <BN9PR12MB525707C7AEA3F8E792638E57FCCC2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250227151217.2620348-1-Tony.Yi@amd.com>
 <20250227151217.2620348-2-Tony.Yi@amd.com>
In-Reply-To: <20250227151217.2620348-2-Tony.Yi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Xiang.Liu@amd.com,Tao.Zhou1@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8345a268-81ca-4ef1-9c31-82f6a67b9b9a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-28T05:54:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV2PR12MB5776:EE_
x-ms-office365-filtering-correlation-id: 8c4b3971-a57c-4121-ea22-08dd57bd3b02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wgLkJRZGerbxT+2QgypZpRApaytqWZHpi+5QvQk977/FGLhCQGMsVJYobvMP?=
 =?us-ascii?Q?1tpyXd19Trt2kPUBN2tiMGwGVOIuSdqCJxTCMmbjvT0kOhLnrDCRgvzOFTGW?=
 =?us-ascii?Q?y79XHOjOj4v9EWCY0yH6wQu3D1OD668VPo9VLSDp6QQ8OCwN8gWsYY7liP08?=
 =?us-ascii?Q?kS5bEUOIoUmAm7od84Omd000bZX5HWSGeaSG502N9pwxJ5Su7p/5Clq039BM?=
 =?us-ascii?Q?B4jjpMvP4ovz9FjjoIRQWO+S4e6AChjHG8lwLwkBDSpCagkspV6W0nvIuRUQ?=
 =?us-ascii?Q?o+KHBR/4w9nD+TsQ/ZZ/3pbz3wfOy84+cEZDC+xhyG1bcAlWomHzPepgw2qY?=
 =?us-ascii?Q?eMsP0EGf6R4pOXKTQ/uR+wcF2YGOpGtZy19ZoVHcRwMuv7mrPU3DA3tbwFrj?=
 =?us-ascii?Q?p8Xaui7jjeY6PsxVyQF4F3VRa7n/H+XAItb+hJ8GCyptc/taMtLW0fxyzQVn?=
 =?us-ascii?Q?6ZNAuIsACuko7LE8jmzSbrBsNDYEFiqLRFLFcsjaBIpRYIRhag8NN3KLR1Lt?=
 =?us-ascii?Q?cJ987OIfTbogxb9L+FyjkpgpQoVSuqpo4Zk9xzci17gtA3NJXgp7D0dXosva?=
 =?us-ascii?Q?y9EXIBeZZ3LRMakXpR3fDSiaOtZM/K5G3N41I/mr2SuNYJhEhfEP2Y3xsNP6?=
 =?us-ascii?Q?V18civieFOPRB2cjg2C8fvknxsiw1E5XygpXBetgVX3xLPEEQqi8Wme+hq27?=
 =?us-ascii?Q?rkF6Hez9JCCfzoc0HXbX6nNzSNhY0pfJEW74mP4USW6/0FQgsmzai0QLVMee?=
 =?us-ascii?Q?mxVCYx1j4V36GvLoL1rpdOOmoEe07o/xRYhEvhvlAR3PhX3ZuLm2vvI3qEdo?=
 =?us-ascii?Q?5+Jg+MmfoohSRL+lkJJLXmZl9V+MfzIWsH+QYvdLRA8WM2N0Iani+vzB9dmk?=
 =?us-ascii?Q?2qpJwr+XRyegoZ+ajXxPKaelgzECbg0XTpswm3vWQcCegdVjsIVu+C4jC/a2?=
 =?us-ascii?Q?h2HtnBvdkfR0lE3ra9AMClW/Sp7lV9UOsFcV8qYiebc2H92fKIvnSI2wuI8c?=
 =?us-ascii?Q?ViyxupR45sZiHqzvOAuOPo15cqwT6aoQ2HRyCGs5Wc83Nhqp+CFmivs8YN9l?=
 =?us-ascii?Q?ZenSmQIMzgJoncYOpTDTWzbPdNWuBbrAgxVLxlLvAiDOx20FHgJdTcAR/edw?=
 =?us-ascii?Q?ypExkiT+U5qSD8VvljzZLE6aiA/03GhuyldHs/Z8KUtVBcfqrQgvG3+sCZii?=
 =?us-ascii?Q?ou3kf0dukRd/oXZuN6YgD3zAwzLWyYH73LMPPm7vQJrcYumN84zgURm2j15x?=
 =?us-ascii?Q?LJSwyGg+PBBSeO3aOuYo+krTxythVF5QoGAWw47l8ha/ho5WKOmFmIhezq1p?=
 =?us-ascii?Q?r0QKWcedll2taOeItPzjbGt/rynNxtmnyTCFFLgHhXYKqJi3inioJd0ifFHh?=
 =?us-ascii?Q?wqbboqbbfKWJ4/mCDT/rYiU8paIZGvt+lm/91GapBs37OlOj/5HxQ8L5wt70?=
 =?us-ascii?Q?S4drIaZRring3Rc8VQ/d3ZyqCE+buvAkLnerwP9mF62xIMKNE4d5Tw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iP8vGPCRbu2zfoJEmPeirp+uI9TYwY/AhbgdKv0VTh5v1isr26evt8LwQ2fW?=
 =?us-ascii?Q?epSOEh7SKCeohvmaVJ2jcJGcD49+iJqsszdt5WoVoielg7u9tcWh3gBr1VKx?=
 =?us-ascii?Q?CZQy6zTiAmmTIRcfQrziI73EeDOL+tSrgUwG6+mRWjEXzZpNhAalxP1LnNlf?=
 =?us-ascii?Q?jU6Bi/9jfmpe71AR3l+ByFnFkp8EEpDxV6x1xaXGbil07Q9f35T1VcyqtGJi?=
 =?us-ascii?Q?Rp4tEAL8Jp3NaKo80kJ0fOfiXP7MxImkXq4IZ+VIC4vpejY+C2BdE4ZVyGAI?=
 =?us-ascii?Q?zT0uFD2K/qeAPp3jf/DAKYQIyrgIXJBIfy4juAiaw7PlUln2f9cTRcjSY/0L?=
 =?us-ascii?Q?MxRJlnCNMqVmU6ENY88WPN4GmD38S+I0wEk72Qo+d3ZGSAoEXaM2P2XJhQTr?=
 =?us-ascii?Q?SYUHQ11JKL0XGpS2RKOdPA7C7VwoxEB1Tby/fRETiP528THA27DeKf2s4H4O?=
 =?us-ascii?Q?dutKRS0ULpAy54VQ6hEBQw8D++miKWU/nd0F7DoUre8PtTLfgY58EaBe1RD5?=
 =?us-ascii?Q?4ugIMui1iP/6wFoWofVpSC8KOy2WKkeV5WlfELaFiq07nNJ2Nt+0H/oyxWgW?=
 =?us-ascii?Q?9d1gH/4I85iSuAVVKDKcXMLT5KZUl8C6qhzcxq1yhUU1g8VCww3dUXj3fZfb?=
 =?us-ascii?Q?BhJdi5XF6h0rLEP9cpKirmNPkEE2mZQyXtp9SGgHSUx2LjdmaFXG6eADewfx?=
 =?us-ascii?Q?jZ8LM9mxDz85b6kRYRBAWoIOS4I/7GzlyW7jK+EOVamwjdctkHuD2wxkORKr?=
 =?us-ascii?Q?AS9Dm+q76h6hZn3gMGgWFzeuYIUmcKB2ne5cpkmdzCY4rw+eZmfymKEQHUaO?=
 =?us-ascii?Q?9+LyJtcXnxLaTBvze4a2yq6PcrYmpv/shxoQVAPNnfA2/uM0tndi9/q8De2T?=
 =?us-ascii?Q?ZtjLQyhJYjrHUYwcHMxGb59onkEY+m7vbJjjUfsARj4ktiTVBt2u/UILEnv4?=
 =?us-ascii?Q?Pn1Y7Ljv9pmqLKfvZRqkFkz1LMutOvakecqXXxSu/2DB8L1rlXKAaw3SrRSO?=
 =?us-ascii?Q?XPW1MJdB/Dm5L0FarLki+rnb5dEg1aNqsiSgHBndg9WhceX0Hn0WB6FAt7r9?=
 =?us-ascii?Q?XhMCE+CHQb2peal5aZQxcnVXomdSWlnbd7OxwLBNm3Pb9RhHHtlVX1TDhhzv?=
 =?us-ascii?Q?sh8GldaIpbk149ZMF9HdyqJ8UFRRLO/MR1QgzDmWBDN+hw6P3mlAkKwx5ww7?=
 =?us-ascii?Q?ND4h52FlyizJzYVh8PRp+o0YU0QSfeM1WEBL6KsW8mVFVyB/WJSlV9mEtpLD?=
 =?us-ascii?Q?02V/CpbI4Z+Lql8RitIg1VhkZfCdEtft7+sp3GAUhVV5KHDix5VK9Do9eCdD?=
 =?us-ascii?Q?NU+t33htQgYtsNkRFHUMFIePrD+EcMBnGMYlp/sIwkilZbzPXb4WrsTRzggN?=
 =?us-ascii?Q?iWBKWKMunpU2YMgIgUGe4AJKc/2i6Hb8lLzDgPLDv4SxGhkGK2u/2I3fVZt/?=
 =?us-ascii?Q?k3jETTWlO4sixgHa5ulchm5vGO4wXCVSoAq3h6zqmn5uyaUZEuKZINJWLMcf?=
 =?us-ascii?Q?PQMpyriOsSS39jK46qdR2sdrUjeoMN3hGt4Dv/HgGHu5eqVTS4U6xAfZxyb+?=
 =?us-ascii?Q?A4C4syO9lmMjN6ypCN/5YWEhIDM6G66pr09lvuLm?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525707C7AEA3F8E792638E57FCCC2BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4b3971-a57c-4121-ea22-08dd57bd3b02
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 06:00:40.6413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2emQxE4fbZHnNr6obDZImR7FM77BSGs8P/thA1MQxj3Pex5u0TxIkWjF84STziQA417XXUgVZ47pp1DcRX3cSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
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

--_000_BN9PR12MB525707C7AEA3F8E792638E57FCCC2BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


+ @Liu, Xiang(Dean)<mailto:Xiang.Liu@amd.com>/@Zhou1, Tao<mailto:Tao.Zhou1@=
amd.com> for the code review

+       if (amdgpu_sriov_vf(adev))
+               debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
+                                        &amdgpu_debugfs_virt_ring_fops,
+                                        ring->ring_size + 12);
+       else
+               debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
+                                        &amdgpu_debugfs_ring_fops,
+                                        ring->ring_size + 12);

Hi Tony,

Is there any reason the VF requires a separate file system node? Is it beca=
use the VF has its own CPER ring? If so, can you please check if the VF can=
 reuse the CPER created for bare-metal?

Regards,
Hawking

-----Original Message-----
From: Yi, Tony <Tony.Yi@amd.com>
Sent: Thursday, February 27, 2025 23:12
To: Yi, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com=
>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; L=
uo, Zhigang <Zhigang.Luo@amd.com>
Cc: Yi, Tony <Tony.Yi@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization

Add support for CPERs on VFs.

VFs do not receive PMFW messages directly; as such, they need to query them=
 from the host. To avoid hitting host event guard, CPER queries need to be =
rate limited. CPER queries share the same RAS telemetry buffer as error cou=
nt query, so a mutex protecting the shared buffer was added as well.

For readability, the amdgpu_detect_virtualization was refactored into multi=
ple individual functions.

Signed-off-by: Tony Yi <Tony.Yi@amd.com<mailto:Tony.Yi@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  31 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 138 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  18 ++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  14 +++
 5 files changed, 195 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5e1d8f0039d0..198d29faa754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3099,7 +3099,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device=
 *adev)

        amdgpu_fru_get_product_info(adev);

-       r =3D amdgpu_cper_init(adev);
+       if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_ras_cper_en(adev))
+               r =3D amdgpu_cper_init(adev);

 init_failed:

@@ -4335,10 +4336,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         * for throttling interrupt) =3D 60 seconds.
         */
        ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, 1=
);
-       ratelimit_state_init(&adev->virt.ras_telemetry_rs, 5 * HZ, 1);

        ratelimit_set_flags(&adev->throttling_logging_rs, RATELIMIT_MSG_ON_=
RELEASE);
-       ratelimit_set_flags(&adev->virt.ras_telemetry_rs, RATELIMIT_MSG_ON_=
RELEASE);

        /* Registers mapping */
        /* TODO: block userspace mapping of io register */ @@ -4370,7 +4369=
,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
                return -ENOMEM;

        /* detect hw virtualization here */
-       amdgpu_detect_virtualization(adev);
+       amdgpu_virt_init(adev);

        amdgpu_device_get_pcie_info(adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index 81a7d4faac9c..d55c8b7fdb59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -578,12 +578,32 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *=
f, char __user *buf,
        return result;
 }

+static ssize_t amdgpu_debugfs_virt_ring_read(struct file *f, char __user *=
buf,
+       size_t size, loff_t *pos)
+{
+       struct amdgpu_ring *ring =3D file_inode(f)->i_private;
+
+       if (*pos & 3 || size & 3)
+               return -EINVAL;
+
+       if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_CPER)
+               amdgpu_virt_req_ras_cper_dump(ring->adev, false);
+
+       return amdgpu_debugfs_ring_read(f, buf, size, pos); }
+
 static const struct file_operations amdgpu_debugfs_ring_fops =3D {
        .owner =3D THIS_MODULE,
        .read =3D amdgpu_debugfs_ring_read,
        .llseek =3D default_llseek
 };

+static const struct file_operations amdgpu_debugfs_virt_ring_fops =3D {
+       .owner =3D THIS_MODULE,
+       .read =3D amdgpu_debugfs_virt_ring_read,
+       .llseek =3D default_llseek
+};
+
 static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
                                       size_t size, loff_t *pos)
 {
@@ -671,9 +691,14 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *ad=
ev,
        char name[32];

        sprintf(name, "amdgpu_ring_%s", ring->name);
-       debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
-                                &amdgpu_debugfs_ring_fops,
-                                ring->ring_size + 12);
+       if (amdgpu_sriov_vf(adev))
+               debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
+                                        &amdgpu_debugfs_virt_ring_fops,
+                                        ring->ring_size + 12);
+       else
+               debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
+                                        &amdgpu_debugfs_ring_fops,
+                                        ring->ring_size + 12);

        if (ring->mqd_obj) {
                sprintf(name, "amdgpu_mqd_%s", ring->name); diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
virt.c
index e6f0152e5b08..3832513ec7bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -739,7 +739,7 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *ad=
ev)
        }
 }

-void amdgpu_detect_virtualization(struct amdgpu_device *adev)
+static u32 amdgpu_virt_init_detect_asic(struct amdgpu_device *adev)
 {
        uint32_t reg;

@@ -775,8 +775,17 @@ void amdgpu_detect_virtualization(struct amdgpu_device=
 *adev)
                        adev->virt.caps |=3D AMDGPU_PASSTHROUGH_MODE;
        }

+       return reg;
+}
+
+static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32
+reg) {
+       bool is_sriov =3D false;
+
        /* we have the ability to check now */
        if (amdgpu_sriov_vf(adev)) {
+               is_sriov =3D true;
+
                switch (adev->asic_type) {
                case CHIP_TONGA:
                case CHIP_FIJI:
@@ -805,10 +814,39 @@ void amdgpu_detect_virtualization(struct amdgpu_devic=
e *adev)
                        amdgpu_virt_request_init_data(adev);
                        break;
                default: /* other chip doesn't support SRIOV */
+                       is_sriov =3D false;
                        DRM_ERROR("Unknown asic type: %d!\n", adev->asic_ty=
pe);
                        break;
                }
        }
+
+       return is_sriov;
+}
+
+static void amdgpu_virt_init_ras(struct amdgpu_device *adev) {
+       ratelimit_state_init(&adev->virt.ras.ras_error_cnt_rs, 5 * HZ, 1);
+       ratelimit_state_init(&adev->virt.ras.ras_cper_dump_rs, 5 * HZ, 1);
+
+       ratelimit_set_flags(&adev->virt.ras.ras_error_cnt_rs,
+                           RATELIMIT_MSG_ON_RELEASE);
+       ratelimit_set_flags(&adev->virt.ras.ras_cper_dump_rs,
+                           RATELIMIT_MSG_ON_RELEASE);
+
+       mutex_init(&adev->virt.ras.ras_telemetry_mutex);
+
+       adev->virt.ras.cper_rptr =3D 0;
+}
+
+void amdgpu_virt_init(struct amdgpu_device *adev) {
+       bool is_sriov =3D false;
+       uint32_t reg =3D amdgpu_virt_init_detect_asic(adev);
+
+       is_sriov =3D amdgpu_virt_init_req_data(adev, reg);
+
+       if (is_sriov)
+               amdgpu_virt_init_ras(adev);
 }

 static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)=
 @@ -1288,10 +1326,12 @@ static int amdgpu_virt_req_ras_err_count_internal(=
struct amdgpu_device *adev, bo
         * will ignore incoming guest messages. Ratelimit the guest message=
s to
         * prevent guest self DOS.
         */
-       if (__ratelimit(&adev->virt.ras_telemetry_rs) || force_update) {
+       if (__ratelimit(&virt->ras.ras_error_cnt_rs) || force_update) {
+               mutex_lock(&virt->ras.ras_telemetry_mutex);
                if (!virt->ops->req_ras_err_count(adev))
                        amdgpu_virt_cache_host_error_counts(adev,
-                               adev->virt.fw_reserve.ras_telemetry);
+                               virt->fw_reserve.ras_telemetry);
+               mutex_unlock(&virt->ras.ras_telemetry_mutex);
        }

        return 0;
@@ -1322,6 +1362,98 @@ int amdgpu_virt_req_ras_err_count(struct amdgpu_devi=
ce *adev, enum amdgpu_ras_bl
        return 0;
 }

+static int
+amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
+                               struct amdsriov_ras_telemetry *host_telemet=
ry,
+                               u32 *more)
+{
+       struct amd_sriov_ras_cper_dump *cper_dump =3D NULL;
+       struct cper_hdr *entry =3D NULL;
+       struct amdgpu_ring *ring =3D &adev->cper.ring_buf;
+       uint32_t checksum, used_size, i, j;
+       int ret =3D 0;
+
+       checksum =3D host_telemetry->header.checksum;
+       used_size =3D host_telemetry->header.used_size;
+
+       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+               return 0;
+
+       cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size, G=
FP_KERNEL);
+       if (!cper_dump)
+               return -ENOMEM;
+
+       if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
))
+               goto out;
+
+       *more =3D cper_dump->more;
+
+       if (cper_dump->wptr < adev->virt.ras.cper_rptr) {
+               dev_warn(
+                       adev->dev,
+                       "guest specified rptr that was too high! guest rptr=
: 0x%llx, host rptr: 0x%llx\n",
+                       adev->virt.ras.cper_rptr, cper_dump->wptr);
+
+               adev->virt.ras.cper_rptr =3D cper_dump->wptr;
+               goto out;
+       }
+
+       entry =3D (struct cper_hdr *)&cper_dump->buf[0];
+
+       for (i =3D 0; i < cper_dump->count; i++) {
+               amdgpu_cper_ring_write(ring, entry, entry->record_length);
+               entry =3D (struct cper_hdr *)((char *)entry +
+                                           entry->record_length);
+       }
+
+       if (cper_dump->overflow_count)
+               dev_warn(adev->dev,
+                        "host reported CPER overflow of 0x%llx entries!\n"=
,
+                        cper_dump->overflow_count);
+
+       adev->virt.ras.cper_rptr =3D cper_dump->wptr;
+out:
+       kfree(cper_dump);
+
+       return ret;
+}
+
+static int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device
+*adev) {
+       struct amdgpu_virt *virt =3D &adev->virt;
+       int ret =3D 0;
+       uint32_t more =3D 0;
+
+       if (!amdgpu_sriov_ras_cper_en(adev))
+               return -EOPNOTSUPP;
+
+       do {
+               if (!virt->ops->req_ras_cper_dump(adev, virt->ras.cper_rptr=
))
+                       ret =3D amdgpu_virt_write_cpers_to_ring(
+                               adev, virt->fw_reserve.ras_telemetry, &more=
);
+               else
+                       ret =3D 0;
+       } while (more);
+
+       return ret;
+}
+
+int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool
+force_update) {
+       struct amdgpu_virt *virt =3D &adev->virt;
+       int ret =3D 0;
+
+       if ((__ratelimit(&virt->ras.ras_cper_dump_rs) || force_update) &&
+           down_read_trylock(&adev->reset_domain->sem)) {
+               mutex_lock(&virt->ras.ras_telemetry_mutex);
+               ret =3D amdgpu_virt_req_ras_cper_dump_internal(adev);
+               mutex_unlock(&virt->ras.ras_telemetry_mutex);
+               up_read(&adev->reset_domain->sem);
+       }
+
+       return ret;
+}
+
 int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)  {
        unsigned long ue_count, ce_count;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 0f3ccae5c1ab..9f65487e60f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -96,6 +96,7 @@ struct amdgpu_virt_ops {
                                        enum amdgpu_ras_block block);
        bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
        int (*req_ras_err_count)(struct amdgpu_device *adev);
+       int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
 };

 /*
@@ -140,6 +141,7 @@ enum AMDGIM_FEATURE_FLAG {
        AMDGIM_FEATURE_MES_INFO_ENABLE =3D (1 << 8),
        AMDGIM_FEATURE_RAS_CAPS =3D (1 << 9),
        AMDGIM_FEATURE_RAS_TELEMETRY =3D (1 << 10),
+       AMDGIM_FEATURE_RAS_CPER =3D (1 << 11),
 };

 enum AMDGIM_REG_ACCESS_FLAG {
@@ -242,6 +244,13 @@ struct amdgpu_virt_ras_err_handler_data {
        int last_reserved;
 };

+struct amdgpu_virt_ras {
+       struct ratelimit_state ras_error_cnt_rs;
+       struct ratelimit_state ras_cper_dump_rs;
+       struct mutex ras_telemetry_mutex;
+       uint64_t cper_rptr;
+};
+
 /* GPU virtualization */
 struct amdgpu_virt {
        uint32_t                        caps;
@@ -284,8 +293,7 @@ struct amdgpu_virt {

        union amd_sriov_ras_caps ras_en_caps;
        union amd_sriov_ras_caps ras_telemetry_en_caps;
-
-       struct ratelimit_state ras_telemetry_rs;
+       struct amdgpu_virt_ras ras;
        struct amd_sriov_ras_telemetry_error_count count_cache;  };

@@ -340,6 +348,9 @@ struct amdgpu_video_codec_info;  #define amdgpu_sriov_r=
as_telemetry_block_en(adev, sriov_blk) \
 (amdgpu_sriov_ras_telemetry_en((adev)) && (adev)->virt.ras_telemetry_en_ca=
ps.all & BIT(sriov_blk))

+#define amdgpu_sriov_ras_cper_en(adev) \ ((adev)->virt.gim_feature &
+AMDGIM_FEATURE_RAS_CPER)
+
 static inline bool is_virtual_machine(void)  {  #if defined(CONFIG_X86) @@=
 -378,7 +389,7 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdg=
pu_device *adev);  void amdgpu_virt_init_data_exchange(struct amdgpu_device=
 *adev);  void amdgpu_virt_exchange_data(struct amdgpu_device *adev);  void=
 amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev); -void amdgpu_d=
etect_virtualization(struct amdgpu_device *adev);
+void amdgpu_virt_init(struct amdgpu_device *adev);

 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int amdg=
pu_virt_enable_access_debugfs(struct amdgpu_device *adev); @@ -406,6 +417,7=
 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32=
 v, u32 f  bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev);=
  int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu=
_ras_block block,
                                  struct ras_err_data *err_data);
+int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool
+force_update);
 int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);  boo=
l amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
                                        enum amdgpu_ras_block block);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 4dcb72d1bdda..5aadf24cb202 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -184,6 +184,9 @@ static int xgpu_nv_send_access_requests_with_param(stru=
ct amdgpu_device *adev,
        case IDH_REQ_RAS_ERROR_COUNT:
                event =3D IDH_RAS_ERROR_COUNT_READY;
                break;
+       case IDH_REQ_RAS_CPER_DUMP:
+               event =3D IDH_RAS_CPER_DUMP_READY;
+               break;
        default:
                break;
        }
@@ -467,6 +470,16 @@ static int xgpu_nv_req_ras_err_count(struct amdgpu_dev=
ice *adev)
        return xgpu_nv_send_access_requests(adev, IDH_REQ_RAS_ERROR_COUNT);=
  }

+static int xgpu_nv_req_ras_cper_dump(struct amdgpu_device *adev, u64
+vf_rptr) {
+       uint32_t vf_rptr_hi, vf_rptr_lo;
+
+       vf_rptr_hi =3D (uint32_t)(vf_rptr >> 32);
+       vf_rptr_lo =3D (uint32_t)(vf_rptr & 0xFFFFFFFF);
+       return xgpu_nv_send_access_requests_with_param(
+               adev, IDH_REQ_RAS_CPER_DUMP, vf_rptr_hi, vf_rptr_lo, 0); }
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
        .req_full_gpu   =3D xgpu_nv_request_full_gpu_access,
        .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
@@ -478,4 +491,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
        .ras_poison_handler =3D xgpu_nv_ras_poison_handler,
        .rcvd_ras_intr =3D xgpu_nv_rcvd_ras_intr,
        .req_ras_err_count =3D xgpu_nv_req_ras_err_count,
+       .req_ras_cper_dump =3D xgpu_nv_req_ras_cper_dump,
 };
--
2.34.1


--_000_BN9PR12MB525707C7AEA3F8E792638E57FCCC2BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ <a=
 href=3D"mailto:Xiang.Liu@amd.com"><font color=3D"#2B579A"><span style=3D"b=
ackground-color:#E1DFDD;">@Liu, Xiang(Dean)</span></font></a>/<a href=3D"ma=
ilto:Tao.Zhou1@amd.com"><font color=3D"#2B579A"><span style=3D"background-c=
olor:#E1DFDD;">@Zhou1,
Tao</span></font></a> for the code review</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; debugfs_create_file_size(name, S_IFREG | 0444, root, ring,</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;amdgpu_debugfs_virt_ring_fops,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ring-&gt;ring_size + 12);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; debugfs_create_file_size(name, S_IFREG | 0444, root, ring,</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;amdgpu_debugfs_ring_fops,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ring-&gt;ring_size + 12);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hi T=
ony,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Is t=
here any reason the VF requires a separate file system node? Is it because =
the VF has its own CPER ring? If so, can you please check if the VF can reu=
se the CPER created for bare-metal?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Yi, Tony &lt;Tony.Yi@amd.com&gt; <br>

Sent: Thursday, February 27, 2025 23:12<br>

To: Yi, Tony &lt;Tony.Yi@amd.com&gt;; Skvortsov, Victor &lt;Victor.Skvortso=
v@amd.com&gt;; amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zh=
ang@amd.com&gt;; Luo, Zhigang &lt;Zhigang.Luo@amd.com&gt;<br>

Cc: Yi, Tony &lt;Tony.Yi@amd.com&gt;<br>

Subject: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Add =
support for CPERs on VFs.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">VFs =
do not receive PMFW messages directly; as such, they need to query them fro=
m the host. To avoid hitting host event guard, CPER queries need to be rate=
 limited. CPER queries share the same
RAS telemetry buffer as error count query, so a mutex protecting the shared=
 buffer was added as well.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">For =
readability, the amdgpu_detect_virtualization was refactored into multiple =
individual functions.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Tony Yi &lt;<a href=3D"mailto:Tony.Yi@amd.com">Tony.Yi@amd.com</=
a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp;&nbsp; 7 +-</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ring.c&nbsp;&nbsp; |&nbsp; 31 ++++-</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp; | 138 +++++++++++++++++++=
+-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbsp; |&nbsp; 18 ++-</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14=
 +++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 5 f=
iles changed, 195 insertions(+), 13 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 5e1d8f0039d0..198d29faa754 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3099,7 +3099,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *ad=
ev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fru_get_product_info(ad=
ev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_cper_init(adev);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) || amdgpu_srio=
v_ras_cper_en(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; r =3D amdgpu_cper_init(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> ini=
t_failed:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
4335,10 +4336,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for throttling interru=
pt) =3D 60 seconds.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_state_init(&amp;adev=
-&gt;throttling_logging_rs, (60 - 1) * HZ, 1);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_state_init(&amp;adev-&gt;virt.r=
as_telemetry_rs, 5 * HZ, 1);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;adev-=
&gt;throttling_logging_rs, RATELIMIT_MSG_ON_RELEASE);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;adev-&gt;virt.ra=
s_telemetry_rs, RATELIMIT_MSG_ON_RELEASE);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Registers mapping */</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: block userspace mappi=
ng of io register */ @@ -4370,7 +4369,7 @@ int amdgpu_device_init(struct am=
dgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -ENOMEM;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* detect hw virtualization he=
re */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_detect_virtualization(adev);</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_init(adev);</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_get_pcie_info(ad=
ev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amd=
gpu/amdgpu_ring.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 81a7d4faac9c..d55c8b7fdb59 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
578,12 +578,32 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, c=
har __user *buf,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic ssize_t amdgpu_debugfs_virt_ring_read(struct file *f, char __user *buf,=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size, loff_t *pos)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D file_inode(f=
)-&gt;i_private;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*pos &amp; 3 || size &amp; 3)</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;type =3D=3D AMDGPU=
_RING_TYPE_CPER)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_virt_req_ras_cper_dump(ring-&gt;adev, false);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_ring_read(f, buf, s=
ize, pos); }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic const struct file_operations amdgpu_debugfs_ring_fops =3D {</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_ring_=
read,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> };<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic const struct file_operations amdgpu_debugfs_virt_ring_fops =3D {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_virt_ring_read,<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; size_t size, loff_t *pos)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
671,9 +691,14 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char name[32];</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(name, &quot;amdgpu_rin=
g_%s&quot;, ring-&gt;name);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file_size(name, S_IFREG | =
0444, root, ring,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_ring_fops,</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;ring_size + 12);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; debugfs_create_file_size(name, S_IFREG | 0444, root, ring,</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;amdgpu_debugfs_virt_ring_fops,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ring-&gt;ring_size + 12);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; debugfs_create_file_size(name, S_IFREG | 0444, root, ring,</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;amdgpu_debugfs_ring_fops,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ring-&gt;ring_size + 12);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;mqd_obj) {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sprintf(name, &quot;amdgpu_mqd_%s&quot;, ring-&gt;name); =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x e6f0152e5b08..3832513ec7bf 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
739,7 +739,7 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-voi=
d amdgpu_detect_virtualization(struct amdgpu_device *adev)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic u32 amdgpu_virt_init_detect_asic(struct amdgpu_device *adev)</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
775,8 +775,17 @@ void amdgpu_detect_virtualization(struct amdgpu_device *ad=
ev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
virt.caps |=3D AMDGPU_PASSTHROUGH_MODE;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return reg;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 </span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+reg=
) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_sriov =3D false;</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* we have the ability to chec=
k now */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; is_sriov =3D true;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; case CHIP_TONGA:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; case CHIP_FIJI:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
805,10 +814,39 @@ void amdgpu_detect_virtualization(struct amdgpu_device *a=
dev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vi=
rt_request_init_data(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; default: /* other chip doesn't support SRIOV */</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_sriov =3D false;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR=
(&quot;Unknown asic type: %d!\n&quot;, adev-&gt;asic_type);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return is_sriov;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void amdgpu_virt_init_ras(struct amdgpu_device *adev) {</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_state_init(&amp;adev-&gt;virt.r=
as.ras_error_cnt_rs, 5 * HZ, 1);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_state_init(&amp;adev-&gt;virt.r=
as.ras_cper_dump_rs, 5 * HZ, 1);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;adev-&gt;virt.ra=
s.ras_error_cnt_rs,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; RATELIMIT_MSG_ON_RELEASE);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;adev-&gt;virt.ra=
s.ras_cper_dump_rs,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; RATELIMIT_MSG_ON_RELEASE);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;virt.ras.ras_tel=
emetry_mutex);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ras.cper_rptr =3D 0;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+voi=
d amdgpu_virt_init(struct amdgpu_device *adev) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_sriov =3D false;</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg =3D amdgpu_virt_init_detect_=
asic(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_sriov =3D amdgpu_virt_init_req_data(ad=
ev, reg);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_sriov)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_virt_init_ras(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev) @@ =
-1288,10 +1326,12 @@ static int amdgpu_virt_req_ras_err_count_internal(stru=
ct amdgpu_device *adev, bo</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * will ignore incoming g=
uest messages. Ratelimit the guest messages to</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * prevent guest self DOS=
.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (__ratelimit(&amp;adev-&gt;virt.ras_te=
lemetry_rs) || force_update) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (__ratelimit(&amp;virt-&gt;ras.ras_err=
or_cnt_rs) || force_update) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; mutex_lock(&amp;virt-&gt;ras.ras_telemetry_mutex);</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!virt-&gt;ops-&gt;req_ras_err_count(adev))</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vi=
rt_cache_host_error_counts(adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.fw_reserve.ras_telemetry);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; virt-&gt;fw_reserve.ras_telemetry);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; mutex_unlock(&amp;virt-&gt;ras.ras_telemetry_mutex);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1322,6 +1362,98 @@ int amdgpu_virt_req_ras_err_count(struct amdgpu_device *=
adev, enum amdgpu_ras_bl</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+amd=
gpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdsriov_ras_telemetry *host_telemetry,<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *more)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_ras_cper_dump *cper_dump=
 =3D NULL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cper_hdr *entry =3D NULL;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&g=
t;cper.ring_buf;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checksum, used_size, i, j;</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checksum =3D host_telemetry-&gt;header.ch=
ecksum;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used_size =3D host_telemetry-&gt;header.u=
sed_size;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used_size &gt; (AMD_SRIOV_RAS_TELEMET=
RY_SIZE_KB &lt;&lt; 10))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cper_dump =3D kmemdup(&amp;host_telemetry=
-&gt;body.cper_dump, used_size, GFP_KERNEL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cper_dump)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -ENOMEM;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (checksum !=3D amd_sriov_msg_checksum(=
cper_dump, used_size, 0, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto out;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *more =3D cper_dump-&gt;more;</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cper_dump-&gt;wptr &lt; adev-&gt;virt=
.ras.cper_rptr) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_warn(</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;dev,</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;guest specifie=
d rptr that was too high! guest rptr: 0x%llx, host rptr: 0x%llx\n&quot;,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ras.cp=
er_rptr, cper_dump-&gt;wptr);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; adev-&gt;virt.ras.cper_rptr =3D cper_dump-&gt;wptr;</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto out;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry =3D (struct cper_hdr *)&amp;cper_du=
mp-&gt;buf[0];</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; cper_dump-&gt;count;=
 i++) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_cper_ring_write(ring, entry, entry-&gt;record_length);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; entry =3D (struct cper_hdr *)((char *)entry +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;record_length);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cper_dump-&gt;overflow_count)</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_warn(adev-&gt;dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;host rep=
orted CPER overflow of 0x%llx entries!\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cper_dump-&gt;=
overflow_count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ras.cper_rptr =3D cper_dump=
-&gt;wptr;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+out=
:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(cper_dump);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device </span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+*ad=
ev) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_virt *virt =3D &amp;adev-&g=
t;virt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t more =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_ras_cper_en(adev))</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EOPNOTSUPP;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (!virt-&gt;ops-&gt;req_ras_cper_dump(adev, virt-&gt;ras.cper_rptr=
))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_virt_=
write_cpers_to_ring(</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev, virt-&gt;fw_reserve.ras_telemetry, &amp;m=
ore);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D 0;</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (more);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool </span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+for=
ce_update) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_virt *virt =3D &amp;adev-&g=
t;virt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((__ratelimit(&amp;virt-&gt;ras.ras_cp=
er_dump_rs) || force_update) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read_trylock=
(&amp;adev-&gt;reset_domain-&gt;sem)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; mutex_lock(&amp;virt-&gt;ras.ras_telemetry_mutex);</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D amdgpu_virt_req_ras_cper_dump_internal(adev);</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; mutex_unlock(&amp;virt-&gt;ras.ras_telemetry_mutex);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; up_read(&amp;adev-&gt;reset_domain-&gt;sem);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)&nbsp; {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long ue_count, ce_cou=
nt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amd=
gpu/amdgpu_virt.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 0f3ccae5c1ab..9f65487e60f5 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
96,6 +96,7 @@ struct amdgpu_virt_ops {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; enum amdgpu_ras_block block);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*rcvd_ras_intr)(struct a=
mdgpu_device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*req_ras_err_count)(struc=
t amdgpu_device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*req_ras_cper_dump)(struct amdgpu_de=
vice *adev, u64 vf_rptr);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> };<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> /*<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
140,6 +141,7 @@ enum AMDGIM_FEATURE_FLAG {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_MES_INFO_ENABLE=
 =3D (1 &lt;&lt; 8),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_RAS_CAPS =3D (1=
 &lt;&lt; 9),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_RAS_TELEMETRY =
=3D (1 &lt;&lt; 10),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_RAS_CPER =3D (1 &lt;&lt; 1=
1),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> };<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> enu=
m AMDGIM_REG_ACCESS_FLAG {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
242,6 +244,13 @@ struct amdgpu_virt_ras_err_handler_data {</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int last_reserved;</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> };<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct amdgpu_virt_ras {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ratelimit_state ras_error_cnt_rs;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ratelimit_state ras_cper_dump_rs;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex ras_telemetry_mutex;</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t cper_rptr;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> /* =
GPU virtualization */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> str=
uct amdgpu_virt {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; caps;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
284,8 +293,7 @@ struct amdgpu_virt {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union amd_sriov_ras_caps ras_e=
n_caps;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union amd_sriov_ras_caps ras_t=
elemetry_en_caps;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ratelimit_state ras_telemetry_rs;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_virt_ras ras;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_ras_telemetry=
_error_count count_cache;&nbsp; };</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
340,6 +348,9 @@ struct amdgpu_video_codec_info;&nbsp; #define amdgpu_sriov_=
ras_telemetry_block_en(adev, sriov_blk) \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> (am=
dgpu_sriov_ras_telemetry_en((adev)) &amp;&amp; (adev)-&gt;virt.ras_telemetr=
y_en_caps.all &amp; BIT(sriov_blk))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine amdgpu_sriov_ras_cper_en(adev) \ ((adev)-&gt;virt.gim_feature &amp; </=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+AMD=
GIM_FEATURE_RAS_CPER)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic inline bool is_virtual_machine(void)&nbsp; {&nbsp; #if defined(CONFIG_X=
86) @@ -378,7 +389,7 @@ void amdgpu_virt_release_ras_err_handler_data(struc=
t amdgpu_device *adev);&nbsp; void amdgpu_virt_init_data_exchange(struct
amdgpu_device *adev);&nbsp; void amdgpu_virt_exchange_data(struct amdgpu_de=
vice *adev);&nbsp; void amdgpu_virt_fini_data_exchange(struct amdgpu_device=
 *adev); -void amdgpu_detect_virtualization(struct amdgpu_device *adev);</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+voi=
d amdgpu_virt_init(struct amdgpu_device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> boo=
l amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);&nbsp; int amd=
gpu_virt_enable_access_debugfs(struct amdgpu_device *adev); @@ -406,6 +417,=
7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device
*adev, u32 offset, u32 v, u32 f&nbsp; bool amdgpu_virt_get_ras_capability(s=
truct amdgpu_device *adev);&nbsp; int amdgpu_virt_req_ras_err_count(struct =
amdgpu_device *adev, enum amdgpu_ras_block block,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data *err=
_data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool </span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+for=
ce_update);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);&nbsp; bo=
ol amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; enum amdgpu_ras_block block);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu=
/mxgpu_nv.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 4dcb72d1bdda..5aadf24cb202 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
184,6 +184,9 @@ static int xgpu_nv_send_access_requests_with_param(struct a=
mdgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IDH_REQ_RAS_ERROR_COUNT:<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; event =3D IDH_RAS_ERROR_COUNT_READY;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IDH_REQ_RAS_CPER_DUMP:</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; event =3D IDH_RAS_CPER_DUMP_READY;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
467,6 +470,16 @@ static int xgpu_nv_req_ras_err_count(struct amdgpu_device =
*adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_nv_send_access_req=
uests(adev, IDH_REQ_RAS_ERROR_COUNT);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int xgpu_nv_req_ras_cper_dump(struct amdgpu_device *adev, u64 </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+vf_=
rptr) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vf_rptr_hi, vf_rptr_lo;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vf_rptr_hi =3D (uint32_t)(vf_rptr &gt;&gt=
; 32);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vf_rptr_lo =3D (uint32_t)(vf_rptr &amp; 0=
xFFFFFFFF);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_nv_send_access_requests_with_=
param(</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; adev, IDH_REQ_RAS_CPER_DUMP, vf_rptr_hi, vf_rptr_lo, 0); }</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> con=
st struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .req_full_gpu&nbsp;&nbsp; =3D =
xgpu_nv_request_full_gpu_access,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .rel_full_gpu&nbsp;&nbsp; =3D =
xgpu_nv_release_full_gpu_access,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
478,4 +491,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ras_poison_handler =3D xgpu_n=
v_ras_poison_handler,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .rcvd_ras_intr =3D xgpu_nv_rcv=
d_ras_intr,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .req_ras_err_count =3D xgpu_nv=
_req_ras_err_count,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .req_ras_cper_dump =3D xgpu_nv_req_ras_cp=
er_dump,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> };<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB525707C7AEA3F8E792638E57FCCC2BN9PR12MB5257namp_--

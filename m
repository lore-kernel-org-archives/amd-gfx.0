Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91324C7115B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 02:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350B510E4A2;
	Tue, 24 Jun 2025 02:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qd3vK7sB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106AE10E4A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 02:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ66GtuKnJVCUDe/noJ0H16FX9DSYTZsPMT0xFhIs3Ze932TOYTqvjbC/tRPZ1xgOed21B2P1OpHo0No6QJQ76l6UjnfQ+iEpi12u2WWi/O6hiBMPQSpkQwnSlsLKzVC+OvJ/+nWbEfkImXp0Tfh17pjrLqa6i5yPMZapJVilQ591VJ8L2O1VajB9dL7PLJCyr98SYVqPXmn5yhe3ttNCl37qnDrNRuJR2PZLuFYfXc1Viy2e0qQWrARkHETHSRIBnPo5pqBvMrWJs1Dd/xCPXo0QLvneEYTcnzEGWijCi2KH6ck3dLhDp5s0AQShIn80qkayl33M1g+vzsL+38mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx6QqiEX2LSs77GQE7dNII1/IXiRTSZiZy49hBvY7Ro=;
 b=NXt3av8uJ/mmMg9WqXdivsab+lTJlnLyGX5knA4XoUukimqFGJzpsbAxQmeLE26UAdhlGfAHnqmQ715GzpdL+E3T54y6B/GngmwVuMPZ/NrCiEQNiMvkbtQtIpWYguOxC1cQNjlT3vxd74uddTmyfju1l2Pj/NLzeRK+tMNG1ntWj9ua65pS8IR1Ht7UFCs3QhedEoiiwVjZ0Ij9yGRopj1uYH2bBmIngmwoHQd8v0nEQcrW2EohrXbqHV9twH2+NR/G6OjWjG2EMWNo54dkTnMF1sMAzk/3hLsifxk0HjKFsTGZQRDgPlZYyfBnYpY49Qk+gY/DNWYqHyOqfyJp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx6QqiEX2LSs77GQE7dNII1/IXiRTSZiZy49hBvY7Ro=;
 b=qd3vK7sBUOP77SYrlRUkOsBDnOKX0s0AkX5wLjPYbHOVeHWhv3NBmKqZkm68JlROJnjiKMa9NBMM53A2VD3IPbFQUpQgwDRlBk0mffe2K5vJo+l+TSMcCI10XSwCgActQ+A+rtjGIDjpAGEOajifOpqmw9tyAImG4D3pFwWPKWI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 02:41:02 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8857.019; Tue, 24 Jun 2025
 02:41:02 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 02/31] drm/amdgpu/sdma5.x: suspend KFD queues in ring reset
Thread-Topic: [PATCH 02/31] drm/amdgpu/sdma5.x: suspend KFD queues in ring
 reset
Thread-Index: AQHb5Fn97VxbgWa4r0asow/zzNrdgLQRmhwg
Date: Tue, 24 Jun 2025 02:41:01 +0000
Message-ID: <DM4PR12MB5152001BA27F913EB80F970CE378A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
 <20250623161438.124020-3-alexander.deucher@amd.com>
In-Reply-To: <20250623161438.124020-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-24T02:40:54.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CY5PR12MB6550:EE_
x-ms-office365-filtering-correlation-id: 5e5d5fd4-a104-4aff-92ee-08ddb2c88f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lHvo45/j8KSAPxm17Jdf7S37edPSY8iZmHLMiYO4uwBZqREy8qep8KvXVuXA?=
 =?us-ascii?Q?h7O4c7px0eL/bSRqtqu5mFkgwZywK3H1hFisFDD3HaC2dg4wR+IU/J/bBh4P?=
 =?us-ascii?Q?nntgVqfmvH59R8l7FHdEga9q9qGlGdX5DE3mxVND+XLGbCYzLfY5kSZIhFjK?=
 =?us-ascii?Q?nolR14O2JfKFa5TJjrk1FWje3SdNIlLRFDIhkhQ9vn8uW+YM5jz5qOAEIyRr?=
 =?us-ascii?Q?iWwEAjVT8nxBVbPpdV0zWp5zQ77JEzTL3mKx0JZRoPkb/F3Spevm0gce3C/A?=
 =?us-ascii?Q?fmtbSpczvz0hqvTVS7g46aiWjepyB3fZtJIeq96zSphPWThwY67m80xD2MAk?=
 =?us-ascii?Q?zwhSnJFtNxxcOrxA/krq+V9Ty/r6rU23duJFfrm8NlTehfdQ/AZXmvaYPxvn?=
 =?us-ascii?Q?2BXVpa5YQwM96MZOfGdfI+Mg6/hMFmMaGKu6TfmYsLQ7s9VgmNEHfg42HLPs?=
 =?us-ascii?Q?VSZCHPEKvmpJOeC0UskV6/soAC5PkIYSzOFK40gfCYsnp4m3bq/kKzG/KVsq?=
 =?us-ascii?Q?Im7eFvamMT5lGd0vBrwndp44C0d4ysNjbrL23VbMViiqN2FRFhCT1vzqmvya?=
 =?us-ascii?Q?uH4vlBXuAcLbLsXubJKACzNEZLTHqMGT3/94PgXmMDPeZrjr/y1tZRc68WXG?=
 =?us-ascii?Q?oe9V3ZaaQPe/Xgz6tTI8UlRF0w609NOvgRdyQ5nboSjZsD7lk1DvgPzioVUa?=
 =?us-ascii?Q?xog4t8LW8QPEddqUJCLhfO+jefV3BkC1N8Nei5BFLQz5kET3qgeKPJFHZBUu?=
 =?us-ascii?Q?8+0Lfk3yploAIuo/UjJNmmqANTU0sIfCY0YKu/nyJ8Wnb7GRLHMaahrN6t+c?=
 =?us-ascii?Q?8g1KZlQzQhUqT8eNypDQytQ2ugO534I4pvkmCjmLo+/FCTUUL94dVEPYaRIC?=
 =?us-ascii?Q?dnvQlMbMk2flFIFIIL+4vi587mvB+Y+H2fuZh3uRkQfBkHmarelqBhIJHoXN?=
 =?us-ascii?Q?XV90SY5Mesfjl6De+A57PBOxM3iEsYFBpE5NShPpJ+lt8Y046EntO8/fQ8Vq?=
 =?us-ascii?Q?HzP5uXbFhO2TkaOy9QMOmb8svI9kP5r9DiVysWHs8DMeZpbpACANZ/4sZJj5?=
 =?us-ascii?Q?Do8YEpQxNQ1PkKoyzJOc7q6gbgRNNK5bo5C/UtFiCEF53nMc8PVeDOEbYmdG?=
 =?us-ascii?Q?681ShxyWWf9gGRd7anXlb6RfDu73WrEGglMoFflhqkKwJfvieGn6m2525P+Y?=
 =?us-ascii?Q?CHvRUZShRuVWZwiQHua5KkfZma5Lg65tDh1Euoh4Tc+b1iJI54veEn3Yt7Z1?=
 =?us-ascii?Q?3N3M4/MeACSFSaeCbrtyem7nNlJMwj0kENbbEhK/FZfF2NpeY8VqK2MAH8gT?=
 =?us-ascii?Q?x9LzfkutAQOekmo0hvH6b4nf3ad8UAMVx4jnYAr+8I5JsBzvK51DT8kIi3gk?=
 =?us-ascii?Q?i8XSjxMo4uUWa7RDc2AgelqYRjvY+Fkqbd8lWG35b47wB8m3Kzv9C8Y7tSQ5?=
 =?us-ascii?Q?YldZhnfc7t3CG8Yc67dyK3NjtcQPfUVIkECd4OlNz6UHFjW0xZzb1+6edyD6?=
 =?us-ascii?Q?j2X0WuIh1ckqzLc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TN8F4XH5moF419ujj+EiPqr47iyPf2zjy3/PTMY4MsOthrWykv4GuL0j/fQQ?=
 =?us-ascii?Q?l2AOi56Dry+LK5ti05QbApNGPw1bLJ9/r4xuRWv8sW9MVGrErCT9FVai8Hib?=
 =?us-ascii?Q?RdTbJCNSiPwED/miSjn6mEjgJ7FATsqJuq1hkvP5Q54ytAcPcK3jg7+FekhM?=
 =?us-ascii?Q?j7nXFpkBIrEhrCfeGAGVaEtiJClqdxuoxQg+zJiraNZB0Ay5lvQhV0D6kCmf?=
 =?us-ascii?Q?AFWOxfQNM62yp0xBsm25Ss1e5mtmr+7iWK0ANzqQPj8k4YmAyzL/oeboHyLh?=
 =?us-ascii?Q?FtTg6hQhNdTx/0h9CBqoy0tA2ErtzOK3XfKuX2xG1fW1ubfqXx7pplJwU088?=
 =?us-ascii?Q?got85Sw1So4X7W91thNK3sV6OqKtD0yNU1vIpfw2aFMpiAaPOcmNKVQ8jyhe?=
 =?us-ascii?Q?aGKn5Fk7Pm3XPEj89+6huIFiGMpXr7Jc+ym5JpN/EY1TRytPT7DdlBZm9qQH?=
 =?us-ascii?Q?3ITSmlYpCLGXhAINTOVJCBQUTKc3FncUTMHh0XBGo0gqS1EuNXQ3eAPrC61o?=
 =?us-ascii?Q?BTTPZ2UbhJu6Nobuogb6Gtp5G2pj7TyceJCYXTS7tXeYEIx9eGrSIwFidw8z?=
 =?us-ascii?Q?rtf41thM/ux3bNBcKIJ9GlzNhtQ2YbTF6YijdleeWQ+s6d6lrfnwRGwQL5Q3?=
 =?us-ascii?Q?wMtXXBbMwVAUL/EnQfUwJkno0zrbBp2lHOoB4BEzzkP1BTVs6frjk0P4Ngfs?=
 =?us-ascii?Q?Wnw/xlZ+ToVVlb4/siSY0j5JUKKlWy013CFV/ItGrS4zosV24+QHpXs1xJXC?=
 =?us-ascii?Q?1zeEIHDS1B7C0YALwh0QGPTZtbh5VnNsZ6aEFTYWBtZiumXdtKg/gvrI/nv4?=
 =?us-ascii?Q?iirci3z3BEWBp9ek23d+ZeOONflakvOG9Qrl9l9bT+41ReNh7cAf2FBDwlGT?=
 =?us-ascii?Q?BFuTRWkrrX1NzK3FM7wl+CGDaI9QCD/+vgU/3TuEcBwEwy8LXYN0Ein+Mo97?=
 =?us-ascii?Q?6Qh5oDGJ6QhCK+eT7xDuQFDo+MI1gJyOo5MNOt7Fa5+5D5RCU1VX7GzXpl81?=
 =?us-ascii?Q?bI1mSTlyFvUhhj2XJOq2nJCQqwzXUcf2L6YZOOAcnJeQo53R+mt2KRQ634+u?=
 =?us-ascii?Q?WytqsQZUoeKTQO2644MdQ5uXDloan+7DHc9iiaIOIINHmANdw8q4wc5kChl4?=
 =?us-ascii?Q?V1fBIkMp+JLxQfdOeBnW0kZTUSpPONG9svDKZZ2cNvSbIIvUK5rLR/Ok+pJK?=
 =?us-ascii?Q?TpWFWSGMg49etE0qaNJhZQ1pEoIHqVfSl6ChxGRlbrqUFlvDIgyn9WohG411?=
 =?us-ascii?Q?z0ULQhQbUwd8GPLeBmJUFkXaEc6wDdHamD5kJrtYzJDAyn02YtUYCCVUMvKy?=
 =?us-ascii?Q?0gFi59a5SR1JOvbPOeIMTZvYN9YOAAT8IUtG/ork7Wx0tOHZLCmrzlc40gCV?=
 =?us-ascii?Q?kbyTxId68ZH/UYqsG1xpcFZg6UFiYB2OTuszgsptFDoAdTSCN9ACDfk/OEQW?=
 =?us-ascii?Q?ihcbMhfmdoorGH5QrpC/SvZjlmDFb6uKyyQojZfPtQQr8xmjfgEiUmXiTN08?=
 =?us-ascii?Q?93JbpLHvVJL7DuV8xVWkmvDBsj6L8ISvCfYNcQPrWExh9eXvT3TL8vjCB3Sg?=
 =?us-ascii?Q?teEY0/5mrpRNCwf9EXs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5d5fd4-a104-4aff-92ee-08ddb2c88f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 02:41:02.0236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7iNxtXwHI5PZVsXnV/bYq37DVDHLZ0dXJKEC8FYTYibZXxjKAp0KVXLCpB+rCmtaj+lDzONDloYAF/QDQdhBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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

this patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, June 24, 2025 12:14 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 02/31] drm/amdgpu/sdma5.x: suspend KFD queues in ring reset

SDMA 5.x only supports engine soft reset which resets all queues on the eng=
ine.  As such, we need to suspend KFD queues around resets like we do for S=
DMA 4.x.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 7 ++++++-  drivers/gpu/drm/amd/am=
dgpu/sdma_v5_2.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 1813c3ed0aa60..37f4b5b4a098f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1543,8 +1543,13 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring =
*ring, unsigned int vmid)  {
        struct amdgpu_device *adev =3D ring->adev;
        u32 inst_id =3D ring->me;
+       int r;
+
+       amdgpu_amdkfd_suspend(adev, true);
+       r =3D amdgpu_sdma_reset_engine(adev, inst_id);
+       amdgpu_amdkfd_resume(adev, true);

-       return amdgpu_sdma_reset_engine(adev, inst_id);
+       return r;
 }

 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring) diff --git a/dri=
vers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.=
c
index 23f97da628087..0b40411b92a0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1456,8 +1456,13 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring =
*ring, unsigned int vmid)  {
        struct amdgpu_device *adev =3D ring->adev;
        u32 inst_id =3D ring->me;
+       int r;
+
+       amdgpu_amdkfd_suspend(adev, true);
+       r =3D amdgpu_sdma_reset_engine(adev, inst_id);
+       amdgpu_amdkfd_resume(adev, true);

-       return amdgpu_sdma_reset_engine(adev, inst_id);
+       return r;
 }

 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
--
2.49.0


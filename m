Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6C5CCD185
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 13:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB8810EA55;
	Thu,  9 Oct 2025 13:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wJn9B7tc";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB59710EA55
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 13:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQfYG4Z9hiU6CEPy5Rklq39fVAmC526Jc3n9t1xvGP6Dok+e/mD6Cqeh7hQTBznVFk0TjzdzCfkFOTtmKlhcPmHd2mH+BG/dNlFTji+su5Y9KAnlBg1v/TvTQoVywZgPuVJ2VAC+kHN86bMQ1CYDUWenx3UhvIu5ZC+b6XxRHpSPHwgfFMJ8pwyzAlcbgG1/r4sT7a2zNqjVLld+xgWARZ1qJBo3HPYS+j532gF3+ZlbLsNajlm65itx3nZsQnm2o2lGF8j6Rqen7tyakhnByEg4XxDVp8ZEGCG2N1SXJBkE57/la5EcpvZZx4qCgffTkqLGralVx87u6/erBF94xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssEhEKYPh4oJR43l1gx+DyFtPrQNZKH6dIA4o6o3QC4=;
 b=D6KeMzIUwgMKioPN1tQ3OzJ+WUDZkpfSsEOivdsICGKjz/Tr6/C0k/+SETIBpN2opTYwGDVxODvRDi6IKMMKzcDfJtiHTMrjq8qzibCe3Q3V/o3AA58NNAT5QB1ihngCAFOXnVIn0T/VHwyOHyXZIYlGVVzelFzmnBKuexaY6twb9k67HuqT3wq7iDfFCIindNOnxHkkfiJtwLf5TATTzL/s0rniDJd/KX3PH7Lh7Z64kB5EvwzuHyicHnTKSeaQ4LPCO1svZ3cPHOynXLpvT8I04zjxkn/7eAye3TJntq7DaaOrg+6kxIBQNGQn8VttraKJqIhQ13aqHEv6cFbwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssEhEKYPh4oJR43l1gx+DyFtPrQNZKH6dIA4o6o3QC4=;
 b=wJn9B7tcZ/2xzgrPyGFHxhpKcPf76gFr1AxQsQNE7dAWznWuZP44V305e6+YmssVeop0/hnQhEY7tx4hcoPwVc82enZ/xjwybJBW88hM3iqekB253H/i1LhtqyTsbBs86vJHqcGUrQ8TtdlnswL/KOjHOyhY4VFv1t97u0pVjTo=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 13:50:35 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 13:50:35 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gande, Shravan kumar"
 <Shravankumar.Gande@amd.com>, "Pan, Ellen" <Yunru.Pan@amd.com>
Subject: RE: [PATCH 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
 during VF init
Thread-Topic: [PATCH 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
 during VF init
Thread-Index: AQHcOM0fChMDwDVOEUiBy4xLz9N+rrS50tGw
Date: Thu, 9 Oct 2025 13:50:34 +0000
Message-ID: <DS0PR12MB780418AEC761FDC930A1FA0B97EEA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251009033029.24986-1-yunru.pan@amd.com>
In-Reply-To: <20251009033029.24986-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-09T13:40:01.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|BL1PR12MB5923:EE_
x-ms-office365-filtering-correlation-id: d5983423-2d02-4587-f1fc-08de073ad238
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OciAh6ylCzTsXDE1KUn5Sz1GhZAh7QddmnXzFachbNOtdwD/0BDcgpKOk69O?=
 =?us-ascii?Q?SOj8HaUEbmAPAvVB+XXGV0nai/nOwzmNPYyBXQJ65qJheJqSdGgkgLGBDgun?=
 =?us-ascii?Q?+2HW9W3m1lcXSOoKrC/tDMisN1TP9gdsNYaoLhGCpIJCQTzBHXwGp85vmRUw?=
 =?us-ascii?Q?/i4livrDLlc2NiK4IS3K8RwIlsuCThmyxtllGa6fqrSNLz18hTnQWg5H1CX2?=
 =?us-ascii?Q?FDctoV5bBS8/odZAKFJ0v93+9KN2FXIbQ800aNcRDR5PLVxd1udYakIdPBUb?=
 =?us-ascii?Q?0LuuHNgBVeEJEPS+reDF+UAu/qpr/C25JV5uHepEJsggmNtlzXELVfd9avYW?=
 =?us-ascii?Q?OxEu3c0/hKu0JU03PVR9pLGHuou2OX+D8herRfYf19211c6CB1XfMsU451Jg?=
 =?us-ascii?Q?gUdgbAbcIOHXtRrfX5xuulyrUFiAdix9e9a7s6yt3oP3unv4iB+bIE5yE+Fg?=
 =?us-ascii?Q?qwME4L8L1G9llRQeydZTUPOSXcCYe4i0yMAGshUGnIqcljGY6Y+YitBbMX4o?=
 =?us-ascii?Q?VPeAe2Qayma0lAM3JpiT8/AEIVV28eaa1RdCKXnaeGo/ZluAJgl1+tziJ9h6?=
 =?us-ascii?Q?iYBDFPPOsmsZGfF+Ad3A0fbUtfvbjt53MJk0LhpYwM42Vda/Nt/6ETnGdRD4?=
 =?us-ascii?Q?zSa9DhXwd2Gq5oKzy/PK8RAhhfC9bVpyZIOlGrIE41gZroewu5n5gxXOpaNJ?=
 =?us-ascii?Q?hoszm7oOzli84aBoewFKWm5en0cZQ9SUjSEJpTxH0om7QKgz2LfSWa6JjOl4?=
 =?us-ascii?Q?BnaO4+Bj7nB8jnECMaUYd7/CS3tFifUakSgsTGwOU1V+YGCHpwwmKKvhVhRy?=
 =?us-ascii?Q?Lvit9jxczWY4nfs3LpEmTB0uB9NpkuUX+SGxESCrctNjMVU4Hjv7DDrZxJ57?=
 =?us-ascii?Q?ERK+iBsO6+2J3O/Z1O94PenbOqD+COQnluxFa/SM1Otm1gQYj5mFiOdIXjJD?=
 =?us-ascii?Q?7RQxrO//JJMECljgRRAur/K/P4bxPQEAJtL3zYhrok4tnJETX9DHMinfokko?=
 =?us-ascii?Q?N3jk0BwMXDK8Bx6XRfwRMKdbhaybL4PfGMpz3r0CCVE/f7/G36wOCB0+or3z?=
 =?us-ascii?Q?2F4rpXlLrpcRtJNCOv09QPUzzL5qdNImuvij0wCBltd+X9OQGIXWXpmiwfZC?=
 =?us-ascii?Q?GliVGCJEFLPElE4KjlWIfzJcaztxBLwIGdXE76ThivrNW6MOVUo/AX/spcR3?=
 =?us-ascii?Q?XVFHGpHgX3oArndCQwrQJ2Z3QwcUEsfv9DAD0mbVKSA+OOBvFCrQiPVwBzFJ?=
 =?us-ascii?Q?JZyJq/ZuPfSBhmOtWwBxfnbOu9QFLqkeobIg1eT0a96vtGcDZCYR8ZknlC92?=
 =?us-ascii?Q?7HRS4vVSG8DxFdgscFRn74M0DcbX5B0kk8SIZgpjcHZJVHCL48RLnB2CB1fp?=
 =?us-ascii?Q?HHjO1VDhqQSM5MBT4IW53gXCisatXF28IUWxMUH5IohRRZv0vz0qQp8FE1FC?=
 =?us-ascii?Q?mfq6zl9rNcSwMoh3+9TzIfD4pEEukX2VE3w/kWE7prxutP3OwfpdR3wdq7fT?=
 =?us-ascii?Q?d0NxP7F0tTVhvrBur7lRPWAXwJPgZ3HeKyx6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ROxdFmQDsJeLih6JuSNroiNchr2/p8ALHEq7iQozuBax2BQSQxIFvP+Ch/40?=
 =?us-ascii?Q?UV9ipjGfDfncEi8AUEjnlhT1ku1dvCWZNcASxndt9jCXUtzxKPVxvgPNbAGH?=
 =?us-ascii?Q?RHCYmJBjq/bH0v2+QnoJjNnynok670Tm6eKB2dIZMvCPepWSyA1aF1vZRRUO?=
 =?us-ascii?Q?kfKTLSsupmpFg58Ix50WVHtBhekt70vSiYjYxYvRgZF44rNJc1iru5ChpvAT?=
 =?us-ascii?Q?L5xNcsHGwEZiD63gR3wwF3Z18jbZANUZwuOMSdziB8qBhNetFI/cRqwp3FQQ?=
 =?us-ascii?Q?U3SWJGbiuwUCpA3MpsYvUzggPQ4Kte1ffVJjPHb6gBiT7nAnbyWMkyFoYGiN?=
 =?us-ascii?Q?7pjajSgrQSZ2MWUzfi3sm5eivBL5YJFR0rxfRDuXIpd3oF2UqweIRS9nXM8W?=
 =?us-ascii?Q?aTbXUG4dRcPjdgUKeC5IE4B19CmE9PRU3CRdW3WA3yYQP0MN3n/kCTXZBcEw?=
 =?us-ascii?Q?/RE0f3y8y6S/r2OozjH7sV/rmo/hKwNIXHR60YhXQ7yYvIdoaddz/7BuBddA?=
 =?us-ascii?Q?N8Llud1fomtJNISiRFmXS1HhpBgm1nok4hUQiWFRCGVgyP0i/stv3hDVBw9t?=
 =?us-ascii?Q?3x+BTebcXVY5wj1LdDpgj4OlM9ax7LjJV0TVu273iT+mA7riHcsnGVkISw3b?=
 =?us-ascii?Q?g0iTYQq6qDIvc5T3k7tTQ/ccMCQCRzha7+5Fg6kOw2co7JpZo6NH5rIv0QyQ?=
 =?us-ascii?Q?RWRx7/hgFvv/7T7aGu7iYCzG8SsRVzUHV6kIl0Kz9HWH3/8zyTGtymCQ1CKl?=
 =?us-ascii?Q?uv6NVGq528wUYTXb00sB45414KjsQORdOFmpIkR7fFQhJpQRkNmHUa4dc6n2?=
 =?us-ascii?Q?FbpgvCZ5xTMs61IIpBi51aGGuwJ30QPtXRUWutITdcg9TD3/WxQz/zLqw7z4?=
 =?us-ascii?Q?22fcD4Bq8NPN/KoxxCJ3USie3INp1OvJPcoq7l979arp+/nVcoWuIYXZEgqQ?=
 =?us-ascii?Q?BPzSmuYMffjyX+CPgPT1arCM5mdE8kFHacSKNAH4jee64g+zq6O2ic7+yWsJ?=
 =?us-ascii?Q?RiEjFyVV2h9IyyKuDyXy+n6sUGQXAeYGg+mxj6cQKfPRw8u6+1t0HG4RmRYf?=
 =?us-ascii?Q?23skH3Xs7URAAiyorRaJHe1khiOJLOhdHA1RCX33Mo2quI1uHjbG0FiuwO5/?=
 =?us-ascii?Q?cgcyzt6JKcNCWYi1c4OKeOLNMGphsNIsWhg4Xi5Imc3sqYQS6LauyrsXQ50t?=
 =?us-ascii?Q?wJ88a6H1Ck7Uvqr1xyAItMwzPZ5Y6aif5EezXHP+cIfyuRKlZZVhsMD8vJRS?=
 =?us-ascii?Q?4k+4ON6MDae/7gjP/H3b/RW5gSpUuU3aZy8Qce0vrHDkxIuzpkTz1KxusWMi?=
 =?us-ascii?Q?s5NybIAgLuaEsgXXJYgvY5QO1BGWfTOJXIaLG52ckC81Mkfo83gIYdKEm5dC?=
 =?us-ascii?Q?AeyhZXg9s5zp8zU2jCEpHaZ/9gAqGmaWsuHVZzni9ecb399Lm8C+cv64jmz3?=
 =?us-ascii?Q?HVjvqcHwvjqvxd5HYXzFaH7/bi2unyNcyjpGhu118Q3QRx5KZ1afcFbX5/HR?=
 =?us-ascii?Q?UnJewZJFY31zmJ0NeGsUkcMSglq8hWUIqk8EybZK36qZZtjwQS1LtDmEtuvl?=
 =?us-ascii?Q?eac55+8fuC2s2DhyYEk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5983423-2d02-4587-f1fc-08de073ad238
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 13:50:34.9367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qLOrHyfoCScvEC4rO77HsfBKMwdI/av5pYPu39fRAGTMUk0oASkG/ULpyOA46K2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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

Thanks,
Lijo
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ellen
>Pan
>Sent: Thursday, October 9, 2025 9:00 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Gande, Shravan kumar
><Shravankumar.Gande@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
>Subject: [PATCH 3/6] drm/amdgpu: Introduce SRIOV critical regions v2 durin=
g
>VF init
>
>    1. Introduced amdgpu_virt_init_critical_region during VF init.
>     - VFs use init_data_header_offset and init_data_header_size_kb
>            transmitted via PF2VF mailbox to fetch the offset of
>            critical regions' offsets/sizes in VRAM and save to
>            adev->virt.crit_region_offsets and adev->virt.crit_region_size=
s_kb.
>
>Signed-off-by: Ellen Pan <yunru.pan@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   6 ++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 103
>++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |   7 ++
> drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++++
> 4 files changed, 147 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 929936c8d87c..2a33b950d511 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -2754,6 +2754,12 @@ static int amdgpu_device_ip_early_init(struct
>amdgpu_device *adev)
>               r =3D amdgpu_virt_request_full_gpu(adev, true);
>               if (r)
>                       return r;
>+
>+              if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2)=
 {
>+                      r =3D amdgpu_virt_init_critical_region(adev);
>+                      if (r)
>+                              return r;
>+              }
>       }
>
>       switch (adev->asic_type) {
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>index 3a6b0e1084d7..46c19e96086a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>@@ -843,6 +843,109 @@ static void amdgpu_virt_init_ras(struct
>amdgpu_device *adev)
>       adev->virt.ras.cper_rptr =3D 0;
> }
>
>+static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t
>+*buf_start, uint8_t *buf_end) {
>+      uint32_t sum =3D 0;
>+
>+      if (buf_start >=3D buf_end)
>+              return 0;
>+
>+      for (; buf_start < buf_end; buf_start++)
>+              sum +=3D buf_start[0];
>+
>+      return 0xffffffff - sum;
>+}
>+
>+#define mmRCC_CONFIG_MEMSIZE  0xde3
>+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev) {
>+      struct amd_sriov_msg_init_data_header *init_data_hdr =3D NULL;
>+      uint32_t init_hdr_offset =3D adev->virt.init_data_header_offset;
>+      uint32_t init_hdr_size =3D adev->virt.init_data_header_size_kb << 1=
0;
>+      uint64_t pos =3D 0;
>+      uint64_t vram_size;
>+      int r =3D 0;
>+      uint8_t checksum =3D 0;
>+
>+      if (init_hdr_offset < 0) {
>+              DRM_ERROR("Invalid init header offset\n");
>+              return -EINVAL;
>+      }
>+
>+      vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
[lijo]
We do a check against all 0xFFs as well which is invalid.

>+      if ((init_hdr_offset + init_hdr_size) > vram_size) {
>+              DRM_ERROR("init_data_header exceeds VRAM size,
>exiting\n");
>+              return -EINVAL;
>+      }
>+
>+      /* Allocate for init_data_hdr */
>+      init_data_hdr =3D kzalloc(sizeof(struct
>amd_sriov_msg_init_data_header), GFP_KERNEL);
>+      if (!init_data_hdr)
>+              return -ENOMEM;
>+
>+      pos =3D (uint64_t)init_hdr_offset;
>+      amdgpu_device_vram_access(adev, pos, (uint32_t *)init_data_hdr,
>+                                      sizeof(struct
>amd_sriov_msg_init_data_header), false);
>+
>+      switch (init_data_hdr->version) {
>+      case GPU_CRIT_REGION_V2:
>+              if (strncmp(init_data_hdr->signature, "INDA", 4) !=3D 0) {
>+                      DRM_ERROR("Invalid init data signature: %.4s\n",
>init_data_hdr->signature);
>+                      r =3D -EINVAL;
>+                      goto out;
>+              }
>+
>+              checksum =3D
>+                      amdgpu_virt_crit_region_calc_checksum((uint8_t
>*)&init_data_hdr->initdata_offset,
>+                              (uint8_t *)init_data_hdr + sizeof(struct
>amd_sriov_msg_init_data_header));
>+              if (checksum !=3D init_data_hdr->checksum) {
>+                      DRM_ERROR("Found unmatching checksum from
>calculation 0x%x and init_data 0x%x\n",
>+                                              checksum, init_data_hdr-
>>checksum);
>+                      r =3D -EINVAL;
>+                      goto out;
>+              }
>+
>+              /* Initialize critical region offsets */
>+              adev->virt.crit_region_base_offset =3D init_data_hdr-
>>initdata_offset;
>+              adev-
>>virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID] =3D
>+                      init_data_hdr->ip_discovery_offset;
>+              adev-
>>virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] =3D
>+                      init_data_hdr->vbios_img_offset;
>+              adev-
>>virt.crit_region_offsets[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID] =3D
>+                      init_data_hdr->ras_tele_info_offset;
>+              adev-
>>virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] =3D
>+                      init_data_hdr->dataexchange_offset;
>+              adev-
>>virt.crit_region_offsets[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =3D
>+                      init_data_hdr->bad_page_info_offset;
>+
>+              /* Initialize critical region sizes */
>+              adev->virt.crit_region_size_in_kb =3D init_data_hdr-
>>initdata_size_in_kb;
>+              adev-
>>virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID] =3D
>+                      init_data_hdr->ip_discovery_size_in_kb;
>+              adev-
>>virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] =3D
>+                      init_data_hdr->vbios_img_size_in_kb;
>+              adev-
>>virt.crit_region_sizes_kb[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID] =3D
>+                      init_data_hdr->ras_tele_info_size_in_kb;
>+              adev-
>>virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] =3D
>+                      init_data_hdr->dataexchange_size_in_kb;
>+              adev-
>>virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =3D
>+                      init_data_hdr->bad_page_size_in_kb;
>+
>+              adev->virt.init_data_done =3D true;
>+              break;
>+      default:
>+              DRM_ERROR("Invalid init header version: %u\n",
>init_data_hdr->version);
>+              r =3D -EINVAL;
>+              goto out;
>+      }
>+
>+out:
>+      kfree(init_data_hdr);
>+      init_data_hdr =3D NULL;
>+
>+      return r;
>+}
>+
> void amdgpu_virt_init(struct amdgpu_device *adev)  {
>       bool is_sriov =3D false;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>index 2a0627596bd2..5f6014b2f349 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>@@ -292,6 +292,11 @@ struct amdgpu_virt {
>       /* critical regions v2 */
>       uint32_t init_data_header_offset;
>       uint32_t init_data_header_size_kb;
>+      uint32_t crit_region_base_offset;
>+      uint32_t crit_region_size_in_kb;
>+      uint64_t crit_region_offsets[AMD_SRIOV_MSG_MAX_TABLE_ID];
>+      uint64_t crit_region_sizes_kb[AMD_SRIOV_MSG_MAX_TABLE_ID];
[lijo]

For this type of thing, it's better to keep the data together like in struc=
t with offset/size
        struct amdgpu_virt_region       crit_regn;
        struct amdgpu_virt_region       crit_regn_tbl[AMD_SRIOV_MSG_MAX_TAB=
LE_ID];

Thanks,
Lijo

>+      bool init_data_done;
>
>       /* vf2pf message */
>       struct delayed_work vf2pf_work;
>@@ -428,6 +433,8 @@ void amdgpu_virt_exchange_data(struct
>amdgpu_device *adev);  void amdgpu_virt_fini_data_exchange(struct
>amdgpu_device *adev);  void amdgpu_virt_init(struct amdgpu_device *adev);
>
>+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
>+
> bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int
>amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);  void
>amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev); diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>index b53caab5b706..d15c256f9abd 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>@@ -70,6 +70,37 @@ enum amd_sriov_crit_region_version {
>       GPU_CRIT_REGION_V2 =3D 2,
> };
>
>+/* v2 layout offset enum (in order of allocation) */ enum
>+amd_sriov_msg_table_id_enum {
>+      AMD_SRIOV_MSG_IPD_TABLE_ID =3D 0,
>+      AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
>+      AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
>+      AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
>+      AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
>+      AMD_SRIOV_MSG_INITD_H_TABLE_ID,
>+      AMD_SRIOV_MSG_MAX_TABLE_ID,
>+};
>+
>+struct amd_sriov_msg_init_data_header {
>+      char     signature[4];  /* "INDA"  */
>+      uint32_t version;
>+      uint32_t checksum;
>+      uint32_t initdata_offset; /* 0 */
>+      uint32_t initdata_size_in_kb; /* 5MB */
>+      uint32_t valid_tables;
>+      uint32_t vbios_img_offset;
>+      uint32_t vbios_img_size_in_kb;
>+      uint32_t dataexchange_offset;
>+      uint32_t dataexchange_size_in_kb;
>+      uint32_t ras_tele_info_offset;
>+      uint32_t ras_tele_info_size_in_kb;
>+      uint32_t ip_discovery_offset;
>+      uint32_t ip_discovery_size_in_kb;
>+      uint32_t bad_page_info_offset;
>+      uint32_t bad_page_size_in_kb;
>+      uint32_t reserved[8];
>+};
>+
> /*
>  * PF2VF history log:
>  * v1 defined in amdgim
>--
>2.34.1


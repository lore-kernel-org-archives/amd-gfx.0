Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA26C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 10:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFAC10E6B0;
	Tue, 20 Aug 2024 10:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C94JaDwi";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1557510E6B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 10:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDyo2JC+JI+NmBgP9s1cvQZYhZP2rIoWf0b1CmkI6twGzU4+xThSrBKgLFek8hlBEBz97/zAeTy0OuctRDfHU4VZ1GHvw4zsh6pYWsWoTZt4AC3NlR+8xt+CrN55BYjuN8fwHzWuISDPrlQSGCuj8GHWg5+BHp60MVFU8/KQXw1GtJln/cDbKbcrSWdAq+Noo1jTEFCho0pMwD3nDsNjzXXK2q7VWmrow6xIuOwlo+Lva6z1/BMJ33PjUFpqVn+wXjmWlvnA9ElwjayjIIxiup/fX7nQEChajdp3rHW85JRp8MygZI2Y2P/LQe7dquvvZ3jeUJ+1L/QFsNx2guZiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmmD9Zfhb6kj6LlfQgxI0tczDrLwWYmBZ93Z38xanMQ=;
 b=IkS0HeMOj75nVqqfUEOuxUp0KrfRm9wUnaFHr6B8po+abD58s1jLm8Ld213Qcf7YKJrj1HXNSK5RjvhVCMqUJz/NadAqOebrwd7DTZG31aHfV7NWxaEgcbWD/HzePOEEeDBXUUKTNY/IjFegpRPkMjUHszydMuiNX/aEOr2/PJVmJQqdGOzFdUbNqoUvYdtbXwfm5SqeBgjc3d0OkTrw6DufsGIhtkGXDTx6dzko/Jj9G+1CxiY2kH5QTIyMLAeEXBpILZ9jFhr/3benl8iFaIpHxkf8RE9rQNiI9yGw2flJKGzz36sWJW3HFKUOl4lBrzslshQPByVKF9ZB8kSjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmmD9Zfhb6kj6LlfQgxI0tczDrLwWYmBZ93Z38xanMQ=;
 b=C94JaDwibVPvAFDX+hDLBxm0O5HD8HKG9lquInXUflnfyRL5kbBPDbSwc91age7H/NXrgqOmo/utTDEVg8m44lfl1A/l1uoaFb2nGERg8i2NipXa3g6rMBB1qt84ymItt2vsZ4CLBzlNkwIQOdh1ifnxX7zyxdB51tyHbAji77U=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 10:17:46 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 10:17:46 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
Thread-Topic: [PATCH] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
Thread-Index: AQHa8t8joBpWqo+hYEyBrrjjXaSqM7Iv420AgAAKtxA=
Date: Tue, 20 Aug 2024 10:17:46 +0000
Message-ID: <DS7PR12MB60056E36DC77D6D44EDFF926FB8D2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240820085810.2831063-1-Prike.Liang@amd.com>
 <PH0PR12MB5404B927720EA127895F155DF68D2@PH0PR12MB5404.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5404B927720EA127895F155DF68D2@PH0PR12MB5404.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=21a6c5c7-e0c2-4c21-b175-8200273d6bbf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-20T09:31:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ2PR12MB7942:EE_
x-ms-office365-filtering-correlation-id: 7cfcae7e-6061-4087-87fe-08dcc1015620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?P4CFZofljFYDGo8BW/zIm77XJCuUap3T+DzJy+urT+M/sWDOzEWrjQxL3M0B?=
 =?us-ascii?Q?L1+rmt9w1fbx1JsNW/DOG2pJDmfevgfIYQRExHMkDUjfNRp+R5n0LeFr7G5R?=
 =?us-ascii?Q?wNLjAhm3KgFekZtbnOfwaDUJJKJqaoRI1vnDPAO+A2zHdmYxcmKPh85x49GO?=
 =?us-ascii?Q?nUsH6F7wZsgy/+7/7z/RtBzy/2t2kExqqbHkA9Xd+dg41o2667yVn1h1rYPP?=
 =?us-ascii?Q?itA+flUOxEHqaeGS+/+Lf3+RRhnL1cpP7cFwPJL01d9tCX3ZLkQdg73XrlgT?=
 =?us-ascii?Q?iioHef7+ObTsNbID8KqwaJikjPkLMN4QdLVeYa+Di+KVpJlwW4fVN/9iErVX?=
 =?us-ascii?Q?oBhysTv++AjfGiP5/du9cg8pVhS8yAsGFl6e5/MnNC2Ujs28y+4YxxXAo5/L?=
 =?us-ascii?Q?w9ASnga/1nVKBWdDU/2aapx7Jc5zY/6hD+oCjmX1VtidtuaEEBmqyQ8CnX3U?=
 =?us-ascii?Q?lW6Jcxu2eJAZnef5e0jvm8sfaAsIKYQnKCQqDZjP+jUSYcfX7PGz4zVrQPmq?=
 =?us-ascii?Q?NUn2cfJkUgzj8i3W7Wx0YuTndEfHlRvVxtZ6jqO3ZVEEt75MhayxmkizE+md?=
 =?us-ascii?Q?Z6ZqHGb38mr7cEYJv5y0gZ0IA3Dq8u1r5AF1mzd89wadJkX500T1ci6VA0cR?=
 =?us-ascii?Q?n7i/LFpzOhBZJS/25irqBpO1fExXac3im5MLEEuFBuF63ldHllgwOWJQAa0v?=
 =?us-ascii?Q?/WjZUZuL/xLa3x1eJwvfiYXusXROcGDfA8MfJUiXOQGvYMZ9QJ2mA6rYMgS4?=
 =?us-ascii?Q?pmr2RAfEpzP8MQfJJ9HM6V26PO1l2HOkHQTzwaCgnGBMSLL0hozAaqLP27W7?=
 =?us-ascii?Q?cDZ6NtU8l+0B4v14zawgaEMakzR0hh1qeFgmyZXxHxl4VthRXhM19S9LE7+e?=
 =?us-ascii?Q?SmulzD4d3Lr/OtKlH8wzLPkxdU2PQh3vxW7UoJGYR+rMXedgRKuxUSF12GlW?=
 =?us-ascii?Q?cmPMGaY9Iw6+zKf2UKrkptkTpknq4RoSQGP0IMjUCgUjYkyNL5j3kti4p2wQ?=
 =?us-ascii?Q?znpiM1rJqGjwVA8lRbGGqI0LAZRR7qRcYaKG2dxkocEsqLWQpW5cEL4BCJSD?=
 =?us-ascii?Q?YBAUs9AXN2597/UHuod3SI1S5EfjqmqwMsAyyx/XeOHI5J9Ex1N/MZGYeww3?=
 =?us-ascii?Q?e5aIqzkcOcYtA/eVu5q9rik/VD8XnxWY3YZ45gff53dze6/fdp8wSuZeEsmN?=
 =?us-ascii?Q?zQ8RhzVc0WS8WhyX2qrolXoP/M34VG/FXyJsPqUZOSm9XV9Dr5h7JiNkCMB4?=
 =?us-ascii?Q?q3/KUF6+FC2cYj/zKoeOBXPDqYyFQRpS8qCdqscu0U+xYVVWP7AETt7S+vP5?=
 =?us-ascii?Q?EodeAktE1Trj1umwiTWKN5Wx13CSjxGEsgpULWGwrj1dvxCyIQTObau3ycg9?=
 =?us-ascii?Q?0Q5EgD5S/uzhMN41QBGQH5TiSXjBwEvdS39bEJAcY64nZ77Z9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dlxxsVLX+JNBO+iwpMzPos1H1Cft+GSJ8oScs7GxUdHtXPHklDTtKheolSfR?=
 =?us-ascii?Q?IgNn4pukdnDprCU2Rn1dkyw04Vu2lxa3mvXRSgtXivwiCT/m0P8etjt7hNx0?=
 =?us-ascii?Q?hx7IWPWHrhvxRTvKgi+wHqd402lzQWgJx5CLC9DL+ALjn/h/JtVpE7jnJXCw?=
 =?us-ascii?Q?sTkIAEa32Jh5GsOBMmUQ9CShUb3pQAzVSXVJ1uRwNUw2o0k5vQA6H7iYHgt7?=
 =?us-ascii?Q?IRGe2rq9Imz/TWgB6T/w9jk0V818FsFeW4rFyPSzw2Lm9K+uvl9XJFaNPEtB?=
 =?us-ascii?Q?KNkaYiPC6e5P2QYaoz8rfY2o4Gq4ooYOY0ci19zEC50hdRGs02zyZ9jMHzQD?=
 =?us-ascii?Q?UH0woyk+gGPA3zK/5jhjk/8QtYDRCx08TnDm9MICCSZ5I+zWIv3n5AMOs1Oa?=
 =?us-ascii?Q?K2A8+re+4A3TYW0lQFdLZIp+caunnFHrzte35d/XHTdpQf95+zfDMliyRzFq?=
 =?us-ascii?Q?Iwhq9rIU3K217nl0KFqoLZt/SG0++H1rcDnkXNLjPo8bqlo6puRMg2JL+AEN?=
 =?us-ascii?Q?F7P3G1O43uXGxg/MFns/qGrZjzBXPpcDcRiraPsTygHcEwoyAHwjsn33SIT8?=
 =?us-ascii?Q?GyfvUXWEEh5nUFgg6HalMPlwXET/vjVnexILExqwzAsL36Ke7Ggld0PQnwQF?=
 =?us-ascii?Q?eWzv0q/qCOSalSaAKzSkxcww25FP8tDjA2G49NKsQm8w9DiwmDcMO179aiYi?=
 =?us-ascii?Q?FJ8EN0JNoBxt3WoN2VqfQ1AlDSXEPceyhFaPitWZmRiU5G+vJ9e1H7HYAbWW?=
 =?us-ascii?Q?LOYMoZsR0eEAj8GJBIDU3M0kZfFHTzRFV9j0enugjzqmAMh4y74EhJspaQFM?=
 =?us-ascii?Q?KEsu1NVoF08l+ksdz259mMDaFApDXBKpDWu/Ss+eaYbo04DIGyUUfmiSiIdt?=
 =?us-ascii?Q?HFhpHhpdwmDZFznig+AwEh9mUjeuEzFkHy1WqGka6HpT1ZkqzoVZhadjmUaA?=
 =?us-ascii?Q?IGDt/NDk5S6M1r0HkWpjOUArHEUNTdgUvCExqpirAKnFgQ/BUEkzT9Zjz0jV?=
 =?us-ascii?Q?Q81hNlDD9bYT0L3DX64jjVHdrfI7KlHCjYkknMY08/93w27T2syErhngg2MZ?=
 =?us-ascii?Q?5aputjXeGGuwSNcnamVqhSx3/ReYTer+u1i1Z0uSWoQfex66ThGkY5FJdONs?=
 =?us-ascii?Q?WUdGgLJYpn5IiHmyZBHxdhhjQYDgzk2kzSBqjJWs0ba5GJWs80raVA+BrTwG?=
 =?us-ascii?Q?9GbDEI72+1HiaKNsaym/ISJckbf4G72YBH/W+tQOvqEYp66TEwZQVJthVWC2?=
 =?us-ascii?Q?ji+lV73wGW6/D0noV7YQz2PKny/tlwsm7WllgEEkUzt0hRkirfu1apEh89pb?=
 =?us-ascii?Q?oklNOHnp+4PeMs6sIhWft5eiJHRlBQphYeBgV7F6YQf1D0Eq6zxuuv2K4eGs?=
 =?us-ascii?Q?CTu9iRBtl6DU80HD5h7NW2vjYFou/IdA7v62zeJ2x/Uo09iRYsFKb9ildyT6?=
 =?us-ascii?Q?yAfkrCFbJQQb5KDMecvGzgBmiEWKo66k3ola8MNjdTwHoumQwFLJEZxC305B?=
 =?us-ascii?Q?QWpAFvXTKCjsHoKvvJvJfIYY7iT5K0v4rAMkxlJOu3iSo3Vu1cdRY2GDh6zW?=
 =?us-ascii?Q?BnGxG6A2w1qtOtHltws=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfcae7e-6061-4087-87fe-08dcc1015620
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 10:17:46.3307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZwKMSlG3DvUbwb0uU6gnG83fZdVT2b9BH3POCMBBQJRLBClrU909rFk74r9dT0f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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

> From: Ma, Le <Le.Ma@amd.com>
> Sent: Tuesday, August 20, 2024 5:38 PM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Prike Liang
> > Sent: Tuesday, August 20, 2024 4:58 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
> >
> > Implement the compute pipe reset and driver will fallback to pipe
> > reset when queue reset failed.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 153
> > ++++++++++++++++++++----
> >  2 files changed, 138 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index e28c1ebfa98f..d4d74ba2bc27 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -143,6 +143,11 @@ struct kiq_pm4_funcs {
> >                                  uint32_t queue_type, uint32_t me_id,
> >                                  uint32_t pipe_id, uint32_t queue_id,
> >                                  uint32_t xcc_id, uint32_t vmid);
> > +     int (*kiq_reset_hw_pipe)(struct amdgpu_ring *kiq_ring,
> > +                                uint32_t queue_type, uint32_t me,
> > +                                uint32_t pipe, uint32_t queue,
> > +                                uint32_t xcc_id);
> > +
> >       /* Packet sizes */
> >       int set_resources_size;
> >       int map_queues_size;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > index 2067f26d3a9d..09caa5a1842b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -166,6 +166,10 @@ static int gfx_v9_4_3_get_cu_info(struct
> > amdgpu_device *adev,
> >                               struct amdgpu_cu_info *cu_info);  static
> > void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int
> > xcc_id);  static void gfx_v9_4_3_xcc_unset_safe_mode(struct
> > amdgpu_device *adev, int xcc_id);
> > +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> > +                                     uint32_t queue_type, uint32_t me,
> > +                                     uint32_t pipe, uint32_t queue,
> > +                                     uint32_t xcc_id);
> >
> >  static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
> >                               uint64_t queue_mask) @@ -323,6 +327,7 @@
> > static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs =3D {
> >       .kiq_query_status =3D gfx_v9_4_3_kiq_query_status,
> >       .kiq_invalidate_tlbs =3D gfx_v9_4_3_kiq_invalidate_tlbs,
> >       .kiq_reset_hw_queue =3D gfx_v9_4_3_kiq_reset_hw_queue,
> > +     .kiq_reset_hw_pipe =3D gfx_v9_4_3_kiq_reset_hw_pipe,
> >       .set_resources_size =3D 8,
> >       .map_queues_size =3D 7,
> >       .unmap_queues_size =3D 6,
> > @@ -3466,6 +3471,115 @@ static void gfx_v9_4_3_emit_wave_limit(struct
> > amdgpu_ring *ring, bool enable)
> >       }
> >  }
> >
> > +static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t
> me,
> > +                             uint32_t pipe, uint32_t queue,
> > +                             uint32_t xcc_id) {
> > +     int i, r;
> > +     /* make sure dequeue is complete*/
> > +     gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> > +     mutex_lock(&adev->srbm_mutex);
> > +     soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id))=
;
> > +     for (i =3D 0; i < adev->usec_timeout; i++) {
> > +             if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
>
> Should GET_INST be used to locate the target xcc_id here?
>
Thanks for pointing this out, it requires to covert the GC logical instance=
 to physical instance on this ASIC and will address it in later version.

> > +                     break;
> > +             udelay(1);
> > +     }
> > +     if (i >=3D adev->usec_timeout)
> > +             r =3D -ETIMEDOUT;
> > +     else
> > +             r =3D 0;
> > +     soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> > +     mutex_unlock(&adev->srbm_mutex);
> > +     gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> > +
> > +     return r;
> > +
> > +}
> > +
> > +static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
> > +{
> > +
> > +     if (unlikely(adev->gfx.mec_fw_version < 0x0000009b)) {
> > +             DRM_WARN_ONCE("MEC firmware version too old, please use
> > FW no older than 155!\n");
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> > +                                     uint32_t queue_type, uint32_t me,
> > +                                     uint32_t pipe, uint32_t queue,
> > +                                     uint32_t xcc_id) {
> > +     struct amdgpu_device *adev =3D kiq_ring->adev;
> > +     uint32_t reset_pipe, clean_pipe;
> > +     int r;
> > +
> > +     if (!gfx_v9_4_3_pipe_reset_support(adev))
> > +             return -EINVAL;
> > +
> > +     gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> > +     mutex_lock(&adev->srbm_mutex);
> > +     soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC,
> > + xcc_id));
> > +
> > +     reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
>
> Here the xcc_id is also missed to address.
>
> > +     clean_pipe =3D reset_pipe;
> > +
> > +     if (me =3D=3D 1) {
> > +             switch (pipe) {
> > +             case 0:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME1_PIPE0_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME1_PIPE0_RESET, 0=
);
> > +                     break;
> > +             case 1:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME1_PIPE1_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME1_PIPE1_RESET, 0=
);
> > +                     break;
> > +             case 2:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME1_PIPE2_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME1_PIPE2_RESET, 0=
);
> > +                     break;
> > +             case 3:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME1_PIPE3_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME1_PIPE3_RESET, 0=
);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +     } else {
> > +             if (pipe) {
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME2_PIPE1_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME2_PIPE1_RESET, 0=
);
> > +             } else {
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME2_PIPE0_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > CP_MEC_CNTL,
> > +                                                MEC_ME2_PIPE0_RESET, 0=
);
> > +             }
> > +     }
> > +
> > +     WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL,
> > reset_pipe);
> > +     WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL,
> > clean_pipe);
> > +     soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> > +     mutex_unlock(&adev->srbm_mutex);
> > +     gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> > +
> > +     r =3D gfx_v9_4_3_unmap_done(adev, me, pipe, queue, xcc_id);
> > +     return r;
> > +}
> > +
> >  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
> >                               unsigned int vmid)  { @@ -3473,7 +3587,7
> > @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[ring->xcc_id];
> >       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> >       unsigned long flags;
> > -     int r, i;
> > +     int r;
> >
> >       if (amdgpu_sriov_vf(adev))
> >               return -EINVAL;
> > @@ -3495,26 +3609,25 @@ static int gfx_v9_4_3_reset_kcq(struct
> > amdgpu_ring *ring,
> >       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
> > -     if (r)
> > -             return r;
> > -
> > -     /* make sure dequeue is complete*/
> > -     amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
> > -     mutex_lock(&adev->srbm_mutex);
> > -     soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0,
> > GET_INST(GC, ring->xcc_id));
> > -     for (i =3D 0; i < adev->usec_timeout; i++) {
> > -             if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
> > -                     break;
> > -             udelay(1);
> > -     }
> > -     if (i >=3D adev->usec_timeout)
> > -             r =3D -ETIMEDOUT;
> > -     soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
> > -     mutex_unlock(&adev->srbm_mutex);
> > -     amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
> >       if (r) {
> > -             dev_err(adev->dev, "fail to wait on hqd deactive\n");
> > -             return r;
> > +             DRM_ERROR("kiq ring test failed after ring: %s queue rese=
t\n",
> > +                             ring->name);
>
> Normally the dev_xxx print is used to trace the socket number where error
> happens.
>
> Thanks.
>
> > +             goto pipe_reset;
> > +     }
> > +
> > +     r =3D gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe,
> > + ring->queue,
> > ring->xcc_id);
> > +     if (r)
> > +             DRM_ERROR("fail to wait on hqd deactive and will try
> > + pipe
> > reset\n");
> > +
> > +pipe_reset:
> > +     if(r) {
> > +             r =3D gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs-=
>type,
> > +                                             ring->me, ring->pipe,
> > +                                             ring->queue, ring->xcc_id=
);
> > +             DRM_INFO("ring: %s pipe reset :%s\n", ring->name,
> > +                             r ? "failed" : "successfully");
> > +             if (r)
> > +                     return r;
> >       }
> >
> >       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> > --
> > 2.34.1
>


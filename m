Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F455C282C6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 22:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C695D10E2F4;
	Mon,  3 Mar 2025 22:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jf1Slc5J";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA5310E2EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 22:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox6rF8eT/IN/L7Z+/4mqV7uw9nHrrl3Xowx+W2AjElbBT2pv7KjYf+vDfvXirbotRy2uaIJIZ86JmW5vHvj/T6cM9i9xg5cMxFsXoJk682WYuRvWHF/oBy8+zMwn4njM16umQOqpZwIZzmKdCHQvWFTRTN+SfoNFMu7z/QAS/I19Nv+Yq/ck5bMgcawVqTas6cwv8UmiiP4yZl7v57t+X/JpsAR/iGYgi7LJQIb9xmOabGgI2pdXwnNlJbJ3S4JchqX1THgMmfFkKGgyU5l/hiZbe/DQFQjVsLnt8UcnY9iMZvntcj32c/qw9fZIv4nNs4EEE5/AruFbYgXvNA0Yag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2BHjGqxUp1DTLUkRGuAyyANvlv8Wdny54JIvZ2L8GY=;
 b=pv7SwTbs/zxFmi5ZM93l19aws8t+ChraugGpxoRiIiTTRcXWwOTmJWslNIIu+pqp0BDCjHAr3zzmTeCDy9Ww4Z9XfsfuKNZvv+eQHUQlIiatKO7Hk/ZG9LQBQM2aUwJ42Ncmnz9/vO3kc0GZ8tttY5ItMkfhOypJHxAqfUaNBEa7QHv5Q+V6SDucyvAjwogaqbFUpVVx+II0Tbwgtb/y8nG96l+UKRvFzt0c1tlh/ynerzuE4Tm6YN+N1BzuTu+RI2vVo1QnR4lpZntp/Qe6OBah1wMgceNHks+lnFQFJo5CEUpGOKiDJqk8TGrdAGboYSgxkqcGysPPOqOVaWPt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2BHjGqxUp1DTLUkRGuAyyANvlv8Wdny54JIvZ2L8GY=;
 b=Jf1Slc5JSXc3ZP5cxCS83UYauWQectWpaYYrGVmVldviHGHykMRspMqFedfcDFjbBFTarOHvfmpKqdrqlaxYcGr22sx/jdEEa2Iu+w6tuHwiJGHBYc150QcPVQdxiqLmNZMTVCmbM33JdUSP/Cl49dXyl9//6sNAxZ0/nR03pYg=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 22:15:18 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 22:15:17 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Add a temp w/a for a panel
Thread-Topic: [PATCH 1/2] drm/amd/display: Add a temp w/a for a panel
Thread-Index: AQHbjENPJaXBfJrJU06EmZ0U3tU9NrNh836AgAAHYDY=
Date: Mon, 3 Mar 2025 22:15:17 +0000
Message-ID: <CH0PR12MB5284B9B4406F51D836239EF18BC92@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20250303135051.1177406-1-aurabindo.pillai@amd.com>
 <1b98992a-d96c-4481-a74b-dc6a4454c020@amd.com>
In-Reply-To: <1b98992a-d96c-4481-a74b-dc6a4454c020@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T22:15:16.955Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|SA3PR12MB7782:EE_
x-ms-office365-filtering-correlation-id: 78d0e75c-3ad1-477a-307b-08dd5aa0e11c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?t/COHG05pmtB4+kMuc7Mt9bk7vSxLdggpeAE36jY22dKjpUrkxHnxN3QyAz2?=
 =?us-ascii?Q?aT9HpRVFgB9iq7QfNgZi7ZPFBlP3YXkUH+D94erX1+KhiFWJiImoYyh6ECLK?=
 =?us-ascii?Q?fGNkRJ9z1DIfmUJEgdfPJRCZudFvaGXuiGAjavaE0hzfMRzGVb1J92oBlA5V?=
 =?us-ascii?Q?oZiw+/qm5V1QDG5XnvjzFBBzvkAhoAFnukwMK20jebX6Fun1+dCKoPzW7Psn?=
 =?us-ascii?Q?Yr2kVVQQbxdY0Ivv95C9jnXyzTzccOikuSyTaXF1rIxZ696YysaNeZMzHz+X?=
 =?us-ascii?Q?6Ut15nyVX9YCYKZSt8rDZ/Y3OEeVpz4hH6EKbNIIbU5SnV81U8RvDlXfsFSP?=
 =?us-ascii?Q?/WUPGMGwbZyJGb0dvF5KNYiYty3L0rK1UGXUDmcW93IXuibaq3gbwsqfLF7u?=
 =?us-ascii?Q?jOOvWNqlcwtVcmQYaNzek3RpKDRSvp2tLdruHpAX6ggl8W8GFSRq55ghkzfK?=
 =?us-ascii?Q?vLXeSvyplnLVkdz1QUipg/sZohKx/HNAkHDdKyrf5hNVcXnQA0jI3AVJt0L3?=
 =?us-ascii?Q?F9214EBPL3scdqrjW7r6gnLcUWYrNOy1rfxzAKTS/mpV+M9NpyvfQdgueFzk?=
 =?us-ascii?Q?eVyHWriHJoonUwuO/N0RNni2fFxPr6/Tw1zydi2Wdpehczibd3M+GzZhe7fZ?=
 =?us-ascii?Q?umL/+hnhh1kkmrniVkw0Q/DKjQDgFOkl4G8NDKhrGd4enZMcPp3nFK2Bo8/h?=
 =?us-ascii?Q?ekoLupHYPhNDiSWy0oEA8fY1z/47uTmW0v2HfHeJr6gaNmVPcniw3VSBlxNB?=
 =?us-ascii?Q?i7RPpEYJhR8oIHvJfQdhzQ7/hcWo7pA+sxlOrSTl6I8BfU+87aNikXNagRyi?=
 =?us-ascii?Q?Y4JfYN93mfTLyvsNJNpAsHdafrjPfHjYsksf9kpYV1mc0sBUeJeLDvxANoVt?=
 =?us-ascii?Q?8+B0CAeTb7wHLV+hCUgtCoNk+CdqwxJoudbvVyVfkP6GyHAtwWYhFnTVKXg8?=
 =?us-ascii?Q?DKRgO/Tykr13Twsi3UY2bsJWAY98lGJDFgPykqGw+DV1MHH9ERpvR4WVIobM?=
 =?us-ascii?Q?RSHmvXMdfwQXmpcKJ3tWlJotYd8I+E/gMVRu8yI2kyC77t5Hlc/wzlChMGqq?=
 =?us-ascii?Q?fKtN4ir+RihpeUfw4eUlRlumrAUgFOUpqOmxde/gIk7AxKPTtEhODtq3jIZx?=
 =?us-ascii?Q?rWr+50GlilhGXdMY0F7ckXoyEnsbm8FBn+bGGfq0x8e4TewwJq+5BDBMvnB+?=
 =?us-ascii?Q?9fcEKk5OtWxx2flOnCDhOWnDUBSoUE5yQnsExlrKTINEgPo4Ap2q5yWIXYbU?=
 =?us-ascii?Q?Icy5KL0YrnpCbLpNu6iI0+sxEc+vCD1TH03nugylsfyDjd+eX6vDF88rRHQd?=
 =?us-ascii?Q?GY8i/z7QXRxVHO2q2CkTinCjJKAzuVfoKz6MTlVln5jIZmITV8MQYScD3tGg?=
 =?us-ascii?Q?JlY+LhWlNvVTLy2zYJi5J8Wq5WOXKI2bXSOmirYrDOh1z5m7BlyatouzZo1x?=
 =?us-ascii?Q?09lACV/ZsGJUUOz39MB8ehGQxHGa69nl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y40JOveBGU4eKB2Ze/dn9tJCNwmv7znCa2rNzp1GqKamwefGkXEp2o61b1rO?=
 =?us-ascii?Q?k3HEBPbkaxcoRnpJS9ShQinDjJLQfPRJmTu9OMljVdkHNG3iqll6p3gWU5Wm?=
 =?us-ascii?Q?pvOMmV38N3U5XojXtqk3eNm2MgP0ZHIyF+KLRSZGEusgizxJLe19Xf36tbdX?=
 =?us-ascii?Q?nrng8wAofmxSBIeHwjaMbawfN7vKNgb301DySyIy+H1GEFpXKjzacIS1wA+P?=
 =?us-ascii?Q?ywHBcD73OhUkmcSD72PqpBS8YcUIJlliBoG3WHzRdF1UMFUQNKExpbw+CFWi?=
 =?us-ascii?Q?Gno6W6kcPI4fAVXHb/U2KeWfyHivnvmI5AatoWo5RpnKWfP85jB1/6GdcYcd?=
 =?us-ascii?Q?kJka9tyzSoniEMiJoL8m0u4+XKJZNfn5S/i5OY/JdjhEyJ98XUkqvybU2ubu?=
 =?us-ascii?Q?6GoWbNSp1QeogkYY0Q3m0+CixLg8zh+ajuhbX+6SQ1ZdZYsp6HzxktawQ2cZ?=
 =?us-ascii?Q?ill16rMkOBtNzVEGRbKuzuD68buzZI9pXed59NfkVos7kIrHq5Y9iYkuUCZB?=
 =?us-ascii?Q?w37SMW587xv6SWmniFbIRsjaUpbmNps9FdM8cRhqfm3TIBXSNuwNv2QovAdg?=
 =?us-ascii?Q?uAu5R52Sf8YBCRBV2/r34p09lj8L5Ed4uDjQftfz5jHgal/paYi3YsYaSTv0?=
 =?us-ascii?Q?Cedy8mNGFZUAwdN2z+Ux/nLR7+OSljjj+Hc8De4/mY5zN/AtmhIlflydAjJd?=
 =?us-ascii?Q?6Kbhw4E+n5DrB6/qA/KNucBj2cvXCnLu2wOJLB7/E97RZElZygMR5CVZFAvj?=
 =?us-ascii?Q?eL4pJYyYBWDtwSQU3UilPZXIjWNPYbu3LYentJRGZ5qNJjwQ6s2fbvIX6q7H?=
 =?us-ascii?Q?2bhhsUhiVoGmVC1GLw7T+AhVeABY5VM+UTz8hR73Xu0SqZcsBpCAA059c2Tt?=
 =?us-ascii?Q?QaS9MvEe0JRiKZduwMm+GuQNh7xZOOYooSXZ283GdDtxv80BsN5MxCoNpvlj?=
 =?us-ascii?Q?Hfjo+EsV4pq64J2h9y088s0rO8ADrnkGXJ+nZQCmM50Na3dhM0fotQu5SSe8?=
 =?us-ascii?Q?1F4RekOnTTfp2B8fTOmdkmkUUQUwh6V1bQduHu3FbymU+1JfZptvS2aCx6NC?=
 =?us-ascii?Q?CJT1IWtLTxxZyNL2RTwqwgATm7+4JaIzy9bxjDtWyk+0qdecD0w9Amye4u+9?=
 =?us-ascii?Q?mq6CbVyapZUBuwdte1+hSJTBcHQGh+vB9oiCje86H5tK+Ne/VmzH+PDPtiYy?=
 =?us-ascii?Q?1CRGyhRjg7vSpovshex3LU+LbEHvZnrTgwZ00EOe0FCPmEOqESY0BZWNGZ7f?=
 =?us-ascii?Q?bhQueyHujaBw+Ph3U8gkIxeaHD2cp6URlBLxfMiboL5YEjqZHx05DHl0eAJR?=
 =?us-ascii?Q?2BM68hGJqXlBAOWLsvkSn+BF0BsG0XNorl8w70BD9SYx5SG7abachZ3TUBqf?=
 =?us-ascii?Q?3M4A+5Li1wJOEFd95TMN/qCSLyYQyoD1KHFRBgk8G8qfoeZdqPkM7vee0r9y?=
 =?us-ascii?Q?mVK4KObRaQ0RoQU7XdqIN9sVEOqcwd4SCUPs8ISkdWL7mPcsJQFTt8qXjQa4?=
 =?us-ascii?Q?dD/ED8PxrHG4ntLtMaJmGeOlKq4oQPFHGyWH/jmJMnhYXdq8AR5un4+iO8dh?=
 =?us-ascii?Q?bQBU5ugbTdct0iraDfI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284B9B4406F51D836239EF18BC92CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d0e75c-3ad1-477a-307b-08dd5aa0e11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 22:15:17.3890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SdXKeJKq+XU2rK0jG4IaqPyw+UbwOKJUCavnP7C5fm0I70vwd30naKQXPJd/HnXKuGD/+ya3MWwXCdRYIqqWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

--_000_CH0PR12MB5284B9B4406F51D836239EF18BC92CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks Alex, I'll fix that and push.



--

Regards,
Jay
________________________________
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Monday, March 3, 2025 4:48 PM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Add a temp w/a for a panel

This has conflicts to latest asdn and a minor spacing issue below.

The others look good to me.

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/3/25 06:50, Aurabindo Pillai wrote:
> Implement w/a for a panel which requires 10s delay after link detect.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++++++++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 10 ++++++--
>   drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
>   3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 73c95c3c39f9..3a2843e3367e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3327,6 +3327,21 @@ static void dm_gpureset_commit_state(struct dc_sta=
te *dc_state,
>        }
>   }
>
> +static void apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev, =
struct dc_sink *sink) {
> +     struct dc_panel_patch *ppatch =3D NULL;
> +
> +     if (!sink)
> +             return;
> +
> +     ppatch =3D &sink->edid_caps.panel_patch;
> +     if (ppatch->wait_after_dpcd_poweroff_ms) {
> +             msleep(ppatch->wait_after_dpcd_poweroff_ms);
> +             drm_dbg_driver(adev_to_drm(adev), "%s: adding a %ds delay a=
s w/a for panel\n",
> +                             __func__,
> +                             ppatch->wait_after_dpcd_poweroff_ms / 1000)=
;
This doesn't look aligned to me, and maybe the two line can fit into
one. But this is just my opinions.

> +     }
> +}
> +
>   static int dm_resume(struct amdgpu_ip_block *ip_block)
>   {
>        struct amdgpu_device *adev =3D ip_block->adev;
> @@ -3448,6 +3463,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_blo=
ck)
>        /* Do detection*/
>        drm_connector_list_iter_begin(ddev, &iter);
>        drm_for_each_connector_iter(connector, &iter) {
> +             bool ret;
>
>                if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WR=
ITEBACK)
>                        continue;
> @@ -3473,7 +3489,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_bl=
ock)
>                } else {
>                        guard(mutex)(&dm->dc_lock);
>                        dc_exit_ips_for_hw_access(dm->dc);
> -                     dc_link_detect(aconnector->dc_link, DETECT_REASON_R=
ESUMEFROMS3S4);
> +                     ret =3D dc_link_detect(aconnector->dc_link, DETECT_=
REASON_RESUMEFROMS3S4);
> +                     if (ret) {
> +                             /* w/a delay for certain panels */
> +                             apply_delay_after_dpcd_poweroff(adev, aconn=
ector->dc_sink);
> +                     }
>                }
>
>                if (aconnector->fake_enable && aconnector->dc_link->local_=
sink)
> @@ -3834,6 +3854,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_=
connector *aconnector)
>                        ret =3D dc_link_detect(aconnector->dc_link, DETECT=
_REASON_HPD);
>                }
>                if (ret) {
> +                     /* w/a delay for certain panels */
> +                     apply_delay_after_dpcd_poweroff(adev, aconnector->d=
c_sink);
>                        amdgpu_dm_update_connector_after_detect(aconnector=
);
>
>                        drm_modeset_lock_all(dev);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index fbd80d8545a8..253aac93e3d8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -55,11 +55,16 @@ static u32 edid_extract_panel_id(struct edid *edid)
>               (u32)EDID_PRODUCT_ID(edid);
>   }
>
> -static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *ed=
id_caps)
> +static void apply_edid_quirks(struct drm_device *dev, struct edid *edid,=
 struct dc_edid_caps *edid_caps)
>   {
>        uint32_t panel_id =3D edid_extract_panel_id(edid);
>
>        switch (panel_id) {
> +     /* Workaround for monitors that need a delay after detecting the li=
nk */
> +     case drm_edid_encode_panel_id('G', 'B', 'T', 0x3215):
> +             drm_dbg_driver(dev, "Add 10s delay for link detection for p=
anel id %X\n", panel_id);
> +             edid_caps->panel_patch.wait_after_dpcd_poweroff_ms =3D 1000=
0;
> +             break;
>        /* Workaround for some monitors which does not work well with FAMS=
 */
>        case drm_edid_encode_panel_id('S', 'A', 'M', 0x0E5E):
>        case drm_edid_encode_panel_id('S', 'A', 'M', 0x7053):
> @@ -101,6 +106,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>   {
>        struct amdgpu_dm_connector *aconnector =3D link->priv;
>        struct drm_connector *connector =3D &aconnector->base;
> +     struct drm_device *dev =3D connector->dev;
>        struct edid *edid_buf =3D edid ? (struct edid *) edid->raw_edid : =
NULL;
>        struct cea_sad *sads;
>        int sad_count =3D -1;
> @@ -130,7 +136,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>
>        edid_caps->edid_hdmi =3D connector->display_info.is_hdmi;
>
> -     apply_edid_quirks(edid_buf, edid_caps);
> +     apply_edid_quirks(dev, edid_buf, edid_caps);
>
>        sad_count =3D drm_edid_to_sad((struct edid *) edid->raw_edid, &sad=
s);
>        if (sad_count <=3D 0)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/=
amd/display/dc/dc_types.h
> index e60898c2df01..acd3b373a18e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
> @@ -181,6 +181,7 @@ struct dc_panel_patch {
>        uint8_t blankstream_before_otg_off;
>        bool oled_optimize_display_on;
>        unsigned int force_mst_blocked_discovery;
> +     unsigned int wait_after_dpcd_poweroff_ms;
>   };
>
>   struct dc_edid_caps {


--_000_CH0PR12MB5284B9B4406F51D836239EF18BC92CH0PR12MB5284namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks Alex, I'll fix that and push.<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof" style=3D"color: inherit;">
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hung, Alex &lt;Alex.H=
ung@amd.com&gt;<br>
<b>Sent:</b> Monday, March 3, 2025 4:48 PM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd=
.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/display: Add a temp w/a for a panel=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This has conflicts to latest asdn and a minor spac=
ing issue below.<br>
<br>
The others look good to me.<br>
<br>
Reviewed-by: Alex Hung &lt;alex.hung@amd.com&gt;<br>
<br>
On 3/3/25 06:50, Aurabindo Pillai wrote:<br>
&gt; Implement w/a for a panel which requires 10s delay after link detect.<=
br>
&gt; <br>
&gt; Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++=
+++++++++++-<br>
&gt;&nbsp;&nbsp; .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 10 ++++++-=
-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/dc_types.h&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; 3 files changed, 32 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 73c95c3c39f9..3a2843e3367e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -3327,6 +3327,21 @@ static void dm_gpureset_commit_state(struct dc_=
state *dc_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static void apply_delay_after_dpcd_poweroff(struct amdgpu_device *ade=
v, struct dc_sink *sink) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dc_panel_patch *ppatch =3D NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!sink)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ppatch =3D &amp;sink-&gt;edid_caps.panel_pat=
ch;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ppatch-&gt;wait_after_dpcd_poweroff_ms) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; msleep(ppatch-&gt;wait_after_dpcd_poweroff_ms);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_dbg_driver(adev_to_drm(adev), &quot;%s: adding a %ds delay as w/a f=
or panel\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __func__,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ppatch-&gt;wait_after_dpcd_poweroff_ms / 1000);<br=
>
This doesn't look aligned to me, and maybe the two line can fit into <br>
one. But this is just my opinions.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; static int dm_resume(struct amdgpu_ip_block *ip_block)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ip_block-&gt;adev;<br>
&gt; @@ -3448,6 +3463,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_=
block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Do detection*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_list_iter_begi=
n(ddev, &amp;iter);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_for_each_connector_iter(=
connector, &amp;iter) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool ret;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (connector-&gt;connector_type =3D=3D DRM_MODE_CONNEC=
TOR_WRITEBACK)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt; @@ -3473,7 +3489,11 @@ static int dm_resume(struct amdgpu_ip_block *ip=
_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; guard(m=
utex)(&amp;dm-&gt;dc_lock);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_exit=
_ips_for_hw_access(dm-&gt;dc);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_link_detect(aconnect=
or-&gt;dc_link, DETECT_REASON_RESUMEFROMS3S4);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D dc_link_detect(=
aconnector-&gt;dc_link, DETECT_REASON_RESUMEFROMS3S4);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* w/a delay for certain panels */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; apply_delay_after_dpcd_poweroff(adev, aconnector-&=
gt;dc_sink);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (aconnector-&gt;fake_enable &amp;&amp; aconnector-&g=
t;dc_link-&gt;local_sink)<br>
&gt; @@ -3834,6 +3854,8 @@ static void handle_hpd_irq_helper(struct amdgpu_=
dm_connector *aconnector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 dc_link_detect(aconnector-&gt;dc_link, DETECT_REASON_HPD);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* w/a delay for certai=
n panels */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; apply_delay_after_dpcd_=
poweroff(adev, aconnector-&gt;dc_sink);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_update_connector_after_detect(aconnector);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_mod=
eset_lock_all(dev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c=
 b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br>
&gt; index fbd80d8545a8..253aac93e3d8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br>
&gt; @@ -55,11 +55,16 @@ static u32 edid_extract_panel_id(struct edid *edid=
)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (u32)EDID_PRODUCT_ID(edid);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps =
*edid_caps)<br>
&gt; +static void apply_edid_quirks(struct drm_device *dev, struct edid *ed=
id, struct dc_edid_caps *edid_caps)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t panel_id =3D edid_e=
xtract_panel_id(edid);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (panel_id) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Workaround for monitors that need a delay=
 after detecting the link */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case drm_edid_encode_panel_id('G', 'B', 'T',=
 0x3215):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_dbg_driver(dev, &quot;Add 10s delay for link detection for panel id=
 %X\n&quot;, panel_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; edid_caps-&gt;panel_patch.wait_after_dpcd_poweroff_ms =3D 10000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaround for some monit=
ors which does not work well with FAMS */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case drm_edid_encode_panel_i=
d('S', 'A', 'M', 0x0E5E):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case drm_edid_encode_panel_i=
d('S', 'A', 'M', 0x7053):<br>
&gt; @@ -101,6 +106,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(<br=
>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *=
aconnector =3D link-&gt;priv;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *connec=
tor =3D &amp;aconnector-&gt;base;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D connector-&gt;dev=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct edid *edid_buf =3D ed=
id ? (struct edid *) edid-&gt;raw_edid : NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cea_sad *sads;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int sad_count =3D -1;<br>
&gt; @@ -130,7 +136,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(<br=
>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; edid_caps-&gt;edid_hdmi =3D =
connector-&gt;display_info.is_hdmi;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; apply_edid_quirks(edid_buf, edid_caps);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; apply_edid_quirks(dev, edid_buf, edid_caps);=
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sad_count =3D drm_edid_to_sa=
d((struct edid *) edid-&gt;raw_edid, &amp;sads);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sad_count &lt;=3D 0)<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/d=
rm/amd/display/dc/dc_types.h<br>
&gt; index e60898c2df01..acd3b373a18e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dc_types.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h<br>
&gt; @@ -181,6 +181,7 @@ struct dc_panel_patch {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t blankstream_before_o=
tg_off;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool oled_optimize_display_o=
n;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int force_mst_block=
ed_discovery;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned int wait_after_dpcd_poweroff_ms;<br=
>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct dc_edid_caps {<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284B9B4406F51D836239EF18BC92CH0PR12MB5284namp_--

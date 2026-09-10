Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5D7C79FB7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 03:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B8910E59F;
	Thu, 10 Sep 2026 03:03:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KphHT3zz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5BE10E848
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 03:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guBjwQHL5Rkj/VoefhnxfuPG6qzXK89y/o5LY9NIZOdoN0C6FtUdHnhXwhchgmGbPvsYl18coROiQdHhz07twGxMQNFvu6sS8lszVLM3QD++Wt5RM70ady/WEMaQJANQVGQmIDVbrtL0yeBxvTWiWDsUDo6AI9Gg7xNV+YIRFJhuwg4uRg0sbljn5Y9AIPMg2QMD2nBU5wYq+HDbGZhEUoIkKDGMn7Q7CC3WUGuT5LwHhVkgoqn+mZkHlV7bIIQAmcXEQilMIgXBibQKRmvsilFXisdgwVXmxm9w94Rldl4vIqnO9V/zK3xdN0Zp2gj1uOCsxwOv14f+UikT3PENSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCKQZ5g8yRcHWI5HxhVuXqKR3UzJtc4V4k+1kvIkng4=;
 b=eWbJzG9NdOH6z7CrGHmm50xYaqsR2lF2S2YsagChEA6cHJpkZOct7YZ63TyM7zIEuVhSVfdadl2ITLY1/W4RL8dAYvjBxiorPebRvy3ONU9sYje94S55Tju252qKLhyjPSI4FnsJ43q2lJaSDAiIwehjwpkztoru9T/0ljffLBZPNtN5GxXylDfWGvASzFFKgy7k5gWWBMRwA7KcUB7rtZa5Jv2qel6cWUhsQPBcCu9A6LptVUBSlzVswRRblvA6tVDEAVJU0pPxrNSoXUEN8GBRZgmFUDDHlXonb5NCqlbFs6E6BN1CK6aw2GJdSSL+0rvw+9M5Cg39niov/Wt7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCKQZ5g8yRcHWI5HxhVuXqKR3UzJtc4V4k+1kvIkng4=;
 b=KphHT3zzoGUWoiivUDTQresyPuihnn20CrjHe2K8xHdEuGgPk5AXWygm5+f1YW8NV6gyfxanw3+mi5zz/weI8wr9aDqrHIJLG2hMsND0fZakGUWWAMEO6XaNDsO2/QtoDFpfyP0fH9wQ+KP97TtzW86m5tGDFsZjAJcDM12v6aw=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Thu, 10 Sep
 2026 03:03:26 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 03:03:26 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v4 1/8] drm/amdgpu/mes_userqueue: refactor mqd_update into
 per-IP helpers
Thread-Topic: [PATCH v4 1/8] drm/amdgpu/mes_userqueue: refactor mqd_update
 into per-IP helpers
Thread-Index: AQHdPmq6uj6FhFpb9kq9wG77NHgLf7bHJPbA
Date: Thu, 10 Sep 2026 03:03:26 +0000
Message-ID: <DM4PR12MB5152CB8875C1CBD74FDFB20FE3BF2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-10T03:03:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB6286:EE_
x-ms-office365-filtering-correlation-id: 3f019809-bbfb-45bd-a565-08df0ee81546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: jGRxXb4Du6tRVEx8kSy/m2UY4omiw1/u1ZwNS8DcCcgPV9aa+F5kTS2vQo2P0vpHzUaObniwymUZlSfrJ6sabzYXPvn6gzhgcCV7/njQGB4ouSlxmbEYgD22ZxZcHbKJCUU49D4Alc8PkmEMXbS99LSD7GyipjVUL0dyKIZShtySQ/rDifvoTFme2tlcLnWDLh03Wl/gmG+lUmP2QWIj/E4f9gD/UHV50bjS1gqNioFRhyXGNlj0kT/FDgSxa8fvqvEzrwZcOALo8YbBbTGy/vg5FBvCXP4TVztdHzQQPiE2DADOdbbGn9+11J3nJ4lWJ4+oZvHmRuojOdSkVz084MJwCv+ondwtm5EJPJCR06tSxWn8PNGz6+BbexrlHNw8XYuRZsvwko5wjnLS4F0N3KQ0J9zsLQXn0YPzHwd0R/+12xxslBwQqEqsdEEZdEIpe3ixCpiVbB3/aMajJt+ath0+AONUcTHML0hU4grIic0WxM/BDo1DbNHCgioDIJjYlNYGChCIJTzXmnF9x3A+sIVk6RrwZ2HPkcYQm0eQKjdwKmDUGu0nFWHGVQCrK6rmMeK6VOauAByM4SUred+wSw6uzSw9CkkJA2k2CemLxNpFEiUW7pMeOvTM49BqXt4+e4KtOEf/MS7NXtMokfPPUCAcpItvm9YWMrf23kSRFKw1ibcTiesW0EoXyLA9UJgqtfh/Tdw2BWM8A0Ek1hEpZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IR+Jgi7NS9rcSqkWnyvxcBuPNiy+sWhOQJMvw1VDrE5KIXlmR5bXFqhi1GEx?=
 =?us-ascii?Q?HrflPBt9BVvFcnymSfpatkmxvFkNQbunSXHyQDBVU2xPlJ4Zdkuy4TCuDIFq?=
 =?us-ascii?Q?itxIY7du/1VPp54wDROWibe2wUWUsdcFjDrRRRH24sfb5rZRGXDZVm+gtSXp?=
 =?us-ascii?Q?2rPjDPkSBO1SUNqEJWLR6XUeHiEQnuaLHwfh/GYr5Xzi4UVJAKToJPO45uyv?=
 =?us-ascii?Q?GwbGVFNvwK7Kb6BZ4rYGiOBcUiQoMSIZYMkUGAjPfvLRHyMg9LYhhDfY747A?=
 =?us-ascii?Q?nb8czEkQRqvx+vkjddAuBiq9VCXFnYMCCl0u50Se9ESnNCHhoFwMQzhQpVI/?=
 =?us-ascii?Q?q/8QHZ8M7HF70XdIXjmoFH1HaO0EfvfZ9MO/tLxQQhIp6p9CWskYHEDDc/GC?=
 =?us-ascii?Q?XVnZY8T4LFTYS1p7IN8IqYTWQR7GVBnvmvb6TkRvlwbqD/SmmawIygsAY9Oy?=
 =?us-ascii?Q?Aovy4o56pHapFlUcytPjTSqO79aZNbFp2gjN3DgZ8cy38KIJ6QeykLOvTtXU?=
 =?us-ascii?Q?YshkOBY9YyOpRpOURlOFoq/8ceBG3KsmzTE7N9uhq9sSkOc682GKyv4JdGuE?=
 =?us-ascii?Q?hFgxTgI3t1Y4jjOnmXkfLY9WaZnTByGLYFR+LV0HLqkp1rEULRmfivnwbNPD?=
 =?us-ascii?Q?HFI8WGbx9qlXiMohigrTKml5b/DT1E8Qe7hlbh6jm/W4eHFfUJSCJRB+otoc?=
 =?us-ascii?Q?QkZcX0hRuF5QBDpTWPU/It6cP2zFIjND7YO5S23BK0nORfc6qkwkZZ7K7gM1?=
 =?us-ascii?Q?fPt3onAYVg2xjMq1jT4lvpse3tHMNMQ0+IUoBw4Zfqg6+mbutMxpYHo6Xr57?=
 =?us-ascii?Q?YWo+QqJLWorVl0KY3udVK3Y5R5/zDjmpHwRrdj/sUqv/YvMJ2mtCEZCahaPt?=
 =?us-ascii?Q?Jycr9JkU4TAjvqar3Qo/yJeR8EbUveLr7QHiJ0ECNI2QYxF3ecx5L1IF4hKr?=
 =?us-ascii?Q?KpesqI6GpizFwh9Ox++DZk1SEWLG721CuttzjEKzEuRy6XMeCADmgpOx/7i3?=
 =?us-ascii?Q?5wt9V+1hOCg9i0rTlBoe6vVJ0voze0dVsC5Vo2vMKZ90mYKCfLMdhGIlfPSg?=
 =?us-ascii?Q?le/nwEsyIwtpPFTiJa9k7+ijbgLgamnoZ5BQBwj5JReg+ngyx4eMq44RRPmg?=
 =?us-ascii?Q?rdyajFl7eRKfm14282dItblIsdW/1wgFox0zk7uym5/XpPhAX0ctMyGgqQD7?=
 =?us-ascii?Q?xu6aM3YWLpaKDIJcmXN1Ey8glu97x/xZjxC9dynLKvuhGj1FTBVYJL9zR3RN?=
 =?us-ascii?Q?42PPQ+QtpAtxu36XcLmPC8gsnEWZrojtT9beUh27E7rTwuIJQEUHQbl5QojD?=
 =?us-ascii?Q?pAwVvBTfnArCAELWVxCIx+CDfSs0RfBSztyLw9VPUZQiSCU2yv2YJiARv56O?=
 =?us-ascii?Q?7v7/Qp/rfbAV0yZsdGvTzhUFEttrRMv5+4N/MurmJ0mCauhQTpPqLCqY42Mz?=
 =?us-ascii?Q?JHavzWegIPKOKcADa+InNlNBSEUw8RPjKHVUyDrsZSnHxiY5/E2i3KQyrVkk?=
 =?us-ascii?Q?DuqRIIB3FKdeLfmMR7ePL0z92OjFDKfsE7/8Yy/xhQG6g3rhb/BhbBqDH2nU?=
 =?us-ascii?Q?9+A/Uj1QrdyTpekFXfMoyV/mP9AVFIplI7R9NK5mCxsopmXBVE2tXuDGjhrc?=
 =?us-ascii?Q?Dn2UoFiDB+ILPL0Sr7fZHgsvpv6adKt1x9+u6Vyu7xabcV6f0a9BM6kh9QGz?=
 =?us-ascii?Q?Ra2WkXKqFhkXtUb72bFo+UyNVdR+oXQWBn2WIejtA9LaekTk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f019809-bbfb-45bd-a565-08df0ee81546
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 03:03:26.1541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdc1m1iqeIoHuoc1Jh21tucr0I7ruXESwPbFNwCYxz0Hx542v+uDkSNQKRO94P3yF9AUXJGLCdwYpkCR5101gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
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

AMD General

Ping ..

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Monday, September 7, 2026 9:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v4 1/8] drm/amdgpu/mes_userqueue: refactor mqd_update int=
o
> per-IP helpers
>
> Split the inlined compute path out of mes_userq_mqd_update() into
> mes_userq_compute_mqd_update() and turn the former into a dispatcher that
> switches on queue_type, giving other IPs an obvious place to hook in.
>
> No functional change.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index ad72ced472dd..82bb4369451e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -681,7 +681,8 @@ static int mes_userq_mqd_create(struct
> amdgpu_usermode_queue *queue,
>       return r;
>  }
>
> -static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, str=
uct
> drm_amdgpu_userq_in *args_in)
> +static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue
> *queue,
> +                                     struct drm_amdgpu_userq_in *args_in=
)
>  {
>       int retval =3D 0;
>       struct amdgpu_device *adev =3D queue->userq_mgr->adev; @@ -689,12
> +690,6 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue
> *queue, struct drm_
>       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue-
> >queue_type];
>       struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd_v11;
>
> -     if (!queue || !userq_props)
> -             return -EINVAL;
> -
> -     if (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE)
> -             return -EINVAL;
> -
>       if (args_in->mqd_size !=3D sizeof(*compute_mqd_v11)) {
>               DRM_ERROR("Invalid compute IP MQD size\n");
>               return -EINVAL;
> @@ -720,6 +715,19 @@ static int mes_userq_mqd_update(struct
> amdgpu_usermode_queue *queue, struct drm_
>       return retval;
>  }
>
> +static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue,
> +struct drm_amdgpu_userq_in *args_in) {
> +     if (!queue || !queue->userq_prop)
> +             return -EINVAL;
> +
> +     switch (queue->queue_type) {
> +     case AMDGPU_HW_IP_COMPUTE:
> +             return mes_userq_compute_mqd_update(queue, args_in);
> +     default:
> +             return -EINVAL;
> +     }
> +}
> +
>  static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)  =
{
>
> --
> 2.49.0


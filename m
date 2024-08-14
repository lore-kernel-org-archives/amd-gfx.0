Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E90C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 15:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAD410E4D0;
	Wed, 14 Aug 2024 15:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m/r1Zu+6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697EB10E4D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 15:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOxmkdSx9Y/gdz/gBxhz/Q2z8caIAc63LlQHGLGnDjZDdq1DP3guxwznWhZoiuom0qimiWRY9/M2jGfeLAjO5Fs97kwfXSIHBQZ6GbMbG/uDrP3RQPs6oydeeJkkIEK2lkWEwkSjv8ZQ3kxo2VSPXuiRC9zX786fE6KkwtunjXhijbS6YkWmuMbdcReF3hPugt0uzFYCw9m7hQg9kGwmO4XyCJpHNZ3q1aM7r4LROFFM5kNo17kIK9IyD4BviyEGzy7xnJQvfWXc0DGrwq+d5o7Au3ycpl1ha7PGoPi15+66LbVdkIgwCB8ZAHlNKCXE6lPwKA8F7cldGSmM0Z9Z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDCwBgZTR6rIa8wl+oVNKC6rp5Mr11UNswyGdCapvjE=;
 b=chhmWiffyhvb82KcJw05hCkQ3khd/7toHbWEujfjC7hwDydCBGY3XOISPv1cGtaNzm2Ppm6xiE4SUO1SpH/qhROo8Agt+taIJYcMl6ow6GPMqZf3ITYmSaOMGCnNRk0E9XDD+kmNdMXcNFdUEgduDRMVDUFb4VViiJkmH/hr+4Jj3mBP6rl0unvoKuDG4n3dXHR2YfNXa4UFjbPfn28Vx9d2eBPKp0zQTLlPp2x4qE2QJPGdncMSCWSZ+6+/oPsSpM1DszDK3hNim712JK5lHGvoht9Z9y0dbkAZtuSK0M/9MKDOZfbUOcyrIKFLEZjUR16Tj8Pt7HF/ray7xsvqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDCwBgZTR6rIa8wl+oVNKC6rp5Mr11UNswyGdCapvjE=;
 b=m/r1Zu+6hOZT9GacINJj9clYug7gWhbMORvJvGaQ1A/1fwp0TqCslWm6Xgnt+4MmClEGz/jAGZKTpXxj+Ibf+WAtP0syNKtMaNZL8rJyhHq6o3TsvvLmFM8e2q3RqVpTjd7dAcwp+DkYAqX6ZBUUgHobd4Kek083AiH49RghIVs=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 15:35:40 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 15:35:40 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/3] drm/amdkfd: Update queue unmap after VM fault with MES
Thread-Topic: [PATCH 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
Thread-Index: AQHa7bKk4GF6wPcwvk28xsWA0a1VGLIm3oaAgAABUNA=
Date: Wed, 14 Aug 2024 15:35:40 +0000
Message-ID: <BL3PR12MB6425BA763BC75491EA95B82DEE872@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240813185713.942012-1-mukul.joshi@amd.com>
 <20240813185713.942012-2-mukul.joshi@amd.com>
 <PH8PR12MB7112017197F70269CF81FF918C872@PH8PR12MB7112.namprd12.prod.outlook.com>
In-Reply-To: <PH8PR12MB7112017197F70269CF81FF918C872@PH8PR12MB7112.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1c54f714-e9ed-4f83-ad69-421fbf10629e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-14T15:08:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SN7PR12MB7956:EE_
x-ms-office365-filtering-correlation-id: c3599c90-fd2b-48dc-d865-08dcbc76c0a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OMO50sICnnGdAhqthaiVXLgcUakBE4C3WiurofVrUDAipN7jbhQXHHdDW6KR?=
 =?us-ascii?Q?od/GXeOWbrG80YcImDJfuLSPIR6Ej9ByxMO0C+HLRVqj/jT2E/MESgy5Vnmn?=
 =?us-ascii?Q?RZ7f3FWndg+aSzIvSut54WQ1xHqLf9SoG90OArZJHn53aV35yhunv0LOgUrC?=
 =?us-ascii?Q?T5PK1ILHmcWCjPfJGVAskPFam69jEMsc5ASvqmiuQE//tOsybZUdOWyqx5lq?=
 =?us-ascii?Q?uACW410f0vu5ixA2W/c1OKHdjZ6oB751vuFZP2QTewC28c5KRzqvOS5Pvd2Z?=
 =?us-ascii?Q?NXexwB1IObcjqoYWtP3YNpwVRgqNeoGH1aksLM5OSGzbHgs5bemFI9vb+IAr?=
 =?us-ascii?Q?AIUMzFGie9CbPCE9Mo5gdxNiiJHYHkrXoRW12zplmZa2Pj9JjETv8+PX9O/E?=
 =?us-ascii?Q?1C4eQBdYTMj+bxkUBJrUHyFXcpWzo69iKxLaNrdxM3Y1+F+nwp28/5nBxGtn?=
 =?us-ascii?Q?Rj9HaueT1VRcITgqGt62NYR/zcogFkTyLSw6jyCUBHUjqmvVCu4n2IP5eGw2?=
 =?us-ascii?Q?+jX23CAVjyDgu7DQDm1XnlH0yzyyNpF+aEJXSSrsV1Cg7ku3tGXlLVhXi0qD?=
 =?us-ascii?Q?/qIuc5iTDFEtY8uunYPrsgdJy93GVR/onjo51iBRc3c5D25guOptBP7x3RGH?=
 =?us-ascii?Q?UZR14M4Z7wxs7PTgEKA5AoYHYlakPmabhqUwYXCxAvRzV3y56uNI3V+UQAaT?=
 =?us-ascii?Q?JHFTLZIXqvQfB0BUMOX98pE5py3FO1SAg1gLa89uMw0NxGSYTyhleBp6klxa?=
 =?us-ascii?Q?SetVtrjbd96UYtlldY9SLgkusaEVrrb+uI8OEJumWxANleZqZ6K93uujXFOX?=
 =?us-ascii?Q?SQrBXQBKs+1hH3rg5+rbeQcMYcI9c6WDotJrvrhSniNHEiJKCPktgKlZChuh?=
 =?us-ascii?Q?flTetpUMFLajNtuan8/PG6KoN7CjlBw8BuKrEquX3Lj3n9rHQQCr23ixOIr6?=
 =?us-ascii?Q?1EtZwWUgrF07kJ6ElgpIOlClcPde7IEDAKE51CGSQhvx+B0t1umCPIurToeW?=
 =?us-ascii?Q?Mx8bXbflGWOy96It68yrDi6YEwBg04uHFI3a/r21X0mnbsMtEHlfJQpu5dht?=
 =?us-ascii?Q?WSAvQtS8iFtXhqI6Ny2rLERXbg32zoAmKWUPhhr9aAOYFUd7mqu5ekeQ1qvD?=
 =?us-ascii?Q?KcByLPVgRozNGGhYZoZbpN5BQFrSljJvdlGG/1Byi8whCxcwpUVTN4Qhs7Sc?=
 =?us-ascii?Q?104RD4oaYtxX8tPtNEvKOkFmuIqt9aklIWz6PMUScHTlCPzpS6S8J/9xAroT?=
 =?us-ascii?Q?Mtr2NF9hYwlj0NGRq/dHaVPMTsnz3/ZemtOwWjnK3yjgPzQK6jnTidnKBKtU?=
 =?us-ascii?Q?nhu25bM2IizmlDmkdWxwwYk38XvkeAkuLYkyriJJQaG+PURF7GjDmf/QeHbC?=
 =?us-ascii?Q?BxIKlKq91earVrryvfycBIiwIbCWd82/CgMJ2iKh/nlLq9ka7A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NIxKhrQOvoQFWd/0dufUUOpiV96uCzjWIgsbizau+YBPh5oPqovOBimCphOc?=
 =?us-ascii?Q?YWForjVG3sBwbJJMwvbQ9DIjfMigwClVK02tfcHAEcX2IU3DrnB14FNiME5x?=
 =?us-ascii?Q?KpNb2WhIRavvCcYE2+LhgvaqU8y8JuJF9TISjDnSFxEmzFcfRLOfGGyXVywx?=
 =?us-ascii?Q?8zN8d9B5iSxP28AD0sIrZQHHtRUNflS1jBGEmSyZn93Ydo9C0i/9KzIgqJ2b?=
 =?us-ascii?Q?CoVd3k8AD8DM/DPCZ4Y9/guTuEHl3mCE/UMrNTm8FuMAQeIp2d6ZOBg2DCnP?=
 =?us-ascii?Q?r+HhK1ciGwOibUFSzRfqFSBdBmAuxiKK/0aoG0Ag3rGQaROOQ3o2ST1xQECs?=
 =?us-ascii?Q?fETzqN9lp8mRfEAaydQENS5VK/2r+WlqLJrr8k1fiIlvI8BwWfCF4CTDrrQL?=
 =?us-ascii?Q?4BVORtVLNkevbPqvQ/bGW4FZVxanpt2Zpq27KKSrQq6XZl5XU5s31MbjL6d7?=
 =?us-ascii?Q?2qpHuUi5F7ruS7Qk2PGjrh2ba/ueLTsBRRKqcD5mHk8YIAlosa81XyHCBQI7?=
 =?us-ascii?Q?iVP051MjJaf4LsNsrB4zagnn/5ji3/BmxgJcndImmUjOuiK5PjiiujrgSeLN?=
 =?us-ascii?Q?YXHTBPTHkhjQ2OKykF7nDzBzSgZpRQPTtJegLCFCYwuRWy7H06oEVyXmqoMQ?=
 =?us-ascii?Q?E00kkAZnywGW9JKV8MlpmK8tQooi1YfoczJj9MA8F8rv4izYE5L8zshnfKMY?=
 =?us-ascii?Q?i3OMoTE50t0bbU9uZD4e5+iBcL1zTbWxdsgFRb8egrwnRj67t01OXTlRiN5k?=
 =?us-ascii?Q?1mG/I7ScmXmAyDAEV5Y/ky2UBWWlllETr+Phoh6tzvnzxemnwz2rYzenSm2v?=
 =?us-ascii?Q?527zYxkbruHigRiFjyNdKVdjA3rxhSl0m+MO1dsYy+p4QqrioVcUgfmlsQ/u?=
 =?us-ascii?Q?hr0NBm4+1NxtluR50DcVSFooRF8J3Hfi3pnnF5M0bO2W4IZhzpMmSZIMC/hm?=
 =?us-ascii?Q?Vb7xIS+j7431x24KHaw9/VNszmlllw8Z3PGmhK0MTCV6GzHvaE2r/JbiYlsX?=
 =?us-ascii?Q?DqFx2ptWHfcQseSicm10XQAPKEyAXs8JV1CSf8ab0H0LpqpCc5RzNlYxKA+n?=
 =?us-ascii?Q?Xc6hux00/HIB1Va5s2RGtzX6uuTm85E0pUBkNj0NywEhZ1odyWfphBHwOc9o?=
 =?us-ascii?Q?qBNnmpMdXdhHbKZEenpR/fEZDWCbODnvyPXLULrg4oZ1qjzrEtRVrhGjpVBw?=
 =?us-ascii?Q?z9aCwReE6eOKxavSTXxf5Qs3CIIenSzya0DfQH68ra6w5NvnW/rOgCjiX1xs?=
 =?us-ascii?Q?FpQIo0LxLybt2mupFvRe/8m3clDLdCqI9eFg4M1rcGijdRRqLQfbmsosZHiv?=
 =?us-ascii?Q?UPH1eCepFRUqYkfRZH+JFoUxiEuDf1XM2eQPXyn3zdiTN4Z9+7MXYV/Jll4H?=
 =?us-ascii?Q?2eBy/DhoVFvf3+XRD3T5l2NJa7zvwnvJIvJGo5YjkoFLk9XtL7Jw2WFExts7?=
 =?us-ascii?Q?6DuLrEk7i3PY7Tpkc9dsjt1nG5NHwoxoNfStdYckJUMW/4bgR+YFEHlJwp5j?=
 =?us-ascii?Q?R3XjFzWGAme1KvZ9duOkcSeqjEozFqmIP5tp524N3HCO1Vtt9jtqKw1sJTbR?=
 =?us-ascii?Q?GNhn7tV4B05zQGUeh4o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3599c90-fd2b-48dc-d865-08dcbc76c0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 15:35:40.3921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HXG0notZqW7KGxh1lzvm2NfLegTrfSUsRX0fgMoILyH/WcF1kuwc9q0BsMcNO1Q/SXWif3hIKCwigtOJr9pkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Wednesday, August 14, 2024 11:17 AM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdkfd: Update queue unmap after VM fault
> with MES
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul
> Joshi
> Sent: Tuesday, August 13, 2024 2:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: [PATCH 2/3] drm/amdkfd: Update queue unmap after VM fault with
> MES
>
> MEC FW expects MES to unmap all queues when a VM fault is observed on a
> queue and then resumed once the affected process is terminated.
> Use the MES Suspend and Resume APIs to achieve this.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 75
> ++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f6e211070299..e16b17e301d9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -319,6 +319,56 @@ static int remove_all_queues_mes(struct
> device_queue_manager *dqm)
>         return retval;
>  }
>
> +static int suspend_all_queues_mes(struct device_queue_manager *dqm) {
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev-
> >adev;
> +       int r;
> +       struct mes_suspend_gang_input queue_input;
> +
> +       if (dqm->is_hws_hang)
> +               return -EIO;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
> +       queue_input.suspend_all_gangs =3D 1;
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +
> +       if (r) {
> +               dev_err(adev->dev, "failed to suspend gangs from MES\n");
> +               dev_err(adev->dev, "MES might be in unrecoverable state, =
issue a
> GPU reset\n");
> +               kfd_hws_hang(dqm);
> +       }
> +
> +       return r;
> +}
> +
> +static int resume_all_queues_mes(struct device_queue_manager *dqm) {
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev-
> >adev;
> +       int r;
> +       struct mes_resume_gang_input queue_input;
> +
> +       if (dqm->is_hws_hang)
> +               return -EIO;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
> +       queue_input.resume_all_gangs =3D 1;
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +
> +       if (r) {
> +               dev_err(adev->dev, "failed to resume gangs from MES\n");
> +               dev_err(adev->dev, "MES might be in unrecoverable state, =
issue a
> GPU reset\n");
> +               kfd_hws_hang(dqm);
> +       }
> +
> +       return r;
> +}
> +
>  static void increment_queue_count(struct device_queue_manager *dqm,
>                                   struct qcm_process_device *qpd,
>                                   struct queue *q) @@ -2839,14 +2889,37 @=
@ int
> kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)  {
>         struct kfd_process_device *pdd;
>         struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
> +       struct device *dev =3D dqm->dev->adev->dev;
>         int ret =3D 0;
>
>         if (!p)
>                 return -EINVAL;
>         WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>         pdd =3D kfd_get_process_device_data(dqm->dev, p);
> -       if (pdd)
> +       if (pdd) {
> +               if (dqm->dev->kfd->shared_resources.enable_mes) {
> +                       ret =3D suspend_all_queues_mes(dqm);
> +                       if (ret) {
> +                               dev_err(dev, "Suspending all queues faile=
d");
> +                               goto out;
> +                       }
> +               }
>                 ret =3D dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> +               if (ret) {
> +                       dev_err(dev, "Evicting process queues failed");
> +                       goto out;
> +               }
> +
> evict_process_queues() function also has if(enable_mes) branching. Would =
it
> make sense to just call two different functions here one for MES and one =
for
> HWS?
>
I think it should be fine to keep it like the way it is. Keeping 2 separate=
 functions one
for MES and other for HWS will probably lead to duplication of the code. We=
 have the
if (enable_mes) branching at a lot of places in the code and it was done ju=
st to avoid
duplication.

> Also, if the process is already evicted then there is no need to do suspe=
nd_all
> and resume_all.
Yes that's a good point. I can put a check to check if the process is alrea=
dy evicted. If it is, then we
avoid the suspend and resume.

Thanks,
Mukul

>
>
> +               if (dqm->dev->kfd->shared_resources.enable_mes) {
> +                       ret =3D resume_all_queues_mes(dqm);
> +                       if (ret) {
> +                               dev_err(dev, "Resuming all queues failed"=
);
> +                               goto out;
> +                       }
> +               }
> +       }
> +
> +out:
>         kfd_unref_process(p);
>
>         return ret;
> --
> 2.35.1
>


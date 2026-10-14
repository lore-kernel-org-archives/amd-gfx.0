Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78343CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 15:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC14610E9BE;
	Wed, 14 Oct 2026 15:00:27 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012051.outbound.protection.outlook.com
 [40.93.195.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1A010E9D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 15:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDHh4T2Nhd30kHphvA0+mx0HRnNcfCmozcO6f+kz6vyx6x/2BGltb0nykoaIStVSFP92cFhp0OC6IbQzMhhXwtob5q+9e39RPGit7s/R6MwKduNM6AhmxHLB0hUBemVrNRzMiMgvpYesDkXr1SVbikFOwoJhXeZxN2IUWpfNli0rY9KwwzthxKMxAcXliMYxusZx028akwzJZ2uvJmjJuPlc1g3BFdzP3iqgmwJkVRtjIwTSqzJ1ctM1Z6NmSwrChAh46KUmgqGJH05Bervj92M/hkw9LrHYovwu2/gdcrvfG4NM/JvCSeUvyplSAzA/PzHHG2ym0RX3Wfwjx7n//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//dvhG1nUfX2rJEsl+EQf0ZKNKwGU2Vj23GiasrnNXg=;
 b=plv5mO1x6qP4+lX+W67svmxdHulttXttG/u8TNzlcHbuCdrPnhxCvBS888o0C8FIv8NhCxz7SvuwWCojr67dtJgfzF5ynYvDFmMbpSIe6SsX0llP2on/rasnSzYwZemQwYFVaONKhd5D+huQhJ1heCBQSIxqsQkUPjxrpBewFGBfPqGdyJ5VRidqXsMiWv3gKQ/oGc/RVqYyqO1FS3k7qHzi8hRtxd8l5/7nMog94QrN84Wwm0KZb0yxtnXeCeAoONmz6eHPIR2KBM2f3zso9oZogj7OkBeP8GjUSmwU73ffCChPb1JxKZX3MqSfelr9weG3o1SQUjK5FDVDKkHHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//dvhG1nUfX2rJEsl+EQf0ZKNKwGU2Vj23GiasrnNXg=;
 b=JahprdPhu0OIp8w8+KHk3VOXymMCDsqHI9H9+7/VEKlq05JbnA1xynbOuQd66s9DZSIkDZdN/fN8Irfurfi5xp5X/VgJLgQ63mM4MafpPIuBRCdlyaAMGWgpwLz5+tfDRSR6jjkpLgpzDvf1vyz8wzKA/wWGl3BmC+BOcE3+GxY=
Received: from SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 by FT1PR12MB804131.namprd12.prod.outlook.com (2603:10b6:170:3b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 15:00:17 +0000
Received: from SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc]) by SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 15:00:15 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 1/2] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Thread-Topic: [PATCH 1/2] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Thread-Index: AQHdSf6ZdvfaGaR6NkKJxGK2d7aOPbb9P6jg
Date: Wed, 14 Oct 2026 15:00:15 +0000
Message-ID: <SA0PR12MB4397565F9FAF09E2FF908AD0959D2@SA0PR12MB4397.namprd12.prod.outlook.com>
References: <20260921192232.665113-1-David.Francis@amd.com>
In-Reply-To: <20260921192232.665113-1-David.Francis@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-14T14:39:31.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4397:EE_|FT1PR12MB804131:EE_
x-ms-office365-filtering-correlation-id: a93a0bf4-db0c-48ac-7e78-08df2a03dae3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|11063799006|260925022911599003|260925021911599003|260925021311599003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: YcNfOTP9nu/vOXBA4eV4IMFBfKh06uLDTXT7Jx/ZZ2UapJfY6rNtDs0SpbCjVy/epCqETNhzGW9JfwwsDR6KKV8+bYv+yL5ZDxV5qITFr4T6oQpo0QyoHE+uvsIJLgMoT4vJ9qsdzBJEYjThiYO/6WWcgn/HQ+yCftJW2DpvEgJVikLA0rftWlC67q60orfnkAr1G+va6Hjd4GNO4cClh5gUAMXYea/YMyxX51QB0CGaPGBPKPRiWLTQTob8PLcyXVOfmjXcUqNaYC1K5gbmd3PaqQN3HE1t6Sj2zYL+OwaVTPt8Z4bqDDkCYDwdZ9SmUs6zgxXER8+cMfiHjYgt17Twin7ItulB/VomuKImHrPKzPdmSD7/49WvvhZI9V/sxUy2+ezfBh2+yeWs4/9+wZZUJMQlgrBZqDQ5Ebm2zSYDay7Q3Nw6GM/cLOCZMAxRt5ch0Y8EDUYDP3rOILFQ/2+1l7IvfotDkzBZA5gl/NSulRsGyvqNRVqfWC+/9dYN41PNEkQfoTesDGhMfELhKmGWyfZt40msmdBycU4ALghIE4eiAyFAZPkOcdXGoX1+5NPSHuyXVyoQPgdCcV0NUcS1eAi4QxrmgIMlmQTZV9Ios+YI/34E2BzrTYP5orYLVQcjSMaGZghcZ+xTJ/NdxnfPZb+8pfG8q0Zojo3vSvMehLjXkczMxg1I/wdqUIGGyI6HFdE9aFMghockmBkyhCKocS4Z9AeEXpHjn+NrhM0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4397.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sHmp3YkJc8z8/58E/+PsBG3dXNRgEIIk1CV8lV6hmENI2+SWUEhAkKuh2zYt?=
 =?us-ascii?Q?8frWM5aZPSZyha3X2LQEgGNtStKkku4gTaI/3h3o7kg7JRVh1KaeIuSV5X9L?=
 =?us-ascii?Q?3Lz0inKkPcZyqYy6muoHaCYI0ByH2APqz/m9v3+g7Sm/gf3E2A/J8xK4hBch?=
 =?us-ascii?Q?J6Ozlav9X16qKEzAgJUVIUd4lCSApdQku9ahJzrCXwZlXuZjiSlwE9OS8RBc?=
 =?us-ascii?Q?MTO+dPUZ+HeGX64CJLtBRf+pCGQROCQ9z0mukq5VBogjgtDUyY9gZnFVzV1U?=
 =?us-ascii?Q?542TRhjwHKyrBndQga+3Wi3yVKMfLuGI0P43J5TNXvzczOoAYJolAmWNFznu?=
 =?us-ascii?Q?OJW5OxB0hZlEx8QT10n9s7Rk6ISO3XITTI+ZvxdpTnm8tPb2/JrjGCqe6d0r?=
 =?us-ascii?Q?l+UpkQtY2r0qhKctAO9PYLkkXhaBLeK31D0LAGvof2/RNkviZAfuZ859okJ7?=
 =?us-ascii?Q?fhpq4JMdU9CZv2PqfoWFj8yNiSxvYFjMP7f44q2yVj2VVc+PEsjOvOCzQZ3j?=
 =?us-ascii?Q?paJMBGkC0iJlnnoj3mZo8zRlElMcteB8K015Ti9GclGN6qZpUSEyJXT498eh?=
 =?us-ascii?Q?IOnElBQBufcpYGXmg6HA4y2NyULIPpUGiX7FbNJpRCc14QrEAuQpo1kc+Kzm?=
 =?us-ascii?Q?rqxCQf1z75tZdJ2kzAe4kIhtKjJF11GUdmG3hygXaBekn/BMaphh4PmBpwU5?=
 =?us-ascii?Q?HmLMlA43fgGVVmILNW+zo71n1lcVBWg6/4WBzmYW3OzeCv12LCB7ViAbc9Kr?=
 =?us-ascii?Q?Jl5O8t8WZctCEmVav5AnDfct3WmxjtZDj9xwZtmfsRq9ghM72Yh2ahHZuoF0?=
 =?us-ascii?Q?qNVAaneltblOUXmohq5mH/T8+Rj5KTW9O1Ty2gWWjVcs/IaVVeoyacK8f0K1?=
 =?us-ascii?Q?ONgtbuNzW36Au4LEAijAkt3rc4ojXIvGVDO/h9T+bkvUdJWnVnaB2XX2Oixb?=
 =?us-ascii?Q?1SisxMa2Q9Sx5KFtjymdjFpsZJwr1QvXUx71jVXCn3tC+rT7EH64hvo04iVg?=
 =?us-ascii?Q?nre3+1FrHeE7ICtFicKmKjjTkvlbG9LJAwODJ1gS3oij86MEovB/ckbtybE1?=
 =?us-ascii?Q?nAgdcHfMyKR1SvigFzcB5MZwjV0RSo6AlMv7kNHVfuK7yau5tudSuJYaK/Rx?=
 =?us-ascii?Q?e7Lxlu3hS7qK+UN/x+q0lKudAhnHrLc2x6Yx2NMKWvppd411E+30CFlL2CKv?=
 =?us-ascii?Q?RbL/NUGG1h1cTk3hYMnOrvhe5QKACYxHy81HY3NBLaHJqEq2yecn2MlKE0SN?=
 =?us-ascii?Q?effkfMdOefwKKew8r/ma26bMfQO1rY5XdF/jNeN6v6UC7gN+JuhorjoOClSy?=
 =?us-ascii?Q?BJ5VI+mQdPqlsPgo+I9hC49/uXvc60umz8nClHje/7hSWTFadVHVaAXbPYbZ?=
 =?us-ascii?Q?7VSZa6aKAhS1ElVNz61TvcP84wZGIiyyOw6lMJPmuH0atiaTtFS89zy9gqwm?=
 =?us-ascii?Q?P+t1HmTv3N9UIJUOP6b6n/7zLwdNFD/1sgqXmVj2brXr7DbG33jQiHTW0mU2?=
 =?us-ascii?Q?THUQf6o4+5zYy9EgLQzSdM2xLrW1zVF4nHbccTtNTr0Mwqd5Tx2ld20uV5TM?=
 =?us-ascii?Q?u8ek0amZN64yWV8WeS+ydZJHhVyZh9lc2WrqsydT7B+qDG5Of+ehRJw8N7f3?=
 =?us-ascii?Q?ijJIFljvTVEWO2izfEG7HV99OL3JlT9eGUr9gEmXrJyBjc+SKQtECDaE5gRG?=
 =?us-ascii?Q?1m0HGVA0y/CBBfyF2GYesDNEvuYOhjAbEW2fz7P3+LQidUMI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4397.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93a0bf4-db0c-48ac-7e78-08df2a03dae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 15:00:15.5100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZRcrJR+beOveUnYM3aeJA3KPb2W2DD+Om3V9+2m+Ns38nNxNdLHTo+Jrthbcnb4kCt0OHGBLOtEHoaZFQFjdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB804131
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

> -----Original Message-----
> From: Francis, David <David.Francis@amd.com>
> Sent: Monday, September 21, 2026 3:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yat Sin, David
> <David.YatSin@amd.com>; Francis, David <David.Francis@amd.com>
> Subject: [PATCH 1/2] drm/amdkfd: Acquire buffers in CRIU queue restore (a=
gain)
>
> CRIU queue restore doesn't acquire the bo buffers in the same way normal =
queue
> creation does, which results in it failing a check in init_user_queue whe=
n its wptr_bo
> is null.
>
> Acquire them, but don't get the svm bo. SVM isn't yet fully restored by t=
his point in
> CRIU and so there's no svm range to get.
> By the time the queue is actually in use the svm range will be there.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 34 ++++++++++++++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  8 ++++-
>  4 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 7fcfc150a7fc..ed6e0f817e7c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -392,7 +392,7 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct
> kfd_process *p,
>               }
>       }
>
> -     err =3D kfd_queue_acquire_buffers(pdd, &q_properties);
> +     err =3D kfd_queue_acquire_buffers(pdd, &q_properties, false);
>       if (err) {
>               pr_debug("failed to acquire user queue buffers\n");
>               goto err_acquire_queue_buf;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d8631847f0eb..59267f8c5840 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1377,7 +1377,7 @@ void print_queue(struct queue *q);  int
> kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdg=
pu_bo
> **pbo,
>                        u64 expected_size);
>  void kfd_queue_buffer_put(struct amdgpu_bo **bo); -int
> kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_pr=
operties
> *properties);
> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct
> +queue_properties *properties, bool is_criu);
>  int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct
> queue_properties *properties);  void kfd_queue_unref_bo_va(struct amdgpu_=
vm
> *vm, struct amdgpu_bo **bo);  int kfd_queue_unref_bo_vas(struct
> kfd_process_device *pdd, diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index a15a826519ad..55569d555758 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -983,8 +983,14 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p=
,  }
>
>  static void set_queue_properties_from_criu(struct queue_properties *qp,
> -                                       struct kfd_criu_queue_priv_data *=
q_data,
> uint32_t num_xcc)
> +                                        struct kfd_criu_queue_priv_data =
*q_data,
> +                                        struct kfd_process_device *pdd)
>  {
> +     struct kfd_topology_device *topo_dev;
> +     uint32_t num_xcc =3D NUM_XCC(pdd->dev->xcc_mask);
> +
> +     topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
> +
>       qp->is_interop =3D false;
>       qp->queue_percent =3D q_data->q_percent;
>       qp->priority =3D q_data->priority;
> @@ -996,10 +1002,14 @@ static void set_queue_properties_from_criu(struct
> queue_properties *qp,
>       qp->eop_ring_buffer_size =3D q_data->eop_ring_buffer_size;
>       qp->ctx_save_restore_area_address =3D q_data-
> >ctx_save_restore_area_address;
>       qp->ctx_save_restore_area_size =3D q_data->ctx_save_restore_area_si=
ze;
> -     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
> -             qp->ctl_stack_size =3D q_data->ctl_stack_size / num_xcc;
> -     else
> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
> +             if (q_data->ctl_stack_size)
> +                     qp->ctl_stack_size =3D q_data->ctl_stack_size / num=
_xcc;
> +             else if (topo_dev)
> +                     qp->ctl_stack_size =3D topo_dev->node_props.ctl_sta=
ck_size;
> +     } else {
>               qp->ctl_stack_size =3D q_data->ctl_stack_size;
> +     }
>
>       qp->type =3D q_data->type;
>       qp->format =3D q_data->format;
> @@ -1078,13 +1088,27 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>       ctl_stack =3D mqd + q_data->mqd_size;
>
>       memset(&qp, 0, sizeof(qp));
> -     set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev-
> >xcc_mask));
> +     set_queue_properties_from_criu(&qp, q_data, pdd);
> +
> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE &&
> !qp.ctl_stack_size) {
> +             pr_err("Failed to determine ctl_stack_size for compute queu=
e\n");
> +             ret =3D -EINVAL;
> +             goto exit;
> +     }
I think that if q_data->ctl_stack_size is zero when kfd_criu_restore_queue =
is called, this should be an error because that means this value was not st=
ored correctly during checkpoint.
So the qp.ctl_stack_size check should be at the beginning of kfd_criu_resto=
re_queue function and do an early exit instead.

Remaining changes look ok.

>
>       print_queue_properties(&qp);
>
> +     ret =3D kfd_queue_acquire_buffers(pdd, &qp, true);
> +     if (ret) {
> +             pr_err("Failed to acquire user queue buffers err:%d\n", ret=
);
> +             goto exit;
> +     }
> +
>       ret =3D pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data,=
 mqd,
> ctl_stack, NULL);
>       if (ret) {
>               pr_err("Failed to create new queue err:%d\n", ret);
> +             kfd_queue_unref_bo_vas(pdd, &qp);
> +             kfd_queue_release_buffers(pdd, &qp);
>               goto exit;
>       }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index ae3e7c54014a..0e8833716381 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -230,7 +230,7 @@ void kfd_queue_buffer_put(struct amdgpu_bo **bo)
>       amdgpu_bo_unref(bo);
>  }
>
> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct
> queue_properties *properties)
> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct
> +queue_properties *properties, bool is_criu)
>  {
>       struct kfd_topology_device *topo_dev;
>       u64 expected_queue_size;
> @@ -325,6 +325,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_dev=
ice
> *pdd, struct queue_prope
>
>       amdgpu_bo_unreserve(vm->root.bo);
>
> +     /* CRIU svm buffers are restored at a later stage than queues. They=
'll be in
> +      * before the queue is actually used, so no risk here
> +      */
> +     if (is_criu)
> +             return 0;
> +
>       err =3D kfd_queue_buffer_svm_get(pdd, properties-
> >ctx_save_restore_area_address,
>                                      total_cwsr_size);
>       if (err)
> --
> 2.34.1


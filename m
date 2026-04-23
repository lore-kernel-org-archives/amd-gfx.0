Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD01F589DC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 13:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC8510F13B;
	Thu, 23 Apr 2026 13:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qm47In4v";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3EF610F13B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 13:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ureXJe29fhZp8QiumxPIGip9/4cRkXAWPceh6/VsbHZicSD7RbFokC3RhMFD4OUzyuj0DQzVGjvgTAkfwPjGZDmizA1DkXqBZwpbHoTWHFnqERuhj5mYwnCtIZ3Ouhz7uSoVSIV0NT4zOby671qCoQtsLRuh8mE/swBRPfk9Z7MbmLOOmlRhGWdbDVxAWasE+JdHXwYigl2u4y4iAWbzrVsHDEfIZaVP30tvP64F0DyBQ+0c9e3bu46IKRyLk3YhHx1c+Mx5AknuBx8lVGVD9gP52uAYMwOelUvKqiFn+UXmYdsWVVcytqBlrex70OeoCK5YTl31jlJhVf33DEivlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc5qP7uv66Zs4B6veuqU8855gHlYp1moWP6Fv6QC2+w=;
 b=YJ3RK3i41QjYiIA3RIizZBq5VTy5hhzlzVvVFYn9sKjLsXsDZtHhLKwZxWNusGXTG1lHNOBG57xyFq6SHwAKEAL+SQiAPkNV5QyQEb1LA//9nsPw5aRD4Lo0J4SDmututtI7tIICVLm98fRdxIHNIK4bMVIxOG9llVKQYTNreAXsPqbGuYliAjcRMBX6AK1AmmykjiJdcLNEPSdiw69+5t9L81ky3QwT/r4N5Dxw4F9psGO83QJqd4SAVklyQVMMkskks0FRxbKrd2IdsoTInHAq1BRQGCJxLd5Jj7YRzV/MzfhtagFtbQOP1QMeiaFdP4VEn6C886NF7vCGnhhD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc5qP7uv66Zs4B6veuqU8855gHlYp1moWP6Fv6QC2+w=;
 b=qm47In4vji2bHdy13xWaZhCTBkBsBCe9jadOoYOdrVHt1Tal3pb/dJ+xRQrGYly8Q4IRhUonlZgwJ89zW7633xfQ3MfZQiPIc6nHekNb3zlo3wfkejVgKHWmz3buDgAeB2fuSWkWALoCucwI55U2yUhkUW5s/qmXgIZuaV7z4Y8=
Received: from CH2PR12MB5019.namprd12.prod.outlook.com (2603:10b6:610:6a::18)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 13:56:58 +0000
Received: from CH2PR12MB5019.namprd12.prod.outlook.com
 ([fe80::7ba0:80d2:e748:6972]) by CH2PR12MB5019.namprd12.prod.outlook.com
 ([fe80::7ba0:80d2:e748:6972%3]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 13:56:58 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <error27@gmail.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Validate CRIU-restored IDs before idr_alloc
Thread-Topic: [PATCH] drm/amdkfd: Validate CRIU-restored IDs before idr_alloc
Thread-Index: AQHc0yICP4mI/az2ZUWVqWVbYCweobXsqvRg
Date: Thu, 23 Apr 2026 13:56:58 +0000
Message-ID: <CH2PR12MB50194D9687C76E909A499189952A2@CH2PR12MB5019.namprd12.prod.outlook.com>
References: <20260423130611.2439580-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260423130611.2439580-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-23T13:53:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB5019:EE_|DS0PR12MB9399:EE_
x-ms-office365-filtering-correlation-id: 7120dacd-3bb0-49ca-9c5b-08dea1402fbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: as2eMzqq9do11tp/CO/GskyL2xKuKNRiA2BzNj1WulaoWcMWu9EGWYsHZRKKwdWON/DwQMrQq1ypMhtqZeJNaBFv977XpbFQ5n0d9BarXtfjLMmSCUx32obekBn8k89ygVDsp1ZL5wJFAzRvIzPRhXhuB1/5SOLlQACCuLv6ac706LSZA9MfED3rcPuUTki9uZqePfs4zEwh1fc3K9T8sBsx6beRMLB6xwZ9GzOoCAllFOHAqk41Pdx9d4MEYWgR3/HtfGalvo6dYIF9IuL1pWDMvl8sjMBTGVfSvfoptmVmrBEB6sP7CPA+PzFws0whphW4vp3V+LjRYLycX/sWQHap76kHH+QeiztZgajCXuii6F6pRjAzBi4ZEDo6SuDZZIiSS8VmxlXTk40evdZwIe0JIOPrB8rWsyDKFwmoHZj2eaedKe1ljHr4CxY8CRLxtzj/6SExKmqf/aXeMQx2bNc0tsMm+pgmFHAWe37Ne+sizM2ogkmljobSqsHLYpiPnOIiOy+oRv3KfJcl3QrjOhSHx5Bxhju+hu7q+PxHiPX4UxudsVbKAPyyMkmgGHkyz+FTgkBK/MiToOkSGVWI4L2f28/mSzdR7g6O8oY4bcmrRtFhkmtLfEK+d9D04GTauS3t3C8acYE57XQYq4XqMEzOBSvjLdcRPnsBQMjZwfCsxte4eSg14vWGElGwcNQiZjHX8XWK3yLccLENsfTSv25km0l2thw0s7qVVqLYsYKBGRH54suOT2vj25kN0HKsIh09fE83Y3hTyc47kk+DMqhfH3FJYg7RjUIi9RRXgzk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5019.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iwvH6rl8PHU9xLTywJxyfYW2IM1w01sHZiNXjQiI8pe0q/iG1iV1DGEIp+Qu?=
 =?us-ascii?Q?e6VjUthV/Yd4CRqNWQ0JgyyHoJ6yZ6Eg2UuRLuGDsfqpnbPi2g5gKfb0Gsne?=
 =?us-ascii?Q?FqdWfmzMORIapBBEUc2jgAUF1rBB5bELwlY9SzgKD4qRKs7ya7yp882EaJ7O?=
 =?us-ascii?Q?6Nt/yUic/CWuTK3NcxXpg1jlVQ4JX/v4w1sklC5/2L8LQsqwsJATS3p1c+YX?=
 =?us-ascii?Q?UZ7lJTHvdRVO+TlffZK5jSFm1qRaGWvwta0VZNvPyTiNlqMb3qN59gwi2XqH?=
 =?us-ascii?Q?yPTgxV96/U5tGmKjqSBGnHxdHFTI4OVZt+PU7Lb33rec7gvp2ofx+XeK7rCE?=
 =?us-ascii?Q?N6p3hRLGLm6QEi6y+CboH2ajDCf1gGIRI0VBnFpn6saZ3ZpKmaafOXUOWAYO?=
 =?us-ascii?Q?906zwEXN5SReITzrXZIcPZVRgWQf2Qaf3yQcF74qgi/NWgs8EZjtTpeIxBSN?=
 =?us-ascii?Q?bANrZTJergiHuAL9zFOSxETSRq/qhd5wvFknKZzE55nxVN0zSPxI7HDsExF5?=
 =?us-ascii?Q?6N3MF15XhvT5OgUp9iM97w+QdoVgFcuB77AND3NCp2NMaK6fdeCdovWnfrCR?=
 =?us-ascii?Q?h3vpw/Tcun1GoJZqyQauy3DbPEBWqndAZ0YDYL8+ujGw42egDW/XnIiZ5gif?=
 =?us-ascii?Q?95GM7U2oU8pzXknUJPK1BE8276nha6sQYJJ3urqxH3AOrLyWWWCwuRwpRnw5?=
 =?us-ascii?Q?Th2Oew/sBYt/BHz/Nrmx+b1IALgPp37Gs1QyZCkWCRw/NjX/6j6m6yKXubro?=
 =?us-ascii?Q?fAPYvAGkUfJTDfc+Z9sS4nZAfA1voGJFFeGIY6NVZl7HFBrTid+4f9ux6RYU?=
 =?us-ascii?Q?gN5TwM0X7ijBD2+3PMDKUT+h77q6C/rtTdz2doaAetlknlZxWpVkWLeGygVC?=
 =?us-ascii?Q?/WBGX72nJUxai0lBaA25pohTeS6h6bMxgmblrxnnW/jRxR1ysReTTP0q7YyL?=
 =?us-ascii?Q?EZ0WnWR8hm2tp8xHjTQxuXo4va5tXimwZziLjwVk71cDMh9qCsmczvRpjny7?=
 =?us-ascii?Q?oEznriwhQwTWbhnq3Z+Rcz92NEDxLJlNNgNjyVfo8PcSoSbdJJLU2OgN0Ed1?=
 =?us-ascii?Q?/tHTLVicfpAk6f0JeQONWpLpmDumqwcL2hMm1jEDrig2U9aSnvhpKV/cw4Sq?=
 =?us-ascii?Q?73Dh7nxdO/CxaF6FoUF234yW+3qTrRJxdGcuFo+WB6+ZojYigu3wQdtne7V9?=
 =?us-ascii?Q?xsWIiVhV8yDSQm3tH77Iq6ETezRy6tnNjDIYrJhbtxLzJKtDu/hJTafAI8Tv?=
 =?us-ascii?Q?aAfDLoOvhTLn1357EK6DdoBmZ5s42izkR+Ceh6NNnNYtuAh3T24WqEnDikZZ?=
 =?us-ascii?Q?WNzRkVsg+CgQ2ED2c9HD79ORubtHcbJb0i2qXIaq7fvcS9mWt4T3pfQSLtpk?=
 =?us-ascii?Q?TNWJwUzdLtz6XUfN33LR5v0w2rBXg2maM8y2si93s61Gr8IfpdsncMKaCOZf?=
 =?us-ascii?Q?aw5GuCHxCm3bRk/2fbtNKSdajKFpbzSB9iHJ1+aHibzBBzEevm7jb+2PBkvU?=
 =?us-ascii?Q?oC5QvaA7qdpzLFd0hNNGfB/IjXIf+TnOj/m4ZowhEbCPNLUZ/fnTq9vT+uJO?=
 =?us-ascii?Q?gQFUWdG8BpUAek8r1QUT4BYVjR75foi4iEpWexfd9uCrom1/cyGfi5IC2plF?=
 =?us-ascii?Q?psJKueNZ9sNaJXDqynII+RNtqrJIaUlGcvN78rpmhBkMIviEqn0riE+7hX/J?=
 =?us-ascii?Q?02ls22oXKIlBslHOr2/hxuFb+rmZGQE97LfiQH/aPvhwn9a/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5019.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7120dacd-3bb0-49ca-9c5b-08dea1402fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 13:56:58.4083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WfmRniE3XhJ5OMkyse0J5blV+o0cI4hrsg1VWy9B2Ak1Bqhut47nak0zk18L1UIouK61SmeY5iNTivvkDVdxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399
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

Thank you Srinivasan.

Reviewed-by: David Yat Sin <david.yatsin@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Thursday, April 23, 2026 9:06 AM
> To: Yat Sin, David <David.YatSin@amd.com>; Bhardwaj, Rajneesh
> <Rajneesh.Bhardwaj@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Dan Carpenter
> <error27@gmail.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: [PATCH] drm/amdkfd: Validate CRIU-restored IDs before idr_alloc
>
> The KFD CRIU restore flow restores previously saved object IDs from users=
pace.
>
> For event restore:
>
>   kfd_criu_restore_event()
>       -> create_signal_event() / create_other_event()
>           -> allocate_event_notification_slot()
>               -> idr_alloc(..., *restore_id, *restore_id + 1, ...)
>
> For BO restore:
>
>   criu_restore_memory_of_gpu()
>       -> idr_alloc(..., bo_priv->idr_handle, ...)
>
> In both cases, the restored ID comes from userspace-provided CRIU data.
>
> idr_alloc() expects the ID range values to fit within signed int limits. =
If a restored ID
> is larger than INT_MAX, it can trigger a WARN in the IDR layer.
>
> A kernel WARN is undesirable because it prints a warning trace and may ca=
use a
> panic or reboot on systems with panic_on_warn enabled.
>
> Smatch reported these paths as allowing unchecked userspace values to rea=
ch
> idr_alloc().
>
> Add INT_MAX validation before using restored IDs in:
>
> - kfd_criu_restore_event()
> - criu_restore_memory_of_gpu()
>
> If the restored ID is invalid, return -EINVAL.
>
> This prevents invalid restore data from reaching the IDR layer and avoids=
 WARN-
> triggering paths, while keeping valid restore behavior unchanged.
>
> Fixes: 40e8a766a761 ("drm/amdkfd: CRIU checkpoint and restore events")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: David Yat Sin <david.yatsin@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
> drivers/gpu/drm/amd/amdkfd/kfd_events.c  | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index ce27a23977d1..880c115dbff7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2433,6 +2433,9 @@ static int criu_restore_memory_of_gpu(struct
> kfd_process_device *pdd,
>       const bool criu_resume =3D true;
>       u64 offset;
>
> +     if (bo_priv->idr_handle > INT_MAX)
> +             return -EINVAL;
> +
>       if (bo_bucket->alloc_flags &
> KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
>               if (bo_bucket->size !=3D
>                               kfd_doorbell_process_slice(pdd->dev->kfd))
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index ee70eb4b6319..e9be798c0a2b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -483,6 +483,11 @@ int kfd_criu_restore_event(struct file *devkfd,
>       }
>       *priv_data_offset +=3D sizeof(*ev_priv);
>
> +     if (ev_priv->event_id > INT_MAX) {
> +             ret =3D -EINVAL;
> +             goto exit;
> +     }
> +
>       if (ev_priv->user_handle) {
>               ret =3D kfd_kmap_event_page(p, ev_priv->user_handle);
>               if (ret)
> --
> 2.34.1


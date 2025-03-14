Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A81C35FF1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 17:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1D610E2D0;
	Fri, 14 Mar 2025 17:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sRlVrnKu";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0385E10E278
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 17:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLWo4whLBDCRnRvFYvdRAR8C5vg9AGkUpJ8yO//O1bu6W0ttwffQBqvdzkUZtc0EN70YXF0Ooi6axEz/cLMldlIA9n8uzOaVDBcxO56qIoejOKUQTqSnxE4hv8Dbv/8uRtHQ5iFG1iJZM2WkFX+rrGJY9KgP+7RNmTpJL2JutXKfKbBmf+bSrUXjvJU6HzuVDke0PSivPXAhYwx2/8Zn9m9JRqf7OfSI/iLObKk1Bda4Q8Qdszwea9q759x9X+P2Jo2h12f9OrGKU5o3zAcPjv2rU9Sw9wZk2eKPRop9DdRK9XkAgiPF2pFTWv6axPCV5/BlrlnUFmNfYEqsUHokpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYH8ReYDIU97q+6Bz99DdOJTG4QGMg6YrNrSax1PKy8=;
 b=bG0u8PASNANeOOiFbNVrWgjfkn+tp3GlJ2BxdRIVoLH5a+TspcPvA4Jl8GpivCWodY7P+sZN18IX9ZTKn1oQWgOVmrWiIgAk3NISYXmyXDUonu3kD6/6SjTzFyTvf4l8La4mEGCu/8xDqDjTmoXDI7I0Du+LPnh6lRNjxWIyZ35sOB5xozHlHdQ1jQaM5AbbUzFlp8GvDLaDxo7ps98JmvFZIszNEdQ5m7qBeK/N/cIZSeOpB8Je0fM8ANBFN85y1goZsja2vQHIHZ4NCVUYyOkD0XDJ3KkNOOupU2qsHsptH0qRuZdzIR9MVPsO0uBaPtUIF60RmNHED8Iwr4C5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYH8ReYDIU97q+6Bz99DdOJTG4QGMg6YrNrSax1PKy8=;
 b=sRlVrnKuY9VrNloDxcDfVAKiyHWi9W16pz1spiQBn5Fs82O4GdnleIsgE8HMV/fba7E1on8/Y41P9WE0gClgZDspznmzvSjgOTjtMlFCiIgYjeq+TxIfcoXbbEpkP5dg7lSmvyXvC+wFk7uoNC5vr8T5yEiQ0LTpLxF2Lb3u3P4=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CH2PR12MB9496.namprd12.prod.outlook.com (2603:10b6:610:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 17:16:30 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 17:16:29 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Thread-Topic: [PATCH] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Thread-Index: AQHblPyPlQg0WUs1/UqZb1hrhpN+Y7Ny287w
Date: Fri, 14 Mar 2025 17:16:29 +0000
Message-ID: <CY8PR12MB7435190969CCA47AD042190F85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250314161654.235110-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250314161654.235110-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=60dffbd9-6bdd-42fc-bb0d-60f4075c4e2d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-14T17:10:34Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CH2PR12MB9496:EE_
x-ms-office365-filtering-correlation-id: 125bedd9-6358-428a-71ed-08dd631bf608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8At8OvTxt3NlG87OY5aX+xNLMO6JVLx7wDjOVC7TE2ueT0Qcf7Ub7bq9jfcr?=
 =?us-ascii?Q?WFkU+ZCjWhLzOH4sLjQJh3NG4pW9Yka4BmegJbeOtmXdzOXA/Qxg7Jq2RNla?=
 =?us-ascii?Q?+eI5E9yyuRxpzZ5TlJRxgDOYiU79g10pVKW2IEqdhlAPr6FGvEzF4+jtdjuF?=
 =?us-ascii?Q?5IPJi07H9/oL1uGhApd5lSkChT8fw/l6Z4fqqp4gxBeOYkO9YG+b0FFFtedr?=
 =?us-ascii?Q?PFn3j64LCO/OAY6ZBeT4NMbjtPHII+eTIlkzs45GMahzW8qxIYEDQeQA6A+0?=
 =?us-ascii?Q?hyzD0ajUCRB7Z4pmKaywCE5y+d6hOLQRUeliAF53D7FyouRgjgDuj0x16Ujh?=
 =?us-ascii?Q?LpVAxSaDNRgLm/8tj34FEuMWhEHFFxJ31vhudF0QzjVN09WfVIKPHNub7OYj?=
 =?us-ascii?Q?IMbnvXEr73/XEZV5idkZg1ByV7iZMapI/p+OnG7oqX9sQwLlTSSYEubJeto7?=
 =?us-ascii?Q?uU70jZlyOc1cGsbUc1hLqiy+zaXag9CVwIUFYfq5Ql4bSzdQTNp4+cfZWu5L?=
 =?us-ascii?Q?rttUPjXF2ZGL+Z0zH+I5CqnSoL/eV+rawUcqSN4CbDaJjYuSrJf9Z9qEvADM?=
 =?us-ascii?Q?CCaAHOLskrFdifK1z6FfdexSx90iWebUyZYXCuTZuXHbWT+sEmh0JIHTiEat?=
 =?us-ascii?Q?AYkWlqzrqWlJhxb+6rrctBmCxuyLlLmXC0qNCIsYXkywXz9KLNE6fgRSTQZ1?=
 =?us-ascii?Q?HvLdHdAjcVj9Q04+sAlHWbwA5nRh238XU25/FNwkLHfBUJrT6hdlwSYvo36C?=
 =?us-ascii?Q?QokZaiHHZKIXdkKue8TcRmnjjYlDY9LkS0nYfLejAS6t4koSsL4XtgTLc5tP?=
 =?us-ascii?Q?RPCeKFKxBkiymnHlDxFfVEKR8Og5B9/KOJiWo60oj0jVR6sEzoYtW53fV52D?=
 =?us-ascii?Q?o/EvDRQ7o/9HN+/832uqCEei2yUbYNVvVcNFUAeLM9fN7bu6spExyiQKD7rU?=
 =?us-ascii?Q?4pRp0TWwL/959O8Njqy30QgtrUGcjXQL5UZJL42KJsPKpBV/bSYVJmK+CBxZ?=
 =?us-ascii?Q?n/eP0P/0zVY78gfWrb2/owzFaweoBgWK9BMlV+6u0dE65N7KWi2D9fqYz7mn?=
 =?us-ascii?Q?r+1UVd6g0lpgRwFhZ6apJuuQNbsY2aRolUN436zliHeeBSpl+Plo9flIvAMW?=
 =?us-ascii?Q?b8YwLJANqJOkdo9mcWFJ+NKGd0PdVnSAeWfwAhT0biAp7sBCs5P9lMqblx/p?=
 =?us-ascii?Q?YFZAnTTYfGSc+JtxD/Ro7nvGm2/YTwDdslvKFPJ6ufwcF4bMWPvvhdxaP8BL?=
 =?us-ascii?Q?NcjiAna9Q9MFT5pyDfBCz/1zlJx5537v/t9ux7ehUE3wlE2Yx/jyGasFNZvF?=
 =?us-ascii?Q?KLivOlndh4Alioet7hTZwKYP5jY28C0dWScAXXavQ1X6YbYc1s4GuWj32i5U?=
 =?us-ascii?Q?l7t/huRCktaHWtRmWBQeSwtBQby3pysfg+KmcLkPXKqvKvhaxS+o/k74cugP?=
 =?us-ascii?Q?66MdEasvx2RHqChKLEZOQdrzc2bM0sR4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H2J9Ntq06bY04N30lwQOiMnOsPC/QkCmdclu8uxPzMiMnnf5PsUND6/yEpHS?=
 =?us-ascii?Q?Wj5rhomPdS6ZHklEF88PUytMCo1MZgetsYxgvytVpHU51M6/wwqpt19LtHQq?=
 =?us-ascii?Q?hrxhyEz4oHLbTtsiosUIQlFJ3PXh/hv3nlu00TfWiUFELVLDLbH6su0/5boa?=
 =?us-ascii?Q?HgrAp+1YljD3ralHsnJNS9yRRT8vY8NswgUDJEAVwRPZLCjZ3HundCx953CW?=
 =?us-ascii?Q?FRzEn42NGdR1tuRu7j78s9W9esS+sBa7mAyzfxFOcO0faf+6iPrylkDfb5jS?=
 =?us-ascii?Q?Uo9awlJ5AzIEn/gw3qy/s7je0YZQC3DV2IPce6g8pQ85EVT+gXoOSjjqgbBH?=
 =?us-ascii?Q?WIVBI5vGGChE58YRCSd/yHX8QfPuW99zAs/xJifWNDk1PWp6Hlrk8hNSw4bm?=
 =?us-ascii?Q?EkNpJR5msghdHI/jNhRnp17WfXjiHeurasoCCSBfzzwb/0USFogXAkOmf3qg?=
 =?us-ascii?Q?MvqaQBpUDnTQWqH8r87xRVmAnduc9j1Pr7AkvJ6QrfKn+31vOXVutFlLbego?=
 =?us-ascii?Q?NR+dXzxBbjpXgzPc037PP6tnCbI7K/MBMnkjgvsNAppz2BOaxDiikGslkP3i?=
 =?us-ascii?Q?PDhMtbGAK4IojIuIpq1P352hI2gdXPI/ygKXF7KLXp5oAwYfnItvECQefsY+?=
 =?us-ascii?Q?U4eso+Wh3H+h1NHImSmCzg8cauecvPmc1MZwTaTgI0/UiB6R1hRWMk2MsSag?=
 =?us-ascii?Q?3ukZ9j8swyEQs4u982SBMoFC97+VARTd57g9rEma2SR0xknBXTJR5olq/V04?=
 =?us-ascii?Q?LsVBwh85/CrQLE8rEs2/VwaVUIP9fG97/lRLicXCD+rcTKsMpwh4PTGYNhya?=
 =?us-ascii?Q?vm+GmZ+x6xdUq3ADwRDvrtVMmAuMuozvZVJV4yvo5MQfxa+8AqSAgtTZuTyz?=
 =?us-ascii?Q?jNMUT9wOBETfAOtoQwGWUfq95oyZxjb9HSjNyeK1tNGVz4Uxk2pmfZJSHEdw?=
 =?us-ascii?Q?6ftfqYV9MSkA2xwj8ZVSCux0EwybElcjxZXHyV+BfvUFmQLTgaE7THJHpiiN?=
 =?us-ascii?Q?pNKHK5o56urAhx7Mp3OCYfPynm0zAeUShSGi7DCWNoQR30qv/SkATD7W45om?=
 =?us-ascii?Q?xwwKWMIkZIWqiuLEplqN16+74j83FPyjmZXMdpBBsgsUBwIfXNM81OIGA6ww?=
 =?us-ascii?Q?xYY4OShLv2w+PEM2Ib7PLQJ0S8i93Nw6XC5sb9ed2xtaD8ySuC2ezLB6NtKg?=
 =?us-ascii?Q?OnO+EmKOXwdmSr7Bfw3Z3fRR94qsZTFHXBw++thi9AuG2yPMaF2KHGaMIAA9?=
 =?us-ascii?Q?t63hgZN3HKuRvcvRwhSviTTY6msCqsqVlHE30hobWDhTr+rTaZY5Eu/f9YjF?=
 =?us-ascii?Q?iiBclsIbZTyR/PwW5ukEAUcJlCXW/Vn2+NZzEfaosl2Y3V1S6zTQ5Qy28OBI?=
 =?us-ascii?Q?dnnlH4MGJPXUJnU1asjB236xtwpI4FirEMlUsbH+os8xWY6AQQB9kL5hK3vF?=
 =?us-ascii?Q?7sKw5zfqPfzlm86wthvom5x5wZ7QgKYrnOKHeanMK03407P7vwZVgcTG8/qw?=
 =?us-ascii?Q?Jcv1tESvHWvzPriyc0CbGSz14IoDRVlgnP54bA6RM2LC7h0ExjfbZBW/qKQF?=
 =?us-ascii?Q?2+F62ggHu/334DHNtjI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125bedd9-6358-428a-71ed-08dd631bf608
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 17:16:29.8974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DxcwF0EXQwtEtKnOsoWaFH1Hio5QQ/fjEHdaCqHjLC52c8Bp9JEBClNhKfKZK+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9496
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
> Kasiviswanathan
> Sent: Friday, March 14, 2025 12:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH] drm/amdkfd: Update return value of config_dequeue_wait_c=
ounts
>
> .config_dequeue_wait_counts returns a nop case. Modify return parameter
> to reflect that since the caller also needs to ignore this condition.
>
> Fixes: <98a5af8103f> ("drm/amdkfd: Add pm_config_dequeue_wait_counts API"=
)
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    | 11 ++++++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c |  9 ++++++++-
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 3f574d82b5fc..47de572741e7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -436,19 +436,24 @@ int pm_config_dequeue_wait_counts(struct
> packet_manager *pm,
>
>               retval =3D pm->pmf->config_dequeue_wait_counts(pm, buffer,
>                                                            cmd, value);
> -             if (!retval)
> +             if (retval > 0) {
>                       retval =3D kq_submit_packet(pm->priv_queue);
> +
> +                     /* If default value is modified, cache that in dqm-=
>wait_times
> */
> +                     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> +                             update_dqm_wait_times(pm->dqm);
> +             }
>               else
>                       kq_rollback_packet(pm->priv_queue);
>       }
>
>       /* If default value is modified, cache that value in dqm->wait_time=
s */
> -     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> +     if (retval > 0 && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
>               update_dqm_wait_times(pm->dqm);

Why are we caching this twice?

>
>  out:
>       mutex_unlock(&pm->lock);
> -     return retval;
> +     return retval < 0 ? retval : 0;
>  }
>
>  int pm_send_unmap_queue(struct packet_manager *pm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index d440df602393..af3a18d81900 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -310,6 +310,13 @@ static inline void
> pm_build_dequeue_wait_counts_packet_info(struct packet_manage
>               reg_data);
>  }
>
> +/* pm_config_dequeue_wait_counts_v9: Builds WRITE_DATA packet with
> + *    register/value for configuring dequeue wait counts
> + *
> + * @return: -ve for failure, 0 for nop and +ve for success and buffer is
> + *  filled in with packet
> + *
> + **/
>  static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
>               uint32_t *buffer,
>               enum kfd_config_dequeue_wait_counts_cmd cmd,
> @@ -377,7 +384,7 @@ static int pm_config_dequeue_wait_counts_v9(struct
> packet_manager *pm,
>
>       packet->data =3D reg_data;
>
> -     return 0;
> +     return sizeof(struct pm4_mec_write_data_mmio);

The return value handling is getting really complicated here.
Either return a unique error to handle NOP or pull some of the IP checker h=
igher to early return sooner.
We're already overloading v9 with other asics so there's no harm in -> if (=
WAIT_INIT && <not optimized ip range check>) return 0 in the abtracted wait=
_counts function that calls this.
You can always set a new dev->has_optimized_wait_count flag in an earlier i=
nit if you don't like defining IP checking there.

Jon

>  }
>
>  static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffe=
r,
> --
> 2.34.1


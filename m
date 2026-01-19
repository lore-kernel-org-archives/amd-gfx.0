Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D26CCF2DD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 19:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAC110E300;
	Mon, 19 Jan 2026 19:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DcAvFVx9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6B110E300
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 19:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj1evscR6LrNA3wJy8LHm0swoyfcePE2akqLYTamljIvBP32qV/NhZrmGDD97M6QWjGzREq04HLM1i3RobH6sYUkngpSLJBSh1ejFC6W8FVjm5XK1lLZdV/cSoTfMn132Jxp18ERrMSn7RDV19abesFulR1dOKutpJcyRdYDXIxnI3DnMphCSQ07XfttAHA9lO742te1xiPNjd6dOG14C+C3IW4EEq0Zbe1E0DFbQnommW8M50qOJlFTZ9fy5iMhJ1TQReHusy7CZWzp4rSwbq6CSca5DjUTgyhZTLv/2jb5FiUBx07TRr80socxft06H/cjsvxcu8VCe9sZjrKGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnC1m04Ez7ZJnD1b6u0zgnc5Orr84KgOqY+iaYuEaAM=;
 b=m/tVSR4svPe8M6JrZFn49x+PbGzmAV9JGForBZhG0uvcGKM8g1pj/RHgi47SngLUuPry4gPVsSLqAB7cb4gShiwy2KfQs7X6pvEApxEI5TLLYZYtv5iHFrnBV7bp1v29jYmMiwKFUj1no+HfIW9I8HD2l+j5pkea2yh2lhrpqxjsFlLDbaRO8eq0SVzVo5UMFyi5UEfnq+PrkyAnGXFFWlB0xLm/HS3qEHrVttakpE/tJY+wVxLMF+42FufkbA4EAQ/kDj2okcR+RRQnpW1/fmnoAC1Is6dFkwZ+InnsPzq45lTHKScCZ5zZszovFNQIsRGLUvR0bF3ovSMFkfTFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnC1m04Ez7ZJnD1b6u0zgnc5Orr84KgOqY+iaYuEaAM=;
 b=DcAvFVx9zsig5oRHsosSKk7+4D7eKsCgbmbAnFCJUHRf0SBelKtD8XhpR0T3lMaHLKg7SjBw+UnSafWg56TgzV483EKTh42KnF6vIM84dKDmJdDl5F0yhBMFi+B2FTfY3avJlVYe/+785gzCMhvvCONuSJZugGTrepMsaj/3VSY=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 19:28:04 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 19:28:03 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Six, Lancelot" <Lancelot.Six@amd.com>
Subject: RE: [PATCH] drm/amdkfd: add mask for debug trap flag setting
Thread-Topic: [PATCH] drm/amdkfd: add mask for debug trap flag setting
Thread-Index: AQHciWcynx9k6MAEbUWQy7iNtI7l5LVZzI2A
Date: Mon, 19 Jan 2026 19:28:03 +0000
Message-ID: <CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20260119171503.624080-1-James.Zhu@amd.com>
In-Reply-To: <20260119171503.624080-1-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-19T18:56:11.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DM4PR12MB6063:EE_
x-ms-office365-filtering-correlation-id: 91e6d58b-b984-4fc1-6723-08de5790dd77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|38070700021|18082099003|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?Gf3fRZ6qpV1khAnt3coEPgyFe7CybQ+jjc3OLxUDzoPsUX5gK6SKM54hIdB9?=
 =?us-ascii?Q?nTf0ZJtvoHSem1ZNQEuXbV9ayRhxyAaxUJa5LdnsiBOdwl7fzqzIHCpeDGGS?=
 =?us-ascii?Q?TejpKCv7jBrBBR3fQVJOSnigjvw/QwwLodqMLcQ8H+DeBGRgHh1W+/G3+RSb?=
 =?us-ascii?Q?lgPadm2Od8IZ4SZ+P7gqLgSK/PnoRIOoscposyVP0ipN5bNjzD97HQwBS1Zz?=
 =?us-ascii?Q?J1U85L1YYFr5xcJjddh/LW6FXaBUy0zyuas6YRaMxqR8uibexN6yK+hPPTlt?=
 =?us-ascii?Q?g44NOIDA8Jyofp201uWPr8En8x1AIHiFcXrmrSkCav9ty6t44P6VpfdUBt3y?=
 =?us-ascii?Q?nG8fFNBZww8KVE0Sc9fPnDGLHA4ZX9rDgOVp0GwO7OlRuvdf127PdfuOf9+s?=
 =?us-ascii?Q?GmvaPgwgQN5txyM7fTj/5RPg/ZKFOGKYmIAmha4+ulMNoaPMArMDubBGRZgY?=
 =?us-ascii?Q?f/yjbJeWzFP1l1GTF94UciK7lGxbAZ5Cbw4Pp6NEcqHTTg4jZxmuGvKUBBMO?=
 =?us-ascii?Q?6qrYcKX0gcz0wkVYIhFfOrDw2u8iYGoStWI1IYzF82SBFzSQBjd1dJpVihFt?=
 =?us-ascii?Q?PkjWk1LPzrOCcvo1L3Egrfxju4+Nkb7CqisRPl4ojGC+PL1JMzA4xLGXjl/A?=
 =?us-ascii?Q?1WNhbPGW/7y+aq8QQW3QaDwnDwR9CsSDZhyHMLInz9rFJukLovrR+1k0PcC8?=
 =?us-ascii?Q?0jmhf6FOLxW+mTfYjVkU/ETY0auQQdkadfZ5d6T5vS3A6zr0vgqNZhckCnSu?=
 =?us-ascii?Q?oz1sCw9sS4GUjAcdVEkWXImZFyUN/2bKxjjNcGZLJ+oFlPZU6kJsInsKWVu/?=
 =?us-ascii?Q?vGwKkqTMI1MV2jaxdODk1aEqj73ZWLYe4AZc8W/1Xr5M/yqY/m1rubLfRMhy?=
 =?us-ascii?Q?1/OTJ43hOYA8rO1vuGCVh4XMqRqxy0gzIMYYsc0eOj8jxunnTvO8ahYxLB8y?=
 =?us-ascii?Q?lmRg6+eSESQYMhK0C7jz7HPr/DDNQ5j/28akPMwtkCX9KmjDcXRb6t3wNt0J?=
 =?us-ascii?Q?YW0/RJsHx9VUFMzSO3zha5Eaec3IwhMvnL2LavgpZfIKS/pY63UwcKCfo71v?=
 =?us-ascii?Q?QojVskRFd+j5WhTQQrF4dhY8omDn2BLbLn29Zff6SNUJ8bV16LvK1PdP1IuB?=
 =?us-ascii?Q?mg203m2YRlv7efCA57UFzPGPdERpMYvdWzd+PsfY++lCk0FGIcCaNeAM047D?=
 =?us-ascii?Q?RE4xVryohcnsoIY7tRGymCH/xeaLMehSknWfUMj0QYeK5XFD1TFJhQUdolWJ?=
 =?us-ascii?Q?bUZfAf5Tu7qbBOZhD88qa24fnXa5tjOwtoBQAqgO0krTe8AJAz6/B3EGyhKo?=
 =?us-ascii?Q?SkiXONE6ds02GcSm7crEnYFznqsMGDqt2mh3e3V3HpCN+dFrfFUCtVX2uHgC?=
 =?us-ascii?Q?2peDyXbWv58w4/BqWn+TttVzHteadJr6NrVdE6+6NL1BLRWomXbKJwZZin0L?=
 =?us-ascii?Q?D06RlNPHFAFy2DGP6nCBZ1MZ35UdDQAQJh24FKIoW5C4Hcxgvz8jjdJR30F/?=
 =?us-ascii?Q?vLe6zrL5lX3SlZoGhLLERlR4Ldd4Sl1srKvkCfI8dSXN0JpQTlpUpErValNZ?=
 =?us-ascii?Q?GNYYWysgS1eBAOR9ebmH57x1AuEARZHcTlrzWjyn5x9S/zuwygY4TvLwDKB7?=
 =?us-ascii?Q?3uRddgQEB1u4XA7FuQ/9zuk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021)(18082099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Ayq7RPZbg/27me/xu7xmBm2H+QmxgdDkWiVWEc9L/dS0Mf7r6uS7lYSwKBw?=
 =?us-ascii?Q?k6lqcLdafL7i6derZlE0T/5pbjr4lGXJkBcR5pSW1cxdPUFHFfl3U+jcV0Kg?=
 =?us-ascii?Q?YwbJDpItEOzhtLoYNTDBfikOfa0ALey2DGeLG6TGfpYuV+YyQJxKEtIkzbP6?=
 =?us-ascii?Q?uIF9zFp5D2uoJmbjZQ8808DmQOa7HY0pUT9B+vT5Iour+UjMb+fZ6DLHpAdN?=
 =?us-ascii?Q?CwBt+12PDwW353oIHeZsirLbM5DPhfVZvzJYsLAdz2so11+AMbUDsDsoypR6?=
 =?us-ascii?Q?Sjg5gSwTnkWHiNRJ09R1WskggoliIzzvRBvfQkrZ4G7cOdzcjPRvfNs88tXF?=
 =?us-ascii?Q?iz0P+fLOGAgFXtiseY0art7+vdUx0tmOG86/+5CnIt4x8PJPNsvJqqFQUDtN?=
 =?us-ascii?Q?mm5lEzuvlCJqc1bl8ZJ/UFLGdx187qINUzubVUTnLwrPcIlkR1jzH7MB1Fz7?=
 =?us-ascii?Q?wcSbac0FtR3w6ykQal8MbCBEVcCrrGPjpMVfMxz6ecPs4s/E0ejeITEuqFsE?=
 =?us-ascii?Q?aiocu/cE7rY6WzgIaYm4UOzwwWs7L/wsn+7Z/ua4YFfgtIPAPiIIJ1gzXwa4?=
 =?us-ascii?Q?l38ypm9V2uIt1t/W2gh4CIt5tPMmT578Jvp/gJMucw7NrtecVJ2zViyriFbB?=
 =?us-ascii?Q?7vbjGRTPwmxel5Tl+2t2HZrz23DyNVQtZbq5Q6z9Z+wIfdwEKj/4fBlhKE8H?=
 =?us-ascii?Q?bTk0Zz66lUXsMo3BhBudMfTZjWRCAne494M6TV6svWyfGe6Mo4vAhCzwUW2+?=
 =?us-ascii?Q?F9ZZxJnRq+T4D7ucoZZySlVSjnm4DMeslLwt0rcOj8vDt4bsZ9tJOhMMjnlL?=
 =?us-ascii?Q?2nJetoAMZtBJKoDNlRBoCfWoeBL13kvsKxLW3FDCEzE0uQp2nafR1m05DpG7?=
 =?us-ascii?Q?ctLlCT3jxAZiAO+LkZzriRfJrsuZGOOmvm9GckSJ9opNvIsZThFD82kItQq8?=
 =?us-ascii?Q?O5wZEhU+XOcbQSqKpq3nqvzeiZf5Hls8tbcGNbEkM41eLjSg1fvLuLVjUo/E?=
 =?us-ascii?Q?RBS8vGCOioCMhnGmnf6QBtczV+lI0vY9dO+CD9uQOCdrp3F8m6JWEqvL0WUO?=
 =?us-ascii?Q?fc2/R4CHwdqqT+fXd3mivFWnjRQCjtwkTaFm2uvGHQXCYE47jX07kzs2Pz2Y?=
 =?us-ascii?Q?5MwZuATxRlsj3i6QdCbH1O2Pf6Qixqdvkfq1cn3PvS4bDCwJb9zelngM8hjx?=
 =?us-ascii?Q?uscI2fGMiFYFqunOlndeNPowkBjcIpC2cfQ02dEN7A/Z84YZeArdIFM0UwoO?=
 =?us-ascii?Q?KzAJLOZ241gxy54u4WJrCQm1RsC9WxbHYdWr5+Luvum6wZch1f74gpxE7Ucr?=
 =?us-ascii?Q?neDHIT0wE0Ply3xodYnU1IkTpOJ5Hg0lGfu+/IZr2vgoC7AB6b9832SVOksv?=
 =?us-ascii?Q?5c3amr/dXqKXr6gVyj0igbbFvTV03P2ALPTE1qKyjI6ifG5F0eHsPhaRSPKg?=
 =?us-ascii?Q?7GWw8KMqCgtmmZw9AMUw2ZmWkj7cWZTApZoCnmN5euMO+E2wAJHpKmk401yy?=
 =?us-ascii?Q?QEVtmirBSOXRrrLSGO4hsSoZiqgRyMm56zskKTTp0nayHngmSEOS6MS4qUDz?=
 =?us-ascii?Q?C2CwPzyEtGvNYTO0WsDtbXrPEnIfqLhKHM2PjIPIrGJ1wk2KamOtCabatxtk?=
 =?us-ascii?Q?DlUmi1AYpadGmcQ+QiaTBI49Y2ss1CYgFG7QGE2MKw1mTvjWBWpf3qQUIlEE?=
 =?us-ascii?Q?u6kzvuD354zdZw/LYxPEaI1/DTiAzeVw7c9GpHJP565ggB6PS62G0ljPb88h?=
 =?us-ascii?Q?8RpG/CSWWMDfE3A5chplISrz7Jg/UNmDwNIfij0ez9/UICiPgKqd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e6d58b-b984-4fc1-6723-08de5790dd77
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 19:28:03.4901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s03G+tGxNE6ThXPrhz/wGqqyKyCVqu3llNZ+PKYPqOir6SUutYRdnh3zgtB3Kcn3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Monday, January 19, 2026 12:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Six, Lancelot <Lancelot.Six@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Zhu, James <James.Zhu@amd.com>
> Subject: [PATCH] drm/amdkfd: add mask for debug trap flag setting
>
> to specify which bits are valid setting on flags.

Can you elaborate?

>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 48 ++++++++++++------------
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  3 +-
>  include/uapi/linux/kfd_ioctl.h           |  3 +-
>  4 files changed, 30 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 79586abad7fd..fd43ef7c9076 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3377,7 +3377,7 @@ static int kfd_ioctl_set_debug_trap(struct file *fi=
lep,
> struct kfd_process *p, v
>                               args->clear_node_address_watch.id);
>               break;
>       case KFD_IOC_DBG_TRAP_SET_FLAGS:
> -             r =3D kfd_dbg_trap_set_flags(target, &args->set_flags.flags=
);
> +             r =3D kfd_dbg_trap_set_flags(target, &args->set_flags);
>               break;
>       case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
>               r =3D kfd_dbg_ev_query_debug_event(target,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index a04875236647..279160ca71a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -512,38 +512,42 @@ static void
> kfd_dbg_clear_process_address_watch(struct kfd_process *target)
>                       kfd_dbg_trap_clear_dev_address_watch(target-
> >pdds[i], j);
>  }
>
> -int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
> +int kfd_dbg_trap_set_flags(struct kfd_process *target,
> +     struct kfd_ioctl_dbg_trap_set_flags_args *set_flags)
>  {
>       uint32_t prev_flags =3D target->dbg_flags;
>       int i, r =3D 0, rewind_count =3D 0;
>
> +     if (!((set_flags->flags ^ prev_flags) & set_flags->mask))

Does this block old debuggers from setting debug mode if pad is 0?

> +             return 0;
> +
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_topology_device *topo_dev =3D
>                               kfd_topology_device_by_id(target->pdds[i]-
> >dev->id);
>               uint32_t caps =3D topo_dev->node_props.capability;
>               uint32_t caps2 =3D topo_dev->node_props.capability2;
> +             struct amdgpu_device *adev =3D target->pdds[i]->dev->adev;
>
> -             if (!(caps &
> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
> -                     (*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
> -                     *flags =3D prev_flags;
> -                     return -EACCES;
> -             }
> -
> -             if (!(caps &
> HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
> -                 (*flags & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) {
> -                     *flags =3D prev_flags;
> -                     return -EACCES;
> -             }
> -
> -             if (!(caps2 &
> HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
> -                 (*flags &
> KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE)) {
> -                     *flags =3D prev_flags;
> +             if (set_flags->mask =3D=3D 0xFFFFFFFF && !set_flags->flags)
> +                     break;

Seems like this is only for a deactivation system call.
Probably don't want to let users abuse this with a magic number then.
Maybe breakout into new static call in deactivation or just device loop dea=
ctivate directly there since this logic is starting to get complicated.

> +             if ((!(caps &
> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
> +                     (set_flags->mask &
> KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) ||
> +                     (!(caps &
> HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
> +                 (set_flags->mask & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP))
> ||
> +                     (!(caps2 &
> HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
> +                 (set_flags->mask &
> KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE))) {

Please vertically indent align "caps" and "set_flags" underneath each other=
 for legibility.

> +                     set_flags->flags =3D prev_flags;
> +                     dev_dbg(adev->dev, "Debug Trap set mask 0x%x caps
> 0x%x caps2 0x%x",
> +                             set_flags->mask, caps, caps2);
>                       return -EACCES;
>               }
>       }
>
> -     target->dbg_flags =3D *flags;
> -     *flags =3D prev_flags;
> +     target->dbg_flags ^=3D (target->dbg_flags ^ set_flags->flags) & set=
_flags-
> >mask;

I assume we can only set/unset 1 flag at a time, which is why this works.
Otherwise, maybe I don't have enough background on this, but please do elab=
orate.

> +     pr_debug("Debug Trap previous flags 0x%x set flags 0x%x set mask 0x=
%x
> target flags 0x%x",
> +             prev_flags, set_flags->flags, set_flags->mask, target-
> >dbg_flags);
> +
> +     set_flags->flags =3D prev_flags;
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D target->pdds[i];
>
> @@ -555,10 +559,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *targe=
t,
> uint32_t *flags)
>               else
>                       r =3D kfd_dbg_set_mes_debug_mode(pdd, true);
>
> -             if (r) {
> -                     target->dbg_flags =3D prev_flags;

Doesn't rewind require the previous value for something to rewind to?

> +             if (r)
>                       break;
> -             }
>
>               rewind_count++;
>       }
> @@ -596,7 +598,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *targ=
et,
> bool unwind, int unwind
>       int i;
>
>       if (!unwind) {
> -             uint32_t flags =3D 0;
> +             struct kfd_ioctl_dbg_trap_set_flags_args set_flags =3D {0,
> 0xFFFFFFFF};

Similar to 3 comments above.  Just call a new static or loop directly to re=
set debug mode (i.e. all flags clear).
i.e. you don't have to rewind on preemption failure here because deactivati=
on itself is a rewind we're pretty much out of luck at this point if we fai=
l.

Jon

>               int resume_count =3D resume_queues(target, 0, NULL);
>
>               if (resume_count)
> @@ -606,7 +608,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *targ=
et,
> bool unwind, int unwind
>               kfd_dbg_clear_process_address_watch(target);
>               kfd_dbg_trap_set_wave_launch_mode(target, 0);
>
> -             kfd_dbg_trap_set_flags(target, &flags);
> +             kfd_dbg_trap_set_flags(target, &set_flags);
>       }
>
>       for (i =3D 0; i < target->n_pdds; i++) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index 894753818cba..34d27eb500a5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -62,7 +62,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct
> kfd_process_device *pdd,
>                                       uint32_t watch_address_mask,
>                                       uint32_t *watch_id,
>                                       uint32_t watch_mode);
> -int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
> +int kfd_dbg_trap_set_flags(struct kfd_process *target,
> +             struct kfd_ioctl_dbg_trap_set_flags_args *set_flags);
>  int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
>               uint32_t source_id,
>               uint32_t exception_code,
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index e9b756ca228c..0522fe7344e4 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1515,6 +1515,7 @@ struct
> kfd_ioctl_dbg_trap_clear_node_address_watch_args {
>   *     Sets flags for wave behaviour.
>   *
>   *     @flags (IN/OUT) - IN =3D flags to enable, OUT =3D flags previousl=
y enabled
> + *     @mask  (IN)     - IN =3D specified debug trap operation bits on f=
lag
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
>   *     Return - 0 on SUCCESS.
> @@ -1522,7 +1523,7 @@ struct
> kfd_ioctl_dbg_trap_clear_node_address_watch_args {
>   */
>  struct kfd_ioctl_dbg_trap_set_flags_args {
>       __u32 flags;
> -     __u32 pad;
> +     __u32 mask;
>  };
>
>  /**
> --
> 2.34.1


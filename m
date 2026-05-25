Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B47CD5BC9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 13:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895D310E114;
	Mon, 25 May 2026 13:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ap7Ei619";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8715110E114;
 Mon, 25 May 2026 13:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oobjw47XRgZQgdjQgflfZcCF2aUm42vOTebkZ0Gj3AQ0SPpclXXmUFMTAJYsRiDPZt68njfA7o1G4PtczN83ljaAuNeGWUdRI8tH3MgTfGSprD7HA0G/P9TPytdJuhqRj617xp+KWKNJJ+RUSTmOdLBMLp++74r8e8bVICGy7HFvGWjVOZhdyRWe/T7LEWLDoEPgz20ywysdy7nGBq7ZoigONlBbzqqfAM5GfaODJk+qmtrERF9lLMH3ukwugtxy4acRFJWpxjjoxo1uwvennfYMwnfCtXpldwQ4sxx63i8q8qQdgFqrrRMXiQ7dbwvKqjwL5WCYhyW24nuqig+sQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra793HBBDO1DF3BKLitKHueq6CxyKxQzooE9zTBV890=;
 b=ZY/qodZ1r1ARaDStawe4vbEeuM705PNRnV3jKn7acV5aTHGrqdb6tx8raMbNSpKZYzcnbxSZNuZxqW46pCYUDznR0RViq1pOrT0T0rZrIHqabwwD4JHyGBuQ+/YraMo+WCfR9hZMK/ofe8Mup4YQOo3mDDJRSojer+IECCXPWu77+CayawO0Y2PxQqp6m43PTEkufU5wh4nX3qqy3DVRF8BnreRiElE2cMrbCm/K9ThHzq2OInx7wDvwzUgiaDY2v9YRIRs70UO7vy6D+jJewqs3hEUSsDLrRZeQF2vzNF6WuQEAY8O+CHRE2UoAP3nQiZd1Zb3JAjzYyK0Nx+6qoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra793HBBDO1DF3BKLitKHueq6CxyKxQzooE9zTBV890=;
 b=Ap7Ei619XX7go9MjMQ4XrWxEPxh2RKZo7EI5DmR7lNRWQusKgRLy+MYDpy150qq9NDUiS1FcBW3/oWDIZtbk09I4f6+Z2zoLs1x/Ess01Ld1Zv5slrvP3Tdt4v7/opb+rnClce7O2KWYJGYRwKE9JErung7BX6xtZPI+SxX+vTg=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by DSVPR12MB999194.namprd12.prod.outlook.com (2603:10b6:8:496::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 25 May
 2026 13:56:15 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:56:14 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Joshua Peisach <jpeisach@ubuntu.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Check bounds in
 allocate_event_notification_slot
Thread-Topic: [PATCH] drm/amdkfd: Check bounds in
 allocate_event_notification_slot
Thread-Index: AQHc6SXOrqLmFOU91EKKWd3V0t1KI7YYevsAgAZO1H8=
Date: Mon, 25 May 2026 13:56:14 +0000
Message-ID: <SA1PR12MB81440D5E84BC4342650FA831EF0A2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260521132854.1016622-1-David.Francis@amd.com>
 <DIOE7AZKC8F4.2NUZMXFHO4L0W@ubuntu.com>
In-Reply-To: <DIOE7AZKC8F4.2NUZMXFHO4L0W@ubuntu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T13:56:14.081Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|DSVPR12MB999194:EE_
x-ms-office365-filtering-correlation-id: 5cf9317b-598d-466b-5bf1-08deba656307
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|38070700021|56012099003|18002099003|4143699003|22082099003;
x-microsoft-antispam-message-info: RomJTxCwWiorhBI1yNGPXEB1OJ/nqb7/NCNKul9Kj4h0paP/bx5NNmsfHVx6BV77GM+JWywzvAlQ9d6PDn8Rx4M31nBCSde7hZUjfDoPb+65mh0l23Ayks2+kxAFtK7+HL5UF433fTFOyhzy0QztU9r5YSexdPJJffG1oJgoLfXv5pOetxJ2LMLRRMjg869qpkxw9aNT3jSt32IleXgwPO1rneLxe8R36lvadkPNUoOZjHhWjlhs62E6OjH8xTv8groaUW+VVKygBif/rNxWwo2ic/zk95kKtY5S/66VOyLOlo6MAYA50UmibcxYWgmYX1Fu7js4+yZ+OBR8IARAhdl8yoD9xicTmGSuYfTW6JGQG7Mmj/D4GQowyTX7YJnwfXLnYt7121XR0wg1JcJWP0vhukdH50kVnzrEmpXv7d4ekK5lzuyV8ScCaIcgI1+BsP+mv+fTAfROHeVSrCz5oj9NhSMxF7an13exWAmdTLbbZXKX52TOFotaEXaIsGi3wJZLCscRUmXf80Zue0mgx9cgqRl8FWcMGJ4hEZEgSjQ1ZSH+YxIpicXEIDmtB7kb/8iY5rM4qXrO7Or2FLSrYvX0QyExdSUNUkw1HHVljyOSiq+7NNROdj8QB4BoqifH5EPIbY2R+rNWHmqYDe6XAeXNtBKXqtE9RMTJgu4yFqQgJTlPGaBzGJbPT8DoSOkA5qIvgyYlke3Sb8dQuDKqy8mlwY337zekdwobug1J67+urhYTQfGWsgHG2Brs4ch5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(38070700021)(56012099003)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M68wLze8270jet7rSbkwmFpWmh1bztFuDL7YfXy9y1JPTvbm/8t8DJ2ShceU?=
 =?us-ascii?Q?kIsQTE2syvWinfro27KL6ygJB/3lWosRal8n6q8LL9tYNCyrzU1VngHhoeLg?=
 =?us-ascii?Q?Q3TU2cv0alioa9fdVa6iolQBhKNR5CEqcjR/XvZimb9ZMbGo9tZPm0+kb7V0?=
 =?us-ascii?Q?Bs/6m1tcGrZpWqMcrcKXJzSyx68I3XZ5E+i4y559F6t8Oa8CYJqOkMnpcWl+?=
 =?us-ascii?Q?ao3byAOU4561gP+NvcS2FabnP+aq94C48HF/JItg9FznHHyidfExZLc8KklB?=
 =?us-ascii?Q?KSBuKZ4sJFAmLrddWB2EC3rDahx2xw+sxEzvgR4fays7Y0lE4YLShyteE1AA?=
 =?us-ascii?Q?KGErfpikFtyCecKDj8JJNJ97h/rVlmYMolvR+Jos7Zwt3VFpvA4ihkIWm4vw?=
 =?us-ascii?Q?zkr1p7uCKjfzMhTqMNhd0pDgPVUimuQAkG+kcr6Jdiehjr9yV8OgAFUSXJhd?=
 =?us-ascii?Q?2XTi0Dsh4AUcrdvmeCB2xhz/4AlYesy8JESvbr0uIeY7j0wNOtJARjNdXQHr?=
 =?us-ascii?Q?RP5WohCWwX7qRvTw4+VlCLhJfpIh6wmCpySKiPIJcMVzKA0MdL4lLfoU38zf?=
 =?us-ascii?Q?bwT2+D9/d8BrRtoh/kVx6Ypxd8s1hlyLIHcyRFQTIRiAtMWlSb1v74cBEEIx?=
 =?us-ascii?Q?UWMH8fgzV8Ib3W+Qx2tUqzBl17+tYzrml74ALyxapYoypMpbDzvAt8c6h/Yh?=
 =?us-ascii?Q?RI+jGWpCozwVlpyq+RyyEAnp3YUlyX0ZGI5CQGjTwh80V+p+y5GaGkAN+5NJ?=
 =?us-ascii?Q?HxlJNDUcKpwMUDKkg+xPbbmIL8cbVKPB+ZP/oh2eA8hMajCYzLRgEdqZb1pH?=
 =?us-ascii?Q?JrmICCw2UPVErsW11Vzy38fr/2xk+QBV0Bo6Ay42OEZ6iodSXmTZcKwxXYBH?=
 =?us-ascii?Q?EtUzi4rdWQxr3FWeaCVlOden6xohl+yIhHrL4f0fygzIdFGjl+YDgKcteK77?=
 =?us-ascii?Q?0Fc2dkwzugc6FuXoEc5WbtwkEUb36ZehirmbmCph6ka6I1synK7utC+JvPPd?=
 =?us-ascii?Q?53ji7Ejnq6qqEO4/R0D9S364GaaVoSAJIxE831EKTaxDhFawUXX4IOVbBLKD?=
 =?us-ascii?Q?0GKPZxpCBIRKVWGspkMEwwyvIatd3M0GxmNTSizXwQDNd4FNqDidbVPpz7O+?=
 =?us-ascii?Q?LKMgYM7tKyZ5v/BH6tGhO2YXHVol2qkoF8cMrgpIBQ46oKKMjVDZFvXn5L+6?=
 =?us-ascii?Q?gOr6bpDNf3EGxuZUJ0Ejj2ePgIWRzevNNBj1u96nivcPOe45VKqR/4CvjLQX?=
 =?us-ascii?Q?+PEgL9x5tQ26PIHuS2n0xb7tBGq7oFd5HNGE9bNrAALZi49RBUWTG/mfW9VV?=
 =?us-ascii?Q?WxL3o4ge7YVcVjvwg9xst8LosPuRrQU9zuA/MIiKDs9KPQMIrBUJZc1HmFvI?=
 =?us-ascii?Q?04iM+2L80/vgEntMbKNRjx5xdb0tOtPOr2N9umtBZadWtU43aTYzybYKhlNl?=
 =?us-ascii?Q?+OytXkrqnrrpll+HF/3QWqdHv4hTkP91z96IsfBj7sRmI5dDGlrJo5jFPY4j?=
 =?us-ascii?Q?81NScjM12vVmIgrSO3F2kG79Vo5/DIclLoGq3gE6HrIOqiZtf9NaQQn47Ied?=
 =?us-ascii?Q?TN7h7mv7LKQrUdogDIXWBB1Ha0N9ldjJC5mpjnXxiB5bYjR2Ktf3INsw+BXS?=
 =?us-ascii?Q?5WLRXfHHFtSjquh8a2SbONoRDmK1rLJ58dTqFh+my+RTaf7NgAmqlJt59W3D?=
 =?us-ascii?Q?1Goo6BAohOVcGspDusVX24KJHe+I4j2mXselVo9hxOr4/gnv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf9317b-598d-466b-5bf1-08deba656307
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 13:56:14.7804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvJXUtk39XH+AIyg9wg5FciSYSWjyjswUhbkis6f0w+dfMirOF/2nKdhx7bAp6K0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999194
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

> This may be a dumb question, but the use of the * means "restore_id" is
> dereferenced. If the conditions are evaluated, either will result in
> restore_id being dereferenced, even if both conditions are false. Then
> can *restore_id still be safely dereferenced in the idr_alloc call?

restore_id is a normal pointer to an int. Dereferencing it should have no s=
ide effects.
So this is perfectly safe

David Francis

________________________________________
From: Joshua Peisach <jpeisach@ubuntu.com>
Sent: Thursday, May 21, 2026 9:35 AM
To: Francis, David; amd-gfx@lists.freedesktop.org
Cc: amd-gfx
Subject: Re: [PATCH] drm/amdkfd: Check bounds in allocate_event_notificatio=
n_slot

On Thu May 21, 2026 at 9:28 AM EDT, David Francis wrote:
> The valid event ids go from 0 to signal_mapped_size / 8
> (usually 256).
>
> allocate_event_notification_slot has an option to specify
> an event id to allocate at, used by CRIU. We weren't checking
> the bounds on that value.
>
> Check them.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_events.c
> index e9be798c0a2b..5a4fe68a7986 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct kf=
d_process *p,
>       }
>
>       if (restore_id) {
> +             if (*restore_id < 0 || *restore_id >=3D p->signal_mapped_si=
ze / 8)
> +                     return -EINVAL;
> +
>               id =3D idr_alloc(&p->event_idr, ev, *restore_id, *restore_i=
d + 1,
>                               GFP_KERNEL);
>       } else {

This may be a dumb question, but the use of the * means "restore_id" is
dereferenced. If the conditions are evaluated, either will result in
restore_id being dereferenced, even if both conditions are false. Then
can *restore_id still be safely dereferenced in the idr_alloc call?

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA40CD5BD0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A698510E6CF;
	Tue, 26 May 2026 14:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mdJv83LF";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD2510E6CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGDnZSIbaHpiwLRN2ForoCKpepfl5dS7WRhhbBOQy+w/QUy3/DJp5T1u/8LxNJ9qIccpy7OalWTh3En+/GpNGCNqd/1eTIC/uh8Uko7khVP8/A0oPJAZyr49kDE5fq4BZWx9RWT0+Bdt4MTp4lmFXi/W0Dy+uFCSShck2EzHHtYebqRFXOhCX7LwXMsTgHIYP6ufoE7rfvLuNhWnqESFF/648VIQJ8w2/nYm2JlKpHaYYDlmma/36m2CzPKHQjGZ8jYIu7tmCh2JFEdBf9FFA9AH7CpqT598xgfQT36ghrgmVxxVgiGlHkexu0YqpIqhHOXpSOEcHf+VUxVwHLgVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tUtcOPPnlZrDK1x2bF05cQBEudGv78DD2HRF0VSzcA=;
 b=RA49QXGV0ho4vkGXTbd+xv4iFR6f6/dHph7AmCBwEU7qHRoyENoTlSeoSZf7Ro642tivGuLvUhSgx0cVMtIa/Wg0rCwC+k3C+jc7FsLIZPheZOC85CRvNZt7NXp56ChqEJhnB25HhWlKP4MOls+kB/TmXnwLseE1kjcTfLlIXcPUgfgOKscJ+2o6z7UKA+MYGbDPWSD/VPFNXwqLDxwmc+AG4w+ly6XqZScvSwkzog8j93w0rksmnS8o/XSoPiiFGjfrhHfi9Xz4wi/eMjtodnHr6InM41C0GKIa3odH7UlO1fFA6asNaXyA3T59vDjFRGlpR9JWtfhj3i/kfvX4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tUtcOPPnlZrDK1x2bF05cQBEudGv78DD2HRF0VSzcA=;
 b=mdJv83LFgw/yF7sfxj2AdmBO0FVvOw24pvuyXkUMrYRVev0F9bcvbL2qKzAMp8OgcsCT1yjsSkkGR3VZpJd/StcD6dWMJQstlaU1sYPECdcfaS1rcr2zI9rE6J2ET3HWkgml4heNyGPzhHgyQqmNwyGgbTScvhlLydmvL4/dbAU=
Received: from CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 14:57:45 +0000
Received: from CY8PR12MB7563.namprd12.prod.outlook.com
 ([fe80::5507:4e0c:e2d0:e6cd]) by CY8PR12MB7563.namprd12.prod.outlook.com
 ([fe80::5507:4e0c:e2d0:e6cd%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 14:57:45 +0000
From: "Clement, Sunday" <Sunday.Clement@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH]  drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EVENTS
Thread-Topic: [PATCH] drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EVENTS
Thread-Index: AQHc55p6Xgu+CUibCUykIrwoZLInuLYgcLnw
Date: Tue, 26 May 2026 14:57:44 +0000
Message-ID: <CY8PR12MB75635951A69497BB2F1869B59F0B2@CY8PR12MB7563.namprd12.prod.outlook.com>
References: <20260519141808.2746913-1-Sunday.Clement@amd.com>
In-Reply-To: <20260519141808.2746913-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-26T14:57:26.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7563:EE_|CH2PR12MB4183:EE_
x-ms-office365-filtering-correlation-id: 4de83deb-ff8c-465a-5075-08debb372534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|6133799003|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: tBj6pCJYZPL0enAUEB5lp5B6CCbmGgOrfjWae9TdEXShQxgMGmbqffndbUXmqzZLfJIPUDOZW2SthhGHDd7EBT0ilY2LQWtdMVyTThpXOBQ8a8VtrD02BP8VTijBrgw/dIeIvdrhGD75alz0UZFhiudpvwCKMoFmhNytwX0otzHzfbQEUUWLRqj4c0CxP5olULDRT6suujl92KkO5doyVP2/wf2hj0sDf+fnz3tOUxfJ0gNDPdWfI7+U7qRKUdoZy6JxCXwUpa18ThDdc9ZcHeHEy4KxExQow8ktg+WNHWxYlUwGdi8NRqWtHp1cE43tVjf0AqyYsD6mtSwgElrQQ3i/DWPKft8zaOJSmGWgblVUng1SpV/jnTXC7n43T0Kk8+gjCdv9+XmmaekO0uU67JIvLzvfWAeWzi/IMtuzcAgLPVoFJRP+ghz2n8CNi0ZJiW3z3C6ZZZZBT4PfaLEDBXtTFRtmA7IgeS9FTTmgJQNqHee3Tb6ZU2gLkJK8b+2BOcgIy+zOztwVKW4dXJTzsnSJBHPeyWUHjJjW1DnDawKtJuSN8c9rvHH6AR2SA3KYpFS++/tcz71WrLYDlOM9c4gYJmbb72AGQd74EtCH9vtUyJ+EGN87pAKmf7hrgEbkAKmsSz0gQbdniALcHbKj+RwidP7iawG+i3eWNw0dzSL8x0JH805sAk8apScvwfJWWjgfj1W6yk/2DtRzcPVP2jPx0HCLJeN9uh6vZ1qgt5VYsM1M0iadqOXl5XR6xiR9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7563.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(6133799003)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BWTzhF0nganEXS3Ruycno7wAUaQoaDUMC1PjhC91PQB/q0pOm1ikQM1OOp0o?=
 =?us-ascii?Q?5wrtc1Su/5Dv5NAndhf7u8Y+PcFxHMSE/WXOIiM712wMp4fah8yvB58S4+gK?=
 =?us-ascii?Q?ih3xRVflJjeLsHtT/ifPUEjhXPD2eJxDTcDJ7gwb0A3hdX+C23T6z6Z9cDEt?=
 =?us-ascii?Q?AGBM5OINU3reoYjnVMEUctcgozTUFts8/almDSYEgVW2x3gaKZ9SfKbO6g2C?=
 =?us-ascii?Q?+Hl5Jmvm/bKg8REYjA28FtdrlDznp55wNn6/3/mhp8KAlI3yIX0ufjIWwDwn?=
 =?us-ascii?Q?xAAuECbI9hiH6eKCvTLx0dIOh4ZtJtzqbApq9qQQLAR33zQk82QJm1ortA8x?=
 =?us-ascii?Q?yAXc7mPlJDsDpLqFKP9byKRSjVg/wKbWIw6i7hP/529WV2m9F68vwvmly127?=
 =?us-ascii?Q?8qa2AFGhHW2LvECk3zwFjSuIPY0yBX9zKnUQzIE+yPRCHOx4zvjmQVPXr9Yh?=
 =?us-ascii?Q?X0c2wUvgib9mXSgPWNsxc6GwsI+BNO1D97aS0lQT5YKkiacznhRlBFwpnepa?=
 =?us-ascii?Q?pQNVqGwxPJDQyM8cnmnmYLzPtF8IcZuOmMfNw9crnYIFeRn7Wi8eI8PjSlXZ?=
 =?us-ascii?Q?H6XE62By1pw4iRgvkg4uWO8U+80Sh3e6j4qDn1/d/cYn+HMLZCeK1ZnDg48P?=
 =?us-ascii?Q?oO57+W6giCccu8DPEak6gDK1PmmFV/w1Xu/EYxKlVrLsWpuu93y1d+oQ3/CC?=
 =?us-ascii?Q?I3eAwCF6nVb+zMYfMPLhNROfLS/iGih+rOL5+dLE9fa5TNRV8pz9IO2qRPVg?=
 =?us-ascii?Q?4ZEd2GHoBnS4cup9wYZzsbvFRceaTZgdjSsPAnxeBeKOe/EyhPpJpshvi6SW?=
 =?us-ascii?Q?RU8dKnZ7TbFMaORQxQk85ClQbSVxhq5ZHfNB58e2/wk5ZQ6Eve9OtAFTA26t?=
 =?us-ascii?Q?iM0+sB6DNsFHC1FKsWZuOv7OvS3BI4znUQrgToTEItjgeexTgH8Tfagt2LTa?=
 =?us-ascii?Q?9ZPY7+P2+vL7LBJzFlS3l6Nb7RlyRn+1G0RGyv5ODt2K4Lfh00EvmQBbBHHx?=
 =?us-ascii?Q?tge+D9COycZYiGpuJC+NvfhWnCs0kFxvDannLYjm3f6GuZQj5ew1LmKwYprV?=
 =?us-ascii?Q?sdF43gqqjtr+ICcu/f5WYrrY+LrKuPzWPjfQ/br+e9i+hL5wZZtRxxfo9Gr0?=
 =?us-ascii?Q?OeHshNoKp/6j5xAKF+8k+ZXDN2W8YU995eYQisY6PQXgx/exvJKPmQbg0qst?=
 =?us-ascii?Q?WwEgqMQrZqPNIsXd2gMUE30fR2HXp331sl1lpoVv7+H/ZqHx6WkuSsKuWPOT?=
 =?us-ascii?Q?2l3ADxD/kF6ezRuixeS1lpK5N4fIN2t/SWnZIBN8QnZUlPzcxX2nSVCRZ1wk?=
 =?us-ascii?Q?ikwt5b3pDor/cEGifjyZ140OBXfI/3jZ93zdo8yN3dv1mKRDOY6y60oKGTWl?=
 =?us-ascii?Q?4eh7qnKLv66ruhEBcejM9qxDXaZQShajcd5G8Uckj3wYLvgmmmhobhpy2j0A?=
 =?us-ascii?Q?a9gmGOYJlSjEKwLOfyVwYFVg78KGYhFB5Xnz1elXbXkEDoKesx2RS82lKWwq?=
 =?us-ascii?Q?vfjAI5649oVd+OWsje3Dx3H4BITNuq3LzEvUHk7ZV2d9zeeHwfCzAc0KC3K3?=
 =?us-ascii?Q?F5NMtY1Zcp1yuSwaXdfV5nXe31qIwwGCT5yKytfW58XDuBDyOQSHunuBkf8r?=
 =?us-ascii?Q?mH8VprwlhQTQV9ZX5aAEe7Lx2hpqe/E5oawET0rJwy5uHMoUepesbsbZ78qL?=
 =?us-ascii?Q?QhBc1ZWrpWpM3aYbkAnNRCfwwgAi7QOyDlZktxZ71TfIKOjg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7563.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de83deb-ff8c-465a-5075-08debb372534
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 14:57:44.2039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8dKkjXafMBfapdGb36JU+cSnBMPyOUHYC9pbsOICUrVr//WGbdpNc+0y5Gdk29AEk/RyTsQJk9jeIPKGpKi+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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

ping

> -----Original Message-----
> From: Clement, Sunday <Sunday.Clement@amd.com>
> Sent: Tuesday, May 19, 2026 10:18 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan,
> Harish <Harish.Kasiviswanathan@amd.com>; Clement, Sunday
> <Sunday.Clement@amd.com>
> Subject: [PATCH] drm/amdkfd: Add bounds check for
> AMDKFD_IOC_WAIT_EVENTS
>
> The kfd_wait_on_events ioctl passes a user-supplied num_events parameter
> directly to alloc_event_waiters() which calls kcalloc() without validatio=
n.
> This allows unprivileged users with /dev/kfd access to trigger large kern=
el
> memory allocations, potentially causing memory exhaustion and denial of
> service via the OOM killer.
>
> Add a check to reject num_events values exceeding
> KFD_SIGNAL_EVENT_LIMIT (4096), which is the maximum number of events a
> single process can create.
>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index e9be798c0a2b..83edc4af77b5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -799,7 +799,8 @@ static struct kfd_event_waiter
> *alloc_event_waiters(uint32_t num_events)  {
>       struct kfd_event_waiter *event_waiters;
>       uint32_t i;
> -
> +     if (num_events > KFD_SIGNAL_EVENT_LIMIT)
> +             return NULL;
>       event_waiters =3D kcalloc(num_events, sizeof(struct kfd_event_waite=
r),
>                               GFP_KERNEL);
>       if (!event_waiters)
> --
> 2.43.0


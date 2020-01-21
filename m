Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8683AC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 14:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2156524653
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 14:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="dVEbgVWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2156524653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F696ED23;
	Tue, 21 Jan 2020 14:32:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10olkn2020.outbound.protection.outlook.com [40.92.42.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FC0F6ED20
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 14:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7HYrbegVOyS6uzcEJ1pGVszMODMA/TX+oxx85AxUzj6Uf9EDcvEa2VMWF0Awg7mMCP+78dsH39pe0OJWJoFlDyj3cRo2sXXysJ0VsO7uPJqIfFW4WqRqqQQvZQMWeVh4+4/X1KW9VpJcT4Tnt+aHUVij8KjrBfoIFbzUtJvlju7cBOtKfygJvmbVa2qhVjY8zmQ6xsNJRQrm4QPh4yBNrONxBabhMBc/rNALsFpu2D2hbe2ofZ3o3vLA5P9y1jG9yNXuhrSOi2v4n7Pr5Eod0Wk3j9V/Eh5fTf+5hjWHQ0RLu4inZbk7w7dPi2T59cPSKP5+qF7tB5uz3VBL5PZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqom0IZa66HiCpyPoMo5Glgv1QsPs+wra6ZZ74nry9I=;
 b=hMEsiwHpP8M+D+QR3i5wz4jwxaIsmrUELElUGAtOv8NMpHuNYp29qHSEVPU6jdLgU+MTxuSmljqQkhbT3WXYDXV6zz3ZjKd6AvjGWMCFtfvpz/TsCFcIjkNEma3ffPVpZMnj3uD6KPTw2p2Z2GSm/gRWXrwbLEY9tm6OX308/Yq1vIvjk9wuUneszP8UOxXV8ZRSQayVLAUeV3ZHBONL7rQuPIVGm1Tc8TqOsNWTWf1yZJ4rC7CPUMpPc0hjPBMwW7acvjbYAzpwOM4/80xxLvjSBYfdKBxynI9djcIqld7QRWRRSmvOE6eSQG8dDFLfk7PeXPyTsYAKQINMjQln2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqom0IZa66HiCpyPoMo5Glgv1QsPs+wra6ZZ74nry9I=;
 b=dVEbgVWeVDLkcuSlUg2yPHdZ75Wo05pICQ5KavcjsdlIGO8kiq8YdBU5WBMS6DHoXrcLOtqZsY4D3Hhz9DAM07cALZiuiC+dnOpdrQ77bCD8WU8M9/MC7m+H4zLLvikTgdwHVLbWln/o+hfapsh9FdlcWniDv9q+IvjkYPb8BUl5k+Hn270U1G9sbGNvb7q5kvQusKtfwFRswpv+HbpApOGgv8TaABd/AOPkS6/7sA67gid4geybgq4OqEo/akAKOEl5acv7pojh2PgQJT3BZ20m+n5L6GnbXNTOaF1p0Eg88ZVXgZsJlbvjs8RUVQj7mEiNtNE92ancTPPFB8yfdw==
Received: from BN7NAM10FT007.eop-nam10.prod.protection.outlook.com
 (10.13.156.58) by BN7NAM10HT077.eop-nam10.prod.protection.outlook.com
 (10.13.157.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Tue, 21 Jan
 2020 14:31:59 +0000
Received: from MW2PR02MB3788.namprd02.prod.outlook.com (10.13.156.60) by
 BN7NAM10FT007.mail.protection.outlook.com (10.13.156.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 14:31:59 +0000
Received: from MW2PR02MB3788.namprd02.prod.outlook.com
 ([fe80::9165:dafc:39fe:6a5c]) by MW2PR02MB3788.namprd02.prod.outlook.com
 ([fe80::9165:dafc:39fe:6a5c%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 14:31:58 +0000
Received: from [50.202.157.72] (50.202.157.72) by
 DM6PR13CA0045.namprd13.prod.outlook.com (2603:10b6:5:134::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.14 via Frontend Transport; Tue, 21 Jan 2020 14:31:57 +0000
From: William Lewis <minutemaidpark@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix doc by clarifying sched_list definition
Thread-Topic: [PATCH] drm/amdgpu: fix doc by clarifying sched_list definition
Thread-Index: AQHVz69y0YuiqEW5LEqzBmciI4de16f1L7EA
Date: Tue, 21 Jan 2020 14:31:58 +0000
Message-ID: <MW2PR02MB3788CAEA2492642D36403656C80D0@MW2PR02MB3788.namprd02.prod.outlook.com>
References: <20200120163536.28801-1-nirmoy.das@amd.com>
In-Reply-To: <20200120163536.28801-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:5:134::22) To MW2PR02MB3788.namprd02.prod.outlook.com
 (2603:10b6:907:a::22)
x-incomingtopheadermarker: OriginalChecksum:D938D6B70F80C467A72FCDC9C55BD459697C6853E39B1AC120B87491368DB16B;
 UpperCasedChecksum:DFC4411005F8E3C392F1C7D975E31C6234B370BCD6E8189D8D76CF5655A0273C;
 SizeAsReceived:7508; Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [gkWMC3OflPTIdnACAG1oZwIs2LADwEIA]
x-microsoft-original-message-id: <d348a953-0213-698e-c074-1fdd05f8c520@hotmail.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 8cc7440e-101d-400a-b4ba-08d79e7eabb9
x-ms-traffictypediagnostic: BN7NAM10HT077:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zYswaefoZ9vQElxN4yvbXuz8xZVIoyyWHd3HswZII11hnWjPG9CfgcouGDklTuqrRlo1940g7ZrSPLbWWDUkeqqw6+B5SSKdx98BC+1YF7WLAj7tPGCqQ9g0IoMjG28BgrlGv9x1821uYMf8kppyn/l59ik00nPWPyAKu+dEkXDDXkQfHXE6jFQvzx0akXpg
x-ms-exchange-transport-forked: True
Content-ID: <094ED4691C2FE44A88E467920EC4FD12@namprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc7440e-101d-400a-b4ba-08d79e7eabb9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 14:31:58.5193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7NAM10HT077
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If we're worrying about spelling and grammar, see one more nitpick inline.

On 1/20/20 10:35 AM, Nirmoy Das wrote:
> expand sched_list definition for better understanding.
> Also fix a typo atleast -> at least
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
>   include/drm/gpu_scheduler.h              | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index ec79e8e5ad3c..63bccd201b97 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -45,7 +45,7 @@
>    * @guilty: atomic_t set to 1 when a job on this queue
>    *          is found to be guilty causing a timeout
>    *
> - * Note: the sched_list should have atleast one element to schedule
> + * Note: the sched_list should have at least one element to schedule
>    *       the entity
>    *
>    * Returns 0 on success or a negative error code on failure.
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 9e71be129c30..9ebba61db177 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -52,8 +52,9 @@ enum drm_sched_priority {
>    * @list: used to append this struct to the list of entities in the
>    *        runqueue.
>    * @rq: runqueue on which this entity is currently scheduled.
> - * @sched_list: a list of drm_gpu_schedulers on which jobs from this entity can
> - *              be scheduled
> + * @sched_list: A list of schedulers (drm_gpu_schedulers).
> + *              Jobs from this entity, can be scheduled on any scheduler

There's no reason to separate the subject from the verb here with a comma.

> + *              on this list.
>    * @num_sched_list: number of drm_gpu_schedulers in the sched_list.
>    * @rq_lock: lock to modify the runqueue to which this entity belongs.
>    * @job_queue: the list of jobs of this entity.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

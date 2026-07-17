Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2596C44507
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 10:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E83210E424;
	Fri, 17 Jul 2026 10:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RB/J9K1e";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A980F10E424
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 10:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v61Yj/B7QHU61fr4wRual0UJ61pZCQ+o6nDnFyMWghY2jabh8BBmGnviIBk5E3U9Gyv4vNf4LRIz5SNLyWWuYgHDLzBPYXN1J6NjbvuOLsqWF3t7S5ecjAideTIkfJprEXr4WD9BWcGnZUQ5Z9/lLZc39+rki6xKT7OsHLDXrRdXse0stxa9k6Rc3ra/VAFr277ig8B+U3ch2Twt1Yk2pUlpX2TkA87SEprzRjuyp+ssIFUWuR1MgdnOUwO9fdMbDb1etRKud2/3vYfZCpK1UsWdF9yjUge/xjXlmxRKpVItidSTl7kZ6148cPQUr70FGWKxIBAvTXHRGPRitaylbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKLkjPmxCN7vIVvEwBETmUBCiloe9GGrm1NAoczwYZk=;
 b=X8pro6nNiC5ywFneTeCVE8Z9/oOeRRyeu+uhgz8wf3xaV8IdHNe2dy6hCI+uxN2RNmlOwou8ctljvdjsccOph9LPmgjCzX1trL62xsvM0mBWe8IRISonu+rAsMG33bvB9R/yVU45zUdPEBg4ElV81/OSwbrJxx0Kq5C7S5fqaL/5PrOk8k27HmO36+nKtmzUUc6uh2ss3b2rNJew/x6gGqSbAIIOZLZPi80ZlKnb5eqZgNeKmbadlyB7rmJ5aUiPpolMwPcBG6ZM7qZf9kF8uuTileapENPJkg9pBZTaDYWpJFrOhnJ4oLKPmIGUvRZGo9G6XStFP9FLfaE1jqBWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKLkjPmxCN7vIVvEwBETmUBCiloe9GGrm1NAoczwYZk=;
 b=RB/J9K1e8vc77dYrEOGFA4nttvsOcEKIY7NJ1fVc8UMUG7mbXoNZ2Di4kthB3sRRn44tj7pbwN9oyp5Vc3RJqFH1ABlFrWbmFmj8M9S0w7OJizhyN6jDO/CM4vwRtMtNMyVWAXoizy5luWTAd9sIcIRDC9/oWo1LjZ7cSdkPvqU=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 10:25:05 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 10:25:05 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
Thread-Topic: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
Thread-Index: AQHdFcno/vE+AMxPbkO89jaTg2SEG7ZxaYuAgAAUMtI=
Date: Fri, 17 Jul 2026 10:25:05 +0000
Message-ID: <SA1PR12MB73439B22EB3FB6CFDCD16438EBC62@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20260715103056.3529178-1-shikang.fan@amd.com>
 <20260717085357.41610-1-shikang.fan@amd.com>
 <da934005-b10b-4e86-b8b0-a910e59b3d66@amd.com>
In-Reply-To: <da934005-b10b-4e86-b8b0-a910e59b3d66@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-17T10:25:04.853Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|SA1PR12MB8643:EE_
x-ms-office365-filtering-correlation-id: 4a46274b-c8c3-4af7-a134-08dee3edab54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|4143699003|8096899003|38070700021|10067099003|11063799006|56012099006|5023799004|6133799003;
x-microsoft-antispam-message-info: tlXJttHLvypZzSBAGhWtuFO1IeM/qjrX3Bn+xUf9NcScNbAK25jW9KZ4RXlIookKxOW+6/7kd1/gi1r2e8pIKfjq3+OfV79Qx28l6c0KvlrGsO4pQaIJINausM7KOwIznCQWj/oETatGOAROPeeHSd7Pm/DG025W2zJe+NggH6x/pzEgQd1j+aKQXc7qbAiqzKsqQULU5IruWCC11sPElJrwppsvVYEQXE5ua3TtI1fb+xeGLt+2M75d3MUbqxW2kFIPR6KFXCRWWIUa5E8L2IFxc6GEnKItfBUnZeU4lKK8mzy+iuyPjNOxCj4b0N70XcvrF8qoN+HUnLl+/cUioQTZEsIY2SdOUs72Xru8vLK9MdVf37kkPumQayHBZoIRToLghJkBrXG9GuvDEdfW7QzDhdlbq0dW3/frhBtupJ0BnnHvcyQkTbQW5KIk0FlxKE/i7l4QQCpsUIIaqufZwWlQymO0o6b/Z9fJLQS1kOeDZinmwmDNYMQAZzbnQrRBMlnwkx1dthb+YinwQq1MILaU3xoPPLdFW/5Zz0g45FFEw6L9gT3OM7HkK3/H0Jmy2GEKj5lKgfI7o0iidCl7THn3dYBthJa4TuiX/tCYbNd7lJoRgNW+P6UO1KwKG/enFlJChu8YtNak4SpJhmpV9zyoEr+kmeZDRUleRg+E5+MYsQVduIUBHWO754wB0FhfGhcc9o/M3LeTCmbsvT0SQLHZQe3MOkq1LWGnTCHi14M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(8096899003)(38070700021)(10067099003)(11063799006)(56012099006)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?rFz3TrkBPH5IggkRHPw60jdyHkEnXvNw21iYNXMDJH4heXVrIPRuQths?=
 =?Windows-1252?Q?rX52RuKaygnbSe94Bds5Obq3hJtsKRTfTE2Vsi4yidHfkf72hGq9aNl3?=
 =?Windows-1252?Q?2k3zXZFg2fPDqmNfRa63yBs+S07AenybRDf5i/TrYvFGlp4WJqhm00At?=
 =?Windows-1252?Q?61qPUhlAk+mPlgSLSfY1jfCPtPLt3po+AKhfruLMpJOprwpn8NqrIsi3?=
 =?Windows-1252?Q?EddQlX3wwuPSW4H9zNJt59zU1ucSXWS4HPbD3kmWR81QZ3TDXbYAjSrc?=
 =?Windows-1252?Q?IcHTQBzikdCPbiC66sfgQTtGttri8dW8fms+O+GPcl385lM0Y3uRjuub?=
 =?Windows-1252?Q?GzleJW+X0Tak2wTYp+e0klwQ1xaFh75LPTFbWyO4uZwEiz/dJ0yf5mbQ?=
 =?Windows-1252?Q?GNvy57I2p1Yp010L5BowPXEAxpNTcuWNlLZu16oqtMcjASwax7YX/4gF?=
 =?Windows-1252?Q?NcASr3ESXy5kZNFCE0wYyl+FSpt8we1Orv3zPUKbytb6bygSkEjA/juw?=
 =?Windows-1252?Q?Uuee60Tv3LS8msZvoGw4PsDogMjenkoYmMsgtwqoWzsATsWgJwlWVAya?=
 =?Windows-1252?Q?Q0qb/7OXL4xFJWMrZwvwh7Rjk6MnOMSF1X4c5VmMY1kAb31fgklfZh+2?=
 =?Windows-1252?Q?P6QAIiA+00AIqXk+xXaKMREag15eIrnbQ1gRLBlT2e4AEkcCe5P4u25w?=
 =?Windows-1252?Q?cOGk1QZ9iFNqSheu+r2ou/2yNJjT33ZR5CDyEQX6fcKgksKTCGne3LW5?=
 =?Windows-1252?Q?dxV43aS6TVLRd16uYdaNWb+8cId8pRv5O7NthIuvJW9eZxuN784TYh0D?=
 =?Windows-1252?Q?0HKWTJ0nxcdBLjXAGWOTOh3BkGsUc0j8ChXUbokliCFLmIC8hP9xNN8R?=
 =?Windows-1252?Q?0AFHpH2+/zs2Cxy7dyU0npVBsJYo3C2gkThyM91Hap3HJeaM+8PqbFot?=
 =?Windows-1252?Q?K2mAXabb05Ld0AoVStTDEn+k/zhgHRcDzefHv0er2gWpujXmZGdhcXR6?=
 =?Windows-1252?Q?N0HMGpH443nX4ITKQCfCLaEAll0Px+Zdqlq5iVTD39l+I+4SnB7l/4Et?=
 =?Windows-1252?Q?DsA58WkJ4U5urMTaeKFv7cvcADyULIcYoIorsuiiM9BTTPO4iIAvbdS8?=
 =?Windows-1252?Q?fP+/oGf4tz8HZXq5idjIJYlCR6tz6bzTdN/PouCpYarEH65VQBkYIgLI?=
 =?Windows-1252?Q?FA596LROgYJPKhnf77ubRDFZgESOZ2Kzi9CENLXPU8rd5XHZTQVd3pjj?=
 =?Windows-1252?Q?1+Fcs89hEoT7Qq2SiWbzNLdAEkIDjVwH4dhrmtqTf73J+YvFdyLm+HVl?=
 =?Windows-1252?Q?5uKny+z46lBrxQoDhHR3ACbM0d7FekyiRQ/bwEEluYn1R9gvKRuHTT6y?=
 =?Windows-1252?Q?lMKoPhEjbxRr/Nw/wtYRC1dKdaQTtxBnBVksqtw+jrLzDxVph6IwW+XT?=
 =?Windows-1252?Q?nZW8ql/gNFxN7qjT2MCI5dFnBoCuWCtZQTqlL7wOJKI9hZnOpIoVIBg0?=
 =?Windows-1252?Q?K7LoGPOk/z6J8gAHZ2lvpNGpRt4ctMe01X+EMtRAe16hDuWlCPNsYtHr?=
 =?Windows-1252?Q?QTSuQKZQH8pkom3MeXwqviS1aqeFDOTHnVTakXXWhcz0Kd3KsAtcX+pb?=
 =?Windows-1252?Q?dXgMe81Mu1zsuslyQpQZTebnpcNlPM/tNroUu3k14Gl2/Tq0RsuprTZC?=
 =?Windows-1252?Q?TtjxKOxnvyvFScBSKdfcRPsZamptyXCtmS0OgxaDdXEHw0Ge7p1Tz18t?=
 =?Windows-1252?Q?QhxCJCMHScDY68uxP5ynsc0cGujHS2WSFmg1O2UueFvPfP+ws+vbK/J1?=
 =?Windows-1252?Q?H/x2igqBLg82N+S3YIipBrmO+pxgNMYFCt0pvep0z50mdQ8t?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB73439B22EB3FB6CFDCD16438EBC62SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a46274b-c8c3-4af7-a134-08dee3edab54
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 10:25:05.3720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2E4ZLUHFD/X8AakvtrZOLEc+OMxM+aMsV1P5+wUny3HBA7mb1nBeTk+PzzJTbJR+GXDYuVKRKJ1N/ZEhdIb+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643
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

--_000_SA1PR12MB73439B22EB3FB6CFDCD16438EBC62SA1PR12MB7343namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

AMD General


I do have a few thoughts on the unpin-repin approach and re-building the MQ=
D from housekeeping information.

For unpin-repin: the MQD's GPU address may change after it's moved back fro=
m GTT, and several places hold the original address, so we'd need to update=
 all of them and be careful not to miss any =97 but overall it's doable.

For re-build: the one thing we can't reconstruct is the control stack. It r=
esides in the same BO as the MQD, and the driver doesn't preserve its conte=
nts.

Separately, I'd like to raise a potential pre-existing issue I noticed whil=
e writing the patch. mqd_on_vram() covers gfx942, gfx943, gfx944 and gfx950=
. gfx943/944/950 are all registered with the _v9_4_3 implementations, which=
 call flush_hdp() in init_mqd, update_mqd and restore_mqd. gfx942, however,=
 uses the base MQD functions, which lack the flush_hdp() call.

Regards,
Shikang

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Friday, July 17, 2026 4:59 PM
To: Fan, Shikang <Shikang.Fan@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM

On 7/17/26 10:53, Shikang Fan wrote:
> On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VRAM
> BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not saved
> across S4 hibernation, so the MQD is garbage on resume and the first
> submission faults. Save it to a system-RAM shadow at suspend and restore
> it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.
>
> v2:
>  - Also snapshot the MQD when a process is already runtime-evicted at
>    hibernation start. The qpd->evicted refcount early-return previously
>    skipped the save loop, losing the MQD across the VRAM wipe (both the
>    cpsch and nocpsch evict paths).
>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   2 +
>  3 files changed, 129 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..d168686ee324 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct device_queue_manager=
 *dqm);
>  static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>                                struct queue *q);
>
> +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q);
> +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q);
> +
>  static inline void deallocate_hqd(struct device_queue_manager *dqm,
>                                struct queue *q);
>  static int allocate_hqd(struct device_queue_manager *dqm, struct queue *=
q);
> @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct device_queue_=
manager *dqm,
>                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>                                        &q->gart_mqd_addr, &q->properties)=
;
>
> +     retval =3D dqm_alloc_mqd_backup(dqm, q);
> +     if (retval)
> +             goto out_free_mqd;
> +
>        if (q->properties.is_active) {
>                if (!dqm->sched_running) {
>                        WARN_ONCE(1, "Load non-HWS mqd while stopped\n");
> @@ -1263,8 +1270,16 @@ static int evict_process_queues_nocpsch(struct dev=
ice_queue_manager *dqm,
>        int retval, ret =3D 0;
>
>        dqm_lock(dqm);
> -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
> +     if (qpd->evicted++ > 0) { /* already evicted, do nothing */
> +             /* A process already runtime-evicted when hibernation start=
s
> +              * skips the save loop below, so snapshot its VRAM MQDs her=
e
> +              * before the S4 image is taken. dqm_save_mqd_backup() is a
> +              * no-op outside S4.
> +              */
> +             list_for_each_entry(q, &qpd->queues_list, list)
> +                     dqm_save_mqd_backup(dqm, q);
>                goto out;
> +     }
>
>        pdd =3D qpd_to_pdd(qpd);
>        pr_debug_ratelimited("Evicting process pid %d queues\n",
> @@ -1297,6 +1312,8 @@ static int evict_process_queues_nocpsch(struct devi=
ce_queue_manager *dqm,
>                         * maintain a consistent eviction state
>                         */
>                        ret =3D retval;
> +
> +             dqm_save_mqd_backup(dqm, q);
>        }
>
>  out:
> @@ -1304,6 +1321,88 @@ static int evict_process_queues_nocpsch(struct dev=
ice_queue_manager *dqm,
>        return ret;
>  }
>
> +/* MQD software-shadow save/restore across S4 hibernation, reusing the C=
RIU
> + * checkpoint_mqd/restore_mqd primitives.
> + */
> +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +     uint32_t mqd_size, ctl_stack_size =3D 0;
> +
> +     if (!mqd_on_vram(dqm->dev->adev))
> +             return 0;
> +     if (q->properties.type !=3D KFD_QUEUE_TYPE_COMPUTE)
> +             return 0;
> +     if (!q->mqd)
> +             return 0;
> +
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
> +     if (!mqd_mgr->checkpoint_mqd || !mqd_mgr->restore_mqd)
> +             return 0;
> +
> +     mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mqd_mgr->mqd_size) *
> +                NUM_XCC(dqm->dev->xcc_mask);
> +     if (mqd_mgr->get_checkpoint_info)
> +             mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, &ctl_stack_si=
ze);
> +
> +     if (!q->mqd_backup) {
> +             q->mqd_backup =3D kzalloc(mqd_size, GFP_KERNEL);

Please note that you need to be super careful when allocating memory during=
 suspend. The amount available is really limited because both swap and OOM =
killer are already stopped.

Instead you should probably consider unpinning on suspend and repinning on =
resume, for this we have memory put asside.

Additional to that it could be that backing up the MQD is overkill, we shou=
ld be able to re-create the MQD after resume from the housekeeping informat=
ion we still have around.

Regards,
Christian.


> +             if (!q->mqd_backup)
> +                     return -ENOMEM;
> +             q->mqd_backup_size =3D mqd_size;
> +     }
> +     if (ctl_stack_size && !q->ctl_stack_backup) {
> +             q->ctl_stack_backup =3D kzalloc(ctl_stack_size, GFP_KERNEL)=
;
> +             if (!q->ctl_stack_backup) {
> +                     kfree(q->mqd_backup);
> +                     q->mqd_backup =3D NULL;
> +                     q->mqd_backup_size =3D 0;
> +                     return -ENOMEM;
> +             }
> +             q->ctl_stack_backup_size =3D ctl_stack_size;
> +     }
> +
> +     return 0;
> +}
> +
> +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +
> +     /* in_s4 is reliably set at evict/suspend time; skip normal runtime=
 eviction
> +      * (pinned VRAM MQD stays intact then).
> +      */
> +     if (!dqm->dev->adev->in_s4)
> +             return;
> +     if (!q->mqd_backup)
> +             return;
> +     if (!q->mqd || !q->mqd_mem_obj || !q->mqd_mem_obj->cpu_ptr)
> +             return;
> +
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
> +     mqd_mgr->checkpoint_mqd(mqd_mgr, q->mqd, q->mqd_backup, q->ctl_stac=
k_backup);
> +     q->mqd_backup_valid =3D true;
> +}
> +
> +static void dqm_restore_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +
> +     if (!q->mqd_backup_valid || !q->mqd_backup)
> +             return;
> +     if (!q->mqd_mem_obj)
> +             return;
> +
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
> +     if (!mqd_mgr->restore_mqd)
> +             return;
> +
> +     mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd=
_addr,
> +                          &q->properties, q->mqd_backup, q->ctl_stack_ba=
ckup,
> +                          q->ctl_stack_backup_size);
> +     q->mqd_backup_valid =3D false;
> +}
> +
>  static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>                                      struct qcm_process_device *qpd)
>  {
> @@ -1313,8 +1412,16 @@ static int evict_process_queues_cpsch(struct devic=
e_queue_manager *dqm,
>        int retval =3D 0;
>
>        dqm_lock(dqm);
> -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
> +     if (qpd->evicted++ > 0) { /* already evicted, do nothing */
> +             /* A process already runtime-evicted when hibernation start=
s
> +              * skips the save loop below, so snapshot its VRAM MQDs her=
e
> +              * before the S4 image is taken. dqm_save_mqd_backup() is a
> +              * no-op outside S4.
> +              */
> +             list_for_each_entry(q, &qpd->queues_list, list)
> +                     dqm_save_mqd_backup(dqm, q);
>                goto out;
> +     }
>
>        pdd =3D qpd_to_pdd(qpd);
>
> @@ -1350,6 +1457,8 @@ static int evict_process_queues_cpsch(struct device=
_queue_manager *dqm,
>                                goto out;
>                        }
>                }
> +
> +             dqm_save_mqd_backup(dqm, q);
>        }
>
>        if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1423,6 +1532,7 @@ static int restore_process_queues_nocpsch(struct de=
vice_queue_manager *dqm,
>
>                mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>                                q->properties.type)];
> +             dqm_restore_mqd_backup(dqm, q);
>                q->properties.is_active =3D true;
>                increment_queue_count(dqm, qpd, q);
>
> @@ -1486,6 +1596,7 @@ static int restore_process_queues_cpsch(struct devi=
ce_queue_manager *dqm,
>                if (!QUEUE_IS_ACTIVE(q->properties))
>                        continue;
>
> +             dqm_restore_mqd_backup(dqm, q);

Those are the wrong point to call those functions if I'm not completely mis=
taken.

Regards,
Christian.

>                q->properties.is_active =3D true;
>                increment_queue_count(dqm, &pdd->qpd, q);
>
> @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct device_queue_=
manager *dqm, struct queue *q,
>                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>                                        &q->gart_mqd_addr, &q->properties)=
;
>
> +     retval =3D dqm_alloc_mqd_backup(dqm, q);
> +     if (retval)
> +             goto out_free_mqd;
> +
>        list_add(&q->list, &qpd->queues_list);
>        qpd->queue_count++;
>
> @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct device_queue_m=
anager *dqm, struct queue *q,
>        list_del(&q->list);
>        if (q->properties.is_active)
>                decrement_queue_count(dqm, qpd, q);
> +out_free_mqd:
>        mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>        dqm_unlock(dqm);
>  out_deallocate_doorbell:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 88191a4c1657..1f728f13813e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -637,6 +637,15 @@ struct queue {
>        void *gang_ctx_cpu_ptr;
>
>        struct amdgpu_bo *wptr_bo_gart;
> +
> +     /* system-RAM shadow of a VRAM-resident MQD (+ control stack)
> +      * for hibernation snapshot/restore
> +      */
> +     void *mqd_backup;
> +     void *ctl_stack_backup;
> +     uint32_t mqd_backup_size;
> +     uint32_t ctl_stack_backup_size;
> +     bool mqd_backup_valid;
>  };
>
>  enum KFD_MQD_TYPE {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
> index 98a5512b701b..cbc90bf87792 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct queue_pro=
perties *properties)
>
>  void uninit_queue(struct queue *q)
>  {
> +     kfree(q->mqd_backup);
> +     kfree(q->ctl_stack_backup);
>        kfree(q);
>  }
>


--_000_SA1PR12MB73439B22EB3FB6CFDCD16438EBC62SA1PR12MB7343namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I do have a few thoughts on the unpin-repin approach and re-building the MQ=
D from housekeeping information.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
For unpin-repin: the MQD's GPU address may change after it's moved back fro=
m GTT, and several places hold the original address, so we'd need to update=
 all of them and be careful not to miss any =97 but overall it's doable.</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
For re-build: the one thing we can't reconstruct is the control stack. It r=
esides in the same BO as the MQD, and the driver doesn't preserve its conte=
nts.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Separately, I'd like to raise a potential pre-existing issue I noticed whil=
e writing the patch. mqd_on_vram() covers gfx942, gfx943, gfx944 and gfx950=
. gfx943/944/950 are all registered with the _v9_4_3 implementations, which=
 call flush_hdp() in init_mqd, update_mqd
 and restore_mqd. gfx942, however, uses the base MQD functions, which lack =
the flush_hdp() call.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Friday, July 17, 2026 4:59 PM<br>
<b>To:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&=
gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On 7/17/26 10:53, Shikang Fan wrote:<br>
&gt; On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VR=
AM<br>
&gt; BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not sav=
ed<br>
&gt; across S4 hibernation, so the MQD is garbage on resume and the first<b=
r>
&gt; submission faults. Save it to a system-RAM shadow at suspend and resto=
re<br>
&gt; it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.<=
br>
&gt;<br>
&gt; v2:<br>
&gt;&nbsp; - Also snapshot the MQD when a process is already runtime-evicte=
d at<br>
&gt;&nbsp;&nbsp;&nbsp; hibernation start. The qpd-&gt;evicted refcount earl=
y-return previously<br>
&gt;&nbsp;&nbsp;&nbsp; skipped the save loop, losing the MQD across the VRA=
M wipe (both the<br>
&gt;&nbsp;&nbsp;&nbsp; cpsch and nocpsch evict paths).<br>
&gt;<br>
&gt; Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120 ++++++++++++=
+++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 ++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_queue.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&gt;&nbsp; 3 files changed, 129 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index 51ee9c39104b..d168686ee324 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct device_queue_mana=
ger *dqm);<br>
&gt;&nbsp; static void deallocate_sdma_queue(struct device_queue_manager *d=
qm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
&gt;&nbsp;<br>
&gt; +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q);<br>
&gt; +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q);<br>
&gt; +<br>
&gt;&nbsp; static inline void deallocate_hqd(struct device_queue_manager *d=
qm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
&gt;&nbsp; static int allocate_hqd(struct device_queue_manager *dqm, struct=
 queue *q);<br>
&gt; @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct device_que=
ue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr, &amp;q-&gt;mqd, q-&gt;mqd=
_mem_obj,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval =3D dqm_alloc_mqd_backup(dqm, q);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto out_free_mqd;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_acti=
ve) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;sched_running) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON=
CE(1, &quot;Load non-HWS mqd while stopped\n&quot;);<br>
&gt; @@ -1263,8 +1270,16 @@ static int evict_process_queues_nocpsch(struct =
device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval, ret =3D 0;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evi=
cted, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already e=
victed, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* A process already runtime-evicted when hibernation starts<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * skips the save loop below, so snapshot its VRAM MQDs here<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * before the S4 image is taken. dqm_save_mqd_backup() is a<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * no-op outside S4.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_for_each_entry(q, &amp;qpd-&gt;queues_list, list)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm=
, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D qpd_to_pdd(qpd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;E=
victing process pid %d queues\n&quot;,<br>
&gt; @@ -1297,6 +1312,8 @@ static int evict_process_queues_nocpsch(struct d=
evice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 maintain a consistent eviction state<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 retval;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_save_mqd_backup(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp; out:<br>
&gt; @@ -1304,6 +1321,88 @@ static int evict_process_queues_nocpsch(struct =
device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
&gt; +/* MQD software-shadow save/restore across S4 hibernation, reusing th=
e CRIU<br>
&gt; + * checkpoint_mqd/restore_mqd primitives.<br>
&gt; + */<br>
&gt; +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_size, ctl_stack_size =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_on_vram(dqm-&gt;dev-&gt;adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type !=3D KFD_QUEUE_TYP=
E_COMPUTE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;checkpoint_mqd || !mqd_mgr-=
&gt;restore_mqd)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mqd_mgr-&=
gt;mqd_size) *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; NUM_XCC(dqm-&gt;dev-&gt;xcc_mask);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mgr-&gt;get_checkpoint_info)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mqd_mgr-&gt;get_checkpoint_info(mqd_mgr, q-&gt;mqd, &amp;ctl_stack_size=
);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;mqd_backup =3D kzalloc(mqd_size, GFP_KERNEL);<br>
<br>
Please note that you need to be super careful when allocating memory during=
 suspend. The amount available is really limited because both swap and OOM =
killer are already stopped.<br>
<br>
Instead you should probably consider unpinning on suspend and repinning on =
resume, for this we have memory put asside.<br>
<br>
Additional to that it could be that backing up the MQD is overkill, we shou=
ld be able to re-create the MQD after resume from the housekeeping informat=
ion we still have around.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!q-&gt;mqd_backup)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;mqd_backup_size =3D mqd_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ctl_stack_size &amp;&amp; !q-&gt;ctl_sta=
ck_backup) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;ctl_stack_backup =3D kzalloc(ctl_stack_size, GFP_KERNEL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!q-&gt;ctl_stack_backup) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup =3D NU=
LL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_size =
=3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;ctl_stack_backup_size =3D ctl_stack_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* in_s4 is reliably set at evict/suspend ti=
me; skip normal runtime eviction<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (pinned VRAM MQD stays intact then).=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;adev-&gt;in_s4)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd || !q-&gt;mqd_mem_obj || !q-&=
gt;mqd_mem_obj-&gt;cpu_ptr)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;checkpoint_mqd(mqd_mgr, q-&gt;mq=
d, q-&gt;mqd_backup, q-&gt;ctl_stack_backup);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid =3D true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dqm_restore_mqd_backup(struct device_queue_manager *dqm, =
struct queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup_valid || !q-&gt;mqd_ba=
ckup)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;restore_mqd)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;restore_mqd(mqd_mgr, &amp;q-&gt;=
mqd, q-&gt;mqd_mem_obj, &amp;q-&gt;gart_mqd_addr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;q-&gt;properties, q-&gt;mqd_backup, q-&gt;ctl_stack_backup,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; q-&gt;ctl_stack_backup_size);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid =3D false;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static int evict_process_queues_cpsch(struct device_queue_manage=
r *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct qcm_process_device *qpd)<br>
&gt;&nbsp; {<br>
&gt; @@ -1313,8 +1412,16 @@ static int evict_process_queues_cpsch(struct de=
vice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval =3D 0;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evi=
cted, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already e=
victed, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* A process already runtime-evicted when hibernation starts<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * skips the save loop below, so snapshot its VRAM MQDs here<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * before the S4 image is taken. dqm_save_mqd_backup() is a<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * no-op outside S4.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_for_each_entry(q, &amp;qpd-&gt;queues_list, list)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm=
, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D qpd_to_pdd(qpd);<br>
&gt;&nbsp;<br>
&gt; @@ -1350,6 +1457,8 @@ static int evict_process_queues_cpsch(struct dev=
ice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_save_mqd_backup(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;kfd-&gt=
;shared_resources.enable_mes) {<br>
&gt; @@ -1423,6 +1532,7 @@ static int restore_process_queues_nocpsch(struct=
 device_queue_manager *dqm,<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_ty=
pe(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_restore_mqd_backup(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, qpd, q);<br>
&gt;&nbsp;<br>
&gt; @@ -1486,6 +1596,7 @@ static int restore_process_queues_cpsch(struct d=
evice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!QUEUE_IS_ACTIVE(q-&gt;properties))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_restore_mqd_backup(dqm, q);<br>
<br>
Those are the wrong point to call those functions if I'm not completely mis=
taken.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, &amp;pdd-&gt;qpd, q);<br>
&gt;&nbsp;<br>
&gt; @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct device_que=
ue_manager *dqm, struct queue *q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr, &amp;q-&gt;mqd, q-&gt;mqd=
_mem_obj,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval =3D dqm_alloc_mqd_backup(dqm, q);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto out_free_mqd;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;q-&gt;list, &a=
mp;qpd-&gt;queues_list);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count++;<br>
&gt;&nbsp;<br>
&gt; @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct device_queu=
e_manager *dqm, struct queue *q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_acti=
ve)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; decrement_queue_count(dqm, qpd, q);<br>
&gt; +out_free_mqd:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_mgr=
, q-&gt;mqd, q-&gt;mqd_mem_obj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
&gt;&nbsp; out_deallocate_doorbell:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index 88191a4c1657..1f728f13813e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -637,6 +637,15 @@ struct queue {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_ga=
rt;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* system-RAM shadow of a VRAM-resident MQD =
(+ control stack)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for hibernation snapshot/restore<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_backup;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *ctl_stack_backup;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_backup_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ctl_stack_backup_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool mqd_backup_valid;<br>
&gt;&nbsp; };<br>
&gt;&nbsp;<br>
&gt;&nbsp; enum KFD_MQD_TYPE {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_queue.c<br>
&gt; index 98a5512b701b..cbc90bf87792 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
&gt; @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct queue_=
properties *properties)<br>
&gt;&nbsp;<br>
&gt;&nbsp; void uninit_queue(struct queue *q)<br>
&gt;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;ctl_stack_backup);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q);<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
<br>
</div>
</body>
</html>

--_000_SA1PR12MB73439B22EB3FB6CFDCD16438EBC62SA1PR12MB7343namp_--

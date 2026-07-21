Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C97C4452F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 03:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEF610E286;
	Tue, 21 Jul 2026 03:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ByhxG9l";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1927A10E286
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 03:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQB4uDRKrylYGIE9CkcH3rjjwapLarcIEgyXoEj/9XTsXihMjt66br3aLU0B7zOPQhZ/80CmJ9Y41VVpaNB0yyXNpFLAC9cXIPj7XPC3IrVb89N3CNOpLR0tslT/nD41KwNXUiRVxcplCd31BQoet8wKaPfwOGkjRvy76iURFejjnY2nELYsPJABRxshiRBcBsmbjuNb/wc+3UqJZS7Au7IyofhM0r3xfiWqPqVKsQMd+U/2i7FjqXHoDBnKVvvoVDcc7DIEDjpO15norUAFWxwevKnQeC2FpICU5F373LBCQk2Dq8vURWGJyqesqWJBm2C5VfhNWcvTAs+EZp1qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ws8oI13gEkzbmf4kV2mWlQvq9IuyQiEwaVs3RmKKu0=;
 b=TVbHxgJZNBhByPVX1Mc9KkWcuGgP47ef05Ix6J9TQ57XECI1jAkj7TChdqntvAf5pBVrCoZ3uvjbLuZs8OBzFR/gIzGVa7Lk6Q7NwuHYlK6Hatc7flrYCxpFWOceOshaEeV9gGcxxx+6TgJNFlh9lOXMa8C+NYZRnLCnXI5en0nJAPL6rybQLBn5DIZ8vbwy/uPFZIAFCyf1ZZKJS4p6fvluMj8/AgSMgJCCwSo0eiF7Er1G/INk4RY/FhkoK8DoaIBTIgrPqysl138T6iJkrkeSg/GVkzn2HZKAlWfx6sCBUZxrra/qgHFsCijpV/MneDQz5NY1YYHFSaiEAGggQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ws8oI13gEkzbmf4kV2mWlQvq9IuyQiEwaVs3RmKKu0=;
 b=1ByhxG9lm+3tCUo8wMVsrctszF6FdjmpVAI8ihouQb118ZDay8Xfy/TFCTTiu7kii1b13ZMkvFBPsfIAWdXSVtnjIFndI25Yinou6czVuD43yDQPzbN82XJ3226yDMidy/EBNj9tjYN1mTwpJ5kg/rdE8EbFK64Ze7HgyRpXM4U=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 03:25:39 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 03:25:39 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "SHANMUGAM,
 SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
Thread-Topic: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
Thread-Index: AQHdFcno/vE+AMxPbkO89jaTg2SEG7ZxaYuAgAAUMtKABdc5sg==
Date: Tue, 21 Jul 2026 03:25:39 +0000
Message-ID: <SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20260715103056.3529178-1-shikang.fan@amd.com>
 <20260717085357.41610-1-shikang.fan@amd.com>
 <da934005-b10b-4e86-b8b0-a910e59b3d66@amd.com>
 <SA1PR12MB73439B22EB3FB6CFDCD16438EBC62@SA1PR12MB7343.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB73439B22EB3FB6CFDCD16438EBC62@SA1PR12MB7343.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: SRINIVASAN.SHANMUGAM@amd.com,Felix.Kuehling@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-21T03:25:38.276Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|SA0PR12MB4462:EE_
x-ms-office365-filtering-correlation-id: 580fc839-277c-487b-d43e-08dee6d7bca7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|56012099006|5023799004|11063799006|4143699003|10067099003|8096899003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: YTF+DFJhwac7lMJ2LrlWYCfcCJAH20JkCMa3yAMjjO9zhy8rkAoXBJbE/YZX0GC2A49MFEaOxRkSq8ty+eVkhbcmJioaHWPq0aBM5fPqqKR9v3eGgI9M+nK+2cFqeVdEpOzux/fSfcGM0blZy54z84UHEpaHZQ4/IZdUr7cMhMDCJ+HMoT7XS6gQyKwMxojFNBDPaGuf5b5dPQ2dMLJxNx4c6DHyqTQeqmiawN5BJGzBgOUiJfbfPZIAGalS2bQBAsJ3/YyIdTKnwZfdpOskrzafFRLXO8HjoFpSTfYZ7nT9HZE1utWd/WPywbUA+5t3ACUHpHyDP1gGkjTVRaO+dMmXeK5EvnY49J75AEuUVt/EbhbXegaYK8NyEfB1L7ZBC9YY6JHT6v1hmxynhqll1pY8fDEq10O5CLgFgPgdr3DzcPBTJ6A4qhpxZBmT3pm6U1+eh9XgR2fotXIXJLaBCba24fd22SfFGuaYmOK1dC4WERQaRKp4gSTOX397JguttSEkD03cEGNvWv47xEGbpH6ZOa0ASqTxIwn23CM1qV5zJOIoqFfBfvyzVLNO0lDUIPur5xG24Kr2jnI1utlvIXf5j/jbbdeICF+VTQBct8lZLjnX3/6QsAGCVZr3yjgBkYB3HCbofzS9chSOgrnA+9ar15xXzwenUf67yYiDvkp4mPECjqjk7BZvGDMEqizNsFAKlBBni4255E8APlNZWyvrn93uTQs8+3Alhhy4WsI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(8096899003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?zASg/kNnXiqsBhAqpT9J6EUhI0c5BShNHms2Lauh5SmdQGQ9JmtwK5qY?=
 =?Windows-1252?Q?DxOUQd24kw+k8eiDy3PZdW33EvUxmA2TxqfuPANQIJT7BvqkuXy5AyGf?=
 =?Windows-1252?Q?JofeJ5CLYrlR6yYFw4FC3Pa/ztYv9NBfaesUWXb/bCs0y9kWwHYJoMFN?=
 =?Windows-1252?Q?GCKoLIjRlScwueIcHG/6fgmcCLRs+5mcHePfqlC0C+VzruDp9kSHju13?=
 =?Windows-1252?Q?BAPF+KJshiSUMQ0n/BG5V3cOnaiBecXyDxS8OkKi8jIAplWPitXreI3s?=
 =?Windows-1252?Q?qNqYToOpxwOELj5RidHxdrbNQvVuN8EDxfaL8pQ7nZahsPWTiuG6+fWG?=
 =?Windows-1252?Q?r24rsQ+/oIJTTHXkP5peaPyCyfaYRif7Klf1ujKTTWZglFhIFkA6pska?=
 =?Windows-1252?Q?07Al49asw/rhNEo+7CdmF1Np1CzCdlzmd2Ed2/ubMgF5/+jROclDbG0h?=
 =?Windows-1252?Q?AZLRNUYQbWczUVMsitS4tlGZYjLMLaOK3ZZDhHS/XK1f99I+Jueysh27?=
 =?Windows-1252?Q?+bPiqyksdIdKXfP0uD7MDIxIrEEYAsW4Q0yTS33JWfZgX+lq3ad+gkKE?=
 =?Windows-1252?Q?DN36gvjCh42PeelkYELnxKUJMsBotdki+DPLAqdKMZArL1obe3AYzhT3?=
 =?Windows-1252?Q?28MEYuWjV4865LhSLbM0DfXmQEhm+CB5tolVGxS5BCAt7zzoO0rkZmja?=
 =?Windows-1252?Q?0qGLGTC4/khkTgZhZDG4NM1+SIuSd8sxCtpqh3477jgXYmTVR1T/9m7e?=
 =?Windows-1252?Q?tGfUhckMCvN2cJZvE2I+TuqE8HHVhPyB/vyHrmIk89VXmvr3jPhZ4pzn?=
 =?Windows-1252?Q?oABlwPs+vlwgdluMOwO6RoE/AG9pLkqdCnf8ZkJGh3X74JYcwiaLdwXz?=
 =?Windows-1252?Q?XO+lErcif9PtwKBujdzBwuc82bwMUyM1q3+sVmAvOVZuiSz2CdqoStG4?=
 =?Windows-1252?Q?DHHl25bN608WU2uvHtXJzMoFc9a3ECI59ttS3kJcvaHIhTL4vQaRwjCY?=
 =?Windows-1252?Q?3Q65c4ZONyjUdcYZmsjj+jxz1xnsOCDxThPfS9kjjlP2vNyW8TW58OuK?=
 =?Windows-1252?Q?yGJrKOyZRKmlRe3jWAQIccuFzmZORGXVGseAsO3NGD7iiyT6QoyY3uSq?=
 =?Windows-1252?Q?DS4IEzMGN84mxRm50oQjveeBic1E6G+LfESUdj4Ug55aJg990mi0Qsi9?=
 =?Windows-1252?Q?jW0fsOE1P5RBfxSDC2qV3IXgfiStEe1pXddSDxsQc1IAC64tsomnoXms?=
 =?Windows-1252?Q?lT1tfx/BWkUfldy1zTxng9m3xGWCMiyf1pybsUWjtvD02OA1GQxtWQXo?=
 =?Windows-1252?Q?3OIc5iyHiwpaMxW5Ki4ToO/oE64SzxgXJG+Qer5UrmtjMHpsK8oHr75d?=
 =?Windows-1252?Q?cAGxqIIxga0gLWaODrIuqwcl1OmoBlju/BG8fgay+KXMGnS1r/fE1rT6?=
 =?Windows-1252?Q?xV5FdNSN9lvvrRO9oF6Bkq/aS1V4j8EXn+AJfS0MYxzSua1VrSsJijEm?=
 =?Windows-1252?Q?26pKbenR3uC98XhwjSL0zJE5XpBX6suH5C4+avG1e64n5JnNI9D8jwDS?=
 =?Windows-1252?Q?7UcIl1TQ+FpT+/JreXl+ynCDt+gT6HXorM/EfV++paYmJ+qM0sOtWcHa?=
 =?Windows-1252?Q?LPh6KpKCPKgWP8ZAp4A7uowwjXfFHWDdZZd8qByBTZw4KPfg1mDiWQlH?=
 =?Windows-1252?Q?0j+HrYAJQ+pLliK/5LckpPXVjNn4XVXBvb52fKJmm8wwbtVDXO0QaaDX?=
 =?Windows-1252?Q?+MW6vFIVmi7mLNshyfDsXpr8K3gKrn+XmltrrApoQb4GeeakBPGtFXZJ?=
 =?Windows-1252?Q?bwn8zo3W4Sf5qJQ3WdoVYv64xIDvrsknDQmkOCXEL6/b51Y4?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580fc839-277c-487b-d43e-08dee6d7bca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 03:25:39.0256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJQsHjpAisoMQjC/zHdLxIP8luyz75kFEloaFVkx1rvhx/Iw/26kuIyXiqD39ruVwG1CaBEkc3J1MnoUH55lZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

--_000_SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22SA1PR12MB7343namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

AMD General

+@SHANMUGAM, SRINIVASAN<mailto:SRINIVASAN.SHANMUGAM@amd.com> and @Kuehling,=
 Felix<mailto:Felix.Kuehling@amd.com> to the review discussion as Christian=
 is currently OOO.

Regards,
Shikang

________________________________
From: Fan, Shikang <Shikang.Fan@amd.com>
Sent: Friday, July 17, 2026 6:25 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM

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


--_000_SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22SA1PR12MB7343namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
+<a href=3D"mailto:SRINIVASAN.SHANMUGAM@amd.com" id=3D"OWAAM517752" class=
=3D"tWKOu mention ms-bgc-nlr ms-fcl-b">@SHANMUGAM, SRINIVASAN</a>&nbsp;and
<a href=3D"mailto:Felix.Kuehling@amd.com" id=3D"OWAAM431627" class=3D"tWKOu=
 mention ms-bgc-nlr ms-fcl-b">
@Kuehling, Felix</a>&nbsp;to the review discussion as Christian is currentl=
y OOO.</div>
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
<div><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);"><br>
</span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;<br>
<b>Sent:</b> Friday, July 17, 2026 6:25 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
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
<div style=3D"direction: ltr; text-align: left; margin-left: 5pt; font-fami=
ly: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
AMD General</div>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
I do have a few thoughts on the unpin-repin approach and re-building the MQ=
D from housekeeping information.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
For unpin-repin: the MQD's GPU address may change after it's moved back fro=
m GTT, and several places hold the original address, so we'd need to update=
 all of them and be careful not to miss any =97 but overall it's doable.</d=
iv>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
For re-build: the one thing we can't reconstruct is the control stack. It r=
esides in the same BO as the MQD, and the driver doesn't preserve its conte=
nts.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Separately, I'd like to raise a potential pre-existing issue I noticed whil=
e writing the patch. mqd_on_vram() covers gfx942, gfx943, gfx944 and gfx950=
. gfx943/944/950 are all registered with the _v9_4_3 implementations, which=
 call flush_hdp() in init_mqd, update_mqd
 and restore_mqd. gfx942, however, uses the base MQD functions, which lack =
the flush_hdp() call.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Shikang</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Friday, July 17, 2026 4:59 PM<br>
<b>To:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&=
gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-size: 11pt;">On 7/17/26 10:53, Shikang F=
an wrote:<br>
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

--_000_SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22SA1PR12MB7343namp_--

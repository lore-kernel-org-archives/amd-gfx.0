Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6F3C28B28
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Mar 2025 03:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CAD210E0E4;
	Sat, 15 Mar 2025 03:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fSrxqI5c";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B95A510E0E4
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 03:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rfwv8C0omvAJPt2n5EDOUtexsoxEPKE0JZkUrCl4wHBcBBIncbaF1ci1PDO5u6Sl62bq9qAVY0kdMolSYKLG0OSYz+SQ2rKWiFttXFjxdaLlFMzKHBvfSZuZtiVTnfLsdubW7yFZL4qiPICYsQ4fQX3yArjY4UTn/mLz6PSpGoO2xnBMn2MIOnvno+SdrG+FRH20329fa1515FehkhEthgraFpodqm5vHcoXdfrX5m8SrBmy9GSDr05JQaq+ci8i/6b0f9jpFG60FkGwWlCM4nSvW/Lvcu5dstaykafwBnjKNbqWulPQY/50R8BSUJsyyO0de/CnifS1bytk5K25nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYh7zwN4mj8Xw5LYysUrAKyfXa3qCAD9/SGxTWww4xw=;
 b=HaIxpU6ALCxttM6S/Ypkz2ebldditbLDiNV+3KCZNVpI9JVuWgqUVuqlNFHhSJwu/1DSpE2JBT7FBGzZ8RYRh7uNPZ/6bOVbp98j+ZVFkbcNTRVPTF8Q7Z+iCpJ4l2RHWOIIb42CIfEWxxyTwoZ80aILDFaSnK+JEoYYgOC8jy2GMgDRUQ5gBXiYWhIccakEbvcOZTwNvEv9l4CTNHSn9F26WoUW04vbYJV8f7jWrW9NNjLcyWLafTFXyRAMIzqwUCwuLSxgCmUNe1hd6HBL73FJm1E4kr9ZydaIQ/NYfh9JiMz+vjdzicIluR7DdUQCwB95mBUlk3ZOSwXWGnvc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYh7zwN4mj8Xw5LYysUrAKyfXa3qCAD9/SGxTWww4xw=;
 b=fSrxqI5cuoqnPdig0QKruPCh7V+zbVVkPBBZjMpW+qpIgazN3lmYq1HGihutS5b1Cmo5yHcKAAMy4v8d5weRurPtYbpYy9aTjD4Xe0CGTRQmUntZSeuAtYfsyfjtgCec7yiK+38qCUzIxNQuA52SWobx98kclSnPwO3Kx3cy8cw=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.28; Sat, 15 Mar 2025 03:41:39 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 03:41:38 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH v3] drm/amdkfd: Fix bug in config_dequeue_wait_counts
Thread-Topic: [PATCH v3] drm/amdkfd: Fix bug in config_dequeue_wait_counts
Thread-Index: AQHblUN5C5Uox/OMtU2mE9eg+6JvEbNziNbQ
Date: Sat, 15 Mar 2025 03:41:38 +0000
Message-ID: <CY8PR12MB7435587500A56EF9B19DB33C85DD2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250315004427.259694-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250315004427.259694-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=35bcb7b4-2e89-4b9a-b3fa-93a2e0843532;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-15T03:36:26Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DM3PR12MB9416:EE_
x-ms-office365-filtering-correlation-id: cb88d57b-ed84-4a05-df48-08dd63734b20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GrLfcVSqyfNfF2pRoMCFJ3yeLovHdIuzneNWAyAiLHyIzEILQdMcHlCizMcu?=
 =?us-ascii?Q?jBAqXtSz112EZtc39DRxW1o8wv7AGe1BgIrbxHdzLyb/plRhxe0TCZtRsrdU?=
 =?us-ascii?Q?7ufy0A5X/KvsMwZJXc6hYY/CFcNXoSP0jzkZsvkZNtiBgrbRsn+c9TSuCzf3?=
 =?us-ascii?Q?rl4IP7GD9PDswoUatFjOk9nI1a9+sK0/Q4PM+XCITQ9rV+9+HSBP7X3JRofq?=
 =?us-ascii?Q?0u7U7t7+AQHBIaz7YTXudOOp5lA7ytTIWNCCk9m0Id42niXg9lIn7Z5plTYL?=
 =?us-ascii?Q?S0/o6zMVmZdOJ4GjxTY7lQuIlMflRwd6NnMFMqedDlbk1ZPP11MQiYdb0Ytk?=
 =?us-ascii?Q?1whJGFk3e8v6szc3JYZnhtuTg3qA0bDLILX+QSTylXeKGfSM5rDigBQgTf36?=
 =?us-ascii?Q?A4Bp05NG8BDnrtYTbMN+C4Zat37cKioa0rUz+PJ7FvcHuRvUB5EV3sKFQoSg?=
 =?us-ascii?Q?oDaoOPIXDpf8KtdmlQd+s0oh+oeaddLhRRYpVTlbnMZ7EF/xu7I2cQ8K8FKi?=
 =?us-ascii?Q?gKd0IyjZGx9wnoF9VKv1BPcQSp9VlRuIIqkpowc5W9eFvkHcjhdaAuKtWNj7?=
 =?us-ascii?Q?SG6UoxaBQUpH6qnDiTj/po6D5o/WmhnhYk5yEb7JX9VJhzAkmi0zYZwUgXix?=
 =?us-ascii?Q?pgC7MxJrv6nBt1d2AU5veQbjZ6XtGyAYOcLCNGSpQL9Cx0NFRL3xgxnBp6iI?=
 =?us-ascii?Q?+HK47hUnxKdfeXKJdm1StS+Ofur16NiV3CJYMoZ5o3jz/fYI7PP18nw5S7FW?=
 =?us-ascii?Q?FdgOMr/rrH7iE600ovi+oyHVugaf2Zu1JoMeq/XU37tNaODHp/dq7XfwJo8T?=
 =?us-ascii?Q?dU7qNSBlttq5wgYHXnShdbfS71dS2YyrXOccwOoEktPSE2u8XQBsaQesuXjX?=
 =?us-ascii?Q?U6YBNGiIOdbfjGdySHy9sZRKArvIx7WvN6jnd1sysMJEUF6h+bCw2DHJ2Tkn?=
 =?us-ascii?Q?EBwiFlMPwPx79BckRg+PUSSnVkRvsawVHoQy6iVlzYY/A9Ul0Px0bcJZxNN7?=
 =?us-ascii?Q?9UGreZak9EEu90cvSJdZKIGvoSvxMn3fIlpct72513Juy5rvFpetQw7swfxV?=
 =?us-ascii?Q?O8O7Uo0i7WYquQg+F4bbwFtzc6WPWOclYn+gjdnCwS6JbfFdYTS+as50O9U+?=
 =?us-ascii?Q?/l3ynO75TZovnmXuDiwKb7symVbbgErQabzjqEMirUg3KIWolU1AHDY+xxjs?=
 =?us-ascii?Q?oVjykotHoJApt7PR8bxhpVIo72ICl9g23Q6l2Ri7Un+Sb48+pWUk04D7Wk93?=
 =?us-ascii?Q?jsj83qGFDEysvenusf/4EYvTvlnOPc9In8RSPRB71fshk6hiBERVY64GMu36?=
 =?us-ascii?Q?ud3qCg27YWEwa7A8BzCRMt8sMrb8mmTkPTLfCWAjgFGpv5t+xHzwUta/JGp1?=
 =?us-ascii?Q?8qlPdglL3OOOARjlq7Xiqa2IlxhYR5EmDyjDK6K1rCXpG3S+OJkEL0VJxMEm?=
 =?us-ascii?Q?i746a0+1JGQqSI7MCi8xoagsosAgLCxF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hqV9Oa29D3ucT+YWH7kf/0srW0zZHzArCcqueNLs/knfpYbnTT+U8JhHrSH3?=
 =?us-ascii?Q?mHTGwYMVvzMwW21wuw9uX4T11/6Eo8Rx1ewJJ3huQYmFudQRpxhQsrsr2iU0?=
 =?us-ascii?Q?RhZEEMYgl+kVCNPVPu/xfpwqgAOiXWGQOltQ2q8zfCdBquE0BlWetENZJyXX?=
 =?us-ascii?Q?XV4vqcBUXbaT2uNZ28uYN/VDrAmsH52EBGZLPTaS9Ul5lq3uPIAFawAlcoEy?=
 =?us-ascii?Q?FDUKGk+FAu/MxrfDYAqYPrtnSAimTCeWb6CyD++VWHaWcX44S1XYUVqDHL9u?=
 =?us-ascii?Q?F83zUdZZxiMCZDoJPFw0ytt8vxMjlFBExg5bQRe0VrXGwwvsdy3eKkKzjcSU?=
 =?us-ascii?Q?dtVzeuqHeKYlbRZm4JUBdVWDeBhwuOCU2H1VsUvsXzNsfkTmXnp/+i1bdku5?=
 =?us-ascii?Q?RoTds/M7H/FrsoNOryCENQhJlahytVVqCuoM0fIY5axvYjizA8l7KaSu8vGD?=
 =?us-ascii?Q?ZNJgPXAJKJ/MVw7sC5EPKgAV62/0bMo56+QGEcNCOuUyN69khVDs3Nqr/aip?=
 =?us-ascii?Q?v9zt3xY2al6ypFeD1HMyVWafDbZcZimaaznev59X2L2+RhQHgY1bywQWZVU8?=
 =?us-ascii?Q?cK4Y3RHVOBMYKtPVyWfkVyFXWbV28nUAdTx3mFyHKoS3V4BfUFZ/3lL9MTwK?=
 =?us-ascii?Q?Vjgl3AbxIiIcUEqgCssXXt9V0BZVNeN9kju6J5V8vxYV//qQ1TEmyYepVV0k?=
 =?us-ascii?Q?7Ikb+eb9ee308WNmUshkh5gjYt9f89T6oBNnXeJ7MCszzyLyR5avsb0Zgr8v?=
 =?us-ascii?Q?ebT25s5jIjpofS3APF1tZsR/NiAIsBB1PvfwwRKWtXmDsFd0xWnseldQVURJ?=
 =?us-ascii?Q?oBtVAkIcQUhRkLykgZNWMgu4ALoP7HfYFXnwJ0pHhx8h3V7gZocL+1wDLwrX?=
 =?us-ascii?Q?lGrPPyQ924cfqJ3V1YMfnM3hGFMhMrOX+v5Adi+NpiUscm92oh9AP1r4bYbe?=
 =?us-ascii?Q?bkFazMg4qOJdZlVVOBSV/7YFwEijCXJ3JVlxVhgvTWb1oC4HMNVsmM02lZkC?=
 =?us-ascii?Q?zJ6Vo/Gu4svzS2VJg9G1D20WToIyo6KklpzkSfZws69PFh5wX7Ibk/pqk9oR?=
 =?us-ascii?Q?Nb7CFwzLwjfQurrXRPfiflaxFvLeTe/32gn76cESM5hJLkFrNhHAfY0L9A2N?=
 =?us-ascii?Q?MHzyUp0goGvmZlqy5W4FUkbroyUuIgJbqCelbM/2tmz+DXKLGMBOOQ6UmwmF?=
 =?us-ascii?Q?7dusfLGrvOP3FdoEXm2ZhMi7nj2RXqmkOeLpqlsd0Co3XO7/J1nMidHJoW9e?=
 =?us-ascii?Q?Wt0bgSu6d8YoEpsY763ZGAITFDu0AfyhD3bPaPRAXuUCmhpEj2VJ9JWo3UYD?=
 =?us-ascii?Q?86lIUf1zRaykDipW0XabHBjH3QiNsxgMd5Q3Q3LUZrXv8vZxmnbAqw7iW2cj?=
 =?us-ascii?Q?4kPyRE2dNxT9xUACoQA7rMgrDiUmG74NVPB63BBM5aTV7hIEN07CcWy6OG+X?=
 =?us-ascii?Q?dLbrJ1U8d5fEPgJnI0NH37SCHt4Ox2MqwCJeuEOF72H7Z5GQ1WVw+aQ2hohc?=
 =?us-ascii?Q?pgszzU/oeMg/Sx3ZmfsSW6oAMg42Wq2wFrBAq7l5maazhFxbXAutkwCKn5hB?=
 =?us-ascii?Q?vlUxSO/2uhTusFy+XQ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb88d57b-ed84-4a05-df48-08dd63734b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 03:41:38.8856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6HTEGk9gKuSHr4OmtgfSUAArzkjYzBROl6fqKURjTRUDVIkWA6Iafs8YcBWiEk8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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
> Sent: Friday, March 14, 2025 8:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH v3] drm/amdkfd: Fix bug in config_dequeue_wait_counts
>
> For certain ASICs where dequeue_wait_count don't need to be initialized,
> pm_config_dequeue_wait_counts_v9 return without filling in the packet
> information. However, the calling function interprets this as a success
> and sends the uninitialized packet to firmware causing hang.
>
> Fix the above bug by not calling pm_config_dequeue_wait_counts_v9 for
> ASICs that don't need the value to be initialized.
>
> v2: Removed redudant code.
>     Tidy up code based on review comments
> v3: Don't call pm_config_dequeue_wait_counts_v9 for certain ASICs
>
> Fixes: <98a5af8103f> ("drm/amdkfd: Add pm_config_dequeue_wait_counts API"=
)
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Nit-picks below.
With those addressed and as long as this has been tested on optimized and u=
noptimized HW:
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 16 ++++++----
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 30 +++++++++++--------
>  2 files changed, 27 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 3f574d82b5fc..8a47b7259a10 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -418,6 +418,10 @@ int pm_config_dequeue_wait_counts(struct
> packet_manager *pm,
>           !pm->pmf->config_dequeue_wait_counts_size)
>               return 0;
>
> +     if (cmd =3D=3D KFD_DEQUEUE_WAIT_INIT && (KFD_GC_VERSION(pm->dqm-
> >dev) < IP_VERSION(9, 4, 1) ||
> +        KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(10, 0, 0)))
> +             return 0;
> +
>       size =3D pm->pmf->config_dequeue_wait_counts_size;
>
>       mutex_lock(&pm->lock);
> @@ -436,16 +440,16 @@ int pm_config_dequeue_wait_counts(struct
> packet_manager *pm,
>
>               retval =3D pm->pmf->config_dequeue_wait_counts(pm, buffer,
>                                                            cmd, value);
> -             if (!retval)
> +             if (!retval) {
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

Put else statement next to brace in line above and put braces after else st=
atement to balance the if statement braces.

>       }
> -
> -     /* If default value is modified, cache that value in dqm->wait_time=
s */
> -     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> -             update_dqm_wait_times(pm->dqm);
> -
>  out:
>       mutex_unlock(&pm->lock);
>       return retval;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index d440df602393..f059041902bc 100644
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
> + * @return: -ve for failure and 0 for success and buffer is
> + *  filled in with packet
> + *
> + **/
>  static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
>               uint32_t *buffer,
>               enum kfd_config_dequeue_wait_counts_cmd cmd,
> @@ -321,24 +328,21 @@ static int pm_config_dequeue_wait_counts_v9(struct
> packet_manager *pm,
>
>       switch (cmd) {
>       case KFD_DEQUEUE_WAIT_INIT: {
> -             uint32_t sch_wave =3D 0, que_sleep =3D 0;
> -             /* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
> +             uint32_t sch_wave =3D 0, que_sleep =3D 1;

Do the following here (start of case WAIT_INIT) for safety to explicitly st=
ate certain devices are not permitted to do WAIT_INIT since you're uncondit=
ionally setting que_sleep to 1:
    if (KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(9, 4, 1) ||
        KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(10, 0, 0))
            return -EPERM;

Jon

> +
> +             /* For all gfx9 ASICs > gfx941,
> +              * Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
>                * On a 1GHz machine this is roughly 1 microsecond, which i=
s
>                * about how long it takes to load data out of memory durin=
g
>                * queue connect
>                * QUE_SLEEP: Wait Count for Dequeue Retry.
> +              *
> +              * Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU
>                */
> -             if (KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(9, 4, 1) &=
&
> -                 KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) {
> -                     que_sleep =3D 1;
> -
> -                     /* Set CWSR grace period to 1x1000 cycle for GFX9.4=
.3 APU
> */
> -                     if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> -                     (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, =
4,
> 3)))
> -                             sch_wave =3D 1;
> -             } else {
> -                     return 0;
> -             }
> +             if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> +                 (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3=
)))
> +                     sch_wave =3D 1;
> +
>               pm_build_dequeue_wait_counts_packet_info(pm, sch_wave,
> que_sleep,
>                       &reg_offset, &reg_data);
>
> --
> 2.34.1


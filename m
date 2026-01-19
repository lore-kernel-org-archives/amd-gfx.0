Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A7FCCF2F6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 12:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0896E10E42F;
	Mon, 19 Jan 2026 12:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wV0Ac5RX";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FE710E42F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev94fxZYRSFKrJmT9YjGQ9dNyvULmE1xQT7dEICr4m4Ana5kjJ562puiGgy2zVfx4xcwfTR40RTrIGE4oR28eBeSB63izz7PrJIg4sQgi2HBmv/MUAHim6Ctj+pUxRSvVYZFlCkeXOrNuZfeXLJa+0hOHdIAX4GAUbTl8M1uqptv1DY3o4C1qFyv8+I0r2GHFQX0LDHPIPYEU/N28Y/bWKrAQhgUYXix6DBJ0MaVtO7Jbb5D6hnq2ndx9DWO3siiqs+GjzNcyrOQncpvO7WnT1nsPsQlzfuindIioz7KcAgscZSFJRlXrf8vOet3OLFlGGNihP7p8LJFxcDdIgmQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEegKZLYYlI9kbPBAF9VYyfpAFBsxYhURSvR4CsSytc=;
 b=JVpwmqQcTHjOWHX6j8d4WseMYchEinRyzwMhh/ltElhayZeEsoLUtln6Fa6ofdl7/skX/cqXVD4gXrjFesc26BwQJXL9ER256cLdAtd9K36FdGBZwRQVjsSVpWl4/y5F252hpCOgcM2O6i57FxiH4VYa8iAD6deV+0ilt8BxIq6kr6+mQthmR2E2E+UwMl66QqSYRtHtdC5bmjCipcBTgljbhMgKjkNR7eEDUXRNPO4CxeBSGr4+nz1b9p7HZrhxR3khpTGljy2ml5ZPI1nHOikTyO5fICZ7K79KRiN79wGQwmyGRzgdSEtVknLSEjj9Wnz7wZC1yDnTdc2cGl0KPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEegKZLYYlI9kbPBAF9VYyfpAFBsxYhURSvR4CsSytc=;
 b=wV0Ac5RXIumM98h7MniKb4MT61U+M5BBo3pmLWs6qHqheoX57rHA5AB6OJekkSEoVYaJvlO1DiFTLhD20sBw6UBEUdmZbs4ie+JS/e1edDHez8BPWj3VftoTgijxEr/xdAgSjrFTbfyHzEBu8BI+h+rMP5MuSBVe/AQJMyOUNHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 12:42:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:42:57 +0000
Message-ID: <919c6cbb-8035-4d31-bfc4-c432f90f3468@amd.com>
Date: Mon, 19 Jan 2026 13:42:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] drm/amdgpu: don't call drm_sched_stop/start() in
 asic reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260116162027.21550-1-alexander.deucher@amd.com>
 <20260116162027.21550-7-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260116162027.21550-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e820acf-6532-41cf-aca4-08de5758456d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHFmM2lBZEh6Q0dLOUZ6QW9uNjZHdFdCWkh1VUtsMG9YZFpnSUJuWWlyTmls?=
 =?utf-8?B?a1J6RDI4Y1Z0ck1tZE11N21lZjVvK3lmcGhsZmpjV0hhdnNWaWUxQjNienc3?=
 =?utf-8?B?Q1ZyaHdPQ3drRElXRVFQYW4wTndSNzlDUG84Nm0vTUJsZ2UrbVczenFleUgr?=
 =?utf-8?B?b1U2elZNbTBES0RTdC82akpWM3dUNVBDMHBJMlBGdS9NQzdYOEloVlFacmNK?=
 =?utf-8?B?QzJVUVpxcFk4V2gyYkJTYjVaSnJqaXJKbVF3Um5oRUc1OXMzNFBYNUw4cU8z?=
 =?utf-8?B?QzlKcGtuUWFkZENNWUJwRThOQVg4ZmVaMElkMkZZYS9BL0NlWmNHKzZMVkhx?=
 =?utf-8?B?WE5xSUlWL2FGVytFazg2ZnRaSHNsb2pUenc4SXJma3UzQzZLQjUzeERkQWVh?=
 =?utf-8?B?d3lwUDQ0UHZjR0pleXpJQ095S1VBbExLSUJtK05adWRyRnpvUnI2b1JRWDEw?=
 =?utf-8?B?dGN1S001aFpFQTdQTllyRDNHdUhBYzJZZGxKejJQQkVtemF3cWhpQnNHRUZC?=
 =?utf-8?B?OFJMdTZnRDVBTTNmUEQ1V3NmVTIrcFRJaWZWa1Zwb2w3czdnK0x3M3d5MzBo?=
 =?utf-8?B?ZVk3YXpTYUhDVVpnZlZUMkdDaVgzbnYwVW91K1gzMUMzaEduSzlhdGUyT0Ux?=
 =?utf-8?B?Unhta05IdExhSkFRTWlvdVA0T1VaN0lhMzA0UFYvYjZHdkFYUDdhUDlpMFdW?=
 =?utf-8?B?bVF3Z1lZelpHZ2d3a1BZSS9DMFhhZURjNzduTXVSenR6YjR2SGEzVHljZnVn?=
 =?utf-8?B?NWM1K1Q2Q1BIZ0V1eWxDUEtsRkZSSjhmRUZjOVhGRmpyOWQzdTRmL1QwUTlu?=
 =?utf-8?B?RzR0L2lsOTlJQkd1d2pvL1FqaGxpWC9RUVI1SlRUZVB4d1NqUHp2UmNucnN1?=
 =?utf-8?B?NGhCOVYyczVlSTlSclV1UDdxd29hRms2WERXSEk1bTI5RFhEcTUrU0huOHhv?=
 =?utf-8?B?WG9Qd09oT1FocFQyejJMN3VNVzZVS2F5Y0JDVjhBcHl5VjV3WDZibkJrbThh?=
 =?utf-8?B?RHF5dXFSTFV5MlFQV1R0U0d1TXhaN2VSQzYvclRuOFg2RnFKL2NTVlFPOGJ4?=
 =?utf-8?B?ZXJBT2FXOTdaM1JzcjdMU0F4bktqcjFzalFidWsvZmtBSURCbzZ3aEpmWDll?=
 =?utf-8?B?S1BUbnFheENZbHVCemlJU0VITk90cFZwajhIcUNKQ3NiY0pwbUtaWERBL3Vx?=
 =?utf-8?B?WThWd2VkU1RhbzlIQmpnMjZXVzhJL2JTaE1vSDBLM3plRXNLelcxS2dteU9H?=
 =?utf-8?B?TnVoVkVCUThybXc2RENGZjNuRk5zMXg0dFpSK3dCK3hMWGJOMmNGVWx5T1p4?=
 =?utf-8?B?NVAzdHVlQ1RMV2lwenlnc2ZWK2dwVHFMeVBwaFd5bVNzbmJaZEtzVTVCYXZJ?=
 =?utf-8?B?K3VhSjREY3RXOGFlemhGcHkwcFUxL3BlRjhNSDVFbDQ2aWpXaW5IcUlKak96?=
 =?utf-8?B?amFtUG1PSk9oSlk3V2l0R0lOS01HdTFrNVNzZTNVUjBZTVEvUDdTTTlUWGtT?=
 =?utf-8?B?NHJWVU5rRUZZeXMzdGpSaTZsd2tRc094ZncwQSt4SEhzaUkwL2lwaytkY2pt?=
 =?utf-8?B?T2RRdm9PZjhkSUZHREFTUEkzczVmYzI3TEF6Y2w4U1ovQVM3Yzk4RlpyL2ZJ?=
 =?utf-8?B?WkN5cFRaNUlpSTZUelVoSjNEUFFpUzFaNGtKYVVCVmlsSnkyeVdOM3IxQmIx?=
 =?utf-8?B?UU5pKzFHeStzaXBiKy9YdXZCL0d4WHNYZ1RJVWk2akVsdWhmZEtoVkR2dmVC?=
 =?utf-8?B?Tll4K1loSTFQUVA2ZHZaWFRKeDRJcGlwcXhCL1loOGhQVHBaUjRTaW56SW1I?=
 =?utf-8?B?bHZFUWVUbjNjdHdjTjl1TkhoZzBtcGdrRFhHVkpkTE9YSnB5S1RjRi9QYTdE?=
 =?utf-8?B?SWR2NmhKTU1UdGRjMGNXRndBcWYyQ3o3azh5ZVZVRk00cVVPS1BkVDNXRkZq?=
 =?utf-8?B?RDBXdTF2UUY1UGxwMVZYUkdpZ3hwRDVidVUxOTdpNVBoanZjS0R0R0orTEMw?=
 =?utf-8?B?Vmg3R1BaVFdXb2UreDFvT1R5ZXVia1hsd1hFcjFBb2NjMkNYUExJd0F6L1lO?=
 =?utf-8?B?Nkk3RUowVUxjVXFrNmJRTER1NjdqWGtUWnJtOVlRSWtVS2pJcXE2VDV3MUtj?=
 =?utf-8?Q?BWnM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1djZm5SZXlkRGUzMkxsWHQwMUpya3c5KzNyemlmdk5qL1owVW5kd3ZiQklR?=
 =?utf-8?B?NktBRDE2NWVlaEkzczRkdWc3WkRLWUpHa2JTY3ZLQUxDWUptTmNvaHRlSHIv?=
 =?utf-8?B?a01Ha0VyaDMvOVhWYnBnaG5yVlFuNDR6SlZSclNXWm4zcGFWMVN6SmFYdnA3?=
 =?utf-8?B?U3A5SnV2MlBSWUxtelhBWllaa1pULzJXZHpJTy9uK1VhdktpZ0VlZjNPZlpM?=
 =?utf-8?B?d01RS1FFaFh3NkxaK2dlR2lEUEtpSTN3alZxdnNnUGcrb3NMUFNlczVrWlRy?=
 =?utf-8?B?M3EybjBmaitES1VqWm9iOGtBU2FYVXV5cnFONUVMVTZINDJabUVPenQyNnJn?=
 =?utf-8?B?SHlJdVBsNVhwOTdnQWRSRVQwRVUzc1p1QkM3Ty9qaHZHSlVXWWxqT0JrN3FN?=
 =?utf-8?B?bS9hVUdUZk1idkFPK1BGQjZZUWdtNWlJR2R5VkVFVHZxa0JSQlFaOFF6ak1G?=
 =?utf-8?B?eUZYNGZFaUZhVEVqK1RYbCtGanBYZUdROE10cnZXT3NZRWNXemZMVU90TUkr?=
 =?utf-8?B?TFVzaVZkcjRrbUNwMm92MFRidzVJbUoxRkJwaXRQcVNnSkNlSnpYWnlRUUoz?=
 =?utf-8?B?VzZaTUhIb1NqRml3SGx5R0xuZFliVTNweWhyelNXRXY0R2F4WStXWmxndHY0?=
 =?utf-8?B?Q1NmcmlUSUVSMEs5MkFuUmJvcmtyQ2ZSdnV2aGJuTVljbndCR1R1bVBDVEVI?=
 =?utf-8?B?YTVuY3BmcUNWZUw2VVhaOWxOZXoxQnFJZHB1d3Fwc2ZjdXhiNzBQSWp5NXpR?=
 =?utf-8?B?MEw1MHhrN0lSVUtOWVlwTldnNEI1WkxlOGc4dnZPUnliYW0wa1B6VzZoRzZ0?=
 =?utf-8?B?bG9KUU4vMTloZHdLczMvT0ljS2FiWHZDWlBCYXdCaDhCWnBKcm5tKzgwTFAr?=
 =?utf-8?B?ODFkcWIweDBzdU1CcFZPY2RoSGVEK2JlZ3B6YXJaTkIzeVgrczU5OVhlaHY2?=
 =?utf-8?B?TFBkMmNscnlFbXZLV1NUSVhha0pFQ2U3ZWRkTFZJTXFzeVNjVVNsSG9wemJE?=
 =?utf-8?B?Z3lVbGFqTCtOSUJmNk1wUWh4YllUT3k0NkVDcVpQZmVPU09kbHZmVm9GYlJu?=
 =?utf-8?B?azE2NTU3QUJIdlBnZXM3Y2tBdmxudVhhRnhFdzRSbkRLblpkVGJ3Tk05dmVQ?=
 =?utf-8?B?U2NLUWxHNm1wNlhMMXVJT1ZrTFZ1YWYwY3g5aUQyL0h0S0JwQUpWdGZIV3Nk?=
 =?utf-8?B?TGtacXEzdEM2bzhubGtLZ0lPdFNWMzhXVVh0YWc1RndRc29lOEQ2V2hEVjY3?=
 =?utf-8?B?ODdwTC9nbUFIQndpdUNGQXpCck52NjVFZmFaMDZRb01LTXV4dHlDb281SGFq?=
 =?utf-8?B?bHF2NTBvc3hYbWRRdFR5N1Zpd0h4ZlZySG9ZVWNabklDWnVzakJWSEgyUHVi?=
 =?utf-8?B?ZGwySFlZR0pGOUNWL1VGUnBCN2JqeCs4cHFmcGkvVnJqaGRxVVhPQnp6L3VM?=
 =?utf-8?B?Z3ZSVnpMWVVvUWtjak1Sc2VVcmxtNGxzVk10OXdYUTBqTldCWGVrZ2Z6VWQ0?=
 =?utf-8?B?RmVYRVNxWWY5dTdTa2gyNW9tbmsvSkhXbi9icDhZN2czNzR6ZHh2c3crYk83?=
 =?utf-8?B?dnNsU3BDM25jckJhMGdRNzIybWphaGwwRVhCMjl2aU12blNRcjVpRzVVTGlp?=
 =?utf-8?B?Nk4zZnNBaHpZa1FFelhMV3VFdCtmU2ZsdzRkelRGYVVOV04waXptTHBnanEv?=
 =?utf-8?B?c0JwNWt6TkZ6YXB5YWZ4TlB5c3pJVnFXR3gwNWR0dVB0ZE5oRFp0N1doL3Fk?=
 =?utf-8?B?RjNsNk5LYWo2S2dnbFFrTFZ4UFVmci9uTlhtS1R4Nndmcmo3bTVJMkplWmpn?=
 =?utf-8?B?RTMvQ0x0bG9TWm9WWnNpK0ZNZmhiaXZRUjJrN3pkV1V5ZERLRS9KU2lvTG5p?=
 =?utf-8?B?WEhwcEpnRW5TbTJUYzZFa3QxeGs0em1DRjFNMDFwUnFKaHpjNEw3ZUtTbXNP?=
 =?utf-8?B?RHYvZEVBY1NMYTVmT3hWcU9aNHBLS1crSDhTQXZpcm5Wa3hJYWVrVWx3cEl6?=
 =?utf-8?B?YUd3MUZIMmtIWjJNMzJLUGJaRUxUSkF3WmM0M0tGYzZud0hNaXBDOFBlWDNl?=
 =?utf-8?B?UHk4Z1Rjc3g0bkExMEx1VHBKdmpYWG56MHhDSVpqQldISWIrajBkWUNQdzJa?=
 =?utf-8?B?U2NnNWdtU0k1bFJ5SnFValhZanQ0WkRjT3dMZ2prMTVXSFlmM2RqTHZlWkEr?=
 =?utf-8?B?NDFMcG0yaHpTbTlFalhVcUI0KzE1bnlKcUpmZTBYUTVuMkRhb2NmSGx2Q21D?=
 =?utf-8?B?KzU0aERGdy9EY2Q2QWZqUnIyTFltaGZCdmRBZkl4MldnTGtFV0hxeXYwM0Zp?=
 =?utf-8?Q?d1vTR/mr7zcu2TJdpv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e820acf-6532-41cf-aca4-08de5758456d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:42:56.9864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy4sfZ4CHsrTtLIAkoOLEdr1cf1gxGiySuK4ynYHscj2rNatWLeronUbdiQBzHbG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022
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

On 1/16/26 17:20, Alex Deucher wrote:
> We only want to stop the work queues, not mess with the
> pending list so just stop the work queues.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 362ab2b344984..ed7f13752f462 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6310,7 +6310,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>  			if (!amdgpu_ring_sched_ready(ring))
>  				continue;
>  
> -			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
> +			drm_sched_wqueue_stop(&ring->sched);

I'm pretty sure that this will lead to memory leak if we either don't manually free the job or return the code to insert it back into the list.

Regards,
Christian.

>  
>  			if (need_emergency_restart)
>  				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
> @@ -6394,7 +6394,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
>  			if (!amdgpu_ring_sched_ready(ring))
>  				continue;
>  
> -			drm_sched_start(&ring->sched, 0);
> +			drm_sched_wqueue_start(&ring->sched);
>  		}
>  
>  		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)


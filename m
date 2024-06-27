Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542C8C30653
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 00:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAF810E15F;
	Thu, 27 Jun 2024 00:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H15xuuXq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6A510E15F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 00:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A67PSDEPkS1W3IGn9EU4QBIJsCZJcI+xeUICD0KlUxsFSoVwW00INIJbrXG7J7Xe8/leiFPoOWKC1UL8sXGxA8eDCOEM0j1oCOc+CrNjcbyVvd2NjU3fBSDXzqluefZl8XYsjSKEGHvmYdGJrw+D1iMZ7GGB5pABEgKZWPHrOmoUlaGQ23pJkHnTfsnSWmFRctHky5AIIk7wzjqQb4mPQQiLXy1V8HOnlTXg5ykjdKfABRQObJNUz5x+tzQiCK6mt2+yNoZ3zRMamTHcQq5OZVbp7yrjy1pLbJmp6zKWUceFpMDxWcZ+eMtBlwrKhBCSFbnUNhPo3GoYbBULk2/hWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2aDd9VRhFu5L6DKZqohk7wg/1tg4cBNvswMKZuSNZM=;
 b=Ss7QJkyyibS+Kb6V1QMs7B+wtB/NMTeQURzz7Gt1R7DVblbtzpObmg2I7Cz7tytmjhfw2t23k8A09gt6dVpSIZzzEC4olxEXFpb3s88g7W4fNHcwb9HO3+7ikbM7DYtz5DjIIMDfBX76n79ZqnMMNp7D5ATQqXyA6Ae8aw5XToozTcRBMHOS9lgF/RtYykMoj7JSWlEf1g0ciOj/wojRPAz8TX+Z5UN7cLYD6LWcd9wtxAJTvXFtmFEk5UhX2ugeZeJ0yKeUrPtFDaVJFmo2Xc/KcC9uSYQdl6znnzS4a5ugaIUD5aRipormQm6ZW+tnoeAw9YELg7aLMR38tM+9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2aDd9VRhFu5L6DKZqohk7wg/1tg4cBNvswMKZuSNZM=;
 b=H15xuuXqXgxGwyajcVdqCKR2CgpD1Webs73/rJs52F7/TQmNZcppE1dtoAo8t55TEkIXGvZRCWqj8uGwFvaD8wvrGtP9CKiqIEmCSfoNCPKjKUo0LOaU9Yu453p3XrgnGHh3dlIYry4kqQctNUTelenonFkDmzg3JEr7gF3fJTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Thu, 27 Jun
 2024 00:30:30 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e%3]) with mapi id 15.20.7698.024; Thu, 27 Jun 2024
 00:30:30 +0000
Message-ID: <3f71a531-e9a6-4e76-b268-cc9b5dd609ab@amd.com>
Date: Wed, 26 Jun 2024 18:30:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Fix null pointer deref in
 dcn20_resource.c
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com
References: <20240626222831.691600-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240626222831.691600-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:408:f6::13) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c581155-47bc-4ccd-268a-08dc96405932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bURwdVliT3lTeFFmVFhTbTFES29tbzgraFoxUkJYamJ0UUFuaEhLU1dMKzZk?=
 =?utf-8?B?UjQ4VlZmSElYdG0xMUNGTXN1Y2Jtb09BbERXZGk4MkNRME55RXZ0SWFyNXBh?=
 =?utf-8?B?aHZNKzlVYnkwNy8wc2JneUdRbjcraE5lZ1phRXN4Nko3eUp1djJ1VVZaZlJK?=
 =?utf-8?B?eEFtVy9LR0JXZ1JZYTVLdXRTcVgzME9PWm5SYWpDUVp5Wm1pNjlxc0hzMVJU?=
 =?utf-8?B?SW9FYkh6M0x4Q0gvSlI2YXUzTTQ0eGduc2NUMHZjRm1RTEphbE5HTVdwTEpE?=
 =?utf-8?B?Zy9kc2lUZU9HaXBQTUlKVGRVbXp1OVRudG9iTFJUMnRtNGFsOTBrL0lGdkdI?=
 =?utf-8?B?TFBHWUYwYVBqditYOVpMUkg0cXg3a1AwQVdKbENscGpYdjVmSDBVREhlOHhQ?=
 =?utf-8?B?VjFKdHEveDlLTWF5aUlGS1ZhaTdES09CWFMvcGNINkVubFFEbUVjQ29rdTg4?=
 =?utf-8?B?THErTWhhSXlEQU8zUitaNmF3bGRaTURKb2R3TGw3bVFDeEI2czVlMEQ4aG9i?=
 =?utf-8?B?S240Z1lKSENiTFhqMDkwU1BZYlJnNnYxNmVUTEc3MmNDaU1SSFpGdVcySkMr?=
 =?utf-8?B?b3kvdWpneGFEQzlxVVhadHd2eGVqT3E3V0oxMTgwOWlMUml1YUV5UmQySGs1?=
 =?utf-8?B?NHZuV09QbVFkRW82VGRWaGJ6ZktUYTAvaHNXc1VTYnRqR1VxOWl4V3JaVWFC?=
 =?utf-8?B?VWZmSElSZUFpbTIzSG43NkQ0V1VWM3R4WXFwNVhlcXdZeGkxWGJQSm5pcXNI?=
 =?utf-8?B?OEliNlFrNnllNUNsWi9sdHZYVmorYVBaUHVLMS9DWFhaU0FSZFZjZjMyVjl0?=
 =?utf-8?B?T3ZGNzErSEJ5aGcxbmRIWHU5RjY4dkJSaXRSdUJqY3phTUdzSkg1OEtlZ1Ru?=
 =?utf-8?B?OVh0N2Z4cU9wTGRBb0NXdU0yR1QxODlCR1N3cm0vWkx1SXJBeDJDZWR0TGFM?=
 =?utf-8?B?V216OGZETlFSeWEvQjcvSThlUUZWalZXWXlwQUp4bktvTjU2TzNHY1VSOGVU?=
 =?utf-8?B?ZWxVV0RUU0QrdHB2bUZlSHY4aTRIUWhJbXVRWFBYZUFiN2NOcmc5b0tWZDAy?=
 =?utf-8?B?enp6OWd3V2kwaDA2VnBqV1JHT3ZvV3dZdXZLS01ZYUxLL2o4QnRaYXBacXdv?=
 =?utf-8?B?U2phZFFwYU5yTHBReUtZZWpuRTE4YU1PUmJXc1JvU1h4OGppSU5xVUJCOWNE?=
 =?utf-8?B?R3NqNXNvY3hJWFJqdm9Bb2YrQTRmZjdKa1hqM1BmdW9aMGdRUzBYWGRzY3BI?=
 =?utf-8?B?WEpZZE14a3VhVW0rQzRlaXo0QiszMUl3L1d0ZlBMQzdIeTZzbG9rUDZOdHB5?=
 =?utf-8?B?dm4zMVRsakVGbkxGZ1QrL0R0U0ZIc1k2N3l3bm1xaVpXd0xieFltSHhWa05y?=
 =?utf-8?B?QWlpUFR0cmVmRFdYWDNrdzk2QzhERkI0SmpVYWNMZ0tIOU1ERmc5TTVuSkkz?=
 =?utf-8?B?U2J6QVBScitpbG51L2d2SjJFUzZFVm5WdFczMXdZL05NZm45SGRUa2x4ZlAw?=
 =?utf-8?B?YWhLRmVTYnRDSCtZU2ppWjhVa0FvRDIwM3VrakRCelR0a3JQWU5jamo5OC85?=
 =?utf-8?B?ZzhKSEI3dmNzQWkxVmRBc1FwNHZYdlZxcXg0MGtjamY2aW9adE03MVVYQ0U0?=
 =?utf-8?B?dUpzcmp6Q0ZiNU9EaWNFeHd4bWoyWTlyS1JEMnNueVBHQjdjMExoeENmc3Fo?=
 =?utf-8?B?MzFoajk4bXJ4QmdqSWp4Nmh0TitVQ2FRaElYdFhaN3hiWmpDTTB2VElCcmRq?=
 =?utf-8?B?ZE4ybWo3UmxhS25rWnFXSnBoZGNTaC8zS3k1cmoxOUUvSkxUczRUOUYrT3Zn?=
 =?utf-8?B?SVk0Y1BwN1FQRVQwRy9Kdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUdqWFBSZ0ZUK0RubkFGTnd3K2FxYWxyaTRNampncHFiek8waC83KzhiNXMx?=
 =?utf-8?B?Qm5CNlhBYi9JWDlTVTd6U1pMcUk1alk4M05wNi93dUdTU2UycWNRdkdZR2dV?=
 =?utf-8?B?cVNVc3d2aXpEL2xWcjlsaVBrV2hjci9yMnRoYldzSEg2RENrQWkrQi94OW5m?=
 =?utf-8?B?NEFsM2trM3Nod3lqVGpQTjdMd2FNTHJScGI2dEhzTkcvNXphaVJNR05TS3dT?=
 =?utf-8?B?dEhtcnNoTit1b0RJTVlwM1Y5MWkwMmFRdjBVOGdvblEvTFJJTzg0U2ZlZjNy?=
 =?utf-8?B?TkQ3bXZPekk3MG9VZkNxUXFraWtrQndMdytWdVNxeWJXVE5ZamEwZldWc202?=
 =?utf-8?B?bk9yc2U1djFxdzhkOFpXdEI5Z2dxME5vSGU0WGdMMlFPUWRYWUVHQXdmUFZL?=
 =?utf-8?B?U2F1Vno5SlJtTDdzRzRQWnFMaDJqcWJ0czVKdVZjZ0lsZWJXaWpxbkZDY2pn?=
 =?utf-8?B?dEtCU3RRT0tPNmNlL044WEhBM1RLdEl2STdxTENMWEMwSWZKZURkN2dPd1pS?=
 =?utf-8?B?ZXdWTEF1YWtBUG9lQTRVbFBRVDg1cElaaEc4S2ZJaVFoRTBIY0FDb1hiS0h0?=
 =?utf-8?B?dzhCK2ZvT3hzQ093QW1weEgwaVNUUEhPbjZmaHpYUHlRSjZ6L1NWbnNCZEZx?=
 =?utf-8?B?c0xHdHVUZm90QS9scEV0WjZ0d3BDaCt6cFNBSXBzS3JjdzA3UUVqRmZwRXRL?=
 =?utf-8?B?Wk04Nm1WbGhOTzhkS0YwQzVDZzBJSHlxRWplSkJNWEMxZUMyTENCTTRlM05E?=
 =?utf-8?B?NTMvc3ByeTNFcHNoeWxTcGphUXo4UEZTY3RWdUhaVTBTMXZ3Ulo2THdmaVZl?=
 =?utf-8?B?UHpLRHJTeGx4WHNDSGE4dFRrelRVQXd6b3RKMTRzb25pa0FUN1RHWmpGQ2Fm?=
 =?utf-8?B?QjVRU0VRR21LVmRsaWo2c0ROK0ZORytJUE03RWp6V21PdExEZTFHZlpqakYv?=
 =?utf-8?B?dU9yMW44OFRxcktjWUVtYU5FQWIwWHBWR1c1eHhFNE9qT0VDcExXTzdteTln?=
 =?utf-8?B?VGVoM2Nad0ZGVlBueVRWWVlmTHVZTndKdVEzYkZoaTc4V0JnRlBsQ3g0RDkx?=
 =?utf-8?B?SGI1SGhOQUo1WFcwcmo2WlNheVFvS3FmRCs2aCtZT3YyVE5jeWlLcE1VQUhF?=
 =?utf-8?B?YklDN1Y4TTdnOVAyL0pjRU51NG5ETWFaUXgxSWtIQ1lscGdvemVqWTVFRkdP?=
 =?utf-8?B?QmFsUUdUMVpSRVJDTzZMSGlObFo4bVFlVUVBeDlVdC9jNEpYSWFIRkhvY0Rq?=
 =?utf-8?B?dytXMU85bE1saWFFd3MvcnpQbVR4TkVHU3ZVYlNRWVY4TUhJVnIzazNiTThU?=
 =?utf-8?B?dzVYbndkM25vemVnYndwZ21GOVR2UzVPN1lscTFxRHVqdmZFaDhMTDhwa1pT?=
 =?utf-8?B?S0lVK0R2eUZXcEF1T0lXUjRaL3FvVlVnbHREZEt6SzdWNi9sa1plWDN2UDRX?=
 =?utf-8?B?Z21nd1N6NlJRcFZoYzZiZGFINS93S2hUanZwdWN4UXZvd3VOenNkSWF5VUQ2?=
 =?utf-8?B?aFNQajhtTTNFbTIrZThHSFVHNXNLNFJQSXpDMVI1SEp5ZDZEYWpKcHF5Y29K?=
 =?utf-8?B?Wi94RlY2WHIvZ3pzZEJQMUFySGptMkg5S2IrZHNsZEZiTmFidWFQNXExd1J3?=
 =?utf-8?B?Wm5tTFZxRm1pSkJ1eGJFNDU3NGxUOGttVzA1K1JmR3QxQVdkMGF1cFlJcHpj?=
 =?utf-8?B?bTA0dk5xK2E1eUNzQUZxWDd1QlZjOGdDeXo1S1poOXZwSGIwZnNCMW9Iemdi?=
 =?utf-8?B?cUJKYk1MOGRHTUtOVlZIQTVhUzZ3NHAvUGdYeGtnZFp0ellGRzZLcWRuUnlj?=
 =?utf-8?B?OTJFWVBULzVZUzlQNGFKZHF6cVpLUWg1NXF1YXlMOVlvdVhPNWNrTEtkQkpF?=
 =?utf-8?B?QUFyeE9VeUh1cGlud090Njl3M3paUGkyeEkwSU5xZ2dNV3l4WkVGbXN6Q0Zn?=
 =?utf-8?B?OUhnSTNMdDIvejROWjBKcHQ2b0F3RFRxbnpQMmZzZ2pQQ3BwTWQ0Y3F3TWRS?=
 =?utf-8?B?MVhkWUhPMEQ0YVhleUpsc2Z3Mm5JaHE2Y0ptaFVuZGg3RmtrKzNFbkd6dWxF?=
 =?utf-8?B?V1VZWERsT1prSE1NMWZOd2x4NXdRVitud3dRcDJaaENKekQ5OXovM2RwODJG?=
 =?utf-8?Q?b/PEHzXSAAFtberK8PnyzNA+p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c581155-47bc-4ccd-268a-08dc96405932
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:30:29.9516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 365UEiIdYs0fi27MT2mw9vc6SjDFCtftmT3//i0OiOtOdsmfODT/8ZZMUcxHAbxCWoPZg29hCKNXIg+ssegpBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
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



On 6/26/24 4:28 PM, Aurabindo Pillai wrote:
> Changes in v2: detailed description about the how the issue is
> reproduced, and remove an extraneous else keyword.

Just remove this 'Changes in v2' part, with this change:

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

> 
> Fixes a hang thats triggered when MPV is run on a DCN401 dGPU:
> 
> mpv --hwdec=vaapi --vo=gpu --hwdec-codecs=all
> 
> and then enabling fullscreen playback (double click on the video)
> 
> The following calltrace will be seen:
> 
> [  181.843989] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  181.843997] #PF: supervisor instruction fetch in kernel mode
> [  181.844003] #PF: error_code(0x0010) - not-present page
> [  181.844009] PGD 0 P4D 0
> [  181.844020] Oops: 0010 [#1] PREEMPT SMP NOPTI
> [  181.844028] CPU: 6 PID: 1892 Comm: gnome-shell Tainted: G        W  OE      6.5.0-41-generic #41~22.04.2-Ubuntu
> [  181.844038] Hardware name: System manufacturer System Product Name/CROSSHAIR VI HERO, BIOS 6302 10/23/2018
> [  181.844044] RIP: 0010:0x0
> [  181.844079] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [  181.844084] RSP: 0018:ffffb593c2b8f7b0 EFLAGS: 00010246
> [  181.844093] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
> [  181.844099] RDX: ffffb593c2b8f804 RSI: ffffb593c2b8f7e0 RDI: ffff9e3c8e758400
> [  181.844105] RBP: ffffb593c2b8f7b8 R08: ffffb593c2b8f9c8 R09: ffffb593c2b8f96c
> [  181.844110] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb593c2b8f9c8
> [  181.844115] R13: 0000000000000001 R14: ffff9e3c88000000 R15: 0000000000000005
> [  181.844121] FS:  00007c6e323bb5c0(0000) GS:ffff9e3f85f80000(0000) knlGS:0000000000000000
> [  181.844128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  181.844134] CR2: ffffffffffffffd6 CR3: 0000000140fbe000 CR4: 00000000003506e0
> [  181.844141] Call Trace:
> [  181.844146]  <TASK>
> [  181.844153]  ? show_regs+0x6d/0x80
> [  181.844167]  ? __die+0x24/0x80
> [  181.844179]  ? page_fault_oops+0x99/0x1b0
> [  181.844192]  ? do_user_addr_fault+0x31d/0x6b0
> [  181.844204]  ? exc_page_fault+0x83/0x1b0
> [  181.844216]  ? asm_exc_page_fault+0x27/0x30
> [  181.844237]  dcn20_get_dcc_compression_cap+0x23/0x30 [amdgpu]
> [  181.845115]  amdgpu_dm_plane_validate_dcc.constprop.0+0xe5/0x180 [amdgpu]
> [  181.845985]  amdgpu_dm_plane_fill_plane_buffer_attributes+0x300/0x580 [amdgpu]
> [  181.846848]  fill_dc_plane_info_and_addr+0x258/0x350 [amdgpu]
> [  181.847734]  fill_dc_plane_attributes+0x162/0x350 [amdgpu]
> [  181.848748]  dm_update_plane_state.constprop.0+0x4e3/0x6b0 [amdgpu]
> [  181.849791]  ? dm_update_plane_state.constprop.0+0x4e3/0x6b0 [amdgpu]
> [  181.850840]  amdgpu_dm_atomic_check+0xdfe/0x1760 [amdgpu]
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../drm/amd/display/dc/resource/dcn20/dcn20_resource.c   | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> index e783afbbb397..5e7cfa8e8ec9 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> @@ -2200,10 +2200,11 @@ bool dcn20_get_dcc_compression_cap(const struct dc *dc,
>   		const struct dc_dcc_surface_param *input,
>   		struct dc_surface_dcc_cap *output)
>   {
> -	return dc->res_pool->hubbub->funcs->get_dcc_compression_cap(
> -			dc->res_pool->hubbub,
> -			input,
> -			output);
> +	if (dc->res_pool->hubbub->funcs->get_dcc_compression_cap)
> +		return dc->res_pool->hubbub->funcs->get_dcc_compression_cap(
> +			dc->res_pool->hubbub, input, output);
> +
> +	return false;
>   }
>   
>   static void dcn20_destroy_resource_pool(struct resource_pool **pool)


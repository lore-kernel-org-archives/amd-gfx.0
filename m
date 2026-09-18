Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D22C982DA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 13:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5AF410F384;
	Fri, 18 Sep 2026 13:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wbu1zwfi";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A6FC10F384
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 13:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmdAMQ7/cbGxLtSDVICmm2SfbwcranZ2LU11lOysBSZkM2GtPwBi3ePataRg1ydSpc1kZTN31uwe1+D2CmW/hWAdeLv7ANGtzKhrpfIM+lLd/UMAjElYErECekwjLndwsc9mwcGTpxUaQLBE5cZHXO2ZGEBAOgetGP+tg5JPvdwQbO8W1qcn2syzi9R7i552cf1ooxXgcv/Lf7REpoiv7IET+KaiXyepGKFE8f4z8feB4B+VtWurDu7Qnl4SR+P3oYMkKjMCpGGhOjYj/aYut/afYl754+blERLVSHZljDGIQaGASobKve2PiajFTet7lEJ2g/yHrGPYlvv9+PXHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A657B6+YjseASIaL6k1gAR27XBA0lv0UPyOYsM266cM=;
 b=T5nLOJ/jEFrkF0o7OdpPddW5/6NAXXu2nOujNVHPEFLrRCe2mgkazWq7M2FR3jy9RzmpHe9xqVjv4tvJgPtaAX/1mOUy/3G/AQW4PAPzqg1HmHLS6dRrj2Mp/o0wfNwhxOzO5I8mS09nV2T0zxlvgoib6Dj5zHbzILaxRNHU342OPiEvyGMkt1GJlS/f/Alih5qPR7L8oLT9avaIEkAlUIAHV/rtAtH8Tod1A34ey0Ovj/vm3SZFvoAmIdmwS6iRSm7UX086qyC7VaIMtnemnNIWqxNNVRgqrNv7KFwTixxqCItA6inR7ghQ+ZRsmLxMRRUPvMiHOfKNp671kRfO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A657B6+YjseASIaL6k1gAR27XBA0lv0UPyOYsM266cM=;
 b=Wbu1zwfidd+yeSKQXsEmgKubdByD+gQbpASVfhi6vxBxmGQLIAgjB6DxK4X6zpPdmBrfZVWblYegrd63Qbrf6c7bQc7W7QIzq+Rkt+RIgPb1n+I/tVt2D1LA8wbrSuV8t0iqA16/uIXyMUe1wqDJJS9sYzGsv2HxtXzWFbPymgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 by DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 13:52:19 +0000
Received: from PH0PR12MB5607.namprd12.prod.outlook.com
 ([fe80::26e0:df91:f91:c41]) by PH0PR12MB5607.namprd12.prod.outlook.com
 ([fe80::26e0:df91:f91:c41%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:52:19 +0000
Message-ID: <f53a9745-3e08-456e-91e1-22046bff80af@amd.com>
Date: Fri, 18 Sep 2026 14:52:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Preserve v1 in gfx12.1 trap workaround
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Joseph Greathouse <joseph.greathouse@amd.com>,
 Vladimir Indic <vladimir.indic@amd.com>
References: <20260918021342.2566402-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20260918021342.2566402-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::18) To PH0PR12MB5607.namprd12.prod.outlook.com
 (2603:10b6:510:142::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5607:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cdc00c-2b23-4229-5561-08df158c0e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: UHTy8BGKY1BXKAuhuZa2em1A1gObKsfNxCn9hmzhPsAcoU9NkZki+I47WNHjGkBQoGZVE2QePikNgBEMnT0iWQd7WSA2CmGSCugveaj2UKKSpiC5nSvZoXXgXG47cjPYlawX+4KUnOLvhcyuhcvWDL1a/MJoQV3J7o46ZTsKpPjt4brBc5igYgWD4g4nQeE3JL3AR0XvoUIxQAirlQ/0DUHFZ5YfPR/kEb47UrgVuElEuyXi9rk4Ow7+ZZg90d0cVmRH8FwJvQ9UTMp/kn37OngYvC03FJarbW427oucTC3pu+ukq6/amvk2DjBNT/9Fm2r8BM/DrbRQFg7iSoI/jXi9s9LPOkqPcICYH+59Z/5R15gG7CgjH9VnqNDkj7sTvgRZNNGCNJMNLYxwdbu+xQ1wtXGTGVgy8ojgqpeKcFxgdn7Te92tGRUoUl+wrBxlXBf+/41SswmedusHqEvt7eMD6LXA7uuGnc5miaktNM7I27va4+QHXu+80MW85GbqvT6S1xR4I9akUAD6pknlg2RmihgGJzjvDBSlkuonFKvYTe1K+FEL7qpDoWna6A5jJyrqa+nvx8UEBpZYWLvGhO7mGSzJt1hjBWfEm989nMFaZIa1fj7s+REdqET+0pKj9jtfvwZuLd1iN6ALPH/lsXzZ7a4M1oPlGkDDzPLJhw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5607.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnZ4MllpL3JYSkRKK05NWmNaWjBtK2Q1Vml1WTNtWHhXNzEyYk1ObHN3RDBH?=
 =?utf-8?B?M0V2aEZYbzRlU1FEWGU2SlZJdWU3WnQyS0kxZll0dDdRMkNYU095YnRUQzZn?=
 =?utf-8?B?UzMwdEJmTFB2STI5ZHhEaDlNOW1qcXBUMHQ5Rk1vbHFiNlkwcE5uSld6MjZC?=
 =?utf-8?B?TlhjVzR5TTEzUkl4NW9xVHg4NFl5clBEaDc4ZG4xeXdkdTNmcE8vazNqaE9O?=
 =?utf-8?B?U2hlUU9LSFlFcWQxRHdaN2RiMEFyS1p1L2luL1FUMHJUdXlJVkZlcE9hTDBN?=
 =?utf-8?B?RG1DK2VFU0U5RXBPd0E4eVZESWZvVU5QZlloRnZGVXJtUUNkcmh0MFhtY0pw?=
 =?utf-8?B?VFZIcEIvWjVFVjlsbjlNNmxqUlRPVld0SVh2a096NGhtVWZyd3FEbVBCejVV?=
 =?utf-8?B?eU9GUVJ2eHdhQW1XMDF3UUY1WlFtU041UlVFRnJncEZBNmdzb1dDOVJQbm9O?=
 =?utf-8?B?NmJlWnZjQi9JRFZIcmc4bU1YL0paUGFFcmw1S3R6MFNkbUM4clk3T3ViUm41?=
 =?utf-8?B?NGlHbE5kTXBBRHpsSU1lby84N3hocHdvYkFaUFMvQWdsZk9MQTBsMGdZSG84?=
 =?utf-8?B?Q0NiNW5kTUt4SWdRdkFRWlpQaEJlQkh5eHhLazhmUzdrWEJFMHAvQzRya04x?=
 =?utf-8?B?TE9NZnpYb0ZWTlpFcHMvdzlaMndrTlQ4SUl2WG82d0tqZGZzQXRJYlprVWZY?=
 =?utf-8?B?UGFSZkVFU3pSMU5pQXZUbzJhK3FaUHREalkwQWdrcHZXUk1CcjZOZWpRcXVl?=
 =?utf-8?B?ODVsbk92cXoxRDJTKzJncisvSzNLdTZZbDRqLzdZOElZWStFbDJCOVFUbzE3?=
 =?utf-8?B?cTJFUGlpU0RjQ0d3c3IwR0hmczh0S0p3azIvQjVyR0hCM2xDVHFMQTRGclhh?=
 =?utf-8?B?RTVxNDFNQVdodDFoY0NMMTlXb1hqVU1qWVdzYk5veUREVU9ORzJIc2toOGJR?=
 =?utf-8?B?UE1COVlnYWN4dndjcnFJdEZWaU1jK0RFYml4L3VZZE1MZVZxZWNHWFd3TWdX?=
 =?utf-8?B?LzdPaklJSnhtcHFFS1d2MU5FdkU5MlRzWE04MldEc1pzZVNjUC9UM3M2S1NF?=
 =?utf-8?B?bnBHQ1c0R2FLdTVjeW85WkFWL3crbXJZVFJZWFFkNUIxMEpXcG5ZQ096M2Fq?=
 =?utf-8?B?VTd5VHg0V2lZVXhJSHRiZDBnWlhGdGtCZ3ZTdmJoWjlKQXU2bHVwdTNycTZ3?=
 =?utf-8?B?bkc3LzYzR2UrdzZyMEU5SjBndmJKNVZpVlNMandEV0dHWWEzMEZmZyt2RmhI?=
 =?utf-8?B?anRnZDJ0TUdYQi8zQ2IrYW1XYUFvQ1RIZ0FKMWdZOXMyc002LzArcjY4WWVM?=
 =?utf-8?B?d0NZeXdsRi85NTFNbXdyWEVFWVZGVFhrdlJyYWt1QitFbzBRaHB4OHl2Y2J3?=
 =?utf-8?B?dlMyQkRocWJyTDE4VEJKdzVnNzhkVnBic1FKd1JqY2Rvd3dLSVp2VW4ya3BH?=
 =?utf-8?B?ZXplUHZLUFlqbFZxZkorMGlpZGRRZ0Z5dkhTRFBkRjBHdEUyS3NRK1hsdjFF?=
 =?utf-8?B?Lzczb3h5M0E1SW56SVp4aWxoS3FuTVJsSzdJbDNlT0RrME9WdSsvTFh5UzNz?=
 =?utf-8?B?azM4R0t6Z0t5WHRzT3gxMXlOTFdqczVPakpTV0dmU3dhbTlVaVVMWW1ZQkRj?=
 =?utf-8?B?by9wZ3Rzd2prZUhPaitESCtGcFl2NGRNa3RqNGNaQXMvQ0RJNkRHbWRWUWtx?=
 =?utf-8?B?eEQ0ckRxNVZJSmlPckZBMWtDMHVlaDBqNklLUFpQL2JEcHpSUmMxbE5JMWps?=
 =?utf-8?B?QTBGdzBQdDZWVHFpSXdsQmNFajNHY3dzSHg0N0lRVWh0ZkN5dU9kS1ZyUlY3?=
 =?utf-8?B?eVpRb1FZekJLb0EwUWVJRkd3YzZFalNDUnBpM0lGR2Njd3I4Ky9zME94OFpX?=
 =?utf-8?B?ZVEvSWttQUtGa3o1aFROTjJtVW94U2hDWFh1SUxtaWVBVHdUN1FpUkx6Tk1v?=
 =?utf-8?B?dDBldmFyMWxVVklrZnZoRGtPMmxQeEh1WHJwNTExT0FCaU5NbWRqeUtkOE1R?=
 =?utf-8?B?YkpxT0xWOGZWUVo5cDQ3UW0zdXJwYjVoUkZIaG1MbFF2WU1zVFNlSE9kTzRU?=
 =?utf-8?B?VzVSM2ttRDdKb29uelF5UmNYN1UvN3ZzR1U4ZmpSaUNRejNVbHZPVXAzWFNk?=
 =?utf-8?B?TmdIUS8vL1d3dTBTMGl5QXVra0VRUENlOGZlY2F0T01FR05jZ1BoanhQRHF0?=
 =?utf-8?B?MEorUEkvem5xVkFqOFRKdUxTcGJoUUg1TG9lOHFNdHRQbFQyWSt4cmwzd0VX?=
 =?utf-8?B?b3AxZzhBdTAySVkrSE0xWjM2M1hTTG5rcFkrZElqUjU4aEJFbXZ6TDN3a01L?=
 =?utf-8?Q?VhWdk8rnTkQhsty/Si?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cdc00c-2b23-4229-5561-08df158c0e84
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5607.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:52:19.4954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BzFd8TBzdsO8rtRV784aC0IizlxkRKw5DZr2KipHUTeQRv9ftMfrD4hT4wEZEdjXPSlZrlDsTkdH4ht5qaVyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746
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



On 18/09/2026 03:13, Jay Cornwall wrote:
> If MODE.DST_VGPR_MSB != MODE.SRC0_VGPR_MSB upon trap entry then
> v1 would be trashed.
> 
> Adjust workaround to prefetch random address 0xFFFFFFFFxxxxxxxx.
> This is unused address space on gfx12.1 besides the TBA and TMA
> which are harmless to prefetch.
> 
> Also remove unused WAVE_START exception handler.

Hi,

This looks reasonable to me.

Reviewed-by: Lancelot Six <lancelot.six@amd.com>

Best,
Lancelot.

> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Joseph Greathouse <joseph.greathouse@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Vladimir Indic <vladimir.indic@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 16 ++++----------
>   .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 21 +++----------------
>   2 files changed, 7 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 8cf3527dc156..73889430d2e4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -4601,19 +4601,11 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
>   };
>   
>   static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
> -	0xbfa00001, 0xbfa003f1,
> +	0xbfa00001, 0xbfa003e1,
>   	0xb0804009, 0xb8f8f804,
> -	0xb8faf811, 0xbf0d887a,
> -	0xbfa10008, 0xb9800211,
> -	0x00000000, 0xbeee0180,
> -	0x7e020280, 0xee17406e,
> -	0x00040000, 0x00000001,
> -	0xbe804a6c, 0xbefa007e,
> -	0xbefe0081, 0xd760007b,
> -	0x00010101, 0xbeee0180,
> -	0x7e020280, 0xee17406e,
> -	0x00040000, 0x00000001,
> -	0xd7610001, 0x0001007b,
> +	0xbefa007e, 0xbefe0081,
> +	0xbeee0180, 0xee17406e,
> +	0x00040000, 0x00000000,
>   	0xbefe007a, 0x9178ff78,
>   	0x00008c00, 0xb8fbf811,
>   	0xbf0c877b, 0xbfa20002,
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> index 233ed8b6d122..9d54a77da6cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -246,28 +246,13 @@ L_SKIP_RESTORE:
>   	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC
>   
>   #if VMEM_ON_TRAP_ENTRY_WA
> -	s_getreg_b32	ttmp14, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> -	s_bitcmp1_b32	ttmp14, SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
> -	s_cbranch_scc0	L_NOT_WAVE_START
> -
> -	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT, 1), 0
> -
> -	s_mov_b64	[ttmp2, ttmp3], 0
> -	v_mov_b32	v1, 0
> -	global_prefetch_b8	v1, [ttmp2, ttmp3] scope:SCOPE_SE th:TH_LOAD_RT
> -
> -	s_rfe_b64	[ttmp0, ttmp1]
> -
> -L_NOT_WAVE_START:
>   	s_mov_b32	ttmp14, exec_lo
>   	s_mov_b32	exec_lo, 1
> -	v_readlane_b32	ttmp15, v1, 0
>   
> -	s_mov_b64	[ttmp2, ttmp3], 0
> -	v_mov_b32	v1, 0
> -	global_prefetch_b8	v1, [ttmp2, ttmp3] scope:SCOPE_SE th:TH_LOAD_RT
> +	// No-op prefetch to random address 0xFFFFFFFFxxxxxxxx, faults or hits TBA/TMA.
> +	s_mov_b64	[ttmp2, ttmp3], 0xFFFFFFFF00000000
> +	global_prefetch_b8	v0, [ttmp2, ttmp3] scope:SCOPE_SE th:TH_LOAD_RT
>   
> -	v_writelane_b32	v1, ttmp15, 0
>   	s_mov_b32	exec_lo, ttmp14
>   #endif
>   


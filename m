Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313F2C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D404B10E4D1;
	Tue, 30 Jul 2024 07:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLOaYm/9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BE610E4DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a37PVDr2fyqL3gbUicrAxPX8TgrBJM74yTFyPaRHdKBVcEzIz9OTyi14UpdKRoYjfyzynp5zeArd//DAZN0iLTfATyPY4GmVjmmnvLmYLbhr+YmT11M27bViGN04rFEEq3Kv+jW6lh4fSGj8jY3XhwlgSHhdaMBl5Dz8I1g7FiKvuRtuAuLvfPVoX4wba7c/6iWMpv+tmWCTQtm/yGmCgO5P1pju36ctnEOWwYnDHrAwEv5XOi8BDqk1YRiy/tHVKJRFBaUOvSbcZrunctCPTsFaAVgF6eKPUOR05AC+KzmT2ZYPNJAEDv1t5VyIRbIu/gT4XEwLwSI1Z9gIjjZDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG7ek2IWJxv64wFUj0la4NSf1ySFyWF9RjDABBX5IJ8=;
 b=crNO7X+zajCfIBoAEiweG+QvhWsuySINFreC3voQPLsQMAU0bt6tDXukNcEC2cA5HPx8NRmzIHfj9LXCSEGpefGcLrz2Lr6YdEDAHtYxtfg9LY+Y66m33jqK1uDRDfc9J/axrIwgcSY3KP3F7boH+yha3On5ukzPGJ79JI2mnXT+okSRtgB2o6o4HoDIHfNeZoL/Vq3dG9qBw6on4c/zr3uceRNggRGWT18VKaZR4tYbTAmf7eqH4OxXNqak/84l/4EX8KnYki6Y6y/qCGoAudeLsNaA20SUhRmAooLQWqH6dp0a5SKxKWsjqVhkX+n1jibCcGKzrnNf0U0D5ItZ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG7ek2IWJxv64wFUj0la4NSf1ySFyWF9RjDABBX5IJ8=;
 b=bLOaYm/9XIZL6CP2rAh3TrTN3BUTdd9ehZns550eo6EviZTwbR8OaPp4u+VBhwYYX6/rEr9mYEH1AByqiSXTG2FSVfDTmiT0JqkxkPg5IRXBpNKeEL44q0gFcqt6WJn1HjtcGMHQzBHNIlFqyd/FU7HK8TrmJee09s8udn2y7H8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:41:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 07:41:09 +0000
Message-ID: <5c94749d-1364-4770-a00c-4e1c6e4d1d55@amd.com>
Date: Tue, 30 Jul 2024 09:41:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add support of burst nop for gfx10
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Pelloux-Prayer@rtg-sunil-navi33.amd.com,
 Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240730052156.4135143-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240730052156.4135143-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: c969d723-0637-4625-2980-08dcb06afa0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmxtWjMwOFBxUjIwb0xvVjBtalRwYS9xcEl4b01RRXh6aWV3c3lBV1BXSlRJ?=
 =?utf-8?B?Q2w2MkZBVU1WRVdOZmZ2ejdrT1JVQ3h6eFJLN0hwakxIZjY4TGh6eG83UklX?=
 =?utf-8?B?VWF5cStCa2N0SktSTjRPYVFMb21abC9LN0JpWklKcVdFU0l1YjF0NlFVN3kx?=
 =?utf-8?B?S3h2c2dqSkRXNnI5b0Q3NitDTTdWNGw4dUZXUTU2SENnb2ZidHdha3VpR1J4?=
 =?utf-8?B?L1RpMEVqS2tpb2tpNzJqT3BRZnhDT1BtY1ZRL0ZXZ2g2V3dubFBSelUyQWdU?=
 =?utf-8?B?eWhubDcrQXJrRHNFQTNnMzNNQUZaT1gwZ0tXcWdVQ0haeHVNbjJFMkRQWkJX?=
 =?utf-8?B?YUgyYWo4OUFDVXlQYzVJWm9EK2Jnbi9LS2ZtVEd0WFRnYkFGMTBOWUEwNlc5?=
 =?utf-8?B?VmliQk9kZ0hEajdiNnM3NzdNMFN0amZjMS9IY3VGK0hPaW1VcUVoSE1KSjdY?=
 =?utf-8?B?V3ZOMSsvV3AySmlqTDJma2NvYytwZjJKOTNpTkpTeXl5ZlhjVG9iZ2hxV0Q4?=
 =?utf-8?B?cFZlQXVCTkpvT2NJcEFRVTJ6d1E0TU9CWVpva0NLMDdnV212UTFtU24xNGlT?=
 =?utf-8?B?Mm5RKzljTDVoL3pqVGFMcy9KeHRPa2h0RjZlaTFkOEpaOStxS1Btc2NTS0pi?=
 =?utf-8?B?WEt6UlVzOVgwNzJ5cFRnZWIwdXZ6K0phZWFvaUV6UHNRRTRjT3JxR0VYZlNn?=
 =?utf-8?B?a1JoQ1plVkZxWW5NN1pUbmZGVzFkT1FUOEx3dlZZbVpsbmc0NlZDTmJJTS93?=
 =?utf-8?B?WGV4QU1yRldPTXUyc1V3OE5DSCtzMlhrcW5PZmhPUzQxZEtCNTUyYXlYVnFH?=
 =?utf-8?B?SjlGL3g5Q2lPbkoxdnBOMzgybTNJeGxYT2F0d25CbkxPaUM1YUovQ0VGTUhm?=
 =?utf-8?B?dG5GdUpDU2Z1emNUcjBDVUlWcUdsWUxvdThHYzZpVmREbHl0NnNFWjhoZWs3?=
 =?utf-8?B?eWRrU1NLV1hrR3JuR0dmbENERkQ5enFmUy9iSzhRNFhnQktlb2RQekVtTXVK?=
 =?utf-8?B?ckp0SW1vM3V1OFpDTXRyT0pIWGphTHJhV3dGVVppQ2lYYWRicDlwVlNSTHNl?=
 =?utf-8?B?V3djSElOSEdVTnJQcHh1SktwQythZnRiOGJuYS9TSGFIQmJiS1V4M05xTEhM?=
 =?utf-8?B?cE1LTzh5R05jNWZ6STRIV2RaQmFuMnkzL2k0YWM5UzJOdkVBM01LeW0rTkZu?=
 =?utf-8?B?UmdxOUIremRFYk1FTy9Dc2hOVmNaaktPcTJvdVI0cXlHc2FTajR2S0dmQjV6?=
 =?utf-8?B?aWRiZ29hcE1vZGJUSFZXV0lhaTJhV2hlaTFpdGZNRHRHL1VlZHd5NVBkalRI?=
 =?utf-8?B?YmFXNEVkODY5ZHlTSDJ2YThwdEN3NGFTN1ZtZldncWxkV1B3ZjJXa0lGRGov?=
 =?utf-8?B?b21NS2dYNkV1d3poeVY3Ni8zZTlKQzFOckFzT05RVE1VakZkcW5XSXBlV1Fj?=
 =?utf-8?B?K3laZVFNdFcxRVVMMkdCK0U4dy9lL1NFemdCV20yaVhwaWlSekxlcGpMNmE3?=
 =?utf-8?B?QnJBbE80UU5CTjVFbDVWcXFmdlU0WTNOck14QUp5S1ZmYVloLzBadGlndFEr?=
 =?utf-8?B?QmNGTjdRcmROMERtQ1BzUEplRXBKRlR1SzBJTkhiOUZiNTZtV09KQmtuRzlY?=
 =?utf-8?B?VDh4eW12TExpdXRXV3VyN1dWUFZHWVlETHRtZ04yenJNTk5FTVF3R2hSbG1h?=
 =?utf-8?B?bkNtdzM3V3dXcVVBaTcrMGk1N0t0S1J6cFZ5MUNLZVJLcFEzUGZKTGJJYm1v?=
 =?utf-8?B?dWltRjBGT1FKOGlXNUc1bEQ0eDVMUENVcUsrNjlHUVBBVjdCdVhEOE1mWE4y?=
 =?utf-8?B?Y3ZMS2hpQk9weGE2V2FtZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZhcC92QkdwZ0RwOXMwTkFEdkRCd21ZbEtoZkhRR2c4KzlMQUI3TUdCcmVt?=
 =?utf-8?B?MUU4S1E0aUIyVURlcWFYQnJoY00xSktmdkMvZ0JDT0FHRnJaRnhjM0tpaEho?=
 =?utf-8?B?K2Q5bTEyZEt5S2dMVVk1Y1ppL1ZoQ2hWRHg5am9ZTUpVbHZCMU42NWJnTWtR?=
 =?utf-8?B?T1BOdDB2N1k2RXliYm1PNmRxNlNYK0xoY3lBWnYvc3BWNHpJQzZrdEFmYTBs?=
 =?utf-8?B?dHY5VjRsT1V5YjkzU0lHdmpnWXU1ZUNFVzI3QkNHb0ZNWUhJN28zU2YzVG5O?=
 =?utf-8?B?Q29vNFUrQVlnWU5YOXMwUkZib3ZNbGJkanV6TzVpdDFISE5TcEpuTGtXeWpM?=
 =?utf-8?B?Nnd0YWJZdWtBdHF2OEpuaTc3VjFFcnJqVTJQK0NzT1FoREFyUWQ4cWhuNk9j?=
 =?utf-8?B?T01NbWNyNmcrREFWRDM4TGZoRTNhY3E5WkdtcUV5WVZ6L3FtbUVZb3pLRTRG?=
 =?utf-8?B?SDNYZ0czOTdQdm5Fb21xMXpUM0VpUzk3V1ZVam1Dd05ic2h3V0h6WHpqSTJK?=
 =?utf-8?B?UHVXSWJXT2kzajJ2STNyL0ozU2IzMzhFS3QrS2paMDVja1RaRVFNUzRFUkNI?=
 =?utf-8?B?UFpmd014VUROK3RFSmUvZHROdThzdXBvNGdEenJXMzdCVXdYSUZFN1NvM2Fx?=
 =?utf-8?B?KzBZNGVCTUFjZmo5VGRPUGNvWTNqVFc3c3NSVTVvV1Z1MjB2cUVFWnlneVNF?=
 =?utf-8?B?RVBFZXh4R2lEWktCNFkxK212UC9BOHJRWmUzcWt4M3BZWThsNTZLd1F0eXpM?=
 =?utf-8?B?MUtyNVhjZVBxa28wUTRIUFllcnpGNTZvZERCeXNMUG9Fc3d4WjNIQVpLdFZL?=
 =?utf-8?B?bGNEa1EvMnA0L3NYZC9xaTdkcGRQd1dOS0MvVUpxNGZabzVqeUNjTm16eDFZ?=
 =?utf-8?B?MTJUSXFUTTJsY2lyQWdzUDMzUTB4WDFzUVlBc3IwVDBhWDQ5OURnVUxmNzRT?=
 =?utf-8?B?Z3h2cE1YZzFzeG0xYU1sa1NhYVpDMW1NWjNtSHlsSEpyekR0TFJQN1R3bWpL?=
 =?utf-8?B?MStDSS9HNldnWmxTN2o1N0x0UmRCbEYvSGl2bmp5YXh3b0tjRjZYbldHTUU3?=
 =?utf-8?B?YXVOMVIraXpaVFRUaWpyalhpbC9lb3VaMmY5dWFhNzZkZG1wczRzU2N3RGhw?=
 =?utf-8?B?WmxZWVN5WXJBR0JKekMvdjEwR1VCVUpXNm43V2xLTitWdFVySEgzSEkyanVP?=
 =?utf-8?B?S2t0c2dFbDAvSWJycGtIQUQvRS9uek9lQ2ovTmc5Z0NrU0JGcUNzV2h6QUhH?=
 =?utf-8?B?TWlKWWFGbUdMRmRaYzViOEdXUXNqOSt2ejRCaCtQVDYwLytSdVAvL2Z0S3BH?=
 =?utf-8?B?cHJlQWp0a0UreFRGNHZUWWZzQm9FVTRHQUY0d1JBb0EvRStUOWZSTGE3UHAy?=
 =?utf-8?B?UXRGM2RWSWlSTHpSVkgxVlY5YVJBVEZhY0FUSDREbldvQ2YyMkJGTVRuQ3Rz?=
 =?utf-8?B?eFVCTHliWGZmd1pFWU9WTUYxYW1oMVA3MTNDU1NabHJ2VVozS2UvUW5ucFNU?=
 =?utf-8?B?U2tIVW1QRlhhYmVDTlJCUG0xOU9pc3JLN1JMYTRPV1JDNjZXQUdpdFJoQnlW?=
 =?utf-8?B?a1dsaXFSeHJhVEZIcnQraFE3N0IwbzA0aGJ6T1JaV2JSQ292OW52SlVlV28y?=
 =?utf-8?B?dmp0VzNUMDhnVUVvZWlnT2JLaStYSUxaOHRJRm5OUnhtMlUzVnpSSGR4MzBG?=
 =?utf-8?B?c3ZEUWoyVFliTGlYaXZsZ0R6NXFKOUZqRHVXOEVlZ3BZNjA5anpMWUYyRDlK?=
 =?utf-8?B?SFlRcEczbTZ3RlpkbkpTWGswRVhVSlV1d1BjRTNvWWJmRXBsZkl1SGQ2bDM1?=
 =?utf-8?B?cVVYQlJZTGFwK2dnUjhrQWJwejQ0bGgvZDlzUGxpaDVrV3IrS0xyTk5hME9j?=
 =?utf-8?B?L1UzeElQak9laVZRbWN6Z1R6SkVqdXFBYys4VWVYY0RybnM4OWNpNmdINWdH?=
 =?utf-8?B?cTlZWG1VNGc0eDhSL296Wno4V21TMUQ4VkxMQVhPWFN6QmhPSEJRQmJZelh3?=
 =?utf-8?B?b1Juc2JnVVFwQXhGc2FEVUVmT1RpemZnNG5yYlk3cUpyTG1zcHNqbW51NlNH?=
 =?utf-8?B?ZEk5alM3LzFaYjV1U3BvQjBZWEpMdk9yUGpiRFBzNi9RRE90RndEb3dvT0hR?=
 =?utf-8?Q?tXzGd2Cl9HgInBUIibAY8aXkQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c969d723-0637-4625-2980-08dcb06afa0d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:41:09.0144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rl0RKgRylJEnE+cPPkCoKtzrUQkXEtobVt4lSWMOb32gb9zGAkpqBAqCHVM8xyID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984
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

Am 30.07.24 um 07:21 schrieb Sunil Khatri:
> Problem:
> Till now we are adding NOP packet one by one
> i.e if we need N nop packets for padding we are adding
> N NOP packets in the ring which does not use the HW
> efficiently.
>
> Solution:
> Use the data block of the NOP packet for NOP packets
> up to the max no of NOPS HW support. Using this HW would
> skip passing the information to CP and it skips over
> N packets assuming NOP packets.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 853084a2ce7f..01f98e2401ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9397,6 +9397,22 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>   }
>   
> +static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> +{
> +	int i;
> +
> +	if (count == 0 || count > 0x3fff) {
> +		DRM_ERROR("Invalid NOP's pkt count\n");
> +		return;
> +	}

Please drop that, we should not have parameter validation in the 
backend. That's the job of the frontend and middleware.

> +
> +	for (i = 0; i < count; i++)
> +		if (count == 1)

That looks incorrect to me. You should probably test (i == 0) here, or 
even better move that outside of the loop.

Regards,
Christian.

> +			amdgpu_ring_write(ring, ring->funcs->nop | PACKET3(PACKET3_NOP, count - 1));
> +		else
> +			amdgpu_ring_write(ring, ring->funcs->nop);
> +}
> +
>   static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -9588,7 +9604,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>   	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
>   	.test_ring = gfx_v10_0_ring_test_ring,
>   	.test_ib = gfx_v10_0_ring_test_ib,
> -	.insert_nop = amdgpu_ring_insert_nop,
> +	.insert_nop = amdgpu_gfx10_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_switch_buffer = gfx_v10_0_ring_emit_sb,
>   	.emit_cntxcntl = gfx_v10_0_ring_emit_cntxcntl,
> @@ -9629,7 +9645,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>   	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
>   	.test_ring = gfx_v10_0_ring_test_ring,
>   	.test_ib = gfx_v10_0_ring_test_ib,
> -	.insert_nop = amdgpu_ring_insert_nop,
> +	.insert_nop = amdgpu_gfx10_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_wreg = gfx_v10_0_ring_emit_wreg,
>   	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
> @@ -9659,7 +9675,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>   	.emit_fence = gfx_v10_0_ring_emit_fence_kiq,
>   	.test_ring = gfx_v10_0_ring_test_ring,
>   	.test_ib = gfx_v10_0_ring_test_ib,
> -	.insert_nop = amdgpu_ring_insert_nop,
> +	.insert_nop = amdgpu_gfx10_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_rreg = gfx_v10_0_ring_emit_rreg,
>   	.emit_wreg = gfx_v10_0_ring_emit_wreg,


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077A1CEACCE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 19:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8B210E661;
	Tue,  1 Oct 2024 19:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fuOQ47NV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2E410E661
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 19:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs8vIveP1ewO6gat57vwuLC6PcSU2XgBW8GA2+3NZa4pVipDtdwJxb7I7rr4ITF5uyWRRMYRyt5ihURjsKkJOjgo4mAYuzg0G1JZhv/kZy2ctQ0MLJHcUnSzYWOuRA5G0XLYgF009bqoKo3UCf1IC1jcIOZez+w3Om2LYMmOqrY9aB2RlJuURFWIxq7KLFP7dWp6qlumVpasViRr436v6qUZKKz3DAUcgh2pMfkdj49MXjgYgeTao58rC96uqrDJi8fINIom9l3T5E39AWombDqE+8rw0XVqN+O6mm8EsMKSrk1iESLcHSCFMzZCY7x4NpTBZx1LsrEB2dsnz1TdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPSpqB/ipFRvUuPzFvCzOWimRIEaGr8z6jaF18hFnmE=;
 b=ecgKo/o8j3+DnvspH8yWilQoOdrzK/CVv3RQak4bNBHPIyB+mc8WnobDxBZ6uSncJK72f4kreR6+65gkL/JTV1QtbqTZpsb/UmH1BeFx6i5F7HjKrRhs+bu2S1gLODl3mo1xo5mBigtrnMSbmUSHK/5zz19GYwa5MtPvPDjfW1v9NI84pqbQLLVMFYQqEUuj7DIPqOG3SVEdYEzhGefVavMYhv19ayrr0PSwSx9EhCMQhens9q57cvOGfCWUH0Jm7LNqptQ79hUeAPZlNtH0AAB7sNJtRUSryZnVA4FRT5j24QK7wwsXis3R+t+3OvTxYYSPs5EnB0x0ETSQqoTDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPSpqB/ipFRvUuPzFvCzOWimRIEaGr8z6jaF18hFnmE=;
 b=fuOQ47NVa3/rTwCerAvqyZRHf+2UdSCl9U0kZNXZp/MCaYnXCAuIudsG5mZusasih3oZA8wHn97uJazjqIc2qotz+GPain2OP5hQ0/Yq6wh9DVaDjDBzLVFlKrvKimeUvEBKIZ6VY/TvG4tAkVF55gYJ1IM0qLtmWCXcs2pMCa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 19:10:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 19:10:11 +0000
Message-ID: <7ed81635-3872-463c-94e5-e4972da9d014@amd.com>
Date: Tue, 1 Oct 2024 14:10:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
To: John Rowley <lkml@johnrowley.me>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 regressions@lists.linux.dev
References: <9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me>
 <925cd47c-8f1e-4b74-aeff-6d13ae5f0753@johnrowley.me>
 <95c575a3-100c-4808-b451-b92f14598188@amd.com>
 <836c2c82-4dfe-40f4-8d50-5e7bff04c38c@johnrowley.me>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <836c2c82-4dfe-40f4-8d50-5e7bff04c38c@johnrowley.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f93da51-6090-417d-9a7c-08dce24cac52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUNGTThvak80elR4cWxmMyttVmxEbCtOSUQ2Y1VINUhWTVZFUHM2UXJjUzla?=
 =?utf-8?B?elRleXpvNjArVVFtajBtZlBGTkhlTzRmRjNmUVMvT0ZlNk5TMzdRWDg2K0Zu?=
 =?utf-8?B?aHNSQWJDNlRZV0x6NllzNVZOUDNtN3Q5ais2NUxLKzRzQ2tMR2p2SHJwTXda?=
 =?utf-8?B?VHRxcTVaR3A2K2NXdGVUK0E0eFFaYXZVZVhyNTFmalpxalRpTC9RY0Vqb1JN?=
 =?utf-8?B?MGF3RmZlaXB4VGtXUVhzbUF5N2l5ZnZLRzFnWTVkdUc0cVRzcUIzdHJNRGxS?=
 =?utf-8?B?cW52STMzcHJabjNaQitERmFCRzRxTzg1SXliellDVy9VamhzRDFNRVdwTGlW?=
 =?utf-8?B?TFlVTFhYMzBYZnQ1dU5URm11YXNXL0EyNGdwK09XK0k3dW42cE5jREJMWWZL?=
 =?utf-8?B?dFVaWHdjY0NrNzJUbGFVV2pHN2tId2RFdGFyK3dXR3RNc0wybVFoL2tYYlNW?=
 =?utf-8?B?R1orMm1XNzFNNmo1MjVIME5iMnJaL0JKeTVNcXVNemFrTzhkdDg3RG1oUmsr?=
 =?utf-8?B?V2F3cXNkTXd1MTV4OHJwbXpyaFNzT0dCVENXM1NsZzluUUM5dTl0RFpkd1lv?=
 =?utf-8?B?c0tLUkVpbGgvZStndFQ4ckdsN2YvVm9JTDBlVkVEbExyNUQrR2l5L0E3eE9h?=
 =?utf-8?B?MUV3RXh3TlNSTGF4OVJURktEN1hSUzJ3dXVXUUgwQmJzVWRaTGo1a0JUZ3ph?=
 =?utf-8?B?MXZ2S1FEVSt5czJWVCt5UEgzVmUxd2t3QXVvUVZJSFZiS1pwdHlpa1ZnVlRm?=
 =?utf-8?B?MWhsaFEzVGQ2K0w4WnlzUXJmK1EwYnJhUE1MYzlKM2RVQ3l4WmFQcklQUHha?=
 =?utf-8?B?WldVeVBhSVpqTGswRi93eEhpM2xNMm5qcjFDTElWeTM3R3hwQ0d1YWhqYXhu?=
 =?utf-8?B?d2RMUW1MVmJla1VQYktyaEUwSVc4ejloVnlTRU43QWZLMUZPZ1B2ck1WbnVx?=
 =?utf-8?B?a1JWZnJmL1JSMU5FcW95R1oyaDRQMmQ1K0dPWlNmWGFKb3VDRXlwQVVnZCtM?=
 =?utf-8?B?TXBPMkhYYVM5NktEaFg0SnV6QkpDWG5GWDJDMUxaMGdYWXZaOEMyNWpkdjg4?=
 =?utf-8?B?NmE3eDlxNXJLTFk4MkNYTWJkNUNremt4aHlZNWVVNDVjbFlmQmZ3dHBHNFFs?=
 =?utf-8?B?ZllHNEF4ZksrRkRmK1lQMlB0SElKR2x2eVE0dE9GWFRaUjl5bGxrZ3NoVUJa?=
 =?utf-8?B?NlBjcmJJOW45K2JkbzFENEdJaFhYOHN5L2hmNHh6VkxQSHZJdnJPek9makxT?=
 =?utf-8?B?dlUrbmNVSW1jbEs2WjMyYzgybnM5d3duTmhnRmtvdGxzTVBwa3pHcDJRNVJF?=
 =?utf-8?B?cHhuWDlZNTVSaVhlU08rNnJ5TERZZ2RKc2krelVpTnZ1MmE4YUlESld1eHpW?=
 =?utf-8?B?MC82dytWbmZDaGtGbWt3TThpYktpQVMxelhteElVc3FraFc1Zm42aGNSeVFj?=
 =?utf-8?B?NG94aFFTelpwUnhGUTRzVFByWmtnWmRIOHRHME5Ra01CZEsxaVVXeHprMFRV?=
 =?utf-8?B?c0NEL2p4cE9TRFNqSTRjZjQyaHVFTHoydlRMejhtaXNqL3h2d2IrV1hKYUI0?=
 =?utf-8?B?Y0trRFJHRS9RYXpKV0R2SmFRQkxVRUNSd3ZSUWlLQ2VzNTJKWmpodzFQcE1X?=
 =?utf-8?B?U3ZZbDFueXVuTWlkVll3aXdadjRVMHp3RDNIV0dUSjg5NHJISUZxU0tiWXJZ?=
 =?utf-8?B?amFsbGZZR3JCQ2FFWHAxOE1vTTVjU2o0N3E2MmhZdTZKWkVmMVVERGw4Umtt?=
 =?utf-8?B?NFZ5RW4wR3pnN2lEUy9XNXFKQ1VWT3BiejBLRUZsN0Y2Rm44aFI0N0xsdjRw?=
 =?utf-8?B?UEQvSENNMkFXcE1nOGhkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1djcURNdFI4dm9KWCtOMWo0WHY3dDVONkM2bVpmb1FWSm5YU1M5am1NZllK?=
 =?utf-8?B?V3VQTmVIa0lyaHdvWStxWVkrWmhqdGN6MWNBWWlEMDR5cnIzdjJrNVhudVpv?=
 =?utf-8?B?ZHdyVUc5MWZ1ak51cU5NcFVKVm5CWnY3OStHZjNqUWF2djdtVW5aOHNOZUg3?=
 =?utf-8?B?TFN4TUdvWEwxWG9XWUFlN3hRSGY5bmQ0bEFqeHN3N1RqUWZIOUdQNWIvUjZ2?=
 =?utf-8?B?b05DMWJDSkxYa3NzZS93WE8xTm5YZDRSSGlXNDhQTFZ4bSt1MVJyTk1aOVZz?=
 =?utf-8?B?dmtBRVRXMnI1bTJ4bHpJMUNueVArQ2cyVVVaZzNBUzF5VEZlVG40SDZudzJ6?=
 =?utf-8?B?ZUl6NmdGSDRaSlVGdXJhNXFUS0VCdUNLMWY0NTk3UDNpTFByVUU3Nmc4clhY?=
 =?utf-8?B?QmNEejRLeXRHYzVUYnltRkVLbUV6SGZ4bmdDS0RhTzQvcHhZS053RjBTUGIy?=
 =?utf-8?B?NHBYazM4alhUOU5YbnJqangxMm92Z1Vjbnk4SlZnUUh5V0NYclEwN1c2OU9r?=
 =?utf-8?B?VTZ4OWpBMml6R1FxRTlMMmpKMm1YVFVTTG5sWGQ2ZWcycVhiTTFKbHo4RFdm?=
 =?utf-8?B?S0pPUVQ2RW9kKzFKNVRmYTUwTjhPUTAxYm5RQ2E3SW9GQ3cwRE9LY3p2b3Rj?=
 =?utf-8?B?OSt2Ykd0SkZBUGIyd012azNRTzVhVUI0UmZPTHp6Vm1qSHNsK1U4UmtjU29V?=
 =?utf-8?B?em9DQzlGYW5vNHNPY0owaWtlR3QvbFNFMkRDamZpWlJPKzZXUlBZTnRHMU0r?=
 =?utf-8?B?Zjl3bEZEWUZ3MGNpQjRIWWhEb0JRM2lLaWxSbmJrRTNHNmFMTVp3RU1qd2RZ?=
 =?utf-8?B?bXh3MWt2cGlna1pRd0xuVytYb25FbE9JZys2eFhYbHE0bUpNc2xGbWlPYWF3?=
 =?utf-8?B?Zmxpd25mNVA1UlJTOVB6aU5ZZk15Sk45Lzd2OHpLc2JMZUlyS0h5aHQzRXZs?=
 =?utf-8?B?MEFEVVJBNllKNkhHcjhmY3NNc0gzL3dCZHJJWGg2K1ExWDd2Nm41aXR2aGw1?=
 =?utf-8?B?VzJVUndnYVRuZ0lrU0NTOEZrdER1MXRPdHNUSk5iVjlUclg5NHhSMHkxczZ2?=
 =?utf-8?B?VXVqbzh0VDVtaHB3bGgwVjlNaG4vcVdiVDN5dzBDTS9IZld0TVFmVGRvM2My?=
 =?utf-8?B?cTNnc3NnL3kzSk42YlowSHB1Tlpzd2NHZktWekw5MnlKYUpyR0wzcklVbVFy?=
 =?utf-8?B?ejVmMnNJUzlvYWVmMDBSZlRlY3k3RGptdkNhNEExeTA4WlM1Z1cxc205NnFS?=
 =?utf-8?B?RUZPNHRrOW9rbXV6aTNDMFA1eFVoZnRZZXlmRkZPaU9nc00wSWpuMWtCMERI?=
 =?utf-8?B?OGZuaGNNRVc2SU9GM2pTT09Ea3o5RnlWR2JMWWxCK1pEK2hpNC8zMGk3VW1a?=
 =?utf-8?B?VThxenhvNTZrV0N6TW00YXdPRFdRWlJkZkttbHhOTHk0NDdxeUppSnpkN2No?=
 =?utf-8?B?S21wb3BHTXNPOU9OK3MrZVJVZXdTb2U0bHczKzg5Q3cwR0NzYkplL1ZxRThj?=
 =?utf-8?B?RE9TeFZPak5pUlg1NXQ3N3l1NnVUSFZ4a0NZMHkrUy9hWTJzZVdsZEVJM2hY?=
 =?utf-8?B?aGUwdTM5bXZObTVteUFuOS96SnJFVFBzM2hPNXljQkhOVUEzajFMdDVsZSta?=
 =?utf-8?B?b2ovaFUwTFdpc05kblpieUpmZk4xMHowNVgwQjIvSTBxZVVHc1lFYmlhMmJs?=
 =?utf-8?B?K2laK2VNNFhrZkNLcWdBdmxlSkFBNmxpNXZBRjZXbUtuNDV2TDgwMUZWaVZ5?=
 =?utf-8?B?dDNZQ3MrYkJZM0pBU2toNnp6TXlnK0lvOEdVN21LczlESEUzS0NRMVZDRjBy?=
 =?utf-8?B?L2MyZFl2Q1NuOEl4ZXNwSWRHL2ZIOFBWK09aVlVubm1tcDN2RGtDcHh5Q09O?=
 =?utf-8?B?YTZMeENpSkR5Q2VYQkxLbXF3ZDhMaGFJRWNDcnZjbHdENG5JLytwNG8wS256?=
 =?utf-8?B?WG5LWmpTWCtaTXpNZzY3QzRkd1VCaUJEUEtmV1pMTyt1N1FZQ1NkUkpUN3ls?=
 =?utf-8?B?U205U1RobytnOHZ3L1k5S2d6REJ1ZXdHUEt6VkNLWnNoTE1nRlhrenFkTjVH?=
 =?utf-8?B?TFJ2RGc1b0ZheFppVEQzTVVzT0JIVVFSbUZYMTNuMFpOOCtNeGxLOW1sZ1ZG?=
 =?utf-8?Q?bcer4Iri3xOMg80NjsTCQZAt5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f93da51-6090-417d-9a7c-08dce24cac52
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 19:10:11.7674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tccRR5dh130Fogqg/E79C8RHB855dIKqL2jBASRRLd5WZPYgHpiNAzqqtOIaL1z33yjbPAtMUAqJbdoTMoAHfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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

On 10/1/2024 14:09, John Rowley wrote:
> I was using power-profiles-daemon version 0.23 in balanced mode.
> 
> I also tested TLP, and vanilla kernel without any power daemons running. Without any daemons I use the following:
> 
>      energy_performance_preference: balance_power
> 
>      scaling_driver: amd-pstate-epp
> 
>      scaling_governor: powersave
> 

Thanks as long as it can reproduce in 'balanced' mode that should 
exclude PPD from being the cause and it most likely a pure kernel bug.



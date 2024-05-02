Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CC3C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 07:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67CC010EE42;
	Thu,  2 May 2024 07:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3DW1nrNV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4B210EE42
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 07:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyfAUZizyF7VJ0Ml7dq/WJLVlWtUPxWCCyTktmqLiinJPpKhdMz4n6MTiK1JbETcYBYIlRLM/mw+izgdgeP6NfKzRffmx6JqNsPToGXcFxd80t42krqZUm2aVlr4kSPJBk3GcYUvJ0kCM03y7Em/a+7T1lQG5jqs37xE86yJZtNwYj/QLHJ2O053WGhXUs37b8CpywWEeVU/hOrRHPEew8t8jdl7ooIejSmorgnwO/xVeAKRYNuiDjw7dbNB+0xvOKKr+Ww0NTbOiE/fqfRQQcGje0cgwgX/BkhjVwLArpXM9wgjGiQu4Z0NpmzrkgsLBlhu2wJtxECChLKKrXHUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSKgdKcq1kTK+NY/hiI1x6BberFbV9dTzLaBelr5mCQ=;
 b=hQ49nsAb3IeJeHdKrtW/vZtbGfHQbfojF61bT9pPvWMgoNGBldbXIZ3b3PId7saSiHW/BtswYnt61hD54FJr7YTcT7zdIi6k4Vi/Nh8XaBfoaIObliOHyEgx/R3yal11IZ2ESbMg8xu0PBfqmaOVhR10nS8/8CvtqCCHu7v8VHU2Z6K2DKwwbaUC89hvrkFszJxi9+7K5myqCjG4yDzsvZFj7moGYl3yn9c2XQtoOLeDcfhiyTcG9kvw0okNVCYLCx9VNWeoYKnhJDqz/z9Qh7ZNkVwqHQqXLwYHb6sqrHepIsa/iqRFw9VfXgwvPT+k9nc0zo2E9fdEiWpTwxC1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSKgdKcq1kTK+NY/hiI1x6BberFbV9dTzLaBelr5mCQ=;
 b=3DW1nrNV3CELOXrFeV2uQ0KNhYMJwBVYfMiLpnBfuYY45oxpynA1UbNVJ4yze7P7xEPdmRUYq82m8g6h9Lq7TeB6hMiI/NcwVoqJYbAO7RK7Nwx0lW4oTGJa0ZHhcn0XOqni2iZ7bCHnRjJR6qujvfi5q8uZN1/k9GQIQg0pNL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 07:16:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 07:16:03 +0000
Message-ID: <10b442ac-4449-4541-8324-3582c6da721c@amd.com>
Date: Thu, 2 May 2024 09:15:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amdgpu: Fix two reset triggered in a row
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
 <SA1PR12MB859947EDEDBA9CD73AA1271CED1A2@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB859947EDEDBA9CD73AA1271CED1A2@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0339.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: c10f1d64-7a71-4d4f-a12a-08dc6a77ba0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVNtSGhZemJWYXRORkE5UHNvM0lMTDBEbzdsc2I2UFlETGdZVVJhZnU5MG9S?=
 =?utf-8?B?dzAvSFRlTjdlOUVTZ2VleVJiU0NZdy9udUpaU1R2RkNRelBZMWJvbVVLSGpt?=
 =?utf-8?B?RFc2c055M0phdWs0RXNVbVo5cklWQkJUYjdFcktVVHJwcWZ0V04xcXJzQldS?=
 =?utf-8?B?NG43dlA0ZlRPUnkzelVCUCtwT3FCMG5zTDh1UDY5R3dvSUU0THNzanhaakkv?=
 =?utf-8?B?Q01Lb1dFOWd4WFFvR0pGM21IVDZNc29SaWxYd0lzZTlLWnQ2NFBlL21ZWGlZ?=
 =?utf-8?B?WmRMNVpOTzBNM2s2Yjgyb3BOSW5pQ2FZY1hNUDMrTDVOblkxZG55WThRbzlw?=
 =?utf-8?B?dWVuWWhBaDRyWnNpazhYM2dSclNVTGpvcmJSSzhvakloYit5TTZ5anUrbzU4?=
 =?utf-8?B?MWxFQXQ5Qkx1bll6MllES2tQYy9nNEhXcEpjZHFDbDB0eDc1L1Q4dVpaK3Fy?=
 =?utf-8?B?bW95aUt5UzBGc0pXY1VyRmdFaVhTNGZSclIrSlE5SkxGdTZZdUlNeVY2d29z?=
 =?utf-8?B?MDZWN2VDK2k1RlZBWkNXbjdjR20xdmxtWVVWV0JFcHFFbzJpeWYrRXdrUkx6?=
 =?utf-8?B?aDdJcDEvaXh2NzlIL3V4WS94S0JBekhrVEdlMlpMR3M1TTV3bVpwcDFscnFT?=
 =?utf-8?B?RFh3QnhTMmhIdUx3dWlSTmdKalZHK2NjeVp5LzNCS1g0VUNVUlp1U0ZjVEFU?=
 =?utf-8?B?TEMxSG02U2tLbVJOVU5razNhYWt3cGY4VWZIMk1qejZ3S1U5bitpQmk0MHNU?=
 =?utf-8?B?dC9ERGZxL3ZuWDdHTk1kOW1ocTJjeTlnaTZiejNCZE1FbzVnSW1QRHliS0Vl?=
 =?utf-8?B?T3lnQ09JdlBFYnFjTExxUGp4UE5kcFBlU1FhK3N5aG0zZG1vb3F2WnFXSWov?=
 =?utf-8?B?TDErRVRBZFI0NVY2bDlIbDdSY294dWZNaTNBQkxob0pLbW53bFJzUHEvV3c1?=
 =?utf-8?B?TUMwU241YmhhUnNoWjZDRWthendSRE0rUTRaZWFSM0x0bUdLZW9NL1IvQm9n?=
 =?utf-8?B?cXhaUnYvYU5lTUxsYmp2K0QwdTgrSktsMlVSUTgxS3owOGI4NFVXMXhCbE83?=
 =?utf-8?B?OWI2enFqYU1Ma29aaDk3Tk5icXQ4T3NtaG5HS2xnaHJGY2FMV0JNL1ZBaHpW?=
 =?utf-8?B?UkllVXlhUWZZS3FXL1pHZDZJUXVjMTRJWlVtdVJVenppdDBkZEU0YjJSL25V?=
 =?utf-8?B?ZWJYU1JxYnhRYUJ6emdFd3lpTEJiUTdPSytxYWVkZkFMRXJWT1RUY3lLOXBm?=
 =?utf-8?B?MnI5SkFIU0NtL3VQRWoxR0ltUkZtYjhzV0J1SVZxb0MxSTFBUmc4VVFCcWp2?=
 =?utf-8?B?MFNmUHdhUU5TcDVtSWhTTGxSeGVWcnc0ajJ5cDlDUXA3SGYwcXk0aGVZZ2Ey?=
 =?utf-8?B?TWM1WDFhakJFbVBCd0xRcFdYemVKSDdtYmk4S2wxT3hqUmFTbzZyMjhoaS94?=
 =?utf-8?B?ZzU1TFZ5TW9ucFhlR1Z6bkpZZkJMT2VWM08rUGE4VFJCaXE3dXczT2lOQVVT?=
 =?utf-8?B?cW5YVWdjTGI0bCtNZ0o0VFFyY0JXQ1pETFZkSm5sWDlWa09jLytROWRmZURM?=
 =?utf-8?B?ZVBUUjgxWU1BckR4cWZnTGFqdGI3QmIrWTJISVZyTXBQOVk2UW94bmszR1FY?=
 =?utf-8?Q?vdf5eL4I+ys2UJ34CPJF+zLhlDKLfm9Rv3r5FjpN01Mc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wnl2eVhjVGhtcDhhSFFZWXIyMm1idytleDVaRzhSckNMZFBDaWwwekFqWVE4?=
 =?utf-8?B?SStMR3NTYVBXd0RQc0NvbWRuTzJwRzNQL1pHejc1aEhRSzVNVzYzMURHMHlT?=
 =?utf-8?B?Vk1qZ2NMd20zZzY3WWlIYnRyRE5Pa2djMjVDUlhSRXFIMzdLcDAzeW5lbFQ5?=
 =?utf-8?B?eE84aWZ4RVZIWFRjWXV1T2NPL1FoYS8xajVLdm00Nkphc29oM3JFM0ZyRlpP?=
 =?utf-8?B?Nm1QVWF5NGErMzdLZ0lLOFcyUjhub1Zrd09oT25EdGwrcmt6WmJOVUtqbVQz?=
 =?utf-8?B?VGRBTHhNYjIwZjJPTWdCbFZrTjBsWEJ4bTJBaEs0TDhLUlNHR0hjUWxnK1o5?=
 =?utf-8?B?ckhvTHJmM1pYNjRDcEMwR0dwbG5xMGNCdDZKUnN2akZwRzFMclE2bFFNNHNp?=
 =?utf-8?B?NmN1aVZHUUNBa21TeTJpanNnU256ODJ5QzlYWHJXUUl1S29qeEVPT1ZsQ0k4?=
 =?utf-8?B?dDRoblhvTzJINUxuaWEvUEpTZ0dRb01lVkhISjhQbjArVVErWDU0SGRUM1Zm?=
 =?utf-8?B?aGZLZGNTYkR3QkducGF5dDNVRE80V3VXemIzQ1dZbWNYRGFzcHZHTUlOS3JU?=
 =?utf-8?B?U2M4dmdDWENIRUFYNEg3a1psdUhhbHJScW45ZDB4cFdBc3VWTGx0SUNGTVY1?=
 =?utf-8?B?d3RxNkFTYzJ6MWlDaElVZkpXQTNtTDVVYUhPK056K0ZTVHRSeEJudW5jdGZw?=
 =?utf-8?B?dXNabXV6TFZQNWNnWU1uMW1IZmNFZnJzNERvdmd2RXpmdjNTNE1rZTZjM2lL?=
 =?utf-8?B?TEh2TnQxTDJJZlpCTUtoUGpSN2RVZXF2a214SElGS1ZLSFRwdlJsYWZ4ckZG?=
 =?utf-8?B?bCtmU1p3amw0VnpRU0U1Uk5DUWNoSmtLQ25PMk5mNFVvRVRiQ3dDZ1QyTHhP?=
 =?utf-8?B?VUF2NTlVeElXT0Q3bTA0QkRGdXVUYmkzSFRLMDVkMVhYMEU3enpIaUcxSDdQ?=
 =?utf-8?B?STRuaFFjeWlPZWFkS3IrYkMyMHFzV1h0TmxzL2NCZldPK1NhOG1uUjRiNFhu?=
 =?utf-8?B?ekV3TnRHbU9vWWoyYlhMbE5CM3AreDJpcW0yMEFNK21HZzZIbHV4R21NZkxp?=
 =?utf-8?B?QzZXSmIxK3JHZDZ6UmdxOHBaVjZTNmNhdWc2cE50eUd4V2tKMnZmaVM3bEN2?=
 =?utf-8?B?VE52NVBNK2tocTZ1dUlVRzNzRFVXTjgzbTFKYnVLQ2tVdGRCejlsSTIxME9O?=
 =?utf-8?B?cVlQZWpoZjJCT3VHR2VvMXc4Umw0Uk5BY210RzR0QlVLMTJvczA0Ukw5YVRl?=
 =?utf-8?B?UGgxVU9tU3VkZ2t2Z2JWb0cvblpZVTNYVUdGSjlBNkxvUTBtWjB1L1VxNFo4?=
 =?utf-8?B?WmNVUTVSbVIrd3drZkFaSUU4b050cDF6Y05kc0VvaWtpT0x2M2cyS2ZJNzl3?=
 =?utf-8?B?SjFDVmFWQjA1cGE5K0haZVR6TENUTTAvaVpYZ3hqL1VnaDYreXpWYTFMREpa?=
 =?utf-8?B?SitCYmhCWk9RRG5pMkFKRys1SzJ2c0QwZnNJSjF2YUJKTmx4M3ZsaUxoSGUw?=
 =?utf-8?B?eVliS0dvdFYxNko2TnRlcEJKMG05NVpyb095YTlYaXNzUkdvdHlZSlJtQkEy?=
 =?utf-8?B?R0Y5YVJoM0JuRWZjYVRUanRZeXdEcE5la0Z6R3RPaFk4bW1tVlEyVmVBZnpI?=
 =?utf-8?B?RVVjR0I4dGJQSEQ0UksxeXZzb3NJTWpmOCszMXQ5WU5yRk5LWlIyK0doMkdh?=
 =?utf-8?B?eHgrYitiamxMbEpEOFVPc3VHUXpjTnZhdTFsejYyaVZQQ3hxM0ttdEtiQ29V?=
 =?utf-8?B?bXJkdXo1a3ZyeFQxSUlpdGdFOWNxck1tSEFyS21vaE14ODJ0WTRSZVE3cktW?=
 =?utf-8?B?OHJhSzlDdzZVakUxU0dqdkV2eitVVmxMUllORE1vTU9qVzVpVWhIOHdPQ1VY?=
 =?utf-8?B?OHh5VzJOUGpyNVlMd1l5TzlBUnpaamNsZmhUWnNnSFNScDR3TVczNFBTeVJa?=
 =?utf-8?B?TDdPSDduMHdFZHQ5WjdjWkEreDVKSDg2cS94a1F2cDdWM05CR3ZXZ2ZpbUxM?=
 =?utf-8?B?bGtrVkxIOE83TTRydGN5TU5Ea3FNZml4cnpPbXk1NThXeFBzVW9wSjhyWVdR?=
 =?utf-8?B?bkpReXhyNDAyNVRRK0xGOWtjU3RNMWFKbUVCeklKUEJBQldVZVBQY0dtM0w5?=
 =?utf-8?Q?EG8Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10f1d64-7a71-4d4f-a12a-08dc6a77ba0b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 07:16:03.7358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsJL74z8fNnE2ogzumJL9QQXusi8ZOUQ8cNEHB7st2U7VErPcO0w4xS8vrOPS7nt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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

Am 30.04.24 um 21:05 schrieb Li, Yunxiang (Teddy):
> [Public]
>
> Hi Christ,
>
> I got R-b from the SRIOV team for the rest of the patches, can you help review this last one? I think the concerns from the previous thread are all addressed https://patchwork.freedesktop.org/patch/590678/?series=132727

I don't think I can help here since I'm not familiar with the RAS code 
either.

But I've seen that you already got an rb from Hawking's team, that 
should be sufficient I think.

Regards,
Christian.

>
> Regards,
> Teddy


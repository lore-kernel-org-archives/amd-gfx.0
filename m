Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DCAD41C1E
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 09:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870BE10E1A4;
	Wed, 13 Nov 2024 09:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ycAGewce";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72FEA10E6B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 09:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtXT0XQqTAatqU74YXAOk0oNDv5TxOmvRFEyGBEuZxf3gYjDbCfBo6p/wbxOrklqvpYwhWDyB0jgYc5A54PDl7qrxZrWXVief7nLYK6qFhcMgxaEAPPGx2QUq1TrN/YHtPa6ZlKPrMDF/XJAVbC9Lvo4CWhc6P3WUTZNYB96iAG2gHr1yhrC/wCgL0hevKFNSQbORdEFtCMj4G4prEbw/BLf5w/2zwMSgoy0J4+W8S92tHdo5mY5pkwUlOqhlSCLLhGEhdaJTFGbumQJSVCJDFvFrsUsHuIKMYTc7RcYDTGMjlOdait9z6JFciRDnTOwzJ83cu6yk1xMvyg0/wmwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH7oS/COFvLMoky3dfNVeA5oQyaTXcqO2RT++sgDRvA=;
 b=ohl9UTzFtwj4aADZmzzNbi33oMt6b8o8N++ZoNqjLyYV/lbE+J4OJZzBXD9OTk+Uwq3UChTFh5o79RtYoX8V1DSO5G2Eqa9AhPh/i9PO/TAxKnThCM3/aAryOhNXiRQ4PNSyPN8kIre+67KqfD9LJswA6vtIqKAqSXzm1BGYj8lvhNd2dY/N1ADvOOdO9D9dnBLRjHYtX2RkE06TEHWsJZWxfXIL5zbShWiXlUWTON6uM6vSUoQ1twvzlZi1shj3ANyGfcAaynXLtu919THDA4lqfsY4YfRaWMMMC1LCwNU579yFOu8zpM81ZTVA9Vz0QMgFsEZvNexaFer7d3lQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH7oS/COFvLMoky3dfNVeA5oQyaTXcqO2RT++sgDRvA=;
 b=ycAGewceB7Whzk+Z4rT68kyuPwPFutLDHMMVpKmqyElJEoBJLrabPdAe7WaOdSEgoSYedImwUM4dusl0cPgPFL2iciyaRnkbx5KmUEn/N8LISnxDN2a/T/sX4rPL0I5bHIgAzV4XhepT0+l31h6usEdSQy2H8XsDcjTZURFe0f8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 09:13:58 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 09:13:58 +0000
Content-Type: multipart/alternative;
 boundary="------------mTyeZGnmlRU52fkL6HQDXeJB"
Message-ID: <23772701-e7ff-45ad-8049-92486398ec0a@amd.com>
Date: Wed, 13 Nov 2024 14:43:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: add the argument description for
 gpu_addr
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241113090705.741598-1-sunil.khatri@amd.com>
 <20241113090705.741598-2-sunil.khatri@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20241113090705.741598-2-sunil.khatri@amd.com>
X-ClientProxiedBy: PNYP287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::26) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e0d50c-f4ba-490b-f23a-08dd03c3811d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlJUbktoNEhkSW56NTVXM3JMRXB1SjIzaHFoOGxhWG9HVlBCNkFDSTRZbnFs?=
 =?utf-8?B?RmtsTExvWlBkN0FzbGpoWFBZUkVSVFVEY3FXRjEzaDlkYWlWeWJpMWo2d2lM?=
 =?utf-8?B?S3BIOURoVmNEWEF2ZllNS3FKVzhmVld5QjM4UlhBaGJWaEFzTjhTNk1TY1R2?=
 =?utf-8?B?ZXIyZG1mQkkycGE4b3dnRVFpTW44WVNuanp4OVdBanYyTnRuYW1mM3FoczlJ?=
 =?utf-8?B?MVZLWm1DWDJoWmxqWFU1THdjd0xoZUhmazBzbkVQUWZKOHo3UkhIQ2xjVzhQ?=
 =?utf-8?B?LzZNVkU5aTdsZFlaY001bXJtaVJRQnlQK1l0Q2FaOEQ5bXBENjRrYlpBRFNh?=
 =?utf-8?B?cUhpN1BGbURIYU5kQXQveFBvWFZnNlI0K3kyUHhZekFSdWhXekozWWZkNXdv?=
 =?utf-8?B?WG1hWVhuUWZrM2RqOHVKM1NmR2hoVFVhQnJSVEdwWTVGSGNBTml5TmQwVnN3?=
 =?utf-8?B?V2pYUTMycGdxTGQwT1dUV3Rad1VUSzBtUnB6aWlFVHJxcTV4WE42TXhvakFy?=
 =?utf-8?B?VjdpYWlXQnJvVFhXWEM3aDhBalpkN3VBdGVWU2VjUURML3VSRnhDN2ZwWEs2?=
 =?utf-8?B?cmRuNjNVbFFsTlhvdWFycGx0eE8zZUxMUWF3RVR0cXhCOW9zakVYM3Jwenky?=
 =?utf-8?B?bmg1OFNzVHJwTE14OGI0ZCtwTDh6Qmw2d2lNSHJ1dHFwWk9USkVtekpBK2lZ?=
 =?utf-8?B?TzFER3QwNFVkaEUzRWJFRWY4eGMzVDA5cTBkekRpbjBDdTg3d2J5dTNHd0JO?=
 =?utf-8?B?bDg3UVhsMTh1WWN5TWhHMERVYXJ1L0FnSzUxdEJaaEQzSC9NQVJ0SEgxcmc4?=
 =?utf-8?B?ZDI3MmNURXcrNmFzR1lRTTlrTVpKbWwrY25oeVFQd0RRTkxxSGoyRThVQ3Ri?=
 =?utf-8?B?ZkQrQkxMQUw2Z000ajRFd0VDWHNNWjNmQjBDVDRSVHJNTXBxU1FPb0VtdHdT?=
 =?utf-8?B?WFVET0ZHL0ZQMzVsRmZZTER0M0xMR0JTSTRMeE1Xc2tPQ3JzK0J5RkZLci9Q?=
 =?utf-8?B?UVkra1ptS0l4UGNuekRaYkhMV0hUUnhncGI2ZGwwdVlGODgxOTVndjR1RmI4?=
 =?utf-8?B?cXBJc2x6UzU3TlEyQnA1Z21Va2RXQ2l2VTF1ckZDQkExRWhVZmZRNlpzOGhF?=
 =?utf-8?B?M1B3ZEIxbjNYdXFjeEhoNWgzeWgvaXhad0xITjYvTkd2cVdBVVlHMGYwUDBz?=
 =?utf-8?B?UWsySnEvS3p1VVloeUtFR1BKUFMrVGNZYlg0R0tZbTZweGJYWjlucEgweFRT?=
 =?utf-8?B?bWJhNXVjZHhTd3hjUk1rbXJ1UTNIdm05cnUvRFc3MnlJQXNPTFMrbVRrY08r?=
 =?utf-8?B?ZXdIVzFmWiszSjVpQTdtS0RTN3k4MzROc2RPY3phYzEzSVlFaUpiOVk2NmZy?=
 =?utf-8?B?MWhGNnNMWmpvVk51YnV1TUxaVHhyUFRqN0pLQXNvRmlIK252Yy9ZZlk2S0Jk?=
 =?utf-8?B?NFpFbTBlOXpIeEUrTXVCU2N2bHVBcDFjR2tCRVl6dVpmZkR4K2c1MldoanZm?=
 =?utf-8?B?Q3J5K2hyMm5STU1UaDV1UHhydnVGT0wyTXZPWmV1aXJERHpmY2x1SXVnNXpn?=
 =?utf-8?B?UlJ2bUN2TEt5WlNpQ3FqUlJVd3Z2UjRuYVp5SjBSeTdiVUtmZEJ3RGhpMXhV?=
 =?utf-8?B?WGVFV2VYd21rRG41OTV1cUNZK1JEYW0zZkdscjk1MmdDMXpGUWFDSFd5cWpy?=
 =?utf-8?B?bGtTc1VGb3lkNngvMXBZV0RrOVlXQnBHV0NLeHp4Q2NIZ2VJeVdDTGV4SWlj?=
 =?utf-8?Q?0LFRLdWyG6xqU2Mzn6iAaShe1A/aFAZGODgmnCX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VCt5WTYrOFAzR2hJTDV0UWthRC9OMXpqbVg4cW00WnpqeSs1ZEpUTVZHRmlM?=
 =?utf-8?B?VDR3U3oyVjZ2VGJvQ1VNeDljZ0Qwb0xFSlVRSDl0MmtNMjg1YWRwcjFicWp4?=
 =?utf-8?B?MmdFdloveUVaekJrc05wcXJLSm8vaUY0OCtHeXQ1WDI5UTZjcUNMeHEyN3dU?=
 =?utf-8?B?RDBxUGdwNmI4bjV0dTZmeGZ0alVCUVhEelRrV29EYUd3V21vVkNEV29PWGo3?=
 =?utf-8?B?c0dUb2UyZHBSU29VaHlMYXFZcThPa2xkN3pmbkhmdlFKa3BaZU1Nc1NxaVBn?=
 =?utf-8?B?eVRSTkI3TFpSZ2ZYVmJFZ0paWDZmMUJyd2dsTXEwd2o1bGM5WjVBOVhkS3dM?=
 =?utf-8?B?Q1RtNTRqSEpSd1k0UVcvd0NqUGNxYkFjR29WK3RUTmVJZkd5VzcxdFY1eXRn?=
 =?utf-8?B?c1RYMmErTmlIZUFaQmNCckNkNjh4THVVU1QxOTdLem1obk9xNEczWmZTckVI?=
 =?utf-8?B?QUlrQXY2M28yV3Y4R0RQSVJaeVVFdWdydUl5UkdIcHUzTUc2ZVZGcDBRcmdU?=
 =?utf-8?B?K3VIS0Z0dXl3Ky9ZZXNFZi95R3VVTkh5MWNxZkZQcmxIR0pGZEM5S0RzSURQ?=
 =?utf-8?B?dUJnVllVeXcvcEZsandGZzVlWWRVUWxoV0w5d1JzcUxydHpiUk9IdytVbjhG?=
 =?utf-8?B?dXhpMVpVeWxsQWlLa3laL1JMeWJRL2tLaWdRZUlGOWF4S1IxQXNTclBGdWJa?=
 =?utf-8?B?MWxJSVdoWG9rcEVJc21QeDFrMGxzV0ZGeFBYSG50ZkQxNmtHemRZTHU3Sktl?=
 =?utf-8?B?K0x1MXdPSHZmbmExTGNLS1dDazNXTTJIeVZveWFqa3Q1aEs5NmNzMkw1LzhE?=
 =?utf-8?B?cVZqWGNLdzRsYmpEYWk2QWlPM3Irc1VUalQvU1NvWnk0V2plV3BodnhWalRx?=
 =?utf-8?B?aENkbHpUcWJsU3NBQnJWd1liRzY2UU03WC9DQkhnbk15cXVlOXUzWWtKUVZw?=
 =?utf-8?B?eGo2S1NxK0s1SmhPcldsTGxrcXdiaU5hekdtdlhjRVFJM3NjWlh3TFhMTWJN?=
 =?utf-8?B?NUtQTUVKME5sMlVBZjZHQjA0UG1HbkFrd3F2V3BWTFlCZ2JYQVY2SGxkbnJ5?=
 =?utf-8?B?anF5eWdURjZHN3FMa0MwWHZZN3RocFNMYjljemFESWFCKzN1UzBQQTNMMmVh?=
 =?utf-8?B?YWdLRlJHb2NWUkMzZE9Jc2pKbkZDQndacWRwYk9vMGsyeC9SOVo0WTJXWnNP?=
 =?utf-8?B?MXVFSDBxeHVFN2RPL0d0K0pDcEJjai9CY3BFSGlMZGFMMGxQMkVKVjlNTXVO?=
 =?utf-8?B?dFprVEE3UG5HSWZDejhqNmdxTk9YWHhiZ2g0c0w4eCtlcWVjdHNFTFlLZjQw?=
 =?utf-8?B?TzdpTHlMM3pYck94Vm90WkpQZXBFNnJrbWxjaHQzRUl3UHg1SElidUJoMkZ6?=
 =?utf-8?B?QXJDcE02M1NjTzU5eDhWQzJKdHhiOVNoZ0dsQjd1YUpsbUc2b1dXbjRVVHU1?=
 =?utf-8?B?ZXNZTjlzZUFvVzdaOCtyRzRaam9oQXAzUTNnLzZBSEx5YzhhVWhTbERlTkh5?=
 =?utf-8?B?OE8wZ09SL1ZuRlYwQVBoRUF0VWsyQzgyTWZaSXlFUjVFNWpHa2FiVW0zM0Vt?=
 =?utf-8?B?a0J2aDc2WXlnNHBuSk1oeTRVdDJxbWNhZEtZYXJnNXRDN2Z3S1EyS1RaYkZR?=
 =?utf-8?B?WlI1dWNKZkYzb1JPWGNyQXVpYVFMS05XSUg0WG9hWExMMVVkb0xCRE9KYVBY?=
 =?utf-8?B?NGhvNmREU2dmbHNkZDNGRnZvZEJBS28rbGpvaGt1TkRNNjJkV1J4dzh1VGVS?=
 =?utf-8?B?SW9mQ0JZemMzUHRrY2NtcUl5cC8vbzUyZExlU2JJdnJ1VSsyN0xNMTlXcGFB?=
 =?utf-8?B?N0lqd3hyRjdtQmY1RUdsS3dMWk5jSFpqYWdoV2dCK1l1UUt6ZUN6ZDVMcDBu?=
 =?utf-8?B?a042U3NTOEoramNZV0l0ZDMra3hEaUhUaHlUS1lyWUFnNU5WMXhHbnl4QzE4?=
 =?utf-8?B?cDIzRHJZRXdkOU4yUUV1c0s3aTRidFpQTW15U25tVGdUWFVrYVYzNTJ4WGxP?=
 =?utf-8?B?K2ZsQm1DKzlPak80dHNsZ205NHI3b2tvYTJqUGwxRk80NFppOE9HUWVxTWx0?=
 =?utf-8?B?MEJIUkkrZEdseDBOWlhnRDJkT3Znb3NHeEFWZUhYYjVtazRnaGQwL096OFNj?=
 =?utf-8?Q?xLqqVk+bPvXC3bkFanU0GP6C5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e0d50c-f4ba-490b-f23a-08dd03c3811d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:13:57.9478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aPkH+oWYzaLFOETZJsGUQM3rE446pGGBs4DsNvJ/P7fSVzaEnjz1dtMRZMMYse4ai2+JkJyqipu+cFnAkfNQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
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

--------------mTyeZGnmlRU52fkL6HQDXeJB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

On 11/13/2024 2:37 PM, Sunil Khatri wrote:
> Add argument description for the input argument
> gpu_addr for amdgpu_seq64_alloc.
>
> Fixes the warning raised by the compiler:
> drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c:168:
> warning: Function parameter or struct member 'gpu_addr' not described in 'amdgpu_seq64_alloc
>
> Cc: Arunpravin Paneer Selvam<Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 0defad71044c..898d215a8d99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -156,6 +156,7 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
>    *
>    * @adev: amdgpu_device pointer
>    * @va: VA to access the seq in process address space
> + * @gpu_addr: GPU address to access the seq
>    * @cpu_addr: CPU address to access the seq
>    *
>    * Alloc a 64 bit memory from seq64 pool.

--------------mTyeZGnmlRU52fkL6HQDXeJB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Reviewed-by:
    Arunpravin Paneer Selvam &lt;<a href="mailto:Arunpravin.PaneerSelvam@amd.com" class="moz-txt-link-freetext">Arunpravin.PaneerSelvam@amd.com</a>&gt;<br>
    <br>
    <div class="moz-cite-prefix">On 11/13/2024 2:37 PM, Sunil Khatri
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241113090705.741598-2-sunil.khatri@amd.com">
      <pre class="moz-quote-pre" wrap="">Add argument description for the input argument
gpu_addr for amdgpu_seq64_alloc.

Fixes the warning raised by the compiler:
drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c:168:
warning: Function parameter or struct member 'gpu_addr' not described in 'amdgpu_seq64_alloc

Cc: Arunpravin Paneer Selvam <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 0defad71044c..898d215a8d99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -156,6 +156,7 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
  *
  * @adev: amdgpu_device pointer
  * @va: VA to access the seq in process address space
+ * @gpu_addr: GPU address to access the seq
  * @cpu_addr: CPU address to access the seq
  *
  * Alloc a 64 bit memory from seq64 pool.
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------mTyeZGnmlRU52fkL6HQDXeJB--

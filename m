Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7282FC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 03:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFAAC10E07D;
	Wed,  7 Aug 2024 03:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pkhY3JrL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66C010E06C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 03:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBHlohpdBV03FhWueps8g4jhof0UmMb8812uHp3CnNYJwwG9Bm6WNYv0Cr/sR9Dsr0eHIwNkLB+QIC2p+vxBFr4jIKzrmUUY2NFX+jtP3PWQKFYmjpTR/FsaettWg4uQ3lCHqlsIKCN2a4zy6Z3DmJ0y46CaNPF38IddNnfAfnooZKoUwIUKjB8wXlgKdipl26SAW7SFsKJe6B5nSQ5scR76CUQ2tP0O2HgKVwBQEfI0ZuH4XvBLolCfxnKa6zQi8fQod0W/fcdSHMe5RDAN95s5TlCEpt1QVA7MITioHQEJx3EdavZFfaNvAGaf2KV9tHN/W/ejttcd3buyywQ9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SpWCcjHB2lBKt/IQOfnm/PFGe+RdeyFrAHub3Wi/ok=;
 b=nvCKFE8iryiNRDhsJIW1+BrMGdNDsx9B5HS4oBTwUAZrPtj5dQPH6HBE9xsJ8XO/w2JiGM+KhQmuF6HG4P9ssnHQV2WOso751D2lnIRX3k/CC5cy7x4NaAxKuILnwGUyIkShRMJjFQE0IXt1oq8+UgiDtFlV4CpwKmsVC4PnqYl4m+Uvp8EX6cbQccpFPVn6ytLeij3ug+E3wMiXqz4iQqtiHEz730iPgJckLh+DL52UbjwMURQRl6bAqn5Z5T/7znqHwSutPkBSJZHmmUatHzbGsHmWxUEnvcpieKR0k8vA35n/RqtddBHz1rMdYUomcbicpQTgjpMdoBGHXK7yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SpWCcjHB2lBKt/IQOfnm/PFGe+RdeyFrAHub3Wi/ok=;
 b=pkhY3JrLxkLcE6ZzSjwqRu+XXPiSj/kuVxnzT/WIOCwX8BQQJ7gaBtbinWKKMGXg09cd9S1GNWvs3FM8V4Sw2AcfMiW9StskYk4s2+yDdq87v8CFXq8HEJ8Atz+/hvPW15zDAsiky3X74Qy9ZfuiHfkOPI7NIqUjWOn+jm4O4UQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 7 Aug
 2024 03:37:51 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7828.024; Wed, 7 Aug 2024
 03:37:51 +0000
Message-ID: <8daf65f2-7fab-4ec1-81d1-1070846adeb3@amd.com>
Date: Wed, 7 Aug 2024 09:07:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/15] drm/amdgpu: add print support for vcn_v4_0_3 ip
 dump
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-7-sunil.khatri@amd.com>
 <CADnq5_PgwrRWLCRGpx2JMW4TiAbbuWyX_3eAphHreocw1K61cQ@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_PgwrRWLCRGpx2JMW4TiAbbuWyX_3eAphHreocw1K61cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::7) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 221c9e24-e08f-4816-a91d-08dcb6925062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWM4c3pZZ0JMbkFQS1E4b3VGL3AvMHBsMkRFcGVBaFFJc1FIdG0wS2g5dmRx?=
 =?utf-8?B?aTZjMGNPZ0tLZnMxbzhjSVN0QnFIWVVNTzUvY3JpYnBrVHJZRWtpOGtaeTZT?=
 =?utf-8?B?QkFxL2U1Z2p6YnN3eG5iR1RkNXN0QnM5WDFZUnVqQVEvcWpLN200NGlMWXhK?=
 =?utf-8?B?K2dxK3JIeWpDWi8vWnJJandzdldkU3FLUStZclJvZDJsTzEreFF4L3BXVWhC?=
 =?utf-8?B?WTRoSm85Z0hWRERmZkZKcVFjN29WV0U0amtwNU5WUlBXMDMwbUdsRW9UTWNM?=
 =?utf-8?B?N0twb05rSDlJUHgxNmdwd3h0eUdqRDd0R253OGx5N3dPY3lkbE1xRnByaGxJ?=
 =?utf-8?B?cHFKeTJ1VzJLZTgrNG9TeTJSQ3g2OEI0b2dhUDQrWExOVnZvUGljNXU2b0Fl?=
 =?utf-8?B?VVhFNC9BdTJYQ1Y4ZE0vUHhsbjMxbmtWYWtFUkU0V1I1RlBSMEF0SFFiN2p3?=
 =?utf-8?B?WnVoYzdEZ0tIanhES1IxQlA0dGJTVWhVL0JVODI3d3dQRFBxc09kenptSm83?=
 =?utf-8?B?VnA3RE1PMDQvVVByN21TazdLUnBlRm5WM3o5TS8xSzZWMzR4TEFEMTZ6L2VY?=
 =?utf-8?B?OEx6OXMrSkttaHdaVGFNeWsvczJKVVBVUlI5Ymx5eWN3STFJeGU1NDk0RVdl?=
 =?utf-8?B?RmFJZG10aWhNNk5FNUpDbmJtcE5xVHI5VkRjUGZuMTJBWTJXWEZRa3RLV1cz?=
 =?utf-8?B?MVE0VUxFQTI1Z0NyVFAxM0VVRkkyajI0VzF4OTA2OUFkb1hKWm5kYmhEanNP?=
 =?utf-8?B?SE42bW02ODZEalQxV25tb2hMaUwvZFJJcWM1SERoRzhETUZiTU1Wd1llT0ky?=
 =?utf-8?B?cm1qNGlkQnA0WXpLNmh4QU9qc3BoakxnaWJFaXl5OTE5SUFYcmRpWVR1T0lR?=
 =?utf-8?B?V210c2c5eEgrbGF4SW5BcXVaRlZRaGl0ZmJzOGJCK2ZHTkFVZzRJRld2cmVa?=
 =?utf-8?B?ZVZ4N1hGenJmN3dZNXl4eU9yV0JHMHY4cFRJT0hpWS85K1A4K3FCaXdHY0p6?=
 =?utf-8?B?cG80VU4yY2lkeTBsamJKWEhKVWk5c2FidzVCdnpDRUIrai83dzZycTRtNUxW?=
 =?utf-8?B?MFBoSUEzaTYxcE42Sk9RWlJXL2ZycjZXRkE0SXIxdm5tMmxuM0ZFaFdRM016?=
 =?utf-8?B?RGdBUnNhbHZpSnJvdEV1czhEVVpHS0R1WnNRQ1lhQU5nZFNKWml0Qmt4djk4?=
 =?utf-8?B?bXAzVnVsUjRzN2ttVW80TzF0bTNic3FJMG1TQVUvSFNuWVY0cHMvM1Y2U0dw?=
 =?utf-8?B?U3lMM2pLVkZWbXE4Y2RuZE9zK0hwaGl3TW1kY2wrZFozcnl2WDlZMk4zUVNm?=
 =?utf-8?B?eC9RTzdCeU1Hckc4VWdjdTVaR2czcXNaaFZpbzl0bFVmZmpSN3hacWt5SE4y?=
 =?utf-8?B?UXoxamx1MEljYlEyL2JneWJGVDJGVkhuU29KOWQxM0FNWjBpMlNVREpkUE9k?=
 =?utf-8?B?RCtWZ3dtY0xwdktyRGxSUndWK1JkMEM0bGxwdmpZSjBOQ3JHZFBGSDFmTXlB?=
 =?utf-8?B?L3htMVBwWUxxdEhNMXJkbUF0ZlhvNnNQMkxWbjdrWERlMGUwRDEyeEZ0blEr?=
 =?utf-8?B?SGRiK3F6SW82aFhzVVFxQ0huelNVbFF6ZkVPd3pRRW9EdlRmUThNejB5Z0d6?=
 =?utf-8?B?OTIxdWd1S2dSV3NQcXJTeWxOenZLdWZwYTdkOEVxUEZzdHdRUitxekZ6ZkhU?=
 =?utf-8?B?cGhLQ1hKbzJMd0x0SVFuQlFIUzAwcDhtZ3ZJL2s3cmRmNWJpK3hIRGNST3lB?=
 =?utf-8?B?YzcyNVlwYzc2ZzRPZ2F5TFZmbXh1Vzc5MzJhNGdJTmFXM0NOdk1jYmN1Rkky?=
 =?utf-8?B?M3pORC9jR25yZzA2RDY2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUJpSk1ETWdYZmQrRy9oQk94TFQzTFJwRk1QVkU3M2hkdzV0WDVlUndndVZk?=
 =?utf-8?B?Tnc2M0R6bWpRcWMrM0FlMk91Wjlzd3pzVlQ3N0QrNU5vTTNXbHZwOUJoY1lF?=
 =?utf-8?B?SkJORWx4M2FqbHl4RnZBTFlOWU03VzhsRmcwbFcxRGVHWVlOZFY0VWhJMVk1?=
 =?utf-8?B?NWFMRFZrRWkrZDhJd1o2ZTJrOUkwaWJiTVQxOHVpTC9SaGRUTTVyY1hlYXgx?=
 =?utf-8?B?YWFOeXRnQXBTMEdxdFRRcGM3MnBuNFpnVDl5ejBEdnkzN0xFMCtNODE2WWxx?=
 =?utf-8?B?SXQrVWFpRkZOeVR0TG5nbWFUK2NnanJqeTRxS0N1SzlBTERpemF0RmQ3VGd5?=
 =?utf-8?B?a2xOMS9HTmpoS2d6VzlvSmUwOEVtSE5sMGh6MTlHMDMxc2poSDJDU01MTTRD?=
 =?utf-8?B?UFVVREl5YldKaWZZcVFNNEF3cW8zL2xFSlpJSmxYRjhOcGZXOVlFZHhOUGZP?=
 =?utf-8?B?M3JORjRIZWdScDJ6WXdoYnp3UE5aSkRLUitMNGl1ZEVDYkhzeUlUQ3M4YWdy?=
 =?utf-8?B?UDZxTG1seE1sVzVlUlRXZlBhR05Qb1lYc0hndjZ1WUFUQmdhaks3NktHUmt3?=
 =?utf-8?B?SXpQZXc3eGJIYzd0UkpRY21PbXc5aGRnV3NEUnk2K3pwZnRMTTFvWDBEYU1P?=
 =?utf-8?B?bzhES1ZTdWZCQWgwRDNueDVpd0FMNlh5TXBVNWhOOFROekRBUHQ5aXF5TTRN?=
 =?utf-8?B?MlVrYXRyWDVNYWRGZGZzUVIrOGxiWG1qUWRObzVBellwdU9vSmNGL0ZMZ0RN?=
 =?utf-8?B?dkVVUGI2bkMrNWEzbEpSVUY2ZkJwbDgrcmM0VnlEV2I5QTllYzFPcDQraklC?=
 =?utf-8?B?Z3pTcS9NZFNEaytVSkJHZjVzUFk1UWlEbVJRQXdCemw1SFVrSWNLQXNyd2xq?=
 =?utf-8?B?d21sQ2RGWTRIeHQxV29XbGNZbnN5UnJFeTZvUzlUckhzLzByWU1ES29Nbkc4?=
 =?utf-8?B?bGNsVmx4UFVSZEtDVUZrZWlxZW1KMUJ6SnpEVGRoWVUyOWZUcENpUVlnUXBv?=
 =?utf-8?B?VXFZbWVKb3BHOW9yU21sZU5iOThrRHZNOEpHaVVkYzBBVjBhRzgyRE9wQTZW?=
 =?utf-8?B?a2ROZkx5R1BNaUpGUGRTV1lDWk9mclF2cFgwVzNrT3JickpoK2VKeFhVOFUz?=
 =?utf-8?B?ZkJrN1c5eDBpNUtWaXJ4eWN3am54SUF0OHZJODVXSGIzR2MwZE9xeDcxSWVv?=
 =?utf-8?B?MGxkWHNUN1JFQjNRQzdZZmFtR0U5dVZLSEErVDU5RUNkUHRhM09jSnExdUZB?=
 =?utf-8?B?VEllamRBeFpDZVl2NndvTlYvcldaWTByOG5nbzAxc0dTQVluTG9XNCtJQkNU?=
 =?utf-8?B?TXVicjNQUm1aV0FoMXRRRFpRdHB1WDk2SzdOOHp0bEZkNmJGeUt6THdxcWlR?=
 =?utf-8?B?QkgvWVhwQkl3cEQ3ZHR6Tk5UZ3Q4b0xsYjJiZWpTVDRVVjR5bC9XMnZjbVVI?=
 =?utf-8?B?RUxJOHA4a0lYVjZ1TldIRityVzlKZjQwSHNtQjlpbmRLYUtKUlhKZ3lSV01i?=
 =?utf-8?B?emd1UTJnR3hGL01QYllwcmUzK3E0OXl0UTZuRTZZcURmcDNkMnVIaEVaQkFw?=
 =?utf-8?B?RXdVRTMvUFRQNnNxVFB0TVhmd3pwT2xwejZXc1h1di9pVXFEYUU0WSswa2Vp?=
 =?utf-8?B?R05hcEUzN3hkVjV2SzNTTTRvSE83c0xNUkViQ2diNzBRckRuaW52bElpOHJF?=
 =?utf-8?B?MTZ5U3BPVGx5RE9VOU1XcHJOL0VJUUhiS1FGcjV4d3RnS2YzbHNYWmQ3c3cr?=
 =?utf-8?B?OG4rU2RrM2E3Q01UbklGWTlrcW5aTVRXb2FOT2FDVDJKTjdBalJrWVNXazZq?=
 =?utf-8?B?QWd2bUhZRnhIdWJtekF3ZmtXNzlNcmljOVczcmlTVmpubmUwdmVkcGErcGZG?=
 =?utf-8?B?ZS9uenlOU2tCbUUxMWNjcDlwZ285WE1pUnh6NFJuKzM0OElGcDk3ZHIxOVpv?=
 =?utf-8?B?Y2txcXdDdzRhMm5qMndGczJtODUyb1V0aXVZeHZPbDFQM0pqajVrL1kvZHpu?=
 =?utf-8?B?S0RWY3RsVmtGN3JZT05oWkU1Nmp0ZnlJNi9VUFI1RmNXa1l5S1B0dWpRalZz?=
 =?utf-8?B?V05IQkt0c0djYkhURGxEa2x2NzF2c2tTME9SazZSNTRYbG9nZUcvWUttYyt3?=
 =?utf-8?Q?sYnQpL60Z6h9Uk94Ly5n2T3sY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221c9e24-e08f-4816-a91d-08dcb6925062
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 03:37:51.3022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6YQTCuZsOMK0oqiTypbLFQtHN6Y8hnpgySgNj8PxTXSXIUxdiOC2xpTqRTer1n7aKfhIFQyTrsHES3eHe4a3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
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


On 8/7/2024 3:02 AM, Alex Deucher wrote:
> On Tue, Aug 6, 2024 at 4:18 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> Add support for logging the registers in devcoredump
>> buffer for vcn_v4_0_3.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 34 ++++++++++++++++++++++++-
>>   1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index dd3baccb2904..033e5c88527c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -1823,6 +1823,38 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
>>          adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>>   }
>>
>> +static void vcn_v4_0_3_print_ip_state(void *handle, struct drm_printer *p)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +       int i, j;
>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>> +       uint32_t inst_off, is_powered;
>> +
>> +       if (!adev->vcn.ip_dump)
>> +               return;
>> +
>> +       drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
>> +       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> +               if (adev->vcn.harvest_config & (1 << i)) {
>> +                       drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
>> +                       continue;
>> +               }
>> +
>> +               inst_off = i * reg_count;
>> +               is_powered = (adev->vcn.ip_dump[inst_off] &
>> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> Actually, we shouldn't be checking whether or not VCN is powered up
> when we print the results.  We've already stored the registers so we
> don't care if VCN is powered at this point or not.  VCN could be
> powered down by the time we print this.  It would be better to just
> store a flag to determine whether or not we logged the registers in
> the first place, then use that to determine whether or not we print
> anything.  Same comment for the other VCN print_ip_state callbacks.
This is exactly the same being done here.

is_powered = (adev->vcn.ip_dump[inst_off] &
+                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
The above is already stored at the time of capturing the dump, i am just checking the value to make sure if it was
powered up at the time of dump and if yes then add logs to devcore dump else skip. Its done this way rather than using a variable as there could
be multiple instances of VCN and one may be powered or not so power state is captured for each instance and based on that value only its we are printing or logging in devcoredump.

Regards
Sunil khatri

>
> Alex
>
>> +
>> +               if (is_powered) {
>> +                       drm_printf(p, "\nActive Instance:VCN%d\n", i);
>> +                       for (j = 0; j < reg_count; j++)
>> +                               drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_3[j].reg_name,
>> +                                          adev->vcn.ip_dump[inst_off + j]);
>> +               } else {
>> +                       drm_printf(p, "\nInactive Instance:VCN%d\n", i);
>> +               }
>> +       }
>> +}
>> +
>>   static void vcn_v4_0_3_dump_ip_state(void *handle)
>>   {
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> @@ -1871,7 +1903,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>>          .set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
>>          .set_powergating_state = vcn_v4_0_3_set_powergating_state,
>>          .dump_ip_state = vcn_v4_0_3_dump_ip_state,
>> -       .print_ip_state = NULL,
>> +       .print_ip_state = vcn_v4_0_3_print_ip_state,
>>   };
>>
>>   const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block = {
>> --
>> 2.34.1
>>

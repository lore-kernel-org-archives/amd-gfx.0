Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936C5C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 14:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3D010F17E;
	Thu, 30 May 2024 14:12:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1m8eCkG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBB910F17E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 14:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS103qzi9GwCQPBzZ/Hs+erMP+Ge3CXJ7x9IWnPhQqbE6TXAQdacRnKzWQbZ3w+/h+vnSR5RM1FVGLOvXzVO09XUJ5EWopALe/wuZQY9c9zf8fAf/47SLYiq91pNPY9r0eStyt4wOeHPPyHHRa4a/CNNr+KZXOHN74A2dn7AC8GpFCu9sIDVr1I70gHzPFE/wnQFOmO9MX2tt8aksRpRhqbRTADaBoJjjAPq+l7IzAFES13BWOERqW8cr20RebEkJVyaDe+2hHnXeSsRUbZdqSKiISaDwrRoCrALjAb5wMPoOjMmtQfxrbp0Ue5y0oVZ/0nTNCJRVvwZgAtebOEhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5qbXo9AU05nLuNdhGc4wTpYL+rMfwK+pYt1NKOgsKQ=;
 b=Wm6rAflG02iDG2mL148WjLNg41sKO5vckgF1BwVB47e5jLNsvrrBYne/cTynvS36BPYFnajL7V6UHl9P+Q7Gz0NOiY+3KOAp3z802zV10FLxjMKJkWcv99kYhRyMH5+/5wQVwTtYU048LpOYuBYwuULTbVKAPmSHW4jYflUKrWJWUGW1lD8xD5zS1EG26hj3njilRZ8Rpygm0gFp3WDnStWsTo4LTOioUA6s5YvMaWz3bnAwhKJLPpd6tYMS+hpUW4x8Hk1lBvvCFI2Z3NF081xVlWfo5kUdSFpggE4Y6C943H6OI8NURjpJu0Rc6mnUXIIYvzt14F+74hkCmU8iAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5qbXo9AU05nLuNdhGc4wTpYL+rMfwK+pYt1NKOgsKQ=;
 b=Z1m8eCkGihtcGrzjOxy01joSWKCa9N0ZsrlJ2LMQlUtInz4kSDRLUvn4PBWmHtCj9N3yEHtNWqApeT01w6G4wkylDesJIYLXmSASMuNT7zkn7nVgsMW4Av+U3RlCsrgEeGjuXqusYaLyy1JN/NpqQ73NlFF/4V7i91AqniKZWwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 14:12:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 14:12:28 +0000
Message-ID: <15b6ed13-acd6-4363-90ea-e5e87a834a59@amd.com>
Date: Thu, 30 May 2024 16:12:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdkfd: Comment out the unused variable
 use_static in pm_map_queues_v9
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240530035012.2341573-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240530035012.2341573-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f70209e-5c50-44bb-0996-08dc80b289c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzI2bkwvaVNJODNVZHRmMG5WVGZCTE1xNHgxOU54Mmg4VVJEcUtjUGlxYkIy?=
 =?utf-8?B?a2trMm9hcmxTbFkrSEY1SllmaHJ0R1ZPUERYcElsQnltdUhiNHZSSk01RnBB?=
 =?utf-8?B?YlhLaVU4ZXVMK0JObE9udEpSMU8xNkZwYTJ5dXZBcUR3TDdUNU82WDlJSXJZ?=
 =?utf-8?B?M1phRnMrelNTREE2UlhRV0ZIWUI0ZW9nakFuVUNyRWRVUW90T2JuUXN0TVBX?=
 =?utf-8?B?bGRnMDllKzVtNUtGRisyNUNrU2p2Yy8wVmo4Qm1KRnRSbmVURWJLQUphbVYy?=
 =?utf-8?B?RnVqRUo2RXE0cHdpVEFzazc2SVFOZFNMVFJxNnVUajZQVUd1ZmFublM5MUhX?=
 =?utf-8?B?WlhrZHQ0UnV5OFJOSTA4cEVsRUVTcmZrL3UxRTFTVmx6N0dXNTFnWFd2YTF2?=
 =?utf-8?B?WG5QbUJ1VEkrSEpVYWxjRFY3cHlQS21pQitNQTJkL09JY1ZaMDJXS05JcSth?=
 =?utf-8?B?TWNJdS93UmdFSElMYzUzQzM2SmVRSkJnaHNva0lNVnpwWld5SWJYRExrRnpk?=
 =?utf-8?B?cFJZNlk5MUlURVNaa0J4VitUNjNlWWpyNjRqY2FRTDdZYUxaTDdUaWFoak1E?=
 =?utf-8?B?cGJXaEpHYnBrNTVSRHBZc0xTRlkwS2dwOFZlMWg1aGxkZUs3eW5DcWVCZHA1?=
 =?utf-8?B?clJ4ZjlSdW5LZUVDTkRGNnhEY3NGdmZPRGJKWGV1T05JdktTSzBtWFNJU3pI?=
 =?utf-8?B?RVdTbWdycWtWUjA0V2FKd3JrNUlaZ0FYNkZOb3V6RkV0cmdLRjd4b2NoMitD?=
 =?utf-8?B?dEdxM0lsQkJadm9xRGQ1WDZOd0hGbTZZeEQxN3hIaHBHTFJFd1piSWNrRnZt?=
 =?utf-8?B?WnVyWkd6dWFLSXI3eGRadnl1S1NyMzVmM09DSG5hR0JiRFYvamYrTzZGNDVN?=
 =?utf-8?B?RXUyTFlNV1V6UXR3dmMrYStqR3dDTTgwd3RDaFg3cjNWNUZPSGZzdnc0d0lt?=
 =?utf-8?B?cVRVcFI5R1FUMHVjWGFLcTlDV3NsMkU1U29OVXBLaXk0ZlNjbUhoeU96OUdJ?=
 =?utf-8?B?emVPTnY2dGRrbW1ucWJpcEE4Z0ZmWHNGeHZyZFZ4ek5JYWtEMTB3NnNCVmJv?=
 =?utf-8?B?V29jYzJRc1IwYWZmUHFIMlFHRjNVUk04ZGRVUko2eVI0Nm1UWHU1OHJTRjRq?=
 =?utf-8?B?S3Q2bHJjUEZXbUtleGNKVXlQT3diemgwS2ErK3FvQ1l0cG1Rbm4wcDRuNnQ3?=
 =?utf-8?B?SDV4b0doZitwcUxsNStIa1ZJb29KZG5KQ2Q5T2VQNlhCbmtYa296Q3VVSnN3?=
 =?utf-8?B?cGs3eEdmd0h1amhxa3prU0x0dUZVbHptZ1B2d1hONEdLb3VVeW1wYVM2TGU1?=
 =?utf-8?B?RnFGbDVOc2VERk1tRjZDQXNGM1l4Nzk4dmI3Y05TZTkxZzRnZEloTkNDd2Jh?=
 =?utf-8?B?ZmExY2hqbWgvYjVIUlpQaTZ4dFdXRHhiYVBMeGxpWThYWFo2cmdwbnJwU0dp?=
 =?utf-8?B?V3ViZU9mS3Jka3Z5OWF1Rk5vZ2RRNUFRSUc3cXBiUUdRN2UvRDdpNTd3ek0w?=
 =?utf-8?B?ZFJpNC9CV3EzTzl0NzY3NFlQWEVnVk5WWEJBUDhvdG9vUFJxL3hITmJEVGpN?=
 =?utf-8?B?Tnc1TUI0YW1kMGZSUmg5aVRkczVXeGxIblExczV0T1JzVlRIS0NrRkRjSFlU?=
 =?utf-8?B?cXptZDBlYkVqVFNScW0wZzBSYWRyVm5tUEZlV0tKejVwSUJXOW1obHNQK3lX?=
 =?utf-8?B?RGU4M1gzc1lwanE2dkwvNnlKaDM4Uk9EVk9ZWmEzYzFFM21jMW9jYWRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmxmWmUzb05tRU51SkpxdDliUkJDb0UxTEFzOW0zR2ptWUZWbVd6QU13Z0sv?=
 =?utf-8?B?YzUxbElibER1YUl3ZkVYcHI0aFVNTWhwdDViQUQzUmE4VXJBTkV4VUFMaU1G?=
 =?utf-8?B?OXdEcm9GQWtDSnBkQjVpbjBKbmt5LzRXK1VhN3FwSzhtakdXcmNua3FHaG5Z?=
 =?utf-8?B?SXhoT2JuMUZNdmt0aFUvakh3d0h6cUpPNEp1WGN6L3JqU1ltc3FzOEk0aVpH?=
 =?utf-8?B?SmxXOUR2QTExNGVqcVdzbHN1YnVnazhvRVdmL0piWmZQK2hsR25zY1pDbTBM?=
 =?utf-8?B?eTErbVBWanBaTG5GRXBxcDhKRVhtb0p6UnV0N1UrYmExamNJRlh0c0xoM1NN?=
 =?utf-8?B?RzZDK1NaTFVuL1poVThrN09uYi83TWg2TG12RDA3cUxOcDhROHQ2YkpYL1pX?=
 =?utf-8?B?MW05RlZFTU5WeURlMlhZN0l2WVpKMlllNkg0cWd0bERCbVV3VzAyZmRldktF?=
 =?utf-8?B?aDlmVkR6L0Vac0VxR3FEVmV4ZkRjZVBXS09VOHdIakxkRlMySGpKVmxVQlkx?=
 =?utf-8?B?QkRFR2dYMkV3aFRuL2hNQUs2SU9KT1hFUjhSREN3cnRTN1JIcHh0Sys4M1du?=
 =?utf-8?B?VTRvY2JoV01hbU5kWDBxS0pTN0xsY2ZXNnJ4Y0lub3J0dDdUbGx5ZlhKOTdo?=
 =?utf-8?B?b0YzZ29KbXg1QVZ0eVF1Y0VXQWgxbmxPV0d3R3ViR0hMWEZkTDZtb0NxdXBR?=
 =?utf-8?B?bU4wUUk2a1FZandGUGdESFRyTFd0czc3Rzg5ZXI2NWpQaFdVS1VEWkppbk9a?=
 =?utf-8?B?a2U0R2pzdElQVk1WRGRqdzVyd1YxcEhSQzVhNSsyR1dFd3lSS0lzYUtWUXJL?=
 =?utf-8?B?RmpzUTJ4YWxzUmY5enBkTmFkNVJoRWxld2Ezb3UzSnZQY1BXWXprUXRFN2hC?=
 =?utf-8?B?Vm5QSkVuNzlheE8renhvNEkxNGhaMFpRNExRZU82Wkt3RmVLZGlTcm54czlI?=
 =?utf-8?B?a09XY2doVG00ejkwYzJuQzhobWpaMU1qbCtYQWorQzNIaGhqQkQ1bUY0R0xz?=
 =?utf-8?B?dU5FZkNKa01mWUY0ZHJGdDI3RHdyZW9jcFc3RlJjWmkrK0tQc2Y2dU51c1pD?=
 =?utf-8?B?UjJ3eUZCOStReFN3cFUwclYyTVZzdHdidnhzRVh5dG1OWEw4TktxcURLWnk5?=
 =?utf-8?B?WFhrYUhhSEg5TGtlQ3c2VGRuV1V6ZzhpeHc5VC9SSEhoYlE0QUhtOFhKRjV2?=
 =?utf-8?B?cm54QjMyanRkWFNsWlZaeG83QUl2TXJLZnFaZUozRGRjL3B0R2NkM1BIQmlw?=
 =?utf-8?B?ZE1tVFhSNzJQTVBOU2ZncG1uSFpxRll6ZFdsNDB5MFY0SXZCT0JkTkNFVlFi?=
 =?utf-8?B?MlR0RldGZUlZRHM4YlJMdlNVQ29kYW83Nm1EY3QxYklLZytpZlNSVGpVWDhk?=
 =?utf-8?B?YWViZmdMRUdJdytWd0cyVXpwWWtwSjE3V3dmKzI2NGRDMTVKajJCdkpRV0xD?=
 =?utf-8?B?MVZzT29ZRXRmbUxKNFZsUnBwcEFmQjFWN3IwL2NtUWl3UUltTURjT1dFZVRI?=
 =?utf-8?B?bjdlSUtDVkltSEsvTjZwKzNETXhRMThDQmVEay84R2M0M0VFQzJ0MFhtSjlZ?=
 =?utf-8?B?SDRJalBmMnp0bmFIbGwyWnYwdlE5aTZVVXhVOGVPbEVJMWNqTnhqWmNZZWp0?=
 =?utf-8?B?cHFlanEzSVhEMTZJdVFIOG1uZUFZdG5SeGN0QzI1MG9mL1dDU1VmUW9kaWJv?=
 =?utf-8?B?ZVRCMGsrcWUvRHEvbzJsa0NTTVRzS0tsOTIxT0hFbnMzNnZha3kxVXZoNEsr?=
 =?utf-8?B?ZDJPL1hTYm9QNnBtQ3YxZjZuMGNNUU0zUThzMk1UNS8zVG8vb1FFYjc2dVlS?=
 =?utf-8?B?a0RvamlYV2krZWVhb2NRZWJEeW1UaXowem5YaHl5elg4SkU1TzhYTzFKcnM5?=
 =?utf-8?B?ejhBRGtVMHBvRTAxNnlzY044eTR4QlpIVlU3c3ZBVEd4cUNWV0tOK0YxejNV?=
 =?utf-8?B?YjVWVWFIK2ZqZllSOWNNTStKMk9abHpneFpONVVkS2hVSkorQm9IOCtoSnBl?=
 =?utf-8?B?d2pzQnY0L2hiTGo2MFZ1TndabGVIV2cvbTEvM1hmRTErQVMyNi82US9JQ0dh?=
 =?utf-8?B?REZwVWFOZnM4ektzVTRoMU0vcG5YdGpmZlNQTVdCdFB4S3d3MTRNZ0FzZVpC?=
 =?utf-8?Q?aTb86Hbidq3onuE3HNDvpgBfP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f70209e-5c50-44bb-0996-08dc80b289c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:12:28.6063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6ahipKg+SYRm2bFREP516GAcWi/TJzseJwsWwJfDpjFoQW2z0FzK9VAArrYhwtd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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

Am 30.05.24 um 05:50 schrieb Jesse Zhang:
> To fix the warning about unused value, comment out the variable use_static.

Commenting out variables with // will just get you another warning from 
checkpatch.

Christian.

>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 8ee2bedd301a..c09476273f73 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -244,7 +244,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   		break;
>   	case KFD_QUEUE_TYPE_SDMA:
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
> -		use_static = false; /* no static queues under SDMA */
> +		//use_static = false; /* no static queues under SDMA */
>   		if (q->properties.sdma_engine_id < 2 &&
>   		    !pm_use_ext_eng(q->device->kfd))
>   			packet->bitfields2.engine_sel = q->properties.sdma_engine_id +


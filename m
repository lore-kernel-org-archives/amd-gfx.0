Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE934CAC5B5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 09:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A26610E6C7;
	Wed, 24 Sep 2025 09:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wdZ2C1pX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E3E10E6C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 09:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whdrHpY+m01mLFpHRVVQJSjWW/1kefRW5RiN7vSsvhVuS9rJMoFMyuhGeMWWtYr8VoYUwYkOJjI0iGgUrZQi7DludQ2v2vz7Bk4hTYK40s9A6Ci4F69AYZIJln7dljXb8CP4uee0Wx8TpO/67BcVhWQMaf4woV5lBfraKzGAHcfDsXyjJQvoNnU0xw1hz49YwGOsn6v5SbovcLdwBxxt3A1viQ+qZ+dzYWEOPpfYb35Fs5MayOMllckmW3nGEdL3mbsxNOnrEKVnDgMEsV0af9Fmmd5nX7JFRRcXNSdZ9xsoAcPHm9Z1SUt5E3NRj4N7jG05sT6mEHMjzeAPWir//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MQAaLevgZImilm8rcMK90qfVU0iD2vGsiVa/eypBes=;
 b=OhYCscrx9QbBjPmM3ukyWL9sKkVWgN9N5wCcdoXrsTQX2rgNKtSjWoEoJwKoj4mU19mrDLg7Xa1NEFZAvxqY+x5vTpRJpiRAucLXMfH15zYPMKDrIgqlXApQ0tfrc65GS6AmDXqvG19RufE8F795I+yUrp2K8I6tNgy0uuQgdJt5uk8BXSps1wxKEvh7xbnWYBYWje5JcPJTMf5BJ87542EYydTSvxqijrPZLiWTw2MpQbfbZH6J1W/JfbsccRQmCwSkveGPSPxnTjwRlM11bC40bqWly+tOGWjKIoI5TTwcXRY0wka03BF8YGQqdHenVTSxW2lwsC1sQWaimd/V2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MQAaLevgZImilm8rcMK90qfVU0iD2vGsiVa/eypBes=;
 b=wdZ2C1pXA9yyEgqqUFrUlUg0SbnBb5tSmocDijTQM7ag5E9WFYERUXBBSKczXFiTn8WvYqh82YElhTtCP7EXUPtP17FQldfc0IKVY8Tw/OxqoRUcsWTsj2rvGfZvfP1N9vq1OzL1YqgAbZiFa0zOROPhb79npKWO4S6W26oJQJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 09:29:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 09:29:32 +0000
Message-ID: <11a5dba9-fa4a-4d1a-913f-36cfa71390c4@amd.com>
Date: Wed, 24 Sep 2025 11:29:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 1/2] drm/amdgpu: Convert amdgpu userqueue management from IDR
 to XArray
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250924073715.2335544-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250924073715.2335544-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:208:23c::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7e2cf3-8eec-482e-1933-08ddfb4cddd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tjh5akNTK2d2ZkVaYnJDbUE0cjBWRFhmbnhySVo4STZibnRyeWc3Y3p5YjJi?=
 =?utf-8?B?K2xybWFDanVTdmx5UFBvcElmZFdxNkNIOGcwT2tsM011TExmZ3d4VjF2dFZ5?=
 =?utf-8?B?elptR0RIdGtqTjBDUFVKUE5Pbys0eUwrOHkzUmY0QnpmcUlPUmplU2FSOThD?=
 =?utf-8?B?V0JGZW5yNWxUSkowTjVuaFNrRGNwS09XS2dFb2ZwVmNkdjNqWVV4NHA3dVR3?=
 =?utf-8?B?TmNlVk9ZTXA2b1lFR3Brc2E1Vm42RmNORzYrOWtweENzOVNpM3RrUVM5RnFq?=
 =?utf-8?B?UDN1cHZ3R3VXTmdZbUtsVm9hNTMyS1VmaEhwRGlRaitzTDdRUWFpcGliQ2JY?=
 =?utf-8?B?Rm5TOTJQZHQxb0pZdnUzKzM4YTJMRkJFZDlOcmI3YW5HYm4xWHpKQmdBNXFB?=
 =?utf-8?B?OVp2NkNtUCtsRTM2Z2d0WlNqTFY4VDkzVGtkaXgzbzQyazA1ZzJ2QWZIMlNU?=
 =?utf-8?B?WmxKQzYrYkc1TkZ2SGZ0VWhEY0NMb3lnN1A2NVI5Wm5EdFBMTEdidWNkTHpa?=
 =?utf-8?B?STU0Wlh1OFV5WVZQUURVMWtWcTVRSU9zQ2FmR3licVhXeVNoY3c3NE8wb2d1?=
 =?utf-8?B?WUF3ekNiQVJBd3licFVwalU1L3RtSzhoSWt5UDJnbUdWcFB5T3dpUElpbERP?=
 =?utf-8?B?d3kvVzRqNlNqSUxiVUtpbC8wWmZjR2dsVkJNZDV0WEFJaUI4alJSbU1IZVBE?=
 =?utf-8?B?SExRd3BzWkRnWEE0VFFNMndQTlI3VjAvQjVYckM1ZFd2QTFQamVkdkVMOEVh?=
 =?utf-8?B?a1EyamRpak9DZ0JaWlRHR244dWRRQ1BZZWxPODFuckRTOHQrNG5CNURSRmJ3?=
 =?utf-8?B?bnJBdDBCazNmRzFDR015L3F5cVQyNXZSeXRRcVY2NFhBQlVFdE9FSHZHTURp?=
 =?utf-8?B?UWpyRGRnNWxMai8vSGRrbXRSbnB3L3JNTUFBSHR0RWF2UUlsdXdqRXlhazdP?=
 =?utf-8?B?a2NEc2J1K0xKRmU1TXZCcWlOQUJ2ZlhZbjRVOFFUb3EzUUxRQ0lpRVAweU91?=
 =?utf-8?B?aGYxU3IwdUdpVFNSOURMTFVLMzZLY1IwbDNKc2lLcXYxampkQitVd3ppZHl4?=
 =?utf-8?B?Qk9wR2RzNXJJUG5BNmgrWks0dTFWa3VqTmdzbWV5WmxTa09md0t3YlJOTnJX?=
 =?utf-8?B?Y0RGQzBrOW5qQmYvRnE2UkY1eEZZWEQ3VkhtK1JwUWFmNFM5VERXV0J6bWdm?=
 =?utf-8?B?cnlBTmdtamhLdGQvcmNTY2tPekU1YmhnK0QvK1BqcVlMU0pQUENaMUhnZ0lC?=
 =?utf-8?B?b08wVXZ2NDEyU1g3K3kzeHVtdURIV0k2aTAzazFGeVpoZldoUTRUaExvZXZX?=
 =?utf-8?B?UDhkRVZvTEpTbklId2xqbTJvZTdMZjBkUzVmb2QrNHlKNENCZG1XT0t4cm9S?=
 =?utf-8?B?NVllY0VpTktYTjdJM3VURkFNU2lhRjRZRm0weFBubmd0dFJaeWViQkJuemE1?=
 =?utf-8?B?aHlQYTFwNkROeGpqcmVXbzQ5NkZpMTliSkVVMFIzQktSWDJmemVQbFJsbTda?=
 =?utf-8?B?SDk5Q29raklIaElldWFFUHV0ZGxoTDFzVFNvVXJ0UFdyemZwU1RIVjRVd0l0?=
 =?utf-8?B?bEVxNEpSQTYrSHEzdzFNK3BITURLZFJtaFppVXNKaDZxSm9NaGVqWHZHSTFp?=
 =?utf-8?B?Z1p4eU5ucVgxL1BJUGRkZ2ozdnBjTFFOekJndkkzQWphSlJScmVFMWZVZTRR?=
 =?utf-8?B?RU1VOVBSd0ZibW9Oc3VhYUVqMXlLUmY0NHJwdzZPY3drWEVIaTdtT3BFMUt2?=
 =?utf-8?B?NHRZY05JZ2JobkE1T0pXUUtVamNROWs2YjloaklKOGlMNUxseGFrS1huTVhY?=
 =?utf-8?B?Z3NUcTlUZEFBT1FXU1FUYmtPNDJ2ZVcwLzE3MWFKRVFVL2hJc09xS1NwMnlu?=
 =?utf-8?B?a3gvV3Z2Yk9VNWozYWJQSmptNWZKQTZMLzFpcWk1RVJaSDVpdEpaTWlHWDdW?=
 =?utf-8?Q?CG6qEte/OgU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnVBWTQzNk1SZCsyR240UjQxbk5keWs3QmIxR2lhQmR0bk9WblVtWmhjR2hr?=
 =?utf-8?B?SDU2K1VQYXEyRXljVTB0cTk5b0MrNnEraHhjNXRhdms0YmMwVEgwVm1aUGZ0?=
 =?utf-8?B?TTBWcHN5VEFCYkJ6N3kzTnBObDNpTkoxTC9lSmlWWXVmN05TbC94Ym0wWVho?=
 =?utf-8?B?YStobzZESC9pVlhwTHpVZzFkNEoyaXRvKzNQUUdSbnJxcWc1MDM4WVA5OXBJ?=
 =?utf-8?B?eXJScXdkNlVVbHNQaVhrWCtXdlBZQ3ByNGRiT0JJODlzU1JxNXpaWWVqVWkz?=
 =?utf-8?B?Smt6NGJxUnVwaFo3WTA5ZXFiekxxQkhtUmZubVZLQ1hWaG1VUS9rOWpwTXN5?=
 =?utf-8?B?MXVGeWJCU05MMEJ4TEVOdXRTSjRBN2JLSFBIRURUQzZSOTRVTzBDNXRvNXpS?=
 =?utf-8?B?NVdWSk83OUlQcjVzM2VhYjNHaUdpZFg1UGJWMmlSZ1dSSk9YcmpzVDZEWWN3?=
 =?utf-8?B?VjJ4WTExZFIySFRSQUlESnBIVUxsSFNEMDlxUnkwZjVLQm9wUnpzSmVaU3VK?=
 =?utf-8?B?MkMvVitxajBQdVlhY3pkNDJvUWhuWnRvY3gxU1k3NTBDUzZsa1JVTHBUMjU4?=
 =?utf-8?B?VmFPK2dhMEhrcEFCZHRIYS9oODZNKzBEVUpJRWpwKzI5amZtOGNkT09uY2ND?=
 =?utf-8?B?UitPTWlvVkxTYzBkYWptT0hKaXlkbzEvZmVxUzV1VWljZXRJUStzMitpNXFv?=
 =?utf-8?B?djEwWVFxSGlZUWxET29jeHUxUHFqcjBLeDIvdGdtdUpISUlnUzV5K1lkVWho?=
 =?utf-8?B?aktpQUNvQXNVQkRGWE43SUV6VGNNMFZ2QlRiaDZja0lERmNtQmhkaHpqeEZ1?=
 =?utf-8?B?d3V3NlNkRGVhMjUxZzBMNzE4b2ZHTERULzE0MGhsMWRTL3QyRTZFazY4R2Vh?=
 =?utf-8?B?Q3gySnVsNUZMK0JFaGlXRzVmZXd5V1kvSS90aWh6Ylp1cnJrNEViU3F6eXdI?=
 =?utf-8?B?L0pBSUd6ZE1OZzV1aTN2Q3lBZ0Iyckd0WXZqN3BNM2dzbUZkL1A1aHM2WnNB?=
 =?utf-8?B?dTJrc2dvRE9lbGRJQ3ZtQ2hSQXVSRWFZVnkwMUovOUp0ekVIaXlnUnVFTmY0?=
 =?utf-8?B?L3JWdkViVElaOFJzU0dkQmlVb2lZaks3NDZuN3lnMXA4cUs5STRqemRzTDNz?=
 =?utf-8?B?WC8xVHRpOStta3c3NjVidmZFR1dycFAxdm81VWVSNGMxUTJHR1poYXEyQmtS?=
 =?utf-8?B?WUFTVm5yeFJ1ZGRxZkp1YlVJUnhlMHlHSGFNUGdEL1ZCb3hwUDl3ZnU1R0Rs?=
 =?utf-8?B?U3JQQUE2V1psNFlSM3NiZ1VqTnFBRlc2U0FZUW1md29hRlVxN0FFdFIyMHVK?=
 =?utf-8?B?cEZkQ21kdG1SUjFJdjYzUnZWc2hzTFVpZkZ0UDZ2dWVFV1ZXaFExNEdqdFJF?=
 =?utf-8?B?WlA2Ky9NT2QrVitVanRwK1ZmOWd2RHpqWFVUVEdDbWt6alZEYkhjbG9xKy9o?=
 =?utf-8?B?dzdHM214cXZCdllQL2lsaGY2dGs0OTQvZ25qbHhhbUNtUjN3UXZnTEoyYmx4?=
 =?utf-8?B?OTc4T0EySitiamwzYzBpTVYrUytkcnpxb291Y0xUZW51VWlJa0p0N0xqVjVj?=
 =?utf-8?B?eHZmQU9lNnczVUlUVmRCRy9ReFdGOExOWWVPQitWNE5qSERYK0UxRUdlUlla?=
 =?utf-8?B?MTh4c3FOSksyOTdUNEp2VWFBcHZKRjRaYTczME40NmRjaFU0clZpYjJ4a25z?=
 =?utf-8?B?QkRnaCtVWWthdDZ4WHpudzE3dVZvVGpwRVpFVzliaUhQN1o0aDU1YU45YkpP?=
 =?utf-8?B?dHVMeVJXb1hoM1hsRDQ3S2NuWW5SdWlNMEczSmRxZXppbTNHVjJ2UmVIT2Ri?=
 =?utf-8?B?Z3NiVjBHdzRQNFZENEEyWkI1NU9aUEM3RHZneDQ2dmE0ZDZ5MnlFZHhmaURr?=
 =?utf-8?B?WUNTejd1MUZ0bGRTU1BzZXBaaTdWZEJxWVNyMW5IL3pGNXhwMFdNREFXYkYy?=
 =?utf-8?B?R1MvZjByZUQ3R3RQVmVpaWJQZFJ2WlVsVWh0TjU3N0dqcTllV29vMmNpUTRL?=
 =?utf-8?B?YnVDSmpKbGprRlZTQXlCYmVWNEJYZjl2aFh1aXpLSFUyaEVOK2EzMTV6aGdM?=
 =?utf-8?B?dzdxYnRZMXI2Um1jYWJzb3l6cWN1Y2N3b1k3aUsyNEw3NllnamxFMlNCaGdI?=
 =?utf-8?Q?TVrzmHESbR0h86gDtuWdf0Lxp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7e2cf3-8eec-482e-1933-08ddfb4cddd2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:29:31.9686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vq490UKnXnQ87R+IQt6zPl4+M5oOoBSEk0fWL3hn5Wp2xhFb5kBvHzBhxvn9gjK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
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

On 24.09.25 09:34, Jesse.Zhang wrote:
> This commit refactors the AMDGPU userqueue management subsystem to replace
> IDR (ID Allocation) with XArray for improved performance, scalability, and
> maintainability. The changes address several issues with the previous IDR
> implementation and provide better locking semantics.
> 
> Key changes:
> 
> 1. **Global XArray Introduction**:
>    - Added `userq_doorbell_xa` to `struct amdgpu_device` for global queue tracking
>    - Uses doorbell_index as key for efficient global lookup
>    - Replaces the previous `userq_mgr_list` linked list approach
> 
> 2. **Per-process XArray Conversion**:
>    - Replaced `userq_idr` with `userq_mgr_xa` in `struct amdgpu_userq_mgr`
>    - Maintains per-process queue tracking with queue_id as key
>    - Uses XA_FLAGS_ALLOC for automatic ID allocation
> 
> 3. **Locking Improvements**:
>    - Removed global `userq_mutex` from `struct amdgpu_device`
>    - Replaced with fine-grained XArray locking using XArray's internal spinlocks
> 
> 4. **Runtime Idle Check Optimization**:
>    - Updated `amdgpu_runtime_idle_check_userq()` to use xa_empty
> 
> 5. **Queue Management Functions**:
>    - Converted all IDR operations to equivalent XArray functions:
>      - `idr_alloc()` → `xa_alloc()`
>      - `idr_find()` → `xa_load()`
>      - `idr_remove()` → `xa_erase()`
>      - `idr_for_each()` → `xa_for_each()`
> 
> Benefits:
> - **Performance**: XArray provides better scalability for large numbers of queues
> - **Memory Efficiency**: Reduced memory overhead compared to IDR
> - **Thread Safety**: Improved locking semantics with XArray's internal spinlocks
> 
> v2: rename userq_global_xa/userq_xa to userq_doorbell_xa/userq_mgr_xa
>     Remove xa_lock and use its own lock.
> 
> v3: Set queue->userq_mgr = uq_mgr in amdgpu_userq_create()
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  16 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 143 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   8 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  22 ++-
>  7 files changed, 97 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2a0df4cabb99..ae10832a09f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1174,6 +1174,12 @@ struct amdgpu_device {
>  	 * queue fence.
>  	 */
>  	struct xarray			userq_xa;
> +	/**
> +	 * @userq_doorbell_xa: Global user queue map (doorbell index → queue)
> +	 * Key: doorbell_index (unique global identifier for the queue)
> +	 * Value: struct amdgpu_usermode_queue
> +	 */
> +	struct xarray userq_doorbell_xa;
>  
>  	/* df */
>  	struct amdgpu_df                df;
> @@ -1308,8 +1314,6 @@ struct amdgpu_device {
>  	 */
>  	bool                            apu_prefer_gtt;
>  
> -	struct list_head		userq_mgr_list;
> -	struct mutex                    userq_mutex;
>  	bool                            userq_halt_for_enforce_isolation;
>  	struct amdgpu_uid *uid_info;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0fdfde3dcb9f..e066f7ff2a82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4483,7 +4483,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	mutex_init(&adev->gfx.userq_sch_mutex);
>  	mutex_init(&adev->gfx.workload_profile_mutex);
>  	mutex_init(&adev->vcn.workload_profile_mutex);
> -	mutex_init(&adev->userq_mutex);
>  
>  	amdgpu_device_init_apu_flags(adev);
>  
> @@ -4511,7 +4510,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  
>  	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
>  
> -	INIT_LIST_HEAD(&adev->userq_mgr_list);
> +	xa_init(&adev->userq_doorbell_xa);
>  
>  	INIT_DELAYED_WORK(&adev->delayed_init_work,
>  			  amdgpu_device_delayed_init_work_handler);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index ece251cbe8c3..fdea7cd4b3ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2771,22 +2771,8 @@ static int amdgpu_runtime_idle_check_userq(struct device *dev)
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct drm_device *drm_dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> -	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	int queue_id;
> -	int ret = 0;
> -
> -	mutex_lock(&adev->userq_mutex);
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -			ret = -EBUSY;
> -			goto done;
> -		}
> -	}
> -done:
> -	mutex_unlock(&adev->userq_mutex);
>  
> -	return ret;
> +	return xa_empty(&adev->userq_doorbell_xa) ? 0 : -EBUSY;
>  }
>  
>  static int amdgpu_pmops_runtime_suspend(struct device *dev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index b649ac0cedff..0712b88782c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -180,17 +180,28 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>  {
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
> +	unsigned long flags;
>  
>  	uq_funcs->mqd_destroy(uq_mgr, queue);
>  	amdgpu_userq_fence_driver_free(queue);
> -	idr_remove(&uq_mgr->userq_idr, queue_id);
> +
> +	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */

Wait a second where are IRQ handlers accessing those XAs?

> +	xa_lock_irqsave(&uq_mgr->userq_mgr_xa, flags);
> +	__xa_erase(&uq_mgr->userq_mgr_xa, (unsigned long)queue_id);
> +	xa_unlock_irqrestore(&uq_mgr->userq_mgr_xa, flags);
> +
> +	xa_lock_irqsave(&adev->userq_doorbell_xa, flags);
> +	__xa_erase(&adev->userq_doorbell_xa, queue->doorbell_index);
> +	xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
> +
> +	queue->userq_mgr = NULL;
>  	kfree(queue);
>  }
>  
>  static struct amdgpu_usermode_queue *
>  amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>  {
> -	return idr_find(&uq_mgr->userq_idr, qid);
> +	return xa_load(&uq_mgr->userq_mgr_xa, qid);
>  }
>  
>  void
> @@ -462,8 +473,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	struct amdgpu_db_info db_info;
>  	char *queue_name;
>  	bool skip_map_queue;
> +	unsigned long flags;
> +	u32 qid;
>  	uint64_t index;
> -	int qid, r = 0;
> +	int r = 0;
>  	int priority =
>  		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
>  		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
> @@ -486,7 +499,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	 *
>  	 * This will also make sure we have a valid eviction fence ready to be used.
>  	 */
> -	mutex_lock(&adev->userq_mutex);
>  	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>  
>  	uq_funcs = adev->userq_funcs[args->in.ip_type];
> @@ -546,9 +558,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto unlock;
>  	}
>  
> +	xa_lock_irqsave(&adev->userq_doorbell_xa, flags);
> +	r =xa_err(__xa_store(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
> +	if (r) {
> +		kfree(queue);
> +		xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
> +		goto unlock;
> +	}
> +	xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);

You can use xa_store_irq() here.

>  
> -	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
> -	if (qid < 0) {
> +	r = xa_alloc(&uq_mgr->userq_mgr_xa, &qid, queue, XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> +	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
>  		amdgpu_userq_fence_driver_free(queue);
>  		uq_funcs->mqd_destroy(uq_mgr, queue);
> @@ -556,6 +576,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = -ENOMEM;
>  		goto unlock;
>  	}
> +	queue->userq_mgr = uq_mgr;
>  
>  	/* don't map the queue if scheduling is halted */
>  	if (adev->userq_halt_for_enforce_isolation &&
> @@ -568,7 +589,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = amdgpu_userq_map_helper(uq_mgr, queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> -			idr_remove(&uq_mgr->userq_idr, qid);
> +			xa_erase(&uq_mgr->userq_mgr_xa, qid);
>  			amdgpu_userq_fence_driver_free(queue);
>  			uq_funcs->mqd_destroy(uq_mgr, queue);
>  			kfree(queue);
> @@ -591,7 +612,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);
> -	mutex_unlock(&adev->userq_mutex);
>  
>  	return r;
>  }
> @@ -689,11 +709,11 @@ static int
>  amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
> -	int queue_id;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	/* Resume all the queues for this process */
> -	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
>  		r = amdgpu_userq_restore_helper(uq_mgr, queue);
>  		if (r)
>  			ret = r;
> @@ -846,11 +866,11 @@ static int
>  amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
> -	int queue_id;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	/* Try to unmap all the queues in this process ctx */
> -	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
>  		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
>  		if (r)
>  			ret = r;
> @@ -865,9 +885,10 @@ static int
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
> -	int queue_id, ret;
> +	unsigned long queue_id;
> +	int ret;
>  
> -	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
>  		struct dma_fence *f = queue->last_fence;
>  
>  		if (!f || dma_fence_is_signaled(f))
> @@ -920,44 +941,30 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>  			  struct amdgpu_device *adev)
>  {
>  	mutex_init(&userq_mgr->userq_mutex);
> -	idr_init_base(&userq_mgr->userq_idr, 1);
> +	xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
>  	userq_mgr->adev = adev;
>  	userq_mgr->file = file_priv;
>  
> -	mutex_lock(&adev->userq_mutex);
> -	list_add(&userq_mgr->list, &adev->userq_mgr_list);
> -	mutex_unlock(&adev->userq_mutex);
> -
>  	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
>  	return 0;
>  }
>  
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  {
> -	struct amdgpu_device *adev = userq_mgr->adev;
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	uint32_t queue_id;
> +	unsigned long queue_id;
>  
>  	cancel_delayed_work_sync(&userq_mgr->resume_work);
>  
> -	mutex_lock(&adev->userq_mutex);
>  	mutex_lock(&userq_mgr->userq_mutex);
> -	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> +	xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
>  		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>  		amdgpu_userq_unmap_helper(userq_mgr, queue);
>  		amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
>  	}
>  
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -		if (uqm == userq_mgr) {
> -			list_del(&uqm->list);
> -			break;
> -		}
> -	}
> -	idr_destroy(&userq_mgr->userq_idr);
> +	xa_destroy(&userq_mgr->userq_mgr_xa);
>  	mutex_unlock(&userq_mgr->userq_mutex);
> -	mutex_unlock(&adev->userq_mutex);
>  	mutex_destroy(&userq_mgr->userq_mutex);
>  }
>  
> @@ -965,25 +972,23 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>  {
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	int queue_id;
> +	struct amdgpu_userq_mgr *uqm;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	if (!ip_mask)
>  		return 0;
>  
> -	mutex_lock(&adev->userq_mutex);
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		uqm = queue->userq_mgr;

That function is used during reset, isn't it?

If yes we somehow need to make sure that neither queue nor userq_mgr is properly initialized and not freed up while the reset is ongoing.

The easiest way of doing that is to hold the read side of the reset lock while creating/destroying queues and the manager data structure.

>  		cancel_delayed_work_sync(&uqm->resume_work);
>  		mutex_lock(&uqm->userq_mutex);
> -		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -			r = amdgpu_userq_unmap_helper(uqm, queue);
> -			if (r)
> -				ret = r;
> -		}
> +		r = amdgpu_userq_unmap_helper(uqm, queue);
> +		if (r)
> +			ret = r;
>  		mutex_unlock(&uqm->userq_mutex);
>  	}
> -	mutex_unlock(&adev->userq_mutex);
> +
>  	return ret;
>  }
>  
> @@ -991,24 +996,22 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>  {
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	int queue_id;
> +	struct amdgpu_userq_mgr *uqm;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	if (!ip_mask)
>  		return 0;
>  
> -	mutex_lock(&adev->userq_mutex);
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		uqm = queue->userq_mgr;

Not sure about those ones here, but the same point that applies to the reset handling applies here as well.

Apart from that the patch looks good to me.

Regards,
Christian.

>  		mutex_lock(&uqm->userq_mutex);
> -		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -			r = amdgpu_userq_map_helper(uqm, queue);
> -			if (r)
> -				ret = r;
> -		}
> +		r = amdgpu_userq_map_helper(uqm, queue);
> +		if (r)
> +			ret = r;
>  		mutex_unlock(&uqm->userq_mutex);
>  	}
> -	mutex_unlock(&adev->userq_mutex);
> +
>  	return ret;
>  }
>  
> @@ -1017,33 +1020,31 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  {
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	int queue_id;
> +	struct amdgpu_userq_mgr *uqm;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	/* only need to stop gfx/compute */
>  	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
>  		return 0;
>  
> -	mutex_lock(&adev->userq_mutex);
>  	if (adev->userq_halt_for_enforce_isolation)
>  		dev_warn(adev->dev, "userq scheduling already stopped!\n");
>  	adev->userq_halt_for_enforce_isolation = true;
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		uqm = queue->userq_mgr;
>  		cancel_delayed_work_sync(&uqm->resume_work);
>  		mutex_lock(&uqm->userq_mutex);
> -		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
> -			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> -			    (queue->xcp_id == idx)) {
> -				r = amdgpu_userq_preempt_helper(uqm, queue);
> -				if (r)
> -					ret = r;
> -			}
> +		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
> +		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> +		    (queue->xcp_id == idx)) {
> +			r = amdgpu_userq_preempt_helper(uqm, queue);
> +			if (r)
> +				ret = r;
>  		}
>  		mutex_unlock(&uqm->userq_mutex);
>  	}
> -	mutex_unlock(&adev->userq_mutex);
> +
>  	return ret;
>  }
>  
> @@ -1052,21 +1053,20 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  {
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
> -	int queue_id;
> +	struct amdgpu_userq_mgr *uqm;
> +	unsigned long queue_id;
>  	int ret = 0, r;
>  
>  	/* only need to stop gfx/compute */
>  	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
>  		return 0;
>  
> -	mutex_lock(&adev->userq_mutex);
>  	if (!adev->userq_halt_for_enforce_isolation)
>  		dev_warn(adev->dev, "userq scheduling already started!\n");
>  	adev->userq_halt_for_enforce_isolation = false;
> -	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		uqm = queue->userq_mgr;
>  		mutex_lock(&uqm->userq_mutex);
> -		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>  			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>  			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
>  			    (queue->xcp_id == idx)) {
> @@ -1074,9 +1074,8 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  				if (r)
>  					ret = r;
>  			}
> -		}
>  		mutex_unlock(&uqm->userq_mutex);
>  	}
> -	mutex_unlock(&adev->userq_mutex);
> +
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index c027dd916672..c562c8d2b53a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -88,11 +88,15 @@ struct amdgpu_userq_funcs {
>  
>  /* Usermode queues for gfx */
>  struct amdgpu_userq_mgr {
> -	struct idr			userq_idr;
> +	/**
> +	 * @userq_mgr_xa: Per-process user queue map (queue ID → queue)
> +	 * Key: queue_id (unique ID within the process's userq manager)
> +	 * Value: struct amdgpu_usermode_queue
> +	 */
> +	struct xarray			userq_mgr_xa;
>  	struct mutex			userq_mutex;
>  	struct amdgpu_device		*adev;
>  	struct delayed_work		resume_work;
> -	struct list_head		list;
>  	struct drm_file			*file;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 95e91d1dc58a..cc597fae8971 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -537,7 +537,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  	/* Retrieve the user queue */
> -	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
> +	queue = xa_load(&userq_mgr->userq_mgr_xa, args->queue_id);
>  	if (!queue) {
>  		r = -ENOENT;
>  		goto put_gobj_write;
> @@ -899,7 +899,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		 */
>  		num_fences = dma_fence_dedup_array(fences, num_fences);
>  
> -		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
> +		waitq = xa_load(&userq_mgr->userq_mgr_xa, wait_info->waitq_id);
>  		if (!waitq) {
>  			r = -EINVAL;
>  			goto free_fences;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 2db9b2c63693..9e4229c79c69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -205,9 +205,9 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>  	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
>  	struct mes_detect_and_reset_queue_input input;
>  	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm, *tmp;
>  	unsigned int hung_db_num = 0;
> -	int queue_id, r, i;
> +	unsigned long queue_id;
> +	int r, i;
>  	u32 db_array[4];
>  
>  	if (db_array_size > 4) {
> @@ -227,16 +227,14 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>  	if (r) {
>  		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
>  	} else if (hung_db_num) {
> -		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -				if (queue->queue_type == queue_type) {
> -					for (i = 0; i < hung_db_num; i++) {
> -						if (queue->doorbell_index == db_array[i]) {
> -							queue->state = AMDGPU_USERQ_STATE_HUNG;
> -							atomic_inc(&adev->gpu_reset_counter);
> -							amdgpu_userq_fence_driver_force_completion(queue);
> -							drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
> -						}
> +		xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +			if (queue->queue_type == queue_type) {
> +				for (i = 0; i < hung_db_num; i++) {
> +					if (queue->doorbell_index == db_array[i]) {
> +						queue->state = AMDGPU_USERQ_STATE_HUNG;
> +						atomic_inc(&adev->gpu_reset_counter);
> +						amdgpu_userq_fence_driver_force_completion(queue);
> +						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
>  					}
>  				}
>  			}


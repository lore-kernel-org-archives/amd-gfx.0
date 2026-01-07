Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECED9CF6C12
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662BE10E08D;
	Wed,  7 Jan 2026 09:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QhwRV3RX";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F09B10E08D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 09:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMT2dmfoG0MHTFI3U22GvgRp8KMlHQjf1rryIzNddjoVlOnVqQa/WwJD4mNrk+xD9an+gp/kTzVb1HDtFEdi6kU/F3ORhlsPwK4sH2uvga5VjC/uNVIt0VcMlCOoszY4vO1vYZTgK84UnFCA3cw2etc/nifTE9TXayB8zHSaHFYvAFG3/WPQENtooU3PYS3TyXtAKFn8JYsMpBeJe2jqqhpu4UyGiBhON2JK4e7I2AL++9lA3S5ufffHfdcaSrhHxnkYXaOw8849qAl1VvB0TtJqIjBbztlkQzu4d6tFyd1RD3SbUMIXzt+Ztcwr6cSnYfaH0lTKZAeureDVDI7ZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zl9osTuDe10nDNxwsphudjvryh7+IZAdIJQSgav9Vvk=;
 b=i8Ev/09kXh1G+pKRpuj23R8DYxxh1/slsMK3lCdJxvnu1noINCul5BGjYrbVh0j2iJi98uekGy+xzTIPI9XwZ7yKSxwbZGKtq7H9tOEcQCZMqtYq+j1SlX2lKlYrayn8cuWvpAJnrnPSnmaAOLZxvrEsXhZ2QIGkzH93kBjNXukArGBLK6q1YTiWUea6G/vbRjPiX14yhrrhBdseztpmFgmeB2i/gKVL9rhPIGMIQ1lwMCJiRzQAeLtw1NYNMdn0AaiOZurUbORiC2hTa5/zgtI88z6cApptwHfj5irRDerbpKpc5vGP/hZcXrMAQP92Has273/evwrQz78EGuWAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl9osTuDe10nDNxwsphudjvryh7+IZAdIJQSgav9Vvk=;
 b=QhwRV3RXPnOzC/M+znlOuI9b5xOEBhbw+7/4KyyOVXHk6x1msf3BdHBbbG1J7c68JCW7pTNvynFXoo6laHgc2Ibe+sACYPCt2/ELhANG2kTLSfcyuEmJPr2zu0MmK3C89pmNdzF/WrGpYhJ627FcStvzvCNg04UAp1R4FgVmBUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 7 Jan
 2026 09:01:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:01:26 +0000
Message-ID: <f56064d0-ecf2-45d7-9ba2-15501454fc06@amd.com>
Date: Wed, 7 Jan 2026 10:01:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] drm/amdgpu: Remove duplicate struct member
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-7-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251219134205.25450-7-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0406.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a5f8dc-fc2f-4beb-53fa-08de4dcb56fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUFOREhWQlliaXlZRjZLRWxjVjBUa1RYVUk3cmU2eTRjNS92YTRPMGNLekdv?=
 =?utf-8?B?QW55UkVPTWx2Rk9Ibm1UUTg0K3NFVXd0N21HNFN6QWlYNllMcENPWFVsUXFI?=
 =?utf-8?B?ZjRTWnlEOWMxcEYxQno0ZVNET050emMydW04YzN3WnNEcmdoNU1zc0U5RVlk?=
 =?utf-8?B?RWp2aTlGRDR5U293eGpkWHlHcEg1QmNwcnlGSUVSSWJ2WTJyVVJ5Si80R0lB?=
 =?utf-8?B?b25ZRDZmSlBkRkJyZE54Y2dNb2Z6cXh5N3Rtb1l1a2hEV2x3aWRqaE5YdDVR?=
 =?utf-8?B?QWdTL0ZlSndwWlJpVW5KQmhjbHBLc0xyQ2MvQ2ZPMFR1elVoQWYvNzE5eFZX?=
 =?utf-8?B?eDlNRzBZdE9UdFVLT1JuSGJHSjJZRTN1cm0xN0hSMFZCbkdDWm00UUIrOHgz?=
 =?utf-8?B?ckZ0UVFpa1krS0JoZUhGUTJpZUhoeGpNczQzMkNsSVArL2VTdGZUZVlWRE5p?=
 =?utf-8?B?K3BiZHRXcWdzTnFaQTVhT2VjZVFjZ0FKSVArSytqbDQvVUV1M0tqTHhmeVRX?=
 =?utf-8?B?c0ZHenVhbnkrSnc5eUNucmhJcThLcVFoVWZiK0tpVlFBdDdmenZQNzdrVUtG?=
 =?utf-8?B?NUZPR2NDWnZkVzNtV0lOTnNXQlRlUjFTaUNqMjI3cE9uUEp1ak1GWXJYYm1l?=
 =?utf-8?B?dmF3eXkxV0RJT01rdVc2QWt6YXFPRUttYWtoQVJFYnpLNFFVNXRmd3F0MWov?=
 =?utf-8?B?cVZscXBvSGpwU05raEhTaFZuSERxVEswOGUyWWliVnBORW9mMEJDVFNyaFhO?=
 =?utf-8?B?RmJBS3gram5mUjJiMGhRYUZOWVl0Tk9xZlVCaTJPNTlLbDFSdjBkbkU2ZC9p?=
 =?utf-8?B?USs3Zy80b1VDdnluK1F5K2hzS1NiWjJnYzl4ZGRmaVBEYkVhNlpWM1BiRUIy?=
 =?utf-8?B?KzZsdmU1bTgyeEQ2UlcxM1NSQVEvamVpM1FZMlFoNm1nVG1DOVgxMmtYdWY4?=
 =?utf-8?B?Y1dUSmh3WXVvVGNlLytHZi91Sm5qLzBhWUZqNXcwOENxUFo4ZXVuNW5NMlRC?=
 =?utf-8?B?N0x0SXBSdGJpWkpFM2VMOGFQSkVteGVFbi9sT2JJcWdzbVd5ODhYTzJjbkU3?=
 =?utf-8?B?RW1CWEVsZEpRSjROUmxLbFJTNkFkS1R6Y05IOUt3Ny9sdzJDVVZ0TmFQQWlU?=
 =?utf-8?B?R0xDZjNoNEp4bHc1ZWtyTnlXWGZ3N1d5eVUraGJZOE1oZ0VxdFErbXNFWVlL?=
 =?utf-8?B?S1NPYWNNQmdiTUFiek9YTFhrUjBXL1hRUXh1YnM5Zkw0S25iTi9lM2h5LzFh?=
 =?utf-8?B?cEZVdkg2Y1ZtaDIxZk1yblVEeXBHNlRZLzcyK1ZOWTlVUkl1Z3Y3czlEaUlt?=
 =?utf-8?B?V1ZZTkVKU0hRNVVlWmpPTC94TnZwT1lYY1hKaFFGZHEzVTlWTU9iR2dFTUFm?=
 =?utf-8?B?K0hxWGozdkYxd2tWaWxzS25Lci9VOUNhcVN4a0puMFhNaFhvL2VobExFcFZT?=
 =?utf-8?B?c2ZzZ0tValdXcXN4Vzlrc3BBZGtMQ1pCUlNoTksxTUU4aUpMS0Z2eVdicWU2?=
 =?utf-8?B?VzR0aGpzVTdtNmpFbWhxM0F4UnNibjhVeVM2dEpHMitzTjEyaUpzeWFsYWY4?=
 =?utf-8?B?QTlJR2dKeTk4MWpLdlRxN01WMVdnbTM0R29FM3NZRk1hYytBSFd4NDJJSkl1?=
 =?utf-8?B?L2tFR2dzWVhKMjZJSUFiZVdjM2dBUHhTNmFoaW5YZ0Y5ZTJtMVUvWE1JM0ZP?=
 =?utf-8?B?azRoYnplZTNsaDM2MWsxTkJKdXYwR0NsQ2wvazNJK0JLMGtNaDNxV1dlaDNR?=
 =?utf-8?B?em5LaUtidDhYU0I2STdERHpmczU1NG1yQ0wzNjJCaHBXcmVnYnpSQ1N3UXRD?=
 =?utf-8?B?WTRpN3VOWU9OZjcxQVdRUTQ5WUc1SHZGNWFYRnlYU1h0dU04Vk9vMWpBWEdY?=
 =?utf-8?B?ZW0vTHI4TzdrOUtXL0lNc1M4dnNXc1dvRXZ0VmhTdk10YkljSk8wdTZwZk8y?=
 =?utf-8?Q?GCBMC6xrWYdbe/dpfykW/tJDwjhsZyCx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBqZ0VZRUdvVkpnTkd5dDN2SzBSZUd0cWJ6Y3loRzUvSnc1YzZKZTgxYUw2?=
 =?utf-8?B?c25CcE84WUNKblVmYXJidjVkU3lPcXRpTzB0WTM5Q1lTMUhxQTRiQTluRWVp?=
 =?utf-8?B?SXhZZjdEbCtjSTB4V0JiQ0VCWFY3VWcvMGlPbEZRYzd2L25UMkdRcmMvS2lp?=
 =?utf-8?B?ZVdQdlF2V3BoY0krV3lkdk16MXFodUF0UThSRFJXZEFYem9OcmZIUGFXN3lG?=
 =?utf-8?B?TWR6eWU3NDdyazB6YmJHZVAvd0dYbkIrSzhMMXVOTFAram5SZ0dvZkE5dlN6?=
 =?utf-8?B?Q3R6bWJqQmlnWEFtZnZxTDYxamtqbGlkeitvK0RqM2NPVElrTndkTDFKVlkv?=
 =?utf-8?B?SjA0R2ZUMTBOalNvZlAyY3lEaXowWjVtVW9SRmpPSWFnek01NGNJWGFGd3Zp?=
 =?utf-8?B?M2plWWd5NTA5cVY1NEFMazdZcXB4eGxWNHJmS2VoY0VobU14SEVBQ0lvU2li?=
 =?utf-8?B?SHA0ZXNoWEt4L1hZcVh0dG92UEh2eU5KMlNhZGcyMTZDY0JaVzQ4anRqbnpI?=
 =?utf-8?B?eXB0bkozbVZPc1Z6ZlYvL0JhalhWSnhwUm1xSlg0OHVINFFqcXZBTHZnWnlJ?=
 =?utf-8?B?Q0M5a2RhWWNKRHZRK0VnSHRaS055dmd1b0RvN1kxalkzbmpCR1BCeXIvMnJB?=
 =?utf-8?B?NmRGb1dQTGVpVGY4RHhiSlJXU09OQXQ5bnlOU0VwaWxzSnRsaDUwWVhFbTNJ?=
 =?utf-8?B?NmRNRGJwbEhQdVJYZ2o2S3BiR3hTM1I2NjRoYnc5NWF4RnQrUEtXWjhnYWZZ?=
 =?utf-8?B?dkthdU9NZDBvckl0cTRKVHpoakpSZ0UydE5MeEdjL0xpbEpOUzl5Mkd1bitr?=
 =?utf-8?B?VWx3dVBGK1JZaTYyQ2NldHYrOUZFMnhacld3QnZ1cS9vZ05iS1d0bG9ZN21I?=
 =?utf-8?B?NlpQM2E1K1JNbUhzVDRjdzgzMXBadElRWGU0OG13RnIxSnBVaVc5dXlzTUl3?=
 =?utf-8?B?UkRJMHRlQ05tRTQ2NDRGVFoxSjIzL3ZGWkNoT253YzNDQ0lUa0lTM0YzS0J4?=
 =?utf-8?B?SFJwcmtOQS9qMS9CMytpOUVldEp2ckhOTGsvWmhkNmU4RTJkb3F2c1BiS2RY?=
 =?utf-8?B?UXZGL2UzbXYwR2lod1c2QTI2bC96M0d1QVFWOWhHY0NlYUhPQXNMRUY5QmE3?=
 =?utf-8?B?cm5jSTVNSEQwTnA1S0xqSzFWeDFESWFZQXhRVjZ3cjE3ZVk4Smo3MmpPUDEv?=
 =?utf-8?B?YWkzOGlLRHBubWxEa1pzQUwvVWgxUVQ4UkRPOGxCMm42RXlsdE5NSTFESW5Y?=
 =?utf-8?B?MFlWQ2FvaGdsZmZsM3liUE1vOWtLdmZSOFdKQ2tNSGIrNDdvcjlZaENkWTZr?=
 =?utf-8?B?UjhYMXRhUGRZYitTR0o3aXhmVE5QN2lPaHJvaVJhM1NUeWVJVk8wNVhuVzRm?=
 =?utf-8?B?dzRzYVVYZ1hPRTBuWWQzRnhicFhaeE52cExGU2JBSTFJZkpmNHpqcXRiZC9M?=
 =?utf-8?B?WXRjVFU1eUZpWWNwSWRZSCtMU2NXYXRtZzdoUnRRbjVTd2t0TEZaSWVUZ1li?=
 =?utf-8?B?VWpaRndHV2NjWFBLM3lxbXpLRmdNLy8rRHFBa2ZrUTRoM3A4OGxHTEwySkEw?=
 =?utf-8?B?dnJjRkZHQlZ3K002RW5uV2hZUGRueW9zTFRHWVZzN0lBdmo4YTVUQ2JNMGI1?=
 =?utf-8?B?NU8rQVJjdkxVNUlsYlFvNUNXdVU3NXBaRTh1NGRDS295ZTFtNFZZZ2xXa2dR?=
 =?utf-8?B?MXNlaFhzK253SzNyZUNKYkRZZkhkRTA2dHIrTEVTNkNaODR2WDJ0VzlaWWJJ?=
 =?utf-8?B?czZUMlc3Y2Nad2IyRFg4ZlVnVVpZQzNxakk3bFhLRlVTUFd0MlFYNjJOUFU1?=
 =?utf-8?B?eFVNK3ZWQUNKSi96cUZjUHdSR3RPUUlHYmlIOU5FZmVkV2VGcnJwNEpvdG8x?=
 =?utf-8?B?TEJDenBYT1V0VFZtSlRHQ3I3MUg2R0R2cmlzNVJ0SmdybTloK01STGN5c1Nq?=
 =?utf-8?B?NTlHUGxBeVI3eDZKSm5rTzhnbFlUUG12dnM4ZkNXSTA0bEsrOWUwVXpFODhG?=
 =?utf-8?B?M1ZLU3Y2UUtBNjBodjFYQ0Y1Mk84d3JlY21lcllPSUNsMVJPeTZPcm5aYjg3?=
 =?utf-8?B?RXhlV0ZGS2pFeDlPSzRwMEo5NXo5MkcyKyt4Tkc5NzBkMkV2SnRHcEZEOGFW?=
 =?utf-8?B?a2FVbXJZcFF3WUtZNFMxdnNrbGJ2amtMR3NiYmNZQVBHTVFna3J6d0NwNVky?=
 =?utf-8?B?WFRxWTRUbHplb3hTWTVJdHlFZkZySngzYzBCSlZlZk8vajlqZmIvOFpscmpa?=
 =?utf-8?B?U0FkSC81WkRPQVNCSk4rM1h2S3JJek5MOFBxT2cweUpDVXRQWUY0aGpOODZx?=
 =?utf-8?B?Sk1qVExhdFF2V2tra3NHLzNCSVdHSG0xUnQrT1JvNUxwbzhwZ0hzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a5f8dc-fc2f-4beb-53fa-08de4dcb56fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:01:26.7931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZWZAr+qtkdeec7snR/d6ucI9XviQgNAxW6NcKUQnTrgdnbVIgHiMTUOKcyHeGq4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

On 12/19/25 14:41, Tvrtko Ursulin wrote:
> Struct amdgpu_ctx contains two copies of the pointer to the context
> manager. Remove one.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index afedea02188d..41c05358d86d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -232,7 +232,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>  	} else {
>  		struct amdgpu_fpriv *fpriv;
>  
> -		fpriv = container_of(ctx->ctx_mgr, struct amdgpu_fpriv, ctx_mgr);
> +		fpriv = container_of(ctx->mgr, struct amdgpu_fpriv, ctx_mgr);
>  		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>  						&num_scheds, &scheds);

Well that code is utterly nonsense to begin with. amdgpu_xcp_select_scheds() needs the xcp id to select from and not fpriv.

Can you look into re-structuring this so that we don't need that cast?

Thanks in advance,
Christian.


>  		if (r)
> @@ -349,7 +349,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
>  	else
>  		ctx->stable_pstate = current_stable_pstate;
>  
> -	ctx->ctx_mgr = &(fpriv->ctx_mgr);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index aed758d0acaa..cf8d700a22fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -56,7 +56,6 @@ struct amdgpu_ctx {
>  	unsigned long			ras_counter_ce;
>  	unsigned long			ras_counter_ue;
>  	struct amdgpu_ctx_mgr		*mgr;
> -	struct amdgpu_ctx_mgr		*ctx_mgr;
>  	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
>  };
>  


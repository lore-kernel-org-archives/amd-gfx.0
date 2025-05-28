Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5312FC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 11:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF52A10E5DD;
	Wed, 28 May 2025 11:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ByoO8yZG";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA1310E5F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 11:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygLnyqr/GSEZ8P6q7OKkTf782s7dUb98yLZKp81t4jNJ/Cz4zfAMGjGPCFjePuHCvxnQruBU3pONzQ0h00fdf+fy+K7gQw/DXTjZ0vkpLH0wZvViROcPoemovgy0kJFL5lLYOEpTpXdFOzlwXQAz7nLwcTaJ69mIhRSK4JOdtN1xvCefOK6pQfUPs3iFFU/hVa54JkNB3gyaIEVTLgXej31j8FsI1uv0kgwrUI8DRTrL96fJWvobYy71XFs9vC/vYJMxs7/w6UH1ccqPf0E7utxMDEu7Z1pZiMD1Vs7E+teqD5SifPXORfPovH1NhYPmfjyPmjomQOlsv29peRZ7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyKd6lnv26mwZS7AhiwCS0ZOLXo6omOq4LQ+2gmryVY=;
 b=GheuGZvdo5nylCfPJTm/NVpuE4oEZSEkXJSMx8z+cNaDm7ivL6QijsRISIdN0Az/IuQD6zppOdYOpZf1xl3By9IjjK0KMtWsH81q2A6giY8zOh4fdcSvLhX9B040HU7aSbTG5fuk3fcBTkeBE8erQ5G4jgNgM6qsbZTFor9HKyjrdV+0BGNuusLBKiIoS3Y0YORYntEhU9klj7w3pFzDFepPYTUKtC5WbB/DkRP/JYgUgFsNJJajNufSfS4k4xFNqDWvM4MXHZ+1vbKJfPXdRjhuBPHekodEwjuAjXw45FECNAI9nYv/mWocjHYVWZWV8ZY4dYedHAL75MI991gxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyKd6lnv26mwZS7AhiwCS0ZOLXo6omOq4LQ+2gmryVY=;
 b=ByoO8yZGyTLBmGi0ZfvAN2hcdlahZaVuslSKxVW40Y7XP6ILBYHqJ/e6i+/GUgjaERZsbvS4gdf7ja3cjLehroTT+TVTEzR6an3bWrRE33icOcVSXUp/OKmByOWm7hCjTjwH3nc8U6kU+/2gUnAioks+R5Qqqf4ZXRruhS79mzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 11:17:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 28 May 2025
 11:17:55 +0000
Message-ID: <b8e1e096-6a50-4b3b-8fa7-0cdbafbe0f84@amd.com>
Date: Wed, 28 May 2025 13:17:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Samuel Zhang <guoqing.zhang@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Emily.Deng@amd.com
References: <20250522104048.569456-1-guoqing.zhang@amd.com>
 <20250522104048.569456-4-guoqing.zhang@amd.com>
 <0d82b43d-4548-4013-87e8-d13ee2f185d8@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0d82b43d-4548-4013-87e8-d13ee2f185d8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c40132-c070-4645-e039-08dd9dd94b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0R4V0srbW5Ccm1JZTFQQW1GK2NkdkNaWHRRcWc4Z2xtOFJFN21vazg4L0Ft?=
 =?utf-8?B?M1grOFpQL2lGQWlHNE0ycHhDNzYvcFdBbHdzR0k5d0NDMUgzNnIzQWcvc2pT?=
 =?utf-8?B?eEV1azcyM2FtOW1HVHlpOGtoTStFSGRkVUlRTkRFV21MVWJGdDZPaTQyS245?=
 =?utf-8?B?dTJyaDhBQXo1OVp3bU9BT0EvWmVCVGJ6dnpsZlZSb1gxYkxlaEh6ejFqRVUz?=
 =?utf-8?B?MTYzMyt6UTBld0h4RUpBZmRkNXZwYnUwQmcxcWxnZTl5a09uOFVTT2N3RHY2?=
 =?utf-8?B?OTRjRi96anJ3eVNlZXllVHZtRzRITkh5RTFRem1tc2thQWFUVWd3bkExS3lw?=
 =?utf-8?B?YVBNSE1ZNEZDSFRLQnBjWWRQYnYwSC9IRVdXejBYa3NVRklCUVZDUjZFS3BK?=
 =?utf-8?B?OXIxeFhySVBTWHplVWpuVEpsN1VTdDlnYkVFTms2Z0Vpb2Q1cEJFQVR4RzFY?=
 =?utf-8?B?aktxOHRvcE1qUUZoVXRvWU9VOVlDbTJrVmJQVW5WY3VNdGZPdERJQzJjVTU2?=
 =?utf-8?B?aDBjN1hBRTJaaVprUzBESWszK0Rnd1pHSlFETEJGZmNSWFN1dGNwaXhpaktZ?=
 =?utf-8?B?YmNmZzhETi9sdXdiM0RyNzIza0VJUU1NdVRaeWVSRjVSaDdjK2lRZVNRVDRq?=
 =?utf-8?B?L0owU3pNcWpNL0lzSjVBRTVqS2NUakE5SjZnbXMxbnhKaUFJa0JQMEx5NnlZ?=
 =?utf-8?B?ckZuU0d2UHY1VlNCQWs2T0p6d2tNT0VKUUxHYm5CS1VEenZTZEpvYU9oVE1U?=
 =?utf-8?B?eGxvUFg2WWkzS2VWenVkQVRqaiswSGhqTWxnOFgwQXVWNTZhbzBkSElpd21Z?=
 =?utf-8?B?emdKSko5YTBFaUJMQ3hGUW51RVlEck1iRmhCeURTOGpvRytDK3lFNHFnMS82?=
 =?utf-8?B?RjJGMkxOelpVSkJCb016L0x4WldLbWNtZW9tR3V5dW9iYmRzZnNkdmhKQUZJ?=
 =?utf-8?B?NVhnSElQelVCZ3FNeHcvQk50bkRBZkszVnlXdVZNUXQrZENPTzJncVd0Z29Q?=
 =?utf-8?B?dWxyaHg1b3dHNUtRM3NSVkdiTDZzQWQxdGJGNDdBZ0RvOFpkWDJNRTI5ZThp?=
 =?utf-8?B?QWNScnhPa3BSUFVjQ21PaFZ2cEJvU3Nuc3o2ZjBZUWFaOEk2OTFWbHhTRjRW?=
 =?utf-8?B?V3U0akRMcGx0U1Z6d1pTbmdSQUczN0dOajBINUFNcHEwR3pKQmVOR01QRnY1?=
 =?utf-8?B?ZG40OE5FVFlSWExzZCt5YWpWT2dvNzZxT0ljTWlqY1hNT0pWZXBtYjNRbnE3?=
 =?utf-8?B?SEpWUTl3SVdOclJTSEFuVVl1cXdZcVZKS291czQ2N29WZHNENE9EbFRtWmlt?=
 =?utf-8?B?S2IweDRnVXpkeTMvdjRYV1U1OFlXbElVQWp3WW9GRHRPeXVqZ0lZTkUzdGEr?=
 =?utf-8?B?VHBKeDFsVmhWcFBOMGJjM0RWWFNCZS9RM044STJwQS9yRlg3LytZdUV2M3NT?=
 =?utf-8?B?SUx0Nkt4VDdBSDU2cUo1cXE0WERvaHpoNDN5aElYYmhybHdNRUZRUnc1d0Rs?=
 =?utf-8?B?aXg3d1hzc2dFS3BoeDhXRGQ0SlV0RkZUVzVLOWpPQ3dxdlBMR2JscUJxVlp2?=
 =?utf-8?B?ejNZZHpCclNXdGVtVE9KcGp2eHVhMzdOOEIzSUhwbEppczdIMTdoMkR3Vlpj?=
 =?utf-8?B?Mm9uWHVzVVdKMHdkbER1OXVRcWE5WTllNnlkb3h4MkE4STV1ZjBKM1UwbVRY?=
 =?utf-8?B?aWVBVHl0Mm8yY1JuVGgwRlVoVjFOMmZubkx0SUJTNWdjU3RkQXBRcEpnTUNO?=
 =?utf-8?B?dVMxVnlDd2xzZmhiOFh6c0ZVMFo4T1N3cDJTM1FSMDZtcXEzRTEvOUpMSndS?=
 =?utf-8?B?dlhoaHZkZy9qVmxKb1IrR2NocUE1WmRiSGtFVTArT0gzNlBUU0dwZ3lodStz?=
 =?utf-8?B?Nk5PdmMwUWcyMnZxTjlxaGN0M2FSQ0N0bUJDb1h4eTkxR2VVMGF6eHRHWkRQ?=
 =?utf-8?Q?dtj52QNBE1M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTg4ZzI3dTdVdkFrQThnaVlOVmFZd2F5V0RIeG92akFpQzRRcmlIZXFSSklZ?=
 =?utf-8?B?QVpIaEdmY2ZXRmNpRXFhZUNxUFdmQ0dwWHdVY3gxeHMwdFk4dXVTVjZ5SmZS?=
 =?utf-8?B?ak00YktNL2UwZFo1aUNQNVdBaXdacHJEOU5ia3RLc3BpcitCR09QTkJ3OXBh?=
 =?utf-8?B?bzhLQjhGRUNJRmRhSHZGdmcyUkNRUDc2SVBlb0hnZWFzZ29VTlU3RFhKUTZm?=
 =?utf-8?B?SnNzZ1ZjS0RLeURzaUdjbmE4ampEWkdwNjRkdFdKNzd0ZjF4Tng1VUUxaisr?=
 =?utf-8?B?YXR4aTEvb081YTVIQUhNeXlubDN3eWhZaFZ6bkFUcnBHaVMyL0VBZUgxT1lq?=
 =?utf-8?B?aXVrK3dNMVlHOCtkTzc2bnVjV21IekNSTExuQVNVcFB4YVVVSmxheHpkS3B5?=
 =?utf-8?B?dG1PWkRlRHBrODJ2bDVoanFHVDFJRWdtSGZMdVhZZ0JKK1pBd1NkZ25Da21Q?=
 =?utf-8?B?ZmM5bXBwdXFOOEZIdDRuVFl2VE5WU3VQd3dVRk9wT2p2YXdEaHg4S1pJWjh2?=
 =?utf-8?B?eVFYTmhoMVFrZnZiVnQxbGxnNU54MUFVSzJ4bDBNaW1vZ3hNenNtQ1ZUNW1s?=
 =?utf-8?B?ZzFRWks2SUJwUUVpdUdaT1h5R0hZUFlydmt3MHpya3owbm56aGs2RyszSlhz?=
 =?utf-8?B?N0g3TTJ3Rlg1UUNiZE1IQ3U0Z2krMkswTGo5ejRvQWxsN1puaVlieHZaZFVP?=
 =?utf-8?B?UW1IVmx1b0tXd0prYW4rZ05naFE3VUIzZjBMR0xFN1pvUGtEcCthaklqZmpQ?=
 =?utf-8?B?c0VBTXJTRUZsUXNhZ1paeGt3TFcwUlNrZlFjaUR0dFlXNnlJR3p4cmJhSW1T?=
 =?utf-8?B?TC9kQUNndXpEK1l2TVRPVFFHVnhWaG5yK3BXVHFUN3VIUExUM29Xd0dSSmFn?=
 =?utf-8?B?NTRWYVQ2Ukx3UmkvVGxOYVpSOWFTL1VDUkdteXhNbVNQdVpMR1VRL3dFeVdD?=
 =?utf-8?B?RzJrbHVGRWRSK2g1SDJtQ2ZuakpMM3p6bVBVRGRBMENzUW1GdFl0d0RYM2Rq?=
 =?utf-8?B?bDc1cVlYZzF0VHVxeWQ2NUhQVCtWdW52UnNOMEx0dzliaS9FRGZyV0JyMk5j?=
 =?utf-8?B?Tm5Wc2swVEt0a1BHTDhQK3drNXNKUnpwWnE4ZXJhQ1ZGUmQ1a2NETGZ2eG9J?=
 =?utf-8?B?bWVGd0hIUVFHZXVGMnZzMThpblB3Z2EyaXozbHd0cFA2TWh2bm15Q0VTTkE1?=
 =?utf-8?B?SVdLY3NNYUZmMXZoODhTbDJDcUk0SThjOEJra0oyMjdRUE54TXpmTWJkV2or?=
 =?utf-8?B?eDhHRS92cTNwNkhtanE4UmF5a1NsRmU1cnQxOUdiVGlEbGZDb29RNXU4aWFs?=
 =?utf-8?B?SXM3b2Y3ekpUcXROOTkvQklYRjJWYlB6dVM5NWZoV2tPZzUvMjhpZEFUbjF1?=
 =?utf-8?B?RTFPRUlSd3M2Q0J3cVByeHVGSzNRN2VVTlJwcTRCSHNxMDNqdnAwdG10MHdH?=
 =?utf-8?B?Nk0rZzVJcTZ5cXVwQjV5ckhJRHFveUdKWU05QnlWVzVMKzR3a0Q1KzFVRUhm?=
 =?utf-8?B?a2M5T04xWjZYMmVSQWJuRnRkWnpxaUJ2KytGMS9lUEdWNlZCb1lnREVoWWQ2?=
 =?utf-8?B?NjB0NzZ2czBqeVJmMWcvdERlNjVsajlZUUduOWp3SElUbXNiUnBMVDFIeGJs?=
 =?utf-8?B?UkxReWNoMUFRSmNKY0p0bkQ0djVDaThlb1kzRTNzY0VHM1NwY2dVZ1hMeVB3?=
 =?utf-8?B?bjRLWnpIajB6SFBDblFXMFE0S25pL3BrN1UxUnE5bkFyWUNmVHpORXBiNHVr?=
 =?utf-8?B?T2xPT3YwcEJ3QlVHMERMYnVvMW5qWlZiaGRadVlJZEI0eURGL3ZVSWx3Snhy?=
 =?utf-8?B?N3VCV001d1BTTmQxRUpWc1E1ZzhFTmcxM0RnaU0vK2IvaFVMakZNM2lUdnB0?=
 =?utf-8?B?SjJZMnUzdjJNY1Q3aGpFUzR4aWdNZkJ0ZlkySWhINmQyelduN1JpT3NFY3ZB?=
 =?utf-8?B?MG01aVIyd0lnYVdOdkhXeExqVkFjTHJmMGhETXVBRjlQajJZOUF5ZHlEaFE5?=
 =?utf-8?B?Sm5DYXZ0c2sxWnJBQjZKbGpmR2tPRVZFb1lNYkthcy8zY2EvcnNLUDUwTnRK?=
 =?utf-8?B?OVJrMTZrcHkvUGYzNFM3SFI3S0tqY2t2SUhwNXlwSDRkV0R1WHdsZEtlWTJT?=
 =?utf-8?Q?73UxIRe80bcetPHV3kjYtKlX2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c40132-c070-4645-e039-08dd9dd94b12
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:17:55.1517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVnc6bI9dTim9gAWE6evk1vXSjGfVuiO8OUJ+CAtKMEPYyeXF5dodt53f6drRKrp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
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

On 5/28/25 09:46, Lazar, Lijo wrote:
> On 5/22/2025 4:10 PM, Samuel Zhang wrote:
>> When switching to new GPU index after hibernation and then resume,
>> VRAM offset of each VRAM BO will be changed, and the cached gpu
>> addresses needed to updated.
>>
>> This is to enable pdb0 and switch to use pdb0-based virtual gpu
>> address by default in amdgpu_bo_create_reserved(). since the virtual
>> addresses do not change, this can avoid the need to update all
>> cached gpu addresses all over the codebase.
>>
>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 28 ++++++++++++++++++------
>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  8 ++++---
>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 13 +++++++----
>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
>>  4 files changed, 39 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index d1fa5e8e3937..74b565283aa9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -38,6 +38,8 @@
>>  #include <drm/drm_drv.h>
>>  #include <drm/ttm/ttm_tt.h>
>>  
>> +static const u64 four_gb = 0x100000000ULL;
>> +
>>  /**
>>   * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>>   *
>> @@ -251,10 +253,20 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
>>  	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
>>  	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
>> -	mc->gart_start = hive_vram_end + 1;
>> +	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
>> +	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
>>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>> -	mc->fb_start = hive_vram_start;
>> -	mc->fb_end = hive_vram_end;
>> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>> +		/* set mc->vram_start to 0 to switch the returned GPU address of
>> +		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
>> +		 */
>> +		mc->vram_start = 0;
>> +		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
>> +		mc->visible_vram_size = min(mc->visible_vram_size, mc->real_vram_size);
>> +	} else {
>> +		mc->fb_start = hive_vram_start;
>> +		mc->fb_end = hive_vram_end;
>> +	}
>>  	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
>>  			mc->mc_vram_size >> 20, mc->vram_start,
>>  			mc->vram_end, mc->real_vram_size >> 20);
>> @@ -276,7 +288,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>>  void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>>  			      enum amdgpu_gart_placement gart_placement)
>>  {
>> -	const uint64_t four_gb = 0x100000000ULL;
>>  	u64 size_af, size_bf;
>>  	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
>>  	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
>> @@ -1053,9 +1064,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>>  	 */
>>  	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
>>  	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
>> -	u64 vram_addr = adev->vm_manager.vram_base_offset -
>> -		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>> -	u64 vram_end = vram_addr + vram_size;
>> +	u64 vram_addr, vram_end;
>>  	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>>  	int idx;
>>  
>> @@ -1068,6 +1077,11 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>>  	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
>>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>>  
>> +	vram_addr = adev->vm_manager.vram_base_offset;
>> +	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
>> +		vram_addr -= adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>> +	vram_end = vram_addr + vram_size;
>> +
>>  	/* The first n PDE0 entries are used as PTE,
>>  	 * pointing to vram
>>  	 */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>> index cb25f7f0dfc1..32a3987bef80 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>> @@ -76,6 +76,8 @@ static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
>>  {
>>  	uint64_t pt_base;
>>  	int i;
>> +	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
>> +			adev->gmc.vram_start : adev->gmc.fb_start;
>>  
>>  	if (adev->gmc.pdb0_bo)
>>  		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
>> @@ -91,10 +93,10 @@ static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
>>  		if (adev->gmc.pdb0_bo) {
>>  			WREG32_SOC15(GC, GET_INST(GC, i),
>>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
>> -				     (u32)(adev->gmc.fb_start >> 12));
>> +				     (u32)(gart_start >> 12));
>>  			WREG32_SOC15(GC, GET_INST(GC, i),
>>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
>> -				     (u32)(adev->gmc.fb_start >> 44));
>> +				     (u32)(gart_start >> 44));
>>  
>>  			WREG32_SOC15(GC, GET_INST(GC, i),
>>  				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
>> @@ -180,7 +182,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>>  		/* In the case squeezing vram into GART aperture, we don't use
>>  		 * FB aperture and AGP aperture. Disable them.
>>  		 */
>> -		if (adev->gmc.pdb0_bo) {
>> +		if (adev->gmc.pdb0_bo && adev->gmc.xgmi.connected_to_cpu) {
>>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
>>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
>>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 59385da80185..3003aa5a53e2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -413,6 +413,11 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[] = {
>>  	(0x001d43e0 + 0x00001800),
>>  };
>>  
>> +static inline bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
>> +{
>> +	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
>> +}
>> +
> 
> What I meant is - since this is generic logic you could keep it as
> amdgpu_gmc_* function and maintain as inline in amdgpu_gmc.h

Yeah agrre.

One more little style nit pick below.

> 
> Thanks,
> Lijo
> 
>>  static inline bool gmc_v9_0_is_multi_chiplet(struct amdgpu_device *adev)
>>  {
>>  	return !!adev->aid_mask;
>> @@ -1726,7 +1731,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>>  
>>  	/* add the xgmi offset of the physical node */
>>  	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>> -	if (adev->gmc.xgmi.connected_to_cpu) {
>> +	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
>>  		amdgpu_gmc_sysvm_location(adev, mc);
>>  	} else {
>>  		amdgpu_gmc_vram_location(adev, mc, base);
>> @@ -1841,7 +1846,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>>  		return 0;
>>  	}
>>  
>> -	if (adev->gmc.xgmi.connected_to_cpu) {
>> +	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
>>  		adev->gmc.vmid0_page_table_depth = 1;
>>  		adev->gmc.vmid0_page_table_block_size = 12;
>>  	} else {
>> @@ -1867,7 +1872,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>>  		if (r)
>>  			return r;
>>  
>> -		if (adev->gmc.xgmi.connected_to_cpu)
>> +		if (amdgpu_gmc_is_pdb0_enabled(adev))
>>  			r = amdgpu_gmc_pdb0_alloc(adev);
>>  	}
>>  
>> @@ -2372,7 +2377,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>>  {
>>  	int r;
>>  
>> -	if (adev->gmc.xgmi.connected_to_cpu)
>> +	if (amdgpu_gmc_is_pdb0_enabled(adev))
>>  		amdgpu_gmc_init_pdb0(adev);
>>  
>>  	if (adev->gart.bo == NULL) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>> index 84cde1239ee4..2e3d0db9bc24 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>> @@ -78,6 +78,8 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
>>  	uint64_t pt_base;
>>  	u32 inst_mask;
>>  	int i;
>> +	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
>> +			adev->gmc.vram_start : adev->gmc.fb_start;

Please keep long lines early in the decleration and especially thing like "i", "r" or "ret" last.

Apart from that looks good to me.

Regards,
Christian.

>>  
>>  	if (adev->gmc.pdb0_bo)
>>  		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
>> @@ -94,10 +96,10 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
>>  		if (adev->gmc.pdb0_bo) {
>>  			WREG32_SOC15(MMHUB, i,
>>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
>> -				     (u32)(adev->gmc.fb_start >> 12));
>> +				     (u32)(gart_start >> 12));
>>  			WREG32_SOC15(MMHUB, i,
>>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
>> -				     (u32)(adev->gmc.fb_start >> 44));
>> +				     (u32)(gart_start >> 44));
>>  
>>  			WREG32_SOC15(MMHUB, i,
>>  				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
> 


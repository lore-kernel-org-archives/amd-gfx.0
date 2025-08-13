Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5ECCA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 16:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D734810E778;
	Wed, 13 Aug 2025 16:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="olzsZ4Ji";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3FE10E739
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 16:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvRclM6nv4a98mxwtKtj8ObqwKHfxlbM8nVCwoiS5kM9TTb06+TZ8LEdtFRkuWs1Y8rlmUIJz8eixBdjezS65TM53/9womTnYgMGPrqbtjLLi0dhNupnlAt183kLZIcJn5moM/STsSx3m1horrLcwH+qyfWk6wN9TTCQzDA+dRTdLZF01+hEma5C06G7uSuNSeuNrnwarbwVjsnldAEsU+YyiBTrw94gbB03eVKs8JQjdWwD9KYLK3tVHLxN1xFK8X5/sexCa+EUTZ1TpYNd0LbLLTMs9Cx5E8fXCVE1tmbPXbkTJHBYyVrD9YRbrRPDWjNCzxcKlX4NpO8lw/1neA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xtcrhur+l8y1mPvXdY5w5b9Y4dqPCLg6NjUzfOx7mJc=;
 b=m68nRZQvAZ6nchiF9WAgJKP66TaA2Qiybb/Bf9zSrTPog+vKmK5N49PqlVsdUGOVG/mpdeiIRD7JIJ7gtR+QGmCRrTUN5C9vmm6XoZLNmEyPnNX6+s3lpaHzAN7B1taTJwmAu5TWI5y4wq47BCPgOJl8nbGkOujeGg/UtnnbKtk6xSvO6oLNeh+2OfSMmGM664+M7cfwU2Vod4wNZZ6up+w/xriE6VnSvrLpbBqzyN++2VWHBmuMibdQGe69itY9TQSVspVe3XMauDyeuIY5QOQWTDloDwA4TlqynjP8e1Cplgnl3wrpyTwguzdjx8o+9Bi0+CzVda8Zc3BcgQataQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtcrhur+l8y1mPvXdY5w5b9Y4dqPCLg6NjUzfOx7mJc=;
 b=olzsZ4JiUVXtWh5UChAG1Uorqo4oQaQJ3LVXNlt84UHj4T2jr0DHCpqF0wfNr2muHb3MTi2zWGws4p/xBK+l9BsrQRRP0u98iC0jiN3hwUmJntXVJAXKNXWWo7r9aUj4mHe7Q69xdsFaVLoNaz8fAJC147ITGzglxa1E0gK1ZUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 16:31:36 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 16:31:36 +0000
Message-ID: <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
Date: Wed, 13 Aug 2025 12:31:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <20250813134504.2037516-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::28)
 To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d876a5-8eda-4f85-4d31-08ddda86df4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0Rtb1dyaXg5ekQ2VmNaVHJVaGFiOUtvNmpvN2ZJbFBEbk14clpoUlV1MkRU?=
 =?utf-8?B?d1ZHUURXUll0RUFjUTF5NXg1bk5hSWhPY0FzQVZ3YWRsOXYzSlJrMnNWTFVS?=
 =?utf-8?B?U2pWK2FZZm1QRW1pYVNMWGtaZjRPUWFsampoeVJNSklaQjFmZU05NzcyaUlK?=
 =?utf-8?B?aDhWK0xLQXQ0cTFaMWRSSEQraDR6WVpCNXdudmdlTEp2NHM2RWlEV2hmRjEy?=
 =?utf-8?B?NUh1NWhDdUJUOUdkaUhBOURGdDYxWmc4NmpXZEJ5K3AyTy9vaVVXY2hVU3NU?=
 =?utf-8?B?NWlySGJJQTJad3FGN2ZRR3JHYWY0Y0lTVUhvc0pINTRETHR4eEE0c25pUWJL?=
 =?utf-8?B?d3crRU0wRFdadGE3OVF2amM5My9VeTMrNi9vRkFkRzhia2YyaDJTQjVETlNi?=
 =?utf-8?B?QjVWemZuQy9KZ3lSNitad3VOU3U4OXA5dStkYWdEOVJLWlVBS1JiQTFmZnU2?=
 =?utf-8?B?bm9WSi9Uc3NPbTRSQnBrby9FbXF3OHNnNWxOS3FXdzJ3UXlBNG9aTjZ2MVhp?=
 =?utf-8?B?SzhRZTBUNFYwYVE2ajE4dmk1YUpRSFBKak9WaUZnMmRkTCtvQmZkT0hWVkFG?=
 =?utf-8?B?M1Q3SklFZ21DZUVnaUY0eTg2VTNZUmVJb3NVVkdlY2swWTdldXNYUnVMZ3Vh?=
 =?utf-8?B?OWZ0VHBxS0lhRUFqTXNYL3ZMRXRTcFRUVHJTcnFQdHgrc0JZMlk1YW80Z2N5?=
 =?utf-8?B?VElBcG8xd3NKTFdYaXk4K3FJYm1OZ2xDQWJUWlpwUFpQL2dnaTB5cmtBZU0y?=
 =?utf-8?B?SWM3TlVaLzkvZzMyem9iclF2Q3R0MkhNVTVDVFNRZFNZSVpGM3dJK3NubEJk?=
 =?utf-8?B?RkdjZXVDODBLbFlXMzY4Uk0vS3FHOUU1UGlwNGV5alpXMkZrbDdqd0lxRGxY?=
 =?utf-8?B?bGFadFVQSTZLUXA0M0ZLd2pEMDB0SlpQdy95QmJLOVN0bWM2OU5UazJLNmN2?=
 =?utf-8?B?L0t1S1dVUU96cDAwdllRZ2JYeEFnV2tSSW5PaEk5MUJNNFFvTDM2MU5JSENN?=
 =?utf-8?B?cEdYa0djbzNDOVZXbm9TYjF5cGFCMG5kMjlTYmNHeStKT24ySjBualRvYURQ?=
 =?utf-8?B?VmxDVjVyTGY2cFNSS3BtbENRa0V6NkJKV0N3WS93UlgxVVBMcXdUMDJFOTFq?=
 =?utf-8?B?cUYyZjR5TFEzc3hQLzBleDUzd1pqSzZ5d3E0TDQ1OTlTSXRNVGp4VWRBYklu?=
 =?utf-8?B?blpYTkhQYjlLQXk5RkRJdmlrT3pIQzV5WXkxSUtxZVB4ODR4YUV5cFpKLzRJ?=
 =?utf-8?B?YkEveXRNaEFRcjBLQU81V3VRWlBtUWUrZXF3aThoL2ZwRWZ5bXdZNGRTRUlU?=
 =?utf-8?B?dDcwWGcwRW5vbWpJWHQrYXMrQ3ZLV1kzRisvVjRyM0xtZ1RiaUg4em83STIw?=
 =?utf-8?B?Mk01aS9tWWJjSzRXUnkrTnRiWnlTSjJYWVI0cmtnSEQ2cVJoRlN6VzV1VE4y?=
 =?utf-8?B?anJpUWhQMXh2Vkx1ajArN1RzSUd1UU10S011dDY5ckw5eVJuZTZGVjdjN01w?=
 =?utf-8?B?b2l1Tmlkcy9IeE8rZW8vVkhPRHVwSHlHNUtYKzRqcS9DTFBHREJnMUtOUGhQ?=
 =?utf-8?B?VGppTW85Y1RGUkpsb0x5NHNZUEUydDFwZjRPMHV4RVk2Zzd6bkRtdmRIOWVT?=
 =?utf-8?B?TUdMc1BXZkRqUmxPZGJ1LzN1ZTJXVjNWcjBhelcyVXhvNVVndURQZ2p2MldF?=
 =?utf-8?B?U2JUSy9sN1ZDRWp0WUxiZkpxMEFuSys4OGZ6K0NXQ04vcDJMd25yMzVYazRB?=
 =?utf-8?B?S0RhekY1N1VBdFFWYzA5V2EzYnVVeS8rb2REcGNIWmZFdzJvUHV5TDFVZmFG?=
 =?utf-8?B?L3JxQ2J4dHdibUZabkp3TUZYTVIxWDhubjcrLzZ5NHZqZ2dQWkY1RFJMeFlw?=
 =?utf-8?B?cFJJRnhGWmE5aElCdHNlMTF3cFlTUGJmZGVycU1CTGdlcDkzUFAwY2xRNkZo?=
 =?utf-8?Q?9zYbwIXKp7E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHkyYUlGMnd1WnVZaG1kbzZ6ektNWlM0aXpabk15eGJJTnN5TFdKeGI2S0V5?=
 =?utf-8?B?d1BrandvODNiazkxcGVsZ2hmZ2lGUUsxMDdmeVllUzVBWlI2QkhGeVkrblZM?=
 =?utf-8?B?RmE4RzVCcGpOQmhuMmpkc1RGRmVjcTVNUFFjVytoZnNqNGwxQW5zWnNNU2k0?=
 =?utf-8?B?VGxyOXFKaFZsZnFCSURSMHFIMWt6QjJwTk94RnFCQVNMM1NjLzV1WjRRU0N2?=
 =?utf-8?B?UEtpZVRUOEhlbUxleGdNZGZ1TnJLTy9iUHl1am9ncmg2NHBzYlROOEtvVjBN?=
 =?utf-8?B?ZGpCZnJHVkkxTHJ5VXdqcDNWUEZ6WklQcUFqd1RqamJiMXBZTE56VTRoQWdn?=
 =?utf-8?B?NldaUkY1cWs0TzdlVXUzQmJ2TW1XVlR0RE9tVEk1c080bFRueHJlMmJwcERP?=
 =?utf-8?B?bytQN2VYTGdvcVdiMWxhU0pUZjgrZjhxMXZWYW01UmRWdm5oWVdFVTNxd2lI?=
 =?utf-8?B?eGNsOGRvN2FEcGQ3RVMzMUxMOFlaVDhXNkt5L3p0bjNpVFNkTmlTZWNGZnBN?=
 =?utf-8?B?RGE0VjhVOTVEYmVnb2tOUEtjZ3hTRDFrWGZDdFZFNDh4VDdWbUtHZGVCU0pG?=
 =?utf-8?B?dVhITWRzTy94dlhUa0djT05QQlU3bG9GSmErdE1VbHJ1VEZIV1RBMGJpQS9Z?=
 =?utf-8?B?N0M5THNlTW1Jb1VvR2E4dEFINk9WUE4yRDdqVUppWmdlWGZiNVVCMUZneCsr?=
 =?utf-8?B?bXNYVmp6aTdPVUUzNGRZcXFuSk50NFFTNjdXTzA2c1BVU0R2QnZ6Qk1HQ1Vx?=
 =?utf-8?B?aUlqK09BWVhlWVhZeHlVbndjZHY4YVlLNWJ4QjV1eDlpTEJGNUtyd1p0SE96?=
 =?utf-8?B?Y3dwczBlR0RwSHlhVnBsVUJWVGwxdEhXelJnWkhrZlNzMlFOVWVabHNHNldw?=
 =?utf-8?B?U2QzNHljYWdWOHlwRUJIODdqT3c2ZnRCa2lwZDR6ZzJMUjRLOUVDRTVadXpP?=
 =?utf-8?B?Wjg5ZmJZRkprMjhvTTVBNGZaaHVxWHRYSkd2aFlTSVpkYjBVc2g5U0NtVW1n?=
 =?utf-8?B?OVFVL2JmMno1b3BOSmFFRlI1eDNGTzR1OEpOQi9qSDRxK2IvZjBHUXh1aHlm?=
 =?utf-8?B?c090RlhwZUtiRUEvVlYvdStCa0ZTUDIrT3lvSmU1VHA5RlRxRThjTXpaMjE2?=
 =?utf-8?B?UzZSVjBTSE9IUFNzU3lXK21GeWt3MG12N3YrcUVqRVlzd2lUM3hHVUhKWGdC?=
 =?utf-8?B?VVBXSC95VTNZT01zUzhaM3lvUVAwT3k2MXl4dEh0dDliSEZuZWh0WUZsdzRC?=
 =?utf-8?B?NTZiaWl6RDlVb3p2VXhaMUJWekZnVjJYdmZuQmx1MDl5ejdhTjBKZGphVE1p?=
 =?utf-8?B?TEZLdGdubTFpMm5tZDJENzM2TktPMW5Gb1R3b0c5ckVoNS9zdlhVT2JFMG4r?=
 =?utf-8?B?TjY3NStLaVJoRm1tNEtRcmNzbUxSYWRvSmoybkhybHJ5ZVJUMm1xTEVkR21G?=
 =?utf-8?B?bGlNdWVrMHltWVZLd244K2g3T0xEZ2wwbWNHVXBzaWtiK25OaktoSFVlL2Yv?=
 =?utf-8?B?dnlkWjd5UytaZ3pmM3N2dWV4NDhRbUVHVVIzdEE4TjIrWWFMSWxIaDcxbkUw?=
 =?utf-8?B?QjU2QjhxQ3M2UFQ1cU5EWjRVQk55Q3oxbkYyQUJ4TUFreHZvd0V3NjNzSEph?=
 =?utf-8?B?K2plWE1tdmhaQzBVOXV1OEtjVnI1VFg4TnlmSXBiVC9Yc2QyWGZYLzYwemZv?=
 =?utf-8?B?TVVtQ1ZPelhVU04ySE1tZk95dlJoRGxBN3d4bytrMk85eUcrSElpYThnd2VR?=
 =?utf-8?B?T0NCT1RHRXFpSE9EOTZJV0RBdm1kQjk3aG04dkJEUEtqdTNKSUxzQTNCT0NK?=
 =?utf-8?B?Ym9MOEx2a1luMzU4cTB0dHdhdzVLTGQwbnRZeG5RSm9HcEFQcElHUUJ5ZnZi?=
 =?utf-8?B?dHRvaWZ2M2ZRb3NFQUwwckpUbWh1U1hGejA1UkdoNkR4MlI5c0RwUk43OGdz?=
 =?utf-8?B?RkMwd3RrMGNqMmh4WW9rTG1Yc1l0V0grUy9yRWVyU203ZGlZWXd3YXJLK1ox?=
 =?utf-8?B?aUxqMkRDMVJDcTJCQ29NcUhwM0hzZnRxSmdVTk53bHlGOWRhcDJKVEt2VUw4?=
 =?utf-8?B?bXN2ZXJTdGpvM01pOHlVVk1uWHBJK01kR3Y0ZzZUMSt2bVdoNGF0UXJmQ0V4?=
 =?utf-8?Q?GzJZ8joc3G7s0TGBh76kH9sQK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d876a5-8eda-4f85-4d31-08ddda86df4c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 16:31:36.5398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYTZn74GKC4d+FpYMXI5krtDaA6MWE2gFgAEYGriGUlY1aK2ugXLi8UrXTb1JNUpdOB9ALnwnMhwk+t94vhSQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
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

Hi Alex,

The addition of  total_submission_cnt should work - in that
it is unlikely to have a context switch right after the begin_use().
The suggestion of moving it inside the lock (which I prefer in case someone
adds more before the lock and not reviewed thoroughly)
  - up to you to decide.

Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Thanks,
David
On 8/13/2025 9:45 AM, Alex Deucher wrote:
> If there are multiple instances of the VCN running,
> we may end up switching the video profile while another
> instance is active because we only take into account
> the current instance's submissions.  Look at all
> outstanding fences for the video profile.
>
> v2: drop early exit in begin_use()
> v3: handle possible race between begin_use() work handler
>
> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling")
> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>   2 files changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c184..593c1ddf8819b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -415,19 +415,25 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	struct amdgpu_vcn_inst *vcn_inst =
>   		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
>   	struct amdgpu_device *adev = vcn_inst->adev;
> -	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
> -	unsigned int i = vcn_inst->inst, j;
> +	unsigned int total_fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
> +	unsigned int i, j;
>   	int r = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << i))
> +	if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>   		return;
>   
> -	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> -		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
> +
> +		for (j = 0; j < v->num_enc_rings; ++j)
> +			fence[i] += amdgpu_fence_count_emitted(&v->ring_enc[j]);
> +		fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
> +		total_fences += fence[i];
> +	}
>   
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> -	    !adev->vcn.inst[i].using_unified_queue) {
> +	    !vcn_inst->using_unified_queue) {
>   		struct dpg_pause_state new_state;
>   
>   		if (fence[i] ||
> @@ -436,18 +442,18 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   		else
>   			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   
> -		adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
> +		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>   	}
>   
> -	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> -	fences += fence[i];
> -
> -	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> +	if (!fence[vcn_inst->inst] && !atomic_read(&vcn_inst->total_submission_cnt)) {
> +		/* This is specific to this instance */
>   		mutex_lock(&vcn_inst->vcn_pg_lock);
>   		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>   		mutex_unlock(&vcn_inst->vcn_pg_lock);
>   		mutex_lock(&adev->vcn.workload_profile_mutex);
> -		if (adev->vcn.workload_profile_active) {
> +		/* This is global and depends on all VCN instances */
> +		if (adev->vcn.workload_profile_active && !total_fences &&
> +		    !atomic_read(&adev->vcn.total_submission_cnt)) {
>   			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   							    false);
>   			if (r)
> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   	int r = 0;
>   
>   	atomic_inc(&vcn_inst->total_submission_cnt);
> +	atomic_inc(&adev->vcn.total_submission_cnt);
move this addition down inside the mutex lock
>   	cancel_delayed_work_sync(&vcn_inst->idle_work);
>   
> -	/* We can safely return early here because we've cancelled the
> -	 * the delayed work so there is no one else to set it to false
> -	 * and we don't care if someone else sets it to true.
> -	 */
> -	if (adev->vcn.workload_profile_active)
> -		goto pg_lock;
> -
>   	mutex_lock(&adev->vcn.workload_profile_mutex);
move to here:
                atomic_inc(&adev->vcn.total_submission_cnt);
I think this should work for multiple instances.

David
>   	if (!adev->vcn.workload_profile_active) {
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   	}
>   	mutex_unlock(&adev->vcn.workload_profile_mutex);
>   
> -pg_lock:
>   	mutex_lock(&vcn_inst->vcn_pg_lock);
>   	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>   
> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>   		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>   
>   	atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
> +	atomic_dec(&ring->adev->vcn.total_submission_cnt);
>   
>   	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>   			      VCN_IDLE_TIMEOUT);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index b3fb1d0e43fc9..febc3ce8641ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>   
>   	uint16_t inst_mask;
>   	uint8_t	num_inst_per_aid;
> +	atomic_t		total_submission_cnt;
>   
>   	/* IP reg dump */
>   	uint32_t		*ip_dump;


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6BAC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 13:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBAFC10E0DE;
	Fri, 11 Apr 2025 13:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CsXDZm7Z";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ACA210E0DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 13:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gy8/AmBkaBhaNP1aEz//X49UkClJwtufqIVBdm7AT7cSI2oGJhvMWPL6wI5JoM8zwA2qsSv6gzVJwfJWsKOy27SdXQQeOnx57D2iOEsi47Wgm5egrLQErP5q3d5GB81wTrW9qrnieHHpshMEr8fxw+QwayaTQ0dDJzeX2gaC76Z0uRCpCDv3PIOOfaLRG6VM9vRpZKlicdDhH4FcsaoTGS1VMgJ0iPQz8fTTDdXklwkGsJ/0NJmMykWJIjrQRVRTY9PSAZyWqaYuiEG+NeEUrvwNwNlLlEojUWjzrWKDTLxUM9kdVI5Q9ynE2jz9oi5WSWFtEN8gb3spLLdWLE9qzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q6QIfpyMMTReMehHj//OkZ0Kmad5LVLc4oJtOcFCMc=;
 b=JQT0Wrhysi1YKavPCGhm75+OlPzF+q0LR1BbH58WZ2aqamODfRfv43EiWgr6DobMDT5bpcjuvwxVP1Zw4/JaiKFv8oPiPZ+2D5BZX4WpooRw8rqG0MMU0WTSC2mtNebAxuLnuroEfOUbI6hUpoQ4xzbl7fOMyI6IHgzXIqQdVZsLHhNEBjwCLL/osZc3OvEf+O80zEgW1PJ5+daFKC7JZuN58tt46QZxE2rMb34MBu8++I8ELLciSlEmVQ9WAlwuHxsw8ZslNB01JAEcrB+3N2p68KERh1HwaWfZ1SCHe++7wshITDoYl3F0H0dBVCS9dskjfGGsWH+Q8zU6qkbIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q6QIfpyMMTReMehHj//OkZ0Kmad5LVLc4oJtOcFCMc=;
 b=CsXDZm7ZLLYIGfZw1mFzR906kDZ4FsUSy4j+J1/r/R4u6V4G3TGNWkfBjvJwpTEPraa3o3RBAV2+IZcEDmVCVY1vUk8qefkJnE2IMkTUh/mbeHINxzQRZuHj/uCPCLMSk2Mv7fzozIPuwLsaZaM9pRFv8toRPvA6T7DwxwFfYJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 13:45:08 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%4]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 13:45:08 +0000
Message-ID: <8ef15e9a-44d7-4d24-9795-bd8d2e4f8c12@amd.com>
Date: Fri, 11 Apr 2025 09:45:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add smi events for process start and end
To: Eric Huang <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250407205237.217164-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20250407205237.217164-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::26) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e39f19-fa0d-4811-3aa2-08dd78ff1264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHhHOGVmZUp1KzZUMGhBck9Pd2tqWXdoanh0Ti9Scml3Tm1NY0dVYitDaGNj?=
 =?utf-8?B?TmZIZ2dJdUloWjdKdUhaUVNvVERNMGJINkQxNGdxRW5OZXFjSURjd3hYd284?=
 =?utf-8?B?dVJJeXRnWHJyc2JkTk53SFppNVMyUEdDRzU3aUxSY24rdWUzd0svWEJGUDJT?=
 =?utf-8?B?bmJJNUU1QVNIL2xmRnRVNEc3azJDMTYyN1gyUjY5UmZsM0tWaE9Nay9XYXhs?=
 =?utf-8?B?Y2hUaXpXSE1zZmhOeHdHS1MvbU5tVkYvaFdFdnZJc09xN0V5aC9VaVRXVjM4?=
 =?utf-8?B?YVUxWG9jaFBMUkUwV00rQmliU0puM1k5M3hOZy8zakpNY2hKWElvSlluNm82?=
 =?utf-8?B?cGZXdHphT3NyajQzc2s1Y2lEMyt3V2k5WTRoaG5nSGRGdUlCaW52UXJhZ0Fw?=
 =?utf-8?B?QzlPVWJoQVRXd0dsa2dYaXZQYkRkR2RFOWc4d3BOTXRuV1pSNU1IVmJvUUpN?=
 =?utf-8?B?ays3MitNdWEvRmdyaDVEc1lNdER1R2ZvZDZHRWVOek9GTmpSTXVaRnp6NDcy?=
 =?utf-8?B?aWN6RmE2WUU1RExKQ2UxbStWWXdvcDY4UmIxOWllQzNiOFNwQ3I2NnY4WnQx?=
 =?utf-8?B?M3VOR3I3bWxwWFdiK2pYZWpJRTZZRHp0eDBvYmt4eUZTZmt2NzlZOGVVVjl1?=
 =?utf-8?B?ZTRjSTFYcGxTMG5hOWJmZVprUmxmNmF4di93aUV6ei9rYUprTUx1NHRyLzVU?=
 =?utf-8?B?VjJGQ2dYbVFTa2hkKzdBZ0FnLzAvM3YyMFlqTEJaOHlIZ3FsNlQrRm5QZEU0?=
 =?utf-8?B?cDAwcE0zOTBYTXBMdkhYRFV1NTNkQTk3c1RLOURnY08rSEcrajhGLy9UbGtv?=
 =?utf-8?B?cG1vOHVxQnA3RWtLOFIrOHhkNzRHMnVLcGpwSG5NL3p2c01LRXJBTHNkUjgv?=
 =?utf-8?B?cHVkZkRQRDRaazAxQ0NDc0k5bENRdnY5NXlrU3pmYVhDU0RTZDNianZGdWxB?=
 =?utf-8?B?SU1CeWtJYTBpdnRjakxrRWk0ZG81ekV6YXpuMjQyWDZKMys1SHlRTFl6MWsz?=
 =?utf-8?B?L0hqU3k3amRtWHdzSm0wTnBZMk9WOFlwcngrTHRlQ01ycE5LazQ0dkh6T01v?=
 =?utf-8?B?aFJ1TEdsdFlRTlk2WURYOWpjMGtwU1cwSm90cHdlaEl1UklHYi9zcXJEYUJV?=
 =?utf-8?B?d0ZuNk1uWmNKY3BFM3VsZVc4c1hVd1VJVlJOVWFKdTYxQ3dwcGgvc3JlTEVX?=
 =?utf-8?B?UGZ6OUxPc3YwSTViakIwNFRIL2tabU5JQmplNU15TVp3d2grcmsxZ3VBWlZX?=
 =?utf-8?B?YUNYK3g1d0krZk93MHIxSGp6cGhCWUtIdktZUGEwVVpHVjhnaTRudzJKNktm?=
 =?utf-8?B?TTltcU56eVZja0tmMkZBVjFsL2VwSUJ5UnRUakwyNHU4Y2hIbC8vRWx3SmJa?=
 =?utf-8?B?Y2xDVG9zaEdtMnhYWHZWVkt6SlVia1p4eExwNENmUkdwVFQ1cGcyNnY4a29M?=
 =?utf-8?B?NU54K1VpZzJhVllhY3lYczlFWEJzQ1FVTXF3NDZRaW9ydW5LeENlNmJjWXZn?=
 =?utf-8?B?RTVMWFpiUHRQYmFjdXZnbUdubnNPaXFjUXJoZUlqNzR2bm9kLys1Wm9CZ0pD?=
 =?utf-8?B?alV6YjBHS1l3R2RiR2ZwKzZGeFVJdjVFMjVTVWg3eHZ2RmE5eE03UGpjVWNS?=
 =?utf-8?B?MlpFalVRR2x4L2czelpESHJMMDg5RXFoY21jRzBQdExCZWJtZmt4OFcyNWUx?=
 =?utf-8?B?ZWVkY2dEV29vdTRBVjFGSkJOakhJVmdWN2hnWlNJdW1BaHdzdFBpN1JoOU51?=
 =?utf-8?B?Y2FvK0Z2TUZPZ0NlMVFNVUJVRGlOU05UZkRDQ2J6TlBNcFRudW0wOTVtQVNZ?=
 =?utf-8?B?RTRDVFNscEs0Sm8wSGNoS0JWN0ozYUY5R1Vlc01OR3cxdis2LzJOQW9NS3lN?=
 =?utf-8?B?bXQ1NmdhOGVmV05BSzRzZlhtTHBoME1Nakk3OEpTaTFXMVBucXpQbFYrYmkw?=
 =?utf-8?Q?2SEKeESkT7Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm92c0tUUVhZaWZnYzlCaXpiWG9uOTM2VGNxaWlrR0RVY0VDU2xaNzNsTWRi?=
 =?utf-8?B?TUFLVUlYYkMrdWZ4cjdCNEN2dy9vWk9JVHQzOEtTdGh2TTlwUVMvRXlmcmRj?=
 =?utf-8?B?UzR6NmdhK01ZeWpRci9CT1ZGbXlad2FoQ2pvVXhQS05QL2JHNkNtSnJ1b1gy?=
 =?utf-8?B?SEcyaFZ3dmh6R2pjOGRjWjdkMVZtV0hseVhWR2JRd3lGWXlUTVgrUWxqMDI2?=
 =?utf-8?B?NTVaaEEyMDNBbUNFZzArdERJSjI4bGRMb1BJTGVYaDlGcWFlWXArQ1R3V1Vl?=
 =?utf-8?B?R0h1ZFpib3ZPbXBGQ1l6eWdmYThrdThWYS9Ld3dkSXRMemJmQS9tN1dMdTZu?=
 =?utf-8?B?NG4rbDMwQXlGUGowVGlVbFRQMjNuMlpBeG1xbjdtcVkzbDBxMmJHblB0N1Jr?=
 =?utf-8?B?LzlQTVY5cGRNQkdBMnk4MW0rYTRhb2JKaG42STFKTHp5YXl3RDNGbmI5dXdZ?=
 =?utf-8?B?MU9OUDkxNlNyL1BpQjVJV2U5Rm9INHU4VTJUSTR4N3k2QVNUT05yaFZUTG5G?=
 =?utf-8?B?M0NNN1RXUkxqSzZqcGwwWHN1QnFkOEhsQjhCV0VQSTgrN1FETWRGdWVuK1ND?=
 =?utf-8?B?clFwaWpJYmdUblNIL1VzeUtEVGxZNTgyRDB2b0EwdVMyN3QxZmR4MURvWEpx?=
 =?utf-8?B?MEh0Lys4YXB4aE5VNGlPQW9Qc1JEU25za1FRR3BidWIwajUxdzFUN2FXeXkz?=
 =?utf-8?B?NnVoeW1qSU5SRlNKaUNYVkRRNGtMeFU1dlFWY3JMTFZPSHNzbWdRUWNpZ3c5?=
 =?utf-8?B?YlZHSHZtN3NLbkZVWHcxWWtsV3NKUWJDWkdKWlFUdVlGWk1jOHZNUDlhdkpi?=
 =?utf-8?B?bFQrcFRPditzL2czdGFhcHBaZFZUeGVrWks2eE1Jam1tT2NpbUh2d01MU1k3?=
 =?utf-8?B?NUxCS2I2QTZQMEhjYXBTZGpIbzhjaXdiWXZrRUNBU0tza1NYUSt1Ujk4ZSs1?=
 =?utf-8?B?cUdabWwxRFBVT0lLQ0RocmNvaDllL285WGF3NFg0SndCUmxieFBNR3EwbS9W?=
 =?utf-8?B?bmFTdWVoVE9PLzJYZ1B4dHg1SUQ1ZmJOaFhrMStOc2tCV2dmSG84VUIxRm9s?=
 =?utf-8?B?OEhtcXZNTmowR0ViT08yNC9PdWFFR041S0pmL0FjcG02ZWVheDZpYnBEQmNB?=
 =?utf-8?B?QU91RzdtWHEvR3JqUnhEVXNud2YrK2lhaFRBUy84RWpGV2NxUy9Ick9rdGs3?=
 =?utf-8?B?ZUxla0JJYkRsZXhEN0paYUFwUlFQM0pXdUk4Y1pLaTMyeW03a1k2VnNaY2pH?=
 =?utf-8?B?TC9HRExMK2NDdnU2R2tIZy9MZTZ0MnN1eE5BVXB5S1ZCZ1FRMlJyWFN0ak4z?=
 =?utf-8?B?cVkzbVBzcEZWcUJnakNrblF0eWZaaEVEN1RJdE5rRFJDNzhmZURrdXNEQUVZ?=
 =?utf-8?B?eWFrbXJad3hXTCs3USt0a1FXVXBqdkFjSjFiY1ZialFka3ZlWkl5L3dsZk91?=
 =?utf-8?B?N0ZvREpTWWpYWjM4WHJOcndwWGEvTVVucUYzNDZWTFQyWDZHYVhYYW9vOXF0?=
 =?utf-8?B?OCtWaklxSUhkYmRMY0k4RkFaMEh4Wk1YQThzK1NnVXNmM2M4VUFpUmp4U25t?=
 =?utf-8?B?MXhwWWdydURrVmVoNi96YTErUjZGU1ZpWjliQ3dtd0FzSFJYcDZWWGlKU25a?=
 =?utf-8?B?N3hRdnI5NWwvaEZpRzBaN1lOTFRGNmVWalljQjFJNkk0dFBDV0p2UUZKZGpD?=
 =?utf-8?B?VkFjRHVYbE54YTJnZC9Pa3IxMXBkQ2piS3VtQmlMZmUvZ0xHL1lnMmhoM25T?=
 =?utf-8?B?STMyQmdaWnIyVW50TlhocUlWM0F4OE1TRGpqYzdkRiszaFc2MW43TlM0QzVG?=
 =?utf-8?B?QTRqNmd5U3dGYytaaSs0UU5QR0FKU2pEaFZHc1hZOWZCN2s5MmgrUG1LQzBO?=
 =?utf-8?B?OEorRVJoUXNRVVZGVFBuQlZJOWpwTFVNMXVOcHQvN3R1ZVRnMzZkamhpalNy?=
 =?utf-8?B?aTBhRHRVSmpOZ21LVzVnUW1VcU16QW5tOVdJUzdsU3RSQUc3bG5ldjV4RU5W?=
 =?utf-8?B?NWpadEdCS0dTbzRPbkxyZnhHYUtSYzJvNGJaWGxFWWJxNmZ1R2NsMTlIQlhP?=
 =?utf-8?B?dldiM3FRN05VcTJVdG9vSkV0bWNuWmJIZm9FL2dpQWRTT0xQcHd3ZU5EZnYw?=
 =?utf-8?Q?Ne2HyUnMixE4c2D0fWHt8PT5f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e39f19-fa0d-4811-3aa2-08dd78ff1264
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:45:08.0408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gE1bvaE7Xs2QpnnlsF9Pn/aYKbH6bnnpbA9f9Q5Ww5coSh4+lUbsy52AHGn3bFliwNxJJmqrMcs/0LXySqnjRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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

Ping ...

On 2025-04-07 16:52, Eric Huang wrote:
> rocm-smi will be able to show the events for KFD process
> start/end, it is the implementation of this feature.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c    |  4 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 21 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  1 +
>   include/uapi/linux/kfd_ioctl.h              |  5 +++++
>   4 files changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 7c0c24732481..41d7dc8c2850 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1054,6 +1054,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> +		kfd_smi_event_process(pdd, false);
> +
>   		pr_debug("Releasing pdd (topology id %d, for pid %d)\n",
>   			pdd->dev->id, p->lead_thread->pid);
>   		kfd_process_device_destroy_cwsr_dgpu(pdd);
> @@ -1715,6 +1717,8 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	pdd->pasid = avm->pasid;
>   	pdd->drm_file = drm_file;
>   
> +	kfd_smi_event_process(pdd, true);
> +
>   	return 0;
>   
>   err_get_pasid:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 9b8169761ec5..727a4ce29fe6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -345,6 +345,27 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
>   			  pid, address, last - address + 1, node->id, trigger));
>   }
>   
> +void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
> +{
> +	struct amdgpu_task_info *task_info;
> +	struct amdgpu_vm *avm;
> +
> +	if (pdd->drm_priv)
> +		return;
> +
> +	avm = drm_priv_to_vm(pdd->drm_priv);
> +	task_info = amdgpu_vm_get_task_info_vm(avm);
> +
> +	if (task_info) {
> +		kfd_smi_event_add(0, pdd->dev,
> +				  start ? KFD_SMI_EVENT_PROCESS_START :
> +				  KFD_SMI_EVENT_PROCESS_END,
> +				  KFD_EVENT_FMT_PROCESS(task_info->pid,
> +				  task_info->task_name));
> +		amdgpu_vm_put_task_info(task_info);
> +	}
> +}
> +
>   int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
>   {
>   	struct kfd_smi_client *client;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index 503bff13d815..bb4d72b57387 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -53,4 +53,5 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm);
>   void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
>   				  unsigned long address, unsigned long last,
>   				  uint32_t trigger);
> +void kfd_smi_event_process(struct kfd_process_device *pdd, bool start);
>   #endif
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 1e59344c5673..04c7d283dc7d 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -536,6 +536,8 @@ enum kfd_smi_event {
>   	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
>   	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
>   	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
> +	KFD_SMI_EVENT_PROCESS_START = 12,
> +	KFD_SMI_EVENT_PROCESS_END = 13,
>   
>   	/*
>   	 * max event number, as a flag bit to get events from all processes,
> @@ -651,6 +653,9 @@ struct kfd_ioctl_smi_events_args {
>   		"%lld -%d @%lx(%lx) %x %d\n", (ns), (pid), (addr), (size),\
>   		(node), (unmap_trigger)
>   
> +#define KFD_EVENT_FMT_PROCESS(pid, task_name)\
> +		"%x %s\n", (pid), (task_name)
> +
>   /**************************************************************************************************
>    * CRIU IOCTLs (Checkpoint Restore In Userspace)
>    *


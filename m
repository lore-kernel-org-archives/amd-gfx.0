Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665EBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 20:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67686E896;
	Wed,  8 Dec 2021 20:21:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689796E896
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 20:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiwzjCwnUN0H2el/TLykatWj0u/bRL45J1y8sMwbi5Rc2p8zJ9/dA1/vDZJDClrelHeWbMRS9WOVtzUfrWL8FI2S4TaUmOzKCd+BoVf8l5Q427QnKDyzioheQICAfiKUdPVeCgcdBiE1yqqwm+8LY85AyZiZDUHScf2Dsn4a05rSvSqoXcqh9rAD8OqbL0NhiPol8rgzn5TOz4+pTroysJ9Jni5+r8RmJartEtgOjBrFndgkj8DAyFDYA7rmZBlcjT/JRVNEqJlEsDDiN2RsA6bRTId7D0lhHiGbP9r1WMlTGiUfiko5D4Vcgre55yvQK0o1VaxA1hIwMy6u/yZThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYuBYv54xd06AbQWKVOaScNxcPCWOvaGPCIn6rkPhN8=;
 b=WZ7uVH5FGKnp4yAaJiJB/no+mEHo2o2tUjmVNkxkHnEFIueJstMyuzTIgS0+NIICRr20yO/dvMSC+LDU8WXJ8e5YsDIkJ1b4D+L81VqUlCw47pSU06Wiwx94/Nt1w8E6wB/ABV9hQ92WZCInN/TlUr90xwh9IR0oYUoJ5eB5ZaEUV3OcuApipYgMoZLEYu7IZSC2pZ/2j0yJiLFtFzUIjJfkixeeaMWXJBz3TzYJcn8b4B1Bb9fcmjKB6ifJvD2XA0A8tUsHE44OcojXUO9go6+cFyl7u3YUltibAJhRUcfxS8ICaH3n0q3RuBfjrNNrRcIpHLgfNkwETkgIWF5mNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYuBYv54xd06AbQWKVOaScNxcPCWOvaGPCIn6rkPhN8=;
 b=XVQB9CrLWvX8nt+qctNFyW/jGjISd3cYHcq/dnK2Y7xjB+gfYu3+UdZMNpGbWvt5ZRju+7okSzUfwzAAHvQAybuks4DTUKXCUByAD4XaH0KbuXHAVDot2icNPKp+vd7H7KV+3Z00TcVi912ZPyZdwac/Km6ElevsDVuJD03z3as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 20:21:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 20:21:11 +0000
Subject: Re: [PATCH] drm/amdgpu: Handle fault with same timestamp
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211208201618.10551-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <fe1c0de4-4e6a-4852-b243-411e122a2c5a@amd.com>
Date: Wed, 8 Dec 2021 15:21:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211208201618.10551-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Wed, 8 Dec 2021 20:21:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08b84078-96f1-4230-d5ba-08d9ba8846ae
X-MS-TrafficTypeDiagnostic: BN9PR12MB5083:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB50839BBD147AE40E79B254B8926F9@BN9PR12MB5083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/RZWUlOXMeh9KWn9wMbJeWFYFG3H+7URqhFKDLN6JontWao5gOl4tSE6GybcTYBDyM5tOO8VYUF8jMy3g6zd2J4UqApLTEYCphLPb0SQKdFIOFNHkeohvdHZ+bgWeGLSZ6aNn/svoea76ngitBFvCqvpd5JMmHKipRYrzJXvJSKnHpFOSIINTHLEYTimhBAIHwZgPcET11620GOhQ3ps3jWhXUw+MIx0iGwTRvX9+DQD4UreWl0hdresc6MzrzXrTzNDPRsZQ850KeBgLql29+Fd/UxY2zdwy5z/rJOaff3Qv2wnAQXIwSVXMfmdO80MbVcM814fWGK7e4EGrgBDwX2DQ2v3BWuMuRpYS1jew5b1ZMmtY6o9dp0qUJGnmrEZmZQXg6m7msZxWkLz0MuJi+IDt0C39MfYprCheUNsRRxLM6q/XQL4GLAypbQa8LGU/oTsCiCFnrz9zvWkMKubU3atu3EesC4e8dg9z4iED0U7cwZIgYgG4+rIxrsV1/Z/AOvh1kvg1p/dJHE67rf7f7QMVmLfY+wYIeFu/EIx5YAwUcqtTlRyi4n4/+69k4eri8mSPS4sAkoFV2gLse5ulkJKg0jByu4aqECElgFQg5g3/HgqFqXqDtDCH3KlVmrpYVs85JuGl7ED3Pg0LUzv6fDhZomtMwNJQhpHb1Ba5jx9YJd2mlkYFKfWGOyP2dSeZTOlCrMETwqF+PEfXBlEKNkWvjplRHuXlj2LsfJd75PuOsWV6D5hBNV3yj+rpcn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(2906002)(186003)(36756003)(66946007)(8936002)(86362001)(8676002)(26005)(66556008)(66476007)(31686004)(38100700002)(956004)(44832011)(6486002)(16576012)(5660300002)(31696002)(316002)(83380400001)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3VRdVYydnBiUlVVdy9hb2hMUnBSVG1VRnVBRGlqOXZVNHBLTnQyZ1kvbU9Q?=
 =?utf-8?B?SG9oZEpRcjRZeFpuVitjck9lTENpMTFIOFRvRENxWTd2bDU1dktWcnlhdDVN?=
 =?utf-8?B?bWhVUlRVcmUvQjRKVE1EWmRZUk9nN2syc21EcWVGVngzOWcrZ2RaNEJJRmlK?=
 =?utf-8?B?ejFUall3NUt6RmZwczZUck40MWRUaEwydDVRSWkvTnhvZ0xrRG04SlkxTXFy?=
 =?utf-8?B?eVZXMmVLcVZpYXJBdnlrUjlPb1p6RzNIQzU2UmF2dkZ2VU1DOWQxZ2NySGRH?=
 =?utf-8?B?bVNpYnFJUlRlTFVxVGR5VzhwODduMVo5YXBHUG04MmFGVlBpb2ZySTlUN200?=
 =?utf-8?B?cVFwMGJQMkdtUVg4VTU2alJtdGtEenRPc3lqeFpvVHBmdi8xMUlmSnNtL2l3?=
 =?utf-8?B?SjBqWm1rMlVHc2tJQWhpZGtaaGhCSDZtUmN5Y2dUS2NqVkRjV2tiSStEbzNy?=
 =?utf-8?B?bmM1MzJXVkduNTU1YVhPNHhqVVlzNW1pNDZSbjB2cmVYOHpBSGZBS05LMTZt?=
 =?utf-8?B?UitrZk9sQjlISGZJYjZ5TE15Y2pwS29tTm9lL2FPNHJmbVVFQThWZCtRa2Zy?=
 =?utf-8?B?dnlIY1FmbTU0a1NacU9BeWhWUlBPUGIzRHpWcmdGSk5LWVRURDBlb3F1NFZP?=
 =?utf-8?B?bktiWDh5OGZnbVE3OGhuYlpCclJkOXp6NzdvdmhiMVF0MUYwSHNGUXhWd1k2?=
 =?utf-8?B?Q2lUMkZFUkFGRkovaWlZRTRKb2ZXek9Wb05HTGxBeDNhM2hOVFRLYW1aR3ZO?=
 =?utf-8?B?dVk1UU92VkhJVVZTWVBod0tibWd1R1FPK0M5dGpZZlFXN2kxa05HeUt2b3B0?=
 =?utf-8?B?Q0tBTHBCcXpadkNhSUY3N3RkWFIyYXcxaHIzd1pValM3cjcwMzVNcEkwTHd3?=
 =?utf-8?B?T1FLMjdoS3Ivc0VpeTBjQW5zMHF1MHVhTkZHMFpiUjhYTU5GbSt6bVluRCto?=
 =?utf-8?B?Vys4eC96KzRQM0ZXTEZWMmtQZjBvNGdCQnUwUy9kL0JYMWRkcHBZdC83NUZz?=
 =?utf-8?B?ZlN0ZEMrUXF0MmJTcElSeTZCc1ZhM3JHZ2dRSTc0Rml3QkV0akp4aWNuNlJX?=
 =?utf-8?B?bkViK1RRM2dOZ0ZDNUg4ZDFZWHlaOVp5V3JkazAwNE93S2ZvMk1ZUzI1bXg1?=
 =?utf-8?B?QU1tbjMrWDVRM2pSY1cxb2lURHRnVkRsQ0RIUjNhVDdMQmNuUlJrTmxvWUI0?=
 =?utf-8?B?eGNiVWZVRkQ5N3dBdzlJN2l4UXdXU0RjMWNpemQ4S01meVdRVGJubHFxczBC?=
 =?utf-8?B?L0UrVzNNODAyVDJYVVoxMWxKaTM3VUh2U2lJTjVlb1gzV091R3V5S0RkUWtW?=
 =?utf-8?B?WSt0VE5tQlRnVVNZMEtmd0JGNEVMeG1YT1FqTUh6WWU2d1pUdU55aFpJRzFu?=
 =?utf-8?B?MDJtVTY4N2ZCeDVpVmxaVVZQT1RlMlR4U0JIbjhEQlZYRytIa0g5RDU1S1Uv?=
 =?utf-8?B?V2prQzloRldULzlWQ2FqZG9TZ1o3NWN1cU1KNDFOK0xkanBMWFdndVY2dHdL?=
 =?utf-8?B?MUlmVDJIcUNOTGpVaXBZcENaL01GNVBwelY5alI2Tk1Bb0RpbFhaODcvaDQ1?=
 =?utf-8?B?NUU2YW90dGpGdlIrOGtqb0cxc2U0WW15SW12MnkvZkZiVlhWTENzN1VZSzFT?=
 =?utf-8?B?ekMzL2pmTEx0am5WWDQxQkFZdlNjQ01iZ0tYYzNqamU4aVM4RHArUjZpRmw2?=
 =?utf-8?B?NnBwU043UWcyaWgwRVRSdXdiVjRKTUxTeVBrcXpxUzRteXFyOERUS05lb2xs?=
 =?utf-8?B?ZDZaZ0N3SlN1eVZjcXBDMzV4T1o0NU14M0thTE1WdlRvbk5xbjJrZVZpaXdH?=
 =?utf-8?B?cll1cE93MFhlSWlidUtwQzRmQVdFVWlJdzNYQXRWUDY3RTRndVMrKzlUazBp?=
 =?utf-8?B?dk5rT1lTdEN1M2pnZS85ME4yNHRwQkw0RVlvMlEyQXNTZkFlbTBxYzRsTW1Z?=
 =?utf-8?B?QkR3VEFEcFpHb2owZkZiZzMwaFR2VW5GNnFuNlNPazZKWkpadkQ3QllaMTRS?=
 =?utf-8?B?YktSc2tlMDhXVjFHVFpDVlJvUy9NUXVVSUhZenpMT25KVnpPdWxKNm1PSXlj?=
 =?utf-8?B?d0xEeHlwUmx4MTRlNnZjV3BwNVI2ZFYxWld3YWFZYVVvbmd6U2FGL1pEMXNN?=
 =?utf-8?B?TWRKR1BtVno1VUFFUGRaUzhDNHRlZkJJZTE3YWRTamZOekJRSExhNEkycHpJ?=
 =?utf-8?Q?Y4OzBZUnbudx1ZMBoAsExLQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b84078-96f1-4230-d5ba-08d9ba8846ae
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 20:21:11.6764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfW2JZCWha7krbSOp8Sg/XaaeS3m8Q9QO2dG7bvqwvCFLB/Q8uVQCxvVgRmKGRLOkCslZg0qdSoLZij4ITFNdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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


Am 2021-12-08 um 3:16 p.m. schrieb Philip Yang:
> Remove not unique timestamp WARNING as same timestamp interrupt happens
> on some chips,
>
> Drain fault need to wait for the processed_timestamp to be truly greater
> than the checkpoint or the ring to be empty to be sure no stale faults
> are handled.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 ---
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index 8050f7ba93ad..3df146579ad9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -188,8 +188,8 @@ int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>  	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
>  
>  	return wait_event_interruptible_timeout(ih->wait_process,
> -		    !amdgpu_ih_ts_after(ih->processed_timestamp, checkpoint_ts),
> -		    timeout);
> +		    amdgpu_ih_ts_after(checkpoint_ts, ih->processed_timestamp) ||
> +		    ih->rptr == amdgpu_ih_get_wptr(adev, ih), timeout);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index e031f0cf93a2..571b11117992 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -522,9 +522,6 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>  	if (!handled)
>  		amdgpu_amdkfd_interrupt(adev, entry.iv_entry);
>  
> -	dev_WARN_ONCE(adev->dev, ih->processed_timestamp == entry.timestamp,
> -		      "IH timestamps are not unique");
> -
>  	if (amdgpu_ih_ts_after(ih->processed_timestamp, entry.timestamp))
>  		ih->processed_timestamp = entry.timestamp;
>  }

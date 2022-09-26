Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7D6C07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 06:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8616010E542;
	Mon, 26 Sep 2022 06:43:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C7510E542
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 06:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRLyDhzlj73jm7Sj8ttpx/NjlvFNv5eES2QDAC7dWf+az1w0pjKhhrHR6zWt/QVbFkMjc4rmHhzozC0Fka2Y1i6gVAUD38fGfdnjpYE4Wl3ZzNszuBsj2OQIj5/nqteYMPLXeHFpRZ9uPbDQQi6sceKofDVsqjM2L6LssrH/tX6HImFqID7S0rXZIqgtpCMT8BdvxQDYvKJj+l7zQQfBheXDDnRrUE+KJ1tOgGdgRcdVtXSN45M8czooqXbUVZERFwtxAZW2rprIJRxkY6NeFmjZkXIaKWyvAOWCEF3IvhdPJxQgfwmdwn1aRh9xZZNwc6yZYC3MV66dfpCHGK/8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7e1Uokvag3Wfj1yy3Xl7EOBsh6N2H2wdB2TgJqnfe8=;
 b=LBKEfz/kj3UECn7tJUKaJxZY3zJH4GbvecSUIH7mt5hmU+HTYo8EkXQmFfbFCyqla2xWRgZHo4YDdXJl0ROOTqUH5sjJMI4kpiMAiqJSF10uWsm2Fen8dU0RClSCM59lEH19tzZxqUBrnQWl/hFheZZHveod11K+HOadXdSQh1mBrUyLwV9H3FObt4FXAQne8kLlthV6Ilir+0/f0VfSVMk6DNDJ93ey2ATO5rAxcVLuIv3deQVWYtgdE1Wrq1vj5ZgZ2iWtZAVvSYA/ey2JZDRMutjegkTOHr15eR4enWIBvqtqlIdHqDg0ZtkE6Ycwl0I+u7oJTUy2SAg/ehKIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7e1Uokvag3Wfj1yy3Xl7EOBsh6N2H2wdB2TgJqnfe8=;
 b=LpgvUJ538rTti9fhwDy7ucRPspID8S5bo+Hsf0JK87njvHkblYKihOV0s4KMaaqUZIaQkVeGZRf+DHJmwFt/wP8c7pVqaMYrhH2qDVYOzVDO0SFAR+XcXF65Ir1vQ65bTGIrwBH+fEIU0wEMGdYL880pcntTPE7QYHCPKWDf/Is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 06:43:11 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 06:43:11 +0000
Message-ID: <d5f1a2eb-c117-b7d9-ca37-73edffe7450a@amd.com>
Date: Mon, 26 Sep 2022 08:43:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] drm/amdgpu: Add software ring callbacks for gfx9 (v6)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220923131630.1260501-1-jiadong.zhu@amd.com>
 <20220923131630.1260501-2-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220923131630.1260501-2-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: d85bd78f-f8bc-4d20-ebce-08da9f8a614c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pX4KRQ+RNG+UcvNkEYpesR7armQD6dk1XA6pdtPq4EHSJMMMVHVvX447io/weWFOYxQrhC4FsNVAuyx/rmkup6nhBj+h6XzMV4TTbhljuoncR5RXx11ZijDtHfY2iUdSpkrap/xHNmJv5A6lnx+lJO8Y+YbWV3IOYuSB4XTy/s+lkRx2lB98f2wdShqaSEr1Gwe2ZT9C5YahzGbWgQQ6SnRoaInCZxRmUDkREGqRkBhDHQ23Qg0E0H2myn4TAT4Wa++x8en4eUIRQcEdlqKI2PufykamzLb/EUMeF7+3xjKVKGZq/Ptpl7MWaKhN87HIaKIxTZmzIqDoERW6EYIlYe5OQ9NNK3/hEUjZMPnD9/MhoSleRlj3sqFZxVKaYz68lPamDZvTojRosUo1glCe0V1+5XPU/dRo9D60gYLzHqGQH3ajTa7Ti/cUQV+2+txWeeGKdmSgTyj4Kxjm6ug86ZH6eNjPd9lAtxizUQaEBZ03n4Eor5xkEZytVD00aY8Kf01BoN6QrzsezfFSwOrlp2PV+lM4I0DgllKA/k7kGiBDnK1hEDQjF3jehOniDsPsybjrH/35gHHirOW4RUwpGNr1OKkVg/28q6APBoX3UGVNmDuTn7DsW/9pYZ9bUMe+cHRYiZdo5woDIsNIsajoRDfmAciJeHlJhAkpjeAhV07Ak98dvGMvtUb3ywJ1kl9nmEc4Kd8CkUfWfzpK8niMInusfRtQ/H9sqeiA3rymjjtvFWagp16Ap3Ilz22SMk2wP3JPVIIKFAUCmNZURWnXbLdSNK5KF7xvAWoEWgN4ayA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(31686004)(54906003)(4326008)(66946007)(8676002)(66556008)(478600001)(66476007)(6486002)(316002)(31696002)(86362001)(41300700001)(83380400001)(5660300002)(6512007)(6506007)(8936002)(2906002)(38100700002)(2616005)(36756003)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmVlK25YRkkxSTc0NVpQdm53TEFVa2w5UnZRRGtWODZkM3ZZcHAzQjZKRzdD?=
 =?utf-8?B?S2FlYmN0SW9SQ3YxZk1tZ3ZETzV5c2VodHJ6cmVqLzlHKzNFaHJxYjN0RVhm?=
 =?utf-8?B?OVdpUm1SbC8wZ1N6eDU1T2RaS3NabUZHdGlvcW94a3dYcnA0M1NpczlySjV6?=
 =?utf-8?B?ZUpMOG00K1RsTXlZMDlacUVKUHpLTzdOb1VkT1c5ZW1qK0ZDMDRMSHl6a3Ez?=
 =?utf-8?B?UlUvcStKQkdKYjB6eFBFTnlPYk9QdEFWc2VGOHQ3Sm1tSDZ2UlZYSGJ1ZEpL?=
 =?utf-8?B?WUpVVnBiOXFLNFpLQ0VJRWhUSC9oQzVuc0ZicDNMaFlaRFJVQmFaa1hzY004?=
 =?utf-8?B?RTRXMzUwRlZFSmQzcGNTZEN6ekc3d2VmUlo4RHQreGRtbVdic0IwSFhrcGdU?=
 =?utf-8?B?RHdrRWJHNTRQdUdRMnYwZVdZYkxoZUpjaVpmK0hOL2h2TFA3UjdMQit5Uloy?=
 =?utf-8?B?cERLcmllMWdPZ3VjTkZITkF1QlZZdWhaQWlWN0tVWGVodkdSNTJBV24vRWxh?=
 =?utf-8?B?RzB5cURMNzQ0VmxLRXBsODliZ3YxQ25KZjkrVzlMcHU3L3k4blNyc0JHbS8r?=
 =?utf-8?B?N0xPVjZlZktEUkhwQjQrWGM1MGo5UDhvbERlbTd5ZjVkaXFsN0J0eDFjb3Yy?=
 =?utf-8?B?dnh3aSthUXh2eFdKN0hITnpoNGZ4SThmekFBR2k5NjZQZS8yZFRQa0Vha3Nh?=
 =?utf-8?B?MTgxK2hSUDQ5bFdYY0tWQTRnOVpqdGUyRFNJN3pWYVFqM0s0VmZycDBjei91?=
 =?utf-8?B?aDdwVnpTQm1ib2pva0dJRDd3RmpOeWtHMTAraXN6Q1ZpcU1ESWJoZGs3cXJt?=
 =?utf-8?B?dGVJYnNnclJmL1Jzb1ZaRE1PakNlcWszMEl5aGJaK3VoQ3l2dFYvaE9YNm5N?=
 =?utf-8?B?NW91ZnJqQ092QVc0OHcraDAvTjgrMHdReUlGazI2WGpwb2R4cFRuODJaRVdO?=
 =?utf-8?B?ZEw4bU1sYmpGSmhFTFFwaU5ram9aUExHcjFTR0lhUEF3WEoxeGtqT2k2SmtO?=
 =?utf-8?B?QldKS0JMYzQyTDhuMjIxY215Q0VZNkNOZ3lwOUI5M0I1N2V2WmNIL1UrMFZN?=
 =?utf-8?B?NUhDcUwvZTlWMm9CSkRxaVIvRURRSXR4elN6alMyYlBNS3NYUkRGUGtjOU11?=
 =?utf-8?B?UmlrZExoUmpTdzNmVmg2ckJMMnJzallEK3ZuSWRTaWduQ0p5bW9wb2lDTXBx?=
 =?utf-8?B?TkpNZEdKcThHMk9CRDd2ODh2dmMzenZySndScXo0MXJvbjVaZEtSUDhYMTRS?=
 =?utf-8?B?QURoRUFvRmdsMHVVbENVSHN0S3ZnblBaTHYzR2NhZzJpU2F5V2N3Y2VhQ0lF?=
 =?utf-8?B?S1hzazA4V1I1dWwzcS9lKzdLdUJmcFhXYjlSdGxlQSt2U2hMZGFlbkZsTmFF?=
 =?utf-8?B?NXowT0JscUhMRi8rcFI3cXBhdDRib2t3aFlVYVF3NU93ZlZRRmZFZzNXNFhT?=
 =?utf-8?B?OTlQb3B5VHU5dHYxc1RPejlOdEVCZlJSRHNZeS9kc251NmtmSWVCMUgwYTAv?=
 =?utf-8?B?VUJIcXVqZzA2d3g4NWt4SHdIVm9oUGZhRXRFN1R3a25LS0hud3ZkakNMRCt0?=
 =?utf-8?B?a3UvOGlSMU5UUHVNKy9NbXk5WE5QbXpNUy9DY0lRZnpSZTlHRHcxSHBCNkEz?=
 =?utf-8?B?WGZHTEF5UkJDbUk4aC9aNCsrbDNJem9XSThYUXFEQm0vMjJxTlFXTmRYWVFo?=
 =?utf-8?B?RGlVRHZDUENGMW9RUURRWkNobmNMRzREMytiV1Y2aGMrUVJGL2tIZEdvNEtT?=
 =?utf-8?B?S05zL1FuUGdwblQ3NDg2TmxRMWJWcFJZNGFEQTFDNEVDcjZRdFB3MnNvdllZ?=
 =?utf-8?B?YktGa2RZellHQ3ZUcm5aTlFTQXNZeEhFZ2txdTdqQ1U2K1ZiOGRwbzhTT3BY?=
 =?utf-8?B?eFUvT3FHUWdkL0JOb0RoRy9WdEVScllpK2xGLzh2ZzVwU0dPL3FpTkxpRGxr?=
 =?utf-8?B?U1EyWTRKTjZxSUE4WEZlbm81OGJ0U3VHT05mSW9BWFZCYS9VQWtvT3R5OG50?=
 =?utf-8?B?RGUxNUdYSksyWUlMN3VSZTRVQWtkWWdqNUNqVTF5ci8yWDRjVmlFT1IzQkFy?=
 =?utf-8?B?d3BIS1lIWituM0Rpd1BpMHZ6TlExK0twdm50UENNNjBiOE1OVzZWRUpiR2pI?=
 =?utf-8?B?ZXJ2MEZiWTVoc0FlKzdUb015UFRzMFp0MmpBR2RJa1BxNDNuaUt5a0FSRTd3?=
 =?utf-8?Q?wmP2IiaC+Lv87Znn096AaJdnDWPlzWjI2YYcFU7xb2rL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85bd78f-f8bc-4d20-ebce-08da9f8a614c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:43:11.4486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Tbzixfn37zwDsjrcrx7O01c7I1s6RNCiD/PbubL67UEnNx09nQABF4Rc9zKkaH2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4572
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.09.22 um 15:16 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> Set ring functions with software ring callbacks on gfx9.
>
> The software ring could be tested by debugfs_test_ib case.
>
> v2: Set sw_ring 2 to enable software ring by default.
> v3: Remove the parameter for software ring enablement.
> v4: Use amdgpu_ring_init/fini for software rings.
> v5: Update for code format. Fix conflict.
> v6: Remove unnecessary checks and enable software ring on gfx9 by default.
>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 108 ++++++++++++++++++++++-
>   3 files changed, 109 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 9996dadb39f7..4fdfc3ec134a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -348,6 +348,7 @@ struct amdgpu_gfx {
>   
>   	bool				is_poweron;
>   
> +	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
>   	struct amdgpu_ring_mux          muxer;
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 40b1277b4f0c..f08ee1ac281c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -39,6 +39,7 @@ struct amdgpu_vm;
>   #define AMDGPU_MAX_RINGS		28
>   #define AMDGPU_MAX_HWIP_RINGS		8
>   #define AMDGPU_MAX_GFX_RINGS		2
> +#define AMDGPU_MAX_SW_GFX_RINGS         2
>   #define AMDGPU_MAX_COMPUTE_RINGS	8
>   #define AMDGPU_MAX_VCE_RINGS		3
>   #define AMDGPU_MAX_UVD_ENC_RINGS	2
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5349ca4d19e3..e688665cd1e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -47,6 +47,7 @@
>   
>   #include "amdgpu_ras.h"
>   
> +#include "amdgpu_sw_ring.h"
>   #include "gfx_v9_4.h"
>   #include "gfx_v9_0.h"
>   #include "gfx_v9_4_2.h"
> @@ -56,6 +57,7 @@
>   #include "asic_reg/gc/gc_9_0_default.h"
>   
>   #define GFX9_NUM_GFX_RINGS     1
> +#define GFX9_NUM_SW_GFX_RINGS  2
>   #define GFX9_MEC_HPD_SIZE 4096
>   #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
>   #define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L
> @@ -2273,6 +2275,7 @@ static int gfx_v9_0_sw_init(void *handle)
>   	struct amdgpu_ring *ring;
>   	struct amdgpu_kiq *kiq;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	unsigned int hw_prio;
>   
>   	switch (adev->ip_versions[GC_HWIP][0]) {
>   	case IP_VERSION(9, 0, 1):
> @@ -2356,6 +2359,9 @@ static int gfx_v9_0_sw_init(void *handle)
>   			sprintf(ring->name, "gfx_%d", i);
>   		ring->use_doorbell = true;
>   		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> +
> +		/* disable scheduler on the real ring */
> +		ring->no_scheduler = true;
>   		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
>   				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
>   				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> @@ -2363,6 +2369,42 @@ static int gfx_v9_0_sw_init(void *handle)
>   			return r;
>   	}
>   
> +	/* set up the software rings */
> +	for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
> +		ring = &adev->gfx.sw_gfx_ring[i];
> +		ring->ring_obj = NULL;
> +		if (!i)
> +			sprintf(ring->name, "gfx_sw");
> +		else
> +			sprintf(ring->name, "gfx_sw_%d", i);

I think we should use something like gfx_low/gfx_high for the ring name 
here.

That this is implemented by a sw muxer is pretty much irrelevant for 
overspace.

Maybe use a static array for the names or something like this.

Apart from that looks good to me.

Regards,
Christian.

> +		ring->use_doorbell = true;
> +		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> +		ring->is_sw_ring = true;
> +		hw_prio = (i == 1) ? AMDGPU_RING_PRIO_2 :
> +			AMDGPU_RING_PRIO_DEFAULT;
> +		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
> +				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP, hw_prio,
> +				     NULL);
> +		if (r)
> +			return r;
> +		ring->wptr = 0;
> +	}
> +
> +	/* init the muxer and add software rings */
> +	r = amdgpu_ring_mux_init(&adev->gfx.muxer, &adev->gfx.gfx_ring[0],
> +				 GFX9_NUM_SW_GFX_RINGS);
> +	if (r) {
> +		DRM_ERROR("amdgpu_ring_mux_init failed(%d)\n", r);
> +		return r;
> +	}
> +	for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
> +		r = amdgpu_ring_mux_add_sw_ring(&adev->gfx.muxer, &adev->gfx.sw_gfx_ring[i]);
> +		if (r) {
> +			DRM_ERROR("amdgpu_ring_mux_add_sw_ring failed(%d)\n", r);
> +			return r;
> +		}
> +	}
> +
>   	/* set up the compute queues - allocate horizontally across pipes */
>   	ring_id = 0;
>   	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> @@ -2413,6 +2455,10 @@ static int gfx_v9_0_sw_fini(void *handle)
>   	int i;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
> +		amdgpu_ring_fini(&adev->gfx.sw_gfx_ring[i]);
> +	amdgpu_ring_mux_fini(&adev->gfx.muxer);
> +
>   	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>   		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
> @@ -5877,7 +5923,9 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
>   
>   	switch (me_id) {
>   	case 0:
> -		amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> +		/* Fence signals are handled on the software rings*/
> +		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
> +			amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
>   		break;
>   	case 1:
>   	case 2:
> @@ -6882,6 +6930,61 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>   };
>   
> +static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
> +	.type = AMDGPU_RING_TYPE_GFX,
> +	.align_mask = 0xff,
> +	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
> +	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
> +	.vmhub = AMDGPU_GFXHUB_0,
> +	.get_rptr = amdgpu_sw_ring_get_rptr_gfx,
> +	.get_wptr = amdgpu_sw_ring_get_wptr_gfx,
> +	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
> +	.emit_frame_size = /* totally 242 maximum if 16 IBs */
> +		5 +  /* COND_EXEC */
> +		7 +  /* PIPELINE_SYNC */
> +		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> +		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> +		2 + /* VM_FLUSH */
> +		8 +  /* FENCE for VM_FLUSH */
> +		20 + /* GDS switch */
> +		4 + /* double SWITCH_BUFFER,
> +		     * the first COND_EXEC jump to the place just
> +		     * prior to this double SWITCH_BUFFER
> +		     */
> +		5 + /* COND_EXEC */
> +		7 +	 /*	HDP_flush */
> +		4 +	 /*	VGT_flush */
> +		14 + /*	CE_META */
> +		31 + /*	DE_META */
> +		3 + /* CNTX_CTRL */
> +		5 + /* HDP_INVL */
> +		8 + 8 + /* FENCE x2 */
> +		2 + /* SWITCH_BUFFER */
> +		7, /* gfx_v9_0_emit_mem_sync */
> +	.emit_ib_size =	4, /* gfx_v9_0_ring_emit_ib_gfx */
> +	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
> +	.emit_fence = gfx_v9_0_ring_emit_fence,
> +	.emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
> +	.emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
> +	.emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
> +	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
> +	.test_ring = gfx_v9_0_ring_test_ring,
> +	.test_ib = gfx_v9_0_ring_test_ib,
> +	.insert_nop = amdgpu_sw_ring_insert_nop,
> +	.pad_ib = amdgpu_ring_generic_pad_ib,
> +	.emit_switch_buffer = gfx_v9_ring_emit_sb,
> +	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
> +	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
> +	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
> +	.emit_wreg = gfx_v9_0_ring_emit_wreg,
> +	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> +	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> +	.soft_recovery = gfx_v9_0_ring_soft_recovery,
> +	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
> +};
> +
>   static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>   	.type = AMDGPU_RING_TYPE_COMPUTE,
>   	.align_mask = 0xff,
> @@ -6959,6 +7062,9 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
>   	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>   		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
>   
> +	for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
> +		adev->gfx.sw_gfx_ring[i].funcs = &gfx_v9_0_sw_ring_funcs_gfx;
> +
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>   		adev->gfx.compute_ring[i].funcs = &gfx_v9_0_ring_funcs_compute;
>   }


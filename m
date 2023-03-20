Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC13C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 15:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD1410E2DE;
	Mon, 20 Mar 2023 15:46:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A214110E2DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 15:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxY5dpcZ22l/8+kbAmcaUNXIX4HDUBdBRYQm9qxT7PVewzpQINvdP5vQvLQqLXkTLMdCjm7JWECsUTOPIM7UhtPZrUV6RxDc21wzYUQUXswyeXDe7TBsNm1oOZwa0ydpSHAPpoLnmpZHzuk5TuUx+U0cTdw9EGvKsH5I1tGwlj/4W4XBo1qcdC7FTk7iuHJgu6n5jAVbPEvJINF1tjFgBcDFXVl8Iujj1AaqutMD2ASwAji6pBBMEFePPecI2KfS2qYKqYUrOVTjd8UR+s9IDa82NGo2TAcTZyZZX5vqKVhFnzuQG9wiJzlG2TuQ++13e/O2BtPn7jT80ROO4Mavxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lQ9Rd1RJ6oqMgQ6fIOh9X4A/vczmBgKuucmDR+6LjQ=;
 b=kUyptrt3jpXLCloxLOR4TeXLz8Tjcwf5oxoedzo4yyTlOLocRIegv8aC8sT3/D9ubrfZFpqTeOJW6RdvdbsVqRlv4AZOj1wwwyXRjbKsNRMZ5FNBUjf7FoWcGLs0WXMyoJd1rkJdWXDgyqFoSuL3sNbEqI9YyM+e0Wwd1o17N7EBLpSDVfz4wvanNTYWyPDC1PoIHud83GVySs7BcJGKomjDuL/TFQxuY3YWHrtSKpjjjv8jmx6k6uhSmckWbR8W1rftuR1XVfHpx1mb3MpTisG028jYn8BTLaKLuusD/W2hfojKEhnGrjivoy7sSC4e/tNwgpVvJ0cnKbKMKGFe8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lQ9Rd1RJ6oqMgQ6fIOh9X4A/vczmBgKuucmDR+6LjQ=;
 b=e7fDNsGQNpI9ULTxzNWF/l+OkgFtubHbzeP53k5sK1BlQbaLYVbNIiIzYQaG9SjICK2KIoQFGCzJOHR6glI3Lc14+KbY/XZP+XiIvRh2CkCKH8PDncdIxU8a7pfCWFfdcoH+XXshXbdwizex4CtBDHWQWU5pMQ3YPm5u4lJpXY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 15:46:46 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 15:46:46 +0000
Message-ID: <a1b61e2f-d69c-4401-b9d5-46c80c14ae15@amd.com>
Date: Mon, 20 Mar 2023 16:46:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/10] drm/amdgpu: add gfx shadow CS IOCTL support
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230317171748.682691-1-alexander.deucher@amd.com>
 <20230317171748.682691-4-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230317171748.682691-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 943ecaca-47f5-40a8-cd97-08db295a4fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGRLfhuhnmOYUTYU6VB4ktOcKM6T9SfW9jqznLK41y/kd3G7haBwI0TQ6TywzxZfXV5w/BghnbD/1lbgI1ot7eB53AqeASczIp/MS+vzvefhhkqrlbLLNc0wnNvvXsPhjYocNxLza7HOjKkItqOMwMCqnTuz7sGlnZ5RMF/yXgpncRdQwfwNaiWyuh0pUFn3RMObgD3n7apayk6TjJTyUvkNL8e1gTZx4jqxf7G0DQCwKJB8XkfxIiQS530CH1igpknsCgLRJEH35/BbM2ujHCIQqBWOW1n9m1WvZT8v+FpnY+izy67Pz3k2yIOFiVQ6AA9J0DYaXLHD9jtJbPrvn5005exOcjwgRYpmYYeTQp89lXj4V5H0cpzvPTcq5ipQQXIuiEfXn5ebW0RFo/ABWJPDsJ0ZdEL0bSQSNi/2pMSWYlFCIQZ8U01G9bdP6I2BxAieSDBVOJIWmRArD012M5jaMgGT183RcQEJeRDDWJuLc2R3YPq9k042IfwZB1cBgJTiBQ4pNAmOe3FHF7j99teYk3U/fIu1PzP89G5dwVhJZkh93txXcbGhzx61N01vKbRLnFGUVLLz+yfZ35PcsEf9JunWKOCaGuY6KFhjdNM3EtiabkFiumtiiIUE/iwujdomtRZgpRUpJLQimoCalVNQD+FK43q4SMnqmevhfFHcwYXOGUqqkLw3TgyPQlF0jE1g0g320H+ksLTZ8SKd5tCACtPoUtq3ZvAyoutMFUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199018)(31696002)(36756003)(2906002)(86362001)(38100700002)(41300700001)(5660300002)(8936002)(2616005)(66556008)(6512007)(6666004)(83380400001)(186003)(66574015)(6506007)(316002)(6486002)(66946007)(478600001)(66476007)(8676002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlR1ZTlpd084NXYvbEt2TkhvTkNiVHorbW5jMkxDdkNkSDJRcUNFUTN6ZUk0?=
 =?utf-8?B?NFJ0eUVkaHdvUERpQm82Z1pTRlFhb0RhOXAwVDNxeUhsbm82U1Y0ZnhjamZ6?=
 =?utf-8?B?QnZZak14dm5ta1FaVzJzeDFIcXFOTmd1M3dTNXUzMFdXZWZMR2lqNlJqdVpa?=
 =?utf-8?B?SDhzeWxtR2t2TUNMUjIyZTZKaXhJdlpxaklFd29aZktkOWtWL3hNR0hNemkz?=
 =?utf-8?B?d1lrRko4K3hIY3ArWldzdVJuMGFjNXVhTWdXV3J2ejh0Uys1a1hNWFpVMW05?=
 =?utf-8?B?b2xkWG9ZN0RvVVkzT3c5WHRRMmdheGxvUkQ4dHlrVXM0L0hSaEkwMnFzODN0?=
 =?utf-8?B?V2pzWFZBenVBUGZlSnBFeUt5cnFqaUVVTVYwRzBGc2FJcmVzUWlCbG51MWdG?=
 =?utf-8?B?YmRGalEvM3BCSUZydzRMbkdMTnZwZ2NkSlJJNXhaaGRRZU1PN3dubFY1Yjcw?=
 =?utf-8?B?dzZxb0E4QXJlanNQcUZKeGtRS1JwK2FPL2NxMkN6dElBWFVGMnZKYUUydWw2?=
 =?utf-8?B?c0RIdW9yQmFIQ21jd2JoQUNhQXk0OHFzUis2N2FtVDFBa1orTllNZG9idFND?=
 =?utf-8?B?V01NVnVkUjRlWThCRE9rVVlpRW53VzBnUEpBc3RrY1Q3bEFsUE1DNTY2WVNW?=
 =?utf-8?B?M2tpaWhNS2Z5RXA5czFlMEExcEkzTWMrV0hGUitldG9xaVd0NzRkM3IxRnVY?=
 =?utf-8?B?M25VUDBSaWNvU3I5bGE5UmdDaWhmNm1sSDBQak4xNGJwWnlESU9uSEFXRTFW?=
 =?utf-8?B?YjVYNmY5cU9NVDl1c05nWkxHeDl4Zm9mYmJIZUNkeDJzeGNERzVwS293ODlq?=
 =?utf-8?B?YkRvQ3RtVko2bXR0TXYra2srbmdMQkZQdk9iTVQ2TzU0MHh2RkR0S0VqcFND?=
 =?utf-8?B?R2E5N3JGMmdTRmhhcXQ2VWIyZHF5M0tJcDdHZWVNZTBsdDMwTVRBWjNqdnQz?=
 =?utf-8?B?VFhIcWEyR3NOL2gxNXJ4ZDlGUGNzakxmbTlPa1lBN2JkbkhGRjNHZUNGQkt3?=
 =?utf-8?B?NVY5aHBPTVFPMVo1UTBCRmJkZHJxQlVHR1FQR2I3QWQyZnJVb0gvZDVVb1Fx?=
 =?utf-8?B?NjZ2Q2I2SDc5QkRyc2h2b0hCRlU0cEd1RlhpV2ErQ2FtM1ZDZUdFcHc3UHVk?=
 =?utf-8?B?Wmk1c0krVVNxVXFoS2dCNnBWLzQ2YmxWU3VXSHNjeWJaaVRJSlZibjN0ZUd5?=
 =?utf-8?B?Z3ZhM2Z5allLYU1HUlVGTjV3bnVFb0NiZUNTMGluWEFtSFdyU3ZKeFY4RDgy?=
 =?utf-8?B?K3RTR2xnQk9TSDdLV2gyKzhSRU9UVkZSbnBSZ3YzUFpTQ0QxbGN4UmxscVhn?=
 =?utf-8?B?aHdvbHdEcVFGM241K1lXNmVmZGJxMGZHeG9NeEluVjlyODgwaExhQlNzbDVj?=
 =?utf-8?B?MW5aYnltQnpoTWNjMTlMT0E5V1dyQWJlRDNMUnVpYlI1SS9ORE1IMjFVM3ZK?=
 =?utf-8?B?eWh6MHZka01MTjZuNjQ0Q3JFYTRVV1kyNVZaano1aXNZMjBYcTZOdFFTTE50?=
 =?utf-8?B?MHBNRkRjZERNazg4a29rMmxOWHFCYUlBRllvaWQzdG5CWTRTUG9EQVFJT0tU?=
 =?utf-8?B?Z25reHZFRTBLVWI3ZHYzT2IrN1U3bDZYeU5MYTVlUXByTjh0M2FYRngwbU1y?=
 =?utf-8?B?OTZtNDV3ZENjVEczU3kwYkJMLzUyRDh1dlRXWS93NWR6WTAzKzc1MUhNSFRI?=
 =?utf-8?B?ZjVxV3VUY20wcE9SZDIyalp6dmRDeEQydVFFRnhUY3Bqcm80ZU11bGhEU1NQ?=
 =?utf-8?B?ellVQmYzZ1AxVnJvSUEzYUtrbDFkS1RLblE4aFFJTWxXVVBLcEtMM21WRWww?=
 =?utf-8?B?K3lpNC9SQmJkT3dlaVVRRHdzL294VVJnN08ycXNicVZabWR2emJCdmdXZWF0?=
 =?utf-8?B?TGhsZDk1bnZpbEJ0RGdYZStjVXpWSGMreEprbXVqcGRkR1EvdDNWc1NveFRC?=
 =?utf-8?B?eU12dHVmeGtsam8xazc5L2VQWFpsdE5xN2pPN3NUQVdhVHBOTmtTTjBZNm4w?=
 =?utf-8?B?UUYreGFZRVN6d2J0RWw5b0lhOXRQMG0wdGdiK3Vzbkd1RXJUQkdNeExVNk9p?=
 =?utf-8?B?aGwvVGNsYmZaV24xd0o0a1NBelRmWkd5aFYwQ2VyWDNoK09iK0p4bmw0TkNY?=
 =?utf-8?B?K0kwSlROam5ueTlPRnF1N091LzRFYmIxenJVYmJqVHRuclNWZjBjdUFBcy8z?=
 =?utf-8?Q?waj0Y2FbmfNpj6flgrLGN3gF4LQ+2YOLU9WdpKoT8zlj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943ecaca-47f5-40a8-cd97-08db295a4fc1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 15:46:46.6516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izzMdrq4dGe5Q145eMDBvf/t/FiWV9tmJy5S9Ees3m2yTKy6yK6HF1GNP7KuOwIq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944
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

Am 17.03.23 um 18:17 schrieb Alex Deucher:
> From: Christian König <christian.koenig@amd.com>
>
> Add support for submitting the shadow update packet
> when submitting an IB.  Needed for MCBP on GFX11.
>
> v2: update API for CSA (Alex)
> v3: fix ordering; SET_Q_PREEMPTION_MODE most come before COND_EXEC
>      Add missing check for AMDGPU_CHUNK_ID_CP_GFX_SHADOW in
>      amdgpu_cs_pass1()
>      Only initialize shadow on first use
>      (Alex)
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 24 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>   5 files changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index f6144b378617..9bdda246b09c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -280,6 +280,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
>   		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
>   		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
> +		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
>   			break;
>   
>   		default:
> @@ -587,6 +588,26 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
>   	return 0;
>   }
>   
> +static void amdgpu_cs_p2_shadow(struct amdgpu_cs_parser *p,
> +				struct amdgpu_cs_chunk *chunk)
> +{
> +	struct drm_amdgpu_cs_chunk_cp_gfx_shadow *shadow = chunk->kdata;
> +	bool shadow_initialized = false;
> +	int i;
> +
> +	for (i = 0; i < p->gang_size; ++i) {
> +		p->jobs[i]->shadow_va = shadow->shadow_va;
> +		p->jobs[i]->csa_va = shadow->csa_va;
> +		p->jobs[i]->gds_va = shadow->gds_va;

Do we really need all three VAs separately?

> +		if (!p->ctx->shadow_initialized) {
> +			p->jobs[i]->init_shadow = true;
> +			shadow_initialized = true;

> +		}
> +	}
> +	if (shadow_initialized)
> +		p->ctx->shadow_initialized = true;

This is a really bad idea since the IOCTL can be interrupted later on.

Why do we need that?

Regards,
Christian.


> +}
> +
>   static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>   {
>   	unsigned int ce_preempt = 0, de_preempt = 0;
> @@ -629,6 +650,9 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>   			if (r)
>   				return r;
>   			break;
> +		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
> +			amdgpu_cs_p2_shadow(p, chunk);
> +			break;
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 0fa0e56daf67..909d188c41f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>   	unsigned long			ras_counter_ce;
>   	unsigned long			ras_counter_ue;
>   	uint32_t			stable_pstate;
> +	bool				shadow_initialized;
>   };
>   
>   struct amdgpu_ctx_mgr {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index bcccc348dbe2..d88964b9407f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -212,6 +212,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	}
>   
>   	amdgpu_ring_ib_begin(ring);
> +
> +	if (job && ring->funcs->emit_gfx_shadow)
> +		amdgpu_ring_emit_gfx_shadow(ring, job);
> +
>   	if (job && ring->funcs->init_cond_exec)
>   		patch_offset = amdgpu_ring_init_cond_exec(ring);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 9790def34815..b470808fa40e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -68,6 +68,12 @@ struct amdgpu_job {
>   	uint64_t		uf_addr;
>   	uint64_t		uf_sequence;
>   
> +	/* virtual addresses for shadow/GDS/CSA */
> +	uint64_t		shadow_va;
> +	uint64_t		csa_va;
> +	uint64_t		gds_va;
> +	bool			init_shadow;
> +
>   	/* job_run_counter >= 1 means a resubmit job */
>   	uint32_t		job_run_counter;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 3989e755a5b4..8643d4a92c27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -212,6 +212,7 @@ struct amdgpu_ring_funcs {
>   	void (*end_use)(struct amdgpu_ring *ring);
>   	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
>   	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
> +	void (*emit_gfx_shadow)(struct amdgpu_ring *ring, struct amdgpu_job *job);
>   	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
>   			  uint32_t reg_val_offs);
>   	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
> @@ -307,6 +308,7 @@ struct amdgpu_ring {
>   #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
>   #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
>   #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
> +#define amdgpu_ring_emit_gfx_shadow(r, j) (r)->funcs->emit_gfx_shadow((r), (j))
>   #define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d), (o))
>   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))


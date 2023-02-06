Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E958C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 16:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4F210E16E;
	Mon,  6 Feb 2023 16:30:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC54810E16E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 16:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcK5bzji/3fTzH6W5+huKVdumS3DZ9w3lSiGbjD1jMlTZa8Rs7pJfHHs7HF7TgQ4qo5abxCTGgZOIxuJLMxeGFx3V5SXNbqtFCxU+1XBmgdrNJ65LxNBYH+B54uAYJL+LV2DUUahPLFD1PtlxW8uA96KwnMkDO1VcyHarx2rukgXRj9VJhJFZb/HKcqx+t+RtCp14vzE/X8mSIiJkHdjwFbShblA2Oaw3Q2qAe0XKeZOmDTezq1U9AWZVJ5eiloaCFhPUjJE4z453CQBP9GzibStCy9Dx5+FfB8S96BOJwe3yprXTp+7mOx5Rx31RHNpqReb7S0xMaCQa+VwbP+iuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67xUMAJ0Bi6jdBtQmBcfqcyFWE/T9I5GO0yAZG865OI=;
 b=IkfR4DtDAqlj+UmlYrIVtYyy70fdy44XfrZeGl7Z3v8nMCuVhZ2zvnSSkDo0XQ9mACBInAoHSLwvgfpsKyMTSWnlKz18nBd7puHA1cfP/QDV3k2qXfD6H3f1K8aItiB+1srCQnk8Jv90B3EscpFJdAqT8+yGBYnL+VgTjWDnatWgYO/KSMqkSJXzXVquNHeOtrdsS7jt2SYLtVqttNO5SPY5j+FpiYrOaFWpL6Fq2PrIKEkMd9fDzE9UNzGTY8C8XtVC5DjRlxgT/vVmQ6o//hxN8DrCt+jKi6t56xeMFvCLv7uRAsqpWYgiVKha4KC1r6v+0fC06RZlsLEWSDcjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67xUMAJ0Bi6jdBtQmBcfqcyFWE/T9I5GO0yAZG865OI=;
 b=BZaSnyz9OyKgyGHrAVuOMNf2He9cM5amhiZ2JkNJM20kzYuXfhmvwmCO0QY+HDa0q1mxKokKIRful06pz+Kf3gHMkyz480zURHxY04joKUGVc8MiKw9gWCfdoLbec/tKWry11s0d36TDbbKogXahjKPrzbsSnNxgfdpb5VcH2Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 16:30:31 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 16:30:31 +0000
Message-ID: <423becc1-5bdd-a50c-16b7-cffb66cb833f@amd.com>
Date: Mon, 6 Feb 2023 17:30:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 10/13] drm/amdgpu: doorbell support in get_memory functions
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-13-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-13-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 40467fb1-63d7-4090-de04-08db085f7686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14kVd3jz7oFy1icRp14TiEeLHKTZN9khY131yooKGvYzHlBRolCPEvmGSB5+cEuXfLht0I7324xcA+JPnxjV0gbszlCOe4NSVEAUQIXs6X/09/JUPFQZz6l/61ZcvWGH+2I8P7LZQqY9C89tjMWGKhRf7jOKxa1WQ/qdSF6E7/xmwSup+9Mg4j5iTTKAJq3Xt5wAs5RnbJ7DmzgUjkBr4JDfuDrDY6PWmbJEJIGzfyOUUu3D3eOMCsXw0KoEYxRe1PKQcrgF5Cgz7duk+/tdlhQMr6HHZfmx90XcJ7suyiiUZDZJ1BdggS07bB3yrzgn1YU7Ig+HPtb+ej3UFBCPN+Pe1yeWTeIzRIE/gXeURbeSsTkJ2A1rAHOk/eWm4aRBHbZnqYmIQ9fa2fuPOUdIHxXKnBMj9aOGG+sA9sujqX0FY7/RiTkzuKrDZfUVdHWcChWPftVEFAxdFnaeb+OjBqxhOW/stIqb0cw+zH9yit3c23E8UpKI6X8R1xoqQdUw+1svlLcsj26Tk/oprKXEawzjQ3nIKus74pkygeAw6jT7FL3dm45dCwnt4q+JpXz1NUCS521gXETsy3hwBo33pmH0DY4NvtejTPDm5qFGpqfdexnoFsCY1hh3dNJt9ctbEtrz/jifWD/uFFAqtxJlbPkD74rAnVyEDDSxi0YBtgbkXITLNB9QKPF9Vf/FEMqKeSYPXIx8mVeCSCOaZ7gppfxRAP+v6L3sb462VkRV+ZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199018)(8936002)(4326008)(6512007)(8676002)(31686004)(41300700001)(66476007)(66556008)(66946007)(186003)(5660300002)(6506007)(2906002)(478600001)(6486002)(36756003)(316002)(31696002)(86362001)(83380400001)(2616005)(6666004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2UyZnN1L2NNZG5TZFJyQmNaSTVWU2JDVTcxNFkvRU5ra3RNZGJ3OS9kOHBo?=
 =?utf-8?B?SlNGL1YxeXlpOHI0MFZvQThaS0pSaVhDTjBGQVk1SC9QRUhpT2ZYMU5qckRZ?=
 =?utf-8?B?RkNGZmk1b2ZTQ214K05ZZ2k3OENKcWpqWWo2blp6NU9jNVplZUVYWndDb2V4?=
 =?utf-8?B?RFhJS00zbjV3UDlpZjVqNVRxcUxReXhPS0ZlT3NkbVl0TWNsc1BtdjNsTWpP?=
 =?utf-8?B?Z3pJVEMzMStCODA0RSs1ajJYNmlCY01mYWpuOVlwL1ZYZ240azA2NmlUb1ZX?=
 =?utf-8?B?Tk0wVDRQd2F3ajNmSDlUSFpTaXM1cjE3RURpNkROSnZWWmRFMjlLbUxXY2xm?=
 =?utf-8?B?N0tFYVliRGlkNW83TWdSd01YL3pvYXE3OUUveFVFRi9mMnZiMCs5aUxlcGts?=
 =?utf-8?B?Rk53VThRUTh0aHFZYnQzS2lMMDlxald0ZXhTVXBmRG9LWnFIRm5sdTZGQVZ5?=
 =?utf-8?B?dFJXYndtWkYvOXlhS0R0b3FFU1l2OE1tUHhCMisrT2FGZG5kNlNCbERMa3dY?=
 =?utf-8?B?UXpvT1lCY2lZZUFRcGMzOWMrUk54YkNpS1VPVTBza1UybzZ1ajU2dUZJdHR6?=
 =?utf-8?B?aDB5NGJWcDVkMmp1OVM1UGpkNkh5QmE0WFJvTVZNeFc4bW9kdFlYNHZwaEcx?=
 =?utf-8?B?dFk0VVdKUVpEZDFMZnRZZkN5ekVFVGU0T1VENElvTTdRUS9jVVVQNThveWlw?=
 =?utf-8?B?VVVtT2lTcnkwVmtraWJzQzNKMkxodVBQQkpacjkvVmk4U0xhVUFGWWEyZm9s?=
 =?utf-8?B?OElPamQ5YXduVG1VcUJiNFcyUUc1Z2dYUDJkaXRvVGh0ZmNyb3hoblozb1U3?=
 =?utf-8?B?S0ZYQUY1RVVpWG9wc0E5dDAwd0xxL2E0dDBpTnhqMEtmTHlGV2dWM2JJb04z?=
 =?utf-8?B?K1pjMllrU2E4TnJnVmhpcUpkekN0WERBZ1VmWHRaTGpxaXkwaGJzc1ZuZ3hY?=
 =?utf-8?B?YmtFb0VFSXV6cFZBQlNSOTlnaERYT25DVzd1Nk9uVncvWGJ5NlVobmpCRWlx?=
 =?utf-8?B?Z1dQSHRBUXZJS3huN2Z6MHVpTXBJUzhJM1hydkQrSlFScFkzUGpQQnZtMzly?=
 =?utf-8?B?K0tpTEw2aUErK1RmUklZYVdxY1FHWmxDcHV1S0ZaQTMrQWNnZ1RkR2N5V2kv?=
 =?utf-8?B?SGtpRDBvL1hkR21YeFBNWVh2Z3hsLzEyOWV0YlF5blU0UDVuTmZPV0E2Y0lv?=
 =?utf-8?B?UjNGbnExdzM4dzRUanVzNmFiNjc0dUYvblljV21iNlpXOUZwaU5Ca01yZWZ1?=
 =?utf-8?B?Z1RSTDZ5cWlNekVCYUtJK0p5SWswQTh5NzB1VU4xb3UrSFd0VUlTZWV1b3Bm?=
 =?utf-8?B?c1c5eDhBL2RKdUNubUJma01VRGxwZ2E2MnlJVmtsWEU1cnlqTGlYSVg0N2xw?=
 =?utf-8?B?dEUrZ1JDNmhnUEU5WjZrQ0JrNExMYlM5aVdGakRzYW5NNWZwcjdKTFRHeWZo?=
 =?utf-8?B?bDhTNDMvLzcvcExTeXRaWmFDeXo2cnd2aUZwWklRTzM1ZmNtYmtRaTc1cW9v?=
 =?utf-8?B?aTVTN1dyVk84UFcyQlF0ZEF6Q3R2alVVWkFadVhPSXdkdmJyV2xzb2NxUTBz?=
 =?utf-8?B?RkVXRzcwUWhTMnBYN1dickFTNXRQNVErc01wZnAvR0dkbTdGRnVXenNjeE9E?=
 =?utf-8?B?K0srd3JDbnR6dGdWWmZzUTNqSDc4eG5zZUdveEtZQUFSTkFhWUcvcjFYWVh0?=
 =?utf-8?B?YWw2YmlHU2E3YTRab3F1eFlLLzRSMGFRVzNCM0FTbnJXRmpVTmQvV3p5TThB?=
 =?utf-8?B?R0JDbWQ2V3RwakU1WEFUb3hFSHBOcHlUamo0S0VmWG41SnFGcDc4MjFyc3N5?=
 =?utf-8?B?clJuWWV4cjVNQnNRK1FJei9iUlVhMEJIZzI1ZmJCWUdreFh6Uk9JQ09zcVJa?=
 =?utf-8?B?TDVCdDZIMGt2eXpTc1gxMlJXOGJURjF5ODNwZWwyY3NoZWY5ZEtGVlZZando?=
 =?utf-8?B?VmFxTXZYbWRabVR2bWFLTkZ4QVorN1hFOGFBdGNCWEpHb3d5dVJ0Y2tseFlY?=
 =?utf-8?B?UmVtUGVWdnpzUDVob3E1TDhwc2ZhaU0xekhITEk0TEdtUXN4Y0oxMHZscVh5?=
 =?utf-8?B?VWxmTXk2T3ZzWXRCNEJUSis3UTF3Vy9WaURrLzlRa3pUdHZ4L0w1RHQ2OWZT?=
 =?utf-8?B?eGk4Ui8vN1JkOHZ5czhpWUprb0N5Z1JpU2xzdVBoa0QzWGVTWVpHRU0xRmJ1?=
 =?utf-8?Q?wJIvOILnhG1mHmkxzY+cGdJgJ/mMKMXTkfmIxa4bnjW1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40467fb1-63d7-4090-de04-08db085f7686
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 16:30:30.9334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWcrzVpULBeXTziahqIUBCLiQF+wVHVhE+iT/WZ7TYLSw1mpXSoIpEXzLXrof6C1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch adds section for doorbell memory in memory status
> reporting functions like vm/bo_get_memory.

Marek reworked this just recently to pass around a structure. You should 
probably rebase the code when that patch lands.

Apart from that looks good to me.

Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 15 ++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  3 ++-
>   5 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 99a7855ab1bc..202df09ba5de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -60,7 +60,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   	struct amdgpu_fpriv *fpriv = file->driver_priv;
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   
> -	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
> +	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0, doorbell_mem = 0;
>   	ktime_t usage[AMDGPU_HW_IP_NUM];
>   	uint32_t bus, dev, fn, domain;
>   	unsigned int hw_ip;
> @@ -75,7 +75,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   	if (ret)
>   		return;
>   
> -	amdgpu_vm_get_memory(vm, &vram_mem, &gtt_mem, &cpu_mem);
> +	amdgpu_vm_get_memory(vm, &vram_mem, &gtt_mem, &cpu_mem, &doorbell_mem);
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
>   	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index b2cfd46c459b..ef1f3106bc69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1288,7 +1288,8 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   }
>   
>   void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
> -				uint64_t *gtt_mem, uint64_t *cpu_mem)
> +			  uint64_t *gtt_mem, uint64_t *cpu_mem,
> +			  uint64_t *doorbell_mem)
>   {
>   	unsigned int domain;
>   
> @@ -1300,6 +1301,9 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
>   	case AMDGPU_GEM_DOMAIN_GTT:
>   		*gtt_mem += amdgpu_bo_size(bo);
>   		break;
> +	case AMDGPU_GEM_DOMAIN_DOORBELL:
> +		*doorbell_mem += amdgpu_bo_size(bo);
> +		break;
>   	case AMDGPU_GEM_DOMAIN_CPU:
>   	default:
>   		*cpu_mem += amdgpu_bo_size(bo);
> @@ -1578,6 +1582,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   	case AMDGPU_GEM_DOMAIN_GTT:
>   		placement = " GTT";
>   		break;
> +	case AMDGPU_GEM_DOMAIN_DOORBELL:
> +		placement = "DOOR";
> +		break;
>   	case AMDGPU_GEM_DOMAIN_CPU:
>   	default:
>   		placement = " CPU";
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 082f451d26f4..bf9759758f0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -326,7 +326,8 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>   u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>   void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
> -			  uint64_t *gtt_mem, uint64_t *cpu_mem);
> +			  uint64_t *gtt_mem, uint64_t *cpu_mem,
> +			  uint64_t *doorbell_mem);
>   void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
>   int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>   			     struct dma_fence **fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index dc379dc22c77..1561d138945b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -918,7 +918,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   }
>   
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
> -				uint64_t *gtt_mem, uint64_t *cpu_mem)
> +			  uint64_t *gtt_mem, uint64_t *cpu_mem,
> +			  uint64_t *doorbell_mem)
>   {
>   	struct amdgpu_bo_va *bo_va, *tmp;
>   
> @@ -927,37 +928,37 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
>   		if (!bo_va->base.bo)
>   			continue;
>   		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> +				     gtt_mem, cpu_mem, doorbell_mem);
>   	}
>   	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
>   		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> +				     gtt_mem, cpu_mem, doorbell_mem);
>   	}
>   	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
>   		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> +				     gtt_mem, cpu_mem, doorbell_mem);
>   	}
>   	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
>   		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> +				     gtt_mem, cpu_mem, doorbell_mem);
>   	}
>   	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
>   		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> +				     gtt_mem, cpu_mem, doorbell_mem);
>   	}
>   	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
>   		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> +				     gtt_mem, cpu_mem, doorbell_mem);
>   	}
>   	spin_unlock(&vm->status_lock);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 094bb4807303..b8ac7d311c8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -458,7 +458,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
>   void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
> -				uint64_t *gtt_mem, uint64_t *cpu_mem);
> +			  uint64_t *gtt_mem, uint64_t *cpu_mem,
> +			  uint64_t *doorbell_mem);
>   
>   int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       struct amdgpu_bo_vm *vmbo, bool immediate);


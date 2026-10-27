Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A994606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J/BVakWZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D3C10E19E;
	Tue, 27 Oct 2026 06:34:01 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689F910E19E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 06:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaCZjrAIueZI5mljIZ9Bzyww+eBd2ZbkBSKt6fSSxt9/DoaYPDwiVhWofh18m0/tVHFTj8akYoROzrSum8uiNY25rhBdDkHmD3VSCKiPUGzm3Cm8TtFhh54js225JVBSvcn3S5AKRkNGKV/Jd/cNvWJE0wT4U93QetnM986DjScYM/7YIeazkN3HgjFzMRiRLYcoQnHz5JYrDPFfVIqi/Rknaub9tBRvDNY8tkhomAQzzvy32knSZrKs04RrtLqgOlhzcHta8M8t0VqJhlPXfNbk5dg2gkN8oo6poByUICYicwmUut829K09ec8/ogxtVNq7qHFif0IthyeW3ZxqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzQlriTgC7/usfMBcZQY1Mp1Dx8PfRq5B12W5mNwprQ=;
 b=j+jR36O/eq/FC/kkSzKn/znyYy/ujN5aVu0nHVyglp0MgPMvcvs+/M+MaXiQ/V/15Ey+3qBGpYsPtRurAaif7QKva0HwaSev618z6OMklmn0GbXPAoQ4UJR6YXSUq2V69o+RgOFMHlMxODxD/S0Yyu9ZBd7GdZ91vBZklpyG/qKgb+Mioi0sTgaNy0Gao46fQFbhG7bo2Vn0D9aSBb1q9JfOFT7IzSILiRB6oRhaAX/iwGyWDN2JrcnszaU+HyqoR5n/y2VMM0cg4O/Y6PpRhwtD+F3lTd37l64a1X+NL/9Z7ckBWmh+XX8flRA5Ht5MoxLeZu0pt/Hnc5MmQtqAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzQlriTgC7/usfMBcZQY1Mp1Dx8PfRq5B12W5mNwprQ=;
 b=J/BVakWZiTiYZ08lflvdtFM3G1rFSfo3h2I++BqYWWUupDVJHjybjLoRk0vuVnr5mo0iinXdEdMvION+qJacYrFql5ZBMA+sUT6byJmzLK15atduA+RKfLJrSJB7UD2OWFyxlWh4+VSokxeg+ACMh3v1e1YuLbJ+E38jJPCGFLQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:33:52 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:33:52 +0000
Message-ID: <0c2a9ad2-5c64-4bbe-9dc9-cd692a6ec7da@amd.com>
Date: Tue, 27 Oct 2026 12:03:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/amdgpu: Attribute UALink loopback messages to the
 correct sender
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
 <20261026230248.1597606-5-mukul.joshi@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261026230248.1597606-5-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: c906a281-2fd8-4e05-a02a-08df33f44473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261026121527099003|18002099003|22082099003|56012099006|4143699003|11063799006|261021123027099003|10067099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 8YF/x4rV+x4I3+C0hUkVeDvJAii9Pf/gbNHGTd4pbTzT+7cgVefNODEJkyTgE8uZKjFuZ1PToaaAN9Prq6d5/H0xHyGtqLQBaz+Ql6h1UJz2PQIFx0qOAMw0ZLZnn4vMU1jh7b0fd+8H94wlZ7O9bJbv9k4hRsKH38W1b2VRVaZx39Mnzk38tzRIlDM3fs4FFr+tg37LfxptAMQmGe+jwjJqhOEzDWJVoBYjATUEEkmg7eXFLw9i93SfVSXBNwE4w1x9ZZHcoOt1Oy7SLwNdhPYbk2kv58zTI4e4pOe4k/N/yREC4RsMszWcN42gQvEwkdMT1JYIHiSTMytY42oq6Q0ENrEo36dmtqGzAgpygVhEGrDj7Ab6QKHA1sbGLqk2Dy1jamg9AmA6NKHv6fRt9B7KRwBjlgCdY5EE/WIQvpGrt77HxjPAtvNMavQJSNVyntul/o24KbTEnzD0wpP60bLpmMfkVemlOLo9By5NuirnL1XUsqUW6oj9JigtptKM8ZEdF9infQ1x5Lhjn8O5ThwTM0Kg0qi3STnrUw5CdSC2wDq6uXdDzUPzM+upd6xaN9TXhvtDR0o2bsszkwbT03wvG7QRtHIgjhCeI3MYr8IfvtmLdt6sYroPNKsLCKY7L8vd0lZVHFvr+iApoS04ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261026121527099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261021123027099003)(10067099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z05wM2ZtOEVvWXBtMld5cG92VXdwQlgvSVFXallKUkQ2WXFlcjVlVUdWaTFT?=
 =?utf-8?B?OHZuZkNlTStocXNWcTVoVEg3dG43ek9tbnI5SFpTWXlKSm1HNURHOHVlVStZ?=
 =?utf-8?B?NXpNOXlIYy9KSFk2SVVQMENSbGJCbmRYSFFCdkhzK3lEdFFQQURTaFZ1djBT?=
 =?utf-8?B?djlVQkNRdDFFSUR0MmVaOVFvQ2lKTEd2ZzdYVTA4UXYwT1RFWkFCdUFEcWhK?=
 =?utf-8?B?L214VVNCdUZwMlVaVFlVMk5ZRVpheDFYZ1IzdHE3YlBYc0xUMGpxUSs4aHdH?=
 =?utf-8?B?WG1ZRW5LNzZLWC9GSmJaZk9SSnBhbzlTMmJoU3dVaDZRZlJUS0pkSURReTlP?=
 =?utf-8?B?Z200UjNhWE5ZKzYrMzdBd3RJT2xOeFQwazUzN2tGZ1hMam1FcUxqancweWNx?=
 =?utf-8?B?ZWpyMFdqVlExZkpKdnU1aTNzbnY0QW9zMlZXWldMWmdrWWc0ZHM1THo3czJE?=
 =?utf-8?B?Z2hOZGN5SjFSbTFVdzFHVWlVSnkyU3RYbDhqeE90UWhycVkydE5ySGFKVDg5?=
 =?utf-8?B?ZUlNNVFMcWtMYmVhRzl2NkxvMjNKY2NJT0VlNXdvTjM5NUJjcG9qQWp6RnRx?=
 =?utf-8?B?WUR2MWNMd3lRanJHL2NUWktrWEZvL0pqMi9HZ0xoL0QvZmZTc2Q3czNVaEVm?=
 =?utf-8?B?Ymd1Z2FyQ2l0Ym0rTEF1ZXZVRElPMU90T1VJS0pDZ2hPVFJpcnkrOSt3RG9U?=
 =?utf-8?B?VlNKZnZndEc0ZUhTbUw5Q1EySFIzMVdOaFNQNXJLMFVWM1g1UTVHZE0rMDdG?=
 =?utf-8?B?SVlQYjdEQ2hidXFPMjluODJDazRuRnRBZUVVL3ZjejFjWnVkSjFmL0prUEt2?=
 =?utf-8?B?c21iaHRjdkcxTmpzcWphcVJMMURXcm9yYXFKWk1KaS84MEwwdXowL0xJMXVi?=
 =?utf-8?B?UlQrRnBDZm5Wa3Zyc1BFRjg0dHZFZEdMWTB5UEhoQTBvWW1FVVFjSWRMRi9y?=
 =?utf-8?B?a0VxcGw5RWxCYi81Y294TzZJTGVwRG9RSTVESTNoWDNpWGJIZUpVdWE5Njh4?=
 =?utf-8?B?Y0ZFaGFURU9pNzlFODhycXhMVjY3VW1waWxxSnFtV0tkdmtoS3FNR21CcXdQ?=
 =?utf-8?B?aW02bzlyM2U5aktaVjBBZVFnVlZNMGFUYjYxaVhNSEhzOU9iQ2NscHByYjkz?=
 =?utf-8?B?SlM1bGNGSUp5WDhxMVZRbEFzTithS2gvNWs3U0RRZGswZmtIQVZ6UkppYUw4?=
 =?utf-8?B?dEIzWHhMZkxCa3VoSzRLd3ZtQzVyNTl0Skg0TlZkYnRnOEU0TTFra1VBRi9Z?=
 =?utf-8?B?N0loRFY2ZXI5Q2pZRnpTSURCUit5NXkwdnh5VGJqc3MrTUplMWlDTGNQN0lD?=
 =?utf-8?B?R1hZT2hKbXRtdkF5N0ZtNlZidmV0anhtMzVpcWtpdnNkamhzaHhaTytjTDJ6?=
 =?utf-8?B?Nit3Y3grZVpYU1NPS0hxZTZxQjN4UjQwS0ZoQm1EeHlJZUQ2bG5icU9jWlpT?=
 =?utf-8?B?Y2l0cFhoZXBJSmt0dUNTTjRHK3FrVmFzbmhVZGNLdlJwYlppYTcvNnpsdXJQ?=
 =?utf-8?B?Z1JlbURMOHcxeXFZaXJFYndTampUZVpIcHFseU1wZHQwdURxQlRRU1NObHhr?=
 =?utf-8?B?SDhheTgxMUFXc3ExL2FBVWJ4d29sTWt0US9wdTRVcEdSNGZZRCtHUHVxTVlK?=
 =?utf-8?B?UlNQcHloMTVLaytDMjA1dDZCbUUwYkpiaHVPTjlyRDRFNGRpS2Mwem5yYlZR?=
 =?utf-8?B?Rldpa2dmc0VkMm1LQXNPb3ppdWdBZTlYdFd5cTJDWnVNTTBUUkNzbmNTRTRq?=
 =?utf-8?B?d1YzTWNwU2d1Q3VHdVZiQS9pbkVXR1Y0RjErUDh0eGN1U0dUL3RNbS8zbUtJ?=
 =?utf-8?B?MmxzRkVKWC9KNTZ4aG5MWHY4bFYvWVBMbDdUQ0JqZVg0MHZKUEl3bkhMbFRC?=
 =?utf-8?B?bysraVFablExNXQ3RmhzbVFmWHFtUFJIaEpqMDF4WlVOcnZtZVJjaVQ1M1Rv?=
 =?utf-8?B?WktXVGM1U2hiTFJIWGs0WGZRY3ZuUDhqUkpVSUJtZzBVUFNLV2gzMTJqR1J2?=
 =?utf-8?B?cFhESURWNG83Z1hyLzRSSkd3TzBrdklmUGMrM3E5a0E1UmEwNXlLdEg4alJB?=
 =?utf-8?B?L2hObEs3SFlNRWVWRlo0Z1hPWnBXY2U1eFlIWThUM21qRVNqWXBiZE1XMkNo?=
 =?utf-8?B?eG04SnViK2MrVFFoYm5UcXZmVCszUGZjODcvTHZ4eXlMRngvZWtqdENJbi9q?=
 =?utf-8?B?QjYxZ1dWWUtJVVA3U3JKai9MeXFjek9ZRkZFWmRiWXpXLzcwODVQMXpvSWh5?=
 =?utf-8?B?ZmtNeDJHUUd4MkxIWmVydlZEcUh2cGpoQldxa2hMKzlDUFZIOStxR2VOd2pF?=
 =?utf-8?Q?Px36MlpvJBZsyED5IY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c906a281-2fd8-4e05-a02a-08df33f44473
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:33:52.4352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmU/0+WWpMQC+mOCfIAtAMSzEViIbS3RBAvc1ZGBDRapoiu6GJEFB+lBedCVx2Tz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 27-Oct-26 4:29 AM, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter and the
> importer, so the sender accel ID of a message depends on its direction.
> 
> - Send HELLO as the opposite role of the destination: a message to the
>    exporter is sent as the importer and vice versa. Outside loopback
>    this is still the GPU's own accel ID.
> 
> - The MPNHT FW stamps the IH cookie of every HW-delivered message with
>    the GPU ID of the single physical station, the exporter. The only HW
>    path is importer -> exporter, so attribute these messages to the
>    importer. SW-emulated exporter -> importer messages carry no IH ring
>    and already name the exporter as the sender.
> 
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 32 +++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index e40433bd79df..233ca804c4cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -1133,6 +1133,23 @@ static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
>   	return adev->ualink.info->ppod.accel_id;
>   }
>   
> +/*
> + * amdgpu_ualink_local_sender_accel_id - sender accel_id for an outgoing message
> + *
> + * Normally a GPU sends messages as its own (single) accelerator. In loopback
> + * mode the same GPU plays both roles, so the sender identity depends on the
> + * destination: a message to the exporter is sent as the importer and vice
> + * versa. Outside loopback both roles collapse to the GPU's own accel_id.
> + */
> +static u32 amdgpu_ualink_local_sender_accel_id(struct amdgpu_device *adev,
> +					       u32 remote_acc_id)
> +{
> +	if (remote_acc_id == ualink_exp_accel_id(adev))

Better keep additional check of loopback mode enabled.

> +		return ualink_imp_accel_id(adev);
> +
> +	return ualink_exp_accel_id(adev);
> +}
> +
>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>   					 u32 accel_id)
>   {
> @@ -2250,7 +2267,10 @@ static int amdgpu_ualink_send_hello_msg(struct amdgpu_device *adev,
>   
>   	dw0 = AMDGPU_UALINK_HELLO_MSG;
>   	dw0 |= (remote_acc_id << AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
> -	dw0 |= (adev->ualink.info->ppod.accel_id <<
> +	/* In loopback the sender is the opposite role of the destination, so
> +	 * the exporter side tracks the connection under the importer accel_id.
> +	 */
> +	dw0 |= (amdgpu_ualink_local_sender_accel_id(adev, remote_acc_id) <<
>   		AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
>   
>   	dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote AccId:%u\n",
> @@ -6557,6 +6577,16 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
>   		return handled;
>   	}
>   
> +	/* UALink loopback: the MP nHT stamps every HW-delivered message with
> +	 * the GPU ID of the single physical station, the exporter. The only
> +	 * HW path is importer -> exporter, so the real sender is the importer.
> +	 * SW-emulated exporter -> importer messages carry no IH ring and
> +	 * already name the exporter as sender.
> +	 */
> +	if (adev->ualink.loopback.enabled && entry->ih &&
> +	    src_acc_id == adev->ualink.loopback.exporter_accel_id)
> +		src_acc_id = adev->ualink.loopback.importer_accel_id;

Consider using the ualink_exp_accel_id/ualink_imp_accel_id wrappers.

Thanks,
Lijo
> +
>   	msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
>   	local_acc_id = adev->ualink.info->ppod.accel_id;
>   	dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",


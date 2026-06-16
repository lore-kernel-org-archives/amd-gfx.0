Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC0ECD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 08:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18FEA10E958;
	Tue, 16 Jun 2026 08:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4CaWhxO8";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A933410E956
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 08:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SATPYPS1MuJishOQtSNj/F4FA/vrR+DGsGri1qkiCCOsCxYTxP97ir7A4Tp1osR/1Bxk1+5QOf6pjID8uTtyGMRFBShgAuZnPudBtgdmh47MDA/3OdXP7wTw4VFrpaQnipPVFT9rCwQ9nnoG5uDbKr49PH0u1as4t/aq4WR7o8ujl5Y6TEL4tkX3xIp1L8L3sBWpP7sbwAuH0mxaEY7z1OJ0895bsSFCxgzqtfnDFAHLiZDA3Yf8kcel2mA0UyeURv21FFta5UDPTdE+fI39JnrJQcGH3LLpqwZgdsTNyPsFxosLbfDK1GPoFu4M5t7zbV+3Od7oXE79I0b7X3k/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p/mvFnk4mcV7urYBDD/lFesONVe6aQGgRBMUwSl/B4=;
 b=rE4hjpcr+Z1udDWARaeQ4jxqDZgsobceMF6iw2ra/8IG2XnUzkJcw9HYfYCdPjm64rav7LnPzjCCt3SgHVJu72Hg2OCHWp8md6A+b3dt8vtEJUW2vCGCIiWW27KJRbLPZumpK0wE4PfjqV1BnUEC5LOGcg+fAxTa7bV/m21SNpVNTcxPLbEOUjuzKlu5pPzVy98yAbVTZSowoLtXPhyUBduWb6ZUhmV51sAP/X+5rqEr7FLPHeHLuqir/9Y1XRVGGYk4gdHsp68TFkuBczCURxtziTprZpoB1kbEZMZD7AQZMLfgZ7GXylpRtCh18ZZxZ9+K3PqeCrpdIoJ+Mg+fnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p/mvFnk4mcV7urYBDD/lFesONVe6aQGgRBMUwSl/B4=;
 b=4CaWhxO8GzlS9Zb6OxajNxEzhwqEPjRWz5agQwTz7AAdCUzztZppMmN/1nifENjxDtwwitEyGz8AYib8IQPFgZazW5JCgF0FBOU/liy3n5kalO/v29S/uq1FvbIVXJc4dBDoI3vjxNrsUeUxPGEgpXE4/3RzjBA2+YiGYfGR3OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 08:54:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 08:54:06 +0000
Message-ID: <8f400002-5680-43df-9aac-e46236a7da45@amd.com>
Date: Tue, 16 Jun 2026 10:54:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx11: Signal USERQ_EOP EVENTFD
 notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612055226.2879270-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:408:f9::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a40a4d8-a13e-4aa0-4ddc-08decb84d29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: G0f095YBS64NMEKKwrepd/Fg2qD8ZB/DAO3+2z8OUI9yfmXhIR5+bDwYEXzTZk+2uM5RLeLtIIo4QWHjUl3xSkxZTNc3nb7aAuDmX2nHIpc+w3QWWG1r7eKN9QCALu4d64I6krdfBOpH6CeTUq6ld6HS3Wz2hlwXC0FY20covpdZF7nK5KmRuACPZkMYao+bJ1puYK5ABa1kbAx+LnX7WQESlAF8SjBOefC0AzbF5G7xSjfW8A4KiS0aIkMbBKDJAnL+SbtUaWs9JozvvwFRXnv/2ei3xZ2I4cysf3arQ/DJuhTIanS8ASe2DEoAA13SR9casDll0MqXJGIMbi+NBqc6MP3Fzgo5+vXdigAM58JTDj2JCzc+4s3v7hVBoaeoISIHoj7ASH6kwb1i3xVguoGqHaH5z1OYVuAuDw+LR6pGZLDQSuvQvUtvpsPOwDdTiUIhVOFSKEpKtJeD7V0r/LhgYK2ucHN3JtFW/9ujaa/X5UdcvC4VopGd4GsFAGSUvaCynTeqm9KAHJcWnGasTBsd/8S+9WJr1ET+WDaEROhID21FhuGP9LstmTrPY3XDst3aL+96qFBtZSLh/rX9s1at8I2IrT+5vjbNNsupcLRZ+mk6GPkx8Mqsa/HHKUgr/igHp2DehJRFZwimxnKvYcXJw4iF4LjEirx9IEpPO7SQY7si3zl5WxunXd7iwQsH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZEN081aEFSbUJzOVNMZHdjNjJ3TXMvVmJJK0ZMeC9sTk1aSTk2NHNKQmdU?=
 =?utf-8?B?Q21JTWhpbm1mb2FSZ1dTMlI4RXo5eTh4ZW9KblNkWnFaOWlOQk9TZFdLWHZ1?=
 =?utf-8?B?bTAyN2IvTUhUeHRNZ0ViTFVqZkYrdVFVVWRDcThYUTVjNXRjaWx0WXlUd2tu?=
 =?utf-8?B?bm1SakZZdzBSNEhkWGhQK1BYOUt1Q3BaYXBHOGZrUXRkOUF0ekpMZFErbGFC?=
 =?utf-8?B?aGtOaEUra1Fpa2w2bXVUU2lmME5JMEcwNHJGTU5JNWFhc1A1WGxUNkRyT21R?=
 =?utf-8?B?S2hmYUYxcjNqMFgzRG1KNWpvZTVFNnMvalRiV1dQZStCdGtVVHppVFFUaFgz?=
 =?utf-8?B?ZEhOOG40WXB5V1MrTXd5ODcrZktMOFh0ZmYyOThmN2FkWDB1ajJFNUpWWmVw?=
 =?utf-8?B?TWR3UWVvQUlkNU8vUVc0UGFrdGxFY0ZPZVRtQ0N1L05VVnBHcDRnTkxVdEdN?=
 =?utf-8?B?RUNZaHhqbkJneHFWaSs4K0NrdGRMK1hKaUtXUTVXTUt4b3VibGtPNWNrVVpp?=
 =?utf-8?B?MmI4KzFmZVhxUmkzaXVQdGsxTm1tYW9rS2J6b05GZk5LczlKZ0htdHdmMUVr?=
 =?utf-8?B?b3V2bUlDWUNPd3QyaWlmVTBNK3h6aVkwN2U4eWhwMnlZaXFqSXRyVEJJT3lq?=
 =?utf-8?B?a3dBZHVUR3l2Q2NnS09KMXEyNmc1VVphRXJSSDdXUFd5U1cycnNaRkgzMnkv?=
 =?utf-8?B?c0NIaGxxK1o1bUxXSFZSQ1d0NzBtZzVXY3RqT0RNWjkyMWo4ZTdyVXRJbnVv?=
 =?utf-8?B?UWdVclU3czZ0c0pPYThQMFY3eFZhbXFPM2cvK1lQWDQ0VmNyVVNqcWxCWFRQ?=
 =?utf-8?B?NVFQRmsyaTQwREJ3dEsydWJOV2FxUjdkNG5QSzBRdnBHclcvYlhOeXNxVkR5?=
 =?utf-8?B?eklNZ0FxQ2dUNXJhSy8raGljMTN5amV3SklnMytuQVZjS2Z4M3FEbEZRcFhm?=
 =?utf-8?B?QWk0RWpzbzE2aGd0bzFpbTNlUkFZa213ZHlaQW9yUjZGQm1UUjV2VS9EVUVU?=
 =?utf-8?B?V2F1d0E2d1JMdEZ5V01vU1VHeEFZTFgwQ0dJTkVsdkNCTW9vbUZNZ3BkN00r?=
 =?utf-8?B?U1B5SkdJUzdCM1RVZG9kenFLWnlkRWIvODhTTG1JVWt5eUJyalJEdnFwVnNG?=
 =?utf-8?B?cVpwQnVoZTQ3NGtWOTRtRTM3TythbEhPUzQyeTd3QVlCZFhNc0FmZk9FSFlT?=
 =?utf-8?B?QldNa3dWRER4ZllmeThPYTR4dlBxZTZuUmJrSVdmNnNuRXlsWlA0Z3YxMjJP?=
 =?utf-8?B?V1EzRWZuQlhkYkJxMklYVjl5eDF1TWhQdGQrQmJuQk51OWo4eDdmRVU0SnQy?=
 =?utf-8?B?T2R4ejdGbkhzVVpycllWcEhBNEFSZEZZQm9mOUFyR01hK0ZCaHJLVVZLTm5R?=
 =?utf-8?B?Z2E3dU55OTlZUTRTSWMxTU1xbHRMSW4ybTVoSHpLYXVBczBaMlF3OERWUkNj?=
 =?utf-8?B?a0s0VWxQcXA1VkhMWUxzeGt6RUNsYU93YkU2bEtUVTdJSk9CbGEzSVYycHIw?=
 =?utf-8?B?a3czZHpkc00xdkp3eXVBeWZsU2s3dXlVMTBLdzZBeHJGRUdtakpnM0MwYTF1?=
 =?utf-8?B?bkw1SnM2NEtCUTlrWkpLL2hPMEV5bFphbTBKcWRwZkJ0a0g4Sm44TVJWc3c1?=
 =?utf-8?B?NGRuODNoVkloai9NYVpEQytYVXFBYXFGTS83OGRrZWFpMmxVaDRqTjhhVHBG?=
 =?utf-8?B?TzZ4d3RZNHZ5SmI2V1hwM0ZqQ3R5cDdBakZlK1c1NjlzdjJhOG5qOVJUYmFt?=
 =?utf-8?B?WHRzR0hTa2xDNTVCUUIxTUR6M2pwZUg2UC9KbFB4ZUtiRkJBaTJ0bGJDdFlB?=
 =?utf-8?B?SWY2SHpPMzkzL0loSW5oMmxPeXR3VzJIb01rY205MWEyYmlrdHdFZ0tJTHVq?=
 =?utf-8?B?Vnh3ek00eTQ4UEQzZjI5YmZPL1NQSW9IQWg4ZkpRU2l0T1NNK0tVcW9iM0xV?=
 =?utf-8?B?RER3WmlZNmhrak1waGNHN1loTnlKZ3ZnbXZjYXdEMnVjdXJSV1E0cUozVC91?=
 =?utf-8?B?UzdvQUNNWFFhY2ZZOVBHTEh4RXJFUk9UNHFYR3RhMGpBR1NPZytGMEZmYjli?=
 =?utf-8?B?eFpkeStWNStmaHN0aUlWTjVBdlBuNlBaWDh3TWdPUGVGMzMxREZFb01jVUcw?=
 =?utf-8?B?YVJBcGRNelhVYW1hamVXU215RDVUQXZkM0U2UGc1Qm51ZzZVMjAzYmY4RGUx?=
 =?utf-8?B?SmF3Q256bXVFRGhpc3NFV21RdXZnSUl1YXFOendqYmRIVnR2eFpDeG40Y3ZP?=
 =?utf-8?B?Y0dyeWpsK1dDOGwycnA2czdnRnVObmY3aUxvUHhTZUs0cUJkL2x2SmNEK0pC?=
 =?utf-8?Q?YVUSUOW0lM0jM+b8PJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a40a4d8-a13e-4aa0-4ddc-08decb84d29b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 08:54:06.5594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8Lih80TrB3tB+mMePj0YrwtZs/g7rmZdgef+wHbZllf2UIUYOtRB4kHYrdU6ZBO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

On 6/12/26 07:52, Srinivasan Shanmugam wrote:
> Signal USERQ EOP EVENTFD subscriptions from the USERQ IRQ path.
> 
> The EOP interrupt already tells us which queue completed. Use that queue
> to wake up the matching EVENTFD subscribers.
> 
> This keeps EVENTFD routing based on the actual queue object instead of
> queue identifiers or doorbell offsets, avoiding issues with queue
> identifier reuse.
> 
> EVENTFD remains notification-only.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 1941bfbcbfbf..565447d7790b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6488,7 +6488,22 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
>  	DRM_DEBUG("IH: CP EOP\n");
>  
>  	if (adev->enable_mes && doorbell_offset) {
> +		struct amdgpu_usermode_queue *queue;
> +		struct amdgpu_eventfd_mgr *eventfd_mgr;
> +		struct xarray *xa = &adev->userq_doorbell_xa;
> +		unsigned long flags;
> +
>  		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
> +
> +		xa_lock_irqsave(xa, flags);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue) {
> +			eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
> +			amdgpu_eventfd_signal(eventfd_mgr,
> +					      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
> +					      queue);
> +		}
> +		xa_unlock_irqrestore(xa, flags);

Please put that into amdgpu_userq_process_fence_irq(), apart from that looks good to me.

Regards,
Christian.

>  	} else {
>  		me_id = (entry->ring_id & 0x0c) >> 2;
>  		pipe_id = (entry->ring_id & 0x03) >> 0;


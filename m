Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112C606A326
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 21:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VWLV7IEr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8842110F846;
	Tue, 27 Oct 2026 21:35:07 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012051.outbound.protection.outlook.com
 [40.107.200.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6143A10E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 21:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPFhXTkRHPAZMXVev+7d7u6bt80owzVL6Go4yRGdrifZBvD9tP7mmwFPFGlMfLSEJPYqnyPbEgx0AxCdFoI+fcicMgeG4VvaHauYk1ms5vZcqK0MKF0ukr6b48YxPq59wrgSkxYj+54+Uid7reVWYdlDQs4xo6fpIRpfT/PwFNWXHk1KW636O5RWjm1qEnAHzbWDRZRaFAPjEUhFyejIF0J66pD5jXhHSg3WZGtPzdC1SFuw+1J8ehW0nXaibZfWzDDEYmVaaDHzC9/CAXQ/7/REqdSp1X8Ktb1bW7p9IJ9ZIgP+p02ZPh3hcDEGeA6OLEnnvaNdW0c3LOfdPrp/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEj4gYspYtGCHsH2B8oaQi2VNmYEBi4gLa7WzVu+z5I=;
 b=HEKFKr0NY2E+qMUtM/owl3Ru2RnFST1q95PjVBTcuffU3zt4itqXfo1wHNghaNAQogG9LIEGIHSjslN+XrvmZtulMocIbu3UkTJMRNEaxgj+0d49KiVs78MRMPbjDLeSvcogMGkoJ2AUEdCqtsWnF4KlSy1Tab2S3GyOlum3H2oLa+A3QCLRBu0QuXvWFFSolJ/HHj8J1TN8Mif53pxmY2aRdWf4aCn6OVPaNaDKlxvQxWlSCYH/QJ3/6WqruU/2cCSkjlhYs1LffgsL0b2kM3XiEFT9dYQjV+4Vh5eLFDQSYa8nOxjMp5e4ecW5Hlkk+AvtkSiWtMfKzYqdeHh/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEj4gYspYtGCHsH2B8oaQi2VNmYEBi4gLa7WzVu+z5I=;
 b=VWLV7IEruepNkjYlMVDdv4xjBVy+JSU4Bw2SAa44OudJEABBiB9wisEZEGLGeTdAvXBuS9MOBBZvgR3kbMIU4VJIP119RVi7KsxSHws8Un2HMud2jGvzsXdTMEUKwnIsFEmjXrIdLTKdcTU2/4O2y077nakpdEupDz410fFl8Do=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA4PR12MB604997.namprd12.prod.outlook.com
 (2603:10b6:207:12a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:34:58 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:34:58 +0000
Message-ID: <c2d7e6ca-f0d3-450a-a601-f2e845ef0671@amd.com>
Date: Tue, 27 Oct 2026 17:34:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/8] drm/amdgpu: Emulate exporter->importer UALink
 messages in loopback
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-4-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261027195913.1794477-4-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::11) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA4PR12MB604997:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c21898-64f9-4f23-451d-08df3472266d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|18002099003|22082099003|261026121527099003|11063799006|56012099006|4143699003|261021121427099003|10067099003|261021123027099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: KQlZ3ov0wsurYZsAHkvQvqmklo9FHl7LFT4BvRekzv05if5Aa9cDxSU6MVrqwmlJ2oky0GHnYjVYTRGYKGJRGScQY+3iTv9LGzCfMDFqmrEEkAn3UAQQ/LUy64O3nhQ1Ai8DsxmudeBfFbfKm6gx76Y25npIdAQcC/stIMNXisTSgTLpb0oIVYEEQdfWUUcCrLfsUbTVITEfLzii9o+xA8gPoqya43xZY+EQzeaoEy96OipKkF55WY+qUjXxPbwU5k/5Fa6R4uSLx8loLppnotQTbpsWjhCI2XRH6EzScrFQKnVLupR5keEmLgyvJXH4pfk4uGFq5I/XsvJiykHMmbhWtT7od5pUS7/YWxTYlFjbfJv/Z/1GaJUhPm5W2WYhxiZmG/Lj06WYYWKl2NLpq+RtS6TXnXhrr74TVVC5kJFD5ikk8ADre0dNF+6CiSBoSOBMW2Av4+VDdze7NZKY2oLwR14usL4YVVmp0c8FW6lalksybeZPBzasRbms6+K65c3ayEe2M/MXMRsDk5SLxOnSB7HFqpj4WFoPz4jUkFZJLtOaSW8S/6xMM+wFeUi5LuYwhj9hzB/K1Ib6bna4e9IzH++qKBUZGnVhTAGTixTZ1NyeDMI1Tp5WYcxhBGOl3K7+3/j20YTW7X69AmmADmu92VV8wIm3ryh/6H/a1lE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(261026121527099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2hBblpSRE9GaENPTzk0ZmhZaTBUL0pNUkU4WUNMazY3RnRDMTZMd01scGkw?=
 =?utf-8?B?NkdRaW9FNFFoWGpEMVliOVBnaENoeUZ3ckdXWDNHQUlqdmp4R0dMOEVUek15?=
 =?utf-8?B?YmdVVEo0Y0kzSE9OSUJUY0pScGEyMjM5MDFoQjRibU1iMS9RWTNHdGRxNHV2?=
 =?utf-8?B?SHVsUzd4ekYybU13NktLOS8yWDkxalk4bG5NZnlPM1ZXbjlVTXpCRlg0VEQz?=
 =?utf-8?B?aE9UWDJRQllGZHNUTURoYVFlaHJnSHErc202M0x2V1NIVUpieGxtRFhqek1W?=
 =?utf-8?B?dVR5MTBsRVkxYnovdWhxcGsyU0M3MFMwOUFsdVZFNkRTTUxFS1BkZFExNU8w?=
 =?utf-8?B?UmRidi9UZm5jQ2N6M3hHdEZrSElNZzU3cFRNUTdJRFZ3Z2NsbldXd2kvSUdo?=
 =?utf-8?B?RCtRRlpCcFJFd3hVVmtydUJIUFZoYTNPWVlNNkg5N1BJMzZUU1BvUDdpK2tz?=
 =?utf-8?B?WkNhNWpFc2RXYm9lNXJocDlPYTc2Mm1XWk9IS05udEZIak9PWUxQQWJhcXpV?=
 =?utf-8?B?ZGp6UDlDWUhXanM3Ry92YUkvRkZ1eUVGRDJTelVRWEozMEw3YXlZanhsczlR?=
 =?utf-8?B?ckxpRHZDZmpvb2RFc2pFQTJCb3VhK1BQRjVkVTh6dVBTeEpTSzRISWhLTWdB?=
 =?utf-8?B?Qnpzc2llbkRvNjVOR3BENzlLOVhGMHhLaEVlUVBMQTlGdVNhd3p0UjJxRGs5?=
 =?utf-8?B?dlhDY0lXTDVjdDJOK2JwWTcrc29OWVJsV1pFcE5tZjE1cmhqUHhhTzF6L1RP?=
 =?utf-8?B?ZjJMWm5NdjdtQ0JJTEtRM3p6dWJNZ1hSL0FnQ0NUY1BKR1FzYkF6NnFQTkFC?=
 =?utf-8?B?QWhHQXJMUlRWbEdMK1ltZThYSVBOOTFVdk5nNWpObUh6ZkJqS2d4RG1LQXV0?=
 =?utf-8?B?WHZML1VpNlNzdzU2czBlSE9pVmNWM25aU3hnR2NUYm1jT2kwQ3lPT0VVNkl6?=
 =?utf-8?B?U1QwV0VadkVUTVRCVmxlZUVSVVRIckZkeEZzeWF3NDVIL2R0OXEyaHI2UjRm?=
 =?utf-8?B?TXl5MGFlYm1lVTlGRGJ5THBSaVJiVDBoZndLWUl1akI3RmRBa0d5d2R1YXBR?=
 =?utf-8?B?Q0tMdUVqbnRrUkJmUFNNZm9vakNOKytyQWhQWVVhRWt2ZTB5WVpMbGZzWnZO?=
 =?utf-8?B?dVZYeStsb3JnMWt0L2Zlc0cwUVpXejdWNlVhNXpuT0xXTFBBOUFOWUMrTkx2?=
 =?utf-8?B?dmo0dHRMM3VOanNraXg0ZmZETkF5K1diaHE0MVFSaXdpL2YyNVlSOVFOR0kx?=
 =?utf-8?B?RGp5ZDIwWitUWWRNdWtqbzUvU1VaWmZSRE5ZN0NxWFdGTjRpZlVuaDlwbVkx?=
 =?utf-8?B?dkkvRkJYcXVDemNqL0d0ZEw0RTFxUTh6dVB0M0lSajJvWkZUTUdNSFFzVnJl?=
 =?utf-8?B?cklBME4xRFdpb253RnI1Q3loSlZKbUFvTlI4bFB3OFhQMVF1SnlibGc0Ym5l?=
 =?utf-8?B?T0xwWERqbElMTDlMSWF6Sm16cjVLN3hQNmFYdHErWlJFRjJOMmd6dkwrYXh2?=
 =?utf-8?B?V0hyd2hFSVBxVTVpNCtGeUsrU040SThzSFZpV0Z5cUphN3lTSEYzTDJsOTZ0?=
 =?utf-8?B?WVc2OUJuNnpSYlc2dm1MS0pJbDlINStpVkg0Vml0ai9ZMFFHZ2h5UGJwSStX?=
 =?utf-8?B?YkViVHNINlZkYUZuZHpCdUQ1WjNBMHNUVTlBOUpNcWpqT3hxNTFIN3JLa3Zl?=
 =?utf-8?B?U3BQTDNCbzg0Q1dMaEtKSUZqTzEzOFhoK0x2WkJaTXZlRndmcXMxeWZEV2o0?=
 =?utf-8?B?VE4ySS94UytGM05nZG0zT2dURER4VEdjZVUvLzJtOFp1NWlsU3lBS1ByMWRC?=
 =?utf-8?B?T3hSVC9BMjVqODdmZDUzWkZCRlYwZ0xJdHZOMGsvTm1ZaGd4WmJUNHZ4Z3lM?=
 =?utf-8?B?S3J4d0orcFVDTXVxQk5YeThhdkpQdnk1dDdWUHl1NmZlK0ZJeWYzTitQdTFO?=
 =?utf-8?B?S1ZweVlMaTdwN2FlL244NnNJZ0Y3YVdqRTk3Vmw1Y21hdExhMGtjVjhvRHlm?=
 =?utf-8?B?YW1naFBaOXd3amkrYzVmdlpLR2YxdC9iUUwrZDFhQ0lkNUZKNzg0RGhzaUpQ?=
 =?utf-8?B?V0Z0REtSRG96eUZGc25zbThIOXlsYTBkbzdQQ2R5enVGWEhLbVpRcDBNZmkv?=
 =?utf-8?B?Q1N0UWloSE5zdi90TXNwc3BUV2lOQzR1bmZPVGlNNFFwWmRnV3ltUCtTTVl4?=
 =?utf-8?B?YmNzYTEzQ0p0dUFvYXZSMVZpR0szZFovSEV0Y3B6Mm9TZVJzbVcvVVB2RStt?=
 =?utf-8?B?MnQ5a1ZEM0VtVGtZNkV6bURNTTM2OXFxZjNtbS9meEp4NlBwNjBzZmVYd1l1?=
 =?utf-8?B?UFAwdllPckpEZWQ2aHRMalp3L0UydXNad1IwYmQ0K2ttbWpoRGpvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c21898-64f9-4f23-451d-08df3472266d
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:34:58.6674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWIz70vKk7TZUfV513fnJLGFiZnH7uxy9OnLUHSU8306RcR24nsWwA803Vvvr3QJRXaSOlfo/wxT9zeKP7+MPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB604997
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

On 2026-10-27 15:54, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter and the
> importer. The exporter is the one physical station, so the only path
> the HW serves is importer -> exporter. A message the exporter sends to
> the importer cannot be delivered by the MP nHT.
>
> Emulate that direction in SW: when loopback is enabled and a remote
> interrupt is addressed to the importer, queue it on the loopback
> ordered workqueue, which feeds it back into amdgpu_ualink_process_irq()
> as if the exporter had sent it. The ordered workqueue keeps successive
> messages in order and runs the (possibly sleeping) handlers outside
> the sender's context.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - Use wrapper functions in amdgpu_ualink_remote_interrupt() (Lijo).
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index a186859dee3c..6c70be7badec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -60,6 +60,9 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
>   					   u32 remote_accel_id);
>   static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   					  u32 remote_accel_id);
> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
> +						 u32 sender_accel_id, u32 dw0,
> +						 u32 dw1, u32 dw2, u32 dw3);
>   
>   #define STRIP_NPA(addr)						\
>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
> @@ -6209,6 +6212,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>   	struct amdgpu_ualink_ring *ring;
>   	int r;
>   
> +	/* UALink loopback: the single MP nHT can only deliver messages addressed
> +	 * to the exporter accelerator. Messages addressed to the importer
> +	 * (exporter->importer direction) cannot be delivered by HW, so emulate
> +	 * them by feeding the message back into our own IRQ handler.
> +	 */
> +	if (adev->ualink.loopback.enabled &&
> +	    remote_accel_id == ualink_imp_accel_id(adev))
> +		return amdgpu_ualink_loopback_self_interrupt(adev,
> +				ualink_exp_accel_id(adev),
> +				dw0, dw1, dw2, dw3);
> +
>   	peer = &remote->peer[remote_accel_id];
>   	ring = &peer->interrupt;
>   
> @@ -6630,6 +6644,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
>   	return handled;
>   }
>   
> +/* Work item used to emulate an exporter->importer UALink interrupt in
> + * loopback mode (see amdgpu_ualink_loopback_self_interrupt()).
> + */
> +struct amdgpu_ualink_self_irq_work {
> +	struct work_struct work;
> +	struct amdgpu_device *adev;
> +	u32 sender_accel_id;
> +	u32 dw[4];
> +};
> +
> +static void amdgpu_ualink_self_irq_worker(struct work_struct *w)
> +{
> +	struct amdgpu_ualink_self_irq_work *job =
> +		container_of(w, struct amdgpu_ualink_self_irq_work, work);
> +	struct amdgpu_device *adev = job->adev;
> +	struct amdgpu_iv_entry entry = { };
> +
> +	/* Build an IH entry as if the message had been delivered by the MP nHT
> +	 * from the exporter accelerator. amdgpu_ualink_process_irq() consumes
> +	 * the sender accel_id from entry->pasid and the four context dwords
> +	 * from entry->src_data[]. entry->ih must differ from adev->irq.ih so
> +	 * the message is processed here instead of being delegated to the
> +	 * UALink soft ring.
> +	 */
> +	entry.ih = NULL;
> +	entry.pasid = job->sender_accel_id;
> +	entry.src_data[0] = job->dw[0];
> +	entry.src_data[1] = job->dw[1];
> +	entry.src_data[2] = job->dw[2];
> +	entry.src_data[3] = job->dw[3];
> +
> +	amdgpu_ualink_process_irq(adev, &adev->ualink.irq, &entry);
> +	kfree(job);
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_self_interrupt - deliver a UALink message to ourselves
> + *
> + * Used in loopback mode for the exporter->importer direction, where there is
> + * no HW path. The message is processed asynchronously on an ordered workqueue
> + * so ordering between successive messages is preserved and the (potentially
> + * sleeping) message handlers do not run from the caller's context.
> + */
> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
> +						 u32 sender_accel_id, u32 dw0,
> +						 u32 dw1, u32 dw2, u32 dw3)
> +{
> +	struct amdgpu_ualink_self_irq_work *job;
> +
> +	if (!adev->ualink.loopback.wq)
> +		return -ENODEV;
> +
> +	job = kzalloc(sizeof(*job), GFP_KERNEL);

Using a fixed size FIFO would be more efficient than dynamically 
allocating and freeing every job. That made me think, could we just 
create an IH cookie and inject it into the normal IH soft ring with 
amdgpu_irq_delegate?

Regards,
   Felix


> +	if (!job)
> +		return -ENOMEM;
> +
> +	job->adev = adev;
> +	job->sender_accel_id = sender_accel_id;
> +	job->dw[0] = dw0;
> +	job->dw[1] = dw1;
> +	job->dw[2] = dw2;
> +	job->dw[3] = dw3;
> +	INIT_WORK(&job->work, amdgpu_ualink_self_irq_worker);
> +	queue_work(adev->ualink.loopback.wq, &job->work);
> +
> +	return 0;
> +}
> +
>   static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
>   					struct amdgpu_irq_src *source,
>   					u32 type,

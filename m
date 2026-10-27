Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF31606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SGOHgomy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A17310E0B0;
	Tue, 27 Oct 2026 06:25:57 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5EAF10E0B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 06:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I82b2mZl3RcBoIeCfWMR8DW55gYvDn/xnaruuvAk7rqvFQn2SP/NBpsnYVnHSL5GBQnKW7CPfz2XdqZJ93bjUfNXdwzj/5BmU8PuLUTcdu3XJvxcdUbAmjyWihzYBCnCxShn29bSu03/ZdD21DN6XkfFDUWFSo9a22qi3yHezn7kjGA/Vc4blTq+/HUniGgfi6bj2o4XdAEdoNo6GapVel57ssiCB7RupHKF+DkIb0b3DfvCAdCuXIYtyNtJalQEHU4DhxgK3Fm+IXNyIT72K80xui+lUvdM6RD4NMexFkt9MBbEmMgt7eU24zAGUrDiXim5GY4XppFnt+lMjLbShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSnw1gb0Q3uCyUrY2SUMZuxM9wlqlgABiqRr7wZaLac=;
 b=CBdXQPe41ZHcWfDOJDC7foAeGdLBaU2PQfcv4EAuhQMrjeu84GO0QTo9Z/E2sTdO9lE0ZC/iD4MxtB9dljqTAcABfh09WG+qp2CGfDyQARQhUUOdyAw5wovRjwrrINFfiKzxqFO3ynra2NgtC0j3rNYS2SVbD/Zz5YPwaCTBR1ffUblc1IyZ7sNSxo+oZsqc2e3YObZK7C1YbfyH8Au4gbEXtDv0GcioKWTvRbpvF+id8S6yQIe3vSsRLdLwUQvwk5ygdhRA7NGZsOkuvA/jAjc+OcGtkAXINEgHXjA8bpgSDtM1vaI08cCHBkx6b8iOl10N2/wm/KWyTqXD3/tBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSnw1gb0Q3uCyUrY2SUMZuxM9wlqlgABiqRr7wZaLac=;
 b=SGOHgomyBbuuAQCka7QniuIIwAztf7iC/oYwuGfQZ8i+rzyzbqeRCpisP28pdfeM5k6ttfUZL2Ng/xvxhT8zPwBrmwOkB3j4D5SRF2i9RYxL6hZbFAD8rgW4nFFigMpuUCi6vs3qMF04e1uHmkoYnCx9+jhKspMfFYFUM/lbHfE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH2PR12MB9495.namprd12.prod.outlook.com (2603:10b6:610:27d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:25:47 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:25:47 +0000
Message-ID: <3b55caea-6908-406e-ae91-33e3b7814ed3@amd.com>
Date: Tue, 27 Oct 2026 11:55:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amdgpu: Emulate exporter->importer UALink
 messages in loopback
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
 <20261026230248.1597606-4-mukul.joshi@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261026230248.1597606-4-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH2PR12MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f07f883-c1b8-4a8e-5282-08df33f32341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: u7KHEecUs1OSY/spyrd0eQdH4YiXQp6p2SHn3pc1XcEdAXYW8zjuDgdp3Mv/oHk2QdWG29on4FWhkDZT1DoW9lG3l+TpEMCmDg/iX1rJWl5ocbF2P+Qsq5aYiTiEBVHnXusvT0dIcGsTQCWIqXJTASP+u9dTE/8cL+WtOx6BEeQiHXQW8f8SXHmtWV1TYjijSBa1IqM699Q1qv42yxUHZ7UBn6WCfI35RlCvWd6TEmlkgJKa0k28NCGJQfP+FoFU78MXYkRoAGPtLRx9lPsN60ayCUTULGq5w3vfbRop7u4TZ4gfhS4Iu5E750vP1oZ0E3hayT7hGeUJoQSNjYrmkCT3mLtXTSN3FHeq0YRzsBoSE80V8MmbhzfdsQmITnRu8bYtsRYTQ79wx7pEbluFUAbKZ/bWegNFIGY1TAg5uwzjk63TzCrxgKhRe1OxHqVGavkG2ruT0i9KLprEwbqpDMjxWIv0r+Uj3FXyoTx7P2fkxLueNDZr/3DsMvtwTTijmZg25zZZXNgr+MeiG9APN5ELeJUZXhUowRyLruTswWZGRQ3/fyasAU1bNw72KhszKpxUXiHt18eKWkhqg1S2q8f4jTd5hYm6eSBhSVT3ZDExCJxKIm4Obj2uTNp2orlDM3BV8kFQvsY7yp0kqjQaJ+27vpKjNF0C9M0J2Biy+ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUhMZUdsZ2hTRGg0aHVzQU55TDNpekh0S0xhZ00xRGJrNkJobUdhMURPSXVw?=
 =?utf-8?B?T01XSWQ2SG9ZWEM2b0hNbFNkYnNRbExWU3NxVUEzQ2hQdDJRR29oeFR3UitY?=
 =?utf-8?B?RmczcWxBNGQwZk0yL2FCSm1Da0lGOTZENC85MHYvR01SeElHNWhKZFJpaXZS?=
 =?utf-8?B?OUdkV0lmU0hsSDdCSG0zOGNCS1lZM0doRGxDY1QxYlgrWDluZThVV2ZScGFq?=
 =?utf-8?B?Yk5CMWVGVTBRaTBUcXB1djBTREN2cFVsb1c1cm9hTkZ6MURMT0RCcCtaQ1F4?=
 =?utf-8?B?SjFEVFM2MnNCMnduUlhwbjJuRXFOVGlqeldraWQ2by9GZjZEOEZueWM2UzBM?=
 =?utf-8?B?RFJhelI2alZXd2lyQUlOcUJYdndZNkNoQmtZbzY2Q0hEcGd2SjMvcWlhTE4y?=
 =?utf-8?B?MGowNVllM3l2S2Vnb2hKRW9UVXhaSm1Bb2RMaUh4ZGhKZXpMalVIL29kek8r?=
 =?utf-8?B?elRPMXB1dXU1c0ZjeWVoQ3RvMmVKcGpzaXl6ZXZSY2FhOVBwVThjaHJWZ0p3?=
 =?utf-8?B?MWRlRkQvSlpIMlF3UzlvcFJEME93WUFIMzMveHQyajF4Tkp3ZWJQbmRxU3Fl?=
 =?utf-8?B?dTZSQjkrN2NycFZqeGgzUFJXNUgxZWM3QklEbEJpNXZrc2RxazRMRWJ3Nklj?=
 =?utf-8?B?Nll3TE9MTWVEUTVjMjkzdktFSWhhODM5N0pLa1NyamxDVGpZZEYzbzJRd3NR?=
 =?utf-8?B?Zjc0c3prbXltdFpqS01lblNQdWNuRE55b25xemJRbFUxaDJOWjZUZjR0UDZh?=
 =?utf-8?B?aDcwK210L0lQcWErQzRiNkdiYlBoS3BzZTJ3VGFGRktVeDU3MmZXQytraDNu?=
 =?utf-8?B?V3l3YVlpM1F5UFJFa3FKZUduSzJuR1hQeWVqdUY1dUpSVWREaXFidEtJZnZI?=
 =?utf-8?B?bWpHMTEvaU14QUQvRVhKQUNLcFpFdTZwRENoQit0MnF1cHY4UjhYc2VaYnk3?=
 =?utf-8?B?TmVsekhTd3ArL0doZlRRekdYS2VrRWNXdlZHZ3J6TGt5WUdHVm9zRFBPQTh1?=
 =?utf-8?B?OXhrNHhCbkNjdzBUbUdLUFFMTWdESytHV3RqN3gxZjBEb290cm40ckxEN2ov?=
 =?utf-8?B?L2VGSlZhNkZnditVYVZwN2hXZHIyRWtrS1A2SHNLVXR6aldwSktYMGZVQlZ2?=
 =?utf-8?B?VnpSM0FGT2x3MkJzRW5ObmRtYWxXOEJjY0F3bVoyVGx3UE1QdVgvSmRHa3J5?=
 =?utf-8?B?dnQ2TTJLRFQ3ZGNHV1hHd05VUUd1aktkZmpSWjM1WHZMNU9mQkNtWGhZd0U3?=
 =?utf-8?B?YmtGdzBnZk5wbGRWb0pLWXRjK01YY1NnVVNGa1lyM1kwdWNvelNmWFYxT0RB?=
 =?utf-8?B?cXFrbXhiaGhKV1dUOHVORmt0bmwvL2dhYWU5aTRuUDhuYXlSeitCL0FOcUgr?=
 =?utf-8?B?Nk5XMHpFSWZLZlcrYzdNMlNiam9USUlHSFRyVGF4em44Y3BlM0JLd1p3SzhU?=
 =?utf-8?B?RGRkSnU2Y2RYMU53YTUwbU9kUVlmMGVoaVMrQXRhT2kzdnhlVVVaMkg1eWVz?=
 =?utf-8?B?dVpkZHFzWUxka0xtMnViRTh4ckdkYWdFWEpaRXlRL3FKSGRiU09SZm5rcXU4?=
 =?utf-8?B?dmdiR0hGTUhHNXB5STZVK2VGcHdJTmlCVjQ1ODg5K3JHOGdod2JibWJpQVN0?=
 =?utf-8?B?eFpJTUZnL0NHUlJsazYxdEpyWkhIVlJiTThrcGhGMGZEcEUrOHpjMzZ3aFV2?=
 =?utf-8?B?MXBQM3pOYmU3SUlzYnA1dFhLK0F2dDVmRFczQWl0Qm1Jc1JrS0xobSsvc0FW?=
 =?utf-8?B?dzdnSEp3L0VSVjdXR0ZpMWFkVG5yZ0dSWEkzK1ZScmxlRUdnRk0yeWUrV0Ez?=
 =?utf-8?B?SEdkSFJZNXNaSkkxQ1FXU1c1T0R2OXZQM2dmSmRCRlVtSE9lakhoY004dG1Z?=
 =?utf-8?B?c2h4cTdOcXU1QUhRdVlNU29pMS9EcjFUZk8vd3NpZnNubExEaFFucVVnZm1z?=
 =?utf-8?B?MWMzdG5JWGoyemRaeXJPdGQzN09xc1ZaWlV4bVNpZEpPdTdTS25lOTFCZWpX?=
 =?utf-8?B?d3FYS0tWenpKZTNuZmxnZ1hDb2VIMFpHV01yNENSTEY4eVJuVVRzUDN4a0ly?=
 =?utf-8?B?T3JlcEt4aUNhcWdxbW16UkM2M1dOMys0dlFJNFNnRkpodDJGdWhwbDhjNVFw?=
 =?utf-8?B?a1pjdzNycFpYanJFN1JjRWFBZVVKQUhmcTY3NUZIbXZtekJSN3RlU0k5cE8x?=
 =?utf-8?B?RERZOW40Z3VNLzJzMVNWMWN1NERaYm51T1NpQjVCZTFCZVNsWTZyVlZ3d092?=
 =?utf-8?B?Q2t6L0hkQW50a0IrODlKUWNxZkQ1QnRpdTNUeXhReFlpMGpabnQ1cFpiT29D?=
 =?utf-8?Q?k0+r38YDFZRGPZWTFD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f07f883-c1b8-4a8e-5282-08df33f32341
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:25:47.4549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTNUOWl8EAe7gDer5rosvBHGJ0Gy3FZ57iccQwCMZoUC6Vc5podJJVCrjd8TtqS5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9495
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 64a051242367..e40433bd79df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -59,6 +59,9 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
>   					   u32 remote_accel_id);
>   static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   					  u32 remote_accel_id);
> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
> +						 u32 sender_accel_id, u32 dw0,
> +						 u32 dw1, u32 dw2, u32 dw3);
>   
>   #define STRIP_NPA(addr)						\
>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
> @@ -6218,6 +6221,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>   	struct amdgpu_ualink_ring *ring;
>   	int r;
>   
> +	/* UALink loopback: the single MP nHT can only deliver messages addressed
> +	 * to the exporter accelerator. Messages addressed to the importer
> +	 * (exporter->importer direction) cannot be delivered by HW, so emulate
> +	 * them by feeding the message back into our own IRQ handler.
> +	 */
> +	if (adev->ualink.loopback.enabled &&
> +	    remote_accel_id == adev->ualink.loopback.importer_accel_id)
> +		return amdgpu_ualink_loopback_self_interrupt(adev,
> +				adev->ualink.loopback.exporter_accel_id,

<nit> Wrapper functions in patch 1 may be used here.

Thanks,
Lijo

> +				dw0, dw1, dw2, dw3);
> +
>   	peer = &remote->peer[remote_accel_id];
>   	ring = &peer->interrupt;
>   
> @@ -6639,6 +6653,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
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


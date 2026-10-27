Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B7606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=o7tABB8Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1D310F7C6;
	Tue, 27 Oct 2026 20:13:58 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012069.outbound.protection.outlook.com
 [40.93.195.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E975D10E2BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 20:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8N+0Dqyk9rIwmIn0GtlhYBHSTPzENGqQao97o6gC4PRDaN8zkf7SR33Zo4/w+ACbY/BpGNomyZqRwNVQBkDSqOFj1tYlJl2Q0qXqLkm86rT/+0emhRfY0SlmVEjMAwWYUJJ07HmRrTrCnAD7oYLb196EfYRdT8iXBrcygfvoXloBHtBZB7xi53mpjNce9pqB6x705RzPp3FGhMkI4OSQa1YQVI3pJegFa3nz+KE0kFXpMhOmOUaj7SCp1X/t/wON9WYWYSamAydF8HvjHR5oACPpp2vaHE0okBV99Ig4TyfsVZQ+MNzJ8xObuaZyqVhVtG8cnTBbDXjrBTo8+K4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmyRs0YpiPYdFD+ITCcyetmGKuX1yPb0pFnFt8LkTGk=;
 b=LZmxlIT1ue6kzfxHHThnmMU0d4GMWIVl5HpazGTGTZY1/bs/gbJGMRjlHqvoymEcfNsK3n1KkYJJITO+ZSogsiHorNNTINtnLkHIhJxdNYzg9Quq2BxTLEbRDBxxk+sj0DwbWCl9oRykhlSFOXM7ZZzW1XT+VRJBplwJ6LOO79PONl4d4x9kIzw9CKSE4yHNuXFCT27trXWYDGZ8YrL8Sz6onqM5crRcN0Ao+Khu2UVCc5gdZdcvMR63wrthEkcakYsfgOpNv2mi18/uUqQvQn/5ABRJ9G75XppDQwA+MQWL8hbAdXqck+jxxhtQN8UztyUgnnLvRS4U7RdKcM5XPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmyRs0YpiPYdFD+ITCcyetmGKuX1yPb0pFnFt8LkTGk=;
 b=o7tABB8YAAVl7SvVUb9d6MdcUYcmTTuv+EzxpvKHFzgYTuI86IC8omygglxOuPZNPQS2qp7onFOatw9hpn1GQv8RrISQoupdXOtUYSS2X9ESv9xTUm2daRf8//R/0De3jy07OZ0u32aEcET/HtlZBOKeTTEiWnE2n9R/qIZ1bLo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 by AT6PR12MB026081.namprd12.prod.outlook.com (2603:10b6:170:113::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:13:49 +0000
Received: from DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0]) by DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:13:49 +0000
Content-Type: multipart/alternative;
 boundary="------------hh9i0BaWoi800ykJ9AfRj9CB"
Message-ID: <6e638917-5e7f-4d3f-8a17-d8d5f57a2581@amd.com>
Date: Tue, 27 Oct 2026 16:13:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] drm/amdgpu/userq: wait for GPU reset before mapping
 or unmapping queues
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Lijo.Lazar@amd.com,
 Vitaly.Prosyak@amd.com
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-6-Prike.Liang@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20261023083422.3049246-6-Prike.Liang@amd.com>
X-ClientProxiedBy: YT4PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::29) To DSVPR12MB449095.namprd12.prod.outlook.com
 (2603:10b6:8:4fe::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB449095:EE_|AT6PR12MB026081:EE_
X-MS-Office365-Filtering-Correlation-Id: 7816bc7a-165d-4331-8f1a-08df3466cfdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261021123027099003|261021135927099003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|8096899003|22082099003|18002099003|4143699003|5023799004|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: FjGsCebrSnTZ9wsDvxu99C5mwK9ScoDqWyqXitjS9eX7z9iX0ug95pSoODX+4kMHhTK9vPABjlnydMrvCxPI18KCoOCleTbVHLpYnlEExpHb3/VFGH3tEyRgXKHzWR5iF3RPurLmwPG1flQSvE+uGynHDevF/pm6aacLsn3Wciw8SnkF9uXkv62PyBckYyBOra0Y/wSELpOEi1x7iRjw8kkH1PhjRuDZu21m3wQvDmF+PwnGEQRKSnlkOa+FF4UB9RJTjY7T/vnIjP4Mu/Hs93uYUAXa1BwhD1AlChSV4yMA6gyhoKSCADgt8W0coFHsdFLvchUT39NG7dKdEGNp0Y72i33+qe0N2lMIL+1/EnIAA1BOg59IdvAZRaT+Hbu6N9cShX0p5J+CaefJOeWOCbsGWHGrPPx987O60YXMHAOG39mxJAYLgBWbeEfmfxsimMMAM3hM90oFajkS5aPuygTfsz7OOuQxLHGEhnVAFhB2/Oo2py0QaCWAV/68b52M2wla1zDmpe6lPUJMsned35fbVvICtWGJO8gEAxRdVK1Qr52Mzloa2BHVyVSMF4OCh22MVa5O1mU+q5F6Z+c1thqQzvaOoeCzIDSMMn/Aq9HIwu/NpZBt0YmuKSgosYuOR7rVvJ3Gt/l489Qhf/IOZaTdzCDzoXvQnJgIJ2qq/Iw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB449095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021123027099003)(261021135927099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(8096899003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW9rYmluUVJHMDVGazRvOHhRbE1rL1k3WjBJMVdjbVFKMVlobG9BT0JRVXB6?=
 =?utf-8?B?enlLcVBkVkxTR3d1bTRJOW5GYk9JeGYrYXpJUlFqME4vSmZvdXlYVU5ZcFhU?=
 =?utf-8?B?Ynl3VFNpYjBIdlVWdWtsaDFJdEZEc2dBZGNaQ3lpN09CZE1paXphWGZReStO?=
 =?utf-8?B?dFI5aGVxUEZMMzE4VWh0VWtwanJMdjltYUJMdmQyOU5pWG52Mnl1bnZ3VUdh?=
 =?utf-8?B?L0sxdmxSUXN3NFhBbjQ0bEJOVWdYRU91dnU3L1gzTXppMVZWVUxPQXBLS2tQ?=
 =?utf-8?B?dkdkVEU4WU1KNkhlSDdKMTBUS0lPY2JCaC9hdmg1ZnN4QjlnczRtK2UzMEdo?=
 =?utf-8?B?WkFRMUJmbTJ0OTN4N3pWQjBQTXgzSjA0dnBTN2UwY1JOYXQ5cnIwd1U1blF2?=
 =?utf-8?B?RjM4ZkhlVzdoc0JOeWo5WEpYYlVIYWh6YW1YOGphTU1Qd1dkcWVENzBpamVR?=
 =?utf-8?B?alVpYlR1RjFlaVo1ZTlGeUxqNlhldWJWR2syeXFraFhMZnkxWGdOOThaT2k1?=
 =?utf-8?B?c2I0Z3BuVjkvSDB3R3hCVUdKWWl2Z3V5QUozdzZXVVJsVGp5bUdvRi9XWTJE?=
 =?utf-8?B?dmdlOGZNbk82SmU0OWdKSTFCcVdZamU0Z1o3eXVlR0Y3TUcxbUFleURHVmxu?=
 =?utf-8?B?dmcxTjQ0dklVVmpWemQzUWpyUGJkdnBiVktORGlsYkNzODlKSURnOVN4K3lF?=
 =?utf-8?B?Zm5lWkpYTmhiSFFkdVJ0TEc1a3RjVEVFWHRMbThPNjRUN1U0Ui9jUldnRWRo?=
 =?utf-8?B?dHF4YTh4cGtIbFp3VisxNmxDcnkwOGlmNEEwVnp2WnMwZDF3V3IrdmZ4eWJT?=
 =?utf-8?B?OGJhVEM1Zk9MZHlWRGR3NWYrNXlDQ1NHRHM2TEp5UWxqb2ZCc2Z0S3B0NVRh?=
 =?utf-8?B?ai9ZTU9pV0FCOTN0RmRGcWJEVVhvNE04NkpESEhmRmg3bnJKWGRLVUZBMnpF?=
 =?utf-8?B?OVFOeDhvcXdOTyt6ZTVZSldWamxEdDgzREJnNTRqZDlhd0QrUkJFdDJ6TVRw?=
 =?utf-8?B?S3BlMTh2a1RHbTAzZVRuMW5vQWU5SmJBcngveU12Y21kbXlUdi96SlZ4ZDh2?=
 =?utf-8?B?L0ZtQ1VNMkI2MmllWFU3K3hEQ1JKTEQrek9vS2FQcHNvTUVONUZJdzBPelFs?=
 =?utf-8?B?bGowY0dYblFTRlFlZmEzZ0xjWE9PaGR5dzYxd2xGR01OZGFOQTlrL3pOekJw?=
 =?utf-8?B?NzR4eVVGb0lOK1NwYTZ3UXRnY0hXbURDdDFFV3VjanU3SlhxTjBMM2RLMXJ6?=
 =?utf-8?B?eTc1UmlTOWdwMENXK3JHRk4wNk1BZkozdXBSVnV0eEI1NWlldXdjZExpanlK?=
 =?utf-8?B?WG9OY3dTZWorUHlrbXZJd3FGNDJaTFBKV1h1QTYrcXVTWlJERWh2WWI2Mjda?=
 =?utf-8?B?WkVQODMzdzRUMk8waDNybEVUa2t4MjdRRFU3enVhLzAxalNJQk5MZlk4bnY3?=
 =?utf-8?B?ZXR4aVFzdFlreC9oKzNWalVnWUUrbkdWRkhxOFY3THM5Y0xOYXZ0UGhlV0p4?=
 =?utf-8?B?ZzdtQVdXelRveU1PMTdLZXVTNm0wWkc0TUJHYkJFVFRCWVV2K2pkYUFCOTky?=
 =?utf-8?B?Tmk5UXgzNEhTYlhhbDlhYjl2aVlFSFI0MUlRQkNvbmRwSE90V2pteFgrVWFC?=
 =?utf-8?B?UUd4WWU5WWI1cWw3dVVJK2wzdjl5aVVkR1h2Zko5d2M3dDlMQ3A1Zzd4N2JW?=
 =?utf-8?B?dlVueEJBckUwMFIyMCtWazgvRmlkem1PRnZXc0FnM05hT3BpSDZabjJxNjBu?=
 =?utf-8?B?ajMvZU5qdFYzbkJZSnpVK1dpVE1jd0lGY2VZYXJuZkFMZFV3QzZ5eHlENjFV?=
 =?utf-8?B?NlduRG5PbDNUdlhoNUVIR1lWY29DWU9wQW9KcXdUQ3JxeUZJQ3psRjNiRUdE?=
 =?utf-8?B?ZG1Ua01IUU9qR0wzUytCYkpGUTVoZVovRFo1VXRTM0QrSnAyMmdJb2ViYVND?=
 =?utf-8?B?RllmTHc0WmZsMW5DUksvYUVURi9HS1B3YTc3M3Fod3o2T3JkREdxZEVtRCta?=
 =?utf-8?B?elJlUFN1TVJ0WExWK0d3MmJQU1VKZytKeE1DMS85M2NFaGQvWU5QSkp6VTNi?=
 =?utf-8?B?WmJNS1dFeXNNNXY2SjY3cm10V0hHS2pUM1lYVDNiYmQzeTQzbmNzcjBEd0JJ?=
 =?utf-8?B?Z1dDVDc1VDNyaWd3ZU9SSnpBNUcrdGs0Z3hTcGxaK0JRUkpZZmR6SWZLdWhu?=
 =?utf-8?B?NDZEOHZxOWxubm9BbHdFLzQ2NnRQd1FKVzhZQnJVcWllOEJDZjNxdjB1ak1K?=
 =?utf-8?B?T1RxVnlCL0g2aVo0Qjl4Rjh0eHR0RlhoVFdtaFNTWTE0MnExamhnUkpQWkdE?=
 =?utf-8?B?Nmgzd0dYSVFEa0F5Mk9EWmN3Vzg1S1J1QUUvT3hkbGRDcjUrTFRWZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7816bc7a-165d-4331-8f1a-08df3466cfdf
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB449095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:13:49.0012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERiCWz13IblDJCpEEzc7RAxPhUDE6EQXPiSpKkVfd4S1lDRseB7FhGr/CWYA4mWw9un1nvY2Nd42+DcipbruXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB026081
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
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------hh9i0BaWoi800ykJ9AfRj9CB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Personally, I am not a big fan of C++ style constructor/destructor patterns in C because they execute hidden code under the hood and can mask what is actually happening during a return path. But i found already in many places in amdgpu usage of this macro ...
The fix is solid and handles the race condition properly.
Reviewed-by: vitaly.prosyak@amd.com


On 2026-10-23 04:34, Prike Liang wrote:
> The user queue map and unmap helpers talk to the MES, but only the
> create path holds reset_domain->sem around them. The eviction, restore,
> destroy and suspend paths can submit to the MES while a GPU reset is in
> progress:
>
>   WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
>   Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
>   Call Trace:
>    amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
>    mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
>    amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
>    mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x520 [amdgpu]
>    mes_v11_0_remove_hw_queue+0xd9/0x100 [amdgpu]
>    mes_userq_unmap+0xc3/0x140 [amdgpu]
>    amdgpu_userq_unmap_helper+0x67/0x280 [amdgpu]
>    amdgpu_userq_evict+0x52/0xf0 [amdgpu]
>    amdgpu_eviction_fence_suspend_worker+0x55/0xe0 [amdgpu]
>
> Take the semaphore for read in the helpers instead, around both the MES
> call and the queue state check and update. The reset changes the queue
> state from amdgpu_userq_pre_reset()/post_reset(), so every caller now
> waits for a running reset and acts on the state it left behind.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c074b562fbee..96e338fa72e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -362,6 +362,8 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
>  		adev->userq_funcs[queue->queue_type];
>  	int r;
>  
> +	/* The reset changes the queue state and the MES is unusable meanwhile */
> +	guard(rwsem_read)(&adev->reset_domain->sem);
>  	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
>  	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
>  		trace_amdgpu_userq_state_start(queue);
> @@ -388,6 +390,8 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
>  		adev->userq_funcs[queue->queue_type];
>  	int r;
>  
> +	/* The reset changes the queue state and the MES is unusable meanwhile */
> +	guard(rwsem_read)(&adev->reset_domain->sem);
>  	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
>  		trace_amdgpu_userq_state_start(queue);
>  
> @@ -769,12 +773,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	if (!adev->userq_halt_for_enforce_isolation ||
>  	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
>  	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
> -		/* Serialize the map against an in-progress GPU reset (MES is
> -		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
> -		 */
> -		down_read(&adev->reset_domain->sem);
>  		r = amdgpu_userq_map_helper(queue);
> -		up_read(&adev->reset_domain->sem);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>  			trace_amdgpu_userq_create_end(queue, r);
--------------hh9i0BaWoi800ykJ9AfRj9CB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="n6owBd awi2gc" data-sfc-cp="" data-sfc-root="c" data-hveid="CAAIBxAA" data-complete="true" data-processed="true" style="font-family: Google Sans, sans-serif; font-size: 16px; font-weight: 400; margin: 12px 0px 16px; text-decoration: none; border-bottom: 0px rgb(22, 23, 26);">Personally,
      I am not a big fan of C++ style constructor/destructor patterns in
      C because they execute hidden code under the hood and can mask
      what is actually happening during a return path. But i found
      already in many places in amdgpu usage of this macro ...<span></span></div>
    <div class="n6owBd awi2gc" data-sfc-cp="" data-sfc-root="c" data-hveid="CAAICBAA" data-complete="true" data-processed="true" style="font-family: Google Sans, sans-serif; font-size: 16px; font-weight: 400; margin: 12px 0px 16px; text-decoration: none; border-bottom: 0px rgb(22, 23, 26);">The
      fix is solid and handles the race condition properly.<span></span></div>
    <div class="n6owBd awi2gc" data-sfc-cp="" data-sfc-root="c" data-hveid="CAAICRAA" data-complete="true" data-processed="true" style="font-family: Google Sans, sans-serif; font-size: 16px; font-weight: 400; margin: 12px 0px 16px; text-decoration: none; border-bottom: 0px rgb(22, 23, 26);">Reviewed-by:
      <a class="moz-txt-link-abbreviated" href="mailto:vitaly.prosyak@amd.com">vitaly.prosyak@amd.com</a><span></span></div>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-10-23 04:34, Prike Liang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261023083422.3049246-6-Prike.Liang@amd.com">
      <pre wrap="" class="moz-quote-pre">The user queue map and unmap helpers talk to the MES, but only the
create path holds reset_domain-&gt;sem around them. The eviction, restore,
destroy and suspend paths can submit to the MES while a GPU reset is in
progress:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
  Call Trace:
   amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
   mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
   amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
   mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x520 [amdgpu]
   mes_v11_0_remove_hw_queue+0xd9/0x100 [amdgpu]
   mes_userq_unmap+0xc3/0x140 [amdgpu]
   amdgpu_userq_unmap_helper+0x67/0x280 [amdgpu]
   amdgpu_userq_evict+0x52/0xf0 [amdgpu]
   amdgpu_eviction_fence_suspend_worker+0x55/0xe0 [amdgpu]

Take the semaphore for read in the helpers instead, around both the MES
call and the queue state check and update. The reset changes the queue
state from amdgpu_userq_pre_reset()/post_reset(), so every caller now
waits for a running reset and acts on the state it left behind.

Signed-off-by: Prike Liang <a class="moz-txt-link-rfc2396E" href="mailto:Prike.Liang@amd.com">&lt;Prike.Liang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c074b562fbee..96e338fa72e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -362,6 +362,8 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 		adev-&gt;userq_funcs[queue-&gt;queue_type];
 	int r;
 
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&amp;adev-&gt;reset_domain-&gt;sem);
 	if ((queue-&gt;state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue-&gt;state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		trace_amdgpu_userq_state_start(queue);
@@ -388,6 +390,8 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 		adev-&gt;userq_funcs[queue-&gt;queue_type];
 	int r;
 
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&amp;adev-&gt;reset_domain-&gt;sem);
 	if (queue-&gt;state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -769,12 +773,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (!adev-&gt;userq_halt_for_enforce_isolation ||
 	    ((queue-&gt;queue_type != AMDGPU_HW_IP_GFX) &amp;&amp;
 	     (queue-&gt;queue_type != AMDGPU_HW_IP_COMPUTE))) {
-		/* Serialize the map against an in-progress GPU reset (MES is
-		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
-		 */
-		down_read(&amp;adev-&gt;reset_domain-&gt;sem);
 		r = amdgpu_userq_map_helper(queue);
-		up_read(&amp;adev-&gt;reset_domain-&gt;sem);
 		if (r) {
 			drm_file_err(uq_mgr-&gt;file, &quot;Failed to map Queue\n&quot;);
 			trace_amdgpu_userq_create_end(queue, r);
</pre>
    </blockquote>
  </body>
</html>

--------------hh9i0BaWoi800ykJ9AfRj9CB--

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7E606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=alDoVNaR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6CC310E0A9;
	Tue, 27 Oct 2026 08:42:08 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1068E10E0A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 08:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEfU8nYXVlMHRk9/44dleZ72ccDjUqVtu//iaWnlBOpl/fOjJkKMY6bwe0slw1OX/UGBUJ8e3gk1vtn7H5LYey7LPU4QdXDZZKUWfbQltAV3kGDKOh1nhIuK6njpdEia8HRM4Sm4svUfvJSfQUw8/oyiDc1PHTE+JW2Qqe1ybHSQrKEQIL2uBQHgMEGSFSJikbP/5fWCAZcFTKxgRqUgeTUQ4KsJrzAqyj5m60gn87jJvVHSr+EZCbeSTlhfzhiVGM8KUFxQa2Kv4t9G3nKfCtsLNgjioOzsbhgVoAGE3qB8004YJobVciIqELRon3DOVYyV1ofNK7jpc4MEtLIArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU/1c+kE/AheuwtFaM7Mr8gFmBxG3Yomw/OJfhq/EIo=;
 b=Qv0M9NgbN2zXUebedsWwhiDxwrY/ZiD4cWuyD20mPG0+Vs22QojR7jvTuVNFDlIeK2+5pPG4wnp/siQPA9MqijiZo3gZ4/kpPUVTBNwfDmmmBDrPstP2tHuJucExOczuzz+iBwKIOkPfLcWOYnYZCLJkg1XkN63aE/S65YAAm4IYC0T4fQNNQ9UDjQB7ktzMwo0mo7LoGSvH6vQOBYBVBH9+69dAm87+qD8VJFQxbIfj7h8r9BgdWLSODm7KKyCp73emQjFDhve121Z9MsGtIOblGrC3tLD7J98sTnEpVtWlou43z64bMamWyHLO8dBetxbCyKl5m7U/6YzeWdMjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU/1c+kE/AheuwtFaM7Mr8gFmBxG3Yomw/OJfhq/EIo=;
 b=alDoVNaR30rkLOXpJzNFqsftwxvBmt0Gvf4uc5l6v2UOO017kzvAq0DtRhbxf0GV7tbyEAPMfEMi1b43D2wReXvy/Fu687RlZuoGE5wfq2Y9J5zkyu3C54rZg/AfRq6z1y6HzDSwP/IjWmS9Mcc5tdY8KWQiRw7W+Vs9zREvniQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV2PR12MB966079.namprd12.prod.outlook.com (2603:10b6:408:3a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 08:41:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 08:41:59 +0000
Message-ID: <870e73c3-a5e0-4f05-94e8-c9a2ce5bb971@amd.com>
Date: Tue, 27 Oct 2026 14:11:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amdgpu: Add xcp to reset_mes_compute function
To: Amber Lin <amber.lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261027075017.121456-1-amber.lin@amd.com>
 <20261027075017.121456-2-amber.lin@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261027075017.121456-2-amber.lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0158.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV2PR12MB966079:EE_
X-MS-Office365-Filtering-Correlation-Id: 856fa2b1-20c5-4605-6dd0-08df340629f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261026121527099003|4143699003|11063799006|56012099006|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info: rQ2K4LVK6qRP6yjECmB84G6JVSCHHYgxcvd/1n5k4x7xOrW8YsH6HqK6MHALJmKThUFKRGrBAHga+EOtN3DUIONQDbVdGyejdMVzYm61mfcloUET9xPhngIqwf1wH9vFN/NOBNIQbDb9B97OMB+ApR+L4cWKytp5Pdl/K8JFcIbfztgN2aIvLa9I3OJh9akQfohsL2mXXJgAnoQrQ2xmk0k4tVNh1Mfc3t34z/0EfhBorex5jhOhr+lny/DZMpHvUU9/wVl1V3FM2UfODqPRlv7PkWeOUCTs2OXupRt2k4RXgy7j4GD0v4onrDEpayeMhj0kSi2Qeg/BU7p4ZvbX3Q7legzg5tmZrFr4SPdC/zl47prkzEoh+CcgKG8n/Pd8yClW3UPr2yWwkUeEiJ/hgu/1NdkyTQMCKTK+gLAiI1CCow8r1PZUw1ckJoquI1d3s27Bk0vkqC8DUKLIyJ5vmLUn+io11at8r9hCnRRTWeUX4oVtm72jG938Pe2W6C2dljJTo3JKkJFrpCGdncdvJQCtFxrrWuMvZLGW67lcnIaOX6uCybwX+bfHJdPw30+jig2nN8he0kkJSD76sLd9utfIkSNfie/vxAR24SA5toA70XOf+YRUy55qkrmsROJxd5+vZKWgPxtOyymd6SrZZyGyo4cPsreZbPh19UkDeKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261026121527099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(261026140227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0xmMktId0ZQN0FMdFIzcE1NM3N6R1VhZGl3bUdwOXVaRGk0OXFDZDVRVkVU?=
 =?utf-8?B?dURaekwwYTcwYitvUEN3U2RzL3h5aEZMWUhKdkVxR00yNTh2UTcxMDJ6YVYw?=
 =?utf-8?B?YURiNXdpK05TYVFQK1NGeldaWHJVNmI2SU1zRjUraXJxY045ejZsV256cy9R?=
 =?utf-8?B?MGR1TlBlRVJlcWRVL0pXV1k2bUl3RnB6KzFGV2hzL014ekFCY3ZMTHBzL1BC?=
 =?utf-8?B?eno1T3NwaGI4YzIzUHRZYjloVjc4cXJzNFBKaFJaUW5qRUVTcWtPeEVtV0Zy?=
 =?utf-8?B?cERnUFRrYjRocjFPTU03dUVHYlBjZ3FnUWVsc3doSmxIcWFyUW5HWjlZZUFw?=
 =?utf-8?B?SjEvOG96VGQxaEU2QlAxSmU4aUtUYnpCaEVFdjRURkN1cUhkWnp4UTRqbHN5?=
 =?utf-8?B?bGt1Y1htamxVa1ZwL1FuSjhwUGlCa2Vvb2gyTEU3U1R5Zk1iWHVGNGdmMmRH?=
 =?utf-8?B?K2FIeUUzRmRVWERobVQ4UzdFWmRjenVEQlFDOG1hQ3QxUnExRjlaSGJlbmhU?=
 =?utf-8?B?TFl3Q1dmNHVSUDVjZk5MdWxWVEhJdUNoOXZhdUFmYVAyOXcrZXE4WlVhWlpm?=
 =?utf-8?B?R0tWQ0dMWnRTRTh6aVoxVnhuRVdMRHdMSEhIYzNudjhCKzQramQ1N3R1QmZ3?=
 =?utf-8?B?b2duRFJQYVhLUWZJeTZFaXN2Sk1JUzlITkZ0UFUyY2ZuME9RcjI4L2VDczVv?=
 =?utf-8?B?VE5hRjVmckdBK29NdzRjMHVSbHl3d2Q2MVVFRnVBWUxndXhXRXA5eFBaU2d4?=
 =?utf-8?B?N2k4cE9MVDJpUXY1THdFWWlrTllsTXZRRU45MFROd3RmUjJ4N3ZUR1lOQXox?=
 =?utf-8?B?NGxIOXp0RVJ2Q1hKT1ZjaFJzWkl0NU1MOFEycGVLQ3FPdmFvNFphenZ4N09T?=
 =?utf-8?B?TnV1aHFLbW1kam0zS1BnQmZYWkVWM0hNK0hTeUxBSldTVDNmTUZVRG9obkw3?=
 =?utf-8?B?S3F5c1hFYzlTcjA1clZIbnVQVndBeVJDV0I2VUVMb1NXaXhEcDFjUTBCM1Bu?=
 =?utf-8?B?VSs4cDU5OVJIRUp0K2s1YktpNEtvaVgrM05LcXAxQnFZTmMxR1JuT0dvTnlO?=
 =?utf-8?B?RHpZQzZOTDNTand2eDJuV3pqNlEwYy84VzFOSFhueSszT2pPT1lwc2M4eHBm?=
 =?utf-8?B?RmdzSCs2UnF5aXhrUjN4WGNvQitIKzRObXN4eUsrV2R5Um5vUHV1c002Q0R5?=
 =?utf-8?B?dVpBb25malllejNHbjc4WVp1UzI4T1pvZnNaZ1JOdUV0clgzNDdxNFA4M2Q5?=
 =?utf-8?B?TXg0QlZlOC84b1AyR20wcnBWVjNDZlhwd0k4cnhXQUVnaDlNZzJ5M3FyNHVz?=
 =?utf-8?B?RFU5K2NVT1hrUmVZUlhsVEtCS3YrZVptSE00aXZsNms5a3hlNGpUYlRQZkJO?=
 =?utf-8?B?VVlabnFiRExzRXNXNlIvZFo0akUyRjY3TzY2bnJaVW4zMTU3YlZONEN2SXY1?=
 =?utf-8?B?ZW41bGtYUjVEYnR6cm1yV0tkRVF4N2pYZmwwUnl2VzJlQWhpM2FKM3hOb1h6?=
 =?utf-8?B?Nk0zZGwzenpsRW1IQ1I3dG1FeXlEdk1sT1JsNyttc2tPYzdTeXdxaVkxK0s1?=
 =?utf-8?B?UWs1dnVVMzJIRFlrWkx0NWcrVFRQVko4ZzRBdDVjT2RrVmVFMGQzVUZpWURH?=
 =?utf-8?B?aUxNeEVFc3Q4dWVadnU1UTRYRGY3ZWJqYlhHdlFwUThJaWtqVS85bVo2VTBp?=
 =?utf-8?B?VEJ2U3NDZTZqOE41czhjTjlyT2loUXpLOHlKNDdlK3BiTHVtYnowMEQ0WnNK?=
 =?utf-8?B?TUxXSCtQZ3g5aE03VDVDWkZBN2IvQlE4OS96T05xTWJaSng3RWF4L041MXY2?=
 =?utf-8?B?RnpHTGczSUVRSG5aUjFEWFAyS0dlVG9jQlg4T1dlSjVMVElBZUdCbWNhWE9O?=
 =?utf-8?B?UktjNVNQekFQbFpoUVczaGZ1Vm5MVjRjckJKVlRmZGtoVXBhazljN0NiSkI2?=
 =?utf-8?B?S1JrUTRMQ0FxUGhLcDlpWXpCV3Q2Y0xjRGtObm5MUkQxTDhtd3FVMVg0NSs1?=
 =?utf-8?B?dGRMbVZzWXMreENNaDhpMGMrb3FBT2ZwL3ZmdXpwVkIxMEZWZHVoV1VKQndn?=
 =?utf-8?B?WlYzcDJCdXZRMUVhcnY4bU11UnZsc1ZHZExMeHF2U3lqaWh0Y3I3cFVXSDhO?=
 =?utf-8?B?V1l5YUo2bmZ0RVk2M0Jaa2k1REp0a0t1NUpHZXEwLzM3RTdneXE2SFVaTzlS?=
 =?utf-8?B?WHZwbTE0SlNOK0dPem1hUDM0UnJSNjduOEFFU2lSQkdvbGFwZ2dSZHVleitV?=
 =?utf-8?B?c0MrWDBpR1B4a21LUjhjUENHTHZ6OWRwRWhUOHNRMisxQ0dqSHJ0U0tnOHRm?=
 =?utf-8?Q?KukKbaemprYGzxcWjK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856fa2b1-20c5-4605-6dd0-08df340629f3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:41:58.9316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF/HAIgLhd9jkTdUzBV7o/i8P3DQ5Df72YokWZjd5km1q9Bz2DM/eH1of5cQh4lG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB966079
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



On 27-Oct-26 1:20 PM, Amber Lin wrote:
> Add xcp parameter to amdgpu_gfx_reset_mes_compute() so on an ASIC that
> supports compute partitioning, we can identify the partition's node ID and
> its master XCC. Pass this master XCC ID to MES when calling MES for
> suspend, detecting hung queues, and resume.
> 
> Signed-off-by: Amber Lin <amber.lin@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 17 +++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h         |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c          |  2 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c   |  2 +-
>   6 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 0c1c8ae822d4..ef34f7b02d0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2470,6 +2470,7 @@ static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
>   }
>   
>   int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
> +				 struct amdgpu_xcp *xcp,

Ring carries xcp_id. It's better to make use of the same (when xcp_mgr 
is also present).

It's harder to read the caller locations with NULL, NULL....

Thanks,
Lijo

>   				 struct amdgpu_ring *ring,
>   				 struct amdgpu_fence *guilty_fence,
>   				 struct amdgpu_usermode_queue *uq,
> @@ -2486,6 +2487,14 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>   	struct amdgpu_gfx_deferred_entry deferred_end[AMDGPU_MAX_COMPUTE_RINGS + 1];
>   	int n_deferred = 0;
>   	int ring_err;
> +	uint32_t xcc_mask, xcc_id = 0, xcp_id = 0;
> +
> +	if (xcp) {
> +		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mask);
> +		/* master xcc in the partition */
> +		xcc_id = ffs(xcc_mask) - 1;
> +		xcp_id = xcp->id;
> +	}
>   
>   	guard(mutex)(&adev->gfx.mec.reset_mutex);
>   	/* stop the drm schedulers for all compute queues */
> @@ -2493,7 +2502,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>   	/* suspend all will determine which queues are hung.
>   	 * reset detect will return the array of bad queue doorbells
>   	 */
> -	r = amdgpu_mes_suspend(adev, 0);
> +	r = amdgpu_mes_suspend(adev, xcc_id);
>   	/* if suspend all success, it should no hang queue */
>   	if (!r) {
>   		dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n", xcc_id);
> @@ -2503,7 +2512,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>   		goto fence_reset;
>   	}
>   	r = amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
> -						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, 0);
> +						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, xcc_id);
>   	if (r) {
>   		dev_dbg(adev->dev, "MES fails on detecting hung queues\n");
>   		goto out;
> @@ -2551,7 +2560,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>   			n_deferred++;
>   		}
>   		/* reset any KFD queues */
> -		r = amdgpu_amdkfd_reset_mes_queue(adev, 0, queue_type, pipe, queue,
> +		r = amdgpu_amdkfd_reset_mes_queue(adev, xcp_id, queue_type, pipe, queue,
>   						  adev->gfx.mec.mes_hung_db_array[i]);
>   		if (r)
>   			goto out;
> @@ -2582,7 +2591,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>   
>   out:
>   	/* resume all will enable the non-hung queues */
> -	amdgpu_mes_resume(adev, 0);
> +	amdgpu_mes_resume(adev, xcc_id);
>   
>   	/* Now CP is running again — replay backed-up commands and ring
>   	 * doorbells on each reset queue.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 5939e1fb3b24..26bbec8f92e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -664,6 +664,7 @@ bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
>   int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
>   void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
>   int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
> +				 struct amdgpu_xcp *xcp,
>   				 struct amdgpu_ring *ring,
>   				 struct amdgpu_fence *guilty_fence,
>   				 struct amdgpu_usermode_queue *uq,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 1a2aa85c504e..7dfe6e83f8ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -153,7 +153,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>   		int r;
>   
>   		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
> -			r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL,
> +			r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL,
>   							 queue, NULL, NULL);
>   		else
>   			r = userq_funcs->reset(queue);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 315dfd806d56..fdc0620ca67f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6932,7 +6932,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   
> -	return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence, NULL, NULL, NULL);
> +	return amdgpu_gfx_reset_mes_compute(adev, NULL, ring, timedout_fence, NULL, NULL, NULL);
>   }
>   
>   static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index d334fb805020..ec5ec1fd8b9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5254,7 +5254,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   
> -	return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence, NULL, NULL, NULL);
> +	return amdgpu_gfx_reset_mes_compute(adev, NULL, ring, timedout_fence, NULL, NULL, NULL);
>   }
>   
>   static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ce67e56efa8c..0eb4081a5740 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -506,7 +506,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
>   	queue_input.remove_queue_after_reset = false;
>   	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
>   	/* pass the known bad queue info to the reset function */
> -	r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_hung, &queue_input);
> +	r = amdgpu_gfx_reset_mes_compute(adev, dqm->dev->xcp, NULL, NULL, NULL, &num_hung, &queue_input);
>   	if (r)
>   		goto fail;
>   	pdd = kfd_get_process_device_data(q->device, q->process);


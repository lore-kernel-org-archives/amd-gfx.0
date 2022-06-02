Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29102C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 13:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A903610F20F;
	Thu,  2 Jun 2022 13:25:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2E310F20F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 13:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoHWRmowST5N8Cd+nLyaKRfHw1jb259/iiukmc/RudZx6bKhzvKQcqpN6lC+QlsJQpbBvT6DnoKa4BQ4udJ50oSnH/pxiTkTDUp6fMsIq0xXVoOLiwWNhw5eiwkzR4FGzO51C25gfgNVlptaPWVKQzmfzyibVeLiY03nvcmYlEE/H1EuepHo2gJLjKmOpq2KWAirgJ1j4LQnTpVOKPrHJrADFO4mkdZUotm6yNrw/Jmz/WMwmAusZ9ePdWgN68uzJhrmU9X/ASQHuf8t1XyxvS5U/wVk9pyPYW/g5FiVcvsh0M1aadmTQPpGUPfwxUeL0/3CxHUoMyM7ky3BF3Hljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQmHCnGFGAYZEgu8mq143lvG7mD/QX8fRGQwvjm/Pso=;
 b=Yw5GYCo3QSF+Fockz7xF0oY7w4Mp4ZHMnfR9fzluXjRC4SLNv2ZszsV2aVTCT9d4cuw0bcHTOwBNUAjBvYZAnX/L8NcviUDBpJsiSBA23B/KA9Uwb0bscTusrEiWjoriBH65iXxCN6EG9cPjMBcsTlfEBDUiVqNQ5Lb+YYBvt4wTlQeyDWp1rh7SrAAUXYPMppW+r9JRjN5Ab9NaVgb9NeTe1Etsud7AdhMmk55j2JYovJfU8H2kr4FthBhbdh3jVgx6T4MdeDxZvXvLIbMnc0rRDPWCZg05SWS3jBOoqkSEKuhx9vPtVYGAXOBhZkkWOsAszke/dy0M7JYhBILguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQmHCnGFGAYZEgu8mq143lvG7mD/QX8fRGQwvjm/Pso=;
 b=5m50ktLWCdUz1376kg2W4//tKCje3SiXwkVGcvb50LBBFMhRybs0InpQoAdjv0mH6Qt1C6JC4PrKEnzFfC2zWJzog8cnin2kikK/8gAGtWMZK2Wwl2V2Y3N6PIbKYC1ZTB1iyZrZfwJBujGWhoKEhOCJfLNwkiffRWJuhuZKxBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 13:25:10 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53%7]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 13:25:09 +0000
Message-ID: <60a9c99f-5a19-fd31-d4f5-ccf81717e3e2@amd.com>
Date: Thu, 2 Jun 2022 18:54:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Update PDEs flush TLB if PTB/PDB moved
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220602132029.6225-1-Philip.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220602132029.6225-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15da2fdb-5148-4e0c-dc55-08da449b50e9
X-MS-TrafficTypeDiagnostic: DS7PR12MB6189:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6189AC1ED653CD0845FE291B97DE9@DS7PR12MB6189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJlAStLaR0B712NTqOpT4c51TRl531/ygcN+IUmehxAwZBGAkqiCpR3haR8/bEJk+BLI03PY2OD014zy0INSKktxUiavlkByJzW12nyeMLlZae9lW5QrjU+VtPfEYDCcmO1esRBVDw39UTQJvIHkgk1+DWyqvalQLioxpgU3yt+curMnn5aDQbUINVtgIQVSp1lqDWMg4NvzIm3zbMSRKLiOhJdFdw3ZRqIX3jiaQwB/nfrHVBNqJbfMxBSkg8P6xl8f3KKWWSau6HZwaf+uCyvXEDbhnY34POwvZAZdOKZ1q+LGPRC/xobUZ9gLq8/4BWrXa2fWvtI+EdQ1/W5l9K646wFIAl19ajTk6ztcUFHk8C5W5wX9l4mYy9NQSuAvKJgH9YgucQurQQQ8eobo1Ld+QY1B64OKxOzYYIMk6HUoplEr63/6Nfzm1wD5nMXUDaScWZ2voNNGNHbT4cHEQmeT/D32R18YEuFriCl6pIR6yrzxC/imKObODxIhefZWNhzp16xmO8dLdc6ryg8iAxVMXu11p9AsOU/F6vHzulHZlOE7BMBy4iaQF0AMyp46sv9L9ZJ+uj32qeBNcfT+dBP9NWfdCqiNEfmxwjTbeZEX/rPQs20LNQDQNKSqbk9+5KzMEg2XEf4y4epa+ACqNV5gvvOhJ0ig/T3X8xOB/hPk/asnXJbQ8AwC3t53x4g7sUG57whkL8goi27Uh4pVw83xwrImNsMajq4Ae4GImfCw1wW2oqJVOXA8M7oNDsHL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(15650500001)(186003)(31686004)(36756003)(6506007)(53546011)(66556008)(66476007)(66946007)(316002)(8676002)(4326008)(31696002)(2906002)(86362001)(8936002)(5660300002)(508600001)(38100700002)(83380400001)(66574015)(6666004)(2616005)(26005)(6486002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emEzTzYxNmJkTUVCaWJrMEExNStyZ2NNUUhCeFhnNnJKZ3NNSkw0VndVK09i?=
 =?utf-8?B?MTRzYW5XTjdsODhVNDF4dnVabVlIRmE0eFZqS3RMc3oyQjdCT3ViZlRJRDlV?=
 =?utf-8?B?SlVqWE1nSjVBUzRWVHNzeTBHVHBHVVJackhsdWZMZEUyVTVSOVpUZXZNNldT?=
 =?utf-8?B?dWk4SGcwR2pHWllvK0pFdlNTYTJOR3REb0szOXV4aWRkUjdTSTd4MUVROEpV?=
 =?utf-8?B?dE9TZzA2UWluZjlZTXNyT01weWZvRUhrQVFDblNsK292R0Rpa1lva1RYMUxt?=
 =?utf-8?B?elBmdXZXeEZvYXRidzVBdzB0aWlmVHlYUmRybzNvdzRCN01lQXRzVjBWQ2NY?=
 =?utf-8?B?Szd1cjhCcmFUSk5NWnJWcXZ1TXIyT1hnWk05VUJCeWUyTUdIV3dibmxWbVBm?=
 =?utf-8?B?YmNSREx2bHpnVERoQTJiVktrempmaVlIRTZBVGJlR05uN0lyRHRKLzhhTEVX?=
 =?utf-8?B?Q0ZhRGRRMk5Tekd0TEFTRnBoTGtqVmZrTVc4V3g5NnJrUHNwL1gzY1JRbkxn?=
 =?utf-8?B?S1gxYkxIMTRVSlpBK0ZrWW5TVXBPUWl3SDExOTVSYkxUMGdGR2tyVlFQcDFX?=
 =?utf-8?B?T1hpdFdWRUk5a3FDendOUU50eWd6OHM1UXIwWk1sbGdIT2xhL3JNUVBUSCtp?=
 =?utf-8?B?Q0gvYW93dXN6R3VhM1IyQ2J6Ri9kYWRnT1RuNEgxdEhpTDgySFBsQ1l1WVlF?=
 =?utf-8?B?RWxBY0pDd0dFYlNuZUxNd3F1NVRiM3hjTllDa0VKd1RuOUJUY3M3RGUyaWtp?=
 =?utf-8?B?Vlk5ZGxMWExWM2ZOZGRTbDUvbnFLOU1vSm96VXU3SzJaOFZERGYra1I1Nmlm?=
 =?utf-8?B?RmozVmI4cVlCb1J1bG5WamdEdTFweFNPSXBIQThyb0dRR1cweVhlSmR6WHNi?=
 =?utf-8?B?V2lHWXI3SkR2VTB1ZFFJTXh4VHZpVWNlZmlRWDJjcXVqdjdzaXQxeXdUQkEz?=
 =?utf-8?B?NFIyRDBlSmwvNS9hb3J0azQ4eU5aVEYwckMzazZMZjFESFJaNlJLd254Wk0w?=
 =?utf-8?B?NXpmMVZMc3VsTW5RaVFCWFlwNTRBaGEyc1pLV3g3YXlaTW1ER3lYbFkwM1Rz?=
 =?utf-8?B?dHN4SUxpZWx4eFAvWEgyaXlwSE40dUdZc3AzMEcwTjBLNG1BWmQ2WVRqQUZW?=
 =?utf-8?B?Vit1UEs1cnFMbngralhmb1gyZUFYYVRiTzhJdGZVSm9mQ29kUG5oZzhiSXVi?=
 =?utf-8?B?V1dUdFU0MGhjUTNaZ1NCdlU2M3hIcG53c0Z3Uy95bWdDRE1kbnpjVUh0OU1O?=
 =?utf-8?B?czYvTFhSeTVrLzRKRldzRWpSYXF0d1UxWEhIQXpLU09EbGpWbFlwQ3dZaVJB?=
 =?utf-8?B?Q2hhMHA2TjBsUUFvTnVQK3VwY2pTMEJMWmxrcFVCVlJQdDZWY1RUbHlud21t?=
 =?utf-8?B?Y0N3by8xc2pINVdOR3lBZnpwSmtxNDJKUWhWNTAvYlliUTNCTFE5MHMva08y?=
 =?utf-8?B?b0d0cW4wMjUvZlFianN1U2orT3JIenRJblJzMUp5YTB1N2pXRlNOOGwxekR6?=
 =?utf-8?B?TFRvQ3VGOXBqclF5bTFER29KcUxTM2U0WERCeG12c2JDUHhNbXQxeEtOdnJP?=
 =?utf-8?B?Ylg2STRJbGZxUUVDalZxRHZvRmo1QjQrd3g0YkJXTVYxK2htUWJJclNpL3Jv?=
 =?utf-8?B?TDFDNnMxU2ZzQ0dIREY2VVdzR21sUGdaTkFhSHpMMWZhdDRQaEZ0aW1BRVp3?=
 =?utf-8?B?bWVLYng1WEhYaFFkWmsyQ0EvOUkxWk1tNDRvVXZwUW9RTHFzcmpWSkRxU3ly?=
 =?utf-8?B?NHJVVk9USTBmVitTV05JNzBEa3NnRXNzeSsrR25JU0MxeDUzNjhuWWRDUUJ2?=
 =?utf-8?B?NDdzbVBibEVNeFVFNzlITElzK25Qc0V6bVRmTVkzT1RKVHFhT1gxZ0hoSHhr?=
 =?utf-8?B?MGtpV1BWTUZVZjZhK21SM0dzRVoxZGN2dEVOL09iQ0llZU5yTUlEcTdEVkIr?=
 =?utf-8?B?RW1STkxZTzF5aW1vRGVSM1Yra0thdDhpbjZsRlVPU09sS1JBRi9CT0RUQlRT?=
 =?utf-8?B?U3hoV2t3OXpyVDlJOGphODlvTitCcWJIZXZxRi9nbHM0RllQOXBHbjdXLzYw?=
 =?utf-8?B?WHJ5cWp0TVg5UlVIeUhHSnpHaGFSa3lCck93ZHBEVzFXL0J1WVRoZmFzWGhM?=
 =?utf-8?B?S3ArN0lUWVpHMHdYNmN5UGlsWHVLMUxjM1hnT3poSmJDUElDbmVtVm5mUXd6?=
 =?utf-8?B?SlRiUjV5aUVPd3MzZG1QdHp1eUloMldhU2F6d3EvaEZyOHM0UW8yUExGQkd4?=
 =?utf-8?B?OG95SVgyZkNVWVVNMlBCaWpMcm9POG9aeXB2dWxSTW1GbW9rQkRLMmhkamg5?=
 =?utf-8?B?cGpzczVOanNOR0piVDFjRndlckc0dWpWekc4ankvYWlLTy9hQkRNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15da2fdb-5148-4e0c-dc55-08da449b50e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 13:25:09.7594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUrHYYW4doStmOv8MKZULrQywAef1hCgNVNH6xtg4TWqL+kOKHut7bS3MKotWTHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/2/2022 6:50 PM, Philip Yang wrote:
> Flush TLBs when existing PDEs are updated because a PTB or PDB moved,
> but avoids unnecessary TLB flushes when new PDBs or PTBs are added to
> the page table, which commonly happens when memory is mapped for the
> first time.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9596c22fded6..1ea204218903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -737,6 +737,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_vm_bo_base *entry;
> +	bool flush_tlb_needed = false;
>   	int r, idx;
>   
>   	if (list_empty(&vm->relocated))
> @@ -755,6 +756,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   		goto error;
>   
>   	list_for_each_entry(entry, &vm->relocated, vm_status) {
> +		/* vm_flush_needed after updating moved PDEs */
> +		flush_tlb_needed |= entry->moved;

That is a strange thing to do for a bool variable. Why not just assign it?

Thanks,
Lijo

> +
>   		r = amdgpu_vm_pde_update(&params, entry);
>   		if (r)
>   			goto error;
> @@ -764,8 +768,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	/* vm_flush_needed after updating PDEs */
> -	atomic64_inc(&vm->tlb_seq);
> +	if (flush_tlb_needed)
> +		atomic64_inc(&vm->tlb_seq);
>   
>   	while (!list_empty(&vm->relocated)) {
>   		entry = list_first_entry(&vm->relocated,
> 

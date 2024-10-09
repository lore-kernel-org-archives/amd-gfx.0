Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F41CEE350
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 21:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C907A10E03F;
	Wed,  9 Oct 2024 21:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mofg0grH";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E1B10E03F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 21:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIm30CRfM8gsafiOiVLcz3HxfT6yp60CQW0pbXZPyarCXa3kzU9iyJvf8Zdhuxa8b0kKB4XbPQhZS7rkHDXvl0TYER9JxSwmsbrKhl3DL1tXrO2Hdd7Om5VwkzPgp+Jwu3tcAw4gFG9e8GTcvEGgpEe9F2oCvv06sDYhdgppiHIyTl772F73Tmznu05YGPUsFvrMNqhLV4E+kpPgdzL43ABlfWBpeWDvGCootrNFiwNr9fR76Hpk056lZke8sL2IS51mxAfgSMTJyu+Y7pGi3FHE2TX4UE2zAjIAVRpA9nELZwDrTenPmQJwL/Yc8PITPjK67JGBjutoyssehj+g9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i56PL0E9gvWEuVtf6ZEWaf/XR3I9WJsMD+Av56deU78=;
 b=E8+sNyHOjMh7TH/E6XMyjQaGe6zK9c17DC/P9HT41qELF7TqJLHubXbrJOo0HM5NY5QgPkbITS1ajlP5X/YtJ8MqaFSRilMfxdDILOR6O7xisfI6l3wRSc+7finDvuac3WOwylBCzeAnBntn/j+ssSoJJleO1QTQ2Z6GOaj6HNGHiFoyrgr5muPVFQFljBcskJCzAAlvbMU3YXkCEJAWCPnNoj1Q4u6qMxxtw9eG0aLiVsp9qPHMKDJsta28QM4eNRkAkYVxySuwyiGAk3//0HsG7zyCC72RxDUmzfJEtwd7ljX+4ri6a7ijiwFkbWQ4VUhrcFVvbmKGhk9eaVADEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i56PL0E9gvWEuVtf6ZEWaf/XR3I9WJsMD+Av56deU78=;
 b=mofg0grHietgApWIXP+SvoQbqrmGc65GAmhdUjRFiHfU39pH/gx+h4mBECDDCOPsO4tRu7XRA74MHvE1+PjDDQaL8Dl3i5Dtir6OKShBMlDbHhT56WOiCxFBPgngN0Qnix1Qt1odzM6Xugc1I/8v3u+mpOpIi/5IbONTlhosgaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 21:36:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 21:36:17 +0000
Message-ID: <39b09fc8-16d7-462b-b4f2-3e0821434d9b@amd.com>
Date: Wed, 9 Oct 2024 17:36:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Not restore userptr buffer if kfd process
 has been removed
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, kent.russell@amd.com
References: <20241004155401.18978-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241004155401.18978-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3e39bc-52d7-4df2-759c-08dce8aa68b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlZTMlpvelZFUE15SEx1OU01VVJicHljNlp5NS9oNWhFRFNySzlMVUJ1S3A2?=
 =?utf-8?B?ZDltMkRjcGZhQ2hWM2lBOWkrcU9TZXMrZUNxRTR2cXh0eWtzenNXTElEL1Uz?=
 =?utf-8?B?K2JaaUE1QlZzbUhFZjN6aVB6bm53THNscEExaTkxRG9LQnZDd09hMURYRm5D?=
 =?utf-8?B?MjcwMDhjT2xqalJOM1Y4cHNHdStlcitCMHUwVmtOUHc5VlhpQUk0NTVldkR3?=
 =?utf-8?B?WC9Ndk9oWHFSUlZvSTBhQWkrbHowbzBVMUFzN0Y3SWZuVm5FNm5JVlU2bVBU?=
 =?utf-8?B?bkt3VlpVWVgwTG5lM3JmUFhaMTRyMVFBZlNocGwxQjRVUzZDN3BYMnBpdU45?=
 =?utf-8?B?eklFQSthdTA2K3QwV0hrMHUwY0syUVBmVm9VM3YxZFp2bkZRM3ZLVnlNN0l4?=
 =?utf-8?B?Q2Q2ZHhEUWltb3FNVkExMUhiNkR4RVhYN3EvSGVoTSs3TkJNbG1SZGlNcU9s?=
 =?utf-8?B?V3BjQU5QcGNGVmpIOTh5WVpzYldWM0tqd3d2d2w0N1dmcjgvZXlHOTB3ZnA1?=
 =?utf-8?B?N1J5ZkZzNDM1dXRhYXFWRVp1WVltd3RUUHRWWkNyL2JwTjRTUDF1Zkd5YVJ1?=
 =?utf-8?B?KzRpOVpSL2dJc2tGQ3lFRmVab2FQOEdFVnM3eWJRdGNlZm9mb2orb0d3Wmp3?=
 =?utf-8?B?NXFBaDVJdDJrMDJtUkoxK1FkU0xJUFMwV1lpakF0dGpkSkJBMzJPZ1ZFanJK?=
 =?utf-8?B?L3hYN29Rb3VRUHllbVJiN29NRUhXa252YUFvQjNKdlNCejh5L0hGMlpkc0Nr?=
 =?utf-8?B?ejVJQS9Wbk5FWDZBTjlmc09KZzMrYzVzbVUwL3BLdHovWGd6WC9iMHdrd0NV?=
 =?utf-8?B?d1Nha2t5a1E2cy82TmRublJtV1VwWmNuTzBJTmFYYXNtdUZycnFRNG5PRGZs?=
 =?utf-8?B?UGtvd0kxZ0t3TTM3dlV1YThVdjFKMmVIczBRT1dtVUNnMm5zZkhTN1NsM1d0?=
 =?utf-8?B?TGRCeElEOFBYRDBqQU5yeit2R2s4RTR3cXc4cWdJSXEyaGZydHRXNE9OdTRa?=
 =?utf-8?B?WUZ0N3hZcFkyMDAyUGFBSk5IR2VnVEhVVW5HSWx2RTFsQTRKQWtZY1MzTWM5?=
 =?utf-8?B?aDU5S1ptbFExcjVkam9RMzVKSHA1YnVOK3lBdkozc3lPRVMwZ0d6em40OHF4?=
 =?utf-8?B?N3pBMkxXbzRZRXNab0Ixc3N1M2V1U1EyZ0VmTUN6MkltVHoyTXFaV3hyUVhP?=
 =?utf-8?B?czNsam4yNjhWQVBDejhTdmNJUHhxOVhGcjVtTnZOWmp5bFFwcDNYcXhaNWJB?=
 =?utf-8?B?b3U5czlPTTAvaGN0aVJSaVN1T0Vlc3d5WVU5VWVDVURGTnVIODVXbSt5WWxo?=
 =?utf-8?B?NWl4NlArZFJmRnFtVDlMazB2dm12SkZSSm1QaTM3Vmo4MTI1QjFWa1ZjOXNQ?=
 =?utf-8?B?WnlHbjhmYWpmN1JTVFdYaCtZVXEyM3dFaWk2S1IzUXNRc0lLNGsvbTkzb0c5?=
 =?utf-8?B?UzVoSVhWWDZlek0rMTFHRkdOYldLOWt2MzlJSCs0ZDVQcVIzYWVrdnMvaDYz?=
 =?utf-8?B?S0RvNjJ1VUtnaHJ5bVQ0ZHMvcnN2S291VE0veXRzTzhhcWwzRnFqTGltKzJM?=
 =?utf-8?B?bk0yRktZRjR5bFVwVDBSVGdFQWpiYUplN0NzVTRHM3dBMC96YVNiaUxHWmNw?=
 =?utf-8?B?cHdWVmZISGJuQlNFc3MrK3VzaDQzVnZzRWIrdTkxV2FRYW8wcm4xUWo0eitI?=
 =?utf-8?B?cFMxV0E0M0g0Z2lEcmhKZHFkNWNSajR2VGNOUkZYMk45ck5nd05Va3FRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDZTQzlOSVM2R1JVeHU4dFp2UklQOW9qTitjV0RFazg2SWNDSVQ3eFI0TkJX?=
 =?utf-8?B?TUZEN05OdnB5TTZJMGhiZjVOK0FyUkJOZE9XcElERUxueFRVcUhKWlpqRVZj?=
 =?utf-8?B?bGdLMU02bWhhNy9YakI5bFhNeFBVVzl6elZ6dGd1Mk4xcG15aGFxdTRwN1M0?=
 =?utf-8?B?VTd2ZVEyZ2dUWHhrV1FYSG9BZ3ZEVzMxd3laeDVUTUFLU3NoelM2bE1BV3lH?=
 =?utf-8?B?QW85MDBFbG1vNFpSTW1QZWpEU2ZSb2tqNnpuMWpPSmIxSSt6a2doTW4zcWlV?=
 =?utf-8?B?ZkRnMytESVNPTnV2K1hjYjZsMWZyK2VadnBoWllxbmI1ajZjV0JKVmR1K0tm?=
 =?utf-8?B?RW5JaHB3Q05ON3VZWGtaYWc5ZmZFK2ZVNmVGSUxDdFYzZmtlV01YWUcrMjJN?=
 =?utf-8?B?OTB5ZXFTNHR3VWNWU29hWUd1SjdNdDZST2ZWMmtuVWFxL3Q5Q2xIVUltWmJO?=
 =?utf-8?B?R01WUXpiVE1QVDVOOFJ3ZEU2T2ZSZVJGR09vTnU2RFIyOUhXY084N3JTWk5k?=
 =?utf-8?B?aUFPZmRublZsdHdZK2ordlFTUy9aWmtKMzhHQXpvcnFlSStaeHYvZWg3cnhq?=
 =?utf-8?B?NHBESVIzT1IyK0grczZGL1F5VzFMQnIvQ0pFY0hvTStQR3hlOW5JUDFtdnhI?=
 =?utf-8?B?cGlvMFY5cjJycU56OS8wdjF0S1hSUlNQZ1RrNlhPNk5VNzhBWStsMXpTS0Nm?=
 =?utf-8?B?TUkxemtSeGhyMjRtMFhveTlLOStkL2lna29KaFl0YVZtWXpUWENqdmphaHVR?=
 =?utf-8?B?dHl4YjZYRzBXOTFSR0t4dWNITy9kVXlnRXhFTFZwK0tTeUdhbWpxbkpIMlR2?=
 =?utf-8?B?SUYybEV3SnppU2xIOFcvSG9kZDh3cEx4a1pFV3ZmVUROb09VT0szWEdrQWJr?=
 =?utf-8?B?azBQc2JRMTJDVkhUb2lkOHRFeWlsTngxMDV5MnZzT3BleUVLNndGK3k2Sm9i?=
 =?utf-8?B?V3dCVGk1c3JxUUNBdmNxSHdqZEdiTjFEYkpHRWdqYnpZVm5meUx5YWliQkND?=
 =?utf-8?B?MEVrVkY5ZXRtOXNtVjRpV25KMWJJWG05ZTFFUDIrZmJyV2k3SnZWTGZiTkRq?=
 =?utf-8?B?ZHBLTkE1MlNDRENSUkkzZkw4b3A0WnFybmVKblNrUFE2ZXBuemxqZ3ZyaEh1?=
 =?utf-8?B?T1doSHovaXp0aU9EaWtWWUdrYkZubVl3TE8vd1R4QVk3T2hpTnlqNWpVcjhK?=
 =?utf-8?B?WTZMdm1DZHJmdFdQTXhzTU85RGR1NHdqK3VPQ1B1MzJZTWhiZzJFcExaL1pF?=
 =?utf-8?B?VVVac3diU29JbjgwRHRzcWkvaTU2TSt3bWVoVFR6VjlrZENNV1hvNzU2Rzhq?=
 =?utf-8?B?SC9GVCtBTXk1c3FZVWFCN2lCb2pqU1JPVFNQREI4S0h2R2tiUTZSNGFhV1J2?=
 =?utf-8?B?N2N4OFpjUmFhYmVtR0UydWkvNGdwVlFqUWpvMmlDdFI2eHBwM2w2RFhvOUk1?=
 =?utf-8?B?ZitIUUFTdE5UMnYyaEVUdkxhRWxjd0JxNENFaDdlMG5GTi9RNHBRejBTYTRM?=
 =?utf-8?B?N3Y5UXBVUGI4SnBUM1RZWFdXNXRHL3k0TDVjQm45b0I0TXovdzRnb1lVejlx?=
 =?utf-8?B?cStnZm82U2NsZGJRTzFkWlpWVjFRNFhRS3h2SFpBTkZNd29YR1Q0T1NyYnRa?=
 =?utf-8?B?ZXpBeEd1R3N5UHdMM1VUN0tGakQvYTV5SXd0a2Z1OEZ0TGxOMitvak93cjli?=
 =?utf-8?B?RmsvNDh4MjY3eTZKanVPVE5uc1ZhRTR0NGZBbDlqSkY0MHErcjhjV0VjREZp?=
 =?utf-8?B?Nnp6V2dtV1o0UEVaU08yQkxhUEszS2hIZENGZHg0TlQxRGFRR1QvNjBpZ3RG?=
 =?utf-8?B?MkRnM3FrY0VqbE1hSXQ3bVlhbVJDRXdBWjAvaWZXMzhXRU16K1hMSlk4NU8v?=
 =?utf-8?B?bTdEVENsdnVObUp0R0VYcW1rTzR1YkNMQ0JlbFNJRERUYjlLUS9BOHFtVytE?=
 =?utf-8?B?SkFPVmVKRjNxTXM3WHdnbUtVK0Y3VDMyay90WEFrY2w2c0V2L1FYTDhVWDdX?=
 =?utf-8?B?SkY2djJESlFzTDdFbFlKVGVtQitVWEZKbXU2azZQQzJHNHUzMFRPdkZxK2JY?=
 =?utf-8?B?UHZORjZRMDdjNkIxZDVFYlQ2WS9TTXdudXU1SzRDVnZmS1hBd3Jla2hmVXQ1?=
 =?utf-8?Q?oG1XwItbo0Y3GL9GkfIzSY/Ne?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3e39bc-52d7-4df2-759c-08dce8aa68b0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 21:36:17.9128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PmivdUSRs/TeN4zcXphAi3UzMFq3xyfcgKiHfYDu/6HrhPgUcXa660p4nxExQk1g/4tengrftYx4HxWWX6KGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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


On 2024-10-04 11:54, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When kfd process has been terminated not restore userptr buffer after mmu
> notifier invalidates a range.

Is this fixing a real problem or a hypothetical problem? If there is a 
real problem, can you include more information here? It looks to me that 
amdgpu_amdkfd_restore_userptr_worker is already handling the cases where 
a process or mm_struct no longer exists. Maybe the only user visible 
change from this patch is, that you no longer print "Failed to quiesce 
KFD" in a corner case of an MMU notifier for a process that no longer 
exists?

Or is there a problem with the lifetime of the process_info that 
contains the work_struct?


>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ce5ca304dba9..6b4be7893dfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2524,11 +2524,15 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>   		/* First eviction, stop the queues */
>   		r = kgd2kfd_quiesce_mm(mni->mm,
>   				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
> -		if (r)
> +
> +		if (r && r != -ESRCH)
>   			pr_err("Failed to quiesce KFD\n");
> -		queue_delayed_work(system_freezable_wq,
> -			&process_info->restore_userptr_work,
> -			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
> +
> +		if (r != -ESRCH) {

Braces are not required because there is only one statement inside the if.

Regards,
   Felix


> +			queue_delayed_work(system_freezable_wq,
> +				&process_info->restore_userptr_work,
> +				msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
> +		}
>   	}
>   	mutex_unlock(&process_info->notifier_lock);
>   

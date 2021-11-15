Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEE3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 04:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FA161C14
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 04:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0FA161C14
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C1789704;
	Mon, 15 Nov 2021 04:34:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B587489704
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 04:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8bzS/EPBL5i3XszXnKz6tPMZzx+Ue97AePH65Fk6F1rt0sq2inFEm9+t+oqiOXK+vSAzbkCG0nrWBNMbUpuekRCRZhInQdKTYaZqVzHsyOWU1w6THDrqLsJjxlCK5cG3v93qsb0/5xMQ8vPy1ZfCIiEmz3iLDBe06tHlfqvPKZ80CgF/1RjVWTRsv8INtIIRidaypF7vfqsuBNxUdKOb20A/AfiHdaoXFf/ViyAs/0knAvQBftbmrxowY4VwA2G66g4LGln6GGrkP2TEWfZGMlisfINByP5NfrKawpiIlDOubDIFh62vxokOBPDhmKKP8BbG7rTZ0i9MJSj+yFsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qXqaHptgTfU66ajG5bybxSCiC6qVGtiyRlWU8+wpXc=;
 b=kEdqro39QexwYgxNDg3YleX1zv8qlezYsCkdXU3vPIuUmlNbWDrv0nFe5ZKilC67Kp7Ad5Z9LsfT9LEtM6mTxF+C3w67clYOoEFS8+H9oW7sH9GJsQ/XB51dMWT4P+weL8BJNpGJAP3d1/5Z/b8JGsL9KK/WqC2xCE2N8c2DJXf6ROaGKKmIR9SPkutDmX8EDKJM1ZcRiPeV1+Wh1poTVaB0X4kJw/yUVjYbuY1vR9YRM9sjvkg8B9OZ8saWQy22E1WRm80O+gQ2pas3goDykvxgQeQelgUQvxy55FO0xr5UtlR2wAKSSE2Ukd3qY6Rc49MeapdBPdTETecEiB/44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qXqaHptgTfU66ajG5bybxSCiC6qVGtiyRlWU8+wpXc=;
 b=NX1NutKazUts86IE6ABz5T8sMDXRj074E0j8rK7Vnz5gmE7an07V6tbLmABPpzu/VhaMeoyfpIYZwai7zY6SoWlJWEavNNP+lrTc7ND9t2JC8XJS1crTKvZ0q4GcGU6gMbQqgwJcNXEk+ctCQsH9C+CmfLKX6Tp0pQLgXR44acs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Mon, 15 Nov
 2021 04:34:25 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 04:34:24 +0000
Message-ID: <69ae10e6-bacb-3ce1-fb18-46a60be451db@amd.com>
Date: Mon, 15 Nov 2021 10:04:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V3] drm/amd/pm: avoid duplicate powergate/ungate setting
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211115025137.639014-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211115025137.639014-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0105.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::21)
 To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [192.168.1.9] (103.165.167.115) by
 BM1PR01CA0105.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.25 via Frontend Transport; Mon, 15 Nov 2021 04:34:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e53f6c4-7819-4bee-0f32-08d9a7f13372
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882BAFE40B836B899F8D2AF97989@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwhaIC1CGKpokmfMGv+g0pCS/gwPsjlWMJ7CSrZunpVDiU67Pe1vEoreTmcuWBU6aPFpCHg7HTxQkp9BL1k4+EKsk5mDSn88LYmslM3DvOP9z05HdhxmETJ/2ZnyCTLfvhwIycKeqLpIjTVf2zUUVrlpVrvZ5jXEvZaslsZVeBb+74lXdtdAlS3cfv+BwNHWGo6bZLyciHTmqGG41AkhdrjlvsvNseojQsKFv3lMk5a4eF9LPqtxGqLJR02gn4jpeBGwG6gK4Y6tGpRIA7lk+wmtG3YU9kbBH+nlMcWGqRVHcvRIuVDn7wq9qC5k6mbnwq/5p6odrmFYqitThCTbQmOoh1ROcpHmk8ImLzCL07yIO4dHJe4LaavReBKrA1GqX1EGk987f6EWvLLrgcL/IDLEevFlhGO+3mky5BOxRxWItdglw4E9EZNk/+Ycihu7yTim/pltd+mUBvZPI4yGHIyBJ9BoRVHgOErS2Dqmvu9INRkeJmvxsmdB/jCcwnvpQhgtmg/HeOFIJOK3diFqeBjqmNkDwlpt+1tCckTyeiWTVB8/sfQvdFKH77rbxjc4yegWEIsCn85gcPCQ2zQcFlo6Zxw3YOKMXZZ/9/ykCZ3PRXby+F2qX9I/F/FUpEQBACsazAZzxL+oP1MEQYraAAn7Rq5zN/vB204AfBzdhikoFclxbK4rifwkjWnnqXLPbaTJ5ShA6TgzqoR2WohSKWtpVoukQ14IhHB+aCk8uRAGvYNbhF58tyPMBPS4cyuPPe1eym8jKeYHn0dX1D5mXX7KLkhaKiJ291+/S6EFEfXgtbTpYnIQM2SdZzT/NSbU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(8676002)(508600001)(5660300002)(31686004)(966005)(26005)(6666004)(31696002)(53546011)(66476007)(38100700002)(66556008)(36756003)(8936002)(4326008)(186003)(16576012)(86362001)(83380400001)(316002)(2616005)(956004)(66946007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHVPRG5VZG1QZVhITzIzOThrVWY0cTBWQ1c5QkRkb3huWk1qektRSmlYbE0y?=
 =?utf-8?B?WFpnclNRUjYzRkw5NnVOV2VzQ2ZMTWlqN2dkbklkSUZpSUVTQ2pKZkNQS2Ix?=
 =?utf-8?B?TmFEYmZaVVQ5bk0vUTg5enlKRWd4YzMzUGZ2UWlUdU9hUzJ1TlFQQWQvRmxp?=
 =?utf-8?B?cjU5NW9ibzJpenlGRHcvYzh4bVgxWkxCa0U2N1c4ZWFVUE9yRzJGaWlCL2FB?=
 =?utf-8?B?a0RYN0NsZlhCQU1ic2tsMzY1dklpejQzZWVmQ0dIc2o1MzRld0VXdm5XTG5T?=
 =?utf-8?B?M3d0Q2hoUy9KclZKYW9XK29YenY2V1dzT0ZOUit0VnBSWDJqdUxmVDNvb3Qv?=
 =?utf-8?B?ZThiZ0NMaU1ZNUdjZTlxUU5RMGlKY0xla091OWZlOGs2Z3VyQTZQcFpQK2JE?=
 =?utf-8?B?U3JOMTZJc3FBMmdRSmt4TjZTdytNWGlNVlpaRlQ1WEdNRzRjRXlMcm1hSDA0?=
 =?utf-8?B?SUxzSG83VzYxYTFtUWhHUWNQQzJ5WmNYZEluaEw0M3p1Yy9hMldYdzJsQnU2?=
 =?utf-8?B?a1BLOVlKTnBXalllZWs5T0ZrUmxlc3pKaWp3SHh3R3Zuc09WaDhYRnFxOTRL?=
 =?utf-8?B?NXNzSDhtN3dTVk5DUWVrZ2VxQW1scEVieVBxS2N5Nnk2d1FxUi9FNGZBcTNX?=
 =?utf-8?B?dFJ2T1RPZjFEQzZTNlNBOTBaVnBIb2xCbUdMMHpFMmZZT2N4T0xzMGprUVZw?=
 =?utf-8?B?NlUyRWVTZWdXbUV0RkJWRnlnSnRwOHVjRS9xcDVZdmtTQmxBNUFaRG1nRTYr?=
 =?utf-8?B?aDZJajNKYW9hRFRuUkkvRDZ6L1pxWGdLVmtOaGlYa2hsZFlDeEc0Z0J6Zity?=
 =?utf-8?B?eXBUMXNXQkpiNjJGTE5VclNFelpPQkpWbjA0Y1JkTTltd0Y1alRsU2ZBeXRL?=
 =?utf-8?B?TC9SVElGZ0ViWFd4ZlBQQ3hxU3Z5eXRVUFNIc1BVQzdvTS8zc3R4Q2JwQjhL?=
 =?utf-8?B?VnBMRlBVNnIzaks5b3M1ZDhBMmFPWXd1Y2R2dktuc2Jkd1dmSjNwdFVZWjFu?=
 =?utf-8?B?TnpaSncydkcvMWY0T25ROUJzTHphLzAzZVRtTzhSUHh1cVdDeUNSQi9MT0NW?=
 =?utf-8?B?dE5RajQvOEtXcHZBZWRJQWJrZzIzdVovY3A3UXpDd011ZnBTbnZJWTBTczlp?=
 =?utf-8?B?NGpjOU5KYnNiLzc1Y2I1WjE0WXUxUzdIVHBCbzFKVXJkMkNYNUEzcTE3UCtH?=
 =?utf-8?B?L1N4cklEY2FnazBnYVJQY3NlNG1nOXM3dFdiODZwL1lNSDlTWlJ2S05oeERz?=
 =?utf-8?B?WlpkallLUUtvQXg0cGNjZkFLTDlCbDlybzZJTk9HYWtEcjlleHp3Wm1KeTl1?=
 =?utf-8?B?dFMrcVR5N21wLzd5NGF6bmE1TERpVmxEMDIySHh4RXFZcFFYMUhneEpJVzJB?=
 =?utf-8?B?M21EWjFsMW5TMy9hSWpmcWcrQzR3UVR1bUFBSy9YN0QxSXRXNENEeUgrRkx5?=
 =?utf-8?B?ZkpEM2JRUWI5UEtYRWNybWZBelVnMmtJZUVrRkNhZk1zL1JnUlVUY3ZMekp6?=
 =?utf-8?B?bFoxeEgxbHlrZW5sUityaDlLaEdQVkdkRE9nT1lUemplekFrSWtlM0pvLzlV?=
 =?utf-8?B?QXZjMkJqV1BpSnErNEJIelJUWUZ0MDcvUjhNTlZzaE1GNG5ZNjFZcEp0SUg0?=
 =?utf-8?B?bGJVdGw3Y1poeXczN2JpTTZtNHc1WnpKaUpQWVR6U3UxV0VOV3V2bWxFcDNs?=
 =?utf-8?B?TFltSUQyamY3WHgvT1A3OFhmYTJoNVZ1ek5Wb2xRbnZxWmNFRVM0V3l6NHBQ?=
 =?utf-8?B?R1RYRWg2bytPNktKWlQ5UjJIT2syUHB1b0Q4eEgxdnpsd1d3WWNrRTlCWkxk?=
 =?utf-8?B?WFZxYkNKRmNYdWpMQWxQUC8vVVl6UzRqKzNYSDRFU2hFUVB3S1FIM2UzOFdq?=
 =?utf-8?B?cEVrQUtTZGtjRDFuMTkxQWdrdEJXMFJyTjFWZlFYMFVGZlV1YzFQS05BcjRj?=
 =?utf-8?B?c296SFdHM0N2UTZhS2J1Q0N1c29ub1ZlUHR3M2dZSTZGbStnZkZqSlpaL3lF?=
 =?utf-8?B?REg1ZmlZQUtaOHk0ZnluSmpkVEVWSEtBNC96ZFN1ZGc3Zld3LzNPdWRLZi9C?=
 =?utf-8?B?aWJtY1EvR1dkQkxYU0pKenBIVEE0MUZJS1VaZzg1ckl1S1RMdXczbGw1UlZl?=
 =?utf-8?Q?2a+c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e53f6c4-7819-4bee-0f32-08d9a7f13372
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 04:34:24.5173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRle/kTNT/Q+CUDFBq1OQLAkoNw3MoOGRTr+JgwzA7TWhjM1pTSyaayC7A4ixGKm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Alexander.Deucher@amd.com, Borislav Petkov <bp@suse.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/15/2021 8:21 AM, Evan Quan wrote:
> Just bail out if the target IP block is already in the desired
> powergate/ungate state. This can avoid some duplicate settings
> which sometimes may cause unexpected issues.
> 
> Link: https://lore.kernel.org/all/YV81vidWQLWvATMM@zn.tnic/
> 
> Change-Id: I66346c69f121df0f5ee20182451313ae4fda2d04
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Tested-by: Borislav Petkov <bp@suse.de>
> --
> v1->v2:
>    - typo fix and add link for the issue referred in commit
>      message(Paul/Boris)
>    - update the data type to uint32_t(Paul)
>    - better Macro naming(Lijo)
> v2->v3:
>    - stick to original logics on handling unmentioned IP blocks(Lijo)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
>   drivers/gpu/drm/amd/include/amd_shared.h   |  3 ++-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 10 ++++++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  8 ++++++++
>   4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0bd90ec9e43e..fca592394fa1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3508,6 +3508,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
>   	}
>   
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> +		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
> +
>   	adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
>   	if (adev->rmmio == NULL) {
>   		return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index f1a46d16f7ea..4b9e68a79f06 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -98,7 +98,8 @@ enum amd_ip_block_type {
>   	AMD_IP_BLOCK_TYPE_ACP,
>   	AMD_IP_BLOCK_TYPE_VCN,
>   	AMD_IP_BLOCK_TYPE_MES,
> -	AMD_IP_BLOCK_TYPE_JPEG
> +	AMD_IP_BLOCK_TYPE_JPEG,
> +	AMD_IP_BLOCK_TYPE_NUM,
>   };
>   
>   enum amd_clockgating_state {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 03581d5b1836..08362d506534 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -927,6 +927,13 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>   {
>   	int ret = 0;
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
> +
> +	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state) {
> +		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
> +				block_type, gate ? "gate" : "ungate");
> +		return 0;
> +	}
>   
>   	switch (block_type) {
>   	case AMD_IP_BLOCK_TYPE_UVD:
> @@ -979,6 +986,9 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>   		break;
>   	}
>   
> +	if (!ret)
> +		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
> +

Once the default case is skipped, this will set the state for unhandled 
blocks. Should be fine if such blocks are not expected. Otherwise, just 
return 0 such that they hold unknown power states.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 98f1b3d8c1d5..16e3f72d31b9 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -417,6 +417,12 @@ struct amdgpu_dpm {
>   	enum amd_dpm_forced_level forced_level;
>   };
>   
> +enum ip_power_state {
> +	POWER_STATE_UNKNOWN,
> +	POWER_STATE_ON,
> +	POWER_STATE_OFF,
> +};
> +
>   struct amdgpu_pm {
>   	struct mutex		mutex;
>   	u32                     current_sclk;
> @@ -452,6 +458,8 @@ struct amdgpu_pm {
>   	struct i2c_adapter smu_i2c;
>   	struct mutex		smu_i2c_mutex;
>   	struct list_head	pm_attr_list;
> +
> +	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
>   };
>   
>   #define R600_SSTU_DFLT                               0
> 

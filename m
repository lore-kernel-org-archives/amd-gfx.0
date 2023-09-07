Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A62DEC8758
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 20:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00FFC10E249;
	Thu,  7 Sep 2023 20:55:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82BC10E249
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 20:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBfMa7Z9e39bA+E5luv6RH1igSYwmUF1QcaUisx/90x9RaQA5TI21FIghMti1JSyCY8LAuchs3iAF3P8V3lbVj98lNl3BMbVv013u9G0bmuN1OOsAs1XghcGS4hSpTF199G6fDDidzLWNLk3cl5N+bgSimPFmxjlObuoFbCTibJtR4fPXdCnGd9tC3wACa1hn+AuG/SgQuJ4wgXyeWe6JCm7ecsPQoqhhsLvBQPF0YFam8iGl8VlaIIvDLRUSGlpEni0YZ0NoiPUWKTOBAFKI+T1hfB/fjRxyJku/Gbh9W8bSVbwrpCzw5GP5R/98qXK/1b9XGYWEBsjQS/RtohOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecnPJaC8j5CXAlCVSihBmY1aRIwW2ENK7zALYNm1qME=;
 b=Zlk7n9xZHtfoCHJsj7mpFSwl3EWneaMO7uARWBYFWszgshBM+pSTvEEwRZZ7nYG20tB17Kl1aQuhDuh9xVqLblTaYiulC7F3L9DNnDGrUgmJ0nSZrXveVFUjBFnPPzzpqpMFs5dgXLqSHYaYoxzt4USATMrh2L6xRIRol/L4yJuj+irqlyaZq6vFzG89LsM6BwDp+KQ7B8xkW8auk978n7aT7n8BocpoMIIjGj4lGHbjR2ebSSPwemJd/qfRO//KvofYwwD8AXP2UP+hy5mOZHHHuI8I/XEK9cuoWK2l0FH/KfMaQ6DPgOGvobEFEDXx+FJ7vQ2K+ftisUz186NRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecnPJaC8j5CXAlCVSihBmY1aRIwW2ENK7zALYNm1qME=;
 b=wROViPI+Gnxq6YEPBohFUzwz/AbsrpSNET+6+7huFza7qwoln8pDHEb7L1Edtdyt7TPNdvAPIiJpmjVgLRgJz7SlJotFxT+J2bpmycrh4/xOoXZ+mJEMKiTVSUGDFPlrnBLF4BQ7gUjP59t6wCBnTbVcSdzqqmhnIBh8ChGKDeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 20:54:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 20:54:56 +0000
Message-ID: <30c7df1a-6803-67f0-c9db-92026939cf46@amd.com>
Date: Thu, 7 Sep 2023 16:54:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCHv2 3/4] drm/amdkfd: Update CU masking for GFX 9.4.3
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230906154429.216489-1-mukul.joshi@amd.com>
 <20230906154429.216489-3-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230906154429.216489-3-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0191.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 93558c8c-b165-4ad6-38c2-08dbafe4b16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTC7NfmTBxp7tL5aygD+AjxfdpcJR1sMq5U2t7f0lstBcpAh+HPM1D9cApuWPlaMbHQNIJ57llzCSY/dctTgtgQ4O9UWJ4tYaXeAzDkP8Ttaqx46aZkzGetigxwWd9iyYkImSheyD84Z0HqB6g2kXfWn8boqk7Ra44aWXziUOBSDUBPKTDWb50dhwjDX29ORxHK2qOYq32kvjYBfhDiNfV9DUW2AeZTlIja4k2LI0rlanh3D5/DfS0NkcDKGWF7+9+orBbl1xQr0uXA3eBMOG3jG58jsAB5eThMAwd1PXEXH72QhlS87VG0b6uTO8LTu59zdv68BCM7jmI3yNmBOOYeazYna6267z07y5TT5mRKEJ7fGjO1QInUQ/V9Jq7yBNM6fLy6Xa3a/i3HZ6rM33ngJj2+Fu/8NqW9wtWg/xCgaLeITt/AAcPQE1F6ny9Y6JFeg0MnNTynhUp/vFCYr6kJXefBnv7zLlEkJYlU91yYfkQgHVqkWz1qNYWSEsx0zGM9nSN6hxELxbNRfn+eumVi+teZcU6DRa5uCVcUowTCcFx/3ho3RYjPiQY83SGvSrYTNZCX90yeHkt2yfl9Udw023U4nx4+GcfuJ10WbiDTYqDhwDH7iNomtSEBv/GcXOkqCi5QTYTMRTkdZwfnf4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(186009)(451199024)(1800799009)(5660300002)(8676002)(8936002)(41300700001)(66946007)(66556008)(66476007)(44832011)(15650500001)(31686004)(316002)(2906002)(38100700002)(83380400001)(36916002)(53546011)(2616005)(26005)(86362001)(31696002)(6512007)(6506007)(36756003)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZOcngwem0vWGNjb1E2U2JHQVNvUUpLWXRES28wd05XUzFMeE5jS0dDZkxs?=
 =?utf-8?B?bFJmUmcxR1F1cGdCdWo5eWM0UEhnKzIxV09lWlpyeWtPM3paeW9IYitIQlpJ?=
 =?utf-8?B?RFZaWXBiSW92WTdwcEtrNFlHU1psVTVoWUNYVWdSNUdxdVJCajFQYVMyNEth?=
 =?utf-8?B?OGxvQ1RDWmd2eTNld3pIeVZtTTdXQzVUYUFpMEtYT3dCUkxuN0ZuaWNNVnha?=
 =?utf-8?B?b2xPLzlVK05Qa29tV2NDakYvckFYRWV4eW55Q0RYcHJhL1BoNXpXT3NFZ1Bv?=
 =?utf-8?B?L0RXYmxJTGdsdUpVQUw3RjZDc1R2STlLeDd4aGlpRlVuNmdDbDliUTFsNXdH?=
 =?utf-8?B?MFYxM1Z4cTlXUW5EQjZmQzFwWmdvSVdvMXB0cEQzWWEzRUswcFVyWDdoVm5X?=
 =?utf-8?B?aytpTFFFNllGUTFFVXduNEU3Q3ZETWFOdGJQL05DVG5OTWErcFdwV3RoSlBX?=
 =?utf-8?B?bTdUQjNUZ2YyS25kZGE1bmFwY2lGdCtMdFRMMjdrQlo0T3YrWWkrTVdSWmZu?=
 =?utf-8?B?cEdYb1lrU05OZEo4NWcvTGFkU3FSNWlrRVdLSmh5V3BKL3ZJV3E3UGZyU29U?=
 =?utf-8?B?YnBrRDhEc0djdDQ4S2ludDBnYzUzK3RMOHVab2JLeEUrZ3dFNC8xUnpOeE1u?=
 =?utf-8?B?TWhVZXBXYW01NU1HNGk2R08xSFJvOFl1OEhNKzhzeS81SmRObFdtbDdORWkz?=
 =?utf-8?B?aHI5cVdWekIwek5RL1R2M01CeVNpTEJKeFU2U2VoZ2FDMnZDQlEyQUdTcnBI?=
 =?utf-8?B?U2E0cks5N2N1b1ZLWkM0QVFJS2x2UUN2VWZvS1R1RGNkeUxWNk1naDZwTWtq?=
 =?utf-8?B?NFR4VnY2enUvYktzQ1J4UGVrVkl6ck5DaGZib3lBdTRqMVYwSll6MnVTVlRp?=
 =?utf-8?B?K3Q4ZUsxTnRVc0RmbUhJSHZEcFpDT2ptaGJGZFVVdmJyd3lzOURHTWlvUzc4?=
 =?utf-8?B?WkRMcTJ2U093d3FyZ0ZMNkw5Z3o3VFlNN2NtcklXVVhnalhKSDV0bVhrd3lH?=
 =?utf-8?B?bGl3TU1GU1QzUWJOeDdWWlFvQXN4TFdxcjFjTVhjOTZWNUIvSlNmMmVjZTZy?=
 =?utf-8?B?eUp0YVY5S29DOXNtc0wxSTUvTjFPVjdodTdWemFXcWtEaTRXa2xMbmlNWlVP?=
 =?utf-8?B?N3VoV2hhemFtWkJWMHlzWHlxdFJ2K0ZNazVRQnBWMWxWbTlNbVpZNDl0bEdO?=
 =?utf-8?B?dFQ0MmF6QVRUNE1Rci92eml3anU5TTNZNXJqaWNsaFp2QTVFWlFIRVlxWUJL?=
 =?utf-8?B?eGYzNVZ6OXBEWlRaVDRxQklWSFVURVJnN1kzU3ZhbitXak0xZSt5Z1FqN2Yw?=
 =?utf-8?B?cS9hY25zOURIT1NzOVduMnQ3T2ZxUmtMSktPU3grNGhBUGhUWGRRRUxkRlNG?=
 =?utf-8?B?RFFFa1dHMXVjU09KdC9pQkRycTVhMTJYSHN5dEgzNGVMaEtoM3lwWHhpTGtz?=
 =?utf-8?B?VENKcTREMkFvQTZ0NStmQ1crblNsUW1NbHplREdpUzRYNWc3a2VqRzNtcnBv?=
 =?utf-8?B?bFpoSVBodkJpbWxnakdrN09XY2xOQmk3VXNnMWFyQytOOVBTVkt3Q0RjNHJZ?=
 =?utf-8?B?ZytWbmEvWWJ0UndiK3NCTkJYUDhYMnNsN050ckg5SDRvZkVZVDdYbENSQnBE?=
 =?utf-8?B?ODhjNnpwWjA5T2VhQlpBY0ZQeXdzWnliOStRS1R4ck9LRkczM2JvVlBwU25R?=
 =?utf-8?B?TENXR2tXUXJLVmphVkU1VjZmVEFlRlpnTzRFYjVUajVMK2Vlc3hIUTBuTERN?=
 =?utf-8?B?NHdVR2lEQlhvL1p1SUdRRFc5bnRXQTlSeURHdFAwWWJLanF2ZGp5RWg3UVVj?=
 =?utf-8?B?UVp2NnRtS2hHYnZmb3hJNUxBRmlyOHljUFJCa2xKZmlDK0JOOHhYNjc1Y1FF?=
 =?utf-8?B?NStBM0dRc0xmdzV0SkdWa3hkY0Z1bmNpOWZ3dGQxOEU0RHVJMGQ1ekFTQlMx?=
 =?utf-8?B?RUtERko4dFN6a1NGeXphZW9ndmtwVGJSZUhTajdzSzd1T2MyWnBJSmZoZkNj?=
 =?utf-8?B?MDJHcW1uMDJNL0ZGcElpWW96SFJhSEZLMi94OFAxU3RDM2M3clk5bDlRcWVv?=
 =?utf-8?B?NHJVcVd3UnJIVnFLN2Q4N2xjRzUrcXpROFpZQzB2L3pCSVpiUUcwbytiTHVF?=
 =?utf-8?Q?nNNCNAKIqhQ1VTribHIinbRf0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93558c8c-b165-4ad6-38c2-08dbafe4b16b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:54:56.8915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8PVZ9IlLox7Zi7xL5a+o+53p2DQYrTKYz1o03wB6zXA70hOi9ZSBFnGRbqJqgrZ/KV67b/346QmKcPPnIcrvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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

On 2023-09-06 11:44, Mukul Joshi wrote:
> The CU mask passed from user-space will change based on
> different spatial partitioning mode. As a result, update
> CU masking code for GFX9.4.3 to work for all partitioning
> modes.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
> v1->v2:
> - Incorporate Felix's review comments.
>
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 28 ++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 46 ++++++++++++-------
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  2 +-
>   7 files changed, 56 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 763966236658..447829c22295 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -97,14 +97,16 @@ void free_mqd_hiq_sdma(struct mqd_manager *mm, void *mqd,
>   
>   void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   		const uint32_t *cu_mask, uint32_t cu_mask_count,
> -		uint32_t *se_mask)
> +		uint32_t *se_mask, uint32_t inst)
>   {
>   	struct kfd_cu_info cu_info;
>   	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
>   	bool wgp_mode_req = KFD_GC_VERSION(mm->dev) >= IP_VERSION(10, 0, 0);
>   	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
> -	int i, se, sh, cu, cu_bitmap_sh_mul, inc = wgp_mode_req ? 2 : 1;
> +	int i, se, sh, cu, cu_bitmap_sh_mul, cu_inc = wgp_mode_req ? 2 : 1;
>   	uint32_t cu_active_per_node;
> +	int inc = cu_inc * NUM_XCC(mm->dev->xcc_mask);
> +	int xcc_inst = inst + ffs(mm->dev->xcc_mask) - 1;
>   
>   	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
>   
> @@ -143,7 +145,8 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   	for (se = 0; se < cu_info.num_shader_engines; se++)
>   		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
>   			cu_per_sh[se][sh] = hweight32(
> -				cu_info.cu_bitmap[0][se % 4][sh + (se / 4) * cu_bitmap_sh_mul]);
> +				cu_info.cu_bitmap[xcc_inst][se % 4][sh + (se / 4) *
> +				cu_bitmap_sh_mul]);
>   
>   	/* Symmetrically map cu_mask to all SEs & SHs:
>   	 * se_mask programs up to 2 SH in the upper and lower 16 bits.
> @@ -166,20 +169,33 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   	 * cu_mask[0] bit8 -> se_mask[0] bit1 (SE0,SH0,CU1)
>   	 * ...
>   	 *
> +	 * For GFX 9.4.3, the following code only looks at a
> +	 * subset of the cu_mask corresponding to the inst parameter.
> +	 * If we have n XCCs under one GPU node
> +	 * cu_mask[0] bit0 -> XCC0 se_mask[0] bit0 (XCC0,SE0,SH0,CU0)
> +	 * cu_mask[0] bit1 -> XCC1 se_mask[0] bit0 (XCC1,SE0,SH0,CU0)
> +	 * ..
> +	 * cu_mask[0] bitn -> XCCn se_mask[0] bit0 (XCCn,SE0,SH0,CU0)
> +	 * cu_mask[0] bit n+1 -> XCC0 se_mask[1] bit0 (XCC0,SE1,SH0,CU0)
> +	 *
> +	 * For example, if there are 6 XCCs under 1 KFD node, this code
> +	 * running for each inst, will look at the bits as:
> +	 * inst, inst + 6, inst + 12...
> +	 *
>   	 * First ensure all CUs are disabled, then enable user specified CUs.
>   	 */
>   	for (i = 0; i < cu_info.num_shader_engines; i++)
>   		se_mask[i] = 0;
>   
> -	i = 0;
> -	for (cu = 0; cu < 16; cu += inc) {
> +	i = inst;
> +	for (cu = 0; cu < 16; cu += cu_inc) {
>   		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
>   			for (se = 0; se < cu_info.num_shader_engines; se++) {
>   				if (cu_per_sh[se][sh] > cu) {
>   					if (cu_mask[i / 32] & (en_mask << (i % 32)))
>   						se_mask[se] |= en_mask << (cu + sh * 16);
>   					i += inc;
> -					if (i == cu_mask_count)
> +					if (i >= cu_mask_count)
>   						return;
>   				}
>   			}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index 23158db7da03..57bf5e513f4d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -138,7 +138,7 @@ void free_mqd_hiq_sdma(struct mqd_manager *mm, void *mqd,
>   
>   void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   		const uint32_t *cu_mask, uint32_t cu_mask_count,
> -		uint32_t *se_mask);
> +		uint32_t *se_mask, uint32_t inst);
>   
>   int kfd_hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
>   		uint32_t pipe_id, uint32_t queue_id,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> index ee1d32d957f2..1a4a69943c71 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> @@ -52,7 +52,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   		return;
>   
>   	mqd_symmetrically_map_cu_mask(mm,
> -		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
> +		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, 0);
>   
>   	m = get_mqd(mqd);
>   	m->compute_static_thread_mgmt_se0 = se_mask[0];
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 83699392c808..8b7fed913526 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -52,7 +52,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   		return;
>   
>   	mqd_symmetrically_map_cu_mask(mm,
> -		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
> +		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, 0);
>   
>   	m = get_mqd(mqd);
>   	m->compute_static_thread_mgmt_se0 = se_mask[0];
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 0bbf0edbabd4..964b5d50a77e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -71,7 +71,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   	}
>   
>   	mqd_symmetrically_map_cu_mask(mm,
> -		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
> +		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, 0);
>   
>   	m->compute_static_thread_mgmt_se0 = se_mask[0];
>   	m->compute_static_thread_mgmt_se1 = se_mask[1];
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index e23d32f35607..42d881809dc7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -60,7 +60,7 @@ static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
>   }
>   
>   static void update_cu_mask(struct mqd_manager *mm, void *mqd,
> -			struct mqd_update_info *minfo)
> +			struct mqd_update_info *minfo, uint32_t inst)
>   {
>   	struct v9_mqd *m;
>   	uint32_t se_mask[KFD_MAX_NUM_SE] = {0};
> @@ -69,27 +69,36 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   		return;
>   
>   	mqd_symmetrically_map_cu_mask(mm,
> -		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
> +		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, inst);
>   
>   	m = get_mqd(mqd);
> +
>   	m->compute_static_thread_mgmt_se0 = se_mask[0];
>   	m->compute_static_thread_mgmt_se1 = se_mask[1];
>   	m->compute_static_thread_mgmt_se2 = se_mask[2];
>   	m->compute_static_thread_mgmt_se3 = se_mask[3];
> -	m->compute_static_thread_mgmt_se4 = se_mask[4];
> -	m->compute_static_thread_mgmt_se5 = se_mask[5];
> -	m->compute_static_thread_mgmt_se6 = se_mask[6];
> -	m->compute_static_thread_mgmt_se7 = se_mask[7];
> -
> -	pr_debug("update cu mask to %#x %#x %#x %#x %#x %#x %#x %#x\n",
> -		m->compute_static_thread_mgmt_se0,
> -		m->compute_static_thread_mgmt_se1,
> -		m->compute_static_thread_mgmt_se2,
> -		m->compute_static_thread_mgmt_se3,
> -		m->compute_static_thread_mgmt_se4,
> -		m->compute_static_thread_mgmt_se5,
> -		m->compute_static_thread_mgmt_se6,
> -		m->compute_static_thread_mgmt_se7);
> +	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3)) {
> +		m->compute_static_thread_mgmt_se4 = se_mask[4];
> +		m->compute_static_thread_mgmt_se5 = se_mask[5];
> +		m->compute_static_thread_mgmt_se6 = se_mask[6];
> +		m->compute_static_thread_mgmt_se7 = se_mask[7];
> +
> +		pr_debug("update cu mask to %#x %#x %#x %#x %#x %#x %#x %#x\n",
> +			m->compute_static_thread_mgmt_se0,
> +			m->compute_static_thread_mgmt_se1,
> +			m->compute_static_thread_mgmt_se2,
> +			m->compute_static_thread_mgmt_se3,
> +			m->compute_static_thread_mgmt_se4,
> +			m->compute_static_thread_mgmt_se5,
> +			m->compute_static_thread_mgmt_se6,
> +			m->compute_static_thread_mgmt_se7);
> +	} else {
> +		pr_debug("inst: %u, update cu mask to %#x %#x %#x %#x\n",
> +			inst, m->compute_static_thread_mgmt_se0,
> +			m->compute_static_thread_mgmt_se1,
> +			m->compute_static_thread_mgmt_se2,
> +			m->compute_static_thread_mgmt_se3);
> +	}
>   }
>   
>   static void set_priority(struct v9_mqd *m, struct queue_properties *q)
> @@ -290,7 +299,8 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   	if (mm->dev->kfd->cwsr_enabled && q->ctx_save_restore_area_address)
>   		m->cp_hqd_ctx_save_control = 0;
>   
> -	update_cu_mask(mm, mqd, minfo);
> +	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3))
> +		update_cu_mask(mm, mqd, minfo, 0);
>   	set_priority(m, q);
>   
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
> @@ -676,6 +686,8 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   		m = get_mqd(mqd + size * xcc);
>   		update_mqd(mm, m, q, minfo);
>   
> +		update_cu_mask(mm, mqd, minfo, xcc);
> +
>   		if (q->format == KFD_QUEUE_FORMAT_AQL) {
>   			switch (xcc) {
>   			case 0:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index 657c37822980..3e1a574d4ea6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -55,7 +55,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   		return;
>   
>   	mqd_symmetrically_map_cu_mask(mm,
> -		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
> +		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, 0);
>   
>   	m = get_mqd(mqd);
>   	m->compute_static_thread_mgmt_se0 = se_mask[0];

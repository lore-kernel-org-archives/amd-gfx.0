Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7545C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 17:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6174210E1D9;
	Wed, 17 May 2023 17:30:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7FC10E1D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 17:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2UbqLmGdzXGK/kdPQh448L1s1hzrK6QAvSJq8Qb7x6zsrdbADnyHBQNP7gUmibrOyhJJCwzfdZ4GBQ9FQn21HGqSW/31PuGqtLwvF7oxilbA8ZRzS8p7G+9iZb7Hy4JZEiMSV+8y61cREDIeTSwBNtjT61w/p24yaiXNAYTeeju1OzI0IW3Kev/KzYguNMTjAnLa8qLcYOmRfPakwmxtjGFL8/s4gVnfHbaEugk+kHH6RCMeu/o5JKlcYNnOiGd8gUW8mdj1XbIX3JZbhN+NFyv1csFaW/MTpn87Q7a9QG6j74MQASEAZCG56AyWIT1L/40uuoXeampj+0IUV2A/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq5RPEHCcxXgMS9W5XPYhdCLHMp+ruP5jK2scnhQuGc=;
 b=QWczNxwq9Ri977BalRWuZzcGgnYcdkqUqLOI28OrpB5pY2MVIkttXgoqJwu1XmGKwNI+hf2gbNbuVQj/Rl2rCwtFhce6pce+M4RsZq6/G69Nkon9M+63Ljz8ts1Ys3AQgptUyxQbHSZvToL0zihqP04oyWXSQTyf4Clq+QPgZKqWJKQOGeN3AQE3iO6WyHI9z17U01NpPmz2V00U8gtxFa7MbHl0iuxSYVVqPGFWKUfTZ/L/drPSRq761AgGznXyNNi4RGb97ko9pVC4cDwf40jYKZUhlierNYnk3CU33JMR9NV7EpylaYqKcxpgBRqO2cuzuCM9f9vvzkKxJAV3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq5RPEHCcxXgMS9W5XPYhdCLHMp+ruP5jK2scnhQuGc=;
 b=hKB6BpICsj8N5zpaWBdZNzpHhDBg9UGm9/hDAc/2J1hwh/P1G7fL5H7/lQK0b1tVaVGs1AFy6bd50o95vT8p7rlXQLcKHOme7tiLZuqNEIQipAAzzAg36KNYt5qw1tejB5CaXImKFDtPsBwH8KY0Nd2pB8UCxRvephJzNlYcl4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 17:30:40 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b59e:105c:f546:4310]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b59e:105c:f546:4310%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 17:30:39 +0000
Message-ID: <2f54afc9-66ba-21c3-9537-79a59c77a935@amd.com>
Date: Wed, 17 May 2023 13:30:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix errors & warnings in amdgpu_vcn.c
Content-Language: en-CA, en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230517151346.2357528-1-srinivasan.shanmugam@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230517151346.2357528-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::9) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 575a6ef2-75ec-4a70-f029-08db56fc6ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5aqQew0P5eTVic9jQm71Qr/y34q4PQTZK1jDGIyPmbPe+ofjsGjTtVD8txfym03E8b0njjXf9VwF97P/6KPLqNry1ZbtYfZkdql60+oAV0ayjkUXJXf8zOUZF7e3Lix+MvI4EzccwFO7Le6+zmiXavt/v8t1y6C0D6urcOQgRe2uGZPQKmFQ60P8AWwJZ1kBzcbE2DWgLszB1GjowvrN6xxR/4V0oJy/zv4LDrQjHqk9ndK4z/m8zR0ifymVsgbzrL82ufbJmHhZip2wwT1tfiMMV/wxnAlgWBGBgl7uxa5ywvx6BI1NTrUhEO4kokwOVkXzHEHGGGSVEduW0CC4lyof27bt42sBbnVpvJLI8fVLQaHrr4K0vMvITCA6FJ5/9pEUvuFcDKB0bTxiDDPWdsE/zaxvWBdQs0s2PuaMYbotvY5CgL43JDx4LxHsjZoNiIb7YUNoIKpjK/Ws0mN1EH24mzfwqgQ7zMGr+l7S3IPsAzeitgozh3uPY0gKHYdPTQUZyjhs19XwQRR6S60DOn37lHP1vD1gORBdKtDrW++8IAnkJ3a1DqaoRR7VgoKsjEJwX9WEZ6+ByHpnlXPSZEsqDEfPt4yc+y0MdmmClfYiIxPgffJmOJg1eQSfMXZH3Js7J1c61Va+GNNQ+tejg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199021)(36756003)(6486002)(4326008)(110136005)(6636002)(86362001)(316002)(66946007)(66476007)(66556008)(478600001)(5660300002)(41300700001)(8676002)(44832011)(2906002)(8936002)(31696002)(38100700002)(6512007)(26005)(186003)(6506007)(53546011)(83380400001)(66574015)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUhWd2RhZGJQZHIvU1UrZFYraFZtblhNS1dZYUFGS1IySUZUUWFCVUg2N0p3?=
 =?utf-8?B?Sm1GTlBQRDR4YTM2K2dkZHR6S1dMNzBoTWVMbHdsOVg5M0V3SThtOEFReDFo?=
 =?utf-8?B?Rk4zUURrRnk4UnFWbU4vVS9DbSt1UVBOeDVDNmJTcFFSbWl3NHh3VFRJYzB6?=
 =?utf-8?B?RnZuTUJoQ1EwcXR5b21RSjVSOFhiMlR6T3dqeTUrRmlXZzVxR29TNjF6dmZJ?=
 =?utf-8?B?YzZRbEY3UnlxWUgzbzFQM3BtVTVCeDRFVkc4b3hKVjlrbzBCeEl4V2pxcjNY?=
 =?utf-8?B?a3VISkplaHZseld3aG1zUHVvcDJ5a3A3RHd4MnNnaXk4ZDFKVEk1dm93bXJ1?=
 =?utf-8?B?a2xKb3VwQUFOSDVlNGNvZ2xvWE1jaFB2SFFueitKMm5nNmZ1RUtVTVdobURo?=
 =?utf-8?B?eVhkRjRrYythUEYzam03czRmd3B1NHp3RjdHa3NwSitvMGFzSFI2MEhLUFUz?=
 =?utf-8?B?bEp5djAwTy9yRjNnK3J3RFNKaFBBTWc3ZWFzR3JuMXUvd05oMHNISmpFYTFF?=
 =?utf-8?B?RlVwc2hSZmI1d2JwOWR4eTR4dk41K2d1TnlmYUlISmlkU3U4SzNCV1lEVFhp?=
 =?utf-8?B?Y0JQZWtTbEtrd2dLaFk3eTl6eG1FOFBjZkpaOUJGSkRWdGRLYzJLYTBVcGlR?=
 =?utf-8?B?d2xtTHR4UG5xbGczOE1JZnJpTFhnbUZQcCsrRzRmZis1UzR3RjZOZlVweFRa?=
 =?utf-8?B?L1pPSUJobWsyMnMzUDBDSDZ4dzY2WkVWMGJIZVdFWnFSMFBWRFRHTVh4SW5F?=
 =?utf-8?B?ZkZXaDlYT3hmUjNISWd0dGM5QkI3eFZ2bXhCQzY5OWxVTWp6OXZBbVJ6UHdX?=
 =?utf-8?B?UVk5NmZBM0VKa0FOOGczbGwzbS9yV2x5eksxQlNick42anNZenR1bHpBcjJT?=
 =?utf-8?B?Vk15TXZSOTdVZ05RMlh6RmdVL1EyUzVIUnZ0S3pSOC9HeVNIME1wNG5VY3ly?=
 =?utf-8?B?bVpNcXMrQWhPK3dadUt0UDZIQ3o4WlZWOGF2a2NWSzZubXkxRzRtdWZZQVk0?=
 =?utf-8?B?cStFUEY5d05YVEx2REpEbTRIeGRnVUIveko4OFdDcmFIWHF3UkxUalhSdXBQ?=
 =?utf-8?B?bkJwRFEzMVpYT0x0Ujd3YnV6QUxROVRzenlxOW80Z3Y1UEJWL0pwWGd3TlRs?=
 =?utf-8?B?QmxSWDdhZXIxUzZ5OFFmcFJRYVNwYzdZYlBQTVN4a3hwL040dXZSMWNVNG9D?=
 =?utf-8?B?WWpxU0p6aTczd3dwc01MT0owa1pzdWhXZENsbnIxN2t2dFVHMHhXeXo4SzZN?=
 =?utf-8?B?cUpNUlFLMm1xV1lSQXdiM3JLMEdxeG9MdUlvQ28yaCtWS0pjYzRzc2NUZ3o5?=
 =?utf-8?B?YWtWcmNzamdWbERmMFNpQ0VEL3I0UTJNMHRFeS8xRGpuZnhXSjJaNllyZVNS?=
 =?utf-8?B?N3FoMDZ5eVhncURrSjVseUd0NWxsNEEwWHdEZ1RXTUNvMHRCSkE5ZC9OTjQ3?=
 =?utf-8?B?UERmNitqc29VdHkzaW5tck8yLzhZOXZxaDVOT0l6WnRvd1MyazZKM05LOHVk?=
 =?utf-8?B?Ym1JaExENTNLS1hGb1FlWkFIMHd2V0JMSktUZXlTVmJ0dWlpbkxDZlRXUVl1?=
 =?utf-8?B?aG5kb2RNM1Q4RFFZUEFtOCtWd2ZxallPc1ZVNzZOZS94MVBNVWFENmhVL29h?=
 =?utf-8?B?RUZBQnVDZUF3b1oxa2JkSHpBRWlIM3JhMnV4aHNFS3NFZXVhcGU5TDVYV2oz?=
 =?utf-8?B?TnUzOWF2bUVkOHZMVGNzcGh1VW0xdHp0azEvZEtxVVhNNWNRa1BpZi80M3Y5?=
 =?utf-8?B?NUQ5cEpuMVJNVjZrNWFJRkFsRk9za2VjMXZqQzQrZWM4SlYzQWFMSU12WXBY?=
 =?utf-8?B?U0h5aG9xOHduYmozVVBLb2xyKyswb1RmWXJtUlNob2p3S3V5T1IzNXFSUk1Q?=
 =?utf-8?B?WDdGck1sRksrMDFQbkkrYVpFWURPNU9RU3pnb1E1dW01NGUxUy9WQ0NiMVlt?=
 =?utf-8?B?WUtUb1FQM1VYRkQ5cTlDWHpmT0pkVnhUU0R3RWxVdW9jNEpxMFNiZzZYcTVz?=
 =?utf-8?B?NkhMYkNRdTRKTWRvaVo5NW4rWkFpTUJtV3FvVEh4THBZdDFFSjh0bFhQUzhG?=
 =?utf-8?B?Y0tFTWhzTWJqQm1YOEN6b2JHZnFteHZmcllGR2Zpa0tSWjhhaG9zVDRQMjZa?=
 =?utf-8?Q?MDw0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575a6ef2-75ec-4a70-f029-08db56fc6ec9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:30:39.5221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1uS5Qvg3XzeqHA+x73nE+Qxn9zaQ6qXKwY9mbwPZgJ+6nD1VAJuzRJGU6QkwhF0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-05-17 11:13, Srinivasan Shanmugam wrote:
> Fix below checkpatch insisted error & warnings:
> 
> ERROR: space required before the open brace '{'
> WARNING: braces {} are not necessary for any arm of this statement
> +       if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
> [...]
> +       } else if ((type == VCN_DECODE_RING) && (vcn_config & VCN_BLOCK_DECODE_DISABLE_MASK)) {
> [...]
> +       } else if ((type == VCN_UNIFIED_RING) && (vcn_config & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
> [...]
> ERROR: code indent should use tabs where possible
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: braces {} are not necessary for single statement blocks
> +               for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +                       fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
> +
> ERROR: space required before the open parenthesis '('
> WARNING: Missing a blank line after declarations
> WARNING: please, no spaces at the start of a line
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 35 ++++++++++++-------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 06ec2dc55857..c088111c2321 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -169,7 +169,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>  	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
>  		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
>  
> -	if (adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0)){
> +	if (adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0)) {
>  		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
>  		log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
>  	} else {
> @@ -276,20 +276,19 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
>  	bool ret = false;
>  	int vcn_config = adev->vcn.vcn_config[vcn_instance];
>  
> -	if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
> +	if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK))
>  		ret = true;
> -	} else if ((type == VCN_DECODE_RING) && (vcn_config & VCN_BLOCK_DECODE_DISABLE_MASK)) {
> +	else if ((type == VCN_DECODE_RING) && (vcn_config & VCN_BLOCK_DECODE_DISABLE_MASK))
>  		ret = true;
> -	} else if ((type == VCN_UNIFIED_RING) && (vcn_config & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
> +	else if ((type == VCN_UNIFIED_RING) && (vcn_config & VCN_BLOCK_QUEUE_DISABLE_MASK))
>  		ret = true;
> -	}
>  
>  	return ret;
>  }
>  
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>  {
> -	unsigned size;
> +	unsigned int size;
>  	void *ptr;
>  	int i, idx;
>  
> @@ -318,7 +317,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>  
>  int amdgpu_vcn_resume(struct amdgpu_device *adev)
>  {
> -	unsigned size;
> +	unsigned int size;
>  	void *ptr;
>  	int i, idx;
>  
> @@ -340,7 +339,7 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>  			adev->vcn.inst[i].saved_bo = NULL;
>  		} else {
>  			const struct common_firmware_header *hdr;
> -			unsigned offset;
> +			unsigned int offset;
>  
>  			hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
>  			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> @@ -371,9 +370,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  		if (adev->vcn.harvest_config & (1 << j))
>  			continue;
>  
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
>  			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
> -		}
>  
>  		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
>  			struct dpg_pause_state new_state;
> @@ -460,7 +458,7 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	uint32_t tmp = 0;
> -	unsigned i;
> +	unsigned int i;
>  	int r;
>  
>  	/* VCN in SRIOV does not support direct register read/write */
> @@ -797,7 +795,7 @@ int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	uint32_t rptr;
> -	unsigned i;
> +	unsigned int i;
>  	int r;
>  
>  	if (amdgpu_sriov_vf(adev))
> @@ -1012,7 +1010,7 @@ int amdgpu_vcn_unified_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  
>  enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
>  {
> -	switch(ring) {
> +	switch (ring) {
>  	case 0:
>  		return AMDGPU_RING_PRIO_0;
>  	case 1:
> @@ -1031,6 +1029,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
>  
>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>  		const struct common_firmware_header *hdr;
> +
>  		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
>  
>  		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> @@ -1059,7 +1058,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
>   */
>  #if defined(CONFIG_DEBUG_FS)
>  static ssize_t amdgpu_debugfs_vcn_fwlog_read(struct file *f, char __user *buf,
> -                                             size_t size, loff_t *pos)
> +					     size_t size, loff_t *pos)
>  {
>  	struct amdgpu_vcn_inst *vcn;
>  	void *log_buf;
> @@ -1105,7 +1104,7 @@ static ssize_t amdgpu_debugfs_vcn_fwlog_read(struct file *f, char __user *buf,
>  			if (read_pos == AMDGPU_VCNFW_LOG_SIZE)
>  				read_pos = plog->header_size;
>  			if (read_num[i] == copy_to_user((buf + read_bytes),
> -			                                (log_buf + read_pos), read_num[i]))
> +							(log_buf + read_pos), read_num[i]))
>  				return -EFAULT;
>  
>  			read_bytes += read_num[i];
> @@ -1126,7 +1125,7 @@ static const struct file_operations amdgpu_debugfs_vcnfwlog_fops = {
>  #endif
>  
>  void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev, uint8_t i,
> -                                   struct amdgpu_vcn_inst *vcn)
> +				   struct amdgpu_vcn_inst *vcn)
>  {
>  #if defined(CONFIG_DEBUG_FS)
>  	struct drm_minor *minor = adev_to_drm(adev)->primary;
> @@ -1134,7 +1133,7 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev, uint8_t i,
>  	char name[32];
>  
>  	sprintf(name, "amdgpu_vcn_%d_fwlog", i);
> -	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, vcn,
> +	debugfs_create_file_size(name, S_IFREG | 0444, root, vcn,
>  				 &amdgpu_debugfs_vcnfwlog_fops,
>  				 AMDGPU_VCNFW_LOG_SIZE);
>  #endif
> @@ -1148,7 +1147,7 @@ void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn)
>  	uint64_t fw_log_gpu_addr = vcn->fw_shared.gpu_addr + vcn->fw_shared.mem_size;
>  	volatile struct amdgpu_vcn_fwlog *log_buf = fw_log_cpu_addr;
>  	volatile struct amdgpu_fw_shared_fw_logging *fw_log = vcn->fw_shared.cpu_addr
> -                                                         + vcn->fw_shared.log_offset;
> +							 + vcn->fw_shared.log_offset;
>  	*flag |= cpu_to_le32(AMDGPU_VCN_FW_LOGGING_FLAG);
>  	fw_log->is_enabled = 1;
>  	fw_log->addr_lo = cpu_to_le32(fw_log_gpu_addr & 0xFFFFFFFF);


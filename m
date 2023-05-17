Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D79C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 17:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABEA10E228;
	Wed, 17 May 2023 17:38:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA3A10E20C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 17:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWk1DL8L1Cnrzl01rBcU17jb5QpO2x0uq8IZEiVWG9/0xu37oMegVd/dIorw7GCQVP8m8wLh3bYp0+xrvKf1ZpL5gcnn20ngvEAB01XOD6OL8+n5UDDC9TI918EnMllHvNhcjOiEvX1oHFtqvXeLswvSqgqTpPT/g0TLGOkGG7+EEBJvZm5YhEmpzYKF3FkrI2GAIVACHgfuESuqd8iBztQCKteoO2Lyw/XsStIOf6vqChHoXwhTSOK3TSlb4i31IuIXLbK15iKl7nkC6PuM6vnqHlWgZkaHpw/7/iA2m+Zgch2I0Bx80FAvMUgyX41t2bakfHVn6Z3lVVQgtxIJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ocb8S8Hjd7k3OkraOMKZ04YHOd4tfHoD8hw1miC6Hhk=;
 b=d0G3olyLUR91NV74NIZ2G+mvE/QeOVR+vEMTkVWqQ8aX1cYVcen2W7s2uf1FrVhto8NRj35e1ZHVp65yD5/vq38k7oBujd7+3ktTC79aMNt6xe/Rz3j6f/DsBta2KixgxC0iwv9XxiCkWvmTrkWMzbVSjIQ2lxjhFnCwe8b/Zt70eNQFq7U70MrSrZvfYcVYRwc7zQ3qNWCJHKYEw4Ksq8oydpwnp/VsJai9LDPaI3tVCzHvCbCUqS+KokFo4sB5tiOxugLfVidS81Ql/+GfdWct2MHpGmGLIIqWo75dY/SkUt2/FkmJE4jqhS/qr4VtjnzxGto3fphfuaeUm3dQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ocb8S8Hjd7k3OkraOMKZ04YHOd4tfHoD8hw1miC6Hhk=;
 b=veTSKlmChi/ICFCmknvbYqUITgVR33YRXjuMNaZZFMzZtL6iSqimVxwDSG4v7w12so6aMr/DH+A8gSZcnP7V1tPoku5v7CvhORA4TG1/Cakog2Wwxw0fThGo/wxQVDr8iF5tXrYy0QrqGMSE3t/YmFMQL9MzyOzGCkfLy1mPCeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.32; Wed, 17 May 2023 17:38:20 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b59e:105c:f546:4310]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b59e:105c:f546:4310%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 17:38:20 +0000
Message-ID: <1ce11182-8e6d-6c56-39a6-704324dc12ee@amd.com>
Date: Wed, 17 May 2023 13:38:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix errors & warnings in amdgpu _uvd,
 _vce.c
Content-Language: en-CA, en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230517155642.2393980-1-srinivasan.shanmugam@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230517155642.2393980-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::33)
 To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: fafb2bdd-d75f-4ce2-14e7-08db56fd8174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euqUa+uxFWa/yYQ1oM0ad2bzfMlKoP8wgVY2qpyK/x2/zIqiW1AEPR/+HJn1ybGNTiDEm9QGOPFJpQa1q3X7IW3w/eHDzlaE5bEUI3C59hJSUqEMs3dZvNO4yagd1vH6zx1eAahXgDNwvmsU6Qqc9v/+0DCJf4V5nynCnQ1nsf+ofdDi3kUluYqf/TTjTnwvIAPQXhwnYB4mEyRKGHL+OFtHmV42aicZmo5/JuIECH+/Z7ODPzb/WmPkDUtXirpVtjp1I/3lOeOT0TABJISvfJeBLHlwZVXNQy/BKYTMlq7Z91ju+AdUaLcsfSNH8u9HrzD5vKLkipazo8vZg4Qrjwd8rdUXC4Le93kiS+s5G7cqRdtzE5ZIddBPYAXg1kje0k7kQO7U6sYstOxo54zje2Q0m02dqts4VSzAiUDP8zOV7MAAe03QT5UH/sYNF/0RcZOu7SC+kdvA1MqQJxqnOIY7oMLxU8ekHVGvKF9RGn9h70oVIIJ+hjYLe/6M1M9zcVKeJjbfhn36mhYrBmugj5/zAGC3zjCVaKY94kKzEJw9GWCCtGaFeABDsAYxfajXJ4wcfcxB4n+ACJPmFX3cExtYr6E6MFeqrdPrhc4riTZqydmNy/1uKRz3ln9WQMk5ANHcOyogOFX+dUDXUXHyaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(31696002)(36756003)(86362001)(110136005)(66556008)(6636002)(4326008)(66946007)(478600001)(66476007)(316002)(5660300002)(8936002)(44832011)(6666004)(8676002)(30864003)(2906002)(41300700001)(38100700002)(2616005)(26005)(186003)(83380400001)(6512007)(66574015)(6506007)(6486002)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEVRWTBXYmRYRU1SZlFzdkN2WS9lNFhSSUJqUEZkTnA5KzhxWWRMWERCNHJZ?=
 =?utf-8?B?eVBnUU1oNGdsOFlXZFlodHNCNlEwclpDVEJvZEJRTlhvbUlzeEwvbkJmUW5C?=
 =?utf-8?B?ZXNQQStmcjdaZjVkWFlrdFBQaFo4RGRGd2taZFZVMFJZNlhDbjVNUXYzZWFV?=
 =?utf-8?B?cS9GMFFkczN0ME5kbEJEU2NhUWlreEUzWXFBbTlkYVVQNDN1enNuWXZ3V1Ji?=
 =?utf-8?B?b21JNWdoNXlhNyt1SFh1ZlRmSmExNm9ZSjZyRFBQcEo3anhrM3Zaa3M0SUlT?=
 =?utf-8?B?dmZUdENQb0VjV2wxSnZnekMzU0IrdjNOTHhjMStCNTlIK1hUblhrdlgxU0pF?=
 =?utf-8?B?b3paZ2M3eEhLQW5lWU11WVpUSU02dUtmNjZDQVFjMVNrWG1KZHRIS1Fic3U1?=
 =?utf-8?B?WHNCWXlpaGxnZ3VKUWJJR3Y5MFhrMzhpWmg4aFgzM2lOemsvMUo3THZOcEk4?=
 =?utf-8?B?enh4NVpDeTd6MlBEQm9hbTJYRGlFOFByL2MxdGw0SkVRUVlFNTNKTzRDZXNq?=
 =?utf-8?B?U2h6bG9ZVVhqQkNJRjlTUkU5VEVTSG4yOStEc1FqdElTWCtIYnFYMllYbi92?=
 =?utf-8?B?cHdpeVJ5K1RNdmc4NlJyblZRaW9MWEpid2taSDArbEpGekdmNExxeHJxQnNm?=
 =?utf-8?B?M3cwaUhvVTR6VEszVWdvbVNCWEs1RHRDcExtNVRzNTBBSkJoa2VrU1ZzL3g2?=
 =?utf-8?B?bmZsd25SYUpSMDd4UXVTcXYxKzdJY3ZLYXRMdzhrTHhzc1UrdElaNmlQQUdX?=
 =?utf-8?B?MmVqTGxmN205dWxSNHlPN3dlNUlkdzB1OU5TZ01LUHRvdDg2Z2ViM1FXQzBZ?=
 =?utf-8?B?QUpkVFBNNTNTQ1huRUJPUnpSVFEwamFZY3prSGtaRkZJVFk5YkNxYVBUTXl6?=
 =?utf-8?B?b1FWcTdQeG53MEpzNzBQM2U1ZDVGYmpqaTdOUFMwZmNQOExzNUE1VXJzRVBG?=
 =?utf-8?B?YVlvaDRWaWxVNlh2eklYa2JIUFdrbTJ6V2c0L1NLOFVHNW4wSW1HdXBiVXF1?=
 =?utf-8?B?SjVkM210RTlYZW5VNnBld1RlNGlYVEhhaW15SHpjM2U3UzF3d0hXWTVYYkZB?=
 =?utf-8?B?S1VYK1dVYm9HaUliNUZjQkcrSys4R0RCMGIzSFMzeE4xU3BYOExGN3lmQWhW?=
 =?utf-8?B?OUpUbldia3hDN21jT3Nad3UweXd6M1d6ODF5T25rRk1EZVMvalg0eGwwM24z?=
 =?utf-8?B?NVZWa1Azb3BPTDdaQWtKNGxjNURvd1ZvR3lCMFdSZ0VHMktiWWtFMi9FL2tU?=
 =?utf-8?B?cWR6ZzJJUjlWS2VGU3puQlpWbXFHMnRYbklHYkhxdFdqK3JiVDJYWjhUTjZ6?=
 =?utf-8?B?UnpaRTlySmJuV1V2WTZ3dkJmdVRNdDVJWG9KcHo4d2RZdTd5WktZZGlDSzIv?=
 =?utf-8?B?dm1JalVoMVJyVFBLSDBrSE14ZjNhcHo0UFA5SEZQZzVCblU4bnVRWW56Q0FD?=
 =?utf-8?B?aXNGQ05jS1p1bk85QmllMnZ5c3YvTE41Yk0rbG40SGNmbG9XQy80VWVsZEE3?=
 =?utf-8?B?SE50ZWQ4dFJ1WXRhRks0dVJFQm8zVjNIRjFhY1cvQ1luSkFsWEhjRDRGdkov?=
 =?utf-8?B?QmFXbXVsR1VuZ0dCd2ZicUFId2pVU0dGNE9vZjlyTTMvWkxrRzRpc2hYSVpj?=
 =?utf-8?B?M0lGNFV1eG5OSEZra1RmY0lxTnVHTU4ralBXWWxVYTV4Y25kMTBlSHlHSUx5?=
 =?utf-8?B?ZjdyRFF1b2dQL3E5cVZPK1NlZjFCNFBPVFlTYldkZWFUWDEvNHorK0JtZHVq?=
 =?utf-8?B?ZldJdy9SV2xZUnZ2VE5LQWhUTGlzd2FVVGpBVm5wWm4rVUo4QzVqOUV4KzBx?=
 =?utf-8?B?UmczY3hOSEpFNzJKQmFmQVVGZXV5RGJSZnJBd3E2ODA2cURuM2E1aUpmUTNJ?=
 =?utf-8?B?N29OVXRlYUlpYWVKbUkyRlpNem1OTUEvSzZFRmVSbmRjb1A1NWtXNmFCaGhn?=
 =?utf-8?B?WWxBM0NKemliamx1V3UzUnFXZU5lVTFoZzh0aVd5dW1aejgrQ091OG1hVlJY?=
 =?utf-8?B?aDhNaUdKR3o4YkRYVkJFclZQemd1bHZkQ2JReDJOaTlPUEZoaEYyMDZYVUFk?=
 =?utf-8?B?R203eXZkQlk5SjFBek9kNXhTTEJoUmZmVzIvTU1ZSDhWR1hYYUZCcnV0Y2ZZ?=
 =?utf-8?Q?zdwsDwl/PodObGNPC5oDSHRxg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafb2bdd-d75f-4ce2-14e7-08db56fd8174
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:38:20.2802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsBEPtxa2CoulSN/Ozghh/8/fSFN7MrWw/1oNVdgFwfGbhq3VjxFAmyIDBkNW0wt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170
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

On 2023-05-17 11:56, Srinivasan Shanmugam wrote:
> Fix below checkpatch errors & warnings:
> 
> In amdgpu_uvd.c:
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: Prefer 'unsigned int *' to bare use of 'unsigned *'
> WARNING: Missing a blank line after declarations
> WARNING: %Lx is non-standard C, use %llx
> ERROR: space required before the open parenthesis '('
> ERROR: space required before the open brace '{'
> WARNING: %LX is non-standard C, use %llX
> WARNING: Block comments use * on subsequent lines
> +/* multiple fence commands without any stream commands in between can
> +   crash the vcpu so just try to emmit a dummy create/destroy msg to
> 
> WARNING: Block comments use a trailing */ on a separate line
> +   avoid this */
> WARNING: braces {} are not necessary for single statement blocks
> +               for (j = 0; j < adev->uvd.num_enc_rings; ++j) {
> +                       fences += amdgpu_fence_count_emitted(&adev->uvd.inst[i].ring_enc[j]);
> +               }
> 
> In amdgpu_vce.c:
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: Missing a blank line after declarations
> WARNING: %Lx is non-standard C, use %llx
> WARNING: Possible repeated word: 'we'
> ERROR: space required before the open parenthesis '('
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 83 +++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 39 ++++++------
>  2 files changed, 63 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 6887109abb13..b7441654e6fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -96,16 +96,16 @@
>   */
>  struct amdgpu_uvd_cs_ctx {
>  	struct amdgpu_cs_parser *parser;
> -	unsigned reg, count;
> -	unsigned data0, data1;
> -	unsigned idx;
> +	unsigned int reg, count;
> +	unsigned int data0, data1;
> +	unsigned int idx;
>  	struct amdgpu_ib *ib;
>  
>  	/* does the IB has a msg command */
>  	bool has_msg_cmd;
>  
>  	/* minimum buffer sizes */
> -	unsigned *buf_sizes;
> +	unsigned int *buf_sizes;
>  };
>  
>  #ifdef CONFIG_DRM_AMDGPU_SI
> @@ -186,7 +186,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>  	unsigned long bo_size;
>  	const char *fw_name;
>  	const struct common_firmware_header *hdr;
> -	unsigned family_id;
> +	unsigned int family_id;
>  	int i, j, r;
>  
>  	INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
> @@ -275,7 +275,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>  	family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
>  
>  	if (adev->asic_type < CHIP_VEGA20) {
> -		unsigned version_major, version_minor;
> +		unsigned int version_major, version_minor;
>  
>  		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
>  		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
> @@ -420,7 +420,7 @@ int amdgpu_uvd_entity_init(struct amdgpu_device *adev)
>  
>  int amdgpu_uvd_suspend(struct amdgpu_device *adev)
>  {
> -	unsigned size;
> +	unsigned int size;
>  	void *ptr;
>  	int i, j, idx;
>  	bool in_ras_intr = amdgpu_ras_intr_triggered();
> @@ -469,7 +469,7 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
>  
>  int amdgpu_uvd_resume(struct amdgpu_device *adev)
>  {
> -	unsigned size;
> +	unsigned int size;
>  	void *ptr;
>  	int i, idx;
>  
> @@ -491,7 +491,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>  			adev->uvd.inst[i].saved_bo = NULL;
>  		} else {
>  			const struct common_firmware_header *hdr;
> -			unsigned offset;
> +			unsigned int offset;
>  
>  			hdr = (const struct common_firmware_header *)adev->uvd.fw->data;
>  			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> @@ -542,6 +542,7 @@ void amdgpu_uvd_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>  static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo)
>  {
>  	int i;
> +
>  	for (i = 0; i < abo->placement.num_placement; ++i) {
>  		abo->placements[i].fpfn = 0 >> PAGE_SHIFT;
>  		abo->placements[i].lpfn = (256 * 1024 * 1024) >> PAGE_SHIFT;
> @@ -579,7 +580,7 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
>  
>  	r = amdgpu_cs_find_mapping(ctx->parser, addr, &bo, &mapping);
>  	if (r) {
> -		DRM_ERROR("Can't find BO for addr 0x%08Lx\n", addr);
> +		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
>  		return r;
>  	}
>  
> @@ -589,6 +590,7 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
>  		if (cmd == 0x0 || cmd == 0x3) {
>  			/* yes, force it into VRAM */
>  			uint32_t domain = AMDGPU_GEM_DOMAIN_VRAM;
> +
>  			amdgpu_bo_placement_from_domain(bo, domain);
>  		}
>  		amdgpu_uvd_force_into_uvd_segment(bo);
> @@ -609,21 +611,21 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
>   * Peek into the decode message and calculate the necessary buffer sizes.
>   */
>  static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
> -	unsigned buf_sizes[])
> +	unsigned int buf_sizes[])
>  {
> -	unsigned stream_type = msg[4];
> -	unsigned width = msg[6];
> -	unsigned height = msg[7];
> -	unsigned dpb_size = msg[9];
> -	unsigned pitch = msg[28];
> -	unsigned level = msg[57];
> +	unsigned int stream_type = msg[4];
> +	unsigned int width = msg[6];
> +	unsigned int height = msg[7];
> +	unsigned int dpb_size = msg[9];
> +	unsigned int pitch = msg[28];
> +	unsigned int level = msg[57];
>  
> -	unsigned width_in_mb = width / 16;
> -	unsigned height_in_mb = ALIGN(height / 16, 2);
> -	unsigned fs_in_mb = width_in_mb * height_in_mb;
> +	unsigned int width_in_mb = width / 16;
> +	unsigned int height_in_mb = ALIGN(height / 16, 2);
> +	unsigned int fs_in_mb = width_in_mb * height_in_mb;
>  
> -	unsigned image_size, tmp, min_dpb_size, num_dpb_buffer;
> -	unsigned min_ctx_size = ~0;
> +	unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
> +	unsigned int min_ctx_size = ~0;
>  
>  	image_size = width * height;
>  	image_size += image_size / 2;
> @@ -631,7 +633,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
>  
>  	switch (stream_type) {
>  	case 0: /* H264 */
> -		switch(level) {
> +		switch (level) {
>  		case 30:
>  			num_dpb_buffer = 8100 / fs_in_mb;
>  			break;
> @@ -709,7 +711,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
>  		break;
>  
>  	case 7: /* H264 Perf */
> -		switch(level) {
> +		switch (level) {
>  		case 30:
>  			num_dpb_buffer = 8100 / fs_in_mb;
>  			break;
> @@ -742,7 +744,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
>  		/* reference picture buffer */
>  		min_dpb_size = image_size * num_dpb_buffer;
>  
> -		if (!adev->uvd.use_ctx_buf){
> +		if (!adev->uvd.use_ctx_buf) {
>  			/* macroblock context buffer */
>  			min_dpb_size +=
>  				width_in_mb * height_in_mb * num_dpb_buffer * 192;
> @@ -805,7 +807,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
>   * Make sure that we don't open up to many sessions.
>   */
>  static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
> -			     struct amdgpu_bo *bo, unsigned offset)
> +			     struct amdgpu_bo *bo, unsigned int offset)
>  {
>  	struct amdgpu_device *adev = ctx->parser->adev;
>  	int32_t *msg, msg_type, handle;
> @@ -911,7 +913,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
>  
>  	r = amdgpu_cs_find_mapping(ctx->parser, addr, &bo, &mapping);
>  	if (r) {
> -		DRM_ERROR("Can't find BO for addr 0x%08Lx\n", addr);
> +		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
>  		return r;
>  	}
>  
> @@ -930,7 +932,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
>  	if (cmd < 0x4) {
>  		if ((end - start) < ctx->buf_sizes[cmd]) {
>  			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
> -				  (unsigned)(end - start),
> +				  (unsigned int)(end - start),
>  				  ctx->buf_sizes[cmd]);
>  			return -EINVAL;
>  		}
> @@ -938,7 +940,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
>  	} else if (cmd == 0x206) {
>  		if ((end - start) < ctx->buf_sizes[4]) {
>  			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
> -					  (unsigned)(end - start),
> +					  (unsigned int)(end - start),
>  					  ctx->buf_sizes[4]);
>  			return -EINVAL;
>  		}
> @@ -949,14 +951,14 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
>  
>  	if (!ctx->parser->adev->uvd.address_64_bit) {
>  		if ((start >> 28) != ((end - 1) >> 28)) {
> -			DRM_ERROR("reloc %LX-%LX crossing 256MB boundary!\n",
> +			DRM_ERROR("reloc %llx-%llx crossing 256MB boundary!\n",
>  				  start, end);
>  			return -EINVAL;
>  		}
>  
>  		if ((cmd == 0 || cmd == 0x3) &&
>  		    (start >> 28) != (ctx->parser->adev->uvd.inst->gpu_addr >> 28)) {
> -			DRM_ERROR("msg/fb buffer %LX-%LX out of 256MB segment!\n",
> +			DRM_ERROR("msg/fb buffer %llx-%llx out of 256MB segment!\n",
>  				  start, end);
>  			return -EINVAL;
>  		}
> @@ -990,7 +992,7 @@ static int amdgpu_uvd_cs_reg(struct amdgpu_uvd_cs_ctx *ctx,
>  
>  	ctx->idx++;
>  	for (i = 0; i <= ctx->count; ++i) {
> -		unsigned reg = ctx->reg + i;
> +		unsigned int reg = ctx->reg + i;
>  
>  		if (ctx->idx >= ctx->ib->length_dw) {
>  			DRM_ERROR("Register command after end of CS!\n");
> @@ -1036,7 +1038,8 @@ static int amdgpu_uvd_cs_packets(struct amdgpu_uvd_cs_ctx *ctx,
>  
>  	for (ctx->idx = 0 ; ctx->idx < ctx->ib->length_dw; ) {
>  		uint32_t cmd = amdgpu_ib_get_value(ctx->ib, ctx->idx);
> -		unsigned type = CP_PACKET_GET_TYPE(cmd);
> +		unsigned int type = CP_PACKET_GET_TYPE(cmd);
> +
>  		switch (type) {
>  		case PACKET_TYPE0:
>  			ctx->reg = CP_PACKET0_GET_REG(cmd);
> @@ -1070,7 +1073,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
>  			     struct amdgpu_ib *ib)
>  {
>  	struct amdgpu_uvd_cs_ctx ctx = {};
> -	unsigned buf_sizes[] = {
> +	unsigned int buf_sizes[] = {
>  		[0x00000000]	=	2048,
>  		[0x00000001]	=	0xFFFFFFFF,
>  		[0x00000002]	=	0xFFFFFFFF,
> @@ -1185,8 +1188,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  }
>  
>  /* multiple fence commands without any stream commands in between can
> -   crash the vcpu so just try to emmit a dummy create/destroy msg to
> -   avoid this */
> + * crash the vcpu so just try to emmit a dummy create/destroy msg to
> + * avoid this
> + */
>  int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>  			      struct dma_fence **fence)
>  {
> @@ -1252,15 +1256,14 @@ static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
>  {
>  	struct amdgpu_device *adev =
>  		container_of(work, struct amdgpu_device, uvd.idle_work.work);
> -	unsigned fences = 0, i, j;
> +	unsigned int fences = 0, i, j;
>  
>  	for (i = 0; i < adev->uvd.num_uvd_inst; ++i) {
>  		if (adev->uvd.harvest_config & (1 << i))
>  			continue;
>  		fences += amdgpu_fence_count_emitted(&adev->uvd.inst[i].ring);
> -		for (j = 0; j < adev->uvd.num_enc_rings; ++j) {
> +		for (j = 0; j < adev->uvd.num_enc_rings; ++j)
>  			fences += amdgpu_fence_count_emitted(&adev->uvd.inst[i].ring_enc[j]);
> -		}
>  	}
>  
>  	if (fences == 0) {
> @@ -1356,7 +1359,7 @@ int amdgpu_uvd_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   */
>  uint32_t amdgpu_uvd_used_handles(struct amdgpu_device *adev)
>  {
> -	unsigned i;
> +	unsigned int i;
>  	uint32_t used_handles = 0;
>  
>  	for (i = 0; i < adev->uvd.max_handles; ++i) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index e2b7324a70cb..1904edf68407 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -99,7 +99,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>  {
>  	const char *fw_name;
>  	const struct common_firmware_header *hdr;
> -	unsigned ucode_version, version_major, version_minor, binary_id;
> +	unsigned int ucode_version, version_major, version_minor, binary_id;
>  	int i, r;
>  
>  	switch (adev->asic_type) {
> @@ -207,7 +207,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>   */
>  int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>  {
> -	unsigned i;
> +	unsigned int i;
>  
>  	if (adev->vce.vcpu_bo == NULL)
>  		return 0;
> @@ -286,7 +286,7 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
>  {
>  	void *cpu_addr;
>  	const struct common_firmware_header *hdr;
> -	unsigned offset;
> +	unsigned int offset;
>  	int r, idx;
>  
>  	if (adev->vce.vcpu_bo == NULL)
> @@ -332,7 +332,7 @@ static void amdgpu_vce_idle_work_handler(struct work_struct *work)
>  {
>  	struct amdgpu_device *adev =
>  		container_of(work, struct amdgpu_device, vce.idle_work.work);
> -	unsigned i, count = 0;
> +	unsigned int i, count = 0;
>  
>  	for (i = 0; i < adev->vce.num_rings; i++)
>  		count += amdgpu_fence_count_emitted(&adev->vce.ring[i]);
> @@ -409,6 +409,7 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>  {
>  	struct amdgpu_ring *ring = &adev->vce.ring[0];
>  	int i, r;
> +
>  	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
>  		uint32_t handle = atomic_read(&adev->vce.handles[i]);
>  
> @@ -436,7 +437,7 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>  static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>  				     struct dma_fence **fence)
>  {
> -	const unsigned ib_size_dw = 1024;
> +	const unsigned int ib_size_dw = 1024;
>  	struct amdgpu_job *job;
>  	struct amdgpu_ib *ib;
>  	struct amdgpu_ib ib_msg;
> @@ -528,7 +529,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>  static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>  				      bool direct, struct dma_fence **fence)
>  {
> -	const unsigned ib_size_dw = 1024;
> +	const unsigned int ib_size_dw = 1024;
>  	struct amdgpu_job *job;
>  	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
> @@ -596,12 +597,12 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   */
>  static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p,
>  				  struct amdgpu_ib *ib, int lo, int hi,
> -				  unsigned size, int32_t index)
> +				  unsigned int size, int32_t index)
>  {
>  	int64_t offset = ((uint64_t)size) * ((int64_t)index);
>  	struct ttm_operation_ctx ctx = { false, false };
>  	struct amdgpu_bo_va_mapping *mapping;
> -	unsigned i, fpfn, lpfn;
> +	unsigned int i, fpfn, lpfn;
>  	struct amdgpu_bo *bo;
>  	uint64_t addr;
>  	int r;
> @@ -619,7 +620,7 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p,
>  
>  	r = amdgpu_cs_find_mapping(p, addr, &bo, &mapping);
>  	if (r) {
> -		DRM_ERROR("Can't find BO for addr 0x%010Lx %d %d %d %d\n",
> +		DRM_ERROR("Can't find BO for addr 0x%010llx %d %d %d %d\n",
>  			  addr, lo, hi, size, index);
>  		return r;
>  	}
> @@ -646,7 +647,7 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p,
>   * Patch relocation inside command stream with real buffer address
>   */
>  static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
> -			       int lo, int hi, unsigned size, uint32_t index)
> +			       int lo, int hi, unsigned int size, uint32_t index)
>  {
>  	struct amdgpu_bo_va_mapping *mapping;
>  	struct amdgpu_bo *bo;
> @@ -662,14 +663,14 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
>  
>  	r = amdgpu_cs_find_mapping(p, addr, &bo, &mapping);
>  	if (r) {
> -		DRM_ERROR("Can't find BO for addr 0x%010Lx %d %d %d %d\n",
> +		DRM_ERROR("Can't find BO for addr 0x%010llx %d %d %d %d\n",
>  			  addr, lo, hi, size, index);
>  		return r;
>  	}
>  
>  	if ((addr + (uint64_t)size) >
>  	    (mapping->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
> -		DRM_ERROR("BO too small for addr 0x%010Lx %d %d\n",
> +		DRM_ERROR("BO too small for addr 0x%010llx %d %d\n",
>  			  addr, lo, hi);
>  		return -EINVAL;
>  	}
> @@ -692,12 +693,12 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
>   * @allocated: allocated a new handle?
>   *
>   * Validates the handle and return the found session index or -EINVAL
> - * we we don't have another free session index.
> + * we don't have another free session index.
>   */
>  static int amdgpu_vce_validate_handle(struct amdgpu_cs_parser *p,
>  				      uint32_t handle, uint32_t *allocated)
>  {
> -	unsigned i;
> +	unsigned int i;
>  
>  	/* validate the handle */
>  	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
> @@ -735,14 +736,14 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
>  			     struct amdgpu_job *job,
>  			     struct amdgpu_ib *ib)
>  {
> -	unsigned fb_idx = 0, bs_idx = 0;
> +	unsigned int fb_idx = 0, bs_idx = 0;
>  	int session_idx = -1;
>  	uint32_t destroyed = 0;
>  	uint32_t created = 0;
>  	uint32_t allocated = 0;
>  	uint32_t tmp, handle = 0;
>  	uint32_t *size = &tmp;
> -	unsigned idx;
> +	unsigned int idx;
>  	int i, r = 0;
>  
>  	job->vm = NULL;
> @@ -1084,7 +1085,7 @@ void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring,
>   *
>   */
>  void amdgpu_vce_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
> -				unsigned flags)
> +				unsigned int flags)
>  {
>  	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
>  
> @@ -1106,7 +1107,7 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	uint32_t rptr;
> -	unsigned i;
> +	unsigned int i;
>  	int r, timeout = adev->usec_timeout;
>  
>  	/* skip ring test for sriov*/
> @@ -1171,7 +1172,7 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  
>  enum amdgpu_ring_priority_level amdgpu_vce_get_ring_prio(int ring)
>  {
> -	switch(ring) {
> +	switch (ring) {
>  	case 0:
>  		return AMDGPU_RING_PRIO_0;
>  	case 1:


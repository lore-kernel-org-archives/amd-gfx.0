Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02415C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 16:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A93E10E187;
	Mon, 21 Nov 2022 16:42:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11E3210E187
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 16:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+hRpT54VwGhoX9oQy2aSadH4oNrsUeLVLM1whGzfi25GoilUIOcWFadfqIhIq6iZzDiMzCuNKMsVvoYDpwXBnDR42o3Uuyw3iYu4lWoL5z+4aMRwOmBfy3RutP6cbmYMN0TzPYQVoVmB/4jRMJNib5ZCetaQT2QbtkL9G0lr0M26AJbN3pVigNXG+rXUML/Ak+3eZAA31x4kk/cRAZp2GCk2x24AllUgabMLHy00/FikfgZv0cFaxUShWaWUvLq8KkqT3oeMIPXuoEyGL/RxzDQ1gARVL1nDeH+rEPklsHTO3vVMUhedqGQR47Z/J82baEZfQ3mvE/U60QRGT2lHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWQG6JM92YD8XiDpdewO3CwWhSZ3ABP0AP+kCLiIbIc=;
 b=GrpTSJfFwuW5Y1ThnRBWDHd5w43OPK14Htd6UWypP2cGR/7O+sir6zt3X7nFwz2iSv45omFEFy4V474lqUwSdh3c1rq7riaYy4bdnwzI6bOT57bL8D++EEwkRm5cmeV0nsMYKBF8XNvl8WgtNKfyPny+OBFBfHbG3vGX67Uy6o+q6hGE3bsS0zlqHHXxLplBlvQKD0VV5SF7DGA0V4t+khDF1dKUiLV053VTclk8+/q90T7NqaADfPTaw2c+pEdjKFfc7esmalTvKxuOgFj8wDVw/kWaBlnDCsRn+gCbj3j0dwW+E2fwsngM0atCOTgabmTl6sVwh9FNoARCD0npUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWQG6JM92YD8XiDpdewO3CwWhSZ3ABP0AP+kCLiIbIc=;
 b=fVTKzx2jenw+5eKhlei07l4ntw4570yAxXL18mSt4sOUuhr8pKaCXA2Nj8CN3ydTJ/uBaMdGtIJ7c2YhwPNK3YObdCaagiGCTuWYdmoI4fGDkRmchPfH521lbfm+tOSRgNDo9f/zt5RfW4j1QYk7Ci3iAX2oUzwvRKn2eo0rF7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:42:47 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 16:42:46 +0000
Message-ID: <65d9d021-d195-deff-6927-079feed668da@amd.com>
Date: Mon, 21 Nov 2022 11:42:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: add drv_vram_usage_va for virt data exchange
Content-Language: en-CA
To: Tong Liu01 <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221118025608.612986-1-Tong.Liu01@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221118025608.612986-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 059b15f2-6016-4c09-ba34-08dacbdf6b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWoRC88ruZOMwQKmhS/v67WzkbCJgyMGCkFc3RG7rm5F1wzmE5klbrrUuf6uKuAbyzTcDvYQ/BqK7yuKflBbcPLbTl3GBgHcCzu8DLagj3hCGBdpk/KcARuQeol7ncfrv5CYgaQYkB1deQpv/ym6Hc/ZkU04sBHV4s6+Gcs8cPcfgjhQDKMvRkoLZ9dKzdLpCEzd0GngxQ8YrxfZ3lWY6lKIBYM9cP9vzV2u1qIhyqqspM0CIVNc2vLOn73fb2fW/Lf1HEufYC5CZ+KaQGRVmO9F7FkyYpZyN5Ob+btH8j/s32D6VxRvU3K44u4kvR3wzgKdy5lkDtRQ29otEJfuJVkfAVu8Ua03kEtfPZE0WmVR6lU0hbG3JAq++r7nj2wyZ0DRJ6ujY1/r1fBwNb5tATEqrYFTU8tBzUbhqPufCcCeT7dtffTxal0VTj0y9A8W6dz8fuBb3tnug10nXusSCqTd6hfrUuGbakh9uYOc0IFWmBHp5ka0uvCSCEmsJwBnaub06fbiEAppKiEaoLVdsyjBB+mO1js5+HjFGsGGgMIQTBAEXAxaWLiNlHQnKyteY1zb76E0AJySkByQC91OJRbhc+6b72sXnYvQvbOts+6CLKo/ht7CcTddQONsqXKCNfgQum4hB97Gz5AizoQ7P9Fr0a7ZgUYMKA9pJlGU/SDgBONyaKl5OTxUdVOx1icPd5UXHFUIeTe+3esDqVU0TONOKuaKcCDD3PBal3Xuzzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(31686004)(2906002)(4001150100001)(83380400001)(66476007)(2616005)(66946007)(41300700001)(36756003)(86362001)(31696002)(54906003)(6506007)(38100700002)(53546011)(66556008)(8936002)(5660300002)(8676002)(30864003)(4326008)(44832011)(186003)(6666004)(316002)(26005)(6512007)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZNM2Z0QVg0T1dMQklKc2VkNjJwN1ByRi9NemxrZlBsbzBrQ1ZtbC9hNnI5?=
 =?utf-8?B?OEJkbmdndFA3ODRjRnhPYTh2QzUwT0N4VzFwS1h1c2hjcXVrWHFkS0JiWW02?=
 =?utf-8?B?ZUJBVk5YbWFhWkNXREk0R1M1Qzhub2Y3ZGtSbnlPQk96UDZ6K05tUk92dUF0?=
 =?utf-8?B?UlFSWmVIb2cyMit5eEJmTUJnb1ZSVU52a2dpSnZVaitqU2RScmdIaE9tQ3M2?=
 =?utf-8?B?NE1jbWx5YlJaK0ViSUc5Tm5LaWYvRVdtY01uM09qRmRmaVA5cGQ5R3dtLzZi?=
 =?utf-8?B?WnNzREtGZVVLYmplUjNLdmVDd1B2ZWJaT0ovWFVEb1BXVmNqQ01Mb04wdnhQ?=
 =?utf-8?B?V08rSlAzV29VWkZEQzA0ekd1T2FSMzErcFg4NjZyV0NaYjZBb280ZDVSODhI?=
 =?utf-8?B?cmlrVU5IZ2dzdTlOWjIwM256OHE5ZFk4WG5VV3EvVkVFZjZwL1pjYXpTVTVk?=
 =?utf-8?B?KzhBZXYrcVlBaDNzSjBQdHExYXdKdC91d2Nwd1FOeWV4QXByY3BHOGVjZ3ZV?=
 =?utf-8?B?Qnc1VnlpdmZLczJDRlpnMG1TU3NEQ05xZVhleGIwOS9nS3k1TUF6Tm0yUmtB?=
 =?utf-8?B?SFBhYWFGTjlyK3NLeWN0aDhNQkVFV2F4WXRRK2xLajFRUTlTZm9VQ3VHcjlx?=
 =?utf-8?B?OUlnbnNzekkxb0VHTU94eUZrd0gxQitpeUR1L0pQL0ovRHlLcWZBRk10ck5s?=
 =?utf-8?B?ZmxFWDY5VUNubWdUUGpUQ0JDRUlmNnplMVRNRjAxMUloVXNqV05vbDNTcWp1?=
 =?utf-8?B?NnRKK3lSN3ZJWG9xZGxzSlh5NmRtd0hrTmIzeExBTjM1YlRVK21xQkQ1Ni9E?=
 =?utf-8?B?b2tIcTc0d1BHY1FuZU9vMFNGM0NtMS9yTVg4VW1kL1FudlN2ckpOOXlJdkxU?=
 =?utf-8?B?V3BMTUpKbWxkNWF5WVJhcVVnL2VUMnVJMkFFaHZPd3ZHTjdKaXV2TGNqc1VY?=
 =?utf-8?B?M0JPV1AxS0xzU3UxUTlUL1Q1N1VqSzhJYzVJcW04UTl2aUV0UVlRRXVnNXZW?=
 =?utf-8?B?YzBMUk05VVFQcWRtaGFzdTFFVzQxZ000UTdTUHBweHhvUUQwWHFremhzTWli?=
 =?utf-8?B?SUd0MjdHVUpQZTR2THRYK25Ya2RreEJWV2ZaVXdWQ1JKM013SFBmYW83a2ha?=
 =?utf-8?B?NkdlQy83dzVCQTk5VXhsaG56SkZrTTNnRzRaNHorLzVaclVkaU4vVm1taWJX?=
 =?utf-8?B?MmNyb09QelkrRkxQSzNCRFUzNHdQU0ttTUx0emo3Tjk5VVB5WFliZnpyVS9v?=
 =?utf-8?B?cUNyTWc5WVR5dkUxbFFTQjYrMmFvRWhrajhJOC9UcGFzQ2xhRlJrMFVzT096?=
 =?utf-8?B?Ykx0ZTM0ZFoxWUhHNU9kV091R2I2Qzl0U2xzSVpPaGRuZkF5amJ1VmczRElO?=
 =?utf-8?B?OU4rWFZxajEyd0ZZODl3YW1EUzBIQUZhbjNCOFlaaFZ2cmJaOTR4UmFJdTE4?=
 =?utf-8?B?eWFHakxsTVkwd1YwRTBoeE44bXdDZENIYVJpZmlJMHk1SGFWSktxSnpOR2R5?=
 =?utf-8?B?TCtiRGthUHZhTUN5MWFSbTJNN1dycVo3RlhwbW1pMFhublk5aURob3AxZ0xp?=
 =?utf-8?B?V0JNODRGaC9TejRINUVEQ0tMNXA0dFpOZkVET0xKMlMyaG42VWJ3b1YwYjA3?=
 =?utf-8?B?WEZVbWk5czE3MnZSNEhIWjlta1B2SVdXVE9Xd2xHVWhqSWxxODIvNi9xUXJX?=
 =?utf-8?B?Y0FQVmFpdjMvK0FmVEJ3QjhqQlB6ZEI0ZXNYTGNTYXM2bnRmNVN3Sm5Ld21H?=
 =?utf-8?B?NVRaTUJ0WG16cWVZL1B5bk9RVlp6dWk0dzNpSGM0a0tNSHlyQnJXWHhGYVJq?=
 =?utf-8?B?UWFFK2FFNTJSeE81V2kxS1AwK3kzMzJvdkJkVFEzU1hNVVQvY3k2aVBQa1dE?=
 =?utf-8?B?dy9XdXFlMEpscFhGMzQ3TDBNSUZRNUpoRHQrL2t2MW1KbWtwUDR2SFU0eEY4?=
 =?utf-8?B?TkpBTnVDTWdrMktYQ0dERU1PVlE4VzZlVjUwQTVNSjR3a1B4dFg1WGRIVWlN?=
 =?utf-8?B?cXBpTmZwMGF1NFNCVFQ5Sm1uSERxcy8vSTBGZlM3Wi9PaHEwWEdsMWFXRUlB?=
 =?utf-8?B?UEJqMWJXN3pMSHYvTEEzMDlCLzNzdHJzQXZzSUI2MFB0M0ZMNjdLRzZWMnlx?=
 =?utf-8?Q?MS60bVnnTVA76DJMNEaxDRvsm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059b15f2-6016-4c09-ba34-08dacbdf6b34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:42:46.4672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1UBGkqlKjOq03C6i6578ZGbA75qQScd0KQWeZ8I8kru7hOY1R/xhG23CR7P3adG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, yifan.zha@amd.com,
 Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-17 21:56, Tong Liu01 wrote:
> For vram_usagebyfirmware_v2_2, fw_vram_reserve is not used. So
> fw_vram_usage_va is NULL, and cannot do virt data exchange
> anymore. Should add drv_vram_usage_va to do virt data exchange
> in vram_usagebyfirmware_v2_2 case. And refine some code style
> checks in pre add vram reservation logic patch
> 
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 16 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 59 +++++++++++++------
>  4 files changed, 54 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 9b97fa39d47a..e40df72c138a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -104,7 +104,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>  static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>  	struct vram_usagebyfirmware_v2_1 *fw_usage, int *usage_bytes)
>  {
> -	uint32_t start_addr, fw_size, drv_size;
> +	u32 start_addr, fw_size, drv_size;
>  
>  	start_addr = le32_to_cpu(fw_usage->start_address_in_kb);
>  	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
> @@ -116,7 +116,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>  			  drv_size);
>  
>  	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> -		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> +		(u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>  		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>  		/* Firmware request VRAM reservation for SR-IOV */
>  		adev->mman.fw_vram_usage_start_offset = (start_addr &
> @@ -133,7 +133,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>  static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>  		struct vram_usagebyfirmware_v2_2 *fw_usage, int *usage_bytes)
>  {
> -	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
> +	u32 fw_start_addr, fw_size, drv_start_addr, drv_size;
>  
>  	fw_start_addr = le32_to_cpu(fw_usage->fw_region_start_address_in_kb);
>  	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
> @@ -147,14 +147,16 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>  			  drv_start_addr,
>  			  drv_size);
>  
> -	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
>  		/* Firmware request VRAM reservation for SR-IOV */
>  		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
>  			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>  		adev->mman.fw_vram_usage_size = fw_size << 10;
>  	}
>  
> -	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
>  		/* driver request VRAM reservation for SR-IOV */
>  		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
>  			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> @@ -172,8 +174,8 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
>  						vram_usagebyfirmware);
>  	struct vram_usagebyfirmware_v2_1 *fw_usage_v2_1;
>  	struct vram_usagebyfirmware_v2_2 *fw_usage_v2_2;
> -	uint16_t data_offset;
> -	uint8_t frev, crev;
> +	u16 data_offset;
> +	u8 frev, crev;
>  	int usage_bytes = 0;
>  
>  	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 52f2282411cb..dd8b6a11db9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1570,7 +1570,7 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
>  {
>  	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
>  						  NULL,
> -						  NULL);
> +						  &adev->mman.drv_vram_usage_va);
>  }
>  
>  /**
> @@ -1608,8 +1608,9 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>   */
>  static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>  {
> -	uint64_t vram_size = adev->gmc.visible_vram_size;
> +	u64 vram_size = adev->gmc.visible_vram_size;
>  
> +	adev->mman.drv_vram_usage_va = NULL;
>  	adev->mman.drv_vram_usage_reserved_bo = NULL;
>  
>  	if (adev->mman.drv_vram_usage_size == 0 ||
> @@ -1621,7 +1622,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>  					  adev->mman.drv_vram_usage_size,
>  					  AMDGPU_GEM_DOMAIN_VRAM,
>  					  &adev->mman.drv_vram_usage_reserved_bo,
> -					  NULL);
> +					  &adev->mman.drv_vram_usage_va);
>  }
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index b391c8d076ff..b4d8ba2789f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -90,6 +90,7 @@ struct amdgpu_mman {
>  	u64		drv_vram_usage_start_offset;
>  	u64		drv_vram_usage_size;
>  	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
> +	void		*drv_vram_usage_va;
>  
>  	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>  	struct amdgpu_bo	*sdma_access_bo;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a226a6c48fb7..e80033e24d48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -428,11 +428,18 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
>  	struct eeprom_table_record bp;
>  	uint64_t retired_page;
>  	uint32_t bp_idx, bp_cnt;
> +	void *vram_usage_va = NULL;
> +
> +	if (adev->mman.fw_vram_usage_va != NULL) {
> +		vram_usage_va = adev->mman.fw_vram_usage_va;
> +	} else {
> +		vram_usage_va = adev->mman.drv_vram_usage_va;
> +	}

Comparison to NULL, please use if (!adev->mman.fw_vram_usage_va), and
also to drop the braces for single line statements.

>  
>  	if (bp_block_size) {
>  		bp_cnt = bp_block_size / sizeof(uint64_t);
>  		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
> -			retired_page = *(uint64_t *)(adev->mman.fw_vram_usage_va +
> +			retired_page = *(uint64_t *)(vram_usage_va +
>  					bp_block_offset + bp_idx * sizeof(uint64_t));
>  			bp.retired_page = retired_page;
>  
> @@ -643,7 +650,11 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>  	adev->virt.fw_reserve.p_vf2pf = NULL;
>  	adev->virt.vf2pf_update_interval_ms = 0;
>  
> -	if (adev->mman.fw_vram_usage_va != NULL) {
> +	if (adev->mman.fw_vram_usage_va != NULL &&
> +		adev->mman.drv_vram_usage_va != NULL) {
> +		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
> +	} else if (adev->mman.fw_vram_usage_va != NULL ||
> +		adev->mman.drv_vram_usage_va != NULL) {
>  		/* go through this logic in ip_init and reset to init workqueue*/
>  		amdgpu_virt_exchange_data(adev);

The alignment here is off. Most editors would align for you automatically.
If you're using Emacs, just press the TAB key anywhere on the line to align
according to mode. (Pressing TAB continuously doesn't do anything, if the line
is already aligned.)

The alignment should look as follows:

	if (adev->mman.fw_vram_usage_va != NULL &&
	    adev->mman.drv_vram_usage_va != NULL) {
		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
	} else if (adev->mman.fw_vram_usage_va != NULL ||
		   adev->mman.drv_vram_usage_va != NULL) {

Note the second conditional inside both "if"-statements' check that it is aligned to
the one on the previous line.

Also please use !x instead of x != NULL.

>  
> @@ -666,32 +677,42 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
>  	uint32_t bp_block_size = 0;
>  	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
>  
> -	if (adev->mman.fw_vram_usage_va != NULL) {
> -
> -		adev->virt.fw_reserve.p_pf2vf =
> -			(struct amd_sriov_msg_pf2vf_info_header *)
> -			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> -		adev->virt.fw_reserve.p_vf2pf =
> -			(struct amd_sriov_msg_vf2pf_info_header *)
> -			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +	if (adev->mman.fw_vram_usage_va != NULL ||
> +		adev->mman.drv_vram_usage_va != NULL) {
> +
> +		if (adev->mman.fw_vram_usage_va != NULL) {

Alignment inside the if () doesn't follow the contained statement, but
follows the parenthesis alignment of the previous line of the if ():

	if (!adev->mman.fw_vram_usage_va ||
	    !adev->mman.drv_vram_usage_va) {

Also please use !x as shown. And you shouldn't have an empty line
after an if () { before the first line of the containing statement.

The rest looks good.

Regards,
Luben

> +			adev->virt.fw_reserve.p_pf2vf =
> +				(struct amd_sriov_msg_pf2vf_info_header *)
> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +			adev->virt.fw_reserve.p_vf2pf =
> +				(struct amd_sriov_msg_vf2pf_info_header *)
> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +		} else if (adev->mman.drv_vram_usage_va != NULL) {
> +			adev->virt.fw_reserve.p_pf2vf =
> +				(struct amd_sriov_msg_pf2vf_info_header *)
> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +			adev->virt.fw_reserve.p_vf2pf =
> +				(struct amd_sriov_msg_vf2pf_info_header *)
> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +		}
>  
>  		amdgpu_virt_read_pf2vf_data(adev);
>  		amdgpu_virt_write_vf2pf_data(adev);
>  
>  		/* bad page handling for version 2 */
>  		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
> -				pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
> +			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
>  
> -				bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
> -						((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
> -				bp_block_size = pf2vf_v2->bp_block_size;
> +			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
> +				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
> +			bp_block_size = pf2vf_v2->bp_block_size;
>  
> -				if (bp_block_size && !adev->virt.ras_init_done)
> -					amdgpu_virt_init_ras_err_handler_data(adev);
> +			if (bp_block_size && !adev->virt.ras_init_done)
> +				amdgpu_virt_init_ras_err_handler_data(adev);
>  
> -				if (adev->virt.ras_init_done)
> -					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
> -			}
> +			if (adev->virt.ras_init_done)
> +				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
> +		}
>  	}
>  }
>  

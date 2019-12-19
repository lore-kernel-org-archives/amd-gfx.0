Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487B3C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122C721D7D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DvVvayTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122C721D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA05A6E072;
	Thu, 19 Dec 2019 03:10:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8436E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 03:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcQAljnT0jIgb72JSnYCiuZUYPou2+lX99Rd7cIGaz1f9gixlVIV+KuFFOAk/3fvb7ojUBYyst1+Hs9StSZhe8f5F1Sz1FkCkWEMnE8PNmrQNXSZs4XTpd2YjHmTiVSUE+kxWlhtopCIaa0WNTgNMrqCvGXIvWX96WRPII9ofhpIkb+ZF1z3f66tZ0u0TprKBJvfuhIgwU9Xfi4KMOWzPh9cpoyDK1m3uHo1/LgxjN2zqTZI39xGS/RiNL6PFoba4hCBdztbsgsY0gheEDG9kVKn3+phBQ1xVITsnY5t0BwG499dDgEAIpd6Y2Up2cHt45qk5UNgFmwIeCW45ELJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVGM5c7gZqngoSeiwTuHQXJfk1nLsZP//jaT0+TMAgQ=;
 b=SAixCbI26i8A5MUW6ls2eglDCSWkPe/07Ww+zfIZckMRG0sjJbZkcsTPTdY1BX0RVmawY3RSTjRvPbkJuDsdAzjjeG6doiDIrBolx05kW8COqUgFxbIFN0EvznSaa5wOMpcWbXHTQmsAx0l7xwi244OikP93U9zL8Qb6gXjiNwQpsBjkSFbDe1Ph+xUnCLBVEYE8e8zLhT4QGITth+soyVrZmKf/Gui2pwKZtCjcNZXtbquP79ch7HYm4VIipcJP14muPPWR4+wZo8roIZ28ynn1HrrYHG2G35SHL8Ip+DApl/AZYXzW/EzbZdiYqxJTfXoqZ6tkQLieQnxG9iBKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVGM5c7gZqngoSeiwTuHQXJfk1nLsZP//jaT0+TMAgQ=;
 b=DvVvayTub6vsVkfq3F1glwQP8wE1t2vBD175OZpDqVElilxdOBVAD+gwl/yJ9UERhyz1/3vOJVbqDWhEqXxaI6mg+C6Ro+FinJjajxzhjnmj1k8BsRZ+kO9MaNATN6EaeIoBtuG+jjf4GQM1qNhxBBLZWGQf/GNDxjMSBzqQq+A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB2601.namprd12.prod.outlook.com (20.176.117.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 03:10:40 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 03:10:40 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V3)
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191219024416.32321-1-tianci.yin@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <1ffb57bb-589c-21ee-fe61-8cb5459cbd1a@amd.com>
Date: Wed, 18 Dec 2019 22:10:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <20191219024416.32321-1-tianci.yin@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::34) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eabc1afc-ce58-4bbc-1d46-08d784310706
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:|DM6PR12MB2601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2601218FA357474C9C9194F299520@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0256C18696
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(129404003)(26005)(6512007)(2906002)(31696002)(6486002)(86362001)(4001150100001)(31686004)(186003)(54906003)(2616005)(36756003)(44832011)(53546011)(6506007)(66476007)(66556008)(66946007)(316002)(8936002)(81156014)(8676002)(81166006)(52116002)(478600001)(5660300002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2601;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHvYSxLggNgB9If1PxA4f57dw71QjcJrv7/CT6UY2F5wy6QTGNzn9rAuh2dXw+UpE93n5p2tiS819Mt3HjcFCBfdCguMZE66t+IymUH1QXPs5kbV5trKGJDg8YgmdcThHuJ4s0WecsClw12X+DEe3Y/0Vq2IxkZAdnfiBqCEeR6uBeBw+KqvqOpbHkh4lsPxKMUnh/HVNd8UeUaFF+Mf1lBGcg7S1srM/SkeVUk6k+zDsWrmi4W0jJDXsXyGQ3TfFHqvVjg4uo4GfUE1v4XpUa6F6+cQgGbgLRZ9S7O1mbhYpS8zKlvSn6fYDq5Ug36YxcbjSZIY0LOd/PU9qGPNjnhL12YaPxtDfylBUKTPRvSyjoSBGbIEroPMGUuTS+FGF9lpQm7+FCnRXIfwBk8NDQTBFTm87d/TNK+Negi6c+9+wDmujn1UP6Y7BtAShTgP5r5FH7ommYllmzaU4BM19yDvsGNffLbqXNihmGpdDhrCLM33eTBojxwddWbWaMgC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabc1afc-ce58-4bbc-1d46-08d784310706
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 03:10:40.4588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6O6Pxu1aFH8z01sagD8wF96zxBA0KhaGS4BsPhrIriACiOdjZRaGQjKDw+z5js4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
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
Cc: Long Gang <Gang.Long@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2019-12-18 9:44 p.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
> 
> The method of getting fb_loc changed from parsing VBIOS to
> taking certain offset from top of VRAM
> 
> Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 38 ++-----------------
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 13 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
>  drivers/gpu/drm/amd/include/atomfirmware.h    | 14 -------
>  7 files changed, 26 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a78a363b1d71..fa2cf8e7bc07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -642,9 +642,8 @@ struct amdgpu_fw_vram_usage {
>  	struct amdgpu_bo *reserved_bo;
>  	void *va;
>  
> -	/* Offset on the top of VRAM, used as c2p write buffer.
> +	/* GDDR6 training support flag.
>  	*/
> -	u64 mem_train_fb_loc;
>  	bool mem_train_support;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 9ba80d828876..fdd52d86a4d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -2022,7 +2022,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
>  	if (adev->is_atom_fw) {
>  		amdgpu_atomfirmware_scratch_regs_init(adev);
>  		amdgpu_atomfirmware_allocate_fb_scratch(adev);
> -		ret = amdgpu_atomfirmware_get_mem_train_fb_loc(adev);
> +		ret = amdgpu_atomfirmware_get_mem_train_info(adev);
>  		if (ret) {
>  			DRM_ERROR("Failed to get mem train fb location.\n");
>  			return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index ff4eb96bdfb5..58f9d8c3a17a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -525,16 +525,12 @@ static int gddr6_mem_train_support(struct amdgpu_device *adev)
>  	return ret;
>  }
>  
> -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
> +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
>  {
>  	struct atom_context *ctx = adev->mode_info.atom_context;
> -	unsigned char *bios = ctx->bios;
> -	struct vram_reserve_block *reserved_block;
> -	int index, block_number;
> +	int index;
>  	uint8_t frev, crev;
>  	uint16_t data_offset, size;
> -	uint32_t start_address_in_kb;
> -	uint64_t offset;
>  	int ret;
>  
>  	adev->fw_vram_usage.mem_train_support = false;
> @@ -569,32 +565,6 @@ int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> -	reserved_block = (struct vram_reserve_block *)
> -		(bios + data_offset + sizeof(struct atom_common_table_header));
> -	block_number = ((unsigned int)size - sizeof(struct atom_common_table_header))
> -		/ sizeof(struct vram_reserve_block);
> -	reserved_block += (block_number > 0) ? block_number-1 : 0;
> -	DRM_DEBUG("block_number:0x%04x, last block: 0x%08xkb sz, %dkb fw, %dkb drv.\n",
> -		  block_number,
> -		  le32_to_cpu(reserved_block->start_address_in_kb),
> -		  le16_to_cpu(reserved_block->used_by_firmware_in_kb),
> -		  le16_to_cpu(reserved_block->used_by_driver_in_kb));
> -	if (reserved_block->used_by_firmware_in_kb > 0) {
> -		start_address_in_kb = le32_to_cpu(reserved_block->start_address_in_kb);
> -		offset = (uint64_t)start_address_in_kb * ONE_KiB;
> -		if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) ) {
> -			offset -= ONE_MiB;
> -		}
> -
> -		offset &= ~(ONE_MiB - 1);
> -		adev->fw_vram_usage.mem_train_fb_loc = offset;
> -		adev->fw_vram_usage.mem_train_support = true;
> -		DRM_DEBUG("mem_train_fb_loc:0x%09llx.\n", offset);
> -		ret = 0;
> -	} else {
> -		DRM_ERROR("used_by_firmware_in_kb is 0!\n");
> -		ret = -EINVAL;
> -	}
> -
> -	return ret;
> +	adev->fw_vram_usage.mem_train_support = true;
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> index f871af5ea6f3..434fe2fa0089 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> @@ -31,7 +31,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>  	int *vram_width, int *vram_type, int *vram_vendor);
> -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev);
> +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
>  bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2ff63d0414c9..ec84acdd43a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1687,6 +1687,17 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
>  	return 0;
>  }
>  
> +static void amdgpu_ttm_training_get_c2p_offset(struct amdgpu_device *adev)
> +{
> +	u64 offset = adev->gmc.mc_vram_size;
> +	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
> +
> +	if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) )
> +		offset -= ONE_MiB;
> +
> +	ctx->c2p_train_data_offset = ALIGN(offset,ONE_MiB);
> +}
> +
>  /**
>   * amdgpu_ttm_training_reserve_vram_init - create bo vram reservation from memory training
>   *
> @@ -1705,7 +1716,7 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	ctx->c2p_train_data_offset = adev->fw_vram_usage.mem_train_fb_loc;
> +	amdgpu_ttm_training_get_c2p_offset();
>  	ctx->p2c_train_data_offset = (adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
>  	ctx->train_data_size = GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;

Well, let's take a look... what have we here? Something like this:

ctx->a = something;
ctx->b = something;
function();
ctx->c = something;

Now, the problem is that that function sets a member of ctx, in a *hidden* way.
We dont'want to hide this. That is, we want to be explicit inline. So, we want to
do it like this:

ctx->a = something;
ctx->b = something;
ctx->c = f(x);
ctx->d = something;

To become something like this:

+static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_size)
+{
+	if ((vram_size & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) )
+		vram_size -= ONE_MiB;
+
+	return ALIGN(vram_size, ONE_MiB);
+}

...

-	ctx->c2p_train_data_offset = adev->fw_vram_usage.mem_train_fb_loc;
+	ctx->c2p_train_data_offset = amdgpu_ttm_training_get_c2p_offset(adev->gmc.mc_vram_size);
 	ctx->p2c_train_data_offset = (adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
 	ctx->train_data_size = GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;

And when someone looks at this, they can read down, the assignments, explictly inline assignment
operators. It's open to see. (And maybe the '=' equal chars would be column aligned. :-)

Note, that the function above doesn't need to know about dev structs and anything
like that. It only needs to know about numbers, since this is what it operates on.
Input is a number. Output is a number. y = f(x). Minimal.

If you compare to my previous email, we just took/lifted the statements which operate
on 'a' and put them into a function. Literally:

On 2019-12-18 3:14 p.m., Luben Tuikov wrote:
> a = adev->gmc.mc_vram_size;
> if ((a & (ONE_MiB - 1)) < (4 * ONE_KiB + 1))
> 	a -= ONE_MiB;
> ctx->c2p_train_data_offset = ALIGN(a, ONE_MiB);

Hope this helps.

Regards,
Luben
P.S. The compiler we optimize away this function and the code flow and order, but it
would be very readable to a human.

>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index f1ebd424510c..19eb3e8456c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -66,6 +66,13 @@ struct amdgpu_copy_mem {
>  	unsigned long			offset;
>  };
>  
> +/* Definitions for constance */
> +enum amdgpu_internal_constants
> +{
> +	ONE_KiB	= 0x400,
> +	ONE_MiB	= 0x100000,
> +};
> +
>  extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_func;
>  extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;
>  
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index dd7cbc00a0aa..70146518174c 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -672,20 +672,6 @@ struct vram_usagebyfirmware_v2_1
>    uint16_t  used_by_driver_in_kb; 
>  };
>  
> -/* This is part of vram_usagebyfirmware_v2_1 */
> -struct vram_reserve_block
> -{
> -	uint32_t start_address_in_kb;
> -	uint16_t used_by_firmware_in_kb;
> -	uint16_t used_by_driver_in_kb;
> -};
> -
> -/* Definitions for constance */
> -enum atomfirmware_internal_constants
> -{
> -	ONE_KiB	= 0x400,
> -	ONE_MiB	= 0x100000,
> -};
>  
>  /* 
>    ***************************************************************************
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

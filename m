Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07171C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E062146E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cZGVhh0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E062146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797E16E150;
	Fri, 20 Dec 2019 21:38:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B2E6E150
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 21:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g51zX6dJI4wxfQkJjulvXCDw+Tm95CdR5qC84MAG4/ApTdLvMV7RLAWT/lciKbkJueRNxLdJvQ/RHHFws3mwFh1JjCP47f+Aq97NOlm9wI8B7sOY0oBzdxaNt81hQeY8RvOoIfBPF5i7IAX+sQZLkmtDZFmljOK6Mt7Zis2GMND0tbbtx0/xO9koFcJza1mCvYcRIUOUbzBSv70SKh/T7V7jniko/xKramiSAlnC94ix6AzlqLQv91rwOgoNktfgt3583rhlOVZ/j24o8GPbDbMCnZTG30aF67emgV5jidFUxx+P4FYrJpFb83Ul/1RY2Ir2VRbzwaPyKYb7NkT9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6EOL7b9/I6wS2/pWEBnRM0EEE4DYwd/dnRzD/F6GNE=;
 b=CtB5l6Rwcz2Wwkhk8207aGyhcXn4+A+q8f6bg9/qAJ/Z42YmFuziOWoVe4TeIR+n8jj0OC2l0RJCXR15kUawiyww3xzm088g21TV/NNNd7kLxOZ/XrUSI7+7fKEIrN6DUBiH1puKsfSljKzWRqPWGv39an4pfv7CPBO/fPvGHuPsKhpMTOH45W75eav9AiW55Uvnzsptqo/Q/JrTU4zoK0PRhy9YWQYrXvOqBHJXQJ0krmOkqm0C0I9r1T40Yz82r6KZPXp/GQLpVo7kUCZ1uSCWPdjYIYHFWg8FMtvt508lDZvBVSIqJSVFjEhQIQA9UTEP+04s9pkikpfItIBlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6EOL7b9/I6wS2/pWEBnRM0EEE4DYwd/dnRzD/F6GNE=;
 b=cZGVhh0r/6FP3s9EH4G9utTYgvPUb8flSTaWAit8gkMJD1Pwca8usQbmyq9qTnXK9C0KYQSWl2zvfaa67hS4cDtHLcT+PFR9fIEE44lPYS2KTiD0wlgNtprfzxI7KnkEZjZ5XvdRVdLA0L8SZOUzF2zCo9HAWmGCEfAFFMGz40k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3184.namprd12.prod.outlook.com (20.179.82.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 21:38:56 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 21:38:56 +0000
Subject: Re: [PATCH 4/5] drm/amdgpu: flush TLB functions removal from kfd2kgd
 interface
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191220062442.33635-1-alex.sierra@amd.com>
 <20191220062442.33635-4-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e2c68c38-7e5f-e79f-0c08-5e9e89e0ca40@amd.com>
Date: Fri, 20 Dec 2019 16:38:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191220062442.33635-4-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 20 Dec 2019 21:38:56 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a9fce77-d50b-4603-0c18-08d78595045f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3184:|MN2PR12MB3184:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3184AC8DFD5EBCF0743CC64F922D0@MN2PR12MB3184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(16526019)(31686004)(478600001)(5660300002)(4001150100001)(52116002)(31696002)(6486002)(86362001)(66946007)(66556008)(81156014)(8936002)(53546011)(316002)(66476007)(16576012)(2616005)(26005)(8676002)(81166006)(36756003)(186003)(30864003)(2906002)(44832011)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3184;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEBfrsieIqW9sedh+9v94dyICS7TQSfdGa/Y2XyF4jDwwt+Go//z2Yt7ZBB6hsCehkjcelrvJBQwcVUODIQZ6WN4GCw8G9H/1sCOCovF+62siSgbLVUF9vNiWNpeQV0wDjznNl+qg78pDFOKoq6TH4BCW6Rzj+OHLnS1kmbexd+BD01daD73xvbrSQfogMv7QV3PJLqGTvNuKRQbwim6Dy1kuTo3pZWU+duZuOLEHUivg8hQDzMwMXTl9CTCoYihorvBIhhlAscsKhNMZf0sblFqfBhzgtZG58UMViYbQBoZ1UFbeK+tqIWeZ2yRFoETMqVW2DvFcK/hd9K2x19Cff33XvbMSgjoudFSLOZM+bL6er9ttp7639+HkVmBTTGWb5rWPQI/Af9jMQC86QnitWA7eyeSKFjGxw/dm+4/E/y8UM96pNjuj6N1GOewCVrO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9fce77-d50b-4603-0c18-08d78595045f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 21:38:56.8442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7ahrz/m/XolspZ8VYaqqMcPirLgyix6oSK54tadpkBIr4Y+Y2Np6gE7y6QZ6BT0a1o32zTlelz0RCFGJSogCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3184
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2019-12-20 1:24, Alex Sierra wrote:
> [Why]
> kfd2kgd interface will be deprecated. This removal only covers TLB
> invalidation for now. They have been replaced in amdgpu_amdkfd API.
>
> [How]
> TLB invalidate functions removed from the different amdkfd_gfx_v*
> versions.
>
> Change-Id: Ic2c7d4a0d19fe1e884dee1ff10a520d31252afee
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 -
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 67 -------------
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 41 --------
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 41 --------
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 96 -------------------
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  2 -
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 -
>   7 files changed, 251 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 3c119407dc34..82e80b92e6ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -296,7 +296,5 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>   			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>   	.get_tile_config = kgd_gfx_v9_get_tile_config,
>   	.set_vm_context_page_table_base = kgd_set_vm_context_page_table_base,
> -	.invalidate_tlbs = kgd_gfx_v9_invalidate_tlbs,
> -	.invalidate_tlbs_vmid = kgd_gfx_v9_invalidate_tlbs_vmid,
>   	.get_hive_id = amdgpu_amdkfd_get_hive_id,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 61cd707158e4..6132b4874498 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -686,71 +686,6 @@ static bool get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
>   	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
>   }
>   
> -static int invalidate_tlbs_with_kiq(struct amdgpu_device *adev, uint16_t pasid)
> -{
> -	signed long r;
> -	uint32_t seq;
> -	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
> -
> -	spin_lock(&adev->gfx.kiq.ring_lock);
> -	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
> -	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
> -	amdgpu_ring_write(ring,
> -			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
> -			PACKET3_INVALIDATE_TLBS_PASID(pasid));
> -	amdgpu_fence_emit_polling(ring, &seq);
> -	amdgpu_ring_commit(ring);
> -	spin_unlock(&adev->gfx.kiq.ring_lock);
> -
> -	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> -	if (r < 1) {
> -		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
> -		return -ETIME;
> -	}
> -
> -	return 0;
> -}
> -
> -static int invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
> -	int vmid;
> -	uint16_t queried_pasid;
> -	bool ret;
> -	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
> -
> -	if (amdgpu_emu_mode == 0 && ring->sched.ready)
> -		return invalidate_tlbs_with_kiq(adev, pasid);
> -
> -	for (vmid = 0; vmid < 16; vmid++) {
> -		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
> -			continue;
> -
> -		ret = get_atc_vmid_pasid_mapping_info(kgd, vmid,
> -				&queried_pasid);
> -		if (ret	&& queried_pasid == pasid) {
> -			amdgpu_gmc_flush_gpu_tlb(adev, vmid,
> -					AMDGPU_GFXHUB_0, 0);
> -			break;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
> -
> -	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
> -		pr_err("non kfd vmid %d\n", vmid);
> -		return 0;
> -	}
> -
> -	amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
> -	return 0;
> -}
> -
>   static int kgd_address_watch_disable(struct kgd_dev *kgd)
>   {
>   	return 0;
> @@ -832,7 +767,5 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
>   			get_atc_vmid_pasid_mapping_info,
>   	.get_tile_config = amdgpu_amdkfd_get_tile_config,
>   	.set_vm_context_page_table_base = set_vm_context_page_table_base,
> -	.invalidate_tlbs = invalidate_tlbs,
> -	.invalidate_tlbs_vmid = invalidate_tlbs_vmid,
>   	.get_hive_id = amdgpu_amdkfd_get_hive_id,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index 6e6f0a99ec06..8f052e98a3c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -696,45 +696,6 @@ static void set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
>   		lower_32_bits(page_table_base));
>   }
>   
> -static int invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
> -	int vmid;
> -	unsigned int tmp;
> -
> -	if (adev->in_gpu_reset)
> -		return -EIO;
> -
> -	for (vmid = 0; vmid < 16; vmid++) {
> -		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
> -			continue;
> -
> -		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
> -		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
> -			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
> -			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
> -			RREG32(mmVM_INVALIDATE_RESPONSE);
> -			break;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
> -
> -	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
> -		pr_err("non kfd vmid\n");
> -		return 0;
> -	}
> -
> -	WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
> -	RREG32(mmVM_INVALIDATE_RESPONSE);
> -	return 0;
> -}
> -
>    /**
>     * read_vmid_from_vmfault_reg - read vmid from register
>     *
> @@ -771,7 +732,5 @@ const struct kfd2kgd_calls gfx_v7_kfd2kgd = {
>   	.set_scratch_backing_va = set_scratch_backing_va,
>   	.get_tile_config = get_tile_config,
>   	.set_vm_context_page_table_base = set_vm_context_page_table_base,
> -	.invalidate_tlbs = invalidate_tlbs,
> -	.invalidate_tlbs_vmid = invalidate_tlbs_vmid,
>   	.read_vmid_from_vmfault_reg = read_vmid_from_vmfault_reg,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index bfbddedb2380..19a10db93d68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -657,45 +657,6 @@ static void set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
>   			lower_32_bits(page_table_base));
>   }
>   
> -static int invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
> -	int vmid;
> -	unsigned int tmp;
> -
> -	if (adev->in_gpu_reset)
> -		return -EIO;
> -
> -	for (vmid = 0; vmid < 16; vmid++) {
> -		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
> -			continue;
> -
> -		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
> -		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
> -			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
> -			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
> -			RREG32(mmVM_INVALIDATE_RESPONSE);
> -			break;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
> -
> -	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
> -		pr_err("non kfd vmid %d\n", vmid);
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
> -	RREG32(mmVM_INVALIDATE_RESPONSE);
> -	return 0;
> -}
> -
>   const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_program_sh_mem_settings,
>   	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
> @@ -717,6 +678,4 @@ const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
>   	.set_scratch_backing_va = set_scratch_backing_va,
>   	.get_tile_config = get_tile_config,
>   	.set_vm_context_page_table_base = set_vm_context_page_table_base,
> -	.invalidate_tlbs = invalidate_tlbs,
> -	.invalidate_tlbs_vmid = invalidate_tlbs_vmid,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index e7861f0ef415..932ae85d97e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -617,100 +617,6 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
>   	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
>   }
>   
> -static int invalidate_tlbs_with_kiq(struct amdgpu_device *adev, uint16_t pasid,
> -			uint32_t flush_type)
> -{
> -	signed long r;
> -	uint32_t seq;
> -	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
> -
> -	spin_lock(&adev->gfx.kiq.ring_lock);
> -	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
> -	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
> -	amdgpu_ring_write(ring,
> -			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
> -			PACKET3_INVALIDATE_TLBS_ALL_HUB(1) |
> -			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
> -			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
> -	amdgpu_fence_emit_polling(ring, &seq);
> -	amdgpu_ring_commit(ring);
> -	spin_unlock(&adev->gfx.kiq.ring_lock);
> -
> -	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> -	if (r < 1) {
> -		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
> -		return -ETIME;
> -	}
> -
> -	return 0;
> -}
> -
> -int kgd_gfx_v9_invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
> -	int vmid, i;
> -	uint16_t queried_pasid;
> -	bool ret;
> -	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
> -	uint32_t flush_type = 0;
> -
> -	if (adev->in_gpu_reset)
> -		return -EIO;
> -	if (adev->gmc.xgmi.num_physical_nodes &&
> -		adev->asic_type == CHIP_VEGA20)
> -		flush_type = 2;
> -
> -	if (ring->sched.ready)
> -		return invalidate_tlbs_with_kiq(adev, pasid, flush_type);
> -
> -	for (vmid = 0; vmid < 16; vmid++) {
> -		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
> -			continue;
> -
> -		ret = kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(kgd, vmid,
> -				&queried_pasid);
> -		if (ret && queried_pasid == pasid) {
> -			for (i = 0; i < adev->num_vmhubs; i++)
> -				amdgpu_gmc_flush_gpu_tlb(adev, vmid,
> -							i, flush_type);
> -			break;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -int kgd_gfx_v9_invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
> -	int i;
> -
> -	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
> -		pr_err("non kfd vmid %d\n", vmid);
> -		return 0;
> -	}
> -
> -	/* Use legacy mode tlb invalidation.
> -	 *
> -	 * Currently on Raven the code below is broken for anything but
> -	 * legacy mode due to a MMHUB power gating problem. A workaround
> -	 * is for MMHUB to wait until the condition PER_VMID_INVALIDATE_REQ
> -	 * == PER_VMID_INVALIDATE_ACK instead of simply waiting for the ack
> -	 * bit.
> -	 *
> -	 * TODO 1: agree on the right set of invalidation registers for
> -	 * KFD use. Use the last one for now. Invalidate both GC and
> -	 * MMHUB.
> -	 *
> -	 * TODO 2: support range-based invalidation, requires kfg2kgd
> -	 * interface change
> -	 */
> -	for (i = 0; i < adev->num_vmhubs; i++)
> -		amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
> -
> -	return 0;
> -}
> -
>   int kgd_gfx_v9_address_watch_disable(struct kgd_dev *kgd)
>   {
>   	return 0;
> @@ -793,7 +699,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>   	.get_tile_config = kgd_gfx_v9_get_tile_config,
>   	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
> -	.invalidate_tlbs = kgd_gfx_v9_invalidate_tlbs,
> -	.invalidate_tlbs_vmid = kgd_gfx_v9_invalidate_tlbs_vmid,
>   	.get_hive_id = amdgpu_amdkfd_get_hive_id,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 02b1426d17d1..dfafa28b7559 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -57,7 +57,5 @@ uint32_t kgd_gfx_v9_address_watch_get_offset(struct kgd_dev *kgd,
>   
>   bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
>   					uint8_t vmid, uint16_t *p_pasid);
> -int kgd_gfx_v9_invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid);
> -int kgd_gfx_v9_invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid);
>   int kgd_gfx_v9_get_tile_config(struct kgd_dev *kgd,
>   		struct tile_config *config);
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 2cd217e60125..a01ef836ad58 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -307,8 +307,6 @@ struct kfd2kgd_calls {
>   
>   	void (*set_vm_context_page_table_base)(struct kgd_dev *kgd,
>   			uint32_t vmid, uint64_t page_table_base);
> -	int (*invalidate_tlbs)(struct kgd_dev *kgd, uint16_t pasid);
> -	int (*invalidate_tlbs_vmid)(struct kgd_dev *kgd, uint16_t vmid);
>   	uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
>   	uint64_t (*get_hive_id)(struct kgd_dev *kgd);
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

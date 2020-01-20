Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A452EC2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 16:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EA822464
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 16:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CuV3So7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EA822464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09FD06E9EE;
	Mon, 20 Jan 2020 16:20:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C0B6E9EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 16:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5V/OT6Q/Yz1Eoi2OVY2da3RqUZUegbChKSyFfH3MP4FRlufh33mNNHwaAf6SHEVYLyzTlGDwz8tznf0YvQnE5hiOvqYPSTb1jdubaIEf5KIdMos8llrEz0RqVSwQVdACchARFXlQoS0KSmIn0peWwc2l7WMlIn6GIhCQGYMhdhEXU1CDhEIJf06zu/sH6TEWXNAOC/GE23wXKwOyX6og7sK8Z3ItTAaAwdUxQv2OTiP2d7W5mWUeGV3X3o5IWR4z4Lm4sTuQ8xltHfDkOvqlIoYv5kdhb7vx8nW7OctleKp7IbFLakpdw9OyqMvYAYQKJCCEHa1ks76LHdIdIRf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZOOvZjhhd+agklNDe9ibs9+453pet7ctdEtRgsjQ6M=;
 b=Fr+T/rGtLGPIfqafMON4VHql+8iFDwuM2CPKOMS6mwOKgKKo1OzanlmdDRNVHHlCShpCKp18qhbJLFEh60byPiHN23MCeFBFD9Odr1mUgzQZYLalTG/XmwiDUqMDvstkxgItuwXQLhcXuFifQFApgJRUo5w55bNTDkrqP/5xM2quVHSAj0K0WvvylJkcijgeLcgn6h9bXbbBm+xQ1S3cKfCnknWdzwDzZl8aye1cEPCTRhUOvqL7OsvMEpSfZUXIjFkIl/OBfBI3msaRae0rKBM0FoKRkzWEH6HySM62U6s5351Wx6kU+kmfvGpGlgX8iyHanLN4xWhv8JiOwsGm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZOOvZjhhd+agklNDe9ibs9+453pet7ctdEtRgsjQ6M=;
 b=CuV3So7a+7/D2cVpP1J3Cur9TbGkKMFx1HpX0wRvNOkN5qzWuU2CNw/re9/OTQTvW9lj5hjD/pzc4LXBJhVPLNIwW4JriSSAyyZ+8xO3Awyw+fNJhxuyTm0KsRD4Q0sFVLLdzCQyACzbuGgLUjl+4ULHyzj9h2X8RAU0lChw0lM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0059.namprd12.prod.outlook.com (10.174.106.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Mon, 20 Jan 2020 16:20:30 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::b54c:16d9:d613:6877]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::b54c:16d9:d613:6877%9]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 16:20:30 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: Fix TLB invalidation request when using
 semaphore
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200118013735.19361-1-Felix.Kuehling@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <f8baf7a3-7529-72e9-6931-87e0b2d75478@amd.com>
Date: Mon, 20 Jan 2020 11:20:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200118013735.19361-1-Felix.Kuehling@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::39) To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
Received: from [172.27.227.155] (165.204.55.251) by
 YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Mon, 20 Jan 2020 16:20:30 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98654c8e-a8aa-4e58-cda7-08d79dc4ab05
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0059:|DM5PR1201MB0059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB005924C095B280355CD8D9F8F0320@DM5PR1201MB0059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(2616005)(956004)(316002)(52116002)(44832011)(16576012)(6486002)(478600001)(53546011)(26005)(16526019)(186003)(8676002)(66946007)(2906002)(5660300002)(36756003)(81166006)(66556008)(66476007)(8936002)(31686004)(81156014)(31696002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0059;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wiTU2ElHFP//OgKtJtLqtqFWas9vuGkuL86ZhH1fS09TVeNPVaP2Jzj6t5/Zd41ScBNAVUiQV2QeGwzaqW3AbS4h6R91gNHa2p73gbGL3uGNBCqeeHhdP3GBS4pVUBZjx0jLOyS0j+BlSzqmeb4Qf3iH2z2IMKWY4x+JFjsgD7ham5eViXPqJr7vEDEDupZaivoT3XJB36WpcPtDwM0lVbD1xXYAMItuTDrVbDFlqe+3KVd/MUBUvvyQSgUtwdBRwFnseIYo+XJ0y4aCDsMWivok8akyntSoxhUG6z59/M7TBOCs7hXWg9GIhpHUylcwkLkeoYByu76RM30GB9IMxbHS4c4Iq2xl9jfFubMNmH8kBc24/RbyoIGEsUmUtkopViiWplHagb0zkpX3U37ymo7NNck3Qm8+zI88Rk6ILEYN/qzG9TDxXJg9N9AtA3v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98654c8e-a8aa-4e58-cda7-08d79dc4ab05
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 16:20:30.8477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9I9QT7wb46u5uU4+gx+TC9SeWp2nhzjUPVmALmEcNpQXmJy+DnLXKk0a2E1N3JE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0059
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

Reviewed-by: Yong Zhao <Yong.Zhao@amd.com>

On 2020-01-17 8:37 p.m., Felix Kuehling wrote:
> Use a more meaningful variable name for the invalidation request
> that is distinct from the tmp variable that gets overwritten when
> acquiring the invalidation semaphore.
>
> Fixes: 00f607f38d82 ("drm/amdgpu: invalidate mmhub semaphore workaround in gmc9/gmc10")
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 5 +++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 8 ++++----
>   2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 86f4ffe408e7..d914555e1212 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -262,7 +262,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   {
>   	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
>   	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
> -	u32 tmp = gmc_v10_0_get_invalidate_req(vmid, flush_type);
> +	u32 inv_req = gmc_v10_0_get_invalidate_req(vmid, flush_type);
> +	u32 tmp;
>   	/* Use register 17 for GART */
>   	const unsigned eng = 17;
>   	unsigned int i;
> @@ -289,7 +290,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
>   	}
>   
> -	WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, tmp);
> +	WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
>   
>   	/*
>   	 * Issue a dummy read to wait for the ACK register to be cleared
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 54bdc1786ab1..6d95de1413c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -476,13 +476,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   {
>   	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
>   	const unsigned eng = 17;
> -	u32 j, tmp;
> +	u32 j, inv_req, tmp;
>   	struct amdgpu_vmhub *hub;
>   
>   	BUG_ON(vmhub >= adev->num_vmhubs);
>   
>   	hub = &adev->vmhub[vmhub];
> -	tmp = gmc_v9_0_get_invalidate_req(vmid, flush_type);
> +	inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
>   
>   	/* This is necessary for a HW workaround under SRIOV as well
>   	 * as GFXOFF under bare metal
> @@ -493,7 +493,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		uint32_t req = hub->vm_inv_eng0_req + eng;
>   		uint32_t ack = hub->vm_inv_eng0_ack + eng;
>   
> -		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, tmp,
> +		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>   				1 << vmid);
>   		return;
>   	}
> @@ -521,7 +521,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
>   	}
>   
> -	WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, tmp);
> +	WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
>   
>   	/*
>   	 * Issue a dummy read to wait for the ACK register to be cleared
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

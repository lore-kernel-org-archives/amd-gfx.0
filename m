Return-Path: <SRS0=L/30=DT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 09:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D86214D8
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 09:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hprgHdnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D86214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB8666E239;
	Mon, 12 Oct 2020 09:11:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227556E42F
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2020 09:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFj2YAzIIw2qAVXrxCV9uHbtiCDV1oUgl7H43R4VTQcAIxwmy8Et75ySKpEMV8kIzqgrdJf56apgly2GXxGT/cBaUHG/Mfbu0SVQBjhScfvfQQ7Wh1RIjjl02C21vWLCPjF2aUMlqK+zIkSclnSdV+WMMTrJ2F+hfppfLZuKBp0NTBuQ4JCMRY1H2liGNSlyeiLwBEMkw59cr09QYEO1Fs9dpB23c9mg0ZN32N0uiDBE0R3WKj75He7QKUPqwWnd13rtyo6lTholn3Za4aS0BbtekKdeTdMCBp8kJGEtiGBhKb8zBLk2btNfg6I/0P6J6vFBrxThpW3PrwujdUQZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97L2VfGaWzzC6xP0sFll8Fd6jo192IUP2ZFJbg8FWKY=;
 b=dIHmYFS/vvOmnx82M2DaoBrd9hII43dhiOomSzNPK2LpXpsE7LvW5izvxl2EInb6J1yY7FD5jUgrXspX4NiP9zTjGMRhoaRfKZwfl37wcuAQ/TqblC4kz/p6lEUH9l9ttF3An8CCoSdoK4U/Ytpc0Ge03pijx0NHenyNy/ymo1/EwCTIQXT1xi8HeB6DPGeMz/UKNhx42MCk0SvLO6ZKP9KRfs+2ZWipjh7BO3my2FcLZIRe0IaEVMApnviWMUMGxcOfxniegbuiLaFGRsDHtSqx6K4kQnsIvXNtKqPzPR5orXE8H02nCgSbcjnBogNFQQnfY/m0GTU4zEvQGX/JZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97L2VfGaWzzC6xP0sFll8Fd6jo192IUP2ZFJbg8FWKY=;
 b=hprgHdnQvmvuDBf7dV2h8AmxuS1wnZ9fKYbpv7zqKyuueyV2424C5JXwBjino7F+M+VppSh58u1lkuWEih9WcORczzGhA5doOdvuivbxtnwRMf8TTexCQYzFDCWOv0Mznm8c9ClKW/frXpBKtkuiJJBfnNp2UZr0dAJ5h6fIO9Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Mon, 12 Oct
 2020 09:11:03 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 09:11:03 +0000
Subject: Re: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
To: Mihir Patel <mihir.patel@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201012090159.28825-1-mihir.patel@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d2d63bd0-61a0-33ce-67da-78143412d6b1@amd.com>
Date: Mon, 12 Oct 2020 11:10:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201012090159.28825-1-mihir.patel@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0109.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22 via Frontend Transport; Mon, 12 Oct 2020 09:11:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2655851e-99a9-4319-ea33-08d86e8ebe4a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4223BFA7A20737542E76E50683070@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cZdXP+94oKPD161gIVgkbj5QqlXXN9sf/hRCnPy9DvYtl1sUiFlckX43Lg9tCSZfi4sP7VeQwvMPDWIgdYxoR0lbKshrGmcO4IjhxrO18EYMEldqorOPlfdcxe5Fc2DqNItPmt3/rTbijfoD4Yk3YhDowl9Sl4cEuFYF3crLOgzeAXwhD867Q/7n+9tY+s0pJ+oEdfsR3QJ1iTLvCx9umMWELzCZfpwqibASxQ2lL41dMk+7W2+2ag4vlhLduwINU/Gkyr2NQrKRZxqx4hbMXgeuAqtDg7zXLlXvfmSCFi9T8r1N/AkCRemVLprkjR4LsMlUY5fRfZjlvvKeACPQ/Z+LN8kE9k2klOoXxefNA0KD3qoupiOa7/zT+W2J49zy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(66556008)(66476007)(5660300002)(66946007)(6666004)(30864003)(6486002)(31696002)(83380400001)(86362001)(31686004)(8936002)(16526019)(186003)(316002)(2616005)(478600001)(52116002)(8676002)(4326008)(2906002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BYZOQC0w5a6AT5WHSJByX1mNBEp6uJ4qc4LDNJxRvD68ySIG3XUQarPZ1Zh5CouOx2KDPKsMnEehE6UoR11pZ30t5sdQPrEEMmLFgUFAWDcgcmBM6Rt7FpXj48rCkaWyMVfSXtW57oP5DPYSDbbm3vZtpo5tZZe9Oj3zX1Iw4YHTFYzpgCcg6+HfD480XPDe07dCEweMG28YU2IRa+iSTS8TnoBLNacA1s0oDtdFZvvnhh5j8a73fxu9YfGQjaZcYRCdzrWMq3VnRA5h0qKYmEaWiXWYD3xFy3cOh/s4bAc4BpR2mdcAsfoIG0CRK5JL1S382H4uh2UN+rpmp6fzrf+hXDlztYt6pMV4WatsntCaSs2+n5jMyoA4ZV5GhKId4hkhTqXYBfHcKjF1h9V0Vy0LWUxB6NeKz9HXjpehKTjMMMo5khaC/metFKyRlsA/62oKcW+VM5pr3VpplTp02CSP14e9WUwJz9UzpqicDtjKoCI8A2PlQaUnnL7gY40g3q+gj/ilFj4vP+4J2Zie8NdzsJUAHvQsutOs1ygR0GthkhEYcGHn6l14vnrvRrzyDKWW/fVpf7pYXBwmedTa5w3NDrb/Z1Fc3hzQN+6JjAtBov5q2XPpbcMF1N2W/Ul/TkbQ/hjIrv6h7r9niEegMIe14cf7qpm6yxMkVPf47VVQmls+FAv+8qKM1NHoJx1koznwnoAY8YmMAP/g428fNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2655851e-99a9-4319-ea33-08d86e8ebe4a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 09:11:03.2445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNhiD0ET62TWcjoXEyTgoYLQgMG96lDpJGFT0WW6xA2t4r+wsgHLfAxkdRhSg6K8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
Cc: Madhav.Chauhan@amd.com, alexander.deucher@amd.com, pkamliya@amd.com,
 ksurampa@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.10.20 um 11:01 schrieb Mihir Patel:
> From: Mihir Bhogilal Patel <Mihir.Patel@amd.com>
>
> Create new debugfs entry to print memory info using VM buffer
> objects.
>
> Pending:
> - Consolidated memory utilization info like total, swap etc.
>
> V2: Added Common function for printing BO info.
>      Dump more VM lists for evicted, moved, relocated, invalidated.
>      Removed dumping VM mapped BOs.
> V3: Fixed coding style comments, renamed print API and variables.
>
> Signed-off-by: Mihir Bhogilal Patel <Mihir.Patel@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 30 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 69 ++--------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 74 +++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 88 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  4 +
>   6 files changed, 204 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 2d125b8b15ee..0b41b8b72ba3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1335,11 +1335,41 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> +static int amdgpu_debugfs_vm_info(struct seq_file *m, void *data)
> +{
> +	struct drm_info_node *node = (struct drm_info_node *)m->private;
> +	struct drm_device *dev = node->minor->dev;
> +	struct drm_file *file;
> +	int r;
> +
> +	r = mutex_lock_interruptible(&dev->filelist_mutex);
> +	if (r)
> +		return r;
> +
> +	list_for_each_entry(file, &dev->filelist, lhead) {
> +		struct amdgpu_fpriv *fpriv = file->driver_priv;
> +		struct amdgpu_vm *vm = &fpriv->vm;
> +
> +		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
> +				vm->task_info.pid, vm->task_info.process_name);
> +		r = amdgpu_bo_reserve(vm->root.base.bo, true);
> +		if (r)
> +			continue;

I would rather say break here and return r from the function as well.

When reading this debugfs file is aborted using ctrl+c we would 
otherwise just continue with the loop.

> +		amdgpu_debugfs_vm_bo_info(vm, m);
> +		amdgpu_bo_unreserve(vm->root.base.bo);
> +	}
> +
> +	mutex_unlock(&dev->filelist_mutex);
> +
> +	return 0;
> +}
> +
>   static const struct drm_info_list amdgpu_debugfs_list[] = {
>   	{"amdgpu_vbios", amdgpu_debugfs_get_vbios_dump},
>   	{"amdgpu_test_ib", &amdgpu_debugfs_test_ib},
>   	{"amdgpu_evict_vram", &amdgpu_debugfs_evict_vram},
>   	{"amdgpu_evict_gtt", &amdgpu_debugfs_evict_gtt},
> +	{"amdgpu_vm_info", &amdgpu_debugfs_vm_info},
>   };
>   
>   static void amdgpu_ib_preempt_fences_swap(struct amdgpu_ring *ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f4c2e2e75b8f..6197c5ce744c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -826,67 +826,6 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>   }
>   
>   #if defined(CONFIG_DEBUG_FS)
> -
> -#define amdgpu_debugfs_gem_bo_print_flag(m, bo, flag)	\
> -	if (bo->flags & (AMDGPU_GEM_CREATE_ ## flag)) {	\
> -		seq_printf((m), " " #flag);		\
> -	}
> -
> -static int amdgpu_debugfs_gem_bo_info(int id, void *ptr, void *data)
> -{
> -	struct drm_gem_object *gobj = ptr;
> -	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> -	struct seq_file *m = data;
> -
> -	struct dma_buf_attachment *attachment;
> -	struct dma_buf *dma_buf;
> -	unsigned domain;
> -	const char *placement;
> -	unsigned pin_count;
> -
> -	domain = amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type);
> -	switch (domain) {
> -	case AMDGPU_GEM_DOMAIN_VRAM:
> -		placement = "VRAM";
> -		break;
> -	case AMDGPU_GEM_DOMAIN_GTT:
> -		placement = " GTT";
> -		break;
> -	case AMDGPU_GEM_DOMAIN_CPU:
> -	default:
> -		placement = " CPU";
> -		break;
> -	}
> -	seq_printf(m, "\t0x%08x: %12ld byte %s",
> -		   id, amdgpu_bo_size(bo), placement);
> -
> -	pin_count = READ_ONCE(bo->pin_count);
> -	if (pin_count)
> -		seq_printf(m, " pin count %d", pin_count);
> -
> -	dma_buf = READ_ONCE(bo->tbo.base.dma_buf);
> -	attachment = READ_ONCE(bo->tbo.base.import_attach);
> -
> -	if (attachment)
> -		seq_printf(m, " imported from %p%s", dma_buf,
> -			   attachment->peer2peer ? " P2P" : "");
> -	else if (dma_buf)
> -		seq_printf(m, " exported as %p", dma_buf);
> -
> -	amdgpu_debugfs_gem_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
> -	amdgpu_debugfs_gem_bo_print_flag(m, bo, NO_CPU_ACCESS);
> -	amdgpu_debugfs_gem_bo_print_flag(m, bo, CPU_GTT_USWC);
> -	amdgpu_debugfs_gem_bo_print_flag(m, bo, VRAM_CLEARED);
> -	amdgpu_debugfs_gem_bo_print_flag(m, bo, SHADOW);
> -	amdgpu_debugfs_gem_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
> -	amdgpu_debugfs_gem_bo_print_flag(m, bo, VM_ALWAYS_VALID);
> -	amdgpu_debugfs_gem_bo_print_flag(m, bo, EXPLICIT_SYNC);
> -
> -	seq_printf(m, "\n");
> -
> -	return 0;
> -}
> -
>   static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
>   {
>   	struct drm_info_node *node = (struct drm_info_node *)m->private;
> @@ -900,6 +839,8 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
>   
>   	list_for_each_entry(file, &dev->filelist, lhead) {
>   		struct task_struct *task;
> +		struct drm_gem_object *gobj;
> +		int id;
>   
>   		/*
>   		 * Although we have a valid reference on file->pid, that does
> @@ -914,7 +855,11 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
>   		rcu_read_unlock();
>   
>   		spin_lock(&file->table_lock);
> -		idr_for_each(&file->object_idr, amdgpu_debugfs_gem_bo_info, m);
> +		idr_for_each_entry(&file->object_idr, gobj, id) {
> +			struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +
> +			amdgpu_bo_print_info(id, bo, m);
> +		}
>   		spin_unlock(&file->table_lock);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 2ce79bccfc30..f4142b7a3c59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1528,3 +1528,77 @@ uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
>   	}
>   	return domain;
>   }
> +
> +#if defined(CONFIG_DEBUG_FS)
> +#define amdgpu_bo_print_flag(m, bo, flag)		        \
> +	do {							\
> +		if (bo->flags & (AMDGPU_GEM_CREATE_ ## flag)) {	\
> +			seq_printf((m), " " #flag);		\
> +		}						\
> +	} while (0)
> +
> +/**
> + * amdgpu_debugfs_print_bo_info - print BO info in debugfs file
> + *
> + * @id: Index or Id of the BO
> + * @bo: Requested BO for printing info
> + * @data: debugfs file
> + *
> + * Print BO information in debugfs file
> + *
> + * Returns:
> + * Size of the BO in bytes.
> + */
> +unsigned long amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)

Please use uint64_t or u64 for the return type.

> +{
> +	struct dma_buf_attachment *attachment;
> +	struct dma_buf *dma_buf;
> +	unsigned int domain;
> +	const char *placement;
> +	unsigned int pin_count;
> +	unsigned long size;

Same here of course.

> +
> +	domain = amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type);
> +	switch (domain) {
> +	case AMDGPU_GEM_DOMAIN_VRAM:
> +		placement = "VRAM";
> +		break;
> +	case AMDGPU_GEM_DOMAIN_GTT:
> +		placement = " GTT";
> +		break;
> +	case AMDGPU_GEM_DOMAIN_CPU:
> +	default:
> +		placement = " CPU";
> +		break;
> +	}
> +
> +	size = amdgpu_bo_size(bo);
> +	seq_printf(m, "\t\t0x%08x: %12ld byte %s",
> +			id++, size, placement);

Incrementing id here is pointless.

Maybe move this outside the function as well, but this is not a hard 
requirement.

> +
> +	pin_count = READ_ONCE(bo->pin_count);
> +	if (pin_count)
> +		seq_printf(m, " pin count %d", pin_count);
> +
> +	dma_buf = READ_ONCE(bo->tbo.base.dma_buf);
> +	attachment = READ_ONCE(bo->tbo.base.import_attach);
> +
> +	if (attachment)
> +		seq_printf(m, " imported from %p", dma_buf);
> +	else if (dma_buf)
> +		seq_printf(m, " exported as %p", dma_buf);
> +
> +	amdgpu_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
> +	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
> +	amdgpu_bo_print_flag(m, bo, CPU_GTT_USWC);
> +	amdgpu_bo_print_flag(m, bo, VRAM_CLEARED);
> +	amdgpu_bo_print_flag(m, bo, SHADOW);
> +	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
> +	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
> +	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
> +
> +	seq_puts(m, "\n");
> +
> +	return size;
> +}
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index afa5189dba7d..06fbff49958d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -330,6 +330,7 @@ void amdgpu_sa_bo_free(struct amdgpu_device *adev,
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
>   					 struct seq_file *m);
> +unsigned long amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
>   #endif
>   int amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3cd949aad500..0e1cb399e508 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3392,3 +3392,91 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
>   
>   	return false;
>   }
> +
> +#if defined(CONFIG_DEBUG_FS)
> +/**
> + * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
> + *
> + * @vm: Requested VM for printing BO info
> + * @data: debugfs file
> + *
> + * Print BO information in debugfs file for the VM
> + */
> +void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
> +{
> +	struct amdgpu_bo_va *bo_va, *tmp;
> +	u64 total_idle = 0;
> +	u64 total_evicted = 0;
> +	u64 total_relocated = 0;
> +	u64 total_moved = 0;
> +	u64 total_invalidated = 0;
> +	unsigned int total_idle_objs = 0;
> +	unsigned int total_evicted_objs = 0;
> +	unsigned int total_relocated_objs = 0;
> +	unsigned int total_moved_objs = 0;
> +	unsigned int total_invalidated_objs = 0;
> +	unsigned int id = 0;
> +
> +	/* Print info for Idle BOs */

I would drop those comments, they just duplicate what the printed text 
says anyway.

> +	seq_puts(m, "\tIdle BOs:\n");
> +	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +	}
> +	total_idle_objs = id;
> +	id = 0;
> +
> +	/* Print info for Evicted BOs */
> +	seq_puts(m, "\tEvicted BOs:\n");
> +	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +	}
> +	total_evicted_objs = id;
> +	id = 0;
> +
> +	/* Print info for Relocated BOs */
> +	seq_puts(m, "\tRelocated BOs:\n");
> +	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +	}
> +	total_relocated_objs = id;
> +	id = 0;
> +
> +	/* Print info for Moved BOs */
> +	seq_puts(m, "\tMoved BOs:\n");
> +	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +	}
> +	total_moved_objs = id;
> +	id = 0;
> +
> +	/* Print info for Invalidated BOs */
> +	seq_puts(m, "\tInvalidated BOs:\n");
> +	spin_lock(&vm->invalidated_lock);
> +	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
> +	}
> +	spin_unlock(&vm->invalidated_lock);
> +	total_invalidated_objs = id;
> +
> +	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> +								total_idle_objs);

The coding style here is still odd, the second line should start after 
the ( of the first line.

Apart from that looks good to me,
Christian.

> +	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
> +								total_evicted_objs);
> +	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
> +								total_relocated_objs);
> +	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
> +								total_moved_objs);
> +	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
> +								total_invalidated_objs);
> +}
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 7c46937c1c0e..74cc14179c41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -441,4 +441,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
>   
> +#if defined(CONFIG_DEBUG_FS)
> +void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
> +#endif
> +
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

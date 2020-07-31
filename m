Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE42C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 13:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FA22245C
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 13:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UcIMKoMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FA22245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E676E927;
	Fri, 31 Jul 2020 13:53:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 908D26E927
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 13:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aODyuXFuNIEVjhFVrVuB9b2SDwfE2k3Rfzuv07/6v0oB1auMI6IWApVVrR0TgzwXyL1GgeGoPafsTlR4R+gtmSDLDabq3KZPrFEcKG91jjEW6o7buPoSc5gSSMdPYrxl54BH1xz6pbAkjsgDsjaXhds/9FMOnJ9WvAA3SFkngLPDCSifcX7jJOCp85Hdj71N7RZc71atgK1DJMdsKE3bjh7GBgfBJ0S/b0Qc6opGbPuAk5l50lsejL7ri6jhDJmCRb6cmv16m+AwBwHk5YLxxNLa2j5Ino8c6ZxRjsuNLj7m4F7krIbyCLfmE8O60JlNOfokPS50Qn4wbvSd1HWKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnSv5fitPrs45QivBDPcRINRXRDKPzhG4WS8uaST0DM=;
 b=gk78fScyuF0uye48IrFGm+Pj3p1eLz2DB7ENVF1dEVuaScgLFwIpHXCuezcZ/UK2xgFrU+356mJAjyLg9d1y5NqBEWaznSo9fCql0NcF1SkUhX50QgCCW8Kt9TuLaHGq6LGqO3h7he/fx8Y2VV3BVKNKKx7qvxLEpnm+jnns6BHGI/1Sm+9F03N6IvReeQ8czaaYycocMy5MSw6cZ4YE0CjsbNASFeTciQjhbRxX9Bxhg7ntBEAKG/txmYiomL5q3srBJrZMBe3a5MJm2PA+e6vwEYM3iCtkhwri0G2wQX67dfD7qmrW8veT3clp/DsLR8bPQSrIrYxlGcvI9kTkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnSv5fitPrs45QivBDPcRINRXRDKPzhG4WS8uaST0DM=;
 b=UcIMKoMI6chZuGy9dWkxuO61oF4+FFG+PLvp7sQTfIqyQkEtF1mjHs1mWGHhs/UvakcmqLJPWz5odQI9WvJUVBooZRwjFU+ruVjHj0JNOLnVl1P07U+BaJ0WO+Lcz9ycUf8kllFFnzC0NNWhcmJ5t6z0Ejka3si5r6hUcakqlFw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 13:53:34 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9%7]) with mapi id 15.20.3239.019; Fri, 31 Jul 2020
 13:53:34 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: introduce a new parameter to configure
 how many KCQ we want(v5)
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1596181868-28879-1-git-send-email-Monk.Liu@amd.com>
 <1596181868-28879-2-git-send-email-Monk.Liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <904d9605-f061-d6a0-b72b-42b0d73bf11d@amd.com>
Date: Fri, 31 Jul 2020 09:53:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1596181868-28879-2-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::30) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 13:53:33 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65763e94-87ca-4dc9-87f0-08d835591da9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23666CB0F2F4B969BFD890FA924E0@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyr4oiZ7VRgJ7my5FG9L0lk+LkCqJBEv4s8lC3/GUeTKeGixEbLQMIo0HES4NSVZKe6uxKvr2P0gNRoKYzy+TqloQ/uyFF9bxj1KeUJM76ycng+v91hxS/f4Iosyr5YYfo8JHBKIdS60+w9Y5dUdF8T6RHReaJuLpo6vBCDNaMkYTZmksY08PgPwoynhN/5YQeTQsuEAoBtPqcmS+RjOFg6o10xwhheJNvLJ4KJDq6zl85/kbd4J1BSqipo9EgOaYNThPA6oh9tBmIHJ9++AqnpSszKipjf02ksUW7b+QSR8vRHT9DZGBbOmRGlqnJvSf5IjHa/dpboWLMu2eKeNmIiBYXkvhQLhgZb3FcFzDi0TyUegyxQjrGxyC379XgD1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(186003)(16526019)(6486002)(36756003)(8676002)(2906002)(31686004)(83380400001)(8936002)(52116002)(26005)(44832011)(2616005)(956004)(66476007)(66556008)(66946007)(16576012)(86362001)(31696002)(316002)(478600001)(5660300002)(30864003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /8Bntiov83+lIv3PoNHvg+2iBYtSpAvpMuFsc55vSwsV19cKkuzlMg8c6nLCpDB8umFHMXPdi7rjPtkvNfHGN0QZL8z7oQks03CjczvwuRYEctVXk45/u6mZdzZCjKNwiJCAwIA7g+nIfSe1eVTNln6PvFwTHsNqGQKUKhlL1WQEicJ+iIJ40dVfGveLccRKNrHyhR5DHanhg8VeOz3N1mY15yU1hCu4SD2IWNpQEwVydTkP3lWJlGGtjiKmi7OkVHkuwmb7NYZN5zBgM4c93QcIKCbvRrSmPxJeJx2PRw3iI0ZtIn/z9y56XowDWLQgyorN8/MQpeiobBJDtftOY81HVyuKgHdFkh7ZVsD8cwgpzyG7SFCdIZBwPISbDRJpCvnpZE6ZEAv+5oxTRaD73syH+fQ0bBFqIjddxNOyFDjKkV3M11xrzG4GAdooPyTlkQrqa7jIri7URpfx5TDE8AeVHhEwq1vii7tD3f8tJSMqj0Uaq5DXqHDFMCniils4i67NtqR2hcbSQU8I7Jbqo+f5GNMd3488VQY1+zE5PP8iiEn8ReUPxbdZPLLVNbdHI9whSmLMJ62ozxfU6T41/m26v02AODrPEpPsA1UEBgcL+fgaOTYvHvXRCA3iy2EsUo6uV35Fkub+5qOBR74MrA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65763e94-87ca-4dc9-87f0-08d835591da9
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 13:53:34.0385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJowV2hfK2W3jIuaReOzrACeM/TnJksifa2daeISlPSvCW1muWWduTsluir3u9Fw4pWiNNqb30GL9zQ2LedlaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-07-31 um 3:51 a.m. schrieb Monk Liu:
> what:
> the MQD's save and restore of KCQ (kernel compute queue)
> cost lots of clocks during world switch which impacts a lot
> to multi-VF performance
>
> how:
> introduce a paramter to control the number of KCQ to avoid
> performance drop if there is no kernel compute queue needed
>
> notes:
> this paramter only affects gfx 8/9/10
>
> v2:
> refine namings
>
> v3:
> choose queues for each ring to that try best to cross pipes evenly.
>
> v4:
> fix indentation
> some cleanupsin the gfx_compute_queue_acquire()
>
> v5:
> further fix on indentations
> more cleanupsin gfx_compute_queue_acquire()
>
> TODO:
> in the future we will let hypervisor driver to set this paramter
> automatically thus no need for user to configure it through
> modprobe in virtual machine
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>

This patch is Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 49 ++++++++++++------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 30 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 29 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 31 ++++++++++---------
>  7 files changed, 76 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e97c088..de11136 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -201,6 +201,7 @@ extern int amdgpu_si_support;
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  extern int amdgpu_cik_support;
>  #endif
> +extern int amdgpu_num_kcq;
>  
>  #define AMDGPU_VM_MAX_NUM_CTX			4096
>  #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62ecac9..cf445bab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1199,6 +1199,11 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>  
>  	amdgpu_gmc_tmz_set(adev);
>  
> +	if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
> +		amdgpu_num_kcq = 8;
> +		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid paramter provided by user\n");
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6291f5f..b545c40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -150,6 +150,7 @@ int amdgpu_noretry;
>  int amdgpu_force_asic_type = -1;
>  int amdgpu_tmz = 0;
>  int amdgpu_reset_method = -1; /* auto */
> +int amdgpu_num_kcq = -1;
>  
>  struct amdgpu_mgpu_info mgpu_info = {
>  	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> @@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
>  MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
>  module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>  
> +MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
> +module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
> +
>  static const struct pci_device_id pciidlist[] = {
>  #ifdef  CONFIG_DRM_AMDGPU_SI
>  	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8eff017..0cd9de6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -202,40 +202,29 @@ bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
>  
>  void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
>  {
> -	int i, queue, pipe, mec;
> +	int i, queue, pipe;
>  	bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
> -
> -	/* policy for amdgpu compute queue ownership */
> -	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
> -		queue = i % adev->gfx.mec.num_queue_per_pipe;
> -		pipe = (i / adev->gfx.mec.num_queue_per_pipe)
> -			% adev->gfx.mec.num_pipe_per_mec;
> -		mec = (i / adev->gfx.mec.num_queue_per_pipe)
> -			/ adev->gfx.mec.num_pipe_per_mec;
> -
> -		/* we've run out of HW */
> -		if (mec >= adev->gfx.mec.num_mec)
> -			break;
> -
> -		if (multipipe_policy) {
> -			/* policy: amdgpu owns the first two queues of the first MEC */
> -			if (mec == 0 && queue < 2)
> -				set_bit(i, adev->gfx.mec.queue_bitmap);
> -		} else {
> -			/* policy: amdgpu owns all queues in the first pipe */
> -			if (mec == 0 && pipe == 0)
> -				set_bit(i, adev->gfx.mec.queue_bitmap);
> +	int max_queues_per_mec = min(adev->gfx.mec.num_pipe_per_mec *
> +				     adev->gfx.mec.num_queue_per_pipe,
> +				     adev->gfx.num_compute_rings);
> +
> +	if (multipipe_policy) {
> +		/* policy: make queues evenly cross all pipes on MEC1 only */
> +		for (i = 0; i < max_queues_per_mec; i++) {
> +			pipe = i % adev->gfx.mec.num_pipe_per_mec;
> +			queue = (i / adev->gfx.mec.num_pipe_per_mec) %
> +				adev->gfx.mec.num_queue_per_pipe;
> +
> +			set_bit(pipe * adev->gfx.mec.num_queue_per_pipe + queue,
> +					adev->gfx.mec.queue_bitmap);
>  		}
> +	} else {
> +		/* policy: amdgpu owns all queues in the given pipe */
> +		for (i = 0; i < max_queues_per_mec; ++i)
> +			set_bit(i, adev->gfx.mec.queue_bitmap);
>  	}
>  
> -	/* update the number of active compute rings */
> -	adev->gfx.num_compute_rings =
> -		bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
> -
> -	/* If you hit this case and edited the policy, you probably just
> -	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
> -	if (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
> -		adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	dev_dbg(adev->dev, "mec queue bitmap weight=%d\n", bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES));
>  }
>  
>  void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index f571e25..4172bc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4022,21 +4022,23 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
>  	amdgpu_gfx_compute_queue_acquire(adev);
>  	mec_hpd_size = adev->gfx.num_compute_rings * GFX10_MEC_HPD_SIZE;
>  
> -	r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &adev->gfx.mec.hpd_eop_obj,
> -				      &adev->gfx.mec.hpd_eop_gpu_addr,
> -				      (void **)&hpd);
> -	if (r) {
> -		dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> -		gfx_v10_0_mec_fini(adev);
> -		return r;
> -	}
> +	if (mec_hpd_size) {
> +		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +					      AMDGPU_GEM_DOMAIN_GTT,
> +					      &adev->gfx.mec.hpd_eop_obj,
> +					      &adev->gfx.mec.hpd_eop_gpu_addr,
> +					      (void **)&hpd);
> +		if (r) {
> +			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> +			gfx_v10_0_mec_fini(adev);
> +			return r;
> +		}
>  
> -	memset(hpd, 0, mec_hpd_size);
> +		memset(hpd, 0, mec_hpd_size);
>  
> -	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> -	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +	}
>  
>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
>  		mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
> @@ -7162,7 +7164,7 @@ static int gfx_v10_0_early_init(void *handle)
>  		break;
>  	}
>  
> -	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	adev->gfx.num_compute_rings = amdgpu_num_kcq;
>  
>  	gfx_v10_0_set_kiq_pm4_funcs(adev);
>  	gfx_v10_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 8d72089..7df567a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1343,21 +1343,22 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
>  	amdgpu_gfx_compute_queue_acquire(adev);
>  
>  	mec_hpd_size = adev->gfx.num_compute_rings * GFX8_MEC_HPD_SIZE;
> +	if (mec_hpd_size) {
> +		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +					      AMDGPU_GEM_DOMAIN_VRAM,
> +					      &adev->gfx.mec.hpd_eop_obj,
> +					      &adev->gfx.mec.hpd_eop_gpu_addr,
> +					      (void **)&hpd);
> +		if (r) {
> +			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> +			return r;
> +		}
>  
> -	r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->gfx.mec.hpd_eop_obj,
> -				      &adev->gfx.mec.hpd_eop_gpu_addr,
> -				      (void **)&hpd);
> -	if (r) {
> -		dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> -		return r;
> -	}
> -
> -	memset(hpd, 0, mec_hpd_size);
> +		memset(hpd, 0, mec_hpd_size);
>  
> -	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> -	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +	}
>  
>  	return 0;
>  }
> @@ -5294,7 +5295,7 @@ static int gfx_v8_0_early_init(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
>  	adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	adev->gfx.num_compute_rings = amdgpu_num_kcq;
>  	adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
>  	gfx_v8_0_set_ring_funcs(adev);
>  	gfx_v8_0_set_irq_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e4e751f..ef07e59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1938,22 +1938,23 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
>  	/* take ownership of the relevant compute queues */
>  	amdgpu_gfx_compute_queue_acquire(adev);
>  	mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
> +	if (mec_hpd_size) {
> +		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +					      AMDGPU_GEM_DOMAIN_VRAM,
> +					      &adev->gfx.mec.hpd_eop_obj,
> +					      &adev->gfx.mec.hpd_eop_gpu_addr,
> +					      (void **)&hpd);
> +		if (r) {
> +			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> +			gfx_v9_0_mec_fini(adev);
> +			return r;
> +		}
>  
> -	r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->gfx.mec.hpd_eop_obj,
> -				      &adev->gfx.mec.hpd_eop_gpu_addr,
> -				      (void **)&hpd);
> -	if (r) {
> -		dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> -		gfx_v9_0_mec_fini(adev);
> -		return r;
> -	}
> -
> -	memset(hpd, 0, mec_hpd_size);
> +		memset(hpd, 0, mec_hpd_size);
>  
> -	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> -	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +	}
>  
>  	mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
>  
> @@ -4625,7 +4626,7 @@ static int gfx_v9_0_early_init(void *handle)
>  		adev->gfx.num_gfx_rings = 0;
>  	else
>  		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	adev->gfx.num_compute_rings = amdgpu_num_kcq;
>  	gfx_v9_0_set_kiq_pm4_funcs(adev);
>  	gfx_v9_0_set_ring_funcs(adev);
>  	gfx_v9_0_set_irq_funcs(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

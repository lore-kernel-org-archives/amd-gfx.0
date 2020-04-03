Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9B1C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 06:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAFE2073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 06:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="agn52P8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAFE2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64CC6EAF7;
	Fri,  3 Apr 2020 06:26:56 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700066.outbound.protection.outlook.com [40.107.70.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7779F6EAF2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 06:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acRSduyYdob5Rncvvk7RzObYDlj+xD4KXu7oxQD8iTeWJkUrNuShi7OFSkchj7Qrp+QylooZFUYbfqbWsVhbPSjQgeZLVh7x7xyrBhcWCyZ16rpvbN1bezY/7NHt+yQJHyJFrb+T5/ouH27r0iWtIRbXfQw2NefilYngchjsiGB8AFIwqNwKF8ZBrluoLtbRYU2SIeBc/mswd5Wu+QZRMmten+y8Htq9TUGYLqlWU691/BT0Z/a/+soxRmnUj5+L5M1YNmoJQjEbMjGuZ28JT7cf/vGvHQj08sikrFpxUI5f/YeZYsjg1fvfcwib5iRcl/WC658qzhcCPCOT+eyZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNLQBNGyO10UbwNxATsMRdoGUCxpDyplkWGHJaZi9Jk=;
 b=cEBScdrI0A3vzal88LzqeI/bZ3nwDxH1scMuRLZWKWAAkRtTSWzXEgerw8aXOvth0Q4rTcWi0Uw5Dbff8R1sL0/AdAqRM5tBWOAtgqYtKARGdgugB5gkGN7O315wacDW8JukgkyD/wAOQeQpVjRFd5QAi3k8KJT+DDfmThcHLAfNN8iLwLlXp7ysdAKTJpLEuWIhmVfOwGV2iAGGtLx3WywY5z6UbDF0fNaI7899AUA5R9F0QfYCv85w72cwWlLR64rQEGge8Ig1A7m5S0llHYfK63j0ZAJQnmNr4wIUrU8g1lZn7LXaTZxTwxa+u+VQKZUconbDsw6QRm/LYupVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNLQBNGyO10UbwNxATsMRdoGUCxpDyplkWGHJaZi9Jk=;
 b=agn52P8fyFJqBV77RszM+uNtNrh8KVfZ+n80CamHsDr7n/AhsrdfdMp9t4zY5Hqz/U0WFnxd47+ub7GrzXZaFOt8h8xOhVo5w7iFFEP/SokS2373o/T+s6NuuVu0srR+VCuAMIt6u/zgD35oBfxFuQuKjIus+iCn5q2tj9EITpk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB2974.namprd12.prod.outlook.com (2603:10b6:208:c1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Fri, 3 Apr
 2020 06:26:54 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 06:26:53 +0000
Date: Fri, 3 Apr 2020 14:26:44 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Message-ID: <20200403062642.GA9191@jenkins-Celadon-RN>
References: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
Content-Disposition: inline
In-Reply-To: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR0401CA0014.apcprd04.prod.outlook.com (2603:1096:202:2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Fri, 3 Apr 2020 06:26:51 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d83624fc-e1ec-4748-618d-08d7d798004b
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:|MN2PR12MB2974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB29742FEC4B9F6EB809D5E83DECC70@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(54906003)(9686003)(478600001)(55016002)(52116002)(6496006)(66556008)(33656002)(1076003)(6862004)(86362001)(2906002)(8936002)(33716001)(16526019)(81166006)(8676002)(316002)(66476007)(66946007)(26005)(6636002)(81156014)(5660300002)(6666004)(4326008)(956004)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obmVTvwKhMZS+PmeCGtkBQnN0kqF3AAPgBhLdJStHBX3mEKCYuK/zSroHBbd8pXoVFCt3MkdwOzYpaKxDIFr1O4+HTO8ACJMsYCv7Ts9vuBWTjlNZg/dTUyj/9+t6RLPybEgVJfAHS9QgzwhtsljRbE5SeSJn7XhCKzOqn5Fq9+jkEDO4Bz6q8eHSvoBfNyVbeEVeLkFN8Vx4IFV2IRI9fOJXkv0+7tdY7UgyfJkwNylIg5pE+5Ey7E0FIdh3lWiUb5T0AXB6bZW/v7aukl3CI0KWH/hfEMPMGJmhKaqIy6rcXiLjQ3C9ueo1xweN9rwuh8Zi+hup103/zsOKq43PED1rm2lLzEpHYOQo9MTVDHn5+ao4gl8KkPU/Vfjitj4umcJeDQ3282eoV87eJ1ngZm7BZy2jtNNYn4p4R9+e79N6PshDK+TRm1sx7ofr8hr
X-MS-Exchange-AntiSpam-MessageData: W2G1Qc+BhirWajKfqOcMir7Yvj6o0aK2lFqeRwy7aXL09kA4f7S80rjQ5esgRkyCC4bNeGmU590vEw5/sgpLwoBPwESvZW8J5aQmp1/1IYQH+CO3UgYyH462PJR708qfsoXz2Ey85RuJBWmpYjn4bA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83624fc-e1ec-4748-618d-08d7d798004b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 06:26:53.7554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTHPfGwrUUCU+ubzdk7+Ep069eY36VYgwARE4qwXO7vj2h+F5GMHDDD7e3esi6oxB8BR1rqTQAHbnQqrmaONWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

(+ Felix)

On Fri, Apr 03, 2020 at 12:07:53PM +0800, Liang, Prike wrote:
> The system will be hang up during S3 as SMU is pending at GC not
> respose the register CP_HQD_ACTIVE access request and this issue
> can be fixed by adding RLC safe mode guard before each HQD
> map/unmap retrive opt.

We need more information for the issue, does the map/unmap is required for
MAP_QUEUES/UNMAP_QUEUES packets or writing with MMIO or both?

From your patch, you just protect the kernel kiq and user queue. What about
other kernel compute queues? HIQ?

Thanks,
Ray

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index df841c2..e265063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -232,6 +232,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>  	uint32_t *mqd_hqd;
>  	uint32_t reg, hqd_base, data;
>  
> +	amdgpu_gfx_rlc_enter_safe_mode(adev);
>  	m = get_mqd(mqd);
>  
>  	acquire_queue(kgd, pipe_id, queue_id);
> @@ -299,6 +300,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>  
>  	release_queue(kgd);
>  
> +	amdgpu_gfx_rlc_exit_safe_mode(adev);
>  	return 0;
>  }
>  
> @@ -497,6 +499,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
>  	bool retval = false;
>  	uint32_t low, high;
>  
> +	amdgpu_gfx_rlc_enter_safe_mode(adev);
>  	acquire_queue(kgd, pipe_id, queue_id);
>  	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
>  	if (act) {
> @@ -508,6 +511,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
>  			retval = true;
>  	}
>  	release_queue(kgd);
> +	amdgpu_gfx_rlc_exit_safe_mode(adev);
>  	return retval;
>  }
>  
> @@ -541,6 +545,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>  	uint32_t temp;
>  	struct v9_mqd *m = get_mqd(mqd);
>  
> +	amdgpu_gfx_rlc_enter_safe_mode(adev);
>  	if (adev->in_gpu_reset)
>  		return -EIO;
>  
> @@ -577,6 +582,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>  	}
>  
>  	release_queue(kgd);
> +	amdgpu_gfx_rlc_exit_safe_mode(adev);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1fea077..ee107d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3533,6 +3533,7 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
>  	struct v9_mqd *mqd = ring->mqd_ptr;
>  	int j;
>  
> +	amdgpu_gfx_rlc_enter_safe_mode(adev);
>  	/* disable wptr polling */
>  	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
>  
> @@ -3629,6 +3630,7 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
>  	if (ring->use_doorbell)
>  		WREG32_FIELD15(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
>  
> +	amdgpu_gfx_rlc_exit_safe_mode(adev);
>  	return 0;
>  }
>  
> @@ -3637,6 +3639,7 @@ static int gfx_v9_0_kiq_fini_register(struct amdgpu_ring *ring)
>  	struct amdgpu_device *adev = ring->adev;
>  	int j;
>  
> +	amdgpu_gfx_rlc_enter_safe_mode(adev);
>  	/* disable the queue if it's active */
>  	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
>  
> @@ -3668,6 +3671,7 @@ static int gfx_v9_0_kiq_fini_register(struct amdgpu_ring *ring)
>  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI, 0);
>  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO, 0);
>  
> +	amdgpu_gfx_rlc_exit_safe_mode(adev);
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1646DC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 06:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7162120665
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 06:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hU7+nm6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7162120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54F489BD2;
	Wed, 11 Nov 2020 06:55:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE2789BD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 06:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIyjMgSd/mGEKtO62SJxgfhJq+2KrIsx5ZceBR9CHO6aPYwhlpCHHpLQhv8SX4gV8o61J5is4OviQf8zckUOS6RY970B64ZrUytFL8R+jrY0TVtnuX7Vld4/g0GDA53WJS09GxklklBBBWFmt/ErnI7LkyVS26guSTuh+O+IDW0p7/p5YrV2vcGP7+CDZ2gMTarr0I4BKQrvHXUY/Q/oGoSAu8pKeB5jxy6zCaE6WIAGL9UAccrVgrDu/ZoVfVF/PIcbNGYR8JxDn6bxbLK+gituj5CyuJdIL2TqCbPE9HXL5RoaInylWUJMQrR7kxLk33M4sxlOXuKII0CHomwclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUVPlWET5qBzxxIbx4WZM1G0Yu1SThFcDiNXjTSJ32c=;
 b=UF0EFNmO0gQp1DARwz4VD7PLeGUoL6jY3y1JFgwAOaPIyDoHdT8d/Ms4NVUoB/eKmixzGklJ7RhefP6ll0K1K+CvXcjfTdhRZF9butGTMWapF65OCB1EkcJG6tI66o1ZiSCaiT3bzSSTJNk0jk7ICuyDvbN0w8weu1v4xYOXErLy+vJVyc02AoT+cuZ6kyZt4cfQ/WC1+V6RnjzIwpjdP1cBLXd6fzGpXTQYa+jhAzZXScYP9Fk4vwVSrFT2s6nDSbT1B1VQsL2hBUJyH6Q835us+U1ofog/Z14KR32mM2hzCWyupGO1Zonz69ckpz0gd3s0ujlCJIaTDJ1kXuMdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUVPlWET5qBzxxIbx4WZM1G0Yu1SThFcDiNXjTSJ32c=;
 b=hU7+nm6UZ3tlP+wxZ2cZBIgl1D/BqdXUlSCOn3xTm4XGDA2O3RzSXe3K9705+We1+enDdtZM5FDGoBYsVfFB5X5tO5S16H5vGA2SzphFRWAai3xqetMYZd7bimdOgdkZH7qlP51JyBZTwXCnkhZudUo6GThrewXOo4C3k6w7AUg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2482.namprd12.prod.outlook.com (2603:10b6:207:4a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 06:55:11 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 06:55:11 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: fix compute queue priority if num_kcq is
 less than 4
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201109181214.35540-1-nirmoy.das@amd.com>
 <20201109181214.35540-2-nirmoy.das@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <69b6deee-083e-4371-ca46-d48b19627046@amd.com>
Date: Wed, 11 Nov 2020 01:55:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201109181214.35540-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.13.173]
X-ClientProxiedBy: YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::26) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.13.173) by
 YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 06:55:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38abde6c-1b1f-42c7-f1f9-08d8860ebbfb
X-MS-TrafficTypeDiagnostic: BL0PR12MB2482:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB248233EC2410C2B8390B2AB692E80@BL0PR12MB2482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dy4bgPObbXfGjZHdUL+XU8O4bz9PXeXVmittG1bXBaJDwnDcS1Wb6UwCUOgQdgF2vV3Iwt6uepGWBBX8SEFWq03Vhph309PVhpgNvWaMJXgqQJbztZkDvtBn3NntnE4H4ADPtYpaEGeJGddPiEp9TyliFThoBQF72oMNgGrANY68+bOlcsKb/iBLp/uP8luXk3SpTrrWWBXTGq084qHwTNAs7C+ya3RwlyXl2d1YYbD4r9U87xmy24CoUGFIgqSDZLO+PvtSxL5ot02Pv7/C5vQdRfvhwDC8JBxuaoP4WWIpZsIgj95bq1aKADiw5jHwZTsIUkacmruZPgOzg4tFaf/bVP37bhmajqoinXCaoHmUYoqzd7jcKpykbfaAvcbx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(52116002)(66946007)(66556008)(8936002)(8676002)(86362001)(2616005)(66476007)(2906002)(478600001)(44832011)(26005)(186003)(83380400001)(16526019)(4326008)(6486002)(956004)(31686004)(5660300002)(36756003)(31696002)(16576012)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: QuEJ5tS7BfApQdWIG4Hzds/kydorLBWmhTABSEIADjHP2eDgmc0xBYMT1rQQfRxciWv7pxNBluW7b7fpdeTsfqBnvAWMXBpB0uI3tq1qPbeyj5T18fDEHh0ExYOIBSA2fcNmebu6s3oQ2Skwf4R5ajHq3c6XubAemjw3akgnPGTr2cIEza63mLiIscNWGDl6hvuvxfHSjScYIyvgSddotUA0I4OcZFAkyhenH7ZRUf2WAVx8oPPF2cbk1U4YzxDWi2qiz2UxSzLYbRFKpcdJX05nG2yo1TfZFhLPEQNMcJujyhjqpoOTZQao/Q+WcMZpogJSuCVk7thUOGqodkbyVYRQWkwxj9GWeX1k8aDYz5nzEDNW+vi4uiec1xEM7E2aG/BjNKAx7+omwJWNOQ01kIYS/G7SM2wgRXSzpbT3NwTmZPOOLyA3wql4V43pyDqM9uxHBS9MJX1ZA4WlP+mTBXrn6FNBgFtQup9DMHEMPo0xzWwKrWq5rUok8UHdJBj9UxwJpFt0FbmwRgak7ynf0HEtUj9nSFaF+x0YN7E+R5esdVGT+p2ylYNpZ9A19YP8zADhqxYQpsyu2XOZLo/eSV6+8UuQdpj6AU3XO5iymskAxXXq4UANT/eeXLFewmxzHQVqXu1k1r/rcWzW5r1UDtKXGumK/Pvy/2S/stAim5q1Pg2LDyJaCTZKw+Gev2loZHwIXS57f5KrxM89Hb3xi1uw2QHN+M6Ns0VEAjNIvoZuJdUCtdfgeQ0KIiX/tri3lQ9bZV6XTfy7n2VvYLBS/G4A7KNyhduHvVDd2hgFMG0vRQ3YIasnE55thzSK+pFuMFRCA7iV1KamRLWeYt/Gm7i1OKxCj5tUpjVobGFNliMrvYuqM9YJ+cenMrPmjw475zZzDNhDeNqmV2F4TOeeZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38abde6c-1b1f-42c7-f1f9-08d8860ebbfb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 06:55:11.6580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKbvYBcX6b0gECCGbAcZw/S9fkj3At9pL9yruPyx2IYmirPddNqTE8ecCR15fbpv7PNv1tY0JpspLAzuU0B2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2482
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
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com, Guchun.Chen@amd.com,
 Aaron.Liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-11-09 um 1:12 p.m. schrieb Nirmoy Das:
> Compute queues are configurable with module param, num_kcq.
> amdgpu_gfx_is_high_priority_compute_queue was setting 1st 4 queues to
> high priority queue leaving a null drm scheduler in
> adev->gpu_sched[hw_ip]["normal_prio"].sched if num_kcq < 5.
>
> This patch tries to fix it by alternating compute queue priority between
> normal and high priority.
>
> Fixes: 33abcb1f5a1719b1c (drm/amdgpu: set compute queue priority at mqd_init)
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 +++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  7 +++++--
>  5 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index e584f48f3b54..97a8f786cf85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -193,10 +193,14 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
>  }
>  
>  bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
> -					       int queue)
> +					       int pipe, int queue)
>  {
> -	/* Policy: make queue 0 of each pipe as high priority compute queue */
> -	return (queue == 0);
> +	bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
> +	int cond;
> +	/* Policy: alternate between normal and high priority */
> +	cond = multipipe_policy ? pipe : queue;
> +
> +	return ((cond % 2) != 0);
>  
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 786eb4aa7314..671d4b37c397 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -374,7 +374,7 @@ void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
>  bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int mec,
>  				     int pipe, int queue);
>  bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
> -					       int queue);
> +					       int pipe, int queue);
>  int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
>  			       int pipe, int queue);
>  void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 8c3bad3dfc01..da5a139c7022 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4472,7 +4472,8 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
>  		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
>  		+ ring->pipe;
> -	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
> +	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
> +							    ring->queue) ?
>  			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
>  	/* type-2 packets are deprecated on MEC, use type-3 instead */
>  	r = amdgpu_ring_init(adev, ring, 1024,
> @@ -6507,7 +6508,8 @@ static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct
>  	struct amdgpu_device *adev = ring->adev;
>  
>  	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> +		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
> +							      ring->queue)) {
>  			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
>  			mqd->cp_hqd_queue_priority =
>  				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index c3fff49e6514..5e6d15f44560 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1923,7 +1923,8 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
>  		+ ring->pipe;
>  
> -	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
> +	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
> +							    ring->queue) ?
>  			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_RING_PRIO_DEFAULT;
>  	/* type-2 packets are deprecated on MEC, use type-3 instead */
>  	r = amdgpu_ring_init(adev, ring, 1024,
> @@ -4441,7 +4442,8 @@ static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *m
>  	struct amdgpu_device *adev = ring->adev;
>  
>  	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> +		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
> +							      ring->queue)) {
>  			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
>  			mqd->cp_hqd_queue_priority =
>  				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 3d6fb5a514c8..5d53baadd6f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2228,7 +2228,8 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
>  		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
>  		+ ring->pipe;
> -	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
> +	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
> +							    ring->queue) ?
>  			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
>  	/* type-2 packets are deprecated on MEC, use type-3 instead */
>  	return amdgpu_ring_init(adev, ring, 1024,
> @@ -3383,7 +3384,9 @@ static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *m
>  	struct amdgpu_device *adev = ring->adev;
>  
>  	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> +		if (amdgpu_gfx_is_high_priority_compute_queue(adev,
> +							      ring->pipe,
> +							      ring->queue)) {
>  			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
>  			mqd->cp_hqd_queue_priority =
>  				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

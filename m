Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C5FC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 09:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C6F20775
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 09:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Af0e1lJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C6F20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475E76E21E;
	Tue, 28 Jul 2020 09:04:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D60E6E21E
 for <amd-gfx@freedesktop.org>; Tue, 28 Jul 2020 09:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mywHe4QJ49MGIAq1cPvDOhvx3klXhWEXq1aEDQLhTB3ZdVupEuYmuP6OVSy5fgdsA+9EUe+cljF74NDilCXa6F8nqvE0TlftMkQ3XJwU2JpdPynZ2olcV10dAR9GA8BkXjvz2btFzKoznd0HihWwEw6sOZe3DTyZX/Q0ciAinEDujhnKXYRRArr7IqsCTCtn0+PNsM/A90kEMuAGaDiOPlkBOQZq0BKaTmkKFT3tAzl6zPpZeEzpBu6XWy/Zwcr3QdDU2aM7MgBmT11qgi1Tinz5CpCwLSPi00DAAfQ0mV4LiobWQprZqlqsFj6tchKFmWWtwm3SAy9ziAwu2L+6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwrMBQuI2UdQ+K1oe+83Fl0qKpoZvttaS9xrD71cbe8=;
 b=MCXdJNXBQ/L68SO+DhH2ewnNsnO9WWqQ5gAMAhVnAAr5oq/84o0TUsAXOA7/SZBKgoLO8HfO7Was9Z6JhGjpKq7QX1bLw/lTeTKT/wVP07oQ3QuOX04kKL64BeQ+HEVR3MZFScb2o5V28fCbAvC6aBbCGs5Rajry7eGes/ViKskdmNrIR3Zr+B3jU7bi9QTRDfzC5vr0VTbX9Qc1dqat/+P53uf1x7GQjgg/SUd5RVZ0Fv1q9/oOTCxhzOQL7u/IwLnwXylFPFodRpztWr99/VUZ6mi+83evVmAo1UIs/zgsMSH0oYyOWyjX3VpmYho+mHTNtvhXRmxsd49u1+doPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwrMBQuI2UdQ+K1oe+83Fl0qKpoZvttaS9xrD71cbe8=;
 b=Af0e1lJcEvgygCSLzL6SDlGAmbxHIA5/qC0m/aokuhrpmWUfwwbT2eBVeKuiVIwC3brKIvytlS7RCFQCR9ZX78PfbRqvOUEe8drIERyVgLx36TR1QGRc9tcG3AnaiyNxfK9ennDgTKpQFaRH/yhQTl5DQABGyAUaWdff9GG9tL4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3934.namprd12.prod.outlook.com (2603:10b6:208:167::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 09:04:31 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:04:31 +0000
Subject: Re: FW: [PATCH] drm/amdgpu: introduce a new parameter to configure
 how many KCQ we want(v3)
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@freedesktop.org" <amd-gfx@freedesktop.org>
References: <1595919538-8011-1-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB1708A4D9F6FE5582FC9A725784730@DM5PR12MB1708.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2ed41f48-12c6-db06-34af-79119a2df26b@amd.com>
Date: Tue, 28 Jul 2020 11:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM5PR12MB1708A4D9F6FE5582FC9A725784730@DM5PR12MB1708.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0009.eurprd07.prod.outlook.com
 (2603:10a6:200:42::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0701CA0009.eurprd07.prod.outlook.com (2603:10a6:200:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend
 Transport; Tue, 28 Jul 2020 09:04:30 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d6c548f-142f-41b1-0cb1-08d832d53d2c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39344792B1AF31B4380A0C1083730@MN2PR12MB3934.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wu+ubUuMF0K1tLH/ZQdPDOyclnWXbYk2IYV3OY5OItIP2tTXcOn2akyjG9jLyfuUfwRJTA9HVzdJIj8dvQntw3WNgbVjaTVm5jJ7cnfyDfRTTwFwM6oqpk8G/1liNWTsrtmb1mWOvpEScHjuQyGQ/SJhZHO+INvnTbtM+naVgLWIsMe79CL/4i4d59eK62huBGhwIXDJrH/7oV8tIGoBrtqvSJOORFbEAq+TmlXAZwP+XkfaQP6CmxP/b41X23FzzaHN8UUyVr3+C0iO41ZSxfVV3XedXqciGQ4x+TvRcUwTpVP0atS1/iC8VMc5F/vI6kd21MIrXdPpeezZ6vsJRaO6v+FbvzcMT0uf4BvTqr3Alt1L0bWnzoP/pgo1jaUd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(6666004)(5660300002)(2616005)(53546011)(186003)(16526019)(36756003)(52116002)(30864003)(31696002)(66556008)(66476007)(86362001)(66946007)(478600001)(110136005)(6486002)(31686004)(83380400001)(316002)(8936002)(2906002)(4326008)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JL8nKn1dH5aRbEjq54wrvoPxI/GLgGFDqHe3QXXu4Z6LIcDfGZ3EQ9asU1ZxDk74sS+2NGF2vq2wSVZszokoOQnnoC0tp/MjfG37l3D0Wy5n3njzgp/u61rMLdwd1W8WtK3JqpJlkFgm1WYcW2NbZzcfVL/UXJBD8O0wcLV8NJkSHUNGglPpWhTYIbcgIj+qPvAIoHHLmW5jNStk37bestn6Jw3oPclrHqkVkHVSZ9x2jVrmRXfn8dJN2dkdCOTWEi2ptec+FJWejv8q0N5jb5Z08BYC6iIEVaEclLjh7F5lumQASBpy7LDjQIEWCypRCU0M21Y1ASgse+Yzi7Xj/PHLpXu90oN2+hfU5RpkrHpD9lXinPwCYKPDY1wpehQvC3vSP0tRL8X3McZhrJCWKEB1cpYJKKBV/mfbzy/Mi/ngfwFYIQthykBUBQosqkFVSYb+/84h8OqoRFbVXhM12w5LUSSbTs2fRNJe7IBkVdyiPGvuiKg3a/yKWiKvU6E04OVPoNSc1vr7Ovx9AJor4wgBGhv/JK7IHi4G0MsoTo1kFckvHy9TVWipaIjfpZa8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6c548f-142f-41b1-0cb1-08d832d53d2c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 09:04:31.1563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usgHacQ6WIiogjPAZnWieziFUD7w5ewVvFTdb//IFQZWFLglpNoruxrJDG72ievq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patch looks totally mangled to me, e.g. some spaces and new lines 
are missing.

Probably because it was forwarded.

Christian.

Am 28.07.20 um 10:59 schrieb Liu, Monk:
> [AMD Official Use Only - Internal Distribution Only]
>
> -----Original Message-----
> From: Monk Liu <Monk.Liu@amd.com>
> Sent: Tuesday, July 28, 2020 2:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Monk <Monk.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: introduce a new parameter to configure how many KCQ we want(v3)
>
> what:
> the MQD's save and restore of KCQ (kernel compute queue) cost lots of clocks during world switch which impacts a lot to multi-VF performance
>
> how:
> introduce a paramter to control the number of KCQ to avoid performance drop if there is no kernel compute queue needed
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
> TODO:
> in the future we will let hypervisor driver to set this paramter automatically thus no need for user to configure it through modprobe in virtual machine
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 58 +++++++++++++++---------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 30 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 29 +++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 31 ++++++++--------
>   7 files changed, 87 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e97c088..de11136 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -201,6 +201,7 @@ extern int amdgpu_si_support;  #ifdef CONFIG_DRM_AMDGPU_CIK  extern int amdgpu_cik_support;  #endif
> +extern int amdgpu_num_kcq;
>
>   #define AMDGPU_VM_MAX_NUM_CTX4096
>   #define AMDGPU_SG_THRESHOLD(256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62ecac9..cf445bab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1199,6 +1199,11 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>
>   amdgpu_gmc_tmz_set(adev);
>
> +if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
> +amdgpu_num_kcq = 8;
> +dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid paramter provided by user\n");
> +}
> +
>   return 0;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6291f5f..b545c40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -150,6 +150,7 @@ int amdgpu_noretry;
>   int amdgpu_force_asic_type = -1;
>   int amdgpu_tmz = 0;
>   int amdgpu_reset_method = -1; /* auto */
> +int amdgpu_num_kcq = -1;
>
>   struct amdgpu_mgpu_info mgpu_info = {
>   .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> @@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);  MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");  module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>
> +MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to
> +setup (8 if set to greater than 8 or less than 0, only affect gfx
> +8+)"); module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
> +
>   static const struct pci_device_id pciidlist[] = {  #ifdef  CONFIG_DRM_AMDGPU_SI
>   {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI}, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8eff017..f83a9a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -202,40 +202,42 @@ bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
>
>   void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)  {
> -int i, queue, pipe, mec;
> +int i, queue, pipe;
>   bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
> +int max_queues_per_mec = min(adev->gfx.mec.num_pipe_per_mec *
> + adev->gfx.mec.num_queue_per_pipe,
> + adev->gfx.num_compute_rings);
> +
> +if (multipipe_policy) {
> +/* policy: make queues evenly cross all pipes on MEC1 only */
> +for (i = 0; i < max_queues_per_mec; i++) {
> +pipe = i % adev->gfx.mec.num_pipe_per_mec;
> +queue = (i / adev->gfx.mec.num_pipe_per_mec) %
> +adev->gfx.mec.num_queue_per_pipe;
> +
> +set_bit(pipe * adev->gfx.mec.num_queue_per_pipe + queue,
> +adev->gfx.mec.queue_bitmap);
> +}
> +} else {
> +int mec;
>
> -/* policy for amdgpu compute queue ownership */
> -for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
> -queue = i % adev->gfx.mec.num_queue_per_pipe;
> -pipe = (i / adev->gfx.mec.num_queue_per_pipe)
> -% adev->gfx.mec.num_pipe_per_mec;
> -mec = (i / adev->gfx.mec.num_queue_per_pipe)
> -/ adev->gfx.mec.num_pipe_per_mec;
> -
> -/* we've run out of HW */
> -if (mec >= adev->gfx.mec.num_mec)
> -break;
> +/* policy: amdgpu owns all queues in the given pipe */
> +for (i = 0; i < adev->gfx.num_compute_rings; ++i) {
> +queue = i % adev->gfx.mec.num_queue_per_pipe;
> +pipe = (i / adev->gfx.mec.num_queue_per_pipe)
> +% adev->gfx.mec.num_pipe_per_mec;
> +mec = (i / adev->gfx.mec.num_queue_per_pipe)
> +/ adev->gfx.mec.num_pipe_per_mec;
>
> -if (multipipe_policy) {
> -/* policy: amdgpu owns the first two queues of the first MEC */
> -if (mec == 0 && queue < 2)
> -set_bit(i, adev->gfx.mec.queue_bitmap);
> -} else {
> -/* policy: amdgpu owns all queues in the first pipe */
> -if (mec == 0 && pipe == 0)
> -set_bit(i, adev->gfx.mec.queue_bitmap);
> +/* we've run out of HW */
> +if (mec >= adev->gfx.mec.num_mec)
> +break;
> +
> +set_bit(i, adev->gfx.mec.queue_bitmap);
>   }
>   }
>
> -/* update the number of active compute rings */
> -adev->gfx.num_compute_rings =
> -bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
> -
> -/* If you hit this case and edited the policy, you probably just
> - * need to increase AMDGPU_MAX_COMPUTE_RINGS */
> -if (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +dev_info(adev->dev, "mec queue bitmap weight=%d\n",
> +bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES));
>   }
>
>   void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index db9f1e8..3a93b3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4022,21 +4022,23 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
>   amdgpu_gfx_compute_queue_acquire(adev);
>   mec_hpd_size = adev->gfx.num_compute_rings * GFX10_MEC_HPD_SIZE;
>
> -r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -      AMDGPU_GEM_DOMAIN_GTT,
> -      &adev->gfx.mec.hpd_eop_obj,
> -      &adev->gfx.mec.hpd_eop_gpu_addr,
> -      (void **)&hpd);
> -if (r) {
> -dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> -gfx_v10_0_mec_fini(adev);
> -return r;
> -}
> +if (mec_hpd_size) {
> +r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +  AMDGPU_GEM_DOMAIN_GTT,
> +  &adev->gfx.mec.hpd_eop_obj,
> +  &adev->gfx.mec.hpd_eop_gpu_addr,
> +  (void **)&hpd);
> +if (r) {
> +dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> +gfx_v10_0_mec_fini(adev);
> +return r;
> +}
>
> -memset(hpd, 0, mec_hpd_size);
> +memset(hpd, 0, mec_hpd_size);
>
> -amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> -amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> +amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +}
>
>   if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
>   mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data; @@ -7159,7 +7161,7 @@ static int gfx_v10_0_early_init(void *handle)
>   break;
>   }
>
> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +adev->gfx.num_compute_rings = amdgpu_num_kcq;
>
>   gfx_v10_0_set_kiq_pm4_funcs(adev);
>   gfx_v10_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 8d72089..eb4b812 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1343,21 +1343,22 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
>   amdgpu_gfx_compute_queue_acquire(adev);
>
>   mec_hpd_size = adev->gfx.num_compute_rings * GFX8_MEC_HPD_SIZE;
> +if (mec_hpd_size) {
> +r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +  AMDGPU_GEM_DOMAIN_VRAM,
> +  &adev->gfx.mec.hpd_eop_obj,
> +  &adev->gfx.mec.hpd_eop_gpu_addr,
> +  (void **)&hpd);
> +if (r) {
> +dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> +return r;
> +}
>
> -r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -      AMDGPU_GEM_DOMAIN_VRAM,
> -      &adev->gfx.mec.hpd_eop_obj,
> -      &adev->gfx.mec.hpd_eop_gpu_addr,
> -      (void **)&hpd);
> -if (r) {
> -dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> -return r;
> -}
> -
> -memset(hpd, 0, mec_hpd_size);
> +memset(hpd, 0, mec_hpd_size);
>
> -amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> -amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> +amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +}
>
>   return 0;
>   }
> @@ -5294,7 +5295,7 @@ static int gfx_v8_0_early_init(void *handle)
>   struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>   adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +adev->gfx.num_compute_rings = amdgpu_num_kcq;
>   adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
>   gfx_v8_0_set_ring_funcs(adev);
>   gfx_v8_0_set_irq_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e4e751f..43ad044 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1938,22 +1938,23 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
>   /* take ownership of the relevant compute queues */
>   amdgpu_gfx_compute_queue_acquire(adev);
>   mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
> +if (mec_hpd_size) {
> +r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +  AMDGPU_GEM_DOMAIN_VRAM,
> +  &adev->gfx.mec.hpd_eop_obj,
> +  &adev->gfx.mec.hpd_eop_gpu_addr,
> +  (void **)&hpd);
> +if (r) {
> +dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> +gfx_v9_0_mec_fini(adev);
> +return r;
> +}
>
> -r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -      AMDGPU_GEM_DOMAIN_VRAM,
> -      &adev->gfx.mec.hpd_eop_obj,
> -      &adev->gfx.mec.hpd_eop_gpu_addr,
> -      (void **)&hpd);
> -if (r) {
> -dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> -gfx_v9_0_mec_fini(adev);
> -return r;
> -}
> -
> -memset(hpd, 0, mec_hpd_size);
> +memset(hpd, 0, mec_hpd_size);
>
> -amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> -amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> +amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +}
>
>   mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
>
> @@ -4625,7 +4626,7 @@ static int gfx_v9_0_early_init(void *handle)
>   adev->gfx.num_gfx_rings = 0;
>   else
>   adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +adev->gfx.num_compute_rings = amdgpu_num_kcq;
>   gfx_v9_0_set_kiq_pm4_funcs(adev);
>   gfx_v9_0_set_ring_funcs(adev);
>   gfx_v9_0_set_irq_funcs(adev);
> --
> 2.7.4
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

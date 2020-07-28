Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600D3C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 09:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143CF20714
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 09:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SKaDvmdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143CF20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49356E220;
	Tue, 28 Jul 2020 09:32:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C3E6E21E
 for <amd-gfx@freedesktop.org>; Tue, 28 Jul 2020 09:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Moguk/tmQJoTT1/5tlVhmaM3Y/OY13Sf4LmtMSuaQ9d+BQ8QjP7BF57ItwqEtlGfUzqPMyQ962MC1GftHzyAZqGg4ui75pPdagc+nr2SzZir6bG/jChNPQV6lAp3KNe0qjpO6frG744xQvEe87CaN5mJcHvEzbutw6WUSqji83rBlwIhan4DxMT+FbPWP9Gd1BtqjFoZBjdRnW5QM9qIYwdt9yaUJc01SROAJWU8THiiledrPNKe9AJqb3h76ps7Z6+SEyLphyb1YdhRr1Jen3RJTiCLAakRtGEMeQs8zmZTK78YgKLcc+zVzH6214ItMUfxEqe1rxW3vR4HdaSrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI6TsG7FqIywH2XwA//TJAKS18zI+4NH+fSY7kbUdB8=;
 b=eOKR8yaWlCTbRaxGzaKMl6KNMq+IPAaCQmI19wO1NyOH1u5c+vhmWztbXEUHws3LiK3JfxtCRiSV2zIxkoEhzUGHCXI3DEpAAuuVUaTwulUbEf2QAYUlUiKx9ogZR2E3XNcDySbsmz3rxo7StuaJmsMQ42adocSWyiPflcXf0F66nRJYn/JsWrvKMLWHpX3GWaFVO3gK6udG4Lnh4xwlMKYVWy6Z2t2C1QElDB+wPYUq3GAMimVnAoCTa4TDv6UtHVOirUdN0cD0GrWqDejWmyW+bcd/aGk4TI5KoFN/cRW+4z4ZlFJJZjzWY9Xbyry9sW/mzdVwmeWHnpeSFj1Z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI6TsG7FqIywH2XwA//TJAKS18zI+4NH+fSY7kbUdB8=;
 b=SKaDvmdmrClbjPt3wURFxi8KYqm618e4DNKHMbOtt56haE82JZ0EcpG7u4SwEVewu4gBrvUkEbvLROXW1smfspW1rtJyWmJOxYQP3S5sLPYDua7cA9hyTk9MYDwemJrp/2rbs90bMEY8TXhKcbJZpagOcnvDsUoBcb0luPcAzzw=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 09:32:03 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:32:03 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "amd-gfx@freedesktop.org"
 <amd-gfx@freedesktop.org>
Subject: RE: FW: [PATCH] drm/amdgpu: introduce a new parameter to configure
 how many KCQ we want(v3)
Thread-Topic: FW: [PATCH] drm/amdgpu: introduce a new parameter to configure
 how many KCQ we want(v3)
Thread-Index: AQHWZKyV8reeYG0ozUiyCKhgwScn8qkcsTyQgAABmgCAAAeKMA==
Date: Tue, 28 Jul 2020 09:32:02 +0000
Message-ID: <DM5PR12MB1708B3388318976102C2C6A184730@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1595919538-8011-1-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB1708A4D9F6FE5582FC9A725784730@DM5PR12MB1708.namprd12.prod.outlook.com>
 <2ed41f48-12c6-db06-34af-79119a2df26b@amd.com>
In-Reply-To: <2ed41f48-12c6-db06-34af-79119a2df26b@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=38f0df6b-acaf-4732-a336-000097319313;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-28T09:31:25Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d8da3a6-c648-4bbc-ccd3-08d832d915f2
x-ms-traffictypediagnostic: DM6PR12MB4355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB43555FB25425D26C7E8A8F5F84730@DM6PR12MB4355.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSOeT+XxF/eF65fFSA2BGD+Dj62OnOha8wUlxNYDZyrkCgdORXtZHLQuWcxgM6Cw56cTjpvz/f3pNVpvSz99SU93/XrcOMW/dmDlJ6I7qUfXq/RAKz0E1wbn9UKFMHvfUz2j3b+gFBtFtNOrTEa2jt9lOgltCKHb8BKrLNT9GQQUigzZowkBmk10/GSZmsvO4AVGvFGYlUDBLY8/RfWnNJdl5sriN8+lMrpsMnkQIdzTOA9PB06l/mWYg3tF1oLo8+PIZTAty0U8BZgSHFdr6U0Akl+2ine0n5GRUfqeOTbz8XQ7KyJ+8gDtyef8RmB+s7iFH+faSxkAOQNaDFPGew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(316002)(2906002)(8676002)(8936002)(6506007)(55016002)(9686003)(86362001)(66946007)(53546011)(66476007)(66556008)(76116006)(110136005)(64756008)(30864003)(66446008)(7696005)(478600001)(186003)(71200400001)(52536014)(83380400001)(26005)(33656002)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qNmvqmcnwo0NbrLtE4JAN+bXkrZMgEjtKxbQ4AKpTDg1YIBmTRLyAHOjSzbP0G11iCl41p3h4+MAnlrBvp7U9YXOOKMie9g7Cy25eEYIhmjtxxI7IP8Nk6f5tAA82FozU2nw4FivY5owoig1FD9E84b3aepuMzMa0psUthUIHf3N2eVvY30h0/hAfagze0nNs8xGeL2+67jNzsJioH//tOUChjOk24uer2wbO7LxWnHdoBoNed+RCLmOdGO3l+WHRah79dwjaHCMpYVwglOwjBWiU47EROavOSHQ0l9GtyNTBhtYcp/RXWrGfbVH4kIWEsujCAxNIc5CcZlBaL9R0KtDk7hedh9v1vbPdgYbLgVldRXZl+40iuJzextyGPkP8Ntmyby8HcXJjCmxxYrrB8UXeAzUvHyjKPUld+UYbz4t9VPdlarcnYnFopU4NZtfI6+rkcYghT21dOunfmlfOJF6SgqfQPOAJNeQJcbjS2NLOWXdQztoJKBg7YI6le+m
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8da3a6-c648-4bbc-ccd3-08d832d915f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 09:32:02.9021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5QdAcYcRn3GkAdd84uakNZovTMJNSi9VNzOkKHoxGGnwWSe9FpYhFhZpVNthGhX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

I repeated the patch broadcast through git-send-email

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Tuesday, July 28, 2020 5:04 PM
To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: FW: [PATCH] drm/amdgpu: introduce a new parameter to configure how many KCQ we want(v3)

The patch looks totally mangled to me, e.g. some spaces and new lines are missing.

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
> Subject: [PATCH] drm/amdgpu: introduce a new parameter to configure
> how many KCQ we want(v3)
>
> what:
> the MQD's save and restore of KCQ (kernel compute queue) cost lots of
> clocks during world switch which impacts a lot to multi-VF performance
>
> how:
> introduce a paramter to control the number of KCQ to avoid performance
> drop if there is no kernel compute queue needed
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
> in the future we will let hypervisor driver to set this paramter
> automatically thus no need for user to configure it through modprobe
> in virtual machine
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e97c088..de11136 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -201,6 +201,7 @@ extern int amdgpu_si_support;  #ifdef
> CONFIG_DRM_AMDGPU_CIK  extern int amdgpu_cik_support;  #endif
> +extern int amdgpu_num_kcq;
>
>   #define AMDGPU_VM_MAX_NUM_CTX4096
>   #define AMDGPU_SG_THRESHOLD(256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62ecac9..cf445bab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1199,6 +1199,11 @@ static int amdgpu_device_check_arguments(struct
> amdgpu_device *adev)
>
>   amdgpu_gmc_tmz_set(adev);
>
> +if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) { amdgpu_num_kcq = 8;
> +dev_warn(adev->dev, "set kernel compute queue number to 8 due to
> +invalid paramter provided by user\n"); }
> +
>   return 0;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
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
> @@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
> MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default),
> 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
> module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>
> +MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want
> +to setup (8 if set to greater than 8 or less than 0, only affect gfx
> +8+)"); module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
> +
>   static const struct pci_device_id pciidlist[] = {  #ifdef  CONFIG_DRM_AMDGPU_SI
>   {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI}, diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8eff017..f83a9a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -202,40 +202,42 @@ bool
> amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
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
> +/* policy: make queues evenly cross all pipes on MEC1 only */ for (i
> += 0; i < max_queues_per_mec; i++) { pipe = i %
> +adev->gfx.mec.num_pipe_per_mec; queue = (i /
> +adev->gfx.mec.num_pipe_per_mec) %
> +adev->gfx.mec.num_queue_per_pipe;
> +
> +set_bit(pipe * adev->gfx.mec.num_queue_per_pipe + queue,
> +adev->gfx.mec.queue_bitmap);
> +}
> +} else {
> +int mec;
>
> -/* policy for amdgpu compute queue ownership */ -for (i = 0; i <
> AMDGPU_MAX_COMPUTE_QUEUES; ++i) { -queue = i %
> adev->gfx.mec.num_queue_per_pipe; -pipe = (i /
> adev->gfx.mec.num_queue_per_pipe) -% adev->gfx.mec.num_pipe_per_mec;
> -mec = (i / adev->gfx.mec.num_queue_per_pipe) -/
> adev->gfx.mec.num_pipe_per_mec;
> -
> -/* we've run out of HW */
> -if (mec >= adev->gfx.mec.num_mec)
> -break;
> +/* policy: amdgpu owns all queues in the given pipe */ for (i = 0; i
> +< adev->gfx.num_compute_rings; ++i) { queue = i %
> +adev->gfx.mec.num_queue_per_pipe;
> +pipe = (i / adev->gfx.mec.num_queue_per_pipe) %
> +adev->gfx.mec.num_pipe_per_mec; mec = (i /
> +adev->gfx.mec.num_queue_per_pipe)
> +/ adev->gfx.mec.num_pipe_per_mec;
>
> -if (multipipe_policy) {
> -/* policy: amdgpu owns the first two queues of the first MEC */ -if
> (mec == 0 && queue < 2) -set_bit(i, adev->gfx.mec.queue_bitmap); -}
> else {
> -/* policy: amdgpu owns all queues in the first pipe */ -if (mec == 0
> && pipe == 0) -set_bit(i, adev->gfx.mec.queue_bitmap);
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
> - * need to increase AMDGPU_MAX_COMPUTE_RINGS */ -if
> (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +dev_info(adev->dev, "mec queue bitmap weight=%d\n",
> +bitmap_weight(adev->gfx.mec.queue_bitmap,
> +AMDGPU_MAX_COMPUTE_QUEUES));
>   }
>
>   void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
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
> -gfx_v10_0_mec_fini(adev); -return r; -}
> +if (mec_hpd_size) {
> +r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +  AMDGPU_GEM_DOMAIN_GTT,
> +  &adev->gfx.mec.hpd_eop_obj,
> +  &adev->gfx.mec.hpd_eop_gpu_addr,
> +  (void **)&hpd);
> +if (r) {
> +dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> +gfx_v10_0_mec_fini(adev); return r; }
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
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
> +dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r); return r;
> +}
>
> -r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -      AMDGPU_GEM_DOMAIN_VRAM,
> -      &adev->gfx.mec.hpd_eop_obj,
> -      &adev->gfx.mec.hpd_eop_gpu_addr,
> -      (void **)&hpd);
> -if (r) {
> -dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r); -return r;
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
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
> +gfx_v9_0_mec_fini(adev); return r; }
>
> -r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -      AMDGPU_GEM_DOMAIN_VRAM,
> -      &adev->gfx.mec.hpd_eop_obj,
> -      &adev->gfx.mec.hpd_eop_gpu_addr,
> -      (void **)&hpd);
> -if (r) {
> -dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> -gfx_v9_0_mec_fini(adev); -return r; -}
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
>   mec_hdr = (const struct gfx_firmware_header_v1_0
> *)adev->gfx.mec_fw->data;
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

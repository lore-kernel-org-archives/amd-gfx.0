Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C2C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C615122C9E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WB7cTCL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C615122C9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7671F6E849;
	Thu, 30 Jul 2020 03:03:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15A26E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 03:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R17TwbQVt5C8dQp+jiTQMLIs2YuMpvDk3NGPazzDco7BTpWGgKEVyFzsS1Hg+zNUlLCU3oaZm7bZJsT6jNsqsHJ+iuLLkq9Uk2K/FFHz2Tvnh5VC5jyp2Ie50NqGx72gVBZes+2eczMnU80GMb7e30/nWc+lr0pUKdI8gPF14A0Qe6TakSvJhlJa2ArGvIK9Ai48r3ODJLxQ2s+PNCDSRRca7h56hfpMmZOhRqBWQ+tSomOoDZ4RYIP8zEJ59F/KnPKAHSzNaTS9Vpk8tshD7vLkNFOfj83zPQkOAKxb7V8ZCbmjQX5jY0ZsLIrBnS3cv4EL7q0iu3f7Av6kv3yJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FixkjeDRzHnRDR4rFes9pVyf+5ABJw3Ca9wecaJMkQU=;
 b=IMK0BJ8JnsjQ1AmzQtLk4v+b4xTSerPIqhspNlAcUaFCQclWRyf1AoUFH9l2wCuu/JIoiAEHQcoA37HjKrZIDoR+ifElFY+4vvSnxUaM7Dsj+qPgNM6LIATd/c3a0dXwwZNmojKn65OM+StwGaRpBxE41hRYppJwNWLj69iJkoZoNqoUEIaGIwjRSOmSECDo1A64z6Z1bffDELbOWNCW4zyLykQ4aDcheqj1MdYn+/w8e9Wj/HprI2iI17lCb2APGnul+7so0Izp09ndKEwQyIbYBVEgdmUqd4OmgnOlMO8BDIt+d4KrGO6I6QIpylZVIF/CNZjazn6xdSjpu1RmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FixkjeDRzHnRDR4rFes9pVyf+5ABJw3Ca9wecaJMkQU=;
 b=WB7cTCL4Eyva2mRWr/m+UGqNa+10/JFkTCPUGewOyn3f9QaJxK8sPWRLyoSj7KsoouEZhtvD8sK0HbSDUvKQJz5eXsS3lNmPaeCtI0f2dIYocJjUpbWRt7eJX/2ES7GHkKGLV+PoFs7auj/ClWAM9EGM6rp7aaGtHinFBNQAFnU=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 30 Jul
 2020 03:03:35 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 03:03:34 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: FW: [PATCH] drm/amdgpu: introduce a new parameter to configure
 how many KCQ we want(v3)
Thread-Topic: FW: [PATCH] drm/amdgpu: introduce a new parameter to configure
 how many KCQ we want(v3)
Thread-Index: AQHWZKyV8reeYG0ozUiyCKhgwScn8qkcsTyQgAABmgCAAAeKMIACuDMg
Date: Thu, 30 Jul 2020 03:03:34 +0000
Message-ID: <DM5PR12MB1708B9BBE265BFFE20A9C03484710@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1595919538-8011-1-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB1708A4D9F6FE5582FC9A725784730@DM5PR12MB1708.namprd12.prod.outlook.com>
 <2ed41f48-12c6-db06-34af-79119a2df26b@amd.com>
 <DM5PR12MB1708B3388318976102C2C6A184730@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1708B3388318976102C2C6A184730@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=38f0df6b-acaf-4732-a336-000097319313;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-28T09:31:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3aea737-a52b-41e4-55c5-08d834352609
x-ms-traffictypediagnostic: DM6PR12MB4530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB45305EDF723D29AD9165692A84710@DM6PR12MB4530.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k5RWlEKUQ+Qf/YZWra44ty4xT4RbbdyuxmbK96AY6PZLqtn0VxPStMxf+hSV1kcSv5bU1Dy7sAbI7yLSJx7GvD6ksyxqb+x+Kps5fek1rq5uYUwomr3qte1KnGLUuaX7vS73IImtka/N4n8W6k0IXxmFewMjSIIb1FUYp0tydcNuIKkvYYB4NczwjM411fLrMTXl3phquduZFd2KmkuiFdL537NFcW6eKJ4olAE9hiJc4T1TPtr9Uqthca5Kw4Yo4yKmXnJu9hhSqZ09um6WQmA/QeMzE191zMgvxV83osL9hBqijny2mhoDo2fsN3azQuO7MaL0JGBScC32tW0RXlbLMmRulCPxAs4cCac6xo8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(66446008)(66946007)(52536014)(33656002)(2906002)(316002)(66556008)(66476007)(64756008)(8936002)(186003)(110136005)(30864003)(6506007)(55016002)(53546011)(86362001)(966005)(8676002)(26005)(71200400001)(83380400001)(7696005)(45080400002)(5660300002)(478600001)(9686003)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 891TSTec/wg7cTpZJeE7u/yfE2LzgrYs18T3r2xVwUtQX054U4nMr4nr2Gy5m2uH9lTnyZT+OgOBA8BtDbelyMcs6a+SzHsTLRw2yFneQ6VdAEaE6EkHLd2Wmx1BWN3KyBVTVoPeJyVY5m1AkNrtOMxvqd8xAgbwKNcTMQNaD+fYlamFzIsdPeibq4FQ4MOWdcTnsFlyUcXcZdeUv4+aL2h6/6bMsQ1uKbRWXI9+jTIofFc3bh3wDBrHP+znz5+XYqauxP6YBMz+btcOvIA1RSDr7fxhWe1Dun/4Ew4L1Q9kWcRtFcIlums6PesLwXwqOvIUvSt4ETcvhoPrMYk6ywr9DsykWU2YJ7TGF12cm1IqSg+W5Lqac+zJKi5+pGVP9+4oHVLiqh5YGOuBTBYPF503cpfLVYbTAbQ30Mu/8Pho7mzCXZtlDjqiOOi9+WXE9Ou49IPnvpYvns/BZCzWXoN/QB/NZiX8fa4giyRB5SQavI1k+IoGXtdp6VsDsw8Y
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3aea737-a52b-41e4-55c5-08d834352609
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 03:03:34.6353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdyMLmpdYxeBcKn3JrgY6UO/aCub8O8NWWbttD2akONwVLcGCrePSTage9ofa4FX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
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

[AMD Official Use Only - Internal Distribution Only]

Ping

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Monk
Sent: Tuesday, July 28, 2020 5:32 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: RE: FW: [PATCH] drm/amdgpu: introduce a new parameter to configure how many KCQ we want(v3)

[AMD Official Use Only - Internal Distribution Only]

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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C0daa686ecc144bdb015b08d832d9191a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637315255294101473&amp;sdata=JRV9wXurbE1fvb%2FTHGMZpgNbPfEWY%2BAmmuXvJF%2BWUNs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

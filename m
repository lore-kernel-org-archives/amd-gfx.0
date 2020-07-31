Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94678C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 07:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF4A2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 07:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bwrE+tmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF4A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCD56EA14;
	Fri, 31 Jul 2020 07:43:04 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680087.outbound.protection.outlook.com [40.107.68.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613746EA1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 07:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiI3SxMtn/8hPhKDXsZWLSE8ieMHfKce1dwp69PLN5/2ogJCoip2FRv3/sV7uc1nHuuzQBF3Z+ysTNVL8cDhDo85lbLiSLh1wFzk99+3+H+Yx82uEdEhubkHL58z5MAiZLYFvEkGs6RNKD62pjzKsMOlggT9WSMFQ/nt7jFGc8lZ85BOITwXLiokeVf9l5XihDMIPa2cqV3a3EoNbjS6LBGemkSGK8o3VusKXQ0hUnNh/thxx+WLX4PSUhOSA+AZpC/Zmv/kKrluPxpoTYVWftmoGLrx4d4ig6dblLM8eIhEuyLuTEMRNMHIq8LpIdAb0gimVaOAH2P0pPQY7piFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaNCDR2iTCWWyCmrpYJiHOzDwNKv6kFiEoZKquHNgkE=;
 b=TQBd0o5KdElwdC7DyCilzQsR2WZb0shYyp6W4BxvP510qiCPa+C4pr1XdgzALfgbImmIvJ8iHnAvGqSQ/U8fJ9qi4J8wqHXdUnLSfPHqkAcK85KtWv1YIutXSvNOmFpWZrbCf1TCm1ajxReg8EWa1R76DiaSrgb5V2yqCbJ/2MUMR50cYRxZOfR+ZEaBf3IXWyoNN6EDaaXYGwU2+4SJfTw7SJthpPL10KRakBoBHDYfSCaMflMqMcPnUs7vccGJZobxaiepjfHczMdXVLsflMLf38o+BJCCjxyaiTFgLPwaATOxAKm9jAaUwNd9fwqD9jR59WewP865VjrmXmn/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaNCDR2iTCWWyCmrpYJiHOzDwNKv6kFiEoZKquHNgkE=;
 b=bwrE+tmnjBA81HqpITuf+TVY8jiEOTBmjnTQIplKyn6AVN5aSPff83rzRoG/eyvWqP7Svz6aWnRQNE/r12AA4DmnDm7Dmx1PaB+NoP/X3H2lx9Ym5jyoHxETWPzNpBPn91dZd09zvtDbkFlz6H5LSku/wa1rGq5Q4Oik8drL3yg=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 07:43:00 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3216.034; Fri, 31 Jul 2020
 07:43:00 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: introduce a new parameter to configure how
 many KCQ we want(v4)
Thread-Topic: [PATCH] drm/amdgpu: introduce a new parameter to configure how
 many KCQ we want(v4)
Thread-Index: AQHWZuyTJaXiRIET2EGq6QLzNF8uKakhH0kAgAAvByA=
Date: Fri, 31 Jul 2020 07:43:00 +0000
Message-ID: <DM5PR12MB170841C3A9DD3744C165F5BA844E0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1596166923-29057-1-git-send-email-Monk.Liu@amd.com>
 <29d89e58-1b0e-15f2-26e7-0d549312fd24@amd.com>
In-Reply-To: <29d89e58-1b0e-15f2-26e7-0d549312fd24@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=02becb8a-dd17-4482-a03f-0000a3146fd9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-31T07:42:02Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 413d4faa-2c1b-46b1-8904-08d8352559a5
x-ms-traffictypediagnostic: DM5PR12MB1836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1836481D0A418C08A3FF79C2844E0@DM5PR12MB1836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eTAo9hE6uNoCE5xyUOptsXzXlZlJB7V8RmUfNDbM2gO2YgS/1bf+2e2fT8L/QVjk4MlYTEfd9dly/d4KgYgkObuu+ECenA5bkk65t9vXH6QBGgHK4V2JwyWBPT0WFxPC0IevaMAYnf/WJpRQGkI7DTT+jzQJxyfSAGcLo4qOAg4TbCHW49IyP/C8ll+66sUlbDMBlDdwZOo0pXXkQjoeJ2SoBv7IWQ4jw9sXKuztoKV5+HK3yDVwFWILygdyZC2wkaJls0O4BDPpzx3/8jK1lDztg/9uJ7vIVVdtnub3iCvP1lAiNvvkC7IaIIWtKlqajteASqVQ1NtpTNrnQKAieQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(7696005)(26005)(30864003)(6506007)(186003)(66476007)(64756008)(66556008)(66446008)(53546011)(66946007)(5660300002)(76116006)(52536014)(33656002)(83380400001)(86362001)(71200400001)(55016002)(9686003)(478600001)(8676002)(8936002)(316002)(110136005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: jlXxguqJKNRVZBYaGhYtHh2+8oymT491mBzw0IHugwJ+2oNHGEP2qdoX7dqVHZDIqcDN8fHNEA0Da4ORQXn+IWWCef/uzG6NFhBEI+R6f6f9Iwd3bRpdyvqaipjI+7cXB836NbgMgJ4DmKs7e0Ean/WSIg1Rp7MqPD2rh6lw9yJq4lT35EfEYwTAi9MRFGZ02vV+/yH/QD7eRh4BJcwaBimMtnrTV86yCigUAlbMNVo5pQbB06D6zSBLYIJSl3Q60AtaM0zZR+QLolJegvecnPmaxP4jTZ5bkKGc8GPrrXSuGm4P8OcxB5McZOdn+S7KPI/N890RCa/LomxZ7cf3pakqlMIHH5r9IiudfCjLs0ikSGAtjegqtUMNfY1hgIEO0XMZFpY5C6IzEgrwvaDE/GvuXb3AK+F+VJDjVP5plivWY0LlLlcfaFKBJG8JJ7c+o3cE8NvpJwGDxqXzA1rr02TglbLrAgH49679bZKU4Jo/UjiY+YQXKgcgcBuNG9fxf+qFY2IvaR1CE84Qz+GUMbRkpiZuX9uwAViFtELpc2E7dhZSF3XmWEk3K7Aty2xc1A/4VXHkaK+t8aKMUbDjhSuMpfgVoWk5sOUaVHI8Rw03zNteFFBSXGhhWJhSBnpcBqFp0ZCm//57kgNV0kKG7Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413d4faa-2c1b-46b1-8904-08d8352559a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 07:43:00.5998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ViNRYSGvu9vam/+Iz+6VyBrzUDa6O1U5+OR4rYeHAc32uyF4Y0Rjhk0W3/GDplfA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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

Felix

I cannot let the indentation look perfect when it goes out from the email , don't know why

It looks well in my VIM although

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, July 31, 2020 12:54 PM
To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: introduce a new parameter to configure how many KCQ we want(v4)


Am 2020-07-30 um 11:42 p.m. schrieb Monk Liu:
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
> v4:
> fix indentation
> some cleanupsin the gfx_compute_queue_acquire() function
>
> TODO:
> in the future we will let hypervisor driver to set this paramter
> automatically thus no need for user to configure it through modprobe
> in virtual machine
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 52 +++++++++++++-----------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 30 +++++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 29 +++++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 31 +++++++++---------
>  7 files changed, 80 insertions(+), 72 deletions(-)
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
>  #define AMDGPU_VM_MAX_NUM_CTX4096
>  #define AMDGPU_SG_THRESHOLD(256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62ecac9..cf445bab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1199,6 +1199,11 @@ static int amdgpu_device_check_arguments(struct
> amdgpu_device *adev)
>
>  amdgpu_gmc_tmz_set(adev);
>
> +if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
> +amdgpu_num_kcq = 8;
> +dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid paramter provided by user\n");
> +}
> +
>  return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6291f5f..b545c40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -150,6 +150,7 @@ int amdgpu_noretry;  int amdgpu_force_asic_type =
> -1;  int amdgpu_tmz = 0;  int amdgpu_reset_method = -1; /* auto */
> +int amdgpu_num_kcq = -1;
>
>  struct amdgpu_mgpu_info mgpu_info = {
>  .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> @@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
> MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default),
> 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
> module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>
> +MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want
> +to setup (8 if set to greater than 8 or less than 0, only affect gfx
> +8+)"); module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
> +
>  static const struct pci_device_id pciidlist[] = {  #ifdef
> CONFIG_DRM_AMDGPU_SI
>  {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI}, diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8eff017..b43df8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -202,40 +202,34 @@ bool
> amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
>
>  void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)  {
> -int i, queue, pipe, mec;
> +int i, queue, pipe;
>  bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
> +int max_queues_per_mec = min(adev->gfx.mec.num_pipe_per_mec *
> +     adev->gfx.mec.num_queue_per_pipe,
> +     adev->gfx.num_compute_rings);
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

Indentation looks slightly off here.


> +}
> +} else {
> +/* policy: amdgpu owns all queues in the given pipe */
> +for (i = 0; i < max_queues_per_mec; ++i) {
> +queue = i % adev->gfx.mec.num_queue_per_pipe;
> +pipe = (i / adev->gfx.mec.num_queue_per_pipe)
> +% adev->gfx.mec.num_pipe_per_mec;
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
> -
> -if (multipipe_policy) {
> -/* policy: amdgpu owns the first two queues of the first MEC */
> -if (mec == 0 && queue < 2)
> -set_bit(i, adev->gfx.mec.queue_bitmap);
> -} else {
> -/* policy: amdgpu owns all queues in the first pipe */
> -if (mec == 0 && pipe == 0)
> -set_bit(i, adev->gfx.mec.queue_bitmap);
> +set_bit(i, adev->gfx.mec.queue_bitmap);

If you're not even using queue and pipe here, you don't need to calculate them above.


>  }
>  }
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
> +bitmap_weight(adev->gfx.mec.queue_bitmap,
> +AMDGPU_MAX_COMPUTE_QUEUES));

Should this be a debug message? I don't see this being very useful to a normal user.


>  }
>
>  void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index db9f1e8..3a93b3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4022,21 +4022,23 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
>  amdgpu_gfx_compute_queue_acquire(adev);
>  mec_hpd_size = adev->gfx.num_compute_rings * GFX10_MEC_HPD_SIZE;
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

Indentation is still wrong here.


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
>  if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
>  mec_hdr = (const struct gfx_firmware_header_v1_0
> *)adev->gfx.mec_fw->data; @@ -7159,7 +7161,7 @@ static int gfx_v10_0_early_init(void *handle)
>  break;
>  }
>
> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +adev->gfx.num_compute_rings = amdgpu_num_kcq;
>
>  gfx_v10_0_set_kiq_pm4_funcs(adev);
>  gfx_v10_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 8d72089..eb4b812 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1343,21 +1343,22 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
>  amdgpu_gfx_compute_queue_acquire(adev);
>
>  mec_hpd_size = adev->gfx.num_compute_rings * GFX8_MEC_HPD_SIZE;
> +if (mec_hpd_size) {
> +r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +  AMDGPU_GEM_DOMAIN_VRAM,
> +  &adev->gfx.mec.hpd_eop_obj,
> +  &adev->gfx.mec.hpd_eop_gpu_addr,
> +  (void **)&hpd);

Wrong indentation.


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
>  return 0;
>  }
> @@ -5294,7 +5295,7 @@ static int gfx_v8_0_early_init(void *handle)
>  struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>  adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +adev->gfx.num_compute_rings = amdgpu_num_kcq;
>  adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
>  gfx_v8_0_set_ring_funcs(adev);
>  gfx_v8_0_set_irq_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e4e751f..43ad044 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1938,22 +1938,23 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
>  /* take ownership of the relevant compute queues */
>  amdgpu_gfx_compute_queue_acquire(adev);
>  mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
> +if (mec_hpd_size) {
> +r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +  AMDGPU_GEM_DOMAIN_VRAM,
> +  &adev->gfx.mec.hpd_eop_obj,
> +  &adev->gfx.mec.hpd_eop_gpu_addr,
> +  (void **)&hpd);

Wrong indentation.

Regards,
  Felix


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
>  mec_hdr = (const struct gfx_firmware_header_v1_0
> *)adev->gfx.mec_fw->data;
>
> @@ -4625,7 +4626,7 @@ static int gfx_v9_0_early_init(void *handle)
>  adev->gfx.num_gfx_rings = 0;
>  else
>  adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> -adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +adev->gfx.num_compute_rings = amdgpu_num_kcq;
>  gfx_v9_0_set_kiq_pm4_funcs(adev);
>  gfx_v9_0_set_ring_funcs(adev);
>  gfx_v9_0_set_irq_funcs(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976D0C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5506820829
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GbEZpjRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5506820829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D78706E986;
	Fri, 31 Jul 2020 02:11:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770074.outbound.protection.outlook.com [40.107.77.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473666E0C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:11:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xlzd4Ry8lAXHRGVLD4XEId8KJ723iN5fX3WeartR3OCUFnDJd4kwScAHrMR2v0Pb/V+zNyUz1stmVnaIBfqb6A9uMAA+/5iN3/nAq+HUzodRkc8NuLEQqJp/7vnjbYY8A6GNUT3WIbWYulzKZKgawwKtviaD/Bgyp1baB0IIvDPLa1+7ohAn2RmnWkscSrVuwY4aVdlCo8bbI0YZIOl2XkkjZDHUJdszUFCTyV3zbisckWxJwcKT0qYC1jUrKpEwJFT42NsMAd1EMOwI7Zm/V/G1hP1QP/9MSWvkXguZpzJNQgj5gki6Lxs+X/EIXQn0NKmz0UCZUVod25bdP+S7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8kglgFFvoopawmTEzBVhjvNJINBxGKlCCh7z8Tk+co=;
 b=NPhKVI7z8ab7FdXWz/7gKj3oQgxrPuKWNO/Fovf+zxr1tTeXKw2aDuZclDffAEUxRFdw+v5rk6vcrh9rJpVWTCqzLqRvhcsnQn7cWnchF/bu1dPetaskyaaleaszohPX7rhxVseGryaXK+YCEHQAlf67eQydQzhSVt1EyBZh7EiYOPuDXQl+NL207H3N45wss+MRoIpA0Q60/VLvf8eicBK8Z4Ek/csc1d067mj40Wab+u5pqSEe4RVoIvzKPBaabM0im+l83S69gMWNyCu2sba185NCqElFjb9cpM8Go5dfmm87Q3XLc66w3lLfEWGPm6Zzn7r6br1UMFwbCxlhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8kglgFFvoopawmTEzBVhjvNJINBxGKlCCh7z8Tk+co=;
 b=GbEZpjRBhBd1AFJ4NeMWeqOx8vBbe/FDL5CIHAWNMIF8lmWfNj4PA4hQtUDK+YTmSXtVRC/XDL5hK5I6XNVE+9GSWOgxMWP1g3dWA9sVxjKb5cxySYRGjHvY44m/nJ8VQrEHgz7NF3Rt1sUqohNAvP2WGATgXfbwulfmheC6l1g=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB3692.namprd12.prod.outlook.com (2603:10b6:5:14a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Fri, 31 Jul
 2020 02:11:33 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3216.034; Fri, 31 Jul 2020
 02:11:33 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: introduce a new parameter to configure how
 many KCQ we want(v3)
Thread-Topic: [PATCH] drm/amdgpu: introduce a new parameter to configure how
 many KCQ we want(v3)
Thread-Index: AQHWZL2aDozQFeOfiE6RuRTYm4GaoqkdD/2AgAPknmA=
Date: Fri, 31 Jul 2020 02:11:33 +0000
Message-ID: <DM5PR12MB1708D46BE6245D9A563C1195844E0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1595926842-12994-1-git-send-email-Monk.Liu@amd.com>
 <ff150645-5527-bad5-7155-6e60734b3297@amd.com>
In-Reply-To: <ff150645-5527-bad5-7155-6e60734b3297@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3c1521d0-2324-4293-b707-00003324ae55;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-31T02:05:21Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f55ee6fd-ff14-46ca-bb88-08d834f70c3d
x-ms-traffictypediagnostic: DM6PR12MB3692:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36928F5DBF2CFED96447D1CE844E0@DM6PR12MB3692.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xxy/u+d8/OUleHCUhC6LIk7QUwAuraweioxw/6rPq3GYRDznVuq5ymzsMKEESROVk3R4Ck5JEigCBTPKAcgv22GIJdcTE1Rcts3K+N6xjnvlB4O2XFUt62KOOGstOXtFXnC7IlVAfww5xz+OPUoFRe/KQvpbzYZvUTG1ZZay47OSsUw8soIgxzehMenSaxFt3ishAaL8CRATxJkpAaGTOHCn9Shh4sZVMJN2Z8Jh+NybB8P+OBXUyVMSSCR1tozY0ixwVDTFH566prfJ9XFcN4VVnzXU+QbfyMuy7WFOwfNFAfTVDk9RlOReO06Apw7k64Gx/SMcvprdJ6UxDT9Lng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(8676002)(86362001)(55016002)(8936002)(9686003)(83380400001)(6506007)(5660300002)(76116006)(110136005)(53546011)(186003)(26005)(7696005)(71200400001)(30864003)(66476007)(478600001)(33656002)(2906002)(52536014)(64756008)(316002)(66446008)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dDLkat30/vjERJzgbLKiuXRn1JLXirqemK/28Md2OiJV6LiVbCtOXC4jgcAbBm9ZfFOu2oo4Z5ZFS/oK1wsbeGpWiCHQgc2Zspy4cmFpITg53dWKanQ+xn3lp1YUyNakl6RfEDsycQtjgUzA1fMnv0FDUBFW8iXl0C16k7POZOxHS6SOJ3tZYvxTRNykOF2shjzvBMhI713M89xPmIMQIwneMO8YPbtTldAxD6WrbpKeTyNCJ+WdUr/6cuRKYZSezwZJMqrhNYlxG+/HHt4BpU4QJWDOjnT8OLOjnHSmRfBj7IDJwzL0on3fZSXLaFXsafobL8rSdv963A9cA+z+dytIG3TH+pyJL9iVCXec9x4DvQV9QerXibVDqfOdfLGKX9mZ3U0TGz6+mZLIX69sHA3mwKuqekZrdPQyM0GSEjAUm4hYvxnEUUen52lfO74DPSHZ/e880WxagVZej27QtrcrGjfsEEaK5yqeV760+JfKXJPcU0p57Z5MxZmCDYOI
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55ee6fd-ff14-46ca-bb88-08d834f70c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 02:11:33.8884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0x0X66JQ4mHa9bPjTbEXKPjrfo1RCkd8TVxjajbFDJ9fglNR4w7a48dJyZUmNCXY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
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

>>> Indentation looks wrong. Did you use the wrong TAB size?

My TAB size is 4 space, and I don't know why it looks strange , but I can use space to replace the TABs anyway

Will send v4 patch against other suggestions from your side soon

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Tuesday, July 28, 2020 10:38 PM
To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: introduce a new parameter to configure how many KCQ we want(v3)

Am 2020-07-28 um 5:00 a.m. schrieb Monk Liu:
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

Thanks. Some more suggestions for simplifications inline.


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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 58 +++++++++++++++---------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 30 ++++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 29 +++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 31 ++++++++--------
>  7 files changed, 87 insertions(+), 71 deletions(-)
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
> index 8eff017..f83a9a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -202,40 +202,42 @@ bool
> amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
>
>  void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)  {
> -int i, queue, pipe, mec;
> +int i, queue, pipe;
>  bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
> +int max_queues_per_mec = min(adev->gfx.mec.num_pipe_per_mec *
> + adev->gfx.mec.num_queue_per_pipe,
> + adev->gfx.num_compute_rings);

Indentation looks wrong. Did you use the wrong TAB size?


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

You could also use i < max_queues_per_mec here.


> +queue = i % adev->gfx.mec.num_queue_per_pipe;
> +pipe = (i / adev->gfx.mec.num_queue_per_pipe)
> +% adev->gfx.mec.num_pipe_per_mec;
> +mec = (i / adev->gfx.mec.num_queue_per_pipe)
> +/ adev->gfx.mec.num_pipe_per_mec;

Then mec will always be 0 and you can eliminate that variable.


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

And you won't need this if (...) break; any more.

It'll make the two policy cases look more similar, so it's easier to see how they are actually different.

Regards,
  Felix


> +
> +set_bit(i, adev->gfx.mec.queue_bitmap);
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

Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D69C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 06:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B3520786
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 06:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sF50AvqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B3520786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D08089BEC;
	Tue, 28 Jul 2020 06:53:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCD089BEC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 06:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfxOlbSp8/6RZdnQ0aPGP5ZhAE56hE2+RgvqgJtXGAP6x2HH/WiL8anNgfd6Doy5D4EFPxGaZokxILnsSwK2VAsEVah5hSx3x8sTfjbsEc9WQOViNbLKWJ0WgwmVS9nmRy2iN9j6eAsGp+v2iSVU3NuHZdnOfZAgciWerihvyso062d4v0F/NLbXGKJZmbXEh/izCFDOcSRp/Ik0qfduBaiRnildhs8RhyvfKkHkMmugmYUF6Mo2arfTf4XoMq0urWs9VO7C2NH4MfEONUA8sl6WwF9hSfLfrX0Dj6aGv2HNcLxbvSsh5rHV7WB2NRRv0DRiz2e+krGbMqNLsr0NCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/NxhCRxTdS6/5NKsMXU6u1ZsQZnyFSfmKfrgbjFRug=;
 b=oMTBC9yBtb7fxEYp3frxPvs1IaR9KbBQezIVQ1W0n2k1gE2lamw+Eqr7Rd8svI7houhX2XoUj110E/96Fvb/EUBIbscCNLoWIr7LU9nkZsXtVELGxYcDx/3tK6mcRoXs+exjhgC5tSmOys5XLX8G4r1kT54Y+tlmoQckGd2moJQAQv9OP7JlPl4myhW4PpXZFufVdg4dA7rjW+jcrsdMrmGftFHFGXL3ZBeYqKPgBht2py3ytF8mtf0in3qVTS19Qr76bq3yjo1tOViGFbXK8mbvvAY6NwYDiGYczfkLLJDWNWhD1l4NSiQnxrq7QNI2p3uNoRZmUgaLzrydQkZSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/NxhCRxTdS6/5NKsMXU6u1ZsQZnyFSfmKfrgbjFRug=;
 b=sF50AvqZVKywhSEYCoPS9cbfYHDdna2Se54kJv6qVcTuFLvg4n5hRLa4A63+3hui4R82dsYKhP+8TZBHl8GLfI1f457fslGu4m/+WVdqP/jCVoO8rNVZeejzfgRssxxckPniKoG0/SbEXzi8IZoI181qQwCXXZ7k1HgFmcQiFco=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 06:53:18 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 06:53:18 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: introduce a new parameter to configure how
 many KCQ we want(v2)
Thread-Topic: [PATCH] drm/amdgpu: introduce a new parameter to configure how
 many KCQ we want(v2)
Thread-Index: AQHWZANM7k7Jyy2NfkSBDg6aCLHJ8KkcFH2AgAB6gMA=
Date: Tue, 28 Jul 2020 06:53:17 +0000
Message-ID: <DM5PR12MB1708B53A00F6D678E7A5FE8984730@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1595846833-22320-1-git-send-email-Monk.Liu@amd.com>
 <83ff7805-e8eb-3450-c909-e65fe0b2f95f@amd.com>
In-Reply-To: <83ff7805-e8eb-3450-c909-e65fe0b2f95f@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=314aebda-450a-4bf0-95fc-000027798f59;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-28T06:51:24Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec0a2753-54d4-465b-2efb-08d832c2e89c
x-ms-traffictypediagnostic: DM6PR12MB4433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4433B81094F6FBBF5DF3A7B184730@DM6PR12MB4433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gJcuHynaGT0xJz+Dwoef9fXqbRNnZ53vvCPTWOFCJ7GovSaMmq/SMUlukNGsrfpZ8tdYtXYAYSyckBAdEcPCaRncEgqqtenvb/CUgnFOEggp7mRbVlm8muIaMHVHa3B5lHicHFGB7nXY0Lv4PG2o/Ju58x4NCpsssDwvhfcwEusCtvkoNZr6Vrv9EEz6U6DY/cdEBrOryHyuy6nGhxhkvMNLZm2lCgSGy/bDsyytYgOkeTZTvBXUGuUC5eeUh21YZcIWDKLFjfulLON7ln1F6qPtp+nmepV/BxhSSlslefTOTcd0edKRHSviZAUNrxr3wX7rYQL1rDVAO+iJyDFrdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(7696005)(33656002)(30864003)(8936002)(9686003)(478600001)(316002)(71200400001)(2906002)(55016002)(64756008)(53546011)(66946007)(6506007)(66556008)(66446008)(110136005)(8676002)(76116006)(66476007)(5660300002)(186003)(86362001)(83380400001)(26005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: rOpTsqKeBBuYYmSj4qLM182jAkEC5F5VFK9NkIlBRvHODJ0gra2GYUn0GSGtW5tLjhj/O78zsRuDYeZSekLt5X3Mj6RnYwaCeuX/8/Rhn3TzxCA8sefsXjk8Xf53pKxrRDraAiGnVeqordNA6j9WPDt7BJPsmqb4XdDZejyRzti+qgKhY2vN7Db3UK35xcU9PQozdgKojwie/iXIQVZ8U+KwHRTOOT7bqnsbxMVDJPvv0lRxr80eB9rieGdA4B/0zF+ylzqqdwp3a+4ymKTx4XGuwJ+QmEGfagKWFV59x14MZbpcIbBb3NsK45NQiW0JKbgWGMoJpssMisyT2uaYi8LC53gNZqivcVVf6DAzBW6JWogp/PrUNu+uYftkKDgbRZa3GIjVv5yalmW0ldIjXIK6xTCKxoz5OtMetTJaXyURZXX4E6R7YqQzQlu4cfJW1aW1e2Ygy7QDol1vuEZVh9xjPxENNzOH/Kryje71RgFoBPsaGvqZke3fpKJay6o1
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0a2753-54d4-465b-2efb-08d832c2e89c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 06:53:17.9289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58K6l99/L1o18NaP1SPeVpWGOiiYcTIn0s0kSaZGOmp8MM20BesC8KXBKAt/+rN4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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

Thanks Felix

I reworked my patch with your suggestion and I can get queues evenly cross pipes, e.g.: modprobe amdgpu num_kcq=6

[  409.878557] amdgpu 0000:00:07.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  409.878559] amdgpu 0000:00:07.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  409.878561] amdgpu 0000:00:07.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[  409.878563] amdgpu 0000:00:07.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[  409.878565] amdgpu 0000:00:07.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[  409.878567] amdgpu 0000:00:07.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[  409.878568] amdgpu 0000:00:07.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 9 on hub 0

Please review my patch upcoming

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Tuesday, July 28, 2020 7:33 AM
To: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: introduce a new parameter to configure how many KCQ we want(v2)

Am 2020-07-27 um 6:47 a.m. schrieb Monk Liu:
> what:
> the MQD's save and restore of kernel compute queues cost lots of
> clocks during world switch which impacts a lot to multi-VF performance
>
> how:
> introduce a paramter to control the number of kernel compute queues to
> avoid performance drop if there is no kernel compute queue needed
>
> notes:
> this paramter only affects gfx 8/9/10
>
> TODO:
> in the future we will let hypervisor driver to set this paramter
> automatically thus no need for user to configure it through modprobe
> in virtual machine
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 27 +++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 30 +++++++++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 29 ++++++++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 31 +++++++++++++++---------------
>  7 files changed, 71 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e97c088..71a3d6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -201,6 +201,7 @@ extern int amdgpu_si_support;  #ifdef
> CONFIG_DRM_AMDGPU_CIK  extern int amdgpu_cik_support;  #endif
> +extern int amdgpu_num_kcq_user_set;
>
>  #define AMDGPU_VM_MAX_NUM_CTX4096
>  #define AMDGPU_SG_THRESHOLD(256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62ecac9..18b93ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1199,6 +1199,11 @@ static int amdgpu_device_check_arguments(struct
> amdgpu_device *adev)
>
>  amdgpu_gmc_tmz_set(adev);
>
> +if (amdgpu_num_kcq_user_set > 8 || amdgpu_num_kcq_user_set < 0) {
> +amdgpu_num_kcq_user_set = 8;
> +dev_warn(adev-dev, "set KCQ number to 8 due to invalid paramter provided by user\n");
> +}
> +
>  return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6291f5f..03a94e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -150,6 +150,7 @@ int amdgpu_noretry;  int amdgpu_force_asic_type =
> -1;  int amdgpu_tmz = 0;  int amdgpu_reset_method = -1; /* auto */
> +int amdgpu_num_kcq_user_set = 8;
>
>  struct amdgpu_mgpu_info mgpu_info = {
>  .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> @@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
> MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default),
> 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
> module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>
> +MODULE_PARM_DESC(num_kcq, "number of KCQ user want to setup (8 if set
> +to greater than 8 or less than 0, only affect gfx 8+)");
> +module_param_named(num_kcq, amdgpu_num_kcq_user_set, int, 0444);
> +
>  static const struct pci_device_id pciidlist[] = {  #ifdef
> CONFIG_DRM_AMDGPU_SI
>  {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI}, diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8eff017..0b59049 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -202,7 +202,7 @@ bool
> amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
>
>  void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)  {
> -int i, queue, pipe, mec;
> +int i, queue, pipe, mec, j = 0;
>  bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
>
>  /* policy for amdgpu compute queue ownership */ @@ -219,23 +219,24
> @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
>
>  if (multipipe_policy) {
>  /* policy: amdgpu owns the first two queues of the first MEC */
> -if (mec == 0 && queue < 2)
> -set_bit(i, adev->gfx.mec.queue_bitmap);
> +if (mec == 0 && queue < 2) {
> +if (j++ < adev->gfx.num_compute_rings)

This is not ideal, because it wouldn't distribute the queues evenly across pipes if there are fewer than 7. I would change how queue and pipe are calculated from i for the multipipe_policy case:

if (multipipe_policy) {
pipe = i % adev->gfx.mec.num_pipe_per_mec;
queue = (i / adev->gfx.mec.num_pipe_per_mec)
% adev->gfx.mec.num_queue_per_pipe;
} else {
/* previous way */
}

Then your change will work better.

Regards,
  Felix


> +set_bit(i, adev->gfx.mec.queue_bitmap);
> +else
> +break;
> +}
>  } else {
>  /* policy: amdgpu owns all queues in the first pipe */
> -if (mec == 0 && pipe == 0)
> -set_bit(i, adev->gfx.mec.queue_bitmap);
> +if (mec == 0 && pipe == 0) {
> +if (j++ < adev->gfx.num_compute_rings)
> +set_bit(i, adev->gfx.mec.queue_bitmap);
> +else
> +break;
> +}
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
> index db9f1e8..2ad8393 100644
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
> +adev->gfx.num_compute_rings = amdgpu_num_kcq_user_set;
>
>  gfx_v10_0_set_kiq_pm4_funcs(adev);
>  gfx_v10_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 8d72089..6d95b4b 100644
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
> +adev->gfx.num_compute_rings = amdgpu_num_kcq_user_set;
>  adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
>  gfx_v8_0_set_ring_funcs(adev);
>  gfx_v8_0_set_irq_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e4e751f..43bcfe3 100644
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
> +adev->gfx.num_compute_rings = amdgpu_num_kcq_user_set;
>  gfx_v9_0_set_kiq_pm4_funcs(adev);
>  gfx_v9_0_set_ring_funcs(adev);
>  gfx_v9_0_set_irq_funcs(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEA9C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 16:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E7121736
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 16:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E7121736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4027189D84;
	Fri, 29 Nov 2019 16:22:11 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800088.outbound.protection.outlook.com [40.107.80.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A322289D84
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 16:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYUSp+YQpSU7dCNP0DjIYi2eciP8l36y7lqHaoIsWHonIL61JF6Hr7Gcra9Q9Y3dfAOfj4S5oVQQdNpdYsP8gIFCobhkkAu6jpvLdLQ9IJsz7uFgpeNZKTEt1t4DZ2i2McsYhvG1r7g8IuBr/jBVD+d03wO6kAinz+HLWFhGX9hYoaoukuCiCxsOiJFoTsRNIWbmdmWl6IrRJahD3U8D+8021QudlVN0/La7TX0cZ0aEXIlCCCIGzDdAQrw+8TZQ5GGU/A96oXrrAlmQRm5/tFhi0lcTgryjGVP+rNQNROPQNSbdB6lrCGLaoC1yDFwu6yanIXX7gZyMXnDt9YhJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MeR5fJbhxYhcrw6rRNFMG07ruzfVLQYVd2ERprO3Ec=;
 b=AKB9hpqoce4wQ3ckpa7LWWSt7YwVTB3RFo5GMAyyZOWTFsh66gIk4TUVIOrDOcoYQW07rFtE+6a0gK32KcXoEEe1BRMofjZ6M44Mfq995xsfDsfhC+9+NgwuyzHuJ05flOwQWkcrx+aWkAxjD/wh0M2DgDGHakQg+0ZGTwYXBor/tZtGzf6DlAsP/QDWxB0hTeYROo4hO5geAzdJ2LDMUhnGacyj3SYx2OqzYB7szAIq74bmptn3j/u6VnlZ/iljrSO9ntCyIynTZh9vYnVaAQE0l5TDtqIv3rDepY2bqeVx2/A1jXaTcXSVAzi14T5/sTrQhzAAEOKEIiXGoYPvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1309.namprd12.prod.outlook.com (10.169.205.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 16:22:03 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 16:22:03 +0000
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
To: "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-6-git-send-email-le.ma@amd.com>
 <c09d7928-f864-3a80-40e2-b6116abe044c@amd.com>
 <MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <157d7671-803c-4f6e-f77c-9738f32905e3@amd.com>
Date: Fri, 29 Nov 2019 11:21:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:404:121::11) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:3edf:e127:3ce3:5665:de77:b683]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 600bea7a-efdb-450b-e532-08d774e844c7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:|MWHPR12MB1309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB130950A44BDB80F9FC8B0699EA460@MWHPR12MB1309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0236114672
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(189003)(199004)(13464003)(33964004)(31696002)(6436002)(86362001)(8676002)(386003)(71190400001)(11346002)(65956001)(478600001)(65806001)(6116002)(2906002)(46003)(7736002)(31686004)(2616005)(5660300002)(790700001)(14444005)(186003)(6512007)(236005)(6506007)(446003)(52116002)(14454004)(36756003)(316002)(16586007)(76176011)(2501003)(229853002)(25786009)(8936002)(54906003)(54896002)(6246003)(6486002)(81156014)(53546011)(81166006)(110136005)(58126008)(4326008)(6666004)(37036004)(66476007)(66556008)(99286004)(66946007)(30864003)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1309;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUduBGbozS44Cvt140eAFO+mmOfBbWQzMe5DFGJlZ7W4W6FsSYvdpL2bQz3ESbS9d3SbBwvj40LdWAMao3Wrz0M8/mIRra3uPu06Q4QNZKnyRbU8T8XfNkDOGZobplHEj0z9mCwQngT98T7hqqBJqHknNCwaeWw+Ki5ipe8A+zd2fcdB9BrGiW0FkwNYkoQtkAk5IJ/GiGHEopz4kzsEhBXDYqYDAI5LG1l21QLovo+vaiUml0fk77bYPNnzGOuUHHwpCFp1qRyEpbYd4uiXvANltj9aQENxatNF7/syVO5jUwcYbf4zNTVOJX+U6iaxu4GUC2t2VoluomA0bNoa4BFpgPjH8ii0sRNX1OgZTdNiL1Ba90s24zIVglBJdIHb/ZqwBMTqo/XE6YiTjyEWnOpLgP1XIQnhvurD0OpDLfJOehym4TwLfYHx5tqIRg+u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600bea7a-efdb-450b-e532-08d774e844c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 16:22:03.4468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxrPEvSPcFPsunLqF2V+iCy43trjJdXQ8lB2tpJZEXBEUVffm1Y195UDyOU0OQcRQ1ZfU/fBWk6dCra3sWBhVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MeR5fJbhxYhcrw6rRNFMG07ruzfVLQYVd2ERprO3Ec=;
 b=tgj2VAvZ6IYykXtkcth1v1ESOubQgXxEfLbdeUPJbI3GYyYKhuIQQHdkPpOW6YNQmDIy0FHqYTnbduCHsqyY2KG3P3xqQzA9HthpE25aJNmaZk/dMIZJ+o/rOeisKgbTm5dxdoIgFGyZubHkoNEkuFfBxWkv/UfFIgxVKXIpmuU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0537108462=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0537108462==
Content-Type: multipart/alternative;
 boundary="------------E2FBBA052F5E87676CF63DA1"
Content-Language: en-US

--------------E2FBBA052F5E87676CF63DA1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/28/19 4:00 AM, Ma, Le wrote:
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Wednesday, November 27, 2019 11:46 PM
> To: Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao 
> <Tao.Zhou1@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; 
> Li, Dennis <Dennis.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset 
> support for XGMI
>
> On 11/27/19 4:15 AM, Le Ma wrote:
>
> > Currently each XGMI node reset wq does not run in parrallel because
>
> > same work item bound to same cpu runs in sequence. So change to bound
>
> > the xgmi_reset_work item to different cpus.
>
> It's not the same work item, see more bellow
>
> >
>
> > XGMI requires all nodes enter into baco within very close proximity
>
> > before any node exit baco. So schedule the xgmi_reset_work wq twice
>
> > for enter/exit baco respectively.
>
> >
>
> > The default reset code path and methods do not change for vega20 
> production:
>
> >    - baco reset without xgmi/ras
>
> >    - psp reset with xgmi/ras
>
> >
>
> > To enable baco for XGMI/RAS case, both 2 conditions below are needed:
>
> >    - amdgpu_ras_enable=2
>
> >    - baco-supported smu firmware
>
> >
>
> > The case that PSP reset and baco reset coexist within an XGMI hive is
>
> > not in the consideration.
>
> >
>
> > Change-Id: I9c08cf90134f940b42e20d2129ff87fba761c532
>
> > Signed-off-by: Le Ma <le.ma@amd.com <mailto:le.ma@amd.com>>
>
> > ---
>
> > drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
>
> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 78 
> ++++++++++++++++++++++++++----
>
> >   2 files changed, 70 insertions(+), 10 deletions(-)
>
> >
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
> > index d120fe5..08929e6 100644
>
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
> > @@ -998,6 +998,8 @@ struct amdgpu_device {
>
> > int                                           pstate;
>
> >          /* enable runtime pm on the device */
>
> > bool                            runpm;
>
> > +
>
> > + bool                                        in_baco;
>
> >   };
>
> >
>
> >   static inline struct amdgpu_device *amdgpu_ttm_adev(struct
>
> > ttm_bo_device *bdev) diff --git
>
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
> > index bd387bb..71abfe9 100644
>
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
> > @@ -2654,7 +2654,13 @@ static void 
> amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>
> >          struct amdgpu_device *adev =
>
> > container_of(__work, struct amdgpu_device, xgmi_reset_work);
>
> >
>
> > -       adev->asic_reset_res = amdgpu_asic_reset(adev);
>
> > +      if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)
>
> > + adev->asic_reset_res = (adev->in_baco == false) ?
>
> > +             amdgpu_device_baco_enter(adev->ddev) :
>
> > +             amdgpu_device_baco_exit(adev->ddev);
>
> > +      else
>
> > + adev->asic_reset_res = amdgpu_asic_reset(adev);
>
> > +
>
> >          if (adev->asic_reset_res)
>
> >                      DRM_WARN("ASIC reset failed with error, %d for 
> drm dev, %s",
>
> >  adev->asic_reset_res, adev->ddev->unique); @@ -3796,6 +3802,7 @@
>
> > static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>
> >          struct amdgpu_device *tmp_adev = NULL;
>
> >          bool need_full_reset = *need_full_reset_arg, vram_lost = false;
>
> >          int r = 0;
>
> > +      int cpu = smp_processor_id();
>
> >
>
> >          /*
>
> >           * ASIC reset has to be done on all HGMI hive nodes ASAP @@
>
> > -3803,21 +3810,24 @@ static int amdgpu_do_asic_reset(struct 
> amdgpu_hive_info *hive,
>
> >           */
>
> >          if (need_full_reset) {
>
> > list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>
> > -                               /* For XGMI run all resets in 
> parallel to speed up the process */
>
> > +                              /*
>
> > +                              * For XGMI run all resets in parallel 
> to speed up the
>
> > +                              * process by scheduling the highpri 
> wq on different
>
> > +                              * cpus. For XGMI with baco reset, all 
> nodes must enter
>
> > +                              * baco within close proximity before 
> anyone exit.
>
> > +                              */
>
> >                                  if 
> (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>
> > -                                           if 
> (!queue_work(system_highpri_wq, &tmp_adev->xgmi_reset_work))
>
> Note that tmp_adev->xgmi_reset_work (the work item) is per device in 
> XGMI hive and not the same work item. So I don't see why you need to 
> explicitly queue them on different CPUs, they should run in parallel 
> already.
>
> Andrey
>
> [Le]: It’s also beyond my understanding that the 2 node reset work 
> items scheduled to same cpu does not run in parallel. But from the 
> experiment result in my side, the 2nd work item always run after 1st 
> work item finished. Based on this result, I changed to queue them on 
> different CPUs to make sure more XGMI nodes case to run in parallel, 
> because baco requires all nodes enter baco within very close proximity.
>
> The experiment code is as following for your reference. When card0 
> worker running, card1 worker is not observed to run.
>

The code bellow will only test that they don't run concurrently - but 
this doesn't mean they don't run on different CPUs and threads,I don't 
have an XGMI setup at hand to test this theory but what if there is some 
locking dependency between them that serializes their execution ? Can 
you just add a one line print inside amdgpu_device_xgmi_reset_func that 
prints CPU id, thread name/id and card number ?

Andrey


> +atomic_t card0_in_baco = ATOMIC_INIT(0);
>
> +atomic_t card1_in_baco = ATOMIC_INIT(0);
>
> +
>
> static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>
> {
>
> struct amdgpu_device *adev =
>
> container_of(__work, struct amdgpu_device, xgmi_reset_work);
>
> + printk("lema1: card 0x%x goes into reset wq\n", 
> adev->pdev->bus->number);
>
> + if (adev->pdev->bus->number == 0x7) {
>
> + atomic_set(&card1_in_baco, 1);
>
> + printk("lema1: card1 in baco from card1 view\n");
>
> + }
>
> +
>
> if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)
>
>                adev->asic_reset_res = (adev->in_baco == false) ?
>
> amdgpu_device_baco_enter(adev->ddev) :
>
> @@ -2664,6 +2673,23 @@ static void 
> amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>
> if (adev->asic_reset_res)
>
> DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
>
> adev->asic_reset_res, adev->ddev->unique);
>
> +
>
> + if (adev->pdev->bus->number == 0x4) {
>
> + atomic_set(&card0_in_baco, 1);
>
> +        printk("lema1: card0 in baco from card0 view\n");
>
> +
>
> + while (true)
>
> + if (!!atomic_read(&card1_in_baco))
>
> + break;
>
> + printk("lema1: card1 in baco from card0 view\n");
>
> +     }
>
> +
>
> + if (adev->pdev->bus->number == 0x7) {
>
> + while (true)
>
> + if (!!atomic_read(&card0_in_baco))
>
> + break;
>
> + printk("lema1: card0 in baco from card1 view\n");
>
> + }
>
> > +                                          if (!queue_work_on(cpu, 
> system_highpri_wq,
>
> > +    &tmp_adev->xgmi_reset_work))
>
> >                                                        r = -EALREADY;
>
> > +                                          cpu = cpumask_next(cpu, 
> cpu_online_mask);
>
> >                                  } else
>
> >                                            r = 
> amdgpu_asic_reset(tmp_adev);
>
> > -
>
> > -                               if (r) {
>
> > -                                           DRM_ERROR("ASIC reset 
> failed with error, %d for drm dev, %s",
>
> > -                                                       r, 
> tmp_adev->ddev->unique);
>
> > +                              if (r)
>
> >                                            break;
>
> > -                               }
>
> >                      }
>
> >
>
> > -                   /* For XGMI wait for all PSP resets to complete 
> before proceed */
>
> > +                  /* For XGMI wait for all work to complete before 
> proceed */
>
> >                      if (!r) {
>
> > list_for_each_entry(tmp_adev, device_list_handle,
>
> >     gmc.xgmi.head) {
>
> > @@ -3826,11 +3836,59 @@ static int amdgpu_do_asic_reset(struct 
> amdgpu_hive_info *hive,
>
> >                                                        r = 
> tmp_adev->asic_reset_res;
>
> >                                                        if (r)
>
> > break;
>
> > + if(AMD_RESET_METHOD_BACO ==
>
> > + amdgpu_asic_reset_method(tmp_adev))
>
> > + tmp_adev->in_baco = true;
>
> >                                            }
>
> >                                  }
>
> >                      }
>
> > -       }
>
> >
>
> > +                  /*
>
> > +                  * For XGMI with baco reset, need exit baco phase 
> by scheduling
>
> > +                  * xgmi_reset_work one more time. PSP reset skips 
> this phase.
>
> > +                  * Not assume the situation that PSP reset and 
> baco reset
>
> > +                  * coexist within an XGMI hive.
>
> > +                  */
>
> > +
>
> > +                  if (!r) {
>
> > +                              cpu = smp_processor_id();
>
> > + list_for_each_entry(tmp_adev, device_list_handle,
>
> > + gmc.xgmi.head) {
>
> > +                                          if 
> (tmp_adev->gmc.xgmi.num_physical_nodes > 1
>
> > +                                              && 
> AMD_RESET_METHOD_BACO ==
>
> > + amdgpu_asic_reset_method(tmp_adev)) {
>
> > +                                                      if 
> (!queue_work_on(cpu,
>
> > + system_highpri_wq,
>
> > +             &tmp_adev->xgmi_reset_work))
>
> > + r = -EALREADY;
>
> > +                                                      if (r)
>
> > + break;
>
> > +                                                      cpu = 
> cpumask_next(cpu, cpu_online_mask);
>
> > +                                          }
>
> > +                              }
>
> > +                  }
>
> > +
>
> > +                  if (!r) {
>
> > + list_for_each_entry(tmp_adev, device_list_handle,
>
> > + gmc.xgmi.head) {
>
> > +                                          if 
> (tmp_adev->gmc.xgmi.num_physical_nodes > 1
>
> > +                                              && 
> AMD_RESET_METHOD_BACO ==
>
> > + amdgpu_asic_reset_method(tmp_adev)) {
>
> > + flush_work(&tmp_adev->xgmi_reset_work);
>
> > +                                                      r = 
> tmp_adev->asic_reset_res;
>
> > +                                                      if (r)
>
> > + break;
>
> > + tmp_adev->in_baco = false;
>
> > +                                          }
>
> > +                              }
>
> > +                  }
>
> > +
>
> > +                  if (r) {
>
> > + DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
>
> > +                                          r, tmp_adev->ddev->unique);
>
> > +                              goto end;
>
> > +                  }
>
> > +      }
>
> >
>
> > list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>
> >                      if (need_full_reset) {
>

--------------E2FBBA052F5E87676CF63DA1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/28/19 4:00 AM, Ma, Le wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:14.0pt;
	font-family:"Calibri",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">-----Original Message-----<br>
          From: Grodzovsky, Andrey <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a> <br>
          Sent: Wednesday, November 27, 2019 11:46 PM<br>
          To: Ma, Le <a class="moz-txt-link-rfc2396E" href="mailto:Le.Ma@amd.com">&lt;Le.Ma@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
          Cc: Chen, Guchun <a class="moz-txt-link-rfc2396E" href="mailto:Guchun.Chen@amd.com">&lt;Guchun.Chen@amd.com&gt;</a>; Zhou1, Tao
          <a class="moz-txt-link-rfc2396E" href="mailto:Tao.Zhou1@amd.com">&lt;Tao.Zhou1@amd.com&gt;</a>; Deucher, Alexander
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis
          <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>; Zhang, Hawking
          <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
          Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco
          reset support for XGMI</p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">On 11/27/19 4:15 AM, Le Ma wrote:<o:p></o:p></p>
        <p class="MsoPlainText">&gt; Currently each XGMI node reset wq
          does not run in parrallel because
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; same work item bound to same cpu
          runs in sequence. So change to bound
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; the xgmi_reset_work item to
          different cpus.<o:p></o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">It's not the same work item, see more
          bellow<o:p></o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">&gt; XGMI requires all nodes enter into
          baco within very close proximity
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; before any node exit baco. So
          schedule the xgmi_reset_work wq twice
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; for enter/exit baco respectively.<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">&gt; The default reset code path and
          methods do not change for vega20 production:<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - baco reset without xgmi/ras<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - psp reset with xgmi/ras<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">&gt; To enable baco for XGMI/RAS case,
          both 2 conditions below are needed:<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - amdgpu_ras_enable=2<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - baco-supported smu firmware<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">&gt; The case that PSP reset and baco
          reset coexist within an XGMI hive is
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; not in the consideration.<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">&gt; Change-Id:
          I9c08cf90134f940b42e20d2129ff87fba761c532<o:p></o:p></p>
        <p class="MsoPlainText">&gt; Signed-off-by: Le Ma &lt;<a href="mailto:le.ma@amd.com" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">le.ma@amd.com</span></a>&gt;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; ---<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;
          drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;
          drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 78
          &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; 2 files changed, 70
          insertions(&#43;), 10 deletions(-)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">&gt; diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
        <p class="MsoPlainText">&gt; index d120fe5..08929e6 100644<o:p></o:p></p>
        <p class="MsoPlainText">&gt; ---
          a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&#43;&#43;
          b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
        <p class="MsoPlainText">&gt; @@ -998,6 &#43;998,8 @@ struct
          amdgpu_device {<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable runtime pm on
          the device */<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; runpm;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_baco;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; };<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; static inline struct
          amdgpu_device *amdgpu_ttm_adev(struct
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; ttm_bo_device *bdev) diff --git <o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
        <p class="MsoPlainText">&gt; index bd387bb..71abfe9 100644<o:p></o:p></p>
        <p class="MsoPlainText">&gt; ---
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&#43;&#43;
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
        <p class="MsoPlainText">&gt; @@ -2654,7 &#43;2654,13 @@ static void
          amdgpu_device_xgmi_reset_func(struct work_struct *__work)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev
          =<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          container_of(__work, struct amdgpu_device, xgmi_reset_work);<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
        <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_reset_res =&nbsp;
          amdgpu_asic_reset(adev);<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          adev-&gt;asic_reset_res = (adev-&gt;in_baco == false) ?<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_baco_enter(adev-&gt;ddev) :<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_baco_exit(adev-&gt;ddev);<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          adev-&gt;asic_reset_res = amdgpu_asic_reset(adev);<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (adev-&gt;asic_reset_res)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;ASIC
          reset failed with error, %d for drm dev, %s&quot;,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;adev-&gt;asic_reset_res, adev-&gt;ddev-&gt;unique); @@
          -3796,6 &#43;3802,7 @@
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; static int
          amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device
          *tmp_adev = NULL;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset =
          *need_full_reset_arg, vram_lost = false;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cpu =
          smp_processor_id();<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* ASIC reset has to be
          done on all HGMI hive nodes ASAP @@
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; -3803,21 &#43;3810,24 @@ static int
          amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;*/<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (need_full_reset) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          list_for_each_entry(tmp_adev, device_list_handle,
          gmc.xgmi.head) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
          For XGMI run all resets in parallel to speed up the process */<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
          For XGMI run all resets in parallel to speed up the<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
          process by scheduling the highpri wq on different<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
          cpus. For XGMI with baco reset, all nodes must enter<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
          baco within close proximity before anyone exit.<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (tmp_adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (!queue_work(system_highpri_wq,
          &amp;tmp_adev-&gt;xgmi_reset_work))<o:p></o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">Note that tmp_adev-&gt;xgmi_reset_work
          (the work item) is per device in XGMI hive and not the same
          work item. So I don't see why you need to explicitly queue
          them on different CPUs, they should run in parallel already.<o:p></o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">Andrey<o:p></o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">[Le]:
            It’s also beyond my understanding that the 2 node reset work
            items scheduled to same cpu does not run in parallel. But
            from the experiment result in my side, the 2nd work item
            always run after 1st work item finished. Based on this
            result, I changed to queue them on different CPUs to make
            sure more XGMI nodes case to run in parallel, because baco
            requires all nodes enter baco within very close proximity. <o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">The
            experiment code is as following for your reference. When
            card0 worker running, card1 worker is not observed to run.</span></p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>The code bellow will only test that they don't run concurrently -
      but this doesn't mean they don't run on different CPUs and
      threads,I don't have an XGMI setup at hand to test this theory but
      what if there is some locking dependency between them that
      serializes their execution ? Can you just add a one line print
      inside <span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">amdgpu_device_xgmi_reset_func
      </span>that prints CPU id, thread name/id and card number ?</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%"><o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;atomic_t
            card0_in_baco = ATOMIC_INIT(0);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;atomic_t
            card1_in_baco = ATOMIC_INIT(0);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">static
            void amdgpu_device_xgmi_reset_func(struct work_struct
            *__work)<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">{<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            struct amdgpu_device *adev =<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            container_of(__work, struct amdgpu_device, xgmi_reset_work);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            printk(&quot;lema1: card 0x%x goes into reset wq\n&quot;,
            adev-&gt;pdev-&gt;bus-&gt;number);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (adev-&gt;pdev-&gt;bus-&gt;number == 0x7) {<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            atomic_set(&amp;card1_in_baco, 1);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            printk(&quot;lema1: card1 in baco from card1 view\n&quot;);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            }<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;adev-&gt;asic_reset_res
            = (adev-&gt;in_baco == false) ?<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            amdgpu_device_baco_enter(adev-&gt;ddev) :<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">@@
            -2664,6 &#43;2673,23 @@ static void
            amdgpu_device_xgmi_reset_func(struct work_struct *__work)<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (adev-&gt;asic_reset_res)<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            DRM_WARN(&quot;ASIC reset failed with error, %d for drm dev, %s&quot;,<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            adev-&gt;asic_reset_res, adev-&gt;ddev-&gt;unique);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (adev-&gt;pdev-&gt;bus-&gt;number == 0x4) {<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            atomic_set(&amp;card0_in_baco, 1);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printk(&quot;lema1: card0 in baco from card0 view\n&quot;);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            while (true)<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (!!atomic_read(&amp;card1_in_baco))<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            break;<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            printk(&quot;lema1: card1 in baco from card0 view\n&quot;);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;}<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (adev-&gt;pdev-&gt;bus-&gt;number == 0x7) {<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            while (true)<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (!!atomic_read(&amp;card0_in_baco))<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            break;<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            printk(&quot;lema1: card0 in baco from card1 view\n&quot;);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#203864;mso-style-textfill-fill-color:#203864;mso-style-textfill-fill-alpha:100.0%">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            }<o:p></o:p></span></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (!queue_work_on(cpu, system_highpri_wq,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp; &amp;tmp_adev-&gt;xgmi_reset_work))<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
          -EALREADY;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu =
          cpumask_next(cpu, cpu_online_mask);<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          else<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
          amdgpu_asic_reset(tmp_adev);<o:p></o:p></p>
        <p class="MsoPlainText">&gt; -<o:p></o:p></p>
        <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (r) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;ASIC
          reset failed with error, %d for drm dev, %s&quot;,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r,
          tmp_adev-&gt;ddev-&gt;unique);<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (r)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
        <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI
          wait for all PSP resets to complete before proceed */<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI wait
          for all work to complete before proceed */<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          list_for_each_entry(tmp_adev, device_list_handle,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;gmc.xgmi.head) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt; @@ -3826,11 &#43;3836,59 @@ static int
          amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
          tmp_adev-&gt;asic_reset_res;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          break;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          if(AMD_RESET_METHOD_BACO ==<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
          amdgpu_asic_reset_method(tmp_adev))<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          tmp_adev-&gt;in_baco = true;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For XGMI with
          baco reset, need exit baco phase by scheduling<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
          xgmi_reset_work one more time. PSP reset skips this phase.<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Not assume the
          situation that PSP reset and baco reset<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * coexist within
          an XGMI hive.<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu
          = smp_processor_id();<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          list_for_each_entry(tmp_adev, device_list_handle,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
          gmc.xgmi.head) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (tmp_adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &amp;&amp;
          AMD_RESET_METHOD_BACO ==<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
          amdgpu_asic_reset_method(tmp_adev)) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (!queue_work_on(cpu,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          system_highpri_wq,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tmp_adev-&gt;xgmi_reset_work))<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          r = -EALREADY;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          break;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu =
          cpumask_next(cpu, cpu_online_mask);<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          list_for_each_entry(tmp_adev, device_list_handle,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
          gmc.xgmi.head) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (tmp_adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &amp;&amp;
          AMD_RESET_METHOD_BACO ==<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
          amdgpu_asic_reset_method(tmp_adev)) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          flush_work(&amp;tmp_adev-&gt;xgmi_reset_work);<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
          tmp_adev-&gt;asic_reset_res;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          break;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          tmp_adev-&gt;in_baco = false;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          DRM_ERROR(&quot;ASIC reset failed with error, %d for drm dev, %s&quot;,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r,
          tmp_adev-&gt;ddev-&gt;unique);<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto
          end;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          list_for_each_entry(tmp_adev, device_list_handle,
          gmc.xgmi.head) {<o:p></o:p></p>
        <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (need_full_reset) {<o:p></o:p></p>
      </div>
    </blockquote>
  </body>
</html>

--------------E2FBBA052F5E87676CF63DA1--

--===============0537108462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0537108462==--

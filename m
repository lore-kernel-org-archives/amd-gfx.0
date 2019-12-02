Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8EFC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 22:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F632071E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 22:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F632071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B116E222;
	Mon,  2 Dec 2019 22:05:17 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790075.outbound.protection.outlook.com [40.107.79.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294E46E222
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 22:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vgg93ZZ//sRnxSvchBuVN2/J7KRVLrkrnabjRHLt+49KbKF+LqLUjdgPKZ3ETBYnr4bo1cO8VbOFNg3qgurFqvUycq0DJutZq2gvBfNvq9k9pRXueyndiR1qV/XrjUPhNZsHWGdtmE0gaQCkY47wMDlVYXk2aDZPq8A9ysZbPDPjY2211J8sPExySFAEcYRnnpGrK0I6SYoLtHpuZtDNqfWtY5NjAZEYpUaLzE+vcFVquY841objf07YrXhRlpZwSq2W53x4Pq4pSX5W7xfEsFL5vYtL9hhYWQRNFBmYLhpAaj5VzEvDCmRjIdSoMJv4ZqPbpT4Di8xfxYkNpLpyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfhGCHbuBBBc1BhHInq4ENHvpSk4h3VcUAbuMdandDs=;
 b=kOBIRWLwtpohTz8E87LQHGx8vwLaKh1rdrIbbF0Sdm4mMhkvJ0E4Qwf8tK/DM/7U30OkzVNYrTfnQwLY0Tbmu6HzDshBbe3isz/i+OXliADLNQE88dob1MmQ8yK3Dnnd2DRj/RXr989x2X6M3RXb60ql4y0hxL3aTA3hLoZwspsry7fhOBkMrGbqGaEvkE6zhb96RzSnIQZwGHmnLaIo/oXTuU/XaPkNLaRiUFMctBkqk4uHmF6Gw5KjxvDTAoDzS0gIcmepWvVg2iCt36u3qr9dADuRSFXD5O4oMw1rN3NjDvumuPLyv9ZAeVYipqTnc7LgHV35JXVTUfF296uvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1279.namprd12.prod.outlook.com (10.169.203.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Mon, 2 Dec 2019 22:05:12 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 22:05:12 +0000
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
To: "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-6-git-send-email-le.ma@amd.com>
 <c09d7928-f864-3a80-40e2-b6116abe044c@amd.com>
 <MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com>
 <157d7671-803c-4f6e-f77c-9738f32905e3@amd.com>
 <MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <5b505116-17aa-383d-5cdf-246663a1f4f9@amd.com>
Date: Mon, 2 Dec 2019 17:05:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::48) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 409d7643-b8ad-49c2-3a71-08d77773b39f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1279:|MWHPR12MB1279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB12795BF844FC0C855655CAF7EA430@MWHPR12MB1279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(13464003)(189003)(199004)(6486002)(386003)(6436002)(7736002)(33964004)(99286004)(229853002)(186003)(6506007)(26005)(52116002)(6512007)(53546011)(76176011)(236005)(66556008)(66476007)(66946007)(30864003)(31686004)(316002)(25786009)(54906003)(110136005)(16586007)(5660300002)(36756003)(37036004)(478600001)(2616005)(58126008)(3846002)(31696002)(6246003)(11346002)(446003)(71190400001)(14444005)(81166006)(81156014)(8676002)(8936002)(6666004)(54896002)(65956001)(66066001)(4326008)(14454004)(790700001)(86362001)(2906002)(65806001)(2501003)(6116002)(559001)(579004)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1279;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3kF3ZynWhoUmoyLsEAdA3gU4pjb2rz8V17I0tABHLXiyT8xthIVLdR/rAYLBHtIwIIjWH8zkcm4i8A7VFAs64WEtS1ZSp2BE1qtbSXgEvd2rdF/elY6Fo44JEIaRxNRkh2rJhN07acmtugN+2t3I3mim3FMiwfPOlpGWzMGyQz8XegR1QQyCocuB13qwrCfxSNjgZFza9p6KtQSVT2sAE+6ckPiT74+8i2QwdcPiyGL5gF6yaGzsnvyluUxgAz5AMzwerK9qLYOoGTK0JUoLJYPq7kL6PBhcH9WYQLWanyTpV/1xghASoEVMIYjD2XjYOV6ZoV3OeEGYsJAPBhvGho3k2gMxr/NvLbOb0L/9Syap2On2+QGZuF3YyFNp8hsLolQxf7jSpkn8zVwKwNW5jnclcYWSn4fs54SCC1o18kVGEmdescauo7HtRFHkaYD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409d7643-b8ad-49c2-3a71-08d77773b39f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 22:05:12.1742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BoaEQeGuHV/sJWa1nIYFbMTqZGF/gyW/ZGD+qQwn1gyQ1qoxJN9XSAI/ElEKF8ev/80bOzp5C3JZgZm4UASTXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1279
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfhGCHbuBBBc1BhHInq4ENHvpSk4h3VcUAbuMdandDs=;
 b=1jc+8YKVX3zgiolyI3/10t2qqDmt/6wtuvNARAYxDnpD9yaeteOg60GBEV+py5IMFiriClgIJHdcyJn5ChHtF/uJn0yiTtlTLFdRmyU/TMw147YRbByJEdn6jhnHbPWVBy6t5tcCkdCKOU38dVcsDyo88H8xPlZkF+H4JzbXDp4=
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
Content-Type: multipart/mixed; boundary="===============1999610180=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1999610180==
Content-Type: multipart/alternative;
 boundary="------------D51E830D76F5BB6B9A582DE0"
Content-Language: en-US

--------------D51E830D76F5BB6B9A582DE0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/2/19 6:42 AM, Ma, Le wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> *From:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *Sent:* Saturday, November 30, 2019 12:22 AM
> *To:* Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao 
> <Tao.Zhou1@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; 
> Li, Dennis <Dennis.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> *Subject:* Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset 
> support for XGMI
>
> On 11/28/19 4:00 AM, Ma, Le wrote:
>
>     -----Original Message-----
>     From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>     <mailto:Andrey.Grodzovsky@amd.com>
>     Sent: Wednesday, November 27, 2019 11:46 PM
>     To: Ma, Le <Le.Ma@amd.com> <mailto:Le.Ma@amd.com>;
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     Cc: Chen, Guchun <Guchun.Chen@amd.com>
>     <mailto:Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
>     <mailto:Tao.Zhou1@amd.com>; Deucher, Alexander
>     <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>;
>     Li, Dennis <Dennis.Li@amd.com> <mailto:Dennis.Li@amd.com>; Zhang,
>     Hawking <Hawking.Zhang@amd.com> <mailto:Hawking.Zhang@amd.com>
>     Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset
>     support for XGMI
>
>     On 11/27/19 4:15 AM, Le Ma wrote:
>
>     > Currently each XGMI node reset wq does not run in parrallel because
>
>     > same work item bound to same cpu runs in sequence. So change to
>     bound
>
>     > the xgmi_reset_work item to different cpus.
>
>     It's not the same work item, see more bellow
>
>     >
>
>     > XGMI requires all nodes enter into baco within very close proximity
>
>     > before any node exit baco. So schedule the xgmi_reset_work wq twice
>
>     > for enter/exit baco respectively.
>
>     >
>
>     > The default reset code path and methods do not change for vega20
>     production:
>
>     >    - baco reset without xgmi/ras
>
>     >    - psp reset with xgmi/ras
>
>     >
>
>     > To enable baco for XGMI/RAS case, both 2 conditions below are
>     needed:
>
>     >    - amdgpu_ras_enable=2
>
>     >    - baco-supported smu firmware
>
>     >
>
>     > The case that PSP reset and baco reset coexist within an XGMI
>     hive is
>
>     > not in the consideration.
>
>     >
>
>     > Change-Id: I9c08cf90134f940b42e20d2129ff87fba761c532
>
>     > Signed-off-by: Le Ma <le.ma@amd.com <mailto:le.ma@amd.com>>
>
>     > ---
>
>     > drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
>
>     > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 78
>     ++++++++++++++++++++++++++----
>
>     >   2 files changed, 70 insertions(+), 10 deletions(-)
>
>     >
>
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>     > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>     > index d120fe5..08929e6 100644
>
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>     > @@ -998,6 +998,8 @@ struct amdgpu_device {
>
>     > int                                           pstate;
>
>     >          /* enable runtime pm on the device */
>
>     > bool                            runpm;
>
>     > +
>
>     > + bool                                        in_baco;
>
>     >   };
>
>     >
>
>     >   static inline struct amdgpu_device *amdgpu_ttm_adev(struct
>
>     > ttm_bo_device *bdev) diff --git
>
>     > a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
>     > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
>     > index bd387bb..71abfe9 100644
>
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
>     > @@ -2654,7 +2654,13 @@ static void
>     amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>
>     >          struct amdgpu_device *adev =
>
>     > container_of(__work, struct amdgpu_device, xgmi_reset_work);
>
>     >
>
>     > -       adev->asic_reset_res =  amdgpu_asic_reset(adev);
>
>     > +      if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)
>
>     > + adev->asic_reset_res = (adev->in_baco == false) ?
>
>     > +             amdgpu_device_baco_enter(adev->ddev) :
>
>     > +             amdgpu_device_baco_exit(adev->ddev);
>
>     > +      else
>
>     > + adev->asic_reset_res = amdgpu_asic_reset(adev);
>
>     > +
>
>     >          if (adev->asic_reset_res)
>
>     > DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
>
>     >  adev->asic_reset_res, adev->ddev->unique); @@ -3796,6 +3802,7 @@
>
>     > static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>
>     >          struct amdgpu_device *tmp_adev = NULL;
>
>     >          bool need_full_reset = *need_full_reset_arg, vram_lost
>     = false;
>
>     >          int r = 0;
>
>     > +      int cpu = smp_processor_id();
>
>     >
>
>     >          /*
>
>     >           * ASIC reset has to be done on all HGMI hive nodes
>     ASAP @@
>
>     > -3803,21 +3810,24 @@ static int amdgpu_do_asic_reset(struct
>     amdgpu_hive_info *hive,
>
>     >           */
>
>     >          if (need_full_reset) {
>
>     > list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>
>     > - /* For XGMI run all resets in parallel to speed up the process */
>
>     > +                              /*
>
>     > +                              * For XGMI run all resets in
>     parallel to speed up the
>
>     > +                              * process by scheduling the
>     highpri wq on different
>
>     > +                              * cpus. For XGMI with baco reset,
>     all nodes must enter
>
>     > +                              * baco within close proximity
>     before anyone exit.
>
>     > +                              */
>
>     > if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>
>     > -                                           if
>     (!queue_work(system_highpri_wq, &tmp_adev->xgmi_reset_work))
>
>     Note that tmp_adev->xgmi_reset_work (the work item) is per device
>     in XGMI hive and not the same work item. So I don't see why you
>     need to explicitly queue them on different CPUs, they should run
>     in parallel already.
>
>     Andrey
>
>     [Le]: It’s also beyond my understanding that the 2 node reset work
>     items scheduled to same cpu does not run in parallel. But from the
>     experiment result in my side, the 2nd work item always run after
>     1st work item finished. Based on this result, I changed to queue
>     them on different CPUs to make sure more XGMI nodes case to run in
>     parallel, because baco requires all nodes enter baco within very
>     close proximity.
>
>     The experiment code is as following for your reference. When card0
>     worker running, card1 worker is not observed to run.
>
> The code bellow will only test that they don't run concurrently - but 
> this doesn't mean they don't run on different CPUs and threads,I don't 
> have an XGMI setup at hand to test this theory but what if there is 
> some locking dependency between them that serializes their execution ? 
> Can you just add a one line print inside amdgpu_device_xgmi_reset_func 
> that prints CPU id, thread name/id and card number ?
>
> Andrey
>
> [Le]: I checked if directly use queue_work() several times, the same 
> CPU thread will be used. And the worker per CPU will execute the item 
> one by one. Our goal here is to make the xgmi_reset_func run 
> concurrently for XGMI BACO case. That’s why I schedule them on 
> different CPUs to run parallelly. And I can share the XGMI system with 
> you if you’d like to verify more.
>

I tried today to setup XGMI 2P setup to test this but weren't able to 
load with the XGMI bridge in place (maybe faulty bridge) - so yea - 
maybe leave me your setup before your changes (the original code) so i 
can try to open some kernel traces that show CPU id and thread id to 
check this. It's just so weird that system_highpri_wq which is 
documented to be multi-cpu and multi-threaded wouldn't queue those work 
items to different cpus and worker threads.

Andrey


>     +atomic_t card0_in_baco = ATOMIC_INIT(0);
>
>     +atomic_t card1_in_baco = ATOMIC_INIT(0);
>
>     +
>
>     static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>
>     {
>
>     struct amdgpu_device *adev =
>
>     container_of(__work, struct amdgpu_device, xgmi_reset_work);
>
>     + printk("lema1: card 0x%x goes into reset wq\n",
>     adev->pdev->bus->number);
>
>     +       if (adev->pdev->bus->number == 0x7) {
>
>     + atomic_set(&card1_in_baco, 1);
>
>     + printk("lema1: card1 in baco from card1 view\n");
>
>     +       }
>
>     +
>
>             if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)
>
>                    adev->asic_reset_res = (adev->in_baco == false) ?
>
>     amdgpu_device_baco_enter(adev->ddev) :
>
>     @@ -2664,6 +2673,23 @@ static void
>     amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>
>             if (adev->asic_reset_res)
>
>     DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
>
>     adev->asic_reset_res, adev->ddev->unique);
>
>     +
>
>     +       if (adev->pdev->bus->number == 0x4) {
>
>     + atomic_set(&card0_in_baco, 1);
>
>     +        printk("lema1: card0 in baco from card0 view\n");
>
>     +
>
>     + while (true)
>
>     + if (!!atomic_read(&card1_in_baco))
>
>     + break;
>
>     + printk("lema1: card1 in baco from card0 view\n");
>
>     +       }
>
>     +
>
>     +       if (adev->pdev->bus->number == 0x7) {
>
>     + while (true)
>
>     + if (!!atomic_read(&card0_in_baco))
>
>     + break;
>
>     + printk("lema1: card0 in baco from card1 view\n");
>
>     +       }
>
>     > +                                          if
>     (!queue_work_on(cpu, system_highpri_wq,
>
>     > +    &tmp_adev->xgmi_reset_work))
>
>     >                                                        r =
>     -EALREADY;
>
>     > +                                          cpu =
>     cpumask_next(cpu, cpu_online_mask);
>
>     > } else
>
>     >                                            r =
>     amdgpu_asic_reset(tmp_adev);
>
>     > -
>
>     > - if (r) {
>
>     > -                                           DRM_ERROR("ASIC
>     reset failed with error, %d for drm dev, %s",
>
>     > -                                                       r,
>     tmp_adev->ddev->unique);
>
>     > +                              if (r)
>
>     >                                            break;
>
>     > -                               }
>
>     >                      }
>
>     >
>
>     > -                   /* For XGMI wait for all PSP resets to
>     complete before proceed */
>
>     > +                  /* For XGMI wait for all work to complete
>     before proceed */
>
>     >                      if (!r) {
>
>     > list_for_each_entry(tmp_adev, device_list_handle,
>
>     >     gmc.xgmi.head) {
>
>     > @@ -3826,11 +3836,59 @@ static int amdgpu_do_asic_reset(struct
>     amdgpu_hive_info *hive,
>
>     >                                                        r =
>     tmp_adev->asic_reset_res;
>
>     >                                                        if (r)
>
>     > break;
>
>     > + if(AMD_RESET_METHOD_BACO ==
>
>     > + amdgpu_asic_reset_method(tmp_adev))
>
>     > + tmp_adev->in_baco = true;
>
>     >                                            }
>
>     > }
>
>     >                      }
>
>     > -       }
>
>     >
>
>     > +                  /*
>
>     > +                  * For XGMI with baco reset, need exit baco
>     phase by scheduling
>
>     > +                  * xgmi_reset_work one more time. PSP reset
>     skips this phase.
>
>     > +                  * Not assume the situation that PSP reset and
>     baco reset
>
>     > +                  * coexist within an XGMI hive.
>
>     > +                  */
>
>     > +
>
>     > +                  if (!r) {
>
>     > + cpu = smp_processor_id();
>
>     > + list_for_each_entry(tmp_adev, device_list_handle,
>
>     > + gmc.xgmi.head) {
>
>     > +                                          if
>     (tmp_adev->gmc.xgmi.num_physical_nodes > 1
>
>     > +                                              &&
>     AMD_RESET_METHOD_BACO ==
>
>     > + amdgpu_asic_reset_method(tmp_adev)) {
>
>     > +                                                      if
>     (!queue_work_on(cpu,
>
>     > + system_highpri_wq,
>
>     > +             &tmp_adev->xgmi_reset_work))
>
>     > + r = -EALREADY;
>
>     > +                                                      if (r)
>
>     > + break;
>
>     > +                                                      cpu =
>     cpumask_next(cpu, cpu_online_mask);
>
>     > +                                          }
>
>     > +                              }
>
>     > +                  }
>
>     > +
>
>     > +                  if (!r) {
>
>     > + list_for_each_entry(tmp_adev, device_list_handle,
>
>     > + gmc.xgmi.head) {
>
>     > +                                          if
>     (tmp_adev->gmc.xgmi.num_physical_nodes > 1
>
>     > +                                              &&
>     AMD_RESET_METHOD_BACO ==
>
>     > + amdgpu_asic_reset_method(tmp_adev)) {
>
>     > + flush_work(&tmp_adev->xgmi_reset_work);
>
>     > +                                                      r =
>     tmp_adev->asic_reset_res;
>
>     > +                                                      if (r)
>
>     > + break;
>
>     > + tmp_adev->in_baco = false;
>
>     > +                                          }
>
>     > +                              }
>
>     > +                  }
>
>     > +
>
>     > +                  if (r) {
>
>     > + DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
>
>     > +                                          r,
>     tmp_adev->ddev->unique);
>
>     > + goto end;
>
>     > +                  }
>
>     > +      }
>
>     >
>
>     > list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>
>     >                      if (need_full_reset) {
>

--------------D51E830D76F5BB6B9A582DE0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/2/19 6:42 AM, Ma, Le wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
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
	font-family:"Calibri",sans-serif;
	color:black;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
        <p class="msipheadera92e061b" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span style="color:windowtext"> Grodzovsky, Andrey
                <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                <br>
                <b>Sent:</b> Saturday, November 30, 2019 12:22 AM<br>
                <b>To:</b> Ma, Le <a class="moz-txt-link-rfc2396E" href="mailto:Le.Ma@amd.com">&lt;Le.Ma@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <b>Cc:</b> Chen, Guchun <a class="moz-txt-link-rfc2396E" href="mailto:Guchun.Chen@amd.com">&lt;Guchun.Chen@amd.com&gt;</a>;
                Zhou1, Tao <a class="moz-txt-link-rfc2396E" href="mailto:Tao.Zhou1@amd.com">&lt;Tao.Zhou1@amd.com&gt;</a>; Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis
                <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>; Zhang, Hawking
                <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                <b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add
                concurrent baco reset support for XGMI<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p><o:p>&nbsp;</o:p></p>
        <div>
          <p class="MsoNormal">On 11/28/19 4:00 AM, Ma, Le wrote:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">-----Original Message-----<br>
            From: Grodzovsky, Andrey <a href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
            <br>
            Sent: Wednesday, November 27, 2019 11:46 PM<br>
            To: Ma, Le <a href="mailto:Le.Ma@amd.com" moz-do-not-send="true">&lt;Le.Ma@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
              amd-gfx@lists.freedesktop.org</a><br>
            Cc: Chen, Guchun <a href="mailto:Guchun.Chen@amd.com" moz-do-not-send="true">&lt;Guchun.Chen@amd.com&gt;</a>;
            Zhou1, Tao
            <a href="mailto:Tao.Zhou1@amd.com" moz-do-not-send="true">&lt;Tao.Zhou1@amd.com&gt;</a>;
            Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
              &lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis <a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a>;
            Zhang, Hawking
            <a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
            Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco
            reset support for XGMI<o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">On 11/27/19 4:15 AM, Le Ma wrote:<o:p></o:p></p>
          <p class="MsoPlainText">&gt; Currently each XGMI node reset wq
            does not run in parrallel because
            <o:p></o:p></p>
          <p class="MsoPlainText">&gt; same work item bound to same cpu
            runs in sequence. So change to bound
            <o:p></o:p></p>
          <p class="MsoPlainText">&gt; the xgmi_reset_work item to
            different cpus.<o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">It's not the same work item, see more
            bellow<o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">&gt; XGMI requires all nodes enter
            into baco within very close proximity
            <o:p></o:p></p>
          <p class="MsoPlainText">&gt; before any node exit baco. So
            schedule the xgmi_reset_work wq twice
            <o:p></o:p></p>
          <p class="MsoPlainText">&gt; for enter/exit baco respectively.<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">&gt; The default reset code path and
            methods do not change for vega20 production:<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - baco reset without xgmi/ras<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - psp reset with xgmi/ras<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">&gt; To enable baco for XGMI/RAS case,
            both 2 conditions below are needed:<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - amdgpu_ras_enable=2<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - baco-supported smu firmware<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">&gt; The case that PSP reset and baco
            reset coexist within an XGMI hive is
            <o:p></o:p></p>
          <p class="MsoPlainText">&gt; not in the consideration.<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
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
          <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
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
          <p class="MsoPlainText">&gt; @@ -2654,7 &#43;2654,13 @@ static
            void amdgpu_device_xgmi_reset_func(struct work_struct
            *__work)<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device
            *adev =<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            container_of(__work, struct amdgpu_device, xgmi_reset_work);<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
          <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_reset_res
            =&nbsp; amdgpu_asic_reset(adev);<o:p></o:p></p>
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
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            DRM_WARN(&quot;ASIC reset failed with error, %d for drm dev, %s&quot;,<o:p></o:p></p>
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
          <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            /* For XGMI run all resets in parallel to speed up the
            process */<o:p></o:p></p>
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
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (tmp_adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) {<o:p></o:p></p>
          <p class="MsoPlainText">&gt;
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (!queue_work(system_highpri_wq,
            &amp;tmp_adev-&gt;xgmi_reset_work))<o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">Note that tmp_adev-&gt;xgmi_reset_work
            (the work item) is per device in XGMI hive and not the same
            work item. So I don't see why you need to explicitly queue
            them on different CPUs, they should run in parallel already.<o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText">Andrey<o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">[Le]: It’s
              also beyond my understanding that the 2 node reset work
              items scheduled to same cpu does not run in parallel. But
              from the experiment result in my side, the 2nd work item
              always run after 1st work item finished. Based on this
              result, I changed to queue them on different CPUs to make
              sure more XGMI nodes case to run in parallel, because baco
              requires all nodes enter baco within very close proximity.
            </span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">The
              experiment code is as following for your reference. When
              card0 worker running, card1 worker is not observed to run.</span><o:p></o:p></p>
        </blockquote>
        <p><o:p>&nbsp;</o:p></p>
        <p>The code bellow will only test that they don't run
          concurrently - but this doesn't mean they don't run on
          different CPUs and threads,I don't have an XGMI setup at hand
          to test this theory but what if there is some locking
          dependency between them that serializes their execution ? Can
          you just add a one line print inside <span style="color:#203864">
            amdgpu_device_xgmi_reset_func </span>that prints CPU id,
          thread name/id and card number ?<o:p></o:p></p>
        <p>Andrey<o:p></o:p></p>
        <p><span style="color:#203864">[Le]: I checked if directly use
            queue_work() several times, the same CPU thread will be
            used. And the worker per CPU will execute the item one by
            one. Our goal here is to make the xgmi_reset_func run
            concurrently for XGMI BACO case. That’s why I schedule them
            on different CPUs to run parallelly. And I can share the
            XGMI system with you if you’d like to verify more.</span></p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I tried today to setup XGMI 2P setup to test this but weren't
      able to load with the XGMI bridge in place (maybe faulty bridge) -
      so yea - maybe leave me your setup before your changes (the
      original code) so i can try to open some kernel traces that show
      CPU id and thread id to check this. It's just so weird that
      system_highpri_wq which is documented to be multi-cpu and
      multi-threaded wouldn't queue those work items to different cpus
      and worker threads.<br>
    </p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p><span style="color:#203864"><o:p></o:p></span></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;atomic_t
              card0_in_baco = ATOMIC_INIT(0);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;atomic_t
              card1_in_baco = ATOMIC_INIT(0);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">static
              void amdgpu_device_xgmi_reset_func(struct work_struct
              *__work)</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">{</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              struct amdgpu_device *adev =</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              container_of(__work, struct amdgpu_device,
              xgmi_reset_work);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              printk(&quot;lema1: card 0x%x goes into reset wq\n&quot;,
              adev-&gt;pdev-&gt;bus-&gt;number);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
              (adev-&gt;pdev-&gt;bus-&gt;number == 0x7) {</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              atomic_set(&amp;card1_in_baco, 1);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              printk(&quot;lema1: card1 in baco from card1 view\n&quot;);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
              (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;adev-&gt;asic_reset_res
              = (adev-&gt;in_baco == false) ?</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              amdgpu_device_baco_enter(adev-&gt;ddev) :</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">@@ -2664,6
              &#43;2673,23 @@ static void
              amdgpu_device_xgmi_reset_func(struct work_struct *__work)</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
              (adev-&gt;asic_reset_res)</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              DRM_WARN(&quot;ASIC reset failed with error, %d for drm dev,
              %s&quot;,</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              adev-&gt;asic_reset_res, adev-&gt;ddev-&gt;unique);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
              (adev-&gt;pdev-&gt;bus-&gt;number == 0x4) {</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              atomic_set(&amp;card0_in_baco, 1);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printk(&quot;lema1: card0 in baco from card0 view\n&quot;);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              while (true)</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              if (!!atomic_read(&amp;card1_in_baco))</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              break;</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              printk(&quot;lema1: card1 in baco from card0 view\n&quot;);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;}</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
              (adev-&gt;pdev-&gt;bus-&gt;number == 0x7) {</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              while (true)</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              if (!!atomic_read(&amp;card0_in_baco))</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              break;</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              printk(&quot;lema1: card0 in baco from card1 view\n&quot;);</span><o:p></o:p></p>
          <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
          <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
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
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            } else<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            amdgpu_asic_reset(tmp_adev);<o:p></o:p></p>
          <p class="MsoPlainText">&gt; -<o:p></o:p></p>
          <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (r) {<o:p></o:p></p>
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
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI
            wait for all work to complete before proceed */<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            list_for_each_entry(tmp_adev, device_list_handle,<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;gmc.xgmi.head) {<o:p></o:p></p>
          <p class="MsoPlainText">&gt; @@ -3826,11 &#43;3836,59 @@ static
            int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            tmp_adev-&gt;asic_reset_res;<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (r)<o:p></o:p></p>
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
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            }<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
          <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For XGMI
            with baco reset, need exit baco phase by scheduling<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
            xgmi_reset_work one more time. PSP reset skips this phase.<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Not assume
            the situation that PSP reset and baco reset<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * coexist
            within an XGMI hive.<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            cpu = smp_processor_id();<o:p></o:p></p>
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
            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (r)<o:p></o:p></p>
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
            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (r)<o:p></o:p></p>
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
            DRM_ERROR(&quot;ASIC reset failed with error, %d for drm dev,
            %s&quot;,<o:p></o:p></p>
          <p class="MsoPlainText">&gt;
            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r,
            tmp_adev-&gt;ddev-&gt;unique);<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            goto end;<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
          <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            list_for_each_entry(tmp_adev, device_list_handle,
            gmc.xgmi.head) {<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (need_full_reset) {<o:p></o:p></p>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------D51E830D76F5BB6B9A582DE0--

--===============1999610180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1999610180==--

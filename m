Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908BBC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 11:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2C82084F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 11:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2C82084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246436E1B2;
	Mon,  2 Dec 2019 11:42:19 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720057.outbound.protection.outlook.com [40.107.72.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 612976E1B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 11:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgogRKxOTZ3Up6U9V0vTQ+z78eSrEtQTTeNnts/fy/5EbA0ax9rihVAw0Zn4dlEJ/iHNYxnm7WkvtsUbg4s2fK4TL4Y/2U1U11z+65zsrfirxdGV8YM6x5kxv7xm4poYJjYjf/Az1P4RjxY3jxxC8eZg+2iZM5MIrDxKin2kSAqPj4VRWmxvjgl8K1Om6M+5Zf6tF4uC0lm3kMo5+aWiqGxWC8VXgxV1u3OlHH+pGk5kvfyopHyUwRtEVIaMu+8aipeEArvaflU1FUWShtJop1cJX6WQ0p9Os46umycvof83RxUMrk9gjxnETpQ1cujKcP559t9b8PEtnKU5xqK/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/ov3WTGdXWlC1ur+omMhPT5AcCmkQXFwdBhvilhHSc=;
 b=bwZCtN1eeWopcKeUDdGCiHs5BB7SFZPAgnuQkHqy5YlBmw4J9VqrGOaMYv/mlgjBvzHoeVWIZFWqxo4vASWWcjJ2ra42dE/fZu9mcNawhZtJ3XaUl0FgA4hZHj9F4aKLC4QMHdY/rIyc3lXeVx6kiP9DJIi9UhZTxQ4sQ2QLDkwuPXJi2tUeS98EKfQFBeu53yDbLdrK1/OOkF2oBP3bhXfiGQuhcArQYfQ4zYC2Jr/bmYLZWuXFn+xebKPPpVexz59Ss4qI9Cv3IfzjH3+oGd1WERDKUnmZ69RhS5OQ4ne8ZDJjWgNy6svtX5Hd4ESjZ8JXAgfUuC2OKPZb9hVPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB3101.namprd12.prod.outlook.com (20.178.241.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 11:42:15 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 11:42:14 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
Thread-Topic: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
Thread-Index: AQHVpQNJI33CWgVjAUaqRB+BX0VW26efKZkAgAETysCAAhrWgIAEZr3Q
Date: Mon, 2 Dec 2019 11:42:14 +0000
Message-ID: <MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-6-git-send-email-le.ma@amd.com>
 <c09d7928-f864-3a80-40e2-b6116abe044c@amd.com>
 <MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com>
 <157d7671-803c-4f6e-f77c-9738f32905e3@amd.com>
In-Reply-To: <157d7671-803c-4f6e-f77c-9738f32905e3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-02T11:42:11Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=419a8b64-f803-4a78-b638-0000dca82c6a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-02T11:42:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: df185d4f-5ca6-4e8a-981a-0000d1e2ca29
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79f07a5c-46cd-4ff8-d3e0-08d7771cad79
x-ms-traffictypediagnostic: MN2PR12MB3101:|MN2PR12MB3101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3101951F28D98CD6F5B476FEF6430@MN2PR12MB3101.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(13464003)(199004)(189003)(6306002)(11346002)(7696005)(790700001)(3846002)(6116002)(229853002)(446003)(2501003)(4326008)(102836004)(25786009)(14454004)(71190400001)(71200400001)(53546011)(6506007)(33656002)(26005)(8936002)(478600001)(99286004)(7736002)(55016002)(74316002)(236005)(5660300002)(186003)(66946007)(76116006)(66446008)(66556008)(66476007)(52536014)(81166006)(81156014)(316002)(64756008)(256004)(14444005)(86362001)(6436002)(8676002)(2906002)(54906003)(66066001)(110136005)(54896002)(76176011)(9686003)(6246003)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3101;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YLt7076LQX7dc+f8zHfjZSbPOXC47AdzwEUZLLGOGY11fyoCGruFZ/N93uAj3kIyIuc1MGUaoiOzytXcd9B+05b907kllLG3MYtPVFHvKJ/Wcmx4yGCwPX+jUqI/METQnYPboRPAy/7svjTln9YpxwFSKcvA6GI1zR/d6LQi1WQnP52NuQhWHcdKpUV3oAW25BlxjK04IuQlfswZsHhsyT8z5jBNClz/vzfveZ7MOdb5oGnqp8uxgI9rE7q7QbSkGvMufemrufz1aARsBJcQT3JRl7VGC7vcqixF4F2klY3U7kKmN7feh1izU2gYCJirOONpnO5ULKYGuYzvS4obqWdR1HpEpqG52eGAvKJj3Wid8fBMAA/PMyjfxFdkOUNmgEPY3wQ6l3Nuw356RNaLOfd14H9Zit/UH+qNdArUtaG+8mvGm6VaEH2kPnTBhUmM
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f07a5c-46cd-4ff8-d3e0-08d7771cad79
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 11:42:14.7863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sh/gWHT8ZUt2rH7ZRMRRS11cjDWCKved1twrLOI5DaUkrHk+MX3TUcrO6tQIqoY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3101
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/ov3WTGdXWlC1ur+omMhPT5AcCmkQXFwdBhvilhHSc=;
 b=PdQOsbew5bsJMGwf59izaHeFe4WqaG+cZ88kL4zNABJzLcFI2xXSLt87nIg5oCosbKwEyULAQSpkFLTVwUI7BnSct61vr2QJnB3z5KAPGOaEvB5GUCHZz07vcV0fXlcDkeV494yqzZhV+eOdhZsPR9VqLx5c42wMcqcL0VV29zc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Le.Ma@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============1929888832=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1929888832==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB428532FA663C99770AA71263F6430MN2PR12MB4285namp_"

--_000_MN2PR12MB428532FA663C99770AA71263F6430MN2PR12MB4285namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Sent: Saturday, November 30, 2019 12:22 AM
To: Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Deu=
cher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>=
; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support fo=
r XGMI



On 11/28/19 4:00 AM, Ma, Le wrote:





-----Original Message-----
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com><mailto:Andrey.Grodzovs=
ky@amd.com>
Sent: Wednesday, November 27, 2019 11:46 PM
To: Ma, Le <Le.Ma@amd.com><mailto:Le.Ma@amd.com>; amd-gfx@lists.freedesktop=
.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Chen, Guchun <Guchun.Chen@amd.com><mailto:Guchun.Chen@amd.com>; Zhou1, =
Tao <Tao.Zhou1@amd.com><mailto:Tao.Zhou1@amd.com>; Deucher, Alexander <Alex=
ander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>; Li, Dennis <Denni=
s.Li@amd.com><mailto:Dennis.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.=
com><mailto:Hawking.Zhang@amd.com>
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support fo=
r XGMI





On 11/27/19 4:15 AM, Le Ma wrote:

> Currently each XGMI node reset wq does not run in parrallel because

> same work item bound to same cpu runs in sequence. So change to bound

> the xgmi_reset_work item to different cpus.



It's not the same work item, see more bellow





>

> XGMI requires all nodes enter into baco within very close proximity

> before any node exit baco. So schedule the xgmi_reset_work wq twice

> for enter/exit baco respectively.

>

> The default reset code path and methods do not change for vega20 producti=
on:

>    - baco reset without xgmi/ras

>    - psp reset with xgmi/ras

>

> To enable baco for XGMI/RAS case, both 2 conditions below are needed:

>    - amdgpu_ras_enable=3D2

>    - baco-supported smu firmware

>

> The case that PSP reset and baco reset coexist within an XGMI hive is

> not in the consideration.

>

> Change-Id: I9c08cf90134f940b42e20d2129ff87fba761c532

> Signed-off-by: Le Ma <le.ma@amd.com<mailto:le.ma@amd.com>>

> ---

>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +

>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 78 +++++++++++++++++++++++=
+++----

>   2 files changed, 70 insertions(+), 10 deletions(-)

>

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h

> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h

> index d120fe5..08929e6 100644

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h

> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h

> @@ -998,6 +998,8 @@ struct amdgpu_device {

>          int                                           pstate;

>          /* enable runtime pm on the device */

>          bool                            runpm;

> +

> +      bool                                        in_baco;

>   };

>

>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct

> ttm_bo_device *bdev) diff --git

> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

> index bd387bb..71abfe9 100644

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

> @@ -2654,7 +2654,13 @@ static void amdgpu_device_xgmi_reset_func(struct w=
ork_struct *__work)

>          struct amdgpu_device *adev =3D

>                      container_of(__work, struct amdgpu_device, xgmi_rese=
t_work);

>

> -       adev->asic_reset_res =3D  amdgpu_asic_reset(adev);

> +      if (amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_BACO)

> +                  adev->asic_reset_res =3D (adev->in_baco =3D=3D false) =
?

> +                                          amdgpu_device_baco_enter(adev-=
>ddev) :

> +                                          amdgpu_device_baco_exit(adev->=
ddev);

> +      else

> +                  adev->asic_reset_res =3D amdgpu_asic_reset(adev);

> +

>          if (adev->asic_reset_res)

>                      DRM_WARN("ASIC reset failed with error, %d for drm d=
ev, %s",

>                                   adev->asic_reset_res, adev->ddev->uniqu=
e); @@ -3796,6 +3802,7 @@

> static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,

>          struct amdgpu_device *tmp_adev =3D NULL;

>          bool need_full_reset =3D *need_full_reset_arg, vram_lost =3D fal=
se;

>          int r =3D 0;

> +      int cpu =3D smp_processor_id();

>

>          /*

>           * ASIC reset has to be done on all HGMI hive nodes ASAP @@

> -3803,21 +3810,24 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_i=
nfo *hive,

>           */

>          if (need_full_reset) {

>                      list_for_each_entry(tmp_adev, device_list_handle, gm=
c.xgmi.head) {

> -                               /* For XGMI run all resets in parallel to=
 speed up the process */

> +                              /*

> +                              * For XGMI run all resets in parallel to s=
peed up the

> +                              * process by scheduling the highpri wq on =
different

> +                              * cpus. For XGMI with baco reset, all node=
s must enter

> +                              * baco within close proximity before anyon=
e exit.

> +                              */

>                                  if (tmp_adev->gmc.xgmi.num_physical_node=
s > 1) {

> -                                           if (!queue_work(system_highpr=
i_wq, &tmp_adev->xgmi_reset_work))





Note that tmp_adev->xgmi_reset_work (the work item) is per device in XGMI h=
ive and not the same work item. So I don't see why you need to explicitly q=
ueue them on different CPUs, they should run in parallel already.



Andrey



[Le]: It's also beyond my understanding that the 2 node reset work items sc=
heduled to same cpu does not run in parallel. But from the experiment resul=
t in my side, the 2nd work item always run after 1st work item finished. Ba=
sed on this result, I changed to queue them on different CPUs to make sure =
more XGMI nodes case to run in parallel, because baco requires all nodes en=
ter baco within very close proximity.



The experiment code is as following for your reference. When card0 worker r=
unning, card1 worker is not observed to run.



The code bellow will only test that they don't run concurrently - but this =
doesn't mean they don't run on different CPUs and threads,I don't have an X=
GMI setup at hand to test this theory but what if there is some locking dep=
endency between them that serializes their execution ? Can you just add a o=
ne line print inside amdgpu_device_xgmi_reset_func that prints CPU id, thre=
ad name/id and card number ?

Andrey

[Le]: I checked if directly use queue_work() several times, the same CPU th=
read will be used. And the worker per CPU will execute the item one by one.=
 Our goal here is to make the xgmi_reset_func run concurrently for XGMI BAC=
O case. That's why I schedule them on different CPUs to run parallelly. And=
 I can share the XGMI system with you if you'd like to verify more.



+atomic_t card0_in_baco =3D ATOMIC_INIT(0);

+atomic_t card1_in_baco =3D ATOMIC_INIT(0);

+

static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)

{

        struct amdgpu_device *adev =3D

                container_of(__work, struct amdgpu_device, xgmi_reset_work)=
;



+       printk("lema1: card 0x%x goes into reset wq\n", adev->pdev->bus->nu=
mber);

+       if (adev->pdev->bus->number =3D=3D 0x7) {

+               atomic_set(&card1_in_baco, 1);

+               printk("lema1: card1 in baco from card1 view\n");

+       }

+

        if (amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_BACO)

               adev->asic_reset_res =3D (adev->in_baco =3D=3D false) ?

                                amdgpu_device_baco_enter(adev->ddev) :

@@ -2664,6 +2673,23 @@ static void amdgpu_device_xgmi_reset_func(struct wor=
k_struct *__work)

        if (adev->asic_reset_res)

                DRM_WARN("ASIC reset failed with error, %d for drm dev, %s"=
,

                         adev->asic_reset_res, adev->ddev->unique);

+

+       if (adev->pdev->bus->number =3D=3D 0x4) {

+               atomic_set(&card0_in_baco, 1);

+               printk("lema1: card0 in baco from card0 view\n");

+

+               while (true)

+                       if (!!atomic_read(&card1_in_baco))

+                               break;

+               printk("lema1: card1 in baco from card0 view\n");

+       }

+

+       if (adev->pdev->bus->number =3D=3D 0x7) {

+               while (true)

+                       if (!!atomic_read(&card0_in_baco))

+                               break;

+               printk("lema1: card0 in baco from card1 view\n");

+       }



> +                                          if (!queue_work_on(cpu, system=
_highpri_wq,

> +                                                                     &tm=
p_adev->xgmi_reset_work))

>                                                          r =3D -EALREADY;

> +                                          cpu =3D cpumask_next(cpu, cpu_=
online_mask);

>                                  } else

>                                              r =3D amdgpu_asic_reset(tmp_=
adev);

> -

> -                               if (r) {

> -                                           DRM_ERROR("ASIC reset failed =
with error, %d for drm dev, %s",

> -                                                       r, tmp_adev->ddev=
->unique);

> +                              if (r)

>                                              break;

> -                               }

>                      }

>

> -                   /* For XGMI wait for all PSP resets to complete befor=
e proceed */

> +                  /* For XGMI wait for all work to complete before proce=
ed */

>                      if (!r) {

>                                  list_for_each_entry(tmp_adev, device_lis=
t_handle,

>                                                              gmc.xgmi.hea=
d) {

> @@ -3826,11 +3836,59 @@ static int amdgpu_do_asic_reset(struct amdgpu_hiv=
e_info *hive,

>                                                          r =3D tmp_adev->=
asic_reset_res;

>                                                          if (r)

>                                                                      brea=
k;

> +                                                      if(AMD_RESET_METHO=
D_BACO =3D=3D

> +                                                         amdgpu_asic_res=
et_method(tmp_adev))

> +                                                                  tmp_ad=
ev->in_baco =3D true;

>                                              }

>                                  }

>                      }

> -       }

>

> +                  /*

> +                  * For XGMI with baco reset, need exit baco phase by sc=
heduling

> +                  * xgmi_reset_work one more time. PSP reset skips this =
phase.

> +                  * Not assume the situation that PSP reset and baco res=
et

> +                  * coexist within an XGMI hive.

> +                  */

> +

> +                  if (!r) {

> +                              cpu =3D smp_processor_id();

> +                              list_for_each_entry(tmp_adev, device_list_=
handle,

> +                                                          gmc.xgmi.head)=
 {

> +                                          if (tmp_adev->gmc.xgmi.num_phy=
sical_nodes > 1

> +                                              && AMD_RESET_METHOD_BACO =
=3D=3D

> +                                              amdgpu_asic_reset_method(t=
mp_adev)) {

> +                                                      if (!queue_work_on=
(cpu,

> +                                                                  system=
_highpri_wq,

> +                                                                  &tmp_a=
dev->xgmi_reset_work))

> +                                                                  r =3D =
-EALREADY;

> +                                                      if (r)

> +                                                                  break;

> +                                                      cpu =3D cpumask_ne=
xt(cpu, cpu_online_mask);

> +                                          }

> +                              }

> +                  }

> +

> +                  if (!r) {

> +                              list_for_each_entry(tmp_adev, device_list_=
handle,

> +                                                          gmc.xgmi.head)=
 {

> +                                          if (tmp_adev->gmc.xgmi.num_phy=
sical_nodes > 1

> +                                              && AMD_RESET_METHOD_BACO =
=3D=3D

> +                                              amdgpu_asic_reset_method(t=
mp_adev)) {

> +                                                      flush_work(&tmp_ad=
ev->xgmi_reset_work);

> +                                                      r =3D tmp_adev->as=
ic_reset_res;

> +                                                      if (r)

> +                                                                  break;

> +                                                      tmp_adev->in_baco =
=3D false;

> +                                          }

> +                              }

> +                  }

> +

> +                  if (r) {

> +                              DRM_ERROR("ASIC reset failed with error, %=
d for drm dev, %s",

> +                                          r, tmp_adev->ddev->unique);

> +                              goto end;

> +                  }

> +      }

>

>          list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head)=
 {

>                      if (need_full_reset) {

--_000_MN2PR12MB428532FA663C99770AA71263F6430MN2PR12MB4285namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
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
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:windowtext"><o=
:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@=
amd.com&gt;
<br>
<b>Sent:</b> Saturday, November 30, 2019 12:22 AM<br>
<b>To:</b> Ma, Le &lt;Le.Ma@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Zhou1, Tao &lt;Tao.Zho=
u1@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Li, D=
ennis &lt;Dennis.Li@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&g=
t;<br>
<b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset sup=
port for XGMI<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">On 11/28/19 4:00 AM, Ma, Le wrote:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Grodzovsky, Andrey <a href=3D"mailto:Andrey.Grodzovsky@amd.com">&lt;A=
ndrey.Grodzovsky@amd.com&gt;</a>
<br>
Sent: Wednesday, November 27, 2019 11:46 PM<br>
To: Ma, Le <a href=3D"mailto:Le.Ma@amd.com">&lt;Le.Ma@amd.com&gt;</a>; <a h=
ref=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
Cc: Chen, Guchun <a href=3D"mailto:Guchun.Chen@amd.com">&lt;Guchun.Chen@amd=
.com&gt;</a>; Zhou1, Tao
<a href=3D"mailto:Tao.Zhou1@amd.com">&lt;Tao.Zhou1@amd.com&gt;</a>; Deucher=
, Alexander <a href=3D"mailto:Alexander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis <a href=3D"mailto:Dennis.=
Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>; Zhang, Hawking
<a href=3D"mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><=
br>
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support fo=
r XGMI<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">On 11/27/19 4:15 AM, Le Ma wrote:<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Currently each XGMI node reset wq does not r=
un in parrallel because
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; same work item bound to same cpu runs in seq=
uence. So change to bound
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; the xgmi_reset_work item to different cpus.<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">It's not the same work item, see more bellow<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; XGMI requires all nodes enter into baco with=
in very close proximity
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; before any node exit baco. So schedule the x=
gmi_reset_work wq twice
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; for enter/exit baco respectively.<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; The default reset code path and methods do n=
ot change for vega20 production:<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - baco reset without xgmi/=
ras<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - psp reset with xgmi/ras<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; To enable baco for XGMI/RAS case, both 2 con=
ditions below are needed:<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - amdgpu_ras_enable=3D2<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - baco-supported smu firmw=
are<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; The case that PSP reset and baco reset coexi=
st within an XGMI hive is
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; not in the consideration.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Change-Id: I9c08cf90134f940b42e20d2129ff87fb=
a761c532<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Signed-off-by: Le Ma &lt;<a href=3D"mailto:l=
e.ma@amd.com"><span style=3D"color:windowtext;text-decoration:none">le.ma@a=
md.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; ---<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgp=
u.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgp=
u_device.c | 78 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; 2 files changed, 70 insertions(&=
#43;), 10 deletions(-)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdg=
pu.h <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&gt; index d120fe5..08929e6 100644<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu=
/amdgpu.h<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -998,6 &#43;998,8 @@ struct amdgpu_device=
 {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* enable runtime pm on the device */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; runpm;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; in_baco;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; };<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; static inline struct amdgpu_devi=
ce *amdgpu_ttm_adev(struct
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; ttm_bo_device *bdev) diff --git <o:p></o:p><=
/p>
<p class=3D"MsoPlainText">&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=
 <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; index bd387bb..71abfe9 100644<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_devi=
ce.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu=
/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -2654,7 &#43;2654,13 @@ static void amdgp=
u_device_xgmi_reset_func(struct work_struct *__work)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_device *adev =3D<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; container_of(__work, struct amdgpu_device, xgmi_reset_work);<o:p></o:p></=
p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&=
gt;asic_reset_res =3D&nbsp; amdgpu_asic_reset(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdg=
pu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_BACO)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;as=
ic_reset_res =3D (adev-&gt;in_baco =3D=3D false) ?<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_baco_ent=
er(adev-&gt;ddev) :<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_baco_exi=
t(adev-&gt;ddev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;as=
ic_reset_res =3D amdgpu_asic_reset(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (adev-&gt;asic_reset_res)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; DRM_WARN(&quot;ASIC reset failed with error, %d for drm dev, %s&quot;,<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;adev-&gt;asic_reset_res, adev-&gt;ddev-&gt;unique); @@ -3796,6 &#43;38=
02,7 @@
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; static int amdgpu_do_asic_reset(struct amdgp=
u_hive_info *hive,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_device *tmp_adev =3D NULL;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool need_full_reset =3D *need_full_reset_arg, vram_lost =3D false;<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; int r =3D 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cpu =
=3D smp_processor_id();<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /*<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;* ASIC reset has to be done on all HGMI hive nodes ASAP @@
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -3803,21 &#43;3810,24 @@ static int amdgpu_d=
o_asic_reset(struct amdgpu_hive_info *hive,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;*/<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (need_full_reset) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI =
run all resets in parallel to speed up the process */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For XGMI run=
 all resets in parallel to speed up the<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * process by s=
cheduling the highpri wq on different<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * cpus. For XG=
MI with baco reset, all nodes must enter<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * baco within =
close proximity before anyone exit.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (tmp_adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!queue_work=
(system_highpri_wq, &amp;tmp_adev-&gt;xgmi_reset_work))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">Note that tmp_adev-&gt;xgmi_reset_work (the work =
item) is per device in XGMI hive and not the same work item. So I don't see=
 why you need to explicitly queue them on different CPUs, they should run i=
n parallel already.<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">Andrey<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">[Le]: It&#8217;s al=
so beyond my understanding that the 2 node reset work items scheduled to sa=
me cpu does not run in parallel. But from the experiment result in my side,=
 the 2nd work item always run after 1st work
 item finished. Based on this result, I changed to queue them on different =
CPUs to make sure more XGMI nodes case to run in parallel, because baco req=
uires all nodes enter baco within very close proximity.
</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">The experiment code=
 is as following for your reference. When card0 worker running, card1 worke=
r is not observed to run.</span><o:p></o:p></p>
</blockquote>
<p><o:p>&nbsp;</o:p></p>
<p>The code bellow will only test that they don't run concurrently - but th=
is doesn't mean they don't run on different CPUs and threads,I don't have a=
n XGMI setup at hand to test this theory but what if there is some locking =
dependency between them that serializes
 their execution ? Can you just add a one line print inside <span style=3D"=
color:#203864">
amdgpu_device_xgmi_reset_func </span>that prints CPU id, thread name/id and=
 card number ?<o:p></o:p></p>
<p>Andrey<o:p></o:p></p>
<p><span style=3D"color:#203864">[Le]: I checked if directly use queue_work=
() several times, the same CPU thread will be used. And the worker per CPU =
will execute the item one by one. Our goal here is to make the xgmi_reset_f=
unc run concurrently for XGMI BACO
 case. That&#8217;s why I schedule them on different CPUs to run parallelly=
. And I can share the XGMI system with you if you&#8217;d like to verify mo=
re.<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;atomic_t card0=
_in_baco =3D ATOMIC_INIT(0);</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;atomic_t card1=
_in_baco =3D ATOMIC_INIT(0);</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;</span><o:p></=
o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">static void amdgpu_=
device_xgmi_reset_func(struct work_struct *__work)</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">{</span><o:p></o:p>=
</p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D</span><o:p></o:p></p=
>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con=
tainer_of(__work, struct amdgpu_device, xgmi_reset_work);</span><o:p></o:p>=
</p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; printk(&quot;lema1: card 0x%x goes into reset wq\n&q=
uot;, adev-&gt;pdev-&gt;bus-&gt;number);</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pdev-&gt;bus-&gt;number =3D=3D 0x7) {</=
span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atom=
ic_set(&amp;card1_in_baco, 1);</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prin=
tk(&quot;lema1: card1 in baco from card1 view\n&quot;);</span><o:p></o:p></=
p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;</span><o:p></=
o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET=
_METHOD_BACO)</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;adev=
-&gt;asic_reset_res =3D (adev-&gt;in_baco =3D=3D false) ?</span><o:p></o:p>=
</p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_device_baco_enter(adev-&gt;ddev) :</span><o:p></o:=
p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">@@ -2664,6 &#43;267=
3,23 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__wor=
k)</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_reset_res)</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM=
_WARN(&quot;ASIC reset failed with error, %d for drm dev, %s&quot;,</span><=
o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_reset_res,=
 adev-&gt;ddev-&gt;unique);</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;</span><o:p></=
o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pdev-&gt;bus-&gt;number =3D=3D 0x4) {</=
span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atom=
ic_set(&amp;card0_in_baco, 1);</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;prin=
tk(&quot;lema1: card0 in baco from card0 view\n&quot;);</span><o:p></o:p></=
p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;</span><o:p></=
o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; whil=
e (true)</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!!atomic_read(&amp;card1_in=
_baco))</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prin=
tk(&quot;lema1: card1 in baco from card0 view\n&quot;);</span><o:p></o:p></=
p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp;&nbsp;}</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;</span><o:p></=
o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pdev-&gt;bus-&gt;number =3D=3D 0x7) {</=
span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; whil=
e (true)</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!!atomic_read(&amp;card0_in=
_baco))</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prin=
tk(&quot;lema1: card0 in baco from card1 view\n&quot;);</span><o:p></o:p></=
p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864">&#43;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!queue_work_o=
n(cpu, system_highpri_wq,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &amp;tmp_a=
dev-&gt;xgmi_reset_work))<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -=
EALREADY;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu =3D cpumask_n=
ext(cpu, cpu_online_mask);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
 else<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_asic_reset(tmp_adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot=
;ASIC reset failed with error, %d for drm dev, %s&quot;,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, tmp_adev-&gt;dd=
ev-&gt;unique);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o=
:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brea=
k;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XG=
MI wait for all PSP resets to complete before proceed */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI=
 wait for all work to complete before proceed */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (!r) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l=
ist_for_each_entry(tmp_adev, device_list_handle,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp;&nbsp;gmc.xgmi.head) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -3826,11 &#43;3836,59 @@ static int amdgp=
u_do_asic_reset(struct amdgpu_hive_info *hive,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D t=
mp_adev-&gt;asic_reset_res;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(AMD_RESET_METHOD_BACO =
=3D=3D<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; amdgpu_=
asic_reset_method(tmp_adev))<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;in_baco =
=3D true;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For XGMI =
with baco reset, need exit baco phase by scheduling<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * xgmi_rese=
t_work one more time. PSP reset skips this phase.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Not assum=
e the situation that PSP reset and baco reset<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * coexist w=
ithin an XGMI hive.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu =3D smp_pr=
ocessor_id();<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_=
entry(tmp_adev, device_list_handle,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; g=
mc.xgmi.head) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp_adev-&gt;=
gmc.xgmi.num_physical_nodes &gt; 1<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &amp;&amp; AMD_RESET_METHOD_BACO =3D=3D<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; amdgpu_asic_reset_method(tmp_adev)) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!queue_work_on(c=
pu,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_highpri_wq,<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tmp_adev-&gt;xgmi_reset=
_work))<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -EALREADY;<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu =3D cpumask_next=
(cpu, cpu_online_mask);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_=
entry(tmp_adev, device_list_handle,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; g=
mc.xgmi.head) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp_adev-&gt;=
gmc.xgmi.num_physical_nodes &gt; 1<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &amp;&amp; AMD_RESET_METHOD_BACO =3D=3D<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; amdgpu_asic_reset_method(tmp_adev)) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_work(&amp;tmp_adev-=
&gt;xgmi_reset_work);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D tmp_adev-&gt;a=
sic_reset_res;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;in_baco=
 =3D false;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quo=
t;ASIC reset failed with error, %d for drm dev, %s&quot;,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, tmp_adev-&gt;d=
dev-&gt;unique);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto end;<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (need_full_reset) {<o:p></o:p></p>
</blockquote>
</div>
</body>
</html>

--_000_MN2PR12MB428532FA663C99770AA71263F6430MN2PR12MB4285namp_--

--===============1929888832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1929888832==--

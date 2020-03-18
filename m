Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C845C1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 02:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5F220724
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 02:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jy/wGjjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5F220724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3516E03A;
	Wed, 18 Mar 2020 02:03:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620C66E03A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 02:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj/1s1gGIi61tdd1OyH1XjQ0iORnl/p/aOJsp6FrZCNoXKLfEjKQSFPSR9LfgBqDc98SfDEpQFxto70uvU9vKcVdqEFBjMQUm/5clLQEgexOlOY+/5gmFH2kysa1zXtxkTVlCLXzqAF4vogXJXjWFj/amIQCxnO1HZ3FmVejyazRdzaZgaC82Ks8T5N2pt2Sw4OmL6xn7pkB0R0vk5J5+CIYz1aveqI/SGfXF6Xc82kKi/WyDHAlJEemLIPh2bWpSbsCyM9tyfMTKSHTj3ZxsA8zpwGjUXSupQyTTQAJ38TWYgD09kIngaaYcLPgwacXbebO4/feNgDrHivzMRZh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwozNj8+8WTAluBuEMEyDuPESc0pQJeePo/fmA9IlEw=;
 b=XGIHUyGMAqSyThENEyEJPXsMlvyoFFPoAQUvODfbzBB6faHK69pGETTSsjGOmMQknAkl0ATk6GW7DNaKTAApMTIYaHfyKIxQQNQNt/O+mqa5CfzyNvdS21sSreHXuMIOvJEZwk6r5H5/H3Obl7SecNFEQ1zoMwDPVp6b+tLluwKmyuDLYyQTJbVFJErwigxG0zy74z211ms3IgBivfOfG8rUQbXbBRounSCAV6jfI2GNfEuLB1E6UE/uVjRPVFjXN6w7Qb+G7kpWChgU0t2YlfhAl7m3HZ2hEjV9E+vepeqM54vSXDZjK/0VDXhKw9M+VVJ2ZgGLvUZgWFv16HX9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwozNj8+8WTAluBuEMEyDuPESc0pQJeePo/fmA9IlEw=;
 b=Jy/wGjjQugfLKxUUycfit3u+g8sWxxGiBSTVfYCRshXokUxf3wN4J9mpgOfp52BN22Lw/KRcNtqcIXMBSpYI7oumYwt6zkGAKjoS5OZpgvmXzJ9+jECmKvuqTPYDbcwTChUonxRF4yFC9p5rBisYzdVEhDlyicf9Zdc6U+dliCY=
Received: from BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11)
 by BN8PR12MB3234.namprd12.prod.outlook.com (2603:10b6:408:95::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 02:03:33 +0000
Received: from BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::a421:2af7:645a:a051]) by BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::a421:2af7:645a:a051%6]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 02:03:33 +0000
From: "Lin, Amber" <Amber.Lin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Provide SMI events watch
Thread-Topic: [PATCH] drm/amdkfd: Provide SMI events watch
Thread-Index: AQHV/IV+uiLW6tS0eUypOVyYgbLFGahNJGcAgAB0h8I=
Date: Wed, 18 Mar 2020 02:03:33 +0000
Message-ID: <BN8PR12MB3041596444CC70FA247B3AB6E1F70@BN8PR12MB3041.namprd12.prod.outlook.com>
References: <1584467823-31170-1-git-send-email-Amber.Lin@amd.com>,
 <CADnq5_OgnVWdmc7PUXbT4Y2wqY7H=_LsTMYK3=2KunQjK0XU2w@mail.gmail.com>
In-Reply-To: <CADnq5_OgnVWdmc7PUXbT4Y2wqY7H=_LsTMYK3=2KunQjK0XU2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-18T02:03:32.378Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0780c376-0bc4-4ddc-7630-08d7cae08fe3
x-ms-traffictypediagnostic: BN8PR12MB3234:
x-microsoft-antispam-prvs: <BN8PR12MB32347D8A9010A8ED0BDC7296E1F70@BN8PR12MB3234.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:82;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(199004)(45080400002)(966005)(316002)(478600001)(76116006)(91956017)(66446008)(66556008)(64756008)(71200400001)(30864003)(66476007)(66946007)(33656002)(52536014)(5660300002)(26005)(186003)(2906002)(4326008)(7696005)(19627405001)(86362001)(8936002)(6916009)(81166006)(81156014)(8676002)(55016002)(9686003)(53546011)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3234;
 H:BN8PR12MB3041.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLX8Es8EoNMDZNf5LddMfWqi5nKF1+ZN19GF60505XlVzi6yrFjAou5OV/APDKi+bMxB423Np1NNb5VncI+AQKnkraEKoaXmnGogfGGQwagL9JVbeLgZaeTD7D3lyk/4GaaklkNfOcnfDAa3gqfJs+yLiE6i+7+EK+BCMAPzt5tbQFYO/bSjL3/4HkR0/g53nBsiXFNe9orVUBusU0YxaQVed1GIHwj5RTNJncvBA6uzDXdeVpFT/rxi1ImpI6qzu8IGSFtWEDIG0vuPgai0oGypDwfc8mjHxU/2zWN6ZLjgGCISVu//fQpEDjWU872/ev+pUqQFjgzRAuMiDgQKOPJ/eoqSqnrkl52D14bw6kwwtGz7URWwUbHN8a0k5kxL8zAzEIoyQdKdCIle19io3L8zWm1vAyZM68laFH+b44dqsqpTsWxV2Xc+JdYX2yfsVuN45rdNfuFBeIxMFjqifQHAeF7NQV53jW9QEBr0OAYdoAjT882CEHaL8d4//oVQhmHM2jZYipc1zmdGWnU5Ew==
x-ms-exchange-antispam-messagedata: 8UQaM9bXdjIOc6NHizRgZfgN8gKrPeq3QWR/bnjLn++qK7ivVyj4yWOyw8IncxmyC9NtGJ33/yAzS/CFxlWUpAbR+6Y8Ks9YnriKoKPuUYGV1pwgH2JFztG1QQNoBuMm0TQQ0v4pPc3qe13tVkDXDA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0780c376-0bc4-4ddc-7630-08d7cae08fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 02:03:33.0838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dj1sO/Ce8x/5JfiJEGhK7OJK53zh2xjdkk2BJPDmsjsDmA5HhBbtG6kvyjc72sIs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3234
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0482714895=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0482714895==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB3041596444CC70FA247B3AB6E1F70BN8PR12MB3041namp_"

--_000_BN8PR12MB3041596444CC70FA247B3AB6E1F70BN8PR12MB3041namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, March 17, 2020 3:03 PM
To: Lin, Amber <Amber.Lin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Provide SMI events watch

On Tue, Mar 17, 2020 at 1:57 PM Amber Lin <Amber.Lin@amd.com> wrote:
>
> When the compute is malfunctioning or performance drops, the system admin
> will use SMI (System Management Interface) tool to monitor/diagnostic wha=
t
> went wrong. This patch provides an event watch interface for the user
> space to register events they are interested. After the event is
> registered, the user can use annoymous file descriptor's pull function
> with wait-time specified to wait for the event to happen. Once the event
> happens, the user can use read() to retrieve information related to the
> event.
>
> VM fault event is done in this patch.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Can you provide a link to the userspace tools that make use of this interfa=
ce?

Thanks,

Alex
=3D=3D=3D=3D=3D
Hi Alex,

https://github.com/RadeonOpenCompute/rocm_smi_lib will use this interface. =
Those functions will be added to this library:

/* Get a handler for watching events */
rsmi_status_t rsmi_event_init(rsmi_event_handle_t *handle);
/* Register events for the device using the handler from init */
rsmi_status_t rsmi_event_register(uint32_t dv_ind, uint32_t events,
                                rsmi_event_handle_t *handle);
/* Wait for events. If one of the events happens, a success is returned wit=
h
 * with details in data.
 */
rsmi_status_t rsmi_event_wait(rsmi_event_handle_t handle, uint32_t timeout_=
ms,
                                rsmi_event_data_t *data);
/* Stop watching events */
rsmi_status_t rsmi_event_free(rsmi_event_handle_t handle);

Regards,
Amber

> ---
>  drivers/gpu/drm/amd/amdkfd/Makefile              |   3 +-
>  drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c |   2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  38 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  |   2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |  10 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c      | 143 +++++++++++++++++=
++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h      |  41 +++++++
>  include/uapi/linux/kfd_ioctl.h                   |  27 ++++-
>  9 files changed, 265 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/am=
dkfd/Makefile
> index 6147462..cc98b4a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Makefile
> +++ b/drivers/gpu/drm/amd/amdkfd/Makefile
> @@ -53,7 +53,8 @@ AMDKFD_FILES  :=3D $(AMDKFD_PATH)/kfd_module.o \
>                 $(AMDKFD_PATH)/kfd_int_process_v9.o \
>                 $(AMDKFD_PATH)/kfd_dbgdev.o \
>                 $(AMDKFD_PATH)/kfd_dbgmgr.o \
> -               $(AMDKFD_PATH)/kfd_crat.o
> +               $(AMDKFD_PATH)/kfd_crat.o \
> +               $(AMDKFD_PATH)/kfd_smi_events.o
>
>  ifneq ($(CONFIG_AMD_IOMMU_V2),)
>  AMDKFD_FILES +=3D $(AMDKFD_PATH)/kfd_iommu.o
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/g=
pu/drm/amd/amdkfd/cik_event_interrupt.c
> index 9f59ba9..24b4717 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -24,6 +24,7 @@
>  #include "kfd_events.h"
>  #include "cik_int.h"
>  #include "amdgpu_amdkfd.h"
> +#include "kfd_smi_events.h"
>
>  static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>                                         const uint32_t *ih_ring_entry,
> @@ -107,6 +108,7 @@ static void cik_event_interrupt_wq(struct kfd_dev *de=
v,
>                 ihre->source_id =3D=3D CIK_INTSRC_GFX_MEM_PROT_FAULT) {
>                 struct kfd_vm_fault_info info;
>
> +               kfd_smi_event_update_vmfault(dev, pasid);
>                 kfd_process_vm_fault(dev->dqm, pasid);
>
>                 memset(&info, 0, sizeof(info));
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index f8fa03a..8e92956 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -39,6 +39,7 @@
>  #include "kfd_device_queue_manager.h"
>  #include "kfd_dbgmgr.h"
>  #include "amdgpu_amdkfd.h"
> +#include "kfd_smi_events.h"
>
>  static long kfd_ioctl(struct file *, unsigned int, unsigned long);
>  static int kfd_open(struct inode *, struct file *);
> @@ -1243,6 +1244,40 @@ static int kfd_ioctl_acquire_vm(struct file *filep=
, struct kfd_process *p,
>         return ret;
>  }
>
> +/* Handle requests for watching SMI events */
> +static int kfd_ioctl_smi_events(struct file *filep,
> +                               struct kfd_process *p, void *data)
> +{
> +       struct kfd_ioctl_smi_events_args *args =3D data;
> +       struct kfd_dev *dev;
> +       int ret =3D 0;
> +
> +       dev =3D kfd_device_by_id(args->gpu_id);
> +       if (!dev)
> +               return -EINVAL;
> +
> +       switch (args->op) {
> +       case KFD_SMI_EVENTS_REGISTER:
> +               ret =3D kfd_smi_event_register(dev, args->events);
> +               if (ret >=3D 0) {
> +                       /* When the registration is successful, it return=
s the
> +                        * annoymous inode. Pass it to the user in data1
> +                        */
> +                       args->data1 =3D ret;
> +                       ret =3D 0;
> +               }
> +               break;
> +       case KFD_SMI_EVENTS_UNREGISTER:
> +               kfd_smi_event_unregister(dev, args->events);
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
>  bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>  {
>         struct kfd_local_mem_info mem_info;
> @@ -1827,6 +1862,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls=
[] =3D {
>
>         AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
>                         kfd_ioctl_alloc_queue_gws, 0),
> +
> +       AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
> +                       kfd_ioctl_smi_events, 0),
>  };
>
>  #define AMDKFD_CORE_IOCTL_COUNT        ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 7866cd06..450368c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -532,6 +532,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>         kfd->device_info =3D device_info;
>         kfd->pdev =3D pdev;
>         kfd->init_complete =3D false;
> +       kfd->smi_events.events =3D 0;
>         kfd->kfd2kgd =3D f2g;
>         atomic_set(&kfd->compute_profile, 0);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_int_process_v9.c
> index e05d75e..151e83e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -24,6 +24,7 @@
>  #include "kfd_events.h"
>  #include "soc15_int.h"
>  #include "kfd_device_queue_manager.h"
> +#include "kfd_smi_events.h"
>
>  static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>                                         const uint32_t *ih_ring_entry,
> @@ -117,6 +118,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev=
,
>                 info.prot_read  =3D ring_id & 0x10;
>                 info.prot_write =3D ring_id & 0x20;
>
> +               kfd_smi_event_update_vmfault(dev, pasid);
>                 kfd_process_vm_fault(dev->dqm, pasid);
>                 kfd_signal_vm_fault_event(dev, pasid, &info);
>         }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 43b888b..fdb51de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -223,6 +223,13 @@ struct kfd_vmid_info {
>         uint32_t vmid_num_kfd;
>  };
>
> +struct kfd_smi_events {
> +       uint64_t events;
> +       struct kfifo fifo;
> +       wait_queue_head_t wait_queue;
> +       uint32_t max_events;
> +};
> +
>  struct kfd_dev {
>         struct kgd_dev *kgd;
>
> @@ -309,6 +316,9 @@ struct kfd_dev {
>
>         /* Global GWS resource shared b/t processes*/
>         void *gws;
> +
> +       /* if this device is in SMI events watch */
> +       struct kfd_smi_events smi_events;
>  };
>
>  enum kfd_mempool {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_smi_events.c
> new file mode 100644
> index 0000000..ba9d036
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -0,0 +1,143 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <linux/poll.h>
> +#include <linux/wait.h>
> +#include <linux/anon_inodes.h>
> +#include <uapi/linux/kfd_ioctl.h>
> +#include "amdgpu_vm.h"
> +#include "kfd_priv.h"
> +#include "kfd_smi_events.h"
> +
> +static DEFINE_MUTEX(kfd_smi_mutex);
> +
> +struct mutex *kfd_get_smi_mutex(void)
> +{
> +       return &kfd_smi_mutex;
> +}
> +
> +static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct =
*);
> +static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, lof=
f_t *);
> +static int kfd_smi_ev_release(struct inode *, struct file *);
> +
> +static const char kfd_smi_name[] =3D "kfd_smi_ev";
> +
> +static const struct file_operations kfd_smi_ev_fops =3D {
> +       .owner =3D THIS_MODULE,
> +       .poll =3D kfd_smi_ev_poll,
> +       .read =3D kfd_smi_ev_read,
> +       .release =3D kfd_smi_ev_release
> +};
> +
> +static __poll_t kfd_smi_ev_poll(struct file *filep,
> +                               struct poll_table_struct *wait)
> +{
> +       struct kfd_dev *dev =3D filep->private_data;
> +       struct kfd_smi_events *ev =3D &dev->smi_events;
> +
> +       __poll_t mask =3D 0;
> +
> +       poll_wait(filep, &ev->wait_queue, wait);
> +       mask |=3D !kfifo_is_empty(&ev->fifo) ? POLLIN | POLLRDNORM : mask=
;
> +
> +       return mask;
> +}
> +
> +static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
> +                              size_t size, loff_t *offset)
> +{
> +       int ret, copied =3D 0;
> +       struct kfd_dev *dev =3D filep->private_data;
> +
> +       ret =3D kfifo_to_user(&dev->smi_events.fifo, user, size, &copied)=
;
> +       if (ret || !copied) {
> +               pr_debug("kfd smi-events: Fail to read fd (%i) (%i)\n",
> +                               ret, copied);
> +               return ret ? ret : -EAGAIN;
> +       }
> +
> +       return copied;
> +}
> +
> +static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
> +{
> +       struct kfd_dev *dev =3D filep->private_data;
> +
> +       kfifo_free(&dev->smi_events.fifo);
> +       return 0;
> +}
> +
> +void kfd_smi_event_update_vmfault(struct kfd_dev *kdev, uint16_t pasid)
> +{
> +       struct kfd_smi_vmfault_fifo fifo_out;
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)kdev->kgd;
> +       struct amdgpu_task_info task_info;
> +
> +       if (!kdev->smi_events.events)
> +               return;
> +
> +       if (!(kdev->smi_events.events & KFD_SMI_EV_VMFAULT))
> +               return;
> +
> +       memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> +       amdgpu_vm_get_task_info(adev, pasid, &task_info);
> +
> +       fifo_out.group =3D 0;
> +       fifo_out.event =3D KFD_SMI_EV_VMFAULT;
> +       fifo_out.gpu_id =3D kdev->id;
> +       fifo_out.pid =3D task_info.pid;
> +       strcpy(fifo_out.task_name, task_info.task_name);
> +       kfifo_in(&kdev->smi_events.fifo, &fifo_out, sizeof(fifo_out));
> +       wake_up_all(&kdev->smi_events.wait_queue);
> +}
> +
> +void kfd_smi_event_unregister(struct kfd_dev *dev, uint64_t events)
> +{
> +       mutex_lock(kfd_get_smi_mutex());
> +       dev->smi_events.events &=3D ~events;
> +       mutex_unlock(kfd_get_smi_mutex());
> +}
> +
> +int kfd_smi_event_register(struct kfd_dev *dev, uint64_t events)
> +{
> +       int ret;
> +
> +       mutex_lock(kfd_get_smi_mutex());
> +       dev->smi_events.events |=3D events;
> +       mutex_unlock(kfd_get_smi_mutex());
> +
> +       /* We use the lower 32 bits for now. Each bit represents one even=
t. If
> +        * featured events are increased to more than 32, we'll use the u=
pper
> +        * bits as groups so the total number of events can be up to 32*3=
2.
> +        */
> +       dev->smi_events.max_events =3D 32;
> +       ret =3D kfifo_alloc(&dev->smi_events.fifo, dev->smi_events.max_ev=
ents,
> +                        GFP_KERNEL);
> +       if (ret) {
> +               pr_err("fail to allocate kfifo\n");
> +               return ret;
> +       }
> +       init_waitqueue_head(&dev->smi_events.wait_queue);
> +
> +       return anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops,
> +                               (void *)dev, 0);
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/dr=
m/amd/amdkfd/kfd_smi_events.h
> new file mode 100644
> index 0000000..2e320d3
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef KFD_SMI_EVENTS_H_INCLUDED
> +#define KFD_SMI_EVENTS_H_INCLUDED
> +
> +int kfd_smi_event_register(struct kfd_dev *dev, uint64_t events);
> +void kfd_smi_event_unregister(struct kfd_dev *dev, uint64_t events);
> +void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
> +
> +/* All FIFO must start with "uint32_t group" and "uint32_t event" so the=
 user
> + * can read the first 8 bytes to determine the next read length.
> + */
> +struct kfd_smi_vmfault_fifo {
> +       uint32_t group;
> +       uint32_t event;
> +       unsigned int gpu_id;
> +       pid_t pid;
> +       char task_name[TASK_COMM_LEN];
> +};
> +
> +#endif
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index 4f66764..6ce7c69 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -442,6 +442,28 @@ struct kfd_ioctl_import_dmabuf_args {
>         __u32 dmabuf_fd;        /* to KFD */
>  };
>
> +/*
> + * KFD SMI(System Management Interface) events
> + */
> +enum kfd_smi_events_op {
> +       KFD_SMI_EVENTS_REGISTER =3D 1,
> +       KFD_SMI_EVENTS_UNREGISTER
> +};
> +
> +/* Event ID (mask) */
> +#define KFD_SMI_EV_VMFAULT     0x00000001
> +
> +struct kfd_ioctl_smi_events_args {
> +       __u32 op;       /* to KFD */
> +       /* upper 32 bits: group. lower 32 bits: event IDs */
> +       __u64 events;   /* to KFD */
> +       __u32 gpu_id;   /* to KFD */
> +       pid_t pid;      /* to KFD */
> +       __u32 data1;    /* from KFD */
> +       __u32 data2;
> +       __u32 data3;
> +};
> +
>  /* Register offset inside the remapped mmio page
>   */
>  enum kfd_mmio_remap {
> @@ -546,7 +568,10 @@ enum kfd_mmio_remap {
>  #define AMDKFD_IOC_ALLOC_QUEUE_GWS             \
>                 AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
>
> +#define AMDKFD_IOC_SMI_EVENTS                  \
> +               AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)
> +
>  #define AMDKFD_COMMAND_START           0x01
> -#define AMDKFD_COMMAND_END             0x1F
> +#define AMDKFD_COMMAND_END             0x20
>
>  #endif
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CAmber.=
Lin%40amd.com%7C2f64059b66554d40898208d7caa5e374%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637200686149934820&amp;sdata=3DvBpnnq1xhSxEMjEWffwSLVIcS=
ymSemDQTiEoYXj5lEE%3D&amp;reserved=3D0

--_000_BN8PR12MB3041596444CC70FA247B3AB6E1F70BN8PR12MB3041namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, March 17, 2020 3:03 PM<br>
<b>To:</b> Lin, Amber &lt;Amber.Lin@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Provide SMI events watch</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Tue, Mar 17, 2020 at 1:57 PM Amber Lin &lt;Ambe=
r.Lin@amd.com&gt; wrote:<br>
&gt;<br>
&gt; When the compute is malfunctioning or performance drops, the system ad=
min<br>
&gt; will use SMI (System Management Interface) tool to monitor/diagnostic =
what<br>
&gt; went wrong. This patch provides an event watch interface for the user<=
br>
&gt; space to register events they are interested. After the event is<br>
&gt; registered, the user can use annoymous file descriptor's pull function=
<br>
&gt; with wait-time specified to wait for the event to happen. Once the eve=
nt<br>
&gt; happens, the user can use read() to retrieve information related to th=
e<br>
&gt; event.<br>
&gt;<br>
&gt; VM fault event is done in this patch.<br>
&gt;<br>
&gt; Signed-off-by: Amber Lin &lt;Amber.Lin@amd.com&gt;<br>
<br>
Can you provide a link to the userspace tools that make use of this interfa=
ce?<br>
<br>
Thanks,<br>
<br>
Alex<br>
=3D=3D=3D=3D=3D</div>
<div class=3D"PlainText">Hi Alex,</div>
<div class=3D"PlainText"><span><br>
</span><span></span><span>https://github.com/RadeonOpenCompute/rocm_smi_lib=
&nbsp;will use this interface. Those functions will be added to this librar=
y:<br>
</span>
<div><br>
</div>
<div>/* Get a handler for watching events */<br>
</div>
<div>rsmi_status_t rsmi_event_init(rsmi_event_handle_t *handle);<br>
</div>
<div>/* Register events for the device using the handler from init */<br>
</div>
<div>rsmi_status_t rsmi_event_register(uint32_t dv_ind, uint32_t events,<br=
>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rsmi_event_handle_t *handle);<br>
</div>
<div>/* Wait for events. If one of the events happens, a success is returne=
d with<br>
</div>
<div>&nbsp;* with details in data.<br>
</div>
<div>&nbsp;*/<br>
</div>
<div>rsmi_status_t rsmi_event_wait(rsmi_event_handle_t handle, uint32_t tim=
eout_ms,<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rsmi_event_data_t *data);<br>
</div>
<div>/* Stop watching events */<br>
</div>
<div>rsmi_status_t rsmi_event_free(rsmi_event_handle_t handle);<br>
</div>
<div><br>
</div>
<span></span>Regards,</div>
<div class=3D"PlainText">Amber</div>
<div class=3D"PlainText"><br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 &#43;-<br=
>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c |&nbsp;&nbsp; 2=
 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 38 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c&nbsp; |&nbsp;&nb=
sp; 2 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 10 &#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; | 143 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp; 41 &#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 27 &#43;&#43;&#43;&#43;-<br>
&gt;&nbsp; 9 files changed, 265 insertions(&#43;), 2 deletions(-)<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c<b=
r>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h<b=
r>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd=
/amdkfd/Makefile<br>
&gt; index 6147462..cc98b4a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/Makefile<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/Makefile<br>
&gt; @@ -53,7 &#43;53,8 @@ AMDKFD_FILES&nbsp; :=3D $(AMDKFD_PATH)/kfd_modul=
e.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_int_process_v9.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_dbgdev.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_dbgmgr.o \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_crat.o<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_crat.o \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_smi_events.o<br>
&gt;<br>
&gt;&nbsp; ifneq ($(CONFIG_AMD_IOMMU_V2),)<br>
&gt;&nbsp; AMDKFD_FILES &#43;=3D $(AMDKFD_PATH)/kfd_iommu.o<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/driver=
s/gpu/drm/amd/amdkfd/cik_event_interrupt.c<br>
&gt; index 9f59ba9..24b4717 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c<br>
&gt; @@ -24,6 &#43;24,7 @@<br>
&gt;&nbsp; #include &quot;kfd_events.h&quot;<br>
&gt;&nbsp; #include &quot;cik_int.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt; &#43;#include &quot;kfd_smi_events.h&quot;<br>
&gt;<br>
&gt;&nbsp; static bool cik_event_interrupt_isr(struct kfd_dev *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const uint32_t *ih_ring_entry,<br>
&gt; @@ -107,6 &#43;108,7 @@ static void cik_event_interrupt_wq(struct kfd_=
dev *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ihre-&gt;source_id =3D=3D CIK_INTSRC_GFX_MEM_PROT=
_FAULT) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_vm_fault_info info;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfd_smi_event_update_vmfault(dev, pasid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_vm_fault(dev-&gt;dqm, pasid);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;info, 0, sizeof(info));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_chardev.c<br>
&gt; index f8fa03a..8e92956 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; @@ -39,6 &#43;39,7 @@<br>
&gt;&nbsp; #include &quot;kfd_device_queue_manager.h&quot;<br>
&gt;&nbsp; #include &quot;kfd_dbgmgr.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt; &#43;#include &quot;kfd_smi_events.h&quot;<br>
&gt;<br>
&gt;&nbsp; static long kfd_ioctl(struct file *, unsigned int, unsigned long=
);<br>
&gt;&nbsp; static int kfd_open(struct inode *, struct file *);<br>
&gt; @@ -1243,6 &#43;1244,40 @@ static int kfd_ioctl_acquire_vm(struct file=
 *filep, struct kfd_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;/* Handle requests for watching SMI events */<br>
&gt; &#43;static int kfd_ioctl_smi_events(struct file *filep,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p, void *data)=
<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_smi_events_=
args *args =3D data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D kfd_device_by_id(arg=
s-&gt;gpu_id);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (args-&gt;op) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_SMI_EVENTS_REGISTER=
:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D kfd_smi_event_register(dev, args-&gt;events);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret &gt;=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* When=
 the registration is successful, it returns the<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 annoymous inode. Pass it to the user in data1<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&g=
t;data1 =3D ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_SMI_EVENTS_UNREGIST=
ER:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfd_smi_event_unregister(dev, args-&gt;events);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; bool kfd_dev_is_large_bar(struct kfd_dev *dev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_local_mem_i=
nfo mem_info;<br>
&gt; @@ -1827,6 &#43;1862,9 @@ static const struct amdkfd_ioctl_desc amdkfd=
_ioctls[] =3D {<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOCTL_DEF(AMDKF=
D_IOC_ALLOC_QUEUE_GWS,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k=
fd_ioctl_alloc_queue_gws, 0),<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOCTL_DEF(AMDKFD_IOC_=
SMI_EVENTS,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_ioc=
tl_smi_events, 0),<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; #define AMDKFD_CORE_IOCTL_COUNT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; ARRAY_SIZE(amdkfd_ioctls)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_device.c<br>
&gt; index 7866cd06..450368c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; @@ -532,6 &#43;532,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *=
kgd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_info =
=3D device_info;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;pdev =3D pdev;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;init_complete =
=3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;smi_events.events =
=3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;kfd2kgd =3D f2=
g;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;kfd-&g=
t;compute_profile, 0);<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
&gt; index e05d75e..151e83e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
&gt; @@ -24,6 &#43;24,7 @@<br>
&gt;&nbsp; #include &quot;kfd_events.h&quot;<br>
&gt;&nbsp; #include &quot;soc15_int.h&quot;<br>
&gt;&nbsp; #include &quot;kfd_device_queue_manager.h&quot;<br>
&gt; &#43;#include &quot;kfd_smi_events.h&quot;<br>
&gt;<br>
&gt;&nbsp; static bool event_interrupt_isr_v9(struct kfd_dev *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const uint32_t *ih_ring_entry,<br>
&gt; @@ -117,6 &#43;118,7 @@ static void event_interrupt_wq_v9(struct kfd_d=
ev *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; info.prot_read&nbsp; =3D ring_id &amp; 0x10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; info.prot_write =3D ring_id &amp; 0x20;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfd_smi_event_update_vmfault(dev, pasid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_vm_fault(dev-&gt;dqm, pasid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; kfd_signal_vm_fault_event(dev, pasid, &amp;info);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index 43b888b..fdb51de 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -223,6 &#43;223,13 @@ struct kfd_vmid_info {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid_num_kfd;=
<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; &#43;struct kfd_smi_events {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t events;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfifo fifo;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_queue_head_t wait_queue=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_events;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; struct kfd_dev {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kgd_dev *kgd;<b=
r>
&gt;<br>
&gt; @@ -309,6 &#43;316,9 @@ struct kfd_dev {<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Global GWS resource=
 shared b/t processes*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gws;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if this device is in SMI =
events watch */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_smi_events smi_ev=
ents;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; enum kfd_mempool {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_smi_events.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..ba9d036<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c<br>
&gt; @@ -0,0 &#43;1,143 @@<br>
&gt; &#43;/*<br>
&gt; &#43; * Copyright 2020 Advanced Micro Devices, Inc.<br>
&gt; &#43; *<br>
&gt; &#43; * Permission is hereby granted, free of charge, to any person ob=
taining a<br>
&gt; &#43; * copy of this software and associated documentation files (the =
&quot;Software&quot;),<br>
&gt; &#43; * to deal in the Software without restriction, including without=
 limitation<br>
&gt; &#43; * the rights to use, copy, modify, merge, publish, distribute, s=
ublicense,<br>
&gt; &#43; * and/or sell copies of the Software, and to permit persons to w=
hom the<br>
&gt; &#43; * Software is furnished to do so, subject to the following condi=
tions:<br>
&gt; &#43; *<br>
&gt; &#43; * The above copyright notice and this permission notice shall be=
 included in<br>
&gt; &#43; * all copies or substantial portions of the Software.<br>
&gt; &#43; *<br>
&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY O=
F ANY KIND, EXPRESS OR<br>
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHA=
NTABILITY,<br>
&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN=
 NO EVENT SHALL<br>
&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR<br>
&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTH=
ERWISE,<br>
&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE=
 USE OR<br>
&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; &#43; */<br>
&gt; &#43;<br>
&gt; &#43;#include &lt;linux/poll.h&gt;<br>
&gt; &#43;#include &lt;linux/wait.h&gt;<br>
&gt; &#43;#include &lt;linux/anon_inodes.h&gt;<br>
&gt; &#43;#include &lt;uapi/linux/kfd_ioctl.h&gt;<br>
&gt; &#43;#include &quot;amdgpu_vm.h&quot;<br>
&gt; &#43;#include &quot;kfd_priv.h&quot;<br>
&gt; &#43;#include &quot;kfd_smi_events.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;static DEFINE_MUTEX(kfd_smi_mutex);<br>
&gt; &#43;<br>
&gt; &#43;struct mutex *kfd_get_smi_mutex(void)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;kfd_smi_mutex;<b=
r>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_=
struct *);<br>
&gt; &#43;static ssize_t kfd_smi_ev_read(struct file *, char __user *, size=
_t, loff_t *);<br>
&gt; &#43;static int kfd_smi_ev_release(struct inode *, struct file *);<br>
&gt; &#43;<br>
&gt; &#43;static const char kfd_smi_name[] =3D &quot;kfd_smi_ev&quot;;<br>
&gt; &#43;<br>
&gt; &#43;static const struct file_operations kfd_smi_ev_fops =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .poll =3D kfd_smi_ev_poll,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D kfd_smi_ev_read,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D kfd_smi_ev_rele=
ase<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static __poll_t kfd_smi_ev_poll(struct file *filep,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct poll_table_struct *wait)<br=
>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D file=
p-&gt;private_data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_smi_events *ev =
=3D &amp;dev-&gt;smi_events;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __poll_t mask =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; poll_wait(filep, &amp;ev-&gt=
;wait_queue, wait);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask |=3D !kfifo_is_empty(&a=
mp;ev-&gt;fifo) ? POLLIN | POLLRDNORM : mask;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mask;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static ssize_t kfd_smi_ev_read(struct file *filep, char __user *u=
ser,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size, loff_t *offset)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, copied =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D file=
p-&gt;private_data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kfifo_to_user(&amp;d=
ev-&gt;smi_events.fifo, user, size, &amp;copied);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || !copied) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_debug(&quot;kfd smi-events: Fail to read fd (%i) (%i=
)\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, copied);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret ? ret : -EAGAIN;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return copied;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int kfd_smi_ev_release(struct inode *inode, struct file *f=
ilep)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D file=
p-&gt;private_data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfifo_free(&amp;dev-&gt;smi_=
events.fifo);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;void kfd_smi_event_update_vmfault(struct kfd_dev *kdev, uint16_t =
pasid)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_smi_vmfault_fifo =
fifo_out;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kdev-&gt;kgd;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info task=
_info;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kdev-&gt;smi_events.eve=
nts)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(kdev-&gt;smi_events.ev=
ents &amp; KFD_SMI_EV_VMFAULT))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;task_info, 0, si=
zeof(struct amdgpu_task_info));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_get_task_info(adev=
, pasid, &amp;task_info);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fifo_out.group =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fifo_out.event =3D KFD_SMI_E=
V_VMFAULT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fifo_out.gpu_id =3D kdev-&gt=
;id;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fifo_out.pid =3D task_info.p=
id;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(fifo_out.task_name, t=
ask_info.task_name);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfifo_in(&amp;kdev-&gt;smi_e=
vents.fifo, &amp;fifo_out, sizeof(fifo_out));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up_all(&amp;kdev-&gt;sm=
i_events.wait_queue);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;void kfd_smi_event_unregister(struct kfd_dev *dev, uint64_t event=
s)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(kfd_get_smi_mutex=
());<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;smi_events.events &a=
mp;=3D ~events;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(kfd_get_smi_mut=
ex());<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;int kfd_smi_event_register(struct kfd_dev *dev, uint64_t events)<=
br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(kfd_get_smi_mutex=
());<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;smi_events.events |=
=3D events;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(kfd_get_smi_mut=
ex());<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We use the lower 32 bits =
for now. Each bit represents one event. If<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * featured events are =
increased to more than 32, we'll use the upper<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * bits as groups so th=
e total number of events can be up to 32*32.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;smi_events.max_event=
s =3D 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kfifo_alloc(&amp;dev=
-&gt;smi_events.fifo, dev-&gt;smi_events.max_events,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G=
FP_KERNEL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_err(&quot;fail to allocate kfifo\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_waitqueue_head(&amp;dev=
-&gt;smi_events.wait_queue);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return anon_inode_getfd(kfd_=
smi_name, &amp;kfd_smi_ev_fops,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)dev, 0);<br>
&gt; &#43;}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu=
/drm/amd/amdkfd/kfd_smi_events.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..2e320d3<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h<br>
&gt; @@ -0,0 &#43;1,41 @@<br>
&gt; &#43;/*<br>
&gt; &#43; * Copyright 2020 Advanced Micro Devices, Inc.<br>
&gt; &#43; *<br>
&gt; &#43; * Permission is hereby granted, free of charge, to any person ob=
taining a<br>
&gt; &#43; * copy of this software and associated documentation files (the =
&quot;Software&quot;),<br>
&gt; &#43; * to deal in the Software without restriction, including without=
 limitation<br>
&gt; &#43; * the rights to use, copy, modify, merge, publish, distribute, s=
ublicense,<br>
&gt; &#43; * and/or sell copies of the Software, and to permit persons to w=
hom the<br>
&gt; &#43; * Software is furnished to do so, subject to the following condi=
tions:<br>
&gt; &#43; *<br>
&gt; &#43; * The above copyright notice and this permission notice shall be=
 included in<br>
&gt; &#43; * all copies or substantial portions of the Software.<br>
&gt; &#43; *<br>
&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY O=
F ANY KIND, EXPRESS OR<br>
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHA=
NTABILITY,<br>
&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN=
 NO EVENT SHALL<br>
&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR<br>
&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTH=
ERWISE,<br>
&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE=
 USE OR<br>
&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; &#43; */<br>
&gt; &#43;<br>
&gt; &#43;#ifndef KFD_SMI_EVENTS_H_INCLUDED<br>
&gt; &#43;#define KFD_SMI_EVENTS_H_INCLUDED<br>
&gt; &#43;<br>
&gt; &#43;int kfd_smi_event_register(struct kfd_dev *dev, uint64_t events);=
<br>
&gt; &#43;void kfd_smi_event_unregister(struct kfd_dev *dev, uint64_t event=
s);<br>
&gt; &#43;void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t p=
asid);<br>
&gt; &#43;<br>
&gt; &#43;/* All FIFO must start with &quot;uint32_t group&quot; and &quot;=
uint32_t event&quot; so the user<br>
&gt; &#43; * can read the first 8 bytes to determine the next read length.<=
br>
&gt; &#43; */<br>
&gt; &#43;struct kfd_smi_vmfault_fifo {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t group;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t event;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int gpu_id;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid_t pid;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char task_name[TASK_COMM_LEN=
];<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;#endif<br>
&gt; diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_i=
octl.h<br>
&gt; index 4f66764..6ce7c69 100644<br>
&gt; --- a/include/uapi/linux/kfd_ioctl.h<br>
&gt; &#43;&#43;&#43; b/include/uapi/linux/kfd_ioctl.h<br>
&gt; @@ -442,6 &#43;442,28 @@ struct kfd_ioctl_import_dmabuf_args {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dmabuf_fd;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; &#43;/*<br>
&gt; &#43; * KFD SMI(System Management Interface) events<br>
&gt; &#43; */<br>
&gt; &#43;enum kfd_smi_events_op {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENTS_REGISTER =3D =
1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENTS_UNREGISTER<br=
>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;/* Event ID (mask) */<br>
&gt; &#43;#define KFD_SMI_EV_VMFAULT&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001<br>
&gt; &#43;<br>
&gt; &#43;struct kfd_ioctl_smi_events_args {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 op;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* to KFD */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* upper 32 bits: group. low=
er 32 bits: event IDs */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 events;&nbsp;&nbsp; /*=
 to KFD */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 gpu_id;&nbsp;&nbsp; /*=
 to KFD */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid_t pid;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* to KFD */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 data1;&nbsp;&nbsp;&nbs=
p; /* from KFD */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 data2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 data3;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; /* Register offset inside the remapped mmio page<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; enum kfd_mmio_remap {<br>
&gt; @@ -546,7 &#43;568,10 @@ enum kfd_mmio_remap {<br>
&gt;&nbsp; #define AMDKFD_IOC_ALLOC_QUEUE_GWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gw=
s_args)<br>
&gt;<br>
&gt; &#43;#define AMDKFD_IOC_SMI_EVENTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)<br>
&gt; &#43;<br>
&gt;&nbsp; #define AMDKFD_COMMAND_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x01<br>
&gt; -#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1F<br>
&gt; &#43;#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x20<br>
&gt;<br>
&gt;&nbsp; #endif<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D02%7C01%7CAmber.Lin%40amd.com%7C2f64059b66554d40898208d7caa5e374%7C3dd89=
61fe4884e608e11a82d994e183d%7C0%7C0%7C637200686149934820&amp;amp;sdata=3DvB=
pnnq1xhSxEMjEWffwSLVIcSymSemDQTiEoYXj5lEE%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CAmbe=
r.Lin%40amd.com%7C2f64059b66554d40898208d7caa5e374%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637200686149934820&amp;amp;sdata=3DvBpnnq1xhSxEMjEWffw=
SLVIcSymSemDQTiEoYXj5lEE%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN8PR12MB3041596444CC70FA247B3AB6E1F70BN8PR12MB3041namp_--

--===============0482714895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0482714895==--

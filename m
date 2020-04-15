Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D260DC2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 13:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B322074F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 13:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kTM/4vYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B322074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BBD76E974;
	Wed, 15 Apr 2020 13:48:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0496E974
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 13:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu3wnokRMGR6L8RgSIadDMtLRJ2M5Zhp2DDqqDER+L4a7QRCL8yiAysDTYxl1IQRSL14H7R4OlFq0ixlUnRzB9fJubIRlU1pIrva97iK6mqASf+CqL6LsbCT9iu2JAifyijTYBn/IxVznLOxcbg+ykD4ZzibHuKth6+w4le3nkEspoYpGhYV+gKv5mcVv/bl5Xt/eTGIQhZ552nuqlqxOyKFWXuM/W2YODPXCC0iPkIXV8bsUiKwbXygkD6mRu3PCyUOLRqL/mxiszQeDIFaMSYnYit73mmi+Qrs030nZRR8Yy8qvbiPfxCCLmJPS1ERXMspJZsa4Yel6kyBq5lufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zvnc2/kJp1oOonAtwnpTtdwWFQLUpcoYD6Dp0FBypw=;
 b=WnsD0vvf+HpNRbbnscBWAnctxSAtUPti7hJX7XQoJu7b1jMI9xBBY4duWytYDN1aOU4/LXhFVCnp6zle5ayzUToPLp/nH+sMet9abMAs1Zvqc2dk7CvDlH1Y8p0/y+iwphk465+cURVQJTzX/H3faTvQz5VNG2uB1OOQtMuidHAEjEIGZWOkziSLHbwHgHe2438GsEJhvp8EdzJ8Z5wXKtdLOD+XHud5tKleV/WgT4Viyizh7LL5cWJySUFL+bPBFvVKvUudGW0+Rx+AmWWiesI4Ex2qVqORrVSPG9CU1yOlZp/AI6QqTftbMqL84p3EZKu02qFxcVwhF2E+QX4tag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zvnc2/kJp1oOonAtwnpTtdwWFQLUpcoYD6Dp0FBypw=;
 b=kTM/4vYW4b32DFUPbYOtZB2eWgy7jYwkDBrEHoMiBgJJHhd+/lI2lttISyNcBfrm+Lummu/6TTlbgmrx/bJUKD0Dwu31NWNnn4NfJ0AsGX3rNynxaajOP4gqtsKkM2RS/KPctFRAiexp+9gGQku8gcGUPqn7CUs9g1ehA/MA9KA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.18; Wed, 15 Apr
 2020 13:48:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 13:48:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
Thread-Topic: [PATCH v4] drm/amdkfd: Provide SMI events watch
Thread-Index: AQHWEqQBluSiSywBekWHn1sWXvu8Tqh5PK8AgAASNwCAACpZAIAABlVugACw7wCAAAJQPA==
Date: Wed, 15 Apr 2020 13:48:34 +0000
Message-ID: <MN2PR12MB44886F41E8D3FCDFD7DED107F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1586899842-28131-1-git-send-email-Amber.Lin@amd.com>
 <46d5b0c3-2fb3-932e-2ec7-216d693a63d4@amd.com>
 <BN8PR12MB30418878CCC5D2FE5103248DE1DB0@BN8PR12MB3041.namprd12.prod.outlook.com>
 <7442ee3e-9d91-d886-af22-cf00f9ab23a4@amd.com>
 <MN2PR12MB4488B378A20AB052F3A93564F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <04d21092-3366-99fa-c792-291b1a7a859a@amd.com>
In-Reply-To: <04d21092-3366-99fa-c792-291b1a7a859a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-15T13:48:33.732Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [172.58.187.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4415ef93-8138-4039-752c-08d7e143b0f2
x-ms-traffictypediagnostic: MN2PR12MB4504:|MN2PR12MB4504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45044828BB3395708908EFA9F7DB0@MN2PR12MB4504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(19627405001)(19627235002)(33656002)(110136005)(66946007)(6506007)(53546011)(7696005)(86362001)(21615005)(66556008)(64756008)(66446008)(52536014)(66476007)(8936002)(76116006)(71200400001)(55016002)(8676002)(9686003)(5660300002)(478600001)(966005)(316002)(26005)(2906002)(186003)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEuTJqrKHZ4zYxuSjgj1jkRg/dBW6ZMARUajTUMLHqZnS29vwkWLf/nnW58QARAwi3XNEvVVOic1QqJ+Lx5wuScxEMnfx5XVn2UUaAUiyW24hxj2zzs4pQV/sHiTRrxbro3hlcmAOBBM/Xt6mLBLi29XY8CPmCP9qpLqXOc5vGsALu3s83zFU2Hg71Md5gv6rGJ+KJq4J4JmYe4U0WPRlr+yUbhVAOwD1HxhYw+ctYuJlK7p3+N51l6raMFXoIbugY0EWTG0eXHY8LIXcINSJXLYhKVDjhCHWjs2u1HYZAietHKeD3+n7XzIlmfRuAJW1iXXqshQ5xv0YULdUpOQ7AHPkRp1KmwTC4Y8oOf/mjjQtOT5cNZ4xeVAmSr+C2P0Y63PijgdU66GXkhslDYn9dQybBRHD85ALUgD0vEngWyj633dSP+MHcWT/jLkxfJbcJ89sLj3RZCad6lanmQHYWu/VUZvvB9mOwpcYpMYGWdYwcZsiM6riqS2G1xfu4ppOcmxG2W7TtrbiCMYHqljrA==
x-ms-exchange-antispam-messagedata: hueE1UThi89zNwaIPcUN1/g7mPzJ9nvLtHWIdB0JaGTQWE4pk9sbsikhGSanW/Dk60FsOqCLorh/ep5qBCqnHjYzeIZbMYx8pUvY03iOYT34Gw1IwCxTMh2LvXpRG1KR3OELF0ftf5sn60fgCRZfdg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4415ef93-8138-4039-752c-08d7e143b0f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 13:48:34.3325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzyX5euPWbojIhLeovyll/fVFxYP/m73EzmKyRyqVTQCTEKzUaHAYHXY/fRccp+r+cnx1hoM4/Aiq9dZjsbGFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
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
Content-Type: multipart/mixed; boundary="===============1010723736=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1010723736==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44886F41E8D3FCDFD7DED107F7DB0MN2PR12MB4488namp_"

--_000_MN2PR12MB44886F41E8D3FCDFD7DED107F7DB0MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

We use the drm major/minor in all cases.  Bump  KMS_DRIVER_MINOR in amdgpu_=
drv.c and add a note about what was added in the comment.

Alex
________________________________
From: Lin, Amber <Amber.Lin@amd.com>
Sent: Wednesday, April 15, 2020 9:36 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop=
.org>
Subject: Re: [PATCH v4] drm/amdkfd: Provide SMI events watch

Thank you Felix. Now I understand the problem of global client ID is leakin=
g a hole for potential attackers. I didn't take that into consideration. I'=
ll change that following your advice below.

Hi Alex,

Thank you for the link. It's helpful. I have a question regarding the versi=
oning. One topic in the article talks about how the userspace can figure ou=
t if the new ioctl is supported in a given kernel. Is it correct that with =
dkms driver, we use the driver version coming from AMDGPU_VERSION in amdgpu=
_drv.c, and in upstream kernel we use the kernel version?

Thanks.

Amber

On 2020-04-14 11:03 p.m., Deucher, Alexander wrote:

[AMD Public Use]

Some good advice on getting ioctls right:
https://www.kernel.org/doc/html/v5.4-preprc-cpu/ioctl/botching-up-ioctls.ht=
ml

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Felix Kuehling <felix.kuehling@amd.co=
m><mailto:felix.kuehling@amd.com>
Sent: Tuesday, April 14, 2020 10:40 PM
To: Lin, Amber <Amber.Lin@amd.com><mailto:Amber.Lin@amd.com>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freed=
esktop.org><mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4] drm/amdkfd: Provide SMI events watch


Hi Amber,

I understand that different processes can get the same FD. My statement abo=
ut FD being unique is relative to one process.

The main problem with the global client ID is, that it allows process A to =
change the event mask of process B just by specifying process B's client ID=
. That can lead to denial of service attacks where process A can cause even=
ts not to be delivered to B or can flood process B with frequent events tha=
t it's not prepared to handle.

Therefore you must make the lookup of the client from the client ID not fro=
m a global list, but from a per-process list. That way process A can only c=
hange event masks of process A clients, and not those of any other process.

But if the client list is process-specific, you can use the FD as a unique =
identifier of the client within the process, so you don't need a separate c=
lient ID.

Regards,
  Felix

Am 2020-04-14 um 8:09 p.m. schrieb Lin, Amber:

[AMD Official Use Only - Internal Distribution Only]



Hi Felix,



That was my assumption too that each registration will get different file d=
escriptor, but it turns out not. When I started two process and both regist=
er gpu0 and gpu1, they both got fd=3D15. If I have process A register gpu0+=
gpu1, and process B only register gpu0, process A gets fd=3D15 and process =
B gets fd=3D9. That=92s why I added client ID.



By multiple clients, I mean multiple processes. The ask is users want to ha=
ve multiple tools and those different tools can use rsmi lib to watch event=
s at the same time. Due to the reason above that two processes can actually=
 get the same fd and I need to add client ID to distinguish the registratio=
n, I don=92t see the point of limiting one registration per process unless =
I use pid to distinguish the client instead, which was in my consideration =
too when I was writing the code. But second thought is why adding this rest=
riction when client ID can allow the tool to watch different events on diff=
erent devices if they want to. Maybe client ID is a bad term and it mislead=
s you. I should call it register ID.



Regards,

Amber



From: Kuehling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.co=
m>
Sent: Tuesday, April 14, 2020 7:04 PM
To: Lin, Amber <Amber.Lin@amd.com><mailto:Amber.Lin@amd.com>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4] drm/amdkfd: Provide SMI events watch



Hi Amber,

Some general remarks about the multi-client support. You added a global cli=
ent id that's separate from the file descriptor. That's problematic for two=
 reasons:

  1.  A process could change a different process' event mask
  2.  The FD should already be unique per process, no need to invent anothe=
r ID

If we want to allow one process to register for events multiple times (mult=
iple FDs per process), then the list of clients should be per process. Each=
 process should only be allowed to change the event masks of its own client=
s. The client could be identified by its FD. No need for another client ID.

But you could also simplify it further by allowing only one event client pe=
r process. Then you don't need the client ID lookup at all. Just have a sin=
gle event client in the kfd_process.

Another approach would be to make enable/disable functions of the event FD,=
 rather than the KFD FD ioctl. It could be an ioctl of the event FD, or eve=
n simpler, you could use the write file-operation to write an event mask (o=
f arbitrary length if you want to enable growth in the future). That way ev=
erything would be neatly encapsulated in the event FD private data.

Two more comments inline ...



Am 2020-04-14 um 5:30 p.m. schrieb Amber Lin:

When the compute is malfunctioning or performance drops, the system admin

will use SMI (System Management Interface) tool to monitor/diagnostic what

went wrong. This patch provides an event watch interface for the user

space to register devices and subscribe events they are interested. After

registered, the user can use annoymous file descriptor's poll function

with wait-time specified and wait for events to happen. Once an event

happens, the user can use read() to retrieve information related to the

event.



VM fault event is done in this patch.



v2: - remove UNREGISTER and add event ENABLE/DISABLE

    - correct kfifo usage

    - move event message API to kfd_ioctl.h

v3: send the event msg in text than in binary

v4: support multiple clients



Signed-off-by: Amber Lin <Amber.Lin@amd.com><mailto:Amber.Lin@amd.com>

[snip]

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h

index 4f66764..8146437 100644

--- a/include/uapi/linux/kfd_ioctl.h

+++ b/include/uapi/linux/kfd_ioctl.h

@@ -442,6 +442,36 @@ struct kfd_ioctl_import_dmabuf_args {

  __u32 dmabuf_fd;       /* to KFD */

 };



+/*

+ * KFD SMI(System Management Interface) events

+ */

+enum kfd_smi_events_op {

+ KFD_SMI_EVENTS_REGISTER =3D 1,

+ KFD_SMI_EVENTS_ENABLE,

+ KFD_SMI_EVENTS_DISABLE

+};

+

+/* Event type (defined by bitmask) */

+#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001

+

+struct kfd_ioctl_smi_events_args {

+ __u32 op;              /* to KFD */

+ __u64 events;          /* to KFD */

The binary layout of the ioctl args structure should be the same on 32/64-b=
it. That means the 64-bit members should be 64-bit aligned. The best way to=
 ensure this is to put all the 64-bit members first.





+ __u64 gpuids_array_ptr;        /* to KFD */

+ __u32 num_gpuids;      /* to KFD */

+ __u32 anon_fd;         /* from KFD */

+ __u32 client_id;       /* to/from KFD */

+};

+

+/* 1. All messages must start with (hex)uint64_event(16) + space(1) +

+ *    (hex)gpuid(8) + space(1) =3D  26 bytes

+ * 2. VmFault msg =3D (hex)uint32_pid(8) + space(1) + task name(16) =3D 25

+ *    When a new event msg uses more memory, change the calculation here.

+ * 3. End with \n(1)

+ * 26 + 25 + 1 =3D 52

+ */

+#define KFD_SMI_MAX_EVENT_MSG 52

If you define the maximum message length here, clients may start depending =
on it, and it gets harder to change it later. I'd not define this in the AP=
I header. It's not necessary to write correct clients. And if used badly, i=
t may encourage writing incorrect clients that break with longer messages i=
n the future.

Regards,
  Felix





+

 /* Register offset inside the remapped mmio page

  */

 enum kfd_mmio_remap {

@@ -546,7 +576,10 @@ enum kfd_mmio_remap {

 #define AMDKFD_IOC_ALLOC_QUEUE_GWS            \

         AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)



+#define AMDKFD_IOC_SMI_EVENTS                 \

+        AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)

+

 #define AMDKFD_COMMAND_START           0x01

-#define AMDKFD_COMMAND_END             0x1F

+#define AMDKFD_COMMAND_END             0x20



 #endif


--_000_MN2PR12MB44886F41E8D3FCDFD7DED107F7DB0MN2PR12MB4488namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
We use the drm major/minor in all cases.&nbsp; Bump&nbsp; KMS_DRIVER_MINOR =
in amdgpu_drv.c and add a note about what was added in the comment.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lin, Amber &lt;Amber.=
Lin@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 15, 2020 9:36 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd=
-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH v4] drm/amdkfd: Provide SMI events watch</font>
<div>&nbsp;</div>
</div>
<div><font size=3D"&#43;1"><tt>Thank you Felix. Now I understand the proble=
m of global client ID is leaking a hole for potential attackers. I didn't t=
ake that into consideration. I'll change that following your advice below.<=
br>
<br>
Hi Alex,<br>
<br>
Thank you for the link. It's helpful. I have a question regarding the versi=
oning. One topic in the article talks about how the userspace can figure ou=
t if the new ioctl is supported in a given kernel. Is it correct that with =
dkms driver, we use the driver version
 coming from AMDGPU_VERSION in amdgpu_drv.c, and in upstream kernel we use =
the kernel version?<br>
<br>
Thanks.<br>
<br>
Amber<br>
</tt></font><br>
<div class=3D"x_moz-cite-prefix">On 2020-04-14 11:03 p.m., Deucher, Alexand=
er wrote:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#317100=
; margin:15pt">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Some good advice on getting ioctls right:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://www.kernel.org/doc/html/v5.4-preprc-cpu/ioctl/botching-u=
p-ioctls.html" id=3D"LPNoLP568680">https://www.kernel.org/doc/html/v5.4-pre=
prc-cpu/ioctl/botching-up-ioctls.html</a></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on behalf of Felix Kuehli=
ng <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:felix.kuehling@amd.c=
om">
&lt;felix.kuehling@amd.com&gt;</a><br>
<b>Sent:</b> Tuesday, April 14, 2020 10:40 PM<br>
<b>To:</b> Lin, Amber <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:A=
mber.Lin@amd.com">
&lt;Amber.Lin@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH v4] drm/amdkfd: Provide SMI events watch</font>
<div>&nbsp;</div>
</div>
<div>
<p>Hi Amber,</p>
<p>I understand that different processes can get the same FD. My statement =
about FD being unique is relative to one process.</p>
<p>The main problem with the global client ID is, that it allows process A =
to change the event mask of process B just by specifying process B's client=
 ID. That can lead to denial of service attacks where process A can cause e=
vents not to be delivered to B or
 can flood process B with frequent events that it's not prepared to handle.=
</p>
<p>Therefore you must make the lookup of the client from the client ID not =
from a global list, but from a per-process list. That way process A can onl=
y change event masks of process A clients, and not those of any other proce=
ss.</p>
<p>But if the client list is process-specific, you can use the FD as a uniq=
ue identifier of the client within the process, so you don't need a separat=
e client ID.</p>
<p>Regards,<br>
&nbsp; Felix<br>
</p>
<div class=3D"x_x_moz-cite-prefix">Am 2020-04-14 um 8:09 p.m. schrieb Lin, =
Amber:<br>
</div>
<blockquote type=3D"cite">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered
              medium)">
<style>
<!--
@font-face
	{font-family:PMingLiU}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Consolas}
p.x_x_MsoNormal, li.x_x_MsoNormal, div.x_x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New"}
span.x_x_HTMLPreformattedChar
	{font-family:Consolas}
p.x_x_msipheader4d0fcdd7, li.x_x_msipheader4d0fcdd7, div.x_x_msipheader4d0f=
cdd7
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_x_EmailStyle22
	{font-family:"Arial",sans-serif;
	color:#0078D7}
.x_x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
ol
	{margin-bottom:0in}
ul
	{margin-bottom:0in}
-->
</style>
<div class=3D"x_x_WordSection1">
<p class=3D"x_x_msipheader4d0fcdd7" style=3D"margin:0in; margin-bottom:.000=
1pt"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-se=
rif; color:#0078D7">[AMD Official Use Only - Internal Distribution Only]</s=
pan></p>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
<p class=3D"x_x_MsoNormal">Hi Felix,</p>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
<p class=3D"x_x_MsoNormal">That was my assumption too that each registratio=
n will get different file descriptor, but it turns out not. When I started =
two process and both register gpu0 and gpu1, they both got fd=3D15. If I ha=
ve process A register gpu0&#43;gpu1, and
 process B only register gpu0, process A gets fd=3D15 and process B gets fd=
=3D9. That=92s why I added client ID.</p>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
<p class=3D"x_x_MsoNormal">By multiple clients, I mean multiple processes. =
The ask is users want to have multiple tools and those different tools can =
use rsmi lib to watch events at the same time. Due to the reason above that=
 two processes can actually get the
 same fd and I need to add client ID to distinguish the registration, I don=
=92t see the point of limiting one registration per process unless I use pi=
d to distinguish the client instead, which was in my consideration too when=
 I was writing the code. But second
 thought is why adding this restriction when client ID can allow the tool t=
o watch different events on different devices if they want to. Maybe client=
 ID is a bad term and it misleads you. I should call it register ID.</p>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_x_MsoNormal">Regards,</p>
<p class=3D"x_x_MsoNormal">Amber</p>
</div>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_x_MsoNormal"><b>From:</b> Kuehling, Felix <a class=3D"x_x_moz=
-txt-link-rfc2396E" href=3D"mailto:Felix.Kuehling@amd.com">
&lt;Felix.Kuehling@amd.com&gt;</a> <br>
<b>Sent:</b> Tuesday, April 14, 2020 7:04 PM<br>
<b>To:</b> Lin, Amber <a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"mailto=
:Amber.Lin@amd.com">
&lt;Amber.Lin@amd.com&gt;</a>; <a class=3D"x_x_moz-txt-link-abbreviated" hr=
ef=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject:</b> Re: [PATCH v4] drm/amdkfd: Provide SMI events watch</p>
</div>
</div>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
<p>Hi Amber,</p>
<p>Some general remarks about the multi-client support. You added a global =
client id that's separate from the file descriptor. That's problematic for =
two reasons:</p>
<ol type=3D"1" start=3D"1">
<li class=3D"x_x_MsoNormal" style=3D"">A process could change a different p=
rocess' event mask</li><li class=3D"x_x_MsoNormal" style=3D"">The FD should=
 already be unique per process, no need to invent another ID</li></ol>
<p>If we want to allow one process to register for events multiple times (m=
ultiple FDs per process), then the list of clients should be per process. E=
ach process should only be allowed to change the event masks of its own cli=
ents. The client could be identified
 by its FD. No need for another client ID.</p>
<p>But you could also simplify it further by allowing only one event client=
 per process. Then you don't need the client ID lookup at all. Just have a =
single event client in the kfd_process.</p>
<p>Another approach would be to make enable/disable functions of the event =
FD, rather than the KFD FD ioctl. It could be an ioctl of the event FD, or =
even simpler, you could use the write file-operation to write an event mask=
 (of arbitrary length if you want
 to enable growth in the future). That way everything would be neatly encap=
sulated in the event FD private data.</p>
<p>Two more comments inline ...</p>
<p>&nbsp;</p>
<div>
<p class=3D"x_x_MsoNormal">Am 2020-04-14 um 5:30 p.m. schrieb Amber Lin:</p=
>
</div>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<pre>When the compute is malfunctioning or performance drops, the system ad=
min</pre>
<pre>will use SMI (System Management Interface) tool to monitor/diagnostic =
what</pre>
<pre>went wrong. This patch provides an event watch interface for the user<=
/pre>
<pre>space to register devices and subscribe events they are interested. Af=
ter</pre>
<pre>registered, the user can use annoymous file descriptor's poll function=
</pre>
<pre>with wait-time specified and wait for events to happen. Once an event<=
/pre>
<pre>happens, the user can use read() to retrieve information related to th=
e</pre>
<pre>event.</pre>
<pre>&nbsp;</pre>
<pre>VM fault event is done in this patch.</pre>
<pre>&nbsp;</pre>
<pre>v2: - remove UNREGISTER and add event ENABLE/DISABLE</pre>
<pre>&nbsp;&nbsp;&nbsp; - correct kfifo usage</pre>
<pre>&nbsp;&nbsp;&nbsp; - move event message API to kfd_ioctl.h</pre>
<pre>v3: send the event msg in text than in binary</pre>
<pre>v4: support multiple clients</pre>
<pre>&nbsp;</pre>
<pre>Signed-off-by: Amber Lin <a href=3D"mailto:Amber.Lin@amd.com">&lt;Ambe=
r.Lin@amd.com&gt;</a></pre>
</blockquote>
<p>[snip]</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<pre>diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_i=
octl.h</pre>
<pre>index 4f66764..8146437 100644</pre>
<pre>--- a/include/uapi/linux/kfd_ioctl.h</pre>
<pre>&#43;&#43;&#43; b/include/uapi/linux/kfd_ioctl.h</pre>
<pre>@@ -442,6 &#43;442,36 @@ struct kfd_ioctl_import_dmabuf_args {</pre>
<pre>&nbsp; __u32 dmabuf_fd;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD =
*/</pre>
<pre> };</pre>
<pre> </pre>
<pre>&#43;/*</pre>
<pre>&#43; * KFD SMI(System Management Interface) events</pre>
<pre>&#43; */</pre>
<pre>&#43;enum kfd_smi_events_op {</pre>
<pre>&#43; KFD_SMI_EVENTS_REGISTER =3D 1,</pre>
<pre>&#43; KFD_SMI_EVENTS_ENABLE,</pre>
<pre>&#43; KFD_SMI_EVENTS_DISABLE</pre>
<pre>&#43;};</pre>
<pre>&#43;</pre>
<pre>&#43;/* Event type (defined by bitmask) */</pre>
<pre>&#43;#define KFD_SMI_EVENT_VMFAULT&nbsp;&nbsp;&nbsp;&nbsp; 0x000000000=
0000001</pre>
<pre>&#43;</pre>
<pre>&#43;struct kfd_ioctl_smi_events_args {</pre>
<pre>&#43; __u32 op;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */</pre>
<pre>&#43; __u64 events;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* to KFD */</pre>
</blockquote>
<p>The binary layout of the ioctl args structure should be the same on 32/6=
4-bit. That means the 64-bit members should be 64-bit aligned. The best way=
 to ensure this is to put all the 64-bit members first.</p>
<p class=3D"x_x_MsoNormal" style=3D"margin-bottom:12.0pt">&nbsp;</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<pre>&nbsp;</pre>
<pre>&#43; __u64 gpuids_array_ptr;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* to KFD */</pre>
<pre>&#43; __u32 num_gpuids;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */</pr=
e>
<pre>&#43; __u32 anon_fd;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /=
* from KFD */</pre>
<pre>&#43; __u32 client_id;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to/from =
KFD */</pre>
<pre>&#43;};</pre>
<pre>&#43;</pre>
<pre>&#43;/* 1. All messages must start with (hex)uint64_event(16) &#43; sp=
ace(1) &#43;</pre>
<pre>&#43; *&nbsp;&nbsp;&nbsp; (hex)gpuid(8) &#43; space(1) =3D&nbsp; 26 by=
tes</pre>
<pre>&#43; * 2. VmFault msg =3D (hex)uint32_pid(8) &#43; space(1) &#43; tas=
k name(16) =3D 25</pre>
<pre>&#43; *&nbsp;&nbsp;&nbsp; When a new event msg uses more memory, chang=
e the calculation here.</pre>
<pre>&#43; * 3. End with \n(1)</pre>
<pre>&#43; * 26 &#43; 25 &#43; 1 =3D 52</pre>
<pre>&#43; */</pre>
<pre>&#43;#define KFD_SMI_MAX_EVENT_MSG 52</pre>
</blockquote>
<p>If you define the maximum message length here, clients may start dependi=
ng on it, and it gets harder to change it later. I'd not define this in the=
 API header. It's not necessary to write correct clients. And if used badly=
, it may encourage writing incorrect
 clients that break with longer messages in the future.</p>
<p>Regards,<br>
&nbsp; Felix</p>
<p>&nbsp;</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<pre>&nbsp;</pre>
<pre>&#43;</pre>
<pre> /* Register offset inside the remapped mmio page</pre>
<pre>&nbsp; */</pre>
<pre> enum kfd_mmio_remap {</pre>
<pre>@@ -546,7 &#43;576,10 @@ enum kfd_mmio_remap {</pre>
<pre> #define AMDKFD_IOC_ALLOC_QUEUE_GWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1E, struct k=
fd_ioctl_alloc_queue_gws_args)</pre>
<pre> </pre>
<pre>&#43;#define AMDKFD_IOC_SMI_EVENTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</pre>
<pre>&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1F, stru=
ct kfd_ioctl_smi_events_args)</pre>
<pre>&#43;</pre>
<pre> #define AMDKFD_COMMAND_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x01</pre>
<pre>-#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1F</pre>
<pre>&#43;#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x20</pre>
<pre> </pre>
<pre>&nbsp;#endif</pre>
</blockquote>
</div>
</blockquote>
</div>
</div>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB44886F41E8D3FCDFD7DED107F7DB0MN2PR12MB4488namp_--

--===============1010723736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1010723736==--

Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F73C2BB1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 03:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF8C206D5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 03:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C1I0wWTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF8C206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66726E82A;
	Wed, 15 Apr 2020 03:03:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD3A6E82A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 03:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyXPCfqJ/mKNw/YRY+uC3BBqRziCjuuqo/wrdpXSgQc15bJOIFpWFjUswUX25y8U7E/cS/jFxojwnCmgFr4vph5N4BE2ibeg/tWgq54IGGNZPAb/MJZCADlARj8s4/QSDw4BPlEdCEkLmib53ps738HIHHYevJ0PO4haGYu+dTjQO9iE5DRng8RNqTCd7JJSjdNmTbjzVAqk4tiOYOAn1gol5BSaBQHZfZiMpSSSTeMmg8xXJSFqNZYKD5SJEMyj9Wv2We/SMBzc2Rdn525ELBoMEMdFEEtgrfCkIfB9JGbFSm1oSdhk3kaH47cn0dZ1uMJ1qsRNPcfQkNykKdo61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCWlewN0e1ey3Qh7r1+2OOi8SRH18bKjAQYm/twpOoo=;
 b=YVwCkLbFGbDSq2mJlx+ogg57LxW36yrLy1fbFpgw70x8ZiXy62zQ7h0zJIYm/39zo6KTchbPpXK4U7IzSJjhyyBk5kiO/4ygx7xYbzcBbsHYX9WYaPJGdFfhtuTVtR1YcF1c3FZIso1riTc4LMai4iqjrLjRJUIPAPn0SgljQ8ZcQK6kixhb7vljfYgzLPcuQ6OHfBXiaqjchj7v47uooX2jhvefJBIhOkCBYd7DivIedySNhpPBBcCOgR0rxqQ69UO950q9DfDZtm2Kx0X2MuZRZF+1pVE1gKgyDPqRlv8nnOjKK0OU3cfPvK5fouadLyzZ5EICvbC54pRivG/r7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCWlewN0e1ey3Qh7r1+2OOi8SRH18bKjAQYm/twpOoo=;
 b=C1I0wWTIMsJnG/MKT2g7h2cRPo57GpmgScP5wYVFe79vTSIzQPGOUyKI8afoBTBZTqaknsYTF7dK63A+dLVdXsb96PB5/kQuoi+SkQNxIopa5Kle8OMs2G3zrCu7/nJB2AFYY8w7nBi+I6Z/2nCMUwq43i9OLumPAyVZmiE6xyk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB2943.namprd12.prod.outlook.com (2603:10b6:208:ad::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Wed, 15 Apr
 2020 03:03:56 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 03:03:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lin, Amber"
 <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4] drm/amdkfd: Provide SMI events watch
Thread-Topic: [PATCH v4] drm/amdkfd: Provide SMI events watch
Thread-Index: AQHWEqQBluSiSywBekWHn1sWXvu8Tqh5PK8AgAASNwCAACpZAIAABlVu
Date: Wed, 15 Apr 2020 03:03:55 +0000
Message-ID: <MN2PR12MB4488B378A20AB052F3A93564F7DB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1586899842-28131-1-git-send-email-Amber.Lin@amd.com>
 <46d5b0c3-2fb3-932e-2ec7-216d693a63d4@amd.com>
 <BN8PR12MB30418878CCC5D2FE5103248DE1DB0@BN8PR12MB3041.namprd12.prod.outlook.com>,
 <7442ee3e-9d91-d886-af22-cf00f9ab23a4@amd.com>
In-Reply-To: <7442ee3e-9d91-d886-af22-cf00f9ab23a4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-15T03:03:55.232Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2387caaf-792e-4af3-ce81-08d7e0e9a2dd
x-ms-traffictypediagnostic: MN2PR12MB2943:|MN2PR12MB2943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2943C2DB58CE22F33547676BF7DB0@MN2PR12MB2943.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(76116006)(66946007)(64756008)(55016002)(81156014)(66476007)(66556008)(110136005)(86362001)(9686003)(33656002)(66446008)(478600001)(7696005)(52536014)(5660300002)(2906002)(316002)(186003)(19627405001)(53546011)(21615005)(966005)(8936002)(71200400001)(6506007)(26005)(19627235002)(8676002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kQVGn+ZIMM8F9vT/8QGnFVW2kkZqS7djJOKV7E6dzLlKWSmn1z36CQ9AwQoB/L7bF50Ld+gyTOIiGkNk0XCydy9vgqGioMtedX9hRraEQ2Dfu4tH7ZCX82MpJSAmAyB/0N3RDdnAsSNCW0FBk9r/fEAe6SIKTqJCqLSyx5nI8wUPv73DJIi0MEbElkD+tjCVUyS/1zFZOlfAv8+gh2OqfpjrB3RwEnabGBSTzxpJvVbWAHv/Wc1K3HlBpGPwfVPzhC1mJ9zh0OzUWJbwnekMeyd+/jYfd2fmfemQmMNOPyuCHPrthPyypB9iAFjxIiGNK/OY127K5HxXx6YUSpAY6w61V2ZZzz+HuLMF02fWk/+QaJPJ9b0tRvzUPCSezCBnrt3x37uf6dr65RblRwig73cAA9H8rZZTTfHwYbscGiGAD/dOE605rGrr9mYy6M9d/5d+x7PEBN3iXfef5mpcp7ndKqHk6cgPfs/AHwLRbjouDYBWItXmcZ/tzaJjbP8XJkydrPhTbvDFUO5kYpXNw==
x-ms-exchange-antispam-messagedata: iqFh8xEsM0AGI4fGMBT7K+vUw/BcTzQl5zBo2LTpQNczhgfR3DStVBTkfwfEl5ryIWJdo4owwWHIH0g+HxioAoXIEteNh8TEesux92C61SH+fyQoM6/PxCT4jWQ046J1cIeVV17TdXh1GkSWHBlVnw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2387caaf-792e-4af3-ce81-08d7e0e9a2dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 03:03:55.9327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmgDrcaDVdXbv6WQUZK5bm6q8KTbceq3/tEp4zoxZ7BhLNL95wEeiuTJVUdXwIt+GrCx+qyVGL7qgZSWxOHKNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2943
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
Content-Type: multipart/mixed; boundary="===============1877818017=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1877818017==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488B378A20AB052F3A93564F7DB0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488B378A20AB052F3A93564F7DB0MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Some good advice on getting ioctls right:
https://www.kernel.org/doc/html/v5.4-preprc-cpu/ioctl/botching-up-ioctls.ht=
ml

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix Ku=
ehling <felix.kuehling@amd.com>
Sent: Tuesday, April 14, 2020 10:40 PM
To: Lin, Amber <Amber.Lin@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
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

--_000_MN2PR12MB4488B378A20AB052F3A93564F7DB0MN2PR12MB4488namp_
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
Some good advice on getting ioctls right:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://www.kernel.org/doc/html/v5.4-preprc-cpu/ioctl/botching-u=
p-ioctls.html" id=3D"LPNoLP568680">https://www.kernel.org/doc/html/v5.4-pre=
prc-cpu/ioctl/botching-up-ioctls.html</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Felix Kuehling &lt;felix.kueh=
ling@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:40 PM<br>
<b>To:</b> Lin, Amber &lt;Amber.Lin@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
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
<div class=3D"x_moz-cite-prefix">Am 2020-04-14 um 8:09 p.m. schrieb Lin, Am=
ber:<br>
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
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New"}
span.x_HTMLPreformattedChar
	{font-family:Consolas}
p.x_msipheader4d0fcdd7, li.x_msipheader4d0fcdd7, div.x_msipheader4d0fcdd7
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle22
	{font-family:"Arial",sans-serif;
	color:#0078D7}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
ol
	{margin-bottom:0in}
ul
	{margin-bottom:0in}
-->
</style>
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader4d0fcdd7" style=3D"margin:0in; margin-bottom:.0001p=
t"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-seri=
f; color:#0078D7">[AMD Official Use Only - Internal Distribution Only]</spa=
n></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Hi Felix,</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">That was my assumption too that each registration =
will get different file descriptor, but it turns out not. When I started tw=
o process and both register gpu0 and gpu1, they both got fd=3D15. If I have=
 process A register gpu0&#43;gpu1, and process
 B only register gpu0, process A gets fd=3D15 and process B gets fd=3D9. Th=
at=92s why I added client ID.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">By multiple clients, I mean multiple processes. Th=
e ask is users want to have multiple tools and those different tools can us=
e rsmi lib to watch events at the same time. Due to the reason above that t=
wo processes can actually get the
 same fd and I need to add client ID to distinguish the registration, I don=
=92t see the point of limiting one registration per process unless I use pi=
d to distinguish the client instead, which was in my consideration too when=
 I was writing the code. But second
 thought is why adding this restriction when client ID can allow the tool t=
o watch different events on different devices if they want to. Maybe client=
 ID is a bad term and it misleads you. I should call it register ID.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal">Regards,</p>
<p class=3D"x_MsoNormal">Amber</p>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1
            1.0pt; padding:3.0pt 0in 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Kuehling, Felix <a class=3D"x_moz-txt=
-link-rfc2396E" href=3D"mailto:Felix.Kuehling@amd.com">
&lt;Felix.Kuehling@amd.com&gt;</a> <br>
<b>Sent:</b> Tuesday, April 14, 2020 7:04 PM<br>
<b>To:</b> Lin, Amber <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:A=
mber.Lin@amd.com">
&lt;Amber.Lin@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject:</b> Re: [PATCH v4] drm/amdkfd: Provide SMI events watch</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p>Hi Amber,</p>
<p>Some general remarks about the multi-client support. You added a global =
client id that's separate from the file descriptor. That's problematic for =
two reasons:</p>
<ol type=3D"1" start=3D"1">
<li class=3D"x_MsoNormal" style=3D"">A process could change a different pro=
cess' event mask</li><li class=3D"x_MsoNormal" style=3D"">The FD should alr=
eady be unique per process, no need to invent another ID</li></ol>
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
<p class=3D"x_MsoNormal">Am 2020-04-14 um 5:30 p.m. schrieb Amber Lin:</p>
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
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">&nbsp;</p>
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
</body>
</html>

--_000_MN2PR12MB4488B378A20AB052F3A93564F7DB0MN2PR12MB4488namp_--

--===============1877818017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1877818017==--

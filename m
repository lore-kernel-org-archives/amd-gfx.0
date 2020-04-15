Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0513C2BB1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 00:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D35E2076B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 00:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M37pQQKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D35E2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1096E7D2;
	Wed, 15 Apr 2020 00:09:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6676E7D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 00:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neL7/dKytPLa7Nkro0/zPtcZ2thJMwNDzV7nyZBBOmgWTF1cSYDpBA/k4cHpYAeRetZZ6Loy84l36uaOu0hAGB7zFbha1NLi+DEyFYx2UDDNQ4IF38xRsr5bS6yo1/EyFudQCHCEASHzK2oKTA73/lus++oiaLo0MR/6WNl0pnqMBSnNF+Cyc5n6NvNKymbIbq3dOid8ht1QFjlcBm0xjPpINgvf6VC8YvoJBz/YoHiOpoYZQJfzeUGeM85pRtSnY+G1E8s96yOSivY6wjq7p34uFauZlqKqrUp2aZt8wK+dCYprML60fj34JlBVN0Vv6FUu0A9aTIpkB6JyLURlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VTgTAx2C5z1RaukUGEz9jbxm2ybl7n2gk2h3NlPJf8=;
 b=FIGIHzbjLPZe2XHBjL1RR/j29+0jy5Uu1rpOfd2xJftQwYq1lhF4htAz9c6G23ZJ/LSuapuuLkCFcOrd1XC3FswUeo18wEKd4Ee5/p+oh0sEbNwfL4K5nUBUiMT7KuflDenPZ09xbLX7pcBLEIiP+ad7ADttq0GISFTylPbqRbk8RsKi95zyvSjOXkXfxCEDR/j/1ZGTlnUG0FgN/KM7yFSSuVCB4AdleP+wbEjzwywtsnZtCvUpVmhV6mVBemSFsg6dMUSOV+7D8mlOM0ocuujyc4ZztluZP1w2rzxETvfsanPcUSPA5zmiXrnGzUQbaTxAXrogrYqfn3OqCMqDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VTgTAx2C5z1RaukUGEz9jbxm2ybl7n2gk2h3NlPJf8=;
 b=M37pQQKHR9Knllav+lmAyD2DMsmkLngELmp5dirr3SwoisUAJMQzVPoG153fbLfuGVeTV45VYZIBxZxg8zWlx/Pb4JhocN5LPDsfwXC7pAxfJo54609SKYKdqpt5W9ggPoPAosO2jMLXxgsQQmBFwK/gPK17Tua0n2MmtNd4LmA=
Received: from BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11)
 by BN8PR12MB3457.namprd12.prod.outlook.com (2603:10b6:408:67::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Wed, 15 Apr
 2020 00:09:13 +0000
Received: from BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::f92c:63b4:3640:a4c]) by BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::f92c:63b4:3640:a4c%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 00:09:13 +0000
From: "Lin, Amber" <Amber.Lin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amdkfd: Provide SMI events watch
Thread-Topic: [PATCH v4] drm/amdkfd: Provide SMI events watch
Thread-Index: AQHWEqP4ERq0bZNcm0CyGWsboeq9lKh5PK8AgAAKH/A=
Date: Wed, 15 Apr 2020 00:09:12 +0000
Message-ID: <BN8PR12MB30418878CCC5D2FE5103248DE1DB0@BN8PR12MB3041.namprd12.prod.outlook.com>
References: <1586899842-28131-1-git-send-email-Amber.Lin@amd.com>
 <46d5b0c3-2fb3-932e-2ec7-216d693a63d4@amd.com>
In-Reply-To: <46d5b0c3-2fb3-932e-2ec7-216d693a63d4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-15T00:09:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=14f1196a-7984-4e56-b2ac-0000d5a6657f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-15T00:09:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 135ba6bd-c3be-4e30-96e9-00006d9882ea
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
x-originating-ip: [72.141.223.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34cdf9b6-cf8e-490e-9e8b-08d7e0d13a8b
x-ms-traffictypediagnostic: BN8PR12MB3457:|BN8PR12MB3457:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB345727AE5A0278806D0A343CE1DB0@BN8PR12MB3457.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3041.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(66946007)(26005)(66446008)(110136005)(2906002)(9686003)(5660300002)(86362001)(53546011)(66556008)(76116006)(66476007)(64756008)(55016002)(6506007)(8936002)(52536014)(7696005)(81156014)(186003)(33656002)(8676002)(478600001)(71200400001)(316002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q3x1EKKosSOkeg/KW8pToz2lGaLXKb6+f4Ukkxhiq/ZXOZyC4tRTTW89GL8Q9sdsmbksQGFIpCjc3F2U4PxnHoUtMlieQtTThP6gKNhH668Rh7o/Ae2qa0A0eaIn1fLBJOCGYKLsDH+FWo5UnE1sQ86unVMJwGdGnnR1E9N7s0DDMvYoBd/rxOOSf/fQ7SHf8ScMVVuoq2eYwvMJUzU/igJ3NAzM0noz8cUVJpqJblaQvfaGhF9khe1DYB27DCksvPdv9SsOSIQAv7vYhDOvfLz+XyKs88imkmv6VCHuMi1TES6UxK2r7DaSOlkUn/3Xxi3LgBLl4Sx5lr/IMZuIxHSwNrbqKLKYhUTLq2Db74/CJz9u9IZl6Em4/UIUaYDSJS+DPB+VbdtQjqYBXu3xnBaC4PL5U8by7+Mr3Db55j6FLzwN6VTrJ6vciUKnzsOb
x-ms-exchange-antispam-messagedata: 42mYiT3xqcYO8JB1F43VrYxNHA8a4GSxeEV3y2EFMoc0PVOvccqqS+818I03QFA8e1itCZJ7kcJ65iLnl6LnYrRnvAPzOeF4hSI2F9IIsK96EIftapCWCXUotNz7UJqoBcpxNJALHH91VoDMi4r88Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cdf9b6-cf8e-490e-9e8b-08d7e0d13a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 00:09:12.7412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IfwR8b47C8UVw3IoibG6H+Who21t+Rei/WRMiZr/HI8urwSqaej7KIIJPikCpR3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3457
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
Content-Type: multipart/mixed; boundary="===============0235410490=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0235410490==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB30418878CCC5D2FE5103248DE1DB0BN8PR12MB3041namp_"

--_000_BN8PR12MB30418878CCC5D2FE5103248DE1DB0BN8PR12MB3041namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Felix,

That was my assumption too that each registration will get different file d=
escriptor, but it turns out not. When I started two process and both regist=
er gpu0 and gpu1, they both got fd=3D15. If I have process A register gpu0+=
gpu1, and process B only register gpu0, process A gets fd=3D15 and process =
B gets fd=3D9. That's why I added client ID.

By multiple clients, I mean multiple processes. The ask is users want to ha=
ve multiple tools and those different tools can use rsmi lib to watch event=
s at the same time. Due to the reason above that two processes can actually=
 get the same fd and I need to add client ID to distinguish the registratio=
n, I don't see the point of limiting one registration per process unless I =
use pid to distinguish the client instead, which was in my consideration to=
o when I was writing the code. But second thought is why adding this restri=
ction when client ID can allow the tool to watch different events on differ=
ent devices if they want to. Maybe client ID is a bad term and it misleads =
you. I should call it register ID.

Regards,
Amber

From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Tuesday, April 14, 2020 7:04 PM
To: Lin, Amber <Amber.Lin@amd.com>; amd-gfx@lists.freedesktop.org
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

--_000_BN8PR12MB30418878CCC5D2FE5103248DE1DB0BN8PR12MB3041namp_
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
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:711004651;
	mso-list-template-ids:506200590;}
@list l1
	{mso-list-id:841353468;
	mso-list-template-ids:-1447530186;}
@list l1:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Felix,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">That was my assumption too that each registration wi=
ll get different file descriptor, but it turns out not. When I started two =
process and both register gpu0 and gpu1, they both got fd=3D15. If I have p=
rocess A register gpu0&#43;gpu1, and process
 B only register gpu0, process A gets fd=3D15 and process B gets fd=3D9. Th=
at&#8217;s why I added client ID.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">By multiple clients, I mean multiple processes. The =
ask is users want to have multiple tools and those different tools can use =
rsmi lib to watch events at the same time. Due to the reason above that two=
 processes can actually get the same
 fd and I need to add client ID to distinguish the registration, I don&#821=
7;t see the point of limiting one registration per process unless I use pid=
 to distinguish the client instead, which was in my consideration too when =
I was writing the code. But second thought
 is why adding this restriction when client ID can allow the tool to watch =
different events on different devices if they want to. Maybe client ID is a=
 bad term and it misleads you. I should call it register ID.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Amber<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.=
com&gt; <br>
<b>Sent:</b> Tuesday, April 14, 2020 7:04 PM<br>
<b>To:</b> Lin, Amber &lt;Amber.Lin@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
<b>Subject:</b> Re: [PATCH v4] drm/amdkfd: Provide SMI events watch<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p>Hi Amber,<o:p></o:p></p>
<p>Some general remarks about the multi-client support. You added a global =
client id that's separate from the file descriptor. That's problematic for =
two reasons:<o:p></o:p></p>
<ol start=3D"1" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-=
alt:auto;mso-list:l1 level1 lfo3">
A process could change a different process' event mask<o:p></o:p></li><li c=
lass=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-alt:a=
uto;mso-list:l1 level1 lfo3">
The FD should already be unique per process, no need to invent another ID<o=
:p></o:p></li></ol>
<p>If we want to allow one process to register for events multiple times (m=
ultiple FDs per process), then the list of clients should be per process. E=
ach process should only be allowed to change the event masks of its own cli=
ents. The client could be identified
 by its FD. No need for another client ID.<o:p></o:p></p>
<p>But you could also simplify it further by allowing only one event client=
 per process. Then you don't need the client ID lookup at all. Just have a =
single event client in the kfd_process.<o:p></o:p></p>
<p>Another approach would be to make enable/disable functions of the event =
FD, rather than the KFD FD ioctl. It could be an ioctl of the event FD, or =
even simpler, you could use the write file-operation to write an event mask=
 (of arbitrary length if you want
 to enable growth in the future). That way everything would be neatly encap=
sulated in the event FD private data.<o:p></o:p></p>
<p>Two more comments inline ...<o:p></o:p></p>
<p><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Am 2020-04-14 um 5:30 p.m. schrieb Amber Lin:<o:p></=
o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>When the compute is malfunctioning or performance drops, the system ad=
min<o:p></o:p></pre>
<pre>will use SMI (System Management Interface) tool to monitor/diagnostic =
what<o:p></o:p></pre>
<pre>went wrong. This patch provides an event watch interface for the user<=
o:p></o:p></pre>
<pre>space to register devices and subscribe events they are interested. Af=
ter<o:p></o:p></pre>
<pre>registered, the user can use annoymous file descriptor's poll function=
<o:p></o:p></pre>
<pre>with wait-time specified and wait for events to happen. Once an event<=
o:p></o:p></pre>
<pre>happens, the user can use read() to retrieve information related to th=
e<o:p></o:p></pre>
<pre>event.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>VM fault event is done in this patch.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>v2: - remove UNREGISTER and add event ENABLE/DISABLE<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp; - correct kfifo usage<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp; - move event message API to kfd_ioctl.h<o:p></o:p><=
/pre>
<pre>v3: send the event msg in text than in binary<o:p></o:p></pre>
<pre>v4: support multiple clients<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Signed-off-by: Amber Lin <a href=3D"mailto:Amber.Lin@amd.com">&lt;Ambe=
r.Lin@amd.com&gt;</a><o:p></o:p></pre>
</blockquote>
<p>[snip]<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_i=
octl.h<o:p></o:p></pre>
<pre>index 4f66764..8146437 100644<o:p></o:p></pre>
<pre>--- a/include/uapi/linux/kfd_ioctl.h<o:p></o:p></pre>
<pre>&#43;&#43;&#43; b/include/uapi/linux/kfd_ioctl.h<o:p></o:p></pre>
<pre>@@ -442,6 &#43;442,36 @@ struct kfd_ioctl_import_dmabuf_args {<o:p></o=
:p></pre>
<pre>&nbsp; __u32 dmabuf_fd;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD =
*/<o:p></o:p></pre>
<pre> };<o:p></o:p></pre>
<pre> <o:p></o:p></pre>
<pre>&#43;/*<o:p></o:p></pre>
<pre>&#43; * KFD SMI(System Management Interface) events<o:p></o:p></pre>
<pre>&#43; */<o:p></o:p></pre>
<pre>&#43;enum kfd_smi_events_op {<o:p></o:p></pre>
<pre>&#43; KFD_SMI_EVENTS_REGISTER =3D 1,<o:p></o:p></pre>
<pre>&#43; KFD_SMI_EVENTS_ENABLE,<o:p></o:p></pre>
<pre>&#43; KFD_SMI_EVENTS_DISABLE<o:p></o:p></pre>
<pre>&#43;};<o:p></o:p></pre>
<pre>&#43;<o:p></o:p></pre>
<pre>&#43;/* Event type (defined by bitmask) */<o:p></o:p></pre>
<pre>&#43;#define KFD_SMI_EVENT_VMFAULT&nbsp;&nbsp;&nbsp;&nbsp; 0x000000000=
0000001<o:p></o:p></pre>
<pre>&#43;<o:p></o:p></pre>
<pre>&#43;struct kfd_ioctl_smi_events_args {<o:p></o:p></pre>
<pre>&#43; __u32 op;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<o:p></o:p></pre>
<pre>&#43; __u64 events;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* to KFD */<o:p></o:p></pre>
</blockquote>
<p>The binary layout of the ioctl args structure should be the same on 32/6=
4-bit. That means the 64-bit members should be 64-bit aligned. The best way=
 to ensure this is to put all the 64-bit members first.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre>&#43; __u64 gpuids_array_ptr;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* to KFD */<o:p></o:p></pre>
<pre>&#43; __u32 num_gpuids;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<o:p=
></o:p></pre>
<pre>&#43; __u32 anon_fd;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /=
* from KFD */<o:p></o:p></pre>
<pre>&#43; __u32 client_id;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to/from =
KFD */<o:p></o:p></pre>
<pre>&#43;};<o:p></o:p></pre>
<pre>&#43;<o:p></o:p></pre>
<pre>&#43;/* 1. All messages must start with (hex)uint64_event(16) &#43; sp=
ace(1) &#43;<o:p></o:p></pre>
<pre>&#43; *&nbsp;&nbsp;&nbsp; (hex)gpuid(8) &#43; space(1) =3D&nbsp; 26 by=
tes<o:p></o:p></pre>
<pre>&#43; * 2. VmFault msg =3D (hex)uint32_pid(8) &#43; space(1) &#43; tas=
k name(16) =3D 25<o:p></o:p></pre>
<pre>&#43; *&nbsp;&nbsp;&nbsp; When a new event msg uses more memory, chang=
e the calculation here.<o:p></o:p></pre>
<pre>&#43; * 3. End with \n(1)<o:p></o:p></pre>
<pre>&#43; * 26 &#43; 25 &#43; 1 =3D 52<o:p></o:p></pre>
<pre>&#43; */<o:p></o:p></pre>
<pre>&#43;#define KFD_SMI_MAX_EVENT_MSG 52<o:p></o:p></pre>
</blockquote>
<p>If you define the maximum message length here, clients may start dependi=
ng on it, and it gets harder to change it later. I'd not define this in the=
 API header. It's not necessary to write correct clients. And if used badly=
, it may encourage writing incorrect
 clients that break with longer messages in the future.<o:p></o:p></p>
<p>Regards,<br>
&nbsp; Felix<o:p></o:p></p>
<p><o:p>&nbsp;</o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre>&#43;<o:p></o:p></pre>
<pre> /* Register offset inside the remapped mmio page<o:p></o:p></pre>
<pre>&nbsp; */<o:p></o:p></pre>
<pre> enum kfd_mmio_remap {<o:p></o:p></pre>
<pre>@@ -546,7 &#43;576,10 @@ enum kfd_mmio_remap {<o:p></o:p></pre>
<pre> #define AMDKFD_IOC_ALLOC_QUEUE_GWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1E, struct k=
fd_ioctl_alloc_queue_gws_args)<o:p></o:p></pre>
<pre> <o:p></o:p></pre>
<pre>&#43;#define AMDKFD_IOC_SMI_EVENTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></=
pre>
<pre>&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1F, stru=
ct kfd_ioctl_smi_events_args)<o:p></o:p></pre>
<pre>&#43;<o:p></o:p></pre>
<pre> #define AMDKFD_COMMAND_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x01<o:p></o:p></pre>
<pre>-#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1F<o:p></o:p></pre>
<pre>&#43;#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x20<o:p></o:p></pre>
<pre> <o:p></o:p></pre>
<pre>&nbsp;#endif<o:p></o:p></pre>
</blockquote>
</div>
</body>
</html>

--_000_BN8PR12MB30418878CCC5D2FE5103248DE1DB0BN8PR12MB3041namp_--

--===============0235410490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0235410490==--

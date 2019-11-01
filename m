Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC91CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181D7217D9
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181D7217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6B16F876;
	Fri,  1 Nov 2019 20:50:05 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820041.outbound.protection.outlook.com [40.107.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4849E6F876
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 20:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I36AWFCuMNF53NI320nBaZwy2lycFJB9jrNCSnTXppT2Ar5ng0xYjMUohK4oEvupUoVdQIvodXEvKf1KA0Zd/myMLsTec6zXmMt4LYa6nql2HTg1eH08abtpYgWLRmRqs9OOPj997+TVkLJO5AiHdbOlYgE6R5MKr/zfBVtKF/oUJuNN/GeOgdigxrxaFL3EZxo7aNRw73uRLre6P1I6n/QdI9sNME+FZJSkXP8jM0bqPPZmXlsQPG/5gGaqbEGukL1Tv2OXXjibsZiPxkJqzxOy9iYIlWt5j1msF/SkosRVmzrR9Q4YSBuylXEm4XNUMbsVMvmxgoTUhWtiun2aZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhKfPPqtQh4GaN58NPaNAJMjX+0Lo8sjH3HKQrNrpUc=;
 b=MSAo38rT/0KJzqsmL3ikFBJBoAIu8pQtYoP9hQBSYhxRiOVUsT6jTjNRdV9BKiv4XWA8SNsemGQc/POL4h1rj1UAlTYZULzfRfUqcu5Mvfnn/5ii3INPgB7hb8F1lpQw9SvazzRfTskmLvrL9MQcQdRQ1vpVEodAY6ZELlcPVZDIWpBWgaXxhOcDeJkYKJAWCRQFqQGr1mzYOuDjk87Hrvp0LvPGl8LUMwzokrlGpP1ErAERxV9+AN6DDoJfB3bI2NO+rRkVhdC2sMqblySM3CRlnZCKZO2RrCx+Xam2hZNUH/yLUkiSwMj2dYtjChc5JCngc1mYGtxHWgOrKUNXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB4186.namprd12.prod.outlook.com (10.141.186.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.18; Fri, 1 Nov 2019 20:50:03 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 20:50:03 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVkPCZFRJsMCOEZkSsXpsspPuRW6d2yaRa
Date: Fri, 1 Nov 2019 20:50:02 +0000
Message-ID:
 <DM6PR12MB2778D1D6CA1EAE57D77078BCF0620@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191101201138.6125-1-Yong.Zhao@amd.com>
In-Reply-To: <20191101201138.6125-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2607:fea8:209f:ebca:3c32:f60f:1ad3:cb3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21fac007-e032-4ee4-7086-08d75f0d1192
x-ms-traffictypediagnostic: DM6PR12MB4186:
x-microsoft-antispam-prvs: <DM6PR12MB41860051B5225C9387DA2152F0620@DM6PR12MB4186.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(11346002)(446003)(7736002)(2906002)(256004)(25786009)(14444005)(33656002)(71200400001)(81166006)(316002)(8676002)(6116002)(81156014)(71190400001)(19627405001)(2351001)(14454004)(66446008)(66476007)(66556008)(8936002)(64756008)(76116006)(66946007)(229853002)(478600001)(52536014)(476003)(74316002)(6246003)(105004)(486006)(76176011)(55016002)(2501003)(7696005)(54896002)(9686003)(5660300002)(102836004)(5640700003)(186003)(6436002)(6506007)(46003)(6916009)(99286004)(53546011)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4186;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoQ9c59uSLX5OGfbm9EG+9B1ER5mkYSIU6Nq9f8AYGLzPs1QC7wAlNzkSRUBVUncqW15L/r0uDyWKNoJf8rFKAbTU9unybAoQU6wmLbEvu3QOmlQw1S9WiHu7Ad3wimP7NzSSvWjhQ1imYPs+ccDqF+r0iiDDI71P2pvqMLq8urMdE2/fUZ/3IoGRie2NhQWivnV/qNtnlxqGgwAXkR87KRSRKxpKhg4gVrhOI84fOxb7Z+j3lhyAC7qcyaYElOlYkkWkGglltta6PWQKFqNrgjvxBTk0o/XbES15NNwTeEa9A9fRekrWRyh39jRhsSpS+33r0xx+PqeWWP7osWnej+HezlPD7/mrbcTtO2ZSuWNw1pdWpzWbomXdsWd7vXX0sFM2UUQiylPnAQXjN/7KQ9vzQsV7R9n2uc+SDyIis7i46fOsEHRkVmjAOnlRS6G
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fac007-e032-4ee4-7086-08d75f0d1192
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 20:50:02.8858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AN1ot+j77KuFDmaYTA4kAL4WmAQeLcNgn2xUinpE65BFTKps29AZsH0BhcAhQCR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhKfPPqtQh4GaN58NPaNAJMjX+0Lo8sjH3HKQrNrpUc=;
 b=Sz4ceavOgnuvWUFSWTN/DJrDhtFc1dIQRsFl/IfsSEE6mjFyd1Wg29bvI0OJfJltyU1gePlM5jG3WmlWasmW+u0WGEea8yMTgylGCvsYlV2kA7cfIA+jm2/1S0T+K22j/uomiGP5AiGzQHwGjc3l2NYBKn18rFQTSEmssKR51Jo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============0254696827=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101205002.WSCA4BC6Km_fyCKLkmhYS8n4KQgcUr6QaMbrGdoKD4s@z>

--===============0254696827==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778D1D6CA1EAE57D77078BCF0620DM6PR12MB2778namp_"

--_000_DM6PR12MB2778D1D6CA1EAE57D77078BCF0620DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please discard this one and look for an update version.

Regards,
Yong
________________________________
From: Zhao, Yong <Yong.Zhao@amd.com>
Sent: Friday, November 1, 2019 4:11 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Yong <Yong.Zhao@amd.com>
Subject: [PATCH] drm/amdkfd: Simplify the mmap offset related bit operation=
s

The new code is much cleaner and results in better readability.

Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 ++++------
 drivers/gpu/drm/amd/amdkfd/kfd_events.c  |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 +++------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +--
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index b91993753b82..34078df36621 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -298,7 +298,6 @@ static int kfd_ioctl_create_queue(struct file *filep, s=
truct kfd_process *p,
         /* Return gpu_id as doorbell offset for mmap usage */
         args->doorbell_offset =3D KFD_MMAP_TYPE_DOORBELL;
         args->doorbell_offset |=3D KFD_MMAP_GPU_ID(args->gpu_id);
-       args->doorbell_offset <<=3D PAGE_SHIFT;
         if (KFD_IS_SOC15(dev->device_info->asic_family))
                 /* On SOC15 ASICs, include the doorbell offset within the
                  * process doorbell frame, which could be 1 page or 2 page=
s.
@@ -1938,20 +1937,19 @@ static int kfd_mmap(struct file *filp, struct vm_ar=
ea_struct *vma)
 {
         struct kfd_process *process;
         struct kfd_dev *dev =3D NULL;
-       unsigned long vm_pgoff;
+       unsigned long mmap_offset;
         unsigned int gpu_id;

         process =3D kfd_get_process(current);
         if (IS_ERR(process))
                 return PTR_ERR(process);

-       vm_pgoff =3D vma->vm_pgoff;
-       vma->vm_pgoff =3D KFD_MMAP_OFFSET_VALUE_GET(vm_pgoff);
-       gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgoff);
+       mmap_offset =3D vma->vm_pgoff << PAGE_SHIFT;
+       gpu_id =3D KFD_MMAP_GET_GPU_ID(mmap_offset);
         if (gpu_id)
                 dev =3D kfd_device_by_id(gpu_id);

-       switch (vm_pgoff & KFD_MMAP_TYPE_MASK) {
+       switch (mmap_offset & KFD_MMAP_TYPE_MASK) {
         case KFD_MMAP_TYPE_DOORBELL:
                 if (!dev)
                         return -ENODEV;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index 908081c85de1..1f8365575b12 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -346,7 +346,6 @@ int kfd_event_create(struct file *devkfd, struct kfd_pr=
ocess *p,
                 ret =3D create_signal_event(devkfd, p, ev);
                 if (!ret) {
                         *event_page_offset =3D KFD_MMAP_TYPE_EVENTS;
-                       *event_page_offset <<=3D PAGE_SHIFT;
                         *event_slot_index =3D ev->event_id;
                 }
                 break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 66bae8f2dad1..8eecd2cd1fd2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -59,24 +59,21 @@
  * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, these
  *  defines are w.r.t to PAGE_SIZE
  */
-#define KFD_MMAP_TYPE_SHIFT    (62 - PAGE_SHIFT)
+#define KFD_MMAP_TYPE_SHIFT    (62)
 #define KFD_MMAP_TYPE_MASK      (0x3ULL << KFD_MMAP_TYPE_SHIFT)
 #define KFD_MMAP_TYPE_DOORBELL  (0x3ULL << KFD_MMAP_TYPE_SHIFT)
 #define KFD_MMAP_TYPE_EVENTS    (0x2ULL << KFD_MMAP_TYPE_SHIFT)
 #define KFD_MMAP_TYPE_RESERVED_MEM      (0x1ULL << KFD_MMAP_TYPE_SHIFT)
 #define KFD_MMAP_TYPE_MMIO      (0x0ULL << KFD_MMAP_TYPE_SHIFT)

-#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)
+#define KFD_MMAP_GPU_ID_SHIFT (46)
 #define KFD_MMAP_GPU_ID_MASK (((1ULL << KFD_GPU_ID_HASH_WIDTH) - 1) \
                                 << KFD_MMAP_GPU_ID_SHIFT)
 #define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) << KFD_MMAP_GPU_ID_SH=
IFT)\
                                 & KFD_MMAP_GPU_ID_MASK)
-#define KFD_MMAP_GPU_ID_GET(offset)    ((offset & KFD_MMAP_GPU_ID_MASK) \
+#define KFD_MMAP_GET_GPU_ID(offset)    ((offset & KFD_MMAP_GPU_ID_MASK) \
                                 >> KFD_MMAP_GPU_ID_SHIFT)

-#define KFD_MMAP_OFFSET_VALUE_MASK     (0x3FFFFFFFFFFFULL >> PAGE_SHIFT)
-#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset & KFD_MMAP_OFFSET_VALUE_=
MASK)
-
 /*
  * When working with cp scheduler we should assign the HIQ manually or via
  * the amdgpu driver to a fixed hqd slot, here are the fixed HIQ hqd slot
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 6abfb77ae540..39dc49b8fd85 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -554,8 +554,7 @@ static int kfd_process_init_cwsr_apu(struct kfd_process=
 *p, struct file *filep)
                 if (!dev->cwsr_enabled || qpd->cwsr_kaddr || qpd->cwsr_bas=
e)
                         continue;

-               offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(de=
v->id))
-                       << PAGE_SHIFT;
+               offset =3D KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev=
->id);
                 qpd->tba_addr =3D (int64_t)vm_mmap(filep, 0,
                         KFD_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,
                         MAP_SHARED, offset);
--
2.17.1


--_000_DM6PR12MB2778D1D6CA1EAE57D77078BCF0620DM6PR12MB2778namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please discard this one and look for an update version.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Yong &lt;Yong.Z=
hao@amd.com&gt;<br>
<b>Sent:</b> Friday, November 1, 2019 4:11 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Simplify the mmap offset related bit op=
erations</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The new code is much cleaner and results in better=
 readability.<br>
<br>
Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 &#43;&#43;&#43;&#43;---=
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_events.c&nbsp; |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#4=
3;&#43;&#43;------<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c |&nbsp; 3 &#43;--<br>
&nbsp;4 files changed, 8 insertions(&#43;), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index b91993753b82..34078df36621 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -298,7 &#43;298,6 @@ static int kfd_ioctl_create_queue(struct file *file=
p, struct kfd_process *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Return gpu_id as doorbe=
ll offset for mmap usage */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset =
=3D KFD_MMAP_TYPE_DOORBELL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset |=
=3D KFD_MMAP_GPU_ID(args-&gt;gpu_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset &lt;&lt;=3D =
PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_IS_SOC15(dev-&gt;d=
evice_info-&gt;asic_family))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* On SOC15 ASICs, include the doorbell offset within=
 the<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * process doorbell frame, which could be 1 page=
 or 2 pages.<br>
@@ -1938,20 &#43;1937,19 @@ static int kfd_mmap(struct file *filp, struct v=
m_area_struct *vma)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *proces=
s;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D NU=
LL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long vm_pgoff;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long mmap_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int gpu_id;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process =3D kfd_get_proces=
s(current);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(process))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return PTR_ERR(process);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_pgoff =3D vma-&gt;vm_pgoff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_pgoff =3D KFD_MMAP_OFFSET_=
VALUE_GET(vm_pgoff);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgo=
ff);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_offset =3D vma-&gt;vm_pgoff =
&lt;&lt; PAGE_SHIFT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D KFD_MMAP_GET_GPU_ID(mm=
ap_offset);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev =3D kfd_device_by_id(gpu_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (vm_pgoff &amp; KFD_MMAP_TYPE_=
MASK) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mmap_offset &amp; KFD_MMA=
P_TYPE_MASK) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_MMAP_TYPE_DOORBEL=
L:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENODEV;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c<br>
index 908081c85de1..1f8365575b12 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
@@ -346,7 &#43;346,6 @@ int kfd_event_create(struct file *devkfd, struct kf=
d_process *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D create_signal_event(devkfd, p, ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *even=
t_page_offset =3D KFD_MMAP_TYPE_EVENTS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *event_page_offs=
et &lt;&lt;=3D PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *even=
t_slot_index =3D ev-&gt;event_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 66bae8f2dad1..8eecd2cd1fd2 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -59,24 &#43;59,21 @@<br>
&nbsp; * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, =
these<br>
&nbsp; *&nbsp; defines are w.r.t to PAGE_SIZE<br>
&nbsp; */<br>
-#define KFD_MMAP_TYPE_SHIFT&nbsp;&nbsp;&nbsp; (62 - PAGE_SHIFT)<br>
&#43;#define KFD_MMAP_TYPE_SHIFT&nbsp;&nbsp;&nbsp; (62)<br>
&nbsp;#define KFD_MMAP_TYPE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x3ULL &lt;=
&lt; KFD_MMAP_TYPE_SHIFT)<br>
&nbsp;#define KFD_MMAP_TYPE_DOORBELL&nbsp; (0x3ULL &lt;&lt; KFD_MMAP_TYPE_S=
HIFT)<br>
&nbsp;#define KFD_MMAP_TYPE_EVENTS&nbsp;&nbsp;&nbsp; (0x2ULL &lt;&lt; KFD_M=
MAP_TYPE_SHIFT)<br>
&nbsp;#define KFD_MMAP_TYPE_RESERVED_MEM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x1=
ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&nbsp;#define KFD_MMAP_TYPE_MMIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x0ULL &lt;=
&lt; KFD_MMAP_TYPE_SHIFT)<br>
&nbsp;<br>
-#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)<br>
&#43;#define KFD_MMAP_GPU_ID_SHIFT (46)<br>
&nbsp;#define KFD_MMAP_GPU_ID_MASK (((1ULL &lt;&lt; KFD_GPU_ID_HASH_WIDTH) =
- 1) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt; KFD_MMAP_GPU_ID_SHIFT)<=
br>
&nbsp;#define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) &lt;&lt; KFD_MMA=
P_GPU_ID_SHIFT)\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; KFD_MMAP_GPU_ID_MASK)<br>
-#define KFD_MMAP_GPU_ID_GET(offset)&nbsp;&nbsp;&nbsp; ((offset &amp; KFD_M=
MAP_GPU_ID_MASK) \<br>
&#43;#define KFD_MMAP_GET_GPU_ID(offset)&nbsp;&nbsp;&nbsp; ((offset &amp; K=
FD_MMAP_GPU_ID_MASK) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; KFD_MMAP_GPU_ID_SHIFT)<=
br>
&nbsp;<br>
-#define KFD_MMAP_OFFSET_VALUE_MASK&nbsp;&nbsp;&nbsp;&nbsp; (0x3FFFFFFFFFFF=
ULL &gt;&gt; PAGE_SHIFT)<br>
-#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset &amp; KFD_MMAP_OFFSET_VA=
LUE_MASK)<br>
-<br>
&nbsp;/*<br>
&nbsp; * When working with cp scheduler we should assign the HIQ manually o=
r via<br>
&nbsp; * the amdgpu driver to a fixed hqd slot, here are the fixed HIQ hqd =
slot<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index 6abfb77ae540..39dc49b8fd85 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -554,8 &#43;554,7 @@ static int kfd_process_init_cwsr_apu(struct kfd_pro=
cess *p, struct file *filep)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;cwsr_enabled || qpd-&gt;cwsr_kaddr || qp=
d-&gt;cwsr_base)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev-&gt=
;id))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt; PAGE_SH=
IFT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; offset =3D KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev-=
&gt;id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; qpd-&gt;tba_addr =3D (int64_t)vm_mmap(filep, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_C=
WSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAP_S=
HARED, offset);<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778D1D6CA1EAE57D77078BCF0620DM6PR12MB2778namp_--

--===============0254696827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0254696827==--

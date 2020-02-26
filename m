Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0520BC4BA24
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 20:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B072072D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 20:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TnDMaJvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B072072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213626EBD3;
	Wed, 26 Feb 2020 20:34:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 807DE6EBC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 20:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIQUfFT5CM9j8XKWrwUi3ydJxxEHeWYrhItawFj2RcaRncdCrw1vrAuhreALqSY4O33TafTGbeF1kCxtLxCDNjXiUAIxaQsKOrsEM0/E5n1lSSVXvohLg1Fc9Jdln5b9dMyWwZraDVmbvFOYAReGIHOP9yQABvrZZmxmK/6LwRt/aNjmF13PlfylNZx5gH+QHY0DfYsxLlRcclmLoWQfHGCD1gy/4z8j/ZIS7onIUyg7iLdcKwKv3KFbDu5yAgi8dmaZzaKSQYG0gHk58dPO0+6WnH+/QK27gqP+3CM/D/vS4of0Xj8P6M9Vl7iPVzO1b6/1g1OIlt656kqtpdcdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mojQ0HlYY6sIoTvC0DHwNNgTMG+bpnymhMvSiDeQOiY=;
 b=lkxLVxJ1UPYygHPSZv4b+8MeCkmwT4FXnNYU4h7DFy9PCxrdlV8nNK29hWz7rDqQlZdWjJTiXMtYr0bFM/Bf/9ONt48Oa8/ZtgW5cNcgkkg3B3ZMV2Cg5t0Y/z/ywWuNPOHbhakwevROW9YcldAVypx+8Sy1jPEZslxj4eLo1DsraVoXp8ld0uCvaqa2I3dpfdWGL9+mzRppJL6zAaa36+yeiT0p/hP+MOUXN0dItueyNzFlDE8HtbUfmVRzB3ZnKJJFEk7nMSlBZWKhF9K4KpZWBOf0jwBVbUm58AkEpg03XG02TEIJT75aSCW655pRC6hbLuV65udNMJZUkAD7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mojQ0HlYY6sIoTvC0DHwNNgTMG+bpnymhMvSiDeQOiY=;
 b=TnDMaJvJA3nYS/PB/PqSW/LSrwGJ2YsITlkjgCABb7RKtb2OZ5KpA8UPc+66wCK2IpatbCMmPtcizcAmWRlGImraiRV9Jv/JtnB8KM334iHXFVKzJOuHBuPAQnPl38BcNvWbHL/rC8zfQVZYUpWbVA9YmqqHelIKugKQIaoH5X4=
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Wed, 26 Feb
 2020 20:34:36 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 20:34:36 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: change SDMA MQD memory type
Thread-Topic: [PATCH] drm/amdkfd: change SDMA MQD memory type
Thread-Index: AQHV7NwtRjXvFZ2iM0yedv8VEkQGRagt6KyR
Date: Wed, 26 Feb 2020 20:34:36 +0000
Message-ID: <CH2PR12MB3926359C63F8D67DFD40C9A6F0EA0@CH2PR12MB3926.namprd12.prod.outlook.com>
References: <1582745831-6902-1-git-send-email-JinhuiEric.Huang@amd.com>
In-Reply-To: <1582745831-6902-1-git-send-email-JinhuiEric.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-26T20:34:34.686Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd24d694-3a74-4e40-895d-08d7bafb4b8d
x-ms-traffictypediagnostic: CH2PR12MB3848:|CH2PR12MB3848:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3848A133BA6E8CF5E89655F8F0EA0@CH2PR12MB3848.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(55016002)(9686003)(45080400002)(66946007)(66446008)(966005)(478600001)(19627405001)(186003)(66556008)(2906002)(76116006)(26005)(6506007)(52536014)(64756008)(33656002)(53546011)(66476007)(7696005)(5660300002)(81166006)(110136005)(86362001)(316002)(71200400001)(8676002)(81156014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3848;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7irSLjQEtAQNWo5LrsFGU97lsEYMGwFcfGrSN1dyQHfjZvqJYym3ZdEGr/ygc3K+l5nOkYfC8d81GV6fqMn0BjeFnEAG2HFHY0vSz0UpM+Ajljd9z/ruDhPCBfJWKZitWLPI6PhHschXb5rXVK/e/GJIibvjN6jqga8oT7e+atikRccoS4cvllEtohclzmkgY7/rvhMajnrvPkD+XuncnCqNwIPRF8ipBfrxYcTlwGuBFaYt6iABooSNc2t87yaLI+IP8WJxticLnOJ37mdF8pBMqFUk8yT6jJMx9ZdmxMjLWZj5r+xvAPSCVaGM5uv/btQQ24zwrTH0jLng8jOtQHcC701QdL7qBvYakRuUhF7mSbIXm3Gb7YvSi39eBBO+W2+ayYOQCMItwfT1JdVvQc29aEWWgt4zrGgMPbzhvCFv2X112Y1DejJ7XhmNWWe1hejZNJwa5hWqy0zZeCDsoJnkTttFBQLxS2Shixm9+TmWkc1+UMUuTbHw4iINsRWH7w22y0DR+nMRDLSo/GDRuw==
x-ms-exchange-antispam-messagedata: DCV0ZwNAm3xDQcC2GvTh/l4TRI53CKxykDPbgJ1OANqruYHIXTqLsAa0qKrqSK2SDUXbAVqts0Zn3tu92nvvoM42wdpE5hi8XMu0ZfhJhiYPLYnNk5XggGvCP3PdiJOX1VuFeVDPxnHmGBSJZHGP+Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd24d694-3a74-4e40-895d-08d7bafb4b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 20:34:36.1080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfJbDM+a3xc2W6HLwUmKgntL22F0sviFa2a3nsBPsCJ0XPMas+a0w/fa1dhaCb9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Content-Type: multipart/mixed; boundary="===============1462784168=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1462784168==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3926359C63F8D67DFD40C9A6F0EA0CH2PR12MB3926namp_"

--_000_CH2PR12MB3926359C63F8D67DFD40C9A6F0EA0CH2PR12MB3926namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

It looks good to me. I was thinking maybe we should go one step further, ad=
ding more explanation comments around the MQD control stack workaround, so =
that people have a clearer idea of what's that MQD control stack workaround=
 is about. We can do that in a following commit.

Acked-by: Yong Zhao <Yong.Zhao@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Eric Hua=
ng <JinhuiEric.Huang@amd.com>
Sent: Wednesday, February 26, 2020 2:37 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Subject: [PATCH] drm/amdkfd: change SDMA MQD memory type

SDMA MQD memory type is NC that causes MQD data overwritten
accidentally by an old stable cache line. Changing it to UC
default for GART will fix the issue.

Change-Id: If609f47c78cb97e2c8dc930df2ab5c10c29dfe56
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 692abfd..77ea0f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1734,7 +1734,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_=
manager *dqm)

         retval =3D amdgpu_amdkfd_alloc_gtt_mem(dev->kgd, size,
                 &(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
-               (void *)&(mem_obj->cpu_ptr), true);
+               (void *)&(mem_obj->cpu_ptr), false);

         return retval;
 }
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cyong.zha=
o%40amd.com%7C2cbbb3322952475590f508d7baf34ce6%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637183426468344453&amp;sdata=3D2zCqxZJFXSbBlezU7UIZxc%2FQC=
0PBTum90MmIjCioHGw%3D&amp;reserved=3D0

--_000_CH2PR12MB3926359C63F8D67DFD40C9A6F0EA0CH2PR12MB3926namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">It
 looks good to me. I was thinking maybe we should go one step further, addi=
ng more explanation comments around the MQD control stack workaround, so th=
at people have a clearer idea of what's that
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255, 2=
55, 255); display: inline !important">
MQD control stack<span>&nbsp;</span></span>workaround is about. We can do t=
hat in a following commit.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">Acked-by:
 Yong Zhao &lt;Yong.Zhao@amd.com&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Eric Huang &lt;JinhuiEric.Hua=
ng@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 26, 2020 2:37 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: change SDMA MQD memory type</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">SDMA MQD memory type is NC that causes MQD data ov=
erwritten<br>
accidentally by an old stable cache line. Changing it to UC<br>
default for GART will fix the issue.<br>
<br>
Change-Id: If609f47c78cb97e2c8dc930df2ab5c10c29dfe56<br>
Signed-off-by: Eric Huang &lt;jinhuieric.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index 692abfd..77ea0f0 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -1734,7 &#43;1734,7 @@ static int allocate_hiq_sdma_mqd(struct device_qu=
eue_manager *dqm)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D amdgpu_amdkfd_a=
lloc_gtt_mem(dev-&gt;kgd, size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &amp;(mem_obj-&gt;gtt_mem), &amp;(mem_obj-&gt;gpu_add=
r),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (void *)&amp;(mem_obj-&gt;cpu_ptr), true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (void *)&amp;(mem_obj-&gt;cpu_ptr), false);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&nbsp;}<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cyong.zhao%40amd.com%7C2cbbb3322952475590f508d7baf34ce6%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637183426468344453&amp;amp;sdata=3D2zCqxZJF=
XSbBlezU7UIZxc%2FQC0PBTum90MmIjCioHGw%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cyong.zhao%40amd.=
com%7C2cbbb3322952475590f508d7baf34ce6%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637183426468344453&amp;amp;sdata=3D2zCqxZJFXSbBlezU7UIZxc%2FQC0PBT=
um90MmIjCioHGw%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3926359C63F8D67DFD40C9A6F0EA0CH2PR12MB3926namp_--

--===============1462784168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1462784168==--

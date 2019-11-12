Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DECFC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E588220818
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E588220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB256E527;
	Tue, 12 Nov 2019 21:14:53 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800058.outbound.protection.outlook.com [40.107.80.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442FE6E527
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 21:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okxrx428SvCT4CdOCge7KnlvjlFUwwh+xLzldkISZEAInNwaf1+3w5bfFbBn5+9GfKpaF4DQ7Ixq5rf6jLy8kd+VWCRknvwY6nJGBqD3BrENlmpItpuqcv9zIL42d2B3cgnq5gEngxj3/lPwirauZaR7qvsIdG5Zn1DltUAj9iRC5DTLnbYm4sl+3MTsBVbLGl5g+km5ArAA0BKhKf4f8CJXzAQGamdRJeVWczF9wNH0XHqrHLii9b63vMrrNB9/IdtsWEsgURA3N9dDACOmb5s3ZR7JR1X5MDgTCeP3JKY8/VM3uRmtbTIZOMccJF0u4QpVO4f1J6NicObz7RPoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRFh7Dct9XHwc5jj6qK+teAGyNILfwxyYEtFIfWsp8E=;
 b=YfF7daAH1YiGXMGEYvfw/XhznIt62377w8FFQCtbA66NhKfZlwwvT56nh9b0Q3n3EPJvFGNG9S+Xa6WGZtAAlsUryyvGCyzWjywjwDvqlhDxZ+Z0EcmkfPZl8daOHHlgbPzRq+sNSeh8T3d+KMD9dN5qNfopGjdMjxGv/AUsCbvMqCWyJYiWxchC2QHTxdAk96cna33NN6njQhZO1g+WhrpBQk90pnfdh2Nn8ZuJe7cSacZovVbSa6G9oSvzT5UvjhHaC4dcsJXisBV/JTepcc/9uJ9YEsHjwvElCBpC6iGATRsPBSJd5VAWPMYJQDuE7f9ktRXkQ6570Cmw3MtFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3450.namprd12.prod.outlook.com (20.178.29.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 21:14:50 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 21:14:50 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Morichetti, Laurent"
 <Laurent.Morichetti@amd.com>
Subject: Re: [PATCH 3/3] drm/amdkfd: Fix a bug when calculating
 save_area_used_size
Thread-Topic: [PATCH 3/3] drm/amdkfd: Fix a bug when calculating
 save_area_used_size
Thread-Index: AQHVmOdULwq1UzJ3KEqMtTnktpSy96eICohl
Date: Tue, 12 Nov 2019 21:14:50 +0000
Message-ID:
 <DM6PR12MB277837E8CD2700465A7AFE1CF0770@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191111232521.10528-1-Yong.Zhao@amd.com>,
 <20191111232521.10528-3-Yong.Zhao@amd.com>
In-Reply-To: <20191111232521.10528-3-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fdcb1339-3201-441c-91a8-08d767b55ac6
x-ms-traffictypediagnostic: DM6PR12MB3450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34508BD95FD82C91D27DBFD5F0770@DM6PR12MB3450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(66476007)(66556008)(53546011)(6116002)(3846002)(66946007)(8936002)(6506007)(99286004)(256004)(2906002)(102836004)(33656002)(66446008)(91956017)(14444005)(76116006)(71200400001)(71190400001)(486006)(2501003)(19627405001)(76176011)(64756008)(81166006)(26005)(8676002)(74316002)(52536014)(7696005)(7736002)(81156014)(186003)(110136005)(5660300002)(66066001)(316002)(86362001)(55016002)(478600001)(54896002)(9686003)(105004)(11346002)(229853002)(6636002)(446003)(6436002)(25786009)(476003)(6246003)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3450;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZB+JPH67UZz7aEiQE/uJlEQprkIBVz070JaJd07JZIXXjNehQxdcWfBorIevdHK4vMjkuenSJ1l5OMbeYnv38r46r2siDsXH/sR68LwoWXqReNwBXHD7J0M7CvzpAtfiytQp7xMUzguUhu7iZHEiz8+4cyFhfwz5la6KpbZ8i2txRpUTTDVG4VFv2Onn8iyl629CbHV98g3eSNDpHNQUitJdAfnZkifmxT3I/NBhLACtczNc/um2cys0HYaGn9LDRAKev6mJPWfpp5bfn32LncrMNyQ+Ud62XZ85inykZMkLbQtdd8Knw75HikAxOmt3EITZLxe0sZk5kQI7Fifs/EPoMXz6j4R3+qwDITjMlMyCtdFO72zAkIQKNI87gXQd4DViw5hoUW2CQsF6XOCpBytl2dMxrV4f1n/uHivdcpNyN3p40hp2CLggzws4w1o9
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcb1339-3201-441c-91a8-08d767b55ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 21:14:50.3989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mW+waso5CjkNbIQPfsrpG9C6tnqCRxnNxhuF/va4luIjww5HIBQ+AbmMYBnFufMm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3450
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRFh7Dct9XHwc5jj6qK+teAGyNILfwxyYEtFIfWsp8E=;
 b=r5ACwSE1logpkPIYysrjh6l8P6g4xtBb2WbXDfoTl783a6CmsVZvnIf4qRQ11WRFjgi2/8jELc7cKLV+z4Jsgm7Fr5ULmlqfumnqHMgbHrGUeziE28SoBdSX/Q8Az965e3cst4/s82Lz+/lRIULnt8+mfr3h6wazJufraishjqI=
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
Content-Type: multipart/mixed; boundary="===============0408743451=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112211450.1s_tOpg-MFIkj48cBQcvw5-Cx3sfhspNsIuOVExZluU@z>

--===============0408743451==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB277837E8CD2700465A7AFE1CF0770DM6PR12MB2778namp_"

--_000_DM6PR12MB277837E8CD2700465A7AFE1CF0770DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

+ Laurent
________________________________
From: Zhao, Yong <Yong.Zhao@amd.com>
Sent: Monday, November 11, 2019 6:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Cornwall=
, Jay <Jay.Cornwall@amd.com>
Cc: Zhao, Yong <Yong.Zhao@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Fix a bug when calculating save_area_used_=
size

workgroup context data writes from m->cp_hqd_cntl_stack_size, so we
should deduct it when calculating the used size.

Change-Id: I5252e25662c3b8221f451c39115bf084d1911eae
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c
index d3380c5bdbde..3a2ee1f01aae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -302,7 +302,8 @@ static int get_wave_state(struct mqd_manager *mm, void =
*mqd,

         *ctl_stack_used_size =3D m->cp_hqd_cntl_stack_size -
                 m->cp_hqd_cntl_stack_offset;
-       *save_area_used_size =3D m->cp_hqd_wg_state_offset;
+       *save_area_used_size =3D m->cp_hqd_wg_state_offset -
+               m->cp_hqd_cntl_stack_size;;

         if (copy_to_user(ctl_stack, mqd_ctl_stack, m->cp_hqd_cntl_stack_si=
ze))
                 return -EFAULT;
--
2.17.1


--_000_DM6PR12MB277837E8CD2700465A7AFE1CF0770DM6PR12MB2778namp_
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
&#43; Laurent</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Yong &lt;Yong.Z=
hao@amd.com&gt;<br>
<b>Sent:</b> Monday, November 11, 2019 6:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Cornwall, Jay &lt;Jay.Cornwall@amd.com&gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdkfd: Fix a bug when calculating save_are=
a_used_size</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">workgroup context data writes from m-&gt;cp_hqd_cn=
tl_stack_size, so we<br>
should deduct it when calculating the used size.<br>
<br>
Change-Id: I5252e25662c3b8221f451c39115bf084d1911eae<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
index d3380c5bdbde..3a2ee1f01aae 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
@@ -302,7 &#43;302,8 @@ static int get_wave_state(struct mqd_manager *mm, v=
oid *mqd,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ctl_stack_used_size =3D m=
-&gt;cp_hqd_cntl_stack_size -<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m-&gt;cp_hqd_cntl_stack_offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *save_area_used_size =3D m-&gt;cp_hqd=
_wg_state_offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *save_area_used_size =3D m-&gt;cp=
_hqd_wg_state_offset -<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; m-&gt;cp_hqd_cntl_stack_size;;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_to_user(ctl_stack=
, mqd_ctl_stack, m-&gt;cp_hqd_cntl_stack_size))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EFAULT;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB277837E8CD2700465A7AFE1CF0770DM6PR12MB2778namp_--

--===============0408743451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0408743451==--

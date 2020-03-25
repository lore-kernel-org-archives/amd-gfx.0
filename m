Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F363C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FB920714
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eyRbXgNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FB920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF0B96E7D9;
	Wed, 25 Mar 2020 10:28:39 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750083.outbound.protection.outlook.com [40.107.75.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536B36E7D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 10:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMCKuQfLzlnkoDiVQzHLe0TmVgBVu7wngoA41aGrFcNt7Fj9SwU99AWGj70zwGS3SDOCcpOgxLHRKHijX0JrfS2btXk/53NasQvYfLGbPnbyoLfS20GXprEEBn6WXSVYdgF+0ZTsslP/sO33f6liHrKYpSUfW+U+sm7o5DCAZEgKdBRmO9v+4Y9ln3VZET/2IyzTsp6LC9l9AVGUiG4iRg6OWlbt44GuBET5Gij/BNATKmwWvG6vAwodzIfTd2XoaiGIs3DvZ7EHaHSQGhlpnfPVGJz8pOt0kKvgFyaiTJveIX0Z+RVRbs9S+l7BmSLt8gkM4Yrtk11njQ2v8MikNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoKBNv6/62snGQa8cONZQzR/ecfrznqFxBEro8HD5+I=;
 b=SkKnRLjPrhGZ7gIrare2BsHPHKwmPJSqBJVFAvm8Zx5b+sZKSsLGC5Nz57+Kd6RMwX12gg6FpmbZiw/79dQN6lISofsLEmHcU3/2RKBfQI4ZOLh17kcK3I7v7TeLvBH8XE5ZKXcucxOhdLA/+TtsFZYo7BuUYpqCK8SpDzYag9Qg1mgIaetVcVLYdVTN0ocEp89aABk2RpuRCLg+p6mVN1c26Dqga2BNENo5rrbuj8Yi7ptwzRZ7WsBqNa8dfEBhvm3spj1VRDY1L9niB+8P37bqfirMbCzvegZKC4/VNe5DSM8JLexG1EXapLWPxCh9cSSDKX++4+t2i22Hl1MR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoKBNv6/62snGQa8cONZQzR/ecfrznqFxBEro8HD5+I=;
 b=eyRbXgNk4vjCwPZpod/N5LJ1lVMUybP5PuS+ZDLTgHT03mh5CsQVhndihjx5jcHTKHu4OTGz/YEKFWN7cIpxiqWg3uonzONRKuHR0UotAw37syA0X80rBAh8jjTlN8enBGWOYpjLHd0OLiUe/7pSHV7uoKRGIVUrYl7E0/sx3rg=
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1595.namprd12.prod.outlook.com (2603:10b6:4:3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Wed, 25 Mar 2020 10:28:36 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f%11]) with mapi id 15.20.2835.023; Wed, 25 Mar
 2020 10:28:36 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix hpd bo size calculation error
Thread-Topic: [PATCH] drm/amdgpu: fix hpd bo size calculation error
Thread-Index: AQHWAo7kCHU6oOQtcUmVFGnvDldr2KhZGytm
Date: Wed, 25 Mar 2020 10:28:36 +0000
Message-ID: <ddf95fc7-daa7-4df4-8610-bc6b1f5b6125@email.android.com>
References: <20200325101848.8524-1-kevin1.wang@amd.com>
In-Reply-To: <20200325101848.8524-1-kevin1.wang@amd.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-originating-ip: [2a02:908:1252:fb60:dc49:624f:5fe9:21c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4de7d913-d6bf-4afb-7ac3-08d7d0a74728
x-ms-traffictypediagnostic: DM5PR12MB1595:|DM5PR12MB1595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB15956800FE23C31C37E2DD3083CE0@DM5PR12MB1595.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(4326008)(5660300002)(186003)(316002)(6636002)(6862004)(31696002)(6506007)(478600001)(86362001)(31686004)(64756008)(66946007)(91956017)(6512007)(66556008)(71200400001)(9686003)(66476007)(76116006)(6486002)(81166006)(66446008)(54906003)(8676002)(81156014)(8936002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1595;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2KCzKUKXNUT4Mov/bMseUGsC0EuKgqypMvYkiXa8mvQOF6tmF6TFLe/XhHB72QxH4S3Tcpfrn3RNKoqk8eo1T/1Ohgq5464egUIbjLQ3vXET/8lUgcwIg2bKrUW8ciVal2EQf8er25226lXHdznQUNrfXY33uy7BNS3FqwIqLU7BjxbjxtOcnSzy8qX8ByW0+25KY1ekWhExNPeD/Pf/ri/JhsFP3c6ShUySxBKvHlIeFEloqZw3DsQhk8MfOXduzvCxI2KChLsGQFIHdfhv2rLybM2XY+eIv25W/k2acsmE2iPfAe3jVd2JTPkc8btc4ggcO+PMnuJLRIFJ+m8R9p3W/9ohu5JBD+QoFjWZARvmpjVPkE2+nJRL42ZyNUclJiBSXvM9gnkZ9g7YX2yl3zXsdS+DMVSFHOcr0x+rwN5vup7tTNu1VNZXxudcpHfZ
x-ms-exchange-antispam-messagedata: F+FFqI7dt1Pdt6xAkhVg8uk4L0eLvE57KGH1ppq8AxKrqCOWSpY2LnYA73H3Dnf+wMyeMe2CIVIe/mhvr92OFliPgxnSfBgm+I2S8xFLLB/janbTS1mI7tTOD6yh7enKwOIwvJ5uzUAKl0da7ltRRAD6TfJBv+2B2FkmXa5zAe/0zqsekOzX3g4Gdh+ACHr6rbC4dhci7sTCi9Jt9yVIjw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de7d913-d6bf-4afb-7ac3-08d7d0a74728
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 10:28:36.6486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fajt1jOL79UDkrnCH2y2NZDSjrCO222Ah00NnymZHuZirJQlaFQiSRsnW4Z+lYvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1595
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2028025240=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2028025240==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_ddf95fc7daa74df48610bc6b1f5b6125emailandroidcom_"

--_000_ddf95fc7daa74df48610bc6b1f5b6125emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Good catch! mem.size is actually the backing store size (usually in pages).

Patch is Acked-by: Christian K=F6nig <Christian.Koenig@amd.com>

Am 25.03.2020 11:19 schrieb "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>:
the HPD bo size calculation error.
the "mem.size" can't present actual BO size all time.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 7f9ac1a14e6f..91c82383b016 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1113,7 +1113,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *a=
dev)
                 return r;
         }

-       memset(hpd, 0, adev->gfx.mec.hpd_eop_obj->tbo.mem.size);
+       memset(hpd, 0, mec_hpd_size);

         amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
         amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index fb567cf5671b..01b22dad52fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1946,7 +1946,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *ad=
ev)
                 return r;
         }

-       memset(hpd, 0, adev->gfx.mec.hpd_eop_obj->tbo.mem.size);
+       memset(hpd, 0, mec_hpd_size);

         amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
         amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
--
2.17.1


--_000_ddf95fc7daa74df48610bc6b1f5b6125emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto">Good catch! mem.size is actually the backing store size (=
usually in pages).
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Patch is Acked-by: Christian K=F6nig &lt;Christian.Koenig=
@amd.com&gt;</div>
</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 25.03.2020 11:19 schrieb &quot;Wang, Kevin(=
Yang)&quot; &lt;Kevin1.Wang@amd.com&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">the HPD bo size calculation error.<br>
the &quot;mem.size&quot; can't present actual BO size all time.<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp; | 2 &#43;-<br>
&nbsp;2 files changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 7f9ac1a14e6f..91c82383b016 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -1113,7 &#43;1113,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, adev-&gt;gfx.mec.hpd_e=
op_obj-&gt;tbo.mem.size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, mec_hpd_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(adev-&gt;=
gfx.mec.hpd_eop_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(adev-&=
gt;gfx.mec.hpd_eop_obj);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index fb567cf5671b..01b22dad52fd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1946,7 &#43;1946,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, adev-&gt;gfx.mec.hpd_e=
op_obj-&gt;tbo.mem.size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, mec_hpd_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(adev-&gt;=
gfx.mec.hpd_eop_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(adev-&=
gt;gfx.mec.hpd_eop_obj);<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_ddf95fc7daa74df48610bc6b1f5b6125emailandroidcom_--

--===============2028025240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2028025240==--

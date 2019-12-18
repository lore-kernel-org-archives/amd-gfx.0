Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F196C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55DC218AC
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kTZTKQbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55DC218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912D589D5C;
	Wed, 18 Dec 2019 08:53:51 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700053.outbound.protection.outlook.com [40.107.70.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EF089D5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 08:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYUNkvPEi4OhGqMsedlPd7I4tp4VWEKGqzpUeVfB7XJwPgPzQOqVQX//5sgileJfFwccGQytJeKS+pMgNauP+LX+B3RZIuI2YTi3/IsNKhCp70hppw2435pTiinjFqrPLmwQ+u4Rdjk4AvB6I4voEIDEYSPanv/eWeiA6e3DsX8HmUJay1pvxv4WHZYHQpOsdHLKD5orb2wtv5LeRHkPSVSj4IJGsdeTW+QcxXOgEG5pL8MdOc+fS58k0DFiZjZftoF4ymfNJCU9r5RcuYsoGxnRqRazcNuYhwekjdsLYufRii7YkU0D0VYQR3uOBiKZ3TRSv1/fgdvlZ2ppQQ9sMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtK9xGM9EKNLqlcsAmUFFRx+DBCojQXxOtNUMO61kbs=;
 b=Foa5DNuA87EeTWc52+NTictuhvuSsBSML3AYJVHeJnaNJJlSlSOO2gK5M1q9IGhRqQyqBb7GpFzL/T4ns1bMx65IrK4faDu91hGO8DUtxR87Xjoe0JdTfFTNBimlIVrb6GJIjdrO5wApyczPHpG1vYJqIWPn8ngisJOnu2jGmM6P5hl6kgBibDHcKatUPto/0K7ia5kQfA0S3AGpioa//horhc7gqsjB8p+IkstzSA/eINWwxxEi4MYFacJ5KeYWBp3F5WvlMOCs9BgxFEQqSrhi31nZai3sl2tbikTf/eygJ3ETiWXXArrItvrHGxfRehIoqtAatTd+dHLzI/UIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtK9xGM9EKNLqlcsAmUFFRx+DBCojQXxOtNUMO61kbs=;
 b=kTZTKQbzQ4RBeOXYm7+J2o3MnVsWDowJHonnneYqpdiUa7qLYvgE9CKPqDdFlEpc9hmAOmA3h+kloUeU0dtxNFKnsZe2ln3AAKoByz1w3exp+lc6QnHRFsr5mZ1fmPOgnOUSQqbUYGNM9WErymEUoYR0f1PHTyBPt2xvSgpXzos=
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB3647.namprd12.prod.outlook.com (20.178.241.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 08:53:47 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3%6]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 08:53:47 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Thread-Topic: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Thread-Index: AQHVtYBGsfl0tDCPbUOWRFJTiCn2C6e/liI9
Date: Wed, 18 Dec 2019 08:53:47 +0000
Message-ID: <MN2PR12MB32961665242FFA632F4711D5A2530@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191218085050.28635-1-tianci.yin@amd.com>,
 <20191218085050.28635-2-tianci.yin@amd.com>
In-Reply-To: <20191218085050.28635-2-tianci.yin@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-18T08:53:45.747Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8ceb54e-c4ea-448d-c666-08d78397cb76
x-ms-traffictypediagnostic: MN2PR12MB3647:|MN2PR12MB3647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3647C120B94C3C8D48C790FFA2530@MN2PR12MB3647.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(52536014)(478600001)(66556008)(64756008)(76116006)(66446008)(33656002)(66476007)(91956017)(66946007)(2906002)(4326008)(26005)(186003)(7696005)(53546011)(6506007)(8936002)(316002)(19627405001)(55016002)(5660300002)(54906003)(8676002)(71200400001)(86362001)(81156014)(9686003)(81166006)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3647;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EsA2ZT52/SPtEv4N8SSRTtaLlYqi9EmAdaRkTav3KxFN48w5XQvDIU8o2WOmACl/Y45Nd2lOKKgi27iix/7ngXFYJ72DqzQZQk9xuu29ZZf1yDKYFmwithgmORSyG5nC99+msUrytXaJoRuX8xcE9zpnINOEZK9lm7mAVEmsHaj0/o7scyuWgCgL/ApO+DbIsFT29mvPqapGUf63cnUdvASCwIwO1gkm5qOdI+MX5VSNTDYx6+Kdn7Wpy5N5XCyqKeCDRd54lMh1LuyzuR0d8JlOJR7EXsRfD0ulp/X0ZBwhgdwHYDYqNrIRdSVUXeHF14wm1MypQazFmPBAeYLtO4djIARwtUD4okXRsb7hmPkayef8/Zx/RFkYhAqqhz3vG5vp9tALTTnNFo54mXTMTX+tzhHIaYaqQUE6AOntDGxQlieMBmUsUo3nHo/KMCI
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ceb54e-c4ea-448d-c666-08d78397cb76
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 08:53:47.1174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVtQDF02qPNw+0Su7btW6pTI91G83TJ8QiCsezWZjOlqqgX2NMsTJzLtiinRKIGM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3647
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: multipart/mixed; boundary="===============0032112259=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0032112259==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32961665242FFA632F4711D5A2530MN2PR12MB3296namp_"

--_000_MN2PR12MB32961665242FFA632F4711D5A2530MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Wednesday, December 18, 2019 4:50 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xi=
aojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>; Wang, Kevin(Yang) <Kev=
in1.Wang@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer reservat=
ion(V2)

From: "Tianci.Yin" <tianci.yin@amd.com>

IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE)
has been reserved, and the p2c buffer is in the range of this TMR, so
the p2c buffer reservation is unnecessary.

Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 21 ++-------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 5f8fd3e3535b..3265487b859f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -202,7 +202,6 @@ struct psp_memory_training_context {

         /*vram offset of the p2c training data*/
         u64 p2c_train_data_offset;
-       struct amdgpu_bo *p2c_bo;

         /*vram offset of the c2p training data*/
         u64 c2p_train_data_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index ce5cb854bdb9..476ea4a4dc03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1681,9 +1681,6 @@ static int amdgpu_ttm_training_reserve_vram_fini(stru=
ct amdgpu_device *adev)
         amdgpu_bo_free_kernel(&ctx->c2p_bo, NULL, NULL);
         ctx->c2p_bo =3D NULL;

-       amdgpu_bo_free_kernel(&ctx->p2c_bo, NULL, NULL);
-       ctx->p2c_bo =3D NULL;
-
         return 0;
 }

@@ -1718,17 +1715,6 @@ static int amdgpu_ttm_training_reserve_vram_init(str=
uct amdgpu_device *adev)
                   ctx->p2c_train_data_offset,
                   ctx->c2p_train_data_offset);

-       ret =3D amdgpu_bo_create_kernel_at(adev,
-                                        ctx->p2c_train_data_offset,
-                                        ctx->train_data_size,
-                                        AMDGPU_GEM_DOMAIN_VRAM,
-                                        &ctx->p2c_bo,
-                                        NULL);
-       if (ret) {
-               DRM_ERROR("alloc p2c_bo failed(%d)!\n", ret);
-               goto Err_out;
-       }
-
         ret =3D amdgpu_bo_create_kernel_at(adev,
                                          ctx->c2p_train_data_offset,
                                          ctx->train_data_size,
@@ -1737,15 +1723,12 @@ static int amdgpu_ttm_training_reserve_vram_init(st=
ruct amdgpu_device *adev)
                                          NULL);
         if (ret) {
                 DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
-               goto Err_out;
+               amdgpu_ttm_training_reserve_vram_fini(adev);
+               return ret;
         }

         ctx->init =3D PSP_MEM_TRAIN_RESERVE_SUCCESS;
         return 0;
-
-Err_out:
-       amdgpu_ttm_training_reserve_vram_fini(adev);
-       return ret;
 }

 /**
--
2.17.1


--_000_MN2PR12MB32961665242FFA632F4711D5A2530MN2PR12MB3296namp_
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
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Tianci Yin &lt;tianci=
.yin@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 18, 2019 4:50 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; Long,
 Gang &lt;Gang.Long@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&=
gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer r=
eservation(V2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.co=
m&gt;<br>
<br>
IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE)<br>
has been reserved, and the p2c buffer is in the range of this TMR, so<br>
the p2c buffer reservation is unnecessary.<br>
<br>
Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 21 &#43;&#43;--------------=
-----<br>
&nbsp;2 files changed, 2 insertions(&#43;), 20 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h<br>
index 5f8fd3e3535b..3265487b859f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
@@ -202,7 &#43;202,6 @@ struct psp_memory_training_context {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*vram offset of the p2c t=
raining data*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 p2c_train_data_offset;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *p2c_bo;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*vram offset of the c2p t=
raining data*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 c2p_train_data_offset;=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index ce5cb854bdb9..476ea4a4dc03 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1681,9 &#43;1681,6 @@ static int amdgpu_ttm_training_reserve_vram_fini(=
struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp=
;ctx-&gt;c2p_bo, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_bo =3D NULL;<b=
r>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;ctx-&gt;p2=
c_bo, NULL, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_bo =3D NULL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1718,17 &#43;1715,6 @@ static int amdgpu_ttm_training_reserve_vram_init=
(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_data_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel_at(ad=
ev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctx-&gt;p2c_train_data_offset,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctx-&gt;train_data_size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;ctx-&gt;p2c_bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;alloc p2c_bo failed(%d)!\n&quot;, ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto Err_out;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_k=
ernel_at(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_size,<br>
@@ -1737,15 &#43;1723,12 @@ static int amdgpu_ttm_training_reserve_vram_ini=
t(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;alloc c2p_bo failed(%d)!\n&quot;, ret=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto Err_out;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ttm_training_reserve_vram_fini(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;init =3D PSP_MEM_T=
RAIN_RESERVE_SUCCESS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-<br>
-Err_out:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_training_reserve_vram_fini=
(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB32961665242FFA632F4711D5A2530MN2PR12MB3296namp_--

--===============0032112259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0032112259==--

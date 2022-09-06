Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB49CECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 14:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF51110E6BD;
	Tue,  6 Sep 2022 14:53:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0825110E6BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 14:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMMsyvS8wdg6BkT9osxgOce8+XarEHnKpI5UmubdGYliiGylrrEIIN6OD1T8cq967+XQney0GNhcWYcyXRiNMyz/BGFN6vqRf59vao2Zv497md6qUCL9vhDa9Ici77XlEiYOeUtSD4djW1YHlJjQwmNcsscrY0+Ddugyn8vqKgd7h3ToTahkJz6xUFqzjbij2ddm9aEHZsvdnZ/6FaWfb2ruzyGK3d1tq3ixnO7AsLtFUuqdJP3uIQYQm8nQorSMTWI53VB0sc6QoO+MlPuSTRf6HJ95UrL4VcXJB7xad1y6XWExm2saNWC9FlhabbDFUVCNp2tCRTABgS2B3aI0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udwl8xLdGnWa/mtqK8qY1BleTpz6RtiwtpGQb42CMso=;
 b=eMsNJTmzZJBNBpGAZITxoCdq512LsVQljP33Nh75RCuo/gwiE3MZRmYkLz9o3tSAkSWrFnoCClCE0FrTfTDXiD4YbM0gmPLWoTKAAKpr2Xdbnhw+G5o2OsGwHcu6z0JFBmws3fnl6B8J6t0+R17VffktiBI1D6VRFQ6O8rCvrPGXPaXMaJtMuAMGSGaz5w4oBMpcmOUsxN2b2e6eYL7RNWHwsVy+sBvaU3o2diTSeTwuSURNWR9b1+xmfij2w0d946n9fqwRMU+iARW81L5q/yYSDzMews6xQRZyQCP0h5SEuVX4oXT8FsNpp1tORxfiYgQcEJrwATt4a2V09EOLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udwl8xLdGnWa/mtqK8qY1BleTpz6RtiwtpGQb42CMso=;
 b=wzv7QmOyclsxo5fGfavMmMYfl/0+m7uD6BRNx6u6eTZqPFg6MwzvLTs5bUnOHAKvhgR6POLkHZd2+fw/OCey+jU3JQo8RFbGtb5aTg8qEFOljNxXplUD+j+v5p7c17MYiM0ndmmCKeoXOuP7IzutL3+rgYa0h7Sp1jfe+/67g9Y=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 14:52:59 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f%7]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 14:52:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: prevent toc firmware memory leak
Thread-Topic: [PATCH] drm/amdgpu: prevent toc firmware memory leak
Thread-Index: AQHYvpLRiDSv21KqpEO0XcNNSKLlY63Sg3rF
Date: Tue, 6 Sep 2022 14:52:59 +0000
Message-ID: <BL1PR12MB5144A2C79408B71FCB10DDD0F77E9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220902061100.1740381-1-guchun.chen@amd.com>
In-Reply-To: <20220902061100.1740381-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-06T14:52:59.093Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7be82163-90ca-4d01-819a-08da90177de2
x-ms-traffictypediagnostic: BL1PR12MB5158:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VO6mSOPRNXP0nK2yFmQXZFvU0QfUqctzD1m5bIujgACwukgFw5VO33njpDsxeg/fTBp8CgELqhjFycN1pNpCWMbV8Y+1PO1O6Uha95nqbP/UuFAjIgvukwtsL1JX0fsiUY7irrgytbVTq0YtNbAgpHHT12cMVk0cuAK+2OMtFYhbqXUAop4lVrFIEAuSQ3A6zlitQcNgaddxAT3DUFarQVUyd5teqAxDC6QJpsyI8mts/LO71OyAJj6HufVqwiUlcfrvjRhfA/MycBQttLZiwBfGDVz0URlI8vXDgeI985jGqjGpbe35qY930X88wokC7gOt9v6xy9xxNoJBpKKpny8blTaMK1pPvBpuEgm1aJqv4uQ8QclPuG7SVhPhFsLn5DLCmYyHL2FF/p//8PtNhC1ILbyGmGPeLEP0yLwdTwmydtyOxpzuH9vNuIB0zGW0SAieojkgGcuJ6TiuMkTAt51FBxpGZ3Qsll1zdZgd4z5sMmy8XSIXvXGlmbnZZSRsFtA4e1jyAdtKHz47Vt7K9RNdtTMwvLPBV7eeo3JIdakkA6KPkfBG0Mq9H6cI9mUyWbxwPVJRptzNYCpyVRzmpkkvniFubsdireOTuOZhP6s+mednMZQ5AiWEIR3aOPNVzuDHiTLd+Vv4VWOazrHoE/Q24pVQHbxIgqzeAnyiSp20jsbDxe0efTsQNfRjjP7Taca2BTCLXJdOwQ27++q+pB/KcuDDcRgXeloXzd/XD8FIyooS00Ox9sn0bcQLARy1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(186003)(86362001)(2906002)(316002)(66446008)(76116006)(66556008)(66946007)(64756008)(66476007)(8676002)(110136005)(6636002)(5660300002)(52536014)(8936002)(53546011)(26005)(9686003)(7696005)(6506007)(478600001)(71200400001)(41300700001)(38070700005)(55016003)(38100700002)(83380400001)(33656002)(19627405001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vVU/jkyWXYbzp2IAzwZsxS+3h7km50WDT4g8FaXD1n3Ir5DtqNUdxAFrGIb9?=
 =?us-ascii?Q?PumhxzaCvCEAFXTS2O855aPw4AY9bnoKVBr3zBjdw7SkJuzIDEXhAjId2PUf?=
 =?us-ascii?Q?KzzSZNSDK2P4n1ogyUCQVY2hq8nAuA4kpmItohG9+K6A5e6xczsLxgGbpYuJ?=
 =?us-ascii?Q?7BKAu5ylQDzRXVjgLeG6DHYkDqxT48VohihxVQWoybYdi0xcLxDo8zGiMhPa?=
 =?us-ascii?Q?1Pbcjn5PUhWtIMX5TSyVD0zPZxsCtF8jpvM9kSG+i9pRZom+r59D26Gt7NNB?=
 =?us-ascii?Q?qrKBEyQeAwZn0s73Sqsy4UhqWPwm1LjrpU9uKJ+A2rRITYn+vPlKgyiBX+ja?=
 =?us-ascii?Q?M7pJoiST6cqZn2dBOxXxwftMcloL/3qo/0QgTntVRC1cwSlCgm21qeNCefoP?=
 =?us-ascii?Q?cCX6BhJn+YGo9W609jDVDhX+m4fupkCXo8SSRmZmJASnWyLphBkAoZTsz+gW?=
 =?us-ascii?Q?9JrFD/yMtNdi7c/PFoLlgC5m7Qd0Und9GbPgL8RvgRpSLh4QxXAiudGmfBRq?=
 =?us-ascii?Q?qPFknyC3Q7VT0hCf3zL1w3SxqMe4GHAAF4iN53lQfFdsG1291ItoTpmM+V2m?=
 =?us-ascii?Q?9Utm8GKllZlrb6E16CzFBBMyOD4Xl2jRBrtGUjLS+/GjEkRHuKqSsUTj9K89?=
 =?us-ascii?Q?y/Ur6Brf+7wd8fvlv3BzRsdI4cyt5AwWSX1TTPItqhykGWpS7ftaElpvPaqc?=
 =?us-ascii?Q?7kJSspcZ1Bt/kjSwVjfSkIwmYhgIYj7TegAwBQYck+X0kQHkEQ80jG9jaxdQ?=
 =?us-ascii?Q?FAas7QVz1vZuNVSQjQ8mEvKzaYTYthdFkXGf1SuhZriKFQURruq+RqzzMivE?=
 =?us-ascii?Q?qzFkGI9h4RekKZID59YLJqGySjz56vAHrkcwADowqNIao4MKEJceA5tK4kbd?=
 =?us-ascii?Q?L2mbUuYuL44ZB3A6N//PvUwyW4+fBrrwWr+vovZoQAfLLSyqAjDdRBGj12uX?=
 =?us-ascii?Q?ZJNA4ZVRTZzlGU7ICbun81ui+101r6U9fc0go2IRHRjMrX8yk/ehEftDNzyI?=
 =?us-ascii?Q?6Waoll0Dlk0FVfRh+Xzg3xjQcinpxqM/Nc/eIGwDBLdHTFvA90cJCX9vlyuI?=
 =?us-ascii?Q?OyzF+++3wUXN3Pdr5ggTlSPr8VCvcElZWgSG162OJYDSz4sRBLuWdTBkCSGk?=
 =?us-ascii?Q?3S4cKMN2ekHChf0pV97+Gb8FyxYmPUY6VEWCEYAphqWLYavRSTOOj0mTt0+g?=
 =?us-ascii?Q?XN4gXWlLC1gyn2nsDE2iM5mjoHgMFt2BAxM/jncGm1X3DP86y5DE4qD2uj6a?=
 =?us-ascii?Q?sf2C9gU/85SOkvHXmI1ekLG5AGl3mOoKo/GfjcGy5JudSNccq/gxNrmdqClZ?=
 =?us-ascii?Q?you9VmL+/GOmsdV1eRTHjEsxSYiIZTB+3NXUp6ycy0vwtBaGXPowf8hJWLBA?=
 =?us-ascii?Q?/PsDlsn//nkQW9xCZuGLmmZ1g9j0KxsHVsmySV5flMMs4dIL2Ke0oDlQEnms?=
 =?us-ascii?Q?870SCKMW4flFVmq6bdb6GXX/kvLFHx8n9G9BHDJntE5/QXOM44dgFlBVDUg1?=
 =?us-ascii?Q?iOiobOpDdIoUOlFtjcbsGQfhfboElbls9QH4z+AiO71dKVmSaXxNrZEAIarP?=
 =?us-ascii?Q?a2YhENrQvFM92oFp2hg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A2C79408B71FCB10DDD0F77E9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be82163-90ca-4d01-819a-08da90177de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 14:52:59.6052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lQBdBX1BU7xZShvDlCfaPBqtlJyTvjG+yfyEe5y3JLYdkSRaNBpAPIHQsGdlvjvpr7TK0mRR/cR+2TfuSkc6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144A2C79408B71FCB10DDD0F77E9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, September 2, 2022 2:11 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: prevent toc firmware memory leak

It's missed in psp fini.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 28ca0a94b8a5..cfcaf890a6a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -496,11 +496,14 @@ static int psp_sw_fini(void *handle)
                 release_firmware(psp->ta_fw);
                 psp->ta_fw =3D NULL;
         }
-       if (adev->psp.cap_fw) {
+       if (psp->cap_fw) {
                 release_firmware(psp->cap_fw);
                 psp->cap_fw =3D NULL;
         }
-
+       if (psp->toc_fw) {
+               release_firmware(psp->toc_fw);
+               psp->toc_fw =3D NULL;
+       }
         if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 0) ||
             adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 7))
                 psp_sysfs_fini(adev);
--
2.25.1


--_000_BL1PR12MB5144A2C79408B71FCB10DDD0F77E9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Friday, September 2, 2022 2:11 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<=
br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: prevent toc firmware memory leak</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It's missed in psp fini.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++--<br>
&nbsp;1 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 28ca0a94b8a5..cfcaf890a6a1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -496,11 +496,14 @@ static int psp_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; release_firmware(psp-&gt;ta_fw);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;ta_fw =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;psp.cap_fw) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;cap_fw) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; release_firmware(psp-&gt;cap_fw);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;cap_fw =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;toc_fw) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; release_firmware(psp-&gt;toc_fw);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;toc_fw =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[M=
P0_HWIP][0] =3D=3D IP_VERSION(11, 0, 0) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 7))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_sysfs_fini(adev);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A2C79408B71FCB10DDD0F77E9BL1PR12MB5144namp_--

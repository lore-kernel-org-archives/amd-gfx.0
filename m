Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6809CEE14B9
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 16:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881C910E6C0;
	Wed,  6 Sep 2023 16:58:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D0210E6C0
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 16:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzDscws+VtGT4GusRUgc2nDNuWfRIQuiPDu8K1R4XYy7/0DSEJG4iOzbsQKcvfdWZaGv5YAqREov6NOQKQQnlZ94WQZqbYej3YIjvAk1MMSIoFtTw06nnVr4lrf2P5NKLTb8EBEVmOt+83PJd0dvc0r+1M26+uMlVVCw6aWWqprC8AIJheur9uwYOWu+YWfKZmhnDlNzapxo3/RL+o15VwaWdMPSBmokgRQNXBx9OsGgPUJoQ8ODZMZFBhbOLV4uorRsuu8ROfv3O53Dv3Pjrrl/NKTxPZC/bsqdO43WVA7mFuu426gxInYMEncW3dV/+BnRfBtQOjtjzX8OW5G1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n6PP1kqgBLdOiDYwt00XvxZCJOBfFvmo4IHxPHkiIg=;
 b=QXqAqQzJAddgT9Wm1B19Enq4NU8SdA/gKizZs2pFIFSDd+HkW7iv5M7tBMOLioSaJq10JrmGcuPI9tJAq2Oovoft8xlnDX8eo0/aKi9W33CCb+Lopn4kiA/8FxmiQzBRPbYsvv1EP2awY/Z7cEd7IzGs1JVRqFz4Udr/up8NuidzzGES+jYbxisFp0eZXzYPz9k15Vk8ZOt5u5pESIRd89p+lJbUfwMMiraBJemCsZUaQJof+G6HLpYlqzVA8xRFU94iFIztC9RfHZFiKAgB2gq3KDBlm2koSDicDmKBzft/wX9bmSXNLbE4TgDVAzrdEH+PIjo/CoSORKWY7S/vKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n6PP1kqgBLdOiDYwt00XvxZCJOBfFvmo4IHxPHkiIg=;
 b=a7yNDts1BjMK593S6ldSR/ggdEhFpaCjMd9M7w4qv0ld0lrdBqt7A4S/C+h4uwbZ5PROxGK2cJ3+xK56m1Zu+2TkE/ngHIQvDx1Slezl8n/8h794fq8ARs1+7nDHYey9eNj9jwBGGK6J8UK/GLJkpocTT1FuDnD9X2ApZ1AVe/w=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:58:45 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6208:cab6:bc19:7aa3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6208:cab6:bc19:7aa3%2]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 16:58:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix unsigned error codes
Thread-Topic: [PATCH] drm/amdgpu: fix unsigned error codes
Thread-Index: AQHZ4LdOl/665HjYOUSuxGRNElB1qLAOBUX5
Date: Wed, 6 Sep 2023 16:58:45 +0000
Message-ID: <BL1PR12MB5144381481A7D006F469B857F7EFA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230906114249.3136325-1-Lang.Yu@amd.com>
In-Reply-To: <20230906114249.3136325-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-06T16:58:44.413Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB6935:EE_
x-ms-office365-filtering-correlation-id: 174e0855-40d9-4c00-6dfa-08dbaefa8822
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H/0dxgTkG6t+6eohgqGsx2mbdsX7b/cFwig7Sd6iuuTxA7jCLgZmYlMDnRg1lwFhu/f8k6fYBrmXx7sIzSXaKu/3mtAx1aYPk4DIRo79rtpWOnt1B4+qska2eMwZ0OU71qwwbld+3Hp42RJNqd/mRC56XZCDuc0i+lpG/Aw+Ipqx9FNFh2MvlFz/6CZCcxCN9DBd1arXUTM42PjEhGsD0wiJu4re2KsDJ0Ol/LibEH5MKzLx8uF2V4UOpeyTf8BHjsLzy8y4xQUNft31F1zWuPbo0rXD5vFbtg9CBSqSHL4zJOPHt63n0LjwWTWE5fH9GCRIToEUljGz/XQ0oBDM1ObfWBQ+yddUYG3i46LyTEfYneLiu93rkNMaXnYGdlqagX+nbFFv65VZjuZxev0nWkok3ubq54TQzMdT2YHEhL4JydfeXx3Qi+3cjznMFKEON9mY4rpvpWomvU0xtQXLrJbQTTF6o/L6M6kiQpWrXahk4zTmjz2xs+FaDKllb4PWlnbstfBPPi1TKP1ut/0ohedkFrnKe6ZB64iHIH1DB8e/6cfcMplsjDbxTejqmzG8r0OKmzTKNxfYtvETjg+JVGaDcwXlUo3gXvioTGnWUBM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199024)(1800799009)(186009)(478600001)(966005)(71200400001)(9686003)(6506007)(316002)(4326008)(8676002)(8936002)(26005)(41300700001)(83380400001)(2906002)(110136005)(5660300002)(52536014)(66446008)(166002)(122000001)(38100700002)(33656002)(19627405001)(76116006)(66556008)(54906003)(7696005)(64756008)(53546011)(66946007)(66476007)(38070700005)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FJFhKZ/+cfdA2lEK3bGsvXKKxe34nNhVUmuwCE9Q867mh4atSC9T9GjzkQMH?=
 =?us-ascii?Q?4FdPzkA4K968j64jQb/EBhpN8gGK2z3dMbOoxL4dF5GTgpMtIelu8wMf4+CM?=
 =?us-ascii?Q?pOtPVvpoGH1XFBAybG+0SsYNlEo+ULOBFFQXZPnyRCDl2wWMa/QKSUa6+BxR?=
 =?us-ascii?Q?DiCesqoGP5zd/aLFCFVLTPQKA0fGLxsjZ1gbNZ77k58zl4DEdoT1fYjwSkbE?=
 =?us-ascii?Q?ccM6HZjwt57oMyctiLQyHICkitPBIH2gYrZfqw1swJdHmWsT2Qev3n46drnP?=
 =?us-ascii?Q?I+3YElUMFyDRkkEzMIl0ymvlpNuFrt6jwZ6ZzREyXj/QzxMbJ5BypIIaIJG8?=
 =?us-ascii?Q?4daVi9jBjH3d1AvtpU2lPSHolix1983NjCtNSibZ4/e1hZFbMbmzNRm+hDhs?=
 =?us-ascii?Q?ROkLG4TTnLFThav1EfhP3gdaTih3fncJEOGrR/ld7ADX/nyrHZ757nKg58d5?=
 =?us-ascii?Q?fNBP7dP0tvOZnS+QwI1VklYSLCos313i6I2jrcur/JTWMKwhE32Q0V7kpJbp?=
 =?us-ascii?Q?l9OK4RX93xGZf6AcRQ7x0X2ylfuAxyRNNKj99aMTe9NwfMtbTefPV8viQ3EN?=
 =?us-ascii?Q?CpzxpgzVIJwnf8HlBafcA/LsQx/ZAxFY+IHE2W9SA2pXjr/bwkv0Soc0+YHU?=
 =?us-ascii?Q?IEDCHG8olx7POqzBEKuqZGOH1w+PDkjXnluvjbwIcqPGx9oBaA2oofZPkBK7?=
 =?us-ascii?Q?IKphUG4/9Dz3sT93MEm4TCUu5U1ztyyqtE4pO4bIDUPcLNXwMRSGXmIRKKZT?=
 =?us-ascii?Q?4PhZG0idd95KudB4W5Ul9Krj9h3V4HgDBumNCosL8NP4x3T/r23S/b7/k9Zf?=
 =?us-ascii?Q?ejKWZtLCxkpuZCWSkTnamY0Nkqj5tRtvMVbz4CYp67DskeROlLSrYVr6OxBZ?=
 =?us-ascii?Q?lKg8HC2VsVB2rr4ggutHw7GfvL8LDZjlys+yg/zGmyaqKrnmvDxyZwLA6avw?=
 =?us-ascii?Q?ObKFJp2u+dNevDxAaSvVR7MlRntcJkGZdJgJHTo1KblR0P5pOwKXqfb7wtws?=
 =?us-ascii?Q?/aHg8oov1QtQjaaA/G03bI/vRXX8pNg5RNJkRvry5qEYh3ema5lT3v51KjUy?=
 =?us-ascii?Q?ttfvsxf3LGKHeIYPMsio5Viv72R96/DYuZ6jdxkD8UeY4mPPdLY5Ftx4guZO?=
 =?us-ascii?Q?Wo0gjCxeovpp6w6/4XQ01csc14akzyPpvL0HU2dCheVjgsHwns4HDeGEOIPk?=
 =?us-ascii?Q?T2Ofv2Nky7TpTQHlhBX5T4wzS80W5Sv8mQfZldHWaAF6l7td1OetF7J74GMg?=
 =?us-ascii?Q?D9Biud4VrWWgfiq9dzJxrNNMCqpwIFknsaAuQwQ4bKEdWd46pRu3YMxmj+q5?=
 =?us-ascii?Q?JP0M6WDelZVp4sl7qIjxcnlGx0qC43bwrMGU7g8e2kfoiQSb706tsLGT0K8k?=
 =?us-ascii?Q?Jh3CuH7y/Z+cUXu4mQqBJu7kBmlM5u0DHDNZtE1z7SRX9ueVnLhUpyVMko/4?=
 =?us-ascii?Q?2qOq8f0ou5pbRIKVQLWwWm+QonBq5B6nvrjbYuIFHKc6aSX559wBp6t6ZWVa?=
 =?us-ascii?Q?5f0Dd26oNJyaW1u5uv7FG2VXrEsZyFZBtG4nqMDXgOsNEtOht60jFGDQg8LI?=
 =?us-ascii?Q?80IDVV8uatLTOE4YyhI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144381481A7D006F469B857F7EFABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174e0855-40d9-4c00-6dfa-08dbaefa8822
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 16:58:45.1761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPSnN3ReElNKVkXyx3pR6WV2DakzjTVyiIBl2ADhzXoC5D0y476Ps7o0MIW0smjvdOxDKpGuLJb6RYJ2s1K/wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935
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
Cc: "Gopalakrishnan,
 Veerabadhran \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144381481A7D006F469B857F7EFABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Wednesday, September 6, 2023 7:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gopalakrishnan, Veeraba=
dhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Yu, Lang <Lang.Yu@amd.=
com>; Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amdgpu: fix unsigned error codes

Fixes: 77b13b916728 ("drm/amdgpu: add selftest framework for UMSCH")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/ZPhddADtKmOuVyDq@lang-desktop
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c
index 284643e1efeb..9da80b54d63e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -335,11 +335,10 @@ static int setup_umsch_mm_test(struct amdgpu_device *=
adev,
         if (r)
                 goto error_free_vm;

-       test->pasid =3D amdgpu_pasid_alloc(16);
-       if (test->pasid < 0) {
-               r =3D test->pasid;
+       r =3D amdgpu_pasid_alloc(16);
+       if (r < 0)
                 goto error_fini_vm;
-       }
+       test->pasid =3D r;

         r =3D amdgpu_bo_create_kernel(adev, sizeof(struct umsch_mm_test_ct=
x_data),
                                     PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
--
2.25.1


--_000_BL1PR12MB5144381481A7D006F469B857F7EFABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yu, Lang &lt;Lang.Yu@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 6, 2023 7:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Gopalakris=
hnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;; Yu,=
 Lang &lt;Lang.Yu@amd.com&gt;; Dan Carpenter &lt;dan.carpenter@linaro.org&g=
t;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix unsigned error codes</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes: 77b13b916728 (&quot;drm/amdgpu: add selftes=
t framework for UMSCH&quot;)<br>
<br>
Signed-off-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
Reported-by: Dan Carpenter &lt;dan.carpenter@linaro.org&gt;<br>
Link: <a href=3D"https://lore.kernel.org/all/ZPhddADtKmOuVyDq@lang-desktop"=
>https://lore.kernel.org/all/ZPhddADtKmOuVyDq@lang-desktop</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 7 +++----<br>
&nbsp;1 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c<br>
index 284643e1efeb..9da80b54d63e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c<br>
@@ -335,11 +335,10 @@ static int setup_umsch_mm_test(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_free_vm;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test-&gt;pasid =3D amdgpu_pasid_alloc=
(16);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test-&gt;pasid &lt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D test-&gt;pasid;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_pasid_alloc(16);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_fini_vm;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test-&gt;pasid =3D r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_ker=
nel(adev, sizeof(struct umsch_mm_test_ctx_data),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZ=
E, AMDGPU_GEM_DOMAIN_GTT,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144381481A7D006F469B857F7EFABL1PR12MB5144namp_--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E20DC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 08:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E824910E679;
	Thu, 10 Nov 2022 08:18:18 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D4F310E679
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 08:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZdnN/FWaO/S2Y7RrQ8O/nJ0/3qhfW+R9wN0huS1DeiUVo1GOuLTfFBQNcIUU5mVwURz0hfY9n6gtX00MdlUbyvldinpfXEnKkEacwnA4VcWO61sog2ugi4syXLTc/gfac82LZYk0DzY9qUaCVzMCySmS+y9HjVoWlvLjFEfz+TURZSNe96P3gWURSiKTfjg2GKMdlECMk7ZBe4bBiRj4f+gJ660HNcRccQOZ3QKqH/QZ9CtCRS581BQk+CRHG137rz6vfNVQEvDR2OoqRTOkS0KmNPxJ9JIjEA+mEIiDEFhN85+Ie2ktWg2P4rTHbmK1G67xVhpN2MWJqXOcrge0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y76we3HjCXz2+WGLT2bxk8jpDpF7fv9yhmX3NFM1+rQ=;
 b=AD0uJnR3/G0R09JGVawtQ+fEP+xlhdwI6Lb3HQrstJAtzlE7tGYTCwXomVLN+8rj4uBIpWBerWgfYvb1og2PIKCPNb3CWmVEKBeKECo4DXNRYrQI2uIEftUfsXFYi1CEok8ejlrfXYmRpJhqIbr0jMWqvVYW8T+qadR8JruA+e4Qip6O8iGGZ+q3nTAvLizgTEM3C/guZ7FGFDWFa/DuXE9wl2iIEQkMQkxb4IlLEicW+rKBk0JPMprFzjqlEZodkyt0xa3unhTImVJ7gOzWHSsf7eT2ab79Z1FByGh90vvUAmvBIVYS4czMFion3unFQHR+Y07MnIQzoMa6Y7arog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y76we3HjCXz2+WGLT2bxk8jpDpF7fv9yhmX3NFM1+rQ=;
 b=c7YzKJgR3TJ1dj74pn0ytQzyw654oe/eFewY1hI7O3X1CeNw2BMuTnVbG9Ow02jkecuo2cesxiBud8D1laAc0FDbWFRGHvd/cc33Si/Fuv6cG/TteuRCMUByJuobjLOK5zm61Q2RJtcLb6sjnm5avNsCARLbnThlIPdw/pi8wgM=
Received: from CY4PR12MB1496.namprd12.prod.outlook.com (2603:10b6:910:10::8)
 by DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 08:18:11 +0000
Received: from CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::f0c5:b405:58d3:7bda]) by CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::f0c5:b405:58d3:7bda%5]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 08:18:11 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: remove the check of init status in
 psp_ras_initialize
Thread-Topic: [PATCH] drm/amdgpu: remove the check of init status in
 psp_ras_initialize
Thread-Index: AQHY9NLD7D1jpPLulki51M5Jl0Aopa43z1gQ
Date: Thu, 10 Nov 2022 08:18:11 +0000
Message-ID: <CY4PR12MB14961ED2F80CDC657E5A928F91019@CY4PR12MB1496.namprd12.prod.outlook.com>
References: <20221110070400.23347-1-tao.zhou1@amd.com>
In-Reply-To: <20221110070400.23347-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-10T08:17:34.0546977Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR12MB1496:EE_|DM4PR12MB5039:EE_
x-ms-office365-filtering-correlation-id: 94dde2d0-a4c8-41b0-cf92-08dac2f41b6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +HobiW7Xvn2oS/5CdAQmyWToDbelsQ109mmeG3nX1dyTRikr5gu6z6Pyv/XD+DwQ2Vm7HuhP/Io5zbTVO3fi5YI18FvFzf84eGE7MxibYZ6um4bfPoNjo5MhRcSJ/Vo96jxbJdbOS3Ja6eRCwjCYzAC7MlcuOG3g+HYwz7IPqW4oTuMFdWZ93vv86BiSe0dUfcTychjUafnYEt3ntP/UgEqIpliRBR0E0GY1SfY+lf2uAbCu3bqN2uNJpmw3vyK+g45NlccFY+Mqe/H6E4q+sE1QHgWasrk5j7PzDGpYAKpR0OME9EoPVmYqu8Q8ak/0IAiLR9LA453qjYEoe5IJq8L51lMJT3KdDxGTpq5kFMEtMUTZfieJEujq8JWlpAVXk+EpStK1dqbzvXwWs2tIEQ5uW96HAeh3kl2EyHwEW/rZngxDO66KBXZ1Kl80sFRSCuzGTh6wcfupcI1ooBecDjBS4ZPtzKxfJ6SfOza/ReJmkPaBx95xCrUOWhVoonWoAa8AADgZISuh1jjM870YxLQOxt55GPkcbGs8To3aLkS0xZ9ff2/bRwsIYkXw91/fKAO/BdDoXKPErq9HSvkJ2LmAML7GuBq8JRpZ4L9I1zLXzfwFa09ik+B7L5O8SgH4sz2zFXKNmGW/0GHnOAAbh9SFYFq5Nt3GLQn/lPG4qTL7EHrHorQWQN/jE0p/TBQJtXNjh01WBH6mCbbcDqDgS41bK6JgyRuB/BnhkTaCNvHgU7tIYWxTo8NqlTK0LL6f6CjJmpJwddlPsd94FKWAjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1496.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(55016003)(9686003)(5660300002)(41300700001)(478600001)(53546011)(83380400001)(7696005)(6636002)(6506007)(110136005)(38070700005)(66446008)(64756008)(52536014)(122000001)(71200400001)(2906002)(86362001)(66946007)(76116006)(186003)(66556008)(66476007)(316002)(38100700002)(26005)(8936002)(91956017)(33656002)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FohYM3qGo4AtIob1snNT/+xz6fDtOFoecGIRdWHgyXZ/1fK/tCL7qMyBFcsW?=
 =?us-ascii?Q?204BwWCcNHDpUp2cbSxeuauZKXDgVAqEm58ZHtc9DAIV2cPEKwOhx9crT3Tz?=
 =?us-ascii?Q?yQJl19LEt+YuQCIbLLjpSbCD8NS2bVXZBrxBPwfbOX1Ppj9NumDDtNbdQ+N5?=
 =?us-ascii?Q?V/mDZ1a+dGuDW3RZ8lQCYyEHwhWymyl+cB6nN6UvAiAZFFvN1kqiEbqzmzBd?=
 =?us-ascii?Q?ZZQkdRiAUx18mF+5LyeMm3dKk7nGM8JucW7NfK0LsOTcY35o4ZUwizqEpIre?=
 =?us-ascii?Q?ff6hT/J5IqMDTaWJelJCJ+uoFLg3FxZgCs50FmO+PxzTcQJU2VnCBlgbkmyS?=
 =?us-ascii?Q?k2fT3vZrhgZKCKoV15jftM5X8v6KFkTvV8x5Ysh5s/uKwk4dWrv9GVz6Ib8l?=
 =?us-ascii?Q?HR8kDssP53/dO0511lPUycAPVSzZO/JhuA3BSq9LFx/K7DPhVOxzB7LupUAO?=
 =?us-ascii?Q?Vle61yM3tcwQKEKs9QFLVazoRvx9EwO14+X/+7xOjBetU1UDcRp2p3fVP3jL?=
 =?us-ascii?Q?l27hox5waXN1u5vrYcucR68bFQvgYeiF/2nnanRvqwcdd9L4fwXt2HnsGUJg?=
 =?us-ascii?Q?i+i7e75PmNPWiTfLMj+AkaxDxsXEnnp200LvubRfmNfEOUnEvTAaZ0CEdWsh?=
 =?us-ascii?Q?R3BsYCUaL2R3xCJFilcA0SsNqlOZ96nOcAC53nnHzZjNwKu0Md9ivvZHpM+9?=
 =?us-ascii?Q?9DxA+CsGlExam8pCg6Old4yeyWfJS50O1wMGRHW92o50wtWHzf+UDRo1+YTQ?=
 =?us-ascii?Q?w+4gkIQ1Z35PHZpE37vVaoeAT2aGbXFEE0pBZTIxnM3a1nnzAvfXgTf0bG0s?=
 =?us-ascii?Q?OObVhlsU25xMYmE3K2jEK+Azr+7m4cz43rT1teGvAKpFguKXeTQo0IJtkyya?=
 =?us-ascii?Q?uTu5NJQ7/UlCqR071DXqZbVMQ3mHvrX8CD8l3+hdxR0UZGgRSnSnQKvqm03O?=
 =?us-ascii?Q?gFK0l7e97tj3b9oDLfRRXALS5idNEV8i849yEWRou6M9KF+2SyKSKvR+qJof?=
 =?us-ascii?Q?ivY8BuKLdqDSZBUCAhSP9y4IJ5zWQbjN/ANSLh9oWRI0Lgd9g4/17qJhmQb4?=
 =?us-ascii?Q?SjkIE9C9T19dxvaD/zCfr80v2pLRDjCpNd+yoZw1bHhZbxRaCwHtHM70HhWa?=
 =?us-ascii?Q?Abdk/LoxGEYHxduFjc/+z8U7LlCUWrDnl3IRjzWzz1ebpTIPiPbkLDuRUNzz?=
 =?us-ascii?Q?h7q1Io87bcX4w2UPNQQPtYMTc8yjwSReFuSdi6N/o6bazLo1QT/0wy05J9/r?=
 =?us-ascii?Q?eGTc5jOfpqA1uHN3YWCQA6zByYEc/5L8JSLfrmAxq0aUIowscMKaZGkJ8At/?=
 =?us-ascii?Q?HIG2KakYFM3DbSZ15i2bdEWyPfnxzMYXLU9MyUKKZUTjPk5ishSNNhlfoR2Q?=
 =?us-ascii?Q?njtqkTMQCAcpNHfgSxOloIXyHPXjW82CkTMWiG2LkoGKoL998k5fZ6shPEWn?=
 =?us-ascii?Q?AMJ7RuhnQOVUW1+Z7juty0ge18voIqunVJBMKgRbg6AqCgfqL+a0b5UnAO3g?=
 =?us-ascii?Q?aEzVlVJjri8UH2kYhulely2k3uWQi0j98oHn6BqTHsrUj5gWV8pm2eWnp0eW?=
 =?us-ascii?Q?FBexeehcneaWeUR400v7Aa3BLoZMjaIW3GiLDnge?=
Content-Type: multipart/alternative;
 boundary="_000_CY4PR12MB14961ED2F80CDC657E5A928F91019CY4PR12MB1496namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dde2d0-a4c8-41b0-cf92-08dac2f41b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 08:18:11.3646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8ioqbTsKe504Y/I+q9QjTspdnIIWNczvYKOPFU+EEzFUuOAJtiacv0ZMph//tGr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CY4PR12MB14961ED2F80CDC657E5A928F91019CY4PR12MB1496namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Candice Li <candice.li@amd.com<mailto:candice.li@amd.com>>


Thanks
Candice
________________________________
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, November 10, 2022 3:04:00 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Li, Cand=
ice <Candice.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Tho=
mas <YiPeng.Chai@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: remove the check of init status in psp_ras_ini=
tialize

The initialized status indicates RAS TA is loaded, but in some cases
(such as RAS fatal error) RAS TA could be destroyed although it's not
unloaded. Hence we load RAS TA unconditionally here.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 2fcb5bfbef89..0a8c30475dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1526,11 +1526,6 @@ int psp_ras_initialize(struct psp_context *psp)
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       if (psp->ras_context.context.initialized) {
-               dev_warn(adev->dev, "RAS WARN: TA has already been loaded\n=
");
-               return 0;
-       }
-
         if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
             !adev->psp.ras_context.context.bin_desc.start_addr) {
                 dev_info(adev->dev, "RAS: optional ras ta ucode is not ava=
ilable\n");
@@ -1602,6 +1597,9 @@ int psp_ras_initialize(struct psp_context *psp)
         else {
                 if (ras_cmd->ras_status)
                         dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n"=
, ras_cmd->ras_status);
+
+               /* fail to load RAS TA */
+               psp->ras_context.context.initialized =3D false;
         }

         return ret;
--
2.35.1


--_000_CY4PR12MB14961ED2F80CDC657E5A928F91019CY4PR12MB1496namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto"><span style=3D"font-size:14.6667px; display:inline!import=
ant"><span style=3D"font-family:-apple-system, HelveticaNeue;font-size:14.6=
667px;display:inline !important">Reviewed-by:</span> Candice Li &lt;</span>=
<a href=3D"mailto:candice.li@amd.com" style=3D"color:rgb(0,120,212)!importa=
nt; font-size:14.6667px">candice.li@amd.com</a><span style=3D"font-size:14.=
6667px; display:inline!important">&gt;</span></div>
<div dir=3D"auto"><span style=3D"font-size:14.6667px; display:inline!import=
ant"><br>
</span></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
<div dir=3D"auto">Thanks</div>
<div dir=3D"auto">Candice</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Zhou1, Tao &lt;Tao.Zh=
ou1@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 10, 2022 3:04:00 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Li, Candice &lt;Candice.Li@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zha=
ng@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Yang, Stanley &lt=
;Stanley.Yang@amd.com&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: remove the check of init status in psp_=
ras_initialize</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">The initialized status indicates RAS TA is loaded,=
 but in some cases<br>
(such as RAS fatal error) RAS TA could be destroyed although it's not<br>
unloaded. Hence we load RAS TA unconditionally here.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 +++-----<br>
&nbsp;1 file changed, 3 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 2fcb5bfbef89..0a8c30475dda 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -1526,11 +1526,6 @@ int psp_ras_initialize(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;ras_context.context.initi=
alized) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;RAS WARN: TA has already been loade=
d\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;psp.ras_cont=
ext.context.bin_desc.size_bytes ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !a=
dev-&gt;psp.ras_context.context.bin_desc.start_addr) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;RAS: optional ras ta uco=
de is not available\n&quot;);<br>
@@ -1602,6 +1597,9 @@ int psp_ras_initialize(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ras_cmd-&gt;ras_status)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_w=
arn(psp-&gt;adev-&gt;dev, &quot;RAS Init Status: 0x%X\n&quot;, ras_cmd-&gt;=
ras_status);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* fail to load RAS TA */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;ras_context.context.initialized =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB14961ED2F80CDC657E5A928F91019CY4PR12MB1496namp_--

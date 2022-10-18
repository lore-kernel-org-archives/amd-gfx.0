Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E6AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 13:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB7C10E5C5;
	Tue, 18 Oct 2022 13:34:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B075E10EBE6
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 13:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnyqgyhiDOwL35JmvVNl0CiVZ0GhiTfWz3/wpcIAaCBZNW4PDu+8XRhLHtKBk0iHRQFpbGkR1CCLr97DGu26DEUbt+0DfF4PyIlGh1trMdQ+PKPXtyP48CpBA9028jOAUrkUh0aqVvQmqOQHJA0k1uImL9m5lYVQr0dnKW9PWBO+nIefKCKH+hQ5dmAXa6noae0syIO7fjb1LtaotxmhRyaY5WdGYvKT8e56E1iRSMJKU5SZcVv5vAPZZGyAAr50SdQf8NytdVhruYdJW6Yri5o8L4H79NLytUIl4oCUgYlkMvfgOYQEyUtcJZpXirjaOjWxFEtqgF11PJs/ceR68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3hbccDLra3HllO14MScbamwBjk6l6xKrLBodThCN0w=;
 b=im/SaoMr2hJ9DyDmOihPpr7wDp2tBYv/H2lGk5BsmHOlbm/S35uvnQyTlIPHPGLfyHk3CmUh7YSTRoWQIsJY94JttJcgvjenbzP0JHroqHM8dnQyrOCmIBhKmqeSJUEavLOXnMNU+939Kuh/1f/Ebetnp3VtGpQGHyegrFEfTJ9FjMnaKjzZAuDXsvso2n+OUS6gmP2dY5aaUOF11pgibQww7lcgjASkOC9fh0oxRw167kBeqMET7w0JD2eu7+G2Qgg6jLgwXkyZwYL2N64KJpqnNq0YliDPklizBQsdkzQ/1wxEBIChopI1Llti7DUlDQLllsdDd/zmPt58QbvQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3hbccDLra3HllO14MScbamwBjk6l6xKrLBodThCN0w=;
 b=N7JtHhAvp6DIoqmPby4gIMgeYdej+VNNAo7bI+f29E/6ClAkk9k0DrVatHLAlsrrN8aBYEFb+gT5p9VfSsQseDjWvG3NVrH40FdBXUq/Ghhg9gLc2V+0f/ff3D7sJv4svbcwhffC19DPAwG27RJ5gfTpUEMfRwtIdXhjiw/VN9Y=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 13:34:26 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187%4]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 13:34:26 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix pstate setting issue
Thread-Topic: [PATCH] drm/amdgpu: fix pstate setting issue
Thread-Index: AQHY4touS7S8xmtpbkKIU9Igh9HRyq4UJusH
Date: Tue, 18 Oct 2022 13:34:26 +0000
Message-ID: <BL1PR12MB5144DB84AED5107123D93C96F7289@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20221018101222.32477-1-Jack.Gui@amd.com>
In-Reply-To: <20221018101222.32477-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-18T13:34:26.091Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB6667:EE_
x-ms-office365-filtering-correlation-id: e33d0d2d-85de-4f68-2003-08dab10d7a20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZdGPdyFoOBgCil8+xtO/3ePRwgCXEa/Gv3r2o/6E8ErdlsX8jyjBGMdwOhHNUh354IO8ZcZPEulBOj3HOUEvPLzFBYFT6BgMSxEVFytbmrdx5tVU+y9RgdARye8Y89ttgH8BrUAUthEslDBJtSNyk3zKoUxhn9zA4i+w0iam5OXCdTCX212TFdl8g64+wcOIHAApPnMGnm3FQ1xXhJYdEkoO5qEKEO03IrCzgxlEHh37uT9/0MhgrO+96eSPgdOh/TLkg7cogcJUChxbbX3D/lx5eEayfaDvzvIZwuY9ezdnLXBmK/BBzOVIgNJXap1cAFdtDYtIcAlxXHvmFKJmgcicAkaPHnszV2ivkgimogH13pG5Di/xZuUSD7a3pFLjtq9esxRdBVcnLjIv4psOT/w1Kz38caCK8+zLSaL6PGz4nf0RWhsqcqZ6Mh19ZiJylnAp9+Nz0IFZlDEPk03+QULm75s863jGY6GVy2MfWh2U/GzsKt0NUnpotXpJ8TrQVsn+wX17Reng41UZP2K5uZ+MooX0CGvLjpj46zt3ukeLw1fA8c50QnAwTOrSGsqBHfQz6JteiJOTI1NiBy6zzCnj9WJ3nCZjhQ/918OVC0Au/LbE8JxTFIADroepnXjGRvwCEDrv15S+E9rxfPawXkOt+rbGgKW7ZdJYTN/MS35B+W3RkbdhYFTJzWdpiYOigbLIujzTxB21T1KEFFquwkU+e4t2g5VWx8v+TR/jiqJ5/CElqrYDFp4QE6An1W6c4kvZmRk+5Z5BeJMZyaowdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199015)(76116006)(66946007)(66556008)(38070700005)(122000001)(110136005)(6636002)(316002)(9686003)(66476007)(66446008)(186003)(2906002)(86362001)(83380400001)(33656002)(55016003)(53546011)(41300700001)(6506007)(7696005)(4326008)(8676002)(8936002)(52536014)(5660300002)(64756008)(26005)(71200400001)(19627405001)(478600001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KwT5vGqd2K/D3Bd0rRcJ/7lolTq363UzoBo0YDQTkwqxbP5rQDvXBp1tBSdV?=
 =?us-ascii?Q?JSkjdDBPx/n37Yyg3JVGhV5x/C7gq2G4JEbwPf3lTTqsZvjzPrwNewS9zsjO?=
 =?us-ascii?Q?vbd/ftuASk1OBAlYnZaHHOvY08FYXskq5pufB6ezRE0qMB0OQc3Dd7A69bkc?=
 =?us-ascii?Q?QehnfmRwtL8vmXYpD9+GzHKKY5puNWKcuuaZOnKIJ6NpNI9pVt4LO+6wNmRc?=
 =?us-ascii?Q?tLVy9PGLS15Gw/DYU2z+4rmgNgtcEGkGjakOfZWD8ygB6o7o2+dsBjOymNSi?=
 =?us-ascii?Q?NBduRB5BrDIxBPF0Wq9bdWsImqf/vHWlbIDViKOcA4R/nq1xRiljthh4oj7Q?=
 =?us-ascii?Q?nFabJ70A/zUdrpdgDROav22LPPQAp5VtwwHnqih1l4LRdoqaZD5Ye4K/sk38?=
 =?us-ascii?Q?2ilE6kyiQMqGvSsf+02gV7pWAhboRPqDaWsPKdNQO8JKaTAlnIWBN4+upJvh?=
 =?us-ascii?Q?fRwtoRK7PEB6j1ht4eTfLjizNQjQ9ZsGVU3V3j95gFmzNynaS365fikC6SlI?=
 =?us-ascii?Q?WdOXHSahUrD/EHnO9WxEI9peXj26fc4GqlH5CmIohedq9dc+8EYRpQ0JaGUS?=
 =?us-ascii?Q?dhPoFPqcNi+Qm1Xl4whHmFEMhPclXnmO8k3V9G95fPPLdMRnNvGxZdSy7DZl?=
 =?us-ascii?Q?Nq1Y6moS8TMSeuB3h+fRtYj8CwFSwsLklox960kObw1zkdPn77XKGkfzIoCN?=
 =?us-ascii?Q?UINi8oKd4LbHX5PzhlMpiTNGV63qozjJKgpYHR7MtB2TJmSxA8Ldp9QQZ4AQ?=
 =?us-ascii?Q?7tL0ywRPEAxLyOppHJEPR91B3IQ+S5mP4xoUmcGqt3q6YVIWK3XW2buSpA+v?=
 =?us-ascii?Q?ln/uQsV2RgaClM6xJHw3+xqTImguu1cXQjdQlo+YoxkF28yoOIzOJb7E0Y0J?=
 =?us-ascii?Q?drW1ZB64fsgVWTjEdl2TLKvDVOuO2itrbWJE5hfYl0sNeKWvzVjxG4lo+MTE?=
 =?us-ascii?Q?wpl7ncNYvfim1pEr+QwLjM0JjFBlB6SX481NrWxMgje4RtUyuspoDnBJFD70?=
 =?us-ascii?Q?wG6anjXDuyKiaeLBgrgrEjCVb5VO9Mgy+aeWY/oBaRRf42RC5uhQWMpGb0sd?=
 =?us-ascii?Q?FGtUpNIV2y9J4pvqKCYIxk9R3VHrIlamp6YdUsFxgcY26uCt0h59+i1g2HMI?=
 =?us-ascii?Q?QDuD2bi2RbfRQ0OK5A0Gx2L7Bxw+hkZBgswKG4PkJ2L9atl9WG8mxf3x8d7K?=
 =?us-ascii?Q?MOkqJrg7OoXlfHwPVuSd1f/1RNRY3k1Lnp0DBsu3Z2RpeGCq/g/8pYAAZLP1?=
 =?us-ascii?Q?ZXZ596Lg1gTd5b/TfurYAtrvr0Dn4ceC+HEz/FgOQ8vh/yJ0PkVIbdtDzHPM?=
 =?us-ascii?Q?4CZShJIuOEuUvL0T3DbdNWqyKGnyRFVWIYfpyY3VJ7HlR8/5/3E5Fk5hiIaI?=
 =?us-ascii?Q?5LM66z3fD4nq6roHC+q60KgpDR7nkzZ+8GnVcBLIsxuHZt4V2kHWm7z4rl6W?=
 =?us-ascii?Q?RX5AXbfIL2+iufnxFHNNiIQiN/kU/inryLQEjzNy2DrZsYnWk+TZQlvWNzzC?=
 =?us-ascii?Q?a9oFP+AvZbcPN+oWtqgy5Ivzto51Kyp56kbGQe7G70jKSa7F3eZDY8/z1U5o?=
 =?us-ascii?Q?GK3ll9xK//UrKdwRbZQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144DB84AED5107123D93C96F7289BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33d0d2d-85de-4f68-2003-08dab10d7a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:34:26.7650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABBVkx24N+QDhL/DC3CD0s5HxBvP38s09lK7WnKea5bJfHp5odZUBusZuqSaNNNHP8pXHctfT5xzhOOxsdBrqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
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
Cc: "Nie, Tobyn" <Tobyn.Nie@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144DB84AED5107123D93C96F7289BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chengming Gui <Jack.Gui@amd.com>
Sent: Tuesday, October 18, 2022 6:12 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>
Cc: Nie, Tobyn <Tobyn.Nie@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH] drm/amdgpu: fix pstate setting issue

[WHY]
0, original pstate X
1, ctx_A_create -> ctx_A->stable_pstate =3D X
2, ctx_A_set_pstate (Y) -> current pstate is Y (PEAK or STANDARD)
3, ctx_B_create -> ctx_B->stable_pstate =3D  Y
4, ctx_A_destroy -> restore pstate to X
5, ctx_B_destroy -> restore pstate to Y
Above sequence will cause final pstate is wrong (Y), should be original X.

[HOW]
When ctx_B create,
if  ctx_A touched pstate setting
(not auto, stable_pstate_ctx !=3D NULL),
set ctx_B->stable_pstate the same value as ctx_A saved,
if stable_pstate_ctx =3D=3D NULL,
fetch current pstate to fill
ctx_B->stable_pstate.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: I61cb68b2a5fe2544cd91233fc069b5919fadcb76
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c
index 5fc3da020a55..331aa191910c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -326,7 +326,10 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr,=
 int32_t priority,
         if (r)
                 return r;

-       ctx->stable_pstate =3D current_stable_pstate;
+       if (mgr->adev->pm.stable_pstate_ctx)
+               ctx->stable_pstate =3D mgr->adev->pm.stable_pstate_ctx->sta=
ble_pstate;
+       else
+               ctx->stable_pstate =3D current_stable_pstate;

         return 0;
 }
--
2.37.0


--_000_BL1PR12MB5144DB84AED5107123D93C96F7289BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chengming Gui &lt;Jac=
k.Gui@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 18, 2022 6:12 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;<br>
<b>Cc:</b> Nie, Tobyn &lt;Tobyn.Nie@amd.com&gt;; Gui, Jack &lt;Jack.Gui@amd=
.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix pstate setting issue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[WHY]<br>
0, original pstate X<br>
1, ctx_A_create -&gt; ctx_A-&gt;stable_pstate =3D X<br>
2, ctx_A_set_pstate (Y) -&gt; current pstate is Y (PEAK or STANDARD)<br>
3, ctx_B_create -&gt; ctx_B-&gt;stable_pstate =3D&nbsp; Y<br>
4, ctx_A_destroy -&gt; restore pstate to X<br>
5, ctx_B_destroy -&gt; restore pstate to Y<br>
Above sequence will cause final pstate is wrong (Y), should be original X.<=
br>
<br>
[HOW]<br>
When ctx_B create,<br>
if&nbsp; ctx_A touched pstate setting<br>
(not auto, stable_pstate_ctx !=3D NULL),<br>
set ctx_B-&gt;stable_pstate the same value as ctx_A saved,<br>
if stable_pstate_ctx =3D=3D NULL,<br>
fetch current pstate to fill<br>
ctx_B-&gt;stable_pstate.<br>
<br>
Signed-off-by: Chengming Gui &lt;Jack.Gui@amd.com&gt;<br>
Change-Id: I61cb68b2a5fe2544cd91233fc069b5919fadcb76<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 ++++-<br>
&nbsp;1 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c<br>
index 5fc3da020a55..331aa191910c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
@@ -326,7 +326,10 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr,=
 int32_t priority,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;stable_pstate =3D current_sta=
ble_pstate;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mgr-&gt;adev-&gt;pm.stable_pstate=
_ctx)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctx-&gt;stable_pstate =3D mgr-&gt;adev-&gt;pm.stable_pstate_ctx-=
&gt;stable_pstate;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctx-&gt;stable_pstate =3D current_stable_pstate;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.37.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DB84AED5107123D93C96F7289BL1PR12MB5144namp_--

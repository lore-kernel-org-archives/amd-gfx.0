Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421A9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 16:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D9389AEE;
	Mon, 22 Nov 2021 16:46:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7EF89AEE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 16:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWjQNCnxySgW/BZBQ9CKqpwmx7qKWHOynRaqHfnEQSl6SiDjl1oybgcl2oA49B/iaSDJUhXZR2ofel29OIl4tEPGTEVfLH7ZHsqsJtDIQZUel1q7OA+yLHCcodG+Xfe6ZyGsupqhcHFfFpsIt+oImes/t82hhHIvd2MxBzGbaNdXGLhaKtSjEoX60zcf2ppwWnIxxSn9TO+Pz3iWG3PZVEOp4celUbuqzE7sRrJj1WVCi29GMgMKI95dZqrIN5uQAt64A6tiwKTdgJFHaHjhICY1CR5VmcqOxy97t6DWj4hozpQFuU9ZbWu0kISBChLNerQXLta5wVRY9p9SPvhsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fAf7WU0YfC16TsqVeJyj1ZQROX8YX50iKsWYR9Tg0M=;
 b=S+JcGSGIjPOnrihVMyHsflOsR5HP1pP1ORwsXJ9p6EV3PGGbyN/XHDQM6MerCcC+JsQKL7WcD2fu0iMXtdymhEArAoai384xjp5LyzV2ixbjX71MkVcXRVREpaM7PgldIBktwr2h98zQSvELuSzDiemJfsY4AGzJ933vKdAyVzvmEHQjuH+1Tg9z8061yOdY55orplTT942RQrJ6QRjRkG2xKkwwGnnEkFzpkdawDe0gm8bihhFD1RUxBlK8iX8pKZZzRtNyqS/U7mC9DsJEyNsbtH5htCL+toKlN8GUGET2BGW9IZiQVjmk6CHsJt2qYR5V0mKJSl+bjwqCIzligg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fAf7WU0YfC16TsqVeJyj1ZQROX8YX50iKsWYR9Tg0M=;
 b=vs+O73EYYn/+aGcS4GOZF49DWT0Jvd6Bw56sU+ob6k1MGC7QsvU9QWHeTUzpSghlUbm3QmHrdV1oq7J+jYFTFvYrW07LhINHdReVzC1FoquNJBFv2iBq9eOFz7EKvqjL6RkXRovffBG4kDlBFi+86Cg18sBO3yLLMGNI/n4YD+U=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 16:46:28 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 16:46:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: check atomic flag to differeniate with
 legacy path
Thread-Topic: [PATCH 2/2] drm/amdgpu: check atomic flag to differeniate with
 legacy path
Thread-Index: AQHX34BeCe8bE4EiukWTdlP95YKrHqwPwe0N
Date: Mon, 22 Nov 2021 16:46:27 +0000
Message-ID: <BL1PR12MB514481C2D446B0333C77662BF79F9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211122090353.1399178-1-flora.cui@amd.com>
 <20211122090353.1399178-2-flora.cui@amd.com>
In-Reply-To: <20211122090353.1399178-2-flora.cui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-22T16:46:27.238Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 32a8ffcc-9f96-55a5-b45a-709ba2366db5
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edf55d6d-26ed-4cac-191a-08d9add7a0eb
x-ms-traffictypediagnostic: BL1PR12MB5174:
x-microsoft-antispam-prvs: <BL1PR12MB5174F44B15F3D8278593DA72F79F9@BL1PR12MB5174.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:256;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sJulN12lrL56EM4tF+fvtYKpYmjj6lBRVieCEjRsC4aee4RkamyVm4k2pFQnOQYrX/C5CwI4/3u8mv9vgBbgMv7eHaVLwvYmhwC75i+3iTPBhoyLqaXxt0y2LRTMO9ft2kXKBdlGkFu5s+eNZdZczF7Ed/W8DuKor473Fa+UXIEHuajiGrjBFg+Lniwv5E8xyMqISvF3VPaJOQIoDXcmvCkDRSm1bZy9f5701rh+hHrsZq2xJqDJLEnsGSklS/zangnWcqogGp2FKfPcdujfzNPfjUvsp5mUYw4fGiZ8K5fz8bNe2iylroLQNBVoW6XAU6HvLMPbMAdu7g/Tjjh+5wPaF6ECsMt64wCMh5tcVvsC0OUu32YCpsH+vkNqs6DsLHrXdEqpsdsuG9fkgbVU4h0vtR/aGSOt6wCDdWOX597+WCvIkgfKm0xLaMbDdagEXowdW8+Lhw69TzzFrS/EuJbuMCn3NfReSBO8y5zwJp5a0LPYdIxE09V8r+EpSFEmGGwySQMCneF5Eun6NVC2Nw0W/duxjzCh55b6sLUeDPOP9Am2Wh3T2RiZEqhtbddZwr7Ikc/PspIoTPq1BnVR4BWHqGFjtadtf8OfL6H3sBZj7QFdkFZ0IJdApQ40MPlTqcrQDlSryvc5dOACYh/dUhoaJzs+PbNgKDYohlIU0GH4rsTV8D+o+AMbyfwj/gR2MFT+x3vOQf2jl1HEXZv7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(52536014)(26005)(19627405001)(38070700005)(2906002)(5660300002)(86362001)(76116006)(33656002)(110136005)(64756008)(66946007)(66476007)(66446008)(55016002)(186003)(66556008)(9686003)(71200400001)(38100700002)(8676002)(53546011)(6506007)(508600001)(316002)(8936002)(83380400001)(122000001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5mIXIh9U2lT+scJaU/cPMT63pQ/1NLT6dJqtw14d5Jmy60NS/wq3E5mQApWW?=
 =?us-ascii?Q?NrtOrImQoILcDonBwzaXCIb0TSaXdiKNxTD/oRwN3bzXVccecdRUZIN1vCnj?=
 =?us-ascii?Q?iusL+lXmdDSbCnYLxUZqB/zZ7IfmSPEzd8VGvWYE111Tox5Od7XsIowng2I5?=
 =?us-ascii?Q?W8omzbqevLAVPoVg4Qj25ZPV6OmoTfI4DgOa/dLSKnR5AC6dMlj67S/6pWzT?=
 =?us-ascii?Q?9It3eUzQHL9MTD6dzKZghpKiDbF+cHLa/1xPLuqqnZP9pqtFWsiyHHMueSRx?=
 =?us-ascii?Q?RqTiHBjucePBk91b42RUbRqfr14mBqp9JKX0NIKRn76dajpE++Ud1CmLiMEp?=
 =?us-ascii?Q?dOP8NplkAWvDrJEMHLWGXsiNxDIpMDuGh+v64t+SIctvVW6JL04QnGTrzEp8?=
 =?us-ascii?Q?BPq56+b+/+lQ+QLaVrQFwfpH4ln9XFhWJz9L/mpsw5lRvmbB34u2DGARfTD2?=
 =?us-ascii?Q?xDNpiJI0otwj4E673gRODWZHjJvhwKtxU46VEp83vEeAn80ODGpTSBrU5Tv+?=
 =?us-ascii?Q?ckbsy9JunMFguigL8rGJntQGa7xTkEy2RPkW5/PLny6Zie8NnBVFbIm+Qcjx?=
 =?us-ascii?Q?xI3mw8dIb5UlqK5Ux9DjYL3LHZW++wMos0AvqnsBON1UM70SgdWjY0jShvXy?=
 =?us-ascii?Q?e2TbdagoSI2nFBxpvwVUQ8BAeWn0iqnXZV3ojgs8mA7bR1B358Pb9ezsz8nc?=
 =?us-ascii?Q?tFtnur1MoF/zCpOStqRHqblBayWXwL5wFuzZHclZJlsMmQsRstg47w5bs+29?=
 =?us-ascii?Q?jtwxuUjuTLYHh5dxABDdVTrXk5H6F24HpL3Vn7AlMKJt1fkBXQKQ7yOniizC?=
 =?us-ascii?Q?6vplXVacjFxl/27hRAQmgE2OmihunawP88DxCSgQtIfgKYaRYbFI004lpCzI?=
 =?us-ascii?Q?RS1ar4xLeICmPBIYIturSe7Fz6d0UcNKFs86phwm8Rs75HUzt/Eq5Se1ZNak?=
 =?us-ascii?Q?bPVqaCK+nzf4sOQHYvsj7OdLlIbiu7ptjlM7EiQvTFZkSUqr3JFh4M2mZ/MC?=
 =?us-ascii?Q?L/DqYQ5jjY+s6ZgfiO+1Cz98TqtfT/Pu9Z1HrgGXG+usgBJANqauoAEt10jO?=
 =?us-ascii?Q?pbwLzJY/8jxs3ytOpf3mo/ADQqsol4J/aft6WIOJxS+jQi68r0nxvTfoXewK?=
 =?us-ascii?Q?NALQiK9jTgfvfiH6ebSEEsfGEnD5HHTFMlg0QRd/LptF5drdFgBK+Xd8YUJe?=
 =?us-ascii?Q?Oqv1R43qsd7l1LJXX/zbSv0hsU/5TsCvdhrDPL9lWUZtvIHDt+PgSi0tPawU?=
 =?us-ascii?Q?7HSiv6u2+tIebK/qqZRQnloYDvXyF3AcoOixaYG+OvPUoY60BllOhgNEOYs9?=
 =?us-ascii?Q?DZWWo6G+UpJq0eccnB/fe9R8vkw6WKMe59F5cTXOnVasvaJHmKul1Zu/d3v+?=
 =?us-ascii?Q?dZjKhY7GBHb0iOP7sqsCmyqWwqB8M7G/27nncuuwLhzD2oox5pyE8MB8ZU6K?=
 =?us-ascii?Q?kncPD8l204Dw+QTn1LWL4fmwq6xOIg2R3wKP+/qnRtCcoXekeyq4hpW6hfBa?=
 =?us-ascii?Q?R9hi1SgpIqQoO46axGK83SFSJA1HVpOjEC2iRHzfOL4NjlxhycquUuqcGc7+?=
 =?us-ascii?Q?TNrad7exYfwAusWr7bn0V5fQHe2fq22fYuQ4fhN3+qORcuNgqr4X+SiE1WMy?=
 =?us-ascii?Q?IJWcoGWz9Ezz3rdzP+UGYHY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514481C2D446B0333C77662BF79F9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf55d6d-26ed-4cac-191a-08d9add7a0eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 16:46:27.7189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VyFZEUOiYqSVdEYLqmX0SMBjItz7vPbqfkGprrcc6gnyfhTSdt4yRtfDlROaaLhfIqISL15jXol6FuUreCc1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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

--_000_BL1PR12MB514481C2D446B0333C77662BF79F9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <aleander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Flora Cu=
i <flora.cui@amd.com>
Sent: Monday, November 22, 2021 4:03 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Chen, Gu=
chun <Guchun.Chen@amd.com>
Cc: Cui, Flora <Flora.Cui@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: check atomic flag to differeniate with leg=
acy path

since vkms support atomic KMS interface

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index ec42a6fd88de..87801f2e50f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3830,7 +3830,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)
         /* disable all interrupts */
         amdgpu_irq_disable_all(adev);
         if (adev->mode_info.mode_config_initialized){
-               if (!amdgpu_device_has_dc_support(adev))
+               if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
                         drm_helper_force_disable_all(adev_to_drm(adev));
                 else
                         drm_atomic_helper_shutdown(adev_to_drm(adev));
@@ -5125,7 +5125,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                         drm_sched_start(&ring->sched, !tmp_adev->asic_rese=
t_res);
                 }

-               if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signale=
d) {
+               if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && =
!job_signaled) {
                         drm_helper_resume_force_mode(adev_to_drm(tmp_adev)=
);
                 }

--
2.25.1


--_000_BL1PR12MB514481C2D446B0333C77662BF79F9BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;aleander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Flora Cui &lt;flora.cui@amd.c=
om&gt;<br>
<b>Sent:</b> Monday, November 22, 2021 4:03 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Cc:</b> Cui, Flora &lt;Flora.Cui@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: check atomic flag to differeniate w=
ith legacy path</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">since vkms support atomic KMS interface<br>
<br>
Signed-off-by: Flora Cui &lt;flora.cui@amd.com&gt;<br>
Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index ec42a6fd88de..87801f2e50f8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3830,7 +3830,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable all interrupts =
*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_disable_all(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mode_info.mod=
e_config_initialized){<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_device_has_dc_support(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_h=
elper_force_disable_all(adev_to_drm(adev));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_a=
tomic_helper_shutdown(adev_to_drm(adev));<br>
@@ -5125,7 +5125,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_s=
ched_start(&amp;ring-&gt;sched, !tmp_adev-&gt;asic_reset_res);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_device_has_dc_support(tmp_adev) &amp;&amp; !job_sign=
aled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) &amp;&am=
p; !job_signaled) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_h=
elper_resume_force_mode(adev_to_drm(tmp_adev));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514481C2D446B0333C77662BF79F9BL1PR12MB5144namp_--

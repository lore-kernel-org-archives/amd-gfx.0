Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EE3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 14:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEE510E168;
	Fri, 18 Feb 2022 14:39:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9922210E168
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 14:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvrCgQfPoUMvPTMxjRZZtZ9JR8v0UoBu5NEchi96J7HY4SnuLLLwCo+LtIVcpor3lylkxHOMND7BMJi6zqcJ3CYPCQo+b/s4CV5WaYhAbiHn1qAgVmwHBprp8c7MF8WMLRnw/I1y4FVmwe+bp35LQUYo3hYaPV7ApXdPXhbCsVobOyrsL2xHYCl3eahVYMtX94CdUBZqK18b02soxeGmrjFa+cZgZK+1D2tVxVyflSwy9BpaJnHuadqxqnCIxAQUJLdTkCNG+wB5C6wxY91wkSmyqbutD7DMTb12Ah1F2VKdDmyKs4P2FMtimGdoLrh8gMJ2ee3jnJZQ1fgfnBkGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSQNfUXw9Ih+5MKHgAJO87DR6eH4rUAoYvbc6J+5/88=;
 b=mnvrBYE6cbT2sJydFT5yLuCkNlYYRsI3IISRUl/AxGy/uyWT3zKsx6cr57u1inavZaUGfQ9jQ87b4LQ/29elvGl/yivHkHum5Sf1yMA89aJSFyPpVW0ituewd2hecyGDLlafUNv0J6/YkyN2qb26K6c77qRsl8gh6GMXGPX/aLDYSgdeOMnbVvgsI52wECj1G7eQc9d5WdEZr9uomjTftoZ7sw5CvNSTjpcAlV1VUVf/yAdQW6DhVm5KVyOfyvfuE81QPhCY32RQhp1x2tQZHNWjny0mKVYlR77Au9FVKAhxD+nx7tsQQ89iUjlsTN2Bny34hrozxL4WwqKEYdBzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSQNfUXw9Ih+5MKHgAJO87DR6eH4rUAoYvbc6J+5/88=;
 b=KjFTDRAEG9pthYZnls+Qif4ij25cGPg0jUk2K+zw6T5CV8svss3u1J9vSsUJ5BYqlAykIu9cM+oHdUspY9/nDpZ82j42OcAobXbxTvqektfQhO5Dr3dpYfoFxO4f0t3O+3qjq9AsHTeDFnKzqP5ouOWhalIML8NACG55l9fEhMY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Fri, 18 Feb
 2022 14:39:14 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.4995.024; Fri, 18 Feb 2022
 14:39:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Shi, Leslie" <Yuliang.Shi@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRIOV
Thread-Topic: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRIOV
Thread-Index: AQHYJIYWsddDwk5YmUusPRaVlutm2KyZYUxp
Date: Fri, 18 Feb 2022 14:39:14 +0000
Message-ID: <BL1PR12MB51445530B33A46F09054E987F7379@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220218051157.19548-1-guchun.chen@amd.com>
In-Reply-To: <20220218051157.19548-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-18T14:39:13.547Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: bd350ab0-e67b-cd76-4459-e0f452913d03
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8452cc5-c1fc-47d0-9670-08d9f2ec6f38
x-ms-traffictypediagnostic: DM6PR12MB4603:EE_
x-microsoft-antispam-prvs: <DM6PR12MB460333BADD3C69DF0D3AE570F7379@DM6PR12MB4603.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBXGg4nJKERX7eZtMpomANVPwTpVWUCY4x7z24tMvcihZPkjK8xT7ZNplLwFX0eV3WWMYWzs6ER0U2B72xIqAwhAJ13IrMaq3+Taq7x01MZEbUf/Zn2XasC1cqUz7XUm+3HzyU6mvgSGsQNXbtPT2kb1vuYBXbxK4PEXn5ocVQ7IPraFr1+FLdCkMct0OdyPDb75GmLf+4T5oVqe4kMAQeOydwWUzcA/2dsw3d+JEfuZhes9DxvcyxRS1TYSPVZ0xd/RxvyT3Uo1RMi6zOoUHxuNmC/nfb1zWH0ZEL0aWFgelNd8E1579k+uLgoPzsvbknESaJRPAP5iU/Q3y7DbxnUP82ZwBHu6/RttGyWwHXtltDFTIxmHK082MR1TmSVstPG5I9J/Mb+4IYZWPtY4/X5eaLGSmQkzLpMPN+TBowC+7DsdzC9t34Z5mW/7piB3iD1/ZuQi6IkDkk+h7ulxJfsQr4oKzEdVN/7+VKQ3J7ZcsNBwpuIVS2akcdVjtk0EtWQ7rqLz7q4XYYjf3QaGZB9VtkJtCEcIftH38+4WhvNLYAniV6coyO9lLZEBe0wa76BRHLkP6+PZEdZldnGZTiUbxKmrkrCsi8m0HiQkI3mrsYvYOCO9NLkLjCECAo/iWiUFXI3V1dYpch3L3MrAqDXNKiURyDy4sFHqz552QoX+J3XsNgkOJXGm4FDpxieuFRB4JklM+u3QoStWqVPvakLLWfqE6Uc0BObRhFMsqJ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(7696005)(66946007)(64756008)(76116006)(19627405001)(53546011)(316002)(110136005)(26005)(38070700005)(9686003)(55016003)(66446008)(2906002)(508600001)(921005)(186003)(8676002)(71200400001)(83380400001)(66556008)(66476007)(6636002)(122000001)(52536014)(38100700002)(5660300002)(8936002)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JcoxvyeoBEZKMR5B+s/0ZEYqmpxBVVkuqddJSnI4QcMthGtudMR3SnMBohuW?=
 =?us-ascii?Q?Y97fUbaNWduaxqKUeNm+1UeZ15OcSNZHErOp+mULJcyDE5KKJSDZAYMgRL/h?=
 =?us-ascii?Q?MOIKeyCAIjOB47/VN3nbfTkO2qL7/3ZQEw7Rgxj54/ccFSfxzLOBamhMYz+R?=
 =?us-ascii?Q?TZ0+lRF2hrU+432PFK34kBiHl1Z0voFpfULls1WP2+bEf3KqCglQiJEDW9Pf?=
 =?us-ascii?Q?5U2PCb6wqCgwMrp5nDbS3UKzbMueyrmuZ56M15/I99NnfKT/w3KBKYKsppre?=
 =?us-ascii?Q?7u9QAymJzlcHtlBEzkjNyhzVmnjh/qYWEhVYLvp0W46wvlvHoAAogjuE3YiW?=
 =?us-ascii?Q?VU538yZjWNXuuVU7WOxdQTglmZdbVuPeNoYA+msh/vaRQvXL+6AqJTV6JEZh?=
 =?us-ascii?Q?mPbu8Jq7eSx7PNYhgCK5vtThIyXudDSwuQ+l7trNhfNBtd/Yp49uRmJw/fpD?=
 =?us-ascii?Q?29dsQ/fBPVi9Dy+ooOnZpi8FUtPkCVin+50LhB1gD3JA7eMQ2o9wSBpVDDxA?=
 =?us-ascii?Q?elWgzZnJgK8KfsYTaf6SoGpk3rINrF+q2rYmRBgxrOfacqGD/XCLL8BBteEI?=
 =?us-ascii?Q?91kfDmDNVYUSqwcRpna15CwtxoJf+diDEWVATgXwpaq//bMCvnW6EFrEXtUb?=
 =?us-ascii?Q?97s0u8JWUZ7UsCCzQ5/9QqQo4wJK/orfabdq5cJKY4ej4/yKQYp57xznxtHT?=
 =?us-ascii?Q?UZs4YFrBn3u/wjYopJoLZ0NB/uc08OuwxXd1K/AXqVpVQgdwjs+GEZCXVwky?=
 =?us-ascii?Q?My/k4Z9kuna55BDRSrlF0wXILstKh/i5f2xEnbPorEcHe/pcw8g8/KlvL7Ib?=
 =?us-ascii?Q?Q3lLMAv7YyCGLFBi3gtAtgHCvnX4zabd/+mCIDqe8Ua2K2Wleud4f18DWWat?=
 =?us-ascii?Q?YoOBUxGkl1vi2zFtP3dmyE1ms6PmU24RFDTsJkB6EQCGosURv28vld10ofNQ?=
 =?us-ascii?Q?ESvYPSVyW3WBpvRubbqtvODe0/ulGdfbjsKBDfKKtqQudITDcd9JfOdADUdO?=
 =?us-ascii?Q?SL6SpyLiL4xrCa4zi/7uWZdWTvRoE6qoGgswc0EWLJ/0o2EYB4cl4F0VtqBB?=
 =?us-ascii?Q?qyfZxfYM0+zGBikkF2BSoBxnzCrielgyd86k/4El6lOwN0arhr3IdbzTc+x4?=
 =?us-ascii?Q?lgkD4zESSU5UMTPvX0a6zEEYS8JgYYA1rCIcNca6hCHZzChOGbHhGuCJR/xh?=
 =?us-ascii?Q?T+MdApFbf4Iin6ZYq/BK3qI7cZWhcrH6ZE4rcXEwzXqdPYcmRhPARpv4GQj2?=
 =?us-ascii?Q?PIt6fzVdIHW0MYGMEyqjOlTEg4VmnjdkV3QPte5ilk8pmR80lyx6it7cSh+3?=
 =?us-ascii?Q?awpGz4aiVYM0yt19TkBks+zNZucWGJOe+xiXXwDkLQ/ajAIuDLC3ucup4N3b?=
 =?us-ascii?Q?0t0VGskg/ViwrdkNsdNblM7gj9Unq3QAXSisF1j4BrBMQ3P3RlbtQdjp1bmY?=
 =?us-ascii?Q?W3yyLR982lxK4kl5Jts/iYEA63u/zmwk4C5HY1vXWjOUJerkulQ5UVqVPlLt?=
 =?us-ascii?Q?cFBWSl9wmzp3LnfHyXpWuSnJwMbQayIJ4XNsF2zIqZebdRS9ZWowNJymMkLL?=
 =?us-ascii?Q?qVnbL1IfkJYCgNP+56NUthpNWk+Yekyax40izjYG9t2eAyPhRqO/+a8fQfmj?=
 =?us-ascii?Q?vA6bAeAX6fY17oMeeM5xBg8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51445530B33A46F09054E987F7379BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8452cc5-c1fc-47d0-9670-08d9f2ec6f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 14:39:14.1194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4GMGV7HdptLM1kpnUXIccHZgXvjRgXT1xi+5RO2P1DtSm1EmSnYv+NCbXiMJmTZUdQkErcrzf13Q4Q5aPAoPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4603
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

--_000_BL1PR12MB51445530B33A46F09054E987F7379BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

I think we should check adev->enable_virtual_display instead of sr-iov?  Yo=
u can enable virtual display on bare metal as well.

Alex
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, February 18, 2022 12:11 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Shi, Leslie <Yuliang.Shi@amd.com>; Cui, Flora <Flora.Cui@amd.com>; Koe=
nig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRIOV

vkms leverages common amdgpu framebuffer creation, and
also it does not support pixel format modifier, so there
is no need to check tiling flags when initing framebuffer.
This can fix below calltrace:

amdgpu 0000:00:08.0: GFX9+ requires FB check based on format modifier
WARNING: CPU: 0 PID: 1023 at drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:11=
50 amdgpu_display_framebuffer_init+0x8e7/0xb40 [amdgpu]

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 0d4ad1ee8348..63cc210e4b6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1150,7 +1150,7 @@ int amdgpu_display_framebuffer_init(struct drm_device=
 *dev,
         if (ret)
                 return ret;

-       if (!dev->mode_config.allow_fb_modifiers) {
+       if (!dev->mode_config.allow_fb_modifiers && !amdgpu_sriov_vf(adev))=
 {
                 drm_WARN_ONCE(dev, adev->family >=3D AMDGPU_FAMILY_AI,
                               "GFX9+ requires FB check based on format mod=
ifier\n");
                 ret =3D check_tiling_flags_gfx6(rfb);
--
2.17.1


--_000_BL1PR12MB51445530B33A46F09054E987F7379BL1PR12MB5144namp_
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
I think we should check adev-&gt;enable_virtual_display instead of sr-iov?&=
nbsp; You can enable virtual display on bare metal as well.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Friday, February 18, 2022 12:11 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Shi, Leslie &lt;Yuliang.Shi@amd.com&gt;; Cui,=
 Flora &lt;Flora.Cui@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@am=
d.com&gt;;
 Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRIOV</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">vkms leverages common amdgpu framebuffer creation,=
 and<br>
also it does not support pixel format modifier, so there<br>
is no need to check tiling flags when initing framebuffer.<br>
This can fix below calltrace:<br>
<br>
amdgpu 0000:00:08.0: GFX9+ requires FB check based on format modifier<br>
WARNING: CPU: 0 PID: 1023 at drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:11=
50 amdgpu_display_framebuffer_init+0x8e7/0xb40 [amdgpu]<br>
<br>
Signed-off-by: Leslie Shi &lt;Yuliang.Shi@amd.com&gt;<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 0d4ad1ee8348..63cc210e4b6b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -1150,7 +1150,7 @@ int amdgpu_display_framebuffer_init(struct drm_device=
 *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;mode_config.allow_fb_mod=
ifiers) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;mode_config.allow_fb_mod=
ifiers &amp;&amp; !amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_WARN_ONCE(dev, adev-&gt;family &gt;=3D AMDGPU_FAM=
ILY_AI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFX9+ requires FB check based on forma=
t modifier\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D check_tiling_flags_gfx6(rfb);<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51445530B33A46F09054E987F7379BL1PR12MB5144namp_--

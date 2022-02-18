Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81374C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A92910F0F7;
	Fri, 18 Feb 2022 15:16:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9135010F0F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA/95yhMbJPh3ack89jx/c8DpzqMVNN1v7Fd/88F0oU0dr4Qwc/JoPWs8WiZNMdlR/2j4j6f5/un/PK+8n7nqhox+5io4Ev7NJc41HV4JYAjA3Wa5D6RugH/QY0c1lfJoFA6fXHlQhHONtQgXCo0khYNZkBmbh/XvaIZaKp+rVKXuv47G3zNPMP7X/1Kzct4ZZKhpLldVHE0SGohVsyllW52Ad3D1+9jhndp9T2+SjezI/OduXYavrtb3KgC3Wr5L2UQlpKGUYV8w/NMn/9vnJowg1mEoZfTX7IgWk9AHyo35hm4j9wtFsVyaHquVZ8cun8CeIyrIns0Bvkm3sM01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv5DAJNbOVoZCQx1HK0cFcDx8ASR7QFBakiVozvCZZ0=;
 b=cCJ5Ch6HcfOw6wQVGRceAlYG+s6ly69cFDSNILJ8JfocnmlttyicYiXswKHx7n4Oyhoy7bcKfx3f54FiIwr0TQFVsiZfvUInJk/l/7UkU6BhL4NN9wclD5UyxRmJyqG1Bq9EKDenGEL7eesi8r7ilepIIR3ATtLf9G/KXxd6bYetegE1vwmzWiOPCvm6K2/a+11iaHJqsASs7kZRddrIwbo1jq/4bv8E0edKMujhUFDCHoMznQbEpEb+h5e555sU4WnzNhNOv/V4k7iwTYkBImUcDEHQtOHszRu+O6Hi7xlO4z5h2GXzu8yGyI5YUIMfGodINM9iaQ1k9ArkLBBTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv5DAJNbOVoZCQx1HK0cFcDx8ASR7QFBakiVozvCZZ0=;
 b=tMf7T4kaAxYJzvW2qfI8NWefoNfycmkFSaP3ViLiL2/5GoyGVkxHalPkwwTk7MUB74vbSALY0nE/uryZyWnOBx+LWjGsI+6Aqt3CIc4yfj565ekAyzGQDv4PrfdNtn8ZulSTLqs915b224+CoX70DyR807ex/NzG4Dx9R+Zgqqw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN6PR1201MB0226.namprd12.prod.outlook.com (2603:10b6:405:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:16:51 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.4995.024; Fri, 18 Feb 2022
 15:16:51 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Shi, Leslie" <Yuliang.Shi@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in virtual
 display case (v2)
Thread-Topic: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in virtual
 display case (v2)
Thread-Index: AQHYJNb/wBKxGp7eqESMDwr+Md2BmqyZa1Yg
Date: Fri, 18 Feb 2022 15:16:50 +0000
Message-ID: <BL1PR12MB5144972616A871EC4F15CDDDF7379@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220218145103.7593-1-guchun.chen@amd.com>
In-Reply-To: <20220218145103.7593-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-18T15:16:50.274Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 45efe9bc-a885-d5ec-53e5-196fc25e2cf4
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8271ac6-8e1f-4119-1a4b-08d9f2f1b06a
x-ms-traffictypediagnostic: BN6PR1201MB0226:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB022627E0F68E3A0DA555E4B0F7379@BN6PR1201MB0226.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZD3TFvO+IDsULmRIZAuEta+4P4GcPL510fSRT4SSs/apjrc6rwqJkcTp2lIq3GGymZOYd0mENU8/1Td5JUI0KO58ZcnrqCmeLS6KaUrWA91X15lfx+LqrzLOndT781Nx+Zg0vi1PGHz1R4XoNibW8as0b1pCFncHNufSmGFJe3cjgJHldSZdnnvrxTnVR1atwx39ZR1GGxdgjuR1I2eKLGxnMdrCnqm9oELi7/TClX1Y/JH+I0DOI4tEkapHg9VWS9bWyaMmLE3etBPFph7c/NNik7BlzOZucLZS8yXEw+ZuW/cXi2HVSfkiG+iYFt9JivtxmJxWSRXVSkJZmEI7XYhP6wvGwxfclZA0Dty3khWGN5LUH+71LdfHIoK6eVFqo3Eq5cVL8uYxyD94UNv3C0qnCF9Z+O8Bt0C0c3lYRpucAc9foK/U5VGmSxKEroAuvSa9M2YxXZ6FrGtzI/qKbTyPZ6CLTAQG8DY+WK2/Ow0gMYpkjXnaf38KFLF1cJ6bmehfV47Ve51qjaVQfqXyhCjm7WjGw1FFAH0hQgJjhahGRbXghhuIm414lbxr40bAJ+i79n+gBOyfBtbZZuxc6ZHr6d+8vHenlXEausnndmAPEpttlEQcrrAflP7Tyh6MLj2LCjWWyEVVlGUM3FL+XLJy0DtM03VWWclS0LiGkJdD1NMKXQ/oNSJMCTVikO6l3MBeZjHCisTxK/Mfx9PUAwj39zTo6ZQgmvqCVcGDnyM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(5660300002)(83380400001)(38070700005)(53546011)(33656002)(52536014)(8936002)(19627405001)(186003)(26005)(921005)(122000001)(2906002)(55016003)(38100700002)(110136005)(508600001)(6636002)(66476007)(64756008)(66446008)(86362001)(71200400001)(66946007)(66556008)(76116006)(8676002)(316002)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T/mlHa8cbHBpStdSDxQPf/7BxJNR+oyAgbzOP/zwIeM7KiAYjxR/WZ3F1YVG?=
 =?us-ascii?Q?o03GbBy1eHIXhJ+KTLNTeB4ue9e/dvTF3JCCY2imbIfMxWIpQGPVwNhAKqOC?=
 =?us-ascii?Q?wkubtV5euaMf8xRmteUMulUk5eMJAERy8j778KFu10pOZmjk0mG0T9EcZFrY?=
 =?us-ascii?Q?8Okqbc1jfH5m0TiCkNgCXRvEBnmWUJ1h988Asa9jGFHGtmgil/SAfYtiMRxi?=
 =?us-ascii?Q?ok7qR8qngvZh70rCEz2I5gvKSYfT5nbo/1geFm02gRYtATJja64Sv0OjEryV?=
 =?us-ascii?Q?ZGTwADNMVu0RM8cYAgQjB1v2UEWhRjmK1K74GPJ0kCmBim/wrd4A6Pnp9GT4?=
 =?us-ascii?Q?FA4v2PXrpqdBhobKuVWTc7rV/5XiJY1kHMFk8BpIpzKS7MT2mvS4WDRKUBI/?=
 =?us-ascii?Q?3VAA/hZIyaqef00Q7Enhddig5SsKURp3fOB6R/KJW/PBGMVEo2GEli3onSkR?=
 =?us-ascii?Q?BYfkH2QF5KE1BWu/uKPwuRd8WtNdcwMbKIwatTKPLYYrdcgEaCJpUfk+FDQf?=
 =?us-ascii?Q?sHI5mvv1IaKuUCASIa87a2O9Rnbd/EA9vVJTQr/V+IsmM5YXABk7lyoy2f0c?=
 =?us-ascii?Q?+m9ltXNvr63R2Ua/uCLr1Ki9SA0/FR7yHwUvQL+4zeMlWnXyoB7+/zVrGVdS?=
 =?us-ascii?Q?ktCp3WhM/iSlI83LrBZ0b+QmZUZO4O1ibXArmkeAwLkykvelso0FHc8N0r5r?=
 =?us-ascii?Q?qh6kiEh+xVhWbcS2AOAQbRb53MUO8rIK/JNyumUQyT853GvlSfp0J/bw9RPT?=
 =?us-ascii?Q?tpft7u2YjdxzTBfkaUnu8ZqE1m6y1MWN+6PcP3WRDPTdEtqqc6v1t8G5hJC2?=
 =?us-ascii?Q?R7Yn0i64n+dSkmcvmtgaR6CwxDNlXWVl1ePYLPBnMTSGXfMhHJcG27ZB1MSF?=
 =?us-ascii?Q?zI/sI4KAddg3XldRWc9ArwhDssbFe0nd30k/nu4AZiJyLJvi0VhI9QOwkiEU?=
 =?us-ascii?Q?rq+qGzSktbGJQQcqk/TC+cvzDj55e7C1JbiQ7LRQ9rZnjsjRiXc5YTKbhu4e?=
 =?us-ascii?Q?5iOK1zotINUVlndLoLIINwwSLFHUlhYag3HBVoj48FlwAMs1w98PoAlnMHjR?=
 =?us-ascii?Q?WHjvqiTrrj/26IwxU1dfC4ZOMK3xvrWa9GaadGJQmfQJ3TTMIYXe67uqCZDu?=
 =?us-ascii?Q?cds3iTRBnaGRVfJUNpbXtsNmbXKGeUiCumlXV+LhFIWESMNQDlkRk/AbyH0X?=
 =?us-ascii?Q?dLb2JrGHUJNgOic0NRJ5ntjjVSDLKfd5W8qdMHPEW8abnvsJoo7jDGjF6s2u?=
 =?us-ascii?Q?rwAlPaFUzJCwAFhNMm7ntJuULsPA74wQLC63T+U8rXOZoYzrjTqthgvf2Szi?=
 =?us-ascii?Q?UoDDSWNMjK5ebJkh4g421XY1SJLp66rVqfvJIE7v2aV8d1E8u5h7MAEvMOft?=
 =?us-ascii?Q?BCNTBu/dhzahsvSUrTGIyXwbayELojB6dLNtDYICDP4diJfT0OkqtDMN/8qp?=
 =?us-ascii?Q?NCFpcabTUmMVxAozFNqiv2ZmpYzbyioO9GLG6VerHVcu+CoY3+d+lf5X+HyR?=
 =?us-ascii?Q?up5PS+MCTar+yAK5dheo4lcxkdlCsVBuwopPI3undvxK7NeJOet2pTZq3NQh?=
 =?us-ascii?Q?OUwCyrWlBSv0zs5rEtGx4sleisBFm8/7wwgsKbKvDw4S0lTaq0ncM89hifYo?=
 =?us-ascii?Q?kQi7gKIGtLXU3NsNfZjj1tw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144972616A871EC4F15CDDDF7379BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8271ac6-8e1f-4119-1a4b-08d9f2f1b06a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 15:16:50.8029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcuoQe0KqCvwKstq/OcKNQDvroJqN9LMa5MMi26YiXUvKtZH/j+iyOa49TgwC8nealpcgdqTabpeWok5raLeSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0226
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

--_000_BL1PR12MB5144972616A871EC4F15CDDDF7379BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, February 18, 2022 9:51 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Shi, Leslie <Yuliang.Shi@amd.com>; Cui, Flora <Flora.Cui@amd.com>; Koe=
nig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in virtual displa=
y case (v2)

vkms leverages common amdgpu framebuffer creation, and
also as it does not support FB modifier, there is no need
to check tiling flags when initing framebuffer when virtual
display is enabled.

This can fix below calltrace:

amdgpu 0000:00:08.0: GFX9+ requires FB check based on format modifier
WARNING: CPU: 0 PID: 1023 at drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:11=
50 amdgpu_display_framebuffer_init+0x8e7/0xb40 [amdgpu]

v2: check adev->enable_virtual_display instead as vkms can be
        enabled in bare metal as well.

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 0d4ad1ee8348..1043e599b734 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1150,7 +1150,7 @@ int amdgpu_display_framebuffer_init(struct drm_device=
 *dev,
         if (ret)
                 return ret;

-       if (!dev->mode_config.allow_fb_modifiers) {
+       if (!dev->mode_config.allow_fb_modifiers && !adev->enable_virtual_d=
isplay) {
                 drm_WARN_ONCE(dev, adev->family >=3D AMDGPU_FAMILY_AI,
                               "GFX9+ requires FB check based on format mod=
ifier\n");
                 ret =3D check_tiling_flags_gfx6(rfb);
--
2.17.1


--_000_BL1PR12MB5144972616A871EC4F15CDDDF7379BL1PR12MB5144namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Friday, February 18, 2022 9:51 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Shi, Leslie &lt;Yuliang.Shi@amd.com&gt;; Cui,=
 Flora &lt;Flora.Cui@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@am=
d.com&gt;;
 Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: bypass tiling flag check in virtual=
 display case (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">vkms leverages common amdgpu framebuffer creation,=
 and<br>
also as it does not support FB modifier, there is no need<br>
to check tiling flags when initing framebuffer when virtual<br>
display is enabled.<br>
<br>
This can fix below calltrace:<br>
<br>
amdgpu 0000:00:08.0: GFX9+ requires FB check based on format modifier<br>
WARNING: CPU: 0 PID: 1023 at drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:11=
50 amdgpu_display_framebuffer_init+0x8e7/0xb40 [amdgpu]<br>
<br>
v2: check adev-&gt;enable_virtual_display instead as vkms can be<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enabled in bare metal as well.<b=
r>
<br>
Signed-off-by: Leslie Shi &lt;Yuliang.Shi@amd.com&gt;<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 0d4ad1ee8348..1043e599b734 100644<br>
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
ifiers &amp;&amp; !adev-&gt;enable_virtual_display) {<br>
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

--_000_BL1PR12MB5144972616A871EC4F15CDDDF7379BL1PR12MB5144namp_--

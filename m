Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A692AC3A59D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 04:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94A410E239;
	Mon, 24 Oct 2022 04:37:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C7510E239
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 04:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzobDEIGVvbX5ine93IoDKFs9sjhv0PAnH65qaExigZQ82V4s1NiKU5KhlcXZhsHfRIG56NVIMAry7cNSDbLL9e+WETluUdIqvf40VmvQRG/uTMSTwV6QRciM2blTfTFxDqSVd6LYlFaPvxng8RYj8j+kW4QPl/Y+wroBiI4rPEB3i2K0+dt0A9DDqCKIVIMDa3llWVsT298j6Dpdi81ZeUmNO9PN4HtdaBhKKpOtzuY0o/9rlxdlrO90KDsnd6p4qTbZcmRXxQZG8S4vxMnZAkVLk9B9r/EiRQxsdRS26Zb2WP0ofe28Gx3mbas1bSviCo79RH3ZLqMmufGNUlwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgTX0PIk9E3A6gU30ijqFEuKk6RzClD4Go38DSMxUyw=;
 b=oKkThr9gbcTpGj0Fhvjxz1n6iWEXrwBOzQAMQxyBER6Wel7wYFQVE9LnteUoQh70Fw2sQvj5MHAfT8jghj6bz7IiLZZqwmLgfp1uJe8zMoF53YamLutUKpvtysJwtU7vi8Yf20j/uonXGnNKWSGljscEgVVf8IFfNIqoP3t/fVJ5TDouUeodH0YSskEUzAXcItReMItaYsK6WBGFeoU6XFoiKzHWaKKybd/kqe+OtU2oWmZi+Tf/MyJoEfTZE8QsD6v8X+2zvXt00p1TLxpZhJznSe8HPCcN7UTgyLukghwhGtfMIMR7ohnxzdFvLkB14mOuNuUotLdUXsgmqNFRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgTX0PIk9E3A6gU30ijqFEuKk6RzClD4Go38DSMxUyw=;
 b=ImFmTUYTPnZLJiI7qMX6o4u4PLRhciHaj2RjxjBzr8sMx7nHfxLB5UC6MupUDU0x9+9UN0bNX666i80ls75jF+AugKBci3LcrFMQoCX2MGkoFoddvGtic+oYx72N5htbSXWU/RpKymSNLa0WtSc2UbkaNb49NU6RNerkqX+IVeU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 04:37:31 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::aa23:a85e:de27:6520]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::aa23:a85e:de27:6520%4]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 04:37:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: set fb_modifiers_not_supported in vkms
Thread-Topic: [PATCH] drm/amdgpu: set fb_modifiers_not_supported in vkms
Thread-Index: AQHY5pRv2PjTVOWZ1UOM2ZlT//tx6K4c9z7A
Date: Mon, 24 Oct 2022 04:37:31 +0000
Message-ID: <DM5PR12MB2469B079C55BCEE73642410AF12E9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221023040246.2491869-1-yifan1.zhang@amd.com>
In-Reply-To: <20221023040246.2491869-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MN0PR12MB6199:EE_
x-ms-office365-filtering-correlation-id: 80992c3c-1abb-4ea1-36ba-08dab57976e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UridLjqxEDVMSMk7kWm9mTUyZNqOGy2QP03bplDgrVU8gMC0MykJ1qb6z2J20ZWCrQjsTAthyfH5WFOJsNHuqSffYdDbyIe59ye6Q+2p+4CsN9eRSfePnuAFEM9wdziuWP7lzcP/WjVXXxrjAUgQKk7Hx2GNfS41K1+MKN4nLvYodV7OsgxAAReoG804mS9rrx85cH4dO/PFknz4pg0PPPb7TJi8szyTI8ryelxU4LJNxucMUAAyV0uDlFUd85otyOndLftC6IS4edBr3lnX9e2Cd4R09Yx8s1ghUJ9bGcSgPxEV88XwvXrUAOn6gKqRX8lB+cZ3cMK1h/rDx8uiJEt64ZpgWzbh9m3OOQ+//FA6ZWUqnxKEaoyGiNiACl9CYwF1ctzl+/Dr3FKYaj+ZstwowNCy3EX4M7os2c8ZkaJ4z+s5jkxx83bbDKWe6kUe0Y16jFGw8sbGg0rSrrW4ogw+dxKuakymd4/flvD38zgSehBIh4wGPVlG+72K7WBgtjW37FsARnu1jI9N6lD+Rb7OJalY3PLOiQz61eQSEaTpNJ0sWsL+LUu+nZFwziHl4Jf/q29XrBWiiL/yizqe9TzA9/1OZ97Brk018IDCtk1jh9vla+wOiFS71P0xVhcnmF3n0R7Js/tkOKHOnx0e/R2WkGUixAsaAeKJydESBQ1fiXo9xY402osk1y02glyoVscs3sjRtCUJn0nA6yNlcdGRpHp5LJMqVWpO55hStOsCipd8HNd0C8dU1tJDU0fcQP5jWvEPEe78vr1SZ9J/9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(26005)(9686003)(478600001)(55016003)(7696005)(53546011)(71200400001)(6506007)(2906002)(86362001)(33656002)(122000001)(316002)(38100700002)(5660300002)(186003)(83380400001)(38070700005)(41300700001)(52536014)(4326008)(8676002)(64756008)(110136005)(66446008)(66476007)(54906003)(76116006)(66946007)(66556008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?14ED7Q/83aZO0HdSeGkpkoi2WLDV0zkc9hKbA+lCeyN0Uppfbq07KMlL9ZS8?=
 =?us-ascii?Q?VtDfUXgJtqLMHl6fljX7jk7yKsOzegrXQucsKBR4URasXkLvwwYpSj7Oexu1?=
 =?us-ascii?Q?YdTLEtwRVlmWGKUxym6RYMGI+1gb7iZCBkLusVxoxnl+tYPpYl1/SVJ+fw3L?=
 =?us-ascii?Q?/Y4QDTBAxihk2EMbNBLilrfsTWeUX039CI0liBZllM9oE7YH/1nr/NwNWATz?=
 =?us-ascii?Q?5WQqm+Q7S2ES3NbSTQxtU1aWDUJNEIohLzcN5V3sBdbKHFiT02RIjJiWiTMf?=
 =?us-ascii?Q?aPUUIXb5ZZUGRgI1OedUBFYgb82OW1Hv8P7S6N29qF9gok/cltYsMSrxnOkD?=
 =?us-ascii?Q?PZ3cjb/tQjc28XISEZmiIboK5g04Uu3kO6pkBbK46+BagYiN8jl3bi/F+VVn?=
 =?us-ascii?Q?y3iGjXy6WZB9hfXLXRnwriwZwAEyWTMAIMwIBl9e45jsT94CMhxfETz7BhVp?=
 =?us-ascii?Q?Qe0SBnaGBGcNo8VjfT4/Yh9Y1jOxqa19lxau9INI7r4CGe/7h/3YtwNBGEUE?=
 =?us-ascii?Q?HQLqH0JlehYWG4IBL1B0IXInvvVlQ72g2C7XUv8Tdz6Tlbtti42U04XlJrqo?=
 =?us-ascii?Q?faL5lTXejZGk0J6eoFXX8TQ7FuPSZ2k0Gv2aF84b5omIYX53CAhE2XAzE/BJ?=
 =?us-ascii?Q?jOMQptmW6fBLLxYwmwoo2ChLnLrkB29zHXLsEubWYsSZNRs6JyQzM4Y+ORW/?=
 =?us-ascii?Q?K2P/KWoRKvYPBwObpJNG2cNglG/cXfyeZuhwQ9A89A4scEl9gckQwOIrdzcv?=
 =?us-ascii?Q?y+f8BYhLWR1LMGfbsZM5m7kgMqdhbiVYksRGUxLVuOQPCBOt7LGGWX7oC8/H?=
 =?us-ascii?Q?uNLUQsu5x1H63EPct8NBLOdOqUdWWOtLX/edWhvXPKP639uCtvUrcEheLAvk?=
 =?us-ascii?Q?AXcEA3W7JbHy1BxGbzVWZimRdfB9zTYggQcxNZvUsLncVqU+I41vTJk62wE/?=
 =?us-ascii?Q?/HDiVlkVpJFd1ED2KFjmWTdYohbFUiADsKBgUtcaqWKcpvdsmS1aGc1iEHy3?=
 =?us-ascii?Q?2QljoaaKcO7nHBruqXb60GGXnQwdC0WfJXbuAfxbv62Oqtb306bBRQcB9DGR?=
 =?us-ascii?Q?WWXxsGi66StQOnE3YnLoY7ulgQxd9TIHGH8CLqpjojNXpPsHg6mGQeBJzjx6?=
 =?us-ascii?Q?UVQXxkHlmo4+uUP4YtL/mjvlY66fRu+v/gJePiQaonX8fF+TKVSsHAof5eia?=
 =?us-ascii?Q?Q3TtIXMiSCyLpEMkNEhPFDE839slfKhSdAEReT779eqdCQeVEP3M+PdWgU+f?=
 =?us-ascii?Q?XwCoZtUh542jcapLMydv3Pgc4MEK57Y19Av3TCl9Az/bpH+ANjlTSd5RB2rV?=
 =?us-ascii?Q?kpEN0wzco1WKKcgT0CUNafGy5g2ptUiXWfRUqCfhzPrS+8djdG6s7syw543H?=
 =?us-ascii?Q?mjgYx6JBtNygSofWEG2yQxsQ1o1LmeDAEcHF7IkmZC9wyrqpnJAVYFzF4vQY?=
 =?us-ascii?Q?9jwj2Z51gsFknYhifMnCqaA7B/ULDuKUVGsgIoQk2spf5SbqahwwW55fG0v7?=
 =?us-ascii?Q?xBtgMbWKOKrtfXtaEO1/aSoqdCuEIBY0B/A3rcfxiRs6F+sbeH7eT3ePebew?=
 =?us-ascii?Q?CIHHKR0+s9KohDfNW6cCa3X3Z+RC6ogWhCIgqANE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80992c3c-1abb-4ea1-36ba-08dab57976e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 04:37:31.6462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtIPbceULcXMeN8+mbMuHb6TUxy0ZN7SYf8ay3F2OA74pzkyLbwCE4/sdbrsxZz3mJJIYyZf0WjpFvcYPd7x3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Maybe it's suggested to add it in amdgpu_vkms_sw_init?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Sunday, October 23, 2022 12:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Koenig, Christian <=
Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: set fb_modifiers_not_supported in vkms

This patch to fix the gdm3 start failure with virual display:

/usr/libexec/gdm-x-session[1711]: (II) AMDGPU(0): Setting screen physical s=
ize to 270 x 203
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): Failed to make import pri=
me FD as pixmap: 22
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): failed to set mode: Inval=
id argument
/usr/libexec/gdm-x-session[1711]: (WW) AMDGPU(0): Failed to set mode on CRT=
C 0
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): Failed to enable any CRTC
gnome-shell[1840]: Running GNOME Shell (using mutter 42.2) as a X11 window =
and compositing manager
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): failed to set mode: Inval=
id argument

vkms doesn't have modifiers support, set fb_modifiers_not_supported to brin=
g the gdm back.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index 576849e95296..2bb346bf0d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -399,6 +399,8 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct =
drm_device *dev,
 	if (!plane)
 		return ERR_PTR(-ENOMEM);
=20
+	dev->mode_config.fb_modifiers_not_supported =3D true;
+
 	ret =3D drm_universal_plane_init(dev, plane, 1 << index,
 				       &amdgpu_vkms_plane_funcs,
 				       amdgpu_vkms_formats,
--
2.37.3


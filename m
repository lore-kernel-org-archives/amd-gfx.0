Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D84EC001B0
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 09:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C8510E40A;
	Wed,  9 Aug 2023 09:11:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C735C10E408
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 09:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krLxU0ZQpdlRoH5WrShaYK0bs2Dy0oAl9FfMFHXFZKmDptCVIyePuiAd3R4/UDJxpjlCvJSJeLux0afdVpcV9q9VXdyqce8eXNDwckrBMJfW7Y8KUMBwcWs+eWGyfktjX3TwjGRuaiTnqsoLw+P8+owU6zCIQ81etmPI3/fGjkmRB3/oD+JC5M0QhV/OQdabmkFFplAzebXOHy3oetAqvai+oTdGkLxwp+K+Z2C1wf6nLpgY6WmFRELr3xHblGh77N0iYXupgNEHFLvQ6iOzLcIrryy0qOeHXjl9DD+JVQqIAOIpNCz+m6uUf9KJLikblZgMzeLdbCdVjp8fXZhCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAnTruA00iclddPcln/RhxULKLr2Kvwr8g3QWnoZ/2k=;
 b=PtGiMXaPm60aOg98ht5NkoH0cXdwD2oti5bYxY4T/JkvRKJzDMjTf1O0lNDrsLTug0v179JmmIpJzdvPb6DzKYUcTouprCvWkV8HzAGZ2IcbOwBaaZ5WO14AghSMA+uTNl09W042sVtrIVYKx3bZ5O0MtpBZOVtQIOP3Aer3Ot9b5DfLaPbKz+ypnQDPpEKG/i1UwEXf+8RaX3bBy2pRv0HhF/neur32fMIKDdx7oKZ4Q9zglGTG6bEniSS93/7zrkMUJpyBRKPIOQO+h/J2eTo/e6FdamgFORj1mi8VuIohHIBCw5HTr33esQe6hXUyyP6uZjsRBqUTFt2dyHUVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAnTruA00iclddPcln/RhxULKLr2Kvwr8g3QWnoZ/2k=;
 b=esh9e3tQBkN2v1t37e+M+6MNjv8eBR68WK2u0OmNUKhIThq8X7Qgc3JNrmDOepcICb9H7pfpmzWK8fQcIiwE7Dn3L/WvOI+wr2raeSJv+5JyNVUZ4mh5XiuDcsrasdYX/4R1WNgJ9XsfwKGVKjnpOlhQUYNsqAIF75ilseEgNxc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 09:11:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 09:11:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Add vclk and dclk sysnode for GC 9.4.3
Thread-Topic: [PATCH] drm/amd/pm: Add vclk and dclk sysnode for GC 9.4.3
Thread-Index: AQHZyqFPC0FcCCvF6EinStPnymP1QK/hrbqA
Date: Wed, 9 Aug 2023 09:11:50 +0000
Message-ID: <BN9PR12MB525792B29483B645FF02D432FC12A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230809090951.435142-1-asad.kamal@amd.com>
In-Reply-To: <20230809090951.435142-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1e4b0df8-ba14-481a-b710-702545459fc7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-09T09:11:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ0PR12MB6685:EE_
x-ms-office365-filtering-correlation-id: 9a1c4bf9-b1f7-4a22-78f4-08db98b8aac7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sYtQn8veCH+LYnF40TH9psJvaPQqMV3M7li3S73WIXIKNBGt25GCFbQLXVf3Kn/xkMmZ60+DGemlAZHuj+NJWv0S0nT/yzcv/SCiQp9DCAKPXBikSjnAuTLC2iICNOybiC3qHU1JCOwbaPPoo1e/QTa6ZAGKXYVlOf6m3UoKLbqwr8yAJEm5kigOKrAn1xWMOfYfifTWMBvO+ZtRjom5DJTByeDT6Qn/3ZGbpHloNw+ugl8ePs16gYwPbNqMYBtu/BJuYwPgI1JwUZV+gzBPcllziTAOFEoZilJgOA7XnYLmeY8lnuWmDDPUQb3PmdMWa2WE19Dh0tgpHBnzmZdk6ySZMKS6zwGvIdB4oxGua8RGZG9M+xcE4M3OfQc/5QRkUvO3LbEANNAlij1VpW993+kgSAmfKaQ7UtW0ptfFxv6vmSKeTxtevSB5nIFT9uRL76Mg6af6exdyQ7VXfCq2tBF3rpNDzKVIbyCtok36jaV0W6/Y6YJJqNIC8+ZO33BPQfVEShDd44qVP8ecCWk2+lu0kVEGGqjiOXNSLKD2EDE2KyMsr864iNkxjWOCReTK4pkfHPzfXHtxGXEete6Buueuy8Lteb+P8VnopmPetoOmGxvJL0vkXK69y3X3wVQx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(186006)(1800799006)(52536014)(122000001)(478600001)(9686003)(7696005)(66946007)(26005)(66476007)(6506007)(76116006)(64756008)(66556008)(66446008)(53546011)(4326008)(110136005)(38100700002)(316002)(86362001)(71200400001)(41300700001)(2906002)(55016003)(83380400001)(38070700005)(33656002)(5660300002)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g/NlKCckrp26KWXix4YmWGXhIc+gaFmZzTnDvow6dXPmQI65Zip6KqaoNfMU?=
 =?us-ascii?Q?alUUUNoyksjDWdtdeYHEvsfUixItavdQvQa3BSnWpl1zv4gYuUETceTXJHWx?=
 =?us-ascii?Q?Wr+XovgAi2NN6myA5ZPWwy1TDME9Kt2RltGhYmMMMLup+WCaWKllMB2NZE/Q?=
 =?us-ascii?Q?VbDdiPJw0zxeiusg9CB1xo0aTm1/M80jw8b0f8WqvX8tExoUwQejuoouhEFc?=
 =?us-ascii?Q?WGhDpgMYza/6ua152H8pg6IOQvzNu81Ec21bSEqeAfVo0punnfexku08DPUr?=
 =?us-ascii?Q?RWEOF91gVUGbQ3kZNXmAPtbmDkQpAE7sXea6v/yFhzUCX0CcyXdc+g5kwN8n?=
 =?us-ascii?Q?Xizkm8Q/sCuNo+t99yuZaZWB67u2xSRlDzhdqF8jM1ZAGJdw1kW1Z397gqza?=
 =?us-ascii?Q?QTEnghOS1Cx7OXYz2w4eWtRfcio29DVxwpXaB+4eMQ7xSUXS4Yx7RfQ0Ih2g?=
 =?us-ascii?Q?CE52dJV5oi6P2d82kMvP/S/KFthQc0uuY5NZcXnbic4NObuD65cFVKyXvDT8?=
 =?us-ascii?Q?WztsLhCLFaFgxqkgbLgqFWqFFTHUGTFijnR+USMUBYAfhNG+pOUDNI6J2Aei?=
 =?us-ascii?Q?sdJwACbOmRyYYHXjv5qWPr5PKuln+CSl1heb7QkJmkuI+xUVfmM30IGiWW8o?=
 =?us-ascii?Q?Zci88kjyFhoGzGevkBQszJlSW8PD4WNQtDglTlrcehfxh1txZYA4ilW4KAQ+?=
 =?us-ascii?Q?YJ3+5JQ5bxuP2p383aeN+TEdOGv8fP/I+bC7VW15ex1isQMdz7gBn/kI/G31?=
 =?us-ascii?Q?u5uIXVm3jdF2tqAOKHznU4k7qCaMBEQFyuGpLBP9SzX4PK/rqXM1TQcGTUx6?=
 =?us-ascii?Q?7GHBS7EDuVo/uQpC50BL3gLdJW1A+KKub4cs82wwSjnp1wztjx+ob3eYYub1?=
 =?us-ascii?Q?kWzoE0St/pNv/4Hng+r2GA5S9/9WhlIwH9rCel78Sy6a3jfbCI9x0nH+F2De?=
 =?us-ascii?Q?vjaOIqBdzeLtfnJYjzAPUyzNnJfgD1VMXm0xPXM1TIkQIafAPGrrQUf6EpYF?=
 =?us-ascii?Q?d4afPMkBWvQo3yRfFfphthDpTYBkVM/XhnRqcxGgKhDRapj76Sgv7SW6K68B?=
 =?us-ascii?Q?nKcmrV6qS5lKHezcWKbNHF4fFsuviIHnMG52KtpztmmFG//SvrfagTbCaB3S?=
 =?us-ascii?Q?K+cAPjcF6ZzKACMIsf9VYvmvmiIn/zP1tIYxKBbXnP0Fu9/3BadO9mNzXjn7?=
 =?us-ascii?Q?XwWmigO8H4krikMBH5GaNxo4S9bB539YeXvhCode6gs2Jp4g4lR0uJ9RKcUC?=
 =?us-ascii?Q?DqH7hODPWKISO3v7v0AW3l6Ja1wsx2WNetHkbFvvjKwF5ABVW9e0OSgUYzl6?=
 =?us-ascii?Q?cYj0hlraKkkXrxl7PSQibe1rvnEvmGVXVU9Jte8QupFFXRBHeOYkJNs/zqFl?=
 =?us-ascii?Q?GECfdEfLHRubOorD8W11KlDnFmWWln1wS3zCCASZSJRA5NNVu4Uz5npPhPdI?=
 =?us-ascii?Q?NSkXjgTkpI2ZquPvJ2xwc7nAt+sxmiIsFBr9Lf0yUQWcswFwmw1zVLGZwmLs?=
 =?us-ascii?Q?oWsDg8U2Kw4qQx4GFD4KhvfEXr4RTIbMfgZFnnsYLAcVlFesDdg5LEYiM1Of?=
 =?us-ascii?Q?WmvukoGfpe1x+6p095FQRtenriBD+NAdHob/4mef?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1c4bf9-b1f7-4a22-78f4-08db98b8aac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 09:11:50.9124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBEFDtIE5ifScFI9XeFavkjx078xjBrgufzoVW57jt86XUuYKShsEfJ4Fk/ohi/Q2SdsLPcI07ggzUogSa/j6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, August 9, 2023 17:10
To: amd-gfx@lists.freedesktop.org
Cc: Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd/pm: Add vclk and dclk sysnode for GC 9.4.3

Expose sysfs vclck and dclk entries for GC version 9.4.3

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 3922dd274f30..e4183d6d7f39 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2095,7 +2095,8 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
                      gc_ver =3D=3D IP_VERSION(10, 1, 2) ||
                      gc_ver =3D=3D IP_VERSION(11, 0, 0) ||
                      gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
-                     gc_ver =3D=3D IP_VERSION(11, 0, 3)))
+                     gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
+                     gc_ver =3D=3D IP_VERSION(9, 4, 3)))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
                if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) || @@ -2109,7 +21=
10,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct a=
mdgpu_device_
                      gc_ver =3D=3D IP_VERSION(10, 1, 2) ||
                      gc_ver =3D=3D IP_VERSION(11, 0, 0) ||
                      gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
-                     gc_ver =3D=3D IP_VERSION(11, 0, 3)))
+                     gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
+                     gc_ver =3D=3D IP_VERSION(9, 4, 3)))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
                if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
--
2.34.1


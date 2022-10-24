Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAF4C38A2D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 05:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C38A10E24E;
	Mon, 24 Oct 2022 05:31:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783AD10E24E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 05:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp+0bM4zy1MPoF+5hlEDigkKsGvzfYEAYMg8Q+oBGGtD6mM8nODGbJeNtFRTp7bRQcrD5J+A3uZWyELGUGbnLWybTa8H1NSFW+2aKbfgFuuer/cm9uBKJWw24Tiay8Lk6od/6FywLswgKlEudH59htq5zlahBPql9+zIYfQoOGH/opHK6A3cG0UNTAX60Vv2Sjd+sa/Hc+s8TQQXb9vzrxp2oRpsHXYrGyay15CcfRyY5dIkEpMMvDyWnOL5mt3fM0VG18OmKJSpMgW9cB+fPbJogVuxGi3WNKTfGawx8jYGltAzQDywb0ZgJNugSvo9CS8T0+P0ky82d2TpslD2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQWuI8AV7dCwHHmDxB35ESmNXol6+CW38i3Lkjfvn0U=;
 b=hzctZ5N3tqyssNWs70YCtAS9xBpmz5O2RiEVaxDOwwyoMMakn4GOcY1vdqnlQu1OXbdFi1nmbrs6IEBjSV5zLutIjR5JR8YLoYNKfS1LHagXbIh8jXE1w3sA32bmMZ7qlgVMUiA2baAuZ3M3szk4YdpDS82Ho697oO3MfM1JazHHH6UA1V+h13pWUELXPgEKk+87J1dQcgFrEfaSLztChBiCHLa09KY6GjIroEfJz6SVutSCm4l+HMMxDBVnG1yYZrkSZhKXakdxIUWEjxATjLlTqmEED9zBZtjf0VfgC03lcPj2Yy21AEPNRZdkDuoUb0pqV/pFW/nA536mjqKBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQWuI8AV7dCwHHmDxB35ESmNXol6+CW38i3Lkjfvn0U=;
 b=sCrMMZQEkfBloI+XAux7uNEP6tW2Mk30rLIW/0G6E+rdfmyEA1vtlwY4P8s9a9M1Ay5tJ8iiWEw5TOrQ+9zqPtHngYnUPlvjEzQtUuFbngPVpgzPP7YHpnkrruD2AW+O6NfoNlp2SXkmAc+7QBl1wUAaAM8KH5EF1AhRDfym3Lw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 05:31:24 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::aa23:a85e:de27:6520]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::aa23:a85e:de27:6520%4]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 05:31:24 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: set fb_modifiers_not_supported in vkms
Thread-Topic: [PATCH v2] drm/amdgpu: set fb_modifiers_not_supported in vkms
Thread-Index: AQHY52RMux2WrJ87OUWTfa8LySjAxa4dBM7A
Date: Mon, 24 Oct 2022 05:31:24 +0000
Message-ID: <DM5PR12MB24698EEC413178F8B528B8C3F12E9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221024045113.2532106-1-yifan1.zhang@amd.com>
In-Reply-To: <20221024045113.2532106-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CO6PR12MB5395:EE_
x-ms-office365-filtering-correlation-id: e91290e1-3b5d-4a5a-11c2-08dab580fe09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +OKXJmQCF9GEt8ZLaypS42DfRuhPSjceJ2CzWcWtFy4bM+rQMBsbh8b+NzL6XhDm3m9LIo7JxxzvwUshI1l9GM1nXzEsPuGIgB51XzXex5KZ5wipIFG8SSw2TRGyA8KhETKSubwQJ2GPlxxOqvlks4+ba1DFbDgHpo72UirZYf2IKovrHUPYKyeTMN9M5N4NJEqG24ZzZzMmG+y2v9DnFjLk17QSPQA7O8b1CskXvuFNWxXJ6n2sScYMe7ZwWytwxC0VJmeBja3kpVLArPFefJpvfsbgdhPcg2DBOmvCqjRhp/HvXyb6cv/uz+JRGGjhdBZ336VKWa1VcDRGe5u3ML0YS0UZw1G2kSzDEp5cs92KBBJI9fo2uJQ8Eim+f8qS6MMql8Gcb65rmnK9F7xuwSM9CL1SROFGQgcvCTLvVDEFfRCGs3J1u7YhMNURqZqmsT6fhiHUJB3FhwgmRwp02yAT714c+Y4uklAbfHb2cz+eixzXt8t2fqMAq88a7FIHMuaeBZz17ZRdcuDJmQSLUmxAbvq5bPUuHQK+jSKxhXGszGpn/BTz9IPg3wHdMj6OQnQndEFk05l5RplRa+5iqtFSE5h301eINwvYc2GC19zVh6v9LaXs8/ksAy4Wr1zsGovKSOL+7gZ+Y7CwxztwFLB5WtYf9gBg99EEfA6vYqMgG8MRJhr/whrctgSnyyA0Bek4j2Kl53R7d0EBHFrY1opebhlP8+LcFqNRgH7WSxHTvLi/TUrUBLGq5JpX/nG0EsOed533SUc6ra7QeKDvaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(52536014)(5660300002)(38070700005)(41300700001)(66556008)(66476007)(8936002)(33656002)(64756008)(86362001)(2906002)(83380400001)(186003)(66446008)(71200400001)(478600001)(7696005)(9686003)(6506007)(53546011)(26005)(4326008)(76116006)(122000001)(38100700002)(8676002)(66946007)(110136005)(55016003)(54906003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PCaf7awTB7MnDSowLQ9kEyB658UvKMR9JhhJ8NhxIL+7WcVQJbfwcyQOAnV5?=
 =?us-ascii?Q?yZP5aYxOs1Sg8TnX3EgWxcN6f+9qqxXTFLPljEgdQ3XG67tB0p1JVzvZcpIi?=
 =?us-ascii?Q?GqCWH1L8UnTBlDNdQAKF1yss+rKyYYD+qZ7ISX50dOIWpGv8+UPv91CJHcSw?=
 =?us-ascii?Q?P6pDwVgZFnfL2LEsld7gTv7QnOk99S4MVXcdiayQw2wmeAHYL3Rwtxzk0rMG?=
 =?us-ascii?Q?wLEizpS8SUK3fM9f4OeW/Rn2YCOci6G9K+9Is90Ji8tkjKoGWrq0GPTQsomc?=
 =?us-ascii?Q?iH2/kW39mxXcdqhhDmUbO4OaCjlztX09CJAQKDJZeMwsJ5je+EpStPRsxswn?=
 =?us-ascii?Q?+PlSOIK/xW3XOMFnVhgGAEH+FKYO9vhyAW9eJK2mmQc823ZoypUBUPXBvtv8?=
 =?us-ascii?Q?l1vRvHwuns/9o+4Nr/gwoS5UQvRP7/oQ9SwmpLBxeNMqzIh1bUlsrEJEbtNr?=
 =?us-ascii?Q?PovYKN8Emui72fI2gfvv5A6b2WFcb7PwrwfjTZhoJVgLBY//N+fMWEZrX/De?=
 =?us-ascii?Q?+/STGqeEArfFXJfMcfpCM5bOGI6DjgHUHBqS10/4iAuE4XD+jBFUzOvbjRLB?=
 =?us-ascii?Q?BcpzJIPufLH9vBLl7jgCTgAjAUi1QTzh15LRwl3/SfkkjPQAa4L42x+VMzXf?=
 =?us-ascii?Q?fp3x4/oII7fdMubwjWpGwCczUXGjtzXp/RUF6F7/+WeVKEe8yfzxtT8K43if?=
 =?us-ascii?Q?1yEZ0WCfN+rPifFoghBSiVmYTDHsMs7qkkbUqMMKerR5Dzuec4BF3CN+tZrb?=
 =?us-ascii?Q?Wfumw5By5RdShVVE/eciflPD42NLGKzQ4wOLA32QQQr4D5aTtnHTU7Yy5GP7?=
 =?us-ascii?Q?jk9ZUsYJTrBVeYfqaAC6sYew4gAdTCtm2VqqhGVYFQ744y3hC/o4HyDWdIDm?=
 =?us-ascii?Q?Hc2XN1Wk0XdA4qEjWtwiATUmzaiAJvRmNZxWbjqnfHHCXD9Y051RX0uoS7YY?=
 =?us-ascii?Q?hiojYCuc7ZeW3uETKbStgBZ2UHZSFViIz3ZbwqdUtkxKuaIp4+fepnbKNjSD?=
 =?us-ascii?Q?Tk7I8IL5jLCC949PBQ7iYyowo6IChkXbbTvCyuSaxJt05kfNJdtzQAAjuXgK?=
 =?us-ascii?Q?jzsMs+/8QCSd/nlW4jsIrfFdflXuDcqgSY3q0IeiaLS7BJx+CV5FW5sjHDve?=
 =?us-ascii?Q?yFZHwk4xXrPCA173QFZv5DZwQpqIQ4ieGQun9EZytEDwKYe6w1dmd9IwY6rv?=
 =?us-ascii?Q?c2ToWTgyaDMu8YV24UYjniBadXUG7UzgxtSyHZ1NKZ5hpmlVYcn4dYBlfGKY?=
 =?us-ascii?Q?yAJoTgxRrh3kBL0LkYe6GnjyqvS0a8hvxC3XItYQz/l+wLfnqBeqpI/u0YLE?=
 =?us-ascii?Q?Rtu+9euh/UYUMSLJL+XCEyBbVV+wLHSBZix0Kv/rqkpptcj97BYBwW6/ukwz?=
 =?us-ascii?Q?W9N59KOhyPYtND/0SsAOseGY6Ha3z67dv+3c4gsxVsdldrZI741RaCI4qnYn?=
 =?us-ascii?Q?gbcDasQ6xeeIdI8wLXRanikcA0RLWwmp55NuF+HqwA9U428MVWjZ/1Fg5N35?=
 =?us-ascii?Q?Q4Mcr5Tg4DaOmAyntI19dUm8LRRzj+7hCEqxEye8IWYsSdWA+bpLOermItT8?=
 =?us-ascii?Q?WL3DKJByxrnkMGBvWFJ71vvPCC0kMee4ekQ0bHkP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91290e1-3b5d-4a5a-11c2-08dab580fe09
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 05:31:24.8326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pNo68AaF4GCctQ5UaVnVSG/QKfoWmGFpb+DPG35K4greTiRQ+Vp5ZfQl5cJVCACNuIzJ+bRMOxxhPNUCwAnxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>=20
Sent: Monday, October 24, 2022 12:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Chen, Guch=
un <Guchun.Chen@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: set fb_modifiers_not_supported in vkms

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
index 576849e95296..f69827aefb57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -500,6 +500,8 @@ static int amdgpu_vkms_sw_init(void *handle)
=20
 	adev_to_drm(adev)->mode_config.fb_base =3D adev->gmc.aper_base;
=20
+	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported =3D true;
+
 	r =3D amdgpu_display_modeset_create_props(adev);
 	if (r)
 		return r;
--=20
2.37.3


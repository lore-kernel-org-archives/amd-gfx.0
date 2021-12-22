Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BDAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 11:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E3010E884;
	Wed, 22 Dec 2021 11:25:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 545F510E883
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 11:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy9kGTGJJnkM+yeSRvfWjtNu/3vQQXM3hGhWERKOxy2lAnnJ7k0mqDz3PzEFzFYoa6YkvlxZ5QTFEf4oO2gPLQBucQAu+1gMoahiup8wmVowEdhGdPxb6uU1KrZSrl7ZdHwO5V2867wfEGTgeQqn8uwAwVopXXfV9AtqAF2sAmzw9ltJNb+ocqi7mWyeOFQNLLV1F+0WdzPdh+SEYbmj+jHCSi+GtiAcqXNTGDeE7nCWwgL8KG4Y8XBFYTRDSQsVD6UIq281yja8h49Ji/jJ3TGZJFB4AnzrR2K7rjmjEaoPUddhB8k5LjNB2wiGkjBU6v+NhTXs39wojbaRtKWNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wovm92xQXGVfHKRLHTFnvJCd23fJTpIXGc5YtnQOlmc=;
 b=KbUjbKogmjuJk3Qc9ewiIWpB5ZXChrEA0Uxsxd1BrLHhbcnpf1vrd0u61Fpa7TSs6orD6rGA6SyoatNZCByu7P4WGvQqJaw9NaR6e3AIr5wuZbOIyxZNQNvBbikvz7dayRnSh6CQe3po41mt40mTuHaMO/WphF+l/oLAL20woroOWeO4PLhR2yiTVYPjD1P10RbaqRV8/NW1e81xNf8sfIYZiDweBEF2ENfQHotL8y+vgTan/xNXufUAywWkO2MaVmT05OnEzavclbEVl/BX4wC29pzCKV9K3T68JiXgZ90I7wqM3UI2HV7m702oLpFUzAwF1s/SO6UH8P8zJed5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wovm92xQXGVfHKRLHTFnvJCd23fJTpIXGc5YtnQOlmc=;
 b=Qz1rfTKerM91SZdf2BiAvHRFY9FGDX7PUufU4ZjFKBiJnuuz6FXtbuz1fpS9ux48mpC8HO+f1kBcs7airlhtpZjCNe8dxsGYk08t1oosm1MMGKv2E/v1dhFdy3WI29sfmAoQPsYQvQ6jMpGWsVtb25V08q1Uscf875AhPXEps0c=
Received: from DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21)
 by DM5PR12MB1852.namprd12.prod.outlook.com (2603:10b6:3:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Wed, 22 Dec
 2021 11:25:18 +0000
Received: from DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::ad2e:ee2e:f3a6:398a]) by DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::ad2e:ee2e:f3a6:398a%5]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 11:25:18 +0000
From: "Nikolic, Marina" <Marina.Nikolic@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs to have only read permission in
 SRIOV/ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Modify sysfs to have only read permission in
 SRIOV/ONEVF mode
Thread-Index: AQHX9yaZ1A0RESguVEGK7wEmINJXUQ==
Date: Wed, 22 Dec 2021 11:25:17 +0000
Message-ID: <DM6PR12MB43004E4DF34D166C06C9AB9A8E7D9@DM6PR12MB4300.namprd12.prod.outlook.com>
References: <20211220160834.8400-1-Marina.Nikolic@amd.com>
 <DM6PR12MB2858E316736722D6682BAAAA857B9@DM6PR12MB2858.namprd12.prod.outlook.com>
 <DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
 <DM6PR12MB4300DD7B8B8F194198F7D6E78E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
 <DM6PR12MB26190A8388C1E472837BC094E47D9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26190A8388C1E472837BC094E47D9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-22T11:25:17.585Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: c38f7bb2-e874-5a67-7f2e-98127a302c17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6745181b-f969-49af-8c28-08d9c53dbb92
x-ms-traffictypediagnostic: DM5PR12MB1852:EE_
x-microsoft-antispam-prvs: <DM5PR12MB18527AB6A6489D7C24206B208E7D9@DM5PR12MB1852.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OrIvd6Zq2eytcQeWxGxoI0Fnzd0lXxdPu7Ay9nRDWR+FLuNQ+THggp40dAS4ErreK021WUK93/9LEe8xAhdoorhPwg6KlPm042r0YYCkJMCzNIQDzPLTigpID3b3W1MRpDD0F8WsbK16NTiUKPiEzlCA3SNdg0o51XMF7e5DzhveNIHxBc48ZbqblDHtjruEPo7jssX87VTfFRGm91515mPSgU/aQqQeuBwE4glBdoI0tCDu6SJbAqKVu4dZ6pZvcldSvpL0O0fj/Azp2HvNZndIJgv857DuPhFS8aBe2gZ1MaifulOpOIAvc6Ox2VTJWxs3VE7VP9EwYcOZAToLKHzyJUHO0P6wvABH7pTjBVWRcw2CJx9ARmMpV1CgghV/jgpCiO2poVaVhSnkRiw4170dHL6+SIknmL7lKFJDIZ5L4zH1/t/ya4HROCb1fBXd73imhmTyFsQqp7/QU9vpg1ZdJCuiyieaRDiH/wjmDuUA75TWjpCZXQ8ZcJOS0zj7WwKeauK+Y2aJ1cCCGVxZf8mxYjp+3ZTG6/T3UmClfLqOt+z+fmujNQ/kvcZRY+p64U3/58TGRtwVPcc8FoGIk24plbTxB1fnDXDhphpIQ9RtCyNWqtiGXZB8Pcgl3yRdQeeuTeHwYyZCjE8dS2UwHRj+E5g0bWCNAhSpoQ7MXMXrGEEWZrfUkmMvGapJebiRB5NUTRi57bPP4VBz1v4ggA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(316002)(5660300002)(26005)(110136005)(38100700002)(8936002)(8676002)(7696005)(122000001)(38070700005)(55016003)(86362001)(54906003)(186003)(52536014)(76116006)(4326008)(9686003)(83380400001)(19627405001)(2906002)(6506007)(66946007)(66446008)(53546011)(66476007)(66556008)(91956017)(508600001)(71200400001)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hbyUjzyWq6+TcbPKfToT32VGyqSXj7gRAJoD70v47K1MtoVLeStH/EReL2?=
 =?iso-8859-1?Q?+l1uTsZ9AAABoj0r/5aB6BKTbz2Mc+T3DnDmYUN5N1kqZK4NMTdhCw165U?=
 =?iso-8859-1?Q?ETl7jSBZdRoANr357S/y8Cus7ZQgf6FWIlsKZlyLK1AAKtkd0DyOtJ3kcZ?=
 =?iso-8859-1?Q?PKb1dcOim3iNLTPdaDC3XCs9QRQ+u7fJhwWEfxg1erejd3pd6P/P4P5+og?=
 =?iso-8859-1?Q?y3VMedc2MrlQ67bGNz0l5/95NXsz9cGVL/x4SaHxahfUzX1XYYxVb816u7?=
 =?iso-8859-1?Q?WLVQ/xaInkDTNX6vgWHc1A517Nw0IaZ4bJ0A1Ggudmxhfw/h4YN8nIp56w?=
 =?iso-8859-1?Q?dTMsW/yxQxwoP8QHsbQe2AEK7h9pRXxMihyua5LHshY2CQufFwHhUuZn9Z?=
 =?iso-8859-1?Q?2pDqSUfdFmRdBmFKYBZgeB/huXidPVLejHekRPK7nntwEdE1axFUG6FXqM?=
 =?iso-8859-1?Q?h0lR0DrTMiEctoOUpV0oxWodE/ycFf4tmpGbWvRMSWIaau/OBo0e1VAwUZ?=
 =?iso-8859-1?Q?JR4RFgttXnZrUs6mANnV/CHFI0YrcHWPg1SchIXwWNDnTBmC/1pSYR5WFm?=
 =?iso-8859-1?Q?yzQ3w6oPUeFI/9YDu2m40oPvFObRsFvAUdANmJ4663LXKussZ7Jar0ncoD?=
 =?iso-8859-1?Q?1DN86zfGiXtN3Vs250KfBo+Y+LQoGUcTUSeSkVO5BIiJ1iIR+t1MI/5bmQ?=
 =?iso-8859-1?Q?vMZCfS0ImLKeOATvE5L/d4ZGhgoDcdElZ+d+eqFLTPiiHynWpf+9eka7lQ?=
 =?iso-8859-1?Q?AA5HfRkxaqPQ1ASDK0i7X4/z9U+jrK/q1H7FMN9RLYll74wNrZCTWag8QS?=
 =?iso-8859-1?Q?9XwNICnmNr67a+k8rrunjsrD7s0xzdTqCO0oQUDQKgENLv+0zuqZlQypjo?=
 =?iso-8859-1?Q?extFTHISOFd13j8qzncMLJDoiDwEBnlFgONvuXOyaqglzSiM4FDKC6JxmU?=
 =?iso-8859-1?Q?D7EOtEL6RdnELY/Gr/M7ERkKNsyFj7iM1SIaiLS+FgwB0kfgcTklpSya26?=
 =?iso-8859-1?Q?ZG0hwpNHb9NhL0Vor2GhBxV2HUb7TDL7zkw7QmgtqG5cCazPludiOjPFcn?=
 =?iso-8859-1?Q?Z03+EjyXMTcd14lw+HUmFtDVp+6YH8n93ZoryH/VVpXxZOi2bfrkEv5pJM?=
 =?iso-8859-1?Q?11zuUU8CZqvEdVpIF87WXWCgmuHXr92erfSmsuVK9U6w7eeL6fi9bDVgdH?=
 =?iso-8859-1?Q?IXOKkyv5H+102Q+i4I/UYTMyKaPcoyNOVKYm7Hp7TvUhzqxhYKWVj8VQZ3?=
 =?iso-8859-1?Q?6cU//eDl0nB17o6y+bxzlPtptRc+x7DTcv5KZzTk8TvKPV4J4cy8LyIiP6?=
 =?iso-8859-1?Q?JCUdDqAJknfU1jzMBoF2yVgCzL0ZVZ8y3ADinnXpYVEI+/NDe2us5e4bnV?=
 =?iso-8859-1?Q?TgdjY0KUn7i3nhoo+WGSMGF9Cn25uIF5czFXYAB8pT+wAYazaJVxW8PG/I?=
 =?iso-8859-1?Q?SJXAwr3ehTD+kO0q8TH6mseFwxraFKxYM5tAjzGTTPbse2wci0gz97gtUG?=
 =?iso-8859-1?Q?ZU/oi6GN3G5rB1n2Hote3huoFM1xyVxw3nbNzqAwLG0C3PhUG1QJ/Td6ms?=
 =?iso-8859-1?Q?6CdXvW7/lswVdSPl+qqkz92FsW3DG6glEr3kiUqiyO9UVNkKFlgUJJrPF7?=
 =?iso-8859-1?Q?0eXmzA4FmoBOiq0OVQNN+SAvOw7tLhG3ojLHYtcp1nbl2Fyk23FlgfMg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB43004E4DF34D166C06C9AB9A8E7D9DM6PR12MB4300namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6745181b-f969-49af-8c28-08d9c53dbb92
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 11:25:17.9475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/7HO370hwmat6/4MLz5HEVDc5Yc7L7/8aB0ZviAOydiXpiwi+JsBJgdufCZaTW6cHgyp46trZoKUcL41evkeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1852
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
Cc: "Mitrovic, Milan" <Milan.Mitrovic@amd.com>, "Kitchen,
 Greg" <Greg.Kitchen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB43004E4DF34D166C06C9AB9A8E7D9DM6PR12MB4300namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

From a6512c0897aa58ccac9e5483d31193d83fb590b2 Mon Sep 17 00:00:00 2001
From: Marina Nikolic <Marina.Nikolic@amd.com>
Date: Tue, 14 Dec 2021 20:57:53 +0800
Subject: [PATCH] amdgpu/pm: Modify sysfs to have only read permission in
 SRIOV/ONEVF mode

=3D=3D Description =3D=3D
Setting through sysfs should not be allowed in SRIOV mode.
These calls will not be processed by FW anyway,
but error handling on sysfs level should be improved.

=3D=3D Changes =3D=3D
This patch prohibits performing of all set commands
in SRIOV mode on sysfs level.
It offers better error handling as calls that are
not allowed will not be propagated further.

=3D=3D Test =3D=3D
Writing to any sysfs file in passthrough mode will succeed.
Writing to any sysfs file in ONEVF mode will yield error:
"calling process does not have sufficient permission to execute a command".

Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 082539c70fd4..c43818cd02aa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                }
        }

+       /* setting should not be allowed from VF */
+       if (amdgpu_sriov_vf(adev)) {
+               dev_attr->attr.mode &=3D ~S_IWUGO;
+               dev_attr->store =3D NULL;
+       }
+
 #undef DEVICE_ATTR_IS

        return 0;
--
2.20.1


________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, December 22, 2021 4:19 AM
To: Nikolic, Marina <Marina.Nikolic@amd.com>; Russell, Kent <Kent.Russell@a=
md.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Kitchen, Greg <Greg.Kitchen@a=
md.com>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode


[AMD Official Use Only]







From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Nikolic,=
 Marina
Sent: Tuesday, December 21, 2021 10:36 PM
To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Kitchen, Greg <Greg.Kitchen@a=
md.com>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode



[AMD Official Use Only]



[AMD Official Use Only]



From 06359f3be0c0b889519d6dd954fb11f31e9a15e0 Mon Sep 17 00:00:00 2001

From: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>=
>

Date: Tue, 14 Dec 2021 20:57:53 +0800

Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read

 permission in ONEVF mode

[Quan, Evan] With the subject updated(remove the description about pp_dpm_s=
clk), the patch is acked-by: Evan Quan <evan.quan@amd.com>



BR

Evan

=3D=3D Description =3D=3D

Setting through sysfs should not be allowed in SRIOV mode.

These calls will not be processed by FW anyway,

but error handling on sysfs level should be improved.



=3D=3D Changes =3D=3D

This patch prohibits performing of all set commands

in SRIOV mode on sysfs level.

It offers better error handling as calls that are

not allowed will not be propagated further.



=3D=3D Test =3D=3D

Writing to any sysfs file in passthrough mode will succeed.

Writing to any sysfs file in ONEVF mode will yield error:

"calling process does not have sufficient permission to execute a command".



Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikolic=
@amd.com>>

---

 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++

 1 file changed, 6 insertions(+)



diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c

index 082539c70fd4..c43818cd02aa 100644

--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c

+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c

@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_

                }

        }



+       /* setting should not be allowed from VF */

+       if (amdgpu_sriov_vf(adev)) {

+               dev_attr->attr.mode &=3D ~S_IWUGO;

+               dev_attr->store =3D NULL;

+       }

+

 #undef DEVICE_ATTR_IS



        return 0;

--

2.20.1



________________________________

From: Nikolic, Marina <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com=
>>
Sent: Tuesday, December 21, 2021 3:15 PM
To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com>>=
; Kitchen, Greg <Greg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode



Hi Kent,



Thank you for the review. Yes, I can confirm I am trying to set this for ev=
ery single file for SRIOV mode.

@Kitchen, Greg<mailto:Greg.Kitchen@amd.com> required this for ROCM-SMI 5.0 =
release. In case you need it, he can provide more details.

I'm going to clarify commit message more and send a new patch.



BR,
Marina

________________________________

From: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>
Sent: Monday, December 20, 2021 8:01 PM
To: Nikolic, Marina <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>>=
; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com>>=
; Nikolic, Marina <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>>; =
Kitchen, Greg <Greg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode



[AMD Official Use Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounc=
es@lists.freedesktop.org>> On Behalf Of Marina Nikolic
> Sent: Monday, December 20, 2021 11:09 AM
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com<mailto:Milan.Mitrovic@amd.com=
>>; Nikolic, Marina
> <Marina.Nikolic@amd.com<mailto:Marina.Nikolic@amd.com>>; Kitchen, Greg <G=
reg.Kitchen@amd.com<mailto:Greg.Kitchen@amd.com>>
> Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read pr=
emission in
> ONEVF mode
>
> =3D=3D Description =3D=3D
> Due to security reasons setting through sysfs
> should only be allowed in passthrough mode.
> Options that are not mapped as SMU messages
> do not have any mechanizm to distinguish between
> passthorugh, onevf and mutivf usecase.
> A unified approach is needed.
>
> =3D=3D Changes =3D=3D
> This patch introduces a new mechanizm to distinguish
> ONEVF and PASSTHROUGH use case on sysfs level
> and prohibit setting (writting to sysfs).
> It also applies the new mechanizm on pp_dpm_sclk sysfs file.
>
> =3D=3D Test =3D=3D
> Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
> Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
> "calling process does not have sufficient permission to execute a command=
".
> Sysfs pp_dpm_sclk will not be created in MULTIVF mode.
>
> Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com<mailto:Marina.Nikol=
ic@amd.com>>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 082539c70fd4..d2b168babc7d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_devic=
e *adev,
> struct amdgpu_device_
>               }
>       }
>
> +     /* security: setting should not be allowed from VF */
> +     if (amdgpu_sriov_vf(adev)) {

You should be checking for pp_dpm_sclk here, for example:
                if (DEVICE_ATTR_IS(pp_dpm_sclk) {

Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not 100% clear.

 Kent

> +             dev_attr->attr.mode &=3D ~S_IWUGO;
> +             dev_attr->store =3D NULL;
> +     }
> +
>  #undef DEVICE_ATTR_IS
>
>       return 0;
> --
> 2.20.1

--_000_DM6PR12MB43004E4DF34D166C06C9AB9A8E7D9DM6PR12MB4300namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
From a6512c0897aa58ccac9e5483d31193d83fb590b2 Mon Sep 17 00:00:00 2001
<div>From: Marina Nikolic &lt;Marina.Nikolic@amd.com&gt;</div>
<div>Date: Tue, 14 Dec 2021 20:57:53 +0800</div>
<div>Subject: [PATCH] amdgpu/pm: Modify sysfs to have only read permission =
in</div>
<div>&nbsp;SRIOV/ONEVF mode</div>
<div><br>
</div>
<div>=3D=3D Description =3D=3D</div>
<div>Setting through sysfs should not be allowed in SRIOV mode.</div>
<div>These calls will not be processed by FW anyway,</div>
<div>but error handling on sysfs level should be improved.</div>
<div><br>
</div>
<div>=3D=3D Changes =3D=3D</div>
<div>This patch prohibits performing of all set commands</div>
<div>in SRIOV mode on sysfs level.</div>
<div>It offers better error handling as calls that are</div>
<div>not allowed will not be propagated further.</div>
<div><br>
</div>
<div>=3D=3D Test =3D=3D</div>
<div>Writing to any sysfs file in passthrough mode will succeed.</div>
<div>Writing to any sysfs file in ONEVF mode will yield error:</div>
<div>&quot;calling process does not have sufficient permission to execute a=
 command&quot;.</div>
<div><br>
</div>
<div>Signed-off-by: Marina Nikolic &lt;Marina.Nikolic@amd.com&gt;</div>
<div>---</div>
<div>&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++</div>
<div>&nbsp;1 file changed, 6 insertions(+)</div>
<div><br>
</div>
<div>diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/=
pm/amdgpu_pm.c</div>
<div>index 082539c70fd4..c43818cd02aa 100644</div>
<div>--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c</div>
<div>+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c</div>
<div>@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_de=
vice *adev, struct amdgpu_device_</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div><br>
</div>
<div>+ &nbsp; &nbsp; &nbsp; /* setting should not be allowed from VF */</di=
v>
<div>+ &nbsp; &nbsp; &nbsp; if (amdgpu_sriov_vf(adev)) {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;attr.m=
ode &amp;=3D ~S_IWUGO;</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;store =
=3D NULL;</div>
<div>+ &nbsp; &nbsp; &nbsp; }</div>
<div>+</div>
<div>&nbsp;#undef DEVICE_ATTR_IS</div>
<div><br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; return 0;</div>
<div>--</div>
<div>2.20.1</div>
<span></span><br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 22, 2021 4:19 AM<br>
<b>To:</b> Nikolic, Marina &lt;Marina.Nikolic@amd.com&gt;; Russell, Kent &l=
t;Kent.Russell@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists=
.freedesktop.org&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;Milan.Mitrovic@amd.com&gt;; Kitchen, Greg &l=
t;Greg.Kitchen@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</font>
<div>&nbsp;</div>
</div>
<div lang=3D"EN-US" style=3D"word-wrap:break-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheadera4477989" style=3D"margin-right: 0in; margin-left: =
0in; font-size: 11pt; font-family: Calibri, sans-serif;margin:0in">
<span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; =
color:blue">[AMD Official Use Only]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; <b>On Be=
half Of </b>
Nikolic, Marina<br>
<b>Sent:</b> Tuesday, December 21, 2021 10:36 PM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Mitrovic, Milan &lt;Milan.Mitrovic@amd.com&gt;; Kitchen, Greg &l=
t;Greg.Kitchen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</p>
</div>
</div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Arial&quot;,sans-serif; color:blue">[AMD Official Use Only]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Arial&quot;,sans-serif; color:blue">[AMD Official Use Only]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">From 06359f3be0c0b889519d6dd9=
54fb11f31e9a15e0 Mon Sep 17 00:00:00 2001
</span></p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">From: Marina Nikolic &lt;<a h=
ref=3D"mailto:Marina.Nikolic@amd.com">Marina.Nikolic@amd.com</a>&gt;</span>=
</p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Date: Tue, 14 Dec 2021 20:57:=
53 +0800</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Subject: [PATCH] amdgpu/pm: M=
odify sysfs pp_dpm_sclk to have only read</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;permission in ONEVF mod=
e</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<b><i>[Quan, Evan] With the subject updated(remove the description about pp=
_dpm_sclk), the patch is acked-by: Evan Quan &lt;evan.quan@amd.com&gt;</i><=
/b></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt">&nbsp;</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt">BR</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt">Evan</span><b><i></i></b></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">=3D=3D Description =3D=3D</sp=
an></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Setting through sysfs should =
not be allowed in SRIOV mode.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">These calls will not be proce=
ssed by FW anyway,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">but error handling on sysfs l=
evel should be improved.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">=3D=3D Changes =3D=3D</span><=
/p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">This patch prohibits performi=
ng of all set commands</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">in SRIOV mode on sysfs level.=
</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">It offers better error handli=
ng as calls that are</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">not allowed will not be propa=
gated further.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">=3D=3D Test =3D=3D</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Writing to any sysfs file in =
passthrough mode will succeed.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Writing to any sysfs file in =
ONEVF mode will yield error:</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&quot;calling process does no=
t have sufficient permission to execute a command&quot;.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Signed-off-by: Marina Nikolic=
 &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marina.Nikolic@amd.com</a>&g=
t;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">---</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;drivers/gpu/drm/amd/pm/=
amdgpu_pm.c | 6 ++++++</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;1 file changed, 6 inser=
tions(+)</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">diff --git a/drivers/gpu/drm/=
amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">index 082539c70fd4..c43818cd0=
2aa 100644</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">--- a/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">+++ b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">@@ -2133,6 +2133,12 @@ static=
 int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_<=
/span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; }</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp; &nbsp; &nbsp; &nbsp; }=
</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">+ &nbsp; &nbsp; &nbsp; /* set=
ting should not be allowed from VF */</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">+ &nbsp; &nbsp; &nbsp; if (am=
dgpu_sriov_vf(adev)) {</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">+ &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; dev_attr-&gt;attr.mode &amp;=3D ~S_IWUGO;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">+ &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; dev_attr-&gt;store =3D NULL;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">+ &nbsp; &nbsp; &nbsp; }</spa=
n></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">+</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;#undef DEVICE_ATTR_IS</=
span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp; &nbsp; &nbsp; &nbsp; r=
eturn 0;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">--</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">2.20.1</span></p>
</div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"margin: 0in; font-size=
: 11pt; font-family: Calibri, sans-serif;text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<b><span style=3D"color:black">From:</span></b><span style=3D"color:black">=
 Nikolic, Marina &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marina.Nikol=
ic@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, December 21, 2021 3:15 PM<br>
<b>To:</b> Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.R=
ussell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mi=
lan.Mitrovic@amd.com</a>&gt;; Kitchen, Greg &lt;<a href=3D"mailto:Greg.Kitc=
hen@amd.com">Greg.Kitchen@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</span>
</p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Hi Kent,&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Thank you for the review. Yes=
, I can confirm I am trying to set this for every single file for SRIOV mod=
e.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black"><a id=3D"OWAAM749892" href=3D=
"mailto:Greg.Kitchen@amd.com"><span style=3D"font-family:&quot;Calibri&quot=
;,sans-serif; text-decoration:none">@Kitchen, Greg</span></a>&nbsp;required=
 this for ROCM-SMI 5.0 release. In case you need it, he
 can provide more details.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">I'm going to clarify commit m=
essage more and send a new patch.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">BR,<br>
Marina</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"margin: 0in; font-size=
: 11pt; font-family: Calibri, sans-serif;text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<b><span style=3D"color:black">From:</span></b><span style=3D"color:black">=
 Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Russell@amd=
.com</a>&gt;<br>
<b>Sent:</b> Monday, December 20, 2021 8:01 PM<br>
<b>To:</b> Nikolic, Marina &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Ma=
rina.Nikolic@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mi=
lan.Mitrovic@amd.com</a>&gt;; Nikolic, Marina &lt;<a href=3D"mailto:Marina.=
Nikolic@amd.com">Marina.Nikolic@amd.com</a>&gt;; Kitchen, Greg &lt;<a href=
=3D"mailto:Greg.Kitchen@amd.com">Greg.Kitchen@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</span>
</p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;margin-bottom:12.0pt">
<a name=3D"x_x_BM_BEGIN"></a><span style=3D"font-family:&quot;Times New Rom=
an&quot;,serif">[AMD Official Use Only]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.=
org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Marina Niko=
lic<br>
&gt; Sent: Monday, December 20, 2021 11:09 AM<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Cc: Mitrovic, Milan &lt;<a href=3D"mailto:Milan.Mitrovic@amd.com">Mila=
n.Mitrovic@amd.com</a>&gt;; Nikolic, Marina<br>
&gt; &lt;<a href=3D"mailto:Marina.Nikolic@amd.com">Marina.Nikolic@amd.com</=
a>&gt;; Kitchen, Greg &lt;<a href=3D"mailto:Greg.Kitchen@amd.com">Greg.Kitc=
hen@amd.com</a>&gt;<br>
&gt; Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read=
 premission in<br>
&gt; ONEVF mode<br>
&gt;<br>
&gt; =3D=3D Description =3D=3D<br>
&gt; Due to security reasons setting through sysfs<br>
&gt; should only be allowed in passthrough mode.<br>
&gt; Options that are not mapped as SMU messages<br>
&gt; do not have any mechanizm to distinguish between<br>
&gt; passthorugh, onevf and mutivf usecase.<br>
&gt; A unified approach is needed.<br>
&gt;<br>
&gt; =3D=3D Changes =3D=3D<br>
&gt; This patch introduces a new mechanizm to distinguish<br>
&gt; ONEVF and PASSTHROUGH use case on sysfs level<br>
&gt; and prohibit setting (writting to sysfs).<br>
&gt; It also applies the new mechanizm on pp_dpm_sclk sysfs file.<br>
&gt;<br>
&gt; =3D=3D Test =3D=3D<br>
&gt; Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.<br=
>
&gt; Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:<br>
&gt; &quot;calling process does not have sufficient permission to execute a=
 command&quot;.<br>
&gt; Sysfs pp_dpm_sclk will not be created in MULTIVF mode.<br>
&gt;<br>
&gt; Signed-off-by: Marina Nikolic &lt;<a href=3D"mailto:Marina.Nikolic@amd=
.com">Marina.Nikolic@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++<br>
&gt;&nbsp; 1 file changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; index 082539c70fd4..d2b168babc7d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_de=
vice *adev,<br>
&gt; struct amdgpu_device_<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* security: setting should not be allowed f=
rom VF */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
<br>
You should be checking for pp_dpm_sclk here, for example:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_sclk) {<br>
<br>
Otherwise I am pretty sure you're setting this for every single file. And i=
s it only sclk? Or does it also need to affect mclk/fclk/etc? If it's only =
sclk, the line above should help. If it's for more, then the commit should =
try to clarify that as it's not
 100% clear.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_attr-&gt;attr.mode &amp;=3D ~S_IWUGO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_attr-&gt;store =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp; #undef DEVICE_ATTR_IS<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; --<br>
&gt; 2.20.1</span><span style=3D"font-size:12.0pt; font-family:&quot;Times =
New Roman&quot;,serif"></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB43004E4DF34D166C06C9AB9A8E7D9DM6PR12MB4300namp_--

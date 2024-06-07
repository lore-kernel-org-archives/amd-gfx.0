Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BB6C27C5F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 16:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A876210E3BF;
	Fri,  7 Jun 2024 16:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k4H+7Pez";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED7D10E2D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 16:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1MGfM1gwMci8U7rY8/CyGlBT+5O/hztaLdkjKvksyWarQk0iTauM3+Irfd5UTmtgytYNSF3Ax5Fln+3XNYVCAoIuvzMLaoRV32Mu3jBSUM4upm8mPnT0tkNRHaerG0dzXhMwpTohfCMvRVqEy4aSE34x7D/XNfGbT2+OuSIhVndLQa6jeb7vY44FecNMCOVfDHT0Z/VM6wmXpSpAOUDe9G08XZVGECScUv3JGjjft1CPRZuiXiaXyKx0n5K6Lf2TPsEG4GP2nbLTDyV4jGE0vGQVdserx8tUUc92FUCKk2kRDeRzpQGGuvMdVCfJURHfRLpsrVwExcwh9Ja0tIiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc8gk7GQNTTLv61iqrmlsS5tQvf5+nA5DEpkVnWXp0w=;
 b=FUT/wcUNkDdiV8rgman0pWFnOrDK64AsQDJ7JMScFBQc+jR8lDEE/UdbDwxbArVtcmwEOn67qL5SCM3TY+i2vqWiKSlj2DVIHVIFaWxFVBDWTTwXqLjngYGiFrZtewiyeGfm49bLjew6PgcU4t8N4vckDKdQXCywLWLNjDmxWs89zpoYtuBMWm1rh4z0NRYOgOKdr1XqY+BcIPUii6L6gqcRs9+QjJPfVch1vkpuHs9pZGZGUdVGpl0/ZC/9+xZZf8YGYHohYvBraWr1rP2NUFINUdxMFpdYIdWeJp6mQnpsv21PKZ+ZXDJytGZNETGtJfjDhGNYBPv3A/y6sirYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc8gk7GQNTTLv61iqrmlsS5tQvf5+nA5DEpkVnWXp0w=;
 b=k4H+7PezCHsWblYrjUVLIAoHQSEmgmcWV78MIR1LXLbTmBTnNzyYMva2viLE/o4JIuraYPMWmgPDckTB/+9hvpweN0irJJ6Z39X/mPpZh7n8UHf0A7+0Mf0LJqyUjKBxniVb+ST0zggqFXPyXe5YMYPdqYJHqerOhpjm4L0igck=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 16:49:18 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 16:49:15 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Choi, Nicholas" <Nicholas.Choi@amd.com>, "Zhang, George"
 <George.Zhang@amd.com>, "alex.deucher@amd.com" <alex.deucher@amd.com>,
 "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
Subject: Re: [PATCH 1/2] Revert "drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_update_cursor"
Thread-Topic: [PATCH 1/2] Revert "drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_update_cursor"
Thread-Index: AQHauPiKtd/9vmfKF0W2UNj50iSUr7G8gw6t
Date: Fri, 7 Jun 2024 16:49:15 +0000
Message-ID: <MN2PR12MB4128E76CB48C8B7B1953EAB490FB2@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20240607163359.18299-1-ivlipski@amd.com>
In-Reply-To: <20240607163359.18299-1-ivlipski@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-07T16:48:18.8528255Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: b1ab8dd1-01f1-4b2c-82cb-08dc8711c45d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?HBUrWhDmsGrdkHjPOVD3ZqLdY9W5eqz1siGsY8htGM3egPBp22FDewBtqenf?=
 =?us-ascii?Q?kEDLST3Gx/qFEmzV+0WrRQmZ6Gs82nUBUB3k9H1N4BzNEVbk/+HinRSHE53D?=
 =?us-ascii?Q?9mn1Bd4WkyluJItocHMhkWMBY3dJxZTbhbUlK8XD1JVvvjFmhzAWwOOd/C7S?=
 =?us-ascii?Q?hHxu9E1OroOeIpFtatb1FoG2122WfkQkeoj3C19dwv39eL6kKdEYO4skaAM7?=
 =?us-ascii?Q?Y5XJdsoyXfnqimCjXT0gM/QvCpdWyldoVYTF7WqatLiyM13ZuAowrGda+l76?=
 =?us-ascii?Q?Z4fQIq5BE8S0xHDdxqfmh7mxJbgXnKjMJrziHoa7A5JpJjZ2kPrTv5K7wmrV?=
 =?us-ascii?Q?sDrId82jTqA05PCTZso7Z1cpqpQsK5IE6TzrYkucMd/6B9SLeOwVPvTNx2QU?=
 =?us-ascii?Q?9fuhisPzxnXJGOPXAE3bpjhJ48Po4hxxyC5OBOdKkifXRIM1I/RutdNeNCMG?=
 =?us-ascii?Q?vAwHX6/CAOIvm2tTgVESQtbRby3k1w/NI+8vuqRmGHK/7OEiW+M2hHTE0qpT?=
 =?us-ascii?Q?oIi1X/4Mfo1gW21FjwkvPe+DBV8dEEW0EsAUoAfAw16rD5NX6Wx5+S0+GOBb?=
 =?us-ascii?Q?LHAchHCsBPtWBzq4CseigZRNua8ipGVwQS7iyLpo1R2Yo8tVdUrlhGEXWqrm?=
 =?us-ascii?Q?uLPC5w/b3lug7gJI3tsPTO85/uY3HrU3I14FglwCYfqlqaOWSr0zFbYnmwol?=
 =?us-ascii?Q?cDfRf5vUAesE5ca0JnnHKZtxVc8vK0m4Pv6V/u3pbdMm/aoaz/5YtC2LbGJo?=
 =?us-ascii?Q?b8lIZWtl98Jz6NYKHx8YPH7ZdNpjfZE9TpcSQG3MMFOhuHkI4GMwn2dz4RY1?=
 =?us-ascii?Q?CR3cAgYkt9OoSeAT4WKs2t2ADYbVmzqUYAhzX3x8+EdX6RtSp8nvxVrlPx7u?=
 =?us-ascii?Q?JGOo6e0CvvLt8e3fiWsEPjJ4cJC6y+PNF6j2roST9AFDWuH/QusHNSzvo9py?=
 =?us-ascii?Q?csfdYbHPJ+O965izO/W+niySm1IXOhysgAbzEGNQK6yjPLE+dQcQxY4Yth1L?=
 =?us-ascii?Q?C0Shqrjq+zdK0ViyVmj8iBNSahp/VWYV6x+gJQcgcAUqgoY9DHBrYUAhTt0n?=
 =?us-ascii?Q?Ld0s5SdceKgV9tr1UnM9IVPVODB+HP5+KLUdMr+GBtSEdnYFKhmxgkDdLzeg?=
 =?us-ascii?Q?ZB7eOh3ntZsJVXdqWeKY+XFgjLIMsKO0XwQ5SWrooDkeJGvmJuyiW40v6R1H?=
 =?us-ascii?Q?/zLWdcDDAiX4jVShHsHgg4cjwZLUSgv7tXxJwntau80ET2bxZEB2IO8MNOMk?=
 =?us-ascii?Q?tXespJsHpMtMQ67LDzw9Nkq+pZ/6apxnaDrkN64fjGYGhUusxvKOh4Ak9D+k?=
 =?us-ascii?Q?XAzfpJcV2Ot0EmwqZf+yUB9b?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MpfwhlNX3AZTuOPMOTOqYkk0HnbGPUmE6y0rMX1tzMBd4hEksusrrK1q5S03?=
 =?us-ascii?Q?uzr4RxexnrfVzQoT0oHG8kJvXR+9N6sK1+s0TrTlhbnT2MVAOaJPaOFAkTOp?=
 =?us-ascii?Q?rOGF4X2SP+nTGO22ckVf9DInReteFVH2UKmPNMLtAMb8WVy4wIZFizFNAtVK?=
 =?us-ascii?Q?8/cL0gl+XPVus1UuMyjmyilSzCDQIiiSUxTdBT7u4e+98XMVVOvSvqSGiFs9?=
 =?us-ascii?Q?bbq2ML1XK/mAtEchjKuOFnsyBI3TfUNZ0HW0WmayH1Y/2xU5gIZf73ngCFaU?=
 =?us-ascii?Q?nqdXqKn2PFcWdi04goGSTZMZ6BFt2OYfydR3ZNjmjDqdcuI5epVEZQu8jruY?=
 =?us-ascii?Q?wyTruDeZnhCa/A6zTUOMUXgrdJEEjgTt3ZvIauVkNAZ/z6wNPE2VdV+k2GnD?=
 =?us-ascii?Q?7FRvI4fT4y02ft/h+L8UkFTVjm+FWRghaGojDm9no/+Mop7j41loREmlxpNZ?=
 =?us-ascii?Q?pczjEzX2OZZU19abgeDW/zsIYURHa3kp+HBoeuSaSzWAf/yNxrHHubUTf4DL?=
 =?us-ascii?Q?tRtvyyW2a6YXibaCBf1ThofQRa8n3NXapOvNNTytsDHjU2OiJkE4fsnv1Lph?=
 =?us-ascii?Q?2GeQVs9STPGTIMuyjgI0AW61XTQDiZKs0Co25X/BhzwVlOggjraJH6MOKwc7?=
 =?us-ascii?Q?865QqsMrk0u8Qs2U58x7/cXH1+SiofDKt1gZEBMNJyeZ5eJjb0/ZS0/CyJN1?=
 =?us-ascii?Q?JHzri0XbXxWqVTzBa+4jrSjPTi0gFxkXruzvzoaJeGIFZdDCO6SkVvHkj0Gg?=
 =?us-ascii?Q?p6q8zPGLL1dcav1xWEj4UzQ/IZ9jhXYXHJ9HNrrU0tqcLZ5Bu9BCX+a37Qya?=
 =?us-ascii?Q?56g+BwagsvS06HBVPklreLgtsYBpXMwTpoHC8v5SIApQ6XM1ZF+RAOGRpi7g?=
 =?us-ascii?Q?dRexm2J8dBOvGVqOu+Xqblj6FmDQNjR6imG2Hp8fqUODqtUGiOxr4NYAj6wE?=
 =?us-ascii?Q?WHgsb7tw47pgUfcXbf4gXqxt+A/wQWoQn6ggeRf+rU2x1ag2PKTQ61n8uZTE?=
 =?us-ascii?Q?ZiHFeJlRv+6zPbHulvW2936dpmY1Wx45OGZNw/UeUkg4arZ2a7vQr9QT3XFE?=
 =?us-ascii?Q?TyiZka34EL4qd5Jx2WRBIDGEkgTfsGYe2V9QfaQM1qe2FZO+zDDwqE+PE0J0?=
 =?us-ascii?Q?U6wc5ZXHwl1IGHCJLz2Y+GBRiXdqJD464THzNreWBQTpIH0U+5WsXFuNqT0W?=
 =?us-ascii?Q?zPKK6WTGyAjo3+F84+SG2iBpuPfsUbigqBkznOFoKlVmgrDTf1iTPuG7NPKW?=
 =?us-ascii?Q?M9BqdSLy3abp/dgI6kRQ6cBNRXyCBmhCOsQhHN8VM7M7WS0GuntMw/3SkSRp?=
 =?us-ascii?Q?tZuASZztpNHZEL6+Yf8Yw2YkawFt3XesNrIUjYY7rFqYmgVLdg+u9LvqGh2V?=
 =?us-ascii?Q?nYDN2wdLj1JAhErT6UUfmmR8d7hSXUhQf7UOrtowzUKKTleOk5v5sv8+09fe?=
 =?us-ascii?Q?hKxBBe1y3iOQgUIPC4Ljlu+3M6KOvsdqw7OddGq+n8d0hKbw5W/yO7cRUl+8?=
 =?us-ascii?Q?yp6LklxvN3ONTcs0cmiXg1qNZ2z3/06uhsoxzHUyPBEgVH6rler5v3IkSNZG?=
 =?us-ascii?Q?uBcJY+qSz8+sIrHW4LPqdOHc6c3awLjYQX3dijdB?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB4128E76CB48C8B7B1953EAB490FB2MN2PR12MB4128namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ab8dd1-01f1-4b2c-82cb-08dc8711c45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 16:49:15.7990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l46a1Kb1G/qestNBfF92N0KE5bKNtW8/lssyqvF0XRnkY3kG18BXVNylUrBDPDS8LlLzHnsIw3jWl4HraEKWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

--_000_MN2PR12MB4128E76CB48C8B7B1953EAB490FB2MN2PR12MB4128namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com<mailto:srin=
ivasan.shanmugam@amd.com>>

Get Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Sent: Friday, June 7, 2024 10:03:58 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Li, Sun peng (Leo=
) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira,=
 Rodrigo <Rodrigo.Siqueira@amd.com>; Choi, Nicholas <Nicholas.Choi@amd.com>=
; Zhang, George <George.Zhang@amd.com>; alex.deucher@amd.com <alex.deucher@=
amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd/display: Add null check for 'afb' in a=
mdgpu_dm_update_cursor"

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
This commit introduced a regression with kms_plane_cursor IGT
tests, causing AMD Asics to fail these tests.

This reverts commit 14bcf29b706f8ef423b86c9b783055b5b0c2cd35.

Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 27acbe3ff57b..448932ac06fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8637,22 +8637,14 @@ static void amdgpu_dm_update_cursor(struct drm_plan=
e *plane,
 {
         struct amdgpu_device *adev =3D drm_to_adev(plane->dev);
         struct amdgpu_framebuffer *afb =3D to_amdgpu_framebuffer(plane->st=
ate->fb);
-       struct drm_crtc *crtc;
-       struct dm_crtc_state *crtc_state;
-       struct amdgpu_crtc *amdgpu_crtc;
-       u64 address;
+       struct drm_crtc *crtc =3D afb ? plane->state->crtc : old_plane_stat=
e->crtc;
+       struct dm_crtc_state *crtc_state =3D crtc ? to_dm_crtc_state(crtc->=
state) : NULL;
+       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
+       uint64_t address =3D afb ? afb->address : 0;
         struct dc_cursor_position position =3D {0};
         struct dc_cursor_attributes attributes;
         int ret;

-       if (!afb)
-               return;
-
-       crtc =3D plane->state->crtc ? plane->state->crtc : old_plane_state-=
>crtc;
-       crtc_state =3D crtc ? to_dm_crtc_state(crtc->state) : NULL;
-       amdgpu_crtc =3D to_amdgpu_crtc(crtc);
-       address =3D afb->address;
-
         if (!plane->state->fb && !old_plane_state->fb)
                 return;

--
2.34.1


--_000_MN2PR12MB4128E76CB48C8B7B1953EAB490FB2MN2PR12MB4128namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto"><span style=3D"font-family:-apple-system, HelveticaNeue;f=
ont-size:14.6667px;display:inline !important">Reviewed-by: Srinivasan Shanm=
ugam &lt;</span><a href=3D"mailto:srinivasan.shanmugam@amd.com" class=3D"ms=
-outlook-linkify" style=3D"font-family: -apple-system, HelveticaNeue; font-=
size: 14.6667px; color: rgb(0, 120, 212);">srinivasan.shanmugam@amd.com</a>=
<span style=3D"font-family:-apple-system, HelveticaNeue;font-size:14.6667px=
;display:inline !important">&gt;</span><br>
</div>
<div><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Get <a href=3D"https:/=
/aka.ms/AAb9ysg">
Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> LIPSKI, IVAN &lt;IVAN=
.LIPSKI@amd.com&gt;<br>
<b>Sent:</b> Friday, June 7, 2024 10:03:58 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Li, =
Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentla=
nd@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Choi, N=
icholas &lt;Nicholas.Choi@amd.com&gt;; Zhang, George &lt;George.Zhang@amd.c=
om&gt;;
 alex.deucher@amd.com &lt;alex.deucher@amd.com&gt;; LIPSKI, IVAN &lt;IVAN.L=
IPSKI@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] Revert &quot;drm/amd/display: Add null check fo=
r 'afb' in amdgpu_dm_update_cursor&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
<br>
[WHY]<br>
This commit introduced a regression with kms_plane_cursor IGT<br>
tests, causing AMD Asics to fail these tests.<br>
<br>
This reverts commit 14bcf29b706f8ef423b86c9b783055b5b0c2cd35.<br>
<br>
Signed-off-by: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c&nbsp;&nbsp;&nbsp; | 16 =
++++------------<br>
&nbsp;1 file changed, 4 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 27acbe3ff57b..448932ac06fb 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -8637,22 +8637,14 @@ static void amdgpu_dm_update_cursor(struct drm_plan=
e *plane,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(plane-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_framebuffer =
*afb =3D to_amdgpu_framebuffer(plane-&gt;state-&gt;fb);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *crtc_state;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 address;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D afb ? plane=
-&gt;state-&gt;crtc : old_plane_state-&gt;crtc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *crtc_state =3D =
crtc ? to_dm_crtc_state(crtc-&gt;state) : NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D t=
o_amdgpu_crtc(crtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t address =3D afb ? afb-&gt;ad=
dress : 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_cursor_position =
position =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_cursor_attribute=
s attributes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!afb)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crtc =3D plane-&gt;state-&gt;crtc ? p=
lane-&gt;state-&gt;crtc : old_plane_state-&gt;crtc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crtc_state =3D crtc ? to_dm_crtc_stat=
e(crtc-&gt;state) : NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc =3D to_amdgpu_crtc(crtc);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address =3D afb-&gt;address;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!plane-&gt;state-&gt;f=
b &amp;&amp; !old_plane_state-&gt;fb)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4128E76CB48C8B7B1953EAB490FB2MN2PR12MB4128namp_--

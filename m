Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08334C30653
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 12:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922F510E7EC;
	Wed,  3 Jul 2024 12:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sjgAo8TE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AAD10E7EC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 12:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OW5/BFTRdeoQD00ay8sSiRZxVlihpFxumzYYuQFPiOdijF3xBY9k1z2CIe5RLanvyzw0GxhLEcBJ6dnF7ts/lh+5ao+vvAxYU6YQknplfMnEjSC1m2fhVJmRjxIABl2KvgK/U+5+R/fInddWKzVrDOhzWTW8GoLNFiZ85LFw5I+qFp6DFUEdq1dwpNy7yhUpltKdU9WhZwxT/JqBA6/LGq8B8WBlDalgHkT1e3md3XYCOT9DILfLoa3QDJzb5CK4F6Gmf/vQOeTmrMPOjvBf/WPUrD5D9wjX+LdtmicVLB6hXLhggwWto9qjyT6cElHZC9SYRrhWdGlLbpcaaqgWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9nYWuJUQeW1cSRA2fDqXPVjfLzBckQ4H741BODG4RQ=;
 b=MBfxU21FIBfzzA0ktkm6E5VQREXjNnQ4OJqKaS7btB3vZv0p27R5vcGLUZhUKTKQIlyEJvJl2owmXiY8FfjCQJh3OKs1+QzcycWlu97gxxrFzjgywCCkkaSvaDDuFzPxjQyihjDETBw4znRQ3Yo+FsPU/Tx/PziYmzGehVoSY62VsHbF+IXgVojY0N0ZMkzG5CVXC0NLHKGOG0VUa6KlLqxGz8hl0ogrEPPkplsOy7w/T/1shtIsCeUovoLgt29t9aGMvU4C+P2sjLynQpy9WOBSfdQGA7/Qc5Hsr/RczZkoJc4WrFCjr0xn+S/nJJbyDk0udrQShCvUYOmV0YwcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9nYWuJUQeW1cSRA2fDqXPVjfLzBckQ4H741BODG4RQ=;
 b=sjgAo8TEHrEM5xJkBoeQHEbN7zcfS/hHxyVtFizjh7VuU95tzI0yCDV3aEmXp6gm4bKNVXimVOSTvPdztwETfer/kmAIdKdlC8V47BvVj8KK0fgzOyO/s66ViHE8Bhi3tFUbsaGY1yFHjrPK0zQFCdDMFFWFuwpFK78ayjTyhGw=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 12:59:42 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 12:59:41 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/atomfirmware: silence UBSAN warning
Thread-Topic: [PATCH] drm/amdgpu/atomfirmware: silence UBSAN warning
Thread-Index: AQHay9eH6X/B/gdbIk+DM93wW4xCTbHk+TFQ
Date: Wed, 3 Jul 2024 12:59:41 +0000
Message-ID: <MN2PR12MB412823E506A908355CCFD18690DD2@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20240701165521.1825864-1-alexander.deucher@amd.com>
In-Reply-To: <20240701165521.1825864-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=49dc913b-48bb-43c0-9086-6624aab8432f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-03T12:56:56Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|SA1PR12MB7039:EE_
x-ms-office365-filtering-correlation-id: f25683ca-4113-4832-b202-08dc9b60012a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?u/dKsdCOxlY5EvLU29QpVlUQy+qk2LnaapqXMH7xJTgwGf95dGepAPGZopMu?=
 =?us-ascii?Q?2Svx4VirYo8CC+deqUuFn/urUTTtCQ+QER0CvdIyF+fgwG/jtXRnOfMqmfdN?=
 =?us-ascii?Q?kUfQwtrKXxouBBvS8vjUdDn4pp8RH41ehIuHbIef1Oi3VCeeeeuLm4H/RvVb?=
 =?us-ascii?Q?o//5d3FeUDV5Fxa/WIZa4rpkCf+O7n3woSs4f3zf/gweMVaNsYXa3EDoA1NS?=
 =?us-ascii?Q?K+uj2ZL3kvZh+3IxBMJcyO7ziEK1EY5bHmfbdohPPw+pzKWghyH8riQiUYw1?=
 =?us-ascii?Q?aamcCM4An3bNfHhSJpBQUuz+sxdGIW4afs+PTBaJm6E5EiMDMLQtYd3mCBBJ?=
 =?us-ascii?Q?+5yHzkKufdJz7gVsTEKIbj74mokgb0g2J+7PZSqnQlvcozfRC3RO5CjQClTl?=
 =?us-ascii?Q?EOYF0Yc2+zbij5UczneK58vNCkMIWzI/T24LsSW3ove1q8Qrz1uhkeKgF4gf?=
 =?us-ascii?Q?ROU1/Fa2fTR52KlsjMFBh7c1tJb8LsOkFWb5mA0bvBW4GrLFvuUx3IwOdrYE?=
 =?us-ascii?Q?2AUhwNq0AfNnwzo/UxUa5/Z16PkKiNS/5cXVxZc4riOzXDIBtIbo8yXyZRiK?=
 =?us-ascii?Q?7xJBYKF6OViS/mFvqes7YXaVIXVWnXqJwzJhXoZm97cYQVt5EVMBis+uQ7ZY?=
 =?us-ascii?Q?PqqyXpHAYFWWPGaXHRPh8a2WRl4UEWz+GNyNQGlM2uZwC6PVbmn7YpdXMMRh?=
 =?us-ascii?Q?582cdagjgTWYl+FtJSUaFP0tI9KrWcE896+1tw/JrokKMpypQGEx5HhujvW1?=
 =?us-ascii?Q?KkU7ZhKf8TwzEYI0oXtpL4b98UlvOUooVaoBDqhoPNpfmzxRV3yEXMRwLAx8?=
 =?us-ascii?Q?pDJUpMIYHNPrFN+ba+AKcmg8ZMvJNIEhNdZaYx3A3n2uyRNiAr7nbmwnF/0B?=
 =?us-ascii?Q?mD6HQGn6OjSFiPc5HuGKIrrJC3eiu4ls0VLT7STpXJSFA2UhQsPR96o2VCNJ?=
 =?us-ascii?Q?SVVRstVLIngIVABNzEyGS2gEOBeFWGbahnADtwc8QF722I6scG0E8Jgd/8W9?=
 =?us-ascii?Q?5lfRS5Q/V4m9gTYpof3E59nWbHgzWXON7q3epUuzQLK8ztCivk9eiDZUB5kD?=
 =?us-ascii?Q?Edc7hEzhn7P6QsAQ6BujcpkAf2gR8FbEO+Pmct0uT6El+qSaYu9B4d/xfESB?=
 =?us-ascii?Q?fM+aRWoUSgJcW3KEpbEQTggrqVwc5ucRG/NhJhhSL3wiZF0aA2XFM9kXQ+S2?=
 =?us-ascii?Q?Z0fvHbMzY/sh8wsv2170Ig9LqOVIpkV2rKlVvc4ZWOb6eZLcCQpkr8ZHmadJ?=
 =?us-ascii?Q?mJ4gCrhP8/TmlcKkTWc+DSaFogIMMv9CqYeo7qeWZFPqO7jy9frpewdTCD/Q?=
 =?us-ascii?Q?xnUglpVILDmPuNo1ncRX7iLSn6plIEf4iwgOeObnx3ohP9t/MV/wB1H4nlK9?=
 =?us-ascii?Q?ZwtPq8w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DYoOlJd2uq7A1Cg+nh6i5OWCGQ41g7xmOD+FGLOUVrU9s4ThGVZIJXOjnbEZ?=
 =?us-ascii?Q?GeoIOJJUjY1IydW18JcN+t0xIfSpPtKlTZzwf8j3HOcXinqnIau1Tpr1vEsx?=
 =?us-ascii?Q?mBtsGh8MYrBiZPf3GJTk9NIQjPDsXeun7fI4NLOsEF4E57KpVJAAOV+bERs1?=
 =?us-ascii?Q?UoRmDO6ZT0iOCdjja/347qHMjX3c6qRz0OegK0Jf5JTT3wMj1wvJ5XWhjSqd?=
 =?us-ascii?Q?OvOAxPiEi4eV5heEOJ4uIJ/PaGxbtOs19sLZ4jQTbyxJGyATNvJ/yWC4oP+n?=
 =?us-ascii?Q?Jb1I46kJ8vHGrD+P6buYYFjAxUyehzy+Qn+1rnhLGvp4XuKxmCJU00a28K1w?=
 =?us-ascii?Q?SJkmDcIqjFjlHMWPSk1Eqh2kISVNV6InGNpOONBwehdOsFLXTRaTubuK6C0b?=
 =?us-ascii?Q?tWbwsELCLepD1Pb4oJExH//x/KloJCJiBVgJ35ZKP5XaDgiwYiZcLgAe1nA5?=
 =?us-ascii?Q?7P9krNykcN9tldZ8ZJAVjuUU3Q/fjgBoOMInckdfhK1r3JZvYZwVPev9gP6H?=
 =?us-ascii?Q?5mtTa51A1znDDR5LpzaibiuxidF4yxNA+cdkmiVvP8jpkqirKTcQwrZkWQ1h?=
 =?us-ascii?Q?xIfCG4OO04CP13cbTSeAhJsciOF+LYS+hJsUpl6LJYpuWQVbPxQZZofOWlT/?=
 =?us-ascii?Q?YqaouAuNv91PoX2XgRjv9D3hsA33mVvfycOCKz/F8P5dO08sfRYr5bZ7/k0A?=
 =?us-ascii?Q?1C7418a58z9V5iCPlLj8JPSMhkfb24nhl82SCkGvzIrI8/KSYsf8+vRx9Iuc?=
 =?us-ascii?Q?+kOqqn3O60fnH39Yl9jTRC17IxngZpXFqy2hSYiNKx3qsRkdpLrcgEDmEtJj?=
 =?us-ascii?Q?gph5sKVXfd8N4wq22IqVVWqsogXcANc3Pmyw1p8bQN0RoSpTBEz8ABGGgd/s?=
 =?us-ascii?Q?WglTVAXHgvdAboJZEGCCGpGhJl20KdWboXD5qoLKlfSppS2CX2LjR8ETdJGG?=
 =?us-ascii?Q?aDVbGfsp5J6LyDaxO99WUKhTEbDIqcqHw7tQN+Yoi3bFp0pkkqmSxOeuuW13?=
 =?us-ascii?Q?Ok+wBSAJiZ5AyHFx97onJzeODkCvSryhzlZw2IHZ3ZjiIjlSqkQcJhjeoE+p?=
 =?us-ascii?Q?OrruZONHfZDZ/gOv1ptN4gqrHDIUofeKaMp/UzCW2uH9KmVVG+c/INKnQm40?=
 =?us-ascii?Q?wOtyi93ddPYUZR+3e1FR7WG90s7N6IRpPca9OwYD7ulm9lq7DpG2S+6hxljx?=
 =?us-ascii?Q?jHeMer6/d9L0DNB1YflzBiJIFYivGpRC5VO75ELDJofyPVw5KOSuh0f0M/Sw?=
 =?us-ascii?Q?NI/6UFMmRW6VdjE87L//PKkXU2amv/COD+MsGDjVRtFab/IMXvwJU+k1j0Tv?=
 =?us-ascii?Q?758A266Ypk210jI4eyMgLgO0jdA6UG9knG+JqwfoFz0SsU+WxxkH+On7dfiW?=
 =?us-ascii?Q?7gCeJLF6xo7/dYiq5GjbPYRbBUrrzntf4ectdU8OUitvGkFnVCD5Vhy/cQL3?=
 =?us-ascii?Q?GDXrOL4ahmbRFjWN5EPwTOD73cYlNol5W/Ac8z8ausNGqpGu6wNcX9RzFk5e?=
 =?us-ascii?Q?uW+fkCZX1cFOewUGLSCbpxPc9uIjdM2IOV+tqTJQWndt9K2EALtkZOWPIDUT?=
 =?us-ascii?Q?VUeY99vrWkMITo24fO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25683ca-4113-4832-b202-08dc9b60012a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 12:59:41.8034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vlVJhnpXksKaOIC/77/8xE16NBb6sHFH/rGtpdF0U6/Dtk/Xj6vTryPEizJs5EdJbV1B3cNqMtIHBKCCNM9ArQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
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

[Public]

Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Monday, July 1, 2024 10:25 PM
To: amd-gfx@lists.freedesktop.org; jlayton@kernel.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/atomfirmware: silence UBSAN warning

This is a variably sized array.

Link: https://lists.freedesktop.org/archives/amd-gfx/2024-June/110420.html
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/a=
md/include/atomfirmware.h
index 571691837200..09cbc3afd6d8 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -734,7 +734,7 @@ struct atom_gpio_pin_lut_v2_1  {
   struct  atom_common_table_header  table_header;
   /*the real number of this included in the structure is calcualted by usi=
ng the (whole structure size - the header size)/size of atom_gpio_pin_lut  =
*/
-  struct  atom_gpio_pin_assignment  gpio_pin[8];
+  struct  atom_gpio_pin_assignment  gpio_pin[];
 };


--
2.45.2


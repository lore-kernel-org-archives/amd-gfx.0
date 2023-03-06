Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D61DC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 03:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B43C10E095;
	Mon,  6 Mar 2023 03:08:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A3E210E095
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 03:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlASTs6CNa/nRBMU+ir3afVrDN8PLiJtH1oWGR/JNeprPaTEpcFhZdJSNvh+/rgTBifl5w0XwCs26R5N/7zp4YLz3P5uSjZLXQJdeSDhL3U92LN7GS/84zRAw7cTR4Sct1cXEzJH2O9dbwRdKVz+yF5xNhr2DrrSJcCYPOxfoOF2jNtabKceZniOctL7gmoUy+GquDgoa+aA1BsvJL64QkDmyEJ1hwhT44wJS9b7hmgX/IUxpnsoFBZglniuv2RuTdbxu+C35ZIJ2dWxtUTsAInP0QnoZYQINQ7EFzMIJhqMVEkdT6UFu91hnUT1S30nmqK6V1QubI3HH5C3Q0lV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHSpHzmbprn3UVdVflLuJ+pil1CzRQB+YXceT2Ly8Dg=;
 b=meEbYycEzhWwegrjpvSwBWyDr2Kwr7xHsqKpviD3eURUAGxrReybEIu9hrTXP33pb45Jt226ZfcKeLBUAP9lUbQ+83LxcOE1QilMZzqRKAatPqZ+QPH3ZCcystOh5k4dkoZmx+qcHqrwey6dZScKl6Gn4RlcnnVIhKqB0AvTWiDqlu/oS/v/kmtrICt/9sRyHDOxbPqeJQ7ajp2r1S+7ePDguzQimiHn6nYxzIpGCGutu63bSfOdCVlV21IyNUGH4tZh3Y+HCdflqyFUyf2UUmFNgun7FbXyw837joSTJRgIUtppibXlbDCc8oYuxu5cj2TPFYCp9DjLd3MJ75OjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHSpHzmbprn3UVdVflLuJ+pil1CzRQB+YXceT2Ly8Dg=;
 b=eZQ8h1F4rr+pq03hpRz4YWmKVfvyafjKugAROmwPGHS0SvDKUNt76l368pHLIqyCPxXpbByHn7V3R/4CMKO217o4SClaPFVDTR2LjH6MVTzMsoVRPIvH9uO4sR2A3T9JtWf3bnltx/DO/YlDZ/qG5zGgk+PzB5XBRwi0BuVkiQc=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Mon, 6 Mar 2023 03:08:04 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::159c:7e97:356f:5edd]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::159c:7e97:356f:5edd%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 03:08:04 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/3] enable new capped/uncapped power profiles
Thread-Topic: [PATCH 0/3] enable new capped/uncapped power profiles
Thread-Index: AQHZSCqbe9bQXmtzQES1vJ9X8n42ia7tIQjA
Date: Mon, 6 Mar 2023 03:08:03 +0000
Message-ID: <DM4PR12MB5165E3AE5A8AE701F528B5BB8EB69@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230224083235.3448477-1-perry.yuan@amd.com>
In-Reply-To: <20230224083235.3448477-1-perry.yuan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ee504b36-2489-48d9-851e-8aa2b0d1d619;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-06T03:06:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|CY8PR12MB7098:EE_
x-ms-office365-filtering-correlation-id: bd7ed71e-f5f9-411e-f3a9-08db1df00060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zPU3pqorRkmvjL+uYfmJL3BJ7x/zawU5HtsH8+PMnfvguN+wsrn/rIir7zDWr5OPuI0X9DyjifP42r8V0NdXq/nfnnqz3LXBJi19/I6yl5XRmuCttL5Gli+q1LwVQwoJs983kR+Z8u0V+MibF3a4m8G85C48zejk8ZQtfQJ85E7CDFN1dA4NjE1A0HXlcnNl0ryvyeXZYWxZBhzHil2LUGW+X7gaKgJB5Rpnk4W1YXxehizQINio0E8mC0+XmDVntIAlFepdOdZYUJ+0SbktOH3wHdP+2jVVmQh2mTJSilD98/Su3mZZb16bx5JH3xFvvWsEHI25edQiWG9X5tt2aE16pXguZxPRueTqDkRs6xxqtEyXzMFgSLQYnNZUdgdVsZ+W+38YZDL4h6WQmjt0v/KgpPZpRwdN9W79tq456A8ndac1q7LYAFbtfQBpx9pzHrkJIEPdUAgOCPCx/a2+GPr9E4eaT2AmyDk+ZUlfiZQLi/wWbGy79X/Wdjd9dhjuObbPOQNU43rBt7hkynf+GUZoE6DhzN9WF9A65H4q2Wg9W8hypFIE9S/GKEi3GyHxMLhEGcKJRyvpsj+KeTha2n3CrqY+UrvZt57pzFW2z6y5XE5PuteOfmtrPJwEEPi4e1mWB2Fl+eV7KvuqTQ+mucTUvKcQEgsjhIq/iW86n7qxQNTBDKE2gT93ja/WS0lroVxs4DAQtQE6RIBfyFtnR8LPJ2zODaf5BPiYVDm7ZFg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199018)(6506007)(53546011)(38070700005)(83380400001)(921005)(33656002)(86362001)(55016003)(122000001)(38100700002)(9686003)(186003)(26005)(41300700001)(66556008)(66946007)(66476007)(76116006)(66446008)(8676002)(64756008)(4326008)(2906002)(8936002)(52536014)(5660300002)(71200400001)(7696005)(316002)(54906003)(110136005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c2ltvc5NWVU8VnRYEsbXfWEVn6ZBvoH3zhTiLLBYSODih15vHmAShEjLwRVz?=
 =?us-ascii?Q?VTUt07xa97GhenIzmksjb9+2ApSsUUmQ0pGAvrufA9oi1Q7s38xNQ7BLMBQZ?=
 =?us-ascii?Q?mwmLXftu2TnVTHjR42n4lb6o60w/ER6ZiKZWTxzBuXSriYWTrC/8yYUmHGKc?=
 =?us-ascii?Q?5PiTdS+hB3gq/ZMKfupgO5TTPNYTSnKmhHfOSLbjzBXkoBCA0kzvL0SmKGj3?=
 =?us-ascii?Q?Ju+kiWazmtmdBbMhDu56hPZZrB+nDUEqqzJiTtSA58R4rkAxL7+L3A/N8OIB?=
 =?us-ascii?Q?nLqWRFMB6XXMN/eQbh3VMHYjYoG7SlLMw5l2T8FlrGC+F3zQzHmITyk5Pb6A?=
 =?us-ascii?Q?hGgyJ6c3l0Ah2vVLkmzYM2W9AtkqJN+7Zldys552y54hatzhK6HpFH7aH7bp?=
 =?us-ascii?Q?f+/5X+f6Jc/aLTL2WtPz2RILLi6xtRIFNa7mmv6SxyrG8E5yOF0E7vvbCHeM?=
 =?us-ascii?Q?J/tb5bX3rWMFGGdyKWbqzskfWE+UwshgN2sqjSpr6FuNkq1/Na6z848ZLz5u?=
 =?us-ascii?Q?niGXq1LrxqLW+4Ep/LKJENKX6fj9seDGqEchjKQVpFIxpHiJ5iE5T2mT2ern?=
 =?us-ascii?Q?0KfQiXk3VUUiRZOJtt/1Qfu4JsrqmOJNvJW5dEOBkayq1zk2PP28hKSq4rn8?=
 =?us-ascii?Q?4zD1SP9/7kT2iPJWTXp/oviAqKtAaxMFbitwjGnTK2rI8Ck3Sb+SPKDJEWDe?=
 =?us-ascii?Q?tYBIyvJk4/IisgQHG4b5Omoav3/HBkmHwDV2yfUCgk29gXs0wai0k1hS0wpn?=
 =?us-ascii?Q?s2vS9JRFYzzdoO3D0GLO1Q2Unv5MMMh4jXC2kVYfnl3sn/s0Hm6rNJS16NEd?=
 =?us-ascii?Q?7JVkgCnK215A39N0JfNOCKGdl+z7uXC7fPS+45nafaJVvZqAEZOOvvXFmchT?=
 =?us-ascii?Q?qVr/Q/r/CPNV17kIjy7mUpVeOwXKQGqo7h9QkiGptp18X1+1G2UgETr2bQGf?=
 =?us-ascii?Q?HPsuSy9m0YpMWeSC9kIVBPwYY6JAbG7GXV2sDEJBzpG9OvDP9sCUBBZBaIsE?=
 =?us-ascii?Q?e3TuicZXLJ4A6O6H8IIIEIKxeZDALQdBQ6k1i3HdqfK2qM01cze3doQN5zFl?=
 =?us-ascii?Q?BmTqcsgbN+X1ToDaZtFQ5zR5U9kcVF3aIUevvZirbGgmQUlHX5eTJyFYmMEo?=
 =?us-ascii?Q?buu/fmS0BJn/QqtfvRKynffIAQdsmCN/8xCnhjNZFFJ6NLZv+JOiUOn/ahFx?=
 =?us-ascii?Q?jsqXlnERU4zFhVTPBJ3UQssTYOFBHbkiRbyy3qZOwfeHf6E8nZpDBXGos2wV?=
 =?us-ascii?Q?g3HxbhhX4sFShVKlcCebVchP3IyuMREDlcF0wsp+n3tmTjQTqOphSvfDGZLu?=
 =?us-ascii?Q?osHPDU8VlPo4GyeUpwVaQ30OPZMvCxAo2YE2lTxevDU1dC9aiw18SAx7VgPk?=
 =?us-ascii?Q?eOPSDnt//DwCRnjdNtxXg/tzNtSdcHrQnkfzUSmUUnHaTlAt3yEIL9dTRkxC?=
 =?us-ascii?Q?atf0sjYWPbMK/SE22X7GObM70thL296vXnrIZrfQhF7QYzzxTyAh0E92Dobe?=
 =?us-ascii?Q?6ynjyJMamk5Bf9+rUwjdOfvcRTjC09L+nBSl5wPfxNhF/EdVWT48lLu24a/Y?=
 =?us-ascii?Q?DLTDbr3/vS16Y/RR4Wk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7ed71e-f5f9-411e-f3a9-08db1df00060
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 03:08:03.8455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8I8Y3IAGh+3l2+40nDTrm/eyJCMxmq+SMBUXBpkG8e7enCTi0SteU16wJyeo1ac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
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
Cc: "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Perry Yu=
an
Sent: Friday, February 24, 2023 4:33 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Li, Candice <Candice.Li@amd.com>=
; amd-gfx@lists.freedesktop.org
Cc: Huang, Shimmer <Shimmer.Huang@amd.com>; Liu, Kun <Kun.Liu2@amd.com>
Subject: [PATCH 0/3] enable new capped/uncapped power profiles

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


The patchset will enable the capped and uncapped mode

This new capped power mode has limit DRAM Thresholds and conditions in DF-P=
State Algorithm based on the workload type set from driver.
The uncapped mode will reset to normal performance level which has no such =
power limitations.

Perf Centric Workload (Uncapped)        0
Power Centric Workload (Capped)         1

Perry Yuan (3):
  drm/amdgpu/pm: add capped/uncapped power profile modes
  drm/amdgpu: map new capped and uncapped mode power profiles for
    Vangogh
  drm/amdgpu: skip the invalid workload type

 drivers/gpu/drm/amd/include/kgd_pp_interface.h              | 2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                          | 2 ++
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h  | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c            | 6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c        | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c        | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                      | 4 ++--
 7 files changed, 19 insertions(+), 7 deletions(-)

--
2.34.1


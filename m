Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A191C48285
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 06:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DF0710F28A;
	Wed, 31 Jan 2024 06:22:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE0C10F28A
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 06:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOpG26N7cDvC5SNe/rsZB2jlCX/IW/on7E0rmYQgqDmZahVahMseX2iZjudff1c1xsO2uY5YQmxRGvt42N18Vi+4VjYi+RHJFSS0M8UODfjZqwpO6TwIfBGbPfcQKmFFZPHIyil8xYpZRzQCsYfvnnHODYpeY17pBXmNCqYKAdhBzQNsfu3UAIwYj5Bri9RCV/mYTnb44AoFAEILT7j4Jdkw8OJyJJIOjAm0WEVBcdHh4azG4keyNARDahL3ZCOVIx6F7XJD7p00bRtiB6G6gpY6XBYWBYaW4evuFb3yEeF9B+uIrjAMrtd2ePrfsjsa8gbWQ0b3/8IVibWs+QZhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joLqzr+wINBw4llTW2tyozWVAaySmmENleuBaG+wJS4=;
 b=lbMitWUCu5fzDWn+fi7u8/OcV4KehMTIXWKv+jnSZxuNfd9UO3XkHcJSNyNxvKK6j8lGbQdGe49QfksSccXthFGhOPl1EED1B/ZzsNiJS+uNq+IdMiJlPGGpUYD5+3PoCUryn0fbCuIsTnwIxi052AZeRROmQLlUdwF6fxbOruhP5vca52iQP6qvCMK7tG8yPOJtiBNdevUR2GrsUr6lMJoUdUg6BzT05uOzsNjSPPjqxaapFP9baUxY58dhDUlcrwmjyo82bK1RsYCR54TEYqvFHmEoYKqEZG4Iuf/m8IHgcic8gh7pgPLooc26P+ioYNjUDkSA0/9dQ7fzdwrh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joLqzr+wINBw4llTW2tyozWVAaySmmENleuBaG+wJS4=;
 b=n1a2L4uol3IhSbRpH82IhyCGvkcawCSzN+cvVlS0A8ZjeVOQKIIy8PRXi7cBT7POv5EV/hw12fQkHke4soDS6fDAhMAPGWFC6iYheZIqa43/U7E1g4K3/wyeztx7RriZNyDcn5C9nIy2deh5QC8FnGivfiXXCHA5xTQMlaiAi4M=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 06:22:18 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 06:22:18 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: Use inline function for IP version check
Thread-Topic: [PATCH] drm/amdgpu/pm: Use inline function for IP version check
Thread-Index: AQHaVAqnoL/7HTxHjEyOozI01HQ46bDzc4EQ
Date: Wed, 31 Jan 2024 06:22:18 +0000
Message-ID: <PH7PR12MB5997BA0A59A00107C5552398827C2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240131055903.1454962-1-Jun.Ma2@amd.com>
In-Reply-To: <20240131055903.1454962-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c26ac372-a38b-4cc8-9212-b3fa42e0d0b4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-31T06:21:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4563:EE_
x-ms-office365-filtering-correlation-id: a6550545-24e7-4d5d-9436-08dc2224f9bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gz1NdD7UDPAxlHbjUOhwz4Ex/pJsrI4Qyaa7brvolA94F9qRQe9ujxSHKyqBqMtdLmb+vhN6Z/rj4mJNcPkkuoonFLO71U2kQNSKsV/gQAJPULdpTYClodN2ep0S15tfqGSmNaDPJvhmTiq4m9rQl8UpuMzddNKJFDDNNkYyRybL3GWgWVkUeSqjZ4TEXOmHpGl8Uyryv9N/NyvsoO9AUyAdjC4JVAREeEtUpbYfZqGCw3LR3wx6Q1wu5oyCONO5yWQ0UXIuqEdkXZ74/SeMCtcxZxw3iGd3I/pXihRNbBWlYa/4F9RWWvaRCzCsHQVqGNrhuGSVoeYnlzKIDO8eFimd9FcCMqHAq8oVvN2ClOyXcViicdyVk0I/4VEmCLA4XrPonE81a9F5ZESuJ2/fhiYZjYIbOKA5JmKGZfgr7TAfZYXP2fFQmnnvg1DuyA2UnTGc4YFTd6khML88AfypID98queoZLu5I/xUwa1X4E5L6IRPv8XOCW5VFEcC5JXtUlULyuW4dXDt3mKxU6vkQi+Xt3Wuy0wgXcAChk/JJTT6hyRMxffJoGtNJ2CByxAcI8yRN08V07Bx1guMWCWE2p/F8ZSCYCPUpbU6A3zWFKI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(122000001)(83380400001)(86362001)(33656002)(41300700001)(38100700002)(478600001)(8936002)(8676002)(4326008)(52536014)(76116006)(110136005)(66946007)(316002)(54906003)(64756008)(66476007)(66556008)(66446008)(26005)(2906002)(9686003)(53546011)(6506007)(7696005)(5660300002)(71200400001)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QkVfJeJFfoTRn08Uhxd2IyqH8csrNwWEiPKTfgVwep34hklqMlgjaNFDLDuC?=
 =?us-ascii?Q?zW44+ktzEue51+Otn8To9WPARQq0FLeo8aQTWq0puFSIZ0Vu7f+IL6ZJK6BP?=
 =?us-ascii?Q?ebueNFPvZ7x8rLTICPybTy21ziTzaloyaJywv9egKbGOrlEOVxHgjfxRbJe7?=
 =?us-ascii?Q?XbrHBQBIn9XEA4D6VBoenyWBZdtEKLuaO7xE2TtMdXKOOfBQe2CraYGMZhs+?=
 =?us-ascii?Q?85cP2sUP6IIJtdseTgSE0vY2vBB8LGtfFh+OvzjLWPbQJTbB5kpfuDhlnvvw?=
 =?us-ascii?Q?bZG/6lbiISqrP5ooljNhJBZHBvdklcHbAWSVzsQJ914LujtocT/F5da1o7sO?=
 =?us-ascii?Q?QSSiHfZzR0yRvj/ypKEn4UWzny/iHNPoDVUpSbsv4JQtRnd9pT188WqXkC3t?=
 =?us-ascii?Q?Hn8dfz9hSGnzwKyf8mt355nKqxRSz5/GpSCnJpbJfqCVDaTRl0/66dqNEun0?=
 =?us-ascii?Q?+fNMOnuk3gn4mwMZ/oX8TUjbMJMBqM6Qo7wnMekP6s3u4aKpkFB1b1wnO+sx?=
 =?us-ascii?Q?zftxpNmuZOgSrH7sQ4Ug0ql7TYUPvGA1RIgSkxO+k+skoh+Nq60jZG8NcIgi?=
 =?us-ascii?Q?vLA4NKsq6N8al9vH2iUt70f/DnyRlWk0EFxGgJVIXt6Z7PWspt0e8Sti8zOq?=
 =?us-ascii?Q?NzCo4Yp+UZKGbHEt56p4eDS/1bpFUwo4SOCB8zVVgfVb46t488AjFl36Ut+b?=
 =?us-ascii?Q?0nxrktEaocFzwQyVfCdwgsKGzksR8KhZydt6XtkplI0YegWTjkSeAwzAC3Xt?=
 =?us-ascii?Q?Nmh6XahayEEYRKC52lfcXpMZRItizlpGoEvmwHWpbSlK1GMRzKKK38eqsMcb?=
 =?us-ascii?Q?OJXOYMHkGVl732u5TWpkC23C56+cOiVVkQ7ShQ/FgOSOT+9B9RaPvZXclE7q?=
 =?us-ascii?Q?VRJ1jAHExyBB/TBJ6PlUI2kwNnXf6wTtIZcH3KA6Y9YZmOxSUbcLbuXu45I9?=
 =?us-ascii?Q?aJJcBBtO6IhKufS5W42U/SYLs/Iy8+ufris4hcO9W+H+fJ5sh5AEz2XVOz3q?=
 =?us-ascii?Q?P+N+F5YWvtv7Y7B/VUCzP8cv1ie4huommJJxQg5aSx+ziD43vcuNhxw/ATuH?=
 =?us-ascii?Q?/WO0/yklb+LyeCcze24RDe0tN8ORY2hSqhvM6wCTQlNmhkOZYOKvQ05CbTnY?=
 =?us-ascii?Q?WikEmwFnFrEwmsi6eyuJCYQ9CrBf5mR7TWHIq1rnPFnV7NHOv0KmOar3vJOl?=
 =?us-ascii?Q?ZCRHNG6lUjerdWBp+WzGGrCa8aIZwZLdczAsJSYSUub67W/PvmJ3f+/WPYeH?=
 =?us-ascii?Q?nPZ3bseIWKndsemw/1H6UIPIM0GkkqC3RizknhdrYf3VI+rDM63MIasLMnnL?=
 =?us-ascii?Q?xyjRAOGmq12u+WK2vk7Iwb9Ukr5L7kEIXXAYs7yDwXgB4u5C6UqJESWKhVmS?=
 =?us-ascii?Q?qp/Re5Lm19UiD+/dBLfJHMOa/Q5UY2qA52yBJCqqPzRyCAku0VGHnS0h0UWI?=
 =?us-ascii?Q?8FMAHas2xqu5E/rq+iSAMck6DUssyS12qqkS133Vlf3MX4R6oGTNBBT/BLQl?=
 =?us-ascii?Q?COwGTkjwOJDEZbi4Iw4euJ5pF7LxItM3jPSrZFB/3TekkkMkaWq1OwwlpO/J?=
 =?us-ascii?Q?DzArCZxuuPJqxWxV5J8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6550545-24e7-4d5d-9436-08dc2224f9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 06:22:18.3401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yXBpXDtCeU4DWZp/lqBErh+BTDLnQVp2XVQCIsbB94LVhIPBHgmAGsEZXyxWTBk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Wednesday, January 31, 2024 1:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Ma, Jun <Jun.Ma2=
@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Use inline function for IP version check

Use existing inline function for IP version check.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index bc8bd67c48ac..9c72c36260ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2944,7 +2944,7 @@ static bool smu_v13_0_0_wbrf_support_check(struct smu=
_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
        case IP_VERSION(13, 0, 0):
                return smu->smc_fw_version >=3D 0x004e6300;
        case IP_VERSION(13, 0, 10):
--
2.34.1


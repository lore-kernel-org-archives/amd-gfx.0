Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2938CC5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 07:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BEAE10E329;
	Fri,  6 Jun 2025 07:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TQkJLyV7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B4A10E329
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 07:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xajihhTpJgCYy0Qmnqy/DQA/46hu6BhIoP5ZYSzA1RHAvOEkTsthxtvX0s6CpONEKuc8/qVqzPqIBTa/nk1axK5oBVGU4yERXqvJso4oJjPsy/pSdma1Ldo83CegnvoSmuOWJNeKABaYvI+xXBAq4PDn8FvjuB7xq9MCagaFOGW0EInZMcZZ6U3kiBZtMi0Iji7u5uUdNonM7WvPnfFSIEM9ElDvkD36y0tfB3UrMquLNl3nvyfkHQrDSk5VZAaWY5PR1tntdZCJas2uPB95PieE0OgWLx0dt1zrXUVJvE/L7/2gpa3xqkAaP6L2yR1cOwMC+GvPeSX6c3CPlNTeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8jdSrP1TQc8QiSYaOuLazN0r/HCrKs5lWgOJ9A1nDk=;
 b=CG8+wbqU6zpeCEV/efm9/QiXOsWu4lzF8/99WxHDeRiBiVG6bo7pBUh1zVG3rL6BN357dU63jkNnyya+wY8WKFbEXFnYNQS2ozCOlyMUmS/FS/UO94INueeZfCxC7EN7FbcoU1vpWfphCR8mC9xXXjsJIs+mI9t0NU7HEh//zpOczWxbdmlzu0ba/GHiXFgstuhtThEvBVbTq9O2C7y/3erHdbB0ANkzVTBnRSUP45uF5s6V0bzrjQhKgm9QalTQNiZH1CqhiTjOTqvAxGbGNg0QIKj5ZJuan30a1x3WCZ2CTGKmYk5g6gbWC9uPK9lkUaecvKRshFFNFZzoyVLk8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8jdSrP1TQc8QiSYaOuLazN0r/HCrKs5lWgOJ9A1nDk=;
 b=TQkJLyV70eNtWE3029g3BEvWe3mvC0NYwt7pCeiYA8PgxBVhMfkkpKzjQ8c7wC39c94KaDIbtAV5gfwYHni54+MnWNDnD0IYkbzuWMm5N50pPCszKcQ3e4t1X+rP09c1QGgnS/XYBNgULmjNY5h6bS8kYdtcmzVv/wTBYnTRjQE=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 07:03:33 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8769.029; Fri, 6 Jun 2025
 07:03:33 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Show default gfx clock levels
Thread-Topic: [PATCH] drm/amd/pm: Show default gfx clock levels
Thread-Index: AQHb1q/zKGLJvQOo1UyeCWHZEHiLtrP1s8HQ
Date: Fri, 6 Jun 2025 07:03:33 +0000
Message-ID: <DS7PR12MB6071CDFBC3D54FDEF5203F7C8E6EA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250606065453.690462-1-lijo.lazar@amd.com>
In-Reply-To: <20250606065453.690462-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=dff47ea2-9d1b-4b2a-bbb3-dd4f89229c3e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-06T06:59:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SA3PR12MB7783:EE_
x-ms-office365-filtering-correlation-id: ce9e1368-9afe-4f57-2d10-08dda4c83fff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QzueTM41RPXjkG97bYLFH5SkhOVVIdwicQhHyIO1YtYdVDhDeqtM62HKhJIQ?=
 =?us-ascii?Q?kQ8HwXc4n1sTEnzSAHyhbL9/rxQDcN3zlC+ZE9Au9sRlgPCWpjoCXJqV35L8?=
 =?us-ascii?Q?amjSb+pB4kNQaSMNrYfgX2O6Z/CN3GF5HKSrMy2To90HlTGd6XxiSX0T2tPr?=
 =?us-ascii?Q?ISDi6SOk2LFgJw97r+TYUwXclhsBPeeZnk9s+QIk8bH730g/9HFfnFTXgsqM?=
 =?us-ascii?Q?me/tNGVJCy0DQ2QvRTAiRAVS+RYye2DtBhIaeBOfzI5M/ljVsFlDSrY2DtXg?=
 =?us-ascii?Q?e+CjZOFoRPWelJr2PZprztDM1UUszAQdB0QWD6k5TPowfbMj3JQlLbuVHWGM?=
 =?us-ascii?Q?yiL93a6Bw6BiB0mDkUbSqr443S4gzbsXfVgT5mdRwcJtLR4R/YwhG3Ur9yTj?=
 =?us-ascii?Q?9d0CVHZX+LMC8XM6ZeJGhI0vHm19KLbL4N/lQaElPI1VYlNBFqDjUHOMhvcA?=
 =?us-ascii?Q?lBb9Wd6PTTv428M+PV5eHd9OEyvDs0xRCcm21mw8MN2InL9oNzKd5IpzWPzw?=
 =?us-ascii?Q?yFD8LG0fbpJHfY2WvDOkflQOsLS6LqeKsyuMvER4huC52gqkwPAzwMNkKyqb?=
 =?us-ascii?Q?09A+NsDeqMWoRR5jsPFXpQyhn88BZ5qJfUMtlbzaj3RkGtmtbWPxHWUiSIhq?=
 =?us-ascii?Q?vvDWniEkQUX//rDFK4lnX67T1gDwLguG7ERHkMaLOppQYaigHacSIHvQCu1G?=
 =?us-ascii?Q?1tU4ZfSSkIbBum/8QI2uSXgS6y5HdnUhUia9OdGukqm8cB4NmZoLJHhu1F6F?=
 =?us-ascii?Q?8yiD4BxYNkTNVFbmyowFYjl/wgZ9RN/ZkZ3aahvh2FZ8ZLkGTTUAEKR3WHHu?=
 =?us-ascii?Q?QSbBirUpq47RK0gnvY+LxabzNdZZznvhhgT8UUcrejTuHjmNkgqO43sLadi7?=
 =?us-ascii?Q?OmAR26OhRZgK4WiRcNMiuiD0k0cLxLcyrSey1fwUmy3Q27B3G0ENRjMPaUog?=
 =?us-ascii?Q?pZtPoE0j9Pgx3CBToezJMemfF7p7OuzN5NkXYacXuFfJlpfAQSdvcgNwfuXy?=
 =?us-ascii?Q?2eVWQ3884qv4WVn20klD9EdrrFDqhSchScMu0+oS/T3PaDcNylH05jGFl1ed?=
 =?us-ascii?Q?jj9DA1zSgZIaspOhal1O65mGYRTyClyz2IsDDyecsqxpfFxDl/QTSWTRZUOw?=
 =?us-ascii?Q?luBylcGs+zOD/yWZ9gjCJPgHgKqwjKGRMvG6Qfzdkqnlv1IoBjWMr8YBWw6x?=
 =?us-ascii?Q?G/5hN1g6VbPtgYPyo6nz8QrQ7kJHLNcWSgF2f3Du+U/oidEXLbuzSyN36ISI?=
 =?us-ascii?Q?SuzGRm4Q0coiD0cPmOq71Ijc33RdtbGTn9JRfdhhbyxrGugzAzALcJae6TUK?=
 =?us-ascii?Q?5BLwSy+Ne3QaMkSaAzuUZFq3fkLOJBMjtulxU9wmNio6V0EexIKdd7z0UQzh?=
 =?us-ascii?Q?bDNC+HqsjGB1AKAa4ZkX3adI3cgkAsUyxWdrZCrgYms+vXUMIm84DPscYwyG?=
 =?us-ascii?Q?7qGbgryBukLGnYgpuz3b/JcFSrgHAABiWsxuoT9mzoiiI5CBdjDprfqbF72i?=
 =?us-ascii?Q?HV5pAPprDKGP6k0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nzuE75DiRL+7Zx+dpucWMK64NxZPpKo/TaWyQp2lzyIFqy/8B/hxEIY5y3oK?=
 =?us-ascii?Q?6tWLRZ1sDL9FB/Uratqn/09d1qbWrAOX3/QIxNAR0upUdSDcWBQYLSN9A4W4?=
 =?us-ascii?Q?1OSqk9uU3IJwd9uFxHa8AfSNjFD1yxhrhWMULRbLzOq6ieXII0jlktOL0GBS?=
 =?us-ascii?Q?yvdbu0OXpOCkfnalrMNc8qrOAchIPzeAb1Cl6GlqCV5hxzlslnx3dtHbPsS2?=
 =?us-ascii?Q?nrLe+gE8oTMjYDY+3Fko9u0kb3W52cNL+GXyVsmcUA++Rtn6ruwd1uBlG2MA?=
 =?us-ascii?Q?p1FH4io8vf1XUwUK9NvKT8iv0BESVlvod8QW42Mzhc9MmPdm4eRiWkY2noIk?=
 =?us-ascii?Q?zQp3a/unGQNrPXwmiRGbRpsYqV5uEu5Mts/TLL2mIKk2HLglRoH44kIP8xbY?=
 =?us-ascii?Q?q13RkDPv7RqR/RRmznzMU77JOaiL/LdkF4CV19msUzDaTAstcjOl5/DjI5UW?=
 =?us-ascii?Q?ZuUwwKezWMvjzHTNcOXt2b4/xZmEZmtH+TEDH4d/hvojoL8XNC4UO/h+9RjB?=
 =?us-ascii?Q?9LnIMleKFjp/kZ5ayNz+rS3YkN7pcQMos+xvUUihhj8YMXgowGRP1Q3ZE/M8?=
 =?us-ascii?Q?BI7hcH3Quebwvz3lp+xgPJjIecN9TREe50W6bWG/i5ZuY0tFle4QxnDchipM?=
 =?us-ascii?Q?7gaTjxIjcH812IiL4aT/iYxdb8NV97ABsFkyX8gLTdKXmKOFFSH+AQsn5mnt?=
 =?us-ascii?Q?iWEWXacgolnsc0JZXyP9WdZiOPVkiyuUDUfeGwsqewgoY98hL+nAfMI7yqlA?=
 =?us-ascii?Q?KvL7DAEBebrYt0JuVy1OkeOf1g/XgG6XxDZSwng0CSkRaFZ8+PXwuXMFYOmy?=
 =?us-ascii?Q?hRZ8o2Smsk0uFJjxiIX6Wb6+9TupZteyV7pNZiYmTHbYXA6Nl3E0zUzx3gYS?=
 =?us-ascii?Q?ORfCAfsxkHXf7jTDZajLNKjkhNaKZQ+ordId1A1Z8tInGVyKnZZCx/OKotxy?=
 =?us-ascii?Q?KsIeW7rr12afpYbf5m3c410mVx3Gb6zg6tW8/1lSZBMdohlydWi+kPWj686P?=
 =?us-ascii?Q?BwI7AOK1HgvyVKhCfpnxGEohcGxXePu/lC937QkbFymzX53XOat0WE9jTqN3?=
 =?us-ascii?Q?S0kj3s1a7hyFzg4QqeEH6/hjOF8h0PKsL/N41Zi/o+SfxU6X8TPoKFVeE1lm?=
 =?us-ascii?Q?5U3NdZyBOFl/h4f637isUdB1A+8WkcvKsRkFoO8qcmDjvFP2yopVwUjyfnwm?=
 =?us-ascii?Q?J8xey9GkYJpKEaMSyFvVRzj5JGvI/0yIjH0Fl7hfQY43hzXrtpeI8K1mgTR0?=
 =?us-ascii?Q?yUXSDS/O6968/V5K/x+wLEpZi5Kg+8EplLQ7yJ8BhFz7n3hqBYHHPBAnlOFY?=
 =?us-ascii?Q?dbo9t5k6YmzRTbTA9BRjNToUV+l4G3kBB/i5WKBKwVQXaLPJdX+YlW27Yvf1?=
 =?us-ascii?Q?izpHDnW3pBzKxsLBQXh5gAW3yGbCE5ilKaD+r8qt3xAw1phQWAVO44tehF0Z?=
 =?us-ascii?Q?usdb3HxnnuppHmWsvGjdYvovOQqiRlxXvbav2Fb9WCsTWu4j6zC3mDT8yk1D?=
 =?us-ascii?Q?KGc3SFX9yzSZrh6JzRQ46nw2+W6I+DvUERu9m/5GQ+seajyk2bYb7FDkrCKQ?=
 =?us-ascii?Q?8gcIbtClKlUgPwcCYFU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9e1368-9afe-4f57-2d10-08dda4c83fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 07:03:33.0357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgoRzWK5WZo1e205M4b2Hd97u5bn7nrtDmBmEmCMO5ksU6bUL9WKTIgNN3QtcNK/kQjkr4zdc+S7sLH6NfQIzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, June 6, 2025 12:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Show default gfx clock levels

For SMU v13.0.6 SOCs, always show default clock levels for gfx in pp_dpm_sc=
lk. Any custom min/max levels set by user will be available in pp_od_clk_vo=
ltage

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 32bdffa360ee..36f210698bea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1416,8 +1416,9 @@ static int smu_v13_0_6_print_clk_levels(struct smu_co=
ntext *smu,
                        return ret;
                }

-               min_clk =3D pstate_table->gfxclk_pstate.curr.min;
-               max_clk =3D pstate_table->gfxclk_pstate.curr.max;
+               single_dpm_table =3D &(dpm_context->dpm_tables.gfx_table);
+               min_clk =3D single_dpm_table->min;
+               max_clk =3D single_dpm_table->max;

                if (now < SMU_13_0_6_DSCLK_THRESHOLD) {
                        size +=3D sysfs_emit_at(buf, size, "S: %uMhz *\n",
--
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FE0C25B75
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 01:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06DAD10E257;
	Tue,  4 Jun 2024 01:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AsJGoIwg";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D01210E257
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 01:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoPL/fn/hVsfbr/W+QXH22f8MHz48x4BSX3lEDzO2gmEm8mY3Avq9yq9ZTavYB1bx5kRUXSnhPss2XoVNEWr5T06fnDw3+OEsF9J7IpSTXw02GrUrOY5nyws8KWRORtSgqpPzd6O7iGR5YemlScqDLPAcQqrwSJqNvjh7SCxSwxOZUpRoUj2iBqpCpYWWvKVSodpaf60PzDPvTYOXxaoyt0jQ5ZYo3lrSlcV2zW3HShhEMFPDejVV9vYbHCCbP5ouzMMZQi2b66G8Uu2Aqk0jGAuaEX+6YZwvL6loIvfHh9/4p6xGN0irj3WPh49up4QUr9gxNjkcJQueo8Z7CKJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4q3buH/rPG0lv89L7Zhij/U53f8aoDJD6mtdf9phzE=;
 b=ZobhX+lWVEBAAGk4PCnM6SJem+FssotlwJ+hjFbOR/lxnBLLLI60hU3t1lvqzyahRzXnhS+0CBmTZkfFf14PaJ4l9+FHt31Ms5Cau/mdv/wsrKmS1GHlbKF+RDjlIYm/RIho1kxwha4e/ziSXizI/8tHGEqcyVeUIBvQHD/kXS3VjTW5oAyUTQweC64tBO+Sx+Vy6xbeo+o9yHI1HPcVdPGta3mh+DdqjKfalWuZNbMAIUhlwj1M5OrDXXvYg6Ufkw6WSKRrXdl/LsWtbnInaJtDKNfWzyeq4FCtF+ij9giUH0Cw7e/5xUQo5X1JyfQI1+dQ0LFw93Ry+Abm3rwwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4q3buH/rPG0lv89L7Zhij/U53f8aoDJD6mtdf9phzE=;
 b=AsJGoIwg2VZ5+O2ruobNLRS/mRN/PXjZOKeWLq52OutfzXxaEyu5N0rm9nde9m0YGgkBYE8BVVBSB4688IQJEWoTuWIMhKA2tSuhz/JNkQ0MNdJFmyZz7wjzZncJhN01DZPZxmf7yvXij6Ep8d3xBuYkEdzx5Jl7nRx1hpLS0Ts=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 01:22:54 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 01:22:53 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Topic: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Index: AQHatZK0Ej7ZmMphHk6JicZTctqH/LG1wBuAgAEOngA=
Date: Tue, 4 Jun 2024 01:22:53 +0000
Message-ID: <DM4PR12MB515268FF505C25FCC69D0724E3F82@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240603084730.2569970-1-jesse.zhang@amd.com>
 <DM4PR12MB601207AD23D14B7BB64B3CB082FF2@DM4PR12MB6012.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB601207AD23D14B7BB64B3CB082FF2@DM4PR12MB6012.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=689ec0ae-dbd8-4a02-a8dd-a477a98b33ef;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T09:05:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA0PR12MB7004:EE_
x-ms-office365-filtering-correlation-id: e32c0fe6-ecc4-4d4a-3f02-08dc8434dbbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?QocWlHNU66vD3xIP0FkqSMw+OkR1CKwtitQRFq5x4/bx4tNiYCH9V0kMaXO6?=
 =?us-ascii?Q?2NoWctan6B1Y7LvKDd9WMLkfZXvECzR+M8E51irMS08IJDMtyqllrvLIEFDz?=
 =?us-ascii?Q?vh+IN4QqfIECJ9pPbl5E/zfdTiuI6UBro/OP8Tae6B3aG54wTIlenfeWhbHt?=
 =?us-ascii?Q?x7COzr4XcUT0HjDNKRk/bMvAq0aOJ3vocDWy31pNuFGB6EsSsFq/Q3bVMdEq?=
 =?us-ascii?Q?ZoVTdXTF0LX+5rG8uOtkp9fw/fTGQOvnUKFgeK2zQJLZgdztUMyhVS6qKZ08?=
 =?us-ascii?Q?67PBZvpZ2pCPcfI27lpnZUT+Pd4bRaOPchTRhnOoYfByQVyR6ZAz7/pOcoBH?=
 =?us-ascii?Q?v9Pqo5GumzE5mxkG/j2kneOEN1FBbxNqR2GQZ/vsY26jb/B5fi8zMo1PRDNr?=
 =?us-ascii?Q?H8NxdmPy4si3WVynl8L7HgB8FDvKatyVzYqi4yceYVDWAV+c4F6AGbeYxKvA?=
 =?us-ascii?Q?s5DWvSRgDi4ZjEaXdTbqXY3IT+MixHalI2rMcERHwWFB7EOGdpvn99uXNTEi?=
 =?us-ascii?Q?2F7FobtiTBJmCAOYc4MoxT6NJegEdU39XknhqVke7PdSV6Tp089126BakIXG?=
 =?us-ascii?Q?AkEVNM3Cpg1lUT4Hts2MokkDWAZOKQ/t3Lp8tKRgoWE7FVFJKCmQNrWLEnjT?=
 =?us-ascii?Q?+I+Dk1RRB7qVjjYbPf0A2klQ8G6Fp83NVtQtIJuHtzRZvUUonAHfg8hw+8pv?=
 =?us-ascii?Q?a6w/ACBJ/6hK3wMiNoImiQ3G/ZGZPi5WW98rHovo8G754zVf0WZCZkc+pYzC?=
 =?us-ascii?Q?MMV27QqMMJm/mKEqnczly+cqpX4pT3UQLBI9h1v5j1mJdkAHevpzALpEIu0Y?=
 =?us-ascii?Q?ijFZx4f0/g1FQwct1dZaQQvymCV1ZvyxK7ZVX3hLy+69f2k33C38ekjb7m/2?=
 =?us-ascii?Q?XxyyLgEnFtApH5vhNQmlKRt8qjixghe0x1FwuxNhvAbfK5gieJLUzbsWh8PL?=
 =?us-ascii?Q?e/ZEy2oCEr+cLVBGyxjXTTfP1fOyBHy3wu4htaK6FL30H8P3Xx5KPgiTyXj5?=
 =?us-ascii?Q?Fa7vEAWkFEX4YQiHxCkbAl9zAn3oL74o/vxpe9ez5FZGcUlo4jTYcXrsMkyw?=
 =?us-ascii?Q?8c6+MKB4SdrdpJmsOlQoJohzbIOkQOulQlQQqv/HT8gNEilnmDhYOCFxkQOg?=
 =?us-ascii?Q?/3/U4aqsq9PlGkqRwJvSZ4afPp3s9Nb45r/VfWrCU4ViLpW4Bdg51Cwa7mQm?=
 =?us-ascii?Q?gfutgVt9yo3QXZswCv5NMaXYkcrSdCvsZozFUk6I3ivUfUy+GDCoVx7b3n9p?=
 =?us-ascii?Q?IgjXgcBGoG5Uda6ae01wpvgveMGCXc4k6fYR/D1A75dsqZ7BNaqIF1kWdcGN?=
 =?us-ascii?Q?06W+pqDXXC/blN/ntIgfg+psOUGrS0ye/SDdctFohWNatA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rBR86yg3WXzufOzUx+5M9NbLz4n/QmV7JSzgWsYecCbiipkq+oFOhaSdO4jD?=
 =?us-ascii?Q?kw6NMy71rakv9E5ypSWC90fvsCNzwz5l96sPm7QK6NOYDrUsceUX1xCE6riz?=
 =?us-ascii?Q?/54bnckm8H/Jo/X+sgAwlo2CdkVWOkv0GQPpnsnhBPUysXLtCmReZSDbtmCX?=
 =?us-ascii?Q?JhLLd3rRTs3prQylgN63bG8pfxYL2YjhF74iXOKodxcZYMltqXOk3UgkhHzH?=
 =?us-ascii?Q?WTS59xbZV2rij6ONcWtVXMYuvD8WjRRpKkEqnJ+vMQCGQ9nQehmpXh9JfExo?=
 =?us-ascii?Q?4IBFoA310bBhckJgtFZZ27rqwzvlQpjkJ/NCzK+vR6xzBRSaLVVe5lmGu+Ig?=
 =?us-ascii?Q?Zz0sCpcctfEBjmtBhHdpn43+yDGRoVflkUHvQn47SOWyyjKR3wMuM0I+G5EU?=
 =?us-ascii?Q?S7NMNUYbbKgvLgEZcthM+3xXfP3VqZaGm60p8DqteT6uWzJdTL4zJnXoJ57b?=
 =?us-ascii?Q?0TN8pP/lTssafx9G7MCB2L2IxdXTjY6AFdZaSWIxQwNvVVhHBeyf3+uA9OeV?=
 =?us-ascii?Q?OMZOafDT2f/03GXO2vV+RCljNzjItQnzbwax+B5FRLTOIIhH5X3aHTBIjXHX?=
 =?us-ascii?Q?s0lsojggyMrWbAzwT8SkVSnNJJ5LFqRrcwDxIocG1ptZX+XebsY8lml0+aUG?=
 =?us-ascii?Q?hYKiYW0SeCALzcWBM9rgYTUu9MWeZEEdqtdkA/0CnUEQAq0LfJwpCnP9xzKd?=
 =?us-ascii?Q?m4OQNANeZ4kTegqNYauCdiZ+KnsF4II6vOVici7wHlsuQM3UoePbJ+QRbtGz?=
 =?us-ascii?Q?MEVKfAsPcjFTTNWrEmVa3XCk35B6wyBIK2x/Dp1L6YXWTPaPiUe1ceuDo5cd?=
 =?us-ascii?Q?BqVetOJpa9gy5N83AHeqbM40u65J2LQw1CYyOw0IDLyePXl5WEyc6ufq/fsk?=
 =?us-ascii?Q?GmXMjxiQdqnMJmEATZoY7iaIkXTyY9vyPhcHGW7ffrVfESnMjGvQ7uMoL+Jy?=
 =?us-ascii?Q?RVdVSyt/IHg3qRAiWfzaB1TnxXWpjZ4WRH+ZivEdLBq7o1QlTmw1Li4PuGMs?=
 =?us-ascii?Q?J1katvzN6GPArv0MLvKi/9bmB8AkBUlvqEjetfH3OVhqfxC9jiCmscG9+YUE?=
 =?us-ascii?Q?STbu8aof++1MxMMLZfx8BVih8QsF28IPOmXYwvElkYCKk+6Qz5XiOC+yCc97?=
 =?us-ascii?Q?nuh9Nnf6b62iDyiXwoF8mKmoIIsdeYmVzhPXsp9HcD9nXkoQh4pU48Wkka6J?=
 =?us-ascii?Q?Rkq3neXbmQk3atr4ERfOIL+Lw5GAhncBGnxF1DoexYAeqGmjGa6oK1mO8n7Q?=
 =?us-ascii?Q?jZcuVU2V1Ejtqcq6k5XEnWrTUDZy3Y0GgzjAkVgsQabqIIa05+HPHDt7K2a6?=
 =?us-ascii?Q?2TgSvx97a5xF2F28/GXsdCUG98VJnPgf9/Thi5dgd6B+0JRMKGgwOnrD3OpS?=
 =?us-ascii?Q?Irro88XYhuIGELHfRX8gCH/tbuNEBVm9BiJetZ24Q0Rt3yQ0vEbcIjom5qGg?=
 =?us-ascii?Q?E+pLdui9EG3g9dPz8+SxeSm8oVHezGmUAT+BAaLUOZLrN7aXk0LVXw7ZGI6B?=
 =?us-ascii?Q?TkfBmhPwqGKJE0cGUSON+8cbwOHDtGVJIIS3qylmg9uZahUlqfYz/U5+Wwij?=
 =?us-ascii?Q?Cjy3ufzM3TSGnxsjVZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32c0fe6-ecc4-4d4a-3f02-08dc8434dbbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 01:22:53.8963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6qIjhDth7Vk0bK4s4pOYZKJrbOcI7E8iQv7euva34reNZEdt09PiJaVPdr0JJQg0jP45KBhXVJ3aJmOI4HI2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

Hi Kevin,


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, June 3, 2024 5:09 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse=
(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_=
levels and navi10_print_clk_levels

[AMD Official Use Only - AMD Internal Distribution Only]

Could you share the problems you encountered?
Some compilers may prompt you to forget to handle default cases.
[Zhang, Jesse(Jie)] These warning scan by Coverity. These are useless redun=
dant codes.

Thanks
Jesse

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Monday, June 3, 2024 4:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse=
(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_leve=
ls and navi10_print_clk_levels

Since the range of the varibable i is 0 - 3.
So execution cannot reach this statement: default.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index cf556f1b5ed1..076620fa3ef5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1389,8 +1389,6 @@ static int navi10_emit_clk_levels(struct smu_context =
*smu,
                        case 2:
                                curve_settings =3D &od_table->GfxclkFreq3;
                                break;
-                       default:
-                               break;
                        }
                        *offset +=3D sysfs_emit_at(buf, *offset, "%d: %uMHz=
 %umV\n",
                                                  i, curve_settings[0], @@ =
-1594,8 +1592,6 @@ static int navi10_print_clk_levels(struct smu_context *s=
mu,
                        case 2:
                                curve_settings =3D &od_table->GfxclkFreq3;
                                break;
-                       default:
-                               break;
                        }
                        size +=3D sysfs_emit_at(buf, size, "%d: %uMHz %umV\=
n",
                                              i, curve_settings[0],
--
2.25.1



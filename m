Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7898BC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 02:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D329910E2D9;
	Wed,  1 Jul 2026 02:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dR4QHJgY";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010070.outbound.protection.outlook.com
 [40.93.198.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 458A510E2D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 02:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvjuTl+SFWRVH9D1E8bFM5RyfAHbPCLtBlVfXdwZcCQsLPq4hdqm4NjnYrq9ynXnO/67VFOCrRz3PQ6sUVpQqKGP/Kj9Twwa/FtLMrIhzAwiJ1RPJ1J4/syYBJt49aVZp4vouxKjTgU16qJPl7bwbqk7nZ0iV0gIVO6kujAYkyBPhapbvSjGwKQ+0pePnXdJY3izE+FEt8tw76xc9HKPktYZ+HmEL8AnAAsrJZvAGuyYkY2BgJ/Tvsa479iYFetd8iYZsSth7xny7b5XY0wVX7U961TRgwb1fRLhmx/rkCYeKBsL765jxagI4dOWwKX7RyIKhh4qm3eF9F37HATsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukcZiobE5H1vlPoXEGVuLt9XcMMVkcRLeoT47SsWfbw=;
 b=HvLUgv3dS3y6+dODfcYk8qBdZIvWYNpu3uO5c5crbEIA+x4QSoNN7kW7b93P0+4is2TM3VIGtJbbd83GLTHFfwKBcjB09wLDzxQUkDcoZOJklEKMs1457W7nTNX+tvGJIcZ+KH/NShisMShlnMBKMB+mQLHrh3QjS/MCLv8lPBTeLUnozxVGwiJYcx36epjg1py1YPfyv5khntB8DXnFPV622kO7MRoCmujL+Q89dsJJZEAYvdTa4rD1gTrl7v718RSlAUXUFhQ1DAsQptrOD7AWsZHS/k6xPhqWoZxcWrYEBBm8K2uD8cwLKdfPGZnhf88AMLB9knpu+2f9LwktIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukcZiobE5H1vlPoXEGVuLt9XcMMVkcRLeoT47SsWfbw=;
 b=dR4QHJgYeMl7BAyxl0p9are706czwlqEL8AhWNYRWnT1g9QWylWhvF8SrZJF2qgVosC2MLZw4lrRHRuOuHiq2F/wri9Y2PzQzRMyC6y0T7qASFuI4V6LQUu02RXSclXaNQVzU6kR04lDz65nobWJko5F40WUsCTzJIkBENjLUIQ=
Received: from SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 02:19:00 +0000
Received: from SA1PR12MB6799.namprd12.prod.outlook.com
 ([fe80::6d46:bf1d:4a60:76c5]) by SA1PR12MB6799.namprd12.prod.outlook.com
 ([fe80::6d46:bf1d:4a60:76c5%7]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 02:18:57 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix smu13 power limit range calculation
Thread-Topic: [PATCH] drm/amd/pm: fix smu13 power limit range calculation
Thread-Index: AQHdCPzUUBFRiswcvUO7pYm14NavqrZX7cow
Date: Wed, 1 Jul 2026 02:18:57 +0000
Message-ID: <SA1PR12MB67993B58D8853878E493977A8EF62@SA1PR12MB6799.namprd12.prod.outlook.com>
References: <20260701015558.3757481-1-kevinyang.wang@amd.com>
In-Reply-To: <20260701015558.3757481-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-01T02:18:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6799:EE_|MW4PR12MB7384:EE_
x-ms-office365-filtering-correlation-id: 2f25f198-a65f-4a3e-7c61-08ded7171b2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|38070700021|6133799003|56012099006|18002099003|11063799006;
x-microsoft-antispam-message-info: MzoQfFO4MT7WMflJn7gQAUeFkqYRphc8ziHq415tOHKwlyJEMWDUGxThlbQp5/Bh8kskadcfELdA5PmMQnuJ9Sr+OGMklI1OUlP/nv9WFA/+GGH6gLAvmgLrVvZMtZjFG+BQJ8lZ/x90XROTgD8MkVvCDfvPvNrQ2vW/pR4HabhOluX26FPME1WU5ZkL6hOtrdqGH+82uvGB6G6hZ+mAHf4wcjxeZd3KwIVyU4FC4v+quuZSGWgKuE2N9M2QBRAB/E1WUF9UcbmKfjF/Yl2wIcCjthXGbKQrtrQusvcWbFHejWWmqWJ6Xv8Y9dUQeCxj3e+zusje57iUTaxlm+Siv5amls4zWupyA4QKEobYIuagOwEBKSGE9luDlt20D6i45Y+su898DDu0eNtjtS2bk8mKSb9V4DqaG9TFJF6EJu2iyF6TkMr3ztT1MIKxqtCGlsWbrfKpcp+Ee2M5timZKo/tGXiFL48UV2FVIZjkK1MutAkr2xRJZt6qiNh2C7aPJ23+lgyZO74/o2di0SRGaWiIsHkxLBCZFOeoaYlO7+j4S15bMi3+JY5CLpJ/xAwC6eTy8ByvaXz8hYtPNA7ycRYrAxIW1wqgfDTurfGX7Ydk9+j6QccKTzQZRtdAEY9ow2bGpHSL72W+1RgUaSZ/Bo3zQc7RqARKfA61uURsgPjkxXa+CV3EHcxTq2QG/rZReip8wSoT65SgsrdB+FT/PG1p0BesYlhR2SHMSOp+2dQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6799.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(38070700021)(6133799003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PfY0Jft8FW4Qe3tF8SDP8sbKbI4sboHKsS1/Wd//r5OyEhjeu+279531+MBm?=
 =?us-ascii?Q?Pk/pTGld+cqDAzOxDqSQpQ12qreCFMYDib5qMu3ViYhsk2S2QqpCd+Q/i9qe?=
 =?us-ascii?Q?Yr4SrvuBPlBl1FF8a5xGkScWJuhtRtMm3mlNRjEaYfWNAZaljwjwgBhp93DH?=
 =?us-ascii?Q?XlDezzFzQlXBzMLp1CpbWTWUs7oIw52srIovatP6+GscyFl0WbQ3ULCoKew/?=
 =?us-ascii?Q?uB7+b25IhS7jNjqcrd3x9IkSCMAbK9Pum0cGkNDm63BUU1eN8IQwbyUccy+H?=
 =?us-ascii?Q?V8VKvZnbTqCD1J+gmbkfc/70q/I9PEq63A5JifXTLfw7R54X+/a0jUKUyhX0?=
 =?us-ascii?Q?RiQ1LBWP+PD0ncHphyQJ8uEK/eFUIcq8eDg4VjQcMDCJGiYSmdfr58u22PLD?=
 =?us-ascii?Q?xoXCEDERQt93BlX83Q8W2ce1MJpXremU/TmHZfAxAItTmhA8fuspb5y4tcbk?=
 =?us-ascii?Q?WWZ+v2Ev99NZfXLccymkgKtCXxriKCEE4muufnWkIFHgimK/nWg3q1Ep+h1W?=
 =?us-ascii?Q?cl2QCkrlVbgGppNFQfUCvld1UsQECGbNyBYbO8Wy1o5ZBFSlvHOch2DNAUXw?=
 =?us-ascii?Q?+f1zCwVVqtYdIR5WENSozkcyl4nLZ3dT5Gc78mVO5KST7YavoG9d0aZOj7Lx?=
 =?us-ascii?Q?wSNIed4VWWXTOzmwppO8faKON1vCp8Lfm/Uu6K9jceAKTsyp5XR7mY0+/oqR?=
 =?us-ascii?Q?OU6qA6NLRfVtL7dReBs0YmbtDQwML78++j+Dc87RSySavsJlBNY0kj9H8IUW?=
 =?us-ascii?Q?dFqKE+cvWrpmLGWitDe9kdOmhCcTsKGhYD1GVj28FLvrcK4L5vmGiAI9VWC+?=
 =?us-ascii?Q?W6u5ZGaxp+HFdMVHrIEdIjMvM+rjYNI2tcuCmGwCbz7rydkJh88CzKGr+K5H?=
 =?us-ascii?Q?DQH7lt5PZ0jMhGfRrD86Ac7RuIDPo21OaS1ZENYolJGsmdReVjnaxkgek7hR?=
 =?us-ascii?Q?GD+U9DglPdt8htEbexaNccRWuspTzXifpy4PreNxAoHaubd/5iM8rCiuajFO?=
 =?us-ascii?Q?iLq2cSp7EgNt32J9Ej3BloCnhRHmbv7pEQBn6P0Yu3Kgqb2KXS37741zHiYE?=
 =?us-ascii?Q?Z0tWOrGZ1MenWdad7uWG+plyHgjttJD68YwHqH92HHq1y5DT9n+EruzHEjRl?=
 =?us-ascii?Q?bp9Nx1gE4btEGSMHkozkL6U+nvvutaDsUR+cBEa0FR22tvN6CEhJ3lobtV7Q?=
 =?us-ascii?Q?7BmGxC35oTncUIygLWtTXThexyYoTLD93I/QNdKAJGV+cLV+u5kz6/PPTt6R?=
 =?us-ascii?Q?8CaAvs0GRqm5nskLl2MoxP81R8JFwZMs1lWySg1zYWcCO57gcAP6JCAd0Re2?=
 =?us-ascii?Q?kdLC1q0Jbwqn4qdVBVe0cUaT7oFZWYUajWrmI+Xt5CQmfVh1oLIim8+QooJH?=
 =?us-ascii?Q?E/90fahhsPmFeDU4XQm4OasL74nDgQio76PjTxxns/zUqDTVn8wANfxGeaAu?=
 =?us-ascii?Q?RX/UWLe4Nc0cZHNRp+CNE45PLjPc+yUKdCpFmtwUcJGliY566jRtjN8uF3uj?=
 =?us-ascii?Q?xXcEjt3KcV/KQoa+OYzX7R9q9maTFnh4wezWU+lAmqfZIUkEl0Q9hzmX4St2?=
 =?us-ascii?Q?7Emj6Wg+fMfNgaPHBgpnXeym9zRWs9vnNvu1yGp1WhSmxDAJFDEPIp9jAvmu?=
 =?us-ascii?Q?EOVjmyuNP4CkU9QTrL94x2TPdT+PSbtkNXleG5eBHDXiZZ0xvzHVvWndJ0pg?=
 =?us-ascii?Q?qzxx6UNx12MAXo6TmIlm5QtLyiR2l3SXgUrMqcdwGFyztq+2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6799.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f25f198-a65f-4a3e-7c61-08ded7171b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 02:18:57.3024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEqMOMXL+7CNaSxWhnSl2SMwR+qzCV240lucPPNAPcdm/bd7cwrRhghsLG1+o9x7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
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

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, July 1, 2026 9:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix smu13 power limit range calculation

SMU13 reports SocketPowerLimitAc/Dc as the default power limit, but MsgLimi=
ts.Power may carry a different firmware bound for the same PPT throttler. U=
sing only the socket limit for both min and max can therefore expose an inc=
orrect power range.

Keep the socket limit as the default, but derive the range from both values=
:
use the lower value for the min base and the higher value for the max base =
before applying OD percentages. Keep the current limit query independent fr=
om the cap calculation.

Fixes: 8c658297a4db ("drm/amd/pm: fix smu13 power limit default/cap calcula=
tion")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5419

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 11 +++++++----  .../gp=
u/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 15 ++++++++-------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index c984dce48310..560cc306f10f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2404,11 +2404,14 @@ static int smu_v13_0_0_get_power_limit(struct smu_c=
ontext *smu,
        uint32_t pp_limit =3D smu->adev->pm.ac_power ?
                              skutable->SocketPowerLimitAc[PPT_THROTTLER_PP=
T0] :
                              skutable->SocketPowerLimitDc[PPT_THROTTLER_PP=
T0];
-       uint32_t power_limit =3D 0, od_percent_upper =3D 0, od_percent_lowe=
r =3D 0;
+       uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PPT0=
][POWER_SOURCE_AC];
+       uint32_t min_limit =3D min_t(uint32_t, pp_limit, msg_limit);
+       uint32_t max_limit =3D max_t(uint32_t, pp_limit, msg_limit);
+       uint32_t od_percent_upper =3D 0, od_percent_lower =3D 0;
        int ret;

        if (current_power_limit) {
-               ret =3D smu_v13_0_get_current_power_limit(smu, &power_limit=
);
+               ret =3D smu_v13_0_get_current_power_limit(smu, current_powe=
r_limit);
                if (ret)
                        *current_power_limit =3D pp_limit;
        }
@@ -2431,12 +2434,12 @@ static int smu_v13_0_0_get_power_limit(struct smu_c=
ontext *smu,
                od_percent_upper, od_percent_lower, pp_limit);

        if (max_power_limit) {
-               *max_power_limit =3D pp_limit * (100 + od_percent_upper);
+               *max_power_limit =3D max_limit * (100 + od_percent_upper);
                *max_power_limit /=3D 100;
        }

        if (min_power_limit) {
-               *min_power_limit =3D pp_limit * (100 - od_percent_lower);
+               *min_power_limit =3D min_limit * (100 - od_percent_lower);
                *min_power_limit /=3D 100;
        }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 7d0222d3d44d..8f214400cca5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2386,15 +2386,16 @@ static int smu_v13_0_7_get_power_limit(struct smu_c=
ontext *smu,
        uint32_t pp_limit =3D smu->adev->pm.ac_power ?
                              skutable->SocketPowerLimitAc[PPT_THROTTLER_PP=
T0] :
                              skutable->SocketPowerLimitDc[PPT_THROTTLER_PP=
T0];
-       uint32_t power_limit =3D 0, od_percent_upper =3D 0, od_percent_lowe=
r =3D 0;
+       uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PPT0=
][POWER_SOURCE_AC];
+       uint32_t min_limit =3D min_t(uint32_t, pp_limit, msg_limit);
+       uint32_t max_limit =3D max_t(uint32_t, pp_limit, msg_limit);
+       uint32_t od_percent_upper =3D 0, od_percent_lower =3D 0;
        int ret;

        if (current_power_limit) {
-               ret =3D smu_v13_0_get_current_power_limit(smu, &power_limit=
);
+               ret =3D smu_v13_0_get_current_power_limit(smu, current_powe=
r_limit);
                if (ret)
-                       power_limit =3D pp_limit;
-
-               *current_power_limit =3D power_limit;
+                       *current_power_limit =3D pp_limit;
        }

        if (default_power_limit)
@@ -2415,12 +2416,12 @@ static int smu_v13_0_7_get_power_limit(struct smu_c=
ontext *smu,
                od_percent_upper, od_percent_lower, pp_limit);

        if (max_power_limit) {
-               *max_power_limit =3D pp_limit * (100 + od_percent_upper);
+               *max_power_limit =3D max_limit * (100 + od_percent_upper);
                *max_power_limit /=3D 100;
        }

        if (min_power_limit) {
-               *min_power_limit =3D pp_limit * (100 - od_percent_lower);
+               *min_power_limit =3D min_limit * (100 - od_percent_lower);
                *min_power_limit /=3D 100;
        }

--
2.47.3


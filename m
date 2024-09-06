Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788DDCE7AB2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 05:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B901A10E15F;
	Fri,  6 Sep 2024 05:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EdhehcMm";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB0810E15F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 05:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leXsUe8OHpAIVdoLQlgK4xs8TG+gen0pwebzEZKvILuaNz4IcCGR/agiVd2tTFiF2CIf9z8cmnYGCprdrBgVXsvsa9bNys+/3Tv339EhcwTxNhc8Xi4K3Jq5wAhPQlG9a48xexYoMzHzueWiJ6XrDXuudcpGuK6LmqSB4/gOopDuARDbthqxMgX+06oXa6zdRhSvxuXBa9kzcAsaSNBZP7MEDvxYWzlL6TYtGy9tOWfsp+Z7MK56K0WCgg4wRPCNiomVlja0uNvkejJiLjHgZjsEbJngc6Ss68Mnfy+kPTRcxmPqJPwGlhwCaOnZZyWUva84+R1DRVuh0QOLf7AQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dK81mMmE8yvt6UBySIYQ1YH1FEE8M07W6+ZMtk3iKtA=;
 b=owlm1m5WNwKpkYy+m0EnfR7sYwbDuqYmnzIMGxWNJ4swQvCyVgly38PD/1RGkteYeTWL2QTzm9+E2/nNWHlqyZb4RXv0Ion7l0lGP0wsYxOHIyh15NiD5QiTP5BpaotEqeLScimWMqRYEaHTwG8MDn5HrjPO4lYPho45+AVtAGaboLKkfb/gX6KS1dqz0vN+KFaEsujBsguxy2KDzZ0VggT/9w222lJkIixc501bByK7y/D/LkO///DUJB/etrT19baGvhMU16CM4WVEF7AgDqqaAkY/V+A+3h3jPieQfbi+xhpJnTRg4LOKbCy1m+J4dvlPXk5FKGX6CtnQp+Y+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK81mMmE8yvt6UBySIYQ1YH1FEE8M07W6+ZMtk3iKtA=;
 b=EdhehcMmd7OuT5f9kSidQxMNHZxGO/WBAfyIW0392Mc4wFpWfMPBq/q0UI7XYNHUTj/ew37huFW1+fDo8rayQ8W110yDjyPcfdEfV5KmcoZlvdxan/Xmh/3otanT8wl3jfkHrpn7GNJKpAQeNBeuZIGptONtIYwhPlAcaLnnsWg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 05:58:17 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 05:58:17 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update the features set on smu v14.0.2/3
Thread-Topic: [PATCH] drm/amd/pm: update the features set on smu v14.0.2/3
Thread-Index: AQHa/2bY0SvqTV9q40GwvP1kKufpk7JKRICA
Date: Fri, 6 Sep 2024 05:58:17 +0000
Message-ID: <PH7PR12MB599788ECBC348AB2CE4428E7829E2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240905074002.47855-1-kenneth.feng@amd.com>
In-Reply-To: <20240905074002.47855-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fba23735-354a-4077-abf2-7b9d00f422d4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-06T05:57:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB7796:EE_
x-ms-office365-filtering-correlation-id: 98bf5af9-8dde-48cb-ba2f-08dcce38e767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6QDXeop9XuEekQUGbx/OgWml2EiKbiI3R3M+QI0e77qRnaUG3b+EnF18RR25?=
 =?us-ascii?Q?THgmVxgRTLx14qEyrbdKcJQwiK4QhUGaz/s0zHKPnTDiVr+4YJ9ZzdYwcZv6?=
 =?us-ascii?Q?haOq2vPfPlQFtqB8VY7ULBRNnAv1xN/bDdvoPpO7mDswMQTNCxXn2BUCHTlq?=
 =?us-ascii?Q?VCGW8ldlS758EoXc7xslGLVDCd1/XF3+Ih5q9mFaciRd4SIzWygKYk+4TBs2?=
 =?us-ascii?Q?EfknjdhP5N4/pRtmmJbK6paLMFfHTZvFVYqDoetuneD61BhpmLkH+bBqT9pz?=
 =?us-ascii?Q?vsuGFzjSD/JSngs2VU/Uy83i76l63xB8wFElsX4ESLh4j7n5ncnsr764cPjy?=
 =?us-ascii?Q?59iVIMIwouqnROWC/89qp0OPKBHNj0q64rHbi01oV4+d720Ea+JEDq00gNsA?=
 =?us-ascii?Q?ZlLTj/ZEXrZjO4aHoIA6cbsn6WlmEG9y+8/w8wq8i7UmFMaUlA1wCRVT9xpQ?=
 =?us-ascii?Q?YRXtoSFmSS20XOtje66FbLGnzIL7ZNluCS+zfhQDXm9fV2AFCUY48wXv04Tq?=
 =?us-ascii?Q?P6RoF9EoPJ0gmr1563v7LgAc4UL99v5xeGwcSbqbBteX3S5K+DLXWQB/JRqu?=
 =?us-ascii?Q?yg4JagpZnRjPP3iziUG4KmclxM3ZwUoMRpjsi5oYrlZ85kjnhl4R8a9ojKrZ?=
 =?us-ascii?Q?MEsae2yWN2ypX9c0hz+dR1gFm8PFRSqKGrr0kUeKR4vUpThXBQu3XJsE0I0V?=
 =?us-ascii?Q?xWnxxTNOt5JrGqt8U4t0w/rr7QSfNs32jXD/6cPBDSvV8aqxbsUfzhOq/tLE?=
 =?us-ascii?Q?FeDRhLSmNrF5ggGtgvGaTEEETR8WZH/SwVxcnGYSZp5x9B8Hsquxx66uQ+0l?=
 =?us-ascii?Q?D0xtJqqhYJpxhvrvWPcD6fdwac0rsTifZy3P0Kb/+QQNwq37E8IAvBmGmxaR?=
 =?us-ascii?Q?AcfHToqN3fJAcjtpwlYm7wGrp0wUDbztAZOCZ/Rzc2cdOGqWfiXdvHULbE17?=
 =?us-ascii?Q?TJiB+WQmWJPX+x9SRJzN7O+D8D1J2uRoj6+L8ZMhFUfgyhiRsnA8D6FZZGzE?=
 =?us-ascii?Q?azzG9jaKGXJu2xbIB+Ey5prbYZgtieu8w7ajEXFMgDM+tw7Vt+krWaJRYMyW?=
 =?us-ascii?Q?dpFcvjs4jzwT3iq6QSaGfEvmgUsCC6vVzR2T+O4kw1duh+87wCowLX18g47g?=
 =?us-ascii?Q?tXdppNCyWJvnmnJGDE5395qOy7uUJVSG8SyZN54moSmgN6mrWhrLvuIB0fN3?=
 =?us-ascii?Q?S+Kj/J100u/tk84XIl2VgEa2DUOul1HWMXT6Z/CET2xXHhmgSYLB/s4ibmkS?=
 =?us-ascii?Q?5SG1Yr3cVdTUn37NKnunz2PgPMmVVyC7+Q8dKgMROlSyK26/SK/dC254z5D8?=
 =?us-ascii?Q?XW1V5uzBWA9f/FKSLYVu/d0A2BVc5g7tTEtRPM8GTJ9QnX1gRbUCbyn7UGHO?=
 =?us-ascii?Q?NOw6gI08M3UO1mb7Mrv9QKqIsHs6uxWDZZLhxef3a5Q5WofEtA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qbDggrDjYtkLTMFSdC1dBUB//iMSOYr0hfg47RdrOzv153zrnBv/nBUAL9Te?=
 =?us-ascii?Q?b1ytF37v+whe4V2iFC34QhPZdGawwh9cvGiSdumrTkCue4j51b4Pr8btBmmk?=
 =?us-ascii?Q?hhwrdQloCTdyTpnj51DPFajrUxa1h1t2CTYAHf6Uk/VAhBrzn+zk9A8frIXU?=
 =?us-ascii?Q?Y+VMUQ1DUGtYDFF/0cimWRM5vLR/0wNUWCWV2FegBeMcGfIguphVrJZBzSw/?=
 =?us-ascii?Q?CNrtiQEuTnbwNoaQfYbPRiztkU5Jl/ViWg3OTKgpQK7upkfqtN20xVfZ8nRB?=
 =?us-ascii?Q?z//QJ/fcLhrIhVyl9Ce4HARQMrg9AcFAHj2d4at1BXHF5FyvZBcC0a2gIGW0?=
 =?us-ascii?Q?gHiG8cXcXESH0CecnNlwScvbjM651aps4jAJdalxG836PjMdGnCCUodd5zX1?=
 =?us-ascii?Q?wa7Y+EzU94IqYn4Fbeo4QSeEt7X0btyR123aCl5bWr9uJJXDCfo6j3ChLHCZ?=
 =?us-ascii?Q?Wrm6RVsEZlhMTqPnXEdQhEEvVgc18dF9pa85Ep6Q+hioryxJ8vYLKdgmrOXo?=
 =?us-ascii?Q?zm4MNHaiwNO+TbGkrsKJ3kiEZSk2DAU9WMfa3mE95eaPEazWNxuHxFdEiavx?=
 =?us-ascii?Q?ft1rhkgnPfY5MdKRt3vrrffu4XUZrIbyLcb3EyS5V/iXfn3z/Rm7NitHqG7C?=
 =?us-ascii?Q?jcPiD5wx12Rh8LG10I02NGfsuqbnZkLc/IBrqNx205rNTL9/IPH9Oity30d4?=
 =?us-ascii?Q?6F25WAK5oWS9XndbVmMSjbykaXHOt3XjUo2fVsHtJLSIriV0UDyK2jWuv8kS?=
 =?us-ascii?Q?PlwoW4V05ZCmmry2YNhjcn+nNzyXer5OxaLwUXJm9MT4e+enaZkITTuQZ+iK?=
 =?us-ascii?Q?igN92jEkuS/BmdhW+QlCpIBUD6eWkvx1ATvKtHb9YwYLjdXVY23z0ALx70Tb?=
 =?us-ascii?Q?5yVgkOyMnUXBnRidb1yFpXysnaBk+vqLn+N0Osxf3NVJnqI9VXZ205sUb9Jd?=
 =?us-ascii?Q?Qh6tbeOZ8iJqX4ktHCQJyP3uHPdfCxmjMUO0zCAkjefV0WZyrjPiIiye/Pt3?=
 =?us-ascii?Q?RZmjvuGJZ6q0HC8QQKGUOkb/PvYFcwCd03GzQA0erGo33aqqik77jSHyJAO+?=
 =?us-ascii?Q?jwcq0Zzw4dDVad/s8LEpObiDKIg9wwDLZYWgZ7nvlk7bYk3XntgyfcpOzWAj?=
 =?us-ascii?Q?PyM1t5W+RnYg8/G0OrXwfRynRsgPbq2Fy3/tHMhhbwOwfmpqQx1EMlcIvwSr?=
 =?us-ascii?Q?DGNvNuBY2YmVik+7iMzBcZM39es//ug6iFKVG6J3lg12lFI3RjSbmscFaJwb?=
 =?us-ascii?Q?5popH0+x+z3ZSXJVcboHCQ/Fj6m+nulw/EQcPCGxlsTWvG6bINgTrIdaVdir?=
 =?us-ascii?Q?YybP/bGcuvc1CQHKhh1NWyw1y+VbFqOiJ6SLPR4LWJGTRxNP/WFfwTjJLOsf?=
 =?us-ascii?Q?nlVHRpiMP3jv0bTZF1GT77yDwk7pfNGuwXTFW1exTdc1QwvzhwXYzcaswzZW?=
 =?us-ascii?Q?bL4mz2NHg0RbPudL3HbINZ5cKxIX0pLrH7BYUpMF4lXRZ3Ul0ktHlKnv8qNr?=
 =?us-ascii?Q?bOzcwsYIB2ETxUZ8BUsZoX5vqgpMz4G5C2Jb6Sbk1vMRdCPhlbbcfVE9+WOf?=
 =?us-ascii?Q?vixAN4d9WzMkKJObv0I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bf5af9-8dde-48cb-ba2f-08dcce38e767
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 05:58:17.5209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHx0GbqgONtgw1DrhA/Nnc/hS+dPpw35cpXLk9oP+l3xmlyp4PO1u2/fWQXaCI3X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Thursday, September 5, 2024 3:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: update the features set on smu v14.0.2/3

update the features set on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h         | 11 ++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c |  9 +++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index 12a7b0634ed5..5b3e38eb26b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -439,7 +439,16 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(BACO_CG),                       \
        __SMU_DUMMY_MAP(SOC_CG),    \
        __SMU_DUMMY_MAP(LOW_POWER_DCNCLKS),       \
-       __SMU_DUMMY_MAP(WHISPER_MODE),
+       __SMU_DUMMY_MAP(WHISPER_MODE),                  \
+       __SMU_DUMMY_MAP(EDC_PWRBRK),                            \
+       __SMU_DUMMY_MAP(SOC_EDC_XVMIN),                         \
+       __SMU_DUMMY_MAP(GFX_PSM_DIDT),                          \
+       __SMU_DUMMY_MAP(APT_ALL_ENABLE),                                \
+       __SMU_DUMMY_MAP(APT_SQ_THROTTLE),                               \
+       __SMU_DUMMY_MAP(APT_PF_DCS),                            \
+       __SMU_DUMMY_MAP(GFX_EDC_XVMIN),                         \
+       __SMU_DUMMY_MAP(GFX_DIDT_XVMIN),                                \
+       __SMU_DUMMY_MAP(FAN_ABNORMAL),

 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(feature)       SMU_FEATURE_##feature##_BIT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index a31fae5feedf..7125f72d01f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -199,6 +199,15 @@ static struct cmn2asic_mapping smu_v14_0_2_feature_mas=
k_map[SMU_FEATURE_COUNT] =3D
        FEA_MAP(MEM_TEMP_READ),
        FEA_MAP(ATHUB_MMHUB_PG),
        FEA_MAP(SOC_PCC),
+       FEA_MAP(EDC_PWRBRK),
+       FEA_MAP(SOC_EDC_XVMIN),
+       FEA_MAP(GFX_PSM_DIDT),
+       FEA_MAP(APT_ALL_ENABLE),
+       FEA_MAP(APT_SQ_THROTTLE),
+       FEA_MAP(APT_PF_DCS),
+       FEA_MAP(GFX_EDC_XVMIN),
+       FEA_MAP(GFX_DIDT_XVMIN),
+       FEA_MAP(FAN_ABNORMAL),
        [SMU_FEATURE_DPM_VCLK_BIT] =3D {1, FEATURE_MM_DPM_BIT},
        [SMU_FEATURE_DPM_DCLK_BIT] =3D {1, FEATURE_MM_DPM_BIT},
        [SMU_FEATURE_PPT_BIT] =3D {1, FEATURE_THROTTLERS_BIT},
--
2.34.1


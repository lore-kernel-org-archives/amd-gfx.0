Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D97FD6DDEA
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 10:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46BC10E834;
	Fri, 15 Nov 2024 10:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RWDdwlLe";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F93810E834
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 10:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylqc9xo6NaqJFi+nazULUoQCsB/3NLtpW1tO0bUeAaTdQ+eeWIoc44Sd7peohuiAbYysCMzNtpBtT9ItppRIwD67Fhi1aiOU2KMa9tEv7XA3+IucvA1IqUMmOAwosW1O23ArP7BBhgNrfzzQkFitWh6FXL5Fqr3x926m76I6Vs+Wj1ckYdn4TIo87Vhyx+zQ0uSjtNgCup8j7cRBj0TdrEYNrgUcYEM++9XLUBhESfn6L20b2BXxlTbHOBB324U1zm5KgHqewA13aImwtPavBDoB2z8I3KsS5EiSETr+7FDjSBvAsGX3WVVxWv2RwmGj4ieGYGXkld2HFDG3wuvpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vd7Gr0AGBd1EkOeoNhT2wva4BXGVKmAizGqo/G12WwE=;
 b=ZSQ3amDdZ1La7avnFWhpLD5E9CBPcYyifqbNeHI4OcoTLzXjr5tUxTdA2hiPOQjXLribGjpOidkFZ+q7L5OtQR0/uyTruOJqpQ9m77VHoHhoMVO/TyLbjNrQvYeZbG+18KHKBx1XUCqUFEg1axUYIWW4cCqAT5KfB85J/DUUwadaivWdtuJnI7Tc9D4Qx3XtIaIeJTJN6SVSChPOWMTmIPsCRBxELCbqMaWy7+Y8WKQRpEWJFSo947wnjPskSpHxaFwjySuvSxWhwhD5PtcLHprmHvoZLaA7QnNhPMptMsGsObHNXiHLuGodwMlndettL3Aib8RlE/0h3FhI7s3GeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd7Gr0AGBd1EkOeoNhT2wva4BXGVKmAizGqo/G12WwE=;
 b=RWDdwlLeaIAQ+hCIEp+W3bBZ504SY7O/gyR9fgk02ECwxkqZyFeXLnLm7S4AEfq72H47zc5Ygd1Zg6QVIBRmahMOY+MfLhRd93PEgRKWgOFzErofUzA3ZlULM+KuhoAM96yLhGQTiFVUySYmCW6AO1cimv0od7w2JB4IpjZejow=
Received: from BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Fri, 15 Nov
 2024 10:09:32 +0000
Received: from BL1PR12MB5158.namprd12.prod.outlook.com
 ([fe80::b9ae:fa61:11ed:4e3b]) by BL1PR12MB5158.namprd12.prod.outlook.com
 ([fe80::b9ae:fa61:11ed:4e3b%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:09:32 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix and simplify workload handling
Thread-Topic: [PATCH] drm/amd/pm: fix and simplify workload handling
Thread-Index: AQHbNtkPeD4CxbLR0UKx/zMev1VImrK4Hjog
Date: Fri, 15 Nov 2024 10:09:32 +0000
Message-ID: <BL1PR12MB5158A25FF61728B884EDE9A38E242@BL1PR12MB5158.namprd12.prod.outlook.com>
References: <20241114210603.10448-1-alexander.deucher@amd.com>
In-Reply-To: <20241114210603.10448-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=95fea572-1e74-4d83-8628-1a0169d997eb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-15T10:05:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5158:EE_|IA0PR12MB8746:EE_
x-ms-office365-filtering-correlation-id: 7cf84e3d-aefc-462e-0770-08dd055d99c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mEw6dwgZEcmHagriZGcPQPHCFY0Ql5GCAPlynqfsg5UNK8XVmdQ4C6R/+biy?=
 =?us-ascii?Q?IZRox2XKtbOCEU//q/zLFZ9PUeYK7yU6FDtL7QlUX1VO7Z5XCE/LKv7ksiUF?=
 =?us-ascii?Q?b1fKC94pAFqgdChrqNcB5IzlycHBAx+fEXCY8spEfEwzwyep6+KrkR+Exzok?=
 =?us-ascii?Q?Babzw9ak9NJ67ON294zixcKBEm3c2hVMjlOI+BOEq2wraP3RBpqP2ephjIdS?=
 =?us-ascii?Q?qZsVK5N5RTwefzWBG2irs7wS7V4vvO/4Ct49KzV89a627aKFJPYmdcMcQunI?=
 =?us-ascii?Q?hyGHAPmqZWUErq/BAezakfZPp8k5+5PWuBcQ7RoRQe0S/4cIpP8sTLbnfzwM?=
 =?us-ascii?Q?9giDpdLBPwkP7maNpc5Al8gxysGrPIeRDtqOqrE9WPcl/Z0Vr1vNJcOopeeQ?=
 =?us-ascii?Q?70s6moLHFSMiMpZzzAg0fSHXmvYuqyv9IqlW0WkrwsAdBY2b90UTmWpkgIn/?=
 =?us-ascii?Q?TY04qe8rpcIvfEdFCsxABTZ+Dzzd8YXIubs6wcb8TbEyqW/kHwvXHkJffCaH?=
 =?us-ascii?Q?MT9WgvU+PcU1vW9L+kOZAJfGzPls5NaLFhm34bci69OZbCHZp2XVcjA1JOrN?=
 =?us-ascii?Q?G1WUiw+xl0he61t8ZondA8ScJHUZva1l4YhkQZEBFCZX4+A2OAII47ayLIBY?=
 =?us-ascii?Q?aCVxTv7fuGAkrofBnTQqTzmx7iSBYNP1elkAxEa7ehUTAAxAT0Y5b/D6ZjEQ?=
 =?us-ascii?Q?nSiKDev3bKqmqAP6j2ARahnfzg8U07+BmgsJugks+g5vivmRQd+FH/lAmGOj?=
 =?us-ascii?Q?0rrFmU2acp7tL7BrcjjXLKcK7An8z/Kk+Hw8xHyBIVjCvFV+R1CAg9Wc0Mwh?=
 =?us-ascii?Q?Tnm+OSrCyWpzCk3mgPMc8QKQf3LfJOmTjAbLBUGkcpUT9/bLUvSlC/6e33rj?=
 =?us-ascii?Q?/gnnGjoO9JIMCy8vjXslXrLAr67f04Nfd+hBq5Os1GCB0/T9G0wsY283cwUy?=
 =?us-ascii?Q?MnRTtP30RghQ779pvtl/Zs0K+fi6GR+bf4eQ4nbC1V/Xlb9yv/laEfl/La01?=
 =?us-ascii?Q?AwLoAgdw1HsJXvYSPy2p1x1TNd0ln91MHRXqFVSxoDUP59fESXsoPIG92n8I?=
 =?us-ascii?Q?i89/GAGLDSayPURUS5HISuHU6JCSZQ2VtqPT5qqY4DR0qkOZV9LGpsurAZW8?=
 =?us-ascii?Q?A7UlA3ZXq2b0ukerEbhz2wRlw7KLH8TJIF81XRzLx3Wgs3W7UK52+Bz1sDz8?=
 =?us-ascii?Q?8+5DqNtHemcLSWnNz3vlTKRjA2Dan0gva0Gkx1VH8vK18h2BB8I6tYRHms+B?=
 =?us-ascii?Q?O2DFUJfiR+WxzNWfmz+itpBml98p0Tw9mNS2kyu4oqziCWLUBPxYtdFFWpS6?=
 =?us-ascii?Q?65NlSlAaKmUOfFLHC+KIXlwpBiQe1CRHLQBAg6/3Zz2LabICmYYDs+7+xLUR?=
 =?us-ascii?Q?UG4BymI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JCSy7A5nIJ04pccQCg0suJhUzUYZ0zcmDwi/73DmWS5HGBEG5A4LWuPy5olw?=
 =?us-ascii?Q?OM6FPofEr32OAYnBeu8IHNpXDSEGs20wJDlfsNB3J9N2c7ZumNZYXlypRHDJ?=
 =?us-ascii?Q?KvqlaEB18zXbf9z1peAUtbhzohW/EBg4rcEOGtJkWcUB3YghgRkaK5ImQtvv?=
 =?us-ascii?Q?pzerXYRaezLwM8wvamWYfpIuLN3K9YmoJikgkf7m57pm1Vc/MJYxQ8h2RLb+?=
 =?us-ascii?Q?kBDfeuJX/6XYh/9BjMMpX9CI09NwoZOHdkwpZWsUv7ooiOgJp3uZ5bMYiQMK?=
 =?us-ascii?Q?U466v3Yz8QdD6gwVKKRW8zRHX4Ts1Z/SI+n2iToKAyqTLbR5CdvR1k2P8pL3?=
 =?us-ascii?Q?+MVGanf6xnydKeEKCGO8ocJcjLV/RoLB7klf6vO+XYjZPeTK0NZhy9Aua385?=
 =?us-ascii?Q?BPgTHPgm87Rx0mV215SgMlVhor+UusutINFeBMuhj/cHybN6kN1BgRDLgDDr?=
 =?us-ascii?Q?QJm6WDxuDPX2xh74DxfY0hRVtIVtp/roRShQTosDMnQcyJWDgk/ZQ87SOHAs?=
 =?us-ascii?Q?VSnL3lkh971v4tJvLuI3Qc3lZJZCAiRxHDEtQnmfWLsqQi+iEzpCk7QkaNC5?=
 =?us-ascii?Q?G/K++JrDnt7LgvQTodNjc6qad3HiHeQGrcsILtFMpF3Q3BPmHuHir20hTD/A?=
 =?us-ascii?Q?2hV71ozsTqofa2kz3RDk7qiIn3tWYnuaMUkk02ZiQAj0zKEfcFvwytEpNy7D?=
 =?us-ascii?Q?y8G7nZhWQkJ7vCFMSNONYj3f+GG26YnxC8ftH0hTRsoFYeIwv9OjAWMxknyM?=
 =?us-ascii?Q?Hcy1B9bOtu+YHILzHRaI3HenkZBxShmLgINC5To+U1vnQQVQSRinaWqM2vFc?=
 =?us-ascii?Q?akgIBe5FVtyWHc3iRaTnpIs7NoAUTq//AuwfXCDEmSmElmpotBToc2JKr5Nq?=
 =?us-ascii?Q?nLHLnPoYOXEjVsUIRpreKsk6HNrmiuCCkJtVpPU5GXBnUZlaeMyVWqbuWq2x?=
 =?us-ascii?Q?wzRUOC9iRv/fAuZ/QWNiycGebHYLXXbyciqW+Ifxpy6j9VWs1HFNzRVAavTb?=
 =?us-ascii?Q?+JaH8GnT6DT83iYZY124S7oJ8tvnf8pr69r2dHp+XB0+75BozS31PWREGYhp?=
 =?us-ascii?Q?ij9XX/SXYiG5gLij3ZMa2xTa1JsghhSnXsKAcVWiLvb1CC4LRuQv8jjION62?=
 =?us-ascii?Q?OL6Lv4zvZzAXADMVIi2C9dtGMIhZ6Nsm2NwoUWk0Cia69AbDxLTx0I95qcJr?=
 =?us-ascii?Q?8g1u3aZtSkWf2TMFe7uSKTLqTwLJPnzx9YDoO/2iBRzcalw7lTGNnNJubH9g?=
 =?us-ascii?Q?77ajy8mpKBajaa7yHeOFrrH9ZwsSj6+znjGAmG61AllR1sYJA3ai0AcIQCrc?=
 =?us-ascii?Q?CA8G1HUA0a1nrpDHthM9QGzCGl8EBiskat8aQlXNMkXBqPCGfM2NWIad4xJk?=
 =?us-ascii?Q?kntZoptVe7aKmZhxIi/i7x04gBtpHpfhXvsvJtnrChiOS8QpLsUAA8hIp+YA?=
 =?us-ascii?Q?wWcbjytvuuSLsbvfxaWGy6lbtyJygXYZfs1bNUsYTEKzWif2ewtGS7cJxAyH?=
 =?us-ascii?Q?NxYy0qWldmi1sZX3EPGDzVlG8pwmrLwy5P7xHvQ1wUXbEOZRu3Z1bb7kbQS0?=
 =?us-ascii?Q?W4QrcgsQ77Cgplk4Zdk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf84e3d-aefc-462e-0770-08dd055d99c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 10:09:32.6339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8y5bNZe7eTws7+Y7bSwBFtksPjJXbnLv9bReQ5sqRqbOYnwe/26RaKenpgN7V8i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746
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

Reviewed-by: Kenneth Feng kenneth.feng@amd.com


-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, November 15, 2024 5:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd/pm: fix and simplify workload handling

smu->workload_mask is IP specific and should not be messed with in
the common code. The mask bits vary across SMU versions.

Move all handling of smu->workload_mask in to the backends and
simplify the code.  Store the user's preference in smu->power_profile_mode
which will be reflected in sysfs.  For internal driver profile
switches for KFD or VCN, just update the workload mask so that the
user's preference is retained.  Remove all of the extra now unused
workload related elements in the smu structure.

v2: use refcounts for workload profiles
v3: rework based on feedback from Lijo

Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 165 +++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  21 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 147 ++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 151 ++++++++--------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 150 ++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  41 ++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  43 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 153 ++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 120 +++++++------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 141 ++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  38 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   7 +-
 12 files changed, 614 insertions(+), 563 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index c3a6b6f20455..ab6b30a9df1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint32_t li=
mit);
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
+static void smu_power_profile_mode_get(struct smu_context *smu,
+                                      enum PP_SMC_POWER_PROFILE profile_mo=
de);
+static void smu_power_profile_mode_put(struct smu_context *smu,
+                                      enum PP_SMC_POWER_PROFILE profile_mo=
de);

 static int smu_sys_get_pp_feature_mask(void *handle,
                                       char *buf)
@@ -1268,9 +1272,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_blo=
ck)
        INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
        atomic64_set(&smu->throttle_int_counter, 0);
        smu->watermarks_bitmap =3D 0;
-       smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-       smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEF=
AULT;
-       smu->user_dpm_profile.user_workload_mask =3D 0;

        for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
                atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
@@ -1278,33 +1279,13 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_b=
lock)
        atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
        atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);

-       smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 1;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] =3D 3;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_VR] =3D 4;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
-       smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
-
        if (smu->is_apu ||
-           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D)) {
-               smu->driver_workload_mask =3D
-                       1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BO=
OTUP_DEFAULT];
-       } else {
-               smu->driver_workload_mask =3D
-                       1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D];
-               smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D;
-       }
-
-       smu->workload_mask =3D smu->driver_workload_mask |
-                                                       smu->user_dpm_profi=
le.user_workload_mask;
-       smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-       smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-       smu->workload_setting[2] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
-       smu->workload_setting[3] =3D PP_SMC_POWER_PROFILE_VIDEO;
-       smu->workload_setting[4] =3D PP_SMC_POWER_PROFILE_VR;
-       smu->workload_setting[5] =3D PP_SMC_POWER_PROFILE_COMPUTE;
-       smu->workload_setting[6] =3D PP_SMC_POWER_PROFILE_CUSTOM;
+           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D))
+               smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEF=
AULT;
+       else
+               smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN=
3D;
+       smu_power_profile_mode_get(smu, smu->power_profile_mode);
+
        smu->display_config =3D &adev->pm.pm_display_cfg;

        smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
@@ -2140,6 +2121,9 @@ static int smu_suspend(struct amdgpu_ip_block *ip_blo=
ck)
        if (!ret)
                adev->gfx.gfx_off_entrycount =3D count;

+       /* clear this on suspend so it will get reprogrammed on resume */
+       smu->frontend_workload_mask =3D 0;
+
        return 0;
 }

@@ -2251,26 +2235,46 @@ static int smu_enable_umd_pstate(void *handle,
        return 0;
 }

-static int smu_bump_power_profile_mode(struct smu_context *smu,
-                                          long *param,
-                                          uint32_t param_size)
+static int smu_bump_power_profile_mode(struct smu_context *smu)
 {
-       int ret =3D 0;
+       u32 workload_mask =3D 0;
+       int i, ret =3D 0;
+
+       for (i =3D 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
+               if (smu->workload_refcount[i])
+                       workload_mask |=3D 1 << i;
+       }
+
+       if (smu->frontend_workload_mask =3D=3D workload_mask)
+               return 0;

        if (smu->ppt_funcs->set_power_profile_mode)
-               ret =3D smu->ppt_funcs->set_power_profile_mode(smu, param, =
param_size);
+               ret =3D smu->ppt_funcs->set_power_profile_mode(smu, workloa=
d_mask);
+
+       if (!ret)
+               smu->frontend_workload_mask =3D workload_mask;

        return ret;
 }

+static void smu_power_profile_mode_get(struct smu_context *smu,
+                                      enum PP_SMC_POWER_PROFILE profile_mo=
de)
+{
+       smu->workload_refcount[profile_mode]++;
+}
+
+static void smu_power_profile_mode_put(struct smu_context *smu,
+                                      enum PP_SMC_POWER_PROFILE profile_mo=
de)
+{
+       if (smu->workload_refcount[profile_mode])
+               smu->workload_refcount[profile_mode]--;
+}
+
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
                                          enum amd_dpm_forced_level level,
-                                         bool skip_display_settings,
-                                         bool init)
+                                         bool skip_display_settings)
 {
        int ret =3D 0;
-       int index =3D 0;
-       long workload[1];
        struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);

        if (!skip_display_settings) {
@@ -2307,14 +2311,8 @@ static int smu_adjust_power_state_dynamic(struct smu=
_context *smu,
        }

        if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
-               smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETER=
MINISM) {
-               index =3D fls(smu->workload_mask);
-               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? ind=
ex - 1 : 0;
-               workload[0] =3D smu->workload_setting[index];
-
-               if (init || smu->power_profile_mode !=3D workload[0])
-                       smu_bump_power_profile_mode(smu, workload, 0);
-       }
+           smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINI=
SM)
+               smu_bump_power_profile_mode(smu);

        return ret;
 }
@@ -2333,13 +2331,13 @@ static int smu_handle_task(struct smu_context *smu,
                ret =3D smu_pre_display_config_changed(smu);
                if (ret)
                        return ret;
-               ret =3D smu_adjust_power_state_dynamic(smu, level, false, f=
alse);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, false);
                break;
        case AMD_PP_TASK_COMPLETE_INIT:
-               ret =3D smu_adjust_power_state_dynamic(smu, level, true, tr=
ue);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, true);
                break;
        case AMD_PP_TASK_READJUST_POWER_STATE:
-               ret =3D smu_adjust_power_state_dynamic(smu, level, true, fa=
lse);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, true);
                break;
        default:
                break;
@@ -2361,12 +2359,10 @@ static int smu_handle_dpm_task(void *handle,

 static int smu_switch_power_profile(void *handle,
                                    enum PP_SMC_POWER_PROFILE type,
-                                   bool en)
+                                   bool enable)
 {
        struct smu_context *smu =3D handle;
        struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
-       long workload[1];
-       uint32_t index;

        if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
                return -EOPNOTSUPP;
@@ -2374,24 +2370,14 @@ static int smu_switch_power_profile(void *handle,
        if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
                return -EINVAL;

-       if (!en) {
-               smu->driver_workload_mask &=3D ~(1 << smu->workload_priorit=
y[type]);
-               index =3D fls(smu->workload_mask);
-               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? ind=
ex - 1 : 0;
-               workload[0] =3D smu->workload_setting[index];
-       } else {
-               smu->driver_workload_mask |=3D (1 << smu->workload_priority=
[type]);
-               index =3D fls(smu->workload_mask);
-               index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;
-               workload[0] =3D smu->workload_setting[index];
-       }
-
-       smu->workload_mask =3D smu->driver_workload_mask |
-                                                smu->user_dpm_profile.user=
_workload_mask;
-
        if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
-               smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETER=
MINISM)
-               smu_bump_power_profile_mode(smu, workload, 0);
+           smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINI=
SM) {
+               if (enable)
+                       smu_power_profile_mode_get(smu, type);
+               else
+                       smu_power_profile_mode_put(smu, type);
+               smu_bump_power_profile_mode(smu);
+       }

        return 0;
 }
@@ -3090,21 +3076,44 @@ static int smu_set_power_profile_mode(void *handle,
                                      uint32_t param_size)
 {
        struct smu_context *smu =3D handle;
-       int ret;
+       bool custom_changed =3D false;
+       int ret =3D 0, i;

        if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
            !smu->ppt_funcs->set_power_profile_mode)
                return -EOPNOTSUPP;

-       if (smu->user_dpm_profile.user_workload_mask &
-          (1 << smu->workload_priority[param[param_size]]))
-          return 0;
+       if (param[param_size] =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
+               if (param_size > SMU_BACKEND_MAX_CUSTOM_PARAMETERS)
+                       return -EINVAL;
+               /* param_size is actually a max index, not an array size */
+               for (i =3D 0; i <=3D param_size; i++) {
+                       if (smu->custom_profile_input[i] !=3D param[i]) {
+                               custom_changed =3D true;
+                               break;
+                       }
+               }
+       }

-       smu->user_dpm_profile.user_workload_mask =3D
-               (1 << smu->workload_priority[param[param_size]]);
-       smu->workload_mask =3D smu->user_dpm_profile.user_workload_mask |
-               smu->driver_workload_mask;
-       ret =3D smu_bump_power_profile_mode(smu, param, param_size);
+       if ((param[param_size] !=3D smu->power_profile_mode) || custom_chan=
ged) {
+               /* save the parameters for custom */
+               if (custom_changed) {
+                       /* param_size is actually a max index, not an array=
 size */
+                       for (i =3D 0; i <=3D param_size; i++)
+                               smu->custom_profile_input[i] =3D param[i];
+                       smu->custom_profile_size =3D param_size;
+                       /* clear frontend mask so custom changes propogate =
*/
+                       smu->frontend_workload_mask =3D 0;
+               }
+               /* clear the old user preference */
+               smu_power_profile_mode_put(smu, smu->power_profile_mode);
+               /* set the new user preference */
+               smu_power_profile_mode_get(smu, param[param_size]);
+               ret =3D smu_bump_power_profile_mode(smu);
+               if (!ret)
+                       /* store the user's preference */
+                       smu->power_profile_mode =3D param[param_size];
+       }

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index fa93a8879113..a9b88072bd05 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
        /* user clock state information */
        uint32_t clk_mask[SMU_CLK_COUNT];
        uint32_t clk_dependency;
-       uint32_t user_workload_mask;
 };

 #define SMU_TABLE_INIT(tables, table_id, s, a, d)      \
@@ -510,6 +509,8 @@ enum smu_fw_status {
  */
 #define SMU_WBRF_EVENT_HANDLING_PACE   10

+#define SMU_BACKEND_MAX_CUSTOM_PARAMETERS      11
+
 struct smu_context {
        struct amdgpu_device            *adev;
        struct amdgpu_irq_src           irq_source;
@@ -557,12 +558,16 @@ struct smu_context {
        uint32_t hard_min_uclk_req_from_dal;
        bool disable_uclk_switch;

-       uint32_t workload_mask;
-       uint32_t driver_workload_mask;
-       uint32_t workload_priority[WORKLOAD_POLICY_MAX];
-       uint32_t workload_setting[WORKLOAD_POLICY_MAX];
+       /* asic agnostic workload mask */
+       uint32_t frontend_workload_mask;
+       /* asic specific workload mask */
+       uint32_t backend_workload_mask;
+       /* default/user workload preference */
        uint32_t power_profile_mode;
-       uint32_t default_power_profile_mode;
+       uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
+       /* backend specific custom workload settings */
+       long custom_profile_input[SMU_BACKEND_MAX_CUSTOM_PARAMETERS];
+       bool custom_profile_size;
        bool pm_enabled;
        bool is_apu;

@@ -733,9 +738,9 @@ struct pptable_funcs {
         * @set_power_profile_mode: Set a power profile mode. Also used to
         *                          create/set custom power profile modes.
         * &input: Power profile mode parameters.
-        * &size: Size of &input.
+        * &workload_mask: mask of workloads to enable
         */
-       int (*set_power_profile_mode)(struct smu_context *smu, long *input,=
 uint32_t size);
+       int (*set_power_profile_mode)(struct smu_context *smu, u32 workload=
_mask);

        /**
         * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4b36c230e43a..64605cd932ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1441,97 +1441,98 @@ static int arcturus_get_power_profile_mode(struct s=
mu_context *smu,
        return size;
 }

-static int arcturus_set_power_profile_mode(struct smu_context *smu,
-                                          long *input,
-                                          uint32_t size)
+static int arcturus_set_power_profile_mode_coeff(struct smu_context *smu,
+                                                long *input,
+                                                uint32_t size)
 {
        DpmActivityMonitorCoeffInt_t activity_monitor;
-       int workload_type =3D 0;
-       uint32_t profile_mode =3D input[size];
-       int ret =3D 0;
+       int ret;

-       if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
profile_mode);
+       if (size !=3D 10)
                return -EINVAL;
+
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+                                  WORKLOAD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor),
+                                  false);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to get activity monito=
r!", __func__);
+               return ret;
        }

-       if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
-            (smu->smc_fw_version >=3D 0x360d00)) {
-               if (size !=3D 10)
-                       return -EINVAL;
+       switch (input[0]) {
+       case 0: /* Gfxclk */
+               activity_monitor.Gfx_FPS =3D input[1];
+               activity_monitor.Gfx_UseRlcBusy =3D input[2];
+               activity_monitor.Gfx_MinActiveFreqType =3D input[3];
+               activity_monitor.Gfx_MinActiveFreq =3D input[4];
+               activity_monitor.Gfx_BoosterFreqType =3D input[5];
+               activity_monitor.Gfx_BoosterFreq =3D input[6];
+               activity_monitor.Gfx_PD_Data_limit_c =3D input[7];
+               activity_monitor.Gfx_PD_Data_error_coeff =3D input[8];
+               activity_monitor.Gfx_PD_Data_error_rate_coeff =3D input[9];
+               break;
+       case 1: /* Uclk */
+               activity_monitor.Mem_FPS =3D input[1];
+               activity_monitor.Mem_UseRlcBusy =3D input[2];
+               activity_monitor.Mem_MinActiveFreqType =3D input[3];
+               activity_monitor.Mem_MinActiveFreq =3D input[4];
+               activity_monitor.Mem_BoosterFreqType =3D input[5];
+               activity_monitor.Mem_BoosterFreq =3D input[6];
+               activity_monitor.Mem_PD_Data_limit_c =3D input[7];
+               activity_monitor.Mem_PD_Data_error_coeff =3D input[8];
+               activity_monitor.Mem_PD_Data_error_rate_coeff =3D input[9];
+               break;
+       default:
+               return -EINVAL;
+       }

-               ret =3D smu_cmn_update_table(smu,
-                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-                                      WORKLOAD_PPLIB_CUSTOM_BIT,
-                                      (void *)(&activity_monitor),
-                                      false);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to get activit=
y monitor!", __func__);
-                       return ret;
-               }
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+                                  WORKLOAD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor),
+                                  true);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to set activity monito=
r!", __func__);
+               return ret;
+       }

-               switch (input[0]) {
-               case 0: /* Gfxclk */
-                       activity_monitor.Gfx_FPS =3D input[1];
-                       activity_monitor.Gfx_UseRlcBusy =3D input[2];
-                       activity_monitor.Gfx_MinActiveFreqType =3D input[3]=
;
-                       activity_monitor.Gfx_MinActiveFreq =3D input[4];
-                       activity_monitor.Gfx_BoosterFreqType =3D input[5];
-                       activity_monitor.Gfx_BoosterFreq =3D input[6];
-                       activity_monitor.Gfx_PD_Data_limit_c =3D input[7];
-                       activity_monitor.Gfx_PD_Data_error_coeff =3D input[=
8];
-                       activity_monitor.Gfx_PD_Data_error_rate_coeff =3D i=
nput[9];
-                       break;
-               case 1: /* Uclk */
-                       activity_monitor.Mem_FPS =3D input[1];
-                       activity_monitor.Mem_UseRlcBusy =3D input[2];
-                       activity_monitor.Mem_MinActiveFreqType =3D input[3]=
;
-                       activity_monitor.Mem_MinActiveFreq =3D input[4];
-                       activity_monitor.Mem_BoosterFreqType =3D input[5];
-                       activity_monitor.Mem_BoosterFreq =3D input[6];
-                       activity_monitor.Mem_PD_Data_limit_c =3D input[7];
-                       activity_monitor.Mem_PD_Data_error_coeff =3D input[=
8];
-                       activity_monitor.Mem_PD_Data_error_rate_coeff =3D i=
nput[9];
-                       break;
-               default:
-                       return -EINVAL;
-               }
+       return ret;
+}

-               ret =3D smu_cmn_update_table(smu,
-                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-                                      WORKLOAD_PPLIB_CUSTOM_BIT,
-                                      (void *)(&activity_monitor),
-                                      true);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to set activit=
y monitor!", __func__);
-                       return ret;
-               }
-       }
+static int arcturus_set_power_profile_mode(struct smu_context *smu,
+                                          u32 workload_mask)
+{
+       u32 backend_workload_mask =3D 0;
+       bool custom_enabled =3D false;
+       int ret;

-       /*
-        * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
-        * Not all profile modes are supported on arcturus.
-        */
-       workload_type =3D smu_cmn_to_asic_specific_index(smu,
-                                                      CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      profile_mode);
-       if (workload_type < 0) {
-               dev_dbg(smu->adev->dev, "Unsupported power profile mode %d =
on arcturus\n", profile_mode);
-               return -EINVAL;
+       smu_cmn_get_backend_workload_mask(smu, workload_mask,
+                                         &backend_workload_mask,
+                                         &custom_enabled);
+
+       if (custom_enabled) {
+               ret =3D arcturus_set_power_profile_mode_coeff(smu,
+                                                           smu->custom_pro=
file_input,
+                                                           smu->custom_pro=
file_size);
+               if (ret)
+                       return ret;
        }

        ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                                         SMU_MSG_SetWorkloadMask,
-                                         smu->workload_mask,
-                                         NULL);
+                                             SMU_MSG_SetWorkloadMask,
+                                             backend_workload_mask,
+                                             NULL);
        if (ret) {
-               dev_err(smu->adev->dev, "Fail to set workload type %d\n", w=
orkload_type);
+               dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x=
\n",
+                       workload_mask);
                return ret;
        }

-       smu_cmn_assign_power_profile(smu);
+       smu->backend_workload_mask =3D backend_workload_mask;

-       return 0;
+       return ret;
 }

 static int arcturus_set_performance_level(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 211635dabed8..8ed446b3458c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2006,90 +2006,101 @@ static int navi10_get_power_profile_mode(struct sm=
u_context *smu, char *buf)
        return size;
 }

-static int navi10_set_power_profile_mode(struct smu_context *smu, long *in=
put, uint32_t size)
+static int navi10_set_power_profile_mode_coeff(struct smu_context *smu,
+                                              long *input,
+                                              uint32_t size)
 {
        DpmActivityMonitorCoeffInt_t activity_monitor;
-       int workload_type, ret =3D 0;
+       int ret;
+
+       if (size !=3D 10)
+               return -EINVAL;

-       smu->power_profile_mode =3D input[size];
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLO=
AD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor), false);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to get activity monito=
r!", __func__);
+               return ret;
+       }

-       if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
smu->power_profile_mode);
+       switch (input[0]) {
+       case 0: /* Gfxclk */
+               activity_monitor.Gfx_FPS =3D input[1];
+               activity_monitor.Gfx_MinFreqStep =3D input[2];
+               activity_monitor.Gfx_MinActiveFreqType =3D input[3];
+               activity_monitor.Gfx_MinActiveFreq =3D input[4];
+               activity_monitor.Gfx_BoosterFreqType =3D input[5];
+               activity_monitor.Gfx_BoosterFreq =3D input[6];
+               activity_monitor.Gfx_PD_Data_limit_c =3D input[7];
+               activity_monitor.Gfx_PD_Data_error_coeff =3D input[8];
+               activity_monitor.Gfx_PD_Data_error_rate_coeff =3D input[9];
+               break;
+       case 1: /* Socclk */
+               activity_monitor.Soc_FPS =3D input[1];
+               activity_monitor.Soc_MinFreqStep =3D input[2];
+               activity_monitor.Soc_MinActiveFreqType =3D input[3];
+               activity_monitor.Soc_MinActiveFreq =3D input[4];
+               activity_monitor.Soc_BoosterFreqType =3D input[5];
+               activity_monitor.Soc_BoosterFreq =3D input[6];
+               activity_monitor.Soc_PD_Data_limit_c =3D input[7];
+               activity_monitor.Soc_PD_Data_error_coeff =3D input[8];
+               activity_monitor.Soc_PD_Data_error_rate_coeff =3D input[9];
+               break;
+       case 2: /* Memclk */
+               activity_monitor.Mem_FPS =3D input[1];
+               activity_monitor.Mem_MinFreqStep =3D input[2];
+               activity_monitor.Mem_MinActiveFreqType =3D input[3];
+               activity_monitor.Mem_MinActiveFreq =3D input[4];
+               activity_monitor.Mem_BoosterFreqType =3D input[5];
+               activity_monitor.Mem_BoosterFreq =3D input[6];
+               activity_monitor.Mem_PD_Data_limit_c =3D input[7];
+               activity_monitor.Mem_PD_Data_error_coeff =3D input[8];
+               activity_monitor.Mem_PD_Data_error_rate_coeff =3D input[9];
+               break;
+       default:
                return -EINVAL;
        }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
-               if (size !=3D 10)
-                       return -EINVAL;
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLO=
AD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor), true);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to set activity monito=
r!", __func__);
+               return ret;
+       }

-               ret =3D smu_cmn_update_table(smu,
-                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
-                                      (void *)(&activity_monitor), false);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to get activit=
y monitor!", __func__);
-                       return ret;
-               }
+       return ret;
+}

-               switch (input[0]) {
-               case 0: /* Gfxclk */
-                       activity_monitor.Gfx_FPS =3D input[1];
-                       activity_monitor.Gfx_MinFreqStep =3D input[2];
-                       activity_monitor.Gfx_MinActiveFreqType =3D input[3]=
;
-                       activity_monitor.Gfx_MinActiveFreq =3D input[4];
-                       activity_monitor.Gfx_BoosterFreqType =3D input[5];
-                       activity_monitor.Gfx_BoosterFreq =3D input[6];
-                       activity_monitor.Gfx_PD_Data_limit_c =3D input[7];
-                       activity_monitor.Gfx_PD_Data_error_coeff =3D input[=
8];
-                       activity_monitor.Gfx_PD_Data_error_rate_coeff =3D i=
nput[9];
-                       break;
-               case 1: /* Socclk */
-                       activity_monitor.Soc_FPS =3D input[1];
-                       activity_monitor.Soc_MinFreqStep =3D input[2];
-                       activity_monitor.Soc_MinActiveFreqType =3D input[3]=
;
-                       activity_monitor.Soc_MinActiveFreq =3D input[4];
-                       activity_monitor.Soc_BoosterFreqType =3D input[5];
-                       activity_monitor.Soc_BoosterFreq =3D input[6];
-                       activity_monitor.Soc_PD_Data_limit_c =3D input[7];
-                       activity_monitor.Soc_PD_Data_error_coeff =3D input[=
8];
-                       activity_monitor.Soc_PD_Data_error_rate_coeff =3D i=
nput[9];
-                       break;
-               case 2: /* Memclk */
-                       activity_monitor.Mem_FPS =3D input[1];
-                       activity_monitor.Mem_MinFreqStep =3D input[2];
-                       activity_monitor.Mem_MinActiveFreqType =3D input[3]=
;
-                       activity_monitor.Mem_MinActiveFreq =3D input[4];
-                       activity_monitor.Mem_BoosterFreqType =3D input[5];
-                       activity_monitor.Mem_BoosterFreq =3D input[6];
-                       activity_monitor.Mem_PD_Data_limit_c =3D input[7];
-                       activity_monitor.Mem_PD_Data_error_coeff =3D input[=
8];
-                       activity_monitor.Mem_PD_Data_error_rate_coeff =3D i=
nput[9];
-                       break;
-               default:
-                       return -EINVAL;
-               }
+static int navi10_set_power_profile_mode(struct smu_context *smu,
+                                        u32 workload_mask)
+{
+       u32 backend_workload_mask =3D 0;
+       bool custom_enabled =3D false;
+       int ret;

-               ret =3D smu_cmn_update_table(smu,
-                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
-                                      (void *)(&activity_monitor), true);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to set activit=
y monitor!", __func__);
+       smu_cmn_get_backend_workload_mask(smu, workload_mask,
+                                         &backend_workload_mask,
+                                         &custom_enabled);
+
+       if (custom_enabled) {
+               ret =3D navi10_set_power_profile_mode_coeff(smu,
+                                                         smu->custom_profi=
le_input,
+                                                         smu->custom_profi=
le_size);
+               if (ret)
                        return ret;
-               }
        }

-       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-       workload_type =3D smu_cmn_to_asic_specific_index(smu,
-                                                      CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      smu->power_profile_m=
ode);
-       if (workload_type < 0)
-               return -EINVAL;
-
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMas=
k,
-                                   smu->workload_mask, NULL);
-       if (ret)
-               dev_err(smu->adev->dev, "[%s] Failed to set work load mask!=
", __func__);
-       else
-               smu_cmn_assign_power_profile(smu);
+                                             backend_workload_mask, NULL);
+       if (ret) {
+               dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x=
\n",
+                       workload_mask);
+               return ret;
+       }
+
+       smu->backend_workload_mask =3D backend_workload_mask;

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 844532a9b641..bea11bbe859c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1704,93 +1704,103 @@ static int sienna_cichlid_get_power_profile_mode(s=
truct smu_context *smu, char *
        return size;
 }

-static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, =
long *input, uint32_t size)
+static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_context =
*smu,
+                                                      long *input, uint32_=
t size)
 {

        DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
        DpmActivityMonitorCoeffInt_t *activity_monitor =3D
                &(activity_monitor_external.DpmActivityMonitorCoeffInt);
-       int workload_type, ret =3D 0;
+       int ret;
+
+       if (size !=3D 10)
+               return -EINVAL;

-       smu->power_profile_mode =3D input[size];
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLO=
AD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor_external), fa=
lse);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to get activity monito=
r!", __func__);
+               return ret;
+       }

-       if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
smu->power_profile_mode);
+       switch (input[0]) {
+       case 0: /* Gfxclk */
+               activity_monitor->Gfx_FPS =3D input[1];
+               activity_monitor->Gfx_MinFreqStep =3D input[2];
+               activity_monitor->Gfx_MinActiveFreqType =3D input[3];
+               activity_monitor->Gfx_MinActiveFreq =3D input[4];
+               activity_monitor->Gfx_BoosterFreqType =3D input[5];
+               activity_monitor->Gfx_BoosterFreq =3D input[6];
+               activity_monitor->Gfx_PD_Data_limit_c =3D input[7];
+               activity_monitor->Gfx_PD_Data_error_coeff =3D input[8];
+               activity_monitor->Gfx_PD_Data_error_rate_coeff =3D input[9]=
;
+               break;
+       case 1: /* Socclk */
+               activity_monitor->Fclk_FPS =3D input[1];
+               activity_monitor->Fclk_MinFreqStep =3D input[2];
+               activity_monitor->Fclk_MinActiveFreqType =3D input[3];
+               activity_monitor->Fclk_MinActiveFreq =3D input[4];
+               activity_monitor->Fclk_BoosterFreqType =3D input[5];
+               activity_monitor->Fclk_BoosterFreq =3D input[6];
+               activity_monitor->Fclk_PD_Data_limit_c =3D input[7];
+               activity_monitor->Fclk_PD_Data_error_coeff =3D input[8];
+               activity_monitor->Fclk_PD_Data_error_rate_coeff =3D input[9=
];
+               break;
+       case 2: /* Memclk */
+               activity_monitor->Mem_FPS =3D input[1];
+               activity_monitor->Mem_MinFreqStep =3D input[2];
+               activity_monitor->Mem_MinActiveFreqType =3D input[3];
+               activity_monitor->Mem_MinActiveFreq =3D input[4];
+               activity_monitor->Mem_BoosterFreqType =3D input[5];
+               activity_monitor->Mem_BoosterFreq =3D input[6];
+               activity_monitor->Mem_PD_Data_limit_c =3D input[7];
+               activity_monitor->Mem_PD_Data_error_coeff =3D input[8];
+               activity_monitor->Mem_PD_Data_error_rate_coeff =3D input[9]=
;
+               break;
+       default:
                return -EINVAL;
        }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
-               if (size !=3D 10)
-                       return -EINVAL;
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLO=
AD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor_external), tr=
ue);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to set activity monito=
r!", __func__);
+               return ret;
+       }

-               ret =3D smu_cmn_update_table(smu,
-                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
-                                      (void *)(&activity_monitor_external)=
, false);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to get activit=
y monitor!", __func__);
-                       return ret;
-               }
+       return ret;
+}

-               switch (input[0]) {
-               case 0: /* Gfxclk */
-                       activity_monitor->Gfx_FPS =3D input[1];
-                       activity_monitor->Gfx_MinFreqStep =3D input[2];
-                       activity_monitor->Gfx_MinActiveFreqType =3D input[3=
];
-                       activity_monitor->Gfx_MinActiveFreq =3D input[4];
-                       activity_monitor->Gfx_BoosterFreqType =3D input[5];
-                       activity_monitor->Gfx_BoosterFreq =3D input[6];
-                       activity_monitor->Gfx_PD_Data_limit_c =3D input[7];
-                       activity_monitor->Gfx_PD_Data_error_coeff =3D input=
[8];
-                       activity_monitor->Gfx_PD_Data_error_rate_coeff =3D =
input[9];
-                       break;
-               case 1: /* Socclk */
-                       activity_monitor->Fclk_FPS =3D input[1];
-                       activity_monitor->Fclk_MinFreqStep =3D input[2];
-                       activity_monitor->Fclk_MinActiveFreqType =3D input[=
3];
-                       activity_monitor->Fclk_MinActiveFreq =3D input[4];
-                       activity_monitor->Fclk_BoosterFreqType =3D input[5]=
;
-                       activity_monitor->Fclk_BoosterFreq =3D input[6];
-                       activity_monitor->Fclk_PD_Data_limit_c =3D input[7]=
;
-                       activity_monitor->Fclk_PD_Data_error_coeff =3D inpu=
t[8];
-                       activity_monitor->Fclk_PD_Data_error_rate_coeff =3D=
 input[9];
-                       break;
-               case 2: /* Memclk */
-                       activity_monitor->Mem_FPS =3D input[1];
-                       activity_monitor->Mem_MinFreqStep =3D input[2];
-                       activity_monitor->Mem_MinActiveFreqType =3D input[3=
];
-                       activity_monitor->Mem_MinActiveFreq =3D input[4];
-                       activity_monitor->Mem_BoosterFreqType =3D input[5];
-                       activity_monitor->Mem_BoosterFreq =3D input[6];
-                       activity_monitor->Mem_PD_Data_limit_c =3D input[7];
-                       activity_monitor->Mem_PD_Data_error_coeff =3D input=
[8];
-                       activity_monitor->Mem_PD_Data_error_rate_coeff =3D =
input[9];
-                       break;
-               default:
-                       return -EINVAL;
-               }
+static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
+                                                u32 workload_mask)
+{
+       u32 backend_workload_mask =3D 0;
+       bool custom_enabled =3D false;
+       int ret;

-               ret =3D smu_cmn_update_table(smu,
-                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
-                                      (void *)(&activity_monitor_external)=
, true);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to set activit=
y monitor!", __func__);
+       smu_cmn_get_backend_workload_mask(smu, workload_mask,
+                                         &backend_workload_mask,
+                                         &custom_enabled);
+
+       if (custom_enabled) {
+               ret =3D sienna_cichlid_set_power_profile_mode_coeff(smu,
+                                                                 smu->cust=
om_profile_input,
+                                                                 smu->cust=
om_profile_size);
+               if (ret)
                        return ret;
-               }
        }

-       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-       workload_type =3D smu_cmn_to_asic_specific_index(smu,
-                                                      CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      smu->power_profile_m=
ode);
-       if (workload_type < 0)
-               return -EINVAL;
-
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMas=
k,
-                                   smu->workload_mask, NULL);
-       if (ret)
-               dev_err(smu->adev->dev, "[%s] Failed to set work load mask!=
", __func__);
-       else
-               smu_cmn_assign_power_profile(smu);
+                                             backend_workload_mask, NULL);
+       if (ret) {
+               dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x=
\n",
+                       workload_mask);
+               return ret;
+       }
+
+       smu->backend_workload_mask =3D backend_workload_mask;

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f89c487dce72..279d01f58785 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1056,42 +1056,29 @@ static int vangogh_get_power_profile_mode(struct sm=
u_context *smu,
        return size;
 }

-static int vangogh_set_power_profile_mode(struct smu_context *smu, long *i=
nput, uint32_t size)
+static int vangogh_set_power_profile_mode(struct smu_context *smu,
+                                         u32 workload_mask)
 {
-       int workload_type, ret;
-       uint32_t profile_mode =3D input[size];
+       u32 backend_workload_mask =3D 0;
+       bool custom_enabled =3D false;
+       int ret;

-       if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
profile_mode);
-               return -EINVAL;
-       }
-
-       if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-                       profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVIN=
G)
-               return 0;
-
-       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-       workload_type =3D smu_cmn_to_asic_specific_index(smu,
-                                                      CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      profile_mode);
-       if (workload_type < 0) {
-               dev_dbg(smu->adev->dev, "Unsupported power profile mode %d =
on VANGOGH\n",
-                                       profile_mode);
-               return -EINVAL;
-       }
+       smu_cmn_get_backend_workload_mask(smu, workload_mask,
+                                         &backend_workload_mask,
+                                         &custom_enabled);

        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessN=
otify,
-                                   smu->workload_mask,
-                                   NULL);
+                                             backend_workload_mask,
+                                             NULL);
        if (ret) {
-               dev_err_once(smu->adev->dev, "Fail to set workload type %d\=
n",
-                                       workload_type);
+               dev_err_once(smu->adev->dev, "Fail to set workload mask 0x%=
08x\n",
+                            workload_mask);
                return ret;
        }

-       smu_cmn_assign_power_profile(smu);
+       smu->backend_workload_mask =3D backend_workload_mask;

-       return 0;
+       return ret;
 }

 static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 75a9ea87f419..f6d0973506d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -864,44 +864,29 @@ static int renoir_force_clk_levels(struct smu_context=
 *smu,
        return ret;
 }

-static int renoir_set_power_profile_mode(struct smu_context *smu, long *in=
put, uint32_t size)
+static int renoir_set_power_profile_mode(struct smu_context *smu,
+                                        u32 workload_mask)
 {
-       int workload_type, ret;
-       uint32_t profile_mode =3D input[size];
+       int ret;
+       u32 backend_workload_mask =3D 0;
+       bool custom_enabled =3D false;

-       if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
profile_mode);
-               return -EINVAL;
-       }
-
-       if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-                       profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVIN=
G)
-               return 0;
-
-       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-       workload_type =3D smu_cmn_to_asic_specific_index(smu,
-                                                      CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      profile_mode);
-       if (workload_type < 0) {
-               /*
-                * TODO: If some case need switch to powersave/default powe=
r mode
-                * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM=
 for power saving.
-                */
-               dev_dbg(smu->adev->dev, "Unsupported power profile mode %d =
on RENOIR\n", profile_mode);
-               return -EINVAL;
-       }
+       smu_cmn_get_backend_workload_mask(smu, workload_mask,
+                                         &backend_workload_mask,
+                                         &custom_enabled);

        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessN=
otify,
-                                   smu->workload_mask,
-                                   NULL);
+                                             backend_workload_mask,
+                                             NULL);
        if (ret) {
-               dev_err_once(smu->adev->dev, "Fail to set workload type %d\=
n", workload_type);
+               dev_err_once(smu->adev->dev, "Failed to set workload mask 0=
x08%x\n",
+                            workload_mask);
                return ret;
        }

-       smu_cmn_assign_power_profile(smu);
+       smu->backend_workload_mask =3D backend_workload_mask;

-       return 0;
+       return ret;
 }

 static int renoir_set_peak_clock_by_device(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 80c6b1e523aa..4bc984cca6cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2571,82 +2571,76 @@ static int smu_v13_0_0_get_power_profile_mode(struc=
t smu_context *smu,
        return size;
 }

-static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
-                                             long *input,
-                                             uint32_t size)
+static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_context *sm=
u,
+                                                   long *input,
+                                                   uint32_t size)
 {
        DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
        DpmActivityMonitorCoeffInt_t *activity_monitor =3D
                &(activity_monitor_external.DpmActivityMonitorCoeffInt);
-       int workload_type, ret =3D 0;
-       u32 workload_mask;
-
-       smu->power_profile_mode =3D input[size];
+       int ret;

-       if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
smu->power_profile_mode);
+       if (size !=3D 9)
                return -EINVAL;
-       }
-
-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
-               if (size !=3D 9)
-                       return -EINVAL;

-               ret =3D smu_cmn_update_table(smu,
-                                          SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
-                                          WORKLOAD_PPLIB_CUSTOM_BIT,
-                                          (void *)(&activity_monitor_exter=
nal),
-                                          false);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to get activit=
y monitor!", __func__);
-                       return ret;
-               }
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+                                  WORKLOAD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor_external),
+                                  false);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to get activity monito=
r!", __func__);
+               return ret;
+       }

-               switch (input[0]) {
-               case 0: /* Gfxclk */
-                       activity_monitor->Gfx_FPS =3D input[1];
-                       activity_monitor->Gfx_MinActiveFreqType =3D input[2=
];
-                       activity_monitor->Gfx_MinActiveFreq =3D input[3];
-                       activity_monitor->Gfx_BoosterFreqType =3D input[4];
-                       activity_monitor->Gfx_BoosterFreq =3D input[5];
-                       activity_monitor->Gfx_PD_Data_limit_c =3D input[6];
-                       activity_monitor->Gfx_PD_Data_error_coeff =3D input=
[7];
-                       activity_monitor->Gfx_PD_Data_error_rate_coeff =3D =
input[8];
-                       break;
-               case 1: /* Fclk */
-                       activity_monitor->Fclk_FPS =3D input[1];
-                       activity_monitor->Fclk_MinActiveFreqType =3D input[=
2];
-                       activity_monitor->Fclk_MinActiveFreq =3D input[3];
-                       activity_monitor->Fclk_BoosterFreqType =3D input[4]=
;
-                       activity_monitor->Fclk_BoosterFreq =3D input[5];
-                       activity_monitor->Fclk_PD_Data_limit_c =3D input[6]=
;
-                       activity_monitor->Fclk_PD_Data_error_coeff =3D inpu=
t[7];
-                       activity_monitor->Fclk_PD_Data_error_rate_coeff =3D=
 input[8];
-                       break;
-               default:
-                       return -EINVAL;
-               }
+       switch (input[0]) {
+       case 0: /* Gfxclk */
+               activity_monitor->Gfx_FPS =3D input[1];
+               activity_monitor->Gfx_MinActiveFreqType =3D input[2];
+               activity_monitor->Gfx_MinActiveFreq =3D input[3];
+               activity_monitor->Gfx_BoosterFreqType =3D input[4];
+               activity_monitor->Gfx_BoosterFreq =3D input[5];
+               activity_monitor->Gfx_PD_Data_limit_c =3D input[6];
+               activity_monitor->Gfx_PD_Data_error_coeff =3D input[7];
+               activity_monitor->Gfx_PD_Data_error_rate_coeff =3D input[8]=
;
+               break;
+       case 1: /* Fclk */
+               activity_monitor->Fclk_FPS =3D input[1];
+               activity_monitor->Fclk_MinActiveFreqType =3D input[2];
+               activity_monitor->Fclk_MinActiveFreq =3D input[3];
+               activity_monitor->Fclk_BoosterFreqType =3D input[4];
+               activity_monitor->Fclk_BoosterFreq =3D input[5];
+               activity_monitor->Fclk_PD_Data_limit_c =3D input[6];
+               activity_monitor->Fclk_PD_Data_error_coeff =3D input[7];
+               activity_monitor->Fclk_PD_Data_error_rate_coeff =3D input[8=
];
+               break;
+       default:
+               return -EINVAL;
+       }

-               ret =3D smu_cmn_update_table(smu,
-                                          SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
-                                          WORKLOAD_PPLIB_CUSTOM_BIT,
-                                          (void *)(&activity_monitor_exter=
nal),
-                                          true);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to set activit=
y monitor!", __func__);
-                       return ret;
-               }
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+                                  WORKLOAD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor_external),
+                                  true);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to set activity monito=
r!", __func__);
+               return ret;
        }

-       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-       workload_type =3D smu_cmn_to_asic_specific_index(smu,
-                                                      CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      smu->power_profile_m=
ode);
+       return ret;
+}

-       if (workload_type < 0)
-               return -EINVAL;
+static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
+                                             u32 workload_mask)
+{
+       u32 backend_workload_mask =3D 0;
+       bool custom_enabled =3D false;
+       int workload_type, ret;

-       workload_mask =3D 1 << workload_type;
+       smu_cmn_get_backend_workload_mask(smu, workload_mask,
+                                         &backend_workload_mask,
+                                         &custom_enabled);

        /* Add optimizations for SMU13.0.0/10.  Reuse the power saving prof=
ile */
        if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 0) &&
@@ -2658,26 +2652,29 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,
                                                               CMN2ASIC_MAP=
PING_WORKLOAD,
                                                               PP_SMC_POWER=
_PROFILE_POWERSAVING);
                if (workload_type >=3D 0)
-                       workload_mask |=3D 1 << workload_type;
+                       backend_workload_mask |=3D 1 << workload_type;
+       }
+
+       if (custom_enabled) {
+               ret =3D smu_v13_0_0_set_power_profile_mode_coeff(smu,
+                                                              smu->custom_=
profile_input,
+                                                              smu->custom_=
profile_size);
+               if (ret)
+                       return ret;
        }

-       smu->workload_mask |=3D workload_mask;
        ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                                              SMU_MSG_SetWorkloadMask,
-                                              smu->workload_mask,
-                                              NULL);
-       if (!ret) {
-               smu_cmn_assign_power_profile(smu);
-               if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_POW=
ERSAVING) {
-                       workload_type =3D smu_cmn_to_asic_specific_index(sm=
u,
-                                                              CMN2ASIC_MAP=
PING_WORKLOAD,
-                                                              PP_SMC_POWER=
_PROFILE_FULLSCREEN3D);
-                       smu->power_profile_mode =3D smu->workload_mask & (1=
 << workload_type)
-                                                                          =
     ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
-                                                                          =
     : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-               }
+                                             SMU_MSG_SetWorkloadMask,
+                                             backend_workload_mask,
+                                             NULL);
+       if (ret) {
+               dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x=
\n",
+                       workload_mask);
+               return ret;
        }

+       smu->backend_workload_mask =3D backend_workload_mask;
+
        return ret;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c5d3e25cc967..225629eb9422 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2528,79 +2528,89 @@ do {                                               =
                                                     \
        return result;
 }

-static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, lon=
g *input, uint32_t size)
+static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_context *sm=
u,
+                                                   long *input, uint32_t s=
ize)
 {

        DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
        DpmActivityMonitorCoeffInt_t *activity_monitor =3D
                &(activity_monitor_external.DpmActivityMonitorCoeffInt);
-       int workload_type, ret =3D 0;
+       int ret;
+
+       if (size !=3D 8)
+               return -EINVAL;

-       smu->power_profile_mode =3D input[size];
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLO=
AD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor_external), fa=
lse);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to get activity monito=
r!", __func__);
+               return ret;
+       }

-       if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
smu->power_profile_mode);
+       switch (input[0]) {
+       case 0: /* Gfxclk */
+               activity_monitor->Gfx_ActiveHystLimit =3D input[1];
+               activity_monitor->Gfx_IdleHystLimit =3D input[2];
+               activity_monitor->Gfx_FPS =3D input[3];
+               activity_monitor->Gfx_MinActiveFreqType =3D input[4];
+               activity_monitor->Gfx_BoosterFreqType =3D input[5];
+               activity_monitor->Gfx_MinActiveFreq =3D input[6];
+               activity_monitor->Gfx_BoosterFreq =3D input[7];
+               break;
+       case 1: /* Fclk */
+               activity_monitor->Fclk_ActiveHystLimit =3D input[1];
+               activity_monitor->Fclk_IdleHystLimit =3D input[2];
+               activity_monitor->Fclk_FPS =3D input[3];
+               activity_monitor->Fclk_MinActiveFreqType =3D input[4];
+               activity_monitor->Fclk_BoosterFreqType =3D input[5];
+               activity_monitor->Fclk_MinActiveFreq =3D input[6];
+               activity_monitor->Fclk_BoosterFreq =3D input[7];
+               break;
+       default:
                return -EINVAL;
        }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
-               if (size !=3D 8)
-                       return -EINVAL;
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLO=
AD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor_external), tr=
ue);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to set activity monito=
r!", __func__);
+               return ret;
+       }

-               ret =3D smu_cmn_update_table(smu,
-                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
-                                      (void *)(&activity_monitor_external)=
, false);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to get activit=
y monitor!", __func__);
-                       return ret;
-               }
+       return ret;
+}

-               switch (input[0]) {
-               case 0: /* Gfxclk */
-                       activity_monitor->Gfx_ActiveHystLimit =3D input[1];
-                       activity_monitor->Gfx_IdleHystLimit =3D input[2];
-                       activity_monitor->Gfx_FPS =3D input[3];
-                       activity_monitor->Gfx_MinActiveFreqType =3D input[4=
];
-                       activity_monitor->Gfx_BoosterFreqType =3D input[5];
-                       activity_monitor->Gfx_MinActiveFreq =3D input[6];
-                       activity_monitor->Gfx_BoosterFreq =3D input[7];
-                       break;
-               case 1: /* Fclk */
-                       activity_monitor->Fclk_ActiveHystLimit =3D input[1]=
;
-                       activity_monitor->Fclk_IdleHystLimit =3D input[2];
-                       activity_monitor->Fclk_FPS =3D input[3];
-                       activity_monitor->Fclk_MinActiveFreqType =3D input[=
4];
-                       activity_monitor->Fclk_BoosterFreqType =3D input[5]=
;
-                       activity_monitor->Fclk_MinActiveFreq =3D input[6];
-                       activity_monitor->Fclk_BoosterFreq =3D input[7];
-                       break;
-               default:
-                       return -EINVAL;
-               }
+static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
+                                             u32 workload_mask)
+{
+       u32 backend_workload_mask =3D 0;
+       bool custom_enabled =3D false;
+       int ret;

-               ret =3D smu_cmn_update_table(smu,
-                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
-                                      (void *)(&activity_monitor_external)=
, true);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to set activit=
y monitor!", __func__);
+       smu_cmn_get_backend_workload_mask(smu, workload_mask,
+                                         &backend_workload_mask,
+                                         &custom_enabled);
+
+       if (custom_enabled) {
+               ret =3D smu_v13_0_7_set_power_profile_mode_coeff(smu,
+                                                              smu->custom_=
profile_input,
+                                                              smu->custom_=
profile_size);
+               if (ret)
                        return ret;
-               }
        }

-       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-       workload_type =3D smu_cmn_to_asic_specific_index(smu,
-                                                      CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      smu->power_profile_m=
ode);
-       if (workload_type < 0)
-               return -EINVAL;
-
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMas=
k,
-                                   smu->workload_mask, NULL);
+                                             backend_workload_mask, NULL);

-       if (ret)
-               dev_err(smu->adev->dev, "[%s] Failed to set work load mask!=
", __func__);
-       else
-               smu_cmn_assign_power_profile(smu);
+       if (ret) {
+               dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x=
\n",
+                       workload_mask);
+               return ret;
+       }
+
+       smu->backend_workload_mask =3D backend_workload_mask;

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..272a44b6faf7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1717,89 +1717,100 @@ static int smu_v14_0_2_get_power_profile_mode(stru=
ct smu_context *smu,
        return size;
 }

-static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
-                                             long *input,
-                                             uint32_t size)
+static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_context *sm=
u,
+                                                   long *input,
+                                                   uint32_t size)
 {
        DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
        DpmActivityMonitorCoeffInt_t *activity_monitor =3D
                &(activity_monitor_external.DpmActivityMonitorCoeffInt);
-       int workload_type, ret =3D 0;
-       uint32_t current_profile_mode =3D smu->power_profile_mode;
-       smu->power_profile_mode =3D input[size];
+       int ret;

-       if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
-               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
smu->power_profile_mode);
+       if (size !=3D 9)
                return -EINVAL;
+
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+                                  WORKLOAD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor_external),
+                                  false);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to get activity monito=
r!", __func__);
+               return ret;
        }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
-               if (size !=3D 9)
-                       return -EINVAL;
+       switch (input[0]) {
+       case 0: /* Gfxclk */
+               activity_monitor->Gfx_FPS =3D input[1];
+               activity_monitor->Gfx_MinActiveFreqType =3D input[2];
+               activity_monitor->Gfx_MinActiveFreq =3D input[3];
+               activity_monitor->Gfx_BoosterFreqType =3D input[4];
+               activity_monitor->Gfx_BoosterFreq =3D input[5];
+               activity_monitor->Gfx_PD_Data_limit_c =3D input[6];
+               activity_monitor->Gfx_PD_Data_error_coeff =3D input[7];
+               activity_monitor->Gfx_PD_Data_error_rate_coeff =3D input[8]=
;
+               break;
+       case 1: /* Fclk */
+               activity_monitor->Fclk_FPS =3D input[1];
+               activity_monitor->Fclk_MinActiveFreqType =3D input[2];
+               activity_monitor->Fclk_MinActiveFreq =3D input[3];
+               activity_monitor->Fclk_BoosterFreqType =3D input[4];
+               activity_monitor->Fclk_BoosterFreq =3D input[5];
+               activity_monitor->Fclk_PD_Data_limit_c =3D input[6];
+               activity_monitor->Fclk_PD_Data_error_coeff =3D input[7];
+               activity_monitor->Fclk_PD_Data_error_rate_coeff =3D input[8=
];
+               break;
+       default:
+               return -EINVAL;
+       }

-               ret =3D smu_cmn_update_table(smu,
-                                          SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
-                                          WORKLOAD_PPLIB_CUSTOM_BIT,
-                                          (void *)(&activity_monitor_exter=
nal),
-                                          false);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to get activit=
y monitor!", __func__);
-                       return ret;
-               }
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+                                  WORKLOAD_PPLIB_CUSTOM_BIT,
+                                  (void *)(&activity_monitor_external),
+                                  true);
+       if (ret) {
+               dev_err(smu->adev->dev, "[%s] Failed to set activity monito=
r!", __func__);
+               return ret;
+       }

-               switch (input[0]) {
-               case 0: /* Gfxclk */
-                       activity_monitor->Gfx_FPS =3D input[1];
-                       activity_monitor->Gfx_MinActiveFreqType =3D input[2=
];
-                       activity_monitor->Gfx_MinActiveFreq =3D input[3];
-                       activity_monitor->Gfx_BoosterFreqType =3D input[4];
-                       activity_monitor->Gfx_BoosterFreq =3D input[5];
-                       activity_monitor->Gfx_PD_Data_limit_c =3D input[6];
-                       activity_monitor->Gfx_PD_Data_error_coeff =3D input=
[7];
-                       activity_monitor->Gfx_PD_Data_error_rate_coeff =3D =
input[8];
-                       break;
-               case 1: /* Fclk */
-                       activity_monitor->Fclk_FPS =3D input[1];
-                       activity_monitor->Fclk_MinActiveFreqType =3D input[=
2];
-                       activity_monitor->Fclk_MinActiveFreq =3D input[3];
-                       activity_monitor->Fclk_BoosterFreqType =3D input[4]=
;
-                       activity_monitor->Fclk_BoosterFreq =3D input[5];
-                       activity_monitor->Fclk_PD_Data_limit_c =3D input[6]=
;
-                       activity_monitor->Fclk_PD_Data_error_coeff =3D inpu=
t[7];
-                       activity_monitor->Fclk_PD_Data_error_rate_coeff =3D=
 input[8];
-                       break;
-               default:
-                       return -EINVAL;
-               }
+       return ret;
+}

-               ret =3D smu_cmn_update_table(smu,
-                                          SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
-                                          WORKLOAD_PPLIB_CUSTOM_BIT,
-                                          (void *)(&activity_monitor_exter=
nal),
-                                          true);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to set activit=
y monitor!", __func__);
-                       return ret;
-               }
-       }
+static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
+                                             u32 workload_mask)
+{
+       u32 backend_workload_mask =3D 0;
+       bool custom_enabled =3D false;
+       int ret;
+
+       smu_cmn_get_backend_workload_mask(smu, workload_mask,
+                                         &backend_workload_mask,
+                                         &custom_enabled);

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
+       /* disable deep sleep if compute is enabled */
+       if (workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
                smu_v14_0_deep_sleep_control(smu, false);
-       else if (current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
+       else
                smu_v14_0_deep_sleep_control(smu, true);

-       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-       workload_type =3D smu_cmn_to_asic_specific_index(smu,
-                                                      CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      smu->power_profile_m=
ode);
-       if (workload_type < 0)
-               return -EINVAL;
+       if (custom_enabled) {
+               ret =3D smu_v14_0_2_set_power_profile_mode_coeff(smu,
+                                                              smu->custom_=
profile_input,
+                                                              smu->custom_=
profile_size);
+               if (ret)
+                       return ret;
+       }

        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMas=
k,
-                                                                          =
       smu->workload_mask, NULL);
+                                             backend_workload_mask, NULL);
+       if (ret) {
+               dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x=
\n",
+                       workload_mask);
+               return ret;
+       }

-       if (!ret)
-               smu_cmn_assign_power_profile(smu);
+       smu->backend_workload_mask =3D backend_workload_mask;

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index fd2aa949538e..91a3bf074f78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
        return ret;
 }

-void smu_cmn_assign_power_profile(struct smu_context *smu)
-{
-       uint32_t index;
-       index =3D fls(smu->workload_mask);
-       index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? index - 1 :=
 0;
-       smu->power_profile_mode =3D smu->workload_setting[index];
-}
-
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 {
        struct pci_dev *p =3D NULL;
@@ -1226,3 +1218,33 @@ void smu_cmn_generic_plpd_policy_desc(struct smu_dpm=
_policy *policy)
 {
        policy->desc =3D &xgmi_plpd_policy_desc;
 }
+
+void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
+                                      u32 workload_mask,
+                                      u32 *backend_workload_mask,
+                                      bool *custom_enabled)
+{
+       int workload_type;
+       u32 profile_mode;
+
+       *custom_enabled =3D false;
+       *backend_workload_mask =3D 0;
+
+       for (profile_mode =3D 0; profile_mode < PP_SMC_POWER_PROFILE_COUNT;=
 profile_mode++) {
+               if (!(workload_mask & (1 << profile_mode)))
+                       continue;
+
+               /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+               workload_type =3D smu_cmn_to_asic_specific_index(smu,
+                                                              CMN2ASIC_MAP=
PING_WORKLOAD,
+                                                              profile_mode=
);
+
+               if (workload_type < 0)
+                       continue;
+
+               *backend_workload_mask |=3D 1 << workload_type;
+
+               if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM)
+                       *custom_enabled =3D true;
+       }
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index 8a801e389659..8d40c02efa00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t=
 frev, uint8_t crev);
 int smu_cmn_set_mp1_state(struct smu_context *smu,
                          enum pp_mp1_state mp1_state);

-void smu_cmn_assign_power_profile(struct smu_context *smu);
-
 /*
  * Helper function to make sysfs_emit_at() happy. Align buf to
  * the current page boundary and record the offset.
@@ -149,5 +147,10 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_devic=
e *adev);
 void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
 void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);

+void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
+                                      u32 workload_mask,
+                                      u32 *backend_workload_mask,
+                                      bool *custom_enabled);
+
 #endif
 #endif
--
2.47.0


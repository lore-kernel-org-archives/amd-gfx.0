Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0010CD6E6B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 10:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9DD10FA1F;
	Thu,  4 Jun 2026 10:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="feYBJQyw";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6875210FA1F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 10:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vj5FXgOs/L2vFbqpP1gzzE88otf6Nn4ejGK7smIFgil7JE4lxaObWgdHxTU6y+j8PN0WA4xTmzOvMZRTScpsrkgVDhTJJDzbRsJz0Nz4nBo2ka0YR6tpLKXSnr7bAm7BzjiDbjySYQAo8hoCCPCYsaEcA2Em9sg/1kZNbdmeoG2M/LDr6nL983+OXl3hL6Pturq2s1n5wVFpad33C+SWiqqicpduT2OS8OgBpLgpGc4NtPnwpr7ZSnmq1ccdITF6Hq8Rlbw07gKbNH2GRJXZlix34wAAosuScqlnK2NUZanKmdyZ6Y8UB3ITExWUjOBjV70thLf2Bk4oi49iybs7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raKjh670NAATAkSZNfgqirqvPRp6/BQedqbpIheXvwI=;
 b=a4xgOuM8j551RbdamUonxTqpGzGSORF4T2K7shwEitWjejIO5NqOQr3YKf2tNl7AQCSfFnTVeTmisdbBYoXWVX5WhA1t+jQJa+apSf+sD/Wabvb8L01pk/k5ro8yhJeC/s5RQUjjo6x92sdGX6hAxRzjlIfLfLmQCIcogN/OeV2Y6ZvJcY9HxfE9sSdippY3ZuQ/LJ2BvpLvLlAWvLiYHi0OWddZkTLXjyJV2lUrneniYfw5z/xczDuW5GHN4Rz2ZwBqn6tb9NYOTNN5tOGCViHkK/w0W58i7WxC/17v0UgywZgQHSWdDoGvz8gnCTKI9r+/TcPNJHMTfCJQMlvVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raKjh670NAATAkSZNfgqirqvPRp6/BQedqbpIheXvwI=;
 b=feYBJQywWxP2ApYqHfNIfT7Va2TsSX6llMwWYQbJI6ihhlCFlsBlYTSzHTP6GuqA5n+/cYE19icQ5HIG/gwK/Vvi3ilmftTAHuvulGO2fIrKWQhSUNDN/5x+69aJImJOpQnRNa1Mgj71ZQBD3AjBbAW5q/WfvpVo+x1OD2B3b1M=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN5PR12MB9486.namprd12.prod.outlook.com (2603:10b6:408:2ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 10:11:08 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:11:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v3] drm/amd/pm: Validate OD DPM triples before mutating
 tables
Thread-Topic: [PATCH v3] drm/amd/pm: Validate OD DPM triples before mutating
 tables
Thread-Index: AQHc9ANTRwuUJ1JP/0S4IgHGQOeTiLYuLCIg
Date: Thu, 4 Jun 2026 10:11:08 +0000
Message-ID: <BN9PR12MB5257DB77812532CFAE664F24FC102@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260604091915.1012329-1-asad.kamal@amd.com>
In-Reply-To: <20260604091915.1012329-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-04T10:08:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN5PR12MB9486:EE_
x-ms-office365-filtering-correlation-id: 8440fd75-aeeb-4c43-1fb5-08dec22198cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: pJn3coWuw1PIIiLsFzL0apCwqf3iVQQFBks+kFUFNEJW6bMS638toAt3vwNTWqs4H0lbEMnfAeW8bZuWClPc6ViQV6frrIO4nKZI0SWpJDIBOJ0bB4yQ/aTkcUWzFzgssDw3cps7LnGYjP553gxAwYSZK3Du8gQVxCz6wDbHIkLL8DZvzirM7A2qO5u1+rmbjASzciQa0pw/iez9SyLwhYXsoYxDVgPlUhZbYYwVJ2Oj1uoPaIIDfhEmWO0VffN+iTzu5SNPUVdFRIm7D905ZzkecxebcY/3JpAghzfuhuS0Oo9W+3RLj8HlGJenubS7lENXfdzX4w+abjo1LwCFppdfx10AuMsTM2QyUuf+vBZzDmGGfhcRKohoExeGEKRQ14fWd0FQAjgpHF7mynvCADXzBxXYbSXOswgQZCmDIOl+Rd6wuEgv3HdDXvIhtVH4+gcr5+/TVQpmkkWjcbJzOlHCKz+4PsNtEhqHzhrUpNeT+jhGVLCZ2T5q8+Ch/7nSmfxWXe/cmhob7C9JUr9/0EczJfxdeZVr90SkA9jRWucpWdyxcp+sfR8azRw6UOTeYX55nKUCitRHVBmA2o4ChF9+4Grli0/zOb+nNfzQdsmEl5TchaGN0V4lRwShxubR2Ze0QN0ThGds+yjQH+UnCAi/Fk2OuxdkJ5yxCD91rRm16aU1+k8L6yAHz6rbecaLwEXFGtfraC3Driv5ZkvZtIItm1XVdVM+yPTNSWqSeUkOQNbj7JtRg0QigtSVflrn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jEZxCv834GRtPCNGWSnSPiAdOfRrM7/vxTwRo6eunEutnkVFK6xtoPmBsD/4?=
 =?us-ascii?Q?YMZcDIm2gqWOaJDRSA5mGJHb4/B/RtSqE532ivaXa6DVIqFbbgW8jiVuIDLv?=
 =?us-ascii?Q?YXjCceimDn01ul2cb5hWhLKgEnofyX71r+TeC6DcRJAWdn4Uz06feK77YaY1?=
 =?us-ascii?Q?HCRLtat5MHHoZJHK/gYsNtThyZ9hE7aYQ/gAub9fdpUMxIYzvrRWXcCyynR6?=
 =?us-ascii?Q?GmU1y54CqD/hkuhJAL9mvdkqtCbKg5WqouNen9+hto2hneC12ubUNWXdBXiE?=
 =?us-ascii?Q?x66l5SDJVOqhn/MH915qtXfTBRIVpyWVHqp4fG9P8rGa/Y9jV85FvOdBlauB?=
 =?us-ascii?Q?+K09rEThHsV2CS2eHsmM0I4Q3swAxasgplrb4J4VGpxdirGk1pLQET5wUvl+?=
 =?us-ascii?Q?AyqYMAzHOd3tUsp7rp7sEEwnWfQe+K9n1HWXdmy+AzJAz6Xn+xdPmGYSdmij?=
 =?us-ascii?Q?hLI6c2m+9ZuT+SaA8eNw8ynEvh+TXZApMQOKv4P06/R08469J67sCw7tEbKv?=
 =?us-ascii?Q?Yzu+AsLVkimAQ61Wv+haYP4ixKdwlBMn1JQfwDPF8y8qegGLTEeq87DCeDWv?=
 =?us-ascii?Q?US3fkZO0dqEgI0G4itA3V2ClDXwWTGsl6ZlZq1TQVaPBYL9eijb8+eigDnUt?=
 =?us-ascii?Q?P4FE07zXNjRmRoxKRMeaCheiAYoE/cJwdzm2WSW8Fp+qcInt6jQ04hzV6OVQ?=
 =?us-ascii?Q?oAc6UHyoHEhxtWonzZy6UyfZ9bYuiAtexyc2vDWvmzYPSeJ28Z8Q7PKa0o/9?=
 =?us-ascii?Q?qy+buoV1S+WhJUzhvURkqjwZzQza4NpQJRAmrgAVoW0vQfyoT7icZsE3Gh6g?=
 =?us-ascii?Q?rGQl3KqVwqRLUNe1YXI+dFN89exnPSWlbZQ9TikMRtIZPJF7uGpmomA+0vd/?=
 =?us-ascii?Q?nVGraS+X20raX2gyhlMzxyDQTVTd44A8oBhCGDDj7RZQpMP4QicrSH68MhPe?=
 =?us-ascii?Q?w9OWk6kvvXKaxqD0n/SRw9BlfR8J8WpNGgMH2cyS0/P9bJUUrJ6omy3lXQyT?=
 =?us-ascii?Q?afL0STTN+FOf0hSQtmpiq5rApBoyRQ+8CNiKBXnDxoma/MoDUQ1CrkDxOTta?=
 =?us-ascii?Q?IEIwJGPK2EXhc+uDN9XKnePANfgsoQEwAFdwn/GehlZltOwvkT4B5HpFUBSO?=
 =?us-ascii?Q?OAxymFMvlAwG28ZFiQ/0OoZJKn3GJkYzSPWK0bzly8BQBw7l0eVA1nTI+3V1?=
 =?us-ascii?Q?bYgUWb4RHvmiT19RJ0wFoxW4wwk5jK42oEYXj8mO8Hd7FMV4ZqRDu3qMs370?=
 =?us-ascii?Q?XxsDy9/qsyVfPW4OezNZyp9+w9zlX7C3WNOxv7AZGg5OCHE9LhEy0tZ7ou7D?=
 =?us-ascii?Q?rk6FKV84Z6No+i+4KXvzem781sCW4gqHMmp0u+e9y/mobo3GdkgVWIjb+zxQ?=
 =?us-ascii?Q?7bSz+K5/2w1XVNYqiqjaByQJHnpbl81YUYfPAkzSy/KOBlSTtrV63n0T6klz?=
 =?us-ascii?Q?Ogr3NE7DVeZMQxjySG5v8oE2icWTBeZzfoypghzQkpuVUiWchkFa+gM/cev2?=
 =?us-ascii?Q?i8u3QlV6j8mg41kzhAJozpHhuG/NOcOnUs9R2lr2Fi93Tk09A5xGMaLh979t?=
 =?us-ascii?Q?DAhMhBokpzLqbBPY41oPxHFTuG9irx2fVt+eG/FlBqMDk4K1rYD0j5z36VDf?=
 =?us-ascii?Q?grEW+Cy77sODXYm1hAnJCX/Qyd1tCUbzlWd1kbbLn044L31cm4vIyNpZ0R3a?=
 =?us-ascii?Q?LsE97CU50z9NowhHVQLC5Uff0dEwQrQeAgFDNs2eyaa2YpbK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8440fd75-aeeb-4c43-1fb5-08dec22198cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 10:11:08.5315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7At1Ds22qYDCzqZJ/BWvN11R3l0aAgEXrshMnvdvQzOBGMTRcCArlAuA2f0bqcqXJXmf9b1EGGfPFUNSyJVx6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9486
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Thursday, June 4, 2026 5:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v3] drm/amd/pm: Validate OD DPM triples before mutating tab=
les

vega10_odn_edit_dpm_table() and smu7_odn_edit_dpm_table() could mutate the =
live ODN table for valid triples, then return 0 after detecting a truncated=
 buffer or out-of-range index. Validate all (index, clock,
voltage) triples first and return -EINVAL on any failure; only then apply u=
pdates.

v2: Use distinct message for different error case, removed unused input_lev=
el from validation loop (Lijo)

v3: Reject negative level indices, input[] is long but was compared only ag=
ainst unsigned table bounds, so negative values could pass and truncate whe=
n assigned to uint32_t input_level.

Set DPMTABLE_OD_UPDATE_SCLK/MCLK only after validation passes, so a failed =
sysfs write does not leave need_update_dpm_table set for a later commit.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 34 ++++++++++-------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 37 ++++++++++++-------
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 416b9380a70e..aac6a0fa5d7b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5648,23 +5648,29 @@ static int smu7_odn_edit_dpm_table(struct pp_hwmgr =
*hwmgr,
        }

        for (i =3D 0; i < size; i +=3D 3) {
-               if (i + 3 > size || input[i] >=3D podn_dpm_table_in_backend=
->num_of_pl) {
-                       pr_info("invalid clock voltage input \n");
-                       return 0;
+               if (i + 3 > size) {
+                       pr_info("truncated clock/voltage input\n");
+                       return -EINVAL;
                }
-               input_level =3D input[i];
-               input_clk =3D input[i+1] * 100;
-               input_vol =3D input[i+2];
-
-               if (smu7_check_clk_voltage_valid(hwmgr, type, input_clk, in=
put_vol)) {
-                       podn_dpm_table_in_backend->entries[input_level].clo=
ck =3D input_clk;
-                       podn_vdd_dep_in_backend->entries[input_level].clk =
=3D input_clk;
-                       podn_dpm_table_in_backend->entries[input_level].vdd=
c =3D input_vol;
-                       podn_vdd_dep_in_backend->entries[input_level].vddc =
=3D input_vol;
-                       podn_vdd_dep_in_backend->entries[input_level].vddgf=
x =3D input_vol;
-               } else {
+               if (input[i] < 0 || input[i] >=3D podn_dpm_table_in_backend=
->num_of_pl) {
+                       pr_info("invalid clock/voltage level\n");
                        return -EINVAL;
                }
+               input_clk =3D input[i + 1] * 100;
+               input_vol =3D input[i + 2];
+               if (!smu7_check_clk_voltage_valid(hwmgr, type, input_clk, i=
nput_vol))
+                       return -EINVAL;
+       }
+
+       for (i =3D 0; i < size; i +=3D 3) {
+               input_level =3D input[i];
+               input_clk =3D input[i + 1] * 100;
+               input_vol =3D input[i + 2];
+               podn_dpm_table_in_backend->entries[input_level].clock =3D i=
nput_clk;
+               podn_vdd_dep_in_backend->entries[input_level].clk =3D input=
_clk;
+               podn_dpm_table_in_backend->entries[input_level].vddc =3D in=
put_vol;
+               podn_vdd_dep_in_backend->entries[input_level].vddc =3D inpu=
t_vol;
+               podn_vdd_dep_in_backend->entries[input_level].vddgfx =3D in=
put_vol;
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 8b8c4e899878..076e10f26546 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5455,11 +5455,9 @@ static int vega10_odn_edit_dpm_table(struct pp_hwmgr=
 *hwmgr,
        if (PP_OD_EDIT_SCLK_VDDC_TABLE =3D=3D type) {
                dpm_table =3D &data->dpm_table.gfx_table;
                podn_vdd_dep_table =3D &data->odn_dpm_table.vdd_dep_on_sclk=
;
-               data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK;
        } else if (PP_OD_EDIT_MCLK_VDDC_TABLE =3D=3D type) {
                dpm_table =3D &data->dpm_table.mem_table;
                podn_vdd_dep_table =3D &data->odn_dpm_table.vdd_dep_on_mclk=
;
-               data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE_MCLK;
        } else if (PP_OD_RESTORE_DEFAULT_TABLE =3D=3D type) {
                memcpy(&(data->dpm_table), &(data->golden_dpm_table), sizeo=
f(struct vega10_dpm_table));
                vega10_odn_initial_default_setting(hwmgr);
@@ -5477,21 +5475,32 @@ static int vega10_odn_edit_dpm_table(struct pp_hwmg=
r *hwmgr,
        }

        for (i =3D 0; i < size; i +=3D 3) {
-               if (i + 3 > size || input[i] >=3D podn_vdd_dep_table->count=
) {
-                       pr_info("invalid clock voltage input\n");
-                       return 0;
+               if (i + 3 > size) {
+                       pr_info("truncated clock/voltage input\n");
+                       return -EINVAL;
                }
-               input_level =3D input[i];
-               input_clk =3D input[i+1] * 100;
-               input_vol =3D input[i+2];
-
-               if (vega10_check_clk_voltage_valid(hwmgr, type, input_clk, =
input_vol)) {
-                       dpm_table->dpm_levels[input_level].value =3D input_=
clk;
-                       podn_vdd_dep_table->entries[input_level].clk =3D in=
put_clk;
-                       podn_vdd_dep_table->entries[input_level].vddc =3D i=
nput_vol;
-               } else {
+               if (input[i] < 0 || input[i] >=3D podn_vdd_dep_table->count=
) {
+                       pr_info("invalid clock/voltage level\n");
                        return -EINVAL;
                }
+               input_clk =3D input[i + 1] * 100;
+               input_vol =3D input[i + 2];
+               if (!vega10_check_clk_voltage_valid(hwmgr, type, input_clk,=
 input_vol))
+                       return -EINVAL;
+       }
+
+       if (type =3D=3D PP_OD_EDIT_SCLK_VDDC_TABLE)
+               data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK;
+       else
+               data->need_update_dpm_table |=3D DPMTABLE_OD_UPDATE_MCLK;
+
+       for (i =3D 0; i < size; i +=3D 3) {
+               input_level =3D input[i];
+               input_clk =3D input[i + 1] * 100;
+               input_vol =3D input[i + 2];
+               dpm_table->dpm_levels[input_level].value =3D input_clk;
+               podn_vdd_dep_table->entries[input_level].clk =3D input_clk;
+               podn_vdd_dep_table->entries[input_level].vddc =3D input_vol=
;
        }
        vega10_odn_update_soc_table(hwmgr, type);
        return 0;
--
2.46.0


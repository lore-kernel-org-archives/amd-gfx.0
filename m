Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C590C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80A061C49
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80A061C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874946EDDE;
	Wed,  2 Jun 2021 16:51:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C4A6EDD8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO783vdRGFoPhPECq2uIyH3+ozp+IZj4gQosgHGK7sJ32vNspf+zrxJfJLVUBbGhqk7QpXk6RE/0HCUKioCAYKBw+TgFh5srWNrh9LiM+1PcRlQ1ie9MLCicyTub807tglVlHpuZVdIrjDmdHRr8MBlQM9QjP+R1/18C/h+HXUimldAlnvpAVPukl0j4Sdx6JOG+EXEcxXIqZOBHoT2Yj3ukijUXh6M8/TvGObecMQTt1RjzNh9EPIOalbQ5qCfdPazIn1Y3C2Hflol6Vb96dbiXSvT1quYnPcp/Zp5JxzkaXWA2U6oDwALXANrrcpFqap9vZ69i1Hx9Tr4DTUXdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyJF8zyLmllT15Ov3ppNp3ah/XsgwddWq3Xn4pW660U=;
 b=PB4n+V0avr5NQhJQiagBp553JHw9ema4GR1VS/7HxSzEBRQiubjSQSJ/Dr4f7TpjrU2c+lPFd39qfdpWA2UteUeEeLwiQOvxqgq0yYat/4RSuwFUW4iG58lB6KKEFaIazktDoOcEyoZuOSrZ8JL8rUAEKQevdTXOuWdv7J2mKOuCCFRiXv3/hQD1QYc1UTQr4JEiP09DHzbouWg2eikstgihXjkimNgjuBnQ3+8voFDX7D/7jF4HXnJ3K5rvJo85jYdYcntX+x92Kan3vvGQ+OTJvnsRrLpUCLqgHsNtVXxmqy2d9l8SalUVKImlq72wB1e9M5eiP7qIE0hgB6AXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyJF8zyLmllT15Ov3ppNp3ah/XsgwddWq3Xn4pW660U=;
 b=C74LrhcvI1iKzGtKkU1U2s/JEUmNXPsIzP5Jnu9DwnXc9OjeU6Ne/g/owFB8ynA/WfI8GyIvhLv2EoNt6lRIjcmmuzn2dhHIb4j6Ipa05Q3v8w912osIt9eN7Osha01O2lq6sokCrLmPV/EvICoscZTpqbBaiWyMg+Z3023bZ5k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 82/89] drm/amd/display: Add DCN3.1 BIOS parser support
Date: Wed,  2 Jun 2021 12:49:01 -0400
Message-Id: <20210602164908.2848791-82-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1ea67fe-03f1-416c-1504-08d925e68449
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45346F0194A2B163A9E5CE83F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUbdg5rhwTImD/RQmKs63qflDJrnlQUmJdSuSEVnZoi7t0fBt/qMoeTw5sWPWSrS7NKnE9NZJJJ/ErJDqe7fFxN8U3pwdGnir+1WOgIsFK7FnbR86yc4SJtna4dVhGs+7PNk/rQl8NktM6QIiHiPONZv+MJKhKp/qqZ/44EjTPykR7EQ7fiLwwkrudKGTUE3ecsjFSkzxfG/HHKThPC48ERdbfhmoyDVUV1hHwVV0BajAKrmTtCcAik6EqBNTMV9HNwGK4xrL+hGTHCm5qf3GTeD+FBUKml/ho8ySeXg8ZAys2r4E+1gERlj+KvXBfBwmXFClzGBU4KLD2pny30V2FTGvRQ4VpPgeFkYdvXNZDQD5GZC0HQXwBzV6hKdN7tW+KXmmno6MLPg9jFXBppl3Hzt+O5t+gWDSBLVeyFZRzdb12AR1WmejytkrPyjWE4bN/5BmJLTFlqZ6s41zLahgxmlI33/Eqe4WbuzvT0fYSTf6dkaqKAe7DcJDok1MrPOhpW+7X5/ehyO0uLaLtVm/Arv9rcHUFjlKhgVcy2XAKPCK5cZqoGN3yRbM8DL0V8jzNyqE3f5S8Kd1aPwytLoBb2S/LDQL4yU7Nu2EjgpbJFdoU1qlhI4SUB8HIw0HImJMY1IzevO9wSbOlwiKNYROzcRIz20UH3rtwDVQGyIqeVyR4XnrRBO3/g7khcJ2YfG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZNJjtot5pZ65WmdOt719qD2G93OTFKFpNDnE11rjbIUhd5jBVNuqhRHKRw+w?=
 =?us-ascii?Q?uOK2CuuqxNE2lWUdFExqnr9fORvYi3jGx9lknFuP6c5ciSr5tTEkGTm3ruXW?=
 =?us-ascii?Q?zHaOnYN4pbkaM6W4W2BY8RdgrpUFGXjmB4m3gO3EDlE4uEDwKCkqTps6Bpgy?=
 =?us-ascii?Q?VTVekZ7zv5SuLp+Kf6fu36UDPHKA+HQW8KCHRzuWbT5DTDyWDy+flxAGKaiK?=
 =?us-ascii?Q?8N6hQDeA6/Hfbrycvg4cROyYdcpmmzPHa397Qa6uYweWhdkTbRAsTO2oMkZ4?=
 =?us-ascii?Q?pbkt0QwHPE+a5gT2LAvMIGLRD9lg0trJFlhoaRY7TmbRdoWWXhtBAYi0W0zB?=
 =?us-ascii?Q?WyrNrYL2CLSj5D3b1eN0X2V7f22MlgQRQd4sHpeWYWu7WP3Fd+s0OxPsxvKy?=
 =?us-ascii?Q?5pVqqEEHUP1efHwWKuj2vATBy2/nqij7LflDl0Zc0eQpchtRBew2FkzDgovW?=
 =?us-ascii?Q?sIVAqHlto/vwtbnwvcKQu897LtLjhZaBAgwQUYlKi1Nr8m9aYNe9WKBJX6L9?=
 =?us-ascii?Q?NYIhs7VMYVGsO2YWN1V6q7UnnngdBUH2VLKFu4FYvtKCMObb9ueBkNlMBY6T?=
 =?us-ascii?Q?2QbPss9FgWtYKGiSg9Z32gyahvW+MHUQSOGi55n5yfhCHDl2WQlIaKCTw3Pc?=
 =?us-ascii?Q?8+Ogjy96ZkQ2ljKQGUPPYQ8IlwR484CqfcIO3tiLiQvZhVNJXY7yTZC+ieyD?=
 =?us-ascii?Q?AwK9BEqfUgLkNdp6nrcuBIFGoAWrP/GE0dnsNTc3jROmOTDhzfwMxD+1HQ7J?=
 =?us-ascii?Q?nycR6q134WZQqqeZ0uAQp6VAcxd2Y9sZkyNphEGy6Oxhh6eB9nRbGixRmbKr?=
 =?us-ascii?Q?fPAUQSoKsN1WouLkuhFakmO+zyCA6COAEUXrDVGjh/y51A37TM/kPFDS098x?=
 =?us-ascii?Q?pgOZkAufwQ5Z+DmrAb6Qb3DLVA0G5eiWvEceUoKbzhqtsXjp4NFRIt4S5To3?=
 =?us-ascii?Q?02u3/LYNbvk9BUSHH/geHbxPX5b6MucAnxFjyM/FI/gHdtV0AbDTKjQH8u6r?=
 =?us-ascii?Q?YA30dNKM2Q8AJpkQaCpKncyfrf2RRpENyb2UznTEu/R3ZZlCU58aqLcC1emc?=
 =?us-ascii?Q?5AqVgauqs5VwswKS6R6vSFoTSXEAsuo/4AqMA0c82UNdi7ludDprB9SonTjx?=
 =?us-ascii?Q?nDqyA79EYLYfklUkh7s+AvFYO+kzTYLfM36bwiLv4Jjc6OWlyeau6uHrrO9O?=
 =?us-ascii?Q?6Dj0FJgFD3DD8/p0Qt7ANc6jXveWVAa0sWu77/BM7GEfK+pHmuEUYGTgD5ew?=
 =?us-ascii?Q?l170qgkkzk1hqJwoMt/QPGhf8FCmJaNGe3ecnw/JSi/kwuN97pMEuLQUv5f6?=
 =?us-ascii?Q?wSiPSf2JfTkeZgSYKDrb3lxL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ea67fe-03f1-416c-1504-08d925e68449
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:24.3207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdxBQhVtEwUC3FZQqDJxtDvLwd+fK+p2+MyRVSbAjrYMaUzuUj0KfP5y44ZVDkz5+5o3f2Gm5s0PPvXz3mfcVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Updated interfaces for multiple eDP backlight caps.
Added support for interpreting the new BIOS command tables on DCN3.1.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 113 ++++++++++++++++++
 .../display/dc/bios/command_table_helper2.c   |   5 +
 2 files changed, 118 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 49126a0f66af..7d1c1b76d8d0 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -576,6 +576,13 @@ static struct device_id device_type_from_device_id(uint16_t device_id)
 		result_device_id.device_type = DEVICE_TYPE_LCD;
 		result_device_id.enum_id = 1;
 		break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+
+	case ATOM_DISPLAY_LCD2_SUPPORT:
+		result_device_id.device_type = DEVICE_TYPE_LCD;
+		result_device_id.enum_id = 2;
+		break;
+#endif
 
 	case ATOM_DISPLAY_DFP1_SUPPORT:
 		result_device_id.device_type = DEVICE_TYPE_DFP;
@@ -2155,6 +2162,107 @@ static enum bp_result get_integrated_info_v2_1(
 	return BP_RESULT_OK;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+static enum bp_result get_integrated_info_v2_2(
+	struct bios_parser *bp,
+	struct integrated_info *info)
+{
+	struct atom_integrated_system_info_v2_2 *info_v2_2;
+	uint32_t i;
+
+	info_v2_2 = GET_IMAGE(struct atom_integrated_system_info_v2_2,
+					DATA_TABLES(integratedsysteminfo));
+
+	if (info_v2_2 == NULL)
+		return BP_RESULT_BADBIOSTABLE;
+
+	info->gpu_cap_info =
+	le32_to_cpu(info_v2_2->gpucapinfo);
+	/*
+	* system_config: Bit[0] = 0 : PCIE power gating disabled
+	*                       = 1 : PCIE power gating enabled
+	*                Bit[1] = 0 : DDR-PLL shut down disabled
+	*                       = 1 : DDR-PLL shut down enabled
+	*                Bit[2] = 0 : DDR-PLL power down disabled
+	*                       = 1 : DDR-PLL power down enabled
+	*/
+	info->system_config = le32_to_cpu(info_v2_2->system_config);
+	info->cpu_cap_info = le32_to_cpu(info_v2_2->cpucapinfo);
+	info->memory_type = info_v2_2->memorytype;
+	info->ma_channel_number = info_v2_2->umachannelnumber;
+	info->dp_ss_control =
+		le16_to_cpu(info_v2_2->reserved1);
+
+	for (i = 0; i < NUMBER_OF_UCHAR_FOR_GUID; ++i) {
+		info->ext_disp_conn_info.gu_id[i] =
+				info_v2_2->extdispconninfo.guid[i];
+	}
+
+	for (i = 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; ++i) {
+		info->ext_disp_conn_info.path[i].device_connector_id =
+		object_id_from_bios_object_id(
+		le16_to_cpu(info_v2_2->extdispconninfo.path[i].connectorobjid));
+
+		info->ext_disp_conn_info.path[i].ext_encoder_obj_id =
+		object_id_from_bios_object_id(
+			le16_to_cpu(
+			info_v2_2->extdispconninfo.path[i].ext_encoder_objid));
+
+		info->ext_disp_conn_info.path[i].device_tag =
+			le16_to_cpu(
+				info_v2_2->extdispconninfo.path[i].device_tag);
+		info->ext_disp_conn_info.path[i].device_acpi_enum =
+		le16_to_cpu(
+			info_v2_2->extdispconninfo.path[i].device_acpi_enum);
+		info->ext_disp_conn_info.path[i].ext_aux_ddc_lut_index =
+			info_v2_2->extdispconninfo.path[i].auxddclut_index;
+		info->ext_disp_conn_info.path[i].ext_hpd_pin_lut_index =
+			info_v2_2->extdispconninfo.path[i].hpdlut_index;
+		info->ext_disp_conn_info.path[i].channel_mapping.raw =
+			info_v2_2->extdispconninfo.path[i].channelmapping;
+		info->ext_disp_conn_info.path[i].caps =
+				le16_to_cpu(info_v2_2->extdispconninfo.path[i].caps);
+	}
+
+	info->ext_disp_conn_info.checksum =
+		info_v2_2->extdispconninfo.checksum;
+
+	info->edp1_info.edp_backlight_pwm_hz =
+	le16_to_cpu(info_v2_2->edp1_info.edp_backlight_pwm_hz);
+	info->edp1_info.edp_ss_percentage =
+	le16_to_cpu(info_v2_2->edp1_info.edp_ss_percentage);
+	info->edp1_info.edp_ss_rate_10hz =
+	le16_to_cpu(info_v2_2->edp1_info.edp_ss_rate_10hz);
+	info->edp1_info.edp_pwr_on_off_delay =
+		info_v2_2->edp1_info.edp_pwr_on_off_delay;
+	info->edp1_info.edp_pwr_on_vary_bl_to_blon =
+		info_v2_2->edp1_info.edp_pwr_on_vary_bl_to_blon;
+	info->edp1_info.edp_pwr_down_bloff_to_vary_bloff =
+		info_v2_2->edp1_info.edp_pwr_down_bloff_to_vary_bloff;
+	info->edp1_info.edp_panel_bpc =
+		info_v2_2->edp1_info.edp_panel_bpc;
+	info->edp1_info.edp_bootup_bl_level =
+
+	info->edp2_info.edp_backlight_pwm_hz =
+	le16_to_cpu(info_v2_2->edp2_info.edp_backlight_pwm_hz);
+	info->edp2_info.edp_ss_percentage =
+	le16_to_cpu(info_v2_2->edp2_info.edp_ss_percentage);
+	info->edp2_info.edp_ss_rate_10hz =
+	le16_to_cpu(info_v2_2->edp2_info.edp_ss_rate_10hz);
+	info->edp2_info.edp_pwr_on_off_delay =
+		info_v2_2->edp2_info.edp_pwr_on_off_delay;
+	info->edp2_info.edp_pwr_on_vary_bl_to_blon =
+		info_v2_2->edp2_info.edp_pwr_on_vary_bl_to_blon;
+	info->edp2_info.edp_pwr_down_bloff_to_vary_bloff =
+		info_v2_2->edp2_info.edp_pwr_down_bloff_to_vary_bloff;
+	info->edp2_info.edp_panel_bpc =
+		info_v2_2->edp2_info.edp_panel_bpc;
+	info->edp2_info.edp_bootup_bl_level =
+		info_v2_2->edp2_info.edp_bootup_bl_level;
+
+	return BP_RESULT_OK;
+}
+#endif
 /*
  * construct_integrated_info
  *
@@ -2202,6 +2310,11 @@ static enum bp_result construct_integrated_info(
 			case 1:
 				result = get_integrated_info_v2_1(bp, info);
 				break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+			case 2:
+				result = get_integrated_info_v2_2(bp, info);
+				break;
+#endif
 			default:
 				return result;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 6d2fb112ad9f..3ac4dc01f8e1 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -72,6 +72,11 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCN_VERSION_2_1:
 	case DCN_VERSION_3_0:
 	case DCN_VERSION_3_01:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	case DCN_VERSION_3_1:
+		*h = dal_cmd_tbl_helper_dce112_get_table2();
+		return true;
+#endif
 	case DCN_VERSION_3_02:
 	case DCN_VERSION_3_03:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43B2C47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8679F61C64
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8679F61C64
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C866EDD5;
	Wed,  2 Jun 2021 16:51:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A856EDD1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD9XZap3tyJj4Maoo3kRF4otF8GwXNx8M1YLVdBEnrL6PT4sSoAhIViE68BFOMzE3ly0dtoMuke0SyQB3+oxnpYjEQ/B+hmrQMqn8N0e9+TVctAAJWJXOVS8+QtUGJ7ewSp5Vl7blqO4o7j+CVPy8z6BHjS7/TOX6Mx94LU0u5mBJaYwqYpAW5yf39dV7wCjlkp8NcCH3L42tmsDrbJmvWl3CqzXwfkF0cDfoBDxDo4bgGykYitDAw9eBouAadmj3VM4AoeJh/Ypr8BMNucZDCmqusU8vxH9YzLFgTrnrn61L75JzpWOwfFZNM1FGZiQ2iEXUnZcZP3Vj7B7fyrcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGsHdUJWSlv4XJ+DiEw4P2wmwh56uVwRKZ7x//sdZrY=;
 b=O9/SLvSJjz8eYNFjX7axnM6F/FU2ma/ttFndyPVeTbs7Zu3EN22NkHJOuzU16GOh2ltvzOKFimL9UG8nLTZIoABdL2Bm+6ZzNEbvu7fVUy8vGvbM4hiIADm8SH4ddDe9ClCNx+XZ2gYxgQ95zc+6dQzhmoXTQm09gGzfHdsi9Bob3MNqjGmECrxyckSd3vQFcbIw5WGZLWhf0kmM0RyZEewWbFzttycD2vz5CUFYwXEr+YpiQs3VMxWuu7rohQy6wXLGjozbgekE5JV6CHwTfQAekqVqTzKDAK6AO7YmKYxfE7zpCZ2uAV6+HVEm8HrAp59Iv2v0U9ILDqoJ9+uzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGsHdUJWSlv4XJ+DiEw4P2wmwh56uVwRKZ7x//sdZrY=;
 b=SHaNVep7Gy3O5LI5K1ZUJFTkf0CGSciF09fPrJlAMjlOTWm3uewrV0H3dDKI/2tWemW0FepgdKnQTqHWjIq66yhrWSqdZ5UYxZCJ7Gxe8ZoMy5r4CZmnXBonQitvN1fVyXr4dFJSQDfsiFMEOeupOVY6v2viqSKpYEOd8ChrYc0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:17 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:17 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 69/89] drm/amdgpu: Update atomfirmware for DCN3.1 phy tuning
 and eDP caps
Date: Wed,  2 Jun 2021 12:48:48 -0400
Message-Id: <20210602164908.2848791-69-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 759f18b1-4115-45f0-1dea-08d925e67f03
X-MS-TrafficTypeDiagnostic: BL0PR12MB2369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2369597369E50E18104B97A3F73D9@BL0PR12MB2369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbMu/xFQud19eRYR8iH88T0EgXWjfM6ba8CTk8byqVFnZk2VMwk6OeVVdn0w45Ci2en4jB7SuvyXQVFsSAMtD+cDBxqi6CipRem7my8C5MlzcPQF5jB06cuE2fubOsIQt05OI1hLiEaqbodiJEV8TfvXwN5cvpB6tSmlgomuaSb5N0Se89ATCN6BT/wXKNnhPSChKPe6BCA4BPD/k6HdBcR2Ij3kiXHVEZyhZItaP3UEaM0ZcXu+rKRYlgalj5EdUIBKcwwQwmCa3/bLAgvoKc+gBMoKYyX8QzlJX7kdPghYON3cZY1hPiLTv+1Axy02AY4exSBlW58RLUMsnBS7VgBaAYZ/uGw22/w3bT7uMeaaNiBY3RVP0LRvAvDVzwppVdguFN09ecxFDm6biIz7gjaR2N4rtFSuMQMlCnOWTDy+adLVGbnK36NK5Znieb08xf/4hcBmeIcJHopeBWEnQympwWm06hkBZItsurULZPnXR6Hqxo8KmxsNWJUWNt5JxNs2gtGs54a0NsF1FD0J15luGVR6i1fChAgZ0dk26o0w4cCDdmuR9NcTQTn4bFA2ULUBJ1JEfUUJzeUgx4yyt1MqO4iZc7X1O5an1ioYOz/ihefuVZREA69I98Pt0vOAkGusjycIrMCiKV8SDMOdAmZ2g+qW8nMj/MyOY/Ss5e6dkuwNEhcFUuxYg5QP+89C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(366004)(396003)(54906003)(1076003)(8676002)(6916009)(956004)(2616005)(478600001)(6512007)(6486002)(86362001)(6506007)(4326008)(6666004)(38100700002)(316002)(38350700002)(52116002)(26005)(186003)(5660300002)(66476007)(66946007)(8936002)(83380400001)(36756003)(66556008)(16526019)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iePwOQhZITK2iGIQmCdC07avw6PIJwfeU+626QbjHUxVH51ef78yxtAn4Lki?=
 =?us-ascii?Q?lx9zpGc1aHTtfwiuS+9KZzZLkPViPDGqjvnDyKo1VLrzMDBkHA3fgVxGbsel?=
 =?us-ascii?Q?NGHRh2LsWxyMFBR1FQcoi2QHnECWbkZ1XNeFGgXWyNGq8S4n9p8SChiFtwqR?=
 =?us-ascii?Q?126zjtn4aCp4u1kmNdtaqclzhD0TwRCuxmzzhys3PeueFHXPMZG/59MZfbTs?=
 =?us-ascii?Q?Q2+6ecfgv/787vZoba5gUiO9in6+V8qGFHILbbsym7yhtyV1CP3z84o/pskH?=
 =?us-ascii?Q?cfs8TjZ7dtJlIIPKOOZ8zxTXq+52GlH34irasOJaiWnoZCW4TQbpOXkVkeOu?=
 =?us-ascii?Q?4UkV7iLyAgkb72OuWTudqKv9MKK02/VmxnOU1nDcV+akMM/WKxH5LA/J8rJw?=
 =?us-ascii?Q?JDq4TVlwEbgKhoFOMEhnMfscbZ652XFoSTJnQE3y1A/ZGSYq9HhxgCN3UeYj?=
 =?us-ascii?Q?X/Ubm0EyGEB7rdUKcaWHgxrnvOWF/1p3cuuuweMUWTRBRYhfOjVtNNTNemBm?=
 =?us-ascii?Q?YWhVyRPckVnYeRGFt2uRDQpxdX/D7QOvZu8lgPptdAmaK9760zYt+SibLa/f?=
 =?us-ascii?Q?I38wtptJa4xz9IufpqpVQk8QF2Lj3Jl5hJAe8qjdp+GzOQDUukXFT/1isaeI?=
 =?us-ascii?Q?Y9Kj7XYoqKA5gaLwPusKtlxNDSU+ZZtcEkMeYb/4AEpEgghTImcRBNO7bcIE?=
 =?us-ascii?Q?27ux/dL9mcPR4phBJKSxEGg623/7larduDeBdaSIvz9lkhPhrIMWkWgIraQC?=
 =?us-ascii?Q?yBwrvVavabZeZO724c8lyLzng4yqSr5MZXH1KvDRJWKNNC+7qGt9XqevfLkL?=
 =?us-ascii?Q?L1rMDrHcm3BUV50lMRsNNc85axdap2zHF1238zLr0coPcaNbAqDDU9xqia4V?=
 =?us-ascii?Q?mBQ9n+ORitUj6MGmSWsAoDhgae2zqN1Zrwi0KIV4lYQNRbsIR6uhUvs0S+x1?=
 =?us-ascii?Q?9Ngc+344gnB2B7y+ykiH6fM5X7XzkZnu381Fj8mtdBIlGHBfkRkt/fdCc5Ud?=
 =?us-ascii?Q?xlFyoH8JrucPabBqjamdH+M4he0uVoR88Z+6ZKQbN2De4NW72v2EHgmkRpSx?=
 =?us-ascii?Q?C48mQ/XdXYMtNnz6Z2lP7M+3p5lMG1arLA2xKt/Wa0fEYNQvNDeQfwh+Jzew?=
 =?us-ascii?Q?yUJ2KaLVxykbtTzydU/sdiufNrWmcV7c2Q2Z6EHtnRP5qmswzJTuDHtTyh/s?=
 =?us-ascii?Q?ZvUCixy9+GnyAd2evUFKOe+btjQF2U5EyD4ls1hndpRnNqvsjzGe5NzDLwE3?=
 =?us-ascii?Q?2laZwZZd+X1VDZA2v5s+X8I31hGfO8j5AO3eiJG47Z6vGyavpuu6GZwvEn28?=
 =?us-ascii?Q?ul6+fdf6zKoD+6HmQd2CjNWc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759f18b1-4115-45f0-1dea-08d925e67f03
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:15.4735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYo3TME/MXsYwjQBU+ucyQ1iFfq9arR355Bicg1VsZPRJzKboDuRJA/34LdGJbeoL8+yyWI28TWcXs7pFuCcsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
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

[Why & How]
We'll need these in driver for phy tuning in DCN3.1.

Multiple eDP support also requires understanding which LCD the backlight
curve in atombios is for.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 56 +++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 28deecc2f990..3811e58dd857 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -883,7 +883,8 @@ struct  atom_bracket_layout_record
 };
 
 enum atom_display_device_tag_def{
-  ATOM_DISPLAY_LCD1_SUPPORT            = 0x0002,  //an embedded display is either an LVDS or eDP signal type of display
+  ATOM_DISPLAY_LCD1_SUPPORT            = 0x0002, //an embedded display is either an LVDS or eDP signal type of display
+  ATOM_DISPLAY_LCD2_SUPPORT			       = 0x0020, //second edp device tag 0x0020 for backward compability
   ATOM_DISPLAY_DFP1_SUPPORT            = 0x0008,
   ATOM_DISPLAY_DFP2_SUPPORT            = 0x0080,
   ATOM_DISPLAY_DFP3_SUPPORT            = 0x0200,
@@ -1413,6 +1414,59 @@ struct atom_integrated_system_info_v2_1
 
 };
 
+struct atom_n6_display_phy_tuning_set {
+	uint8_t display_signal_type;
+	uint8_t phy_sel;
+	uint8_t preset_level;
+	uint8_t reserved1;
+	uint32_t reserved2;
+	uint32_t speed_upto;
+	uint8_t tx_vboost_level;
+	uint8_t tx_vreg_v2i;
+	uint8_t tx_vregdrv_byp;
+	uint8_t tx_term_cntl;
+	uint8_t tx_peak_level;
+	uint8_t tx_slew_en;
+	uint8_t tx_eq_pre;
+	uint8_t tx_eq_main;
+	uint8_t tx_eq_post;
+	uint8_t tx_en_inv_pre;
+	uint8_t tx_en_inv_post;
+	uint8_t reserved3;
+	uint32_t reserved4;
+	uint32_t reserved5;
+	uint32_t reserved6;
+};
+
+struct atom_display_phy_tuning_info {
+	struct atom_common_table_header table_header;
+	struct atom_n6_display_phy_tuning_set disp_phy_tuning[1];
+};
+
+struct atom_integrated_system_info_v2_2
+{
+	struct  atom_common_table_header  table_header;
+	uint32_t  vbios_misc;                       //enum of atom_system_vbiosmisc_def
+	uint32_t  gpucapinfo;                       //enum of atom_system_gpucapinf_def
+	uint32_t  system_config;
+	uint32_t  cpucapinfo;
+	uint16_t  gpuclk_ss_percentage;             //unit of 0.001%,   1000 mean 1%
+	uint16_t  gpuclk_ss_type;
+	uint16_t  dpphy_override;                   // bit vector, enum of atom_sysinfo_dpphy_override_def
+	uint8_t   memorytype;                       // enum of atom_dmi_t17_mem_type_def, APU memory type indication.
+	uint8_t   umachannelnumber;                 // number of memory channels
+	uint8_t   htc_hyst_limit;
+	uint8_t   htc_tmp_limit;
+	uint8_t   reserved1;
+	uint8_t   reserved2;
+	struct edp_info_table edp1_info;
+	struct edp_info_table edp2_info;
+	uint32_t  reserved3[8];
+	struct atom_external_display_connection_info extdispconninfo;
+
+	uint32_t  reserved4[189];
+};
+
 // system_config
 enum atom_system_vbiosmisc_def{
   INTEGRATED_SYSTEM_INFO__GET_EDID_CALLBACK_FUNC_SUPPORT = 0x01,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

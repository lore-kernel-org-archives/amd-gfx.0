Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B814AC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D911206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="17vc5lel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D911206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13DA6E97E;
	Fri, 16 Oct 2020 03:27:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92406E9B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9X/0GP0VdNAbF0luygqLRGgJ7uVr7ey1oeOcBOEGrGztL+EhUgrap+mjZiVpk/YeDlKT0tm1c9sR5LvIahBoTVYAgioU5EGEtN/sHElWWmKGank7wmTx7KfcoQ+Xx52/oFAhZOalQHQiYvT6h9P+JgTGv2+wewvID9qprXG6tkE/rKSQeyA/8CkcdeimCndMqZJghQqlhF1IxriMI2UwV6+XDuCwURRyyC+b42HjJRMa6R+ZUV2ou3LgWgs5YtdZ2jDeBiw+jrn4R/ONefDerVVmOV8oBaQK/DQqOTyKrjWvoPMyiLMA0raciM7WdEbqx+4EZArIHyjOvPezu6joA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncaGqm0DvSE/KPMQSfIRaIfe+R41aHco3Dwb40NEWI8=;
 b=BAZMzXvwQBNZh4OHtuA/IsbXF2UO/iVTS+qIjNe7VtcXbrlUiHlmCceiBbrZLc4A0O4r6RiIbMBWAAwkaX9mlk5VGHzfY/yUK0SIjoZ+1lO1QEjyYI9qZ8WBtu+Z5uGz7WwVlUniIAgmrThdV/Y3Xdf0/MbGFRQgUqa2361ArADKcCJGoV/hKyXH0TsTDK7t2+32KJNwbbjLSLSceG6ZD2nwPQhquBIsHoByu1Msq5LjyzInCbwS7dZi4VnhDiwuZ5Sm8VpWgbJU/yjB2QH7FDFaqpPdNbVI8xXCkZ5cuj0zZEoFHmnRpPklvuYse8AslmmUk5dq0k4PDAlW5VtU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncaGqm0DvSE/KPMQSfIRaIfe+R41aHco3Dwb40NEWI8=;
 b=17vc5lel4OINlrn9YiZBR20Xx5nTuGM2wKA1173kDHVxFi7t1RBPvKWyyiS9hSJcamxRpR7e9MfIL5a9q5TMs7zU24rg7byIcrzpVy8iK4g5bCAZBMnyH4rXJVL7KAo7/ObrRSq5WlFLth1RMq5sOA4lasAnTbrrzgQCNh2JZtA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:37 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/40] drm/amd/pm: populate smc samu table
Date: Fri, 16 Oct 2020 11:26:15 +0800
Message-Id: <20201016032652.507-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9da15b2e-3aad-4f3f-32af-08d871836de9
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4680E95C0620980C6EA85CEEE4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CDX/U6yjmV5Oh22VpeLfi6Be0Kj1Xkfxx5BoBr/nWFMWR7ah2IjSYHbFxVrfNMQdq1+fY10zrOEpMW5LHO5kvYVVfIHTr+nOuQ8DxcxL/zNSNSgIApWvtwaaHzYm+xprHlehdWmdDDAwR9boCGlpaEUjXL7yo4P7RyDphI85neO0cvL3hw+aOCklzVklse1tA7/+YA3ARE1Zf2S1nMQxZiplA2SJWLhstjXUsi4PQhE1qidYRcMaIoGjhgOn65pQhJ1JGdVLjJdcib5ITvD17gTOLiYXDT6AHTd+gF6NC+XSeep56Og4ur3wSS8Oo1exAUXXcSRqIt5YTtP/Oc22kITImJjmj6eMSu27U2sZNTcdDdfZrNQ3b+tw5xJr/EW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(19627235002)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sV+nlFd3rcinpt1sRbHQigTaQ+PRQu/szzwKv7bJmIlXJ+uSTVtkHXuItgFpLziA2QZ2HX4DP+sRNFTpBZdRZfGwOk2igmjhjE33U3XcPYg62sQFOwzHk6MyBYykmk4e674NBFka0atIU4judjNjlgiJy8zPyhBvFiPHhjWySdvs2hKxC3QnL9Js6PuwMTQ9gcK30T8u1FTePJW1oHW6J6XTqEtFr8GgJe+uCaN85nW4yaQFrleO5/l9yuV5cWjn03ycsMJGJn+X2FXhC36WuAK3odvn0Iw5jyUtqcg4zQX8rvfK7yjwcAz8tv0/yNqWnKFUCUKlobWP4F70guLV78IqNbbBZsQjAlg6NGouxEis/NrYDxV952vto9iyHlEluXPCNuKVWi3G08SbQyFVc3OBnRGfz82XGT1ZzxBjibGhF6hFDgWt4MdL/cEm9no3adEu7zdt3hdYk8139uwzcznPf3GgPGEVZSCVf8NKFGuTNxs5UZfU1NksPWczpZL+PGAB+dMaC6FM2JBOcoVoUIOE8Z0//oJXhvYhzhYiIin1vWEASBDCSvY7eOkqAQ/iJtFcWbvdByYjGeAVxUSQlNZEKIePXlwg2RuxUmZnP7kwWKNs7YYszlsyuKPIP3LuSMV+iucfTmwHogjx8fgffw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da15b2e-3aad-4f3f-32af-08d871836de9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:37.3028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: os6KcRvebarkUIfofP/3KhbefD0+W8kVCzAQm+2qj5yJ404bNxyil4/E1NS1ocjV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing smc samu table setup.

Change-Id: I28c49330121b17fb3a03ec5b76f3b87effe92ecf
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/powerplay/smumgr/polaris10_smumgr.c    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 4a786b159bbb..a950387b492f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1360,6 +1360,55 @@ static int polaris10_populate_smc_vce_level(struct pp_hwmgr *hwmgr,
 	return result;
 }
 
+static int polaris10_populate_smc_samu_level(struct pp_hwmgr *hwmgr,
+		SMU74_Discrete_DpmTable *table)
+{
+	int result = -EINVAL;
+	uint8_t count;
+	struct pp_atomctrl_clock_dividers_vi dividers;
+	struct phm_ppt_v1_information *table_info =
+			(struct phm_ppt_v1_information *)(hwmgr->pptable);
+	struct phm_ppt_v1_mm_clock_voltage_dependency_table *mm_table =
+			table_info->mm_dep_table;
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	uint32_t vddci;
+
+	table->SamuLevelCount = (uint8_t)(mm_table->count);
+	table->SamuBootLevel = 0;
+
+	for (count = 0; count < table->SamuLevelCount; count++) {
+		table->SamuLevel[count].Frequency = mm_table->entries[count].samclock;
+		table->SamuLevel[count].MinVoltage |=
+				(mm_table->entries[count].vddc * VOLTAGE_SCALE) << VDDC_SHIFT;
+
+		if (SMU7_VOLTAGE_CONTROL_BY_GPIO == data->vddci_control)
+			vddci = (uint32_t)phm_find_closest_vddci(&(data->vddci_voltage_table),
+						mm_table->entries[count].vddc - VDDC_VDDCI_DELTA);
+		else if (SMU7_VOLTAGE_CONTROL_BY_SVID2 == data->vddci_control)
+			vddci = mm_table->entries[count].vddc - VDDC_VDDCI_DELTA;
+		else
+			vddci = (data->vbios_boot_state.vddci_bootup_value * VOLTAGE_SCALE) << VDDCI_SHIFT;
+
+
+		table->SamuLevel[count].MinVoltage |=
+				(vddci * VOLTAGE_SCALE) << VDDCI_SHIFT;
+		table->SamuLevel[count].MinVoltage |= 1 << PHASES_SHIFT;
+
+		/*retrieve divider value for VBIOS */
+		result = atomctrl_get_dfs_pll_dividers_vi(hwmgr,
+				table->SamuLevel[count].Frequency, &dividers);
+		PP_ASSERT_WITH_CODE((0 == result),
+				"can not find divide id for VCE engine clock",
+				return result);
+
+		table->SamuLevel[count].Divider = (uint8_t)dividers.pll_post_divider;
+
+		CONVERT_FROM_HOST_TO_SMC_UL(table->SamuLevel[count].Frequency);
+		CONVERT_FROM_HOST_TO_SMC_UL(table->SamuLevel[count].MinVoltage);
+	}
+	return result;
+}
+
 static int polaris10_populate_memory_timing_parameters(struct pp_hwmgr *hwmgr,
 		int32_t eng_clock, int32_t mem_clock,
 		SMU74_Discrete_MCArbDramTimingTableEntry *arb_regs)
@@ -1902,6 +1951,10 @@ static int polaris10_init_smc_table(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE(0 == result,
 			"Failed to initialize VCE Level!", return result);
 
+	result = polaris10_populate_smc_samu_level(hwmgr, table);
+	PP_ASSERT_WITH_CODE(0 == result,
+			"Failed to initialize SAMU Level!", return result);
+
 	/* Since only the initial state is completely set up at this point
 	 * (the other states are just copies of the boot state) we only
 	 * need to populate the  ARB settings for the initial state.
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A8C433E2
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A27206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tkk2iscd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A27206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0857C6EB25;
	Fri,  4 Sep 2020 08:15:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886AC6EB26
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 08:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODiByQ1lvk8WBZZuDERjpLRrM31gGnsErJk7jfxE4PCHcEV6gL8pAYG8s38Q60Zo+pdOWoD3aCeoqa2kW/dvdX7hG5jHRxJc+eDrCGlcTORH2SKT3BjYu0geBDjhgm7eQxbEJK5KsLWqbmJ/s8IeHBNnR5E0RkrO7jkpgdlsrjo8RomJOvlW5xWJh++MwfryGDrx7bimv6WJ8/eYIzr2VMvrYB58G3AW84GxTN8bQjA/QUcpahExdWpTfxmrBKuN4zj5E6H9FgElmCD5SUGMmRrKtO516CTaMtHRdLpcqeuvhmWBuRayKbwG3RcuuEs7QgJJ6+ACgtXatzcYX8NPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjoEIW7iOpi7nsKB64767QtrKeSyJOa+B8B9tna91lk=;
 b=WoMyqNrsUAnqlCxLZAZNxFwIBscnLJFFwdTZNJvKMvSXjM4npOO+plc/GXXd5JR/+PkREwPrNJ3YciV0nZvGZEudVRHR4D60AtQoLdnuKrDQSdpOouJ83ML9WcvDKQLaaFdAdHZVnUyVfLNXy/LiwamODUYd8/6rUi55LQlArbosbrgnBxFOpCaTPKoMhQehlB9pNQI9yRQ+PBNGRBUSHSs7XgZdTTyBB62WLcZs7xtgmeqZUQvUSERpX6WcXwGQxU8cy1fwdaC32YpG5W7pqJDRwLSwdLYwrWqF5TgrDXmxcoQbekYHD15+0EeBFawMKlHx6a8teDQ4dJ/MzT1MgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjoEIW7iOpi7nsKB64767QtrKeSyJOa+B8B9tna91lk=;
 b=tkk2iscdhGrgFbXMwhsAIN3+EJ3LmCn2XPyjnlSQ0s2mBcxRr3NjqBTEgmPtVIrWiWLRolbruAjMKnh90xdaeNmerLgGgjD60EUmvVkb2q6Ic7lm7oqnkmSeONDNuq/UHYHGnQc7FqQnJWh2YCFTVJY+MYLz5HZNf+/UZ/2BU1I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Fri, 4 Sep 2020 08:15:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Fri, 4 Sep 2020
 08:15:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: correct Renoir UMD Stable Pstate settings
Date: Fri,  4 Sep 2020 16:14:43 +0800
Message-Id: <20200904081443.19768-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904081443.19768-1-evan.quan@amd.com>
References: <20200904081443.19768-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 08:15:13 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b512299c-e37e-4ded-4c80-08d850aaa6db
X-MS-TrafficTypeDiagnostic: DM5PR12MB2469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24693F21F7C497DF30FC315FE42D0@DM5PR12MB2469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teXYhXtEg3LL1k1qA8i3I4LXe7cafbBybeYefoOwQKjPdv3pjRb+76MOXuF29r/XFBFDCqhzRZelKvDSol913guhltWWZ+AjY4NWpLd/aWy7YtTzm/Oh2R0agHROcgKElGUf7mtAodwUWfru5NB4dHfbvTXTzdjSWUFeX1+q2vwcQbrbFQZUvi3y+S13X72e5C+RVnlgBg2tTaVYV6qhm7+Gu8X7LSAPKxbVidyojEBcduoQGkJvxc88WY6WRo94TuPO3npCzy65L2QVBb0VsdYozjPfa+zj1GEkajXFjGsTHPjSe9R4xEgxPt2+HY7IU/iG3D2wmoYpDLG0NYG+uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(1076003)(8676002)(6666004)(316002)(6486002)(6916009)(8936002)(83380400001)(16526019)(52116002)(7696005)(66556008)(956004)(86362001)(26005)(44832011)(478600001)(36756003)(66946007)(66476007)(2906002)(4326008)(186003)(5660300002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9DaDy1VC99Tz16Qf43X8UTu+cdC4tPvDe1p6H0Vw+YiAxmDfBkhNTqlIpKvOjtT1E1SIwVHgJVrel2Qc2TeJEPK04mhg9pUwVVRW154vgGUHk/s026hkAGBdAtfnZLrjLtXX5EpKeSXLMiRrMMRRH57fl6eImiq97AXM/s9d/lnbgLmp04C75MQz7eOiHXwB2RE8+lMpXRbcNpwMRoNar7nrPmn6cuOtJ2Pl5qt9GHSryYB41i6iUcM9bZHeaoIZvZgaiKVJPs8rqxPQX4o/wVByHunpmCiP44HWXKyjo5yMkxUxHkYc61xGq2t5nrKWsOI1G9M3bY6tJPi5xQaySWAsTZtFyENavmv5+VxKDCtMV9A/rOn+EVpRPYjXZIuvbtad803ISrZmDukRg+HwIwblfOarrwND4px+cbZrWl8+QeK71DA4IkepVIWxgcrNCMuu1uyM0ir7ATTLH8r62RDgjpgZlMRXix9EKFkVbs7j4zt1y23bGyp4rxQKWAi78P2kLL5F3S/5blZBuqlAZ3xuPIhxHhOEXQHJ/5j/vIrUT3uUwj2g99PMgk6WzzlNE0sHXL5YnXwToy35/qCQmhoFV9zMSOXcbTifQOfXdz8VZQHqH1NHMuSK8KwZ4DqAsfd4Bdsv5OYEqUcZaGivMA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b512299c-e37e-4ded-4c80-08d850aaa6db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 08:15:14.9735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rBD64R+AtWLDAOekHnyPcz61BwKhHUacL0axd3WRtG17Yqp9fgAQLUvfX5CoOy4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2469
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, Evan Quan <evan.quan@amd.com>,
 changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the UMD stable Pstate settings with correct clocks.

Change-Id: Ia14eb8e23c513cad0bd633fbeb99ed694c7e3f7e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 52 ++++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h   |  1 +
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index f4c55e8b5221..8a0bc7f5ec03 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -832,9 +832,59 @@ static int renoir_set_performance_level(struct smu_context *smu,
 		ret = renoir_force_dpm_limit_value(smu, false);
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
-	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 		ret = renoir_unforce_dpm_levels(smu);
 		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetHardMinGfxClk,
+						      RENOIR_UMD_PSTATE_GFXCLK,
+						      NULL);
+		if (ret)
+			return ret;
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetHardMinFclkByFreq,
+						      RENOIR_UMD_PSTATE_FCLK,
+						      NULL);
+		if (ret)
+			return ret;
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetHardMinSocclkByFreq,
+						      RENOIR_UMD_PSTATE_SOCCLK,
+						      NULL);
+		if (ret)
+			return ret;
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetHardMinVcn,
+						      RENOIR_UMD_PSTATE_VCNCLK,
+						      NULL);
+		if (ret)
+			return ret;
+
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetSoftMaxGfxClk,
+						      RENOIR_UMD_PSTATE_GFXCLK,
+						      NULL);
+		if (ret)
+			return ret;
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetSoftMaxFclkByFreq,
+						      RENOIR_UMD_PSTATE_FCLK,
+						      NULL);
+		if (ret)
+			return ret;
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetSoftMaxSocclkByFreq,
+						      RENOIR_UMD_PSTATE_SOCCLK,
+						      NULL);
+		if (ret)
+			return ret;
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetSoftMaxVcn,
+						      RENOIR_UMD_PSTATE_VCNCLK,
+						      NULL);
+		if (ret)
+			return ret;
+		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 		ret = renoir_get_profiling_clk_mask(smu, level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h
index 8c3f004cdf8d..11c3c22fecbe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h
@@ -29,5 +29,6 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
 #define RENOIR_UMD_PSTATE_GFXCLK       700
 #define RENOIR_UMD_PSTATE_SOCCLK       678
 #define RENOIR_UMD_PSTATE_FCLK         800
+#define RENOIR_UMD_PSTATE_VCNCLK       0x022D01D8
 
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

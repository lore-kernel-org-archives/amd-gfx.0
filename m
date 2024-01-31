Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735BBC47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CC010FB32;
	Wed, 31 Jan 2024 20:16:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA52B10FB32
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO3OzrvE0Zs+dXeQhlLG4X01zgXBSAfrTgSrpKRqA7iur1QjmKpcH8mD10kFwdTxiV1XkHn/+6I6eGQvV33ZeZmTKaAm0dc30uGMDgMh5KTEbvIuJce5twdC5dooL+qhAe13yIqqzoFkRdCzz8hfCv6J/td85cezdkjsltLkDb+ZZsZtZVBGhP8PfQlHnSpmFs7SkJ1Gl3ZzkugPt3og34RbIjWPT4E67UHVbM67J3D3kTGRmchBRcfDci56/h/0h4VoRSqNczQVTMXsdguHQKK8JR0vknY0Muo5ZnHdWJVpPsJWgWolBsntLbxHE27osW5wz82TCXYVOD8vA6/Y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZudzjki48TxrJZBHpd6fKlIkwUJQOeWUg+cGbT+NGQ=;
 b=NyhDz/TXdOBArkwEgeGd0cbPtIFHoJThJZtsSrsJ8LHN1yQqSFfwAuxfxCvSFyW19FFeIUS96isxubtbcqRoNcD5YCKdB9r7Ht8pjF/dhsU8GKIPO95Z0GRw4s0k44jQaQmCwtGbZG82lGGtZqd3Sq1nF/JUDNSOB0ezFNn528rzfNBYdVWvzBCpdDFsN3+ehaDBI4ddVzxuS9T8a4HvoCOARdowCQH/pCEWjepP+WXlMz0E0SnmvwWhVllT6lav1SFW1ntCo4clPF14ERBra2E3OesTXS7IbT4qEtccvR6yS7af2DOH7fF7006+AGzdapKl7EgqVsjuQCfN+eoEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZudzjki48TxrJZBHpd6fKlIkwUJQOeWUg+cGbT+NGQ=;
 b=vV+EKCcUtb2SoBWrReeB9vGCK8b4jsPgv2Bwf4kGsOFGo8nRAEuoHRVce60IDjQ9jKU0B5aXQvh7RJ3cfR99/gqO0VK28TWftERh78IeOgPB7+6tU6FVC08maajV//uMGwYGGebPUInNMjd+kkyaPPzHJIb1CE7aYpnc6VADC0k=
Received: from SN7PR04CA0032.namprd04.prod.outlook.com (2603:10b6:806:120::7)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:16:12 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::aa) by SN7PR04CA0032.outlook.office365.com
 (2603:10b6:806:120::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 20:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:16:12 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:15:45 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/21] drm/amd/display: 3.2.271
Date: Wed, 31 Jan 2024 15:11:27 -0500
Message-ID: <20240131201220.19106-22-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdbd480-ad09-46f9-7cc0-08dc22997835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Zw+/8q/hpGbfMglnSOqw7Bs8Z6UD4EZ2TkR950F9gLg6NtTxbrbbJIBl96QTZiFYK8T8Fc3Qt2sbvz/jGWnu8rUeWANtU6w1pyJ/6JQS4oBV0T/vih2JZDW5br4bnZG7ViPVHXVzRK0KN/mnvsrbS9lXNgKUqqoOXiZz+AtNRW1ME8tcoM3UQWbcYfgy71cL7npEF7O8oVflD1XZGMzdW3aBNx1WMiCqv/MjI2g7xVeA85V9RX6wYW+wT4M6u9hVH8MlwOCDvxWu6VJ/bkz/rDaG718XyHMwE3cY197+J4VtYqJKgBOE95VEz/cpmNqxzdP16pW5K74NhqfHa3NBlhtKTLGDYsS//5y53rNLVxDDsgMLB4uvGGsADZ6YF1fEKUz2fqwGc1H+W/PoJoWYpbIU2+D15nqXLqNXc8ou4y+3XwRZ/PoKuiQzbbtii5Aa/AzOSHR8cOCJ+igz8ZSvCjiU4DsjqjDewhGSz+IVHjPVWNohvSt8Sqsxm9SCi6g2i42pwRkx39bryyxZvnooOvAuaXPuYtOQ5yCUBjtKAZ+Y+L1eCnQl8RFktFLZJ1c/EWg5MzyJJPSWVerapKEtgqBVr0E19NuVrv5wuCqgYfeYHcdWeuNsCFZH+b/5TQtP7INq+kJvqwQwDeBwHj3FWVI5L20gp4M/4BRg63/7R3QD2xY53QkrIkq+9Z1zKCmj0tg//mRuwXDwlvFDUm3sgYPc337UZ5TF18UHL/np85Tenedf9alkfD1liSTQMFNrMtgQMvtdiB7BH3S4+SiEzQqXUAjP+DxIrKPBX4wO+RAqKKuUEaiwB6y36Rz1rRO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(83380400001)(4744005)(426003)(2906002)(336012)(2616005)(1076003)(5660300002)(26005)(36860700001)(82740400003)(16526019)(47076005)(70586007)(54906003)(70206006)(4326008)(6666004)(44832011)(8936002)(8676002)(6916009)(316002)(478600001)(86362001)(40480700001)(81166007)(356005)(40460700003)(41300700001)(36756003)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:16:12.0942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdbd480-ad09-46f9-7cc0-08dc22997835
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
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
Cc: Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- DCN35 fixes
- DMUB fixes
- Link training fixes
- Misc code style fixes
- MST fixes
- ODM fixes
- SubVP fixes

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 07e6f25269e8..c789cc2e216d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.270"
+#define DC_VER "3.2.271"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.43.0


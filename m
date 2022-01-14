Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72FBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F87210EADF;
	Fri, 14 Jan 2022 01:37:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948E510EADF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM0LrXQe0kmKgfK3U4N2HBNSnHp0EFWehqtafJyYZ4rvhVztoyanMmO/z1EHYY3PZhEJD+q7twvvSjPuNPsNSZaYfG+jNHnUYI+tIpUUKqocI6eaHo+gEuNyj7t0WjuFSeK3W44pW+HqcKh9qXJ+7MC2dG8MpQvYTK1HH3X71hcOV2TpgPAnaXQE1nzi4kvkilzw1qpP/p1xe3tAlSnNaiDitOpqJ9JMievRur5cYdpnsaamSLoFCFZtjLztAUQGhfjWerd23g2oNtXaB4q76AK9Hy+4ZKdDLdYpKZ/jM39cUoZ5AnUQPWSYP2Mzliq3pQ5sgN0Kw4dm0KEYH7mp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCi5TODI3b/t1rCoh2EhyMLUxJQ9djBOLsz68IHb6Mo=;
 b=LOhkImU0TMw/h8S5egZWev9CISRhbVKI8b4L0bZmeuSVzvkL2wRr47As5cbQXeKe1WKBjpDrQS+6RLReM4GAtNbNpDnGNOJLky6nDZ2o7LWmfe60W/JvyuY0BYp1La2bfE3p9LErwlD+wgUfHvsBysCQJVQnW/0PKqedWJCAR8sSDrkQ1+i4y3moMGULSR8VaeB4a69jp/zu1leQ+E0Kzh4gvcb6kpGMKPtU7updeHthE4mGYpKjAnac5u6j1msRnDViifYPavg+KL06l5Jr348CNVtCuDjESp/vAWT/XNsBgLEgAVCKd5ZXwfQFGwdk/Tl+v6/KJhojh1ZyOkbjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCi5TODI3b/t1rCoh2EhyMLUxJQ9djBOLsz68IHb6Mo=;
 b=YRac0eIYpnGart87jTILMFf2i2ozTPK6kC2SJIisBhX+7W17aEmoqTyy9IocJ2UbsEZ7e/8pLjo07/r7wt/4RWdZjtNRo5EdSIb85lorRszeSVoY+yuztEr+iZC7cUo7Abh0RlpuqHC9dREMww1Q2mAh5xehf1l2peauCKCzPDk=
Received: from BN9PR03CA0144.namprd03.prod.outlook.com (2603:10b6:408:fe::29)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 01:37:48 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::b8) by BN9PR03CA0144.outlook.office365.com
 (2603:10b6:408:fe::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 01:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:37:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:48 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:47 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:37:43 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amd/display: modify SMU_TIMEOUT macro.
Date: Fri, 14 Jan 2022 09:36:51 +0800
Message-ID: <20220114013657.3119627-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b0da68-a624-445e-c05b-08d9d6fe78d7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5164:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51642643230EEAF980149E68FC549@BN9PR12MB5164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjvweRkEPbBChBVOVzR4yjaaV9BTA1hhRC+2+cOamv0TNWCAY7vYDLOhj2kZN3t3zBOZptVfW+xB/RlscRhl6RIVM/o9gaV48BqfDkwQimcoEcjWBml9tTr2269d5OrmUAvSoW/IhRFCBZAUmIaG1VDTRtnT6CutUTcPoxXTG1moH0wGV/nquJYJhUxBzXKwi5j3cGXdFBffsNVKv4KP8L9oQA2P6UNdixcCCpEKFMGLgdRu1ONd2MwWYls1SJ3HAGwyjywNQWjfQ+veldecSfnjE1NZTrTDku5HUvxXTqt9QbTwBsG1kcJY6wXfUH9KEc9VaF7dvfSctXyhM9wwpZHvMBgSbYxEXzQCz9akv9PtHk/W3HGH/4GWo3FNHcWCg7vLm67e9PeXwRBiwQFiiR9419tsXYqMPk16JfFvy5900r0mvGJ1bd0MW9hBJ2THBrdlTjJEe3LHSHo4o6tOy8pFpSFP4ydiAYmThBob4Kxo0rks9lgGqEgQoz/5VWGkxH9Ruj0G2HL/C71m1kQYJbsHUaY5ZSOf0RhLxDTREZjSWQLq5g2sfc4pb7SzZyuvKbxGt810nIxmVjwVFWFgB/EDbdE6znaBSx36geRI51UrTWpDuM9jmqBWREmM0IZA5HliU/pay38E15/zPfJEkFc7gQoFPFTMInZaIrpZObBiyVt+1VLntf7aV0qSoGFo/jH2WIoAlI+iBsr5aaKltfRDIPKJtRFeMWvDP34MjtL+ZDUis5L6rHKfO7msThPoxZwKqDowitbpuTa08hrBS8PpveRNdaoZxwwZ6YnGEcw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(83380400001)(36756003)(1076003)(82310400004)(40460700001)(4326008)(81166007)(2906002)(8676002)(70586007)(356005)(508600001)(426003)(70206006)(86362001)(8936002)(316002)(336012)(6666004)(54906003)(47076005)(5660300002)(2616005)(6916009)(186003)(36860700001)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:37:48.6609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b0da68-a624-445e-c05b-08d9d6fe78d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

[WHY]
If some SMU features are not enabled, SMU will return fail to that
message.

[HOW]
SMU_TIMEOUT macro will treat "return fail" as timeout also.
Correct the macro to only report timeout case.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dm_helpers.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 7f94e3f70d7f..a5497ba89f15 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -170,9 +170,9 @@ bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enabl
 
 void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us);
 
-// 0x1 = Result_OK, 0xFE = Result_UnkmownCmd
+// 0x1 = Result_OK, 0xFE = Result_UnkmownCmd, 0x0 = Status_Busy
 #define IS_SMU_TIMEOUT(result) \
-	(!(result == 0x1 || result == 0xFE))
+	(result == 0x0)
 
 int dm_helper_dmub_aux_transfer_sync(
 		struct dc_context *ctx,
-- 
2.25.1


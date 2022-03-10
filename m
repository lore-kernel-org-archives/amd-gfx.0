Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC9FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D5110E5ED;
	Thu, 10 Mar 2022 22:21:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A625C10E5ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbN1FovPfBJGPkm1h4NyOaZsbGAgzfXiiGFGI4JtnuFCH0WeS5IZ4xO+1i6ahEr8t8cmrPOTiM4axlCWJEWq+I2DAOdmrMVe5+nJb6RTPcce7+HvvTolo+0kL1LS4bJwMA9UB03BOLo3CxotfWlDz8Dl4Il5vpikr5iAe2v6srnNmEcBulfthVLtTUfPo7yxwAblmBtzNAlo0OsCKkrZuCxcq6ezR6i33epGlZ6YwkMLbvMLJRtoD5r3yaFbg7BNMweobgtiL3O1Im9qGK7ujeV+SwPr1oj7/SM10t7mGW6V4sGyUcBTeZr9ZAY4cSrANeAMrIxxhaNxEeTomz1b5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyGDI4z7FIM0GKpn7nspfGdUayHmnuR0N345BDYjPs8=;
 b=bQ8Fprc1hyR3ArRBDWVPjBqfnuR+M71KuwKQirA2jeBD/IlrepbwAJmOKIimhdSChtENGdTYGsH5xoYX8ulWwy8sOmWHbdgGP36P7FXutb1Hx08Xr7dc0WGDf7sYSUiMvVk1iIwNiMzQRZUEKl92nf8InONKnI2sGxVBaaI0JmXi2Om+BXkB5Z271scC2GSeyPg85BGB0D76xZ8EtgEgBllk5tTHW2bcYzXxhG5fXIRPqAXwTBt32Qxqd8ZV+lhIwHODbIPAAxjzxUyCXG2jeoNN0c4qcM5eys2EmLYbLGpCuhuXfmFq+7E3Z8uXkq9Bq5Gf+cgu0r8+izCmwQLUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyGDI4z7FIM0GKpn7nspfGdUayHmnuR0N345BDYjPs8=;
 b=gN132YiSOwDCcdnXsY2k/ubRP+47uKXyREMlo0I/ocBmqJF5r5hN6W0Uo4ZWFz+ob20Q8QVT7PUbJXaG7Yw9cquHwbOTCa+MWxTIKbYgGKfuo54PY7NCLt91aFoaYtG+XbFQ+n5rOmBZHjhn8x6f4BmyXvmDcoGLLSUwGHbkqOo=
Received: from DM5PR15CA0065.namprd15.prod.outlook.com (2603:10b6:3:ae::27) by
 DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Thu, 10 Mar 2022 22:21:49 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::3e) by DM5PR15CA0065.outlook.office365.com
 (2603:10b6:3:ae::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:49 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:44 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: Add null pointer filter
Date: Thu, 10 Mar 2022 17:20:41 -0500
Message-ID: <20220310222045.664867-9-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba3fa4bb-4c54-4b7d-ca32-08da02e45edf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3259:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3259E31B9F4A60583B222354F50B9@DM6PR12MB3259.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+eTolKfJhUoRtt13gpRAmtNAtbw0QLx5gk2AxJdde+9yF9+JAUScsnMAHyl4GAKPPacgMerPbd42MfMiubc4vU4aHubIm+3aFl3ApGayFJIrU5WWHjOcXPUrmkvjzY2/KWKyGC7PhrtqxfpXe0PwQc5hoUpAkm/j1AUVp/ORMl1YqjEc7LtvX7ULBMFTUgRZnrVoecE/TWI61Us2SCzqK/X31Y6ehShPEu2mgwQk60iqhy8bRvNQlfInul3GqSwP9f0Nl+O026ZfQwkKMj1W8odTdNoRSqBlzFcNOKt7Ea/Zd/KH08gUxXClE8t2irej7Je+ZaFSkClW8BCxlt3apvliwqUOS0pwp0IVVLisbi+rQ3mHuwEaNiLxbjXTo+3adWgikiMjld0Dkys4YWqbDRHBApp0/NACQwg4heT9Rlk++auclalG1u7f7z7U465fNB94imW2CaV6EUDUNoH2r9xm8vPx8C5ud8I3Mi4D/8qCvp6cwF0nkFb2/R4hh2mPHiEaAk75wYBU6abWuXeUpCQW2lKxtZ7R8wn/wkXHUKZTde+UxEjDYFIVbJO5fR6Hxx5grQP492FtJ9TnWiZTQbSe7+ZbTSxg2WPU1/Hir2E5Z2HzNKP43gcVWLblfI70+AXYQ2j1+MAuU/q5E5YY8z0Yg4Hv5HflOBDv0S9yeR4LBIjFrQ9FyZhGsm3ShsXpl/Vn3SNh5brQE7MEP5/ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(6666004)(6916009)(7696005)(36756003)(47076005)(508600001)(356005)(81166007)(2906002)(336012)(82310400004)(70586007)(70206006)(86362001)(5660300002)(8676002)(316002)(8936002)(4744005)(44832011)(26005)(83380400001)(186003)(16526019)(40460700003)(1076003)(36860700001)(2616005)(4326008)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:49.2776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3fa4bb-4c54-4b7d-ca32-08da02e45edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Jing Zhou <Jing.Zhou@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jing Zhou <Jing.Zhou@amd.com>

[Why & How]
Add null pointer filter for logical integrity.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index dae8e489c8cf..778c206f754d 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -647,7 +647,9 @@ enum gpio_result dal_ddc_set_config(
 void dal_ddc_close(
 	struct ddc *ddc)
 {
-	dal_gpio_close(ddc->pin_clock);
-	dal_gpio_close(ddc->pin_data);
+	if (ddc != NULL) {
+		dal_gpio_close(ddc->pin_clock);
+		dal_gpio_close(ddc->pin_data);
+	}
 }
 
-- 
2.35.1


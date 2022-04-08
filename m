Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BECC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B431C10F11A;
	Fri,  8 Apr 2022 17:27:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F2C10F10A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBnoZ9+P8JTVmhgYNmcADvfJzWoxSDVv4XboU/LUOiMLMSgjiylgnMYQi7sbcwYJu2jGAb2Zhvosd4dGj5A6h+yizA/mStcnvJMYR2EE9eCXMPayJwBNYtzzqcHQwwg+3jvA3uwUN9au+iZ43x+t5xtXWqrrmH22KnT8QIl5l887oHFww/rkN4rAV9kgQvQhsgqzbi+5tit3Tf26pfjmqxYTEepyhASKNkyEapu5dUhnu9spmEmh2IK3nHK/0DUxF4prVxBYViuzXSrlxsNFZEJljX/L+ssX7XCHkPUNWudR/cE/NlXO/oWJxhQ8K7UwRo9RXgjtPtYjYZJeCaOk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp231aGeTE7xr4TGRs1zhyeZLDUtSu9AuwnA5nPkLYI=;
 b=NtBRJ+DNBvaRxp49dxStnvSfVzDFwp4U4sQuoR8q9NgAKRb9BKOyM39QbCnBah3A8/votfKKRWiR/EiYoWNhA4vcnmBkISu4lTinS35mAnoh/p55uEZefZU74BwdzwgOfkfmAf9FsN+BQab7jCEn6kHvpqQ/qKVggUfV7DeBRfNDsRH1maA6hiBnc4PIt1fgFPp3aFFM8VBcQJtMjWn+lj0L6pkex0AU70KQz/cRwfELnDBbABI3hb4XOnUWJfvPkE0gKUSNhASPP9oT3LkvO82q5JDM/o7rFqGjWdjQOlHX7+YO4i9LqGsV490t1Nb0cCrzDd/kR/NhxvSlbeWN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp231aGeTE7xr4TGRs1zhyeZLDUtSu9AuwnA5nPkLYI=;
 b=zhr5QdusJ0kaeuTroQUr4VS7G8Xt4vDZwpLCTznKNbQpeBKbNBaK4xaK+gOITEenbaJzHSUGtr2/z1C2y49l4wSMKee525yzCufSwqxKG4FQQ3pd88yhJES5/CvjCccnNBMrQ9VbHWRxb99YKs90uGZQ+wniFvnTbHrA0szVFUw=
Received: from DM6PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:100::27)
 by MWHPR12MB1775.namprd12.prod.outlook.com (2603:10b6:300:109::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:27:41 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::5f) by DM6PR03CA0050.outlook.office365.com
 (2603:10b6:5:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.24 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:40 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:39 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/20] drm/amd/display: Insert pulling smu busy status before
 sending another request
Date: Fri, 8 Apr 2022 13:19:01 -0400
Message-ID: <20220408171911.601615-11-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 600d602e-94e4-4c32-d992-08da19851581
X-MS-TrafficTypeDiagnostic: MWHPR12MB1775:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1775550339976A8BBD6FD8F2FCE99@MWHPR12MB1775.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lRo6eSD6CtbXBUe+SJAmLZnJRA2aoQPKmsvPEvrgmw2Z25Jv4bIvNspTst2JPZYYDrxdNsy3mO2AHjstnRZtAkbw/tAFtG7l2ZK4mk3kUj0FWHvRluK3zabWR466gl/ZlvXD9Dwa1XPbRJ8cqTsHntlLy3Jom/CyNeZCE5vHJYX+Ot4MjPoHbh5p8B39UcUFf05C333FH2MxLi5Ybp/FUQttfcEvstrgPR4m47Z2gRhcYuoJ1DQmYnkyn9QRXZfM0JwFdDxffO/iiRVFXBRSAKNuFgXWXPRPt8jR6iR5W6WXym2yPcKPpxwcY+vziQt5CYowqbtjaTYzwVxpucrpfRvlEttp9k4uKtCIXSZV1KQebZ3wuTG+KDf6U5Vsxh1/DC7IAX0uRHRj0e/dqQX3pSGFpf5m2GqKZYy5C3EkG8sgBIfYYX6AXy2MyiV/QOeKWhtQoEH6n7Cey1pKNy4ELz1l6qOBUVDUVMmElZm26N+ja+N9s0fOcCjbeLCeQ/ItNMTiRbg8l31d+nKhayiu0oEmTkmtRw9Kp2uGstZ9PNoZgXW9kYh3rv/8KyJbpIHp9Ko9f9ZCV4DCL+s0Gt8F3ukYZJH3No/GKmG7UBFP1wWGNP/ZAO9FjCH1u+yxT9+DoTUmLw2Th2qgEbArFGXY3HEQplQzNzImNGW8ItgrhRq2FYDa2eXuuTXjz5BnSf/HAr0fdweZLKX4cROgKL+/ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(4326008)(508600001)(8676002)(2906002)(8936002)(2616005)(1076003)(7696005)(70206006)(70586007)(54906003)(5660300002)(47076005)(6916009)(36756003)(6666004)(316002)(186003)(82310400005)(26005)(16526019)(426003)(336012)(356005)(81166007)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:40.7585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600d602e-94e4-4c32-d992-08da19851581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1775
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
 Oliver Logush <oliver.logush@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, Nicholas
 Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

[why]
Make sure smu is not busy before sending another request, this is to
prevent stress failures from MS.

[how]
Check to make sure the SMU fw busy signal is cleared before sending
another request

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index 8161a6ae410d..30c6f9cd717f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -94,6 +94,9 @@ static int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 {
 	uint32_t result;
 
+	result = rn_smu_wait_for_response(clk_mgr, 10, 200000);
+	ASSERT(result == VBIOSSMC_Result_OK);
+
 	/* First clear response register */
 	REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
 
-- 
2.32.0


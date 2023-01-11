Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362D1C5479D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 21:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA00E10E159;
	Wed, 11 Jan 2023 21:52:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6869410E159
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 21:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/PDNLuIZLUpedXVyp7jiaQZsIJXKeDR9rbAy4Z1+QpQEL5VxJtgjfNr+VRRFwHrDQEvqpvY212EAAqbJNROruuyb6ehXpY6quLYaj/qNYzP5uNnlLrEVzzm71bypr5ReoauclR6zSmF7cv27h06DhcjqEn1NvvhBbycmsGeR9fxoJ7+e0waYdk5IRLIxLCBccLVqpqkA6ImjClPjC3ZkafQqTpG5p70v6mI0hvPyx74gR0FcrvdrnwWCnMQgw3Wxt1FcBtd15KA7ZLXq2hITw6BVZ4onVL/J5NpVjypblLz2kCVUnqICtbv1XsWNT5Jjnb/6ik/9rMUAehOCY6+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIqtL6LXJiyJzXc2W73S4bGTqF39YkkTPt9jtfbskss=;
 b=VFneouUTekaw0y4/2LQ5YrR83NOMdfizamsACs0lm05b7i1yt5jBHpM/u9azSXl28bfWcoEVux8UwydZiHPD1AKsMc+ju1VO0R1NAIvdZbhlT+kfOOQ9cUEhxnPXHJ7JI3Ti7EpVtawTeneeUf0/lJm6czoEA0jjvKFB62ImUMoYENCt/5ITp4L0fdeVZZ2TJ/EwANCEMXVEmhxKtCEWTwchpU98tcUqmBuedFNdoCYoxDv9SQhCLfHXGTGSuzmh19MjOlua/mOqlPhuzWcoPEw2px+XOwyHN0gBH8Uaqw0lSjzjQnN1hgLhQhHtJ1AZz1uQQ4XDv0Bqo0IjKJNzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIqtL6LXJiyJzXc2W73S4bGTqF39YkkTPt9jtfbskss=;
 b=lHR648+a0lwGD/pQM8WI45Yd0RJODGw0sBRWZy2YZm/LsRGqYF70dO4MoK/qdbJvIeUG8dwBhIJBV0uanUUZIl2/a7hJvzuMO3lMpKu4jokEuE1PYvtN7MOby5u/YQJyE5oSbX2oTpfmyfTcYYFP/B62Ph6ZbjrfpmpRlXegftY=
Received: from DS7PR03CA0042.namprd03.prod.outlook.com (2603:10b6:5:3b5::17)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 11 Jan
 2023 21:52:50 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::cd) by DS7PR03CA0042.outlook.office365.com
 (2603:10b6:5:3b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Wed, 11 Jan 2023 21:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 21:52:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 15:52:48 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Avoid ASSERT for some message failures
Date: Wed, 11 Jan 2023 15:52:31 -0600
Message-ID: <20230111215231.20122-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b07396-d89a-4aa6-5006-08daf41e2ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDD/SD0n2bFAIM67eAV+EiTtGDuPa/UCpZUYaRx6GxQzkpekfR4YWIFPFywtnNKdOxdLdVwgR7NOdzfzskI/KN/cBe2VTo3h9SCooaSIbTxjZPcySm5x/PyWFQ0nOtDGjOiJsQ877vQDPU+lHm32EPB1u4kzB25oD3vwK5WnatfdBltA1+Ds/wAJjTaaa6gb2A4E8BtyLsaMtcPyBr85Izz9mzw8dGTeWv7EXHcEggWx/bQf3RHtGb8xPt5wyp/HFQBjwIQdBomOwQKiagYSW736gskRc8XZ2x619C3wxwMpmk+O9d4z8g4YfzE6mvIX9OVCLaCzk3D8CvzOc835zkllxHjX8xWyP4FH68sHenub5NVgjPQnvejXgBawWfEFPuFhHtzkdv2FbPBE+ieAVdmBYI0LEcVzlM6ue39YJz9/f7/QUaDWx3BdQNNnpczSROGW6KQDXHLbrc0fp617zfv+qu17CEt7nTHKLd+jvrmsp4rfD1Z/7vm6/sOPxLUhmGSO8ywgsIpgbi3BEyjYOMJmDxbPyILYeU7gJG5MtbSHfhS+ZYigU+Trek7EkffPwP7jKmbzfAQdJoAXd0gK8RacXpKsyuZaidNR0sZp+ij738TzDqA93S4h83VdGhEl/sckNWPd8aOFIokSklTzNaZUaeuFLuxV3AII4ZDr/WhQDzHVxj9yTKQ2GIf+aNU461NAckSgHicIdsYHdYtMwoNQ3Up4wvxoly5z/4oKQ2E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(8936002)(2906002)(5660300002)(44832011)(316002)(6666004)(41300700001)(4326008)(478600001)(8676002)(70206006)(6916009)(54906003)(19627235002)(70586007)(336012)(26005)(82310400005)(426003)(16526019)(40480700001)(7696005)(83380400001)(47076005)(1076003)(86362001)(356005)(82740400003)(2616005)(186003)(81166007)(40460700003)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 21:52:49.7780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b07396-d89a-4aa6-5006-08daf41e2ed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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
Cc: Richard.Gong@amd.com, Roman.Li@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On DCN314 when resuming from s0i3 an ASSERT is shown indicating that
`VBIOSSMC_MSG_SetHardMinDcfclkByFreq` returned `VBIOSSMC_Result_Failed`.

This isn't a driver bug; it's a BIOS/configuration bug. To make this
easier to triage, add an explicit warning when this issue happens.

This matches the behavior utilized for failures with
`VBIOSSMC_MSG_TransferTableDram2Smu` configuration.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
index f47cfe6b42bd2..0765334f08259 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
@@ -146,6 +146,9 @@ static int dcn314_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 		if (msg_id == VBIOSSMC_MSG_TransferTableDram2Smu &&
 		    param == TABLE_WATERMARKS)
 			DC_LOG_WARNING("Watermarks table not configured properly by SMU");
+		else if (msg_id == VBIOSSMC_MSG_SetHardMinDcfclkByFreq ||
+			 msg_id == VBIOSSMC_MSG_SetMinDeepSleepDcfclk)
+			DC_LOG_WARNING("DCFCLK_DPM is not enabled by BIOS");
 		else
 			ASSERT(0);
 		REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Result_OK);
-- 
2.25.1


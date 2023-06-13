Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66098EB64D8
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 23:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E192710E0EA;
	Tue, 13 Jun 2023 23:09:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815FA10E0EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 23:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx/QLKtoHJQT0SzTSbwDTkDW1h6LFt+/Rern1QETNGTgBJxeFHvXux0njwY5C8/0RB6HrP6jZcA5GRX5S2q4naoXmccEzHpEf7sKtVmFjJW+u5pEEugiG+bPV6adbRdqK+jXewFSxoQiAOGbeD9NhlX9gYqx9nn5GjPsB6VMDa0TArQ52sTm8On1dcfCcw2BcSocfhzdmA3W+wU9oksQh7OJCuHJRvly7J2v4nRCrAq8WQdpKDi27IQX1SsGYf6g1xTacm5JRFRC0Y/VfRO0B28c7LdH2HbYBDpU/SiLdUd0oJAsfLIBQTt/gXXnjKRbjGK+RgRytXxfNY6WJZ84MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6/iIwwk3Sb3g9N44hpg9oY8eJq6uSJn5OAjlSW75XY=;
 b=HMimJ4Qjn9jWWbg3L1eUgxYlpPF2/weVWM7lfFb3XyfqyN/oWp1mGY/Yf8besI1PzfcONJATF/Sdq78Ctt7iJq82bfgCPHY7iF/UIg4OxRxELqxvugVmFBEnHdNkdvqNCOezAma1CNFmppm+R1VOp1OHdbTQdS9geQ394INWgjCRgP7geco0zVl4k+yG70YHC/WKhsrnGFYUa+5LPp3qC9sV0fvomwIWdkM3lSNXfYvnjoxfn8lec3N1a2cbYwRCXEoaYeCD9Fep3fY8C1V+/lryD6X64jD97oAo/m8oRTBeJlkjGU/GrDwpZu/8DLU7Nyu+OO20n0uEb2xhjKzCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6/iIwwk3Sb3g9N44hpg9oY8eJq6uSJn5OAjlSW75XY=;
 b=tXeR7+PCezNBhZiNNOuCcxAyWydUre01T4uaw1hmlNTC5xq7T1ZziyLPayaxp7ct4lOd3ezS9vzLoKZ6J02Weq0pBIxj3K+BxxtpX9UT86nimD8H9n3hnN45OuOZT2mEB2LGBlXHbDCacg4enAxv6o4hX3KCEz0hRb7cwZHkkVM=
Received: from SA1P222CA0043.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::17)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 23:09:00 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::3c) by SA1P222CA0043.outlook.office365.com
 (2603:10b6:806:2d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 23:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Tue, 13 Jun 2023 23:09:00 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 18:08:59 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add channel_dis_num to ras init flags
Date: Wed, 14 Jun 2023 07:08:37 +0800
Message-ID: <20230613230837.3499103-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 126f1e94-2a53-4692-07b4-08db6c632c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcSajofaugieTPeBDZrx0KLUzsKcyMmWqgTlUrDtkaDl/mAoQNYwY/R4Wx2DWDKBP8SfdcUzEbM7h6u3ZYb2HjNbfGOoS1g4b/nqDS9GFov3uRKdE7AEUDM5g7B3l8fb5ZDR0f4R1N8Yphc1mVR2pv1LBpNkTtNmLIBIkDNjhsAHOOxB8I/t89+gVATC41yDqZJI7AQXV4Ag3qVDWQiV/9f34JIgYZnUEjTB8Ct83ycNH/J+MOYlFmdXIpO7EkvwcbubD57E0lkCnWj9vHh5LZw7pY4eBfVOsS0pE9Wsh2nQWMktjIUdPnGeWVpvZrul8vdoZSI8W9ACbW0+nNq5x+XoNJMwGw1tqv4XXkvN+cyxgEAxwtfmHgAXM0iKn8bqjPpOTPG8E2wjOO0x2C0zS0pbJAoLCusaIQQY05jjxU26V7Jky0iGd7Qx6BcIUZwSCuFMj1VhB2wYxCc3s46oxSEQfqBMvGjJTjpqTagqktpoAYrqC+txqCcLi8pSN1fmvh8fm9ok/DPksd5KJ71Np8NMoFTPfjEE/I6wNPNGFM0NGYATkYUuaGHYkVGN3SoAZHwCAcC7Pei5Sq4wrkl3vxU8qmq2eXTrB03HZ7f73dmt2awEYZc9OBzFsR5dmjZW/fmlcahfU7IgmohGs7oQNCxJHmldbQlju2In5qSNjoYnERfOTWkSAN7lXSfvrB4UlOphdSl2s3QxrfI2oj/IjgMStL1masSR6OQdTm6gTRvrq/BbEhjFf4x7irzWlq5led9Ns/IxogRnZ65Yb7Ji1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(86362001)(316002)(7696005)(40460700003)(8676002)(41300700001)(82310400005)(26005)(82740400003)(5660300002)(83380400001)(40480700001)(81166007)(1076003)(8936002)(356005)(6666004)(36860700001)(44832011)(336012)(36756003)(4326008)(6916009)(70206006)(70586007)(426003)(47076005)(478600001)(186003)(16526019)(2906002)(54906003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 23:09:00.5075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126f1e94-2a53-4692-07b4-08db6c632c69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358
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
Cc: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add disabled channel number to ras init flags.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dd865beb39a8c4..6070c91f0b8293 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1657,6 +1657,7 @@ int psp_ras_initialize(struct psp_context *psp)
 		ras_cmd->ras_in_message.init_flags.dgpu_mode = 1;
 	ras_cmd->ras_in_message.init_flags.xcc_mask =
 		adev->gfx.xcc_mask;
+	ras_cmd->ras_in_message.init_flags.channel_dis_num = hweight32(adev->gmc.m_half_use) * 2;
 
 	ret = psp_ta_load(psp, &psp->ras_context.context);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index be2984ac00a56d..879bb7af297c7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -130,6 +130,7 @@ struct ta_ras_init_flags {
 	uint8_t poison_mode_en;
 	uint8_t dgpu_mode;
 	uint16_t xcc_mask;
+	uint8_t channel_dis_num;
 };
 
 struct ta_ras_output_flags {
-- 
2.25.1


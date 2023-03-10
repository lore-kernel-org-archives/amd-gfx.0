Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DECC6FD19
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 517EE10E9A4;
	Fri, 10 Mar 2023 09:32:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49ED10E9A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kmp8wAS22ZehTizzofga15I5dvu5F/VbToqE8ZjNYxWBpfDQCvIOhBHivGS0+snZ+co0M1NOIwQt+cANZ+lEEkAjzM5GZb8LCjhvWEaMhLJYBG1IoqC80LpNLLkybZdYIv23qsxF7yQ3lUeNfmEbp9kWbgBXKLTrbXJP7RDrqNq7twp5vgfRjLSzgvs7QBDNQzy6dv2aYfX2Dfs/gmuK+vbPfnRue0EBZP8rIgw+nCGSqbBNmG3+ZTdeyEmC9HR0GCO+ZTu8lslkdp+FM2zlt6oIJzTaIRP9FHcx0wrnH1w1RjcFDyoNxZm15fnYZyMt0zfcuTwM2yD/CxzMkGiZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ8dDaPIeSnmfwNKKJ3Pg2cHrcJ8aMnfQlJA4LLyzlk=;
 b=ZHFkBrvt+B/TdDFgykZ9YnLVCInvqUvmJjetzGiHC2A1M7nrIobD9Ni+DP9B4rug0MJ93zzgC4CQSzNwHpQTn0+3ScJAfqW3004ATgb36nBlAqvfsxHJr2rq2ucZdElDno/3yF/fTN+Pk7oGcLGTVGL9roMbdeP3RlPxbrA0Vf0FxnQj0pjyliFXggxoeLNPf+3FmHbflj0NKEEfVUrraapVBP5/wxCMQ+MwLtwsY5Mn/LYdreVOz7uonPjYydSjudQb6C3MZNIBT/3fm3kcXjILef9AEp0w9uLBKrPV7magwUS7ynRLRpjsUvPcji0mjzXUoQMCtSLkVDUlSaIv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ8dDaPIeSnmfwNKKJ3Pg2cHrcJ8aMnfQlJA4LLyzlk=;
 b=0z2KMmsBCQr1d+kCskJzhkZf5ROVB7w9DM7xpFopt5UwmMj7DYbazUUWE2L0BWw3hozekbjyMcHoRrn4OMUx5RXD0OiR0EFNUCGJh8Gp1XD24TSNX3QcOu/wZqHTvvXC4M+/PsUq2pJ/8c5AMuRtl42Gc/O9H61hJ6CSIo/me/I=
Received: from DM6PR12CA0028.namprd12.prod.outlook.com (2603:10b6:5:1c0::41)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:32:08 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::7f) by DM6PR12CA0028.outlook.office365.com
 (2603:10b6:5:1c0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 09:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:32:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:31:58 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/19] drm/amd/display: default values for luminance range if
 they are 0
Date: Fri, 10 Mar 2023 04:31:01 -0500
Message-ID: <20230310093117.3030-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: a06c876b-b285-4ccb-eb74-08db214a5114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pg6JbOk38VIgNvHEK+PcUk7qB0tI7JWhQKvsXyih95r7PqXyas2I/fmvkdpW/5ZuXrFbk129Od4qy7VyrbbfOnuOBhEEvpONDK7XI6ZRGA4S8M5fqbn6BG5936OW3B1knXvbc9YGphp7TsgeD1BtCw/ADYSEDIc3B/PSSmZ6YOBLArKXwQ4nFkxMHl2OxYkPxlYJFscD2PE94GhPAyECdHkOzL6DRcQLu+lTAUdbb7d+vv3Oaym1hmnm5dd7WBsbxc+7fiGes8s/lHmtkW0xHsBjAvPey4ZvZYUipFUW8DFXwdjcjd1pTSG0dE8fm78hpBlHsi2Ml96BvCU3se+5j6dq0vucdQrd7eM8gxqNFbm3EJkGVyvrLJAhRwiNtHR7dJ9RnZ+kpX65sqCjaVF+YMEbWZ6Ffc4aIXyL037BPJbQznK6R5cqJiJcvDhwYRj8amVEyuYFuePNaV3aesO2M5htW7gausy7g8MC+KKe/jY+B5Cf3U/mQK90juUgID2DIPu41moXwpzQYeACnnhnx07mk+mUD672YUSQ7Ybwj1Vb0KauWl03eOUIA+3ObEkZDJuIK/Crr/XR7MB0kMP6/qRVuYqVQkK0kvEBPPvAV31uobyqe5JcEhqrpN3zJrA9HYT93I+uwHiYIS7YTfDMRVhLMD06lUDIf7ZBUvVo9eyqH3h5chR0ECQdF+M2svUh3ZJG6iSvbAhuK/WZ7sk/rF3J64hLczg1i3eDyP00oBo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(36860700001)(82740400003)(186003)(36756003)(41300700001)(478600001)(54906003)(356005)(86362001)(316002)(81166007)(82310400005)(83380400001)(26005)(6666004)(426003)(40460700003)(16526019)(336012)(2616005)(2906002)(1076003)(70206006)(44832011)(8676002)(8936002)(70586007)(5660300002)(47076005)(6916009)(4326008)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:32:07.3116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06c876b-b285-4ccb-eb74-08db214a5114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
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
Cc: stylon.wang@amd.com, Swapnil Patel <Swapnil.Patel@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Swapnil Patel <Swapnil.Patel@amd.com>

[why]
Currently if invalid luminescence range is reported in edid,
then the driver doesn't have default range to fallback to.

[How]
Add default range if, the range is 0.

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Swapnil Patel <Swapnil.Patel@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8af58bba503f..51afc937308a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3012,8 +3012,14 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 		caps->aux_support = true;
 
 	luminance_range = &conn_base->display_info.luminance_range;
-	caps->aux_min_input_signal = luminance_range->min_luminance;
-	caps->aux_max_input_signal = luminance_range->max_luminance;
+
+	if (luminance_range->max_luminance) {
+		caps->aux_min_input_signal = luminance_range->min_luminance;
+		caps->aux_max_input_signal = luminance_range->max_luminance;
+	} else {
+		caps->aux_min_input_signal = 0;
+		caps->aux_max_input_signal = 512;
+	}
 }
 
 void amdgpu_dm_update_connector_after_detect(
-- 
2.34.1


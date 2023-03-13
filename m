Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1169DC6FD1F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8402C10E45C;
	Mon, 13 Mar 2023 01:44:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA0610E45C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeibQiYSMAF2jPVXWCViFpbZkbGsD6Nijdd8kwBIay2KlPtRpQWNUfTfzo/VkV0j1j10O0vhdubEgctUMAqNMQ4e9flPquIQdVu04SY2sXfQYSyZcAYrRLb3Py9Y5dxbZcHIIumOB1NgFqGX9dQ/5iqRqgytF3PUu9xUG+lE6JGPusSSD4a+ZE7emGYrs/nR0Yk3W21MdF0T7hDU91LoZVo56ifXBygQ2NqXIItF5qeVu1QhGRp18LC6T/UzUMN5zIKMStfKzH0U/ifKQ3L4WO5YdoqcyasBAewTNZFk9qXeEavzg6AkBVuXSLFew+PmqLfg6oNO5ix68IKJ9xhQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWDEuYvm9VEa6t+50seTdfriOKmZVFdyhqA+xWFKqcw=;
 b=FIKahxlIRD96DDa3olrYgLAD43RhCAfgIflCrwm3phNulvDQ9t/DaypVuqORPm9bBdf7BOZg6vlfTxCxDm6V6V9uOEtGtKesKtzyHE7aZiQcsgjFlZHjnHvodRWh/5GI21DfaEvj2wrLvbCD4G1JgKRb/pbI7gHDdDSidYuufeVj7y23u62SDmVSh/gGSPqlvoFmt9ExSRxD/jxtYg1h5eL6YRiHh2AGPyHv9xK9NOFtawdxqOKhBfDyx0LF19is2AEP72LuaZNja6+/cTpM8JWfdvYybW8dzh7Y4N9sI9/h0bsauHqFpQh8jf9aISrR/l56xb6dxEgYWEvHo9fjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWDEuYvm9VEa6t+50seTdfriOKmZVFdyhqA+xWFKqcw=;
 b=WnDlGTq70tj47KoCPVCy/UYzEne98ozH5ATjPujVJAiQ5XI0tnPfS1BinfBGsHne6SQpsktoTBXjMqkwdBn9Za14g2FZxTTh39Zx1J+gkZdgR1oYuRK63wkktJdaqjdmHxTFx6yoSyNykCY+/qLPy3e/xgxcOdjaj5WeUPy8+Zs=
Received: from BN9PR03CA0501.namprd03.prod.outlook.com (2603:10b6:408:130::26)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 01:44:40 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::a7) by BN9PR03CA0501.outlook.office365.com
 (2603:10b6:408:130::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:40 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:38 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 04/10] drm/amdgpu: Correct gfx ras_late_init callback
Date: Mon, 13 Mar 2023 09:43:57 +0800
Message-ID: <20230313014403.21903-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313014403.21903-1-Hawking.Zhang@amd.com>
References: <20230313014403.21903-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6c5bfb-913a-43dd-8d41-08db2364833f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35MrpYRqKcRvBZhgaIp7ikgnydIGrPj7A9emk54HFOrJDWqFu2LPSqeBQK7RiaVTCKkdHVYK6KIFgbkWFG29JfwFMJ4gpqhRMSxvZDkNVlLrf+vjg9vJSfm7o6bz3SdhyQ071GMlN7qYVQ+fJsJqaXUzphtFGYFW4GZaAJa9ojQCtifTSSuw6Ug4gjMNBzoVlbTaWr5jzycGmVi6W3JN0zEWzKVwJjo2+B1uiFXpB6G7EBR6iADoqo9sqrfs+I4hDVW7nN45kNciem6M3lPnG8wMxsIk42O34PN6q5fFjoBhTo0jyLnoXu6Wvsb3QFqbSSyrae6pzDIkHBUZFT++Zrv7k3Jo8W7HG04BeAMEr7aoSVr4fdPBTE0RAiQipFwEZNaz3LdZQwLLDDT/Ml6bW5WuG6S6wppVONA0WdxjayXnIfTOsBRcvY21s3EvBvVVcxhVpDWOUk3QMvgkbS0tF6mzjJVHywC9CU/+i0F65p7CH4TGq0d1EXn7f9rjCzfPBoqjG6/5WXSHuULtv0/Vj918ksMjVwuYkC7n8bWQmrxANdBHzlhhKx3NDTrYS51c1Apw3oaFLpVILQwsIz3kddhJ5kMxn0N/lgJzBXcdVjdZySY5DfYc7iZ8lfkC9A3lYPmMK/YZD4rUMkDFwK/AvfFjtZpwoopdN4lE/VliIZkOR45qZoic+I4otnU03wMAl97b+SOFzIbTd5av6xKi1fwySK7NqhOXlJr03hxJdpg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(6636002)(110136005)(41300700001)(478600001)(8936002)(4326008)(8676002)(70206006)(70586007)(82310400005)(356005)(86362001)(36756003)(40480700001)(81166007)(36860700001)(82740400003)(1076003)(26005)(6666004)(186003)(16526019)(7696005)(4744005)(5660300002)(2906002)(316002)(83380400001)(336012)(426003)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:40.8270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6c5bfb-913a-43dd-8d41-08db2364833f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use default gfx ras_late_init callback for gfx
ras block.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 35ed46b9249c..c50d59855011 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -725,7 +725,7 @@ int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
 
 	/* If not define special ras_late_init function, use gfx default ras_late_init */
 	if (!ras->ras_block.ras_late_init)
-		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+		ras->ras_block.ras_late_init = amdgpu_gfx_ras_late_init;
 
 	/* If not defined special ras_cb function, use default ras_cb */
 	if (!ras->ras_block.ras_cb)
-- 
2.17.1


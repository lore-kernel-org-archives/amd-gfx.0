Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B70AC48297
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 17:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA2410EE75;
	Mon, 12 Feb 2024 17:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9wAvFGD";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2BF110EE57
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 17:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeDqJOT4pIcog9TshaYnL5nveCX6IzI+W4ExvcHDWueBbVY95CHEscK7+/ESPCpamt0uGzVuuwIkSgqdVrCqYkBz1iLhN35siUA5PfZXG9u6dS0lPYTpoDMHbH1rF7CElMNFjBCZByCYCH2SrelpSLsLTPl96O7ZRX9ZVVVt5RKvn1TfbBIJts/DaAimlAgNMggAXwxgxLK8CQU6aE5cAb5VsdEPH9pZLloWDKFztluYC5C2tGqMYoGX7HzzbefNKVPcrhwz19JPS9JS7cko5ocizHlJIgNcOqLqWoZ0XKcHWBeI+51ZuPvD+shxu0Gmdcf2/UNNLPbZd+DZVDpXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdsk1m3hjY1KrH582+mBnGqrnROJLB4Wfe5fF4Pw644=;
 b=Yehk+7Q7G2ClMiqumvkMx6gAYLIhI7coyqVaZNvSDxCEENvyPcwOrRnU768ff2NktoSOuMOEl263cOb2ojDTv/KbtkfmDh1IrL3gDHZ8ioO7HO+ZEloGS12+exEpppHwWFQmt3QlWlDuPlS/7nKlc6/YnJLiCh0PilAbEST+MM+9JiorYVbK3CZW21y9HyKCxEPse1jpbfx614co0oCboneeZHVdkJRwtdWn+kfvspop9r6xEUpSpQnHP/nHVYsnYtDMCz3VZ/wQg0rw06YmB0HLP+VFu4Z5qi0xUpWdpB94Jdao+VbBOeuTtTP7eMSHx/Q8KSIaRnBlKwcq6VJRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdsk1m3hjY1KrH582+mBnGqrnROJLB4Wfe5fF4Pw644=;
 b=B9wAvFGDyx49yVWEIuvda32Ya1JK5bc0XlxWtXaOQFNMM/CKqW9YW7g2p/DIElOkyEfSb8HUXzWfaszS7zOk/jmiHyX1yPmj7HOregkkjczXMLJpIj9xHpyhwqKH41yuNN47OGMPyvX5RrK2ZgV7m3TkRCd2bivIPUMu3bAZZUY=
Received: from DM6PR06CA0065.namprd06.prod.outlook.com (2603:10b6:5:54::42) by
 IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.18; Mon, 12 Feb 2024 17:59:10 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::fa) by DM6PR06CA0065.outlook.office365.com
 (2603:10b6:5:54::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 17:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 17:59:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:59:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: support psp ip block discovery for psp v14
Date: Mon, 12 Feb 2024 12:58:49 -0500
Message-ID: <20240212175849.433812-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240212175849.433812-1-alexander.deucher@amd.com>
References: <20240212175849.433812-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0ae748-ac36-4feb-069d-08dc2bf4507f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6p+ezSDvD5/FdnasBl7z7sFzQX7SrojKdXTL7WyXc4XrsZjJ/36iocV3sj3CPbmmYDaZl46HR3/k1fjXApb6nyKSAtMjoUkEZQPTwP1DJWv3f+FyHjiIYHdXuW2xWD0QOjPb9yb3+2GW40s6Br3oXohnC2X6dwvX7hzpvS68+WRnCamGBt56KArCANv/z3J6zhpfBS6+/iQuwT+75j4PxdHszzAUWam74Cl+IAZL9JS48DUlqcO0OW3yKE+YAewOoiNE81SU7/a91FJiMRWTspKOMozexLpTQNHZV8oz7lhPl+h3UC1vrzC4FEFCy4E33Zuw5cAJElmjgfTROQHEkN1hGjHcDfbtspLDBxFX5nlqhKVb9QOSIVV6/qxuTPGjxN7JgLh45uwVSPPvnGD6tWelvtMV7BjBZumFQZIEZ0QoGGodjbV7q2F37tkNxBWAftXvxk8Zj3gIsdjF45OcG4bDJaf1SadifiZAdp5//ZT8HNv6MecWMactLM+6IPfc8x4SyMJuQwWZPs5siaMOHi75tmo8HW8xhzPMR30sdmFsjhoVX8E2G843pzJtpmfIWOzCACdm9Uln6n+IfpgfkkwB1ZMlZm8Dt0xvkqVnY8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(41300700001)(2906002)(4326008)(8676002)(8936002)(5660300002)(356005)(82740400003)(86362001)(83380400001)(6916009)(36756003)(2616005)(6666004)(1076003)(316002)(426003)(7696005)(336012)(81166007)(54906003)(478600001)(70586007)(16526019)(70206006)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:59:10.1503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0ae748-ac36-4feb-069d-08dc2bf4507f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Support PSP ip block discovery for psp v14.
Add psp ip block for psp v14_0_2 and v14_0_3.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2b6e0eb5aa3f..5256df93a68b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1829,6 +1829,10 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 4):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_4_ip_block);
 		break;
+	case IP_VERSION(14, 0, 2):
+	case IP_VERSION(14, 0, 3):
+		amdgpu_device_ip_block_add(adev, &psp_v14_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add psp ip block(MP0_HWIP:0x%x)\n",
-- 
2.42.0


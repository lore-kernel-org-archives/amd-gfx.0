Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197F1C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 16:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920A710EB70;
	Thu, 13 Apr 2023 16:17:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A6610EB70
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 16:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElKXCXQ1ONcDhFdtJ3g4hAdpC0l/KOy1kGJaG25q1ZM43+nIupUxd6HFJrP9N2PSUL6Fs6mlG/Pyv6sQGF2fJLfb6zXXP5tghusEKzg31d2sg7JqutkdJ+wahGymNlzJzJPgsHSM/cSRZ9m/aL+rYLl5b6DDVa1UPdTTJ6/9VEriYFTFzTVCn7zcQXYO4U5s/5GXbfPck4OmoimoujSyGicHkYbVkV9t9nf/4Nxn/Dgz2vEM7B2MCVYsLTU/Rcfe5UO/HBlVPmeVGhMR/XqC0sXT0H5vD4QukZOxGGb/1HDm0vJ9uDsC93GKlsaGkvqHuarhiwNEhRH9kccVLWWNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLRs492Y371k5D9vCHfi0z+gZvzjLDqy4OFwz9FE7c4=;
 b=e5BU88szGUd0taWcDHX7lDFkPUbGg8UKHz30z3W/NgSZ//Jp/TEb4jHK+pnI/AXvN1ycjpbzUxHyS00UC9/QwgGbwq5P2Jri3w+q8Vnbgu0GAviz31K32pXmc7LOkOOzv1aYY5UcK7LqAlh3dY1ndBvAq/FjcxSfn+6j9dIozcQOgtYJgz7bB8lJ0Uvh246jBMjVKtWJdUjSDOrYZo4M7xXkS6YgERx/Xucg32Un3lezYm7bXYJp3eJXOBvps1CbHOK0LUS4B+wWQdGw9ZD0V5JgOGHWcMO3GcIzqBNBISnqGxjwV/JN+kBDInqZD0X4q8Rhvc/m9yJAk02+SBZlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLRs492Y371k5D9vCHfi0z+gZvzjLDqy4OFwz9FE7c4=;
 b=F8abbIh3DmXIaPVpKZGDfPDGKo3+eYzBlZTTT+QVfldJ1TkqVuIBUqh3rOEXs/1DeuKsg+D3RSqNmV0YnFVRTP8wA0czzamPNIy9iEF4NSY1EOfJieE4O1Ei6XOJjh10A5unBIhs0yosv57pFwpNcTZYQhrsw/j91RMrn4bzs84=
Received: from BN9PR03CA0381.namprd03.prod.outlook.com (2603:10b6:408:f7::26)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 16:17:23 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::ec) by BN9PR03CA0381.outlook.office365.com
 (2603:10b6:408:f7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 16:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Thu, 13 Apr 2023 16:17:23 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 11:17:21 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Improvise error handling for DP sink power
 states
Date: Thu, 13 Apr 2023 21:47:04 +0530
Message-ID: <20230413161704.2262865-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|MW3PR12MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: d5179508-cecb-480e-c08f-08db3c3a9065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeH8vAHq8iKwr92tnQFy5PlREGxAQko+V3CXG1j+vFxkaw1V8FNTLNuJa6I3m5zfWC86Et+tgNZs9UKLmgcpGeG62duD/ZucOHPFyALZ4Y9tFUlYz+ygeFjRqUsHfGENNzvbJvF0nD2/81Vqsl2qbxFYOC6T0IXHSY6Skz3JMunEJZAkrqbPYMHui+4rxNPdBPtkUZmlJSpWFzmvAbrRHXAEWlHN1YhqSr62x3qfNul2xZScK+s6nPPdT4FKkvNqa05bm82soloIrCJPf4tkGtg4o5o8UwMFGFosdoa55dI6wdzBAM6bZYkPHQQfQ3DsRdCodFqqBQx4/u4T3qdCETr8dpP/nSrD6KHA82DZiriwocH0mkokx891rsN2KLDAIO+SvYDD0MeJd+07ifcAGwNNH7Af7oWE9bf4MpbRgaGFHYlk274f+blk8EV23MOnIVbIF106dCIPRsfeURo6tZgPgeVvrXyE7B9x22AARtwFhUiAF7DHnvls/X7DY1xp/mbaQpORNpzNZsDtdxhyPNVo09AoMh7QeSN1MxZp+CIiPKwSHV9GKx2oXLUH9yiKjckauxaWobEGMs58pE01ORoClqlA2h/Vqrb5MeLarbn+cDvo0lkqaDvVmFctzCU3aM1QJUKrKrRYO9pEaSZPBwWj5Aq0REkJFlDE3eagAtDetpcYHW/upsdFDyykBDiTAnZ+PwnwbAyTHZS1LeToaDbcq7+Y2nvm9/ehGPyDGlU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(54906003)(44832011)(110136005)(6636002)(40460700003)(478600001)(356005)(81166007)(316002)(41300700001)(82740400003)(8676002)(8936002)(5660300002)(70206006)(40480700001)(70586007)(36756003)(1076003)(26005)(426003)(336012)(16526019)(186003)(36860700001)(4326008)(6666004)(2906002)(4744005)(7696005)(2616005)(82310400005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 16:17:23.0945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5179508-cecb-480e-c08f-08db3c3a9065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Log if we fail to setup sink power states.

Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index c840ef17802e..adf6a67e0e5d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1043,6 +1043,9 @@ static enum dc_status wake_up_aux_channel(struct dc_link *link)
 				DP_SET_POWER,
 				&dpcd_power_state,
 				sizeof(dpcd_power_state));
+		if (status < 0)
+			DC_LOG_HW_LINK_TRAINING("%s: Failed to power up sink: %s\n", __func__,
+						dpcd_power_state == DP_SET_POWER_D0 ? "D0" : "D3");
 		return DC_ERROR_UNEXPECTED;
 	}
 
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ABEC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Mar 2022 11:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039E410E10F;
	Sun, 27 Mar 2022 11:19:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C1510E10F
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Mar 2022 11:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROICiIP8crTJ7KpiHpBVXJVQHqvO1V8/zgzNQ3N3WfnJJnIgVxf9/YVYQ7zjA3oO4MxPaab8PF9GlAFLGV0eU0qcdzcjAjTEYIHURPTtaqaNiqXRY4KvbpXWUULKlQ86b53y8L5nNdABBWQfvwFDDdoGOlZerbDub38xD9ysA1YvJ19w2Z0U3W0qX9E43yyGm6Dtox/G2Y1aWvtqbdG2IwUXCKlRjuPTH85lukFBuDsjnzgR0+LDMa9mXEx1CVLwb8Z5OUMF1ydwtHNvQJszVPAcL48qVzCLjvcYcrh2IksN94++5sPzhJ819n38K9A8Sqv+KEaxIgPFh7wU4Xiuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCBTUI2CHHpYr/4sV/og3UwWhOIFC4mXlR74hMsPYZM=;
 b=kINKnIOdmtoMcOGgMTT7lLPYu0PqSaSYItla0uICyt5v3BYWxPa0kpJwqT3BDoeqUj4udVKC+c5cRQ4DEoJPr0ZL8D3RQhSFZS4DqnKGTA/zQg7rvxP7sJi2M529mQ+7fu8tvkK1rhQ6pqmUvQtp9EImk2KjWG3UZJspNi9i+Z0x+PYbQ6tIRVq62GzjfBMZ48OervwrUEl5/xgrXczO/cZdBaAnPtshboQV2zPDZo4OxZhHil9o/TsQXXdJ6P1zv9YMz7OfbB+If1DadwxX1IWEr3c5LagKTeXIAFpk/yHCi5yiIri3FB5uXeDtdE/dkUwAfxvgrjE2K0JbDFIBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCBTUI2CHHpYr/4sV/og3UwWhOIFC4mXlR74hMsPYZM=;
 b=s1Tp9y8e2jtLtYLb/yx+q81+itq2ImGimlTx4nGyiBvi2KAgdA3esMwOCzcZf1Oc5hlfxtn08CImsswXqyxvwLlB72Dmg2+o46FBtUJD9q64TiFNrBLWb8eCaAZyNouLS46jd7b9ESCOCShw8ycbVfjWk7BI/oNFHQpTcI1Dq6g=
Received: from MW2PR2101CA0014.namprd21.prod.outlook.com (2603:10b6:302:1::27)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Sun, 27 Mar
 2022 11:19:04 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::fc) by MW2PR2101CA0014.outlook.office365.com
 (2603:10b6:302:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.15 via Frontend
 Transport; Sun, 27 Mar 2022 11:19:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Sun, 27 Mar 2022 11:19:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 27 Mar
 2022 06:19:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 27 Mar
 2022 06:19:02 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Sun, 27 Mar 2022 06:19:00 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Date: Sun, 27 Mar 2022 19:18:57 +0800
Message-ID: <20220327111857.1372675-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3d343bb-8fae-416c-3809-08da0fe3998b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB530858A92BB099C8890D54F4951C9@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9W6dtPWaygoUIkWrYh0gft1Mo3sB7ds+RSYW5mZLwT6/7HAGDz0fXjGphUOQYIuM+niSLYsFquLt6ULeEeAIVn8UEiCi73itHoKHQWCCEHHx8k/EHusBmjWerJqJx1Gft6OFZjqv84X6K6dfnzkTT7uLCJllsMTc3b4gZZBenc6QrBSyd37OZvdLdg/yEA9HvXcGncJfc76AP06gIy7+3IzHMxVGnVeUt7OvO1zqvD6qB0vBxsgLxvP13fqNBxRVbQDzapfuz56ejIgz60uS/Q0C1nm/9eH6I1G6w91dHNgLxttNX1rQHcWlZOkubud9WV0paxOO4+jPmEyZA5RnPXWyDzkdB4RINwz1r9ZoSo6GHhqLzGvsWDXDetT1+4w9O7wjZRJoY5WxeFdfbwImZFKqgs43fsXhMKHurdW1y12gVB0cH2o44k+7RS7cmgn8KnmdMRk7npIyhwTlMCsv2FrW0Jhj2/NZiW8ffxWmYAKtLZV99I3kN6ANtZJTM+pAo2RKorOOnK+N6gM3PjbvdWwfsr/h4xrN//C8ak+k+c/gqLeV39vleNeliKJfyYLfuv0ovf8X9FyTaNmDgCSi0rJ/GoqC/LzdqKN7ra9rvxakuXneZHJnoq0iRiM787AsYhar8fdgOTdtacYBWJTwn0ZOT/YQv9uZKxAMGO+mJkdPAmY0eTyHVrl12AKJ9vPYJEil1hqKFc3C712VpujcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400004)(83380400001)(6916009)(86362001)(54906003)(44832011)(8676002)(4326008)(70586007)(70206006)(508600001)(40460700003)(5660300002)(36860700001)(47076005)(316002)(356005)(26005)(6666004)(81166007)(7696005)(2616005)(186003)(336012)(4744005)(2906002)(426003)(1076003)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 11:19:03.2502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d343bb-8fae-416c-3809-08da0fe3998b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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
Cc: Wang Yu <yu.wang4@amd.com>, Zhu James <james.zhu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: tiancyin <tianci.yin@amd.com>

Some video card has more than one vcn instance, passing 0 to
vcn_v3_0_pause_dpg_mode is incorrect.

Error msg:
Register(1) [mmUVD_POWER_STATUS] failed to reach value
0x00000001 != 0x00000002

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index e1cca0a10653..cb5f0a12333f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1488,7 +1488,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
-	vcn_v3_0_pause_dpg_mode(adev, 0, &state);
+	vcn_v3_0_pause_dpg_mode(adev, inst_idx, &state);
 
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
-- 
2.25.1


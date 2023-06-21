Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4F8EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 01:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A3A10E39E;
	Wed, 21 Jun 2023 01:30:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F4C10E39E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 01:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHCOYN76KirLDf+Nyn/wF6urAoy6wSCTRY9amhhUH2p93SYonpCp8gcAzy5DrdSQnwuOksajYNQ86KqbTYWohrNDk0EiWnrpUtYoISrUEJO/QfAUNKEOEoFbtzLzjE/2MY7S1gVskfj+1cchcCv8O0sNMZXZ5FWmbi4wyjfQOjrS8EzcLMxDQlEOfCQwcJ5WpNNPlfvZt4WXeyMktnYpxo3QHfT1oV1WhBZzlka1FgwkEgxecjZYhXqTvm4Sir/8jo/H8c8EU6tLRKadf8uMNGMHd0sd6n/+59PjjQM69GmiUXX4j5QQVeGaorbjEEE8m80zQbjyrKlFb6erEWuWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWgwEV4QPTQGYk6LzM9B2J/EqiQ2gTC+xpeRiFIXFDg=;
 b=Wp+B07CYHYixA8zAuuWltZ6vtY1s/6L/8iGPBPQC6VtBZCFv3olqNpDa2CxELSt7PXbGlb3AIg2fDfMePjweq5SzqvkEQcxJpf5ggy8cT7UNDsjcl2mB+BWhPj3oalIEIK67Ow6jBiLZrhP556e4GSqIsolezGR2edN1nHq9ynonZydDHqAikgiDBvnTIdMprNIftJ2XfE2e7sRUbquaZd7VWHcgLAhl1KqTGIbpouYG1arLR+ZDgpsJbmYLEEJZGQR+KHqVzW3yW5KUj2xvGSTomYWAfzFcwhTlmGX6v6gOfiH2R0zRoniHH7AhUYOPRzfhbMnawr2TODOCvadE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWgwEV4QPTQGYk6LzM9B2J/EqiQ2gTC+xpeRiFIXFDg=;
 b=C0flP26gxnzVWzvfDdI6X8rXzMCofAUrO+GsnFWvaTOIBwDYO6QJb+Xu7bLHbecLoRV9pAFhJcY0CYWwQ20ffoTGIIjc9gwYHjLbeBHuqgVUKuAheNnPAar75vYFKNHI6GXlSEHplsxvAhB+Tipb7oMEKPCcRQlLIGaiIwEvEaI=
Received: from MW4PR04CA0360.namprd04.prod.outlook.com (2603:10b6:303:8a::35)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 01:29:59 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::70) by MW4PR04CA0360.outlook.office365.com
 (2603:10b6:303:8a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Wed, 21 Jun 2023 01:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Wed, 21 Jun 2023 01:29:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 20:29:58 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Tue, 20 Jun 2023 20:29:57 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: Need to unpause dpg before stop dpg
Date: Wed, 21 Jun 2023 09:29:54 +0800
Message-ID: <20230621012954.2273614-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: dbef280f-68af-4164-79e9-08db71f706fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmHay/kKPXfhYl2edz+bgBSDaTJ3Vvk1tTEVu/x+63I71+CUC3cNqMMnWrm+ZmOGjDu3oocsSQ7Z3Fi1F1OoAhBqqoJmUkkgV/Yh1GuCrvO+fAMCgV7H0v625UoTwDwTcjMv7a8ekTtuKfwHUYkank8rWAW1+nKYOmKQcUfOZeJNOz3LQmlJxhAtaJJ40ko4gp2Y1a+W2rHOuyQBoO6dU8S4ZHRA/adJYumElT/RvAA53X5yRTPPvY/3xgCnbJtCqAl3H8m7/fyLRcNpo4+v+Kik4tHT8IN5kZna+wDR3TRZUUmY2uqrhpVWntemqoiKQTsQVKXqE+Q9tMDJmx8HatkJZWNK/9Bxm2rDR0YybUr40VYIuAxU1tYTEKzIXHnYhbc32Ax6rjn8C1sGw3ARg3IIkpfY29cCXrdF7BuqGZZva5Hml4xn6pALoCNspr4JgSmmkc9TdLmByLRrZPp9wlpPuldVoyBlHhvsE4w4B8MaPcX8AgOg6RHeCfcYF9VpC8H/hlCJ/enN9z3exJNbPTYFkU0W+zrGWvIpKQ9JfAaSDk8aw51sfGNnfxCoIIYy9/5DntIZmNIkN5jNxZsq+P0uU4A9cE1aDNEItPqcEBoFFss896ML73ndhh1CqG4VkGU2L7HJZHX9XesW0W4jNPFCZaAMXDWYHCBIKdoulGpdcAjH7S86iliPdBPitBy3U9b1csRTf1PpakAOggEH0z3mLSSF2FzofQNxKHZ6LsM+2AyJbEB7nLqhaVIailFVMBY4y/W/uhV7CBaOTnCWvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(2906002)(4744005)(40460700003)(40480700001)(82310400005)(8676002)(8936002)(356005)(81166007)(426003)(47076005)(86362001)(36756003)(36860700001)(26005)(82740400003)(70206006)(6666004)(6916009)(70586007)(7696005)(4326008)(478600001)(186003)(336012)(2616005)(41300700001)(316002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 01:29:58.9565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbef280f-68af-4164-79e9-08db71f706fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to unpause dpg first, or it will hit follow error during stop dpg:
"[drm] Register(1) [regUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000000n"

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b48bb5212488..259795098173 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1424,8 +1424,10 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
  */
 static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 {
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
+	vcn_v4_0_pause_dpg_mode(adev, inst_idx, &state);
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-- 
2.36.1


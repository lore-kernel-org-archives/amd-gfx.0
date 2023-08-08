Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344ACC001DE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABE110E1AE;
	Tue,  8 Aug 2023 16:27:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9220A10E15B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 16:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7vYnq/zNEvfsp0dRXHIF8QBN6GPKr/TaDgRm/vjKtaDwwKuBwHujSoCmdNy2vyte8dnebilg/xgTCeWbjRWvOGSH1c+2NPomOHFTRZFsv0LtyxMvSCjWvvzN6VWMkzUN3ysJ7QP7MIWXXkrrb7F0rNZ0u50ABu3PUATZ5nsY7JXoOxxnwzH1Jv7/A5Y4RmRyNdQOZPfnycXDbO0vU89uQgaYVNgJ7snXBKxEfLEHfh9z0AxIMxpfzOTMY3OyeQ8o4izgFyWGg3IFrcMt9z4TeKSUu5d/EAuESaF5fYZFPU676MEQJs+gfvrtWcVu+pDCCwjO/BNEkWeSPWmhFN0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvBKmCbhYtTor+74ioYXQIK9BOnnxLuL6DkvSVQqqmg=;
 b=IWMLcwGP6kiiWZ3hStysBHidATYdzs0L430VnrWI3R6At4Jw+/n83VzmEg9UhOH6j6VLT8KfX6fUruOOIRjUL+8sJ+nFWSh+NGHX7NTojjRWV2LrQVsFkaS2DI0l4KcYnrQ/YmhCcbnRbcjXyZF0bFjcIwIRx31jxQSKygYZ9sXnl/i0ni03S8o3xBTJbHwIfrcBDNWG4DFmMp/VhJrhZ/mP6W7MfOUe/sVS/kY7dyRJvLOEEFxH2hiX29+V0nANGW2Up6UlkyoSZbpemI/ofBSco+zE/2u7lEmkzF/+sBbP+TR0j+xgVIN9/mvt+vuoxkzQCmVRIkvlWGPtKvr/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvBKmCbhYtTor+74ioYXQIK9BOnnxLuL6DkvSVQqqmg=;
 b=wHIlJUl9zQLYMuWVERIu6KAKYEk3/Zd07R0lJ9zo6LXXu2m8C6vmbz2FPTDpZR7XPfvXL5sqaJ+GTWhxR2yooGAfh8dB9syeEavj60Mi8o/7uLHV0ssAn/QcNjZ4y26j0o+N3Rv7bMSlx7jifSJ0r7Rnk1Fm/fk2iomLMt3M8K0=
Received: from SA0PR11CA0001.namprd11.prod.outlook.com (2603:10b6:806:d3::6)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Tue, 8 Aug 2023 16:26:59 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::b5) by SA0PR11CA0001.outlook.office365.com
 (2603:10b6:806:d3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 16:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 16:26:59 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:26:58 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/7] drm/amdgpu/vcn : Skip vcn power-gating change for sriov
Date: Tue, 8 Aug 2023 12:26:17 -0400
Message-ID: <20230808162622.74937-2-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808162622.74937-1-samir.dhume@amd.com>
References: <20230808162622.74937-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 06723c9f-c6c3-4bf5-c3e3-08db982c4a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrLvNmyEQvXxCDc4UzNTqc605ru1Ly697v6A1SISjrKUiZ+I4xU+uSmTI6KpdgLZZpQ8eVnqpHYtZ8JfIHzykN0jnEVduVz9po8sXc/k7OaYL6dFeq9AlzW4YBDkiGYBjXWZcIiuhFU4UNbR8hIuc+D2F2n0p3LC/9et/zoTPkxYszkYb48nT5Hi5K84+T1MbygYw8SaR6yL7NnwStgdlwxH2Lsb9q7tu6NcZCgdsyaeUvycDX6Qvz95JU22E+lm8hQkKtfg0enyUuCiQ685rfrrGIHYJB76mmXZl8se6PA8dPO90PoqZN29rmCwvYk0d/F3r8r85fNVMMF5L/n0CD3tFltwMtk/DYjoJDzasmjFKRfhr5cKtrA2Py7sk6edE5xpHFgF/gXeRcBImhchT8xQXRn0KjXG/dsK8qpus6wC+tviMhvYLDLky5IFnwBvU+jux/9fz8fZm+DejXEPZVWp2t0uM/ymhrgJNqNG8xaLvGb8sF2H12EbHFTVsM+HtCjlIxAqQqVSOzmjXBcibTPc67muQ1Mz3twZv2QU73ZSUNmpGAFIun3R7k85G2rUZeV9cGzP9uQFQrEaJJj+KhWizQgLdzd5hKwpns82LPHgtyuEe03zjjGGE0RZWX4SdE99Tbwq5iQ7mJgvTwGAqpLcCQ3B8Vs1YfmsTE8d7YdsT6/ZSTOtZPSrzQF1nSYV9o2Y0RCz2oCIQZkGY7//ptU6VHmeQJXC9BN9T3lVXXxdjz8fA6OL5L/LQC8bFc6y8aXmjebNY8Wn3Ccp42uWhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(82310400008)(1800799003)(186006)(46966006)(40470700004)(36840700001)(426003)(44832011)(8676002)(8936002)(5660300002)(4326008)(6916009)(41300700001)(316002)(47076005)(83380400001)(40480700001)(86362001)(4744005)(40460700003)(36860700001)(2906002)(6666004)(7696005)(2616005)(1076003)(26005)(36756003)(16526019)(336012)(70206006)(70586007)(356005)(478600001)(81166007)(82740400003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:26:59.2666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06723c9f-c6c3-4bf5-c3e3-08db982c4a29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, emily.deng@amd.com, frank.min@amd.com,
 alexander.deucher@amd.com, Samir
 Dhume <samir.dhume@amd.com>, leo.liu@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 550ac040b4be..411c1d802823 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1317,6 +1317,15 @@ static int vcn_v4_0_3_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
+	/* for SRIOV, guest should not control VCN Power-gating
+	 * MMSCH FW should control Power-gating and clock-gating
+	 * guest should avoid touching CGC and PG
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if (state == adev->vcn.cur_state)
 		return 0;
 
-- 
2.34.1


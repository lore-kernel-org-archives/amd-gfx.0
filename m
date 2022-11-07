Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C054C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 08:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C60810E05D;
	Mon,  7 Nov 2022 08:43:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B693F10E05D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 08:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwj48QPwnex3eQ0vLEb/tXqFLk6XXQyl9wF/KmbEZDUKSp+U1Z+PGg+u8jKbaLXS08Gd0gACW0qdH9zsr7Bd0NDdRcWW6UlujJSlpo6MZ4qoIq+BDihW9+DN42XMeCn3XltkV49LINfgdjnNPM36xrULm+wE55wes0ffnnQjHIYuGj0hUh55VhuqCZtEB6TUFX2HpzdXsaYZEEKsnCwF1fCOtVNFHdd89hdsBDY1K6e5PNqQ5ADVnc4efwCYGHqKqc33K4eD0iGL/CL82kEZkpndChPkRzH2yh/kH/w9+WNvl0eQpiJd9Ve/bgfjW//gxu9Tqtm57encjqFTDkwV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTLMSbQGPYRBqF+2murFx7qXQ7Eqi90kJ/tpbsZI3LE=;
 b=k6CQwVmImMdxyPg3Oad4MoSyJM0i7SmOewvyS7wcgWuLdFuZj4+RX8oBgl1+aU9j6beOo/eBLfkKKNptI4nEikh2VuFikQVKFc493Djq47H3lF1cmW70KwoPGZxibq9zP60W9Rsyh4rH1CL0HaOc0l3x5egadEinYwWsSW2mg/+LZL2ih6IW1bYCxQcJecGyRvEcMOlStv+UfuFiJBr3CE8iK4KKveEjO11akcn0z2cKqh8g3S3umt8e0osdBjrGQOuei+8ifydgepsur6lZISrGbRIc806v+bIiKk0xNVkRyfoIWgO81cEV0/IrQpZGi1HRA+61KUPnJObqUG6A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTLMSbQGPYRBqF+2murFx7qXQ7Eqi90kJ/tpbsZI3LE=;
 b=noy8W+NXCa43n47HYMFyRSE1Qkf521SiLtAqyXn7zoUTjotDdZETFq4nAYRTjmHVU3DSnyvtym6bznnCk7K/JwCYWVW3cFetfB8Oz9Wd5h+lTWsiV+vd65XltmBMmFTMvkUzoo5KSRBl+ejhyOsvk52hj7ljFLukFErLd//bL5k=
Received: from BL0PR0102CA0029.prod.exchangelabs.com (2603:10b6:207:18::42) by
 CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Mon, 7 Nov 2022 08:43:43 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::4d) by BL0PR0102CA0029.outlook.office365.com
 (2603:10b6:207:18::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Mon, 7 Nov 2022 08:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Mon, 7 Nov 2022 08:43:43 +0000
Received: from ETHANOL-3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 02:43:41 -0600
From: Harsh Jain <harsh.jain@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>
Subject: [PATCH v3] drm/amdgpu: complete gfxoff allow signal during suspend
 without delay
Date: Mon, 7 Nov 2022 00:43:10 -0800
Message-ID: <20221107084310.3316535-1-harsh.jain@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 587a9541-b090-48f6-b1e0-08dac09c2d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGW7OPswzBQTwhc1BFq1zcFX18q323qXMP2d4CtuYrde/hMLm8HOkXhWXb1s62gvzhjSYLoBlprfTAYvrsBEKO8BNBRALfFLZjHvK/CmJZtLFiNN3M+EuwULT4qKhIwycFGib3D4P/0SRC2AvjKiBb9iP9aUxe/mZVIyAeuZqSuTlJEwnFz7P9LavMnKkHGZXdD67JzYj0wxt5bu2eDw0qB+0wxHzeHrHjhkepUDapQ0AxPQ0M9amca5AIS0xeetPDNbYPjl7C6o6+WQVC/d8GnSfSHddPpXp5N7ZIHa22iNNGn5JYtSMI9ZCk1G8VL2InjWa4JvdaaQrMHGUpsBxZwr/DCupszwPHzSINZyjjfVTJ20/E6Yf1jUJiwGf9bn6XPgtuLNuZiKV4bI58ve3YsBOaa97gYy/KLKdDZ1xeEEJyR4UgddNz62B2/QTsCuhE+5LeBN50QbanDZwDZ3iMl+w5KVogzjKMtQt83GMzKoBSwrf7TdxBQ3qiFHD3UAM0UoCdxD/5D91W7xWNQcVWq54bMixBYiURbssSzPhQDBrwh5N9E/5xJApy0LX0PmXS/f80MBZFx2LtqYBNmJjPrMAV0MUV6iC1pLU1RlH3Z8DPGbdTqLmhMj81bgYgfsjg8Xpbn19dsYXT1XkdhJTnT7bWGyReesYNzfx5YjNiM4UPX3XjWXhaX8NBJmc+Ob18gnb+XnLbGiWK9LrG69xJKVrI1Nttjb04RcSGbhSoVoHRlUC1wPxPqr09EcZdzo2t+tuCfSMCY0KhaGCS7uaksMgckG0+IGRxXQnwIsros=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(426003)(186003)(336012)(83380400001)(1076003)(16526019)(7696005)(2616005)(6666004)(26005)(6636002)(82740400003)(36860700001)(5660300002)(2906002)(15650500001)(44832011)(40460700003)(40480700001)(316002)(110136005)(82310400005)(478600001)(41300700001)(8936002)(8676002)(4326008)(54906003)(47076005)(70586007)(70206006)(36756003)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 08:43:43.5930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587a9541-b090-48f6-b1e0-08dac09c2d74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
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
Cc: Harsh Jain <harsh.jain@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

change guarantees that gfxoff is allowed before moving further in
s2idle sequence to add more reliablity about gfxoff in amdgpu IP's
suspend flow

Signed-off-by: Harsh Jain <harsh.jain@amd.com>

---

v2: replaced flush_work with direct call to amdgpu_dpm_set_powergating_by_smu
and edited title
v3: added braces for readbility
---

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9546adc8a76f..23692e5d4d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -583,10 +583,14 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 		if (adev->gfx.gfx_off_req_count == 0 &&
 		    !adev->gfx.gfx_off_state) {
 			/* If going to s2idle, no need to wait */
-			if (adev->in_s0ix)
-				delay = GFX_OFF_NO_DELAY;
-			schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
+			if (adev->in_s0ix) {
+				if (!amdgpu_dpm_set_powergating_by_smu(adev,
+						AMD_IP_BLOCK_TYPE_GFX, true))
+					adev->gfx.gfx_off_state = true;
+			} else {
+				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
 					      delay);
+			}
 		}
 	} else {
 		if (adev->gfx.gfx_off_req_count == 0) {
-- 
2.25.1


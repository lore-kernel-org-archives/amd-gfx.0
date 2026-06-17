Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A1CCD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 10:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FCB10E9BF;
	Wed, 17 Jun 2026 10:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BIt8A6AG";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4AA10E9BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 10:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIgev5rZf09f3rFZyC7n36mOPtsPEhKhOAc4ROj+QFCxQ9icGt7SOUpGHrKEtqP4M3CicQRbKiCf7dnXYBWwLZ84YXOkbHaLjfVKUg8ij0CvWS+C0RJHjbHLQMmaQ5fMkp5+xWG8oPz4AKNMEFUCxfIV6nGoUkJ8Sd0NIlQkzqaGTGwGJRjaTujHScxrys8jj1vQIHfdc9at2huymzj3U98Ee+ZZoUChwsPL225mAupLw5iv+GqbH3v+nWpHcfOQLNCcRzWA2kX6Uan/S4hN2uKIKoGArYrOl91L9+aHyWvBlihtinph0k9I75VW/R8kl+y3WUPZTqXLpHLMVDpDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owLF2fj7v7YYw5geXfrUUK4oD09JZeTVi/pPk3rsP0M=;
 b=OH+zKl4PwFcBRdKlut+crmY4XEh/BKmsq/yoUE5NdWQbPvlEtBF9RtCAIZmfhlEBHPZ9+Ht+6txk2eFIVFPf9GVnNPxdrDEIPGtzSw/YhH49b1MA44aW/leR8JAhUWrrFKIUV4XbP3qXyKOJzh7EBwHABLSmfQDK6w+MVlgbchK0arZlTXoaQzAx+4X4FeSaZ0NMjWtNpIK9zAVpb8+X/df8sm6PwaQTyC3kEZXWoUosaIFWIqw+mthKfb8Hmid6UMoi4uo30O5VI33CNqLhynZ+dH3CR/20+5egGDuawneY++mkf634AVGo7rW8IWAPY90as0jFSBq1SCa7DwYXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owLF2fj7v7YYw5geXfrUUK4oD09JZeTVi/pPk3rsP0M=;
 b=BIt8A6AGPwRS1qAp/bC1zoEGBQG0abXmBykBqT+7Bj6Nc7vYzm6qiEYJXsBSbyjlOUUGY6vHActt7FuV3uX6vQ8s7GlVDYkCLm9uA3gMdOe3wjsiADFLUxjjnNrluJ4+hqwLl1JCmuymN9WTHhBXJfauLV41r1SS2aBNP8pa4rU=
Received: from CH0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:610:b1::6)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 10:26:42 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::6) by CH0PR13CA0001.outlook.office365.com
 (2603:10b6:610:b1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 10:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 10:26:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 05:26:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 03:25:51 -0700
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 05:25:49 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 0/4] drm/amd/pm: smu_v14_0_0: DPM clock fixes for Strix Halo
Date: Wed, 17 Jun 2026 15:55:48 +0530
Message-ID: <20260617102548.11781-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: d729fcbd-f2f9-4f44-bde1-08decc5aec57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: W1rsVrHSGZYaijuzbsxI8W8JGUX6WIWNu4Xz3ROI7Kau8bL90yOqbnqgOgIFJsXG1vFSgMIAMiBj25CzJn67R3+G/vAES7facmsWfXgsjoAhZ5gqryg/l8bvFEnED8ggttPuvgamydpJEC+mMiE6JULqP6oYT+/iYV/eIMboUrbZrA9Q8y3Rd6pjg/I1Ewl/Pda9jBPB+6fSj+CmqGzxCJrSbMo8DV9uixsu9Lx758DheNb1E49AKM179dB6vfX6Emef9iT3i7YAlDtd5UwC9UPt3MtpFpnyx+9Xe43uGZHjfp3Q6D9IhFMAKPUAm/Z9gghQJNYeunoe1O6j8SE9L3nNSMJ7IzJg36ae4Ju7lN5VhYs6XGHXNTjxW1f2nkKhEFrN/bmHvKUgrz/xE/DNE+hcEPzTZKeh6L7HX6f9cW7OGQTPF/od7faiDhj+Gb+ABNkdaNVkNHYf33mqci2ORzfHnhNxVg9tdABVVaFTVDHBQI8JGqUeGltRxJDzubYGautzEIl0cwGEqpeKhxyZahcDV1lW6LO/qudUXN36kgr8DGABtMfI3hs2COXP2AAY31H9QU0iOWvZhu6RlnZF9nxAN5F+0+2xTD4qlGRaK9rH7vJldN7Jl8bVGYXXVouhEtOkeuciO6kIuEjzHkl4QdL0xdKDoqVCH4Kyi0R7xT/Vb7FyImUCdL0f4+0mGlDvebZegga7ZL0r0v7SMdT0JhmFBzCW8clmeZyZ6q0CLK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8i6Sca3ND4kw91tqUklmwDAVH2ebdZTioabpQLrvk3JLDx+Gqbgep3pPWQTXQyL59T+F/Xrj8U030FOD26tH1TDBNOsw0iX7awYjGKV9lKQtorsNYiWdnKhSzWBMH8W4hCdhJP/LrhXH4Ncjnuc+337PvmgpNFPOyoUykphly/OctfvpE8pO3gC7/vvOTxLVy+Euo7nDzKtghAud6G56/9gy+BJ5a25ufTrZaMGjLuByLoJr4vm0ImEV/BkHmdX7FAvA0rGN0LB7KVmP8V0mJblHxZQrBaZlMOdOuVVzUfCNy6WHbaH40jKiltMtqDLmaeErdcsVvRW6pEVif4HB4OzGSRP0pIRobpahqN9WOr+E23ylYjWxYtKLe57TSAa3+wfh7L5/4SytryDHAAEzS7dfa07rba+DIrB3LB8EHPkRJ3Y07EPR3P0omSS6dAJf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:26:41.7216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d729fcbd-f2f9-4f44-bde1-08decc5aec57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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

This series fixes DPM clock reporting issues on SMU v14.0.x APUs
(Strix Halo / GC 11.5.x / SMU 14.0.1):

1. Introduce smu_v14_0_0_find_clk_level() helper and fix DCLK metric
   reporting by looking up the VCLK DPM level index
2. Expose vclk/dclk DPM sysfs entries for IP_VERSION(11,5,1)
3. Add SMU_DCEFCLK support in DPM frequency queries
4. Use the shared helper in emit_clk_levels for closest-match DPM
   level marking

v5:
- Extract smu_v14_0_0_find_clk_level() helper used by both DCLK
  metric lookup (patch 1) and emit_clk_levels (patch 4) per Lijo's
  review feedback on v4

v4:
- Drop early-break optimisation (Lijo)
- Drop explicit count guard; rely on for-loop (Lijo)
- Add Reviewed-by: Lijo Lazar on patch 4

v3:
- Add closest-match DPM fallback (patch 4) for MCLK/FCLK marker
- Reverse DPM index for SMU_MCLK
- Add SMU_DCEFCLK support (patch 3)

v2:
- Split IP_VERSION(11,5,1) whitelists to a separate patch

Priya Hosur (4):
  drm/amd/pm: smu_v14_0_0: fix DCLK metric reporting via VCLK level
    index
  drm/amd/pm: add IP_VERSION(11,5,1) to vclk/dclk DPM sysfs whitelists
  drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in DPM frequency
    queries
  drm/amd/pm: smu_v14_0_0: use find_clk_level() for DPM level marking

 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   8 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 105 +++++++++++++++++-
 2 files changed, 106 insertions(+), 7 deletions(-)

-- 
2.43.0


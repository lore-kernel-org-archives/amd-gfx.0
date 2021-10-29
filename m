Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B225C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D6660E9B
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5D6660E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA326EA81;
	Fri, 29 Oct 2021 20:32:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636CD6EA81
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 20:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaLpVh/g0FeRVR7YWA0LeX7WDb1n66XDqsJKKkwzDxpnm5VBkAFIMnv+Sgngtf/TtN1Njo/9/NSHI82ukF0La9QILLpz0tmLF9vcTy1Jz62uVlYC+bKmHs9ruA5gNaftq3Q20zAyONom7YG2neyEnKz/P2A3pJ+JVvP6j29/lerLqjH8ugS7SpRSY3/pLFRhS/pcSHEyIjmaFtAITfGom6ymLr0F7JDbaQ+0RqcdPbNmrE1gtRWtcINL+A4oqRReWjVl/dFaTD4sz+t1GAidkDmJVNSWKIzVsRdg2HsdeZJZ7VAE4MkVEQQUiKUZl/JANF27hVcQpxEdvs4/pvoHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMgVnmCJGm2FWqfu1c+xaVw+C6syR7juDcj04mNJc+4=;
 b=T8i/6kyRqqJ28350kD74MKI4KwugQGR3xJOAAsr36xdRHQ8t5yHWVD5fVO2QUgQ7wccfdBNvRFeLU7bNQ0shFwEzwerIe6taiMNTo7swWRtwwMIml5dqfsWaLfp8zdgxQQWAmJmKgLR7cEe9ld6MxXBXed4zW7QP3cg93pg41JjmdXKn47/38lt1lp1iEqbH0SdTiA1DMVLGQh06qB9IzrtOuT7NJ9UCRqxeZySCftlNOTB69MS8rt7NOBekqZHOxWDDccg0gfmb6pcVoysV0QvAcZ3HE8sgjRHLskosg6N3tr6ZaO+RUVNlA92sxqnezT2aBVTw6JcQPljysn0RWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMgVnmCJGm2FWqfu1c+xaVw+C6syR7juDcj04mNJc+4=;
 b=wm9k2Vnib9LZDmhlXBgek2YBSqyVrCcgJoJZcYOt4QF1RsjZ+xtuT+wNCjVUc75mnjB+wCd1246yr61MaJCzgggE2w45QWB5agMSBePCitKaaP8en3ppIlVdOZEUsNcvN+M50wLnojiN/3uSFvIbcbZ7a/PYfVdFH+mHCCwe82A=
Received: from BN0PR04CA0144.namprd04.prod.outlook.com (2603:10b6:408:ed::29)
 by DM4PR12MB5277.namprd12.prod.outlook.com (2603:10b6:5:39d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 20:32:52 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::e8) by BN0PR04CA0144.outlook.office365.com
 (2603:10b6:408:ed::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 20:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 20:32:52 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 15:32:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <Roman.Li@amd.com>
Subject: [PATCH v2] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
Date: Fri, 29 Oct 2021 15:32:38 -0500
Message-ID: <20211029203238.4486-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc6c6c51-9190-45ed-323b-08d99b1b4812
X-MS-TrafficTypeDiagnostic: DM4PR12MB5277:
X-Microsoft-Antispam-PRVS: <DM4PR12MB527757EE1C1989091DBBB2D4E2879@DM4PR12MB5277.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCRYeoScoJdZ5ZQaaYBlrvBa/8upOUd2LLojdH1d1H/ZZKC6Sp96pUMp+k8PfYvmTRaMydT+F3yu/GkMEdcNYecJqPlFH7ZIJ1eWkkcx+J12XjRmRq+YddbYOkNvay5yuHUv1aFHGfAc+LasQXfF7pqL0sN/UMMpSZDhlwpOIrBmZSjvukzn3t70vz0pfac77jQwHIrywCYDCojl4yLB+KoAjz0R3Qr4eAUHJONzJtydPOeOfKLOS1fwsJKrdTPrluHIlktnDHMfGXSlkEF7ORRCpT/+WO2a2hKJGlG+gjsqIqTfpNZVUfDDgQCfThVGH0t61H8VCzkHA+KGkxwpXXFFd1rN/xmKFARy1FDc9rP7YqqGCQnBustHOyBCKWd/OJ/Ua/eIbDacZtmiWN7q5CD1Ej76NtgUqC8HqKVd31o76Ak54mcCBQNJ0/jqql5Yx8+t01jMIplnpNA6Tt8GzBhwCP1gezNBwLU2LprVFN/oOMvFQ8CnWxuKOl5zoxaA71FekTfIl5TBed1gOEOhTiiL3/mvzapSMKVd7rNk6tkTu7CQEZ6AOvekE1ZmSsBPvyBc+A+32qXpl0ZVh3Iu91WFHCRboQ3/aOFGcnW6Gq3iareQMmx9DjV6wCrnWKXZS8VcjjmJ2/VOqbOl8DUYysERLGxLMzoGZYVvI8GoRce96Dywl4UQTeMMnPKm1uM5zYAjvWrkIV/vPgkMi0QyuWAALuaTT7FZXASMTg4K2oE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(426003)(70206006)(5660300002)(81166007)(70586007)(4326008)(54906003)(356005)(7696005)(8936002)(6666004)(36860700001)(508600001)(26005)(8676002)(186003)(966005)(47076005)(82310400003)(44832011)(2616005)(316002)(16526019)(36756003)(336012)(1076003)(6916009)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 20:32:52.4770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6c6c51-9190-45ed-323b-08d99b1b4812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5277
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

commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21
asics") switched over to using dmub on Renoir to fix Gitlab 1735, but this
implied a new dependency on newer firmware which might not be met on older
kernel versions.

Since sw_init runs before hw_init, there is an opportunity to determine
whether or not the firmware version is new to adjust the behavior.

Cc: Roman.Li@amd.com
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1772
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1735
Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21 asics")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6dd6262f2769..e7ff8ad4c5a7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1410,7 +1410,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(2, 1, 0):
 			init_data.flags.gpu_vm_support = true;
+			if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
 				init_data.flags.disable_dmcu = true;
+			else
+				init_data.flags.disable_dmcu = adev->dm.dmcub_fw_version > 0x01000000;
 			break;
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
-- 
2.25.1


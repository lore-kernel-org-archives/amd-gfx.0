Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1774C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908C261BFA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 908C261BFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266406EDCC;
	Tue, 16 Nov 2021 08:01:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF656EDCC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 08:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU99D1n7xH8/yVni29Oy4Z6YME+xJNxZ3Wr51FK9FIortQaRQWuTqqIH1R64VJQ/kvvMYjTRDKjqtxex6MMIg9V4a1cqeN90TkAGdpAWV8j9DYpielvNzJf7HrwYVNMv8AWCyabRVDCeVlY0CKJoQtyjumm3kCuLgTQ7NBBDVECHmCiZ8wKr2rApM1SSyo2vr1U28WdT2pobtIrkHOEXWjTNiHqvA50xfbbYvAA2PKjBJFQdvgCTkVEVxy6hy0jKQXnpo8oG2ITztqHyUu/PvgwzixpprS0RhINIGzuDGpf5qg+PVijmvTWV2V10J8qsxOvgRr5Q0EGvscVM1RKGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYvf5np5AFkmrrolMz06tCWd9BLrIYYU6ENShjF8Kk4=;
 b=TTpZ63qbncBG/adhdiLgloh8rEqfjxzNLuDHKoOrJen4phasdaC9zCUd+/d6OuhY/5vPXIp+lzrLrXjuBVtFHBnodizlYbu0LmKandBztARY00HeR1vvS8uFvb1Ae90xbuMT46CElBRykweCeGi3jJgcuTs3uH8CUsSvZFIB8RfLxDYgBJXRWqOdqZY9klzBl/Q2c5crZEhRjwk9OsBp/+VmIwqPgBwNf+zJLbdFCTnJk5+S79Z9XUXjXuZiwyZbcNcRwN7hcJPixQMCnm7ZltkWUoYGhKznmwGECPAg6Evm4OxHEPf/JYI8SkLt+T6olJOg+TyDu2wbldn/resZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYvf5np5AFkmrrolMz06tCWd9BLrIYYU6ENShjF8Kk4=;
 b=qzbMrzD7vwDWH4E4rZ1U3Yzp51TkbSRWQctnAUizFc4vIk6BoDn3+b+Semnr6Q8GuPBhP0wPjVx/OoWowUbPl95wkt9mLLNgmXnpQF0hemyvVFOTSk+RWSwnWWLrya3B2qYhoKEx/suczkYX5FhXSzfsflZ8BeCYw8UpZ6CKPM0=
Received: from MWHPR14CA0041.namprd14.prod.outlook.com (2603:10b6:300:12b::27)
 by MN2PR12MB3424.namprd12.prod.outlook.com (2603:10b6:208:cc::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 08:01:50 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::bc) by MWHPR14CA0041.outlook.office365.com
 (2603:10b6:300:12b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 16 Nov 2021 08:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 08:01:49 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 02:01:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 00:01:46 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 02:01:45 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Tao.Zhou1@amd.com>, <Evan.Quan@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix smu not match warning
Date: Tue, 16 Nov 2021 16:01:43 +0800
Message-ID: <20211116080143.32027-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23d381c8-0ab2-4402-a0dd-08d9a8d757ca
X-MS-TrafficTypeDiagnostic: MN2PR12MB3424:
X-Microsoft-Antispam-PRVS: <MN2PR12MB34243ACA3C78F4680B7AF6749A999@MN2PR12MB3424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6Fz8odJecEpVXus+A6y2bZ9jxfhzr5ou9J+TE8dG3e/BLWFNhZQ1koMklU3HQoNdcD4hkfbHmQh7FDqMzqmcw3cSpJgWEJykmVH8n68+8ZYE6/8gHeetm0K+7bym/QeKChBkzLj1Wtlp2IOEH23jmKObY7+Vc6rIgmaLpFdHnB0iWtNvTnWoHLHG2s+7qXugg0a1UVh0jKSyrefYCQHuVEBGYKgCHzqTNZhXusJT8BEitmHCi+FYzb/elA4VWONSMQnLadkL00ZhAkYm/Yn0YrDa20Gv51X6JNClG3d04d6Se6/UT1kSD2d+ru6ya0+To3h217gH+RLCGmKtM1CAU2sD5Kxm+6W6ObYarvUsDriRUvBHexYXZlZ9rRaiXDQIqqGz9FDfyFmKBeF559KFHZ7MMle+/m9Aq9+cqqdKHG2a1UR1B3Kxjf6P8mrZ2XuKUXBlFQeAxoefuPtBQSn+RadJEbVVnpUwON2zSzrVVkpZLt6OsV7cErzsppxsvQnfyRMvYxBlqC9vObUp46sa4T7Xf+wLaFnVzcUsP7V8lPOAlzxTdg77ULpHouETiLP2zmhurtFB0py8BUpYDbweIj/Oz7Ga7A54+tFJ2ww3/Grhp/ScleXtXI9eA7TuVEa3gypWDN0hY90WZmM90TyRKNEhlqFROyXhxa9hdHpkCu+hPfk+SXlG2qddSWvOkcSrKCNWElsaoCPUcyx09u3g9Ys++7MCIml7ygTeA/rqhw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8676002)(8936002)(508600001)(4326008)(70206006)(70586007)(4744005)(81166007)(36756003)(356005)(86362001)(6636002)(83380400001)(316002)(2616005)(1076003)(36860700001)(2906002)(5660300002)(426003)(336012)(7696005)(26005)(186003)(82310400003)(47076005)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 08:01:49.2399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d381c8-0ab2-4402-a0dd-08d9a8d757ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3424
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update smu driver if version to avoid mismatch log

Change-Id: I97f2bc4ed9a9cba313b744e2ff6812c90b244935
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
index e5d3b0d1a032..2e35885c7287 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -27,7 +27,7 @@
 
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
-#define SMU13_DRIVER_IF_VERSION_ALDE 0x07
+#define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.17.1


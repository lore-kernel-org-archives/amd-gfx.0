Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C0FC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 21:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C5D60F02
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 21:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37C5D60F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D4889FC9;
	Mon,  1 Nov 2021 21:29:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC19889D99
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 21:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3oaWowgJbrTkJ6IFnPmmR5YKotJuHx+JxOREBTSPldK8b/XFod4SfR1OVPaiKQmw8zdZ+tFIK4gzc9ino43PI3kYxa+sytlhsM4mnqhCPICnDjCLydmeDL5UErpokPZKMipwUOlzXDecRhdD3Wcv6r5Oeqi9uBu42o2wR/jiFCVla+eKIMzVYcJA2ApuYeISK6CDIUt/BOw+l44nI3/P2BipVZQrGFR5nmOxlCOcwTu1J8EnF6wjlDtqtDhvPsUWoe8Vrl/Jny290Jgkb+0Xzeuq5ZgRWJhIKtwXzyM3BAzb1fneBOrPKczmxKeFIyFrwutp958bpCJ5a17FYKjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMOtVEkoIbASWCS+md2VziCtn4Nk76iI2TTceXw5VtY=;
 b=ST5zmpkXuln10xLvS62oFYMHqQNGormH6mH3ik0Czjsy8+bllIDATAFszcMZfxjQP8pAz9R7mIbNgKnqI8nBGvcQL/hHaMnU78WzbBIJ/2nBNuyZpWLKw7ydz+1icNYlXbRTfjmrFGEI6X6xZ5iXpL6p/hX2dXBGapEwf0iWIjTQt5vmpkuRfD1a2ioa0qTOY0nxF0xMlDJuJoQaw3SNWl+SJuzbWI5u4jNVr2pBNk6+MUm9FOatRBZvrX/CJYi1zr3Ssk8ENjmGxTfHFxieC6LVJ8YaNshuDEcxxBGMRoWtDU4jX9LzoyibTyJB6nwC8qxZdACl8G5k2Zm+Oooe4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMOtVEkoIbASWCS+md2VziCtn4Nk76iI2TTceXw5VtY=;
 b=ngwAovNNT5h7z/ZWyB0LaEkf+GtTT5X7TL+WcrDolufzeu1KuJmGOlGIu2oc0Xb2pJQkJW78pGXw07RE5TEV5nPF/IreZcBtX5CLonMhGYcCV3EPqOBrB+487impjo9wncs6BjKacBLNz/UL4CGtn9ZBkfBk3uHOXAaW+/z/kAQ=
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 21:29:53 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ea) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Mon, 1 Nov 2021 21:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 21:29:53 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 16:29:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/3] drm/amd/pm: Add missing mutex for
 pp_get_power_profile_mode
Date: Mon, 1 Nov 2021 16:28:46 -0500
Message-ID: <20211101212848.20449-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 041f1b86-bce5-4c58-85ad-08d99d7ebe51
X-MS-TrafficTypeDiagnostic: BN9PR12MB5196:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5196A0C09EEB894904E160A3E28A9@BN9PR12MB5196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzxpYWqFM27KP/E1cmbZmYY4FGUC5/ku5IcxmE0NyeaPf34mnn/iZtiReVplXEWYLlp0EAd9PTUla63l+t3y5PATdG6d77WQu0wRaz1xC4+t3rmGwYIYdfN9XdsxBEse0q6yXZMTIK80qv5K0oQOtzEuN5LkPsqA8/3hsWLe+dE3gZbUCmPx3wkrnTzSMxBxZbiabUACtASk0noHHHx2hWYOB4w2AKPzT79NZv0AYYuM4YQfb4DpEMyxB8LPldElizAxF2E4i2+Ho4gJghvwkEOpMIQ+Tnhd+jgdeUF/Ln1mJbHL48tngkdly26UuWKWJZQ4u0YsxERp1xWXe7wkdt8MqMOe9kImmBFu0rSRNgGwUjMdH5k2cJfzjo/YJ8fy0kQlvwjAeTBTvhPG3BDyysmU6H5JSOfrNCoHeRdcHEmJSsF3W3SVUy3vMhXhKiYNUYvL8IinxN/+mRn6gkKHrro0P3WCLnWxCETS+x5ud0tTFu0rEVvynjDQRAmP7jJrffSYfdmM0LtODReac2yWJRvNfmZytEvJ6TYYFZ7fRo8Mr+LyejU3Jw7f9zz1bh8tAuZAzIczij3kT4IFc1xPHIrgKcfxJ2r+g2FTloQwEgYrh7QygOdqPY5OqG37Z9YVnTXPgYvvSJJCkKSDqFERii4yjBg+fuGaDlT8KkTe8WfGJl/wXy3Ka28xjb9akULzv+0hA3zjODDiwEdn1p9RTEnu4e7KrjoZoaekZxy5vYc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(86362001)(82310400003)(8676002)(1076003)(5660300002)(7696005)(83380400001)(16526019)(44832011)(186003)(47076005)(4326008)(316002)(81166007)(508600001)(70206006)(36860700001)(426003)(6666004)(6916009)(70586007)(356005)(2616005)(8936002)(336012)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 21:29:53.2440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 041f1b86-bce5-4c58-85ad-08d99d7ebe51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prevent possible issues from set and get being called simultaneously.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v2->v3:
 * New patch
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 321215003643..978007664e71 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -875,6 +875,7 @@ pp_dpm_get_vce_clock_state(void *handle, unsigned idx)
 static int pp_get_power_profile_mode(void *handle, char *buf)
 {
 	struct pp_hwmgr *hwmgr = handle;
+	int ret;
 
 	if (!hwmgr || !hwmgr->pm_en || !buf)
 		return -EINVAL;
@@ -884,7 +885,10 @@ static int pp_get_power_profile_mode(void *handle, char *buf)
 		return snprintf(buf, PAGE_SIZE, "\n");
 	}
 
-	return hwmgr->hwmgr_func->get_power_profile_mode(hwmgr, buf);
+	mutex_lock(&hwmgr->smu_lock);
+	ret = hwmgr->hwmgr_func->get_power_profile_mode(hwmgr, buf);
+	mutex_unlock(&hwmgr->smu_lock);
+	return ret;
 }
 
 static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
-- 
2.25.1


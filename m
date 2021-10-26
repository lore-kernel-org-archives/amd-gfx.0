Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2E1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 10:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A5160E09
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 10:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3A5160E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5068999A;
	Tue, 26 Oct 2021 10:32:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3188999A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 10:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJb/mieJaYvT1dhD1dDsKRdiYiZA48BCkOOv8xH3K+L7IMNbVgbjlcfMj6y/dwodYv/gcaEEnNqvxn56TNy0rf0+mJ9BDWcD3H10TJUnPw052NuRq0IbPh0qoDIeVVSuGIwOWpm+BWTxcT+AO32pAJl/dKyFqzHd4UxfRfePAqR+V2SBVDfE2ubD5sXpltZFrCeoj4k2qaI27FX+lhyuIsV19GKZGTFThpGmq0lTlfgm0Ob0zTK2tAOIw0AzNmtH3HXUJfD2OgQrLGb/Z38jJlp26L0/YYeBMvnU26eoa/lZWLrkeq6/DdUdIMYwzY5/wfYJAI4NZth07k/jLmPZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjl1EgYayixpKP4BBFz3UyF2mOSRSsfOD+bRLZgt3lg=;
 b=IQYm9RnemO0ikJF9DjtxwG2ImLxZ2wB3tjEzqbujlAYEnsudUx7l+6F1yp1d6Vl7rZdC30xyihZmtSYfNKgrcF5P2l86weU6OBY1OaxsMcyU8JwcILnfmWCdcPkD6tU17K7fOwobZ0DvuQoFP3nZQKy4+tJV8fYNegU1e/BMg4/KvGz9bt7dnSwcZkj9Nu6m8mD13lmVQXB4kNU6xQABse3re3ME8crBzl9PLC3eavcnz2kJWhtUSucXZWl73AqX1TUCDYZ7OKWa9HomQJ1ukmjG6un/iiAf16y8jNl5BZpH2l4R9xM0XNA40yOG4oVd6echkiOSK7wC+fhAcZR01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjl1EgYayixpKP4BBFz3UyF2mOSRSsfOD+bRLZgt3lg=;
 b=3bB2Mjs0bVk/IuTALwzshcqVQRc4Mi1iDq5Y3sWgiJntWX1V447AnCLOk+6PM6A2zfuiDH1i/uANFg0iOnlfsOMOx3gZw4bLQazEo1CzKPHRVmuBPyt8Gntxc/KTjO1U3Qwriwz6GYhfZ1txONo2q7Ioc1uDZE0VMXcrtM1aEU4=
Received: from DM3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:0:50::24) by
 CH2PR12MB3653.namprd12.prod.outlook.com (2603:10b6:610:14::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Tue, 26 Oct 2021 10:32:46 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::b5) by DM3PR03CA0014.outlook.office365.com
 (2603:10b6:0:50::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 10:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 10:32:46 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 05:32:44 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN in gpu reset (v2)
Date: Tue, 26 Oct 2021 18:32:35 +0800
Message-ID: <20211026103235.18489-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e28ed60a-dff9-4d2c-07d7-08d9986bf374
X-MS-TrafficTypeDiagnostic: CH2PR12MB3653:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3653CB9CDDF7118445EE1E03B0849@CH2PR12MB3653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wb6v2bzMptFzy92uyzqdoK6ogohrNFdlJLGyiPqD6/BgYr2wRXvuN4CIwkF7fo3Fmx6j/C3154cG8r40bZXtw4lXqYdRoomdWMxtXwQ4GJBUUaQkh67+LpxchQV/AiT9IJdYmMT9uMTTq5FtWophx89FMV+w7msrg7mx7PkyhKaa1SoGXtqFZL5SwXUAt5YoRh2jnImqArsy2Eg1Qp/84supSzGDMogy1S//POI4TgkvfSLt0yp7/a+sRzPessrdjb41VAU9qoyaFNgzt2h8Ksh+K2YzjEHGjDoqLaA4AVTb1BLRGI4lQkDFY0LhTmJSQ3yd5CXBl8LzNM2HHO8MugLjL1UiwjgNekYSXnZLufAOZo/Kibcs1A3orRiqCUlemn0W4uMbeKhRQVtJeG01vUo+iC0zeNE+OUpCX0XDUxtxwiuy1+HGzVsq1pED6uST3UGGvhsO8Kz/Qclch3kVBrGBD8AUPEUWyVZUSwp4nEj+FBqT71McNcgFiJBozw6nbfBxv3s7zFK9FwvaLNaZFGDcbGG0VgJluMpVkfcUgDftIrDWfi1GMyrIybfhu2pIXeq5zldfSBsO9COR3AogdNeO1Qbzn7dViCdXAJZrY7CMaH4LcJOWGWqkvPn6hRhvXi8s9V0DzYRh+0wRW/sz8NYtar/ABpUuXYcDNMmnq81aRv5e9EtjMVDRV4axzRMrWes1qoCL0IjxKfnh/Y0rkkEKpGx8Q7sGAlTd2RbRYeM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(81166007)(47076005)(26005)(16526019)(7696005)(6636002)(4326008)(36860700001)(36756003)(316002)(8936002)(86362001)(83380400001)(1076003)(6666004)(426003)(2616005)(2906002)(70206006)(70586007)(8676002)(110136005)(508600001)(5660300002)(356005)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 10:32:46.2176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28ed60a-dff9-4d2c-07d7-08d9986bf374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3653
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

Remove GPRs init for ALDEBARAN in gpu reset temporarily, will add the init once the
algorithm is stable.

v2: Only remove GPRs init in gpu reset.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 24852a24cc58..9d0f4f1026cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -706,9 +706,9 @@ int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return 0;
 
-	/* Workaround for some CU settings, skip GPRs init.
-	   Will remove it once GPRs init algorithm works for all CU settings */
-	if (adev->gfx.cu_info.bitmap[1][1] == 0x3f7f)
+	/* Workaround for ALDEBARAN, skip GPRs init in GPU reset.
+	   Will remove it once GPRs init algorithm works for all CU settings. */
+	if (adev->in_suspend || amdgpu_in_reset(adev))
 		return 0;
 
 	gfx_v9_4_2_do_sgprs_init(adev);
-- 
2.17.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99043C4706F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE6F10E02D;
	Tue,  2 Jan 2024 03:43:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869D710E02D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4f93TPqI4veLaaC1fwpZfgJon9pWKZIRCFpzmVFQsy7vUUDpwj2kmkZ7+PrbADuMBSswKFXRv+hG92167vrGG23LLG1DC+Sru+klwEy9crzRcRsQJ4uA08hr4P/Tdjgho9yuvBQcYbFbJ64sLcgThtDGZ33NLs6qZhDGAJ0s5a/3vZiYz6qSbHTRp905Et3b0CvhEvUupqw5syiNz5k0NHXlH3WYsUAaOv6fFWvGhTBhDjiJZHkxXQ13cKTzvFu3FYH6/UArrZaK1Pp0cigp8DfFZqGZsfJ42dDU4m+reW7zLu4alPGbdDNYPlv/xnyo2JZIOZdaBvO27aCbSBw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvNF25iiDwYofIUKaftG+ypkeKjoUIGO5W5CH7OseD0=;
 b=O7MeAMcGKmcsEtdd/9cRkWIXImuRfnSZ1TIaaWS4kOp/weI7cHAZO+tXgV2Y/ka2kogG4fVQ/isdaTJfTEFCD87Ntg18SR+pJiBfYbnQo/z8sx645mKuhAna45R9JWCmc36LJmZB3+NpVtKAEJMinQnVUzk8p0ISHfLgCp0YLyawP77fe2s3Az5MejZCqRXNT3ijOYN4TJGtC2Zcnmk8UAJ7Sy7vN3BamVqH8L42U8x+1WTUmibTyIAZnHVL/xn00A2qCB6OkgLCGiJHYJiY7loyCUE6Yp3tVlxHIeWJvChxpuJ8yBDdOQHL0sCd/5W1+Toru+1hcJUExvTnrfbkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvNF25iiDwYofIUKaftG+ypkeKjoUIGO5W5CH7OseD0=;
 b=at++5xrJRHndIKvPdGELvaym13CMQVwy9aXxaJ6MdzuVDdEC4FnJfLviEt0UJEQtARN7SxaT/9I74qKf78hTHZLHn6n8BHa4svmtLbW91EECphNNj+I87Qpx4/1GC7eGa47wgKwcbjIkrGabOa74YQBdUOWysweNpGTCTLOecvo=
Received: from SA9PR13CA0075.namprd13.prod.outlook.com (2603:10b6:806:23::20)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 03:43:52 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::64) by SA9PR13CA0075.outlook.office365.com
 (2603:10b6:806:23::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.11 via Frontend
 Transport; Tue, 2 Jan 2024 03:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:43:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:43:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 1 Jan
 2024 19:43:50 -0800
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:43:48 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 0/5] Add boot time error reporting
Date: Tue, 2 Jan 2024 11:43:36 +0800
Message-ID: <20240102034341.16321-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c0dffe-f2ae-4c42-4073-08dc0b450921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aDmTqzSNYgPcMKdliY1pPJwJZHlJAPJApDi0L//waW/XKr5WI2vv+8nkVYmnfoJkoO6uzrvb9Ug7ftBz1EjuYl6Soa0jsQaZQAvS3GwKqbkHmlm4jhbgB+AfuRBwULTi5WjMZiCPbVsZne0vyVQskuvZvPZ57AyLPxdbq0jUAjD8vNAeaOxiREzftAt4/cfl9+WeQ60q33B78fQabHxj1SSwgHRvf5WeYjXIFaGgVEznd7JViDbXJHYZFug0EesQPxWIE0bb30OAY6PyuQZj2Skp2UzI/h2aNvYm782BZrQQD+B3Y2BFLsvkJIVL+5li1rb0MmSQsARtw3jk2msNn27A5T7pIjB6q7mbpyKkxiUymJDx3CImfYhU5sTfSMTdOOtg/hNN5JH/QOja8izh4yFa/ssoPewu88y2yW+XjdSE2glVoeJTMOFBne17uAYqB57luvGm2zQat6P4t/tTaj8SCs2gvXe9BKCSpc/p8BWMo42Q9BDUHN9uCXY3p8ut8gpV/uLfw8ndsNz2sts9cws2TweCDhYePeO/qSps+Xj9Z+Lq99h8VMegEh5wQsfLEU6/XpvTHSEKeRM+40U8p+qy1udaHRYLENtfE0tiKN5T4o6HUNBM5YlanvLq/l2ALq8SphxIQiXLydushjXg5R2+j2mxzt2GQpNHFEXnhWSMN2L00+FcgtgwH5a+peYKtuEHGnQkv0tZ/OQxct28IuMHDbCFeo2yxSxw69u0C4c4Y4q7tlpOrwHLu1Pd/XrT+GaDqcSEzH62iEWg9SngQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(426003)(1076003)(26005)(2616005)(336012)(36860700001)(81166007)(356005)(83380400001)(82740400003)(47076005)(110136005)(70586007)(70206006)(54906003)(316002)(36756003)(6636002)(478600001)(86362001)(5660300002)(4744005)(2906002)(8936002)(8676002)(4326008)(40480700001)(40460700003)(7696005)(41300700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:43:51.2965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c0dffe-f2ae-4c42-4073-08dc0b450921
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For ASICs that support boot time error reporting, poll all
the boot time errors cached in registers and make it available
in kernel log.

Hawking Zhang (5):
  drm/amdgpu: drop psp v13 query_boot_status implementation
  drm/amdgpu: Init pcie_index/data address as fallback
  drm/amdgpu: Add ras helper to query boot errors
  drm/amdgpu: Query boot status if discovery failed
  drm/amdgpu: Query boot status if boot failed

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 22 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 15 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 95 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       | 15 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        | 89 ++---------------
 8 files changed, 141 insertions(+), 108 deletions(-)

-- 
2.17.1


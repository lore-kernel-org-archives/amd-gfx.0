Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CD8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FD26101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34FD26101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD9496E8AB;
	Tue, 28 Sep 2021 16:43:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D3E6E8AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6jeecOUXZ82nBpC9XNWueBfyfzSKOgnBSrp3CplrQClKpBWi8EAMlDP/kWNibS/TAZZJNXMepNK16woQhghg3y+k6Fyo1PjGRt+rBp6TG3HHbMrLOYpjFX7BaxpMq3QEtSBstNQNR59xVGnMUb8IpjGdKohGbC3At/68x2+X0KnkVIuFNkF8eolxmm05krGNeYgSrF/qi1odOlio3YmNkWW/qK7bWrOLj9t3Z9c1Ju7h0SIM1GOKLpGzlam4V/ajNYTZkJ1E7s8ZuuNfJszImcJTVeE080mQHrtmKiqieOq4ZjQ4n//6EJV+Z3yYEO5e79/d+F0XMW4OIxnjMAsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qjvBAiyH6+YOqLF++s4Q+COExOUS2RfOFAfJNq2SQGc=;
 b=AuU1Od772CagupOElz+C9k9XRGmpFYP4aZMCQYHfMU2+5Z1bSwN3KU5gf8fHJ2KOPLz0UnpLDpPA+a+791pNLTZC6Bu1o9DGWqRnX6Rcllk7LTtaC2FRwS7iCzspSXrss81p5pYFQY9EJ+t1eKtu4OJPEPCcnhBZez0gZ2QqalJU6y0zizEiI5F41wissHgX/nu0earcy2CMZTlTu/cK2rbllw9tAHCi5UPpd56+Yc06h26UwQzxPF9B2AQGo9+88Q+C/Rmz1J7vUJsT2amVzwdt8PgzsAAEOmZkAf4bGMglKrgnBCgvEFO69UXTxy9cfis20vEjEk3tvEEMEJNzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjvBAiyH6+YOqLF++s4Q+COExOUS2RfOFAfJNq2SQGc=;
 b=V49UdjmTZelTuO5SPcmJ2Jqnxg5m3aG1eXN8Qq7htq6qJ5cenruKMjsLLXUzY6lJJFi7ksjZPQmcswjs7HXGoeFYI1KoTh2c4NTkIMfBGR228+w0lCz3uu5+/5sxzH1S7T/GYsIo1wQQwTQkyk5yHStn0tdRXvYhDHUkqAj1zkc=
Received: from DM6PR05CA0052.namprd05.prod.outlook.com (2603:10b6:5:335::21)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 16:43:19 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::c) by DM6PR05CA0052.outlook.office365.com
 (2603:10b6:5:335::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 05/64] drm/amdgpu: add XGMI HWIP
Date: Tue, 28 Sep 2021 12:41:38 -0400
Message-ID: <20210928164237.833132-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73fbdce2-a8d9-429c-05a4-08d9829f13e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-Microsoft-Antispam-PRVS: <MN2PR12MB430250AE071A058D553710FEF7A89@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMaDvgalSoPSUjOMOQRT26z4jsol3/0ZpPQ8GCtVacU9gmL1XfA9Ka7BySnCRwRLY3rvKVNL2pBnnOMqDCKJVIu0VHf+UKC+ZYQPIrKQUZZCAiOND7ApBqUrKcj+lnYkNnwgIQbSJEWprw7bGTYep1d/vhajhpLn7urwDXZGzLez2xNAbGlupglAp5wkxkCVl6E7qlT7PP7wPKFm+yPlSWjLMDz1aEXJeas6nNcMA+Z9bq/iuJVpb+1c8IlNFHl5yMdr4u/kbD9aLjpuL1GYLGDb7mNWpkz3PaUVuBEbOvATy0iMnJmN0XxCWi84Ag1DAOHVHR1R6/gNZ9v3AHn4E6jbap3m4n/iTXqZflj3gVizVOld5OpA/J+lMrTNs9bZ7dh3uikYIN5tr0VGxtE9oBYCsn6d7w1PDhtljyuz95UZ6xZR955q1kJNuPImYSsF+xQ9q1n62LBZN3Y5tMJnH2cC21WBizfttYpD16n4HP19v55w0RcsQY3UYQM/A82Hp6o/uiUtwAuLqjpYbZhEiOLM4K938l7HWQL5Tttgf6CG+ukpxlQw1Ma941zAekflS7cVKjTBji6R3oLIyVZ2h5q3vitbL3RYPRxO4TfQmMM2EWrcBy9mhj/JPCH/RFHhef1mwVYAjQOjrIA2RngWrLUk2P72Vw6DIjg6z/iAvadHD48n7YEME9JanBIYCNDcniyZedk/Ds968KjCfrU9ggz3AgGs/T+rdBS25o1imuU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(186003)(6666004)(82310400003)(5660300002)(1076003)(47076005)(16526019)(36756003)(426003)(54906003)(2616005)(508600001)(4326008)(2906002)(86362001)(8676002)(81166007)(70586007)(83380400001)(316002)(336012)(356005)(70206006)(7696005)(26005)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:19.4295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fbdce2-a8d9-429c-05a4-08d9829f13e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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

So we can track grab the appropriate XGMI info out of the
IP discovery table.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 61ef0d81a957..8df4be702870 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -755,6 +755,7 @@ enum amd_hw_ip_block_type {
 	CLK_HWIP,
 	UMC_HWIP,
 	RSMU_HWIP,
+	XGMI_HWIP,
 	MAX_HWIP
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3c60b7af9898..885b653f0b05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -128,6 +128,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[THM_HWIP]	= THM_HWID,
 	[CLK_HWIP]	= CLKA_HWID,
 	[UMC_HWIP]	= UMC_HWID,
+	[XGMI_HWIP]	= XGMI_HWID,
 };
 
 static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
-- 
2.31.1


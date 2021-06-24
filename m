Return-Path: <SRS0=QFXE=LS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F9C49EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 06:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E143461351
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 06:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E143461351
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1244E6EA5C;
	Thu, 24 Jun 2021 06:47:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190536EA4C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jun 2021 06:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo5GYTkSXjuq/u3l0yCiT3tGtIQiJu2hOpVXjdQ6pfnqdWCcQTIcIQyuP06mG2h1/mD2xtWsXTdnw310M84ana2uKHTWi5G2IeTBA7D2DATqJnGKPWPai4ehq07tUXxPf0WGJdpBX/PCTzbuMaZVEs8k2eAdsrFzcrTIdsbIXgPKjPa2iQEHNq2yL1a+xCWA6BtMszP+At3ttOIdBLGeP4N5voJgdEUndTsskunrB2CPKKF0OzVKDlGFTxxDVHTlyYIpIpbBxzB6lXMT57a0DmyAYtMW9Aogk9dVXIqgz4/y0ku6BMyZ1/UxfAfJJyZovSam1H0dKlUpzrmNw6iVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0LCcFFntg1Z6D3VYzXNGKZLNU8BIHp7A60oxPrPYoM=;
 b=B/pmdO7pi+dCyaFPQ9rbxbPERqpJSaC4qS2HegRkNNrOF+spl1BTq8xTZxbIh1rYzgrkK9f0akFcPIfIt1j8IfVUZxnebWBIc80RgzKDrJoqbvgXZQ6YtzGO8GPg/E/RhG1L095kQjTj1R7F50kDXgQGnxelVi6vycL0sAn0Qf2WS4OQZSwGJC1baUrRvtXrj7BM0DmGuz2lpOP0zE83rme5/5aAp5r9LEC6fN38OBG0buhIFsBgVEzewsjBDKyOY4BYr6YCi6ADX3dAdP8Q0znD0lJ85m75Yq7K3gY3RwaWR+duQ1EQfANP6rdCXp40uP4EdX1vpVskq6fS5yR5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0LCcFFntg1Z6D3VYzXNGKZLNU8BIHp7A60oxPrPYoM=;
 b=txW4/L1qH/pMcb1MFQIlR5ckcd2UIKqt/mWOeWMjhdANiwjyT5QWwyDMvmp6f5uyASGHWvXN9RYmPKejFWaVBDQy97rUfOQkrMFAgb10vGthh/P/DDGpeipQfvvnV6LFHYf6QcI2p/N6/A3+44qovjXY8R10u/5CgoEBlN/EOJs=
Received: from CO1PR15CA0107.namprd15.prod.outlook.com (2603:10b6:101:21::27)
 by BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 06:47:45 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::6d) by CO1PR15CA0107.outlook.office365.com
 (2603:10b6:101:21::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Thu, 24 Jun 2021 06:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 06:47:44 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 24 Jun
 2021 01:47:42 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: show explicit name instead of id in
 psp_cmd_submit_buf
Date: Thu, 24 Jun 2021 14:47:24 +0800
Message-ID: <20210624064724.77436-3-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624064724.77436-1-lang.yu@amd.com>
References: <20210624064724.77436-1-lang.yu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af8878d7-a37d-41c2-bbe4-08d936dbf8c2
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2353FC08881A4BDF58AA0711FB079@BL0PR12MB2353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:210;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKJL9VnzzT2HHAMQaKfZjhAOMwqI2CmCKNmNmvxDhxpMhbb0W/nPxHWV2m6XKnGx7TPS+yX5w2RDA+ks6/WbHlChwbPH4wWB5u0SeEU8h2/D7H2BQ4K4Mik8a0TyjhaYQsI7bljRIq/jlTRUKvMk2RPx+ipfb5VvGnuKPCsyRF0chefKmCfvYiVLC/IDqiVMg2iOaW5RrYP/BkEr+Jp/92osRneZKpQPIlMb/dBHyJ59pNBiVsO6Ft6H0TPaiVej9bGJn2GibVjgk3nmLRBcXQaxPExBU/dCP7D3IGwg90CabXnh0z/aFs4qb4hWYdcn8S7s4MY5PZnlhDknFiyCLjmZkl7bfXIBfZZQISbBkqiUqp2YLmcAw0bVIrdFq/3Zfs9/j3QzqFQ7HiglFmG1qs66NPDRzCiBMB3NYLNzjGiurCAZvDzZF+2j0IpZt05t6YtDHnh8FLUulRNGdRxC31AniVI7AQOP7WDm6ylP/PhLkuClhLe0SNUHkrj+DRuWLg4pqyF6SzDgTM0To+atDU5scPaqpPufPxnjrXJrNHYP+Zpm7P02cOybmjQ80WkdZdxI2nDTQq387sLF0SGGDDcRPQz00iW7VwC0lo2TqQzzjBwhCy8hczvekDHjsvkAhJiOAjQsRsHRJomSyRIN10xYuqdK0qxW4/A2Z7EyfgsZbw14D1+euDRHNMDDa/qY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(8936002)(336012)(82310400003)(478600001)(316002)(8676002)(70206006)(47076005)(83380400001)(86362001)(356005)(81166007)(6916009)(44832011)(5660300002)(26005)(36860700001)(1076003)(82740400003)(4326008)(7696005)(6666004)(2906002)(54906003)(70586007)(186003)(16526019)(2616005)(426003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 06:47:44.7136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af8878d7-a37d-41c2-bbe4-08d936dbf8c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2353
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Use amdgpu_ucode_show to show ucode name and psp_gfx_cmd_show to
show psp_gfx_cmd name in psp_cmd_submit_buf.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index ff26185b1485..76faf10bcd54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -450,10 +450,10 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	 */
 	if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
 		if (ucode)
-			DRM_WARN("failed to load ucode id (%d) ",
-				  ucode->ucode_id);
-		DRM_WARN("psp command (0x%X) failed and response status is (0x%X)\n",
-			 psp->cmd_buf_mem->cmd_id,
+			DRM_WARN("failed to load ucode (%s) ",
+				  amdgpu_ucode_show(ucode->ucode_id));
+		DRM_WARN("psp gfx command (%s) failed and response status is (0x%X)\n",
+			 psp_gfx_cmd_show(psp->cmd_buf_mem->cmd_id),
 			 psp->cmd_buf_mem->resp.status);
 		if (!timeout) {
 			mutex_unlock(&psp->mutex);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

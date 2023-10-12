Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C771CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 13:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A9210E4D1;
	Thu, 12 Oct 2023 13:14:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BBD10E4CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 13:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAR58hKWsiRgwKUmzUZB+WVbHC3QyAFzKjMSKWZUcTiVrTK9lzwG6DDV6NSXb27wtKgNP8ZmY87Jjyf7TAtB+srHvacagtY3NshTCTmV06OQ4JAG6q9d2yLZPzqsHoR/WJ8uKznK7tNTtsKL7TzNWVi6ebGX4I/o89NAmNdCqeYR9GBt6BvLmkzMyS3MObC6IjWcRj8LAJr1UfTL8cOB4S9BAkrgL+5dnUz3ZDz/Jj+FDLGKLJwmszs6Bpd52FiTYwSjv6bikF/V7euo0zwnVfGCAO8CBTIwAdfieBg1Deyme5l8UygsALO3rVGHDQgA2TWbKtNlybyUCG0FF3q1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62IbKsJDRGB8Dxy4QDbd6OvnGlaY+aL48e9ak5kdkkE=;
 b=Lbn0H3eBqfb45F3OAbDmpStGRc4eeK/YLee1A0R2ikDzR6OufeIwFXlYmBkURsiUb8aYf71PxP9Gkb9r7KpaOWj6Wd4+wJdtPYWskWuHPcOkCVjnTqSjYIcKljdgIdYDKF5A5S58D2v8HtR7nBJzTWo1ebLwoljK2WcoQbonJrJ8lNKRfw8ejrDMiU9ZGa0oVN05qU9k0g4J92p/PztS/a+xP+sq/OPEwIlbRWL3x2X4FViKiTeGU1xh2IG9jauAnGTs/fZKNQ7FEYggVvwH+JftRDZ9Uj1R6VNViZnNM5d58p2hG1iLgflJQEv0ps1tzFeYJI7fIJEDAbRXFGqCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62IbKsJDRGB8Dxy4QDbd6OvnGlaY+aL48e9ak5kdkkE=;
 b=PMTlTHNxxPPgYyfMMCRwOolasuVaatQat/l7ZKseuUYajFmEznyUPVdtRd++PQXGiyvggZ7QlyYOzjyfI22aklR2jn6ilgGzX46k2faO0bkzplWjs00NVSa1n3/DFgg5Q5VNm2qTaBrYQfoN93UU28zHja5fsnuPBxmwxnlX4aY=
Received: from PH8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:2cd::16)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 13:14:26 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::2b) by PH8PR07CA0008.outlook.office365.com
 (2603:10b6:510:2cd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 13:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:14:26 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:14:25 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: add RAS error info support for gfx_v9_4_3
Date: Thu, 12 Oct 2023 21:14:05 +0800
Message-ID: <20231012131406.61101-5-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012131406.61101-1-kevinyang.wang@amd.com>
References: <20231012131406.61101-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1ee325-c5d6-457c-e741-08dbcb252904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paZ0py+44iUlIK5ONc6hoT6wGnEFlPRgY1PUqjhzGtOwStr43pqSbKnmBvYImXlXx29xXr658GZb7yxXOAJPeYqwE5DTD4NS/fUL6TOoGfO/ynXVg9NUPPMm4604qn5rjj99Bi7orAA6xnB8lNThh98BhLX5yYni5Y7bcx+/Od2mWt6DRSsigdeiAD2VfX8T14NcDazuN5/144aGUJF2yqEedDOj3nLy7oyvBrYhdxuSt+X/rFA19S9LbF+QkiZ5g5JfcbueQQh83f2yu+lCT1+e4sjeIAIbbIgZRaLQSeEi7XDtqRp80FLEzWiLs3IS+IJVzra+f8Vz4ymDQLEYGTRjPdajDfZeRX1Skah0m4qYCQ5MlSoTK2So4I9BsvoAom1Y+bHiVH4rF9jsh6TheXjbzSTJ6WUW/AWNdO70UeKzlxl1+yG/CHxKLmNr8W/MtOwav8OFyA4StHIxYt5VeTDXHah57h+ue68AzcXsJ1oQvYMk4pr7zoXsaE5Wr2Zta8aX0/2n0vjd5+c5+8XbpWooO16Id9CkXuP5nLHkXr+etWvpahfWTJa/zPtkJ5z4ory1WEH0nlg3YjBOVe0+spzMVStQhX1JFGmlkh4v74nVj9alXUzVys7TlCQU/zs08qp0i/ba/7p3MgYpWkm0t1fwABYeCLUTI0lkdbQCOOIWVjUz3fn8j+zkIaHOdZ9XsvRHulLBHH2GQJRsMZ4Wvzyc1fpWjb0zUZFbzivMecMCegkc0N2PBGZSWppJzsPodiYQh6PaTROisI/uhzjvsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(6666004)(41300700001)(7696005)(1076003)(2616005)(82740400003)(316002)(81166007)(36756003)(86362001)(356005)(36860700001)(478600001)(40480700001)(40460700003)(2906002)(336012)(47076005)(426003)(26005)(16526019)(83380400001)(70586007)(4326008)(8676002)(5660300002)(70206006)(8936002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:14:26.4847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1ee325-c5d6-457c-e741-08dbcb252904
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add RAS error info support for gfx_v9_4_3.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fbfe0a1c4b19..db179d085efa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3766,6 +3766,12 @@ static void gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev,
 	unsigned long ce_count = 0, ue_count = 0;
 	uint32_t i, j, k;
 
+	/* NOTE: convert xcc_id to physical XCD ID (XCD0 or XCD1) */
+	struct amdgpu_smuio_mcm_config_info mcm_info = {
+		.socket_id = adev->smuio.funcs->get_socket_id(adev),
+		.die_id = xcc_id & 0x01 ? 1 : 0,
+	};
+
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_4_3_ce_reg_list); i++) {
@@ -3804,8 +3810,8 @@ static void gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev,
 	/* the caller should make sure initialize value of
 	 * err_data->ue_count and err_data->ce_count
 	 */
-	err_data->ce_count += ce_count;
-	err_data->ue_count += ue_count;
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
+	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
 }
 
 static void gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev,
-- 
2.34.1


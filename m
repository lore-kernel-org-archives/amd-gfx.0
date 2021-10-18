Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BB8C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 10:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767A560FC3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 10:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 767A560FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99616E9D6;
	Mon, 18 Oct 2021 10:50:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71E56E9D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 10:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDBaYIq6d3X9tXkwkfCUCAsioiciXgnaNTFrL65PBPwaDIFBsPCkj+uaANZW/zeMYWLjEwQ7irgKr5jH99ZDcNJaYvso0IWVI7TxVyzYzxwBTZ6kadeq58CUkp0nUunM5puSCgjf615/WvJJMBQXK2mKGNE8OxhK4uqX3CvJ7KCvw/lAnZkEs2NhTJXGWXN06rqokJYqF+aTdUcAKiLblfnaPD/UCCi5jQ0q0Rf7KMeWDmjBF1+uwyON/yFHYN/WOqP9OPr3WtncQFCXhF/U4UASzUUlI/c6AP6F8B57VnmaZk7KjqnG5EI17ELdhveTLtg4SD+D8wJbmdIPqhNSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C++8xcEc1uo36Wk4ZsOVqXP6LzGbMgS25pbNwwQgtdE=;
 b=jAGZaiTYUSXPwXe7R1ujeuytb0rXRqeu+RRAeByK4DdlHjC7X8XZHe9Cij8568X2bI/eoQvFCLyYIwyEDWHpPtZGszhVbT8VDafWwjYZJgUJC5rFGjrrxQAoaQ5fAcOta2e1RCeeOSsy8HpK7J0Pp6dFtcXFY6K90d6d/vmgyrOgBEfbprAHwN33yna5jFr6rlBGXNd4EcaRpWQ+Iw189zJ6jZSgUaPAO12yisoLaFmziWaxubSpJP1EF/VRQLftKGwg/HCG/I6uG1grUxZH21qYUj3eZsIqWpeqCPvzSGOceBuesiABo7vyyGeRKcIvEDpmjMRcswNzr4ExIKQSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C++8xcEc1uo36Wk4ZsOVqXP6LzGbMgS25pbNwwQgtdE=;
 b=jJz6h3sN3S+46fPHKsA8neBUeLgjRpID8u1rEB3bVKiKvYCRytOYqDOgEqeQzp/HkqBQRx3pMQsLz4/uT2A2zA5vZ2f9kqnTgZ//MT22AqZPK4S0LwX9RP2y/XbwkuvReh5rX5J9zDFExbKv3tb1Rv7xPq/DbNgKj3jZiz4NFWM=
Received: from DM5PR07CA0157.namprd07.prod.outlook.com (2603:10b6:3:ee::23) by
 DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Mon, 18 Oct 2021 10:50:03 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::56) by DM5PR07CA0157.outlook.office365.com
 (2603:10b6:3:ee::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Mon, 18 Oct 2021 10:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 10:50:02 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 05:49:58 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: centralize checking for RAS TA status
Date: Mon, 18 Oct 2021 18:49:48 +0800
Message-ID: <20211018104949.17814-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b2d138f-bef2-4f10-914d-08d992250988
X-MS-TrafficTypeDiagnostic: DM6PR12MB4778:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4778A035F41EE03176A14F53B0BC9@DM6PR12MB4778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3D1t/BW5dVIw6Fg0fSmGgnBmhvkjeBWoHOO60v2yg26QaR3dOJvIyYdY1X3YPONL+SvkMw+yTnTuKOOsBdDan84lVsQ92RNAyIzfgr/76kPDJgwhBJ7KKqv61Nc8iZ2W7Iecap2ePfiNf6GP1J5vXfmDi0ZWlBAynxnID1sgcbD0u22t84JLcZ77zrXJTL3Dyri/1+2NNIzE0aOHzT9xbkKszjf9rSsgEgOqYQMZY38ZhgskW/j9yr4PU/2piWWUflTv2XiX/12WaQBYQdrdyvRY+ud4dj2rsizH+IaaSppeWnUJZzqGEZ7bvqw+OVfXHw5reoXbNZVtJBAGS8oTWOWCYHLx8i+LAC8/3of0CCOYJq+RaZbR77TO2/zY9DvFsJWsQAVg7Z8dN6/3NBbvJZNRaL/heHhDV6zKRlfbtitBvD/qiwvq7UJEVggEDAAynfNN6Aof6V0acBR2k/Et/c0wuigLErOJ21eYYOLUAqI7u09+Lg5oAODwIEYJmoQXQizyz08oPZ3EBgJ5A35EHlAA//a23gwuqf0GYdXLRsTSepMAoyk/X9pj1cLmuhZ327QbUVHJbv2fXjc6v27CXfHCUxQ3yDjLJL2nXJ8EbWy/zQQWoTRo02XkBzDJCb3C1X0B1Sqc8DMdQ1k0jTJhl8nzwwiwXUnR41P8tU2yjW2xwuHU4dIg5cZaisdODrmXkFFPQXtwLLnfVVByIwk3vnOw2HzNPw9chsfAu+KJ+cc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(110136005)(7696005)(36860700001)(8676002)(508600001)(47076005)(356005)(16526019)(2616005)(86362001)(336012)(186003)(26005)(426003)(81166007)(2906002)(1076003)(6636002)(4326008)(8936002)(5660300002)(70206006)(70586007)(316002)(36756003)(83380400001)(82310400003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 10:50:02.0237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2d138f-bef2-4f10-914d-08d992250988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4778
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

Create new function to check status returned by RAS TA.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 88274c254c76..bcf95982f6fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1292,6 +1292,25 @@ static int psp_ras_unload(struct psp_context *psp)
 	return psp_ta_unload(psp, &psp->ras_context.context);
 }
 
+static void psp_ras_ta_check_status(struct psp_context *psp)
+{
+	struct ta_ras_shared_memory *ras_cmd =
+		(struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
+
+	switch (ras_cmd->ras_status) {
+	case TA_RAS_STATUS__ERROR_UNSUPPORTED_IP:
+		dev_warn(psp->adev->dev,
+				"RAS WARNING: cmd failed due to unsupported ip\n");
+		break;
+	case TA_RAS_STATUS__SUCCESS:
+		break;
+	default:
+		dev_warn(psp->adev->dev,
+				"RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
+		break;
+	}
+}
+
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 {
 	struct ta_ras_shared_memory *ras_cmd;
@@ -1326,10 +1345,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 			dev_warn(psp->adev->dev,
 				 "RAS internal register access blocked\n");
 
-		if (ras_cmd->ras_status == TA_RAS_STATUS__ERROR_UNSUPPORTED_IP)
-		    dev_warn(psp->adev->dev, "RAS WARNING: cmd failed due to unsupported ip\n");
-		else if (ras_cmd->ras_status)
-		    dev_warn(psp->adev->dev, "RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
+		psp_ras_ta_check_status(psp);
 	}
 
 	return ret;
-- 
2.17.1


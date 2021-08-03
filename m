Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C639C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 03:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D312460F56
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 03:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D312460F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAB789DC2;
	Tue,  3 Aug 2021 03:16:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA5A89DC2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 03:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQIm58K9AfgErIMxIHrpZB/j+ptZDaLhYIgzynL9GJcM/HxlCnqYPy58+FysdpNcO9O+jGa3HGDw2u5zf8Ho6m6z9hyqB82dkMVOpK680Ps6AEl06EWfMBhcVVabgsNI3gLlQY+DwjdWIsFaXaApg39nCJ3hWvhgk1BeWa+x3DXf+LmfVZ0mTR2zPL3uLbEXdzQ1St/B0NihK2KRGUujynPDqIxfxQz/AIrLf50MgkOO0umcjY1wSiRiQMyEubhoUk+NAyDnETflhRI99F3cq2jXs4NhbmrfYfclwBYtOSjZxGzDK7OJgToB4yjVU3PvA3OCkLbVvDYnOp6ktCaSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru8ecTPR+j+wVC4fnkOGT9r9RQ5JSuj6DIsDh2nBWtc=;
 b=DE191Cl4Noxnmy7IIH3O2+zbtKb07GzCEdhNv5GqHfmlJeH/Z4aHwQRhL/4/zvS29z0sXGUGezPnMza3LbVRhwQfqx+o8icultRPAuWsQe4UB21Z6hzNtof+n42dqFPRWNSYtNjKgrnYdcOxb1/MSPoQ4CfF0ezYf1khXAEy8kOwIRFVdXNYJ9/nQIDPpY5kXvrAoj5ipmDuAMWLnhjp0iS3ev84JN3B7oJdoKWY8ykLDYlHmsSHkeWy04GvQ7YLQnA1dlhbwahcaVIyCTsBM9EuNy5yi7FvCar17+Bv4KyG7C05f4YAsDLnJUSPlAvktvbiWWzfKPyVRqzK/oTtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru8ecTPR+j+wVC4fnkOGT9r9RQ5JSuj6DIsDh2nBWtc=;
 b=d5W6WZfbWA7i94DwENmQ7/bFvZeAvERXEISuyXA8mDsKxi9np6bHUsXLvbLFo5quOcJlnYOyw1jkr0QloSS5Siqv82hT+7cOYDAOoCSefLWAGc9XgeNwoXWngkDMYomjqi/UsnCnBkKfZ9IbZ3wEyE8iYm0IPUGkmPJMfc4FtHI=
Received: from CO2PR18CA0052.namprd18.prod.outlook.com (2603:10b6:104:2::20)
 by SN1PR12MB2384.namprd12.prod.outlook.com (2603:10b6:802:25::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Tue, 3 Aug
 2021 03:16:34 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::87) by CO2PR18CA0052.outlook.office365.com
 (2603:10b6:104:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Tue, 3 Aug 2021 03:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 03:16:34 +0000
Received: from code-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 22:16:31 -0500
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Aaron.Liu@amd.com>, <Alexander.Deucher@amd.com>, <Ray.Huang@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Subject: [PATCH] drm/amd/pm: update smu v13.0.1 firmware header
Date: Tue, 3 Aug 2021 11:15:59 +0800
Message-ID: <20210803031559.18025-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a629924-8774-4b69-d8d8-08d9562d1916
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2384D2136A7025A1333395A19FF09@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEnKWuC51kJuLJUObTL5eCBiaBUlbD2Dtd6GR7X1ucySrxFmX+5zZmAx2mwPnxTCts97Gg8ZQ40EzfcxLHlBovDQq2nMG77JUtdFscrwdztZykhK2CrAGtmaz+CLfHVNMmmX4ljmSf5JDYpwIlJzL+b0MtyX4axM30LYwyGuLCY1MSoES3Pr5VGH0pJWnYlx9dLAPpK0PanTVuAFcbMHMbsu7e1jBsULqYkrTXumGGCXTy5/OJlDqqhX4SWAdh4heXmhDfvMJvpHP2nw+39AtPx9efDuni9V9qW+jR0c4wqgsH/LQbGDpMCaK7gJF8fG7HEgHz6p54uLnkjlmI/Q5XJKUo8NqvOxJALC31egd4Fno8k+edspY07EfEMcyyD7NZ/y6k9UB7TxyezRoUtQhx5Opw2o92bcZgOxtqsOieEJALNH8UJjf5Z7e7KveE+P1wVkb1zW8Vnc9OxRzlRVxITg7aCob0KphKB8tMirs7tGwbQuhHJwjYTceSzgUzyalL5EHSiyeO8PcH4XSQiw5BmtL4gOn9vbAjibvZpPnZvfrTEIeu35w0G4FFUJ//8cpHhleITz84ziWQaahxQgLDy7dAlCJfoL3da6rAG5uTTYwyXH6DwfzzuqbQ7a4dbmWSj5ZnPmKzoVkmHe3qRwH+xSmkOeZNrSqcat8ms16ai/5BHnCHKYJx+iM/ARUxzqtNxN2bZQpyoHmhDlr+4afS8h/7eUSdkhah0ONgz5E8s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(8676002)(36860700001)(16526019)(47076005)(26005)(8936002)(4326008)(83380400001)(6916009)(186003)(1076003)(70206006)(6666004)(5660300002)(86362001)(4744005)(70586007)(336012)(356005)(508600001)(81166007)(19627235002)(54906003)(2906002)(2616005)(82310400003)(15650500001)(426003)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 03:16:34.2331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a629924-8774-4b69-d8d8-08d9562d1916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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

Update smu v13.0.1 firmware header for yellow carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
index 5627de734246..c5e26d619bf0 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
@@ -111,7 +111,9 @@ typedef struct {
   uint32_t InWhisperMode        : 1;
   uint32_t spare0               : 1;
   uint32_t ZstateStatus         : 4;
-  uint32_t spare1               :12;
+  uint32_t spare1               : 4;
+  uint32_t DstateFun            : 4;
+  uint32_t DstateDev            : 4;
   // MP1_EXT_SCRATCH2
   uint32_t P2JobHandler         :24;
   uint32_t RsmuPmiP2FinishedCnt : 8;
-- 
2.17.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4311C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0145B10E7B4;
	Wed, 28 Sep 2022 19:04:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C4410E7CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UakJnpjRsXYITNijtKM7vkpS8jy3o7b5tBVBwkcEXb0HZ3fHsBSd8oa6Mvzviw++w7TwMpSWyBFtRH1LNYZrCan/dqVNKMQM73n2tSDoVKQcaWUmmPbVyAgDo0P6PT0PelPLMG7NpgKEzQKXV4ITnKEC0Y+VkXKHPlXWf6UUti29RUhoCh3vg0wP7oHUvzycmpSSEMrfXiW92qEL5tsvjIF4eOmbT48kr1Ex9YbV2Z323ObkWapaxN+Gq7dSaN3vrIn63WQI/tCbyvld0+kxEkUd4TnU9+lrxF4vbqy2mFaEoCkYONGyczCuG2fClr2aOWSfpIYGMXtZNviRAqybyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EF8yA+vsMRofn9I7f0EMCE8SWsWXi+wWoEIYFPvjiE=;
 b=RsPwbzdrnegsAm6DJAgHsLCmG4Lpjo49TEeHSdkA0xZfjbdYm8+fXxherH74lW//uWbwHx1+RGvviJc6JbV52NKampo7uEAzeza9zPGZHLiLri5zuKSy8PrP6jl8T3u7aG9t3LZabBCIThl2i20ykw9eZKpLUy8HXbbYS3nUE2j9PtE+MOOa18DvUuQCGAoMp0EjBexxHXLjID+4dxVKVeaPABlAckemNe799uIFEx7/yDpVrX6WKzy5DSVpQcvdN9OD5mmwqszAt9AVWVmdQJV69+NkMw+UWdd5Ejgmsswv9QyvuR1ozaLCCrypjHWoaSxc2aBwq+OFFBD74E2Xqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EF8yA+vsMRofn9I7f0EMCE8SWsWXi+wWoEIYFPvjiE=;
 b=QPbA+m6aDvFeoJpexji7m314OWTGT+z1NJWhn/iBx94dEW/7wvp5BPJLyEuTqjlNL48WUQ7gMgkutL8C9b3Xhk5QHM84PmGECJWuxBxBiLA7FsHF6MkjTq2TkC2Fj558Cbvi2e1TZCKt9wpQnGT769Gg8MTUCDdFQ+dqcNbGgbI=
Received: from BN9PR03CA0872.namprd03.prod.outlook.com (2603:10b6:408:13c::7)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 19:03:57 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::8a) by BN9PR03CA0872.outlook.office365.com
 (2603:10b6:408:13c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:03:56 +0000
Received: from VC-PC.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:03:55 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Date: Wed, 28 Sep 2022 15:03:57 -0400
Message-ID: <20220928190357.16117-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: d02e115c-3e17-4e31-6f1f-08daa18431a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3VbPe90MmUC8HA9LKjeFmVkIz2dpgmMWgiqeKemOD8Ivmsz9fqOCN4vFB8Nu/fcqAyJBU2ciRBIyI0WQSt/6bquGHFNIzLsi1lqtE5I4DiFPcsfsNTP1+iBWsGXzSNIDlJBx8uvrHh8NVjuLoKx5rm/pwJqeRsXtQZOLo66m52X3qfq6+ACFjiyoVp3n/DSwYhrnkLEPPcISRNKIRFPFE3WrVXRS0Y8iczN7xjQ3vOj3wjL26Le+KWXl7gWP7DiIrBqO0J9T42XYQrb4U0xTnXQdmbYzWYxp+P4qsmHhF6D9KuVgisyMdfs4VpN0L/rfSAkRaKLmJImqrk00CgqMfyyyNrRmo1Dhm3wbxeRZ9wnU3FLLZ4QRUISGZubcRqSVJMDfamBmYd0jay05nofQJb01di4TF5crWzXSP2fRZhddyukLEpQbZlwHFX9clFLGnpsA9LDDq1+86QZ4ijXYNl0QLB8/ZDOXKxvt13+9fO2wuBFj9Ak4QGN5c6Ae1/bQIJOepb4x26rYq0pMSoSi2y70ERc2CWoGiXKg0BQIUB1RAcTYuWIfY7+jmA9f49tMejrfu0aUGd6GZNwToTUIAIls7KqRuMbQiUJwf7rHiiy1e+271FjxV8YXW9oz68HtJAa9FJDSuvgS6qZ0aQUBn9lnXRXgPneYHDjlGK3o06hDnshAbQUtEDe+TUTeg06AegEOvx8DAOfS2xTEBaY68xcEHj4lESkMuwf/JxYjlRmrD7PnnhTMS7X0SRkeoQlKH6JedLTcwCRsW5OtH3yBQNXgdUYnHl0rUMiIeO5Bc851hIwil2oKzHGIFi+ed1kpo+OKFV7x04dfzrR1/VRc5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(83380400001)(36860700001)(82740400003)(7696005)(478600001)(36756003)(316002)(8676002)(4326008)(70206006)(54906003)(40460700003)(70586007)(81166007)(356005)(4744005)(82310400005)(86362001)(40480700001)(41300700001)(6916009)(8936002)(5660300002)(16526019)(2616005)(1076003)(186003)(426003)(47076005)(336012)(26005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:03:56.6442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02e115c-3e17-4e31-6f1f-08daa18431a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
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
Cc: Vignesh Chander <Vignesh.Chander@amd.com>, Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For xgmi sriov, the reset is handled by host driver and hive->reset_domain
is not initialized so need to check if it exists before doing a put.
Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index dc43fcb93eac..f5318fedf2f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -113,7 +113,8 @@ static inline bool amdgpu_reset_get_reset_domain(struct amdgpu_reset_domain *dom
 
 static inline void amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *domain)
 {
-	kref_put(&domain->refcount, amdgpu_reset_destroy_reset_domain);
+	if (domain)
+		kref_put(&domain->refcount, amdgpu_reset_destroy_reset_domain);
 }
 
 static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *domain,
-- 
2.25.1


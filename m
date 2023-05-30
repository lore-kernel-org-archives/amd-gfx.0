Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B41BC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 19:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E27110E0EC;
	Tue, 30 May 2023 19:08:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A018310E0F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 19:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhW53QNhaMirN+KBrFgQRDNNZ3vIWQkduVyZyd3i3bRUrTU+6GCgSIHNbignj2psqCSwoorCkRJ0jPNJeCmJsXXNwWt0mNWCNGPpzSrHaUq76Dg/svT3MYLMEPVXgjQHBQgZqB80W/6wTFW4sUFxj5+pgFCHArPKdlfVikV9cAfmtlVIyvmoQ/aVURf8Mhjxc66jxdNHGqzV83VZvHaIUTytYsyECzbJfIk/tuk4OZHxUXWKrUt/s4gHOw5KWEVWA77K9+HFgN1CDazy0gVpr80OmbKFWXB9Vf7CNKwtIfuQTr9EEAimeUyHf8NaWlhaGEFRtZFi+3oapVPITD6OfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ftF/ntwEYl+k+Wjf8lumgrA8GaQSym1EJnTxnD+ts4=;
 b=kFNpclOB8/CE5gBhh9Qqpjk9sTxLyCELtPhPGEao9ObtVNtjdvNYMLPOIeGZ9H1y3PulLWL5SlzgObj1fRcZZ62MM444+Zx+p2BH0heT1BwObICJFdKC9h/HC/CXwJwEGWVy+AkpaZ4h0gREqLTAs9vFLrO+6II4VFqvNqojm4/awc4JhwHdV0H6I1xV+zZMUnTHxauslmqED9qRufi1KDhe5kedsNJxZqozdf9fNcjBdWtHx6J93uGWe8YeZm6x31Z95FCxIPCwZZSEg0ks8Ffq6b0WyWWLRi1mckaibZK40yuXIoYtpHPV09NU8ogua1LSGkwLyN/c9nkJPzDKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ftF/ntwEYl+k+Wjf8lumgrA8GaQSym1EJnTxnD+ts4=;
 b=P64D+G7ZRMueha9SH2ygUutuMy77KRvaR2nSYbzQTd7Y6ZALmHs/R5ts6xtu2BxjE774GyPgyaqS8vxn2sAf5wsMoiUKozKSmyIFKmGpQau06pVkqaSJJI5CRKNWAb6X3AIRxnkDdxBDRc+9OovFViQvWRAbKjd8MBrlge7bBzI=
Received: from MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::15)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Tue, 30 May
 2023 19:08:31 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::85) by MW4P220CA0010.outlook.office365.com
 (2603:10b6:303:115::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 19:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 19:08:30 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 14:08:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Fix up kdoc formatting in display_mode_vba.c
Date: Wed, 31 May 2023 00:38:14 +0530
Message-ID: <20230530190814.3116237-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ed439f-e2e1-432a-d1f4-08db614141cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAFh/UvZ42iyo49vs41Pa25XmmqrQjL30FuKM9Pnhzau+mLDxz9BS41Idm/fX1xjXgazam+YtDt5Q9yNpOYruzXkKlqQHeCb3r6X9BNTyVRIWnn0lOXhzRcdSl27o+BziGCgMlcEYqXRCuM2ItG9L2yiZ/lIifFfnXTAhIgRBFU3xrayO46W3fE8awLoGvyjpQSZJUfuD+6uwdWmaT+exscrDO7hvIaWPVsx1GpqZyiuYW6X8+neQyWA41R8EceELdSMtKsSPT1X+u38REL4uMFxjliCMd7eyusX7fbTri7FRedzLDrn/NlhTaQV6cbnKqWLEcFZgeqfx8NcBYpf3vC9mM6yWSdQsqDJA/gadJHzQX0tvq9iz64FGRaGK9mT0Ky8AMRNJJ6AzqNhZZLqgchqSAN/goyio2HlDF2kBiE0mjEs/FAJuI6YLtUM3cKMvpx+ioy7HUh13Rj4RMjJUZBRaGcl0KQ3UImEmS0goiA3tNcnljgrU8xJ6VEUaGrKG1MbsMHz/4XtFAeI2PWrN7eJGCfFZ8jANrolTh2vkjlVTncetyNeJob+ogV81UVHEI6+hialP5+OSKl/SBTSMmFtU0bLBqsQk1GCQBvaP/5I6+9WjlmvtuYSVJBCG1l3WimIuL9mGyJRdFSvra9SshiD0QRKTeSM7sj2i9rLZ1xEOvXXcGG7MI9rdeLd71ajV+5LsgJFhtpqDsKm5dyhI5WYwP80Qj060teT9NMlaHx87ai7xgyUv7wc9Uej04bWES4MwYCATpFilmuOAXYpNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(37006003)(186003)(2616005)(2906002)(54906003)(426003)(478600001)(16526019)(336012)(26005)(1076003)(44832011)(47076005)(83380400001)(86362001)(40460700003)(36860700001)(7696005)(8936002)(8676002)(41300700001)(82740400003)(356005)(6862004)(81166007)(40480700001)(70586007)(70206006)(6666004)(316002)(5660300002)(36756003)(82310400005)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 19:08:30.2521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ed439f-e2e1-432a-d1f4-08db614141cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following W=1 kernel build warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_vba.c:936: warning: Cannot understand  * *************************************************************************

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 2f63ae954826..9a3ded311195 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -933,18 +933,16 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 }
 
 /**
- * ********************************************************************************************
  * cache_debug_params: Cache any params that needed to be maintained from the initial validation
  * for debug purposes.
  *
  * The DML getters can modify some of the VBA params that we are interested in (for example when
  * calculating with dummy p-state latency), so cache any params here that we want for debugging
  *
- * @param [in] mode_lib: mode_lib input/output of validate call
+ * @mode_lib: mode_lib input/output of validate call
  *
- * @return: void
+ * Return: void
  *
- * ********************************************************************************************
  */
 static void cache_debug_params(struct display_mode_lib *mode_lib)
 {
-- 
2.25.1


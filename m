Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327ACC35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C58410EA71;
	Fri, 15 Dec 2023 16:00:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFEAC10EA61
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ef+xkg4bvJgXjBju51uRe7swRoiyI484tdss8zKzWpLeSILCrw/9uLcUfM5cvY0rbdxe+4stSGGxj56td3G8JOA0ngurgGzp1O3E4Egg6JxTahVrCEESFNbIEqUl2xHM3Y970bmjayGoMx27p4X8bWekfeC8tpQytEdk2SyiOPdLUJbH+LrB8PsmnopRuOpTN/WszRYru37PdXRUquGexJvZfIm6Z9K2T4AjB0GKt27kumiNRA4a4zIDCVjV306DWtOPXgwh5y8/nS6BPH2vsHk0Yj7qJY97GS/yO/prefWAOipZWcAavv8tTocD+TFIaHEPciS/g5TK0CmCfGqsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBdcUlFAkWTH8yTTbFjaLifJgznK3Pw6kLaeohF6W28=;
 b=AGyNDIvhb4JYfwUCnRpP5dK/ODSIbhyfG8c7KyGvDEwdJyusns46JgQ4G/fSwHGg7Ppr8gShCXrlgbanbBgSF0YnPHMUCY9qTcQXlXHuoUBjWMN2xrSoUTs82tuP7umtImFtaXfGnlvy3l/6u2S+BrCQsLiRmOJeUJxulQEy+TDW0xfajqpjAjpeGcR0XmdiCGt9TDPkov7nUp/MdQ/5fWpxPyLdXbQRGEiFbFsxq2an8MNNhWd0qrEY3EVwnjzhqyGNyxfaCjnfclUzMeptR6+jtWdL6jnIi0Gq7cxbHm9XRWLMeX+IklMiYVnbBuMRjllHNQ44Bu5iV1flj5ICkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBdcUlFAkWTH8yTTbFjaLifJgznK3Pw6kLaeohF6W28=;
 b=LVOxRUnqTxhnrhgQfeMc2b5RpddHeH3mN4jZgc/HvmG2PlkQU6xaAlsDTiGL4CTgTJKjEQtQUuhUzcvPs9bzsKBfnmfnHzqY8/Mu69Z7kYSQpKi3ksqXPEIqig7saQpkd/8UmpGvUhKZ0Di0sOzgr33JV4RCtytnkhU+T4Qdj8E=
Received: from SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::35)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:00:46 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::26) by SA9P223CA0030.outlook.office365.com
 (2603:10b6:806:26::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:46 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:43 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 16/24] drm/amdkfd: use bit operation set debug trap
Date: Fri, 15 Dec 2023 10:59:43 -0500
Message-ID: <20231215155951.811884-17-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: a31096aa-e62c-4a3a-b6c4-08dbfd86ffd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXGl52Z7USG3VXyLSWDGelIgmMg+Lgzkg8JF982sX8178hCwEgkxxyrOWdSPGfJK2e5bxak9sHQpwubFKkhFP+qGO8lGWyCUGs9qF5ClX/bbMpCzfQSoDaDmuIfMIPIJrdhEItn+0liejwOYzcwTAUAenT+UsZI3Goq9SpkzmWIRfA/Aoe9EHD/mkxOgaNjZuiqOGZRVaGyiM33+GrzRTrFz01afNnwtEgFIv3XzWDn3/H21K9LijxVSiwioF5LvEEQ2l0u/M9dWnVYnsM1wv0jGtxe5H327YiBL+4jOfOQfoH1PxkF+HKCoUrYcUXEyzdPWFRmaIEurGxJhiBgMq+HXJyjAE8uPEl4FN+D8oVxUjatuNBCjdtZWvN71d978zYcEd2gmkZhZdyWecA4+/VqGLzWDnP3oJdoOfwfPNLz9rXMMdZ0YhWMrJgw7TOfz54+poldbuY4pASxaUnAKKqE/WEGk1dcryLyotqZKKZ151Ydyy4YxyJz2P5ars6oaRjlMSSIu8O2i74BhSIDfr3YUj1pJl2KWlRkh7Isq0M3S5e0O0+hKTHD8tFRLdlMJwMQVKd45psHyvMuzVryfStEO3uFLDWclu6qFMPB/a3Q7rTED8cLoxwlvKYVRnxitoHKzF22TXkSHWLiQHarMCrroXhYzzci4a4TfW8Ib55eF2L2OOliSjENKXtpaYHMi5tkQBChoi8BGPTi5fjp3+7jmpQ7NCBrxxdZZD+TZr4QuJ4ql24jW2/15L/G9yWLyUN9R6Uof5RXmpXsul4Nn4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(478600001)(82740400003)(7696005)(1076003)(40480700001)(2616005)(426003)(336012)(16526019)(26005)(6916009)(54906003)(316002)(70206006)(70586007)(356005)(81166007)(36860700001)(47076005)(86362001)(8676002)(4326008)(40460700003)(8936002)(5660300002)(2906002)(36756003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:46.1745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31096aa-e62c-4a3a-b6c4-08dbfd86ffd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1st level TMA's 2nd byte which used for trap type setting,
to use bit operation to change selected bit only.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 71df51fcc1b0..1a31b556a5ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1440,13 +1440,23 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 	return true;
 }
 
+/* bit offset in 1st-level TMA's 2nd byte which used for KFD_TRAP_TYPE_BIT */
+enum KFD_TRAP_TYPE_BIT {
+	KFD_TRAP_TYPE_DEBUG = 0,		/* bit 0 for debug trap */
+	KFD_TRAP_TYPE_HOST,
+	KFD_TRAP_TYPE_STOCHASTIC,
+};
+
 void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled)
 {
 	if (qpd->cwsr_kaddr) {
-		uint64_t *tma =
-			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
-		tma[2] = enabled;
+		volatile unsigned long *tma =
+			(volatile unsigned long *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
+		if (enabled)
+			set_bit(KFD_TRAP_TYPE_DEBUG, &tma[2]);
+		else
+			clear_bit(KFD_TRAP_TYPE_DEBUG, &tma[2]);
 	}
 }
 
-- 
2.25.1


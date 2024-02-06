Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C910C4829B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6323D112B47;
	Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nLpgyGy";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADE2112B47
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Azg+X82mc7Sqh2jZYh7WnhvnfxFhU8C7BfcusXLXyHEWBH8mdkCjqJdgIyuf+LCqCXX6BsVDEiSPUdS8BRuSflVT8IKHlPAlntKBLtEzBN5uUHAWEudfxPv+3CJAjQXAOF92blZT8h4dlSD+bdBR50+7hwwUkOSb4UAJqjLVpNJNMqoeroeGnie8yUFastZFeF4EFPd08/ArCjw2hHhFoC5SsFxPMB5hnZny6iIHpyAXZASHfB4SFGdgd+M8LO4AH40pZpkVQRhg1ScTAzof/vXiRcVxxxWYGeF89cIb+7uT2U9Dp2z/NGgx1mriO9jy/kYm7wRVL5c2/BumoPqL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVBA0C+v9cl2Tpc8J9AuB+09xMBXVD+PaJKyyrfW/Sw=;
 b=G2VkEizMUzTbCwtuKYtKi3h6saqExtfW2lj4g76bdwi1hY8lt3J9KcYg5ivHzl/B/Djz8tARt7ue7uxBHi5FpmNkKVzOeYiTkelGJwJlJ4Ny9PhdxTwSQdG1JV+zhoS7TrAtvL3ZYPDcV474lRlF3/bZKE20PAsxtL4NUNYlSCp3BMwwYS8XDy4lZHTbN2Ls82CB1ddJvYwLvup5yOXRaT0PnXVDtvLzUoB6uXlFUcT66LuLmJnxPpt7ZAXdCpj47iHTSDH8zlkcIlMwmk6J4YEKkaJ5XKoQNh8aZdHyvU85G3F93T+E/8jRre4L3EcPkvNYs3g+nlT21djy1YUgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVBA0C+v9cl2Tpc8J9AuB+09xMBXVD+PaJKyyrfW/Sw=;
 b=3nLpgyGypb2gYATV3XHueCGrSxwT18rWEFiPPdav9fmqhTYO0nsgzLCOhuj3WVSu1XYDFfBEEeBTF+p9nzLIwCRbGIvPYr44NT+KCGRcyiuA1FKt2s7xS63yytbZaSrCAIDNpSTKIfCTAAp1I2cwB4T5KJx5UAjIngeyHDN3cuw=
Received: from SJ0PR03CA0224.namprd03.prod.outlook.com (2603:10b6:a03:39f::19)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 6 Feb
 2024 15:59:43 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::8) by SJ0PR03CA0224.outlook.office365.com
 (2603:10b6:a03:39f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:39 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 16/24] drm/amdkfd: use bit operation set debug trap
Date: Tue, 6 Feb 2024 10:59:12 -0500
Message-ID: <20240206155920.3171418-17-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 585237d2-c8a1-4fa5-d14c-08dc272ca22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHSz/yqOqZ/476zo8Em9s1WcaF1gcdi/btjK0k8Rz9tpG5/GAdL16zBjQQi74Pk27OxGkbCn8C0Yl4JsbhmGCPBBYlvbRv760LVEFuvopxmO1jk0tFFJcDsjxCxp9Zbo73RKsQGyERcX8PeUU9H0aGtx5doJ/N8ScMvViYZwIe5fTH0OwzPEsqKoSLMjiwCA2aCd6dQ9CzYQ11m3Be82awLOeeXTC7ZA5VI6ozOe2lyU6Yx58CBn5npVlzVjn9oVtjK26maEFLpFTN5AXHCAchwXc7WnGDMDpFTRXhZNmn3n1R7hRn1D8VTTMl+0u3v+SU052gBJ6liTKzSt33GQhayJTXXk0aR4JyrlEQhQYV8ya6r8VP9nDlzHKChDrmQLCaV9DFgjImb3c9scPjsEobS6zK16X+ma8dvj2MT+YfnzLPxZ1huhxwrkGrZyfHYRCNprbDgWDYwVuYGzo7zRJKEPj1k2OkWzcZAfnWxW68KpNgJqPJW8s2kJOgSBkQfsi4G86qC6LiZYB63uxHg2L7kYKJ/PiZjk+kqjgERWw2mQbpOoRMCMUQNXDNLuSOANg+CyAD7mVJ8D1laAL1rnIiClzwHh6rKU2M2FQOQqPpgV0lNy0KvGAwK0q67zb+YOFgG/mRy2s14XznVNXPoN2FYB9R3UdqvhXwdZ7YLtoOqeU3Vbefx1V85DV287UaTDnNzyeUONJPmbKkM7XiCL5wbWhaQrsoi4sJiuzV6piW9anCivU5W6LpGDiq5oZWMuQqsJfX7Fyac5DV6HEGIDPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(40480700001)(478600001)(86362001)(356005)(1076003)(83380400001)(81166007)(82740400003)(336012)(2616005)(47076005)(41300700001)(26005)(16526019)(54906003)(6916009)(8676002)(316002)(7696005)(5660300002)(6666004)(70206006)(2906002)(4326008)(8936002)(36860700001)(426003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:43.1604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585237d2-c8a1-4fa5-d14c-08dc272ca22f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
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

1st level TMA's 2nd byte which used for trap type setting,
to use bit operation to change selected bit only.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 717a60d7a4ea..3e3cead6ccf8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1443,13 +1443,23 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034F9F8FA78
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 14:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907EB10E8BB;
	Tue, 21 Apr 2026 14:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UMsqLT7S";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF2910E8C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 14:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9eMGnK4kPO2085yRnRQlLhbrwTbFonS0Gb84DJG4jG+YwxINKD30FbNgDyWbiT6q8lBtKxXQb39TGDqzorVKOaNYHbb9qefSSGUog7pii5JtSql6g6xTZjs6sYtBNzGILo7VlJXwrNjGrpgWn6wK/mrxGxh5v+2v6hZKbDa7UET1GI4lSfd+966eNTwwoZO6a09cdexBg6qtYN+aC2q9umjCV2ohG8/0dmv6YJEr5eEtny8j5UPITviuG3wK4/YWIdo7hK+yVlOr1g4vWly80xgNZhZIrnTtOaUAIo+ctIsh2vKrN0P5ZS+YNxuO+cN853n+yc+KVIJiClNRRXpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qji13EVxefWItq6WIEmJphFnjXO47zvdeFFtjFHElIg=;
 b=OD7F8ay1qU/UMQr/dg6vfT71tpT2/4wl9XO+Q3NiMc3YY1v3reKLkGImHutD6ct3TrCqq3XCUpKACjy2yB9oSb0tEHQ0RYjFLAWtcVzT7M4Qd4Kp2fPX34eD6jBBnIYVRoWf07VrP2fzklWhDR6EyvX0uJfZozWteEUfeIl3FJiG0M4+adXqaGC2tnDC8Ra7MH52gLoMo7TGN0v8zmLM2HcxqcdMyqUCNdg9/E+BSkwrk9i2oVLA5ink1baN4yI0H9SsXV14Dm2AZNcnQZjV6cBl9tYHib0N/yp7Ki2IcaC3nwijxVrOI0Rzqcl0cMJb4pIqzJNlBd1B1eyqnB2Gcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qji13EVxefWItq6WIEmJphFnjXO47zvdeFFtjFHElIg=;
 b=UMsqLT7SKyR4fR3YSxgN30Q+4G8UjY4Lx4RK/j0bJMd4EuG4m9YTNFCNzTULrfz4hCk1qak4ryb84jHbAUEzUbY1XqCMhde/7Cr35FcrY1rjOgSjPU7fVqR3S7dBPdZxgcgDPxs0z22aubLuuWZKIJ25aSqYJ61Sr1UbFZTKa/Y=
Received: from DSSP221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::19) by
 CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:29:00 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:3d5:cafe::c7) by DSSP221CA0002.outlook.office365.com
 (2603:10b6:8:3d5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 14:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 14:28:59 +0000
Received: from test-X10DRi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 09:28:59 -0500
From: Alysa Liu <Alysa.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <amir.shetaia@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH] drm/amdkfd: validate SVM ioctl nattr against buffer size
Date: Tue, 21 Apr 2026 10:28:49 -0400
Message-ID: <20260421142849.19422-1-Alysa.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cf9e69-ec10-4099-7900-08de9fb2544a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: fVZvTi5l5ajm5sGZNSJ/CaaS7ACfMJuWm/cDfdWLnGj/9Z3dqLpwMc7fl42hlxoScQqJRkCyjx1RiRpuFvcmv7hhpSHcfaMptntDO6QRr0RK6LOG0BRog+6O7PymO9dLT0wAQ1f47imHeLAWgA9zFIgrTnLgPzyZtcPvqUcS8wV8qfktWaIFl1aXGT8ihefTnQQJr7PEYQN6UIc3Ez2eEJks8T2NLa29isLz0eFisyCuguIHFrO354yPkaccuWjO87OGBB91C+sMTIa9kj4CkNdw3QsbSfV4RHEYs+1J2z8BcZHXwWqA2S/AXGcl8k4jzcLwOElfZokhVK+DfeFxMN8R3SIaCqaoaIFaFByYSWdkCoDKe3jThyLWEM5w4mcVN5R1oo39w+EXNLXHDezvuBxEXaSdB2PX+n7vtoX5zpcsQEbr40g13upDSNNAWsq9ERqNqSYKz2jA8Tx1MgVBiG6pvewuAfpQAnDNwbfS2YP19qZKX8z1y/eTIteUzXYbjEJ8y9i7qtygqX3DPMb7+nl+iRxR39JXxn+r0JuMxOd49onMqlWJ/zc3sj2Vj2UOB9+UwWD568T7t+hm6LXIIBmNnMA3BTMRpO4gWKOj4Pqc2uwLKKC948w7bYapGGgv4MC2BqV6WYV9wsxbv2K5aNJ2uIOLlUMUmmSWUgwM6Ad7lF5wfZOgSe9XyaN6CW+vKwJEtOZJott48WOp2hNfxcJg6WXnWkqdiKdlhoCa1S3kCFqGzhavwpL0ZeWbdtR67TteQ3fPrtUBJ93Qf3cGRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jjThNfph5QgrFLtAfNAbt0nVUIbuKYNvYo9ZJezq1qkMmomR08Bpk7HtjlbbxEpr6ITvvc2XSLs46B3+PZ46v0j75N1SBTt8HsPsZ6bTUE7OuJ8ZeW5u0grxc0IJF184q3EpOk6VXkJN/lamYTJCBzs3bUEuX3pndt7nGfkHQ1rsN/gFtEjIQ3v+mLNya0jGW6nk0aM88HvXRAB6N/6nhKzdxoup9FcvWkF5pI0p8CtrnbTExscX+Fb2TaYyKXe5cq/HDaENNz+RGZ3lwftXgpEi5hIXUYVS7iRVckv3oAZPO+m1tKdBylTz7zu2ePg++JNXfPpJ0PHbOo+dhmEyv8+muVMnYns+divDQeOwsc1aKjPLADi73CazrC1qyhrRNJ9SqW9u2Z9UbSwvZoOP3JbpzTQyPwkmDDTqFv9bKt0pyiv1UriPEYVEsr7JZIIC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:28:59.9558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cf9e69-ec10-4099-7900-08de9fb2544a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
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

Validate nattr field against the buffer size, preventing
out-of-bounds stack access via user-controlled attribute count.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 16fb39259911..3e575fdfa4c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3636,6 +3636,22 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		memset(kdata, 0, usize);
 	}
 
+	if (nr == _IOC_NR(AMDKFD_IOC_SVM)) {
+		struct kfd_ioctl_svm_args *svm = (struct kfd_ioctl_svm_args *)kdata;
+		size_t expected_size;
+
+		// Guard against integer overflow in size calculation
+		if (svm->nattr > (SIZE_MAX - sizeof(*svm)) / sizeof(svm->attrs[0])) {
+			retcode = -EINVAL;
+			goto err_i1;
+		}
+		expected_size = sizeof(*svm) + (size_t)svm->nattr * sizeof(svm->attrs[0]);
+		if (usize < expected_size) {
+			retcode = -EINVAL;
+			goto err_i1;
+		}
+	}
+
 	retcode = func(filep, process, kdata);
 
 	if (cmd & IOC_OUT)
-- 
2.34.1


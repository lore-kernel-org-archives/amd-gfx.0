Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37757C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 22:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6C110F0E7;
	Wed, 20 Apr 2022 22:47:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D07D10F0E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 22:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REdUM8ZmiM592uEtNy+cQZVfuNfnFzZK+OsHQ0b47MjVMyKuKeoc8gG9tY9/jlLmiv7vgkfs2RXk7uUth32MHGrLjJeHCcfENh+MZGevaHqTgZ6ELdn9ON1OT2ERQxL+X/PPIDFNnl/jRNcgPhMWiyJwkUFoRBEL9MXfHBl+MrGg476YgICLFcrw5HkGY34nonIN0Qpl3YWPeCL/qW761UMD0HpEpeQyJtpz5XstnejwuX1Tm15Hv8iMHpOSOS+T5HVRFPhHymTV6D/W37S+FbSjA2j/pKV3t80dWlO6nlC/vg8VQLJL5JbL19Yod75mf659DH7nx2g/bAXc3IwK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+mP86T7VsT0PLfe+lbsSj59hX8iX6AYku6MPioNlQA=;
 b=c2s3bDxG43HbUo3Ovfr9+j+6Gmsd3Uwr11tCOAQijYpX+9crMHqIDUOh6DvC/cMsxypisZfXPTqXFExax2vlTKWOcF4X3tVYwAsC9AVu+ohbnF1zP+2YOxbdJ5AAhKAuiG+00g+XHzWDrO3E8s1PZGL8F2/H82CP2kTAu9OUAuxw3bWHoJNL137oEj0RQ1APJNe029HClv3m4yNi2kSxmZAChTiMHYDRl+6zI3Mbyg7hPnv7xz3a2yNNukez7xqP5ulZNnyg3TlFekrdnnRlfLBmXlcPtt/28woewWhiwTxudgNDt8VLItAsjt7Oea+gnLmmVxqDDycUcHRlMX03uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+mP86T7VsT0PLfe+lbsSj59hX8iX6AYku6MPioNlQA=;
 b=KPhgCmc2S/TMf9mkPe4wsyAQ2fKgi8uhg9dMCL1hjxyoXq4icYA+Lfag7kUUOR0P4f9JMoA/YVGWmlm8wF3S137DLd63SSYViFfqfQwItegqHRgxrPVRseVrTS6AC2ui8IfPaVxHX7UDfuXKw0U2e8ommIPNvuDCr/z1Im0Cs2A=
Received: from MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25)
 by MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 22:47:15 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::37) by MW2PR2101CA0012.outlook.office365.com
 (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Wed, 20 Apr 2022 22:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 22:47:15 +0000
Received: from AWS-Host-01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 17:47:14 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3 v3] drm/amd/amdgpu: Update MIT license in SRIOV msg header
Date: Wed, 20 Apr 2022 18:46:39 -0400
Message-ID: <20220420224638.274991-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cc974d9-e8d4-47c1-b4d1-08da231fb77d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2569:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB25694110DF46DB054D310090F4F59@MW2PR12MB2569.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ypjnrm/pLkdTeVKJorRyuXfsKdzAixnXvJNf89+n5pbqTqW+hJEcadVt1MT0xYZvVz+RcSK5vJVMymz4oH/IACtUNIJNzGiXT1jege3QZgk9CqHcbVbnsLmnDFUsnq0grvAvqFzHDfc2SxjYb5dCaoS6qqAP6oISFzlX78qj8TbfsRBx63+uZP6noSL7AffVQAEgBDA8iRvjdr/ZOVBzP9cXrBM6lxCaAdF851oisXbYV20Eu4n5tzADqbRGzNKhCKvdWnkcKRVhxxWHgg9g64sW7XOLwC6HE/jD2UXelq+ovA0PXLLAkek/+qQRVyGbosBpqs67YEyV9dLYhkW5U6m1RZiATuwfMSEsLB0HwOh81WLoUMy3KmtgaG0FW1BdR2rP/3vtt7Lo5mmRLHc9/A4HWfA0XmBPYbx03hcKTh18S6ykK4gAM7n5f0eMR3xDYJv92QhzT6uhcKDwm6TtIn7bQm5cMt707Z5xgXFblJjoIA5d/O/wEtqG6kpITG33tm0VrPe2drEAdnG9HpKrREMU2dDlwMKgAI858m5WeAxh9OKE6Yxn0+fjaVO1vWV7ftSsgQ4+xzlgUBm6orNVTRJqh8jF2qbKxFdjONZ3Pyc1VOoZ7JXQBxtqFxMPhINZt5mP9TLA7Me/WGJdEnrTriIYFiNUboNBEPkJsrPV4hUyt5LwezfuQHyIJn1kdXa8h3N/wwtSXbUlHKJBeH7Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(70586007)(70206006)(356005)(336012)(2616005)(426003)(5660300002)(26005)(86362001)(36756003)(83380400001)(1076003)(6916009)(6666004)(2906002)(7696005)(47076005)(40460700003)(82310400005)(15650500001)(316002)(36860700001)(8676002)(16526019)(8936002)(508600001)(4326008)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 22:47:15.3898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc974d9-e8d4-47c1-b4d1-08da231fb77d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2569
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Update MIT license header

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 25 ++++++++++-----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 7326b6c1b71c..059be32638ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -1,24 +1,23 @@
 /*
- * Copyright 2018-2019 Advanced Micro Devices, Inc.
+ * Copyright (c) 2018-2021 Advanced Micro Devices, Inc. All rights reserved.
  *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
  *
  * The above copyright notice and this permission notice shall be included in
  * all copies or substantial portions of the Software.
  *
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
  */
 
 #ifndef AMDGV_SRIOV_MSG__H_
-- 
2.25.1


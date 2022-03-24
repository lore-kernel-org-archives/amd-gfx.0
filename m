Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CD2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 21:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E800B10E3A2;
	Thu, 24 Mar 2022 21:32:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0111E10E3A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 21:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0JQrf3wkA4RB20Jiskvoh3ZK2guqaf6j00WIyMbFla7d+ErCzWgmuYbqnrFR2zbNDbCrcZxo4ipxU7I3Wx3wpmQLUqH0PdxCGdsr/bG8BvDI16fFVA2ju1TXEkku0eyj5jZJIHI2F7iQjkjSOrrDH4R86jmQaht3C/J94gALsX2PQZ7ScDvmKdwz3WuRzhmHBwIO8a9ekoAaV1G4apCS2h22A//pXrwZrxtEcZhX+hBd1gVbZUkiUnWo9YsRRWStkkI15XG2DmUGi82MxGJFusBKrbGyQt+JlUyj6K+8s+bCB8udcvUU8ZOxw49RiF/kktSdGe6Y3faFljHT1li1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEiGyT1ornYGBgmC8bbm76owqMOrtTp8qetpRIpVgOU=;
 b=ReQ9+XqQlI3RuN1h5lxC2lPq7/v3OQUZZSsuEsaLnw9MLed4scZ+8rZnMzG3JSrVrjUwfXkVuWEittiSjjRs7x7DeLZiV+3BbTqaKWzc187UsYNYFpl+0nf6BzqqL5sXoLYi6i0OJ+SvFfm+VYkdoK5m88RCBQZ5Dt7qa8qE7OEdATWfdixTGDcZBZPPFKgImGcINj4eRh1DvPMWDEMGa/nJkoHJ1cvWKDLt7GfsTiZupVGrgLFRbG/3RlxOErnyLxCWfU1aqfg/vhxjqXbbOYTzK7ANSXcNPdngyV+cBpPXnzh4rqBbQ5dObE0/QkqcpzsNGtIyVwKUSfNQn+4M1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEiGyT1ornYGBgmC8bbm76owqMOrtTp8qetpRIpVgOU=;
 b=aOlJSbx8dW3sBH4UjoHSNrO2oJUEaguxa7S8iIgt5Fh6GTLUy07Jq0SZGQKtgKxMQ6KkpfciFv2fq/zHDPzDbwosMTPAAx2xOaRclL/z6PYMyacg3bdu3nZyVkc+lc87mr8nMBa6mN0EqlynH7kN04ZDLBgLA3/5bTq24KgG9yg=
Received: from DM5PR20CA0023.namprd20.prod.outlook.com (2603:10b6:3:93::33) by
 BN6PR1201MB0162.namprd12.prod.outlook.com (2603:10b6:405:51::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Thu, 24 Mar
 2022 21:32:20 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::43) by DM5PR20CA0023.outlook.office365.com
 (2603:10b6:3:93::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Thu, 24 Mar 2022 21:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 21:32:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 24 Mar
 2022 16:32:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix comparison warning with min() macro
Date: Thu, 24 Mar 2022 17:31:56 -0400
Message-ID: <20220324213156.574719-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12ba8395-c718-4ca7-9396-08da0dddc6fd
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0162:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0162F190D58901CC42611EADF7199@BN6PR1201MB0162.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46LLnc5krY1TY7IlGop7x0rbWhrn79VR6DmsGeKQk4eJzuQ9yogJTHjwGxpA2Y+BvS5AeCvSfem4d26aNaEEyqPjBLzBwCYOvf1QZpaw/jWXxa0ZBNqQeek7+OmacC3bxgnudT31HN/kEkzteosypXgpcQQp0+PRQbWo1UZA8MdUK/IA7TMFlL6c0H5eaFhSWM5zQlQGGPYIEVfqQPKeUZ0Q3KPXW61PfdpDc8e+k6fKnT6yJV8aB/o8zZe+gr7FCYJo7JgUa6rRg+LUX+qdVXqyj2W5wlwJ86pLpgzkd8ix/w8KDl8KDXaL/tdzaL7CzXejQFOJbzF9QKQRIVDFXSQsBNuhgMxem/ggHkEyCWlzLIo7WdTfvajetWYxVpdCKDBkZp93Xxo80dYs8HnqJNXtOdbMfSJsFm/7ZLoq7FHgZCCPcf7kR+Mdu36zO2M7NnuLKLVJyk6jY+NQxO+MXxdF0CKt/fFFxHGIEN6MHz9v54HqFdnSHefXLfj/SjvmVOYl5RJ1WTnRi3Mp2vFw2tF1SoildUSr39HOoaGs33u00EyJ2aR1HajkdEdmQPg+524lgMDH4Z2RyX2xTsbhSFCHDFEzoiSY7nI5jteevK8iOtJ5GA2cIhlIdCo9GPksRIJnhBqQQ09UQC+HMbuvagr2Tmh+9RPnXDMXahNCspZk2MWq932FnRUjHcU5wISUueggJqOIUsTJs8KN91PlQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(2616005)(83380400001)(356005)(6916009)(81166007)(316002)(40460700003)(47076005)(6666004)(1076003)(4744005)(36756003)(82310400004)(7696005)(508600001)(336012)(426003)(5660300002)(186003)(26005)(36860700001)(2906002)(8676002)(4326008)(70586007)(70206006)(8936002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 21:32:20.2693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ba8395-c718-4ca7-9396-08da0dddc6fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0162
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Properly case to u32 to fix the warning.

Fixes: 83f1287c57228f ("drm/amdkfd: Fix Incorrect VMIDs passed to HWS")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index d70f787369a0..62aa6c9d5123 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -484,7 +484,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	/* Verify module parameters regarding mapped process number*/
 	if (hws_max_conc_proc >= 0)
-		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
+		kfd->max_proc_per_quantum = min((u32)hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
 	else
 		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
 
-- 
2.35.1


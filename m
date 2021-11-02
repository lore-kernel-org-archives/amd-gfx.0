Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C318C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 19:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E05360F02
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 19:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E05360F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC5B16EC41;
	Tue,  2 Nov 2021 19:23:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A846E99F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 19:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeKOOXikMlKNLJTQGSY5H5GBQYzzweE7ofTOFW2oDCT2KOPEckK6Gh7MJ0kzjJNIKVw0yob+kK6Y8nq6iVwq7+uktJWUSPjoOhTdeipHXqju7WjBym+v/j3+gnE6qF1cT69v2S7r44cxVY0TGRZNQXli8nBavBqCb6eGpPkpmNkJf5lgqOJFLthbnfYItbMiW84a3kahErNvI8s+ORVrbKuyrm9wpjM07PykCNHm9f/f2L5tsHiWvw7k8TWWslUuOV1a513nQgOJURCtKbbscOC2gugoha9uy++WN4NUmlulskEZ+vhV17ur+VRUKtJhxoYUjwnBbtHrWo89wahdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MivDGCfvRTSYwwsVyr3AO9GpLGFOVD2/Fh0W2mJGA+E=;
 b=ffHgBGI9PSanmEZRTZCH43axPtmr/QgGK1InY3HA1gIWrqsaXnJTK0PQOpQMAmg8E4lM4ufx4avJTzOrdwLWBw1xhhPw2cWI72T0Y+iLySur6AdYBqf4FL/w3qL6n+nUeoPiRZpTOj2RbWjsrL0tMTZlH2/9l4s2HZbGe0R2BDl2Av1pp/AQOaIDCPaxTZI8IRdp6pptM7AcApL4P8PmESmc7Z1oMlxzg8h3uXDEyXNlO5BgUdF1+mq1gN5B2VvKPfCKSZnSsuen45qAYfG3kk7Mdlh1GYjHRz4L8oRic8OjL88wCW4dz5p5J/tRdqEoXcxd7w1J9k4HhqHUcOpPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MivDGCfvRTSYwwsVyr3AO9GpLGFOVD2/Fh0W2mJGA+E=;
 b=d0D79BMf6gNB6bEegG4UtuOx8d4WVFaeCJpo5e6yC4q4VTDJ7MSg6/a8jrETe320VOtYRsGDAz/ynVi+keBcd14koYpG7idFLvKVvfh4Q8/TzuKGotRYHi63WHa8hwdup9Hkcn0MvGESuo+4fPe7j1+tKWpyOPBz+/ajTxAlX/c=
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by CY4PR1201MB2469.namprd12.prod.outlook.com (2603:10b6:903:d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 19:23:43 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::17) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Tue, 2 Nov 2021 19:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Tue, 2 Nov 2021 19:23:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 2 Nov
 2021 14:23:39 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amdkfd: fix boot failure when iommu is
 disabled in Picasso."
Date: Tue, 2 Nov 2021 15:23:23 -0400
Message-ID: <20211102192324.3402-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe61f3f-0680-4b21-286c-08d99e3648a2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2469:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24699CD7A7E42187BD65B831E48B9@CY4PR1201MB2469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:164;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wC0M0+m7KaLsCUz15MTsN0tXUDjWVyoYResN9A6ytkBurTz+ftkHFfu7nCxWNiX12JovhPyYEIRHW/ANKhsED2fpZTe1OTSYeBOwvXetdIT+j5EacfpiS9N7NgeQ8T1BBqTQpEhOrgLHceVug8xRb3+M0pQRntr3FpmhT6c7f+qTmu/JvFt3xwySgEVwJ/IFWBRsFA/85RLszFE2QJDdFk7cF9d5fBzGw9aOABChrTBD/S1yntH2bAkcmVsMrnhuoADIYMOdTfz+w/lbqFFbzsli0KEUThNFfgfdZtAtFqV3lmPUKaN+eg37lYlSdzj2MDWq1xoavmEb9Q7SAfWBw8tcIM6/z891poDP1+dUfqXcJbOoAeL4KjMqjakjqNavfM0giYm2DrlU7xxyP4O2S+Yl3NFetO8/7dRCoF+2RmZ5gc7eEdy8ZFwRTH6mlhB685pZhIXMH1YUY+R0YMjdTRxCqxi5EypgsSHbGh1wfHfEIEDm1SLcSs6WmbK2wDrJxgF+K404pUvMEq0y6DrkZPFBvw0ybc2SMFq/apHkdYIZO2nANhKn/ghQnr6AKXKlrEKREq02XBLFN/J6x4UFqEARB9GZhbdr/3R1WWfEejRYzEL9RntaUhStcNxBD3YSYWaHAFKVjP4MD4qtIogYLqYbjtvKR42DLHgnfTSODG0UhKtbJNeIVdLaW1Ij8d0vYMbCv1wjdqz/TuagkEg5z6/cQBUSumnawKGi1vNF/2s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(1076003)(70206006)(8676002)(36756003)(7696005)(508600001)(70586007)(36860700001)(86362001)(54906003)(4744005)(82310400003)(2616005)(5660300002)(26005)(47076005)(426003)(8936002)(16526019)(186003)(316002)(4326008)(83380400001)(356005)(6916009)(2906002)(336012)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 19:23:43.2865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe61f3f-0680-4b21-286c-08d99e3648a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2469
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, jamesz@amd.com,
 zarniwhoop@ntlworld.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To revert wrong merge during rebase.
This reverts commit afd18180c07026f94a80ff024acef5f4159084a4.
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7677ced16a27..be26c4016ade 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1031,9 +1031,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_migrate_init(kfd->adev);
 
-	if(kgd2kfd_resume_iommu(kfd))
-		goto device_iommu_error;
-
 	if (kfd_resume(kfd))
 		goto kfd_resume_error;
 
-- 
2.25.1


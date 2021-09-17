Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B08C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 00:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A5A611F2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 00:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8A5A611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863776EA22;
	Fri, 17 Sep 2021 00:50:55 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F5E6EA22
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 00:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRlXb7iFSP3GwmjR3hTrZ/dDEL2FgUe6iHfgxsDzcqJYMrP9PGRuGaCEwd3eXX1THj1/YWcdAbpH2uh3TUZAMoAgVhydk7W1vcYopLkzYwdER00IsqoqMWn6pJmYYEoDtntT7mzj7sI9RhPXpFPHGMCgLxwef5dKCjgJaDkkN3iXAXMfNWc8moFesSOJACB4+3P/Tg8ORWbuz+RL1n/2t9UwXW9QfGRhz6zotXAjmiCgOvxyrfIN2/GbxIUUYLnXUDEzJBaxWSKLOvTiAZw646fSgNG+BpxWnsAIjXgUGQnNkee5aCmLVsL/8YtQXCCIu29enIAJV7hrH2fPzENFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=+0JF6Vxzj/0HBpJOCxo/G+6GlFylZMY8939wX+Pwcsg=;
 b=JF+M06+KGSg5OzfetiuNMp525LvnNHgB811R/A0RyJS1oifE902QWDb2mGY0d7l25atTrNAQQDUeDBCzaofb61LKlaMG1HFKq5WbYB/Czp0qEUmDSgCxsIo6L2gEOPDl9gFKVZPwixTDqmZDEp2LweB1yhJAl/jjAiT/NHquk/iUNlrLsevbjLi+wlb/mDgNAVWqxKQXvxAPA930sXkE3w6D13YQOtPBKdDTHslmm2KQhFtqMs8aeD2OoM1FXMmbb2G/RZ9qJePbYz4mqLPtgnaqIKw4p/dO4CVVSzWV009X10kovUd1H5hsfDLywsT1Gl8dk3Hb0Q3w4eBnAhYReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0JF6Vxzj/0HBpJOCxo/G+6GlFylZMY8939wX+Pwcsg=;
 b=WCjmJjobMPtV5yIhxbmOYokmb04MmV3cbbs150vfqhQLiKqy1BMZCzXVam6M9i4ttwdCVD6SaJb+tBSlqRbwY5cLjg2Q97ysKcbNWcZ09imtnvwgEZZuDgMCZYUekEdqyjN1YjuUE5rXpWdQgZubFVvJXhmBfIY6+BXoW75g0ag=
Received: from BN0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:e8::13)
 by CH2PR12MB4971.namprd12.prod.outlook.com (2603:10b6:610:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 17 Sep
 2021 00:50:52 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::4) by BN0PR04CA0038.outlook.office365.com
 (2603:10b6:408:e8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 00:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 00:50:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 19:50:51 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: mask out invalid PTE address bit
Date: Thu, 16 Sep 2021 20:50:36 -0400
Message-ID: <20210917005037.18526-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58019abf-b42f-4f32-a4cb-08d9797532c4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4971:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4971DAB5E1BF5DE9144D6F5DE6DD9@CH2PR12MB4971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPamDHVWAvtFXy/BJVHCM2rEeF7V3n2alrzFdyxM0weCY0LvyyU+3AbregX43IEeNLc9ISKhb50Vs8E1PcVkm7Hor8DMvm+WRxTDpsih4LeDWXpPgdMN80b5R2odHTStEol7zDBc6dXoN83xtXNMiwhtPb85P5P3p9Nx03+SGFaVq2R+X3qTT6JZyt7DglQ2PYXwOg4vwuTZbq5kw6NbInq0hXGSB4u+iXCitVyy5Bpu7+QdIPnKy2v9+he14ewM3ZUzFx2UsS80PItE4GUbRNHXPnlrqgsBuC+8VVIMHXDinl+m42sZ96BU2GcY3oCgYbZYQBSCfzYNPDILtssbejv8819jsG/0TGOVmyXkRvHeDEIP0n9UHtjIJChmVe88L90Z4T1DgA/VeCnYd4v4XjV8LJ02NESYXWwF607RFKy+4HrtdfwN/agdjSDmU7FfNPjfN/uRI04aAMcy6Z6RtDqtEgQgOlcr9+QZeDjLPbuF+BNLAiNvyLsvI6hfLs7iQfTAze7GmTMDEaNEa70un3YjKfA9V3sl1XdCKqE++STohiuzGhwxyAnA++FVNUJfHJWJTC+PEe8qaVQTjbo+RJu3Vm5Qo5IP+vFSjFaXbZbV7db80QjG9bt2xiNmTEqnr79DmnfVfzWLNO2UngMU0S/QELeMjevKE5TJUKOt/tOJQOCIqyBVmR2G5+BDfvvWEtGIce7Tw+lH/JpgHKCp+ejb3zK6WvldHV6VsPvKMGM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(83380400001)(426003)(5660300002)(6916009)(36756003)(2616005)(16526019)(6666004)(1076003)(86362001)(356005)(508600001)(36860700001)(316002)(70206006)(47076005)(2906002)(8936002)(26005)(7696005)(82310400003)(336012)(81166007)(8676002)(4326008)(4744005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 00:50:51.9088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58019abf-b42f-4f32-a4cb-08d9797532c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971
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

Before adding the PTE flags, explicitly mask out invalid address bits.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a1ddf74bbdba..b40c15c9fc81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1445,6 +1445,8 @@ static void amdgpu_vm_update_flags(struct amdgpu_vm_update_params *params,
 				   uint64_t flags)
 
 {
+	addr &= 0x0000FFFFFFFFF000UL;
+
 	if (level != AMDGPU_VM_PTB) {
 		flags |= AMDGPU_PDE_PTE;
 		amdgpu_gmc_get_vm_pde(params->adev, level, &addr, &flags);
-- 
2.17.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78D3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C2010E507;
	Fri, 28 Jan 2022 14:39:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73CB10E2E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK/NrWJk5RJCNT+3x46IgBycFmzVYo41+kXkHr0dnaAo1U5em3ug2Yq25jXLfCjRNZoDLSnX7ifQz7xt2TMgoF3eQ4ElP1kLCDL0dYckc/8tfCUKNNnN5er9GOiHimnbSKpxI07nP9zP9vMpbEvACNgDgN1PYvPkdO+lfzxUFxbs1uzb9E7CQoTREtC8MgPbaAgqaEHnBAok3gbL3TczE+Fvfq5tIe02TpQhJmpS/f1LAR+AwnBrTfQ4YeoVL3+zPCJwOhIkhs8WIeXYqPfDUAQYSZjZ4k4M7TIQyHP+pl4q9jXC1KcquAgOVGzO/DV1THpUsGd6Pue29R1tDDBSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5octM/zL7vHuWan8QCB+elZI9vjHPtXMDoPrKEY4edI=;
 b=MSd+aZ9EC4DGGNjMNSl8GDwk98oH41wlNy0cWuwG0HidYm5jaHQmrUPbQwBoZlxVM61/GLWaOxRM1anTcjHtMcZBy+AlJqnB0j5DNMtV4FJu1Xtmjv5BPuNkYDERnnbo3N7wZ4UiPf28P0jCZsTTd4m1gIQ6OFTrzdjElGgylCRq3t8ffkp+sFzRzKQ85aLTz53wdx9taJ0p9LG2i2/P6MMUHDnSz6u3cqIRIYuTI3wKBpl8uPhtH4nFgYTjaxWT5F3LywgCjA6ueCyrdrQexl4VprPp+MIdXvbTPFaHMMNR6zNekcdVaQdRONlcFztWpI//QfSucKqW/WkMNi7Pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5octM/zL7vHuWan8QCB+elZI9vjHPtXMDoPrKEY4edI=;
 b=Bgk0shyhoXEW149hBJPl9iLgEIK26Dly36mI1c8dTLiwlsUWFuMZHSNel+n73IZztyrY/TP3mqrxz4ypIcFxYqf/7F8mGTU8czks8OfyS2cn1Mo0ietl8uvg8NCP0puBXn2WQ+wCXuk9NRs3PDCDB/IIhPTrIRppVvwwG1DHzNo=
Received: from MW4PR04CA0313.namprd04.prod.outlook.com (2603:10b6:303:82::18)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 14:39:45 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::42) by MW4PR04CA0313.outlook.office365.com
 (2603:10b6:303:82::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 14:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:39:45 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:39:44 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Fix variable set but not used warning
Date: Fri, 28 Jan 2022 09:39:14 -0500
Message-ID: <20220128143914.17343-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ab101ac-0f73-4e14-f927-08d9e26c072d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4357:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43575584A3ED74414A566E22E6229@MN2PR12MB4357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHEt/pXeIJJWJl4HODoQt3rCVYRFaw7LDBWgX0Tm7mvvbRhJ2zzfH+BSp+5YnkeYij20NTk2ZYE3fendv93dG/tvseISBiFQ2xR42mcdOGWSSGNkE2SePR0AGQlja4P7EKg9xBevz02hu7ydTweEkeQE5D5JC6wQJPxQgg1ne/y1a6JTtyzN89vYFPI8e2rshHfnHD1qpPpPmy0kkj49Ttl3gLOlPT+to5ets944LvTpUOLtPxB5i02lVVRN0MtJxKzIlYStjPIU6ewh++TN3UA1fDcM/XqQ/6DySw0cz/Woikl8zVBmeEJMdhGTA3SQyfeg5PJYESXi+RmPdHXUf1Y+LZ2RvjsRKCgJ3S1ixvvOhRtHNNEhvocr4r4z5M5sNQxcWlGelg2NhCLRN8DIUZcPf0iZr4GrfycYwsc1sMj1NbHhkjA2W5FE5feLNAETbKjeRAYtoy/zHFq5c10Vzbw8FH0yV1kLpLhdlnvqh6hStQX91/KSgldBhqllavBPbUyQhG6b7JFv1VIVkcnVPSaTmtFMA1JY56wsza9GjCJALM4OQz6JllZwqjOmPlCiXklT+96la7FAIZCmzACOJc0Y2/Z8AebhmGVqzQ6UpF8s6XFk/jNUwmt6gYHXctuF/V0AeFi6VxZLfGkus5FIMYS5YMhH7vR0OQrJnLtLPfWKWPPoYYNm0X8EwVrSeuyaoaIyZrkz7HJCNezyH4iEdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(7696005)(36756003)(316002)(16526019)(186003)(1076003)(83380400001)(356005)(6916009)(81166007)(26005)(47076005)(8676002)(508600001)(5660300002)(70586007)(6666004)(40460700003)(82310400004)(4326008)(8936002)(70206006)(2616005)(336012)(86362001)(36860700001)(426003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:39:45.2559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab101ac-0f73-4e14-f927-08d9e26c072d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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
Cc: Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c: In function
'svm_range_deferred_list_work':
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2067:22: warning:
variable 'p' set but not used [-Wunused-but-set-variable]
    2067 |  struct kfd_process *p;
         |

Fixes: 8b633bdc86671("drm/amdkfd: Ensure mm remain valid in svm
deferred_list work")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 649c1d2b9607..9a509ec8c327 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2079,13 +2079,10 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct mm_struct *mm;
-	struct kfd_process *p;
 
 	svms = container_of(work, struct svm_range_list, deferred_list_work);
 	pr_debug("enter svms 0x%p\n", svms);
 
-	p = container_of(svms, struct kfd_process, svms);
-
 	spin_lock(&svms->deferred_list_lock);
 	while (!list_empty(&svms->deferred_range_list)) {
 		prange = list_first_entry(&svms->deferred_range_list,
-- 
2.17.1


Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A4DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 15:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F5E64F51
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 15:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F5E64F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D526EA41;
	Wed, 10 Mar 2021 15:26:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770044.outbound.protection.outlook.com [40.107.77.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715606EA48
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 15:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5GuWLyq+lfV8s4GaZKPp1lPUKbnPbSMnri0nTqPMBu7DnvaypbyBdN3hhyNJawe4EPc9lLnkQOwYm+1L1GNY2V80LgmkTefr89lzLNqfIgXbfJVUIZw6A67uN3qSR51iNi5q46ANoAkR4/RG1Mr8NfOpg7mhV133Hmrc8pQZXEfgFuJ3njszh83UC2nRUrQ4Pe54ngOpaJjOksuecDo7QrUH0MYCjpe3E0Cdx1LSVfXcKT/roxsDc+v3QPrQHuhOrVWfkrh12ofnN5fh3qiJZUzCOX97BlYHOpHsh7n239GIbFimeiiSCLvTb0zbrrw0y/KMWHskDijOsDj2EB+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rIvgU+w7W1OVzREP/vwlBFGvBBG0T3Gdu5VoQrd5m4=;
 b=WNCy8IKDYX3SekgQIebEab1i+19dFnPzgkjhP5slvBIRbwrNeoc+XcfJJ/nz/5IR1Kk5oCC1fNyiL2I7nf0v6edNP7iIuW3RdkjsgrqssrocW3fJEH8/Zcvy0sripgHQQoe7RzsEyejUoRY8/UC+ZkmV5kpEGJWEsFzY/K+HJXeFdhaFHuRaiK46a5hNP/eRhMcSoqmBfNgxLym81zy4nODqIIEH70KoBdylX8rkWW6vV9DT9//IOPCiAaZrNMpq1gLwB1tXV2zZQnEEQDo8mSrw6jFFibWe0uOGPRY9OQ4GPr1XXpT6ml9JOcSuVaNrgMSCeIxaDAJgz5M3G9bZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rIvgU+w7W1OVzREP/vwlBFGvBBG0T3Gdu5VoQrd5m4=;
 b=IcEtgOfYQKQiabAxJVdLaw5GngmcbVOvZDlkOq6WGfSLGMmuqXIUHgo+wiSXlv16mIbM0EX69zcqbxmsRSAPeLlTsw32a3lD6FKG2UrFEApzhz4Q7/7xogHFqUV1viVy1dC24nbePaICCMx43LYSPt84BfB4gliJQj8nr0eBq9c=
Received: from BN9PR03CA0759.namprd03.prod.outlook.com (2603:10b6:408:13a::14)
 by DM5PR12MB1210.namprd12.prod.outlook.com (2603:10b6:3:75::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Wed, 10 Mar 2021 15:26:12 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::99) by BN9PR03CA0759.outlook.office365.com
 (2603:10b6:408:13a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 10 Mar 2021 15:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Wed, 10 Mar 2021 15:26:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 09:26:10 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 09:26:10 -0600
Received: from Bumblebee.ht.home (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Wed, 10 Mar 2021 09:26:10 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amd/display: remove duplicate include in
 amdgpu_dm.c"
Date: Wed, 10 Mar 2021 10:26:06 -0500
Message-ID: <20210310152607.33953-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbacd20b-8734-47bd-1ce2-08d8e3d8d5c1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1210:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12109E5498B86BFEE85941DCEB919@DM5PR12MB1210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5bsILItb9rt/Rs2CV7At4hV5Ni2Px9cOo2BHZrgC+9mzkTRHGr/FjMIVFFqJUgpahvTRAEobGtIZJgOLvAmsDGQjE/M0ZS4rd0IMebNNJU8tH6eusKMN75cWDI4Rui/ihBSA6mAXLYR8LRsU933tYVKSMydCW6I6pn8S+EoAt/HjbYBPXfA7fFcirwcviBMshktwu0w0CM4G24DS2AHaKRN98CghesqL7Y3lzHhe0xbZh9ZBKFjpKQ7bQCc7QLTK/Xl6YwVClgUOdP6QqcyBb83tDDyqij4zci9JLauLO452Wsrq9v8poyaRMCfOu4TRfeiQ4qK+cMpDmjR20eKiSbcHz1Nr/To0c+fzfkDzFmd/ge/DZoDK6YjiWWLN+kO07ZXMOsUCbymtk2S/aaiTkKiv5GgxD4DLhIID9sLIU3/tut6k5cVO75VpvdhRxgXv8ujSnze/LXD1FDFP3esM0vbSO+3QgNrxAwZwNPya3LRmstREMrTNgPtcBYBvnZeFczVqtOkJfFrkYHQl7vF3tXQrpmcX7okNH8sig9c+0MZQsbbykWX0gR+jLgX/xvDjTfH8DFYQCZfMykYhU5cxYN+4rtp93foTzIj+17qfvit+ledE8wkmiju3W/prg4GNyDJ7rgFkQS2CtHLffPX9hY1IX6QaT0q9zAOLkEBZE2ieewZHWnLvuF0cItFWEi+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(426003)(70586007)(36756003)(70206006)(47076005)(356005)(2906002)(82310400003)(86362001)(6666004)(478600001)(2616005)(4326008)(8676002)(8936002)(1076003)(5660300002)(4744005)(36860700001)(6916009)(316002)(81166007)(336012)(82740400003)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 15:26:11.1139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbacd20b-8734-47bd-1ce2-08d8e3d8d5c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1210
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
Cc: Anson Jacob <Anson.Jacob@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 92ca4810b82ff3ca7791114c8b7c161f3c58b4de.

The duplicate from #79 should be removes instead.
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2506e85a19b6..b5a75c73ad71 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -45,6 +45,7 @@
 #include "amdgpu_dm.h"
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 #include "amdgpu_dm_hdcp.h"
+#include <drm/drm_hdcp.h>
 #endif
 #include "amdgpu_pm.h"
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

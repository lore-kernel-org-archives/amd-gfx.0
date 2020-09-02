Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A2C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 09:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DC52072A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 09:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="enaePnFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DC52072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B61B6E2C4;
	Wed,  2 Sep 2020 09:33:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC916E2C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 09:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMNqtFJZ/jV/CCBbfJnNRnEwTNhXQyw/9Gj3Q4SrhFqD8SNuUschDPPunjkq8R1WChk2dVJDFmOGL0hO+qWLdLXOOZVO18jpteUSxkRym2YfqO923F/vzQLZk/IUPkumelZvja7JoxqK0I3LLgQ2/se3pJ2A5ORt61+P8m3VGwO91pXVR8ebWIII2hxVuHdhqmU36a09ZqzxOOiS+sQpXBQuSo02kB8CLRmDVOI4mFY07PHVYXqaCduWY9KpRWWPJ/ZY5SUASCFzlTb72bDWY/muKNaobImxMck3JtAm8mXcZkVNbmHoZRtrr5C18ttrn0++0UQ4btIL2GNlPGH5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzyMZUvSRgfqT069Rha9fbzrQF1zP/dOVuTGcGp8LdE=;
 b=jGrU1Lxkk8USDPuQGKapZyL8XdysFlh0HX0h1htTiPeHqev+33tu2aUkELHL/jYg//d/8ABcS7qjdzN2PrUDd5hTKKal6culSEmc2kJkE0ZVf3JynGx5zdOzfPwifcAmwNH28bDtR3Twf1M/nQiQvJ4SSXJrKymk9DTT0VCvEtUWd7OQho/1/MYsYRw69H3+XLlBYQURT7f2Bg6oPy0yS/pt/t3GhObJFQgxaqB7QVNcp67pNEWuDpfAC+s1B0dQzgdKzdEZAFCR6wROi2mKrbPsGsNiXvSINOIC8ADKOck64FDan0wSgwpYacVQfkt8eq4VI+IrpmWWWi4HiHS6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzyMZUvSRgfqT069Rha9fbzrQF1zP/dOVuTGcGp8LdE=;
 b=enaePnFG/HbBOC3UHnp3iTuSWbTdcz1vnfvbmMHhql9Qh++C6XimDrydiQmaIz07fO2t867nyuq/JvCHukssNLqazGHbrFAVtfR+jExnTbiCykYNhLynGvhVmJ3sF9isetCNmcClUMfJk16+jR1ZNlKfJAaSur8VhxMmXGNt+jU=
Received: from DM5PR20CA0012.namprd20.prod.outlook.com (2603:10b6:3:93::22) by
 BY5PR12MB4004.namprd12.prod.outlook.com (2603:10b6:a03:1a8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 09:33:09 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::d7) by DM5PR20CA0012.outlook.office365.com
 (2603:10b6:3:93::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 09:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 09:33:08 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 04:33:07 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 2 Sep 2020 04:33:06 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdkfd: fix a memory leak issue
Date: Wed, 2 Sep 2020 17:32:57 +0800
Message-ID: <20200902093257.18592-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79f1af2b-24be-4e35-1c48-08d84f2333ef
X-MS-TrafficTypeDiagnostic: BY5PR12MB4004:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4004397F2619656DE2D168F9ED2F0@BY5PR12MB4004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYUL4NkVmLcoTr32iC5/9pPIyijLo0tD/UNhvIecHHCikTcDFFF23RD5wQIm3O8kLijT1cIKwip77weHEg5FRR4+GMmR1u3mYMIz6o0+GNph9cLEnel+qL1L+JZv9xjplzt+pMADwlCGNFS0VD5ilyOP7OZo7XGXJq2/GhQEHaaC1kEKizJQqcdtaYq4dq0lQtF4ozS3omlH+M+sytXOADWdhWIgPysadb4QCsFe94S7Zxnhkb+BmXmPeei9ANhcuEPLyyBQFKPc3QHib9kqVFR926qVHTdZimyEQlKA4VS6yzrfkeVwTggsrMyh7shPs+s23qdUQh8KFuswiCCC2OimIZcB+hl5h+i1bBnvfYUlYb0pHZT0z/J/fA6OH86AkyaI5vznt9HbaaIWhjGTphki7g2BFFWLb214ftUqeDg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(336012)(8936002)(26005)(36756003)(4326008)(1076003)(186003)(4744005)(6666004)(6636002)(86362001)(5660300002)(478600001)(70206006)(70586007)(2906002)(82310400003)(8676002)(110136005)(81166007)(426003)(47076004)(7696005)(316002)(82740400003)(356005)(2616005)(83380400001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 09:33:08.5853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f1af2b-24be-4e35-1c48-08d84f2333ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4004
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the resume stage of GPU recovery, start_cpsch will call pm_init
which set pm->allocated as false, cause the next pm_release_ib has
no chance to release ib memory.

Add pm_release_ib in stop_cpsch which will be called in the suspend
stage of GPU recovery.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 069ba4be1e8f..20ef048d6a03 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1192,6 +1192,8 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	dqm->sched_running = false;
 	dqm_unlock(dqm);
 
+	pm_release_ib(&dqm->packets);
+
 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
 	pm_uninit(&dqm->packets, hanging);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3852AC4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 11:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E424023B6C
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 11:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E424023B6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0276EA0A;
	Wed,  9 Dec 2020 11:59:26 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700087.outbound.protection.outlook.com [40.107.70.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C053D6EA0A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 11:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JODcWSqhnizbHktNaGxcpZfnzTxxZSaqdxX0iOkt3qfuOTnQuHtjNJ6UOmf4ENeULtgl25N7Vmj+k57det13Ji92bdFPbTc7DfKgQzPHNTDqpAQt0Yeq/WTsInP5597Ir/pNVBmkpHXPZAKyBHu8Rk0JY+TbfAM3IA3lcopkFC2zMly4T877RV+x9muKWvYXHKsxiWIztTRvIXdtm8ObLajaK2lGubn6hOGqB/uwvKlQpzhZGye/9xMJugAlQbah8phtYozluu7/csX6lwDnmk7ldsk9cLkxEf45XlvjAfVlfxpTfp6HkjA8j4dQ+nxPg+45QRyBOYANBXYKruWkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lrav+vcK1Rpd3ve2+hnTsRF3HeiTBCgYzOo2jfa6lYQ=;
 b=E09FGU4pXZc9H6fWVpCZ+pR4yr9da0lPsopI608kLJeXWmnpV48Cc07dzQpF2+K+5EEOigf1PznitZdX/WliWlyXdmjTGBeAZA3VkzljTy5F513GER0lwNYUEWoyzgXrpwNmzyZgY0qFjQNkBMOI60UrFspJXV53BwL4ohPUgI9FcInqI3UA3FCxxDEU1hiCBrhJPLkXUrNyPR3LWYXQJFTCEVAteJ56KGkuDJV88/DjOOt6iC8sP1pqz40Xr2eeUP6MtHkmCfc8MABYODdhzE6iAqQqwFspZVjje0/0z20scfZggZ+nd0l2XQdcYIWgjTYB4WVFOCJPhZQF01sW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lrav+vcK1Rpd3ve2+hnTsRF3HeiTBCgYzOo2jfa6lYQ=;
 b=16MZzEsJ1mZVPE6IXapRSYf2a1nzCyh10f01RPi4hl3TdPVKbT287Qcn8OYjjwTdcgnuqxYQ8WSrE5uJbwbcpjdYbC/Sv/009kYM5E7W2rBT0yETpswoHca09Vi2FsYdeUov4j6TGcirBKDYLWmuP2wHSY55udStYO6CwsL5NLE=
Received: from DM5PR15CA0031.namprd15.prod.outlook.com (2603:10b6:4:4b::17) by
 CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.14; Wed, 9 Dec 2020 11:59:22 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::1) by DM5PR15CA0031.outlook.office365.com
 (2603:10b6:4:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 11:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Wed, 9 Dec 2020 11:59:21 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 05:59:21 -0600
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 9 Dec 2020 05:59:19 -0600
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: correct pipe offset calculation
Date: Wed, 9 Dec 2020 19:59:11 +0800
Message-ID: <20201209115911.30391-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3668d6ee-2dbb-4713-11c5-08d89c39ddb6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4245:
X-Microsoft-Antispam-PRVS: <CH2PR12MB424511535AC27CB33650CC96EACC0@CH2PR12MB4245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: es1gvzLlgvfQstHGB2TBpOe8x1sKFGONWkkvf8HKGribYxHsc2Z1xH5lpYzDc1BGrs9dckmLIw2wqRAytEBYOdwFA5N2hSYcel+OON0i0IEi+3RoUqV0/RScHAQ9cXJXfXGN/xk24eJAUHRll9nQb91HP045PslwwOfXfhBs4BkiBK6Mtu5uGu56goLeoUBDqw5yegEOcqhmSMYEhjE5SUEOUZ/1AhtrARbraaY4Wc5h3O4UoeLmsH3PoPvF4L34FfN3okd1t+Ac9t6ZJbdJBmhaEueyiFdxb3OpHUSVPIGC6etywo+dooigLnx5wJYo0mkGg+tAkefuIP5zIL/h7OeNlVcoxiBosc//B2Uz64f71cE8PCUvWyF1kKnEh8+CbBdHxQ4B+TSwa+W0t7ZyMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(46966005)(70206006)(7696005)(70586007)(4326008)(6916009)(26005)(508600001)(6666004)(47076004)(2616005)(2906002)(186003)(8936002)(1076003)(86362001)(82310400003)(54906003)(5660300002)(36756003)(426003)(336012)(83380400001)(81166007)(8676002)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 11:59:21.8751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3668d6ee-2dbb-4713-11c5-08d89c39ddb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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
Cc: Felix.Kuehling@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct pipe offset calculation in is_pipe_enabled function,
it should be done in queues.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I826aa532ca1e5073e3329212a8096f8f5a0be057
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c579615451ba..c37e9c4b1fb4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -72,8 +72,8 @@ enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
 static bool is_pipe_enabled(struct device_queue_manager *dqm, int mec, int pipe)
 {
 	int i;
-	int pipe_offset = mec * dqm->dev->shared_resources.num_pipe_per_mec
-		+ pipe * dqm->dev->shared_resources.num_queue_per_pipe;
+	int pipe_offset = (mec * dqm->dev->shared_resources.num_pipe_per_mec
+		+ pipe) * dqm->dev->shared_resources.num_queue_per_pipe;
 
 	/* queue is available for KFD usage if bit is 1 */
 	for (i = 0; i <  dqm->dev->shared_resources.num_queue_per_pipe; ++i)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

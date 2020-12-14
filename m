Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D179C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 09:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1969C224B1
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 09:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1969C224B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF8589C8F;
	Mon, 14 Dec 2020 09:52:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE68089C8F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 09:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYi+W2wpLycnyR9FT0ZnI26f5iidYXoiCj2KShcuzbKrLMovYt440NYthKlGRQqx7yiDCAcnHeS9/bCPEAe4k3kJo64Ut2B3LhZZqmpWjyvlkii1PMHh21/SxiAdzTmVLk17kJx5IS/SShhsFjpbNJM0OsIWEj2X+FKT+X6RI06nvKthv81O+M2ulgu6okzCsXB7uYhglIShnWSdAx10wjA9g+ODw53wY9YvK0N3RaNVoHtJhdmWIe9PbObtYpq83OjASGjck0E/q0zwrXRSBOQ7GNfnapB3YL3Dxan+LLt2y2g54EjTUaKAAUPKTzY+ivoVYenIP8GE7I1dZwOfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0pxf70Lx7I1f/fH8Wf3VWA4ab7TumBdUniQYYEo/yo=;
 b=O1Hz4MY2IYS03ux+RfNyrnHKFpxqfaMI81rqni+Y9Xh2J9iyy7ou6OUJTFaxtBkmM+TsgjXyGNHfLz9vs4ioXQm6nT4JALKScWY6SLL5UEmP7zjSkJOpDKgEIaZ6gt8o9J+dmmxs6hbgiIBU3mr1plelVFbirPCmr9JklMev3tKmlf5nuOEN9FvemGb2akFV8k4icQjg1ABgfqDkkYmFRNgSnkWmzv6ObX8+maZqW33OhYQGqeGEMk23NGWz29UwWicucIWDM3Dpl8ejKlbXbXdcqYMIbcdnHYAWtLldrn/9R5/eHybrCof5Guxg1HKE5S6hEhI8ZIDgs1Yru1iO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0pxf70Lx7I1f/fH8Wf3VWA4ab7TumBdUniQYYEo/yo=;
 b=UTB1C2NZ4VDIf8tuoG6rq80HAiqEZkW6qpxDrbdkg33xBNIh4YhyROhqTOkymZQd5Vwdv9r/n+GE93p6V6PcTXSwm0Z3cVT2Jt5ZC6qBOUEn+3TZB6n0XNaDEseqXrGda1WUjBeJH+qE+KtukeRGyG1w2TpDBnqAhFbMou2ZZOI=
Received: from DM5PR20CA0048.namprd20.prod.outlook.com (2603:10b6:3:13d::34)
 by MWHPR12MB1613.namprd12.prod.outlook.com (2603:10b6:301:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Mon, 14 Dec
 2020 09:52:07 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::ce) by DM5PR20CA0048.outlook.office365.com
 (2603:10b6:3:13d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Mon, 14 Dec 2020 09:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Mon, 14 Dec 2020 09:52:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 14 Dec
 2020 03:52:05 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 14 Dec
 2020 03:52:05 -0600
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 14 Dec 2020 03:52:04 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: correct amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu
 log.
Date: Mon, 14 Dec 2020 17:52:02 +0800
Message-ID: <20201214095202.2436484-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 527b6331-b92b-423d-47f6-08d8a015eacc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1613:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1613F95D3545EDC680A2CE4BC1C70@MWHPR12MB1613.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvKiL44bLXn/wLqv1OtZBEfTQuwA4n5AiGtJ60BSx9F5boedwNM8Prepq3wPFhGZSf4KV7eU0KJDbMCulcr881g7g2n78jbW6wqn35tUdKn8MlJ03KNE+20uh8yJe9NBZ/1kOF543Ii8EKn4JnqAyuIcaaCihSivi4TbqMEkMOCZuHZy+S7D+OoKR6xerzTMi3NAMe7Qdbl1A0+hSGGlAP4+hhBlDBG9Ezh0FkD+6Sp5RJdCGoGnQwcr03TFcdstb+z96tSayJvuE3Mf0YBvsR4joFp+iqh+VBXyovujUfIMqpl/t5NZdmTdlcztttamOi2KCV2BvJ75ONAl/ObIns7M5yS8i4RofWXRFRKva93aW+bOeqJ9tcR2JqcQXZB48FKIXWeMesEtuEyUNfTa4hb1qsY6JNBPgO21kkOGVEM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(46966005)(2616005)(8936002)(336012)(47076004)(7696005)(26005)(82310400003)(186003)(54906003)(5660300002)(86362001)(83380400001)(1076003)(4326008)(6916009)(8676002)(4744005)(356005)(426003)(70586007)(70206006)(2906002)(36756003)(508600001)(81166007)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 09:52:06.5869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527b6331-b92b-423d-47f6-08d8a015eacc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1613
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

it could also be insufficient vram that makes
amdgpu_amdkfd_reserve_mem_limit fail.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e54883ff74d2..99ad4e1d0896 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1213,7 +1213,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, alloc_domain, !!sg);
 	if (ret) {
-		pr_debug("Insufficient system memory\n");
+		pr_debug("Insufficient memory\n");
 		goto err_reserve_limit;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

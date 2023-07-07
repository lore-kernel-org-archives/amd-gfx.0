Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC174EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 17:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6E810E5CF;
	Fri,  7 Jul 2023 17:47:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF6810E5CF
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 17:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEBr58vbG7KU/hKzzWyNxzwaIhh7zMMGWhjPbpwNZi2y4yZeqOtxbv0IQDRaYHj5THyO0J7vfagWRyVc/B3CMDY04XlrvJHnU/Y5vqlo1yahNmf76FK08xsfn1qatZVzmUsX9AAyFPt4mPKgv72dW/l8w7GyhxkXUqSkHSzVYiGXk3yUNd7LXMN0CZKa+KajnPaFdcF1J5Mw7wCvPqUnIbe2mBjRbF7yrtlv4SgTHD0ra9CzGoUm/ohbxNcMsvCwBTELoxCUhkotbAeG+66wPM0OCg+d9jFPjd3hJ+nzt8dUwmawP7FtxALTxQYzkYdpJQphG5AfVgGcGUKYhmU+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pBNat+0zlhUKw/QxAvP87mq56G5XKLwP5cOrCqOgm4=;
 b=M1eJdVbkQcpy+9/BxJQOYedi9pKoUjxuPb4SqdV6dl5fHcmXo5QjZm5dVK67zeuNhq0e9Tk32Fs1G4kJJGivdGgFfey7mAjbnPgHseiZnT8cd4cilSyPrWEdaPRWtvfq1yjCm2Cmjd7vsF1z1FJwV8MAP4K5wI89vgfMxQuSFu+LFQAG1BzV/MmbG/YktXZ0uWAglidyu1PzAIrz50C/jC4eISmJqrrlAkjyeJlPdkb4IwRJ9JSjvuH7GDR0BZ/V4E/7SfcQdcEGsqa0Ze9WkcbQ7hFnQ59LHSukV5y7XQx6xJoxZeye+zmzGbOuPOY9dMro2B6visctTWzfJr1cSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pBNat+0zlhUKw/QxAvP87mq56G5XKLwP5cOrCqOgm4=;
 b=fIjvKQXGqKeJjKI4QOECKadxPZsiYWj97lYioLGKNwmuiCSmhap8cPCtJdeQsniY7R3hdEMV/IBB0Y5rB4p8aMZI5M2TiGXeTzs1pvaux/0VwNAYlF56KkZ/Pm3tFVHs7b0OWV4TMsjjFPhWNRw7QPQriFFJ+XZkUG95ADwGEjk=
Received: from MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30) by
 MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 17:47:11 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::22) by MW2PR16CA0017.outlook.office365.com
 (2603:10b6:907::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 17:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 17:47:10 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Jul 2023 12:47:07 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdkfd: add multi-process debugging support for GC
 v9.4.3
Date: Fri, 7 Jul 2023 13:46:48 -0400
Message-ID: <20230707174648.146441-5-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707174648.146441-1-jinhuieric.huang@amd.com>
References: <20230707174648.146441-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|MN2PR12MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 85189d80-c552-48ce-bf1b-08db7f1230fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eLQxnYMVYSX725plHhi0hFiqg19zGpub/36ooI9eQ5VaTq2HJ54E5/MJ0NXiohJViBThpY3+J66lxejX2Oo23TnhfP2zs4Y4BFs2e20AuVKUp395O6ZdlPwRjkY3vCIradA1wEM21z/mJf/Nn5H3KrVTcIoB3t75t4mhiB0supOENbvMgkhfHG4zUABHqpL/bu/lO7p+oK0gX311FdHbfd1zQO5vVoLx0tKRVKqRI+0J8d3ncqcYr12jJewnPPRb66SV86tQx0+d+QLYLqEGls250NklG+mxUc9Muiu3pdjD8o0hEKPQ1ex74CbA7as7dZQ5KOumZixn4+yn048vhyMTwocE9rQW0Zb6v83+7K4Tf5GSzvc+QsE0EP/0DuR4EycUll2Xcf+ym73s5sxQIRuCOJjmkcg7T2/B281QVWGr1A1YeDHDvjYzmo8t9jyVVOfCeC+xMDvtWOq64kkde5j1GvHlNPLGbQ5zkma8DRZ12onCM52CVJ1LOoP5q1MYgHP8SrO9PurY2Uu8rGYa4ua2ID+otsUx2tRKM1e/6T8wk0iQiehcKeYcQs/T3fK86DcTGEo4VYZvykQRbbEF5PZiaVtyJTmdnFEuxgX0d7514DvT7iZvmgE/zKhL1QfeYlWtR0IqsVJigPRCHoC1XftCmRWf3lTAGLa9vmqYHaGpgpEqacx0CwpWNXcNn5UBsVKN0a9lf2yVjqcDMtXr0yJkzpYacWZ6dLkUKPGjSo6JDQsHto/mdjvV75b2uWy+cXk19AFKaUm1/mKgHmfmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(7696005)(6666004)(478600001)(70586007)(54906003)(1076003)(26005)(186003)(16526019)(70206006)(336012)(2906002)(82310400005)(41300700001)(316002)(4326008)(6916009)(5660300002)(8676002)(8936002)(81166007)(356005)(82740400003)(36756003)(47076005)(36860700001)(2616005)(83380400001)(426003)(40460700003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:47:10.9635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85189d80-c552-48ce-bf1b-08db7f1230fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Felix
 Kuehling <felix.kuehling@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Similar to GC v9.4.2, GC v9.4.3 should use the 5-Dword extended
MAP_PROCESS packet to support multi-process debugging.  Update the
mutli-process debug support list so that the KFD updates the runlist
on debug mode setting and that it allocates enough GTT memory during
KFD device initialization.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index a289e59ceb79..a0afc6a7b6c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -76,8 +76,9 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 
 static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_node *dev)
 {
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
-	       KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0);
+	return (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	        KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+	        KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0));
 }
 
 void debug_event_write_work_handler(struct work_struct *work);
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F25C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 18:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE0589EB7;
	Tue, 25 Jan 2022 18:04:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E44289E9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 18:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeaZEc78d0rpyzAyq78TZZpb9fVpQoYELDRYEzdZ1MJlv5nvIIIdnFq6jacEMVtOH3F5AiCkyaQ/B9dk8HqpmxsgpRWhSrow4sSUBuFwtqA2BqW3d7AU0TtRx8Wz9Cpk5kIs1Y9xELcBh+IR/RbcHpYfKcxT3NMNEGB6KaNrTHgoFLpRo2H5ax+bBRdkTC93KVPNGpndYUkP0MZhZzbpUJKEHsTgBR1pdCs1nI+jSn1ZpTNbWi21wifgZuY93zV3euCWy/fUUw30tqLsRLUKiR3N7Ts4jnoqmTxru+PufjglkjuCxBAf8/hl+//qZzfqQ636p7ABiVZYJZ9SBwxZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtoTXSVGBo9U7ec2BE0Cb3OZkT+6zkjoc9OT3AQpVKs=;
 b=CBsvHAQtlMdizu5S2XG524xLQrCaQ37C4xvnBRq+hHdObEoupRIoPQeVD72KZqavYzDhBCFEb8eu4X3L25/Yhmvem+4Vd7b78QUFzy5o8xD7j8JrfBDI91yDZS3m7GunnJ6AquZL8wXGo5gVwdz80ranZC1vhsilsvBXnV3TSlhbGMs1QJRWjc67e9RPmx9ulqcQZ93/8zzqBTRWi2wZMkPL5T6jBiA7iGh7mvheFObmqwmTYpwrSGn0fP99FQq0Yj9sB6YsCw5LVr7vxdN/qwfq5VTYAQqiJD+LO0La/tk8q6Zi5IgB26g4cKHh3abOa8X+whshSMHF0qnEghO27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtoTXSVGBo9U7ec2BE0Cb3OZkT+6zkjoc9OT3AQpVKs=;
 b=w+ppzWviY8wcvGkww1QyY6Ri2lQajBUWRNAH7z+2pUeuc8l0upIPtsUQln+17mhZJp//yeWNFHCfMP2kNio4MzMiiNRlh3tXNViiTDNGKjZmhnmOrZs14jnBXT8dp56Mrpg1FF5gsY5yRGtkLmcYlaaXgCgA7JQ75iWbg/8HYjQ=
Received: from SJ0PR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:332::28)
 by BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 18:04:41 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:332:cafe::50) by SJ0PR05CA0083.outlook.office365.com
 (2603:10b6:a03:332::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.6 via Frontend
 Transport; Tue, 25 Jan 2022 18:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 18:04:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 12:04:38 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Don't take process mutex for svm ioctls
Date: Tue, 25 Jan 2022 13:04:20 -0500
Message-ID: <20220125180420.3022-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4efc901e-ba2b-4880-1a48-08d9e02d287b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4872:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4872248C3C77FF13FD1AEF90E65F9@BY5PR12MB4872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0g640m5I5jO7JBv05eO/NccAXxaOVmZ8R7IZtihsRCAQtNUT7BnGXyCmJZslpdEwqxDKyMrDbPI+pHPh3VfTARV1zdu4dtaRnwtGmzPX8AaB9jyoFoD5nuip+HxVey1Wq9B8G4rVubyHnkIgMmAV7kXhUaay2lltb5xS3rwADl989VgrA/sQ7N3/uK9NGkYCsqWyNbfuiFQzeYXjW89BEc4tPaTjcRSyBWn2VqSJRjl1ccfaZgCfv9Gku0b6yYQGnQXYIxPt5G3dnxvphLFe0fBxpHzYLVt/G/nAQOTgeGUML26H7SuPM+3kQi6m0ICSpo+y7mG2lAh0M2l7jgoGQD5aoxphLIbRKUOAaj6SPqKS8WD+Na3TrHrgTyXXqCO9aQ2RLzH3WagNF4pDmEMqxlepMiHtjkmPeMn3GnZwEEOrqSC7VKMUidTGUhmJcfTtK0EYczKQvIY52TBxJWFacfr3n54OyP9+T4poECCnKJyNgt8HSJ8/Ls7RHgXcjMNIG8rr/ZJl8SARLo84VuDdd4jIu3uWeHW55UfnMFlNBrbib6Zdm0CNcJHcWtNCVNskQ49YrqoJ6dalIvIQPhWWqTed+nll/6+6lljVAT0VZ4HOKVytQ40Z2fbA6192tagB9QS1zPLV3CzrrS4O2BYTA55LIQWydRknc3s/AjE7+XCb8NtOE5KV4y+futzcnteCsZRcYwV0JgKyCHQX6VoTfxliB+HaFQsy7jDIOmLxsHaqIB6+Ba5rASEJHzf8ot+XLH4Irv2FI8QBe+g7v/+H5lpn+y8HGlBZHog72IoqzKs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(36860700001)(5660300002)(2616005)(8936002)(426003)(316002)(336012)(186003)(16526019)(83380400001)(86362001)(26005)(2906002)(1076003)(82310400004)(6916009)(70586007)(54906003)(6666004)(4326008)(508600001)(40460700003)(7696005)(356005)(47076005)(70206006)(81166007)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 18:04:40.5379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efc901e-ba2b-4880-1a48-08d9e02d287b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SVM ioctls take proper svms->lock to handle race conditions, don't need
take process mutex to serialize ioctls. This also fixes circular locking
warning:

WARNING: possible circular locking dependency detected

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&svms->deferred_list_work));
                                lock(&process->mutex);
                     lock((work_completion)(&svms->deferred_list_work));
   lock(&process->mutex);

   *** DEADLOCK ***

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 337953af7c2f..70122978bdd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1846,13 +1846,9 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	if (!args->start_addr || !args->size)
 		return -EINVAL;
 
-	mutex_lock(&p->mutex);
-
 	r = svm_ioctl(p, args->op, args->start_addr, args->size, args->nattr,
 		      args->attrs);
 
-	mutex_unlock(&p->mutex);
-
 	return r;
 }
 #else
-- 
2.17.1


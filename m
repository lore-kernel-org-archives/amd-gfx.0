Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1BEC04A6A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 06:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB5A10E65A;
	Fri, 11 Aug 2023 06:04:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08BB210E659
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkyc2gvDbIJcf+UMjIx15G0SmHt3FOcg+i+ZWAxgnWK55/gCDTHswSxC10m5C4hj175XPIU/Ec2eXrmPisVkKn5D+ORFLrMT7ZeWn+FFf71MxoqGWfiAuyh7hdK96HoRz1TaA3QC3t5h85XGKfQkp+bU5ycmnGGpMBBByDvi8raQQmT+Jyc2O6fjjEThffp0HBVOY+vwsQyBMq68GnsgegQn7RnOpdQkWE2Yk0d8c9LrmV6BMchrYdCc/3K6oJf7IabmXgT4o7SzhATdLa26iR/5d6yRHSajzKCQL7G9nN1c3Z85fR1hE0XVticvzHiqIBh0BiUkAXGrjlr86ifyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQBRe8p6Kocg4+pKE26EPn/kB+r+CUKmqJbIHIH+AwE=;
 b=Ifoh62EwtvutLyNk7BSKWAuLSLEzyjTo8glMvh30aSE4txgbzPCSFlOovGQXd/tktiFsTMlBk084OnXM/e2VzAFyNPkwRDLK0W1zFAXcMhYlVXZuPYftbnDPVkY9sOowp7KlEltmX0vpeUcqm8cYJpWvd2CUbtDLlxxdy6pEQkz2wMihgisN40UHiWTJubLWiFct1sBbq+yLZFfyh0d9EWu0j8skAFMbRPAC9w3RN5Pb4r7ws4CuyV3gBxH42RawE/sONmcnfhnaeCdC/sq+u4H6ZUgV11vvItxPZbUO2J0sPnzTmlbD1PFgGyVZ/wda4Wn7NdibCPN9GMqVjSaixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQBRe8p6Kocg4+pKE26EPn/kB+r+CUKmqJbIHIH+AwE=;
 b=v6j1forBOyXzxlbHDR0hBaSOgCrJ2qL9OAwsK9OxMBZHyZTvOVe2FXUlDGME7oLlnrPm8/x1m1kKTKFDO0xp5Y5XrnA4toRH15xqwl636P7/QscJOFUzh0+5e/xZ38+WWnOxXi4D0lE+p7hur5dGSI8cjTNZazoBhFAtnmQkMm4=
Received: from SJ0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:a03:2c2::21)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Fri, 11 Aug
 2023 06:04:07 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::f0) by SJ0PR13CA0046.outlook.office365.com
 (2603:10b6:a03:2c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8 via Frontend
 Transport; Fri, 11 Aug 2023 06:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 06:03:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 01:03:34 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: Set flags to cancel all pending resets
Date: Fri, 11 Aug 2023 11:32:32 +0530
Message-ID: <20230811060234.663789-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811060234.663789-1-lijo.lazar@amd.com>
References: <20230811060234.663789-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: aec429ed-38c1-4f73-913f-08db9a30c5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Qp6t5NEnibY3ukiJVzSKLJiHchZOp9+KmQsFO0AAa+PAM+XYxWTPqKDTZs4XrQJyvPUvV/39jb4ED5aiNvdvGnvY9TBLa2TtfnzYIx4H0RDrPH0SgfGufNyOn2RiUF2IC7P6sUTpEPEonrdraemtjZGTkFxko16USB+1UI/kPnQOWiK3rhYtfRqO7SsdTBURE6g0huQ5KGqn4BxoasmsrSGbcUjLZrdjlYgzyxbSdZBQ5eeeEddldk0B57vQ+guTg4S3kmgvt7Rs40IIM2r74PRH1ZLnrnzib/BZwxfKvUrVMcW8MBo61PlAXpsTJmb146p4yzjpaRtR15P65HwhnvAEvenuTrQCE7xI5/EsYdeNprO4afHqPe27Eir+O6wHngwN3O9/KyUQE8vBlqDVU4B9tY98NhghjHEXz57TL99SYVYb2yz2XV/OirqcDCguMG/pKCUgDR8Pa1J4UCnZjDZL6glIvOyuEHJ6Z7pnw8Zl9ALqdKAeB6Zwh3+2uGy3h/Bj7jC52IYhET9twZUhLgbt16zyVTLsNMxcGIv8RFoHR0eVE7YzFSM+Lz3NKqoWlyoWRB6PY2VO0whIxyaFAa5X7VVU7FiqZxzit1Hoa3x3DcPQVTCkutj9vd/E+nU9qTc4rYyKRJbOTU/o6X/ASFMRKAyaEdIPES42AqRHz5wDOu3aNxqAjNj9eFj9X7QV1k+kPTQXxb3w97ERXS/19HSBut1hsWpFBhkJZvkqCYrJ+y3YsXaQ4x43KHJwRK2oEinGkUXl8NTCRQYoDVcJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(1800799006)(186006)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(478600001)(36756003)(4326008)(6916009)(70206006)(70586007)(2906002)(44832011)(8676002)(5660300002)(8936002)(40460700003)(41300700001)(81166007)(16526019)(316002)(40480700001)(36860700001)(86362001)(54906003)(7696005)(356005)(82740400003)(26005)(2616005)(426003)(47076005)(1076003)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 06:03:46.3984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec429ed-38c1-4f73-913f-08db9a30c5dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If reset is already done as part of recovery, set flags to cancel all
pending work items in the reset domain. Also, drop unused functions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 6 ------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3e56ccb742bb..4aee867ec59f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5150,11 +5150,6 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 	return 0;
 }
 
-static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
-{
-
-}
-
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
@@ -5320,7 +5315,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 * Drop all pending non scheduler resets. Scheduler resets
 		 * were already dropped during drm_sched_stop
 		 */
-		amdgpu_device_stop_pending_resets(tmp_adev);
+		set_bit(AMDGPU_RESET_CANCEL_ALL, &reset_context->flags);
 	}
 
 	/* Actual ASIC resets if needed.*/
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index d1393050d3ad..73d1f78d2b0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -139,12 +139,6 @@ static inline void amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
 		kref_put(&domain->refcount, amdgpu_reset_destroy_reset_domain);
 }
 
-static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *domain,
-						struct work_struct *work)
-{
-	return queue_work(domain->wq, work);
-}
-
 void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
-- 
2.25.1


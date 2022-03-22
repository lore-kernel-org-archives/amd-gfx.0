Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35EEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 04:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA5910E503;
	Tue, 22 Mar 2022 04:06:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3523910E503
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 04:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7CESk5BBcVuJrAbQ567FrfyDbLVko49KRcsLFNWl4JFoaOdy4qghAXVK3isqWmRfovHuFdZDWwVa9Xce7hkdlEnaoEoMGQMkdlACohdg3ObcYEP1lMxZutWmFB2d2iXp9kJ2cqAxv6bFXRqOhMFf0Hu/J/566GPG09OWBqG4vquScNRmuwmT3q+MYm1UGbZoCkmCt+nirkEMIKdukXI8mb51D/IiWrnaETc8RfZWx8rXazPSY86XXe/h5/WNZ5ONhDwkOATcwyp8K42wVvUXKE7jF2SFKMD3eomLnFBDd5bbFx56+9Gokf0Q2XQxf19OQ2qhv5VeLqdJkSqj3J5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3xWSdf/bRjLIE0l+v7hMqBq+10tf9TII5e7t1D+usQ=;
 b=as+GsfSEwMZ9k536GXBKSIwHOeztYsPjy1LwCLxGv1+EQ/ZQD0FSFugjD8wGyVM+dOzxHEjz0gypCgW75g3YbYOAX3xdmbgPVneu4IVB8zC3oom0z9//S+kCAbCJee7VXg5cI8OErjvBEygtwKqE+RlJxg2uKGCAbN1dA+4HJTc9/OaB0rm1aEx85DRtMLBHA1EEbjZvLBqWUIuf4W60OUqqJQnvLxpFNcAyEKyyECuJyP9WQ8Ry35U4bhNV4UPTpSjoSkUnm9gY44bkI5UPLt1r2ASPy4CdQ9rX4j4PgaqGuksGsy8dRsQL+hnz1u9NcuEbUHB9lsbyY/TX61Lkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3xWSdf/bRjLIE0l+v7hMqBq+10tf9TII5e7t1D+usQ=;
 b=KmxGzuDhIkKAz0270AZlJuWn1+s6ybrBMZjRnshbMCJtGVrMKzTxPfDLEADg9WUPbj9VZTzp8/Ew9h9f9QiWtEd9P6LyaH9fxjis4xJrhTRvMhg42HBWgBOBGyIXtAPygAUzu+Gi+QWr+OdSiI+bjaJM64QQmlpdub9URJeMekw=
Received: from CO2PR18CA0058.namprd18.prod.outlook.com (2603:10b6:104:2::26)
 by SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 04:06:44 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::97) by CO2PR18CA0058.outlook.office365.com
 (2603:10b6:104:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Tue, 22 Mar 2022 04:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 04:06:42 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 21 Mar
 2022 23:06:39 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Felix.Kuehling@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>,
 <Lijo.Lazar@amd.com>, <pmenzel@molgen.mpg.de>
Subject: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v3)
Date: Tue, 22 Mar 2022 12:06:27 +0800
Message-ID: <20220322040627.5728-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 037dfd39-c3ee-4d2b-e4b9-08da0bb95f93
X-MS-TrafficTypeDiagnostic: SN6PR12MB4720:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB47208055A0A948E69A1C2DA3B0179@SN6PR12MB4720.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSlW/TQrQT90yKscFHW/gjnR3c9ScNWTBPS776/MaqByCI5z5avtaDwiZDu+HXqlbQCXvnfBp7mROpz7XZRCPVJvXSB4/DzXTiVWDfYJ1HQLcO7x6YHGq415H4ofvIlIS/UZpPMJ9DTYlHeFmyFnqY/fW228az1l2YSO/nkENRIE6taJA69R2uWXzgymOzuZ4RaTsHquXpzHcJYPS5WHSeT/WFbPgg1F9pXEWXpGWB/5+4m7fuGHgEA6CbyuTb4vDUl8MGh6+rKViuHSSJg8ONa+Wk4fquOxfNXcEw59pb/mCT2akKRIqH3/2HLz5SSKOQpo7VRaE/UlCMO2+FWRtmZfsbqkDHSSdJAXZEUXlUxxHHFfm3czAb8g0M4VsjDhxz1m/unjbJiu7u7MZHNCuly8PsfJ5/WF0V/47TRWXBCWfiNv/MmOLRwMW32F2yuhJkFEhreIyhRyHLZOS0bc1pA5IuZYOtnyFqaJnjja41jILiZ4Q8Sab1HCwTEtqT5/v3Q2SAhQxz4OqC6ojkF7sRmYK5cqPu2gPnuiUqn7j18996bfZwhAibR5rPeFxe+EvWQz9PRJx7d85jE+R7Eq4kp6fMtc34d3zUvWm1zpJ+uWoOx/6z655lvD3bgSN4Swng+BCRn0cuuDunjpg1eRueoqbkooshiY8ULkc734LWt3ts+30w0cJgyHFSRDnJ1F/cnGGobsnof33g3STDornw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(356005)(4326008)(6666004)(70206006)(70586007)(508600001)(8676002)(336012)(426003)(1076003)(26005)(83380400001)(16526019)(186003)(81166007)(36756003)(2906002)(82310400004)(316002)(8936002)(5660300002)(7696005)(86362001)(47076005)(40460700003)(110136005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 04:06:42.4854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 037dfd39-c3ee-4d2b-e4b9-08da0bb95f93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4720
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print the status out when it passes, and also tell user gpu reset
is triggered when we fall back to legacy way.

v2: make the message more explicit.
v3: change succeeds to succeeded.
    replace pr_warn with dev_warn.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 56902b5bb7b6..03c29bdd89a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -105,8 +105,6 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	if (old_poison)
 		return;
 
-	pr_warn("RAS poison consumption handling: client id %d\n", client_id);
-
 	switch (client_id) {
 	case SOC15_IH_CLIENTID_SE0SH:
 	case SOC15_IH_CLIENTID_SE1SH:
@@ -130,10 +128,17 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution
 	 */
-	if (!ret)
+	if (!ret) {
+		dev_warn(dev->adev->dev,
+			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
+			client_id);
 		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
-	else
+	} else {
+		dev_warn(dev->adev->dev,
+			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
+			client_id);
 		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+	}
 }
 
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
-- 
2.35.1


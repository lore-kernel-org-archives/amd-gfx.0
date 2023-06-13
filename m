Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248BEEB64D8
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 21:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AA910E087;
	Tue, 13 Jun 2023 21:48:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0132010E3E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 21:48:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpRGkpka0uYHfF/+AP5kn9k/rC0aHcyGEcwOLAF5g2n+cA+1k7p7BHHARXO0msOXiJlmGH+RDgZ/B4fbL/71yRpA94WKPK3ooPHUNGA6nlLxh6HbXHVlQDgLrObb9BR+E0usTSmSOUz94KKv2MEyu8afRamRduhUHOG/2LX03V8cHiw5voNfcM514kzTiI8QVI1HM0dMTyh7Ig/PIA2trVsePP7Mx7J8X06NpWKG55kfwR+1Y9bcpztzpsIo/AcxjN2s9APPhPe/30slAzgcHDm7IaOFcIqxqfuQ6dKINieM7MD/sKOccocpUzqfzTJpvbm0NXdg9NiN1SfoVFV3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq8HGGwklPRLWHiNkAjJzKIP8Ak9VKHurWiWzXiKf/4=;
 b=lAVNQq2S6hjja5LIPH5egKLqKcKutpbR8uzEqyHAPIvrRmXyB1S6qBcBsvN8wswhCTopPqKrV9S1xILVZhfc5e6oq9Q+HybCrpIC/MPPtIE8Erxnnyh2f1MLdsKx9AzNvCiZr2RNOKrzrD5UL0IPyoMiztLl9DVlfBAkZvhXMh49fIkcMAyQOtt+iejjpb0GgVxxZxI2Eo5jZ0MOPdbDmPWTFh/yUjhDZ7hcQmjDL1MmlNEiclet4FKDrsuegBGM9Iq9HwP/bkNu+FK+g1Oz/CWxp0uMlDVCjph73GBxEPmoFY7zoiFoWCHlMEmBw2GJopyuRNGdXCMg+ewXU6W2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq8HGGwklPRLWHiNkAjJzKIP8Ak9VKHurWiWzXiKf/4=;
 b=3dUjbrdw/qsD1GEF/9IkFrF8RweK5f7KdKsVmDNCsTh2fPrRFm/JdLGtCblRPet3vNf+b/O3K+NVZ/LAkSsQ6r3vBvIP7CsQSonJF9FPS1urqV7RdWeZgFFukf5R/OaKrNYjkT1tCRAFCWDoyUFxIjuXukLtWoasJKMwBswyJ8M=
Received: from PH8PR07CA0028.namprd07.prod.outlook.com (2603:10b6:510:2cf::23)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 21:48:53 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::db) by PH8PR07CA0028.outlook.office365.com
 (2603:10b6:510:2cf::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 21:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 21:48:52 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 16:48:52 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: decrement queue count on mes queue destroy
Date: Tue, 13 Jun 2023 17:48:37 -0400
Message-ID: <20230613214837.3452334-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d57e38-0da2-417e-9d43-08db6c57fac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVQeeFoFdAEiYLz5X5hUJqn296B1rDxzLERM2DGTkfY9EJ0sv6Xuqc03XOdzgPozAwO7WiyLrA3TzRRfSK86N7/3YprssdHzk63AVQwtuGiYRdp1UGX5oeX7IkMUA/MY/ILJikTVjtcWDRvrRS0OkKLkfkOqVMrTrEvu19tEU27XUynaVR2YlDSSWkvC4+VBnTZ1eMCGh0b4IlQsGR2hgtSWqoogd0Edznx2KhNiGegbqJJkJqXDgiERX0Bg3QVz+NO9Vk5S18eE4pUC/l0jxQtxQQoUvzsEHyVoKhQshhb9yocCNJJAwgLr2ZkPgFEGBHcsI0VDI7eHLADC/rH7GI4upTVhk3RgiOUPvZKGQhlgFVmo9EQ0PdLEmuY1grwke3Vq98KSrBt4PON5/tI6/rDbAmvuioENViGY1Z/ry15nt1SEuaZr/DzBxuARAPRPhY3W76bhi09Ib/a7ue2W9JZRF6IAlKj1EQxRdhYvWkHPoWx9rr3356SfWOxQSWTQoeNKb95FTZSMTYq03pgQqRpO6Ik2wjC5kL7c9QEmhnDONQRSXUzMN8RbhsRCsvcBgS6kx0dIY9eAGyHcxIN+XOrkpswr5QuW0ydfvuP+VZbfW6HyoMXm5PBXCcxMQ1BweXWBjOWyOiPq1Lx10JXjrFGqGOFH0PEWv8OFpbUk/kdBvLwfVzczOK8SUlwxOIKAh7khh5vrSBl/fJC/trRyrTBB1Z8+69BXMy63lBs5nUaK6dwZ2GAyvx3m3HuE3aptZLEn9v/0+55ssjXf/j5m3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(2616005)(316002)(40460700003)(7696005)(336012)(41300700001)(86362001)(83380400001)(82310400005)(4744005)(36860700001)(47076005)(186003)(26005)(1076003)(16526019)(2906002)(82740400003)(81166007)(356005)(40480700001)(44832011)(426003)(5660300002)(8676002)(8936002)(6916009)(70586007)(70206006)(54906003)(36756003)(6666004)(478600001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:48:52.7641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d57e38-0da2-417e-9d43-08db6c57fac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Queue count should decrement on queue destruction regardless of HWS
support type.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 8a39a9e0ed5a..f515cb8f30ca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2089,8 +2089,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	list_del(&q->list);
 	qpd->queue_count--;
 	if (q->properties.is_active) {
+		decrement_queue_count(dqm, qpd, q);
 		if (!dqm->dev->kfd->shared_resources.enable_mes) {
-			decrement_queue_count(dqm, qpd, q);
 			retval = execute_queues_cpsch(dqm,
 						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
 						      USE_DEFAULT_GRACE_PERIOD);
-- 
2.25.1


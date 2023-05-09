Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0625AC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9AE910E430;
	Tue,  9 May 2023 22:22:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 485F510E430
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR7VPrqkefHnHlHRAd3zLRoc8VANTgll3hqFyPkOLm5DSAVBzfko+sQ1lokRoOmHpx3tIaaEy78lykNQrTjYZGyXo6de92tBXNoeaqpTXbZbxyxN2uP7+1ZUuXjFUn6FLTa6TfoY5+VCrBwOy8QJa42FO+3Z4hCglJKPJmOOp5mRBVMnMpZ/Vqh/94aI9jL9g+3krjOvTHMsv+M1MdSmcQPOvzGdLKUuAUvtpeYFUm1jYHdI+RW+6UwUYJzXosS93z8/mIlda2vuJ4TqPwZ95vdkgDlymsr4leFK6G2E1J/VLvyiA3Qe1EWV4SY2Glqb36z3QhlLzOP02Kv2M9K2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1HeBvaDKLmhB1tXiGXxiEWkjpImzAgcUuPnxYLLXes=;
 b=QpdAl5jM76+/dwj3CGrTtzH57VkUgfSX8I80PTHZtHK4dpi/V29EckIhS5qXRB9d8NANDilNjtEoHO3Anz/piH05GzvwSl2oEFbN7YLPcZLPr7s0eGJub3VY8gXKIMdv4ottFp4cVyCUwcqgfR5okIXxqZDkNEDKYUvNoBEkOP+3nbkIK/tgWoRGcAxxTAwkJkmHhMYAi+NO43p8AJnxsXXYvxuFY7aYn3HeN3ZyRXFt51lNP8Wb31gp0vWUEuybAKAtk4nQGRIlFBUKJPkCG6LDi1+rCPFYnOfdOpJx493CYEQRAv5eeNd1i4c/LGimwU1o6ezownAzXUBu+ey8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1HeBvaDKLmhB1tXiGXxiEWkjpImzAgcUuPnxYLLXes=;
 b=tbXhegBcsNKChSohxaBmAK9b8bYuQYAu9jVoOzmflMXVxUFgvpB/I1MlI+9C0KBqJxf1gEHiom2o8MCrZRtf5d4zTIaFaiysZhIw02Kr3wYl2e258AxlbU/Un5aYSbixgE0zC5JJKd9sxPScFEJ7bcJoxc3B4tVaXldAVc3gzmc=
Received: from BN0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:408:ea::26)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:22:51 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::c4) by BN0PR04CA0081.outlook.office365.com
 (2603:10b6:408:ea::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:22:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:22:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdkfd: Increase queue number per process to 255 on
 GFX9.4.3
Date: Tue, 9 May 2023 18:22:32 -0400
Message-ID: <20230509222237.478097-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|BL1PR12MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 9636cd8b-44cc-4334-d560-08db50dbed31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AUl+i9rkBJDR0TeBWkw0IzecDtDE+5bIMWKhVt2DqdU9GhdQ88qxO0O9JMi27vnQgPgSPc1xDwQfKqZOhnOtRqDDAHe9w2rZoEE4d28zY9nc/8wGZ4V3eIRP5C1R1bU8EQxY3JTF+drbh+Vfo3E0DOKnO48yeM7ogx6T8y5+5vLZSO4xw96/nmdGwUDz2ZSdY2AAoRz+jjvdvlLhQ7SajFWjuOXlyMmmytV8KY1IEz/DkCEl1ycWsn7qzxGfTbmctIGdVp4Hc+uogQWKRhWqjEBleGJqvZmBzkXDrlwxWuHM+bXZ5mET0bfEwFDUl0FBpNlxrMpH7P4ToEH36vkBGK8wzNBqTw98bgx9ZsEZL4Ksg4G0quxM7bQIwYH+WnxKNy49iNr+P1LQFe8hXsc065UU8U9sfNHTLX3ucxZLoPIuacWYO8XquG0gih2bzeR9UG3R7rgoGwZvE8m+XLUsIAjZGC+nFHuLUc5Vl4JLaw/zRkMwWGkGsHqfhuJNz+zpdJs5BxDD7qGvlD5mqvLQefu5Q88LtiN2lMNW/oZ3vQTsYRaMvtMRPhsJGibNyYJF2nxUZ2mKeVtuSQzA9L5uglKBWf2XxmtdU7IT0Pz2MwLZlK1Jvwbc6u8HlpGIKF1tE/nGbYTYh45EomZEml2FPszcjlfynkB1z0fziPK0/DxFYPXpwv59HczT534FuuoDCCqfRA4IZguyl6Y5oBnvv1px/qgR0hu+APD6iDN4JMJTXB+6peLrAQbzA2BJoe6ydivmWdaPOVrzy/TT9zZJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(6916009)(4326008)(70206006)(70586007)(478600001)(54906003)(5660300002)(2906002)(8676002)(8936002)(316002)(336012)(426003)(86362001)(41300700001)(40480700001)(7696005)(356005)(82740400003)(16526019)(26005)(1076003)(36756003)(82310400005)(186003)(36860700001)(81166007)(83380400001)(47076005)(2616005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:22:51.0114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9636cd8b-44cc-4334-d560-08db50dbed31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Increase the maximum number of queues that can be created per process
to 255 on GFX 9.4.3. There is no HWS limitation restricting the number
queues that can be created.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a3c23d07c7df..b100933340d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -242,6 +242,13 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	enum kfd_queue_type type = properties->type;
 	unsigned int max_queues = 127; /* HWS limit */
 
+	/*
+	 * On GFX 9.4.3, increase the number of queues that
+	 * can be created to 255. No HWS limit on GFX 9.4.3.
+	 */
+	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3))
+		max_queues = 255;
+
 	q = NULL;
 	kq = NULL;
 
-- 
2.40.1


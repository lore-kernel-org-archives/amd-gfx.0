Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF43C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 06:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F46610E648;
	Fri, 28 Jul 2023 06:01:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6E210E648
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 06:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQDmL7tm3OPNNfnRAbvNjvj0xNX8FOukENU3pLB7ccQpJgQJh/uEIfz65AGMOmXCxS6k/W8ymGYnFcXywefY8J2ra7BjqPV1SnJSS31UB5Q9G4T/ul40cgZeMZ5Z+ggL3sOdKWXuxkKsr89eAGci3lUaMae2c3CkcB62vLJR+QwU4bP/6DtOUwZ/nlf6XWH4edwqWWXZ92GHtQsVlqxQ7N2akLW14wggejldT181WmjjjM7kzxt7/YpQdSPSRU5T69T9fLN+bH/6PbdQ9n4+POtBKV4qF1sVzym4BAZ2fxT9QzeUcAmYdxOM/0qhLjwGKXwj6EbLMwuFAS+USnhctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxSPCbR7BZyT7+1tBOWlNZHhAAf9Uolwbg9hkEfHmU4=;
 b=FqyuD2f3+WDMQJnp3kVfH8L61ivrAosLqYAaGejPdJ4HYiRA+he3vbgDm04gT5JY3xi0RlraZq4r/0AVMW+7N7htktmYXVODQmE0vjEJUeu2hw0eRNXv+QaQ65U+o2kg8Poa30yzhHAMtF79n/DEYj8Qyz2D0zAVmk3aU7gRx9BVscE0G2oNmJ28YSbyylSHmneumkvsyEgOk+uN6QSTlUnkSF9GCl7fFRbZP8+050HCdIWBVzfYovdmhGXyCR1k2QXc8yIV9Z1aUhDt12hK+lmuGZwEmtrloIaY0nvO9G+alWdG1TyffKDtATsoLjNxtJ4bEJJdBW+1mVrrvjta9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxSPCbR7BZyT7+1tBOWlNZHhAAf9Uolwbg9hkEfHmU4=;
 b=V7OJiapVVIqzr/YxHQ2z+pRK82CQQC4xwxBnur6dUUIPLmpudDp88XQ5j/elWlyqhhDyX1+ACWrU4oxmTH/46XRhehIwra+7y6rjv8susqqkPD+D4cDPSkGzzj8eBu5feWCW9pbOhzvuXTy5r5QZaQewLys5tyg76SQeIaLhF0E=
Received: from CY8PR12CA0015.namprd12.prod.outlook.com (2603:10b6:930:4e::15)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:01:51 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::99) by CY8PR12CA0015.outlook.office365.com
 (2603:10b6:930:4e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 06:01:50 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 01:01:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdpgu: Fix printk() should include KERN_<LEVEL> in
 'amdgpu_atpx_verify_interface'
Date: Fri, 28 Jul 2023 11:31:29 +0530
Message-ID: <20230728060129.2691502-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9ac7dc-dabd-46cc-499e-08db8f3022ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekktNSjX/cKFuZrB3PT0xVf7nRDZwxY5p1Wrr/h30QX+1sCZtiGOAhQf71R9Gc9/R0M3WWgyttKkKpn87C2WVFOP+HXZ0L+ky/qnLYieeyF11RSd6TAt841jEuDlJY26Ii3Ptl1XLIWq3gacV7ulzblyTlfVk8vOxuMMoV9OEw0l2t+wdShyQFNG/2Lu2CQWmb+UlW+3frtBkyLKaZ2K4oWOjKUilLgKuV7zeDqz2C0n7McLDwlQbs+4IeDOeTzwd+TsezCmiI1bmYSdJOFic2oHDwh6cF62Bb6Acs3dpz2pVDyY2zRBeckhj1zDwAITE8MXkqLnc5VW1xhn70S6x6M9f6egF+T0iWHqgvaLyaKanP5A6OHVyMQKBAv0PridtoyW5qGUHoRFH59Y7lU0PErAXRIEXiho1SO12EWolIBXJi2v4kYh5UrMx2szBVEKOT0gThjIxwk+5AY2+NwjuthFGc/7lAyXt3FVUFCSxhr+zwuxD/Ko9N8zssrYo5lHxRjghYfhCNersCBa07WFtl/M++pBNzh+Kb4dzGCfiHAvowk4Z+8IyxJvJ1OFgfRWm1+qJNAVTyxGJKgxHeSFDxlmnKSRX1J5WsuCYp0UcGGmrlSRuoyeI1Wjmen2SyCR+VUrtcfRut9prJlQ3WM4GdzyFz89hitq80rfq180YrJCs6tkXZzsI4x981Chw6G+5MLszZQbTki5/P1WYPMc79N2fYvJzmbWwjOlKXcoLhUQPSkCOtyLWG88CSiB3QOxV8InZxo5seWd27FiYKKsFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(316002)(2906002)(8936002)(8676002)(5660300002)(40460700003)(44832011)(41300700001)(36756003)(86362001)(40480700001)(336012)(7696005)(6666004)(426003)(81166007)(356005)(82740400003)(478600001)(66574015)(26005)(1076003)(16526019)(186003)(110136005)(54906003)(2616005)(70206006)(36860700001)(83380400001)(70586007)(47076005)(6636002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:01:50.9272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9ac7dc-dabd-46cc-499e-08db8f3022ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prefer dev_err over printk variant so that we get better debug info when
there are multiple GPUs in the system.

Fixes the below:

WARNING: printk() should include KERN_<LEVEL> facility level
+               printk("ATPX buffer is too small: %zu\n", size)

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 6f241c574665..dccebe6aaad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -280,7 +280,7 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
 
 	size = *(u16 *) info->buffer.pointer;
 	if (size < 8) {
-		printk("ATPX buffer is too small: %zu\n", size);
+		dev_err(dev, "ATPX buffer is too small: %zu\n", size);
 		err = -EINVAL;
 		goto out;
 	}
-- 
2.25.1


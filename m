Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12489C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 05:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9526C64E27
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 05:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9526C64E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1E46E2DC;
	Mon,  8 Feb 2021 05:46:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3349E6E2DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 05:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNHHBZRVwlhs1Tqcm9F5Rbo9m5gYL2RpBVdODOGBrGpJh2wDao0ggHa3g/aEikdunkV+km9AahCU50zgx0C+zar4TPIqR6kufbUyYBB53snZeXqLzXNIN4PZWPmqgF5I0H85ogWH+THrwLph0HbmpkcCz2/2nxwwtQCzUfE10cAj5/PZdbdH6AxCD1Nn6igrDNxkcD5wntfpDfSJIFAQH2tOt8gUgmUOvzSHpFV+kZZmOpFoQQzjZ45ioWK7A7uY4MagvnA7YboM5fmSHIBsdl3wjVRwODgLHoYmtoRwOuYT/ncv6y/yP3RwpSP8zbtDf3ljY1Z8roMW8xWtK0H8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQxrd5LnIobMC4x8qvXpBg4dX/NW25iL8+WJPlEAw/I=;
 b=CbALDAT5BRzwKvOOjDEOw4vx5pqRFHvZyn7ULaQqtE61fspv5mxmIm0J9NeAH+CQPgt/nxHGFsbteqdhaufIOL+hWdS/Avu/ZuV1OqrmP2AcNpdCOlCmEM1jBTnF2cLZIXOyClCFAOLnJeSOE1pIXLr/4xHE6WO6I00zkS0/PQKTRyqMs9MXA9cTlwP0vFQ/CnNNyVwNUJufab0rfvRZkxJ0VqYGGN8zL8OexFfK7uYxw/6BwPpJbj8IxzI0qiJw8aMVEZlTkyMFZWF+gRZbrdC377W4S5tPAktEEgmC0CWiXff6oaN18OEHm4Ugda6eUjBRFvB7QQ9gTRYBw2PotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQxrd5LnIobMC4x8qvXpBg4dX/NW25iL8+WJPlEAw/I=;
 b=OAu360FM6qBWwbJ7b/+Tea178fjDrmhV/vkWi+inXG5VDxEkXOVKkf/pFKmfsv68y2BYYWYVu4G/ZTN9QdWI/CSxhetZ6PkMEjeSF9m8Cnpu4mQoS0W0ISioys+lPJkzErORvTdKzf6iHNQ8QXBN69qx9utZbGAEbxqaBZQ/gkI=
Received: from BN9PR03CA0225.namprd03.prod.outlook.com (2603:10b6:408:f8::20)
 by DM5PR1201MB2473.namprd12.prod.outlook.com (2603:10b6:3:e2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 05:46:30 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::1f) by BN9PR03CA0225.outlook.office365.com
 (2603:10b6:408:f8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Mon, 8 Feb 2021 05:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Mon, 8 Feb 2021 05:46:28 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 7 Feb 2021
 23:46:28 -0600
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 7 Feb 2021 23:46:27 -0600
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: extend MAX_KIQ_REG_TRY to 1000
Date: Mon, 8 Feb 2021 13:45:55 +0800
Message-ID: <20210208054555.23421-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec8ad9ac-a260-4d5b-087e-08d8cbf4e19a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2473:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2473231E1AB143CFEAC5F505F88F9@DM5PR1201MB2473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfOn/4kkgtw0wpqR1zZtKCQ/7GRkWYi57DE/14oAle9GEu5E5S9jn3O1k3MtHb/WOBf1faVyJfPnqQUyIA41BH0AAOw5LVdxzsyOvxhxqUeLcnMwWOmGSDOFEzu+0Fdl4d4dSp5FiEXcn/Vy4MzqtbZdQQy4M3mjr1C/IfKli57k84ljbHTjywxn1D5gGsZrBQ/HcXG2CTPzbW+6L42H6ldU/flDhmcwtSmNddCJFHhWggaCXObKg32eYXAzp6TzGicaYUrRBM69UDGKFl3TCPwvIzZhuA4twlDzI4lpXCCmIklT8OENU5OucLhxBqfhY6lxInDU8zbBrEPX91DbYFp+dKQt6+MIXoZsonX4AitP2OYFrMiPKzj9vTcFTbASfFwq+9nZF9Lula7od8Rv3AFcMLr3aZOrUtx/r9yBPuhnbRX2MEU4P1sgHbATiy8LhDlrid8vu9ArRroQvIF62ga1N5a1iq6MLAfmQDOdxkqkQNEeDwUh8afImGQ+EGnOj6sEWxjl3xtEgxshjEXQfpiKvaIoCSZ1dB0chynP7Vc4roATzBii6XCj4mpnGNVJy+H1lFl7bb3oPVlYuU/QwKsSJtM5K/LGbHk6KfSTeUHxW5nMl5yFzrHxUtghkv+CfXbRwwSs/eldBEJnBJRAjlljQ9gz+0WRvPlyUHJ23nbULWVp88EuUmaGSLqSPAnj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(36840700001)(46966006)(316002)(2906002)(26005)(4744005)(426003)(186003)(54906003)(1076003)(36860700001)(8676002)(36756003)(6916009)(47076005)(336012)(478600001)(356005)(8936002)(7696005)(6666004)(82740400003)(82310400003)(70206006)(83380400001)(4326008)(70586007)(5660300002)(81166007)(86362001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 05:46:28.9912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8ad9ac-a260-4d5b-087e-08d8cbf4e19a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2473
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
Cc: emily.deng@amd.com, Jiawei Gu <Jiawei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend retry times of KIQ to avoid starvation situation caused by
long time full access of GPU by other VFs.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 639db32c1383..e0c797a5f739 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -288,7 +288,7 @@ enum amdgpu_kiq_irq {
 
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
-#define MAX_KIQ_REG_TRY 80 /* 20 -> 80 */
+#define MAX_KIQ_REG_TRY 1000
 
 int amdgpu_device_ip_set_clockgating_state(void *dev,
 					   enum amd_ip_block_type block_type,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

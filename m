Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB22C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 07:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E1C10E375;
	Mon,  7 Feb 2022 07:28:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E9010EF33
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 07:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8gkEneIhI0rWYDft5hiER9mEO7P7Dg3nqmLikyUQYtqPqL8+wRnembZtydPTh71m82oKIi9DXvaTYnqzsKXV1ebnAUOTTXiRwU/cMTclfoZR9xoxD+WiepXJCMlluI7TLXoChr51nKEHfxWeWV//6PIVS86bLi8qry0poY17R6q4POp5QNrN9r041ZiVWa78XRrj4n9pKOlBQX/FrTJDHPGWHFY3xMJdXBeoqkpYVXXLZWBx3+2nB2XaGdfWu78P52zoPdczXLfW3+F2nS3p1H5y6O1McGbcPrt/ZyClfvNB+N1iva8BEOSEnsuRNvSXhE+OhoADN4mcNlHe6wygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPoOCPiE4MnNCfPRQzY15Tp3PElCPzzeswy16OiLJeI=;
 b=BBupdiEYhoEkG2siMjxQTgPBFq9RFEP7/8cDtOzA/JtYmUk2YTOLIQzDa5weik4H2HsNYvd9BRmL4+IvErSvm/WpFhq5Qw2qqyKH89Y2eZtPpyIosayvmuceJ3BW4qyYf0ccPZUhx9kdAB94+qEIs/G2BKyGtyw788xeWu8NxyrjJvYOUhybTrTBWsFfvgfuu6vrS0iiAZv97ikx1ms1SGGGGnYum+4MIruCk2hzq2fNRHGhPZHSAynVM3TGKq8n5suW/+SrhOfHWB/I6fys2/QAglXddtUxcUCFJLuF3FeWw5tC/XU50Sp6qtHxcXzP0iYXUQ7eKgObJX2vlSrIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPoOCPiE4MnNCfPRQzY15Tp3PElCPzzeswy16OiLJeI=;
 b=QeEYnWrPU9vx7LE+oMfyihgq8YUV9kc45iGtmCjgKBZkA+QQjwesxPw4YkiG19eK4Jzv2uGc2p3mhJIiMqlkROgY5tjp4G8vrXtVMzrmA+FGRmvV3Vk42aGSddKu3F3AIpK+KlfK1zSUlXBLu0Fu8dGXpHpfIkCCF4+/vYeWm0Y=
Received: from MW2PR2101CA0021.namprd21.prod.outlook.com (2603:10b6:302:1::34)
 by CY4PR12MB1816.namprd12.prod.outlook.com (2603:10b6:903:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 07:28:01 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::18) by MW2PR2101CA0021.outlook.office365.com
 (2603:10b6:302:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.4 via Frontend
 Transport; Mon, 7 Feb 2022 07:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 07:28:01 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 01:27:58 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <hawking.zhang@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>,
 <john.clements@amd.com>, <Jay.Cornwall@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: use unmap all queues for poison consumption
Date: Mon, 7 Feb 2022 15:27:42 +0800
Message-ID: <20220207072742.5476-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220207072742.5476-1-tao.zhou1@amd.com>
References: <20220207072742.5476-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f72dabb-360f-4f22-583d-08d9ea0b5f74
X-MS-TrafficTypeDiagnostic: CY4PR12MB1816:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB18168DEC2FAEE09EFF883DCFB02C9@CY4PR12MB1816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4ARUm8NCwo5+LyahVPfmhjlHpkffIOxXbs9bUmoWHEY0jWwX3rwdJ5rdzAuhUTaOMTpCQF4WpRJvJ7oJqZ+wtAyxQ+qN8LgKOIcBrPa1vx4VOlzPzDtC5Fv//JNnxeRCl5xukopJqwhnNW+JxPah2QUbD2KfNBCnpaUFMob51Ts+eSppz/emn4DZv28aMFHKHbIUSO3eJTsLCIgJq7G4uc9U+agJBLPbgMy/Z4sMiR9nS31E1AIM7SdtzlGNEf3XpcjOqbe/lhz8JWcQcJuukf0Ycy4T52WulPT3fWWk/YZAaVvZyM9oTz2o5j2q4S/fZfkEjImhKuU4FXr8jSPIpzXBBaWAOFlARgKd+dilN6T8jwTogi71xeniBmaGE60Ienigx9uwRdLmSdrsoTy5fWnKBMwZuVWGhoBJrKX7JEZ3Ay3nLho4rRZUktSHGTXiU9sMzgI0vJ48cQi2hiBmY0TY67MOo6oSGubyImjLF+jhudRL5uhQHkZCneBcsJsTtYjyHWibtRIpTXABCbBT+qu43MZ/pTBnJS1nig0wf1MgW4sBJFVJ8RBxOEHcaO4L6v734bRUtUHSgX0uaySQPop85tHz7tLTK3ZCMZQ9LVV6pn1DOF6dHPZ8JWKT21RdURj8r3Gf9EvoMXVVsQVWpMYRdxLVhilrgGgZU/zEmuUKx5yOui1+rFTFPNrbR22vG/Wa3WHKOknKmDnlaBhQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(4326008)(8676002)(8936002)(70206006)(82310400004)(316002)(86362001)(70586007)(2906002)(6636002)(110136005)(47076005)(2616005)(7696005)(36756003)(40460700003)(6666004)(81166007)(508600001)(356005)(26005)(83380400001)(16526019)(4744005)(1076003)(186003)(5660300002)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 07:28:01.4917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f72dabb-360f-4f22-583d-08d9ea0b5f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1816
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

Replace reset queue for specific PASID with unmap all queues, reset
queue could break CP scheduler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 7a2b6342a8f2..68ee923a440b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -109,8 +109,7 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 
 	switch (source_id) {
 	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
-		if (dev->dqm->ops.reset_queues)
-			ret = dev->dqm->ops.reset_queues(dev->dqm, pasid);
+		kfd_dqm_evict_pasid(dev->dqm, pasid);
 		break;
 	case SOC15_INTSRC_SDMA_ECC:
 	default:
-- 
2.17.1


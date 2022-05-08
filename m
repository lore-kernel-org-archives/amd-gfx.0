Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F1C433EF
	for <amd-gfx@archiver.kernel.org>; Sun,  8 May 2022 18:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BDA510F2BA;
	Sun,  8 May 2022 18:00:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AFA10F2BA
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 May 2022 18:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkS3TYxSiwWS/mO5BCtar6l1xbSM9/CbPYyexFb+SAobH474a+is8Bs+rAQ8j0zjK4vtE1b4sGpi6i6lV+jWLW+Tp/R8n7Q7QowhNWUC+EHoUWx7t7ilhD8+Fjw/HmZpwm9h0L0dSlEeTEYkpWlqCkjqTUZDii/kIyqzpflQZ9HHZ2/eP8K/n1CfwkYDexvFHEryHM0LmCXZUF5c9mCbT0Rc8LDYncuhEvzY3Sh4iISgPAsLPnsVr7AF2+OxCeoiJjfRuy+B64ZwOW4MyjYTgo+mwtJXUHrLh4oG1t8P92XCrFpDlP0n+Jt/hjBIZFnQVPiNzEAe/g+4qoZtB+lQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzBJPLoZTIC5LN0GjGsw0Z24Dr4xe8AUMr5vR79lG4Y=;
 b=JbMzS8EnO9jPB3Ay7sSLs3jgpghdUn8NGFfkiBsxIiN/i0wXuCWzx9BExxwcymQL7kWlsEa0/ypvjiSRErGr6L4UKZRW/Xuezf1wEejo2Efrhp9JZ0mTDQCFIjARGOWv6OeK52QqtwMpbIc23BS77ZVHwsqXOiYhDe8qWUmA8EPJKgHRkejZ/aM1dBTZE9t9IYKEd/X9NKm1vkzeFQ3aMjpqJmV9eTaa9XQZ2Ym/Vt/ik/le/CPvzNCgST7VoQL10uCkzv0p8k+8v3NO7gePH1ZsCI+2c40p2+uO4+mqFlWXl34GMfuYy+kIqjJSPOBfjzfG9R+qmVozbDosXVQxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzBJPLoZTIC5LN0GjGsw0Z24Dr4xe8AUMr5vR79lG4Y=;
 b=UObPyMjigKi/BaULPr7AFWF1nfacHvkuRtp38HxgyTEbCDN8Di2NN9H7EGLpajtI/nLgcCRAgjEn1fEHRJaQHZu2RkSoICxGzxJSQcuQZXcttSULM2rdLfl54B1Z+917mtP1eHTjuQGTaiXehBdYnT0mIko8y/uJgVTFZdvXYQc=
Received: from BN0PR04CA0174.namprd04.prod.outlook.com (2603:10b6:408:eb::29)
 by CY4PR12MB1318.namprd12.prod.outlook.com (2603:10b6:903:38::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Sun, 8 May
 2022 18:00:26 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::34) by BN0PR04CA0174.outlook.office365.com
 (2603:10b6:408:eb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Sun, 8 May 2022 18:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Sun, 8 May 2022 18:00:26 +0000
Received: from jz-tester.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 8 May
 2022 13:00:25 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: fixed no previous prototype warning.
Date: Sun, 8 May 2022 14:00:14 -0400
Message-ID: <20220508180014.313767-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508173008.281673-1-James.Zhu@amd.com>
References: <20220508173008.281673-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39de0734-0642-49a2-da9c-08da311ca181
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13188408085FD14BB3D3ED31E4C79@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4oSFQOG8zxJ/yLd4V5npAguf9gECIbD+nkLugUZdLiB4adiq/ADdFI0DdjPsfWIjBtuQCdNl9+sbdAOTujjoVNmrmem8QERew5OKV38cBZM3xNz+jLeqhyFpSskLvSk5dVL+Z+z5z2/ReJ588FeQlyAb9hJVmcSLI7iEDtG/dGdUL4EexV30DT9QQAk+izC7Fpln/Gm3ghedOOlm+mdYUhrH+TxGBHMyAk14sbiLei7yy5k2OxaBrpSedimmKZwqKrc3thchLK/xj6N1c708/1rPdwriWO1dJ2qJVkK3xGZ5kHcREGBDzx7DU92dnGtPnYmyiErDbKOrQ/iIWIzNtBINM36mpOZTavCWmU/LOfOBoSAyOvcOeKAg+tYlxYY0YIb/1D5CCFpPa+iz7S5HQ8JrwdO3/JjtyiJi288Jq6N+UlJwqINK+AgoOw3Ar3S8XlbDy2tSLXotrFaMNiw42mKjRwcjK5yyS9eZe7BJygCa+nHc41PJhu8M2dmvMYptN1i6r0RL3EZJsz9sOAXzd2TZ/iPpCmg04uQHhb3CPtqfpYkEvcBd7eWF3Laqs1MVvW99QvHwgPg8Hndov3iKYZ78T+5qHALJiZuXWUxwh3oMlATLhhWL3BUmr4npWERZcPrWT8gJ6/29EGIMXXlQsWzgPCQeLiwJwNvVzwiJ907gvZkMCBQ1MY9Vm+snhrl65jlU/nAtSAXTlZfEUjUa6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(86362001)(82310400005)(5660300002)(8936002)(36860700001)(426003)(47076005)(316002)(336012)(2616005)(16526019)(186003)(1076003)(2906002)(36756003)(356005)(83380400001)(26005)(70206006)(7696005)(8676002)(4326008)(40460700003)(81166007)(6666004)(70586007)(6916009)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 18:00:26.4208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39de0734-0642-49a2-da9c-08da311ca181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixed warning: no previous prototype for 'vcn_dec_sw_ring_emit_fence'

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
index f4f97f0f5c64..1ceda3d0cd5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "vcn_sw_ring.h"
 
 void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	u64 seq, uint32_t flags)
-- 
2.25.1


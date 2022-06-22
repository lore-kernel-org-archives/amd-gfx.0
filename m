Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16C1C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 14:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418C4112421;
	Wed, 22 Jun 2022 14:25:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A3FB1121D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 14:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN/d9+ieh0CqjYS8o97GzzixBO6W/6cuNrEY8/fq6208W81nhtF8mYYX82WqZ3Obynlib4CB6B4B8zou8s2orSsQFEp17teDJUKoCDvidDKbMLrHDLNFPWbCFtcSEtdFfMRVXak6VHcgYtBZX+oTdwxaphamTEqoeCCjQbtefzHG9PhuiSWynGxnbWzWIN31FTG6Ja7EB1HYEFXr0JFN8Gzjxpnoi9LGA3TLNimn9P5u4QLQshpLbPbat3RzOROnZLRRNyLNdQ53hFrUMSL80wL+uHKWdRWSuqNT9hDWX9enFcHyb09PuBtLJCbO9P7IGIzDL7I61Hf/RtCnh5OIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lWm3/PT//8DwoBcTqQAQ+HCc1uTl1YhuQnqKuogq5Y=;
 b=SlAzir8aXGfvvF1m4qHbV2V04Jyik7f4MP+F5Ra893Ui6tQLh0ZBagXewX8rLIaQViKPX74S5GZG259q1khPkguqqIg6dDiK2wjO5ZCYeo2kCE0zBeCIo21kEdLBqi9cGivUWjx0aSP8A2vG/bYR6yi1hAKkNsYa8b+kZ5LLt3Px0vncG7vLdmtljbiOWALN0YcmNJIFIr1q6IaBOAPA0HOzV388YURiAwqhZixoT/TPoKNOwUGX6nCqGG9zF8cs+cNe6ETjomqgVFbcmYU2iTU71J+MYvR+vTWMISqVV7vJS2re4ww85hxzJFP/0miEJE5I5HD8Gnx1poe5ODO7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lWm3/PT//8DwoBcTqQAQ+HCc1uTl1YhuQnqKuogq5Y=;
 b=hMyzkOhSSMITAO++K/6smTkVcvjftTBz134tgTW6PsH7F5o2wQAbL3EUmD19yxXCQfBhxwVSMgeMay80TJWdeQSPs2mGYgbOOYSYZkzc4FIo2gAqJtpjklraaBi+5vB9n3V9GCSZUtZy4n1lNyqz1bGZ/BMN00Gi6OEo8Yq/K4Q=
Received: from BN9PR03CA0122.namprd03.prod.outlook.com (2603:10b6:408:fe::7)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 14:25:56 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::fd) by BN9PR03CA0122.outlook.office365.com
 (2603:10b6:408:fe::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Wed, 22 Jun 2022 14:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 14:25:55 +0000
Received: from ruijing-ubuntu-pc.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 22 Jun 2022 09:25:54 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: fix no previous prototype warning
Date: Wed, 22 Jun 2022 10:25:38 -0400
Message-ID: <20220622142538.27843-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62559bb5-e330-4be7-cb81-08da545b1e83
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB546087A536AF1B065D25ADBE95B29@CO6PR12MB5460.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CN+0SJnxqnZRhACpVmZ+J3tFtrEpPceWI49dR9saZx9+r3gAAbnnGouFPaV9r7DViVBuUi6kIyCejwjAxF5VbajZBEWvm42rUY1FaU2EfHQ30XQ9/akwI1Oj6Wc0ShV5A+bUK8B/u7c/D/+cSlYHcdcsSK1QH6rHUR1iv8cd+pqJoy3bSWa9PeyG86on7WZl+O1vGkHtPpQIiVTTxgMWaslVxWCR9USlqHs8Y40aO/xSD+zRMAzHp0b9y4O1xitlJFzsnfysAMLKiwVNX1Bp0CeAvQzOVcgiDAbhYtAU6wzwP0mF+zjvHKycPqTFLGFcbh4KNXApyeMrm3ew9A5qGHN0uNLp5Jlhi3nK532Ifc/P6py7APpJTeJUdbMhBVsX5Amd7Q8ZpmwMjAaK1EU2BDAgsz8HGN6IpQyd8IuDrLprUFK/YomMjLcAuLjC+e/PVBUwGFZ2tXsY0ikFpeuo25ADjmHDE0HyBT80FD7uLOuy7b6WCjPfkjPg0KkFcZA+g+apA2py+GlpJxTXXOQYcPvf5yUWgI4TOi664K6rjHEx4onJvw+r5RzyI7fUk/y3Bm12S8Qwtms065GMiiNXfuwVqkhFkP7T+/09l5yfF6l2hUw75jPrJBnw0Ba1T2BmLeT1KOmCqaAQVCsE3otj2mrEgTzlEqpjiA86RkbJU9h/Aud1Cdmf2rOVOTJAdDpI2Y9kfaYEGy1Kou7BycHPg73yEEVihusfH9piAiWKKnvXE1XuIwL7VLPE0Usj1OfHvyGpK3mr59uDTPMeO72wRygYNc+eTL1AAGSZio1wQ2k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(46966006)(40470700004)(82740400003)(4326008)(6666004)(6916009)(478600001)(82310400005)(83380400001)(70206006)(70586007)(8676002)(81166007)(186003)(16526019)(36860700001)(316002)(86362001)(356005)(5660300002)(426003)(54906003)(40460700003)(7696005)(2616005)(336012)(36756003)(8936002)(2906002)(26005)(1076003)(41300700001)(47076005)(44832011)(4744005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 14:25:55.6432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62559bb5-e330-4be7-cb81-08da545b1e83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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
Cc: alexander.deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Declare 'static', as the function is not indended to be used
outside of this translation unit.

Fixes: 748483dbc215 ("drm/amdgpu/vcn: add unified queue ib test")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index fea436023351..1bfdfb9207ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -330,7 +330,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 }
 
 /* from vcn4 and above, only unified queue is used */
-bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
+static bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	bool ret = false;
-- 
2.25.1


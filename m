Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B594C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB155AA4A9;
	Fri,  3 Dec 2021 22:59:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107C1AA4C8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCwLvu6TTZy44X4brlGdJ7w4XtRPBmnVOlxkiceQOS+YW3Puf9x1YgaZmeS6e51BAVmo+WceA4BK9dOi9ZebIsZB/jy5o6Mu1Zod42OK9i41L0hSrwEQKDmk96jzvszdbMLsSrP0Chz20BLk93+tNI2FSfCZvWmfd+uXheCWItAkS3B7BiF5BOtEjukwTw4l0J7EM4xYvi8c28lZtzCZq+ffyapJ+xLiozXPlxKHJUKmmj0azSrmwOZuCiDaunVV+6HyyN2nsiQcCAQDfESuVPJK+0oF8cYDNWVfvkaruUr8r49Kg7dZmBflgEEcM6C35e+1oReljgItMZ3fgdqVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/eff6/1WyJdWR4HocbOWZXBe0XgVoT/0d9ZXO6XK00=;
 b=CMPeVgCv1McEoOuxv1PdC/Ya7AhM1uS+sHyS/CYZ85QfVySRx91MBTvj0N+S92pppcAG/eLPSub8M/U75n2CHa0GbrVmM1cs9q2mQs3aV/zoU4Bb5SRcKTXOKu2NvDzwfjFtGXxqI0zXpEXsiDhfpyufAdMuF/VJiIgOkkPRCrwA/817+3Co+rp1nTRnof/T1m11AuGQGOs08p0kZSjrPSp+lzhCKDgAImrynjascHXoLl/4j+geqWBkay3h0OQOroP7DzUFezQSKeDZTP9JIDfIa1vSpR3p89ZxWqMXkDLM3FC7hTzSbvc8pxbmK9ZmkuqBeiuPVVRr4PJyoHCnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/eff6/1WyJdWR4HocbOWZXBe0XgVoT/0d9ZXO6XK00=;
 b=T+9lTKPtMJ/+aIARHJGmK+d0CIzkd11eKNsA5kuV+5lmSn4WhMyAknmMW+QlFdT4+I+Ra7IZsUVEtTOEx/9eF+qjlZAY1USYvwBe+pKtxwiTBLoXnlgPjnUeDztNj4NUlx7+ne0Bi4VCNhGX8b55yL6KHofPe5S/K0oETCXjuBU=
Received: from BN8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:408:ac::45)
 by BY5PR12MB3730.namprd12.prod.outlook.com (2603:10b6:a03:1ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Fri, 3 Dec
 2021 22:59:29 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::72) by BN8PR07CA0032.outlook.office365.com
 (2603:10b6:408:ac::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 22:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:59:28 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:59:26 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/15] drm/amd/display: DC version 3.2.165
Date: Fri, 3 Dec 2021 14:58:02 -0800
Message-ID: <20211203225802.651367-16-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c539a91-c013-4539-193a-08d9b6b08f84
X-MS-TrafficTypeDiagnostic: BY5PR12MB3730:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3730DE3F339876DDC6C8238BFC6A9@BY5PR12MB3730.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FF5IG+nBQk6nrNndgerQZEBhy5kJNZGEeTbisepXMvwlyOvYPTT0mRSwiWvroSW3w1GMHSUOffIEsx63H0P4H8dpmY0DYO2a/Y/8NIpXmS9oqcu/wThECWTn7vp35vlDGPOfKq/Wc6vtYWaH3q09dwyfaac9ruwVqIXR54QtCWCmo10TbhMSwTq/Pm78aEDZxrzcjWpxI0gnbTenTrwOAT5uW8fufC8810t5LUob7HyqDcSP0DHgbOWc6fnxPfp/stvf52j4BUKleZlzI1j0ZMKehnPHFUl/4apvI8hlBladX3faqS0XQli3lP0DBdFwVDZNTibyDXVVnp3duo6bo7n+LgirVtwNjFxlmqw5cEXMQ7z+g+/azCrClYxsDGLQfDGlwlP4dBC4mlZ+6qjk+ffYxTiqhzysRWJwayrQ/+V8cDTGM2C1rQAJQcQon29rY146/1anv28k7qWhuzT+T/qshf9pJEs5DKi0ap4fHf+VhjZTUz1U0YqvWutSEkUNhxGnsw7RFMRTMWvU2ykxPSxYgsnWcJWSlNrSFkO3ngxZxVw+3EOfBpUq7tKr811i6S0UUYuvhqDp/ugJW65JStdq0KCz1irhetqPF46wbZqA60x5veXstkG/yclBXnfHDxXZW9R1pm4D4KNeNRP0K+G5Tfhf8skpg9QyOHmUJ07AOE4QizG2Rr1PQYOb8/fGf6gEZfufSowdJYwE3iJ73DswRGXfjc1qhoy9PQLmeu/oaeDa9JzDxBmFR7bnOlT+TSDN4MrQsVJ8SZetBBmMcTuJ4tsxjQ8nq8TXBtuIOyw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(36756003)(40460700001)(47076005)(54906003)(70586007)(316002)(4744005)(336012)(1076003)(4326008)(508600001)(83380400001)(6916009)(70206006)(86362001)(356005)(2616005)(5660300002)(16526019)(81166007)(426003)(8936002)(186003)(26005)(2906002)(7696005)(82310400004)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:59:28.7465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c539a91-c013-4539-193a-08d9b6b08f84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3730
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a43c008bd0f2..7d87a47511b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.164"
+#define DC_VER "3.2.165"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.32.0


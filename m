Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE72C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102E060724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 102E060724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07BF96E125;
	Sun, 24 Oct 2021 13:32:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4C56E114
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RleSgxGYGhF5tAf9t18jBA+rehZFe5nFrvdidcJn7QjrulijcMvYl2QjBCxNW971IV0Afj5jx1AfcLfE2WnHwxZW3mCDjIyUfc60cfd1eoZpFc/34P7ZYYBMCb2jmgYf/oppD3FNwpqSjlZX+nYZbOWj2SClLJc8l42t6aVC2qyIfbl/ix1D4cdboVjA6529MvPVmbgiV6YkdRRyvVKnzyjDzbqmq5YnoFndTpuyXLaEU9/mC/Rxbm/5bPuuGFEylNTZ7wIqLevIYXrjbJLu2wq+Md/7waIRlRPOs2RcPjPjszxgqzDMi/ZtLHIPx6G/zxMiH1SX1wryJH/6MQGHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEjnH1++B8Bu93a0q9M01qOm3vM42kqWFIQ/+TKwof8=;
 b=nqB+C+dfJdQXPeqe/b+i0uC8F8m0x7KaoMQ6/XYiSgrbPZTmpKC7OeCRjNTbS35DDapYJVlwKsCK9WmTfOxPkZwDCfhyUxJiy50oAjAansNaWMoUf8wzvW6NVzpFPNAFiuG0HR9CVBEX6DZSbg/t3fvGWMBhyMtscXkHN0wQ3z5TYc+gwSWp2DcrIDEjnfnNKQSNHuUfgb45QYYRr/QbRWgx5lO3aP/d4/mVDyZV2gD5wBHnSLv55xdqItT2KWJsMx+9qIDlKTJu68b4oVYS8LXgebYWfji15U3OVbiRL7zyJMtA4rCzlyf5lOtxvsMOGu+AKiahHqRQrh4lPZj0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEjnH1++B8Bu93a0q9M01qOm3vM42kqWFIQ/+TKwof8=;
 b=0ozyiGJlTT7SkYn82ZLL1GJN5kRW+C3S5uDaU6uVD6+kMgZdlxR5A9DR8juvX3skg1vUgwzGQUdCQSMgWYqnOTCjtLCQy5Qe1gRdygNA4nnVxF7M6LCQFebjdGSsg2vyWp56csG3a4HmQNEUd8j9+V3NvC0CyIPpBWlrCCKXL1k=
Received: from MW4PR04CA0062.namprd04.prod.outlook.com (2603:10b6:303:6b::7)
 by BN6PR12MB1249.namprd12.prod.outlook.com (2603:10b6:404:1d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:31 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::b3) by MW4PR04CA0062.outlook.office365.com
 (2603:10b6:303:6b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:31 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:25 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 16/33] drm/amd/display: 3.2.158
Date: Sun, 24 Oct 2021 09:31:24 -0400
Message-ID: <20211024133141.239861-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c737357-317d-467e-ee12-08d996f2baf2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1249:
X-Microsoft-Antispam-PRVS: <BN6PR12MB12498F072EAC10BBC775CE3698829@BN6PR12MB1249.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0GVRryHyhFoMm2W20bFoc7XLD4jjTyWM1tTmT52KbDgr8xASPmbKQxUJIpmHCEqtCdt7ESzxZEAXjuSQCIw3d+evvPwObJtjSRKeVUorzqmw0P9P7STuVnBlWOGiAzf9xJaWKuuFefsjPws8wtCQjLxBzZysJnwuv8Ko8jaHmUQVajftnso7GLNzmjjZ3s5jmF0cCnEodfUwrUFdfw2WiiipDkMRekHhqKAz+9lyd81NdLA/zRPIK6R7kDlnaeBh6Oce7aNM8xFYcDNN8OSQCAegIK0Rqi28d3piVX36tZO2QLgSs6a3nf+HQLVKx4zAKNdXC/7lvi/ARz6vaeG1ovBTCCCW8JX+w6ikGgRGrzqiSQQPM3bguKRN3/eLcXjoX+HmDQpKVamOzGfCNuLoT7j8rl72UvBF1LR7oF5HvQJ++1O/NqcbgZT40BQySbuul0THs/IgOYapiK4JbvDpGre5Fj4ysSrWlUeh5mj3EPbUE2Pa6evw0gkHFpy4artiRZeoL9RAMHQkHYyicLKnZ6D9pxnQfUVwSVb+QnO/shspHlHHesgDaPPiS5b41cOLnSJJ8RAMtBZUv3R6v5cDH5bCoOG4oGObs0cN/vLItmbldtSlJX+GNT55i5PyCwDWUkqlrsPCc3k6DrlMIOlhoWorjd0XP2qM9K2mmCLQC4jzigw8ky4gY8C+wGhDrVOg0aK59r4H1ukabqqG3eUwsBVDyTDt5B7m530U7Kg6H0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(70206006)(70586007)(16526019)(83380400001)(8676002)(2906002)(508600001)(82310400003)(426003)(316002)(186003)(336012)(4744005)(1076003)(86362001)(36860700001)(4326008)(6916009)(54906003)(81166007)(5660300002)(47076005)(2616005)(36756003)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:31.0831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c737357-317d-467e-ee12-08d996f2baf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1249
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 23977de4811b..4cd04a78f926 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.157"
+#define DC_VER "3.2.158"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1


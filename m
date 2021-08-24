Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E00C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3857961220
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3857961220
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8B689E14;
	Tue, 24 Aug 2021 06:11:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E762989E14
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qbjc56DIRHlCDCciuAkLcrBnQfU2qGIvfjcuJCXX0g/5xfEL+O41rGcSc5lsOv13+7++Xu95XA5O6tXpaYyEVvBHuWdt9kqf5baWO2Ru8IXTaPFRVILTPd0S6vDhs1+OnFtT7axgTNCtsVjgfWSQp1xi7XkmRRewxzEDRjb0l2I8+K5Q6g1IXmsJgMQpVToCYMvKe2Aab5kLxY1HtxvmgX+itkLvcg4TW0h3nexF/svrw5GH/F65E9EkluVmwcHEPY5QL4IB8SmdNyy+uWI11GOM5gNyJz2A3t7ajc6eAQpWSQOEF9MoPDc7waW23yw/n2IMpRO/aapr2RHNCZWNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ooecsbvf6OqR7PGt3HnzvWuPixsWT5BstqmUvWsgqEk=;
 b=dTAj2OY6YbtvUn8nSD/jRUCOLoVIXYbwxwTflkuRJzgbAl9rYuellVdIkFHl8JOQSFS1V/+QRYcCl1PkK+aFdAZUsfiCIyHGBR4tp28a1SS/ZBkySxvAqWNnIMS0Vdx2V+RHQqJ6gK2DKmSMgQARYtb3wGgfhKu0xBEa2G/jwr/1hZxnnPgYEn8cK/mqkebMxkPJMAxcqR5Rv9eeGBk9E6DwsZndzEF/N6m9jPuz9U54VQEiCf6JJJ11Gp9q5e1xA4+5UhsyxkefhU7phGF2VTPz1CMRHXWTFL4+QzL9wzmxxsbd16O9XQaaaDxEnFpk76cp3Z5ZGnh5M5d9H1QOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ooecsbvf6OqR7PGt3HnzvWuPixsWT5BstqmUvWsgqEk=;
 b=lKjf7NaIP/pVxwaSTSAKowVUs1uXfkdmboFft+yQiL/vPHcyljm7agUW5kIu4Xq/G91eId3jQ4ehaBvp1o7Fek6SBspYg9VYmZGn6UNObDbKnFmWGhYpL0t7RXDNAnZz5Pi+hEwHI6dg5SHKgFsdLDavqRzYNJFveN0X8AqDezY=
Received: from DM5PR19CA0018.namprd19.prod.outlook.com (2603:10b6:3:151::28)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 05:56:06 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::27) by DM5PR19CA0018.outlook.office365.com
 (2603:10b6:3:151::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 05:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 05:56:05 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 00:56:01 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: map user set priority to drm sched priority
Date: Tue, 24 Aug 2021 11:25:07 +0530
Message-ID: <20210824055510.1189185-2-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824055510.1189185-1-satyajit.sahu@amd.com>
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd0f6a55-4736-4c60-c1af-08d966c3dcb4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50476415CA27955193BC51BEF5C59@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5i5u7ZMMdrOlTd26xHDRRKBjJM31XT6hLK7G6lQtP1V+YNG7tjdgdAu5wAxv/kRF4rcWU1rhYXTXgcxspvPFouNYTPgngwtRLSkmfN99h7XHRJwL44Qv216Csg4HRvPfd6kkEhbijTw3AWmhicqXRgaUReoaOnAhLf8abqW+HRasR44ZBEDH0l3j0rD4CC7s7cj7gpi4WiTnP4ihKTEsYPnYCOgn8pq/HGdp9RofmPPHavPqyyC2smxYzl3KmprvBh3b5v09wD43CEEVX/+THkF9xBDNYqmASk/dklrH/IPMUicXaddehDpmBDAYDUksi/M2JHi7dE9pOdscHUQHDGfCV43NTO6grFlVbnSP6SKsBlidohmJ4VZra75j1+i5sdXc8QEGA610qS8395DkqLjKPIstj47md7v2xnNm+pXoNY0Q74VSa6+Udm7IFekggoMTtK4NwAOYP/NFEotBKxwUYaB7U5fn1atERN8m+u1pjBDeNHXhp4IS249s9KImprGdOC8dgeRRWfwfPLKxfyjeLKljmZ3hhiyhHJaKw0vE6ED1mcFnPLzsBaaC60YRTVtcJCpawvV1fAakdj2e5ttDNxUwZMVn2K5+2unIgN91lFqvCYmAprZumhFj3M2KnotY5V/NqpILvh4jcE5t2O4o2zVj/Gn1NR/I5Tj66zH6csGdveNTdY1ZSlbq4WpVlkQsoZ//XyLagYe0y7+s4vPnAKmC58XdAWNMKo5bDfZmT6zh/LVyv+zAxq0K/C1tSFkXJr19afYU/DzT76mw4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(36756003)(47076005)(16526019)(82740400003)(6916009)(8936002)(26005)(54906003)(478600001)(186003)(356005)(7696005)(36860700001)(44832011)(316002)(81166007)(86362001)(83380400001)(426003)(2616005)(336012)(82310400003)(34020700004)(4744005)(2906002)(8676002)(4326008)(5660300002)(70206006)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:56:05.6125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0f6a55-4736-4c60-c1af-08d966c3dcb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
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

Map UMD priority level to properly to drm sched priorrity.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index b7d861ed5284..6ae0b723ffd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -37,7 +37,7 @@ int amdgpu_to_sched_priority(int amdgpu_priority,
 {
 	switch (amdgpu_priority) {
 	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
-		*prio = DRM_SCHED_PRIORITY_HIGH;
+		*prio = DRM_SCHED_PRIORITY_VERY_HIGH;
 		break;
 	case AMDGPU_CTX_PRIORITY_HIGH:
 		*prio = DRM_SCHED_PRIORITY_HIGH;
-- 
2.25.1


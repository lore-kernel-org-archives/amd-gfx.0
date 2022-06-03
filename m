Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBB2C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352BA11243A;
	Fri,  3 Jun 2022 20:13:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C15211243A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:13:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp9p+77BTirS/OSYN9t3EavUBDfc83GRxjK7vl+AMiqvEGtSJHA9lKgXm//fLi+GTC81WbytWqxQAEmp4J1hODs5wpVvnOiqZ8AOy0fEawTIU5UaSFxqAXaSXcKOMBxmLlHntrBNtvw0TEfTirfix6cW+K9gmxhfnvGA5vYJD/5l64eEpyEzURkcStuhCo6v0i1rsk5f2JBUxQQtr3gBocJGGwWhseiUzh9+kPhQUwxnRrKrC0v7oT+rvw8WOWVYLGYuumTjOmCKtRI5XWZp52kBTGO1Od2ilBu8J0GLZpTYjHIoC446Y+MEhvZyJxTLdHtBQpBBKjSCnqJ/YVRd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za1bHYrBTb+NuxVYese6ixBPUo0/xFQczyT4GEmJrMY=;
 b=G/CQz6aMpUMADHJm01L74Gs4EXPZRprw0Cjr+pXgxmbGgbcvEf0YXw4URyPDqPHe3iC3LymLAESeudT3KUajfpVXuY0lbUTEJxtSmGVzLg8vpCfSdgkySjZtIKrcve57LTCVVtjSGQedruenjWNa3mg8SQDQfZnqwudqX7jshyXiyGeLvxVyvOYVOJDH3LR35CuGjndsIWCasZXcXxV/3yAYqF+DdqD+GEcCaO0Qd04iLEbf9WX5EaZ9StvYhEvQE6qM/kcWNYB5d6Y9uMe/enkboqsbdLht/dLHJrJNcOeYg3OlHVFVht4Z70vUPhx1kqlovPbYd5ty6pEn8NCKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za1bHYrBTb+NuxVYese6ixBPUo0/xFQczyT4GEmJrMY=;
 b=dnTH8qX8pU8V1fHq/9/kSW7oj4TU+cIxRdEWttZdzdDDcn3HdUMKxkCuK0Y6SWdVdundpkJcxR85Nnbh6hHEBahG/+KtPQz5MRxMHAVKOJF+g/lQqWLO57wBZQQgTv3nDimc3BYAPfxA7TwY4MlwBnBPTYmxoiFaAQ5knmSVBns=
Received: from DM6PR12CA0005.namprd12.prod.outlook.com (2603:10b6:5:1c0::18)
 by DM6PR12MB3339.namprd12.prod.outlook.com (2603:10b6:5:119::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 20:13:05 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::37) by DM6PR12CA0005.outlook.office365.com
 (2603:10b6:5:1c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 20:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:13:05 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:49 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.189
Date: Fri, 3 Jun 2022 16:11:47 -0400
Message-ID: <20220603201147.121817-17-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d831848c-bd5a-44fd-1859-08da459d7845
X-MS-TrafficTypeDiagnostic: DM6PR12MB3339:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB33393875D591CDBB19A54AA0F4A19@DM6PR12MB3339.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLZdbHQ2C367Jte/HZ0lcMtDcnZn3PYqHK7LZahRrQWGSi3z9MRyniQgzbcMJX4m1ZrjISeRu7MKjOY5KjRGYi/lbiTj1XW1jnTvsJi2mq3rqK0oMt0wMJIR8NwOvyvwIy9vpbqeZ5eWrFQAiZrs52PtHnjVLqMX0sKlQ30wudp2CYyRTIGc1nf24P1ixhoPXgIYQCMfH1f+01FPsJ/BeooJsLP1XOt215lAvmgcN9JTYqsBgXnsaC5+REZBuMJG26mLkUr7VR94spJWlabnL9zFlXDbKf8YT3122cvqimLXf/ZZ+ibyq4jlWZnHyyOf4TQKV/eMHkvfsFl6p9h7oK8k8qaMDYCO0lSy3UQPkKJlhT1Rm0H2AfbY/UleDIF3qrhuBmzWlJf6pJWo4MX6P8twfhYCFDdQMCWM4QEMCbelUbcMWn4BdqKIDFkiiHK3OvHvobbnU33q/kuso5tcsa9tG0iDG7e5lB+nrC+tkS4uwNzWSA4zelV6gXqHpj+nXc8CSxM8fSCXeIsM5oad0baQBgkTi8HLlCHxOaSKXVsQiGPRPCGEf59oo2Xa4uu/hHZXBtztMqAjzTIrC4swPub/wqBrew5PVtjcWcqxsOKuEUv0quVlkqbKhknnR+K09FacvcNWmocoJTUvagnkj7awp3wjLNJkPbhVd9rnT1kHBm3EbRVO6ZHAU/ZMjagMsqVp/N8eDoejt2mP2Z8mjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(356005)(83380400001)(36756003)(426003)(81166007)(26005)(336012)(2906002)(70206006)(70586007)(44832011)(2616005)(82310400005)(47076005)(6916009)(54906003)(40460700003)(1076003)(16526019)(86362001)(186003)(36860700001)(8676002)(508600001)(4326008)(4744005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:13:05.4760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d831848c-bd5a-44fd-1859-08da459d7845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3339
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- DPP DTO fix
- Transient encoder fix
- Restrict the reading of LTTPR capabilities in LTTPR mode
- Increase maximum stages for BB
- Distinguish HDMI DTO from DP DTO

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fc0da169346c..11b18dea54d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.188"
+#define DC_VER "3.2.189"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.36.1


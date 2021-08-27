Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A9DC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2AC60EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D2AC60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095456E9DA;
	Fri, 27 Aug 2021 20:45:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6339B6E9DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:45:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw60e3C4MXmG3Hu9r85QL5nUnWbuPp4LlMJ0Wol9NCSy7fts9bEoSHij2rafnq7C8FtGh+7WD8EEGU+Jau0wXcK8wYejK+wIS447IJSlZdyGRB0E/+WoehjmgbEO6rFBt+letHQJS/lNYTrQwxRWWvg0sjFpNVbpuRkbOio9KFgxoEuHKhMpgw6DxUQs0u5bqF1PYExzf0At0tcs6N3Fuv5GfaMfKaj2Nf/Fs0SddLdl4gx+1aSl2jZv6TOtgcew3KD9RQ9YgwjObZmulAoqMhzYosUvzF5pljbVpIldmITRSE/HmmhA0l8u0vRGFS46p+c7PFyFHGuTkOicRzwVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RtgrxifgkIlYfUPZjtsVYovbK5YsOFOOeOHTJQgg3M=;
 b=k6JJM3oK8dZiZpfjiwXcbOI7PYQMP+VGf7zZLmqQqr9XzrKUciya3gPRu5dpidP+85OAvUt6/PXnxwxxzNlYFkYIgeOzQFi+erZbVhaEVuCaNz+M5r0iAj4J2tk29F69L8Wb6wKuApLNT5CM65LFWAZmbfUtCiQyG8nQYBaXTidS4nymIIr2JaKDWpoQNTXqQPMJ6NB/D7A9yA5oaVOM2ToLaVYFT2KTfXKuhIptBWrbNgKwYJkGj5rGfEO1QkNCNkuNUOR8uY0iLNhAlqVtUQEdKXOlSI4x8rErJAkWvAVgSwTr7Z7dAMf1uVIfLzIn8djw6E7tugUYoYUqBYAVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RtgrxifgkIlYfUPZjtsVYovbK5YsOFOOeOHTJQgg3M=;
 b=J/m63BhZx9Ra0BcNlBgh1PolyHHqknUR6ktYOyWkGCRMQ6DAxnEBxtfo7MWX9BScEBbBhml4jvve7+VRqCEdPNe4lzbkhoJM0qufL3Pi5khYZ9gKMpbIVBeArwXEibYnpZGxQ2QXNqq3Skl0F5zEgzl+CkaPUezgW92LMlHZ2TY=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by DM5PR12MB1788.namprd12.prod.outlook.com (2603:10b6:3:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 20:29:41 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::6c) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:41 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:39 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 15/19] drm/amd/display: 3.2.151
Date: Fri, 27 Aug 2021 16:29:06 -0400
Message-ID: <20210827202910.20864-16-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fbc0da5-f9b4-4c16-a65b-08d96999663a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1788:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17887C600C350391DDBFE696E4C89@DM5PR12MB1788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2I4j9oGV31rCOxT+irBZFPQL0D2X+uFv+aVh8pD8/1QMmKQ9QGv/zaDVsnBXVVHoWtcF29FiReut8czt+UNZVr84DnzAJuMfCP/YuqPGLs0ywhBkBaxTsLxvRQiP74dHZJiBRs+qLXLa/ZxQLay/8u9X41W7pXJRon33zJIvcfUN4X9y1k+dMl2Mp4uAYkYssCQuV4nXiTpoj9xrTJPNHTzEXV+yhyHOsapx36tBgd49z2mwHE3jfjOhbJ8CkPROGcyRccGFYpwGw3t9BSctK/aZVFPsUZe0mAfrFQQrWjsBYQGuUwmkah7C7hSvCoFfzhMoxM4m610aIzGVnOtjeoBL8Fz7nRF9GO125oaygOjUYlic6rQH1RZZYEu/OESXrJthdjh8Hp6GaI0ko+q0T7l9uvHVVH5mjqGaxoqPXxJmA+cfMIStOpEeI9y1zyclG7at15ayCwoPKHem+7QhfqwUXJp2tryAELGqpeCJ8Cp5icfIhwMXlsTAn9G2aMJRmfPPx+lCfD4jTDf1E2XahnvezRaPLenKOMpFMuA4lexFfmZ9qJdEDwVyt1C0M67AZ0ygbpF4i/kLNubyLv6xPLDjVhcW7GyCAsNwwMeWRDMajws0AEcwByw7vVulde1wCqeeWIq4DoHnm6yBCdLwGIUSQAO7+KElUxzlGyFBEAaJ757QW0ypGZh16FPakWrIqCmswWHzQThnIr6VIco50HbrelLCtH8puTIk/VKx8Hc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(1076003)(8676002)(83380400001)(70586007)(2906002)(54906003)(16526019)(36860700001)(70206006)(82740400003)(478600001)(6666004)(81166007)(356005)(6916009)(316002)(44832011)(186003)(36756003)(4744005)(5660300002)(26005)(82310400003)(4326008)(47076005)(426003)(336012)(2616005)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:41.4089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbc0da5-f9b4-4c16-a65b-08d96999663a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1788
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

- memory leak fixes
- fix unitialized lt_settings pointers
- add DP trace functions
- add null pointer checks for DP sequence trace functions
- expose dsc overhead bw parameter to DM
- block abm when odm is enabled

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c6c0fb17462e..e0517eaa8fa4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.145"
+#define DC_VER "3.2.151"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1


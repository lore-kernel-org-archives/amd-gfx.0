Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E40AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 16:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E62B110E53A;
	Wed, 29 Jun 2022 16:30:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9001410E4F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 16:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBCRCEWQDRT+Z56uz4GnUo2OwhAUrl8wy/UoAFiLdmwH3zvMn0B8Wmhc49QacFi8iu3Y+g96R26aajdKwUWrpJqAVfpQv6Lvv5CfrAHqvganrdVzb6IdmuVsEB8mtItyiAm5beQbj5DH3QDiGDN8lv4x+ZYBgufg7+yHx6bk0d8QhhMBupYlBZsAzGm24wmvMn1l9iOWsEXTORaMiIcSEIl7PIJcqzukmP72tl8egeL5iAlDSIJo7N992oYqmh1OwmczLPwnKqAwl8n2ye/nYRIT4DmbWFEiehYq91kZlYPc2uRHgQfHnNQ1DsSYPZkq7aOPUZsScTTuy6shYtPJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vonfXGquPbN6xUsPLKcou6JwlGOmrB1WqoKrapZNo3Q=;
 b=baKQylrmuFTbA83UGdmXuUk7CH6stADTgOmEUSdyIOwE76Z3q3jjf+7d2Bt/5Iq5SpMbfpEpLEMowDlCCUEqSRU58X9n9Iah/zwURrsJ+GW3kDiwwBvXzf5f/oQULczqfkKT7zlBCVhIDXBzuekync+70s9GaaBoaQHpeItPG9MUmrjX8Tu3o6qD73AVmZ5hSA4MWaQSAsAWKDLAdzuiCHPvPcR8uv5FXvBOqWph2DhSuEMDFJ1k67e1XAEaQsJNXS48iauohbcaE4acbBffAb6Ri6sls76i2AOihRVPLpSDWfStExYcMekJPHXSf2yiPArfNlPEq2mDCUbzHq0Shw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vonfXGquPbN6xUsPLKcou6JwlGOmrB1WqoKrapZNo3Q=;
 b=KCY0xGwqDF7hZbIVN8DgPLwmE/vRGYeb/KN/8Y+QPs0xdoml3LPWiUF4bqo8rKk8BWPtWKvVh2j8VmXeYmbMOizhafBYkxcbmxT+l6pPT8fYPAmBagjuBo+0WOBAoeoq67lfmFxhxGhTQaABSwh45zFcWKakLRdEH1wN+ldFAOg=
Received: from BN9P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::35)
 by DM5PR12MB1369.namprd12.prod.outlook.com (2603:10b6:3:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:30:24 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::60) by BN9P222CA0030.outlook.office365.com
 (2603:10b6:408:10c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Wed, 29 Jun 2022 16:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 16:30:24 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 11:30:23 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Date: Wed, 29 Jun 2022 11:30:15 -0500
Message-ID: <20220629163015.3766571-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c726ad5-569a-41a6-bf32-08da59ecab24
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZuWRvLaqtPHDdJhv1kKXUpMC86nSeQC30SC0Ai8Vg12BiHa2cqi/qOcAuDTkSYJnVkrH1mkGb6xuI2S7dV1HIZ4NmyMehqXG3VT178XqVnoSY5gh61h1kW2q7fy8chOyAl3bzOr+4ffMcqNAd+4y6j7BrIOT6/aOFGmMvihb5vUu8Y3+C2SXrpH3/+gfYoUhsRXynBzB1ts6bHmYE/xXYE6UMTdNTIWxm/ptswmExXd2Dt7a0YyT2cmi6zkCpTOrnaTF83ChW3lwiffYb4ykE3XnODEKUTA8NHSap0mSJRfw0NY0qelGxsB4wmu3XVIGYGfrDntKnLk+wpe2yXKqjJd229Ma5JLIYM20RPE4/aqNN8oX1hbYupV0wzOCU9b4Hx4IpjrjQoBy8HPQ96vTVDlfBK+UhiaRedsFUT9NzvsB3YMzaQgANL5m59FACVOw8ZdEPMhscta7vddmeYNQwL4wZZ3CPX4HX5bbz7ygdPye11esW/6rfbf2QDCph54WZnA/zeBj/bY/nvbjhvq6Z0qTQgtmESv/IuJixdPX3OaQw1lVqZFIu1YRnazIoeSu0KSl2MKzR4yfRsYf1H2JUasqFurQmQYMJXeP5WhG2qLyrQHqxFKSrK4ji24Wa55cwim31gvbAVhuZEWtXlNHBNG8PLGLKQ8GzB0I5HNdDHprbKc+vL8mF6qNZXXF9ADfQh+hECyyH/Z23LXJsqEEAvcdZKovPwFUN91JL/hIhoUiwQ0DkFdi5qX0izNJ3gvvFYOi/xDwJchLvoTok17i+q7ZvjccXjCC54w/2Ifhx1bUHXIE9cVBsCgiCJignY7t/WLN6QMsVFfDIyjT3k0WOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(40470700004)(36840700001)(26005)(36756003)(40460700003)(356005)(36860700001)(47076005)(478600001)(7696005)(86362001)(6666004)(4326008)(186003)(5660300002)(2906002)(8676002)(41300700001)(82310400005)(426003)(40480700001)(70206006)(82740400003)(83380400001)(16526019)(336012)(110136005)(2616005)(70586007)(1076003)(316002)(81166007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:30:24.4031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c726ad5-569a-41a6-bf32-08da59ecab24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patch fixes couple of warnings, as reported by Smatch
a static analyzer

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 34 +++++++++++------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 25990bec600d..ca4825e555b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1417,15 +1417,15 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 
 		/* find CPU <-->  CPU links */
 		cpu_dev = kfd_topology_device_by_proximity_domain(i);
-		if (cpu_dev) {
-			list_for_each_entry(cpu_link,
-					&cpu_dev->io_link_props, list) {
-				if (cpu_link->node_to == gpu_link->node_to)
-					break;
-			}
-		}
+		if (!cpu_dev)
+			continue;
+
+		list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list)
+			if (cpu_link->node_to == gpu_link->node_to)
+				break;
 
-		if (cpu_link->node_to != gpu_link->node_to)
+		/* Ensures we didn't exit from list search with no hits */
+		if (list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list))
 			return -ENOMEM;
 
 		/* CPU <--> CPU <--> GPU, GPU node*/
@@ -1510,16 +1510,16 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
 		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
 		if (cpu_dev) {
 			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
-				if (iolink3->node_to == iolink2->node_to)
+				if (iolink3->node_to == iolink2->node_to) {
+					props->weight += iolink3->weight;
+					props->min_latency += iolink3->min_latency;
+					props->max_latency += iolink3->max_latency;
+					props->min_bandwidth = min(props->min_bandwidth,
+									iolink3->min_bandwidth);
+					props->max_bandwidth = min(props->max_bandwidth,
+									iolink3->max_bandwidth);
 					break;
-
-			props->weight += iolink3->weight;
-			props->min_latency += iolink3->min_latency;
-			props->max_latency += iolink3->max_latency;
-			props->min_bandwidth = min(props->min_bandwidth,
-							iolink3->min_bandwidth);
-			props->max_bandwidth = min(props->max_bandwidth,
-							iolink3->max_bandwidth);
+				}
 		} else {
 			WARN(1, "CPU node not found");
 		}
-- 
2.35.1


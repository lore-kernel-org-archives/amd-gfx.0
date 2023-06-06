Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD01C7EE2A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 16:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346D210E37A;
	Tue,  6 Jun 2023 16:00:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBAD10E08B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 16:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0LITvC4kwBPmUBX8O4BW3o1BygsQzgg6yGxVf0uXdUYHdrgzo4v/9MET5yLo8nV+FO8cUDeRhPmhuLvxVy3VEsT8d/T8hLwF0YBHakZiWq5AOVLbo3swVlYW0BELNzBac0jwETmo2RywBMg52Rk6w5k/6oXjp59LkG4FOPsj8OsIJoY1AKKlTNFo1DNw9uYZQZoRuoGDi7w4WFU45sMZlEKOvWIyBve0HgJ+gNojgY80DFIO/+fOnR6Bz7n+iLuEO24arzij5y/mePUDUeVAzc1O/fSAHrVSVxtlFknmNoy5S99uFIcPg+hOvPQ/SyLNN5tX7glExRJ5r03cZ6HyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mMW9jC98oJp6IpUM9G1YCwa4nElBiGVuERPuBcO5/Y=;
 b=Wxnf/9cmovrq1D8qaStKfXJjmIAbnRmtYDWSxFrtXtukq08oW0ARiCZm+FutjIiV7YAMQA5hA9dh6ccr4SXjANYH0ethyWFbTk2V8/3weEAXSfDYc47FVEu2JbIR2WEAILFG/GXbVqaT9P0kVKyMnJt+oihlG250zkwlxgC/MqRtSMj5Ckc8XpdovUrJ1R7LrNyoNv6NxDr92baGevwT9zZpZhM9F+DnMnA6sY2BTkhTuw579Ve2GGjMSd+6bK1Fy/RPXAyVBAfGXXOqlStl4SxeonK9hlC2sYZpUY80OPJ8wo94OgfCyTJH/5NFM6C5HlzVDETFKti+oM6FxIHxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mMW9jC98oJp6IpUM9G1YCwa4nElBiGVuERPuBcO5/Y=;
 b=q454Iq0pbFf92szrQHujzBfu1f/PghU/jIryjfbeEz4W/q0hE9lIIiYlxh0p48lPKlvfx5B8iTlNyyWdnOOrbMtovF0Y1jX/wwtToqzXnIM48I6rocWo5tdgyJ6WN0AzwxFwGZOygExU2WL4D/kSbAODiI64CbFr6XRA/1eBDiE=
Received: from DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) by
 LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 16:00:24 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::42) by DM5PR07CA0087.outlook.office365.com
 (2603:10b6:4:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 16:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 16:00:24 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 11:00:23 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: don't sleep when event age unmatch
Date: Tue, 6 Jun 2023 11:58:00 -0400
Message-ID: <20230606155800.1859694-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606155800.1859694-1-James.Zhu@amd.com>
References: <20230606155800.1859694-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: ce92dd32-5899-4617-720e-08db66a72371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNyILjxNTG13aUFT6nYKO8PMe2tNaYZzLnfSRmGBYG9aDfInEQ9Nk9K2tIuH8RxajJ6uIcR9Ms5szCKfeGKT7G+eZn1XPHUn25z9taVcMVp2Yroz9MxePBrdiaDxvW+PTglGwjIZ8WflUWG/oCv1m3J9IH4yTjI0bFgSeZK4J7C/sIQZzoAymJQW/pQDkv1Yz6tlgTzHpqcT3ioq3ecUmxIKPRFYEzqyhXVL9tx6oLSoUFtrRi9ty3uxeswKrVSuy7XyFjoiyHpWEdP3TtvdajdiO/t6cAukrbc6EGu1OTr13MJT98ZRdkgOdjTBkUVHlxa8GTbgjmdtmGKJv2pFmz8MDkd3i18EQyfA5+qL8D7WCgPL6J2NHOY2lyhWtaZC1LGbzmvBaQ66OQ6f1I7d9RAaHwSReabquWnzbGlHp4KTYTBOJ7Je6MxeXN2HA3cxjtwIBq3aP2HQUX4tojSiNAxRkfT/r2otMOeWICMT447El/9t90hP27gMESxgCnCpQw7XzxQHOjHu/UPFnxF2NN+v2h3V+D1RQEQ/MzgeTa7KTHS3NPux9dHamtt2jN08KZ3sgr/Bt4R5Bs6xfmLQ8+PbAmpUY3PaBBZaCU7M7qVvC7mfEWjyRdvQc1s5y89n50/zqFIz1pMRlwcyVzrUsrTrJCfn40c5zr1F5CsD0lHu/BUtheS1r4ztLP3FLBtVypEPwJHC4h9Wp98w7lS1DL0miGz8hZKLx2kAjk/63mDfFZ8i3+csVrkyJf05CBaR+OszpoGmnsHs7dtkAjhE7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(2906002)(40460700003)(36756003)(7696005)(83380400001)(6666004)(36860700001)(2616005)(336012)(426003)(47076005)(82310400005)(26005)(1076003)(16526019)(86362001)(81166007)(356005)(82740400003)(186003)(40480700001)(70206006)(6916009)(4326008)(5660300002)(8936002)(8676002)(70586007)(54906003)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:00:24.2484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce92dd32-5899-4617-720e-08db66a72371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't sleep when event age unmatch, and update last_event_age.
It is only for KFD_EVENT_TYPE_SIGNAL which is checked by user space.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index c7689181cc22..f4ceb5be78ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -952,6 +952,21 @@ int kfd_wait_on_events(struct kfd_process *p,
 					event_data.event_id);
 		if (ret)
 			goto out_unlock;
+
+		/* last_event_age = 0 reserved for backward compatible */
+		if (event_data.signal_event_data.last_event_age &&
+			event_waiters[i].event->event_age !=
+				event_data.signal_event_data.last_event_age) {
+			event_data.signal_event_data.last_event_age =
+				event_waiters[i].event->event_age;
+			WRITE_ONCE(event_waiters[i].activated, true);
+
+			if (copy_to_user(&events[i], &event_data,
+				sizeof(struct kfd_event_data))) {
+				ret = -EFAULT;
+				goto out_unlock;
+			}
+		}
 	}
 
 	/* Check condition once. */
-- 
2.34.1


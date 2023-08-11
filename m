Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7652FC001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 06:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6D110E65D;
	Fri, 11 Aug 2023 06:04:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F151810E65B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmvoH6h8bU75ly5Jp1I1SNHvF3bNb/DkRLSI0E/vnG5DjXse7D4DQ74ijxf29jmU5WiYNz0xVkC71apTUWdRGmNDmeRwScZHEy/vofWMwQXwduq1GdtplFk6pB3MdrFOsQq5homxA1CwgDhZ7rLjw1x6Xi4E7ASpuxK7qlkSBEFkackwqf7vZVLgTTn3GVlWyh93abC5v/vQeVkd2poFvByh+QqrBnDCCulQvYNU/pWUwnDeHPNrQTP1soQ9MMZO2iu9hW41f5ROBAE8HN2WCHP9VCbl+oMogPbu3gT1cIYkbj8JTtqz50udu+sJNJ/3C7ToicdRk+UWRGNHWsZ/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pLMJ1Sh9m9xVDGYgmw1UQZpGAxvlaJTqRdLbX2rcKw=;
 b=TqhyAbil2frD7gvIB2t8TXl43qz9i625H5y+lWqh2+N/ZfGlNjiYeRkCMr3DEV3fQZ4SDXqHIAsV85AnZ6qry9AWyXv7S7N5JqANV9y2QpAummdQemSRuglY7LyD4E9u+9EJ1R375jHI/6diqdTVnE6RXFfUiJw+vG/x1fazLlfUPOwS7VRLxXhTplL1zyuvPmrxxdreUsvdDF11Nw4FZiLbjAA95WMv2XFAkmo0zBX4W6IHR1Je1PEI1SDBKYjP7ssup9B2xFrzZhwlYlxSE/I2P6HK9Pcj8qNcRDIzJsYsZMNLhfiPZE6dAtx2wOnowvTb1rnbHXI3K3sLYMMqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pLMJ1Sh9m9xVDGYgmw1UQZpGAxvlaJTqRdLbX2rcKw=;
 b=D1sEntnJB7+iRhwvnzuQABO18s/4TNe/x4ijGejNdGhPzW6knab4RX/DW+ZBAjy4OCAfk9n8JkNWdshNqeqTHi6sU+8SR0Ss/W2JKKM2fQYOTlW1847HWlgjnOnUmdXV0fKGzZd/P55b8cx9JcOk24J4NlnugNB/tbpDepfcmmE=
Received: from SJ0PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:33f::23)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 06:04:09 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::83) by SJ0PR05CA0048.outlook.office365.com
 (2603:10b6:a03:33f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Fri, 11 Aug 2023 06:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 06:04:08 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 01:03:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: Add API to queue and do reset work
Date: Fri, 11 Aug 2023 11:32:33 +0530
Message-ID: <20230811060234.663789-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811060234.663789-1-lijo.lazar@amd.com>
References: <20230811060234.663789-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: eff2637b-5fbf-4563-34ab-08db9a30c6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQnAPZ3IpcPvUg+qEIfEeADBdxUtR0+nskjSLGx6DmWQDm9fyWr50KQMzvZ/xirmRw1m3meWaPvsxi0zTud1mb86O32+MIcbP/q+N154JdNQf61//2Te9Sc0Wgpd+Q4UvV7iCZYYLzM1we410PAoyLgHGPtn3aS6W3C2QPSXZ+FAqve7t5tNil/6MfNlD3j7YRBPaiLR2K88Dzgev55V8RBkYtsWl3ks6tM0rV/19Tzd/XlmtOrB+uf9lb7WkXH1aK8GSHnGLiTAOJfuxbdqGtB1l95kpJR1iVFEeZI478BpxZZicMM9yzjQBLeESEjKdL+FT8MaCtHEfzvBPuzIEDV6u5BfzunMpDN4xZZMmq+OTw3l7KD+IqAd2J1yrYURBvReyerSLD7Dm5tFwvS4xo0r5LRG6hy8+ai0uTs3cxWBwFOV3FJArwAZIZhuHRihK7JiyJpnaWkFcKlP6Lj6icLZBOZeb/np72npNIC5md8iBoqczhuXeX3hR/9aoXov95ZwkRUoIEYT7MzY4i8U2tn4WvPPgsGqmdYPw80zhhEcNu+RRu9iri4qJKu19Fx5Vvdsb/myslWyMOdTTzVnvtDwX373hIGiQYyLgl/IJH6LqDqkoT4QxgJmx1mgf/zZXEKTONHF0myAO6+fOtw2GBfWdd8L7jnP1AGZfJgDcIeNJJ7GyOM2fSa2+ALD3kdgo/LLqZlYVeyz2ec7O+dV+Gz7JX8aTM1WEcCpoyXd6sZa2YEJr5RJ7tuRRyaRUDd926pI9mQeYWA2yitnrgwF2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(186006)(1800799006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(36756003)(316002)(7696005)(8936002)(8676002)(36860700001)(44832011)(1076003)(26005)(5660300002)(6666004)(356005)(6916009)(82740400003)(70586007)(41300700001)(70206006)(47076005)(83380400001)(81166007)(16526019)(2906002)(4326008)(426003)(336012)(40460700003)(2616005)(86362001)(478600001)(40480700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 06:04:08.6529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff2637b-5fbf-4563-34ab-08db9a30c6d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add API which queues a work to reset domain and waits for it to finish.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 713362a60c9f..0c29acb65b88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -263,3 +263,21 @@ int amdgpu_reset_schedule_work(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_reset_exec_work(struct amdgpu_device *adev,
+			   struct amdgpu_reset_context *reset_context,
+			   amdgpu_reset_work_func_t reset_work_handler)
+{
+	struct amdgpu_reset_work reset_work;
+
+	if (!reset_context || !reset_context->reset_req_dev ||
+	    !reset_work_handler)
+		return -EINVAL;
+
+	INIT_WORK_ONSTACK(&reset_work.work, amdgpu_reset_work_handler);
+	amdgpu_reset_init_work(&reset_work, reset_context, reset_work_handler);
+	queue_work(adev->reset_domain->wq, &reset_work.work);
+	flush_work(&reset_work.work);
+	destroy_work_on_stack(&reset_work.work);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 73d1f78d2b0e..dba719012516 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -145,9 +145,13 @@ void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
 int amdgpu_reset_schedule_work(struct amdgpu_device *adev,
 			       struct amdgpu_reset_context *reset_context,
 			       amdgpu_reset_work_func_t handler);
+int amdgpu_reset_exec_work(struct amdgpu_device *adev,
+			   struct amdgpu_reset_context *reset_context,
+			   amdgpu_reset_work_func_t reset_work_handler);
 
 #define for_each_handler(i, handler, reset_ctl)                  \
 	for (i = 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
 		    (handler = (*reset_ctl->reset_handlers)[i]); \
 	     ++i)
+
 #endif
-- 
2.25.1


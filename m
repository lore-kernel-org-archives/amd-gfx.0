Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECFEC35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9605B10EA6B;
	Fri, 15 Dec 2023 16:00:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D32610EA56
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0ACjVJf9CC3V65uf0MO0BIoOJt9WwdxLmhksQhWzTufyHJrkJJU9HYGIuaEYVKHZKLgWsN7DS+/dmXIOisp3HLrsupp4AnwV/2AoZF7MBxcr2ynNMfgDlGkhh9ouTb3c6HpTisv/OHICaynS/VElM6BZF72oX1N/KC68GsJikLAnXJ0HtMR7k2mNHzAIWK8iABRMzGkINBRosdWDIUVwatCFjIIUd6ur7XDTnFurQBTubImiOVhR1UgvEFiIyScgk068+dwv3eUViExWgYH+uy3CshFXh6atMr6gbtxEyd8/F8nyZ+Rcsau7mAEjQ1M7lLl++tg8kInUyAfaoGWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LQtYj8RaDju/daPz1cpISNq85g3cn0vn8XP84KMucc=;
 b=SuPE+qSGVyKN4wSZOoqRBjDws27b3TZ5sMAQyPwwPhy/IaHJjL9VK2v6nmnzaf2GTmU+wZvpvlTrKGHuGP8KErjO9PJOTebXuEJnTyJxJIRYaD53I7LmpKaOFCGx+jBzVgH+MXTLDLQtHq1h4Qe/xf459VgJ34cT8oudvz7je6VuD+xz8wGFdlFhZi//BvrhUJB4TKJif80ybQ5UWUY9jDZpUdZCHnyiJZ61cv988v0SJuMb6+oTVo1d8wcPEHh5ui+IaMMX1UdxuAYr/ikA+WynSq27NrSrNNli9UZAiIKZVWNenCIebXm5Gm3byknLRgOrjHDDzdSNGQ1iD11Zaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LQtYj8RaDju/daPz1cpISNq85g3cn0vn8XP84KMucc=;
 b=jPYhV3Bgw+5SOn+he8o9bWrHCJ7htbv8+55R2imKXrzheoBSNw7XI3Jz+bqXZHhfUiL3OaxT2kW1AYgZlV75steMxh77u0wsBTM4XrQNe8ukM7xpDBjL0KCEv7JyW9HS3lRmUnOqYk+zkoZrAIiU0ZPiZq/mbRVbbwKy5XU545Y=
Received: from SN1PR12CA0084.namprd12.prod.outlook.com (2603:10b6:802:21::19)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 16:00:43 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::31) by SN1PR12CA0084.outlook.office365.com
 (2603:10b6:802:21::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:37 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 07/24] drm/amdkfd: check pcs_entry valid
Date: Fri, 15 Dec 2023 10:59:34 -0500
Message-ID: <20231215155951.811884-8-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e42924c-5639-4b32-c7d2-08dbfd86fe0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qu4sgwkjSfhFmD44VTEAsNhPMFzJzE2FizGfTpk4tShLG4POyAlsQfJ7Wkd/24Z0q4VKsI33JaIXQo1yHh4YngNJnijSOgue9hTZhBkZMY+d1TcWqO9eK4OQu4gO5S5rhN0jhDikdrUHLEOKBhaw1EhHPJ/myUzwRDJ4/l66uAiVM0IEGnrRzBhJ/N5BSY/dTIhgPhEM7OA+Z6Ll/ZiQipHA1ZaopxqrWVqvCoGvVfrLleIx0fTSFojIc393wgis4oQ99IclZ/AyBMB5sNsok4h0QdsOZJYjBFfJwBi/gDWKXzza0mxud0RfiX33iWjS3VIwTkDvbAn1Ga37XKOKUUhr4FlUQf77gFLDihghyBVb0Spo47DyO2eN3Ccb715QRW8NOWgBO3WWlfP6gLTjHuM/C49D0v7dwVY7v0/XpBKFe6cqBaa2FryeKE3CaDTcqYtfAtPRcJ8YonQEF7HFaEClw91rIJXFx2XexThhD44OSHOYEVST8dbn8bQeAQRtQ9+0BMzyNPOM2MTed44vUn0VTVelfZgyb5FX+ujkbC9jMHwvTMFYPZJBpWnV4olyh/1w+o8eiPHu+mFFXET5+aI+Ud01HhiVSN3pjvnC6B38Jq72QZE6DEarNaOKQXoa5u+JjIQGqlFElMTsvPVnNxk9K7TiMMAUS54Yghx13Wt6G1RMrYmCB/KV/tOz7WjodGOtrWRbna4sr587IBd00Ux6mXq/GdQoMUirp9GsW7/Zbog4erKK3qojO2f4nrq5G8SXr4kuqp+3C+fHyHpFkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(16526019)(26005)(426003)(336012)(7696005)(2616005)(1076003)(40460700003)(356005)(82740400003)(86362001)(36756003)(81166007)(47076005)(83380400001)(4326008)(5660300002)(6666004)(36860700001)(70586007)(6916009)(316002)(70206006)(8676002)(8936002)(54906003)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:43.2062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e42924c-5639-4b32-c7d2-08dbfd86fe0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check pcs_entry valid for pc sampling ioctl.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 33 ++++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 0ea51330acd8..193a8aa94d52 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -178,6 +178,24 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
+	struct pc_sampling_entry *pcs_entry;
+
+	if (args->op != KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES &&
+		args->op != KFD_IOCTL_PCS_OP_CREATE) {
+
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+		pcs_entry = idr_find(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
+				args->trace_id);
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+		/* pcs_entry is only for this pc sampling process,
+		 * which has kfd_process->mutex protected here.
+		 */
+		if (!pcs_entry ||
+			pcs_entry->pdd != pdd)
+			return -EINVAL;
+	}
+
 	switch (args->op) {
 	case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
 		return kfd_pc_sample_query_cap(pdd, args);
@@ -186,13 +204,22 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		return kfd_pc_sample_create(pdd, args);
 
 	case KFD_IOCTL_PCS_OP_DESTROY:
-		return kfd_pc_sample_destroy(pdd, args->trace_id);
+		if (pcs_entry->enabled)
+			return -EBUSY;
+		else
+			return kfd_pc_sample_destroy(pdd, args->trace_id);
 
 	case KFD_IOCTL_PCS_OP_START:
-		return kfd_pc_sample_start(pdd);
+		if (pcs_entry->enabled)
+			return -EALREADY;
+		else
+			return kfd_pc_sample_start(pdd);
 
 	case KFD_IOCTL_PCS_OP_STOP:
-		return kfd_pc_sample_stop(pdd);
+		if (!pcs_entry->enabled)
+			return -EALREADY;
+		else
+			return kfd_pc_sample_stop(pdd);
 	}
 
 	return -EINVAL;
-- 
2.25.1


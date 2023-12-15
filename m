Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B729CC46CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A7210EA81;
	Fri, 15 Dec 2023 16:00:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E7D10EA6A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsOYZ5tk4So7P7APdrWjPPGavQNFRdr4glk4PDiWDJa0zJm543aLIy4g0KLwYpmaCugN9sDa7zBsnWiEKTz8YLzqT7AwAU8gw26NPE6D/yl6ajUxauz1Z1nRk0F2OSGwFFinqleqFaxRiJv28Tf9FJdYZkQmgP8veO82EqUQzAHvpzP6V+zVAgDh2f4fdCLWzNwvhtXixI+GZznIeIzgBCx2UyJ1JvRXraGsLzSL/dyDPxO8G4baDy+/gtGeGQ3Sy+v3FWndESu++RAuSb5p5mrla7yG3Xv+HSFTKvu66zTJW69+F/8iau2PcpFAgq0h2MrRH9DQBQbSh7H6Hq/4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTp0wv6IzYFADz11qt4fzyDQ68K61OBBLd752bqFU+I=;
 b=nWtMJEbRAPm7+kjUjneURpb7+IWpwEJhAn2avYOdMZQsPP0l94/GTGu3ySHBLrAmrN4woS0VbCwFmfY7OnPrd9e+0DqIqLq6DC+PyKg0SrR1gQCO6TUij+lrPDYsx+TX284txnC86fTn3c2hJnuB1wDIChxSDav2I55yBvWveZ95924bW1AtlxElTBp3jp3cTUXO5ogWgkrrqu6jN07LEmG3t/PUEucphzdTqqjTXqfuhyE9/+N/l8wzSBtfpVzINlrKmrguR3x7ABCrVhZwEmCwaGqlji9VcPUg0J29jeljrC0U/+VOcuxh1SS0BdByVDkKT2NG3r8siSzG++c/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTp0wv6IzYFADz11qt4fzyDQ68K61OBBLd752bqFU+I=;
 b=dAVPEU+6zyU5fQASSCreBW3P+YVaYHbF5yQAp9mFkEzvmgZXXEyiq/uvU3vpOXp5DZxztp0LJFHLVH9/7zhYFTmxF41+UbWtOabxaxl2mBOb3dQZQ/mWQ3em8/NnMc2kjNHKzK1/oHmm72Y3oX1AOg+hJ+++Ml+mJliC4XM0qkw=
Received: from DM6PR06CA0036.namprd06.prod.outlook.com (2603:10b6:5:120::49)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 16:00:47 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::bd) by DM6PR06CA0036.outlook.office365.com
 (2603:10b6:5:120::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:47 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:45 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 20/24] drm/amdkfd: enable pc sampling start
Date: Fri, 15 Dec 2023 10:59:47 -0500
Message-ID: <20231215155951.811884-21-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c769f5-a6b6-4f55-9825-08dbfd87005d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hnx1Sq4kwe4bUmsBx+DaTMfEJVeyfOX2wBtIT2sdpK2Lvj1hxvrOse3+Fe3UvMzn2OJbrx0Swp7Z/5wKGHo8t+l9t25w3U9cJcHATheKQr9QpdAX4M2qsgjtt9hkdlkWpB10PoxenKCGYKqw5jdTnEcqpMi9deBqTLaLOoXqZkpQ7I5yTvztWrfVSv9iw1FkRW7Gl+BuXxR14WDzN9RTWnsRNZNQkPb9s7iN2eVQ41g15RUiqhFXW7ZLBilNc2rE99qS/JILvy32Q+WUhLkM/OVxdBPtESJ06IY4qN1zSXGs4Uv0es5ZSa12BTltABqbFSaH/1XqLIlaxNAILwlSm+JkN3W46UD0DPuCIEGUBPVShhsSCJVzEhZqSkzzIhokR/w0dLUEn1zgdkd7jNGiUtdG2EbIRXeITvCjkv2KZ69UGOMsKzXbQRqeg/p4tblno1iQkC/Km7FreqdXTexKRArZyyKcZWFBarrvAVLRTmNPmwg33nFaz6IIsK+fAyX70hQqOJIooBZkLEhjIFqwkqZB28FGUorrQbLR6qR2cmIc8zdZS4Wivj/y6Z1XnobuKQdR4SEspQnQnnZ/54fZZPT5Ku7ORwmU+YcmBpYWvT9gefd3vBdTp6orJZtu1/iM2BSVwGPUPGRRbiTrsKE9XVJ/ZuQOWOqOkt0Tznt8cNN/HyjH0E2knY5pqANS8iXEa5KlGqOBVvx6p4EJtIo9y7yvkExnvsNWsTkCUcqQXhgzC36lw7+pfFuTEopVoyO7PSKQEoW0BVaEPKmwgEnlJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(82740400003)(2906002)(36756003)(5660300002)(83380400001)(336012)(426003)(16526019)(1076003)(7696005)(26005)(2616005)(478600001)(6916009)(54906003)(70206006)(70586007)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:47.0509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c769f5-a6b6-4f55-9825-08dbfd87005d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657
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

Enable pc sampling start.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26 +++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index c9fd5b2a3330..42282f130fc3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -84,9 +84,29 @@ static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 	return 0;
 }
 
-static int kfd_pc_sample_start(struct kfd_process_device *pdd)
+static int kfd_pc_sample_start(struct kfd_process_device *pdd,
+					struct pc_sampling_entry *pcs_entry)
 {
-	return -EINVAL;
+	bool pc_sampling_start = false;
+
+	pcs_entry->enabled = true;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count)
+		pc_sampling_start = true;
+	pdd->dev->pcs_data.hosttrap_entry.base.active_count++;
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	while (pc_sampling_start) {
+		if (READ_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable)) {
+			usleep_range(1000, 2000);
+		} else {
+			kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
+				pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
+			break;
+		}
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
@@ -252,7 +272,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (pcs_entry->enabled)
 			return -EALREADY;
 		else
-			return kfd_pc_sample_start(pdd);
+			return kfd_pc_sample_start(pdd, pcs_entry);
 
 	case KFD_IOCTL_PCS_OP_STOP:
 		if (!pcs_entry->enabled)
-- 
2.25.1


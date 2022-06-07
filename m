Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C926C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 22:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE76010FE34;
	Tue,  7 Jun 2022 22:50:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D63910FE34
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 22:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWxcnXv2/yAGADVrkfhZGUbSHtg4PBqfNZwWmfbWS1uJJS5vUCO+IvUORrUdyVYEqMKtGSJNSpg+TiqAO4Ye9xEmqG8T7Oi5nfVB86GEq9ZDrigrEn68jYT4QzLQrNERd/z3wroRFIswzN6KCsVvbnKvvOF6fwF/QSdHHYqOFM7Wv8N1U0bvLeYcQ35XUB+uXteyCI6xDcetAHF//ygKpBOY98v0/BpzmGXgfeKPybK40WKx7BV346IIp+/72Gu+BTNscXCIOYsth+mZm06uxiJ6KgdjeXCH7UgVet1V3upfVDjhOJehnif1fMAwVX+q0uZhKQm7aOgiHcqVrE9TTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYdALOPPLc4r5lUPwIMRiY8WEVf60eDyPEGLDwxSH4Y=;
 b=HbHqBR1HDCxqGxa/AKdVA0SDE77TWqd9RVPyJWtUJRkMWyW17zUTQhp9eNZbq6Ex8nQraAS/aUijzV4WPcKNVXGGm2BAV7YHhc0dlLTll1Ad9nK8Q/ZujrPJ5DfHBuYHjc3a3ArJ3Gkq695alUi06Uw7zINyxBVwE7RvzFkJ4saffg09gKf4o62KGNSIHnPy2LJdgCz4P58cYHnBqyINr/PVbC6S3XSh8j61xn1Be64Hr3iHIrMgOX2FngrPlJm1gEZmfeHvXMiyx7be6gk0wRs29l3zJT98LR789ivcJC8zRLTyfw++vxfkdFJ3vg0sVLz+0T4IgQ3UrHyUJnE2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYdALOPPLc4r5lUPwIMRiY8WEVf60eDyPEGLDwxSH4Y=;
 b=3uYjnS1gbpSRC0jENZo7NeL4/70rLB/SAvtZOZN8NH5DSWXrBSN8MP1MKN9Z/1xAnRKJwFszq4hDFSujP0pOS1N6Qk0c+RnUBRL18FK0Bp6H+AnBWbmNIfr/hovmnsuKXDkKlo5U+cnDpraC9gtISzX0fxDCXFbzmRZewFJp6xA=
Received: from MWHPR03CA0007.namprd03.prod.outlook.com (2603:10b6:300:117::17)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 22:50:20 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::8b) by MWHPR03CA0007.outlook.office365.com
 (2603:10b6:300:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 22:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 22:50:20 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 17:50:18 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: Pass MES/RS64 information to sysfs
Date: Tue, 7 Jun 2022 18:50:05 -0400
Message-ID: <20220607225007.1372343-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607225007.1372343-1-Graham.Sider@amd.com>
References: <20220607225007.1372343-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7388454-886b-41e1-58e1-08da48d81963
X-MS-TrafficTypeDiagnostic: BL3PR12MB6548:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB65483A5F7D919E919C7C859C8AA59@BL3PR12MB6548.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9DdUS7+IyYB7XHQJlI0k2bDzPuyj0GWwhZsMAvjkdhRKKi27mfTIM2NdjP2NzOU/v4GC1aoaua6ZVupvkToLErq1hi7OgG9Yr5qSlfSGxWUY9QKDsDL7QrcGJdb6uMDItytfGdFcyhFKt5X22eBjw5gDjEnOqxEMssy79SFKNebJrKLh1zardmG1jv7VBDeomHg6XxpuI/5AlBAHvNizqjguxLvw2Qajre2ftCY5ei+MjbXdMkzR8qGX8wpqBIpN9p8vMvMSbXhVOpHA+irMwlHHtrZajc11Am99G8pp0ijgZqbe1P8fN22at3a5byb87cfMzS696oJm3oplwT49jCU1tkOeLkJ2QDWmLB+lx5niIjCKMY25Z4uSfr04FEWK2sCzl5EC7zZYkgav8AW01+SljSsGxo7aHErAXhE+OP6xw7q0vVLXje2pij/j8lHvpw9KN+gyX4Vp62VUy3G1ymBrxySQni1G2kUBqMUNtFZ98udy0F0ahr2fphG+zR5uZs8Q4ruQ0/x59d1+ktCJj6b/qlxK950WMLYwA5/9D/EQnzYQqvYyWgeCpIRTHkAD/EBlopvoQLaBLlgJgzEn5F1K1i/9UbEVz5nwg9IlsV7waMdCEpWh48mSSKiA9/Nge9tgKEp3fjm3Bz/b0+qr7ay1V9h3xFZHRMs37v+eb/YG5zZkdlg2DpF7MUSuY+0JIj6TYYx29KGUHULgPzhZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(36860700001)(81166007)(86362001)(40460700003)(7696005)(36756003)(6916009)(316002)(6666004)(82310400005)(54906003)(8936002)(70206006)(70586007)(4326008)(26005)(8676002)(2906002)(508600001)(16526019)(47076005)(2616005)(1076003)(426003)(186003)(336012)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 22:50:20.0548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7388454-886b-41e1-58e1-08da48d81963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Mukul.Joshi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make MES/RS64 CP enablement and MES scheduler/MES KIQ versions available
through sysfs.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 02efae4f5549..51c8a285baaf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -571,6 +571,14 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 				      dev->gpu->sdma_fw_version);
 		sysfs_show_64bit_prop(buffer, offs, "unique_id",
 				      dev->gpu->adev->unique_id);
+		sysfs_show_32bit_prop(buffer, offs, "mes_enabled",
+				      (uint32_t)dev->gpu->adev->enable_mes);
+		sysfs_show_32bit_prop(buffer, offs, "rs64_cp_enabled",
+				      (uint32_t)dev->gpu->adev->gfx.rs64_enable);
+		sysfs_show_32bit_prop(buffer, offs, "mes_sched_version",
+				      dev->gpu->adev->mes.sched_version);
+		sysfs_show_32bit_prop(buffer, offs, "mes_kiq_version",
+				      dev->gpu->adev->mes.kiq_version);
 
 	}
 
-- 
2.25.1


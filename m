Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CCBC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A269810E3EF;
	Mon, 27 Mar 2023 19:30:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8DFE10E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKEFmCh7dQRcWgIteBzqa9YgAqxw67X2oqzAnIdfG/vTWkrxKCXOvVGY428kiAwOmuTLdbg8v4NMeaq/SvZpH5jgtYGOXZz1p7sThAKiT73EDsraTacPGOCSf7tFL9Dzs0qfqqaagkHDQfHqG11ARc8xrLwR49za6EHfKabBNwMRSfGNKNgR82iNB9TlKwlS8SOPjWiDIR8cTvvJ95bAAcBUzDNDNrg+tfE+AWSGCNUJyphgARuE6RLKZrt5JtWnswfO0tDtnhnharWC9mvfPRxUIideHjX3aQbwuSNUXXhHjtNrc+FCQ7fzGH2/6uD+mnLvbpHsSIWt52I1T+FqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWjriTXdjp+iFcNHivMiilJZKd256jiQFUBQa2tgwJk=;
 b=RCBPc0sESbKWRNpK1PyzAOyDOzAWtYNfq3iFaEqdxc4MT7Y7FvHoniWW7Y7E0PeCAGvnEYZfWMuyCAu4WQ842pwPiFsiRwJBdx1I0PN7RrdoRNVi4mWGR5cNDcbWdPqan9qIq4CmQVOgXSq/S4ycK2TlwsQW7QtdQSkx+DB98vUaklsQS0CudkBmJ0O7nAgiQ2REKbYgzzvply4rABa7OE4b6Rb+1uKuwWNO5scIPgBziHlFUKiwvp1sQDztr8aDOFVYaI6duYDb8xxVufT64f610nydNI/+ChArYpUdbyyOO/a1Hszo2VwWCLrjD99RUPEmA/ftOVx5WLe0fVvSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWjriTXdjp+iFcNHivMiilJZKd256jiQFUBQa2tgwJk=;
 b=dBto0ENIn+drS64RwV6mLHvMopPJN2OMz29U/DF98q/u/kHwp49g/IIaPLMuegGReem2gZJq7NkjOG1KKQbTrJyk6TM1hdPOymZmf5/jaqULa2OBERPL2kXbE9OqhXrYFksrFvwpXSsYxEsFXmHyRYspRqDgGRZQX1YmcRiFd2w=
Received: from DS7PR05CA0012.namprd05.prod.outlook.com (2603:10b6:5:3b9::17)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:30:17 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::36) by DS7PR05CA0012.outlook.office365.com
 (2603:10b6:5:3b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.17 via Frontend
 Transport; Mon, 27 Mar 2023 19:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.32 via Frontend Transport; Mon, 27 Mar 2023 19:30:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:30:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/10] drm/amdkfd: Set TG_CHUNK_SIZE for GC 9.4.3
Date: Mon, 27 Mar 2023 15:29:47 -0400
Message-ID: <20230327192953.7756-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327192953.7756-1-alexander.deucher@amd.com>
References: <20230327192953.7756-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: a008ac50-14c9-4ef0-88ea-08db2ef9b217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ir/Btdlr/o3159yQTtRcCVGRJYMZL6WGSLr9SLbm+UljxWFHo/rqujdk0S1LfO/T3Q3qEH6tgtr4Aum6OKQnwfDfPo7JW77f93eZi1BwTWQ2lhxCjmVGtE0mGSvQdMog8fV45y5J5UHFon97XNMABYT8SeknsIu1FpHWNncrAzgqq4+3GMs0L6MndVtkBYog+F1D45GsQtR4Y3S83SoLRANGgIw/BqcJWTpLTidJWcvkj+lOiPwnHArVtXSv3ITF8fnyN3kvHMyDqjj7wNSU2XemRyjb9Si2rB6AJAHe6beBXRGqMBBJ6mXMsgaD/TlCQCaAk9t7RIAUUBuq4HgzTXr/EHMWYo1JRMXsex0aVV/P6zkOEysb+dmJU1N1/lT/9pYdb7bPjI5us8IyyEvDjMxkoDIL5n+nQo0V2Y3z4iLeeDVUAKX/8sTzug5VbTsvpmJBT8Q1oD8psXX+oAwTXFL5CYW5Ucu5TLjSH7BPHvZzPwum7T5uRH+Zu5v24zpDeTgBEoIdjGtu0SN70BQtjbyWwpaZ0Yprsev1HUqrmseaPPxPeeEEkrmUyDm7l73tRpqLtiL9Wb4pprYZQh67iNy4bDOgJNhJdoglJCSNbHNATYErERoaP3CWjvQ9QOJY7Ze9fk7jtyEc8WVIxXHn1FoA8K5JBF1ggAfLvyzCaebRMLYVfgBqNiJGL4j9LALm3ybcVbrIqwOntJUshRV/9vaMif/M0EJTfoPUHp2mLxw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(7696005)(6666004)(478600001)(316002)(16526019)(54906003)(26005)(186003)(336012)(8936002)(5660300002)(2616005)(41300700001)(81166007)(47076005)(426003)(2906002)(82740400003)(1076003)(36860700001)(40480700001)(356005)(4326008)(70586007)(70206006)(6916009)(8676002)(82310400005)(86362001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:30:17.1584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a008ac50-14c9-4ef0-88ea-08db2ef9b217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Sean Keely <Sean.Keely@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amber Lin <Amber.Lin@amd.com>

On GC 9.4.3, DW 41 in MQD is repurposed as compute_tg_chunk_size
for cooperative dispatch. When it's a AQL queue, set compute_tg_chunk_size
as 1 to spread work groups evenly among XCCs. If it's PM4 queue, unset
compute_tg_chunk_size to disable cooperative mode.

v3: set compute_tg_chunk_size as 1 instead of #CUs per XCC
v2: set compute_tg_chunk_size as #CUs per XCC instead of total wave
slots per XCC

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Sean Keely <Sean.Keely@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 0778e587a2d6..4dfae19714ab 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -135,6 +135,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 {
 	uint64_t addr;
 	struct v9_mqd *m;
+	struct amdgpu_device *adev = (struct amdgpu_device *)mm->dev->adev;
 
 	m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
 	addr = mqd_mem_obj->gpu_addr;
@@ -167,6 +168,20 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	if (q->format == KFD_QUEUE_FORMAT_AQL) {
 		m->cp_hqd_aql_control =
 			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
+			/* On GC 9.4.3, DW 41 is re-purposed as
+			 * compute_tg_chunk_size.
+			 * TODO: review this setting when active CUs in the
+			 * partition play a role
+			 */
+			m->compute_static_thread_mgmt_se6 = 1;
+		}
+	} else {
+		/* PM4 queue */
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
+			m->compute_static_thread_mgmt_se6 = 0;
+			/* TODO: program pm4_target_xcc */
+		}
 	}
 
 	if (q->tba_addr) {
-- 
2.39.2


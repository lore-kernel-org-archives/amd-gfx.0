Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA981C7EE24
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59CED10E539;
	Wed, 10 May 2023 21:24:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B91710E531
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER9Fe1c4VdmHhkwimnYFes+eRatluLgg04DTx4KLpneZOEhVdeDzBZqySVF5XNR+i9kQH8T79OqF7Z+oM2xsCrPYNlrsmRlvXXgKS/nVoLGDZ+VaSDR+2pfy8QhVy0jrYn0B19RABtkk/Pjv1+QJZdcN7KOe04KPFb2dNqLOCKKGMbs+yef8Vo0nPh95xQjp/m/XN/vX7CBxymOd0rnHEBV98qlqYzJwCk58rb5PAM0Q8FU3BDszDRDDUPA4VYh8MjEVFKJ+ruT/6hr4yUj31GODfiVP5bIMJD3mMYKWzHhWuk4KB529iIVrAtE6UnHPS/0ug+xSuef+XLfr8siTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgKs4kw5QJwVvheP5fAnmAcupQx8TuQ9wteXQBC0EWc=;
 b=LC58Kp+zXbnwjXsEqxNwC0cNSdfccBN87v9MAzVjy1yjgRtImgdx0JnYp0VjKk0+sOVKImCw+gQE13TWRQ/lSTNNOeSAl2ApojTI4kr261gOsXTFb6sLau/6og5Wrw9SY2K/wwcWo5kdxfirCucboJYzrKg42FtIxj6ji1SA83ku+Afda9+F7s8C9US7j7StP4yhTeMLywFjA1ek7ZH+lmogpJw/znH4ZpdblXnm2XQSREYYi/bwUG8oV9z31JKOzK1LPz5TDzPJt2p5WfbyqHKOWl0/ysgr3RbL0W9jeQ+o8+aTSx7IR0wrCOBansb/DLo4EmOB3LjVO6VwTRXMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgKs4kw5QJwVvheP5fAnmAcupQx8TuQ9wteXQBC0EWc=;
 b=zvDKjLUEodG/hM1/cmIXKV/Ww8fU1qxZ0YPJQKNh+jhH76DHBUzhzlBypTG4crnSpzdokcS96WVwDBkY9vH9w98GuOiEl6s4ULH1qpptdvdBPnnUqK+bwr3bc+6nztxnEYjGf9UDKxtxDwOu3U8SN4XN70TeZmncEz+z8j3BaU4=
Received: from MW4PR03CA0067.namprd03.prod.outlook.com (2603:10b6:303:b6::12)
 by CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 21:23:55 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::c4) by MW4PR03CA0067.outlook.office365.com
 (2603:10b6:303:b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/29] drm/amdkfd: Store drm node minor number for kfd nodes
Date: Wed, 10 May 2023 17:23:15 -0400
Message-ID: <20230510212333.2071373-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|CH2PR12MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: 868a8fd7-aa42-48ea-ef5d-08db519cdc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mm9ULwVMG2he28nPbaSt9oxTSzOXlqnKclNIAkR8swffe+pxCHwGC9KmX7MGDtuxqzxBhvqce26dZs69QnWPhOAZEH+vqlTrqVdnUfndSZfe+dndp6aSmOGKmhI8fpmNE0JPmMrPlcVr99I0XRNmtK3gf32dqJij+2bj9rdaktV2pbu/iaVywBQ4cH/OaKRJcZ6wBDMcXihdP5WqbkPAba5OM4YrWA0KaQ5Ik6cp+XulGHJqBOLkWfHpgtQONMsdU9dMc37n4i0UZyOm+nOZ1LqLNkOHJdVMu2rSndwQYELnzQaGYyCJFyKsw9/UTqQQgfZfgfbPZnCfrQWPIJ0kaAJ07CiJ21TNMU+gHMAhR0T29TbQoRlb4d+FwktJ+8XHIz4IXv3Y9pdqIzMrPs+zJfyIgjIBtQ8W0l5YKLG2CSIe07KVtuXzy1qZAY9wum1HVIBSZCP7lXjyyWjQ5Matxz2tsp4tmIwZXzVFkLqtW6lFFqvOQy/Yj3I0oRzRRQKsW1gI0WwPs6MB2fFxKRM7BooLE9RQ4+jlKgWNbNFjPO+a0eCFRBLFtru+SQBd/t+bgt62HRVNoWSoeS4z4fn18qCHOHT5HJFyMOvfNC+r9BcJbG4nbNUPJjcmSplnxLDFXSQYb0mqCw5C/7wPde/nXgFAM1KqFKw64swqktIN0pv3vYHkViG9XLunChJO0sU84Pjyv5TDRhkoDwTM02j/hOH1CbTDmHAff8eF4RGw0XW0VfAS0DCXJ8bEhv6vReXq7fLmlOBjFDXyzkGWXr4egg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(316002)(40460700003)(336012)(426003)(2906002)(2616005)(4326008)(47076005)(6666004)(83380400001)(36860700001)(7696005)(70586007)(70206006)(478600001)(41300700001)(8676002)(26005)(16526019)(186003)(5660300002)(8936002)(6916009)(1076003)(54906003)(40480700001)(82740400003)(82310400005)(86362001)(81166007)(36756003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:55.2568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868a8fd7-aa42-48ea-ef5d-08db519cdc32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

From KFD topology, application will find kfd node with the corresponding
drm device node minor number, for example if partition drm node starts
from /dev/dri/renderD129, then KFD node 0 with store drm node minor
number 129. Application will open drm node /dev/dri/renderD129 to create
amdgpu vm for kfd node 0 with the correct vm->mem_id to indicate the
memory partition.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 6d6243b978e1..a8e25aecf839 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1942,8 +1942,12 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->adev);
 	dev->node_props.max_engine_clk_ccompute =
 		cpufreq_quick_get_max(0) / 1000;
-	dev->node_props.drm_render_minor =
-		gpu->kfd->shared_resources.drm_render_minor;
+
+	if (gpu->xcp)
+		dev->node_props.drm_render_minor = gpu->xcp->ddev->render->index;
+	else
+		dev->node_props.drm_render_minor =
+				gpu->kfd->shared_resources.drm_render_minor;
 
 	dev->node_props.hive_id = gpu->kfd->hive_id;
 	dev->node_props.num_sdma_engines = kfd_get_num_sdma_engines(gpu);
-- 
2.40.1


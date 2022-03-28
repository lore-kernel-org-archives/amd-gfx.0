Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6C3C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43D910E443;
	Mon, 28 Mar 2022 13:07:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28BD10E64F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6pBevioSfX9Mh2eU3g/KrLpvxtpc2W438X5SvQanhhyYlhl006i2W47m5KYD46hSLR0w1xXahjZwywNeguIiygofgjpit+EdHsn5er1z8PDQagA/GCmCwVulm1H7R0y7mmy+OpxnejRuN6f5Al7e8OcBSIOocRBUEYMw96JPJVzXBQph1BxsGkEdN/bFrnTxEQjlh5U1Xv1QsmjdVMGHfCKWCtob1HWwz0GZ2ZHicAgZG5yE+WdoJMEcpkEqDQVDGBYu289OUBd2kSXakyhpa915LlXNiNMiRMa1IkZqtCFq8PvSApegJdQKh203CwtFABd+D0DjKWuBhBdLDqUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyx5f9GcqzYWfY309a8tHvwkHk4MhS+floSLoukQNAA=;
 b=DM1QxKgwlH03pvIurnlPTdjiWneAy9IxjM34hP+pEy0lVj35Iz/Cw90jTlTN1Iyc6I3hapzOhl9Txpu3txxd7hOWgP2u8LwUO46hk4l3JfhXFPUXK19Vr1vVTPRd2iejixbTeAA9s77e72diHfoTYk5/ne7EZxjpVR+g2OL3mM6Q3Ei8uXxHt8XcNw2QZRRE2MhaxYQ+vwlC7zA1+UYPVYLqSJj2o3r/bik/nhqCkNfewRpvsVja/mI2v+MzEsyIUEKErhsC9vTkid/rclW/jHpd+/hXihATOYb6OdwviCTOZqZfZsVQ/4oGVIpfDl5z8uERChfjZEHp1c1GSwtz9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyx5f9GcqzYWfY309a8tHvwkHk4MhS+floSLoukQNAA=;
 b=Sb8cDrWx8S1XInfvoZQxL+d3zvD6xBoLr25i10A9z2Xdt4ThmIWXSTYCgE4mg+YG/XcJwSoABHmXMuRLDlvylvIUHuzynit2cXdNZwhM72ubaIuR+KSlqCAjU3fKnZ24p1l2BFrdV+07ANPoG5Rjs5j7GuQ9MO/GbdIppfaFRs4=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by DM5PR12MB1625.namprd12.prod.outlook.com (2603:10b6:4:b::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.22; Mon, 28 Mar 2022 13:07:32 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::c7) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 13:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 13:07:31 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 08:07:30 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdkfd: Use atomic64_t type for pdd->tlb_seq
Date: Mon, 28 Mar 2022 09:07:00 -0400
Message-ID: <20220328130700.29642-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328130700.29642-1-Philip.Yang@amd.com>
References: <20220328130700.29642-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dc2dfea-92da-4518-4640-08da10bbeb32
X-MS-TrafficTypeDiagnostic: DM5PR12MB1625:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB162500D1A8BA5F5899281468E61D9@DM5PR12MB1625.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAVwDZ3mLJ45wIUIr/Qk/xK4PH6SF8NmFYcxMrW2sYzPaRPbZMauu3e3NxJr0eyDTOBBlcG5uwlkDR8qoeKtnRZxc6/kZ9w7AWbZ4WPVDKtq+r7xln16O8Ut7ePwtEqkMQnHD/iK32+YIvH/QwKqv82VR7xT+1FL9wiIdOMvicW0V05jzrxyi8KvJasL1ckVqiFU4rmc3rsSFkZXMsKIi4wGIaPnNOvxflbBMujjrQTJScu4tkf+VJMk+/i619o82dZLunWIHvUMEfqD59zdbZ7h/ONO+xHAmjbtp3GQNaEHAe00rwGjvN7JHeUZppN2DkHfj5ImQJd4I1SmAkJmB6LklPus4qboB/s9dwMne3HL6ZsOk3GY+I/n0THUjpZ+ojp4NTcpTvGL+DfeoWVSeYiilghsGuiqMFPO+oVLyaxEKtggXg8dJZ0ImgY31cZp7NWYVKKyCnrYXO11hvpnJMM0Tixz1RB1Izsh6WHnJZTACFCetDykZWf/PbMQEyJt1aeBNJRmFkKBmoLUH7fuxOr+P8Vvi3T0lRPF7d0rs8TSwnny6m3GH0W7RunuwC4AV8pPvS20/0co/RF3RbjarDH3A6fqQWPR3BjcdGR++AgRAA6CZaxE5jy+zt3MX8/HuL3oA6b7CO31Rm92GqP+sDt31+RKfm38PJkXNt3aos0v7DW1UlcYJH5nDQRUSWw/CywTECwayTWPOEJqw311lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(7696005)(1076003)(36860700001)(2906002)(36756003)(86362001)(70206006)(70586007)(4326008)(40460700003)(54906003)(8676002)(6916009)(186003)(82310400004)(5660300002)(508600001)(426003)(336012)(47076005)(6666004)(356005)(83380400001)(81166007)(16526019)(2616005)(26005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:07:31.6434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc2dfea-92da-4518-4640-08da10bbeb32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To support multi-thread update page table.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 945982a5d688..e1b7e6afa920 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -705,7 +705,7 @@ struct kfd_process_device {
 	/* VM context for GPUVM allocations */
 	struct file *drm_file;
 	void *drm_priv;
-	uint64_t tlb_seq;
+	atomic64_t tlb_seq;
 
 	/* GPUVM allocations storage */
 	struct idr alloc_idr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ac8123c1ee8f..43ed8ec1f975 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1560,7 +1560,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 		return ret;
 	}
 	pdd->drm_priv = drm_file->private_data;
-	pdd->tlb_seq = 0;
+	atomic64_set(&pdd->tlb_seq, 0);
 
 	ret = kfd_process_device_reserve_ib_mem(pdd);
 	if (ret)
@@ -1954,10 +1954,10 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
 	struct kfd_dev *dev = pdd->dev;
 
-	if (pdd->tlb_seq == tlb_seq)
+	if (atomic64_read(&pdd->tlb_seq) == tlb_seq)
 		return;
 
-	pdd->tlb_seq = tlb_seq;
+	atomic64_set(&pdd->tlb_seq, tlb_seq);
 	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		/* Nothing to flush until a VMID is assigned, which
 		 * only happens when the first queue is created.
-- 
2.35.1


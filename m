Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DC5C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBE210E6E0;
	Mon, 27 Mar 2023 19:30:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A819F10E6D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+NyhlL4Owp3CF0smpGnqb4XTx2n4Oy4ABVxFfeOHbNPfd5QQJv00ZmSHxoBB0ncSRzkAMgsI0dfLLSTP3Oyulf9ZNb/xwqCR6xgTTIl/0h4at+5xQwf48eMUcySLUbCW5X0ndKSvf7LqQ/fTHiWWbjJ6R+ujsBXoFyXTPvW195NvV7b0ZtdO95LI6FKsASNPodJAyq6mvSlHX/WraUmzNBX/lpRP3yANzAewZPvPHY7zr194fycyMchzDJP/jVnO9uXbZGhXut14S3a9wdka2djnJPI0AgXD7K9v4DCDdbWwhjyNfoaOB5Q+iQaYpsVfNa2uJfv4l4SH4Dh2v8p7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GByOF4NU+WQCAKcWX27p7FES6DWRJnOeuqLCaCbwFA=;
 b=FEFR5cRH5owY/tv1ZO0XUw/tfeNznCxH2/3ULWMUu/urz8GqOymuW/hlAR/akXvm83DmcVxj4dqMcXCaawbYtfoFluoXpiDUcQklk15yrTJMVzho0NzTQMsT9cjh7+3yVTcky+TpPLEzJCWgvW/Mw2hd4WESFc9FpcXBwSs/u4HhNm0LAcQwlIt2AJckmvVDJYBjuiNtZhwbfrLd08LIKBJUM4TjrTeRxTSeO1hfUPD6Os3sM/xed7eNYlPLFGCwX9IdDP+znBnD6ivVmj8vJJij3zyPYM+bGLhPdlX25yjKMNbCj4FP6qf7IWB7D13xHE8rC12PrnDs9I/aplmMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GByOF4NU+WQCAKcWX27p7FES6DWRJnOeuqLCaCbwFA=;
 b=GekIkqSBubXf2dnEMjNvZqu41h5BoSnYvIcDYjSMolPWXqCUrJiZ5AHHNyRrLoLMfpK6c83oEKoSPPjFD6XpapTnuu5B+eSQbO9Rwgmy4V7dHo7Jduq02j1oZg/Vfq+id62VZD5FwHqkYv38Sez+g/oAl8TAOFI1bh+/TBc2nWc=
Received: from DS7PR05CA0009.namprd05.prod.outlook.com (2603:10b6:5:3b9::14)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 19:30:19 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::81) by DS7PR05CA0009.outlook.office365.com
 (2603:10b6:5:3b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.32 via Frontend Transport; Mon, 27 Mar 2023 19:30:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:30:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/10] drm/amdkfd: Enable HW_UPDATE_RPTR on GC 9.4.3
Date: Mon, 27 Mar 2023 15:29:49 -0400
Message-ID: <20230327192953.7756-6-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: db0e0f05-1214-44f3-9c97-08db2ef9b354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pd7Ygdch+3A2RkmgVV5CaoXJo6N23D1b9V2/xFTexQkxzo+fFu3u4ZWHOmmoQJHtOwP32aMRZ2B3cxIKj2WeJE2cb9e6W6qEp0GE2p6sYSAwNlivymhl5fQjbjHey8Gitl29ELJ98fairvkvL6cnkK8gzQQBqph4znRPzS/g2Vjg5DDzerXeCmOu3dDJg68lwPPIXnzNv6UPjozsurOSjSWPeO8U+UR9kxnThaHH3vhKX4MxEz+LthypwtjbIdPEYzLYEhi1+z4LfAyVda4g1NjY1ykge+ai6ihM5oos4qFe7heBP6U+FpVHa/Z8RWfOsVeQl3FRYJftG4a1d4JOXvPbTYb8c/eU6nsd4+d2Cr/Uh0GMlXN1DQXDm63KotcnV9KYkepiwW3S9M+pBCwqba+JsHIHqCNR8qTXPPgLIk7+qAiG/PJn6R73oWy8Kg/+7ItgJLRzLhrGDN7xfMNLygHUPirHc5t+5f9/lusuRlBunly+kSQTqerREQZcS5OM6bU6DwzSch6R3Xyn0/119TbuX2X+UcJJk10P0m0O15PwpLxLq/yfQzo/4v2g/Bv5J8ebfKChcTsTaCDIPrUeYhTvLAtycCtArph5sqLnfXq9hxhcW7S2wpwosjUi2fhRhFhBBaqLWLdylyrBpJrr0Jl2ovBiPa+jnQeCLIl5b2bIHKR75CHS4lYEwzqE4zGOR7VfVVMqZW5sO81q1zv1s5oWJxydyL9EzEhOVeulImw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(356005)(70586007)(16526019)(316002)(336012)(2906002)(82310400005)(86362001)(6916009)(36756003)(8936002)(186003)(82740400003)(5660300002)(41300700001)(36860700001)(1076003)(4326008)(83380400001)(70206006)(7696005)(54906003)(478600001)(2616005)(40460700003)(8676002)(26005)(47076005)(426003)(40480700001)(81166007)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:30:19.2520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0e0f05-1214-44f3-9c97-08db2ef9b354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amber Lin <Amber.Lin@amd.com>

GC 9.4.3 uses the hardware to update AQL queues read pointer, so
remove CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK flag from MQD if it's
GC 9.4.3, and keep it for other existing gfx9 ASICs.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 4dfae19714ab..c5e29fdad1e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -224,6 +224,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q,
 			struct mqd_update_info *minfo)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)mm->dev->adev;
 	struct v9_mqd *m;
 
 	m = get_mqd(mqd);
@@ -269,10 +270,13 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_vmid = q->vmid;
 
 	if (q->format == KFD_QUEUE_FORMAT_AQL) {
-		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
+		m->cp_hqd_pq_control |=
 				2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
 				1 << CP_HQD_PQ_CONTROL__QUEUE_FULL_EN__SHIFT |
 				1 << CP_HQD_PQ_CONTROL__WPP_CLAMP_EN__SHIFT;
+		if (adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 4, 3))
+			 m->cp_hqd_pq_control |=
+				 CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK;
 		m->cp_hqd_pq_doorbell_control |= 1 <<
 			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_BIF_DROP__SHIFT;
 	}
-- 
2.39.2


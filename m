Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49537C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B8C10E84A;
	Thu,  5 May 2022 20:08:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51DE010E7E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkwwDkw2IDoCjdWKbrNGFFNSQFyIgNfaFPKi75FOqA5a7x/G36OtK6VszaJ+1igcY9zMEyp3RtLxzNOUfcD5gCPOi/Z7msMcsXr2nWG2Zu39S3tU8fTDXBFE2DOErRYmAdL+Zk6vM9gLdwtQSZuf7HRHu22pWT81X/ZzniaCzhYhZGHZI4QpolYRnL3XZ4zGwwb69CCnKUfGRM6h906MAUmmASYJM6kb2U1geVwgRIrL/cssV/kOXuPtDXZ4DTu4mkX7K5FKhX+P2EcpWyqf7NxYGbDyY/VVTG1vYq8RfAkXczrakESEnKkZy8IfG9IWTZ6kGwqReZvCLYZs4HVjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnzFdQW2EcXu7QnmxdtjXMYOtG3BkqMq+bV+4DbCcNQ=;
 b=hBtIXjHZdub27JDkqDWWcIqL/89fx+RRA/Ii3Py7Xqt37aLY/u4mP2O1rSAjfzV8kCwu7efX1vcsr+8jnqXe5ItGrGDOsDokMLYW+4+vJgIPoo8iu1CAu1niw+Ej+/SjgBTPq8QNK5G1ffN68BUfcCMe9pJ/VpWhxcjiQBexm18aSE7Vh8AdL93NriYBTWbGVLhihVDsJ1FY+jHTCfZXKCBTNYMtuTKUQH84GDwu/2DEA+DgNNQphj2zAVRM1fNbGYnP3jGy4XuXRVUOCL40Z1KV8eTf22i0Aqjwc2qQq22cXggltJeSxbJEn12MyAEGTyC+Gad2pU/Tl8VAJHNFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnzFdQW2EcXu7QnmxdtjXMYOtG3BkqMq+bV+4DbCcNQ=;
 b=seyY4rk1zE6yP9pIxNP7uZSIrub8fmfbk7AmgmVGq0gTo8/ecJmhsw49sMTHYyYdvSP0mBup7jQVmFFZaNYXsuNzqUDX1meqJIaVxGlS8H/LWbMeoBa4ZvRoc//MjpUH398/LAr3NLRVu6ZznJg+aNpCBtvWXcKETnTwekqG/M8=
Received: from DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) by
 CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.14; Thu, 5 May 2022 20:08:37 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::9) by DM6PR06CA0064.outlook.office365.com
 (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Thu, 5 May 2022 20:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Update event_interrupt_isr_v11 return
Date: Thu, 5 May 2022 16:07:48 -0400
Message-ID: <20220505200750.1293725-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea849e7d-f96e-4a62-8eac-08da2ed30aa7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5369:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5369E8E31DBA23CE681C5FB3F7C29@CH0PR12MB5369.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lu7JCFsJJrZZ07zX/MUtQEYTQhzc0KSwEvbJGzQFuWGMqsruJeiuLmy56R5pCT06bgt12BX/eNETi9n+NNDJ0UKomajXrNx2TzQE6dWEQWgw1zrutzOD2L8VSZLcKlTGAXXu2H91SUP/LhSx7IdaB8PHgjajUbFRj8yJfN80pgW8amWflZtD6j5EWr1bpAOlHRPnw0qjYSOtVKECTmM5AyS750qvFkI/F+X5uSov+j2Lt5r0vubUL2/nPikUMJ7mxZDo7Gom4z6g9lWdrGDR+FUHzmxkxEJQaCwX3iMg8vf9WD/aK7tZG6C5FmbT7TlXCtaXTJxBPfDCzCb25dEUHVRXXWsoEVFEoQwRob1u1lyECH/dKvw5jBN5NepUWMTtnvCRRmGEL7kmoL+2NCH7hC9opOSm99K4vFm7cAFDWHHu5fe/UPyMcBiOGzTdE+uVnJMAu4urTNaYW56PwGNjCwRhCuLgXoZehCjE1wVLT5ssoMOPf+WdIz1f3LR+spBSXHFqbL5VVtEAaLfHd7vfxBrdX2bNKG8qrnuCPV47dQZHix5NaxT9yuE2JE7jlnKDOT8gA5e7nASDNAXrDRr4YjHageoUiz3EvKD0Y5SKp8Xbfhm/w1c9lHzMnONFViKlTXy+za5Ajnp36bEf3Oat7jPw+KtDE29V2xNqgb0kC14CC1FWAq104yaGjt8Yq5PP4tbGZCYssRGEyYrXvnAHBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(70586007)(70206006)(83380400001)(36860700001)(4326008)(7696005)(26005)(336012)(508600001)(426003)(47076005)(316002)(6916009)(16526019)(2616005)(186003)(2906002)(1076003)(54906003)(36756003)(82310400005)(40460700003)(86362001)(81166007)(8936002)(356005)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:37.6983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea849e7d-f96e-4a62-8eac-08da2ed30aa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Graham Sider <Graham.Sider@amd.com>

Add amdgpu_no_queue_eviction_on_vm_fault condition to
event_interrupt_isr_v11 return. If no queue eviction on vm fault
specified, function should return false for client/source ids specifying
vm fault.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index c3919aaa76e6..2bb8041565f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -267,10 +267,11 @@ static bool event_interrupt_isr_v11(struct kfd_dev *dev,
 		source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG ||
 		source_id == SOC15_INTSRC_CP_BAD_OPCODE ||
 		source_id == SOC21_INTSRC_SDMA_TRAP ||
-		client_id == SOC21_IH_CLIENTID_VMC ||
-		((client_id == SOC21_IH_CLIENTID_GFX) &&
-		 (source_id == UTCL2_1_0__SRCID__FAULT)) /*||
-		   KFD_IRQ_IS_FENCE(client_id, source_id)*/;
+		/* KFD_IRQ_IS_FENCE(client_id, source_id) || */
+		(((client_id == SOC21_IH_CLIENTID_VMC) ||
+		 ((client_id == SOC21_IH_CLIENTID_GFX) &&
+		  (source_id == UTCL2_1_0__SRCID__FAULT))) &&
+		  !amdgpu_no_queue_eviction_on_vm_fault);
 }
 
 static void event_interrupt_wq_v11(struct kfd_dev *dev,
-- 
2.35.1


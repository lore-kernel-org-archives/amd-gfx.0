Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D086BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 14:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9BC10ECBD;
	Thu, 17 Feb 2022 14:29:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21FB410E9AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 14:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2+VdPHAB356eNi9rVBjt3pFdZELTPiq2il0mILa1d+YCTNMFNw3UQCUDdRW40UkhickE5ifm8WlRhTTbQ0fdvYDm0ekeCEZk+yFd6V1RntNzQXTIbpsv1xPLU7ucdacIchzBxqptL0orjgkkrLD+3VKzpI+I9yyb128vH2OQf8vNzp5OWJdLkt+ghUWDOg4GUgg5JpXxbEy2u15kCy7hwjaHnMKMEMdfGq/2gt2/4WSzdhvQvm1KJQ2eIWaTQlV4Bsd8FZbwH5tpqbvWTMNTnX5F6Ur2cX3y7s8wK/OwGp9yyYZJOzIuo+40rCzjqXhrwpPHsevNCr+qJtgmW8v4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M75tG/EAnzgmlTORKeB/WIKa63Y2t1WdVV1JDqy3VlU=;
 b=CDudxRkyKpj9gQc/R2qquEF30ZHFxQf5Q/bDdRwNBZJSNDfk8IWRoLS7UOE3rI/uz2HkC7s3VfydZFa254FkDlXeVvAovcCNS/YrRIaxtPIct999G2o25XY9fvO3FbNEwVMs5dFaeAoMPQZshMl12JjZ9kV5+Jbv8hHjwaRyOEiBSjI/Hfk3Xb5ofoE3/P1TFnGWvLguITj36p6eAOk1pVG+yZPrxKbIPTzy0KCM8d/TVdrTwmgOj6xG3jjUMsbBSClqFMax0aBJs9olRRnA6RcO9Hu4FEiVR+AnbwkwXYLfUT700BZNtmr2ur/YqHiQhr7Rwm8KQkzVqG9VJXLm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M75tG/EAnzgmlTORKeB/WIKa63Y2t1WdVV1JDqy3VlU=;
 b=5In+JAjOKIh8qU+Jj/nEJqFy9lqYXEgEr10j4Y77Y+aL9mxMiex2VNsgB3y0xg1rW07rwgS3P4383wvR6nquSzQMMt6B/sQrbaRoD8QJVM6zxWKeWqxliGI4hnAvQ+X5MqSMD6Sbs3ZecNK51rFxYXIheXC5UFJX9kVMVYkh/TM=
Received: from BN9P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::29)
 by MW2PR12MB2473.namprd12.prod.outlook.com (2603:10b6:907:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 14:29:52 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::82) by BN9P220CA0024.outlook.office365.com
 (2603:10b6:408:13e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Thu, 17 Feb 2022 14:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 14:29:52 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 17 Feb 2022 08:29:49 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 2/2] drm/amdgpu: add reset register dump trace on GPU reset
Date: Thu, 17 Feb 2022 19:59:18 +0530
Message-ID: <20220217142918.3624-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217142918.3624-1-Amaranath.Somalapuram@amd.com>
References: <20220217142918.3624-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 747504c0-3610-4ba6-6edf-08d9f221f5e5
X-MS-TrafficTypeDiagnostic: MW2PR12MB2473:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2473338D036F5FF85787EE0FF8369@MW2PR12MB2473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hM0+7vHYfQXm3uU1T+rU3wha1deQWyl4batxMMR5052f4MKgAJhFkseNUQd008Yuv/oEEl3/TPeqfov3cttYyP/gY9qKn1pzPUA9u2ZT0bJWO87AH1GWqlboMiypV89/BACqmVbHuQ59UeqfU4q36o7sM84bJ7t2gHhbatnyEutj5KORYNU2XlfwoG0fn9hYRJUD6t5NLsDzvq0k8WPVsBcxYUd+BlHE48NHevtKiPbFhOG86HvZzJg1fRw6It0M4sWKKEUhGGTYsQMbkK634svb5eD5cMv/O+hQvjzlNxzQbWIZBSALVbQFkqm3rqCMdN89cu9Ua31/3B3qN1QgXjSw7CVIiB1Inx3xUMuA0MIltB1a1UeG+TuAey8KNV5Yg2qLUnRJ9bA0mYnhB4NqsaZITOtF4Q8ASyRNgghivBOeN2jWnjCAu6kAs6A1C4vpQaIVvJ3bQ3q2FXkbJMRaFKpnEvsk0vc6s17cNbfXutmml7pvu2wXxtYSN3GoT1C4RkddvI9wRBFo1d5J/nh0qtaAO07vyF98EaE/lAL/AA6+l94Sil/p2BDyanZHm/8wWzbbfnwfcAomzG5cFjuz/wVqAcH2O2gSU1wnos3ccL9DtPgH7Wh0cQiZyB6RfmLohVw2KJ8t5IpefED6E3NYWBtXRmYefGzhMpi1kDZwYxxlXV6q5PjXvNOODk4ZgXSs5O9w44jJT1lgQmvQbB5EmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(356005)(2616005)(426003)(316002)(81166007)(6916009)(26005)(70206006)(70586007)(186003)(336012)(16526019)(1076003)(4326008)(86362001)(2906002)(6666004)(8676002)(40460700003)(508600001)(36860700001)(54906003)(7696005)(82310400004)(8936002)(5660300002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:29:52.2151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747504c0-3610-4ba6-6edf-08d9f221f5e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2473
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dump the list of register values to trace event on GPU reset.

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e651b959141..25c38a4e13ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4534,6 +4534,19 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
+{
+	uint32_t reg_value;
+	int i;
+
+	for (i = 0; i < adev->num_regs; i++) {
+		reg_value = RREG32(adev->reset_dump_reg_list[i]);
+		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
+	}
+
+	return 0;
+}
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4544,6 +4557,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	/* Try reset handler method first */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 				    reset_list);
+	amdgpu_reset_reg_dumps(tmp_adev);
 	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -ENOSYS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d855cb53c7e0..b9637925e85c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -537,6 +537,22 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
 		      __entry->seqno)
 );
 
+TRACE_EVENT(amdgpu_reset_reg_dumps,
+	    TP_PROTO(uint32_t address, uint32_t value),
+	    TP_ARGS(address, value),
+	    TP_STRUCT__entry(
+			     __field(uint32_t, address)
+			     __field(uint32_t, value)
+			     ),
+	    TP_fast_assign(
+			   __entry->address = address;
+			   __entry->value = value;
+			   ),
+	    TP_printk("amdgpu register dump 0x%x: 0x%x",
+		      __entry->address,
+		      __entry->value)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.25.1


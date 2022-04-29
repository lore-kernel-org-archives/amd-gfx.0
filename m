Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E980C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F5710F108;
	Fri, 29 Apr 2022 17:46:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3931910F108
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eerHC2+2gh4BZZdd8t8/QRdqSvACc2BpyqiZPj4SrBWoaA0JJA/kStdcXKcW5AgqeTH65xBKtNtvWuxZw36p0+2ozIUO31KvOt3dZyC4aLdZTgyn4V1UniJjpvSQ9vcZxhbZBoSD0Va+W+7RI9kg9zFPYO9NbZEjb3ZWQuEoeBuzCGuX+gQTCRoJPGw6oqm3muEq3ZoMIANp54IeBYsUT4q/tUv3YekC/AGzacE7MagoJ9FoQoe/ypaRpllJ2atCgJQOB65jufJmH0EBnxq8UTPNLq9PwMfThEjU7kYUz3fF3iG8hod26eAtMbpYBMjMfkchXjtRL34LiS/GPcyOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca36cMBTqCdCJUESG739PvXRZGFxz80x/T704e0srXk=;
 b=Lxqy6RKr0szCRVI+f9Afj2mXim98oPmznokS24z06xmATKru4S2q0wmEGRhaC38PnyKR/gmQxmkULV2PydetUpyMhC7OLj4oBv6ZqwY1MSFwMlBGRUDnxzPdufITNajJhYkkTJCOIci/eJKar+cDUEnnIYfgtWLDxdPlUW+ClL39y6wYc05hutu2OJ3DKH84SH54Nee5jMIHfFfa9Cgce7kzjkxqGT8piu6LVPuBg60DufEtwXgev37aS75mxxFgNTCzmAz+FcJMzYXNPcwwrkHTZ9Y94PXIx8/ImpRjNz8lYg0Z+UxlZY2OhaOA3NsTrtzQU9OiQRPw+rpYN0rk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca36cMBTqCdCJUESG739PvXRZGFxz80x/T704e0srXk=;
 b=Q4+v4ZcRwBAhy3qOeZovsa2GNgruOyEcv88841dW7+7RnhU/o0sQQQvvryqhzQyzz4YGtBlS1+Rlskol7KxHF1dgTl2QASxcbr9Bq6uedbObZfvO2GQ5fDSI/LGf/gr0uGmJlqhq1lCyQjUFeJsMoE3KhMNTmG1xClioAe8vnps=
Received: from DM5PR08CA0056.namprd08.prod.outlook.com (2603:10b6:4:60::45) by
 CH2PR12MB5530.namprd12.prod.outlook.com (2603:10b6:610:35::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 17:46:38 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::70) by DM5PR08CA0056.outlook.office365.com
 (2603:10b6:4:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/73] drm/amdgpu: define MQD abstract layer for hw ip
Date: Fri, 29 Apr 2022 13:45:12 -0400
Message-ID: <20220429174624.459475-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a275e3-9448-4494-29b1-08da2a08363b
X-MS-TrafficTypeDiagnostic: CH2PR12MB5530:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55303EA393D3B8C967E8D1D1F7FC9@CH2PR12MB5530.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ff4MG5RynWR/IH/8zlWNakOMsFpPgSRsLAAYzTcf0B1RFRZiAvK8CX6xpGEHWCl7MASbkDKADjQHyNGQ8wI/8klN9dkqKhe3HJ9BlqNjT010d6fZGGV6WozkeWzvr0zmEPCd3alTLMYvW6e5Cs2ZE30H67EGvPMWE7se/mdWOIgRSQYwsmDEEjtRG1+iTtTOuqkSDkruYm3wZgsNeu1h5LP02A5OUBvkGChN3ISo8faUCf9IK4m25c4CboM9IPjQ0GTC7Uk7bcGfGbTGAVYiqSoPQVuygeHZvyJy7UlOmVYbFkjUq/lxr3sU1KOhLPAK80yaRZ0re3BFNTzRvhZdsn+weYhAG8LCd6EwrxCrC5JGjDpJNZF4Q0PXCCfMO3E9clsOISlNZqnkZ/g/kTAIds7EkOQsShABjgG6qAMX37jTZMmaEcdOc5KTi264XxWFXdJAbimLH0C9BChj2i/QRiTXG8Juir25cYHX00RW4ycJUFnnq97qEiTR3/7mCXJQOr+addJv7KjUxwwU+i7h7caF7S+SOGuwzXzD2foCaoI2qB2RQbPPuFIg69qW4szLTIA0OEK06pQkdLK/T81YSdfsWrHNxjYjVyDbvquKJ7L7QS57jl1eRaqMs3djM8/Q7apuVUnIHPBcRV1kbK9SHb7U580CR0PyhfKcAcMqMzS4a6VwdgHHDjInrnECtLsMyYm/CYNBszUzyK9O/aF0GQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(2906002)(508600001)(4326008)(8676002)(70586007)(70206006)(356005)(40460700003)(316002)(54906003)(5660300002)(36860700001)(81166007)(8936002)(26005)(86362001)(2616005)(36756003)(186003)(16526019)(1076003)(7696005)(47076005)(426003)(336012)(6916009)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:38.3360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a275e3-9448-4494-29b1-08da2a08363b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5530
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Define MQD abstract layer for hw ip, for the passing
mqd configuration not only from ring but more sources,
like user queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1a598e3247ca..2eed9479e854 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -720,6 +720,26 @@ struct ip_discovery_top;
 					  (rid == 0x01) || \
 					  (rid == 0x10))))
 
+struct amdgpu_mqd_prop {
+	uint64_t mqd_gpu_addr;
+	uint64_t hqd_base_gpu_addr;
+	uint64_t rptr_gpu_addr;
+	uint64_t wptr_gpu_addr;
+	uint32_t queue_size;
+	bool use_doorbell;
+	uint32_t doorbell_index;
+	uint64_t eop_gpu_addr;
+	uint32_t hqd_pipe_priority;
+	uint32_t hqd_queue_priority;
+	bool hqd_active;
+};
+
+struct amdgpu_mqd {
+	unsigned mqd_size;
+	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
+			struct amdgpu_mqd_prop *p);
+};
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 #define AMDGPU_PRODUCT_NAME_LEN 64
@@ -920,6 +940,7 @@ struct amdgpu_device {
 	/* mes */
 	bool                            enable_mes;
 	struct amdgpu_mes               mes;
+	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 
 	/* df */
 	struct amdgpu_df                df;
-- 
2.35.1


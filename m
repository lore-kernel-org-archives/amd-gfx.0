Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D11C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3712610F8C8;
	Fri, 29 Apr 2022 18:03:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE9510F8BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3yjmEuJpEK5FFJHh3t5L2yuYsS9ALy7ahhP9phZVyHMcdXDYmCqFehy6epGNTw+vQDLRTciqwLsQWS8LRMQ5pYKbgHcmrLkbB69LoTLNE1bjkSKcyRXMgwFjfflUwp7HEcsb4v3sfoyqAm90v/DKciINeHKaOj8pqeC28+UWgh+OzhJFbQYp0r5kDDLHv2ww2OnF8GNCeusdvyZz2/xCSoVKxXsUykrf14zwoWIALP0qWKOVYCPUsy/2p9rjT18Of6noni5+M0GLCBSR0j4BC2wKbCIifW+eDLkegUGZKQr0LKWXTqPFg0o+i9TVHxSH4B8eouf2vyBmITStOylBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52ulJ5RMgS/Es6n4q12mIPtr+sKeoZH4yZ6DVBdVc3Y=;
 b=U9VvHTXZV0Mlxcp9wmjIxCan9JCnm9qrI3NwHnqO4T+h3vHoLHV5iVmLt6OcMP0uRvsih9CLMQr8HY/le/BOw+UAYo0j1vzJl7vYPeVjPQlJ9w//h/6+66ecCcnZP3uySo7HPSAdH/c5tr8nB6XPehAzDFIa6h5k7LFZnBEwVantUtSqstwE5Tng0qar6nCdlOtPvEo5NOaH29ntzwHhJEoRcmMYDFuGjbf8igwk0D0dUNzwz9bYtLV+hTP9AImSFC8y4PTv+ksIRghS6nqXSy/2C+uTi/ZDTaJATrWBZt5DbcMBMYZTU+IpcgBwH0ywkEybMJHWFgEDWVrNk+uGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52ulJ5RMgS/Es6n4q12mIPtr+sKeoZH4yZ6DVBdVc3Y=;
 b=HHG548jnnpXiTsUiQdHKjfKNdgeBX7O/8QKz2r5NGbleoY3xvz7t6DbcG+My0y4JZsJUakr52kC2IRf4jMm/wP9gtysFzyePbUMs/c+pM4o6mBWooJ1yHkYRVVfCybTTlTO0O1ICgsRWNeeQlvy0NIIzVb4vtDeJlq2cmokolPw=
Received: from MW3PR06CA0025.namprd06.prod.outlook.com (2603:10b6:303:2a::30)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 18:02:56 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::bf) by MW3PR06CA0025.outlook.office365.com
 (2603:10b6:303:2a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/29] drm/amdgpu: enable GENERIC0_INT for gfx/compute pipes
Date: Fri, 29 Apr 2022 14:02:22 -0400
Message-ID: <20220429180226.536084-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d59c112-b68e-4a23-ea26-08da2a0a7d10
X-MS-TrafficTypeDiagnostic: DM4PR12MB6328:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6328F190024376A04476DD72F7FC9@DM4PR12MB6328.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTb4GuIhB39SZ9bz5gppiLb/cbNj0+t6HAz5ddBMdRXeRWCy078dtzp8J3eetZlns1yzIZjQhrM7gWtuIhTa/UqXYcY5Ltr3ou4NnuD6hqs6iEs564aa4fpPER7E1g4qYB2y/u4zrqR0WbpkuuJvyUaklMAWT+MV5/gUZrIAhwBFHAhvkE1IBfZ0fGzhh3NR3FRdvCqXknPT15cuMn+qFNFPIddHnNnmmvGXZSuiH8UPYoIR9PTA/LRqm0Sa8mOkBsEONwbMkNHoX2k9l2K9dob51wcjj/MUThqJLMU0NA50vCOde6dFFi6WQVpsbQs4lCCOoKhQPV2w4clT8Nmbn614ONhVtoaIeq6nxYgByNS+Hd+rCEF8dN4U6eTIj7HZDQMnnsjx0zGlotELTC+RKdJgf8Z6TQR5NQzwyfqGWVMt/p4FjBbMKNdnzzCTk7cnJXmcViUPYSGj38ZjpczCfsAKuR/9jIr1TmKSJdBTzjb3BP7eWwe+w8xnAHgRA3gJkxO+hQI1h8H/1Ti1qCnZFXAS2NkBlVXQ5RJgLCgw1Uka4qGR8TNesIOZPnzqD4SaOgZC/LMrb8Wl6OqTxd+GgIAUGO1Zxv+qorCeCje/yhHU15E8RAa8F/Vq189lDpjD5h6yU6typlweTFffPvGWOl9X9QDeJkrMKrg4WyodcEopCUsQkARsc4JeNI7X6qgCbCsfHdXBYHlHFH0TcbqRsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(40460700003)(7696005)(82310400005)(426003)(336012)(5660300002)(6666004)(86362001)(8936002)(70206006)(6916009)(508600001)(83380400001)(2906002)(316002)(16526019)(36756003)(47076005)(2616005)(186003)(36860700001)(1076003)(81166007)(356005)(54906003)(4326008)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:56.0771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d59c112-b68e-4a23-ea26-08da2a0a7d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

To generate an interrupt to RLC for accessing indirect
registers that CP can not access directly

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7a34802544c0..2f8fbe2651ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5689,12 +5689,16 @@ gfx_v11_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 		cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 0);
+		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+					    GENERIC0_INT_ENABLE, 0);
 		WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 1);
+		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+					    GENERIC0_INT_ENABLE, 1);
 		WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
 		break;
 	default:
@@ -5742,12 +5746,16 @@ static void gfx_v11_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
+		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+					     GENERIC0_INT_ENABLE, 0);
 		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
+		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+					     GENERIC0_INT_ENABLE, 1);
 		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
 		break;
 	default:
-- 
2.35.1


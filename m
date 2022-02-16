Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DFDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 09:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B430E10E62A;
	Wed, 16 Feb 2022 09:50:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD0110E62A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 09:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuj2QHgSA+tMVuAEsRBG3Lmmnzn8g8G3fCRjEeP/mL5fZTwpLlikblEl9CRC8q2sBgJ4p1GuCffWfjP6siQ+jlOuIHwQ4yJo2TmpbksawqfMJbhc7HXSnbYUH7Y3ZOmYpbTEQjoAmXOtVXi1e2d/6KvKPFs8RC3+rgKZP3zXnoYh+/x1mcDWGpodbD+E4/6DyeB0J4M2Xznw1lXRJnznqUWaVkzewtHpNE+LA6WF+nGtlIZ6euN8TidIk2ty6/+Ym5GONRak7cukuKEhcxAY80vjqeES0v2JJkvwx5aBbLUraY/vSt9u1p0nX+GxgrcaA1AaRWMtAmUvcEruBAdlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj40QR2E6ZUxqIwGlvZBtlp/G4Tn2p/RkBqLoeG89mQ=;
 b=c57+YxwoabGVsVe9qrCWwB3atcsPliZ980HRNOw6NjFZcHOeHYrOaMdj9pkaYm+J6EcLP1QHiaZtnbXqDpEWNy1ycK4PBh+4lSFDeVgXyEPVtIm53LV8A5pCLh4EA1KgNEqrHkmL6hW1zJHzacyrIpHcDL1lMO1z4+j4AN7DMZksF1o8ANxSggqQpJ7Q4OybVesn2H41V/qWD334qgl3J7Ux3O58X0knZxl/IcR+6/rsVo08ZkPmRh4g+BC/HcSZlOjuZeLWZBKRhfSPuaqOT+ppiIHIxlTV/XEjn3eegExzUT+xSU40r25YaJFi0NJZ3zcH1ODFDcUkCfQx9kzF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj40QR2E6ZUxqIwGlvZBtlp/G4Tn2p/RkBqLoeG89mQ=;
 b=Kkos528I/IJuIzaflzSdWhQK3HzUPW23P3ORsJCNQAVPyX6gIK2oUBx5mplI+X+dR8w2/Ialw9zKS0pX8w9JUXNUviwVz7JcrxzGFpHiHwJ/RVf/OFGjkNglGv+5gh1fcIWiBQm+Jo+Y51pZf02Isr2u+ZHmQB2YwvOpxFU4xds=
Received: from BN6PR20CA0056.namprd20.prod.outlook.com (2603:10b6:404:151::18)
 by DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 09:50:17 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::42) by BN6PR20CA0056.outlook.office365.com
 (2603:10b6:404:151::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13 via Frontend
 Transport; Wed, 16 Feb 2022 09:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 09:50:16 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 16 Feb 2022 03:50:14 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 2/2] drm/amdgpu: add reset register dump trace on GPU reset
Date: Wed, 16 Feb 2022 15:19:49 +0530
Message-ID: <20220216094949.3169-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f48197-634e-4b71-5281-08d9f131bc67
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0108:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0108648706ACF1F645022BC5F8359@DM5PR1201MB0108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P84A3zPg43zCZ05WjaT2BjRH1hw9BcTN7NTA92tuSRdIa8W12RSuQFVZfZs3G+dvHO5eiMQ+FXsHy+MEMvJffToKtTEyyU/2QPCDvzSuGdHDsJJG8bu5LJU3oNCXrPiNJiNMFBbbyv/J3uVVaAhEcIFDSzzCUyxCcf2Oi+pqSI19ZsNvNhmztMYtZDV25YkLTjQblh6zTVrAWhKfdytO0uiSutsGQQ7QcL2axGJUawT+q71lQOE+x2Iblyhn7fVF8HxgF9lCs8McsUmvQDPEr6ozLdnpZuG3oY2m1AiKMvkex9fRbrV1OFq6C7qaUpa/3NRkDhUng+Zr5rZS72fmzDF3+TKnFQj+Uh+maHrzj+1EgxVIEc45xFbIIcWDU5spWwY7+H5CImauWs8rBmMk5U9TzadOQYREFA7l17ft+GBkezClvJ7Ik9U/KFiSX9dlRfrZdFyJw70Nu5NBVXQVA2feQGnkIkmIFAosV0okVOSMqhlTJEfDAU2/O8jlANt3Ft0e0K5rpIqlziribjHyLdnAYXErUVnyUpyvEdHFUjUqenKkBn+u93GjsmZYGS4ikS34P4kCmWJlKegqZyWNLjs6ZyNLP8TAUHU2fq2IgBdHDp8Tfk89rCkJYP1SzEvcrhUGPfNiFLq8ByQtKgYbLDXF/p3SZ0OOHsykr5MWqdRt7CiAizxj/9a97GBOQ680VDIm8qiBctcEBQnlp/sawg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(8936002)(186003)(81166007)(70586007)(36860700001)(26005)(70206006)(356005)(5660300002)(6916009)(54906003)(4326008)(82310400004)(6666004)(83380400001)(47076005)(316002)(8676002)(86362001)(508600001)(336012)(2906002)(2616005)(36756003)(16526019)(40460700003)(1076003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:50:16.5590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f48197-634e-4b71-5281-08d9f131bc67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e651b959141..247e4f97de33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4534,6 +4534,21 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
+{
+	uint32_t reg_value;
+	int i;
+
+	mutex_lock(&adev->reset_dump_mutex);
+	for (i = 0; i < adev->n_regs; i++) {
+		reg_value = RREG32(adev->reset_dump_reg_list[i]);
+		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
+	}
+	mutex_unlock(&adev->reset_dump_mutex);
+
+	return 0;
+}
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4567,8 +4582,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
-			} else
+			} else {
+				amdgpu_reset_reg_dumps(tmp_adev);
 				r = amdgpu_asic_reset(tmp_adev);
+			}
 
 			if (r) {
 				dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm dev, %s",
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


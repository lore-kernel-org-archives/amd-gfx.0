Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4814C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 07:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D5C10F723;
	Mon, 21 Feb 2022 07:16:25 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1968B10F725
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 07:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wyt7V8mR/0su7rCJIX6nJlAl+izrpSdSVnH66JUROCNjY08mZ0xtOF0F/3dLquTluelb20puHwzpEZlUXNttXc6F+K2Q4/prnRg+VfAR7xmxyMl12xVSrtfQFuTS4mswbNB98lmaC5TYamRBysy9CWS4+0IauaCzezruL10bMvtyPbiQPC8ETMDDKmDH00nt2II95ku60l7voIrz4acDurExPLAGq2KThUZTpMWK37wd7zo4SdN7jfUZKW5TqlenFDhHHqsyRcUSHuNTa0epwjDJAhT1ZIntewri9eB+QMtEZcLVUQXAY6lipGENmKVufWd1q3u8QaKgrTmgp6yRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M75tG/EAnzgmlTORKeB/WIKa63Y2t1WdVV1JDqy3VlU=;
 b=FCmWheQZt3tQPUQ4Rvr1g5Ckr3D+xg8LQHBi1PHpkGXuhV4YMPsFHXGikSQYuliHbxmRAHYnsIakwuO6ve/ld8zL8PnqUl9AkMbhNh5IgfsF/GQfjprvDyaMonSrZM62s5gRSnMBrkV0ArUWQQKZHdeTu9NEYJvqRPrh8FX7q/WWFPB5K6sklUaW7vv3TWmWo801wHX6Lqzcr4Dg7T0Rn2oNKUMEd8pGGtffcc6wEY47SPtzetC6hyzNMg+ajwHDfWkgTlecIRgFSMPB8b8GaNCCTcBbAYOFTyjphPQp2IHRbCy5BcW6nf1C51JHPxfUGe5KGlcFZ7tMSsxXHbQtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M75tG/EAnzgmlTORKeB/WIKa63Y2t1WdVV1JDqy3VlU=;
 b=mpSR8YdgrmgTQiioSwnx3pSwxgi3LwBdN1kvRiDTe4wYL18rVge6NHxaz0l23GiD7REh+ctBAglHEPSUFiC59kS1agf1J16bffuNyVqQNxbYD6WEAgkulB0uhxzjhzyngxQy61Xy4+P39+nOMMeXo+0cf9HQbsDqpy8R+nR6IaM=
Received: from BN0PR04CA0137.namprd04.prod.outlook.com (2603:10b6:408:ed::22)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 07:16:18 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::5f) by BN0PR04CA0137.outlook.office365.com
 (2603:10b6:408:ed::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Mon, 21 Feb 2022 07:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 07:16:17 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 01:16:15 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v8 2/2] drm/amdgpu: add reset register dump trace on GPU reset
Date: Mon, 21 Feb 2022 12:45:40 +0530
Message-ID: <20220221071540.2485-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221071540.2485-1-Amaranath.Somalapuram@amd.com>
References: <20220221071540.2485-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f19816c2-9c2d-44d0-e12b-08d9f50a0dae
X-MS-TrafficTypeDiagnostic: CO6PR12MB5441:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB544130A3D4E83AC275DB753AF83A9@CO6PR12MB5441.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d19lShL34bEpTN9+jZhO1ccMKtm0JZHjAj+vTIjbNQ8Adr6Gh6k8jZjNVizQY+fpwUED01FSY1oFH5GaQsBl9lvmmpoPCh58gDgN/CLgSU3cVAEWgu1ulSaMI3nneSnvykj6Yll2g31757P81xtdmmnijhS0Af0f1vFfwj3t6A+rvqLkOUdRpBeZkP/VBCJDx+FVpudvnrpOOaMNs+9ANIpcKHaC/+eiVcxBvLkjRL7DEO5ocYA/0feiLgR5Q9siqyZOLpq9GFCufUOmbWZFgHDP1YP8r8/jPvxqaw8FCjmRGh5wtrPcWwQ+mxzSyUr1JeSQuh4DM7m2IvOsCFO82OBTeuPl/Sv9OZUdUqObUBgohzh06Z+c2WPVjH/itJjr7Z2uBwtbTdo1WGLRwL7VZt5zxvpFLOMJLiGd5ulaCmzW8J5x5pBGWD64mpeyMdFnzY2+zxPQeidoqqZRrTpA0ko8XvXBexmc9olem53i7hgQLmnoVCeTqLqqxguTJIAVEqG8Y4n5Befh6NsNbXhNBoPJAfvxEae4OX2E/84aVpQhg+Sc1tZQ9uJcgweJ3Skkw8fhI7jmCYadDHbQI2fIXwaOcdCTIxKi+AkoCp366Q/QgfRhTrf2MV+NHw/a5fFPhyCuslB0WhUOUZxj2U2BNnWEeksVWauyKEUJGkMqO1LIdPjqXd9iwQYH0+rpw8QV5C+2GFqeUqg7DIYPUlFHtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(7696005)(40460700003)(6666004)(508600001)(36860700001)(47076005)(2616005)(2906002)(186003)(16526019)(5660300002)(54906003)(6916009)(8936002)(26005)(1076003)(316002)(426003)(356005)(82310400004)(86362001)(336012)(81166007)(70586007)(70206006)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 07:16:17.6741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f19816c2-9c2d-44d0-e12b-08d9f50a0dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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


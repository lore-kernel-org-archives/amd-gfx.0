Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A570C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 13:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EC010E328;
	Mon, 21 Feb 2022 13:34:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD2B10E317
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 13:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2y+V/+vbE6QoPHzWSrhdYg2uPESySvuS6TZ0ytvhebY10jFW1izhUpQzDb/c0ES6PxQ5mFq9nT0jt1pvysQefnMucarYq2hiW1gJIoXdzyHRIkU1cSeSc1MajTMTWxKX1qxihdG+3055cj0mDHb/d7j8hL5RMAE8+TeHGTWyJ3bQ+VypH2gqmDf84hPHBc8YQSQyKl3fguyLEes1afLQjY7pSvmw/oIsppx8zSXgk9BlwHgEpcuWjpDUcKnG0iMTe6RDiA2PbxLFUU2EEQA4cJQ2fi0AbHCrfFkjHt3av770Mg8jmAAK8al9T6/VnXwnsLYwN/MqnrsO6tgrbetLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkN+JPEfcHsK0ugoeHseDdSeWwD/+Mzrx60GDRbZvvE=;
 b=MizgewMtkkGOxI+fD0iSL0Srb9E+RkWgpVoGUY26ob6XmcH/1yBUYHzg4byXylGXJCNXcdHxlK69HbZsVS1nowbkIXwJZYW57X2F2UuhoiSQJ5vYrzBTInQGIhD76hb/KchvxstPr8FDd74CQT44xXbUaEswJ4B3RBiy8BnPQ+FnyUjFsgOrQtBs5rjESHFj0n+3A4QyTFvi3/ehQvBPvyNXk34OICeyhBrzScA9jN5VeqECqxR8pX2GURt0clOqFH5xd4JNNUYNqqWDqwvnLLWfMEYZCKvsS8hdsV/GNiI0x9mUlKM6sn38OkfGX1gRMv/cHmVSFIa9IZUDvvhThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkN+JPEfcHsK0ugoeHseDdSeWwD/+Mzrx60GDRbZvvE=;
 b=iHORZJtMFEd5RHAMbR9XtmQUnCL6HG/poR2NL2oe9MBN+qvyGni0Ym48KGN3EGTD3J36us2NLtOXy1th+eWrDI275iMLZhnXTitxHI3VA8GfyWGhF9QBUX00cAEIXItXc79qe7LDByi3OV7/C7/nKC3YyfkE4hFWP7QWg/QDvJg=
Received: from DM6PR06CA0051.namprd06.prod.outlook.com (2603:10b6:5:54::28) by
 BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 13:34:43 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::ae) by DM6PR06CA0051.outlook.office365.com
 (2603:10b6:5:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Mon, 21 Feb 2022 13:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 13:34:43 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 07:34:40 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v9 2/2] drm/amdgpu: add reset register dump trace on GPU reset
Date: Mon, 21 Feb 2022 19:04:11 +0530
Message-ID: <20220221133411.12544-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221133411.12544-1-Amaranath.Somalapuram@amd.com>
References: <20220221133411.12544-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23f9c293-a3b4-4888-84dd-08d9f53eeb45
X-MS-TrafficTypeDiagnostic: BY5PR12MB4049:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4049903A272C89341754F4C8F83A9@BY5PR12MB4049.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ha1+6jYOFpSqgWAQGmLEg0HhzAt5ftv48MYGdkfbffDTHQP3qMwwxQGYgX8mTRHUh/X/hnE9J1/NMZc1T3HtoYKcrzAK5tr8UuWO2ZytXK1v78lqxF+bCwS+qOIV8NQeUTSJB6F82mM56+8/DtKZR/OwFLm/TLFSEt/GeshhfXTCTx8/KE1jltSe9fq/yEL4Rw+bb9rhEFfJnXGkzzm7KPcSho6LkCDWlstXG1+TCe83BM8HxTs/qETKj1gcLXbM60fgXRX+bn5z4hOJgpOx5jmFBIeNm6B/pnX63HKvwR8Wi5NBU2d9wvOZhjH1pt1kUwERV9/TqZd/CU+fBIzm/+VtedQgvABVEZSOsWQMlushtSc60HJW/vej6RxmC+cMPEDRNteXH7B5ypOr4/IDN1IKUo4yXBbuZHPbbGEsR4Jf3bfTZsGfQJdu8jIZpfq2b2PtJfAeRjUIpvxmI/78ljvxT/dE1x5WAUGI7+GZet1CyHa8wGBQUvz6nGuLyJikQFKO9ajbU6d0otWM0BvBX4WbRanfcwZx386vjAaobxSfSBN7HHBAHBb3wTvT4CeK2vJxB3IYOjNchAR4Sp1q4mhfFHacVbSaXg4Vz3cpoLbT4cotpGXh39ybFNw40WXHLDgGZ2HhzZdfGg/HwIIU2ABIEGgMP1ruLZjuNvw9YkMFbvI+awc+R3u3P6Oyw+zeuBLiug5YcV+RT8x3oojFXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(186003)(26005)(70206006)(70586007)(1076003)(82310400004)(54906003)(6916009)(7696005)(2616005)(86362001)(8676002)(508600001)(316002)(6666004)(36860700001)(81166007)(356005)(426003)(336012)(83380400001)(4326008)(47076005)(5660300002)(8936002)(2906002)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 13:34:43.2521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f9c293-a3b4-4888-84dd-08d9f53eeb45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e651b959141..0eedcd4e2227 100644
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
+	lockdep_assert_held(&adev->reset_sem);
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
@@ -4544,6 +4559,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
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


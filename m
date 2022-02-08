Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927A5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294CF10E30D;
	Tue,  8 Feb 2022 08:17:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31BA210E22C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 08:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un4gVW5AHlGu4P+lVVJ5eEt69xFfbnu3vwqscP7B2fBkuk9qRlaX5P0z1w2uxham9QUxcwYS98NTNA3IsI9MDBtPhOFR7AokCEmeY5szEY8V3ZS1X1ai7gk6xwek2FPxI+2nS8UNuNHCIl5BjUXbogbJOEgc204owLzPSTOm79nCHjISfJHDXLXHCJjUQ2DboMhfxYFX2oe71JtGpxX3K/AGwxSrjb0rAD8KhBl/yRSaRs/Rz5MsNllBkpU6n4a5tcbdpunXa3Yt2h7xNlRfuyYlrkKB+fvM3LKONLoKHJynTwnT+9FQlqa39rLppGBLUpujZadAMD/Xv1o78dKzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rp6K0PU8TtpgGQcxHVs1znXHmNlGs9Rke/u2XsirVS8=;
 b=V/8D88pNE72ptzBX+WsFu5smq8Tn9f0lXtjGOGZnfnm9vEz6klcDvX/TT/1MrphqSgVBDkf8YUYKvxM73kdJhX/0eOetlZjNlzUviMqoF+/otRyaEfmoHuPVMgtRmNfuiT89z7eb0HmHiyOiifrjh0/HGkahsqX2fKRydD8su2OPmDfJcG6vyJwxLyegj5Jc1aOgHfiySI6NxFsj/Nvwuh/q88Yd62t2g8vPrVHV0YxRmxEZ5HsoJUUv+1fIZfZth1BZXCWInEYpPf6uxfdeakDrA7oHKrqvowHGH8V9KM2U7S9ZDi5kiUeMkbCACIcVCERl/2NEds5cIW4QIO3dpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp6K0PU8TtpgGQcxHVs1znXHmNlGs9Rke/u2XsirVS8=;
 b=KWRWKtRSChlTG1XJ+a/nV4Yy2pUoJWngXBASGK0/xG2kc99xrILyuyxTPI1W5js0STYUozrtDrXNxnmedZhFsxc0qrViaxvP4l2P3LVhZbQiDDJzEUczgc2axmCwbxo4auQlgyNhH2nyddCtBRiO0u69xmqXvV46HoK1SLOYwrg=
Received: from MWHPR20CA0024.namprd20.prod.outlook.com (2603:10b6:300:13d::34)
 by CY4PR12MB1927.namprd12.prod.outlook.com (2603:10b6:903:127::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Tue, 8 Feb
 2022 08:17:14 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::dd) by MWHPR20CA0024.outlook.office365.com
 (2603:10b6:300:13d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 8 Feb 2022 08:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 08:17:13 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Feb 2022 02:17:10 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU reset
Date: Tue, 8 Feb 2022 13:46:47 +0530
Message-ID: <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 623cc14b-5979-4706-6170-08d9eadb69aa
X-MS-TrafficTypeDiagnostic: CY4PR12MB1927:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB19277E65FF0E4C2CF73134F6F82D9@CY4PR12MB1927.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mx7vN3YXHU6rKKC+8NgGqHzGuoEG/OPTL6Pfn4aZFrwO9QDW+YjAuZlXWmlB8OVBPtE7YFQSvQ+PbcEwKDkXhX9nIZVCTBc+zgB+8pKgOFBeBGrx0Ln2cozF8CjzjcaHiIv0P25RF3JTUQUzc49dx1TQKScBMumayKhq3vyEJJwad5ZMTgNFVS4Nd8lnBgDz/vLfDeQL+zLCJSSmxr4SCTQuNyY2rSSEC4dRkcnhhbj+jlyMwOaTrGMyBj5yhgbcQLpsn7YH39pjkJ3VNM18e4hDv0O5JG9M1aB0LsQZlIEq+bnVQH2AWlobE4v3ocPN7WMT/lSnNQN13uZoZz6h3mPj021a2d+42AwUmHwrEkNgbjt2c+vyhPApH3RJRQbOX/dZ3wBFNqjNT6sE77nn2vJsaNbgxHrYdi0sZUulDU8bBWim9bDkglg+oE+Zex2b9MGAUwn/GDEb7rtydHSFXJmTsDEiyZIyWKagPxpynv0OrWKufR8xUGswvg/AdyocqrMX04/9roYHobHP7UYHAokz4AAgmgZgC1AD8gh2lNMhlgykCb9ohn5Vq3UnYyUJObLMO3SVrmqn2Y4fJ+TcldENXXiowptG6S7+kipB8fu/lM2ek3ZH7QVRYVI+r2j6VeLNhLrXoN9hUGwlJ0uNbgstsYXUQh2VB4wxxx16HA351/EKflRJSda/9yOe7HOAIZAzObHZfqulzyBS4Xub3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(54906003)(6666004)(7696005)(82310400004)(70206006)(83380400001)(508600001)(6916009)(36756003)(4326008)(81166007)(8676002)(8936002)(70586007)(86362001)(40460700003)(2906002)(356005)(16526019)(47076005)(26005)(186003)(1076003)(336012)(426003)(5660300002)(36860700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 08:17:13.9115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623cc14b-5979-4706-6170-08d9eadb69aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1927
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e651b959141..057922fb7e37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
+{
+	int i;
+	uint32_t reg_value[128];
+
+	for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
+		if (adev->asic_type >= CHIP_NAVI10)
+			reg_value[i] = RREG32_SOC15_IP(GC, adev->reset_dump_reg_list[i]);
+		else
+			reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);
+	}
+
+	trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, reg_value, i);
+
+	return 0;
+}
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
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
index d855cb53c7e0..3fe33de3564a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
 		      __entry->seqno)
 );
 
+TRACE_EVENT(amdgpu_reset_reg_dumps,
+	    TP_PROTO(long *address, uint32_t *value, int length),
+	    TP_ARGS(address, value, length),
+	    TP_STRUCT__entry(
+			     __array(long, address, 128)
+			     __array(uint32_t, value, 128)
+			     __field(int, len)
+			     ),
+	    TP_fast_assign(
+			   memcpy(__entry->address, address, 128);
+			   memcpy(__entry->value,  value, 128);
+			   __entry->len = length;
+			   ),
+	    TP_printk("amdgpu register dump offset: %s value: %s ",
+		      __print_array(__entry->address, __entry->len, 8),
+		      __print_array(__entry->value, __entry->len, 8)
+		     )
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.25.1


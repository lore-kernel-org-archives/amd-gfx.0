Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402F0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 11:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EDB10EA74;
	Fri, 11 Feb 2022 11:48:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53ABF10EA74
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 11:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ishZeuFVgSDmSyU6zYV6wr0ml6kxiQDnYlHR6kv9gUp4f3zekEvDjT8k2AzScicqC1m+0vKbWuQqbeVP3xPDhbM29XnPa7WNR4xx18Sl0lC5V2sUWyAjVBoQkrGAdaER7iDleDgl+lOCLONGhH4p+eZgto7NBMqdz6kMXzo8l5PiXW1ZeJ3z4OlQgLIjIWShauY9Jj6wY+Vpqhocog2TRRbHbu34P4bNZgcZAwiZWCpeb2vd3zXA+eiTHiJccPHVbs8MTmYP5FTRAE2Op24+Ax1WvSxwvGHt8BLYomfpdbMQXEOiJjXEGb0IUtCam9a2N+WEZ5HqCFcOFNqh5Ruybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPlA2X7JXiH/RBqodI1fuO615bzFCLq+L2tushnUlgA=;
 b=a5yxG3VeyM+Ve8ArOJeSDy/6n++QpyTq8fif4GdVRGkdldB+xZbh5pNdJz0FzWaIG+tb5Vlgak0BmlqrKDW+cSGRR+/YCR28/ZljnXSagxHtHRn+JbJzxsdk9opwg62Y3U23VNScl+hVWDDBfHeFmcBm2QEhysh/hGQUWDv4QRyeodNktlT+ra4xhMpibjHSKZskNLq3+t+OikrHOmliK+oOnrN3cWaofB6j+TS+FdaiZqLDGIYEgf0rB3ctuk7jPj6VJLMCMQTi9iC3fqG15feSmDmNXFi6W1BjT2H0t7Vue7Zb1oL/QVQMddn2LEzcAdysq5xIG2G1MRfSQbFZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPlA2X7JXiH/RBqodI1fuO615bzFCLq+L2tushnUlgA=;
 b=oEih1UyqpxhNGg+uMv3hBfvZeo4weHucDF+M8Q7ctfvrzSvmJq0F4SxQtm9+pVUegj3h6QB6wTqs0e6wyOI2gBfc8pGsrPw3v72qCcoGxkO2J7v+FaVTUQpWsKIgK17rijIaOkQMpm1DRu1WPkobUolig8mUSF1MxPOeK4IBC6o=
Received: from MW4PR04CA0159.namprd04.prod.outlook.com (2603:10b6:303:85::14)
 by BYAPR12MB4981.namprd12.prod.outlook.com (2603:10b6:a03:10d::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 11:48:10 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::de) by MW4PR04CA0159.outlook.office365.com
 (2603:10b6:303:85::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 11:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 11:48:08 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 05:48:04 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Date: Fri, 11 Feb 2022 17:17:40 +0530
Message-ID: <20220211114740.10904-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211114740.10904-1-Amaranath.Somalapuram@amd.com>
References: <20220211114740.10904-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08c40ea5-cf29-4dc1-a0ac-08d9ed545f66
X-MS-TrafficTypeDiagnostic: BYAPR12MB4981:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB498196DE54ACE355E9D30C94F8309@BYAPR12MB4981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 906/HafGkph/K0+rLNTS5HRQ7li1cRVhVR8OeTryjEn7Vn7IEMpamdZnXecShwlZb6A/Oy5subG1gquEquCBSCWpDK7t7wyAYt5uhyLjzaTEi1RulV4O0NFV++7OYKxZrSW/8OJ3kTSxj5tzEa50aP/XDSzWurlrRSkvIWJ4gQ3N03/i4whsWARf3uMYwmH1sMVX4lJkWN8WChHWMv7rHrl6jrVJjjYy94WRaqHbKVHs5rEx8wAfTdpRlAE4ytCJqUTbho+vIdE4MZapksj4U/oJPBJlhHTut55brPWNTaooCy+EI/eh9HP4CMDiPe2hdj719T69q1MtiXimvPkTCIw0i6L0OSmxBCIAimtiLbVUluxF954oU9ZbJIdsASGRAOfT8KQ7ie4SiAlLEGWICUm1cDdnmu5JJe2jk+chnJbNH2PNHos5Ycvr6FdmROpAl/l4vzQdtNDHhJ5Di7WdKFCtp79ZuTyLtY7mZrqpGYBkzww2OUQaec/bCoLVkdV9PC901Xl8i2vRWCBBZ5JiBXfu00YqXQQhq6DMVyLLmwb4M0yDQaolmZdyu9NzNaq1p6TvfzuxgWIpW+dtgopBF9A0482yyEj5EkuaeqzIsclPFiTOaHa0obMX8XdVUoitGlg0oRuRLUSq6xDUCO6Ha/ZmxAuuV5CCiOvF8wfEE5JPEkKu0edVP/YcpbTNOmXTuMwMTrn8OFcPEesjoQ5mng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(186003)(26005)(54906003)(16526019)(316002)(82310400004)(81166007)(6916009)(36860700001)(2906002)(336012)(86362001)(8676002)(70206006)(70586007)(4326008)(426003)(8936002)(83380400001)(63370400001)(6666004)(1076003)(40460700003)(508600001)(5660300002)(356005)(47076005)(36756003)(2616005)(63350400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 11:48:08.1358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c40ea5-cf29-4dc1-a0ac-08d9ed545f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4981
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e651b959141..d52d120e7a6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4534,6 +4534,20 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
+{
+	int i;
+	uint32_t reg_value[AMDGPU_RESET_DUMP_REGS_MAX];
+
+	for (i = 0; i < adev->n_regs; i++)
+		reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);
+
+	if (adev->n_regs)
+		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, reg_value, adev->n_regs);
+
+	return 0;
+}
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4567,8 +4581,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
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
index d855cb53c7e0..781fd0ec2c9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
 		      __entry->seqno)
 );
 
+TRACE_EVENT(amdgpu_reset_reg_dumps,
+	    TP_PROTO(uint32_t *address, uint32_t *value, int length),
+	    TP_ARGS(address, value, length),
+	    TP_STRUCT__entry(
+			     __array(uint32_t, address, AMDGPU_RESET_DUMP_REGS_MAX)
+			     __array(uint32_t, value, AMDGPU_RESET_DUMP_REGS_MAX)
+			     __field(int, len)
+			     ),
+	    TP_fast_assign(
+			   memcpy(__entry->address, address, AMDGPU_RESET_DUMP_REGS_MAX);
+			   memcpy(__entry->value,  value, AMDGPU_RESET_DUMP_REGS_MAX);
+			   __entry->len = length;
+			   ),
+	    TP_printk("amdgpu register dump offset: %s value: %s",
+		      __print_array(__entry->address, __entry->len, 4),
+		      __print_array(__entry->value, __entry->len, 4)
+		     )
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.25.1


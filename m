Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00DACCA46C
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 14:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EFF10E24D;
	Fri, 16 Oct 2026 14:29:04 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563EB112873
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 14:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3xZsi/PHy9WZE7cFdi9asLwFw+4J6v+gj1IuX4FoRnkfhXUUMil7lpFKgdb9Qs6kk1ylS/l0Er78wjEuoQLlzKGLEKpbxgFxkVfJvLUzpfJMheIXNRmTmwNapprwB0yZPYvB1FzbH2cFpcGnSu2dlAEf+mtUMDvp03OVjZW4zg5O2UXdSJhrT1MalAqejzOZCtthKVKlIYoGJepH2UVeRQ+CjsiX3lapCM+X6LNycVtQQ9ITubMTRbHjuvxbTiIWu9WF2gAcQ+SU/hhhRKW0dvIKbKn8Wi+wR9Za2TNnbLwmr9fk7Otbofh1Sf36Wsl70wOqvXea4RKWg1Pn/65ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCiuG3NOvGXZTEMZjEe5eKNEfDPihp2JJFcuq+1P0k8=;
 b=BV0ocl+GMIHZsNK7+LLbp0XlLsUs18/Wxnl2HF0Ntn+bKIT6YmgnCVHbanTvZ1zF2a/eEyrJh7Bh7vP4W09QbJN6r3s7T6zVEheqbTiO8WwqHY8knr2Lod17oUbGodT4v0YeuWC5gNJA5kAVQigpZmlKPnlIUlOvIEzqB9PZK1cC4E6XLmfs+67CZZfWLoOb6Oo9hU6I6NzmvL0ESWY+ucwwwhk5cBVtEUxfxnuOEJbhxiqI6+mor+gPKQQrgPLLs0sjtpTy+9/IYZFOeducP1i0xN8No4FcTr7GtskKMKo3SU0pZzzO4F99SS7LVCiV8LskL7SQIbZIsGjmnnCzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCiuG3NOvGXZTEMZjEe5eKNEfDPihp2JJFcuq+1P0k8=;
 b=PJRLuuD4/q0ySy+sEMvIlZoH1QEgZ+9sRT3g3buf8Z+GhY4GuI1J7DtDh5LOEF63CXKzntuEUibBNDGAarpOmIk1XCfD4vCw3wWeCpDQf/Rpt0/9PFF1CrZukBvYtFC97ZN4CO7grzSsk48mre07MhGUIR2+9fu+Mcke7RlGceM=
Received: from SA0PR11CA0157.namprd11.prod.outlook.com (2603:10b6:806:1bb::12)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:28:52 +0000
Received: from BN3PEPF00022BC8.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::1b) by SA0PR11CA0157.outlook.office365.com
 (2603:10b6:806:1bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 14:28:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC8.mail.protection.outlook.com (10.167.248.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:28:51 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 16 Oct 2026 09:28:44 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: setup MES DBGEXT per requested pipe
Date: Fri, 16 Oct 2026 10:28:38 -0400
Message-ID: <20261016142838.361821-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC8:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb6fef3-20d9-474b-1876-08df2b91ccc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9/OG2C91+Tgf25rt4tZFdGwKQJjP3Y4mRfTorIattZ783jMwA9mmX5HzlcsZQC2ihMqxM9PH9Kq5ADyt4wBWG9gvJOXWUZagRJkcYOuaCFP/jBa7W6wC8VqoRTGAPqadRM55qN69WqS3Oi5yojz26MvIk8hH2msx8WBqcJH+S+RmWwJiQPneuw33LHGa90lPB4NreBayU70JE2p0N7fBIWyHKHLf+J3eSvun3AeROTPNISPg4PbVDD+2G4+NxgM+h7dAKhrgfMkRJ53aY5sTlNHOsSBMpxRabHa41Ap4n2A5jUHYhAlAc0E6vN9cDYx2rEUZTghXJvvmnvK0zq6j9n69bYlxXKKluKgqEBNeuVF4AT90etlxeZKUAumcwVMQai0+jFnR3fqEm/YvpBhsaCjMYFnGd7XFzNQ3u0mJNfzwnv1O5GrkFgVrS7ZvBandV3mLIiNHF/7/sMdguxcJXj9pLDLZGxXWjV1HX6g6G5XF9MJ+wEq24H96DlUN0UTmJjAYQ5W2M4upke9d4bbEKqYAKN+BgM/xZs271aNJcz2MreNZpZV0XDT2OP6XoVUbznEr9t53EDreh0DrbMqSyqtiVo7KHIieHIoePskYNJ/xtPNdjAfz41Sq+TOqP5n58XZMVSTgVnvGYPZ0AYDluurvP2O2mHApjEwmAtbQ5oDO+2yd5bovwP2sPdqyuERJiMNVV7uu9oPjd44fIpJ7Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RRYxZ4U7nD+dGOILENx2FG1Sdzhb0DbUSZZaOBqnHb9jgl3QdH0i8QXPokqRDAzpxW4pnEEXaf7DpVZOVh7hlEIyLJucn/Z3CwqjYrcie1WhEzb+ei+msljV3ahDdR5MJI6kaWzn8YQMbeWU03GUcl/KeyS1sKKYqo+cT1w4IrMcvQBh6YjMDy3CTrLAQP3nAhr3YfE99LA7Nna5a345zjDDsngmPqMCNq7GcNdKs9t6a4x90U+iqPLsN+PNFke5MxTVb3j4K3/wfp+z/2C8VDtPnRXZb1ZTWuTmkrBE3WPwdig8b55bGbDgfqzI9dFy2R5oOXVaRkV+/B4WW4vRDUjaOLn2c2AN3asY6YJcMoiJ1uC8bRBs12/tPFSX8ummcaDg6Tqy234tTTXQOKbiltwo0URACjm0n91QJLNR0+Qrdz6aGNInJeXdLMfJNFA+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:28:51.5179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb6fef3-20d9-474b-1876-08df2b91ccc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

setup MES DBGEXT per requested pipe, so the firmware
attached the log buffer to both KIQ and scheduler pipe
and reject a pipe id outdise the MES pipe range.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index c5fefba912a3..65adbf5541e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -633,6 +633,10 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 			input->change_config.option.limit_single_process;
 		break;
 	case MES_MISC_OP_SETUP_MES_DBGEXT:
+		/* The log buffer attaches to the pipe that receives this packet. */
+		if (input->setup_mes_dbgext.pipe >= AMDGPU_MAX_MES_PIPES)
+			return -EINVAL;
+		pipe = input->setup_mes_dbgext.pipe;
 		misc_pkt.opcode = MESAPI_MISC__SETUP_MES_DBGEXT;
 		misc_pkt.dbgext_init_data.dbg_ext_mc_addr =
 				input->setup_mes_dbgext.log_buffer_mc_addr;
@@ -974,10 +978,10 @@ static int mes_v12_1_inv_tlbs_pasid(struct amdgpu_mes *mes,
  * hardcodes the TIME_STAMP assertion bit (CP_INT_STAT_DEBUG bit 26).  So
  * TIME_STAMP_INT_ENABLE - not GENERIC1_INT_ENABLE - is the CPC_INT_CNTL bit
  * that lets the CP forward the assertion to the host IH.  CPC_INT_CNTL is
- * per-(me,pipe); the enable must be set on both me3 pipes (0 and 1), matching
- * the Windows/SR-IOV KMD path - setting it only on the scheduler pipe is not
- * sufficient.  Armed on every XCC, since each runs its own MES and logs into
- * its own per-XCC buffer region.
+ * per-(me,pipe); the enable must be set on both me3 pipes (0 and 1)
+ * - setting it only on the scheduler pipe is not sufficient.
+ * Armed on every XCC, since each runs its own MES and each (xcc, pipe) logs into
+ * its own buffer region.
  */
 static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
 {
-- 
2.43.0


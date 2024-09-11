Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE77EE0219
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 08:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23B310E1E1;
	Wed, 11 Sep 2024 08:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J/CnyfEf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757CD10E1E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 08:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMwmsrVz5YwJY2LjjOKpCUPOxDzA+7t20Khry+JbD5WeA3QoTsRLKww8fDJD9yah8tP2qPmpJnFsGOSeS99JDkjigUa4sGSy1PLb9O6rIJzkhZ67kMw/bNBiKojdTOl668v3hhDHlfGczmbDsdx6Xhsteoe7zbmD+XPNGJWgLVjgMwkLn16ur3BwZoYQJPUz9yyKj3MfKLueY8mpOetYrQtpNAzHiNkvbIHn3EP8mLLoH0+6asllh5Clag5u5KZU0aHpfP34YnPM1EU7XWUAjh81762mNIyQoN6sJLnLGpp8zXlHUDKuUAL6O6RkiKUItVmMBO2LAFQA1r101WadvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ff9Av603yEHFied1TTrhwb+eTsmZ1eBUZeYpfckZ4Y=;
 b=UJOl/hAKGmqyrMDFGu3Igst8SmhwngqJxWyMRJbcSUglXXpPSr8Gr62cJkXT+6Vl43Nsa1zDMriXX1JbWXoDj7+yT3v/RNoO2x3Blaf5Mt7RUn0eo6FXPXfWu+u1niGnbKnjJnVVTpjlvEUQztJS1DLKFSXpcDZM3xHvnTmjBu8QwD7R3PU1hT6bycwf1pDG8tMVitWyBrn5hGBOZKtYes3v4hDeTsOrodSTFRtdjqnJe5z0X6/Q2gAHSlSwCl5/FT3wfcpJY3ln4FBLahwqVx8VVCNrsHSNARlriLb08ibzrCepOIWcsZ8bxQfl+PybDzo3Hqwm8YNt0UdKH6vUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ff9Av603yEHFied1TTrhwb+eTsmZ1eBUZeYpfckZ4Y=;
 b=J/CnyfEfnECbgwvJyRWvTijDkfXPZrKMpaokwLLH0IaglqHXAJ4+As9EwSlcFlYvJkWHfH1vCDtN52Bfo36KB1DBQ2d2Qh8hYRw3R9rd7DNzvOUn9ZrAZoj4ZwehAIF36RATCHeGwjzp1UvJTI0u5gxUfmK3c/pu1JmeEZ5NzgA=
Received: from BY5PR17CA0031.namprd17.prod.outlook.com (2603:10b6:a03:1b8::44)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 08:36:08 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d7) by BY5PR17CA0031.outlook.office365.com
 (2603:10b6:a03:1b8::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 08:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 08:36:07 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 03:36:05 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: switch SET_SHADER_DEBUGGER pkt to mes schq
 pipe
Date: Wed, 11 Sep 2024 16:34:58 +0800
Message-ID: <20240911083458.4109430-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4a21f2-37b7-42c1-bda3-08dcd23cc85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CAmhbzqYuojrmvotsXthSjSCNQYs+o97DfsmjN03UWgIUy3rspoieCBQPe7V?=
 =?us-ascii?Q?B/tJJ9jQLhrcrrrmtn1EeyMEXF7AeYywRpT4g9WycncEkoyKWblaUJtukosU?=
 =?us-ascii?Q?jBPdWS89jq9/aSljRQ+QTI15ljo2WxXDuX3e2HFoGuRe2BSEVa2c9oRFmBZd?=
 =?us-ascii?Q?c0vYq+JPbNwlvun+cYPM4fUaj+Zae3HYP7VVxbmx5XhACsUhClV+ZxXKGl5p?=
 =?us-ascii?Q?k5mZdRlctJDAXpQZVlnVaFnXVPdJH07P//WCHNksY/YqFN3ZpJwjCb+IPq3u?=
 =?us-ascii?Q?BWyd0sEg7dbSMYWc7AKzHpqwYkuKHAoYJEX3faSxhJjJ5W91dxbA3tnUOaOu?=
 =?us-ascii?Q?IB4iQcT/qBMeNkYdfppJbkV4QS3bnE7dpq/qKDfvf5uycdAgpGsJx0qCosCd?=
 =?us-ascii?Q?toaOPCWELyPKOldtruoiZavvPGn61yuvKekf5j789bx9y3KykWKu32xyf/i3?=
 =?us-ascii?Q?XGglC1yX3xo/ERV/cz50rVOs+VPZFO6Gc1mp9K4zROjxnC6/XfPS+Rs+BUgq?=
 =?us-ascii?Q?qM2I4M3QAdrBJi3c4MQeS1Mp8qILoWTPX3xz+udNQFcqGTBlWIGWQtX1/Ljh?=
 =?us-ascii?Q?SpHSvXFMgnlrDlMzWPaW1X3FSd8XTWSrGMJbpGGr/7sWLx2zMgs07uLYX1wv?=
 =?us-ascii?Q?VjYddrEIaErGwjIoV5YXKUz6cVgBKuMD1MXdJ6y3EngSp6ZhYM47ailzDvka?=
 =?us-ascii?Q?zoGH+vbZxtnPamLizYoo096MppPxmeMdZTGuG5LpbDHcTCDmZA1S+JD97avS?=
 =?us-ascii?Q?fYh0fi0CfPdvdGnNf28KDUXGVKB8CRi6OXZUMOK6VQIqQUM+xy2Mv2EtmApV?=
 =?us-ascii?Q?MJmTBTjeudxnj3JQyI+GKlWmh9/UY/Ci/mHYFGixUi98VdiqJ5eT690VWEJu?=
 =?us-ascii?Q?aLeDXhJaCEh+iJ3JRpCKSgBvNFwgWcqb+ygtYnK795O8J/ZYeb/xnqjzdQFB?=
 =?us-ascii?Q?b+d7K3WxGq7OVEnDWRv9FO9mU+7AV1AzqlEL1VGeFsOxElEIM5YbxUjaBRmD?=
 =?us-ascii?Q?PfCEsHkSvYSWJMmAfPL7Op7VIqF/CZr5VZ+NgJejyPGF2xZhjmGS3uqy6mmy?=
 =?us-ascii?Q?2kLH/JDeD/Xl8Ho15RdHvQ+gfZ1aYtAw+3Ky/pK6o95mCtbInUoyxPXj3v2c?=
 =?us-ascii?Q?UW8qRZ+o3PLnX6L2Oq/9+FivAGsOlD184SfZ84cmpOlHSMbScstMWbBTI710?=
 =?us-ascii?Q?OVQyfuRVJ5CqIVUEbdu4FsM4hwC0vL2Bfscu77P+/xz9PPNitco6cE2fmIq+?=
 =?us-ascii?Q?lW/NWi35GoCA+tWsmp4kmUP1O6RGQsBXFbeV0OFAh1CCE23ilImsf3vEWjCi?=
 =?us-ascii?Q?hzzoxI+GktN02tIO4ni2anITJBfGJ4eSkwSRv9GuBJrHWflgpJHKeoEaJorK?=
 =?us-ascii?Q?WgMaiDBSCPkhQujT1BWOepYrM56LlWgBNjERsZPEHBHuziqd4Y3MrQd7NKdf?=
 =?us-ascii?Q?PMYPDTSeCrRt4ldkKt4if/taXvJop0eK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 08:36:07.9687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4a21f2-37b7-42c1-bda3-08dcd23cc85b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

The SET_SHADER_DEBUGGER packet must work with the added
hardware queue, switch the packet submitting to mes schq pipe.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index e499b2857a01..ef05a4116230 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -479,6 +479,11 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 	union MESAPI__MISC misc_pkt;
 	int pipe;
 
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
 	memset(&misc_pkt, 0, sizeof(misc_pkt));
 
 	misc_pkt.header.type = MES_API_TYPE_SCHEDULER;
@@ -513,6 +518,7 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.wait_reg_mem.reg_offset2 = input->wrm_reg.reg1;
 		break;
 	case MES_MISC_OP_SET_SHADER_DEBUGGER:
+		pipe = AMDGPU_MES_SCHED_PIPE;
 		misc_pkt.opcode = MESAPI_MISC__SET_SHADER_DEBUGGER;
 		misc_pkt.set_shader_debugger.process_context_addr =
 				input->set_shader_debugger.process_context_addr;
@@ -530,11 +536,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		return -EINVAL;
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
-		pipe = AMDGPU_MES_SCHED_PIPE;
-
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&misc_pkt, sizeof(misc_pkt),
 			offsetof(union MESAPI__MISC, api_status));
-- 
2.41.0


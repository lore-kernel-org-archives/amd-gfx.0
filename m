Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ADECC6B1A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 20:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B1610EA37;
	Tue, 13 Oct 2026 20:11:30 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF28A10EA37
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 20:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsE3yTll6cEYttGsucwLUSHz5u47Jqw58crnjQ5cTwQyln3/uV3iejd1IxjJ9bLDrSMwYLOvtTkNi14KdpnZV6rjo9/WRwtL2sK+Sk4K11zb6PDTwKeHbdv8p7QrViDI31nIPAHx1wvEHHu2U/72xajpSOHBo0Y7CexEr5z57hMhmdvrz6ICKIs9mMhBTZH5/7C3tUsNf6fEmronQdAGjkq1nrOQ+q00tHY33hiXeahFweEadSbU0BEU/AhuJXnjxODwyeFIeod9ZmlMBasTOgbTIYJ5STe2rp+a16vPRH/K0fpC0tcgwGaBsXQ7avfO11xH0f10gSNnIZDwFxMPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0wPcY3lWl4W20bYkk4ZgxyrjDPyANAh2A0eaLZ+hwo=;
 b=Q7HohglkwrZWmtt1aGvu2wFPflZOAN9jtDn5tARegtQS5dGSHW279GhvLoHyJstAsDzPyBDydvDPuqwlEptru1gLVteUiltBduOKaqhhnNHet2si5d90mOyFOe+QIGt6A6xrf7lYUP2Sv3hEnbuHFukLJ6fE1AddqEYyt9QNceKzD0u5UK55cYJQeLzkbew5lvyvlZ5/38hJ5UXZ+KdD1pUxruIGu1FEDVw6tXF5KE9pGc/seg+ZAAMd+QwSXRDAa24SvDn1xcwUgTk03EUJDjxdeD44JwnkOmQ3XHQSDNK7Brjs3reWsuA7pLH7njYGQTXmFGA8EV6XZtpicml4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0wPcY3lWl4W20bYkk4ZgxyrjDPyANAh2A0eaLZ+hwo=;
 b=C2DSUYRmtdSJ2VHf/WHslMEcUSTy3JHpd03wyD3rZg5/5gwVwVisU9l1ZvHalznsNbwma/zMyx6fdXqKK3YfEBVA8ykqF1VaPd+KwgYpNqF5CkO81EIqvcVn8dySDeaSe1ShheUeHn86l4byuwn3pf/j10BNnXI70wakbHJh76Q=
Received: from CY5PR17CA0023.namprd17.prod.outlook.com (2603:10b6:930:17::25)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 20:11:20 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:930:17:cafe::1f) by CY5PR17CA0023.outlook.office365.com
 (2603:10b6:930:17::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 20:11:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 20:11:19 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 13 Oct 2026 15:11:12 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12: send SETUP_MES_DBGEXT to the requested
 pipe
Date: Tue, 13 Oct 2026 16:11:06 -0400
Message-ID: <20261013201106.2142038-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 499c4432-5623-4f51-ac45-08df296624f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|10067099003|261009223027099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: XWPXHqPNc2oiWG2uWN/hCc8pBC63nlLqZfk+RH1zdkLZl41EV2K93SPrhIWXiTcqY6nAD9vWU7KRo+F5X2G3BXE7hhjgxmUPiv+lGs89izB8ni02az8aNsLnSqzVAn5HIDfx6CMIz18GnlXdWouVUViDYaO7QbVcj3bSY1AoYWfqpwadgvHueOM3YGH0yaHU9ZnftFWxsFqLIgtwQhhygvbMDGSviTbreLynoGw2EOnD1Rcvm4ImXbf6zXTvqPyOPZS5owl7vTVWFFlAWJrG9XoAbhIVAkk3mJNfZNHJfpzqQf9SkpwN3nn4R6KCHIGOUrdOBKhtTVy1OhffnUZe3bA2Rqgv4TpCCDNPkbhLTH+/OySOZl9uPN8pPgD0yEvuduAoMguUL3a6EE7LpEQUb3wucIDgtDj/QrTtEDsL8CHgCQlIiTuOYP5mGpaEPwYAL2Rmlx8Ypp7ezbHc1aWkoB32/BCHUPDLekkrM7eZEk2SOfqOEIzSOzUSHEi3RapY2k0LGHLm14uWsrJ/ngzFikbRzLYDOnCDY0HP48b1ZxeSTVSPVtk7d3CThQoAOaQft13I2B8E7pqby4hg63PAeLjGrg3gto8F/nl6q0uPJLgBIsZR3CVSX/a3Y2vzuDnSWACK8sB/w2C9OrFwxLprwZnnrLx9Z6C3EuoMXqFae4EhUfBybJxX0zKjIAFOjF3LrLLTn+pjFeNZW/ZiCoTAdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(10067099003)(261009223027099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Pj0MvU3Wrqi6LdjARC8ZwOCYLDqgKc57iKOGKT632Zdq7O9OgHpwwStjNf2M2wKzv7kySnJCj1RCYtQ4pz9H919ZZr1P6o3+nZqQIsiCqE11qNKaI1lwYPvn3jj5omFLQgNLQcsUjVSvXSzTZFU25Cpr9ceQzzin9aifsSUmgHvUfSsrV9+3ZW/KyOiTaYHZJmSEp6WzHD/8E0TMTGMRbU6mkj2ynwZ7hwm8zetRx8vmTBVR34C2yURPCaivG8YTKsO5GrcjX+w/NaqIHNsXR4b+cHIKAaoI/Hc4D3AVC8D4DtlXMpTSmm6TNhpMALGVmDEtYie0c6LjqFlfqQHfbmmGtgW2i9TVEsZaXEkSoNv0eEo28XbOaJQ+Jj+mIeya9nQr/3YE012Q/ZP15XOYYvLIAKqBjQyWZ/hWKe0hrBqLRGSm6wj07RhrpVFkGTv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 20:11:19.2731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 499c4432-5623-4f51-ac45-08df296624f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
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

Route MESAPI_MISC__SETUP_MES_DBGEXT to the pipe named in the setup
request instead of the default MISC pipe, so each MES pipe can be
pointed at its own dbgext log region. Under unified MES the default is
the KIQ pipe, so both setup requests landed there and the scheduler
pipe never got a log buffer.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index b6356095b079..0f8b9e59d394 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -991,6 +991,10 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
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
-- 
2.43.0


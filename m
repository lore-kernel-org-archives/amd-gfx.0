Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578FBFEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF5BE10E796;
	Wed, 25 Mar 2026 07:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DeepWS7M";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010055.outbound.protection.outlook.com
 [40.93.198.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B9310E796
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtHM5sOCKC4kfzJJMUYs1IohzU+b0ajYKloEOrvxT15B4jnyi/Ajzjoo1FslgY+RZ7jXGOL+oSWDLIqsSbIvGYPMba7acPp/syyP8gsy6+LpSw3I7cKACWnRX/VyED5l2rnjAWzcXABH5qEQgfvfwwjGdt7+7vSN6xMelCRnjwbhpMGI+wkyX1bsIbI/VKVVhRdepGCvd3NhpuUtFuticOlMHEnlaykGu4iGhqTjsmMnpqs8knkuosnZz9JQHyPEEMs+/y9dEepDQPTT+8rw6HToWW9C/87mM73uFcbIKKC0lb5omzFcIm+62N9eE2CAJ4UW6QPYxxsxxBg2UGYwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBBOAWLXkwH3Ec3jcYqi+c/uwdzlc3tE98JWZC32JpU=;
 b=T4R6aSdtrcwYE6Uniu4RIvndtOsbQWRVFN+ne2R4ORpj9AGx0bMWuQidRkbva0lSxVQO+TR9AySnPOpXBWXFeFAWAnfFXr7/qR/CHcTTN+hptQ78lZWBLqYfttwH2Gq1eYgP2OnSG1g8C7xRO2XA6kRigpCEZS7uVs1xxcLEFtxlxovOnV25+OzhZJWzN2dPpz45o+XZWBSGkVpEv+avPLiW0X3wH1rgXS7BWtPnzHwWsQPMw9xQYbuwGbRhA8FZmAyJMQwLPx4EKPH4xIAskxYZ3JyiqQ1Io/yT7Vnl+Q4zt6n8vYHZSo5HTluDerYDqd0QinEAiIpSAfkrITlYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBBOAWLXkwH3Ec3jcYqi+c/uwdzlc3tE98JWZC32JpU=;
 b=DeepWS7M4m0KbBbaPbSZI5Nx/7Ytss3FmJA1wM0ycx9QfYSFkOy/7XKf9OTQZIC2zwo+fLouMgwG1RC1b90ApRZzi2QlO3sTKgGvCta1zK61tP2HTEOZjWcZchTwUUNEHDM5qtCWpfrAjl8o6nMhg73x444OctWx0NGtMJkwzLc=
Received: from MN2PR01CA0021.prod.exchangelabs.com (2603:10b6:208:10c::34) by
 SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:08:39 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::18) by MN2PR01CA0021.outlook.office365.com
 (2603:10b6:208:10c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:08:39 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:08:35 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, Alex Hung
 <Alex.Hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH 01/29] drm/amd/display: Enable Replay support for dcn42
Date: Wed, 25 Mar 2026 15:06:07 +0800
Message-ID: <20260325071003.4022594-2-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 2402f31d-726b-4304-a6d3-08de8a3d5713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: r5MHpCbf9qJw6KttNYe2pDTPZ7aHt/yNJm73mg4OE7nBdj1zE81bZXbVpOCsx8lxwald8mSEiDCQgLl5aj1yLvR8JTV3+rFG7hlk6x+y8v3is+Iautj+RpXJZPRXm7Sgyp4+PV4Jmz41jhwKK9j/WBatAlfo1mDTH1nf88Z0d0H2RrlxSC8+3yxnK/Op5jNj/ebhR/f48CpyY5D67rOLJ9GyiANzeHZdc1pp+Q0oSaTDP14aSu8ReZi/ECOTKeW6rt7RQ+buKpjDuYe4AgiLsml72TLnCUhrtw2FAGKe6GQ8HimVRNaEnleyOLCU32mWYfoAqRo3VxfkuzRFVpgt3Ql3hHGSdwgJhzUZ+hw9Ui60cfrB2dDZfBBKG2rrbGbFlDAH1ZJKo+VE286hD0nHHdeLE8S7XJs0N360K+Rew/ZwmhUI16u59avFr1PEwPe1lGPn+avnAMF7H1z8TB6uk6m+GcPTbj5frgK13s/ymMsAL8ohFaf2WWqXUS8w618wdBwc8lK2VOp6mrEM8dlTV10TX0NwOfGEVgEHigehZGOoFP0SFq+aSAs4dWRZD1bgbsoBjvhsXmRKz1og+lasOyKxGGLzJqQxzNpL0HGBh7ffeKRmdwLM9QzJsxCEyRzFA1Bgnr2sucLlEGLfCDfCxU+JKweHvKRU4e/G0NJ4wTJ4iOG06l73soZoxcdMmD402bpHcDrLynlQHUEVyv6orunsnF1nxi7V7uoi1dJTEB6tyE+1zQx0YXmYcscGKvXBxwQUVEPcELiKk3JHIM28dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jdqM4jSMO9ADO/ySUhCzz/HklXTk3JAq/rP3g4kxPmvRE97f8uhidiCXtE8wowmaI3gp2W1ZI+/zrdbpcjHv4ac7Crl9ehwWKN3HGdVYZXSIqv2IbrfDpIoQDk25iQdBNp4TlULTEELYI2/PI6uzirIFp5NL2VMEIr6cK54okjyMnAqpIVSrp1RrEWok8OiElspU/m+eymBDIQ3k1JbY/mofKi8FVnzu61hTNR1Ha2xqfiGq24Epws4KKEzDXy4n5opKGy1Su1wa67KMnXavEFrs4loQQgAOq0ZVpFscwJ1LIhqt8z1GUR1lGyBk63iFi5GAE8hrZqEl3YqADXAIaIBkiQdqxHmzNa/lC6W6HvxH3m2eUDSCvdjPlVe/elYuhZbo9kEVBe3/AmjP4TFPyRAkYuGfIQ9Fjky05Xkd7RF+mSASv7eTrSHdVwxbaDhG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:08:39.1295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2402f31d-726b-4304-a6d3-08de8a3d5713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

From: Roman Li <Roman.Li@amd.com>

Add DCN4.2 to the list that supports
Panel Replay feature.

Reviewed-by: Alex Hung <Alex.Hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 44294a67c40c..cc1127aaea9e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5577,6 +5577,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
+		case IP_VERSION(4, 2, 0):
 			replay_feature_enabled = true;
 			break;
 
-- 
2.43.0


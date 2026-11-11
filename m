Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57BC606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ly2UsJ7f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E0FC10F8FE;
	Wed, 11 Nov 2026 01:45:59 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010036.outbound.protection.outlook.com
 [52.101.193.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B6A10F8FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9p+xY86I0agB0J9lbZFNvwesCXvtgcUCsNYCgkYbuhOZDWRNo3RYDgNjwDhl7uywlhV2Z9my6wrbTkUMFe8TksScfgHE63hpMFaHFwOreKlSUw+8FYL87rP/33CZfIofmEBX/ziSrxWoxHKvbMJmNvQQn/qTStDksWpcHG0HIjlkLD9TeiA2xKNUDWMtBCmGPu8cOK2YdlgdclxxxKfLxGtLXBusjlcCKABH43WSZzDiK2ZhC+mUbNZSrJZ4NTPdE6+MWUv0fzIv462Acab0nA1j598Qkw03TIrP89F/X1Rpv3STXsk5978lGBAd7u1uEkAlmxtvJJmAogCkE5t+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfgBWuXkZuMBQ3NFOzcn7wKdxxVN0Y3pazgaG2A0MQ0=;
 b=dNfl4urAKygCyoTTV34+WGVF0OQrTL8AhGBgjyRw30AjIbFyKAmtKZDxdwzd/tLmPFw37kIu1lnOl3dyxGcNAhOrNVwFlVtIyUG+UAeTeWZyJVPU+EwDp1YOIKUm3wKjct3PSORgu/KKeRl9Jq4yoL5Gt3/dJeTpXrNTIl/x5qA+4j1BbQ9skNvOhhR7sHzKU3Z46e4YgLxZreflp+LIByNGnT6KSiJ//WS98gZ5OCNCoBEva4BM/Hct//9amVN2kMpbCMmRU2NkmoHs3Q6GHNp1Gm9E48j1RgvhnCSYEkjInKuXNFmdJ1pB4Q2a3tpqPEwBGCaN0BsdaiOn1wLTAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfgBWuXkZuMBQ3NFOzcn7wKdxxVN0Y3pazgaG2A0MQ0=;
 b=Ly2UsJ7frIGagPMAhq9QX/RWhfGHsyeAjlBefRAoFd+k8k67YR/D6a7AyPhaJDRMNYcajvQWD8jNfF56NqdIlKnaGYMLN2KycYkIWEEdk+ytGGfnX2+BKFd/hFcDUuCJunxXL4PXPlmgwmsVRPYeuP/lZV9hCLDpPupP2ENiipo=
Received: from MW3PR06CA0026.namprd06.prod.outlook.com (2603:10b6:303:2a::31)
 by SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:45:47 +0000
Received: from EA8PEPF00000005.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::83) by MW3PR06CA0026.outlook.office365.com
 (2603:10b6:303:2a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:45:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000005.mail.protection.outlook.com (10.167.249.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:45 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:45:42 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 73/74] drm/amd/display: [FW Promotion] Release 0.1.84.0
Date: Wed, 11 Nov 2026 09:29:19 +0800
Message-ID: <20261111014100.3596072-74-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000005:EE_|SN7PR12MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: d49b5569-a412-4c28-18df-08df3f958196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|10067099003|11063799006|261028144727099003|261102123227099003|261021121427099003|56012099006|261022105027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 9CP/Vx/xRKYnA7ZChC9n45VQluYzCi4/sck3dlCoalwY8UdLPSMeNXSxys5rLzLKAf8zLP8GH8VU6a+1r71efs2CHBvk0xnEY21Ae1YNb+hQxAcpGKd60NCPhLiT5lV7WsoXvDBveCczULgviQiEl4Vg/No3lXF7YWRinS1NYCrqtpLJuyPzKsr5tg6xerxN181+WWTRwMSvT2xxyT9u9ehZqY2q3KocDWADwhXZ/VuWGdNZvm+LJmV1yv9nRRBioPt/mf9IzxQqhcf2UTzlW1/PJI3q6E198yNFlxa9WVf878Eo25St3msjzCIBJXHgtPqrHwWAEXNfyVL2nwxkNJbWJH+IBUMjocFT1ywD8Ykr0NVn4DCPwDobgWUwABr1gCShjFokudEo8DV3Sh7/BnrHLvd+xBOLYXgnywY/H7yDdjNqDIjfCzJKkUQWHGGKPGxEtcjIVs7OYaeTHhxG19gRN9Zi+zCvWQy//VAMFCT7U+GoIJ8161DNUFkIvp4t4lhvIAkfV0J2/rzzxiBlpIIhttyc8Gl5ndF7SJkOaEszUbgSHl60+jbCPY6AopKZBq6GmRawh8UbGNZ1slSmUiuQNSxV4ulCybSOLgBS+qCsurEnajUb8deDNwqVW1bEAILnjR6eV62mFFVGCPgs+exnyv/XherOIfBCuHo2uGNGD3gf8Or9QcXAUrv8sd14pdySSD0YR5Dn3TRKpFqKIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(261021121427099003)(56012099006)(261022105027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q3Wyh5B6vC7XSrijRyCgsdT1dDIejCbjPH/cwglc014XNYaapFjBikUBnzHzx4FQqbPA/JFjvIpn6nhkuQUv7CEbnxwFhspwgyyIp/WxSFCFkU0a12IC6t8Pv7Eo/Fg6zfeXwMW42t5RKNe5I+Z5RzzeNXQIth6Exz/ia1XQ0IlUzhMsJTsM25mYW2VhCEGbJUvpKVhC4g+txv1eC5P85pH6flY5GKxwTN+Ti3PIJ2+FDOVI0iqiT3cXlvk7rRRtOOubI5AL8ID51HCQTFLI8W3C5Qf1ImggyzeCHgaKeniwwss9DN3hT2mDhxb8APz+bfa6+nBQURWZjqUja66GK44bgqqNYXpvdC9vIYNh+Qrs8o36ReY+6mZJDb8TDK/wtgnhaxnK4ArP/2G03ZDYsueY85TWRb6dYltgr/7A98vSZc6bWR5hC1y7EFw7hSVW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:46.5324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49b5569-a412-4c28-18df-08df3f958196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000005.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

Updated display microcontroller (DMUB) interface
- Add ramless_lobf_state: disabled 0x00, link on 0x10,
  Advanced Link Power Management sleep 0x20, invalid
  0xFF.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index c3aa0d0a74be..e9eee64fd834 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -7781,6 +7781,16 @@ enum ramless_lobf_enable_cmd {
 	LOBF_EXIT_IDLE_SCREEN   = 4, /**< Exit idle screen */
 };
 
+/**
+ * enum ramless_lobf_state - Ramless LOBF FSM states visible in firmware state.
+ */
+enum ramless_lobf_state {
+	LOBF_STATE_DISABLED                   = 0x00, /**< Feature completely disabled */
+	LOBF_STATE_LINK_ON                    = 0x10, /**< Link is ON; Vline interrupt registered for Vblank start */
+	LOBF_STATE_ALPM_SLEEP_ENGAGED         = 0x20, /**< ALPM Sleep pattern sent; transitioning to PHY Off */
+	LOBF_STATE_INVALID                    = 0xFF, /**< Invalid / uninitialized */
+};
+
 /**
  * enum ramless_lobf_phy_mode - PHY power-state mode for Ramless LOBF.
  */
-- 
2.43.0


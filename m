Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009B606A327
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gRXivV92
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004E810E425;
	Wed, 11 Nov 2026 17:32:08 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B8910E425
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 17:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hS8qWsMm/crpzHgcqcyOdUeh4TaV7acn2+LrnH8/uAe/kV6l89fC7E0Pq+jyaI4OnG3SaLvnArZRhdbCUofxYb+lrTQl+s3QKXBFYlGoyEq4yn4ZRTU4btbTw7ne9KVzNTXL6IGZhdju1zQZW7h6mw+qLUbRvujZtM3WMIQy49ub4W3MVr3EH52D9rpuAPB4B3+uDxWlcv97UMOFFR+fvaWAoHAXjU8vg/I4p+EbBbvz3nJ85Vz5bDLjnjh97Cv+wbnLMSjEvqXugIGvxoANiQyiU2dDYNlhMdvvAhdMIk12FymRaNq8VYIYjDIF50fuQO5uTsT/HkQYJ9RyKgIjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vqTD6RRx7PvlClPoZnJ0WTT7lmWFeA/nGUJNbdUHAw=;
 b=Q8wFGe93TkeZwcilJuZso8kUlNAUhuSijpadY2k2Ox+TFfRFdL6NaNi5fMKDBbgL+0jzlonQfPu5dK+dQT27Gm4LqNQxmiVOtccoJYznG15T7jMIRIKMqsbaMA3aYhxknvwWciOKEjSHBTWP9yqWk/ubAzAeghcYgoDHJ4YF8hzzMKILBYYS45fMdfUQSXCKsNrTrZe3eeiy4qyZ9LjYoJH3vnASwy5tBaV6h7nWP5Cv13ItRzGuIGl4eeizbn6OgtUQdF4xzjeD49ccGsw/PTu73+Q4gJjmZh22vBy9uqak6UVxd1oQvHAmkJCUfmAP69V6mVqBE5SyavZkdiT7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vqTD6RRx7PvlClPoZnJ0WTT7lmWFeA/nGUJNbdUHAw=;
 b=gRXivV927zn6AbgCzLkChFn5c+/EPu5aVc6IRxXZvxwB2ppcZ6HLGR1nQ7/JRiBG5uU8vzpYwzdtttceUUIJMlndW33smdsMW/KV1+B+JcAJzFDZibBuXD/INw/7nmZ3gNP9V8lpJqmhtoheaBj1z8XPXVQ3TXjMKLm5ncVv43o=
Received: from CH0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::31)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Wed, 11 Nov
 2026 17:31:57 +0000
Received: from CH3PEPF00024581.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::7c) by CH0P220CA0003.outlook.office365.com
 (2603:10b6:610:ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 17:31:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00024581.mail.protection.outlook.com (10.167.252.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 17:31:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 11:31:54 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 11:31:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Jakub=20Oko=C5=84ski?=
 <jakub@okonski.org>
Subject: [PATCH 1/2] drm/amdgpu: allow dispatch tunneling on GFX12
Date: Wed, 11 Nov 2026 12:31:45 -0500
Message-ID: <20261111173146.3157865-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00024581:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 9357fc9d-800b-4086-ad49-08df4019ae1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|10067099003|11063799006|261021123027099003|261102123227099003|56012099006|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 8zmsa50M9u8o2nGbSbCNeyMKkVYzXQherUJk5jICtd/M7reKY4ScJ9tE/Ymby/uBvY8pPKntubSGrCJBk7G3njJExshUimPWCu3mjt89ifKiC6fFGNjT0ShIHmEM5AIDqFzSdQTSRujhhh/9LrWngAEFYHULf9Eq95LjLZfGta330OYIo4RHjibEnfrXV3DGZXKH8DE836u1UBmsCpRzAy3kdAsCJmpulMmZylqCDleUxGxy8ctitp84JJRS4shAYi6R0KDgXBJ15NsY53aC+1jwlHVtOXZtst9EQObhUV/ExQkqcIrb8XmeatIMyYyJdOrXAAsXWDl1L7lzMgWZ/d5xoaKJ4c2laQ2VM80AecWYQgm4z+3zDZbVwtU69XZJTclbUAiDDuQgZAT2AzMQKBYl7ysN+QXjEkZunfK65N1JeND+M/Hejky1Da0qkWhjBTFER3UmDX54f2Wlct6ftWgyoYYD6kkjZ8x4Fng0feEyhSTbpUfRZA9Q2s9zWeAKoedBRmaZXK2HjLe/n7m6v/oZgbdqdDduH2AwGFgxJAdK3U8CzdTnTp6evC38P4ok0ZzwpZokHJOvHrZ8bBpYoRNlMuwlyhgwhRbChdpgsxH76MWwE323LDEKgAOrmAqiWvQIEpb1RzKUm7jKet7B7/9tbgm+McXuJfWsq6uGQvQlQh5depHHjopByRuxNIUynyopPRBW1UODhWqWk+xGbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(10067099003)(11063799006)(261021123027099003)(261102123227099003)(56012099006)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5UB59vmqYgA1M6xoxA/hsn/uJbdM0irPLPL244gBLcSrxXiZjkFIUHWHZYPIH86HET2NvlVDS/6A2pKypAnV7v0c3Y9NWh9RMX58rYLhr9+W/GY136PSGPim/cX6cQ+ziWXEccpdFFwvIrBo0w1ZMeauMIO4QGBoz68K68zYXdcLdRw/PEU2lcuOaFJsexH+PHbRArBHynAlK78+Xk8klZaXRZliJTd7H8fI11i90+U8EIpMhlMN85vTzbSOXdLL3sEt8Ew1W5VyjBTql3iuu9rjo4tfT0FOrsAyuuqz4en4Pm9PRAZeygUewnsWbqMXogMgfVpUfM8kEkOyHT71rtdcp9CfyuaSuqj70KpXSvPnYnTwz+Qrc4MCD3rw9Kji3FgvAJOnTm6YxvrN83XhGGfTC/bQTTQ8yBip9cMX2OYa6MTJAQws04z6LuJDE3Sm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:31:54.9320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9357fc9d-800b-4086-ad49-08df4019ae1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00024581.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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

Was implemented for older gfx generations, but got missed
on gfx12.

Suggested-by: Jakub Okoński <jakub@okonski.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 8569c371916ec..1fc74e53feffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3181,7 +3181,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
+			    prop->allow_tunneling);
 	if (prop->kernel_queue) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
-- 
2.56.0


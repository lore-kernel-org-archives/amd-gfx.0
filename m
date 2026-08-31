Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E0EC61DF0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 05:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A6F210E5D8;
	Mon, 31 Aug 2026 05:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUo+oktO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A2310E251
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l18l7r/2UfXTg3QMbNcfuQ2Vhv22OvFF4MylbGUooP37yApSQt0xPmptgsglPi7oDUIQJwgkHOFLQL6oIYFTnv3U+xXdsoLGOvS+xi0/JHKqUJMGCMnpht4lxAQuoz7293hm+qdzZprU0X10xI1eTUYZ7B+do6hxLIRq+6oT2m5nK5/e0gggv1UQUc8V0QJ/bpm/OyD/bmGrYHwIKF7tuXBaBGGPI3zqRKItafKOYzwb0x+K5sagqX4X9uhhkDrncp/8l56ysusjB6cAYj1Bba+4KJqmxsZEZjqmUZHGz9NNDXz4bXfnX9zPNEwFZNt2VAwg3h6zt9SAgwxHpmdRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMbi9zXcn5MSsWT5cEGZCZyedyEvV3vOdsLKEfF2xNo=;
 b=Ahjk7Fuey7iTzpxgVhEVncIAP8Ow5B9gkhFkD8yfIWssRSsRwm94Qw7j37zPtBG/IRqX7+oRbLgDCkE0KU5DjO0OVTk6JK8mOPFIyCkVRDs06SreqwYZzDNl80FFcCIIL5Q02dWRr30P3FqO2cjJqKuQAypBQxsQR8BIsCHvk0GAfZmnJxEsfdzCw+bMzqEn54Lfbb1nelzWxo4ihTAWvPsOEyxN6rOET+1h3RTqoWYY9vxlHNi5MXch1R0xT4R4tBdGkGvOQcdiz9pRYbTw0vw//aQel7jisMYjC838QhitWs5mSsxWA95Le46FZp1j+fbww9UCBzkCx/xVDFdERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMbi9zXcn5MSsWT5cEGZCZyedyEvV3vOdsLKEfF2xNo=;
 b=DUo+oktOmhfUUU21kZOeQWkW5plxi3h+IQpiwGYL97r2oogsfYs/70zH2dNwuJYPUl2FUJVjZT8iDm8mbyCKi0fBB+T3WXXsE0ZQ/jhOKYWYuXpxa9NCgznDnx401wDy34Ki5qO1LPR+ubjGqzhInOdRqjF6uhMg+kgO0JxkAzw=
Received: from BN9PR03CA0597.namprd03.prod.outlook.com (2603:10b6:408:10d::32)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:25:18 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::97) by BN9PR03CA0597.outlook.office365.com
 (2603:10b6:408:10d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:25:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:17 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:25:16 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 02/10] drm/amdgpu: add mqd_prop modify flag for queue MODIFY
Date: Mon, 31 Aug 2026 13:24:14 +0800
Message-ID: <20260831052513.1518180-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c28ed54-7501-4a04-a245-08df07203e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: I/sw0NdGAiGyFXKMKf3tJjkNLIYx/J0dgsh6AWtXy5kbhPEg0st+J2Q446Kvlp5VVWglsUMRv5ElZfK0muxC6fQ94lAMNjGapi6MdhhieFScABa7612sPjyqzMvbQdVhToU5ptO20u2W4BvUTmd3p2MdblYke4z/gW6YyNJ9GokPqikN0GTofSJN2hyCRDPyMtTAtgLjKxRCNBkF71NBug9RoZbCChaWAVmerZoUpT1Rde6rG7dfeYK6keK9FDbjjSj5n55zke6Vy8xejx7MqUjTrA6POpVweLMegyRR7YLbyvi1qTyH99gs59xkcAmJSy+i2IsiNYWWWx2qBaA2vALwopiOa6EOiiQEKpa6TwIjK1SQJQ+qA2ssyg6aEoRK+a7hKLvOkTRViHa4KLdjw5Ccy4a2JjKIyS9ch9Q7lNkD5MX0OGS4YYGueYdc4EiXCWQ7IHCcH5TEi6cbI04nvFcZen6rB5vtMVlSmqueZdgtSVgtisdJ7isBTxFAnb9kLC68KGhzQPsl0sfLWYKK3ETo1Hhn5SkGYdDQP1U7NgxiwfzMnEi0rj0ncbWWe8wWj3EEo5R2Oa3t+Mns/8eyI6uUmg521Uq3DAAsr4lXF5tNetWUXZUaq5y76XB6jtthGVM9N5l+Jn5YX+72L+Ys9AdyfqHHPYwdaNTMshuBNYBAcsLcJO1dMRK52szvB4BtNp4Up38qv2KA9yQfGfwLNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gJc6ezg2yzbcm6keSNebAh7Nma90HPOX80GVay24SVBkyAI3I+1DWjuE1KhDgcwTtkcUI5DWocNrBEDgFHcNGINqoKv9bwAPMlsPguiR7Jsfyt+m7P5RyFSQi8EolMdipVY/7Oi5deKFD6VGdQXNTz6Q/zH+ZtXd5DJY9L1Hs5CjIErua7jLfYp/fvcQ5NOQLA3ldMJEcgK5HY8U2OKSvUMVRqXctKkYziZLJbJfb8WyK1zUjtFJYadimyXZQwX8ROnn0XPJInK71oqegpCPM5ay9yyva7ZPbFZYDFzKb9dxm/ZcXjWXe5ENFwb7/Cn3TUa/tmvu7JOsSDly18lWcocvyY73MGZcb+E6bw7uxygco9IPmvN7NRRqBI+i2G8n3P2URKzeAS9LQ1PLS05k4QrWWdwIWqVBq/WGzkmiUujlbIjKY2yiTN3kVstUQZjB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:18.0008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c28ed54-7501-4a04-a245-08df07203e98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464
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

Add a modify flag and user_wptr to struct amdgpu_mqd_prop. When set,
init_mqd patches the MQD in place: keep the context-saved rptr and use
user_wptr as the wptr. KFD already patches the MQD in place for the same
disable/re-enable sequence.

v3: use an mqd_prop modify flag consumed by init_mqd instead of a
    separate per-IP update_mqd callback, per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 63670b41c26c..df4aae01b285 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -494,6 +494,9 @@ struct amdgpu_mqd_prop {
 	uint64_t ctx_save_area_addr;
 	uint32_t ctx_save_area_size;
 	uint32_t ctl_stack_size;
+	/* queue MODIFY: keep the context-saved rptr, use user_wptr as the wptr */
+	bool modify;
+	u64 user_wptr;
 };
 
 struct amdgpu_mqd {
-- 
2.49.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0680C74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE6B10EB72;
	Thu, 23 Mar 2023 21:41:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA3910EB58
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asTXTqRFXV16XU2playB/zsF6bnf8e67FXMU0RK6bF0RK1uJc1W5tEyeGVIaa4xPD3GQQWV4Z1U1pAhjFFy513MJ4DJi+xGrMVShMjKIc2erwD73t4Z9bG0khY+aQIJiksLAelRJYkPAWmUP2stRQDv8sxySR3F8xrTxSTVbIq7w62KT/GJZavwFKrXCHvSBAHEk7bAkYiOcVls83O9tjtCD+y+1x0xcojvGxP5VPAtWX5RM13JU94Wn+HMGgPHRZLc7hpiC+mppvdhgDsaJCeT0+xf6IGELRU1atevcXumgxhM3Zc0UHD9OlE9JpXB18J00i6uafUIWcArT24QJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP8TdcQ7fOBVSOx1VcvZ+5le8IzJVj5vEelNeSyGjGY=;
 b=gJqNCINX77FGxELmjwZ0ZLvUM/cbeg2rUNVvXcT1qHtNfRu5BBLmcXi9M/SS6OvYe2QSFGP+RKrp10djazvOuqNRrWOZU1DICdboApgFCzybuDfL59Q14mgrziSRpAophAF50Q8dRcGe+g++LMvSZ5Y3RE7dHhs6FWSJGdk8XyGI4iRCVER8+4xHftkQPVzPGtfh+f8PeCD4Cfh2Zj4DuPFFxxdMlyIgJvQsJCj9pyuLo8hlNXYjLkSZQj5NmL4LDAbULGQ3K5xmqGeZAHzlTRagJ0CYafphGOjzwK9nP4OVuzqEmIKyIYfDSLZVyBslbxFQfb6so/bABJ9Vjl+mlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP8TdcQ7fOBVSOx1VcvZ+5le8IzJVj5vEelNeSyGjGY=;
 b=igjyiFEaRtLGgcfiWCYcPaRyyOwIlE3z6NH9hJED1yRhcQ6e8Ee6wQ37EBDh4qlV34X3mUiP3foiLXaL8reHWs8LRPbNvTLpgjApdFkqwW/0z9Z/5YtnVc5nBNlMG+elgoEONRZnRPxcGUhCqYUqxqhMXLf/x3eWn75y2e+NR2I=
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 21:40:55 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::26) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amdgpu: track MQD size for gfx and compute
Date: Thu, 23 Mar 2023 17:40:33 -0400
Message-ID: <20230323214034.1169310-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DM4PR12MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5f87a7-e6fe-4293-058c-08db2be74858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fulUPtcl/jQoNJxWEb2StIXpk/jKCsXZPiawEMEAE6RZD7h8RqKzoGSHKcHYz73T8MKxoEqsIzGSuBzC42OEG0e7f+MIpA7WY9ktOt7gScLsQjf1WVDJR3qdywnRAPdOXVuPb5fpBkZLSiKD+3e4CUlA1frMtIwFEfJJ6bJBWzMi9Y4iVIEH5RCU/BzoxLGjnp9zeH+akhZuo8OXCdvYm+GIY5klCKF8qOWqd/irPCiKVUKUlPTfumOstj5vaNXhAJWoQxtC2yjFnaTv7vlfM469OCfzCSpvtDkKvlXL2xbg46afjfLlgsRYRCamuipQq68sGoHbEju8gM5K122Bm0SgW9/MDohnLB4jbWD+pACbUXVIlkHyvpJ/3jrxz375iNQCwEXJwpP2XOLh40B9OgRJp8w8YwYlKe0ipwWsgLu7uyIFdd5zW/RctxDkaDmpDodL2+yZ7utVXcukHzQZOS/TPoeOlEztDvgExQPPwMtuAu2egxCxp07ICs97JZKwGSGUCXXAD7MNarByNxMYr9GJkORmgiJ+zlYlai4bLLvPWZbeCoPQkYpe5lDs/H2YqDwXe17CE05fD5bsm9UAic/DNJrYniLVxb8u/GxRyKgev+IjpDixPx5MTGjnNykR5Y3zsgBEA86WWyqBisyXBR4VRCW6kDQTqSEFEr+T3yQ8W7GFSjO/vkSmC3skEQdM6rQea+YJt0sIo9IunGvnXLUhsQ1KqmqI9fFnI4wYimo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(6916009)(5660300002)(70586007)(8676002)(4326008)(1076003)(70206006)(54906003)(81166007)(41300700001)(82740400003)(316002)(8936002)(6666004)(426003)(47076005)(26005)(16526019)(2616005)(186003)(478600001)(336012)(7696005)(86362001)(82310400005)(36756003)(40480700001)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:55.3443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5f87a7-e6fe-4293-058c-08db2be74858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It varies by generation and we need to know the size
to expose this via debugfs.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c50d59855011..5435f41a3b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -404,6 +404,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 					return r;
 				}
 
+				ring->mqd_size = mqd_size;
 				/* prepare MQD backup */
 				adev->gfx.me.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
 				if (!adev->gfx.me.mqd_backup[i])
@@ -424,6 +425,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 				return r;
 			}
 
+			ring->mqd_size = mqd_size;
 			/* prepare MQD backup */
 			adev->gfx.mec.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
 			if (!adev->gfx.mec.mqd_backup[i])
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7942cb62e52c..deb9f7bead02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -257,6 +257,7 @@ struct amdgpu_ring {
 	struct amdgpu_bo	*mqd_obj;
 	uint64_t                mqd_gpu_addr;
 	void                    *mqd_ptr;
+	unsigned                mqd_size;
 	uint64_t                eop_gpu_addr;
 	u32			doorbell_index;
 	bool			use_doorbell;
-- 
2.39.2


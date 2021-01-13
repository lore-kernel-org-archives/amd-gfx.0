Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6DCC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 06:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D98A2310A
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 06:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D98A2310A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A790789C19;
	Wed, 13 Jan 2021 06:36:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C26389C19
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 06:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmhBgPiwib8ul2z4b3JnxBOIlGcIGAGbQkHxdxoevvKyoQjDaZPUuOMCVZ8os+KYVyOY6IDLLw5ThnfO8S9HYohWzloy5n+AZqkkgesDc5aFk7glA4E2uO5SEcTrZaP31o4UZmU4zrMlvrXEmxOa+IlGGo/rrYGG4KatPPdw8ATNF3SIwiWAJe5G2VSAIijQ5VffyenSf3oMXWtdQFyexMJzvvWBIyBKyQxlh3sKcQ3Cx8FSpdmA/OLrsFLcxkeylL0tFB1Lk2Qt5VRWMNcjVg78d7Blr6J34HV8RKrQPRIxXVhyUOhPpK4KDoZ4xgDG6beuAGzg+6mX1vCRV02J1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH3AXccf4YpvgEK33wtIEKheprwzwrb7KD6Vut125lE=;
 b=YjVmDXJD5dYk6mCWU3EkPUnjO43squomAb+kILv2LHqesLOaegvzIDI40pUVQPs9FfqYF6djhiDhpejA0+fDAOUT69FO2NDNjRFpyf48An0YkaPAp0twVpqIDq46cU3501OA2aPHAe8ra1STwcpc1y/UMWL8+IdD+Ej5yuTnuAowgFBD3TAmVjefAKfNIxWj0WyYPovqdzBxa4nv/WUqC2iEgu3D4M7LPEwKbIL8aFS4+OK0iXO2E41iKuniYIAipy+PRtsavYjgQXygItQ6kOOSK4GilZYFrRW6/sTru4ic9YekrmNfKrZ+SCwGI9o/oe7LRY6Du+NSTBSDxDy93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH3AXccf4YpvgEK33wtIEKheprwzwrb7KD6Vut125lE=;
 b=kwV5ARb73Xq3tNA+RBqmIWp5ry27lcVoSqC/Hk5mKiVfwsWYlWPGrSC1cxFqBAOBUlMHJTL33GEipkeX8NC8fwQK9ML6AGTbOcgB41wCaUrvReCpA7Gqhf0QDkSTvV5m888SI38Ca8sMMrahXf8byIJCAzafuvUdbefeFynx7sA=
Received: from BN4PR13CA0010.namprd13.prod.outlook.com (2603:10b6:403:3::20)
 by MWHPR12MB1824.namprd12.prod.outlook.com (2603:10b6:300:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 06:36:48 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:3:cafe::c5) by BN4PR13CA0010.outlook.office365.com
 (2603:10b6:403:3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.3 via Frontend
 Transport; Wed, 13 Jan 2021 06:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Wed, 13 Jan 2021 06:36:46 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 13 Jan
 2021 00:36:45 -0600
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 13 Jan 2021 00:36:44 -0600
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change the fence ring wait timeout
Date: Wed, 13 Jan 2021 14:36:12 +0800
Message-ID: <20210113063612.31468-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 043fe095-3ed4-4465-9214-08d8b78d992e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1824:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1824D8F5B9A62B506CF15D1AFFA90@MWHPR12MB1824.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMS70e8DDWBcJkvYArfz1eL0x7oYC5rmcXGpmzuTsSrMfTyKhgn1FnBto8iWlWos+aG6L8Xcbdm7GAm8sfna/6F5K6zMAzgchEi0dop+PLW87/AaeziTlrRZdTZymM7Ryih0zO1PApxdbrVRPiNDHg3XaS+uX7Wq+qeZ+tus0c2R9aTnsAS7sGA2WRNg9yYu43MOFlSx1k6U96r96RJheSzqz8NiltldEafu8LuzT0OG0xI+DRER3jDLmEIInWxa8NspPWPIoVPQCksbq+O3MXx3uIK3UIgPrknzu+DBsC+c//kKMmLS6vy1joTt/a0NqwG9vnJL53zunnUT8xjiurEAN8Zz4lQ1b4E4E91Uug00Te+vqLjvSETM08iw6YovzgEygOSKzE7ZTsK9107wsVWqk55B0gogbhu2PVUEU0uYQqwE6a1iR01nW88grnaui/2UE0SCka/lr0ORgXaS1yfyQqU/5iy0DoclPO2kPdIF0g/3zpBNt/Be4YnReDW/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(5660300002)(82310400003)(34020700004)(8676002)(83380400001)(6916009)(8936002)(2906002)(70586007)(316002)(336012)(1076003)(356005)(81166007)(4326008)(86362001)(2616005)(47076005)(70206006)(6666004)(82740400003)(478600001)(36756003)(186003)(7696005)(26005)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 06:36:46.0713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 043fe095-3ed4-4465-9214-08d8b78d992e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1824
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
Cc: Roy Sun <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fix bug where when the engine hang, the fence ring will wait without quit and cause kernel crash

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 48 ++++++++++++++++++++---
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 6b0aeee61b8b..738ea65077ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -41,6 +41,8 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 
+#define AMDGPU_FENCE_TIMEOUT  msecs_to_jiffies(1000)
+#define AMDGPU_FENCE_GFX_XGMI_TIMEOUT msecs_to_jiffies(2000)
 /*
  * Fences
  * Fences mark an event in the GPUs pipeline and are used
@@ -104,6 +106,38 @@ static void amdgpu_fence_write(struct amdgpu_ring *ring, u32 seq)
 		*drv->cpu_addr = cpu_to_le32(seq);
 }
 
+/**
+ * amdgpu_fence_wait_timeout - get the fence wait timeout
+ *
+ * @ring: ring the fence is associated with
+ *
+ * Returns the value of the fence wait timeout.
+ */
+long amdgpu_fence_wait_timeout(struct amdgpu_ring *ring)
+{
+	long tmo_gfx, tmo_mm, tmo;
+	struct amdgpu_device *adev = ring->adev;
+	tmo_mm = tmo_gfx = AMDGPU_FENCE_TIMEOUT;
+	if (amdgpu_sriov_vf(adev)) {
+		tmo_mm = 8 * AMDGPU_FENCE_TIMEOUT;
+	}
+	if (amdgpu_sriov_runtime(adev)) {
+		tmo_gfx = 8 * AMDGPU_FENCE_TIMEOUT;
+	} else if (adev->gmc.xgmi.hive_id) {
+		tmo_gfx = AMDGPU_FENCE_GFX_XGMI_TIMEOUT;
+	}
+	if (ring->funcs->type == AMDGPU_RING_TYPE_UVD ||
+		ring->funcs->type == AMDGPU_RING_TYPE_VCE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_UVD_ENC ||
+		ring->funcs->type == AMDGPU_RING_TYPE_VCN_DEC ||
+		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC ||
+		ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
+		tmo = tmo_mm;
+	else
+		tmo = tmo_gfx;
+	return tmo;
+}
+
 /**
  * amdgpu_fence_read - read a fence value
  *
@@ -166,10 +200,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 		rcu_read_unlock();
 
 		if (old) {
-			r = dma_fence_wait(old, false);
+			long timeout;
+			timeout = amdgpu_fence_wait_timeout(ring);
+			r = dma_fence_wait_timeout(old, false, timeout);
 			dma_fence_put(old);
 			if (r)
-				return r;
+				return r < 0 ? r : 0;
 		}
 	}
 
@@ -343,10 +379,12 @@ int amdgpu_fence_wait_empty(struct amdgpu_ring *ring)
 		return 0;
 	}
 	rcu_read_unlock();
-
-	r = dma_fence_wait(fence, false);
+	
+	long timeout;
+	timeout = amdgpu_fence_wait_timeout(ring);
+	r = dma_fence_wait_timeout(fence, false, timeout);
 	dma_fence_put(fence);
-	return r;
+	return r < 0 ? r : 0;
 }
 
 /**
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

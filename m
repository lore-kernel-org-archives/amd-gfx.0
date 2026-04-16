Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E502FF433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD1510E7FA;
	Thu, 16 Apr 2026 03:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="POst94jj";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB8A10E7D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We/k0MrymTdwqwGGAJpfih0/QrP9oTgbUe0b+BoSrs8LXtOTgZuI0bKlWxVvh+YOe6EQyKUX/EJbpiUdIQPPgTj6FNgO+HB/AYKPf5cA3h1xXktnwy03yaQ7IKMI5DrikKuANI+PrkfT5QNh1+ud8+tnVZxNrwlEDJVaGksig457tSYNBYlZDf7VYdXFfpsVaOQ4lYKWsUpLesbdZv7lE39+8doaWbQoY77hAHz0YXO3yW1KmG/uWzE0kakTfv+49LRmmJmaF4zS+WzQGJE3eaeYLDRf4tZP+Rr7zfJP7YH2doHUELeou/7MuR2GQNUIRZZQpyHuwNuPB26x+4Whfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQml/bKVo87LkuAGWgjfZpIyv8Jpl/XyDRa26mRcDXQ=;
 b=rhRwY44OPDrT3ne9gseUh3/watOMxfyHA8KYJ6zpH2c5fOOstNXi4HOjuU3TWjd3XwtdLWwE1xe+KlU3ft+1O1BktCfkTgIyZlqx6N6BbJXmoo+gBzWYDHa0EtSAgCOPsQG+63eAbw5xAyZtJ/xdf7Y2vnCZe1nlJ/Ogd4fXu44aMCezRNzwsj6EmmQpd73tZEf749s9MnxtvJpYHqPdvqu4+1CEB3ipv2KOxxdCppqN7hu+RaVMhH8XV1Hm67mFv18PrjyWZGBGfaY8IKUU1/t8+zxViEjGL+6nY+bONfKtVjpOEDiRhBSe5e7ME2bMii+hBR35idCFyrzSVtk7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQml/bKVo87LkuAGWgjfZpIyv8Jpl/XyDRa26mRcDXQ=;
 b=POst94jjCrKXaz4/BUaWKZLCnnABgOZ6lvaG5qLkU51S1nT967D6CpOEnNNkHlZ438k6+0AeJJ5mlMQCF9NaMEoL/Eyy50TkFsiWqqBTNN9fqXfnVaNvgbrJ/i+0XvqURBS0VCSspPyAj3lxiPG8JLTHhYLNnuh6naMG9OuJdyY=
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:27:36 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::73) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 03:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:27:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:27:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 09/10] drm/amdgpu: Signal MEMORY_EXCEPTION eventfds
Date: Thu, 16 Apr 2026 08:56:58 +0530
Message-ID: <20260416032659.2368054-10-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
References: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: 234a7766-8cb2-4e2b-b25d-08de9b681b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: nL1BqfLybvQC7ZbYwKd7AYVCemRju0QceqRuVQn4ox37xC26bSWhJlIsKRHsWxpg7rd0QnmGX1YNRhxlgoj6E4SUGPTN6wYHdYBxHOrD4SEvvJT/fVRmToPHcp6LKWV0nN0qCqOJs+ZFX1GtaeMAAI2FGARq8gljNWqWnmOMBjrlnN3yZnRKWuPXuJrQm3gvlbU+271bzTU6/6dnkMJjWQ+IP8QGbZ7BHTEnfqbSG7kFb/6PO03CgXnre+V9Q2GcTykrOfx4MwwVS0/BwypUzB2zj29lrRnSLiRZsJrcbmxW8OdmTpPNzm8eLyIiaZ8XKzoGjZBS3aDLmR8nLHOSZ8UOUHaaP4u4jLsJC2ARKeyfa0LOcF8fV2ZDW2iDPr3dK1uN+Ny9LWRAPlsPg1q2Iyp3eQGWtfCSmbkzSQJHMq4obDFrdYk9xMu3J+pBiOYSL3ZJnr6iy/qo0txLJwx/SEmLmEC72l9gOVS/PCliX6+vtGxiwZ5MTRIMOUlk2GXJRpli5xMpPomKhd6J6o5ZurG18mtHr+27LLYKQGvJ9d6IBLkefEpyuU06GfIjHkw+Y02r4+MFS2REIH1IcjNcJazPcnYbJtzhbjniHWcQ0hkBeY/HCGdxE/vRaV+IFxdKUF3gknMOomh0oGWwUKsxW/FLwdBFQ52zP4q9mZA8zE+NvGY9Zz92DbIfyqqN0x3dFIA8XQdzHazyRxZXE7xfsB+oX/YvQMvBmK5FGWrUz698G7Yc+oae90X7NClLqwJvdZkNaL7+M67s64s6VrIRlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GLaZVQ3S7lvkEaPBOdI7F/hgsK05fbay3waEy3ActS9AMY/fQlSNyhms3/SMWiVRjQ0vSsyYGFZ4qhO0UWdl/L90ZcJvFgLrJphO1Wog8fTcrQ4VPQ+y2SLN5rwfRTLjCxTEcCLBD6mn0N0ygc6UzS9ABj6hK1KeqZW/DKkk14tCZq5ZWeRunVE5oF+Cvck9b1aMqaFmHrfbQYyjEJiMINrMdWXHe9sRJfOQxymvCXI+gXnFYHjvEJeVV9nTE14auINfQ3NvkSLTKvB+SYwSHsj3HPisumDyOvwuCXAnIAQgvgrOI+ScMgnvRtOVheDUVf/yLppj/wEQCSKDqEG2856YE50tKUmlUaDylAPAtXx4AoQ0bHRmobJgcsDrMrcAp9Xmzube8BHDaffuaC2bSRcUl3R9gQyY9Cl+2LNTxPzLqLtBb+Z0ZVypBJNVWTxi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:27:36.5498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 234a7766-8cb2-4e2b-b25d-08de9b681b11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673
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

Signal MEMORY_EXCEPTION EVENTFD subscriptions from the KGD-side VM fault
interrupt handler.

Reuse the existing VM fault interrupt handler which already decodes the
fault address and status. MEMORY_EXCEPTION subscriptions are currently
GPU-scoped, so eventfd signaling uses queue_id = 0.

EVENTFD remains notification-only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 94d6631ce0bc..d49fdb70045e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -135,6 +135,19 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
 					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
+
+		if (adev_to_drm(adev)) {
+			struct drm_file *file;
+
+			list_for_each_entry(file, &adev_to_drm(adev)->filelist, lhead) {
+				struct amdgpu_fpriv *fpriv = file->driver_priv;
+
+				if (fpriv)
+					amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
+							      DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION,
+							      0);
+			}
+		}
 	}
 
 	if (printk_ratelimit()) {
-- 
2.34.1


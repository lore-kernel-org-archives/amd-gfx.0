Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48294C88E50
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA5310ECDB;
	Mon, 14 Sep 2026 13:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pam3Kj6Q";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA79110EC7E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7+3u5mQMfPBFQVa8pLu88R7UbCfsnko6N8Fn9x6DWO+Wdp04+CRDv6mytHNpZ4K+BA8EgTfyVjQ1cd7u3OoVz+axiAQ2lqW0I/zwLSbnc3C16QMtGaEU4NxxPfa3fKRgdUyCH843WagXEV3grp7lhB6HoOZyZwiHh7m/cKveNdWmBGFSOE0eudf9JxWb8h626pMe8FyXPSBLcD6kQSvaQH9IX7PfXVYXpkBJ0f7M65ODYnMiS987BWmlao7qIL7aVRFs5EhjzrAPDLBua/CRrOvGB2TgRqNfvrQYHehWgJOq5PhSeeBvbdgaxTggCh3LvLok9aA+Gg/dNHHrysWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zvcDXh9qAvhXXeoSgIWgZysfoQ4n1usNKyFZWFUlfc=;
 b=K5X7gyDdNOnvoqyCHwcnW0mkWhxFqMA2a+xYxR7O/m1rbtHo+SeSY/wuJ/EVag8joM7nvTc7isqSls300HUuE6nPrkCL6Sq7fnvQKywtw2v/KGtvbbyUHYQHMpLuSosR6UOIjDXtoi+ybBbLhP+1b2hQrp4AxtWbmxtUYEG5cecQVF5WEmFUzg63w5Xy6wJFtCT/b7/SOnwndb+xQHZ96FhSK2CZMmYb+hiQ/T/B1xi8sLn8N42C2+ty9dhZLAKKjYmSmlcIEpchhkzMHquC4GU2wU9oWfeELnMOfFm6UsHeSu3YqdY4+KcigY/kQF+0B/0OdFOoSQPdgDsCqyqFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zvcDXh9qAvhXXeoSgIWgZysfoQ4n1usNKyFZWFUlfc=;
 b=pam3Kj6QjVoFR21pcJt/luOgr3JeAPCJHOc+GLaB3eVindkMsawAvwxA29H2LRJSTnrF3BSlBrgc1+0AwSpAu7nFWxHXguYcRC1KTVy82Z5C50lbiVdREPN5psCNteNLEr/9rk+gQZjLY1H+9bopHHkD1Dc0P0yWjK/kiSYHudk=
Received: from BLAPR03CA0103.namprd03.prod.outlook.com (2603:10b6:208:32a::18)
 by DSVPR12MB999284.namprd12.prod.outlook.com (2603:10b6:8:41d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:07:08 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::ae) by BLAPR03CA0103.outlook.office365.com
 (2603:10b6:208:32a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 13:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:07 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:06 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 03/10] drm/amdgpu/gfx11: hold userq refs in private
 fault worker
Date: Mon, 14 Sep 2026 21:07:17 +0800
Message-ID: <20260914130724.130794-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914130724.130794-1-lingshan.zhu@amd.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DSVPR12MB999284:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cad040-a914-40c1-61cd-08df126114c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4SqbbnnZpOn4Qo+3LtpkTIPg3T/jzpzzDjjee+34stiPkF+HCc7dFVbMQH9EnoqMIUFUl1uBc9OZw+cMhVcIVVuDmwYy44SXyJZ2jFbhhP4kSNCQe48i/BRnCmkRxlec7aFqZnwAv4c3u5R+c/u3b8TAFF9x8/mkwOjoMkryV/qkDfowA1P1/TbGczf+7B4/zNobv3lNt0jUWWCLEuvKJWb7Lgc4syUzNLy5jOklsi6Z0CiKQaGwX3vKR2OtHUVrWXqGuxft+aMqJcrYTowJ0+26DoeWARvb91e8764fSEZG0zr9FsO49Ybw9/8BMZWgFLmBGavmwqH/SEV4DMg30JDS5yIna0UbbjE6BVVm5IuSpN7BLuDYr3q9Eztk/o3N9Jwgdv5rcjLf8mZaTVWj9faywAsZFwrGw2feBWWqpVD65jaYr+GaNt1XI7CbtT6QWrhquD9JC5xyHwXDUbql/OO6bkmx7LVpB3OVorIB+LuJTn2kJWD1kJ52c8DlrGM2wbTL4wMV/WamLaI/sW7oa0wr5AUS8XOoTyXKel6GyJaxaDhYHf3XMXQFrpFwlfqO951fmnV3Vjr2LQYJgPvGIKnEeF1xggb2I+OLG0UVQDz3G+VcaBniClbfdLdCSLpYuLYTRieFPcAc/j7GGFNUch3pvGKhcGY8XMb8Xb/27ynU5nAeWsnotmoKft2mSO5zKIPP+uSvEFoP6v+rbPucLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MrxQa8EhL8zIZnnh044drpOHmo6nDydNaONq6MLtHpTsVm51CyPnOalGRWFFvkF9chuOR57iiK+oonH45FmpnYX/UOmXIwWXNuDUeVQ2wLC3DYHhi4I425U2R3vsBAFAxcFLR13HlOnhIrcCT/h/SRc87FZS8WubBV6LDOLliupVzhN2Toe3C73TnpKQddv4E0YvMrSriVTeUJLXa1pVeBcXrRsMen5Z5DGzfXh5VLNwBiujEnSBF6PXgBFhtZl8JB63SjXDIQndcsradD7LVfWplz6/TAUY0SDA+24yQ6jRGeEu2fM0eg4OKshuC4VAI5RWVMxmsD7Q6hgE0aibTJAw3fdKkqiIjPKzfI5XULatN3cWNMBeAnCAPDYfpQNtmexEjSUbj8ULViUfmN5VzVR1LpiPLZSA9UKi2KxIIQfm7PutiFmyBXiV9v/MKKpW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:07.9148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cad040-a914-40c1-61cd-08df126114c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999284
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

The GFX11 user queue private fault woker loads
the relevnt user queue from the userq doorbell xarray.
However it does not hold the spin_lock of the xarray
when walking the xarray, and does not increase the
kref of the user queue, so it races with queue
destruction path and may run into an use-after-free
userq problem.

This commit fixes this UAF problem by utilizing
amdgpu_lookup_queue_by_doorbell helper, which
properly hoding the xarray spin lock and the kref
of the user queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a447562977ab..a063f86a8847 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6733,9 +6733,12 @@ static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work)
 
 		doorbell = (db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
 			   CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
-		q = xa_load(&adev->userq_doorbell_xa, doorbell);
-		if (q)
+		q = amdgpu_lookup_queue_by_doorbell(&adev->userq_doorbell_xa,
+						    doorbell);
+		if (q) {
 			amdgpu_userq_start_hang_detect_work(q);
+			amdgpu_userq_put(q);
+		}
 	}
 }
 
-- 
2.53.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B102DCD6E57
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 18:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A62B10F4CA;
	Tue,  2 Jun 2026 18:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uik04WNw";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013014.outbound.protection.outlook.com
 [40.107.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D6D10F4CA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 18:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGdyhU92TwZ3prJ4E2jM/gQnK2HO4OyEJTkVdLuJ2YzhRSNv5HUPKgg+qT1ZSyVuhVexocYkeChCpKOj4qVRAAU/YsxXMs2HW3Fjg6JCXAqtbp/kH9FnVxSg2f7n4Kv9x2aK/xny8In82JhelCSxY+Gf/scjJ80RODiafr7c+RejDJs4bNJB+3zPZk7hg3ZEAKglt4dXLFKUwj6+mRnXoVAHXQonCwxvz0kVyS4XQ7aaH4+Ealb9CklGtyQ3Jnx0Q2KK4PQ97gbHcAy09FY+ua894cmd89UwtoZYCAkrMv4U96/Swxuv7csEPh5Ptq5Z3yqW3sDdqCFAW/E8oFGlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+hDWWX8zxzpXq+Fu7t1h3FUyVLe+JQDU+IcUwscRNs=;
 b=OsV7jSivzmKglLsRri9FsDiF5nyffXupHPkftWLdJN55grH4wGR2EzHomnQt6VGA/PUEKbBCaCfKUZGUPoh5TnXDTmCsXLeP9XsYnmqrO7HXChQjdwoPUDzjg1TaAe9+kj6tmdzq8TYHjZZepxdj2uAO/ugmOZnnuK9utESwvymubEjpCJdV/wJayRBl56i+aWNM0Wb6YlS+TZvqLt22HwHdJ6aWswEJYyyZFNDQZGg60JpkRZ6uR2SujAPT8//+XoVu7wbJtg+E4+PWWsXqMmbuWATqgO+hxZUw7SRx/PHBBc0/o2B5isREFBolFjkluhd1hnAAjVkBFbWw3obNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+hDWWX8zxzpXq+Fu7t1h3FUyVLe+JQDU+IcUwscRNs=;
 b=Uik04WNwurDr9o06ymquN9wY8xBBWg6TTdNMf8Pdd3RHffxQnzIrGUJXTah5rknTnvbH7IeyeqpF7ZOcmGboYgtKU89EMWUWeXB/4/9Qx/sdbk979VRblhcfShdpzTobCFwAjnv8GRkc42p1JhxCs+5NsfEvYIo2EPliEm7/HQU=
Received: from BYAPR21CA0019.namprd21.prod.outlook.com (2603:10b6:a03:114::29)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Tue, 2 Jun 2026 18:47:07 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::26) by BYAPR21CA0019.outlook.office365.com
 (2603:10b6:a03:114::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 18:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 18:47:06 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 13:47:04 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH V2] drm/amdkfd: Check bounds on CRIU restore event id
Date: Tue, 2 Jun 2026 14:46:52 -0400
Message-ID: <20260602184652.2614456-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a7d83c-452d-448c-2e13-08dec0d75865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uUnr9q4Yz2wCOByHQyJN9c2DkBeIf5AsxUcIr6brP1N4bvVAugMNK5HFhRToja2wHnNFQP17nw6bRSj48iydN2gm1sdIs80thK/HvGpG0p75Lg8Mg2L+2TpMchSTqClDA3YFQpWUtCv8Q57pImli7+iKDnQYGbuv8fRktddCLtK99CQYpoLOPMwjfS5k3GzwhkGdXHiZYBFmrTAkQCOi51vgBv27s3E18y1D/IOOIcmmCBFv2YzDJLZ5iNpneNXEXQ1aiPx6RbGvGFdn0oGOTYesiEEGquynlwvdihA4gve9ONJ1UyKENF561SCnhG85hDmNee73xESv8kORQeM2e0L/6F1OqA6B+6JAHMzT5A9BYXef6JmnYihS9EvtstdBMVvjju7YCuk83A07HXjMsQ+j+DkR1IINB6BIXUKbNpgLAKQY59JLYty/KET0sG5Sry6E+4L0zc5gWUmkJ3asajzAnv6CG+062eJv8fjFJor6uYI4kddZErtit6mmUBRVIu+ZlYHHlieKBDUVqfpHu+O4fSJ45QmaDy7tcGVXXmUy7jxEUfZxTEabt6N/hY7wR0cOfe05X8g0ogLaiz+u4DVtJFfHxAju0H4I1PDnTpz3DQFsi+vtFoYX6HQol05eWoBJkUNI0bZwR9sQk4sgueTD0uWmrJlIEzAW4TnUDzbA8VcnNG9EIiWYVAB4LZef+19aQFFGgvJPv6Xi0kNXCdIcA8dviq7Ckni9frAHTBc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5HurO4AMVBw+9/FNPxehtxnHRHBtZKws9Zjr7A1SEVaddwzmNCRjbcZuXJ27XUXJgqxPDOn52bEAqbHbbgXMbb9SONBMaC5mMB46ibPA1D6KpYDIWHNAehvLkYN7B6mepKzvCWNVhF5fKEDTh6XjIfLjCRfNvroBPioFMuHbReP6nijDmSiA5oXJ3YBGE0FMJVxNs3RN5Wyp+1nSn/fSc7bDjZpJlC6cUxFTnLlOqhWosft4q7QB4R/iw7n1fN/+P6ueDoqpDevXcTuMKfdmov0d3PZxh6g9+Yh+F8NJuLg+Y8GK/8hsKKSV5U0Hgus037KGxeU696akR8HiTWeHMrnHXr2nyhXytk9vZTx8XRsKRagdFFFAB+QFy8Lm+CfDp3GaHbSKHRNPFQXIvI7t8/lUIbK4cI6FU9xDPwJ3nt/WT1YWRc5F45je9Wcw7nph
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:47:06.5375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a7d83c-452d-448c-2e13-08dec0d75865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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

The valid amdkfd event ids go from 0 to KFD_SIGNAL_EVENT_LIMIT - 1.

During CRIU restore, ensure that the provided event ids are
in that range.

v2: No need for lower bound check since idr_alloc rejects negative
inputs

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e9be798c0a2b..850d6befeb6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct kfd_process *p,
 	}
 
 	if (restore_id) {
+		if (*restore_id >= KFD_SIGNAL_EVENT_LIMIT)
+			return -EINVAL;
+
 		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
 				GFP_KERNEL);
 	} else {
-- 
2.34.1


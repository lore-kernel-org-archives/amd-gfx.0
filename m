Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A530EF433C7
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450F610E803;
	Thu, 16 Apr 2026 03:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SWJGv5cP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C9F10E80A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOrrRjUqQP5ucIIJPEt5h1w11DaoXH4zuQUZyufAFPx0pXyRQvj7wLzwzsr/lOh829Gn1Mi6LCY7lBCrmYCVGShe2xCjdotoI1u6raxcmefarf88Emr+APu6xDp+6LIo8+zOX6fBaDkGLmQysce2wMGCakGDrSF3OkcOzxZhuDud9VWPN9Y0to7yWMDWJwJVBjxulpp2yVNZE4wVGtlRGX5wuUUlI8LzXDC1I24YlD22nf3Q6i8kOd5/N7e1wCc9hdbSqaZ8a1adwlg5jOEC+JWcOdrtBu6yNV47/zXL2quG8ggOLuBEAJbHE+VMyA+8nCglzrcehY6FRzzeQn3lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyrFcFmRqWzjtt2YEpFw79zeikA+grQ8YV0jVpRyIt4=;
 b=PV7v0iIX2mwEWynDOROFzJYWch7K6R4dbIqTCQPMi/Yzrg0L+XVv9VsFWaTM6AO7tyDqUKr6h9hZAqYvVbwy7rWIrMLvCDBZ68limAMngj/ndl5jlVLY5V8YhSRanClJ6fDTry/YnmWaCr9JOzn1dEIPjlEFUEaEK1w4/czNwMTQWW9+94l2uABd5B5g0qcyBQ2d2jLrPxUCMId3UIfPPZeVPXuDFI8NH7LgmvHxpMXIUPC42oGOcVDEF0PbI1xl8BsA5PL22Cbf0ERtMUlmC9H77sRyIFadHnAMX3iKtUY93p5/Pv6d0S2oLYQ8R8CksEkylpoCi/lG1mQGUj3LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyrFcFmRqWzjtt2YEpFw79zeikA+grQ8YV0jVpRyIt4=;
 b=SWJGv5cPTb5KE6IjGJLf5mCl2WHDREl4RnXAWwdROm8aOHY9nYHnuY6DDTY9YIF1l3qCIE+0Qd5LBaN1MRClEqNqi7X7b+AcQ6V4NYnAHMEkslXo2aXQA4vnp366wDVlPShfO3glBN1cXFBTwtGa2cgG1aBomH3CiTpoWnyfc3Y=
Received: from BLAPR03CA0081.namprd03.prod.outlook.com (2603:10b6:208:329::26)
 by DS5PPFF8845FFFB.namprd12.prod.outlook.com (2603:10b6:f:fc00::66a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Thu, 16 Apr
 2026 03:45:01 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::85) by BLAPR03CA0081.outlook.office365.com
 (2603:10b6:208:329::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 03:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:45:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:44:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v4 11/11] drm/amdgpu: Add scratch records to WAIT_EVENT
Date: Thu, 16 Apr 2026 09:14:20 +0530
Message-ID: <20260416034420.2368152-12-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
References: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DS5PPFF8845FFFB:EE_
X-MS-Office365-Filtering-Correlation-Id: da1d17a4-7699-4903-aeb3-08de9b6a89e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jtSlmul2epcXDSeSTbOwuJR0MGYgzkK5uBWXvcqndp430xFb6yjHW5Tzu6yln+vGDpYBs6ihW70mHOeIgUDPvh+R80rumeereXHwI0yXoe5Kt5HIH0laYQ4UeoiJi2HA9Dj058dCsjk1KP2vW8IPuPTLGNwl4Tkjir0IkFvfiQtSBND4v2GIKKGHamEo0WVxu6vkZluMiN69zB/KiaHYGhk/lmLmLS4H4aphDBVAxqsXWQFQD3C2t11J7NVmqpjDlsX+wiE1X3Q5Vza5GEV4R9cO/Rr7nnPUFKTk/6Rsc+h44HFdvbTXGsP09WNaWOCau/eg/rDt/Z8pRQ0H8kRj0+MgBNmcNbadmSs+dtquqGXxj605pW7VvCDfzQF7BshkJXbtOG4IquBVlIW5KxGEaEeq9B6eSa167ZSkL9t0u8hobDxqTJHixhOay83iId4SCi7rbGuXvVG/gLI8pu/jTanWUSNvNiGGqlLOMvuLmOgUQ6ZrBoCHYOT1TVrkqeGCnuBGTsEpgBs31bD1soFgwMMlFz8w4MpWOPOKPwygUMSei1Vdehxm/6AC8cwhpV2xRK4CYrnylFNH4HeCBbXj6+/RiZqMqo7H8XwyR7h2Cwh6ymIFkx9xYqWt89KJGSpKZcIa/u+AhxGlJBMLAGPT5NpchyPiC0pVMge6m58G1+62g1+HkFU/Ya12XzV+1n68430EMIxw9jmym71Ges9LXEz0QaiRw5VBh5A6x+b9s3X+fWMdTRjxb1OIVmucXyNRz15eQfEJMmheCpWvwGkXyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yF5c3/NbZhwk+UEFyvWC7QZB6Juf4t9u/To2csKiNrDLAVxZ8q8DektcLjDhYsGAkuWpoPT1NFk46sAQyil1NOGVltOV+SaxTdA202dRCGu571Qvsy6kxepH54xHp3RA3YSiqTBMYr3yI/2vCg70wu3uPNDmj5HvDb3vW+BfkLfpbKYszB19zA6HQsLjQg4GIO93+i8i8CqVQnOEXHQNirnJn2U/JHai6TTUTkd8C0943VqU8Q0/DlUY8N0+7xT2y4M+IYLrcICZWWuoOjyDbCl04eHLj54Lb4MUBIUyM8TGFKl2mvQPt4PY5WDdRI3BY66Nd/Kl5GKMH5GSVp5tUgw8D0qYO9G1vz2wRDE8tlGZ9m6mQKQzRQcQI6HpHK3YgNMdOxeZEwfMR+DbKKzxYOc8GG5v6RE+rJuH1+egyoeTgRBNIMFbyvFJNg45J8pr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:45:01.4866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1d17a4-7699-4903-aeb3-08de9b6a89e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF8845FFFB
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

Queue scratch/runtime error records into the WAIT_EVENT path.

The INVALID_VA queue state is set when user queue restore finds that
required VA mappings are no longer present. Reuse this point to emit
a WAIT_EVENT scratch record.

The queue doorbell index is used as the queue identifier.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1fe025785300..0f70728f3166 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1024,9 +1024,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
-
-	if (amdgpu_bo_reserve(vm->root.bo, false))
-		return false;
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 	/* Resume all the queues for this process */
@@ -1044,6 +1044,16 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 					DRM_AMDGPU_EVENT_TYPE_SCRATCH,
 					queue->doorbell_index);
 
+			if (queue->userq_mgr &&
+			    queue->userq_mgr->wait_event_mgr)
+				amdgpu_wait_event_push_scratch(
+					queue->userq_mgr->wait_event_mgr,
+					queue->doorbell_index,
+					0, /* error_code */
+					0, /* requested_bytes */
+					0  /* available_bytes */
+				);
+
 			continue;
 		}
 
-- 
2.34.1


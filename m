Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B5AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 23:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF81B10EC4A;
	Wed, 27 Apr 2022 23:07:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD0F10EC4A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 23:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEPkbw9zj0qJpGqiDFw7WMYCUtxXhDZ2CcGDj4TfrlMqt4whZqDA0LOBboW39vTJEEWk75MoWxhUHf8UHxt5F++SQcifyqNac8N/j2uW8xws3Z7YNLXPXcvw/f7otXDpeiiIfgX6KEKAt6XNXl9RAwkJYyJktRkWMa80Hk8lq2JrnuDryoIf40AoiPdmJTsO+jM8+I2KWf7fPRvx7Rp14E7HPC6oY9+G3T3XCKNACN4f9/gb082YkGxZAPPz1AeKqjkKE9jbgmtx/7wpjyKw9cDtotiiYBdoLdKMqNb0bobeyfZYaLO9s8PHXV+33fF32BuU/HhpQ4ed9KzTu/+ZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZDiACPwf6Nmkj7lxVxMUBY3K4nbtHWAYrL/K0XtrY4=;
 b=YPl4c8lfoEmYGgEe9X5V1+lNoKpwlGC2Lgq9bmuPpA+pmRTXbngrkae+VedDXFoQhWOGRmUThae4wapwNrFii44yJl/FJVk1KkjR6Ompe7jezcDGrzuLmHNb1uPkvmT2gIpru0pSbmwyVtH9SnNs4du2SgqU8EoFKdsCPI704Y1Blzy/ONFsKHVB9kSdAWOHiTvB2fsJP/qgQXg2mMNKBuc/Hqx72nAM3fAHCB+h7y+46jefFw4E8UwBYFS6b2enAeHCbfx3jBA/EmmCJkcEBqTHXnUMlBUJ125vEv+I4SohfoDzzOApP9EC09hFawYqVpQf1ZCtYJ0lPQUSWfxtFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZDiACPwf6Nmkj7lxVxMUBY3K4nbtHWAYrL/K0XtrY4=;
 b=qA0eMx7uRYHyEazAs3VXog9LWa9U5wlvKjabdwO9Q25lz5kCFnIPWHF8Aa7IyG2SdVUn7UE7FQANp0saptKTL92nHD2nB9U73ZMV1yatROZLaE50Jw6a8GNLRO/qQEkHc0VBZ2GYerwpL0BsQbtNO1sPS6zqFVtJnmRtNxuFWZE=
Received: from DM6PR01CA0013.prod.exchangelabs.com (2603:10b6:5:296::18) by
 IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Wed, 27 Apr
 2022 23:07:26 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::99) by DM6PR01CA0013.outlook.office365.com
 (2603:10b6:5:296::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 27 Apr 2022 23:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 23:07:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 18:07:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Free user pages if amdgpu_cs_parser_bos failed
Date: Wed, 27 Apr 2022 19:07:00 -0400
Message-ID: <20220427230700.11891-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAP145piim21dDoS7fsv9WQ-Toc3xr-xG7ayP7_T+F4SeS8AUmQ@mail.gmail.com>
References: <CAP145piim21dDoS7fsv9WQ-Toc3xr-xG7ayP7_T+F4SeS8AUmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78a2e2c3-e36a-499b-66b4-08da28a2b232
X-MS-TrafficTypeDiagnostic: IA1PR12MB6332:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB633247A730E999206C25D963E6FA9@IA1PR12MB6332.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZiS5YL1ZKuzo8G2aqWV8H5Wm66gJWT0tADeu6N3jK1V9cw6QD3hr5RVZ0GDu0mu5E1bR9YIKRw0nDaTaS2bZB6U+1CrgVrTxWkdyBqfQ4/Bp7+bKpXWSTZK/QQUUC1xwWgo8+V/WNS8RgtAzPq+0R5nwPaIy0E3BQqCYnW7BZKus5+jftR9bXHSgYf52UKVPOLy7XgxpKqFrSSb/3Wq1RyQoHaloMyCz3BUrqRh9ye+MXjFntSmyUwu6mSH7e9B4M1he1K3zN4ofEtPZY+NnyhbtXDIh45v5/XvA6iLf4uMF+818QwV3tCfsyaraEpP7/Xkdtuoyj6bFon21beufT9GOmOTMRifoSRBjru8Huj13VaamiD6y5TYLs8+wdQq1F55mNk6ZgMAF7Pict8Y4N3hqePFTib67OxZiiMH+bgMFXhYFAGFbhw4FsQ9dUQ+r13ZnUvLEIYNoaw7S/ebw9QF81NAaPilsLVZqMwemBdr0RYB7YHUeyerwteRST3SZfdIrYgalkx/dEmjibI0D53Q1J1huzAAIQm2PAf/u3xFShsJ6sjpSeEErTbMjo43rhI8rIdfHtbOkYXmUlkSy+z/JO9TGaOZSodp7BYBrASUNmlbC8TM2ba4r5mQXukP9ufTAQPjX38mkFdHvLGt0qmVAIXPGs2cXZKUdZhucf64aPjS6sMaiqVb5s/jelAmVs0pR8z+A+w0onSZrmr5QzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(6666004)(83380400001)(1076003)(36860700001)(316002)(426003)(336012)(26005)(2616005)(7696005)(186003)(36756003)(16526019)(47076005)(508600001)(4326008)(8676002)(81166007)(70206006)(70586007)(82310400005)(2906002)(5660300002)(8936002)(6916009)(356005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 23:07:26.4713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a2e2c3-e36a-499b-66b4-08da28a2b232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
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
Cc: Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise userspace resubmit the BOs again will trigger kernel WARNING
and fail the command submission.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ea28942b0ede..44dcbef80229 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -550,7 +550,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		if (r) {
 			kvfree(e->user_pages);
 			e->user_pages = NULL;
-			return r;
+			goto out_free_user_pages;
 		}
 
 		for (i = 0; i < bo->tbo.ttm->num_pages; i++) {
@@ -567,7 +567,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
 			DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
-		goto out;
+		goto out_free_user_pages;
 	}
 
 	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
@@ -649,7 +649,19 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		}
 		ttm_eu_backoff_reservation(&p->ticket, &p->validated);
 	}
-out:
+
+out_free_user_pages:
+	if (r) {
+		amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
+			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
+
+			if (!e->user_pages)
+				continue;
+			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
+			kvfree(e->user_pages);
+			e->user_pages = NULL;
+		}
+	}
 	return r;
 }
 
-- 
2.35.1


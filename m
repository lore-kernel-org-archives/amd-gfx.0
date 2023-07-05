Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAB2EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 22:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E941310E3CA;
	Wed,  5 Jul 2023 22:59:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A13B10E3CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 22:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOCVh7IBkx882E/nGl/7ruppll07gHV15ESZbWP9VpC5y37BqfajczCJlm2GuD2tVhJ/0gsBZZ/Fb6GNYz1Xdzi1mrF19gXPQ5p3jpfXgBj9aIn0BwkVCxhaq2+n7haCMIcGYNkbo+0fE7jVrvf5iT4V+bfUVSocWSLviIOXx0Lwgeih7nc3Y3EAVF7lEn2oAze8I9LZ//A9t8L+UzYluZg7G37MUD4XlUBzS0xxW6pVKOl4WOVr/Btjgc1Rf9c81oo6pGkbgf3hhCwzVNQdRlkpQkeCMTMkSf4YozqtRG/cOs3yVpsWxQK4rp+njLJwcWRV0gbn9QbE0fSkQo5CPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkLOen1n61eeCWupyUBnSqVg0/6BM6I3ErtCDPuSRBs=;
 b=FoHgXv1617vuVoZnMEeHMlWExDoUAEDYAWkt8zxegj5LIN+LNHV6UnTvxQkHl72j6E19zL9N+ZtzHfTBc1UC8Qagj5ez5j3WbbyT5IMg7YR3U5PvoMhuWZfjjpPjXDnUdEiJcvWpmvrmpzf+QkIZb+ccxPGh0DgUyJAF08G129biAdZVjiP7fQaTfcD1wGSBuR79RWw+CX9Y+v/uLyaUb5U9wnAiRuynw1nrMo7yZfVWjbYIy4NliqIOUp819NSBfZiLLHvzFy9mQ59KxkBed/jDeBJhJ8N0XRcea2d+dh0slEa2XkcVhfllW7E79PbCXXGhNUQOJvRzC7xqpBKaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkLOen1n61eeCWupyUBnSqVg0/6BM6I3ErtCDPuSRBs=;
 b=kE35A/HLE4tqYnj+aac6Ug/pX7VMOlyxr+xN5JsDQsX9FcDGn6Y0Vpn30CnSUHaKzOQb9yGh+LPjXEXF3vOf8WDzazn+131oHII1kmUHBvs3FiQCKCbP/72uxI6JYL0e1Mj/s6UnUE+5mMiyxy8FBogo+AuJkZt5niHBrzDaNrQ=
Received: from MW3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:303:2b::14)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 22:58:58 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::b3) by MW3PR05CA0009.outlook.office365.com
 (2603:10b6:303:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 22:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 5 Jul 2023 22:58:58 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 5 Jul 2023 17:58:56 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdkfd: add multi-process debugging support for GC
 v9.4.3
Date: Wed, 5 Jul 2023 18:56:55 -0400
Message-ID: <20230705225655.299335-6-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705225655.299335-1-jinhuieric.huang@amd.com>
References: <20230705225655.299335-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eaaaca2-2194-4c2a-dca0-08db7dab6a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usWQxeSHqfRBQdXsgY5aCs0AHeCMWiZPWVVCsHhH/RITXg9FRJHz3u8J+nDhgzWv2ksdRj7S66XBTuWjhTPygkAnoi4O1pk1WfhLoW0htH5lMT1nWKQ3NmdVaxAGpOshnYJgpBgR16lDnlUJf3f9+pDpLRAc6the8k1z9F340MrFplUQCn/1Z2YFhHpoSRmtjd6TmQXTl9ly/JZ+yQyVMg8WONs7rKHfBSdOO5uAQG69K1IefCmvsYshHZadsMC46nj9skFKb0y8fFS5krEeY+HHi+f/b5Q1xQ55BQ5YIFQm0qocqWk3TRWyN5fipHH04/awrINxSeH/4D2/QWSzz5VKebzXJZyrjl33pAbz4nWNQXWlcsPtNzL/cMN5sOOdiJrJEi0yCKXNU/gKNiJHpeeM0XZBPYfh2zf/Km1a4IVZqGO8tJMOKUVR2YtoRD9hH47gKguM2Rf/dY3CRzDS3xQT3RdU95hC4Q4BeFzNJsSF2yGCsXQ/QP5SBVzyGxjWMrdcX/3hhMaLRf1Q3xCG+AaRneolok3v20ETjKZtu3k6RSNm55c99BEOzBaIG5B9vFIPz/tkOvz5xXfxWg5ZfOzjAFSddzg94Pykn43qbbVkQZMWX/44YjgBv5uTrz17PHoPDRLpbPalH6W7iIOCeN0JPYdNzqWt2lpquCe3RosvVTq5NHJnu9T1nfTVO/ZXgSsmYvsOwC/5in6Pn9TsgwWXzhDyideOAZYIClmYvdkJJsHMnupxupt7nnwZq5/nzM1C76IwUDrnmrr2IDGh9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(54906003)(7696005)(478600001)(16526019)(47076005)(186003)(336012)(1076003)(26005)(2906002)(82310400005)(356005)(82740400003)(70586007)(70206006)(41300700001)(5660300002)(4326008)(8676002)(6916009)(8936002)(316002)(81166007)(40460700003)(36756003)(86362001)(36860700001)(426003)(40480700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 22:58:58.1728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaaaca2-2194-4c2a-dca0-08db7dab6a88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Felix
 Kuehling <felix.kuehling@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Similar to GC v9.4.2, GC v9.4.3 should use the 5-Dword extended
MAP_PROCESS packet to support multi-process debugging.  Update the
mutli-process debug support list so that the KFD updates the runlist
on debug mode setting and that it allocates enough GTT memory during
KFD device initialization.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index a289e59ceb79..a0afc6a7b6c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -76,8 +76,9 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 
 static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_node *dev)
 {
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
-	       KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0);
+	return (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	        KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+	        KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0));
 }
 
 void debug_event_write_work_handler(struct work_struct *work);
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED76C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0D810F0B4;
	Tue,  3 May 2022 20:29:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8015810EF0C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv6+dDjqgziRQAFQJjkop6hxfsUjopvJBSkyx1nX2ifFq0ulMzKXJI3D9VNGTg0CNn17QwJUu2LGaPJQb6t55Grr6E0EMC6El6eLAPyznimzugg8KBeL0+i9ZHfORJK3NAa8Z/5EJStbMWJ33ITpp5tlGz+sHtH2P0srDJthDMPhmJePbMlIPUF9yswU1X8qLCPNtXHLXzozTYQp5B/xWQ0sRUFF32FVWTf6uJSZ4RE1iXIYBcW3OJ7eVMEaUKSBIH8jvvACMOuS2ocQ2sJPeqHRPjU8H85PAklxPEfuPjlCle6Z/dUYXbCj/j60aELZWaiP+0DWdu5Wz+WxHZNnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwrKN4jMIBMPJ8vfO60kcOvuYvGuhoKzInX/JGRJezc=;
 b=VbjRXNUZyiDsCS+xC75+hbywCDXDv+HGrQx1qPtMFmEMuYjG9YAW3vD/8UmLodizHfzwhXrRMMG0kehH+tXM4XNVADxv6mm5wzUuIxTej3miuvdozV9LXU91J9Y85dIzj8MiFWq6YGK/pNBHXz8VEjhpsjvGQAfiFgT+faUgutjIsi1fzm5Fp1AgRz1Va4u9oOfWiiuK8Mj1EChcNdVlCQbOaVkRcXmUq4BLaMRAbWlUKMTt3AFIP5bOZl2j4+SIhMlPx+FTdXNKVh87WpVHNf2YO74lvdt86KwIo2wZim5IrpgMw3wT5x5YuQ7NIOduR/iM9+csvKUS/dTopc5Spg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwrKN4jMIBMPJ8vfO60kcOvuYvGuhoKzInX/JGRJezc=;
 b=W0JJA+kRwgtEYHv9RzHvEY0FQ02KdFJI2I4mYiNtnpcGnGIA1+xaEBlP5ppmBeTpB/S3DPPigME9Xxgyowyo0jb2IyJQFEHy0TPVCCYx0Cjbm/lAp71v7q58dWHJDO4HFTH3cf5TYoV86n2M9uDq9DxH38omVPgkcw2iA0oWYMo=
Received: from DM6PR13CA0032.namprd13.prod.outlook.com (2603:10b6:5:bc::45) by
 DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.19; Tue, 3 May 2022 20:29:30 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::76) by DM6PR13CA0032.outlook.office365.com
 (2603:10b6:5:bc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.8 via Frontend
 Transport; Tue, 3 May 2022 20:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/jpeg: enable JPEG PG for VCN4_0_4
Date: Tue, 3 May 2022 16:28:55 -0400
Message-ID: <20220503202912.1211009-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0b5e1f9-c9eb-4459-24bb-08da2d43a037
X-MS-TrafficTypeDiagnostic: DS7PR12MB6141:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6141CEDDF3EC8A8EFD5A8434F7C09@DS7PR12MB6141.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Thg88fJY3joo4q9XxRnzYg3J+TEYIY5Yusb0W0mtNaTEc/OMGjG+4JJ4jhKwu2XZP96JmGwmZJIsy7hWFd4BBcyWVvpRVfHu2Rbuc2P74SKRxo5gVWuQlvL/ypqv98HnQiSiUmbwk6u7TGCC2KpR+hBIgNN0TRuK6iKDUiWaenGm0fwkg4MdBtTG97Ig54PsaNNMdkzEyWhtu1WYsK6HB5TOODGVFD7H/3jKN/qtVe2YCVC4oiH5HHTqHXVm9qQdMeJLSUJLqfNSQJlY1quwAVL00x6BPl42TKwG5h4xYbOxxhCFwgvBDiwfDS9zB4grnBlkw/2qNuz4b15QpuzBB7zb1rtNV3yvPd4ll6zmfLUrgj1SlaEldRgaCU3oN2rSxo3EYPcr0Rb4+MZKA9uQWytagzGDFigJGceuhNTXskfPSbTEPOIewdh3INcP9h2OyfQC2hl9BMYb9otfdLqiN6O40Yx30iyMnTkA1UyCDjWeD75v6fg+HuHl4UcZhiCosJfgBRUq5kaXhLjtz5ivXq4obRfDh+45cYVvrpecsR7wuDvinzsXZb1qYHamMdHixP+8HjBrK6fbK2khHHpIe/O3PR/qItrR6U/mMAqALI7djvux2uub344urd2zyozbRpPz6kwntP4rokh/hn/6DwEUasV46of4qh6RV90NE5q5GiIu3GvU6NWwpUjDnsG5199gBIHH+XGr18r+gRBlrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(508600001)(40460700003)(186003)(36860700001)(1076003)(70586007)(70206006)(8676002)(6666004)(356005)(16526019)(26005)(7696005)(4326008)(81166007)(47076005)(426003)(336012)(54906003)(316002)(6916009)(83380400001)(2906002)(86362001)(5660300002)(8936002)(36756003)(4744005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:29.9436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b5e1f9-c9eb-4459-24bb-08da2d43a037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable JPEG PG for VCN4_0_4.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 6d6aca7f64d9..a75860e6c3b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -550,7 +550,8 @@ static int soc21_common_early_init(void *handle)
 	case IP_VERSION(11, 0, 2):
 		adev->cg_flags =
 			AMD_CG_SUPPORT_JPEG_MGCG;
-		adev->pg_flags = 0;
+		adev->pg_flags =
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x10;
 		break;
 	default:
-- 
2.35.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49424C54F30
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA4D10E566;
	Wed, 28 May 2025 02:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bpyaCK2c";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01AB10E566
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6zxU/LDP8mSvYKdOMnDFHVuqockQM3pRExpuYRKqUXMCt3s4F370JvVyC2vJ6m2Nv8ZZtk2bG81pu08lUBLxNmxHkigUBHiyBLLnfEWfyB5el3NqiJwMBCQIdmDrOpg3bTGeyTx/bwW0U/xc+AQkkWxqkiD4F3y8NpyQsFCXwFabuu4Tu3BgoZodJkPtYIgdS8ZmIv1vtwk9IXZu2CSz+wLvSo90gu2QOS70GRdwN9eRrU4ANH9agHIYvmXRxo6C0AZnmdtuzSwsDw/4kTmG0ZZPg+69m9jCaHKDCa/RRMmLRAJbubwR3OinubUWurGR8WHVIPFZcWynD88K5cvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jppdpg8SAvmH1Sdmwx331jOE8r6Irp9jSCxU3u30mE8=;
 b=KIsm/lOueh5Y7HzYXZ/MhndtgqlmiJ8C/SZ6e6OduiwpGsW1fQt2fHIN1Uyc5znXk3ou9k7n5ckdbxpKtjQiz5GRQbXpw6QGVmms/E00wxDfFmTvyjLfJQa7FBAozgq0LeTb5UIHi21x1qYiMGuovjmbX8zyFinczsf1lgR4ZEwS3eNOop6qPW5SBw2u1+Wx+HagU2ku55EoAdWfZaH4RRikULfunXSyOAIidGgF+GqvMpHNSIesSLNayon5jOrIYkHKHy9OxMNyKxoNAjhF4jg0IwrzfPwJ4u3T2VhxbjUHgjWyT0XIhYwum/1nO01Ngfuyx7fTdN1cb3k1f/TlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jppdpg8SAvmH1Sdmwx331jOE8r6Irp9jSCxU3u30mE8=;
 b=bpyaCK2cjpcZS/2/sVYgjQYEZrB7MRiexlvSlR5uqWxZAHaiHeCveLjoGHdYnlSyhjROwnh43tGJYuLAKFO1s+2wE2bDL4ib08Pgkats/+DDcyL2wLi21Jqlq4/wr2/kuKtum6sV7N83LeYFxSeVbhUZBS2gn2hSvc003p3fqEU=
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Wed, 28 May
 2025 02:54:26 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::5e) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:54:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:54:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:54:25 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:54:21 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 24/24] drm/amd/display: Promote DAL to 3.2.336
Date: Wed, 28 May 2025 10:49:19 +0800
Message-ID: <20250528025204.79578-25-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf7cb05-e882-4a24-4974-08dd9d92f55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CigN9fs3VsqONngiHhk2lVHkjBMuN51EYeew96VZgrJjSsKXw99IpJsqRqLS?=
 =?us-ascii?Q?clDUl7dzEukQ35sOhseOE9xdJrQinojBeL8Lh9DieXyzwhquhlQf8uo5VuV9?=
 =?us-ascii?Q?XdiLtH9NCloYUIfzxgNtfNPt72qUzsDSfoNM8qJv50ogh31XiRNb066tVcDi?=
 =?us-ascii?Q?TRM9Hm3eoZJASMHMuUyk5KxVOteVKsaZkS0+hriE84VHT86bKMIQah9I3teQ?=
 =?us-ascii?Q?x87IzcJOjhETOIMJq8aU8ODN8rLlSUJgQuNpO4jtF3eVWVWHmqPGOgmfvMai?=
 =?us-ascii?Q?sS8ade1Hkic7C+H3V1fm8C6Ta+HmMz/P2uor6L0vhXg981qUcWDnnUGNh+Va?=
 =?us-ascii?Q?BgFuGQQ7NSfosJqaeiHVMYqxiNvS7e4qHkf3rnEsC0kbF7q1W6DsQfM7ROxu?=
 =?us-ascii?Q?VuRqaxtAqDLxBgVSYhZQWBkMVXxHoZ0G35awf8bcNfq1GgSpL8bbarp4723N?=
 =?us-ascii?Q?faqo/ySOj++jH2QqPXVWjNJ381JgSIKkdZOBUXStWZl3hVs3La5T/ZtUmQRj?=
 =?us-ascii?Q?GNckoVbsMNbngNtvqEIUjP1RlVnqw6RsP6URU2anFtZyhp3ZCA62s3jUzLMv?=
 =?us-ascii?Q?ZcKtcgphdtRb7VDRaUkfqljd67iHNstizR4HYvogQW/LpP2WLDl3EfhkECaw?=
 =?us-ascii?Q?GJKStp/v89+ZiHDfz67dBw2B4Wsv33LEwpPJP4iG+MEMQ5Qe+qO+x4wO+L0U?=
 =?us-ascii?Q?IsIiMnhw9EL2MUtQ12tDXFL80puUj5tP51m+uVMEwOhAtnvAnbmvdWP/jqXC?=
 =?us-ascii?Q?zTULIaXIto6BQ7TYNpz1gt/EJa5X+g+xcdkHY4cXaytfJpnzWLT5GRUXdVJe?=
 =?us-ascii?Q?04rmJqmUEH//3LjLhKnnxn7vAMEJC1S7urILb0XgV0C12K2tysFIdDfj5DKu?=
 =?us-ascii?Q?cc0kufoks0ZKnRzLV5YcxDGSJzrWMaLzFl8yoZQnxAEFvpfWzAW3vqMoUFV0?=
 =?us-ascii?Q?VXZAOS38+nEO2JF5T4dllFsWninpKdyd1DSdVbKHRnS7TDG8uvQs+vrY9aa8?=
 =?us-ascii?Q?m3QpIimp3VNVFydfxK4co6gU2T5sYSAIkdIwRkibK6dLhzS6FkQDy0B0+tOh?=
 =?us-ascii?Q?jtyQGN+iIKIel1htUejvexLrosjY94i1OYn1xuJx/RS+7QDzhKo8m613TVSO?=
 =?us-ascii?Q?OxmFsm/EbVY8gq9qOoP/NpDoopTwiNfQuTDUFCj+Iz35i0sxIIhfrL1cBYi2?=
 =?us-ascii?Q?N4H2zcTtxt0Rmu5Z5HqMXs4wcqlB+ildSKITqHxLdmgHGJm2+Q42K3vUMRaM?=
 =?us-ascii?Q?wzh+1CHmcAdy3OsHVTtGGIf/WoVyCDg3f8di2pETbuWQCxL5WfombA/s0v78?=
 =?us-ascii?Q?DvrrgeVy+lNhjcEFJbDqK7G7BoB9nK+AmyYDlNLul0YGLvjbJnXfQlpgzEDz?=
 =?us-ascii?Q?kNZEQmcTLklAFhvrOdHQi8YJMUhOyu/ITO6WyJeCMBJbOuy/GaYwmWwXp7E8?=
 =?us-ascii?Q?FKKSRxzaERaMS5R2KWZTQZ8d8Zi8thrfvyS9MQaFXcLVXvRaLdxyeht0cfa9?=
 =?us-ascii?Q?z5fNiRSnYgmKyWUScQQWvJ1PgV3v7VDP2OgY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:54:26.3238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf7cb05-e882-4a24-4974-08dd9d92f55b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following fixes:
- Fix brightness relevant settings
- Fix calling blanking stream twice
- Extend dc mode validation types to support more scenarios
- Update DMCUB loading sequence for DCN3.5

Acked-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9878868ff4d2..4984700b5f1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.335"
+#define DC_VER "3.2.336"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0


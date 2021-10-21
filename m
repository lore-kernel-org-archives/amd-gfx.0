Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2277EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 08:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73B561038
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 08:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D73B561038
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140456E419;
	Thu, 21 Oct 2021 08:50:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221A76E419
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 08:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoHQqtH3aaaeUeQqcue+3yDe7VVDVNsY+UxKUpbLLvD2Rf2aRzmU5tOy5rTXI8ZI5mpemZN6PbrKWZC+b+O5AaLf7Urjd08uV53pMSqu2QD5gddkjh/Qo4b2/xv7ns0JoQdwGPwy7liOUN+9t7Ccw4L5dsbeqmCzGRcmTg/Y8ACh/LIRs/y22ooxROMd9Zlbx2S0kgSqIjbU1C066lsMbgulkrRuYwe1bG/mnEi1Ws/bdjJZzMjXObJVkGx+ZYO21aXozQRf5WjfOVFP7cYKVWK33jVlYYj8U3CqNsGB0kB99Kh8aU3Puh+Y2ydJkvmfBekkCXGYlqjIbkkmxp6YSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyo0n1nVb3PFU3edmtMlLzgQ6sMyGsLC/fg2Ba/B6dg=;
 b=REYoYT+xTdQb6TmZjtwX/+l/+SpoNqOoCdqKKvgXPo86yfTTrsiN8zf5w6fD5f00O8d9sZkEPTMZ6k9m8+7hPAK+j24B3nFB6N5af2tZcF8cBnqHtbqS+EiJEUdh5U4HfRW+au/wXwejt+fVMg6+hD43mCFsabwlA5k2COh/7Jr2PbGvTpN26525n2toubqrHwkol6dvmv/4sg4tS5b19ClVhsRY27fgYVsmGv6iydXU52+W1NtxNYF8FFAMfS0lepraAFpDCldPK8sPTxfF4LS7hE+yPwFAm1oXR3u3bedZz41Dy+GWoxguIxVxl7m+tW9lQREIucZJvhcvAwGZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyo0n1nVb3PFU3edmtMlLzgQ6sMyGsLC/fg2Ba/B6dg=;
 b=X+u4nxPToK0DJR/+5ijNQGFcA7Y4q7hL5Si1K9ILswlCnpae5owgaBPTLfR0X5z782HKTxZVc4cGGBU5nlODwAHv/TG2uGr9OQV/aKvHjJTtECNYNE8D3aupj3rl8VMNjwqYysF9eZT23mkifWsWuZnxoW4qfiMJzFxOwoN+aDM=
Received: from DM5PR19CA0057.namprd19.prod.outlook.com (2603:10b6:3:116::19)
 by BYAPR12MB3093.namprd12.prod.outlook.com (2603:10b6:a03:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 08:50:47 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::a0) by DM5PR19CA0057.outlook.office365.com
 (2603:10b6:3:116::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 08:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 08:50:46 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 03:50:43 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <horace.chen@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add dummy_page_addr to sriov msg
Date: Thu, 21 Oct 2021 16:50:23 +0800
Message-ID: <20211021085022.1130505-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da98d489-5963-499e-2248-08d9946fdff6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3093:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3093653BB68F0D35D1CC8F66B7BF9@BYAPR12MB3093.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lq1RuRDQh6H9ks3RcdRAHunYkYUpEQleWhCSQa5p64C9+CQ1Gq2RHlrFh7WwSS8Ol8zOTbjL9BbLqvc3oqXJtsFKUGohiuiiTfwICr5FR0s9mUCIT6OW2mlyyhvtWdnHxew/o1xnXzFV6V9wHuYrg73W/OdXy/kiTxEvObBy1e1URHEPSE2KxhXTooA1xBGImA3xYdds89Dy0CX7OovTy8gM99gAQaYEzo0tspgUHd6LuVArwpDrr4hMypJBBFwRNmFsT4+YJP7e0HXaGNsXsH78z1gAJoeT7oenQpHSksqJ7M2960v+izx+Issl5vxiGL/hSJWsfaiYTgsfo7d2/XM7ApB7f3BunJEtzxpZagWivWmWTLXC9F61UEruMSd+ZqTUq3FI8jy4InZzpR6/5qdovTkYNjYdzuQ//Y28lv2DXxe2mFbzXa120sJ6ahMpmXOfiF9epGSqAY3uSyx+pv0rS4b7XoFKfvJVDA1elDlxJaWCEj3Q1Q8CdigffvvV1CBUE9d23+dzT55pJyAiIkdrXAb1vaEpTyDpDRPEteQ/KSwO1ZzK+9w1pLX8hsXj6oDcg9KzYC7vnCv8GueUqmvb1evM1+l3e/mcUsI7D/C+ruO9GlGvjliPzbQTxBssrrQDJ0ABWV/XbEVd/ceR3LmxuhHuwAH//KXZOgEcv7O+i9w9g9EijkaU4jrXTP3ZfUgrmQfHqy15E0uAcJB093XTjLVVqDyBc6uhXluXWFU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(5660300002)(426003)(8936002)(70206006)(70586007)(83380400001)(316002)(54906003)(356005)(81166007)(82310400003)(36756003)(86362001)(36860700001)(47076005)(2616005)(508600001)(6666004)(8676002)(336012)(1076003)(6916009)(26005)(4326008)(7696005)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 08:50:46.8486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da98d489-5963-499e-2248-08d9946fdff6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3093
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

Add dummy_page_addr to sriov msg for host driver to set
GCVM_L2_PROTECTION_DEFAULT_ADDR* registers correctly.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 88c4177b708a..99c149397aae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -584,6 +584,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->encode_usage = 0;
 	vf2pf_info->decode_usage = 0;
 
+	vf2pf_info->dummy_page_addr = (uint64_t)adev->dummy_page_addr;
 	vf2pf_info->checksum =
 		amd_sriov_msg_checksum(
 		vf2pf_info, vf2pf_info->header.size, 0, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 995899191288..5e3d8ecfa968 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -206,8 +206,10 @@ struct amd_sriov_msg_pf2vf_info {
 	struct amd_sriov_msg_uuid_info uuid_info;
 	/* pcie atomic Ops info */
 	uint32_t pcie_atomic_ops_enabled_flags;
+	/* dummy page addr */
+	uint64_t dummy_page_addr;
 	/* reserved */
-	uint32_t reserved[256 - 48];
+	uint32_t reserved[256 - 50];
 };
 
 struct amd_sriov_msg_vf2pf_info_header {
-- 
2.30.2


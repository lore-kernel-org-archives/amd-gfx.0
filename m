Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353F8C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 16:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D555410F87B;
	Mon,  7 Feb 2022 16:23:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E6610F87B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 16:23:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLrQyGvRDJk5A+p8xtuIETpxt5G9Ifk2OFJweumX3VXFpRMKL9Ddg4nICXWiSaPEddvg+Xo0qOHHrMwyN8RgZRJ62aIzT7Aa7UD+DEtCZVHdSPzdusPbDqL1fFFcnFuUdaIw5CYC8oC8ObwF7V84e+ZeK6NuszZU7vFh8z5y+4n5LfRu+63XydZMVEQ643ni3toUIwEDO/y3BZAX6i/q8Tfvkg87+hIC1HMDnpUceWe+VoXa/Bv2vAq63anESL7nQcO5OPcWrRpi2iUpsvsf2I4pmTEjKi9V4v1IRTx0IHiYta81FO4o01p3sU10cJ8hTnVeBFUOc/Z4QbOuYxATjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utqnQA8mw7OSrC+cTPEWWZM10GR7M1D/62uanif5Cfc=;
 b=DtvswaDrPMnVFdeUjm71oE2N7LA6nxEfTjyPj7/g2CjgG+HGwLnowzcxzP9Vzn/7Mx6Gql649a1V1SCkuDxaGwnWxa27RMkNhU5rWKNpdQLqRQdrk8cKVl3qm11G3FQwM+t9dUCdoa66/gyDOjFWHtGUaUGvTCtySxeV8rSoDWTibB1Mq2fK8BVZm+X59gWjlVtMwAp4CQseko7nCLHXxVcOoxn2oqRwk9mGQFQw4pDoTPPl4Hpz2wQyaYhaBZH8vbYlA2rDCeJrc4U+lwjau3mmNLY+2CeEXYrjBaom1dJzJuscjA3y8qUce0Xauduwr4vz/K+g6IZfl18m+Hd9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utqnQA8mw7OSrC+cTPEWWZM10GR7M1D/62uanif5Cfc=;
 b=XuXY9SJiXtycftz6+C+BH69jgt9+AivQhCGxeU7A4U+Z9TpOqTSbXiAlemmRHmKHUspISVdViRIy/rHB4twM1piCQ4SmZ88hcqY3cPt0IgF5ms8D+8oXt5+2GSNGfQntLmdh/vHdgWTiz7p0PGC3auRhi6n3v3RS+619jtm5V44=
Received: from BN6PR14CA0028.namprd14.prod.outlook.com (2603:10b6:404:13f::14)
 by DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Mon, 7 Feb
 2022 16:23:37 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::48) by BN6PR14CA0028.outlook.office365.com
 (2603:10b6:404:13f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 16:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 16:23:37 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 7 Feb 2022 10:23:35 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/1] Revert Patch from Feb 7 2022 Patchset
Date: Mon, 7 Feb 2022 11:23:24 -0500
Message-ID: <20220207162325.37401-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8759bc74-f476-4314-1818-08d9ea5631b4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1641DAFB1F996271313744EBFB2C9@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SE7wnyAfIQ2r3rigH04bfrKgGShAUCoRJfSQfDp12MhFtjERbHb8JIpMiu0ydlGBdTKVtZnN8aYS4/yE+JtTczXC+a9lCKbrSs6fqHetpjW55zuhLA2TLseZ8xTjBALT4wvS2WCrXJ1fsMPmQ5wH/7bIsumNbYmHWDGdv0RBDqvEjGPykKDGXdF2lSbuAzhrICTBbti0QtIJoAAsl5Cx87ytnFudbicaPLjOj0V0shHn5p0kg9YbB+Qu1VPxRC717cWwVvxn3sChxCNMHf+HDWR+QMDyiJqIGTSNhCg+HtiBJJ7E9FgcgujryzFTTtmX6O+vtH9w+jS9eZ056WwjCvqlfHGd8Ury+EhQQ+uxR6ylUqRoO/NpllbyMWJ723vZ5BblpfaeL2ocQgZYYC8nqEVFxNb3IW8bdYxMSn6aIH117IMtgrxYZv9X8LC+EjRaUpPzpCJPMx5Wlt0pzQdt6a4fSp2niLJjNzG76TroV2K+tFXaPHVdc20+gvnTKnKrAwxWbfFP46bakmQYYK39HvVpJvLO4CmV3we7ELOeUQZLI7MjEuZvafP5mjyhv5yb+nDxVaEDxFlPIYo1UlPgzqy/voKUuc9W5NORiU+B3q1LpeD3bR2LtbI6srPh5LZdY2Hpx/Ur5qIiLzrYw0KnSWIXfCCilz+fI2CS7TQaApa1epjM9fUtwfu4CkCv2xlkJMvaqyFSxZnvuyLtg6z7Lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(81166007)(2906002)(316002)(54906003)(47076005)(6666004)(356005)(36756003)(508600001)(4744005)(5660300002)(82310400004)(8676002)(426003)(336012)(70586007)(186003)(26005)(16526019)(1076003)(2616005)(70206006)(4326008)(8936002)(83380400001)(6916009)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 16:23:37.0046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8759bc74-f476-4314-1818-08d9ea5631b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reverting patch

Jasdeep Dhillon (1):
  Revert "drm/amd/display: Basic support with device ID"

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++-----------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  3 +--
 4 files changed, 5 insertions(+), 26 deletions(-)

-- 
2.25.1


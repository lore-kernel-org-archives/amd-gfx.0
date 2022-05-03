Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA82C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EC3710F5CA;
	Tue,  3 May 2022 20:51:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79FCA10F505
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CC5dSqO6jTu6igzG1v/xOJFHMDuKVW8bf2dWrZzW5F5S4yRQuLGG65xAfHKDfwIs584RJOjOezp9vMsV8WEPOtT35chBdkGWmtAgxj4S55WNlC5FpnPBrhsFLOLPVKniQLTkCBZjMT0KfNf3RwpzhmOoQqr3Wy0OXLs7/EY2/X8fTK6+M+OeAGI7JWZE8FStcemhbawM9WPlcvNIVjUccr4wTTPvpmZSZgVuNo0v9HwA+T2deKE039vOhO4BGjpPiG8FsO5PFrkaFQPuGD+K652DgQYMVlmur25f5KPDeoMZik0gIgf6J0VUVIwrB3saW1l8ebnsyr5XWX0rpykRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDru1CgcQUKv0QZQ9rznw1tyz77MtsdkQewCG0x0SGk=;
 b=AQ/PypcBimi49YLtxU9r4oFfWQaNkeVB4kycYnkam9asCqQcl7bpLY9p8xW3tUwN3L8ZYbcbc4BMjgV5m+HDtzoSfPghlp75JoBj4t+IO8zuqM8k968gDFuKbQ/tJHUrlWk3BNJ2ovN8lbwH10d51O5fyqQODO7xnB2n4IPak2esigRAWdAviWSJ0PHpfigD2J0a6Se6igmvl6bLkuxnHSyR+mu7olmiduuTloXGabE2ADWC/Yp9xhhc+AGrMT92DQa9RcURMZL7HvN6wwltMZ44HgIoTvz1FNNdF/bgiQZ2FyTfLdxVts7+sCUI6go+AkD/syPm4jLpidG0+gmbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDru1CgcQUKv0QZQ9rznw1tyz77MtsdkQewCG0x0SGk=;
 b=F6552WWxkpYeLCheIyFWSf6qkQKO+NGOHyOz+/X33IQt3GIXkKIP7j5uSgiQz/Py0VDpGjCqQ5PcRuXChof4uUU2tqZ1Ob7AVXkaB7vmpsctOcsfQCqGRMWQ71h7e1ZlXjlHUdoJ4YjAkZSEByOaPQ7MVTXEwuieXU2QRasfscc=
Received: from DM6PR08CA0063.namprd08.prod.outlook.com (2603:10b6:5:1e0::37)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:51:30 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::b8) by DM6PR08CA0063.outlook.office365.com
 (2603:10b6:5:1e0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: set flag for GC 11.0.1
Date: Tue, 3 May 2022 16:51:06 -0400
Message-ID: <20220503205112.1285958-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37122df4-6565-41b7-58da-08da2d46b369
X-MS-TrafficTypeDiagnostic: DM4PR12MB5328:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53289EBF19458E876F58C813F7C09@DM4PR12MB5328.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Alwiijiij3184Oxe6SAJ6qFztgXkhZMx845hb/nb0e3fH5Du+YoUoocbgkcYOc2f4TwREX3uu+Irf9NZl9qOxoJZJRuk8RIA2jnYomEAqRdS4FLVuscfqCagY4sqQOk4PUkAT6l0HWXtyc30gLrKJQL320T9SaK4c5fdz7cKCpRBSRvdLWaE7aYF2Zs3wkwnSQU+9+orqUHaDwrwLE5BGULn9UvOaFiz3WtQWMxzUiMFJFpUArodl7KNlJmS8B1jKl26iLRto+VgGpUFuUmJbKr7wJAeTKPCgDT72Wrlp/yZ7DlLUm8wQ50PkDfponi4aLDZwONCGJLn2LhG5ezCkINvAi4mPhvYIo0s8+Pf5sJgUVUpsf2+m47e7Kmrd8j3LCgplcRTeQG7Gp991XYpga75Z3RVn8dtfgbU1F8eFWOHM2xitMMlT6OnzISjjlOPVWpI17V6kGK4ELHCHOIkmqUTcm2Xt873SwIdMOjoV9ann7eJXtzIX9hoMDntG9ZdzjlICkmnlpF4c5s6Yx0OyzS1ymt+uBpPoEtMdbGqTm4TCxC7xu9oLH6pwm0H9J9O6Lj7czGGOWzlScv04yRNrzA+b1M9SyJJCixDgyw4SyTPYVdvvHaYZET1ls18Bm8JZReC5s2tWmKJAQVr3VlYCfThSirh1ooK6iB8K5iUOuN0eT46VmrPKYRkeajYL81bzh+t/I8U/RcvBCO3G9kRiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(336012)(6916009)(47076005)(5660300002)(426003)(40460700003)(70586007)(70206006)(86362001)(1076003)(8936002)(16526019)(36756003)(186003)(4744005)(6666004)(2616005)(82310400005)(4326008)(508600001)(36860700001)(8676002)(316002)(83380400001)(2906002)(81166007)(7696005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:30.6395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37122df4-6565-41b7-58da-08da2d46b369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set the APU flag appropriately for GC 11.0.1.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5c6d8a68c540..8621e30b52ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2152,6 +2152,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 7):
+	case IP_VERSION(11, 0, 1):
 		adev->flags |= AMD_IS_APU;
 		break;
 	default:
-- 
2.35.1


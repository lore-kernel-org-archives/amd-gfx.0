Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16755C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A05EC10EFDC;
	Thu, 30 Mar 2023 19:46:06 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BE510EFDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhD1yKlkwdKHiBvbU4duxH+s5ZIY5JtNJXbLxLSD/MUx2jX51PFbeanI6UmJM+BPIFpC667IUg1Dxii8QTYXbJa6TD8+PCyZvZKj9Y1q16+o3RkklIWMMTtkB+boYq76SxK4T7ZM7/Q0KotJHrAfTriq86JEdse5FU6d+3k7zxLNdK1lOahuuKNIawqxKgLp15hSAkh1Kb6y49Qst68p9JnXzOsT0lGOjXz6RH2gjlK3XMBvmvBioBDYd2UelT6Kz8ggv9IDbJE3LPmSVwagoduyUDXML3YldpIGK8XTIcKLFLQsWMpJk6zQlxSaEkGb23o9Z1nQUPYGpCTTLo3FHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5J18OW0qz4hngvU8BMzEaZC2Cdx15gUx9co7T3uwDo=;
 b=DG84q0vBcxl4F+iwHTJHumUkR4UaTFeOuYCVWrv/eNFeboAN/oi7ipGPotuGJTBtjBcYN8gmhzQToCHkScys5fF78V67iqEYof3hOCPmm1getYrd0SR2VY5vvb+F0Karqsg24LRT31OhdC+wZhyv6A1UrBjRVzxA7aX5U+dtnxz+r2B/zqeH+tTP0m6RvjRf5JQdoKJtZGT5nztuyQMUL/PrUe7QKbZ99fZ0q1e1UKdVYl0pUeSW5tDDphmUngKJZ1syVSxSOGPud5pKgvLhq5Syk5etHmnu1NOCF2iRW8rNQ7hljeoljWJozLoCDEx+OSf28t2ss383jLYybKKbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5J18OW0qz4hngvU8BMzEaZC2Cdx15gUx9co7T3uwDo=;
 b=5shBv7nXnphuXQYKxUEDtJYvL10/yfIi4IPOPCxGiUrKn2tRpJwSDL9vdANefrGv8L+QUgz3PcBRWtaPcLSHsZRU04FN1p6oBSIo9SMaqy2kCgEJjE7ARGSM0jwsp7BcgwqcnH0bq0mYj+nMMlGc38O3PRsyjktENf6fLeyiDBE=
Received: from DM6PR13CA0016.namprd13.prod.outlook.com (2603:10b6:5:bc::29) by
 SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 19:46:03 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::b6) by DM6PR13CA0016.outlook.office365.com
 (2603:10b6:5:bc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:46:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:46:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu: Populate VCN/JPEG harvest information
Date: Thu, 30 Mar 2023 15:45:46 -0400
Message-ID: <20230330194547.1135862-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194547.1135862-1-alexander.deucher@amd.com>
References: <20230330194547.1135862-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f1f600-c7e2-4692-120e-08db31576564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0tjZ4E/XRyMze/fj0g1cmxyywX4PJR/izc5GJxRqXal/4QNKQOdeUb5ht6AmFq9Y8QhRnjE7qYARfcn7dk6ai7wjcw4ezmMOhOZo4qA2vqaKXkz9lSu/Ka/6MO9yBhh2kn+G2EW7SL57Zxs5x7KSaFlhHUkH4Mc/3hRxBhIZIGQccS//f5fqlXCmkpL1HR4Px/sAe7kfvzf/1SH7Ms73TyBdWIPhpnpee5z5brG6UrH8oR9qfVyl4++741CXk6oz00DlgB69joHp1qW6Loji9mlA5cI41VTo8nmE6UV/usOoxSoMA28CdmMNBfwc1yKDe03f/lIXSFidQcyQCOrlWf7Hh2dnDgAYcg4rlHNZYb3bI0KTPZYJIkQPQTv5IsquJfH6xNcZzp8M5fxb79jS+uLypqGPNxBO9dqiNEkinrBuS0x57ymPWNzalb731QarxbqVBqFblZ3/+tJQiOVbF1a8WCBhGeFyb4rYtpuy1iIIqmZqeY+fU98z+DK8lKfpArQKmMcoet4NUJsKq+dSZZfFpa1R+IF7hBgChVek2obcP8frv4XwHAmAsw41dRbuHAsWnEPVDwanrIvpX7zQ2UfDx6kUNmKiDqHmJ4g/iaCJbYBz4ojaLgazmQrqEeeg2JaqGDXjMMYaeI++KzZDSIdqjOd5SI4/bnSFHkZLyvXgR/K19kcUtIzlEm2GWtAkPTSSV0A0anTklUOYTtVeepv/KFLkP9l7sfsChIGhyw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(426003)(47076005)(83380400001)(36756003)(70206006)(40460700003)(6916009)(81166007)(356005)(8936002)(5660300002)(82310400005)(86362001)(70586007)(4326008)(82740400003)(40480700001)(41300700001)(8676002)(36860700001)(7696005)(336012)(2616005)(1076003)(54906003)(26005)(2906002)(6666004)(16526019)(316002)(186003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:46:03.5405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f1f600-c7e2-4692-120e-08db31576564
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Certain instances of VCN/JPEG IPs may not be usable. Fetch the information
from harvest table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 200cbb0d3052..779697d8b939 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -563,10 +563,10 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 		switch (le16_to_cpu(harvest_info->list[i].hw_id)) {
 		case VCN_HWID:
 			(*vcn_harvest_count)++;
-			if (harvest_info->list[i].number_instance == 0)
-				adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN0;
-			else
-				adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
+			adev->vcn.harvest_config |=
+				(1 << harvest_info->list[i].number_instance);
+			adev->jpeg.harvest_config |=
+				(1 << harvest_info->list[i].number_instance);
 			break;
 		case DMU_HWID:
 			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
-- 
2.39.2


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93628ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC5D10F3CF;
	Mon, 29 Aug 2022 21:18:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BA810EFD2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQNAk0amgzoglIP2PNrgPuxkqXT4d0R+ihlUaWkyUZB4E110eGGqnp2hDE60NVIk+g6wxkOhBX4/nGTfWRxSKe9Tks3CzJqxj+KZ6DW0HAzphX5aYR9nX0iuAjBtvDCho5wuZJ760Yl18zCVKh4cHcqLz8+3S9o3bQCxMBg7nqBwFTRMMuUExGbX8iQZvFOzE7e4ODguQGfVsOaiO/AhMpafpRYrGLJFxNdxE/7v0plgO+RXpKuHTkqL/tSI4N4MI3rg68clgK8ermy3VOQSv+GLj1eRbsPwO7wxyI1rMikikWtxAySHUiw36BjXnTej9vt1pmMqYAdaJ0AqpCWENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EanE8Rk3J8BDBNJDTcZpbbCJGlRBDvXzFu4A/k2e/eg=;
 b=fIZp38valz0MIHSKtBd4w0tK6FSfGaIRgB7EaKoLZEYc1iwcZXHJEpmlmkgBPJekMcEatLZfw98bueM6pzbdnCz7zB259dGkWMeaURXaBqN3K1eGKlKPy7ILqHIR89gprEguWsrgA5vkKq0ZIXpG+kti+Cu4fyOfVGPyD1cGlfFMAP8+ZKA9M0Y19Csin1hpOnAwVmG1QfhRZnVw9COpJAr9dKW90vdkrMSRI/wwxHq4d3AcJPS+kwmTF4VutFt5ZBtPpu6Rv1aUnH1Mgr+viZjkNyJh6IRYFLtEIPKmwVZ02uoERbYpc2DWUwPBBzIpjIAf/YN4geG6D9fX9H5jbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EanE8Rk3J8BDBNJDTcZpbbCJGlRBDvXzFu4A/k2e/eg=;
 b=T/eXoRnlsu0FYuW8oDD6aBZO3EvOlp4jOsKtZnHM6aRu1xvLCOl0asw/6DwnUdWpkO5xyToC4z+/wNS1eHyiZUkyc9JPAAtxNBE7um6ovgVAf183tC85RCXZfIq9Svcl//l6IgdwFmOsNSf7lrjz9KefQrmEi/749hZDI68P0bw=
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.27; Mon, 29 Aug 2022 21:18:29 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::57) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Mon, 29 Aug 2022 21:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 21:18:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:18:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: add new ip block for MES 11.0.3
Date: Mon, 29 Aug 2022 17:17:56 -0400
Message-ID: <20220829211756.1152505-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829211756.1152505-1-alexander.deucher@amd.com>
References: <20220829211756.1152505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49c448d2-54c9-4aaa-79bd-08da8a040543
X-MS-TrafficTypeDiagnostic: DM4PR12MB6376:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1jWYddMa3CaEXwd3BsmNaRF0PzIU39zF8TkvPQ1ddPkKzeyDRZ+b/OC7kKVGK53PqoyGyk2lju+F3eJ4i9V7ECcKD0Y2O6jClpihCvmQNGVqBJz4MIWOOKBp6eUIimu7Cb/zmtJ484XwNQYgHCpfTRTdG09kiqvRvaAf9rHmd0QMNqOSXdUwir1R+q/Z+crHrc7cYddCGek4iww+cYn2BFyXV+yzgSPlVs2U/M/I2o3bNB35FAd9Uq2AW7w/umaG5+7yXcG7mpI1JhiQ9z9Oh2Afd/1qRgD/pnYEXTcxR7UcankWzLssZMPIFjZXc5911R8CaCkIjA5YRJkEb2BoaeJ3QMBDAOz+11ZpEHYIyQhBuU3SgxKaJkqs2lp5fDZyop0H4j78b/BC74F4WFuEmGkbQsyexnvwxM7RHh7DMEsvZgSPf6szE9kLGyNTz6GSe/7btmC0lzOWawOpa6lCWM2+8ZeYfDSVJxcRVNx35DDAMqLRGRCwl48icsS0Dk+rNsSWzuPe6oYWUFc+mggI4w+KhOjX9VXOKEgPciZ9IQ+yb4EduLYBfRQ8mZkyp6G960Wv4HSuqb8v/eEPHUtep9guP6PwbBI3CwtNdZ/y2qSe1D18+UTNKyqDafMiF8yns6RspSOxRN1wPDWwx6YDGC2bJV18Kb5Bv9KP283KlVq1zqZdct/lmiGnM2uBKE7QGrlAo8d69TALoGlCfvHNBu3HqUcLPMlzJufeKogN6RXJBR6dvvtm144yltcNm757u0OsqtYfdrdsnd+4BJI7VduWg/aPqfBKARLl/W/gXY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(40470700004)(46966006)(36840700001)(356005)(4326008)(5660300002)(8676002)(426003)(40460700003)(36860700001)(70206006)(82740400003)(478600001)(36756003)(8936002)(41300700001)(316002)(6916009)(54906003)(6666004)(70586007)(4744005)(47076005)(86362001)(26005)(1076003)(2616005)(82310400005)(2906002)(16526019)(81166007)(7696005)(336012)(186003)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:18:29.8219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c448d2-54c9-4aaa-79bd-08da8a040543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add ip block support for mes v11_0_3.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ee4ae555c487..5fd56ebc3f6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1946,6 +1946,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
-- 
2.37.1


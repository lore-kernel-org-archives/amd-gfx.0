Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBC0C77B62
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD07110E903;
	Tue, 28 Mar 2023 15:14:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0042510E48F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Btl0B37bTBhJL1uKzhvI+iHYTPoAB6vlHufgLXhISmO3cyJmgWfJcn4MGcWhn7TJLoSmTJDuGwEIWMd4Fishov5Lt5klPzsyNtP/jXu1hOY/ZWrFdPG/ywNvtFXLZNS2c31r5609FcR3nmvlhoRN8/8Y7SJ88+NRo//cYPahhW7gubxmWrrmMINcp8hNrGzYbO2uXKkP7grCfeBZQXl0uywaWyQOsOwupMiDCOhERSI2ix/6NETD98jld/HdCQ4yD+D56FLWO2CCaIfkqYCB5acLqRVa5H9R9LZl/bmSm15ot6KcjOF6sb0BGPqojTJP3/VeeAux2Rxe6gVW3kyrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7ZVfvnNepTf2hodmianmdpEMhLM6/aa05xITW2IrOQ=;
 b=Qu1SoB04vx0bRp1ia6XalemZMgCBK/PTbAHkHzav07AH4JiCtUOAqbpjt/DrxReVvnEwu3ppEVA7mAXYIzYc0EvKqv7RljhXRmfOcyxSi1J1FwDnjAZ9QYNHVf9x9P7jF7h6nljiHmBMUXGjtevYlwqlDwdgTXRtyZcjL0XW59Z0fu1X9lZmwlkJTvabzt3Q2rgOipdId+KsDDsoJJKFHSLZhhWW36oZdt1bsu1XcG/6FlHPVX6kD6uAFWfUVTVwK3XpOJ9DaNXy08PxJLrPZlJFPyZgQcc+9S8+c3uS+HgAdCIsl+PmUf7jYl7exRHX7dYBYLocHn4UAuM94Mx4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7ZVfvnNepTf2hodmianmdpEMhLM6/aa05xITW2IrOQ=;
 b=ouBHy1adP/VfubYDaqmU8NOmUhspUTZ/DYT09lseLV0mmWFMXlWdWtfo4oDxRFnJFcrZhaCfcefDvhDrDqXIKy8VX9KbrpgZau7QCuegSZ2nf7GngYBjiI9gqy1zjoI63WPzyWBRtd/Piix++JXz+xuu62fO4TEyy9l3Ak1YefU=
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:14:12 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::74) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/32] drm/amdgpu: Add mode2 reset logic for v13.0.6
Date: Tue, 28 Mar 2023 11:13:17 -0400
Message-ID: <20230328151344.1934291-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: b00c3d96-3c47-4729-e9d1-08db2f9f15e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HL4/usb/mjPHTh7eQ7ADIBqytFESiXAYku9HMnV3S5BPBWIej9Sa8JxSyil6cOpKLnh42OFLD09s9hVuGsIApC0Wwl18Xq9eo7G+7EfBlPjsY0QNNfsSq1LQymu86riiZyAE9xegBmn1gW9j75Wu0xhKsGJ3ldvFWfgjf2E5jwR7ku0QcbcjdsRLE7tIxePajcLvswXJX60nC8eEofoWspYdx8gvQbyt4nL75YEwvSmWD3X6Kepe2D+IplnA/4INdOa+KYu+ruZyHEAYYwR9QnqeW4aWSykKCDcpaXsi4/s63oSjBWf/i+Hn/D4yej6r6LxhGvp1ApxyRQBdK+OLRgnWIWU5caAANwIw5Rusmk3mL7v4avxZres7z4o2NeDoCHsOLhvwqdG6YyW0LyMdAKBd6cO3f/hHD6/7ol+j3a+AEMuGQI1shY7V7RJXHebSpIq3wXJAeUkQ8SRraZzHSCZjhzqk+hwpIEg565sNa1jLztXwWvEb4tbm8+ScFgJ0bDhWzbvtWlh+qc0sNykVesNqcix5t07pUdS0kl5uiUB91MUwDfREJe+8XHXtE7ePwoRQzk9MwqyRlSslSgXreCPWz8cuZ1N12TgkXjnTBQfYq+AyK9PQ6PnuhR7GLXuvbHy7m3wUFHs5+1imz1eBd0AJ+oAOoEOcZhTdQGE5dusfm5SQPYO73pyMXykAe6xGAoIMqD+rTj1rUIv0xJxkK2gF7qmuvipEdXQt69WYI2M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(8676002)(316002)(70206006)(6916009)(36860700001)(70586007)(5660300002)(16526019)(8936002)(82740400003)(186003)(41300700001)(4326008)(81166007)(54906003)(1076003)(47076005)(7696005)(26005)(426003)(6666004)(2616005)(478600001)(40480700001)(86362001)(356005)(2906002)(336012)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:11.6545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00c3d96-3c47-4729-e9d1-08db2f9f15e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
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

Mode2 reset for v13.0.6 has similar workflow as v13.0.2

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 6437ead87e5f..eec41ad30406 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -40,6 +40,7 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 2):
+	case IP_VERSION(13, 0, 6):
 		ret = aldebaran_reset_init(adev);
 		break;
 	case IP_VERSION(11, 0, 7):
@@ -61,6 +62,7 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
 
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 2):
+	case IP_VERSION(13, 0, 6):
 		ret = aldebaran_reset_fini(adev);
 		break;
 	case IP_VERSION(11, 0, 7):
-- 
2.39.2


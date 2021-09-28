Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D82C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38D96101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A38D96101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC7E6E8CA;
	Tue, 28 Sep 2021 16:44:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04AFB6E8C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzDeeoqT7HIpvsUH3GLTzZ7ocI/tjIWPwyYN5hX+l8nOhkbWyidd458Z68hBIiJ/nd/1ZC6JDJyBc44Vx4C6OtqCH3r5B3XgG22+ZAPolWzXTqs/jxl+I2lFLIp7z8gLd3cAtxx+VgfF6NGLQmQG1sHL8S5HmcJKTrsJydBVok7bQkiuYamc6l0xKyj+9qReMYvjcrTSRWB9TAfk5egO2Q/puA3biLRzMe+9IRcU680ebXIy7elHLY9jxWKhS1jh3mkISd7WjOnDD/C+mR1XL/HnFrmqh70mBfj+6X+Yo13SGmulSxU+9C3grWvjh0so1UlgSFfz5+kTBZ5bFZBZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=m2YmE1I9b32PTS/iVmjwKA+4qPPxV+imlJMsO8M0+LU=;
 b=CX6RlZYRN6ehdaKaNL3rmxPMN9KxrLWdbLBHoIk/AI6E0crlE5RGd77M/fHHh378rIQ4f6tfFBbTeaywo9R4+h5RbOvmx5elvXGIy7MVeu2QOlBlkEETQgr01S6PJNl7hQY8Y5crtw4PDEKEArzIl2wDPzw8dXIcqDvSm098979QDpTDXlRLs9iTaLhjtjbstdlS3JWQdID4lWZFxaIubGHA3zLvt1BJ096JHnlWjsHONyUXIqpXgMtXwQ5wmskJVEzUFKDqoD3bl5ZvqkB3LqAABjIZ4mHFGuJLhKSq9KOqMOTU0AKYMwK9ZC2e/mxCr4lawQBvA5I8pZao+x2MFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2YmE1I9b32PTS/iVmjwKA+4qPPxV+imlJMsO8M0+LU=;
 b=quy6PqbhS85zMd9ZiamXQJNTCyxLGVJx1z89PDCKC8yncupotrlWVmHi/ZHarXosZrfdOq+M91pf4lOwFVs0JOl6FjIXU+LoMXEv1+Jf9OZu22N7TCc4Ijn5nN+kdROyBZLkJ7JeJgZVcUJ38APOKxQy6ytyQ2+EWvZeh4Pdvs0=
Received: from DM3PR12CA0051.namprd12.prod.outlook.com (2603:10b6:0:56::19) by
 PH0PR12MB5467.namprd12.prod.outlook.com (2603:10b6:510:e6::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 16:44:21 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::d) by DM3PR12CA0051.outlook.office365.com
 (2603:10b6:0:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 22/64] drm/amdgpu/navi10_ih: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:55 -0400
Message-ID: <20210928164237.833132-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af42d12f-3a40-40d7-e73e-08d9829f3878
X-MS-TrafficTypeDiagnostic: PH0PR12MB5467:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5467C3A32E8CA574FE85DE04F7A89@PH0PR12MB5467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHeA6wvBrT8s6qObdaADXLhh3HPh2Q89pY/6VmEXNZnnFuO5CL5DJUJtHdGcLO3LA7+YcQ7vvQM3co/7xOEQn0Jmmw6HDE96Q6dy41zhPdbo9MpIJjxy+UI7t/EvfpnktsK/I4U+iTbiwAGEW1Jpi83ZJQM1LFLW53//Ezn8u6tha2looGA02OEsJSnP6pkKYNa/ykWbo+1rGyWkrbNvoEG2/ABOTXlNnvMnNoQVg/kClOuqKXxE5o6AboU1USPPpP0GmkKpMQCKZ/wU3N+dbga2MtIaZ0AL2EWiMf5AJ9Nbr7WA11xRWBj/zrEWg1p4VkPx8B3XDln4AwFofeg5VIZSWqrlrjTiOPqxi8xQVWT8TLH+/MZk4sBp4P06VmMT7pg07/B9ghw410i9yy/v+0Xlv9xwCWTTQdQ6nnK8EGBrxHrdrIntb+6P+BBl8rb9LLxIaX5h9+tZrbc/PEa4l5mItUC95caGzrhT3G828tzpfobsZchG08E8trJuLcn9v7q9zk496VtDOmO0BgmJD+adQt3i1qKsQyy/VnM/Qk9yU7JbzO80xhoHkvrYbA2nQlzhplMGqSlDaEVHx3bAoJmJ8aC0GTBnioBt8kyAJ8aYu/gFMI6sMl9lfpuEfxN58Bnp/b4e9rYeGyPM8RJTVANc4Pfio+Bp5D892tbcIFQ5uXBXlFQGd0nMGgStnSEsV/9XZHHZzq8Y9jXpZhTzlIzJsmJdwJxSfja02wCZmyA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(54906003)(2906002)(7696005)(508600001)(6666004)(82310400003)(36860700001)(70206006)(86362001)(70586007)(36756003)(6916009)(316002)(83380400001)(4326008)(47076005)(66574015)(336012)(186003)(8676002)(26005)(5660300002)(2616005)(8936002)(1076003)(16526019)(356005)(426003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:20.7704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af42d12f-3a40-40d7-e73e-08d9829f3878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5467
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 530011622801..c3f968d9cfcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -107,7 +107,7 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
 {
 	u32 ih_cntl, ih_rb_cntl;
 
-	if (adev->asic_type < CHIP_SIENNA_CICHLID)
+	if (adev->ip_versions[OSSSYS_HWIP] < IP_VERSION(5, 0, 3))
 		return;
 
 	ih_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_CNTL2);
@@ -332,13 +332,10 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 
 	if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
 		if (ih[0]->use_bus_addr) {
-			switch (adev->asic_type) {
-			case CHIP_SIENNA_CICHLID:
-			case CHIP_NAVY_FLOUNDER:
-			case CHIP_VANGOGH:
-			case CHIP_DIMGREY_CAVEFISH:
-			case CHIP_BEIGE_GOBY:
-			case CHIP_YELLOW_CARP:
+			switch (adev->ip_versions[OSSSYS_HWIP]) {
+			case IP_VERSION(5, 0, 3):
+			case IP_VERSION(5, 2, 0):
+			case IP_VERSION(5, 2, 1):
 				ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_Sienna_Cichlid);
 				ih_chicken = REG_SET_FIELD(ih_chicken,
 						IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
-- 
2.31.1


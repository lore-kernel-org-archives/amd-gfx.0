Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF650EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 04:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DEF10E63A;
	Fri, 11 Aug 2023 04:12:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9486F10E63A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 04:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltEfcGcZvn8c2lLrYkiXwhMVnU6AJW1ss07lBlCBFOmFuzdAy1eTpgixrc+2qUOub/mn7pYsWC4qnM/GQDf6RpzrqLupPyGDgwO11rmPcwVbd4c+LavXUf1tblqyhOGMe8+1FMqhjHn88YxVDmqa+iDRYCoGel43+5ubUSAXTPO8+QqGg3SoKwUt7rsX6/PESJzLHLbSQSQZS7foOQDwfnjUdGugQ6LSz15BAsxPxaOKlhzbj/ik7W+PG4dtolTJHx9fKum6h23fHUsnRwaa1J8yZiylbO4sd16VBTCBrOfgQIca4QgWFpetiCO3mnBMhvjq5ubNib67gRCL/iTMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AegiP1SH+FxKx8t0X0WyBZXkJpC5eRdxLgHonpOiRhM=;
 b=YcZcRmMdh1BP6lFmzIaohhBPH68bSXS+flbkq5CYzKRUDaldbA+4f4JL3PjofqulSsix78VPHy8USBVu7PtIQg1UbpyD37abCRyfiLjMYF8co4ZNUUteNUURc2aghBLS80hKl9UqRNUeT0qzQfqfA3R/8q5vS3DNEgdiJkDWR+rkHv8X3/OJhlhQhUMVqorZh7EyRvfdTt3TMxWM/vlFRn6vpRT5SgYVbGzwccm/MIwgOMNb4igWtCc0FcXAvnubNB2vPf7HtSeGLJLcdGAIotEwXLfVonlPeEbs+Dxu16UL159lrq5RmXaRFe8tIkhhc/HBwhgSAMjcXG1meVqs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AegiP1SH+FxKx8t0X0WyBZXkJpC5eRdxLgHonpOiRhM=;
 b=fGfDxJE7IHhp0mklqzsKhSEu0FAH1aRS5MTd12LLWqvBJnWnC7WDuaZqjLFPTAbgPsGXDglIsP65aaz5klbn1tKRCb3N1P3OQL7zyOCpkp8IL/pBX+ylk451FpIXAhrWHxi9NlXfSH28Qq/gYfsxRuRL1vzR9ceG09GGWFot/G4=
Received: from MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::24)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 04:12:16 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::8a) by MW4P221CA0019.outlook.office365.com
 (2603:10b6:303:8b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 04:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.39 via Frontend Transport; Fri, 11 Aug 2023 04:12:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 23:12:13 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add memory vendor information
Date: Fri, 11 Aug 2023 09:41:57 +0530
Message-ID: <20230811041157.652427-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: fa17efae-6c48-4d58-b99c-08db9a2125bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/pgHvmrJJw9SlWKm2GvC3LGXHHnV7CF7ZAplCJOhaRCYF69+craxScDeUurkB4Xmctp9jqPcb1X/tJP+S823HoDowV13FGHT49DUDNVLp4inKnQ4pO+hcGY3AM+m3JaXlM5FgIXU5aKVYfSZbwKGsgA8Ia407y0NitsIglSXISGwSo/Fd2iHIsFOoseLlzUAi4MY1hfI+LzpMUJf0T0UH+mNE1ZbFGjcQw+SE7gtTW3SwK1bmrNtNGfWNj30i4HHcbpSlggZqOwAhiTybGyW2uQKh/Mzpq4+pjW65LJPxYaKEB1brg5eVnyMgM225JA/iN2UP/Y/aCZ5QYSXE/9H/foO/PH1qFZFQRDlLHQHD2HQ0SD7/KOdKxpZBNt7rCeMf81/EBqjpQYY7b6CmMg5KD84a/pb+XYLwRLZ+9V0lVLj1wHvjhNptMajo+6gecZbkQE46LjyzPKDoQHIBqFfLvcHE70mhyOX5+xyXfym9wpRbupHYVY8DEzU3pYj+1JPw1REbthNC9hBHWH9dzxXfUd/p0eyRuOsPmlbCl9GUek4ALWMXfjQYMYyW6aJCji1fWU4SeHaZprN53exS1kJqCUW3JjTnc+6HMJC+IUG4PcikjNCv7dALoH9P2TvDL/hoAYpNQkY0IaLiebCU2NyajWidUda6IV8/GMCIsMsjUKJCajvCZc55sPpQr1iQn0qkTZxVU8/Hx27O/n/IclTSdIXVW1ZdsT77ZHCr+haxa+p5Zq3+hr6Xbq8+PGY1TNhERgpVUzRH6yz8Zq0Xa0Iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(1800799006)(186006)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(40460700003)(36756003)(86362001)(40480700001)(356005)(81166007)(82740400003)(36860700001)(1076003)(26005)(47076005)(83380400001)(16526019)(2616005)(336012)(478600001)(426003)(54906003)(6666004)(7696005)(70206006)(4326008)(6916009)(316002)(41300700001)(8936002)(8676002)(70586007)(44832011)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 04:12:15.9152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa17efae-6c48-4d58-b99c-08db9a2125bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For ASICs with GC v9.4.3, determine the vendor information from scratch
register.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 880460cd3239..f9a5a2c0573e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1998,6 +1998,19 @@ static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
+{
+	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
+	u32 vram_info;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
+		adev->gmc.vram_vendor = vram_info & 0xF;
+	}
+	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
+	adev->gmc.vram_width = 128 * 64;
+}
+
 static int gmc_v9_0_sw_init(void *handle)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
@@ -2010,15 +2023,12 @@ static int gmc_v9_0_sw_init(void *handle)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	if (!(adev->bios) || adev->gmc.is_app_apu) {
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
+		gmc_v9_4_3_init_vram_info(adev);
+	} else if (!adev->bios) {
 		if (adev->flags & AMD_IS_APU) {
-			if (adev->gmc.is_app_apu) {
-				adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
-				adev->gmc.vram_width = 128 * 64;
-			} else {
-				adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
-				adev->gmc.vram_width = 64 * 64;
-			}
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
+			adev->gmc.vram_width = 64 * 64;
 		} else {
 			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
 			adev->gmc.vram_width = 128 * 64;
-- 
2.25.1


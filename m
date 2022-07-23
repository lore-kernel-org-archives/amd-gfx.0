Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF26C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Jul 2022 12:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29713A119F;
	Sat, 23 Jul 2022 12:49:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F7AA119A
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Jul 2022 12:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5VeC9dEmykIsdMpNEqVKvrl5PnOedb3+pLscptVVaspAs2otWgaORmeVbxON+148OWp7mps34Og3sHrcGYmxis3MVrghg5gBOjHgCLa5aUHkxgwwnW3JWgbMSuZ8IMpnS1LJ02nveVOX9Qf7ly+aad9IKB47zYM8E4XCgnDq2CwxKjaw39PEZWcZxwcfm6e38DTdroRaLLs1HY9mL01KgNx0U2ere404Vo77AJi0VVf+uIC+TpQ7jQLIU2Aw/OS7ZPTWYuI0nTBOEVWfgno4Gj4cFrW69n0RdtJWxUKzDMkz6wFuO6xiznOuOqpvRwrIj+VnMzl1cdtcMQoImln4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/wKGAXmjlCOcByW2xEn+xSoj8qAzQjpxTQoL0hpNQQ=;
 b=Vgpg5NmTAKtGs1rpugj10raNHNv9bZZZpAjfEilHpijlnjm75Xr3WzL4mpax9EGf5lQkwIUexL2ITrWAKvSpJuANLmWSyOCIYD16yBDhTsPOFmxnpQiCEKe5YhdqvVJrzUPEK65tQfKQd3OPQrod27RTQ7ia2InpYOtNnt2B5sG909k94AfieqHjkJIVUelqNnu7aPlp1js3So+aPqMC0r8Gy/99LAJAcEjjIIEXP+mJCD6yk3CYdZJIPBk0b6WUxOYQZJkBAldnlGqas7dIKmxOgiav5BFTThz5D8tbD9RG4Tq2V7OxChHSarvag9kn2iBBWFoX60xwyHs54HHyvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/wKGAXmjlCOcByW2xEn+xSoj8qAzQjpxTQoL0hpNQQ=;
 b=Z6pur0S0mOFCUDctVQ8LDe/moFZT+2wZwO1YJY/kbWDe90H0xzhjRMA+mvkDDK+IVVo/yn4YdsegoXhonZGdbih32hI8AtjrQVjhUvzbwdQKNcb/DAuAtF6akekn2EHrWb2S9shSqVkpjPOPtHyd5pvIgZ0mJ5F/Y3A3CSPED3Y=
Received: from MW4PR04CA0383.namprd04.prod.outlook.com (2603:10b6:303:81::28)
 by CH2PR12MB3832.namprd12.prod.outlook.com (2603:10b6:610:24::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Sat, 23 Jul
 2022 12:48:56 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::8a) by MW4PR04CA0383.outlook.office365.com
 (2603:10b6:303:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.24 via Frontend
 Transport; Sat, 23 Jul 2022 12:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Sat, 23 Jul 2022 12:48:55 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 23 Jul
 2022 07:48:53 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct RLC_RLCS_BOOTLOAD_STATUS offset and index
Date: Sat, 23 Jul 2022 20:41:33 +0800
Message-ID: <20220723124133.669673-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b45c57d4-3ee6-4f2d-c091-08da6ca9b489
X-MS-TrafficTypeDiagnostic: CH2PR12MB3832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfFxD7JD10Af+sHgRVPgc2qQKfgj28w6OlSHSITABnOCnTW/1k0GO6u2LhzIK/nQ09cqz36HlzUN4QWfTB//jREMASQ1sKOV8HQ+HTUbibNBFIgvaC/VDp11zmZM5j61Kz3HFGBL5AQqvDlfAB5Sp4JtU599aQNHujT0CYS12jubXqMc3RFiXNk5hPuhe8h/EhKs+H5jVxzTJUjuw6bH80ZBAFf8jF9+oSvN4TqqMtun9PBVg9NCan3ds7PEbEOT+78ht3FfNFH8oCikAEeyC5P7v6vVaoFgZID2fY8ZwVGKn8bEf7kF1l8vHYCzNQ1ZE3MRh4tLi4OjOw8nfRHbuSzEne+nqlUEpFYZdSGn/1fcC9GZJ+K8KtHAH28CU2QL/fpq24B65nqISVdcUoBkGptUQCBy5t2nkt5AzZ3LE+et+pHirzx4qVvuCLrTpHIny0Tw9W537e6riyoI6f4uHx1UNYoS7GNQvLpcR+AShX7L1JVmFDEkAlA9X6vgbY8AINRkV42wkG7V0GTMUK3PP/tQPac5u/vvjP1clh2sf+Y+jK5lYxLxCorMjKh/zkW5zvJXLLp60nkaFh+Sucv6c7VVUc89B5lKPUVKaZP6MXVPDqHgHjDQ+jKARu284UdAi3GTCDw/LOTn/C5mAR3FzHu+hCXANQo3v18IZt4OpOjLnNfKfR03n8uP/BtNeG0olbc0/AieKRdxlOZaflqHvuO/cXpOMTqae4Y2B9sZlOmXPlSf2U/UScF8q1iXQbK+VH+PVHkSPba4HQVF21Zf+0sD8ZAU3c0ptASdOLQ8oZiroAOzUJ5V2I/ztWRqlgjlma0Ow6uedY295oqprpb5Eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(40470700004)(36840700001)(70206006)(41300700001)(8936002)(16526019)(82310400005)(86362001)(356005)(19627235002)(426003)(336012)(2616005)(81166007)(316002)(1076003)(6916009)(54906003)(478600001)(47076005)(186003)(40460700003)(82740400003)(70586007)(8676002)(36860700001)(83380400001)(4326008)(40480700001)(26005)(2906002)(7696005)(36756003)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 12:48:55.8671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b45c57d4-3ee6-4f2d-c091-08da6ca9b489
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3832
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this patch corrects RLC_RLCS_BOOTLOAD_STATUS offset and index for
GC 11.0.1

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0787a965615b..fb9aefb1b404 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -77,6 +77,9 @@
 #define regICG_SQ_CLK_CTRL_BASE_IDX                                                                     1
 #define regSPI_GFX_CRAWLER_CONFIG                                                                       0x1296
 #define regSPI_GFX_CRAWLER_CONFIG_BASE_IDX                                                              0
+#define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1                                                           0x4e7e
+#define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX                                                  1
+
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
@@ -2800,7 +2803,10 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		cp_status = RREG32_SOC15(GC, 0, regCP_STAT);
-		bootload_status = RREG32_SOC15(GC, 0, regRLC_RLCS_BOOTLOAD_STATUS);
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 1))
+			bootload_status = RREG32_SOC15(GC, 0, regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
+		else
+			bootload_status = RREG32_SOC15(GC, 0, regRLC_RLCS_BOOTLOAD_STATUS);
 		if ((cp_status == 0) &&
 		    (REG_GET_FIELD(bootload_status,
 			RLC_RLCS_BOOTLOAD_STATUS, BOOTLOAD_COMPLETE) == 1)) {
-- 
2.37.1


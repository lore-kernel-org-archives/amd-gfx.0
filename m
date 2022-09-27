Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439CFC32771
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 02:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48ED310E0A2;
	Tue, 27 Sep 2022 02:30:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73C210E0A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 02:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLDNmlxnz3Ha8KKv85wc3wd17iZDeTK0KznDXA0bhzjybVAeWLS5C52wawc7lWsula8fQEnvURVU2i2K5K7zpFvmKGAenmtHJMKrv3M2rGAztNjDCQgH5qlqjjCgOJEV36tgpsPl1umSrB75Zo+eKEwrbyNTECpLHqjdkZmcsb+JRyO5uKrQBfen42i7Wc4eeP5CJ0pHAj1J99GSbG8QrDTQsrvykM4W5jyUt8a5lA8XyLQtgMxqD7MvnJOn2ImzfRAQD2VQsmnSfWvIgeVzG+Gvj/s/48STJHhLy3QDZ89BvDWPmyAAcMxeUPXUSEjtClKRVMGps6GAyJCAXuv01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkoGcwLkWhgWB7IWr68WSaiQGXLrDzmhK2DiMw1E6M4=;
 b=U6rtZZMxHnKR5XGZ0khLPZ0i9jIxDN1aVekJ6Mz6pN0X2bLUmvnWefAUTQnZueHhY07hKOwGPaGN6i0davHdUb0w5FUnaUUIV13RjseufQ7Q1XqaKJd58LTuH2LoiY/1rpayyw0F65mn4AljxVBaMx/plhBNTReF3BsVVNSxID0AFW/HiQQqrloDo8bdXWv8eQCqiy/jnxmMkW6PAZqvDx16WHPNBqku3RpF7fpu99UmYg7ANg2N0VWo8OrxAlBMn/UG4wUSmJ8NUgUSFSH/SHCPIx1GLRx8zkUcW/e/QpUMOmob1/KHK0gcjTNnxuE6NeW/Z3EN2VLxhV0HNisTtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkoGcwLkWhgWB7IWr68WSaiQGXLrDzmhK2DiMw1E6M4=;
 b=fx2Em2QTJZkq5792XOIvcG2bLwAMYjhhFtxnQEXrMk3OV0DJCY3XRqfac5feufV4VCnxr9OrPG2BjhXe1NZfhrtCAtXtWYLC2OScp2mLnKEkJf/rrTopga94vNupkwsgIvbn/b9CNJ3niN41mRSnU87IdcPwZDg593uTM8SqjdQ=
Received: from DM6PR06CA0053.namprd06.prod.outlook.com (2603:10b6:5:54::30) by
 SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 02:30:49 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::c0) by DM6PR06CA0053.outlook.office365.com
 (2603:10b6:5:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 02:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 02:30:48 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 26 Sep 2022 21:30:46 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add rlc_sr_cntl_list to firmware array
Date: Tue, 27 Sep 2022 10:30:32 +0800
Message-ID: <20220927023032.13051-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: faf911b3-0870-4242-90bc-08daa0304a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXRzm7a/Xl3QS47fAcI8S+9MLDCUD5nkstDRYgELBnzL8vn5KOn/qWKAUh7oypx+ivBIcQBCQfSVEQSuaOEK8H5YrmdPSh+wuWJ25qVB4AOI0LULLbS1kntkmMzL8EEPmjfXCqD0zw7nGa/PnkB2i5Ks94UjncqYsmADp9e8Ys/Wl2m56g1LQFd5mLjzSwGLKltJaRlaQLXA+K7/Q6UWyzu7bDCZjZv4NljXIBZ/vuasfys1c+a4XTYrcsxmCpXkc+yK8ERBvWdCcwlw/vlFQk5q1V8B4UP+IaNEPiX+JnpJdKCSinAgV36htK4wTPwJQJNW6Bavv9xm7J+9Daq7u7H3vEQQiAlz49K6PcultG9PHJpNOl2sMuuLqp5hpF1fmYXWvW6XftctAjDoTceas2z5JC1ZHCsFsjiO3vgse0KJMqqIrq80ihskj810bReMf3pe7PvZeXNdCwFTQCjE7/yyOCgfLCns3SEF1qrIXGTHxHeA4WdW5SX1vsjv5RiFW6+DLFcFHlfGhuMt6xYT558gXhaA+34LD5afbtbRQPo4TdBKoHyLL1UxCl72cw0DLhxODTCRVswsQOr+oSYCrxUrVUsqnOjGCvknxlSSIxyxOvTe1bwO0pIrV3mhzLXA+W+DO+BqpObqvMKqXUm8kMIGdkLcblftbgwo8GUYou9FvcnEUjYcq/w4RN7/5aAQ6HdtaBpqGMaGPP3u02zYue/A/05DYmz12nndZEbpjzmHTnBfEwXoPn4kcQCrZAk5mfBY732hogh8cZwG9ZygpSyVGWWwtp52XqdhP/xUcjKKbvIfTvMWxpc7AtN779tR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(426003)(8936002)(5660300002)(40460700003)(26005)(86362001)(36860700001)(7696005)(110136005)(8676002)(70206006)(70586007)(6636002)(2906002)(36756003)(4326008)(41300700001)(316002)(40480700001)(47076005)(6666004)(478600001)(1076003)(83380400001)(356005)(336012)(82310400005)(16526019)(81166007)(186003)(82740400003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 02:30:48.6792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf911b3-0870-4242-90bc-08daa0304a11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow upload the list via psp

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 13675b3aa218..792333206362 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -359,6 +359,14 @@ static void amdgpu_gfx_rlc_init_microcode_v2_1(struct amdgpu_device *adev)
 		le32_to_cpu(rlc_hdr->reg_list_format_direct_reg_list_length);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		if (adev->gfx.rlc.save_restore_list_cntl_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(adev->gfx.rlc.save_restore_list_cntl_size_bytes, PAGE_SIZE);
+		}
+
 		if (adev->gfx.rlc.save_restore_list_gpm_size_bytes) {
 			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM];
 			info->ucode_id = AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM;
-- 
2.17.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5537C4321E
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12CEF10F8B8;
	Fri, 29 Apr 2022 18:02:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C0C10F8A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZFtbAgNdHCpcg5Z3QegC5xNTMQVyGd4l23IQfaN7OPAEqLtByCXB/brH4EchfSA1jzra/h2BiPoRcV5ORzmOU4/VT60Hi5LlchRZrTNO68SpT6FpTnWscT/+JtQJ+18mUyT7XhHa6cbttdATfme1Jjb3DJw07fJ+5Lt6cVydwin3PPtCcwL+OCKz5f5o4I1AweSc4WFE3jVe4KBffrzhvyKm9N4HJ4zrQ4srtXgq/RULXY4nFKuVFhADj1QrlMi74wMEYl/7YiP2a2sxe6UyY8+1HyX5FE9+4ODUldQvn2wKm6C1ZYsCuqGU52IHbuUytB02nKe8mIO18RM7T2/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYHfnK6eWQVn0XM/caeTy5p29EprTtKsSxYkNHMKgg0=;
 b=L1Z78B+8IBcvDIyAy9Uw5DZvcWDMTkeF+rTkVRxvEKEzc6AAoQ5RiMj5TcU4i5fCF0c0hnXUHoLga4S8OqjTEebMWsDXHtNqk/x0zLhSaXva1JCUFZc9E37qo6jF0ukoVQ5ISvAlrk/AVgudZp2NWC5rSWK31vLhufIWt/cbKTZkqy19dVGY/Fpc0Qumb7TBIeP+8aI+oAYJlZA8I2uqkiLmnTK0bHDIye2aP37QfcvhNYSpFL5MSu43wSN7K7MctN+JCzRaSwkziJIRXnq3YWBhzWzFBZd7H1sA91l3f9YJiSIjF2KzfxPmzc8mqrY2FQAqPgeAmvLE0CqJGHG+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYHfnK6eWQVn0XM/caeTy5p29EprTtKsSxYkNHMKgg0=;
 b=sgQuNQjsX2vTlE3p7Gr0vIOxi+SJMW9yzDLGLKlpQRn0BaHAMKcksbnzWIBCffg2bo6KCZ0iWFBrxQ6hdRVXV6DCsxx53AFrxCeclicPNHf9Z9ZOUq3Ci6ISpNiw+wsfGbh57wjJy4gqrXY4hK6OAKfUf5weg8cQoXzi6PZMw+4=
Received: from MW2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:907::49) by
 DM5PR12MB1804.namprd12.prod.outlook.com (2603:10b6:3:112::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 18:02:48 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::73) by MW2PR16CA0036.outlook.office365.com
 (2603:10b6:907::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/29] drm/amdgpu: skip amdgpu_ucode_create_bo for backdoor
 autoload
Date: Fri, 29 Apr 2022 14:02:10 -0400
Message-ID: <20220429180226.536084-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4872093-81ac-4465-b6f5-08da2a0a7815
X-MS-TrafficTypeDiagnostic: DM5PR12MB1804:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB18044167A2C5D52895E5620CF7FC9@DM5PR12MB1804.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvArM3YlssYZahfX0IWA8MA4vRsHQM4xwDsP8cPBJ7hzuPrHS0ugZwGaugJjForW04V61N88pJbC3YUteJD/oeBEddfeG9k+s6aaW2tZuBE+qu8tp3yXKYHGov4/J8V6uHetufpH45qWWfh+X+hAsTif/Xbr6WqD+35Omupoks/6Scxr8uynm8mahHfsyjFOIo5sNNeiaJOOLim7/bazNpPvgYEBBph3E9x07FmiGgd3T2ZwKxCVeRaWiAb7ix3rQLJcIQtepo5JkbJeykZHzTkt2NA3YRl2DfD5p0JHurjVQGQNlmoGA89W5o2vFctjdbomuECuAFUEWQQW1ZvW21TLJgJh6UghGrCYeCC8Mx1Jh/AIr8rek/hgjMlSrBcapR5K/nS91Zw89oNPgbODr1BjPFD9GU8LMIOR+ib0w0jCfpMok1bb78eNOBTQGtQkX0xV6Z66U7zGDzMujK4sWZffZJkwbVvtPIts+VLbtM03QrQTpz7jGgj/21pg6WYCY73qicFnEUWyGQgn4+Q5vIpYr72jsrhHa1THlEwS47Y9jzHWWXlAjjZ/tFPrfMhvjG+PFMz4BMKPoQ54S8M3FuwoV1ZkaUlWKOrbMxCk/9kwEffLVRAUsOD1HClEbrWBq8dZtOtdPnMgRtCLozfBE/g6GBj9cn05dyPb/Txju2CEjbIQLM4qxMq6WxIjpkhPWK776ajmtkkS7acoq+60WQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(6666004)(70206006)(4326008)(8676002)(7696005)(8936002)(36756003)(70586007)(5660300002)(36860700001)(26005)(356005)(2616005)(83380400001)(508600001)(86362001)(6916009)(426003)(54906003)(1076003)(336012)(316002)(16526019)(82310400005)(81166007)(47076005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:47.7200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4872093-81ac-4465-b6f5-08da2a0a7815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1804
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Skip amdgpu_ucode_create_bo for backdoor RLC autoload.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 86fe9da72e6c..5e731db12e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -834,7 +834,8 @@ static int amdgpu_ucode_patch_jt(struct amdgpu_firmware_info *ucode,
 
 int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 {
-	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
+	if ((adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) &&
+	    (adev->firmware.load_type != AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO)) {
 		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
 			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 			&adev->firmware.fw_buf,
@@ -852,7 +853,8 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 
 void amdgpu_ucode_free_bo(struct amdgpu_device *adev)
 {
-	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT)
+	if ((adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) &&
+	    (adev->firmware.load_type != AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO))
 		amdgpu_bo_free_kernel(&adev->firmware.fw_buf,
 		&adev->firmware.fw_buf_mc,
 		&adev->firmware.fw_buf_ptr);
-- 
2.35.1


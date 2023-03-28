Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768C7C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A62A10E93D;
	Tue, 28 Mar 2023 15:21:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F48010E8ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BreFU7w8+YVJHvNeK7/8T8eCwNvRovGzXzPcbEYfTcjDOgc403T8CFA0ingofEKcaxVYlVVSpKGtJAdV5GAF4OrKBZLkNB+8afHZIjsvAqLMsykApCEiAHB25jPzewoXEKdYGdknwU/nDX96fAAWZ7/s3MlrM7tYLuYkRfKp4bOBjmKMsEHCKCGnNMx68aVrO7GswLnzHJwD+tfyzrvT5sKrB/RAHKjQmwM7/g1cMwsoVhh4laKqKdBFKW+fHfNTbupYhwRhBGaZCyxC7wUCFfrcTrA4jCHnXDlYdFCAXPFcJA/1oCeNEx77O7un7mOum1L0ZXJrd0U40K1jby8tXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f4jTR5XqZZjU9k1gElDU16LVXFObu2stY0WHWr3Mdk=;
 b=ZXpDpefDdTM6GveaDC7Fx8/43m3DqYkWdbV3WFK0SJmZ54WCIky3UVbyIQ5mHLCjquMZLxTYN/4fOih9HdZTS9AI8PO9IOyGToOiUr6EdOo5yf5EyIpUDyq6SYgWXtI9g8LxKj3Iy0UIzsg+ThF8sreUC1tMdqSN9ZLhHR2JZAYhQ7HbqvKPnCcdvt0+Omh+C7TXk0du38hgZv/0MkLJjzn9FN0RXNw/l5Tug2QQiBBhy28lMdN4mdRl8oyX+4B3L7K4kQ4TKzSa56QBXehKjkRGsF8wUzfpzS2rokfOrbom/NOegqQs8rgjtfC036K6xyRu5lw3mkz1bizJCTuhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5f4jTR5XqZZjU9k1gElDU16LVXFObu2stY0WHWr3Mdk=;
 b=phdg3h3o/sNAcnKrKdQC5dAqvlxyAFitID2nziXtl9q3d5plrk6ICZNVQ/+BxYI7SYjMaNoqMBTqW5slTKOBhJxTcgEpgaZqgXQoSDiat63k0QLbkT4137eGflaXFbyx5U5DZDDLS3cvcYeWfn1BFMVGqsQZrqpDFatV89+xT8A=
Received: from DM6PR02CA0087.namprd02.prod.outlook.com (2603:10b6:5:1f4::28)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:21:02 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::c7) by DM6PR02CA0087.outlook.office365.com
 (2603:10b6:5:1f4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.26 via Frontend Transport; Tue, 28 Mar 2023 15:21:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:20:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu/vcn: update ucode setup
Date: Tue, 28 Mar 2023 11:20:34 -0400
Message-ID: <20230328152036.1934902-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328152036.1934902-1-alexander.deucher@amd.com>
References: <20230328152036.1934902-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: e94efff0-637d-49be-368d-08db2fa00a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzhC7AYA5TiKOIzMpIkJu/iVJTJJnTi7C7oSeFdteQuJiHVf7Tli0yWCb+BH+d2SregtZYT9DOt8w+xEdaIB4Nh5yH/AYk2flgeYT7Og2Q01lBwJNyj5BqiDbQGcfHAHDzDq1QR7SSLhOM+3tu/W1NXOzUJUawQ3Z9bQd56izggSAGGBNbOHC6ei0ZfHA7/2L7WR9gS5atnzV8f/oy/EKweJ499eYAVFhhgBZcDIQ8I0BSuw/7lgqZucbQxfregRmmEvmuGOYh/9zwzeP4l5GTHHIFm/wMqb0kwDTr5bJXJUVKPhSrn/6HRf+wXOG1xXJzwnaxXUljnCCYXIk7/OFmGjHPE8UFxYRqCxju5TdjrXB+EaaMn21eiM5cY8ZZEHIe7WPPNma0SSs75KIGbXvKLwVnPpnKByj9WfuBJMypRLwqjRvhUrZ9/44TY6mF1m5T5a6A5Quu4R0tzz2QRPd8/a8Gj1YPMFIOz6+JG3BTzN1IjMOvSgX0GbVDd5KC0zHZBkmwHJ7o+ju7TjawZdCdx8E2oT0mum2cNmA6A+xhgsDcEO4hPhrEZazVxu5M5qK8rMTwDicUxvTHM2CuOfJHxKVZ8L/jt7V+vdLKoOB7pcuiO82AFPxsaaDJ8JLG/8REnZT4fU3BNIVSvRsmahtQTvZvrhm2XmAQt37b2f8pqd/S4XN4u81wPXEQhrotGDyt0bGMI+L358RZc4dJFjASguB9oeMLXE9+DXnDLgjgD7Z1k8CRYhcniDVIhX9LprCOE2r5gbV+Pr/ZLPuWyV74wtoj3yuJO3vMwDNWHQpJc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(186003)(16526019)(6666004)(316002)(26005)(1076003)(54906003)(478600001)(336012)(426003)(83380400001)(47076005)(2616005)(7696005)(40460700003)(81166007)(40480700001)(82310400005)(8936002)(86362001)(5660300002)(82740400003)(70586007)(356005)(36756003)(70206006)(4326008)(6916009)(8676002)(36860700001)(41300700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:21:01.9131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e94efff0-637d-49be-368d-08db2fa00a77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Use common amdgpu_vcn_setup_ucode for ucode setup.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ddd844cca02e..5eaaac531ab6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -87,16 +87,7 @@ static int vcn_v4_0_3_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-
-		DRM_DEV_INFO(adev->dev, "Will use PSP to load VCN firmware\n");
-	}
+	amdgpu_vcn_setup_ucode(adev);
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
-- 
2.39.2


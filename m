Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1542FC83F32
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 12:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A34C10E66E;
	Thu, 31 Aug 2023 12:37:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B6810E5E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 09:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2I/DMcZGyXYfWe0QAecWY89maFBNlumKfzFmLoa9lINGrPpbKqLsyhoqgeQj8GFV3Gp3Xj63MPgur0+RpQMNM960bdgJ8q+3w1EuuMwstqBqgA5cLcNPg+dooE/RunLxbYAK1Cwp3cVrCU8qRDvZDynHIqiESOONnSTTH343qyY5CY9jzqURXyiTia4MpMz0+i8r+Dt8U/H90gRb0SR7V4EmWW9PDOz0rB+4kIyfXNwIFT13VZRK69300eIEkKYBhYh9jSRdmj5wP31wuqhYye51/DRN/9GAl3P/8toMVXVmGcsdAqd+KEgCa1eXtb8uAdZIOpYBZsX1PsrGtEFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmaQr0m95s5ex0W15RRDVhhCsklsZ+oi/NShVUIK3IQ=;
 b=OLzMsEqbYkagHcOScHoGtJOR305lqJtfOcbGzsDgOd+qeiczB5spi8Go/YfvN1vR/GC/ksdHdgZf2QHK7W2a0wevHFB9E5/BuYD4/rJ3I/0UoYWIuO8cY5J/+6CiHP8FBLfVsq0A1GHtBqY7L290n9OiFLY04Svxi2bBmd1MG3TOPovTJnsf0z2ie8rMk/KyEHPC4gxZiOiBKBaAek+CvrGhBkR/jzc1UMY8ZiaVBkuo8X78WzET8hgBClK5M4Qc2bv7xiwej0ZtuFQnoW9uh7CzrifELiEv8T1ejkdU3unNV1E+cuf0njg7qwBE1gDHwdG3ErEyZghzJdondOl26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmaQr0m95s5ex0W15RRDVhhCsklsZ+oi/NShVUIK3IQ=;
 b=4W3Hf8xLwG0Lm8Xi/QIvebpokRlFxNDMw7Xx5yR94mVL5xNu/KNyOIwH7SACOMGYjY6PeASDpdfbTa+VSUnNYQt+sLQYhNzEq4ld7gySFAXkT25mC3hbSvBe5SfzMNzbmHKNpGeznmR+d4oqV2n8g0CyjOUz3eAkJNHsrlwn7NA=
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21; Thu, 31 Aug 2023 09:53:01 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::be) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.15 via Frontend
 Transport; Thu, 31 Aug 2023 09:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 09:53:01 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 04:52:54 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <brahma_sw_dev@amd.com>, <saleemkhan.jamadar@amd.com>, <leo.liu@amd.com>, 
 <amd-gfx@lists.freedesktop.org>, <veerabadhran.gopalakrishnan@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg: initialize number of jpeg ring
Date: Thu, 31 Aug 2023 15:22:31 +0530
Message-ID: <20230831095231.1416451-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b45fe68-4aab-493b-a495-08dbaa081043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjpQ9/AxTKv3F/KezCar/JHvVl6FNQGEOvVyuH6UhD6nqhkQV/c9UbfbflIwHv0o8K/UcIM0jhfEGG00sv6bi45XEeLYf2jL4UAnjwSwTNtLgg7YwHIm0Xbf6ua3rJf3iGL6ZnKyiHVbSjzF6bLNFvdeHGJlhYRYHPT2A0RvF0qRnPe77al5FjQA7HBnkI4NVLf5ENtFLc5lcCTMytxOkIT9kr2plR/UgRuS0k26IzCKQm+7xd+BA9cxL3d20YnI1pTM5KTp3yjihjQx5g2z9mAKtGWPDM5VpgTSuESBaJI8yIilcvedgDEJKZiASaIgpXB7dGPvVpqyHeMNQbaRDK9Iw+s0AJnqPX9ZhRAT7VGGh/QDlMpUtvtJTlyvjvCgNbvhjmmJWdmb7gat6tPAHSwLczaILHWgqyRzN8wRYn27LZCLK7G8Qxkt6vorLCullVOuXcHV66ToO3viWXjBTNSDvanQs/RFdJYYI7L/qUUerEQvtky6NspDYEeLh+reLO0f9msSXq8j4tTYD5ppYayU4J0lxndLCluk+66mL10xun1Prwv3mybhpsan0V4TuwAmDTlAFet2Z/wI2TbNG8pzVbTQNPMdXAiRBIDkjO/Brrgz3LprhUS0iqHQ7DUz05d+6h5KIu6fUzHvCBXxqqXY2Arpyir9IkZyYeb4vvKVTGZNMK37Ug37OiFJcUa66RGaDTxFCnHUDV+4Xsrg9kZfJgjFrgsSNZ35EP1ls8RLRLBv1MScm14zsEXwMry3za+yOkPZvMVqwSysbQLBGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(41300700001)(356005)(81166007)(82740400003)(6666004)(86362001)(478600001)(2616005)(47076005)(336012)(426003)(26005)(16526019)(1076003)(7696005)(36860700001)(4744005)(40480700001)(70586007)(70206006)(2906002)(36756003)(110136005)(6636002)(316002)(4326008)(8676002)(8936002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 09:53:01.1448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b45fe68-4aab-493b-a495-08dbaa081043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
X-Mailman-Approved-At: Thu, 31 Aug 2023 12:37:37 +0000
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
Cc: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize number of jpeg ring for gc ip 11_5_0

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index b99faf55d3c4..9df011323d4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -56,6 +56,7 @@ static int jpeg_v4_0_5_early_init(void *handle)
 
 
 	adev->jpeg.num_jpeg_inst = 1;
+	adev->jpeg.num_jpeg_rings = 1;
 
 	jpeg_v4_0_5_set_dec_ring_funcs(adev);
 	jpeg_v4_0_5_set_irq_funcs(adev);
-- 
2.25.1


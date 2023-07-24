Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB18C0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 15:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA7A10E336;
	Mon, 24 Jul 2023 15:54:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F24F10E336
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 15:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBGKap2DJw057YktrZchz3/ihqyJ3mvNXseg1Ng/CYG9uUMeECjLxQRNwnETAngY6oWh/ljGkRfjy44uj4tziRj3A0OsqWJd2xxwfy6gIJLNZfGSZW/YYedBC9JCd0z49ojZs7LO+PlH29iCuPz+ibm58p8FjpjLq3V7wQaJOJpGpope/MfzteSzPtpFM8+xsyIE/XGew409QuF74OFc9SJv8Wro5DbCqhhiA/rcf112GM8zaULq9WH9qM0onIsZ2L3S4CAujyZ78++AsHpe8/hB85Qj6KN+su0fORkIrw/bofSXqh2yH+lnGX4Y3+6mWl2nTiFERhmZZqAYbSy1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4wUW6rtCFz9Jek0xQp1C5Em3JNZMyMsCtC2PT6bueI=;
 b=XRm8o+PEUTZjcpQgZxg573qfdIFEUbkYu8ue78Lf2xErmnAtrUcIzBmYRlRQnzg7ip4aPTIeb8g8bIbrEiAOYsdUN41rrkMReUultf8nZwJIVMac/SDcnGwxOyjOXrAhwj0Uxxew9aVaHhg6/iBESKvjVt1YWcJ0g+2a+3nk4Sy0RAsbjkXaATF/AzZZZ0jnYrksOs6BfaIuSmz1Q9ZB9k9rZTjW9aAP6c6JHOVf0Ykx/s2EJGT9Ch4rt/PA3X6a/b9D7jbT/cNVujOQlIVC2w4ClAlEADRt0K7cDAVs6aIzaovdHoAaki+9mAR49kyR19P5hcSVzTn+zZYGHd+Law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4wUW6rtCFz9Jek0xQp1C5Em3JNZMyMsCtC2PT6bueI=;
 b=jtjSM6g1KE1IbMOSWSMFf+vw+VUQBM5bRa3G12GValGPQ2PMTuc6ZwjV6m8Revn2ZTPAbDmQ/5CvpMWDsAhJvEuweEEiuFQGpCx9CPeHsepQ5iNcn+9UiXOqdByqgNNVKPRTil+KEFj2+dYzdXxG/KObh0R4XT3RtgW3LVrZ7QI=
Received: from BN9PR03CA0483.namprd03.prod.outlook.com (2603:10b6:408:130::8)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 15:54:41 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::b0) by BN9PR03CA0483.outlook.office365.com
 (2603:10b6:408:130::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 15:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 15:54:40 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 10:54:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Remove volatile from 'wb' & from 'ptr' in amdgpu.h
Date: Mon, 24 Jul 2023 21:24:18 +0530
Message-ID: <20230724155418.2179209-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: fd11cc74-8120-47e6-c36a-08db8c5e4a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAzgSUtCBvp8eBAMWkZn7aOfIWPVPCdDt7qFiiQ1KLBGNjF5kG03yRttVv1EnHCjZtnoPq3p/Udq7k8uRT+hS+7uPdcVAofFliQr94YOBtLFmipjonigy55BoyqjXrgTM+EA4yGsS1sYNt61VEisuYXt0M7Zc+G0O1uaDcbbj26T5Yqmg1Te9RBqKj25BgtiqG6jhHMs8V8uSLtcpdEhpz5x/ITRndpfKwCW3PDCPx/6tQgY5Nx5OSXiWGU7iEjkaJ3C2YKnGdMEM/ctPsmCY6f3Dys3nSLT+giLDboNqr7IUlAcn8nBx7zX0DI/4EVgqBprvWh1dQLhdarlZ06tbwVzRNei9qEZMD+zcEOTkie3y13UpFKsbEzKAJkExeVH3jg3mVu73X++aPqmULvGz+nj36rvJJ7a5VEUThYu95Nned5DeLiwoVdmUEKtIIwBR0IiofEoaZ2WnOPPmXiY8V937mRsFH+GZ6BSHy1/mEFTdnUo1LMyxLWIPXPq+66a0L0gYn3iimZM4XrDnsqU2h669+iE/xUTOh5K40ISI+JQ1yyw5vHPaXyYZd5V4iRxBfzI4nIc51+7dajtlyKvevGWccGFgbXmVdJWrUuIMDL5sNg5zTchcGqSsyiCYWvy0pnCJbv+sisMSXTapnrVE5kH58HCg7HRUaoRi5JAgNsbH8c/51Sh8z+E/aLNRCt+U7RkIDbOQJ32xA/YxPimExzjUOekP1FMtc5Bdgyaq3G3qx86Xg7HXAXLPQuz0miSYT0soLKqRX8rFebNCTVI6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(26005)(186003)(336012)(40460700003)(1076003)(41300700001)(16526019)(478600001)(356005)(81166007)(86362001)(70586007)(70206006)(36756003)(6636002)(4326008)(316002)(110136005)(82740400003)(40480700001)(6666004)(7696005)(54906003)(426003)(5660300002)(36860700001)(66574015)(2906002)(8676002)(8936002)(83380400001)(2616005)(47076005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:54:40.5061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd11cc74-8120-47e6-c36a-08db8c5e4a5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following from checkpatch.pl:

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
+       volatile uint32_t       *wb;

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
+       volatile uint32_t               *ptr;

'wb' field from 'amdgpu_wb' struct & 'ptr' field from
'amdgpu_mem_scratch', is not used to access h/w directly, neither they
are shared variables, so volatile is not necessary

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a046160b6a0e..06f79a84ff4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -502,7 +502,7 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
 struct amdgpu_wb {
 	struct amdgpu_bo	*wb_obj;
-	volatile uint32_t	*wb;
+	u32			*wb;
 	uint64_t		gpu_addr;
 	u32			num_wb;	/* Number of wb slots actually reserved for amdgpu. */
 	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
@@ -621,7 +621,7 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
 /* VRAM scratch page for HDP bug, default vram page */
 struct amdgpu_mem_scratch {
 	struct amdgpu_bo		*robj;
-	volatile uint32_t		*ptr;
+	u32				*ptr;
 	u64				gpu_addr;
 };
 
-- 
2.25.1


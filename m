Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8952C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635AE10E209;
	Tue, 21 May 2024 07:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YYXtWnsN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEC810E1D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkCbteh20C/D7QWDrA7j4YJk6UVcZ4nGa00YHxL1iYdaxReobZg7govxo0ZhbjbCPxgRUSO8HKGq417FfJnwYUdoXFeHrmATc1Nz/3JTczNOBuMYvuOIDRbPbdBjCfa1DUhyqfHdyjOcwtCUJE6xD/hqQ45ZRyzB4g3BMQvFflXJWuSqYpljEa1Z1oVOi0FsCF/CQ8aWg+jngZHVxOkT3J5SG6c/Jfyyq/2Bn9VAaAKRz0zm64nvVKLWgNbwKjCzKjo/OHH7w2J68cC2qshjIPVv9oiLNvsmwzTJyViTu0tyUJYazOgl3KHqzsW9JROfyyemXrCzxtTfcR1m21+Hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8joyTlFNhdJ2nd404jMjgGpKtGmRQM7h9XX7SxUy7cc=;
 b=RGvIxmFoezP9mnsakOLYbmSyGAiS7K2LvCWuAuQ5CMQzU+KWYBS1ril1HNHVCtnLMRwIQikfmKQRCpoHnbHT2Qzj09AsLgMTysUzXH3D4Eg8cHc6q+dT9Zm3Y4z5rF2f5ZpZyqDbSHbE/9ovF/HljiQzPWU40hHsEBkdeOf1cdDu3mIwLcBduPIaYhjQRu6P5PANyuf6ztqXQNY+RQS3wbVItffOqrbXkScet4SNNhkdjp6MOn34Z64PDv6gaaYPWGZB2xTEnPeD9zhTMagPn02/t38YJuTsISuGnHrdnQRr0oABtMEYBz0raB+7/UdkDO3A0AOISajw2vsE/Rg1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8joyTlFNhdJ2nd404jMjgGpKtGmRQM7h9XX7SxUy7cc=;
 b=YYXtWnsNIQLk2kENOFC2UUt5qZEC8ycWuw4DyGm/cgUc27iK8wwqgfUgOMXKdl4y+mEjBwhfgHYSUMlarbugShxoiPBp93lYbiBtOnmFyRUvHYXmR7/ZDn7WQswVfNRH9YZJYDZ7nkI9osA1e32A9rWWvWk551XYzvQGMGBsWbk=
Received: from BYAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:a02:a8::46)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Tue, 21 May
 2024 07:11:58 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::a0) by BYAPR03CA0033.outlook.office365.com
 (2603:10b6:a02:a8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 07:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 07:11:57 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 May 2024 02:11:55 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: correct hbm field in boot status
Date: Tue, 21 May 2024 15:11:30 +0800
Message-ID: <20240521071130.12167-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0ae085-a19c-4e60-de96-08dc79654d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FJhFKlN0CQ/pOfQF/wA2ye/CTKit+sqxn1h/Ti1N4kKrgsfbCbwDmveCfAJC?=
 =?us-ascii?Q?h1nB9leVcs4whrrneexNtHtzig64n2wS2qEWmQmsO7LJ4NJnN2ED2gJyAA/e?=
 =?us-ascii?Q?fsVzoMt+c1HhT1i6rz0uvNVaG1UcjAgdXZdt8kg/X7ijNvhRVEQ1p9vmWcxj?=
 =?us-ascii?Q?C55qPFgealWM/nQFWAriwqEj7G2TxBM+3IGmy+b/W6Jyah3a1i9ZwDayjh03?=
 =?us-ascii?Q?tKiQnSmi1iZYZO1mTUi6C4bLhVjPRRWP8mPUZ+q0v+rHovxCkp/lnUcDIKLx?=
 =?us-ascii?Q?Z94yD70mkvOslY0gphQDB67FGyt0ZKqwaHDnLUkBiUQ/0O0iDCOgn1kbJlZu?=
 =?us-ascii?Q?Awps/3nPvzUvmo2p/AJ3cLDI2KTGRAAwbAigzEKZgXnj/a8d2k9HhE0EQHhu?=
 =?us-ascii?Q?So6zM5IsuTPP1M03Z37YKbTt0phOZ1b8gMJQ/sxJIfknGm2mAdO/5xBVjZil?=
 =?us-ascii?Q?hAFaTYPiKZnIoycwjkuZYfa1oX0C8FxrPzXAkUs0Uuqp0YS9+NgizvtyiTs/?=
 =?us-ascii?Q?oqHvdzAxGdKwSqtrbG7i6ml/3R5H/+k5RB4V3zNPH507Vlg8uHI950sOCwfn?=
 =?us-ascii?Q?Yoz5IZnNFdxmmfd18Ui08GmXYABhAsIhGPV7c59i3egkcCC/lDpxlao+PlHg?=
 =?us-ascii?Q?Hl5m+IdELBHXFn1p+wsokhYLSwhKkbmOnyk/M0LEqKzLLcKIN335dyTMQeGN?=
 =?us-ascii?Q?i5F0mhFSCcAf9n5R3mcLceHyFL7eAi3AkmC7FWrAYTLjyn9OkNVSHU1KIsyd?=
 =?us-ascii?Q?0xRp3RX3oWKjXVQ2dmDDwO5TmwlmyUHyd5nJwIkQKzkOrTtI1mwHZKy8MjIv?=
 =?us-ascii?Q?ietKUCg91NOVmu7zjWjA6Gtj5BbdAI9tFSab2NvHzjKOf6zAu3gT0C7nYiRr?=
 =?us-ascii?Q?2Pg1U1Ef/vBsM9vuDcbJL3zz/EDOZKuL9bQ6lA+8IyojTa67BpFgvqMFc+Jg?=
 =?us-ascii?Q?pFVc9t3b0Q8j+vaWF6ZuqWnTGliCWjB59xgWr+2WEV4gDIMaQCUqv0NPDv+i?=
 =?us-ascii?Q?WmqvWjbWCmeLPNVsjRHYfv7Rbu49QqVTsmIDN/A0L7hHHTe8C8N2pM5iRMZg?=
 =?us-ascii?Q?zhFT5cJVrbDa8ecHqGUgX1WkfajZRAbROp8pPhSjCTqu5DORd2sp0plH+VSS?=
 =?us-ascii?Q?aXNOzI/jwZ/z34FwpjiLklK00hs4hMOOuoTGR4XjdD3Ul/i8O9565FL5nUiQ?=
 =?us-ascii?Q?sphB5XIE1i2zMCYgCFWFYwH/cfU0o2/mCCfOyCi53UbX1yY2zwVxGzHCwJH7?=
 =?us-ascii?Q?nCq4WpL7o7UAN9QHPiXZGAQboxE3QV4SGJIAPe10VaDMv0qeq57V791kBlzf?=
 =?us-ascii?Q?TlCa+1nJXbYRYuaMDk/24Dndj5sZmMM6BR79v3D90tt2jgTIvzEf4SP0EyZl?=
 =?us-ascii?Q?wFaTZrEY6Qg/mQlBDP0k45oIeQvQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 07:11:57.8202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0ae085-a19c-4e60-de96-08dc79654d90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887
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

hbm filed takes bit 13 and bit 14 in boot status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index c8980d5f6540..7021c4a66fb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -46,7 +46,7 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)		AMDGPU_GET_REG_FIELD(x, 7, 7)
 #define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)			AMDGPU_GET_REG_FIELD(x, 10, 8)
 #define AMDGPU_RAS_GPU_ERR_AID_ID(x)			AMDGPU_GET_REG_FIELD(x, 12, 11)
-#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 13, 13)
+#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 14, 13)
 #define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)		AMDGPU_GET_REG_FIELD(x, 31, 31)
 
 #define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT	1000
-- 
2.17.1


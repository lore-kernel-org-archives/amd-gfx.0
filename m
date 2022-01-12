Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A26BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 21:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1910510E55B;
	Wed, 12 Jan 2022 21:26:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4BD10E55B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 21:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwnpmflUzDzKFLgsiA4F8uPm5xBDQC4BNBtZZbpUn8x7YNLmg5n0VPnwFCgqZhCfyQA6lPd810YCZn+neMS9Bjw4wrvV+PAHNMXaT8DCPMoLyM+/H8k1fm2YueMveBUWdhumE7Tzitwi56EnpkjEdzkw9z0Rd3bGm3XVYzxaEfRHAzawLfVdvSSrqx581MGNshWiIJbcutqrWSyhzUaf++0q+Azr4DWWFeqBtXqjPYxGUdX5tIS6OarQZjKH/iw0XuuMmPyq9/MYvSfQQRVlpqagW15NlnHNYZUi4ieg3uvr9v6EZZZU0SnHl38E+5DdBiv1M+kaThxOuuuMfQO7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdgHRuZaUqOtXAZs5KK0BWSvlN06O2fWnD0HapC3LNA=;
 b=d+gk5f5wu//t4UM7/rscIjKsqTPQfxBjrZSJqeuUSVbrjfIvsPN9tuhe7wEaB/dTV4vZeQ2EMsRuBs0Fl1ofYWS0+lSZnAZjnhPjJNCu6u4GkcFqAONKhxMQ9ZBLCwX3P45QmV+06xg99+dpHyxRnIdAMc7mJnO7gRDawqNfu2Hckg8XZrpA2e7WgloZaAKqMdSH0RWyGxLitiKoGVbmXErF8l0VVVueizyP7EQoNkrrFCakZ+ApeCjIEwh4VAUJOfWLSSUfrypy53WSFkL11f7uA/YA891FhCvNddV8HMBf6giKhwLYk1niJHIp2DkVZgXUdOfKJNHOfrB1CaQ/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdgHRuZaUqOtXAZs5KK0BWSvlN06O2fWnD0HapC3LNA=;
 b=REClGZ/yefiN+V4RMjWXQptgYjGZKLjdkYTYdTI5covrpuYjTEwTa6NzLivNVUUaV27z2kFBIQiI4/Ibag1gqcMrKEsXWRwuyFDL4sabLPutZ12mbPvPRunblsKPx1hHuf3yhJSF3XLIYw0PfWNvNc3mz6L7opUkfyGfe8gsr9E=
Received: from MW4PR03CA0272.namprd03.prod.outlook.com (2603:10b6:303:b5::7)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 21:26:43 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::59) by MW4PR03CA0272.outlook.office365.com
 (2603:10b6:303:b5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11 via Frontend
 Transport; Wed, 12 Jan 2022 21:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 21:26:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 15:26:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/swsmu: make sienna cichlid function static
Date: Wed, 12 Jan 2022 16:26:28 -0500
Message-ID: <20220112212628.3154974-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7e3ac6a-fb0c-4644-88f3-08d9d6123a4e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53503FBF363143425C191755F7529@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCCpX97uF1ur7L90gmWla5Qv3HVCoMVX47LbgynE4c3uY1C62PzWk8ex42i12jJrs1CZ01hnDLPYNvfjHh+30M0z8iF1PlDL9fl06bDB5bwRyhsFy57cIshbD8ZENRIzMonkOd3dMBNKplSP6klPDu2/hMTh9V3CsTdfqYIac1XJYYzONz+pKYyA99FjZiD8k1CBh/TeNdBGUW8NsH6n0PROwVa0ZsxbqkyVfBVvGt6daFlu7hiuMoFfpc6EBFQjZnf4zd/SLT24lh1IBpvvpcXNRes5BiZYYmo/JK+2DXEln+t6KoXM3GQH3yD1/z839CqmbQuVL6KibLA2ZuBujsj3T+YrhN05fE0XBY/RKV3+/h6ZjPL/eOlC3g7WWELmdGbt9GPZZFYj7FQr4gSoqHHQu5xZIgcHcEa+9WSGArgxnvgYkSBNeXKqPoXoHfgVIMlJi66ORBogIowHYvxKm2VRFyW4nasRjL6h6V9c4/gyw72f57TDRUvAZpxM/+002P3GoKznscb6NK1Gz9Nunpp1+OrTE6DJCeRpBXylc33Tw5tegx7t7FYmUQ6KkqRcOzoLY0y91S5y2CBBI+qwfs98Z4NxhOK1abyBr85NvC7DlpY42+YifLGxNQMAaukP50U01H4VRtjqTnQ0F0WxUd3tEdkvBKd/eWqkeduX1P6RS04jQ3au43Q3jaLTx8QnrqAH5fG5NVCLDqPF5W94Lbj07osQSqYqSu3IYR6r+/gvYLKZsOcoJ8XlBQ7n5CIJ8r445K76oONUSwiaPFGhdoJ2R7zfsnunCgIqdciNSZ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(36756003)(83380400001)(54906003)(426003)(336012)(316002)(40460700001)(81166007)(82310400004)(356005)(86362001)(2616005)(2906002)(6916009)(70206006)(8936002)(4744005)(26005)(508600001)(4326008)(186003)(5660300002)(16526019)(7696005)(6666004)(1076003)(8676002)(70586007)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 21:26:42.4054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e3ac6a-fb0c-4644-88f3-08d9d6123a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unused outside of the file.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9766870987db..4e37cd8025ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3810,9 +3810,9 @@ static void sienna_cichlid_stb_init(struct smu_context *smu)
 
 }
 
-int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
-				       void *buf,
-				       uint32_t size)
+static int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
+					      void *buf,
+					      uint32_t size)
 {
 	uint32_t *p = buf;
 	struct amdgpu_device *adev = smu->adev;
-- 
2.34.1


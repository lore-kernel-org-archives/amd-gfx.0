Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B801C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 16:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DAF010E102;
	Fri, 20 Jan 2023 16:29:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5608210E102
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 16:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0bDMMgHf/aARibL4fu3dySdHupdcC9b8kpbcLVkPQUUrdxhRcJWDO369HwNZ5Rd0Eobx5Yeec9EvL7zipTqqq133OI8XifaF4UpkVuqlp7AvKadRYjjmXXegYyNI3pGE/JAbJno7dk3yY5dEbruQGRwfda/ZJKTS1aQZNE3tw+3K0yNTz/+kjZQVItrv1MdHEjEQpOi5CVKLpPH7osI+CufhdrL+cKgi2rm4D0sF0mwN+J3iJnz8tGNY0Xh6WC/o6ETVlFx8v2cky9TyvQ3YCpyht89G5P7/Zcu08EbPTFv+pC4m5WMXJTEMtOlqKdzfKWn/fp/L8EIZiuim7BLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBajkvhi6517h9+IGk4NvVfbKiu1g8cDWhxU5XtQNqw=;
 b=XTW96SWxhiF6eRq5IwBQteqValixl62fSYzNE/kmPKYFfCFxyo5oCQe4ybogpfW/VNzbBeElC9jXyTae+fXeplC3/21deCuNdHbmUMZRtxmedCZaqw71299zNOQqfc+nQrST9ul5GWN9YEhry78B6EVWiI2604lkxjMGVtSxxjIYPrPpovOR/sAwedWIlAq6JLk+XQUiDghbsAGxfYNJ1kFtN4OWknddO5s4i3nYVZXvxFHkpmevQz8P0Do7EIohaqYbfN9dO6ay+6C51Xy5U8MlhEAmKGkHPy0nygoNu9vdPsDkd9UX3GZnYD8LdLFRRs2ds7L+/IAR1BL/pMirDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBajkvhi6517h9+IGk4NvVfbKiu1g8cDWhxU5XtQNqw=;
 b=ioGwy2MyBL/9uySfKHeBq8brB5qncpAP12CxMv/QrwimBAH13tYYUuQEEmlftSqts37n/2gMqArZQQQpv/Vwdgfp3JGkmjKVwe9rUwUcVdovCDXB6XEqA2gi2PY02MOFWFWkbulLObbqwfK+EUpDx6EJq1MLufxqqzAr7eEgC6w=
Received: from BN0PR04CA0146.namprd04.prod.outlook.com (2603:10b6:408:ed::31)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 16:29:43 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::a1) by BN0PR04CA0146.outlook.office365.com
 (2603:10b6:408:ed::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 16:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 20 Jan 2023 16:29:42 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 10:29:40 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: drop unneeded dpm features disablement for
 SMU 13.0.4/11
Date: Sat, 21 Jan 2023 00:28:58 +0800
Message-ID: <20230120162858.1580755-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120162858.1580755-1-tim.huang@amd.com>
References: <20230120162858.1580755-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 4920a653-82ea-400c-5022-08dafb038921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /a/wFT53d4YJ8iS0l2+F6V2E/BJJjmrK8q5Fcnc0d9o1GkKVnMQk9cH8foUkJ0Y5HobjqsHmOilpPTrom/jMAAgMljKcji1Te9dHqrPNoky+s4pRdTZ1rrN07x29wfdi41MDqYQDyTiLzVFK1q3NoOMY19+5eN8krtyj8PxCFuYzWx+xqFA54cl0Goa29L4suOpsz2clelpW6DIgItSVPEVPV6gP2V+ZlJQDpNMiw3HQu48zt/s5QGjTtQmRyRMbRGsaFtN7N1CPL47lfPOscAblVz1YBOCxnGzybTEGkUhmbvufdT1wLr6IkCgbdMyYtrSKnpMlo8rok+C+YMQDouLPY05M8ki/LqtcJNhBfbyi3L+LW8kjAvxKFL5KO+mCcuxVkKIAtc2ctXrT5+4KH85E1GINR+x0dSGJkVV26XHLAG3AEJy/6gk6xEW5Mioq46kpd/hTPyQbf9WXcMQQTIkBquDNEbMreXXsHvaR8y+mB296foX9CRUbaTKcZLVhameOcZow7osPmAyKRNaZiCITWXtdabZiFbQInHiDESYVjAvf3p5xIXIFUaLBE6/7/Fd9FMSvBzECxU0wmXXhsR4tLPW449r/5q0JeHo7XtVLoYMN1x+jNWNSYIaK5upLrL6qlfky48hPtXcEY32MU1kIfsPdIOwhIdpYXwSTcWOTIs6ZqgZLdp2ud1jjMO8NPECIgf1+A5i1z7n4jN5ahye1kub8NBUpYWBHE/IShyA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(4744005)(5660300002)(44832011)(8936002)(4326008)(82310400005)(8676002)(6916009)(70586007)(70206006)(6666004)(16526019)(186003)(2906002)(54906003)(26005)(36756003)(478600001)(2616005)(7696005)(316002)(41300700001)(40460700003)(40480700001)(82740400003)(356005)(36860700001)(86362001)(81166007)(1076003)(336012)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:29:42.9075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4920a653-82ea-400c-5022-08dafb038921
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
Cc: Yifan1.zhang@amd.com, Xiaojian.Du@amd.com, Tim
 Huang <tim.huang@amd.com>, li.ma@amd.com, Alexander.Deucher@amd.com,
 mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW will handle that properly. Driver involvement may cause some
unexpected issues.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ec52830dde24..800eb5ad1dcb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1448,6 +1448,8 @@ static int smu_disable_dpms(struct smu_context *smu)
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 4):
+	case IP_VERSION(13, 0, 11):
 		return 0;
 	default:
 		break;
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC8FC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 10:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C299910E054;
	Thu,  1 Aug 2024 10:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CXquGZNb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A511410E054
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 10:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJ739/3zuTwZ6BJ2sZqqAxEBBnQ8+ho2S/N7XrwzlsunhMWf8EfWjK5bHYoO7Dxx6isf/89J8+TJvsP3VcZdRj8UVtrjKhZ3ZHaXva8KP9KMk07yid/CH1xJJ/UeE2JG1ftf6rqjWtuNYF+VyIdW5ayN0y8dujhRFK4ZGqUzDlpt5kIE7t+HZUZcLIIXZDKzBilAmrpgz9vyMpAcYQqJAGPnujn7UDBmgYPP91vfnjwdVX916NVwYW2rEdsad2f1QXafxazoQCktWvH8VnZXSIjez+QWLZ0MpcX0O+sg814YB+xtXzZ+fPOVTiJE7gx/gtew4MooKGceTuokRiWOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoUUgOCdx7N17XXOa5qHWObW7ZK0qV1uHj+k/Fprqls=;
 b=mKUKrfQ604bbPqEvOgGyp1xJ1YGMrX1C7w9M3N2Tchb91HYlVpIYOA5WPnegZwXiftQMKpPFtKSIDBXUcQXSnen1v0sHzajUPlkqLV0pLef4iHHuUPHCi31AQRpbTDzfHTSNicC7WpA/iLHZWixsqGkZjHWDav9BQtNdTKFcEmX0kdUZkFfdNF7KFGsOHC8RHedkvsnC/VbHEGUiPOwXDr5JgxMFcSCbOEhUkotY4MgAxtTtxjJfa1fDPCSxcH1f+IrknU8PeghceXvUHsNGIMdC6qtCHHN+lNLdzxIxu6XkER822KdhnBp23Qe7DDFOaEPtecHkqLsn5Xu1w55hgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoUUgOCdx7N17XXOa5qHWObW7ZK0qV1uHj+k/Fprqls=;
 b=CXquGZNbtZmnG2t3wNlQEUXPqlGS8Dqsjbs+NJEjE0Qaqo7Zu/2qWS3B77wZaszlMalzrPITTMBfaAyN4XTw9qchteNIcD4ewc7xVDFVB8jVebAGiDLuWL0EMs7Qf83lXLGWYnoUAAoI8h54UtaY0HuipetGCsdjqRR6oEebw44=
Received: from BLAPR03CA0158.namprd03.prod.outlook.com (2603:10b6:208:32f::24)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.21; Thu, 1 Aug 2024 10:00:07 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::c4) by BLAPR03CA0158.outlook.office365.com
 (2603:10b6:208:32f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Thu, 1 Aug 2024 10:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 10:00:06 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 05:00:03 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: update bad state check in GPU recovery
Date: Thu, 1 Aug 2024 17:59:52 +0800
Message-ID: <20240801095953.35625-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801095953.35625-1-tao.zhou1@amd.com>
References: <20240801095953.35625-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: e114ac5d-84b1-4738-319f-08dcb210b8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PXQ4B7J3UUNQiif6atGvuws9KVvwwmBRn1dmhE8MKRvssPfoplR4muQsKZnd?=
 =?us-ascii?Q?KrBERVDylV6NAmKt9zvELnPaDUDdfzEx0mYJgZ/jR14uTeQIa/OJ64XUoUmd?=
 =?us-ascii?Q?HdyfcjGOCLj8VdmSzYPmfaUDX3XFnR76qKU0SnjU91logwiLXw1njgnZ4CJB?=
 =?us-ascii?Q?fQ641TQm/ZA6oVf7dKEXuIf5EUozA1rjy0MHcjUcLuCJjPWMFe5dxFTPxPS0?=
 =?us-ascii?Q?Oi8Ur5PKmMg8LWp/rMJpbz+7XHRHf/weTB35Tg5L74/krOLegxZGUFhG+0ri?=
 =?us-ascii?Q?y9Etjm3YDrB7qjkeGxpehB5nD1NNo8ZgDS8lPWPfUw3zpjxhj0z65/6n1cVe?=
 =?us-ascii?Q?PyalRKuarOlITlkBhIbqKhDgsrHSz8SbBfzJx9xi6YAexLaVzCDo4fgn6XCI?=
 =?us-ascii?Q?ro9FCaJVfXPDlCQHcdXuOdriJX866/0pcRjd8qQdaUxBb7lpJhDzDwDCweOH?=
 =?us-ascii?Q?Yo2i/aVL3ceLDaqh6WYDHuAbhQpnhplvG2omXkPhQzyvFDggGLAn1FkSYsPm?=
 =?us-ascii?Q?bDaf+mJtHV2PXjeqKXU8bY9zqcS2F++yWRsCwmDwzN4fFCv9HYepyqEloM1k?=
 =?us-ascii?Q?qOadqpCimtXHi48YfBPlFnrDeQ45nX8u0ZHXdCn4hWfId3JyCxSYpwT7Wdal?=
 =?us-ascii?Q?tT9wgEzwbCy9LxynqmkgIFHyTBhBpQ/T7oAfGpgT0WVbWUufcUJNVEc23zgW?=
 =?us-ascii?Q?QEkTafOXxCCj90B+BrIV4WywAqBmkuEuDl5f4IjJsfIB8pPh+HYTqBH/+PqU?=
 =?us-ascii?Q?xeqZFbS/+QVCgv71yH1J+7nShdsqr56tZPOYgLfAS8N3Yt8GD9NPpcePtUB6?=
 =?us-ascii?Q?9PBPQEc7lSGg/sRto/ouIY/YO7Itt3ZI33Jk9d5jjlDqXBGGMBg/IlFkzJOk?=
 =?us-ascii?Q?5mwhzN1nC0Ey7qTfDOqQ1NN3x69ofu5J6+PmBc43ZFKnLUU1ZTvW1yS5EyTv?=
 =?us-ascii?Q?YJscuhIHHGH+Y8xhiz9Rx77Wg29cxZnguLoGaq8rX0u7pfFXmvN2v/t9F2Pt?=
 =?us-ascii?Q?BaND08/Sfxn9bqGuKo4HXiIXpmB9mG3/KDkTT1b8b/BGrTiRp85ql/MnMfmX?=
 =?us-ascii?Q?t5r6Kn+tUtC0e0iryAVmwrK/GI2z1N0aqlbYQc1KMl59BabAlVWARXwmxbBt?=
 =?us-ascii?Q?trLmvWX00UqEnq/XWAU89fD9YzV1CnB0hkrmxhcZB6Q2VmbEvsczvKEYouBH?=
 =?us-ascii?Q?sYo39a3SQWqE6uR7y376En+IQyC2XLvKnecoz45n7Qg2uDX5NjSJhixOJZ59?=
 =?us-ascii?Q?8n22QOBm+mey2vpPHS0+xf39ISsoxcAUpyp3m7+g6+W4hOY0KQfDGneE8njA?=
 =?us-ascii?Q?h0GvZILowPeop4GnG/sH3C+r9cY7ofzNA5pzDlBmFRrvNRCWrxB3umsajXQ4?=
 =?us-ascii?Q?yIQ44SiQNaQK58MlSGlb+Jfm6DGIuyoG7kfMXPY24V21EqmrPDJfjRZwymo2?=
 =?us-ascii?Q?Qb82AyKxqpuFuDECg8dUHMCOi/0UMo0X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:00:06.9711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e114ac5d-84b1-4738-319f-08dcb210b8dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
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

Return RMA status without message print.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 96e525ab9a84..5d49f70704c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5538,7 +5538,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				 * bad_page_threshold value to fix this once
 				 * probing driver again.
 				 */
-				if (!amdgpu_ras_eeprom_check_err_threshold(tmp_adev)) {
+				if (!amdgpu_ras_is_rma(tmp_adev)) {
 					/* must succeed. */
 					amdgpu_ras_resume(tmp_adev);
 				} else {
-- 
2.34.1


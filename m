Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C004D6DDD7
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 06:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060DD10E398;
	Fri, 15 Nov 2024 06:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="thEncGXM";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B14D10E399
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 06:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4zxbu0P6jOpY5ivTw5sBBItrQ47ZhbVPwmkt9VIvjuGBEX2fLdAQG4dDrm+NCTwQH+IfErUbK96MXcgLy7MkSiFIpzNylazV9WBQZ6+AhNJuLQ5hNBCxb9WGG3Py0CN0B4OlQRhaIWbaXIKDXmnexunpPHVjG8c2f9Eaar6+egHmuEjWPi9wCgWUbQEGXisBgAUjEWxouYveaqVULEtXxi/B2I9dt5x2iSSRs5vjdWlNEDaUcKA0EDEHM9tcePDHAYLJt6rFT/oJprTtnUpCj+qrSoxfbQJFBHxSYTLnG32CGsW+CSYSPhVQtrVky1LzJWu+cCZZv1qMCLyY6Wdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN3ClwioE125X/Q/2lTqyQyO+fQKfx6x9BqN7q3vb0c=;
 b=tYDBVHkBskrRNrEAsvUDDv/833HVCWRDlOXtTv5MCFWzXyLeBl8yZ2yKTPwEmWRNXlM5NOZjVOZ4JOJJatSbjWheC6AOhfTuqPjSoCl3st7dz4BOfM+5Jo2OIBd46z96P7rDPXeufTUbJeKx3pnhLGWgr0T6tuAZ8WkU961aKNI+87YVA9V9mMjrBmvUFfAngXqhEFM5B0RV6I0sAVqylUTTB4ylAtp6cF37qGvmBgRu3UvN4Pc1MPwIn69dTUebNdNGc0Te/moZpbFHxQWdXD8XLsdujYolU5+mjWCPC6kou0Wr9UWHBFrh7mzVJng9D165RMnTAosLq2YDQ48jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN3ClwioE125X/Q/2lTqyQyO+fQKfx6x9BqN7q3vb0c=;
 b=thEncGXMP2uHr4MQSTtvGgYuWk36J9rCIb3BbiOVw557MFdyXmkyF8nQr1BQbbpK/PoIbo6g2RtP1ptof1dmDbsArEQCRWn8yyVbNnyI0YXH3L8rtArBUJCJMbZ9qOwJywa6oS2UvSpUQ3dUj9iMHTYipV1WC5cwACuiq1WqHN8=
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 06:09:41 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::e2) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 06:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:09:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:09:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/5] drm/amd/display: Fix null pointer derference in
 amdgpu_dm_fini()
Date: Fri, 15 Nov 2024 00:09:21 -0600
Message-ID: <20241115060924.1805-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115060924.1805-1-mario.limonciello@amd.com>
References: <20241115060924.1805-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c295a5-268e-4c5b-30ba-08dd053c17fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AXNkayj7J7ywMStBfm0s/PTz5tsJiEJDVYHKW98ER0nqWEIdjX7DbHPf4vS9?=
 =?us-ascii?Q?JWX6EsMf3GrsjvDGDsxsyM59HDGL8xQgilqiJ26l2r0FXFttUBQAUZSZFsPo?=
 =?us-ascii?Q?6iaSFnsbEvlf/vNvRSMDoTcCYjePWdLHz7+whX4vjJmvPtDGL9z9BNN8bN+l?=
 =?us-ascii?Q?r9vqRPBeruExcK875hlKPGDu6lYv+G0Cf5sohD+0D3O7cjcxDxA8QTV8d+2M?=
 =?us-ascii?Q?NATLw2VS1y+NsD3+BzErkWTmu/B7KmnuMzKo3og7vH/o9tTSFrXnLR9rIPez?=
 =?us-ascii?Q?TQEar1ptVdebhK+jTS/VZfalWUe2GDOrROeEYTtqzdgo9XNLA3Aw8QhVIzKz?=
 =?us-ascii?Q?EMrUPfao93SzAR0PcSl9Os2GOL/x3BK4lgZngwEwE6aeXup0plJDooujPiFb?=
 =?us-ascii?Q?esVcBVOXsVoNZD+fhZ83h9Euk/Cjkno/9rPfcTH0LHqMvUdE24MIQjN49ZgW?=
 =?us-ascii?Q?cwtWb+ycSULdrHWMwBG2h9oU76h5oR03/XsML0HndprJCPKjsSCdzojpgfVE?=
 =?us-ascii?Q?aU1P7nNBEDUoo8XBKzPCNG/7sg4UJCYHH9N0Pbrp3UMngWPAT3r1LsWTQzxp?=
 =?us-ascii?Q?0skAPZNkfWfiq71O/tSq8Wjgtpx7eP8o4R/mUg+Xw+keR+nrKiRgcpV/3iat?=
 =?us-ascii?Q?hO+AeiWaDdgt/xIkO8jB0sMGm2pag5AgctIlH1+GJ9aQQxwoZ5jrJi+AZGm+?=
 =?us-ascii?Q?aacOyV4S1yyqZYz6k+7rS6tJlYCkUDdYAg0wwYl/CHuzLgDj+bhWczzH4mIl?=
 =?us-ascii?Q?21zLgtwEKDL73UKSI/9yGk+TS+5/l76Kl7LV4V/ecs+Mwk/WXe2LmBLf7TI3?=
 =?us-ascii?Q?CdmjHamoT5yo8iw5diOdJx1p8eCGDOzXj/nuBAWxJSfIHZJKyShkgXFPJNVM?=
 =?us-ascii?Q?gPcqvRARhDxf47UycLH2IcE3cK3SKT1uk1y8yUE6n1+k+geRBF55AzvPsFla?=
 =?us-ascii?Q?5jrLAUDJ7udnffTyfaDqqHuw/666IiDC7VwHFxdGcpsUfRwgIC4aVXwgqedG?=
 =?us-ascii?Q?UkshyUDgbfeNkW0OP2Y/ZywVQQMZWdJcxL9chndGNLiJg6bwBaCVEh61LwOn?=
 =?us-ascii?Q?2FfmBXHbbZQWPYMm8eFLKVAT4EUWmR9ScXs8ZdSqpGrESdoxyc7bwn+mYCUT?=
 =?us-ascii?Q?74zWCW328MuznY+noOlrMp/pM+MCjFtWEFeIKXbYHOWXFqwB/8t2hZfsqDop?=
 =?us-ascii?Q?fObb6xlB51Pz0J28Q5v51uRJkBOvS4SOImgGgjqW67qx7nlv63mYIVKsPRAH?=
 =?us-ascii?Q?5F3NdEXSUg88aoa9fjpB7YiI7wC1XksXak4ulN5vRbYpY6NyHSUfHXt/PibE?=
 =?us-ascii?Q?FgUO7bt6nXINQ6MIeDUrtGmJX7HKYUL9Z2QQbrZXbaqiyQ0XKSI5O4xtD8aN?=
 =?us-ascii?Q?wSQ4LpCS68oKpH/Sz/imiEdVowNfrgt0CNPbRNUz8GA3/78EUQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:09:41.2220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c295a5-268e-4c5b-30ba-08dd053c17fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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

Some error cleaning paths call amdgpu_dm_fini() but may not have
initialized `adev->dm.delayed_hpd_wq`. Catch this and avoid
destroying the workqueue.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 94f1651422da1..5fd3d36964369 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2219,8 +2219,10 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		if (dc_enable_dmub_notifications(adev->dm.dc)) {
 			kfree(adev->dm.dmub_notify);
 			adev->dm.dmub_notify = NULL;
-			destroy_workqueue(adev->dm.delayed_hpd_wq);
-			adev->dm.delayed_hpd_wq = NULL;
+			if (adev->dm.delayed_hpd_wq) {
+				destroy_workqueue(adev->dm.delayed_hpd_wq);
+				adev->dm.delayed_hpd_wq = NULL;
+			}
 		}
 	}
 
-- 
2.43.0


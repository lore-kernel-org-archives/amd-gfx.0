Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13968C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 05:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B35410E17B;
	Thu, 25 Apr 2024 05:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xsWZzfQm";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51B510E17B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 05:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMXYPXlCZ4w2hPiL7BoDhcAVxKzXUYI7pCp7KThOX7DGyTR3mTTGHzjGmJ0nfd0v0U7+j9d8WY/yLWBkifUROTDC/icAyjMsfr73f4v6pcWNIULb+H8Pfc+RbuCPmSWVGJeEWdNJRuplRosC9WVJ63M+DJa7QtFkoZu0pvar1ARNhLjP6nffP6Cyr3uY6HCTqyKoKXQ9s8RApmN5IcTAjsNsymUH46A9D3qKe392V8YbsqknySri38fbPeTAJsch1jGQ/nAhTjgXdgx3Q4Gcu/Q98qtcV+a6CUCeHkURt5Itul72fWB4ZPSj56oYMGT/u4thMP6s4QWMCfJsJVh2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDR7ex6J/cbpef/6Vd7b6R3CqSRy+h2xMCf0UM5zTh4=;
 b=ceg5btilVNWRhFFnuqbUKzwZ2Y7C8ZRLAYR1cap4KewPQDZcGToAOrwLPRTPzRjVrUTCKCzmQSpngs3J719rm5nUzZXnu/PlUmI51NPwpOeNcSAhPI7aLG/LoToSSUUpWk5qmRePVVV+fwGM2NZWUgPQdX4DcABB0DAIIQRAIWvNWTqOOgZfTijs7zIU7n2ua83rslRusewwDbOepkyY8pFbeR2AFT7DNPVVq2CgaUO03SxoT9GXg3iPWPq1qt9jNVMIOmpOb0GQZJCEQL56WdfOvz9ZKbKlW4TTyAIdizS6HLH8Lvnrc0qN3ymDbljy4v6u7fhC5M1BBlmNQXtiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDR7ex6J/cbpef/6Vd7b6R3CqSRy+h2xMCf0UM5zTh4=;
 b=xsWZzfQmcmb7n3A7T8Mbg+a4lEsBalyJiOcorHstGHjpNRfrcm0nRQSjOqEYjh38XWWYRQHrQQxqJC9/6glWl7xk4zEY8fhXWgqu6MQiDAQdi4/QLDYY1l/Ad80IFmptd88L0l7vmZJDcRODAxmvnVYy5/bhPCIvEQEsM6UgcnY=
Received: from CH0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:610:e4::8)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 05:28:03 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::10) by CH0PR03CA0183.outlook.office365.com
 (2603:10b6:610:e4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Thu, 25 Apr 2024 05:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 05:28:03 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 00:27:59 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix overflowed array index read warning
Date: Thu, 25 Apr 2024 13:27:36 +0800
Message-ID: <20240425052736.1312063-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a288a8c-c6b4-4487-df04-08dc64e87a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZOu04oNskB69i8vIu14poO/v+SkBRN7/8z+CzTEDudXamzcR+vFX7YBRvdSm?=
 =?us-ascii?Q?QqJzeVPgijsmfYSRcbeOMtAQphiPPUnjRsYC1wjiRyd/TLd+Z/f8mvQCaA1Z?=
 =?us-ascii?Q?jsBpPXLmSpPKo97MICwK6MwvtsrufwbJBj2VGAws6WwdxaySBlUT8q+b40s8?=
 =?us-ascii?Q?uMyrig9npPL4+aZfjM5sp4QCahUiBON+ITpX+fyoHrJPxxqJI0iDzIvMr49T?=
 =?us-ascii?Q?7GLyXlbmHdK+9x74j66osAuV8r1gCw9gJb+x4gVItmI5XXIAtajWB5ZqxwVl?=
 =?us-ascii?Q?whiiNz79UpVTDKyYDVG5qQUXjiUEXVe7YwZEWc93Luutek5+y7Uge43PNY/F?=
 =?us-ascii?Q?1smKw7HaUtXGSyoW3Bc2kFAKHho2kmChfdaeDFj3lCOEDfbtC6IIB5UquSIK?=
 =?us-ascii?Q?POaPz8pZbyCG2tdgWxWgcUmV+JkibqCoX07ZCYSL0I9PWngpCFcJSwjXD3vR?=
 =?us-ascii?Q?ltESUSycqkuOWVpdsEW4p9YJSqlufOZVfSAfG2ZOymEBdfIZ91TW8FDwoPbN?=
 =?us-ascii?Q?yGvzv1TYAuZfYqqUKn3gavUCC6zrKOWNZkuRqe/qH9ojXBpMzqzO2X2/+Q2/?=
 =?us-ascii?Q?qR05qIFMdKRl/jqb9PlgSrBjSmCS5OQ3Yo4Vna3DJUnXH9VSC6OVPMVqaivC?=
 =?us-ascii?Q?cBhc3QIG+mcLK2Cg5M6gyRVeQJkT/tyyMwyj1v962jxQEtV5wv7KhO5wVaz4?=
 =?us-ascii?Q?/3iLXqDve4/g3KMkgn5FkLFUl15Z2J4qR1lBr+3DHSXbhsagKh4Lx430P6kF?=
 =?us-ascii?Q?+l87ut+L1a47nz2AS1pe3dMeGmbR219faAzX8/VN9kfDpIWLMizDSG94Zojg?=
 =?us-ascii?Q?zTs9/BeTqVt35yupj8D0AL7i3NRLzg4wjhKDaHLl049zXDwwdiy5Or15KgY7?=
 =?us-ascii?Q?vV7tdS3JNyCqhZ3jwuIdpkyT2Ro+3OF6pKMxRX/PM8gbbW4EQs2cYSjrXFM9?=
 =?us-ascii?Q?Oywi0eVT45Hi8vi6oI4qIoZrMlRopgVVuKtDryikY4OGaZJU258+4TsOXENn?=
 =?us-ascii?Q?GABU13iYUZhvMh94BlwT+z6giwTjqsnp99GLRm9n1jdpw1/1HKbtxdeX3g/y?=
 =?us-ascii?Q?DQcPegiAO/7WTW7vgz873xp4ox5y0xO5tv7YMyRZaokHWKQElkI1WNsVb5Fc?=
 =?us-ascii?Q?B235R9cVETXERgUxf1GIabxOo1wo0IVcHu1yws2rUshSgwwez29CnAkdHyJD?=
 =?us-ascii?Q?3iCKbzUf8uWaiI4xGkfnddtKUP8xDMowBTRf+kdreeWYJapv4M63iaDReJHu?=
 =?us-ascii?Q?qJBGgWw3oDWyirqSRt8L58D706c5NwyOMHD3jdguidAW/IUsVhsJMA1TB7FY?=
 =?us-ascii?Q?U18BNtz7N4s4rTtR3xr2CkYjh13+GimGTR2Z25WLRECo+Kl7Hhcr/u4eTNBW?=
 =?us-ascii?Q?XpjAz1p3qXaTTomPnJ0qpnjn1ROz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 05:28:03.0844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a288a8c-c6b4-4487-df04-08dc64e87a93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
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

From: Tim Huang <Tim.Huang@amd.com>

Clear warning that cast operation might have overflowed.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 06f0a6534a94..6dfcd62e83ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -473,7 +473,7 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	int r, i;
+	int r;
 	uint32_t value, result, early[3];
 
 	if (*pos & 3 || size & 3)
@@ -485,7 +485,7 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 		early[0] = amdgpu_ring_get_rptr(ring) & ring->buf_mask;
 		early[1] = amdgpu_ring_get_wptr(ring) & ring->buf_mask;
 		early[2] = ring->wptr & ring->buf_mask;
-		for (i = *pos / 4; i < 3 && size; i++) {
+		for (loff_t i = *pos / 4; i < 3 && size; i++) {
 			r = put_user(early[i], (uint32_t *)buf);
 			if (r)
 				return r;
-- 
2.39.2


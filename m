Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D276E7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 09:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0022710ED14;
	Thu, 12 Dec 2024 09:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MM1FR8VS";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C250710ED14
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 09:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q28TgGgzFC0JA+f1KXPNu2rybFEZTeuQG7SxHZQZIUacfwKu7a93jZkIMS3DsQNjoVg6o7+bYBsyVDeyWGyBPaXbY/90cogmzX93KvbVtso4M36uj4pFLXQvND+mmIItyLLUFehRt/2OQeO4bd1a1shZ2yHNPiRgZ2AfM2zjbpEW1+ORRxXUPVXxX+wnsF17g1yrHB281mAAajjhPSFPt4UWLGcd254TeBhnowcZclePpPSsa/SNBnOXYppa4YA4BC6leFYtckur7zfynYlAw3fqcT/5ErmETvWvhoBfwBcQnUbH+1bl/hOOZCPpzQPg5YXG6WxGbzvMKWDUWgp9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJzV++o8GGIqDIEaePXRQ4on21DBNdlScHftdYy3SXw=;
 b=soR7zMOgD9FHM5hKkTWBtvPeUniLrb1T33PvZcOKzpOZ+49IDFNP4wvGBhYYb2lWI76N2n25jD2LpynRTuw41avFcfEfUyflq6q7MbmJtxQGJb23hREMU1sVzMBIDRkx5F+nyf5Yxz4s2hSlgRRkEbYDeoCj1PLzGY/NTimNEhAbq6SiKBd55Ecn6u6sA/Aiv25VNuTd21lkgfm3UyK5bNJt0rgPrnRBKzBS2gmiolwqw9lCGooW8cAjjG0rKI7+bUbe31BF1oK5osRgRbn7Z40LkR7Xy2CVL3B12mFSdbFKUt5QJOsadsuHJMvsigjcgXyU5+14R599n8Pk1ICF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJzV++o8GGIqDIEaePXRQ4on21DBNdlScHftdYy3SXw=;
 b=MM1FR8VS2K16k+MW7jlbc9ISUjsCWRZq/FieU4fkFgHOAGifnJYZsGwPLYf+aUu02RX/mD5iHC9MfuA2oAMOulaOH/AxbzhfJBTsLKdJWxhqgQH/T1EHmbuUJ1r/wxUwXqg7LRSDa4r4Buf0rdX/xz3DskOaeklhj6wUN1gJTgc=
Received: from BN9PR03CA0791.namprd03.prod.outlook.com (2603:10b6:408:13f::16)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 12 Dec
 2024 09:38:15 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::ab) by BN9PR03CA0791.outlook.office365.com
 (2603:10b6:408:13f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Thu,
 12 Dec 2024 09:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 09:38:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Dec 2024 03:38:10 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Leo Li <sunpeng.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>, Alex Hung
 <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Fix NULL pointer dereference in
 dmub_tracebuffer_show
Date: Thu, 12 Dec 2024 15:07:58 +0530
Message-ID: <20241212093758.916895-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: b07bb6b0-5f62-4108-1502-08dd1a90b3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jSNfrBgrAmIzRqsYWY2Lq5pTS0C5+wEjgfU3lRyCDsOLHRO+JSQWXXSxklgn?=
 =?us-ascii?Q?zao+TQHYOs4wkjsOjV1rybQ9Q6CGTjmGiNXb594iWGbuFi6v+6VUh7PMNacZ?=
 =?us-ascii?Q?riCCLry7k7DTGZkng2zGW9x4PKbJ9W4Y9gUbYk6vcsjKLzzFAMl/31rkQRv6?=
 =?us-ascii?Q?3L2Pgji+pPEEnLE66nSBNHR5JVRhECcZuKNUIFgoveuTvrZHqR4OnHx2oZ4n?=
 =?us-ascii?Q?b2vN/bBdnTr/007CxY6LT48OHBsH7t3D2p/nP9xysbQ0r5jhC4E8DSpfXmjU?=
 =?us-ascii?Q?Z3fgmMPaJnOezlyGwY+JMYHOFMaGhpH3PfPaG9vh3qxyrRGdW8gU9nEUZ2fo?=
 =?us-ascii?Q?QzHnmn/7kZ5a5q6Urx3OVnL48p1dkYjHjvWYOXRyET9Y7W/6GGYikw9nYYmP?=
 =?us-ascii?Q?iHCttfMudvKo92qjBhsZLN1xedcBe0+McTewjHHup5z79fi7Kd6V5tGTTqjG?=
 =?us-ascii?Q?hoHSzVUvAGEe7KLYvlGnFtbLOwdM5cznk+WgwfSXZcjbYT7YE1qBYlrsHkQW?=
 =?us-ascii?Q?7p0ctE1gL1z2zQBTwm/jaSyCr84JFZTWASStE9vOcFdHScPoJ1Ad/GAsgdAK?=
 =?us-ascii?Q?7GdieMzeZZhK6ROMtP+i48V0hZdYT1QakWDZAooIuxlrnXdUS2k9G2E+gQ94?=
 =?us-ascii?Q?A/zy3yo6psYry27r4rdpSwA4rwIOJDCl9P695ziLLldN1rBfx7I1ZJrLLDw2?=
 =?us-ascii?Q?i8zwtQcilr7C9qU85Rq1MPfSSPNH5IhV4UqCurNfSDREziWuha/BleKqfx0l?=
 =?us-ascii?Q?cAr5lNBsgX+3uUMUZXzVbDbHZ7RFLJ/P32+tNDtcWCHIrDKr0w0qf/o50j4g?=
 =?us-ascii?Q?M/jCvaTLNELcMqA9VNgO8gNQQlz4femTv2T42AjqCItgSkkos8nFPcm8ZcTp?=
 =?us-ascii?Q?tOznMxhbbIHVsd8bc49tj4d6XpGcNlpdm6XPsrTEZNw7ZQl6EL2dP6n8s1lw?=
 =?us-ascii?Q?53f5cSXVB16DKeyhdwcHuX2aQOdm1aJIYiZNof3fx++e7GIxfKsaOxI1d9N9?=
 =?us-ascii?Q?jc6w8KqLKeb8nXinfLksI07+g7tYqVS6YCosSYL8hE5bKNBif6yBfGPQ3KrJ?=
 =?us-ascii?Q?1rkj+GeRI+7dldEkbW/1neBaByycLmljblc3yrE/WROihVbTF6ecVyxWma1k?=
 =?us-ascii?Q?ARM0Z+HuKYETKyQLRAEBxxA8Tz0eOGr/6oi0FKps5EBs0V7C4Ha0Rc1eeUsc?=
 =?us-ascii?Q?z75TOPNcmXq+1g1vPyhp8Piun2L24sLxlGMH9uuYerZTSz795LNqJxtBgVjN?=
 =?us-ascii?Q?hiLXmOD7+qZSeKxNqlTTP2AllZbOtuqjZdRIn53tJ1YLDeJIKyjuM22hB4as?=
 =?us-ascii?Q?iXK2u6QPTZCwISKUvJP7o9iWSlNp98qUBayoUrnfntQI4ysnkP2gmEzpEgh3?=
 =?us-ascii?Q?vScqkM2h+p5dIz1oSphtjZOtB+6+ux08+7QaNfPmDPJi3neqjV00EXAZMdrD?=
 =?us-ascii?Q?GA9mibarCRcTGMKhGFzgq2G5wOArJxTM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:38:14.7144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b07bb6b0-5f62-4108-1502-08dd1a90b3a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190
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

It corrects the issue by checking if 'adev->dm.dmub_srv' is NULL before
accessing its 'meta_info' member. This ensures that we do not
dereference a NULL pointer.

Fixes the below:
	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:917 dmub_tracebuffer_show()
	warn: address of 'adev->dm.dmub_srv->meta_info' is non-NULL

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c
    901 static int dmub_tracebuffer_show(struct seq_file *m, void *data)
    902 {
    903         struct amdgpu_device *adev = m->private;
    904         struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
    905         struct dmub_fw_meta_info *fw_meta_info = &adev->dm.dmub_srv->meta_info;
                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Even if adev->dm.dmub_srv is NULL, the address of ->meta_info can't be NULL

    906         struct dmub_debugfs_trace_entry *entries;
    907         uint8_t *tbuf_base;
    908         uint32_t tbuf_size, max_entries, num_entries, first_entry, i;
    909
    910         if (!fb_info)
    911                 return 0;
    912
    913         tbuf_base = (uint8_t *)fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].cpu_addr;
    914         if (!tbuf_base)
    915                 return 0;
    916
--> 917         tbuf_size = fw_meta_info ? fw_meta_info->trace_buffer_size :
                            ^^^^^^^^^^^^ Always non-NULL

    918                                    DMUB_TRACE_BUFFER_SIZE;
    919         max_entries = (tbuf_size - sizeof(struct dmub_debugfs_trace_header)) /
    920                       sizeof(struct dmub_debugfs_trace_entry);
    921
    922         num_entries =

Fixes: c506f6e03b18 ("drm/amd/display: Make DMCUB tracebuffer debugfs chronological")
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 11a7ac54f91c..0092d4a1e59d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -902,7 +902,7 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data)
 {
 	struct amdgpu_device *adev = m->private;
 	struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
-	struct dmub_fw_meta_info *fw_meta_info = &adev->dm.dmub_srv->meta_info;
+	struct dmub_fw_meta_info *fw_meta_info;
 	struct dmub_debugfs_trace_entry *entries;
 	uint8_t *tbuf_base;
 	uint32_t tbuf_size, max_entries, num_entries, first_entry, i;
@@ -914,6 +914,9 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data)
 	if (!tbuf_base)
 		return 0;
 
+	if (adev->dm.dmub_srv)
+		fw_meta_info = &adev->dm.dmub_srv->meta_info;
+
 	tbuf_size = fw_meta_info ? fw_meta_info->trace_buffer_size :
 				   DMUB_TRACE_BUFFER_SIZE;
 	max_entries = (tbuf_size - sizeof(struct dmub_debugfs_trace_header)) /
-- 
2.34.1


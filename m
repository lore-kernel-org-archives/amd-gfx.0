Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F397D35664
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F6A810E5F2;
	Wed, 28 Jan 2026 01:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HlgLPZSg";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012051.outbound.protection.outlook.com
 [40.93.195.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1642610E5E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvZNpVX8r6szKlkxESanSqUHSmXATKlHuI6Q5LWm5oDeLNtSQZeZaz3R5lMf08Dn4vVbWADseTOQZy3PMsDFCMzpK9cJxv21rM51noo2ax8vzJQjTw6kpj5Y3Zw4Xz03lLjMk6ZT+zTZOMrpn2FkkJUmVPUw6GvjhZIAigjUPb5d3MAXG0XwHUsfnF9jhXWbp1oweLMHoVRD4YFj1CQ+SLys6Czouou+UQhTi792m881iClWH9A7+44aSl37ugFrOl3tUXDvZXScCzb08r/fPpNVdSdy19xtTVhW08LaEzrLJwyG2UcbAPgIEUmciypFsGOJ4ZuyHW58/Wr72cMuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7a4M2X9qDhA62MzINeHAL8Fc3mJBCy8JipbpBatzvE=;
 b=nJ7/NE9wXGiOw9xqdb8Exm1GUE5RA9w2UuBe2cKBijMI5R1EcyPwtqNMRZ10G3MzCTPG/oXmjPDUgfvxw8I5Ra7KOaDcpAAVQ+ZiF9uRtKOdVY1aVmlZGpcjyUIlIev7DAZk0eybu4nLiV0o4pQ64W6yE82Zh7cX1WK/OLpZOi4m3EFSih2fwgIATMGsY8pthAYh+7uRZ+ZUV8tezYZXg2EH8khALvgmcugxbz9dgEwCZy3f0//ZNXseBjTJrpVezDmsPn/EJOoL6hok6E+hcCG3WIoNmca6Y4h+9zw7rBPUJ8bTx/Z4UE8hLRjYrzZptdyci9uHdEl0OlC7iIRf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7a4M2X9qDhA62MzINeHAL8Fc3mJBCy8JipbpBatzvE=;
 b=HlgLPZSgpmm0mUjsPELvSr55/MtL1/im+RtzjmXRmq8FQsnqQPp6vRQskful+wO2Fk5YrKZu6VK0SKioI4nfbJIMZ3g3aYvqlpw8BWMGd4OoBaJnjjk2FCAptEEvoaRFxQMwEh1sES1BOagtyscpcIqQd1cKuhJEFh/O1sQ1AK8=
Received: from MN2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:c0::17)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 01:59:29 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::f6) by MN2PR05CA0004.outlook.office365.com
 (2603:10b6:208:c0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 01:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:28 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Jan
 2026 19:59:28 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:25 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 05/21] drm/amd/display: Make DSC FGCG a DSC block level
 function
Date: Wed, 28 Jan 2026 09:51:30 +0800
Message-ID: <20260128015538.568712-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: a7737c4c-946a-4102-6a75-08de5e10df3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q1wTWlNo7wjCTmBqHF0cwMyyVv/P3ZBi8ifc5ZAt1O+l6cXd1EUCpW/7pLlv?=
 =?us-ascii?Q?gSzUvgJ0QMQnDwfn+vpGSGQqbG6oYPCoYM3Ikqn4+TbABLAoMB9OMcAPHWZi?=
 =?us-ascii?Q?lY1Gt/+Uz3AIVWHZK2vky6+wodQhECBBBOv9l/9pkjWoTQdq0/HpnuPUXN7R?=
 =?us-ascii?Q?Mzu8ymMlutaNdXz0VCx6JdBUvtCUjC3z5VE/LnUuF0HRhLwzMIjcei6SGBZ4?=
 =?us-ascii?Q?zyewxLS0KAkELsjQqnyfWhWKWSGebapjvMNdFHhobypwm3IVhJmqYOaz3xRt?=
 =?us-ascii?Q?VHRwToVPQNRti8WRdqfs7+4RmcvUK3ooFozltXQevyCydGDcIZ3CYZ+VCmTX?=
 =?us-ascii?Q?yzpsQaZbIoSVqVs4y5eiFRBRXUAHHo81us2nOzqZojIM69wlx8TLyBeBghaV?=
 =?us-ascii?Q?5lYPl7itXzqaGO9yTUwI1F0D3jNNYrRp/etYkcsCdduJyfxBzLY8L9OI6RdU?=
 =?us-ascii?Q?C1LMBUKYNoownot6xTKpD1pQiyPiqmOlfiPAonIsuIsf7KtuHpuVND2XscCH?=
 =?us-ascii?Q?TrhmeAOY9Hf8IXN0GkWIlzPmyyrGUww8ILtVTqlxgiQd3sLtaZjTYXG+3vuT?=
 =?us-ascii?Q?3iSAOsrVjIkltsASkYfrg3sP93hsUKw2WmmpbAy9Yi7MrWCRf64JTbg91A9p?=
 =?us-ascii?Q?zM81p0G6IljngRYlByMELTIk8B/+JbtpB82J4qSBqAJJryvYB/IkbFm5D6IQ?=
 =?us-ascii?Q?rQPhXH+pQZ/nlHvjLAAlzZlXyFTU2Q5rQwFmW1ZwP0IT8X8utlYCbgYnK6N6?=
 =?us-ascii?Q?8IijV8vs/ug1mXtYnrXx7kJeiZckIVVhmp1TKU8mFglHebLi1JNFcH8ooNsF?=
 =?us-ascii?Q?kqAjvbz/MDXC+fndLxNqlXTIUIlgJtOMiuJ8tKPcphKb6Rlf+P0qEwk7lpdW?=
 =?us-ascii?Q?W5PmY4/Lv6fVCteE8Nxw9PWI8CphWHOOs31+qGCL0gpzgt5CYv8ym3v8K0mn?=
 =?us-ascii?Q?BCwy+231OARJjmLZeC/vXhP2O9wJMa9iefvsAM1DHfqhA6Ny8LamHuLxTzS2?=
 =?us-ascii?Q?mekRYYFUhnmf0FpXHshDPn1hMfisGsNRB7MBfHT33NYW8WFe1BG6mzZ/nwgE?=
 =?us-ascii?Q?4VahJ31UljzDr/vjRweeKjfyscDwjw/0eFjpgD/RWSg46n5VemHG0hwJzg4Q?=
 =?us-ascii?Q?+IXdetz6dgV1ZOjppk8/A9SD3sYujXpFTNil3V8BrMr8m1rl89cS2TtBw7Mk?=
 =?us-ascii?Q?TsRsYgxr6h2WOq6hEfjhJdd7eEIYk6DG9SE1k0rtMtSi91Cv+N0rJA9vm7Hz?=
 =?us-ascii?Q?yTgGuhYEd18WODjgHIdNqpPkJOBiobbYq0GvghrR/G94drwVxSuppbnkgZzq?=
 =?us-ascii?Q?Uy9WvsVor+9MSu3qIoQYa5kJdiQb2gxmJBpo/Xeg7g0sgTlzeheXrsDEQW0f?=
 =?us-ascii?Q?3KjYJ8FrmMH7tN6zH+tA60xoEFVvmRylDOWfwlYm6lHdG902pXtFuA5K6D1j?=
 =?us-ascii?Q?SOhg7SZbyfxESrm17YR9fxk9oYgYEFm0ILk0BUZOVX9/ZGa7N5vzz2mmVmhX?=
 =?us-ascii?Q?BnM1W3RsXKSK93XyntzCLQKN+lAELRkQtx+MKHPlbOn94iLRXeRs86KcUjE6?=
 =?us-ascii?Q?oXRsQuZjUVfsyT+X9+r28msh2zto+fqdF74zKQM3VCMax+T7JXi5P2F43G2Z?=
 =?us-ascii?Q?P5mkCVUL+I7Xv9uAYLI6jdwpUIM5Swju+xgi4kPejNx9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:29.0518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7737c4c-946a-4102-6a75-08de5e10df3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
FGCG shouldn't be called at the DC resource level as part of DSC
creation because dc_create is intended for SW init, not HW init, and
register access is not guaranteed to work at this phase.

[How]
Add a set_fgcg function at the DSC interface level.

Existing ASIC can continue using the function in DC resource to retain
current compatibility but further development should favor calling
the function pointer during init_hw (if it exists).

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
index 81c83d5fe042..ad7ef83694ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
@@ -115,6 +115,7 @@ struct dsc_funcs {
 	void (*dsc_disconnect)(struct display_stream_compressor *dsc);
 	void (*dsc_wait_disconnect_pending_clear)(struct display_stream_compressor *dsc);
 	void (*dsc_get_single_enc_caps)(struct dsc_enc_caps *dsc_enc_caps, unsigned int max_dscclk_khz);
+	void (*set_fgcg)(struct display_stream_compressor *dsc, bool enable);
 };
 
 #endif
-- 
2.43.0


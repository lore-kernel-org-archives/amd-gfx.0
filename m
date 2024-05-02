Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555D6C04FFE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 21:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DD510EB48;
	Thu,  2 May 2024 21:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D9GohBo5";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD7010E397
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 21:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzGogit3XGl1m+IuU0OVVoD77DkFCJlKb391mqEA6Xh4gflrYzwuqCH9V3b6xHSHEzylFQg1NcC71X2SfUvPye7HZ9oBzXxejWXNbSQJhM72HIGeFIpkKxkTEnYDZCST8r/XIuHzXMEd3pkWLc9xLR4Bm3Z2sA9fkEmfDoUk9L1ZQCWe73pXTz/XjpaylkFt6RZvQ8x52RWb5redp5hF+Z96HF92chhI9m2Fq0Wucm57MMG8pVzH0+6NJev9Xw/Pwcv4vhvQgWCUzMHHVbaxzJQESQJmmOtdR29ZPDyycY4qVjXwiqIOtE9vZPv1jDjnQmXDg/EpEdhXPTi6JuhqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8+C2ZLnyQBH1q6VejwOY1Y0hR7EiTrsKfsNi9HLVLY=;
 b=Vg6XTMXEXnkQ37JIbKRRRMNyFjlsDvJoVRrgJCRjhX/iHihZsImThTN5R8N0UsM1D9PSlQTtSSlryg+/g8yb+6+PKrd3HKC7hcwGKNKFy1mWdZYvtYkB7OrdgNsbdd517yaEGo0ocpcUzCO8n9NaImzszqtpkwNNiVcV7tSvX6Gg74In6B5jW2JlclXob77KkB5dYBoiirNHKuvf+Ez4/G5M+VPzTDcmti4g5lQDPsAVRgj6BvP3/ivbMV8PJh0Dv7DUoIpdZzuSV26uiM2dDne1udPG0g9Y/lTkq+fKefxFFpL3n+jBl+VS4ofRc1qs+BM26HkLptW6rH21FErp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8+C2ZLnyQBH1q6VejwOY1Y0hR7EiTrsKfsNi9HLVLY=;
 b=D9GohBo5r0E1H9mjWI45lZIpv4pXYcNPxx+VqbqLqIs4wVXvdFUk7ImUDzZTdmb7+ZzYEDeTJwNjtJV4gItLrNNAZEwV/NjeD9cIDTIiDExZsk/k3jynhYEkqoUOhMaCTIDaVt07odoVMW2LQ6PCeTfzqfsAohweiE5To4Emkds=
Received: from BN9PR03CA0375.namprd03.prod.outlook.com (2603:10b6:408:f7::20)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 21:42:39 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::b6) by BN9PR03CA0375.outlook.office365.com
 (2603:10b6:408:f7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Thu, 2 May 2024 21:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 21:42:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 16:42:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gfx11: select HDP ref/mask according to gfx
 ring pipe
Date: Thu, 2 May 2024 17:42:23 -0400
Message-ID: <20240502214225.8101-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 04aa1f75-96d3-4e0c-a294-08dc6af0ca33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pnb6DVkHfuUZXfz3saMPHEi/qTOnWByes5ag9nDrwY9sOxz+yxb2tA1dy3QF?=
 =?us-ascii?Q?g9E4Yx5b03USVufxMo6j+B9Np6UGdZgAsjFAaFLxbvhNE9Nkocs/ylJmRIde?=
 =?us-ascii?Q?hr9gJqXodHDrwpexdHD+iLobuaf74xQ2fdV+SOzTS4ISMyEd04DpGTQ5tBSt?=
 =?us-ascii?Q?PNUijsRmntkBSzDscEMVsRAtwhvVSVY2k3bATjAiT7GC30/Jw8nLaGkDjusW?=
 =?us-ascii?Q?wArOJ4itUIfupkg0gjO2BUmcVhnIhQHriqC7znxgHe/s9IQVLCAnk4+sr0P6?=
 =?us-ascii?Q?apy496kXf2zNJDSHcYG4yQMqU4hb6JGGStscK9NXiEF5PxbeSSHcz33trxLk?=
 =?us-ascii?Q?gM7/ekozl8kEqunhupahGMBClFSVO/7Ed/O+ZcKjER2+MRPHvr2uK1ymrSAb?=
 =?us-ascii?Q?fD106cSh9DZH7FKiU9oCHqyOPH0/p4253/mD9TOggJF+YY9gpCZgilng9v7f?=
 =?us-ascii?Q?Zu7DqftCLQoogExKfJl9RGggmIQTuaEVX04sHSfiYgaOe+B7gz0Xw7Q+S4Zv?=
 =?us-ascii?Q?FSjLBKRzbgfN88KkMNS3AtfE1BOFyvFC8sdfuJgBZME7TrbsPEEPkpBlD086?=
 =?us-ascii?Q?UL4wKZAKbmZqHprv1EB40gvFp/irxdwvGOKhiETw/pmIFnIkPp2OK+B3pz7R?=
 =?us-ascii?Q?FXCX3Lh3iUb071VZSzAWHxtCY2ShjDlQx7fYExIpjDagMbtitQ0DTBXJU115?=
 =?us-ascii?Q?RWMnsY+OeU16sukqBeUeR8Z+vBYbyt8FAT7uezo+/d00v7tDoMfItJD9rSn9?=
 =?us-ascii?Q?D9j5kAYKbdIWjeyaYLxiuJOI3lDJFbTSLf+JzO5UDvJd0uCufrFqlQGbrfgg?=
 =?us-ascii?Q?FchH2BlvnE98h/1WLytmjPpp75PgTtI5ADo3OzSPEzTg94hnlEbbVI/eCmS6?=
 =?us-ascii?Q?av2dOH3+0zCKn2RQvkevzf9b5GVmgi958jMv40Kja7q7RDJ5XPOtumTB9PQc?=
 =?us-ascii?Q?lM0WqQyO/aU0vMxFLF1L3+P1dEWrDmvLDPhNVLQ8Lut8IzS3aZf5LcTdouls?=
 =?us-ascii?Q?WhtSjGyiiY4CfFwYhBRKOYNgZcnEZcQVYTYPpch5D9gwUrQdmfdrsnpZiyGI?=
 =?us-ascii?Q?gZKLO7tSg4qi+fOaasVhGBah40OL0k9Ee15rh0BIzrNwTN8We64XY0xJCEOT?=
 =?us-ascii?Q?CGGwCeZ9z60+Bfov/3hJYj2bXTIAF9pkroNxfpXV+WM1KEbqObGXTOWf8W2e?=
 =?us-ascii?Q?xChMUugLdMPdlLfkUCD8/4repAfL4ASkqHTbLFWXmEMdeeIYznX7/VuEwOsB?=
 =?us-ascii?Q?78DiTjipiwbkSjQ72XvMg9E1CXMCqXnjBVcvQVqce6OQ891QAmk2/Cl3Nle9?=
 =?us-ascii?Q?Tax/RP2K0FpQIOjLiuYK8j/+OKoNuvGvuZ2uhfq4N3mKskTosiJOAuoMnMpd?=
 =?us-ascii?Q?4yiL1YAA7qPOAFkvdqQArsb4CI5o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 21:42:39.6375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04aa1f75-96d3-4e0c-a294-08dc6af0ca33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
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

Use correct ref/mask for differnent gfx ring pipe. Ported from
ZhenGuo's patch for gfx10.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ad6431013c738..81a35d0f0a58e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5293,7 +5293,7 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 		}
 		reg_mem_engine = 0;
 	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
+		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
 		reg_mem_engine = 1; /* pfp */
 	}
 
-- 
2.44.0


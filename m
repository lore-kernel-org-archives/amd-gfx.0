Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ED8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E7410EA5F;
	Tue,  3 May 2022 20:09:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFBB10EA3C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXFl1cl/mGc8RY31cOsDRDAdhCSPQbP4DWE9Xg5N4K2Mqy3OD1kSOGunpSm2eBIQ+/PRg0XC9suULZ0+jleJbPyZzRYDoUEki98mxM7TiGxN8A659/l6UIwyXMFPpY1ZnaU5d6qzv72ykXWg/Gv+l9gdkyfs5Fi9T4y05ByMCCmqH7/S28eebR1wKfUc3OlC8VG22iIdwdTOcnba4HuOPrdu3b4JCd9FNEftdIQfzT1RhXB1s0yLxsloOvLKVpS+ihuMQ1zlCstbubheDTWsddAo8I0eDC5UCpdgl3HIOqD+W1tUQunNMKbLCXSzlERghnqA9F2GbTN+0QyYUj+bpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKneBJmihGJVj+h9oimW0Av163tHT0p86DJA++sZE5g=;
 b=amO3DOnjDj64kW49aN0g5FsAQS3IYnxrSmrk1Qj+g5rf2513U0qceeeiihKc88nRPnkKtmf5fOjzdNz+N0dl79+XXigbl0yhrmxw7fuKorNZhVFmuPVm5BRD6gQLNxDnR+wyO1JaW33ueg6TA1jKvYdpyt8RWm2AVlz3zfH15NhYtaST+No5NJu7Pm7MpGQ90YHbAhuzvyb9YbzdAo+deWelupsBmGYj3oxKNs0bGpnXQz/LU+ubpZok6Mfq43q//hJ+IC2+m4Wm+q1o9WbQGagucQbtVUnU1IjY0BZpL0JGq8b3ThDKoC8323/xTSjq3yyW3aIfkT18ntkvZ322wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKneBJmihGJVj+h9oimW0Av163tHT0p86DJA++sZE5g=;
 b=KYkYDd1YBeNXuUTj1ukmTXPq4CNxfD3kzXU8OSnIBebd4fF+fJaFFQVLKrhyTvW6K42hTNMfkeL0O58DMGu8wIMj17I/9tOsPpkYYPRE5hYQozVbGV0WzIGr0kVOrlk98W/ohFMvcFao1aMUnrwhIsTAj+xgLjQ//tUNbq9S6A8=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:09:21 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::f6) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 3 May 2022 20:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add hdp6 support for HDP 6.0.1
Date: Tue, 3 May 2022 16:08:54 -0400
Message-ID: <20220503200855.1163186-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8529c14-75e6-4e49-0a63-08da2d40cff7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41573583A3D5186CF7725116F7C09@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nf0ROA0sfBemQcAXwtsvHhdg9a9zvNJMsMdmcwIVWfC3xwevUezFuSB3QUyBMAlwkMSfrSjwO8jL0cA+Md7xW+xkJP9g/GidSsoGpMAcYZi8LS/pccCNANv/uSfjZLBV9ogmbcetXsGm7ezX9oDa4+Pdy6+xaaRao8rafXLlkMNmFvcKPeLWh4xfjN4SlfZMUBsnsK8O/Kg1zpIdX06HwPPRnO7OgOuXDN6wHMDceewGSRbRYOT7wnbIVOES7wYDR1PBjJ4MXVzigLkm7XDD8s0D0NuQFBG2aC5ia/38lUl2G399os5oMHmssqOqZb6iljawaUDAi5rFDlCvIXkxMvKESUgc44/3mdpLIqMVU0Bz8wTppdRPYNHLXNJIe1sTDFoAC2pvzKM/Jplds61O9tvHRlLNinlX48ZLac7FcYKwyXbMv0TKVMsAtSQOV2TQnThzcjgkvRGH5B0eK5mbhkDcWTkx268bgHCV4YJEksP2QKSHJdoeV6aC94YezSGIG3l1vLOlqoxEdSWxaAIbsrG7XT+SY9eWZHnysyu0vsTb2VogkC6xcqPRDC5Gsu9P5bWR9/1JXxEgNNB4vTmJ7Qtf4XvWEwBrMpB5Oho/jYckpKN7EcEig/bfRkRmmMQm74sbasOSHLCqO9EVeb3JUDX8XXjqdOgmnSljhnwyP5Q19n3+P75/7wBw8GWclaGX3WHsMqVUtM15EKQH1d6xQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(2906002)(26005)(508600001)(8936002)(356005)(36756003)(6666004)(4744005)(5660300002)(7696005)(82310400005)(8676002)(70586007)(83380400001)(4326008)(81166007)(70206006)(336012)(426003)(47076005)(40460700003)(186003)(316002)(1076003)(16526019)(54906003)(6916009)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:21.5483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8529c14-75e6-4e49-0a63-08da2d40cff7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Enable Host Data Path support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 26ed3ff8e7d2..45383c1b4dc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2217,6 +2217,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->hdp.funcs = &hdp_v5_0_funcs;
 		break;
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 1):
 		adev->hdp.funcs = &hdp_v6_0_funcs;
 		break;
 	default:
-- 
2.35.1


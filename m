Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81756C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 20:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00EC06F507;
	Thu,  2 Dec 2021 20:52:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF76E6F507
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 20:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/sVIgiHcR/H3F9PWm1h4nZKS2F+Xs+14+QCQXVwiPGqklmt4/7vi3ocdc4mNYYB63gg4OmSirHIB/AvI0rayBar9yO1OpFJfTUjsVJiXSHuSTZmk8HiJgkFS7OQDFlswbmvODiy4swusIkNO+JMuLdJcTkbG7vpPpHedeo3OLIoOj5BU7Prtt0jcgEkONCDro87iFh0i8MDMz/EgzH87xBkFr6EL25Cp7WHB5h98AXvXRk/Q5He4KZ3gSNqxOTbeLw2H2MFCX3N/9NCkuGA1p3IgPTHohB0v9loER9Kh8tjsM25l+EDD03KrEGbivnuh4Qb89EDuUEw9de3m9IxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pahENdxlc8DEa4AjWVYtVc2akVPihdgMlOJ/JC6AjBQ=;
 b=RncSL1lPkFIcZXy332fDvxK3qEGIQzmmVS9hFseFJvdxxi/lLK3gRj/ZojUmQmQDc6b5zvgrwdav0HsxnZOlGAxmpOuuj4+YcC89ckEd628xvlnHHhH+GxS7crkQGsagYWgyPa2SUQjXizgMd0WzhS8Fmfev4I0r/OQOMi00mfUYHr5RnmxBYqV2s0fBxGOTD0Lw10eUTRuIPgRDokjo8FtKZYyIyqk3NjgFsRWrreZZ3jPq/6IgoMyEfmzzFpcnJWVatUPCAbWmooDgMX0S470lRVd3SEIvTHTjdyZXrVNAiDMdVLUQlq/G51w1a6KbyEggNH7XVxqShVrfpluFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pahENdxlc8DEa4AjWVYtVc2akVPihdgMlOJ/JC6AjBQ=;
 b=1v/iTaX/k96nkQBonOMx0Doc50NrZ4hV0LxJdWXH0Zqx2VRh60U4pMdUZmoHbaHYN6lhyTyz7Pa1eDOvz24hHgEiHpah/n1bplQ3RB95w57GHL9RBLBtmDqTHmYDdOrTIEJLYFv46cehacuAcuTt0FxPp5T79Kj0FbYoCxA3+Ug=
Received: from BN6PR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:404:b4::32) by CH2PR12MB5515.namprd12.prod.outlook.com
 (2603:10b6:610:34::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 19:19:26 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::1e) by BN6PR2001CA0022.outlook.office365.com
 (2603:10b6:404:b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Thu, 2 Dec 2021 19:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 19:19:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 13:19:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 2/2] drm/amdgpu: bump driver version for PROFILE IOCTL
Date: Thu, 2 Dec 2021 14:19:12 -0500
Message-ID: <20211202191912.6148-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202191912.6148-1-alexander.deucher@amd.com>
References: <20211202191912.6148-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8697fb32-b6b1-40a4-8eb6-08d9b5c8a772
X-MS-TrafficTypeDiagnostic: CH2PR12MB5515:
X-Microsoft-Antispam-PRVS: <CH2PR12MB551584CBA69BB2355DD9B952F7699@CH2PR12MB5515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkM4ClGlJf8KHynRc9CEAGr56V3qNF2X7oJTFtsjGWKMgFuPSSf2eSgPX0xINnZrCRRJYxe0q7RZJodXY/QNrkVg1WGaHn6UpAn5wEQ+sB20cRMDdTSbI1a59asHWYAz18j5ZCJWTCNh6S+JegilRb/59co7wWmtDabLb9Qkunhkug3bbLrQLs9MX0b9u19Rlq0HQ8pMY3lPhSTUHqmqYkW4Hv8d4FuvdvDkAOSboWuXtvHkNpyIRpKlDCyVKubQBLU3v04imLShpiO/XIT9zHdDSPD8GEb4pNpjKmUz8DsdR3031N5JeCXmVtReiczqBLESOda8kPNIVV6IWGTGZoFnCWtO6vY+H7ITdz9Elyzo4GC+xxTmdTuKFq8XJJbVk2qh5IMI86qaP9Y3/fpiWMpYQrPbQgXvDVtcwXzRy2v1s2g27rWbgLuGhce5Y04JHtHUWlqaaNUygDBT02p0L3C1M0BptW0iA72r9rmq5kmAm5OUKFNOcl0RUALHq+t+JCCF94XgQzSB8d2ME5QI1BhpMxfNbk6yP08WVs+ojf/vK/vYqdipYq/thtrkqcI5HBH81pbO31VSucvfNGAXtxnDswkrJs+vLrBQrnN1/842NwSeu0V1iUcPAi9Nz8xJf+srYXAkts61Xzik+brWodWMyMwQRIZf0tv3K28XMR/D1pqCw8uynwT6TOsuM2ZL5+pzP9w0l8wdlSQ/n4wuYFl3qsmiho6RcJLfy98VeKJmsChS6MbdBStBkmIIkluqiu5aqijxDYr0tE/JKoiOcAEkSyexjJmCorz0KQgHukE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(47076005)(36756003)(40460700001)(426003)(4744005)(70206006)(83380400001)(2616005)(6916009)(86362001)(336012)(70586007)(36860700001)(82310400004)(186003)(4326008)(16526019)(356005)(81166007)(7696005)(6666004)(1076003)(8676002)(2906002)(508600001)(5660300002)(316002)(26005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 19:19:25.6591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8697fb32-b6b1-40a4-8eb6-08d9b5c8a772
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So mesa and tools know when this is available.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0e27f9673f8f..b50cf36417cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -100,9 +100,10 @@
  * - 3.42.0 - Add 16bpc fixed point display support
  * - 3.43.0 - Add device hot plug/unplug support
  * - 3.44.0 - DCN3 supports DCC independent block settings: !64B && 128B, 64B && 128B
+ * - 3.45.0 - Add PROFILE IOCTL
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	44
+#define KMS_DRIVER_MINOR	45
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.31.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A548DC6FD20
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 19:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C3610E132;
	Tue, 21 Mar 2023 19:39:46 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DF310E132
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 19:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+8MxlJQNHFymE1y+hy+6HMLq9mx19y2U2CVrDTHiQeQ6x1lSsPJxTQxJS7TEuGQiP3S3/GcMMoawwsZky4n7NC2Z1/bHsJ/LjfBGqBFe6SETkQL97fqjZpvWuehYyPOwNS5cnlIGC9605W3BtlM0JbVMyKbN8IKSjtZCswCNg3j8kOpnzOex9oTt/hyRQ/Db0gfnEUO9Lw7DT7WcaYQ+zKYmNOek0WaMGCzUqtRAAFgofnLMt/11nDmYmvg5LpJezKAxfzHfSwCEhv6A2U8wH/m/7InIYYTgyJTbf44ZYyjx8L917DCSxu0BgOR90EEFnhi0YzfoTQAMiVoVV/NTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8jalTd6jmU4jIVws8W5lkPyZC5RXCtTh2pT5KBgrfg=;
 b=h74E6IsNLw/ff/gLIf4I2ZsviUFo+B0AGQ/5j9x++n+R9/VYn8YmK4o2j6pTL0dQEK1L8BwRPDcs9y4mXadZb+ZXcEwS5jNwqZdjiSF9okNLumJfOzRJ2FlJUqrjre622YkGxzGhnEWoMcgBgQ5YVP4HRVx7MOL8CLdSVlg7SqP/6Um9p22P7FhsSe6NLhsIhJ9BGyaVvyhlZ9K1lmRTLegrd83qYD67MYpowy+OyGNZyLxDXPiezZKnYDEqlQL9j+759+3jRi75NhjqVCaY8qkiS0/8L/NslCpAe/7m17TKAzxycCZojV1mmlgZsRexr71cajkJToSkx0HbbLR6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8jalTd6jmU4jIVws8W5lkPyZC5RXCtTh2pT5KBgrfg=;
 b=DlWkWSuUlLULk7PdGkkAadwEdMKMjdlBFUrc6lDdGAJqtsUTpgUOuV6ISCkVqhso1yEshann4ewAuG7RtPPdkOBBFgtoBx3Zp8C6PXPEoxNmFvzfTRukhckNbbxrjSK5gYezJB9wq/7PbvroxII/WWSC07GKv2AeYJzdwwjBU64=
Received: from BN9PR03CA0403.namprd03.prod.outlook.com (2603:10b6:408:111::18)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:39:41 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::54) by BN9PR03CA0403.outlook.office365.com
 (2603:10b6:408:111::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 19:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 19:39:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 14:39:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: track MQD size for gfx and compute
Date: Tue, 21 Mar 2023 15:39:21 -0400
Message-ID: <20230321193922.2029808-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|BN9PR12MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: 69742187-9e20-4e51-b520-08db2a4403fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+W3Z55n5LS7Y7CFga4Agu1CuD7pjPtmNmMZmoYQ99xsvt7V4hboNDumhwyx+Y1xvKvMwm+VBxFGT0QTi7AoT+6oxgwGDVQz0fqpmdCnEuIAl0WrIW743A9/7YPSeqnCbl+BSFc0p6NpWXcM5jjKlO/WnDOR8YEYAPiRlA+TCVYJXtTVEdgYWP9l9jj0ABjoZ2kbE1j6AGRmNUikjsgnyqme2oUrWu28kUrCEcLlPFsBMwePz1ZzjvNubJzqC3pge4CgYgOWBHv0t70O0CekUNYbLRCAW0m0wQpaOHj9XVSyidmWGJWduIdp6VjPiVgoH3k2qdl5fbPGBH8CB9EgEYEW+ptIo2mN4SEwOnvbsopZZWebM0emHEKw9JP2O1XIbJP8PsYit8//PDng12GZfDYHqs7P5/3COBf/RyZILOMU61TN0i9MaFVvGvtvWP+eRxa2ZmhZK26+2XeokdtmtYKrZg/QRzupTod1HBEF++y4OGw52Z2u4Ujl6GCJ9f24bVGUOFT3b/D2TyMacsCzXAZzat1C0TxiAXSIJdoN/f95KCr5VjSjJMvM1zKoJCDxmfKJ3MmEAGkpcHrf0xEscvPZ5H8q3ylrECR/32d+6qvPbixzUIEpcr7RiadzDJXFB72Gkc5uSZP0yDLviYv6jlYLmozKxAqxOQpGVIHhH7M8U2YXG/MVRk4GmLkG7L6jkGlBGP7e4ElFSmLous4n0D5hoNY94V0OCijBxnBgCmc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(2616005)(336012)(16526019)(26005)(1076003)(47076005)(6666004)(316002)(6916009)(8676002)(426003)(4326008)(478600001)(70586007)(186003)(70206006)(8936002)(5660300002)(36860700001)(82740400003)(2906002)(41300700001)(81166007)(356005)(7696005)(40460700003)(82310400005)(86362001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:39:41.5624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69742187-9e20-4e51-b520-08db2a4403fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
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

It varies by generation and we need to know the size
to expose this via debugfs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c50d59855011..5435f41a3b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -404,6 +404,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 					return r;
 				}
 
+				ring->mqd_size = mqd_size;
 				/* prepare MQD backup */
 				adev->gfx.me.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
 				if (!adev->gfx.me.mqd_backup[i])
@@ -424,6 +425,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 				return r;
 			}
 
+			ring->mqd_size = mqd_size;
 			/* prepare MQD backup */
 			adev->gfx.mec.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
 			if (!adev->gfx.mec.mqd_backup[i])
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7942cb62e52c..deb9f7bead02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -257,6 +257,7 @@ struct amdgpu_ring {
 	struct amdgpu_bo	*mqd_obj;
 	uint64_t                mqd_gpu_addr;
 	void                    *mqd_ptr;
+	unsigned                mqd_size;
 	uint64_t                eop_gpu_addr;
 	u32			doorbell_index;
 	bool			use_doorbell;
-- 
2.39.2


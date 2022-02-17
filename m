Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA19C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 17:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D2210E33A;
	Thu, 17 Feb 2022 17:07:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E42D10E33A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 17:07:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2lK1WiJNHqCndZSkQt10hhIeiQ753emfuGnYecJZIg2gvAgPdzglvDqGGaFktbZD8/WIoUztPOFMf9/NEVDt4DhspV5QR3kMb2jx1/sQWfC9KmTGtEfKGVPxJDnAAI8EzFLSN9Z0ijVjP/olWeuTZlysdkT97cvBq8afBOnQnRMp4ISDHp/f5SuOaGMMVldiC+J5LcPrZNunpG5nYqo54Wp0mNor/gks8/I9l+dGRkN0IttApSVfeR+yEyNCznN0JHu4x/ITptWA2CDolPjMSql3LtH3pSfP0FN9PkgotIfHhuxqX21CXqX0pjxdB+9ZfHsHmo9eAJN3nPcqqRujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Skdxny9woZi8DEV6ZRYP1kVMtXlRJ+NlNW3aAqBu4Q=;
 b=cREsgZAkhXBtsfFMvTzpfTmqjUsq4vYiiRnI4PFUSGlFvKBWha59N1kDwN2HH0Nw8wuCdcPRzMJP5T4nIMjbR0oZ9JIGOjQ3VZc/IAU4MFICTawitOPleOeq2+dy73G2+BF8qp+NHPiQseQPdNW6Y+CvQOrPZRporD+x4HrCfKBcGXhRt4rG0leyEOmehVFEZrAcZJnwl4WfW6Ejzd0tE+RowTbmMbzfQk4HoolKYa/MusUNWZfG7azVT5Uz4QwW4MK67kYaaWhk6febLa6ymnCEhP/EfOblMNfOEnkeliyw+8iCyA0hsmn1tX4GrvSLpbt3i5PqnveHVIfC1JOiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Skdxny9woZi8DEV6ZRYP1kVMtXlRJ+NlNW3aAqBu4Q=;
 b=UImQF6R58y/lKqURjjpkFPG8t7vgsOfi7jg3K/+BJxMqo/KUfXYnO2H0387kp+MrKT7OkjYxmqGxnno+j1vgN7cpnUwc6WH+mvX6jmhaT5mMdFd8Om5ULW4/IBI5yzbMqMP7+peI/S+O6jlw0yZaQPwJX6qFNDsPICPQr2WbUWM=
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by BN6PR1201MB0196.namprd12.prod.outlook.com (2603:10b6:405:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 17:07:25 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::39) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Thu, 17 Feb 2022 17:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 17:07:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 11:07:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add smuio support for smuio 13.0.10
Date: Thu, 17 Feb 2022 12:07:11 -0500
Message-ID: <20220217170711.298235-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3171306d-bacc-4afa-ce6d-08d9f237f83e
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0196:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB019645BCC584E2033301C3A5F7369@BN6PR1201MB0196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzwpbfvB9TThUzJaxfTRhYHGOO0N9YaRgN4OmJR2hIhO8hsXWcTasWNHRrXTbVb78OZHYRx2Wx+calFtsDglAKxMagNrGWGjZ5H24UsNRWyo4nE0R67bkhM5aGxdh9fRK/lWPj3UMONZeW6laTUYFVuK9/1KpKwzSioPlu78dYuYVj2KsOLvdpMZJobGWZasUCue4Yrw2GQv2OKXrWffHuM9+QQGNfand2GwdonWQWDrrPvo72l8kSsiu+DXAUjKDk4SV84IqxDLrlBdbl4uNeDKEXyKExGom5DeGm8979D/KgSR9P2QS59Ll+QtjWvDu1IRar0ubkeRggxQV8960vKDrI41F/0mvcGu7vjnFg2+H0PgpKxiasLCcH+yjKDkvavXnDu32Kdk64M/W28GVXpJLrRSca+809CGO/G5VhN2hkIWGsSl4/s9bKqMZicogIn3lgGAMXbhIzR5wD4N7tNyFbWCgRaldQE1CoE/ii5XjXEdQsIhkyEnJuY5Y+Ak8ewJvroTmHAzFMYAEQleiNQAfBwzXokBZ7w5tUeqYHpKODVAtbthbmGjgX5Wu7omgRLKCR6iYPfDVZbuujZJn6KYPXqrjh3+PYfrHPiOGXlqrqijaxRXPnMamLcKXKQdygj80XzcfoS4VXw8+kP9K0wF2yr4Bfngmn9x0C+699OrMD6Xgk8l/65+53x/pR9BFf/fqO1SEtWcH8b7je4qjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(70206006)(70586007)(6916009)(83380400001)(4326008)(8676002)(86362001)(7696005)(6666004)(2906002)(356005)(5660300002)(82310400004)(81166007)(2616005)(1076003)(4744005)(336012)(426003)(16526019)(186003)(26005)(8936002)(508600001)(36860700001)(316002)(54906003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 17:07:24.9749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3171306d-bacc-4afa-ce6d-08d9f237f83e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0196
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

this patch adds smuio support for smuio 13.0.10.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 016c3dc4c303..2ca94e2c54f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1912,6 +1912,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 9):
+	case IP_VERSION(13, 0, 10):
 		adev->smuio.funcs = &smuio_v11_0_6_funcs;
 		break;
 	case IP_VERSION(13, 0, 2):
-- 
2.35.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0515BC761A6
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D615B10EC57;
	Wed, 29 Mar 2023 20:26:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC7210EC54
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUrUIgzxF8kdNT2bYKI7zhre8nhVZFS2v9+8g1fNdTmmhccESAVj6TX9XOA0P/mTM4qqtVd8zITZifEkFDtDDt+WC6QfCVlM2dF4jKU1cLCf8+Lwj+YsWJudr6dOS81Bi2JTUlgxfEW2PD0TufFSEzfUnK7xd48fGQ1pIgNp4fOveyDOv8wj587thwt2j0PVDSZZs06jp0GVfHuBGWORC3/IEsQa0MtjfMiu+cvfz5r2Ih2+OqRVB5fUOwUIf4vaFz9Dh50HL2JNqJ8I8fbVfsu/GkjxWfY4sMmU1wS6/mzQgpgEtrYQ1Kqul+KRujXXNcAJRBk2xEbfkV/kNS054w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYSCkGWw6saVpEE9W8uuthUjvfBCVjyfZZRSvBvJexI=;
 b=Ot1567qSAISPUfpwuroCE/sbO3188C7TwUbj+yc199qoLOvy6rc26v2Ry5l2mcvPZp3liZDNb4/SfuIVt7s9GWUgXNUoR7p1asqdLpTTS/hfWwJIH8LZhxSaB9BBnidE+JYvsS5Mc7aKetNa5I8hyH4wr9TYVkipWGYjfw7uxp1+JSJXvvqXCFZl+3M3GjUy1L+LvzGvq26vtHmRonCxWh6qrnqu+yz+7E6WnoGWyoaKpSIHMFvqeLsEIk6noEHu11J/ezjUppPwSSfFlouv8i7dfd/HEG1jT16V4tBmOFy+ECSnJVfvRJiL6s7UWtrC3Oonz1ZOvn235RDGJIIUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYSCkGWw6saVpEE9W8uuthUjvfBCVjyfZZRSvBvJexI=;
 b=hEau7jWacTNbxFo2sJb4GohGMmnl/eb4zuVMGfUfuvsMsDblstsveFho49Xq2yIm7VYbn0l4OHYXx95c46GjOY6dckWIYnwDX0Q6rB5PoK9xZo9qZY3fcWqJ1wNL78CN5oFqhq7V/vNtH+TL/1UBmthVNyY3IS4wpY6Iy1shwv0=
Received: from DS7PR03CA0137.namprd03.prod.outlook.com (2603:10b6:5:3b4::22)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:26:03 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::f7) by DS7PR03CA0137.outlook.office365.com
 (2603:10b6:5:3b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amdgpu: increase DISCOVERY_TMR_SIZE
Date: Wed, 29 Mar 2023 16:25:37 -0400
Message-ID: <20230329202548.1983334-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|BL1PR12MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 26661024-9abd-4d81-864e-08db3093d10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLL7ClB6nFc+OfH48athxyPX3Hr8yDY5cl4UUt+w97vpzLRnfnHKokBntusjeI7IVQnnVO6uCodcn1jUPrSnkEdLBCIXa8IwJwNML+DliVuFQqBh2BEovSHTztE/ph7CFuxqGs0xvhCu1rZfTeLLYfLq9uH7jnWVMtU0y0T5nJj+WHn1q0oONwzppUjQUitUEZbVpWWRWJliQL5YgyW95K11nxxYYgDNaygkH6F1H1294HyENoBDmTzLlu5ERV/2e0q/itXMToQ+ZLfsN0023nExjPU7aD/TlQ+VqmYmd7yWupZhDwhUgHv3Y59BbuOdj4zAQEAbaNeiAprZhR0LUeIkA3+zQ/edcGRxVU8tjSbCEu51vrZ5dV64rNxzxoctIGEB0FfYmlgnr1Vkqs8CUyQtoIW0H7UpIbOGUnyg1YWDAVHrZaPhmYvHeveFP33emti7Pe/QwGmenLluDM7xJ4Ry5X74PYcdBHcu6UlN/NisY6im93/fWrot67PvXWkok9+QS3Z58rlPYDDfF0aKnlxs2cvB+STs2P5v4pvMeZRqLx2b/k1p/A4araXlUrOlLuQcO7tGJMUJozctuckRFf+1XcIEf3qb5cR9irih6zvAeG+uXfhp4uzMywyMLeoSZ2MlWn+VPxiddEyWJQ0WSJo9gquCuziQIoQyZOkvIPWKyjgNcu0G+HS93LPPdwqEPBctjFqeyJUZqa5IzJmSNgx+TPQN/sEWq7Lg5iSHjoU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(26005)(40460700003)(7696005)(4326008)(8676002)(41300700001)(70206006)(82740400003)(70586007)(6916009)(356005)(36860700001)(2906002)(81166007)(5660300002)(8936002)(36756003)(478600001)(40480700001)(86362001)(82310400005)(4744005)(316002)(54906003)(2616005)(6666004)(16526019)(186003)(47076005)(1076003)(426003)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:02.7926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26661024-9abd-4d81-864e-08db3093d10d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

New ip_discovery binary size is increased.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 8563dd4a7dc2..b7f4ba72a1ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -24,7 +24,7 @@
 #ifndef __AMDGPU_DISCOVERY__
 #define __AMDGPU_DISCOVERY__
 
-#define DISCOVERY_TMR_SIZE      (4 << 10)
+#define DISCOVERY_TMR_SIZE      (8 << 10)
 #define DISCOVERY_TMR_OFFSET    (64 << 10)
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
-- 
2.39.2


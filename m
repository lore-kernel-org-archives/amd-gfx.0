Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E717C4829C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A61210E59B;
	Wed,  7 Feb 2024 20:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Glubopty";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C5D10E483
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BanOd8ZhuE7xBkWtUwdgMQPcaNnYo2q611IggaagJYkzex+RYl79g2oO9UOK2eGsPjUWII0baCtdEmhJWjwfhwIjVFb4mdn2mA/0LuSSl3Ai0fOQ8RbY6U1Y1++r1nSqlSp1MBhxwRBb/9XwFqf74e1bf/x3xRBIDNlSlOXUHz34ilc4pHtgCqjzhgUlTE4BxZKb/RstznP3m2TeA0DrPj22NYb6I8uupo8yJFVdoB1Wji5ZCe8SlnHFX6CbyamdmRB1iiowiXY+LMFOc9k/B62eFeKvDzMoHjyGMIdh+jTGzGmwLp/T4/J/IBzkaoRLGNpKd8BQjiUK3DdknIr9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc/JXB2JFJupRWJe5JydW2WUa8grFO+iRVwCPHF1w8U=;
 b=YY9b5+IofqQ4qubOBM6SVftXajfKet6kLGK6fDmpOV6BrcRDezcHulSDZEREsQDlpU6Tqt2mY5nbeCXtuZa65p1UFWAgpaIKaEwarPv6g3AwFo7CWz1Z9uFW6OvOUimhZoV71ZaUV0Qi62wVeQjbKem+kgSZUL2JUut+wLuDR4Zcn9sKZNA45dktjqmbOOiUWLSRgiDCMyOWN19NWRw0pvXFcfP+GqvYUZWIi7SOnRP2QWpRyBLp4nLLlKZK2KJF6hBy0f3vcHHV9jV+W+4m82MhVEJVCjklcUGOMT10PVU15JK7vAehmd/frIrl3fKAf8um4ct4XMfT0vExi/+fFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc/JXB2JFJupRWJe5JydW2WUa8grFO+iRVwCPHF1w8U=;
 b=Gluboptyfwjlint4GcXTd4x1FwHQKPomstZpmGBRrnVXJI7pEDfIDl+yC8OSxLqzHdkFUCgR5THoZE4m9lo9WTn//Lume+jMEJvRtN6gsL7wvvS1hhFlTKCPmaoTVxwFFBAJ+NDJfX7BIjONhVfQg+/6dwNouUdaXGbdPiZeqS0=
Received: from SJ0PR05CA0110.namprd05.prod.outlook.com (2603:10b6:a03:334::25)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 20:52:23 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::c8) by SJ0PR05CA0110.outlook.office365.com
 (2603:10b6:a03:334::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:18 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:17 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 15/15] drm/amd/display: 3.2.272
Date: Wed, 7 Feb 2024 15:50:50 -0500
Message-ID: <20240207205200.1608684-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a659822-20e3-4f80-5cde-08dc281eaf6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyLxa0bBtDgXd1Vlt/3iRDb3Zz7f6Tjfj4IB1nVjk5ISm2XIvzKyvcXMdo5C67KKnM/xL2xeFjdgBal5T88tU0fcgj6IkDaj5b3KIp7VH3bRYUUHPLMtyrHR3jYoiQCXple8wzO8vqxzKn4OJioB0tmBSkvs6JTn6cE28Lz2M9YRZuak/Msipyv5LdY0zKdVwiZa3EZ0lynxTsRycMvenA5zKCGkt2YHamZuFqRXdPcyYvufE29kuy7zHDp1IAoI40T+6gn9CoPf4IbEbNAnzCZ0qmyud8VauWVdAbNj/hkEKvnEu3q1jx06Pftz8e/8XbTB9QQzbjIICmkp3X+HFy1DQN1v6tEA+meSh+5CXFhJLhDYAVfviZl/hKretal9hEm6ujqFqksgpcxs/ZD4SA1EE0gOn8P1PEKu6LPk0vQZl6UQHyYBOcIaLvpyEPyqinSvbF6tvNGJRch1nEXTrvmUf9NADV++S440+lm5dJem+5fYUea8pmalbwJpGHxMlax/E00OiZ0n8VDF5yIIvAZ204MdzyJbzF0tFvkG81r31WdaFzLgxCX8d121bDHaW1wPE7a6kJJg2uIl9/p9TLlcIFnig7NGv0JHQpZ1xrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(1076003)(41300700001)(426003)(2616005)(26005)(6916009)(82740400003)(83380400001)(316002)(7696005)(336012)(356005)(478600001)(8936002)(6666004)(36756003)(81166007)(70586007)(86362001)(54906003)(70206006)(4744005)(4326008)(2906002)(5660300002)(8676002)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:23.5071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a659822-20e3-4f80-5cde-08dc281eaf6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
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

From: Aric Cyr <aric.cyr@amd.com>

Summary:

* Revert some changes related to pixel encoding and clocks that cause
  corruption
* IPS hang fix and FGCG enable by default for DCN35
* PSR-SU/Replay fixes
* Plane clip size change treated as medium update
* Fix for checking link alignment done during link training.
* HDMI compliance test fixes and other improvements

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 181144541657..9b42f6fc8c69 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.271"
+#define DC_VER "3.2.272"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.43.0


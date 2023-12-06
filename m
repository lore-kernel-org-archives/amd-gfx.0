Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CC0C10DCE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7577610E553;
	Wed,  6 Dec 2023 19:52:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536F610E6A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz0C1PFam4hKv253v/eRq4yeEadpzo3a3Gb46goiSKgs1WxLNfoG7618ruaZZ2ZRKc9akEjpiMgQ+YWr11A60QjdAvNu9/BGRXH6/qQHTrcSnosm4piT2OUWKSKyZEqwrYw/BW1Hejr6XFZvimA9xVezODsI6/w67Av1GI2hvId3dSBqGha9j0vyqJRb/2zbyK+FYkfB1xb/ha1VVYMpAZcTz7rtbfDgczEShOHxZecnLW/l68vCDp9iPsTSchaSxBdjfT2BqgrqJfzSHJRz7Vx3pEAJNIXOd2y/x1kfIJvMhzHnm+hAR03JDgcv1SNihbX8SRx8HbQiAsBankuaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pqf2IOj1WOXLjQkPdAJDkfvT7u2wGjnS1shBu63x2lM=;
 b=KXpi7vgDmGYeSvueGxAPU1Cqf44tlXPQsUOOGFVNo3w663Q5/Z1V6Jgl7Gg6u6Am6iXEsQ4AmWPW3Vi5H47ocHyd/XDfcvEvc3NhaxJVB6g/n0/7rLvCnEmuZ5PHT5PjKTxRmkPalCJzx4yKFUt7UAZMsseLWSC+zk/DXeyxSHMxkSBHh1B0eie3dU6cJPA+JnAH6HcJd6v3PekPfBkBqH9fMsUBi6YwMg/M2FHp619Z7x0fN2/Z65HYX2Nu1ECTlRLKRA6+rzIXf4AqgqIK0/c23hVQUFEPrKEhhly5byGHkXDPUO6jU+6C8LJFbNJpSU8lPjpxenMFkMPL3W8Uuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pqf2IOj1WOXLjQkPdAJDkfvT7u2wGjnS1shBu63x2lM=;
 b=dSxVUEgTiF6FGVkvcKF9tNRUjpGd9blcHk7SP9vyOXzvuDEeNd0nUNwKY2DhCpYL0r2rexowXxNulw2VYGHO7n+YPjZfN0fpWFVRUfnEDqwb9JSY+fqHbWUZHThFaupS/frOwYIHs8ecnKl2+VmY8156Q5DFsjBoHSz3FlZ9uVk=
Received: from CY8PR12CA0052.namprd12.prod.outlook.com (2603:10b6:930:4c::27)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 19:52:47 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::1e) by CY8PR12CA0052.outlook.office365.com
 (2603:10b6:930:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 19:52:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:46 -0600
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:46 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amd/display: 3.2.264
Date: Wed, 6 Dec 2023 14:52:34 -0500
Message-ID: <20231206195234.182989-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d977c6-0826-43df-c263-08dbf694ebdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rj4mC7LJqdeuos5aHKYxFyiabCm/k2rbyxq2A4Mwj98s/bMHsJElt+9k6yA/+VacMMys6S/5ZHG4voUY3slxLAWJprJXu09tfh6NGcohslx9k62bo7T1h9wXK/1q3EYYhVy/NXcmPzOgRWpzVOQETKOtdP3b8FTKcNK01RpF1j1/CgkcF25MWcqGl/6kYWjfat5hk8mkYdtulfNwqZPhjV9JeJHNLGU7MtYscSM2+BHaykLLQSB//vOIq7RnbSS11TKfoRA3vf3pEH9XmsInCINcTPSAbWZ+d+iycOjPXoUF8pNr5o7aDWsSqcwCLbAwn4WCYMT/0tSInZSPm+SEqwA18KYbqzSoaT8ZPFWJ+LCrMwS0MYJuovTx3QXVQ6ONwNDY4FwmXirVKDQ8GzVcpqOqc6fTD5pvEGGYr1gL9AOqJE0kSPjkj5PB4VD5pSCZOl8uxztkXJGgUfXgR0RfigTTOpuEbnqFmlB9yySe/GMHsePha53BX1y3fGFwLRy5jAPZbQvwwwR+d3ku5HmYT/q0OlMy/uxsySTc7r/8D+CVpc1uK5zR++g8I9LafPXcHwhiOhG9S6WXHaaTi3Yqa6+nbitYhKplcuoQHikbmHEctVxqEIqzHB0V5dc+JXSzggo7UTMrHHmjYeHLAz9YNrYzwQ/bviQ8ESDurczjejcCGd5hEpF784Ox8hYa9CbY9hJFFcsbGLXeCIZ3xP/071O1sA7e1+JY8rsGTngBDnRPHh8JBzHszhl+MuEE7Af/Mfa3t/w0feq2D9Ke9C0uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(83380400001)(7696005)(426003)(40460700003)(6666004)(1076003)(2616005)(26005)(336012)(316002)(70206006)(70586007)(54906003)(6916009)(40480700001)(5660300002)(2906002)(4744005)(4326008)(86362001)(8676002)(8936002)(36756003)(44832011)(41300700001)(478600001)(81166007)(356005)(82740400003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:47.4825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d977c6-0826-43df-c263-08dbf694ebdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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
Cc: stylon.wang@amd.com, Aric
 Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Summary:

Bug fixes for:
  * DCN35 power gating
  * P-state change, & prefetch logic
  * ABM
  * DP 2.1

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 61d08349a0d7..2c85f8ee682f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.263"
+#define DC_VER "3.2.264"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.39.2


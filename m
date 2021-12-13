Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6411C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 19:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9DD898F0;
	Mon, 13 Dec 2021 19:34:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F574898F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 19:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSYlyAXfmR2apa1wuvV1OnctRvsz9EusI0hs7yy2z+ipzQkxL0YEAkVNVrBoBXJk2jdsQt+O0Aa4mcAQ+TgVIukHwrt0CLyCoOP0DKqJSiZAgLv8Qnn9ekjtg2S+1ieJ8DZl1fJqBmarfcBMWXVz4Xbelbjdj1IyLukAEdyiXkf/S1LKXdXepEP9ncZeOqGlVbGOiSrtSGURlxMBjIPup+RplVy99l2uX5XdK8Wl3OYglcc59flQea0hufJf+dsVOtUc2V3wgflggxXAeLnwMj+rUfv3i2LgCv2WpfhJ5Sa3vXCptZqPxlQuPkWo21LZE1VV0VzRc7dCzyV+fQvk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNvBVTwgIV/RzgvBtwcasApqIFilSldIZMmHRuzHAbA=;
 b=oDLeGDenrm/rF6hvYIhFOGNFKoahgYeIbwP7pGd8QYWmww1E1FJmYTfOImNUwnO6bs/4qiyfFQxLa37nem4CB47Y6lhzJfyytOgdNlDlzJo2Vn1NhkLG4TISOosEjHcF3k2wFqpUnYIJDBN0wsch8spIrutb4gRwkTeIwD5uLrllpWGzttLW2ZOD0uvUiQ36Tj+EnT0ffvF0NSFslgJ/dP+LCGt7B7rKuHVVbDCSTp92mzi1vxZM5wiXJ0cNrHN6YUJ0HJ/wUqO5mnOH8g4Y8S2DgtWS/CagQERokYYO2EJM24c4fSuaChRo8RCEmIoLKzo5EBmufADDzyzZo2PqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNvBVTwgIV/RzgvBtwcasApqIFilSldIZMmHRuzHAbA=;
 b=nKe6v165lUvZSpGPQboaMO67V6BkVOA+AslmXmnxRrKfhwMcFDPt1Gik/GPBfqTAt8Ww/UQpPaDVx4wcmctuLhzUgzDJDWDSa1wn9NJ3wm3ezFhHDuxtIsHFmbfz5PGAJIbRQ06YX/DZb/IPSd2ImFPbC2MAUWrQnXNcl3mH3Zo=
Received: from DM6PR06CA0090.namprd06.prod.outlook.com (2603:10b6:5:336::23)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 19:34:45 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::f5) by DM6PR06CA0090.outlook.office365.com
 (2603:10b6:5:336::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Mon, 13 Dec 2021 19:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 19:34:45 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 13:34:44 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Enable unique_id for Aldebaran
Date: Mon, 13 Dec 2021 14:34:00 -0500
Message-ID: <20211213193402.96278-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213193402.96278-1-kent.russell@amd.com>
References: <20211213193402.96278-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d2f2d65-0ef0-4930-324e-08d9be6f9e4c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42791AC8C7515FEA428EEF3D85749@CH2PR12MB4279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Clc8j8IoDHyFjvGadE378vFwMHBhfKkymKS4N3gKs0w3gMqXlSQ8y9ZCeTeJivhOM58ezSDtQx0xpOHn6PNpdQ8swa7hv0XBdKRsJoHi5pF/SGhqOpunQzMFHu0FSBoxN6GkA3hlL9FGKc/UiJ5dcbtk/lFRmymTZlATlGBNit9ljuhANttQ9VfWk0kT2lyYhz0R7YVQL86SHm8RZe9A5/6pIJXwqaOBLrRXAFtiJvdil2yYA7XkwAzAJt0caMb+CrIst4RPGXCwPUP3Dg8O2iKsxkVDG15lT9vgO02sfY+P9+IFKYGbw3ITEwvqT61RuD6wLtm7LssSoSQvT1NcbU8NRGLNwf+WwSNHqDHZBp9jlJJn+LOUBjFY46pua+n2G9FU9fy5xL0SgVuEla862Ckq9oc/3Y1W1TnCjzSS+/522jzn0wSP8CNZe8dHPdNnrCujmb1d3HIHHC5J4jkMwNjNODgcsovO5BVNcko8EQf6AZo1nrkklKmjyhvnli633RO59bu1mhv3ro1nsR3wMvlq+YXvjCUPbmN5u7XhHc06qcuET4KlglT6aaqfdPIpBQMbiHWTgztRjBkyift+xaHIVGUiEUtXbvAQX9448mK+/vE8vRAS1vzopPnQqB6MCeye0rG7dg+jxWlX1RjFLVOD5b0YKMgehhJe9SL0Hj9iiyX2WvglZQJSrstIQOi+7elile8a+B0MbIkMtYYRK3I3bF5VizHNlLcI4y/SppgMNPKB4inJOt6rb3/Tnl5O/TQ8VMPbimrWWr31rYqXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(2906002)(4744005)(336012)(426003)(8936002)(7696005)(36756003)(44832011)(508600001)(47076005)(86362001)(82310400004)(8676002)(40460700001)(83380400001)(6916009)(70586007)(5660300002)(2616005)(186003)(70206006)(6666004)(356005)(26005)(1076003)(36860700001)(4326008)(16526019)(81166007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 19:34:45.5295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2f2d65-0ef0-4930-324e-08d9be6f9e4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's supported, so support the unique_id sysfs file

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 082539c70fd4..dfefb147ac2c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2090,7 +2090,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(unique_id)) {
 		if (asic_type != CHIP_VEGA10 &&
 		    asic_type != CHIP_VEGA20 &&
-		    asic_type != CHIP_ARCTURUS)
+		    asic_type != CHIP_ARCTURUS &&
+		    asic_type != CHIP_ALDEBARAN)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
-- 
2.25.1


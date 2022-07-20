Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD40C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 08:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445FB10FDC6;
	Wed, 20 Jul 2022 08:27:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B2B112A49
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 08:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TodYxEHkPs41YhXG1skwH0UdnGz5o+5bmc6hdb0tYiSRpJDLYlRqDjNlKEkafL7VG4UyBDu5yqb5XoCZg4NOHvQKJk9MbY34OsB7K5yHhVIn0xDGB32ExqFiM4Phit2At6PMXBEdDnREpcrm9P8HjMb6YQTXsr50zgx4HCi+e++SAPH0HoX7ALDU0GNkKoEophrXhBZ2wtcsRSxHtTktqph+8KPdODxAX19YsSKTRRX+M7cGxrQ31411AWnYUhE2A4fUBYqI4EEMzyrbiIqwVS+juT3adzQeLV/LT95G0Dx0n4Gbo2jNg+9nZPRVQZLXqkjDt+Yk6LPlQKRi+fwE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMKD1tXA8uq5Dh8eoyIrUzqsdLkIjZKWFmalVuQg1sM=;
 b=ADkKnvCMTHzzs99uLbNbXgnqkpxheGy1dd+oENdmXobzh+m9xy9gkmjATXBi7VVeYJW6BOVG2N0MLahE6aHBN4uwjpiotzakNk/EFP8HLS53NfM7oaNXmj44gPpOiYett7HJFgdjywVSBVE0BfsnNOmTpvEYYyFWtmcOPBqU6l8Ot5GAIcYsoSLSWM41M+px3US1lYMNxeE782FStrIwm6TVTtWGCkTZ2vT1QqF3+F61N9S4+ybEobaTPoupkbapTteCS+wrAwKf1vijEiVkrrvvFpEDDKZhwkArn6GKlse2dXiLggD4HEj6U0ZJtC+JyzeskXvAgeGzWkRWREAE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMKD1tXA8uq5Dh8eoyIrUzqsdLkIjZKWFmalVuQg1sM=;
 b=VbuPVHQQ34qqFNO0dRyZyNUp3y1BiTOQu1sMBoAi/CfoKy79wDxXGcZYkCTkC+SWUdfFcFyqNfEKs4KMvdGOS1+Ad0t78/0oWZObzKIg1RCGMPp1mpLM56K+FdNgsE7Z+GFgKMB16pLuou/A470HTtE6Lc4w50cUT+OLYY+WK8Y=
Received: from BN9PR03CA0235.namprd03.prod.outlook.com (2603:10b6:408:f8::30)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.23; Wed, 20 Jul 2022 08:27:13 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::b4) by BN9PR03CA0235.outlook.office365.com
 (2603:10b6:408:f8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Wed, 20 Jul 2022 08:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 08:27:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 03:27:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 03:27:08 -0500
Received: from roy-X10DRi.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 20 Jul 2022 03:27:07 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the incomplete product number
Date: Wed, 20 Jul 2022 16:26:59 +0800
Message-ID: <20220720082659.49637-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a35e158-8a14-40a4-8a0f-08da6a29a571
X-MS-TrafficTypeDiagnostic: DS7PR12MB6215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+lM3SV0gsjCucbMxkrQyDn/aqF8ellsHhHE4VSbYuy6Dz0ABweLqh0Kr9CnruofQL9H6q3Obw6kn1NoF23S7GCJ1mlraSwexXuXrNsFsF2hHNODS/f1DJLX647SfxEa8steXoHYDX1hyptdiuESLAjIt6lNSdqOoDRji6ABcNed5El3iH9C7LssatbtAEGOvg9tSk+YQBOco3l284LkS2Ml547DYtsadAUypaGl2jd+v88vkdlQQ5VJ16lWTC5kMFJ7bGxeRMhM4A2N3HSsjOMA4eLmnq1NDBY99luqUjWsf23yjIIFK9ukVKxbxz8S7UKcNjct1X+tZaGRupsm1dWAhhvoHlvy8l/U1+BQjxpsjsdB3Zo7rXkHgJ25Qe6XWimfH/HyXYvakTWK1zzzqbIQdGgQXgsUKzd/+aTIyFZoMV3OyCjb/3RgqaX/BStTbeQb2W3cPlgYttuxVC1yPdB4+cWyzHeGr9ou1b0KLJXeMvSMGFTIn6QPAPgwLd4uOs1eadhgkyA3b6KvRu84JuD3CLBKW5nhyd6EH0ahi/CEVU9JxUUlAa4OY89NGXu0G2RWQ3EsiPlnprtcwR6ZaIEdwFMjL0bPec7BGKAuxJ0pntOHtUUL6jwmyOXgsjaROKHnl2eT762mz7fGNrskzbwm7CtDKp9XGRl40fqc6yyBCphBv9XVterZgCfB6nuaqz2UxyILk/mLeS7AdfTNvg8d4ipWOUcWT71pbPn/ZgIlszuEIAkKMoF3Vv0U8wL2ncoAv9rrqtSAj3Jc//58n+LR2O9tQGB770BkLDpHBXGEhm+jOKHrb5478RCU5nIEzV8iKAox+m0ADJ3i4ZoUkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(40470700004)(36840700001)(70206006)(5660300002)(70586007)(8936002)(4326008)(40460700003)(4744005)(82310400005)(2906002)(36860700001)(86362001)(40480700001)(26005)(41300700001)(82740400003)(316002)(1076003)(186003)(8676002)(47076005)(6916009)(7696005)(336012)(426003)(356005)(6666004)(2616005)(83380400001)(81166007)(36756003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 08:27:12.7606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a35e158-8a14-40a4-8a0f-08da6a29a571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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
Cc: Roy Sun <Roy.Sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The comments say that the product number is a 16-digit HEX string so the
buffer needs to be at least 17 characters to hold the NUL terminator.

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9f729a648005..187e3dae3965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1019,7 +1019,7 @@ struct amdgpu_device {
 	bool                            psp_sysfs_en;
 
 	/* Chip product information */
-	char				product_number[16];
+	char				product_number[20];
 	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
 	char				serial[20];
 
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45D5C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356C510E9C4;
	Wed, 28 Sep 2022 19:41:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F4B10E9C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBqrsvbqKBji7yWlZVte9EzAnGdl5aA4WyMVwq7phDBs+IsdajpgJiO1vCMQhH2OMy8LWSH7NMg+1MDAxPGvgCsNz9iq4xegN37i5bBVtGarc5ka/kmJi6FXqUGrhyjIdZS9c3EfBKgcppzFX613hjf5xldwywTa0AI9aT5h+V7CEuOg1V60NJ3aiN2lEctUkNv3akDbySPjuXtyZbZwwlJAiFcjYtDukpARmLvl/5ro+l8lbyu7F2lnR7MoR+oTjaj4iXzTXXiCH1CSIlg5iRBXFKe7eSn1M485bUmvXHAXrsvbQaAD3Ug77R1WqTK+vZX8XbquEI5XHLjb8uTuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB6jcpdlLsQNvSRwD6Vj4C6CF3Z1TuXEMxp/3wnSNOA=;
 b=KRL5XDVL3g2Wkn+4xlBh0TtoKqWa1Q9U2SLw41ufLZ7/EZ7aCi30SSGiaDzVK2MmW5lLSl8E/10GVBDwT+dM3GHb+5hXTxQrFRYIHk9QZuNtpqZ7saGGhXiRC83c8kuC6GHoXS55rILg3zxE+vEiS+fU63pJEL5jrwKWR/IJv6X1CUd/kjU+5VxgpFJ5l0/t4pc6TNaie09fgaF/af4jSHGNoa4nPJxZVdSb7rTZ+mww3QUHjyqVtH5lAgYdcsCeoIpKREJSzqIQNqfX5gscWhpQ+fbBKIpn+cAnM+wspPqyRMXbRzaEu4Qe073XEOW1NqH/KjWwqDyu5TLAPE7pGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB6jcpdlLsQNvSRwD6Vj4C6CF3Z1TuXEMxp/3wnSNOA=;
 b=wPia89HgQz4ZattGExV8GTMFhqq6uNti2b71M2or8W2TA6GZQcV6B1WkkCcLkyn6CjMGBmXl4lwpSeeNmiaGaDZmtHvTe2AjOxvFaNJK8AEl8A0dCLMIrF9g+94TjQFu4kPDbWbzndFgg1WbUYs5dPl9na2ibjeUV/nGU0TQUrs=
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.27; Wed, 28 Sep
 2022 19:41:25 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::1f) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:25 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:23 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/36] drm/amd/display: 3.2.206
Date: Wed, 28 Sep 2022 15:40:14 -0400
Message-ID: <20220928194028.144879-23-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: ca91b400-caee-4e70-22f0-08daa1896df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNCeWqeB5kz6TJTqKe0RauGHwFT5xPGIT8Na/KmcKx5ERiNHMenGGDtmTXiB7FQeO264ugGTwImzaeUFVwYtRMbuYSgdwL/1Pw/4ZHs7DJkOwfFfGBEardAOxiavxuraOeVcc3kglTmOya5Op+n4CMrQcswTnmiFK8QSNwjqQivJugOZSR3ilGnGxdxiYM6os9fSSrzOyNqWLiaY25nsIOIBLZf5/56Wd/GwUZzibISW6T/32xuw3JkfVTnt7kkK09Q7ji8xxWoeIUunJbTp6hD4wSyAdaIBHmiXm8SyX7O0dd+zr50pYX+XwMBMmzKbh6v3MaqWR6vkNEb2ioUlZYSPXSs2qJFHOCk/+z6qjTfS2vjH9xwhlDfUzijQaQv8L8jhVy5mt5NqxQO//VfyRX+N9T2I5P0orPkpvVYElIdH35a4LMm/sFSaCPo2+AZd9qAJX9MjMW4YlynT62oc+hjsDbvWz/CFp9N65EoZbBxTX5ZKRk8y9ZQZ3FvvjJYFaGHkvT+j2E7lQk3YON0AxHKcb1ZWe+2aNd5k1SLLma219gpju4so9XeW53PiPqiFRJl1qipZZjYKTAw4HVnGK8l3OuYtGcpmgDbfCKtXI9rOpMyawuNvGgVdhM1ACH41M3H1XH4ASNDA4uj+HA2Z0GwfaVVd8W3ZuD3ZwtWvxz4NGlcSBgSuodcYOfrwjyDU4pkkrwBVOniHuiFT3HiXWuGspb7/k9Etfh3hPcF3xJwZNPL6DNBtRYEEEKIcMWA+bx4xaPMkuludUwHhJwYqtSpTYUYMcsxS21GQ3MoGQSwDWrKxIegnBoOtspGpIl2h2wFcwUf0Qmkd/52jo5UwjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(8936002)(8676002)(356005)(82740400003)(82310400005)(81166007)(2616005)(36756003)(40460700003)(70586007)(70206006)(40480700001)(54906003)(186003)(16526019)(478600001)(7696005)(4326008)(336012)(83380400001)(426003)(86362001)(26005)(41300700001)(1076003)(316002)(47076005)(36860700001)(6916009)(6666004)(4744005)(2906002)(5660300002)(44832011)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:25.2963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca91b400-caee-4e70-22f0-08daa1896df3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following:
- ILR improvements
- PSR fixes
- DCN315 fixes
- DCN32 fixes
- ODM fixes
- DSC fixes
- SubVP fixes

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 458a4f431ac6..66b7482d2e72 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.205"
+#define DC_VER "3.2.206"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.2


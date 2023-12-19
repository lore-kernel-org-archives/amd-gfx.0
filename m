Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FEEC41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 13:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA46210E191;
	Tue, 19 Dec 2023 13:38:33 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF87B10E186
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 13:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0kx5YeJpCeQlwIeLZvnhuBDH3Hxi6vCqbMhfpf1NrpVvi11Tw8ahoROGlLID3vp0Y24KqYqP2CjN1xHsIZ+w4Mht3pLHmBlCe/X++Q0VyI33BcIjLyxIU8sTh7kb7CFwqcatu+pdsEwohbIXY4ywEhiQPeAbq5DfNiHnUhDHVEDLTXInQFhA2pfozUSuLHj1mhL9SV13W6A2vFt6ZvMWfboIvuea1hg8ih9EOlQS+jTEhF38nT+HtfQMPu1j9V+YtpZeK6yIaajYhznz3YylHwnrXwFTK09RWVWE4dfFJBvb3Z45OP/b20ZsTYvWYK7tFEtomE7C2wjmd2gWzH44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyNAMKZah2tQ06oHuB5kLBXJe1AEBUGuLug8/Kw9giQ=;
 b=HbX4VE+ZucjDdi0HUrKVXIb14N0j0WCc9zKeK6FS9By0xiLm0pvg0djmZCUiB/WyVRPgw4zyC3T7bof+c4dMmmFicJCO869vkrSFFPOdikCBT6wpSyJWe1TRWNvLtz6PV5yfiesnJpfRm1UImzsgCYlfVmCXbpEMWgIhcsrinELjpoK/bzDpXReI0aGVksNhXVaxd70zHU0jFqMDeL/QIpWEV7J8BEGCDgxIpgTmn9+Ivku30TttRKChJe5WJZkYITBrOhgaZgMqX25pdMFWxTkNF4u/yJyYJ7UQgiaCvxDAtFrnWCjHFVFmkHssyEpUe4wGKa7vocBDqLMTB0/W+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyNAMKZah2tQ06oHuB5kLBXJe1AEBUGuLug8/Kw9giQ=;
 b=ygo9li24y36Xr854Ad5JybVW0hB+8ArQfH4LVjIlEVxY2oAHGrmXukjfwWBMh8WxPgOwX33QRb667OxrQ8HKCxbSgNGkIpzkprL24ivx73MLHmAcmZLWVKiB8DYDlB+QmDHsxVpkibhJ9x4gUVFLpeJ1ggiAkIJCS2jHZa+G8QM=
Received: from BL0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:2d::27)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 13:38:28 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::19) by BL0PR03CA0014.outlook.office365.com
 (2603:10b6:208:2d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 13:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 13:38:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 19 Dec 2023 07:38:25 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Cleanup indenting in amdgpu_connector_dvi_detect()
Date: Tue, 19 Dec 2023 19:08:07 +0530
Message-ID: <20231219133807.542179-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 9671130f-dd55-44b0-3346-08dc0097c875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQzYW4wKZKaT15KD3u5z4dvXZyIPX1Rgu/t5u2rzztpVnJHOkReJc4eLdkSW1zUvXrls2pZu6y8M7vBQnVLeD/W4B5HTQsZt15sGU8hlPlVGR0v3DjZxncJSTcUdJGbas2q8NdIXYHKnPpTRmyKikKgMmusAYm8dwox8vNboo93XA6EU7zx27RhvpIerU/BsG4Ks+/3iNOmSptB08Uz7WMoOEM4ZxunKoMP3x3+NBrrJ90TYaZ66yzAFwUNJhWG29SHcPdGlLHDVy+UL3mxqiqQwPD2+jQP77316Y2ofqeEAd09NvHMtUJDvxfokXvlJXUnq8GBzm70H2yinYG1CS4xyc1m5NyqClovNDrHHvFb7Mb4AZmTXxw1+OrMGnymuK015Obym9097OAOC3S610NjeTMGVHOmTRXPA3dLBEj/Ly5nDJwJrxlqKzNykLXUAkqPMWjCPNR6s658OPtPD0I1po97gkMQkjlyOgC60Idng/Q5APqGGQqeunrqs/5mTqzEwOeBC1CxKeXb/L0fFaFzZn7eAZEvbEnZRDh8gr5w8RJrn7T+q1dCtrh5yC20iwMKGVSb/cB10RvWJJrMNnAbyBOJeQs60C6QihOy7snMmpa3tIS3+z1oYDi7lnsIdX2LEIkZD82JZONgoKnFpPusgkjScBdeEriFtrvr+1gov+oSWT0mrS/aYsbItu4rHdaTbUr8UEImkupOuU9g5q/MReyic+1bDDasHqD13z5NF/tj1J5BEuLk2/yOirCU172aQoUUrnc3dwIpbEn62HQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(8676002)(8936002)(86362001)(110136005)(4326008)(316002)(44832011)(478600001)(70586007)(70206006)(6636002)(54906003)(41300700001)(5660300002)(2906002)(36860700001)(356005)(82740400003)(47076005)(81166007)(7696005)(2616005)(336012)(26005)(1076003)(6666004)(16526019)(83380400001)(66574015)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 13:38:28.2484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9671130f-dd55-44b0-3346-08dc0097c875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:1106 amdgpu_connector_dvi_detect() warn: inconsistent indenting

'Fixes: 760817a60724 ("drm/amdgpu: Refactor
'amdgpu_connector_dvi_detect' in amdgpu_connectors.c")'
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 96f63fd39b9e..9caba10315a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -1103,7 +1103,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 			 * DDC line.  The latter is more complex because with DVI<->HDMI adapters
 			 * you don't really know what's connected to which port as both are digital.
 			 */
-			 amdgpu_connector_shared_ddc(&ret, connector, amdgpu_connector);
+			amdgpu_connector_shared_ddc(&ret, connector, amdgpu_connector);
 		}
 	}
 
-- 
2.34.1


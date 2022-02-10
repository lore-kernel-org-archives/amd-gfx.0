Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C506C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 04:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D087310E486;
	Thu, 10 Feb 2022 04:53:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D9F10E486
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 04:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOMjHw9JO7jhAXtXOVfkn62zSqbeOlME48kRpUJxYbLEPUAwNneDyZWGI0DnLA+tk7D1/u7hVpfRiWj9afBk/BCbqcKcVhevbxhqp/FSBJkhrHW+9YE9Ht1LC0cbTfcloftj+k0ZMH/d89yPz/fpMcQey/8Jav2+eTSoG3C6XlTSQ8iZGLg6Xp7X3ctUFjPgiWSkHMeFqpeZNpMzz4UUpgGRPmmPB/nvBrmQ3P+HVgRwRnoWEkBsnA+Xwy0TdnZXGppm876CVa405+v0ETnOuquEl6BegPqmrC9zX3TBFmX7VylHxqGoD7eupktB0SEUMgqPwKi807bF8u2VDQ72/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL/kih8OiLSZUm4sfShyJ8DNdSqTpABw2PxhWfcb1nY=;
 b=NFRHRHgpcedBgWNbSuP221XH45ueDp7ELmigETbqX1MZ1nIGPiqSft1dPz37hODyGtRaGk7O1XtNqoT1aBLO96OxCT8G3Guu7I8mxqrncR4dGYelARG35pJTv/rNzGepzlQ/8EKpNL1Hz/1I1YKZ9SsRaiHkeeH9oDV4mfQUfgfV3z/gLPy3WkLvheoCGZeYP2TVaCVujMxygluU9jB4RQTxt7+LALxpqt5oEXdpHn66ztjtAxLMRM8SBpcTRSr+A734gZw6BTWOSlMHOQYIkCGB8NjZmpLWz6+Wi9hoosRKlyhaNjBxis1eTsKyLilpEmklDrAvN9ip4ev1iEjGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL/kih8OiLSZUm4sfShyJ8DNdSqTpABw2PxhWfcb1nY=;
 b=skLgnH0cjS9mKydXGZd1To9NgnrIIDf4IUeHxya1jJ9f76AKk4hzoBKk/FBVR1XWxQG8BopcYBVlRQuHNX4N0rVAevs1KpsH0rqqgJLQb/HlBZliN2naNyv7EXX30IWarEt+FdBVdAVUyLuqDUQ5vX/EEYPFtJZCvniiBQksgvY=
Received: from DM5PR18CA0093.namprd18.prod.outlook.com (2603:10b6:3:3::31) by
 MWHPR12MB1296.namprd12.prod.outlook.com (2603:10b6:300:f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Thu, 10 Feb 2022 04:53:30 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::7) by DM5PR18CA0093.outlook.office365.com
 (2603:10b6:3:3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Thu, 10 Feb 2022 04:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 04:53:30 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 22:53:28 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable xgmi feature support in sriov mode
Date: Thu, 10 Feb 2022 12:53:15 +0800
Message-ID: <20220210045315.1578274-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ce98671-c846-4550-a435-08d9ec51488a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1296:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB12969A8A56A55A1F36C01D12822F9@MWHPR12MB1296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPcOBZvIV7Q7zPi7kPfAdWMg2QCGwK1FGjZ0dyhZPES26GxkPHgYvgZcPj2MurRdCQkIaHcsnA+8Hp3+OOEnS75n4PaipD2hAsAJzvpBmBLDVZu0YLKeNo+8rfhivo8OIwwwvI6E/epviLDK23eLwafPPncvL4Ju/HdGQhqP0zPYOIlmPrfKM5dgHnEYpfqTTou6o0YovAL0Dy+Zgdfkh2o4Zsbrdj0dyoPOzs7uBsbbQmIM7YgcSNhROqS3Nr1ndGi9djTR3mG7AFH4o6g9KZ5sN6PqF3lxZ1mGzdNtfwutYXxWRJaSlb4ApwcMPQe1KbyqrkXq63oNWDRrECMILNBjOAfx3jSRJF268yr7V+rHF+hdjtzsc2r5JDcoh11HyArKUA+HeR2W+xOzdkiGuUHaqLEuyS4Jwquul8fdF/ID3ahHoYUbTyeOJn1VoLWEYFe5wTACkxFpGo821iQsadBzIYktI5dQDzkyddEtvGOkkF82ZvBWxTL6Om2tHdlkXCmWltSqfxZ+4AkzJvY0Rkpg/pb5GK2g1e3Y9WeltBq7iVcp1SkOJy/+EQ+UkBbLRj6JwWeJv0NQpPLxLSS/WVrbbi5YwnRgD1oqjKU+4vIr+a2xTVjtcJsG8gwVSUTND3AbHttA8puvbsO+YuHOF2Y8RqMAvjxk7IuUw03cNdED7I1s5wzm6mF37I8cjZTz5q8FtSH5Fuhs0BQEIK6qzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(2906002)(4744005)(81166007)(6666004)(356005)(36756003)(70206006)(70586007)(4326008)(8676002)(40460700003)(86362001)(316002)(6916009)(54906003)(508600001)(26005)(186003)(426003)(16526019)(336012)(83380400001)(2616005)(5660300002)(7696005)(8936002)(1076003)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 04:53:30.2093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce98671-c846-4550-a435-08d9ec51488a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1296
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
Cc: Alexander.Deucher@amd.com, Yang Wang <KevinYang.Wang@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the xgmi feature is not supported in sriov mode.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 07623634fdc2..b19e36487789 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1271,7 +1271,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (adev->ip_versions[XGMI_HWIP][0] == IP_VERSION(4, 8, 0))
+	if (amdgpu_sriov_vf(adev))
+		adev->gmc.xgmi.supported = false;
+	else if (adev->ip_versions[XGMI_HWIP][0] == IP_VERSION(4, 8, 0))
 		adev->gmc.xgmi.supported = true;
 
 	/* set NBIO version */
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321CAC3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F6910E55C;
	Thu, 17 Aug 2023 18:11:57 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64A310E545
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLkXAujniJJb6MaKsoMiVvh6j9fw5DpDvL03i19stSEyccXD+MV2V11c6tmOJrSZQvgLSIU/IJheLWb7xXrLUWQn1+nsMDGxSp/s8v/vjK7wUqZ11gv92POTT5ad1+rA22MUQdPD11unCgwG1KZ4Qzdgwi+U2kB+nbWJWXhlHm+fnw3GcSJbtAs8PRUKecTLBgJ0jAZCia4Swx8ejmrry/E7FkVKv1UIQwG0ZKhh+fL/BMZAcfrbeDVNi5tzdMvdfwBhE57v+bxD/bZd77xgfHM4I4GtPZggyHMduJdnZ4T5aZTQbp9ZbvDIOYPbJAarzIocX0DKX6XT45637lMYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSPuvUZY2/oXMWglFMM+iGr9gXnZnte5R83KQedvpHQ=;
 b=dJG9669uX+F3CDlVb0Fjfu19a/RYZQjC3R2XZxYKloEAu0AxDLyAErz+3lmg1Ejw5A6VSIZTeBJpeKQj4unqDQFeOT4nyOuesRT0iLBQFtVx2+HJD98Zz0XDOHpJVwuh8Cvi9sRt9EcPq/xD90t+3dqvD+sTFBUtLcaoX3x9jO3NqNGr1gS4wsSinSz1gYKy+XbCj9JZloyG9MA/pkYYpgcG45Xyn0hX/DLih1rUnbnwL8Fe5XPMtFVJL6Fk7rgCX+r0O/oZ/5YtijsXZbERbhQTIo7PGuwfd5rjREteP0t5iHjAbTkRzamPO2LqkJE4knSP55xiL7fN/JHjX0qKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSPuvUZY2/oXMWglFMM+iGr9gXnZnte5R83KQedvpHQ=;
 b=13lbKF+MHWjXj3QPghIJwJgNVzBc5FVD/Hw4T5Nt/wqzMOOavINavfBuM5AbIR3lL4TI8RbngJ4Sw6By/S4OGIUjlhb8boolcVF8/fkc8zcpfh5SbcgZ/nJvhsv7z/xE7C3n3utJE4q3DMhDzSUUEHNj3KrWbjU6BUPy3s9n2o4=
Received: from PH8PR21CA0002.namprd21.prod.outlook.com (2603:10b6:510:2ce::16)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 18:11:45 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::ea) by PH8PR21CA0002.outlook.office365.com
 (2603:10b6:510:2ce::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.6 via Frontend
 Transport; Thu, 17 Aug 2023 18:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 18:11:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:11:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/9] drm/amdgpu/discovery: enable gfx11 for GC 11.5.0
Date: Thu, 17 Aug 2023 14:11:21 -0400
Message-ID: <20230817181122.1543473-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817181122.1543473-1-alexander.deucher@amd.com>
References: <20230817181122.1543473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: f31c3805-83f1-4df6-42bb-08db9f4d6a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: og+GtZp1wBOHANLQvj/iwCE1WwPd3+7fLD6Ns/quiHHAehI2S6sJJW9GaxRYiDxTJJ9BVXLMXO8mgQujSW5Sn83Q9hIMaQVAuBjWN7R7vAh2IOFVCzqlU8mLxdKQMrHOtFVD3q/aPM2ZIqKwU1WNp/EF1n4uDewwJN3YbpsIYfe928/VjHdNV7GikmFsuz5TEY9Dyxpi2NHCLh4hX2VWgO0iRvZpGSYhM7yf3zJ+gKv8Zd8keK40RsB/9JY7l4uRtIv+eB7YFn2TK037O9ZneXrzNqg113qbZcXHQB3QCsQiHEsL5f7XRbhM2cS1YRzcFPJu6pXsKArKZxJFASfULZTWeLnEP4bYW3ecaDh3DMZRndLE/F9JV9H7TzgCb/W9qakLEBIeh02bdtTOWUK4ytJ9/qPIM287U2S6i0cuEFNHCVAhl++Tzj+aJYclSlunxAG0FTD0dMXiClw1URUc78Pt70a8N+hcXEXJVIoMyH3I/oxIdYbVj7CN7WUODqP7zkSdbQiFoBZX2pl4iTkvF3BZ+muBztNGR/pJfZYGdMDSjAFKqg8B/2VQiABrWwTszkRfFQBqvMuJby4fGcI7tUYjYoI84v1SfvDygMLfHDNC5F6rtBGcT02byfZc45xq0/X+vU1Bji37rB64PDW9m+fXtiQO2FRICLc4WDTBS9ZWjVDPVSn3f54hYgyt46aWNvTXeHSKdGk0B97I6j267gF5hRx6HqNMqFNO5JJBMW0q3bQyCYqPvmMsSFSw8FMjOlYO+8qogCqhRpBTti8kjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(316002)(54906003)(82740400003)(356005)(81166007)(70206006)(70586007)(6916009)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(8936002)(4326008)(26005)(40460700003)(2906002)(4744005)(83380400001)(16526019)(478600001)(40480700001)(336012)(426003)(86362001)(36756003)(6666004)(7696005)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:11:44.9341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f31c3805-83f1-4df6-42bb-08db9f4d6a6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add to IP discovery table.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c9b688d372a7..5c4e85ad7f8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1926,6 +1926,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	default:
-- 
2.41.0


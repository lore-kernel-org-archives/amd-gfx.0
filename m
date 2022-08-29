Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AC8ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41AEC10EF7D;
	Mon, 29 Aug 2022 21:16:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C03510EF7D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT9D2wQwt08uRfXxh0zK0iknDRMb9ozkbVGWPY2KbFFhwVXtrMpcwA550MsC5ZOuLLxsDZpmwAUt6pi2eMy0orWiKQLm1bo2dX/D5vdgUkH8AP+Rq18ZneMFj1be9QQY57VcJv7SVTATMVkdjCH5x9i110L5YYuqoPtzsYqE+cYZ8sniYHZiwjBS0p/nZcfoluv+locY/H+om5gYEcHHMb4mhBWDFPqvJIglsEuwoqElT7pieC3UslouBmfM0/AZxHQySHq9I8ZE7P1atr/EXnh9jSnAyq5IBXR2UcsM0WqhDoYptYHumM7/hDYJoIfGZ7pMOYgtokJxryCi7PR1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWAMZ98a9WgQIkBnie+t2Wx1LrzJvdkpDjVImf5m3gc=;
 b=aUcDxC/wxJNg5ZU2BAbeoyxYaABoBYXBN5AYixxs/soqTqPAwTiUP+dS7Zr/e9Wga54IO8f2Cwf42lEzRXYQB/hI48P1SLmyi4aZgXUqat+4u/P+WwKsBhmv6Sx5OtVRzt1IJqeBbKquBB36Kz+qpm9F0wgYTvV5EshRHt94GYIXzOg1JmrmnckyWR6UB4ZoZ0//2zd5e1DgZNWLjlfvXB0/FUKMk3MM3wC1pB76UcILKfOBuD7WI9TFxya/APy5uYpVR2uNM/xFKXzOTGqpqZwymDIVXuyPbhWVf1GsZgqb3wn/9icwNGoxNya6wgYGKaKt9tMb6qZtJBcjjhEVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWAMZ98a9WgQIkBnie+t2Wx1LrzJvdkpDjVImf5m3gc=;
 b=r7YY2KGDrrFOsnKsjwDnQvWmO7kCjE6A4UEJvRKeVZOUpDyXs3yPEe0p81R4clhNX//EM33d+5SlnnqTIO1ltVKcaKQneMiIiV8+rfnx86SHm9eWkCYr9ByEvUR6KyMqsdL+iKBnhmLcl5etQ2QkjlKYDSiOuVfEJec0gHyHQ7s=
Received: from DM5PR07CA0056.namprd07.prod.outlook.com (2603:10b6:4:ad::21) by
 CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Mon, 29 Aug 2022 21:16:31 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::70) by DM5PR07CA0056.outlook.office365.com
 (2603:10b6:4:ad::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 21:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.7 via Frontend Transport; Mon, 29 Aug 2022 21:16:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:16:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: add new ip block for GMC 11.0
Date: Mon, 29 Aug 2022 17:16:15 -0400
Message-ID: <20220829211615.1152396-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829211615.1152396-1-alexander.deucher@amd.com>
References: <20220829211615.1152396-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1911c3e-ab2f-497e-906a-08da8a03beb7
X-MS-TrafficTypeDiagnostic: CY5PR12MB6575:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ge4Ssec1p4S4vyI7da+22S6+ETmSLbF+iZN970FZY7CYSCzy0P6yEsc4UoX+vCrcXQXo74CJj5MSx4WNMZZGkZ1iYX1FArPmBrttTzyIDbRG6qC6JWsaTtOFLSw5e5gMIKoRsnIF5XTwuNKuqAnZDqs6JjmGuLCjk9qJ93uxFE+fXqjYd9a5rVqjGE+CdOtEU9LyjLFJv64sfhhw/JZ1xXJv0fFcGVeptlaGi0Oy3iroJB3+KrxWdf5AP+g7Wgqfi7fHKsefwHFVjKjt4XpRDjAOYaCUnTFcpgIFqdrt/SCI9wcNgEORRwvnxhEcPKzhH8UTezm+HbuewBLAuVCIKIBQcT+ZwNHnAJSneffGuzDH+pAFC69364xbJrNflAz1JuF44ObcECZZfh7ExuqWTJG0d3CnyMADAvEzDVa5rzXzp3/ecYfKGLjxFwo4HhfNbxo4SOAoJ6zrUgc6xOuvmpv1owvIyDdRITeomGZ95kD6GlDYrjv/5g3Ajm+bn/kGQkKtvqQzT1cAh/zUb4WQyf78ScxvVkV/yNUWo7iFujCCdA0hoOsg+4iV3p4MbtQiFOV1sn1V4n2AFL3zhQMNqwnMZ4CUnJXZPJakfwSDiSsj/Wzb2phenpBmGysDzdC+CGBfyy0UW4YPg3OwvmXywoNiS6yh+VXouh5XT/CWV0J62gfvvlaZovLHew6m7Y3iyXeRJTPMyiE4Yg1D0nOaUxVyU31o1m2UeLGFpW97Hedi8ul3jsGUv0YAqSF7AmkM3r2gLOAsZ1JWIdLPA2eREPnbwcQ9O+4LVspv3YYDgtQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(40470700004)(70206006)(6666004)(70586007)(2906002)(4744005)(7696005)(8676002)(8936002)(40460700003)(41300700001)(336012)(5660300002)(40480700001)(2616005)(86362001)(36860700001)(16526019)(478600001)(83380400001)(4326008)(186003)(47076005)(426003)(1076003)(81166007)(356005)(26005)(82310400005)(316002)(36756003)(82740400003)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:16:31.4488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1911c3e-ab2f-497e-906a-08da8a03beb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add ip block support for gmc v11_0_3.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 709fc61e3305..a22b37495123 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1550,6 +1550,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	default:
-- 
2.37.1


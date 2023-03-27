Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9979DC77B60
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C5210E6F6;
	Mon, 27 Mar 2023 19:30:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBEE410E6E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFoDVs667xvwlQ0fxqSHYdZRk7ksqOwImcXaybTSuzuLuP+WSUVYOslgdJx8Ib3guS0pRYlzfF3KUpuLnOWoPf6tVNKCn0HXNRqZ6f6Ei+SEwC06Jvo3RbcmmtvxLor1QQtMDXZawV8azlInya7tY0MDt3TbzoxTYzarT7yXN+8XZwUUgby77NRzy6Csq9ie4Eg3Sv62sT77wRYhh347ITkuspJ+70tFazgtHS8eZSnN1j2OjcIJ741XuzampJWbmcmj89FXUrS9gNUsTs5jMc2UuIsWuYH2fXmVdilRpKIiDWJ1eSdJxTSWGAdBSFHsni2JbJkR/jrHxc++kD+dfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP2KueUrX6HOCXGGBLj/R5Fh0kqRq17KfT0XEEOyQFc=;
 b=FYUPPlTzMYFCByBLE7UtlIZQhB2tVmnUmO9XgTxR3RFnV0KFyVosRgxcGc013uJfPtJJjqg6oSPEWA/e5KN9HMUYeF5ha/iVJcgzEylaR5EljPrBEv4stIT+eDo30Rx3qcZdv45ncP2Qu4aOVojgTeCSaqGg5wN2SwVLvhwJobVMXwPUaQt1dMaqRmFKNvnROcYVLRMlI07OsVbh7I+NlYTJndBiMMejdzc/aOgU7uVG5q4nxIEBfsMI8qZsvaa/O/KYkpKBNd9Htmh1pGkVgPHTyVatbxjdX+X9X8kdKs6Vlp5BlNIGhbuleb3Qs8dkkDyvt87hrHRzdkTSjjrZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP2KueUrX6HOCXGGBLj/R5Fh0kqRq17KfT0XEEOyQFc=;
 b=uMYryl7Y5ggVY/4mOnrnQQp8Or9KJptAtVnYsnpg+FurG80lE+hhFCLlJTkerJLVrDrYyG1n8XM1Ff/akJg1lJhEAdKIzHzwCmoUEsJE9K3321EazJQhfnccrg9pyI4NEN92GvUiqoJbTxhN5x1AM/Jr9nyUFOIEJQSW7EpXzmI=
Received: from DM6PR02CA0139.namprd02.prod.outlook.com (2603:10b6:5:332::6) by
 SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:30:22 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::a2) by DM6PR02CA0139.outlook.office365.com
 (2603:10b6:5:332::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.32 via Frontend Transport; Mon, 27 Mar 2023 19:30:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:30:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10] drm/amdgpu: add common ip block for GC 9.4.3
Date: Mon, 27 Mar 2023 15:29:53 -0400
Message-ID: <20230327192953.7756-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327192953.7756-1-alexander.deucher@amd.com>
References: <20230327192953.7756-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 14dfdf90-901f-4fc4-34c1-08db2ef9b52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqbQT59IgAfkqvSQq57x+rtbN9ZvoozGly8aKeLH9S7jmmcHNrP5WBf31K7hVxu8SHFWkfcwpKSj+qqxVpBgO1ZvDE2Z+QsgD794TL3cIxELyPaxItE9paHU/JsIdoygd4i6Zxr7ZZAeCW3O/X7Dp03/bvJhSaWyC5L/uWdp/GiGL3CnoEhMEYhsNA3hWjkQtXP5koLSoORpZ/i062xr8SFzNO6fcImGC+e6zP8kwvFjFPRsqq+3qEYCtbZKfpzRNyTHyl1hRlmftvKee3mS10HOKb9ghWGhB2MQxkBSrJZiXtZqX0ZQK9zqinAOGw4KetI2Vltwn8G1bY8iz6VwjeOTiJuKaia9Za8zAq5TcPP2s4XkLkETNCRjAqlyHES1HAMcW+kVRIWQOxEoqB9I1dj5OmnXsX7MiG2LeAejeIvmyagVMzevTJoO76RbPyUvmtgieSt9LwsCoFB1VbnKleNymjFYG0NyM//lu8B1kgxieq7vUPygLN4gdm2QywqpOV+GG5VioAmFFFN3CqJL3xBE2MpSlW+9QwEZ6x3egVrAHFCeXP1rj2fIvrP54J5Oes/V1DJgYzcaopjBI1HuYCxVGaNgKALSTUZzArkii7w3Qh3wGgvIwkzDb61ar7dd+SfXct0IYW+f5h8CP3grDvlDV65/I4I6hXwDUXaQBS3FtYUSTq7syMxBTSj98STOWOsIZMwZVdF90Mxic5oOafy+4UIWqFpgvE1Hc0saVGw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(6916009)(26005)(40460700003)(8676002)(4326008)(316002)(70586007)(70206006)(36860700001)(5660300002)(41300700001)(8936002)(54906003)(186003)(16526019)(81166007)(4744005)(82740400003)(47076005)(7696005)(2616005)(426003)(1076003)(336012)(83380400001)(6666004)(478600001)(40480700001)(86362001)(356005)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:30:22.3714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dfdf90-901f-4fc4-34c1-08db2ef9b52e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add common IP handling for GC 9.4.3

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5139334925ea..0ecce0b92b82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1502,6 +1502,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 0):
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
+	case IP_VERSION(9, 4, 3):
 		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
-- 
2.39.2


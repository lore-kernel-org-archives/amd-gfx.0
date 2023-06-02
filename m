Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0547C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 18:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E3610E607;
	Fri,  2 Jun 2023 18:43:32 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E725510E607
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 18:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmM+jA2VxPED1XasCDa9d8uCWs/GketoV/dw1pFFq9a471oMq7DM1efBcIO+pV0fTnN2RsUR6XbI54vf+rirIUBhpuBQ9rbu7MvchPV7yUoE9aEKSPZA6mIn9DI1JcwYY0T/z6I6zG53x9L+ZSMRTiz4Wwm/AW/7Pyd/VzuBQXSiM7xB1tgSgkIVdCkBqgMguS6K4pqYKkLPB5cfzuu0h5V6EsVQNGPfmSukee2+ANeKLPnNbuaCsixrmhAkLHICkgb0ZmfI+VL5fHUgVFO64l53pYXCCzCRbxeK2wJIe+ArQ5kTpaGLMbR3FpLv9mGq4d9q7Xts1zfsSWflHWz/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOxXMZHuyaW5dsjDfUuftRAiTH2LQo2/aoa32FkS1nA=;
 b=dqip0aYMbQ85/PcSenQdwpwl9CAGcoBERlKYa/mYwfffJNj54Rp92fMKLMooOoKE1leT/HdieHuaIj1GwnKYpWtd+QH20DrU6Iu5UHFqF4u+D0T38VjffqWsU3EnYsu7lH50T00jpuPltnNHlDRo88I5rvIAFg000z4Q20myXuu0m4lmuIX1pOyoGV4zSi7fODIUMeTzFyLsGaa08OyTih6dr1kyynsoIbkLmOKy6iDRKIxNBC6waFQn6ETGeWN8X6oLEfCtDmEy+ki9v6AdPXl1mgqn1sFIWjVR6t9+HhV49dEs/q1Ql9qOcLwTgyPxon6J8Gs/jinK5TMS9l7Ngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOxXMZHuyaW5dsjDfUuftRAiTH2LQo2/aoa32FkS1nA=;
 b=zIPME/cihrgMIDmHA+f+fR7mC0W5q1aJNJpZooJRYwL/4Qda7c4JUsz89eKIBMBE4Hxw3E0gNfO5QjH5dTEsOkswH06coQH42RcVWCJzc04PYAh6sdxXW0irHo4W1m3m3qBUTn6Bjw97P38w0nFrW6tZdeIrmCa0+VOzI5e4DYA=
Received: from MW4PR04CA0131.namprd04.prod.outlook.com (2603:10b6:303:84::16)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 18:43:27 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::b4) by MW4PR04CA0131.outlook.office365.com
 (2603:10b6:303:84::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 18:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.28 via Frontend Transport; Fri, 2 Jun 2023 18:43:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 13:43:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] Revert "drm/amdgpu: change the reference clock for
 raven/raven2"
Date: Fri, 2 Jun 2023 14:43:10 -0400
Message-ID: <20230602184312.752618-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|CYYPR12MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: e190c888-7766-4b95-9ad1-08db639940e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAHLGCEyrL4V+c3HFjD/H/71iR32rJU7bQUrP7dxPGbadVPjlQSMDeLM196dfT4pdAgx4CcR88idrZ9dJu5oOhk0y7kMaiNGpRiuC2FqLt59DFXtXJwrxGm+uid0C2TW4SfjjFzLKuRcTLblI3pwMDM08oOZI1P3NEWs5PABNzPxYTCb/aoscuTNhr/+Kt5GkQln6SjpaeVH9sX+Sl+OlzBLjLH5TlQrsVq2vJbqnDa3pDPBvq0hFZ/vmyUzOrXUkm+WO9OjrjrD6nYcnFfbSAO7t4fUMehVVhEQ6SVwr/SAsAqHQOm0g5nkHBgbHtDz8pEafpSpmNqvdaAAUL8RDAKmXPT6ADrtvcUU0MjLhCl8ZBRZuACM+GqAtn0ScVRlZlec7inHO8sE/CWXAy9sGZr5MBeuilTHBxFo9CeqrAdTx7ISFAuCWmYCWyfZeaQDoXa2/3Ieggtne/qf2UyDE5JJi1DxRUAofbh/2KWyO/Z37AQ/TQCxLoqqJXcIeUmGfwALpz7abt+Jil+0I9/7QY0hu0PeFHfYmd+rzSog9STVwOLi7dwbil0wgnC7ld8yOsi4ntwEW2VgWhSiBBelBHHPa2oMXwwV432NRhAkfKIBlSc3oYGfef50XjZekwoZmHB8hjMWQjjLpv86wIMz/+tDBHApbmQ+3vXE5tEmIKNEUtq61QBh0enXGgQAEnZtoKzmSxUifiubQqCq2blMclnmZwYdUW1gvneozqxKkuY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(966005)(40460700003)(7696005)(478600001)(6666004)(36860700001)(186003)(36756003)(336012)(426003)(47076005)(16526019)(86362001)(82310400005)(2616005)(81166007)(40480700001)(356005)(82740400003)(26005)(1076003)(83380400001)(41300700001)(316002)(4326008)(70586007)(6916009)(70206006)(8676002)(5660300002)(2906002)(54906003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:43:27.1651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e190c888-7766-4b95-9ad1-08db639940e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jesse.Zhang@amd.com,
 michel@daenzer.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit fbc24293ca16b3b9ef891fe32ccd04735a6f8dc1.

This results in inconsistent timing reported via asynchronous
GPU queries.

Link: https://lists.freedesktop.org/archives/amd-gfx/2023-May/093731.html
Cc: Jesse.Zhang@amd.com
Cc: michel@daenzer.net
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 135440b5afe9..afcaeadda4c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -325,10 +325,11 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
 	u32 reference_clock = adev->clock.spll.reference_freq;
 
 	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 0) ||
-	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 1) ||
-	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(10, 0, 0) ||
-	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(10, 0, 1))
+	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 1))
 		return 10000;
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(10, 0, 0) ||
+	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(10, 0, 1))
+		return reference_clock / 4;
 
 	return reference_clock;
 }
-- 
2.40.1


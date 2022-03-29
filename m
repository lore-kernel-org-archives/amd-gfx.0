Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3080C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 15:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BCE310E8C0;
	Tue, 29 Mar 2022 15:10:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51CD810E8C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 15:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4RMFVHB15wgM3Vej0knfwyZO/09bkSDTSO+CdZojTdHpZwY2v2sZjR00K8jzPg8S/V8sVg1anRNmzhz4AkI0DTUrYRSvNToDAnIQCpLXyGU/qiBrylCGCNE70iNG8HN4xANtb8XQLNwdr6zLZZ36k0TcRwRLNjzS+oP3B5CsqWZhOfYp6NY0mx5KsvGnHhsD7pLDzyP6K8Lq273rJImZGq/Xr+iVp1brwWiQN2dpZdiG//RLd4yWm+33NiTh9TdENyHkGZv03XZKRgOXIbyyxhM+8y6UKrb7WqiE5vRlPyaO886RBmX+HbVEFoVbt4xZT+TDwHMkGYkS1AKgK57VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJcxic88udOIt97VFcOpHolfJu75Gw2ZPgt89gCC0ZQ=;
 b=ab0F5Voke/Gpor/wXlapInRFQtNSiQpj/9DbrGTSCfzY0dmD7RtQJiwkswOKOv4EFW5+lTEYOjX43snCq71qsjTtwyyBEXy5kK/PtE8TgsCafogzwpnzCYk1N1t1hZJtFYKLEOS/alFuGZEa6PUtnLuAqNPG5wQuOn+Z0nDNQo4tdwyKMThb9cEWFQFkUSYUJ59dmwxuq7emWef0Jg7HQs7teM8akbjjtRBU8osgruXZasxLFIoaRpjbffL+P3mtXAUn4x42RjorbKR1ksb3+wPC1GC0m9jU+1IbP6VHuMux0601OYwCak7OQvF1/QPbHOJK2ci0R1EXiDkXio/0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJcxic88udOIt97VFcOpHolfJu75Gw2ZPgt89gCC0ZQ=;
 b=4n5mqUwh6pRsfgXnQjAylD8gRuz+DD++NPsMYepNeH2GT4dWS1a9DBev/mv/exPVnmsRtEvt9tZ+yh400opPuYa9yHu+g0KDxPU3Ohz9W3A5U9taf+1KYXpLRvAb2D7fPJEkw6Uhj6t80vpfa/samwIvX/SWZ6GGQnxNFmvZSCs=
Received: from BN8PR04CA0028.namprd04.prod.outlook.com (2603:10b6:408:70::41)
 by BN6PR12MB1940.namprd12.prod.outlook.com (2603:10b6:404:fd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 15:10:03 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::14) by BN8PR04CA0028.outlook.office365.com
 (2603:10b6:408:70::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Tue, 29 Mar 2022 15:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 15:10:02 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 10:10:01 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Use switch case for unique_id
Date: Tue, 29 Mar 2022 11:09:48 -0400
Message-ID: <20220329150951.1311452-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fe45018-2b9a-43bd-18f8-08da1196333a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1940:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1940C7367A898E5B044F9F77851E9@BN6PR12MB1940.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLDhKApgeyvuJRZzPwgkrLkqmLF/srTe92/8Dni0uSDaDbr87fEU0qufBFoulZLGNIQw3ZXWeuLRwxQXBMwwnAuyozwrrDZp+XQu+5SFbUKj8gpX/NCeutOJcBaGbodB2WENvyoJ4L+f6TZ6roG8HkKw9Ox9jgsS626WUsInlVUAVs9gSanwRak6EFNEoFabB01byM8wC2DB9uH79TXQ03kTF79WgnWKTGJOOdC6M6vZwATzpvlb0hkKn3BBGOX8s8+Wow3Ucia7XlKYQQWqH1F0WkzA4tr7tlZKQsmAaZ0KUGbZRGcT7CaXq3TkvGO/7WJCXA3EVjzJnzVybq4r0AXLqg8x5hc89jAbM9+6bqIktVSWzmZByzFCWLPhIqBk8n5bly+nTS1/sUOkoI3XXWUr93jOAcwjajFaBiGEw5k+HU4GYLjsoCSLietFbtFpgx97LsiTOVmTvlMSmdeUvL1fCjNWjAhD23Utx2hxt8XgiggEQlWEhhlzuYy8BqOyEY7PzTfoxt197HZp5beg86lL34nkYAV4BeEjIgBVHArEFwlRzsdBHr+qxzgcYU+a1r1i3oqmaBuvanjGbcz+wGPXRQuWWWJYI4wEpMCiJvAL1DlVGM/4SUdaFIbz7SAzq+k8UcW9wZ/ylY05jjw+e1LDEybrlRJsWCPK82mwpMirSDWCBEBokmDV7bSEFkLRk9Umbmc9P7MH5GgOjoM9Bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(508600001)(4326008)(8676002)(2616005)(70206006)(36756003)(44832011)(6666004)(8936002)(16526019)(1076003)(336012)(26005)(426003)(186003)(83380400001)(7696005)(70586007)(82310400004)(356005)(47076005)(86362001)(36860700001)(6916009)(54906003)(81166007)(5660300002)(40460700003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 15:10:02.7933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe45018-2b9a-43bd-18f8-08da1196333a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1940
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kent Russell <kent.russell@amd.com>, Kevin Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To ease readability, use switch to set unique_id as supported for the
supported IP_VERSIONs, and set it to unsupported by default for all
other ASICs.
This makes it easier to add IP_VERSIONs later on, and makes it obvious
that it is not supported by default, instead of the current logic that
assumes that it is supported unless it is not one of the specified
IP_VERSIONs.

v2: Rebase onto previous IP_VERSION change

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Kevin Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9ce597ded31d..4151db2678fb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1988,11 +1988,16 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (adev->flags & AMD_IS_APU)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(unique_id)) {
-		if (gc_ver != IP_VERSION(9, 0, 1) &&
-		    gc_ver != IP_VERSION(9, 4, 0) &&
-		    gc_ver != IP_VERSION(9, 4, 1) &&
-		    gc_ver != IP_VERSION(9, 4, 2))
+		switch (gc_ver) {
+		case IP_VERSION(9, 0, 1):
+		case IP_VERSION(9, 4, 0):
+		case IP_VERSION(9, 4, 1):
+		case IP_VERSION(9, 4, 2):
+			*states = ATTR_STATE_SUPPORTED;
+			break;
+		default:
 			*states = ATTR_STATE_UNSUPPORTED;
+		}
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DA5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 02:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A753E10E108;
	Tue, 17 May 2022 02:06:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C19510E108
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 02:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og/9sqjeM7SnVFKSiFr4NsQ3X+WdOoF6c7sBJWElNsGnxoZQf37p10IK6+FG7v+aaK93iBJmLzmS15NqMXO/75amipQjOan5/uSs6DVeSiqhZkfW3HpjB9a6QlHQPKRB3XmHjNxISDOdOBcwu0/vc2NucgY1zkDdudgei5FuQRLRyLHNhpPVhqXgHzmtE/0L1Yj8y4hWl9qZerxZn66vkuSfsYVV7AIL9f2OO7o0z/ADCWgfcfuw2kN4q7OFo+OjM8Y9wv0ob6vCeDAud7P9pU3dU3jZgubyheMyfRv0/ksJrVkmKpQGo1tTteiVqyT9B/PUdsJda2mL36xXugxz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HUuoHcmc28j02rrsQkWj6eXGhmUFqAi8qzuzkK5tOY=;
 b=PwK0CH1EV7nwvHCsFbBRqcCvuC3iMB6+0GPI8YOIdoQGRZhM+V1dXk57sHXSDvkhVbHsKzqbzFCRTxZ9DPN3gs54Amv1eCcMQpcd2RwcAw0AEBnT41WLncGybgubVYSgIvQqD/7KSKooqIitGNvIsinAccu5g806v1sOf1sN4reSHT+lXjLzOKCQO6tFKQupl6xknj1bCqyCHlRkgzbVXuxtrg4crWzQ6cb/VRhCBrEfOYbT849F0YKzfpzFIjUdPj6CH1aWssGnmoH+ZDlaOkq06G07wE+TDYyUSxhf/YB7Tz77VsAv5jj5+e+MGJEt5NM+7c/3XG/g0vizi15bWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HUuoHcmc28j02rrsQkWj6eXGhmUFqAi8qzuzkK5tOY=;
 b=PHs/U7tj2/Np3IJIpuuZHCakSer5W5xzfmtrwPoTGef3KhKmgRTLBw4/jiTBZh0ZEzJ/HLIWiIaM2IhVkwpOZOtaw8PtwNvfm7EZpRKPmay7rYdWlkS4TBwTWmSHejKWPwxlSpdCTkj3emsKuYdrZuV7fc53NoMoLaf1STWhc38=
Received: from MW4PR04CA0092.namprd04.prod.outlook.com (2603:10b6:303:83::7)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 02:06:51 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::11) by MW4PR04CA0092.outlook.office365.com
 (2603:10b6:303:83::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Tue, 17 May 2022 02:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 02:06:50 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 21:06:48 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amd/pm: correct the softpptable ids used for SMU
 13.0.0
Date: Tue, 17 May 2022 10:06:00 +0800
Message-ID: <20220517020602.160108-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220517020602.160108-1-evan.quan@amd.com>
References: <20220517020602.160108-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4382e8f-d1c7-4f00-0fb3-08da37a9e822
X-MS-TrafficTypeDiagnostic: CH0PR12MB5236:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52368428F2B8631F5EE62528E4CE9@CH0PR12MB5236.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORuJDHpUrsiJ8llr/LFS8HGvU4aCFXxgNFfioojVke3o2Xf6c2CMz6Q/HbVvARh1WL1u4n9f12lWroSSm1dDhK4QtasPkYRLnq6eJ/s2blqPjx8p7SHPil0HnUWAV5A2tTO8ZVUeNrsrlQhB+AoDR0PED71q73WAcM9s+RvWaSvKm4O57T6vuamrK/KQN81hgErqNxMS8p1X7CNovHCeeJIr8yCjq3O4flBMBRtlB06/OWbTtjbhFsYbuF0a53mp4fyrgqHqpP5ZO7PeK8k0MyHZo/VbsDXynv5qJ3zgIA/f2eJ1sPrTDVLXwqDCicyYOSa3GSyQyrP/1u2DoGceqwISWoOgctAbZvsNkvVA2HUyFyjcvkWyyj15xgCzsNstb8bE3k/M0ikGxEyydsXqEmOWJ0yWWcg+ExQHQI4XG6Z24YKZRV70CjauOSFs/YKFfAzwPTM77cwS14S4FA9XiyJHF9oPu7OCS/iQGtjpNzKoPi/U+BZ9ZPnUyz0pYOa867OHYbzIqKRDjcI9JssMLa3VxYtxxhRbyNsQLusmOQA5M5A1nm4WdjdV4FzV+fTx4dxF9ihJgY2LI9JUHLW2UUlHMaQYm1MF6qpzaZW11MkRoAp7N1eonKY3uuE+YbT+JQWwRUqc+ptNx2W+Mrmo7lf7sg1WsZP+jG62AAV00UAf/RKjQKTXftbAVQyp7jXFvP8mBLY3WCZEQ5dAzg1tfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(54906003)(1076003)(8676002)(5660300002)(8936002)(36756003)(2906002)(26005)(47076005)(6916009)(2616005)(16526019)(186003)(316002)(70586007)(44832011)(356005)(83380400001)(36860700001)(336012)(426003)(4326008)(6666004)(86362001)(81166007)(7696005)(70206006)(82310400005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 02:06:50.7081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4382e8f-d1c7-4f00-0fb3-08da37a9e822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To better match with the pptable_id settings from VBIOS.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I3379443067a5df3a2fb04ff1bc48e8c8f28e1c66
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 47 ++++++++++++++-----
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ae6321af9d88..7be4f6875a7b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -218,13 +218,25 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 			pptable_id == 3688)
 			pptable_id = 36881;
 		/*
-		 * Temporary solution for SMU V13.0.0:
-		 *   - use 99991 signed pptable when SCPM enabled
-		 * TODO: drop this when the pptable carried in vbios
-		 * is ready.
+		 * Temporary solution for SMU V13.0.0 with SCPM enabled:
+		 *   - use 36831 signed pptable when pp_table_id is 3683
+		 *   - use 36641 signed pptable when pp_table_id is 3664 or 0
+		 * TODO: drop these when the pptable carried in vbios is ready.
 		 */
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0))
-			pptable_id = 99991;
+		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)) {
+			switch (pptable_id) {
+			case 0:
+			case 3664:
+				pptable_id = 36641;
+				break;
+			case 3683:
+				pptable_id = 36831;
+				break;
+			default:
+				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
+				return -EINVAL;
+			}
+		}
 	}
 
 	/* "pptable_id == 0" means vbios carries the pptable. */
@@ -448,13 +460,24 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 		pptable_id = smu->smu_table.boot_values.pp_table_id;
 
 		/*
-		 * Temporary solution for SMU V13.0.0:
-		 *   - use 9999 unsigned pptable when SCPM disabled
-		 * TODO: drop this when the pptable carried in vbios
-		 * is ready.
+		 * Temporary solution for SMU V13.0.0 with SCPM disabled:
+		 *   - use 3664 or 3683 on request
+		 *   - use 3664 when pptable_id is 0
+		 * TODO: drop these when the pptable carried in vbios is ready.
 		 */
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0))
-			pptable_id = 9999;
+		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)) {
+			switch (pptable_id) {
+			case 0:
+				pptable_id = 3664;
+				break;
+			case 3664:
+			case 3683:
+				break;
+			default:
+				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
+				return -EINVAL;
+			}
+		}
 	}
 
 	/* force using vbios pptable in sriov mode */
-- 
2.29.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C42C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31E210E562;
	Fri,  9 Dec 2022 16:37:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260E010E568
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H73ZS45wDZoRnD6ehH4+sr8ruLKuIHqx/vnKJoh2CnzlHe+iwtuC8wXgZNbSavTshvFCxVil4+m6HjG6cLzT1sbKRWSgX1405w6bnpe1igZZo6V3EJDoYx9HviP8I9Vz+l+VQaizdYwSCIoZgvsbVeOgpGrX1EOSHNbVc4pv3qq8roSp7ogjASG8KVRdTuu+e//5nwCr+gsuGf6WyUm6qz9d662PeyJcRz48k6kyanXRgzrcCcUPAG3iFURwJkQPejEA/lafvq0uw5lgWJ9sgagwrSAIR8GD7o6b+hyHXLZ45/syacOXKa5P7O3f/DaqnNVGoX265cmO+LJVt+lGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXJ43ECLjuNDk4B12X1zAd5zMU9XQHMYmNWrNYenqOo=;
 b=l81QKaI24I98Yk+QMFsqPdI6hlaql/gcxqRdxfj2LtCaI2J0ICq+rL9nPJylbB4G7CTf5t5gfB+nop8I0NTJIDjBrED3TfDILOdz8REcO87b+PTQ5YJWGxOcz0NU+fHWydY28R/ObiHZ1dNyluFjcN4leZaaKeRihKXLcFUAAXWDMJeaEZ3iIS2yeIFUQWDpB8ypjvqPhihR7b6BqTsPK1PqHhS3w1IoNuH/SR/fqQMd8h1+DIDdhhDvUaJLFXPjXCzWbNgPxEfrkjkTqZSk1GagGVNPz4dCCekEjfW0u5TbCs02DHTl6OOGGykAKz+7v1V62ocoE0vnAXcbE3xZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXJ43ECLjuNDk4B12X1zAd5zMU9XQHMYmNWrNYenqOo=;
 b=ZqCieo4EJTEnHJ2S9GNKqjEBqDiuxQiZIDpYS0L0rpLPe3JgtcGB1KAPEQTIqn1wig6flhflzL2FOa3CPlm1z1WdJ8jMa6kuZHWPNvo4Jip1ip5UTsW/iA6jCWbSw63PaMeT0dP30v2CqCIc2D9txarjpYiPxbMvRflMbksm49E=
Received: from MW2PR16CA0068.namprd16.prod.outlook.com (2603:10b6:907:1::45)
 by CH2PR12MB4907.namprd12.prod.outlook.com (2603:10b6:610:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 16:37:35 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::b7) by MW2PR16CA0068.outlook.office365.com
 (2603:10b6:907:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Fri, 9 Dec 2022 16:37:34 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:32 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/23] drm/amd/display: Fix potential null-deref in dm_resume
Date: Fri, 9 Dec 2022 11:36:41 -0500
Message-ID: <20221209163647.25704-18-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|CH2PR12MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2a91b1-e6ec-4eb6-59ae-08dada03ad28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vSwY21HYii09Cd8NP5/zTXvhwIvHFSWZwL0JcKc8zzPnT8wzY3RvHSRckzf1RybsgKFVTPdRb7jnqRm5wo9miL27YuKVyfMMFyxfrh1/5ZAAfSzwPdjufn7XgtfQQnTHpB2qzK+dQoK3NC/JWZCMSfLK30sX2gXnJAmJEcIuiGbsURoXSkRtiNGCz+KI3DkBUrXu9tismB1oMvsf9UO33H1YQrbwWHDwHS1A0YXaN5NJOYMqK71sM5BNgewXAKQ7g2WqYp9PGklSUzUrQ3oaGvSylp0xFZ3AsJsXu4tYaZwA088DURPdMornR+gXzbBw8Lk4YWcTHA4cJ1HEkMdEX+nSH6ZvYmeKErCJellU/lJwBVdnClF4E1g3qGnni9EBEkBdR1uTOIHeybzJR7eth8ghndBvFAuRVJ1VSt1owPCdXLoVsp8FQNyDOw3cxDgMccJuTF7TqXavOPSgGKLbQLeQEdKj8dwVibaq5u39W2io7dzQ476Ku1dcEvQBbQMSlR7mJNahZvQCL9/+oskbDu+KAxINihkXD3Wvqlls9/j9nLDyjJKOyfdOFVC1lIzN2LQLYFML6/gLVxITeZT35yIcKxeHDr52caEqd0Ksfp+Em21voEy6N8RfLDxjRMGO7bhJSA2KNh/+8ufbMntPYneCU266GQXNaGzinnQ6b/mahSO6zQhKs8oKgu/y7+N99+RkIHNURHm0KR5qxWpzBVuRRouFLUBBntDoiTa25k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(70586007)(36756003)(336012)(40480700001)(2616005)(1076003)(83380400001)(16526019)(4326008)(47076005)(426003)(6666004)(82310400005)(186003)(478600001)(26005)(82740400003)(356005)(5660300002)(41300700001)(8936002)(54906003)(8676002)(70206006)(316002)(6916009)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:34.9800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2a91b1-e6ec-4eb6-59ae-08dada03ad28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4907
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
Cc: stylon.wang@amd.com, kernel test robot <lkp@intel.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Dan Carpenter <dan.carpenter@oracle.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Fixing smatch error:
dm_resume() error: we previously assumed 'aconnector->dc_link' could be null

[How]
Check if dc_link null at the beginning of the loop,
so further checks can be dropped.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 37c6be337a85..88474f04fa9a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2739,12 +2739,14 @@ static int dm_resume(void *handle)
 	drm_for_each_connector_iter(connector, &iter) {
 		aconnector = to_amdgpu_dm_connector(connector);
 
+		if (!aconnector->dc_link)
+			continue;
+
 		/*
 		 * this is the case when traversing through already created
 		 * MST connectors, should be skipped
 		 */
-		if (aconnector->dc_link &&
-		    aconnector->dc_link->type == dc_connection_mst_branch)
+		if (aconnector->dc_link->type == dc_connection_mst_branch)
 			continue;
 
 		mutex_lock(&aconnector->hpd_lock);
-- 
2.34.1


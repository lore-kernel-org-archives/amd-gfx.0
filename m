Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC54CCA47F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714D910E78E;
	Tue, 28 Jun 2022 14:42:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0AF10E78E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaAFAWVEEV9Y+OuB3MV7UiawT9PhC3As6mf4EtS0J1QbQa4ozf/0+s0CVnio8kVcC9TyxxtpbOqOy39mHCeq4EVBYlr9OHOmN09o8dQSuVBpCKi5RQpOadQgE0VVWQFPpfMJeFieNG/wnQvsS8WMENl8YVwbExWwrIxahr2sP/mOGyVtvCbALsfMWgsDJOX88BgziU7ma9g5dIxZwUkbfHjjq4aLBSSsiqx1LizfvNnGjylRlMyyRxE/cZZwhqhl09NJvfZsGicNen8AAaIfPzMuhPcosTwTdYJzfyCmCmSChVxDSr+5BDX3TBYwO4sjQgwvaIOQub55PqZlnW6gqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crEz7Si9xjQchy2tYqnHxn1fAS6rnvuLnSouWuPr+9w=;
 b=iqJdz0qXpeva6vw8qHO5jcmXDKYeTQtza49V/4BvoDS0O6eCbuXIU2/urxRV1EyyHicyd6lj0/l3ehe0iFn7LANHf88J3jo24obv1HwY5WO9GNt5HeVlzVqEhXnMcZs2zdG15uqQPFy+UK4Ft0NRHgpAVoO3Y39hBkINyA017+TOhjCht6UlNQ6gM878OtOSEAlWslsWHKWII8Ie6yvFo41o3SmBgjPfLSIaR8SV+2+kvuNm7Ev04VUybZVtrI6Jo7SatTqflMRs1sYgvvF+R+oO051vyX54qJNzIeeKNtNScaSPBEA9P0Dy1B/PTU4GywZNUJVQAi4cd8yNniY3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crEz7Si9xjQchy2tYqnHxn1fAS6rnvuLnSouWuPr+9w=;
 b=MmI6S3inLr2vqGXpyVbjYutJWBeN2Sp6+KiEnduUcS74Oqw0FQy3TwsIWv5xMtqKPyUITBLuosdq/xu2vPkQNvPYoaCfkSjDDC69LQRxwaWbCKax86K4fx2EUuoDBGBzJMJS79WLB/kosIhk0NK3wSDqy17NYVsk3TvbR8DzI7k=
Received: from BN6PR16CA0046.namprd16.prod.outlook.com (2603:10b6:405:14::32)
 by DM6PR12MB4529.namprd12.prod.outlook.com (2603:10b6:5:2ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 28 Jun
 2022 14:42:19 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::d) by BN6PR16CA0046.outlook.office365.com
 (2603:10b6:405:14::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 14:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:42:18 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:42:18 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix typos in amdgpu_stop_pending_resets
Date: Tue, 28 Jun 2022 10:42:07 -0400
Message-ID: <20220628144207.76106-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26c681b6-863d-46da-1b57-08da5914671a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4529:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WgX4dIeVzx+fFPA8GUngX24H8dea+Kl/djLjXOsMnlBIOroDMqAl6RYxO2CYhIr/Nk1S3EA3dl2d+TpMwUa0iSCQISEWeF6/H0sIAh1Vajn7FrKXtl7iJGwWHEcDvcKKG+E4WeA65G5gma6Ik5WNQv96HtWtV5InKQtUrFLdIkPV57abFhrO/Oxr01J0MmhJHQDm2IMXXwvCmvRDD1CWv5QS7PhxEAIIagBwk5sJAxKRBJ1o4SnksLtD/62Jf9S8VdgNoIgL9ujjOzJM/SdkNphUWAXk91reEBBCAXh7zDQ+mIiTqnxnLKvUDI6l5U7LmxBcj0h6FP5Ffjs9qphmDpHkTX+w49XdoYWSF29zH1wUFjW4s9zSsF/PfrWlZfmA7Tg9se6AUL+da/jAY8r+JAuSH9kMPZwSMxpWkkIdnXNHlgCel4WN19ffb5YooJ+EYILemcaHqCU1jnDleZGkBmg4p9MCQtjeO5zCXrpwne/MrE6BaLeKo9YEf5pW/wsaPSsHZX4ZBXWbPbOFJa+2cHJXa8V9bi57t5tWJGP0+XKbUjHSGvOwnUk4LhI8f/6mR7tJbcwCQF4wYMAOc4T3ApoYcPNYmiY292RTFz6bs/44pq5D+0GsIr/afEjnWo2lGd/S0uqdmArxDCfSqF9uyJPo1o6YWbD0dOl8+FjW9xJXhRw/3FWvr2BWrgnsba0MNucMoZf3y5C4OAAhcGXnv+aYJ3FfbTFWQmnYgZ7ELJ3bblUmjf7j1MjMb+WaXHZYL/Lp8Rqmde1IZP6/joyEBwcaGTnNmH9lJbUnRg/TzQHwgQHL5P6HuuzwQJY3I4bUMudLZg1TYeF9mJgm9/t+og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(40470700004)(46966006)(36756003)(83380400001)(36860700001)(86362001)(7696005)(336012)(47076005)(426003)(16526019)(186003)(1076003)(26005)(82740400003)(356005)(2616005)(41300700001)(81166007)(70206006)(70586007)(4326008)(316002)(6666004)(8676002)(478600001)(5660300002)(2906002)(44832011)(40460700003)(8936002)(82310400005)(40480700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:42:18.9547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c681b6-863d-46da-1b57-08da5914671a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4529
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change amdggpu to amdgpu and pedning to pending

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2c268d48edd..39a875494edb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5075,7 +5075,7 @@ static void amdgpu_device_recheck_guilty_jobs(
 	}
 }
 
-static inline void amdggpu_device_stop_pedning_resets(struct amdgpu_device *adev)
+static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
@@ -5256,7 +5256,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 * Drop all pending non scheduler resets. Scheduler resets
 		 * were already dropped during drm_sched_stop
 		 */
-		amdggpu_device_stop_pedning_resets(tmp_adev);
+		amdgpu_device_stop_pending_resets(tmp_adev);
 	}
 
 	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
-- 
2.25.1


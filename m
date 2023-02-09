Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E13C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 14:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 170B310E229;
	Thu,  9 Feb 2023 14:12:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5890310E21F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 14:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDd8fzmRq7wAkhP/6GzUF4dpb/PXbK28UuJYfUYdPih8+fxptq7P6UBrOgkHmXYMhCjNvz2dbZi6rbLK2LpXeD0favADKvNv4btPdhRRv9xzcUxBP7EfPKJmBtR0XK6U9MjNSWbCE690M+EgwLrpvitPsCKj7hSSOgHxYyAkk4edjCDIOWM2NTz76OXH5oUS0a6g3bXH106XU6wwNvugSMiMCl+1116xrBz3ApdWdosM6kM1zo/HNYRA1ItYbQ9rkTB7hSGPv5j61Tiviv5R9fCsr73q+HuPrY+Ge3Bgu7oNJqmdajlGu/jIfaAgb6b89MZ9fDfN3NQ/4YhD3b75hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwB1W6fISrRVvHabfP0yDcgowcivEyn6vCOIr8gh7ko=;
 b=G7oWqP2n56/TYRyB/KgdNIMFr2gEKanL6avsc6vduzUXKWdakYjwvhmRnDdd2CjlGRrl0HJI3wrVa8m47GTTeLAHQVLYqcHFVItQFiXSOCL5MWI6b6RwIJU9Jefbg/0YBBIRN/qtLdTMwsxmoTvCdu5x0vppMQP6l5VtAISTKgL9wU9Y1mewoQr7nVyJv2ZWUEJ6ODyGpJi+jcJECaXtEWVIOv6rF0O6wyGDfkSfWHrXznoxgI71xA78zLiROpViB1KlNxS67zwN7Rw8kobh2hPSy7gppZ9tTQJQlA5rV1NX5AsG1jR6KU7jHlOHcRT625YdNH90gszhkNxRGi8sJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwB1W6fISrRVvHabfP0yDcgowcivEyn6vCOIr8gh7ko=;
 b=ZDeigeT5yQlIiMg3pHqrV+FawszNNBVAmCL0I6fCpoKESPhs9EdVW1u+3sP2wTfanrLsNrGtBXAeCBB6S4oHKsMARsiwe8J78/2oFjTwbemhNjcNdW+jH1enCIfxFEPdJBDRaVq1Fh0hb+NsZ6FUKOw4ZJ1aIDDrju+x58BqwDE=
Received: from MW4PR03CA0300.namprd03.prod.outlook.com (2603:10b6:303:b5::35)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 14:12:11 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::55) by MW4PR03CA0300.outlook.office365.com
 (2603:10b6:303:b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 14:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 14:12:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 08:12:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] Revert "drm/amd/display: disable S/G display on DCN 2.1.0"
Date: Thu, 9 Feb 2023 09:11:49 -0500
Message-ID: <20230209141150.612825-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209141150.612825-1-alexander.deucher@amd.com>
References: <20230209141150.612825-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: e76b5147-aa15-47ce-b1f7-08db0aa7a2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Exk0BLng/hDJm+2nkaQTmafCSuGFchZ5zLBDcqFLj3xkJYwp8eRwiSBDeizpbZdJH5hha53tbZKywmDlOXk76+alqfj8HP9Lna/EJqp+kw+kj9309xZr5XmvtAY/4NY0R1ikBgBbcv52AghR/xY3asSCwq+0dMuJMTwbbiEKn4+8F86ahRurx7Y+K+allss/jjJ13+RMIPwLb5tA3bHHv0BGc0uEv9QXuJ7G/HaWHCuHz7dSJeAWqtYATNpze7fdrSr45oWRF9tgJ2DJ3rL17NN8wwYxVyZU3YUx1R/u0BlhJ8ekHtsZ4Uc0XWHcihhhhQXH4dkLiBDU0ZJq7XZQ5WHwUTePGEeko5s2zKl8FMBLRzOMZgnCL2C+bS0iegv/pJYnQplnjfOqHmTo7emYxGfLJuIzXczQvFtV2CSNU2WWytaQsLNvaD3q11kyZz2RRa6XKfkRlPQp5vLNWf/Vg6ia4KxjCGKLww1BVbZSqIEaJr7kyoRsrFWKKFQ94Wbu3/iKF9gQylAFEdIxSsNszPyErzue6NR98QtoVSE8b6H3khCxihuoxs1LT1C2Z8NKP6JbVg9+GpwvERE/hHpMx1mKfTkmSnVe+iWU8KD0rB5pi34UWCLq0s26Tnh10JFgsvBidcUdcF1wfzxgQQOXGQ8NR60K36KfeWBnjvoBhiSle8nMCJ+/cQX4D0XvmhEsHI0vnTqF0f1TJG80sV464oROb24s4W1F+D/Cx9m4cQ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(70586007)(83380400001)(316002)(70206006)(5660300002)(8936002)(6916009)(4326008)(8676002)(6666004)(2616005)(41300700001)(478600001)(1076003)(16526019)(186003)(26005)(47076005)(336012)(7696005)(356005)(426003)(36756003)(40480700001)(86362001)(82310400005)(2906002)(36860700001)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 14:12:11.0837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e76b5147-aa15-47ce-b1f7-08db0aa7a2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 2404f9b0ea0153c3fddb0c4d7a43869dc8608f6f.

Some users have reported flickerng with S/G display.  We've
tried extensively to reproduce and debug the issue on a wide
variety of platform configurations (DRAM bandwidth, etc.) and
a variety of monitors, but so far have not been able to.  We
disabled S/G display on a number of platforms to address this
but that leads to failure to pin framebuffers errors and
blank displays when there is memory pressure or no displays
at all on systems with limited carveout (e.g., Chromebooks).
We have a parameter to disable this as a debugging option as a
way for users to disable this, depending on their use case,
and for us to help debug this further.  Having this enabled
seems like the lesser of to evils.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d22bbd6d8ba5..f7ba65fd8f48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1566,6 +1566,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			    (adev->apu_flags & AMD_APU_IS_PICASSO))
 				init_data.flags.gpu_vm_support = true;
 			break;
+		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
-- 
2.39.1


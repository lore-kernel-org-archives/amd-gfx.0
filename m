Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E357CEB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E0810E15A;
	Wed, 14 Jun 2023 17:58:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9443610E14D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APXXjXkRsm+sblLaHj0BQFbOpaEY3H4IEKYJtCdlaXXOwMyN/wO4M9h/7NrElueXEkFgGjrhZ8c+HFtOH0X+ZU3OB01u8ESnFJc0ZZuJt7SkYRTX4I+Nb2EsL7Vsnqv7TmVp/D6nIUd5maNrmFuRpQva/6lGJ1IQMm+W6F0R3O524cOAyB6OuIzTLK7U7GsKTPcipeaYaeAKZXNfcNBzMCxz7gg4AU3Q9VLvEajv0u3qyVTr5yrgn3eUZbqnqSu7RSisUjapvPOsWluCorDddzTxOuGW9WwLSHNvptk+hXUp4Ox2Q3vNkRQoCf9bokCe0RK4kVRoKZxqvkFUXVpOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iirOL1CamVOwVdv+biMxw0G2uAQzVRrh7AnYSKEfAME=;
 b=BH6shBgNr6ixKDWZjY9fhtxIRFFkQ5XnPZyaTDvSU5z9/jpYUQrBriRPN1uqCLdCJiq0gJkeybspu273taE4yf+wwXJdvMv7QT+0s5SKBFedbYC04SyV9bdrw4nLwiW1rVlq/epRNeWY5HSMjsYp2V1LxHTrEGQV17jkT+sMdp0KGcOx97TS5Yew0S51/NVLD36cxW+zwwy5mzvFeTnwfYlfTIKdueaus6kUpozEc+z2nh0XMlaMPos3NqDd6gcC4lODeYoxxFGDAoHhwjffbKwFRxL0vnzB9J+oaFCXETDdK2uaoC6BcellkPyto1AYlk8+5D5vIAb1YguECp547Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iirOL1CamVOwVdv+biMxw0G2uAQzVRrh7AnYSKEfAME=;
 b=qV5yq4kxURnhONb2SCUcntZxnbAnI7lLqVr7qAAWwNhH55z6wCqtuWRY/zPJqmw/7GzzJSgKnKiyAiBRUCUbnD90SMt96jnZw2OgfxovXfdURuAC6MJ0WYSFCM3yzNwFUTBs7m+RJfDfTQ9p5z6GJsn+4OnABkBPFXqilUYAfO0=
Received: from MW4PR03CA0201.namprd03.prod.outlook.com (2603:10b6:303:b8::26)
 by DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 17:58:23 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::78) by MW4PR03CA0201.outlook.office365.com
 (2603:10b6:303:b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:23 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:21 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/17] drm/amd/display: Fix pipe check condition for manual
 trigger
Date: Wed, 14 Jun 2023 13:57:41 -0400
Message-ID: <20230614175750.43359-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|DM4PR12MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb37dca-e1cb-48de-38be-08db6d00f240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAcbM4Mzo2KFAhEjywzKH5bmqT1WLSEJ3HEESmWFkwG+nl6tDZZsqp1C0BfjWXM6eq6+PPZtYj+sNWUgzlRlk0kyfNbuD8lDTNDLE8mNhNI4N1pXqR54sQ7ovxO+NA2lyTKFIBMmQhEB2xcGucgxwEZhyhwboa7Mu4/rpwCmA/0ZSc8ruYwuFex8lv3iYCM/Po9N1DUK1B0NhYa+sO/vxH8fdu4jiDg8eVbdOFjwwhrSF7TNunDVjvwhm5Is6ceXQR92mSgF+7gj7oekRlPRwWm6ECHWlHp6mYOcycMLviatfyYGaVjfs0Ak+nO8E/8GjmyR1iBc4YgEe0sf3KBH6iykNzNq7AACv/51p++CjC6KsvFFIBGyLzZJDjP7jdzgUD5/YRQVNPp1Bl7CZ6IyNJf3WyNVzBxiUzkyPa05bUm2ZddfmfLaCKMbgFVqEQNjxvED+c0PCGh//n7ZxEvNz2jygtjTg9p4vzviOMIx0qWZZ+zroxndxXzUKnHhjuqSNTXuI403fM82fHOHYMkV6A0wxMM5at4NRtQgIrzxNsmh3wgjNEhwZRlNWWYQjRQrzxs6mx7hiMI5feVXWu00QZyNjrADxiIQxbO4zWKTyimkmxeqLvKMYyD1rzBoI66RiLn8fni1B649kj8hM0SIgicTjnmMmprbXLfpLgH3QpLRsFUX0oP1xEHKkqxdsQd0w/p4BbhuZ7XclFlWOCkRHOSJ/k32tIyU0ZRvTxO4k65E6XjiPOv66v3Rsp3rLqtGsUUuf2PODr+QfD1BqtZrWLkxX5EXZp1jYnOb7TZAYpU3EEVEIkySW9MBYbryDq5h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(186003)(16526019)(2906002)(40460700003)(82310400005)(44832011)(86362001)(1076003)(26005)(426003)(336012)(83380400001)(2616005)(40480700001)(36860700001)(47076005)(82740400003)(81166007)(356005)(36756003)(4326008)(316002)(70206006)(70586007)(6666004)(6916009)(478600001)(41300700001)(54906003)(5660300002)(8676002)(8936002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:23.3217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb37dca-e1cb-48de-38be-08db6d00f240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

Condition for programming manually trigger used the wrong pipe (always
used top pipe instead of the one we are iterating through).

Fixes: 7c2c33690791 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index d7d00fefaab9..cb2bf9a466f5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -610,7 +610,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 		current_mpc_pipe = current_pipe;
 
 		while (current_mpc_pipe) {
-			if (!current_mpc_pipe->bottom_pipe && !pipe_ctx->next_odm_pipe &&
+			if (!current_mpc_pipe->bottom_pipe && !current_mpc_pipe->next_odm_pipe &&
 					current_mpc_pipe->stream && current_mpc_pipe->plane_state &&
 					current_mpc_pipe->plane_state->update_flags.bits.addr_update &&
 					!current_mpc_pipe->plane_state->skip_manual_trigger) {
-- 
2.40.1


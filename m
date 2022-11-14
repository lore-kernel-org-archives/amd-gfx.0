Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6D4C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 02:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937F510E25E;
	Mon, 14 Nov 2022 02:20:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE29410E25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 02:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G44QUOvfIUk+deaYp5wGzEOwps3nJOozLvwOcJNNsWNFKCzcx2R7XMiSM2zovPfLItyFl08pcNTWp9GdYgtaFy4EAIRmZRHy+hdtFqLCoWApo0ahnrtK0BRrVU/BSaQ3O39QIP8bSJiw+Fh+xe3RX1g4NmQeFnzX1gg9QGgIVtxOrORN9c+xHvcMERbK43hPN82+aaRebXsbo2NRptyi9s1Wr7Y3nhc9L6GwxFCFDDNrNLcvZlJ81u3GpKVIUOgy9nNTZgLDvbbGdFVBtamrbg4TJvTnZT0Eyf760SQvRszM8UjOxYsd4iFm5gf25Ki3bPEgzaKVI04W7oikV05hog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A51dxDShhrFdsOOSy1DkQEpoH2b0QP55wsj0vvtf4yo=;
 b=FcQ4b4q+C6/mpCdx43tSk3B2gs8LF1bVoKfzJSxQnWB+Tp5QeSMTjAaivvn+iVLQZOKE9DnOwiyOavYmr1YcaMAcZ7CxWhboQFt8TFJ0R0kppYyQh1flsaw3lHv2t8amjN7Aka/qgARUgzm0MDItW+irVrVVY7L94oIJJE7XOgNbbiVMNJsGx+4w/yxvQTW5XznK9MykW7WDj2JIeZYwpCs1LZJc7FrfDARlE7EIZrX5ILWGfgPao3hvyPK3r6Q455L4h8zA8ybB8bLnhsbJ/VcfZ8/Ah5+dWlaXOK42l45Dj9R1jCHXPZb+p8ms/vkHqlOm6SawCev+dwIuaexkdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A51dxDShhrFdsOOSy1DkQEpoH2b0QP55wsj0vvtf4yo=;
 b=LrrzFINy1f5bYcqo646NugwzfOnPKUeLiLXmABT2WdlGvZf0h/rxCmzPLbE6jK3O6xW0i2DVSDWhipgKn14Xkj/mid1CCkAyzyYU3FBTs+hT135vE04bXnUPtd3lzSZBlR0e/nW1TFF8Y5t+Gd3cERAsdfZDfxlSzpKBxtnuQVk=
Received: from BN9PR03CA0707.namprd03.prod.outlook.com (2603:10b6:408:ef::22)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 02:20:43 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::76) by BN9PR03CA0707.outlook.office365.com
 (2603:10b6:408:ef::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 02:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 02:20:42 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 13 Nov
 2022 20:20:40 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fixed the problem that ras error can't be queried
 after gpu recovery is completed
Date: Mon, 14 Nov 2022 10:19:40 +0800
Message-ID: <20221114021940.4080321-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea403fc-90a6-450a-f2c1-08dac5e6d4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSLgT+6gzbJzTqbbrKa/VvVtThx5oDoSGPflffKs/XYHSdvKi9HikYcyqvNKR/6LMAo1HAgbULV9thO4tlwgUF+P2ntkx/PsV0TBojYe4yQ4Jxp4dpkXpE9YYakPaXLnUbv4Enu1Cht4JvSdv0/GGPNvvA7+rgZ9nGaDWJl/49EqroR+yYiqVF/Lv1gbaIZbhyzeyqIvAhzsbV2HI3AECTbYafW9iCiIZ3vdyyse8u9uplgR6q2cicEb91nC8cYeuaNoCQshRWu8NrFVCfmSM9BkdNPTWgg10wgHTK6JZxH6seHYSV2+AbuNMfegSgrdwy5AmFBy/tMLKxCCntkOw9ZP3XhFIbsCZIgktrdSVzeJFCJQExUPyDEqe56aI2FppZi8jp7UlSxzO8OB+/vu7mtMLmanoGSBYJbP1K1+aPfAafdGTL9Kzb/ZpuGJsCtHtX5FfiBnDy+gJv4oehqJeGEuzUou4GCr0GgV/QxNeHMaodzWzfZ4Yg+mvwFNi+fHJ9YZR7CBDcM/IMjBBupn/EMgD0XcUvhYDz2MBfjlTYjEuEeoyjaqEg+C7KAB5gITogGvXl6lPSOC5SzBkBVpNZwRUAhSB/8SfnGpk/mDisO6nccPKGAayMlQ+oTtVcs5oDzDygbhja04/P2UNwfYq5mTFJWPi1BzRcvpBp/Y0xKkw0nDIqgEojDcoPQKqBYvidJyE/h7GLVwxDkEOUISAYIV4MHbTWJzpWe65Zc6EiB8q7Zbp1U5OaXZRABSwu5a9cTLTeuVUXL+cPXTnX7L03moFfb0jb7Zxl8gYU9GNBw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(70586007)(4744005)(36756003)(70206006)(8936002)(5660300002)(4326008)(8676002)(36860700001)(86362001)(41300700001)(7696005)(47076005)(478600001)(82310400005)(16526019)(186003)(336012)(426003)(2616005)(1076003)(54906003)(316002)(6916009)(81166007)(26005)(356005)(82740400003)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 02:20:42.7525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea403fc-90a6-450a-f2c1-08dac5e6d4b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>,
 Candice.Li@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  Amdgpu_ras_set_error_query_ready is called at the start of
amdgpu_device_gpu_recover to disable query ras error, but the
code behind only enables query ras error in full reset path,
but not in soft reset path, emergency restart path and skip
the hardware reset path.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5b9f992e4607..603daf8d95d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5443,6 +5443,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			amdgpu_device_resume_display_audio(tmp_adev);
 
 		amdgpu_device_unset_mp1_state(tmp_adev);
+
+		amdgpu_ras_set_error_query_ready(tmp_adev, true);
 	}
 
 recover_end:
-- 
2.25.1


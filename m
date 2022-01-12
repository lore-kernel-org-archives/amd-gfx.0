Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB201C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 07:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA45112119;
	Wed, 12 Jan 2022 07:48:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E187112113
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 07:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjnlW41xktn/Ayslu6ryel9Q+wUIuCxl9ycpGlCQ6fL8mtURLPuJ/BclkhMoCKW34SIFqo+9taq+XAd0JxMF/+4WjnOQ2dT+0T4klW5fAowhNNu+6q/2up7B1Jth+F5Hpf1LLRgX1diysRNYdEbbnnmWmWvr2bOJrSzvdQcNZncKbkO5Am3Kemr9LtUPHY0WoD1U886WztCdDnIqQrnEfR2a/nVqMZjlLdEhLDSppg0gyAYnmU07qvghSMRxj+M465ddPgk0fBz1HtPI5Bm8xQnpvLBkrwDvN2wJY7fJAAzX9eQIldEdIxDp/gOnxwiruV5TT6Ne71Q0SYBX9y6uvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5svHh9K2nplrYqInLoW3pUa5rnfPEe7/N+lTZe4bci8=;
 b=dVHk+l0XIixbX8ccqM10D3ykdn7/flMGyQBm7O32BYdnq5midOQzs/l+7WtHK4Dr9iMl36tKV+onSAoATVBs10iu8g5gfQgsATXHwQhqYQYpobYoeifcpcpOk15o9iXj5S3GckwxVFFzKu8Op8kQcv9+5zhDB6OEhC/5WFHyHONG5S0HQYu1AjBRQrNzi7uwZkyWBpCvYfW6CGUFf1YQi5yvyMygGCcdFZqUNIZqpr+5cCKcKk1fGNPkFsDKtqXQGu9zOqmclS9yFE2ZyoGRjz5SAkylulUv10sk3SNd9vFvaWP3QRJnE3YDYMj/H7lXWnYmmXLfmIzmTT8TiRf1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5svHh9K2nplrYqInLoW3pUa5rnfPEe7/N+lTZe4bci8=;
 b=3QsQOW2eWyPt4+aio3eSnaq+u3Xz6M45YQ/9n9QKNz8R+8q/dtsF4nGDVtbPeAZ8T5UbRUbTVXGuKJQVTeJlimLMdGjbdvW3qUIltkfHZZ/qlZ/dna9Zi9I9k3QFL5mLpDGaNNocQNZtrzrtfBArXNdtRX7odDmAFxPwWhQpDus=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by BN6PR12MB1444.namprd12.prod.outlook.com (2603:10b6:405:10::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 07:48:36 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::86) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 07:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 07:48:35 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 01:48:32 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Add a filter condition to restrict the SW ras
 function to be registered only by asics whose hardware supports the ras
 function
Date: Wed, 12 Jan 2022 15:48:01 +0800
Message-ID: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 695ea038-1209-4411-c5f7-08d9d59ff063
X-MS-TrafficTypeDiagnostic: BN6PR12MB1444:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB144417749A868C433545A185FC529@BN6PR12MB1444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBnyHoFk4YBn+O8c1sM1kgVntrRU2DOnKsnbScV1FKkJXott/0EyW7W3FE+ZUYbw8bHAjoNTbtMql8peCJ/v6+YQMz5UEv4wHAcvlgxbvvoinCPi3kQxBAxX/uVX8KMZM2viUXDjorUnDhu6DwykB9YW76XzPIymDXn5BQkAUOqpnOjqiQ60WwNbiSkK+B3++m1QkBFZ7XwmzDfRVkZVGJ2L2a9Abd6VQJXMqRhVF4GllSXhWAf9MN8/mKjbenXwsTV0zuoZfujmMdQ0lF55+sPS8deVop+D+euT0nf2jt82Jq8z+BhZBmHw1UMjfqJJQstqMusVhe6Cjz7rGQfIqexaUXIRzQASHlSZQTZFxZ5K/vS1YYt6ugrXxMqLEubm543DP7S3rCLtWriFoFiklju4mENKvZKb37fLRwUZ5chAm14eAxNuuEIOEYXTgoHM9+BbXi9T7lUWdv7QpANonw2Rddb5HNd4So54m04UYsllBlOBUACGhLeTCLvOVkiv+CEyCr+L8H20lM2WRbilYK+gOyaHZ6yEUsCh8ZRIkB7n+hOMIahu/esSy+nhMOnnjncwbFeXOrH/pI8TBVrgQupWbWmuTd+mKDfugFgYyUtAt5FFhqEZjVpRoCoqvKESS5RRgxu49RHN3jwjfhYXCzdEH0AzeQ1DPcDU0RL6/NfBsdHo+U+5Z/GCJVzqGa1He7mzd2GrEQP1AQvus+so6SNh0X8V4DMqL0MmMM2Z2VVxNhay0ZEWjIDh9SEg3fE2ZVH8ZNDc2gkLlDEhYa54p48MHNgtXkg4Rc8UwnfGx6B4PCcc7h7MPzNBkIr/fREqR+3KDwlDHB4HFtGfipBbqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(316002)(4744005)(26005)(2616005)(508600001)(4326008)(83380400001)(186003)(5660300002)(40460700001)(82310400004)(70206006)(16526019)(2906002)(36860700001)(7696005)(54906003)(336012)(81166007)(6916009)(426003)(6666004)(86362001)(47076005)(1076003)(8936002)(70586007)(36756003)(8676002)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 07:48:35.7347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695ea038-1209-4411-c5f7-08d9d59ff063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1444
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a filter condition to restrict the SW ras function to be registered only by asics whose hardware supports the ras function.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b1bedfd4febc..62be0b4909b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2754,7 +2754,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 		struct amdgpu_ras_block_object* ras_block_obj)
 {
-	if (!adev || !ras_block_obj)
+	if (!adev || !amdgpu_ras_asic_supported(adev) || !ras_block_obj)
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&ras_block_obj->node);
-- 
2.25.1


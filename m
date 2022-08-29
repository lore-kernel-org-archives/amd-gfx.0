Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F2EECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050D110EFD4;
	Mon, 29 Aug 2022 21:18:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654CE10EFA9
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlK4sSXN921dlT4mIIi8fZd9hj1QjIEokSl02b8k1GE1Flrrmy419dfvLSOdDwUF+bqhMvoOZZFX5vV4NZj73EwzqAuywIc2A/e4TgiGObqxZYVHJnT97CA4xSG6fCY3OikgTd7FfqWI9RF2P4FmqcOQvbQx8Ro6OS44UKn7kqzvmz+J6eR+y+TcIQR9SsDFwcolgDbz+wPlyuJZd8iFMB8dy1Akc2DX9ENcLioa2jroUmRTsqzQx3VTmDQ2DNEhip4PgmCqL3312voghqxgtbnfP3tXuSN6jBbAUg9j7pQIujg6IiK6WMCJIiIA4w9W8cEDmO/At/lrEOHym8uvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENgdTQlR+g11AJdEuGnG8E5DYfOjdNSismZz984I/ZM=;
 b=aIFeetmUxDpUuTV+Xud+4wXDQpiY4KzMlroHES0HFw7CHZTDUdA0O1DbkekrXAl5F4pfG1zMfGMLP/ugEaa/t326RFznj9X1m0tiGNSJyjCBZsfcluTawnL/IsdcJZvM0lQ9UfzhXxpiKshIwaa8t6THfuFsJCZ+Okt4RrIIy0SUEcQEXtW88iO9Wy98GZAe+fnpuHdhyqQT6S4zzQdoXddVu2hY6VKuQOHHGKDT2jjQWjCPZ1vv33ewTEdLxuzZxQ1XpGGgGAxmjHsHL2o/AkUIQn5deEpJKBubTy7JlIpqDHpLSIJO+REfpoPs3qippW1NHP9OeeTTGMwbypfRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENgdTQlR+g11AJdEuGnG8E5DYfOjdNSismZz984I/ZM=;
 b=RSJW9ABW6+kVzsbVOXq6RiUd0tU3wKPT9pikLNoz/F3qaEUkKarpdGGkYJiKME67XhS6mLkoPdVcGNtn6flxN+JAD88IBUmJjDwwikMvH7vPJFAdf8pdrNR6IuZaJzy5fcM+U4OlRg6luvhmTM4s/MWTiksSVeFmb32z0T8JAhM=
Received: from DS7PR05CA0068.namprd05.prod.outlook.com (2603:10b6:8:57::20) by
 CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Mon, 29 Aug 2022 21:18:26 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::11) by DS7PR05CA0068.outlook.office365.com
 (2603:10b6:8:57::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Mon, 29 Aug 2022 21:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 21:18:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:18:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu: declare firmware for new MES 11.0.3
Date: Mon, 29 Aug 2022 17:17:50 -0400
Message-ID: <20220829211756.1152505-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829211756.1152505-1-alexander.deucher@amd.com>
References: <20220829211756.1152505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6756b730-63ff-480c-c212-08da8a04033b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWjXEO57d5YLQHk7VAMUR2JLytI+smokxmMw7eGZOZc4fv2TGh9DulJXyIIUsxv3Vpn1tUlZprd3pcLjB567gnL79gPx6nlTtyQ+55HBM8Qit98ZgVUBgwIU7nH2aUXIaUazsjUVkWV5+hdP05HpJ2Z9haaj/bs9bKd2okA4i4ceQRsAbRRhnOKm1uK30dOxx8Q8GbqPKR84GIzjPtAJiBA2PleTsDqVR3QnJHe6I6WAlfl3FzDR//HoOD9JyvalwA4qSrEK2y5s1rE8gyrVSzAyCNfQfQMYSIeo2mFx3AAjVKEDuqPImg8E92Tc3vukzomSkPrfDUu2HlyHSoz9E71UyWFWab9aUEZn057/Ziko5i4SYZwViTBDmAgwbXAKo01V1nf5xQbnvlMVoN41ao/R9huXLJ6pzakMK/BMS9f4iq+ZVXT7Bo0J3Xq3FO4IgqZ2eSDU3o/pXRcMhyQCstRW3aTrXWfcrAnwAgIgvcsgi4H99DJf9NnyeKCGWVGuWPAKrul1pxJScuXCdB/Br1pROzxg2afhedO/68b0UtL3m+hwt7FItAZbLeiqxBr3OLPNOguzf+3IheJ7uhClAwVBa+zJ07MibBC6sOaXeVvq8O7LbVnLn8WObk348SowLoALf7lGtyims8OBK+3gFQEZzKoTsMLWsD1AfxiMxFPbGobtQXTFR7Z7KWABiT9Bzgs3pWmoQo6PJBBm9cNnnCSDipgPOqjI+CoX9relR6Boix9mWeVPsMeeulD4fgT7BgzC6atEQEEbOQihw5q5+sSPmLtfcJXWyR519mB82Mz6ugZpT4uQbJ41bIosN7IR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(26005)(6666004)(82740400003)(82310400005)(7696005)(4744005)(2616005)(40460700003)(336012)(16526019)(426003)(40480700001)(186003)(1076003)(47076005)(83380400001)(54906003)(6916009)(316002)(70586007)(8676002)(70206006)(4326008)(81166007)(356005)(41300700001)(5660300002)(36756003)(8936002)(86362001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:18:26.4159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6756b730-63ff-480c-c212-08da8a04033b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

To support new mes ip block

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index cc3fdbbcd314..b64cd46a159a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -38,6 +38,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
 
 static int mes_v11_0_hw_fini(void *handle);
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
-- 
2.37.1


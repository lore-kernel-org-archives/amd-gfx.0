Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E520C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 08:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2374311B8EB;
	Fri, 15 Jul 2022 08:44:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E0311BB3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 08:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu7tnSqTA3C6jzWXE3Rn+ONF6nqhPpnJ/TKQVIzxq0AhjCLh6JnBIAmauSxtz11yPM88YPgY7sXu3U3JqAQ6JYKJxp4ZZ6cvwO1KaWSM4vJ4bPBdBJhf/q8zTTwAZqi5WnG5lippjL0rL7fwlRc8XOKK/+q412CKEMUEdkV9MnfzU1b3nsaTol7hGwhhGgwzJ02EXYBdgS6tIqWAc6J9MMVqIiLnuDFfq9ktVnGgUYNCdDnUN+muLAO5dmWuckLIgE2s60yZFTDPz4+eD3JJ1HMA0SHr0OLZ3ksRsUne/mccURzVVTUL/eA49vX1YjWdmWjUhDBYPO5O/uy4PTCCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82va7fd3kUxrCSv0ljeJ8Hqbb1n+dHKJLUoq6/joXHs=;
 b=e9qqTz/kcm1p0E4GD2U2Z1OOrtqaUPFgd2RgfbmsWUizTe5rBtoVM9cLDOpAnjmwcb/jSV5OappMTlaSCucW7AgKP9+A+DkzKXJHSnR3sMOs5d4fXxhI6o7M37Yer3Gz/37v34gOcut4MF1Z+3hruFq6BbcltTmfi3eYPGR2SzRlPRK2vzKxmuU26rbkmw9WDnlLmQJVSb0+5nCfPfPe+Dx2QUn6IwSaUrfHViaVR/2FZ+1sN06TJ0mE0Riv1acRR/+Yqg+LHRxIGXvkQop+jLTHWErrEp1DdLFzQwVVm3abH04rQlU5RPEIHPB48ynkHShpyBTX7aW5/Uo+2dSruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.helo=satlexmb04.amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82va7fd3kUxrCSv0ljeJ8Hqbb1n+dHKJLUoq6/joXHs=;
 b=KX3mxrI3bJAsl1gQrzj0SX2wYmzB1Z9WhtVZctEnRxBxUqGahYKLJKX4ZyBGXUohSoQ+Rs22d5XryCdzXYky0WS+9COMu/16O9VSf8WpOIkhjyUCS7sV78fxB6ZzJhAHjIa9/7Ct8Bi4A3sSEynmpr6jIM/jsg19hfg9WDKIXrg=
Received: from MW4PR03CA0159.namprd03.prod.outlook.com (2603:10b6:303:8d::14)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 08:44:39 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::27) by MW4PR03CA0159.outlook.office365.com
 (2603:10b6:303:8d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 15 Jul 2022 08:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.helo=SATLEXMB04.amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: None (protection.outlook.com: SATLEXMB04.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 08:44:39 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 15 Jul 2022 03:44:37 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: skip put fence if signal fails
Date: Fri, 15 Jul 2022 16:43:56 +0800
Message-ID: <20220715084356.427458-3-Jiadong.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715084356.427458-1-Jiadong.Zhu@amd.com>
References: <20220715084356.427458-1-Jiadong.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc84f1a6-abe0-4a5a-8877-08da663e413f
X-MS-TrafficTypeDiagnostic: MN0PR12MB6079:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUnB6tUoJi8J7nilhFjoy9G4a6erD/Tym7uqdH1qJ8pZgAn+WcjTUfGn9z7SAWrU/cI4+01jW4/g4KaAyiohZCDC/VyRQYwrN3awGU04ugOuXMbZaHeWFMuMN9JdPhG+p1e+Su76UTcgyeX629EWT6nIUdYRGP5vzcuw3JRSdiZOnqs+9Dvq9h0+/LFFQ8qyZ0DopH/AH7D9sHUF9o6/t8ruJql/xS1cROYbKsB+ROdbOs5uFJ8t8aoiZ9XHBSz9AyFVrlmja3wk/d6v/G5tjbbwyDmqMN5K2s9pd0QP53pXLNCWn8hf8HB6cDVBmfyM76exsK+dCZLOcasmWufUmAH0IN5WCpQSzpAT/M0V/zFlWxqXIHe96IjlXGbh/88+lCa+SPA10V0Yo1HAIBoKM7Q7nRAr4ZVVvdN/XbEgNG3Jgqfdfvwqn/li1wzteX2+h8utUMe5ph75pDA/ip6ORNfQujEFiC/yHv8I3ZKgoyjZvIOtsUTOOTH6M2IWd+OyDBJ+59hW170LCfBH8XId8300FugRkypI3o0qb0Z2lkuS+Jguc7PlmV76skaB4+pVDg5LLNmNK16NInKpmTbbon0RSeIOx0B1VwmTCpaU5LmVrp3EQp/WlUHiiwJ7uu1TGv4oi//OKo/wvBtmFXMaoISM18FQiUEBTxGaVTMyN1lp8tQuuqeZMKw0UW8GM6u7zWlYU8DXYRQDL4IEFaKewBJQ2bCKSJBcWOLXo4k0MatB4wcbV/mTKjCSUZqw5GhyxLZ3O1pcui5RlhONFuXdYx+bnCtnF1Q+64YDq4zFoJyVOVSD2VYy8Dh1l038M0Dz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(40470700004)(2906002)(82310400005)(7696005)(26005)(2876002)(41300700001)(6916009)(6666004)(336012)(4744005)(40460700003)(2616005)(5660300002)(1076003)(82740400003)(78352004)(8936002)(42882007)(81166007)(35950700001)(47076005)(70206006)(40480700001)(426003)(16526019)(4326008)(54906003)(316002)(36756003)(356005)(8676002)(498600001)(83380400001)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:44:39.3003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc84f1a6-abe0-4a5a-8877-08da663e413f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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
Cc: Ray.Huang@amd.com, "Jiadong.Zhu" <Jiadong.Zhu@amd.com>, aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

Dma_fence_signal returning non-zero indicates
that the fence is signaled and put somewhere else.
Skip dma_fence_put to make the fence refcount correct.

Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f4ed0785d523..93c1a5e83835 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1500,8 +1500,8 @@ static void amdgpu_ib_preempt_signal_fences(struct dma_fence **fences,
 		fence = fences[i];
 		if (!fence)
 			continue;
-		dma_fence_signal(fence);
-		dma_fence_put(fence);
+		if (!dma_fence_signal(fence))
+			dma_fence_put(fence);
 	}
 }
 
-- 
2.25.1


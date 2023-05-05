Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F39DC77B75
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 05:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1440910E56C;
	Fri,  5 May 2023 05:29:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4917510E56B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 05:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB4bqxtcHrDv5xWKJgtFlpA/w9riiFem3tfl7saQL3B4Aa2CT7Q3yTBx0XI+T/RDHhD5w9e6AFzrtHuvkt33g/8r/6hlKyP5hJPFtoCg0ZIxTFSMdxOpWVDdugB7XEf4+/vpajj0TW7jhm1wk6KVoN/Nagp8+pGVwO/i0llzkyDVbsjFb67sHPokYaRaPtUu+NohVzFSiBmvj5L9uy4UyCODuyK0pin7zx7WsHkAfKuHuDgbhdxFXMinjkmmmAeaZ2CE+v4xomnbHGafNrcXyn235AUpQWseCE07u5KZqMwri8v7lEh7+BRx3IqWVdZa3KHzhvcbwcdWu3bVvNtBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqu396cuLCUIief4P0SOm3k3pZFQzQpPHNA58K62oB8=;
 b=XYuyLyMROPE9NyNawSIgQIdtwCOpU17KIjvpyKhZY9vQS4Dshvc4Sa8RYjj3OXPmKgrht+llKNOTXukXQUoS40hlWWD4XChMNZWkPm9iXiJEYjpZx29VswLu92fF1G9O2evbsHhN7+W7b6PHRojhN51j4XuF6r3IdBKN/1s87z0riFn+meNSYCa9COUVMwQdJpvbBHmwZ5MJz5vwrKmFMbAPb12psKo0CF/l83ZkWtBMcMteiD90z1UaWhb7h4vFn0oiHyJ2wLVbwqWa844+e6ICYTQnV8yCZRq68fNTKB0n0MnYkvEBzrS2GkXvKZBBWbGbmDamwzxWa9SYnRUsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqu396cuLCUIief4P0SOm3k3pZFQzQpPHNA58K62oB8=;
 b=2wVFB1BDZ+SUe8CrPPjI019YB+XBvjxZcRkGUqMsLWweim+X2PK0s7owqfERphPjc/ZmP5PGaEyoena2CWCOeSMLYDgFMXGfFyPzZpidauYWHv24R9YNcuE9wNog5OMGb0itpwhuwGwRSbNE4TGh94ZRLveO/nsLABdpfoGgGU8=
Received: from DS7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:8:54::10) by
 IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.22; Fri, 5 May 2023 05:29:42 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::ab) by DS7PR06CA0041.outlook.office365.com
 (2603:10b6:8:54::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 05:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 05:29:41 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 00:29:39 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: print vmhub id when no VM inv eng found
Date: Fri, 5 May 2023 13:28:46 +0800
Message-ID: <20230505052846.1489935-4-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230505052846.1489935-1-yifan1.zhang@amd.com>
References: <20230505052846.1489935-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1fe8fd-0e85-4639-231b-08db4d29ba63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iU5AF5nugRw3+HWryK8XQeJQT/zUIbRAPZupQ9kheHi4d59lJhSdeAr6GBQLrzFAtXmzvHSMbQ0LpixEzyAJMTxiY0weV0zBV80JGpXMrBhaN77LfUO6yUqWrZEQAHNupgkOGRz8UwfUg+keT0GCC7R1ls1ukcls0ALhycqxQKjBQdhLCRgacRou6H6I6OF7f43WYIOT5LYgpQs2t2kAN6j3NkrAdQ1DDhFX0BEwiWLBKxVArz5cl+uLC4kSIXD5hPekuhcZPXSA0CC2qrG0n6UC+6SgMgxwFAGS/+q6M3C8mWkLGZ8USkG10pB5Ru2MgfUf3CjW/2AwJ+Hmoa5vDtnijtVVGKVo7IKbk0t01iM92zPySyrQsApTln543gWp1LgsRtcfXVq+w+rp2Ifmckbn7+4IA6r6rPnoR1p+aZa/Kn4BxvgFzVK8MiSmzFKe6eeYJBnztGe72gMEIAG+L515ufXQtKjh8B9qtxz1KSdSMrmqH8ZxGVrGTVcwasj5+qNu79zM4HGvJl6TpnROii7kXfyiJ9z8y8Er0KcuG3nj0CFfQ4blMfBUTY5Pg93Zmnxu6wmC2DXSIlJwlfd4Fu6FH6UIE4EHXQpo9p9+poQhBYZkukiz5PdZaBVUtF4av66DbSNEUxBDL5KAlLw8zBnXwQPwmfHbDkq3fKhvR8udkcyTlwHm40RQe0NDVazzmNebKgnO7jPZ01W+9GnIKZk+YSA45xm9blGOycJuLOA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(8936002)(4744005)(6916009)(70206006)(4326008)(8676002)(316002)(70586007)(54906003)(41300700001)(478600001)(6666004)(7696005)(83380400001)(5660300002)(336012)(26005)(1076003)(40460700003)(82740400003)(47076005)(426003)(186003)(36860700001)(40480700001)(2616005)(36756003)(86362001)(16526019)(82310400005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 05:29:41.8176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1fe8fd-0e85-4639-231b-08db4d29ba63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Lijo.Lazar@amd.com, le.ma@amd.com,
 Alexander.Deucher@amd.com, christian.koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

to facilitate debugging.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a4ba2c50a5c3..abdc2923cb62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -561,8 +561,8 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 
 		inv_eng = ffs(vm_inv_engs[vmhub]);
 		if (!inv_eng) {
-			dev_err(adev->dev, "no VM inv eng for ring %s\n",
-				ring->name);
+			dev_err(adev->dev, "no VM inv eng for ring %s on hub %d\n",
+				ring->name, ring->vm_hub);
 			return -EINVAL;
 		}
 
-- 
2.37.3


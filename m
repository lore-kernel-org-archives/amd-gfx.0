Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF00ACD54BF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 19:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D6E10E31F;
	Mon, 25 Sep 2023 19:52:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340D110E31C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 19:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj/TrkJ0Rq+N/z73NbFCwreOomjTXXm+p+NrNHlrzyqH72rrFOO0hSbWev65DNwK1KMlE1zrB1iod+KEZaN3GFs6616URo+avHc/qe2tqF6SCFl3gjdT0Xlcms/FQKQT1kJPaU43WYonmg/aEUZQxcek09N/aiR7U/KRcyQIWxbbN++7a+Fwmem2Z3nW8hVAoc9ODuX6zOmTWpXC4H0pzB5olpkrg7feH1fHn0OzuIdohS5wwPLc3yZk3hhOmwqQWRq0dhTfPCQHJefQfha+S1L0K3Jj8TVpnR0+V1dwzV2iD6xyXB8VmFcXVfxz5zW9Y3CtCQp1QuY5W6M95Qajtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyWkIhOD+5mBuvfxRtQC/VaaluP1/Oelqw0XaCtIoAY=;
 b=aKzqzAsWiMkRNz57gHz4ArOJEppdmUjunYzP3IcxwEiEvdtK1aeUhnzTsUYH+fl09WQZuqE7R6bM1RHc3RJ6p4kO1K3r+44ZWeFpz8po5vTPTuPVf4l0oTw2N0LCJnB72XAq1xCQxAF50byeECrW56s3qSSpgcGA2kaZJ6imANku0RVA53RXUEDPwmYnnC4uneFObFDKkIzYuWtC0YHb0JYT5knKrTpuf5jrMFT0RJsSzYYEJ+IPVh1krdmAMsurg7nwTZPxDMOyt7vlWfTpv9uCzILLAGokTAwin94QI8MFsi76lXxf2390qdPEGLNrGVpw7Yhpz7vsI+3t9wXZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyWkIhOD+5mBuvfxRtQC/VaaluP1/Oelqw0XaCtIoAY=;
 b=WHhQc0/JUVo8OySBY9XXPvIbnyigdE0SUDYMh8AygBDGuqVQnUR+tFr3ll/kjCEsVCLWdrlIhomED4S3kQi9+dkH14UOi3jHxDvH0n5ftvJXvOjc/B3xc7leGqCuzctOoXv11yxrbdOtFjCEVpeAXS4eT4ZDxtik97R2zyezMdM=
Received: from SJ0PR13CA0127.namprd13.prod.outlook.com (2603:10b6:a03:2c6::12)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 19:52:48 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::2) by SJ0PR13CA0127.outlook.office365.com
 (2603:10b6:a03:2c6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.18 via Frontend
 Transport; Mon, 25 Sep 2023 19:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.17 via Frontend Transport; Mon, 25 Sep 2023 19:52:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 14:52:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amd: Drop error message about failing to load DMUB
 firmware
Date: Mon, 25 Sep 2023 14:52:00 -0500
Message-ID: <20230925195207.124850-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925195207.124850-1-mario.limonciello@amd.com>
References: <20230925195207.124850-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: de8210ea-0751-4f29-a30e-08dbbe00fe2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdbMQHX51711X2dRC6lrBgp2PRpVtLO9I+wk7lhHwzRpX0bjbLwBEIz/vBsn1LYDaqPiN7tZ/dql9eqyEIiqRQYlLkGZRczC+5GF2Ljqqh7oTHVS7My7KlWCFKiSLvTM04X4qKjy/zamQw1ii0zlx0uDyAbm/ri6u/88C9Lnu1XgInwdwrDKKCqomV1l2WLmExccomvVKDYLiEIj9K2VtwVTUigyrGcvvrPJfbJ0F1QOnO66frdRK4IwNhkcCS+ufCj5FlmC4Dxv1ACV5v2Tc1QApvN8Ol18RQodykLM3X44JfSfsScmbsAet45IRArfBUR0bSWZ/213oRImOqJXGaB8vI466FuJj+4d4Ew5S0o889YFegwIqJf00dvKV+99+iNvdGUPAOZHgFUIYU8ooa4ezv3UQpufe+dM9uMmkthr9VhyxDIHchWHWVH6SQjcxYYke8DvjNMj29nIyOXLKgZP/cU+HzjVUt36JWfo/0DjVyDxL5FZFhwvQpkkT8jJ3EBl1rmuhsAai5HO7w1HMRu38sKWvMEzBAG6cq0HN7bu9i9PL8SLWKjG4OW9t91Rk9kpfUmrCVQSSwQHmzwqXue6qdXyP2pzB3oS39fOgQnJDg4PrabYgl9xR/6Cc4qFqgJaV8HGV1qJO6q9hyMO03fg0co0JqvYz0i0JJzzPDu1Mm1j7416yBCeslTMKDgzZEHcUh++R0K6WxW+stlSBGhoWDiVVCDs6LMfukejoUeM/o1YjrEE8vQxQxVHlXFDfAc0PugCrpGbr7g7HCcbqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(8936002)(44832011)(8676002)(5660300002)(4326008)(7696005)(83380400001)(6666004)(26005)(16526019)(2616005)(2906002)(36756003)(36860700001)(47076005)(40460700003)(478600001)(70206006)(426003)(316002)(41300700001)(82740400003)(1076003)(356005)(6916009)(81166007)(336012)(70586007)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:52:47.5266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de8210ea-0751-4f29-a30e-08dbbe00fe2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The error path for DMUB firmware loading is unnecessarily noisy.
When a firmware is missing 3 errors show up:
```
amdgpu 0000:07:00.0: Direct firmware load for amdgpu/green_sardine_dmcub.bin failed with error -2
[drm:dm_early_init [amdgpu]] *ERROR* DMUB firmware loading failed: -19
[drm:amdgpu_device_init [amdgpu]] *ERROR* early_init of IP block <dm> failed -19
```

The error code for the device init is bubbled up already, remove the
second one.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f06136a0bba9..7e6a693d6369 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4758,8 +4758,6 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 		return 0;
 	}
 	r = amdgpu_ucode_request(adev, &adev->dm.dmub_fw, fw_name_dmub);
-	if (r)
-		DRM_ERROR("DMUB firmware loading failed: %d\n", r);
 	return r;
 }
 
-- 
2.34.1


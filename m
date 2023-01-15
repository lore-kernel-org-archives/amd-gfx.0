Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F447C3DA78
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Jan 2023 19:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D11810E08D;
	Sun, 15 Jan 2023 19:22:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F7810E08D
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Jan 2023 19:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgTBe6b22qKpIeUEfLOItNpnqKIxWgPPR5M1ALYjrBkAFxFS5yO11/PLAnUv2Q9o3ZGbT3f7Rk5sUV4pfilOaneB02ahnhHXVj/OVORLQCufSBXbBkPH1vWmdqwB4YRG54mqsHQuq2ZS74neNBax9VeqfAMMAFgaxMyx17Flqhxfu+wotiLwJHhCUp4+ZNUJB0i27aIVNA+hzNNLpS1zktr/2jnr15fhR7lM/t/HWvWsmPv8UprvZNv1ZovG1huaW40nh3hUFQHrJSnxYbJD3FKoS7IINfKl0BlRfZ6p1x0MZDLUh1Vp/jqOE4TOTuG39hzmPMOZCXc2QZXrKQUM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huK7v01HRN64S54cEAmyPOn9rJFy0mOvF+QPT3+XxSk=;
 b=NABpu23hB6bq/yzHbIEEm5/2pODcQ1kiiHTPd+KdrURWz82XeMkbjH6iXsRM3LWIaGBBH92r68ajSou7XNp2WuCuqdkRVWbC0kFfGt4Nkr5tZ/f9rSKLDkIZKkmaRQq003ONFkB1HrCQSynIjqJwNxHGhFiGO7+zNTrnLgIO53qsoVO8S2x/tqsrGfmq3DERd1JMvUTBnha4QrYmdIwdaa/UOqY0kO45hsSO8JsGlRUDeuOr/i+URbbFRhE/pWvRmkK/NZv1xrlCIdyMmhkzTuugQLF1sH4NspsT5YT1rZ5yoznuBX/536FV7QZUGtjqyr0s4JnDDCKuEQFGxAKZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huK7v01HRN64S54cEAmyPOn9rJFy0mOvF+QPT3+XxSk=;
 b=M60JAMvGfo3NiZgWPpAR6jQRHuEDA+SJaWKj3ZAUnEdA3dDLWhTSClDvKs0S+nKv0mLesFi6/rwz2Sg4mXnRPFZNmn93FTgga6Q4Uv2/vwSSpeh5sWUBzZDwwwd6baYf9swelwEuuU2iFyJVI1dLhjsb2unXSoU9gpHGKUHq9Do=
Received: from DS7PR03CA0333.namprd03.prod.outlook.com (2603:10b6:8:55::15) by
 PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Sun, 15 Jan
 2023 19:22:08 +0000
Received: from DS1PEPF0000E650.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::30) by DS7PR03CA0333.outlook.office365.com
 (2603:10b6:8:55::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 19:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E650.mail.protection.outlook.com (10.167.18.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Sun, 15 Jan 2023 19:22:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 15 Jan
 2023 13:22:06 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd: Evaluate early init for all IP blocks even if
 one fails
Date: Sun, 15 Jan 2023 13:21:44 -0600
Message-ID: <20230115192144.4566-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115192144.4566-1-mario.limonciello@amd.com>
References: <20230115192144.4566-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E650:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: f66bb073-b878-44b2-34cc-08daf72dcb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaUzCMBBL8eMBu+Eyg2du//w+MR0QhezWny5LleeriDf58lDk7qxd0zsPAkcfEbvoFPiTnZOPhcA1mmT7oQIbeXWCOaFmzVM8Ffg692hf1VxNQ+ZbcqjEanGTmodaPRW0PpkOIu33K6UP8ANehamlOxdlrk7vFZl8LiD1Q03MyEpbl5VmAtnOM17U8G7ZhU8d8ERmg6fODzTaj04FAE0Oq1TtdLjMFDe+OXqhRhtT7TxVhF0FZ/DSkedhsiwsgwbu0DnUqSYyq74DNPKv1PVZsr3r7k+Dzxr5gndzWkAJ0pn54dMb8BqHZ8TLj6Ki313VDHfwbZzhxbbAuHI6P4PA1OroFKuBTOjk3lgu6WHpb9rtC1SW+vNt3CU7BANqVQplDCfq5RGC162biw7un3kYjhb9lgPE04vmK/xu55bpMD6crXEl5wiqg1E9/1JDKbtKMhswnRZbMgkPJ63oFtbm6ZPkej2gWvARyUg/SnPcaqV1KUP6XKLpxM783rxMTGfvdJsSJgxC+m9PRfOWVs4/LUyvz8v4r7eZFmcEmmH5SmnVl4Esp4bTfzeC3Aaq5No9kWRHtaUUYgyq4mjiHur7YLs+EKowObCs37kXzKyBCm2ykCt8tB+UFkXVAx6CRcvBGr8mLsZ2tDG5+EUwDIRlnFSZRgqaLb8DNjCg94aF2dd7PZU5nV3fOMIHY6iTm+Ea4U6BolHrRTKIB6/p2vWQzwcXvzbulwndn3/YG4Ewiw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(26005)(6666004)(82310400005)(16526019)(186003)(36756003)(7696005)(82740400003)(356005)(81166007)(478600001)(86362001)(40480700001)(40460700003)(83380400001)(2616005)(336012)(1076003)(36860700001)(47076005)(426003)(8936002)(5660300002)(6916009)(44832011)(316002)(2906002)(8676002)(70206006)(4326008)(70586007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 19:22:07.7532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66bb073-b878-44b2-34cc-08daf72dcb09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E650.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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

If early init fails for a single IP block, then no further IP blocks
are evaluated.  This means that if a user was missing more than one
firmware binary they would have to keep adding binaries and re-probing
until they discovered the ones missing.

To make this easier, run early init for each IP block and report a single
failure if not all passed.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8846f026eeece..2f904bb545fe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2074,6 +2074,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct pci_dev *parent;
 	int i, r;
+	bool total;
 
 	amdgpu_device_enable_virtual_display(adev);
 
@@ -2157,6 +2158,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
 		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
 
+	total = true;
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
 			DRM_ERROR("disabled ip block: %d <%s>\n",
@@ -2170,7 +2172,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 				} else if (r) {
 					DRM_ERROR("early_init of IP block <%s> failed %d\n",
 						  adev->ip_blocks[i].version->funcs->name, r);
-					return r;
+					total = false;
 				} else {
 					adev->ip_blocks[i].status.valid = true;
 				}
@@ -2201,6 +2203,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 		}
 	}
+	if (!total)
+		return -ENODEV;
 
 	adev->cg_flags &= amdgpu_cg_mask;
 	adev->pg_flags &= amdgpu_pg_mask;
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABB0CA100A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 19:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9BE10E4CB;
	Tue,  5 Sep 2023 19:36:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B48910E4BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 19:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idfoVOa7HRlutpV6+dm2cLRwxKFf/ZtDnb4qlve1ZzRg0uWQUQ4+V71uenK/O8K7uTSM/El62J5ajwO+4Ek+/YBBeV8RnIxo/AAKhuf23DfIT9aJl9cATmWaWRiKdAuAETf9dlCMIysCASo8PWLSuExKQj0UfJJxKgUlkD5s5B+kvWOcBN0Nb+RYNHpU5SKLDC7E4uC8HxpJTp51uU3em7tru/JZoeNHYcYpGEU7bzBbSArU6MvSmOUGtJsyEa20KE8BKD1JviNtxzqYlIv9I3oDTa/vb4dRbjqjQR3TCTpBqMO66TFOgzJjavFEFQAsl3ICsFkDDJetbv3EHLod6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zn4ld8WMPRlkXBVGwLn8ipKw2bfYObraqNS1ktDWwo=;
 b=MSbU+eBDAi+o0O73/SevYEVtMo1++SZRGOV9xa0Qe1GUAs0SMuA8AWbh7FJfEJF2Is2VDXgJ/iFyZYbhSm6ysjps7XwQ1wW2LbgCda/5i7s5s6UdEbNwjQ/1ChrOykxPvzzMjFNr+1tHA80/JdvX36LngcAl1GMuikfUEvFRJSrX4ZEKQTxvGceiRrBkbitF4r7I3a20qG/EqWlyzIzIjSFlh0foJYj/By6Olm9au+/eNYfK2HZeuNXiCsodZPN1I7qYHr26No3zHmRTN5JAH/D4BjbZkRfbrNyxed9IxITrfCzoqm1VhwAn3zT5TlOcWTYbnL5WA3c3zvTxkxtggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zn4ld8WMPRlkXBVGwLn8ipKw2bfYObraqNS1ktDWwo=;
 b=FTt9aBFYornTENlTxD4ufB8E5oG2JcmZvNQSie1e2Q6cb1Q+gxq2VrYDW28CbR4Zw5WL5QndmgsPqgK3ACM69gxgkPIJ0Qr5VuPBnLuJuNEimoItdtVTmoE7VNYKqJ2pyg8rRXJ6SasIrfKrK3f/6caylGL4S2tDKApmt5vhscg=
Received: from SN6PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:805:106::40) by IA1PR12MB6281.namprd12.prod.outlook.com
 (2603:10b6:208:3e7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 19:36:38 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::8a) by SN6PR2101CA0030.outlook.office365.com
 (2603:10b6:805:106::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.6 via Frontend
 Transport; Tue, 5 Sep 2023 19:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 19:36:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 14:36:37 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Enable seamless boot more widely
Date: Tue, 5 Sep 2023 14:25:56 -0500
Message-ID: <20230905192600.32449-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 176d0279-b6fa-4067-0203-08dbae476c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeQWL7NtezvduMWF9OVoWxdxar4jq20iZhNL3pAW45k6WLgOiR3fq0xlcLMDBFoFNh67oVwSoGu5FmAOG5joUUAL527OEYHUZbvPXGZBUv2Fizj+FyQlf3xYSnuIXG3jPKg+WImK7zRkOTyk92PEf1CIjHttfLqUS25IweM5jd52TQq6f6r5xLUN1EoJVBRocBBhszERXTv6JnPixyCcPVOHqHKuRUVV3Hv9nRUDxSCR5LDZf+1l5oz1Z6sswtLhdH0K6Wc1Hw2OUyIq/fAmphzIetWKvpQN/PRuLTA5q7iyjRHZTkhJF7JNWcSW3MgUG2vskNfh/HsNXVYfnOQAnVRj/9Ujc3pbh+xcyk+57UeH80s1YT/0Hiuh5IH6mlQGlJtu8FbiabQD0alcdPyCppd055XKwg5mNJjPPC95UjkxrXXCIsYECkn2OZSyikcdSADCY5TY2cnvbQaxqi2izx7H5nOObZv/b284uQnBFDgqWwDhMsMOwIaU2p9UnI4010mYdsUheRsGPi/rZ7uYyWbC7kjvlpwKXo1WY5Pg60PSM0fRsZyC7jQM+6yn7TLdvguGlh9wnIOaOt/S9XmwdIQ4jxNhMKleO688FItAeg9Bt4eJ4gKVsV9o4KYC8N1OoJyyRUaN2Sh3ppn3qQFSzL1rW3PX5hqlFa6S3seRY9guRlL0czvynMY7ltQp6s4IDLbr+79EQHzV7mnhNeEZJDL9fFMTAbwK/O0dEvkwdqZTtMYPr7R1LyScSQ1bp7sLclhxQ+p2/WNVsFECUHCd+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(82310400011)(1800799009)(451199024)(186009)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(316002)(2906002)(6916009)(70586007)(36756003)(70206006)(8676002)(4326008)(44832011)(66899024)(1076003)(41300700001)(40460700003)(16526019)(36860700001)(7696005)(47076005)(336012)(40480700001)(426003)(26005)(356005)(82740400003)(6666004)(81166007)(86362001)(478600001)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 19:36:38.1331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176d0279-b6fa-4067-0203-08dbae476c10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
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

Seamless boot allows keeping the content on the framebuffer from pre-boot
so the screen doesn't get "painted black" during boot process.

Ideally the flow looks like:
* UEFI F/W posts vendor logo
* GRUB doesn't show anything, but silently continues
* Plymouth starts and adds OS logo to bottom and spinner
* Simple DRM loads, no mode changes
* amdgpu loads, no mode changes
* Spinner keeps spinning
* GDM starts up

Previously this was only enabled on Van Gogh, but this series enables
the functionality more widely onto APUs that support IP discovery.

This also introduces a kernel module parameter that to easily force it
enabled on other ASICs too, which may be useful to adjust policy.

Mario Limonciello (4):
  drm/amd: Drop special case for yellow carp without discovery
  drm/amd: Move seamless boot check out of display
  drm/amd: Add a module parameter for seamless boot
  drm/amd: Enable seamless boot by default on newer APUs

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 31 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  8 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  6 ----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +-------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 --
 6 files changed, 42 insertions(+), 30 deletions(-)

-- 
2.34.1


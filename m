Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AD5C25B67
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 11:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D181910E978;
	Fri, 27 Oct 2023 11:33:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF25B10E0C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 11:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGN09VlIzVq5NXsMXDdP3Gy9UyFSV6HAadR8M/fyQS3KrRch1e0EQyiXiE4d0fmqgpJj+7snnCTKegQMPOeV+YPlT8dQg/VwNYzqONVo3UrBwneW+Ee0VdbOYMSxNnzbDnMDViSYOAzGs2Iqsn8La4w0HTyNSvWMurl1cG//WVqSW4eBcof7mLyoV5byKiaDUU4BNqUX8tjdGu/fnHAHCiIZgQxqcmNQqgUTulBNb5rfToDyPCgYwDIQGKDlMaDgjsWvYnnNciWdPGbBve+M0VtOfSRrg63h/PEG7qtixLxD06QdIakC3bROwEnJYp1doA4xwCMK27+XXLf25Z01PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6aIvN7akMa5qqnqOdWh1OYWAg3zHvW0B8vwJgBDElI=;
 b=R4C8RBb4RdT4o30QXpeTGxlIAltmkiCajMrjojMWcrR7mmrulemU14EbrAyPjr6vybJy8svdRdA9LYgxkMR5K06K5C3sBE7g7t6H/czjAyqmWFQJepA1m+hiRc0Ggtz9TUE521gv3J2shSuZygEHpvt89bWNIY4/i5dxSSpanhDIo7eWHXxb/T2cEI/PNddYb2VdHQjuQVgJ3uRi1mXDJMQznrvt0XBGzn+MstRemwmmuLrTC6CLyRsafsNKHkNGVfNkfBKQxF0mr4G0QzDUW8tTRMj4BtfFlTvOM7XH7A3E6fFrhSv4M4KX3csW4BpSIKUbhHhRTj8bK/dkobEx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6aIvN7akMa5qqnqOdWh1OYWAg3zHvW0B8vwJgBDElI=;
 b=lHgkcQo5a/84XyOOUTvXqnB9quGikpx+qXh2FohUDG19kJMfFl8YmTV9IPTAU1TbvvB4mamP2pvEhozeRXW6D0uSWouy3Nb+HEJaaC7Z/BdCS11saFj3bmuLGfkU8gtBOz5LfaG+ckiE7RW1GH4lcr485EWOsrlILtlP4u3xfB0=
Received: from DM6PR04CA0022.namprd04.prod.outlook.com (2603:10b6:5:334::27)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 11:33:12 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::67) by DM6PR04CA0022.outlook.office365.com
 (2603:10b6:5:334::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Fri, 27 Oct 2023 11:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Fri, 27 Oct 2023 11:33:11 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 06:33:10 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: set XGMI IP version manually for v6_4
Date: Fri, 27 Oct 2023 19:32:53 +0800
Message-ID: <20231027113254.20958-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 5734a05c-c42d-4be3-91db-08dbd6e08086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCnL56Da7fmx88TTGP2HaAfpLcngOs1uYoAVDpKN3p8Pe4B5rRKIPi4ESK3lF+ca4EtVB1AU1xA/+kjH2qR5qMCa8WFBkA3o/jp5Ni/mFmce/dK+ZxK9je/aGcNayKSnT0iZ2VYOeUzEGaOhRMspTsdZzD1VvrjyL+BGQllGo5bMH/4xJX3pysuPhZyQ3SG+1RVc7jKCP4YD4CjvKhTDiPYHZ/PEjv1zQRVoOGmpXS8CU5TdzNzoFT+5RkAuM5rMwsgRGwYLOAsJLzNnLlGEtRncSlDrSVrA7+xccg59Kps1HD9uIxBpcOxB55nz2u2G58oHs0as6DRURjJtqPT5RoXhtH4IIsZIrbmdnJnHAO9hpdyBRfFZgwVJN+5cTVK2MxTixwZFhNHiWIu3n3gTid8huXmb/F0Tp76J3U/jD+Z0NtXN02slYu6iLTKRmwllotIaHdeMZkef7mFcCs157nEzQs5f2jVsAyYRxU3ROBK4ABb2d6LfQYAiXNrx8YoE+F2vDfAFVTGW0V0EKGh2Wm7FrCJDXq3IMn1vGItgAS7Cs71fW9680MO+OTtdbfe9qgOoH4oA2WeCecUDEA4c/jtKKGEE7H4X2NhQ6vkHpo4m0nSKWpQdZynbEmn7iIcHmhonaj17pQ3707ob52jLR3EnJMWxKYXVhviB01Sm1cl4joyo/Lj6KiboSxrN2F6ESNwgSD2x4/ID930BQQCkQIHN8pOIkLs22x//AgG27jFj3KeEksqwmXr4sfCoKyfrAdlUXLduEtwbsiIie7W75g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(47076005)(26005)(40480700001)(336012)(426003)(1076003)(2616005)(16526019)(356005)(81166007)(86362001)(5660300002)(4744005)(82740400003)(2906002)(8676002)(8936002)(4326008)(41300700001)(6666004)(7696005)(70206006)(316002)(6916009)(70586007)(36756003)(40460700003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 11:33:11.9597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5734a05c-c42d-4be3-91db-08dbd6e08086
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The version can't be queried from discovery table.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0b711bac2092..d22f22d706e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2464,6 +2464,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
 		adev->gmc.xgmi.supported = true;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
+
 	/* set NBIO version */
 	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(6, 1, 0):
-- 
2.35.1


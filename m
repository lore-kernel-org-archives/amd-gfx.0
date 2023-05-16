Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C1FC77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 18:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F45888647;
	Tue, 16 May 2023 18:15:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331AF10E05F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 18:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPgxqQSmWooYMcK7n2vzQYXeoyEEZJuiXUPg7Y3Tx9DHlm7XmwWdpG/mwsCdTNRCxOLfVed1LRv+ZhyfaphwBHlYnIVG4ombyyt2q/iBTs+tPc/VeUA/9+PxmbFzbqtzIoErLV7aAvMNQ/6klRRAeFmRVuUuryzPtPNovMXpIPcZpYWz8+IdyXHl+hjvCVV/JuHJyPjCqonjKs3E6Z4VxEnqkTn8SenYMOBqWWxDYk87Nn+D62quiTvgag7u5SAVyuFamQb/czMx1/r7rgxoEA3gi/ACI3U4ydMA4xsgzhKgLtpnn5YDmrh1sr2yMt1edsnReq8qz1q09onvdLphuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/S+4WlFpHj075+GD4Iu6Wez21SOnUlWCepL8csbwXw=;
 b=eOjqeqP8zM2vYWSFK15V/U/tHmUywzoYuHNly5riG5GdLjazBulGlNgML8BwStKAOS3C1tfrCCQXp3tijF0YmSL7xvTbWMAIm3I2PmST3lsCpf5BOoFGmPkv0XOM+7Gw2djxFTUtLmM9NxdebktaJxuQ3CDNLAJQaKvR97oGDirj5oFhN/V1kKq6XlbnOhxs0zXVaXdHveMV/d3bSi6zlJ4OzgDKRWB4/U3IsHbO9b65seEFth4TMOoUzqdumbo0+MCaDlsogD5BKOpjM6tbDDHuNf6I49G1WQ8AvJuEYycJ/4j++qhCq5lfKlHg3A4YlLV0+Tx/bPiXKjG9YEjJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/S+4WlFpHj075+GD4Iu6Wez21SOnUlWCepL8csbwXw=;
 b=4aNCoJBOyZbF0X3UPa/qOeaxHEPuB1jblBMghWurbT4YuBcR2+xvwm5PwmAsFj6n91u0iOm9ZXOar7SZg/MyjLPshEQfHMoBcGWOQuFgwn1ZbSFbFX7aCKEM1c+KLtqMPcqdk48+/pL/Nnu8d45CKBwk2opNnSnWue1H/SeVljE=
Received: from CYZPR02CA0023.namprd02.prod.outlook.com (2603:10b6:930:a1::21)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Tue, 16 May 2023 18:15:41 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:930:a1:cafe::83) by CYZPR02CA0023.outlook.office365.com
 (2603:10b6:930:a1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 18:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.11 via Frontend Transport; Tue, 16 May 2023 18:15:40 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 13:15:38 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Fix DCN 3.1.4 hangs on s2idle entry
Date: Tue, 16 May 2023 12:52:11 -0500
Message-ID: <20230516175214.3491-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e0691d-b1f1-4072-c7fb-08db56398e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eq1WugdvRFP+uIt2fMuL8vC23TTwLvI4m0b+Pk14HLKyuz6Ca7LBI7+W0pDR8+GgQHCqyjYVbZebEPwltuAAOczNMD8jfkNLBwrbzu30iuHI0Z1+4PGd2Rc9Xm/mnzW7AVoxszIpeKKPn3NvbYETe5ZLtwR6hp0+FUlTshYDqbup60eN+ZgLhDmOHsnELROF9EuR3JVxa8TrJUfVKDYkcod31LkLzyadrt94gJ2skqbEJRqviXh4xy71srsYdX8rrt8BNowC8EEzRkNb7beAP25OVM3M8E37Y9mcu9+yLMdY51ntD+kwZB5fAnpd/tpYt8TDionOX8qLR26z62DBp4dHeLhXObrauBBW5VvapN1ZuIkHFKUvh6Jjuysuc7fW99zPWxoXofUupl9J8tHGUay0BnsYxMtKad8n57CTIMCxRJ+Ku9L/5EhnLcrafI2DCemyA1ZoUbkYo77IXOFQhgAfSQe25UYC0/2mHJgYVgeCv3JsDl1rUPR07VsnPqGNeStKE1vlE+9i4WpVE/tse/tlp96w2lUME487Yrv1djlEuEDS/FHgG9i+bZ1FQVGYS1DhfkYsAh0NXJjeeX8TBcHA34EJ5UwHQc3RobsuyX1azYBMhRgZn1UEbXzV7a5h8m0FOF6eneji/qYoMKKVM4YYTszYfSkYrULbnZ9uNZPrW1I9RwU9/Ct8jnI+01BDvVHK1RBrkraTKsyWn6OyS0VgigI73wuz9afAK52PVWmQSBH1qtJ/nPSFmG5BEs9OaClS6T55Jfys/z4GDAKPUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(4326008)(70206006)(6916009)(478600001)(70586007)(7696005)(86362001)(316002)(54906003)(36756003)(83380400001)(47076005)(186003)(26005)(1076003)(16526019)(336012)(36860700001)(426003)(2616005)(41300700001)(44832011)(5660300002)(8676002)(8936002)(2906002)(40480700001)(6666004)(82310400005)(356005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 18:15:40.5655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e0691d-b1f1-4072-c7fb-08db56398e7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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
Cc: anson.tsao@amd.com, Tim Huang <tim.huang@amd.com>, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, richard.gong@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's been observed that with DCN 3.1.4 s2idle entry will hang
occasionally on s2idle entry, but only if running Wayland and only
when using `systemctl suspend`, not `echo mem | tee /sys/power/state`.

This happens because using `systemctl suspend` will cause the screen
to lock right before writing mem into /sys/power/state.

This causes a delayed GFXOFF entry to be scheduled right before s2idle
entry.  If the workqueue doesn't get processed before the RLC is turned
off the system is hung. Even if the workqueue *does* get processed, there
is a race between the APU microcontrollers and driver for whether GFX
is actually powered off when RLC is turned off.

To avoid this issue, flush the workqueue on s2idle entry and ensure that
GFX is really in GFXOFF before any sensitive register accesses occur.

Mario Limonciello (3):
  drm/amd: Flush any delayed gfxoff on suspend entry
  drm/amd: Poll for GFX core to be off
  drm/amd: Add safety check to make sure RLC is only turned off while in
    GFXOFF

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 3 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.34.1


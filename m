Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379BEC7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 04:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EDD10E399;
	Wed, 17 May 2023 04:14:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6DB710E397
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 04:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0JHQ3Z+UIf3c8BCGC3Ej/W6nqcUDxqIDjJmC0wOs+GHO7fTYlLRvWKbtxG0GHaPkmlwfOOq2PonLAzu0ALFlfzvf0bNd64Bn1ec2K7vsypV9CSqA7AJpy1UIuzuhaWIL0hht51H+vMhGyq+8KpVgr9iiK55CZlFQAaDIen8JKUzBPx334w/JWVN39ec3IlL3Nzz2Lm22Z1UVZG2RiXZBNhcF8UMtohzxP+e9t1Za8MKY0gr9XgGwvcgAw+uPkoZwiwWV2GHA/PtDXWVy/s7lyEv7IVKsmgM+6sSOMWOtyTJ09lbM1V9TmiZOleXbUR8PdHrcULxNXTxUjilThWizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bA81naLuICSA0m7AQo1LBGMSbR6Kz/88bHpsDfiwa1E=;
 b=SH0cUuBVrW5QDutuJ/Ip2XEtr2/SPH3u/HP6Y0F30R5h/BLbyv5LHEC5A1KmAcRV+Eoa7lH9Lx74RG2/tdYKIL/OCmBE3CMPR0YTVMsECwr13kXk2grmA6+RMmzMQPl1bui8EiO6RxF0H3yF1dKfC3AaElTuElCTh4LSLPFgi6HEvVqKH3KNjdy7cHZtvd7qMDd6wSnJZSMxVcuOfcBddnr1L+71vKO/japO6t9J/Wfwjbq3utyTCezqv3lF3km/g0/HjJBLQJwYI2YPM8C258FFtU3hKP7utIPnBgwoxEHZ/VEvzoIUz9icp8cAwQq0MUdK34IR0VpQoS/yoEC2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA81naLuICSA0m7AQo1LBGMSbR6Kz/88bHpsDfiwa1E=;
 b=v+EdFMyzpzkxOZ0fjfVObo5E8g5MNwx6NHXYffh+vbpoEaCbK3dti029+Q0LUaLuKaT2Wn7oewAnCrHzkhzupW6SMZYaWCezu0DqRqzbbS+8heTGhjbGNnGANOGCet0KE7E0McyKQYsaDNII+cVJFHli0o3Prbv7LCkhSJAzlRs=
Received: from BN1PR12CA0005.namprd12.prod.outlook.com (2603:10b6:408:e1::10)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 04:14:46 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::46) by BN1PR12CA0005.outlook.office365.com
 (2603:10b6:408:e1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 04:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 04:14:46 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 23:14:46 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] Fix DCN 3.1.4 hangs on s2idle entry
Date: Tue, 16 May 2023 18:34:17 -0500
Message-ID: <20230516233420.2087-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 09863351-433a-4406-b4fb-08db568d3ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1+ZxQs1FuWY1WrR131IUP8kkDMkNQJQfdq/oH8IQXYj1iOajDhxOxCKb8TRHnb2Fp51B57bNWg9wjRBXlFWgAOtnRKYc5MVQOLBYSntecroTYbIgFjBhlgSNIXkZlIlZhxOg38a2kZt4lhZkqfuOdb5iwWR8/Uii3dDfn6MRDqg+RFdjJpi8sftpcZOSeiNVT0pk7bpvN6FGQZmyus5NbfBbpFfJ9XSEV5vYdIIEH0/ifJUGSxGD9bivjiotXWDu3FcgEqBhEkd1DMeLonj1VOUGBOfd+utM2KRnhaTnn2xZlqh2tOdcMEHrMHe+lEyZM6ISaAKaarZvEK+VHbXiUb8zLYDKNcxc1P7654X8IODfwF2VS9JLudeS5zEJeQe88iDDpEgzuqiXgQyTV/ylkKOR/reE/bCRQi+gy0mibmFbBc9u190jkgjZAkUCTCRHWJY+SZNJFOawuML/fHtcVvdMgy5TvDg+2sqvyHaHlwI6/dj/gn13pyBCz+HHZRn6n+F8jJFf6yyVmH52kiuoJ5gALkHAIiypiPsezLUVBOK0CxI+/imsJ92yloPiCbaw6AcF00qpxuhy43cxjkhlDkV5qqIxbVmr6v611UzgpI9nyATw4/kUW0h6Fhv3HRhhITB1xKdOKPxHiCUtI+X4bYurDXz5AO0vP+qKSxMWt03uov3wmbJcIXu2oMt4hfNjiswql2g0kLdX5DZF6NyRYvS+hKlhnzkQQnlAESKBSmEmCPeTI7eyFzVc3+nV1fcKu8vCJ2UMVg2GB0vtJlIzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(40460700003)(54906003)(81166007)(44832011)(5660300002)(8936002)(8676002)(36756003)(86362001)(82310400005)(2906002)(4326008)(40480700001)(82740400003)(6916009)(316002)(356005)(70586007)(70206006)(41300700001)(83380400001)(1076003)(26005)(2616005)(36860700001)(336012)(426003)(186003)(16526019)(7696005)(6666004)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:14:46.6386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09863351-433a-4406-b4fb-08db568d3ff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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

DCN 3.1.4 s2idle entry will hang
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
  drm/amd: Skip RLC suspend for s0ix on PSP 13.0.4 and 13.0.11

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 18 ++++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  4 ++--
 4 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.34.1


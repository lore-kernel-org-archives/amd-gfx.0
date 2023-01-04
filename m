Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2465DC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 06:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9860410E06C;
	Wed,  4 Jan 2023 06:36:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4ECD10E06C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 06:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmJkXujuxVleGwm907supmNrpkm/IAEGbUq+2eshspHCNTN09K8cF589TcZxtudW4rtCRUIDiDupLlJiiLDF3Vbv1/iF8YtDWqtupsSytr42R9kpkTtmgOuqNhaUTmwPLeBpTob/WjTvGD8d8NCtzLn+qRpVIhe6MJu32Tm7ppdDJ1w/QMBJkjFphnMY8OUWm8+WrxbUPEV9amKqVteW8sZbnPz3Fhpq8OdwHbKlnhVls+nnJFuxWT+RpFGCDGC6z1auJ0vhIKoPs28JXY8QwHW6rmZrVh8EkkVRCT64ySP+GfzcW/ElgbHrNhjBzrEHBDsySk7v+8yJ2oD6hVYlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ila+4PwR+IHffAWTulP4W7g0m0P2NNUlDH8LaIb8aPY=;
 b=Dm1+oPntQdY6QYcLLn3x7aEZhXP8EhtZ7OEmjvQkRKhm690mqVR/RvGBt5QsoaquxMzt3GYKxljRD8Q0mPlTxcRCxi6Xtwn5jXYS1XpYQ38wdgEVag8UsJ/6ml3eq2e2TG8W2y1nJPc08RdxX2MY+h7tmNdAVCcoBaO4pL4Ka0Cu4OyDWuNTEs2O3ESFmdy1jCOJKg8DgDGh6Ft+b39jr9ZLrXqbqsPyrMgq15ek334bp60m4lp/wHWe7v+hC0KXZRtu1Vu2R2A8eBkJOD/geUS9xo3uwZEHm6lF737aZMvBKNoHc0YVDejtI8+xwQugwO7YugbELORfboYbIx+vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ila+4PwR+IHffAWTulP4W7g0m0P2NNUlDH8LaIb8aPY=;
 b=v+0J+cJitjJnj323mxL7i2ZkCeOfDTvldeXEl7J9gigoZlJnGdqsbrs70qcfqCbLtwHvY9sKR+dEmDv0VOSAu++xifAPjIonMjQA5r6DIt/cYW0ZnfmS7s34mUS8ppTUow4MKuAM7V82tYnX/LVgwULlRiMv44ZhO0RV2D3oHXo=
Received: from DM6PR02CA0071.namprd02.prod.outlook.com (2603:10b6:5:177::48)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 06:36:47 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::b3) by DM6PR02CA0071.outlook.office365.com
 (2603:10b6:5:177::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Wed, 4 Jan 2023 06:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Wed, 4 Jan 2023 06:36:47 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 00:36:45 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: correct the reference clock for fan
 speed(rpm) calculation
Date: Wed, 4 Jan 2023 14:36:22 +0800
Message-ID: <20230104063623.3674474-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f0df45-972e-40c4-4939-08daee1e0dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DY3LcPyncV5ySYLAeccyL+TlJbd0BgBAuz4P+0fy8WQqZDvsmXMGNZwXiAukGiS6Z4kFHNLDEBnMLnHoZ6Ad0axllKtM0cUmnzYiTQMyC3Vd3Lal2hXPpYrqkuoFIDMLk99QktsJd+77GRO4uf5037c0m3QHCyK1rvkGkgv4VryWNxh6B72+6VBcQx+kzCiMzu5bXM8vibVip5R0BlZjQzvxnagI2kGCOaEC9kdjJn0knvqYPLI8cq9iyMztItbyIL485DqkrSrjs17h2J4x91/9tSLniin/IruyM9MHLCIr9ncBYkPVHrCMKKsnA8co2oVAqeyt2VdtrPhQCZ2CPAuLFQuEzw1CLjzKWjyT9ElY8B/eGhWPWAxyefSySOS3S63/eprexOy0oeM3kXGuYne8efXwPRKliONJpPQSIoX7ZrmxhtmcnSeeyo1dcw2jFWCoaua9rPPXAFM0JukzA+zXmzrC7peiYOhRKYk83TCCfiurMU/dwbIsV8hYNjR5WLJcbEPhoa9ElbRl1j3tpmlk71MdoNe3IqXy0DktGmZ6lNELPjQyz45oBpf2HOmNSZZshI01X48l77M8ii7J+TFv4AaxgYifTVPpvf7OpFqkLx9c5LVLZrTSblgjFaqqwKTOlapg7rOsh82gwbOUClpX8YeOH6hk5c8B6wZS1/6o2Fr8rGgdmot53ThuS6oQlJGNFxQBhHR+p6J0TuECfyQrQs/y+6Wxu95+PLS8Mpk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(47076005)(426003)(83380400001)(26005)(186003)(82310400005)(336012)(16526019)(7696005)(40480700001)(6666004)(1076003)(86362001)(40460700003)(36860700001)(36756003)(356005)(81166007)(2616005)(82740400003)(4326008)(41300700001)(8676002)(2906002)(5660300002)(44832011)(8936002)(478600001)(316002)(70206006)(70586007)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 06:36:47.3421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f0df45-972e-40c4-4939-08daee1e0dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the reference clock as 25Mhz for SMU13 fan speed calculation.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I9596635b14dd4f9a55ba11324e2e0a3c4d6d3108
--
v1->v2:
  - correct the way for reference clock updating(Lijo)
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0ac9cac805f9..8bc70ed7ed00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1261,7 +1261,8 @@ int smu_v13_0_set_fan_speed_rpm(struct smu_context *smu,
 				uint32_t speed)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t tach_period, crystal_clock_freq;
+	uint32_t crystal_clock_freq = 2500;
+	uint32_t tach_period;
 	int ret;
 
 	if (!speed)
@@ -1271,7 +1272,6 @@ int smu_v13_0_set_fan_speed_rpm(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	crystal_clock_freq = amdgpu_asic_get_xclk(adev);
 	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
 	WREG32_SOC15(THM, 0, regCG_TACH_CTRL,
 		     REG_SET_FIELD(RREG32_SOC15(THM, 0, regCG_TACH_CTRL),
-- 
2.34.1


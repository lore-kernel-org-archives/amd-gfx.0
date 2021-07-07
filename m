Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F69C07E96
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD056613B6
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD056613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC1E6E802;
	Wed,  7 Jul 2021 01:59:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C7E6E802
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 01:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQfP7Yt/riIuANki6bJnexfi5PWILQ9kAqseHxT3F4DZ8n+8rMUKQlpurcu3ekJsVRPgaaCkpckn7OfToa8aWCjLJefI/C7LO9KiL85swQpfyiHHOx/lvq6agzF17U5B/Fp6aeSkX0G7YG/HcPJcNA4YYZ+U5ndnv/M2cIXV3lqCAmVGfLCjzi6A0snGaOVZXw3gtxcnzreDc18W4LdBv2887HasKB2ifGl6q2o4L08ABn3IKwN/35s43p9kwqHyfXNe5yNMPtkd6+eXAo8GqySBAShQpxGF8czSkkV1zisfz8breQMQiiGJVL4H6oo1k2XFjeVOz64VDpNFifr0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gY6cTu+rwb1+czoBb7iSZ+X6QNdryJSounCe11M//w=;
 b=aQp9lFrZMfbdutmxbRUXN9/h9GRIBh4s4Zv5ZvgitBvgoIIvogSiKuUnkP0zKsYzkXY3LBa3ELidFVJOLC8Z4sqFd95sYzs6Mv9mkboyvWmWwbNnpocpmhhOF6gl6yGeJ/MoLVqon+0Bt1XzitEEhgqNIyBaI/LJqfrc4PEgFOjK/e0VM4J29bh08wovYeJhrJvPOJ2YL9LIF63O2aG8DrFkx7ZIu+O15nwRVHvj1FEb9raY3azP7HSQKfE/wMZgyUkrNu4ZNSoUm9p5f3cnnqyCQ77V9aehVyjRcti1OApZ5i9OflZwMjKOonR07s+UJJmYiybjnF5jfzk5WxcVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gY6cTu+rwb1+czoBb7iSZ+X6QNdryJSounCe11M//w=;
 b=XBYTxffhoURJB23E43QVAbQCxcwg+EA0q+bKJNBZsSoGLVAULtevbAEahrRUMpCRKBguRZEq4c6D4HhxfRIfSXFpnDwf4U1I08dPUNPH0JX/1fH+ZBCDtlSVUyNqariUpKDGgk4OQCqWYTFOGn+J8lBN8YRTU+5N91sna9/ZaXg=
Received: from DM5PR2201CA0006.namprd22.prod.outlook.com (2603:10b6:4:14::16)
 by MN2PR12MB4991.namprd12.prod.outlook.com (2603:10b6:208:a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.30; Wed, 7 Jul
 2021 01:59:33 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::44) by DM5PR2201CA0006.outlook.office365.com
 (2603:10b6:4:14::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Wed, 7 Jul 2021 01:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 7 Jul 2021 01:59:33 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 20:59:29 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amd/pm: drop unnecessary manual mode check
Date: Wed, 7 Jul 2021 09:56:46 +0800
Message-ID: <20210707015647.139127-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210707015647.139127-1-evan.quan@amd.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bfa83d1-0c15-4136-daf9-08d940eadd95
X-MS-TrafficTypeDiagnostic: MN2PR12MB4991:
X-Microsoft-Antispam-PRVS: <MN2PR12MB499134B8B9A1C38207A371EDE41A9@MN2PR12MB4991.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Sp/x5pDSuhilhgCR4PMG7Do3foNQKqntIEkEZvgkR/J2jMFCQ3FQfYiyo7Y21bfPyf/vRpfC+IULpa92e8TWotUAlW/8Gui/UI+OmQsdMhpsStkXOH7F881zSSs7UwGVNhiH3LZSOvGVIu48/CLVqM4T4IHScAiZntOEeu2yNgQV7TsH+g/GhLxaA1zZFg1ovKTqMqMDiYjUwddg6CA0ZTJ1FAwHAK4hVzj1duxqS6/wQxCJeSOgBx2Hh8Nz7S0MAn4POYVN2whffPmUSqh3xpszzf4A5lGzUmMMp4Db8m3mORV8xAatSU6DmMPRCk4lIBUwgOjuVxmMbDE4rSXeJ4tm4+cyW5iXXDCFyHAn7FCp6DcfdOB/nBvfjoZ/gAxxUFeilJ3QQ4k16x6feLSYEuHAnlkZ5s79eRUftzdMMABNyCXLockz4HANvS75AeZ81t5dgsxFaPQDF7jdSC4uvcsG9PJgzABCTCg3/Yxg5ZMRm2K6QJwMR2aFRdO/I0p/oQp0AuzDbdSmzGOATWYJ5oir2T417VYaXp/3DPFdjzZwj+F7TUZZPd29LmtBMfLUMMtKpsecn2DqE1w85bp8ZZtLBDudEKNE87nXe8c71fFVipwnLH2L09u8guHguC9hKe5SN/DnL2mphnd1kIWATl2NpV/u/pOA+GUeeD2ts6HGdWej+mNe9i24LRI2hifGBOur8n/Na2++34/qF3MMqnein/uV5AEIC7gzHEi/Xo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(4326008)(54906003)(1076003)(70586007)(5660300002)(16526019)(186003)(36860700001)(426003)(6666004)(83380400001)(8676002)(356005)(26005)(36756003)(70206006)(82740400003)(2616005)(82310400003)(6916009)(86362001)(8936002)(7696005)(478600001)(336012)(47076005)(44832011)(2906002)(81166007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 01:59:33.2657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfa83d1-0c15-4136-daf9-08d940eadd95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4991
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the fan control was guarded under manual mode before fan speed
RPM/PWM setting. Thus the extra check is totally redundant.

Change-Id: Ia9d776141ec4aa39255accbf00d7e7ed81c8424d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index f0ae0920c07e..319bd7689df4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1194,9 +1194,6 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 	if (speed > 255)
 		speed = 255;
 
-	if (smu_v11_0_auto_fan_control(smu, 0))
-		return -EINVAL;
-
 	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
 				CG_FDO_CTRL1, FMAX_DUTY100);
 	if (!duty100)
@@ -1218,11 +1215,6 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t tach_period, crystal_clock_freq;
-	int ret;
-
-	ret = smu_v11_0_auto_fan_control(smu, 0);
-	if (ret)
-		return ret;
 
 	/*
 	 * crystal_clock_freq div by 4 is required since the fan control
@@ -1244,9 +1236,7 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 				   CG_TACH_CTRL, TARGET_PERIOD,
 				   tach_period));
 
-	ret = smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
-
-	return ret;
+	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
 }
 
 int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5950BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4DFF10E1C6;
	Tue, 22 Nov 2022 05:54:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA7610E1C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igv+J+gR8fRM1pvyVoNuswozmvIopTIr1Zflu1XoW8YmIJFm2QRc+f3QaUiPkPo9u1AZue/6KQRUDxF0TFGo6fpAAWws98vGIePBA9cqkySRIFCa2/L6EsWZE/7KelilOBphbldrUwRznvxxLwUiWy4UbRo0iyL8VcmVkZa6CQgkrV08TjiXal32P5Po2jd/QIF+SkZ8kCGTGvRbPcAtSvKeH0lSF2mAkE2V0qW9USIVSrI+Y/g7s8kFjynvE3W2yBA/5hrMTghKjlylsOlZFNDVjuxcbyOdOzu6I3abcCbRdfmbgeQvU0TgXr5VyWhhpMUslob5i9qWf40+vfwEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1USXeeL7mhhqMHnZgpUZ5Mmkvr7hpgfksFNugMtd4I=;
 b=ceBARl8lQzzKvrxmlkHO+i63xQbNoS6aYVKtw36IAj1Ngzz8LFK3Hky2OpbAeBCpU7xKNV0Tv+H2Lx5zbhfKvBcY3GMhTCJn6nYVSC14rBH0rxTMkkzKEPW97Si9qC9kXxoPl7a3T0dwZkNvqOhgvUDmau6b4iio6B/TV+pda4qs+j64pHSaUW4NUWG696O6PYnhaF+hfcIlABwzHuYns5PuGbleIq47Dh9iE2Ohp55YMTpa3OO8yja+SesiQSSuassXRraI8IEtBw9GXoSHm5NObNfIR4BPCa2g60oE6iJHifpJIH5Uq65xuUBrNe6HE0Agu5m5WZcILPPlIeWnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1USXeeL7mhhqMHnZgpUZ5Mmkvr7hpgfksFNugMtd4I=;
 b=haSxhG5AbnmqGQThEsT808Hbw7mwWr/wjFXviLMb4WiRw6E8XbMEE4t2kudZG65zbV0SzHjlrgE3IfsAmZmdw68dp1/PxD9+hKPos+r0xEf6rtwq6mdhipjooVjlrMkbQZ3onpoGHkhCMfucaAcA/7i6F/Zr/yCMOJWUDrMRL60=
Received: from CY5PR13CA0056.namprd13.prod.outlook.com (2603:10b6:930:11::12)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:54:43 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::e7) by CY5PR13CA0056.outlook.office365.com
 (2603:10b6:930:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Tue, 22 Nov 2022 05:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Tue, 22 Nov 2022 05:54:43 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:54:04 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/19] drm/amdgpu/discovery: enable nbio support for NBIO
 v7.7.1
Date: Tue, 22 Nov 2022 13:50:23 +0800
Message-ID: <20221122055025.2104075-17-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 5666bc14-104d-48ee-5e87-08dacc4e0d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWh8onVBCD6PjgBE1jkILQ+x+kmSwsB0n+82TFecSEvredBjS4s6AQTZtFJ+AIjoJdxaXERVeBnEGAc0bhnJscPGDT68txjekW5adCuXRIuMzCG6XO5Kto5SxiV8Pgz9e1RctCbswADXXN4rRGNfPmsV4O63Pa1gtJk1Hl48zffwkwhbLH3tptjRyre59DxQ5E+Gf8KYuqLnSsLs1QTNbXaP2Yh8qXqjavErjiG7evVx8ajDNEukCKhNbsvYlJ7G9paQriFCcII9Ye+qPw1exeL4qVVOUL+5CaJR7RJnrEmx52kHZtW4ZGXI8gK8le5r2fdev3plWUoR9IHMQ/qFIReYTCYOprGTuK3zcVrxaDy/+dFt0hky4Zu2x4MSXDesXnQCmIAEWis51UKKxo9Wx5MaADaSbtAOUHg0Pz99yqUjJkMsk3TP1WcdDV5J9Wy4pyJ+MITjQ03BuyTwmCVs5JhsBRMIFLk5KhxyPJRWcAnXKIVi8vC3k7NKquJqT/gafUnRN36UTUZhyuQ5tH082ZXoxHwAeN3LpmHOKeLzCB4JWggF8MSHJohS0EffF0q0HMDysZeOlgHLdvwTHCg8/0V7+tmu1Ws7sNGv9R9K43wwgOm6UF+6rLJ9q4nmXJDQgjsxEIL1eFt4E/x20qx9/kvg+l9Fl16cTJHb8OxhaggJOUY30SQ0BxxNhz8TBEDImKHZcOsx7R177J9TW6AVgNtviWJbozrFA/y2SBmLj9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(478600001)(41300700001)(6666004)(26005)(7696005)(8676002)(36756003)(16526019)(2616005)(1076003)(47076005)(4326008)(5660300002)(40480700001)(82310400005)(83380400001)(70206006)(70586007)(336012)(186003)(86362001)(426003)(8936002)(36860700001)(4744005)(40460700003)(81166007)(82740400003)(54906003)(356005)(2906002)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:54:43.0236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5666bc14-104d-48ee-5e87-08dacc4e0d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this patch is to enable nbio support for NBIO v7.7.1.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ac0f0e09a60c..1bbd56029a4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2278,6 +2278,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.hdp_flush_reg = &nbio_v4_3_hdp_flush_reg;
 		break;
 	case IP_VERSION(7, 7, 0):
+	case IP_VERSION(7, 7, 1):
 		adev->nbio.funcs = &nbio_v7_7_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_7_hdp_flush_reg;
 		break;
-- 
2.37.3


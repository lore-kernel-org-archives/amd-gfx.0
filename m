Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155E5C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 01:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AF610E518;
	Thu, 17 Nov 2022 01:24:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90F110E513
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 01:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQSzQ/b7DCAbvNsjf8Oep4AMY927bAWxUmgLGBvM5ZYB74nqW6OLqj+hpAr35lnGoQ2BeUnUZfiyKewsieUarprwvX/owIgS+RU+3VsS3EkQBsWe/rEezRj4sc3wcSob7wraHB0/+S7Sv+FcTDfQNg/t4JhEwyrxibSFnpl0NMEZVe6VookxOOrWLrvim9c7GdDkwFif/WmdSp0pL2tvlAQ/gZQkfrZxlvoycRIYhcE98UPmTD82aePM99pVWX7eLiI0O14vCR7v+BThssBHsKhWrmtONArd0Ll8gRqpKB4lzyXvvH+7hdvAB08Vf4o8Joilj5M5OH3ChzimZpb8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGHySYGBXe9vwonn0TlbKY06WlbBrz+6S8qNtiZ+hTg=;
 b=TySS0woNH49O12tOOF2O3zR7N3lB5TjaJ9toJCr2qDgmv9bdD7ql+nBqAoF7BxmOq0JQXRFpx80/32h69MtMVI1p5ZWznib4AGb2GmcqMgN1PzG77BzKMWFxiCe2oAHX3TObyRxvgeWUsAjsGkFL/43ICk6FdGcsd7unACwgxhA1mzNSaE1eDdS5lKeJDjaUBamVx6CLFrptA2XXkTYLxZekcFgrlCn8LTJyJqbiLEHyijUuhWzsDKRRPHStvUeVXYkkDJz+8/2GLKk8jl5T+td+hHRYEgkTXgJuqf7AxrGwqP2MRJRkDsihvJQIGQ6N2MrOEdWw+HqoAS3k6i4H0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGHySYGBXe9vwonn0TlbKY06WlbBrz+6S8qNtiZ+hTg=;
 b=MQGQD1maO7XYA3vrVjI47Q5mAr5EFDWR7/BiK65VSVz36k8Z6hy4oHPwEoXt5nL7BW+EKIg3qDaTMxkrJenkitzdlUFxJL6dblvy4+pqj7/wCgCnVMdrYYWLhafrGcR6wYNd+xV0nuwzXuE1YxX35eF5Dr+I6Lx7cqRzUN8hi78=
Received: from MW4PR03CA0206.namprd03.prod.outlook.com (2603:10b6:303:b8::31)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 01:24:50 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::e5) by MW4PR03CA0206.outlook.office365.com
 (2603:10b6:303:b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Thu, 17 Nov 2022 01:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 01:24:49 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 19:24:48 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Allow non-standard EEPROM I2C address
Date: Wed, 16 Nov 2022 20:24:03 -0500
Message-ID: <20221117012406.33268-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117012406.33268-1-luben.tuikov@amd.com>
References: <20221117012406.33268-1-luben.tuikov@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 5745d9ba-3bd3-4bac-28cf-08dac83a8593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATDhl7TaDSb1WTe87uNckUra/JAxSnkFufksyFZ3EDhv7wAknb4bxjIAlMNgAHQS7+oJ9R2GwuuJ/q5NCznaS3eRstOlt+fskl4oe1rTMDtMKFhvWMD8iBFYfp+Rsx1kj/B67n85EQfyGoMuAiYdzBPGbleXX3vYvLolWe2pwG4zd0tKiFl3MuV0gaydhRITCRTfzfydA2h5yv0mNEejHqhiDAXAYbYwkk5LJy1YbebyTotQS/llD4wE2vQL5zzRjsYyzdnRGlfHYLP1Ba1FtCkaDPySllfyXPfO3wFRaOrd1NejloOVX1fwqaQ9VVZVyYO8sGI8oFyYXi7cCnQVS0YABY/e6YrEgiqxalQ0NC0IqCwTIy7S0/65MewjGFqUPeGtIoFgNCvGevtaCdw4XI47LobtbkXtoUKKuL5NjF4ceNDPrJX0VGYtgmM1YciAJW+3K/wUyxk0abOdBysagN4Mt495E5ZXEwalIzxxVKjz8WGXhAInjP8Wg6tXO/u0zGwE62s3uYSr/1MrnKzNOpHvwrlLYiGGUuAv0MAYXXWKnjYoYkh0DwmgEbk95icOHIOJxiunsn+qEArNrNDAbYax+p+UMmfdtPH6zkGllSW6JXwcbM9lm/aHVgTEcwAUjeVlxITdPcwnPSwMfgfKI6upHM/BVeCR29Ekh2ekKurljLnEmWHGmGNX+u79fS2UEg6ZPTNJzneOieLCGi/tteyPvu0Ktko0e/pm38T0goYYtluwAU4ooMdTiLJDHM5QS3hMxfSEptyLKgqbdqS87RBVCjxzsGkwKkC6HCtfZez/hfbaPf8UK+oaRw7RAQOD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(26005)(86362001)(81166007)(82740400003)(82310400005)(36860700001)(356005)(83380400001)(336012)(426003)(47076005)(2906002)(40460700003)(44832011)(186003)(1076003)(16526019)(2616005)(5660300002)(478600001)(7696005)(40480700001)(8936002)(70206006)(6666004)(54906003)(70586007)(41300700001)(8676002)(6916009)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:24:49.9300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5745d9ba-3bd3-4bac-28cf-08dac83a8593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow non-standard EEPROM I2C address of 0x58, where the Device Type
Identifier is 1011b, where we form 1011000b = 0x58 I2C address, as on some
ASICs the FRU data lives there.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Tested-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index d6c4293829aab1..7d2a908438e924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -87,7 +87,7 @@
  * "eeprom_addr", and set A10 to 0 to write into it, and A10 and A1 to
  * 1 to lock it permanently.
  */
-#define MAKE_I2C_ADDR(_aa) ((0xA << 3) | (((_aa) >> 16) & 7))
+#define MAKE_I2C_ADDR(_aa) ((0xA << 3) | (((_aa) >> 16) & 0xF))
 
 static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 				u8 *eeprom_buf, u16 buf_size, bool read)
-- 
2.38.1


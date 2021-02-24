Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05043C43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B801F64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B801F64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE19D6EBFD;
	Wed, 24 Feb 2021 22:22:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185E16EBA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGv5WtKWomp49oAURd15DQ/ySjphPKz0kmu3YvEZO9+Ds6RrLd3p45G3cjOscul0dS2mTZPJKIOI/MunVswN7y9ngt3zsZ2QJBBIQRBGkymLQEJSXcCwXmD9eO3FUFyBTiJsTxbCkusi+LstBQgdIkS1/HE2ypsxqHpVFpxOF6HDZSLtVtpwqo5h/MzBA53AivGILAoB3hJB0qBJGYh8Om9FDcUZZbruI2icdDUhTT1Pnu/6Ty2a0NHBnu9y6iwXs/0dc4TBqoS+rQKBd4UyIqxFLvrUkCfGQUhL/rDqFzTJulz56+JU5yrTuNs/2OXo7tqSw6I+1xhjTxRZozhRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hmehoE+7LKAD+yuGLXDIETOSCIA5tgnd4ZDBOjk9lo=;
 b=cdJcGMQm49dmxzj/mb3ZFigVulH+WZJOFSgMH+PJ5DiiGg+zn2fYuwd6IzA5/kAAgIkT5nDEqRF1n0/ms8/PUgt8sfIHItxen2Q8GsIrUOoDMmYpTyCh2Pzq2em5tv5Jg+oi5Qd4rDtjtPZOTR50uxvVB4tOlIMuCN7y0yoUDXqa3lIK0RzSYGW7eue6j6Iy6H7sT13FaGgjhYphom8yPFnOrD/soHwuiD+4l6wLovjL4vVs8lhFfVnFot89urvEeVlbw9X7D3efYqNesEKdYZY7dLQ3MnWCR8ehwCp5rkIRHxn1XyzDZhCqQFJr2LMJ/7JeWo3DNgDTUK8j1Zuy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hmehoE+7LKAD+yuGLXDIETOSCIA5tgnd4ZDBOjk9lo=;
 b=jZAiPzrkTs0EX52BuDCepHSwFvLxHE08BHOYBepR/q5D4ISMR6rSzYfR0wuaMqHSnriByIRuObegYsouu8g6sHbddTOQymp1VmUwyNBpsrGd52wDEUYMsB14kM97PgHlO9ALjb/klkI6xNQnUZace4RMxLYcgGrWhGlJcrzzkPc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 22:22:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:36 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 148/159] drm/amdgpu: apply gc v9_4_2 golden settings for
 aldebaran
Date: Wed, 24 Feb 2021 17:18:48 -0500
Message-Id: <20210224221859.3068810-141-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1158d21a-6e6c-40f1-fbfa-08d8d9127831
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47228098BA727BFF4FFD9132F79F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kinufwa6M2xX7I/8OqVDWt5ZsP9Au4r1jhP7E5KcRPZ7yhEyi0Ot31UJzYkTTtE6j7ZoMJ1Hn8aXa3KY7COfDGsfT1dispVCVdBw9Ur8mEnuUORKtoeco7tCxJPxoL8L+8WQTJ2/hl9hqQQljGupD5QtQgb8rj0eHw6C3/3ejPivrFru3xrRyTCJxzq82HAc5rxwCOvKpwEW+grGICuWB1z+4JJT54CPnz47r08M7HRVrPLnajhlqZjlKB9RD48jhSt3hkV7+KpHT3yoJFvC4wZ82uFLxpnzu5I1RjFFC7nGEFxrj6D52Q3U4sPB0/gcLLX+TqWNwetX38Js58wuIB0fGe6fJ2v1RgCBs4z6td9nhje04c+3/UX9TW0eSduJy+gpSxX11yJktNH0zsQhHAq8k2sAQgv91IvzQVIXblxiceMpMk71xVt2yawU6iEJZ8GIISGZDpaVUaSm+Sx6X5XhleWNYu3limzMs3W+OFVg5EqTareLvyQSwboGSIalwuwVNVcc31MyWmAgD18xeq3LUuvCJIr3rNmPXEgQio8o5Pfnof0QAr/VEbmYr+0aVoMFMeCAOb1kZW1k7zNA7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8676002)(69590400012)(6916009)(4326008)(6506007)(8936002)(478600001)(66476007)(54906003)(6486002)(2906002)(6512007)(86362001)(52116002)(956004)(5660300002)(83380400001)(316002)(16526019)(1076003)(2616005)(36756003)(186003)(66946007)(66556008)(26005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lj5VQZip+e9bHgUAzU+A5u29MvPX7xueyn3rkAImbT0Bi389pBDzj89rnRjL?=
 =?us-ascii?Q?91HQH3cb1X8C8btP79k7CHsymTlHSt6PqOak1+aaY/gbuB2bA/ux75h8x/54?=
 =?us-ascii?Q?+e5+OZDvFsasYMDiBguGn+MKcxlHDKpDNzPVmbjG0QQrJT6Q96+u2bhnllQb?=
 =?us-ascii?Q?gjwllFiK73FwMs/gDIU0zTK/4sB+V2EuFX2s3rO/uWXxgUVZu9mfvz2e0n8X?=
 =?us-ascii?Q?uZQWwL2CEpig4K8uZw6tDupmIZTIoGYjeEmPlhH+Q6UhUKc02E6a6zESXcqz?=
 =?us-ascii?Q?zysf8GGKj2EZM31EKl/VKw0r/tomVSOk6a7WQn9dpxVOIyoI1WvCf2xFdf0k?=
 =?us-ascii?Q?ro5FtUXIRF1Fc9xLDv1dOzcqjCz0JSFci6T9Q3Y5nRiLo8egQcVGuX8GCbmN?=
 =?us-ascii?Q?NnSMHGfwYWJVOi1gHX/jjTnZudz0WaY6Qs9hzDebJg1+DZ9uvR1tEy5dN5eB?=
 =?us-ascii?Q?tQ1kCjSQ7AyMqX4M5MYCA8Ldf90NT+YH3BtVK9eqo3gUHT1djnAkf0Uq6wB7?=
 =?us-ascii?Q?EQnu7xServz3g7SPJWrlr8n3aDOugp+QsCTV8tp5hxrtz8gzyxEoTxt/Kr4Z?=
 =?us-ascii?Q?q3L8+e1ozNIRaBfwFa9gWy6gfnEMGkcyxLSkeGJnHK1mFpI435eha5jbtzLs?=
 =?us-ascii?Q?qsk5LW8TYcpzeqM5YONzNPiqgFl8P/n4zEAunlH5OphpbTulgxs7nqQ4Tq4V?=
 =?us-ascii?Q?uvGDMK2fLjdC7FR2q2zoUFuashxD4ySJNo8K9MQr7wMxoPEJI53YA1JQdMDL?=
 =?us-ascii?Q?+HknlXVnBF17e8GMINx1v3n6Io0aFeVhfxrAYCaRKOTK1EUSKxZyWCmkvxJK?=
 =?us-ascii?Q?wPDgJubHIsDjGW08jNiDCwdyCcnF2ygCtLrgvGuYq19pUA1/ury4Q/kp/u9/?=
 =?us-ascii?Q?K17PElx2HKB35RmFW3H6m3nIcHvOoSEpHu4/GD0whnRlqziiV8dGTQ7ezQtW?=
 =?us-ascii?Q?f/jOa+5UblbGJQGKM/hyiC+P8xOAItFrvm6NPWLt0wKcn7sA8Ze73+Z02+pj?=
 =?us-ascii?Q?Gksd8gaC1eIt1NdWGqEGeDMmn8MkFzM46jppBOTYD0aAJbnE6GDhFnEpf2nX?=
 =?us-ascii?Q?XCDY24ZfKWJXP9a5qTvfhp4g1/qxJu7Z3oftlfYW5bShmvzJoTExMCR1HIeE?=
 =?us-ascii?Q?4+lBNRPEA40E84afYMULFaW8Nz0YkR0cZb0BuRN4VV1eVZy6sEujDjA+HikN?=
 =?us-ascii?Q?ba1PXOcC5T5icpztFr5AJMsVW6yx7xCak0Gzd+nub8ihVUV79pLwyDtWIyBD?=
 =?us-ascii?Q?CZl92UYaEQoYD+wVkbL6sfllhT9HueBc48JP1hzzOguj51rSLRVBvNc/w5kW?=
 =?us-ascii?Q?et7JGFgDkDYZgsiEN0gJWqF9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1158d21a-6e6c-40f1-fbfa-08d8d9127831
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:02.3957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofy3Blm5f1g66lha44r8YQY2rWVXeG77GjHj/bw1d83vqrwSBg5oZEpwCd2JRXGL/7I9ui77YJxGBLZP1B6g+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Those registers should be programmed as one-time initialization

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 51 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  3 +-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 78bb4e28c27c..7fa1660fd751 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -984,6 +984,10 @@ static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_9_1_rn,
 						ARRAY_SIZE(golden_settings_gc_9_1_rn));
 		return; /* for renoir, don't need common goldensetting */
+	case CHIP_ALDEBARAN:
+		gfx_v9_4_2_init_golden_registers(adev,
+						 adev->smuio.funcs->get_die_id(adev));
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 0c2ccbe327ab..4c4549c2ecb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -26,6 +26,57 @@
 #include "gc/gc_9_4_2_offset.h"
 #include "gc/gc_9_4_2_sh_mask.h"
 
+static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde_die_0[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_0, 0x3fffffff, 0x141dc920),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_1, 0x3fffffff, 0x3b458b93),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_2, 0x3fffffff, 0x1a4f5583),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_3, 0x3fffffff, 0x317717f6),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_4, 0x3fffffff, 0x107cc1e6),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_5, 0x3ff, 0x351),
+};
+
+static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde_die_1[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_0, 0x3fffffff, 0x2591aa38),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_1, 0x3fffffff, 0xac9688B),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_2, 0x3fffffff, 0x2bc3369B),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_3, 0x3fffffff, 0xfb74ee),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_4, 0x3fffffff, 0x21f0a2fe),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_5, 0x3ff, 0x49),
+};
+
+static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_UTCL1_CNTL1, 0x30000000, 0x30000000),
+};
+
+void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
+				      uint32_t die_id)
+{
+	soc15_program_register_sequence(adev,
+					golden_settings_gc_9_4_2_alde,
+					ARRAY_SIZE(golden_settings_gc_9_4_2_alde));
+
+	/* apply golden settings per die */
+	switch (die_id) {
+	case 0:
+		soc15_program_register_sequence(adev,
+				golden_settings_gc_9_4_2_alde_die_0,
+				ARRAY_SIZE(golden_settings_gc_9_4_2_alde_die_0));
+		break;
+	case 1:
+		soc15_program_register_sequence(adev,
+				golden_settings_gc_9_4_2_alde_die_1,
+				ARRAY_SIZE(golden_settings_gc_9_4_2_alde_die_1));
+		break;
+	default:
+		dev_warn(adev->dev,
+			 "invalid die id %d, ignore channel fabricid remap settings\n",
+			 die_id);
+		break;
+	}
+
+	return;
+}
+
 void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
 				uint32_t first_vmid,
 				uint32_t last_vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index 5b175c10de23..0fa4cd423384 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -26,5 +26,6 @@
 
 void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
 				uint32_t first_vmid, uint32_t last_vmid);
-
+void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
+				      uint32_t die_id);
 #endif /* __GFX_V9_4_2_H__ */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

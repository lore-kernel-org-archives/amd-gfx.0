Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A6C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B0D64EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B0D64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 886336EB63;
	Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971746EB61
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhR+CeZWyIgL1F67wbEN+xrSBfojyV7FSkrBAomZoXdtQAIU+xWih3Faof1k5IaQ7zIxKM0wN9YtOXkQrxZKSgXuUCG9kUPbF7NyTgE9dmmem3GhJzFD0YAYSzA8cjmz17q1M1hFKMe/V1cdWVyPvjDum+hLh5vhjdfcmZ4V11Yau4+LXsd+as3N9M3tDL0q34FXUNhcm6F71QuNCy+6SH2/ZJ8SlcAf3JF5WjB5zmIFH1VfJdel/V6TSVQ2WT+TQiV1FkO8MTKw2WmQGAgTUyf83ok2uMVeK8u2tXBdIafYTmGfBiGJU1hrmH2xTJNhD/tpJ+OPaRVIuqNMqUtMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+aJXC7oQYt+R00mIegF5pYB5C6bzJWYkNjnwXRlaj4=;
 b=EAAaOwZNPSUmS3eOkIWgEWJuO0oyJkCGMQ3+6L1XgZiCTpwDt6jYz2cACeLk19HzygFlTI+/KSQHeF7tlMe2aHQWv3WTD6oCK1ODZmDWEbW8+jgPzkYgS/+rTg7OI3x8BUWyJY4A2RzzVp7rvSGO7Oi7yQ6caIRqMrcy9m8wvZQonjTDgtsU94b1QOlKcCAI3xGIDxCvp9CgI6fwbFWz5C8ajYb5XIQwQd9Lygv8DmmOid0myRuCHnYmZxxateh/hpDGlt1+t1YaXU93yGJRtboVaA2Dke/fq1fJ90jcov2dSJjCERajCkCuwF6H2iCMX7gCapoybeHn0AGquTpbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+aJXC7oQYt+R00mIegF5pYB5C6bzJWYkNjnwXRlaj4=;
 b=xKY1s+DXborQaK1DVg/rU0kbLw/S+1iI6Ac6mQ4KJJVe45T5dHkRzy1ebt+CBxmT7Nx2UppRtpPsc/dDa9ed7aNxzDabhmrdTQ6vUCuNTZXp3qf2kZxvkHKfwHhvLOwjhe9v8IXmbaeUi/G0z85qNyiYROSexYd1lbvYGQr3EJI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:06 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:06 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 081/159] drm/amdgpu: add mmhub error status query callback for
 aldebaran
Date: Wed, 24 Feb 2021 17:17:41 -0500
Message-Id: <20210224221859.3068810-74-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86de0f35-dc14-4691-c5c4-08d8d9125c66
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24978320C826E6578D714535F79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e26EzBEpn2Vo4Xo8REnyhUl4d8dKLo9lfRQ+sljleyfgx6gUqPoFe+3AO56WqMZs8Zlcjpz2JLhHTtmwGSCZV61mw5MZA5V2V+FClumFFKnWIr0kid3v2DXrFEcE/w9DQ92bl4usZUmrteFFO7rbaTFCt9cCoSJQjDqWTSucBDdAWfUFWSv6INCWeLCvjJMvDJb8LNsla5qSYCY0buXZ1kdlPmt1f/2w0v6Fm1M4WtZB9J08flz3DeQv2z4Qt9vRlpmhNxd1QpjcnkJvABWBheydZtJytYoHHugkROtiXkZRu98/k7bc6S6cfnFCeHBH66AKN+VZgFarrwVXO5WKm4yvFM2Whvy2E1/BntRMKl8jam84HgS69Ec1SKHFOxUgYoDLgXkub+OpeHIB1VKnyWnKpvh3ikAw7Stcg754nnbZ+9f6LPog2Xg8/4phVqjyTqWSLQQeb8/gg/qiIh5O1lvcLCnjRFRyD6Cn+ghBxHfJdJuYb9UfhYLoXSI1RPLihpE+XV3ajlcfo0tFWYBcq9xcrO+aVdPMQHo2jVVSJW1sXwfJ8h4z9SLtrAyg4qNHfc3+k9XJPBVv8ZFiT0qTKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(83380400001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/lQ0mw+xH87J1sa7eF6WW3irtYLOu5bSLtG1AnU9A3LvdeQQSuyAWAmZpN6O?=
 =?us-ascii?Q?msFm3BSncCwIAw7OwY/QgHM+YbKXCNotgcXTvIORYBxQtEKW+VLmT5GkPs/W?=
 =?us-ascii?Q?Z47IVCelJj77bdw/qBX1ZfdgFCJDTmpDYB2u/8dRZ7tyQB3BxEdh5d7txeDU?=
 =?us-ascii?Q?InOoSEtb9O0dRNYlnZp/EeW2HiirGzxiJzf6Q4pScUuNDsly98GlOb2o6DZo?=
 =?us-ascii?Q?0p6nm9BUYKBNtTNDyLrs9r3Xe0E6TBtIE+nafbQeuRrV2qVCMpL90aP7N367?=
 =?us-ascii?Q?Nb+7RxIDo2cDQb73mBAa2RJ0UBWsyXG9+VEaQDrq5OjOT2PsPAY9zcZ4IHN5?=
 =?us-ascii?Q?IR99uUS/jkcTiX4W7StVmH51of3D680I7F+VBhzFLsbODq/QZfw4GPBhusNM?=
 =?us-ascii?Q?Y11Vt248I5ZdTBnJdCs4MmeEYE92eKoHqi+sIJVPKK7DBxGmfOM+KgbFz8VC?=
 =?us-ascii?Q?3idBNDK+FM7Q6IhzOxxGHjB1soKxIx0uqPpd84WzbzGrq/3XLqNSZT0Ki5Sd?=
 =?us-ascii?Q?EGlK5Sla3BmtPt1xE48mwIXw/g/7UfGLI0rogPPPv/QE5SXmmDpyZLKz6Ul0?=
 =?us-ascii?Q?qTX+2fyGRekUN4vzbjVpoYbxa1ufjhLnGdswDF8+kQym1z8Ak2rBYo2OtwDL?=
 =?us-ascii?Q?Jte2MJdXYFtsvuzVuZXiLyfeMS4EGwJYXSKzFPKjtbbrKbZDuWZ5+Xh4Fdcq?=
 =?us-ascii?Q?fhfdhpz6m6gGZxrIr0UIpan+0VEPm5Q7rk12Exfo4KFA50/m45Le46V5gIcR?=
 =?us-ascii?Q?+0YOAeVnCWJHA8T9RBLNLkpBndr7MWgL+lWGpVYvZf8EDiDvxRVygVY/OqZz?=
 =?us-ascii?Q?keRAv4n2sOjKt8pY29VwOQGz/IeNyS4/5C+DGCgxVr78Cqjj9mH80Hv6DmC3?=
 =?us-ascii?Q?5S/2IpBSQLSZdFY7WgF1GFI4EX7WK+3uutybH/H+zbCL0qeHQCfbTI05yuFA?=
 =?us-ascii?Q?uR+y+wk/RnzohS5M0wmA8IFZdN+bWM6bexCj/Bihz0XF6sd3ldtr+G16XVzh?=
 =?us-ascii?Q?9lqbbQEIAm5xET5y/wBCEbZDw8dwxp9xZsDsqNo/HPjcxkVeN1sZzft96yKP?=
 =?us-ascii?Q?0xSzVn5aiOL9sXcObXezLXoFLMXi2V/tI2lv76LEadfhpZbOgHyf6iihTlWk?=
 =?us-ascii?Q?i2CTTm2vxqQPYFeOOGq0PM4pBbeMfNrgzHXbqzN1XyfH9Cf7phKO9oQlsv2l?=
 =?us-ascii?Q?ZjMSzrlFqP+XJw14qI/6HBP1Z9N5bI5VMk9MCIrggqgqhn2piLoZ+oaXJ0/t?=
 =?us-ascii?Q?6Q243NmQJeis4ZKRH5uj55cyg6wm1gag+BnoA506CQjtd2KwtHmH4GCQVyty?=
 =?us-ascii?Q?EdZ/O4RcU1KAeXBiOHXGAOAe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86de0f35-dc14-4691-c5c4-08d8d9125c66
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:15.7834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaHStYXahZhvm+EcRbzBMqOnHQ3KXGjYAghVm6tRHQ0dyXJI1BUqkrRA/WfIuqajbcYHbItLK8I5Q10wbeifBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

The callback will be invoked to query mmea error
status when needed.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Dennis Li<Dennis.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index c94060ca4a10..71bcea66715f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1242,6 +1242,32 @@ static void mmhub_v1_7_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
+static const struct soc15_reg_entry mmhub_v1_7_err_status_regs[] = {
+	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA0_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA1_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA2_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA3_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA4_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA5_ERR_STATUS), 0, 0, 0 },
+};
+
+static void mmhub_v1_7_query_ras_error_status(struct amdgpu_device *adev)
+{
+	int i;
+	uint32_t reg_value;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(mmhub_v1_7_err_status_regs); i++) {
+		reg_value =
+			RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_7_err_status_regs[i]));
+		if (reg_value)
+			dev_warn(adev->dev, "MMHUB EA err detected at instance: %d, status: 0x%x!\n",
+					i, reg_value);
+	}
+}
+
 const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
@@ -1254,4 +1280,5 @@ const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
 	.set_clockgating = mmhub_v1_7_set_clockgating,
 	.get_clockgating = mmhub_v1_7_get_clockgating,
 	.setup_vm_pt_regs = mmhub_v1_7_setup_vm_pt_regs,
+	.query_ras_error_status = mmhub_v1_7_query_ras_error_status,
 };
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

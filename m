Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0600DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 08:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7407E64F5F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 08:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7407E64F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F068789A1F;
	Wed,  3 Feb 2021 08:26:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9091289A1F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 08:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXC4mLsF4hRac3D+05saLrC9UjMJ2d6vyF2NGX8L6Muy/+iIjDPr4lxPlPqg3lTMeWj0V6Ip9ILa8wErZqojw780920UwaCrRlP74VSV7AWdzsCLYm8uFKwewJnWEBalIDcW2m2QAlux21tSZRkE9xT5DhYC3GvTgQxlOFqSXGqYLmN93xI7JbWYJSqfaNVVV8Xt3luBrdKksS+MXTIxxVdaZKY3Cob8Zp3ik8MLj1YpjVOzCQqezYOQzI6nQpXW7tFFKAfU4dGOqNl1ZHvq6SONdSjZ1k2p9nuKgCp9vPznk5XIPGd5L8udiZY9dx92SAumUj44slJZtr3Pe/ynBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfDBXXW+hI/GjSnW3RR7wlRxsj3Wt2kZmfqrK0rvhcw=;
 b=MTj0km7rP0im/zKuW4ZE/oF6ykvYBBIi3oPtB9WnvLHc3x55TVyXlCmLAxf9JarNUoPmezbpFqftoZR0ILLMtp4UZPysOsKpmIAgmmSVQj0Dfmze3aVIdgBsnKRKfAtKXn+ADzyBDpaZQ49ilot9J++HztMhbK1eCFCpagjjmvbwCAQKh/U+Ulj+hjwAHav2RzfdRoEkmZaFCTBzm8IclNvIXr83C3AV7QEt3uF8x+xPzI2IMSJmairFTbKeOlCl4WGo+oH9BG0m6fn2euTX9v0VUpONKLL8Lejh2U2KzQe7oNC/7fVrcTdK7CH3XOSt8+Bmh9eT5eKSUuPqv4DPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfDBXXW+hI/GjSnW3RR7wlRxsj3Wt2kZmfqrK0rvhcw=;
 b=2T59ehWlse8IFDq2GNq0xhK5gvhthRvpnnxqdmIyiDDr6VWHHtJihM7P0+DyP3+/MgpObr+jsmnS4IqqODxvO95SX43ofUgbnOa+YiF6Lr/0t01QI+g+H1D09GgBoJuVoJJ8cCN4FAyBiwsL15JMgYVuWdUNc6Uihj0xdeQgAwQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Wed, 3 Feb
 2021 08:26:00 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::7c48:cd3a:5f92:2c47]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::7c48:cd3a:5f92:2c47%4]) with mapi id 15.20.3825.017; Wed, 3 Feb 2021
 08:26:00 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: update the smu v11.5 smc header for vangogh
Date: Wed,  3 Feb 2021 16:25:13 +0800
Message-Id: <20210203082514.28303-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HK2PR0302CA0021.apcprd03.prod.outlook.com (2603:1096:202::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.10 via Frontend Transport; Wed, 3 Feb 2021 08:25:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6fe6c87-3b3c-4a0b-58b6-08d8c81d559a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4287AA284854E8FDEC6CE53E9FB49@MN2PR12MB4287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQ2hN8eSLX1IvyA4T3MK95vAHjUFIl9Z3xRFCsG8urCsLfmeg9ONwXOSDf2flIh/rHTj/T0zlpUmDSmRwOQUMjXd15VTyylvWUjxuz56zs+O1MJdpzlshSvchD8U9Uxv7AiJapz6467zGNhjCvDxkeesFWwc6IMdXt2oZQPHWiMZwXjva8hJsXr+DjaRE+dGJVItEl2garZRDYwFSMRP0KzfdO37i6YJKg2ziabbGxHyJzJTFXKrLsYlx6kWVSl9eBohkeQ3AJBaGhlJ050Pb4icKi0uE9SDFGz0tGTxQMm4XB97QsSOeijrc6RV4LzPhCx2Xkp1rq2CGQf2kctF0u2byo6DGX0Stvk29G15e8uCqU50T6nbx7wlcY3hlWaHbpnc/eesdcqUm3WskzcSbsVvz0q+X9rcyTATktpWAvgg5SSAjdm544LdlaWkOsjrXPVTsYdw2ztZBQ/yIzZyfDhuiOKMsLxU6Pb2MKAk4T8bnGtSpJCkhfMWbmoOVtmobKTPmXlTrTVGTfWBC9V9uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(956004)(2616005)(16526019)(186003)(36756003)(8936002)(83380400001)(5660300002)(52116002)(7696005)(15650500001)(478600001)(2906002)(6666004)(86362001)(1076003)(316002)(8676002)(6486002)(66946007)(6916009)(66556008)(4326008)(66476007)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?esEhiXt7dLYKNUgYyNMVJqGwqAF5QTCG0c0kVrL0yQktxl0vwskPPj/8o85w?=
 =?us-ascii?Q?T8KXqwlyvWx6qwz2A88MT8xCQaDXE6knYSP1LmfBJaZiohNYZqPRKtR/5ihc?=
 =?us-ascii?Q?Cb9/ihLePfSxBG8qSEnh76XLVtpah9ouVZEVDQAEcLVZ5ZZLrNP1RQHePnEd?=
 =?us-ascii?Q?caN+3rUd55/+Vt/hWMRXq0S7UFR+eBloP11EQkeidbWec0TW5v8fFBo/xnUU?=
 =?us-ascii?Q?ZIrG971waXtnyPj0/gHiuAfZLcgfkifhkzgFZDRA37XZqLCdwuFE3jHRT8MN?=
 =?us-ascii?Q?8YkevWOyGU4b5PckEwc8Zpy9F4KwjS2gtiOpQBesxeih8SfHcZ9FOtjwouCP?=
 =?us-ascii?Q?BhuODPliiAof5zigiD2J/gGAIxgULya1bWTI18YIlyOUEm//uu66Zdxwdukj?=
 =?us-ascii?Q?/QxnnJc7/S1YTrneGBz1KfBsyTy+tGNW0k8noDlYN1VCaOPovpaA6j/GVjwX?=
 =?us-ascii?Q?I1LPwtca5k5wF6P12T5YwyU6NEmp1WljrsiAgBY+EFdxshx3vrr+M3hkuItj?=
 =?us-ascii?Q?wnW9Fq6qDOn45lGtHzk2HW0BofT+uiSgThHD3L/YsP0lw94zrLnLRYBOqEki?=
 =?us-ascii?Q?HvHPFnZnnBTkP5ZwtMbceC2yrCGyZLdfM7Lt2neoYAe5GtQZ5SA7ztaBF9Uy?=
 =?us-ascii?Q?mwbWo1AjMEWfcskI8oucXNvExIei7pPCAm2mq1gj4zpzhJeheUcOaUSJ0ADz?=
 =?us-ascii?Q?1zUWiONtWEknBGroTJiQHYDRBWwAEQsQ4skfzud909MG1VsxmGN8RkyI2EQG?=
 =?us-ascii?Q?O7eyp3LEvmzFUW5hEKEsK4/HGyd33Y+JQAWA6BpY7XgO0/eh28koPf65jX7J?=
 =?us-ascii?Q?NNyyUbjN+4U+jeL6MmzYBV74ggC2JEIKw8YgytD+KNw05VTFtE8H9LQXTPDQ?=
 =?us-ascii?Q?0UUkXBK/DXTjTIfLlZtGF6L0VPr16ER79WTr1UxBQPXKtNHCRAzov8hRyZLN?=
 =?us-ascii?Q?E+oFERyU6AQ0rQ935UO9qhF4W9CIiB7TQSIvHuALvGVMGvTaTMhFnsTZ30qU?=
 =?us-ascii?Q?nY6qc5KCowLk93DFfdyCKGCr0aRZQDfT2Nnt+x6s1WNGuJRQIpQantrVUfEs?=
 =?us-ascii?Q?5/y52pujN1DO+DaoO2xjpQvvdDvhxg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fe6c87-3b3c-4a0b-58b6-08d8c81d559a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 08:25:59.3927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stvxWbm8UfBzOek/HFDLBNmUeRx7OpqXPEMrdO/9JqEE5Jw/BPLK5UVZq0oXmUo0qmmwrN8a3hk1miq5GnukMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Ray.Huang@amd.com,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Kevin1.Wang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add PP messages for reading/setting Fast PPT and Slow PPT limit.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h       | 4 ++++
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 68c87d4b1ce3..aa4822202587 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -210,6 +210,10 @@
 	__SMU_DUMMY_MAP(DisallowGpo),                    \
 	__SMU_DUMMY_MAP(Enable2ndUSB20Port),             \
 	__SMU_DUMMY_MAP(RequestActiveWgp),               \
+       __SMU_DUMMY_MAP(SetFastPPTLimit),                \
+       __SMU_DUMMY_MAP(SetSlowPPTLimit),                \
+       __SMU_DUMMY_MAP(GetFastPPTLimit),                \
+       __SMU_DUMMY_MAP(GetSlowPPTLimit),                \
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
index 55d7892e4e0e..fe130a497d6c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
@@ -104,7 +104,11 @@
 #define PPSMC_MSG_DramLogSetDramBufferSize             0x46
 #define PPSMC_MSG_RequestActiveWgp                     0x47
 #define PPSMC_MSG_QueryActiveWgp                       0x48
-#define PPSMC_Message_Count                            0x49
+#define PPSMC_MSG_SetFastPPTLimit                      0x49
+#define PPSMC_MSG_SetSlowPPTLimit                      0x4A
+#define PPSMC_MSG_GetFastPPTLimit                      0x4B
+#define PPSMC_MSG_GetSlowPPTLimit                      0x4C
+#define PPSMC_Message_Count                            0x4D
 
 //Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CB5C4332B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 11:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F799224BD
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 11:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F799224BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE3F6E1E0;
	Tue, 12 Jan 2021 11:36:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0FE6E1DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 11:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdH+FwFm6ZejxmofqoCzh8mDv+Y7nOJ1g8ckPVB5zk9sMGEomyuvibAgrOs/QK+OL7/5vIUADDDUqIIEGaSPdz71O6GNmJno6Eas3c0NrdKzHcLMIRcNNMXqzm5hqd/KPPZky4O/HZ9HVEf1ZEl+Gj/Jha4OhDEE/bIMLFgsdguuhOc8dPyUtfsbFmXu45Ozc8/TXHeDOeBF62dLdCc2qRG+4aLD9vXTqeLVIaNx1pAA9BX7Wx+ufBDzm/reKgkK5ycwDAQ3afYbrzWpXNxhKfOPjDkR52vju5GJu2fKkXhJfFT8oAftyLngTPFZPxtpY1zMIAzrlGLanrjDFNhkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slS7TeiR3BkgcozUZseBEI1rSIHNaBufy55GdsiFByM=;
 b=iNrG7CKSa0Cx8RruAn3+Sgl0WSQMNrRHFmUfE3XEbtF9saInyzfszbrb7+8PNvPOx1D19A5UKdZex9neW6+RQZGWvKCPWxZAHr54mrDAMGcQ3uzJZ+mlhN9cyKtXZkmHd46Arr0VtQYJTIqM2KyhKUw619CQYnDIOJ+ViWtpb9lQXlKCRx/ecrDdgub7QB+qDn3Tg8UQdp89ZtOL6o3oN5QrGkr3XiB7TwApJsYw45Vu8E5va66KMIgJ8/vGo3rBZtqe+i1bFcnvPsoLp7gkKX0OwGv7skWfGMZ2TUWOH27w5THFi/3mvcX//3Ix3Eoq1EWHkxDiRwvhiMHEFriMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slS7TeiR3BkgcozUZseBEI1rSIHNaBufy55GdsiFByM=;
 b=KL3Shrf0ILlyYlIYzGU+a32QcsGxk/CBAckCGu+Suyfp/aEx69jsBaFmAJLTfuSy3YAS9iiqUOq3JBTAiSA96klXNPoMZ0DrpyCI8MDQG8nbvo8n9HT26r6+uf460iyvFrdQDuDbnSG0hStMFxL8ZuH4TM2yapEMV251BJhA2X8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN7PR12MB2660.namprd12.prod.outlook.com (2603:10b6:408:29::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 11:36:07 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e%10]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 11:36:07 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: fix one superfluous error for renoir
Date: Tue, 12 Jan 2021 19:35:30 +0800
Message-Id: <20210112113530.28540-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112113530.28540-1-Xiaojian.Du@amd.com>
References: <20210112113530.28540-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-MyrtleD.amd.com (58.247.170.245) by
 HK2PR0302CA0002.apcprd03.prod.outlook.com (2603:1096:202::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.3 via Frontend Transport; Tue, 12 Jan 2021 11:36:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ee076e1-12eb-42f7-1bc8-08d8b6ee40ce
X-MS-TrafficTypeDiagnostic: BN7PR12MB2660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB26603BAB39254B21ECF78709F1AA0@BN7PR12MB2660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMB4X6SnYO268qNL2mNYIyDd5aDC1XDUG5t5cVXLJYZErg6OcMw1/oW7EpIRyuiNkNfOAblKQxHT6I2EG5FrPu0ytWMmj1cHm8RCt1dM0KGKwOaVIH9j48Be5WMqyPMKgjRK5XhAShI26i+xOG39nUVJwo3VsbhLwu2iB0uodtkD5yYxt3JycFydgjdLFgZJQTstfnUVSnj9756rpi542XzoClzzbmSzESI1Fe8Nrc0oEeUXO58JITNgjv2uPhh/4IGPYeFO9rub3KQbSxXL5whr4v+fCEtV4tbbFIxqO45UcxZErdUDTJ2DrPlJHKJXo/50gBcAxEVlO7g/gYM5Xoe2nZ3Rt+ZO6UlIrF34C44UHOWy7zEqEy7tQcdnnaMIxKh5/nBitRw8xAWbwrGzTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(66946007)(6486002)(186003)(66476007)(7696005)(316002)(52116002)(4326008)(16526019)(26005)(5660300002)(2906002)(478600001)(86362001)(6666004)(8676002)(1076003)(6916009)(54906003)(956004)(36756003)(8936002)(66556008)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fgBmlbBftIEvYPlnCsN1twIEereEcSJ7m2EDB6ANIX1W3e4YxRdvBaR7pgcm?=
 =?us-ascii?Q?F6R8y37sLpB7nz5weu9XVVY+VN0lx6JPS9+eGDJ+XSsPc8xnOyFzRupXgFPU?=
 =?us-ascii?Q?gSLwMRE/EmrmD0B6+TUdWsbDmZe6BjzVUoHdHaQaqPyMB96aQMgnK+/VWwrP?=
 =?us-ascii?Q?SmT8pFFWWxJRujo+vXY9h3nbAdRzZdcQ6mVHq7QkcaYv9eKjvrfETTPaNBCA?=
 =?us-ascii?Q?12TuQ0z/VIHkusW9JZk3MfpCWq271p+l1VSyxL4N++SxpRCVCfveerLueLTV?=
 =?us-ascii?Q?JRQxHwkRNis1xssj3DzJaMsklFtaf7Bgx/5P01xsUYy2mz/YJE54KI3saHhg?=
 =?us-ascii?Q?e8XKgLuWTsKQdmwmFuQ6/t07/juwlqei0tTdbaeLerrET9mS2IvWk11MK4R2?=
 =?us-ascii?Q?3jEPwRT3VAYG7uJFOXQBjS0djohDips7LwgBs673IdNtbKozh62vH7giqs0R?=
 =?us-ascii?Q?8gfrdnkiwTupadh5LzrV+uePZcH7GyQ3Mi6svNF8medCdFCdD0t1cgc1ER0n?=
 =?us-ascii?Q?jTyu8qNhPS/rZf/ErRqstMEkcT9bNexXK10VVFxFyLCdvNINXM3fhg070UpM?=
 =?us-ascii?Q?KUwgYcucHYfuR+lD1pdpDY5jABmLlw+klH17CEq8VMFqsyZSiGc7qwr+JDrS?=
 =?us-ascii?Q?q53dzPftnkkNRib5eaQ7dIXZrClmARASmuF+F3AUbt1AXfVUCEtC6tHEzRzW?=
 =?us-ascii?Q?b53/cI+H3DHOaTvd3ZrCInyBF5X/G9ZGFvbnHlF5REp/ULkNqgbC2wvSWLjw?=
 =?us-ascii?Q?Sg9gsyP+thKAkShPqxGzpPks3+Fx++b/gamZUBT84gjzhu/V+QnYAPA3Hc/4?=
 =?us-ascii?Q?5fQ+1DVDXsWtvmkYbrjO4aV4IjgxDhn1WB4Gjv/uzP9it5cTqNPlTYAkU+g9?=
 =?us-ascii?Q?pUZxT5M+3A4yO/eJ/ra3BXx6jE4LhrOsD4IYPYBuwvtQJsohKzdWW5nhuyeV?=
 =?us-ascii?Q?OcRthyy0SsnwU3C9n/g5i7BZFUR/GTHM6ahQcW/D6LDyFoD9rCw5HUv0Vv9+?=
 =?us-ascii?Q?kNBE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 11:36:07.5607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee076e1-12eb-42f7-1bc8-08d8b6ee40ce
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EgCvnwB0uTfxR/6PLD3Gp3YUT9NiUBKgjZEiC39MgZMmk3NK0qJx0F+cwC3NwuThl7MkSaaWDQpbng9WBayQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2660
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
Cc: prike.liang@amd.com, evan.quan@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to fix one superfluous error for renoir.
Renoir supports 5 kinds of power profile mode:
"FULL SCREEN 3D", "VIDEO", "VR", "COMPUTE" and "CUSTOM".
After loading amdgpu driver, the driver will set "BOOTUP_DEFAULT"
mode to APU, and it will get one superfluouserror error,
which is saying "Unsupported power profile mode 0 on RENOIR",
but it will not make any other harmful events, so fix this error.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 1f6a774278b1..f33f5141cbe1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -835,6 +835,10 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 		return -EINVAL;
 	}
 
+	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
+			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
+		return 0;
+
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

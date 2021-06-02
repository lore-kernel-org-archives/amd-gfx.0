Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91507C47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C5561C21
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C5561C21
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782426ED23;
	Wed,  2 Jun 2021 16:49:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD1446ED1B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB/gNzTY9xZL28y2TpVj3Qf86Fe/UKcP8YvIN66rc4AtZKioT+F24P0AJCvUm2vlCQgP7nY8nY/SQ/vrfqDA0uJLi8nFSjUq+0jWMFrMxJI9n+EWN7rSnrFhxIjo9NDMg6JvxNmK6iPh79HyfXvzcqk8YkgACCTeiHa6ugO3cHZ7EUGPatHUSul/8ZFQR8FwlAJh+cRudoPGON9lh3Q+fgF/TfP55f1Msk4c/iMB81VksBi8epQPQ6HGNQ6TERVF+dmNxdk/JQ/5Egzhxw+0OKn9EFmGq02RL7Llm4quZmClFOj07azQuWVsiqv9uH4QvfrdRk1152rfdpW4BbbWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/d16ZFnUTY6iM/3jbgx5SZpgK3MNcQuZbOuLX58cWU=;
 b=ZqF61r59FjNmXssDW4/F9bopRZlkPdlynxI/zjp0TUmnRwt11nQEGTq/OKeFTMlzmU308ZjNFeF0naUOZhi688J2XCMkJ70J4vGCi2R4cbzJ+NkkpfrssBZIj+8dCQxUfpFBcf3ZcfQq2TNdx6edF6jD4VzEP810RNGflWB0z4K3HFu5aNqs62LQ3VMsxjpJGAEbYdnEgzZVySnf6kXoZUDSwraq+Arqs1+9R+GbubkB53exnoixrFxHcHivdryBSG4npQ6QCwQ5SAskI6cxY0iL8ml254tRYiUzRC3NWDjHeITT47wnaeWp5i8pNC+zTth+K6rO8Opd7tOUJk15sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/d16ZFnUTY6iM/3jbgx5SZpgK3MNcQuZbOuLX58cWU=;
 b=HmmOmFsgSQ9CRmsYNnDflZ3vedsGNhMp8h/9DMwaAMXDHRxUWKtfeKogpN6FvwFP9Jo28/8Suzh1SKr7wttyGWJWnjV4O8jXF+Ou1aRzJCIDr9kmk/PVEGjXwKmywQOynYAjvkOy+T6AHBQH1dvZ0wiSaNhptbm8VT6UPnMmLfk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/89] drm/amdgpu: add yellow carp support for gpu_info and ip
 block setting
Date: Wed,  2 Jun 2021 12:47:43 -0400
Message-Id: <20210602164908.2848791-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e194291f-bc5f-4c23-3e01-08d925e6645a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4077A9AF7674D40FC6AAC2B8F73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwkRf+6hx+egly1+meCYU+g1aNxcsHcw4F89bXkWscf7Ep1HxIqyMMF1ZlB663zaCJQ5cQvoO181Y7RrKeafa3nsrN7LsWI6wsGJDqL83yYqqcyx65nqWRB0Y4q6x7t3GF85+TBZYAgLyAUBm1y250PPNfjfJ/M/tSNHyTcIvprxOvqBOpAqzwV8Qjzn66/C3EVSluN9x2UzO3LnfrvG66yl/Rc9aEe8nXGStlY6RCk/RyeZV8Xub8t0wO+bSp9/f+BmamDslB/kOHkuCAn6b8b05JMW3Ci5q4cmfYkwVqIRVSQkr4COXoXN96c9u/F5smcsyfhcYKmhonvq8DMOIoqafvi1lfH4SefO3P3er653terL7pcivlyrdDRTePSXi6yjLTEhWbtM/BZJ98KLje7yHEv2pkK5ei7mwgsrFUxWc/Uq7k5qkgvD21/GIAIQ5CfJyr8lU/45FaSzdS27OIZ/22sWh08QpS9W6X4uhDXF4vtSW1MhLRQnjBxAlBDYfPBfulfu/B3nrKE0K6LX5ffMcqO8XjglmfnGCXjnHiWlCKg9rgw86dQt6wSx6tqO0JvLs8/2ResmxVG0b33t/LpPwz8OtORgjWr4HdoVfjgarwTqy1pOH1hsjcjwVkzhYExMSCCoGEJlxLN8FMzMcaXMo+eZ6NCvvl/fnAIqKJJNEPRzDKPxKVCPnUCfGSri
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(5660300002)(8936002)(6666004)(478600001)(316002)(83380400001)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XPrENl9zToI+MavWFO3AlnRDgmazsQndM7slETMUxUz3qfvXBXC+F6n+45FE?=
 =?us-ascii?Q?lVIL51LxBI1zHMDjOpOlaoDFVxJkld4qn/iZLP6XWZMNegZWYtt0C+Jv9Sue?=
 =?us-ascii?Q?+UJ/eiNnsexb9ODEs7+qQoqlxA/s6BRrMYx1f4zHhHM42iIfXqI4E9NWOsTU?=
 =?us-ascii?Q?jFcfVc0YUVBUXy0XH7EtznRsHeMFVShxKo7VoTopyzm+9KQWAdXYAhT9FP2o?=
 =?us-ascii?Q?Ut4v99ixMiGqDPI5sILqHKLFOd8jxEgWptp8qvO2+rVqF+s4ly4o7kKdw6fp?=
 =?us-ascii?Q?HhJ3j5MJFupWjf3pRyaAae00ntJ/aLqucffH5Becy440pBjD3hWLFbSkGQ5B?=
 =?us-ascii?Q?r7YQAyZ8veupuTBp2Na5A/eyQvIs92g2uzPgyRfXnlq5wupCmhdQn1h295ak?=
 =?us-ascii?Q?MFfPAmVzceVZqEkjVNBIJMcKeCxLP75hsg+UL7dAv13QRH+M4docBNCOKPs6?=
 =?us-ascii?Q?3AT9drsK9icjN/Wwqkt7y6V660mh76yexVm31xQ+3ZW9lk+zWg9C6aBO5dQn?=
 =?us-ascii?Q?6xZpu4ugdla9sR9uumzS9C9Tmx6yaVZMTh5icCEmjC/bBqPMayhowDzbzfVw?=
 =?us-ascii?Q?qeUssAdbQ1w4xYzmKcS08WQ1yVQ+em1lOxAH+2G2W26MrSkwGuJarnclwCeU?=
 =?us-ascii?Q?FAlOxkiq3Us3nsddeNFpa7WB60NOycoj3JMXxpgQA7aho21CQJcGJPPY/NIu?=
 =?us-ascii?Q?te07U9TqDJiMJXXoZIdl9zhOasWp983kKlrWMH4ywB/o5DYuVwf/G7xR5Ckx?=
 =?us-ascii?Q?MPZVd45W38ym+MOTK5QdvCOj5Lf83POw0hxPBkA+Fv0JPrXTkxpDZEKMeH1Q?=
 =?us-ascii?Q?aZ3jPsBkJkbSfeu0AP0Od+c8Fh01vhqGKn/7oRKOMEWI7FwciqvOhr7/Ht7e?=
 =?us-ascii?Q?kbhR6Ev08e6k8kHsRu6CAIKV4fpdMDD43km6uNsfjHJpJwKm2pI8qjKxUDdG?=
 =?us-ascii?Q?kIdxNKMZ38obV2Bu+LpdC9EuYiZoXz4O03WBLng3Qen/ZHJm7UzKBcq3Tu8/?=
 =?us-ascii?Q?3QaKrCGoUIde4oo6RW5hkQ49Rl5a/mLN7utTD6JssAu+Mn7onovlvQQ5oCRd?=
 =?us-ascii?Q?RHyZ4ZrGfo9XGKHB7rk3P/pLFYY/32Sye6nnIXD+9OiA1iGSH69JRLI/WeCZ?=
 =?us-ascii?Q?Ol/GA3KoJQOdh3+MktZEAguF5VhXO9Q452pfMaLCqXuCoPUWw4leBLimeXFl?=
 =?us-ascii?Q?1iAtpYXEFkqcLUrxxMe5+P0R7/UnvySLTTWT8yTA+FbP9e1obXUTIZHPkGBE?=
 =?us-ascii?Q?N4tdUcTyGNqy8ugEwwYtrimEfBK9avEF+7kOdA2MIygwy2Fij7SmgR8lqY7b?=
 =?us-ascii?Q?W61ndunRFuQ2lKOfASfRGRRk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e194291f-bc5f-4c23-3e01-08d925e6645a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:30.7470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ws/pEdOG94ivOUwrGjNTbu+BtZGw2oOD0f8A4vp7cgnLMreD4IMn2r9Hop16US+mIczgAH4e668KXQ0ztaDJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch adds yellow carp support for gpu_info firmware and ip
block setting.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5db997a09bbe..0b38771ffc79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -82,6 +82,7 @@ MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
+MODULE_FIRMWARE("amdgpu/yellow_carp_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 
@@ -1875,6 +1876,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 		chip_name = "vangogh";
 		break;
+	case CHIP_YELLOW_CARP:
+		chip_name = "yellow_carp";
+		break;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
@@ -2053,8 +2057,11 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	case  CHIP_DIMGREY_CAVEFISH:
 	case  CHIP_BEIGE_GOBY:
 	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
 		if (adev->asic_type == CHIP_VANGOGH)
 			adev->family = AMDGPU_FAMILY_VGH;
+		else if (adev->asic_type == CHIP_YELLOW_CARP)
+			adev->family = AMDGPU_FAMILY_YC;
 		else
 			adev->family = AMDGPU_FAMILY_NV;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

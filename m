Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A95C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB7823A5B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB7823A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCDE6E94A;
	Tue,  8 Dec 2020 08:28:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05A86E0CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 08:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEsH0gT0Q4anusC0SeBtbqq5ycODGNi7GkjK/BxW4RCzckUfHrSkFBOoCxlTJW8szvrvfLB2zdYFcY/ua8NBXPrJ92u4GENq4eMFYWrCpUBI5kbcGQ/IZkSmq/j9XWnoH+btuReqOOSPSV9+qslvM4srp+wWR7wn5Ur1yQ6Vrv9ZMvNWWL+cyyTiJxZ1U1P57LTpnDBuLTh8tbakp2Uy2etu77jRYC2V6ftamKIV6dBGU+pN/E7Nbalk/vnyC2PUI4uL7AACCQDjO5P24iH0HwnJu2Xu2EswgyCeTBK7XhEfe1OCXih1Y09DroqZvA6y+Mqtwnsefu0DJKIMstFMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMEjB08y2owH3qGU7lVEPh5jLXMqmSYhcCRnmFeFIL8=;
 b=SPpNIpkKbhC+D6EVzayPiCr5oSLiHew25TMSHb4gKO3uac5Q5mYBYHimeVw4XWBwHb0WUhGHAbcQ+aoaFAEBAU5kqBTeGBljRXYFuzqqpyGJsix2LIDNmq5zOYNm0zR6v9DDyVUly+oZnw+qFcgHjE5Ekz3wkBXxM0mvn+zwO30ADHcAhAFLJ223q0s025mAMcrX7demFK540C7j7im2IPeXu313uhZLk+g7vabI/lyPeflaoQVdLIZXJ8tfr2/sEUl+68WFyUYJTN2sGdUELqOw0ZwhmM5PJeWI1yCTGNY9hKlxNKpP1fmWTAoVBJ5CeXvt/5qJ+Cys3hAFvgvtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMEjB08y2owH3qGU7lVEPh5jLXMqmSYhcCRnmFeFIL8=;
 b=bFJDTayCgEFvGmyaJXgCWvpo5+nnm5+rADdt1qNEnwm8X6pyufR+BSNi+kmfUC3aUFUuQbQ4kXFsL791Fz966aZAoZnKQtwvD6mcG9yBsKqQoMTBk1uDgyDjS9RSb/ec2hO0LVHsjASo/JbAqEFZCkJi8aI5x3YyHSmd14A5Rck=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Tue, 8 Dec 2020 08:27:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 08:27:58 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amd/pm: expose the firmware_capability from
 firmware_info table
Date: Tue,  8 Dec 2020 16:27:29 +0800
Message-Id: <20201208082733.126647-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201208082733.126647-1-evan.quan@amd.com>
References: <20201208082733.126647-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0061.apcprd03.prod.outlook.com (2603:1096:202:17::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 08:27:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d42abc8f-32dd-4914-1f24-08d89b532b4f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2507E14AB8987E5AB433DA89E4CD0@DM5PR1201MB2507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VA1llfWgO157m5lJ6SjWxb8mwxVHFcPChgvM/DU5sdWfkn8LKQe7kVov93708pjV+H/3gLZ3wNAf/8dR8PzWw/cXfJyNhkxl6OXAdB9FvhSm98mwW/5sNjrZ3PMmdbysGQXD/6Pim2djsNLAK292EuzXd0rS5DxVJuQbq8mmwOWIhf0zJG7T7QcAjZGGdqTQf0tN56sqR7pxICwMfZkC4T44wWki0bVyO+FTKPfwGveqNwLlfhoDwgp+P8cSfh3vo0jlMfhaVQum3q/jqgO8oD6mjev4V/3YNoV8NO7Dz3l9lZk4busdlObmACxpiiw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(2906002)(4326008)(8676002)(52116002)(66476007)(66556008)(7696005)(66946007)(2616005)(478600001)(316002)(8936002)(26005)(44832011)(956004)(186003)(36756003)(6666004)(16526019)(5660300002)(6916009)(6486002)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?F0Om7q79gPaRBHV12fYOotpJIG0Pj4ve0dzCXXtHQJ2mhJO+oUfuy0whIhvY?=
 =?us-ascii?Q?qKqawlzGkJEsupjTXTvmLwG29+ySby3kEHm5OxuqzEsPrkmRrSxsRub8mmzF?=
 =?us-ascii?Q?pRIyHW0lRtdYvsYlJnikuVEaGO9G35d8/hdiN7yDE96Ng79JouKnujm938Wi?=
 =?us-ascii?Q?q1JKsoQBfFNumqnTLq+r8P0fFP+YbT8+GSi3iK2eMQN4F5XuwFw9s58je3jx?=
 =?us-ascii?Q?Nc81iv+jzrjTzN8He6b0XxCkgFI1Qg9xBkQu3LvsWZ8lQeM6Weo+Zo2bR5u6?=
 =?us-ascii?Q?/cc3zFZvg/xTauUS1ZMdyOG4I4uP28yAHGc+/E/437lWMl31ifZdeBDED3IV?=
 =?us-ascii?Q?dcstwSV5c51yuQoIPErwYiSYfb1rMBOCFunOAPyptmHr01H+xi8q8XDmZqye?=
 =?us-ascii?Q?Lbdggkl3z1U/6eSvXbUt/u7/g//RFAWGsSOfj74Mj4J3FEbzIeNGbC2pQhuN?=
 =?us-ascii?Q?mCbfcFpdF4G2397AsqKVWyPRLINskxCCO0u+BfJBs59Ql7d2yTsUA3fJ67dy?=
 =?us-ascii?Q?byiBK4NOMY6Xde8VM+bkoob00WgwaEJ1IUBUHf7d2wGTxIwZV2G5S6onbjQ1?=
 =?us-ascii?Q?fZg8R9IGF7Y7aT0eY16u5cdIyQGuVNs5GHdSbN8KC+HobfpyNkkyY7jZASIk?=
 =?us-ascii?Q?bPg+CXhj1FYl9inIRVB+Fet3roiehUnwTqj1AWUIIkwPGGEAvArMXweZAJX3?=
 =?us-ascii?Q?a5NoENJ+tRRIFM3+4xDX1so6/7eNPUkYBF7bzflsYU615SyV5tHFw9WKf9bw?=
 =?us-ascii?Q?4GbJaKDsRrNxkUOKJkQc3qeR2qGLh4OvOccrtlp58cQBExmJIipZO+7tu3hY?=
 =?us-ascii?Q?wedolscdwSDRB6Qcfgrybzf9Mp9frdbYOGosP8Vbbwd4RcGL5LTqz2nWoSP/?=
 =?us-ascii?Q?cPhqf4xShJSqN/tP7RbT++h9oLyDJgxY1HaEh4MTVCcMZ6W2Lz03s0f1hPgO?=
 =?us-ascii?Q?NyelHrIB2Khguue251Pl/48krM0TJkA9JaIoOevTk3NG9VTDoTfX5x497muN?=
 =?us-ascii?Q?pveN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 08:27:58.3601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d42abc8f-32dd-4914-1f24-08d89b532b4f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JvB5vKO1ecqTRGRVbDyW9gYGYx5UkicO8uF2gAmT6V1i/ppgCu2IcbUs6wrcNT2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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

That will help to determine whether 2ND_USB20_PORT workaround is
needed for Sienna Cichlid.

Change-Id: I3852e7c8cb11c12845ca81e7967e332c499cb470
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h        | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 971c7fe4af37..cb96466605d5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -227,6 +227,7 @@ struct smu_bios_boot_up_values
 	uint32_t			content_revision;
 	uint32_t			fclk;
 	uint32_t			lclk;
+	uint32_t			firmware_caps;
 };
 
 enum smu_table_id
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index f2565eed469f..45ecd0386e9f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -554,6 +554,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 		smu->smu_table.boot_values.vdd_gfx = v_3_1->bootup_vddgfx_mv;
 		smu->smu_table.boot_values.cooling_id = v_3_1->coolingsolution_id;
 		smu->smu_table.boot_values.pp_table_id = 0;
+		smu->smu_table.boot_values.firmware_caps = v_3_1->firmware_capability;
 		break;
 	case 3:
 	default:
@@ -569,6 +570,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 		smu->smu_table.boot_values.vdd_gfx = v_3_3->bootup_vddgfx_mv;
 		smu->smu_table.boot_values.cooling_id = v_3_3->coolingsolution_id;
 		smu->smu_table.boot_values.pp_table_id = v_3_3->pplib_pptable_id;
+		smu->smu_table.boot_values.firmware_caps = v_3_3->firmware_capability;
 	}
 
 	smu->smu_table.boot_values.format_revision = header->format_revision;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

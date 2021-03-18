Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F3EC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F099E64EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F099E64EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE2E6E87D;
	Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E1E6E090
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2LzG5YrtCuQP6i3RP6kQNNGq0zFdqdXraFnKT6L2yMphBZsHA0aOv69AGqmYoe/QJNMOB/2FXjAHy7VXWvJII/G65Q2TADTa8NNOm8kEjYexxNjxGhwG+PpIxd3/bvhVv1PfhTLXnHwDrhHO4drh/NGfYyopWwrYSgXpDpsI4AqJWhqRQ9g3l8Dxz+CaaltH7CLNSC5AoIZRVEe03yV/nkUsCwpzfysk7o3upQc1DweebRdRQ2C+IOK6gkAYWQN3SyChUHieQSZH8n6YVffGRxVi/W9GoGfHeOVxVKn1vQz4/eHqLixklQ2mLvytYNeviiExZTRiiMo3VPRBLMdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NADsAqGZ/pILA+pjP/fqyXActUMVwZDs27uUAuBmpoE=;
 b=mnNFAk6BLujjVrtjlMOHu9MToGhxXLviDgUmJObFvgfCLCI6OL8+dDsZGug/v8kuZ3XzvgW1ez8dl50cyLZQ8YcLCklZaYM8BV/x3r+A49MCa7fnVHGwSV6uQaSTWgD6dv8klG/y/Ubj2shFVLkBiUsj3t96dODK6+iuJ3Ult9z7a0xdT5QgdpH/pVe+azX2MM78S6NWOTm8zgsyjkP98DEKy+vM4XZHkluDhbe5baWL4SAdzQygtQQvg5V+YzUYvRRBdcecerlLd/4Khd7uKwC7AtBYaV3K7HZKUC5cF+gPB4m/5NCbXgHkIAb8gReDQIrWyjswQfwLR0n1anfjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NADsAqGZ/pILA+pjP/fqyXActUMVwZDs27uUAuBmpoE=;
 b=pztZ6GeB7MT1gsO7HyI+AM6svxL0nIq3lE7AcTxopWW68ZaILiTpB7+PUBDQ2mNT5HzpdfudLFzDUMUku5q0MwSoXWPRVeuvmdMebhdPKbejMbDMuOb97aSCu40tikAfIHFORfalnBDm7bEWr9x9+U2YLzmcFFHs/LYv+5tDY6c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:44 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/13] drm/amdgpu: don't evict vram on APUs for suspend to ram
 (v4)
Date: Thu, 18 Mar 2021 00:33:15 -0400
Message-Id: <20210318043323.3989-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318043323.3989-1-alexander.deucher@amd.com>
References: <20210318043323.3989-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:33:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2f73aff-6585-4d91-4d04-08d8e9c703c4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4016BAB2EE8EA2A9DF54EABAF7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rArybklbdnLjAbT48crXVT8Ua7BkYAu3RJsPe8MqdQ3jvbnrqqykbzwKVyfKb2ntDIN/ED9+2adkuM0/k4c+NqcPrTjH/XoWcKzLcn9lMOdavG3YifklPAdDheq7PFfS4ID43S3EzUdU/iKAtrLJkZwskFbzYcGO5aQ7VxnD9nJovFWM7q0+SKPbzmvpyfR94pWmr8lKnKD+Pt56FYuaAtdjAhY+5qWojrvgZJThku1oToODZJ5X+sXoOtP/dncHE0IUpPr6MCsiTHRPGKfVN3Oh+kuLSMaPeT8TuDhICp6lWYmuXXj7LiY9vVNxKyYeyIIoaIG/ykqob7K/kxYq6iMgGfV5B9o9w46UyfEjbpC/CCZ31uSMZ7F6sfMivXeUE6bpYUg8ZwFp66JRWf9BHSORMzknhZDOh2RDDVRIWKapX0V7PtrwHnxMyw+IFuSvnT1a7XD0VmGG88phWfUioz0x8VIK0dZ72u4e2B2j/6vTDpxx30VIp7Offjl+J7V/1kIc7oJbrOZpbYxrceYQrYRl5+oXdEz6IuMK1/KD2loybd5bl2JNYfI25VGCB7aIKq7X1mETYB6GR5cy+pGTgcU/Av6HkwOxVlmMmT0DOZTPUaBhKkoPV+TOB6ayp5XJblXtWPaSBBuRh79vkazNfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(15650500001)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C5fvhX2pvloDIPFuOZOh8j7fdDxJ9FSejVZSOfnEux9N2DaRyyG6aZ0x4avS?=
 =?us-ascii?Q?A3z5Q69dde6wl7kyv2BUOxM+FA4KlYc8cJmdMMSUyG3DZYCf4b34NdsfF0GT?=
 =?us-ascii?Q?4NkoYH0Nd96YfPqv5sg8fkjK0vzulR4GaV77DBH8/9cDlwyserYKbkiKgIE9?=
 =?us-ascii?Q?2IISuxko5jtKGMaswpMooL+cyxpcYzT8qf1Ro0DbTRDnbCtXa88pUMs+o66s?=
 =?us-ascii?Q?mvI1AdRxXfXJgfy7dPadT8UXDEQm5TAPVhupwjp+IQy60Mt0XAMni6B+QSQ5?=
 =?us-ascii?Q?B9snBW8K1hARcJlIS+E4+T6qEHv8ZCt30e3UuzrodKj5fxEQlCecBDcyv6bK?=
 =?us-ascii?Q?WMLv6N033KNvW82ydJtARSQxGX2vx05j0GeIQTrG8J0D1QZY55/3ZGzsWouh?=
 =?us-ascii?Q?a4f/UggFIndHuLrZZNdLqdLxjZEhHQYECu9kb4mlLiiyI7+0LuR03R0zL0Fz?=
 =?us-ascii?Q?3G0+BIwqxdXl4oqQGF54YKlERsU+BCWIwSLVDg2uyJldZDiG+OpBHBbjWj8b?=
 =?us-ascii?Q?M7BjuCL1geCI8Z1dHjHAXKS67XZoj2f5fkUlee8N6TZQWObqyYIghBuhoMMi?=
 =?us-ascii?Q?F+7epx/rjCnWLn2srTWmPVnqBPUYxYDqJMVtUKHMiqTxDg+WzXV9KfUnSFiA?=
 =?us-ascii?Q?LrM1aD0LUBXxlNaeH7DBx1YIgu2z/8tUy6AKTNBTkssq1TtaXxMfxDuXXdnP?=
 =?us-ascii?Q?kbbEexmgUQdZSc2odXLEwS/Jv0kVpujbbCQCnmU2TmUgyAYSxQeTor7KYzga?=
 =?us-ascii?Q?jC4mKJCX7cdu3MHkDl5LWsiMSJ/2aycCHyFq/ySj+gUj8/sNcnkC6Aoh7Ecw?=
 =?us-ascii?Q?HHFegtt0p4BqgVPkBkwBirNY2k7NjvCzO8fgseEEbeOB0gLxGQ/kXWsx5ILb?=
 =?us-ascii?Q?fvrcERquJeaj82TzqWyhllQFG/MKSL+xHtdqU8aJqNVs6uceQ0BhtV/Jt4xN?=
 =?us-ascii?Q?6sDZNTtbWoDekbx79kmSAC0CJfj7Md4dpd5wfzIcvGZtEIQIddZ7iGgxwYiF?=
 =?us-ascii?Q?R2loB7vVbsNdIQGiBfqhNRHj83Oz6McnDpQlZBRzaXuNOPI2Ug2wBV02hpCn?=
 =?us-ascii?Q?NWrn6BhdEXPuodY15SWv7DKHzojYGMQRCguXDfhu67uW028VCl6Z5WpR5x7A?=
 =?us-ascii?Q?rH8GRuCMP3xCS8y/k/DK5Cv/AnpKgnW1lhZmstNsOrXTQt5+ibakF3hXKGju?=
 =?us-ascii?Q?oOrvafVv4lR8m7HWRE+eclrkGX29C3FHK21C1ALUWKplAWUPLbz30x2CLLQC?=
 =?us-ascii?Q?FRkAMmK1+xoadxAubgrEvXBEojroV5qWdxrf63Nf4KUL+Af8a10NCGUlZBq0?=
 =?us-ascii?Q?AeglW7bV3LaO+Su/qneITZhC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f73aff-6585-4d91-4d04-08d8e9c703c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:44.5806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WJa123QceqqIWo+sv8IxcdljCGZOy+xv/lW0oYO86qWrs2rnhQrhWgmFXD9l2SdZsqtsjOQAveG/Y/MvKIktw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Vram is system memory, so no need to evict.

v2: use PM_EVENT messages
v3: use correct dev
v4: use driver flags

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index de52a99916f8..a26e24d86929 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1028,13 +1028,10 @@ int amdgpu_bo_evict_vram(struct amdgpu_device *adev)
 {
 	struct ttm_resource_manager *man;
 
-	/* late 2.6.33 fix IGP hibernate - we need pm ops to do this correct */
-#ifndef CONFIG_HIBERNATION
-	if (adev->flags & AMD_IS_APU) {
-		/* Useless to evict on IGP chips */
+	if (adev->in_s3 && (adev->flags & AMD_IS_APU)) {
+		/* No need to evict vram on APUs for suspend to ram */
 		return 0;
 	}
-#endif
 
 	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

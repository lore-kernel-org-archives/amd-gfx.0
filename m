Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF32C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8573C22248
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8573C22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9DC6E81B;
	Fri,  8 Jan 2021 08:55:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC156E80B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 08:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRJ/Vyn0WFJlBRNxPVCXfD7TxY0dqtMZZ5pCTduj69C9Thi73nDOyd7gBXXP4UfGr+LFJdsXrOTPwjtFDBKC39RseoRYQLK6/5ta5Xzg3eAVGZe+vgXvBjGiwXQX94rQKJ3yUPwx1QfGJXjLGFpzDc6vCuUtdRp9vo21cWXlPh7uDAet37CSlo2/8+ilG+kolyCImnMcbhc/KpKRMbbjVCD3AIVGoL7/C0EnE4go1rDvNs9jjufvDpLTpPNbi3hEGlsD1cR6mBhRxuB0LtHbd+orNWIoNhHWLTpQEKZxDrvzg/K4QsB+a2BWQaloHm4h+Qz57632MjIJpHElTWz7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUTuiM5cFWrVZBEHI2mEqqNAsEFARkTJDaYtrx096c0=;
 b=UCZlfIOqF1jCQd6vm2LpNH4G2yqGKmI6BxXN5xWIKnZxRdOWwHp9N1EgoH8X7RBM3Up3dG8E7XERJHwq7MnBKHo5OM25HM2ZyCgrfxim7kJ2SvEqBaaSfA8lhjX4VfRYEt/z/Z8W+aU+KeEkIE6Z5RaD3l6kkLTb/E6hp/nNtEA9O9id/j6TzvJnkIHipugTI7kCxAnIeU/FKlbZJ6EF0s0DvPbdWkyhBENy/65gbYYATj1ZsrrSHQn8dURmvzZdp0ERFQwEW7grUx7OLh+SEyXIxqO2tDQ7Qew7jxlyvUwVAVgqIHzHsNVHSYjP0l6W5aXl49dz/4OO4a6WWhDEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUTuiM5cFWrVZBEHI2mEqqNAsEFARkTJDaYtrx096c0=;
 b=TJzeqnl3XorkLJhYNFI2dWHfVhttaRXt7bgQ0iI/0NmOV9t0ng7AWBaWI3GBHMq8jw5mZzOS6MOf35SeRU2hDM6oGc+5pXk/gDh3GXy+P4b4lo+2BsR7IGh11d4SiyQLIS905V0sIMoD09PBCaxnKK3zZZNyZlV9M++MBdmuUKw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2458.namprd12.prod.outlook.com (2603:10b6:907:8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 08:55:40 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 08:55:40 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amd/pm: don't mark all apu as true on feature mask
Date: Fri,  8 Jan 2021 16:55:05 +0800
Message-Id: <20210108085507.1164588-6-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108085507.1164588-1-ray.huang@amd.com>
References: <20210108085507.1164588-1-ray.huang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 08:55:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 882d1357-7b66-477f-4253-08d8b3b32cd8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245814A36C66DE5E9CE9E6DFECAE0@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFtyFQLBzX8C4LWlKty4hbpTOPwGWGk5qX8E6EM9RO3kN9y9YwkFL7gtq5U3bZj4DqYTUx+CUgeYXUKqrNDi6+SpHSudyKA7/DdAw4jIocIvYVnTnmel44HYsGfdBx1KAfj/II4ZPEchCx0H4iB7YBsK5YOfv2g/zEUk1OYGDa3hi8egtjr3sK0uxWMfx8qiw/bhUi7UWvRLscAQ2P7hcEmALpPpNbChETFsTouP0gWMM7oFCkV0axf3AGOZASAU6a/MeKBBp5bXKKroNmNsvpjuI+tWMuqgAMjsuX1e2IYW33JXrb4uJeWyvezHGuu7LdYIFjk2alzEWufnM/O2P63paE7fVuaasWB/B0PoqAWjx8NGGhE1pTnK1ZE6Xwt1/ABsWItdYmq0TrgeIGwD7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2616005)(956004)(83380400001)(36756003)(26005)(1076003)(7696005)(86362001)(4326008)(66946007)(6916009)(186003)(2906002)(4744005)(8676002)(8936002)(52116002)(6666004)(6486002)(478600001)(316002)(66476007)(54906003)(66556008)(5660300002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dnI5DzzU3Do3L8AsIOFOTQcC8WhuZ9Om/N6pPRu9o0bzDUYgLhMgrOKYfeDk?=
 =?us-ascii?Q?tX0SbhA1BwnJsNaJYCMM+0cmDa4xGBJGpSQ2D1W0tEOndEMTXaA2eUz9T5JZ?=
 =?us-ascii?Q?DB+d943eYEFXz2fl25XDS7U0Grm/vzhQxIljouIkLQUzrFlgSIfI5FmLHo19?=
 =?us-ascii?Q?fWHNEJ9hIyVFWZ5HRPVhx37/OVRDJS+khJcb5LQYCiTrBJ/W4MhLaPeBuszi?=
 =?us-ascii?Q?fc0aQp+W2x63BRLEo0trCy2dwOlIEw8cpe571Giglxf0UoQX5BmVj8Xbrvdh?=
 =?us-ascii?Q?qiXELALjMbD/xzzni+HEGX6xFlq38OzZEfYSEMkM43e0aIxvMyoPn6Hh5oT/?=
 =?us-ascii?Q?AO5xNtF2O4rodwrZWt/epDmMqHqfOPdXr45Ibf9j3KprKNuCr4GuYsX537jM?=
 =?us-ascii?Q?RiJLSv3bXTYyBFnocSrf+twSj/x2sulinEfO1oMzR07aj3e5OWGafWXj6cvS?=
 =?us-ascii?Q?/b19Bn6sEDbjvDCggI7YJYfxbm2OoZjUTjIvWvjFVcCmSskfcehtpm+OqPas?=
 =?us-ascii?Q?x5Siv9eak6pYT5ahAYNGZRSIMFYAkw4eSlCMF3mZjp1ZT0TYK/BBOWRUzT7W?=
 =?us-ascii?Q?C6nxblPMc0UF5G+AsyvkuES1mIm108alybzwe8c8lAooVWFjC3ru4Yo6skCe?=
 =?us-ascii?Q?cqMG5BJWXbdfIY944ht33C4IxwguQB5fU5gpE8DOO671zdGXYS2X4hiicK0C?=
 =?us-ascii?Q?TUsx+CVsQS/fMIIZBE8wZ9bxju9sILO+qL5gCfCmt7Ci7vLfja91Cp7kTETr?=
 =?us-ascii?Q?J9ltU0kqrVzrurUp2LhAoerF6AA1Bok6MwreJwWXQwDcttSVYUF40rYU6M8J?=
 =?us-ascii?Q?gDbr1zQKwDdt7INWLHKVG2NMzxzS9RhkLwF++YCv9QO6rhOzsS25udxcjKZj?=
 =?us-ascii?Q?nYHbkqghQ18r87/MUhxJ5m+P8jT/JdNuUH1mhS+8IjUtfkZwVtYc9ikT6iiz?=
 =?us-ascii?Q?s3hQyBWzb84zbArVj8R3prKKX+9q1xH0ICij0dbgHCfMa/lAIRtVVaY1wHpn?=
 =?us-ascii?Q?M49Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 08:55:40.3674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 882d1357-7b66-477f-4253-08d8b3b32cd8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHBsh6rQsvY9Rw55yuAw2wrYnARYjz7/9zCbX0VLxdzB0a2htanpXHK4F/Ww3peG2uE3+ruM7HQVP4M9aQZhuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VHG based APU will support feature mask checking.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 42b125701436..540dd4ddf09b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -271,11 +271,13 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 			       enum smu_feature_mask mask)
 {
 	struct smu_feature *feature = &smu->smu_feature;
+	struct amdgpu_device *adev = smu->adev;
 	int feature_id;
 	int ret = 0;
 
-	if (smu->is_apu)
+	if (smu->is_apu && adev->family < AMDGPU_FAMILY_VGH)
 		return 1;
+
 	feature_id = smu_cmn_to_asic_specific_index(smu,
 						    CMN2ASIC_MAPPING_FEATURE,
 						    mask);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

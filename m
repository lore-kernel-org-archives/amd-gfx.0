Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32668C47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0202E61C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0202E61C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BDAF6EDA6;
	Wed,  2 Jun 2021 16:50:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFB06EDA1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llvmUbi7ENYdHSBqbxKJH988WfCIyZ2TGiDb8ol+JQzuNmPfX0R+E0uMnb5WyvqkbkSHA7DQMkkgQjNe6t1hr3r5FBBIsCqSFhy0Z+cjAJiM0WBBFq7KpwIYWf0VrizAdmAqSKxdY/la+c9JQzF0uGnVkRWAu71+fZ+7C0oPf5t7lTh+asUJ2lhL+DuviqZY8sLCVgei3QAqAbNBOY1YKdXh5amoa1cmHtof3d8MOC8uQI4SIZCleFVCxpqBHR6LDRQRw+qMZtaoTihTciuoQ0KbE6KlCpVMYAjrg+cy1jxXModN1qgNE0A5IShE++JmZLLwkSBSk4RgOcng+673yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZQRkax/y3lacktDVDyLz9eEg023HqeMBYhLlOA86MQ=;
 b=LPPBoCld0tRbHkUWkZrUo9hNyssIzu03jITEVH91BazvByMJaKlSyWrPC5qefD5goOx7pve1R8VuOqNTxGOsCL0rCbZxVIgySXPL3rc7mSB+XxoeHsbBiS7+Xe81wzCxqlD/1VftXxL05r4etVvCOznmaMWVjbQBES9TR0B9u35Mp4ehU/TzUor5UVbAxE2HlrSBb76eX335XxdbR+LIVon0T4ppRsgNQRNohPGV6tfi/zF8qh/3dSwZ1p1r9Dcj1xvTmjOYuxHAUpg9QBDipp5IQp94yWQ8u6UmDweQw95UBRrzGz1olOZguAYE0eWtWrXLaFZ2N+HYYrp30XJTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZQRkax/y3lacktDVDyLz9eEg023HqeMBYhLlOA86MQ=;
 b=sOlEHy6BRzaYOaBr0vBGx+bp85tDZXWL5MaEC+vOY7tL/d4lybLokTzB5of1uaF3uc44z9px17wWclgt8MOJ6XJMKMIyUv+VKEGLKVQv75yAhBnbtm73Vj89xHWtvVxto1A/Hf/b7u+/9AWngMVacIWwsE4CVDrmw/yIp8mTyK8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:26 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 39/89] drm/amdgpu: add IH Clock Gating support for yellow carp
Date: Wed,  2 Jun 2021 12:48:18 -0400
Message-Id: <20210602164908.2848791-39-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1809d1f-6eca-4327-cd19-08d925e67347
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB467557FAADA5B4C512BEEECEF73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tdYGt7sFPIfzIpichHJ5xK9FJF7C4BRLqSjwu0A1qY4FSjTP0ruMquHOFXfsBK7POOFYLaqucGKNy/Oqp/tWYN8pS+ObNpxWBORapyottb+5IgOeSi5gir2GAgEjgTHiRS3hGeG5y4YibOyB0JLinewqmf9aXFe6NuStqyB4SoRm95UDl8L0zAy7ixgs3dAJol0nUdENc0Rf00lWP3PIAdSG5XJPQr6I1PTOAhkBuBzsEE0QkOFYSdkgz8oHv09k2dfBK51EqyEXJ8H4amqdUp7VOAW394s6n0Oj1OGnEPbYBIsFCdQvHtR2I2VysHHLD6EFEetCu+E0/hpvRORT17MiEHk/MF2E8WBEpNvnhnosyxiAY5A1z/QtC/7ltyVf/Yju5UsMm8AUc9qqHDJbSP6Bowu1HBPb779GnXZt0zxn7HyU8Hhhgy72fQulM5TSfhSpCgnCfuvDoiei8QXHkLHOQT5QGspdnZQ20PzBtYeE1zMlhA9bquooO9SQVpTvxrvyfAM2y5TKdj7hYnPfQTeA88WbdeGqzPwst51Qv6hTeHaMQ26mGBY8s15Z7e2YVZyUezKpMY0tRVDByL3qrKBHEK7abSJwMjFy06WQAfIgad/2ADXkbX5KiBGw4G599ihuN0mStqru+LeMmOc+GjgBlSsOjHrZXLheQ84op/fxsBVZ0ADYbp9pys1x4bH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(4744005)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K9bj1yuccwminP34r4gjbI09xH0ed5heZVKsl7MScwtnZaP//nxHn7uEsHIb?=
 =?us-ascii?Q?wQ+GoJbXhfbd7usGuaE1IY9qZGgCCnBjKzdY8h27cyb57xjRRqXMZU7bWtEn?=
 =?us-ascii?Q?x0sEbpYOI0ummBtk3IBnZErNwD59CQcyAyPOP2VGjA/Fp1LYlPJ0WAU63Jeb?=
 =?us-ascii?Q?jdNc8YCJkhPYi3zraBFs5HW57lSeCTaYYU6MLCQgDIPherq0lNcTE/6vXKw1?=
 =?us-ascii?Q?QrDwCJ3rIBs9mW0jg4Yjag+QVxCl/+uipVmwtXeuGe5XnnIAR8kYLxSm6v80?=
 =?us-ascii?Q?9X3m/vzPdB99KNkQcsldqSn8hXdGnVcl1lLFsVxNV2qKvxZBMkRVA0QCTHBT?=
 =?us-ascii?Q?PZxTLexUz4IsaSuUSS/tUB2z9SgVe5nF+hB83jyDTbdN8cnsCXjt0jdndzMr?=
 =?us-ascii?Q?gzy+EIiBEgqGpdMWY7/YR94lv0jTwOZcu8grcVdJchfi2nY7+ptOASDO7GD5?=
 =?us-ascii?Q?Yuv2CnvUj9SSg4//hkof2D8nvDD/TBdXyPW1Qrwyr0kofuiuYIdge14OByy8?=
 =?us-ascii?Q?K/twPqe8mUYtjWbpst/Cn76n+gEe4qfHbpciAwic1uuLCIhluzgBMMHJq3vf?=
 =?us-ascii?Q?i2gL9tXnlGbpEowTND9S4sHMlfjlkUmT3WnpYLGRGBSukyoCr3Hb650dD9SY?=
 =?us-ascii?Q?pPJZECLU+mbFyMwQ2h5hI8K+Sw5c085GW/DH/EGfRZV8auQmGYZc5N3XrfQJ?=
 =?us-ascii?Q?fY13L4Hsmi6c1IUzpZjuBRt1nLy9xBNEQlDdJyFpQESKV+y22v/LW33VCr1J?=
 =?us-ascii?Q?JYaFlsoK3htI0yGL2jWdm5Ts1NlO7v+eI5dLuIn3hXYYw6XcExzZ2iOnHBe6?=
 =?us-ascii?Q?NtZVYVNaDgN6fwoUtP0F9H7RrsL0M/BIeCrVs1zHOE0HtGU/R8Irq3Yc8265?=
 =?us-ascii?Q?JGzBLwWuayLJSb613qhjzLVzLVdB8gX60d5wU7KvjtouJpWEdxOYZ08HrZxH?=
 =?us-ascii?Q?/Sy36/bBqhpGLsKhJO4qiXmHFihArsrtICxlaJZrIMGnqU/QMVCcIWAJSFRC?=
 =?us-ascii?Q?h15irfVKT6fXepCYcMzRQ5a+RKqXzaHXlCmOMm7HruUxsvdUpdQUgHYdYhqL?=
 =?us-ascii?Q?qoItJmawalfj9UQ096Jyb1FaYBHnPiJSouZVzmLDdGkR6D1UqRjsyb17N2l8?=
 =?us-ascii?Q?GSaIn86I/lsJiGxaIw/DVvOfjOO13WwoToWKNn43Z4XHU11In0qT6MuGwebb?=
 =?us-ascii?Q?vfPDBHh8Qchn2U91vNobSSfY00McmVPovEG8bB8QK2oUPlqgOI9C5bNdhJr8?=
 =?us-ascii?Q?u8baNyYEicNiArK9p1FIRxgBXW38KFGi7JVugTwegndVPDe37dtlbDD8MFoP?=
 =?us-ascii?Q?WJ0QtYx+1ECWqM8jUnSbAQN+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1809d1f-6eca-4327-cd19-08d925e67347
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:55.8179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhuzxgHNawHg2UHTe0gAjHCjbwEuoR2o+aByK8llhf16a4O8KutUWbIQEp7kWMuaLQ0M1ngkWEs3K1LfgjM3OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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

IH CG need to be enabled by driver.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 15f5d9aa9485..fc3ad33b4de6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1340,7 +1340,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_HDP_MGCG |
 			AMD_CG_SUPPORT_HDP_LS |
 			AMD_CG_SUPPORT_ATHUB_MGCG |
-			AMD_CG_SUPPORT_ATHUB_LS;
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

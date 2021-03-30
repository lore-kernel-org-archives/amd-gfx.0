Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D374C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 14:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B9D61920
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 14:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B9D61920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEFB6E904;
	Tue, 30 Mar 2021 14:05:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A1B6E905
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 14:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuQEY5inSdGePXCMboS8zI9ht8GgYdq26DfrF2qaHGTP2cCG8VvgBsK2/YgYVVJyZJ9nVufb3L395iv1niHU3dRj0OLrwtITq2ZVHPo8mCpUbrP5oVlAk8gXprkYoIA2tF5714iwaxbUvJUhBpbEybopw1bMHqzoFFJjtvIeEQyuCRronJa+mzS++kpr55/lvmYRMc9LdfAZO80N3CqjBGZVNfi7khvgp3H7aNCW150ZRmo79GjxoAImJZr8+WLMm3O3fWrnU/svjO1pFIXu+kA0c0DK608rK3lWZNupQrCVWMiyzD79+wJHxYrsm6TtTlDQNhxgnR55wHWg1oQBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlXh4WeroQx0/hWhPCRMXFjSnt+W/deV58K3pWUTey0=;
 b=PBIncfwGFljLEh2r87JzVOr8L22zStQRk572U4OkDb1s1IbvvCymMqV0MzxB2KBWHgikeV3T7REi5fADyrXA4X5EckMEA8WwH7dnVVxLfPZhX+xPxgnn37LBK+k6XSP528dhW1zvKnbHhfcqbaoAeVMHnDW2EML5SbFLo07NB2NGJwQGwyJhEcdnQASWIbv8uT/uyaYbd3iLoxX6KvHh1FrqJaUYlzbdAu7ymGv6IpGeL5X24ogRpLXPhSzQ8XykFfN8AKcs8vYFE7+BXs7fsxoboekjfnW/c/9mNL9RJ/xa4V6ReVqNQMl7Sfx4Jy+E22dJzx5+ZcE/5AQY2/VGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlXh4WeroQx0/hWhPCRMXFjSnt+W/deV58K3pWUTey0=;
 b=csfKGRtEXmY2x/m3yAOMAzd9d457FKAsuEkne9IvduNKAj/050s0yI9X4e3xUMW8/ugsoI4d6+bLEIcZU52snU5H2Ne+H4B7wLbTZGpnLWLdfc6ZkcYd7sUWgehO57BwXz45B55EaXdSw/iA9/zZjiU6azKigak2FjnHQaTcV9g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1878.namprd12.prod.outlook.com (2603:10b6:903:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 14:05:05 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3977.032; Tue, 30 Mar 2021
 14:05:04 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com
Subject: [PATCH] drm/radeon: avoid potential null pointer access
Date: Tue, 30 Mar 2021 22:04:05 +0800
Message-Id: <20210330140405.14086-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.0 via Frontend Transport; Tue, 30 Mar 2021 14:05:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bac49a73-da51-474e-4dff-08d8f384d13d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1878E4AE2C22744F4A88AED5F17D9@CY4PR12MB1878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +z3x2ZjV1VoRKK84n31KVhAp9Fnu76mxH4Bx+Gi+YPIlhIokZeb5UFNQo0wK+NrUmQwx8ZM3hvcHkX//VYaa1mJoumlf6F1PbBweszIoPKDK9SWztdFjxQQnff3FueizRpW4gdsO13Y+RzS1UmV8ojitJxaWtYeOiPfVltgNbBkAFpS5VMv89Q0zVfLD11QoOjV/kU0QeQLp8SQBI/fMImwKccvfy7oPuZufFrKHAk7J/FgcV6OcDCU9fUUFCXx0EIBOMXtzQiBkJTaBC1KlIj1yDQyue6/G0GcuHkJ05sUV+idcPJChJJkimsVNl9ArB9Oec8W2t2QxJPOsThyWo9YKxy5w+ks+x3Ju33MxroDHiBguI+eQ1EgA/4m2DqNxRMD/qSFvR+oYwDLhbdWWibs8IgGvAGHrVEVOc6zfkIWJRSUF5PI2f+LAZEHMlt+XbWT1rOg1j3zaq4YN+j+RFczm0LvX6Pq8gj8r3urS4Ux4fiBMVkCDUleeozYpDSZY1+S55twQP8JqV1plAUmKtenjG2bOZ4gj94u8jj+IRQoZ2IDC8JyHOSqLO4vQSqjs7OfFOJ37KdNJAKyTg6TEyuJqFfWwb1mM1guYgo4Wzt+dQo6IxT1A6d/T9GDSAevGUYZH6h513FPSrFPLoRSuUQMBSGEBu5T/FfMwHxsrVlY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(1076003)(8676002)(7696005)(52116002)(956004)(26005)(38100700001)(16526019)(186003)(66946007)(44832011)(6636002)(66476007)(66556008)(86362001)(4744005)(83380400001)(2906002)(478600001)(36756003)(316002)(6486002)(5660300002)(2616005)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RlhNNnfkOGLePD3f/D5YnjtFSJny+Vql6SOVrZXOK0YFlYIaovjFOHZi2qAX?=
 =?us-ascii?Q?JF2UDDA1z+TD24xCR/HdkLGPSNGOMrixBXgzeKN38Y0Ybgrywn1jcyQ8Wq6E?=
 =?us-ascii?Q?+XdLnfgjClhezsCauK9vvGlBdorOBWumbJWbBWOYJMwj19fQCpDbbBslo0Lj?=
 =?us-ascii?Q?r/Xb+h2POSrQB9pv3q7vO+fHoNk+V3goPjOTZfuw9RtZcSlihTswAHLhkVoX?=
 =?us-ascii?Q?fHNgwHnYX5KnQRcbwec2UTsmF/HbB1IsR5YZ711josWcD6tKv85tu738tZkJ?=
 =?us-ascii?Q?wM4Z/3N6TLkaq2076CHTihOVUsM7EsxjDzLZXkfbRO/EqXIa4sW1SwwBWKwM?=
 =?us-ascii?Q?CwasEt73ar8rgz1qnGfkOTr6ndXycJm3ZuNeUJh6JJgxSnrNMfqfOkIgzU2d?=
 =?us-ascii?Q?cMy7BbqUfnrS7DmfTZRMUIEauqdy18BU7W9JTOf5OfhKzmxd+VbjTS3o9X8G?=
 =?us-ascii?Q?+b7CaU5+Fzd6aHziEznVrpKMHFir2ABXWPElTZeDbDB1v6QMREyAqSvouHSp?=
 =?us-ascii?Q?/Pec0VTiHOw0nBXNkDhvzjqfSHWrl0Xo8PRvfCehFqdggsEcO8FiLVLAFj96?=
 =?us-ascii?Q?d2rcmrM0lf1JeOx5cMD57TeNiQhwh+SEigk1nVaDVX9+k1nGAPS39MmyBHE5?=
 =?us-ascii?Q?o/ckANRwnGVT9Ucd+WhS3CCYP+la0qAujfOf9hTxZC6LO5sAreVHnV9kI5Rr?=
 =?us-ascii?Q?b7WfOPQ8j0ZY5c0DBHeGPpRWbUw04yPpFWiuxVlO4BrhGT/cgxIQDqv+cTIP?=
 =?us-ascii?Q?OeZ7L9xaLUGanGNMCyEKCOdfptzzRSkNH9jQyKBJu6S30HURwZSshLCeU0sb?=
 =?us-ascii?Q?AvmyoP8gEMZFO+8a96DJb7rC6CTkGxgUIdSu2V5BC9BiWDm5dtH5JU7+8DoV?=
 =?us-ascii?Q?sDd7XHfGb+fGa69Qa/8nEK+w8K9tCbZQLhb1fIv9MCK/mFPyt1A+rwwPz9BP?=
 =?us-ascii?Q?69wL51k2ow2id8Qvib6G3kyK0WjufR7hatLCbix4qI3zXmKR0aHeroFaCoip?=
 =?us-ascii?Q?rVO+VfBIX3Oxzw5IX8/j9K8CNJ8M8Td951b90dE4LMjnXMjdL5qKrKkf6Agy?=
 =?us-ascii?Q?s9GKFGbv0zAXUfIfoV6dD93xzR+5Hd1EeiCuTobiiM5iFJUZULXd4NZVLFUE?=
 =?us-ascii?Q?a1W2gZfdnEcYw5YlUrwmQ6eGlbAknTixbRb7arlejb2vRWCIMD1YG7HDLl3g?=
 =?us-ascii?Q?rbf22eehYQge8VI6AAJJm8FfZQMYNg8A0++QTTzePDcNkyJ+Qr8f+ZCGaJID?=
 =?us-ascii?Q?iwcqAnO92PnXdptdyQ4S/EZ/q/Sp1ic2ir5YRfKgET4s1KpHo5IK/Jnxj7in?=
 =?us-ascii?Q?og9sOuXA+7QDfoJWkXWpLMDnDKeDqK5XKbNlSrIaiDQHVg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac49a73-da51-474e-4dff-08d8f384d13d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 14:05:04.7702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1WtUt1bs0tY0BWbLzR7Sy9iplrIZNaARPf0pyY9UM7ySjQmjAIHzKnRcUSvPerszAbWvQYLI1bBM/cvYtim0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1878
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Leverage the same logic from amdgpu_ttm_tt_unpin_userptr.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 37ac42d6740f..2a61cff325e4 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -415,7 +415,7 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_device *bdev, struct ttm_tt *
 		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
 
 	/* double check that we don't free the table twice */
-	if (!ttm->sg->sgl)
+	if (!ttm->sg || !ttm->sg->sgl)
 		return;
 
 	/* free the sg table and pages again */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

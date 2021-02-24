Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86999C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4441B64EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4441B64EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B906EB8C;
	Wed, 24 Feb 2021 22:22:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621186EB88
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7u/YH3HhhYnuYL7Dyxp87h4RAW6EeNp02hn/LbTnYL2O+GSTeilidiI3iKFLyL6ejMcb96XeI9uVE+M4O24zy4TODjD3NDVAa7pShXm/Qfh9pHX5DTVCZKaHK/L+0SrKKGLsg80kh50BXSP0l4FNHEpyMuKsLw8NA5X8L/vaDDxsmI4aVAA6A1uWGDYRP7BTN+ga2jCooLfpXZ8XOXpC997+SqDQG/RjJ3TkHLQKhLkJil2gToP0geooFuEqVrw+esD6UnG+zbnepc6u8XltXTxGI7gZwx3Q27TKPOOwkRB7ERhoFi87M2xACl1j5FvvdsUvbPz7i1sYYccAQBFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHoNRjr/RzsqGbWX+5gcwqQMATHhQj/gnBzlCkpEqVE=;
 b=l6hM2MLjzn8wpWnayNJ8G28Vagq2jaj9Fnp+QQw59iHGNtQHTBPaSK+HUeFeW6NAQ12586ABG0GKJCNQtjHM2HL90s6Kzzlel5s6vN1QFXS0x0dYW44oqwiByGfbJkAVC04j1hS9bU52dyOxc9ApxS9xcnlhQOyGoUgdBju7Qevu9ekYUmgES9MzqlCbJBq5qFqZyAW5knmLTvB7CBfZTsAooqr1MPmrfxI23ixZ2LAOmv7uZ098kUguJMG74J+7CLJRO60//vehBISph61oUK2+5arunWNwyImVaw8DCcqdNaIdF+66igkfZX3erwYf3vr8KOZjZrHUbfPP+pPjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHoNRjr/RzsqGbWX+5gcwqQMATHhQj/gnBzlCkpEqVE=;
 b=bfdxZpk3arImd2yiYNBBpWpPY7kfSugm6JZzc7wQVbMQOsp/XI1+yyfayP/DDOQlDuk4AYwgoyOafF8NxKlYiqWZlWwgN2IZ4CJyjA2QQNva92mf/x1GMcV6aezeDH8uHdZuqyYhVacdqMWXdTMaQGpaMraj6IqC6PZR7i20/j0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:21:49 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:49 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 120/159] drm/amdgpu: enable 48-bit IH timestamp counter
Date: Wed, 24 Feb 2021 17:18:20 -0500
Message-Id: <20210224221859.3068810-113-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4073ba1-f153-46bc-c8e6-08d8d9126e0f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB380766476038D17FDC15E645F79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqDeEXmzezPYKc9BdjjZ6Ah51KDDuezP6HMp9Ht9xcbgTdLAhqILZTqRRYdxCDAZms5wVTsVlGO8KMfdnF6ZZMsEAe/nQJntzK1dgoZch0zczzGTJSpFoORXFAo8H+5998svS+bPsTFPYftsohVK5l5oUfcNsXmNCBNbWbdSWIHmNgEj0jfRCVfBfszisgKjuii9hP2DirQ0GMJS5noL5/oeYnF2gnys1rdWm+XjHmsTrr4g4we8B4tgXxUjsa061Ll8RW11IsVoOwyi2I28rdwMj8IqWO18x701N082AEJVyaDA4Yv6HX8pB9a1KSjI5mRgC+pI4VYezuQjCxnP/U2ahBbNHiqr0C3fA0mPzQxyqery/AzgkjbRzQ8HT9n9Tdndpx8ilnLTYdFSo04aDrbuRvl1Um2IHjC6ECIb5W1qgbkqrvBOa9TyxnPJ/l91+QIHZfxBnngDnZOU+YHHbpuuwHv3rkzTzVKQ6b5QCcNnq8Xzvh3AeqQn17YJ9z95JqiFxBmm8t7mIow2Xmu+yFxapgm3UbwxQ8K/q28cwct82KKeGTJNNkNITCKakmtmGyrLRLS7crmep6RHt8JnrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(4744005)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7iMSRH0f9y4++IhndXp3C6kfOwPMY9M+bmEVfZoGxWKeUt8kdfNKfzQx/Sx1?=
 =?us-ascii?Q?a02Z7CZivPW9m/7pS4sWz3D/DpKrb1DprQNBnf2M9Zw7pFof7i8GUAhUpZLv?=
 =?us-ascii?Q?GrUFUqB6jnfrInq4TBp1Ug49tVE7U02bCsNZTX76MC9swXTsA7nA6Sa7X3WH?=
 =?us-ascii?Q?y7U2zhRMPhS1luvPv5LbjZk98/iOvgwgysA/2IvMX2sq9sDKHbunnmV/cKFD?=
 =?us-ascii?Q?ER6ZZyF+Cz7S4m87U+pJgAPbVJMowFehwBqjf4515oWRLIeLmvK00Np8h9j6?=
 =?us-ascii?Q?pH9WiNpMLQnYol6dVknu2bJrCg69oKadTpd3tf2mAQvRkk+PX9WXRkE7hyBW?=
 =?us-ascii?Q?U7a58aPajomCtgNXtIbXw6iMpw6fxzIjncz75utWugDkI8GyddR5D+QLmuDr?=
 =?us-ascii?Q?Y+DW8lW/ITT8kxW6eU3Hgisd74nqM/EUrLwx0rQtofXUN+DcNPpOO4rYGxhg?=
 =?us-ascii?Q?4GQXbqx6YyYLNBRbnhbxF1uirf8J3z3E0smN6tbhVj4U7nTOhDVOM0XEC7rX?=
 =?us-ascii?Q?OluYGG2O4RNC+GiXQJfZ+FkdM1ZzUMyhRI063Yyr8Kc9W0LGn+YcyhcqDPKZ?=
 =?us-ascii?Q?H1St1LU1Jqvb1iw362baKth3obfFhQrK1kXw+1Kf4IVeSb+EaUVcDJOWa47W?=
 =?us-ascii?Q?dxkdPNgZ35OR/b3oHRQhigBVPMZgqQqp94zCMz2hvUpAEWepUD0YZY2ZBais?=
 =?us-ascii?Q?bYOq+3adkoVqohzFHx9l4JOAreDzsTYFFv+2UNj20LqrRiLzQ5be03SxB5ni?=
 =?us-ascii?Q?I7B46mpUrDbwSNSEZhzeMbXuV2/i+TsxJIADcErM72V8MJb4E6B4JddqF+WY?=
 =?us-ascii?Q?8skPWxSXrDTjXWIpXuom7iFvsP5ttpWAIpgaLnGdKakVtWmJfyN81wcnSMoL?=
 =?us-ascii?Q?WkSeO3NFCuEO420gesbaoiqU9cS/2ckG3DuhzRlLw0iXyXaLdK+P9tCwAoqo?=
 =?us-ascii?Q?TO7xpM1gXtdtRRGukOx9DLEMiO6r+/XEoVyxMtMsRtwSbAh/t7K3cmrh3l5I?=
 =?us-ascii?Q?oXMPHcVcNBaUseEfC03ORmbYZwu1tNiCHD3JHe2Ex68Lg8vASPUtqueiUyis?=
 =?us-ascii?Q?F4JbJva/ngZez4eeYfgatRgn0s+0RpUs9NS+VSYa+OQ/7hO10AO7wxRxueqC?=
 =?us-ascii?Q?W3iha2RjT1Fvo3MLNa4o/v+E1NVyeD4D6ybi5Yw8OMoj+lMrrpPQMVObYu+8?=
 =?us-ascii?Q?WsRpXOa/SxN/cA3iFEwppOTV8CwwnegbWSPcIjxBPG5OpmkHSDMoFiDXWXid?=
 =?us-ascii?Q?y1jECn11uwODqqNPcHXGgOqEatsDpyDhIrNwO6EYhpI3tK4Y6H6+zcAup60h?=
 =?us-ascii?Q?y8k1dI4ZzR9FT5npGGPvqNxd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4073ba1-f153-46bc-c8e6-08d8d9126e0f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:45.4411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BspJU4q+zgICr7JEJoE3zfgbum/WwOhUcIQxaEtgG6lzFayiVudFAgNP3kUhYodXlYuk+v0Us41ajugvLEUKqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Sierra <alex.sierra@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Sierra <alex.sierra@amd.com>

By default this timestamp is 32 bit counter. It gets
overflowed in around 10 minutes.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 101416c646c7..6c3cb3513b98 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -107,6 +107,8 @@ static int vega20_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 
 	tmp = RREG32(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
+
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B919C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 17:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17AFE6511D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 17:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AFE6511D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87336E431;
	Tue, 16 Mar 2021 17:38:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E2F6E2E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 17:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQu14D9aMbw+RH1TKId1kd1GIV0yhGq3UtfMg0lRzaj/yOx8ZZZtmVlHETqQ3Dyv3pDFerrjTqk0LL1tunSJ8U0MLA26yp1ObVgEJCq4O+IUUHEQ6WhTr+XKT6qzUB9MQw2yGOCSS0CjIGgUT4r5FxnVBbWkantfsNkTA6qOneHl92pEnLvBia69eb3JWVJPXpMcLXf21qlhBCvB8Yh7DJbPLfAmcgT+K/ekgZ9X0FQvhmxK92ia8q+OyukWO51mtSwQUhrbK+2VwRw//oAEVmDrR6NiO03Tge4TbPNDR+XftE01GKjbLFP60PWqRz8JgPZqJ/8Ne8Tm3P3dWiGHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmXF0AKn98KB/K+rzV+kR7t/kt5yc5OkuZwhU1OC5Kk=;
 b=cJyRX1TslPkWS6G0D0K+0TbE0hc36PeS3lWFxI4NCjvkNATOtaFdccUxHMA14U+lrr6JgCNvrJASdHkwaLqvwLqaJpfzgU4taC4Kag4lZ7XjkCuDbctbDVBLCpr2N5I/3B4QU8Xu9cj5aOLeU+bStwrNAYSL0OtWl6Lj6mAfW7y7HZWTzhjCbsigVGyadJT9PLZqyAom6n7BPxXqO5MoalBy+ivywPpz+T5HRQ2swLGIb6nSR9FmqOKp26An6qi3WLpDE+bfCiS+htCP74a5AAYSUcsqpYo+HYMtTa1iYQe+rkQjeAPp+0gyRu/usHXHRB3TTyIvgeiDEb6S/w87nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmXF0AKn98KB/K+rzV+kR7t/kt5yc5OkuZwhU1OC5Kk=;
 b=o6DFgLGoqdmyWFO9TW2Puc40BoA4GVeK9ENxtlQkU5Oq0FwWIXfEtxTvidZHtVtLHAPcfoW3PW79mFOCiNXfJFjXLeoCUPOh+nHB+GEOKSP/6saYP50zh8+CUXQxLtvD0gKp7p3h/9ZStE4NfhB2SUme5bN/CEhxD43jFge02GM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 17:37:56 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 17:37:56 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: drop extraneous hw_status update
Date: Tue, 16 Mar 2021 13:37:39 -0400
Message-Id: <20210316173739.229594-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL0PR02CA0134.namprd02.prod.outlook.com
 (2603:10b6:208:35::39) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL0PR02CA0134.namprd02.prod.outlook.com (2603:10b6:208:35::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 17:37:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f0ef0f2-1316-4689-fcfc-08d8e8a23c2d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4501D6A7E233491470D64DF9F76B9@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7JtAbpcg4n4TQKsbXb24ymYwey7tVxzq8I7F2VVtlw6lfDO7/77lC09a8GDL6nmhS/GgO8sfU6pDtREOK3ixPOG34HeBZPYL1OuAYsaUrwxoDF8rLJ3o9oonqxK3w/HGDwwRuJAr5TVRmrLhvpTYkK1xS8akhUBGd5Tl7nVeq3eksMb28/WRwcRbI8Y5y/9fVGIs6xf04tKQ/hrlK5hZQPfbaLooZrDY0zM/GIWElA+TtN9xsC1wZzs79vGBdPbA1QWTycHAz5Kx8JbV0EIEjA9e9IMAjS1oIrn68C9Etno75z1NWB3C2cy6U532aqCHlq6FUrrPzaWBjlZCl1ETae3XmNm9NsvJxbRCoV3qNfpuysqeWr3i0Mp3olX2FkvHlEDggne8aklqMTbc+t2S5AIUhqn+q7GRnIIhaV/oKKcMwXpXEohL8vwQU00Q6UoH8JpKX2cxYaiWGqHuB8a27dRX5ahD9m1+HZ2nDxKfjgPymOwsTyCoeo58m7p7BMsQIts9KbSCAWiu61L77ub4HnAFhrnlc1RuQFtGAaJzEjH5bRy+Wo8KjfAg5RaSCViHsEZ87e8Cc8syoC879sYiNu9YF1b6JuzByaN87FGElRbiJYxAco/P9LE5oTF2QIf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(26005)(6512007)(186003)(16526019)(478600001)(36756003)(2906002)(956004)(8936002)(69590400012)(1076003)(86362001)(52116002)(8676002)(6916009)(2616005)(4326008)(316002)(4744005)(66946007)(5660300002)(6506007)(66476007)(66556008)(6666004)(83380400001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GggBSTot982YDML0VUyeTJCexlWTsZyuivp+evtI/76Nl+kiDzDhdQ1zD7Qf?=
 =?us-ascii?Q?Si8F0LFNU8Ru9tBo70kbbcSo4vz2XGsWch4KrJ7T3NKW5Fv0WSD8Hjb1z7qw?=
 =?us-ascii?Q?d3LzynrVhKGNDqGV4/GladtU+La+biZa2ne57VTuDtWWwvp3iow1xgaLjMyf?=
 =?us-ascii?Q?iP2DDJbzTqb8mBMUloH+XSGh5M7xNOeb7UDYh2xvf8o2PvKkIfAsP+YlGnPg?=
 =?us-ascii?Q?fpZnQeMSpbgsg+5l3Ph1EON+GMiUXOvuBkoCia3ud/ZnbgeATD7JiZAh3IYo?=
 =?us-ascii?Q?Ow1NEaSA5zdTGBxd9A6GMCyYKczge1R+sd/jJ7VAIEQX1bsoGBvCFwoKBAYl?=
 =?us-ascii?Q?/uoEaZW1kFNnttvfUXDhvL32BMDL+SIvxeBsgZ4aBmXgod8NqOBT9KPV4lvn?=
 =?us-ascii?Q?CRHf+gXMQMDsgUMPIgHdLt2aqh34eLTwX2kEzA0NNZ4Fo7pjGZZFqxFuqnU5?=
 =?us-ascii?Q?B3H6WAfovG8OdIXDWkPVkYXH4p2IrfMsoniVnwiUNzuahBmFfAHFB1S2ESyt?=
 =?us-ascii?Q?hWepA9MWU8volBEDyTyggHow1hQG2kWCW4p8FwxqB+0u4LsFpgFRyr5tyXC9?=
 =?us-ascii?Q?hmV17Grm0orkpYww/q8LdT8fNKToasHZteR+ZxrdViTFR4eAdzEZuSIhiXJW?=
 =?us-ascii?Q?0h0rQ/t4P3vBBCiEGg2FSbmLkrmwAp23n48a9mnsv6hh1i1x2UhZILZDwkIW?=
 =?us-ascii?Q?xs8xQjGbZKuXzmhDlwhDmgi7efrxpEqqLhRTbvlzLY7qWt6TNDfg57zE8swK?=
 =?us-ascii?Q?DhPWOWntNKtIG0Gpe1ZUnrEg/nsig7OlktwlAruiAxh+J/4K/5puHzYYVdjk?=
 =?us-ascii?Q?OOZfoLwpGO26twmeiauMm1aUSw74rC8LQNs/s5JVQFWQSzBsxtVCd2tJs9FN?=
 =?us-ascii?Q?eOh9nkMv+iUsyq5RH3c+O08Ow3GWMvaheFaBCDnC9frxNQH73qawj7eatSx1?=
 =?us-ascii?Q?4NQYd2cgpYFQa8AScvX/3Mv6H1uG98UfOMlw8ebUFxPwcR6UjcS2MwM6AhyD?=
 =?us-ascii?Q?yD/183aPH0yyc9WGrww3qFna1kDW7C+ovUF7MzsuhhWM8z9U2lZy0xxJO4c3?=
 =?us-ascii?Q?5jmuOvAqsOCZyKJDZjU2tfiFnpDeZ7fTjWJRdg8L1ltAueeXWycRYurCBvf3?=
 =?us-ascii?Q?p547iwEMTLKrplvviSjcNYsfDx390Tc2W0Vj7t1k/pjXf/eIAQ4Lt+1VVmtY?=
 =?us-ascii?Q?2/72kTvFv92b4RQ+WT1+oG5dTz77FGjfeRw0miY5zQwlSob5OusUrS+rrhFi?=
 =?us-ascii?Q?nPXPwTxOKGCX/djmAOR9HRm93brQijV+8gt4pzHZuKOmj7i3mepwEguBOOlv?=
 =?us-ascii?Q?Qo0Mzx/JLC3/dwXpfoCDelcu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0ef0f2-1316-4689-fcfc-08d8e8a23c2d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 17:37:56.7068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMgTNf64QOxrdIPUK6l6YNEiZeLuDGNXr6cQR5CpRCsOHwma+0TtZuHeBJW8jbUS6ne0CoUgruR+MH8kg8eD2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
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

We set the same variable a few lines above.  Drop the duplicate
setting.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bca4b5aa6407..7aa95eddd521 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2739,7 +2739,6 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 				}
 			}
 		}
-		adev->ip_blocks[i].status.hw = false;
 	}
 
 	return 0;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

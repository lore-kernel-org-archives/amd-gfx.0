Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27F2C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 23:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9326B61601
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 23:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9326B61601
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA896E972;
	Mon, 10 May 2021 23:35:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69F46E972
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 23:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRSg8ydRft4z2/1wPpcyw1zeLvY0MqdxE4y0mpWOtFVW4UdaVzHWDQDnW39RikcIBF3kSSfcSlFw0095uj3rvdylVSu90J0iN0vyOE8HIJGKj6HG+LgrAadX/O74tCh7JlvVxNTa98+l8GdR4DvL00HICrzOqtJZPxF6CYjdsL6DjJHOQ+fOlzb6bLqIGpD1maW0fPD9cuD4jAJFRZNFjtTETZShg6QDrNDRwklAbynsiSJNSAAtgMvaV1y02ePK9jbgl4p47X4XgLXK4n5S7Is1ovgEZ1Epw86r0fapieboxXIECpZlasNiAxnARtvEeGvybYNDPCx3vvKHBv2kzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+qxQeGaznJoGh+BOb1n+zq+KAhLaYbTXSDT+yI7gYI=;
 b=a56wQcmsMd1bbB27U7iJ0+w/wCCj/JGTQNCeAoJM+OgiCTOpJQknZLOIye9CNRWVhdvkCUyeIVnzelSnFBAzhQPo50PInAF2XF8Wr6Nn9c0BEPL1dtLg7/yabOxhLJV8oknHkcoRlid8JYcaMp0uduyLH0EWy/oxdFA5ou4n6p89JvpfAcltIjt5P3Kq2Jz5ODEeQXBS2hkH3mL/z7eDMOOFXoQnS6K7AHg99ndhDWOI8kmETYEqQz7dA5ckAIRvz0aGAKl6h/DnKTe3HNOJZTe8YIlJXpPzG9OXHHLwF+eRS3A1AQ53VJpzzOcXmjJ4uzSrLKGnigsIB/jERQjMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+qxQeGaznJoGh+BOb1n+zq+KAhLaYbTXSDT+yI7gYI=;
 b=Y4rcUjpPqCsxvwJ6kOlDGAIpXGMIDTkCSHKFDuNw8SRMxLh/mM/egCBN5XGm7fnGglDYOUZir4Mqocaga0VZxLPMYegWhXDHv5qzzlduA5p6uYLECguZvbGkXMFLENO/4viNYPYBSsskGW98U3w8NCrE8KoPQjkxFW3sIvq99Ik=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 23:35:52 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 23:35:52 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] Use MTYPE_NC for coarse-grain remote memory
Date: Mon, 10 May 2021 19:35:26 -0400
Message-Id: <20210510233528.1633-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::39) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Mon, 10 May 2021 23:35:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4460e4c8-c50f-4b59-8382-08d9140c5945
X-MS-TrafficTypeDiagnostic: BN9PR12MB5050:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB505084AA2DF7A84C5BEDC91992549@BN9PR12MB5050.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJPMxsOfEfUbFsCahGDaBw2ANP5CKDF44aMvTH3EZkM4hKx31wcW4HyB4mv5NGSX1tIAREyQ5CbjXPiA2SOL6XgYuRKM9E/UAcBObMq0GNe/gL1lC4buRDAK4k/eehx7nvBRZ6X914ZCkgZAxIXN40Im+iWpVPRg2A0fJVM0B7N7pf3E0SXBIvUCP8xvZc91+LB451zyTqIdKCPahEAe5bBHh8JV2bxeE4AJD6/bI5jsS+Qb+Ce0HBzBqreESjvcuqciO67J4qjuc0z4RwONeVOYLr6O45ynS80A0ZBjKYDPbrd0H7ZKfb75JiqIwzdsEdAVvevd9Ssz/uk/q2JQZMam4cQszKsJ7lL4+v+2KuZSEUhPIEK1xbfQdZuZ+P4lre8ls1kXn7MjFPxOR/80cxHI9gGY9oxBOydEHvVwPZDK2sreBz14eKZhMJSNC7DDGYGR9XtNqdd/N3OtLEvC9K64hIiQ1OTVgMtbLMjBxxgXSemPqr0UQnwidxu6+lObspL6Kt60e6naRXl4VMYbUjh3g18/XFxDiMwn2FTUh+oSIC+PMlGLD7epgMBoCgnpqyVy2kM7yTGBsikZyG7SmNU2EdtKWqbkuzm3Rld+itRWjEcYE8ykQgg1WKuOFsCNlu6j1xhZeajP1ggpndYOgJzCs9xuuaFq41z08tGiXcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(52116002)(8676002)(7696005)(66946007)(956004)(26005)(66476007)(83380400001)(478600001)(5660300002)(2906002)(1076003)(36756003)(8936002)(6916009)(2616005)(38100700002)(316002)(38350700002)(6486002)(4744005)(86362001)(4326008)(6666004)(186003)(16526019)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jn8hx9MaGL8aAJAshtvKzEhpum6K3Mv2c5WLOo1zj7OU4nuIWThBAdFo4yEG?=
 =?us-ascii?Q?h4mxIdF1CCNxy0CFoE9Ujr2o7Z/n7ZX+GQCwZ8fV10TT0xWgwzP/mvfYqAai?=
 =?us-ascii?Q?7lQVx2j5sQEfm7syZGk5X3/qhEJ02055B+nmLfB+zNhKrytNR8V+wpFM3H2b?=
 =?us-ascii?Q?3Apql5yUDAK/3pX6CxD97+Z2SQ2/zjZBIqe+tpQU0XozYaIupZzljzRr8l0w?=
 =?us-ascii?Q?aGz0ygstvLljXpQFpErXix9xMLRjzS9oZjtQFhpSZ3URvyvzJLMg7H+g4PrV?=
 =?us-ascii?Q?o3T/AiAaJp8INfeQoH0t5UBv6Aaf6sqpvhQTxrHe5fOb6mqv360veFhTHJ4F?=
 =?us-ascii?Q?f5Eyla+G0J6Q3HV/xL0ACRswwQnM/Qou0B0VASY0Y2cy3pf2SMdVhL6/tjpr?=
 =?us-ascii?Q?lPNKOjon/C5/JvzTHJGXwtHGgIMQ5CqsYrFdIf+rp8gktgedAfskPqFH5Uqg?=
 =?us-ascii?Q?jJIMp27w5DmEfgjuW6LrP/E5R/F+nbVWPfMiWqYx76a6T8LqX4ftpYWxsdP5?=
 =?us-ascii?Q?BpOajSGyCjBRZ7oiH7y+OZUfJxc3YIk92gDleNYV7AeCom2Wpi1rm6BWhKdF?=
 =?us-ascii?Q?Dr/Vl6BybBu1/NakMsPbIGf+k8y7cBvYVcS7FFxHAaeKuEyibkTIIazmFUoC?=
 =?us-ascii?Q?AiHT7YWyKC8nXyFkGxzv98b+q7H/5R3M7FMkKc5wuAfn0ayxXO1qzgXzHMNa?=
 =?us-ascii?Q?ylJVwgI9pUvYd4IIJ6Zv29m06cV+9Il5mBcv5gO7wORZ/0e58z9AqA200inv?=
 =?us-ascii?Q?LAZMVG60UWGqn5f8mGbefzMMXG/0b1aM+EYwZ5GtSGzNHUe8M2pM1aiF0gFv?=
 =?us-ascii?Q?bZGanEUK4PnIEZVi7wFHTLJqGPl531J7hvW5w+aYP94xo0rlETNZk6snJX1A?=
 =?us-ascii?Q?POoXjXUu/+YEOelS3xAexjIS3en9EvWWo3vmoh0TqmVK58SzqZnyypHsWMS/?=
 =?us-ascii?Q?GccJAasS+GKpdtcsV+EfqeSP+lyb6QhCQm9k/rH9Wr/RWXiJHRr4b5EOGFSe?=
 =?us-ascii?Q?+r/ZoiFctb99sKvGRzIbtSTZexj0bfyyk6FKyLKzUqjAlB7wgGKQ9542jB5O?=
 =?us-ascii?Q?aEFpiJ+NV8i5lf8LxaGEFOxtlaVhK0n9i53DZhXE04N5ePIV9yX0P//J7Yx0?=
 =?us-ascii?Q?x7IW6FxAo05iTA54LqAK9/2lOXNvsnpnjAQE5Zur+oVo2WXyJoomEaC5xjSd?=
 =?us-ascii?Q?+cN0+utNHMh52MDt2lrHYe/BLh2vg6Vh+o66+HHDt+b4/1Ap0ModFEgNqgMz?=
 =?us-ascii?Q?AeDKRPDmFaFCvtDFZLAQ3Qn6zOvO1IrZ7O8GwH5UHkDzAzNIpky0xo5W/AlK?=
 =?us-ascii?Q?nAd8lxgPXMm19Z7YJHD5CQmG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4460e4c8-c50f-4b59-8382-08d9140c5945
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 23:35:52.1826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns5+u7rpv5IvAmQjDzmfyD1vlhMe5WkhHzl1dFGhXgli8LRfNyNSRf1kDxi1mB21bD9M+18UjLyZISg8WAY5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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
Cc: joseph.greathouse@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These patches are the result of deliberations with multiple AMD SW and HW
teams with the goal of improving Aldebaran performance and harmonizing the
Arcturus implementation with it.

Felix Kuehling (2):
  drm/amdgpu: Arcturus: MTYPE_NC for coarse-grain remote memory
  drm/amdgpu: Albebaran: MTYPE_NC for coarse-grain remote memory

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

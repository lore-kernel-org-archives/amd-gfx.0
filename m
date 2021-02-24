Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE96C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B3764E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B3764E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268016EB47;
	Wed, 24 Feb 2021 22:20:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF606EB47
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WToz1ZHtKBRldqvR1syZbJHPl9Oe48TN6sKlM6EqJnkYKex8LDH/TazQN7h9UVqmMQFh3O59AJ3NfakjmIgHMN6BAF92g9e/wNq2kLf29lj5UbrV44I8udu+0SaNDCfDtakE6698TgZulkESwq5JMAjN3tjrZid2qug4Vb65BU8XkPPpCn0NjIzrGpf9KSq0bPtkKnJDfM1/qQ++tTPK+C30m/6LB6M1cPJ+nLyBnBIH3FJymzZJuSVx6wJ7nRjNCZ8Fdw052Rkv+AgWCjghqB+93tuLI7ssu0cHK+/z9QOU/qlqXDLD3TXMMMF0oHjQ8HHYVX0mhbSEuwpyKi1JKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLtyOUC+fltITHJdEy2RLtCVOF5UflHBqfGQZejzL54=;
 b=cDNg57ZOeusOF9VFHdjS/am5zCJxeQ1bwmGEztbcQlukkD+xSaaBosApe6R/ABX4kbLCQ/2LV3QjYt1Psnn928YfIl3HDyL8QpPjVB7zw1BTtXe9vnkRvIfuZFsXGdxnUixS2Ivcm6rJA7zQOyhGwBTqr5RVAx5zwfwHY61HK1Gd9oAX0S99npJvvRxrKrcwJ1hj0bs0HfKl0QmxNY5ALUJwDhihlNImyqRVOHJ5m1t+dxYHw3i7TtVUIOQMNYChk6CcFqQophyn4Sziv7XC5E24+T7hPfBANMCjUmgNUwIKTeIrLgU+oWvF/9l2MrbdX/1oKn3LHmvXaM5Ln/tRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLtyOUC+fltITHJdEy2RLtCVOF5UflHBqfGQZejzL54=;
 b=J+Jvi+G4NRh40o5KIr7t9XUYnyMhyQbWPmJBz0yukYS14UgZoP+cGF96bIJLlMy2RmMKCrMJ9F/8O2Wu+rs46JFK3UgMrXtJivjqo3BbHoLEhV8pD/Po1oK57/yWyOOLVp0g4wzHTASV4GrEdIYu8Nzp2u+/zpjXuEroCVP/GHk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:20:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:29 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 067/159] drm/amdgpu: Add DID for aldebaran
Date: Wed, 24 Feb 2021 17:17:27 -0500
Message-Id: <20210224221859.3068810-60-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ece20e9b-dd7d-4f85-8120-08d8d91256e9
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4865CF7B98CC5962C67A6D9DF79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxwcEoHavV3zCOaOSKJhAn4/zaFHsxgRoRWE9sXVUn2WpC63U6dJAc4tkmrsvDOiIYP1VvxJ1v6CBMteD8/dIQUFz8uNCX2z24p3jNN27/ltB9PAd5ZkJvy+GKLLQRlXrqVkr6izrNVs8bfvHCr3pw29ujCwh2EM1L3z5G873tmOaWz6q0D9K+ocv5Y0sf6cPJu2ViUWzurFZKYXh6xCBuQnOBXErSqKPjZs7wvvHBe8TEWQBH3fY8m2tBo/M+BXbh3z8H9jzCzOUZuJLbkBZ3Ez6qmOcOafpZ31/8cnXvVKGTbzc6BqH2C39abF3ByM+el5/aZe34LUdR3yU8BvkUXstUHjxMNlUX9DYWqcFEwcG+yJCfok7JafNbPOeFAEELgk0emJ1y85jXQimkt0IFsX+S8MpdugbEO3jvP8wCmMnpFnfRtbMOp+W9khrw/bTumurLk71KDC4ghVua+UPhKJgmCHecRo7hcQHV/Qpi/X04m7/GW1NC8fitGHPOrhmxToim+p2j3LDRZCKa3jUe5bb0otQCz/FxeHSE9MRMoe8cttge61mXWJiWhY5cdKPLQpFPsvC2yvN1tvgGBcvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(4744005)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c5wu+W2u9O0O4zqXwSQJJhsnyCj41Gn+cIuMF3LbstJ0JcggqwyNSA8Lh4tx?=
 =?us-ascii?Q?HMnDqPjqB3RjcbB9c8k9e0D8I4rZnBnTWsHM2cLZpuaQmyh+/w0GDMvZNHbq?=
 =?us-ascii?Q?HIU+FiRboWwYkEYD2zb4dRhKB6AEgeS6o2agzAL40ariVBEdTXw9i/2LTOu0?=
 =?us-ascii?Q?2m2ON/fuD7tJBMtU1XF7FWK89FmfVdJOMVqhcfLSW7vfXgUbKEwnqMioZ7lu?=
 =?us-ascii?Q?nTvx5+R54h9jdLguBFJStabNqe9+Vg5xKWtOjhDW/c0weXoT7htNjWmP6Fg2?=
 =?us-ascii?Q?sBjK339L6hhk52VBD94Z5Leut0hmiXTjrFShXmEQYC55acZ4oQZXSSK3rgTH?=
 =?us-ascii?Q?iwKbIgVJYRe4W08gdqrlSA6jyfNUE1IQDl7nkls2KY2y9VdrUAqoWXCRxk/G?=
 =?us-ascii?Q?/SSir/OdDU7/EF5kgCExy91tiZh3WeNVbjO44DHBBtO0LLSjoku3jUURGlBt?=
 =?us-ascii?Q?hfDndjRCDKUN5RlNjzsCgZYTB6WqhTPWHZ2H2IEOrdqii16HiPp4kioqYZNI?=
 =?us-ascii?Q?JCiG5ElS6JrPCbzNipW2QOfojcYr/F/q39vIgpnKbAkJ+t1s1eVP+uiEEtsU?=
 =?us-ascii?Q?TII6J3c+v31b2uxQeF07h+G81lcG0mKgsN/424pv285+L2tmULXKxqqlf898?=
 =?us-ascii?Q?0P4TCtHlqPh1LT9JA+ULnicnx5bYTVZuTGBojtl4oVSpAlvYpjYt+3+jNGq3?=
 =?us-ascii?Q?ZOQhuYLglvHW7Za06V87GDG+46DUITxkZ0L0YGWzAGXoz/KAdw0LHl2vTxWZ?=
 =?us-ascii?Q?min3V9R9EBNruZt3IqADJBxVdX4S7O0vBd2ZhNBnfL9XBL/yG3mzbA3GTAhp?=
 =?us-ascii?Q?F2saNtsxnwRO0Nvjs5RxlaTWI6/Em4tlG4pnsRcduoWC3cupqG3SConePtIA?=
 =?us-ascii?Q?60s8JvobJowNEwpumEyz/CJp2C2LefiY36TMCsMyGL08x2Q4cP1JPQm/QxdS?=
 =?us-ascii?Q?VQsZTfQZopP5WcfhsOgXsVSw21WKt4+CQnXkafwY9lLFN3HPDR2UFT5Ilnqa?=
 =?us-ascii?Q?RzbEsjg3MoM24ese4rEwT8zyuXveQ9CZUc607HofvV/C6IcdeftKo4PM8EGY?=
 =?us-ascii?Q?RiPxHNqWARZTo1dWo7pXQ3tkMeUgVI2C6z1BUQSNe6dllXzlZg81BqyqzcWD?=
 =?us-ascii?Q?kF7Xdiss6UiRfsQWU0O7u0ow+v/NnXYCDR1Wi+RjNDiq32XzGSeLTjLdj+Oa?=
 =?us-ascii?Q?cVS7+RHJHHQDWz/EAT2qL+7H9yICcu9zyDOd1Ct5EdfMlezKpn6m1m9q64Vq?=
 =?us-ascii?Q?KPKMAUyk29Laf61CDpn8jYL0w5w48xR2Dlz6AuCtimdiPjMLw7ysg5V69Rak?=
 =?us-ascii?Q?FFrFa9GK1Gu9NMZRr6C2J0qC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece20e9b-dd7d-4f85-8120-08d8d91256e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:06.5539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qJWHWwxZ+KpKebds9Z8cl6KG5dHey8cTsqsHJxU4yTcbT5sLTiXuj00fTpVehwzDxpQQFH0wILfaMq4dLpKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Feifei Xu <Feifei.Xu@amd.com>

Add 0x7408,0x740C,0x740F in pciidlist.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 91acecf09964..652f3c6ed79f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1119,6 +1119,11 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73E2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 	{0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 
+	/* Aldebaran */
+	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
+	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
+	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
+
 	{0, 0, 0}
 };
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

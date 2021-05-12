Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DBDC43460
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659C161412
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659C161412
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86966E090;
	Wed, 12 May 2021 17:31:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABADA6E090
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsaomCX2QgV6sFh9Co+xyY0+WGfUY3o29brDcOSJBeXJVyWrx3U2HUrqHs0fAmRJnZk042vjAs01x+wZ+/KPaqmqgqfWxkhQT2GwTT5O4tUcEU3IYzrrRGiT99QJVsXbWb3/F3LGz2kr24m54jdhEYhsbCPD+X8NIMKyOKNrUwTXmOKZxTE17edxNnhkFdvRgohQwI1GdWMS6B4L8wa9bkDHwmoNiDk87pomky7tdsmJE/hyiuQ1+iVV3DIgJyCrL1+XoLC8I5KkSstGJI+6MLQxxpUXaAMyKjmuRQvb46hCGyGWqNOcUPBUL20E+zJSSOhHVsxB7FPPA7+DJj0a+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga6nCFrwK6Kmd8Nq6rfBXNsQV9/1Gxez8diLuooGu90=;
 b=iLCmZIXNWuzH3L5vJe0nwgwyDerXg5iKXnBnMH7rvTRN8CTl2PYfKyAIXTrsw+Wxd3rokV/GI1ay633MntkAFZRTh9n+m2UpdAlIiNp/Znc2imiDFBICosZ55OsuooA/c4rS4SYWUM8jO3O0x3QZX0VDhjEZRUnjw4fzln9XWLg5ENE02Nid7lPTG7mT9oCPIIU+RKGO1mX74o4niJ4y0J6Vi+d7vcQD8mFZHW406nqsh3ISIPUyH1GMROEspFPtrOC/ZEL5tf0V9c26bRDqs8XdFVsk38DQZdjUtuhkE5GPcvfrCTNHGYtd9Bwm6PiGprapTzBuHoW634whufEBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga6nCFrwK6Kmd8Nq6rfBXNsQV9/1Gxez8diLuooGu90=;
 b=UmTULzz7aj4lDhQxn8qg6fkl3q5TnAfIuVUdNFS4/KljdN1D48SAKtMuE4t623rJvpiC4OAMSHq3G745GAmrvuNWj2B6A44Ep+o1/YnLROBXpGGij6zhhYHl/f1nYNgG4cfBXFotWc074jkIU3SWGkytptIhEK4xKQ4vwvHUXds=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:13 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:13 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/49] drm/amd/amdgpu: add beige_goby asic type
Date: Wed, 12 May 2021 13:30:06 -0400
Message-Id: <20210512173053.2347842-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4dc8bf8-8ccb-4c50-8d1c-08d9156bbd06
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4915996FF79D6F70A0C7AE83F7529@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alI0mIvmdBVOvkZ+gEKUufUpTlzlnU+gtz1R/1L92Qo2pjIk8RDrRjn+ddmpLcOLABQG5pq1jcTwBmdwYHhrAV0vvBHHbXSuKGSWJDdObganK4pnuMbTajcK8WVHEkFY735Yk8SSNUEr/9Sl/SL6tCbwxXnL1n63fY72foeR79AvIof9gAW+x2a56OPNW+cz3JNlDPAk5qlTpOwMi0vbeqM/xpcXS0WG6TMoJpTitnmwLQE3zrH+RkNHGjEXRanKA2KjcaZMDB2Y/pba7YB3t4n049rvrgYv496LfbRyrlwJje5TAJUTZSjB8W4yUodbVweyDDz7sqqKuCfhrWD4jHvtT4pRLiAZCeB2kYjDTFU2ee1n4DpA954LEYNUkzajwX5+EV7RzaKCVYJKU7Qo5jb8iS96ueuBB5hkZEGc09zqxQvbG79WQx0XPBpkB8iVb20JAd7bB5Gmp6yJtAyIeT4gkylj2P2XaPbZFhqEQn3hi3EtIlTsDYuYbjNmDGFTybAZG3wsROzKf9hirQCf4p2kWtCWpULAaW03g99F0z1T7omk27vNdYmNlxGzOIZHYLujV4DzfbbKYjKAsLdtEHGdRCS6yRM4Se5F9ZP5m8lvyxEpZDcclzGIYAi+8oyu8YrhbXRK1V+TdtCYkLbHuW1TV45UVV4LQh5hAbR7WhX7uaT0lcjGbrXdr8sz9xGf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(8676002)(186003)(16526019)(8936002)(54906003)(6506007)(66556008)(478600001)(52116002)(6666004)(66476007)(38100700002)(6486002)(956004)(5660300002)(6512007)(26005)(36756003)(66946007)(6916009)(2616005)(86362001)(4326008)(1076003)(2906002)(316002)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EH+tD9nNaC/aTLEp75VM3qiT0VcgenK9Osc3Wy7Wup9CFr+4EXCHDz9bNcvO?=
 =?us-ascii?Q?3herwfLa1A8CknBLd3wbIjNFAk0N0L8W2iuwAB8yKlraxsCL33OtRPU+ma8b?=
 =?us-ascii?Q?f0x0q5+cMMU6QoC27dW25FRPt8vUt+GVlB7u911MaVZE9coRXjjNEuZPyLdS?=
 =?us-ascii?Q?O1cpD1Iex4lRp8rusidY03ve4Jo/72cbvm8x/N1niHUFy3xVOMbQ44QIMXGJ?=
 =?us-ascii?Q?fNXSzF7kzqpyhrUOSM9C2Vo9vY35TcXCSO2agOL+4q6N2NUuDmVHuLxUqjwv?=
 =?us-ascii?Q?S0IzCr+gBG3yWnWuOl2Lq4v9wvVooo2Ndo/8ISCyoYR4tvRQj0gd7R5ZbUh4?=
 =?us-ascii?Q?ka4460XonLjZz7vcupyXMKqypHhV4KYdkQ1drWluN4u+eQo6MVi4N16QKbx1?=
 =?us-ascii?Q?Ug/unax6naET/gW8+so4aMhlvtPMNBobeJ89U/JkpQXTmuD9LpH9p0jOUG+s?=
 =?us-ascii?Q?qWhjDwA9qXKUDES63Ig9zrQ7DXluivr6c/nke8lkJ28YC05EOuWE9svrvoIm?=
 =?us-ascii?Q?AA6vw208Y5Cnp7fr1LQl/uJ0aoE8RcCgMfQPCyCSjkH7RND6uB+vszKxFWkh?=
 =?us-ascii?Q?Red/sgGwbvEjiXRcggmZqqHBzo+CoOLoGUQavXebQodrUBaA8xNqVrOT7KAU?=
 =?us-ascii?Q?iuq2pO3HEljpt4tzCVfunFEerJyaZFtK3GvVRzEjWFYs5mpYPkTgLLCpTMqm?=
 =?us-ascii?Q?UzVOWNre3L1kygKnVl9gzbhH7N5W8uzFAIvBYWCQwY/Llw/4UtRli9AZOx80?=
 =?us-ascii?Q?1F7ZecDN6Gcq4744Z5YavUcUaIUjeg3DHoL2T6sDmekQ1PWXn8JIcUpLLAbp?=
 =?us-ascii?Q?C7aIctjaomHaPwy8zhFGNc8uU3JvdfR3v1vB8uPnjI8qX6/tDZYJL7s2Z5wN?=
 =?us-ascii?Q?1bJc4TYsIOmiovTV0NvAEAiUKFK2Wg8cSSUKzfLyd6hEto2AP5eGwmEkJ3+U?=
 =?us-ascii?Q?U/GG/fKmECLhjeQm4lpjSqGupbN5sIxwlRlf+o26IsCB/I8dE4gEH/ACHp9f?=
 =?us-ascii?Q?cy5nKhKwIRrHBFms6f36yY4EiKDBMOmUz7p86iT5IF8U91un5KcLgp6qPAQB?=
 =?us-ascii?Q?ykm9Vhii8hPUyERSQGiV5mzbPf84o3SGstFKHCqLr7B/0xNKteV9wbMT4P/d?=
 =?us-ascii?Q?eBZ4syNDzl/MTCiZLqeqWnyMtj8Ws64pYtu+eIsirB10FRGHm8TqGheZvGQB?=
 =?us-ascii?Q?oPUK7hYOyhiOqQtHDDbNxGxoV0dkLTt2zn/KuV5HafzvddGSdPzvHOCjFkBB?=
 =?us-ascii?Q?P/O3mvq0GeBJJAxog5gxEAK8Qz/5JrBont50GudCWjUwBXKdZCEg2jhu0OUL?=
 =?us-ascii?Q?cqwWmWkLxtOVvTmX7XdLmE3Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dc8bf8-8ccb-4c50-8d1c-08d9156bbd06
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:12.8455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W203M+3K1/y+G58qjCjdd36s5RS15RmFeqcIHYW1AarEMRMVD/OdNo7vW7quQem2ifLuy5etPl21fW4VG+ssIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add chip type for beige_goby

v2: fix enum count (Alex)

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 include/drm/amd_asic_type.h                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 357f9405f1aa..6a19e802d386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -119,6 +119,7 @@ const char *amdgpu_asic_name[] = {
 	"NAVY_FLOUNDER",
 	"VANGOGH",
 	"DIMGREY_CAVEFISH",
+	"BEIGE_GOBY",
 	"LAST",
 };
 
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index 336e36506910..02f703ec4230 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -59,6 +59,7 @@ enum amd_asic_type {
 	CHIP_NAVY_FLOUNDER,	/* 30 */
 	CHIP_VANGOGH,	/* 31 */
 	CHIP_DIMGREY_CAVEFISH,	/* 32 */
+	CHIP_BEIGE_GOBY,	/* 33 */
 	CHIP_LAST,
 };
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

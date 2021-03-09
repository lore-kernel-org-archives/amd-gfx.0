Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D5C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D73065273
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D73065273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F776E453;
	Tue,  9 Mar 2021 04:10:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DB26E204
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 04:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWAwbEXLUQV7r+5fRGp6dKX5xpfX9kk9vOhHKzkdEvBVodq6qDOelADTQcSe6s4LDN6lrU19woih4VwI1PkwVNMeVoLAldV5T2CNIQHD0zwj7QzH5f3W1d1zrJLjp0yqycN0FkTPgVnx35K3b6VlnQC8ZY+Y0aMLI0Y7PiSoFwtQSoU34YqqmXt1+lF6VsTJCL/sM2i6aMdUbSEN5ANfwGXSYtsy4PD2+oTUc32DWjc4ZAFrUMhTc3DiI5yY7de+6ZZ2Qso3Rm2Asm2+hPqKSqJ/0S4ARn9SzeksYeU6b93ydjHsLfI8bu5IvKlALp4Vng6cQz7apxePpYrvax524A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ5JvX/RkuncYPd+cNR5ABs7dqhA1RRCPF3jBN56mvA=;
 b=XpDQotbOOuSRzLk+9VcDkZqu+cjlnMf/piMS88+DonlmRwsBLF6Rm57A7Vj/fqymVMzFMuItOs4WAEWaXrJAXRshTuINkxJ/qNs7QnVWHBWXG91bAitH6DZj48ZgGR/71RRkc3Vclw1WshUWhhC9lG+hB2WBifQHaGgq0VkykA0+3i3NZjzxslG47V7M52vcG5LBlVmuDAFRqGmvxPlZJcTJoGrtf8uDzovDRTiT7ZAIzVmI+EguwkgNlGX37H0mb9JPhEHpFugFIE+YZBuPt4pf+ipDtoPH9AonbU2Y7A/wrjVegSvh310RpdaxUhbNN2nSOJTuCOuFBMIY8HkYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ5JvX/RkuncYPd+cNR5ABs7dqhA1RRCPF3jBN56mvA=;
 b=wn91OfJ/LY2SJYE+e8gHgOUhjgHKAmiEgWzaZ4Nd71VbIPP03qHoc1Qvcu7XjhzgHWEmEL1v8tkyHsvTt0fpTDg7QnhW7acXGbRes2zpQWGJT+vRv+OK19ijTThowmt+0UUaNpC3j9nyttfFVKQbZn8sw1C9JtjS1oUYPzz+fPg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 04:10:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 04:10:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags (v2)
Date: Mon,  8 Mar 2021 23:10:07 -0500
Message-Id: <20210309041012.23367-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309041012.23367-1-alexander.deucher@amd.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Tue, 9 Mar 2021 04:10:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbb1c538-b122-42f1-c211-08d8e2b1477b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44862D462C76A4DAB0DE5FFBF7929@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1I3zjRnRMlRU22Xq8a+4sKAWddFgr+ig8NA06SiVemARuKEKLK/77EwrdHP5WAjUriQuujo5CtDCmA2J83r+W8EJycFhhc8lyO35l6Ft0fk/caw4IU7n+wYJ/osY4Ov50xp21OSADH1eKoDITJ7uPfY9mdW11+9GCUIGJzyv0ikWjClN9pwliy9iCbrorZT6i+RRcdTS9gvJedAH/k+tQ5tzcSGaZQzO3z4q+aBsqNyxLCsMMDrHS6JcMNiR9Q7IebS0yVOyXftN9MncMnh97cXkrbSrYL3dSbP0ettv20y+kpEMy48X0PcLlzbfx3zgbgHR92h8Gv5YiAjNypOSovl05BMw0TnM6XLbsFCYL3Ys0qX6HmzebtqqipQiAfwyFxnTh/LINt5wd3ttApk4VIROjR6TnpHTi5rLvweWxC3OF8KeyA/Y2n7lBw8/+47XCqC9FlgO/edn9qTuWOu5hDA/Wa79LXusg4OEUYJp2T/1rIJySekLekdQF/TFOysQ0R8V/7YWHid5PXmrmFjRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(478600001)(316002)(66476007)(5660300002)(16526019)(6916009)(8936002)(54906003)(26005)(83380400001)(2616005)(8676002)(186003)(36756003)(66556008)(66946007)(956004)(86362001)(2906002)(4326008)(6486002)(1076003)(6666004)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xqAisVR9HJhdvtQIBMUuIw3lw6gaLeM2wq88Pv/M4LrBbW2Y1zsCdVLvs7jt?=
 =?us-ascii?Q?Nf+KFKMfmsRWWDpzzaBn51T1IYOi/fUhMt6ON/JHaLscHH1ZsJAtBO698j2f?=
 =?us-ascii?Q?Z19p46rH7rJK/q0MigOSpo7jATtlrhBZS7yDC1u95jec0e9qv745We2e/D8c?=
 =?us-ascii?Q?a27SDUhhho28VANht6Lt22TYjMHWVY6LAX5KksiYZVp0KTcFUFJpcevGi2tl?=
 =?us-ascii?Q?M/5Wi4B3dhQbM1JPrgV6h8ual0i64rTjz4lJ2L4kxkvNEHQNEZWImX20WXdh?=
 =?us-ascii?Q?vH8/7dJwFcBjAOcd+DxjpipynYaoq2mlojJWuh1prHXkHXNHA02rLZtUMWO7?=
 =?us-ascii?Q?xS9oxIUaG2/fYIt9B9/s+iJ8iC6QIckTwESDJ2M1cIXiynUW2dsOAg/nY+Kh?=
 =?us-ascii?Q?eGH1ZbL2rEwGSnvIbm9ggPhbeM4ox7Y/ZlRXMdc/SbgUnchMDw5o4TAuyN91?=
 =?us-ascii?Q?Jm1SmkF3UBOkVXSVzKx6HkK7YPumdUDJKR8mtPG65XSo83zA1EvU+TmlJoie?=
 =?us-ascii?Q?P7oRvjlnO4tqO8R46JLhp6T3DJG45LkxWsLEYT17wZBL6M4NRfEDE4rsbMZn?=
 =?us-ascii?Q?zfoiZwaF7n6DS5IP6EdAEWJ8Fwu2Siwx8rPg1ZjPOD1r+ZuVrTRvovtaE52R?=
 =?us-ascii?Q?BIJG/23KNt1RC/6TAg/dJYcuKEEisBf7fRHdAyDQfoNf3ymg+2a1vlLf4eqO?=
 =?us-ascii?Q?8ewc6sbKZ3r0Ef6xlpCImMqc56AYwkw86MQQ34BywViLFTsB3NcybCl0BcVa?=
 =?us-ascii?Q?d59VugCWTYJkxeIvjGQbt21AVtbYI9J9gsWE9M3B98OpeqJwfB+MAFds1gUQ?=
 =?us-ascii?Q?zOEkFWXy9UtHzQ9mcNBdTyfbp8rj/3x0SuLblDaFK7iJeW6bJYfXjhIFUjFk?=
 =?us-ascii?Q?9x6mzVR1C/qOM8Ktz8lmNZ2sMkXyYXgGESz/ji0vimH2cITpOjPnI+S7HNyY?=
 =?us-ascii?Q?2nMqKXqGmchWGivt0JAPVN4948DacSZWdCJJcpfwO9Ljb3NXV+4tZnt2cRG7?=
 =?us-ascii?Q?7p6PQKUlNtc+UWzlzuUSzwE6o2FeT3H2Lq/71dpbIg67AEWK5p00PLeAInBY?=
 =?us-ascii?Q?sfanravJ02qqYo0srtz0kjF5UekYuuwFw5N+aPhDATscDds2mtokOfBQebi3?=
 =?us-ascii?Q?WkMi5PWpc6beZkW5aHqu3CQiZFKLA/vycSrO7WQ/42tq3GFr2RpppJkkNzZf?=
 =?us-ascii?Q?J6ZaYOKgkMd0W9fZnBgzm6FkYCTxDwpZ/kDRYce3fK/0UcYOHiSS1yihkGto?=
 =?us-ascii?Q?xnrKAvPIl2+qr6AHw68ACr2dKZPQJmXGH3VBQwOZBpsKn2X2JjJ5BSNJcyHL?=
 =?us-ascii?Q?CryQ4qy3GTTfBNLdpZcwlo4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb1c538-b122-42f1-c211-08d8e2b1477b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 04:10:31.1885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pOC1lzyoHCLJkLN3gnfvyKHA+FZUtMtwXHFoSJVravnFYhYLYDP1Ngo7YAuN2iQEoH5HgxdvJ3LCydttK/rxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Once the device has runtime suspended, we don't need to power it
back up again for system suspend.  Likewise for resume, we don't
to power up the device again on resume only to power it back off
again via runtime pm because it's still idle.

v2: add DPM_FLAG_SMART_PREPARE as well

Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f269267a96d3..8e6ef4d8b7ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -205,6 +205,13 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		if (amdgpu_device_supports_atpx(dev) &&
 		    !amdgpu_is_atpx_hybrid())
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+		/* we want direct complete for BOCO */
+		if ((amdgpu_device_supports_atpx(dev) &&
+		    amdgpu_is_atpx_hybrid()) ||
+		    amdgpu_device_supports_boco(dev))
+			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_PREPARE |
+						DPM_FLAG_SMART_SUSPEND |
+						DPM_FLAG_MAY_SKIP_RESUME);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 		pm_runtime_allow(dev->dev);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

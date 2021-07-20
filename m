Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F08C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3BE61029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3BE61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79796E42F;
	Tue, 20 Jul 2021 15:44:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3D66E438
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPupwYrF/wsqVpioctJp0/63rw5xLgpT9q8QoUSTXcuSw22ah5qfUifmTEcCDzZRtpVF6muej7pcrc1GapuCgeYXi3Ya43IEFeJIkyV9JoN3ODBuE5q6Fc4cao4qYFc6sMGwxQNSY2FeC3YWPFqYRXZe60ZwbKkH/PUxg5yLYexptENi69w14NEkpEZ52aU8xMz/msYHSunTrqMLTByINTe4hqPaxGQ/M9I23AmjN9oIcqTEX5V99nmWP0DpW+8CiEo60AFiu0oxqP0486CfRH6QqoQ1K8CkZlkJnpYzgUbnEDYorCO11GUXbwOFqK5K+JM7izR3z5CZDT5zn2i4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syDRLrii7P9uDPr3NJ/pN1/desaIhYNI2AcCYiuvzO4=;
 b=C1/wpRzNcNpikjOeIJa7kZb7J9nhI/cURhK3thyzjMLWq+vkxaeMX6DX/fP3dd03TTRz5sD5RkfUNmkIXBu5Yvmvx6SlgGr5hy+VKqZ5vFPoECMY/zqs3bGrlG4OART1lTt93llDUG1YG0Ccpn3P9UDDiQ1RwGL0ovIw6nPFhREzNkq58TovKytCxwPTIICb7n/DJCXfr0oXEfd/gAmnNcBwwF3v5lfOtK9oIy5qGEooW4Tf6ce3BfPoC5DGvugQK9t6PGfUqqc0Wbl4ztjSQB45+kkgS5SA3MRueDTb3Pjegq5T9I/Mp1eUKLgJMknncnXfjRjMBI5h/XQLSW6mGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syDRLrii7P9uDPr3NJ/pN1/desaIhYNI2AcCYiuvzO4=;
 b=J3CZUVOjKz4OOsnfKg3cjDCJB0xlIuRthKeXq+Mh9W81S42HZ8fDC3EhP7d+4np4SnwDK7Q9MznEWwMnxfLN0wQrLAraE7oZ677Fy9gpjGfbhGXG9bc11EhMckJZ06/LI9TR6ysl9WTM9q24ahLCvKOzjawBN6dUgx6LzijkIrw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 15:44:17 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:17 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/29] drm/amdgpu: add chip early init for cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:35 -0400
Message-Id: <20210720154349.1599827-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d32ee392-b472-432b-ca9b-08d94b953b95
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53493CE5CDE78CB733EDF9BBF7E29@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLdktlD0L8wkwsxDy6hrpeUwYH5ELHyS/XgcSBV1AwMBvFPzIEwyo1MhjmFBzCAniokqGyx9/QWA9pcRw6QIxRfpXk6kGSvhfrOjE2g3yYb24vl/Ya/H/1EBrCcVgg+eyqF318laP3mK6yOAcmWp/mWblqhytQ1OZc5t8sIEz8q3ZtI7AhvXpITbklMVVGO44N4s8w1NXLUd3aq3Ga57MZDFemQQ+oCR/XbMcIGhr5uHBD1nQ8dOIYrfXQNGFJm/wguiH/RZrLwZIkufK+MjhsobciE8iJ3/S3PDAqAJzdVZszu2xL56BqJs+wmdtUpZahi7QCckM+ZLe5TyDJAK4L1wz2BdcvAUPGdbA3guI80KKxBkC+kX+AGJIw/WQ9l2RAbkfQ1XHufyBrubM1pN+UUipM+xM6KxpCd9kxLNlUV7Us9Azan0xYu2QqyxYXXJ1TkdUmxVYQ02ElpLnd7GOJPf1aQDZ81Ig5dNTGescMbg2lSJwbfhFA4z4x1tuUsJFIwcfSidQ7EvOK7Qt7ni7DcKGdx+DBEtrPDSnjpQnClWXy65BMMweWjTcnbh6pYAnVwkf7w3/wZlpdpkb5h2ju4K9HyXVk29808N2P4ShU26Jx04qd6/mLaGamMTsZBaRv41mscCwUMrJn/KPDaPOzXaKePQsb0S4twtH3jzszGsXeNFOnPxLCNh8UYnfVCz2u3yP531l4NWFftERb5hIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2616005)(86362001)(6916009)(38100700002)(6486002)(54906003)(6666004)(4744005)(956004)(478600001)(316002)(1076003)(4326008)(52116002)(2906002)(66946007)(38350700002)(66476007)(5660300002)(8936002)(36756003)(7696005)(66556008)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xrD9QdGNd3f7ieffUd5CHZpdwSk5whYXaMV1K3MCM2dPm0g25BlHS4BYifEC?=
 =?us-ascii?Q?KFlLVXSNidyrretFy0k3/GzwRaLXbuE3E44kl66uSfpl7PSVyc13gNNpQta4?=
 =?us-ascii?Q?US8Mpm3CVdlkqtlP+whYiNFI3rN32QeFkbedTsyMDLi28DVNCmt+DaGpqhlI?=
 =?us-ascii?Q?GgaRuxM/H4x6sozM4s5TF6f6vqnsE967EJ3XsfSOBl8ZJdH0PkEl9Qu4BiXK?=
 =?us-ascii?Q?0m3Cuvhv9mpYClDRY1aDDmk48AQ4FJdt6eG0AxQhCE+6tdeYQ/+evRikpoeN?=
 =?us-ascii?Q?uFHOMKguPeCLQMLkErgGMV08yWmnDLIaggT3OfRN6bMe68zrNDWk4DlBDwmG?=
 =?us-ascii?Q?AFWBbX7nWY0EyN1o2sDEW4qOHaqCUZs5zV4ccQRqHGUlxYyQXSDVFurhfUaT?=
 =?us-ascii?Q?FJ/GcTRbCCpgFwkVOQyjRV2uUBwi47syJmDtjN95Exas+Kt3JSnc3HJG1NOr?=
 =?us-ascii?Q?tevDfp1DHdWBvk7MliOPVeuK6MF3YqRFTzofVEnvIOLeUh6PB3NH9wQ40CNq?=
 =?us-ascii?Q?/ZM18gvcsyQzhK3AQXdLP9jRCPDQYtXavuL8jRHAAXKCKDXx8ZsqgjEChDb1?=
 =?us-ascii?Q?iINyTa0keeCO7mj3rrZN27mP6B2P7n7cpjpE4YtbwfARotV+q+LaniCO5pyl?=
 =?us-ascii?Q?E5fTiFlcgI7g+vrgPsnWhZ9kEEIxCHsC8mA8BORkIWENbzXBGvXfQTEmOstp?=
 =?us-ascii?Q?XU9Tk3nNQK/lVFgJIC03Em/X20eWY8dZIeK0imYNDdAC6N/s5SO040Y0jOjg?=
 =?us-ascii?Q?L9d6AvayTvRmmAiBjrL+mAgzOvkX2qC9A9dHwJF8D06Ck1flPA2tp7TjmwPa?=
 =?us-ascii?Q?/QTK02zMG1Bhf/Rf442a2AxJrNB+v+9p4F5zad3NbcuJiwGs2LF9AEEz6rmR?=
 =?us-ascii?Q?yJCnOBrq2PX/Yrd4MPVTHB0BLHyImVPqvgJo3mDT1O5e5VsqfVvHvwnvDmtr?=
 =?us-ascii?Q?qp5/jWS+vk6l20oP4gbSA1BFwNUoMMGmD5In/9VKUyjP9ezoE0nGF7keJ5m5?=
 =?us-ascii?Q?YJeKzKmphgU7tuNOtD224BBGG5MHe4bNW6SkEk5SfiZLU5dlY+8sh5+Us1Uz?=
 =?us-ascii?Q?YG2aMkS5RW3GD0bqLMQJ0XIg/NWZYCznK3i0+4Bh2eR1jkyJy6PIGXUVffXV?=
 =?us-ascii?Q?Vwu5kU9zIGghKFaGUPwCJPu3v6MxqdK81SH/7k+xusDSsuJQ+iI3yPFTJNTM?=
 =?us-ascii?Q?8GnM9RR88VhbSblqydUo7RAwrrGUUFkmevrG5/AAN4qNb0+HT3dh2MTMbwbh?=
 =?us-ascii?Q?i7a8TxKBhC8/b4rchaSVFiL05gQedsNXdE6mzwwGuG07AFlBl1dDfiuC9MdF?=
 =?us-ascii?Q?fxJifHKITYOlT8HHhza45PNX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32ee392-b472-432b-ca9b-08d94b953b95
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:17.3609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YL4/ZNogrVkWy7SfBl4gfMwheWt6p5/7TSGQX0DQ0cPTdBaZba+bKTF+AdJ7/EwFlbmCxow5+He9UAy5hbAIGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Set cg/pg flags and rev id for cyan_skillfish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 837c101ce5d9..41eb97e7b47c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1401,6 +1401,11 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x82;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

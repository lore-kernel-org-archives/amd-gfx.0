Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40174C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 16:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30B361029
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 16:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F30B361029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B446E7D9;
	Mon,  2 Aug 2021 16:45:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A5B6E7D9
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 16:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UG1EgsVpBaXYMqqrFEKQEpoeZWWDgmqJsjBzgBYTPdvD5PCzs60FGqK0YnO2g/N26QB87tOaOdpySmp95vnySY5JQwJGlsURlwThXwxp/vT4TLsykn885jSYe2ks7e8q66Tlk1yudo0fzvHk4UtN9owI9R0tZsV15Q2TfMg2G22O6K9kOQ7oyPQVUdQNerWzFeo8Mvz6FrBJKBp6tk0z8l/ajDnQXUxTww3hkkMsmpGAGHHPe0ox/H49TiDVENaBsZVor3HjoA9JtGxYvnmhPCdAgSRAbVKkQPkfH2ejXi4IsoLIfnlXH0ytS6+gPhWo41yq3IiRqMr0DBpDn6Im9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVmW6cuy66uPgJoWRzFSmOr7BlozuKJzC8wefL2djdo=;
 b=DkqhxybTHCzqjPOv/9ph/kdKKZc9qEaeSxkazNa0N7IOh7T+F/Mb0X8q8d3V10folLN67DXSgowfcEwBoJCyfP4RFx6uw20+NdfdwQ7ttyEhZm/5TkYRwYGJdcjdrFsnxjvCyibJB+5Ws3dADvIIei2EHfpo6C2XttCfQ7vKhprysKI2berzXKTjZ+H5wRshof5iIdw1lqBq3AFE17p0t9K3xDQWJ9qmw6c93JdgK7nSwAFcXNE+JG0hUKsryA9wrUgTmFTmCxhBt1wLX4yA8Z5tentxvePoo8b+ayUt73rMtjnnNFk+oMkY5UcCac/B56/RA2XeFOErBWpvDIxevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVmW6cuy66uPgJoWRzFSmOr7BlozuKJzC8wefL2djdo=;
 b=L4HGu+DRj5e/JObZw+ba8fLDlRQTW+kwPU5BvjqeMnRCiY1lZnMoO+qqKHEyxc+hLPvSqTw6VmBscrsUuPRP70krdKlS1ITsyBQpHvnftTmGW0SQJCiwxj1BmmAkUa/7vMA9IL7kLGUR8e8xNBixDdnWNzwjPT4c/tlOIq14jeE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 16:45:50 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 16:45:50 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: don't enable baco on boco platforms in runpm
Date: Mon,  2 Aug 2021 12:45:34 -0400
Message-Id: <20210802164534.1359533-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::35) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.17 via Frontend Transport; Mon, 2 Aug 2021 16:45:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49658d46-0941-49bd-0b35-08d955d4fc02
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5159FC6839B10E1605F38EE8F7EF9@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CfswWUhJu9TVXRt9m8cgTv795hrmdc3BRYTkKS2CwkwMWlxpU3Ym+tCyh0HRhEg85vfiPFF24thoTTMXbYaDQOdUcTH5/ZxK8bBlqZpfoIxzLXv8qvpUBF4mSvbBlfKFRVqqtoG4vBiblrBcgYlne8PpqbaRhcODqMkF55fpUOy13Bh4rkiG2lgTeauuMuMbCpAet7s4Ctz15L94JcNro/eY8jwrMPN+PBiTDY9VTRtHq6gXsw7VHihgMW/rlm1z7B9uyiyk4WXMNgpf7XRRB7UD4askIRT2efs5AT7Z3ayj+W+umvuDqgzHSFWeKMsiU/NQ5d6z7fnVJn0pvOIUnLhl12QOPFHuK2DG35CQTkPrNdgXJnOlasyARpKXnLvVh/SHUIOn2wAh6SFEfHoE1WpDHymLboMc9gBJiHn9uzmK8Q1SlPePIoHDxbgmjOgUTk1KkmSzALRMSKXKs1UmWfQpC0B8nmjLiQUICocoGLvsOVuxwwsTKNcV+ZPPWVVH7bUV2geFk6g+vjuSXFAR69uuy571CkDEz2iRpLH+E/Zs44ekt1oIuw6GVUHVw05ehQixOCLvTdzoj0hLNSO/ACIDihb3jh2uC9KX5rTrd5Y5++YMNR9wbjD6bUDzo7+6TFkffEaASk0ENVr/kZKarXPyxpVHGuAofbaejYH4DCN1mNqNpWVvKYg+6z6SgpNKlGGGS8uxRafN3Vx2QQmIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(86362001)(8936002)(1076003)(66556008)(8676002)(66476007)(186003)(66946007)(83380400001)(26005)(6916009)(6666004)(6512007)(36756003)(6506007)(2906002)(316002)(38100700002)(966005)(956004)(38350700002)(2616005)(4744005)(4326008)(5660300002)(6486002)(478600001)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+hdA+o0xBFjI4FaICPTKmyQIH3KY4HDNDEGXdyWt4jS5sR/soR6wbJaguQJ?=
 =?us-ascii?Q?jR3S3UUjsGLZNITChJYenTndAm2Aj/VB9bOBxqBDkeN+zzW1bvBHXYi1h1kg?=
 =?us-ascii?Q?9Qwc9ws7ydXZfUaD/yaL7ip5j0W3JuhT+Yhr77yPyD4PNUyg/7x5SKXtGs6U?=
 =?us-ascii?Q?SlbA0YthZ8PXAJnOacYBjKHLCla82pADLPB73lgNqByM9kh7SPWx2rwttfmP?=
 =?us-ascii?Q?gJ8knyRYwlJ8IttphPi1fEqq4pWo9EpHinkO5+Y4m0OTZqKX8OL4pvZKRX7N?=
 =?us-ascii?Q?j/z13MXBcoblFYxUb1lr1WEAhVjIdXcUQq3/TKN4U0F1y6mEKl7bjItIhQ0A?=
 =?us-ascii?Q?l8f4kDCsVDqe2ZeLUJzHt6Uxr0nrcv9Rdlbs5dRVQGPGENG17Ka9Y+hpuCf+?=
 =?us-ascii?Q?JnD/fxiykQgt1jXZBtVgJ2xa2NqWpg9UUt4yArd6XEM9FQrf0W1E/yhL3gpS?=
 =?us-ascii?Q?IUmosHb27tJgI92oz433er0iDM2tYxX1hmOhmDXi8UDn5ncJzuOGOreHtHxM?=
 =?us-ascii?Q?u/2rB7hup2R3/9EpKfFRfD2qHQRd3SI1LVi+o1blkhBjRphuxHDCAux24Vor?=
 =?us-ascii?Q?fB5QscdDsx/YvUgkU5VysRtmPK1HRB+IWZFfmV000eim2zPaSY8a+4ujmkoP?=
 =?us-ascii?Q?cOYymTVpbA9difrwp/1iioQLM16+wbmSVBltXDQIxdcLqO0M0YnozTHuL904?=
 =?us-ascii?Q?A3zKWq6d74k+iFlIN5SI6tXnhfJw1Xs95bb53VfUWKKFbgyfMsE4SZ8EdxPi?=
 =?us-ascii?Q?w1/u5u6WkMCCqVhGxFMLL2e4dI8d4pOKb0V00k1p+TuxRkOws5rpaJOlXOYY?=
 =?us-ascii?Q?WtpBQZLGQz+Anc2DsTGY1bSLJrozQAZa/7aKhCvqEPscd3V4ka28KPqcWyQY?=
 =?us-ascii?Q?XW8TQxHaGEv95b6+BvwjscOjfmhKe99bk/fW6gFLbK2EzKzA2ktELsHJltyH?=
 =?us-ascii?Q?G0mFjjgc5OtnpC6lM5B4HRk04LF/oGMPemFDTVqdLlrwyKWSNtrC39p6VdOB?=
 =?us-ascii?Q?62LIsMB8GEXXiwERdp+ylTJ0esMTIfvvQysbhyX6iP7r8l1lcD3t4gqgP5tV?=
 =?us-ascii?Q?1L+uT+6MQmNTFkcNvQ7Xd9xEysYJdrB0YVhmYbuQDbswdBCjFHnmJTF3sgoL?=
 =?us-ascii?Q?ULzp4trNQGqJ11H9Gb1QAhKeXOzqeqtk6pcnyZey1vt6mfT/ki3QjltHftN3?=
 =?us-ascii?Q?2xGM7nWNanHUloQIm5V4/4HbB098qaBSH727rqUdeVo3cNer3IHZ3euYQety?=
 =?us-ascii?Q?a8hdeZR/6UtkjA86rUakZ5rYXJySdEv0m+X3H38oDNpv5b0IKRv7oNDzFVWo?=
 =?us-ascii?Q?3c9WerN/1bAI9hzKShRLecL3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49658d46-0941-49bd-0b35-08d955d4fc02
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 16:45:50.0907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B180BHcI75iKtRwT+miwdiqkggIRUau/zlFymhW3MPaKdtF5ohaxCdSzzHCSSxmAFgII/imOdjCI37LE/cW+tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the platform uses BOCO, don't use BACO in runtime suspend.
We could end up executing the BACO path if the platform supports
both.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1669
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 91a5ed96bfbe..d96aaa2aa5ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1566,6 +1566,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		pci_ignore_hotplug(pdev);
 		pci_set_power_state(pdev, PCI_D3cold);
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
+	} else if (amdgpu_device_supports_boco(drm_dev)) {
+		/* nothing to do */
 	} else if (amdgpu_device_supports_baco(drm_dev)) {
 		amdgpu_device_baco_enter(drm_dev);
 	}
-- 
2.31.1


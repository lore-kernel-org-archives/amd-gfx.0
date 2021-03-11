Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC230C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 17:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8049664F8F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 17:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8049664F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050236E436;
	Thu, 11 Mar 2021 17:16:04 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E89A86E436
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 17:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuVxuyrI5aoCpHDHmFyle9iq5hkcTaaW3zeO2aUg470G6uLmXh7MDaOQM7vpqlXMzYqcvkwrdnSOWMbHH7HUv3XtWoV4kE7eG1uG10HaxWXlNk+r+UTCmkJ5Z7nlmH/+0qpy6koLaVVDKGKz5oSgyGDPM++WeDznmaGwLDYl48wqIt49J+7Ga/UnjK9bk1xgdpOWDWgin5fcwQvknSXpuIefjJ2pC+ZL9WBLlcRNnNlaJoVDzn/WiMc5aRVNPUCiDYi9+QkGhUmXXm0xr1moVAjYJvmYnUBFQKAYUC6TEcFrO/CXG/PyjsMH8knielFhkdsx9TMFFIzPQmextHgHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49bpFUI934S3XPoNqNhQi9kQiIvsGzOXef97hFQ/X8k=;
 b=gzKjRt4skqZpDYob38M+iNbBneP+2t4QA7ZjMAdcnXMxoq8e+AC7vgrTLiMK6Zuq4aXt5PlPai8A13mLlPWtgzs+wVRTQPSRTPdC9aR8Zel52EOp7mfGDUBymvds8htDqNm71kb9BJF2+ccd8O8sRdwm4S+IMup24VotWnm0LNTeENhIvLoVaNZWuRW38k7jtgo8+ET879W3DxMUBFF800Qq1WMrOeriMwEgeN6n9QXY6TGh0UY3L1x673gbwfgVbwH3CmKU5SXE/vUqrL3hqS2qCz9T3EmFixikMh/oQf22Se1a/p/Na4XN9Z49dmd3MPUizPdYf9PJ+UBIy20vrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49bpFUI934S3XPoNqNhQi9kQiIvsGzOXef97hFQ/X8k=;
 b=mpoQh8E6tdn7qynX8k8SiQd93V42Gap3LuQ2UQt8EVTbplXqws8oR50B8byfjwyx66t4bjDlT2RLrXTgyMrDs+8K5VqJYslwpTAF023pqQd4h2j5KpDsI7pFLiJhgGCH7jEtHyEez4+DLTYhjjtkW1uK6IMny5en2TQni/d3SeU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 17:16:00 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Thu, 11 Mar 2021
 17:16:00 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configuration
Date: Thu, 11 Mar 2021 12:15:48 -0500
Message-Id: <20210311171548.10671-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Thu, 11 Mar 2021 17:15:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40755cbd-3480-460c-9283-08d8e4b15778
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB383544DDC9AB4FA040568A62F4909@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sw32yXHdc8mPDvQaOOmnKeRQ7IISKtjxEl9rX+soqEkPuFitZZI301jEQ4/hvcLBBkPASDuL3NQdAzkppi7jp/+LlYCF/rb1OUQ7tbgYQ8gD5bYpkSKqi7HHKDovGJf/QxhMS0IntsAOmmMHjaZ2Ta8revywTSTh9eptJd1Onuy56B5lwYz1aFXhsOF5U5nM8U0qcBoHAMCZxmPwea0kHGpNzXvz03uEfSqEuAmu10dnaeI/prIbNJuGFS1xvd9bfcgzcXiJXTcTIprHRJdJyr7FwgB58jWxEPnTF5jiX0jMsjXqMXZqOWkQqMFIp385wkuBPXeJXSsxK/IeXoh2TLiE9VgWICmsB8RuQ8PGd1RYD7jmgvV+F0akRxgvHoflN6aViFoEqG3DFuaf70fvk8V0U0YGWLr4FrHk7lO70cHoRCl52DKPz2s1GcNJEZMVBTA93ZyO/u349lVbCoLcqJ2/3NLIH5l18pVG3KqhmvBvnibW5SbPyk1b0RRrjtRfgoJNJlemh8qpA4i0qFrvMPCv0ccYoxs/gZ3wE/oSI2P+YMHE/cVNoMA/pnnXKq/L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(66946007)(4326008)(1076003)(6486002)(8936002)(66476007)(2616005)(52116002)(6916009)(66556008)(26005)(6666004)(16526019)(186003)(478600001)(83380400001)(7696005)(316002)(956004)(8676002)(36756003)(86362001)(2906002)(5660300002)(43062005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LBwmIH6QQIeNYD2FLgxeVXLvepNqkyf+E7TZrB4KuusmsTXZzPfAWbr/vI19?=
 =?us-ascii?Q?EHyk1tN3qT62zz74I8O/g2bd/SFAxtj6nYLmMyZLAQ++s92CzonFFrgBnv0X?=
 =?us-ascii?Q?rQJn/4iiRmD3kk2dxaWWI5wHhFYdCmVZmF8WLts7wBH38XLnpx+uMsURjJVf?=
 =?us-ascii?Q?ytNHo9ouHeEWKnQcqmPOtoNZTwjkc/ipPOGTVLz/EiUXhlWaRRb45/edWg+T?=
 =?us-ascii?Q?l1htc0RMCyLAGr1ePTRj0LIHCSVc4gPddHI9cJJyTU29xBr3rIILGDqTo/Y6?=
 =?us-ascii?Q?0MRPkNJOQRo7ZfVlDc9+jo0Wbznxu0CcekkvBZ6/K+rlM9IbYZW3nls8ex7/?=
 =?us-ascii?Q?sdeMT8vhEjWjokpL2DJ5XZsASZAigAYfr1WuIf/6syba2RGt/OvAiB4PpqsG?=
 =?us-ascii?Q?NDnhCRFeuT9TarDRKed8NTRcQDp2DLYOLtInUxALJ43KQcOGh1KgnUH4WCYX?=
 =?us-ascii?Q?swtXM+WASsau1TVDuZBuxY4+7BH+f1/KsIkkqDva31Qz6PDzRh98E5I1zrwM?=
 =?us-ascii?Q?g9kGwgVtAAXxnNmNp9kLn9vSvsyzj5A6J4B4cQf6zvm5RFljm9zfwhnhC73s?=
 =?us-ascii?Q?OChAqwh4pE6jEzilpHxB4duzv68UAUHmmN0ymFQdiwVnrXPl2QKq+ijtAohE?=
 =?us-ascii?Q?+So/xp39XIXtWDWrBYDYrkowV9rnpZaDGFrUzI+ZUPyok4Dh/6ERWNF1HkGk?=
 =?us-ascii?Q?K4MiogN8GgKBRXQ2OPT9WqnxCQvIC+w0ieAmWAFlRCS9oB8+fU6IN14mOrfg?=
 =?us-ascii?Q?MQAYJjPcCar7L2Xn/j543KshCE9u6r8cxzewAGttbzDwYq3CHp08nYDGm2Qu?=
 =?us-ascii?Q?u2f7qzTfvGYd4AP9S2uVz/tcMsPh/HR9zsgMPrl860XMb9KRM6G7aQTHQ9o+?=
 =?us-ascii?Q?pZ1nqm8JQgxX97CowxcJXd0inK2+U3A6EqykVZiYqA9+ariWlScoPI8MxXPG?=
 =?us-ascii?Q?CsKwsGyDp0UcLXEH5FDr0Yw4JDXNFTwEl0x1C9pQ/5vu23FO206TwlLlnhux?=
 =?us-ascii?Q?ZCRFJDr1WGBFClqlXKtKeb7PnUyWD20lTGrsij9FNsuHuZS3VwPAdILTrcMf?=
 =?us-ascii?Q?HcxFgKNKk8ZhsWpctUe/p7m1R780kXVsN/lqXPEWzujgygdFIcl5eE8yU67X?=
 =?us-ascii?Q?88wKmuO36WDM/MG9R1IJ1Sj1BPbBfPnc5ym8oaPn+2p4kXKtOBadycYpfPkO?=
 =?us-ascii?Q?77DvTfKc7yCcAVzJZ9mSQZxc47qdjFKJd5GyfmLwV0Ddm8lU+IZCwGkdlnnU?=
 =?us-ascii?Q?RM9M0zjNRSOwEpFo/FgzYN7c9Gjm3CgPfe1IvtyCZFvdE275FuPUx/QnmaXu?=
 =?us-ascii?Q?j+N2Ad+X5n2HbEQlaoi76KgJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40755cbd-3480-460c-9283-08d8e4b15778
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 17:16:00.1728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYCXsNTK8qMswnlhIkuhTcPm6hhJZ4NLz4iJMjp5zPGZWJk3i3PtQmkGfZpWSh1EIEkHncoLkSRKnpLhSNhagQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is to fix the commit dda9bbb26c7 where it only enable the light SMU
on normal device init. This feature actually need to be enabled after ASIC
been reset as well.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cada3e77c7d5..fb775a9c0db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
 
+	/* For XGMI + passthrough configuration , enable light SBR */
+	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
+		smu_set_light_sbr(&adev->smu, true);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		mutex_lock(&mgpu_info.mutex);
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
-	/* Enable lightSBR on SMU in passthrough + xgmi configuration */
-	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
-		smu_set_light_sbr(&adev->smu, true);
-
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

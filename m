Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF38C636CA
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB0961029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB0961029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40196E434;
	Tue, 20 Jul 2021 15:44:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A726E42D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh5Kv90zdbbLn04Ge1Ljfe/o+gVq0bDK80IsrkGSYP5fN0CE3VpLCSZKnJMFqZHtJb3KXJ/K2A7h353iMVqyFBPQd0KjVFJg9qWukgFNRHDaKCJmiu1PIDnlRZ7Al9IlNKhcIq+6dj137bSts1KQBklMlDUZ33XtQtlTUdxJKqZLVW31jBIKNjTj5swkXiNFZlbFeAOA8k8vo8R4LpPyHG4t3Te+FoLVxF9h1SMYKNPrvZHsg154piVSLODKCne+ereSGaPN5Wl4J7of7qK0zOqlTQRNTpuffxsR6p7sFD3zBnZYNLkA0/93WdTXTJrYf3xVLq11XSeoT/ywcDnMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDnrd6VAkXmLRA3xrbTagQzNrPJE03f8GEYcgxdicVo=;
 b=HA2VhOuZPO0ctX2FVYFNec3bfeb2O8YLPpIqcBYhdatVsr9CoZmKiLlmw/AIs8BOLZZOxlL4XqkeWalfXiJ8i+c5UYTl/vrFAVbFQlly5oOsve8Rj0+6dSExxNdaiuOfh6npHfo9eqimOjt32GaBUzH8TtS++cqv4pVQtSbsenR5BLPlzRJL9nxqmf3is1JoUZCzDjcd8Zp0vxV6ihw+uvdzEX4C3c6+/Ok6LHkiElOzZDTk+90sTnlqYvvzrWfQu5vFt7yXK4LLsRYeJGTiFaJOg6jxru4LM/PugqsJoULaO87BjoaDQ0hVeIHYAuOTUPBHbjlOyX2v6ierk3TqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDnrd6VAkXmLRA3xrbTagQzNrPJE03f8GEYcgxdicVo=;
 b=GJtX4tHQ6sCiTInon4ZZMcZ96LpXXOcp49zDIvx9yAw0WBwx2fNBa9Q5L64gM4yUofgga49DYsGGBPJaLTrt5f/GE9p6IjDUEojJffZRwoVlADZrm/ATVpypz7XZgQT4exRneeWIK8tSndGN1f66+0T3oW4zldJpq+Ek/hMsi/8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 15:44:08 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:08 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/29] drm/amdgpu: init family name for cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:25 -0400
Message-Id: <20210720154349.1599827-6-alexander.deucher@amd.com>
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
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18ae7112-b3af-4683-f162-08d94b953621
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53496C4FB83DB8BA606C126AF7E29@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKMUyvhXxTC84wCrNChHvxu+BnBjbLhGTdkqFuT0D+72oUyLQPrDTdRezR4WMwe2MN2aKKKqh14IgcJQMTx6L+jalOTsFQIS+qkcfTjOTNFbWXU1H92djTU0bwtN8vbklBydgGuvzvGuNRWKi04Wjnb8aO0DhOg6zymJgW6OqxoGHp/SHJmhzFZycxdwYY6U5NerKFwzhkH4IJMwYPi+a6sIWtzxqdtPUBd3uUM5onMcSUARahz4dhi8TR1o9CV1fJlWjMMQ481S+BTeAkcrpM3gLXTMVnuFCemnxct/1R1mFRUSdwravMONyedqf9n4pPnJU/hh7ri+qwafXDysKnZlTQI+Z1Sw6iuVaQa6uBb14PzhLB7FBn62ZestHi01P6KZkmSA6SK5eE7k8/n5YG2Sh1q9p4WlbOG6eqHtDiZTzzPQ9LVGCiAFXFMSNwk3mUHZkNmkzXzApNxXf+JpZ1krE9Liiya2bXsa7IfMIpZlNpkVWy8PMUmkV2KiAiDGPT/sLGcPIa2AoU+KLdXeJ3Ci0P833sdakvMZP3DNWkwcf6T3FCkuCKqYV0d59vaIX3RgyH4URs10nc1p2M81HlfQXiFmSOBoyDNynf9qlwT0YW/mk0ExD8tg/MIKqpu5d+GA0BJnLUi/uMCvs7ST9q296IZ7v3/2ov3SpUb37YKa2JKFRdLjzRVWNLR8olPipoghKXHcPmTAOfa3tNoGSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2616005)(86362001)(6916009)(38100700002)(6486002)(54906003)(6666004)(4744005)(956004)(478600001)(316002)(1076003)(4326008)(52116002)(2906002)(66946007)(38350700002)(66476007)(5660300002)(8936002)(36756003)(7696005)(66556008)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CVCoCgWd789/iZH/6GeuEFbyPltryUgiqucpxS2K0LfL3uTyvIIJGBGNhvQl?=
 =?us-ascii?Q?pZkOTuQxAZxFfz7Yj0T3s2jsBrpN1rhMxkR3QSjVxVzQp1ZwNnx5wMWs70bN?=
 =?us-ascii?Q?0Ev71wCWL15BCZIlaqb4hZJjSfRkPYKqWGKlwpyyXvjbqCZTIdyNuyk9A+Q5?=
 =?us-ascii?Q?/O5Z8wZF2A0RCYrx3ZW3iUY/1PDDuoWEeFDf8t8dZpNXrH66AwtMaAZjwjMr?=
 =?us-ascii?Q?5GZ7Au/5tuN4//HQ1+RRzkVjzQuOnaUSeh95qSNcZJJ2/8icyl3fMXxz/Ig7?=
 =?us-ascii?Q?+XDJX/tj7R1jrh+O0DqRwqC/vEoq+8107rVBVopQzq/PkN18Ezw6FBGrofXR?=
 =?us-ascii?Q?m9gLAiaJGnavHrKdbz+e4eZ/XwhV6e6qJK5OITi2q/TY/3Q23FNSYdMqRUnO?=
 =?us-ascii?Q?gJpezjXkj9F4WTNSuzQCjTyn5jn9VduEo8M7CGqbm2bWkICi0g4+WtKTETYp?=
 =?us-ascii?Q?93OCyQV31XRW6YXpLAKV8ES9AJ43f2gMd5At33pnoNmtFFAP4tc9wG5idzkm?=
 =?us-ascii?Q?U2S6H1GmPouy3VcdofvzhCec8CZT70QT451w2N0wcs4V7S5wbzrmnNf/FVAJ?=
 =?us-ascii?Q?YmFwZaF2feMFb6FUAaWfbt4d3mS7Ywb0gGIsv348dY6vEhNQILlekuSiyYBQ?=
 =?us-ascii?Q?1cDb8Te4vdDKWg0GyZ7JMtcHrJ6cXoCjXYSuhJ+sRYigACumoQ12A966V0py?=
 =?us-ascii?Q?3FwLblLQ/HRFQFvNGpmPZrFblezYbBXkLCXRuvSGenJwvjeM4UjFm7G7WIRz?=
 =?us-ascii?Q?tzj2ZrMdNLnajWSM6O1S52jRs2MV8fMy0FfnsdlBBpfkVZ38DV0cPWLrisvl?=
 =?us-ascii?Q?xDP1kMKRRqUKiBvjoyMg9IqxPKjSpE1NTsGUEmwdbBYGJ1DY4iweqoicMXAa?=
 =?us-ascii?Q?GRaeIZPrnni2/DAbwVGreEnmVBsvFulmozAzf08KFC19mYRIrYSTkztPipPy?=
 =?us-ascii?Q?QFJa2w4ppHrpJBjdaVGOTYYUh820OxxCfF4d4gImxgJBZdi/YWy4OZNV3Fs5?=
 =?us-ascii?Q?lhjJSD4JwjYwbcMHmocx5t4wlhyhoZjskecFUrlD2c6frwMiHs2/UqEekjbD?=
 =?us-ascii?Q?UjQRvOccnCFMq0OGt4DbyBN/du7wrtwQG3lENoWwBril+YcooklBBAt137X5?=
 =?us-ascii?Q?oP9jDlcu7lIXgfpnz5pSjLbwS188uad3UvFtG0mOIqvvdD9sercZdD8CIkPh?=
 =?us-ascii?Q?9TLPd2xT0y1gkyOWOaT0ZQSG4GngEwdUgHf0UppRBuFm/MZzIAbfTiA1K71B?=
 =?us-ascii?Q?3aDhYnNc1T10+RoNSfG0WYiG7UhFkH1iwjgsjGY8xRwyQJZcjyJ8zjkufcoO?=
 =?us-ascii?Q?7nFfT6abJy0CgOUSAA6Qh9FO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ae7112-b3af-4683-f162-08d94b953621
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:08.2260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLlmdAWmlEO7tjuEvEFP2VCwrLrFL6vijYaQc9CYDR8CMkd2T9Q+arfToPHH/nMvnv09BAfY++lO0aEPWIhc6A==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Use FAMILY_NV for cyan_skillfish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a58da68c33f0..099d0a1b4857 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2095,6 +2095,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	case  CHIP_BEIGE_GOBY:
 	case CHIP_VANGOGH:
 	case CHIP_YELLOW_CARP:
+	case CHIP_CYAN_SKILLFISH:
 		if (adev->asic_type == CHIP_VANGOGH)
 			adev->family = AMDGPU_FAMILY_VGH;
 		else if (adev->asic_type == CHIP_YELLOW_CARP)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

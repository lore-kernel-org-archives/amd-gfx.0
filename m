Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47EFC43461
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FAE60234
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FAE60234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB456EE18;
	Wed, 19 May 2021 16:23:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7D26EE1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 16:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mj8DkHfIeCl4ILSknwrBd5xYsuh5NVnjRigcxS4J5KpX97U3EkFQ9lZA/h80m5CjTrEC/jPbnH2cRfNIN58qz+cd+jecOS4buzpegMzRmOZ4+3KOvnjPZ0lnBUKGsIBP4qK0l3PWS5Z8/+sY5OGeJWHy5xB9GyATwMjaFmJXXeG/QQnQDtbkbYw3PovAhYS3zspzJcgnsfYnqpUiHryN9ZxioyRjXYAR5/YZyalYwZ5+3z+hHE0cQGtYx9/dFKXKv+ynVd83Wc53elIQZoHGUGZAuTaWFh8OiWm0Wztz+amUVndaQnCt83jlqK8x/8F5XccScblgGXn4u9yjyd0sZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRsDU3PN3s92N+ogS+PQMoJX9KDifxNTSvRyUCqIFuM=;
 b=bmgcd8rL4bzzz8ps2r43ySsYc/uAQce2aje1wPPHHrb7SOfY+W5N9J3sz0s/5HEUXmevQFNwo4G7+bW7u1MyDCvOqvFO8z4V1tTQbtCEWgeyp0LN0Gh9JOfX8SgMc3FXMUSxy2Pj1Kb3BlodqZQy1HAybh7Rev3v4+EROYky9BCCVYBBsn1gAExzXO/fGIQ3WCEzTN89FnpiZNU0LJh9/FcSt+QvJgbPRNTRkt3yplZKBTIxgys9nEb0LN7cioEWGI1jE3Oy5KHA2p8gPU6t+J/8GmPasd0ignCXerig+/cJT1RGXFJQGlytAcZXeDNEv26ILClFenIgZPQIVVRisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRsDU3PN3s92N+ogS+PQMoJX9KDifxNTSvRyUCqIFuM=;
 b=JBvfEay0vczN2vkjlrvnI/wUIysrAxT9/po1AhH071A0BuQ1RGpY47KfblcVK7Q6xwNrayRfdSFgn+L8AwQemM3YJbsPlFhuZUNOKoM+3ZXwQcgnmFOpM40Nh8yIMCW3LUPaHkrLNB0FeWDTPMPVCESjJgodk+rkh0onwfErM6I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 16:22:56 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 16:22:56 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu/jpeg2.0: add cancel_delayed_work_sync before
 power gate
Date: Wed, 19 May 2021 12:22:36 -0400
Message-Id: <1621441358-14685-5-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
References: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 16:22:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78b21ad6-96bf-4991-99bb-08d91ae25bb2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3259315B6EBA9FE95ACFF761E42B9@DM6PR12MB3259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QdhoX0ATSLr/EMyWejIZZjht/1eFJR4MjHqe7Gj92kB8hz0BIxHG7hTtoKlRdhN2bc6W8B3jUUEZyvwMb6E3YnhHtwGZdpqVXigsKc+b1hw6G3fJcYIN0jcsTHPk5V3S5YNvohqk7T/seMaNKPbcYKnZZMNDWNX3aIwYBxEp4QwHCp63I00xNtT+LmXAWqASkIWMt8gMREDk5pCnhX2UexjJaYdF2OhZifo+VNuBgKLCMFE2lqiVnDpSS9W0guCePd4d8VoEAUf2Tsqx4t49I7o+jHwbbuErexI4IfUZwxcG708Y8iDefHR1+Q1zlwhMQhJnmWNzOvmKpvMvkugx6JumIjXIoIzKQRBc1LJ7fWT9PUdU0NQi9TUsbFU+URlOEj3tDvz2IE2XhzVEBhht0CsLZI8d/RlqvYcEy1m+yReBXP4nTPiwtwZNG9S+E3t6MhFhgMgIApeXitckNgVBySMfxW0P2XMER5/ezocEA2ejUdVpdgntOVK4MlNTHie3q2sfnTo1qzNqu1NjYocJzc4B9Z+8DK6q3yqqAIg1fzNmnUIg1ODCV9wqnMk1RVTjIgbD9E4FturKqU4VSMvY+Dt5mPWXDWfAHsy2RQ8vjx3hd8oLEvHWk8igXLmfQR7c9KNQDqypd8U0VnCAtIDZr5FlKOq0d+/nyRc3sGTfxYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(186003)(36756003)(4326008)(66556008)(956004)(6916009)(8936002)(16526019)(4744005)(26005)(7696005)(66476007)(6666004)(52116002)(8676002)(38100700002)(66946007)(38350700002)(2906002)(2616005)(5660300002)(6486002)(86362001)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O5QAK0vlrZ3Qs5L1QL+CEptTuGWXWAqyH8PiDKT1fn57U/M89d9XY6pxqxX+?=
 =?us-ascii?Q?EZlk2sOXWyV3as95DnsnXaB0lPRNo50kIO1mbzucxngvkuZZNbaHWpjB1ilv?=
 =?us-ascii?Q?KAg+vqOCz54MfyIjKsOX5kavuZwWkP5k6T/tTkCuPDwCY1OLIghfPQonA2ec?=
 =?us-ascii?Q?Ci3WQwtsqrMZFSJE8eKDLBA0sv26OaALFjH4ry2D+7E49K4IlLrFa/SxnK63?=
 =?us-ascii?Q?KuOq2+mzfmtrlccFQUT/wFl8/Br2LaRQmTHkH0MBSLZi5iGU0snErcWcFxPe?=
 =?us-ascii?Q?GbojUQai8f2aGtfEJAn+mczz8c8/kpP67Z/1QiY8/P5iVm6FkhoIajgTGHas?=
 =?us-ascii?Q?FWBq84cg/ODi9MBvxIIjpYQpnNG0oYPFWhQhsao4aJeIVRq32s+5cuwDFdkw?=
 =?us-ascii?Q?LUuhkHxmhl0WJ1Ds8AuaBOhj4AP0FRwjgVGyXEaZBNfKT3L6x0qALx8DkwfX?=
 =?us-ascii?Q?qAwC+emCVd6a9mmXjPFhgFoZ5O1fDzUxT5t54HVL45KJafxb/PgfGTM41J2e?=
 =?us-ascii?Q?6nR4gG7MZUOs5yPPpviIWApzoash1hKJrbeHXZlYjxkMckPhyO3MFs4sLLh7?=
 =?us-ascii?Q?tuL8ozjHhA6fPCA1llBnBk8JjR5cqo5UNopV2IgpGGr6UUjA7bVHuoRJKYnZ?=
 =?us-ascii?Q?9CWgmLJKk5jIgSkvFl2g/EOIS+F4c5YTYQQwVnNa1/M3sJml8Acrh2KUk4rq?=
 =?us-ascii?Q?HlnwIbuRg3BrwOfb0+gsBhTi2Dqg+/vbvObFjoPB7LYyT3gOHm2GorzYr38f?=
 =?us-ascii?Q?ohybgTAQi0zQkF0jUzzI1B+wCGbXFNJZygEmAJPUV8STqxRFNr2TGkPYkae3?=
 =?us-ascii?Q?AHeigZJk34a+wCMRiN4Wn8Ewa+dhy7vKMaigzBQR2aO2Tl9HJOEtlcUhpDU7?=
 =?us-ascii?Q?IEwh0SphAf5zTfjn4w70VvWXlxurRsmS8rry0q1RWj5WOIlvF9K1reIcYV28?=
 =?us-ascii?Q?dYi1ZmMlDdN9tvqnya2SIRI7oKtsZTGz7zHTkVZ0TT7c7ZgAV6B7XyPtE9qS?=
 =?us-ascii?Q?bcFsZ/JqpMboLPZiVkD8ex1MldIN8vA20pSAb5Fvs0HDbbVMML7jri84i7QE?=
 =?us-ascii?Q?id8hCTX9Xy2USyTJkQeBVIrb9atEgep6ke/AkUtQk0zcMfdrpQEh+fPMJghW?=
 =?us-ascii?Q?dWyO6eB50+H6W1oAoVKH8aMNqLCPwLho3TQDRShHrfiGZP5S0Xl/iD8yo+8m?=
 =?us-ascii?Q?6oRqGRcPMu7Ic1RKKQp/T3oJ3+outSpb9g60QjhaoudiD7ou3KZGBFbx9GR/?=
 =?us-ascii?Q?Bft2npspG/cRKfl4xb7UBwGUrMeENdcEvV8/8rkUjkQ5tPtGzSu3M2WtH95k?=
 =?us-ascii?Q?PCDod9Sa+n8fYySp1d7+qGds?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b21ad6-96bf-4991-99bb-08d91ae25bb2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 16:22:55.4997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6SaI+hrLykrcsZFWsNk9sm1P7VgJJa8g5993lc3dpufFPuafXU82zzNUlT2qUVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add cancel_delayed_work_sync before set power gating state
to avoid race condition issue when power gating.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index de5abce..85967a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -172,6 +172,8 @@ static int jpeg_v2_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
 		jpeg_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

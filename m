Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3D9C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 10:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225B8206C0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 10:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A1xvjEqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225B8206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CDC6E2C4;
	Wed,  2 Sep 2020 10:11:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888A26E2C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 10:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yye3Ky+v0VjV+PpYViDzaznbGvYcyH773SZNi2hqZhTh4lb8VUw4zAQjLW0NYjQPdsTck5U3MM3DwRVKmGL1+U1qOZ582eJpxypE54exjkXiD8yv/Jyx81gA9S8smTX8ZDGJqimyxdp2cUE6LNAN0Lp7rERmHPnx6QaXb00XsHjg3KShACWk+f+TbhkUZC7Acwpx57TT6ROBb7XUOlMtI00iqBmEe789qV+0aLmD4szc/wWv1go5FQQNoszu34Immzraj4kTk9r9uNpoqeSvm2wAUBS7BqH5VZBqpuYHS/lhjqvBjEP/Cm2dP0ehv5OMfMuCeQsuVVmOzDjXgoTCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5P3LUzOYmIRj5CR2nMpqqg/phc3Te3aDzG0l5WBamo=;
 b=ZEkQpMOo8SwX3XRM1/n6apUdbZ/1iHfwoPkZSXs6zUnmViF7Td+KGvtpkAUB4qOQloQP3yedp6NXTb2QEX4epz4JXEDUZrVWYbRpMFCbDRc1LP/kKi8YFpvKPVQ5nn7LkqvciOWeYYMoXM7sQPKl9d4oeAAXpkJN5qr21AbiGJ6mAYLyTj+5gMgQ97VBMZ8wwvRwAz8JifJxtdqKDxsaewK+Dw059lEhPGsYVcbho/010Va37Lwf+cxShlyYbaQrGHHhb1xhWpvuhEtm1rnE2vUFU5tBQTuj67x8tsQkZ80KCMxjGS51ay3PuBbqRn6RzN1rSY6PMOMWRrcd1T8MLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5P3LUzOYmIRj5CR2nMpqqg/phc3Te3aDzG0l5WBamo=;
 b=A1xvjEqcwB8ylhUSuuXlgF3Rfq1pJnOG3mP+l9yNCtiV/3HxZSIWsWU11fDHwp+ACwHtMbXVGr+wfiELF8bZBo11JAVbtYz7z9f3uOuYY3x5hoW/a7o7wiqU5n6GN4QeXzr7A+r4MDb4dTgSmduB96MimP5Kc2ni9sWUTBaLV3o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 10:11:27 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 10:11:27 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd_enc
Date: Wed,  2 Sep 2020 12:15:36 +0200
Message-Id: <20200902101536.47112-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: AM0PR03CA0076.eurprd03.prod.outlook.com
 (2603:10a6:208:69::17) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR03CA0076.eurprd03.prod.outlook.com (2603:10a6:208:69::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.20 via Frontend Transport; Wed, 2 Sep 2020 10:11:25 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [217.86.127.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23ce5754-2a11-4bc4-a573-08d84f288dea
X-MS-TrafficTypeDiagnostic: DM6PR12MB4404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44046B70468BEC2C2A01A2918B2F0@DM6PR12MB4404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WseH4VPFYkzWH2U3mk+Np0enfHOsb6qY1Ip4ikspsImV7j40CLytb7Ns1d4bBbflAvtx+KnTkw4F8A1u9btp2okkeluemNtjlauyRwzufvy998ge3Qhmx0eIld13siEwiu1ASyN27i36LYcIsOxnyp8Tl3yQ9kCuoAeN/Hz17jBncZn3J3S75vCposUWkTF+bBAPAf8wQnSwu72wmRRP9hGG9lEuERKWIa3YCvg8oRXpzS63KgmepHxZPthcilQBQwxpyc0hnp08jygB4wABdHhE/QKF7siRsmogBAHqwuz6ai3PNNpsaxgFi3T5LDo1tvrntgzNv4GRIgrvzMMHSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(26005)(86362001)(36756003)(5660300002)(66476007)(956004)(66946007)(52116002)(2906002)(66556008)(1076003)(478600001)(2616005)(44832011)(6666004)(4326008)(186003)(6916009)(316002)(6486002)(8676002)(8936002)(16576012);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KQD8sjwAEPD6777OT7JzLqiX5WltPnszoiNSCNSuJoH+yGO8GvsXnYO6/DK9eZiCiHkTYaU6mne8MJXYWOyyyEZa0x3TAf9yAPzs5uAWud+g5Pfon9mRgcqQmaDIhVwm6+NprxStrabW1Xay2M+9jQeDuak40tXDwKnlVAQdAYNOD45rlYqH3qqInaiS/feXsKZt3t3Jk2T+wulQfBt080MSiS53NwZuLM3HShhdg49fjwiT5tpzZCGs7kYBRIEN6ShgU8XTAHDFRQTCM5BjqbG5EPV2qqxzAGrcoK/34cqop32YG3jH57piXC27mkhOso5XQw7lfbtHGa3Bqr5XqpRFv/s8xyL1MeJZ6GUabfetQWAaRAlxm8KGbugAMs05/+oEaq2kjGEc8mF2DT6KAQiN+z1q5oxQtq1daOPyqhqNh7IGTJK9ywPCz9En5WLinNt+LA7dZS3HpTfWVFFuqntQrxPwv80LP3tM8bT703f6ZRQRvgoNWwZUGn2W/6YvTy5hCS1XRtOI7WywriVMpNq3ArG91TI3RrjOZbDM2MlEllANcrluhcM8XwmNX6BWHp9gZXrCERlwHpdhtSHoRXUuaoL3xyB23ZkJMawDntWZMRdmVkeVmOccRVmMkinla4H95xdGjaoby6/RI00Ghg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ce5754-2a11-4bc4-a573-08d84f288dea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 10:11:27.4074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kduPSk+NU9oXvSAFFYQ33vccGqUCIuWY3Ql3r6Qn8Ct5Z6FXcLMyF5n9QJjuQvBKLKcspucXYh87dfRAJxtbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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
Cc: Tianci.Yin@amd.com, pmenzel+amd-gfx@molgen.mpg.de,
 Nirmoy Das <nirmoy.das@amd.com>, alexander.deucher@amd.com, Leo.Liu@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On hardware with multiple uvd instances, dependent uvd_enc jobs
may get scheduled to different uvd instances. Because uvd_enc
jobs retain hw context, dependent jobs should always run on the
same uvd instance. This patch disables GPU scheduler's load balancer
for a context that binds jobs from the same context to a uvd
instance.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 7cd398d25498..c80d8339f58c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -114,8 +114,10 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
 	num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;

+	/* disable load balance if the hw engine retains context among dependent jobs */
 	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
 	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
+	    hw_ip == AMDGPU_HW_IP_UVD_ENC ||
 	    hw_ip == AMDGPU_HW_IP_UVD) {
 		sched = drm_sched_pick_best(scheds, num_scheds);
 		scheds = &sched;
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

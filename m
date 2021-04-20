Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C086AC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54639613C0
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54639613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBB926E8C6;
	Tue, 20 Apr 2021 20:21:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4234B6E8C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 20:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzpo2wfx9H6pih4WTEltZ2Lqw/oT1hvrACpOCrBEmEb+OW5nOb10HvOvLaEv6E2jLTTjkbXNQVmMWszDGAKTvGLoDxTc5UkSfDQDat7WSZq6Hryngpnib2MV3BcXOmE7GJTKNF1bjgUwLUHy5HcLkfIg6UjOKO7l3lzye6OJM0+hSFxd7anqHnxWRmEBTJgzcpKjkKslrWluoVSVCu2eYePiX8JNCIzReoCZjndObA6xKOrvk7zvkhTkILx18JYN4E4/Buw4VGPMfSPwR3AucwXPS9xflPitvSFdD8XXw5OLusQr9Zh5qSC7C4ylR2Wodeb/2wSzw6qSCj+8VQhV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnq8b8bg5dYKdSFVrCemvrKd8YAMU15A+alm8HRngxE=;
 b=jw4E29yEPdF+nMWjL8Mp7BvsUg2OijVgK12PX2MOC4vhTXVQE/fz0CGMXnaLK8rxkhvYP2l/aOkly+B4CSRCxkU3QCzAEb8Wwpw7XlXLn0/zf+DQv+gRQdUkVDkYi81/ELNGQRcf4LJqMuhmrt9gFZGFTezqLTGGkJFBmRdasZQs2kRbm5usdLdEn+BdtzBpVtEVOIiulZzs8dVTIn59AZAZouzLsAZJSZRECQBWfz0g2pXYaVUzApuvd9GOADNSqtfOeUkRfZbPAVW/bwi/ZWA5CX/W+WTM2299ahFgMSehmjzRONSpKrvKKec4dc1IhX5IJYgdmQfzabtrQpQXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnq8b8bg5dYKdSFVrCemvrKd8YAMU15A+alm8HRngxE=;
 b=1ndMU/EmGy7QP4vbmPh2fkXDA67D/dyOCXiedAom1LaTp6dgZao+1qGxYv/VvG+VMiZOqOHqG9jRsMX3CAkeTYzSOZqa7e3vO9ca3Ps9m+xJzs4PWqiJQkpV9Bupp9KzUpp9I+Oncxl7HLc7vvf/gkLpfdfwX5cg3SfNcfP3TYI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Tue, 20 Apr 2021 20:21:36 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 20:21:36 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdkfd: retry validation to recover range
Date: Tue, 20 Apr 2021 16:21:18 -0400
Message-Id: <20210420202122.4701-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::17) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 20:21:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ab71e2-c7ac-46df-596d-08d90439e59b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2488FD1B02E03DD624AE7700E6489@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsSrwKw9X9WUSnjkruNkYwApeF6DWo09GrliK4U526hx1pDFHUOUaSHkZtZWs3LB6agJ+2VOnDyxa7z4uwc1MMvhbYTGpevTuRAnwfU/6agonZ/6v2xzndznXS1IyvBveHkuYBOlRruhxAnj8wY3YUfuKzEjyq4coD6S8y0SGs0+YXVxzOLN2ppbadUMwYJEY34l342Qg+S0JM4n1TKQQ52Z31rbmue4UwAs5bFDt4K+NcMVGEaVVNcuJyZlHOi+Ju36Je9Gxbb6ykVKXHIgzpDOL+PWC/tVRLlLGpZpZpDSZNN8hyiPuPGhjhuARpI4E7hYWH6TaCJ335MdfHdCkLfHK/xhLR0Zxo75WnMrTif2L2SrEEVP9fX8qv+IIQA+H3ybgoD5uXbSfbJcMdHPOluFVZ+xPztwW+Ibos4ODZv2AoQf/nC6yLAcoxF5E7IuigPGv78xHXODqUPQdEMRJp9C+JDIAwf+pzSzamvmTUyuqvtX4+7fq7fn/Z5xdzooBblD9qfJEM8pd1RDsC+19UEkdKxT7TgmXvmmySn8IhoYkXfSTfu95F377v8nVt14L2Hff5JFtBKGCcuj/ewi90sjzL085vV/Uiuv2zdFWct3bb1rxRR32JkyND2Of+PQNczNbYpXrkWRCCCgqWYp8d1axtNEbGiPaoEBzW9t35E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(38100700002)(83380400001)(52116002)(66556008)(38350700002)(1076003)(2616005)(956004)(316002)(2906002)(6486002)(6916009)(36756003)(5660300002)(16526019)(7696005)(8676002)(6666004)(26005)(186003)(478600001)(66476007)(8936002)(4326008)(86362001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u/SkO9z2LGKIVYHFRGRbvZApwqHb2OSv8wEipY/3utsQd1O9jIRwC6BYIVAq?=
 =?us-ascii?Q?KW/1g5k2aZHw3Azs/19XFpSTem5Nx7/kp5pVfIpFr+2RGQhLC922moLhTKSF?=
 =?us-ascii?Q?AtCUF7VPO7uvk0s6LAb/WYB4fL+cBxvDW5NWjQ3pD7KQPA3lg0mXrj/zpeaW?=
 =?us-ascii?Q?gh/65cLm5GVCWAD38CJud5YfUBWjh5BUnONsMa64SYb2weJBHboAd8Ka6/s8?=
 =?us-ascii?Q?XWEM4nMWkFk4Yw112nbl9Tokcqq+6OeYVw/J1MGJPt5C/MzYVEWqF1YmvuJD?=
 =?us-ascii?Q?AsIfz9xErkU+Uy6cJe7bwaW1xDtQQweAFoYhSxNsAc5zJTCZmF7a3LNlOtVO?=
 =?us-ascii?Q?cRUtfH6ceT5Mq6AofTO++aBp9R285gN/pFAV5oexXS7UL3RjGokZ4gUd69NM?=
 =?us-ascii?Q?ulL/zumOd78ExDIT3DqOrM/CZpsr6PZUSEOX8Hz3dKhv/4lhNYv9vvmGB74y?=
 =?us-ascii?Q?7vzvbnAMEuqJSboCLhQd1VVLcEx2YnCM62k/Jhxl9OmXI/4yluWgx0HHmU9R?=
 =?us-ascii?Q?ZB/5ifvPjd7SXgF/B7MY6lq5x9fe0M70/AMtYZwq8GzFBIIec16CPk8cHzae?=
 =?us-ascii?Q?2trt5ad/bTOWnDVRzOZyZkpSJtqsGK5lWuCVI9Kck0yw0qyFMuIsw9n9hgXe?=
 =?us-ascii?Q?Fyhq/F/dwucJ916L+BSAdwZOOOqP87bmmLOimUhsQ7CeCsOJC/8RnYPTO7Re?=
 =?us-ascii?Q?ex9G5bcvFHKLvmdZkCz+w47v7FPY5nxOR9yuWVofNa06nPKF2GynpaxQ1gtd?=
 =?us-ascii?Q?uBK5hmZasgsBG66gKPyFL1jxvcPhJboLuBtukn1KgkIjlQHPJIQGqYL92x0b?=
 =?us-ascii?Q?j59XdS3CNefVXo+Yp6uA957A48d10rc1obi9y+N+dO57dGIQ3puvVmCgsdLt?=
 =?us-ascii?Q?GhGMBdjBiewNY7scmmmzg/qqPIryzS1rRdbh8XAtpClmfsZlcFduKwrCEBP1?=
 =?us-ascii?Q?HeDod+FaZSK0Ug2p7UYTvgdHUoN0MToHmFctbiYEUqmpH433Ws4AX0p/9AQw?=
 =?us-ascii?Q?mztG7Qx4FlwiRMZPEEIJXpfWyE8N5XTwTFJdz5WXW+V6IJSKj6xLqDPYBim5?=
 =?us-ascii?Q?Jh+8NHHH9D2yrCLQoNRWSvXvN9RQb4DCxY0LbxhpP4biMKfGxeyzp8O0X07o?=
 =?us-ascii?Q?nUynHWTVGNVmhOjt2PTh2agUhKYOeEITS+OozUR0tt7qUluALJMiAudBu77B?=
 =?us-ascii?Q?CJakRcQtzNywDHakfcM5NUjqnky4DXeFFsrLJOq5BX1JV/SjtA0OP1HMgdiZ?=
 =?us-ascii?Q?bDRLuq42mXaK6fOaY3fjNZsmq5otq32itEdoKGHHJewusy1P2zm6KzP3OeaR?=
 =?us-ascii?Q?1MQNuBj0Hd0nphHZiQTpwesM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ab71e2-c7ac-46df-596d-08d90439e59b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 20:21:36.3015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3AUS9sNVsT1WqjeWO3+pvexWOmBIlWDRPVPqY97fGGYgMBMbwRomSRTlejWir3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GPU vm retry fault recover range need retry validation if

1. range is split in parallel by unmap while recover
2. range migrate to system memory and range is updated in system
memory while recover

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0e0b4ffd20ab..40ef5709d0a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1402,11 +1402,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	svm_range_lock(prange);
 	if (!prange->actual_loc) {
 		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
+			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 			goto unlock_out;
 		}
 	}
 	if (!list_empty(&prange->child_list)) {
+		pr_debug("range split by unmap in parallel, validate again\n");
 		r = -EAGAIN;
 		goto unlock_out;
 	}
@@ -2254,6 +2256,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 out:
 	kfd_unref_process(p);
 
+	if (r == -EAGAIN) {
+		pr_debug("recover vm fault later\n");
+		r = 0;
+	}
 	return r;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A60C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 23:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8274E20768
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 23:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Uyuifpb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8274E20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CEE6E99C;
	Wed, 18 Mar 2020 23:38:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D18E6E99C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 23:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFLG6EElcAFQk6UDKtQjyt43pFCFteP6YQkies4XE8st4IsRde7iNOGPPhme9wxXYlfcNhG2RM13KDyzAUTQNxJhFA14HtKrEgd9CyFOQ0s46PB1AqRebngEJPRci1VLS2xMgHtPAGW73SPUaIF1Phi5+J2UtUrZ+bEYN4FJ9e0Y4VluApQaMK6VoC4ZodLjwIR3tBw+0PhJFVXcX8Gz0NKr2SW6myzbtmu+0g5jDVdQKgYmPsYxOyU2UCq1LL5JLPmjOYSGqJo5XnwvL0nPU7LYFSlA1tPT1Ft6KoNHe/enBEkyftO8aUcVeeHvqUqAdM7u8gBYDOakf/lqPMwtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxUC8lu65AxSbQYpD3zkxVOqy5zMQoz0450AJSplO4Y=;
 b=GQ/6vB/VrJgjwNHAO9gNKx3L0wZ3v3YrfQDUBopJcuAjVoc6/T01aO7gRXMRsOteXA3LkcIyKM9kTBIJ1vBv/kZSHcesLpM7bn6LWcK0FVQ9UlN0wdHxa/GnKHA19hp6FLJWLlWOPas6IjtWezhK/oypsH83ImXCaDAL7ggVHBN3pnC+rLdk4jhj420FdpmWvkU44M+MW08aJaqcrICWZLuAnoTuIGD5I07pRuFdksYqPVZLlgg9/+JbeWHmtkhXnufdrv4vB9x22aLFcH6FkcG8feQ7Zkgjvcn07pc3vrIC2weqGn+CknSFSKRiA2uCzi+r9WZC9By0Fb7pEIrVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxUC8lu65AxSbQYpD3zkxVOqy5zMQoz0450AJSplO4Y=;
 b=Uyuifpb0sebdtqlo9ie4gaakFLZjglXtBmDBEpenWFvHXKqI9SLFg706Kw0cU3RUF1pfBwk/rkLuGzisBMKfAn/RY3c5QQo7e83HoYyeeVCj9lThxXrluAV+AYTHvkfy/UBBrlYG7Ot1sECa5jduNzSbjuFISTCxHzTF8/QWfiw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 23:38:24 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 23:38:24 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: ih doorbell size of range changed for nbio
 v7.4
Date: Wed, 18 Mar 2020 18:38:01 -0500
Message-Id: <20200318233801.11866-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318233801.11866-1-alex.sierra@amd.com>
References: <20200318233801.11866-1-alex.sierra@amd.com>
X-ClientProxiedBy: DM5PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:3:d4::33) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR05CA0023.namprd05.prod.outlook.com (2603:10b6:3:d4::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.12 via Frontend Transport; Wed, 18 Mar 2020 23:38:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66a53670-155d-4645-6770-08d7cb957356
X-MS-TrafficTypeDiagnostic: SA0PR12MB4352:|SA0PR12MB4352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43525B3648018B1F36BA5A98FDF70@SA0PR12MB4352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(81166006)(2906002)(8936002)(81156014)(8676002)(6666004)(36756003)(44832011)(2616005)(956004)(6486002)(478600001)(66946007)(52116002)(16526019)(7696005)(5660300002)(6916009)(66476007)(316002)(66556008)(26005)(86362001)(4326008)(1076003)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4352;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcUDNiWMtK7XxDMSdJy1SzpPiesceRiP37/7HKyGWbDvxjq3dajhl7EtJ2534KM6vFc/ezvgk+FHgy28sf9htEykwr26xEh+Ru+ZK9uZsO5TsEa1dprdgpPW7AStZDDhNf/SfCim66zoA/LSrN2HJfayviMne+3ZM9U6V7pEI2yFT23NesRvmHkAGhRszk/QZPvdtMqsvsVK+/gERvq9rVRb2Vzdya4ACTJTqM+nY7gPOEkAmKusULiaFMUI7D+wMplZChWjpJtuVSupND+GjjqJbAtRdRkizWsIiauqQ/B7jVgZmcoPVzWph2h9u66uwTCDQr07Jb0NEmn+9EOSBV42stuSVurNfMxsRhRr1OJK3ppynTwRqjhJTmJ+He/LZjIX1Gtqfp8kulujAsUSJOU39ZSkWXPm0X6r9AKYmhiIUoaHbwPho289Sf1xoHbh
X-MS-Exchange-AntiSpam-MessageData: 51gDcOlXCRgxvRSKsnnVt6RMaNFBkJZdqHnCSVt+ljpJRlOk1GX4DHP7rh/ZFbg7w1SKlE5DNFB612ihqPvNhmc+2w3n5cwhOF8cth1hYMC4hO2L+MYoeousg46UuI+u50EWC3rsMpPUxhJe8ebf8A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a53670-155d-4645-6770-08d7cb957356
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 23:38:24.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDwnf8XG2J+JnWX4C4PyY4ZU1azQMygSt6MXV1AMeMA1z/z2jeecBupM6CRYGUmxBQuTkcJ8Iwz1r/47QEu5CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
nbio v7.4 size of ih doorbell range is 64 bit. This requires 2 DWords per register.

[How]
Change ih doorbell size from 2 to 4. This means two Dwords per ring.
Current configuration uses two ih rings.

Change-Id: Iae28c22dd6e650f56286bfa0d9e002a8562fa855
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 149d386590df..263dbb1f92ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -185,7 +185,7 @@ static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
 
 	if (use_doorbell) {
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 2);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 4);
 	} else
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 0);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

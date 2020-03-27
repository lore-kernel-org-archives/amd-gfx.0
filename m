Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAABC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA14B20575
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P5XH0qT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA14B20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A4C6E202;
	Fri, 27 Mar 2020 19:32:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D976EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 19:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyhmipqI+prL8LZULi/vY7paRorQgPbKOV5x89kNztOyXi2TW67RcBNhjj7axWKryMpgPP5RC0HNt8cCObSQMKD29uftzNfrT0SlK7ZbLLFgtQsTJMwjvSAD5g8v9r24wCRcoi9Yj1MuHip7AVaGmVWyWvhiqpBDu7a8ua2OByFC+n+gGiWZ7RBPT2fXK8EbXkr5o8AgY+chJL47Lwx/W8uswQrkQ1G7DyJvaHB7eKBK1ZNi0KFeZf6SnLMIua6XupaLNbazAFnmsDz012oV8oxUukWDB8omBdeemKkppPp2rCbtQN57uqlxB/PA8DWv36ceWcnbq2y279PpGrZhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjXtkxYpXvG7HcgocJotcpFjkE38VvFqOsxIZzxfpLU=;
 b=OgcQxWezpOq3m2eTHSdYzgBhAdf2qXL2N/A+QdOGPjASomks4mgx4BSsXpdcudRFYle36TPaLBX7WNGzoIrQULDyvAFua5q9rltVVd3GVjDQC+NVQyFqIOgE/TPu+en78Is+sdxTAmZtVOdAKdjrtfvP0wIID1qrWsY39hPRKnNI6kDOa4P+oVzaUWwpw0YrAxpw7SyjQxp7oYyxqnzXHo58Dc/0P6CudgjSETznAQYvI8n9WS5gruK6P/4VmdIgLoJl7cJanYDWF/4NRTkBWwDjL9VycSFt9iiCVCd2v+6O82fSxop8K2NkK3hnfQjQJLUpxPjwao8aDAKOpyT7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjXtkxYpXvG7HcgocJotcpFjkE38VvFqOsxIZzxfpLU=;
 b=P5XH0qT0rbAwPQcNbBAVQjvH2DOXYMswg+L38SRYiRsVMQQc5rKTy6Dxic75IEM+1sZMg7xFr2n83E5i50/AH7zNZlvM6u6Tx4MS8DrEoDmaDjbsrATTHkq+CrlKlDp+tno7w8h8EHeMMk7AuDYq2p2f/ba5j6AvyUdToa8TnWo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 19:32:24 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 19:32:24 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: ih doorbell size of range changed for nbio v7.4
Date: Fri, 27 Mar 2020 14:32:11 -0500
Message-Id: <20200327193211.8148-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: DM6PR02CA0109.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::11) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM6PR02CA0109.namprd02.prod.outlook.com (2603:10b6:5:1b4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 19:32:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f4cbba5-9618-42d4-123a-08d7d285935a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4560:|SA0PR12MB4560:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45605493E399D0343683F5B8FDCC0@SA0PR12MB4560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(1076003)(86362001)(6666004)(6916009)(186003)(36756003)(26005)(44832011)(8676002)(7696005)(66946007)(8936002)(4326008)(52116002)(956004)(81166006)(81156014)(16526019)(66556008)(2906002)(2616005)(6486002)(66476007)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4560;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlUcrXQsNumEe3K4Z7o260jHfpUFxTEZ28uWFJdYFpm/pA6nJWwAk7j7+61D29M4l+EuAuva+6iXEh8DqnvSaKufOXRya7wbrWjxy1q8mS6QC6361T/Khrn4aFW3tf5BuknTJVxHT/OB4ZVMyx/UAhqPBLhHUsvZKt9kKxOo9J0fXNl9PgX4PyI/arwtn172Wfu9WyYJ+qcx5bFgDyWxcQF1nnOHSwiOQxQrHo4XQ/Gy5LGQcEdLnai9a/5k48mRtSbTzRq6OWYykTyTW8tnaj0cpkfmPEKuRsOq4jZnE04hq5P1JdkmK1bZFCejO1GiB9tPAxUsXHOY4GflV5iEciF0aKyjetCN5jILoOTmCVxlDkQH8IjHz+58Qq9ggF6/H3j8K+6ktHwlJ0fqucmgC0jO9sYZTGD65lzNhE9cc4k6LEKaVmA2qkOtZ13OKZQL
X-MS-Exchange-AntiSpam-MessageData: cCj4tu1y5KFbfklzJkZN9b5Vr6yu5Nve5fWQHETRTqoXJ6wy0bLVN+Bf5uLogk3c3W7MiUg6l8+N9zna6ENspj1NthXA2r0AA8M2fIEZoXN202NZWODy9ETvnYDJv4dgsGDGfiyjXImv1ZVDRR2Gcw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4cbba5-9618-42d4-123a-08d7d285935a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 19:32:24.3061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ovIAmdNCiVk0CvvAxVDwfMsGC0NaYkM0UzNKjqS/mYlQddNhcbuAHR7D609yXAmid9Jole35FMh8dyH1xmbDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
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

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 41c53c149852..72bdd06ed508 100644
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

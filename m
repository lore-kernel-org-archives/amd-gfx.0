Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7596C4BA2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 22:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66CF21D7E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 22:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CpOqWTHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66CF21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430CB6E092;
	Wed, 26 Feb 2020 22:39:30 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700064.outbound.protection.outlook.com [40.107.70.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7EC6E092
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 22:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S95GLwuJdJ2mGf7/D4EE28fEyZJcHgVhNBuiL8jk6kouIVbTSHOqxWIy7YECdD7+MXmv3cT4NPkS9O5+Ez7fQ9yASl2OCLp7VKQffcnZwgHAAiGz+A+Nee9IWjzSw8hj2nafLiW9NelqMAvujk59142yYmWPmPWtOXKv3r86H6zRmDWJm3eckjNNeNrnUE8Gh1QXiNrw32XsWVHUYUxrd1A1EAxjijuAveEjaPiYgZ/3K4K1letQUHJqDVM1cMfWXpovNrKSpr2ApSF9ZikVn7tO7WpLMFFHx4ki0C55A090JFuciG2YJUyUquPDjAcyylBQbjVDGn8ltknU0iWGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMw7kAsH+7FVb+wuL1HDriKRHhzCwwH/4yp6Y9ikwQg=;
 b=UFgDt3LgsknuZDwrlZEqJQdVN6NDSY4B1Z0sQv8vecIAlsa9kBnnZHcTPo+HMcsczCYXM58rruYH2WTG38hIJPyOtrrUUewVbBwZmun8m52/m2bR5UqxpPCojfBwXvwZRz7JiEZDJrCRjri8jkUgOF0JM5SrnhohnxMkMivySU4iC4L/C2BGb44gkWw5G0N5yg6PoDUAw9xMmtPMEytxmLVNelC6ryOQ1wrIB64GzBGCVtv6Gh7+MfkS7KSTpBtFNGkqvKgcOu7gSxjFO30Q5ixoZAdWf3LRJwYeiyJY7EwMyjXrSX+2omLEKjbkcMWZJ8RTrcvQIsYExv89HEt2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMw7kAsH+7FVb+wuL1HDriKRHhzCwwH/4yp6Y9ikwQg=;
 b=CpOqWTHojGcveVHnWc3UJBkgwBx39wowARS5b0Q6GZ7UWp0tVGekRhx1OBrLYgSxTTK6zXmoZqoRtHrhQBO2KdP69oskqF+rdiqAdBLJ7NsS43LjQHUbmy2LhgSXue5mghlkT6U1Tyh7cxUhOuTvo4OJbJOS9/B7ZhpI7dSWNek=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 26 Feb
 2020 22:39:26 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 22:39:26 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/1] Fixing the GFX hang
Date: Wed, 26 Feb 2020 17:39:02 -0500
Message-Id: <20200226223903.6088-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
In-Reply-To: <c062930f-d9bd-bb7b-e75a-3e5b4e0c7de4@amd.com>
References: <c062930f-d9bd-bb7b-e75a-3e5b4e0c7de4@amd.com>
X-ClientProxiedBy: YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::22) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Wed, 26 Feb 2020 22:39:26 +0000
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dcfc3c6-760c-43d3-217f-08d7bb0cbbf0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:|DM6PR12MB4124:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4124C1F73400404D1DD0D1FF99EA0@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(6666004)(186003)(81166006)(316002)(81156014)(6916009)(5660300002)(478600001)(16526019)(8676002)(26005)(8936002)(66946007)(7696005)(36756003)(86362001)(2616005)(52116002)(44832011)(2906002)(6486002)(1076003)(66556008)(66476007)(54906003)(4744005)(4326008)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4124;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TipDqU3WUYMh+4oLWNW2eqaFpVBgOfj/l5CKV7k4QhZfez2e81Edgn0fZrYFz8Lpy6R8YoXPP5DTgbeIg9M2h2v8Yn+9+XJun7xrGL6TY3HSgwlRRv0rQNZz1hp33kJAVADkMxpiA1yc5cB9maXyAUo8hkJvwsehgyW+z1i+LXYBNmTk7ZD2yHO0R1lXFPJx2mcyxqCYvDPhqvfvZ59rHR7aMdPBEoSXQctaiTdE1sqXoKvqXumLYn2y9+KdmzU1ebecFRZ4MlmGv08v226P8OXcrtHcqJCCaW9OVPFj2N5LOzaBPmuJyHuvu7ReOyusL8BA5Vbg1+SPn+G4ANCXi8fZqzH1HC8tZjabZXMNcuwGlAOorDrwKAIYzhM41Mq7oyzVyNzxxTpyiAwu6M20Cf1rE/fi1wxgUpO8G7TQWzhAAqMCli4QtcmY21Y2T8ps
X-MS-Exchange-AntiSpam-MessageData: xbsTcjYckleh2+r8PbWPoFi+NlYVjRJWZgAmyJX/1hK9CZoGWfrV7OyUX4HA2McU4IZdO8H/2uaRt9L3/Euy30RVU07vq4BZZ09JBp5yeLoVnTv7kX3ryojV49ij8QQRCAWoXpwZQqxM5dK/tEUvhw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcfc3c6-760c-43d3-217f-08d7bb0cbbf0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 22:39:26.6141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUKevZFcyrdOGzdKNwFWNvR4TWGWwM7pfQByv5obyNbP0VFB3I//GqzfVGNijk7F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Huang Rui <ray.huang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I was thinking like something like this, Ray.
It optimizes the body of the loop, and pulls
out invariant conditionals out of the loop,
and a few other optimizations.

Luben Tuikov (1):
  drm/amdgpu: Fix per-IB secure flag GFX hang

 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 87 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 ++--
 4 files changed, 79 insertions(+), 41 deletions(-)

-- 
2.25.1.362.g51ebf55b93

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

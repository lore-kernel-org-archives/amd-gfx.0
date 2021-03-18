Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA84BC433E9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB9A64F10
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB9A64F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032CE6E889;
	Thu, 18 Mar 2021 04:33:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACCD6E090
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCOHlrVxyrXzbDacuXOQAQ/m9j4JLLHbyjRbeGjPRWGVLC5QaMD82OR70ZpNeJhMSYsGmVLjsIkPhpBW3cwkCoRdcszFtHaG9BmPkLJGeHwyjKZaXNMyRBvc8xurbh48D/7nmqDBADNiSAiQKjU6a0CM5/9QNhO9pfVE/P+aTQGAtutCkUbZBJGAfOp4jft+XBEyXDbYt4FXQD++kLa84GhlPoyoQ3VN0lGwHrOKPy8EPhRUovMAN/iijhQerMRgCWvVideO4tl3d9zzH3sfBNlJvslXC25aYClYq2g/yMflGiroMvmGX+K5rhUafMtzVQKumfCl0h9bMGVsXTh71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH+FyWkR3w+J/5ULW1BauK5FNDi1xTY/PDtJY41lBbk=;
 b=iUodaeqrskR9BUAWsWBPG0/Ud+jUfUQbj3RMNBp9lohCX8STAGFpjrWfpoQlsoi7zLnoIJ9nO/z8fB+EpN+1rUB1HEyrLISR1pqB4QpvoY/AmGsN9+XptGjWN5bMbItdp+69S4M6vY74VnvOshQQruREJfg0WFo1Dhw1J+JnXh9ulSvWoiRPnfiXtOGkU1uCZ/gGzrFA8WptPGVbufbzNyUEWXjzEldepvdZ0eiZzJNGfvT0ztHQtAABO2Fo4QF0MPl/oVwqH5+czTMEn7cNkdtZEJwmgd4l1QSxPuA1v9yI9bsFLyc3DPFhssOm/K0eIifqUXEM2Lscy+CWURir4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH+FyWkR3w+J/5ULW1BauK5FNDi1xTY/PDtJY41lBbk=;
 b=D4/JXCI/DfAGa3jdBXJYeFnrS5D5/qWdHDT2xc1S/ow4t4zcb/iv6XvirxQM098HncS3t8cof9E49lak2owtVhJ0ByIwM0EG9Y71ZezUP0MjhNTe3fu+urAd2yX4CVT3HSrqSmdRU6fpXFmRTBUf1mBfcMc0NktCnXbHDxUHggg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:49 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:49 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/13] drm/amdgpu: drop S0ix checks around CG/PG in suspend
Date: Thu, 18 Mar 2021 00:33:22 -0400
Message-Id: <20210318043323.3989-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318043323.3989-1-alexander.deucher@amd.com>
References: <20210318043323.3989-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:33:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbda7249-26a3-41fb-a058-08d8e9c7066a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40168F341479612AE8C5FF7BF7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdonWXHKAC8nvMvtibUkIR9/okml7jkkb9weIj4EvoigS3XjolYOa+yy/LncAUAyq9DcwjJ6LvWud1wF00Ph8qsNc3MH+PnjQMqjkMAEw/dhHxDxcUbEiLuU54UVq3CWJ6DoIR/7ihGvFQNr/9uauWQxjRl3QnMizOdJK1rVKy9z4bpVTVG+K91h1G2QJiKlfxgKKYUm6JsEk6RoBQw/ckLT6wo/zE5R9P48Wib3gDorsU4hep0jgPreWV75RWruLT1rz4GBIAEziII83sw29sTSB6i8LbW574Yumos0FBdGKJWAEfX5R06pBexPs602YFSu36BY6i3Z5xlfGP7r0DM6RXk62PUWxQ+Q5aSXsrs0Xe2klU+xCzO4bRPNs32/ywSkguoFt9NGbID+F/5DH6EJ5N5HHI2dNFr8a4Sl6PKH19+slpBUAuqZpm6IWLIOLki3H717q/c9bH1Wxh06iWzYavUenUiTQC8k1uSNKZoqEVoQuKXPS+/OUcPHlSYejHbi6m3EOgivVSg/bwLnR7fwbROX/KoZYFI9WiFGXYF4NBtCDC947f81/Q1Kp7YC0f8W0bLhG7lmeU3S89nH0nV7dOdZyGRqIAA9ImarxvaO5zF1HSLRPiZF0kNiTIGmTYMmjyFfjFX1fUcypVm65gK5UE+TtHJPhFpQg/fviYchSJBqt1J9X4HnqcyiweUK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(4744005)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6v+WMfK1hst8PhJSOZCEViRdHkx+lQ3SzPDv+J2+r2c5NJ9QhbAAeeUk0YoG?=
 =?us-ascii?Q?68gcbXRbd6Qi0tKrdp1nESM5vnTxhXTylPmOWNph5MloarX7sSMmlyLns/4U?=
 =?us-ascii?Q?eFXnc52/rG4yPO7UPlYkA1+9nTA+sjA2RwDoTuPsbmGlafAArLLAsfz+eLME?=
 =?us-ascii?Q?L4RfXydwH/YcqnqJgWZoLdeUTtPG8q0AU77JgoEWvEgwdEvUOt6AplXfZLhH?=
 =?us-ascii?Q?bdZzVV6ZUf4djq4/9bHSVBLjuRwdBstqe4NdQtceTLUKbw4kmPLE6OkEbJp4?=
 =?us-ascii?Q?YWu7cpMoBB0YV9dJJ2ql42n1aId2l5jt7OzpLnaB3xhLoTCt20EckeAwRa4t?=
 =?us-ascii?Q?/Z/9dXjiwr7PZgY5fm/V/WnOVQiN3TrBeh0WTSB70uSEiN/QpgbhC2YDxqnv?=
 =?us-ascii?Q?y8uY6Y6XXiZd0MPtV7QOcg9gSZZ5aQROEhRYiJIUmIiI+7eCvFQUf8jrLkhN?=
 =?us-ascii?Q?QwtedB/zdNcejwvq/pk9kDlG8mzJ7o8TNNZR9nl5uPx90bhZQd1q8b1id7Kq?=
 =?us-ascii?Q?Wc9nvJay4rLdPqoIWkEyxUGiL94gdE55xLNaYkX55Q9J1QqoatelgZYpycQ7?=
 =?us-ascii?Q?rUtePUfmGlG4UKSwx3CZG5gx9L4qJRKQVFwY/L5k6fQqYNIAu3EkKJ7Z1Ap6?=
 =?us-ascii?Q?Qm1WqWtRicPQKgsxo8PIH4A+d9zBvbvlv4sbFlY/tUBQYqqT1Mep0mifh5+3?=
 =?us-ascii?Q?LerFf6GoNY/jVWW4pSPv/mBI9YLWZp5fZTqTD7A4ovod54FiHTDbUWCzhDK1?=
 =?us-ascii?Q?dF9+YV6ogxJuzy1bcp0c/+xP9uw9IbHZL7NExnqgkodGhMCYzvdv4DVREhLt?=
 =?us-ascii?Q?vVL16fBRq+v9Qu2khDn8L7P3etndy0qbk6KUGXsPh5fdbm2fyMgWlTHi+ist?=
 =?us-ascii?Q?Cc2eyELv3WtHYsJam53+QpKobbPNffGXQSMlYy02XgmiU0v0xS+8BgPbsdwh?=
 =?us-ascii?Q?iW8JHzpnYyU9q7tnn4IbVznxcRSv+pqBuQWBItwIgyafRD5Z3mB3NqW2y+5I?=
 =?us-ascii?Q?mJBgMMAFNWDVd0bYlU3l3wH5d50MOdQkIL8bEFNJbDjmKQc/C4rkQ173vI7q?=
 =?us-ascii?Q?t7VduMUdvU8G5qdfbL2U4cheX42dxxldM1OePpLiMcApb+xS0Hzk+5vNxWmd?=
 =?us-ascii?Q?xVQKqyV7+WB/91Lv4XZ7xNl5mAgOzJ0SvJ0KgoL0aSlT8+/wgOrzPSCcg7xE?=
 =?us-ascii?Q?i8d3aqZVduVZ7vLo8Nz7J0XHg1jhc5VdRQBVo4sLYXqFh+zotoWW82WzcvH6?=
 =?us-ascii?Q?UDnSvv+GgnmlT+LVUOVRm5h1hzwPzo/VncKrnCaFrkaRyNFzEImHQflD+dsh?=
 =?us-ascii?Q?CGQTeq9tndqbUULfWNe6C0be?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbda7249-26a3-41fb-a058-08d8e9c7066a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:48.9544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG9Crlw5/597h5fN1Q07Rx+Ja+UZMAnr08CM/UPzdCdbAQZ8o6Mq7EBwyWwstovkSLLQkEYwpfGqC27F6SHwHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We handle it properly within the CG/PG functions directly
now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index de70a9917db5..965b4f18ddc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2664,10 +2664,8 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (!adev->in_s0ix || amdgpu_in_reset(adev)) {
-		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
-	}
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

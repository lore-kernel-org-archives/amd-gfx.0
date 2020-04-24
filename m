Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC74BC5518A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B9B20774
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g0dXjkKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B9B20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8671C6EA8B;
	Fri, 24 Apr 2020 08:06:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52C96EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 08:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfVa8hlWqfCqzP6f9EV2zms84cOz1Qqr87OJVbRgCosUxy5ZmJYOxI/rK1suqg97jfR8lpzIqK04+JkpI1YRiSI330ZP2xu6b9kdcXOPIR7lFtRlbJFuU3fdR8yve2Bs23kOUrcZ3utWozLdetHFCJUKGT31FNkFZESB3X+dZHlrik+3FTIqS2+ZAzUW6RCexDoyi3WyL31l2/dc81iaT/3m/2uvKaac2mPmGWj5Y8t5d+ySuqPqYjOJbeVsnixpLfOQ7TS8kzyg9bR8zKJIZZ39JHPrMK9HNQ6ZNAVdhbXeGjt/cNmrVMo7JhD9Ou4ctn/f7935gCee1XEiplZj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+s2Ccs99rVhO1FbyKjVHGoOqhJ0vHVDSUdZ4TGh/Qk=;
 b=H9LcGfIqcmdMzoWI4Hr4d8zj7HNjx/pYC9eIz5cdB6SuRYzmE1AKDhXIRZDhYcg1wK+Tdon3e7lc3H9IOjtuM1OgP4nnBAb9ZpFY2dd8nc7eTLsYsmKdWS+pGxiL1paxvUMWi771xPF2Nf2pAJ6Ax1o1Ugb2Em/NuoF5ICcWltmrDTuDhwQmyN0W7VrLd6qHGBu59lHs/2FPF95fhbSXaDQXuqIixKJwq3EFQPJGr1JKCyORxXmDUeQnP32wL0blXoo77/rV7DSndRqdyIweoFkkRnMJLFN4OE7YsBbOAk4G4vWyh9vovA5SiDzaTrDGZlgVOrQnFAH2NWE7DQvGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+s2Ccs99rVhO1FbyKjVHGoOqhJ0vHVDSUdZ4TGh/Qk=;
 b=g0dXjkKx9eWGPK6nIqkGC1u9NXqfBCMiK3LFUxQUv7rJ3AGMqNxrxiFpBMeD0k8QG5HhAD86ApCNNnw5Qo6Cka/bP1cr94H4j+szlamoHk3+gQmTSdmBmcPwgsZrXe84Icxe2gnSzr0YiROUD7dSBM8Wb3ZmtXxc8fuKlp+mcBg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Fri, 24 Apr 2020 08:06:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 08:06:12 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drma/dmgpu: drop redundant cg/pg ungate on runpm enter
Date: Fri, 24 Apr 2020 16:05:47 +0800
Message-Id: <20200424080547.25599-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424080547.25599-1-evan.quan@amd.com>
References: <20200424080547.25599-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0004.apcprd04.prod.outlook.com (2603:1096:203:d0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 08:06:10 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ea046f5-b755-4487-7db7-08d7e8265aa9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2890:|DM6PR12MB2890:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2890D38BD024A057574A8BBBE4D00@DM6PR12MB2890.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(4326008)(6486002)(5660300002)(6916009)(1076003)(4744005)(2906002)(6666004)(26005)(956004)(2616005)(66556008)(16526019)(66476007)(86362001)(316002)(186003)(36756003)(7696005)(52116002)(8676002)(81156014)(8936002)(44832011)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Dn97HfFjcw1y6obe/+yMjUZWHU7hVQPpmymaly9ljefoPDDBQas79/DEcA70w8waVW4OzjgfOOZC777GqwG+fwmYPkecmTIzSVxFlkg7rYA2W6/73MFD6awAZdn0WPS4qDYt/8yKYNU1VngF88Y946WbvXn+ZvATM66sceRb7vh+LL9+UkdRtxGCsBcNdDNKVE9jl5zpm5CUl7X+v6koh6kj51emyu+N3suJpC5LfTpJHCzFNGmhU8+fYThaVbXbrHzcoU8cFk8N9WUB5ax4M8YYz5qalE9CjJpbAMP4+lNt5bcrskufhRovnb5hwbswQxOZvVpztSx9DRV5kv/19JFxKS1rgFlZyjmc0VTyruoqQLmc+h+cLYYyJtQL3i5ysJTYIeDP+I9swlun3QqLJo8O/bMPxZvfH5RDsg1CiGogZAWgxoRnM883ZnLAS9Y
X-MS-Exchange-AntiSpam-MessageData: QzK4cxWE6IKOa2ilWk8GhmWTWD0vP3GQFFzUfRyvc/z/0OCsdqwNJo0sO/ygpVyqJ9q7ETQbCWsiL3/+ymTUrIlj7MmvbvUdzOI26ZMZxz3q1YuAiqrhfs02pgqep/hQZHWyON27Pr+Dw0ouwM9u7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea046f5-b755-4487-7db7-08d7e8265aa9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 08:06:12.8250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJazeCCWxGB6z5tVsbMe1mFDwC4LhRgy2lI71NKsmMtLah3iwoY88io2Kt4q72tA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, prike.liang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CG/PG ungate is already performed in ip_suspend_phase1. Otherwise,
the CG/PG ungate will be performed twice. That will cause gfxoff
disablement is performed twice also on runpm enter while gfxoff
enablemnt once on rump exit. That will put gfxoff into disabled
state.

Change-Id: I489ca456770d3fe482b685f132400202467f712b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 08eeb0d2c149..71278942f9f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3453,9 +3453,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		}
 	}
 
-	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
-
 	amdgpu_ras_suspend(adev);
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

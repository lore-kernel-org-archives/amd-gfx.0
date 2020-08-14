Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03CDC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 04:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCA920708
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 04:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vdeqSItq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCA920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65EC86E2D1;
	Fri, 14 Aug 2020 04:22:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972F16E2D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 04:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/uqES1HUxIBBcaUHOQSJF0sHgLeeU/Y2yjR8+iZLaeVA1DvGuu/hSWPeEg1hRU1+g9qgtEYmbzMw6uVKfzojrQWct4xI0dOPIeIf1cc464zaxlvkWhtJRws8PdG/nniRoLNlKlbEbYmcSDho/b6q5sd0ttrn6JA+rjBM75EOEyc0M9ydEgjnMGSXg+pY162D0oY+d1Dds3oMP3JV9REnIk/27S131GQ29lDG12FO23N0SN9oNstfxxDf4JBSVNjlon6/VJO08AONswGYxmgz+UndSMZLPM/mGxSxO4Pm5U2IvJ1YdZJv5KvkAaoLKdfbi1lKS4TJdj6AYeBa/aURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqtmBp/5rR0rCLU+uTYBZuidrj5Qbr7KmKJb1ra4/rw=;
 b=fYfWmYVO4w+MFe6r65yaYXmlE4xKkoxVtat9l+cAxuGb5wKBf1R+JhOE/a4oUbjxA6Mhn/nbQJGwSzQPDhblMZx69B0eSmZrdWeKQKkKC1MADBuZLV80llJI6KsZQEcekM8Qnlq2CF5b7fTAlkLoJyHfncr59hLw7fvTxaACXhs/TtKXjbWd95RniwvDEndDpuIMAg5LyYk4u0E13oDoQjceysYKwAVqfCP2xpkS8/rbRRCmKqy7sN6IdkhNsgZZ2vHiYhb0bO1BV9Pp44+JPVnkBPPVX+l+R4yPe9/Pzj4dP8xqZplELgqLHU7/+Ecqn3cP/18/HwWBvBDfy9rLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqtmBp/5rR0rCLU+uTYBZuidrj5Qbr7KmKJb1ra4/rw=;
 b=vdeqSItqi4RVvfABHusAzt9P0ApJY6qSnoagkNjNFMwBT7WxTYqTptR/aYQLeSOChCZiF6eJE6CieZ0aXjnh9s50z0rlTOjDb93otW4sWkNKFC0r/aFUxZFrzqJMF8z/4wMmI457jq1yytof7eD8Z5ViL+4l7wXFP5/KNJtkCl4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (20.176.117.82) by
 DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Fri, 14 Aug 2020 04:21:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 04:21:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: suppress the kernel test robot warning
Date: Fri, 14 Aug 2020 12:21:26 +0800
Message-Id: <20200814042126.6104-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 04:21:51 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd7aff51-b5f7-4cfb-cf60-08d840099243
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1163C8FBDC8E2213A43FE7CEE4400@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8B56fOgzIK8rKnRhJX2LSi9iYYjpuyEouEOyqeyHxNsGj0Y+tK/DpomqnpO324K8NcKeZTlwM1LURtgp10SeiwbftzWf+PI3Lyy8Ch2h7uM71HI1o348U/lnPMVqHiM2u7sPP9bap9O5EJ6Ifl0HAzzTNu9+6Ngk3AdrGNnu7T+Os3wCr4peM0Hy1Cf+AbVaaq/ZSv9IAMUfbb95n1PO6FxB2ZN+srOZjU0BxciG+beIf6WvB0DOTGQeDXP+y2bMKv/BxKNLn4rTu1vH80km70dCSC510+xalZVPpfhq440eh0zFUVhM5Cl5HRAbyMlFTGxLoutjHTGGfsmJxHnbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(186003)(52116002)(7696005)(26005)(1076003)(8676002)(6666004)(8936002)(44832011)(2906002)(5660300002)(86362001)(16526019)(478600001)(66946007)(83380400001)(4326008)(36756003)(956004)(316002)(2616005)(66476007)(54906003)(66556008)(6916009)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ry9FkC0bhh/o4BEgE3PYcRWSp3+sZxJyOIFfGS/lo+U5kjJO9bBuL/dyR9B88PrSD+GuosPBCA+fhvBPi6X6Q1u/nXlandz7yWf2Rt3JrcI5leDeXmboD7zUxLGm8VO3lNIGIlQzkBhC11Ff/Qyj7HAnDHTfYtILa6jSmxo7BpsjX0PPLpTQMBN0vLJNJXJpVEOHW1n45Ons1LHOR/4YwqZqexYA+apAPynklKTfZg285j2yLFq8xDN/5kCb8EVWO4Zy0CoW75IM2o6p7ZxS21FAJRU0BqjPw8CXOHXGTNuO5n59xc1Gs9+wZXVK6R0wItDxs0/RinBvQavilREbOZfWx6zoYp3rboolt9gX+Sd8uptXOVdYizauDufMsCVWJ/aA8BFas6KXOzdCThNauQ74iJ1xqWptKLlClXDXintgR0E9VvyEsPuUPNT88Yu36jkGDdkz03e7wo5pU3iw0SeXuqCAK0/dmTCn85Q/IUMX/1Fiolg1BuFFV6LxQs+C63iUvOmZomnnrYIlsvpZrifMOdDrTbW6zbo6hRyH6Mv9KVyYa/cNDbUn8MaLlmouqO1xddez4YpyhLWFHogmxn+OvByN3wCnHyPk7JFF4MCgNIt+bE39JIic4vhKbF/jjTHF08JBSqkUWUMVFJGyAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7aff51-b5f7-4cfb-cf60-08d840099243
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 04:21:52.9294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLcR2A8cf59IU1l4YPqI9Blp5UKC/wwm34v8tkWzaJtYnozzDDhwzMvbaXcH3ZcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suppress the warning below:
   In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smu_cmn.c:
>> drivers/gpu/drm/amd/powerplay/smu_cmn.c:485:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/smu_cmn.c:477:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/smu_cmn.c:485:9: note: second condition
    return ret;
           ^

Change-Id: I4b512008b8fe410fc7974e0483c39206ebec08ca
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/powerplay/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index 968b734baac0..a58ea08cd115 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -604,7 +604,7 @@ int smu_cmn_update_table(struct smu_context *smu,
 		memcpy(table_data, table->cpu_addr, table_size);
 	}
 
-	return ret;
+	return 0;
 }
 
 int smu_cmn_write_watermarks_table(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

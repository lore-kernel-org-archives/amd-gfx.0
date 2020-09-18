Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF682C43466
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 02:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2707123730
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 02:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hDK9OFXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2707123730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827306EC90;
	Fri, 18 Sep 2020 02:36:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7A06EC91
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 02:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtvpfafAX7g9WtWqjURk8LcUX4dG+lJTTgzm2Ib16COvlnsH2YWwjo6f6HbANuqb95G4y046w/RWA+6/RrVec1Tw13M8mW5Zd7FGjrfoppHGv4n3u/6ZYOeoJGQX+anGbvnsoDLlzRT8x5VaPvDFtIH+FdPtQCOJCYHJOH6MQHT2se8i8+bFJgWci60cMCxDj6eCrMc5JUvfVhy3SCKumNFtuy3sLsfcBuQav1cSDNseDD6k6q5HJ36FCox+LT0a/ffk3EIP2rlv0fng2oZKw+A7OM8XNLi/zz7aGW1usONx4Xp94CGIiPmzn9Ovh9oZNw/cJflX7hsHNyoDzXXW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlJUwk/8tnW9uOxUnS639fbcx5r1bFa+YRU2OT6JQv4=;
 b=MU6p51dOgSxT4qKzGIXxWkqErDteMlPfY58Fe0c3R7DEBSCm/ePb1BJNZ44G6xC9OtRO6Vg/7KR9JdQTr2To0ZijeRDP+XI9u+4x7AIrb5nyHhI8dIVIrm7p7AIi+a+wWGgqYDVR5mOWSYLOSXvYp8uzCk/ghMzNL3HbQ8SfZ2MIU8Byd0Qoe8SWHJmex2zNVG88p9yfRaegxfeDjbBA/Q2JZ4FTZGhcAKykDkW0P7Ihr5F7vDZ0o3tYl1Ac8KByPXZrItOBwNP0/Dcn2FT1EB8LT/7fA1yY4oaeZAq/Y50WbfhQJL0+YE2i5Yl2Qup5AXByGbzSBWUlJ5Zum5rCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlJUwk/8tnW9uOxUnS639fbcx5r1bFa+YRU2OT6JQv4=;
 b=hDK9OFXpumpHgRHyWGcW2Na4dJdGICSVlda1+PgG4XFruCyedKkdoJPiFWNDFXbSrGVPHmzJhm4xyCOnwJ10DLA9o3sYSWT1Gsz3t2kMlCn7tXtnYcnPm1+98Ffc0xewyJUsaf4/t+3Vv7nUmgZh23wAZokOonv8Mi2/SHur3IQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3867.namprd12.prod.outlook.com (2603:10b6:5:1cf::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Fri, 18 Sep 2020 02:36:34 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 02:36:34 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: apply dummy reads workaround for CDR enabled only
Date: Fri, 18 Sep 2020 10:36:13 +0800
Message-Id: <20200918023613.456-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 02:36:32 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b36102c-e6b5-47dc-88a0-08d85b7ba88f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB386726DF48D5FAE486C77A2EE43F0@DM6PR12MB3867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dn84WKiT5Y5xRAd7FrlLjlSdBX0MVXYmR7Ri61943dihwUStmGf6jYFeUfzApBtMKrp7/1mn905jFiFau5MU+5S16f//ifdZ8dcAaQIB4b0iZAAHDj3WfFqGjJ0RUbaw8RjA0EGQkmBrAPGJS5BsoDd7HBKYClsD0ctpT2VxmioIlGL678mAPUfNa77xKIKSCn0aPSqtZPun1D+C3+OSGWpevaJWSDm9pV30plds1DldJd8cybbiYnNfhR/A3OHgLD+aDXQ2J6D1O0WDnJHjFtY0D154HtWCm7+2S0BW+kYR0RevWlu4c5fy1+5sLOJvH27Wi+mOdTjnKzvNy5GVkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(6666004)(16526019)(8936002)(316002)(2906002)(52116002)(7696005)(83380400001)(186003)(8676002)(86362001)(36756003)(1076003)(5660300002)(66946007)(2616005)(6916009)(44832011)(26005)(4326008)(66476007)(6486002)(66556008)(478600001)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ux2ya70/PE/YbugfM5s0pV8LiETm4VDlisZ+q5UFbOW/qe3/G70iVhr3kdqSRPbSEv094Ct5OCN3POQ0rBbiDn+Ayuaf3eiqgLOa4AwXrKJJX6tLm18blzn06NUQgxziDnyvibYUyKNBA7REPRvD1fiexkAG66UdHBR5iXix0pr3Y55t1SnXytpdu42+wlbR2nmH/J/yTOLJ+au23cwej/Je9GCpRjnv6Gjrx8pK8hypEhPcNPFw74MrIsdbOBd7bnvthiM0NIkkPssYKjU52FpRbHL97984MGHNyhe6gizdCz6eRmriWS1xUJnkGcPCf30RHG6TtMu2hYn+0incyBGIEmuPDxus0X9Qek4olfxWXFytDuwY0ZVTaBA6qzq/3iXqMLw0K/GsowPLWKMqtwz+8DG8R+IPhq3aZabJrBYopAKO3p/qGxowvGuK0l3sTU5jUZr2f330rDRfvgsKYCOgBN/lMVPDBxyRpOGmPnznzBZT+d5Hh90Y40gYdfSzfeYMttRA+9DIvs3ik8F5Fqb+b5RoZ9dMp0rq/wl4Llfmil+UarT0udnyQInvpbZhUeY593n7awVj/0j4CFvD3APN5vsJiIlyRXF2hcENGlEJZGPWuYTr3OdxuMytxz7tUfqyH8PHKjKDAFRZpUm5Yw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b36102c-e6b5-47dc-88a0-08d85b7ba88f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 02:36:34.4536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2xZCqzkBAjywZJjO8p8gmKTo8eqUEgiG/qFWRHq9TjJcLvjELoJH1+jRce1CP/0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3867
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For CDR disabled case, the dummy reads workaround is not needed.

Change-Id: I474619b3d82792151870811c289ab311028de211
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 338a9fdeef6e..5b87690c1e61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2303,10 +2303,12 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 		if (umc_fw_greater_than_v136)
 			return 0;
 
-		if (umc_fw_disable_cdr && adev->asic_type == CHIP_NAVI10)
-			return navi10_umc_hybrid_cdr_workaround(smu);
-		else
+		if (umc_fw_disable_cdr) {
+			if (adev->asic_type == CHIP_NAVI10)
+				return navi10_umc_hybrid_cdr_workaround(smu);
+		} else {
 			return navi10_set_dummy_pstates_table_location(smu);
+		}
 	} else {
 		if (adev->asic_type == CHIP_NAVI10)
 			return navi10_umc_hybrid_cdr_workaround(smu);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

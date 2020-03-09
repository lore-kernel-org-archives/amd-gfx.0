Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E084C10F27
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 18:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791B520828
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 18:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rOaoFSye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791B520828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 318798914B;
	Mon,  9 Mar 2020 18:25:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EBCE8914B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 18:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/AGZVCiezUT/h6GxMvKLr1dYkskG3pKorPpJEFWcdgGKK0951KJmy1xRI8yqyZWB+wiUA3RFWwP7aKrsNc/4+6bdjmWfks4j8eP/n0wnf0hLZoJdU4pp2dc2yxfn4QPhECwH11HrSiZjwo+c5RwN/nwEqitjP4N3f7rXGc0Fb+rcet1r07WaY7arrWtNTufP1dNZqco+1H3hprkjz/8VFTwenpYqYjtmiZNpKXqrxjHevO51B5LfVR9CWQmvGVn/UZR9MdiFK8nbi0OokH2gBjDmyamQ+Zhh27VHuJAkyC26wT7Rg+NGlYMKgveTSaanjOiZZ0V7uMuzBE0yz+iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/GTnNZAbucBiM8AzcwPzpv1RNGZA2ztO5CcZkMDByU=;
 b=bg5V2f246cfN88wrnarfawhHLEvDUhR1vzbJ0phUElRlU/yQxf7ODD01v13ux3bD6c6gkZG93CgW8PyPPJuwK1yy6VVDk2HmHlK4m7fArO1bJfL9elV+gZCm9fOBUJwfpKUk7Qz5QSI0fpprdurjZ1BaNLr3vo/mow3HxPKmfRDFuTWMkztdBCFjn6wjtZBj5mTKRfsjLXuftIkEUa2NpnGGgo65O9JBSHHafCKoLiy+kOppF/3K4E11cksDxc3c8f7fAbs+HXHWUVr28OmGjkKJfAvR1MKXGbJ/ZO3GrhjSBVlL7VspfEMJnFFfZVaY/EaM1NMDuOlpY0D9/+4/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/GTnNZAbucBiM8AzcwPzpv1RNGZA2ztO5CcZkMDByU=;
 b=rOaoFSyerRPgK6Yal8a6oXPUCErdL0VGNdhECMC7zdVGp9AesTtt/cfJAyspNn4njMTqnQCeqD22T++qyyKuvaRifXTI9UgX84PR94miHaVVekESWn2ptF3SIf8l5v/NlvFVVK5GNrcOS8LUPptBRais2SD3oasaSrS4ch2gFbI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 18:25:23 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4%4]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 18:25:23 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Use pr_debug to print the message of reaching
 event limit
Date: Mon,  9 Mar 2020 14:25:11 -0400
Message-Id: <20200309182511.25716-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::41) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Mon, 9 Mar 2020 18:25:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a7d5c9b-3c66-43cf-bc87-08d7c4573b60
X-MS-TrafficTypeDiagnostic: CH2PR12MB4119:|CH2PR12MB4119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB41196661370215D9E1743E8EF0FE0@CH2PR12MB4119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(199004)(189003)(2906002)(956004)(2616005)(5660300002)(6916009)(26005)(186003)(1076003)(16526019)(7696005)(4326008)(4744005)(52116002)(478600001)(81166006)(8936002)(6666004)(86362001)(81156014)(66556008)(66946007)(316002)(36756003)(15650500001)(6486002)(66476007)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4119;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCy2FQ6+u3xChqbFK7DDslV9M3jmd3rQIxLQfM+atq7hHaPFM9c5fT0P0pGwszwIMoNXNHpH4BQlI7x5RIvRrf2/QY9A0AcphIDd7fDjtqDjN4Uw/ypUfgTGMNtjqUxzPN7Sdzv9vXlBqTQC+QGe8GomFNSiObZmI1P0LSvwCo0XPxqZQV2aR9yi8C3o1VAFb1uGSLygjWbmWPrVlRLAbgP1SG0dCovnOESfoi8Y9ELrLXjY6l6WwCDIzKXfS1D4VfAgYVIkjZo33JM4nXhNtA3GNws+TUomsCjRK1FCNKm5zLyxQ7N83pmEu1SFFaucqUuH3/eLXYuFMOD1SaMDqbwPjORIrMXure/9wYt9WHCVdVpbcpReF1b2tEzID3YZhV7k5kUADWFr4FOup+cnTqL8VJOYJJoeEdhk+uVvpwxQPROuGOHkAIzp2ssry/uX
X-MS-Exchange-AntiSpam-MessageData: gi7NeWQGoHtBkGeZj3oBKxEZz22aCRcjIBvC091sNf4ZVb4rujVdj7tWYLnFGVtmh8tpiidLBfwLCqMx2y3v8SJclDp1HZScIMsqncXiz8y5epYq9NugtYCdzxT9DH4rplaIjd/grDNHXeqI52HADA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7d5c9b-3c66-43cf-bc87-08d7c4573b60
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 18:25:23.5677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFqgHeNSXRzX2gP2vuxUG8CVNaZNsElMsLrVWZH5vUeb0EsQnFIbhpirpn/XQF/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

People are inclined to think of the previous pr_warn message as an
error, so use pre_debug instead.

Change-Id: I3ac565a2bd3b8d57345812104c872183898d237f
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 1f8365575b12..15476fca8fa6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -187,7 +187,7 @@ static int create_signal_event(struct file *devkfd,
 	if (p->signal_mapped_size &&
 	    p->signal_event_count == p->signal_mapped_size / 8) {
 		if (!p->signal_event_limit_reached) {
-			pr_warn("Signal event wasn't created because limit was reached\n");
+			pr_debug("Signal event wasn't created because limit was reached\n");
 			p->signal_event_limit_reached = true;
 		}
 		return -ENOSPC;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E14C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 10:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCECF20774
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 10:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d2F/SA5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCECF20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8509F6E083;
	Tue, 30 Jun 2020 10:31:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8B96E071
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 10:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLf04hN+wW00e/OCjJ8cPu8lX9x+506FsSnYZbGw2kW5bFBKu9FuB1arGdJIx20UCrEF0tGb3r9g6EE1dxhPyrUdQy0KEihee2A1PCjaEtQTKHT7/6dRmspJyYXpwXknRbavKr9rzknM1dC0avuyKfr/VKQdgGBgYUivVE5N3Is69mMoXN+dxYhvjQ39F5iuX3T2ronwctEVbTaHJM5PKRSU287rysJEW9aY1FG2/2KSL/RncjkFnPv7AhqNUyTIr9XBQI7PN6JG+8j8XoCQT/8vjaUUvrUo0TF4Hwkw6FvMPC5EkGDGmxA3A2gIQUqKi2He12ykaxCQWz5YntKZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfhKm78FTxvM+9sHLYwXuZYPM1QIpAfFREEq87JmmtY=;
 b=C9W+2NlrTIz/RSa9GKALaHXTBmGsDNVNEuETxZd4RKrSGu+VQT+H1hfXuwuYsTVlFmf+j+Qu63TMmsa2rksNnjpdsgu2oorKgJGquFdNUSE2WDHXP8+KhOO3cW6whyhmJL27zgfWrmx9b/OlupufaJlylOIZiQfKe2NGUFbnh6QRrx1Ogv4mxvhBbNSe9XZnz8bxHu7tMtyCdZIx6aYIzJKXV3NZK39bqVcXpZqOz/CAOKaMDcpg6okxkYd2p3PRuBY3tsyZUrGXymZQQcOTCy6/+5sEE1f3JEa2qtY4sqiM0vErnlIzI9KMyB8ctEc5VG4YBfPZZ+etyRNlelZ8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfhKm78FTxvM+9sHLYwXuZYPM1QIpAfFREEq87JmmtY=;
 b=d2F/SA5PLY0zA7SvbKb6cILdCREXv79jAE0oYLRcn3EC9PM2Lu+Sx7HM83iYu263kGK9Yt8iwe2CY/caq9Dg76zxZC4gruxB3zM4kM3RKqmM45JNyTioT7GqeE/+J0a4jgVU32CE4p/wO2N+D5Dh6/6USwKWa4FzjoNRWaAPVPI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19)
 by DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 10:31:45 +0000
Received: from DM6PR12MB3770.namprd12.prod.outlook.com
 ([fe80::20e2:909d:12d:3d23]) by DM6PR12MB3770.namprd12.prod.outlook.com
 ([fe80::20e2:909d:12d:3d23%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 10:31:45 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: asd function needs to be unloaded in suspend
 phase
Date: Tue, 30 Jun 2020 18:30:50 +0800
Message-Id: <20200630103051.1206401-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To DM6PR12MB3770.namprd12.prod.outlook.com
 (2603:10b6:5:1c4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR0401CA0021.apcprd04.prod.outlook.com (2603:1096:202:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Tue, 30 Jun 2020 10:31:43 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18d1569a-e24c-4021-abd0-08d81ce0c926
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2795020FFDBA6473CEE310E1EC6F0@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1W3vh6yTFd+DjfykhF3M4u09pCMlSCJwPEPMDckSMfWWLXaYVWVwrKVeHaYbQ35XPL22BjbaXUjI6peFgzsqabA77b8VYS4qO5TLzwmHaqV0wG1KmNf5gLG4kyo46TYYO9w2pMzyixqWnB3TS1h6SKiHDw0NOtwcNWfHkAcHNZUiOwlUNj6LAP3hbXNkx+JbyHCxiNNY2YPKIa1dMAg5ElLAym8PDrPSQaC5Yv0LnXIiB/pOEPJg9xK9ozXDFfgeoxY9JhJSIZf1Z0mjJM8e+P8xGwIP14FR2NKBHaLkbBnPMqpCQO0eoBIjuI7nYcdNXCiYAycsuH9bXYoUmMPpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(52116002)(7696005)(6666004)(6916009)(4744005)(8936002)(5660300002)(478600001)(86362001)(2906002)(8676002)(15650500001)(2616005)(83380400001)(26005)(1076003)(186003)(956004)(316002)(36756003)(16526019)(6486002)(66946007)(66556008)(66476007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VyVhivWBDfNz4QmOiItLk/YHM3LMXGbkWXIwih8K1121a7+mKy03+VpzKtgK5h0H7IvMM4fiCinZXh4u5No5ddwgSwWpvFtklu0FCtQrK2psF89O/IixOLc6sQAgXkKePBXPi+68XQbLIiqLm31t8yju2Dp8CGAz2OVkRlg7PVocEaClw71YKZzyMzstr4+iYe14mNg8btS6/mCemiefgoANgGroNSQbAqYjFj+MulmSEDpMEqprwWsrGtzhMMcvThHPNRT0KL/snf0gW/GQd/LdemyNfkdm7x2+bUPsZNIXQJThdJlzpUc93/WwjyDIeHl6OJXY/tkB0J1vc1WfCIg1iL+/+sJXfL38THApqpN68OVNNaI8d0s/fbCYsnQfxEbqcs8+EJRxdiTVgLctYTI9dRKx+0rgkW5qhO+Yz6Vhp64tTAEnAHZnuYAHR9PBAFuRgl9wV83bVSxN1FIZx/7gJH1IoBihZJCHIwUxC4mc42TVKnhi+yaM5+tqYftH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d1569a-e24c-4021-abd0-08d81ce0c926
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 10:31:45.1328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxy37mwgiFevmT/Of/OLf0/5cVBsYGGETlM+EwAs9wF+3Sk/0j2qUVglKOny8oJ2j00O00M+90P3JYnXHy44Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unload ASD function in suspend phase.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9342a9e8cadf..e57a53d5ca96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1933,6 +1933,12 @@ static int psp_suspend(void *handle)
 		}
 	}
 
+	ret = psp_asd_unload(psp);
+	if (ret) {
+		DRM_ERROR("Failed to unload asd\n");
+		return ret;
+	}
+
 	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
 	if (ret) {
 		DRM_ERROR("PSP ring stop failed\n");
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

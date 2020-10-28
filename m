Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A12C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 02:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C13222384
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 02:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z37c/o+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C13222384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C016E44A;
	Wed, 28 Oct 2020 02:46:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81B66E44A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 02:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqEx41OlWi60LDLTAvh3sNQRkl/saOjQ+9S7fkbtrs48lh5hfoGYBJAHFuCJve466A0t7Rc4o2CLx+WwzC+xnPjn0t1xF0reRatdwBPH8OC1vMpMbdsGt5Ofj0dTXaRckvdxhDVyM50XfFllnFqX/fbJfA8thhYtLTiTn09T9J08qij9d3LFhdRZp4r5viLHppAMO0zQiJyrPYcuCQ+owJ1arSQx76a7dEXCG/9/MjYTGaX/ii0yVKbdfzvSiO6sKzzbsUDPNXHaPt8GNsorRj3XkPSiJbiPnqkkNGcg8l8HBa192IyQHi0NQn4+RQu1oScxUyerCxA5xbDpH1u6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/1uWgUn21MaTgWUffRukuJGsTwpFyYRkodT3GR2ilw=;
 b=QJ+IInm/bYy3o42vJbycjgVDSAs29IhKNlwlxjUH849GO1ukFr+RwdHwtjLwElt5Ju8kj5o12KlqyxHwTw7aW92XZZCp+c5khs9M8enuYQLoNXiniXu2WuXNsw1Zjmt7YafCSxhD5yQP+HXJOuBD5VjXWYMDExvTedB1amhHPt57vpQLUjTTvlZdLpOkx+pWK784XY54rN3wqsoowhfzQb8L9kwSNLFxYM7RHS6DATigpPMzXGurzdt/bnhOhC2g6TqRVAAkQlEtplmrLRu0nVhNrXP5zckbuZ6aGjgzZ4T6V5y+6t5wrTTrTVJNCrTKRiIo3EYHmovczcMqI7kfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/1uWgUn21MaTgWUffRukuJGsTwpFyYRkodT3GR2ilw=;
 b=Z37c/o+j7tdISTiUVrxXH390fLGcvv+KimzoI0csnqvyNbaxYqNbx0bX2NTGk6AkezT/yJV0NjlK7gnVtVaUMCfVpT/1313IyCcpmbDuF9gFUVdyOR2K4ETHQoblh/1QxdEvJXMtTvHzQvQcIhAMdRoKLp7TwD7bZy0M5uDAy+k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 28 Oct 2020 02:46:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 02:46:03 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: fix compile warning about missing prototype
 for function
Date: Wed, 28 Oct 2020 10:45:40 +0800
Message-Id: <20201028024541.1164776-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 02:46:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0616151a-742e-4729-40ee-08d87aeb9c34
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02208CA6C2C608E4A244D73AE4170@DM5PR1201MB0220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bmY/dJaAS2SD3si2rlwUyqymjmO+lBUg3hURI8ArvQx101iSX4fbLEMCPk7ryxzCXIq4XkqtQ73aNzTma37TrQ3n+yXNjRDt9H/DbHE51xzGBN8pxCSCplfES+WXX0bIQSDqGXqMO0dBaPmcrp14/Toe2UVKIHQH+w5TK3bJvipGHMPjbOv1+AhZ9SPSuDrDbO45dZ/pkA4zuYWzSg1o/9b1i7lCbAdCz61/lI6YJvaRPaHGNHp0eqmXOFm+5Vpri2q/pL7cWkU9I1U1tNp4RTpTPG+6ynue1rpb+CG+GFgGE4rZZPqsTUNjJluCn0U/aLUY4VwmiLsuCBPDqqWvpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(186003)(478600001)(54906003)(2906002)(2616005)(6486002)(1076003)(8936002)(8676002)(36756003)(86362001)(83380400001)(956004)(66946007)(44832011)(6916009)(66476007)(6666004)(316002)(26005)(16526019)(7696005)(66556008)(52116002)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 53adwveKrND4ObXHm/zQJHhA+7IoSB5wAOhze1YAi8amU3pCZ4NTO9RVMfs032RbsGyZkbg3XUpfRMGPiz9EwYGVkZlOmovr9gdFDXgVERAIRzPt90hatGMRbB2SZko27zC0CteOBn0NpqU7T6zR1STFbLnZz4csr79jlLcF8kgqgGvFvHMzFajt74E3zg1+B6CuEFrsEXb2qm3qisXsadTF2Fm0GvLY3fXX0+UCOnzdK8tJHhofyKJsFQmEVc86PnjLy+KnFIqdOU8YJcI6Kek5VIjd7SQiw3eYUXAwc/aoFI7KKvPsbJImec3KN4JjND9vlmoKtrGhpo1zHgDwG92Za8QZGUvtzmtfUDUsdCI/PzDWPScEH0OW6sCL/zvfkmnmSyaKPVMMFdH/Hh8X8eKj+uFN+lWcEl/F3nXxWHU5YMQyBs1iXV/iaGGf56yI/kr6P1+q47+UAkQ7HD1EfoM6ZJc60cp068TQEPcsC8vlsrQJ4QyGuD92jLV+aFehc5VACxGzdQLqpcfJp4JGqYQSG/Y7XNmC10KABs7FJmPZQT+e+n0q8e3ci7nHLq/l5paeBex+jwtKxcW/9ikYu73W64OryuHudA7hwAwPTuvmZ+L5WMK2zCYSLUelrj4qCXAkabvO43B/ns1DAfd+8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0616151a-742e-4729-40ee-08d87aeb9c34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 02:46:03.2346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htzjtgf0U4uyqLi0VZBwxlhuBh1c8fTs8rHU7o8GZL5iXZavsRhUidkhB0okLs5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the warning below:
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1234:29: warning: no previous prototype for function 'asic_internal_ss_get_ss_table' [-Wmissing-prototypes]
   ATOM_ASIC_INTERNAL_SS_INFO *asic_internal_ss_get_ss_table(void *device)
                               ^
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1234:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   ATOM_ASIC_INTERNAL_SS_INFO *asic_internal_ss_get_ss_table(void *device)
   ^
   static
   1 warning generated.

Change-Id: Ib4f252d0103fc10f7a89b495d9e0bfe8439b6c65
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 401b3b516db0..c2fee6796bd9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1231,7 +1231,7 @@ uint32_t atomctrl_get_mpll_reference_clock(struct pp_hwmgr *hwmgr)
 /**
  * Get the asic internal spread spectrum table
  */
-ATOM_ASIC_INTERNAL_SS_INFO *asic_internal_ss_get_ss_table(void *device)
+static ATOM_ASIC_INTERNAL_SS_INFO *asic_internal_ss_get_ss_table(void *device)
 {
 	ATOM_ASIC_INTERNAL_SS_INFO *table = NULL;
 	u8 frev, crev;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

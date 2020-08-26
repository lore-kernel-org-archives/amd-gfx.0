Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD50C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 03:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0961320715
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 03:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EqUANAMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0961320715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5B76E0CB;
	Wed, 26 Aug 2020 03:33:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDAE16E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 03:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guKRpEu5NYadmlTtYNDNYPmPKE6wg8Fwaz1MKK4IKumW/5U+N+Z6qMOb2tVmLL7xXVJ/K7XSsizBWF9ACj224tyTrFIk8gIDbYCp2wv5VZpzdqRupu0CS1n4tdEpLKtiD3qN6XDw9HdmcDl0zgjcP1WPsNeVT5HuQlGCfedFqf5e+BVIIcjzpRcAyTUm7xEv1/jOzT3IylGNSxKAZwCvkZ/0KX6Ir6Edshe90Ss7gghBVx6PKhgyQsier7T9rbeUTvoLsKNGI1X3M4GLPSOopt0RwYgjm3/qKF9jH5Xexk7UQMYSHtKGDOXWJKK8PbBmLGeWNgs8UhsR4qnRAarJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owJUIElCYF0rDkeLtbj46detNUw4gept74dfGkxU2EE=;
 b=FKaemyNRPbdSOJvlEM2CvHtALYyPywODpQa8rwQi1p7RI49B/+7nK529l1GCeM8RWLmDSfKEz6GakSf+KvTDTEFThiY8LCkFA7HL7+wpnL9cZRFsiyDbPmwHVGq3jiCtDMRXntBXBjtD2bF1sr7hz2t3lw3GMHLksUHn1aEPWDdSAjKcZllnQ8uEe5TSyRR5gRMH0sj1rbm5K1hXRXQIItr9kSznIrBrP+njMOY2PcLlVsZU7+n+U8CnXmh6ox57eXQkxv6B4+V+o+MVuHxByeqhT36Mu86c4u1+p6cQ9l+HfGntu2uCjGTLy1Wt7fUcXzjLh+7dCHKZ1exUo4On8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owJUIElCYF0rDkeLtbj46detNUw4gept74dfGkxU2EE=;
 b=EqUANAMPGb8D9MF98Q7mfo+A7bnMMaDZstxqqu376x2/o02hH8E46OESqE2Xd1Jwz3g7p/aIwe3ehQhdphlxHvURvbpveItf5JThG04QQe5GPJn5gfKq9MebQM/NovYptIoYjnl1csZozBA0/1wLRp0VBxkLUW58T2f/yml8bck=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Wed, 26 Aug 2020 03:33:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 03:33:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: suppress static checker warning
Date: Wed, 26 Aug 2020 11:32:46 +0800
Message-Id: <20200826033246.9063-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HKAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:203:d0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 03:33:09 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2858ae87-0f9c-4afc-be9e-08d84970c1f0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4058E915B1EF1388CEFAB0F9E4540@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: COLggHr64hx/VIwRQkmE7FRtOCRmrK0FfjGe2UBxAGubaA43xIlQDLiBcCa9MuxAh3EFImSS4H5qU6euGWjCzEgzv8Pypk5uhx9txLx7JvD139WcErJ2s5Xmh/Rq6yDO3CkxaYYl9EXzweimzMt9t1/jZ7P2OQZUgIcMdUaYLEABA+kvjdVEJnT+lNwHpHoj5qfJGYdlp363/0yCZZHwNR0lskfLozQpY79nVApX65ev2jxiV4z2eOpe4WMsxbMyypfY4NNNTlV7Tc5DeXfrZKWN8kUOc/l7iIEdt4mnJ+U9gOVRRktmul7wpB7wKhsTl0o3scrTP4di8eI7UvR7hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(4326008)(6486002)(5660300002)(26005)(186003)(6916009)(83380400001)(2906002)(8676002)(316002)(478600001)(16576012)(8936002)(36756003)(52116002)(6666004)(2616005)(956004)(1076003)(66946007)(66476007)(66556008)(44832011)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XJw6vAL3DwPMHS9ulCekyRSQEVWRyFZq7mh4gjt1kGr/pFp77L5Q4eEA5ep04NZ/uyupgjosQ+GNte8/J7Yfv9ftG6LYc0nTGy+QhtDxT3o61dPCwmSdqhiwExPrVcZyA2KN2QDZxpi1gzmP5iZJmMDqbdd3fBz2gMgzMJdU97gckMO2nbrocgPFB7mB0v1H1n2NVdkDrX9wlUrLibT2NRmKBaBawzh0CtoeoeGP8cLaqe3Mvc8e/PWvtoJnQFPjEPDxRvNq7eSGX37SgS5HMuRPGsHn8qnI2Wdwx+uqGYPo1eJRmbf/wLbvwbypy0DVWOMwu3SWfild3b7O5nSLE/EO0pdViTZDqDkgMAVqZWOfnmLNnAZzlC5A8+/MNbzKyUsyD9U1j2RjZkaj2aGB5Jm4SW6cma/XqcEjFmDegF/I6C7aTFjV3GPahms55L9Wiw0JWcwQGjLU4YlDls0WVqP+/BvRlEOHs8d4O4sWpZYwtAE2viwrT+zthmCub6p3M1OZqIjejTl7SL0XldDzKzeTxSof2RweCVVWxfU/sDd9UZF+RpfcNJwo+3EQb4qDd6LoJ3Keht/m0VuIhLkY54tHL/Dd5BQCM9QRwDyn7vPuVdvbGGDAZf60nKDgWsTskQsjuO2hR4HoWnwLZdFm7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2858ae87-0f9c-4afc-be9e-08d84970c1f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 03:33:11.6347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKNxzYK7sPm83XFTUF9deGHo1jYF8yd8leiUcxyHDGDlwIcXWjgFJKReAsDYevAH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
 dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suppress the warning below:
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:274 phm_check_smc_update_required_for_display_configuration()
warn: signedness bug returning '(-22)'

Change-Id: If50e39fe401c16d981d917ef7d8d5ea81d6538df
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 9454ab50f9a1..1f9b9facdf1f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -271,7 +271,10 @@ int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 
 bool phm_check_smc_update_required_for_display_configuration(struct pp_hwmgr *hwmgr)
 {
-	PHM_FUNC_CHECK(hwmgr);
+	if (hwmgr == NULL ||
+	    hwmgr->hwmgr_func == NULL)
+		return false;
+
 	if (hwmgr->pp_one_vf)
 		return false;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

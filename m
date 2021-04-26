Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AB7C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 18:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574606199F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 18:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574606199F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA61189E3B;
	Mon, 26 Apr 2021 18:41:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E75489E3B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 18:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0Sf/hQ/uTqxbZ/AQSMYhNxXzw+uPOk1jYVtjxCrNqKnHrv/mN3jGdkkdtLUkiEFYxntQyGgDdp7OXyQE4gZcJoTE9bfLlpSOBaTah9+OPeQCoJiBRiXMcXMaYA4PVI6kiRkrbwPUqrR6CO6uTDSNDTJHmJ4ukuxxKr65CI4BdceZOkthAkhl6zZMYUW1jNxHOUE1CY46dvRUhZfmBdBPmwcTg3WQTEy3O44Op6xo6YJO0e3Vow67M2pYlE6SFYslYsnzASXOoceq/qG5FfPLBOkeY+fhctUvb7Lm27ssBxH7ZE1zpMAL7TyBdAuPPmQG0Ve/6f69zfHZ6JBD4J/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsx6TtzljblE9QtQIFOWdAaGXO6TUqy7GSL/H9/Mdog=;
 b=VHQTB0MjZIRpPAucmCqkqER1TWfvzG46aoX0H0WI7OjhkPku0SA4CLNTMAor6hTKqHdjp4HK/oN7l4Vhi2j6A1lRfQXAghEX33TFZ01AKTnicJJDJfIQqNdr+sTiDPlbEuOeN8ozak9gaS6KWhJv5mX/plb3Y2OhvN8o4eYNEWBOtyUcUUClpWsYw2kLdFvH79Y74+xgT0TlJH4wOKda6uc9mRdbENJwDuJmPEFC0sGsYZN9zRrJOB0uPx8flluBphIqmPNorWRjoEEwZwcg50aEQMv2JkImGbj21eAQsB3p+0Sn3R6AldPbbHBoLShll3pTneoHZzJ7L7dNUh/pog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsx6TtzljblE9QtQIFOWdAaGXO6TUqy7GSL/H9/Mdog=;
 b=sS898a6eUAeeWDL+3g7r1iYMDlLQYrO+jxrRgOowEre2UV0mIgCJRrDVB1AWMH9wrl29M3dKCk/rBLzM7o1JiGXiRE81fP5q8EcS6csP/la3sHtrkqOO6jBMUMIuGSXCp+06ytHJzLlftYaquQoLB8oKlDV719Vv2H4TsReBxPw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25; Mon, 26 Apr 2021 18:41:17 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 18:41:17 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix double free device pgmap resource
Date: Mon, 26 Apr 2021 14:41:04 -0400
Message-Id: <20210426184104.4360-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::23) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTOPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24 via Frontend
 Transport; Mon, 26 Apr 2021 18:41:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abf06dcb-a682-425a-93d9-08d908e2e090
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26012591EFF129B5A63896FFE6429@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DlVCCGjWcpkUsqdH24q5lGp80UmvtIAiYhN/AvQRMaebXmwUrGGPXpxcVwAgGjUGsGuhBJzBWJWI/KomptGYEWGZHeE6y6k4CeKs3REinAKHHRSiB/wQSZvcNPVl8FASYMPcnLOuEjqaopNFcMl+uygcDy6yt/0jxx2OvdLjR5QVoUt2kNkv6JUFwrBltmo/ECqqhlmEafQ21yRRxi+FbJnY3KIk7TvLZGwmJWTME/PPrU3GI/OtcxwbVzOSrmxd/Hc410qmB3CrUjhRgVrZG/eTcaF+Mupf6f32DJzp/kW/M/iPJqIU5O46ludzF+QiD0Sq1KSQMtQSnjyQMdNJVip80oUHhm1CaWJqaXPXRGt/QksYLAJ2wCF0E7YdZ4OA5JllkHRC1wxhuVSpEMXTCp43Rxdx4CYd13qQE8pRi1sL7oUkoMCWaR1qIZOEFh2YmzyqdjzNIOC01RYNxgmVTV4HdKSA9e/RlbDpjlSdHpKiVkbHxGlhoDwMfRGIyb95G+JM57FT/wVl5JG2fnsmyOtW0NyeaZWzGuS+OOtQ6cJsd/vV48diFqWyrj16QrgqXVXNjQbQ/PcaViPanFIOds74llMFq0wy63wiLxNajaedkakJvcqYLUIqI00YBop8WPWGjEp4rGWsmbaSs1s+Lv2WLUzLUQ7g22v9OLRtL0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(36756003)(83380400001)(52116002)(38350700002)(38100700002)(66946007)(2906002)(8676002)(8936002)(6916009)(7696005)(5660300002)(4326008)(6486002)(1076003)(186003)(16526019)(26005)(6666004)(66476007)(316002)(86362001)(956004)(2616005)(478600001)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o3CnAlrUi38ygvgy36ELB2jke9JFY/PwFYLbhvuqbLFeIRfFXDZJGSwt1mE9?=
 =?us-ascii?Q?5FBI26cOvg0TbGj2T6EVCgLcgBnMrOYcErRJ+FUCIhQQTYaQ9OWZOcBtL3mM?=
 =?us-ascii?Q?GBv61bX5BVeFcZyxTc3rk+ymPzx0EEhAna9d9VOR4sW/u/W9HnusHpAxPqgp?=
 =?us-ascii?Q?UPFYwUQo2Iu9lW5+RZZaMjA6Kz/QiNHHeCyFsKTUCKRwaTylwKWs+gWpu+Bu?=
 =?us-ascii?Q?za5HtOvbz0AgGZQMwsAtjDJS3tm78J8jFKJmn+R9S1H/sETt7BHwFFgFU119?=
 =?us-ascii?Q?lyqRTCb32xpj54dlH94T+LFkTzlI5h76O94mRwW3izeTcnlPBbD6RSjp6IMD?=
 =?us-ascii?Q?RJWOmlNtv2Ef9c/IFQVsUW2agYbUK1Qfve15J0XT5pNZiLEpwpgp7ytFRtKa?=
 =?us-ascii?Q?sTpiUWgJg8jitO1S1F6fQfhLiFoDmuSUlNk+Y0nFFtLCMJckY8FPGuNXKjMI?=
 =?us-ascii?Q?yRTZtf+TMCWKCoXTEDa6O8TLE8iHB5rNQMoGtO+yi2D+2I821UzzsLsq6SCR?=
 =?us-ascii?Q?Qoxi9/vKeMNmw5aAM3kAAPwgl2G0qqYfx/HE6MFcAd2/eu0v6xSjehPjPX6m?=
 =?us-ascii?Q?S11VGHhUUW4cUKt6esFPpVnTgMWTga6s4sIWokjIS/EXKD6EupnuQIpHankE?=
 =?us-ascii?Q?1n0YQ7hAZOdKqeDH4wxBFSbxac5jxYeZgU/AQAlgTdvaQiHg16drVBTYu4BG?=
 =?us-ascii?Q?MaumETphPzHslTz/w5qvMDkg+kfnBOt5vQhUPF+rZQIzYuguOpi1Y6EGfPD3?=
 =?us-ascii?Q?muaAM428QzdAAbJ27JvsvQ7GbiIb8Ax9gUCFOH88DJRaCGOPkHVAsRSjbDQw?=
 =?us-ascii?Q?5EMu853kca41PSX5NGExF+v7MDk+E7GhOMIi0BNwC6rrShwQk6CK2nzBfqPB?=
 =?us-ascii?Q?9GKnQgJ05dpPZS7+WEsPscs2BmIxSzDPeI7yYuLV3tnOWeHqzBThds+h7Lso?=
 =?us-ascii?Q?L0J7wHM7yYYKN6wdux1u5ZCVdSDBffRnCY1F3/FSWHmiaeEM9jg+htPnH6F5?=
 =?us-ascii?Q?PsJlKSsO2lbx5+hoUx+sHbbGNMhsjB8RjxzXm1wiKYjtDPVTbFCrnvaDoVC0?=
 =?us-ascii?Q?zLh3eELdfBhrtz583rdZGqpB5r0S/rN/IWxHBeDuV8Jpc37P08ele4J10toX?=
 =?us-ascii?Q?odO8aGA4wfKx+leHLvsNUJLch30wGy5d0zYMmnhwAa8/fBHkI/4QQJTTD5pR?=
 =?us-ascii?Q?UlwCDUm0UWRU88zp/0IWb0eFjx93XrGGOCagNlZ5o7bHd8HwTKQMYbC9shr6?=
 =?us-ascii?Q?xsXBkFgyBZAXF9ofy9mU5S900kB8+QyCwXvdxn59SeciFDndWPCmTxLtDnHH?=
 =?us-ascii?Q?O8Rbrr9RNIzcI4d5gQ1gtXUM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf06dcb-a682-425a-93d9-08d908e2e090
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 18:41:17.4657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFgqfBx4Z7xyZd2Zx/38/dpjTGoSghHfBJ1RumcBB1KI/vRS07hRLAMOar/ibgun
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use devm_memunmap_pages instead of memunmap_pages to release pgmap
and remove pgmap from device action, to avoid double free pgmap when
unloading driver module.

Release device memory region if failed to create device memory pages
structure.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index a66b67083d83..6b810863f6ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -912,6 +912,8 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	r = devm_memremap_pages(adev->dev, pgmap);
 	if (IS_ERR(r)) {
 		pr_err("failed to register HMM device memory\n");
+		devm_release_mem_region(adev->dev, res->start,
+					res->end - res->start + 1);
 		return PTR_ERR(r);
 	}
 
@@ -927,5 +929,9 @@ int svm_migrate_init(struct amdgpu_device *adev)
 
 void svm_migrate_fini(struct amdgpu_device *adev)
 {
-	memunmap_pages(&adev->kfd.dev->pgmap);
+	struct dev_pagemap *pgmap = &adev->kfd.dev->pgmap;
+
+	devm_memunmap_pages(adev->dev, pgmap);
+	devm_release_mem_region(adev->dev, pgmap->range.start,
+				pgmap->range.end - pgmap->range.start + 1);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

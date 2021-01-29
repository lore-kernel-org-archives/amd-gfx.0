Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDB6C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 12:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A9464D9E
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 12:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A9464D9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D724E6E865;
	Fri, 29 Jan 2021 12:43:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E456EB29
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 12:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dArJ0B9Z6lP6TiqgLQrTbONx1S5H5oj08tdmNpqEdNF3z+vlkRXPxm2ICXSGgQRe9XxJIGIgsSxytuxANYQPjsW1yh4bfQjoBrcVgL9Okzk0M+1gtOE33PvL8JnndUBgf8zatwd6ZSdiMO31wIzpVoggOtRPMMNW1sBXawrYMaUAa+Q5gBfB+PHngDEjdFaVM7+myDmLk9pqcCnb2aMpxaEtuByddAuql5eZl4B2BWdJ8G6pnga9UAta4VBV+PPIRv2OPo+C6gKjuFyTvms5V+qGEb0k/A580SxQmYid/cFFExuxWb9rlJ0dNssIYSCa11aO2sChzIN+YtJ9PMLnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwdG33r2a6F8/HR3dNzrUOJZTzlkS+hxaOtKRMLXV9M=;
 b=b6W7e01vBcXkftqPoncH3uKJxbW/Q9Cemsf8faYD0cOyA7j7FM7EdWT+2QHh9iU6ILmMQY5T06M9iisJfGz7uuIti3OA3nlgnsj7d8STELYjFkIDYJ2pj4aPWQeaVFFFID6hH9g2Kbn0RVOmaQHaWU3Z9nhdWns2HVgwIVQTn38ZBRWrC+41OMkKwXFXZyG47LPe5uQYUet4X2EpgdSNowVXbfBv7H+yeqM2KTdJ048C0dVdnp0HJ1x4LABwlBczFeh/rHuRo155ld3aICNznPbWyT71D9cLl4ZmuV+i9f/Ymb6Wsz3CIDUS056xCCiyV9okE9/aXW/dr4NltgEYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwdG33r2a6F8/HR3dNzrUOJZTzlkS+hxaOtKRMLXV9M=;
 b=sY7Ik4rHEgNfQXmpSXOVKaYUDk/bXRyavDAeS65UicsbBoZGSL22xLNunTm2C6uMOf3bp/FwaCcXVlOa/sg6KzHMrgUeA3uxQi1T3pLCUCVvlZm2cliOCq/24Xjtw4X/hdWUj6SLozJUZ40euFkOPBy3RHG3oLNaRNZ1TirYt4k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17)
 by DM5PR12MB1676.namprd12.prod.outlook.com (2603:10b6:4:8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Fri, 29 Jan 2021 12:43:21 +0000
Received: from DM6PR12MB3546.namprd12.prod.outlook.com
 ([fe80::3516:aaa4:e0d0:fa92]) by DM6PR12MB3546.namprd12.prod.outlook.com
 ([fe80::3516:aaa4:e0d0:fa92%3]) with mapi id 15.20.3805.018; Fri, 29 Jan 2021
 12:43:20 +0000
From: Ori Messinger <Ori.Messinger@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu: Add Missing Sienna Cichlid DID
Date: Fri, 29 Jan 2021 07:42:50 -0500
Message-Id: <20210129124250.24700-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To DM6PR12MB3546.namprd12.prod.outlook.com
 (2603:10b6:5:18d::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from OriUbuntu.amd.com (165.204.55.251) by
 YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 12:43:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e991923-071f-4aa1-329c-08d8c4537541
X-MS-TrafficTypeDiagnostic: DM5PR12MB1676:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1676B96E2F273944BDE19ABCF8B99@DM5PR12MB1676.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kizf8bHfqnwSgOIVaUsZPWHD1r4IQodsf2ilUbbZ9ESaAGAS3+qsSgv55a923fuH1+wrIhxB56V0mkHXc+iEn11eETrTAl0zSECD3a5EJLbasD1T/irb6XjRN5Z6vnXPSOLOeLi4W90uvZZ7JBBo/TzDDSDvW3zsnf7CDZhsziK/dcJVFx+HFQiaM/waaug3byYhohcgjFl5r3HeTZWbbAzMvFbEcS2zMmAIhVDPqufNhJFffboAE6e33Wl/enng75VdMO4KDCDhP2rrtHrBp8qak3Xo8c1w6xgxVlAcPqP1N3AS8RA8F1YCACH6/XojbYpp1UJ7lvzt52r1UU1IxObKRMIosGXPX6vxoFBtW69H7geGW8Yz/TqjJC2vDojrSV+b+BqjM+4mi99MI6SBu0TxoiUrg23FyIA/Etr41B53cD1WzWkubNqQZYe9ZlHWxheOhSw/Q3lYT6/N8VvHl8uJsryDYVqo1Hkw1g/ngnx8IN4OMPEZGFJ16ZYcg1idQAacj6sakr2anhZh7fbG+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3546.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(2906002)(36756003)(6666004)(66946007)(16526019)(186003)(5660300002)(86362001)(66476007)(66556008)(26005)(7696005)(52116002)(8676002)(8936002)(1076003)(316002)(4326008)(478600001)(6916009)(4744005)(6486002)(2616005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nmr+VoUaD7lFaivfsCn0GJ/CV7L8CfDZPf5j3XKh7W9UTWDJi1EUDOyaNK0w?=
 =?us-ascii?Q?+zWU+wZglzJ41PhFM/716lcxZNVC+YP5CL4NAEguZOJsH6aRCc8h1/+NzbSn?=
 =?us-ascii?Q?DFsLIHzVXb8UU5HMPppMrlamkkVU+djCNW1NuyYdb6nYVugRSa8QcNVe2cJt?=
 =?us-ascii?Q?QlCHEAQWF/HHDyuqt3y3XPpBEbkVs6L9z0uGCOOvP7ZcG7tIdIOZDUg1wVof?=
 =?us-ascii?Q?Hsv5yLLzZWhF2+rb8MVc+citkOKksXh3S0CF1nY0/2Um+hP7nAnlOXso/16D?=
 =?us-ascii?Q?sDZnZBjCETFSnxlQxsVjN8mcTwG64T/FP5ySIzzR6yEpWHqa83UWcOAtUbpQ?=
 =?us-ascii?Q?/Xl9KdUiXh2Fu2Rqy40EQfVscnRlHoGaS5KTYEcJsxapuVD4We29qjTe2fkH?=
 =?us-ascii?Q?Ack23sUKECb3yYcffw0F+YP4NFTUORvMmTzwrCc7IbkPrLrcrfQYLw/9sUaT?=
 =?us-ascii?Q?QxEjYuxX7ALT774Rm1gtOyvnw4Og8xtZ96Aruw2gpFLEUnuo/L0eDEvcROk1?=
 =?us-ascii?Q?UCTprpEHVBf1w2xCBrs9F0AqmXMG8SZhOxgLemGvRnKQ+7BcB5o0N2+NrwdM?=
 =?us-ascii?Q?trceQwlJvxb73kC2+Ccc/hxc7/2YEdvefWSAAOYN9ZmiQsE+F+l8RepVFuRt?=
 =?us-ascii?Q?2SQ3frbOopI1Ob5qm+4dll8KFeHgWjhCcoOiHAc21vmCCjhVhaH44NvoQkpD?=
 =?us-ascii?Q?VohtmqLy9uWxkA6+eE88s3mg+CPdpzjxGw0GUblrkJ+6cYWL6MBVBXoFdmQL?=
 =?us-ascii?Q?BZG/slHoMr2Pbs8AfUlP4vMv+PItXlDZ6ak5a18ZK7/mH8dVWfVBwuqjGJA/?=
 =?us-ascii?Q?F02Gfyjhzq8F67PqrftBui5ELvh653+EC0MX2r52WtlWM4XiH28dLkZuOPJp?=
 =?us-ascii?Q?6sA0re9FXX5uaVIE4hsfzjYHqlUd+1FwDvE4tbohTXh5O9S3GRD8B/C40HwP?=
 =?us-ascii?Q?+eyY27diMJye7DXKnFE44pXErcQhxLhV8jq0gHAkC88jvEnezb+He9nhE0QJ?=
 =?us-ascii?Q?6mwhdQVtzGtJBHXYNsiR3pyytsLD52XzIKJlYD6VB8zXuWY7OsAcOc9XnVdb?=
 =?us-ascii?Q?fYd7o6Tp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e991923-071f-4aa1-329c-08d8c4537541
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3546.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 12:43:20.5159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzRGs63Wdq3VTTyBPWGr/GOIuMvCQtMpLNug6INwrELyd5/O7GHG4m2m7zvsZd1a0FDCA0pO0tZi+OxAixiwlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1676
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
Cc: Ori Messinger <Ori.Messinger@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The purpose of this patch is to add a missing device ID for Sienna Cichlid.
The missing ID "0x73A1" is now added to the "amdgpu_drv.c" file.

Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 529dbc566f68..864cc69997dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1094,6 +1094,7 @@ static const struct pci_device_id pciidlist[] = {
 
 	/* Sienna_Cichlid */
 	{0x1002, 0x73A0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73A1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73A3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73AB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

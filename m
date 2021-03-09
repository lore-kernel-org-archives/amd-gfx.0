Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2190AC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 20:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55E66523A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 20:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55E66523A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8716E0E8;
	Tue,  9 Mar 2021 20:07:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19256E0E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 20:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlyZN438IDqtnllV81cvmFuG3G90ymgu1fJigq2l/h78YJGw+zBCegcYqXHxAlsw5pRLs+fA17RzsMSW7DnrhExy0fFxNStCKEReCFghqt6nRhe12AQ99OSs26O68+y+Lo/XpaYhkbrPSSBFs33zTw4jcykGb8WBmLNnf8bnoguZFt3NSX+deM4KauH7NsLsdz18lz3k/Nd7akai6vKsQi2qkdzxNUe4Nrf6MrNSV0sLd1zMr9z7nemGQY1zRn7LjSrkcJf2QS9q7lphRud4XDqZsam5XNjfQDwh/z7y3lNo9sHWKUXiAGk/YimBabyHGoaFkH61SWU4HjFN1waK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqouymY6jCKUs5pSr27/Je1zCkLtgiNOMDoVYmRMTI4=;
 b=ZJmW3WPIVRXiLgkuD6h+is01j1IJrttU5u/xqKNK3DzdtyysJYdxZ9MsTGmZAerahI17Ihc5g1cfa+TOv0a0vTsGX2RsXjqZX7VZ2QQ73PAbwlHVzyNdLQN9qVzsaVswPf+bOdR/PMC5P4OkDMRCcH6A02i2GShJ5oXBNahikU0O6Lnf+ol4d2AM06prkQfhZR0unNd9L7z/4kXgrk4d1REA7K+6Wwb6Jt+nR6qE22Xhv0vb+2CyXjcu6w2+E/DewpTwQs29sFui9zNM5dJS+YJb+HFiYzcfZBGbbQ8AanntVW0Qoav2o3fR3yCKftmjxqPTVjH+FkdQ1YciqiN8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqouymY6jCKUs5pSr27/Je1zCkLtgiNOMDoVYmRMTI4=;
 b=D1hOgmfKuzYMd6sTFWLuuSD9ivlby+/S/M6bWVOR8HuW8nJSjiqT06Uz/3xM3iljPn9UrM4HdPRK6M02jtuAiDkbqt3DeDy7Kw9kzpkFKQMpO5DPdTGmzm/uLorQOST4Jvc8IMRL+2ka2xCf7rFnWEL4g4LJ4OOLu3dG8ojqFsw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4608.namprd12.prod.outlook.com (2603:10b6:208:fd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 20:07:28 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.031; Tue, 9 Mar 2021
 20:07:28 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Bump KFD API version
Date: Tue,  9 Mar 2021 15:06:44 -0500
Message-Id: <20210309200644.28188-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::32) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 20:07:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08478393-da6e-4a48-d4fc-08d8e336f6e8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4608:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB460815FB086C10AFD53473EF92929@MN2PR12MB4608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b56KxJC6sp7VuE+s5WBwSfPzID3nosyjInWHynpy169sbfyYXVIEEplj4wX5JP1KWMyTKDj5eNElDFuFZO+5Bem7rt5QCaCT+fMSI5CPuAaOpCTHu6icXjpvzjwHZua31n6wm9DSixc4ujYsLRubh+N69jrfZPf0MY3g6B0OGlZqI4z+Q4PS+xPPqC5PXcHFqEJ5AlnLe6+LSnOrLjuI2lcpp1x1iVAZDQaJQJcsVnoCmrzk8l0jO5PJqa8izMnfJBoA/paVgxePYZ/EtzHB/wdHPnwUB+q4TY3pfItr0UGIKJ+gp1Mu7DTso0B07kFjvLH8lvsjeX/S6mHD2bgI0pb1sGKFs7202+K6kNyc6BnHy7ac9qqvtGqNNyW7TsyQfP3v34Ny1h+6xXCst83ve6Him5XwMohQSIgyR0O+I9hFjec/ZXKXF01HvodOZvYbyAHDCuFfxuMihhrVEcP2rB6tOr8UhdI18vo2V2yh8cKU/RHfLkgGD8vHzdA2izUnX7BuRjKLc3B8n4JOk3xPMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(6916009)(956004)(6486002)(2616005)(478600001)(16526019)(86362001)(4744005)(186003)(66476007)(5660300002)(2906002)(83380400001)(66556008)(66946007)(6666004)(8936002)(316002)(8676002)(36756003)(26005)(4326008)(1076003)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YGDjvfQJSRsF0TVsSa1mxIJxjEv5UQeS5bUlIbhmZYNkCbk7Vn3ZkWsfWS8B?=
 =?us-ascii?Q?BVASovnTL5kUPQaaS6Yf18tIHfQkqfoYXxfa0Fca6Ic5L0Tz2MOu5UOGo+7i?=
 =?us-ascii?Q?eJcwuwFwXLbJ4u8PquMrmiIe0bI4e2cQ0jCQCBqxlvXGMnzXa4ncp1BqLhh1?=
 =?us-ascii?Q?JTMnPbfIravcG4JHusuuFjHUCEaPFO+w3VQqAQH3XiQ8io94O3mVvxumqQRV?=
 =?us-ascii?Q?bctqXSFmh1qLonXRi/Bf7S+HAQVb2ZbCGTAKnid0gMCEvLqx1/fKPJlhDxSF?=
 =?us-ascii?Q?oLAk6vCXADeTGVyH/HIlPCB/48amSO0eMJbQFKZBFC+w6/KVgI9Fo7/V+0D/?=
 =?us-ascii?Q?GdHNQ0EcYLXhLMBXHHu/gX3kxvMaHoraZWMOeZ3miARFOSEQc5Wsu6S6h867?=
 =?us-ascii?Q?1r2UB8hOmAPUW2U9eB8WM0lxcC82agbc1mPxnKIrAu6TtI0cmUqVAit7UDFE?=
 =?us-ascii?Q?GM5gVPOxqXml/rknqaMSx9VTHmDs+R5YiL/rNCsMS6mvRLHiuYeHEYsu/3BA?=
 =?us-ascii?Q?9XHo5QmBrqgnULpFzYr2Te+b78er1x1KqTTHu+heiFVhRy7ChtrWN7C1LOzO?=
 =?us-ascii?Q?BpXkqDjNBNvpqqakUO3ar9Lqk1SQoU5o2DtsemRsY05rKYwpXTqc6f7G4xaZ?=
 =?us-ascii?Q?gUBKK2tTN32hOzmsqCydNBj6bB3ROmhCMXdnGz78pViuivlG72HZ1AxBahoI?=
 =?us-ascii?Q?mNxBh8E5jm8ljzxQvgzSm9GzX7HwubhR71kcX/l7flFKn95oD5tVv9Kz2Rnl?=
 =?us-ascii?Q?X4Su3nOlYyE9RnaJUOuEWYU8EhsG4f9b7H323FNJ2YcfH0O6piyx8V+29TSq?=
 =?us-ascii?Q?XI9qWCb/7606e3efcseJEqdF1nHxAYV1x7+VaW9PREuJJofPSvA2+Hchzoc3?=
 =?us-ascii?Q?VgHcjUTtJA8/nhmNoI3m2QnP4PvYux8EtRf+Sxof9eYeuGjNQPpbTnG84y6w?=
 =?us-ascii?Q?u+/GE186rpfb9p0f9croorD+EHELHDagwjFRKFl1Vd2f0FhemH4UtPxy2iFK?=
 =?us-ascii?Q?uQ7RjRH0Ejjl2WklXc0RDJJm6GYZNxkw4EUAJnP48wqSWvCIOpPE2/d33jO3?=
 =?us-ascii?Q?lj9+f7MzsCBkOBiW+ZK+2HrLZpumUlbqtsygkmqVb5oZ+I17ngmir7/vEFGv?=
 =?us-ascii?Q?mhYEYiH49JGyDAFTcDija+a6l5OAIs4kX9//vVWVLAzFoTqr6UeZ8pwIUxzB?=
 =?us-ascii?Q?tWD+wRZ6wdplh+ezZmX9zcuZtuU0/S9e3ehKdXl8b0xVjA7k5KwlzkmpuXAH?=
 =?us-ascii?Q?yR0USnK4QfsWg/MaPWMhCY4o5ndMmgoKatAtfEjKWXuxk0Ilp/SrkBzvPmK8?=
 =?us-ascii?Q?3Gh7LTaJ0JtGvsuJ6lIm9p//?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08478393-da6e-4a48-d4fc-08d8e336f6e8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 20:07:28.5278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boznTFLWCa9zXqkPTIPZ9Z6aDHKiZtm4tRDZ6ijBxqwqp5Jd8ICX0IUkpompMH/JJ3AjSpbiGtEusaojkpIVMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4608
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
Cc: sean.keely@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Indicate the availability reliable SRAM EDC state in the new bit
in the device properties.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 18449f746097..bf5e7d7846dd 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -29,9 +29,10 @@
 /*
  * - 1.1 - initial version
  * - 1.3 - Add SMI events support
+ * - 1.4 - Indicate new SRAM EDC bit in device properties
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 3
+#define KFD_IOCTL_MINOR_VERSION 4
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

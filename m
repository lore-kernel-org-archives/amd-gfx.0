Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273BC55178
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F2722202
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qd/aI13e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F2722202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3866EC63;
	Tue, 27 Oct 2020 20:53:17 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700053.outbound.protection.outlook.com [40.107.70.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CDB56EC61
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5/XBi6PaNt6AlUL4tG3aqdepLICYwvrdp797vn6LeFBz1EKnXK50sAYCR+9FIk9i3vvxVs7Xownk4zraHPYcqofpwvcFY8CTOrTH3LYfGXRMp5nTj4ju/Rqz7olsoQiJucfZlrPcC7gVwM5iZYDBHnJHihdKWxQl2FdqojzNQw6PcpedPwxmi9p03AQMHgx3a5V2A/gqiVlO6tVqHv+jWIs1+2ZaGRqjx5tkE0fRKNPKAadwpDTqLelYNYLx/PlokiKmQHjt1DheAWw7Ua/QHSmsx3J8F51rrQoK3UBOLDQl6PngItP/av1qInF5OXDz5brhiO9ayOeB7RS0E61wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIVKlfFMnEp140WPXiqTTWPpX5Ssn82KRIROyXZKzR8=;
 b=e+BKKEgXSUqTLZ+cNKHmsP8AMdSnUyrL0kKNi2crZqxnN4UpEdpgJDym95lA/nrp7rScVN+mPTSFvVjBH/feuCYFC64OFJRS3oZkxpUjYz9zhNoAhPsVsY+hOFSgeBvwZgG4M85yhyHaajI/vSFvrjvvFJZXvqSveJKfqtSEuY6NauX4pzI6uRNNUdKK6T9fkwKFjfEtP4vp1UMjFFUf1zNYL0f0Ku6+csRZl5JHlu+5ni52SFyHPuGqLUxtDF/YrSxI9i14SeHyOoe2v6gG1KHqSANwMvX1lFwm/3U0Y6pi/5mxxMwvMbN7Sir/GFtDlLUEkzlR6Nfbiv1OVsHmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIVKlfFMnEp140WPXiqTTWPpX5Ssn82KRIROyXZKzR8=;
 b=qd/aI13e1mBoyvkNVcR5XLEkLKqpYjlxhdtc4ScXnzmVAGivdPSBr417Qyd+kmVDUwofdSw0i4bBf92mJgeRKy2LZBSLAGQUdWDx89zvjVrJvWdic2tBeRoaKpK0LWyigDIdLpiNNzyUnfy2HNIOjg2VPQs4WzdqK0VMj3vmQoo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:07 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:06 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/25] drm/amd/display: 3.2.110
Date: Tue, 27 Oct 2020 16:52:33 -0400
Message-Id: <20201027205234.8239-25-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:53:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3106c560-f5eb-4386-f500-08d87aba4ae8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35959C91AAF2BF7F37FF1F1EFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oo4b9kfagIFDHFakkuq1QymWeVubLtqKJwE4TIquG7xVN7W+KKfcxJRRkTK8X9A82XezRYafNSwT444xNRHt6+lCCdFQ06Let16rQX0cPvcddhIZ0ChMOzirBzFM8CYeFn5NUemlYnJ3rOzShK2JcCKbEE87FeJIPEICziB2gZ+PIwrfmKaIFTzXI8avYsWx9neGggut+3kG8LkXVM0sX7CpKA6KkFK07wf1PPYhAy/8GoQ64qgfBUWX7TAIneEtvwlRsB4r+53jlQibr0vDKNeoSIl5UnJLjvFbfeSoRr1vE8MIS1q0qNtd2CVbEZl0fT7rhVnPENqV0a2G+gBuc6eloNWHxRfaakiwhS9GQ1ChvhaPJGm88aD+ZOocY3ZG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(4744005)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OEOLzRTFNd248Q2nwpI80j9MkOWu8i0qC0sxvu9Hr31177ceFpkcV+SC8y/RzNbHSTy5MJ3W0Xyqs79gEaVZhMOjj4LoAnyHL/6utzJVtyHn3qBGeG9zL6j3OS8bVousKAeMayKEDFkpmdVDvlL9U9iOQ6VUtJPCWqZvWR9e0GdPPadcJh0GG017KUdA0MxiCldP7sKXYBrEjlrQogtxMiYqpjlaclf7h6bph9M2I41OqA+ZUqDETC+ZFxWkcHt0dUcJzntbO+sT++B9XTz/BX+1xeZW43Hb6xBJIk0YSQ/ebyaj/CnPLfOOUUvXgWiVdrL1w4Ad/4QtCJXE6VFSc4LlzmdUSWl7DZbvJqU5Py5cJkkuyPPeTTDIxRtCbvM4tldg/HeSUW3fx2oODwrU/9FBn5JMw1+T3JtKR3G3AbjTc7RqJ2tEK94H8LG3cbtc/5RoUJfAxzw4DbQ2c/BBtvDUQvlDeNz38zTVjFzgI3VReGGp5+c3dt7GdkFXHUZElpOfq+Fpo74tXkHy2XXDN2q7ohQ6a/+KgiLHda2y+bof25OLyVlBN/fPP+Hl+DjQ5cAp87yyCnKk/woCwmoFvM0zDD+nrhbw/8DB72oNGrQVOIuY6E466h+kGnZm4usHHAGsBAwb+KVcFjfwZG6Ltw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3106c560-f5eb-4386-f500-08d87aba4ae8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:53:01.5540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qu6v/k6kN7KS/5Nu82nF+K1iY1rmvS2QhakKDwcwjGpssPTLXFn0FEtnEZc4/9OZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 87bc10279349..e6b92683dc5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.109"
+#define DC_VER "3.2.110"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

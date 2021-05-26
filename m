Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88183C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 00:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406276023C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 00:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406276023C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D02636E454;
	Wed, 26 May 2021 00:41:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716AD6E454
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 00:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0pW8/j/hJ+gUL9wXSDvdaoAaOc+LkaSuPF301izBLfBzgrp0mvMSimmKNPHIGTNM5P14ER4cfLGZFFLk6g08+DpOeIVW1RhZpvMYGn/lcXsO0I25Afl/mHO/QCNZaYIshfhEvDtCR9A1WtQLOZ/6kpbWDEgd2VFQOe16NaF8f6Nyzah84W/XjsMRBMz5+waEY+TV/Nn8nPVLbXan+HcCYan4xd/b7yT97/0ApmFIsfDDxZX8Fkor1bIqnZu/nvi2yuD1ZMro1Klo2VmuAfYBTlvY7Tb+LIxJ0GF76uKhDORIlZhd7WKKqotDSLcPljOAZT0It8KTYW0BBhA4c+wRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9w/ArS5ZkLoiVhKxF12xfNJAeen6bgDK9gfXnyLbhw=;
 b=d30lFDCIJQPTMRFSlt7ApAcPEuOIrRd16nBLIsu80VFyrXsi4/KLayP39bJl2+UsRymws5vtKf5fxpuyVBpY3OIX7FAAtuY8cCL885Yz+Zc5WrfrzPXwgIK9kq0rLEfUbnaVjeEoqrfk4XldHtHr3hjIRgKxv3KQKMY1YhR9aWZNQGukwCTGMLpImcOyb25CWR12mHv1AYepmuUaUeDJxZu1G/S5mAXVsC9zyqHKmmMhBePmolvrn5d41nBwggzCVL4B+8MHY0bfS5AtWeBE7+3MBedcihU5RaqNtTZimuJdkeyrfDCCIpHMHb2/+joe8AlefQeaFGr6J8ZvhLPbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9w/ArS5ZkLoiVhKxF12xfNJAeen6bgDK9gfXnyLbhw=;
 b=KWk6daNlu2/LgSkZwPyFnyPzcgz8FQ/4RwTcg/+DfqxhfcHK4aeS4kvYSb9rEqA0HbXzx/Shb3SJmBiWx9hKDyecE0CANJrLqMJJ9pMZ8Q9SKyA5AynxQRZwN6KnNmxPcD0JysKaVmVssH49PMJNLwwN0yqmgHb0/++HsLT4K0A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 00:41:03 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 00:41:03 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Fix RAS function interface
Date: Tue, 25 May 2021 20:40:43 -0400
Message-Id: <20210526004044.58986-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
In-Reply-To: <20210526004044.58986-1-luben.tuikov@amd.com>
References: <20210526004044.58986-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Wed, 26 May 2021 00:41:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91d8082d-f9d7-4379-f674-08d91fdef0c0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB164119D21170FBFDF434EEED99249@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyfzkGJOnMxf95bP0VAgdnBOR9mIpgSDzI9sMSVwD0/06NjLoOtHU5/p/XPtN6Hmd1HxJYR11qThyH/Kbc+VUtvB/U56wSjAozHZZqVcUQnps1Za1YoEPbGHm4azZ084i7ncg5QR2n7ZF/YlVPEY+CKNiCzBUAto+W129gx//cGTNmCZxlvquN9IUW6S4qtFVEyGP4hHWQBSWgtaSXqi5qb85/qBx+8mEvLPXXrS7gYUDRTNzcNp06HetV1GOqD8RDAvouVeHxFAVBzfYrHXwWAi6ScZeF3dKUVkrhPdp13MqrkeiYP+V2mNx2gP0GMtXio8IkkEFDcohKyGt+ixd3eC1C8uexGmVBYcimobP4Sl6FnuCEDXgagOMZYpcM8UmEZ0t2StFUWKzpWcCo9wuR0/qDXVmh+7v8Tvg2hsO8LC8hH0v01/75FYSux6azQbF9n6/kvq8A9j/f+SiDi6sAUD18WzK8lpFZZ6SBFezqrlqP/M8yPoFh/ZM3gkQPdU5kcuCEPE+c3fiv8fBvvDyqw38TUPTEW+4guBzZwisZghshWNWGbtg3XteZdAkQC7Vtly3VK6OOZwCGgyHhM2m65PWcqKjRRH62cYrOMVV0TdSaBmFmr1wA4xlsrHDV63lzpkxEFENjsfi/hakVelZKWDHx9y86AzGuE+YUjesNXsf0cTaa2hVxXHSmB+3KWM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(52116002)(26005)(55236004)(186003)(16526019)(66476007)(2616005)(478600001)(6506007)(66556008)(86362001)(83380400001)(2906002)(38350700002)(66946007)(6916009)(36756003)(316002)(8936002)(38100700002)(4326008)(6512007)(5660300002)(956004)(8676002)(44832011)(6486002)(54906003)(6666004)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?miTHU0HODj3Itml1n/rdYJ/6e+lRK/PKvZzsz+WxYha0Oy+9tM+pPmHGSoPp?=
 =?us-ascii?Q?jtOvtncnwMBt0pdeLyTYsLpu++iTO7kWsLGKjhOh+v7y/O4k0I42jBeGH6EH?=
 =?us-ascii?Q?eBKAAafluflzlDfVfzfxiCSWLEich2hAZvesSVdhsO54kCtrwUUwif4/ILDI?=
 =?us-ascii?Q?rcGZx/HZgYFpnzoHlHrzocmoyd9DDA4axfPDKhCj0K9shjLpc+cE0TfLZ4rl?=
 =?us-ascii?Q?uwD1OckuKk6c3rOLABjqoIKKcdTYQ6eccV7D/PrR/2kHXTI+8o9Xr7A1SaNT?=
 =?us-ascii?Q?DI3MMG3wWsbP8IcWHK8V0n9ZBHr8kmTpvXDjCNhtuvw+rjYAKWn53wWQiyxE?=
 =?us-ascii?Q?sBggLmNVv4AAETQw94qcFJuoHiZiPs12OoZ8Qj5/A60o14BHeS+indRq1wc4?=
 =?us-ascii?Q?FifTtI9Mm0DbEEI5CIvsQzabiVn4jDFKTGxzcJFZ4L+U0cVgC5OAZEidLGbE?=
 =?us-ascii?Q?uPON7iEqJmCZ6x/qh4UOzVFNBm82+APut1eC4SE7ZO1L4Vp3WNvkJkpViGPG?=
 =?us-ascii?Q?Nel5NieQJfWgKBlx85I3a3EN9O96vlFGBjEzad1IQToIY+TpogfXHKuHraEM?=
 =?us-ascii?Q?Sexlr2DykGEQ7dQnWruTDKiWOgu1iUmJpaQKrsnP0EiV4tFdt1pz2daASaHB?=
 =?us-ascii?Q?hrJ6sarIiyZ7YO7OR1hU4+M6muUAHTw8hEGenC7JVzopeMFYc6RMrJTEobz6?=
 =?us-ascii?Q?ghTXd6Pq5vMOZpSPG6wTydD6yWT/7tTLkJPJsgqWOcnltWfKlEMxxURkAp/B?=
 =?us-ascii?Q?YIQ2HtqLPkt91gWzoX+fEKbrKERL7etthhR5i35XAYHztDJncdKwqeEoCA7g?=
 =?us-ascii?Q?8GAzJWB+gma+NNyKrjckXRE3F6EFEoRSSC8dLyZ7rPVRFfL94qpWV4OfXHXp?=
 =?us-ascii?Q?Mc3amWq8J7HEvyFtgJ9KDVqe/NO3CtkIn19PmgcyfiaMhNWh8N7EeUnMIk9g?=
 =?us-ascii?Q?GoDT0DF87TJdh+tsrfbgz86XP47bK0mSTzoxEg9U1PRASNjD2utWOOetaI7A?=
 =?us-ascii?Q?DNgZ0oE88qS4P0jdG9p9jMvfZs8VRlJMKXZSJzD/+lczmEZ7W/6ivSA0wm5+?=
 =?us-ascii?Q?7HexOCb0HiD5wVGQ7GZaH0lCVDqFCeMTNEDU7lttKRlf9O0lXKvIWnfun5ya?=
 =?us-ascii?Q?2aXpyeFuo8HqdsU5dSgUGL0AXoqfvHsLoQ3mgZVAWdeuNssMF2+xqq42YiK5?=
 =?us-ascii?Q?Bk/DchRPaqXzY4unkxuWEIsKKO1/TFKae57ue92xEGvKmZyCp1Dorlc46bFz?=
 =?us-ascii?Q?VsdGdXNPZandVsyT83OLDrrzDIZyoPgTfuX846iZjPuzQVv8Q4+X199O0mRI?=
 =?us-ascii?Q?Luh480GFEzGdyOW37pcz/Bg1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d8082d-f9d7-4379-f674-08d91fdef0c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 00:41:03.3423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mafF45xpvRYNeMOxFQc+fTqvtuWoJtNlKxhmsCIlS1is1IsCFkRti5DOfZrqoGGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The correctable and uncorrectable errors
are calculated at each invocation of this
function. Therefore, it is highly inefficient to
return just one of them based on a Boolean
input. If the caller wants both, twice the work
would be done. (And this work is O(n^3) on
Vega20.)

Fix this "interface" to simply return what it had
calculated--both values. Let the caller choose
what it wants to record, inspect, use.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 23 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +++--
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e3a4c3a7635a..ed3c43e8b0b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1043,29 +1043,36 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 }
 
 /* get the total error counts on all IPs */
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce)
+void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
+				  unsigned long *ce_count,
+				  unsigned long *ue_count)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
-	struct ras_err_data data = {0, 0};
+	unsigned long ce, ue;
 
 	if (!adev->ras_enabled || !con)
-		return 0;
+		return;
 
+	ce = 0;
+	ue = 0;
 	list_for_each_entry(obj, &con->head, node) {
 		struct ras_query_if info = {
 			.head = obj->head,
 		};
 
 		if (amdgpu_ras_query_error_status(adev, &info))
-			return 0;
+			return;
 
-		data.ce_count += info.ce_count;
-		data.ue_count += info.ue_count;
+		ce += info.ce_count;
+		ue += info.ue_count;
 	}
 
-	return is_ce ? data.ce_count : data.ue_count;
+	if (ce_count)
+		*ce_count = ce;
+
+	if (ue_count)
+		*ue_count = ue;
 }
 /* query/inject/cure end */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index bfa40c8ecc94..10fca0393106 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -485,8 +485,9 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 void amdgpu_ras_resume(struct amdgpu_device *adev);
 void amdgpu_ras_suspend(struct amdgpu_device *adev);
 
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce);
+void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
+				  unsigned long *ce_count,
+				  unsigned long *ue_count);
 
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
-- 
2.31.1.527.g2d677e5b15

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

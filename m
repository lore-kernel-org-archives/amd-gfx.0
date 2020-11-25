Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C3C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 14:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FF62076B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 14:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nZX0aRV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FF62076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3B36E9FA;
	Wed, 25 Nov 2020 14:10:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C996E9FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 14:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMySBWoFkqGQbJmbGga1ij9rnfzvJLmcRupPWFGqslqU6Bf42N+c6aCOIziqEF2wQchAV/TtMxVnhfEzoRIrEUDeHiCf24V05dstH+K+wDg2ELnud8Eu5NY4NpW6nQ7RYUVyKvVLdt0k3hsabfMmXvD81h4dBk1fU3zF6jml/Nzk5DZChsBjPmPvxSJbbydNQti2hXcD0TthSwNY/0Ip9lCTbA+52MpW3AaIrLxDwrVUf7D2uXKYX1VqEalofInBR/qg1WlPhGVJ6Gc1tzkP1sVqlDzuA8h52dP7LTFkB/zBvNfvEwdZ+VS5OUSeTlJ90b+umaRkDhST+OpSS1fPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvDlfZ/2DcmBkK4lPKwgZ+fV1tAYa7GhIDli+b5RLiQ=;
 b=CrmObftEWNHko5TqmteY0HpiOdUD9rwXqEHkBK0atr0ZKdUSkyJtmDBFiqOkOuHoThduoWKffVokNrzc52q1OymRYHRTyVDYCHmRnT3pdkBTEH0/uEB/E48ZizkCAekTq5ZpD9mm80AOjpUYDs/5CfF+edb3r8snyNXrbt2wl37gF9oT9yLY4Z+gnMm95FPTk/piydhojP8icQ/vaTZGiRQbt+2I+6Gl3KM4MAJlAGUFUiM4jL5d1BFw83DzSA3LI3D7rV/I8f/WigFKJXHEiRnO5n8DjkDhCXhupsBLpSC97PZ4a43i6wBCTgASMEVO+uDeqyKU554dRn4aXrzX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvDlfZ/2DcmBkK4lPKwgZ+fV1tAYa7GhIDli+b5RLiQ=;
 b=nZX0aRV04fJP6L871SBtj4ywYYMKpUHDCdEyi6RhYC0wiC/OFawhmwNfz1qxqXbX/qzdFl1IxvMOPRulG1UKj/Vs4sIkclwMDh2eSUPwRnY+cI8Psxr3URUz0b+2VTidOjSr4lRncSNYn6fsjH7bnH9XA7P/m6qBCfVv/oM6X60=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3222.namprd12.prod.outlook.com (2603:10b6:a03:12c::23)
 by BYAPR12MB2759.namprd12.prod.outlook.com (2603:10b6:a03:61::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 25 Nov
 2020 14:10:41 +0000
Received: from BYAPR12MB3222.namprd12.prod.outlook.com
 ([fe80::7c6e:b8ff:6043:9dab]) by BYAPR12MB3222.namprd12.prod.outlook.com
 ([fe80::7c6e:b8ff:6043:9dab%6]) with mapi id 15.20.3611.020; Wed, 25 Nov 2020
 14:10:40 +0000
From: jianzh@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period
Date: Wed, 25 Nov 2020 22:10:12 +0800
Message-Id: <20201125141012.301219-1-jianzh@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To BYAPR12MB3222.namprd12.prod.outlook.com
 (2603:10b6:a03:12c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jg.amd.com (180.167.199.189) by
 HK2PR0401CA0022.apcprd04.prod.outlook.com (2603:1096:202:2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Wed, 25 Nov 2020 14:10:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 417d281a-eda3-471f-6562-08d8914be3b7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2759B1924A0DF7DCDB280063E1FA0@BYAPR12MB2759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zg3pPIRu2XbCmUMFgqv7jWXmqFV4RZ/TG/qygqkOjIdLb8T+cVOEcNarKktaOGI04H71J3kL1iVh2s4F76SXR8qOHF78DD/K4u3xLW1P9+zvn+2vYsCQeea4A67twC1tZEEwIM/2k2qXw5kj+VxMj/ngwbzUSTbc160YYRuyc385xgtldX+zi6Fdot399Edjkf8M4/ZsC9iII1ZZ9FmzihhK0skirnPtGv8MMs6MHJg/1BTRQYFOSfk0juyJgzAZ6S0/1oC1Q5uaACmz1ggJMVGVleoGylrTF0ipKfv8IqUogIq/0dSpKFHlFl+hYoOc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3222.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(8936002)(5660300002)(316002)(6916009)(4326008)(66476007)(186003)(26005)(52116002)(8676002)(83380400001)(16526019)(66556008)(66946007)(36756003)(9686003)(7696005)(956004)(2616005)(2906002)(478600001)(6666004)(6486002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8E2E+3VTbn9j1UUFbdbnKO/Rfz9DelXkSEoG8+cIJCcncYzvLsIn3IJr13EPqS1X7SDMElJZ3iB4N2X7mE7N9nqT69YA7VJRsMAYa6vUdpSCBIm3RApjVPLffdF6RNsHDGN7dYzZZQFr4Gm4lYMR2IFNn5S0beAhNaspZhJH/XZzHtU7W6jXq+WCS8vPE8jIFv+MYRxTHe8haFiz74R6w7wRK+MBbvbrrEuTJQu8QMcyZ+qNEgUpkRdj7aKM2KUgLLEx9t46BaEWi0JpxQGKqGp88ltq4vbekOOPmTSDA91pLx3W60SOiQMdjl2eo8MDyaHKf3gn+1ugZcZ5RtCzKvDgDubw04EUaZdwZtVJj/AqqidD7tVJxOq3U662OwacamwrtIbu4MD7HyexrXLgnYEuE5ps1y0G9kn26r+t3evNy74ZI4YjlbUoEQEX+GtCcNaTFEEJXxXQvH9HEG7pHgLe6PZgfODk1AESRhVUcJNXPcjdENdCun9WkDCnI6rLrIDqIVD59EclTY3xcp8vYo/9kEgAqLl8MlEAW88zbYnbiHYiPANM1JYPdS0/OgolmL0okc6I/96Bj9QRcMx6oCZQYu6i0hKbkr24qbbdYQuq904n7x2KUhL4qU9RqPGCcetlXM/k7mHj6OSYa30jYmsAXNoEMw85SXJyMPVtrW2YYkmXJ1Jw9S2hl7Z22MpJ3Za8fyQqTtC7QmzZ2AoElTFb/nrOB3GQA3UichGQjQXXKpamLi7ehqnHjMoZjTBs7ryqoVhvq/6WlEAeViiAhcP/Q6oOBqNSQagadmCButyy5gFv3ID4DcIA8sYDmS7Y7p7NCN+hKHkR3komdJgMhz989kqYAvgOJ3XjlXxcdp+dH8cwhxwLvXNNksjLcBm2497JAhMT1YXSN668AoHJIw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417d281a-eda3-471f-6562-08d8914be3b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 14:10:40.6724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN18pwHvws5OobhvhFV/RIbaqqeR4eheFzjB5e25s8On0hoQv7NcKMqiyr8TqUrO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2759
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
Cc: Andy.Zhang@amd.com, Horace.Chen@amd.com, Frank.Min@amd.com,
 Jiange Zhao <Jiange.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiange Zhao <Jiange.Zhao@amd.com>

In Virtualization case, when one VF is sending too many
FLR requests, hypervisor would stop responding to this
VF's request for a long period of time. This is called
event guard. During this period of cooling time, guest
driver should wait instead of doing other things. After
this period of time, guest driver would resume reset
process and return to normal.

Currently, guest driver would wait 12 seconds and return fail
if it doesn't get response from host.

Solution: extend this waiting time in guest driver and poll
response periodically.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 11 ++++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f5ce9a9f4cf5..d8d8c623bb74 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -187,7 +187,16 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 
 static int xgpu_ai_request_reset(struct amdgpu_device *adev)
 {
-	return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+	int ret, i = 0;
+
+	while (i < 11) {
+		ret = xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+		if (!ret)
+			break;
+		i++;
+	}
+
+	return ret;
 }
 
 static int xgpu_ai_request_full_gpu_access(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index 83b453f5d717..20ee2142f9ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -25,7 +25,7 @@
 #define __MXGPU_AI_H__
 
 #define AI_MAILBOX_POLL_ACK_TIMEDOUT	500
-#define AI_MAILBOX_POLL_MSG_TIMEDOUT	12000
+#define AI_MAILBOX_POLL_MSG_TIMEDOUT	6000
 #define AI_MAILBOX_POLL_FLR_TIMEDOUT	5000
 
 enum idh_request {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 666ed99cc14b..0147dfe21a39 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -200,7 +200,16 @@ static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 
 static int xgpu_nv_request_reset(struct amdgpu_device *adev)
 {
-	return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+	int ret, i = 0;
+
+	while (i < 11) {
+		ret = xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+		if (!ret)
+			break;
+		i++;
+	}
+
+	return ret;
 }
 
 static int xgpu_nv_request_full_gpu_access(struct amdgpu_device *adev,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176D2C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 05:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE25020714
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 05:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oN2q5zXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE25020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F646E0A6;
	Thu, 23 Jul 2020 05:12:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1BE6E0A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 05:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1VD4N5n9SxmsgJaF37qyMu01SXWxMlhaJQqU6zo7KuX4bRV/ASONfhH1+ybPRhGAeEER2dYQ4SlSGxXCXzgIzQ/b627yp1TGeT3dzg6qWFx819d19m8DJdg7Dho+NssO9SgBhiClT6UsEtnszOxPJenLszCAW7kPOufQfjvhvRX22X3C1e09Kfk6zwQxDbXXLuS+XD8PpX5JKJgCzuekHq+gFzR7VAdktn64jo9QAlLwbeGQSWKj/Vdz73DiJIgU7CrZmXImSe4BLQYx/CSHU/1TPXUBzN41sQ7GKr5RmnrivFQkqDME7Pl2m+2kJKZe8C1NUDsgMeOgH2DeU4ThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3zWieEpNU61IiLpRfzSMIymfB4PSNs83e0ry+r6JJ8=;
 b=lDmn4E6dWQbG/X7S6Ku/IOWPkbAjfjO3BSRi9p6vxKP/ZNumbYTJ4cAn8BuZWqyEplLDmDPu/XVxdIjR1oVrLiPa6J0o0Cd5c7L7+E9LNXgJdp3b9K/sq8tt3xh+6XGYzRdzM6bg7W4OLuKvkkrgRmcg191ZEMmkfnXIoOeiKO3OaWa8PIAr2bDiqqi8nsJNgb3sqz4nUdJ46YVT/zrfUzpSsmmpraTk2/ptzJwgoxzOW1YImzTgacZtmTMcSP854Q/WN0LCG2Gek6DXQD9bfSV2ubqyjbsFpZWANfm+9MY7OAAslNwiT8poA/gJZZ1hsUFeyAaHTZ490tj0mKl7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3zWieEpNU61IiLpRfzSMIymfB4PSNs83e0ry+r6JJ8=;
 b=oN2q5zXijDA1lZRFzfzTX4cIJWpuYl8S7P/IOSQCFFXmSz+Ob5c8k9i9a24epiwo6HHIBuyv6iZppQA95dtd6t9VQbE1YaGwMluUnrTg9bgpt3BCUnfQGQGXbUrTv4poUHUAv+K1IqhfSFvZ+SfNxBnubF4PymscHfhnDBbV8qA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20; Thu, 23 Jul 2020 05:12:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3216.021; Thu, 23 Jul 2020
 05:12:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhu, Changfeng"
 <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] Revert "drm/amd/powerplay: drop unnecessary message
 support check"
Thread-Topic: [PATCH] Revert "drm/amd/powerplay: drop unnecessary message
 support check"
Thread-Index: AQHWX/5AGkluZ3ilk0aaBEkALrsTG6kTP01wgAFc2jA=
Date: Thu, 23 Jul 2020 05:12:00 +0000
Message-ID: <DM6PR12MB2619C943A0AB43FFC53BCECBE4760@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200722080045.4178-1-changfeng.zhu@amd.com>
 <MN2PR12MB417536617C127BDA31E875398E790@MN2PR12MB4175.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB417536617C127BDA31E875398E790@MN2PR12MB4175.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-22T08:11:36Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=56551eca-97cc-437a-a877-0000ce1ae798;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 923312f4-c244-43de-0332-08d82ec6ee4f
x-ms-traffictypediagnostic: DM5PR12MB2470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2470A363EBEA11F85B14FCEBE4760@DM5PR12MB2470.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D5C1DGfWNoRsoIPWgmkAYW6W4TR0LxUF6/vrHRSNYu9pruugC0H62ACDQuMLeTL3XhsKnPS/oy5K68kVtwWuKimw0L9JoUrGb8Ak5hDSDIQYa8CaUXHRwnobR/KL0ytdZSuKTaCJJc8TXIlqUpBCWDHqevrdqOzKmoSpGMbHZU8CkMA3yeBkUxNHQZxAfowEt1wa6G4tX4pd0snklufWqVpyDeFpPBeTVsKJjyU3b/3WwLBFkRTdHV7W1W2Y3KUyAPxjSaYI/xO7LkPRZ6IwiR7il/UwqFYJcGfZBUXZSuK2HZkS9Kd2rlwiAxfFbfeToa2Lfwo2x2HaZVvdL5hNhUxgJ+ojx0FYmb1PyeR9nT4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(33656002)(45080400002)(26005)(316002)(110136005)(71200400001)(8936002)(5660300002)(2906002)(86362001)(66556008)(64756008)(966005)(52536014)(19627235002)(7696005)(478600001)(55016002)(6636002)(8676002)(9686003)(186003)(76116006)(66946007)(83380400001)(66476007)(6506007)(66446008)(53546011)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5wje68le8GFBieLX8yuTo7If31YR2ceEqTuMqgU0l/5qpqHyDjgsPtCk/KrZIE7Xc4Sbg9yWSNEng1EYETlFRXKmq4jMzOK3TDgTlWRW+opJzEx7Fr4ltlVapWuHTnzl2KDjg2RXd4wOG0FJcJjQR9IgF6jtpZQdaRLOJTTjhhHx69zlU4lnAQGs5DBVw2Odu6UfU6D+ae4ilFdlCtCnoHCTkjCueg5OtTz7cxjibJYo7lzY2YXbgZ1QUkujPWxho5l35Ng8HFlOG29iKRaJJy5Rg8Y/OzCzRbCoIrEO7W/XLV7Ag0RMxwAfDsaANfBQpt9DuA4W1Xwtk3uHk/YH+/KgGhGyfq03n2pfvM3lAo+I4PO2i9ErOLgzbnnzcdi9Om11fkc9WLmmFIH/KyC/oOdKXeGsCUXy1IPGkxyJqs6MHgecO+dn0vPrKOE3nIO4rillnol9d1r53aPUQwmLcsc+/Y2Bbc8E7I/gkpfCJTnFGL+KNe9eS9EXAE9gYfgC
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923312f4-c244-43de-0332-08d82ec6ee4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 05:12:00.7883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TskYfnZJ266ja5/bG0cfvH+TycEt+EGcanIy4dU7JWc4aZy31QD+gjTKLQKfvk+s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No,  the change below is not a good idea.
-#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
+#if defined(SWSMU_CODE_LAYER_L1) || defined(SWSMU_CODE_LAYER_L2) || 
+defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
These are used to guard a clear code layer. I recently just cleaned up the code layer mess ups(which produced lots of redundant codes and made lock protection a disaster).

To this specific one, whether or not to use smu_cmn API should be decided at ASIC level(${asic}_ppt.c).
Each ASIC can have its own implementation or to use smu v11/v12 common API or even smu_cmn api(shared by all ASICs).
But all of these should be decided at ASIC level.

P.S. Likun sent out a patch which should fix the issue here.

BR,
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feng, Kenneth
Sent: Wednesday, July 22, 2020 4:12 PM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com>
Subject: RE: [PATCH] Revert "drm/amd/powerplay: drop unnecessary message support check"

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Zhu, Changfeng <Changfeng.Zhu@amd.com> 
Sent: Wednesday, July 22, 2020 4:01 PM
To: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] Revert "drm/amd/powerplay: drop unnecessary message support check"

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

The below 3 messages are not supported on Renoir SMU_MSG_PrepareMp1ForShutdown SMU_MSG_PrepareMp1ForUnload SMU_MSG_PrepareMp1ForReset

It needs to revert patch:
drm/amd/powerplay: drop unnecessary message support check to avoid set mp1 state fail during gpu reset on renoir.

Change-Id: Ib34d17ab88e1c88173827cca962d8154ad883ab7
Signed-off-by: changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 9 +++++++++
 drivers/gpu/drm/amd/powerplay/smu_cmn.h    | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 838a369c9ec3..f778b00e49eb 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -34,6 +34,7 @@
 #include "sienna_cichlid_ppt.h"
 #include "renoir_ppt.h"
 #include "amd_pcie.h"
+#include "smu_cmn.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -1589,6 +1590,14 @@ int smu_set_mp1_state(struct smu_context *smu,
 		return 0;
 	}
 
+	/* some asics may not support those messages */
+	if (smu_cmn_to_asic_specific_index(smu,
+					   CMN2ASIC_MAPPING_MSG,
+					   msg) < 0) {
+		mutex_unlock(&smu->mutex);
+		return 0;
+	}
+
 	ret = smu_send_smc_msg(smu, msg, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n"); diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index 98face8c5fd6..f9e63f18b157 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -25,7 +25,7 @@
 
 #include "amdgpu_smu.h"
 
-#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
+#if defined(SWSMU_CODE_LAYER_L1) || defined(SWSMU_CODE_LAYER_L2) || 
+defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    enum smu_message_type msg,
 				    uint32_t param,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C8105bfba31de4bb7bc7f08d82e16e403%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637310023202564830&amp;sdata=U0HuFMHcmQ6ZtPsdL%2FisRBIvR9J422uydwWuDOY%2BYF4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

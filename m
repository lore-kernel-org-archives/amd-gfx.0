Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACC5C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 08:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D25D20657
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 08:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zr//01CN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D25D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7B76E7D2;
	Wed, 22 Jul 2020 08:11:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9EB6E7D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 08:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsSFcH5SbD0AJDJduNlgQXYc9ykHSj00fLNV8EQ95zboBn0ZNN/FkdkX1EsJGDS7Nqgd/+MTaf/2VV71L1KJHr41QX/kfD2IL8kg5Gk7OuwkJWsnf++HY+jKtvzO7jFOz4qb8A3RJsahgBastx5GyPa0RoHU8OYnfHVrIZRLAPUZah9SOxU/l8gts2y8pCdPGqHHL4QbQSQdzGuwINa2bRhPqBlyBXjxrofh8cgpXBpjG59HlY+EvkEXopcdvDHsmvDcAva7HtFyY6DTg0+F2crwnFTv2KBDJVCQyA66q/iymt10luk09KAQqv9Scx7rwRrd4nV1V5UWQtn4ShrnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txJvWhsux5fk16YqvQG9OoHEIOjWvFEFixn02loBHbo=;
 b=b2gw4nT7MP812hoTgFE8C7ZUiQGKlCwpfjTJRc8SjI3CbC6twYSLK9FYreM/FUKAZT4mQCjGhFN+MKVGGBKuGs9cGx8ak5y6V/HWses8RWCUGnggCvPqOeCfVzAjq2jKqqCyR7kRWOXIUH4H3xRtL1VnoYB0rGd4myJJPO/1xEXUeO9AekXypTd47sIhV/XTXpvfisH1ZHVSRZasyAH9eWgcpIs0gVYEBhLWMWF70M1qrjM2egcpuS/OyAKnTjJ/gaadmL8VugJyCtxwcwzsn8ddeEOrgK36Q+61VsX+mmPjhE4U0HzByuNfFt03klj6+xaz9tOLXFZGOTBtVWGcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txJvWhsux5fk16YqvQG9OoHEIOjWvFEFixn02loBHbo=;
 b=zr//01CNWkQYMSePwFM2Y1b0pdgL1qDlwCsnSKKt/tL+hW9nOeesoGNYPiak1P7TSgxOCS/aV/BwtHsQYOMx3GCN92mjoLE9qEZDbsZTJM4GzNgT1lNmxmU0ZeBAF2b7GKZkXGVsnj3TrxsQSERajDEG/kwwT6nYUKKJcNCUZ+M=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 08:11:49 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045%9]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 08:11:49 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] Revert "drm/amd/powerplay: drop unnecessary message
 support check"
Thread-Topic: [PATCH] Revert "drm/amd/powerplay: drop unnecessary message
 support check"
Thread-Index: AQHWX/5AGkluZ3ilk0aaBEkALrsTG6kTP01w
Date: Wed, 22 Jul 2020 08:11:49 +0000
Message-ID: <MN2PR12MB417536617C127BDA31E875398E790@MN2PR12MB4175.namprd12.prod.outlook.com>
References: <20200722080045.4178-1-changfeng.zhu@amd.com>
In-Reply-To: <20200722080045.4178-1-changfeng.zhu@amd.com>
Accept-Language: zh-CN, en-US
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-22T08:11:36Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b009e925-bd6f-46d6-ba0d-0000a1211b06
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62c4ee92-a3dc-469b-b059-08d82e16e256
x-ms-traffictypediagnostic: MN2PR12MB3759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB375920EF8C780706A5280B798E790@MN2PR12MB3759.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qy4GNOAWqQHuUdqmadPykk9669EPPLaJBS80lbDSkUr431BZNMO2hzjXZB4JqFO1F3EK3n4jMLKsJgmZzkTLkm2i3nQQqddKibvz5OJ3Tb32rDnJr5Dpgx9hIih2lEhxjG09svGqZk0T8XEbLM3POfKOqiT/yl82Q8FuASTWEOwFSlMf0w8+pKfdNIeMKhGbr0mB3OdgS0DUH935niHUN/+2J9egROSclT8euZIaxu+SoMuhVfuS0/b9WuCLOae9HiGGp1TvOeTHW6D7WKCH5bbL1hE0P01yezy/m/6Bjwn70PIjsXStatlPbIcSSDEq59hFXZ+UnNybUBYmcTTBtg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(52536014)(66946007)(8676002)(76116006)(110136005)(66446008)(66556008)(64756008)(66476007)(316002)(15650500001)(33656002)(2906002)(6636002)(9686003)(55016002)(478600001)(5660300002)(186003)(71200400001)(19627235002)(83380400001)(7696005)(8936002)(6506007)(53546011)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1UL8tZW+Bd+YWUwx8ZTznzlf8yxlUqiaEjkTJVlLiGy7omphNuR+LwNsHznQS3VywSeWOjHBARMPDLWU9foZNASDfAqdpf+DkT3WRM0EfEzPe1GFyWFOjEbdCF2H9FxKcGs4uhX9a0QF5WZW69V6zMIdj45VhLMlA/Ns+5sFOzOxGGXvy7Sk+7oPmNUi8fy/LZ+6eu+3D5OOVBJCcKH+cgbW8IzfsTgh40fsOrhNmwoqA09UBiEV1Zxz/3m3ZZqcV4NUP78cwq+XGpJAkhpIcJCi1dOeHtOGx0Te3Ow1692dkU5rjtGKSaKHJs1LjMlUKjHSSKMojvt5SR3JzPvaNyNbS8OWUreH2Jlyxkccfxs4IApkh6Xa1tTrKLPCXcsPEeNOOsMk8Wb1gQDFxsfeILBZFJ1+tNn6j1u392H4BrmVr7dPABJ/QfE/tscFweoGDJaXupC/EvJnogNbCHweZtaD4BopWkl48h/ZcfjiF32U8mgLUGKX9KSY/MMnVUZD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c4ee92-a3dc-469b-b059-08d82e16e256
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 08:11:49.2025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYciDzQaUmPrl0q0cdBZzu90G1EKXtwpqwTHjUZz3Bw+VuTj6zI8yi1t9DDbvdvM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

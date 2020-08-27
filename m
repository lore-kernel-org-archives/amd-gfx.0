Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C70DC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 05:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4298B2080C
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 05:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BsnqBJJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4298B2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03486E049;
	Thu, 27 Aug 2020 05:12:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A796E049
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 05:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+npWPNBdzwmEhb3+ML+SHlIRPDwQ7MXamRuIgwGelT6+FBv57m+667TIzDbXIK5jd3HgEdj83A2BH4Ey5i2r17AoGL8rblwbmfqT1GAuhWhJWJF8JazhwCUsjbgKzLQUF5GQLcSISAGG7DtOOpRuS+kDrHfOvHQ63kLapgwS3OkUPRH0CR9fMrBGIZVdb4DoaBEWnpB9H2bzHI2nVoWhHZv+JScWuFUjDTJO7cCuGDWEZvcS+tKzR6g4ytgLAD238w4AsmxVKiGGGeQKoIQefscmQMvHDwfStBEA5OiaSpsBuNe7K4tZb4tC2fw13fPlokxMAyZpai5u1Nph4VYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59PbqjT3G4L3qc5+gDkANa2Cuts6LfjtW3hMOnRNZ50=;
 b=HTvdqOgFod9Jk9AKnoJWfndq4hqklPsXBKkstszYVX3F7E92cX1jhOEvI5/tMjvdseW9Y1W7v0uoONEkrZocIXrXgnA7slo/Z45QvKSjrFeaJSilNjU1eSYv5RLXnVuOk0FF+AGyty4O3wKWrvKS6FCVn1dtXjZShdpRYyMcE3DUPsrvq4ngzYF5Ce70p7KC5UHPCZ5ZhtfUARtydTdhVEZzvG+0pliiMIj3nE34hOA23ZSIYEVezSxJ8LkMb8384EaLTbd7iNBpaiFGrMnlxiD+9S2x5xxMZ0TLIDoJzS1Vsx/AVXt81ur/1NS7r0o4XrfshxCSTj3p79YJsccvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59PbqjT3G4L3qc5+gDkANa2Cuts6LfjtW3hMOnRNZ50=;
 b=BsnqBJJprpSSYnyr35+JZBW+znl8mUS79nIk2Rrpc8oGLd8zQZSaFnfCTwuRO94Ygv3RjAh8C45C+FC7i81S+kJr7S5aaHzzlUjIR0t41oFTwrzWa4JgdKwIivNnvfj/q6TAJgwwzsLZzZ0KAbIzRGJaWh6YDGPcaaGmHwytxn8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 27 Aug 2020 05:12:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Thu, 27 Aug 2020
 05:12:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections(V2)
Thread-Topic: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections(V2)
Thread-Index: AQHWerRL/uAEDSukPkeF+dR0FbQ/86lLa7yQ
Date: Thu, 27 Aug 2020 05:12:00 +0000
Message-ID: <DM6PR12MB261915C78B63850BD7DC7124E4550@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200825074923.32345-1-evan.quan@amd.com>
In-Reply-To: <20200825074923.32345-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c471d6b0-d423-4b9a-b838-e08b0faab2a1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-27T05:11:52Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afd3293e-486a-4e38-2abc-08d84a47baa4
x-ms-traffictypediagnostic: DM6PR12MB3466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB346618296EBD3A727117ADDFE4550@DM6PR12MB3466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H2SGw7QTd32ZMg9TJkqPvtgK7iO9y2aMmidbuh03+ezPYvpreHWye/wcU0pCX/LtFdeXIkpxk+XcWboIOPYS1FbkaM4+dSdOjQwVm1dcF8qQIL5qYEAv5Z34xpGuCrT0F0+YS1aF+HYR/7cVRtVmzpQjsMZwDxnpSnu1Qf9przkaq5H/G9eunHF7YsTmwBrlkoG5zliyvlQsKOtg+nfses3f6KwSSJYJQIf9hfXebJ87jpgchmQz+E82VvY+B+Hh+yTp6rsXUwXEK1MqhT9z4Y2RFkbqAQkTaBXJaofWGGa6GEw9GZYrlscwKd7GI/1hRB1xG6zJc8k/5UfuVTwmVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(53546011)(316002)(6506007)(8676002)(4326008)(71200400001)(478600001)(9686003)(8936002)(76116006)(6916009)(52536014)(26005)(86362001)(5660300002)(66946007)(186003)(2906002)(33656002)(64756008)(66476007)(55016002)(66446008)(66556008)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UHhMqM8GynAYzKwNrfPaiiHb1yr0gJSoJddPhesN1MAFHKoId1uL+yzNxLHwo907KOA2FxowVgIjH/wqB8ALQeHeI3SlIzWQuMnflERw4tUrnBPaVrTqwmf8/kewgO+rrTrps8xF5f6xtutF1crcauKZdpi4aMbdCRouNp1d8t00FVeWQhG+Go0we4TAqU0T4FaA4//imZAfb/xDoRaklIZe1h4vzWUIGCb7BRG441PfM7VJo6acYWEKyHHTthEsEYl63l0Wk6+GRV0gNWcP2Tz9Z/A+uT8GiOv8latEvzmdyZFNeZilU3eV7MqaiaZ6N0CYvJu6IQtGlCy1dwmfZwGA3sEcTdXOiu84ULvS9jepXn5SdjU9xT3adl/DEcIBuSM4Eril9C/15bnGeYAGd/yJ7R/baXOAQ47yav/NGR9hWtcR5KxnciaMlf9+SaS+DcWoHlnow6jqHtZeLHQt9K/d6V9Ts/204Kua8J5spOqLXTpShwNzWbCfugZKl7ovXNlOimI9D92rYKuyXTDGqAiNDSBb2mhiWTw2buGG4CyAYNL89rFlu9KX+rWdAFohYoHJDeMQuITk+mlC8xIsqn81DHHaGMgOS215sH1ZgNSQtwX/q8JCzYB0hf8bRD37mChkRebnnhDTPQI7H5lVXw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd3293e-486a-4e38-2abc-08d84a47baa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 05:12:00.6430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pImLl1fxmdxaq5/fil7frBTwcMac9clpJaUIVevRMoTvaKZgPYQ3FE7joww7bth/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping..

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, August 25, 2020 3:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock protections(V2)

As these operations are performed in hardware setup and there is actually no race conditions during this period considering:
1. the hardware setup is serial and cannnot be in parallel 2. all other operations can be performed only after hardware
   setup complete.

V2: rich the commit log description

Change-Id: I096d7ab0855ff59b0ecb56fd9d6d9946b3605fc8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 4 ----
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 09dc5303762b..b7cad8ef6153 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -361,20 +361,16 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 int ret = 0;
 uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];

-mutex_lock(&feature->mutex);
 bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
-mutex_unlock(&feature->mutex);

 ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
      SMU_FEATURE_MAX/32);
 if (ret)
 return ret;

-mutex_lock(&feature->mutex);
 bitmap_or(feature->allowed, feature->allowed,
       (unsigned long *)allowed_feature_mask,
       feature->feature_num);
-mutex_unlock(&feature->mutex);

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 548db1edd352..28a19ffd22a1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -721,7 +721,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 int ret = 0;
 uint32_t feature_mask[2];

-mutex_lock(&feature->mutex);
 if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
 goto failed;

@@ -738,7 +737,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 goto failed;

 failed:
-mutex_unlock(&feature->mutex);
 return ret;
 }

--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

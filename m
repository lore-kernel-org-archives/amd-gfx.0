Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F36DC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 05:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BBB20782
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 05:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VtGNLyIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BBB20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E58289DD3;
	Mon, 31 Aug 2020 05:03:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61C089DD3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 05:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3jD3IA3MTasp/jE7ryDbFf8e5xd6K/qqZJGfcgkIqQFS2XtjuPUlkVnLSXCx9B0E2SkBSrhWwEfRMyJTD7Dm0bPo7kvEYvWGFderQCnIF22H8ccoblZJFMq1efmTVOCerxpmA7CYtPCyqT2Zs+GWVRLJo7V/gOI1Ofhx5TjArDAw4KuMDLtYqZtskdQ39EoVW/9WpSIEO81jvdioAehkfDgsAESi/9wDS2ubHt3y240kIVRt3pzxyG+JZaQNm3ve9qDZwK9uoeFFDFvdoACXL4qdTJ5dhVlX75E5/TFbr21RR4q/OBDDWTwY3n43a429+lvdZ56PITywCTXyVDoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRogkQYNVAZQoB3niZ5Sy5gdL67SQvtHDPEfu8EISMw=;
 b=BGIdJ6ZoQq61TH/DuEVTfjGwycSi0k9M/gF84gn2zKdyO9193uQ7rILV7FJBmbzkvczmWPyhJCQNJBO62gxhqRUUSnzPsaT/3OeNhFHPyGvr4koY1nzWwMcteG0EB5ChEGXphyR2eBGG48WvkCw5XZB5zInrjiRQ9WlP3XYx0KIWnONm7Y/R10z+8EM5kP/rVC2uTIz3i2MePOPvIcstN4x8pv7OLAilT0mXDYUbKykJvnZwGX88Byy795YvlqHQ1ZErmnzlaxC41PK6/j9wR8CbXyc0+Iqo2yyUhgOPcMgyRg775oWKvR2iAQldc/QLfNFOea7e0nKux5HdN3Ifww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRogkQYNVAZQoB3niZ5Sy5gdL67SQvtHDPEfu8EISMw=;
 b=VtGNLyIQYgKeIti+nh8Brtm/bA6gVKd8Hc1+CCY2VKM/rna495qNrrsmmZL05VhfKUpPcfr+AauguppkcPPRdjpPz6w3+E5WOoapZ66Z7ooSswYKc9DrKuvAlaLiRjbfAXlv/C5MHeJsCqtBlY0z6otliMlnKbp/xD1TKr+IHoc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Mon, 31 Aug 2020 05:02:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 05:02:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/6] drm/amdgpu/swsmu: handle manual fan readback on SMU11
Thread-Topic: [PATCH 6/6] drm/amdgpu/swsmu: handle manual fan readback on SMU11
Thread-Index: AQHWfWTzuC+3mpdh8U2HoS9zD2ypaqlRrQGA
Date: Mon, 31 Aug 2020 05:02:59 +0000
Message-ID: <DM6PR12MB2619D1550667B81A5C638403E4510@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200828175853.2378523-1-alexander.deucher@amd.com>
 <20200828175853.2378523-6-alexander.deucher@amd.com>
In-Reply-To: <20200828175853.2378523-6-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=35826a64-18ae-4f50-a09a-efe5f927225a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-31T05:02:17Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bce5f5ea-88bb-41ca-67bf-08d84d6b2182
x-ms-traffictypediagnostic: DM5PR1201MB0217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0217BDEE4C6DCEF203F5AD23E4510@DM5PR1201MB0217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqMrNimEBbT1f58TKm+IPM7pUVB4FL4SQOi5caW0jI8HvNJCo6hU3h/XThHfGOqA7VhcWFXdWl2ha45PrBWOch+WY5ACLlVqB6JCloYSI0j769VRVhwxTsQmM3iMlhQaKQ5UbiDc/VJBusvXJMBEFApcRTj2JnGVzAhQhl5SqARQNj0J6WWbEFn1RhIccmRI4IBLbcrv2iiHsgjnbmMfSrpT3X47PyF5Kggxn4B1ZwaBuxlNiYkVfDShtWI11vXFiIxhWSQyA1oxM8U72YeWjWoLxKJhG6ZqsDMj9tZmiS9aXstMxdXSJ7ZHSbuD4LoRFfZhxcOy5lOVy/SODeg+Ljpo+IkjeAskUanPuOA4b5E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(71200400001)(966005)(8676002)(55016002)(9686003)(478600001)(33656002)(8936002)(7696005)(53546011)(6506007)(110136005)(86362001)(83380400001)(45080400002)(66556008)(2906002)(76116006)(66946007)(64756008)(26005)(52536014)(186003)(66476007)(66446008)(316002)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 8OvCqT1gOXdzW0fHogdax0p0lxbMh65JOURyakK34GEkyCJrzQscyIVN7qscrJWV6N3wNI61gFJZxckDIHgAvxQIhGm5CdvpGcXSVrvQlTh8CQRUJHgaATKpNyz9GkA1FuIAyhYB7qJw4bvpPLvCbMnSZ+pRdmclLY/Mj4XPdks/jwrsyJPOagyXXYQ7b/oa4Rd9gn29pqZ3pziW6v2fYPyhAJAi4CiaWeq/+rHI4skLBDR+TUy8fCxHBh0ffh99DoVt9V+ue6KSQe9S1d86pCYm1p91bi8q7TNjTtGe6V1NZEuJ9alZZkiADas5sciVuorPSpJsbKttiMdMugsU3rWOKLC/p/ehinFZ/JgXL43f+kOVqguD2VVX2+PIoLkJMKgAu9MOqnFcwlE5ec6/38Ihg85xBIQAINnRPwrmQltgNmLjPMf+j9dTfKNXWIDDi3e7xp5JWel2vwmw3rHgq7q/d5aVq0OWE7fDAJzsrQeWbxVkFc5ca8Empa8xF0XVZ72OCRjbVGY39BSBHv5bDW8VNXERAkpnk6mCtGif4HbKZO+oHFU4SwJdBtV/umnerpP+hMW9esFsmZ98b3ZNezd4yURecHC9sQLYi0uhl0g7pkOAH7fF6E7t5z8W8oKLLdIbouGW71NEW5z6CSrTUA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce5f5ea-88bb-41ca-67bf-08d84d6b2182
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 05:02:59.0689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrlzbA1OJ1OPSVLyMlzA3tOHi7Gq1BudM9H2sKKOztnDioJU+WyeO8EUt2Y+yMFa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Saturday, August 29, 2020 1:59 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/swsmu: handle manual fan readback on SMU11

Need to read back from registers for manual mode rather than using the metrics table.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1164&amp;data=02%7C01%7Cevan.quan%40amd.com%7C4fdd9ee7de274e193ebd08d84b7c125d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637342343592341398&amp;sdata=O20Z37%2FF61iFiAGd9o17bitxAZaSfSnZIBCeoEl68zs%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c     | 11 ++++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c       | 11 ++++++++---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 ++++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f6d9b0db3e82..2ce6ad9c6609 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1123,9 +1123,14 @@ static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
 if (!speed)
 return -EINVAL;

-return arcturus_get_smu_metrics_data(smu,
-     METRICS_CURR_FANSPEED,
-     speed);
+switch (smu_v11_0_get_fan_control_mode(smu)) {
+case AMD_FAN_CTRL_AUTO:
+return arcturus_get_smu_metrics_data(smu,
+     METRICS_CURR_FANSPEED,
+     speed);
+default:
+return smu_v11_0_get_fan_speed_rpm(smu, speed);
+}
 }

 static int arcturus_get_fan_parameters(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 87b5f9ff4021..42d53cca7360 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1362,9 +1362,14 @@ static int navi10_get_fan_speed_rpm(struct smu_context *smu,
 if (!speed)
 return -EINVAL;

-return navi10_get_smu_metrics_data(smu,
-   METRICS_CURR_FANSPEED,
-   speed);
+switch (smu_v11_0_get_fan_control_mode(smu)) {
+case AMD_FAN_CTRL_AUTO:
+return navi10_get_smu_metrics_data(smu,
+   METRICS_CURR_FANSPEED,
+   speed);
+default:
+return smu_v11_0_get_fan_speed_rpm(smu, speed);
+}
 }

 static int navi10_get_fan_parameters(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 863372436b98..5c22611d5878 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1169,9 +1169,14 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
 if (!speed)
 return -EINVAL;

-return sienna_cichlid_get_smu_metrics_data(smu,
-   METRICS_CURR_FANSPEED,
-   speed);
+switch (smu_v11_0_get_fan_control_mode(smu)) {
+case AMD_FAN_CTRL_AUTO:
+return sienna_cichlid_get_smu_metrics_data(smu,
+   METRICS_CURR_FANSPEED,
+   speed);
+default:
+return smu_v11_0_get_fan_speed_rpm(smu, speed);
+}
 }

 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C4fdd9ee7de274e193ebd08d84b7c125d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637342343592341398&amp;sdata=3gOUFWAaLuSkN%2FkwjCb7tO3zTgBixYU1uLGENGv9FQM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

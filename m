Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA001C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 06:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70E420792
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 06:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u+c2mI8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70E420792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF6D6E188;
	Tue, 28 Jul 2020 06:26:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B7F6E188
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 06:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqfaPiYLtpY3VShA+2PNOZjtlRpa8+VB1Ul9wBlcn8EUNu8a035kzaPMlmQX/8GXjfHAOD6/puxX6kUTIVJRUrQYOerHDY40ndaNFAl/ZSNd2hlcEcaG4UpDT5JUKrRbmMy6cZoUYTFgEWrbyS6X9sWdDgB617m5fKk3yrmspQenMWtvw6syQN3/4Pv0cBxXb0nAksYwCQyFfzpI95l+73mu7wCRaZLHdJgSTt/2W0QhpdO6RAKRDelyJTn5VFDNEy3ZUdsRDCYKfbD4hcZ8mEyQ7J4xgmKbYbh9lyELgWNpyRTHIRI2djyacMMnAUrJ/oXcy0ICVYqQEI5ANkU40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jJQPH2z5IwgVY2m5k7gTdK1IeuYqCTINTJFlwIIe7Y=;
 b=QRCmd7r9npODh6aZJjNBMy7V41m8Un1l5bS8pWtXfWB1ctbiuwuAT8zYtGWHxCc42J61PaRy7MYGjh2PSJS5XIkaSwTnrweHKneWLnJzG3YL3jcE3IWI4HNa1fx8hZ1Ff665QD9Qe61Ja841jlhU3qNmilUHsw9KwsPmNj+vZKmEK5g3VK+Ia8Jdtm/DVhAtb8ry2h5+CjWZMmdMXA/X6jx/x0UitT7spyIFVQ5u75oFW3lyskX3Y4yWclVqZdNN5WHj+PtMRck9XNhaSucnak/0Ts+DtzS+5vGPzldIxMA9Mp7omkOu+G2n5babnDI9Qe1O2BCbJzZaxOLvfDsVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jJQPH2z5IwgVY2m5k7gTdK1IeuYqCTINTJFlwIIe7Y=;
 b=u+c2mI8BI2cb9X4NHSnTp5RXGZOr9eqdT1zfXDqwwW8m/5r9JuUF1/CXARXGrAtldCUEpWs4Gm95Ia+OnSUZ7PznWMpXWxbYKKT7w9jXY0/Eq2YguUNZ8R+e4PLiIblU62Omgc5Ptm/eHOfvNxr8XLB8tdxM6W5XrbxQfezwqeo=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1575.namprd12.prod.outlook.com (2603:10b6:910:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 06:26:25 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 06:26:25 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit
Thread-Topic: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on
 Navi1x after GFXOFF exit
Thread-Index: AQHWZJ/OP5aeB+Pms0mXhJwSvYPLFKkchkIA
Date: Tue, 28 Jul 2020 06:26:25 +0000
Message-ID: <CY4PR12MB1287B8C26F31BEDF70130C35F1730@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200728052717.21071-1-tianci.yin@amd.com>
 <20200728052717.21071-2-tianci.yin@amd.com>
In-Reply-To: <20200728052717.21071-2-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-28T06:24:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=83d23519-abd0-4b2d-993d-000020fd5e75;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-28T06:26:23Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4f1e6c0e-9bc8-484e-af71-0000dc78aed7
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: beaebfa5-a83f-4edc-0959-08d832bf27ad
x-ms-traffictypediagnostic: CY4PR12MB1575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1575969BC27E954660DF256DF1730@CY4PR12MB1575.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IJ+8uqzE95cVtaj9HilQm1HEFyTpU/+syVN/1HQpAeB4epHw8SWObtiMJZyIAs/1vwgJHqSgfgDeQarehBr1zACpnYjiwWhk0XnJuH8pvOP19vXikDr6jMqBc6Gh2GP8GlSNwFt/tFTgbni5CXdMcJd6NdSzU+rD4RucJhJ/te36Qz4UqVv+TntzYby7YKlvTUHqWi7dGStvzrfhOhj4wWGBLTa13RcDUL/KT/YZuAUUjVlkytJgvfDOmdQNCfPpsqF3u0BxjxdltWpYWh4TnPQIonBr68bFlZDZGSlT40DrXBPtvyTrQXcduPqFtPrpAWfMYZory+K7xFw9oWaoeeooqelajpds9Dhk/9leS9PCCbyfbGKFNuS+GeA69EC5GEY/r4h8XURzCJ/epev2MU7/r3LeNAKXL8YIwf82reI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(83380400001)(86362001)(64756008)(66476007)(66556008)(66946007)(76116006)(53546011)(52536014)(66446008)(6506007)(5660300002)(7696005)(33656002)(4326008)(186003)(54906003)(55016002)(9686003)(71200400001)(478600001)(26005)(8936002)(8676002)(966005)(110136005)(2906002)(316002)(45080400002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: VOZpyeFVo/95h7tIBqDedZ7XEMO52t/69hYIMWZ10NEkOOMvn3zJ2via/RLEyObR203cE+Ual4GKHXJ2vqaqVTYIucE1lYtG1E0ketau9KiPCfMr3Mdz7uDfZVYDPAAdfxn7qoFcUcfGkQonDu8+fnfP2StArhq+/SFTuKbOlj8aXA/B6RxMiykg0GIYJ20udr02v9LGkk/6pk0RfZjf2gWKLwpcjJx9GHxbPI0vtRyYP5YafWNEy+B6rjICZ16kdDKA+NX2yVameSEFoN6t5bG2sJpOqCNAiFgEx3KU4fC09QnxM7/kWu+9ERaclIqCb2ow3Yhd+BIimJE9Rf85GzrggNVG2xO0sw+kF7gzIp9iKnxo8m84OjWmHP4NafgNPnsKnVR3iEDsvZXEMaIZhcmJSbb7VzAOArN0RxqxFyzfFt6GFkgolv2d0vE9HPUuf+mIeAuWPghOnHr99CmoU5Gvsg+haj01mHhV9NAt5SFI8unUFU2QJE4ug7sFYNzB
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beaebfa5-a83f-4edc-0959-08d832bf27ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 06:26:25.6759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQaoxuooCEqnQn/AJopTT//pSEYJ2LJUm6DBQo1YnwdGz/WIppE1rUR+T7Tmx0HI+nykaYlRIT9hdMjxZS05Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1575
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Yin,
 Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Hesik, Christopher" <Christopher.Hesik@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Swamy,
 Manjunatha" <Manjunatha.Swamy@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

One minor comment.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tianci Yin
Sent: Tuesday, July 28, 2020 1:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x after GFXOFF exit

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit, reconfigure the golden settings after GFXOFF exit.

Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 55463e7a11e2..5da0436d41e0 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,
 
 	struct smu_context *smu = (struct smu_context*)(handle);
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
+	struct amdgpu_device *adev = smu->adev;

 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
@@ -1324,6 +1325,16 @@ static int smu_enable_umd_pstate(void *handle,
 			amdgpu_device_ip_set_clockgating_state(smu->adev,
[Guchun]Use the local adev instead of smu->adev?

 							       AMD_IP_BLOCK_TYPE_GFX,
 							       AMD_CG_STATE_UNGATE);

+
+			if (adev->asic_type >= CHIP_NAVI10 &&
+			    adev->asic_type <= CHIP_NAVI12 &&
+			    (adev->pm.pp_feature & PP_GFXOFF_MASK)) {
+				if (adev->gfx.funcs->init_spm_golden) {
+					dev_dbg(adev->dev,"GFXOFF exited, re-init SPM golden settings\n");
+					amdgpu_gfx_init_spm_golden(adev);
+				} else
+					dev_warn(adev->dev,"Callback init_spm_golden is NULL\n");
+			}
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7Ce6176c766fe747a6fe1a08d832b6ee3c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637315108573876551&amp;sdata=43GHkX%2FCRLsfMmNxurLMIZy4l4ElUB2tnslPyfT7NJg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

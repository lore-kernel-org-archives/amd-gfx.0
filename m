Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478DCC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E73C207F5
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fWWItvaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E73C207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853B26E990;
	Fri, 31 Jul 2020 02:34:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F376E990
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLVhRgxxZM50fdW+ng61DSzg565JRDxHjbKvKDM/uyBRxtwiqjZZJv8BuHuoUNhR35r1XCfUKDsluiAfxzd+566SfxrupplpvSl3o7En2H8Udl/AnYiVM+/DBojqksiaJfPHN+JQFD0CKegggEp6INaW95g1BRexHtIimcKUFjf+LQFx1oMlrXBKDZMMFrBo6iVVDVgbEb2e9oRB6qQic87df1VjVUy2JBxExIzOIunFjleqhXXf4yPyfaQx5EyaL/LwtreVSzs0zV3KOsf2/BvLttR9wEQ5bQEaL1fvOZW57up0CSBblDgX4/KqXcWJOwTdcahwTD4oYPBwH4gRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKZV3mx8RTnL9gGhIy6i+kIhWljUVRermlfFqCipgTQ=;
 b=EPThh3HSPPCpGXjGbT7t7RtS5by2uLG5p7RzDPfYsrtWZkKRMQRp58w7XbJZP73dUP1nqDpYYTFgYGpHKyH84qaFz5QFrV3ZuHjo7bVoh+AzNnuAiPprk79ANLJxnr+XHAEjVS/xLobDqhK5FxMTuKOJa2MYa1TQW0pK86bPSxIE1QRSuc7zjuruq3AxAwWHn25y0njcjRWiFXaOE090+CcQUsn6Y0iWKWiMKmmZoqEEX4stMuJpt0E16uWobnKfAG58q98YVv5ffSzawd7aQajFb6FDs5MdoVrEaI7MMQJVpbHAxtAm+CzAeJYtmD8of7LZ+nC7j8kkCS4FWxYPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKZV3mx8RTnL9gGhIy6i+kIhWljUVRermlfFqCipgTQ=;
 b=fWWItvazxV2nbZRmuThAi7sD9nkH60uR/aAs70cgbszfsaFEmPkhyf6RomaDy0oppK9AZl6yVTn12le1/oJA9VRJYEy62YUANY7M8Aa0Zjn9o1evfouIPqgCs5rvRZROKh//+SMPMk1YVpORnEkEVWEVCyhl5FsGWkhCeGX2ZVs=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1911.namprd12.prod.outlook.com (2603:10b6:903:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.33; Fri, 31 Jul
 2020 02:34:39 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3239.019; Fri, 31 Jul 2020
 02:34:39 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 00/12] BAD GPU retirement policy by total bad pages
Thread-Topic: [PATCH 00/12] BAD GPU retirement policy by total bad pages
Thread-Index: AQHWZVPpvByIwWr/50WSgjJ4cIa1A6kgLpKAgADM0iA=
Date: Fri, 31 Jul 2020 02:34:39 +0000
Message-ID: <CY4PR12MB1287BD1A0CDD0172FB04179BF14E0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
 <DM6PR12MB4075FF459BC25066C718845CFC710@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075FF459BC25066C718845CFC710@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-30T14:20:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cfe8bc7e-e000-49d1-9ae1-0000b9d49405;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-31T02:34:36Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 8e859832-855b-4e49-834c-000061b4f3ce
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9b7de18-a2c9-4757-797e-08d834fa4631
x-ms-traffictypediagnostic: CY4PR12MB1911:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1911E1058510875EA62D83A2F14E0@CY4PR12MB1911.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kfkg3fmVTUYpb0rzkgpjZ66Jdo6H0l0xYwZZlqfN439RwjGgX8xxF6qgFyKHLmTcGYnxTWgWfcC6brpQHh3FVGfIDmqhc59Fwj4rtoTOfeA6idBexmMAzhs5/7IUKmvP4bFurFQWVY6WCkHOCibNdfT5I4tS1GiNMdB+fkZOCd0TyfasO/nJ96CaXyLGWnN0ZssCQ+4dwbYNuOZZb4pvreTxojILb8w0eTji6zYW+J5DwtLNrnANdKqnPrz2vWONZ7YxXxMYpPKhtCAFyj6IMiLHVHNLq1uoUH6+UDJz0F0LC+NmqyGE11HtkouzV9aE4AJNcZrmw60sB66lcBeY5eT3i9tQHs/hdIUBw6iOhaXBUj6DAEBcHOFd3QZA3zak
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(83380400001)(55016002)(7696005)(52536014)(478600001)(71200400001)(33656002)(86362001)(110136005)(2906002)(316002)(26005)(66946007)(66556008)(53546011)(76116006)(186003)(6506007)(64756008)(8936002)(5660300002)(9686003)(66476007)(66446008)(8676002)(6636002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: pssquqRMnkbxzt1S2Qfczur2O8AK0BgTD5xdIwplZ/NQFPNzCSNuosNdZQKrzYUEyL64nQluZybi8Ezesw+sK3Kux63O4VPepq2oTon+ntoeLpZ9ceiFNxAZgE33jBAEzGXPpTCcXvuGgFj4c8Ouap4Fh0TnmilXShNvIt1XJZLbnOKUEmpnCVZzaHp+P4as/EJxmw8ugrFyS52/eUTXA7MShvThIEUYN3uGlLcu4c/EsQzbcFvFcwav4050mVPXXKp0pyULTb/LzeEOeKTXVP/D8rNpyqJV0zEV39IWz1EnDa17Hryol8dEyxTzptAXnkY4FOEa31hm5oWWfC6mSQNoDLjpms/2VdxR0IKGBInxpl8Y5psbRv+566suTcuNLbkUSLDZLjI+1VS+ZBf8PkRsYVrMsMLRSstgGiVbStwnf1enLTMqfc3oWXBu+/dKDbfYdsZ+z/R5q22ib9W+jJZBIadP+VSxJQGJhFGeSlb8RpPIM4Bj/D+l1tm9rUif
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b7de18-a2c9-4757-797e-08d834fa4631
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 02:34:39.5551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zh94vA56T4Gza1hIHiqdSSBzqWTL0a+tHWMpZWXDTRVGmlYJ1t5drfaZPqqK2n5+CmKTovV8u5OjmIenfi9oMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1911
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

[AMD Public Use]

Thanks Hawking.

I will conduct more tests today before pushing the patches.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Thursday, July 30, 2020 10:21 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH 00/12] BAD GPU retirement policy by total bad pages

[AMD Public Use]

The new series looks good to me in general, but still the following nitpicks

Patch #1
Default typical value --> default value

Patch #4
+		DRM_ERROR("Exceeding the bad_page_threshold parameter, "
+				"disabling the GPU.\n");
Let's use dev_err to have device pci bdf number in dmesg

Patch #8
Please remove the redundant {}
+	} else {
+		return -EIO;
+	}

Patch #12
It would be better to use dev_info/dev_err for more readable information in mGPU case.

+			DRM_INFO("Using one valid bigger bad page threshold "
+					"and correcting eeprom header tag.\n");
+			ret = amdgpu_ras_eeprom_correct_header_tag(control,
+							EEPROM_TABLE_HDR_VAL);
+		} else {
+			*exceed_err_limit = true;
+			DRM_ERROR("Exceeding the bad_page_threshold parameter, "
 				"disabling the GPU.\n");

The series is in high risk to introduce regression, please do conduct comprehensive testing before commit.

With above address, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Wednesday, July 29, 2020 10:56
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 00/12] BAD GPU retirement policy by total bad pages

The series is to enable/disable bad page feature and apply different bad page reservation strategy by different bad page threshold configurations.

When the saved bad pages written to eeprom reach the threshold, one ras recovery will be issued immediately and the recovery will fail to tell user that the GPU is BAD and needs to be retired for further check or setting one valid bigger threshold value in next driver's probe to skip corresponding check.

During bootup, similar bad page threshold check is conducted as well when eeprom get initialized, and it will possibly break boot up for user's awareness.

When user sets bad_page_threshold=0 once probing driver, bad page retirement feature is completely disabled, and driver has no chance to process bad page information record and write it to eeprom.

Guchun Chen (12):
  drm/amdgpu: add bad page count threshold in module parameter
  drm/amdgpu: validate bad page threshold in ras
  drm/amdgpu: add bad gpu tag definition
  drm/amdgpu: break driver init process when it's bad GPU
  drm/amdgpu: skip bad page reservation once issuing from eeprom write
  drm/amdgpu: schedule ras recovery when reaching bad page threshold
  drm/amdgpu: break GPU recovery once it's in bad state
  drm/amdgpu: restore ras flags when user resets eeprom
  drm/amdgpu: add one definition for RAS's sysfs/debugfs name
  drm/amdgpu: decouple sysfs creating of bad page node
  drm/amdgpu: disable page reservation when amdgpu_bad_page_threshold =
    0
  drm/amdgpu: update eeprom once specifying one bigger threshold

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  32 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 186 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  19 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 121 +++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   5 +-
 8 files changed, 331 insertions(+), 53 deletions(-)

--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

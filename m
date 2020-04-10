Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1DEC2BB55
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 04:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA49320692
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 04:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ekAy5ayo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA49320692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CAF66EC5D;
	Fri, 10 Apr 2020 04:56:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B616EC5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 04:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE1XOjHbMqHKpRxLn23EuHBj9A6JRlbLcVbhGMvUFfJjowPdDvfdhhhnIReX4vvZ7SPTOJ+M8HDrPFAUeIT6z8G2TN2cIdrE+gNu6r6FKXqHY6yxZtbbpkCf4Vv5+T8s5lwHy7kheVL5cEvHL6FiDVvLpXT+9ff/rD9F7sMhGzuNZzE2vjp3HA0F4nG/QX0IYt9sVH5XLIvTVJg7LZ3eLWHy3s9stirhos0h8lWCYBe//mqMEElZOV1dJLvUSHcq3IXLcBOvGkVHD5QugMYgqoT5Sd1FMTbpo+E7Ww10GfmEnQHNg7c4S4Cm2plhWhdS6l22ciFtUKO2dISmZPIVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2au9EW8SL7DNK1m70x5PbA2ZZhY532HDv2HBOYsrpo=;
 b=jMjB2JjJ4AerU6YMtpCP4kB+gG/0nxe8TuE7O0SqgI2oLCUGLdfyKCfqHzKr9aseBHWkXihUxpCVtTbct8fPwYXAl458IWWQxKf57i8UZCa2zDwQZF1D+HvHFDcBuN1mTmIqVlNfLCfKuoDv9ScUkJcz5CsoWkbeCeXgpdqS2sXUI59z1ART6KBFlbuNPgDEoaCFio8a5mAdBsGV/XcMV8qCaeoa5Eifbo2GMTXOSw5+EgpDfQsl8EXV9i+N1ZN2TCUnJJc1Z5CpVaD/1ibXrkewLE7gDtAqblF2wrgh0E0sly9PQ4UtcPdR7s6pu+PAmmMzLMC0tWhzEeF2WcX7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2au9EW8SL7DNK1m70x5PbA2ZZhY532HDv2HBOYsrpo=;
 b=ekAy5ayotivHK1QuJPpby6+JzwjE/WDTPVvpDU/t1saokZjBWp0MM+KiBrmWV5APG9LGy2fLrvQNNSunqBJlEl1MFxyp/lFcgyVuDp6gOTwSNWM6NaCTMy0ufCA2ME+Du2maYHnjn8HcIgWx6EpA/LAZYQ8RJF/Olg1spAaF7lM=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19; Fri, 10 Apr 2020 04:56:40 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.023; Fri, 10 Apr 2020
 04:56:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC
 ecc irq cb
Thread-Topic: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC
 ecc irq cb
Thread-Index: AQHWDuvsZWiiP/Nhp0OLCdc21USFL6hxykbw
Date: Fri, 10 Apr 2020 04:56:40 +0000
Message-ID: <DM6PR12MB4075902286A10D35E42015D1FCDE0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200410035528.27347-1-guchun.chen@amd.com>
In-Reply-To: <20200410035528.27347-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-10T04:56:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b4fc3f36-8f40-41f4-8201-000035f92d49;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-10T04:56:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5bc282d0-969f-4257-a663-0000a1b615d3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87c08e9a-e416-4e4e-e87a-08d7dd0b8e8f
x-ms-traffictypediagnostic: DM6PR12MB4169:|DM6PR12MB4169:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41690D58E3C7C8FDC08EB81CFCDE0@DM6PR12MB4169.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(9686003)(26005)(6636002)(5660300002)(71200400001)(8676002)(55016002)(66556008)(33656002)(186003)(8936002)(81156014)(66446008)(64756008)(52536014)(478600001)(110136005)(66946007)(7696005)(316002)(53546011)(6506007)(86362001)(76116006)(66476007)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O2eWU0SNX6+5e0IkZokZCyDxo0D8i9aXFoIO5YOfXJUYb+XX7+ZF8NZqcTB/3vmRoclwKftQSt7eKQWHFmApn2ZYGUrKdKBGrt98C2J5RZAtlYmYaxKDj5IO0kWGwjWCsiDhKmtasSBcRRsO/XgYSjxPzcNyhLr4DpTMUZ6YvO7+iKrYYslCW/5O8H4hZLOwdDrc1bf//Mbfojs/GBpTxCBf2SHcipCJ2+4no6/8MAiYi/3S/d+HhwANGPIlol0bZiaeBlzfcz4kboEZ1EVmN/XrmUKE7KaxDfeUseov7BlTMAI3h0MibXCCSsaKHnLnj99mkd0erILXP3BWzG0pnsGpyz6aNwGmuuzQcgWEpjibxTdp45PHQnYKLWTiW/BxRVjAEmyscfAhw7YqLhzkytCGeXzCmX7XEKmcfFDMgQZXAVuDwipt49ZLNXrw2irY
x-ms-exchange-antispam-messagedata: aDz+r0QFeR4WF58gz/drPPQry2ZFjdanqMv1N+3Zc7ILS081ix0Ojlf28Zorf6d6FepedsxfPMrHGl1odLN+CUECZEgTLYujkmogpzqgtV3mClSY+RjVHOjjQ/4O6wdKopgb7W7zjjRRcu/jzFr+NA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c08e9a-e416-4e4e-e87a-08d7dd0b8e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 04:56:40.1044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmrcpaNq1TR+Y+XjWlkn9uBtTX17EUqzXIhPWgq/HTJpBFO0iXaejsn2q9wCiFAnCrOQs26G225sUA1+l6eNBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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

Hello Guchun,

Besides this, could you please also make a patch to replace DRM_INFO with dev_info in amdgpu_ras_check_supported. Basically, we'd prefer to have device bdf as the prefix in RAS related wording in kernel message, instead of DRM pre-fix.

Please also have a review again on the other RAS wording in case there is still use DRM_INFO for the print out message. We shall let user know exactly gpu device for any RAS error information.

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Friday, April 10, 2020 11:55
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC ecc irq cb

Uncorrectable error count printing is missed when issuing UMC UE injection. When going to the error count log function in GPU recover work thread, there is no chance to get correct error count value by last error injection and print, because the error status register is automatically cleared after reading in UMC ecc irq callback. So add such message printing in UMC ecc irq cb to be consistent with other RAS error interrupt cases.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f4d40855147b..267f7c30f4dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -121,6 +121,9 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 
 	/* only uncorrectable error needs gpu reset */
 	if (err_data->ue_count) {
+		dev_info(adev->dev, "%ld uncorrectable errors detected in UMC block\n",
+			err_data->ue_count);
+
 		if (err_data->err_addr_cnt &&
 		    amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt))
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E5EC2D0EC
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 05:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5F220787
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 05:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ilDE+U3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5F220787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D693A6EC5F;
	Fri, 10 Apr 2020 05:04:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D4C6EC5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 05:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdIAl8zaiH/ew8nvMi3JCR+UpjYEJuGKN78XCWiStBf94qXRYRgZ6Uyf4iQeCHuzy5Ht16i/rgAwVtEK4LbSlgaMTVPpMJ3R3xOhl9/RaseBKH03/pzmMj0pYhLhn9oTwmitJqxv1iHfmsWw6KjS3sxlgFJSJ5hBGNMs0o5+X6Oq6+o2KzxXIt0cW7yGR/YBpm9ZQYJQAK1bgEWqahu44i0c6NiTMuMYoowqsAyWjx24rlSH2FhhgnYtiYQiWhAzhciF8BQWgD3FnaR0Y+KtK6oFVedfmwuwOCKgVrhpRcxlXS8sAoEJ8BhInKvg7IW/bvVaiQhKAFVrZEej0J3AqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTmUwLz1vfJlUmQE2ifiadqb2CrN83XYXLcEEjz+2MU=;
 b=faJPDboLNlttrJbtg+y0o6D88aznBS78Q0Jf2FnP0EFxvYduz5Cb4cAhZ4OtsosGvg0coOdr0kNeiDPzgmi+4l2dsauMMkomBXOPho+Iogs5T2CKDbxiFG/o8KsVR2av03NDe9XbxVdxNmSt28VobIpaYHlNr0HwNM+YFORN6bC/JP/2CGnlviCRUMVIwxhydMz7riyNnwyiS0bMxRlBgEYVCGrxgl7i/8zRyWb6YncYtlLqwhZ1qVEn5MIM6imXfvupPUguEcQDMOorMcmczZgH+DX8aIikdpCjnJjYTtWkNhbabSTQ40s7eX4Ne+D20WcrZkisdJfA/72WUL/EYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTmUwLz1vfJlUmQE2ifiadqb2CrN83XYXLcEEjz+2MU=;
 b=ilDE+U3c0gCL+ZrtpgryBocE7BdhjFiHeLutDDXLynlRDkjjLV6qLV+ag3+W2//J9OGs6TKHgol/ydIx72xCKojZau4iKfIE38FMVXk3IpW//r97BvNpFA7UnIV51kbTRT101O3NmUv6Gg12JS7Xy7glteffZK0J6OM15dQNzZs=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2650.namprd12.prod.outlook.com (2603:10b6:5:4a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Fri, 10 Apr 2020 05:04:40 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.023; Fri, 10 Apr 2020
 05:04:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC
 ecc irq cb
Thread-Topic: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC
 ecc irq cb
Thread-Index: AQHWDuvsZWiiP/Nhp0OLCdc21USFL6hxykbwgAAAxxA=
Date: Fri, 10 Apr 2020 05:04:40 +0000
Message-ID: <DM6PR12MB4075841B0C5015B48AF45EA8FCDE0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200410035528.27347-1-guchun.chen@amd.com>
 <DM6PR12MB4075902286A10D35E42015D1FCDE0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075902286A10D35E42015D1FCDE0@DM6PR12MB4075.namprd12.prod.outlook.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-10T05:04:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: bf342a45-9e64-45a0-b0da-0000c6beff0f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 472889a2-2658-4334-999f-08d7dd0cacff
x-ms-traffictypediagnostic: DM6PR12MB2650:|DM6PR12MB2650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2650686CC3D986EF788886E4FCDE0@DM6PR12MB2650.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(66946007)(53546011)(5660300002)(2940100002)(66476007)(52536014)(33656002)(7696005)(26005)(55016002)(66556008)(110136005)(6636002)(9686003)(66446008)(64756008)(76116006)(6506007)(478600001)(2906002)(316002)(71200400001)(86362001)(8676002)(8936002)(81156014)(186003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYs2amFB0PtYdh7rODl69w2y/PHV+MmBf0iDzUQamtv2Fb//XaPVOlZ7MakdD6pOMrulEBvoQkDuXbsbQWVND5aGk4+HaKOVxaNE1GStCaZ+Ws4HuI5o1otNQblqrFHuD/JKqOwlqP4gz/y+kS+3r2CHwEG0/Ie0OrnazYkow0r4gIQnfzvFu9uIZ+aYKH0FbWtHsRD5aH/ievcFknSeSXhLizdD2R+ltD0AwBSlSw7c85o7mSElPONzdn2YHtX3A07hyKVM4E+JZyMFZdW3FprSh3D2G505Qq9BYoKcHVol1nYV9ZeXxJNS8xDRS5Xe4Y4ljACwWlhxSMUX1OrwwcgH1UbssNn84atmcCLycf77AigU1zNB5QxbMJZfOL91a+16TcRfqOqXD3KNMCCvMKv+nwZADokzfukZsT/5JvvCoM10HK4z621jvvojUYCg
x-ms-exchange-antispam-messagedata: OQV03cKGVgl1A+Pr44a0ppLiYTN3nthLENWrb29WcR+Zv4eW8JvpnQ6+7/RgjFHVnVVBbBY7FQgIS2us5+kThrAC4VBfSSM/02lUDbQFbyuXzbbApZrpL1uj5BlrR2aWjUqIZSag3AF+OdoVhOndIA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472889a2-2658-4334-999f-08d7dd0cacff
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 05:04:40.6957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPwCQd+XOLZhRzlfWJYzaGdLd8Q1Vpt4bXarlrpqp7YMgoTthL4vLAx7BuHwW9JerAaDX5XUAgZO9i2ARlcEJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2650
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

And some more rules in RAS wording in kernel message.

1). Use "correctable/uncorrectable *hardware* error", instead of just "correctable/uncorrectable error" in all callback functions that prints RAS error counters
2). Add wording "no user action necessary" for all the "correctable error" related kernel messages
3). For the sync flood interrupt, let's not just indicate ATHUB_ERROR_EVENT type, but also "uncorrectable hardware error (ERREVENT_ATHUB_INT) detected". And so does the BIF interrupt for the ue.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking 
Sent: Friday, April 10, 2020 12:57
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC ecc irq cb

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

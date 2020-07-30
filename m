Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756F1C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 14:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E04820829
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 14:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="diOuuCkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E04820829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55BE6E90B;
	Thu, 30 Jul 2020 14:20:50 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680051.outbound.protection.outlook.com [40.107.68.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B4D6E90B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 14:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnowIWV0OnWqNG/VGVveL4s8lKKtn0d8qFcMHukpQIixk7e8nFEZO3u3etmnPNOZWPVAPtxgdwbGtTMfqphiUhMIWtzPsoWhiWtM4Rn6PTfreuUubq7ZcZTOL627PpmPqcz9FOhk85Pzln9j9NWZVkZ7klTl99hKAHVANiSA5eOmv54rnnApC+65LfmtVdIWhzgI0oXK24Gf2GkdC49UZ9y+fMsnXVhk0zdPvrBO9lMO5ROI97UkDJbJcJhYyrEhtCKQ1+UckkYatefZWox1kpVnaxvaW23hU3XoILJ00kfZ3t6BBMyI1PR7p5R5S3CwgJMXMLLSN2P5vsqPiTUlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4FOj7cfQrMXNHyx4Z2+RckRuDqpMh3gB0QPx+5pRJo=;
 b=i/+a21rf/XQavPmYWqBFbQDv1pIMGbOyYztyzW1hbML3TRbLv1/ljd4ZwJUwWnuxvDl4VwEgL2zzQn0zAsc3QJ2mCYQHPt/ICg3bssnme3h8h8avcu+DDtnPX948JnV/ZS7VM231QVOk+gqKRhzAdbnv+1UE/gpF7IoVvSyc4xdqw7k3PXEfOyueSxJsZb7MjI6EEfnQnXTXiYGa4MLITHgaIr/ln5kj+8W1qhf9M2SddMqIwY56NFC3MtJe18C3qaQ64+2pD6tTw9c0C56d8hFqJJWKzAp5ttVHZZJhv79Rr62/WgSxmGOfIuO2syC/fp/tFZSpJIGJFlSlw9pv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4FOj7cfQrMXNHyx4Z2+RckRuDqpMh3gB0QPx+5pRJo=;
 b=diOuuCkqnCroICPd2dX6fDZf+FOblItyPAbysEaOeM5TW1OCoQbvkApn96hSbdTsvV97bydnsp5Dk79jvasb1i+nTLMEE3urjRGTecJXhKXWO0U3DMwJKNw9WnsIHTE8bj5bKl85dCi+f3AwHLpl8NrK64QDapkcNzmT8G/4nL4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Thu, 30 Jul 2020 14:20:46 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3239.020; Thu, 30 Jul 2020
 14:20:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 00/12] BAD GPU retirement policy by total bad pages
Thread-Topic: [PATCH 00/12] BAD GPU retirement policy by total bad pages
Thread-Index: AQHWZVPqDH9bEMMY1kCl3614obkFH6kgK9CA
Date: Thu, 30 Jul 2020 14:20:45 +0000
Message-ID: <DM6PR12MB4075FF459BC25066C718845CFC710@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-30T14:20:30Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ce223924-3b75-41c5-9f42-0000d22c861b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-30T14:20:41Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 3d955ac2-c242-48a4-ad67-0000d0113a43
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4025dddc-3197-4538-e69e-08d83493c00a
x-ms-traffictypediagnostic: DM6PR12MB2795:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27956BF52BF007FEF8FF56FDFC710@DM6PR12MB2795.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J/uYB6+lmqDIq2e/UN5VtN1xRaOzDgBXW1mCJNGnQbg2J4xX2n8zqJzOHUCj1C4Pp59LnMrBIbDCElLctBmd/n0Dmqq8QQdyGUBhyS5jBhErv0JdCqPsi39Z0VyDt0WIt7Tcb3fGH7rIWoI/wBxisIwNtQUGJjI5VPKdaxGPEwP2ViugOmnlEaJ3W+mtokZ2eDCOxtm3JemY6Zf870WiD8dbFwJHU640DP39jOmWmSTahynaNB+obKOJw5BA2A2CKyMudsCEdSgsDRIfuAdzgwEtVTxD7wf6OyjRi9SKvBaj1bQt0/c5Y4MkYiDjXvK5sPLap2rGDpXxo5nL5cTJqvGlp+g/3p64H5HY/js2cOtVbCaNhwOkltN7Zod/kwy7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(66946007)(86362001)(8676002)(6636002)(2906002)(8936002)(66476007)(66556008)(64756008)(66446008)(76116006)(83380400001)(53546011)(55016002)(9686003)(7696005)(186003)(5660300002)(52536014)(6506007)(33656002)(478600001)(316002)(71200400001)(26005)(110136005)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: N8TGemuylwipqjJhhsEdDF1+V0Kh6YtaNp3jEiQ52AvI1ePHeshNt+fKQy+fJEvGtmxB+rTsPzjTMNS4utqU60h2TpKQ6atDXgGzuRvywDXEsgJIRu49YitaL7idH4MDRjRz0mklLAGwx+CFi/ibGCsF/YfkW/guf0tq1vh1F4ixNGVY+cudnGzetD5SsXgEY+ZbFVSU+1S7KQdczFxHMLmcophT4XK8JkneB5G2V4lMrpz1Il05ECg4GDz4TYKlNj0jMlbKGVjt5DDnDc28DVsQyKkR40ss8GIThpgbfYuBjyn8J2B/NESN/qVsPhV93nD7fjyNLAZtC/RCGDCcI5+bW9OEDhZcP+HhKBXQuAcz2bF7g55Q9tet7AVDgsv79fIFCWYY75/N034cYIFgP4JoGQsYOcZsQ2mMxtQ/C0iQ5GpxZMuiN5t7aKX+N1Rmz6b2JpeWNW+FC7McEO81Q2zmYsu39zTZKQWDK7Hq7jLdT0mdQTmNmR3cphncJU9/b7BzObAQ7kQAXSBntz/GTr0X5WwF1oIUhFT+j/qeFAdkXScYW4Xdjna05Orsvn3cyaT7xMIkG3PbvuM+D0ntVGvBXNGaGnBaGlcgnGUCKK12eevMWpoutjh7zGwf9C9douXbiqsLnF8L6ub7I+nZLg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4025dddc-3197-4538-e69e-08d83493c00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 14:20:45.8248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COjZL/a6Gq8PlRBf1TN5yO7M2M0v4slIeN3V7L4ySr+58GQsg8nP7Zw2RPkFJIfFSMxNp/HFoiMIdWAYQIzlmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
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

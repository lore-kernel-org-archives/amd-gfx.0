Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E3FC2D0EC
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 05:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3A020714
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 05:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zqa1aqMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3A020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D852F6E277;
	Thu, 26 Mar 2020 05:57:49 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690053.outbound.protection.outlook.com [40.107.69.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66F66E277
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 05:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L89jPy2HIWkHHeNoTRfKz3iL4WgQXcJorWohqOOfO2oJ7tclqDs8+ALvrDee0F+EXWpm4980ahacx0q1+KwFBsndgKBo/qSa9/ydSW2aQbpvc6/DXlwn+OeFVXK9k4ZQrNOPrjtXB19rRr8ZIm24NemGamcIZLzGSLuOxmajbuTyMStW5SxLxPvbe9UsefpnqCDsT9CTDOcGaa+xGeUn1WogDMFoYDg+eF7E05xqfFoK3M/7wvFKLeLcS1+0MjUxsMwYyjf6YTmEsHMNRNpLjFWln6CnTljg4wwWgDnVg2nLmtgHEESaWPnD3H7HN9WBfMji7H9ESdDBxYEn5aZ65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7614tLs2rsAyQZyA7Ww7xK6oDCEmGgQRDP7vm9LLps=;
 b=LQTKuvvhMQea53g/zzgs7tWlqKGl+9OMee4Z4P6cy81Li21XrKSyk/Sg+9Zys9VaQXKpuZn1TqDj07unsZcQOPmXlGHpI1DXW/YpnBdt5AMBS7V5VJPZfxpE4e2mJQLEC84jXG/OdInhgQMTixa/py/BGJTkfVL3r4mHpjiXN+Mw3s6fN63U7NTsNpTTIe5M94mnkSs9j78R2VdMIJh1a9eWXxtqNHl/qg1Sf8mNrhvgUCUmCOox9SL/uw5RAaRAP+Fo4k/fzVb1+KQG/KQYAAe5PXFrStmyS//hNrQsUKj91q+G+6y8D72vvcNS1B1/0qiQM7MHYLkbQpfZBn73pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7614tLs2rsAyQZyA7Ww7xK6oDCEmGgQRDP7vm9LLps=;
 b=Zqa1aqMz451QhHsYvz+OJ6sLzmlaPOR1HzL1QRZcWApBEdh8MoRUMNqntNibwU9wVpsEwGyJ7vFB9faya3ibAO00ewSTI/B6E4lf7HSUTwqPALDPzgq2tZlo4/NjrKUnyfbmxdrIV0aaZOJZCqj0t4MKMQCoz+JVKW5bPI5ysS4=
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Thu, 26 Mar
 2020 05:57:46 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::b4cb:4250:334a:deef]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::b4cb:4250:334a:deef%5]) with mapi id 15.20.2856.018; Thu, 26 Mar 2020
 05:57:46 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] SWDEV-227226 [AWS][Linux]ReallyQuick test failed, guest
 dmesg and host dmesg have error
Thread-Topic: [PATCH] SWDEV-227226 [AWS][Linux]ReallyQuick test failed, guest
 dmesg and host dmesg have error
Thread-Index: AQHWAn/kvap0Fh/PvEyQn7iPn/Mb86haYdfw
Date: Thu, 26 Mar 2020 05:57:46 +0000
Message-ID: <CH2PR12MB392607C1823C91B2821D20C0F8CF0@CH2PR12MB3926.namprd12.prod.outlook.com>
References: <20200325083141.16919-1-Jiawei.Gu@amd.com>
In-Reply-To: <20200325083141.16919-1-Jiawei.Gu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-26T05:57:44Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=dab6e126-7a7e-4b00-9a02-0000b18e312b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-26T05:57:44Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e351bb0c-9159-4993-817f-0000a8c8e71b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JiaWei.Gu@amd.com; 
x-originating-ip: [183.193.138.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f2e21ca-9a14-4ff6-fce8-08d7d14a9b95
x-ms-traffictypediagnostic: CH2PR12MB4039:
x-microsoft-antispam-prvs: <CH2PR12MB4039BA6BD4ECB9A20A6739D7F8CF0@CH2PR12MB4039.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(2906002)(53546011)(55016002)(186003)(81156014)(86362001)(7696005)(6506007)(9686003)(81166006)(8676002)(8936002)(33656002)(26005)(6916009)(64756008)(71200400001)(76116006)(66556008)(66946007)(66446008)(5660300002)(52536014)(316002)(478600001)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4039;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ClRojIqUbOLMWcafTJkidKzjYB04g+kMBRFk2Sa+3km8bDlOewDpHHv4qbtlrRQKho8ROAK55AbQaS3i3wLZbsJEkBtZ/YN+iKljiV7wxNK0LfnDLx05uPgvb/58w2frPI+ozkDrde0X/Sv70/JKNKjFAmxEFRRUoKuJ9FQqIUcznWCeY+D5rXpvMZyOwdDQAIucp4TEEoWLhe/MXoogl4OCM3l2gmufe+UbFtQPPTGJXdOZKaO8t/6DFwUpLba6daUbJGrwscI1qMvSn+cRtfbmd7SdfHwa8a5EyBCufBDH95IUp87sQOQycjmTvuN/V9Sg1KgoObJU2xzDwPeftkCzw8TKWGd+R2NIXOve6fxd4AkDDZr+HNjKdFjhm8gHkQ0sSKyQZN0ZxZt4hXGi3xCkg07zeY3QFbEJNgQM0NtWTvwiN2k//7TLEMaBIXCP
x-ms-exchange-antispam-messagedata: oUw+Cq0jigXebkgb1Tv+/lngLS3IqRPXcxXbQxm7MAI+w3/mxff2HzOPWBkkel85xKRktPhX7EpLa39gyBusNvhsRW80pE1TX8epb6Ih+xfc1jdSAfnQgA3CSUjQCWMXfUPwtRo/eYFzgX7321RleA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2e21ca-9a14-4ff6-fce8-08d7d14a9b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 05:57:46.3837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ge3yrRJLT+yc4U2VK+oQEgcf5QG4ipCpyU8iLu+jPS8AvYVtkh6bpUIIo1cuwmNBO5S5TTYby9nZ/GQssunBAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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

Ping......

-----Original Message-----
From: Jiawei <Jiawei.Gu@amd.com> 
Sent: Wednesday, March 25, 2020 4:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: [PATCH] SWDEV-227226 [AWS][Linux]ReallyQuick test failed, guest dmesg and host dmesg have error

root cause: compute job timeout for sriov/passthrough is 10000 ms, which is too short for some compute benchmark

solution: extend the default compute lockup timeout to 60000 ms

Signed-off-by: Jiawei <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3607a63f48bb..88360b220a8f 100755
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2680,12 +2680,12 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	 * By default timeout for non compute jobs is 10000.
 	 * And there is no timeout enforced on compute jobs.
 	 * In SR-IOV or passthrough mode, timeout for compute
-	 * jobs are 10000 by default.
+	 * jobs are 60000 by default.
 	 */
 	adev->gfx_timeout = msecs_to_jiffies(10000);
 	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
 	if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
-		adev->compute_timeout = adev->gfx_timeout;
+		adev->compute_timeout =  msecs_to_jiffies(60000);
 	else
 		adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
 
--
2.20.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

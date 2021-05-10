Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C4C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 09:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9FB6142D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 09:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9FB6142D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767F16E0A5;
	Mon, 10 May 2021 09:23:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B48D6E0A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 09:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im6IhZ3N3yljl1J1ceVqPQf5bOP/E9GgM7mMa0ms+K118KCHFXlP900sly1mnqY/NoMB1Dc/RfS7Cv5KO9LPQbQpPJNXIOqwqarH6d1RS/FhH2vQ3Uzhb68pzFkgOOjYIFtAKcylqxp5gq4IchdqpYlgTCk9DOPgLkQSndc/HZeIB2FRZb6fBek6xS+GNOI/VL9HpkcS6nL1o9KXnBmAlFdwrn9PHMlXaJddrDLQtdbUp4J1GIskazSAJdv9R05CnMVEOLN3yBZTCRASxtAN5va8bCBYIPY2Ry/KoPjBn6DUS1zlwp+Cn4+P+qWDXEgP6Qd4MJpPdZBw3+qlhkpoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhQj4QrqNmXIzXNHy5FSxT7H5s2bhyRTF8uZySB+eJA=;
 b=jDCRSzl3XsRglLDMMyewZo//+G4TmQKSjW5b2UWbqbTsMRfvexvgZf5kLNVXMtg7aRlwhFLCgdROwBjSxQNYFp2FjwwvPWaj8zPPvzaGr83aJ1ubFP5ZkjpUSUgWoEln5N2F9M4SOybWLAse5+sQjwNk4N9B3PmwoywaBSOTTY8DKMGqHDscN5iP7BY1Vg5Rt5zffMbOHW+5lz+yzo7UAwC/H4acOvjl2/goufkvDxXeK8z4L9oWljis69FaUs/XHbjmCuHn39wutgBXQsXFeRAB/cArFeBNaXytrs7XYgfX5QEfKUd1eEPINzo9XbQNMZdaaJeZq7v0Pd65odrX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhQj4QrqNmXIzXNHy5FSxT7H5s2bhyRTF8uZySB+eJA=;
 b=DS9SruhLfSxL1PFXQi0u8W0GWv/DVuEabSMKNwX6F34jSR1zSMTPU20qjdD1QNQMKcgWOqr1dvWcuW6q2RPeyGIHejFGO5EZeqeir2S8sFtscX0Ra6TUavVXAL/qL2ZOYdxcG3csxuPNBEEhovAnrb+gjNzLo0627Wcn9eHRhDY=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 09:23:55 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 09:23:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct the funtion to clear GCEA error status
Thread-Topic: [PATCH] drm/amdgpu: correct the funtion to clear GCEA error
 status
Thread-Index: AQHXRXTs3nX9CfJuh0mB/1nL/xb7PqrccVYw
Date: Mon, 10 May 2021 09:23:55 +0000
Message-ID: <BN9PR12MB5368D87DABA6D60B60FB425CFC549@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210510081719.2638-1-Dennis.Li@amd.com>
In-Reply-To: <20210510081719.2638-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-10T09:23:53Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a3cd65da-2a20-4f98-a7b4-d46e46d1a005;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2222eed2-5226-423b-ad56-08d913955578
x-ms-traffictypediagnostic: BN9PR12MB5367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB536710E5BC2FBFC5FA473D49FC549@BN9PR12MB5367.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zzcX+/nzwqVekGLRDhYz5V/GK4+9HoN8N7EehvbC/KCdUjhjvP88nfg5vUwr8LLwczckTFiD2RhWDmjjf5Hi4PAChZFuDbFHPJQjXTiVVOECUHmCHPVNTbuVtj+KuMS04kum5yTROK7Um3t0Vlps6HOnZQ+IbixGnjiYbK6X+DtJAvhhCyq3wtdHO2IUJXFW7EzWt8v6JK2dV9gCNfx/1KrmYp9QMlSq2ABYr4CPvj5D7WvntDOIo4XdkSwL1TpmFUsipE2W6loE0lUpNvpV0VOvUx0Odw+bVg0qsRdJTUFXcr7G5U4wxyFo+FjrdCZyvEELq+b56hN6624tl5NtfYVXAP0W1M5pkdUBt8rufpUjFTe6t4fR/97CajLfMQ/MRCc3GYnN1ebqpKQ85ve9uoGdq0+pGttE5TYqcwm5EtRYqvo/XmVoD07grQpKQol79fGxcYteBBqJS7iH6r6pVn+jy8ELrMhCx1juQwvZIfGme/dYT48jUZ40OAOxJxU15PApIyy8Sl9QXlek9547qpDXvf03JdMRXWx/yXiCr1rfa9jQVgQI07xUUj+XPUxLW3e9Yo+OtCZUQlSnvhbFx1VzlLA5HbOw8emHUfaoypA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(478600001)(186003)(26005)(33656002)(83380400001)(55016002)(9686003)(38100700002)(122000001)(53546011)(4326008)(6506007)(110136005)(66946007)(8936002)(7696005)(316002)(71200400001)(5660300002)(6636002)(66476007)(66556008)(2906002)(64756008)(66446008)(8676002)(76116006)(86362001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xo4lsoPVElyowjVJkl/N6Hc1n24YCDrkVfV91pEJwzBFix9IBJmG1kYxBdT4?=
 =?us-ascii?Q?I1G7iv4WdesO1RMewXphR+Pncny4W2YsWRgZ27f1NFHi0fYQ/dr7aEp2NlgE?=
 =?us-ascii?Q?zk74at5CiK2qEWTXuXLcR92P8SYQOzuW+Puh0ROsI8VbUzUgHa/2kD1Yc1xc?=
 =?us-ascii?Q?3gRG2rhVhYaL1x5PRqhhCVYgBFNhpYzi5ZdIuF41+7u0fWmFMY5vN4Kc5oQF?=
 =?us-ascii?Q?8v76uq9jM+0pqNFTxfnqPAJqNfxHFz9SAxegWtVYiNCuy8x95YEKQCdFRMGj?=
 =?us-ascii?Q?QhqP0vPieOGh+sRUSyq8DDdIwCs3J+ggIwrVT8CwB/NBfoI3HbJ3/AM2mU/J?=
 =?us-ascii?Q?t7ACG7YTvFTrCgilPOYiqM5npdXyg/jLhvb0ATUrHcmE2kEhKB889RbIEFJR?=
 =?us-ascii?Q?x46Z/dRIKUZD6N3i+1/N7EyjuwEhbl+PgsHzMAnxnQeuA+lP1qBrcElYpr34?=
 =?us-ascii?Q?TkRSyYCM9SzYTSunSJqFGp3Bi3ia2BPvKMHRBtGp142Il1mSchjQWsu3ZwSM?=
 =?us-ascii?Q?lTpDwHzZ747TCDT5JS55lZquF9JAkY4kQW30LZl8tn1OC/39D5uEmWU1jvIT?=
 =?us-ascii?Q?A1UtqvEPE/G19Erki6e9QVysITVkJncvrXyuNNsY/kNXQTfM4znNbXXvKw9v?=
 =?us-ascii?Q?nkZSzh/8D7sN8GTC/9cs2S9SxjRRiJWDPt3x8P0CLJh6UJuRs+FMQASxLiQh?=
 =?us-ascii?Q?JnNfFGHdywTOtGnKEn+pzx3h5RR//0OJbxqTpuKRoWWugTUGRLvyfsLCJbKO?=
 =?us-ascii?Q?jOOmL9QPaVNT9oW8bIcSxwGxCp3BlfAOmXVb0NgPViPRnvk33H0jhXC985Xf?=
 =?us-ascii?Q?UV0eVh1K52I3DqIvL3rgWCdO7a9w+PLU3r1zbIVM8Rx5OMavd3yxCVN2jiS3?=
 =?us-ascii?Q?A4gS9KSqxw77yMW9JOb4mYmQZmSc/tFYv2rd3p67U/8OSQTFvlfdhx691yQr?=
 =?us-ascii?Q?qV6GhhT1hMX2fbMPsXhHZ2N7XXExvk6wibcUIEEB+EwYY7GGAFRsEAZVQfUd?=
 =?us-ascii?Q?Wj8hjCBZa+sle/x0ng07K8o/iddWDzPgCCXNdodq3nJZ27qwr7jQTMULqSfw?=
 =?us-ascii?Q?KUaMGHzkd+NH/O/icRyeGQtt15eqArL4WUy0O74euEb3wF9hQu1b7MNbw98I?=
 =?us-ascii?Q?zRdv0nHHMHAdLpcCjgfQLOai7wdC5ASLl+FnSeCrJDORo6pE42omMKisSE5V?=
 =?us-ascii?Q?ctOFy01phSkA5CRT6t+Drqjv63DC8gs76qmwv8EvE+c6ycVkJfuBRa16DNJb?=
 =?us-ascii?Q?+60+5Lxj5FLZ71s3mJuaew3MDSsDhn2tgnXtzeTdq1XYbv0StmHUi5mgoM75?=
 =?us-ascii?Q?jmDAd1TrLX2er2a7KFOMj6xB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2222eed2-5226-423b-ad56-08d913955578
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 09:23:55.2362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGnI53BuQ8Fgt8sr/Vm/FipdVFLI+mHv6h6D4+0Dk2DbX5VG1h5baFxOmx77DqLAjgOVwd258G2oIn45NHxzvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Monday, May 10, 2021 16:17
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: correct the funtion to clear GCEA error status

The bit 11 of GCEA_ERR_STATUS register is used to clear GCEA error status.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index e943cd2923ac..c63599686708 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1674,13 +1674,16 @@ static void gfx_v9_4_2_reset_utc_err_status(struct amdgpu_device *adev)  static void gfx_v9_4_2_reset_ea_err_status(struct amdgpu_device *adev)  {
 	uint32_t i, j;
+	uint32_t value;
+
+	value = REG_SET_FIELD(0, GCEA_ERR_STATUS, CLEAR_ERROR_STATUS, 0x1);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < gfx_v9_4_2_ea_err_status_regs.se_num; i++) {
 		for (j = 0; j < gfx_v9_4_2_ea_err_status_regs.instance;
 		     j++) {
 			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
-			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), 0x10);
+			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), 
+value);
 		}
 	}
 	gfx_v9_4_2_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

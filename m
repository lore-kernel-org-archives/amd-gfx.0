Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3C2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Dec 2021 04:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9836310E3E7;
	Fri, 24 Dec 2021 04:41:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31AB10E3E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Dec 2021 04:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvnMqqGvPq9wV8zNT9ikpO+9mIYKCCAhVuvcQVJ2kgeNTvNQPOVQY1NOQpfriqog3EPaGmK3148v7WTSptg5YhIuT9Xj0RbJKMkBRTXueCAGIat43Lg5BXfqAAdDF6x/HVsKWojh7JWcB2w4eMQ0BqXtF6IURN4tdCPtp/Leh1LvgGjLDOKhNAgFYiTiyLBIJ9r18i7lfWdbj+L9j09JT7/8yRSNr4G7PrnebFfSI5EqEmEln0euzWYGtBCuidD7zVWyfwIkF9smdcc5TIczizHn5AwENPBbEg3UDhH0LPtcShMnwbiyQNk6iNjFkaQLVVC/G2J2G3DpUT2ZItnH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAc1cyIDjZWs0wkqLv0R8alZ0P5FJg1zY5mXVZYuKB0=;
 b=R/xyFx5LD6+XSrym/NQ3s84TjUF2vlt7vUrInjSIyS1H+ypc1WsrHnLJrFXiRUFlVG0waWWKCctZUIwN4IVzJglzITASTV6qHzIwHhhJNOdCayFa2k6DNe+VxZ2+R1kO7Z7eX3rByT/MlAUGpFm82mqQG8L7DhkWVPrd0Aoz345trAUsQqKTj5293lHjI1E9W+hNWRZxoxpeM6yxrheQaUkgMoNZ39nVJQ6RsF1/Eu1QN+bTWQTxBmOXkF3kkNxQ4LoeF1S/uxUWIuIcOKnKnq8bFNXB/3ohz7itOwoAq0z/mRr2HX+kEF45rPbEa8F5gVhygsXJ4wtFTGAaGKM6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAc1cyIDjZWs0wkqLv0R8alZ0P5FJg1zY5mXVZYuKB0=;
 b=kEcRdqUFZUS/jVTCMFf+onv/WhIIvg5291GbDzTNGMqB5khv6RRxrpEJ2LVX2eCguunIZ+A81mBYBO4ev064EYiTrHx8lpP+zhDyTauVbKihCCTmcuSJCI6Ys+4yNyb6Ye8/VS4jzwAIN6W2BKLKtTZVQA1P1FQ3hJdpsNUqobc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2826.namprd12.prod.outlook.com (2603:10b6:5:76::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.20; Fri, 24 Dec 2021 04:41:53 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4823.019; Fri, 24 Dec 2021
 04:41:53 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: put SMU into proper state on runpm suspending
 for BOCO capable platform
Thread-Topic: [PATCH] drm/amdgpu: put SMU into proper state on runpm
 suspending for BOCO capable platform
Thread-Index: AQHX+HS+nLduwuKFakeGdwr+F0Qtk6xA+Zgw
Date: Fri, 24 Dec 2021 04:41:53 +0000
Message-ID: <DM5PR12MB246972666C925C37BCB871DFF17F9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211224031644.2555373-1-evan.quan@amd.com>
In-Reply-To: <20211224031644.2555373-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-24T03:20:54Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d69a6c63-eeef-404c-8735-c05a4988c8aa;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-24T04:41:39Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 56ea83da-05ba-4739-93c9-089149b89d1e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7297383-9d21-4c4e-602d-08d9c697b589
x-ms-traffictypediagnostic: DM6PR12MB2826:EE_
x-microsoft-antispam-prvs: <DM6PR12MB282625241A6B164305EC2AF5F17F9@DM6PR12MB2826.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sZCG4otEt55JWRvgILsXxktR5c8NIwUSz+1tj+XBV+snHQlnuepifatpvxe11Q6iyM63urD1gMiB4AyaOWYaJ22oefqPnJTSC///xMKnVzUaqRZZ0BE1yVaOgZKoM/BSepiN89ZFxmzaDBHoSLx/6oQq7dBPOx6FJXW+50JbEzvvHxbR+zfzHv0rODqs8mSh91J+o0jJnMHrn7mMZtb/5iLYS1HbatOJxabQTYgE3Uu1jXOp4U6mN9nYmfJ0+qDDsdk00GCGTnCsyLfVHrL/hxZDf7JG0zHhmE41mnE5gViJ+mt2LH4tBYQRRlF1yg3+sy58Awhy+R5lYyC58V5+gMGiXn+qodfOW9eP4+Ai2p7HI9Qu2apiUqK9dsV7z/OoJFQYAHDTNJSh7Wpj0p6xecPmygG5D4P/9RKlx9B0uFxK+WfCODrWCKWr2LsYk73EpPhq/+fdJvM0MzR+aSyGAGm1gxNLNKSjpKbFeb79Nk63Jv+yxtU2m1Y+RiDnu/PMusz+tEfFoPZqsABp0hwp96TenEv4dK6eWyPwNFCVmSdXNwr2iah8kZThNIYBT3qFhsy6SV2K8YMzeQn93EjedGlSVrI6Q7tV203JBOHgkIN+Ctt1jstlFlu72TKCaRsImwAA8+uU17oOvhFJvgdRtGt0WE+Rns1F3seCmCqsBUc1/DkPLfXcvHUUZX2BQf9hRZo7tezo+R1VmPBwZSt28Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(64756008)(110136005)(15650500001)(33656002)(66446008)(122000001)(38070700005)(53546011)(9686003)(66476007)(66946007)(71200400001)(86362001)(316002)(83380400001)(55016003)(54906003)(186003)(52536014)(38100700002)(26005)(66556008)(4326008)(2906002)(76116006)(7696005)(8676002)(5660300002)(508600001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?83s7Y3QE63y6e2c1hSVoaRUUd16fJ6JhfN+uDNcg/rddk69iPdOKDaTgQYjN?=
 =?us-ascii?Q?bS02YZZgVBwYRpDvIctGk/1nVZQQZJSU9X6NTrSCdVIoJWwBXLBy5RYTajyj?=
 =?us-ascii?Q?NiGSpfNH5JwU+m7TQyhKtGZlnjHSiyoz0a1NRwlsRySlLi0X+guWFAXeVqcS?=
 =?us-ascii?Q?M2rkpHz6xBmu1SfQsZnwcYGEWav2gzAlz9Ov8Da5GSjmIXxkYnkGSrGMpmcd?=
 =?us-ascii?Q?mE1l7qzdLtnn1/GaTRMRegjS2EjRsOBCnMaKYuI1rN6s8Szqt7nHIG/m7CxJ?=
 =?us-ascii?Q?izA3YcM5Fb7WodgGp7rA8FMrl50unTaXcDqBWbWXMpp/3jRdeWnN0HS0PxIz?=
 =?us-ascii?Q?VlEScxnDZOOH6l1uafJmGHDZATPsN8kJ6dK34qfidLcOIuNuWVe0zz3VtTpp?=
 =?us-ascii?Q?H6Wzve5XnodXZWz7inWnqt/SXxlaXb1hLDijBj4nojQctiEpzbyGmmUcyvpd?=
 =?us-ascii?Q?6TgD/h7WZRy11VD7Fg8QvrM/LwqF3Tuici/1N7tsBGkByVozAtWyjjw8A+XJ?=
 =?us-ascii?Q?VzPBsiBSyZ0M0yFtwnctH2iO2qujzmUvAmDcZEBvzk4D9KopLoNDCd9J6wm7?=
 =?us-ascii?Q?UdBPQtMZPiMtwBiweiIg9Y4gr0iWXX4OeBG1kGQ+GbdcqBr1Z8YUmGsUwxN6?=
 =?us-ascii?Q?OFA26fvK2sOIDv3gldBx0JFjrW2XR1agqJjj4URZxNAJMuMvkXg8JXVjrDoq?=
 =?us-ascii?Q?JtiAWCdL1QBGCoHs8lPQVkI+0dCxB37MVAYHBc11h90L36exRTQ0KOGo0FJ5?=
 =?us-ascii?Q?TyhDU0dY1chlzET1RIP82zKwc6/t1k5Vyq8Zkf6cZwCarGW1jIozhs5zYose?=
 =?us-ascii?Q?g5tdwHrP9uXs1bFVRMcWuX/JUbFuReAUojWN+rsZ8h9E7jwOMSz9bdK/06y6?=
 =?us-ascii?Q?Bfmc7SxJPaSbVztP8YyUI2tAHkvkGVUCNMGQO9PbfkqukiR4SX1obh3Cy5pa?=
 =?us-ascii?Q?hmenq//eRJl9neIDf818IKE/BWyCV8xHWO30/oINfhl++0Sv4/WIzTWIIyK1?=
 =?us-ascii?Q?tt0wi50wxAyHZVlmyb0OL5KC3ufZ2WT3r5iTFsYIek85nn4cPc5C5xm29BZH?=
 =?us-ascii?Q?MCVISidOtmwozcTZXD/GdnPwpJma8CakMMttVYwFvqGHlw/DRRlz0Qb6cHGb?=
 =?us-ascii?Q?ACCdf4rYyNYaRNJvcNkgJxXFtW+Ot46K6x8lFLsKTSuOaOxT9W8QtSOrTvle?=
 =?us-ascii?Q?YOS3RTe3f/tTBDZoTM5jU2Z1Ha4RbERMkTuiVTCkcTYhPaiUzpouWRlFjXP1?=
 =?us-ascii?Q?YkA1ixtO80ma0rni7AbwcPTlcVkttr0YlyB5yExICPzct6GNRRiRGr1J1c60?=
 =?us-ascii?Q?vNht95cy0Dyaz3TjlNxZoRI2RB5wKH7wXWM6GqWK2yyfhg+BaxlPKXPlz5qA?=
 =?us-ascii?Q?mEcj+e5z0297I3xbgWPvr+ATU/0NX00BvVxvC/Bt8HHdCeHmFijKTsF85K1d?=
 =?us-ascii?Q?iuBNjeQ5D0FItJ5X8V6JJii0OkwUz2874ml+XDRG4erNMD5OtiQyqIBq+DND?=
 =?us-ascii?Q?xCjPs8Nr5J0fhjx4FKPqOtYkiVS/H9wzufF9v+IXHJXz5BhdIyD/vOzqsKkc?=
 =?us-ascii?Q?I9bhocF3krTOH4ju/R3ZkwCX+OgRPHGX90X8YqtXo+beCXtwf09jj/hEnigh?=
 =?us-ascii?Q?4+5elYWeLGdxEQOfXZOylhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7297383-9d21-4c4e-602d-08d9c697b589
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 04:41:53.6582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clHyBO2Td533yFsLFMJ53SYDdAbC16GYUqPgjZUTtbhJvDVAb9ADHXQerADAHKLjNuCjWeNNgIEo/9yUxXz72w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Thank you Evan. Shall we limit it to dGPU only?

With above concern clarified, the patch is:

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Friday, December 24, 2021 11:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: put SMU into proper state on runpm suspending =
for BOCO capable platform

By setting mp1_state as PP_MP1_STATE_UNLOAD, MP1 will do some proper cleanu=
ps and put itself into a state ready for PNP(which fits the scenario BOCO s=
tands for).
That can address some random resuming failure observed on BOCO capable plat=
forms.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I9804c4f04b6d2ef737b076cabf85d2880179efe2
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index e431c7f10755..ad8370b41e74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2235,12 +2235,27 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
 	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
=20
+	/*
+	 * By setting mp1_state as PP_MP1_STATE_UNLOAD, MP1 will do some
+	 * proper cleanups and put itself into a state ready for PNP. That
+	 * can address some random resuming failure observed on BOCO capable
+	 * platforms.
+	 * TODO: this may be also needed for PX capable platform.
+	 */
+	if (amdgpu_device_supports_boco(drm_dev))
+		adev->mp1_state =3D PP_MP1_STATE_UNLOAD;
+
 	ret =3D amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm =3D false;
+		if (amdgpu_device_supports_boco(drm_dev))
+			adev->mp1_state =3D PP_MP1_STATE_NONE;
 		return ret;
 	}
=20
+	if (amdgpu_device_supports_boco(drm_dev))
+		adev->mp1_state =3D PP_MP1_STATE_NONE;
+
 	if (amdgpu_device_supports_px(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
--
2.29.0

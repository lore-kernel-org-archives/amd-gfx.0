Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D7FC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68AB64EE4
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68AB64EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 679206E8E1;
	Fri, 26 Feb 2021 04:29:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF216E8E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 04:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cntCD5GIHMI4Phl4VcTLmkj6dOJLBzyT5nFzUlgjurCuGJTiYJBcPX9LQBijS5VasGRTECGK31uJ75txrgKuPv34Dwk67Fmgdx5UOW4SAyzryoJ7OJ6Ne7gvAOyG3M9aXXwO8JWkOD4eJ2kcOa+aduO2HTrciK8F32nlKEZVKmsq7t0jPf+pBE2/wMKyiAoLFyHws7nOIq06bw3d5zQN+Ugk2G6YnUBHNEGdfeT5GoY+6xdNCwRa5tQq+PNR1nGOOVFN4Q1xTe8QCZK0Z+FO+dZjNrZDAgO6MxIk4o4mFo4wXHZldAs45cMXuY1WlKQwwZirWB1e0gDVqoYRBIfZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJWVyiCgg80veFdQYDsM+YsLlCkx63WifEFPjFKI/y0=;
 b=SYN5uBoasAxlWAolFW+QRmm4sl7jNlBfeqWlCR+6VjTjxtV1vvQq8iJZiwCYszblmjJEnNGOlAh0lu4Fbu/O16ZksbJe3eOuz5MF++XOtX7p3Fs3bDiVVDsA1/zRwQV9XBgOA5OhVS1LwO+sNVty2l/tytqy6qLIfzSTse+pEtF6M/mSfMu/suGGA9w8Oqf347i+i2kizhXTKF0fLvNo1z9MAT6dAfnOBk6POJDtiQG05ZbMdXkTUP6AHBxL26/e9oGM+IyH0qej3RPFU9eCLwV/WpSiOQIxJyMAAueYVVMeoJsc23wQCbaz4trDe+ZosAD1MBZJ4nlWPP76z3AXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJWVyiCgg80veFdQYDsM+YsLlCkx63WifEFPjFKI/y0=;
 b=5mJYZAER/LgjrIgquLir6Wny+Wagcx88IGNz388P91YV/kZ980tlQB2nyN2FQdnrHn6/zH526mq6lq5rQYEklsYjOyNcNqQeu6tHXEiKfNjAXp+03BnWw2Hq3aByPjUHAIE2MjV/N4+Ec9xxENhdFMVrAyPdrFRxXn1vQYQe+LU=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 04:29:53 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::f8e7:bfb4:8183:b7d2]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::f8e7:bfb4:8183:b7d2%8]) with mapi id 15.20.3846.047; Fri, 26 Feb 2021
 04:29:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove unnecessary reading for epprom header
Thread-Topic: [PATCH] drm/amdgpu: remove unnecessary reading for epprom header
Thread-Index: AQHXC95e7OJL3hXTl0i7tMIcaxeUPapp2DgA
Date: Fri, 26 Feb 2021 04:29:53 +0000
Message-ID: <MN2PR12MB4078C6619A293123C3616CC3FC9D9@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20210226012556.10811-1-Dennis.Li@amd.com>
In-Reply-To: <20210226012556.10811-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-26T04:29:51Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c596c0b5-5ea1-4acc-b694-690225521466;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5cbde8a-be9e-4785-28bb-08d8da0f2a02
x-ms-traffictypediagnostic: MN2PR12MB4063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4063B8374F4D425AAEE16CCFFC9D9@MN2PR12MB4063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eefLBE0I0rqNdbrynAVULpwMCObMGWqPREd7+GeZZczsMnh/hDyfXBYgWmO7lvvO52VP1net4lD3Emh++EudhFL31+N9i6QURzGMlxzkYUlaJiCxrIhIYxGFj4y/ImAmPYxq2fKMmN/ObFGCXdGu/yzPu8oI/YBqK0+qCRTAUmQlXmtsqDV6h/yhPaXusBWcWHTQuExGFmkE3u5zYc19Hguf2UINvEv5DXm8R9q7ytgdxrDEvZVdBapsKTCeMOgI/RzXZMxenGWjSi6OK9QyKCQAvwbNsMhDH1K+EQnMXjcR9wH6wmcmbq8kSp3KlGSKds59zstpUpXthGmFSGVTsxiOzbd4CGGHH1uwoPH0E+0i9HvzFxypwQbcv3UpjhNGqvm/KWv1dUIpqMMDWI+9jJU9T+EvER08wudvIaRq4bGPC/GupqKMPiau5xW5OMPfocMssBZe/q92hp0sumr3hdtrkoGciuwFadnBLey/ylecL2eM6wUbg3qaDnAPiSFcAMjhfLzu4ylEeMu7/lg/Yg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(64756008)(66946007)(55016002)(86362001)(66446008)(76116006)(66556008)(71200400001)(6636002)(8676002)(26005)(66476007)(7696005)(186003)(4326008)(33656002)(53546011)(9686003)(8936002)(52536014)(478600001)(83380400001)(5660300002)(6506007)(2906002)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?p4kddU3z0rLRPz6ZFdOfZjaW9A6khBa9FpTn7yhe/m1grVimfzYGxJ8N7tgF?=
 =?us-ascii?Q?hIKl2C4MbqY0P9P5pDAP0jPRqSlIke3YHOnunSpBzmC1ZSUF4le/pvJhsn1O?=
 =?us-ascii?Q?mFVY8vKvA6Adig18O60qHWr6J86qRtz6K/PmyHsRimZOAMfLUlhAt3Z/3mJw?=
 =?us-ascii?Q?R/0EeQbiBeBDBdP3kTlWFujE+s9ZscUQdl2Mg9j5xtj5WV+WjuMa6oMSp3aD?=
 =?us-ascii?Q?wHgCUSdu4IV99b6s4oGywDn8lr6mRAu/qY0HMiMD9narBzR1pZHihUEvGmJL?=
 =?us-ascii?Q?7JroKgIB8C4P7lckCiPdndMGS210rLwa2PJ+Jd15T6drkxjjmevBEE25BiD6?=
 =?us-ascii?Q?fErZ4dN5MI6v4FFLmeHfJu5E5hg2lF0+9qpKXW043i0HfobNT9Xo2ypJBqaN?=
 =?us-ascii?Q?VlZBTk/QolULJJCbCT9ZMtNLdcVvl3LczV6D6liX6vLYpPOJgvoHuyjNNcHh?=
 =?us-ascii?Q?g9ThyFqiG9Jc4BVR8LtjnxFMWaoN6OZnpYnXWbRroKg7DRkzkpilicGiX4N8?=
 =?us-ascii?Q?jR3ggYCxUx2jqx+JxYzCbAlclSiB7n9XGQzhTITH/74pm8+QtS4iuezZUyIW?=
 =?us-ascii?Q?GFfPBWzHq/+Id0b1llKG1XeWlrDYvkpJY88R60x+HD0k6wp8UvnaRdUmbbAI?=
 =?us-ascii?Q?6XPnT68STWBySKvtptSpHpAbyHZTq/2FNk+8jmRbLNDq0B1D5DJZQPNtrIcW?=
 =?us-ascii?Q?PiL5Va8ewXy3PgP5biTjquPiUYsL8aHI9fJXklMiGwJMWnTKP0JfZZCHX72C?=
 =?us-ascii?Q?J+ODicGUUpQLVeDK/FTaS214A1t4sk48VuJVB2MKzC4welx/aHCwynbzEZlu?=
 =?us-ascii?Q?CgrRKLc5qt4ekkgP5r+lMkSkVfmU4pWPW28Od7gBMN8b36C/xBN+kfTvPSCJ?=
 =?us-ascii?Q?WFu7WsoItJ7UA2py+FYMFIU6Vv66mkWT4313Ezr76br31BG5mLHLWsBzKp2E?=
 =?us-ascii?Q?XpHgOEgX2ogNfJjGSSPMZLDaN2S3kJzRaKSQqPJYVfafiWg/BgE0dmGDPllt?=
 =?us-ascii?Q?uSxtHW+XNXHx+4/o8kuf2LPnjvqSBuxPLPRHK6we7sywR7ZBQ3F7ShU0fwqO?=
 =?us-ascii?Q?USxNGcg8tqFioaDxdUxUXYEclrKLgNQHXB2wgj+mItJVZ/QHKm4UcPNqkKx6?=
 =?us-ascii?Q?stwK+KbHta1dEQwZtePuWbGbZe1rs/lCNBiKmFumZgWx6g9TFwKpLA2SEuHG?=
 =?us-ascii?Q?HUgRnZaar4PvRMls2A9arFTF76z/VgPyjLwXkzve500ucEvH4krnRx9wnA6p?=
 =?us-ascii?Q?NfvlydjTuGmWbDFBj3UjST2sZCr5IFOqpi0c1ZJBLCkcmkOkUGqG3ffuoZEl?=
 =?us-ascii?Q?TeWnrOaIPN9etAEmfRPH9gP+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4078.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cbde8a-be9e-4785-28bb-08d8da0f2a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:29:53.5531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxwbNVd/bMk7OvIVSWHTBuLnQCD4eJWPbP7IVe0cNS7obVXOyxolU/jnvbaNp+D7JAuQrpMgVB9Xby7pwb0BBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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

What about merge this function with amdgpu_ras_check_err_threshold?

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Friday, February 26, 2021 09:26
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: remove unnecessary reading for epprom header

If the number of badpage records exceed the threshold, driver has updated both epprom header and control->tbl_hdr.header before gpu reset, therefore GPU recovery thread no need to read epprom header directly.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 19d9aa76cfbf..4310ad63890c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -439,41 +439,19 @@ int amdgpu_ras_eeprom_check_err_threshold(
 				bool *exceed_err_limit)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	unsigned char buff[EEPROM_ADDRESS_SIZE +
-			EEPROM_TABLE_HEADER_SIZE] = { 0 };
-	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
-	struct i2c_msg msg = {
-			.addr = control->i2c_address,
-			.flags = I2C_M_RD,
-			.len = EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE,
-			.buf = buff,
-	};
-	int ret;
 
 	*exceed_err_limit = false;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-	/* read EEPROM table header */
-	mutex_lock(&control->tbl_mutex);
-	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
-	if (ret < 1) {
-		dev_err(adev->dev, "Failed to read EEPROM table header.\n");
-		goto err;
-	}
-
-	__decode_table_header_from_buff(hdr, &buff[2]);
-
-	if (hdr->header == EEPROM_TABLE_HDR_BAD) {
+	if (control->tbl_hdr.header == EEPROM_TABLE_HDR_BAD) {
 		dev_warn(adev->dev, "This GPU is in BAD status.");
 		dev_warn(adev->dev, "Please retire it or setting one bigger "
 				"threshold value when reloading driver.\n");
 		*exceed_err_limit = true;
 	}
 
-err:
-	mutex_unlock(&control->tbl_mutex);
 	return 0;
 }
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

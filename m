Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3ADC2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 06:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D367961409
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 06:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D367961409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0B46E9A6;
	Tue, 25 May 2021 06:23:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CDC36E9A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 06:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjSM8kHwGgxj0+4Oj2rzElMY67fGqKgnqCMYjgYioF5wvgeYT42Mr6kFzUW1gqmuSAQSiPN0NjCKZzJDjvS5vgqN1npW1kMVizlMPRcy2EZ86IPZ2jTBtSSvGFr2hgDCVXqpx0NE9jeX/DQxXM4pOjki+2Rs7Ds6IHfD5gpM+6fMJQF980c7W7EkhoaO2EMCiCybKuvhvKTg/qKF5812qPSvL6DDWD34Er033H7cYegF7yKvahA8KD2krB2G7I5tBsrzLSyzc9sqwSLdaW6SOz7uxGEl8gPzpEdN/IVMtBA1ORkgCjO0Eh+CYTTNflvdSRoH63wTMUN4k4r1fe6/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/pX2wbjYglTXqcrcyiQsnDmUuv5iro5la9qB7B1aSE=;
 b=mUR1gYdrRj7Z6WQ07VBWpRvy0oS+3lWbE0YGXj104xWLOfEsH7rz40UySfHePz5lPNKwiCA/iFN5GoPrt1lkh/q1dyaJ2Toxd22lZJ1oKCTYHeDPbM+kLbV9Ui6GfV0T6EtV364vLvxiJVJ9FUlgiaAr9WkL+TQHrzJzh2PXfMjrwA3pCjKTdJBZPGPPdoFt1dAJEcVYUDi4AnoP9AeurMvk05xHp1LlroTMeUSqG1j540UF3MW9xpMgtRGS+4/RcA4ExCpiXHGOAVQLbXIx1N1F0aMK4PSQ0ASC7GktZ/qd9xv+64AayYEioM3Wvr6QJO5RVtrHWROTh5oeYyIyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/pX2wbjYglTXqcrcyiQsnDmUuv5iro5la9qB7B1aSE=;
 b=SGzp2cq3Nm8u/74Js3GErksogIwfi25t5TT+amVt5WjiBTp7PfeV46UlEFoxmCQliEjJf7RZI6Fxx0HCg6T/F2pavsaCvLKuGCvpI1LdEvfoPTQ6JybThd6Ny14KD3bfTI8Ee/GnvALZsB+YDXxFNKP4s9CPF0kDTXiWKViUqjQ=
Received: from BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 by SJ0PR12MB5408.namprd12.prod.outlook.com (2603:10b6:a03:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 06:23:00 +0000
Received: from BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::b123:6491:dff1:e2b9]) by BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::b123:6491:dff1:e2b9%9]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 06:23:00 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info
Thread-Topic: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info
Thread-Index: AQHXUS2aukEVFz213ESNyP2RUrtVIKrzujtA
Date: Tue, 25 May 2021 06:23:00 +0000
Message-ID: <BY5PR12MB555743BDB1C594842EDDB55BEA259@BY5PR12MB5557.namprd12.prod.outlook.com>
References: <20210525061654.3002-1-Jiansong.Chen@amd.com>
In-Reply-To: <20210525061654.3002-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=38567ea7-e817-4e4c-b42e-f03a74259d2e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-25T06:22:10Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3e62826-550a-4cf4-4465-08d91f458bcd
x-ms-traffictypediagnostic: SJ0PR12MB5408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR12MB54083C2229AEE5EEB8C88A58EA259@SJ0PR12MB5408.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sC+mzxLnbhESsWFTWuPcWk7xqc8Vu2NemyNxqGnjE42ErOWwWAtojnksdZ7lllIOHMF5HhhkGN886JCG9wvhC35wk+W646bLnq10eXfO3b7uprHhpPCSuM276a/xXpcCf90fztuOfob7/VcQUrVYxx+lP31hAdW3QyQXNr7H0Yij3cm+oktsKUKh9s/eMT9iCOhRyXg3hXFf67TwnnwOlyZeCgbUzJjJ2NEHNMk8iF1BFVGJX/lhZBPKnehLTo4p07FiaRLe3raHCunpHXAaGgbhWJKbwUPVkx1GSooeqycnkBp6FBb0NO37aF735KuIhKs4REdcPbnfMsc7/H7kRqW7xgBp5xNo8JflMbhUY6oWe66HwOqqI0x9gCbnXxazRVZQFoc6wRLenDPhjjtRVNwLH0WDjSVJbLPwLycnir99Ca110jdkXzak58jXBSBJDtadp4nQ290nm6AkKZX7/g5iEELpmy/XMV8i28YtxAUTeSu3gCedBZV0gsb2benj5x7RRcCFN7SkWVT3Pk8PvZUb4OKNjA8XV53/wON/KxXWw/XrxfucipCsWJHj+aF05yfZSAdVfobHbCcTzPoX0zIZTcPDQQwMfs6BbLv1Tw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(9686003)(8936002)(83380400001)(7696005)(52536014)(8676002)(122000001)(110136005)(5660300002)(316002)(38100700002)(33656002)(186003)(86362001)(6506007)(71200400001)(53546011)(66476007)(66446008)(66556008)(64756008)(76116006)(478600001)(26005)(55016002)(2906002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cxouXEOAbVRo+Fbs43EHAmtTPJEIgv7QH8+Auwkzaz7FQjUO+ksQetYxuEQ8?=
 =?us-ascii?Q?ZhHz+DK6RrNz/mOG/UxNVq8ehlGZrqs2icS0y6jUZPArYLWy/O2IxL4n3UdU?=
 =?us-ascii?Q?D9MXKI17dpK+fGDjkAmNjxp2R8aDQW50jF5jU7JsJ8Jynaw93tGOLZOnQL0U?=
 =?us-ascii?Q?u5JucadDn5RkptyFGP3nknq2d8tjHBSZtLka13NE/SgzdxKkHUVrmOsAEQGU?=
 =?us-ascii?Q?k17n/RxXfItY8us4/dTEW4aY6AfmSX5OXQjg/3yZLCPEnp+j447mtNo5gK/3?=
 =?us-ascii?Q?fYJ1UZLOWIV5dWXk6ypK0uS9GcnIAUC7StdMU+YpQIFxIk/IY5oixEo8uEgk?=
 =?us-ascii?Q?jZa9eygpZlL+0wkR9eXxF3+zQ5oblCDas3lhWpOeBOWAqMdZbN7kO8+nHLsD?=
 =?us-ascii?Q?LvyI1eohPfzNf2Y9HShhIAq6uAAx5ucu4CzzOzvCLV3sqL22iViCnpanYLxM?=
 =?us-ascii?Q?EJgi/IeHPz9NP6Xy/HvNLb5uWCebzOX4DjhhbrmLz+GYV6m/Wo2ERxAxaWMu?=
 =?us-ascii?Q?rOsFnnyeta5vlS8iEDAn/fYKtHXg9AAVp0nyKSOg3iYijNfVJ35c1HIA3KN/?=
 =?us-ascii?Q?hPYjPFwF1+a90FWVg02mKApr/++DBsfRBGmkUzAtFUSCLJZEtZcBSGNa8flv?=
 =?us-ascii?Q?Mh1TBfKXLfO2qKe86VcCXnDH/IXSB8O4rkmGnu2C8c+Gm26xC7DHilqXIqRf?=
 =?us-ascii?Q?QTyPsheCXCCvy18XaJg9fqzTEplTIDMGsVB3IH5XbGTN4K7Em56ucIbBZBQn?=
 =?us-ascii?Q?nylcv31TzV0lN4jb2Jo5m4L6spJYXCrzjWRuSXykY9VzG0sa8u5QJL4Cdfw9?=
 =?us-ascii?Q?Uyed1zI665k0vukRaC1qfLiMEhRPnQ0h2oZBJlLPN0mF9oYm08yyxwSWRegk?=
 =?us-ascii?Q?yuyRD6Vr7Ns5vKWoGpGFBSehJkDd/zUPNtCNPWmrzDstRmZ4pEbXJ/qZh971?=
 =?us-ascii?Q?UpopkfG5l9A5NI8bLXDQEnLfcProMOyaeyqPudupNKSIix0z9s8zB0aA/xXA?=
 =?us-ascii?Q?6G7LxOeJ9+UM4kvRQS1YcCW7/yEGmKtNqBzOe9ZJocbQdXyl42PM+rMx5hCY?=
 =?us-ascii?Q?BTkQPTwX7EiHXFJ4Nj4okb/N+EVeNIVuSwGn1yS2YWLN1TTtBDZ7U4r5wzp/?=
 =?us-ascii?Q?4r3HHGMsoMTWy0b5NaJc0A3iRwZeH0vKDKspJQvpUv3LiR8AZSJTDF5dtmfB?=
 =?us-ascii?Q?RNPpmtFDF0BQuI5xiidYW//IcrwUPfFgfxnfthDlcxR3xlL6RDeQCTozM50l?=
 =?us-ascii?Q?V5CWfhQ2leRnVaYJzePnuLrha5dYmh+0w9ympTfpLYSqv7r2jmDOjx2EhH2G?=
 =?us-ascii?Q?5NyA5kENeK5o0Qol5nfsn0BE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e62826-550a-4cf4-4465-08d91f458bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 06:23:00.7300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PngM3QoEefSO2gnBzF4UOYMbsgcVWvYtXtLfUmDnSAZUKDiZZhU1jU6tKkwWEJELDNIMhkIL2OxUwfYj56Aesw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5408
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

[AMD Official Use Only]

Please ignore the patch, will resend after removing multiple assignments.

-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com>
Sent: Tuesday, May 25, 2021 2:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info

1. eliminate potential array index out of bounds.
2. return meaningful value for failure.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I9be36eb2e42ee46cd00464b0f2c35a4e4ea213e3
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 69 ++++++++++---------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 8f4a8f8d8146..5c2b4403a5b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -101,7 +101,8 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,  int amdgpu_fru_get_product_info(struct amdgpu_device *adev)  {
        unsigned char buff[34];
-       int addrptr = 0, size = 0;
+       int addrptr, size;
+       int len;

        if (!is_fru_eeprom_supported(adev))
                return 0;
@@ -109,7 +110,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
        /* If algo exists, it means that the i2c_adapter's initialized */
        if (!adev->pm.smu_i2c.algo) {
                DRM_WARN("Cannot access FRU, EEPROM accessor not initialized");
-               return 0;
+               return -ENODEV;
        }

        /* There's a lot of repetition here. This is due to the FRU having @@ -125,75 +126,75 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
         * and the language field, so just start from 0xb, manufacturer size
         */
        addrptr = 0xb;
-       size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
-       if (size < 1) {
-               DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
-               return size;
+       len = size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+       if (len < 1) {
+               DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", len);
+               return -EINVAL;
        }

        /* Increment the addrptr by the size of the field, and 1 due to the
         * size field being 1 byte. This pattern continues below.
         */
        addrptr += size + 1;
-       size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
-       if (size < 1) {
-               DRM_ERROR("Failed to read FRU product name, ret:%d", size);
-               return size;
+       len = size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+       if (len < 1) {
+               DRM_ERROR("Failed to read FRU product name, ret:%d", len);
+               return -EINVAL;
        }

        /* Product name should only be 32 characters. Any more,
         * and something could be wrong. Cap it at 32 to be safe
         */
-       if (size > 32) {
+       if (len >= sizeof(adev->product_name)) {
                DRM_WARN("FRU Product Number is larger than 32 characters. This is likely a mistake");
-               size = 32;
+               len = sizeof(adev->product_name) - 1;
        }
        /* Start at 2 due to buff using fields 0 and 1 for the address */
-       memcpy(adev->product_name, &buff[2], size);
-       adev->product_name[size] = '\0';
+       memcpy(adev->product_name, &buff[2], len);
+       adev->product_name[len] = '\0';

        addrptr += size + 1;
-       size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
-       if (size < 1) {
-               DRM_ERROR("Failed to read FRU product number, ret:%d", size);
-               return size;
+       len = size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+       if (len < 1) {
+               DRM_ERROR("Failed to read FRU product number, ret:%d", len);
+               return -EINVAL;
        }

        /* Product number should only be 16 characters. Any more,
         * and something could be wrong. Cap it at 16 to be safe
         */
-       if (size > 16) {
+       if (len >= sizeof(adev->product_number)) {
                DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
-               size = 16;
+               len = sizeof(adev->product_number) - 1;
        }
-       memcpy(adev->product_number, &buff[2], size);
-       adev->product_number[size] = '\0';
+       memcpy(adev->product_number, &buff[2], len);
+       adev->product_number[len] = '\0';

        addrptr += size + 1;
-       size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+       len = size = amdgpu_fru_read_eeprom(adev, addrptr, buff);

-       if (size < 1) {
-               DRM_ERROR("Failed to read FRU product version, ret:%d", size);
-               return size;
+       if (len < 1) {
+               DRM_ERROR("Failed to read FRU product version, ret:%d", len);
+               return -EINVAL;
        }

        addrptr += size + 1;
-       size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+       len = size = amdgpu_fru_read_eeprom(adev, addrptr, buff);

-       if (size < 1) {
-               DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
-               return size;
+       if (len < 1) {
+               DRM_ERROR("Failed to read FRU serial number, ret:%d", len);
+               return -EINVAL;
        }

        /* Serial number should only be 16 characters. Any more,
         * and something could be wrong. Cap it at 16 to be safe
         */
-       if (size > 16) {
+       if (len >= sizeof(adev->serial)) {
                DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
-               size = 16;
+               len = sizeof(adev->serial) - 1;
        }
-       memcpy(adev->serial, &buff[2], size);
-       adev->serial[size] = '\0';
+       memcpy(adev->serial, &buff[2], len);
+       adev->serial[len] = '\0';

        return 0;
 }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

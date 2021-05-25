Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22252C2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 08:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9251611C9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 08:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9251611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD596E9BE;
	Tue, 25 May 2021 08:17:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A265F89A44
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 08:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nfp9reHAjCQBw1XX+L6WE+OJPZHD7FdhU+44kNjQk0UaqT09covePH/5e6qDg7LjHd4GQgjFWparob6ckZtyQds+3sEMtEO8MbWYjFsM2QjVmxqV3CDvc61T0V3Vl0O55HoE3f4wZD67hWqAS/QkSnDHVKf0M6U677hVBwTSmTBeVjstWtdu1fiGnlk8URLPbnLNA6EXs7UuFGD3fCznlIN9mFk56OcOO0fiE34Bt+ubvYjC5NhVQcwEMoM8+ADSGriFdYR0VF+hQhBVsvLN+EsYjo1LeSJXpCUQjWMbBsbr6pHrj0n4dH1GtEI/ZDK7AYJLza0jlDFyV4uvfTqEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ4i5BsR3eVZq+Ux16Ky/C1oF/7xQqhOoTm9nwufgIM=;
 b=VEtfXchS7hxoC1DmOU8XocOAOoChFqeqq+BrmZsKB+Vss2zxHWIaYTSp+YJ0r2HlKyAn0LsthTXOrXtGUSbpU8IV8t2tmuBrdcB9nIyqZNMnApYr0I2MYjHblyy79O0GC0wz+ETd0B38TRjS8om2Dw49UOb6yJ48sDJi1R/vkkbzeBmi327wYrCvKlT3eMHXPWD/vU2jvevbZvlVPxmpMnoivu+REpi6iJzfu2t+0Zosm/zPl6DJL1RKduHAM4IFCFFgNU3GvHxTSIg/eVMvqBaO6IRgrKC+IdQbavgiYkEYLOLPNqQmoojsIBkFkA1ug+C1t3DAbC0uVpQKZjz0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ4i5BsR3eVZq+Ux16Ky/C1oF/7xQqhOoTm9nwufgIM=;
 b=rZuPDlB4I0JwfNdvMdwTcTteQXSvyTBR9HQ+YG20Fe9HgDePr3DeqghCd/S+ztyr4V5A/l3VgoPFAy0Ij3gYnQU4ckL5QeWDq5lbvt7p4waQcUBIrFkO9fQ2/W31lZQyHQ9JkcnY/BHRWC2fnqPuDBivF4gt0WbErsolOn93AYY=
Received: from BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 by BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 08:17:47 +0000
Received: from BN9PR12MB5244.namprd12.prod.outlook.com
 ([fe80::b0c0:588:7be1:637c]) by BN9PR12MB5244.namprd12.prod.outlook.com
 ([fe80::b0c0:588:7be1:637c%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 08:17:47 +0000
From: "Gui, Jack" <Jack.Gui@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info
Thread-Topic: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info
Thread-Index: AQHXUTEn6VlPEml4Ck+HxVATbe1iRarz0eGAgAAFeQCAAAMCwA==
Date: Tue, 25 May 2021 08:17:47 +0000
Message-ID: <BN9PR12MB524416D88DFFC35B35C31BF28B259@BN9PR12MB5244.namprd12.prod.outlook.com>
References: <20210525064222.32495-1-Jiansong.Chen@amd.com>
 <CY4PR12MB1287299074EFC87B16273934F1259@CY4PR12MB1287.namprd12.prod.outlook.com>
 <BY5PR12MB55571600C28F85596F2B8292EA259@BY5PR12MB5557.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB55571600C28F85596F2B8292EA259@BY5PR12MB5557.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-25T07:46:53Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e605f181-2930-407f-9d46-624a22a84d15;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d9af0e8-acd2-4445-4ed4-08d91f559489
x-ms-traffictypediagnostic: BN9PR12MB5194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5194F6BFE6BC54ADC1AAF53A8B259@BN9PR12MB5194.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 60KLHfTfA8dvlix63CTNlKKQJxy0hbjGEj82L5kXVDwm7GrzDtj6wDCmTEDpaeZb+ihxf7VkD0vuAIFLySvJHvp+jechStTZeCAB8ass8Z4lQ6PhUjB12RkTsqVBJV356lRajKbbEV6RmNhsCvr1P/L8kcwD2fesIdGtmjB8mH/E5dF3hlvf+zeoCcrX9xELFeKRWZTykEdYKR98V614oLxasPCyRUqVZkRdQyAonVmyzOvsTOBxS55DCOA3E5LaDUbMXuZkKcZskrOfIypNnhyd0Y2U2jZauOHFM4KrDDkvbz5Ix/VexYivqw7azsgsvE38fo6Cj+1sif7jJvo+FD9DohGGq2T66gugBirm4qP8Zet7+Ta1RdwQWMNne9SQnzeIfWvSdtcpMXT8UHIezPWlvwqyTCZJYUaCQ04h9BkEjJky/4/TAz6mv4aupVGzVV1puUcrg7w7w6VmS0euskcRl+wxuWltmjPtUb/qLgLk5TTwlz/dWO7Abvg15RNaBuwSh9OpQZe+cTYSeUWA+YHZ6keSiYnUcUXM/3v5zJNRxzvGhd97QxOsxRKlsRy+PfRj3SlYxX+CaFoeNZaDUPAuTRtE4IH+HZLj2KpcLzS6fXll1X52x62JSuC9nSW7TqaXvzYRg4uhTQvjMyOKfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5244.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(52536014)(86362001)(8936002)(186003)(110136005)(2906002)(66446008)(8676002)(83380400001)(5660300002)(53546011)(33656002)(6506007)(64756008)(66946007)(38100700002)(966005)(122000001)(7696005)(9686003)(71200400001)(76116006)(478600001)(26005)(66556008)(45080400002)(316002)(66476007)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+yqToSMxEIEHIU57A7SnfPjBgBoBid/rrYOQu/b9/pQ1CpokjC+JSSdDS/kV?=
 =?us-ascii?Q?igXfnLJSvSULbOY4MAkVOOIQEFHan+SKMdy7l3D3uvERkOIB9LQzxhUoOpUE?=
 =?us-ascii?Q?w6d4qd0CVSPS8BU+wvQch4vfwDdxuBwFvDDDSQbpiaJ6to2dvEY/nn4Vs1QK?=
 =?us-ascii?Q?GaGUstj5MZWcO7+W+ytRJX0bMuiGrlckH2LjN3A5CKTUUizNFgY6RcVGTdal?=
 =?us-ascii?Q?KPoxHDZuTY9cXxSDsw5SSb2AyJL3yAqDNTCvYd93SGLFCw9VLNz7wHhZ8IlV?=
 =?us-ascii?Q?XfKC3nsyXF4MYZoWvZLl/qdj3+W5hsZPPx7RsGT//rQ8FaYvlRP97P4yb5gx?=
 =?us-ascii?Q?poDK+mCileENeLcLJpS32yw7nvNuJxs/NEV1/2XFJvUb09m9XwCcrvfdZS7z?=
 =?us-ascii?Q?uHFmhtJ9zH2PnFB6ofawrmAsm8lj0I0n46hYLEtQ+cKszRgVGLXMY0CgoexS?=
 =?us-ascii?Q?ppMIMHYdZNo8l7+22DFgVhuZnhVieBLddkpE0Rr6HyhulHIa9RMeBA8pb3zs?=
 =?us-ascii?Q?H5Uzr8niN/Ay5G70z9bBkBy4ZnZ/JiG0sL59TXf/OjTBQ04pwqn6HfGy8eLt?=
 =?us-ascii?Q?/VcHQIJ3xO2FeewWLsMf9X0+s6rf58Mk/2VU1KRnG7d3wlkDKYy0jrg36mD5?=
 =?us-ascii?Q?SUdGqNi93zFuhg5KDUgfJe0vt0gCpGooDAXTtwilW/vRvRdV2b0czwIm4XBJ?=
 =?us-ascii?Q?1/HLcXY1OuqxjRBcTm92vXxahxPCUIUrjpL1xhMsRq65K36cKr9mqcZQW2d9?=
 =?us-ascii?Q?8xEmv8fvPZ6uQUmsZJlasybISjPPQOHOon3ASfXKP+x6DWN1dIHKy/gfpfVp?=
 =?us-ascii?Q?NTnWz9DyFs9KnB0P9ceH1gJT4iz1Y1fRUJLK4EDIh7IlpJLqYRvoCKvXRSMT?=
 =?us-ascii?Q?0F3FK1/sEoe4aNsKIZY3NoReuiE9S5PpjSDNPXdPLVPybHUZWGJaFMonSv4Y?=
 =?us-ascii?Q?q70q62byLHc0WY+UELGJssVMRXwbc81zPy1ZCMyf9fIJlgq4GU6eruSt6mFG?=
 =?us-ascii?Q?8gOWc6RaYwRjd2C1tRqtReb7EpLSPX7n7YbEcKYwO26av/KUOBPe0onpSYF1?=
 =?us-ascii?Q?aIRYKc2KqUEacG4WbDUFM0j74Ng2YCaoRSuEv94JKmh7rLXX3YIqhGQ5YDmM?=
 =?us-ascii?Q?7fBfWGl9T/eGS7oUE9aitIStWlWQ9Z7aHnSSuMviWZ2bMDVP9IcI35KuKeWf?=
 =?us-ascii?Q?5SN/mMXmkFEiyPxWZ/7+Fz9oCiRkgcBTyO9oGd59gFMjrmJISmdFPyb2LAGW?=
 =?us-ascii?Q?j7AtYyyMtI0iy4kfmZfimNdlULcc2zqIC7qQaNCJUZKWWnZNp/Wlaty4CzZR?=
 =?us-ascii?Q?zIXx0mDFe226WR5sVtFauDZ8?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9af0e8-acd2-4445-4ed4-08d91f559489
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 08:17:47.2999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRFLj5qAjWAwInzyVOKf2xwFjHIWcopjkXpGKOjsflV4vCAM8o1fkejUMvqFZBtM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194
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

Reviewed-by: Jack Gui <Jack.Gui@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Jiansong (Simon)
Sent: Tuesday, May 25, 2021 4:07 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info

I think we still could keep them to be more informative for the moment.

Regards,
Jiansong
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, May 25, 2021 3:47 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info

[AMD Public Use]

+	len = size;
 	/* Serial number should only be 16 characters. Any more,
 	 * and something could be wrong. Cap it at 16 to be safe
 	 */
-	if (size > 16) {
+	if (len >= sizeof(adev->serial)) {
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
-		size = 16;
+		len = sizeof(adev->serial) - 1;
 	}

The hardcoded '16' in comment/warning printing needs to be dropped as well?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiansong Chen
Sent: Tuesday, May 25, 2021 2:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info

1. eliminate potential array index out of bounds.
2. return meaningful value for failure.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I9be36eb2e42ee46cd00464b0f2c35a4e4ea213e3
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 42 ++++++++++---------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 8f4a8f8d8146..39b6c6bfab45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -101,7 +101,8 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,  int amdgpu_fru_get_product_info(struct amdgpu_device *adev)  {
 	unsigned char buff[34];
-	int addrptr = 0, size = 0;
+	int addrptr, size;
+	int len;
 
 	if (!is_fru_eeprom_supported(adev))
 		return 0;
@@ -109,7 +110,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	/* If algo exists, it means that the i2c_adapter's initialized */
 	if (!adev->pm.smu_i2c.algo) {
 		DRM_WARN("Cannot access FRU, EEPROM accessor not initialized");
-		return 0;
+		return -ENODEV;
 	}
 
 	/* There's a lot of repetition here. This is due to the FRU having @@ -128,7 +129,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
 	/* Increment the addrptr by the size of the field, and 1 due to the @@ -138,43 +139,45 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
+	len = size;
 	/* Product name should only be 32 characters. Any more,
 	 * and something could be wrong. Cap it at 32 to be safe
 	 */
-	if (size > 32) {
+	if (len >= sizeof(adev->product_name)) {
 		DRM_WARN("FRU Product Number is larger than 32 characters. This is likely a mistake");
-		size = 32;
+		len = sizeof(adev->product_name) - 1;
 	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
-	memcpy(adev->product_name, &buff[2], size);
-	adev->product_name[size] = '\0';
+	memcpy(adev->product_name, &buff[2], len);
+	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
+	len = size;
 	/* Product number should only be 16 characters. Any more,
 	 * and something could be wrong. Cap it at 16 to be safe
 	 */
-	if (size > 16) {
+	if (len >= sizeof(adev->product_number)) {
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
-		size = 16;
+		len = sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, &buff[2], size);
-	adev->product_number[size] = '\0';
+	memcpy(adev->product_number, &buff[2], len);
+	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
 	addrptr += size + 1;
@@ -182,18 +185,19 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
+	len = size;
 	/* Serial number should only be 16 characters. Any more,
 	 * and something could be wrong. Cap it at 16 to be safe
 	 */
-	if (size > 16) {
+	if (len >= sizeof(adev->serial)) {
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
-		size = 16;
+		len = sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buff[2], size);
-	adev->serial[size] = '\0';
+	memcpy(adev->serial, &buff[2], len);
+	adev->serial[len] = '\0';
 
 	return 0;
 }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJack.Gui%40amd.com%7C9587f3c2d6c84b28b3b808d91f540388%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637575267971455391%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Q4S%2B%2F4E9BnaIwzra%2FyRRdF%2BD75QhTVKEdqLfQxFMOTs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJack.Gui%40amd.com%7C9587f3c2d6c84b28b3b808d91f540388%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637575267971455391%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Q4S%2B%2F4E9BnaIwzra%2FyRRdF%2BD75QhTVKEdqLfQxFMOTs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

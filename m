Return-Path: <SRS0=J5eG=D2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88CDC433E7
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 02:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3A222269
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 02:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GwfuHvM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3A222269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4A46E32A;
	Mon, 19 Oct 2020 02:45:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 415E46E32A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2020 02:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFJUA6ADRY1Xef4AU7O5HhMWGD2Qh5Xsf0qpNE9fNBzXIiS+MNrZ8exFw3jwQ+mOgEFWWmYIM++G8gcxbv4z3I5gmkK3GDmjx32dhgRS/t4sAQgovv/fQ/9VF5+Jpsr2/mUUUTcUOz56B28ZVVoqJQHfvHrYnzcWTmjs/hdTBDwvTD0ljVvnX0D2M1Bz4EYSpIeWqFfNq3mLikHBeJ84SMGohxHcaslhtRsigRjKn51izTzKAOBOhTSiPLfZO9UlC+9iA64xrIk5O2l9Uq2Xytd4dZVdivAOAopgD7VS//nso0mIkVYKavsRawuDgo33P27z9hi0QLDtM4O0MO0VOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGH8cftC+iOgYalomNDj/UY75zyUCqF0Fo8XAhJ774Y=;
 b=Z3ckwuGMcs4BiIzcrIq8wJU2Gw3dLcihnuIntHn9auUs9Z4aaaXYbHIY80ETUixE37AaUFLsb7q+pDntP4qik4pf9rxO2zgfMZ0M9gGcgPqqQvsYg1N8kszjeZ/dGAKAKLj2PQ/uQO84h18h1cOCI42SpVAr92U0e9aK/VIvtbGmtcS4dezlE4DamM4L2hZUCRgGrx8qbYSX/pi02/g/Fzesj3Pxfaf3vcgau0KVOM6sngnYixSZFKKtrMbFQXA8wfZ/T3A+0I24miUnrPS3epndTDL3dZGfFwuamb2SguoI1tMJt+1bZ/5PLtSJtQflsOjUOj1ZgvtFy9SR3+ze9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGH8cftC+iOgYalomNDj/UY75zyUCqF0Fo8XAhJ774Y=;
 b=GwfuHvM92cK958Os4WE/VAkqS21tYBvsPlg31T51bJwcz4Xeh5g/m2uF006QihQoZNRBVe36Kj3VGorYhi97TF+PEDzzW5XYZlGDEDwehlJV19mnFmGvoItWUV/fL6a3nY7DM0e1GPqC8AUXbvz7Qcorp0jS0k1Wf2a6WL2G6io=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3579.namprd12.prod.outlook.com (2603:10b6:5:11f::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Mon, 19 Oct 2020 02:45:34 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 02:45:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gmc10: remove dummy read workaround for newer
 chips
Thread-Topic: [PATCH] drm/amdgpu/gmc10: remove dummy read workaround for newer
 chips
Thread-Index: AQHWo918ntl0B6a0skuOTvjrbCDWq6meO/Jw
Date: Mon, 19 Oct 2020 02:45:34 +0000
Message-ID: <DM6PR12MB40759BBC17CFB3D0B738D613FC1E0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201016165735.1232180-1-alexander.deucher@amd.com>
In-Reply-To: <20201016165735.1232180-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-19T02:45:31Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b3447bb1-e19e-417d-b805-0000117bebaf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-19T02:45:24Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0e8bf126-a907-4018-a21e-0000b3583e14
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-19T02:45:32Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 47bf528c-82ea-4bf9-a86d-00000e274b9e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7e7e9a6-28c5-4ad5-3597-08d873d90da2
x-ms-traffictypediagnostic: DM6PR12MB3579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3579718CD000569692631585FC1E0@DM6PR12MB3579.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7D7hCMzOOwhYNKkzQtLaDqKwLDZbth+Uajvfxzj8ZaNw8w1AFkv7ODgWDKCGkVoqRtFdqL7ILEtVh/sRzsYzKPhkC/s2SlEH7jx+2ZbFjI7R44K72ipbZ+0m14hVKlf6/2NkdyIsp67ByC3TK4XI/LbPScTF828r/uIklXAZknXfLDtMooRvl5fqGGC93MWtdmQdVLyjYo6SIPe+gwQFShx6TGhlKbp6UBmXjTxyyGA22qtaNaWynnhGBBb6tfYHxN7OQG5uRDMKm5xEWb5eSwtYwiBF8OdVeYbeqHAvgfg6c/A4CrAg79l6Leo4ugiKwel0DwYS8FBqLOuKy4UQCSOkuGXH1qMi4giACM5xHu8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(4326008)(45080400002)(8936002)(8676002)(26005)(55016002)(186003)(83380400001)(110136005)(478600001)(9686003)(86362001)(2906002)(966005)(7696005)(66476007)(64756008)(53546011)(316002)(33656002)(76116006)(66946007)(66446008)(66556008)(5660300002)(52536014)(71200400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4NVyuFY9tPGNE6IcTA4XHYy2kv33wGCAW3TqmOmwQziHRisSZD3b/cwqzRX7V5NaQ9vEVOIvcgTJA1H1qT+WzALWTy0C6ba11uQwrx1nwvJbYddVR3znKJP5jIQRzLhmdsx9/IQ6l206IZ6OBa2BJv5szhWKZRtRRu0deupNZDI4pz6saNqXM6Gnf816Jz5bPr38kZZMiv14UkLGXiZenYdo9i2SoURhwIpFB4whZ7hSHyGryFsw3fkIeBPS2j+i+aafEbpNSi1L1YXxBC6FHoeXvddX2NqqG7LVKEyaFlq9O1XqIVg6B8N4gBsiZkW4tYZcs/xAFQIJNbWa3Rh+TK7ybb9BQDLyVYGO17lhJbu+GYpbBJPQL9atMsJNWK/3KT03VIgi3ST+uC3T0e4CEKuWf487I8c8aFmNaRH9oIZ0na6L6JKqyh3noua5K8Qa51xMhloodh+fxDRdQR+R+ImZ8pIV5OEBRKVz+ZK5IUuqVi5y8AYpkK+8IuV8c6BlcweZLJUcU1Fz9e0Eu13uxrWe6C4jwqsaK1VaUdD2b9RPJryZM62BjgrQfmqoKWOeb+z6dKDFCflZCrZ1BCGeMT/5skaaDO1rOk0JPqPtLM8/W9r+vhhD1/HHTXBYChdR7+D+ei4vRz6HfMUH86wGqA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e7e9a6-28c5-4ad5-3597-08d873d90da2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 02:45:34.5691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6MUd1YxrwY+ypKDlQKTpwBhgrQYF9rnWVvnqGRWLLKj944sIlYudkUoearbBxpKbeu5aDxwFsYyvtyuFAZChCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Saturday, October 17, 2020 00:58
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc10: remove dummy read workaround for newer chips

Sienna Cichlid and newer have a hw fix so no longer require the workaround.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f7a8417b2946..40af17610207 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -107,7 +107,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		 * be updated to avoid reading an incorrect value due to
 		 * the new fast GRBM interface.
 		 */
-		if (entry->vmid_src == AMDGPU_GFXHUB_0)
+		if ((entry->vmid_src == AMDGPU_GFXHUB_0) &&
+		    (adev->asic_type < CHIP_SIENNA_CICHLID))
 			RREG32(hub->vm_l2_pro_fault_status);
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
@@ -232,7 +233,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	 * Issue a dummy read to wait for the ACK register to be cleared
 	 * to avoid a false ACK due to the new fast GRBM interface.
 	 */
-	if (vmhub == AMDGPU_GFXHUB_0)
+	if ((vmhub == AMDGPU_GFXHUB_0) &&
+	    (adev->asic_type < CHIP_SIENNA_CICHLID))
 		RREG32_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng);
 
 	/* Wait for ACK with a delay.*/
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C60cb49692afa43db6a5c08d871f49d6d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637384642722943276%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=N5g4KP9PKHFfHi6c9bKI49QRlgmo6ZuxbHAbUe61Aic%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

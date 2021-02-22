Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E7C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 16:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C266664E61
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 16:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C266664E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661876E122;
	Mon, 22 Feb 2021 16:14:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7847A6E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 16:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3PK0OmmkPj8audJhh1ypc52y0XBjsw/kp+MidBxGlbnQBkwfAWXa7f4qz12C1dZOOoqzMdY3BN508MvhmBzryGM1CpT3NFm5dt3qshLd8KcbIq+DgGrBJViog4/zDigaCQRrYt0WE9fSAqt1l82SglAfdvYjTLbky0aqG/wlD84QAt27kZlI7dECkVeUenqEBVj1KOhabj6x1ODmKGtzy1AAnE1/nroWPEBx+dJWCoMuaFYtbWCRUG9YzuX5HJYmBQaMj8j8hQ994ESsrYvVAkdx9ks02y4iolDAQfGm/skyPHFLH12SCnv1LHM21eg9wqUPGhdnYmpgIJbUmAHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y08qfBgFciluA2yUPr1JkG6nPKQ31/6C4W4XjjkFszQ=;
 b=T8G8bil70M8gyK6Et5i4EgzfSOG+eZI9pvhHSRrEMhSTTNiLDQWSgtHp0b6/Kf0G/ZFtQ7iIhJuTFC5kQ9UEUAXhiZqC2ZzTqTiLnd8tJg6WC35lvin8taxpbPKpz/qaVaahuCcyS5qwxblC6hVCpKamikW6x7WwEbLIDaF9lGK+Sheapd9KexI3SbBd6Q1mp/SgJ0nsZpXLvEHjpjnwLf08P2mD8DBv03g2ihuGdr5SDIP7TCKnZ25BApqSnqTiHexp9LHT0UxuoFPM3ddyl0zHs3jQVVdIqx4SLNddhcbyeLGRC/j1CZe/6P6YDrqcKA3Fs7CtBzLhdTps4PuoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y08qfBgFciluA2yUPr1JkG6nPKQ31/6C4W4XjjkFszQ=;
 b=MuQ7MtNaik9tyVoNcDqPVDY/phzGsJdZsILRBVHPnNy6/IRnoxnAlfhOJCZetNW1kWNA6RhLvnmi0Y9OUp23IjH5RSa0V1YkCbiL9bXyeP6RhRicUpu2vzdYYcK3wZVvflmk7gGC2HWR+n+jAXL6I6mqyDII2O2w1FJq3o5L0ZI=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32; Mon, 22 Feb 2021 16:14:04 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Mon, 22 Feb 2021
 16:14:04 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Thread-Topic: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive
 duirng probe
Thread-Index: AQHXBl01v0ZbFS6gCEmvb376iost8qpkWrIw
Date: Mon, 22 Feb 2021 16:14:04 +0000
Message-ID: <DM6PR12MB3835C3E49A3F9477704C5216F4819@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210219011846.28413-1-shaoyun.liu@amd.com>
In-Reply-To: <20210219011846.28413-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-22T16:13:56Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f4c3ba30-d146-4d55-8b02-ec438f09602d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:c0d5:387b:19b:615f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1b5ce39-35dc-4dda-ee59-08d8d74cdfd7
x-ms-traffictypediagnostic: DM5PR12MB1658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB16586C7A040FFBBEA907D762F4819@DM5PR12MB1658.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +vn2QXjiiaTtkOTXbJg/m9b43/8esegb9J01s+j0j22hM1fnKtqZ2SEEc9y3fAlO0JQc8Tv7U9lysi1i75VndTIrk4IpWQkmWlMQaOCJlwGea9JtjifhBYVF829Rwfovl5yUQlqXHUyyOzydR4s+JCmqzmTblYbljHM0Aur3/UZSZTq1XQFIsBwUUBysHz82giNeLHFvA98EFpb0/fiz9TIAPMYz0D01HEvSFtU9RbKz4SQTBP+AFw4pCQpqdvQyfoCl9J1hhAEOI1vxte6B21AI7/Qg8FblHRHYJfOsqVQ0JXNxw4Op7aC6nt5M/f6QDzJxVh4fWPt0lI4LEYRdNzykKTU+VPbyb3V+QlJpu5NsbxUwUFBP1sfiizudDnK3Vr2R3ZU/lp/61eBbZohOQGRN7ytNraHTYvvk0Y6wVS1ZjkRJ+4AKs/iVTZzAd0EtJMLBxQUfBvp753EseqqYeUsBsDGvDeCCsVqpY1Q9QrCoo+xy2vNgv91hOo5YU2IKJhZ4XcR6z+lPfjTq8g7qeJBL8bqh45vHUU6ZOChG2JUJNxmyWmVUxSEEpw5VZns0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(71200400001)(53546011)(76116006)(7696005)(478600001)(66476007)(66946007)(6506007)(64756008)(66556008)(66446008)(8936002)(2906002)(52536014)(8676002)(5660300002)(110136005)(316002)(86362001)(33656002)(9686003)(55016002)(6636002)(186003)(83380400001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ee9QRKx3Mvr2/YXlpnROvoXTLcekFT3GwUc4leYSjaB/Yx7FDYg9G3JrT4+Z?=
 =?us-ascii?Q?V0WAwiTdAeVpJ+3e7U4wuaxgFfs06qB1kpwY2am6ppDjSh1gYc9vMPcmfvIe?=
 =?us-ascii?Q?CAJsIjTwlB/Wt+Tg/GBt+InPY3MWJCSvbRksXFlumZ1X7fL+N1pUhFxNJqx6?=
 =?us-ascii?Q?VwW+khYSXitIeq21Zq5EhRYkTxOYEEBQg/ckbiuIdvPJsZVkM1KXmVU1tW8n?=
 =?us-ascii?Q?HhjCrjZUMx+qqs0f5LZpm9IVHAosz6fc7e+ZnaGLH0esZdpcHW/1x6RitLfI?=
 =?us-ascii?Q?FjTKKaY/AclLD9snv0sKdeB6qdvDFSRmHMDPODlHPUyBz89F1y2M4XloWN2n?=
 =?us-ascii?Q?+WY5Yl9/PQAKdazbWsVpa77NMmJioWvRkqRIc3AjhGPJhFjDKku7YXsA9E/e?=
 =?us-ascii?Q?XVd0A+KvIciD5EZX1nv4QTvO3bIreWUx70nkmtCriO+kYGy3KXJr1I6JXUcC?=
 =?us-ascii?Q?x7ePzkksw/Q//+qsDCnF0ubt20EgqzATbv7oLN5AYfKKeRyK/Bj9hLdQXB65?=
 =?us-ascii?Q?Rar0CECO02Gql4ypeliQwhUpgilg0thPhTSpVWGLIRRPSH/E81lSrmYM6PQY?=
 =?us-ascii?Q?uMzTTh7F4ZUDiK29rStOM9z/dK9P/cmiCXyzGbJi/rdpalcn4xQhD9RsiyY9?=
 =?us-ascii?Q?dBmvw/k0hXRf1SjxL01Sc0WKULaTthjXXH01Hz1kBLJOokyqhNRXWyqiTrn8?=
 =?us-ascii?Q?tHJDoEbrhHq4o9CU5b1xlNaKUgHpGFGkHFGnXyK4pnPlNCxwHpTEu1DKDGXd?=
 =?us-ascii?Q?oZefaDc36Qwpnw+XJqht/y8AS6JVKeZWX6WHK8L1ZkProOFfiW+FQ0MBoIf5?=
 =?us-ascii?Q?dINagYKovYGJv4xnNpt6gB75GbqKZS+kSU/eqFPZXQuFCOq7Dnt36TWIXxzb?=
 =?us-ascii?Q?WqGaiAmx3GYRIEy4+RZpmOpMHDfK3bN33/F8BNcFwRko28r75xMTA9j3Pezf?=
 =?us-ascii?Q?pchZKsiGRc7/5xiM1+j5PrwXf2tRLLrjlkJbuz9WcD4BvRx0gr65xYbmuT/8?=
 =?us-ascii?Q?flgpq0CW2dpwlX8eiFMqpD99/yAMk9qgCN1isQt1px6kh2A4pbfRD1bHT1YC?=
 =?us-ascii?Q?fjQFUc2In3E9l7j6Nnu8zkAT/JfBaCawqq+Ka7tNIKfv8/jJkq0u1DB1YpGQ?=
 =?us-ascii?Q?Hh0NnkRrWO3jQnbQWw4A7FxovvxmbR9lIRj+VKxKogq111zvMT2iHfyThYjK?=
 =?us-ascii?Q?1++WzRE20E4HQvxb9q7CULZYA8H3DvbCcgk0rc58f21gNvGTeEoxVp8lL+53?=
 =?us-ascii?Q?yCTDVrzbqwQY+lE3Yq731m3BQfoShV69DoGB/ekqPJpefaoqJJ90p1f107CF?=
 =?us-ascii?Q?wTbzTc6XDjvDEigodFEoPMelYQL9bJfi50l+Z9/Bp0FcHX/bmA1Xs6GDOuku?=
 =?us-ascii?Q?LsZ+fBAPuJCZpYLCG6fI/u8ziAAT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b5ce39-35dc-4dda-ee59-08d8d74cdfd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 16:14:04.4432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJVl9KN+k9Nh2PExxTWEjrct8MPnoDnUhFDz+AZxvUiUDZZojgK6MT0nnJuUrfoUJi11e9vDvKW/agCfvgspRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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

Ping. 

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: Thursday, February 18, 2021 8:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

In passthrough configuration, hypervisior will trigger the SBR(Secondary bus reset) to the devices without sync to each other. This could cause device hang since for XGMI configuration, all the devices within the hive need to be reset at a limit time slot. This serial of patches try to solve this issue by co-operate with new SMU which will only do minimum house keeping to response the SBR request but don't do the real reset job and leave it to driver. Driver need to do the whole sw init and minimum HW init to bring up the SMU and trigger the reset(possibly BACO) on all the ASICs at the same time with existing gpu_recovery routine.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 96 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  6 +-
 4 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f9ad7ed82be..9f574fd151bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 		}
 	}
 
+	/* Don't post if we need to reset whole hive on init */
+	if (adev->gmc.xgmi.pending_reset)
+		return false;
+
 	if (adev->has_hw_reset) {
 		adev->has_hw_reset = false;
 		return true;
@@ -2147,6 +2151,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
 				continue;
 
+			if (!adev->ip_blocks[i].status.sw)
+				continue;
+
 			/* no need to do the fw loading again if already done*/
 			if (adev->ip_blocks[i].status.hw == true)
 				break;
@@ -2287,7 +2294,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
-	amdgpu_amdkfd_device_init(adev);
+
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_amdkfd_device_init(adev);
 
 	amdgpu_fru_get_product_info(adev);
 
@@ -2731,6 +2741,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hw = false;
 			continue;
 		}
+
+		/* skip unnecessary suspend if we do not initialize them yet */
+		if (adev->gmc.xgmi.pending_reset &&
+		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
+			adev->ip_blocks[i].status.hw = false;
+			continue;
+		}
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
@@ -3402,10 +3422,29 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 *  E.g., driver was not cleanly unloaded previously, etc.
 	 */
 	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
-		r = amdgpu_asic_reset(adev);
-		if (r) {
-			dev_err(adev->dev, "asic reset on init failed\n");
-			goto failed;
+		if (adev->gmc.xgmi.num_physical_nodes) {
+			dev_info(adev->dev, "Pending hive reset.\n");
+			adev->gmc.xgmi.pending_reset = true;
+			/* Only need to init necessary block for SMU to handle the reset */
+			for (i = 0; i < adev->num_ip_blocks; i++) {
+				if (!adev->ip_blocks[i].status.valid)
+					continue;
+				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
+					DRM_DEBUG("IP %s disabed for hw_init.\n",
+						adev->ip_blocks[i].version->funcs->name);
+					adev->ip_blocks[i].status.hw = true;
+				}
+			}
+		} else {
+			r = amdgpu_asic_reset(adev);
+			if (r) {
+				dev_err(adev->dev, "asic reset on init failed\n");
+				goto failed;
+			}
 		}
 	}
 
@@ -3536,19 +3575,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable clockgating, etc. after ib tests, etc. since some blocks require
 	 * explicit gating rather than handling it automatically.
 	 */
-	r = amdgpu_device_ip_late_init(adev);
-	if (r) {
-		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
-		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
-		goto failed;
+	if (!adev->gmc.xgmi.pending_reset) {
+		r = amdgpu_device_ip_late_init(adev);
+		if (r) {
+			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
+			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
+			goto failed;
+		}
+		/* must succeed. */
+		amdgpu_ras_resume(adev);
+		queue_delayed_work(system_wq, &adev->delayed_init_work,
+				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
-	/* must succeed. */
-	amdgpu_ras_resume(adev);
-
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
-			   msecs_to_jiffies(AMDGPU_RESUME_MS));
-
 	if (amdgpu_sriov_vf(adev))
 		flush_delayed_work(&adev->delayed_init_work);
 
@@ -3565,6 +3604,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	if (adev->gmc.xgmi.pending_reset) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+
+		if (atomic_read(&hive->number_devices) ==
+		    adev->gmc.xgmi.num_physical_nodes) {
+			/* Trigger hive reset when all gpus within the hive is ready */
+			dev_info(adev->dev, "Trigger XGMI reset during init.\n");
+			amdgpu_device_gpu_recover(adev, NULL);
+		}
+		amdgpu_put_xgmi_hive(hive);
+	}
+
 	return 0;
 
 failed:
@@ -4241,7 +4292,9 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_full_reset  = *need_full_reset_arg;
 
-	amdgpu_debugfs_wait_dump(adev);
+	/* no need to dump if device is not in good state during probe period */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_debugfs_wait_dump(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* stop the data exchange thread */
@@ -4304,6 +4357,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
@@ -4343,10 +4397,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (need_full_reset) {
 			/* post card */
-			if (amdgpu_device_asic_init(tmp_adev))
+			r = amdgpu_device_asic_init(tmp_adev);
+			if (r) {
 				dev_warn(tmp_adev->dev, "asic atom init failed!");
-
-			if (!r) {
+			} else {
 				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
 				r = amdgpu_device_ip_resume_phase1(tmp_adev);
 				if (r)
@@ -4790,6 +4844,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
+		/*enable buffer function after reset */
+		amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 	}
 
 skip_recovery:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index aa0c83776ce0..8c71d84a2fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -149,6 +149,7 @@ struct amdgpu_xgmi {
 	struct list_head head;
 	bool supported;
 	struct ras_common_if *ras_if;
+	bool pending_reset;
 };
 
 struct amdgpu_gmc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 839917eb7bc3..5e127a59b121 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2261,6 +2261,12 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		goto failed;
 	}
 
+	/*Don't do the real PSP HW init if we are pending on XGMI reset.
+	 *The above init probably should move to psp_sw_init
+	 */
+	if (adev->gmc.xgmi.pending_reset)
+		return 0;
+
 skip_memalloc:
 	ret = psp_hw_start(psp);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 659b385b27b5..b1c8fd90c1b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp);
 		if (ret) {
 			dev_err(adev->dev,
@@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	task_barrier_add_task(&hive->tb);
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
 			if (tmp_adev != adev) {
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

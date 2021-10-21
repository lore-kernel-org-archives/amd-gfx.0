Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32600C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 07:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010C660F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 07:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 010C660F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94DD96EB7E;
	Thu, 21 Oct 2021 07:20:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E44C6EB7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 07:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPHR6RW7Vln4yHffENk/SzVsvHAlzurvLlKqnR1pAgqxz+Aqv5l7+kE5xGzCnjc3ZSgGDgtGFRYzCfxmTLjWFa+6PUEFr5VHduHWLme2z3gwlXzKUaqRsCXwKawLkl5PZI0Sb7xQEZQGAERArbIP8CdwVTNy1lb4ZRp8S8bCYK+rB3/4tKuTYl0d1cs6rY17fdnt3n4hE1q5hdNPnMgEYbI8sZzymxIbDiQhCnHEe0CWSbhAfI1rJDP7TUisg4pqJE+j3KLC8G2/2UlOHit9r+ikdos8I1rPbB4TepNhYXssCWnWVOlIYum7lNl9g4Wxp6XxLIJNSLESDB1PrbQu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Idpg99uSrNdx300ZHFFjhSO9C99uDGipfhLSQH47Q8k=;
 b=NePz50FjvIjIHmcT1VOHaA2qO/1H8PQfD43i+JFOO8qZdMcc05E/Pb03cHb4FB3raejHCvJEx5z3f1qYtaORuB7UBeuFcjWyeQFUzAZ4xFAsKXlp4Z0G1nezQDUQ537HcSTQmQm78gFlzdjjs0C+kNUxvFCi6mtzDE2XkSnWn+FxEqUG3vsrdH5djTQw7z6UUsPr9wt/ynS0SmbsUx1LMcSKYOFB0YnkR7coZ9Rsyj8cx6Ogx8T/oHhth+v4hP6W9rJS4WcAPyxVm//IeZGewafrRI2aSZiehstlk4VpoCowLkpCNr+zY2Ax8IWxdvKjTcuA7l+rSCrvOyLEoZKghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Idpg99uSrNdx300ZHFFjhSO9C99uDGipfhLSQH47Q8k=;
 b=DZEYhmdT5dI0t3ytdwyCN41f3WLR1Wntb4UAgtQEt7o2MpcscVrL7yAd6dWdcJ6V4hCuXvuSaHP+DVvatDQ/4kDeQyt1ylOTu7xw6lFgSkOikUDas3ZhDBA899Y995L1EIMyAdCh1NsfSnBGlBNtyrhPBdTuv89owtNA9r7swBQ=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Thu, 21 Oct 2021 07:20:10 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 07:20:10 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: FW: [PATCH 2/3] drm/amdgpu: use some wrapper functions in
 amdgpu_device_fini_sw()
Thread-Topic: [PATCH 2/3] drm/amdgpu: use some wrapper functions in
 amdgpu_device_fini_sw()
Thread-Index: AQHXxkvQ/GewUGkFCUGzDu2n5BEXIqvdC4qQ
Date: Thu, 21 Oct 2021 07:20:10 +0000
Message-ID: <DM6PR12MB4250B95D3B4286930B65EDB8FBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211021071750.2912140-1-lang.yu@amd.com>
 <20211021071750.2912140-2-lang.yu@amd.com>
In-Reply-To: <20211021071750.2912140-2-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T07:20:08Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=55b36282-7bee-4c08-9e73-1fb681230390;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eac173ec-eadf-47ee-9fb7-08d99463379e
x-ms-traffictypediagnostic: DM5PR12MB1516:
x-microsoft-antispam-prvs: <DM5PR12MB1516EAF18B86E641153016C6FBBF9@DM5PR12MB1516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +XUoofKaootHMg5ooXYCxI3AOo5K4iSs+CZAmGKDvbhYOG+4d8GjWDYzoqKHdCsok8IsYQBH65N5M/BO/e8vVyBM66zsMEN+4x79MISSYgnriuHo7AOJTx9ejbL+n5+Yv5yfmqmV9FWHsw0zzZqtD7T6cjCNrqM/QRdk0Ndz7DzW2y+ZxPRuEGm6IuEqNB9nVuNZ062fNmMYssD85v3Ajua5fZznNVoApty1fcTO8DyKgC/1yPlCEn+cMRYVP1K0cMoR6g4bNMKD/y7sC8Av5WtzymN6+R1bIRBT4LzbuzhD/kZW5gtrTDIY5wndhZO5kGi+zxKIx3N3RGKKDMSpg2qJRpiCuvkon7q4gM03oMVa+6kn82ZVeGUsUst4b+gvg/ti/5bWbLaeup/Ekp/M5Mn4rdquooEQGsL+trnkh429IGNPPRZXhtaOnARvaKXVchsYHOkR7cnDj1GiS68DcSmybtEqDGWrSfVOCWMh8XwYHkvMQfSe21NgFT2O/rPsycfi1bGS24XC69nuC7jLQFZ++yWABC0qrM1vpVbuA5zgshv+S0QrUgZ6kA+zGutGglHHNoiMBTtVoq+MiwYO7j8CXIlKpXZVxTck2kMdCXJg3i2mzeXRHfHcvMLD8KyG3pKzKWvJ4OSAPs+4lwJzbganMOCYI1wVJLOzU6WxtWSJIva9MWAQv76f7/b8gIDmlkmo5Awmj5/NL7mxnZBw/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(86362001)(38100700002)(83380400001)(8676002)(76116006)(5660300002)(71200400001)(6916009)(8936002)(26005)(7696005)(2906002)(66476007)(66446008)(64756008)(66556008)(66946007)(33656002)(186003)(122000001)(6506007)(38070700005)(52536014)(508600001)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RfqTmhjEUeArDGHFICCX4FpJ02lbLNuw9PAI3sUE3FD+yXs3q1nXd0yKOlpo?=
 =?us-ascii?Q?02kp1olJ9uK/6IsedO8CjBIiWkUCD+ge10HZHHuxSE1+faCNo7Ete6Up8kI4?=
 =?us-ascii?Q?LpCKCW2lhoiVlqF3msZwCFzSxorVE8DhsuCklrAzrCP3AqPQwMga4UgFajbx?=
 =?us-ascii?Q?PMZVSzrhWWb96tGoWMixfbe7ybySyoGLC4gAcjUbg7vah8wUVYdPwmyt3ny5?=
 =?us-ascii?Q?ekXY1um4p4+q4+N4Mtl2XYWhGrj5ho2aKXrxiAd3j+TlrV267s046TT24SFG?=
 =?us-ascii?Q?UIrIW2cY3I7wWxVGzATQa9enNOI/R8DDHHeliQRpkszaYO739WzfDFzaz2O/?=
 =?us-ascii?Q?urBWFTuGM+Q86uacTx7GTWAT+TcvOnbShZ3UT8qfABgsyKqbv3u9i+H2wr3D?=
 =?us-ascii?Q?+ZCoM494gpk6zPMORM/fJRz1q+mOiNFESGJeHr4Nju5b0iQ6zx4EWavylD4X?=
 =?us-ascii?Q?Xasx0WTuG39pwae5vhQNQsdHXV6FA1/EoUmCm6ZYdQGeLiKtQGQ+ToZpWbjS?=
 =?us-ascii?Q?lXo5TKV5CEGI8aO4PaUs6FGiEUQuiHEdv7NuLX19PpKJOQYNwTOJ0we3KjQV?=
 =?us-ascii?Q?uR9KK+u+674PTKHqAt+pqDJXYHtqISPLwBIhDqqzWlQXf7SB1Dl9UWtYaBIF?=
 =?us-ascii?Q?UJMXrfARDSmnaS2W/23Ul9qGmsLnKRUisAW4Jnzu6UnilnsJ3MzNl7t6uT4S?=
 =?us-ascii?Q?Yr8G/0MMU0lBlkD2oJMpb//y70cAEZF3dBDIWf7QSHPOdQXHGrklHKhhPsoo?=
 =?us-ascii?Q?cZk5498VeFYtdL+bsVFI/LtmfMg/835j1gMCXxgq1EC6TF40l23jKxz48J5D?=
 =?us-ascii?Q?8WwajtRe6ybLMsKIis3HCRIDd7CoVpjyGkYQxGYKrU5iTpnqS4ObU0ee8IMg?=
 =?us-ascii?Q?jxl97uMd/cIxcpG0MFOTK80kMyh6w0MXtB3vJBZt4U/4fhBVRJT0I89FpkMO?=
 =?us-ascii?Q?+yn8F0F+AAKwMbBVak3AnIcDzJH9lwAKqzhZXxlrzidCodwxNHpC0XGP2gQL?=
 =?us-ascii?Q?eW2/2GFD37cs7L7vr+golhoDfTK5ftzNeO7VbtZvlSM1+nPRRVPZT20SbaKo?=
 =?us-ascii?Q?zfUTKqvbsA+DLiYpQ5pGX0x361PnBujojWO4bfMTiC8FS89l3DX8xXsAO351?=
 =?us-ascii?Q?20+tL3aqZFSweYC6ylL6NmnM4sauyx6vd1Pz/l5qGahrUhu2R+jNUZ9sfgtm?=
 =?us-ascii?Q?6rAxIoDJa+s6FyUIytfCz2Ly3Lz3796hJQzs2lpqkYS+FAub55GKqcWl7jH6?=
 =?us-ascii?Q?FM2k/6k/vm6u6VJPrV7vw7NAam/F4QTKx6nbSjulzquEtSXjus+UnWihJwuh?=
 =?us-ascii?Q?oVHntfX12teMK0rZwnZnhGoR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac173ec-eadf-47ee-9fb7-08d99463379e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 07:20:10.4565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: langyu12@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



>-----Original Message-----
>From: Yu, Lang <Lang.Yu@amd.com>
>Sent: Thursday, October 21, 2021 3:18 PM
>To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yu, Lang
><Lang.Yu@amd.com>
>Subject: [PATCH 2/3] drm/amdgpu: use some wrapper functions in
>amdgpu_device_fini_sw()
>
>Add some wrapper functions to make amdgpu_device_fini_sw() more clear.
>
>Fix an error handling in amdgpu_device_parse_gpu_info_fw().
>
>Signed-off-by: Lang Yu <lang.yu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 10 +++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++------
> 2 files changed, 34 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>index d58e37fd01f4..5df194259e15 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>@@ -372,6 +372,11 @@ int amdgpu_device_ip_block_add(struct amdgpu_device
>*adev,
>  */
> bool amdgpu_get_bios(struct amdgpu_device *adev);  bool
>amdgpu_read_bios(struct amdgpu_device *adev);
>+static inline void amdgpu_free_bios(struct amdgpu_device *adev) {
>+	kfree(adev->bios);
>+	adev->bios =3D NULL;
>+}
>
> /*
>  * Clocks
>@@ -1440,6 +1445,11 @@ void amdgpu_pci_resume(struct pci_dev *pdev);
>
> bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);  bool
>amdgpu_device_load_pci_state(struct pci_dev *pdev);
>+static inline void amdgpu_device_free_pci_state(struct amdgpu_device
>+*adev) {
>+	kfree(adev->pci_state);
>+	adev->pci_state =3D NULL;
>+}
>
> bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev);
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 5654c4790773..be64861ed19a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -1871,6 +1871,19 @@ static void
>amdgpu_device_enable_virtual_display(struct amdgpu_device *adev)
> 	}
> }
>
>+/**
>+ * amdgpu_device_release_gpu_info_fw - release gpu info firmware
>+ *
>+ * @adev: amdgpu_device pointer
>+ *
>+ *  Wrapper to release gpu info firmware  */ static inline void
>+amdgpu_device_release_gpu_info_fw(struct amdgpu_device *adev) {
>+	release_firmware(adev->firmware.gpu_info_fw);
>+	adev->firmware.gpu_info_fw =3D NULL;
>+}
>+
> /**
>  * amdgpu_device_parse_gpu_info_fw - parse gpu info firmware
>  *
>@@ -1987,7 +2000,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct
>amdgpu_device *adev)
> 		dev_err(adev->dev,
> 			"Failed to validate gpu_info firmware \"%s\"\n",
> 			fw_name);
>-		goto out;
>+		goto release_fw;
> 	}
>
> 	hdr =3D (const struct gpu_info_firmware_header_v1_0 *)adev-
>>firmware.gpu_info_fw->data;
>@@ -2051,8 +2064,12 @@ static int amdgpu_device_parse_gpu_info_fw(struct
>amdgpu_device *adev)
> 		dev_err(adev->dev,
> 			"Unsupported gpu_info table %d\n", hdr-
>>header.ucode_version);
> 		err =3D -EINVAL;
>-		goto out;
>+		goto release_fw;
> 	}
>+
>+	return 0;
>+release_fw:
>+	amdgpu_device_release_gpu_info_fw(adev);
> out:
> 	return err;
> }
>@@ -3845,8 +3862,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device
>*adev)  {
> 	amdgpu_fence_driver_sw_fini(adev);
> 	amdgpu_device_ip_fini(adev);
>-	release_firmware(adev->firmware.gpu_info_fw);
>-	adev->firmware.gpu_info_fw =3D NULL;
>+	amdgpu_device_release_gpu_info_fw(adev);
>+
> 	adev->accel_working =3D false;
>
> 	amdgpu_reset_fini(adev);
>@@ -3858,8 +3875,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device
>*adev)
> 	if (amdgpu_emu_mode !=3D 1)
> 		amdgpu_atombios_fini(adev);
>
>-	kfree(adev->bios);
>-	adev->bios =3D NULL;
>+	amdgpu_free_bios(adev);
>+
> 	if (amdgpu_device_supports_px(adev_to_drm(adev))) {
> 		vga_switcheroo_unregister_client(adev->pdev);
> 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
>@@ -3872,8 +3889,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device
>*adev)
> 	if (adev->mman.discovery_bin)
> 		amdgpu_discovery_fini(adev);
>
>-	kfree(adev->pci_state);
>-
>+	amdgpu_device_free_pci_state(adev);
> }
>
> /**
>--
>2.25.1

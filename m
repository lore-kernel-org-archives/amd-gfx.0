Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BB7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 15:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14B289B95;
	Mon, 22 Nov 2021 15:15:56 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD6C89B95
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 15:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl0GgMjl3MhvAUQ6C3vncCr8t2Fu8gK6/txX7UJJ12wNpeo2r2u7Kr6ptJAFGR2hNBmTpzABzZ5zKlqBWWpgxdZ9Y6iy8Ea+HaG8qLCY61NNXrWvz2fJ1hIKJ/mPKwfZEvJnRXOzTjtRDxbdIFFGAC9D561qS1kY4PgwVMiGrgfRZ9l4mNsTM7KJQDz3gkb1BznnxQSbO6ZldS3V/uQegEMF/UyZTIDAgTDCmrrWM3BJ40T4JpkhhioZL5FEYX8V5wiTjy/lkIPqUPuuDQ/xHceQxr2mHyTwseIjmSoMBtcdCGwvX5xmg1kI2VdevrnfvDrpBe4glFZoWXv3f0XwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGoJ0Gh1P4rkAFyRelNicd53EAmek7MvC6D73hiLduU=;
 b=MQ7EV+I/DdhzK6W4cMfnmHnY0/a5yQbVF8ji4ZRSgLJBrKe235pR+S6qAkUBjWxtlW0yuEPQtTWnvRUJxIZ2u7ovHKaEDQFmOIsb9ei3o/9gUDk7vNNynCkDWp2Gk1ZnJVkp5veWfSE/e9ot2P3qJW4Sj56aa+alDi/Q44Ls+JlfAiLWAJN9vgHg+WM3HPtasP669/M3AH2hesMm64S9hmNUE+hSgbnjZCb212UOpb2Ob7y50UvmTxAcU3GJk22M15phIpVIeyiBCGmEnshaskS012c3ZdNaQcnaXRSaQ5AHsARupUmsklvPfW7rcFcZVpQWYWtga22z+sFp8uxWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGoJ0Gh1P4rkAFyRelNicd53EAmek7MvC6D73hiLduU=;
 b=3X8mnyyyvIY3fUAZ5ymkvXP8TGeN2fPA6VaJYwNCiCO8Nldwlg2s4tDUduoeMKB7GZIUoFe5ferP1W/zsOM1DxV0vbLF3rylfpMTvoU+ZyA4Sik5EVXohwaPvHErP3y1Oe6ygstz5hbhbqjJfGm9h3MbrvfjM/Rxk1JHBN+TFGs=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 15:15:53 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::d1fa:7115:639b:7ac8]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::d1fa:7115:639b:7ac8%5]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 15:15:53 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov
 function
Thread-Topic: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov
 function
Thread-Index: AQHX3J1tejNjhD04q0aFu2fssW4xvqwKK/AAgAWCZyA=
Date: Mon, 22 Nov 2021 15:15:52 +0000
Message-ID: <CH0PR12MB53726802A7062D634C61C993F49F9@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211118165737.27432-1-shaoyun.liu@amd.com>
 <CH0PR12MB53722603350F564FD70B512FF49C9@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53722603350F564FD70B512FF49C9@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-22T15:15:50Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=71b25f2d-c700-4f02-8767-d2fed4c560b3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e9f2f35-68ec-4a56-814b-08d9adcaf9bf
x-ms-traffictypediagnostic: CH0PR12MB5297:
x-microsoft-antispam-prvs: <CH0PR12MB5297332B782F875269E8277FF49F9@CH0PR12MB5297.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyuyzyYXsSvBtPaTzI17GQrtvOa7Tpjmi3JAwH0dD4ErZDYrY4vSHwecOa4cGvRaipjtMboaOj0K8GkBqSmpLSpbkTgVxCACFm76gpa4XFugvf2G1XcD5qyp/stBEEo+AY1QTAGfmp9acTTpnZ/opNP8gG/XV3yBclh5FVQD/ZI4Zmebqkep+lbcEcoECFLNe1Wg7m97xvI9SO+81hyd0pVr0jTD3vD3ogjKeFkim/e1F17a42TFEThTsOy4XyK/7PFpCS0n05PgCsudqZzXN+uddPcfVczXb3VSNVWYVsVmrPsf7XI7NNsrL2THmQFS6RdExSeipFsaPMIhDjr1W4uF2z+xjvcZD/SiR2gHCMp2xV+xrYPhft6Dq5yUV/GUWRxC7Kre9Iyno3jRHlp0BUAVeVUk8p5F+OlTsH4PedwWl3XQhj8XAsGmQnRjPiS2OIGzd8Lhla5LFE+Ss5nxZ4EMcJNmk+aCgHjJOkNF8gVsxo3/K5xeZJdcx3Ih6POjmMtZMHhTk7M/6a4qvPRhbht80Q/zrS1KEka4rOwPVzF8S3PFwowsXf/zfAIe8CaAU93/gz21JXoFuN+/i2jIKzKNYGkoveDAxAlWnv6pbScNRVXI2M+iAcz2PvSLsziYoOW0evSwQYKCBX6qgd4u0oBiyywqSTQV9G5GU65bn785HGTYsvf1nX/GIXHRn58YyGqU/TQYTnc7eeWF9AZhMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66946007)(186003)(71200400001)(6506007)(5660300002)(76116006)(66556008)(26005)(110136005)(122000001)(8936002)(83380400001)(9686003)(38070700005)(316002)(38100700002)(2906002)(33656002)(53546011)(52536014)(7696005)(8676002)(64756008)(66446008)(6636002)(508600001)(55016002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RQbeq7uuW6UiYMxtvz+h1afKy4eET6l5cjJyF1WHO5eip0qZGvR9aQ1jVG8s?=
 =?us-ascii?Q?fC4QPCvpyZX0CxD7BdVd9+6pWsMovqnuZ7P+TtqhS26lviNNR713bPYKEukO?=
 =?us-ascii?Q?SE/5Je05ATmIAsEIaG6V68Ky6CtO7dlIP8AAOtU8LPvabPsMFMC3X8xynbkU?=
 =?us-ascii?Q?FgSqH+ytxkNEMdK7m3Otwj92H2/vNgvGC399SI7XZmvprkTH0m7SAmUjXoBI?=
 =?us-ascii?Q?X33ISB18QgY5aWlaZNIDgm67G0tZ0KDeekXdlAMKiuz64zg0FTFi97vWFcD9?=
 =?us-ascii?Q?vJKpeyR+ki1JttJTUNcDtwSKDrzlP+Tzz3FT5gjzTF8gRaVXmNSdaVHPxXHq?=
 =?us-ascii?Q?CIhibY5/S/vpir6aQbWSZqz838b4MBLhX9KGwS+pg01MsFjNURKL2DchLUvY?=
 =?us-ascii?Q?YeNfUKv1d6pbaF4p04XQVLfIUuzzJn22eOsm2JwdUUe516rJPNpSBRxAElFA?=
 =?us-ascii?Q?K9fHXZ46kRDhOa+CvgaLVqbh2GC5NlSzqyvk1jcelGoQ29A4HAzXBZWGAPZG?=
 =?us-ascii?Q?zGMwA5UeVEdKUN/1B9+NtT6R03wrVg7l/l4pQXe7YJqqofJeuVMMIsaZhPZg?=
 =?us-ascii?Q?iAdZWBi89F/jDHDszQIDgMJZc1SqovmipxI2pzCISCVzKLvgy77fmsfnvpxB?=
 =?us-ascii?Q?XDf0ik09UcnZfTxt/qEwSqka+vptjyyXryaXtpxs85BjJn0nISm0nXGKSLZf?=
 =?us-ascii?Q?mCTo3gL11cb5zGV+/NapPg50OJwqNx4nUof3Ue1ncJg5WJK1YTsCXrGxc8ZN?=
 =?us-ascii?Q?/Qz5XB208y0voG2g7OzrhhnVVnIjRL0E4M7fN6E6LFhemOpiZ84O/Je8A6oC?=
 =?us-ascii?Q?QbA/o57JU2jwTXVhSpf+WWGMeKlsd308cpSxCnQkr5I/rZ3wbhLvHiADqLyw?=
 =?us-ascii?Q?gm6+cPLwL6RRIUpYa95fWN9hVcg31fdu6hPHivXvWo/tdpRgi/KR+66XsULH?=
 =?us-ascii?Q?bZaU4kY6ajmGUjpc/wpEw3L8v/qNoaC3jGZ6yL/Kg8yG/oxaD0I9RgSWdoa6?=
 =?us-ascii?Q?5chF0UV/RmJJ8Emw48cw5odKErQm2pK2ZqQB3nkid391G23osKYCq00Lt9t7?=
 =?us-ascii?Q?IcakJgRVifLET7ktej7lmjA7COGn1eOiAuMQABNhbKCAC3E4EOd/pSYbEUyn?=
 =?us-ascii?Q?EzYilqXesolJF310IIYdKksnWJjTCsSVrf6jEEyGqcBoMjVaGFBwr+cFU0Kq?=
 =?us-ascii?Q?RCZ788jZIR0ntQhyV8GIKFHEEAaGI64Xzi+TIJ7Czmt6wnQ5wn1LPA6H+OBo?=
 =?us-ascii?Q?9OaVzIB/XTmHELKQzKaVpnNfeqINAokP+pK87wPaqxbj4yRCHsQjn8QBs+4R?=
 =?us-ascii?Q?verzbBlm7fhayeDO253QYmcPqq3DumJG1q/t+BCf3LZt4MkvRg8s1/Pphq7C?=
 =?us-ascii?Q?CgOWA4BBHOcMQHBqF+YVoruIBw4UauuzXfszDj2SmP/D0XVKUiUUxR/VHYuu?=
 =?us-ascii?Q?jTGTvTxTbytBYCoWJ1ttRcNvY4B9s7a/QZMX2rQTLhx14pPedLVn6KqdgZ1A?=
 =?us-ascii?Q?Kz+rpiQ/KtLnxjX3ysBsdTnd2qvaZ4sHdAC4vcZFMg2g0dqEDUww8MjlI1RZ?=
 =?us-ascii?Q?AQVf6ivlmKrfZ87N+oaIVszIIxr/kacCr0kH3qV9Dt6XtQDIYlssXwL0hSyv?=
 =?us-ascii?Q?/QpN06v/whhatCsNbvBNcl4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9f2f35-68ec-4a56-814b-08d9adcaf9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 15:15:53.2969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMsyw0ErKSE8BdlDv1BnJPUjKgTZfhwbvnw38R0rxkA0GRtwNrzfkNTuht0/G+o1I15d9igLjf01uq3ww8anFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5297
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

ping

-----Original Message-----
From: Liu, Shaoyun=20
Sent: Thursday, November 18, 2021 10:08 PM
To: amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov=
 function

[AMD Official Use Only]

Ping=20

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>=20
Sent: Thursday, November 18, 2021 11:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov fun=
ction

For sriov XGMI  configuration, the host driver will handle the hive reset, =
so in guest side, the reset_sriov only be called once on one device. This w=
ill make kfd post_reset unblanced with kfd pre_reset since kfd pre_reset al=
ready been moved out of reset_sriov function. Move kfd post_reset out of re=
set_sriov function to make them balance .

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 10c8008d1da0..9a9d5493c676 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4308,7 +4308,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,
=20
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 	r =3D amdgpu_ib_ring_tests(adev);
-	amdgpu_amdkfd_post_reset(adev);
=20
 error:
 	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) { @@ =
-5081,7 +5080,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev=
,
=20
 	tmp_vram_lost_counter =3D atomic_read(&((adev)->vram_lost_counter));
 	/* Actual ASIC resets if needed.*/
-	/* TODO Implement XGMI hive reset logic for SRIOV */
+	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
 		r =3D amdgpu_device_reset_sriov(adev, job ? false : true);
 		if (r)
@@ -5141,8 +5140,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
=20
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-		/* unlock kfd: SRIOV would do it separately */
-		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
+		/* unlock kfd */
+		if (!need_emergency_restart)
 	                amdgpu_amdkfd_post_reset(tmp_adev);
=20
 		/* kfd_post_reset will do nothing if kfd device is not initialized,
--
2.17.1

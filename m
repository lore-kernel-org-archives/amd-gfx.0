Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1EBC5321E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Aug 2024 04:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB91F10E0D0;
	Mon, 26 Aug 2024 04:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b+NfmSMl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9B210E0D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Aug 2024 04:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5U8c3ltGTOcD5KLNkwNDa+r0HEFDqqqVczDyTLtFijQHGLzbpWgK6cFsaXqbBGaVfPOQbBhJHTHZDtvBlkIjQDbPzjR7UPkhSXynyzUUrQHEf2p4WB47N0gRx2rYh1H0wHHTPI92Jv3cWWBwyCkHV9+ZeKa/ieHDDwfCySPEUQftbuKyzhwI4bf+d6TT2JujJcdY4oyPVQqISLQKnVF5wx0Yzz4OMdkHJTN84B4GKxUzo9w1M7hjJ4D0BVVM8z9hi37ft6uF4LGQlYqtzeo02aPqyRXOXdoUW/O2eNQ9suArz0zTkVI52CWS3qldVuAP8LOwfWk9OA3Dy7W11PHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ypx8h9MUvl4IwnAoFnBf4CMEJz9TRs1Mal7Adu812s=;
 b=V9Lax3MMiCiopwHhxv4BmGx+R5xlxo76cHB2ti+ao+Tps29fXACkU6bkNRUPUqW4jOSTAjaBgabRwznk83+iLVnFCpEFKqBSTX6rf9B0u5x5dhFrL4+w1+yYS5uEahhG8wD8j5IwuI6Hwid+ecc3t8mSEx1wEAPzaiMgAxNjQ7ANCpuPKjknLMfYPB47BOoTstebywpZaIFGNI+ew/Hd7WaKtWqAmFEjuvoKdPe27onIerSZFHsAOu9sRTA9r8TUb6R7TBiTHEGxAmMM93nnBVul9j/8D7f8hn9tdPjII9kV4XJZ6nB54rk64M+Fo+6bAgpClHkU8ITBoPklGsnfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ypx8h9MUvl4IwnAoFnBf4CMEJz9TRs1Mal7Adu812s=;
 b=b+NfmSMlSHN60LFhVmZOQJnRTFZifY55Crv3/rppL/mNzJgrBPc4Mnz2k2kvHiWhuoQ4MMrA3oE0xBS9DoozlAVf++VKL6OdFHqeibUGpDnYZ86sY7KDP078V6HIhNrTIGEAcQwmneZFtVYJFERs3H8fMPDcOYc/MowlLE1xb7s=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 04:00:17 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%7]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 04:00:17 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: move drain_workqueue before shutdown is
 set
Thread-Topic: [PATCH] drm/amd/amdgpu: move drain_workqueue before shutdown is
 set
Thread-Index: AQHa92ttMq8q7X/2JkymNMMhrfsAuLI46gEw
Date: Mon, 26 Aug 2024 04:00:16 +0000
Message-ID: <CH2PR12MB4152E6812FDDACEBE7058203FE8B2@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240826035225.3382900-1-Victor.Zhao@amd.com>
In-Reply-To: <20240826035225.3382900-1-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c6298a90-87b5-40ec-9bcf-6bf6a817ccab;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-26T04:00:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|BL1PR12MB5851:EE_
x-ms-office365-filtering-correlation-id: 879bcf41-605a-4ae8-bde0-08dcc5839875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3Lc7W6/P9Vd0Fbj5rEFw5FOzl2bmgtJsEiKhwjBBebOfoFZqoBgEcl8eX6lT?=
 =?us-ascii?Q?QCO6edEMH+AePB//i2pDaRbUuLgNiIyZu+qXIEKoBEYbHQaqRTOlScWO+4mX?=
 =?us-ascii?Q?Od1m5rFNzPBMyfeqe5b9WaU6EdIKxnWOLMqdhYOBsIw13a9HozT621hyNaow?=
 =?us-ascii?Q?IcJdmiyndCNMpBG1rL0gPjOtLf0sTwJA0hnxXc/AfpJmvV6NC/I98Ls77pCJ?=
 =?us-ascii?Q?i72IOtSSkP+KUpjUwSV2E4pKU3uC2Y6gqYOIf0HUGLFh2R0JIWlRJ+3LlXOV?=
 =?us-ascii?Q?2tq5DdkdRRdSGVokv8z+3FQ8UngnfCiEzk1h9rhMIi5sUdT7/SUDyXuR84/3?=
 =?us-ascii?Q?YE6Q1fcSgF8NbRBQlHI5ZqDTktYtmdJEEU9SA+7W+tLROUIsp2zK3qJNsjar?=
 =?us-ascii?Q?vd3ZKl2+QMh+hmUUulsTJpfPf9Vog3jDNRH06r+JLkaHIFIvw67zJBhDSkUc?=
 =?us-ascii?Q?7cISqxabQy9H837ErwBSpOQ1Xv7Eh+ApmkCIzvhZI9YhebtyhsUuxbj7VW86?=
 =?us-ascii?Q?PAYdzIN4YAAXFi14kTMt+ctouBnBwRSolIRQJ9dAkm2G7ntnn0CTUlkkKQj9?=
 =?us-ascii?Q?a4zbPXnc479Ot7enoyLycc4g7fvYcd5LG/EzuV0QpkIr+R60523BwscdJPyn?=
 =?us-ascii?Q?CLh7sksT8djaUPXTLWHxQ00PQA7GoBDPe3Q1uSI17VUftHdaCzmXDexQmWnS?=
 =?us-ascii?Q?ZAjrgHBqJpDCe6xhx/FfKtuPCAvE2cuVg40Qra+MF2uZ420EbDS4BOHgHNMU?=
 =?us-ascii?Q?Qe8GqgWzGF1/1pE47s7CrvuviXrhe99OqNvxwh6cLOw8akuBJ8NN0wyMJIGf?=
 =?us-ascii?Q?DVLtmCNeU1IaAIh0EGFVKE54eadEyJUV4QMmDjD27mFfBB7PiwoCjjkLEdmW?=
 =?us-ascii?Q?46tmpocr6nGSTps7X6JK9ByjpORoTB/aZe7vQ1aVIQiqzhTeKOlBXREEqEno?=
 =?us-ascii?Q?6t3MG1g7nHrMCY2STcp3SfcHfq5bGnJvdb8W+L3oY/CFP65LXAtkfFIQbAcm?=
 =?us-ascii?Q?h2PyrtObnkzO8/KP1MIzC3czODBd8DApFpVAXnVqWxZNDCwUg59+rWdA7za8?=
 =?us-ascii?Q?KE9Qc2pJTbM/o4/1ViuHw3arFprdFYPksJXUtPrEOlXxPwNQ5wJp+nBuVz/G?=
 =?us-ascii?Q?KNVACobDPkjBXjJG/z4GvFY6UdORlXAEdPxJtw4xL3evpJlfaKA8MHJsRpR1?=
 =?us-ascii?Q?PrF+dRRcNXSbFaxjWjtWpWPEtxXM8pZ0+67CEInEHrxD8VlAqDz3PDEsm7E4?=
 =?us-ascii?Q?EeLc+KXK0fS52fHW5LOJuMSp5CBBK+0pqn98fCs8VIrgiRIhwaWCR1cYKzTh?=
 =?us-ascii?Q?1qopqg2CiJ3zRcQIy/rbgMobpoNMBwh+IMDaN2ppkDhLWQVvvH/Z+h6KbScg?=
 =?us-ascii?Q?ey0l0z4dAxpfLNEP1EV/UpvQUJBrARJZqK/OulP5DRh62Uj1cQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/CpPfiq5Opv818Zcd4FVTuEhzAt/prxgmaeGb1kEbBQN1tAXMz3DHlttPny?=
 =?us-ascii?Q?maIJjB0sl7sY39RL3qlzUvkQBegKc+XDkh23idgCb3nue/kbf3gCR/K7Kzyj?=
 =?us-ascii?Q?kevxfPVs4bVhoKdP+pFAExNvCoZYCu/0rBmUDUb3YamWsnS6ZUBoUR5OPem8?=
 =?us-ascii?Q?toAFVQtXqyNGsGjNmyduU3+/d8+dbpALeZLQiy6rPh7NLgIzk+y66ZotItNq?=
 =?us-ascii?Q?cZt361/poPQbgMjnREvg4TumfoaodN0bL1NqU+dpRYaC6fYIV2P6fcSnO7xU?=
 =?us-ascii?Q?eswkRTgO/dSe7jLNQi2v1ru9jeRG0cPXtUbQ9y1+ckrpcYRup1kWZRCS732I?=
 =?us-ascii?Q?K2c9XntBGyd4yL0zimtz2qjMI78CTZ3UWCVeBN1/nysGd6bOuei1YYjYA1fn?=
 =?us-ascii?Q?LCC7Y7lOixVHq0sS93OftIfi1SeEYwHAPv++awau6699YBnvaCp6enr0zekx?=
 =?us-ascii?Q?dEhgZA2ERk2IYxDfOkQjudrty0RlLpG+97xeOSpqxGn2K4vOOqyCWmAq49g5?=
 =?us-ascii?Q?zkN/xR3SiA86bHfiHL0AhW8xOX+sVP5B/4xJapkoqPhpvn3yVWJp6AOIe/jX?=
 =?us-ascii?Q?MfFxh6CmMuvdapPgUN3t32jXHyYj9/Wwy5e32XKtr4ezrWWoXbMPvaDz428G?=
 =?us-ascii?Q?KFcDNAAIZX9BR/uPWShWNkl8/WTOvQ3j2KtdE4jxbs4/BbQLdXWK5o3MN/86?=
 =?us-ascii?Q?y3reA9hfwjN5L3+BleQSjLS3EiAaZyPP2J1Sp37J7WI8tZdCRgea7MwbyaVP?=
 =?us-ascii?Q?VoCDuBaAZUXWCq8ivA1Gn3eJYZaB5wwK9qIZLOugzrwS7MIOH4Lw/xZll4kU?=
 =?us-ascii?Q?XTH3/pmert9wqsPqAHbcNjQ7TxrvX90++2TlASw6Efh42ZlCDmxu5qbn2sBW?=
 =?us-ascii?Q?Tqk98em0/zxzo0hGzkbH+wJ+/mSbWDRRrAp+B1yXE5hCQEoGKF3dC1tNoNAs?=
 =?us-ascii?Q?nNajZYrnXejCfqXUcR2tLkt3BWxv+H1etYCzvUQD4JmUwL25wNzdfi0aERol?=
 =?us-ascii?Q?DY1wadrjdIdZ3BlZekr/8ATJbczEwCPB1vIU1uNcCDIcz/0Ws92lJKFwnmWK?=
 =?us-ascii?Q?gqMbmiXmBa4tpo1JGo33mlUjwgVb80ZJUmh4pZUJOfuup/+0GRKBkqy3XflO?=
 =?us-ascii?Q?CXz6TCXFco4bm5RwsFal7AY0z9+1hmnqX9yPns0hiy6P06Mb1EnOkuCZulL0?=
 =?us-ascii?Q?LeQoTotgsFio/S8Q4PgvBG3unYrKIQvGGnrMMjRdwpaIm6Zfk7Yw3+l9GLuX?=
 =?us-ascii?Q?0ZOmT3/TtqyNPFfFgvUJ7U5txyMTlyhHd6U55orhCFvAgl5cvS+QfBMaMaLg?=
 =?us-ascii?Q?41wgtQVsAxTHf62VXRud5pyL/ryUKYltpXvtazd1opAXi3dUxZSYjyWxS4nf?=
 =?us-ascii?Q?/EX+EDHtTP4uJA6sIZdv/pHckM6pSjv4Vzrvjg0+KkkNTchjDlkcso7eHnFT?=
 =?us-ascii?Q?WJLHVko6cMojO2tDV1LrxHtuQ0pLGsntjW9ZWcNmyQkzCH0THbXygCotEZUw?=
 =?us-ascii?Q?NOK+yyy/TfKrZQT/4XSNFHse/6tIT8LfHXJgVJS+VCq2Ony399ZwwxS6gze6?=
 =?us-ascii?Q?KtxpnzJn7nNB7kgzItU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879bcf41-605a-4ae8-bde0-08dcc5839875
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 04:00:16.8578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnI9Z5GDVcyHgM92wz51uh4dCFDuwVPA5wmYeiInPrvFzxqB11K16JI9wXyj5xts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor Z=
hao
Sent: Monday, August 26, 2024 11:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amd/amdgpu: move drain_workqueue before shutdown is se=
t

[background] when unloading amdgpu driver right after running a workload, d=
rain_workqueue is causing "Fence fallback timer expired on ring sdma0.0". U=
nder sriov, this issue will cause sriov full access timeout and a reset hap=
pening.

move drain_workqueue before shutdown is set to allow ih process and before =
enter full access under sriov to avoid full access time cost.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index da06705f0026..f06e1f408f20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4531,6 +4531,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)  {
        dev_info(adev->dev, "amdgpu: finishing device.\n");
        flush_delayed_work(&adev->delayed_init_work);
+
+       if (adev->mman.initialized)
+               drain_workqueue(adev->mman.bdev.wq);
        adev->shutdown =3D true;

        /* make sure IB test finished before entering exclusive mode @@ -45=
51,9 +4554,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
        }
        amdgpu_fence_driver_hw_fini(adev);

-       if (adev->mman.initialized)
-               drain_workqueue(adev->mman.bdev.wq);
-
        if (adev->pm.sysfs_initialized)
                amdgpu_pm_sysfs_fini(adev);
        if (adev->ucode_sysfs_en)
--
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93996CCD185
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 05:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4A610E07B;
	Mon, 13 Oct 2025 05:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NsdIuGIv";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D4B10E07B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 05:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itNIbaMZUNWkg+neeoYsaBNTqzRSdYkPuxnNe+JH1+In59NliaXDFWPT1LLl7Vo4qc6ysdm0tsZ2cG5hSFFO8jwYkHRFF/4ukC0wC8fC6P9pWuToCsoSsv/QT2m32LW4VptIl2Rzpvr2jmb5AY6GKA5J7hEx+XErAP5eQzEkl14c4B+1JADWyRhewQixA39qp/k2NqcWC3gIXhlRUYFk8KRhdWHiz3ILrXnGhcQNHi0BWPeksGoYzvssmjnrlz/Gb+O+F1bROpIpXhwvcLHkLAXbIGAyIfGuC8ah8lBvH+QMzOaUeAQlgNz4MAbZ7VDlkCfJEPjnjy67Z6HGU/AsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4vPfLSWfho6UXz3OiHvhrXS0GyH12/Bsg9brN6jkt0=;
 b=ln4VeWoXqmPebpZueQllcMr38Acl7hPwxYbF02SmsX8G32oIYr5ok6Q5PRKn9xy8Wf/wuRT3dHt/gW/faI1H512gUYhkloorKIODsY0NydnUXYTAsTmxWW0KNajdm9LTLLh8QeEmGFRzgrD19Jy1yx1dtYwgeuuBZAfP13eMzYcKsMTi1Ar9jGcnPpa9iRuPNSNDZoT37ZW2RvijWEAFf92Rn+U2YliPxGoMdO7Mdyxi/2tPLfuKVctqntgNpgHU2JO2VWD2/A8x6Ed5f7q0hA1jEd7BDpTCttYoMyG686f5JtW0X5BSInPh4dDONgxteHoqTXjGwymI12zvgcxbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4vPfLSWfho6UXz3OiHvhrXS0GyH12/Bsg9brN6jkt0=;
 b=NsdIuGIv23rGHMol5JlhWHR6jlLtGbWcCDbB7OgFjMc7f3JUXYfSdrowAo7FHsp6T6fkw75skUM1c9i6yZcI5Nujpy2ML6h/RILlYCqg0RIA6JZi/vvIWs2g8VdJB48zL96uOtd3uNxFq7KL1I+p8Frw6GUPWCdLvqhJ69/vykQ=
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 05:14:15 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 05:14:15 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>
Subject: RE: [PATCH v3 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
 during VF init
Thread-Topic: [PATCH v3 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
 during VF init
Thread-Index: AQHcOhaN2LcPcOSCbEOSXZFhc8QP77S/iHBw
Date: Mon, 13 Oct 2025 05:14:14 +0000
Message-ID: <PH7PR12MB782057D8B015A2BB6BF1905797EAA@PH7PR12MB7820.namprd12.prod.outlook.com>
References: <20251010184849.9701-1-yunru.pan@amd.com>
 <20251010184849.9701-3-yunru.pan@amd.com>
In-Reply-To: <20251010184849.9701-3-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T05:00:44.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7820:EE_|IA0PR12MB9010:EE_
x-ms-office365-filtering-correlation-id: ebddb333-ff98-460d-d5fa-08de0a175a39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kIESqsU+EA/LrUiDaONigAwJGiyJGF7XQuDOflFZfLaUpnBRYT4WhZwF6B9+?=
 =?us-ascii?Q?gDIl6rTAOpxVGf8kqDj7IJ/ggq7Wbp7fmZwPXFC+fBe//l+7Ys4RVrF+XAkN?=
 =?us-ascii?Q?SklYO9SLlqNf+hq5ufVL+yOjFclTKDiMQnWfKGQVpT8X5sBlGPNY5sMBkhF/?=
 =?us-ascii?Q?7IcqCr+zskgU4SqkHfy8/Wamb6UdoNee95MhhB2iGwdWmPruB7OQwoR+YS5I?=
 =?us-ascii?Q?T3sQrNjufP5lIuUj2QQSPpnJJmPcx1NYqDZU3eYDo9gTxlZm6rLbVhqx86Cn?=
 =?us-ascii?Q?E9Zwh0lmaWp9EAP6QlH0qqhHF8e7p5EQK3MmADxq/6OlkD0bGOs1ROkVqMFx?=
 =?us-ascii?Q?ANMSXvdirOKnmTWUvCr3pYwRMf4CUAqmHU6BooruuRzz0g99Zkd7KZOhU+0w?=
 =?us-ascii?Q?I6fGV2CS3eQQCow0jFjoixDSL/dLro9zGDa+gx4Ln6uXBR46ZbniyA7qIZhT?=
 =?us-ascii?Q?NJew6pRNTi3l/YJ1Arke7lgWs4o+LPKMnZEaBrN9ODwS50MJ5SVKeKJM8fsF?=
 =?us-ascii?Q?sumSTTA421DsLOkvtGkr/SSrRGJkHgSH08Go/E7WOCxQyPe9DurzmQO2a59t?=
 =?us-ascii?Q?deFOjDFU6Yer/DB4IiAD38AVA1s6hPixdb3Jq8MXclIg5JAOGPn2MWCYul5m?=
 =?us-ascii?Q?S9pzsex0WCsp+05IsEbsidJTtwTfPuGPXfCdjXMhSrkpEDUFlGnjoeC2rPKW?=
 =?us-ascii?Q?oqISmJh/CsL0G9KOnK5LXTrukFtK+Zlhnysb04Hr0RgSecE53EKVUULYE7/b?=
 =?us-ascii?Q?rF30//vRFvmYyKPSI1+NW+S2tvtBKcY9oCkm+2UtJ5bQoKtTzo0UMzgy7Dqo?=
 =?us-ascii?Q?LzsS8YxDmIVpLxt4Ezd7v/vTwRIKyBkQ+PckYJ3HrbxcxTVadn+f5WbtFopU?=
 =?us-ascii?Q?RGJ1m43t808h2iyxDoporJIG7vKeNt394DJ1zOszlg6sj3P4tIEmaHOOe5da?=
 =?us-ascii?Q?LwmTQ9MsMnrhY5ZZfS1QhV/rYVr24IBo9nhVvlg502GhZTnNqCXDn5CqO6JL?=
 =?us-ascii?Q?PgME91lB6xfEK1KLT5BYc4RGcDcAtp2+hUO97kFaV890m+ftlKYn1fw1yGzi?=
 =?us-ascii?Q?9sh14/6CsdzwhXcPGJMLO8hcs2xlVkVSe2VVZqcKm18yl6nDjTD7xuZs9s7C?=
 =?us-ascii?Q?zKejAfEf/taRS8IdU1iXgMbdEIjd+Mp7xXAEczrxonVnwAZ4POy+wNsaYbU4?=
 =?us-ascii?Q?ro+Yc3imbImKY4x8GGHsevcDxCUAC54b8subSHZ14k6hAEnswLzq47DoQlmS?=
 =?us-ascii?Q?d87DNldD787o3CuL5HaS4wjD5Dvs/8wbLxamEpuiYEyL0n8jkMsm2OhTYTu7?=
 =?us-ascii?Q?ii800qnb6yxChUXd2iUcKkXQYiuAFAl0IhaoFJ6Zmlfs8K8rYPZd+cvZb+m5?=
 =?us-ascii?Q?ijL2NmIJ6FsX/fCdVQtaBNbGqT6gMu274iBW99SaCdkuFOEbba51xTREy3wl?=
 =?us-ascii?Q?i9YjlpTVzPnsYncSzMEUD+MwOxkhRyrrwktnM8OvrUkhFqBaH8i4kjWL6Lz4?=
 =?us-ascii?Q?EayknIVfQ68MbZv8LKYqjzP5SOKRgtwBD2i1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PIkiA3s3fk+w0g6MJMci3nEBJaXba7thGigPZT0onUnmqFx9/uAUpCLb0Ixg?=
 =?us-ascii?Q?G2v8pEbF9eeZXJksL9pYySE9nu46Vy97nqI7HfM64tCvo5JdzALq6IkERE/x?=
 =?us-ascii?Q?DVMuV4bs6Cqk+D/XeeFpnX/TxoXdXA+SF1wRzNQGEsq8KTrESHmnthSHb302?=
 =?us-ascii?Q?vN+gqQSYX18UZzzsN0J3o1cb3MFHJS4tUjwh1ceU2anfSqDaEi6ZlHPCpLy7?=
 =?us-ascii?Q?pscnfnbtGSBRW6bpDbZTIoAWyeJk/+clExen69Zolyn5kIN/OSg/D9Zkv0G3?=
 =?us-ascii?Q?sM2PI8k3NMBydWmHu3bNjxZPSYqOM2W58jJ3sEc5I2Qex3U66akg0QrV7vMa?=
 =?us-ascii?Q?ufyRhBP7YaOqntodPLP4+KV1M2CL10c9D/XLqoUWpSPtk4d7YRRYLdovsi5o?=
 =?us-ascii?Q?oCCOrlQBy6/PzE6P0JEo/S4wZ1kWEKHfjl4azRkcHxcI2hBTTfaH5fcUSKmJ?=
 =?us-ascii?Q?9Cj4hGjAO0Ez/IpN3Dbx4ygaA5qex0mGuCnZRSjX9CZJW7IEAgLUqKST0zda?=
 =?us-ascii?Q?JSwR7dOezhaiveFdBojv5GqpBP++JOupDVSD1mMd8O2+fR+5/uMwscZ0e/08?=
 =?us-ascii?Q?3n3e/MKKK9kNDCtKpUTypJu/kbgBmc3Y41ap7um3dObBJbPIWzNef1q2uXlI?=
 =?us-ascii?Q?RQ+OnstR2uFopKWWVRWASSUjbrs4MVPi+dkx/N2wHx7pf4JKHNZGidA1oefS?=
 =?us-ascii?Q?KEzmeT8Nleo4z6VGNd2rSXhuwXGHS6WqDWPifYY39lQ1dH77M4ba29hI+8R/?=
 =?us-ascii?Q?DabPcrfLarB4qfRpylbFMvO9Nf+IjsOQOL2CNO21HpY180HNoIG3oEoWdDKO?=
 =?us-ascii?Q?/uwAq2zwbuxsHhuBDg/iFHZxqgs0H8p/577cJ3SBpxItZB6isSQRKM3J68tf?=
 =?us-ascii?Q?uIECcb5TtQCA982R8DJ+K8CA98XlTBLKOkb2sli8+h8+OX288tnLiOPe+dD8?=
 =?us-ascii?Q?QQrnI+ZfB5KZgKJ0bY2gfDM3fn/FTTPJ1kSeFHjN54TX+mAVVdSQsFfQxkve?=
 =?us-ascii?Q?wNH6QDWduR9aQVEFlRvecPknh9CLeP72EUVrsd1Y3OisscHeH3Smquc0bX6R?=
 =?us-ascii?Q?NsyPHSkqA3nfi4yOxUvz3CvswK38VbDTyk6V1pqLR1k4eL+TFBXBSht/aynj?=
 =?us-ascii?Q?TYicQR47WCt/kJDAuO19BI10IPyWz1VEBGljPT4N85CRw2w+pR2YQDRVor2O?=
 =?us-ascii?Q?2CCLnYkWV5Lds7Rt448lgoU7tAMkn11qizlISRpjxTtaD0GeGMEFi9TIffVN?=
 =?us-ascii?Q?SvwQQhLoGqhhO/7IdehSgMJrNVtK/wYRhG/DNS5Ul7bqirqxatSeTF0Vbhwj?=
 =?us-ascii?Q?W8MdYDqkP0A7CRbvEXDWgRrntvwMCH2uHuvQxRgCyhi3DnqPLhAJamAJIvyl?=
 =?us-ascii?Q?u33MgDc2OFeZKLtyodYErI7yFbtNl9WMz/B7GI5PLAk3dLySeo3qGozzJGBh?=
 =?us-ascii?Q?xpoUP4OAXY/3qNy6rT1y2pMEGWRX02mxWh0wmAQKiiW6iS3PS3Zi5GCtkSeA?=
 =?us-ascii?Q?ISORekbEZ/AUNswjd/fDsdl0/yvFBzVVF2tPGSbDMH0Fh3//FeUeGkJEZE0k?=
 =?us-ascii?Q?OyK3Q2mKBhNDw/esurE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebddb333-ff98-460d-d5fa-08de0a175a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 05:14:14.6936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xd4SYE2WVJtfvAM8EpYHphLEl49yLcbySvVzdw1tLuv0cU6492iIjF29s3mREHMG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010
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

[Public]

>-----Original Message-----
>From: Pan, Ellen <Yunru.Pan@amd.com>
>Sent: Saturday, October 11, 2025 12:19 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chan, Hing
>Pong <Jeffrey.Chan@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
>Subject: [PATCH v3 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
>during VF init
>
>    1. Introduced amdgpu_virt_init_critical_region during VF init.
>     - VFs use init_data_header_offset and init_data_header_size_kb
>            transmitted via PF2VF mailbox to fetch the offset of
>            critical regions' offsets/sizes in VRAM and save to
>            adev->virt.crit_region_offsets and adev->virt.crit_region_size=
s_kb.
>
>Signed-off-by: Ellen Pan <yunru.pan@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 113
>++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |   7 ++
> drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++++
> 4 files changed, 155 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 929936c8d87c..351cfe03a1aa 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -2754,6 +2754,10 @@ static int amdgpu_device_ip_early_init(struct
>amdgpu_device *adev)
>               r =3D amdgpu_virt_request_full_gpu(adev, true);
>               if (r)
>                       return r;
>+
>+              r =3D amdgpu_virt_init_critical_region(adev);
>+              if (r)
>+                      return r;
>       }
>
>       switch (adev->asic_type) {
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>index 3a6b0e1084d7..6eca5e8a7375 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>@@ -843,6 +843,119 @@ static void amdgpu_virt_init_ras(struct
>amdgpu_device *adev)
>       adev->virt.ras.cper_rptr =3D 0;
> }
>
>+static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t
>+*buf_start, uint8_t *buf_end) {
>+      uint32_t sum =3D 0;
>+
>+      if (buf_start >=3D buf_end)
>+              return 0;
>+
>+      for (; buf_start < buf_end; buf_start++)
>+              sum +=3D buf_start[0];
>+
>+      return 0xffffffff - sum;
>+}
>+
>+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev) {
>+      struct amd_sriov_msg_init_data_header *init_data_hdr =3D NULL;
>+      uint32_t init_hdr_offset =3D adev->virt.init_data_header.offset;
>+      uint32_t init_hdr_size =3D adev->virt.init_data_header.size_kb << 1=
0;
>+      uint64_t pos =3D 0;
[lijo]
This variable is not required. Seems it's always reading from init_hdr_offs=
et.

>+      uint64_t vram_size;
>+      int r =3D 0;
>+      uint8_t checksum =3D 0;
>+
>+      /* Skip below init if critical region version !=3D v2 */
>+      if (adev->virt.req_init_data_ver !=3D GPU_CRIT_REGION_V2)
>+              return 0;
>+
>+      if (init_hdr_offset < 0) {
>+              dev_err(adev->dev, "Invalid init header offset\n");
>+              return -EINVAL;
>+      }
>+
>+      vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE);
>+      if (!vram_size || vram_size =3D=3D U32_MAX)
>+              return -EINVAL;
>+      vram_size <<=3D 20;
>+
>+      if ((init_hdr_offset + init_hdr_size) > vram_size) {
>+              dev_err(adev->dev, "init_data_header exceeds VRAM size,
>exiting\n");
>+              return -EINVAL;
>+      }
>+
>+      /* Allocate for init_data_hdr */
>+      init_data_hdr =3D kzalloc(sizeof(struct
>amd_sriov_msg_init_data_header), GFP_KERNEL);
>+      if (!init_data_hdr)
>+              return -ENOMEM;
>+
>+      pos =3D (uint64_t)init_hdr_offset;
>+      amdgpu_device_vram_access(adev, pos, (uint32_t *)init_data_hdr,
>+                                      sizeof(struct
>amd_sriov_msg_init_data_header), false);
>+
>+      switch (init_data_hdr->version) {
>+      case GPU_CRIT_REGION_V2:
[lijo]
There is already a version check at the beginning of this function.

>+              if (strncmp(init_data_hdr->signature, "INDA", 4) !=3D 0) {
[lijo]

Suggest keeping this signature as a #define

>+                      dev_err(adev->dev, "Invalid init data signature:
>%.4s\n",
>+                                      init_data_hdr->signature);
>+                      r =3D -EINVAL;
>+                      goto out;
>+              }
>+
>+              checksum =3D amdgpu_virt_crit_region_calc_checksum(
>+                              (uint8_t *)&init_data_hdr->initdata_offset,
>+                              (uint8_t *)init_data_hdr +
>+                              sizeof(struct
>amd_sriov_msg_init_data_header));
>+              if (checksum !=3D init_data_hdr->checksum) {
>+                      dev_err(adev->dev, "Found unmatching checksum
>from calculation 0x%x and init_data 0x%x\n",
>+                                      checksum, init_data_hdr->checksum);
>+                      r =3D -EINVAL;
>+                      goto out;
>+              }
>+
>+              /* Initialize critical region offsets */
>+              adev->virt.crit_regn.offset =3D init_data_hdr->initdata_off=
set;
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =3D
>+                      init_data_hdr->ip_discovery_offset;
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =3D
>+                      init_data_hdr->vbios_img_offset;
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =3D
>+                      init_data_hdr->ras_tele_info_offset;
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =3D
>+                      init_data_hdr->dataexchange_offset;
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =3D
>+                      init_data_hdr->bad_page_info_offset;
>+
>+              /* Initialize critical region sizes */
>+              adev->virt.crit_regn.size_kb =3D init_data_hdr-
>>initdata_size_in_kb;
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =3D
>+                      init_data_hdr->ip_discovery_size_in_kb;
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =3D
>+                      init_data_hdr->vbios_img_size_in_kb;
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =3D
>+                      init_data_hdr->ras_tele_info_size_in_kb;
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =3D
>+                      init_data_hdr->dataexchange_size_in_kb;
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =3D
>+                      init_data_hdr->bad_page_size_in_kb;
>+
>+              adev->virt.is_dynamic_crit_regn_enabled =3D true;
>+              break;
>+      default:
>+              dev_err(adev->dev, "Invalid init header version: %u\n",
>+                              init_data_hdr->version);
>+              r =3D -EINVAL;
>+              goto out;
>+      }
>+
>+out:
>+      kfree(init_data_hdr);
>+      init_data_hdr =3D NULL;
>+
>+      return r;
>+}
>+
> void amdgpu_virt_init(struct amdgpu_device *adev)  {
>       bool is_sriov =3D false;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>index 36247a160aa6..f46edc03f57f 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>@@ -52,6 +52,8 @@
> /* tonga/fiji use this offset */
> #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
>
>+#define mmRCC_CONFIG_MEMSIZE  0xde3
[lijo]

Alex already commented about this. Keeping this here will pollute other fil=
es where amdgpu_virt.h is included and the real definition.

Thanks,
Lijo

>+
> #define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
>
> enum amdgpu_sriov_vf_mode {
>@@ -296,6 +298,9 @@ struct amdgpu_virt {
>
>       /* dynamic(v2) critical regions */
>       struct amdgpu_virt_region init_data_header;
>+      struct amdgpu_virt_region crit_regn;
>+      struct amdgpu_virt_region
>crit_regn_tbl[AMD_SRIOV_MSG_MAX_TABLE_ID];
>+      bool is_dynamic_crit_regn_enabled;
>
>       /* vf2pf message */
>       struct delayed_work vf2pf_work;
>@@ -432,6 +437,8 @@ void amdgpu_virt_exchange_data(struct
>amdgpu_device *adev);  void amdgpu_virt_fini_data_exchange(struct
>amdgpu_device *adev);  void amdgpu_virt_init(struct amdgpu_device *adev);
>
>+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
>+
> bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int
>amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);  void
>amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev); diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>index b53caab5b706..d15c256f9abd 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>@@ -70,6 +70,37 @@ enum amd_sriov_crit_region_version {
>       GPU_CRIT_REGION_V2 =3D 2,
> };
>
>+/* v2 layout offset enum (in order of allocation) */ enum
>+amd_sriov_msg_table_id_enum {
>+      AMD_SRIOV_MSG_IPD_TABLE_ID =3D 0,
>+      AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
>+      AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
>+      AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
>+      AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
>+      AMD_SRIOV_MSG_INITD_H_TABLE_ID,
>+      AMD_SRIOV_MSG_MAX_TABLE_ID,
>+};
>+
>+struct amd_sriov_msg_init_data_header {
>+      char     signature[4];  /* "INDA"  */
>+      uint32_t version;
>+      uint32_t checksum;
>+      uint32_t initdata_offset; /* 0 */
>+      uint32_t initdata_size_in_kb; /* 5MB */
>+      uint32_t valid_tables;
>+      uint32_t vbios_img_offset;
>+      uint32_t vbios_img_size_in_kb;
>+      uint32_t dataexchange_offset;
>+      uint32_t dataexchange_size_in_kb;
>+      uint32_t ras_tele_info_offset;
>+      uint32_t ras_tele_info_size_in_kb;
>+      uint32_t ip_discovery_offset;
>+      uint32_t ip_discovery_size_in_kb;
>+      uint32_t bad_page_info_offset;
>+      uint32_t bad_page_size_in_kb;
>+      uint32_t reserved[8];
>+};
>+
> /*
>  * PF2VF history log:
>  * v1 defined in amdgim
>--
>2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ADEC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 10:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0716F10E0C4;
	Thu,  1 Aug 2024 10:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UjpgkhGL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B494E10E0C4
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 10:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKF26XEhFKXeokvECWN2sLsyW6pSIAoi+qLDJR1rhBgTywfoNMIgPp7QFdvYly5SbhWqfzeYKQr0ca4fd2Q2pRcUt1t6wFXDTXbM5h4CnZzzaVWFLM3vQ0OMdjzg7E0r5qG8iacFvqpb7v6ZiPvj3sjOnA9Tk6F+qG3bsRxZJ4LcDftRK0c5SIXurTMl4xvV6SoSTk/yn8jIrXlVEFYkzQBlb96fSV36Gdw8AkvVeD+F8k9eiu71Ux2UJMhFv69Fd069VEby8WQsCf6czxtJXBhWjUIO5bpJqcLyqamBa2DR4iNziAj8K7LsZmELyagKXDCX+lE4IJENAzhMvapvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4R5MUqUsEGS4m2WmmgRQbIrEgEmfsGd9R91+1hi+CMo=;
 b=EElYZFEJB6GvLnL2JqC2TweEU0N4BAK8UKjBNHKiqUTi+otBCO+gD2W3kY1mq+4PZsN/DNMcu8mL6GzQymUs6C4dY15Cmqh7zj2XNkZBw6qyR0lzowr1Ltfa0k0nPcsnld68+rmTWNENdGzW98NAJvPDZBBq4pNiSfFiNPBvp+15qnVpvlhlM1T5sXkxSzbI5wwaV+fGzfHzb7dY2QWXhK41FGGCRS1fURJF83J2pyFkRwRT7oEvTv0BUrkyy5lpTxHLsV8kCDH/IjjE2Imtv4u7QDLBeBM8tNUd6e2YgvBOdVuiZSw37g0njXR0jQZjd1/4TA2ZlGmlLEFh8RwBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R5MUqUsEGS4m2WmmgRQbIrEgEmfsGd9R91+1hi+CMo=;
 b=UjpgkhGLSxjP7+GAd9e+CIBA3fquvkRJcobZJkE13Xwa2EDWxrk+5ciEuDejY4xf7ZA3rK5ScaNaztBw1Bch+MtnS2MpJdWe2b4xPieiq8oacUgylfzaTBdX9cQv+IXUM8oj/c6LhXM+WOLAPXuvnc8vfDUyB7rjgc3ZxvLFIRQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 10:30:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 10:30:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: report bad status in GPU recovery
Thread-Topic: [PATCH 3/3] drm/amdgpu: report bad status in GPU recovery
Thread-Index: AQHa4/mfeHser1IoZUG6c66g95rcubISMwjQ
Date: Thu, 1 Aug 2024 10:30:26 +0000
Message-ID: <BN9PR12MB5257B63D130A4FDDE4C7354FFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240801095953.35625-1-tao.zhou1@amd.com>
 <20240801095953.35625-3-tao.zhou1@amd.com>
In-Reply-To: <20240801095953.35625-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=61a6d282-dcc7-4047-9a3c-7d63c0b5ea7e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T10:28:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CYYPR12MB8752:EE_
x-ms-office365-filtering-correlation-id: b22aead3-c966-44cb-da9d-08dcb214f55e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?E427s0/QcJcpj86i18u+U14ZMmpd/TSU6VtTNrHn0R2YguGbrRJuR+pTf5nE?=
 =?us-ascii?Q?QK1cqzCePetT3w4X+fn/TpecxfY4CxfdGhA648KkEcxswj/po8CiELzoaly9?=
 =?us-ascii?Q?sqfi8lTCkPixd4FIc+SoENbZvvT+2yWUb69N+S7D2SL8O5Iv9wxwCQ9bORqf?=
 =?us-ascii?Q?sJy/v+FDf+lcDwEjH8s82HidEUSQFJo2cznTa0V/rJytFgbN7NDZ7cow7qAL?=
 =?us-ascii?Q?+2Fd20Fy1IzITpXJlRoGIaTyIpw/s/DpUA7CBoWJp4JwR6MAMIELpdomnjOY?=
 =?us-ascii?Q?JbroN0h5gUb8b7F43rxSTyQxkWBRMGVjQmOZKhT/ErBjRymx8Nm6xpvmq0Mf?=
 =?us-ascii?Q?rHRj30nVm5dFM9lVtiW5F42beJLs3pUGl0pvnpIIbZCnwLcIpNX86UhASnP9?=
 =?us-ascii?Q?sqJEQacVF3xwUsVMSAgGjsPQDDC+iFg4c0nrciJRwKjaGLcTllTCQB8rPzfQ?=
 =?us-ascii?Q?Xby/LyMJJs5W16yG9tU7a6IzNGxgytSRDr7aWkVnFXjJGvMoikf5AuMt69f8?=
 =?us-ascii?Q?BWhPgdC86xEH2N0ioC4XU6GNiAc8LkF37RkFCCocstCDPYw6yWbX0E2CwTkt?=
 =?us-ascii?Q?hYokex4jQr/4E3pnCmbPDn2Xz4z29ZdCLy57X8zVMoNaAAWbZRniFJqs73wX?=
 =?us-ascii?Q?DrCIp7Ja878mqhYWwRlgvJasAsWYPozTxHXN7LoNunDPNFRaI80QzqoywDOv?=
 =?us-ascii?Q?351NQk4fmoOjNDm/SMThydIwXN7+wwXiKyQUfIjVuIZrxzSXe6GSy8suQBze?=
 =?us-ascii?Q?umpoO7gI126XD88sDZmlFh7qbW5b9hOcD+HID3OFPPa4O3XgYJp2A6pCy2u8?=
 =?us-ascii?Q?qitYlOE7sAcrNMU4GeobhgiBEYzcAZPvGRStgHS8XG2PJkmYHz44isEH6b7I?=
 =?us-ascii?Q?SOOzYG6KbJxTRQPhYrIGq1OanoI9WJnY1bGIcDIZLKRhqsTH3LbKeqZIU/zB?=
 =?us-ascii?Q?MmVBOH6KqCpLIYjK8QItd0o1uJBR/MKL48Tn9BXGB5PZKN8fhyoKscoIuqx2?=
 =?us-ascii?Q?YlhRg1akUSxUfIEcXSyxrMnEWUY8k49krUh1GYddJVnGzVzcN8W2MLS2igJ2?=
 =?us-ascii?Q?cqiJDtK4B5DVOiFrAerCuDKzzRNwd/ybfEiaScksI68+L9VsFfkiP1BmyaFa?=
 =?us-ascii?Q?e6HHfAozQtYg3zUW0zMtnoQAnM7lXKhIi6hZwu8M5UjjygCKk02LxZrzmGVH?=
 =?us-ascii?Q?aQau3uxx2X5RIKlWyh6Pe3Oyr7DEt4WzXKiPIfQVu1/QwwBEHX+mfCXM5zNC?=
 =?us-ascii?Q?PfjAomIRy8VuTKsXe7Y3dxMEdzvKbShH4yX9Dc6I/oIu5pwFc2jKq3cTMyQy?=
 =?us-ascii?Q?qvtA8STGLoMkJlkwgvB5fFi3nhxdm1zj/zSLgKJQXIQwoLhdHu+H7GuJHEfD?=
 =?us-ascii?Q?QcwYGl7apsS3eH0xb9bAmE4EZ89U0L0+MImrnXhcTjGZUAvdOQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bMI8uUFK5Xvpx9Ow39VzO6/w5Ci5lRnnXt+HsAf6Su/Ftie1kK1b2hrGN63v?=
 =?us-ascii?Q?oNiQgnw67UxxHnjEeq7m2KOS2wGIOfW9QSpGkKvnCIUdnbRsDVWF6BNLpPFZ?=
 =?us-ascii?Q?K6L02C3w2gup/GjmzOl3F+xnOw4EOwKb01XIzCaD4H3CCz8e6Jd9qtTlAtYb?=
 =?us-ascii?Q?QqbPMchbO0IPkpHpJgoW8en71XpOuuPoaHiXIH9s+hvK4b88OrLTdiUpCT9p?=
 =?us-ascii?Q?FkiEgFoinOT3OPXxvbgEih5zV31kZe+j6AhJTxUdVoj7dUUktGalHBVL94z9?=
 =?us-ascii?Q?eqzjpqvWxswvxHZJi899h1GreLP520HT3YtCtUCrswzUjYIsVg9FPW9qH8cK?=
 =?us-ascii?Q?mzjqZEjbpZm5m99wmrI3plRUVM/ZoMH6UeR/SWrBfXrOVzz/zHmoMyYVyKxy?=
 =?us-ascii?Q?VBZqNdhY6SjfcruOf1uH694FdOOufu29+6Hb74eM72KofkX/q6QtBBUVZ0Qb?=
 =?us-ascii?Q?y6tNMDwdoibWpxk9nRjQvZ3FODlxZkqkoVK6/uKcCCbI9NPKLrJRG3hRkKlL?=
 =?us-ascii?Q?vNMkHyFSao0uTC6O4ZsAdOMW5GzBu6eO3wHxzP6ijEIXtjldUIagjj4OQ36c?=
 =?us-ascii?Q?sFlDHWnKM1xEgHxp97TBkDigHcTonUGqumqN5zJVImcrQ3t6F08kK3rcCR4J?=
 =?us-ascii?Q?VcrUk4C4Vh63k8aW01tpf2aWjEv+1Kro1cPLvjPHzzGJ4MpSHDPBNJjCn4yg?=
 =?us-ascii?Q?ohC0nX6EkrWyPd9mJx+hdaUk15EwaYh0XifoyhP9FICMTH9dP1wPkTVkyNbm?=
 =?us-ascii?Q?C9Motb616nA8G8kBQCWtdRlgfaBX0Xyq5ro1mo400aTlmX5vdOR5t9H4jUqe?=
 =?us-ascii?Q?WcwPbFtvizMAY++mZ8s4INJI5wZ2rvM9r2yVMEZzLQVKxnkhdmJr2dSjNcwN?=
 =?us-ascii?Q?YGJ3isl5YU13h7aQO1OtHH5e/TICEWkjprS7SS/fAOwepTbT7EtK7fjOmglv?=
 =?us-ascii?Q?YRriDWx2GJ3URxoifgD0xl5359C0RU5GrwO89Iiqwyf9035CTLmptibmQH0h?=
 =?us-ascii?Q?3MIjYhBu1fqouTgKKm5gOm4rNn5ylVMuJWg/q3ME3aorvYJKgmtVqZw3XfTW?=
 =?us-ascii?Q?P10AjyW4RkggS3YOzdwsO2Smaz17ABO0Q4pLbs1jm+rII3vn52gI4TS9yKYk?=
 =?us-ascii?Q?7xWiTZZ8siPO1wdOkyRl446/awh7Re3IcmXfsuD29s3pVWLWL3mmCaLcLkyU?=
 =?us-ascii?Q?MFTCvnJ1xlV+IGIPF47y8pcBhmnPrmMfM0AZVMiY32y/cAl14u6+VbQf5hOF?=
 =?us-ascii?Q?iTrgUOCoNMMH7iSZY3QGbbCZ2SERRQQdk3BQPDt8N10Us7L1fZlZDGijjLPg?=
 =?us-ascii?Q?VgxK6AXuQDL1lf92rB76h/w7k4VpgLsIYigq2n9ZXraT3lIXxfnhXL7wThjm?=
 =?us-ascii?Q?395zy9yeSJO7vdfhgxOvgFo6EMNuSSfuUz2UP5tm/YKyOlkSwGCnvs80mPs0?=
 =?us-ascii?Q?FpmoU60U2oelbg2Xwnjx2kzNkWL3uwYCuNMJDZMug9flAKEeR68pNahwYtLs?=
 =?us-ascii?Q?2pM+RFmbwraOHD+KNi1YCchUjJq7T6DGAOW1wHWhha7vDpAGt1Go2P+aGC/x?=
 =?us-ascii?Q?7473fEj0V+TP62UaomM1UNFVBR9A7jhpHNLzIJho?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22aead3-c966-44cb-da9d-08dcb214f55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 10:30:26.4974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzWvWteJnePqZyv0DDoPcaU0IzwKBekIerYEAPEQEGSp3CYsYJftuaNy8vFZq0Vd0CIYzQPdhccb+HA8Jmm8IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, August 1, 2024 18:00
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: report bad status in GPU recovery

Instead of printing GPU reset failed.

v2: add check for reset_context->src.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5d49f70704c6..7b21243c7c55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5921,8 +5921,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,
                tmp_adev->asic_reset_res =3D 0;

                if (r) {
-                       /* bad news, how to tell it to userspace ? */
-                       dev_info(tmp_adev->dev, "GPU reset(%d) failed\n", a=
tomic_read(&tmp_adev->gpu_reset_counter));
+                       /* bad news, how to tell it to userspace ?
+                        * for ras error, we should report GPU bad status i=
nstead of
+                        * reset failure
+                        */
+                       if (reset_context->src !=3D AMDGPU_RESET_SRC_RAS ||
+                           !amdgpu_ras_eeprom_check_err_threshold(tmp_adev=
))
+                               dev_info(tmp_adev->dev, "GPU reset(%d) fail=
ed\n",
+                                       atomic_read(&tmp_adev->gpu_reset_co=
unter));
                        amdgpu_vf_error_put(tmp_adev, AMDGIM_ERROR_VF_GPU_R=
ESET_FAIL, 0, r);
                } else {
                        dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n=
", atomic_read(&tmp_adev->gpu_reset_counter));
--
2.34.1


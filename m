Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C764C83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 04:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C89AA10E281;
	Tue, 22 Jul 2025 04:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hq0w5j7G";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD73C10E281
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 04:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHSw8bAru30bJCbvPTDpbZWeXR5tQSmqOU08vw1BI/7aSFdrvHCdWTLJB8f9gSsn8Hs4nd2/gvbMbBZW16zw/odwhAPKnyYsZoUJwYtxpeqc1qh+a8igLePi7fCZPllPR+5FITsF6sKdEQ5wlKAo09T1yNdOz6KeNUO0j+YI0iZiFqBDlrcUqEgfNvDdlrwjylw1kl8JFvWlSevY2FZk6qmlF+/11ZjUlu4F3Eh2OfQh3COA/+ila29Ik8kGPnG67tBwBoEgPRKWk4UNre92YzQZpszJGlXAcWHkfxwlZz9l3ywy/sXjR1C3nF73ztD+3b6NjoJ4Q2I3D+WBPJy6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pGatyllmTjyfep9ZeDMVX1dmiK66e3NDXuAYWe7Igs=;
 b=j/bNNluweCT8UpY+/RAKH+PuZxvCoo2y7OLdovbIMjmVaW4eb00XS67BA1B9BtOx+jjq9A4a57kkayGApzFTlpdBHO7i5z7neO9X1eaSMTNF8A0KhJYCR1HeSbsubMFgXGGrjIZOR7Mr+Emg43FXmixme+UXRaTJJqeCAQM89QNVVsmlo1eYlodMKYyzV1PPqvRpeHg0Ykrkttc01/7Y0H+XZwG0m6rHOPA+pZjJZ4iZpP0a5XF6v3bVIsksOJ1I2JQemiQBaA7qsPnQCbn+VRPecxEtQXQ4KF4HjrPzZWhJlwKhY7024AxnLUFm+B3RiNfQHiAzpF3vjvCfydgxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pGatyllmTjyfep9ZeDMVX1dmiK66e3NDXuAYWe7Igs=;
 b=Hq0w5j7GtWLATbJyLrwt/GLeh0Ku7uDsSps1j351701mQMHC2moTyouC5++ar2t0WiHsECDxeVUy0gem84aRLrmh1il3u2V+ZVZHPmeGj0AGAs6OPj2CA1sECG4a79c3CRGLY5tHrD+C/SXGyPsMu2FKBX3IL0u12y1z007U8GA=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 04:37:46 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 04:37:46 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "Lin,
 Amber" <Amber.Lin@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update supported modes for GC v9.5.0
Thread-Topic: [PATCH] drm/amdgpu: Update supported modes for GC v9.5.0
Thread-Index: AQHb+rs7gfn7FGmoJEqnAUaXslYcjLQ9jzWw
Date: Tue, 22 Jul 2025 04:37:46 +0000
Message-ID: <DS7PR12MB607105378A8DDB131E5415108E5CA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250722034603.1579566-1-lijo.lazar@amd.com>
In-Reply-To: <20250722034603.1579566-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-22T04:37:30.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MN2PR12MB4360:EE_
x-ms-office365-filtering-correlation-id: 49472061-530c-4234-ba55-08ddc8d9819c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pJsnVE8+vRSnIc2z3PwckPO671eqlElS1tx3OGhA8MaFmJ1kmsD1xe3KG+U0?=
 =?us-ascii?Q?F+280TZoEsU7fNS3BtoxwDlaLWUNPGS8pj3mUlW5lYdZMglTOk/FJyVsrqR3?=
 =?us-ascii?Q?boK2RHrjGEyA4zQwho6QAyUHV6Uh1Mtb17rlSrwd3wBsQbrkg2+UoUnfxSJH?=
 =?us-ascii?Q?z6eBJ7c4Y18+RQFZOXwje77hJBDRSyBTWTveSgilm1icM/lCPkcAsrLl0VsG?=
 =?us-ascii?Q?V4OLilUbHl+wodHrB4W7JjUfYcnQjqz0Q8ByuYpG4utv293PyTVYmGKvme4r?=
 =?us-ascii?Q?5dGfzyKmJLEPY6lf71n9FFaZfAwgA5bTs7AtdX+CYfdIhIuFOuLXG1JW6hjg?=
 =?us-ascii?Q?zSZTQpWpzR+dKAy+Cz8bw6wm9bDJcJNmdUDd5WJLxcNBw8a6C9RWxTYTFIgh?=
 =?us-ascii?Q?ECh+Vvca/glGTGuvBH2j7xqg/siG7ltATuYLq1KIJpGwLonW650Re0c6INIz?=
 =?us-ascii?Q?CCiEiC/yi0kIOnwaJN3j0ahmR5sU2uRLV5dhbCzixrMdxWw9O47FpkZLKW7V?=
 =?us-ascii?Q?xVz4OPk9tDuCAgHgLPadAKyMo9dvrrEXJKc2sAjyW6wPdcafMDMfcXDVRSRQ?=
 =?us-ascii?Q?1iwbKhHphW6Yw4c3bCpvHF+sGSfhkQdnRNqKiCvfup43hItmDl6vZKUBeXKu?=
 =?us-ascii?Q?a5amCHffC+6dZ0s/xu5N3fDDnBHKMjBvWViOiSccDuNH/SFlqZuvTwYBNWUd?=
 =?us-ascii?Q?NaLW0bWekDvkqHEsdpVUI2dBRLlCQJvhSYmGSejJQT2fZ+HR7F344qTOmAl+?=
 =?us-ascii?Q?TBNPqn4kOo0wONF3dDIEUBJZ5rOtpoDdI05eVCEbeCqpLW/VIQ1Tf5dncdml?=
 =?us-ascii?Q?GeKng4qYmVMvPwbNb059b02CcroRoZUTF/cZ66bJUgKI1fTYXUDPS+gCXfPr?=
 =?us-ascii?Q?iCTMi2ylH5lr4qV20YFL8J3/pLY4ifzh7sWVOzx3x0rXBCiMVBx5BgQpWUX2?=
 =?us-ascii?Q?B0XeGBNsfQrHiU6v4q1wEZmSKbzTqCSk2I47ykTOpIyMjWcbHiOJT+x13K34?=
 =?us-ascii?Q?Kv2glDC6svuhH+x6I/X29NHZ1AG1L/AAwTbjewxzN+J1EzqXrVEMwUuUqqFa?=
 =?us-ascii?Q?Orsy/kaeFw1cK2/115+v2kijIS++7QDRDzeU0MGf4tiSVoLUxLu0GxSjlu6Q?=
 =?us-ascii?Q?r3zI9wekjhNax+S2F1aMWZIR/0G2Dw+yM8Pg7rBL1OwkEGdjv7cuVHoH/QCS?=
 =?us-ascii?Q?rCxjBMXbfIsb2swZ0w1Sb/Lcxfm2GTWPUWZrUo3oNtkPvvtGxJuZNiVJ973f?=
 =?us-ascii?Q?jokqdHK9NaQyK6gpZbysx1cvtkXzNRsY6/eqXHyI2Bh/T8q5bC5A8HBavex2?=
 =?us-ascii?Q?R/dcVA/8Yfvf81IjAA3bLLZs4EJXB+J2d4LkbrM4nDcJMSq6A0U/47xE7zvW?=
 =?us-ascii?Q?2mGsft7bHSlSTyQAR/qZDCSDjCfV9OaCMn/Pj+9BPsIMiGDZLcW4SbX3ZDoN?=
 =?us-ascii?Q?XmMF+3JD3czmcfF5YEi1bbCv1QoAnlNtr0bygPlJgyXttVuOSHR50A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LcM5R/Wz19jh5Osvn/lJAX/LGS67MVlLwbKehd9Xsw8lNfQPRiRXOe84Jkka?=
 =?us-ascii?Q?YEo5vODqvafYPDSrDd3zvCnCZ71abvoTet/fFuKFK7+tspWo9Gfg3FGek+Yj?=
 =?us-ascii?Q?hL/UGWlV5OZEH7S+zUsqcWcGi+sjaZ4gdIPKwSTA/4leEWuP8xwjqbUtAW84?=
 =?us-ascii?Q?ThzpuYm4EJvyXzzLmWi/zzmVg3Q/OkcQ2TUHQ1aE278Rh47sbL9MNB8hqw+a?=
 =?us-ascii?Q?pr3edrTUhvK/XaMaGTmJraN1WfpYES8R/dAPnXJljHwhc5ikiPxbmjf8unh1?=
 =?us-ascii?Q?kjMcGNqDJJ50jJWHwFcmHd1E2ldzaOdV0K9Hdshvj/KpmvFQ4IPu1yPpSrra?=
 =?us-ascii?Q?A3Ff6/sfkBPZ+OrXY/12ojKJoOEzR1fhWy0Hn+UZDtA14ZjbtvTa5b5Q4o5a?=
 =?us-ascii?Q?xX75+b0qiU3FSz89su8vv07DuULqhQLYiYAAF/GSSGk+Lv7bUqN85NacN9gm?=
 =?us-ascii?Q?T7oPvEXPhKBqjrJvFX+k23hXfKhX8aS7RpzYfTIgcP3uWh9alGgPC6OpTqsR?=
 =?us-ascii?Q?wiaNK1/M3EYqTIHGhfru7tYxTM48C+AjDvuxz02XgyHLFSI0elERXkenZ6oH?=
 =?us-ascii?Q?OZgRZnpG6G1+x9vNp3IeR2lYiIQQlEwEa0XtQ5aMt+hQ9k7PqpKjvX8h9E/F?=
 =?us-ascii?Q?6eWDL9jz/0byluZ3DGzTwE7QTr1Iia8aol8qOBRQ5bFjbB5JYkk8u1kAFnRy?=
 =?us-ascii?Q?WDtPr/slqxyZClkq79nuvVt1VbpUoa3yo/V5uQ/x8rsjsZxkAlbCGTEhvnsp?=
 =?us-ascii?Q?YufBzC9yGxHRJJm0WtneV7CAryGH28xp6/oQTAeJBdYvlmkjl4NZaTqP9Fvx?=
 =?us-ascii?Q?h6QaxEANfiXUuVFFLqz1FxysF4QhIg0M0hU/EbLLXTGxrsWZLrlM0KDMis8u?=
 =?us-ascii?Q?KsthzbIfjBKjLf5E2nLPsPOY0Ak5Plhe+hZNVVr2mt860ONik09PDtjxyPpp?=
 =?us-ascii?Q?sJ6XDPa6D67ybywMwESUydzWHzq3skdWW+viBrzEWdCX1wTMCIE9GyrivBRL?=
 =?us-ascii?Q?9pqQRgbYWrxdagM9i+raB7h/fAAeRF5jvBoZcrBU3QeKUtVOo/8JiSdxQ/Os?=
 =?us-ascii?Q?iVhWfjwvBNTlDiVFhjP4meF3Bs5JmzSAOwolaT5LqD2XnWYcTv3dOg8IxlHl?=
 =?us-ascii?Q?4plUoFMPEnSFeW0i1tm5OnMXNpLWsEbj8v1ydV341ya8i3hlCY6CXkWLoHob?=
 =?us-ascii?Q?73CtaKnsDXQFwv8VYkBJ+AlSlCATgAMfmdAzFg3sFxdPaQKAOOBypVXB+1b4?=
 =?us-ascii?Q?vK7sPxp5FeQ0etzcs7vY+DrFuR5lRDTAxwItVQi0yh9ouvlRl0ZPUHLY9PHg?=
 =?us-ascii?Q?C8SY1TlUMwGno1NpzlC+NH5FcEJdXrU0msyFlPKOjLhxRlkC/EESQHRfae6C?=
 =?us-ascii?Q?6g+3YYnVJj62t6gc7OamY/Di85PwVjh2PQq+t8hulftmhO8ZcdAbOzDHDP7J?=
 =?us-ascii?Q?jPzHPX5fw/LLneP61ckFw8B3OhpsdVGg4elC5prDYVnAILt9ijFTHVy2MeO6?=
 =?us-ascii?Q?654EY5iFBytH8aGuBD/GRFduIE/cDCwQaZ3lIhgQM6NfaCJCMccN6Im24hH2?=
 =?us-ascii?Q?6tTT14oRndktqmz7rVk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49472061-530c-4234-ba55-08ddc8d9819c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 04:37:46.3850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGc6+Te/4ykxBu2r1Ush0SV9Phl3G4TehMeeUoi6SQg298weGxN17YaiSHfo5654Q9T4kjSetbs6otFHPy8Z2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, July 22, 2025 9:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Gadre, Mangesh <Mangesh.Gadre@amd.com>; Lin, Amber <Amber.=
Lin@amd.com>
Subject: [PATCH] drm/amdgpu: Update supported modes for GC v9.5.0

For GC v9.5.0 SOCs, both CPX and QPX compute modes are also supported in
NPS2 mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index 914cf4bfb033..811124ff88a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -227,6 +227,7 @@ static int __aqua_vanjaram_get_px_mode_info(struct amdg=
pu_xcp_mgr *xcp_mgr,
                                            uint16_t *nps_modes)
 {
        struct amdgpu_device *adev =3D xcp_mgr->adev;
+       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);

        if (!num_xcp || !nps_modes || !(xcp_mgr->supp_xcp_modes & BIT(px_mo=
de)))
                return -EINVAL;
@@ -250,12 +251,14 @@ static int __aqua_vanjaram_get_px_mode_info(struct am=
dgpu_xcp_mgr *xcp_mgr,
                *num_xcp =3D 4;
                *nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE) |
                             BIT(AMDGPU_NPS4_PARTITION_MODE);
+               if (gc_ver =3D=3D IP_VERSION(9, 5, 0))
+                       *nps_modes |=3D BIT(AMDGPU_NPS2_PARTITION_MODE);
                break;
        case AMDGPU_CPX_PARTITION_MODE:
                *num_xcp =3D NUM_XCC(adev->gfx.xcc_mask);
                *nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE) |
                             BIT(AMDGPU_NPS4_PARTITION_MODE);
-               if (amdgpu_sriov_vf(adev))
+               if (gc_ver =3D=3D IP_VERSION(9, 5, 0))
                        *nps_modes |=3D BIT(AMDGPU_NPS2_PARTITION_MODE);
                break;
        default:
--
2.49.0


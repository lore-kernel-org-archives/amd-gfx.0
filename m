Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4C8C021A9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 12:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F0010E445;
	Mon, 17 Feb 2025 12:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qfoy5IvU";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D67010E443
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 12:16:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHaWv0Fea7O2xYreC4zjl4egx22WnGsPMWOkOXSmVJ1JUzz0PeZiIu9x0bPwVH48GcN43pfISW4hoc8mA1It95Nv7JNa8c8eIVWAgXKlo7dn3+i5gJOZAMnmwB6/zGKUmFw9b5/fj8BJLwEEgd3OpcVIU5k9/cL7SGgH9wdyxHLz4BUPCbs0WVMWyMSMJOHZum1ngRDKrrf7D47hujhkBmmpYtc52m0m4MgBy925JXeW+IY4YmChjYtwGN2FVsZg+dsBPGrZxLpE+a9dpoTiOw9n20yF+kejspw5id4J21duirl3JjmVXNtUbIKk4CXQIMg3Gz3KGJ2j1woDQUwgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOWSWVPQ/oeHfj7/4fBZGsQHY34+9+6DqtkyD7Pr7RY=;
 b=bz66AE0owT6vug5PhvKa5CSX7QiwfbMkoeGb3KghksyMkoKgSujLEqQwhbF8F3wxt6N8o+A1Jrax4uLBZSlonf/87GG1B/nQv7OBceDfM26czPh3Ti1hKMrwPMd2GU+Ab5T1tLmWh5C6b6xxqSgN5/pzsPr7rAd7+UO+syzi+yEYbkI2o1muyPLQeOwkB3f1djIuISf/Wyc6gXSvf0V68kHMUphjdpsn/7WhrO3sssE9PcK3Dwhs8LONANhwnUFLKaCITTn2Gr9EKOBSsIdUwQG/zSVejBOdhZocILoJu2PD1x4+AiMGU4RdfID5q59IxvlY9dgAM4ptq8egvmsXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOWSWVPQ/oeHfj7/4fBZGsQHY34+9+6DqtkyD7Pr7RY=;
 b=Qfoy5IvUFnAX+uU8f4XT2OMiLrQA4hW1bHfG4w46VXyadP3A25pykfNOGVbzwLKOjw1VbvZOn3WaENqNONGDhnun1hJ5MRd6Nx/30Q/G+qXoD3amPZC2gBQs5VOGOAi0E/t5dXAJlvJjMPUEvWRdJ91Ksh69ePMJ6pp6j5Stlmk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 12:16:13 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 12:16:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Limit jpeg rings as per max for jpeg_v_4_0_3
Thread-Topic: [PATCH] drm/amd/pm: Limit jpeg rings as per max for jpeg_v_4_0_3
Thread-Index: AQHbfrIPm1uBROaLVEGl9PyB+trEZ7NLbfwQ
Date: Mon, 17 Feb 2025 12:16:13 +0000
Message-ID: <BN9PR12MB525755E263AF504FE272F8E9FCFB2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250214072816.332991-1-asad.kamal@amd.com>
In-Reply-To: <20250214072816.332991-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=380c5873-08eb-43bf-8c42-82d4e2756de9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-17T12:15:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4433:EE_
x-ms-office365-filtering-correlation-id: 7b3c7e41-2267-428b-47ff-08dd4f4cdeef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5AYryWeZrMZdvYUnsQv+Lg3bHfwRsUfilNMmSM3XRWf1rEkOsTLlEPOX0ir7?=
 =?us-ascii?Q?gR3wihOjRM8zljucZG/F5pvk8mq/FLlmvTqsNdP5+7k65SGL2yS8XacQ5qIy?=
 =?us-ascii?Q?0Gbegl73L20yqLNwovsUHb3yUUj0L1y2AJruVT4vOx2avfrDamf3Yp3sYl75?=
 =?us-ascii?Q?mSEJUYLR1dmrXqI7xV4tzlZZ0/2C8oX5p56gEysETZU5ReUxGuDNvI2G23Re?=
 =?us-ascii?Q?M/yH/R9MQkgEcD3wO1WdlPQ56NNTNBRpNT1m0iy1Fy4z399bke/1MKJ5xsx5?=
 =?us-ascii?Q?n3s7AdRil5kuITqqEoFTxttJ5s6Go2zhzVVKLkLmFGZ/y7sjOmE1nw9Bh8mI?=
 =?us-ascii?Q?79ueCtK05dtnf4sHcPRs7UuKfwCqX9w6UXvP/yA80W0FSz6ketdZ6bJOgWXv?=
 =?us-ascii?Q?BzeyFiFlBHPuTPyjpC0G4CFpXpyGa/x1FnoVbWD4MwnWj9Xf1qVFfKlP6IRp?=
 =?us-ascii?Q?xsOHrgkdj5hHRWaFq3Dr8nQa+d3+7pDM5vC15Lrk5uUyEE9yDJ9naSDnwSHb?=
 =?us-ascii?Q?MTAYI28unrNPv8uH3LVqt5sB0uIYmLJ/L8IwmPFY6cxnJHMlXliIbeFAQMf+?=
 =?us-ascii?Q?zu+cPiiSNT2fbDGkhPQzoz+slemMoeirxUTSxZUhi9Om83MVZTvFkW/wAfHa?=
 =?us-ascii?Q?WQPfHw4XVjCTpORGduRp2O6uozVdK2h0yxFpRzxZj76oVMzv78OQuQQNwOpX?=
 =?us-ascii?Q?suq/ttXrGQe/P/LR9nYT81dxLMUcziMv4DPb5HoLYgs1uMhjLGmNC1x1QZ7H?=
 =?us-ascii?Q?szQkzCuyR78pi609blzvlmQTqc9pYF4YD+FbnsrnBUXm34KB92gNpE5vw8oE?=
 =?us-ascii?Q?86RsKtvAswrAfUDWI2hNCyjzWK9VMTlpTY5fEGBOV62S3sRaSecFu4IsXiRm?=
 =?us-ascii?Q?ci4R7HviNTeqnPWiEjbTrRzU3QWAylXSh9A+ugUFkC+yGxTDnjY+iUGKc3Wb?=
 =?us-ascii?Q?CqxUIavErjKaGYB5DPaQ+pfo7ZYYYJUVIty1TQXYczver0SYSSUnjcNdWs9C?=
 =?us-ascii?Q?0m9vBtSBWKesvRJ3oNB7vl4/JyVH+2EYzMexrmMUq9q433Do77NQZyZ1aoQG?=
 =?us-ascii?Q?IRYdp1Ndfo2DLTPCQ6pLiUvrEm3go5qoiplG60+ls2PEnkv8ToJPdeLCUFDA?=
 =?us-ascii?Q?gSusc3Sd4cX7NwYKqPfe5XSFfEmkwzU2IAwgDJf85a/+29jTOv1uq3jHS0I4?=
 =?us-ascii?Q?s465v3xXiK1CmZd3AXt7KQO3Jony0oUKILHL6mgfjeGmrUx6bJBoCFwJR58b?=
 =?us-ascii?Q?kUEYWxHoyzppghy4zH5TF/TyMMdWXp0VjkatEf5GzmqPMqA2ClYUbQ3kyyCy?=
 =?us-ascii?Q?gNVi6s3N93ae2S1+g2gYIJain3dhmTx0gNz3d3RE++QG7GsuEkGLNsVVn6g9?=
 =?us-ascii?Q?v05dg+Qk+E+6aclatF6AYAxB35SWwlCoEWNcpRfWZZY/tDx/+70dJDMFpO2Q?=
 =?us-ascii?Q?f4yYmhJG+X8s+XPkRwgOpBztTS8FKsJC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qMpFyAA/X59lUUBTH5WK8lB0lZaGh7hkB2GNT2OJAM1tD6Up33wladB8x+Vf?=
 =?us-ascii?Q?NYTngHPm/FGaOLaBT6C5cKFXgjNCt8VHICnRdUHt+AIk20G02FfZREg2PohA?=
 =?us-ascii?Q?CBKw3ENH9tTugs6D4SgfRCVo90wbW9dhO3zm4anjEbpC1dA3rzcCADkq0H28?=
 =?us-ascii?Q?Zx2C3NzY4A26Z/mFoX2jAlUAZ+sTN9FtWbhK98HnGKHVDAPbIdb7oNsp5rE3?=
 =?us-ascii?Q?xVqn8P/VKlBz8Fc5+8QFHHD78Y9yzaw50Rx9cY1b4bAyC4u9xPSTmxt+kYlF?=
 =?us-ascii?Q?sPMzmJn2AzSOS9gHSl8xgNjdzy/y/jPninugrCLNEOw7wL6Sx9bqR7OXyKCy?=
 =?us-ascii?Q?N66QoM/dGfp4W22G3v/TMezsqpD91iMKTKkzmYw2NDbe/gfphuZ4KaNj317i?=
 =?us-ascii?Q?y5DG/pVWCNOPsR3scj7fuUeMUOed2QJF6LaLCnmvZiZHxGOSZOHsAF/nDYYM?=
 =?us-ascii?Q?pwpWa3GazNK5SeKo8MQlDt7bIMRkmaeXL3f8Ed9cRA8sIlYWpoYbrcbnMgqs?=
 =?us-ascii?Q?LHKm0N5pLcYuWl1d0IwELmZHtz06j9KoFryDYQ2V8aQ1+n3gKIOSC/bbIj7h?=
 =?us-ascii?Q?Zdoy20iuM41U5eSVcYI6UuDRBTzODz+Vv4GiTiE/HeWOra9YqLSlVORUhYYz?=
 =?us-ascii?Q?/q7CuDzG4Gf+aYjPRcnkDKWzsPaTFZqbc+XUPfN4Ey1Jp917QaHMbWYI9Nx2?=
 =?us-ascii?Q?1a6KGQodCWv9ZnRPIQtfMaw5/U/Td+aGAT9tiDL7BLKNATqCCPbX1sqV6TkG?=
 =?us-ascii?Q?lMuYCPA23Ycsz9bhYmMBFJUZAnWQMtR+zkVoOuvOKA9XZpB/31Hh2tRMKgXy?=
 =?us-ascii?Q?8j+WlrcftfSwMmlBL7It4+hzFTKzKQZ2QPmG8TlmHheJJEjxtfnOzQ3GeYRf?=
 =?us-ascii?Q?2nQXO3peNfBwStK8+M8lzBPiJbhopuRrZeOg2F16NWW+yNI6nCe1DwnHeyzY?=
 =?us-ascii?Q?+Yqye/tUV5P6VCF1uoyhEOB62zSeYDw/8x5780nvCI3fXsfv65bUnGBiiJEv?=
 =?us-ascii?Q?dLegern8LJp918+nvKAdRec1vmi011CnsbCbqma6dT7BwvfV0l3m7Wfidpox?=
 =?us-ascii?Q?21SfkYvNZNCYZNaLIAka1VVsYqFQP9J7zMclWmJDSEC8ejDphKjU/12kQaFq?=
 =?us-ascii?Q?fvm3TXIyz7cfubo8pvlR5PdG+S3ajsaaZeWeQ1dMQljWtMntjK5UDNkx2l2Y?=
 =?us-ascii?Q?E+OG/i5d0uRoIRiUkfBEeH0snCqc/BYnUlLVBfQ56KZImiAbGRm74d7h3an+?=
 =?us-ascii?Q?NTdCKhBnGTeKk26uwId8/2nkVQ1fd2TqoHLHi+tkMff5KBmWWyzBlEwhG8O6?=
 =?us-ascii?Q?OqCHvL8w9kTwtVml91mcy99rlj/knLng3CbWR22lKcARqZUZ4JjO4URLGf87?=
 =?us-ascii?Q?pnG08rx39MIHLq8wfS5kxMtertjFnU+ByfS+nL4KxBjFc0+DBcRo7yIe2xkL?=
 =?us-ascii?Q?l3zYAW9676JNi4MOYHGRNpWg9gDjq9YAbM9zVgGf4X9wfEJm/R8ZQD15Vfsr?=
 =?us-ascii?Q?65kDlqSIZ/nZHOrogRj5HAsaq+poVmSrabSx1MCR37sq3dJD3jUiL78qT9/F?=
 =?us-ascii?Q?bK2cYzScoDpC5YX2nBQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3c7e41-2267-428b-47ff-08dd4f4cdeef
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 12:16:13.2434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/bdOmnRAtkJBPhF41ljJTwfz0kbU3tKvrFIR3bsQsDcSW+MnGa2soPGP16aK0uWVkhrdisWbNeORTYFk31RHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, February 14, 2025 15:28
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Limit jpeg rings as per max for jpeg_v_4_0_3

Since pmfw supports for smuv13_0_6 is limited to 8 jpeg rings per instance,=
 which is the max for jpeg_v_4_0_3. Limit it to same to avoid out of bound =
access.

Fixes: c80feef27112 ("drm/amd/pm: Limit to 8 jpeg rings per instance")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3fa671f4981c..9f2de69f53b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2644,7 +2644,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table

        per_inst =3D smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRIC=
S));

-       num_jpeg_rings =3D max_t(u8, adev->jpeg.num_jpeg_rings, 8);
+       num_jpeg_rings =3D AMDGPU_MAX_JPEG_RINGS_4_0_3;
        for_each_xcp(adev->xcp_mgr, xcp, i) {
                amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask=
);
                idx =3D 0;
--
2.46.0


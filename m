Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA39C3ABBC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 16:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 785BD10E0A8;
	Tue,  6 May 2025 16:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nKfYogi6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD7610E0A8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 16:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVEgFj1+jgohxZKHoM94IKFjKOhntl0AAhX3lsYghipQQbASqMihsvhFhMOI6To/5zLMHGToRRNFUzhNcgBKy9UzKdLgeUUyqu3NVF+Sehw2eEjDc/CzgTXFPCD+iJ2mM0qiaIgt/dkPh4QIKvXiFmTX7oDe2VGxVl7R/WFwJWUep2/oyf+FkfJmjvaL12ieuPhH/auFy/vj5mZ3wDZHMKW4TnUjwIMTYsEEbZE1l/NYUuuYMtNoXkGrvOd4nU4YWEYn6OLOwhmS+HUmfyEH6vrgd9P9t8W8E+4jAfEqZ+yfD9YUlrNumNxaeOrmNV/+zOZJZfQ1Kti749Fno94KFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziIOw4lFfFWXITy6TR5tH6hakpgtS5bU3ZtOtdEjeoQ=;
 b=A74fDm5k3Tkpf2WCOvqn26wWU89fgtEM/iUX25BGO0PsQN+716jq0NVa6Y17os/C5a/ClN1K/Ky+P6qWvjJbvg1XQF202ta4SJBu6Tcb3pqNNI2IE0JMjNnfFCXDlJLkHMZqTojv0ZMNaNUIZIJt37X1KfwPNwpJNgJs6h9A10OvoEkPLhuAOgoz2Boa5NNaGnOVKnxT21LuF0e13Msy1shFs54M1W1rFgq0BDrJQi7OwMQ53/bO8Cf+XgKHX1XF8KCTCO94gu5xqDvD+j1e87A7vDZMIvh8cw1EEkmrdIFnr1WS/IEhjV+nDtxsCp7G8gq24OMwVP9fzHrvpfq9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziIOw4lFfFWXITy6TR5tH6hakpgtS5bU3ZtOtdEjeoQ=;
 b=nKfYogi6Qf5eAExqBqAUTpb8cL4QqiaQUkwNySazTVdLN5InCsYWdELyPFKaPTckA3GY16o4FbTIL5idT2cvX71Yy3i+VMFycT0cF/NI9NEAo32seTkSj/+az93wa2c/zJ0Ja2/TEkHCm7VOVFHq/5z4lz3N/lfrFUj+qJ/noz8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 16:13:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 16:13:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/psp: mark securedisplay TA as optional
Thread-Topic: [PATCH] drm/amdgpu/psp: mark securedisplay TA as optional
Thread-Index: AQHbuQ1VOcerQ0bFUkiGHsslAQmA4LPF0Uvg
Date: Tue, 6 May 2025 16:13:12 +0000
Message-ID: <BN9PR12MB52577A4BDE0D31A36523D988FC89A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250429134739.1523228-1-alexander.deucher@amd.com>
In-Reply-To: <20250429134739.1523228-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fdd6dc5a-513f-4222-a261-4a429333baba;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-06T16:12:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB7088:EE_
x-ms-office365-filtering-correlation-id: 2eb3713f-f8a0-46bf-12ec-08dd8cb8e652
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6tUxXkJDl0pUG06jUCOUts0/2Sa6w7ggt7jz/BzKwwgws8e8jH11VebnbA4p?=
 =?us-ascii?Q?4g2yosehmGnrkZtM89IXKhslYF9vrnXjgsznoYrGnkVorVvIwpWjq6JkdSBW?=
 =?us-ascii?Q?sA/jmsvz6oPBu+qTvQrsxjGqK8/MaS0lCthOcDt7H83IgRpn2Ojzm/3D6+F1?=
 =?us-ascii?Q?++jWvsoMH5QCAQRWtwL5XQHwgAYwcC6M2nyjScqVx4uLFxBg1+VDgZktKKek?=
 =?us-ascii?Q?fDn4fv/iXITexfK05dUmEpz/NVX5qijlLBKigjWE7kiOj+YQayWzn75i17U0?=
 =?us-ascii?Q?o4F8Cs8rgI7J7WbgrYctFKnvy3UBqN8ImOq/Gv14Mwd0iz9QGHISbUDbSR8f?=
 =?us-ascii?Q?Bm9b350bmP70xDdKlIlz3+pCSl5rxUWTzZg4S+vSdp2MOrR6JGzq4xomb+oP?=
 =?us-ascii?Q?q7Xgln4FAH9OjAvbNsOZe/Jk/gflxXsqKT8HHTF7ih3OChSU8Zm676YpSHgD?=
 =?us-ascii?Q?KOcqom3lq0w+9XTt2d28UlfvtuhMFSurlwBfQNiHzCQ9OTAVlKQXbNB0GccO?=
 =?us-ascii?Q?Ftohm2z5THK6IeAQY/dLYi75+rohgL3mbL+tSZEcoVXK7Kg4jryyOKo0XDk4?=
 =?us-ascii?Q?+jBuiX1JZzdTYMPMlGYxNiP/OZ9PJxZcgSlb8YGkWC0SyDGcnyR4SPRduYAk?=
 =?us-ascii?Q?RAG9tXDF/a/5CHP3XTa54Xc6zdqGRXai+zJiCENMLeJode1SQD5hDXdZeOQp?=
 =?us-ascii?Q?VWYD9YuzFUHq5MiXlBVOfJPGHuUX02AFX0CqK2rI/ydDPb7KdUIyMY0l1D3J?=
 =?us-ascii?Q?pful2xOY3dlU2jkfAaGb9RAs6d+wZYENa45U+8YOTDpyfQ95xM8VQWLMdJ5I?=
 =?us-ascii?Q?jpo5QIZDQdaE5eIcnbFTiXL9oeapc3Y/FKPR0uDt29qB8dhoKV+1IhSaZVuU?=
 =?us-ascii?Q?64htGhT+QUyM1+nbORa676PL2J7yN5G8D8xqqQab5R8PInRgG5y99v/z84P0?=
 =?us-ascii?Q?ow6Gc+SDrk3R54hl3FYIn9Ed6pEXS+7pNJvEU36yqfqAU9v3rwUjSjJwfNhX?=
 =?us-ascii?Q?mdXrmB7xSEeHFLlAJ9CCSb4LixLLS8QCNKRB1aS5xgur6RPtTfgDMaQUrVCr?=
 =?us-ascii?Q?ktMaG7gb4/2t/rlLIvJqkw+tR/m8rFGhB1UVluHVMBBJEux8U0w6yYCErzP2?=
 =?us-ascii?Q?9pLRp4TxNcD8iYhhzrtnsfGuBLkjWOpUd+t7hNiTvCx1q36BeBKEnRyNz99V?=
 =?us-ascii?Q?6KYqvjUFCjr1F0r6VVf5GMmLe/ZhXEliwXJdtXn8NK8NmWyKypVjYjKL1ZRp?=
 =?us-ascii?Q?rIqo0iD9qR7mO0CzPPqsc/nHIuA+AIJE+2rPfweD+c8GaL1s2yFDbBbgPWlM?=
 =?us-ascii?Q?ActAJPdErONgtvAmQWvo4bcR3NIv5NgSkaAOo2KJC1StXPlrHexmTO6jXwOb?=
 =?us-ascii?Q?/3Pz92HD9sernPzBrNn8FnL9NSFGaajGOuUNryvKybxcTL4Qfe3I5pDCH5x1?=
 =?us-ascii?Q?QIawCohdKLg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q1V4uFuFoRi3iN/7JWEWopKlkoOQluipEv1SDq/li2rYBRWdBTwi2QrXdh0e?=
 =?us-ascii?Q?Dq6bFkT/8Tpu2l04sgJzc64Fj6VlbSB1DOONMuJWEPu650vPX9dE23WYQIbb?=
 =?us-ascii?Q?QzQn9h7HwsLONkEsLYtGDH5bfPop8PGYCHHB+1RapDzZ2jUdmNNtFYS5joeH?=
 =?us-ascii?Q?PRvk/w2Cp4zqMpcTBwvvjs5dWEp/Y+2w+TiBZNSnAufltz3u6yxHbecoQ9dY?=
 =?us-ascii?Q?lPki7sO+VGQByek8MqVyXcHsmSHQaYOa6sZAkultWhY8cL9cRRF69k2O9qUP?=
 =?us-ascii?Q?OQT7U/9aaJvr/PiJHbcPXI3PD2GJPcSOv9cUwftmp0GdbGvkWmfrtccez5Nj?=
 =?us-ascii?Q?W4Rpap6vi2jBgAbJTmFXQ78OFJYNYTko71dZrAyFWdjbCq2oQNkZGCEDmACh?=
 =?us-ascii?Q?iVoe8cxJsgD5KdgDp/pRkACzFojyff8OnGq5GwADUhf4QV/cjY8RY0TEnaev?=
 =?us-ascii?Q?n8LMh1T6zohDNI7PYJl6MsOGPx7r4omtO+fHEdNI57t1GHPHbfDO4WY2WiZv?=
 =?us-ascii?Q?ztzU0i7xeJqT0/ft77qPD3MSk0uWc4tSNUxnJEQBOuYdNSEsEnafU7ArGqIP?=
 =?us-ascii?Q?NfekpZd/bJYd2rT9pCd83B04/FnkX2aArNb9VSihVvw8lthiSl5kBLjZ8Wpe?=
 =?us-ascii?Q?2wlwMatmnc/PbDlo5q6V9hY+rxbuKboXevcjJ+HGXFV6UUCW8JkpTDn+9Qm7?=
 =?us-ascii?Q?SLixzGUA2SvHFSird5grj9/JqHMzIxKrbbssVw0JbuI/wlj+QC/WCYtyIEMd?=
 =?us-ascii?Q?K2OtRA43tqY4gRvZEYTT7yORys/AwRNS+ZmGACPFyf3/D5nxQxdBHRyEHtyA?=
 =?us-ascii?Q?pM6d7EeMRFdJjwj5n188thx886ZY2ULag+iRKPpi4jBwsTpr3Ottfzv6Dxmy?=
 =?us-ascii?Q?pa6gsjaaBmRaOj9bvWcd0jeDW2LjA13ZTS3L12o5FFODxgOuSjyO7XEa6I2R?=
 =?us-ascii?Q?D0/esm8eZkhiDt/pZg29FSIZf587FkA+zXSWHWa35eP80Y2Qk5eLqnZIKIzp?=
 =?us-ascii?Q?ZGJ93gmD2FAaB+i5eST8OjfyAZYeAzHSsOemgy1pf9a9i1qyXYZP7cbU9J6C?=
 =?us-ascii?Q?fPgbtPVONCHPsfeCp2QpnQIKGJPxVoYyaq8d+DCkVtWnm4Hd05m1zu5Hhh15?=
 =?us-ascii?Q?dsJ8EU5jN+jQi/ilUHAMoyvdibgJvBPfZQXEotXlJ3nkj0CFqwwOXKkUU9Cg?=
 =?us-ascii?Q?x/iWdZVpTcFIBgpksylK+820q0+92eDwUWXQwF1HbkRAm6ScT5xCQHKTFS6B?=
 =?us-ascii?Q?twNOQObgUDFN95LgYayWzHDyZ0ooZgEsYXvKX4RGs23BIexZf7SzGPa+S5JL?=
 =?us-ascii?Q?vXKkKKOnogxK//P10Ff8SR3wdssI5gjIZ3wE8jtkIscs0WBUDS04o38nUFu5?=
 =?us-ascii?Q?KF89CDXoMdbRqe+DFyF3VjbZT6L/NhjM1uxuyQi0ZeVYvb2jVI/fYgi7YgKE?=
 =?us-ascii?Q?y+9Dd0F/VLx9NesDu/vzYyqRTozyZ0ixu8EIrCL2g4rQzFf/gOB5K5fWZmff?=
 =?us-ascii?Q?R9h7pfrO+d+sddWCPLSimucElZi/+K1zOXLEzgaaKJU9KIkrKczLVGSmKcR/?=
 =?us-ascii?Q?LfEtPSw6unH0RZoviuM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb3713f-f8a0-46bf-12ec-08dd8cb8e652
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 16:13:12.2388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWxBlZdLYNlot+JxXyNW0RR565q9rjXkMfepNdBjKdhbiFI9M+eC5wUyxjbhuug8xbsQRUZu4YneMoHUaGQ5ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, April 29, 2025 21:48
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/psp: mark securedisplay TA as optional

This is an optional TA which is only available on certain embedded systems.=
  Mark it as optional to avoid user confusion.  This mirrors what we alread=
y do for other optional TAs.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4181
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index d54bb13772622..1c843b888475e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2214,7 +2214,8 @@ static int psp_securedisplay_initialize(struct psp_co=
ntext *psp)

        if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
            !psp->securedisplay_context.context.bin_desc.start_addr) {
-               dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta u=
code is not available\n");
+               dev_info(psp->adev->dev,
+                        "SECUREDISPLAY: optional securedisplay ta ucode is=
 not
+available\n");
                return 0;
        }

--
2.49.0


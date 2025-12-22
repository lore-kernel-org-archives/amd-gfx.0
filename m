Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C75E6748D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 09:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8889110E365;
	Mon, 22 Dec 2025 09:33:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nm5nc314";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA50410E365
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 09:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZlo+0y0hbA1hHU4JECrO/zKnBSguDOe4qW8E9nd17meix0E73k3taa6Z5dAsCx3Ud9fO2gsnRFtTa/lma1fLQof1jHX8+i1iW4/5fyY3JiLRPnNesmZ+M/nxuT1b5Da6a+i5ALnVH62vVI60nzlxAO83qh8noAZ82labVdQ6Dg0byjPcCCbm2fhLVQoLsnDRhYLweIIQhZEoMmRZ+05keJOuQTHIiPwySi6XOfJbtVNDlGH808Mfu0ivYFQn4dCx7mVF1TBxMdwdwnZSLKZZduhammqQYF+Jbo7eLcnaMj8YTx8NYdamvfnw7PHVlgp/cFNWoCyZ5gFNuEbE1FjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh0aLJcOuRk4/9RbCWVUlYnMG39g4GebifRzltqJwXI=;
 b=WodSXWc08U+kVE0GExNMPoB1mt9Hu2fEAE0t4B5QmgH7n9PglGefDFHK9p0GpWrfJwtpo3BMWM40hSXNVm9wwVxlmixND32AWKomjCfHxjkHZ5XLI2CulPEk8vQSaqGml3R50ypD6nQzF6760e6CLTtlysXmAok+khYI8cVeh2zWGX1exa77RHx8PKZ61OlMlnmDhQsg6IvcyBcDrzD3KesxNq4V89h5e2sns09axVCLYV2b2rsdHexep4hWgI5uFqLbHUJzJE1oa4YDN58zAR0wTR+iUUGszJwH+dSCuq0lpebHGGlLRDPloq3JDi0BEXTAaCa4TyK87vCGJ1sJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh0aLJcOuRk4/9RbCWVUlYnMG39g4GebifRzltqJwXI=;
 b=Nm5nc3144PuOAOiY3euqVBuMyfaDeX+OHMnz94+XABSI5I0PFwawwWvzhBmqX2P7WQbQx8BJcrh30RfgQt/3dhSDvkfK1J1BhvB1e48YmB+jGAEIf4wKDMuzAfewxWRxLIJmgeKNgUVXPPgzsDCwJPGC57nwQCyhmFwICTEO7MM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 22 Dec
 2025 09:32:58 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 09:32:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: only check critical address when it is not
 reserved
Thread-Topic: [PATCH] drm/amdgpu: only check critical address when it is not
 reserved
Thread-Index: AQHccyB3+Yo6jUKY4EmsYQYQjnxUCrUtZXuA
Date: Mon, 22 Dec 2025 09:32:57 +0000
Message-ID: <BN9PR12MB5257BF6E79A34DF2FBEA5C77FCB4A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251222085307.863322-1-ganglxie@amd.com>
In-Reply-To: <20251222085307.863322-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-22T09:32:19.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ0PR12MB6992:EE_
x-ms-office365-filtering-correlation-id: 72febc8e-3078-4889-da9c-08de413d1779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?U5sJug4HLtgAAtHkwdrL4tXVLvlH2SglopK5+m+bsCURMpEYBRimrr0aB7XF?=
 =?us-ascii?Q?wJ0gZfJ40X7DGeVnkeg6qWjTcruEKgFAreICQF6GT3i80GnFDJuYCgZgrRgL?=
 =?us-ascii?Q?TPGZ7XXPK5sTst1QJNnJ1wyK1v6bhVv+Vp9neHc20eXAYLB7FQHbGgAFHqan?=
 =?us-ascii?Q?+q+rg8odbbQXmIj6T9EfNKZMfSGcgXEAuQQHS/ehznnpujAeX2gmy6hYYpVO?=
 =?us-ascii?Q?8pywHa/dRJVHjfV3VllCzFEwPRFbLuX68bGizmPB1Bo0O8wbEKk+H+GvlLEs?=
 =?us-ascii?Q?HUV6nSzUAub7x4jQvk05ZYF+NVbV/1gbNCTtTdNiA/COfQe50xnBY0bhKvas?=
 =?us-ascii?Q?0tY0e7yCssJYW4qky4K91tBVcyab8mSmU+IpP7V1cGdGQaLKo0oRXl7bFSFM?=
 =?us-ascii?Q?QjYdBJZxnKTov/gq79LRFxqMLSrPVF5vgcBJsf1xCTQ8NiXpnU+byP5OAEdL?=
 =?us-ascii?Q?wpy6vZ+3J2Xh3ztHYlXRX+xv/7q2ZkSR6cFvD6F2VSQFkWaiBp23lSPEEsFA?=
 =?us-ascii?Q?N1SuiXXQC48iWoJBl+eyfV51AHih7MaKL/ZbY5hwQj7iEenjxFPmy5zxRdhm?=
 =?us-ascii?Q?bBiI58DlY5NjYt+60rINx4YjFaOjEqCIFli8LjjRe9CzPFmQk/wcEDEy8YtP?=
 =?us-ascii?Q?qtxbzGI6h3N04LivU6GomR2ykG0YHWumnCcFiZqPvE2RuK7kpHoaB6nq1Hhv?=
 =?us-ascii?Q?L5dNTnMqaqUPK4eHntLN6q+FKBVdKXGPi9vWFok7bARyoOhpKvyJnWCS9hpS?=
 =?us-ascii?Q?5hP9NHLfGGdxcFXBUJUxl8aAALvnwWOxAkPbLE0N6mc8Jwp2l/pdpHqpzMvL?=
 =?us-ascii?Q?FNWz36b6TULDxVPv7jqwPX94A0oQPNMQiEPVRjx7ORbnDS9InSd/BSyQe7Tq?=
 =?us-ascii?Q?E3sKh+5Ga7oOLVSNDd0/wJ3DpZvsSiBh16PluX4YkxhSanwQe48QkcalzJ/g?=
 =?us-ascii?Q?R5s11ZloBn3Pa8K2z1Mr0fz/9XXPyit7b2kYJO+usEPN3nJBIR63p+WJGUic?=
 =?us-ascii?Q?42GyKdtpPTnTEV2qGhZSlGXnODHG8YD17i3PKyk3tyajFI8SiExY6e5Krs+3?=
 =?us-ascii?Q?EyhuDUaeQhQFtIXxtrjv8ETeSvodEWy1rAtRbbW5cmXgvbJr+rHur36a+kR9?=
 =?us-ascii?Q?BaE5BBAZQNr0+iU6G2yk9+hLbnCt/Sc7tAm9BsNv1l4nRlyPS8WAaIVKixkc?=
 =?us-ascii?Q?8pW88y2HrK8kGZji4k33oHEEkjzC8+KkBRzWbDujYp+Vm0JyZKgPRzPa/qVx?=
 =?us-ascii?Q?sAul2pWUjow8G6BaFiI+D/gRl3eFgLUoX6jTXM1Os1yRWgyv+3GZs7eiLu0s?=
 =?us-ascii?Q?6SxrWX3NfY9oy9whwPHgnmLF+1rnkP8B3vZGeDTeiLRgj8v8Eo/Ps7WeAGLa?=
 =?us-ascii?Q?Q1wQWjiEIPCmZmlLUVlvXhBzl3pyaeXp7799xRH1pHErAiDwtoXi3UKIviUD?=
 =?us-ascii?Q?GMuR7DQkgWUGSC7oO37YQpgraiUhBXScMWYhRROEW3ky7HEczAspV4n44H0a?=
 =?us-ascii?Q?R8BlfVBbh1FNvUUvaABFPfbF8J5W8pjP/mH8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y50CySHwBwy11RdUcDZelAViqv5Kvofp2y3k3fcj/Rr2L+N/LGyioeg01gkq?=
 =?us-ascii?Q?dxOWiquSfERNlY9bf9z0VxRo4SboTceJqEOtyXFiBvF1mirCEvbZVI4ZvMXr?=
 =?us-ascii?Q?BSInHc3D4r6dL6xaCvjMGP26S8I8aTl1mbau1ejHLukZ+9l7UzkbYxfxR3w+?=
 =?us-ascii?Q?aG+umR/Q4zZotb8JfnSPpvnjCNToN+RSFEJIhPLATJ7EGfy4360wgCsdh8ZD?=
 =?us-ascii?Q?TRl8+Luv6X9oh6DNbVdBkcdE6EJt/bQPWXJzlD4FxVVuBZ/Hc0py8y11HxQm?=
 =?us-ascii?Q?nT0bNKL05ozVFeYxGfIHgArbT4mUJIDjmZIlFiFpTQzWadM5A9VbWH1yB7p9?=
 =?us-ascii?Q?DHCy4Of8PBRZbk7cx63HnAFyw+oGxgH7IOlTZ/aVcp+x1ooc3fbs08VFDusy?=
 =?us-ascii?Q?WF80GBdd01UqHGtX9WcanuJ0HEngoxd6LFmbPJdS+UymctTl0hndMu7G12Jo?=
 =?us-ascii?Q?N2JxuKy9mvK1E4w3NuRXzjzYBJ6GSih/9tNfO7W/+Wl4Gccus/ctW+q0B8Yf?=
 =?us-ascii?Q?atFdVyETSEtdZ6KM9vmSPv8ycBfgKJ2x/NNro7e/8OpQpiAQ3W85GV11JFpR?=
 =?us-ascii?Q?SUp9oFqyownHc+H637BeoFL3zxrsdXbmSM2e25hq6zfU64AJEKThEEFO0cnd?=
 =?us-ascii?Q?94gb3Fqi3Kb7M73jlsH/CiaIjCO+6s2UEJPBpQnpNcjjU1PhXlulJa+jPBI+?=
 =?us-ascii?Q?bxLt8yhfPRztg1eKql+Uqg6zw9G+FTu7qMxEbbhouBzLQ7dlb/wF1i9vMFxU?=
 =?us-ascii?Q?gi7dGBsupbbBXL/uIsVU0pNnHvoFpKpTJarSl6q0Dp5C7qS80H+RDXBOr7GV?=
 =?us-ascii?Q?u+p31CNQcMPJU5N4y4dT03JX93nLs5CkKlNobwHtrUYBN+4bytcVm91MZg6d?=
 =?us-ascii?Q?4ELK0/3mpbVz5fnPXj67ty7GtdRD0mPkPt32k6fGrp7/eACGwV8mOJsobOlZ?=
 =?us-ascii?Q?kI7he64gYA0SfGq+8lXT3v0QwioqetvsP5mmugMFr4n0R9EuZ3zatIRbm6Wj?=
 =?us-ascii?Q?t2mLApdxybPpar6meBv0r6XJpKMuzpXWyTCiIGO2wTl2XkL4X4LcfJwtmRrX?=
 =?us-ascii?Q?nnCnSGfBz+6jc0Z1OUGeYI7xjmNbPHRP6GJOq6CCnKXf8wFgfwzOPOToZ6dh?=
 =?us-ascii?Q?LVDnM6e1j0amEzqw6jbN4AIVJuvzZccTVIQ4osPNGsmhT3WyP6eUkN+zG4Bs?=
 =?us-ascii?Q?I61wZJqOV8DRR2PTQU099+XPoaGelFMsRRn87ZxVZEb1h4tj6iHjxO379hFH?=
 =?us-ascii?Q?oS3EW/fwJ0A+jM8HLKvjCc+kiHCqyz8vMiZsbgqg8XT/wCKRy/zEVdwGj9xx?=
 =?us-ascii?Q?pH6TIJxjN86jBy5TQkDJanMOEFrhiaad2duKQFD7anMLzOfquXmcTDen945Y?=
 =?us-ascii?Q?dmoH3tiFhJUM78VapnEo0K4yZUxnlhznFaoP8rljPFZ9rxIxmteeAIuiLAj0?=
 =?us-ascii?Q?E+o65bwk9WWim1wFYbPn9DbboN67U6OFK78oiLAG6+S6rjBO2IPrVbY+mj9N?=
 =?us-ascii?Q?t2O8EpW5bwS3KfdAgleCOzguonRcmDiQw3R0LjLyIIUAkjUqKFqVX/1SfOW+?=
 =?us-ascii?Q?Cf2k+yke/osft9EorQiV/RgJoF7ldrc9waYIADQTLHhH34XHsZNAjI3JHxiE?=
 =?us-ascii?Q?1jSODWI82tEIrwWAnsschqMlOVyetR4NmWGQyBZsGr15Z+/hyd9OfIhsF+sA?=
 =?us-ascii?Q?aRuhgQEr9xu0BUVYSNTRkoOJXlKwKILEV6QOJwnnqcuthYQ1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72febc8e-3078-4889-da9c-08de413d1779
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 09:32:57.5429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/8VJVKJILMXsulbBO1vLS3AW+oVKVaw264KeRunVRANUYuEGV/yduYffm94Bre9LWw0vjOM+CgyL7G+1NNqmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
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
From: Xie, Patrick <Gangliang.Xie@amd.com>
Sent: Monday, December 22, 2025 16:53
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Xie, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH] drm/amdgpu: only check critical address when it is not res=
erved

when an address is reserved already, no need to check if it is in critical =
or not, to save time

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b1d1bc544998..0c84c7ab36d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1922,8 +1922,6 @@ static ssize_t amdgpu_ras_sysfs_badpages_read(struct =
file *f,

        for (i =3D 0; i < bps_count; i++) {
                address =3D ((uint64_t)bps[i].bp) << AMDGPU_GPU_PAGE_SHIFT;
-               if (amdgpu_ras_check_critical_address(adev, address))
-                       continue;

                bps[i].size =3D AMDGPU_GPU_PAGE_SIZE;

@@ -1936,6 +1934,10 @@ static ssize_t amdgpu_ras_sysfs_badpages_read(struct=
 file *f,
                else
                        bps[i].flags =3D AMDGPU_RAS_RETIRE_PAGE_RESERVED;

+               if ((bps[i].flags !=3D AMDGPU_RAS_RETIRE_PAGE_RESERVED) &&
+                   amdgpu_ras_check_critical_address(adev, address))
+                       bps[i].flags =3D AMDGPU_RAS_RETIRE_PAGE_RESERVED;
+
                s +=3D scnprintf(&buf[s], element_size + 1,
                                "0x%08x : 0x%08x : %1s\n",
                                bps[i].bp,
--
2.34.1


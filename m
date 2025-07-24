Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDB0C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 06:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC59610E887;
	Thu, 24 Jul 2025 06:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OhpYjV+7";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9AD10E887
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 06:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHpuF7/xSIGAzaEHJhFZd+psGBM6CEIFmonxxgfVjXH7JDep05JlD3EWAHYfGfjy7+dnZACPpbHh7bmID9nNBkwZPZn69xpRnRM5MaInFNBdMzo7DGi+heliOUAqw1F/99+9ZjMYbaqP4z9KgjrbW17xXKz5sNowhZQJNkzLWPFm99fBnNygp7nY/NEt0tRs9DbWGojiWB9BKgxDMJ1j/nBedOr1EWQihgKVVxFkp7msF47OTctA+4qDd4NGM2RCO6czFHsw99+RvA/ePEGuGLYpX92gNQj3dpCKjBM0fqvUtqZVrR+2FT8PInLr2e/tUGvzK3mBNlkiemT+Z9OGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiNiV1Wl7SYAYpCCRqbnuA8/65kVcBX9ZLS/uaABqDQ=;
 b=Mf6hEvbQ0b6XXxNHTjGFJgIEX1FoyDTghXwu79K1hevfR6U5+ootCpLD7HESHUBgz83ybVUZem9vBwEbXZbL3ie+ooRIlWE5OkATuI24Xqh5jBwYPhC9Sna3/MKt53RPiRARbD5xthSCW04v3ee8wBSmEj5Y6Rg/xMoj6uxy7RqA7wze+5JnT9th4uRrP3ANLCLo9cBzYNPu3Bn+E/RQdGgUC4YZbaoFJPiI0NfLwg5VSViBVTEd84IJyc5C7kvD5YV9j+s2wXUL3UA4Viy7ZlJRMNQzZHtZYZh/sIX8F9LK/n8quRP5p1NKlIe6J3CDG/k9J/uthIA+64CPU4MT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiNiV1Wl7SYAYpCCRqbnuA8/65kVcBX9ZLS/uaABqDQ=;
 b=OhpYjV+7mmK5lV3ZZq5OsxX+a4quYD57iOxUqraBcNu8Z0xRaWdMk9t+EOAAbHqcIDTTFzmWBVh4gmdtNgkzL1Wd66KMt+syy1YuCd6PAjtwxAuX98ExjtFEWQQIo8NbLnV1JJROvqajGr37sWXv5k6M8uwjDKNLtQ6WUKFdzJ8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 06:24:46 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 06:24:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add critical address check for bad page
 retirement
Thread-Topic: [PATCH 2/2] drm/amdgpu: add critical address check for bad page
 retirement
Thread-Index: AQHb+6TUy80GEmY75EC50w6PnRi2bbRAz+bw
Date: Thu, 24 Jul 2025 06:24:45 +0000
Message-ID: <BN9PR12MB52573EEBB7C23D6305A12269FC5EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250723073802.1844148-1-YiPeng.Chai@amd.com>
 <20250723073802.1844148-2-YiPeng.Chai@amd.com>
In-Reply-To: <20250723073802.1844148-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-24T06:24:22.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7296:EE_
x-ms-office365-filtering-correlation-id: b4d377f7-0cdf-4dfb-821e-08ddca7ac8c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EgRharV+4LdewRfZsz5ISWp/alv5Ok50BITcSgbX4XHb0VnWG9xo8/JXdc3r?=
 =?us-ascii?Q?lzHuaDce/Qq+ES90Uw9zcORbdvdtoD8OpELDk0xXqaSvibP5CwYlZLmmDmzc?=
 =?us-ascii?Q?LxQ1Cj5V7PdaIFYpqPs3O0BmjVqZaLlX++cfJrov52elJrm2KRdnaIHqO2wg?=
 =?us-ascii?Q?S7EahIdXDO6TENVCPAu0sEmJ0bb7b789g+Z2qRTw6BwUKNdFSR7EwTLaFITB?=
 =?us-ascii?Q?hc71E4/4EaFMDAK880aMW9TgFIsaxrv8QYb5fenO9/Hwg6fxRsBOrbZsPLuo?=
 =?us-ascii?Q?idZcbbAZE70Woi9a5WF5f/jsEfxw38mUqa5Djceh+LMuOJmy/qkiPOzaPPRH?=
 =?us-ascii?Q?359LP3egNJHFyCaxE3qyAE6adUkzCELJLxb8E+FB+Ke8/0J0OwweqlTnqTYI?=
 =?us-ascii?Q?V7Ih0hsKFkR8VEAhs3t2NAueqexvSemklPzgF8lLLiDS7ZpAleynIZ6YohX9?=
 =?us-ascii?Q?zzWE1/Mt8x7RqpAqXR55gilqRv29Qxmsh1fO2Qudm4aZ3JHhNsdjaVuVQDwg?=
 =?us-ascii?Q?MZQBvPBgzeCLI69Sql+uDR0vaUVkt6QmLEf3g1mOakuGpH0Dvv59bcn9/Jfp?=
 =?us-ascii?Q?TQpHSiSfls5sAtI1IECTCgbzKJEwSYTtPHJrgolfZNgHKvOCMpl98F7/I66D?=
 =?us-ascii?Q?ynKO6W9bOaMYKdZitGo1oBsdw+AICL/o4MhOTk0mY7jgY6tV5jXA/oBfZTcy?=
 =?us-ascii?Q?6bL/22f01wpKGl/CiRxWQU9KID7x9tWumh86T2DCzJndy8yhZY9AVdCXI4B+?=
 =?us-ascii?Q?Ijel0betxMDiCLMxxiVxyltzxN4N2iFAEVFfqG6sxwqKkRY05omRWwD4VAJ/?=
 =?us-ascii?Q?IINAqgMFoJk5jfblY23IOsonwyR+YLlzQTNb7b4bhOb/ae+RiXDiGoNqjke1?=
 =?us-ascii?Q?8Myt+gRxGW1BF8d7XgotbssreFXrLdydmCKcH1xHWlTOFkQl42mGPWIHaPut?=
 =?us-ascii?Q?ftowB5KykKt0P1kSiwIYWYwkWAlsqhCKfY0uNBumpdxksOlsgfW7SC0uWdxB?=
 =?us-ascii?Q?8Iob6XecubDglDd2aGDAYEmsKFq74igQt76M0zd1wJDHSvILcQPX8GECrHL0?=
 =?us-ascii?Q?ccahlmt6lDcOoF1EUSJDtdqLVQQ1Bjusju+eyrmEaO/9NZi+jnXEwbXrH19s?=
 =?us-ascii?Q?7o+R0zGRBS257w9IcFdKlsIf7nMe93pBGO+M1xhbLGUD7XqH0+wmLYtmbq1O?=
 =?us-ascii?Q?OZybr5McMnszxkw2Hp8yTQMXESh1O7SKDkQuOslrgyXDBYSpNY+9I93QVPgu?=
 =?us-ascii?Q?iFjfesFWDD2ttEJdeLsSkeIVIAUoqzqO3u2vBCOA/lpR+0mU0W+Rqqpn7/7m?=
 =?us-ascii?Q?7R0MjR3zqJEta+6/wII3TDZDirUI2xvRFCWY08XD1rEvMM+eA1UaJzyLm8yC?=
 =?us-ascii?Q?OI/MXjXnzkGnUl/fKVN7YEwfULZyHqM2LGJL7XFfusNXhA3wreMUjxPKANrq?=
 =?us-ascii?Q?K9LXKfPYaia9OJEwsFOZpaS+KMLKMGEkz8r25vwmJ6kEVeIC9ndVog=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?glo3P5D/C5mZ5sleN9K67f95By2kUIXpa7Zq/3wqGn50xH+Yy9jhADY6Ubdr?=
 =?us-ascii?Q?AckJb9isXTEsNI+ryjXL8FWB+WhsEGkxIILzbBPf3GeP8GSo+M/aUXSE7Lq7?=
 =?us-ascii?Q?T8lEQ+RREqGAilVPyIGUDHyxjWvEMQ5+8bA7hk09DeAMz4221gsMCr+j4KCS?=
 =?us-ascii?Q?4IOSkxPxyGdB250mABF8/QkRyeNUSl8u4kYPW7HVWrNG9tGeLeZpEj9xCKcE?=
 =?us-ascii?Q?IcgJMfWAmkxLijbk2tScbU+5n1Tik+sIMyO8rrHAatT3/my/0BYUQGnqVMeQ?=
 =?us-ascii?Q?6YaVpOT6jHE5+LMMJmERqxqSc4LKcaxu6GAsMtPMVEr0etSfYZjd9vBkz68M?=
 =?us-ascii?Q?b7sDZSlPinCCJr6Gzjf3q/HcF9d1CHEaDlYG8yLuaMZujtI8cMMd2tXkc9mO?=
 =?us-ascii?Q?7ODoYrEeKYA96fpCsAdYnHNGChON5StsY+vmSjGtflm54Uya+YC9/jFg3TGw?=
 =?us-ascii?Q?WaErAOj0WDY1AfeGDEa7scd/WSAgZkHViGYPnC4ck45ac6J1BgyEIG9HawFD?=
 =?us-ascii?Q?eCkYGWsdtoeYcW89/a2HAK42fCkUFdaig5j+9R8r14dnjVdpUsOBFeECxbao?=
 =?us-ascii?Q?G+9BYvQetmhJGjg5o8tN5u9QzHaqwakyjT/V457RgUTy/vO3y/7VIcRHTJai?=
 =?us-ascii?Q?kzV5aHv+2W7JBc2ydryiWMoMQF87Vp5wSrJ95Ad481S1rdGsJskT96O0RLZS?=
 =?us-ascii?Q?ktmnPlLVgMQX098Hen7u5KK66y/ABpp/b8oTk9fcoQacP/er16G3DtpZkOzW?=
 =?us-ascii?Q?S/CetaHzdPGMTacK5Aufv/Hx1cm+0T4DQ4xJCGAT96O2PJmhxAjmtnzyYCwj?=
 =?us-ascii?Q?FcJhWYwIj6TLa58qtFa8CXomuFo8u0oVC0yaIrz6+TKf5WCa2X4WYYfhj57L?=
 =?us-ascii?Q?VDG7+ucsYm6fkqWSpHdcPo5sJIHSpGEvfXSgXxHq6//ikmn/Mo5h6jeXUs4Y?=
 =?us-ascii?Q?uFWMJl7dtxAFZA2GwHgf1xmiVUA2ee1IsFrZE7XDGW5DKvAsVL3U5++CdSEG?=
 =?us-ascii?Q?Z+ofcMdzfuOWY7+guK0d2OEVIbNeCfkzi+BBz7qEB9ivciY7alOslWD9Objz?=
 =?us-ascii?Q?KRykx7toqvnay/HwKlBKJR3EepWh0GGRqoHzvXGDjtvyUba6RlY6UsaF3McR?=
 =?us-ascii?Q?280yfePaSecEt6Q4Fp15oSw5Evja/JvYDTjOgt083BYidWFAQoBF3pfDhTKd?=
 =?us-ascii?Q?EecxLDjJKX/4p2qUOSfVUqFKPeIy9V8wktyBGmHrZ+4UDRfZtmdlC64rpEQe?=
 =?us-ascii?Q?8hXxqxLj8YhHEeRSgP3T2aXU5OtzWit7Bxj0oqiS7xKMfB3/8F10SiITCPbD?=
 =?us-ascii?Q?1GaIR0cwN2hAs4fUYvhGJIFB+hdomJ09l2s1Io+Uk6mAq48QJU/GMQRVYNl/?=
 =?us-ascii?Q?sg4PRpNaxaI8PRYg5Cs3+tzJ6vKJQs279Y/EXVl8IIl1HHCe/ZQmtHdFmK/q?=
 =?us-ascii?Q?o6R75WomHKHzzAH8kNF2TFmPDIH13ZDTIHdftPVTMRnyOdfrm5+Ke95+K7wW?=
 =?us-ascii?Q?3zfqKXfRoODRdGjXh2emG2C+Dy5eG/Yzyqa8j6USeFIQHSbBrcFITnWZAlys?=
 =?us-ascii?Q?Ol1jUZzTIzOpfgCnND7F31fOWlq3qq6zn/H38y6q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d377f7-0cdf-4dfb-821e-08ddca7ac8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 06:24:45.9373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AN7PfnGwzP56G4puJGonhkK2fZcoC/5BV2EmUpLpDDYMAqjDpQBTTavQuMC54ltM3xwFh8lWdiPR/CZOwGFMbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, July 23, 2025 15:38
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add critical address check for bad page re=
tirement

Add critical address check for bad page retirement.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 0ad3a9eedfd2..a1062b23d0b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2660,6 +2660,11 @@ static int amdgpu_ras_badpages_read(struct amdgpu_de=
vice *adev,
                        .size =3D AMDGPU_GPU_PAGE_SIZE,
                        .flags =3D AMDGPU_RAS_RETIRE_PAGE_RESERVED,
                };
+
+               if (amdgpu_ras_check_critical_address(adev,
+                       data->bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT)=
)
+                       continue;
+
                status =3D amdgpu_vram_mgr_query_page_status(&adev->mman.vr=
am_mgr,
                                data->bps[i].retired_page << AMDGPU_GPU_PAG=
E_SHIFT);
                if (status =3D=3D -EBUSY)
@@ -5406,6 +5411,9 @@ int amdgpu_ras_reserve_page(struct amdgpu_device *ade=
v, uint64_t pfn)
        uint64_t start =3D pfn << AMDGPU_GPU_PAGE_SHIFT;
        int ret =3D 0;

+       if (amdgpu_ras_check_critical_address(adev, start))
+               return 0;
+
        mutex_lock(&con->page_rsv_lock);
        ret =3D amdgpu_vram_mgr_query_page_status(mgr, start);
        if (ret =3D=3D -ENOENT)
--
2.34.1


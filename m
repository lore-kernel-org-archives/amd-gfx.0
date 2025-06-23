Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF55C7115A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 01:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26D810E058;
	Mon, 23 Jun 2025 01:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EMZuWCIg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717EE10E058
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 01:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBm7g4zOEZHweJ5aCgyrXz0NZeoqFJONhbdlPsN52k9rQaicBDPxPo5SyFC8T/FRsKbT/ln14dQHS8jhehkSfyNFB9cTXj3wtOweTK16DbP8NLmL20AwNHjsUO307VzYb4cGI4JHhuyqKYcXBLCr1pl1jL38/0IZ24x9C0b6vVaRnSEETH4xHaHRaVv9fRlsow+8srn2JTjVQl9OdQ/v6MhuH3BpIusrw0JvQpL/S3gIgL+q2hkp4v7TOBYoT53pr/H+aBtnNpVsxqGESuaqgelJNDPQFmaLgj2Q+AdADa5l+gnxTiFjrQeamdEWeqhqtbMROP7xN6zefrlJb+Tq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byWotgVoWvuTQh5gY5JTY7G80guzUWAR7yhl0A0bovM=;
 b=sTiCzBxqDNwZC3AK1DZSAu5CXYycky5llWt7Knh6ue9FO90hsi7YKLHyxzhBhGvTiePWGg5sK4v0h/SZ6AGd+qTBhtZEishoaUvIDhwpP7tcRwUPIfvKQCIQwPAeDlXRJ7v/VLBs6tj+9JH9dPk734oJ4qlnrm8HqcBRZY/7ADsrJ3VZdSniKGmFOFlB0MVTvRx4TvGaw11kw6/viToYyGQOkTJTe+CWML/Wts9J0wAMB08Cv6TDl96Sn7NggiYMUtSURLvoP1BZqDsn4WRC8LvJ+9j/UGjQ1A+km6yuRRbcqbYbitNOypq2CP9fVLW9MBJ7FVLxL1F/Zaej0+wPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byWotgVoWvuTQh5gY5JTY7G80guzUWAR7yhl0A0bovM=;
 b=EMZuWCIg2oS+nzAinIt+Z+THavPN1eewKStwGE3Vs0T1PrbE2yMP/ica7fxnPtkW6g87KizJw0sFDiwyAVIageqnFNTnsggWmOWxa1omocdsAqLji0EO7VnMu5UKXQm/rkcC8ECUoSqcO6pPydeyQ+CBNTZw2Ovk5SiM4sA3eLc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 01:25:05 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8857.019; Mon, 23 Jun 2025
 01:25:04 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/sdma7: add ucode version checks for userq
 support
Thread-Topic: [PATCH 2/2] drm/amdgpu/sdma7: add ucode version checks for userq
 support
Thread-Index: AQHb4fnRs03bRN+430+Afd3zijjhmrQP90fw
Date: Mon, 23 Jun 2025 01:25:04 +0000
Message-ID: <DM4PR12MB51524932C70AAC30B09CFED1E379A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250620154102.49652-1-alexander.deucher@amd.com>
 <20250620154102.49652-2-alexander.deucher@amd.com>
In-Reply-To: <20250620154102.49652-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-23T01:24:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BY5PR12MB4241:EE_
x-ms-office365-filtering-correlation-id: be0d52f2-3369-4c74-ef02-08ddb1f4c82e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+7dK8dughVuOvuSaAzVAYGcFpRaqriSWIJeNdIvtj2e1YSfg0uGEBLm+sP7W?=
 =?us-ascii?Q?9RKyZTJwR3MCUsqfXC0ZYxhR5CVCYGyxfZf7cwEdlC4zIdWsm6xo8lCWX/US?=
 =?us-ascii?Q?rV038uINpR2ywMTLHfwmmWkO4KHleQ65m/bOr1PbkLM6rAvt7P0jTDqlRSXy?=
 =?us-ascii?Q?6RHjHABRvfObiZgF8bfSMvC2frQEARxfa6j6kU01lHZRWnN8WNWYoJBdfZCZ?=
 =?us-ascii?Q?fuTtDnjiX+Vb+gbcAahx7RtK1UkT+2ZZO/7h5gSdLLTLcl469JElvxTmP/FC?=
 =?us-ascii?Q?B85FO23yuuxlcOtDHG5+KXJMcguw+3Legv9hP0e2ysM8NK+sVoyow4TPxnB9?=
 =?us-ascii?Q?JxtsdIqnW3ZlRD4YNsgbLLCCTW2EqRiHiIm3z0lGlJyU72pqH5D+IG1/SuQx?=
 =?us-ascii?Q?AXDLaGtxc+/eL8t5vtDxocXzhyrnq3PyXT9X1PVp5BJ7BM9QbNZwH2NpGmB1?=
 =?us-ascii?Q?xFoJCkNQBuf7zeCH73qcYZ2w2kjPa9rnBuGQGrdoOB46fKTQq0W0EFVfucJA?=
 =?us-ascii?Q?zgyvV2/LaYVRUaz5SzKMpli4Nfl9Oz/4f2xkV000ddLJHBLHGaJzQD3lYk37?=
 =?us-ascii?Q?dljyefa3t1ejMtOnkuhaYyULDqOOWNu05UEXd+C8uqMgFKHsOXz7iU5WrZAT?=
 =?us-ascii?Q?rLXky8BWJCnIIFTlb17lhq2NnYXPKs+r/WM1D+SoDKUaL+4+EuYzTW9K+zBi?=
 =?us-ascii?Q?YTvSl6mIlEhXyRDCqzTJYG6onMJSV7OvZLwRnqGJmJwhRrkYb2mK0QecNkl+?=
 =?us-ascii?Q?u2EhM2gy70NFuM9Ae0Rs7dHkU9pautMuiPNgvJ+S12Xu3P4U+/kRQz2p4ub8?=
 =?us-ascii?Q?vqtW8BZ2TXwXnbliFa7eYLSBefT+6OXd6h37PDgG9tuZkKIvdVSqk+soMVE7?=
 =?us-ascii?Q?ng1uvt1PBNlKwDhLEcW+2QNpvDyR0a6A8fzQ3ntdH0GffhHtsFB2fiOWoO+T?=
 =?us-ascii?Q?WBlY05PBnlasu48h6bfbrcWDJMIbHvQF+WV31aRkxd9gcla3Csv2CO6p3col?=
 =?us-ascii?Q?9bM09dGju9Mk45XbLro0EynvnXqp/nRD5HrDW2kvT2SEMcwaIEX3TE4+cS4p?=
 =?us-ascii?Q?sE72TD0k+bd3B4GE+ZZjxJ+6nzbCVjnC91FgZvYwJa16phfklKzCrvrV0tUZ?=
 =?us-ascii?Q?NR+Cxw4vtxCUDwfBv6jbgA8nhe07xM1rvch1p+s5q3mAD592uAAdyDdxHQuD?=
 =?us-ascii?Q?AATmTO4TvzPMrR6I0m1EXpcPli0r2KvtLUbyDnuV4+NRuZ1wYw73GShdA9gX?=
 =?us-ascii?Q?QnZFMwhlpDffEBxus3NyHUi5EEp4DWqqrnwhwcufe/6uFw8ZR16Nd0+GWdME?=
 =?us-ascii?Q?k1TSP9q7y/Iyk9xTILCBDWriVEFcBiMiKMXDK8H1Ac9cGyLw1rTF58PStXcs?=
 =?us-ascii?Q?z2ZkLQICTrQIrW9vr/3tvjW+5zEnuZ+X+ESNs/Y7gw29ytQmiwOSe0ttj6N7?=
 =?us-ascii?Q?hJk28KY9HtB3cyLO2LRVDiE6h5FUlx+HFW4qWVamvZe6b4jfnThr6YKFE40r?=
 =?us-ascii?Q?UrIDWLlj0UNV72E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hGW9E9R95ixXogAQEUi8g7tIAh9IgdcxAPG6DrTAE58WG9ToTIoYzfTQzfG8?=
 =?us-ascii?Q?ueVDqSrEPW2kMd1MELFmmnYtbJlviRzrVoH4a05sp6KrtN1pMRcHw7PWgSQ0?=
 =?us-ascii?Q?oR35zIfmwishQNnvqZYtcfOMxunX+uI4u9uJ0VDTCazAr5xFBvfE43mI6Cfq?=
 =?us-ascii?Q?gzGtnnbE1gGpX5WbHFOHMO6f1riWeckaiyr0TuzSPfF9tTlSop7w/jpqutsa?=
 =?us-ascii?Q?lgFd5IZRYdUrLJu5W18hWw4kF5dmqBJXQf/JOCSyUzlv4JvTNgSLTo2r+O87?=
 =?us-ascii?Q?RPkY0blxpuKRa9Bkwe+50pOMNC3o9avGryIx6QT2gfvxGDbIXCKef+zrGRXC?=
 =?us-ascii?Q?pECnG8O9hhnQs0Xo2maWNB6n9vuGbeke8HFKSHpVyIwYyphvLUitX+35opMc?=
 =?us-ascii?Q?ClL95TNx72e8Kdh7GNHfGoMW6gubM5nbL8hb/UXV8Ym4BD4q+TbMhkEm/0Tf?=
 =?us-ascii?Q?zdJ9xJzq1HhJJQRQ6rPyy7bIAUZS7uM/Wx66zgCDQTxowvdQqoipq0gbZiWU?=
 =?us-ascii?Q?TG3xw0xv+eWM/+cUGRIXOlO4w+nZr7nDKADAb0eEcxQEF+nVZQyb/QTr3IPC?=
 =?us-ascii?Q?JOhRhHdjzfSZsQTxNTvm6Nl/EsLqMy/elrBlrESegQMWIapv8MGK0LuVosNc?=
 =?us-ascii?Q?1opi8f8JeYOkN/pZNNbPGMplobGSuypM71MLYLHZ2fBn/g1wh03RbyZqD9DR?=
 =?us-ascii?Q?SO4ZER7QdMhg2WilFXME6ZTiOXfV8Eyb32jb5aDSfB3D8bzVqHWvipxvu11d?=
 =?us-ascii?Q?qApqYdgByEXZgcWV6snUe36u1mV9Hms4zJmnYcBy6Lu/uywBt4QHpx7fVFpw?=
 =?us-ascii?Q?FUp/fUdcArVJVIYrqlzRQ+ed6xXVoowwrjrXLb5f/X/snABDactBidf90Jx+?=
 =?us-ascii?Q?c860eOZezIQt7xUPL/Owb/c5OlRGjZZuJXEiqc22pSiXBSHQ3jYhuPDjbrzr?=
 =?us-ascii?Q?9Wq+XYT7wWV1n6cRMrPJRzq7KkITOVJq1U/2L/IshpPzxCH0tfLU+iwX+Vqv?=
 =?us-ascii?Q?LnagQckqSmnQHZtYfsCE/jRKsSwHPeiuc31FdkSa6M8s4Y73wvZ6eaJf5ipb?=
 =?us-ascii?Q?48xkysxF4bIX2FxyshDoBSUSm9UzyRBhngDsB4GWALyrwJBW3TC3KTRsGMaw?=
 =?us-ascii?Q?ZbOBoP6eqyhS97g+utbvbl+qU9Cc4O+ACSCRRj6kDUfpUVT99cNYgft1N4el?=
 =?us-ascii?Q?+l3fEuN0HlonkMbb4WXaBf59kZ+tZC4/Mpo6P8kJ3HOdigypH5/PV2O6UV1q?=
 =?us-ascii?Q?b6+VZH+gKWR3mZ3LXG8yVyo8ZXmPzFeg5PnkEvLoTxKPpTdCHcEQMGezDa7t?=
 =?us-ascii?Q?t0d1cm5VsVom6ccz2o1TH0Y9Uzp+JVEYuyL4FBLhTc+4EIq2UnqnLPf7LQfe?=
 =?us-ascii?Q?sKtnFbrb32/rtwseLjMx1Z+6Liq5H+nQAGWGLpIZ801s1XvBfDoAJrhta2pk?=
 =?us-ascii?Q?pB2TtKe5xWTC64bmkTyBmuT8c9lPhTJhZgcF42LxGFPXbAVSSiPkkRX6regE?=
 =?us-ascii?Q?Es+SC0eKi+F3keUAR5823JnAiV2qvyXTtcCC2TNYOKP7dWDa70FtDe5lAoqB?=
 =?us-ascii?Q?I8sYEg4lRnORVtBNujM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0d52f2-3369-4c74-ef02-08ddb1f4c82e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 01:25:04.4846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIXuIvZwVjenyk4/cS7j0QYoD1sYL6lvlC14m3MSD451d0ZjwhGufr/YRlbLAVucT5sofpxgCKIUZI7Gs6LSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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

this serials is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, June 20, 2025 11:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/sdma7: add ucode version checks for userq s=
upport

SDMA 7.0.0/1: 7836028

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v7_0.c
index ad47d0bdf7775..86903eccbd4e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1349,9 +1349,15 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block =
*ip_block)
        else
                DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");

-       /* add firmware version checks here */
-       if (0 && !adev->sdma.disable_uq)
-               adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_funcs;
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+       case IP_VERSION(7, 0, 0):
+       case IP_VERSION(7, 0, 1):
+               if ((adev->sdma.instance[0].fw_version >=3D 7836028) && !ad=
ev->sdma.disable_uq)
+                       adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
+               break;
+       default:
+               break;
+       }

        return r;
 }
--
2.49.0


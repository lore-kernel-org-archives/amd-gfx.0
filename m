Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05450C28B2F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 02:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A9210E36B;
	Thu, 13 Mar 2025 02:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYgbc+V2";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E82810E1C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 02:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDrI2aVD78iBNLpmGCBsIj7BtjWyOA2Sm1WnS6BxwzBbPmg4Ir7yDZZ6/eqcZ+PfWeq7s18pdDhyg/APSOnAyWMTaH436FceCoE+DrR4whg0yyF0YiGhoMF/l4shZCS8oOjtZTTBv7n7CscB35C7J69gvFEjw3K1Oh8LZn4TUaOk8Xyrg0+NCOixJoGXMKpYZpyVYRJg4L48D1S/RwarMhwOvaFZaamqZsk3Xd849ZX+woBHbrJ/GvlyEkjLMO82i2Ec5V/W6VTij2F4S7oUIEtixgcywcUXtJ0J+N/hILkLD7UKT3qwsD+lZ9xPoEgjwPZ+UKLQLBIFfA1pksKxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ5NDM9w0YQMOv3OKXqE18jVm/DgshcUMto3zWhkq/0=;
 b=T1gxbba0kuhOijQzVzMHMJiBfQymP3F2s5ob3Zywbe5lefW7/pMFs+WHAWrxBqbH46pjfnHaSkgqr2WGQqQIrwVDtEMgkxBl9nvDb8riAQjM4INiS9p9QuOvQq17VxlxD0shOnSRZ9i2Ylf9CqzvP9d6kS9AaEaBtxkbKVaM8v601w/gYqrDNQzrpmqgh3KpJ9pl1j/XPOPGV7PY9ml2J3E9AKP25fCEY13W8wDDEkIQCKBu0IzH96IoTqo3amg15lMFJVq6ERxStd1bzGBPKGs1ENjbQR2EM52WpaqbACw7veiER7vfOOThSXVM/fMSoUNlVUsCwShoq1Kp7zFZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ5NDM9w0YQMOv3OKXqE18jVm/DgshcUMto3zWhkq/0=;
 b=aYgbc+V2ONz08AHgwpaMTpIMeI5X3gz5yW7yVnjcDgSYCY80fI7PUjzgiBhaxMaGIbnbN5gbWyRP4nTZr13GVIbCsE32kCQ0ONt4cWqMDPKrTjEqmS/qklFRwuitTsBYYhdVAnnmlsFkekr5GVpFyeWkSIau6GK8wWElraJkPO8=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 02:40:24 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 02:40:23 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lin, Amber" <Amber.Lin@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Correct F8_MODE for gfx950
Thread-Topic: [PATCH] drm/amdkfd: Correct F8_MODE for gfx950
Thread-Index: AQHbk7jMkKd6RSQ27kmHNuV4bVUkHrNwWtKs
Date: Thu, 13 Mar 2025 02:40:23 +0000
Message-ID: <CY8PR12MB7099C9DFD42F96A392EF41038CD32@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250313013921.63647-1-Amber.Lin@amd.com>
In-Reply-To: <20250313013921.63647-1-Amber.Lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T02:39:24.5630624Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|PH8PR12MB6772:EE_
x-ms-office365-filtering-correlation-id: b73c8e0b-329d-4e34-dfc0-08dd61d8678a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?e5fsndO1R4ehFKbsXpQRZ3OqZAfWVJ5EporSgdfu9z2856MLSMQL6bT1BD+E?=
 =?us-ascii?Q?c64rHV/3F2Do+IsmxW2bedc7/k1BzkefEG2mk9s63LDWfzKIJNOod9AOBquy?=
 =?us-ascii?Q?xCxZta7vtTBBIAAPidQkCgrFR9iUZFZA5aMy9krnxXfR9pYhoaD7d2XIDLEO?=
 =?us-ascii?Q?mGp/Gbck35GtcBGizkSylFLoRZK3LV4yjTmyNBpjdrKWBFxWSKDKLyUSc8SO?=
 =?us-ascii?Q?bcC3yPJ0eUT3PhsnMrRrjt7dcWhCTSulGCCgEFsLISlJX3yxNRdGfy03NqlK?=
 =?us-ascii?Q?SGqxsbW04kABi/R0fS041lrs6VQzaxtqyCRtJ93eAiegGhkbXs0DDlez3hIQ?=
 =?us-ascii?Q?VcYmMf/pCkrjiGEIYjoxkC7Mlosys/BjQr9slByR1HCOph5q0xO5r12CT1ZN?=
 =?us-ascii?Q?/h+WFw2V6CSfAT9lS//YxKAxxn2d9gjsTWwzAjVqfcJdIlnSnUamZ99MOuqb?=
 =?us-ascii?Q?u7v5uniDf75+f+yeQ7u769Dv2+48qGtM7oa0BwvFicetPt+99MKhc5H14zUx?=
 =?us-ascii?Q?VCMyDuh4ADB9YiGKOx9V0aHzSw2MM5+m6ARAQ0fxeNr7q85V6CSCu6SkpId2?=
 =?us-ascii?Q?8jpSniMyGUH9f8tpTes7/+vq4/U9hjKG1NDKDAEwZ1vWzPUxiqr01CJ3ToPf?=
 =?us-ascii?Q?I9wpclqBa2NuCt/Qp7G0yFAdvqXri9PVaMHlZkP6Q8WVjbcIGQLucH9ums3w?=
 =?us-ascii?Q?eH/BpeTskFoJ6iyIs0C5w7mihVEGaLVrV0GlfNVf/x7PwMJoj3H1/xVMFDzN?=
 =?us-ascii?Q?DvO0nFgF1rNHw343uGAquzzknEEKgYylG1lPF1vmXtOzZ2vO694PRwBZEeic?=
 =?us-ascii?Q?hNII5Rh72n8Bv4/IobQFI8zG6bZ6fwqQCFHdGe76NadRQ0AswY82Qt/TH0Zz?=
 =?us-ascii?Q?tGHjU5yGrF5Z8Vk2dMHFDXGqyOJi3812AoiTQD3GNsRH4/DQ7u5caKxwX1K+?=
 =?us-ascii?Q?Qh8HyVugtK/p6sel9eMRsTtR+Qc6CXdC9uSGAYMb6AKYtJHizcPiNaefvIpB?=
 =?us-ascii?Q?w4PalqNMnLrpSpblE09u1kf/wj0qKpoh7uMhAWRyZ97e1cU9BtEbg+4qJ3nO?=
 =?us-ascii?Q?xXQtpszOsEOqj3PD09R9ftX/vvl57UGlBlTb9rGreTOUOJUjc9LbWHgGk66f?=
 =?us-ascii?Q?bkNOz2tlKbIsjqBSxDciLivooqomQYR7AzmJQuya+nxp5kkYJjQQWIahLqcn?=
 =?us-ascii?Q?VHtPTdvOOnMtynxAZKRj+Z1bxTFM6vV2qtaUJM9DhaVdLYY0ZEDcbDW6wTHN?=
 =?us-ascii?Q?zbu1wfheiNSsn1ytWargWmqL7OyFiMqNLzy9rzyUIJHOQfkZ/XIHmB7XEuHk?=
 =?us-ascii?Q?Ne0RSe75w3uFr6qS1VAnzjhyCtChLYuhLyYMd/hoZRCrrbtc5v8ddOmWE55d?=
 =?us-ascii?Q?P/2acyLbd4Vqzk0g5Md6wvYx1jPX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CGZhMPPOmFCdcg5NpX7zEla7KaKiIOjl+7XRCGhh9Dta2EJkId7nlzkQ9a/i?=
 =?us-ascii?Q?JmujCJp8tnCgeaipNixXiHd0+9gmpnyRCpCYxPjLHC0SCiXt635TULpdzL9k?=
 =?us-ascii?Q?yiZDpoSkDwK4Q6zcCr01XI1khkQ56pG2dr74swmN5uF+YNdm2+5743fzfdSE?=
 =?us-ascii?Q?YRy7LpQ2UlGfHUIJIVq8kSvHcVHM/eDRhtI4SD/SFnOr1Q5DkKZVcpEGWPnk?=
 =?us-ascii?Q?0qEnJYWIeAUykFEAJMKK+w8Qk0X6vBv0beuW3g8ibWRBJSDs/euFQJ57AIDl?=
 =?us-ascii?Q?0iNd8vV14oaEdZDPwsrnueUDRuP3NFZXODjUf8p/IF01tzZs6HT1/d1KG7py?=
 =?us-ascii?Q?IwqAzlD+y8uKiZeOHRXh5+59OcqxZjWysEjE1L944QaYCOigh5NAl5VajklX?=
 =?us-ascii?Q?r8qZ21y2yTvxD2RcMXW4dc92KkqcYM0Bg7p+ggBIrADUsfZ/lViDVZ9+2xHk?=
 =?us-ascii?Q?546BIz9sWONfu6HNVPHlLH69fGVJ0Vr0WIbLUY8I+W7cXvImb3ddOo47Detr?=
 =?us-ascii?Q?PtgcrjIfyjS3Zzn9+PCFTEslt7SsEJd8FsHYhruS3oTjRuLp5AnkseO8GYm0?=
 =?us-ascii?Q?1DfKBLfYaSxY3BuZjrD26HXZESEL10yzFu4UdiTF1oU75Dj18eE/Gg+vs7ZV?=
 =?us-ascii?Q?kLB7q5AE6sGVOtmTCRAnl5Lw2nEBfBIHyDEvPBC+OO6NAGONyLgq2H96sLfe?=
 =?us-ascii?Q?D35T5jRZup6iSvr1JGV611mdhBMawA67aN8GRTJo4okYeU8tRN4MLqmPMygs?=
 =?us-ascii?Q?/tw0K54vEKQuduVo5LUd9XuQNUE/XzNhoiL4gkQRQwqFsz9o0DQbb1fqFpUX?=
 =?us-ascii?Q?GTCvs7I8U5EjB1xzc4IctUe1vbrStrPnZ8Ge1hmkMqp7PHVKHgyjLx+sp+eo?=
 =?us-ascii?Q?FD1M/Sx1PP4isK9Api6ljR4ioNsuhFoOISQ0FoRobXZNPvIkSlCs1AAeuJ3g?=
 =?us-ascii?Q?vN9W27I65xx+JaYimwllwqIgyChiJP4RbNz+zvVN8jv1SSc11B0ajW9NC5mj?=
 =?us-ascii?Q?MnM86tnIknkVSCuxuSSu0lcuy/KbgVYWDHLeYvhXKVTCOaoAmypLNd3NMDKQ?=
 =?us-ascii?Q?sx3+83gkPjxECub99SeiwOplmyq2aSpsNixcNVKmeKlEvzLPGRXZIKZiVJc5?=
 =?us-ascii?Q?VLlEzpsP0UHxIOYYVyjvDgJz1s5E/n3pvdkWrGhlmvXD+czGXGATA2PPCLu4?=
 =?us-ascii?Q?iUmnEBqzXpnzw4cYYeAut/JxLRajepfIlMVxAtb8U8x+rt1NMGpzqUclc+Gc?=
 =?us-ascii?Q?XctREfM5mzLe+ividXFH+Ero9GyEQN3G/0px45qyQIxsA5hTlLFhpBSKKUPH?=
 =?us-ascii?Q?9ve0tSCCDmpNYT/xWTZag07xhSlxkFvZwxsQ1iMHzx49x3jHSh2O7AxojEdp?=
 =?us-ascii?Q?FwSydeeN3OJ17j0/yjHvXrSyi2Nu702wDeRyHzC8pYWgQHcZ1461bF6XWV3W?=
 =?us-ascii?Q?khrc16DHkSYlYlzAx4HDyyGC8VxO+2E/j3ETq1GNz/uhN/X1dnCYATBdqxi6?=
 =?us-ascii?Q?hylmRDWLsopT/YyWnTxWQgdI11JhCoR8FH52V5Siqb4pULE90h2KhO/7TITw?=
 =?us-ascii?Q?stVvlCkB7FxSjR+mPxVNd+tAOW27mnsDr7/zAZTG?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB7099C9DFD42F96A392EF41038CD32CY8PR12MB7099namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73c8e0b-329d-4e34-dfc0-08dd61d8678a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 02:40:23.3859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pI3zLrug1QKu9Zv8Y9+pulsn5V2lL8irSGx6u3LBTH0kdvRO1udfYOEIaYsI9bDM1FrtgTVqKBqCgxpO83YRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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

--_000_CY8PR12MB7099C9DFD42F96A392EF41038CD32CY8PR12MB7099namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviwanathan@amd.com


Get Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Lin, Amber <Amber.Lin@amd.com>
Sent: Wednesday, March 12, 2025 9:39:21 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Lin, Amber <A=
mber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Correct F8_MODE for gfx950

Correct F8_MODE setting for gfx950 that was removed

Fixes: 1a9dbc31d234

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index d794c8172b40..9fcc8c6e57b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -71,8 +71,7 @@ static bool set_cache_memory_policy_v9(struct device_queu=
e_manager *dqm,
                 qpd->sh_mem_config |=3D 1 << SH_MEM_CONFIG__RETRY_DISABLE_=
_SHIFT;

         if (KFD_GC_VERSION(dqm->dev->kfd) =3D=3D IP_VERSION(9, 4, 3) ||
-               KFD_GC_VERSION(dqm->dev->kfd) =3D=3D IP_VERSION(9, 4, 4) ||
-               KFD_GC_VERSION(dqm->dev->kfd) =3D=3D IP_VERSION(9, 5, 0))
+               KFD_GC_VERSION(dqm->dev->kfd) =3D=3D IP_VERSION(9, 4, 4))
                 qpd->sh_mem_config |=3D (1 << SH_MEM_CONFIG__F8_MODE__SHIF=
T);

         if (KFD_GC_VERSION(dqm->dev->kfd) =3D=3D IP_VERSION(9, 5, 0)) {
--
2.34.1


--_000_CY8PR12MB7099C9DFD42F96A392EF41038CD32CY8PR12MB7099namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto">Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviwana=
than@amd.com</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
<div dir=3D"auto"><br>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Get <a href=3D"https:/=
/aka.ms/AAb9ysg">
Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lin, Amber &lt;Amber.=
Lin@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 12, 2025 9:39:21 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; =
Lin, Amber &lt;Amber.Lin@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Correct F8_MODE for gfx950</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Correct F8_MODE setting for gfx950 that was remove=
d<br>
<br>
Fixes: 1a9dbc31d234<br>
<br>
Signed-off-by: Amber Lin &lt;Amber.Lin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c | 3 +--<br>
&nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c<br>
index d794c8172b40..9fcc8c6e57b7 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c<br>
@@ -71,8 +71,7 @@ static bool set_cache_memory_policy_v9(struct device_queu=
e_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; qpd-&gt;sh_mem_config |=3D 1 &lt;&lt; SH_MEM_CONFIG__=
RETRY_DISABLE__SHIFT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_GC_VERSION(dqm-&gt=
;dev-&gt;kfd) =3D=3D IP_VERSION(9, 4, 3) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; KFD_GC_VERSION(dqm-&gt;dev-&gt;kfd) =3D=3D IP_VERSION(9, 4, 4) |=
|<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; KFD_GC_VERSION(dqm-&gt;dev-&gt;kfd) =3D=3D IP_VERSION(9, 5, 0))<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; KFD_GC_VERSION(dqm-&gt;dev-&gt;kfd) =3D=3D IP_VERSION(9, 4, 4))<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; qpd-&gt;sh_mem_config |=3D (1 &lt;&lt; SH_MEM_CONFIG_=
_F8_MODE__SHIFT);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_GC_VERSION(dqm-&gt=
;dev-&gt;kfd) =3D=3D IP_VERSION(9, 5, 0)) {<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY8PR12MB7099C9DFD42F96A392EF41038CD32CY8PR12MB7099namp_--

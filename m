Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE8EC3ABBE
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 02:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3821F10E0E9;
	Fri,  9 May 2025 02:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hrfQAXEM";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02A210E0E9
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 02:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMyNU2Ogp6uzZREgsrlGsVzTEXDorP4hCc7S9qU/YXgC0HO6bLyTpjfE05K+lCVgi96eh+6cgqtqktqwJZOfXi3JDNBcXbBrl23u6vt3DoOWB4Cst1j2wF2vBNAP1gKr+PLIvjkd/nWVw/e7c4Kv2qe1lbr37Ik7ddMt5ErlVrk1NGbxfq/a7qTObfeyn3k9i7koy4Ny2ybup0A99mbH1TZxUW+hzyDs10Us1YHywyP7P+GO7ns1qX+YG2hAy/t++S56PGCwpy83a343NO2+oWiwZv2NmlCyFU8k6zow4y66U5mWAkpAlIpvSmUdL2zi4oXoVyLFziqEBMb1/kgYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+bndoCaDa2fl7L3sOIL77TtKDySU6KnxPT9Sq/SEH8=;
 b=kKhKLfvHKSq38oWJPuyn2zynjoZLOgN+dqi1bhxx6tUvDIOuVLctxTxjaXAU4KMTC6reiPTdWfXUN3jJU4bgBW5It9gIkzxzvtBL1AfuvMz7ycRXUqD8RVbf/6uQtpHVIRKrnU3tzq89LlT9/U0X1d570QO6R6idLeP4iedVwWy+eZSmtsaFBrldPtmNAqPdwRfk8poKIaC2L3GCPQiVJLjfndDH7pyt0bsVCavQhce070BLnwZ0DZvpU8jED2VAxOEmeBBm4P71fg/Sz8j1cfT4jRNmCHdQU+xZB1n/4YYyeVBDNyyL9jbKnHOOPBFrUcnDcSzJ2AVJYsbNJKntkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+bndoCaDa2fl7L3sOIL77TtKDySU6KnxPT9Sq/SEH8=;
 b=hrfQAXEM2Py9TmOXQV28YdJMYX8/99ItoYjXT4XgonoTf3CHaOqTIEpi7X/sYhaRcI2xZunb6328VMiAbA8U0bXj6xEdNMjJYZXpLR9k8i0VGutwYOYWtN6EIXaS3l6DcMPg9w6kyLzhJY5sIHSb4Wdv3AnuosWkQ9wn5XeMLwk=
Received: from IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5)
 by BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 02:03:20 +0000
Received: from IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::79e7:c0ff:6ff8:3b30]) by IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::79e7:c0ff:6ff8:3b30%6]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 02:03:19 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect MALL size for GFX1151
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect MALL size for GFX1151
Thread-Index: AQHbv+sp3EP47N0s+k6agIaJWeRj0bPJjQuQ
Date: Fri, 9 May 2025 02:03:19 +0000
Message-ID: <IA1PR12MB63564F6B79F07222DD159E74C18AA@IA1PR12MB6356.namprd12.prod.outlook.com>
References: <20250508073000.1172588-1-tim.huang@amd.com>
In-Reply-To: <20250508073000.1172588-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=07f12d5b-3856-488e-8042-9c941b36eb4b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-09T02:02:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6356:EE_|BN5PR12MB9509:EE_
x-ms-office365-filtering-correlation-id: 83c2ee4d-22a6-44e7-df05-08dd8e9dabc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UWsnyV4j6GbH/SVm16l01wN5x4CNSvIaQx+M0PdCFwTZ48lvYWKwZYnEeYme?=
 =?us-ascii?Q?8KOVqwoh32GX/lkWKJQbqfTCqxKvX6icTBfzb1DFA7jcLVxBLw3RKVv2ZC88?=
 =?us-ascii?Q?RX1dZU45L+cjn4cnoVRXPx4cBsO+NlN5Q2JWrkjnzdkbHOal0Zj5gAV4qwPU?=
 =?us-ascii?Q?XSpBFL7NKTSQ8GNzGHKQqyJxF48cPgXH+kTEQR3zCG1hRixIeEH5UHSY1CTX?=
 =?us-ascii?Q?/3vyBYwIH5TbBWadVgavIr5MNuXOjZQ2XKcBGYWC2LcTZKN9VFkR1soCw/os?=
 =?us-ascii?Q?hvJYzyb839u8kJh5g8Ng/NsLKBrhDBq5RK2guF9CqFSF8GN632ZOw5Yz7xmz?=
 =?us-ascii?Q?5fSw1b4ZFYLBrCP//MKHMeBNmc+27B8rzbBK8NgYka/F+ltw64D3u/LG+Jk2?=
 =?us-ascii?Q?eFHs5nvLLVNjHyr0ycx+U5LSKeZ3QesI8DcbA8E7MxfWyZFG4838/n9fyYa4?=
 =?us-ascii?Q?nDzegUFvV+CKEYxia3uuKB9T2wLUFmchRk9QMzNeGc4Ry8xzqpzO+zRdYYXA?=
 =?us-ascii?Q?+PD+jp3KIe9R7DdCX+nyyPShjkWUMDUIvf+lPWURtbJQpMsqV2qe+mOt0rsX?=
 =?us-ascii?Q?2d4/cu0dbrc3O99oYE6SszUp1sPrCTe79bFfkasEojBvT7f8uuBWBMW8GW9K?=
 =?us-ascii?Q?R9PnKUgKwxmIfHM9YMQi39c5x/C9Y46C0iqsQJ2RN3rsPSYzz8pNKTn3azWq?=
 =?us-ascii?Q?4IKFmAhwmVq34Tu8UgB2gaJwYE5rfXSZSZdWaKgS6p5yJ0TZysOA7EyBytmv?=
 =?us-ascii?Q?8IfKJvVaoIV3u9ss1W2jp8vzIvTZU/4cNkU2g/osnUwr7RWR5cDqiljv0cTe?=
 =?us-ascii?Q?gI012mOacw+IT1J0GGecW4QQQHYkPhyPcddS/XxrNCHEqNFXDWNvKvwO08N4?=
 =?us-ascii?Q?KmcG0tkKMXjRLu9WltET1m0fKdfpSc7jNwX54c3pbOuHxIgjLqRs3oQJYWRn?=
 =?us-ascii?Q?rNGZk183hWTakI0DJ+HBwkHuTJf49sTDR5Ve4EpNe/i9SHj+nmmGNeaf0lCt?=
 =?us-ascii?Q?ownOITHu9C0dWwlAYdE3S61P4AZmHE095EjvnIjZT4PZX69FP5C+WKPlbEvA?=
 =?us-ascii?Q?1vstpzslqzkEURFHKipCCxrvR88YG8cIGMtcekPsjleYihsWRYTi08hutgBH?=
 =?us-ascii?Q?FXel+RnV3UrOLkY1rDAAIY1ysFNKy7fk+pdPwEDiVP5ARSnAi/d9Ms8qUKWY?=
 =?us-ascii?Q?oQ/24Y4AVqE8sVOVuz2P7yrFzZLPZjaqkv8JVPz4EI5M48JTwZN0+tYTJ2ye?=
 =?us-ascii?Q?9ckKlTUvAdYS5UBROGc/qQ0r+cIkF7kUJKj5WQpm7DnnZ8BiUtKy8OugwIFD?=
 =?us-ascii?Q?OpbR/kIvQJNoKXDMEtr22/Wt7otsh9aMrzvUoWTzAy8FDDrO/aaFItKWMg8l?=
 =?us-ascii?Q?CW6aea6A88C8dF1CCN36RPqlCUwzMa6oBF5ej79zM61QiYtqxfbVTmoCR0R7?=
 =?us-ascii?Q?esQygkaoDfvrwcfDF9B1EeRdShKtfaPMo2IKuGtquENAhWqIs4EqQA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3HZJmiU+K7dL1arSbdJMQa4rOv6UmkofWcDbImtv3wTfXFCi2UL25megEdyw?=
 =?us-ascii?Q?z82ZEvPcmPvt3hO5x/yaxs7Y8KTWGX6vdZ1Q9UGd0Ki94J37heRc8M4xbYgD?=
 =?us-ascii?Q?FetNo2VB4jS1zfdwTgJsoDumOp7vjUKAD8EWvqmpch5snZAXuzAabg99bMVu?=
 =?us-ascii?Q?UzTEfk7gPp//7c4918G6xVdCxfRQC/BVQg8Q6LQjPsMrhW2fiPRJxeinvUg5?=
 =?us-ascii?Q?AvhEdgpAlIercxB7Sq/HE1V+r2ESxB0Tw6cavu1Bsh5L5RBTDVO0FfnG+Fxj?=
 =?us-ascii?Q?YSe2vSE6lmEzBKnC8MKM3WF8Ate4Q43GB+jXMstAfE69a8kYrHlM5nIkyjgs?=
 =?us-ascii?Q?Wf6Gw8j3LjAVFv8SVn1fx3JfCSZqRZQhxYCYg1LLHxdu2Ceygf7Kvv6nk7bV?=
 =?us-ascii?Q?azVjDirl3YGvpP3ndXgsGcqjhJfahG78HLSLtRHLHlbkGWxQurkuigcFB8wj?=
 =?us-ascii?Q?L25A5JYZZQ7JhjOjWy9T0x45mLQad1cCsEZIltFNsWBVucVf5e3tvvN1i+Nr?=
 =?us-ascii?Q?vmJkAElTPkjZuF3fkuMEAy9nAojwVBsDevgOJodfJ/6t6YqttSv6QMR8VhnO?=
 =?us-ascii?Q?vzYSl53IxNZGzx0/FtRcQm7z4W1W2YqoaJGIIneZln8kX4OPUVGNQK4UPbYQ?=
 =?us-ascii?Q?sXNyW7OLq8ek+1QwVrULSl9lCTTITSu5tmpGgAxTX3yFZf+CA7nJpL4s+SJo?=
 =?us-ascii?Q?NbbHWhvBFamsHFI3E7NRzGyodhP5xvz+BJ1lDTSBIs41alH3BuDAkTNkf7Ss?=
 =?us-ascii?Q?0mUpUTPCXfuTi6pKPNowJcq3kQeDe5A6TJC/qjaXi+TrF+nygc3gkst341ma?=
 =?us-ascii?Q?M6ead3i7SvSD13vMdH8loBtkNFDUAPPz0tDlWj3v6eCgLFlG5oKWY+fd11EQ?=
 =?us-ascii?Q?0MiuXqZ/ho1UwJZlOVPm3PwQCOGpFAGj1aqOiZUDzKI/YA4kw1Ek6niJiR1I?=
 =?us-ascii?Q?62rL9B679RXICeL5ob+6U8QJ+bBj6doOqb2mu4uSDD5vlBHP4fEh2/UFcj5p?=
 =?us-ascii?Q?VODXkxvRlSZiuVM2YvSLiaAgdtCv7no8k1GFjfrvTJ6jD2P6XZ8M2AGII1vy?=
 =?us-ascii?Q?dfqS9IAQgBMVhHZPV/2SEy16UEn8tA+2VxOzh12jzCh8kFNmkBzR7lJQxBUv?=
 =?us-ascii?Q?wXw8/va9BfAdZc3ESNDkFIH7SpDoYY6lSx0VCwDl0Lj2OSmsljlE9N2t58j0?=
 =?us-ascii?Q?e7ANe+XvbVXn1CZRDZhTZCClH48HvRPNu0lAeeR+mGkSDkxNFPS3RajUz54b?=
 =?us-ascii?Q?pqg670ixmtRQ7M0RTdrXF93WxNQ4vpeLJ8u7A5TH817UhNz68Lc6AnliXr5a?=
 =?us-ascii?Q?zWjQDhEhZgPeQmyWDFiLHI710Sm6M+l39CZJERUL955GdR3eXWE3K1uis9Ji?=
 =?us-ascii?Q?TW6glGxMa4i9Et74aCoJ4nIj8drdvm79TXIlvfeOOprSULKkbpfq9plPKKSZ?=
 =?us-ascii?Q?n3/GD2OkiJBLi22egZF3J1wvtB2Gvlqc7j5+GdC8s+FCLLKxOqBpcrZYZTns?=
 =?us-ascii?Q?oudQO696AK4HRK4+hOwVj/LxRuM5Ceu6se4ZBs/QunMj+nakxHPG5sYbHs55?=
 =?us-ascii?Q?YfwDfWo8QPUnZT1QRM8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c2ee4d-22a6-44e7-df05-08dd8e9dabc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 02:03:19.8271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Oojk6jmtSPPEqUKWyTvLH/F0D4dkOWvAQbtlwBFCoJAkR2sklyBoXaWu/E8Xoge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509
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

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>


-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Thursday, May 8, 2025 3:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix incorrect MALL size for GFX1151

On GFX1151, the reported MALL cache size reflects only half of its actual s=
ize; this adjustment corrects the discrepancy.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 917d894a1316..72211409227b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -748,6 +748,18 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *i=
p_block)
        adev->gmc.vram_type =3D vram_type;
        adev->gmc.vram_vendor =3D vram_vendor;

+       /* The mall_size is already calculated as mall_size_per_umc * num_u=
mc.
+        * However, for gfx1151, which features a 2-to-1 UMC mapping,
+        * the result must be multiplied by 2 to determine the actual mall =
size.
+        */
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+       case IP_VERSION(11, 5, 1):
+               adev->gmc.mall_size *=3D 2;
+               break;
+       default:
+               break;
+       }
+
        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
        case IP_VERSION(11, 0, 0):
        case IP_VERSION(11, 0, 1):
--
2.43.0


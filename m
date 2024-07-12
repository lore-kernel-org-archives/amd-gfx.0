Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE48EC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 11:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E61C10ECB8;
	Fri, 12 Jul 2024 11:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zMYRA5IF";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302CB10ECB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 11:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXnyOKJJt5sfyeFKAKlgKopBR5BG+NPlTOFGHXL6AdV4Nd+yyKypC8cKpbeRvFF+7Da/OWzS140JPoJOsiaDZx/eSGvwRO6zdY9ZaC0ayIHiNfmodgwCInQ1r0ZnMd21sx8AmAmkmvLzGyknYNsRpP1G5VHNagD6s8aZST4vTfQaHW7Zgj45jFXFB/jboP/dwDra+ZXfK9Ez3StBdVDWUzSusQld9IxoIQ1aFxGrMFQ196ZrWt6GLA2gvuALpXiS7tRxRtof8R8b2I8en+R9k9WLbjzDiFQUu9esylIipdpaU7cDCFYrtCs7ZZx6chkbewzhjNCe5VSRWkh+zZ/+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py3P524keQQoZTkgp8gOnK7T0QfqZyFX07YPNZ8hSWg=;
 b=p2ssjrkr6bgaN8ZwsQMDyo1wXzvXIVJAuV0qDLZ3NAOV0fzGW5b/adcjUaiqSrARs3QpKdDBfQJYMm1FPmekJtzm0Ha19Z97SRHKvfHKUm/2jmSomTouJPqC/5PWrNDQSEEWYa0pqptf+23E5/+s/7uebM9UAb1CpXWcsNaVNpbSoOkEtaQNGHbLdu7kHCjFWY0AMjiAcLGVKo+4oN1NksaTq6sUtorzGvdA0f2S9uewtkbyL1mrFNzBy+UZeC+BtMkvJf0nDOioHvG1jvM78HvxaoGE1jLU6PDHdWt6PEV9rHnij1RMALm1nen3Tj1cp7J30VlnSkYO6Q6kGPLp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py3P524keQQoZTkgp8gOnK7T0QfqZyFX07YPNZ8hSWg=;
 b=zMYRA5IFP14jXDiVXYyOEj/wjq7+Xm2NggxSijGe+LX7Mas6aO3fOmoJszJb5UuTbKVtIolGKRPVgNiXA4VKOcwNgIBGPfVqmmo6jgeiZAdbxZs4+BZ8Rg9UbtGcqCLLMdh3CDGKgS5Nj2cYjZyAqxdBFaVjIZyuNaxFkrl8Cfc=
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 11:54:35 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 11:54:35 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1 0/2] SDMA v5_2 ip dump support for devcoredump
Thread-Topic: [PATCH v1 0/2] SDMA v5_2 ip dump support for devcoredump
Thread-Index: AQHa1FIFYJxwKulPL02xeHCE0ZM5p7Hy+9dQ
Date: Fri, 12 Jul 2024 11:54:35 +0000
Message-ID: <PH7PR12MB559618164C3227B7918F711A93A62@PH7PR12MB5596.namprd12.prod.outlook.com>
References: <20240712115241.212758-1-sunil.khatri@amd.com>
In-Reply-To: <20240712115241.212758-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f89d528d-fd75-42cc-ac8d-0509dc3874ba;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-12T11:54:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5596:EE_|PH0PR12MB8099:EE_
x-ms-office365-filtering-correlation-id: 55dffa2a-a906-4f0c-c336-08dca269668a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NDDiGFAcF/xczCBEiF7VluZm5l4taIeZsreD3nSgUcbgJpaEcDdhphwFIPOs?=
 =?us-ascii?Q?69M3WiXtgszAcWiCknRWIbHVIxp4JkqzOq5QME6YLLMsyfpi1NW3ZKE5C7Yj?=
 =?us-ascii?Q?hlxXjgAlxvInHSLk3sJy1Zs+7x1Wc0X7J3q8W3Hwx02qYMjL2iiqtA79RcOR?=
 =?us-ascii?Q?k5tEeev2ifKUodP1Poyl7PNDErh6c8WdRiBuUHfApMEwB3BmzMpDi6MnIOQR?=
 =?us-ascii?Q?KPX2a1b9H8d7SlbHVnn0wy5HI61m/fNl4ri4M2kTmB9O0S0Dcksoxqve5AE0?=
 =?us-ascii?Q?CH4XfVjXg6+9Wiu2/O94LnzVpRhiCk8oMcwiOLB2utrP9cfKPho5HbiBOX8e?=
 =?us-ascii?Q?qU5Hjnu7Zd2MxjIOSPCvAee3v5cSGE5ypqag/TUcLb75c1TGPZya/Clj0VHX?=
 =?us-ascii?Q?YTVw+j57keV4nRU09tCeKEh9rCsa91oHlwwn3ElFSIauFy/IHYbmpW9GCIb6?=
 =?us-ascii?Q?okRPl27DjWv6C4cQAjnhuwu9qqr1W/H/MWTHcgHLDEYh5H9vJ6SiDv287E+T?=
 =?us-ascii?Q?hZi2d3L5ikAKH0U7lKnPFUmahAtPcvZjz4rB5gHa4ZJn1xivSKiUYUkwfkTf?=
 =?us-ascii?Q?wu8n5IoVgTJ19Wxb3BNoFJWHM3n6LofsnWy6U8VqFRoQSJCXkbYGA3L/2S67?=
 =?us-ascii?Q?NpWWks6JYDLQCuqSR+sKSWY0Y8mKDQVfHVz3j/xzTOUBXJOOvJhcw2SGa3xF?=
 =?us-ascii?Q?EOZtuJYh4EBzwTgPtB1jePDSt8yd6YjaAvM/cqwgTCLq2favdJd2kK0iuKCx?=
 =?us-ascii?Q?lH6V/L00sr7Hf5s7njYeVMaCk068C30nF5dYOVmFM9PzAx+yDQzTg6wV4cLm?=
 =?us-ascii?Q?lzRsGLH2D7+ebiKCaouedPE0v7rIQUsqTy6AR3pzoUcgptqDdQNcEohiHVKf?=
 =?us-ascii?Q?bUtHKrFo+HTUDOCAKgmQBajV1C6KBj6oW3i8ejOmGABnrwz6avmO+kiWxCk/?=
 =?us-ascii?Q?k5aAOaylqXsExamI52+Zf90SAaEOFYzvvtStgUqtiSRmQa3nCxqiFgtAWAo5?=
 =?us-ascii?Q?5E3is3lJS1redIzMTM+oX5AGv2+X3VPM9cBUl4GQmZUk89UK1yMf15dsBA7R?=
 =?us-ascii?Q?xSV4iIE1OtTAM/ma4BvsYeFfTNne0rG1NqeTyHmmKz4v+iAaipK8wXhNdrRa?=
 =?us-ascii?Q?rOo6DeqimSzRlCd2r6Am0Gqnphv6haA+KCjB1W+YBQRwRbvjhI9U1SA7u1HU?=
 =?us-ascii?Q?hvBZECJ6+j3xWSrgzJkHRBld5I6nuea4wC0pNdWNR4gqtD6UwWyPEnBAUBFz?=
 =?us-ascii?Q?IMeJ/dlJaKtvL2PyIGrkDm4PlEVdzjLimeHguaZo3BXoa6gebqtoEBIBve7v?=
 =?us-ascii?Q?OGTvlOO9dccnRpOpaR2kZqaU1QZ6WNolSshYmSvgjszkTQN7Dxc2uxqsmwBO?=
 =?us-ascii?Q?TPJICjn/YY1CukMGhTlHt+ozTBsvb2Isp/KwUDLrUWt3JAj0kA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i8Cju/b1MwYeNH3hN02ZM6gJbuWdVLQJQ5aEJLmcKHmi3S3XwL9Gm7k1gPOU?=
 =?us-ascii?Q?iZn/jdotookuufvyWBto8XE4BHcoaDyaUhGYINiwqA6XGuN2eDFa3QJRF5L2?=
 =?us-ascii?Q?2zEnpSsVZbWi6nbA/qqvvIpQ7RBkjXBy3ji/RQ7w8Hpcwzq8jiY3l8p3nLIq?=
 =?us-ascii?Q?abULVe/abH03fIqzR9Aw+qm1O1aXff6SvFOMa1/Vli1FAE6lLZNA83VwhBTV?=
 =?us-ascii?Q?xh2ofFyxTVzJjUTv+oSkiosbHDBmlB6gkrPUmjI+XQpDeWhWhnlCGoguwBnN?=
 =?us-ascii?Q?z0D/+Z2XWcPmz6+8f3a19G7zBppVbN6/hP9e7EPpmgNTSLy7GF+EHvZYwPXX?=
 =?us-ascii?Q?jSf39UZ+My+tHN9+tfcTlPYx8/nrJN8zLodtkYYXVhQQdejvxEuOCZhsmERy?=
 =?us-ascii?Q?CotxTrfMrL8fpqMW+HVeIqH0ohiruNJEyFwnVBrhVXHqJHPJW86LQDgcXtAl?=
 =?us-ascii?Q?8iaUX0j91rlGOD96vQXUt/U9Nvip+2cpFvI+o8g/dj6vLmEj+cC6szWq0Aqj?=
 =?us-ascii?Q?rAzV4aTggkggGwdcUhkU1wZ+ZNlbvmoEUZHbxIbN6nHnqSKxb6qek4MONGz3?=
 =?us-ascii?Q?HlNX4xYf3nh5mZ9RGYttNR3fF0UamRU5xt1Uoje+W8iT5sVlP2w9Hda+z9Xa?=
 =?us-ascii?Q?PaDP8+voqHhpK1vnfEe7B+OkoXmgXtQCiB25aa8YU7EefYUJV13JGzgFiTMh?=
 =?us-ascii?Q?f/GBadpRX9+p7yCfTZ5TFXkQ3IW9LRQxjVSVKkr1hrtC+u3vMnpkD1OkIMoQ?=
 =?us-ascii?Q?X/HS0Q3xBWf9+4m04JLsWIoDuTD2e2zqVxQZqNLD4kGsLdQU3jCxsu3wJjj2?=
 =?us-ascii?Q?/q7kXckkwKLoE/6XF5vVjazo02KFoQNp3Xv8S9kIZOqFWMfBFJlJ73gT51FX?=
 =?us-ascii?Q?QZqNXGu1fwLGtTwbCIz/wBTFwt+PwRoCfAoFK89rwLMOq43Loj2zmuhc9bdc?=
 =?us-ascii?Q?qFt1Qng2oHNUUWgg/nNKNuG50SXS11kDZbV4jzu5xaSbrhjSAgvzQJPKABEl?=
 =?us-ascii?Q?m3n1w9rqKKmuDGRmC2AmUsjoDKG5IVgeHtHMeWI2lnTJghOr82QklxuWG91c?=
 =?us-ascii?Q?4H6SbHrVd4hXCP1T7i12aZRCOBdYBduyNZAt5hopA1lZS0YPWLnuRBnTx5Bc?=
 =?us-ascii?Q?XxroMzt+KDVexQ69N8N6T48iDnGK1urZfud2qR2H4/T9Uxn6rsO64IMniH5j?=
 =?us-ascii?Q?Sk3K0Raf/EQOvktel+v11VxzaflGUGbrM5b/zjxeCrmkK/GcvaQ3aBbOpJAv?=
 =?us-ascii?Q?59EdVXd4X1dq853DXQjgopzFlC1u6oUytR5pgucTANI3otiDT1TBB0aWNO0a?=
 =?us-ascii?Q?Wf8HWOyhc8DFIcuqKIQudqbg4fUzPo15ADpsEMGqGWCTjyy1Y3Hik6a0n9G8?=
 =?us-ascii?Q?oFPZ1oSn4U9S0X7K59TR/FMGbQhDZLaNWDy7kUo7uipqdzYc3X13MvreqXBQ?=
 =?us-ascii?Q?c3D8ZmdJEkNiBDgpY11E8YPFvvXN70bRQPymyq/Q+p6/u4X7jxvzxd/9lLqu?=
 =?us-ascii?Q?/vuCZIVoh3dJgQ/+4UMZoby2JjsBQUVNwX4BB1z+cCTGZeCSjx4m+527UbGY?=
 =?us-ascii?Q?D+VyjQbHMk3a+6e2t2M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dffa2a-a906-4f0c-c336-08dca269668a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 11:54:35.4898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjTX55aRDEsmZYSdcqZoIAMV8O9z2NUcm4lOmAS/SCOU51Jw0HJjsrbZK2i3u9NWrmZjK40wG2mb6617+kml6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
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

Ignore Plz

-----Original Message-----
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Friday, July 12, 2024 5:23 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
Subject: [PATCH v1 0/2] SDMA v5_2 ip dump support for devcoredump

Sample output:
IP: sdma_v5_2
num_instances:2

Instance:0
mmSDMA0_STATUS_REG                                       0x46deed57
mmSDMA0_STATUS1_REG                                      0x000003ff
mmSDMA0_STATUS2_REG                                      0x00003f20
mmSDMA0_STATUS3_REG                                      0x03f60000
mmSDMA0_UCODE_CHECKSUM                                   0x716360f5
mmSDMA0_RB_RPTR_FETCH_HI                                 0x00000000
mmSDMA0_RB_RPTR_FETCH                                    0x00004980
mmSDMA0_UTCL1_RD_STATUS                                  0x01891555
mmSDMA0_UTCL1_WR_STATUS                                  0x51811555
mmSDMA0_UTCL1_RD_XNACK0                                  0x00155828
mmSDMA0_UTCL1_RD_XNACK1                                  0x02a6a700
mmSDMA0_UTCL1_WR_XNACK0                                  0x00111558
mmSDMA0_UTCL1_WR_XNACK1                                  0x01c1c100
mmSDMA0_GFX_RB_CNTL                                      0x80871016
mmSDMA0_GFX_RB_RPTR                                      0x00004980
mmSDMA0_GFX_RB_RPTR_HI                                   0x00000000
mmSDMA0_GFX_RB_WPTR                                      0x00004980
mmSDMA0_GFX_RB_WPTR_HI                                   0x00000000
mmSDMA0_GFX_IB_OFFSET                                    0x00000000
mmSDMA0_GFX_IB_BASE_LO                                   0x00928600
mmSDMA0_GFX_IB_BASE_HI                                   0x00000000
mmSDMA0_GFX_IB_CNTL                                      0x00000100
mmSDMA0_GFX_IB_RPTR                                      0x000001a0
mmSDMA0_GFX_IB_SUB_REMAIN                                0x00000000
mmSDMA0_GFX_DUMMY_REG                                    0x000000af
mmSDMA0_PAGE_RB_CNTL                                     0x80870000
mmSDMA0_PAGE_RB_RPTR                                     0x00000000
mmSDMA0_PAGE_RB_RPTR_HI                                  0x00000000
mmSDMA0_PAGE_RB_WPTR                                     0x00000000
mmSDMA0_PAGE_RB_WPTR_HI                                  0x00000000
mmSDMA0_PAGE_IB_OFFSET                                   0x00000000
mmSDMA0_PAGE_IB_BASE_LO                                  0x00000000
mmSDMA0_PAGE_IB_BASE_HI                                  0x00000000
mmSDMA0_PAGE_DUMMY_REG                                   0x0000000f
mmSDMA0_RLC0_RB_CNTL                                     0x80070000
mmSDMA0_RLC0_RB_RPTR                                     0x00000000
mmSDMA0_RLC0_RB_RPTR_HI                                  0x00000000
mmSDMA0_RLC0_RB_WPTR                                     0x00000000
mmSDMA0_RLC0_RB_WPTR_HI                                  0x00000000
mmSDMA0_RLC0_IB_OFFSET                                   0x00000000
mmSDMA0_RLC0_IB_BASE_LO                                  0x00000000
mmSDMA0_RLC0_IB_BASE_HI                                  0x00000000
mmSDMA0_RLC0_DUMMY_REG                                   0x0000000f
mmSDMA0_INT_STATUS                                       0x000000e0
mmSDMA0_VM_CNTL                                          0xffffffff
mmGRBM_STATUS2                                           0x54000008

Instance:1
mmSDMA0_STATUS_REG                                       0x46deed57
mmSDMA0_STATUS1_REG                                      0x000003ff
mmSDMA0_STATUS2_REG                                      0x000043ad
mmSDMA0_STATUS3_REG                                      0x03f60000
mmSDMA0_UCODE_CHECKSUM                                   0x716360f5
mmSDMA0_RB_RPTR_FETCH_HI                                 0x00000000
mmSDMA0_RB_RPTR_FETCH                                    0x00003d00
mmSDMA0_UTCL1_RD_STATUS                                  0x01891555
mmSDMA0_UTCL1_WR_STATUS                                  0x51811555
mmSDMA0_UTCL1_RD_XNACK0                                  0x00155827
mmSDMA0_UTCL1_RD_XNACK1                                  0x021a1b00
mmSDMA0_UTCL1_WR_XNACK0                                  0x00111558
mmSDMA0_UTCL1_WR_XNACK1                                  0x01656500
mmSDMA0_GFX_RB_CNTL                                      0x80871016
mmSDMA0_GFX_RB_RPTR                                      0x00003d00
mmSDMA0_GFX_RB_RPTR_HI                                   0x00000000
mmSDMA0_GFX_RB_WPTR                                      0x00003d00
mmSDMA0_GFX_RB_WPTR_HI                                   0x00000000
mmSDMA0_GFX_IB_OFFSET                                    0x00000000
mmSDMA0_GFX_IB_BASE_LO                                   0x00927200
mmSDMA0_GFX_IB_BASE_HI                                   0x00000000
mmSDMA0_GFX_IB_CNTL                                      0x00000100
mmSDMA0_GFX_IB_RPTR                                      0x000001a0
mmSDMA0_GFX_IB_SUB_REMAIN                                0x00000000
mmSDMA0_GFX_DUMMY_REG                                    0x000000af
mmSDMA0_PAGE_RB_CNTL                                     0x80870000
mmSDMA0_PAGE_RB_RPTR                                     0x00000000
mmSDMA0_PAGE_RB_RPTR_HI                                  0x00000000
mmSDMA0_PAGE_RB_WPTR                                     0x00000000
mmSDMA0_PAGE_RB_WPTR_HI                                  0x00000000
mmSDMA0_PAGE_IB_OFFSET                                   0x00000000
mmSDMA0_PAGE_IB_BASE_LO                                  0x00000000
mmSDMA0_PAGE_IB_BASE_HI                                  0x00000000
mmSDMA0_PAGE_DUMMY_REG                                   0x0000000f
mmSDMA0_RLC0_RB_CNTL                                     0x80070000
mmSDMA0_RLC0_RB_RPTR                                     0x00000000
mmSDMA0_RLC0_RB_RPTR_HI                                  0x00000000
mmSDMA0_RLC0_RB_WPTR                                     0x00000000
mmSDMA0_RLC0_RB_WPTR_HI                                  0x00000000
mmSDMA0_RLC0_IB_OFFSET                                   0x00000000
mmSDMA0_RLC0_IB_BASE_LO                                  0x00000000
mmSDMA0_RLC0_IB_BASE_HI                                  0x00000000
mmSDMA0_RLC0_DUMMY_REG                                   0x0000000f
mmSDMA0_INT_STATUS                                       0x000000e0
mmSDMA0_VM_CNTL                                          0xffffffff
mmGRBM_STATUS2                                           0x00000000


Sunil Khatri (2):
  drm/amdgpu: Add sdma_v5_2 ip dump for devcoredump
  drm/amdgpu: add print support for sdma_v_5_2 ip_dump

 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 106 +++++++++++++++++++++++
 2 files changed, 107 insertions(+)

--
2.34.1


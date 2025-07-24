Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8665FC83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 03:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF9110E14F;
	Thu, 24 Jul 2025 03:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jQxyXuTM";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1022810E14F
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 03:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM8gTCjQozYI8aKKYDx0ivhRDsHUjNs+Qpxcbzpm1y+YPKxaG/YH2zcxmHrhVvwMpu6qHt33/2l5gHyi8EtGu8ThYcHvnkP1JZcN3R7fSdRhjce7xD+RaTkEOeLQ5/QV+khXP4LwoEvcd6uCvrxj1asXxzBmUlT/LWlO5g+At1rkbLTpAOokMP13RdNv370EFWDEsDSUavzbxNEwl+nCK0eL73/jh04cfx42SFJaBQaQRYmCsK8vcUkE2tsiWVIb/+bMW4I3pjH3BwZ86D9ivLa/69hGvFFRDVT9tvmnu8/p1+fSJ9UMXpnqX4X0PFEa6UE8DiWr82laX5jb8bagDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s0uBhobhdZA+RtxC/AEqfJErnrx7cuqkYPfGurT/kM=;
 b=X8KU4BY2mNU0FfOsTR7jaLdqij1PO7Lfosl1vK+JEUKkuL4OqYs5b4EJ6gud3OTtm4UE+55wOfNwRuijKJtuxBT2yAjK/vgR7c2YuVvzQDgRMt/3857e/c/r4vfWIyuckO+j3EokdUwGFhISl//Ztr9D9Pqt87WRjhC9SUfmgOpYrTrd9HNWZIhAtqSrpTu7d910hrw0HTEuJAP4w1U0/LTvELlQ+98LqWHUJ2nzTlq2a7KcexXAAVoOXtTzhkquRCGqR8WAIHktYzJS/J2KB6ysR/FoO8RmafmMDb3O/VgJwFxHt7W/0YKGkbjSbN7/dQQ9FGOPY8i0XgMWdPQFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s0uBhobhdZA+RtxC/AEqfJErnrx7cuqkYPfGurT/kM=;
 b=jQxyXuTMWMW6Y5qA3cSIiTRwKKwuJeDzTzsgqvUuBwlsFaYJDocGwUemX+/1IruTy/EgIMHJPGzHwn/+Z/NrWo96GEKwQXiUT0aIzihMuqpIP+z+IFPvXeKQ2OWMRYUTTCBbSZ6DpwHSEo8BIDmwM5GsoAQ6Gg8e6TkuZPYmby0=
Received: from DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) by
 SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Thu, 24 Jul 2025 03:51:16 +0000
Received: from DS0PR12MB8199.namprd12.prod.outlook.com
 ([fe80::238:a778:e012:821e]) by DS0PR12MB8199.namprd12.prod.outlook.com
 ([fe80::238:a778:e012:821e%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 03:51:16 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Shen, George" <George.Shen@amd.com>, "Strauss,
 Michael" <Michael.Strauss@amd.com>, Mike Katsnelson
 <mike.katsnelson@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>, "Wu, Ray"
 <Ray.Wu@amd.com>, "Liu, Wenjing" <Wenjing.Liu@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, 
 "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH] drm/amd/display: Reduce Stack Usage in
 'dp_retrain_link_dp_test' by heap-allocating 'audio_output'
Thread-Topic: [PATCH] drm/amd/display: Reduce Stack Usage in
 'dp_retrain_link_dp_test' by heap-allocating 'audio_output'
Thread-Index: AQHb+kBPpi7iIR01KECFTp670lZl07RAhWIAgAAiSAA=
Date: Thu, 24 Jul 2025 03:51:15 +0000
Message-ID: <DS0PR12MB8199FA0A6179DE709E01DA25905EA@DS0PR12MB8199.namprd12.prod.outlook.com>
References: <20250721130613.1291563-1-srinivasan.shanmugam@amd.com>
 <f3fa231c-053a-4164-a8a0-416880d59e97@amd.com>
In-Reply-To: <f3fa231c-053a-4164-a8a0-416880d59e97@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-24T03:50:23.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8199:EE_|SJ2PR12MB9162:EE_
x-ms-office365-filtering-correlation-id: f74ececc-d5e6-4ae7-950c-08ddca655716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OUFlcTkvdVh1OEJSb1k5TkZldWVqZi9OTVV2WWpNa0RPYUNmTFM4MWI1L2hP?=
 =?utf-8?B?QzBBRTVLak9UZUgyVVJqR1lzcnQvMEM2aGpjSnYrNCtZVTJzQUZpMHVzeVhO?=
 =?utf-8?B?VFIyd1RKcGxFRTZSZ0phWW5kR3FxRno0Y1lWVnYxTjJseG8vN1hUT3pXOUg0?=
 =?utf-8?B?S2pQMHdnUDlVbnpxM0thd1V5ZlNXc0NGQ1J5a3Naais4VEorZkhaN0JXQVJZ?=
 =?utf-8?B?blpYdVFCUldYcHM1ajFMR0VWbm8vVUxzUTJlY0FqMzlvd2s3QTdzMFFSWW9Z?=
 =?utf-8?B?KzQ5YlBjV1RZTXlmM05pd2haMDFUNDVURCsrcmFNaG1hb2FjcVU1a2V6aEFI?=
 =?utf-8?B?dG9mcElPVjY4N3orcEtzVHBQQVRqV1ZrcktGOUFmdzFKYkpTQzJzVFdaUzB5?=
 =?utf-8?B?Q2JVRmg5c25zUXBQRTdRbjlOL2FmZEFmdkNYL1ZxNDR6WTRDcTBoOHgxMWpp?=
 =?utf-8?B?MEptd2pOWFRBOWlXWkZCR0lDREx0UzFvcjVzVWZVWm15MWxJZmN0VmlxYkow?=
 =?utf-8?B?SmwwTGFaanB6aC8wd1V0amVkWklNZE05c052RTlscTBOeUdpWjZHZnNQZkR2?=
 =?utf-8?B?ejVqL1Y5NitDR3U3RXFHZzhpMm9ySTlNL1Jkc09lUTBCeXRhMVdsVlRxWWNk?=
 =?utf-8?B?TzA1VTJYN2FHTHRtalA2LzZQRnJpK0g5YllXbTVWUmVaMllQRllGT1E2MTNa?=
 =?utf-8?B?MjVVamtRS1Btc1phbHd2SUtqaWIwNkRneGd5YnpPd29NQS8yQlZ4bHVwVjlS?=
 =?utf-8?B?V0tCZWt2YXNuTURsdWU3OGh3dCt5STZHRmVNYmt1dHptYTE2cjJyRFhiUWM1?=
 =?utf-8?B?eUpWUGY5L2pEc0lsT3FKY0d2QS9Ibml0RVgxTld3S0FYVVZ1dEV3QUNOdjRx?=
 =?utf-8?B?ei9yREFibnRyNVFBTFVMTGM4NkIwT2s4NVVSKzU3STlJRUZOWldjYWdSUXF3?=
 =?utf-8?B?OFg1T0FiTWVmTmkrZFl5UCtYRDNDOFkyZlBZbmZFSjRwbjg1Q3N0eFpOeFY2?=
 =?utf-8?B?T0diU0dhR1JIUm55T0c3RDBsd1ZFQ0sxMk56Q052VkIxMForSFMvUVkvMGYr?=
 =?utf-8?B?aThOZE9pcWd2SVFRSmUraFdNTlBFZVNjNUkxY1FwOGRqb3JYS2Y3YkxsdXhn?=
 =?utf-8?B?T3NpbVM0T3FoNEp6MnVGSVRlTUU0bk1YSzk3V2QzcUFVc3RvK3pIQ01NVjVi?=
 =?utf-8?B?SVUxenFhRG5mQWFvM3JLY0pSWVpJbW4vaGlRckxSRGFBWHNXakg1N2lWei9H?=
 =?utf-8?B?ZzNvTy9POVdFNmdESk5XN1BQdDYzZCtnbWV1SkY3bm1OYlgwUW0vYjJWbE15?=
 =?utf-8?B?RDRLdDlYektMNzM1aUdhQ0I1OUVGNW1CajVnWWozcnpleTVVbjk5a3dNKzk5?=
 =?utf-8?B?NDhiMDFhZjc4eUhLck9oYXZVNERTblZJZlZEZDVIL0JsYjZUUkRnc2p6dDN2?=
 =?utf-8?B?VXYyS3VlVTR1TXdhSXNENGI5bUNndk91NDBUZTdjeHFFK3VXZFVRdG5nR1RP?=
 =?utf-8?B?NlltbW9TbkJub3JEWXB1SVJLaXhjN3ROQ2hJQW5tdEp6ZTNUd2ozaitiTlFZ?=
 =?utf-8?B?NE5CanZxZFJpUEE5eDlxdElEL05RSE00bVJwZkRoVXFRMXVhdW5tMDNvZjdS?=
 =?utf-8?B?b0ExdTJWbTBTcFVvRnBrYzUremlsWENWZ0VwV3cybTVDT0tmdHJXeFp1YjZB?=
 =?utf-8?B?YjVpcUZ1L3d4YXAzU1hWd3l3RklkMWNLei83eFNUbkZVT3ExYjVMbkMwSzhm?=
 =?utf-8?B?djU3elUxWjcvOHp2VVJtZmFXSUdOOFQ2OWR5UXI0eWQ5Y2NySE5rR2JDcHZz?=
 =?utf-8?B?MUdyNERVeXVrR2dtK3ptUVRERDByZ20rWjRVUkVlWDVvYXV6RFZmUEVpSnZa?=
 =?utf-8?B?dVdObFdQYU92U2t4T2xLRGlDMVVrT1N2ekJGZGtlUmxSS3ZOWnNxVE1FT29P?=
 =?utf-8?B?YjJzdjJsSlRxVEJ2dno3a1lMNUtzNHRCdG94SjI4MlRNOXhORjlRZ1RvUEJ2?=
 =?utf-8?B?Y1NyclpjZHhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clpORHlwejF0MlFyaUJxbm5XZ3d6UnRnbGdVUVoxQXo5RFVLVUk4a0ltNU12?=
 =?utf-8?B?OHN2ckQ4dkpmUTVoSkxpeTk2MXV4MXlSVHZpc3ZhUEpaUWp4MmdiUUpxUW11?=
 =?utf-8?B?QXVoVit3ejNBWTNWVjJoK3FoOFNmS0JTKzBpY3lnaUp4VlV3bzJCQW1JSEt3?=
 =?utf-8?B?OTR2QUpRMlByNW1EdEkzTFkvWndpbFJGcC9LRXpSWjlTYTZ1TDM2L0o3WFcy?=
 =?utf-8?B?eGFIVGsrK2MxdnE1U1FGd2lxVTVrNEtCdldkUEpaNml1Q0tpemNOVVdOQ0s3?=
 =?utf-8?B?K0ZJWGVpRVRlYWJkQi9IaU5nUUVPTUg3aTFSWXNFNENTMlcyeWtPN2ZibWNh?=
 =?utf-8?B?cmFNVUJoSUtSbEtqRlBTUTA5V0d4NzNCZzRhWjltQVlodE9KL2gvVStSQ1pX?=
 =?utf-8?B?azhsYXVqRFp5ZjEyVVJyelhnd1JvbGpKTGdHZUtMVGtFRHNFYmhUV2J6dnVz?=
 =?utf-8?B?NmJiVUVyQTh2N1NSbEZBdlBmYUV3WkFFallzVkcvU3Q1bTlOUU91bmlha01v?=
 =?utf-8?B?STNraFJBakpmRHEyTjZGZjg5OVlFY3hMSWQvdko1ZFc3RWUvZ01lZUxNR1Nz?=
 =?utf-8?B?NnVMWmhJY0g1LzRIYWtONWRJb2UxZmNmc3hjT3NNazJWeDg1ME9wR2libGU5?=
 =?utf-8?B?UzEweUZGcGN6eElZT0dOcFE3VTZUS1EycEVHTkE1bytiaitwWGxGNU92WHZI?=
 =?utf-8?B?dFlHbHJ5SWtTS3JlUHNVanNjYnFTMHR3cnNzbStveDZjQjBuZUtIcDVEOE5B?=
 =?utf-8?B?ZlRHQW1nbXFaSHFGZUwyajRaRWFXaFh1MzRqUEtCWnMvTlRIOW9HaWM5SU9Q?=
 =?utf-8?B?endiR25xeGYraTI2UzBPdG1kcGhLNFFrUlRoemhzRE1xQTExZHZzNDJ4QVRz?=
 =?utf-8?B?d3hPRi9ZbnNacDV1TUtSV1NHazZ2ZVpxVzR2ZmlBTGVLM3hZaGNYK3JLSzh1?=
 =?utf-8?B?UE5OMHVCaXU0Y0JoZy9BUlNOb2FFQTVacjFQTkJDK0o5a3RzRXpEUUpjM09q?=
 =?utf-8?B?bUprblc5ZVJDNG50elR2d2tjM2kyT0VDYWlWRmxTeVFKMzVTSERQVDNubWZj?=
 =?utf-8?B?N0lvcjJXUkgvc29yeFJXWUtQb01ocWR2Q3piQUkvMS82d0RXQTliQnVabVdK?=
 =?utf-8?B?Q1o1b2NQOEZJNHBLWFlOOFN0ME9QR1hNZDNFMU5JV3dqWFZOR3ZadS9TRERz?=
 =?utf-8?B?VjMyOFRub1hpWkNaV2dtTzh0eXVrL1NyODdFZUIrMTZzR2ZSOVd6d2FqeFRS?=
 =?utf-8?B?TVpyK3NIeUhrRFdTTkVtVnkzc1J4YVI4YWN3dXZKMWFJdG5hcUhYQ2xqb3RO?=
 =?utf-8?B?NmhKWUE2ZDhZaVlNZWpXbHVxUmoreTJOZDVrVkh2ejlkMUh5QTNGeHlhcVJG?=
 =?utf-8?B?ejBDMnZlSy9sM3lSRURnbkFrL0FyWHhQOVVyWEJBWHpScDQrNUFTdHg5d2sv?=
 =?utf-8?B?TktNQk1TQzlseTMwbWdZTnhhY0x2RU1ya3lTQ09ZQ0R5TURFUHQ5bnB4b0hM?=
 =?utf-8?B?dlhXTWN5dFlKRkJncURoOTJya3NyQ1IzSnBQdWZ2SUtkREgxc08zZWREcllK?=
 =?utf-8?B?Q1ZTQ1lrNUJoOTJCQkFQQnNucDZISzN3bHpVa3dzZmRmQ00zZlNreXZJM0cx?=
 =?utf-8?B?LzRSTHlJSk4wNkxJQzZMOU1ySUh1T1djSjBGWmo5clNVelJTS3d1bWkydlUy?=
 =?utf-8?B?UWMyUWNIVjV0NFZsbW9rNUVtYk1HWVRSRjR6THFGTWZEL1BxOEJCeldudllD?=
 =?utf-8?B?RkgwZ0YxWHlIR2p2M2F4ZUY2NDBkRHJKMkNYaS80dEZZRGpHOEcxRFUzUDZF?=
 =?utf-8?B?YkZJSUdOY3VRYk9SLzd0cFRiaGI4Z0xMSUxtc3dvaXNPNENFaTkzbWRNSExT?=
 =?utf-8?B?UHAwYTNhMFZ5M3ErY0tLYnpZNVNRczZ1ZjBVYnhxV1pONVVRZTNmNEkxenY3?=
 =?utf-8?B?Qm83ZU5Bc2pJRW1uT2xOVkN5aDRuRzIyTkZVWjk3RFJTWDE0MnZNM2xzOGZE?=
 =?utf-8?B?UzAxTjd1bnl5ZDdTakFIV2ZoMXRMV0dzZ0dtQWJZYUo1QkZlZVlBZ09jQldw?=
 =?utf-8?B?czlTWDFZMlV4d3pBQld5d2drd2MyZHN6OVFhMlRBVVNRUVJZaUZJR3hhaHdL?=
 =?utf-8?Q?OOZk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74ececc-d5e6-4ae7-950c-08ddca655716
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 03:51:15.7643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bizoRf+/SoGJsueKGmx1clImf8tHW/KwSrukXeeI+vNTuUSmsBVDCu0hHMGLixF+dBfYFEofR2QKCDzYvMmP+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIdW5nLCBBbGV4IDxBbGV4
Lkh1bmdAYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMjQsIDIwMjUgNzoxOCBBTQ0K
PiBUbzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29t
PjsNCj4gUGlsbGFpLCBBdXJhYmluZG8gPEF1cmFiaW5kby5QaWxsYWlAYW1kLmNvbT4NCj4gQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMaW4sIFdheW5lIDxXYXluZS5MaW5AYW1k
LmNvbT47IFNoZW4sDQo+IEdlb3JnZSA8R2VvcmdlLlNoZW5AYW1kLmNvbT47IFN0cmF1c3MsIE1p
Y2hhZWwNCj4gPE1pY2hhZWwuU3RyYXVzc0BhbWQuY29tPjsgTWlrZSBLYXRzbmVsc29uIDxtaWtl
LmthdHNuZWxzb25AYW1kLmNvbT47DQo+IExlZSwgQWx2aW4gPEFsdmluLkxlZTJAYW1kLmNvbT47
IFd1LCBSYXkgPFJheS5XdUBhbWQuY29tPjsgTGl1LCBXZW5qaW5nDQo+IDxXZW5qaW5nLkxpdUBh
bWQuY29tPjsgV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgQ2h1bmcs
DQo+IENoaWFIc3VhbiAoVG9tKSA8Q2hpYUhzdWFuLkNodW5nQGFtZC5jb20+OyBMaSwgUm9tYW4N
Cj4gPFJvbWFuLkxpQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvZGlz
cGxheTogUmVkdWNlIFN0YWNrIFVzYWdlIGluDQo+ICdkcF9yZXRyYWluX2xpbmtfZHBfdGVzdCcg
YnkgaGVhcC1hbGxvY2F0aW5nICdhdWRpb19vdXRwdXQnDQo+DQo+DQo+DQo+IE9uIDcvMjEvMjUg
MDc6MDYsIFNyaW5pdmFzYW4gU2hhbm11Z2FtIHdyb3RlOg0KPiA+IFRoZSBmdW5jdGlvbiBkcF9y
ZXRyYWluX2xpbmtfZHBfdGVzdCBjdXJyZW50bHkgYWxsb2NhdGVzIGEgbGFyZ2UNCj4gPiBhdWRp
b19vdXRwdXQgYXJyYXkgb24gdGhlIHN0YWNrLCBjYXVzaW5nIHRoZSBzdGFjayBmcmFtZSBzaXpl
IHRvDQo+ID4gZXhjZWVkIHRoZSBjb21waWxlciBsaW1pdCAoMTA4MCBieXRlcyA+IDEwMjQgYnl0
ZXMpLg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgcHJldmVudHMgc3RhY2sgb3ZlcmZsb3cgaXNzdWVz
Og0KPiA+IGFtZGdwdS8uLi9kaXNwbGF5L2RjL2xpbmsvYWNjZXNzb3JpZXMvbGlua19kcF9jdHMu
Yzo2NToxMzogd2FybmluZzoNCj4gPiBzdGFjayBmcmFtZSBzaXplICgxMDgwKSBleGNlZWRzIGxp
bWl0ICgxMDI0KSBpbg0KPiA+ICdkcF9yZXRyYWluX2xpbmtfZHBfdGVzdCcgWy1XZnJhbWUtbGFy
Z2VyLXRoYW5dIHN0YXRpYyB2b2lkDQo+ID4gZHBfcmV0cmFpbl9saW5rX2RwX3Rlc3Qoc3RydWN0
IGRjX2xpbmsgKmxpbmssDQo+ID4NCj4gPiBUaGlzIGNvbW1pdCByZWZhY3RvcnMgdGhlIGZ1bmN0
aW9uIHRvIGR5bmFtaWNhbGx5IGFsbG9jYXRlIHRoZQ0KPiA+IGF1ZGlvX291dHB1dCBhcnJheSB1
c2luZyBrbWFsbG9jL2tmcmVlLCBzaWduaWZpY2FudGx5IHJlZHVjaW5nIHN0YWNrDQo+ID4gdXNh
Z2UuDQo+ID4NCj4gPiAtIEFsbG9jYXRlcyBhdWRpb19vdXRwdXQgb24gdGhlIGhlYXAgaW5zdGVh
ZCBvZiBzdGFjaw0KPiA+IC0gQWRkcyBlcnJvciBoYW5kbGluZyBmb3IgYWxsb2NhdGlvbiBmYWls
dXJlDQo+ID4gLSBGcmVlcyBhbGxvY2F0ZWQgbWVtb3J5IGJlZm9yZSBmdW5jdGlvbiByZXR1cm4N
Cj4gPg0KPiA+IEZpeGVzOiA5NDM3MDU5YjRiZmIgKCJkcm0vYW1kL2Rpc3BsYXk6IEZpeCBMaW5r
IE92ZXJyaWRlIFNlcXVlbmNpbmcNCj4gPiBXaGVuIFN3aXRjaGluZyBCZXR3ZWVuIERJTy9IUE8i
KSBTd2l0Y2hpbmcgQmV0d2VlbiBESU8vSFBPIikNCj4gPiBDYzogV2F5bmUgTGluIDx3YXluZS5s
aW5AYW1kLmNvbT4NCj4gPiBDYzogR2VvcmdlIFNoZW4gPGdlb3JnZS5zaGVuQGFtZC5jb20+DQo+
ID4gQ2M6IE1pY2hhZWwgU3RyYXVzcyA8bWljaGFlbC5zdHJhdXNzQGFtZC5jb20+DQo+ID4gQ2M6
IE1pa2UgS2F0c25lbHNvbiA8bWlrZS5rYXRzbmVsc29uQGFtZC5jb20+DQo+ID4gQ2M6IEFsdmlu
IExlZSA8QWx2aW4uTGVlMkBhbWQuY29tPg0KPiA+IENjOiBSYXkgV3UgPHJheS53dUBhbWQuY29t
Pg0KPiA+IENjOiBXZW5qaW5nIExpdSA8d2VuamluZy5saXVAYW1kLmNvbT4NCj4gPiBDYzogSGFy
cnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+DQo+ID4gQ2M6IFRvbSBDaHVuZyA8
Y2hpYWhzdWFuLmNodW5nQGFtZC5jb20+DQo+ID4gQ2M6IFJvbWFuIExpIDxyb21hbi5saUBhbWQu
Y29tPg0KPiA+IENjOiBBbGV4IEh1bmcgPGFsZXguaHVuZ0BhbWQuY29tPg0KPiA+IENjOiBBdXJh
YmluZG8gUGlsbGFpIDxhdXJhYmluZG8ucGlsbGFpQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+
ID4gLS0tDQo+ID4gICAuLi4vYW1kL2Rpc3BsYXkvZGMvbGluay9hY2Nlc3Nvcmllcy9saW5rX2Rw
X2N0cy5jICAgfCAxMyArKysrKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2xpbmsvYWNjZXNzb3JpZXMvbGlua19kcF9jdHMu
Yw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2xpbmsvYWNjZXNzb3JpZXMv
bGlua19kcF9jdHMuYw0KPiA+IGluZGV4IDI5NTZjMmIzYWQxYS4uYzRkYjYxY2I1MDc5IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9saW5rL2FjY2Vzc29y
aWVzL2xpbmtfZHBfY3RzLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvbGluay9hY2Nlc3Nvcmllcy9saW5rX2RwX2N0cy5jDQo+ID4gQEAgLTc1LDcgKzc1LDE2IEBA
IHN0YXRpYyB2b2lkIGRwX3JldHJhaW5fbGlua19kcF90ZXN0KHN0cnVjdCBkY19saW5rICpsaW5r
LA0KPiA+ICAgICBib29sIGlzX2hwb19hY3F1aXJlZDsNCj4gPiAgICAgdWludDhfdCBjb3VudDsN
Cj4gPiAgICAgaW50IGk7DQo+ID4gLSAgIHN0cnVjdCBhdWRpb19vdXRwdXQgYXVkaW9fb3V0cHV0
W01BWF9QSVBFU107DQo+ID4gKw0KPiA+ICsgICAvKiBEeW5hbWljYWxseSBhbGxvY2F0ZSBhdWRp
b19vdXRwdXQgdG8gcmVkdWNlIHN0YWNrIHVzYWdlICovDQo+ID4gKyAgIHN0cnVjdCBhdWRpb19v
dXRwdXQgKmF1ZGlvX291dHB1dDsNCj4gPiArDQo+ID4gKyAgIGF1ZGlvX291dHB1dCA9IGttYWxs
b2Moc2l6ZW9mKCphdWRpb19vdXRwdXQpICogTUFYX1BJUEVTLA0KPiA+ICtHRlBfS0VSTkVMKTsN
Cj4NCj4gVGhpcyBmaWxlIGlzIHNoYXJlZCB3aXRoIGFub3RoZXIgT1Mgd2hpY2ggaGFzIG5vIGtt
YWxsb2MgY2FsbCwgYW5kIHVuZm9ydHVuYXRlbHkgdGhpcw0KPiBjaGFuZ2UgZG9lcyBub3QgcGFz
cyBDSS4NCj4NCg0KVGhhbmtzIEFsZXghLCB3aWxsIHByb3Bvc2UgdjIgZm9yIHRoaXMuDQoNClNy
aW5pDQoNCj4NCj4gPiArICAgaWYgKCFhdWRpb19vdXRwdXQpIHsNCj4gPiArICAgICAgICAgICAv
KiBBbGxvY2F0aW9uIGZhaWxlZCwgaGFuZGxlIGVycm9yIGdyYWNlZnVsbHkgKi8NCj4gPiArICAg
ICAgICAgICBEQ19MT0dfRVJST1IoIiVzOiBGYWlsZWQgdG8gYWxsb2NhdGUgYXVkaW9fb3V0cHV0
IiwgX19mdW5jX18pOw0KPiA+ICsgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgfQ0KPiA+DQo+
ID4gICAgIG5lZWRzX2RpdmlkZXJfdXBkYXRlID0gKGxpbmstPmRjLT5saW5rX3Nydi0NCj4gPmRw
X2dldF9lbmNvZGluZ19mb3JtYXQobGlua19zZXR0aW5nKSAhPQ0KPiA+ICAgICBsaW5rLT5kYy0+
bGlua19zcnYtPmRwX2dldF9lbmNvZGluZ19mb3JtYXQoKGNvbnN0IHN0cnVjdCBkY19saW5rX3Nl
dHRpbmdzDQo+ICopICZsaW5rLT5jdXJfbGlua19zZXR0aW5ncykpOw0KPiA+IEBAIC0xNDQsNiAr
MTUzLDggQEAgc3RhdGljIHZvaWQgZHBfcmV0cmFpbl9saW5rX2RwX3Rlc3Qoc3RydWN0IGRjX2xp
bmsgKmxpbmssDQo+ID4gICAgICAgICAgICAgICAgICAgICBzdHJlYW1fdXBkYXRlLmRwbXNfb2Zm
ID0gJmRwbXNfb2ZmOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgZGNfdXBkYXRlX3BsYW5lc19h
bmRfc3RyZWFtKHN0YXRlLT5jbGtfbWdyLT5jdHgtPmRjLA0KPiBOVUxMLCAwLCBzdGF0ZS0+c3Ry
ZWFtc1tpXSwgJnN0cmVhbV91cGRhdGUpOw0KPiA+ICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4g
KyAgIGtmcmVlKGF1ZGlvX291dHB1dCk7DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyB2b2lk
IGRwX3Rlc3Rfc2VuZF9saW5rX3RyYWluaW5nKHN0cnVjdCBkY19saW5rICpsaW5rKQ0KDQo=

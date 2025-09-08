Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825BACAC582
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 21:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB7410E209;
	Mon,  8 Sep 2025 21:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kX0kRkcw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D83810E209
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 21:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEPSDGDWEwYwTqcSKAeQjYmNAjxGUXOQVkRBW9ioNAOdezs8ADkp8WB8eRdlj4o8fJBf9umFPG23vqg6Vqd9A5UGcY75Nyj5u59mZTJnNnkhn3BsHjeYLeVlKqJZg5MDVSXwmIiW9QVSSNwbrbaUsfs8HweYFaH/jmVW9cJxbtd9+4L3fAeKweXo6wopwcpiaH7oRn31gR8G9KHb6QaJzvtAricl0CzdmmVeH2riYuwMY32XPF7izSiRllH0B/14xdzHT9HFmhqEZ0zVHrmtVCN+Tz2kcJfcHC4Z+cNp6OL2SkVjVTmYhu1hP/dGWyHQEWzaTcG5a4/RVRJK2cgJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSrjXj9YEu7iblDmBSfDeVHIRXqZ/xLD3xXAztNjHQw=;
 b=kiLy+hOt+SygRYJfp5XumIVyfq5Qxze2baxFOwJ7T6kis1+ejD45UdEmNn9hbeDRuc4H8tquLmTlmoOYn3KdV7KGDh1vz7SHzFORdFf8o6Fqoe9HZC6N6FKHpKGpy+TcERJFAApJu1J5Ga7isZlLg24jswAgxXbJNAE9fhSZhXnmM13L3OMRu56ahm7maDPV6QcbGFzvsOrVB8rVDhpFT4jHRQ+GLBbNcdsMpPn6x9WrYNHfU5ItDElKCtkHUtBhbReL8t8UdoeUcPSL4Kg5fNdG8G+3asWsq1DknuRdHOHChiV0+c7fgIWY5RNDjwFNGnct/s1wa8Z0kHFgPy/eBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSrjXj9YEu7iblDmBSfDeVHIRXqZ/xLD3xXAztNjHQw=;
 b=kX0kRkcwOds/ZX7OejnouO2SQsF9SWInpr0+uEBwoKtmYFHMl2QeVpoJXCmkf8YeJLaqyh2NSUAAqFvoeaiFtN0kHZ6WsAoHicWc6dhhTduVZMfpZzG1s137WYCvdF+JYJ1ZKAdh8+i39caeneb7+fTTcEndZYXOu//rLF684A8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 21:15:59 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 21:15:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?utf-8?B?U2lsdml1LUFsZXhhbmRydSDImHRlZmFu?=
 <stefan.silviu.alexandru@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: RE: [PATCH] drm/amd/display: Register DP aux only if used
Thread-Topic: [PATCH] drm/amd/display: Register DP aux only if used
Thread-Index: AQHcIQEeQto6Sl8hl0CYm0ZGBt0d5LSJxgqQ
Date: Mon, 8 Sep 2025 21:15:58 +0000
Message-ID: <BL1PR12MB51442BF8FBDCE9F4A23C21D0F70CA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250908204207.8397-1-stefan.silviu.alexandru@gmail.com>
In-Reply-To: <20250908204207.8397-1-stefan.silviu.alexandru@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-08T21:03:38.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB6185:EE_
x-ms-office365-filtering-correlation-id: da846082-3b55-4111-e813-08ddef1ce828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UTNYblczMnZQTVc0elNzbWxJMm91YzVPN0IvbWpyTUtncWwrSE5vUE9KQ0ha?=
 =?utf-8?B?TlJ0RVNZR0REUWU3VElrUkVtQkJLejlhMFp4TzJEcVBSZHR4NlExUi8wQk0z?=
 =?utf-8?B?YnNqU3lpSmxScVhmbTkyekNENGU1VUdGV2tHUGk4V3pydHEwS1JOZDFRTEFS?=
 =?utf-8?B?UjhQVm92K1lFYWpTcklyektDTm9ZYnBOWDFISXRDR25OY2xteGRhUklxWlFw?=
 =?utf-8?B?MTZpSUZnTDVFMEdlNUFYbmNPZmgra1ltK0NocjNhNW9nRFVlcWdLaHE4YUpm?=
 =?utf-8?B?K0RDblpkcUJTd0J5V2ZwZUFiSWw2THB6RDlhWG5kRWFTVTdveTkyRndUaGpk?=
 =?utf-8?B?ck1TWkhXc1U0U0RueU9jQS9xdlJpUzVPRzIyUzF3cFVEbk00bSt2c01TamtW?=
 =?utf-8?B?NXZoQ1kyWjlXNWJIbUhzQVNUWmhjNTZYdmpiR1dzNnpod25zdDlhbCtyZ05j?=
 =?utf-8?B?T1ExcWhjTFBwT1ZFejFCZWlFa291TWNOZXZmbGlRcDFtWWhXMGJ1VDRyL3Mx?=
 =?utf-8?B?OE42Z1ZhSGtKeVBza1BwVmRVSW1uZUdEMnh6RGpNSzNGMGIxSkpJQyt0SWxm?=
 =?utf-8?B?Tk5meDJyemk0dEJHU2g0bmowUGd6MEY0bzR6NFJ1MG9UM1dDdU5ON0lEb3Jw?=
 =?utf-8?B?WFprQ21wa01QZjZQQ2dZNFNRdVIzZDFZYWZrRHcyNUV3QllxZ0oyVXVGTFFr?=
 =?utf-8?B?NWF5Y1FTeWlIV1RNSHArV3pPWlIzalhZZVpZeU04OGU3K1BNVVV2elpVdGhP?=
 =?utf-8?B?YkV6VWt1ckI2RTQ2Z3FueXpKVWk1SlVrV2hpbVd5VWtocWxNbWVXcEhQamp6?=
 =?utf-8?B?NUo2am54VjVPTDM1VWNwQ0lUeE1kNUl2SDZEUnhTdWwwL0hwcWo3NzdzaXpU?=
 =?utf-8?B?Rm5mVTRSdDI2QTBNcFBLU3I2cjR2aWJyR2NJejZyS3J2ZnliVGFNRTZkdmFa?=
 =?utf-8?B?ajkzZy9HanpTZUFOQXdvRFNOZkkxL0pXWmdzQzZpdE9DTVVBUmxMUlZUSU9B?=
 =?utf-8?B?cm0vRUd4K1FvdzNNVEZ0c011MjBOK0c0V0drQmpxUTJ1YmRHdDE3TEIxcWhT?=
 =?utf-8?B?ZS8vNzlXVWZEMGVMY1cwa3lUWHd2TXVaeHZvWE1lVjNzci9HNGs5dDRDS1RH?=
 =?utf-8?B?dEJHUmw2eEdlUThURFhWdmlJNlEyWkl1ejk2Z2Zhcms3WXV5WWg2TW91a2JE?=
 =?utf-8?B?MlFNNFNEOXYwK0VjVTNFd1FNYzNia0RWUWh1RWpOUFMvYlFDQnJBRTlBV1Nr?=
 =?utf-8?B?ZUhnaUdWeExFTTlHWCt4Uno0UzFGZEw3ZXorTHlCVC9YWjU2NFhmaktBcTg5?=
 =?utf-8?B?ZnVIZWluUEtqQWFPM3pOcUhkMXJOdnUybHF6VXI4SklBbmdZQUV3cVZaL0VV?=
 =?utf-8?B?UGkvS3RjU3JtbHEwWkRyYzA0VzljR2diRVRVTW9SdTRyRDdsNk1lS0JIMjFk?=
 =?utf-8?B?c1hJZlA0T3FHVklTWGUrV2huYVBKR3RyZkR0WTBCNkhYZE14eDBIcHlBSDdN?=
 =?utf-8?B?L3IyZEtzb1ZlU2h5Ylk4TUZFNFQ4bEdxWFZiREtWQmI0MXJ2aytWMHZydVpn?=
 =?utf-8?B?WkhHcDNOVldOd3NIVm5aM1laWEJta2JkMVpVNDNHL1ZtVE5xSEpVNkkyOVA1?=
 =?utf-8?B?K2FGbUlBN1pPK3ZOazNlM3ZLYmhYQm0xVE9JZkk2bGtlcVByWnEwd2NWMVhO?=
 =?utf-8?B?dUNlTUtOaDh6Ukw2NFk2VWN2eXhUZEFsS2lCbmNmOG9mS0VzamU0ZGhQRVU2?=
 =?utf-8?B?ak8zODNBUjlqTDUvUHJub3RBNUF0OVBVdWJzYTdtUWVMeWVlRXZvZE9vQk5k?=
 =?utf-8?B?ZzVGbCtGUk1NS1o3VjZnQVV1SlNpWmd0cFhxTXF3R2dIVjAxM3I2NmV6Y0hV?=
 =?utf-8?B?MlZXYndvRWVJRHNjbE1rUGg4Q3UvRFcxMTlRNkk4dXhVQ21vdEhKKzB5ZXF0?=
 =?utf-8?B?YTc4V2RhQ1VsQkVTNDQrZ0RyOWpyV3JsWTAvQzcrT3NaaHNGdWJJWmM1VGlY?=
 =?utf-8?B?a0Z2U1ZJZjNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmhiakVFdDVoeHExa0FHcVVBWVpTUWNnRnV3eGwxMWhHSmFUMzltOTJPUHA1?=
 =?utf-8?B?dDRTVVY0N3dRa2g5QXpIOXZvT3pBYi9Qd3lZZkVnZk1kdEFOQmhJeng5Z2lP?=
 =?utf-8?B?MjlPb1UyTzJ0cVUvanJaU21XOXdFcHFjUkhWem50ektpZExISWF2aFcxeVhI?=
 =?utf-8?B?eXovN1MyczNYalF6bVY1MGVvYWxMeWFqVDdRZHBEcTBLVFZmZyt0NXhDTTlT?=
 =?utf-8?B?alRScmVaa0MwRTl5a05sRWRLd1oxdG1pRU9MMUYrcEpOdzhneG1zcmRBRkhB?=
 =?utf-8?B?ODRGT1lEWGhXUzdIQS9rcGVSNFFwVFlFUDBmc1NrY2RzMjFWc2ZJTHZnWWR0?=
 =?utf-8?B?a1RPYjhaOTVMUk0xUWtDMFlUL2xRVzF0WG5weCtoTEJzT3BnbHFZdlZUVGN1?=
 =?utf-8?B?TzNyWEI1OHhCTmN5QUdXYmpzUTYyS0JMR0tLWmsvY3g2Z2hQYjBQdmxVZksx?=
 =?utf-8?B?Q2hlM1M3eUNsWDljS2dNOWQyYTZFSjJVbWoyS0Jic0k4bGpmZTdSVGNxR3Fp?=
 =?utf-8?B?OC9QNG01M0xTYjNJMk02UTlNZlBrVE1tcmNPbW9SOW41QjVYaHg5emhJQXRQ?=
 =?utf-8?B?WkdXUEE2UjhVY3YrQUljeXpiZzBsOENYcU55MzFPUGhlM1RFZTRDN0QzOW9M?=
 =?utf-8?B?RXNqTERiSndjUzIyZVhIN3cvTWdVdk9xYkkzT0JFTXQxUEJ5RXJaQ1lEY1dE?=
 =?utf-8?B?RXF0U1JyMFRDRlVxUWVreGMwVDQ3S3pOMS9TaUwwLy8ydDR5ZlpQWWFWVThK?=
 =?utf-8?B?amZKM1E4TVE4UFdvRWJnbmlzc3picnkwYVg2a1RieGxPMXdKNEdvTy8vdFV4?=
 =?utf-8?B?VERYRzBONndxV01kYmUwNmlLR3VVc1VnNGh4OXhNRFZObndtWUx4Z0E3UjJK?=
 =?utf-8?B?NU1FdTNldTRvM04rSVE1YkduajFaUDJaRTdKSVY0dmZQOHYwREpLRi9wZVhZ?=
 =?utf-8?B?ZzlpZmNvZkJVUFpNTjlZZGdFUDNUUnhISHhiRU5vZkZZUnhZMm9nUmg1R0NT?=
 =?utf-8?B?OW4yV25rOVQzVFBzeUdKNzgvZGpKaWJEY0g3VFhkQWk2bDFMYndWdU1UT01Z?=
 =?utf-8?B?Z3FuUjBIdkI0UGZPRUFpQXVFaTZmL0JBZDJhVXBCM0JaRXhhQ0tZaldLY05M?=
 =?utf-8?B?S01nVXlvSklZb3AzM1Y5WFh5d1lSSTRzU2xDYTQ5UEpJZS8wTHoyUzBiQ0dm?=
 =?utf-8?B?MHVaQVFONEtFWnJXQkFrMzU4TlUybm9VVEx3SjExT1cxUXY4emtqUmxhU3RY?=
 =?utf-8?B?cWphOVlCL2R3eUJnY25YQXNCWWg4UzBRaVlVbmxIQlRodkZ0M1lCWDVVMGRK?=
 =?utf-8?B?dUs3cTZuNHNpL01HazhWczRuMzhqZEE5aEwzand6QkVscXN1VnJwME9yZkJS?=
 =?utf-8?B?SHB3WmN2RkR2ajBjVjhDOVJqZmxPbFdFOUpjVFF3ZUo2d0czMnF4aHhLS2Q4?=
 =?utf-8?B?UkYvMFphaVJlQnk5WjU0NkwxaFdzTUpwS1VOTTgrelRuZDRsVjFwU0FkdnNw?=
 =?utf-8?B?VkwvL3phY2tFeDhOMkI3cG5RVlAxQVlyOHI4SzZ3WVVudktiUWVJRkNuM2J1?=
 =?utf-8?B?QjE1ZlhJT2lQWmdBRDhUQmE0eFVxWHpYUGZoclhUTW4zd2tTNWhralZkMzkz?=
 =?utf-8?B?M1VsYzdEd1pYeDhLN1hTb2ZmNEpObkJLOGZMT3QwU3JzYzhPQklvNXVpWXlV?=
 =?utf-8?B?WlFuSmovcWlKeS9DME4zMlM5RXhUYmZXNS9DbFl5endXOC9hTUtSb2ZuNWs5?=
 =?utf-8?B?MFVRZEpuNk9WbHdIUEh1NzB0b3VTdEtwN2pvc2lKditaVTY5Ym5mUzlzVDRy?=
 =?utf-8?B?Q0JWVFBkc0VhNXE2RG1XYncwTkVjaXY2STQzbVQ3OHlNWjJ0STlmbC9uK2NI?=
 =?utf-8?B?RXE2NGg4QnR2NmNmN0JiRXp5bWpDS3JMYWFTbnpXNlljd2FDQmVCZUJHb2pp?=
 =?utf-8?B?Rjl0VnN4Slk3WWFsa2tJbkpiUmV4SHZ6SlJWSFpLeDVWcGE2VXJGY3EwWk00?=
 =?utf-8?B?QjJlOWlXU3pRSjh1K0s3SERLSG1EUE1pS29hbXF6L3JFeTdoVXRZZ3V3N0h6?=
 =?utf-8?B?TkI0dDJGbG9kY3dsck5TRko3MGJGSGpKaE05eDJMcHRjQmFBUU83MWZiczdK?=
 =?utf-8?Q?JrV8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da846082-3b55-4111-e813-08ddef1ce828
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 21:15:58.9184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+zvU6HBvRWgE3Xt2t+kIowD416d3iIWTPd8fuxKPkfoJI3fyacgK9pMXOlXjwfhz5bIoxwoLau2abo2VP3yTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgU2ls
dml1LQ0KPiBBbGV4YW5kcnUgyJh0ZWZhbg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciA4LCAy
MDI1IDQ6NDIgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBX
ZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBMaSwgU3VuIHBlbmcgKExl
bykNCj4gPFN1bnBlbmcuTGlAYW1kLmNvbT47IFJvZHJpZ28gU2lxdWVpcmEgPHNpcXVlaXJhQGln
YWxpYS5jb20+OyBTaWx2aXUtDQo+IEFsZXhhbmRydSDImHRlZmFuIDxzdGVmYW4uc2lsdml1LmFs
ZXhhbmRydUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBS
ZWdpc3RlciBEUCBhdXggb25seSBpZiB1c2VkDQo+DQo+IFRoZSBhdXggY2hhbm5lbCBpcyBhbHdh
eXMgcmVnaXN0ZXJlZCBpZiB0aGUgY29ubmVjdG9yIGlzIERQLCBldmVuIHdoZW4gdGhlIGxpbmsN
Cj4gZG9lc24ndCBjb250YWluIERQLiBXaGVuIHVzaW5nIHRoZSBEaXNwbGF5UG9ydCBjb25uZWN0
b3IgaW4gRFArKyBtb2RlLCB0aGUgSTJDDQo+IGlzIGRvbmUgZGlyZWN0bHkgb3ZlciB0aGUgcGlu
cywgbm90IG92ZXIgYW4gYXV4IGNoYW5uZWwuIFRoZSBwcmFjdGljYWwgZWZmZWN0IGlzIHRoZQ0K
PiBjcmVhdGlvbiBvZg0KPiAyIEkyQyBkZXZpY2VzIGZvciBEREMsIG9uZSBmcm9tIHRoZSBhY3R1
YWwgcGlucywgYW5kIGFub3RoZXIgZnJvbSB0aGUgYXV4IGNoYW5uZWwuDQo+DQo+IFRoaXMgZ2Vu
ZXJhdGVzIGR1cGxpY2F0ZSByZXN1bHRzIGZyb20gdG9vbHMgbGlrZSBkZGN1dGlsLCBmb3IgZXhh
bXBsZSB1c2luZyBhIGNoZWFwDQo+IHBhc3NpdmUgRFAtdG8tRFZJIGNhYmxlOg0KPg0KPiBEaXNw
bGF5IDENCj4gICAgSTJDIGJ1czogIC9kZXYvaTJjLTMNCj4gICAgRFJNX2Nvbm5lY3RvcjogICAg
ICAgICAgIGNhcmQxLURQLTENCj4gLi4uDQo+IERpc3BsYXkgMw0KPiAgICBJMkMgYnVzOiAgL2Rl
di9pMmMtNw0KPiAgICBEUk1fY29ubmVjdG9yOiAgICAgICAgICAgY2FyZDEtRFAtMQ0KPiAuLi4N
Cj4NCj4gVGhlICJyZWFsIiBidXMgaXMgaTJjLTMsIHdoaWxlIHRoZSBhdXggaTJjLTcgZG9lc24n
dCB3b3JrLg0KPg0KPiBBbnkgcmVhZCBvbiB0aGUgYXV4IGNoYW5uZWwgc3VjY2VlZHMsIGJ1dCBh
bHdheXMgcmV0dXJucyBhbiBhbGwtemVybyBidWZmZXIsDQo+IGZ1cnRoZXIgY29uZnVzaW5nIGRk
Y3V0aWwgd2hpY2gganVzdCBzYXlzICJNYXhpbXVtIHJldHJpZXMgZXhjZWVkZWQiLCBldmVuIGlm
IGl0IHdpbGwNCj4gbmV2ZXIgd29yay4NCj4NCj4gVGhlIGRjX2xpbmstPmF1eF9tb2RlIGlzIHRy
dWUgaWYgdGhlIGxpbmsgYWN0dWFsbHkgaW50ZW5kcyB0byB1c2UgYXV4IGZvciBEREMgSTJDLA0K
PiBzbyBza2lwIHJlZ2lzdGVyaW5nIGF1eCB1bmxlc3MgdGhlIGxpbmsgaXMgYWN0dWFsbHkgaW4g
YXV4IG1vZGUuDQoNCkkgZG9uJ3QgdGhpbmsgeW91IGNhbiBza2lwIHRoaXMgb3RoZXJ3aXNlIHlv
dSdsbCBuZXZlciBoYXZlIHRoZSBvdGhlciBidXMuICBFLmcuLCBpZiB5b3UgdW5wbHVnIHRoZSBE
UCsrIG1vbml0b3IgYW5kIHRoZW4gcGx1ZyBpbiBhIERQIG1vbml0b3IsIHRoZSBhdXggYnVzIHdv
bid0IGV4aXN0IGFuZCB0aGVuIHlvdSdsbCBoYXZlIHRoZSBvcHBvc2l0ZSBwcm9ibGVtLiAgWW91
IGp1c3QgbmVlZCB0byB1c2UgdGhlIHJpZ2h0IG9uZSBiYXNlZCBvbiB3aGF0IG1vbml0b3IgaXMg
YXR0YWNoZWQuICBJbiBnZW5lcmFsLCB1c2Vyc3BhY2Ugc2hvdWxkbid0IGJlIG1lc3Npbmcgd2l0
aCB0aGUgaTJjIGJ1c2VzIGluIHRoZSBmaXJzdCBwbGFjZS4gIElmIHlvdSBuZWVkIGFjY2VzcyB0
byB0aGUgRURJRHMsIHRoZSBkcm0gcHJvdmlkZXMgYWNjZXNzIHRvIHRoZW0uDQoNCkFsZXgNCg0K
Pg0KPiBpMmNkZXRlY3QgLXkgMzoNCj4gICAgICAwICAxICAyICAzICA0ICA1ICA2ICA3ICA4ICA5
ICBhICBiICBjICBkICBlICBmDQo+IDAwOiAgICAgICAgICAgICAgICAgICAgICAgICAtLSAtLSAt
LSAtLSAtLSAtLSAtLSAtLQ0KPiAxMDogLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0g
LS0gLS0gLS0gLS0gLS0NCj4gMjA6IC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0t
IC0tIC0tIC0tIC0tDQo+IDMwOiAtLSAtLSAtLSAtLSAtLSAtLSAtLSAzNyAtLSAtLSAzYSAtLSAt
LSAtLSAtLSAtLQ0KPiA0MDogNDAgNDEgLS0gLS0gLS0gLS0gLS0gLS0gLS0gNDkgLS0gLS0gLS0g
LS0gLS0gLS0NCj4gNTA6IDUwIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIDU5IC0tIC0tIC0tIC0t
IC0tIC0tDQo+IDYwOiAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAt
LSAtLQ0KPiA3MDogLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0NCj4NCj4gaTJjZGV0ZWN0IC15IDc6
DQo+ICAgICAgMCAgMSAgMiAgMyAgNCAgNSAgNiAgNyAgOCAgOSAgYSAgYiAgYyAgZCAgZSAgZg0K
PiAwMDogICAgICAgICAgICAgICAgICAgICAgICAgLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0NCj4g
MTA6IC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tDQo+IDIw
OiAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLQ0KPiAzMDog
LS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0NCj4gNDA6IC0t
IC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tIC0tDQo+IDUwOiAtLSAt
LSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLSAtLQ0KPiA2MDogLS0gLS0g
LS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0NCj4gNzA6IC0tIC0tIC0t
IC0tIC0tIC0tIC0tIC0tDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNpbHZpdS1BbGV4YW5kcnUgyJh0
ZWZhbiA8c3RlZmFuLnNpbHZpdS5hbGV4YW5kcnVAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAxMyArKysrKysr
KysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbS5jDQo+IGluZGV4IGZhZGM2MDk4ZWFlLi4xNzU5MDcxZTAyYSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
DQo+IEBAIC03NDI5LDYgKzc0MjksMTYgQEAgYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9hdG9taWNfZHVw
bGljYXRlX3N0YXRlKHN0cnVjdA0KPiBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IpDQo+ICAgICAg
IHJldHVybiAmbmV3X3N0YXRlLT5iYXNlOw0KPiAgfQ0KPg0KPiArc3RhdGljIGlubGluZSBib29s
IGFtZGdwdV9kbV9zaG91bGRfcmVnaXN0ZXJfZHBfYXV4KA0KPiArICAgICBzdHJ1Y3QgYW1kZ3B1
X2RtX2Nvbm5lY3RvciAqYW1kZ3B1X2RtX2Nvbm5lY3Rvcikgew0KPiArICAgICBpbnQgY29ubmVj
dG9yX3R5cGUgPSBhbWRncHVfZG1fY29ubmVjdG9yLT5iYXNlLmNvbm5lY3Rvcl90eXBlOw0KPiAr
DQo+ICsgICAgIHJldHVybiAoKGNvbm5lY3Rvcl90eXBlID09IERSTV9NT0RFX0NPTk5FQ1RPUl9E
aXNwbGF5UG9ydCkgfHwNCj4gKyAgICAgICAgICAgICAoY29ubmVjdG9yX3R5cGUgPT0gRFJNX01P
REVfQ09OTkVDVE9SX2VEUCkpICYmDQo+ICsgICAgICAgICAgICBhbWRncHVfZG1fY29ubmVjdG9y
LT5kY19saW5rLT5hdXhfbW9kZTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludA0KPiAgYW1kZ3B1
X2RtX2Nvbm5lY3Rvcl9sYXRlX3JlZ2lzdGVyKHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0
b3IpICB7IEBAIC0NCj4gNzQ0NSw4ICs3NDU1LDcgQEAgYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9sYXRl
X3JlZ2lzdGVyKHN0cnVjdCBkcm1fY29ubmVjdG9yDQo+ICpjb25uZWN0b3IpDQo+DQo+ICAgICAg
IGFtZGdwdV9kbV9yZWdpc3Rlcl9iYWNrbGlnaHRfZGV2aWNlKGFtZGdwdV9kbV9jb25uZWN0b3Ip
Ow0KPg0KPiAtICAgICBpZiAoKGNvbm5lY3Rvci0+Y29ubmVjdG9yX3R5cGUgPT0NCj4gRFJNX01P
REVfQ09OTkVDVE9SX0Rpc3BsYXlQb3J0KSB8fA0KPiAtICAgICAgICAgKGNvbm5lY3Rvci0+Y29u
bmVjdG9yX3R5cGUgPT0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCkpIHsNCj4gKyAgICAgaWYgKGFt
ZGdwdV9kbV9zaG91bGRfcmVnaXN0ZXJfZHBfYXV4KGFtZGdwdV9kbV9jb25uZWN0b3IpKSB7DQo+
ICAgICAgICAgICAgICAgYW1kZ3B1X2RtX2Nvbm5lY3Rvci0+ZG1fZHBfYXV4LmF1eC5kZXYgPSBj
b25uZWN0b3ItPmtkZXY7DQo+ICAgICAgICAgICAgICAgciA9IGRybV9kcF9hdXhfcmVnaXN0ZXIo
JmFtZGdwdV9kbV9jb25uZWN0b3ItDQo+ID5kbV9kcF9hdXguYXV4KTsNCj4gICAgICAgICAgICAg
ICBpZiAocikNCj4NCj4gYmFzZS1jb21taXQ6IDgzN2YzYWJiZmViZGIzNTVlZDA0OWMyYjA2YjU0
MTA4ZTJiYmRmMzUNCj4gLS0NCj4gMi41MS4wDQoNCg==

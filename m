Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD56EC113C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 20:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF30710E1F8;
	Mon, 23 Feb 2026 20:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5d2sg9RZ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F7A10E1F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 20:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgSxnxmvQtPe6pxZupHqrUrerGo4RlRoaKlJQBbtkd/LzSaIoB2DlloKj0pRxzKV+8hpJAwFPY6DVeq9a2B4tzMjoWBqPf5DeqnxdT7sQZW2/jszNhN1uFsrrTlkYANF0Ps6E4PwTXSQOGNevXm0DSxdMMkqQ0qXpscEC7ns+gJU5DDtRcyAC1YyGorUM0pqsUhdaUDCOl+9Tpe5RRUBADQJwcsNfm4Ti3XqevvdaDZmkh3YG4TEjox127d46nDr/DSqJQK4fAEmn6ikR222MqHGWJ012dagOQG7JME+i/BAvssBLGaBj93mWAklindjKDOgZUJ8aXsbqEw/LQGqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtAKPJXkYlgNouOW52U1uY+OlFH94WwtIoEzJvRnsBw=;
 b=e9jAvq3+Ybig6gxeieUkerWA4OH8/VbiAbgobHVUQ++qZsh+9RUXCmde3a+JzsqwA69hf3ohRevepzpMiOWAq/ADkC95Js9QuDoghu6zdNUtHlpCJ/9N0TNPfQcFa2x2cuxsdRE0h4X3RrhcqK4d5AufUngAfx7j0wbXkjHFl0aNpg6Ovxq5xekQaeh1p1dwsoevefrEHfyZ4WYw1+wiGt7ETa5Mf16jEMgoDB0lp49MQt++mgtMy/We3b+/0lBU513zrROoUOSMc1gOWy8k6gS9E/xtcF9XXJp2dbp8yuFWygce9ZfjWs4Xl2WD07fXNu1WTcacAcGKZA0EKsgR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtAKPJXkYlgNouOW52U1uY+OlFH94WwtIoEzJvRnsBw=;
 b=5d2sg9RZWxLoL0YGhVzOqWnsocoHzKmSCm+N2qD/YmTQ81AvZEKd0K96lrudxLsiAhfuIHaf78L2Ffd76I7Te2U7WhGa4IC8/Ich7Xjo/XHR4V9/AEGfaHG1TyAA/OeRIj2Hvo1HFPHgobcv7S2LESGZ/7ymINXdLFAftpLXiNY=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:59:37 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%5]) with mapi id 15.20.9632.015; Mon, 23 Feb 2026
 20:59:37 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Removed commented line for MQD queue priority
Thread-Topic: [PATCH] drm/amdkfd: Removed commented line for MQD queue priority
Thread-Index: AQHcpQHKTR1/+FWpHUKddTG7HQnOLrWQv9wAgAAEghA=
Date: Mon, 23 Feb 2026 20:59:37 +0000
Message-ID: <SJ0PR12MB81381FE299B375A8BA721910F577A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20260223201945.58052-1-andrew.martin@amd.com>
 <CADnq5_M6g=sK4VBanvRp772fyhyGrZa88agUxrLgYD3KPvWpAQ@mail.gmail.com>
In-Reply-To: <CADnq5_M6g=sK4VBanvRp772fyhyGrZa88agUxrLgYD3KPvWpAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: alexdeucher@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-23T20:58:41.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|PH7PR12MB6809:EE_
x-ms-office365-filtering-correlation-id: 1ebd86f9-bb4a-4d05-da6b-08de731e74a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bHBnVEtzYVNDZ0VVd3ZBZEJ4TTU2T281YmZ0eFgwaTJTLy9JT3lKZ3JNZW9j?=
 =?utf-8?B?azhGYjBIWVQzMTRlelZoanRnaDJzZWdVdVZra2owck13TEt6cmpMcklMdEJE?=
 =?utf-8?B?YnR2STlKTy9ibHlaZHhGUkdzTjFiYUZRL2QrY002aDhlMGVkdUtUeUg1dkdm?=
 =?utf-8?B?RWw0ang0aVFCNHhaSmY4b280YlkzOC9ScUY3SUxMWVNRZ0VHQ3FqWndwWE5T?=
 =?utf-8?B?TE8zeVA2eEQrbzYzV1VBbDJ5TnRHbkxEVE5xdU5iZXF6RmhzWUVCM0UwTVp0?=
 =?utf-8?B?aDV4eGxmTERsbkllVjEvR0kxTG95SzdjSk51cUpXT08rWWF5RURLczFuU1pB?=
 =?utf-8?B?NDY3VWJ6MVJuVTl6MWxNVDRZR3hjbzhsVUJ6MmxaTlFhMUNnUENyNnZ6aXV1?=
 =?utf-8?B?U0w4NlpJeklsR2s2T1IzUHRnN3czTXlzandvWG9FUnZEYk9icVJwT2J0NUtu?=
 =?utf-8?B?WFVwS0xsOGZZa051am5TR1JSc0hCMTBWMFJFbThsQWdBY1ZzUnd3V0dMeERV?=
 =?utf-8?B?bloweVNDc0h2c2srVlRmanA4UmZyb1F4NjRraWVnV3RaVXpVWXRzRVd0ck5G?=
 =?utf-8?B?ekR1RmZjZE5KZGZLcGt4ZDJPV29BclNoOEN2OHd1dWtHL21xYU9DVTh6K29u?=
 =?utf-8?B?OUFzb3cvTkEwQkU1SjNBTXVaa09HSzZOVTNNcS9McFVZeWFlbUxuTUgrcEJw?=
 =?utf-8?B?b25wVHVvU3FjaTFuMWdUMFdDeldqOEFiVmNFQ1R1R2U4Y0pPeDNIdlVDemVz?=
 =?utf-8?B?dUVEVjZhbE1FRnFUMkF0ZVNxT0labGJHaFR2ZFlFTEZrdi9JVHNGbFNoZ2Y3?=
 =?utf-8?B?dVVSN3lpelY2bkJUSWlwcmdLcFhaNE9wUkUvajFqR0ZNbHc2dzNLL2QzRDFw?=
 =?utf-8?B?UXArWThKT1NCQjdzSDNuNm10a2lRV09JY0RwTUJFOTk3b1grOWhrQitIdHAy?=
 =?utf-8?B?MFFjb2lvQ0NBcm1TZzBIejkvclpFRTMvREZyU29CRU9kU0dSM1AxeERCc2hx?=
 =?utf-8?B?MFRPTzhxZEIwVTF1bmRncUpHU0YyTnQ3YzBwZ05sZHloM0I3RkE0dzBHYU04?=
 =?utf-8?B?cS9RcEwwZFVKMmdHcU0vYTZqa3ZXanNCbW93NGRRR1d5UDUxMnhvYzJRbnZB?=
 =?utf-8?B?YTZpUzZ5QW9VOGZhM3VJc21SUE1FV1YwR2NQcFBRcG9xNlRkckVjQTdIV1Vt?=
 =?utf-8?B?azIrWFEyeGNqNzFQL1MzNGdmaklReUNxVVNkblVMR3MzOFlFZU92Ym9jU2JP?=
 =?utf-8?B?WUV4REtRZjZBKzMzbFFzdXYyY0FRMDlnOVlmY09uWmR2MUZPNzI3NDRHdmts?=
 =?utf-8?B?ZE40OWNGK0MxYnUwL2N1SWxSbzJzN1NpYW1TTjNJdnprVkEvZVpWVURrMXN2?=
 =?utf-8?B?WmFjdWEvSkIraEc2STBYVU5QRnRCZFhuL1BBcS95aGZVcGhuOFNFSzZFVDZz?=
 =?utf-8?B?WWJ5ZTVTaGJLL1VBcE5kVHdJcXNUamU0MUt6V2lPb2ttS3RhRjJ4Z3Y3QzYr?=
 =?utf-8?B?SEZRU0ppNzdJVGtXWGVrRlhiNXZQbnN6MWF1U0VpaHFxYTY1YVZRWU9od0tF?=
 =?utf-8?B?UmY5ekpQU3IyTzNYZWhodytYbkVKNUtkRzBaTTdIRWZqU0sxZnhrWlhHcFlv?=
 =?utf-8?B?WXRTenBMMVNLOTZTa2Y0SDN2bCtSbjFuRlp6ckRIWXNuL2QxL1psWThTMGdQ?=
 =?utf-8?B?QVo2d0lrVjkrdVI1V1VWU24wZWpaVEhERVI3NmlnbGtObHFRbkVpTXljTjdZ?=
 =?utf-8?B?cE9sOTAxMmVwd2tGOFp0S1AyeWdDTnlpOS8weVMvYzYzZHVORzZTcGRYYWdQ?=
 =?utf-8?B?QUhvNzNoc05rRmxUWUpaVlljeEhkZXRsYTk2QjkzVFhwaS9lUmtUSC92RzZY?=
 =?utf-8?B?cityY0VZVFk0SnMwdWY2WnBiaVFnMlYwdlpTdlp3T0I1OWtxODEzbCtsZjVz?=
 =?utf-8?B?T21ONGZLKzUzeGtvRTZKMDR2TXpob2p1KzE1cHN2NksrZEZSbzNhTWg5cGZi?=
 =?utf-8?B?OVJtaS9NRG1CdEhFRk5BWEU4MkZiRmNzZUtpcHVhSnBYcW1pWWJuOFZYWm1w?=
 =?utf-8?B?bXlweTVSZXJub3dmUnlFelhNUGUzUTBoR1Y1NUx3SldraElpVkVJM1VLYzlj?=
 =?utf-8?B?VzZZVmR1ZmpEWnprSUlSZDRuQUppOXdqM2FnSDJJTHFyNHBla3U2cHpMeHJs?=
 =?utf-8?Q?h+4iX3mrWzHSravHPVoHHOg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlZMTzZZQzh1TlVodWZNMjJ6cWlteWk4WG11TGc2eUVsOGM5NmFjNlVjUWNV?=
 =?utf-8?B?K3A1MEJ1Y3U0UTdIYjNrNzVKWXJ3MTBuNk8wUjhuWTc3VzdpUGRKaGJnT3hR?=
 =?utf-8?B?VHR1YUdXK3RvSzlOSjVETzh6T0J0N2ZEUDFYekUvZXpCa1lBSXRZckRZVDcz?=
 =?utf-8?B?ZEpNN3FpRHRza1NwYjNxOHRmS1FFeXVwRTZIRGRsMngvN2xxdWwvekFuYnkx?=
 =?utf-8?B?OWFlUmFpenJXeG13SnNjYmpKYzJyMDI3RzlSUk5Da3QrZVdLNFQxRVd0WXNk?=
 =?utf-8?B?VUFEbmh3SktaWDZFcms5ZVhSQVhzSUVVTzRVQjAyYjhYUytQa0FPME1RTGs2?=
 =?utf-8?B?bjNJMFpJbVZSM2tqbTRpMUFmNUtGWkx2eEhZVXIrb0JPNStYM3h3ZVVWQlVs?=
 =?utf-8?B?RXJDbHU4Qk5qY1owclVWRTBQbDFQUC93U2VmZGtnK09rR09teVpJUVFmcnpt?=
 =?utf-8?B?eXZXUEpqYTVzWXByTzBocVpqd1hRMlVxQlZQbzRxam1LeDRGbDEyVHRrWmNX?=
 =?utf-8?B?WnJudk0yUW1ET0p5bXE4bmlRbnhEdVFYTGJ5Nkp2SG1YRDIvWDlTaElQVnRK?=
 =?utf-8?B?MEN6N2c5ajdxcFBmTHh6ekNpaDl5Mm9TdmxOZ2l3VGY2WlJ4R2pmS3krVjJv?=
 =?utf-8?B?em84ZVlUU3JRbDJMb0hSSG9WaWd1V1NrVVFLRjViY1BaWitrRmovQjhHQS9l?=
 =?utf-8?B?SkY2d1ZSNXhGVmpLYVNTd0JmVTg2ZXZkZUF2TlV6RVNiekhxdXNWRk54VzBO?=
 =?utf-8?B?cnc3RE45UVltN09GSzBNWHJ5RHNwdVEzZHhMQ2gxVjJlTFJHY2VLWmdLbE9K?=
 =?utf-8?B?dmpBY3ROZUZ1RmJGKzFTTkVwV1lKZFA0VlgrNk9pNFk2NTFMYUZENzEwVS9Z?=
 =?utf-8?B?MmhPamU0aXNqVnhpTEVzZTJlUkhNSGFZTHd4QWxHdVlaWS91M1g3ckFBUmVD?=
 =?utf-8?B?ekpvUWdqTGN2azkrMWNrNzFTRUdDb1Jxa0dua0ZRQXI5M0pwZzZxM1doYWpl?=
 =?utf-8?B?RlhRV2dSZVFpMFpBRG91aGc5cTZraU1YelNvUnNlQTlMQmxCSXUzVXBpN2VL?=
 =?utf-8?B?WGRmUWRTbkFabWtlZnFRc1lscDJjSDZHWUtvNThRSmhiUXFIbEViNjlkM3p2?=
 =?utf-8?B?TzdkNlh5YUZFNTRJVmh2b3p2WFV6T05YUDBZNGdCV25Ja3k5QXRwN21NWklY?=
 =?utf-8?B?UGs5dzNMMEpUK1R4WnVlSUtUdCtjMTZXWFMrSVFMWkpuQ3pJRjdZMTE1ZG5o?=
 =?utf-8?B?cTl1RGZnWURtVVIwZlVCbDZvbVNwOGprUzJjb2FOMFFyTGFzanBMTm1pcC92?=
 =?utf-8?B?dFlGVmZucU1uWGdlWVhpVEtzVUZzY2VxbHdURFphZFNEZnUzelJZVGY4SjlJ?=
 =?utf-8?B?Y2xjVVdHeHJ4UG9abFdPRHRsZjVnaHZzY2lSZFQrKzQ0RnBQLzdhbGlWMmxK?=
 =?utf-8?B?Q1NYRGxubzlLejI1ZGF4ZHFSUDRkeUQxWk9tQWc5OGtzU0pWSlVUNGtuZWtx?=
 =?utf-8?B?SjNyNGhPdXFBcXRtR0NmNXEvaGVwZEo0bzNvejRlMjZkUGZ3YlJ4MHM4ZXF1?=
 =?utf-8?B?YWNXNnBrZUIzcW1NbFA4bDNsT3ZnVzRYYUYweXh1MDJqelFYbUlCSmJ0YVFG?=
 =?utf-8?B?N0FsclpKTlVBS0F6QnV4NkM5Nzd2NHlKRHB2R3J6SGxkclNyNlVYNWQ2NDNy?=
 =?utf-8?B?OEwyTzBRSDAzVUEzSW45Vms3VWVlWVdkUy8xdHpVV3l1SEFQQlNFb2tsZHpM?=
 =?utf-8?B?Q2JKeE8yb2cra0ptK2hZdldYOGVIKzdIS0FqK1Bwc00xVUVnK0VPV0Q2WExP?=
 =?utf-8?B?L0ViaWNwN0Fabzk2ZzFQS3JOR0Y0S3JKNjZRdHhEU241bVlOTE8yQ200aVJX?=
 =?utf-8?B?Q25XTm1mY1hEN2J1SmNiWVJEOXhBeEZjZkQyc2VDMnFEMDZwTWxMWUt3TVZr?=
 =?utf-8?B?SVk3LzgxcVhJdFVNUjlDd250V0hzbUpBMWtlOFpBZGw4YUI4OVp4SVZXZi9j?=
 =?utf-8?B?ck1xK1dpY2sxaVYzd3huZmM0dWpaWjUxOUZTVWpjL2NiQnVuM2xVL0g0WjZG?=
 =?utf-8?B?RFhydFZDakZRWnFnS01DeDdiNGRwZ2tVMnkvaEJ0bUlwRzJuaisxbnFJRTZa?=
 =?utf-8?B?TVZGdEgwQVJXQTVnRWprVVlaTk9MWVNCb3VqZG9FYkxwNVNFcm8rdWFRWTVk?=
 =?utf-8?B?TTgyOG5aMkF6UzZwOU15MXlYOXNxb0ZMMkxBd3MzV2luYjBhZGlmMkExN2xT?=
 =?utf-8?B?VUZYTTl6akxxTlpYWlkyMnR0amY0N3BmZTVnVGdZSmNIMURyYm9QZmg4UTN3?=
 =?utf-8?Q?U9qvlfTavYuwBt8jjl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebd86f9-bb4a-4d05-da6b-08de731e74a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 20:59:37.6626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDLm7rglsm23ZXRv+JS2oN9NnqyifR+Jb9/CPAd8SNKeMUiv5jrYIoqaFeiJ83vhf78vk4LFW1Z/3QMdBwxtSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
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
Cg0KR3JlZXRpbmdzIEBBbGV4IERldWNoZXINCg0KVGhhbmtzLCB3aWxsIGRvIGFzIGluc3RydWN0
ZWQhDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVy
IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMjMsIDIw
MjYgMzo0MyBQTQ0KPiBUbzogTWFydGluLCBBbmRyZXcgPEFuZHJldy5NYXJ0aW5AYW1kLmNvbT4N
Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS9hbWRrZmQ6IFJlbW92ZWQgY29tbWVudGVkIGxpbmUgZm9yIE1RRCBxdWV1ZQ0KPiBwcmlvcml0
eQ0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFs
IFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywg
Y2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIE1vbiwgRmViIDIzLCAy
MDI2IGF0IDM6MznigK9QTSBBbmRyZXcgTWFydGluIDxhbmRyZXcubWFydGluQGFtZC5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gTWlzc2VkIGRlbGV0aW5nIHRoZSBjb21tZW50ZWQgbGluZSBpbiB0
aGUgb3JpZ2luYWwgcGF0Y2guDQo+ID4NCj4gPiBGaXhlczozZTk1MDYzMzgzZjUgKCJkcm0vYW1k
a2ZkOiBEaXNhYmxlIE1RRCBxdWV1ZSBwcmlvcml0eSIpDQo+DQo+IFRoaXMgc2hvdWxkIGJlIHJl
YmFzZWQgb24gdG9wIG9mIGEgdHJlZSB3aGljaCBjb250YWlucyB0aGUgb3JpZ2luYWwgcGF0Y2gu
IEkuZS4sIHRoZQ0KPiBwYXRjaCBzaG91bGQgbG9vayBsaWtlOg0KPiAtICAgICAgIC8qIG0tPmNw
X2hxZF9xdWV1ZV9wcmlvcml0eSA9IHEtPnByaW9yaXR5OyAqLw0KPg0KPiBXaXRoIHRoYXQgZml4
ZWQsDQo+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+DQo+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1hcnRpbiA8YW5kcmV3Lm1hcnRpbkBh
bWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFk
X21hbmFnZXJfY2lrLmMgICB8IDEgLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfbXFkX21hbmFnZXJfdjEwLmMgICB8IDEgLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfbXFkX21hbmFnZXJfdjExLmMgICB8IDEgLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEyLmMgICB8IDEgLQ0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEyXzEuYyB8IDEgLQ0KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYyAgICB8IDEgLQ0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmkuYyAgICB8IDEg
LQ0KPiA+ICA3IGZpbGVzIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX2Npay5jDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfY2lrLmMNCj4g
PiBpbmRleCA5MGFjM2EzMGU4MWQuLjE0MTIzYzVkNDkyNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfY2lrLmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfY2lrLmMNCj4gPiBAQCAt
NzAsNyArNzAsNiBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfY3VfbWFzayhzdHJ1Y3QgbXFkX21hbmFn
ZXIgKm1tLA0KPiA+IHZvaWQgKm1xZCwgIHN0YXRpYyB2b2lkIHNldF9wcmlvcml0eShzdHJ1Y3Qg
Y2lrX21xZCAqbSwgc3RydWN0DQo+ID4gcXVldWVfcHJvcGVydGllcyAqcSkgIHsNCj4gPiAgICAg
ICAgIG0tPmNwX2hxZF9waXBlX3ByaW9yaXR5ID0gcGlwZV9wcmlvcml0eV9tYXBbcS0+cHJpb3Jp
dHldOw0KPiA+IC0gICAgICAgbS0+Y3BfaHFkX3F1ZXVlX3ByaW9yaXR5ID0gcS0+cHJpb3JpdHk7
DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgc3RydWN0IGtmZF9tZW1fb2JqICphbGxvY2F0ZV9t
cWQoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwgZGlmZg0KPiA+IC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMNCj4gPiBpbmRleCA5NzA1NWY4MDhk
NGEuLjBmNzY4OGExZjhiMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMNCj4gPiBAQCAtNzAsNyArNzAsNiBAQCBzdGF0
aWMgdm9pZCB1cGRhdGVfY3VfbWFzayhzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLA0KPiA+IHZvaWQg
Km1xZCwgIHN0YXRpYyB2b2lkIHNldF9wcmlvcml0eShzdHJ1Y3QgdjEwX2NvbXB1dGVfbXFkICpt
LCBzdHJ1Y3QNCj4gPiBxdWV1ZV9wcm9wZXJ0aWVzICpxKSAgew0KPiA+ICAgICAgICAgbS0+Y3Bf
aHFkX3BpcGVfcHJpb3JpdHkgPSBwaXBlX3ByaW9yaXR5X21hcFtxLT5wcmlvcml0eV07DQo+ID4g
LSAgICAgICBtLT5jcF9ocWRfcXVldWVfcHJpb3JpdHkgPSBxLT5wcmlvcml0eTsNCj4gPiAgfQ0K
PiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3Qga2ZkX21lbV9vYmogKmFsbG9jYXRlX21xZChzdHJ1Y3Qg
bXFkX21hbmFnZXIgKm1tLCBkaWZmDQo+ID4gLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfbXFkX21hbmFnZXJfdjExLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9tcWRfbWFuYWdlcl92MTEuYw0KPiA+IGluZGV4IDdlNWE3YWI2ZDBjMC4uZDhmNTY1
Y2IyMTgwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9t
cWRfbWFuYWdlcl92MTEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9tcWRfbWFuYWdlcl92MTEuYw0KPiA+IEBAIC05Niw3ICs5Niw2IEBAIHN0YXRpYyB2b2lkIHVw
ZGF0ZV9jdV9tYXNrKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sDQo+ID4gdm9pZCAqbXFkLCAgc3Rh
dGljIHZvaWQgc2V0X3ByaW9yaXR5KHN0cnVjdCB2MTFfY29tcHV0ZV9tcWQgKm0sIHN0cnVjdA0K
PiA+IHF1ZXVlX3Byb3BlcnRpZXMgKnEpICB7DQo+ID4gICAgICAgICBtLT5jcF9ocWRfcGlwZV9w
cmlvcml0eSA9IHBpcGVfcHJpb3JpdHlfbWFwW3EtPnByaW9yaXR5XTsNCj4gPiAtICAgICAgIG0t
PmNwX2hxZF9xdWV1ZV9wcmlvcml0eSA9IHEtPnByaW9yaXR5Ow0KPiA+ICB9DQo+ID4NCj4gPiAg
c3RhdGljIHN0cnVjdCBrZmRfbWVtX29iaiAqYWxsb2NhdGVfbXFkKHN0cnVjdCBtcWRfbWFuYWdl
ciAqbW0sIGRpZmYNCj4gPiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9t
cWRfbWFuYWdlcl92MTIuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21x
ZF9tYW5hZ2VyX3YxMi5jDQo+ID4gaW5kZXggYTUxZjIxNzMyOWRiLi5kYjYxNWI0MmIyNWMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2Vy
X3YxMi5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5h
Z2VyX3YxMi5jDQo+ID4gQEAgLTc3LDcgKzc3LDYgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2N1X21h
c2soc3RydWN0IG1xZF9tYW5hZ2VyICptbSwNCj4gPiB2b2lkICptcWQsICBzdGF0aWMgdm9pZCBz
ZXRfcHJpb3JpdHkoc3RydWN0IHYxMl9jb21wdXRlX21xZCAqbSwgc3RydWN0DQo+ID4gcXVldWVf
cHJvcGVydGllcyAqcSkgIHsNCj4gPiAgICAgICAgIG0tPmNwX2hxZF9waXBlX3ByaW9yaXR5ID0g
cGlwZV9wcmlvcml0eV9tYXBbcS0+cHJpb3JpdHldOw0KPiA+IC0gICAgICAgbS0+Y3BfaHFkX3F1
ZXVlX3ByaW9yaXR5ID0gcS0+cHJpb3JpdHk7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgc3Ry
dWN0IGtmZF9tZW1fb2JqICphbGxvY2F0ZV9tcWQoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwgZGlm
Zg0KPiA+IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2Vy
X3YxMl8xLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdl
cl92MTJfMS5jDQo+ID4gaW5kZXggZDA3NzZiYTJjYzk5Li42ZTU5MTEwM2MzYjYgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMl8x
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJf
djEyXzEuYw0KPiA+IEBAIC0xMzEsNyArMTMxLDYgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2N1X21h
c2soc3RydWN0IG1xZF9tYW5hZ2VyDQo+ICptbSwNCj4gPiB2b2lkICptcWQsICBzdGF0aWMgdm9p
ZCBzZXRfcHJpb3JpdHkoc3RydWN0IHYxMl8xX2NvbXB1dGVfbXFkICptLA0KPiA+IHN0cnVjdCBx
dWV1ZV9wcm9wZXJ0aWVzICpxKSAgew0KPiA+ICAgICAgICAgbS0+Y3BfaHFkX3BpcGVfcHJpb3Jp
dHkgPSBwaXBlX3ByaW9yaXR5X21hcFtxLT5wcmlvcml0eV07DQo+ID4gLSAgICAgICBtLT5jcF9o
cWRfcXVldWVfcHJpb3JpdHkgPSBxLT5wcmlvcml0eTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRp
YyBzdHJ1Y3Qga2ZkX21lbV9vYmogKmFsbG9jYXRlX21xZChzdHJ1Y3QgbXFkX21hbmFnZXIgKm1t
LCBkaWZmDQo+ID4gLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21h
bmFnZXJfdjkuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5h
Z2VyX3Y5LmMNCj4gPiBpbmRleCBkY2Y0YmJmYTY0MWIuLmFkMGRjYWVkM2QzNSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5j
DQo+ID4gQEAgLTEwNiw3ICsxMDYsNiBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfY3VfbWFzayhzdHJ1
Y3QgbXFkX21hbmFnZXINCj4gKm1tLA0KPiA+IHZvaWQgKm1xZCwgIHN0YXRpYyB2b2lkIHNldF9w
cmlvcml0eShzdHJ1Y3QgdjlfbXFkICptLCBzdHJ1Y3QNCj4gPiBxdWV1ZV9wcm9wZXJ0aWVzICpx
KSAgew0KPiA+ICAgICAgICAgbS0+Y3BfaHFkX3BpcGVfcHJpb3JpdHkgPSBwaXBlX3ByaW9yaXR5
X21hcFtxLT5wcmlvcml0eV07DQo+ID4gLSAgICAgICBtLT5jcF9ocWRfcXVldWVfcHJpb3JpdHkg
PSBxLT5wcmlvcml0eTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBib29sIG1xZF9vbl92cmFt
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmkuYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3ZpLmMNCj4gPiBpbmRleCAwOTQ4M2YwODYy
ZDQuLmMxOTJjNjZhNWM3YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfbXFkX21hbmFnZXJfdmkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jDQo+ID4gQEAgLTczLDcgKzczLDYgQEAgc3RhdGlj
IHZvaWQgdXBkYXRlX2N1X21hc2soc3RydWN0IG1xZF9tYW5hZ2VyICptbSwNCj4gPiB2b2lkICpt
cWQsICBzdGF0aWMgdm9pZCBzZXRfcHJpb3JpdHkoc3RydWN0IHZpX21xZCAqbSwgc3RydWN0DQo+
ID4gcXVldWVfcHJvcGVydGllcyAqcSkgIHsNCj4gPiAgICAgICAgIG0tPmNwX2hxZF9waXBlX3By
aW9yaXR5ID0gcGlwZV9wcmlvcml0eV9tYXBbcS0+cHJpb3JpdHldOw0KPiA+IC0gICAgICAgbS0+
Y3BfaHFkX3F1ZXVlX3ByaW9yaXR5ID0gcS0+cHJpb3JpdHk7DQo+ID4gIH0NCj4gPg0KPiA+ICBz
dGF0aWMgc3RydWN0IGtmZF9tZW1fb2JqICphbGxvY2F0ZV9tcWQoc3RydWN0IG1xZF9tYW5hZ2Vy
ICptbSwNCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo=

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88B7C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 06:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDB7113865;
	Wed, 24 Apr 2024 06:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BE7uLSsu";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A50113865
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 06:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtHwWC0BvILUn6iwFbc2PF4yux8I6DrQY/UaXy74peSyvoIw8yZ7e979qbDlwTUk5tVse31J0k0XgiJxksMHh7s0pr6v0kapUA77z0e1oFIv1HZh2IrCmmgaVRys+MAEzaVnk/S6V/ACOw8HO+2C+TTD86XqwJhPRzDiq4eD4vaO6AB1H6kxm0Xeuk65RDrto//cITYVMcpFdGsfZKG1bWeBq96D3j8DOJnYlB0ER9ZXhze5EpD7FgB+qmTMohYwJTPIwxoZmatHfw8vmRBFeDf5i8Si6pVkvBghAUC/mRMBCQRVjhIYNkBrvBvQRpum55PGdxPaMmri2SY8YUgqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk3cdK43b285hscokWnKSHXD6WL1B4kBDINq1VcHZiE=;
 b=gWUg6riQao/1vY1Ues6vBfUVnEx11BI9OI8Oy1bOxMbUjEkDRYouv7GxhyvC3DZFYAze/1nWLVLdr7v9my92Y+HZTrSUeP9Q4w1CDld5Pa35HIsOjY2arMLf1v9e3lPHcX1M9R5yN14vv2+Cpl3Gd07rZe5wmWvpkzDj48iz6TaUi433Tq4GkjTHVzUzEX9jeuy219hskz9F3qSVW7IB9uEkWbUF9aH9TxVmAUct36grlqgfbSyO2G2VE6WxY8/PSmfcbYrRCLUwYNe5vHSIzdyVzNQ4OndqSqws7gLmO9TSD0Fi4sszWzQ6kQY53TCy3pjrMNQo7Tj12TXvstPx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk3cdK43b285hscokWnKSHXD6WL1B4kBDINq1VcHZiE=;
 b=BE7uLSsu5uI3j5iXAlN/Q8+MGTQjW3rTp8aHsTAzsowK2HhKcN1FH5CuQgUby8FhqYKT+ndCUkhIt6w7wbtxppS1qn5JjRA9mriagO3pRMTIPmHmLlBH8ulWtHBgMkpBnJ4zAxfjxr1xRkARKFT+2QUT/V0Ecabd0wJZFelE4vc=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 06:41:03 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%5]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 06:41:03 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix double free err_addr pointer warnings
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix double free err_addr pointer warnings
Thread-Index: AQHalT+r822L+FDCCUapuC88+smyhbF2+T5A
Date: Wed, 24 Apr 2024 06:41:02 +0000
Message-ID: <CO6PR12MB53942B3174B3DB3D52DFA60F94102@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20240423053239.884297-1-bob.zhou@amd.com>
In-Reply-To: <20240423053239.884297-1-bob.zhou@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6a7c61d3-65c0-4e5d-8467-e214bd895665;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-24T06:37:31Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|SA3PR12MB8437:EE_
x-ms-office365-filtering-correlation-id: 69e1fdc6-e02f-4b84-fd21-08dc642982c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?VjdZZW90MytHMFRlT3U0L0x3czlSR3FEK2grSU1nTmZzN0RnMmppVDdv?=
 =?iso-2022-jp?B?QUVmS3pEcDk0SmhQMDJBN01XTWllSm43bXlZcVlGT0hmWTl0ai9zK2k3?=
 =?iso-2022-jp?B?K3JYV1c0ZjZ4RXhxcjlFNFkxbG1YcFZSY1h6eUNHOTZKTSt4eW1JS2x0?=
 =?iso-2022-jp?B?dUtyVHY4OU03REtGbXdOUFZSN2EvYnY4czZlWDY5MWh3ZnJvRjk2ZGlw?=
 =?iso-2022-jp?B?eXVYaGJNcWNxRk1KcE15Yll3NnpJckxLc1hNV2p0b0JzVnJnTXhuUHNW?=
 =?iso-2022-jp?B?VEFSZExyOVQxSXgrZ1NWSmF0aVEvcENvbGQ4VWc5SHVQNEpiSndzMk9D?=
 =?iso-2022-jp?B?Y3dybkNVSjM3MFFrVVM2cTFwT3B1MFZORXh4emEybHcvUXpFak92ck1E?=
 =?iso-2022-jp?B?dUtqRjY1SjR2RFJkaWtSajVGb0N0blNBT09EeFpucTBzS1IrT1E0cEJq?=
 =?iso-2022-jp?B?T0N6bENVZ05uRDlLOWc3Q21VQ3lkZXY4YUhpNjl0RHd3cDRpbStaRWpM?=
 =?iso-2022-jp?B?THRPdHdzYURUUmtsQ2xhRFpJa0tPcDNJWDU4MHNJTFp4WGlUZVBmTHIw?=
 =?iso-2022-jp?B?MFJZTzR1M2Evc3lDc0dLdzhvZGFnNXFxY1NpS3RGenBMOU5WMlNPbkVj?=
 =?iso-2022-jp?B?VkdEMm01RzhFQ3VtOGpjZlhiTTViYmxiL0FwLzBtdjRLTGhxRFdWT3R4?=
 =?iso-2022-jp?B?VmlobnNoZjBFdElCZHFwUWlad3RDam9NQXJiVDZ0bjZzaitPMDA4TVZX?=
 =?iso-2022-jp?B?aTFyczd4bW9TWnp5ckF3dzRCbFAyOEtmUnE5MkdZUmduQmpIaEUzK3Jo?=
 =?iso-2022-jp?B?OTRNRTExTmV1OUFwZzNSdDJNaFNhWjREY1NDSitGMEN4M0NkenNWUzcr?=
 =?iso-2022-jp?B?a3BsTUpHVWpaU2dlQ2JaQzZoZlpienc4SlVFdmQ5YUw0Y3F0WTdDQVdC?=
 =?iso-2022-jp?B?aUJzek9acUJlNStIVGZ1Vlh5V1lLbys0L0w4d2tidWxDc0g5ZGRLUmZt?=
 =?iso-2022-jp?B?elM2SzdIRWlVcW9wUFlBWE8yNDJaSm13bk9mQTBjZmVMaGh2bk9vd3hQ?=
 =?iso-2022-jp?B?NXkxYU1LN1NIak05T09hUlFYSE5Ub1o4VkhaSEdjeUdja0J2b2xyTWwv?=
 =?iso-2022-jp?B?YjczaSsrVXNMY0hOVlhWNlZQSGZDdWZkMUttWmcyUUdNeG9uQlhaK0Jr?=
 =?iso-2022-jp?B?Wjh6Vmlta1RsWlczb0JmdE4xcFAveWtINFgrQk82emQrbUlsUjFIakJF?=
 =?iso-2022-jp?B?cE9UdjNnNDZIdXJac2tKWVhTYXZiYmZPZnZsdTFRT0tJVHJTWkxNclBF?=
 =?iso-2022-jp?B?NXkyNXN0WDVwWjkxNlJ4bXNMejNEcmJTSkh0NDVOUUYyTzRGV2gzQmpK?=
 =?iso-2022-jp?B?bGdwK0xrYWlTWjVLc1JRcGxneCtwUjg2TzgrK29Vc05HNEhSQk1uT3A2?=
 =?iso-2022-jp?B?R2VXdzF2YmpFK1RwTnJRVHVjMDkwZ2ducWVmOW9GajA0UjlQaEVYZkt1?=
 =?iso-2022-jp?B?OFpVcUxYTjI3QWVaclowQndmNDFISEhzTXBXWCtJQ3FsbGh1dUppWmJh?=
 =?iso-2022-jp?B?SFluc0haN3VkcEpObWh3WVpuTkRZYkdxWUIvR3FYTXQyRmk4M1o4RDJi?=
 =?iso-2022-jp?B?QjcramY4cFIzSnA2d21oVDBnYWhsQkNQYXd6T1d6M0RpeWZWQmRJbUFk?=
 =?iso-2022-jp?B?b1NzaHYyQ2pVTzM5TUdwMjJBUGdmY3FjQkJTQ2ZVeUN2eFBTekRNcjZi?=
 =?iso-2022-jp?B?WTlLb0M1MVhYNy9MOGxyM3EyYVRuQU5tSk1uSVM0ZGdNd3NDK2pGTE5U?=
 =?iso-2022-jp?B?R2tEZktkeDNEaWM4VEFRemxXUmxzV1R2OFVadDZEUkVnYTVYY1RIc3My?=
 =?iso-2022-jp?B?ekNyRUJ5aVZlRGFMOVFOSTdCWEJRcUN5ZE1YTXZOdzF6ak1ZclBvTjN5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZkVVZ0Q4NkMrN0NMUTBVMVZ6dzVZVWF5ZGw4S0tOa0hLejJTOThQS3Jq?=
 =?iso-2022-jp?B?MGdIS09XRjh3b3dYZVBjaFBEZkRhc1dTS1pDK0tVL2hzcS8zaTZMaU9y?=
 =?iso-2022-jp?B?U1lvRUZmQUZtamlPd2pzbjAwK2pNM01Pb0hTYUIxbUFMcjJtZlAwOHVz?=
 =?iso-2022-jp?B?djQyVitudUtubHMxd3ZaZjhENjBTWGV6ai8xUjhobTVjTk9GYmhpMm1M?=
 =?iso-2022-jp?B?emI3bGF3U1hsL2pxK3F0dFdFSlV6TzZoK3h6RGFTZEtZMEFzLzZkS0VV?=
 =?iso-2022-jp?B?alZ1TFVIUUVvYklzQlI5UlJhZ3NxaDZjd2U2M2ppcHZibU9PcWVZaW9Y?=
 =?iso-2022-jp?B?akh2UGdncmF6L1FTbWIwZG9OYnphYWVuZ3hnQ0dTeHBSU0xlUndBUTZn?=
 =?iso-2022-jp?B?ZDluUkZZWVpQcDZRT1ltU2FrNjBhaHVaRmtSeUUvcE92bGRQakJQMFA0?=
 =?iso-2022-jp?B?cVVOYjdma1QreEtDalZjemhXWjFBdHJHZG5oOTRweFVzbVRpV1ZWc05O?=
 =?iso-2022-jp?B?N1BESDNoeGIwQTBwMVBqbnJheXNaVDRpWFJzWWFka2ErS1lPaEJUS28w?=
 =?iso-2022-jp?B?ZGdrYzc5KzNyL3puOWwvMTlOS1hrS1FLMG5jMzB3cFV6ZVNqWHJ2eUV3?=
 =?iso-2022-jp?B?SFZxcUdkWGg2RUlCZWwxdFJRWTY2aW96Zy9jS05WTHBLS0ltb3VTd0VV?=
 =?iso-2022-jp?B?ckRjN1RnbTVtampENWZtWHRRZUhpeDkvdHIvYVhPbTFqLzRHbExJaElh?=
 =?iso-2022-jp?B?bHZWdG9pT0thZzhNQ0RJRzNpTDloajZITDVuY0JEbUNyZU5uVm1KWklt?=
 =?iso-2022-jp?B?YVllYmRQcFNKK2JiVitYcVcrT09BWVRBeElvVENOWVBiM2FyVmJkZm1a?=
 =?iso-2022-jp?B?MEhGREoxUGhxYk10cHRueVpLaWhFaHN2M2JJdWVaOWU3TTRNVndvczBW?=
 =?iso-2022-jp?B?MXd4bkxWNzExcDZ0V1pIVjJadVhiNlQ0M3pKOVVpMlFSY2FjdjljZ2pN?=
 =?iso-2022-jp?B?YW9lQk83VXRQN1gwWkdNNGx4SENuRHUzdkdBUjQ1RHJGUGtQM2NhTjZU?=
 =?iso-2022-jp?B?V2NtWWhBN0VQVUNnWEdSdWtvOVhpS3l5YWlIYWxnVy9YcjhEb0lXWFUw?=
 =?iso-2022-jp?B?eXpZS2JER01pdnpxUC9LK2g0RGxDRXJFWExYT3d6NHpVRGZLMnBwTTN2?=
 =?iso-2022-jp?B?bGFRSk45N3dMOFE5WDh6emtUTzNsU2tDaGVGMjh2VFRyTE5UL09OYTZV?=
 =?iso-2022-jp?B?VkVoWW5MSDlQNlVRbEpoZ1Fzb0d2UHM0UGliMWVnN2tURitnbkgvMUFK?=
 =?iso-2022-jp?B?R24xRWlTSWxJRHlHdnkrdWEwWk85UkY3WVVZOXFqSXZwN1l6RE1MMHdY?=
 =?iso-2022-jp?B?aW9iVmRCRlhvWjdKQ3h6UnFsTk14WktqZ0d6NzBONXNEQzl2MlAyMHJj?=
 =?iso-2022-jp?B?K05JZFpmYmRFbHgyUnF2cDdUSkdHVWt1alViZjExZ3BON3dXbXl4R1Bl?=
 =?iso-2022-jp?B?MnRHS0NnaDBRenk3VXkzQnU2dGtQblZPY1hJUWtjbmc2bFIrVDUwNzNs?=
 =?iso-2022-jp?B?MUgxMWc0YW1rZjhiWTBUZjdYbDhpV0phejZWMllMdFNUNmFDRWJacXJ6?=
 =?iso-2022-jp?B?UWgvL2lERXhtWnI5UDlTUmF6RUZpelNrSzhCSHpmUDloT2hRL0FKbDBX?=
 =?iso-2022-jp?B?dVF4V25zTUg3ZHJ6REE4YlpnWWFIeURzWTUvMnAwUFVnUDByNWJHdnI1?=
 =?iso-2022-jp?B?a3Z2QWdTZXYvWnhtOHdqTS9WNVBnMFNVVEdGbXBJazBRZDk1VFFZSUpn?=
 =?iso-2022-jp?B?YmlVdEdzOFNsNmdxR294ZTB1a3BGVUZDRURRQklZZUFNR2tBMVArMHNC?=
 =?iso-2022-jp?B?UXRCQTMwbXpGQ0F2Z1NYZVI2OHdVMnFGcWllSEh4dEcrN042clFrb3VX?=
 =?iso-2022-jp?B?cHBUZGZidVFyMk1ocXFSYVhvZVJPNDVLaElLVWdqWklrZ1h5OFJodkli?=
 =?iso-2022-jp?B?SkEwbDRyNjE5SmlxQ1daUEowYkRmbDJQcmU0MkhmSmxLbFIyY21BUmVF?=
 =?iso-2022-jp?B?VGxYcmNLK1Q3Mlc3U2tZQ0xETTl5eXpxTVBMcHFZU3FWL3NyNnh4dG4w?=
 =?iso-2022-jp?B?UGNCbjBWYTMwRFFSVy9tNkV6alBjM2t4ZDhQamVHcVJhYk15c0Q1d1dU?=
 =?iso-2022-jp?B?RklWa2ZMU00wU1N0ckZMUE1EMzVQSXJUcEM5ZjFVVVhCQUwvSTVrazha?=
 =?iso-2022-jp?B?ZHBHTW1jVkx3MlRqOE1rQzYybmo2QnZtYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e1fdc6-e02f-4b84-fd21-08dc642982c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 06:41:02.9876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPSdXKalEuRTLqUXzZQq7XyZhHUcJEgWvZGJadumDX6p5XdvfoXedj1FoIYnVuN6+J6LIufcs9vX+Zyi2n+eVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437
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

[Public]

Ping


Regards,
Bob

-----Original Message-----
From: Bob Zhou <bob.zhou@amd.com>
Sent: 2024=1B$BG/=1B(B4=1B$B7n=1B(B23=1B$BF|=1B(B 13:33
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Zhou, Bob <Bob.Zhou@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix double free err_addr pointer warnings

In amdgpu_umc_bad_page_polling_timeout, the amdgpu_umc_handle_bad_pages wil=
l be run many times so that double free err_addr in some special case.
So set the err_addr to NULL to avoid the warnings.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index f486510fc94c..32e818d182fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -170,6 +170,7 @@ static void amdgpu_umc_handle_bad_pages(struct amdgpu_d=
evice *adev,
        }

        kfree(err_data->err_addr);
+       err_data->err_addr =3D NULL;

        mutex_unlock(&con->page_retirement_lock);
 }
--
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9315C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 15:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D600410E756;
	Thu, 23 May 2024 15:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="St8s3kjO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED9210E756
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 15:35:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIi4j4vfihMosX/7Umeon8kZW6xyD7lPltZf9wYlhqoE7yyNPCuz3iaTf5C1+p7aAaLFOI2Na/MZFKcxsT2uZ6u4sRy3FCxEox1hwVuIRAhbC/hsxuZIvE600Ap7YJo90QpudVDk0ORgAYy1FSSvMVymmk5vcS6k7t4ppJheIjYqcI3lkFLslP6LKwk5pdUU99k1W3vjXEPmm6PZhj5+rD2KYC2O4xAOT94vaMk607fqIx8LkH2FS3ypWqFEq9N2sC1pAze7tG4ZvF73v//vmhtT9Hri0pLnPoj/lH1A3xmHxU4VjYqUn4NfmGyaGn6/5iY+2eyDpklo3iDLI93qpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peORXT9JdDnLeEf8AzuWcQ86WXZkukeGxQ7i+x4qruY=;
 b=ZTuFF5QK0LlEvosAdx0AIHQud57zhDb/zTDAvVyWo1MSzMfHaoKA9UncmVo0NeaTwRMONHtP0bvnnc4cwOVwxr63eLuQhJmAEumZ6HC0w3InmkXm3Tx1zoGuTYYv8DKsXplxOel4VGHcSWhELC29t9GdPvylNet6kb7yYfYpBFs5Z9caQ7gcZIz1zLfHLnKlbnvXBIGVG5OcR4+vTJl+tSZhhfsQjs5xKItywXgpfYyDt6Sje4PENi8zkBeleaStELxJnJTKGUFFKt8ll8WE2CeF3NCBZ40uZSmUcgdgjpZpdIlElAAs8x+HprIrOav0/vYy0/WLGuenoEGlBxi+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peORXT9JdDnLeEf8AzuWcQ86WXZkukeGxQ7i+x4qruY=;
 b=St8s3kjOxI+omUdeyj/VLuDcytg3XVrEYT11hdrrw1oCSqxBBAz2S43UEYLlSyNaTxuv7AaU92a+OglDIgNsRna7vFgJx8UljSvWOujBCYbrpJ02B5LDGUpHoOexOIiyyQAg/4UaODgt8nuUJ8sKkHg+ian3aQYjZhAF5kDqSRo=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 15:35:07 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 15:35:07 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
Thread-Topic: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
Thread-Index: AQHarG1nW5oS5CkfwUKJjHmhvnayr7GkaWCAgABFTCCAADpRgIAAA26A
Date: Thu, 23 May 2024 15:35:07 +0000
Message-ID: <SA1PR12MB8599A25B022AE47DFD501021EDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
 <20240522172721.14085-4-Yunxiang.Li@amd.com>
 <5025dc06-8471-4f74-affc-1070fc7e6dca@amd.com>
 <SA1PR12MB8599116F019C2EFFF427C50AEDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
 <38598dc3-c815-4328-afa5-6eaa9997c755@amd.com>
In-Reply-To: <38598dc3-c815-4328-afa5-6eaa9997c755@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=199c301a-29cc-4820-9f4f-4f5f6560f24b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-23T15:07:04Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|SJ2PR12MB7865:EE_
x-ms-office365-filtering-correlation-id: 58f89313-37cd-4931-59da-08dc7b3dec91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cCthMk1IR1VLRTFnOFozczVGa3FLZG1WeVdFd2JYeHhYSGRhS2lqalVaMlhv?=
 =?utf-8?B?bmk1YXdtNWEvVUxTczNSdUVPQzlncEJUOVBvNkxaZUFaU1ViVTh5cno5dDBZ?=
 =?utf-8?B?elIwWk53Tm1FdVRONzJZNks0aCswbGNXaG1CSHZtNmNmR0dwelZqc2pYSXRn?=
 =?utf-8?B?MVh4eVFJcnVjLytDczVnR0IyOG80dXlJUlF0YWFmaGE5Qm1UdkFGRmFNeUY4?=
 =?utf-8?B?bXppcDYySnJOQjdaN015TGlzSGZWSEpWS1IrRlhnUkVLRjkvNk5qRENXRlBH?=
 =?utf-8?B?N3djSnFKVEQ2ZXBXTlF5Ly95aytMLzBlRkZXQnlOR3JKcGVnaHUrT2l6aVds?=
 =?utf-8?B?VHU0L0FPSmpwMmlwNG5EcTc4MU5hRzd6Q2NldEtSM1ZxMlhHZ2tvMTAwRDJW?=
 =?utf-8?B?YTdpZWVlSnhPNXZRdFoyUEtLZExZM3BYQ0pmVmU4cnRjdEJjUGRoKzNkeXZI?=
 =?utf-8?B?VGdPakM2SmxtN1JiUXkxMGxJN1puWXhQelNKa0pjdmMwUFlKZG5IMHlzckNK?=
 =?utf-8?B?YTBsZkZXZEZJWTh6Q0ZqRnU4WDJZaTcwWjFLRlNEN1oyR3F1OW1RRmVsbjkw?=
 =?utf-8?B?OFpYcERZbDVsQlhFZEtBVUw3SEpjLzlTSnpQMkkxNVNNTTE3azI2N0lTSEdl?=
 =?utf-8?B?N2tCOWpjR1ZzYnVybmR1TkdTd0x1bHlEdFVxbTR4SnJXTlRxUDlUYWhNMmFi?=
 =?utf-8?B?VlRMdkFIL292WXhsVjE1RUZaSmRmV2VpdEhKNFZId3VIVnIraDh3T2RDblIx?=
 =?utf-8?B?TlFlV3p1MWNzMlQ3dG9PMDE1L2lXbDJaOXREd1ZwWjVjYXkySmRFNUE4VkY5?=
 =?utf-8?B?OThsd0E0VFIzb3EzSTMwc0lWenhXclhOaHE2L1phQ0RZSituajVra3d4dENt?=
 =?utf-8?B?YkxpVWlKQzJBay9Ga2ttVVFET3h0elRhMnhqSmcwUlZGemlrWVAzTFp0VkpV?=
 =?utf-8?B?ZTY3WTFqeEg3c29EUytxS2xaaTA1WjJTcmhJL3I0cUJ0OThDU1lLZnV2bGxS?=
 =?utf-8?B?YVJoK3lQWlliRGxpWTlNOHdxL3J6dCs0L0VGdGVoVWhWTWR0NTJOT2hsbEht?=
 =?utf-8?B?eHcwTUdZMUZsTU9qNDdld09NaC94Zi9iR3E2Zi9BSUFRa2NKT1d0V292Yk4v?=
 =?utf-8?B?MkpoVk1wb3k0bnBDVkxJNFNWMVNGVUZKWFFjUzBXQVlLUlBzd1NlMEdEWHll?=
 =?utf-8?B?bWt1Sk0xdVdzbkRTcFU0WFhraytHQTE1bnBVcG05dXJMdUNocnZGU3JpS28r?=
 =?utf-8?B?QTR1djdUNmxxMWUraFBQR09Yb1l2cEtmNG82ek1MQ1BNcTNKVEYxbXpYak9W?=
 =?utf-8?B?NzNmV1cvM25jTlpRRVA3SjMvVnZ2WWNBUlpOVkZ2RlVvLzRlaWpEY3JId2My?=
 =?utf-8?B?MG5Cd2dyWW1tbko5UWtDbmIrZ1diTGJuSTYxeWJZTXpyc0tMdEJnOVNVV1Fn?=
 =?utf-8?B?dnBuOFlKeUdwdXo1djBBVkpQQnNvbmNnWDluL3NaUVdNeFhhRmJjT3IweVlj?=
 =?utf-8?B?a1Z2eG9sS29HUUcxck9pbkR6ZWV0WTJpNGo5Qk8rR20vYmFBRlF4dWFWZzcr?=
 =?utf-8?B?NmxtMmJqMkp0MDJQcTF2RXE4R0pva0o0dVNrMWpLN3h1dWlYbHNVc2lKWDdR?=
 =?utf-8?B?SHpNQkIrblFhQVVpSEhGZlAvRnhpL2MvMmtwUUhScTBNVVVNMDNkc2dTcjJ2?=
 =?utf-8?B?K3ZEd1Z0cG5OWU9MQVBqdTNwNjcxcGp0WHFuNXRmOElPeFZJSWdvY2dNWFN2?=
 =?utf-8?B?aFRDcVROSy9ZQ1piNWV0eW05SDVzSTU2endjUm9OVEozUXkyQWE2WWs5VXhm?=
 =?utf-8?B?cHlTeVZXaFN4bmxPdERDdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE8yc1VzcTlTUG4zVnpGMDBDY0R5MUdaKzdxRVkwUXlvWFZERXRCQlI4OE50?=
 =?utf-8?B?SENDait0V2txeWZoazhoQ2IzNGpMMzlCVGdjRCtxb1Y1VWN5MS9JdHdTQ1c2?=
 =?utf-8?B?SlNYYjFOdk5waHlJdFJOaGxZU1FIeWQyOE5pVGdOaGtTeEg4cHRJVkwvNlNM?=
 =?utf-8?B?cUp0TUZlRDJ4a2xtSFRIcDZrWjdwNjRTOU5DYWUvRnUrZkIyemhpQ1p6YkhX?=
 =?utf-8?B?Zm9jZjJzVFhTWUlSR3FBTG8wMG4vNWVJekFxSVZpL1hmeEZkbC9kRzRuU0l2?=
 =?utf-8?B?WnRqeDkzT05uOC9KNTF5RkFPd3BSaG9HMmR3MCtYMDhQSHIzUGp4OElHbXZO?=
 =?utf-8?B?a2dIRFRkVGplWDFCS3QwMzJqeXo1aWMxekhrQ2ZhQWhBVFArcjhoZU1TYnlT?=
 =?utf-8?B?NnFMblF5T2tsbEZoU085VEY0SDMrSU5ldmtkU3lkYzliWHFSYU4vOG4yVkI0?=
 =?utf-8?B?K2NIUzVnd0dZWDU3NTJORytsRVA1TFRDbU1QYng1VTRzR1N3NVhma3VaeTJw?=
 =?utf-8?B?MGZIRDNLVDJWaWxjL0NyZmhuNmw0OEFPcW0vdjN3VDFrL1FUZ29SNHlQMFRQ?=
 =?utf-8?B?bGVIeW9HNDFBTHhUQUVZS0dvdFB4SXNkUDRONEU4MGJyak8rMXo2RUZwdVVR?=
 =?utf-8?B?Mm1rQjFyaHR4c3FLNk4rdHBLeENVMWQyS0ZuY0VNUXd6QlpVVmd3UnU5YkFu?=
 =?utf-8?B?Mk9NSXBDL2RzOGQ4Uzh1R094QlNQUEM0bVFGY3V0V0RkMzFmMDNlNThaV3d6?=
 =?utf-8?B?cUpMalc4UEFmenhSQjlxWU9GMmxnMHZiNEFINWYrbm8raGpxREpZRUhzOXZj?=
 =?utf-8?B?WFhEUi9qaFlIb2JqVzdubjBDbVRBSG56S2JYVjBJTWZTdVZZaitXcTd3VFlp?=
 =?utf-8?B?UkJHZjVSaXYwL3hVOTlFajFuZ29mNnlKUERHUitZYXZHMytRMDZ4NjIrMkNX?=
 =?utf-8?B?dERmcGk2SnZObEsyOUJoL3JiNjZLWkVIRXUybzNkeGwvSnJjRVhtYzdvV25F?=
 =?utf-8?B?RlFuTGdzMWFteWVFZjB3b3ByTnVrNi9TNEtMRjlRSHIwK3ZtSzV2YTVtU1dh?=
 =?utf-8?B?RURhSXpxa1NOSHN5Mm5PMWdXMTRMSXZBQzVaOU9LT1ZVbjhmekRuaUdCeXFQ?=
 =?utf-8?B?UkJYRSsrNnNtQUlUZ3NndnBRRzc1NFg3RVB5QU90cmt6RnE2M2tHUzFsdjRL?=
 =?utf-8?B?aXU3bHpsbnJnNmkxTUZ2SWd6cUVhV3ZacXUycC9yWi9QaERCVUEvS1E1QThK?=
 =?utf-8?B?MmhwKzBWWXFHRkx5VHpnTmJXOVliS0lZNXFqK2JWc3ZhakZLcWdGalRxYXVP?=
 =?utf-8?B?TWlDRGZSTDhDK3UzbmF6bmNxVWlzb2RqNGhBYk11d3k5djlxbFhBL29odlkz?=
 =?utf-8?B?TnZ3aVh6TGkvYWpWamwwTi9PMkxpdWU4VzJMRHdZTU5kUnFIQS94UHlraGhS?=
 =?utf-8?B?cHkyR3h3b2ZQV1JIb0dzdC80RDB3SU0xeFlxcERtNGZ0YS9ZUnVZZFViSlFQ?=
 =?utf-8?B?NERFd0lUem90WWZENHMyL1ZyUUJaK3RhcWFXVkNKZDY0SXFjblR4c3plS1VK?=
 =?utf-8?B?Q0d1RUw0YW1mNlk2Q0hHcW5xem9iS2dyWkFRdDlZdXphVWtma3lESmxhWnhK?=
 =?utf-8?B?Qm83STFNc1BQM09LTlpzVVQ5anpQUjdsemtuMTJ0QU95WHliZ0luVGNKV3kx?=
 =?utf-8?B?NWdUL3V2R1hvbjFJSmRSbXJvUktMUjFqU0RXbEZhMDdxWHNPaVFvakMxRzFu?=
 =?utf-8?B?MlRzVDJ5emdjcTZMRHIyVmNUS09iSm83bUpsZ1hYZUQ0ekZDRThzeWs4eDZV?=
 =?utf-8?B?WHdzVjRTak12L2l3cEk3SCtMMklsWUM3MmtGU3ZzcU9INXBpb0llVVpjNk5L?=
 =?utf-8?B?NVdVTTVrZ09GZm0yZHBIRGl4Q1hOTVRwTkdMR3hhZ0ZBUDR4bEVaVGpxa3lz?=
 =?utf-8?B?R0V6cGx3VGU2MTduN1B2Mjd5ak5hOWxodmd2amFPelNhc1pLTkxSYXRBSlRX?=
 =?utf-8?B?UWRYWFBvNGRqSmJaVW00MFEvUzliaGpEUDNMU1MzVEJDbDdqUVhLMW5aNVN2?=
 =?utf-8?B?dHM2cnY4RjhKaU5QVk84bkt2bUZoTUxNeUh6U1ZMYkptQmpOTVFLbUFIdUJ6?=
 =?utf-8?Q?Lovs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f89313-37cd-4931-59da-08dc7b3dec91
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 15:35:07.1401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAs75J0ZIytTWHSMDSCgJGhCIIVEs6FeqZ39K01PR3Pd4LGvofb1DlMnAUKz7yiWcs+YjZC0X5k2bwVo/4LF0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

W1B1YmxpY10NCg0KPiA+IEhlcmUgaXMgdGFraW5nIGEgZGlmZmVyZW50IGxvY2sgdGhhbiB0aGUg
cmVzZXRfZG9tYWluLT5zZW0uIEl0IGlzIGEgc2VwZXJhdGUgcmVzZXRfZG9tYWluLT5ncHVfc2Vt
IHRoYXQgaXMgb25seSBsb2NrZWQgd2hlbiB3ZSB3aWxsIGFjdHVhbGwgZG8gcmVzZXQsIGl0IGlz
IG5vdCB0YWtlbiBpbiB0aGUgc2tpcF9od19yZXNldCBwYXRoLg0KPg0KPiBFeGFjdGx5IHRoYXQg
aXMgd2hhdCB5b3Ugc2hvdWxkICpub3QqIGRvLiBQbGVhc2UgZG9uJ3QgYWRkIGFueSBuZXcgbG9j
ayB0byB0aGUgY29kZS4gVGhpcyBpcyBhbHJlYWR5IGNvbXBsaWNhdGVkIGVub3VnaC4NCj4NCj4g
SWYgeW91IHRoaW5rIHRoYXQgYWRkaW5nIHdyYXBwZXJzIGZvciByZXNldCBsb2NrIG1ha2VzIHNl
bnNlIHRoZW4gd2UgY2FuIHByb2JhYmx5IGRvIHRoYXQsIGJvdCBkb24ndCBhZGQgYW55IGxvY2sg
Zm9yIGh3IGFjY2Vzcy4NCg0KVGhlIHR3byBsb2NrIHByb3RlY3RzIHZlcnkgZGlmZmVyZW50IHRo
aW5ncyB0aG91Z2guIFRoZSBmaXJzdCBjYXNlIGlzIHdlIG5lZWQgdG8gYmxvY2sgdHdvIHJlc2V0
cyBydW5uaW5nIGluIHBhcmFsbGVsLCB0aGlzIGRvZXMgbm90IG9ubHkgY292ZXIgR1BVIHJlc2V0
IGl0c2VsZiBidXQgYWxzbyBhbnkgdGVhcmRvd24gdGhhdCBoYXBwZW5zIGJlZm9yZSBHUFUgcmVz
ZXQuIFRoZSBzZWNvbmQgY2FzZSBpcyB3ZSBuZWVkIHRvIGVuc3VyZSBleGNsdXNpdmUgYWNjZXNz
IHRvIHRoZSBHUFUgYmV0d2VlbiBHUFUgcmVzZXQgYW5kIEdQVSBpbml0LCBjb25jdXJyZW50IGFj
Y2VzcyBpcyBmaW5lIGJlZm9yZSBHUFUgaXMgcmVzZXQuDQoNClRoZW9yZXRpY2FsbHksIHRoZSBz
ZWNvbmQgY2FzZSBoYXBwZW5zIHdpdGhpbiB0aGUgZmlyc3QgY2FzZSwgc28gbG9ja2luZyB0aGUg
Zmlyc3QgY2FzZSB3b3VsZCBwcm90ZWN0IGFnYWluc3QgYm90aC4gQnV0IHdpdGggdGhlIGN1cnJl
bnQgaW1wbGVtZW50YXRpb24gdGhpcyBpcyBpbmZlYXNpYmxlLCBhbGwgdGhlIGdlbmVyaWMgZnVu
Y3Rpb25zIGNhbGxlZCBiZXR3ZWVuIGFtZGdwdV9kZXZpY2VfbG9jay91bmxvY2tfcmVzZXRfZG9t
YWluIHdvdWxkIG5lZWQgdG8gYmUgc3dhcHBlZCBvdXQgZm9yIHNwZWNpYWwgdmVyc2lvbnMgc28g
dGhlIHJlc2V0IHRocmVhZCBkb2VzIG5vdCBkZWFkIGxvY2sgaXRzZWxmLiBJdCBpcyBtdWNoIHNp
bXBsZXIgdG8gaGF2ZSBhIHNlY29uZCwgbXVjaCBuYXJyb3dlciBsb2NrIHRoYXQgb25seSBjb3Zl
cnMgR1BVIHJlc2V0PC0+R1BVIGluaXQgYmVjYXVzZSBhbGwgdGhlIGFjY2Vzc2VzIHRoZXJlIGFy
ZSB2ZXJ5IGxvdyBsZXZlbCBhbnl3YXkuDQoNClRlZGR5DQo=

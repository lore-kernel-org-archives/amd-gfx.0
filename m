Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A605C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 09:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF6F10E4E5;
	Tue, 23 Jul 2024 09:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HqvVkW9o";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3972E10E4E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 09:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wwl0HGiOaVPmA/xT+3rRDqapQs+2FQabKxoklAwCtVhQB1hnG5+dPWwWNHuYTPw0ZKwcqJviCstCJgFNf9ViuTUjNubqM+H5GLinE4fsX823w6AuK77/0YralJoLh/bxSBv5MBetp2I/ZpuPNL25TuEm/to9vAnTLblWjus+eNBxyzPfEdgwaRBI9SCfLpvFPC8zX1poldUOCrJ7gFOAupJNHCzNq9H2wcM5rOzT9p5HChvu8IWd3JVSfPZJQ3ZHf8RnwB+puXa3raar9f74cndyMbCoGt7HvL1gIGdcgMp6qLKfau5We+JOWyosBaZdIfX5U72W3OY/17LhNq3sbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ujso5/A4cJ8Iq1am9KHLAVUv+QBiXFnkMIb0gz/2SF8=;
 b=j7h2M9/jJIo6hAOswtUm8YQ/+TgLkE0udOEbUPvwIF00/LgSqg46cRQsm/bPITcu8o0qGMjHMZ1vDQp4gDt59kRwPWPDN5AKtR4IsAD46mDzwkxTvWXyv0Q/D5c4HYHdP6oO5jgMXp7EoQN0ETiB82C8mQ7i+/MyWL2QrhXrFnHppFz5qpPWC7fVAsIEedCzdLIDpLGPRbAWpZuBqkYssev8bGd3rfJB694Um3wD96oA6yetlbUloYeQWRhChiJSk3wh6ntzo7C5qtak543Y88HrXLaFzGaZelY8ccf9oc4iod9TXmmXJKGLS0HI+trQzC/7Nwn/TmqwD0QAL5ylIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ujso5/A4cJ8Iq1am9KHLAVUv+QBiXFnkMIb0gz/2SF8=;
 b=HqvVkW9oyO6yLxH5V5CEsZ+6PrUKzzpmLRDSOvDrKIqb/7gCSdvsLwHT8Rjgx6vN8HiNX+rFm/9tiVC5J1xsH3dsf0PRfqC3KzsaCquM5dmKONbU3DZBpnU0o8Gnft/Qf+pAI87EZi0UlNfDAyf/lAMbpooV45+is6SZWNG+LuE=
Received: from MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 23 Jul
 2024 09:04:51 +0000
Received: from MW4PR12MB6683.namprd12.prod.outlook.com
 ([fe80::9e98:5170:cedb:5505]) by MW4PR12MB6683.namprd12.prod.outlook.com
 ([fe80::9e98:5170:cedb:5505%6]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 09:04:51 +0000
From: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: reset vm state machine after gpu
 reset(vram lost)
Thread-Topic: [PATCH v2] drm/amdgpu: reset vm state machine after gpu
 reset(vram lost)
Thread-Index: AQHa3K1aoIxkZIsPdkqRFQYZsWQrjLID5jgAgAAGh6A=
Date: Tue, 23 Jul 2024 09:04:51 +0000
Message-ID: <MW4PR12MB668323C00301AC048424BF43E9A92@MW4PR12MB6683.namprd12.prod.outlook.com>
References: <20240723030548.1283366-1-zhenguo.yin@amd.com>
 <5ceac529-39cd-4095-8193-e30932f37dac@gmail.com>
In-Reply-To: <5ceac529-39cd-4095-8193-e30932f37dac@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b84fae64-d11a-4583-af58-41b4d18187a3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-23T07:36:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6683:EE_|PH7PR12MB7259:EE_
x-ms-office365-filtering-correlation-id: e0c26d33-3b5a-49f3-f054-08dcaaf682ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dzMrZ24xbVJjeHpHWkhocnQvMUpBN09Ta1B3SkpEZWdIT3FiREdzMk5CYXZl?=
 =?utf-8?B?QnhGS3QzSTg5dlNGM0hUbWdDcFNmdjY0VkVEaWRwL2g4WmJwL1dsbVlHMFNa?=
 =?utf-8?B?dWZOeVdOM1BLcHhVRTh0SGh6ZFR6S09SbXNZMVVXWEQzaTloL0RJbVkyK0lH?=
 =?utf-8?B?b0VCNzV0ZU4vUjQxUit5OVE0aERrbjR5S05wVzlsUUx5bEx5UFRvczhuYjBz?=
 =?utf-8?B?VGpJR3JQVUE1SjRROVRETzkxTXZsTEIyK2FZS0RTNHVza3VLM1BRclcyamNE?=
 =?utf-8?B?WVpPNkJrdGVJR0VQcXRRaEk4OE9DcGVtbDAwQ0EyTHcwektKVGFybnZnMDBt?=
 =?utf-8?B?UENpQ2w5cjFWR0czTHY3NUFTS2J1cGdYalZGamNaRWNLRnFRU3lMWmFJVjU3?=
 =?utf-8?B?c2tvZHVQbFA2NjJiUjc0dHlDS3FqWDI1azVnVEtFczl4dEJLVFJjKzJTbFpG?=
 =?utf-8?B?dXo4c2pabGdQdG5RTzRzZ0tYaFl2a2ptTmtqeHhpYUVDd0RzTDdqRjJFdm94?=
 =?utf-8?B?ZFFpZ0IvYWN6T3pva21GMWRreFJmVW1vRS9mRWVqYlVCSDdFK084SmIreDlU?=
 =?utf-8?B?b243VUJrZktpQ3VEcFIyYmNUc0U1dDdKZjBUb0N2a0NBNFBzV3ZMcFNDZmFY?=
 =?utf-8?B?bGVQMTZobnkzSkJsVnlDTGw4LzRNMmtaNUE4NmZPNFgzNVkyV0NxbU4yUldw?=
 =?utf-8?B?N3FSNUtGWW9RSlZibWdVL3JISGFQWEZFRVpzN0Y3SWxSdzFmWnRXSUlLcDNF?=
 =?utf-8?B?RU9rUWFKdXRFdXc4TkV0Uldyd2Fma3pDVzFCeXgvSVVneEZDeGJMdGE0MGNt?=
 =?utf-8?B?VUJ1MS9xQnhLN1pEL0F5U3RSMHdBRWZOb2RWV1VzNERSVVFBaG95cjhZRG9C?=
 =?utf-8?B?ZjVoOUhTdWFUUitib1hrWFNqZ3U0ZUNVL0hMTGRhQ1lHRDEzMWxsSkNqMmdH?=
 =?utf-8?B?Ymd6dmt4aHZtNFh2bGFPR0dHdWlXWllsWVlwaHJrQk5wMjF1NytOcjdzT0V1?=
 =?utf-8?B?eVg3L0xyWEtWZngyVDRoVzR0bGFJeXpyWnlsS0pMcXZ1aG1rRDdlZE9xaGE2?=
 =?utf-8?B?Nkh0MTFvN1BNRW5DdkFBTVRvVmdVc0RTQVA1TlpMRmpxblR6VDkydW55MW9Z?=
 =?utf-8?B?cnpxZkhVZ1VFbGFLL2xBSHUrUVVQY3VhTCtKYTVXMXhyOXJOSndHRGJZMzhZ?=
 =?utf-8?B?SXQzSDhIcFZ6YmZtWkh4ZERsYVc0aThRdHQ1SkVZalVlSnZnMDVnYllUdXR2?=
 =?utf-8?B?YWc4YU1xR3ZBMlNqRnZLS0RReDcrY2ZEaDBLNG50R0Q2WHNFeWMyZzM2TjQ5?=
 =?utf-8?B?VUNRbzMzN0xGQzlhd2p2bUw3Y1Y5OHdxVjlyU1NLY2Y2ODFHZU81WjRCY0pw?=
 =?utf-8?B?MVIrdG94OHJZNHYxOUJvMVdScGhrUzg5SWNPdlNuaEdsZWxsUkZ2U0NYTEdk?=
 =?utf-8?B?bkVJVjFRbGFvZlZmMHBQQzlaZG9KOW13MlNjY0JrL25EWWt5dEYzVUl0YnBV?=
 =?utf-8?B?NnE3TDVUWDZCL21JMVU0bnZTNFRWekZ1WWNpOVlNVU9YdjY0bWxzY3VKakdN?=
 =?utf-8?B?V0dZdTNUYUFvT2lVV3pGQzFnaE9nRExnMW13NEg0NVBvU3phTXlSMzVnbnRj?=
 =?utf-8?B?azN0eUY0Y2djMFp3ZUlmQnhLSXRZdHB5OGg4Smt5OFNDR3pTQUZobnIwdXFt?=
 =?utf-8?B?VmdJQk1YV3JHQitEOStjdnhGQ1RyWWgyRUZoZTdON3hic1lUZnEzMUJiSFhn?=
 =?utf-8?B?c3d0Sjg5TGdLN2d5Y240bkM1QkFPSUJKT2tGSmFCSVlYak0zZ2g3U3NGMXEy?=
 =?utf-8?B?RE9HaVM4UGI2TDFhUnpsZXNtbmxZZmFuMkVuU1FzdXBTRWhzNU45WDBDRzdy?=
 =?utf-8?B?TkxDT0ZvUHp5dngrVXN1aGNGcVFVeHAwaFk5SjRPRllCRUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6683.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzhWNXRTRDIxMHlJZGlGM3RtRkdEdTdOMDg5YTZkaHltd1RmdlhVczFkaXBP?=
 =?utf-8?B?bHlzQmF5bnBHOWc5eUlLSUJGWEZiK2hueWUyK2R2ZTdrSHJjc3BlUnZISEF0?=
 =?utf-8?B?UzNJUDR6R29IcEsyN2JYcTJ4V293eXdvQ0NqTDZsNDBGM05Xa3E4UkZITlRE?=
 =?utf-8?B?WkVzcU1aZk1NTnhOb2FMNm9rV2RYZlg2Zk9FT1NTOW82N2xBN3lTbTJPOHhQ?=
 =?utf-8?B?SnNpMmxSYXlubnJkS1dBM25kTUVhVHlaY0Zlbks3SHlyRXRkeXEvdGUwTXYv?=
 =?utf-8?B?ZzQrRVlQMUhnQzFtTTd3czh0bGF0NHQzM1FQdlZMaGwxRlFzNm1GT04wWHR6?=
 =?utf-8?B?WkdydDArNmZ4anJQYUlndFFGN3VKV0c2elJmckVITW1PUU85YmxVak1IYUVn?=
 =?utf-8?B?QXlvb0xEOFUrYjB5MjFESVlraCtxRWdTQ25sbm53UHRCaVBKWXlCKzhrMDQ1?=
 =?utf-8?B?WUgzc21tVDVzZkgrMzhqeEFZWHNBM0VBWEM1dU5YQTJKbUY1ZU9EVGNyQi94?=
 =?utf-8?B?NG5xM2pUNGtxd2ZRMnlNMUk0Nk9uZWNQRlc3VlgyZXlobFIvaDVFV1hFTFRY?=
 =?utf-8?B?emtZdXgySy9MeU9janhFS29hVHBVUDhuTDJ1RUozeHBNZGVrc2ZWdTU0OGl4?=
 =?utf-8?B?bDR0RmRhZVJJMlVjdnk2SXl4TExIbzVNTjI1T1d5aVpjOFlZWTIwWGRQN2Uw?=
 =?utf-8?B?OWNkQndkM0hoNlZqVFV3QktkSWE2MVRrM3E5Q1hvRk95Qm1FK2VaQ0FEM2dK?=
 =?utf-8?B?L01raXljTWxRR3AyMWF0d2lCUlFEMFVBVGhtd1YxM3NSby85NlJaTWQzaEFX?=
 =?utf-8?B?NGpGMVBIc2FmMXh0RnF1V0l4WjZLaW5PaEFWNkh5NGR1VzZFc01YREZNekRj?=
 =?utf-8?B?SldRRGk1RzUvZ2JwOFhKZlZuQ0drUTlJNUJEZjB0ZVJGQzR3R3hWWTFFZHQz?=
 =?utf-8?B?ajRMTTFKUGx6T0ZLOTNUcDVKTUU0dUhRclVEcERBZS83MWxhcm9xSkkyMDJT?=
 =?utf-8?B?R3Fzbmw5dWtGVlVadWpvMUFIcGhiaWJOcUszY09xdFFNOUNoaEhjNnh6a0Zv?=
 =?utf-8?B?amU2ZmdYV2FNWDFGNGxhRVk3MkV3YzYxeCs3Y2NhdXk4d0ZJanRrK2ZlTDlp?=
 =?utf-8?B?MmdmK0Ivajk0UmMwUUdnZ014YmwyTGFhdituMDlYY1FKNS93cm4yZG1vRFBQ?=
 =?utf-8?B?V1liWVIvZmFuVEpadTd1ZkJ5MHNucmEwTzFmMlZOMjlQOWpXUENYZkpzYTZF?=
 =?utf-8?B?RHBXN3MxV2NVc014T0pXbDRlRWlOdDkrYzRiYXRMbFd5dEZieFVxQVZlNFN5?=
 =?utf-8?B?T1JYOVJQVnFIamFoOVdoT3BESUxqRGZiRGRiMUVHSWwvSE5lc3cyNFdPNUNS?=
 =?utf-8?B?RjVwM3IwVTlQYlJWb1MyWTluUFdNM3hSNFVOTi9QU1VKZjRMeWxUYVppbDBN?=
 =?utf-8?B?TkFoTkRic2x4SDg5MDZIU1grVEdCTSttT1FxbzBoekh2VEdXYk9DVWwvMnMx?=
 =?utf-8?B?dUZudDZIaTQ2SWNhZDlneUR0b3NIdmExMnNFUzZTRHdQcGJKQy9qQnRoOWZz?=
 =?utf-8?B?RUVkbmhaSEtsOERNVWNDUzNyRmFRNFlOUTE4Y01RNkcrWEpXaXZuL2RiOW4x?=
 =?utf-8?B?ejJ6aEgxUDdUSEhTekdGZTJQUklNd3F5WlFBRjI1MTJUSjhlV2NHTmFwVjdx?=
 =?utf-8?B?UE9XVEJjaVVteDQrU0NoRm1DZzMwSWFjcW51Z2MyUTJkUzM1UGU2aERyckxp?=
 =?utf-8?B?U0tzb3ArSFI4OW40RGVITDJ4MmEwcCt2VExwRkdYUkxWN25CMlQ1V2M3Uits?=
 =?utf-8?B?SmY1V25pU2pJRHdhNVF0cmxYWjVLTTlheTFkWEZvTjdOMVV3MnhqNFkvbjNw?=
 =?utf-8?B?UTZPc1dPL3NtVlc0STlUci9NRTBYazFzbi9CQW5STmczbEo5bzl6VXVHMFY5?=
 =?utf-8?B?WFE1U3lsbmlzMnpId0dLWXQ0eW5JUUJ0YzBCcjdGTE9sNkU2bUpPa01QZzJr?=
 =?utf-8?B?WVN1MGVEK0NzaVg5R2YwUFFIM1FlcFZXanMydHFoZUdmbDhVZFd5TTFlTVBI?=
 =?utf-8?B?R2tWSjVjQkIwSmlSSVViM2J5ZENYT0hTRWNWdUp3YmpCVXlCRmRLZHR6VTlI?=
 =?utf-8?Q?DU4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c26d33-3b5a-49f3-f054-08dcaaf682ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 09:04:51.0644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phndQlwrVjS7ZdXA1Mx22NoK6KhtoNAgGEQsOi+s4PeTsp0hfD4nMEBKhWl0HWtDyFlDA96SVPWRkKSg6WLA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
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
Cg0KSGkgQ2hyaXN0aWFuDQoNCkkgcHJlcGFyZWQgdGhpcyBwYXRjaCBiZWNhdXNlIHdlIG1ldCBh
IHBhZ2UgZmF1bHQgYWZ0ZXIgZ3B1IHJlc2V0IGluIFNSSU9WIHRyaWdnZXJlZCBieSBxdWFyay4N
CkFmdGVyIGludmVzdGlnYXRpb24sIEkgZm91bmQgdGhhdCB0aGUgcGFnZSB0YWJsZSBkaWQgbm90
IGdldCByZXN0b3JlZCBhZnRlciBncHUgcmVzZXQuDQpJIGp1c3QgdHJpZWQgdG8gdXNlIHZtX3Vw
ZGF0ZV9tb2RlPTAgdG8gZGlzYWJsZSBWTSB1cGRhdGUgYnkgQ1BVLCBhbmQgdGhpcyBpc3N1ZSBz
dGlsbCBleGlzdHMuDQoNCi1bQ2hyaXN0aWFuXSBXaGVuIFZSQU0gaXMgbG9zdCBhbnkgc3VibWlz
c2lvbiB1c2luZyB0aGUgVk0gZW50aXR5IHdpbGwgZmFpbCBhbmQgc28gcmVzdWx0IGluIGEgbmV3
IHBhZ2UgdGFibGUgZ2VuZXJhdGlvbi4NCkkgYmVsaWV2ZSB0aGF0IHlvdSBhcmUgcmVmZXJyaW5n
IHRoaXMgcGllY2Ugb2YgY29kZSBpbiBmdW5jdGlvbiBhbWRncHVfam9iX3J1bigpOg0KICAgICAg
ICAvKiBTa2lwIGpvYiBpZiBWUkFNIGlzIGxvc3QgYW5kIG5ldmVyIHJlc3VibWl0IGdhbmdzICov
DQogICAgICAgIGlmIChqb2ItPmdlbmVyYXRpb24gIT0gYW1kZ3B1X3ZtX2dlbmVyYXRpb24oYWRl
diwgam9iLT52bSkgfHwNCiAgICAgICAgICAgIChqb2ItPmpvYl9ydW5fY291bnRlciAmJiBqb2It
Pmdhbmdfc3VibWl0KSkNCiAgICAgICAgICAgICAgICBkbWFfZmVuY2Vfc2V0X2Vycm9yKGZpbmlz
aGVkLCAtRUNBTkNFTEVEKTsNCg0KSSBhZ3JlZSB0aGF0IHRoZSBzdWJtaXNzaW9uIGZyb20gdGhl
IG9sZCBjdHggd2lsbCBiZSBzZXQgYXMgRUNBTkNFTEVEIGFuZCBiZSBza2lwcGVkLg0KQnV0IGlm
IHRoZSBhcHBsaWNhdGlvbiB0aGVuIGNyZWF0ZXMgYSBuZXcgY3R4IGFuZCBzdWJtaXQgYSBuZXcg
am9iLCBib3RoIG5ld19jdHgtPmdlbmVyYXRpb24gYW5kIG5ld19qb2ItPmdlbmVyYXRpb24gd2ls
bCBiZSBpbml0aWF0ZWQgYXMgdGhlIHVwZGF0ZWQgb25lLg0KICAgICAgICBjdHgtPmdlbmVyYXRp
b24gPSBhbWRncHVfdm1fZ2VuZXJhdGlvbihtZ3ItPmFkZXYsICZmcHJpdi0+dm0pOw0KICAgICAg
ICAoKmpvYiktPmdlbmVyYXRpb24gPSBhbWRncHVfdm1fZ2VuZXJhdGlvbihhZGV2LCB2bSk7DQpB
bmQgdGhlIGpvYiB3aWxsIGJlIGV4ZWN1dGVkLCBoZW5jZSB0aGVyZSB3aWxsIGJlIGEgcGFnZSBm
YXVsdCBkdWUgdG8gVlJBTSBsb3N0Lg0KDQpQbGVhc2UgY29ycmVjdCBtZSBpZiBJIGhhdmUgc29t
ZSBtaXN1bmRlcnN0YW5kaW5nLg0KSSBzdGlsbCBjYW4gbm90IHNlZSB3aHkgYW55IHN1Ym1pc3Np
b24gdXNpbmcgdGhlIFZNIGVudGl0eSB3aWxsIGZhaWwgZHVlIHRvIFZSQU0gbG9zdC4NCg0KQmVz
dCwNClpoZW5ndW8NCkNsb3VkLUdQVSBDb3JlIHRlYW0sIFNSREMNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJr
ZW5AZ21haWwuY29tPg0KU2VudDogVHVlc2RheSwgSnVseSAyMywgMjAyNCAzOjEzIFBNDQpUbzog
WWluLCBaaGVuR3VvIChDaHJpcykgPFpoZW5HdW8uWWluQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiByZXNldCB2bSBz
dGF0ZSBtYWNoaW5lIGFmdGVyIGdwdSByZXNldCh2cmFtIGxvc3QpDQoNCkFtIDIzLjA3LjI0IHVt
IDA1OjA1IHNjaHJpZWIgWmhlbkd1byBZaW46DQo+IFtXaHldDQo+IFBhZ2UgdGFibGUgb2YgY29t
cHV0ZSBWTSBpbiB0aGUgVlJBTSB3aWxsIGxvc3QgYWZ0ZXIgZ3B1IHJlc2V0Lg0KPiBWUkFNIHdv
bid0IGJlIHJlc3RvcmVkIHNpbmNlIGNvbXB1dGUgVk0gaGFzIG5vIHNoYWRvd3MuDQo+DQo+IFtI
b3ddDQo+IFVzZSBoaWdoZXIgMzItYml0IG9mIHZtLT5nZW5lcmF0aW9uIHRvIHJlY29yZCBhIHZy
YW1fbG9zdF9jb3VudGVyLg0KPiBSZXNldCB0aGUgVk0gc3RhdGUgbWFjaGluZSB3aGVuIHZtLT5n
ZW5lcnRhaW9uIGlzIG5vdCBlcXVhbCB0bw0KPiByZS1nZW5lcmF0aW9uIHRva2VuLg0KPg0KPiB2
MjogQ2hlY2sgdm0tPmdlbmVyYXRpb24gaW5zdGVhZCBvZiBjYWxsaW5nIGRybV9zY2hlZF9lbnRp
dHlfZXJyb3IgaW4NCj4gYW1kZ3B1X3ZtX3ZhbGlkYXRlLg0KDQpJJ3ZlIGp1c3QgZG91YmxlIGNo
ZWNrZWQgdGhlIGxvZ2ljIGFnYWluIGFuZCBhcyBmYXIgYXMgSSBjYW4gc2VlIHRoaXMgcGF0Y2gg
aGVyZSBpcyBzdGlsbCBjb21wbGV0ZWx5IHN1cGVyZmx1b3VzLg0KDQpXaGVuIFZSQU0gaXMgbG9z
dCBhbnkgc3VibWlzc2lvbiB1c2luZyB0aGUgVk0gZW50aXR5IHdpbGwgZmFpbCBhbmQgc28gcmVz
dWx0IGluIGEgbmV3IHBhZ2UgdGFibGUgZ2VuZXJhdGlvbi4NCg0KV2hhdCBpc24ndCBoYW5kbGVk
IGFyZSBDUFUgYmFzZWQgcGFnZSB0YWJsZSB1cGRhdGVzLCBidXQgZm9yIHRob3NlIHdlIGNvdWxk
IHBvdGVudGlhbGx5IGNoYW5nZSB0aGUgY29uZGl0aW9uIGluc2lkZSB0aGUgQ1BVIHBhZ2UgdGFi
bGVzIGNvZGUuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTog
Wmhlbkd1byBZaW4gPHpoZW5ndW8ueWluQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTEgKysrKysrKy0tLS0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBpbmRleCAzYWJmYTY2ZDcyYTIuLjllMmY4
NGMxNjZlNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4g
QEAgLTQzNCw3ICs0MzQsNyBAQCB1aW50NjRfdCBhbWRncHVfdm1fZ2VuZXJhdGlvbihzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pDQo+ICAgICAgIGlmICgh
dm0pDQo+ICAgICAgICAgICAgICAgcmV0dXJuIHJlc3VsdDsNCj4NCj4gLSAgICAgcmVzdWx0ICs9
IHZtLT5nZW5lcmF0aW9uOw0KPiArICAgICByZXN1bHQgKz0gKHZtLT5nZW5lcmF0aW9uICYgMHhG
RkZGRkZGRik7DQo+ICAgICAgIC8qIEFkZCBvbmUgaWYgdGhlIHBhZ2UgdGFibGVzIHdpbGwgYmUg
cmUtZ2VuZXJhdGVkIG9uIG5leHQgQ1MgKi8NCj4gICAgICAgaWYgKGRybV9zY2hlZF9lbnRpdHlf
ZXJyb3IoJnZtLT5kZWxheWVkKSkNCj4gICAgICAgICAgICAgICArK3Jlc3VsdDsNCj4gQEAgLTQ2
Nyw5ICs0NjcsMTIgQEAgaW50IGFtZGdwdV92bV92YWxpZGF0ZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sDQo+ICAgICAgIHN0cnVjdCBhbWRncHVfYm8g
KnNoYWRvdzsNCj4gICAgICAgc3RydWN0IGFtZGdwdV9ibyAqYm87DQo+ICAgICAgIGludCByOw0K
PiArICAgICB1aW50MzJfdCB2cmFtX2xvc3RfY291bnRlciA9IGF0b21pY19yZWFkKCZhZGV2LT52
cmFtX2xvc3RfY291bnRlcik7DQo+DQo+IC0gICAgIGlmIChkcm1fc2NoZWRfZW50aXR5X2Vycm9y
KCZ2bS0+ZGVsYXllZCkpIHsNCj4gLSAgICAgICAgICAgICArK3ZtLT5nZW5lcmF0aW9uOw0KPiAr
ICAgICBpZiAodm0tPmdlbmVyYXRpb24gIT0gYW1kZ3B1X3ZtX2dlbmVyYXRpb24oYWRldiwgdm0p
KSB7DQo+ICsgICAgICAgICAgICAgaWYgKGRybV9zY2hlZF9lbnRpdHlfZXJyb3IoJnZtLT5kZWxh
eWVkKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICsrdm0tPmdlbmVyYXRpb247DQo+ICsgICAg
ICAgICAgICAgdm0tPmdlbmVyYXRpb24gPSAodTY0KXZyYW1fbG9zdF9jb3VudGVyIDw8IDMyIHwg
KHZtLT5nZW5lcmF0aW9uICYNCj4gKzB4RkZGRkZGRkYpOw0KPiAgICAgICAgICAgICAgIGFtZGdw
dV92bV9ib19yZXNldF9zdGF0ZV9tYWNoaW5lKHZtKTsNCj4gICAgICAgICAgICAgICBhbWRncHVf
dm1fZmluaV9lbnRpdGllcyh2bSk7DQo+ICAgICAgICAgICAgICAgciA9IGFtZGdwdV92bV9pbml0
X2VudGl0aWVzKGFkZXYsIHZtKTsgQEAgLTI0MzksNyArMjQ0Miw3IEBAIGludA0KPiBhbWRncHVf
dm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0s
DQo+ICAgICAgIHZtLT5sYXN0X3VwZGF0ZSA9IGRtYV9mZW5jZV9nZXRfc3R1YigpOw0KPiAgICAg
ICB2bS0+bGFzdF91bmxvY2tlZCA9IGRtYV9mZW5jZV9nZXRfc3R1YigpOw0KPiAgICAgICB2bS0+
bGFzdF90bGJfZmx1c2ggPSBkbWFfZmVuY2VfZ2V0X3N0dWIoKTsNCj4gLSAgICAgdm0tPmdlbmVy
YXRpb24gPSAwOw0KPiArICAgICB2bS0+Z2VuZXJhdGlvbiA9ICh1NjQpYXRvbWljX3JlYWQoJmFk
ZXYtPnZyYW1fbG9zdF9jb3VudGVyKSA8PCAzMjsNCj4NCj4gICAgICAgbXV0ZXhfaW5pdCgmdm0t
PmV2aWN0aW9uX2xvY2spOw0KPiAgICAgICB2bS0+ZXZpY3RpbmcgPSBmYWxzZTsNCg0K

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5F9CE8D6B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 18:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C55510E0E5;
	Mon, 17 Nov 2025 18:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="us3GA0Af";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E8F10E0E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 18:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r676BiYYfTr6gXYUvSrCXrFefveI8HCuEL9+5i5nzF60NOnWzBWaNGrQHoWpvb7W1M9hDT2HGptqBSLYWp4Xm/2nhP8/dkxDVDLbqmLBN3x9QSgx/fNrrFDFe1pbqPu2RmKWq4HufACcLblHkjoINq2sM4AfktXcy99Jq8iHsxwtV26GOJ0MXovM2aOoV9PrAC16PPHKProtROmF7kr4EXpXAWhMzg3If71GE6g5g8JkJPab51tKZQ9sc3TsE0GfwN6wbvZ+HU08xe/7Jecbxwsw5Crw4HRWSndHMDp8+Am6fTfUf+xKolGYsB+a5tHL0AyCOyY1SunG89EE4vhV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkKdq9uIhYA7FecqHZwpwMUSY+rkGxEQfIYqXzWXOpA=;
 b=RHzoNavYU45ZfG/yvsgOuaoOzf8KK+QKBJwpT/6+vBYymOL278EvAEW38NfG8kv84+sNO/qW0rtKfn/VNKmUoRsAA1X3GQbfUiqK0UhAUISHgPBEMaFtAB8h+fXSGSCMWnDXsEvd+0ViWOJIkVGct28Q2usCiO2kOK70FxXl5kLIkS+GGv9DkmO9lp9SHzJaNU4pipaPzaFrfF4MIU3l9UYleZMYgoOu5aJK36INFa8MIbGKXIsP9eoQU2cjGFC9g54j9qsnPlo5volYq/CWzWZ2J9h19v4iWancfc7iZ1y3cxRMVKg0PXxFvdOYCT5HDKF4exdC1oG4nUTnT1ElLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkKdq9uIhYA7FecqHZwpwMUSY+rkGxEQfIYqXzWXOpA=;
 b=us3GA0AfHdcTrw3JUYx4QktxAbHTq3/g7260cbKYGulMRb72UjYd0+OEtco1PH0k13hmVcL8H79LKcmWjniQP3BRv/XzPUFYPEFudxoTg+bq0U1PvwXPU+nYwL01qvM8kgF19SbohJyIH3sHg/Vmg+v6lNYTxxAIMxieLdxahS0=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 18:13:54 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 18:13:54 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: FORWARD NULL
Thread-Topic: [PATCH] drm/amdkfd: FORWARD NULL
Thread-Index: AQHcVXSwv0zaaD4Zs0yOHV4tJTwO0LTyZg2AgABPpoCABHZiwA==
Date: Mon, 17 Nov 2025 18:13:54 +0000
Message-ID: <SJ0PR12MB81387F24365922E3E1EFE646F5C9A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20251114144033.1432008-1-andrew.martin@amd.com>
 <PH7PR12MB590242762FBB162CCE923A0385CAA@PH7PR12MB5902.namprd12.prod.outlook.com>
 <8f5fead3-2f4e-4352-a4d1-2d316bdf23f7@amd.com>
In-Reply-To: <8f5fead3-2f4e-4352-a4d1-2d316bdf23f7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Felix.Kuehling@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-17T17:56:28.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|SN7PR12MB7023:EE_
x-ms-office365-filtering-correlation-id: f277cb0e-212d-40f0-5871-08de260511a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?aGRuRXUrdHJOcjFNclk1bFlITjFnWWhxb2xyR2JFNmdKZ2pUYWV1cEFXd2hI?=
 =?utf-8?B?OS9uQnB4bUxWMks5OW9EYWNNK3l2SnlNYUZkYlZiRXpXdUdvZDl2YjI5OFlq?=
 =?utf-8?B?aXRjaXhDek84eWhTWWp6QW5MZ0czamhTRExyc29aMWZkWFcxWm9BY3F5cy9h?=
 =?utf-8?B?TU5kbDFLV3BRSElkTWNCNWtpL0JxaDB6N05lVUk5RHk5cVZQd3B3bUFNc2x4?=
 =?utf-8?B?VmdxNzdFdW96azJQSDhNdm5xZ2RQQkFralNFUERkaCsxd2NDOVhkTWxJQi94?=
 =?utf-8?B?WEpCM09oWDIrWEZuU2h3KzE3REkzaHJQYXVGbk41TlRDekM5emhGWWJGbHY4?=
 =?utf-8?B?eWVBckUwaXU0Lzk1VlNYT1JGbDFYWmtpYkp3TXlkZi9UNFZteHB3V2ZnSHEz?=
 =?utf-8?B?RDMrSi8zeFNwbmlNUmlkT3grL1ppYU1PdlBmRGJBU1F5aVBEbytaNlBqYk5R?=
 =?utf-8?B?c1U4Q0JTQWd1ZE5tTW44SFJIT05DVnNmdlZHMkRNaFFUeHAwUkxWcmUvOG51?=
 =?utf-8?B?UWREeTFJMEd6cys0eGxnTG9SWFB1bG1nUTBrbEljT2lvelZpUnhDUDhDVDZv?=
 =?utf-8?B?d1hnbnhJSHNjOEVmcnovei82QStSTVFPR25MR0lDNGp6SG1jRlVGb0JqMTZR?=
 =?utf-8?B?YXNDbnBHeVhKN0w4Yzg1a3FONUZqMHR4TnpxM2pZSzIzQnlxUVIwN0cyR0c2?=
 =?utf-8?B?OFl2VTFXeFBhd2liMmtuL1k4SjFBYXJTUVg3aGtiaHlUVG82SzJhbmtUUERS?=
 =?utf-8?B?bFFtdS9BaElwMUx4QnpaK1RhUVI4Tm9ONzJkWWJtek9IUW5NNGN0cHgwWXIr?=
 =?utf-8?B?aWlUMXR3QU9KalBtem9HTC9CWi9TdklQVFQ4cHNwS1ZaK0FPdnVEck8ybjFx?=
 =?utf-8?B?UHpGTG1GbW50bmcvUWMwcFZKS2pJbjNSNDZtQUFpaTBNYXRCL09QK2hXL3By?=
 =?utf-8?B?SjBHa0k1NkhiUytVQlQvK2VWcitidXQySnJtVDBpQlB6dWphdjRuRWZoRU52?=
 =?utf-8?B?YmN1NEQxWmFCejZZS3lHendSdnhtQVA0MGVFK3B4QTYxaDZZd1NPSXlxZVQy?=
 =?utf-8?B?UUJMV1Eybnh0ZEtqWmt0bVEvNnB6YmdTYkNyNzllODBPUy9pR09adHNTWVZa?=
 =?utf-8?B?U0RRbGsvWENEOGRnTExtMFE5R2plOE1qaVBMQTk4azVFK01tMnRvMmNJekhD?=
 =?utf-8?B?ZUMxUlFFTHN5bHlyVnpvZ045bWpKUUJ5UC91OTZ4VzZvaXRmQlpqYXhzc2Nr?=
 =?utf-8?B?UndGWkZnd1pvTnBjSEVoTXhuQ0Y2ZHN4d21xRGlGMWpVS0VSa25JMXdBaEs3?=
 =?utf-8?B?aStJYnZpbThnT2tUTk9rZ0J5R09VODZhbVpzQ0VESzNSYVFJMFIzU3RIbUJW?=
 =?utf-8?B?RGt0emg2MyttNXQ3NFpLaFJwQ3UvWThUNk5nMnEvQkVUZXl4V3QrTW5ORVJr?=
 =?utf-8?B?N1Y3RHdWUDRmaWtpeUg1WDdIMkZ6QVllQ3ZKKzVOUWtBMzVYSVVmdHViUGRE?=
 =?utf-8?B?SHl0dzUrZzQ1WmhRbm1nY2NDek9Rck0vMkdyR2ZKd1ZYdktSM0h0czlQVjUx?=
 =?utf-8?B?M29UTllURlFUUUJWT2MrZlFjZVgxdUZyNkE3VFFOVko0L1NpQUIrdnVoQkd0?=
 =?utf-8?B?UWZQZmh2bEM3M2lYRzVIMmRNNy9rQktiMU54K096bGxMWVBkMlliTnpjSTk0?=
 =?utf-8?B?VldJR1Z3V3JHVDB3NHE1aG9VbzNqdlJOWTZVSDlnTWh5cWFiUzNoU1dQMXdi?=
 =?utf-8?B?cFJrQVhGU1VaNk92d1QvVFlQSmdGbEROZEU3cFltWEJQd056ZlIwV2FBQ2dI?=
 =?utf-8?B?UmYyeXl0UmVnQXBQamhHeXpMYmlPZHZvcHNsNkFKdno1eUFRejhhcGFIRkRB?=
 =?utf-8?B?NThvaGhYRnZxeDR6Ykx5T3NRRkVIaHNaVHpoWVFyYlk5aEQxTlVTVGh3NUVp?=
 =?utf-8?B?S2RqTEdXMHlZWDc1RCsweHhCcGF3Nzd3em0valY3R1ZkYm04VHRJTEJJU2ZT?=
 =?utf-8?B?U3g4Sk5vY01uSlZKTThCclkwcWpKMHFZaWVyNkhhbko0RjJLQ3FYd2RSbVkx?=
 =?utf-8?Q?ztjOR9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUsvUW5mT2dKTjZNeGF4UnFqeGMzVm1jN3E0OUtoZnpYT2tNZCs3UWplQkZM?=
 =?utf-8?B?NWM3R2hTZUxnaXR5Wms0MGIwTkIxUnI2WVNNV3dISXlUZEhKNXZUU0NWL2RG?=
 =?utf-8?B?WGpNR3A3TERJc0NmZXJmRnJkMkNmWWlteVZlZUxpcUwvV01FMENmZDQ2OGhF?=
 =?utf-8?B?U2drZUNtWmpFZGkzTmNISjYzalYzSUExb2NHUXJiRXZhajdubzNOUVVlemJs?=
 =?utf-8?B?LzVPWGlpSGc1Tzlibjh3ZmRvYmpkWFZXZ1VXZmU0dmllNzZQNlVmdUVmbWZn?=
 =?utf-8?B?MTZWYlRCZEtxMDRpRC9RcmlkTm82WTFkaXR2VGxubzM2NWdLN0tYNE9iK1lJ?=
 =?utf-8?B?emFnUm0vTlZXSjlHUHlvK0ttTkowaEdDNFpIeGJrYnZoK09Xakk5a2MzbmRi?=
 =?utf-8?B?Ri83VFdQd1FNbVpZN2NYZkd5bkNwOVkyOU01WXozNUJxMWIrekZVRlJjeTZ1?=
 =?utf-8?B?azVqMmsrZXF6TC8vVklQOWFEbExzYnB2UXhhR0JLOTFGQlh1VWE5VFdPRlEz?=
 =?utf-8?B?Uy9qSXA0LzJSVm4wYi9VQ3NZZSsya0s4T1AzNkVxdUtsY3Fka1IwTWhMeW9u?=
 =?utf-8?B?ajRjYVhYMk9tT3VSMmFkMlJvRUZETjZrU044U0p1bHc2Y3k3TXY4dUNBKzlH?=
 =?utf-8?B?NmZ0T1ViamZnNzRMMDRMbE4yTE5zczdBVFM3L3N6a1N0dW1EK1ZmWTFTMjhj?=
 =?utf-8?B?UzR0RG1Gamt0Qnpsc1Zob3N3bGJVem1SaC9VRjhvenR3TncvVFNIZm9WSEwy?=
 =?utf-8?B?V2lhVEd3amExUk11ZStjaCsrb3FMbWZaYUgwUlVHS2szeDE1aWRZMWV5QXd3?=
 =?utf-8?B?UTJpSGkvdXhFTWxrbFNsdTdwVTlOaUx6L1lqeGxnK0RiRGo3V0ZhU2tPUXNM?=
 =?utf-8?B?ckVlVkFzejBWK09BYVM3NXhYWXBXTHVCcnY1dnd6UTlZMjFVeGtuN1lra0dB?=
 =?utf-8?B?TXZuYUhnQitjWUR1cGhTYnFDRjFQYVRlcmw4cWtoWGxGcUZ6b0VMbnVicSth?=
 =?utf-8?B?WWZXSmFyZldNOXVpYkZOT09ZQ2pjMXAxMlpid0JSVmdRMHFnMDFQNWJONVpG?=
 =?utf-8?B?UWlpdk13ZDdkV2ZtMU9kWjZDZk9Zb0VKTThLYitDMy82REpocXF5VU0wS1Vv?=
 =?utf-8?B?U3o3Q2hjNlRrY0V4eFR3MUJsM0dGMnNNOTBFR3JMU1pqMXgyRno3NDBhS1FQ?=
 =?utf-8?B?a1k5TS9lRDdMbUlnblZNVmJmb056WG1ucmllTDg3VUYvM3VEM0lpOHhBSDJ3?=
 =?utf-8?B?bkFmRFZWR0p1SjhGdDlEd3BqODB0eEhtUnZSSytlTnFSR2MvZ01vMFVDS0dl?=
 =?utf-8?B?MXAxY0ZjZFNLcXZZSDRzaCtpWUZEZmhOeVcrRCs2OCs4ejFYSzRCUWZnUUlj?=
 =?utf-8?B?L3ZYWXNOKzFUbWZZL1VDa3B4TGUrVHlJM3VHMWhRVGhKUlVYRUREN2d0Yndv?=
 =?utf-8?B?ZGlMMUxmSEFWb3FTS1cydkNTaDQ5aEdaZjlFS3N2MFF0Q08wVDg0ZDRwczBh?=
 =?utf-8?B?dHJxR0tvWklPbmVqMDhZQXFCK3g5WExQY1I5Y3RDb3ozZE1RSGNGL0NjbUsw?=
 =?utf-8?B?cEd0RXdYYWlzMGRMYUVKV1F1YUpOemE5VzA1ZzYxZmJRZ0NSU2lSMDUzN3Jj?=
 =?utf-8?B?OU9pcUQzNWdyMUVCdnVVSE5tT3BzNDdMQWllRHI0Q0ZZOXRFc3c2ME45REZi?=
 =?utf-8?B?MjJRbjdZbWtZOWxmYlRVMzB5MVRXV1FyNXhudklEekh3amtBU1BjQ2pUQ2Nq?=
 =?utf-8?B?aUNvUzVwMXN0ODFIc21IUjY0aElYOEVwLzF1UnpVa0pJK2ZXeVh2NzVLUlRp?=
 =?utf-8?B?R2xpdFZzZTlFN01YWW84QzVtZjZXbS9zZjA1bU14UzBZQ0p6bmVRa21RL3Va?=
 =?utf-8?B?bHJyVjU2SXprNHZNYWdEV29MdENPcXJ1UXBXVEp4eWJsV3hlNXVaekgyYm1o?=
 =?utf-8?B?ZXJFODV1alhqaDNlR2EzV1ZnTC8rb0Q2Rlk0MmthdjkreG8vT242YnVDUVY1?=
 =?utf-8?B?bFpMdlR4aDlVeGdkTDZmVjJacENLZERqbDNXdEsrWkVYZ1hOMWtmaTNRU3kz?=
 =?utf-8?B?QXNyTGFXVkZKNjVTcWtLclI1c2swd3U1UW1VN2xBbGRJM2VjRjgzdHdGUlls?=
 =?utf-8?Q?SY2I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f277cb0e-212d-40f0-5871-08de260511a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 18:13:54.5415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MmQX27wNHsvORjQvyc4O/BnjJt6z+S87sWFk3ACR2K6hC9mRhvKVV2jDxRaN5gxvYANfhx7zC4EcqYlJIrGzIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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
Cg0KR3JlZXRpbmdzIEBLdWVobGluZywgRmVsaXgsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBj
b21tZW50cywgcGxlYXNlIHNlZSBzb21lIGRpc2NvdmVyeSBjb21tZW50cyBpbiBsaW5lZCEgIFBh
dGNoIDIgd2l0aCB0aGUgc3VnZ2VzdGVkIGZpeGVzIGlzIG9uIGl0cyB3YXkuDQoNCk5vdGU6IEkg
aGF2ZSBhZGRlZCAxIGNoYW5nZSBpbiB0aGUgbmV3IHBhdGNoIChyZS1ydW5uaW5nIHRoZSBzY2Fu
LCBmb3VuZCBpdCkNCg0KZmlsZToga2ZkX2NyYXQuYzoyMzYwDQouLi4NCnBlZXJfZGV2ID0ga2Zk
X3RvcG9sb2d5X2RldmljZV9ieV9wcm94aW1pdHlfZG9tYWluX25vX2xvY2sobmlkKTsNCiAgICAg
ICAgaWYgKCFwZWVyX2RldikNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCi4uLg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxNCwgMjAy
NSA0OjQ4IFBNDQo+IFRvOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47IE1h
cnRpbiwgQW5kcmV3DQo+IDxBbmRyZXcuTWFydGluQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBGT1JXQVJE
IE5VTEwNCj4NCj4gT24gMjAyNS0xMS0xNCAxMjowMiwgUnVzc2VsbCwgS2VudCB3cm90ZToNCj4g
PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5
XQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0K
PiA+PiBBbmRyZXcgTWFydGluDQo+ID4+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTQsIDIwMjUg
OTo0MSBBTQ0KPiA+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6
IE1hcnRpbiwgQW5kcmV3IDxBbmRyZXcuTWFydGluQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFtQ
QVRDSF0gZHJtL2FtZGtmZDogRk9SV0FSRCBOVUxMDQo+ID4+DQo+ID4+IFRoaXMgcGF0Y2ggZml4
ZXMgaXNzdWVzIHdoZW4gdGhlIGNvZGUgbW92ZXMgZm9yd2FyZCB3aXRoIGEgcG90ZW50aWFsDQo+
ID4+IE5VTEwgcG9pbnRlciwgd2l0aG91dCBjaGVja2luZy4NCj4gPj4NCj4gPj4gU2lnbmVkLW9m
Zi1ieTogQW5kcmV3IE1hcnRpbiA8YW5kcmV3Lm1hcnRpbkBhbWQuY29tPg0KPiA+PiAtLS0NCj4g
Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2ZlbmNlLmMgfCAy
ICsrDQo+ID4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RlYnVnLmMgICAgICAg
ICAgIHwgNiArKysrKy0NCj4gPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJv
Y2Vzcy5jICAgICAgICAgfCAzICsrKw0KPiA+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9mZW5jZS5jDQo+ID4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9mZW5jZS5jDQo+ID4+IGluZGV4IDFlZjc1
OGFjNTA3Ni4uNzFiN2RiNWRlNjlmIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2ZlbmNlLmMNCj4gPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9mZW5jZS5jDQo+ID4+IEBAIC0xMDQsNiArMTA0
LDggQEAgc3RhdGljIGNvbnN0IGNoYXINCj4gPj4gKmFtZGtmZF9mZW5jZV9nZXRfZHJpdmVyX25h
bWUoc3RydWN0DQo+ID4+IGRtYV9mZW5jZSAqZikNCj4gPj4gICBzdGF0aWMgY29uc3QgY2hhciAq
YW1ka2ZkX2ZlbmNlX2dldF90aW1lbGluZV9uYW1lKHN0cnVjdCBkbWFfZmVuY2UgKmYpDQo+ID4+
ICAgew0KPiA+PiAgICAgICAgc3RydWN0IGFtZGdwdV9hbWRrZmRfZmVuY2UgKmZlbmNlID0gdG9f
YW1kZ3B1X2FtZGtmZF9mZW5jZShmKTsNCj4gPj4gKyAgICAgaWYgKCFmZW5jZSkNCj4gPj4gKyAg
ICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiBGZWxpeCBjYW4gaG9wZWZ1bGx5IGNvbmZpcm0s
IGJ1dCB3ZSBtYXkgbmVlZCB0byBoYXZlIHNvbWV0aGluZyBoZXJlLA0KPiA+IHNpbmNlIHRoZSBy
ZWZlcmVuY2VzIGhlcmUgZXhwZWN0IHNvbWV0aGluZy4gTGlrZSBpbiAjZGVmaW5lDQo+IEFNREdQ
VV9KT0JfR0VUX1RJTUVMSU5FX05BTUUoam9iKSBcDQo+ID4NCj4gPiBqb2ItPmJhc2Uuc19mZW5j
ZS0+ZmluaXNoZWQub3BzLT5nZXRfdGltZWxpbmVfbmFtZSgmam9iLT5iYXNlLnNfZmVuY2UtDQo+
ID4gPmZpbmlzaGVkKQ0KPg0KPiBGb3IgYW1kZ3B1IEpvYiBmZW5jZXMgdGhlIGFib3ZlIG1ha2Vz
IHNlbnNlLiBCdXQgS0ZEIGZlbmNlcyBhcmUgb3VyIGV2aWN0aW9ucw0KPiBmZW5jZXMuIFRoZXJl
IGlzIG5vIGpvYiBhc3NvY2lhdGVkIHdpdGggdGhlbS4NCj4NCj4gSSBkb24ndCB0aGluayB0aGUg
TlVMTCBjaGVjayBpcyBuZWVkZWQgaGVyZS4gdG9fYW1kZ3B1X2FtZGtmZF9mZW5jZSByZXR1cm5z
DQo+IE5VTEwgaWYgdGhlIGYgaXMgTlVMTCBvciB0aGUgZmVuY2UgaXMgbm90IGFuIGFtZGdwdV9h
bWRrZmRfZmVuY2UsIGJhc2VkIG9uDQo+IHRoZSBmZW5jZV9vcHMuIEJ1dCB3ZSdyZSBpbiBhIGZl
bmNlX29wcyBjYWxsYmFjayBoZXJlIHRoYXQgc2hvdWxkIG9ubHkgYmUgY2FsbGVkDQo+IGZvciBh
bWRncHVfYW1ka2ZkX2ZlbmNlcy4NCj4NCj4gVGhhdCBzYWlkLCBpZiB5b3UgbmVlZCBhIGNoZWNr
IHRvIHNhdGlzZnkgYSBzdGF0aWMgY2hlY2tlciwgSSBzdWdnZXN0IHRoaXM6DQo+DQo+ICAgICAg
cmV0dXJuIGZlbmNlID8gZmVuY2UtPnRpbWVsaW5lX25hbWUgOiBOVUxMOw0KDQpUaGlzIHdvcmtl
ZCBwZXJmZWN0bHkuDQo+DQo+DQo+ID4NCj4gPj4gICAgICAgIHJldHVybiBmZW5jZS0+dGltZWxp
bmVfbmFtZTsNCj4gPj4gICB9DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfZGVidWcuYw0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZWJ1Zy5jDQo+ID4+IGluZGV4IGJhOTllMGYyNThhZS4uNDJmYTEzN2JkYjJmIDEwMDY0NA0K
PiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGVidWcuYw0KPiA+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGVidWcuYw0KPiA+PiBAQCAtNTE3
LDcgKzUxNyw5IEBAIGludCBrZmRfZGJnX3RyYXBfc2V0X2ZsYWdzKHN0cnVjdCBrZmRfcHJvY2Vz
cw0KPiA+PiAqdGFyZ2V0LCB1aW50MzJfdCAqZmxhZ3MpDQo+ID4+DQo+ID4+ICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgdGFyZ2V0LT5uX3BkZHM7IGkrKykgew0KPiA+PiAgICAgICAgICAgICAgICBz
dHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqdG9wb19kZXYgPQ0KPiA+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBrZmRfdG9wb2xvZ3lfZGV2aWNlX2J5X2lkKHRhcmdldC0+cGRkc1tp
XS0+ZGV2LT5pZCk7DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICBrZmRfdG9wb2xvZ3lfZGV2
aWNlX2J5X2lkKHRhcmdldC0+cGRkc1tpXS0+ZGV2LT5pZCk7DQo+ID4+ICsgICAgICAgICAgICAg
aWYgKCF0b3BvX2RldikNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPg0K
PiBUaGlzIGxvb3AgY2hlY2tzIHRoZSBjYXBhYmlsaXRpZXMgb2YgYWxsIHRoZSBkZXZpY2VzLiBJ
ZiBhIGRldmljZSBpcyBub3QgZm91bmQsIHdlDQo+IHNob3VsZCBhc3N1bWUgdGhlIHdvcnN0IGFu
ZCByZXR1cm4gYW4gZXJyb3IsIGluc3RlYWQgb2YganVzdCBhc3N1bWluZyB0aGF0IGl0J2xsDQo+
IGJlIGZpbmUuDQo+DQoNCkRvbmUNCg0KPg0KPiA+PiAgICAgICAgICAgICAgICB1aW50MzJfdCBj
YXBzID0gdG9wb19kZXYtPm5vZGVfcHJvcHMuY2FwYWJpbGl0eTsNCj4gPj4NCj4gPj4gICAgICAg
ICAgICAgICAgaWYgKCEoY2FwcyAmDQo+ID4+IEhTQV9DQVBfVFJBUF9ERUJVR19QUkVDSVNFX01F
TU9SWV9PUEVSQVRJT05TX1NVUFBPUlRFRCkNCj4gPj4gJiYNCj4gPj4gQEAgLTEwNzEsNiArMTA3
Myw4IEBAIGludCBrZmRfZGJnX3RyYXBfZGV2aWNlX3NuYXBzaG90KHN0cnVjdA0KPiA+PiBrZmRf
cHJvY2VzcyAqdGFyZ2V0LA0KPiA+PiAgICAgICAgZm9yIChpID0gMDsgaSA8IHRtcF9udW1fZGV2
aWNlczsgaSsrKSB7DQo+ID4+ICAgICAgICAgICAgICAgIHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZp
Y2UgKnBkZCA9IHRhcmdldC0+cGRkc1tpXTsNCj4gPj4gICAgICAgICAgICAgICAgc3RydWN0IGtm
ZF90b3BvbG9neV9kZXZpY2UgKnRvcG9fZGV2ID0NCj4gPj4ga2ZkX3RvcG9sb2d5X2RldmljZV9i
eV9pZChwZGQtPmRldi0+aWQpOw0KPiA+PiArICAgICAgICAgICAgIGlmICghdG9wb19kZXYpDQo+
ID4+ICsgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4NCj4gSSdkIHJldHVybiBhbiBl
cnJvciBoZXJlIGFzIHdlbGwsIGJlY2F1c2Ugd2Ugb2J2aW91c2x5IGRvbid0IGhhdmUgYWNjdXJh
dGUNCj4gZGV2aWNlIGluZm8uDQo+DQoNCkRvbmUNCg0KPg0KPiA+Pg0KPiA+PiAgICAgICAgICAg
ICAgICBkZXZpY2VfaW5mby5ncHVfaWQgPSBwZGQtPmRldi0+aWQ7DQo+ID4+ICAgICAgICAgICAg
ICAgIGRldmljZV9pbmZvLmV4Y2VwdGlvbl9zdGF0dXMgPSBwZGQtPmV4Y2VwdGlvbl9zdGF0dXM7
DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vz
cy5jDQo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+
PiBpbmRleCBmNWQxNzNmMWNhM2IuLmY0MGQ5M2Y4MmVkZSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+ID4+IEBAIC0xNjg1LDYgKzE2ODUs
OSBAQCBpbnQga2ZkX3Byb2Nlc3NfZGV2aWNlX2luaXRfdm0oc3RydWN0DQo+ID4+IGtmZF9wcm9j
ZXNzX2RldmljZSAqcGRkLA0KPiA+PiAgICAgICAgc3RydWN0IGtmZF9ub2RlICpkZXY7DQo+ID4+
ICAgICAgICBpbnQgcmV0Ow0KPiA+Pg0KPiA+PiArICAgICBpZiAoIXBkZCkNCj4gPj4gKyAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPj4gKw0KPg0KPiBXZSBnZW5lcmFsbHkgYXNzdW1l
IHRoYXQgZnVuY3Rpb25zIGFyZSBjYWxsZWQgd2l0aCB2YWxpZCBwYXJhbWV0ZXJzLg0KPiBXaXRo
IHRoYXQgYXJndW1lbnQsIHdlIHNob3VsZCBwcm9iYWJseSByZW1vdmUgdGhlIGNoZWNrIGZvciAh
ZHJtX2ZpbGUNCj4gYmVsb3cgYXMgd2VsbC4NCg0KRG9uZS4gIFRoaXMgaXMgYSBnb29kIHRoaW5n
IHRvIG5vdGUsIGJ1dCBJIHdhbnQgdG8gaGF2ZSBhbm90aGVyIGxlc3NvbiBoZXJlLiAgSXMgdGhp
cyB0cnVlIGluIGdlbmVyYWwgb3Igb25seSBmb3IgaW50ZXJuYWwvcHJpdmF0ZSBBUElzPyBJIGFz
a2VkIGIvYyB0aGlzIGNvbW1lbnQgZm9yY2VkIG1lIHRvIHJlYWxseSBsb29rIGNhcmVmdWxseSB0
aGUga2ZkX3Byb2Nlc3NfZGV2aWNlX2luaXRfdm0oKSwgd2hpY2ggaXMgcHJvdG90eXBlZCBpbiBr
ZmRfcHJpdi5oLiAgVGhpcyBtZWFuIHRoaXMgYW5kIGFueSBvdGhlciBmdW5jdGlvbiBmcm9tIGhl
cmUgc2hvdWxkIGJlIGNhbGxlZCB3aXRoIHZhbGlkIHBhcmFtcy4gIEJ1dCBwdWJsaWMgQVBJcyBz
aG91bGQgY2hlY2sgdGhhdCB0aGUgcGFyYW1zIGFyZSB2YWxpZCwgYi9jIHRoaXMgaG93IHdlIHBy
ZXZlbnQgY3Jhc2hlcyBpbiBvdXIgbGlicmFyeT8NCj4NCj4gUmVnYXJkcywNCj4gICAgRmVsaXgN
Cj4NCj4NCj4gPj4gICAgICAgIGlmICghZHJtX2ZpbGUpDQo+ID4+ICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiA+IFByb2JhYmx5IGVhc2llciB0byBqdXN0IGNvbWJpbmUgdGhlICFw
ZGQgYW5kICFkcm1fZmlsZSBpbnRvIHRoZSBzYW1lIGNoZWNrLg0KPiA+DQo+ID4gICBLZW50DQo+
ID4+IC0tDQo+ID4+IDIuNDMuMA0K

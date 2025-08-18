Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84381CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 19:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2438A10E1EB;
	Mon, 18 Aug 2025 19:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywTo9Dy2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 458DE10E05D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 19:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLV0KuZxTQLPSBWYMadZJdU2c+p3RldTowNPmL3+SZDWuo0Wo794o2WmZOzeQZIfwuOaDX5ioMGvA5NWJ47rNn/YMDMT0F/0S92S24R3O7Rxsd14azYAjsvzmZwtvzxc3o4lkcfbB+Y7mkwawnDyu1fIx62xaIfpcAXEpiogL1rkqiwZMZGYMjwVocipzz1dcCk3rKrsfQglaJv7Yhkf3Ywq+Bf2GLbBV3DRapbqmtwTX1gYagRKw/Ut+IHiB95fHcAOntzTd/CIV4qoy7u9HVctyfyvofNWThewsY9TAPkL7QBLnkMvZ/vvx6HRqKROJGsCl5deVhmEepp56DcPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhynuBQ9xoOl0QO+P0QnZvE52d8TWN0gxCuzMRwU2Hk=;
 b=r/EQMn3JWz+Rr6Oi/ilSBH7Pu0iuevRt6Walud7guMkNhnYDyfY3jxQs0xbtqIAeg1NFoDbgjKJ5IKLsG2XatW+jRn9gbrdrnnHMy2DE1kDEDLF6niPe+aRT38NkoZOOGqK2oZXb4AeTMZUNg5rccWrQEcLX5nM1IMHKpHQpMl31NzW3YpV8NnUdXGupgLIvHVgoWr4cXbpCPPDQBskU0UJTWbEjbTCDqgL1xtrfNkLkmjZ92gu4yfmSvj6VcxAXwgioAMRFdRePZ3O07Pt7BSvhKTosGlSTFbSKXtfxjclKntQlOzyUBcw8B3Gp3bQWfgx9vKO0N+cR7urPhJnHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhynuBQ9xoOl0QO+P0QnZvE52d8TWN0gxCuzMRwU2Hk=;
 b=ywTo9Dy28QgIbeWlfFSJOGB8OhcuUqFPhZMDyFotNp7kxCm0tYw22VchL1U+fTvUT2BZrVIKeuz89QfKTEVcQx1lDv2yxfxbgLN6ewpupPv3L4uH2g9QPVuQDFoi7CuDjsOsGjCd5vWs8KpadHmT1Hix7nydSbWjIr/7AAtF9ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 19:23:01 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 19:23:00 +0000
Content-Type: multipart/alternative;
 boundary="------------1TlL7JgDnkImHCfCeJRd0fuS"
Message-ID: <8292ca54-d5f5-418f-82d0-7c70ac47c6a6@amd.com>
Date: Mon, 18 Aug 2025 15:22:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
From: David Wu <davidwu2@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wu, David" <David.Wu3@amd.com>,
 "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <376e6482-7319-426a-3d67-994b9581c678@amd.com>
 <CADnq5_NajJn+6hHVmQsxBQ=-j_Xhc50csXGVPDmRoDvAb3AZgg@mail.gmail.com>
 <422ce379-1a56-de36-c040-6da658dead63@amd.com>
 <DS0PR12MB780454748D8280FEAA9DF3339735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <dd993060-e357-ebe2-4786-cbff7f3eb60c@amd.com>
 <DS0PR12MB780432BEB1D74FE5685273F59735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DS0PR12MB78045E926BE8E8D0B663CAEC9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <6ecd4ff4-d427-6c62-0c9f-21b7c601de79@amd.com>
 <DS0PR12MB780439434F2D1BD589ABC9359735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <3e0fe19f-68af-5802-0a33-bb5b63132f9e@amd.com>
 <DS0PR12MB78044AEE4BC81BD6338492DB9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <535641b0-6fb2-4541-ae89-c8f278869eb4@amd.com>
 <DS0PR12MB7804E1DB7C7882D3F0EA7EED9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <2d89d9f9-4dff-4de7-96c6-6176df98312f@amd.com>
Content-Language: en-US
In-Reply-To: <2d89d9f9-4dff-4de7-96c6-6176df98312f@amd.com>
X-ClientProxiedBy: YT4PR01CA0473.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::6) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0b3de5-0b99-407e-6d3d-08ddde8ca52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZS9RNjUxeml0MzB1Nm9XMzVqMWlHNmRFbGYxeURWcXpSQnMrZFlmVmNkZHRO?=
 =?utf-8?B?ZkQyRjU0T040WUUxMEZ5cjFkbnFTaDZVdkdKb2sreHptYWlqN29uMVBwWmhy?=
 =?utf-8?B?cDN5WkFHSFRwc0F4cFlxWFl5SVExOS9od2tnblFKSENjLzM3SlZpRFNQZU55?=
 =?utf-8?B?UGVWWGFUbU1mUDN5UjIzY2VsN2twaHNOdjlQR2lpMnFGNkJyNHVxai9ZZm50?=
 =?utf-8?B?MUpYSDllV1BzL09vNzJicVJMVDB1bmZGanZqMmZWTE9IWjdEZ0ttbGp3M3cx?=
 =?utf-8?B?NnZWMVNPS043ZDBQaGp6NnFWYjZIL2VnZnpqejdHQmNweFNLSDhGbGxFZzhi?=
 =?utf-8?B?ekluM3NYL2FvWGpYazk4Mmt5MXc1RWhYRFpzMTV1TC9EWVpqNEkxbW1UdU0v?=
 =?utf-8?B?VUJpSlB4TDVyYTBzQXNLcWJMYVVNMlduMmRlSDNlbjRVTW5GVjdrREc1TnNp?=
 =?utf-8?B?RWkwSERFNS9jWGhYSjZjaWZGUEl1TSsvaHdGaE5xVmZPMnBnT3VoeXNya1Vs?=
 =?utf-8?B?ZmJyUzZHSkpqM2NTbUkwY3Y1cVpOdzk4Q1lGWEtTVjBqclQ1N0JSQUJVRjM4?=
 =?utf-8?B?UDdHUCtCWWtrdFpoSno2ekNkMkFhaGNwV0gxcjc3MW1PK1FKSmRoY1lHeE1V?=
 =?utf-8?B?Q2xOOWRrU3A0TDVHMjNuMmNGbTZ2MzZlaWZMNDVDcnZMUFJUU1BFT2NxcXZp?=
 =?utf-8?B?K0xDaGVzS3NOM0ZxUWVqQ0trbDcvVHc3VVVkSDd0VEdhY3ZNOERLRHloQ1ZR?=
 =?utf-8?B?RnRWbnZlbktpNnRuS0ovU2w3TGZlQm50SDM1RitNd0RrMGo2aDBjQ3h1NVZ3?=
 =?utf-8?B?NmtXNTEwMGpPMTN6ZHJITmZsVEdaL0t0YlZRV0lLS3FxMkpFcER1SmZJSXd4?=
 =?utf-8?B?UUZRc2J5WEVxUFV2WnZwUjhSZXNvVWFJcjFLTHJzd1I2THE5QXV4QXk2UXZB?=
 =?utf-8?B?b2loanJaUlhPRHZNWFB4TXhTTEgwV3paOFdndFlVN3JwMDRaU2ZSOEhHQ2U2?=
 =?utf-8?B?L1VTa1AxWlpkTWVNaVFRR2VRYmo5Q25SQm14MnY3ZWlmbXBxc3RwUXM2SEYy?=
 =?utf-8?B?WTFWOVVEM1o3eng0YlZBRS9lK3VGWm9pRmN5NC9uYWgzSmFmZXU1L0k2M0d2?=
 =?utf-8?B?anluUm1KbWhhYjFMdzA2WE5ZeUZUSUxVcUpPYWdIQkRJeVozb05abEtCa3pv?=
 =?utf-8?B?M056RVBxYlRrWWhHaDgwQnluQmJkcnhWSHNJSDZZOC80ZTBiV3pGclI1c2xE?=
 =?utf-8?B?YlppQzgvSjI4S3JyejJ4QkwycmpwY2U3N2RULzdST2dhTXFkRm11U3JhNTdP?=
 =?utf-8?B?WmswVTJKY0VQeGFWMWZDZnI5NVlxOXU1YUovZ0NXQVZmNGdlYWMwZ3JpU0hv?=
 =?utf-8?B?ZUU2Ri9RekhSaEFCTEpIa0JwMGErNUwya2pRYXNEVEFXdkZkckp1aGRGbXpl?=
 =?utf-8?B?YmxLTlVoa1ZodktzbG5mU20ybURoWS9qVEtkZFhRWU1OVktIRERuMXBGNzBV?=
 =?utf-8?B?cHlob0tSWkFKZmdrZlNYVXF3MWhMWmxYWU9XenEzWUwwVTJkeFJlWkU0SllH?=
 =?utf-8?B?emVob0dYbkpJQ1FoVUtNZzROWjA2MTR5Rko3VllydTlGSytHSlJOWlpjZE9Y?=
 =?utf-8?B?bC85RTQydE9iVlp2WFZvQ2JpZE45TTNqaWdzUmtXN0VTNVpDU3BtZjZkUjhX?=
 =?utf-8?B?bTlNa3FJMDk5bGRNME9YK2lEYlFUeVNIRjdPemZHeldDeG5NSXJka05yYjVZ?=
 =?utf-8?B?YjBXaEtlOHFEZWxBT1dkajMwTmtQWTFLcjhqTytYWjJpWXhUcjVYd09lOGFR?=
 =?utf-8?B?enZIMWh1bTRZU3RLbk1yaDNlRXpXNFRPVHcyV3c4Tk9QaStPc2RNaEpVcjhx?=
 =?utf-8?B?RjBQR0FyOU5NV0ZyNmtQVDRQcUViMWtFUEhkY2w3dEtYcS9qeitISUQ0VnVh?=
 =?utf-8?Q?YTLrFPytFyU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFJDbElBTXVoMC85TGplejBFRVpnb3pKVzF0cXZudlhhdEhhY3lTdlJmVkVC?=
 =?utf-8?B?QytYSnB6bDRoRW1tVUtKeElsTGdRUHROSjFXdUZnNVVWT1BvTGN5QWhwNjBF?=
 =?utf-8?B?QWZVOWdPdzR0dUd4VXFadXluc0dITUhhQWNSTmRxQVdUTmNMRTJEcUw3ekVZ?=
 =?utf-8?B?bjZkcjVnU0ptanNKZU1MVmxFdVQxNWZoYWdmcXZzMW8rZnFYcEp3Smlkcndp?=
 =?utf-8?B?L04yOFVJRVI2WlNnbVBNWjJLODBiQmx0VlM3QTh1MkxpalpsZ2pWOG9KYXdl?=
 =?utf-8?B?QjVhRm1CdDhkNVE0V016VVptQWM2QVVwZ2hxcVJvQnpGV0pOdDd5TlNDa3V2?=
 =?utf-8?B?VHVDSEtBbUdzUHI0VHJvenhnZU9odDFCQklFRm5GbHVsd01PaWgyU2pTMEdi?=
 =?utf-8?B?ZWtpZ3dIYkdnbGl6dUZBbXJMdllEMlJoVHhrdmxURUU5S1FsUm1TQnhJNnBW?=
 =?utf-8?B?RTdkU1FOZGNnUmExWkRFTllEODg0bGM1WWk2Z09jcEhRTXA0UWNTZmlVY0tN?=
 =?utf-8?B?aHk0dXJ5aE5YNVVsbStWS1VSdVc2a1lHMENPOVd6QkVYbVdyZ1JPSERrTjAy?=
 =?utf-8?B?ODYrTVdRT3dVcjVPTkMvNSt0eUZveFhRalRxb05zdSsrbnlseU93UEZZU1JV?=
 =?utf-8?B?VW9HM3l3ZlNQcjV2ZTRkUmtmdUpXcmwrUU5PNC9GK2hUUnR6UGg1UkUrNU5q?=
 =?utf-8?B?d3BuV1NmVmJEQWxBVFQ2b2JsRnVYR0JBb0hpaW9VLzVMUGViOUVjM0xLQlZr?=
 =?utf-8?B?S3NWR1B2YjJ3MGJVM2tZRVk1WmN5cWNCRlBmUTNPME1yTklyelRBdUhUcWtB?=
 =?utf-8?B?MVFpTGsvUmN2cjBqdks0OVlEM2VKQ1hNSS9IMk5OMzJ5UWY1a1YrNzNuUFRU?=
 =?utf-8?B?MWFNR3dQdWl2RXJkdldjR1RvKzRZMndmNy9lcVZXZ3FoeEN2VldWbjREZ1lH?=
 =?utf-8?B?T3hGYUtpY3k0R2xGbE5XUXIyMGd1Rk1DY0lrd005ZVZNQWxoRFNxcDVEaHdk?=
 =?utf-8?B?MHg4dkpmcjAzZ2hJYjFZTVFWcmw2N0pwTXUxbG1WVEFnV2FndVUxWk9xdm0z?=
 =?utf-8?B?NVBSK1VzM0dJcllnSTZFb3JaMDhRYU00d29URDh0ZWtPNm5iV0NIUVUxT0to?=
 =?utf-8?B?cFRFWThRUG9XQUZpcklBSDIyU3ptcFV2Zm56MU10NlVrdEhxYUEwQitiaWwr?=
 =?utf-8?B?Q3dNZmNxYzl6aEVWOFlwNW45dTM4RW1KUis0VXBCV0luUG00ODdlbzI1aVFD?=
 =?utf-8?B?THEyajE1R1N1TStWOFlkeGFKSEZVMS9kRDZqT2xZcEN5RlRiZldSS2haOHRW?=
 =?utf-8?B?anB2TjIxTUM4UXVLcUlqc1NndHVBVFRXeG0zL3F5cmluUkxsV0pJZkpHQ0tM?=
 =?utf-8?B?cFJ2WnZpNzZWYldnaWJwUmZDU28wRlNSdkhkcldadjlmbXhHS1JJUzBwUVJj?=
 =?utf-8?B?Y0ZMU0dLYTZVNmhhL3lKb2ViRXJFU0F2ekF2NW55MU9aUjFicW0wYk9NZ3A2?=
 =?utf-8?B?dEJha1NmZUFkeDlsdGtFM2pUUHNjNVJMdG9DUmlwV2hObEZ6N2xnT0dMeDNm?=
 =?utf-8?B?cTFrTEVITmhkOFYyMERMcjVVeS9uM21JZ29MV3dkVlQ5OHFKWDZHd1J1OHZD?=
 =?utf-8?B?VFA1ZTFuQzNqOEV4OWNiNVBGRHlEaDVoSkRLaDZWa0xTY0g5MzYyY3g0eDB2?=
 =?utf-8?B?TDNqMXBFeHd1OUkvWVZaODJBVFl0L0twVHY1UENmZ3ZVSVczWEJub0Fiandt?=
 =?utf-8?B?MXY1U2NKSHlkVWEvWU11K2dGNFpSOTVpd2RhWGxwZkhLcVVwbmtBd1h4eW80?=
 =?utf-8?B?U1d5QWk5UG9aRzVXR09LVG9ENFFyUjYzQnRKcW5JMmZKVHY4ZEp6OG01empV?=
 =?utf-8?B?RkM1V3V5UlEwUytvazJwRXRURktuNno0bHJFUUhoOTJ2aHA4NkxOcGMzNU01?=
 =?utf-8?B?Y0tWSzllZ0FtZjFqdmFzbklJR1kxRXJmeTdzMDBSd25LR3AwVG5sVlk1a0Y3?=
 =?utf-8?B?Sml3VWhIaWphdjl2Yld1T1A1SC91eE9nZi93VDZQS3IrdjZvOFJQNGNOSGQw?=
 =?utf-8?B?Q1ZUNktxZVRtOUpKQWY2UTk5ZzVHUHF5Qk84cVg0VkpMNTBjMVI5VVM0WXRn?=
 =?utf-8?Q?ECXUTpJxtGu+bmIAj07psvttI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0b3de5-0b99-407e-6d3d-08ddde8ca52c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 19:23:00.8053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3wCcRPSK0rcSxFWnn4KnaJS/o0Pt54qSSm2etrzOoqZ9CqZ52HHI5TaETXk0ASyeYTlJXvgBFS/KU1SZ4iC6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

--------------1TlL7JgDnkImHCfCeJRd0fuS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lijo and Alex,

I prefer Lijo's method as it should not cause unexpected power profile 
change for the active session.
Liji, could you make some adjustments for your patch such as removing 
extra blank line and function
declaration such as using "void" instead of "int" for the new functions 
(should they be static?)

Thanks,

David

On 2025-08-14 14:42, David Wu wrote:
> hmm.. it is my concern for the same instance. but I got it now. Your 
> patch is good.
> Thanks,
> David
> On 2025-08-14 14:06, Lazar, Lijo wrote:
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>
>> I didn't fully understand the question.
>>
>> For the same instance, begin_thread will set the power state only 
>> after cancelling any idle worker for the instance. If idle worker is 
>> already under progress, then it needs to complete as that's a 
>> cancel_sync (it's the existing logic).
>>
>> Basically, by the time begin_thread sets the PG state, no idle worker 
>> for the same vcn instance would be active. If it's about context 
>> switch to another vcn instance's begin_thread, I think that won't be 
>> a problem.
>>
>> Thanks,
>> Lijo
>> ------------------------------------------------------------------------
>> *From:* Wu, David <David.Wu3@amd.com>
>> *Sent:* Thursday, August 14, 2025 11:14:26 PM
>> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; Sundararaju, Sathishkumar 
>> <Sathishkumar.Sundararaju@amd.com>; Alex Deucher <alexdeucher@gmail.com>
>> *Cc:* Wu, David <David.Wu3@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org 
>> <amd-gfx@lists.freedesktop.org>
>> *Subject:* Re: [PATCH] drm/amdgpu/vcn: fix video profile race 
>> condition (v3)
>> amdgpu_vcn_idle_work_handler():
>>      if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>> ----------- could it be possible a context switch here to
>> amdgpu_vcn_ring_begin_use()?
>>   if it could then AMD_PG_STATE_GATE will be set by mistake.
>>
>> David
>>
>> On 2025-08-14 08:54, Lazar, Lijo wrote:
>> > [Public]
>> >
>> > The request profile can be moved outside the pg_lock in begin_use 
>> as in the attached patch. It needs  set power state -> set profile order.
>> >
>> > This is the premise -
>> >
>> > Let's say there are two threads, begin_use thread and idle_work 
>> threads. begin_use and idle_work will need the workprofile mutex to 
>> request a profile.
>> >
>> > Case 1) Idle thread gets the lock first.
>> >          a) Idle thread sees vinst power state as PG_UNGATE, no 
>> harm done. It exits without requesting power profile change. 
>> begin_use thread gets the lock next, it sees profile as active and 
>> continues.
>> >          b) Idle thread sees vinst power state as PG_GATE, it will 
>> make workprofile_active to false and exit. Now when begin_use thread 
>> gets the mutex next, it's guaranteed to see the workprofile_active as 
>> false, hence it will request the profile.
>> >
>> > Case 2) begin_use thread gets the lock first.
>> >          a) Workload profile is active, hence it doesn't do 
>> anything and exits. The change made by begin_use thread to vinst 
>> power state (state = on) will now be visible to idle thread which 
>> gets the lock next. It will do nothing and exit.
>> >          b) Workload profile is inactive, hence it requests a 
>> profile change. Again, the change made by begin_use thread to vinst 
>> power state will now be visible to idle thread which gets the lock 
>> next. It will do nothing and exit.
>> >
>> > Thanks,
>> > Lijo
>> >
>> > -----Original Message-----
>> > From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
>> > Sent: Thursday, August 14, 2025 6:18 PM
>> > To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher 
>> <alexdeucher@gmail.com>
>> > Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> > Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race 
>> condition (v3)
>> >
>> >
>> > On 8/14/2025 5:33 PM, Lazar, Lijo wrote:
>> >> [Public]
>> >>
>> >> There is no need for nested lock. It only needs to follow the order
>> >>           set instance power_state
>> >>           set profile (this takes a global lock and hence instance 
>> power state will be visible to whichever thread that gets the work 
>> profile lock).
>> >>
>> >> You are seeing nested lock just because I added the code just 
>> after power state setting.
>> > Pasting your code from the file for ref :
>> >
>> > @@ -464,32 +509,14 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
>> > *ring)
>> >
>> > -pg_lock:
>> >
>> >        mutex_lock(&vcn_inst->vcn_pg_lock);
>> >        vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>> >
>> > +   amdgpu_vcn_get_profile(adev);
>> >
>> > vcn_pg_lock isn't  released here yet right ? And in-case you intend 
>> to only order the locks, then still there is an un-necessary OFF 
>> followed by ON, but yes that is acceptable,
>> >
>> > May be you want to move that vcn_pg_lock after 
>> amdgpu_vcn_get_profile to protect concurrent dpg_state access in 
>> begin_use.
>> >
>> > The concern is, this patch access power_state that is protected by 
>> some other mutex lock hoping it reflects right values also when 
>> holding powerprofile_lock.
>> >
>> > Or
>> >
>> > Have shared a patch with global workload_profile_mutex that 
>> simplifies this handling, and renamed pg_lock -> dpg_lock  and used
>> >
>> > that only for dpg_state changes per instance.
>> >
>> > Regards,
>> >
>> > Sathish
>> >
>> >> Thanks,
>> >> Lijo
>> >>
>> >> -----Original Message-----
>> >> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
>> >> Sent: Thursday, August 14, 2025 5:23 PM
>> >> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
>> >> <alexdeucher@gmail.com>
>> >> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>> >> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> >> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>> >> (v3)
>> >>
>> >>
>> >> On 8/14/2025 3:16 PM, Lazar, Lijo wrote:
>> >>> [Public]
>> >>>
>> >>> I see your point now. Attached should work, I guess. Is the 
>> concern more about having to take the lock for every begin?
>> >> This is closer,  but the thing is, IMO we shouldn't have to use 2 
>> locks and go into nested locking, we can do with just one global lock.
>> >>
>> >> Power_state of each instance, and global workload_profile_active are
>> >> inter-related, they need to be guarded together,
>> >>
>> >> nested could work , but why nested if single lock is enough ? 
>> nested complicates it.
>> >>
>> >> Regards,
>> >>
>> >> Sathish
>> >>
>> >>> Thanks,
>> >>> Lijo
>> >>>
>> >>> -----Original Message-----
>> >>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> >>> Lazar, Lijo
>> >>> Sent: Thursday, August 14, 2025 2:55 PM
>> >>> To: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>;
>> >>> Alex Deucher <alexdeucher@gmail.com>
>> >>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>> >>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> >>> Subject: RE: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>> >>> (v3)
>> >>>
>> >>> [Public]
>> >>>
>> >>> That is not required I think. The power profile is set by an 
>> instance *after* setting itself to power on. Also, it's switched back 
>> after changing its power state to off.  If idle worker is run by 
>> another instance, it won't be seeing the inst0 as power gated and 
>> won't change power profile.
>> >>>
>> >>> Thanks,
>> >>> Lijo
>> >>> -----Original Message-----
>> >>> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
>> >>> Sent: Thursday, August 14, 2025 2:41 PM
>> >>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
>> >>> <alexdeucher@gmail.com>
>> >>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>> >>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> >>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>> >>> (v3)
>> >>>
>> >>> Hi Lijo,
>> >>>
>> >>> On 8/14/2025 2:11 PM, Lazar, Lijo wrote:
>> >>>> [Public]
>> >>>>
>> >>>> We already have a per instance power state that can be tracked. 
>> What about something like attached?
>> >>> This also has concurrent access of the power state ,
>> >>> vcn.inst[i].cur_state is not protected by workload_profile_mutex
>> >>>
>> >>> every where, it can still change while you are holding 
>> workload_profile_mutex and checking it.
>> >>>
>> >>> Regards,
>> >>>
>> >>> Sathish
>> >>>
>> >>>> Thanks,
>> >>>> Lijo
>> >>>> -----Original Message-----
>> >>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> >>>> Sundararaju, Sathishkumar
>> >>>> Sent: Thursday, August 14, 2025 4:43 AM
>> >>>> To: Alex Deucher <alexdeucher@gmail.com>
>> >>>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>> >>>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> >>>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race
>> >>>> condition
>> >>>> (v3)
>> >>>>
>> >>>>
>> >>>> On 8/14/2025 3:38 AM, Alex Deucher wrote:
>> >>>>> On Wed, Aug 13, 2025 at 5:1 PM Sundararaju, Sathishkumar
>> >>>>> <sathishkumar.sundararaju@amd.com> wrote:
>> >>>>>> On 8/14/2025 2:33 AM, Alex Deucher wrote:
>> >>>>>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>> >>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>> >>>>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>> >>>>>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>> >>>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>> >>>>>>>>>> Hi Alex, Hi David,
>> >>>>>>>>>>
>> >>>>>>>>>> I see David's concern but his suggestion yet wont solve the
>> >>>>>>>>>> problem, neither the current form , reason :-
>> >>>>>>>>>>
>> >>>>>>>>>> The emitted fence count and total submission count are fast
>> >>>>>>>>>> transients which frequently become 0 in between video decodes
>> >>>>>>>>>> (between jobs) even with the atomics and locks there can be a
>> >>>>>>>>>> switch of video power profile, in the current form of patch
>> >>>>>>>>>> that window is minimized, but still can happen if stress
>> >>>>>>>>>> tested. But power state of any instance becoming zero
>> >>>>>>>>> Can you explain how this can happen?  I'm not seeing it.
>> >>>>>>>> Consider this situation, inst0 and inst1 actively decoding,
>> >>>>>>>> inst0 decode completes, delayed idle work starts.
>> >>>>>>>> inst0 idle handler can read 0 total fences and 0 total
>> >>>>>>>> submission count, even if inst1 is actively decoding, that's 
>> between the jobs,
>> >>>>>>>>         - as begin_use increaments vcn.total_submission_cnt and
>> >>>>>>>> end_use decreaments vcn.total_submission_cnt that can be 0.
>> >>>>>>>>         - if outstanding fences are cleared and no new emitted
>> >>>>>>>> fence, between jobs , can be 0.
>> >>>>>>>>         - both of the above conditions do not mean video decode
>> >>>>>>>> is complete on inst1, it is actively decoding.
>> >>>>>>> How can there be active decoding without an outstanding fence?
>> >>>>>>> In that case, total_fences (fences from both instances) would 
>> be non-0.
>> >>>>>> I mean on inst1 the job scheduled is already complete, so 0
>> >>>>>> outstanding fences, newer job is yet to be scheduled
>> >>>>>>
>> >>>>>> and commited to ring (inst1) , this doesn't mean decode has
>> >>>>>> stopped on
>> >>>>>> inst1 right (I am saying if timing of inst0 idle work coincides
>> >>>>>> with this),
>> >>>>>>
>> >>>>>> Or am I wrong in assuming this ? Can't this ever happen ? Please
>> >>>>>> correct my understanding here.
>> >>>>> The flow looks like:
>> >>>>>
>> >>>>> begin_use(inst)
>> >>>>> emit_fence(inst)
>> >>>>> end_use(inst)
>> >>>>>
>> >>>>> ...later
>> >>>>> fence signals
>> >>>>> ...later
>> >>>>> work handler
>> >>>>>
>> >>>>> In begin_use we increment the global and per instance submission.
>> >>>>> This protects the power gating and profile until end_use.  In end
>> >>>>> use we decrement the submissions because we don't need to protect
>> >>>>> anything any more as we have the fence that was submitted via the
>> >>>>> ring.  That fence won't signal until the job is complete.
>> >>>> Is a next begin_use always guaranteed to be run before current 
>> job fence signals ?
>> >>>>
>> >>>> if not then both total submission and total fence are zero , example
>> >>>> delayed job/packet submissions
>> >>>>
>> >>>> from user space, or next job schedule happens after current job 
>> fence signals.
>> >>>>
>> >>>> if this is never possible then (v3) is perfect.
>> >>>>
>> >>>> Regards,
>> >>>>
>> >>>> Sathish
>> >>>>
>> >>>>> For power gating, we
>> >>>>> only care about the submission count and fences for that instance,
>> >>>>> for the profile, we care about submission count and fences all 
>> instances.
>> >>>>> Once the fences have signalled, the outstanding fences will be 0
>> >>>>> and there won't be any active work.
>> >>>>>
>> >>>>> Alex
>> >>>>>
>> >>>>>> Regards,
>> >>>>>>
>> >>>>>> Sathish
>> >>>>>>
>> >>>>>>> Alex
>> >>>>>>>
>> >>>>>>>> Whereas if instances are powered off we are sure idle time is
>> >>>>>>>> past and it is powered off, no possible way of active video
>> >>>>>>>> decode, when all instances are off we can safely assume no
>> >>>>>>>> active decode and global lock protects it against new 
>> begin_use on any instance.
>> >>>>>>>> But the only distant concern is global common locks w.r.t perf,
>> >>>>>>>> but we are already having a global workprofile mutex , so there
>> >>>>>>>> shouldn't be any drop in perf, with just one single global lock
>> >>>>>>>> for all instances.
>> >>>>>>>>
>> >>>>>>>> Just sending out a patch with this fix, will leave it to you to
>> >>>>>>>> decide the right method. If you think outstanding total fences
>> >>>>>>>> can never be 0 during decode, then your previous version (v3)
>> >>>>>>>> itself is good, there is no real benefit of splitting the 
>> handlers as such.
>> >>>>>>>>
>> >>>>>>>> Regards,
>> >>>>>>>> Sathish
>> >>>>>>>>> If it is possible, maybe it would be easier to just split the
>> >>>>>>>>> profile and powergating into separate handlers.  The profile
>> >>>>>>>>> one would be global and the powergating one would be per 
>> instance.
>> >>>>>>>>> See the attached patches.
>> >>>>>>>>>
>> >>>>>>>>> Alex
>> >>>>>>>>>
>> >>>>>>>>>> can be a sure shot indication of break in a video decode, the
>> >>>>>>>>>> mistake in my patch was using per instance mutex, I should
>> >>>>>>>>>> have used a common global mutex, then that covers the 
>> situation David is trying to bring out.
>> >>>>>>>>>>
>> >>>>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using
>> >>>>>>>>>> flags to track power state could help us totally avoid 
>> this situation.
>> >>>>>>>>>>
>> >>>>>>>>>> Regards,
>> >>>>>>>>>>
>> >>>>>>>>>> Sathish
>> >>>>>>>>>>
>> >>>>>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>> >>>>>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>> >>>>>>>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David 
>> <davidwu2@amd.com> wrote:
>> >>>>>>>>>>>>> Hi Alex,
>> >>>>>>>>>>>>>
>> >>>>>>>>>>>>> The addition of  total_submission_cnt should work - in that
>> >>>>>>>>>>>>> it is unlikely to have a context switch right after the 
>> begin_use().
>> >>>>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer
>> >>>>>>>>>>>>> in case someone adds more before the lock and not reviewed
>> >>>>>>>>>>>>> thoroughly)
>> >>>>>>>>>>>>>           - up to you to decide.
>> >>>>>>>>>>>>>
>> >>>>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>> >>>>>>>>>>>>>
>> >>>>>>>>>>>>> Thanks,
>> >>>>>>>>>>>>> David
>> >>>>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>> >>>>>>>>>>>>>> If there are multiple instances of the VCN running, we may
>> >>>>>>>>>>>>>> end up switching the video profile while another instance
>> >>>>>>>>>>>>>> is active because we only take into account the current
>> >>>>>>>>>>>>>> instance's submissions.  Look at all outstanding fences
>> >>>>>>>>>>>>>> for the video profile.
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> v2: drop early exit in begin_use()
>> >>>>>>>>>>>>>> v3: handle possible race between begin_use() work handler
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload
>> >>>>>>>>>>>>>> profile
>> >>>>>>>>>>>>>> handling")
>> >>>>>>>>>>>>>> Reviewed-by: Sathishkumar S
>> >>>>>>>>>>>>>> <sathishkumar.sundararaju@amd.com> (v1)
>> >>>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> >>>>>>>>>>>>>> ---
>> >>>>>>>>>>>>>>          drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>> >>>>>>>>>>>>>> ++++++++++++-------------
>> >>>>>>>>>>>>>>          drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>> >>>>>>>>>>>>>>           2 files changed, 21 insertions(+), 20
>> >>>>>>>>>>>>>> deletions(-)
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> >>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> >>>>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>> >>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> >>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> >>>>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
>> >>>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>> >>>>>>>>>>>>>>              struct amdgpu_vcn_inst *vcn_inst =
>> >>>>>>>>>>>>>>                      container_of(work, struct
>> >>>>>>>>>>>>>> amdgpu_vcn_inst, idle_work.work);
>> >>>>>>>>>>>>>>              struct amdgpu_device *adev = vcn_inst->adev;
>> >>>>>>>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>> >>>>>>>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>> >>>>>>>>>>>>>> +     unsigned int total_fences = 0,
>> >>>>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>> >>>>>>>>>>>>>> +     unsigned int i, j;
>> >>>>>>>>>>>>>>              int r = 0;
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>> >>>>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 <<
>> >>>>>>>>>>>>>> + vcn_inst->inst))
>> >>>>>>>>>>>>>>                      return;
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>> >>>>>>>>>>>>>> -            fence[i] +=
>> >>>>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>> >>>>>>>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> >>>>>>>>>>>>>> +            struct amdgpu_vcn_inst *v =
>> >>>>>>>>>>>>>> + &adev->vcn.inst[i];
>> >>>>>>>>>>>>>> +
>> >>>>>>>>>>>>>> +            for (j = 0; j < v->num_enc_rings; ++j)
>> >>>>>>>>>>>>>> +                     fence[i] +=
>> >>>>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>> >>>>>>>>>>>>>> +            fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>> >>>>>>>>>>>>>> +            total_fences += fence[i];
>> >>>>>>>>>>>>>> +     }
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>>              /* Only set DPG pause for VCN3 or below, VCN4
>> >>>>>>>>>>>>>> and above will be handled by FW */
>> >>>>>>>>>>>>>>              if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>> >>>>>>>>>>>>>> -        !adev->vcn.inst[i].using_unified_queue) {
>> >>>>>>>>>>>>>> +        !vcn_inst->using_unified_queue) {
>> >>>>>>>>>>>>>>                      struct dpg_pause_state new_state;
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>>                      if (fence[i] || @@ -436,18 +442,18 @@
>> >>>>>>>>>>>>>> static void amdgpu_vcn_idle_work_handler(struct
>> >>>>>>>>>>>>>> work_struct
>> >>>>>>>>>>>>>> *work)
>> >>>>>>>>>>>>>>                      else
>> >>>>>>>>>>>>>>                              new_state.fw_based =
>> >>>>>>>>>>>>>> VCN_DPG_STATE__UNPAUSE;
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> -            adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>> >>>>>>>>>>>>>> +            vcn_inst->pause_dpg_mode(vcn_inst,
>> >>>>>>>>>>>>>> + &new_state);
>> >>>>>>>>>>>>>>               }
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>> >>>>>>>>>>>>>> -     fences += fence[i];
>> >>>>>>>>>>>>>> -
>> >>>>>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>> >>>>>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>> >>>>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>> >>>>>>>>>>>>>> +            /* This is specific to this instance */
>> >>>>>>>>>>>>>>                      mutex_lock(&vcn_inst->vcn_pg_lock);
>> >>>>>>>>>>>>>>                      vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>> >>>>>>>>>>>>>>                      mutex_unlock(&vcn_inst->vcn_pg_lock);
>> >>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>> >>>>>>>>>>>>>> -            if (adev->vcn.workload_profile_active) {
>> >>>>>>>>>>>>>> +            /* This is global and depends on all VCN instances */
>> >>>>>>>>>>>>>> +            if (adev->vcn.workload_profile_active &&
>> >>>>>>>>>>>>>> !total_fences &&
>> >>>>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>> >>>>>>>>>>>>>>                              r =
>> >>>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
>> >>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO, false);
>> >>>>>>>>>>>>>>                              if (r) @@ -467,16 +473,10 @@
>> >>>>>>>>>>>>>> void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>> >>>>>>>>>>>>>>              int r = 0;
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>>              atomic_inc(&vcn_inst->total_submission_cnt);
>> >>>>>>>>>>>>>> +    atomic_inc(&adev->vcn.total_submission_cnt);
>> >>>>>>>>>>>>> move this addition down inside the mutex lock
>> >>>>>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> -     /* We can safely return early here because we've cancelled the
>> >>>>>>>>>>>>>> -      * the delayed work so there is no one else to set it to false
>> >>>>>>>>>>>>>> -      * and we don't care if someone else sets it to true.
>> >>>>>>>>>>>>>> -      */
>> >>>>>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
>> >>>>>>>>>>>>>> -            goto pg_lock;
>> >>>>>>>>>>>>>> -
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>> >>>>>>>>>>>>> move to here:
>> >>>>>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>> >>>>>>>>>>>>> I think this should work for multiple instances.
>> >>>>>>>>>>>> Why does this need to be protected by the mutex?
>> >>>>>>>>>>> hmm.. OK - no need and it is actually better before the 
>> mutex.
>> >>>>>>>>>>> David
>> >>>>>>>>>>>> Alex
>> >>>>>>>>>>>>
>> >>>>>>>>>>>>> David
>> >>>>>>>>>>>>>>              if (!adev->vcn.workload_profile_active) {
>> >>>>>>>>>>>>>>                      r =
>> >>>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
>> >>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO, @@ -487,7 +487,6 @@ void
>> >>>>>>>>>>>>>> amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>> >>>>>>>>>>>>>>               }
>> >>>>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> -pg_lock:
>> >>>>>>>>>>>>>>              mutex_lock(&vcn_inst->vcn_pg_lock);
>> >>>>>>>>>>>>>>              vcn_inst->set_pg_state(vcn_inst,
>> >>>>>>>>>>>>>> AMD_PG_STATE_UNGATE);
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct
>> >>>>>>>>>>>>>> amdgpu_ring
>> >>>>>>>>>>>>>> *ring)
>> >>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submiss
>> >>>>>>>>>>>>>> i
>> >>>>>>>>>>>>>> o
>> >>>>>>>>>>>>>> n
>> >>>>>>>>>>>>>> _cnt);
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submissio
>> >>>>>>>>>>>>>> n
>> >>>>>>>>>>>>>> _
>> >>>>>>>>>>>>>> c
>> >>>>>>>>>>>>>> nt);
>> >>>>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>> >>>>>>>>>>>>>>                                    VCN_IDLE_TIMEOUT); diff
>> >>>>>>>>>>>>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> >>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> >>>>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>> >>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> >>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> >>>>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>>              uint16_t inst_mask;
>> >>>>>>>>>>>>>>              uint8_t num_inst_per_aid;
>> >>>>>>>>>>>>>> +    atomic_t                total_submission_cnt;
>> >>>>>>>>>>>>>>
>> >>>>>>>>>>>>>>              /* IP reg dump */
>> >>>>>>>>>>>>>>              uint32_t                *ip_dump;
--------------1TlL7JgDnkImHCfCeJRd0fuS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Lijo and Alex,</p>
    I prefer Lijo's method as it should not cause unexpected power
    profile change for the active session.<br>
    Liji, could you make some adjustments for your patch such as
    removing extra blank line and function&nbsp;<br>
    declaration such as using &quot;void&quot; instead of &quot;int&quot; for the new
    functions (should they be static?) <br>
    <p>Thanks,</p>
    <p>David<br>
    </p>
    <div class="moz-cite-prefix">On 2025-08-14 14:42, David Wu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2d89d9f9-4dff-4de7-96c6-6176df98312f@amd.com">
      
      <div class="moz-cite-prefix">hmm.. it is my concern for the same
        instance. but I got it now. Your patch is good. <br>
      </div>
      <div class="moz-cite-prefix">Thanks,</div>
      <div class="moz-cite-prefix">David<br>
      </div>
      <div class="moz-cite-prefix">On 2025-08-14 14:06, Lazar, Lijo
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:DS0PR12MB7804E1DB7C7882D3F0EA7EED9735A@DS0PR12MB7804.namprd12.prod.outlook.com">
        <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left"> [AMD Official Use Only - AMD Internal
          Distribution Only]<br>
        </p>
        <br>
        <div>
          <div dir="auto" style="font-family: Aptos, Aptos_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
            I didn't fully understand the question.&nbsp;</div>
          <div dir="auto" style="font-family: Aptos, Aptos_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <br>
          </div>
          <div dir="auto" style="font-family: Aptos, Aptos_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
            For the same instance, begin_thread will set the power state
            only after cancelling any idle worker for the instance. If
            idle worker is already under progress, then it needs to
            complete as that's a cancel_sync (it's the existing logic).</div>
          <div dir="auto" style="font-family: Aptos, Aptos_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
            <br>
          </div>
          <div dir="auto" style="font-family: Aptos, Aptos_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
            Basically, by the time begin_thread sets the PG state, no
            idle worker for the same vcn instance would be active. If
            it's about context switch to another vcn instance's
            begin_thread, I think that won't be a problem.</div>
          <div id="ms-outlook-mobile-body-separator-line" dir="auto"><br>
          </div>
          <div id="ms-outlook-mobile-signature" style="font-family: Aptos, Aptos_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir="auto">
            <div dir="auto">Thanks,</div>
            <div dir="auto">Lijo</div>
          </div>
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" style="font-size:11pt" color="#000000"><b>From:</b> Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com" moz-do-not-send="true">&lt;David.Wu3@amd.com&gt;</a><br>
              <b>Sent:</b> Thursday, August 14, 2025 11:14:26 PM<br>
              <b>To:</b> Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com" moz-do-not-send="true">&lt;Lijo.Lazar@amd.com&gt;</a>;
              Sundararaju, Sathishkumar <a class="moz-txt-link-rfc2396E" href="mailto:Sathishkumar.Sundararaju@amd.com" moz-do-not-send="true">&lt;Sathishkumar.Sundararaju@amd.com&gt;</a>;
              Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a><br>
              <b>Cc:</b> Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com" moz-do-not-send="true">&lt;David.Wu3@amd.com&gt;</a>;
              Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu/vcn: fix video
              profile race condition (v3)</font>
            <div>&nbsp;</div>
          </div>
          <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
                <div class="PlainText">amdgpu_vcn_idle_work_handler():<br>
                  &nbsp;&nbsp;&nbsp;&nbsp; if (!fences &amp;&amp;
                  !atomic_read(&amp;vcn_inst-&gt;total_submission_cnt))
                  {<br>
                  ----------- could it be possible a context switch here
                  to <br>
                  amdgpu_vcn_ring_begin_use()?<br>
                  &nbsp;&nbsp;if it could then AMD_PG_STATE_GATE will be set by
                  mistake.<br>
                  <br>
                  David<br>
                  <br>
                  On 2025-08-14 08:54, Lazar, Lijo wrote:<br>
                  &gt; [Public]<br>
                  &gt;<br>
                  &gt; The request profile can be moved outside the
                  pg_lock in begin_use as in the attached patch. It
                  needs&nbsp; set power state -&gt; set profile order.<br>
                  &gt;<br>
                  &gt; This is the premise -<br>
                  &gt;<br>
                  &gt; Let's say there are two threads, begin_use thread
                  and idle_work threads. begin_use and idle_work will
                  need the workprofile mutex to request a profile.<br>
                  &gt;<br>
                  &gt; Case 1) Idle thread gets the lock first.<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a) Idle thread sees vinst power state as
                  PG_UNGATE, no harm done. It exits without requesting
                  power profile change. begin_use thread gets the lock
                  next, it sees profile as active and continues.<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b) Idle thread sees vinst power state as
                  PG_GATE, it will make workprofile_active to false and
                  exit. Now when begin_use thread gets the mutex next,
                  it's guaranteed to see the workprofile_active as
                  false, hence it will request the profile.<br>
                  &gt;<br>
                  &gt; Case 2) begin_use thread gets the lock first.<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a) Workload profile is active, hence it
                  doesn't do anything and exits. The change made by
                  begin_use thread to vinst power state (state = on)
                  will now be visible to idle thread which gets the lock
                  next. It will do nothing and exit.<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b) Workload profile is inactive, hence
                  it requests a profile change. Again, the change made
                  by begin_use thread to vinst power state will now be
                  visible to idle thread which gets the lock next. It
                  will do nothing and exit.<br>
                  &gt;<br>
                  &gt; Thanks,<br>
                  &gt; Lijo<br>
                  &gt;<br>
                  &gt; -----Original Message-----<br>
                  &gt; From: Sundararaju, Sathishkumar <a class="moz-txt-link-rfc2396E" href="mailto:Sathishkumar.Sundararaju@amd.com" moz-do-not-send="true">&lt;Sathishkumar.Sundararaju@amd.com&gt;</a><br>
                  &gt; Sent: Thursday, August 14, 2025 6:18 PM<br>
                  &gt; To: Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com" moz-do-not-send="true">&lt;Lijo.Lazar@amd.com&gt;</a>;
                  Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a><br>
                  &gt; Cc: Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com" moz-do-not-send="true">&lt;David.Wu3@amd.com&gt;</a>;
                  Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  &gt; Subject: Re: [PATCH] drm/amdgpu/vcn: fix video
                  profile race condition (v3)<br>
                  &gt;<br>
                  &gt;<br>
                  &gt; On 8/14/2025 5:33 PM, Lazar, Lijo wrote:<br>
                  &gt;&gt; [Public]<br>
                  &gt;&gt;<br>
                  &gt;&gt; There is no need for nested lock. It only
                  needs to follow the order<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set instance power_state<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set profile (this takes a global
                  lock and hence instance power state will be visible to
                  whichever thread that gets the work profile lock).<br>
                  &gt;&gt;<br>
                  &gt;&gt; You are seeing nested lock just because I
                  added the code just after power state setting.<br>
                  &gt; Pasting your code from the file for ref :<br>
                  &gt;<br>
                  &gt; @@ -464,32 +509,14 @@ void
                  amdgpu_vcn_ring_begin_use(struct amdgpu_ring<br>
                  &gt; *ring)<br>
                  &gt;<br>
                  &gt; -pg_lock:<br>
                  &gt;<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_inst-&gt;set_pg_state(vcn_inst,
                  AMD_PG_STATE_UNGATE);<br>
                  &gt;<br>
                  &gt; +&nbsp;&nbsp; amdgpu_vcn_get_profile(adev);<br>
                  &gt;<br>
                  &gt; vcn_pg_lock isn't&nbsp; released here yet right ? And
                  in-case you intend to only order the locks, then still
                  there is an un-necessary OFF followed by ON, but yes
                  that is acceptable,<br>
                  &gt;<br>
                  &gt; May be you want to move that vcn_pg_lock after
                  amdgpu_vcn_get_profile to protect concurrent dpg_state
                  access in begin_use.<br>
                  &gt;<br>
                  &gt; The concern is, this patch access power_state
                  that is protected by some other mutex lock hoping it
                  reflects right values also when holding
                  powerprofile_lock.<br>
                  &gt;<br>
                  &gt; Or<br>
                  &gt;<br>
                  &gt; Have shared a patch with global
                  workload_profile_mutex that simplifies this handling,
                  and renamed pg_lock -&gt; dpg_lock&nbsp; and used<br>
                  &gt;<br>
                  &gt; that only for dpg_state changes per instance.<br>
                  &gt;<br>
                  &gt; Regards,<br>
                  &gt;<br>
                  &gt; Sathish<br>
                  &gt;<br>
                  &gt;&gt; Thanks,<br>
                  &gt;&gt; Lijo<br>
                  &gt;&gt;<br>
                  &gt;&gt; -----Original Message-----<br>
                  &gt;&gt; From: Sundararaju, Sathishkumar <a class="moz-txt-link-rfc2396E" href="mailto:Sathishkumar.Sundararaju@amd.com" moz-do-not-send="true">&lt;Sathishkumar.Sundararaju@amd.com&gt;</a><br>
                  &gt;&gt; Sent: Thursday, August 14, 2025 5:23 PM<br>
                  &gt;&gt; To: Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com" moz-do-not-send="true">&lt;Lijo.Lazar@amd.com&gt;</a>;
                  Alex Deucher<br>
                  &gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a><br>
                  &gt;&gt; Cc: Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com" moz-do-not-send="true">&lt;David.Wu3@amd.com&gt;</a>;
                  Deucher, Alexander<br>
                  &gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  &gt;&gt; Subject: Re: [PATCH] drm/amdgpu/vcn: fix
                  video profile race condition<br>
                  &gt;&gt; (v3)<br>
                  &gt;&gt;<br>
                  &gt;&gt;<br>
                  &gt;&gt; On 8/14/2025 3:16 PM, Lazar, Lijo wrote:<br>
                  &gt;&gt;&gt; [Public]<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; I see your point now. Attached should
                  work, I guess. Is the concern more about having to
                  take the lock for every begin?<br>
                  &gt;&gt; This is closer,&nbsp; but the thing is, IMO we
                  shouldn't have to use 2 locks and go into nested
                  locking, we can do with just one global lock.<br>
                  &gt;&gt;<br>
                  &gt;&gt; Power_state of each instance, and global
                  workload_profile_active are<br>
                  &gt;&gt; inter-related, they need to be guarded
                  together,<br>
                  &gt;&gt;<br>
                  &gt;&gt; nested could work , but why nested if single
                  lock is enough ? nested complicates it.<br>
                  &gt;&gt;<br>
                  &gt;&gt; Regards,<br>
                  &gt;&gt;<br>
                  &gt;&gt; Sathish<br>
                  &gt;&gt;<br>
                  &gt;&gt;&gt; Thanks,<br>
                  &gt;&gt;&gt; Lijo<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; -----Original Message-----<br>
                  &gt;&gt;&gt; From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                  On Behalf Of<br>
                  &gt;&gt;&gt; Lazar, Lijo<br>
                  &gt;&gt;&gt; Sent: Thursday, August 14, 2025 2:55 PM<br>
                  &gt;&gt;&gt; To: Sundararaju, Sathishkumar <a class="moz-txt-link-rfc2396E" href="mailto:Sathishkumar.Sundararaju@amd.com" moz-do-not-send="true">&lt;Sathishkumar.Sundararaju@amd.com&gt;</a>;<br>
                  &gt;&gt;&gt; Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a><br>
                  &gt;&gt;&gt; Cc: Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com" moz-do-not-send="true">&lt;David.Wu3@amd.com&gt;</a>;
                  Deucher, Alexander<br>
                  &gt;&gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  &gt;&gt;&gt; Subject: RE: [PATCH] drm/amdgpu/vcn: fix
                  video profile race condition<br>
                  &gt;&gt;&gt; (v3)<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; [Public]<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; That is not required I think. The power
                  profile is set by an instance *after* setting itself
                  to power on. Also, it's switched back after changing
                  its power state to off.&nbsp; If idle worker is run by
                  another instance, it won't be seeing the inst0 as
                  power gated and won't change power profile.<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; Thanks,<br>
                  &gt;&gt;&gt; Lijo<br>
                  &gt;&gt;&gt; -----Original Message-----<br>
                  &gt;&gt;&gt; From: Sundararaju, Sathishkumar <a class="moz-txt-link-rfc2396E" href="mailto:Sathishkumar.Sundararaju@amd.com" moz-do-not-send="true">&lt;Sathishkumar.Sundararaju@amd.com&gt;</a><br>
                  &gt;&gt;&gt; Sent: Thursday, August 14, 2025 2:41 PM<br>
                  &gt;&gt;&gt; To: Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com" moz-do-not-send="true">&lt;Lijo.Lazar@amd.com&gt;</a>;
                  Alex Deucher<br>
                  &gt;&gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a><br>
                  &gt;&gt;&gt; Cc: Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com" moz-do-not-send="true">&lt;David.Wu3@amd.com&gt;</a>;
                  Deucher, Alexander<br>
                  &gt;&gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  &gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu/vcn: fix
                  video profile race condition<br>
                  &gt;&gt;&gt; (v3)<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; Hi Lijo,<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; On 8/14/2025 2:11 PM, Lazar, Lijo wrote:<br>
                  &gt;&gt;&gt;&gt; [Public]<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt; We already have a per instance power
                  state that can be tracked. What about something like
                  attached?<br>
                  &gt;&gt;&gt; This also has concurrent access of the
                  power state ,<br>
                  &gt;&gt;&gt; vcn.inst[i].cur_state is not protected by
                  workload_profile_mutex<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; every where, it can still change while
                  you are holding workload_profile_mutex and checking
                  it.<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; Regards,<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; Sathish<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt; Thanks,<br>
                  &gt;&gt;&gt;&gt; Lijo<br>
                  &gt;&gt;&gt;&gt; -----Original Message-----<br>
                  &gt;&gt;&gt;&gt; From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                  On Behalf Of<br>
                  &gt;&gt;&gt;&gt; Sundararaju, Sathishkumar<br>
                  &gt;&gt;&gt;&gt; Sent: Thursday, August 14, 2025 4:43
                  AM<br>
                  &gt;&gt;&gt;&gt; To: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a><br>
                  &gt;&gt;&gt;&gt; Cc: Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com" moz-do-not-send="true">&lt;David.Wu3@amd.com&gt;</a>;
                  Deucher, Alexander<br>
                  &gt;&gt;&gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  &gt;&gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu/vcn:
                  fix video profile race<br>
                  &gt;&gt;&gt;&gt; condition<br>
                  &gt;&gt;&gt;&gt; (v3)<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt; On 8/14/2025 3:38 AM, Alex Deucher
                  wrote:<br>
                  &gt;&gt;&gt;&gt;&gt; On Wed, Aug 13, 2025 at 5:1 PM
                  Sundararaju, Sathishkumar<br>
                  &gt;&gt;&gt;&gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com" moz-do-not-send="true">&lt;sathishkumar.sundararaju@amd.com&gt;</a>
                  wrote:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; On 8/14/2025 2:33 AM, Alex
                  Deucher wrote:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt; On Wed, Aug 13, 2025 at
                  4:58 PM Sundararaju, Sathishkumar<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com" moz-do-not-send="true">&lt;sathishkumar.sundararaju@amd.com&gt;</a>
                  wrote:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 8/14/2025 1:35 AM,
                  Alex Deucher wrote:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Wed, Aug 13,
                  2025 at 2:23 PM Sundararaju, Sathishkumar<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com" moz-do-not-send="true">&lt;sathishkumar.sundararaju@amd.com&gt;</a>
                  wrote:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi Alex, Hi
                  David,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I see David's
                  concern but his suggestion yet wont solve the<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; problem,
                  neither the current form , reason :-<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The emitted
                  fence count and total submission count are fast<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; transients
                  which frequently become 0 in between video decodes<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (between
                  jobs) even with the atomics and locks there can be a<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; switch of
                  video power profile, in the current form of patch<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; that window
                  is minimized, but still can happen if stress<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; tested. But
                  power state of any instance becoming zero<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Can you explain
                  how this can happen?&nbsp; I'm not seeing it.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Consider this
                  situation, inst0 and inst1 actively decoding,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; inst0 decode
                  completes, delayed idle work starts.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; inst0 idle handler
                  can read 0 total fences and 0 total<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; submission count,
                  even if inst1 is actively decoding, that's between the
                  jobs,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - as
                  begin_use increaments vcn.total_submission_cnt and<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; end_use decreaments
                  vcn.total_submission_cnt that can be 0.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - if
                  outstanding fences are cleared and no new emitted<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; fence, between jobs ,
                  can be 0.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - both of the
                  above conditions do not mean video decode<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; is complete on inst1,
                  it is actively decoding.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt; How can there be active
                  decoding without an outstanding fence?<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt; In that case,
                  total_fences (fences from both instances) would be
                  non-0.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; I mean on inst1 the job
                  scheduled is already complete, so 0<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; outstanding fences, newer job
                  is yet to be scheduled<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; and commited to ring (inst1)
                  , this doesn't mean decode has<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; stopped on<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; inst1 right (I am saying if
                  timing of inst0 idle work coincides<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; with this),<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; Or am I wrong in assuming
                  this ? Can't this ever happen ? Please<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; correct my understanding
                  here.<br>
                  &gt;&gt;&gt;&gt;&gt; The flow looks like:<br>
                  &gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt; begin_use(inst)<br>
                  &gt;&gt;&gt;&gt;&gt; emit_fence(inst)<br>
                  &gt;&gt;&gt;&gt;&gt; end_use(inst)<br>
                  &gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt; ...later<br>
                  &gt;&gt;&gt;&gt;&gt; fence signals<br>
                  &gt;&gt;&gt;&gt;&gt; ...later<br>
                  &gt;&gt;&gt;&gt;&gt; work handler<br>
                  &gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt; In begin_use we increment the
                  global and per instance submission.<br>
                  &gt;&gt;&gt;&gt;&gt; This protects the power gating
                  and profile until end_use.&nbsp; In end<br>
                  &gt;&gt;&gt;&gt;&gt; use we decrement the submissions
                  because we don't need to protect<br>
                  &gt;&gt;&gt;&gt;&gt; anything any more as we have the
                  fence that was submitted via the<br>
                  &gt;&gt;&gt;&gt;&gt; ring.&nbsp; That fence won't signal
                  until the job is complete.<br>
                  &gt;&gt;&gt;&gt; Is a next begin_use always guaranteed
                  to be run before current job fence signals ?<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt; if not then both total submission and
                  total fence are zero , example<br>
                  &gt;&gt;&gt;&gt; delayed job/packet submissions<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt; from user space, or next job schedule
                  happens after current job fence signals.<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt; if this is never possible then (v3)
                  is perfect.<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt; Regards,<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt; Sathish<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt; For power gating, we<br>
                  &gt;&gt;&gt;&gt;&gt; only care about the submission
                  count and fences for that instance,<br>
                  &gt;&gt;&gt;&gt;&gt; for the profile, we care about
                  submission count and fences all instances.<br>
                  &gt;&gt;&gt;&gt;&gt; Once the fences have signalled,
                  the outstanding fences will be 0<br>
                  &gt;&gt;&gt;&gt;&gt; and there won't be any active
                  work.<br>
                  &gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt; Alex<br>
                  &gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; Regards,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; Sathish<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt; Alex<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Whereas if instances
                  are powered off we are sure idle time is<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; past and it is
                  powered off, no possible way of active video<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; decode, when all
                  instances are off we can safely assume no<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; active decode and
                  global lock protects it against new begin_use on any
                  instance.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; But the only distant
                  concern is global common locks w.r.t perf,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; but we are already
                  having a global workprofile mutex , so there<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; shouldn't be any drop
                  in perf, with just one single global lock<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; for all instances.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Just sending out a
                  patch with this fix, will leave it to you to<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; decide the right
                  method. If you think outstanding total fences<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; can never be 0 during
                  decode, then your previous version (v3)<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; itself is good, there
                  is no real benefit of splitting the handlers as such.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sathish<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If it is
                  possible, maybe it would be easier to just split the<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; profile and
                  powergating into separate handlers.&nbsp; The profile<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; one would be
                  global and the powergating one would be per instance.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; See the attached
                  patches.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Alex<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; can be a sure
                  shot indication of break in a video decode, the<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; mistake in my
                  patch was using per instance mutex, I should<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; have used a
                  common global mutex, then that covers the situation
                  David is trying to bring out.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Using one
                  global vcn.pg_lock for idle and begin_use and using<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; flags to
                  track power state could help us totally avoid this
                  situation.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sathish<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 8/13/2025
                  11:46 PM, Wu, David wrote:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On
                  8/13/2025 12:51 PM, Alex Deucher wrote:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On
                  Wed, Aug 13, 2025 at 12:39 PM Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:davidwu2@amd.com" moz-do-not-send="true">&lt;davidwu2@amd.com&gt;</a>
                  wrote:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  Hi Alex,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  The addition of&nbsp; total_submission_cnt should work - in
                  that<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  it is unlikely to have a context switch right after
                  the begin_use().<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  The suggestion of moving it inside the lock (which I
                  prefer<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  in case someone adds more before the lock and not
                  reviewed<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  thoroughly)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - up to
                  you to decide.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  Reviewed-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com" moz-do-not-send="true">&lt;David.Wu3@amd.com&gt;</a><br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  Thanks,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  David<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  On 8/13/2025 9:45 AM, Alex Deucher wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If there are
                  multiple instances of the VCN running, we may<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; end up
                  switching the video profile while another instance<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; is active
                  because we only take into account the current<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; instance's
                  submissions.&nbsp; Look at all outstanding fences<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; for the video
                  profile.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; v2: drop early
                  exit in begin_use()<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; v3: handle
                  possible race between begin_use() work handler<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Fixes:
                  3b669df92c85 (&quot;drm/amdgpu/vcn: adjust workload<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; profile<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; handling&quot;)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Reviewed-by:
                  Sathishkumar S<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com" moz-do-not-send="true">&lt;sathishkumar.sundararaju@amd.com&gt;</a>
                  (v1)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by:
                  Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  ++++++++++++-------------<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |&nbsp; 1 +<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2
                  files changed, 21 insertions(+), 20<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; deletions(-)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; index
                  9a76e11d1c184..593c1ddf8819b 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -415,19
                  +415,25 @@ static void<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  amdgpu_vcn_idle_work_handler(struct work_struct *work)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  struct amdgpu_vcn_inst *vcn_inst =<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  container_of(work, struct<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  amdgpu_vcn_inst, idle_work.work);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  struct amdgpu_device *adev = vcn_inst-&gt;adev;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned
                  int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned
                  int i = vcn_inst-&gt;inst, j;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned
                  int total_fences = 0,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  fence[AMDGPU_MAX_VCN_INSTANCES] = {0};<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned
                  int i, j;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  int r = 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if
                  (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if
                  (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +
                  vcn_inst-&gt;inst))<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  return;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (j =
                  0; j &lt; adev-&gt;vcn.inst[i].num_enc_rings; ++j)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  fence[i] +=<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
amdgpu_fence_count_emitted(&amp;vcn_inst-&gt;ring_enc[j]);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =
                  0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  struct amdgpu_vcn_inst *v =<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +
                  &amp;adev-&gt;vcn.inst[i];<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  for (j = 0; j &lt; v-&gt;num_enc_rings; ++j)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence[i] +=<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  amdgpu_fence_count_emitted(&amp;v-&gt;ring_enc[j]);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  fence[i] +=
                  amdgpu_fence_count_emitted(&amp;v-&gt;ring_dec);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  total_fences += fence[i];<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  /* Only set DPG pause for VCN3 or below, VCN4<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; and above will
                  be handled by FW */<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG
                  &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  !adev-&gt;vcn.inst[i].using_unified_queue) {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  !vcn_inst-&gt;using_unified_queue) {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  struct dpg_pause_state new_state;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (fence[i] || @@ -436,18 +442,18 @@<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; static void
                  amdgpu_vcn_idle_work_handler(struct<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; work_struct<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; *work)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  else<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  new_state.fw_based =<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  VCN_DPG_STATE__UNPAUSE;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  adev-&gt;vcn.inst[i].pause_dpg_mode(vcn_inst,
                  &amp;new_state);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  vcn_inst-&gt;pause_dpg_mode(vcn_inst,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +
                  &amp;new_state);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; fence[i]
                  +=
                  amdgpu_fence_count_emitted(&amp;vcn_inst-&gt;ring_dec);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; fences +=
                  fence[i];<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if
                  (!fences &amp;&amp;
                  !atomic_read(&amp;vcn_inst-&gt;total_submission_cnt))
                  {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if
                  (!fence[vcn_inst-&gt;inst] &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  !atomic_read(&amp;vcn_inst-&gt;total_submission_cnt))
                  {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  /* This is specific to this instance */<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  vcn_inst-&gt;set_pg_state(vcn_inst,
                  AMD_PG_STATE_GATE);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  mutex_unlock(&amp;vcn_inst-&gt;vcn_pg_lock);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (adev-&gt;vcn.workload_profile_active) {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  /* This is global and depends on all VCN instances */<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (adev-&gt;vcn.workload_profile_active &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; !total_fences
                  &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +
                  !atomic_read(&amp;adev-&gt;vcn.total_submission_cnt))
                  {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  r =<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  amdgpu_dpm_switch_power_profile(adev,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  PP_SMC_POWER_PROFILE_VIDEO, false);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (r) @@ -467,16 +473,10 @@<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; void
                  amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  int r = 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  atomic_inc(&amp;vcn_inst-&gt;total_submission_cnt);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;
                  atomic_inc(&amp;adev-&gt;vcn.total_submission_cnt);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  move this addition down inside the mutex lock<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  cancel_delayed_work_sync(&amp;vcn_inst-&gt;idle_work);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* We can
                  safely return early here because we've cancelled the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the
                  delayed work so there is no one else to set it to
                  false<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and we
                  don't care if someone else sets it to true.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if
                  (adev-&gt;vcn.workload_profile_active)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  goto pg_lock;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  move to here:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  atomic_inc(&amp;adev-&gt;vcn.total_submission_cnt);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I
                  think this should work for multiple instances.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Why
                  does this need to be protected by the mutex?<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; hmm.. OK
                  - no need and it is actually better before the mutex.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; David<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Alex<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  David<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (!adev-&gt;vcn.workload_profile_active) {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  r =<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  amdgpu_dpm_switch_power_profile(adev,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  PP_SMC_POWER_PROFILE_VIDEO, @@ -487,7 +487,6 @@ void<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  mutex_unlock(&amp;adev-&gt;vcn.workload_profile_mutex);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -pg_lock:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  vcn_inst-&gt;set_pg_state(vcn_inst,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  AMD_PG_STATE_UNGATE);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -528,6
                  +527,7 @@ void amdgpu_vcn_ring_end_use(struct<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amdgpu_ring<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; *ring)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
atomic_dec(&amp;ring-&gt;adev-&gt;vcn.inst[ring-&gt;me].dpg_enc_submiss<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; i<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; o<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; n<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; _cnt);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
atomic_dec(&amp;ring-&gt;adev-&gt;vcn.inst[ring-&gt;me].total_submissio<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; n<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; _<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nt);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +
                  atomic_dec(&amp;ring-&gt;adev-&gt;vcn.total_submission_cnt);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
schedule_delayed_work(&amp;ring-&gt;adev-&gt;vcn.inst[ring-&gt;me].idle_work,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  VCN_IDLE_TIMEOUT); diff<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; index
                  b3fb1d0e43fc9..febc3ce8641ff 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -352,6
                  +352,7 @@ struct amdgpu_vcn {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  uint16_t inst_mask;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  uint8_t num_inst_per_aid;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;
                  atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_submission_cnt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  /* IP reg dump */<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ip_dump;<br>
                </div>
              </span></font></div>
        </div>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------1TlL7JgDnkImHCfCeJRd0fuS--

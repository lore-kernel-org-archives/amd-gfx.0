Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEABE6BF1B
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 15:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF4D10EA0D;
	Fri, 30 Jan 2026 15:30:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WAknOFPE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E244410E375
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 15:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRJmi6gnjCDiprgUAt86sFh4zp0DTOWXl6cOYQ7ZWg27f0rEcOziuSklJjhM7c6uPks/n5MEdmJV4ecLMniCGRrl4d2ZN5BvTXTBcr38UpnWG3J5JPnhpZIyVwU7WpzAOJF7EsdZltVGMaGi9ErsiiTsX9s+tVbIFI2KT/Q943mN+MnE0Z6BT2IHFz1f1ujjB/WAwePAPYcYYeEne7S/yEFjITqx4VGR1cPm+HxTmEGBOja/aibjxInf/5tT6KijfElKHBE0xG/0xSxd03XLHPj33dbaRitX+X3H3d5eXUwg+KaMU8uxm5xNVpyNF4H0cD8KOyzQD+PMwHf8L4mtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDIa7QHLERLJh30PwZH5FJA5QBlLi7UkoA63PXix/M8=;
 b=NEaSpLwPqn0C+uJ7VZ5v8mQhVzkf36/Vb0RA1mv1I3HtRLhCXp9EvyiFtJ19Czhlsbr5nZ7MNPxjYxOXK83qhyczLSGRT4baWzM3EDsoteL85ZklzJlbDfY3gCRaNmFwpyQCOWKzwvCA2iNcNtRqgOS3wLx4P2mF/scotoBq5H8ogITbJ9AXiIoxdsqsDJMVtcRW36ZZwlINMDe/vN8T6AziJE7o6PhGjgVaMzA5JfyTQOAB27nhFIMR4FKbms9Cxe/n20T1+95uLR87ZQ9ONXFB1h9bWCPp82oCDKRdv/m5EqNC1faYGuetOFkC0ycnWm+TnFv3HspADvcnHGC+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDIa7QHLERLJh30PwZH5FJA5QBlLi7UkoA63PXix/M8=;
 b=WAknOFPEzL7nb6jtNvda0W5UcwcLdmA32g6nw5BAIIUejtCLZ/tDia8tyn+yEazkMHnJlk4Md8sBixfnG+epaTgkTikxBHp/6jaZvuozb2HPj9RwyKChLVXJLFI8ExhDH4wgy/yuhr045Bm+siRAvsxjC7Rz+rPlAmGZuJv9WpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 15:30:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:30:16 +0000
Message-ID: <e8bbdbef-8d34-4465-9ad1-aead5e1f9361@amd.com>
Date: Fri, 30 Jan 2026 16:30:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: re-add the bad job to the pending list
 for ring resets
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Philipp Stanner <phasta@kernel.org>
Cc: Jesse Zhang <jesse.zhang@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
 <20260129203731.21506-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260129203731.21506-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a99e1f-e350-4dc7-4692-08de60147805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TStTZTJob2FiemQwM0taM3JtVTltWEhUMWxWeG51eGIyNW9BVjdoNktjRm1r?=
 =?utf-8?B?cWV1UHVrVUlYN05EY2Zra0FueXg1RDZsYVlONXhvWHhyT1ovMXZMTGJ6b1pt?=
 =?utf-8?B?Ymc0UEludVEvY1paOHBWdFZpVE9IdnZXc0ZpMm1NRVBpMTlKeTR2VlRXd3JQ?=
 =?utf-8?B?OHNzYTFrME1Ta3dmeU1USVN1V3E1RStMbDBiUmdXWjQvODMzMFU0b1JLLzM3?=
 =?utf-8?B?bm13dGxSVTMzV0Y1Ym95VWtUTFl5RVlDU3ZaSGtjUGo1SmJUNTJqb1NpTkMz?=
 =?utf-8?B?YlRuMzVlaTBmd0NBUjIrLzU3NWUwbk1yTENTWmRoSW9vekQ3RnBZaDRraHVT?=
 =?utf-8?B?Q2Q0ZUdiM24xMlhUYW9Nd2F0U0dZN242T1RXdkFYUUgyWWwzQ0tKZ21uYmNn?=
 =?utf-8?B?d1VGemlNUXNUcDJvajQvQlhGemdndm9UWDZsVnhkSmVGZWpEQnVDZzIzQTZE?=
 =?utf-8?B?TkNSanIrUkpOSGNXK0RHdW1sMk5sN25OM2RDTEFwTVROY3ZGaG9ZRDU0WXFj?=
 =?utf-8?B?KytOOHlpdjJjWUlMaUNKZHRhV3hPcTE2bFdMdjRQMkV3ZW9USUhpdUdLTEpo?=
 =?utf-8?B?WlZwb1pqZloxbjFPY1VtWEZkRzkzd0lYZG1lS2s4ak12K1c1MC9XRmJYTTBk?=
 =?utf-8?B?SHJJZU5oSFJuY1M2MmNSZlJTdGVneUJHTUVEMktkV3BwWTlEZldNdUk1MU1W?=
 =?utf-8?B?bWNDNy9FK0RxcWFuQThRdzE3MHoxUnNRclowN2hvS0VOZExrbkpiREIxRjNj?=
 =?utf-8?B?UlgyV0xTajNBeW5yWlBVM0xLSndDYkRtRXNsYzZFc1NJVThYcnVudEhOYTUw?=
 =?utf-8?B?eVNLMTZZOEtBaHRPeG40aUkyLzNmM1J3c0oxdGxhWjlyTHlKbi9QU2tPWE5N?=
 =?utf-8?B?S3hQS0Q1Tm1EYVZ3dVVGZHN5RTZUdzFXd3c2YkU2UHI3UmZITFJLWnB3cTdt?=
 =?utf-8?B?L3R3SEZpZWV5Y1VGM3FObzluQ3p2bVBDd3JlQk9mUGZZZTh5bmIrUjAyR2hY?=
 =?utf-8?B?S3lhU1dzVGp2aWJSME1oS3dBQ3luK0sxT3gzRUprdUdtTmYrU1kxczVORjRE?=
 =?utf-8?B?RWtCOTVBVHlneFJJUVBXRUZBbDY2MlJVR2NNT2I5N3hGUzFKYXlXU3FZb2I1?=
 =?utf-8?B?cDBpcG03SlVScTFjQ2owV3YxYWJybm5LSnBuKzBYbnBLRStZVlRpWlhrMks1?=
 =?utf-8?B?akxkYnphS2hIMUN4dXZQcFRJcUV0NFZpeURGTXBubFh3d0MvcG5HM0VvclR1?=
 =?utf-8?B?ZTJBdTV4aEcvUGZmdUtSOUpMR2p6YkNtTE9JS1Q3MThUQm9YaElnV0h0WXEz?=
 =?utf-8?B?OTlUSTlDalN3eXExbmRUKzNQUWZYZmFUbzNHNGRyZ3B0ZXozRGljTWJpNVI5?=
 =?utf-8?B?WmwvWmVqWUxMOGUySTlYUXJEMm5vVDlzK0xmdXNYWk41YUprNWdNeEhKTVFT?=
 =?utf-8?B?K0hhc1h5OHY1SEhyV0RqcjNKOUh1TVh3eDFoM2FEZFp2WnBxZHpUUjlnUEEy?=
 =?utf-8?B?NGN3YTNWS0VQMHZoaDk1eGFTSktteXB4TnZxQ0lVWEpYMVRZakFoSU1aSThD?=
 =?utf-8?B?MU8xQlVmNWtWQWpadzNad2JUakNqZ01HcXpxeGl2Z3BoZnAvMGd4SGJkalRp?=
 =?utf-8?B?RDVEb1NCM2FqcUljeTk4UjcvZEdCcGk5ZkhFK3kyZVk5Qi9EUG5HODYrRity?=
 =?utf-8?B?aDQ0SUtZbXFNRno5VDNUNGN2SlZGZWwyVXNpSFV6dDRrQ3o4ZWp0U2V2dzRL?=
 =?utf-8?B?dmZxZkk2RG0wLzl4aDc1N2RQdHB0R2FhV0huQ3JCWlFtbEFkSkNqTmwxYmZm?=
 =?utf-8?B?dHo5bGRpdXVQWUNqTU03VWV3bkNXejNsU0xUMEIzazdpL3g0bTNRV1RVV0JP?=
 =?utf-8?B?YTltT05CMUk0ZzU0dTBYUjlGcURXOURkalUvQnpRQ0ZIdUxlK1RNeXNwbTdw?=
 =?utf-8?B?QWRGbldUVlJoNlRySFhNeno3eHJ0KzJMYVQzTG9DRDFwUm9VZzg3Q0plTjNV?=
 =?utf-8?B?amJGTzFxMzQ5SFlkaElRaG03cGhOWm1SU0pEalY5Rm9ueC9oc05HWWx4c1RX?=
 =?utf-8?B?U1REKzFsYlNaQmVNenVQVU8xZTQrZnF2dndPOCtyNTZDQUZOUXRmUjlxTUwr?=
 =?utf-8?Q?A3f8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhZcUM3VEM4UGVGTVBmQjF1OElqWTBIZ1MrdnhZbjRUTExvWGZzQUxFcFZl?=
 =?utf-8?B?eS9UdDJ0QUMrc29vQnJlWENkNzVQMUxPVTdKa0VIY2U1Y1BoaldaTnVHM09J?=
 =?utf-8?B?TlJFYTZ5cUJPVnJ0eWtLNkE5OHo2aCtpellVUU82VjNlc3BnZmoyV2d3am5m?=
 =?utf-8?B?RmswZWZxTjZJSU8xNldWZ0s0OG8rZGRYZ2puQ0FZL3AzcDFiQm0rT3Iyemds?=
 =?utf-8?B?KzFmbVRhbEJCaXFhTWljRUdVOEdyM25VWEZiWGh2aU5YbHdvSzZwNUlmM3l2?=
 =?utf-8?B?eEw3amtYZ3loMjZBcVJyOGxyVitkbmZrU2tNREFmUmxlZTJGSVFsd2RYRytK?=
 =?utf-8?B?aFIvN1hucmFXd3ZEY3FRYnZpYW14b1V5TE54ZjUyZ0w4OFJvdHhONStxUFpu?=
 =?utf-8?B?eTl4NFQyVURiM3FVdFM4NnlGd3BTcTRNbktZTVNxbXpZQXplUkw3cmJwUUNt?=
 =?utf-8?B?TC9ZNjhtcS9QMW93VkRpa1ZnRDcyanQyL2ZNbHFLUjBXbVhpcjB1c2wyUjFU?=
 =?utf-8?B?SDA4VW8xV1FjamczeVRhaGE0aVQwMkQ2MmJhWU41aC9nL3NVenR6ckgvOVAz?=
 =?utf-8?B?aDY5Ry9iM2pOYUVVVFpCZXVDbTBBVDhmM2xKWGtYUnp4bmF1cWpwYUJmVEZL?=
 =?utf-8?B?WGJPcjl3ekU1UU5jUUo2dVA4K2NiOEMvaFd1c3czMncvUTJhOFR6ZTQvLzhD?=
 =?utf-8?B?THFDZVJtZVBKbmtsVWdCeXAxVnhsS0JJY1poTVBjTkpXcStlZzRtT2ZNb0N6?=
 =?utf-8?B?V09IWE52VzQ1YUpNWkN6QkdxbzF6ckNmOUsvMkppUTFCaUx6bE5UOThQMmFj?=
 =?utf-8?B?SUdDdTZlK0s1RE9LUDNwQVlOTS9JOVdRZUl5MnB3UHJFcW9Ic1NMY2tsODdG?=
 =?utf-8?B?NFh4SGt6SlpvU1dJVlFaRUhYWlg1c2hNUk45dStRMXVxMDRLUE5BRlJNZlps?=
 =?utf-8?B?YnNjT1dDeVFmSThvVXJhUmV1MmpkbUVZdFQxVllDUzMyUnF0T2RObVpGWFNa?=
 =?utf-8?B?REtDWTcvd1czVnBIbnZEdHlITlFLY1ZSVXhqblZhOWVhTzkwdTQ3aG12V2w1?=
 =?utf-8?B?eXVGc21kdDZFMXpmM3VGdkpyNDdROXFycUZBNzFCWkR3V29mZmowdytFSjFO?=
 =?utf-8?B?SVVHRVpMQ1VYU25leGhjV2hrZDFRT0xqb2dpdHBRdkxIYlJ4MCt2ajdpbFV0?=
 =?utf-8?B?clgrQ0hJTzc2R2IrTkl3NmRvTkRTYUU1d0hhZHhQVjJwTWRXMkh3MjIyQkQ2?=
 =?utf-8?B?NGhpM0k0N1dIYUpHeEpmM1VxK0dUWHRzOXpMUThmamFtZUUvUDZBa1Zub2lT?=
 =?utf-8?B?eFF1VXVRM0p1eHE4QkZHbi9HSHpQSjNxeGdIdFc5c3F0dGFmV1VqWWlScDVJ?=
 =?utf-8?B?bTVydWdjQ2pVVXM0R0U0TElSUEw2aVpxb2RBNnVQaDRLT0czOW8raTVVK1Vk?=
 =?utf-8?B?czFRaCsxaU5Ob1BOOWNQRm10UmpRYTRBQkNzOWYyZkowMGQ2dk9RV2Zlemhn?=
 =?utf-8?B?cEE5blpTSXlia1hnQm5NTE5ET1ZvYVBxaGlMQUZ5cDl6dTVPdmQ5dXZwaTNX?=
 =?utf-8?B?ME56MHowV1VCNEc4WVI5VHlpclJnQmZRejhOcEFIODFOTjl3a3E4WkxQSnBr?=
 =?utf-8?B?OTg5ZmF4TWh3WDRMV1B5eXNiYjkrcVNtSzZEVWFzMTlUdm9kaFpTc2RjYlpi?=
 =?utf-8?B?YXFpVHdaMk5lTUlGRGRHdzZ5Q3drK2Q5N1dtT1FQeXVrd2dQVEUvZE9XUXZF?=
 =?utf-8?B?enRMekk3V1N6YVpZbG9hWDh3dm5XbGd0WkxSTHBENDJPTldscnN4SDB1S0ZI?=
 =?utf-8?B?bFVSRW42STByZmFTcjZCNmZrb3pFWUZDYUNqc2RFMjFCZEhQb1VLQnJQNGtv?=
 =?utf-8?B?bGRFZEhQbUFRUm41T290bVlIekk5bkNzaDZxMkRBdHJTTERvUDEvaXdEaUZV?=
 =?utf-8?B?VjBPM1FzSHQ4cXJEd2hnd0Q1MWxPSzNpem5qbG5qYm9sRzBoSHpvdlVVRlhR?=
 =?utf-8?B?QTVLSytQWVY0VENrdFd4NnliSjVoSE10amJyRDEzTDlWMy9tNjVaRnRvczlo?=
 =?utf-8?B?L20xdGIrSEhWcVl6QlVvb3BFQWpQc2lxTitzVkIvazVtZk9XdCtaNndyM0c0?=
 =?utf-8?B?TlM1WFN1aTVxNUhOcUQ5RW9KSUhrTzkzR3VXMkhlNk1oK3NsQmg4cElNRDRU?=
 =?utf-8?B?NjNGMUg2dzdaVENpcmhnYnhIbEtwTHhPY3N6bEk5K0p1N2J2N0NXV00vU3JY?=
 =?utf-8?B?MnFaTG4vN3F0TnB6Z3lhc0d6d0QyNk1kMlVpVFJaM0hCaXVJNG5JYWVzSmtQ?=
 =?utf-8?Q?rUm47JLSRA2J9mAZzf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a99e1f-e350-4dc7-4692-08de60147805
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:30:16.4373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAGle2qzqhqfmfYbzIrkfR5+OgtbUIVBtVFWdxOO0ei1sN1AnHZXjqngUwGWS/Qt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887
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



On 1/29/26 21:37, Alex Deucher wrote:
> Need to re-add the bad job to the pending list before we
> restart the scheduler.
> 
> Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index aaf5477fcd7ac..9b10470321be3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -135,8 +135,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	    ring->funcs->reset) {
>  		dev_err(adev->dev, "Starting %s ring reset\n",
>  			s_job->sched->name);
> +		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
> +		drm_sched_wqueue_stop(&ring->sched);
>  		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>  		if (!r) {
> +			/* add the job back to the pending list */
> +			list_add(&s_job->list, &s_job->sched->pending_list);

This is explicitly forbidden by the scheduler maintainer.

So we seriously can't do that here.

Correct approach would be to return the proper code to the scheduler so that the scheduler does that.

Regards,
Christian.

> +			/* Start the scheduler again */
> +			drm_sched_wqueue_start(&ring->sched);
>  			atomic_inc(&ring->adev->gpu_reset_counter);
>  			dev_err(adev->dev, "Ring %s reset succeeded\n",
>  				ring->sched.name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index b82357c657237..129ad51386535 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -868,8 +868,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
>  void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
>  				    struct amdgpu_fence *guilty_fence)
>  {
> -	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
> -	drm_sched_wqueue_stop(&ring->sched);
>  	/* back up the non-guilty commands */
>  	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
>  }
> @@ -895,8 +893,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>  			amdgpu_ring_write(ring, ring->ring_backup[i]);
>  		amdgpu_ring_commit(ring);
>  	}
> -	/* Start the scheduler again */
> -	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  


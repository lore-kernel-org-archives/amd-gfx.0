Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC512CCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 13:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3179B10EABC;
	Fri,  7 Nov 2025 13:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mj7XGeki";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BDD10EABC
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 13:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXB8tocg06OnZq1/jHWQma4HqNm9X4aEPLy35YMaAt/mIv2J9qrnhBlpgybN+yWYlBv3uToL4PviO4Dc09xmqC3L6A4pqkiF5rkGtUMifC35FQDgpXWHbCLcK5AsuuMJ5Bo6rw5qZn2B4qRuXhb76sWx6UyIwzYyqD0EennNlAZSPnpR8yMHw+KZClGlN1F1yIdTN7mTC5JOQXSU9o3KAyz7cvZ6ZkPZKTwSfeZsSet67/5P6cTMdWfxDBuuuONVruTnbMvTgPX1S51PW14tHCByiNoMp3W+gNHeK73WvO1J6jNqYqRxRYHlGJY4Bdlbp1MiLsupI8h12aPi4nZVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMAlGmCqZAEeWOvRJnnMGruBhOYnq72zPuYOzGe9Nek=;
 b=lh7P08HbQBw6dknJMJbMIeexzH0kVsr8JjViS5mIt1tF7JJvJevNJZC4Gwc33jDcv2jMkvlI9Kekz70bNwt7A6E896B7cOHg3PrOlKzhkCvT7FkiMYYpjr8YdZBYwDJ/Aqzz5BzAwzrP6kq2rP64TocOU+GgxsgHijLAGD7nnjQcN0X45lLj88YTrNlXYmd1eWhkWpSGDRMO2I8OCmXMFHUG3Z/KCEr8y0Fb03OmxO65V9APF248zbYsFbzuh8EsPQSi0o9nvxeceZiC3lsg3xKZRwg9PjmSoPdaNGrikieBvJ/qBhdrNI2ZZQkpejo6iwg24K65sUg4cQeF5Ytgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMAlGmCqZAEeWOvRJnnMGruBhOYnq72zPuYOzGe9Nek=;
 b=mj7XGekih3dqFP/86sRzJaE7kv6IK0m27yQv5ZyhBJplLz/QA6BgKs2ihP/NdrVBwJ0dfve0Ix8fzg2yIS8VDb6oIXr4dzd+fCMN33narxHg8BWbAon+kTa4U/8Asp5VFYV7UGwUo+y4L839QDYDn0JPRNNXvQe0iPYnKjYBF4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 13:14:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 13:14:30 +0000
Message-ID: <180c651a-1711-4618-96d4-692d0c9c8996@amd.com>
Date: Fri, 7 Nov 2025 14:14:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] drm/amdgpu/vce: Save/restore and pin VCPU BO for
 all VCE (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>,
 "Dong, Ruijing" <Ruijing.Dong@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-7-timur.kristof@gmail.com>
 <991f6d36-81e4-42d2-b301-0755fa00ffde@amd.com>
 <b7eb6efea5606c6d9b6d1bcdea6552b3602517bf.camel@gmail.com>
 <f0bbffa2-3b34-4f36-9fb2-44bcbcb5b8a3@amd.com>
 <a1f6e8e49d4f3d3a90afa8d3232b15626c34d991.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a1f6e8e49d4f3d3a90afa8d3232b15626c34d991.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 6407e906-4eed-4d2f-f139-08de1dff95b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFhGVEQyQzZmWTZFZG9SSXAzTlBLb3RSamc1UjNKMUpCbHBPMlRZeW9lNnQx?=
 =?utf-8?B?L2xHRGxRdjJMdEQxd3FGRUV6ekI0NmwweWNrRnhIVU9zS1lsOU9zZjBxQkFu?=
 =?utf-8?B?ZWF3L1RoZ2VTQlpiTzBONG9qQWN3WFV2bTU5UzBCZlBpeXdiQjZheCt5SW5w?=
 =?utf-8?B?ZEJjRE5Iem5zZDVVZWVKUG85OHluUmtiNm44VjNyUGt6WTV3bCtyMUtaUGND?=
 =?utf-8?B?SXlrRy9QY1kraW9MLzdhQk5pTzRqWThTeWQ1ejhNM3VPUVYvRXJNcjVzYWJl?=
 =?utf-8?B?WWdsYUZBL1RmdDZkU3JNOFVlN0pmWmMwZlp4WUI2RUhHZ1ZhUjRzTHU0RnQ4?=
 =?utf-8?B?cmxXZGNyckc2N0xGbkZFbFh6THo2eHZmWTJhTDlsa0JrTGp0RkU5VEhpUjJl?=
 =?utf-8?B?NDEzbzYyc0pqcGd1SFFMNnF0VE9VbWhLZHV4ZkJFcSt4TkVSSmIrVlNraWhG?=
 =?utf-8?B?eG1hVTlRUkIxU3RJT0lnVWlqa0J4RFN0ZmwyYnZrNnFSUDdhd1JQNThGdVFO?=
 =?utf-8?B?Q0NWMUI2cDFUeTMyejUyQWRMMTZYSlhwNnhUNFptT1QxdE5SZWtKVm14aG53?=
 =?utf-8?B?Z1dFUVViVVFGZGk1SnNxY3QyUWhQV1RHeFNTbm1tazBsR2I3cHhZQTNKWlBw?=
 =?utf-8?B?SWFpWWliY0Nud0xqQzNwY2ErQ0ZFNUI1Ui9BYzRTNmRkcVJDbXBiZ0FqaEpa?=
 =?utf-8?B?QVZoaFdjMmlNakxRdmlmL001aVRrQWVjcys4RS9BblpwaThWNnBGdFV6ZmJV?=
 =?utf-8?B?OU9qT0xBV042dWUycGF3Z1dZRHZ0NjBaelpLRStsZW1uUHZIUmVJSEJYejgr?=
 =?utf-8?B?eVFLb3luK0lMenN1NFVmcld3VjFFa2FRSTNOVlZMMkVnZnM2cmJzdlFoQkRZ?=
 =?utf-8?B?dG81QnVxQXIxTlhzNUs2Rk5SNjRoYm9wMm92OG5oNkZyVFNrRHRIcThoUUFj?=
 =?utf-8?B?aHdBckIrRU1kbkhINk1tZndRejFvOW1kQjV5S3kxNjd3WDlFdTBJYzVuNk9q?=
 =?utf-8?B?algrMlpwVGM3OHdVWittWVNFMUo4MEVXOGYvMzNNL0ZHNDRCWUtuck5mUnlr?=
 =?utf-8?B?Vm4rOGhYbTEzVEVWTE84T1NHRitNaHFQaVk4RnQwMnpRb3QyQllwd3VSMjhs?=
 =?utf-8?B?eXA5RTlJa3U1QzVndkR5MytGV2Z3bkFVYUVuanIxK0tzbEs4c1JmNHNMYU9y?=
 =?utf-8?B?bDBtWXZuNHZ3ZmtNQXdNbGU0ZG5nR3UrKzR3RElPNyt6b2ZCTzVON3dJS1Fv?=
 =?utf-8?B?bUVScVR5SjdMOVlUcjFBZmZYWE9tL1hvTW91MGxpNTlveU5yVk5jZUcyQXhZ?=
 =?utf-8?B?ZkhlVkhYNnlGa3NRdmVMbnhOVmltWFBqWTdKT29ldDZqeVZYVlZhdkk0bkR4?=
 =?utf-8?B?NGpxMVZGbVUzc1NueXI3MTRUTDVPMnFQRmNkYW51M0dPZlhMUXZaVGU4N1J4?=
 =?utf-8?B?V3V3N1RmaHVUK21aRFF6dnJDdDVMRmpxMEw4K1p4aVNpc2RlTW42SW1ZWFhD?=
 =?utf-8?B?RkVtbTVpSDJtL3RkTFRWRmN3aFhnQXdDSVMyN0YyaEg3SWtjNUZxK3E1Sjly?=
 =?utf-8?B?a2RHNDFtMWl6bS9WRDRVVytnT2srK3FJL1J4MzJJcXl6TldZMUdaazMrN2J3?=
 =?utf-8?B?Z3RtcDMxS0c3YXlPRHdUdms2eW1sYjVNUzAxTUtob0lKZnMxZUQ4MVRYM0dQ?=
 =?utf-8?B?R3JxT0RGQUtMZk43djd1NFBDWHF3ZENpSGRkb2Eva3gyTzEzUWw4dGowdy9D?=
 =?utf-8?B?Y0hpdkJPZS8wZ2diRU8xTG85dVBqbUVwaXdSTVdlVVV1TnlLODIzemhMQkk3?=
 =?utf-8?B?NUVlWjR5bUNORDd2TzF6cldDTXpzSTJ3eEtHbGJXOHRGK1huemxST1RKK1Fm?=
 =?utf-8?B?NCt5NWZzeUxwOTFLSmhRd3h5Smd4V0p6S3M3bHJldER3M0loT2hyTmtMQzdh?=
 =?utf-8?Q?Jxvlq8sjv47RDcebVa5RYFcPs+cnaI7N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVUyYW5haXdqaXhhTGEzSVNpM1kxeVlWSm4waXNSOEhSblZiUHo2Wk10Q1FO?=
 =?utf-8?B?b3hrSmk0eHFmYXgrZmRUWnJvQnZWMWp0QTBMUlpPS3ZNWDZYN0Eyb2ZaN2dG?=
 =?utf-8?B?bnhtQjYvQUsyR3g0QjRBRm4rcklvNVlZVXU3VmFMcnFtZlJhbThlNVJiSWh4?=
 =?utf-8?B?RFRjTlcvUDcxaUR4ZjJheThmSGNzSEg2R0k2bnRER0FMb1lQcisyOXAxNjIv?=
 =?utf-8?B?cFYwRHJWcHBPRFp6azlqN1R0U0NsNmRySC9MMnNMaXUwaU5CbktnZEdpNTI1?=
 =?utf-8?B?d01Qd1kwWFJlNWNqdkltMlFjdW1oOUd1NmNtd0ppZmg5a0ZmTHpGZW91bGo4?=
 =?utf-8?B?TVpZZVBwZSttVlNtWllYWGtmTVVPQmxlNEdQSGJkbXp5aXhUamh3S3Y3QzRR?=
 =?utf-8?B?Y3VSTlY2STVmTDY2eFdpM3VVaVZTdGJhbkFFejlXNG5XZTJnR1RPTDB5UzM4?=
 =?utf-8?B?OG9kcjhvSGpsWXpoSUFxMFhIM0dPYzFMd01KYkhScUJIbm0yY2tPNjlTQWZ6?=
 =?utf-8?B?cFMyUUpGRm44NFJlRitwd2hrTHBIMGpVaCtTd0tDcjJ3YmpCdWpOVXBaV1lQ?=
 =?utf-8?B?OTByOStxWEJONEZYN0tZckpkdTBWci9yOUhaUG1oRzVGelBTeGppaStsb0Qr?=
 =?utf-8?B?WTlLbDBWRHh6YWtvRUwxWWdlSUFMbjlZVWpFZEVKeStsUkk1T0pyL05FR0c2?=
 =?utf-8?B?elZycmQ0RHhhNWhPSURzd3lyR1hPOVlsTFkxK3Y3aCtVMHUrVnpZWTl5VHhE?=
 =?utf-8?B?TlUzb3lHOHBiaHZrQ0VRTFpnQTY4SnNTZ3lqcXZsaEdTQXFZeEQrUE9hMEgx?=
 =?utf-8?B?aXhDYkc3WWNDMER6bGkra2dKNVRCTFhHbGcvN3A2VUZ5eE5Bc0pxYk5CU1lx?=
 =?utf-8?B?czQ3NWJDUHl6RjB6ZWJVQzd1WjFqWUp3TWRhVXZOS3NTNnpIT1FyRCt3V2RI?=
 =?utf-8?B?THBBNE5vVjVLTmx6dW5aZThLSGU4OGQrcXRSOG9HYklJU1FMNk1YUGVBdWpy?=
 =?utf-8?B?SFl0L0JRckprUHdqZ3A1SmRlcjF2OVFRZ0RUY0JucjlpOXZMYVhiTE8zT05G?=
 =?utf-8?B?Q0Q5MVFWWGJJYUZpUGN1KzFkcHkyTGhLOGE2T0g2bW4vdTdNd2Q4aUJHOS9u?=
 =?utf-8?B?TUgwc3ZvZm1ERHFLWTR1VGlhdkFrNU12bmhNREY4cUZDK1ZmSUFFSWhWOTVv?=
 =?utf-8?B?eEJoTmY2RC9scnRESHpJbVNLVzNnTGdhOWttQkdjYkRRVlJjNnRCMyszSkZw?=
 =?utf-8?B?YUMwT0lSbkhzOTJNcXVxdzF3WTVRQzhZbHpIRkpQV0toOVJ2VVNNWGw5QVpr?=
 =?utf-8?B?UE9SMytSWnYxdFV6MllFN0NLdmQwMVpJVXdBMkRpWjVwcFlKd200Y1Uwako2?=
 =?utf-8?B?Uldybkg3UFprVnNPbmNMbStScWVrVXg4UFovRitWZTJ4eGkwajE2T3NiNkFp?=
 =?utf-8?B?N29pc09rL2c0dmpQbHMwSmVaUTFvRzRWaExRVEM5N1cxb0QxbTJ0U0syaFBC?=
 =?utf-8?B?clpGUHBib0hPRHZBS2lQT2N1blZJVEVGQ1I1WkJGQXdwcUljUWxwWUFIbkZ5?=
 =?utf-8?B?QVhkUmdsUDhaTFV5YUJPVTBmbW0vSk53dkI2SXNmc0FobDdidlJtbGgzU1Zl?=
 =?utf-8?B?Nm9ob0xhUnZ3MGhWbkhMMEJaSjRMa2JoSXVyZlJDQzIxKzFtSmFxOWZEVmtC?=
 =?utf-8?B?RmFhYk9mWDAvYlh5c1FKcTlIbTh1aVV1blZBV2ZKUXJ5aWZENDdpdDBxYytY?=
 =?utf-8?B?Q0sxaXFMQkFPQ0F1RVowZWxvZXA5Yk5waURxOVBoRGZrVGtROWkzWmsxOEdw?=
 =?utf-8?B?c09Ic1lsOEZrZDBlTnVmcHlPaHQ3UkdhV0ZuMEhPdUE0bkJFcGxzTlR2alVW?=
 =?utf-8?B?VUNrTmpzZWJaRTlmU3ZVdUh3WCtiNFhrcnNkMzNmZUVxWUZRTG4rT3hpZFZP?=
 =?utf-8?B?WVhNcTcwcGVtZ3Q2MXhpSTBNcVc3dXVOZEN2c244MWNHamZidEMwdTFmUXRK?=
 =?utf-8?B?aXhaaFNSSmRuaXRvZnRuSlVaVHpqejNpWDc3Ni9vTDgzOHJDMjJNdWhVdjFY?=
 =?utf-8?B?NUdDejJLaVRWdi91YkNNeVd5aFF5N2Zud0diV1NhL1ZxNHRJTzhicFhXOTh6?=
 =?utf-8?Q?HB0NqxKEaS+NLltlB5waiviVU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6407e906-4eed-4d2f-f139-08de1dff95b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 13:14:30.1146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwFK4lQIrY+IgyboO/3hI85DjrB8KLs+83mu3ZyTn8xhKym9N0pTaYrtmJ2WmnOX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
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

On 11/7/25 11:47, Timur Kristóf wrote:
> On Fri, 2025-11-07 at 11:01 +0100, Christian König wrote:
>> On 11/7/25 10:53, Timur Kristóf wrote:
>>> On Fri, 2025-11-07 at 10:49 +0100, Christian König wrote:
>>>> On 11/6/25 19:44, Timur Kristóf wrote:
>>>>> VCE uses the VCPU BO to keep track of currently active
>>>>> encoding sessions. To make sure the VCE functions correctly
>>>>> after suspend/resume, save the VCPU BO to system RAM on
>>>>> suspend and restore it on resume.
>>>>>
>>>>> Additionally, make sure to keep the VCPU BO pinned.
>>>>> The VCPU BO needs to stay at the same location before and after
>>>>> sleep/resume because the FW code is not relocatable once it's
>>>>> started.
>>>>>
>>>>> Unfortunately this is not enough to make VCE suspend work when
>>>>> there are encoding sessions active, so don't allow that yet.
>>>>
>>>> The question if this is the right approach or not can only Leo
>>>> and
>>>> Ruijing answer.
>>>>
>>>> If we can get VCE1-3 to keep session working after suspend/resume
>>>> we
>>>> should make this change otherwise we should rather make all old
>>>> sessions invalid after suspend/resume and only re-load the FW.
>>>>
>>>> Anyway I think you should make the removal of
>>>> "amdgpu_bo_kmap(adev-
>>>>> vce.vcpu_bo, &cpu_addr);" a separate patch, cause that seems to
>>>>> be a
>>>> good cleanup no matter what.
>>>>
>>>
>>> This change is necessary for the VCE1 code when it loads the
>>> firmware
>>> signature. Without this patch, we would need to call reserve(),
>>> kmap(),
>>> kunmap(), kunreserve() in vce_v1_0_load_fw_signature().
>>>
>>> Let me know which approach you prefer.
>>
>> In this case definately make removal of amdgpu_bo_kmap(adev-
>>> vce.vcpu_bo, &cpu_addr) a separate patch.
> 
> Sorry, can you clarify what you mean?
> Should I just go back to the way things were on the first version of
> the series, and then clean it up later?

Just add a patch (early in the series, probably as first patch) to remove amdgpu_bo_kmap(adev-> vce.vcpu_bo, &cpu_addr).

Then put the memset_io() into amdgpu_vce_resume() like you had in the first series of the patch so that VCE1 behaves the same as VCE2-3.

And when the series has landed we can clean everything up depending on what Leo/Ruijing has decided to do with suspend/resume on VCE1-3.

Regards,
Christian.

> 
>>
>> I want to get initial VCE1 working and landed independent of what
>> Leo/Ruijing say to suspend/resume.
> 
> Agreed.
> 
>>
>> Can be that suspend/resume is then still broken, but that is also the
>> case for VCE2-3 then.
> 
> Yes, some extra work is going to be needed on top of this patch to make
> suspend/resume work (if it's possible at all).
> 
>>
>>
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 44 ++++++++---------
>>>>> ----
>>>>>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 52 ++++-------------
>>>>> ----
>>>>> ----
>>>>>  2 files changed, 24 insertions(+), 72 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>> index 2297608c5191..4beec5b56c4f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>> @@ -206,6 +206,10 @@ int amdgpu_vce_sw_init(struct
>>>>> amdgpu_device
>>>>> *adev, unsigned long size)
>>>>>  	if (!adev->vce.fw)
>>>>>  		return -ENOENT;
>>>>>  
>>>>> +	adev->vce.saved_bo = kvmalloc(size, GFP_KERNEL);
>>>>> +	if (!adev->vce.saved_bo)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>>  	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>>>>>  				    AMDGPU_GEM_DOMAIN_VRAM |
>>>>>  				    AMDGPU_GEM_DOMAIN_GTT,
>>>>> @@ -254,6 +258,9 @@ int amdgpu_vce_sw_fini(struct amdgpu_device
>>>>> *adev)
>>>>>  	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev-
>>>>>> vce.gpu_addr,
>>>>>  		(void **)&adev->vce.cpu_addr);
>>>>>  
>>>>> +	kvfree(adev->vce.saved_bo);
>>>>> +	adev->vce.saved_bo = NULL;
>>>>> +
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> @@ -290,13 +297,19 @@ int amdgpu_vce_entity_init(struct
>>>>> amdgpu_device *adev, struct amdgpu_ring *ring)
>>>>>   */
>>>>>  int amdgpu_vce_suspend(struct amdgpu_device *adev)
>>>>>  {
>>>>> -	int i;
>>>>> +	int i, idx;
>>>>>  
>>>>>  	cancel_delayed_work_sync(&adev->vce.idle_work);
>>>>>  
>>>>>  	if (adev->vce.vcpu_bo == NULL)
>>>>>  		return 0;
>>>>>  
>>>>> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>> +		memcpy_fromio(adev->vce.saved_bo, adev-
>>>>>> vce.cpu_addr,
>>>>> +			      amdgpu_bo_size(adev-
>>>>>> vce.vcpu_bo));
>>>>> +		drm_dev_exit(idx);
>>>>> +	}
>>>>> +
>>>>>  	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
>>>>>  		if (atomic_read(&adev->vce.handles[i]))
>>>>>  			break;
>>>>> @@ -316,40 +329,17 @@ int amdgpu_vce_suspend(struct
>>>>> amdgpu_device
>>>>> *adev)
>>>>>   */
>>>>>  int amdgpu_vce_resume(struct amdgpu_device *adev)
>>>>>  {
>>>>> -	void *cpu_addr;
>>>>> -	const struct common_firmware_header *hdr;
>>>>> -	unsigned int offset;
>>>>> -	int r, idx;
>>>>> +	int idx;
>>>>>  
>>>>>  	if (adev->vce.vcpu_bo == NULL)
>>>>>  		return -EINVAL;
>>>>>  
>>>>> -	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
>>>>> -	if (r) {
>>>>> -		dev_err(adev->dev, "(%d) failed to reserve VCE
>>>>> bo\n", r);
>>>>> -		return r;
>>>>> -	}
>>>>> -
>>>>> -	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);
>>>>> -	if (r) {
>>>>> -		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
>>>>> -		dev_err(adev->dev, "(%d) VCE map failed\n",
>>>>> r);
>>>>> -		return r;
>>>>> -	}
>>>>> -
>>>>> -	hdr = (const struct common_firmware_header *)adev-
>>>>>> vce.fw-
>>>>>> data;
>>>>> -	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
>>>>> -
>>>>>  	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>> -		memcpy_toio(cpu_addr, adev->vce.fw->data +
>>>>> offset,
>>>>> -			    adev->vce.fw->size - offset);
>>>>> +		memcpy_toio(adev->vce.cpu_addr, adev-
>>>>>> vce.saved_bo,
>>>>> +			    amdgpu_bo_size(adev-
>>>>>> vce.vcpu_bo));
>>>>>  		drm_dev_exit(idx);
>>>>>  	}
>>>>>  
>>>>> -	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
>>>>> -
>>>>> -	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
>>>>> -
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>> index 2d64002bed61..21b6656b2f41 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>> @@ -448,14 +448,8 @@ static int vce_v4_0_sw_init(struct
>>>>> amdgpu_ip_block *ip_block)
>>>>>  		return r;
>>>>>  
>>>>>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>>>>> -		const struct common_firmware_header *hdr;
>>>>> -		unsigned size = amdgpu_bo_size(adev-
>>>>>> vce.vcpu_bo);
>>>>> -
>>>>> -		adev->vce.saved_bo = kvmalloc(size,
>>>>> GFP_KERNEL);
>>>>> -		if (!adev->vce.saved_bo)
>>>>> -			return -ENOMEM;
>>>>> -
>>>>> -		hdr = (const struct common_firmware_header
>>>>> *)adev-
>>>>>> vce.fw->data;
>>>>> +		const struct common_firmware_header *hdr =
>>>>> +			(const struct common_firmware_header
>>>>> *)adev->vce.fw->data;
>>>>>  		adev-
>>>>>> firmware.ucode[AMDGPU_UCODE_ID_VCE].ucode_id
>>>>> = AMDGPU_UCODE_ID_VCE;
>>>>>  		adev->firmware.ucode[AMDGPU_UCODE_ID_VCE].fw =
>>>>> adev->vce.fw;
>>>>>  		adev->firmware.fw_size +=
>>>>> @@ -506,11 +500,6 @@ static int vce_v4_0_sw_fini(struct
>>>>> amdgpu_ip_block *ip_block)
>>>>>  	/* free MM table */
>>>>>  	amdgpu_virt_free_mm_table(adev);
>>>>>  
>>>>> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>>>>> -		kvfree(adev->vce.saved_bo);
>>>>> -		adev->vce.saved_bo = NULL;
>>>>> -	}
>>>>> -
>>>>>  	r = amdgpu_vce_suspend(adev);
>>>>>  	if (r)
>>>>>  		return r;
>>>>> @@ -561,20 +550,7 @@ static int vce_v4_0_hw_fini(struct
>>>>> amdgpu_ip_block *ip_block)
>>>>>  static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>>>>>  {
>>>>>  	struct amdgpu_device *adev = ip_block->adev;
>>>>> -	int r, idx;
>>>>> -
>>>>> -	if (adev->vce.vcpu_bo == NULL)
>>>>> -		return 0;
>>>>> -
>>>>> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>> -		if (adev->firmware.load_type ==
>>>>> AMDGPU_FW_LOAD_PSP) {
>>>>> -			unsigned size = amdgpu_bo_size(adev-
>>>>>> vce.vcpu_bo);
>>>>> -			void *ptr = adev->vce.cpu_addr;
>>>>> -
>>>>> -			memcpy_fromio(adev->vce.saved_bo, ptr,
>>>>> size);
>>>>> -		}
>>>>> -		drm_dev_exit(idx);
>>>>> -	}
>>>>> +	int r;
>>>>>  
>>>>>  	/*
>>>>>  	 * Proper cleanups before halting the HW engine:
>>>>> @@ -609,25 +585,11 @@ static int vce_v4_0_suspend(struct
>>>>> amdgpu_ip_block *ip_block)
>>>>>  static int vce_v4_0_resume(struct amdgpu_ip_block *ip_block)
>>>>>  {
>>>>>  	struct amdgpu_device *adev = ip_block->adev;
>>>>> -	int r, idx;
>>>>> -
>>>>> -	if (adev->vce.vcpu_bo == NULL)
>>>>> -		return -EINVAL;
>>>>> -
>>>>> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>>>>> -
>>>>> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>> -			unsigned size = amdgpu_bo_size(adev-
>>>>>> vce.vcpu_bo);
>>>>> -			void *ptr = adev->vce.cpu_addr;
>>>>> +	int r;
>>>>>  
>>>>> -			memcpy_toio(ptr, adev->vce.saved_bo,
>>>>> size);
>>>>> -			drm_dev_exit(idx);
>>>>> -		}
>>>>> -	} else {
>>>>> -		r = amdgpu_vce_resume(adev);
>>>>> -		if (r)
>>>>> -			return r;
>>>>> -	}
>>>>> +	r = amdgpu_vce_resume(adev);
>>>>> +	if (r)
>>>>> +		return r;
>>>>>  
>>>>>  	return vce_v4_0_hw_init(ip_block);
>>>>>  }


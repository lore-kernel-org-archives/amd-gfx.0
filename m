Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06817CCF2DF
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 10:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B9310E05A;
	Mon, 19 Jan 2026 10:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xye7+Qh7";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC0BC10E05A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 10:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWA04p64u9oNvyZySJfajT5p0xvkFcXDid7y1ETLMZbjJ7x9jqaCP1k7X3fJuiiUJRsnnejPMAh0tcwSdz/0M154EmRhguG2lezlwvWFuLKNZKn9VIr9mT1yhBKvZTeOfDj7pynDycnocvrs/8HmASiXuKopT6lZD+NRClSC9indWTRH+xfSNRDt4x9GjJ+UwSgMWYP8seJ7FqbShMtMdRVz9n9qOJl52HVsF9DPEwBCTr45+bb+jo3cINNDUNGBG05DZ6PU0UWdcKkpqg0b3CvtR0dqpvJD5IWfRXC1c1hP8bLDfqJgcxg6rmC4JZA/XucSc+e6b1Hr8UNjP+Zt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKNJ3OJiY12LC7O4EqqVallE6Bf4VPCyZqOTNxXPpcA=;
 b=jRlUIyTLMA1hFintkdGJT6ZYpZQJ/4T3Q0/VoKOULwMUTMBvJGH1LimRErjK5gsX8isOL4fmo4+5vSsEm5lRKCTafqdsbX8ADpNmZKber5Owk8qV5YO1tVHsmh2OsL+Ce0khZ/pelKwrIaDpb3g6jIq0giA+ipEy+Kb5jJFb473cYaLmpoKmLDTu4VkgTc1+s6UBzwerHO9r4gaS4u76Yk3ok8bGBywDsgztINVoJhkcYWdpTNulYPv/oqYde0GeW1DSz/slE2adhIZJ92/PwWKNMP7ZjAjQ1Q4MWByLa+X6kyCyRj2P4uvdRaWTxeVThFovPe9v333tOJTiVF8q2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKNJ3OJiY12LC7O4EqqVallE6Bf4VPCyZqOTNxXPpcA=;
 b=xye7+Qh7c+npT5tnBIZz7zrpZeSS9fQG9hENrfSF5b24qMdj8UHJYGh1DQrwfrj0MEgWLAWrx0bxmFmsmq+s7zgk6Bg5ChK+yc+aGAn+PZ5GJ4ipFu/5gCwqY3SnvHfB9MbALx8SuYy0/+ZwwYFjTfX4KNssi4coCpyR5ndprc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 10:45:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:45:50 +0000
Message-ID: <434e6332-2520-4ed7-9dea-8f5118dbb02e@amd.com>
Date: Mon, 19 Jan 2026 11:45:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdgpu: Avoid unnecessary Call Traces in
 amdgpu_irq_put()
To: Tiezhu Yang <yangtiezhu@loongson.cn>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alan Liu <haoping.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260115012830.31182-1-yangtiezhu@loongson.cn>
 <6ac02ffa-5d62-4fc7-9882-6ccf7b44eaf4@amd.com>
 <0afdb83a-d2db-53d9-3b1b-253e466a5cc3@loongson.cn>
 <1673a119-838f-455e-88fb-528bbd72e1ea@amd.com>
 <1a0dab04-cb13-9307-2853-38221193e38e@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1a0dab04-cb13-9307-2853-38221193e38e@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8440440e-9b49-42c0-2ac4-08de5747e96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlRUNkp1c0ZZdWZsaXYzbjFDb2FORUJ1ME1oSlpJaUdiTnduMW1YaVA4N2Za?=
 =?utf-8?B?RW9kbTh3bXlJVFhUZjBZM1dKb3RSZW5vY0owTE9GZTZwMEtoSHlRVm16S3Q1?=
 =?utf-8?B?cE9hdUdXaGUrQlZzYnpmMnNZZ0srYUM5YnRHbkZkaG52andzQjdYTXU4ZXRO?=
 =?utf-8?B?V3dWcWh6cFhVTVRxTlNoekVWang3b3JITC9aamxSVk5scS9Hb3lPK1ZXRy9Z?=
 =?utf-8?B?aDg2cVY3SkJLcVV2ajRwTm5qblJPREdmY1hxWW9mR0hBc3FwbGFuZVlyV3VU?=
 =?utf-8?B?ZUJvR1JtcFJJK2xvWVN3RTZOTFZTL2xjK2lrK0FldUNUWjh4a0Fsak9xbDNr?=
 =?utf-8?B?S3QxK05nc0JQdXRtbnByYkZRMlFncGFjZGNvMkZHZHc0S3hrL3R3L205STF4?=
 =?utf-8?B?QUI2RXFLN2xuSXBXRVd6VWNXMTI1TlR1eFdkVDNBdnBKZEhsZjg4VkxVUTVy?=
 =?utf-8?B?WnZOWlRUMnAzakJERDFhdEVZZ1lwdkozdlF1Q2ZsbjNvd0IwYXU2cFNRQXZV?=
 =?utf-8?B?bnVHb1RBVHlXTExrSUxIdmlEMWVQc1IrdWhqZUkxYkQzN2FaaFlicjBQdXN6?=
 =?utf-8?B?WHc3djVXTmtzWHpuQjkzL29ZeTlvQUhSRmpXdFZBR1g2YUV4L3dmL2lQeUFp?=
 =?utf-8?B?OFIzZG5qaEFwbWhoUjhQSlVWMWdqbGd3ZGJLRm10NTI5VFhPRE8va0kvM3lz?=
 =?utf-8?B?MFVqSXpiT202bEZvMkhFc2tWOXNGaUFDZjJvV2hQcGxUcnJnWmlJTlQ2bTFa?=
 =?utf-8?B?ZitxSVo4YkMwMDlqV2o4OGQ3WE4ramJ6NVhZL1VUTHFDS0NsU3RQV2ZIUWk4?=
 =?utf-8?B?QmpKT1l3QmRyNkMyZS85OU05VCtJOEFpaEcwY0tQM0hYSWJhMzY3R0FCQSt5?=
 =?utf-8?B?aVJ5OVJ1VnM2cjZsd1NnMm9tc3hhTG1ISlIyekFHaGtMZkdIOFFJZ0JlQk13?=
 =?utf-8?B?Y3EyM3FxK3RZcDRSOTREWkVmTUkwbnBOaDVWMEVqYk9tNTZtUG1CaG1udTVy?=
 =?utf-8?B?MzFUczR0MmlieWdnM0Y5WHM1SHdxSi9mcEpHd1ovd1NTWUZoMzkxemRxMEMv?=
 =?utf-8?B?ei9RUWxFcVljb1pjL1F3aUd5eUtkbmdVQnRjeGdjMmlEVGZvbTQ3SXI2QWxq?=
 =?utf-8?B?bkwwZ2E3NjBvc3U1WTdWZlpnRWdHUXJCaWdkSHQ3V2FTQXI3K3RmUWM3Y29i?=
 =?utf-8?B?NWVMM25GdlZZYS9SbFR1d0V0Zi9QVVg0cUhyUzhBVXV3Mk14dEJqRVpIQXpK?=
 =?utf-8?B?a0VtS3VaaUtyT3lZOEJyc29oa2lwakZJdExhVDVkU2hIdW5zWitlWUZwbGR4?=
 =?utf-8?B?VHJFS1FFRnY5QUxua2ZBMzZIWDNic2NvbXVNRHZqQTdsdThOSVNqSmFjNWZX?=
 =?utf-8?B?UlZaNlV3eXFjcGNJc1R2NXhuM25SaXpzNEhuaStuV01ZV1lIUUhTTGhhdE1Y?=
 =?utf-8?B?eERnOW1wL3FUQzA0Y2trc3RhSW5naXBUYzZVWDFiQk5VTkptV1p1TXFoWUYy?=
 =?utf-8?B?MmdnUVpiNG10U0YyL09wMFFEbTVmSWlSV1N6MHdEUWtHQ1BvVUJUTHh3RUNt?=
 =?utf-8?B?M1BIbWl5UHg0VVQxZHNUeUxCVzAySi9mWUdpM1I2TnV4aVBpUENiT1h4R25y?=
 =?utf-8?B?TkNmZXNsMzB6UDZtNmR4OVhUZzM2QVZHZGNMcWhkTXB1OVZUOWd6WSttdktF?=
 =?utf-8?B?bTNFOEViNExJNU1GRlhwaWg0UHAwbWs5eG5zTnhRazB4QTVZQmo4UDlPRmFZ?=
 =?utf-8?B?S2Y1QVk0dFJXdXdZRkwveEFIOFY4M1FxaVI2RzRXa3hwOEFIWFBHTVNCMFlk?=
 =?utf-8?B?MzM5NzJxN3J6NmNNT0NSMjVPcFdtcFpqamlsamIzWHpMN1JkQ3MvWkV5S2xP?=
 =?utf-8?B?MVZGcTk2UHNCVkhpY092L1IzY01Bd3lDckdpdmlRZzFPZ29aSGo4dVRxQklB?=
 =?utf-8?B?MFdHZktLa2tveStSRnFwcy9GVWFUb3hXazIrY1NHNmJiZ3Q0ajhjMktaYm85?=
 =?utf-8?B?Q1E4VUo3TkdZR3pQT0VTRGtIQ1ZpeU5uWjRlRlJPdklhMUZqUlRSczlRbkRh?=
 =?utf-8?B?RmIvZXpnVGtuSUJlU1ZGUFNQU1pxT003bVlTK3UvZDd3SUlKcTZMWVArWFkx?=
 =?utf-8?Q?dEug=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdYbW9LbEVyd2hlN0Y0MVVwMTMyQk0rTjN1NmhGMGZBWmxjRUpsN2pjeTht?=
 =?utf-8?B?a2dycU9EYk1OVUtXdTNkYXdpUzVLVHZkQW91enI2U05GaWZJV2ZSU0NKMXhw?=
 =?utf-8?B?d3UwTithaENPcFZmRzZmMDRpaGZ4akRJbndNdlgwV3U5UXBzNkI3V0hVMk5i?=
 =?utf-8?B?elNKbUlOV2FGQkxxTFFhV1BJTFVjZERYMGZTaEg0Vlo2TWxCcE1EOFFFVkxZ?=
 =?utf-8?B?VGRlQU9aMUhYVDJCcU45ZnJRR0JScG1zWGU4Z01MVTR5aVJoeFZ4OHdCSUhB?=
 =?utf-8?B?cVhIRU5CdDZNb1ZsRkRoYWYwSGpUcjZqb2VKSWROKzlqSXRYU29YY3g3MndY?=
 =?utf-8?B?S2ZReGZodUoxc1M2Zm1Ma3dCUlA1TERRdWhhRnVJbzJZcVM5ckRCTnAwVXpw?=
 =?utf-8?B?TmRzcWJtcDQ4MU5OaFgyM0l0Nnl4R3NsSVZoTWNmazJrZGxoNTBQandsUHds?=
 =?utf-8?B?YWwzUFdxSzVpOU85QTFBaFZQS2VhNVBhZGtVRFBDNytROG5YOVptRFNNN05N?=
 =?utf-8?B?bWNJajZaQU40bXJWUUdaWGgrWVZndUJEU0pUK05UdG5FeVVrY0NrcUhka2RC?=
 =?utf-8?B?dHBnRzdVVGI1ZjJyMmhKYXEzMEJvTVY5TE9uUVgyTStRWUxQSGNKZUZmVGEx?=
 =?utf-8?B?NmFiTVNYdTR5c2MrZnlHOFIwaklpbENhTENkSWJzTVdrZUEyZUtpK2pwK0Jn?=
 =?utf-8?B?R2h2MUpHL2dYa1pDZzZVNWpXM1VRblNNQ0x5SWc2dFA5ZS9GdSt3cGw5eExU?=
 =?utf-8?B?aUFMMmVUSGxVRXZlOHpiMllDSk9ZVFRVYjdGb01DQXdEYTVzeWpZV3Zja3d6?=
 =?utf-8?B?aWRLdzJQSEtqYXNTT05HN1U2MVpLTkVVVEVvUGpQVHlWeUIrS2JGUmpmUzVV?=
 =?utf-8?B?Um4xeENZTjlTby83cVE1bE9tdXVyUHVMaTBOZFZiZTdnUVlOQlkyRklJZW1H?=
 =?utf-8?B?b1lqa0g3UUdBSlVJS05jWi9wZlBSQk5qY3BKa05wMGk2MGNjV0M0dG1uam9L?=
 =?utf-8?B?OXU3VURsQzRQeEh6M2liZmVyVEw2UjlxNXRSOWE2ZDBRUlNJWjZyd3lhZHJS?=
 =?utf-8?B?cW9QVm13cWJtWHhqVWlUUXc1SDNYOU42WnJvbzMvUnJwSW8wclJESG90bm02?=
 =?utf-8?B?Y0tJMlZkLzl6am1LbEY2ZDdpNGdHc2tXRVVSYkxESTRHbi93SW9qemhqNmV4?=
 =?utf-8?B?NUhMeGVscHFpa2dhMGZoRkoxV01lcDVQT0UxMlNTRFgzOENSYWtWTEtNMFhH?=
 =?utf-8?B?ai9TREJoQStzaEIrTFRpbkNmWVdod1JFVjBPenZtSlA4TEZYV3hxdFNmaWNK?=
 =?utf-8?B?V09xVmtpdTVOdFdsMFRJSDI4QjhNVWhGVE4vODlZRXFycVRRUHlSUUJQWkNk?=
 =?utf-8?B?YldOOUFTQThPZk1mOUJQY2g4ekNxd1RXMXJoZEFTTzJEa2VtcHlzRGloSElk?=
 =?utf-8?B?N3U2SFdUNVJLRzRESFJpNmJma1lITDM2UFlUNUFDUStnd2gvUXp5c2tkaSt2?=
 =?utf-8?B?V20rZTJ5OW4ySklNaHdoK2cvWUFxYkdMVE9Ramt5SkxDTXBDRnE2Zkg0UTYr?=
 =?utf-8?B?dXlGcXd2MnlXNFMwdC9yc2xBMmFVUjN0WElEK0lRbkVtdGhpb0tkR00zNHN5?=
 =?utf-8?B?WlhGcEp5WldEQ1B4Q1BWVGpJbEFDd1c5bWszUk1nM2x3Y2ZBMFcrYUNqcXJ5?=
 =?utf-8?B?R0k5T2g1Z3RLTnJIcFlOWkV6eGdWM0FacjhmT1NaQmtSQlJZVkl5ZXpUWThk?=
 =?utf-8?B?UHpjdWVlUXNzVVllWVZVLzljV0NTdFZFdjZtZmpOMHhiem82WUhvYmlick9R?=
 =?utf-8?B?aDQyMzJ5QzBCa0FTLy83cnFNbUJvdFIwQXZINTVERU9sQ0tYRnY5SVpyS1lZ?=
 =?utf-8?B?OFdzUnZYOUkrRm1TVEtRY0RRQ1FLZ09lSkZEbERMMlV0WjZaUERpWWdzOC9p?=
 =?utf-8?B?VkZldlZFSjExNGFqV1RZQTlkNUNCejBMNlVWTGlVV3dZeXZNRko3b3ZweDNu?=
 =?utf-8?B?c0xPMmlEOXBmb1Vra1VQNU9JUEY2VjBTTVlhMEcyWFhEN0NHTm5Kc2FEUWI4?=
 =?utf-8?B?WDZkQTR1dEptMDFwMjZSYUllWW5PdTVHWW5FTExNZlRmNXRXYkVMalNwaGtU?=
 =?utf-8?B?NjRJSWFyOTM0SE5hc0ZLb3NKTkRicjZLeXE4T0dqTDRjRm16VHg3a045L2ds?=
 =?utf-8?B?blU3QUZ4U1N0dWZFWUJwSWF3Qnc0ekt6eU96TWFNNlJFZFd5SEQ0K3N6OEJq?=
 =?utf-8?B?T24xenNDOW0wdjQydmo0TmRlUjlZOHBuQTJKY2lTQnpyTXBubXVxMmtndDd1?=
 =?utf-8?Q?UVSFrAu4/yVUmFusMV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8440440e-9b49-42c0-2ac4-08de5747e96f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:45:50.5625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkbbEn6jXyrt9ZPUSsj9W/N0ppCWtK4T7Io8z8JFHzw3XE+JWNycAsGNy1ohA9bG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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

On 1/19/26 09:53, Tiezhu Yang wrote:
> On 2026/1/16 下午6:03, Christian König wrote:
>> On 1/16/26 02:20, Tiezhu Yang wrote:
>>> On 2026/1/15 下午9:47, Christian König wrote:
>>>> On 1/15/26 02:28, Tiezhu Yang wrote:
>>>>> Currently, there are many Call Traces when booting kernel on LoongArch,
>>>>> here are the trimmed kernel log messages:
>>>>>
>>>>>     amdgpu 0000:07:00.0: amdgpu: hw_init of IP block <gfx_v6_0> failed -110
>>>>>     amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_init failed
>>>>>     amdgpu 0000:07:00.0: amdgpu: Fatal error during GPU init
>>>>>     amdgpu 0000:07:00.0: amdgpu: amdgpu: finishing device.
>>>>>     ------------[ cut here ]------------
>>>>>     WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 at amdgpu_irq_put+0xb0/0x140 [amdgpu], CPU#0: kworker/0:0/9
>>>>>     ...
>>>>>     Call Trace:
> 
> ...
> 
>> The warning can basically only be triggered by two conditions:
>> 1. A fatal problem while loading the driver and the error handling is not 100% clean.
>> 2. A driver coding error.
>>
>> And we really need to catch all of those, so there is no real rational to limit the warning.
>>
>> I mean when you run into any of those they should potentially be fixed at some point.
> 
> I did the following change and it can fix the problem, given that I am
> not familiar with amdgpu driver, could you please check it? If it is OK,
> I will send a formal patch later.
> 
> ----->8-----
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 8112ffc85995..ac19565e7c45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -138,6 +138,9 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
>                         if (!src || !src->funcs->set || !src->num_types)
>                                 continue;
> 
> +                       kfree(src->enabled_types);
> +                       src->enabled_types = NULL;
> +

Mhm, I need to double check that but that looks like not such a bad idea of hand.

Christian.

>                         for (k = 0; k < src->num_types; ++k) {
>                                 r = src->funcs->set(adev, src, k,
> 
> AMDGPU_IRQ_STATE_DISABLE);
> 
> Thanks,
> Tiezhu
> 


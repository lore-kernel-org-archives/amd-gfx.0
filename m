Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A28CAC5B0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 12:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9293F10E235;
	Wed, 24 Sep 2025 12:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UCqoHQfr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DB410E71D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 12:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uONRHpuFHuS/9q3F7wC+bn+HKi+0YFI8oplODbqbDrcIpE0zy12QUJhatWKJraqeqT2/pom62pgS2XYRc1TVZzP0jCPVKn5KG6QoKQAxl/w5oI0I5rpAanUUzakhxrrxJPAPf2Y0kEWcmpq6P1vu2yV7LGmYaMDMGL5ue7DpsRFsZL+n6pB6UcLeRPAXhLTmXDwlujiKta2vhU+2PNChyIMrM76eB5ITgF514GFBpMCfR/DFepemXFH3pvn/6fQvTf5KagQgLDKMKwXXQhtt4FaIKbWTuRyvKIQ8Ehg7j18H8qLoAiZWPb/X1A+NRmLM588SS+LI+gCfBlH0cHJdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYZmhCteeqORwu3OIi31UyxJL3ETYPQ42p/+o5uJWKs=;
 b=pJ1unVZZJlQklJHT28efNuXEzyN6wf7eyIQ0J0MkrgMvF1KR1TduX65+QxwV+Da+VlmwR3DkRRdRgilkGz0WE4Kt+y2IAbk2s8qaSR0zDFDsIvstE284fNEdZC31MyeXj7iyXAk/fO3cmi6do3lPJvs5V5Khx/Mz7Un70K4enXLxcL1LNlCR3BUZwkzmhIeQhyfgmg8yHuOut0+pLfBnv+ld1vC39g8yYLrsrWrIMa3T/M9Y+IjHd1h0SDx1adT5ouu9EooadX7pYzSZ7t9WHox2Ah3T56Vp/H4i74RY7QDYkc3qMNwRaXs7aU/vQugEqch2qvADqYUkxk7HI9hcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYZmhCteeqORwu3OIi31UyxJL3ETYPQ42p/+o5uJWKs=;
 b=UCqoHQfrFhyMS74CyxQTLjcneq8J0YliUWaQHOhOxKw0UA0N1zvjESi0CSpPz+QtQ2Mi5peMxS4lo03cFrD+XBRGnRBo7SfpLi/i6F4gWcWk+Zm7I9L6sw0wTEQue3hDFuudNLmoz7nJSCFYBQJDmd1pWebabZkD941Zwcw+cA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 12:10:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 12:10:02 +0000
Message-ID: <9c78383a-d32c-43f7-8a91-dc01690d0a51@amd.com>
Date: Wed, 24 Sep 2025 14:09:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/2] drm/amdgpu: move variable declaration to top of
 amdgpu_cs_parser_bos
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250924100156.3746229-1-sunil.khatri@amd.com>
 <20250924100156.3746229-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250924100156.3746229-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:207:3d::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 4178bd14-03da-4c7f-3590-08ddfb634a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUhILzNiMWJNalUyTXY0ZUFuc3J3TnFRdTAzSU1lZkhjcjVGamN1azl5YzRr?=
 =?utf-8?B?bkMwdlJtY3ZnRWI0dEZoT29Bd2RSMEhOQlJZVW9IbXNOclJHMEZXRk45dzRU?=
 =?utf-8?B?eVUrTUVxV3JwWGQ5Z3ZDbUdwblh0azhYMkZ1VVNoKzFmaEN6NFhxZmNUc0J4?=
 =?utf-8?B?SEVObVp0WFBIbGIzTWlPRkxlYmxVNWNwd0trYUU3bEp3WUtrc1RSSDh1Q3Jz?=
 =?utf-8?B?Ty9uQXdhUEFYNmpzaC9oNXF0eEQzd05JWFdPS21QZVQvWUUzeWlmRmZqT0pw?=
 =?utf-8?B?MDJGd1BQRFZSVFl3MDI1NVRyVlJiZ28rTFZveGFQWTJ5WXRqTEdLdkJSZDk2?=
 =?utf-8?B?ZVludU15QlhWZG1CZ0VEbytoL1FlZy9TM2VydDNZOGpvaXUya216WTdwWDZh?=
 =?utf-8?B?MzhRMHNGRWlQTWQySHI4ZEsxZGhabGJMNnF5SlY0WVhZZHRkZStFUG5IamRG?=
 =?utf-8?B?OTNhSUh3Z1BsaWM2eUt1NGhpa3R6OWx0ek5jRlFTczVMMVF2akxyRSt4NHlt?=
 =?utf-8?B?S1c4RXVjM3pMRzFIOFc3Mi9yTzc4QWl1eXdqenlxQnQwRUhta3U4R3p3L3ht?=
 =?utf-8?B?RUx1Y2hLT0RRY2FKTmNLMm5CVkNld1lxSEZxZko1QkQ4QVJ4UktaWG1PL1VB?=
 =?utf-8?B?Q2pkYStqN0gyaUV6WkxVeDdhSFRoRThCZzU4MmlYR2ZEZ1I0QlJzeGpMSk9T?=
 =?utf-8?B?UXhvb3JKbU52NVQ2Tkh2UjVteFovYW9nTkhTSnFUZlNsRHMyM1Bac0ZsUmxa?=
 =?utf-8?B?Z01zMjM0Z3c2R0x1T0FVU3ZMYWEyTFIzQndkNlc2Y29WakRoUzIzMXpiamJm?=
 =?utf-8?B?c1ZnajRPanZFdERzYWNYSFZYRnVUZldQSWIrRFg3OFZTaDl3TXVsQjNCV1lY?=
 =?utf-8?B?WEdMNDh0WG42T0VIRDJPdFovOE1jMjVnUExIMkVDaG9DbTM2dXJTa2hkTDBj?=
 =?utf-8?B?WmJab1N0a2xoSFRyRTdGTGF2ejN5WVVxSXk0SzdkdEwvRWZ5RkdMSnJjZFpG?=
 =?utf-8?B?TjAwTldwRlluRGZhdjI5eXkyeGlzN3hBYWJvN0I2Y0EvV1loWW1SVVc1dmNV?=
 =?utf-8?B?dGRtU1FIdGNpRzJVdEt2UVMwa2tQZElFRExaQk4zalBmUWhyQ1NLSE9uZkt6?=
 =?utf-8?B?TFpzK21rWGxIY1hQSEZZUTkrTXhsMDlUcC9tbUlKSjlvWDJoamZPNm5VUys5?=
 =?utf-8?B?K1NtUnQ4em1RQk85eVBkeGZiWUNGcm1ncmIzTnpHUU1Fb0hjd3ZMa1EySkla?=
 =?utf-8?B?ckZzOXE0akFUZXhXU1h4ZjlGMEdQc1M0clVFRHlEaTBmS2xkR0F6a2VheFFW?=
 =?utf-8?B?TTdab0MxNW0xeENwYnZhWGxJcXZyb295TENQa3JpWndGbTJjWFBFRXhGQTVa?=
 =?utf-8?B?U0FHaFpyK05wZUQwbDUzbEROM3g4SkYvaWxXQlVleUxzOXdIOGhPbk96aXZT?=
 =?utf-8?B?a2tQL3U4eUtkUCtSZm5QYkZBKzdwc1p5Ym5hTXgvRDM3UGx1dTNLdkQ0UkZQ?=
 =?utf-8?B?UEl1YWxlYW9sS2I0ZjYwTk42UGhhZUw1RUxrSGV4cU96WDJVNUtOZUdmeVRv?=
 =?utf-8?B?U0dOdS9uZ25KT3VVc2d6VGloempZTW1sMmNNSmRGMDRwd3pHMUlLc3Z4dFhK?=
 =?utf-8?B?cjNZVVk2TDVXTXNxZitwVW1DZHRHWktHNWtqckkwdjBsUWVjcUlxaDZScGlJ?=
 =?utf-8?B?aDlaUkhibHZGRGxzeFdHS1MzTytQS2ltREpwaUdtNExrL2JEN3A2Qyt6WjhP?=
 =?utf-8?B?aHAxcFQ0UDJzd0FxUVZZbGhyWDlwZjNIYVRlc3AwSzhTdWVYVE9Xd1hNRGs2?=
 =?utf-8?B?N1JIekpzREtyTUNMWEZJREllcVYxTjRlRGUvSW51dk1LSGIvRTNyb204TmhK?=
 =?utf-8?B?MVFlUnFhUEpKc2VFL3h0L1NWTit1VCtSNER3R3BIUGtodmZ5UXJIbyt3S1Er?=
 =?utf-8?Q?hgXydvyJ6gU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjBkdFBzMFhLNEx3aXRYYXdlaDNpcXlTZ1FjZzlQR3BFQytnUVUzUjdPRmpr?=
 =?utf-8?B?NzZOK3hkVEJnNXNvemZERzBiVFlxL0JEN0phM2pYSHZHM3RPRFd4Q1E3SWdh?=
 =?utf-8?B?S0g2M1k0L1BoQlpDV3Fram1ZbFBISXQvK215NVVDc3Z6dk1zUi83Q2pIbDhn?=
 =?utf-8?B?ZGpMYlhPaTVGcnpVcFFueHJTaFd6dEtuTk53WEZyUkpYMkFyWGdvVFRKWFR5?=
 =?utf-8?B?Z3g1OE5LaWNiTksyUjNvR2JJRHE1M1cxMXlRUjhuSTlCaDBHL1kxLyttazI0?=
 =?utf-8?B?ZzlsbHFxbXdNSERXcmd6aVFPemxvN0dzZEFQcXpxVTB6am5xRVNEdVQycnhP?=
 =?utf-8?B?VTV2OXN3cDJqTE9NUUQ1QStWdy9JbWJtSVNkMk96OWdnSTdNRVdrcXJJcjZh?=
 =?utf-8?B?RzA1UnJDaWw3VkNRWmhacHFiZjk0VFQ0aFJ0UTB3QzRtZGxYVmhHSWYwdXNy?=
 =?utf-8?B?NHFSZ3U2RTlLMlZuT3V3blFMdVd5QU9EUGRmTk1NdEdMM085MTUxNTBSNGM5?=
 =?utf-8?B?WVAxby96TlRHVHUvYUd3cm5JUlFrZk85eGJMN0o5UVp2c3NmbnJNZ29yb2d3?=
 =?utf-8?B?NTFJK09SN3dReHBCcjRCYy9lUnBLUFZUajc1ZmkzRnM1RGVwUS9MQ0RpekRM?=
 =?utf-8?B?K0YvQUhHYVB3cGpFTFp0dnp4UTBNYXl3aU9kbmhFQUlTUi9tWGN2UDgvREcy?=
 =?utf-8?B?ajk2alduYi9CYW1KUHRDZTlzY3M0bWlmU3FzMWNueUhEWll5cmp2bzA0dG5G?=
 =?utf-8?B?VFJnenpJRXhWYUg4R2pGd3J5VlliTG40b3ovU0pYak9SOXNrUnVVdEFnR2JN?=
 =?utf-8?B?cFYwUGVoSngyMHV2Y0VtdUtvRWs1OEZ2cW9GZERFR0dGY2ZsNkZGS1poa0pn?=
 =?utf-8?B?MGdVNXdxWmlPYTdTa2Y5c1pxVHY1N2U1akoyWHpVbEVHWGNzMmdVdUFrUk9k?=
 =?utf-8?B?TnJEZ2UwR1FTY2dSQzVYRGVvdjRsQ1IyM3M5MUNaS3VPYUxmZm9OT2xkR0RW?=
 =?utf-8?B?VTIydUd1d1h6L0tINE1sTy95aVZwdllBaHBPZ1RrYjVMVHBhTGdLZGRQcGN2?=
 =?utf-8?B?Y29BNWJ4eG5PUEFaR2w1ZmFKb0xGdnVmQ09KTDdPRzAydVFVT0hncXU0TUJv?=
 =?utf-8?B?bThXK0w4ajd0VXBFSmdNYUNlaFYrYVYwMS9rUSt1L1pKN1lERnZuV045WVRM?=
 =?utf-8?B?anYyT1NiNGZTMUcyYkh2ck1MWXVXejA5TUZ3T21kZE9NUXpxRkFJM05XOUpr?=
 =?utf-8?B?WXA3SEtlMmxKVzJRK2FPak5yTy9WbVR6OWlBSnMzSU1uUzRhM3FNT2wwSC9W?=
 =?utf-8?B?ZDJPczNWMFNEcGp3TzVJb0hheHZ1d2dRbm0zREhaUURua05ScC9pOXgzUnJo?=
 =?utf-8?B?ZU5xY3RHRU9pbENFZy9iaUFtRXIxeVVxa3ZQNlhhTzdpOFBzQjUxdWJxKzdL?=
 =?utf-8?B?RW50bVZvYXpMVEwwSVpBMTFtd3VlSHBiTnBWVlcvb2NKOEpOaWZSdzlUc3Vu?=
 =?utf-8?B?VUtQSndYYm5qRC9ZVExIUWN3b005Yml6Z3lXaGNHZmFhNG1YSDdQTDVsTVNB?=
 =?utf-8?B?ZnBkb1NlMWpGWlExUlI3TTZRKzJXcGFlUVh4OEVHOXhUR2kzZnh6eDE2dkNC?=
 =?utf-8?B?dkVpNUtPeXVxbmEybitVUjBCTjI2K0puZEk3Y1YxZUcwVmdPUjdaTEtoUTd4?=
 =?utf-8?B?cFMvdnNNQjFuVnlxeko5K09La1JzVmowWGtaT2xiUUxDUTdTbzJYL2JXejJs?=
 =?utf-8?B?SGhFbkE2Y2cxQklvTXRCaEJjV0pGTGtiMWp1YVZndlc4bzlRR0tneHBhaHFT?=
 =?utf-8?B?V3pCSlM5alZaS3M5NkVIQ0FKVlBFQnM5SjNjcWFVajdRTUZrOVpuaytuVzhx?=
 =?utf-8?B?ZCtqNUo0UGVabXoweXcxOE52akN2QWxyQUNOOW1XUGlqdlZFcGo5VWx0Q3Rr?=
 =?utf-8?B?WHBPamw1NVQwTjllYTdPcFJrN0FsK0doK1E5VlFQYlRxckJOQTZQZHRZdndr?=
 =?utf-8?B?L3kwTnEyRzVsY2RSeHZidy9vVXlMVy9jNzFMSGYxZGhFbnVITGxpc09KOWoz?=
 =?utf-8?B?ZUhCYS9wT3lzeWhCbGJzSUl4aXBpejRHZjA1ZkZGdko5bDB5SEpRTWg3Myts?=
 =?utf-8?Q?i3ujzqd1COfHUW+pgdy2k0wF6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4178bd14-03da-4c7f-3590-08ddfb634a8c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 12:10:02.9205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PWW6qr3seJgaq9HdXOFKkt4gRShQTcLYgRIPqf264wkCIZnvmW+K6klFh7uljEt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
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



On 24.09.25 12:01, Sunil Khatri wrote:
> In function amdgpu_cs_parser_bos, declare the variables in the beginning
> of the function and not during the initialization.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 31eea1c7dac3..a9bdc368c981 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -854,6 +854,9 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	struct amdgpu_vm *vm = &fpriv->vm;
>  	struct amdgpu_bo_list_entry *e;
>  	struct drm_gem_object *obj;
> +	struct amdgpu_bo *bo;
> +	struct mm_struct *usermm;
> +	bool userpage_invalidated;
>  	unsigned long index;
>  	unsigned int i;
>  	int r;
> @@ -882,14 +885,12 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	 * amdgpu_ttm_backend_bind() to flush and invalidate new pages
>  	 */
>  	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> -		bool userpage_invalidated = false;
> -		struct amdgpu_bo *bo = e->bo;
> +		userpage_invalidated = false;
> +		bo = e->bo;

Those can stay as they are. (Ok there should be an empty line between the declaration of variables and code).

>  		e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
>  		if (unlikely(!e->range))
>  			return -ENOMEM;
>  
> -		int i;
> -

But that here looks really fishy. It basically means that we have an "int it" declared in this block which overrides the "unsigned int i" declared.

Please make a patch just removing this "int it" here and feel free to just add my rb and push to amd-staging-drm-next.

I'm really wondering how the heck that happened?

Thanks,
Christian.


>  		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>  		if (r)
>  			goto out_free_user_pages;
> @@ -930,8 +931,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	}
>  
>  	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> -		struct mm_struct *usermm;
> -
>  		usermm = amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
>  		if (usermm && usermm != current->mm) {
>  			r = -EPERM;


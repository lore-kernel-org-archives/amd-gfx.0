Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DAFC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 18:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1011510FECB;
	Mon, 29 Apr 2024 18:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QJqiALqq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6BF10FE7A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 18:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2nZvEhdisXX1uu4d0SPzA86sfuAy7KMeMa5cnc3Jxw5e1RBomFhIPXZBSCb1gMr4CqPS/M9iaBeQo2iAl9N+7J2aigQ3QgFn6pX8lfDLMmTdCcZIRVF9DJovXC0E/p7oYPbY6K8yegn1Nt+ZN5iYl91JuibFv0zeNRT1bGuoEto8Rt8MuSGtINnl6rJ7vhVfUqUK5VSPDE2ioDqnz9emluOnLkIMAOxuP4dTvxWcqC4xnJS6tU3vJtAfZthzuNMHpGPlDL6xJXEUSoB6Et7jhELFqsZ/sJXHnT/Lj4VeOIJ6kBVl12oIow3sFJsW3RbuArf1Qrt/h2RO5lC6ygBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0i78q0X9hGXZTiAmAtPxHGSbzTlzwR80GwbtCsXneE=;
 b=LffQeXdVwEkf+uPxhE3b54WgkKE0jkFPCuIiwl9H/Hwh0tI//SuA9T5TexSRP6EooWE8H/mH06/Fv+ewzKoTwDhQe+muX1gj99aGryBjL/DZPRJapHmbjEEWnEr7J2sV2lsNe78ZPv3Danf/ezoIGCEm2IDlX6a6j8Yn2m9imNSrxT95UKwPTYdPSZt4OFUTH01pdXTf0M9VGgIPbgFBJuybn8/lLFv6SDa/5bLYmj+Hq/+sBnMaNVcVCw0nsqly+xKMsrDIF/0t5n9NKqmBAeFM5U6IQWa94AMbUNQKLrN7BOIYplNFxUlL12XSkTLPZAn0y6oCrv39ezWaJ7aP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0i78q0X9hGXZTiAmAtPxHGSbzTlzwR80GwbtCsXneE=;
 b=QJqiALqqeNQa4QIFe8WBuQtmisszrQ8K3eWqmCPaudS6jR0uCLE+j2vBLpG5qQsr65VPL4w1jg1H/0ledluGLsmGMjAibRLcqvKfIp+phNaJrJHGoZHoKoqysRnpWmWaJo8HFDAujCklmEUQx9UwpmgEU3tevHWt5vKUhxI9+4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 18:39:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 18:39:31 +0000
Message-ID: <88b36122-0f32-46a4-a5a9-9a29e25cf6d9@amd.com>
Date: Mon, 29 Apr 2024 14:39:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Allow memory oversubscription on small
 APUs
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
References: <20240426083750.485808-1-Lang.Yu@amd.com>
 <20240426083750.485808-2-Lang.Yu@amd.com>
 <53f958ca-3422-4ee8-9d07-228156d984bc@amd.com>
 <MW6PR12MB8898085860F60973EBB34A9FFB1B2@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <MW6PR12MB8898085860F60973EBB34A9FFB1B2@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d502525-7668-4f74-85a4-08dc687bb593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXdEdndoengyOXBmdW1ycUtxbTZYZGV2N3ludmJvRGhQWWE1ZzNjY2RrMmVw?=
 =?utf-8?B?M3hVRllwRVpHNUVOZTM3RW5UQ082aXp0QUdDQXYzY1pneGhtTmV2QVFlQjhW?=
 =?utf-8?B?NjhGaDlzNWU0S045aFJRQ1VUZ0tNS0NKazVlbmN4U3dMMXdnLzVYZGZsdS9P?=
 =?utf-8?B?YUJqcmlicWd3QVVScmVJalM5c3p1bHRPTWdUbUR6QVBxdmpMcFVNOUJPOThs?=
 =?utf-8?B?eWRqam9nTTRuK0Fmd2UwajhyOFNQVlRDNFNUSTk0NkMxU0dIMkRxMmR3Y0NK?=
 =?utf-8?B?R2VoeFFEYldOSzU0azEreTM1bW9iTE1aWncrbkZBVUVOdE5NMDdrb2hQMjVW?=
 =?utf-8?B?cE1OSlJmMnV0c1YrZktNdi9ELy9rQ3Q0YnRaTG13Y3N1bnhMM3RnajkvbWpB?=
 =?utf-8?B?cGJFQzVQWWVlOEV2eW1YcGQzV0RGMDJobHBKdXkwRTRHVzQwME5LYndpcjRN?=
 =?utf-8?B?cS9NcDRjY3NURGN5Mk1HbDJuRmdzMHBaTTVuLzFoSHo0OE1rY1Y2TVc3MXJH?=
 =?utf-8?B?OEFMcC9PbnQwY2FlTC9EdjRpZllGWC8yYVhqMktWZ1NxR3NxQlI1VHlxU3Jj?=
 =?utf-8?B?cVd6ZmNZanplY1dDN3ZPTUVPUndrSWNSTnFQV2JTYlNwbTQzbERjY016N20w?=
 =?utf-8?B?Y1FRMUZKQzlCTExPbUZUVTJkWlNUL0w3dk9QcnlSTERvMHBQSkNnSUExMWtR?=
 =?utf-8?B?UUJ1VEhGbjQ3U1FvU0lnb0txaDJ1Z3VxS1doQ2RsNnJpYkhpcDc1RDBUMTh2?=
 =?utf-8?B?UXRiTklSSXF2SEV1bW5mZmp5ZUNrWVRjbndZeUg0d1FSVTM0RW50UFZnNHFq?=
 =?utf-8?B?MFRCUXVESzNINW9jczJwL2N2c2MwT2tVZEVQOHdMMVhIYjBIZXhzWG8rdnJ3?=
 =?utf-8?B?SmxTZ1lDUnlML2hMZCt3ZUs1VmRCcWZ3cnFxTkpqWXhza0NPWU5PakZwNE12?=
 =?utf-8?B?cDZiQzR4VWQvVlUyU0k4cjJPZnh0aE5pYmxOSHozdzZHZktoWmFCTnVDVmNZ?=
 =?utf-8?B?Y2NZU292UFRjMUhMRlYxdWZrcUZvWW1hNEFxKzk1YVdQejQ4UDl0LzRGTjlD?=
 =?utf-8?B?eFdHQzJwN1dPZlJWRXA1SEVacTJERTVQZHNhOWU5dWdnUHIwK2M0NWJsaHlX?=
 =?utf-8?B?T0svRnpyOHRYM2RwWGZXc3FYbGRscXAxVHAwU1FaK0lvU0RZUld3d0RTQ2ow?=
 =?utf-8?B?UHRjLzVsN1BWU3VlRy80cVpQTHVHZ2twR2NXR1hEWWtGVG1VSXZ4MnhjMUx0?=
 =?utf-8?B?Y29Na1RKbkYwQi94Q29md25RcEttUE8vTTRMbHBKb1BQZTQ3WWNNaTIzVkFI?=
 =?utf-8?B?Z0ZxQStvK2lVQkFQeHgzWENTYy8ydFpBQlExa2dLNzlVejhLRUdSY3FEcGV6?=
 =?utf-8?B?aWxKeFVlOHpwYlFjNGdOeU5JQ0kzcnlLMmlzQjN3SFNkTk5RMnZtcmp1R0ZY?=
 =?utf-8?B?aGRxUVFnVFAwLzZSYnBBQ3dnUTBIdVM1aXpnRnIzdHdZSFgyTmdMVFpXZFVG?=
 =?utf-8?B?c0daeklLS09hRm9aTHlKb2pTWTVQdUNnRkE3dVN2Y1dsUE1DT3ByVjJjYVVG?=
 =?utf-8?B?TjdkWnN0SjNjSEJvbFZ5cDFnK1lmWmd2OGpVSjJHMkNXUUpaYVM1UXBCWSsr?=
 =?utf-8?B?M3BHN3lkTjZhVGE5YVhSM2tqMWpKK2tuQnh0bWFaNlQ5SHloKzRQbVp3MTRv?=
 =?utf-8?B?RG9iZnIvOXNVSzR4bk9lNEpuWks2WjU3TW45Y2hBRDdjZXFLV3FoZ09nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDQ3TE4waXQxLzZtVG9hWlRNL3ZEL0JmcmpQQ0g0QzlVNnQ1Z3JxU1BXc3NU?=
 =?utf-8?B?aHdFclE2V01zS281aUdmNkJLVWErRGJML3ZVM2pRaWJOZjZidzBYSGhHcXJ1?=
 =?utf-8?B?b1BGM0J4MkpMM2FJbnJDNzRZSkNaUkRzdFZWRE9YUnRXR0RlazBia24rL1pn?=
 =?utf-8?B?RnVCN2VtdnNNZFo2T3ZCcUROTVdlMy9FWURDLzZhYllNRUlLNnhZWHN0T2FU?=
 =?utf-8?B?R2VtVUo4cGRIaXQzSGw2QW8vOTVGZ1pUKzIwWmJMWDNoT256bWxrWjVBMGdW?=
 =?utf-8?B?cjFJRDNIT0o4NG4reG5OcytzWEk5OW9VWmJhcVRVQUFVU3MySWIrLzdXRnU5?=
 =?utf-8?B?Ym9NejI1a1EwVVBXV28xRTJqa3NZUExzZ2MrWE5pNnQzdTQyRzV1QzNoSnNs?=
 =?utf-8?B?cHpEV1RVelZkVG5HZysvVGxEMjBJUHdNZ2YrK2trdmhuSmlLNUdTOWJGdnps?=
 =?utf-8?B?NG5Xc2FnVDk0SndQSEpkVUdFb25QNENTd2FyZWE3Y2dqd0pEempUSEZITEdW?=
 =?utf-8?B?Y3VDYno3UkFYWWFaU1pPenZyZ2hWQjRvMGpRM2E0NzM3eUtRck4zbWdaU01B?=
 =?utf-8?B?VUgyWWJXQmxXcnNwQlkxMnlGbm5aczdtU0FCZ2tmWE1pRnloZU5RYkg2STVj?=
 =?utf-8?B?dGFSYThwWS83VE1NQ1JGbVdwRFd3WlV2SDgrVG9DM1J4UllOOVVBYlMzcEVW?=
 =?utf-8?B?K2RZY1IwcTZlRC9QY0thVXBLeVUzN0xCSjd2Vm1EMGdxVkhyaCsxVFZQY0V3?=
 =?utf-8?B?TzZnMFQ3Mll2Q1NnMEZIcUpiR0lldmlhL1NoK2hJM1BueExjVk43dW4yanBK?=
 =?utf-8?B?WWM2Sy9LSkJSNVVZN2UyNnkwbHNBblpDWTJpTzFxVjVONVo1bVZ6MTJrc3BG?=
 =?utf-8?B?UTdsa29uRVdUS01lb0JYdEQzZWZPVVZtZ2M2RWkrY3BzZEUxS24xZ0IzMGxh?=
 =?utf-8?B?QzdVWWIwRXZ5eVU1N2VpVUkra09nSkxKblBLZ0xuNVFIeWQrYnpOanhmTFgy?=
 =?utf-8?B?L2JxWGZqZTlJR0FKTjBtR1hPVUZmZDVHVFdCY0k1UHlVc3JXQnlPZ1RMSERW?=
 =?utf-8?B?bXcxdGVEdGgvOVRYdGZ1S0thVjNoeFJrY0Q4emtZTVVpZ3A1OWhLVnQvOUQw?=
 =?utf-8?B?T0FrVDdGdmhuNEJYTjBOSmY1NlFob2dUSTFIRHYyN2xTMEg3ZUtpZ1JXWDl4?=
 =?utf-8?B?TldrSWV1THlKYmQrTDBGUWIrQnp2dUM1MkJ1R296UzJoZ0ZYNmE0a0ZjSVdO?=
 =?utf-8?B?LzZ4d05tUDFXdWZzZ0lWZVErZm85eXJ0dFVMMWZFM0lFb2krc2srT1RtZVJ1?=
 =?utf-8?B?dXZJQy91NVdFV3hQR3MvWTQzVy9uMHNwbFFMNDh1dXRGaGdXUlYzQXBEZXY2?=
 =?utf-8?B?RkhYblIrQ0UxUzBiMHlWRnpqTXNmT2VITjkvOWZTaWErWURoZWhGaloydm9U?=
 =?utf-8?B?NFkwc0FxRWc5MC9tSDVYRkNoQlJvMG4vSTBzTGU1eXg1S2VmUlFYMHdaMGZU?=
 =?utf-8?B?WjliTEZ6eGIyTzdYQ2tQdTZpRjNoc1hFeXFvbUFjcm1zMlIyZEZHcXNIaDJs?=
 =?utf-8?B?ZVNBOUNoVWx3NFBMUWkxdXNMZkZUcTNEOHUwN3UvajcxVVpVdG12STlNTS9y?=
 =?utf-8?B?SGk1MTB3RFBDWGdtd0hKVjZ1K1dvK1orWE80a3RXZEtKL2Vkd3B1S1hkTEhr?=
 =?utf-8?B?ZnAzbmNPazgxNjVzY3ZibVIxUEExemlQVXZoSEdZblIxS1BmbE50dTJWTXpv?=
 =?utf-8?B?enVOM0xGWmF0czI3akVkZ0FpSkRRRTVyS0xtSHdqdWs1Ui9qd1ppU1c2bk9q?=
 =?utf-8?B?cWlGcWtWTm9vVkt5T2ViVFVMdjBYWC84MTZ0YWlKTlJxcVdHbDBIcktwY1pq?=
 =?utf-8?B?WkhBazEwd3UxbkpaYzBGbUl2MEdEYjFCYldsNmxsTGpEdDA3TmczZnIvcWZo?=
 =?utf-8?B?dDdIMWltQVF3SGI4dWdpZk9FYThLQmNsWmtoNU5qVEJITTd4QWxDZzNLeEZx?=
 =?utf-8?B?bGREa09Bbm1XcnZSUlE0NmlFMDRwK080S3ZqaElreXB4U3lUMkZ5N2xsM2x6?=
 =?utf-8?B?TnVpalFPbFpuL3U1VUYxQ2RaS0JRRW8zWVhqUVViVi9pL2hOUGJhRVZCNms4?=
 =?utf-8?Q?GUt1VVhuaERhlIPShuoG9VxJz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d502525-7668-4f74-85a4-08dc687bb593
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 18:39:31.7447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTKJx8H8QJJSWrPnYxqnwjee2blM23zXn/2fRKi3KzJj6cDZKC4xP/1XpNEdXzDqBMNctLdfUEUwrj10WPd2Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
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

On 2024-04-29 06:38, Yu, Lang wrote:
> [Public]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Saturday, April 27, 2024 6:45 AM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Yang, Philip <Philip.Yang@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Liu,
>> Aaron <Aaron.Liu@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdkfd: Allow memory oversubscription on
>> small APUs
>>
>> On 2024-04-26 04:37, Lang Yu wrote:
>>> The default ttm_tt_pages_limit is 1/2 of system memory.
>>> It is prone to out of memory with such a configuration.
>> Indiscriminately allowing the violation of all memory limits is not a good
>> solution. It will lead to poor performance once you actually reach
>> ttm_pages_limit and TTM starts swapping out BOs.
> Hi Felix,
>
> I just feel it's like a bug that 1/2 of system memory is fee, the driver tells users out of memory.
> On the other hand, if memory is available, why not use it.

TTM does not allow us to use more than 1/2 system memory. I believe 
that's because TTM needs additional memory to swap out BOs. Any GTT 
allocation through the render node APIs is subject to the same limitations.

Render node APIs can handle memory overcommitment more gracefully 
because the kernel mode driver is in the loop for command submissions 
and fences. That doesn't work for KFD with user mode queues. The memory 
limits in KFD are there to prevent overcommitting memory because we need 
all of our memory (per process) to be resident at the same time. If we 
let KFD exceed the TTM limits, we get into situations where we're 
thrashing (processes evicting each other constantly) or even worse, 
where we're just not able to make all memory resident. So we end up with 
suspended user mode queues and extremely poor performance or soft hangs.


>
> By the way, can we use USERPTR for VRAM allocations?
> Then we don't have ttm_tt_pages_limit limitations. Thanks.

No. There is an expectation that VRAM BOs can be shared between 
processes through DMABufs (for HIP IPC APIs). You can't export userptrs 
as DMABufs.

You can try to raise the TTM pages limit using a TTM module parameter. 
But this is taking a risk for system stability when TTM gets into a 
situation where it needs to swap out a large BO.

Regards,
   Felix


>
> I actually did some tests on Strix (12 CU@2100 MHz, 29412M 128bits LPDDR5@937MHz) with
> https://github.com/ROCm/pytorch-micro-benchmarking.
>
> Command: python micro_benchmarking_pytorch.py --network resnet50 --batch-size=64 --iterations=20
>
> 1, Run 1 resnet50 (FP32, batch size 64)
> Memory usage:
>          System mem used 6748M out of 29412M
>          TTM mem used 6658M out of 15719M
> Memory oversubscription percentage:  0
> Throughput [img/sec] : 49.04
>
> 2,  Run 2 resnet50 simultaneously (FP32, batch size 64)
> Memory usage:
>          System mem used 13496M out of 29412M
>          TTM mem used 13316M out of 15719M
> Memory oversubscription percentage:  0
> Throughput [img/sec] (respectively) : 25.27 / 26.70
>
> 3, Run 3 resnet50 simultaneously (FP32, batch size 64)
> Memory usage:
>          System mem used 20245M out of 29412M
>          TTM mem used 19974M out of 15719M
> Memory oversubscription percentage:  ~27%
>
> Throughput [img/sec](respectively) : 10.62 / 7.47 / 6.90 (In theory: 16 / 16 / 16)
>
>  From my observations,
>
> 1, GPU is underutilized a lot, sometimes its loading is less than 50% and even 0, when running 3 resnet50 simultaneously with ~27% memory oversubscription.
> The driver is busying evicting and restoring process. It takes ~2-5 seconds to restore all the BOs for one process (swap in and out BOs, actually allocate and copy pages),
> even though the process doesn't need all the allocated BOs to be resident.
>
> 2, Sometimes, the fairness can't be guaranteed between process when memory is oversubscribed.
> They can't share the GPU equally when created with default priority.
>
> 3, The less GPU underutilization time during evicting and restoring, the less performance degradation under memory oversubscription.
>
> Regards,
> Lang
>
>> Regards,
>>    Felix
>>
>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  4 ++--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12
>> +++++++++---
>>>    3 files changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 3295838e9a1d..c01c6f3ab562 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -167,7 +167,7 @@ void amdgpu_amdkfd_device_init(struct
>> amdgpu_device *adev)
>>>       int i;
>>>       int last_valid_bit;
>>>
>>> -    amdgpu_amdkfd_gpuvm_init_mem_limits();
>>> +    amdgpu_amdkfd_gpuvm_init_mem_limits(adev);
>>>
>>>       if (adev->kfd.dev) {
>>>               struct kgd2kfd_shared_resources gpu_resources = { diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 1de021ebdd46..13284dbd8c58 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -363,7 +363,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct
>>> amdgpu_device *adev, int xcp_id);
>>>
>>>
>>>    #if IS_ENABLED(CONFIG_HSA_AMD)
>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>> +void amdgpu_amdkfd_gpuvm_init_mem_limits(struct amdgpu_device
>> *adev);
>>>    void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>>>                               struct amdgpu_vm *vm);
>>>
>>> @@ -376,7 +376,7 @@ void amdgpu_amdkfd_release_notify(struct
>> amdgpu_bo *bo);
>>>    void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
>>>    #else
>>>    static inline
>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>> +void amdgpu_amdkfd_gpuvm_init_mem_limits(struct amdgpu_device
>> *adev)
>>>    {
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 7eb5afcc4895..a3e623a320b3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -60,6 +60,7 @@ static struct {
>>>       int64_t system_mem_used;
>>>       int64_t ttm_mem_used;
>>>       spinlock_t mem_limit_lock;
>>> +    bool alow_oversubscribe;
>>>    } kfd_mem_limit;
>>>
>>>    static const char * const domain_bit_to_string[] = { @@ -110,7
>>> +111,7 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct
>> amdgpu_device *bo_ad
>>>     *  System (TTM + userptr) memory - 15/16th System RAM
>>>     *  TTM memory - 3/8th System RAM
>>>     */
>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>> +void amdgpu_amdkfd_gpuvm_init_mem_limits(struct amdgpu_device
>> *adev)
>>>    {
>>>       struct sysinfo si;
>>>       uint64_t mem;
>>> @@ -130,6 +131,7 @@ void
>> amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>               kfd_mem_limit.max_system_mem_limit -=
>> AMDGPU_RESERVE_MEM_LIMIT;
>>>       kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() <<
>>> PAGE_SHIFT;
>>> +    kfd_mem_limit.alow_oversubscribe = !!(adev->flags & AMD_IS_APU);
>>>       pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>>>               (kfd_mem_limit.max_system_mem_limit >> 20),
>>>               (kfd_mem_limit.max_ttm_mem_limit >> 20)); @@ -221,8
>> +223,12 @@ int
>>> amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>            kfd_mem_limit.max_ttm_mem_limit) ||
>>>           (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] +
>> vram_needed >
>>>            vram_size - reserved_for_pt - atomic64_read(&adev-
>>> vram_pin_size))) {
>>> -            ret = -ENOMEM;
>>> -            goto release;
>>> +            if (kfd_mem_limit.alow_oversubscribe) {
>>> +                    pr_warn_ratelimited("Memory is getting
>> oversubscried.\n");
>>> +            } else {
>>> +                    ret = -ENOMEM;
>>> +                    goto release;
>>> +            }
>>>       }
>>>
>>>       /* Update memory accounting by decreasing available system

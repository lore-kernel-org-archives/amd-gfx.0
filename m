Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359D3CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B797210E6CB;
	Wed, 22 Oct 2025 07:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XwP3mFCT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF2610E6C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfegLSinn4UIwIN/M8UCk+0BV5ndgZJG5sVYYYR5hZbFGMa0yllLVcMI7ZGwDEflLu8EGlCQPVCFIleOVzQ+L6jUkPhTJqUw85DZrNpaXJeGiI8RYyOYxOEuYA5aXv+qHkb7U8GGwagFvu9sUiDDGO+Ey5l5S8GSCWA9g9Ks2DfSoT1Q3TW5gcRMxQQkK4cNJdov0iiD8fp1EBWVYrK3m7+obj2dvLu6QCtCoYEzKPnn2AkvmTHMs/sfhPmH28ZiTFNKZc/bc9j1/9wSKAts/W/rFj7CitmgECbY2cdx22LiPx/02NGBshJ4x7s6h5+ZlgB35mmPYCr3YB3fnUgj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1opsph8bfIyjNsKXlKMDuX3SaGPl03p/u9RdMorFLs=;
 b=kklwiwxn1vifkt575e/r8rAKf2CyUSTbEEwZuyn4c9UKRG2SqiqUGkTOR1fsYh4RkFiCR8W1K1wrIY3b3sxvy/GICGmAtHWG4oowywQY9XtEMMIWdAIGVK1eT4kDBpGxjmJP18AiuTncniomTFyYMglIzTMp20jnYWF/y1nQthv5ZtGnXEyJZEOVPpiSn9Q/eLJFR4yPRgJBvuvHdyp0zR5YNgP1NF5LYTU9v/miqgVvb7lkoWkVjpewyNADO5Zjo2WiBZkuOH2+p+k+Ag4VD7iT+kq7yVnNCvC/zE1kQ6oo6Hb8l+aFE7J7s93P+99JzxNhD+kuLDTvvOCT6GeZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1opsph8bfIyjNsKXlKMDuX3SaGPl03p/u9RdMorFLs=;
 b=XwP3mFCT1aVBTSSwO21fVI4ZaeVuTQ0b0r0txPSc2erTx3ISFqMv3fm5SZImrg+JaGZY/K75uHOKoORl08ocfQjILIG42jiZpv9n6eHD6DaIs2BwUWZ+dl79SCHCwjZLXQTi7swiW5099153S61V1HRlicOEwjEB15vnTsBc2mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 22 Oct
 2025 07:01:05 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 07:01:04 +0000
Content-Type: multipart/alternative;
 boundary="------------hRwOyF8lx0toK0thq0YO3wrw"
Message-ID: <231341d7-5138-4834-a44f-1c76f3f81a65@amd.com>
Date: Wed, 22 Oct 2025 15:01:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/18] [PATCH V4 00/18] amdkfd: Implement kfd multiple
 contexts
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
 <41489a22-d687-4ccf-a3e2-d1126bb79ebd@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <41489a22-d687-4ccf-a3e2-d1126bb79ebd@amd.com>
X-ClientProxiedBy: TYCP286CA0172.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::10) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: b452b5a0-1e40-4730-ca4b-08de1138c466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0FpellhMFV4Q2VKQXdyVEl3VXJVY0tRY2NQRVV2ckltUi9YVE40U3h6M0Nk?=
 =?utf-8?B?bkJGVFF3OXpQTEI4Q3ZWVTl6aTJneFlSdVh5NVlORVltZFNEMGxGa3pQTjJu?=
 =?utf-8?B?UG80eStlV2loSSs0RGVITUtzK0RrYks1SStOclJQNEo1RnB1VkdRSnlEMjNR?=
 =?utf-8?B?YitKL2JQL2lFYXIvb1hjNUErY3Nob09iK21heFNWRDhzbFlwT1hOSDNnMzd5?=
 =?utf-8?B?TzlRYVc1TlJiYWpaQndRaWdVTEVMRlVOZHYwaXpmOUhGSHhVRnBIOTFMY3pZ?=
 =?utf-8?B?anNjcnlWQlFqRTB5V3plaFcrVlBEa01uaWpibkx6ZDFyeFhrdEVPRyswWHZI?=
 =?utf-8?B?S1N0OWRuT3kvUFNxb1MxTHhqTCtlOTlCa0VEcjlJUzVJZEV0MkJkTldsSGM2?=
 =?utf-8?B?cnJPaUc3MWNWakxLazhKWU1NeTdRVzFsdFFXVnZ2MmR5QmRjbjB1MmsydlVh?=
 =?utf-8?B?dFdtU29SalVxZzg3MnVtbVNlVGFXZ3RaK2hyam95UEllMFRJd2pMQzZUYXB4?=
 =?utf-8?B?OG0vZU1KV2xtNTJMeHUzMnlNenIxRFV6T1VQNHd3cXlXMmlXTVlhRGl0aXR2?=
 =?utf-8?B?aXpLSnpMclg3Y2VUMFpMU0hOZ3kxV2ZBQkdUNTcyYktmRDJhbVY4S09SVDEr?=
 =?utf-8?B?QVJ2RVRDM2ZQOWZTamJYUjdVaXczTTY5akFmemhFQ29MRC93dGhmQW9VTGE1?=
 =?utf-8?B?OUt0N0taTG15bjBjcitvT1E3SGNnYm0zSThOWU1XbkdDcUl4WlJMSU9tWjRQ?=
 =?utf-8?B?Q2swUWhLNm9ZcnU0dnM0MFBLUU5NMlRzUU9aVEp2U2dpUExQTmtSbVdnQlpF?=
 =?utf-8?B?NGNCRVhIVWkrMTJlelVVSDBzdXgzOEVyc0lRcG83Q1BJMC9GdmlmYlR3c0NO?=
 =?utf-8?B?dVQzWUVwdS8waFRSaFZySGVVVmdyOG9nRnZKZlFQNWUvd2E0K1RhQnJYcTBM?=
 =?utf-8?B?b2xZNVg3U3FyL1BlUGZ2N2ZQT2JkTmdUNnRBbkJZMnlMa0JTQk1qenNDQ2lD?=
 =?utf-8?B?REMxMnlkOUUxYlNKaGluMkQ4ZzRLd1lPTnBYZnBjalZ1aVZjS2hYelQ4V0Jx?=
 =?utf-8?B?Q0ZLU0ZrcUl5NldETHd4RGFWN1kyYmVXVkkwUjh2WHNSczJXK0tHbEZyWXp1?=
 =?utf-8?B?UHpRWDJENnF5Z2lYYW1kYUtKQ0ZhT3VqdXFVaFU0dStBOFdRSWZVTDdYbkFF?=
 =?utf-8?B?TEM3YVpuTFUzbzNTVU5maWFNcTJvWnA5Ymx0cCtSZE5va1lqbnk2Tm9US2U4?=
 =?utf-8?B?eXgzV0V0cEluenlBbnlFNUhkYnREcm9YRXhLMkREcFNHYVNUSTBpSjJQVjVZ?=
 =?utf-8?B?RmlSYjhLOWNUL3RMUzdFNEFkMmVBN0ZrSGhKNEZnQWJmTStzNmRUSWN3N2dK?=
 =?utf-8?B?TUx3Z20wT2kvbmJFUjRaeU9Yd05RUU1kczVuNGNvRHVicXFteEpIa3lpU1Bx?=
 =?utf-8?B?bXpGbjhIbGZnTUxFWmY3dkYxTXNQeDNkV2VncU5xMEhkcWRFc0QzS3NVaFBt?=
 =?utf-8?B?NFFDVWdjQXpKbHlvQkdiVHJBMmJqTHNKRiszQmRSUlpPV3pINGczSWI1alVC?=
 =?utf-8?B?Y1hzaEk1Z0lSN3pvNXhDaHFkTklKempSRURuRWxFR1lia21Ba0tMN2ZwZ3R6?=
 =?utf-8?B?dndLV2xDZ1krTkxhUUhmVmlUc1FqNFdya0RsdU41TGwvRGRBOTNzQlNqc0xi?=
 =?utf-8?B?bE9aUDIwVGM4TDByUmkrYTV5WERCdTZ2L0NVVkR6bU9uTW9sMXlLTkdZanlr?=
 =?utf-8?B?WGx2VUpiNGZESGI3bDUwSW5Hd2kyZTAvZDNidWRUMHNsTitsTnBPRGZSdkVH?=
 =?utf-8?B?WmtuNXNKZnRXSmVob3NUNUlHczkrSHpLTm1ibFZHRkFYZzVlSmVJTWVxbFRk?=
 =?utf-8?B?VGRUWEJZVVZyREtUZlB2T09TL01xajhIeCs2MVQrT09IYVJENVROZVY0VFo5?=
 =?utf-8?B?Z21obTZPZ0kyaUZGY3A0ZWl0RmNSakhiN3ZqOHlQK1FBSVBLZUdFZ25xZGg4?=
 =?utf-8?B?ZjN6a3hHMEFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZick5Ib1NIOGN0L2MzaDNHaFRSUjNqQmtPZVBLeTFOZVRIN2FuR1NvZXdX?=
 =?utf-8?B?blEvRGZjUnVPV0wwNklFZTdOLzA3eGdtSVpwSTZERkk2VlF6V3pSWWl1ak1o?=
 =?utf-8?B?S3VNSVNOb08vK213WjJLL2Q4RERsSHdLR2x0dmtQTmJCWnRIczltczBYcjl6?=
 =?utf-8?B?bE1EMEE0STNKcDAyY3JkTjVTSVpwdEc3TXNPVHFrcHNTSFBoZzMxb3hlWEdF?=
 =?utf-8?B?ZlY2dzU0akh5TjBiWXB3MFArcTdtaEdUVUhxUkM2eWdRK1hPOS9YVEV4NUpF?=
 =?utf-8?B?eWFRanlZSzlsZ0J5RUVuRExnRmt1dS83UjBqQnc5cjRKYzhKR3ErQ1ZQRDZp?=
 =?utf-8?B?T2NoSWNTVG0zNi9uT0V3VkY0R290WVN4ajFwd1k1ZUVlaGZKeGVkT0lNMnIz?=
 =?utf-8?B?S1FZUGFadHBJQXdWMjdESllMMGJLUXU1M2ZpR0REVkJ2NVJJMnFtSWhFSGN0?=
 =?utf-8?B?WHZVbWVwVVYxUDhaLzE1emRBVnNCdXZMZ2lxSkh3WGtrZEJFMzZKdVdITTRv?=
 =?utf-8?B?U21OWitGTGNJMC9qZ1lidHFEN3p5NWxqV0dwakpPNUMvV0Zmb0sxaWV4WlBu?=
 =?utf-8?B?M0RLZFZSLzV0aVdDOER2MjM5YjVJMWx2NS9XN25SdG9KS2dob0xLYk14OEsw?=
 =?utf-8?B?QUFQTENFYmdpS1VCNjQzNGFDd1N2S0UrTkR4WXB2S0NBNTUxSTdVdzlnQkVQ?=
 =?utf-8?B?ZUc1NkJseFBlYTM4MEZrUTdMZ2RIMHg1NmJSalR0MkFlZ3ZOcnpCSC95MXNw?=
 =?utf-8?B?OC9FZG8xWEhEYVMvdWdjMlV6R2d3bjJqYThncnlaSlBEOVN0TzdRcWdYUGc0?=
 =?utf-8?B?eVMrVkdWQmpBNU1iZ25mQkdlenZSZUlxS1hONWVrZURFaVRtNDYyakxvaXZq?=
 =?utf-8?B?elRsTkRyZlRlaFJKU2tSLzIxSm40SEdNc2IzaWJrT0pySHpYMThGMEJYRHpX?=
 =?utf-8?B?Mkl6Z0o2R3B3elVQbzQ3Z2tqeXdzeUVyYWl0cDNLZkdLUkQ1cXBaa29JNUFz?=
 =?utf-8?B?bTR3K2V3Sm9JSHlVMlF6Z3FzdEpPaFY3aWV6bzcyMVJqOUd4WFRKUTBwTXNo?=
 =?utf-8?B?TkN1VjFZdUZQV1gwdGVzZlNSR0l6cS91YmFBblFSdDkxUXdLTXJoakswYlY3?=
 =?utf-8?B?NFBJRm04KzU4YXR2TEJhSDQ4VGF6SEJzb2hoUWsvY3FXbGRzMUJJb0NZWmVF?=
 =?utf-8?B?eGdnd09DWS9xRlhjT3NuRGhRZ1ZiK0ZnMjIwQUR5b3p5OS9IMzBEQjZxL0dt?=
 =?utf-8?B?ZHNuSUMrUU82YUNRTjh6bWFnaW5DMkZQeW9jTkF4WWZTbzdqUUtSSEwyYU1G?=
 =?utf-8?B?VDlGOGVZbEZaS0NlbU1KR3NrdE0wQ1Y0QWlFaGtvVk1tTHdEVGNScHNOOWdv?=
 =?utf-8?B?dW9hWVp2WUMrRUkrSk02SEpKQWVvY0s5cUN0a0NsVlR1bFk0NW11NzJuTUNq?=
 =?utf-8?B?d05HdVlNMGNQMUVKcEFGbklkaU1DRGpreGtDR0QyaWtuU2tKbWpQblkzKy9K?=
 =?utf-8?B?YkhodXdaVDZsS1crc2Zqdm8xYWZOK3FJNkJuSk1OQnFVS2lTWG9nNlUvREhr?=
 =?utf-8?B?Rk9xM2lyU2lyQ2FpUHFjTmdNRmtERGxLMEIxcXpzQVVjOFBtcXR0cTJldWtk?=
 =?utf-8?B?M2ZyVUs0QlZaT3NLdWVKU3RuR2ZIeVh3NlRQOExiV1F2VDZCWWhPSGVtN1ph?=
 =?utf-8?B?YnpPZEdaQ0lsZ3hubnlXWU5xajFNcURDd29FR3ZWMFJnc0VIMkJ2aWs0ejJO?=
 =?utf-8?B?NVBSQjBFcmNVSmZvUHQrQ3NQK1lvWksvRnRxa0VNNk44dlQ0S1ZCMXhUaTU4?=
 =?utf-8?B?WjArQk9JcGZRRU9Jb2owcWl2TWFNRU91Mm4xbFdVSkVyeGRiVTJTL2JkaUF5?=
 =?utf-8?B?bmdSSzRrUEYvUnhuSzRxb1dVckhhcTdZZHdPQzZKSlJWdk1nSk9Fbkd3V2hi?=
 =?utf-8?B?VlJnZ2VGMC9EbWhIRHZBaVZ3SnhQcEYxTzNHaGpyQ3dQWW9KM0cxcnFGT0lN?=
 =?utf-8?B?UFJDMVZSekhCMFhpSzlva0xvRi9nRDB3U28rSTFBTExsMU8zUFJpOUVpNnRC?=
 =?utf-8?B?NjJ4dVJjZjBBR1M2MkF2MVNpbldvT3RBa0k2Y1FMSlZTM3JnMC9rV0IyZ2xQ?=
 =?utf-8?Q?9I0eOq2soowVxUjzN58MQrf58?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b452b5a0-1e40-4730-ca4b-08de1138c466
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:01:04.6706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbQ3Q54oZc0FOdSkps0m++LjU+XbtNrLmfmmkQgBfmuXyGuCtiF47IJpMoNxxaXr8kXdobvj/6t3prZ4cz6Ntg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
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

--------------hRwOyF8lx0toK0thq0YO3wrw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/18/2025 7:58 AM, Felix Kuehling wrote:
> See my comments on patches 8, 17 and 18. The remaining patches look
> good and are
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
> I think this patch series is nearly ready, pending actual user mode
> code that uses it. 

Thanks, do you think it is a must to merge user space thunk/kfdtest code first?

Thanks
Lingshan

>
> Regards,
>   Felix
>
>
> On 2025-10-17 04:42, Zhu Lingshan wrote:
>> Currently kfd manages kfd_process in a one context (kfd_process)
>> per program manner, thus each user space program
>> only onws one kfd context (kfd_process).
>>
>> This model works fine for most of the programs, but imperfect
>> for a hypervisor like QEMU. Because all programs in the guest
>> user space share the same only one kfd context, which is
>> problematic, including but not limited to:
>>
>> As illustrated in Figure 1, all guest user space programs share the
>> same fd of /dev/kfd
>> and the same kfd_process, and the same PASID leading to the same
>> GPU_VM address space. Therefore the IOVA range of each
>> guest user space programs are not isolated,
>> they can attack each other through GPU DMA.
>>
>>
>>  
>> +----------------------------------------------------------------------------------+
>>  
>> |                                                                                 
>> |
>>   |  +-----------+      +-----------+      +------------+     
>> +------------+        |
>>   |  |           |      |           |      |            |     
>> |            |        |
>>   |  | Program 1 |      | Program 2 |      | Program 3  |      |
>> Program N  |        |
>>   |  |           |      |           |      |            |     
>> |            |        |
>>   |  +----+------+      +--------+--+      +--+---------+     
>> +-----+------+        |
>>   |       |                      |            |                     
>> |               |
>>   |       |                      |            |                     
>> |        Guest  |
>>   |       |                      |            |                     
>> |               |
>>  
>> +-------+----------------------+------------+----------------------+---------------+
>>           |                      |            |                      |
>>           |                      |            |                      |
>>           |                      |            |                      |
>>           |                      |            |                      |
>>           |                   +--+------------+---+                  |
>>           |                   | file descriptor   |                  |
>>           +-------------------+ of /dev/kfd       +------------------+
>>                               | opened by QEMU    |
>>                               |                   |
>>                               +---------+---------+                  
>> User Space
>>                                         |                            
>> QEMU
>>                                         |
>> ---------------------------------------+-----------------------------------------------------
>>
>>                                         |                            
>> Kernel Space
>>                                         |                            
>> KFD Module
>>                                         |
>>                                +--------+--------+
>>                                |                 |
>>                                |   kfd_process  
>> |<------------------The only one KFD context
>>                                |                 |
>>                                +--------+--------+
>>                                         |
>>                                +--------+--------+
>>                                |     PASID       |
>>                                +--------+--------+
>>                                         |
>>                                +--------+--------+
>>                                |      GPU_VM     |
>>                                +-----------------+
>>
>>                                   Fiture 1
>>
>>
>> This series implements a multiple contexts solution:
>> - Allow each program to create and hold multiple contexts (kfd
>> processes)
>> - Each context has its own fd of /dev/kfd and an exclusive kfd_process,
>>    which is a secondary kfd context. So that PASID/GPU VM isolates
>> their IOVA address spaces.
>>    Therefore, they can not attack each other through GPU DMA.
>>
>> The design is illustrated in Figure 2 below:
>>
>>    
>> +---------------------------------------------------------------------------------------------------------+
>>    
>> |                                                                                                        
>> |
>>    
>> |                                                                                                        
>> |
>>    
>> |                                                                                                        
>> |
>>     |      
>> +----------------------------------------------------------------------------------+             
>> |
>>     |      
>> |                                                                                 
>> |              |
>>     |       | +-----------+      +-----------+     +-----------+   
>> +-----------+              |              |
>>     |       | |           |      |           |     |           |   
>> |           |              |              |
>>     |       | | Program 1 |      | Program 2 |     | Program 3 |    |
>> Program N |              |              |
>>     |       | |           |      |           |     |           |   
>> |           |              |              |
>>     |       | +-----+-----+      +-----+-----+     +-----+-----+   
>> +-----+-----+              |              |
>>     |       |       |                  |                
>> |                |                    |              |
>>     |       |       |                  |                
>> |                |        Guest       |              |
>>     |       |       |                  |                
>> |                |                    |              |
>>     |      
>> +-------+------------------+-----------------+----------------+--------------------+             
>> |
>>     |               |                  |                
>> |                |                            QEMU   |
>>     |               |                  |                
>> |                |                                   |
>>    
>> +---------------+------------------+-----------------+----------------+--------------------------+--------+
>>                     |                  |                
>> |                |                          |
>>                     |                  |                
>> |                |                          |
>>                     |                  |                
>> |                |                          |
>>                 +---+----+         +---+----+        +---+----+      
>> +---+----+                 +---+-----+
>>                 |        |         |        |        |        |      
>> |        |                 | Primary |
>>                 |  FD 1  |         |  FD 2  |        |  FD 3  |      
>> |  FD 4  |                 |   FD    |
>>                 |        |         |        |        |        |      
>> |        |                 |         |
>>                 +---+----+         +---+----+        +---+----+      
>> +----+---+                 +----+----+
>>                     |                  |                
>> |                 |                          |             User Space
>>                     |                  |                
>> |                 |                          |
>> -------------------+------------------+-----------------+-----------------+--------------------------+----------------------------
>>
>>                     |                  |                
>> |                 |                          |             Kernel SPace
>>                     |                  |                
>> |                 |                          |
>>                     |                  |                
>> |                 |                          |
>>    
>> +--------------------------------------------------------------------------------------------------------------------------+
>>     |        +------+------+    +------+------+   +------+------+  
>> +------+------+            +------+------+                 |
>>     |        | Secondary   |    | Secondary   |   | Secondary   |   |
>> Secondary   |            |  Primary    |   KFD Module    |
>>     |        |kfd_process 1|    |kfd_process 2|   |kfd_process 3|  
>> |kfd_process 4|            | kfd_process |                 |
>>     |        |             |    |             |   |             |  
>> |             |            |             |                 |
>>     |        +------+------+    +------+------+   +------+------+  
>> +------+------+            +------+------+                 |
>>     |               |                  |                
>> |                 |                          |                        |
>>     |        +------+------+    +------+------+   +------+------+  
>> +------+------+            +------+------+                 |
>>     |        |   PASID     |    |   PASID     |   |   PASID     |  
>> |   PASID     |            |   PASID     |                 |
>>     |        +------+------+    +------+------+   +------+------+  
>> +------+------+            +------+------+                 |
>>     |               |                  |                
>> |                 |                          |                        |
>>     |               |                  |                
>> |                 |                          |                        |
>>     |        +------+------+    +------+------+   +------+------+  
>> +------+------+            +------+------+                 |
>>     |        |   GPU_VM    |    |   GPU_VM    |   |   GPU_VM    |  
>> |   GPU_VM    |            |   GPU_VM    |                 |
>>     |        +-------------+    +-------------+   +-------------+  
>> +-------------+            +-------------+                 |
>>    
>> |                                                                                                                         
>> |
>>    
>> +--------------------------------------------------------------------------------------------------------------------------+
>>                                                                                                                                   
>>                                                    Figure 2
>>
>> The relevant reference user space rocm changes could be found at:
>> https://github.com/AMD-ROCm-Internal/rocm-systems/pull/78
>> https://github.com/AMD-ROCm-Internal/rocm-systems/pull/110
>>
>> Changes from V4:
>> 1) rename process_id to context_id in struct kfd_process
>> 2) remove primary flag in struct kfd_process
>> 3) reject set_debug_trap ioctl request when
>> the target kfd_process is non-primary
>> 4) other than default 0, assign context_id 0xFFFF to the primary kfd
>> process
>>
>> Most of the patches have been changed, so I removed
>> their signed-off-by tag.
>>
>> Please help review
>>
>> Thanks!
>>
>> Zhu Lingshan (18):
>>    amdkfd: enlarge the hashtable of kfd_process
>>    amdkfd: mark the first kfd_process as the primary one
>>    amdkfd: find_process_by_mm always return the primary context
>>    amdkfd: Introduce kfd_create_process_sysfs as a separate function
>>    amdkfd: destroy kfd secondary contexts through fd close
>>    amdkfd: process svm ioctl only on the primary kfd process
>>    amdkfd: process USERPTR allocation only on the primary kfd process
>>    amdkfd: identify a secondary kfd process by its id
>>    amdkfd: find kfd_process by filep->private_data in kfd_mmap
>>    amdkfd: remove DIQ support
>>    amdkfd: process pointer of a HIQ should be NULL
>>    amdkfd: remove test_kq
>>    amdkfd: introduce new helper kfd_lookup_process_by_id
>>    amdkfd: record kfd context id into kfd process_info
>>    amdkfd: record kfd context id in amdkfd_fence
>>    amdkfd: fence handler evict and restore a kfd process by its context
>>      id
>>    amdkfd: process debug trap ioctl only on a primary context
>>    amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   8 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  10 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   8 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  79 +++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   7 +-
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |   6 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  61 +----
>>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 -
>>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   4 -
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  19 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 239 +++++++++++++-----
>>   .../amd/amdkfd/kfd_process_queue_manager.c    |  39 +--
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
>>   include/uapi/linux/kfd_ioctl.h                |   8 +-
>>   14 files changed, 294 insertions(+), 200 deletions(-)
>>
--------------hRwOyF8lx0toK0thq0YO3wrw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    On 10/18/2025 7:58 AM, Felix Kuehling wrote:
    <blockquote type="cite" cite="mid:41489a22-d687-4ccf-a3e2-d1126bb79ebd@amd.com">See my
      comments on patches 8, 17 and 18. The remaining patches look good
      and are
      <br>
      <br>
      Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
      <br>
      <br>
      I think this patch series is nearly ready, pending actual user
      mode code that uses it.&nbsp;<br>
    </blockquote>
    <pre>Thanks, do you think it is a must to merge user space thunk/kfdtest code first?

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:41489a22-d687-4ccf-a3e2-d1126bb79ebd@amd.com"><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      On 2025-10-17 04:42, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">Currently kfd manages kfd_process in a one
        context (kfd_process)
        <br>
        per program manner, thus each user space program
        <br>
        only onws one kfd context (kfd_process).
        <br>
        <br>
        This model works fine for most of the programs, but imperfect
        <br>
        for a hypervisor like QEMU. Because all programs in the guest
        <br>
        user space share the same only one kfd context, which is
        <br>
        problematic, including but not limited to:
        <br>
        <br>
        As illustrated in Figure 1, all guest user space programs share
        the same fd of /dev/kfd
        <br>
        and the same kfd_process, and the same PASID leading to the same
        <br>
        GPU_VM address space. Therefore the IOVA range of each
        <br>
        guest user space programs are not isolated,
        <br>
        they can attack each other through GPU DMA.
        <br>
        <br>
        <br>
        &nbsp;
+----------------------------------------------------------------------------------+<br>
        &nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |
        <br>
        &nbsp; |&nbsp; +-----------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +-----------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +------------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +------------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp; |&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp; |&nbsp; | Program 1 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Program 2 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Program 3&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        Program N&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp; |&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp; |&nbsp; +----+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +--------+--+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +--+---------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +-----+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Guest&nbsp; |
        <br>
        &nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;
+-------+----------------------+------------+----------------------+---------------+<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +--+------------+---+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | file descriptor&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +-------------------+ of /dev/kfd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +------------------+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | opened by QEMU&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +---------+---------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; User Space
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QEMU
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
---------------------------------------+-----------------------------------------------------
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel Space
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD Module
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +--------+--------+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; kfd_process&nbsp;&nbsp;
        |&lt;------------------The only one KFD context
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +--------+--------+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +--------+--------+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +--------+--------+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +--------+--------+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GPU_VM&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +-----------------+
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fiture 1
        <br>
        <br>
        <br>
        This series implements a multiple contexts solution:
        <br>
        - Allow each program to create and hold multiple contexts (kfd
        processes)
        <br>
        - Each context has its own fd of /dev/kfd and an exclusive
        kfd_process,
        <br>
        &nbsp;&nbsp; which is a secondary kfd context. So that PASID/GPU VM
        isolates their IOVA address spaces.
        <br>
        &nbsp;&nbsp; Therefore, they can not attack each other through GPU DMA.
        <br>
        <br>
        The design is illustrated in Figure 2 below:
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;
+---------------------------------------------------------------------------------------------------------+<br>
        &nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |
        <br>
        &nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |
        <br>
        &nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
+----------------------------------------------------------------------------------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | +-----------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +-----------+&nbsp;&nbsp;&nbsp;&nbsp;
        +-----------+&nbsp;&nbsp;&nbsp; +-----------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | | Program 1 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Program 2 |&nbsp;&nbsp;&nbsp;&nbsp; | Program 3
        |&nbsp;&nbsp;&nbsp; | Program N |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | +-----+-----+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +-----+-----+&nbsp;&nbsp;&nbsp;&nbsp;
        +-----+-----+&nbsp;&nbsp;&nbsp; +-----+-----+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Guest&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
+-------+------------------+-----------------+----------------+--------------------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QEMU&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;
+---------------+------------------+-----------------+----------------+--------------------------+--------+<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +---+----+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +---+----+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +---+----+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +---+----+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +---+-----+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Primary |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; FD 1&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; FD 2&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; FD 3&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; FD 4&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; FD&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +---+----+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +---+----+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +---+----+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +----+---+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +----+----+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; User
        Space
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
-------------------+------------------+-----------------+-----------------+--------------------------+----------------------------
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Kernel SPace
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;
+--------------------------------------------------------------------------------------------------------------------------+<br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +------+------+&nbsp;&nbsp;&nbsp; +------+------+&nbsp;&nbsp;
        +------+------+&nbsp;&nbsp; +------+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +------+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Secondary&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; | Secondary&nbsp;&nbsp; |&nbsp;&nbsp; | Secondary&nbsp;&nbsp;
        |&nbsp;&nbsp; | Secondary&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; Primary&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; KFD Module&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |kfd_process 1|&nbsp;&nbsp;&nbsp; |kfd_process 2|&nbsp;&nbsp; |kfd_process
        3|&nbsp;&nbsp; |kfd_process 4|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | kfd_process |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +------+------+&nbsp;&nbsp;&nbsp; +------+------+&nbsp;&nbsp;
        +------+------+&nbsp;&nbsp; +------+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +------+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +------+------+&nbsp;&nbsp;&nbsp; +------+------+&nbsp;&nbsp;
        +------+------+&nbsp;&nbsp; +------+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +------+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; PASID&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; PASID&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; |&nbsp;&nbsp; PASID&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp; |&nbsp;&nbsp; PASID&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; PASID&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +------+------+&nbsp;&nbsp;&nbsp; +------+------+&nbsp;&nbsp;
        +------+------+&nbsp;&nbsp; +------+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +------+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +------+------+&nbsp;&nbsp;&nbsp; +------+------+&nbsp;&nbsp;
        +------+------+&nbsp;&nbsp; +------+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +------+------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; GPU_VM&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; GPU_VM&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; |&nbsp;&nbsp; GPU_VM&nbsp;&nbsp;&nbsp;
        |&nbsp;&nbsp; |&nbsp;&nbsp; GPU_VM&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; GPU_VM&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +-------------+&nbsp;&nbsp;&nbsp; +-------------+&nbsp;&nbsp;
        +-------------+&nbsp;&nbsp; +-------------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        +-------------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
        <br>
        &nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        |
        <br>
        &nbsp;&nbsp;&nbsp;
+--------------------------------------------------------------------------------------------------------------------------+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Figure 2
        <br>
        <br>
        The relevant reference user space rocm changes could be found
        at:
        <br>
        <a class="moz-txt-link-freetext" href="https://github.com/AMD-ROCm-Internal/rocm-systems/pull/78">https://github.com/AMD-ROCm-Internal/rocm-systems/pull/78</a>
        <br>
        <a class="moz-txt-link-freetext" href="https://github.com/AMD-ROCm-Internal/rocm-systems/pull/110">https://github.com/AMD-ROCm-Internal/rocm-systems/pull/110</a>
        <br>
        <br>
        Changes from V4:
        <br>
        1) rename process_id to context_id in struct kfd_process
        <br>
        2) remove primary flag in struct kfd_process
        <br>
        3) reject set_debug_trap ioctl request when
        <br>
        the target kfd_process is non-primary
        <br>
        4) other than default 0, assign context_id 0xFFFF to the primary
        kfd process
        <br>
        <br>
        Most of the patches have been changed, so I removed
        <br>
        their signed-off-by tag.
        <br>
        <br>
        Please help review
        <br>
        <br>
        Thanks!
        <br>
        <br>
        Zhu Lingshan (18):
        <br>
        &nbsp;&nbsp; amdkfd: enlarge the hashtable of kfd_process
        <br>
        &nbsp;&nbsp; amdkfd: mark the first kfd_process as the primary one
        <br>
        &nbsp;&nbsp; amdkfd: find_process_by_mm always return the primary context
        <br>
        &nbsp;&nbsp; amdkfd: Introduce kfd_create_process_sysfs as a separate
        function
        <br>
        &nbsp;&nbsp; amdkfd: destroy kfd secondary contexts through fd close
        <br>
        &nbsp;&nbsp; amdkfd: process svm ioctl only on the primary kfd process
        <br>
        &nbsp;&nbsp; amdkfd: process USERPTR allocation only on the primary kfd
        process
        <br>
        &nbsp;&nbsp; amdkfd: identify a secondary kfd process by its id
        <br>
        &nbsp;&nbsp; amdkfd: find kfd_process by filep-&gt;private_data in
        kfd_mmap
        <br>
        &nbsp;&nbsp; amdkfd: remove DIQ support
        <br>
        &nbsp;&nbsp; amdkfd: process pointer of a HIQ should be NULL
        <br>
        &nbsp;&nbsp; amdkfd: remove test_kq
        <br>
        &nbsp;&nbsp; amdkfd: introduce new helper kfd_lookup_process_by_id
        <br>
        &nbsp;&nbsp; amdkfd: record kfd context id into kfd process_info
        <br>
        &nbsp;&nbsp; amdkfd: record kfd context id in amdkfd_fence
        <br>
        &nbsp;&nbsp; amdkfd: fence handler evict and restore a kfd process by its
        context
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; id
        <br>
        &nbsp;&nbsp; amdkfd: process debug trap ioctl only on a primary context
        <br>
        &nbsp;&nbsp; amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
        <br>
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 +-
        <br>
        &nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c&nbsp; |&nbsp; 10 +-
        <br>
        &nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; |&nbsp;&nbsp; 8 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 79 +++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 +-
        <br>
        &nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c |&nbsp;&nbsp; 6 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |&nbsp; 61 +----
        <br>
        &nbsp; .../drm/amd/amdkfd/kfd_packet_manager_v9.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 -
        <br>
        &nbsp; .../drm/amd/amdkfd/kfd_packet_manager_vi.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 -
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 19 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 239
        +++++++++++++-----
        <br>
        &nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp; |&nbsp; 39 +--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-
        <br>
        &nbsp; include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 +-
        <br>
        &nbsp; 14 files changed, 294 insertions(+), 200 deletions(-)
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------hRwOyF8lx0toK0thq0YO3wrw--

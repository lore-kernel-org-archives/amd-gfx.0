Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62934C02199
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 16:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149C810E8CB;
	Thu,  6 Feb 2025 16:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vA47gI/p";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D55D10E8C4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 16:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vgf+QIGgwwFA90x7K65bwutYA8OaQPurNLbpCLc+3cdIp4MEaV2AcjQKlbC80FS8XLhacrDFtUljsgZKiZ/m0yYWPg4RwKsstZTLR+vM7QUWBgm7w/VT1rLJaW4LwZFG9Hi4L2dIzvDR1zty0yJq1qLB8t9bKLiXTC0tGM82Brt7KE3p7c6FVmjw6nSBkKNnWezsOp6u8pC1RE7lo/ZuzmVvy87G7gFvQaLQb1ddExL4bhojHlAVfPafi2o4b0hb1SwSkCbjZFCoWKsVr+kxnUklDQuUe4g46pPDXUNZYjZI35mbfFYQ8vYAFsZ4BJQwD6+QIfXgrvkIClgu8cEM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAG1fTb0OSvtNjGlYl+BOOJojzOEmffQnlR+CKKFG2s=;
 b=SYOj5OneaoV6HRuPusrsj+A06/LLWD8jPfnA7PltxtHU7yUQmbA0ZDiMpfxkol2BM7cdrbiRDg4gbgc0kb4Ebvy5JP7C2u9MJ7LUyBBB8yFzGKsMLpwuqxe1CfvHO27/xA0rLjtLobqNfcAx5Jl3jPgg+Bo9TIjbfsORNOWj2KXgnh2ZB9jR45l7g0gWJcfwLs7n2gtAZHD0TqEUbt3x7KeZNT/scAq/sUJrgcHLpi+EhuEXuEu1sR2qMO8H/+cwqVLijVZBRF6eKoPJLysw/6PZ8pax1+NBo1LQk+FTqoZE1nIkdgBY9L0riU/jaD5HWiuKwlwHV91zIffZ23opLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAG1fTb0OSvtNjGlYl+BOOJojzOEmffQnlR+CKKFG2s=;
 b=vA47gI/pOVr+DxCGXDjIzsbdJIbkZ+lEbJJ+BehW5qIdyLc+UBF2NNPi78mxbUf2EaklbJ7lMhjojVkwX6iXSzK02PEQ3S7SFgr18BP+hVoQShGPe5J5CLFs0o2D6bKnt3/G6ikFjiqpFk5/Sxm1EUJ/y2k+uSP0uf3UPLHrTlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 16:30:41 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%3]) with mapi id 15.20.8398.014; Thu, 6 Feb 2025
 16:30:40 +0000
Message-ID: <10a87efa-1e38-4fbb-b194-036042e2ef43@amd.com>
Date: Thu, 6 Feb 2025 11:30:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250129152029.32275-1-jinhuieric.huang@amd.com>
 <b137eb65-248a-4def-8445-4ef29cbd9cd0@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <b137eb65-248a-4def-8445-4ef29cbd9cd0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::9) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 5905659b-0c2c-4214-e514-08dd46cb9828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHRsQVhHdGV3RVl0amJhUTF3ZHlreGdjZ3pDSWFINmsxdXNDTVY1V3A5UUdG?=
 =?utf-8?B?OEtIeFFEaXpneDJDNDE5TjN2UVFHR21HZ3E4d0xuL01KMXNrQWJrTjQwMTR4?=
 =?utf-8?B?V2hvZDhteGY2Rk02T05temxIYVFDUHhYSzRoWkpGZ0VmSitlUDV0dldPRmVC?=
 =?utf-8?B?TlpIOWprOTVKU2xseGdGSUZHLzNFZ2RwZ0JBdFh4VXNTazZZb1VKTFZNWkUv?=
 =?utf-8?B?eVM3R2QrUXE5dHcxWXI4bmhmeGdvQS9yNjI3UHNjQW1LdUpnVEc1ZFJHUXhQ?=
 =?utf-8?B?SndRQjZ0T2M3cXlBMWFZTFVyM1lsR0VOaURlZFZ5UnVrOFU1eDFxRCtYQmJp?=
 =?utf-8?B?dnp1OWUyZlE0bDJOWC9nMWFDRjNWOFMreU9QdDZmVHYxeDEvTnhZbE5RN0N5?=
 =?utf-8?B?ajdHVkMwMGZXMC9hcVZjVGY4NTFkNTgrZ2tiNnpETVpLVmZGdmlGenpCcHVD?=
 =?utf-8?B?akV1VFlIT1YwUjNFdVJxeE9iMXpoUnU1K2c0d3NhVW82bVgrOGI1M1I1RWlN?=
 =?utf-8?B?elloQitvZWcrRVpuMmlNS2hWd3ZHQ29iYXh1U1ZiTXFRNUtDWTdJb3FXQ05D?=
 =?utf-8?B?SHdCZERGRXVJT2JZeWZrTDVhYmE5K3p6R3NTTmpnV2didVNjMW9FVDZObzls?=
 =?utf-8?B?b2Zvdy9nY2F4c3ZydWZ6LzU0b3hrQW41SU1rcFVmNzJ3enZWNjJLUTFLa1Bi?=
 =?utf-8?B?SnM5d08rdXJraVZsRnM2c3M1UXM5UklpYVpRUXZaREhTM2RlVW12T011b2Ez?=
 =?utf-8?B?RjBHME1ybDlPdGYzTTRBaTlhRGNEbk5ncjRSNmZrNE4ydFZrZndPTFYreHJL?=
 =?utf-8?B?dWNRQTZZM2tmZjAyUkNlOWNUMFBkKzVRaysxam9sdkVmZzBvdmJJUFBsTzRo?=
 =?utf-8?B?aDlYaThlYlhkaUFWWjY2VVZTdzMyN01lNVBwdlJzeVJwcjZpWEpWcmM3MlZ2?=
 =?utf-8?B?cVNwQjR3eVdZdHZOUTZpS0VoamhTOXNEKzZxOUltdUlGcG16ajNWMDgyRmpm?=
 =?utf-8?B?RkdjOG00dGxQbXAvU3pXTU1IZElHeXc3TUhINmFGaXNlL1VoUG9CSDVNMnZy?=
 =?utf-8?B?RWZoaUZ1M1pmTnBMeG04ZVFaOWNUaytJQkduNFd4SlRsOW5UZHR2Z2dDNHhC?=
 =?utf-8?B?N1hPbElVTHQvWmJiM1F4VGVsMUZDOTZjV0pjM25lZ1FsMkRXdmx3bzRNTWxk?=
 =?utf-8?B?UlNYOFYwaHNlakRZZlFnVmdWRi8yaUhzTG94TThKWnNWeWNFV0x3dnQ3VjVi?=
 =?utf-8?B?eWRUdy9qVjV1Z1lBMktVR2tVb3IzRVpvVFFpTkhETWczS2EvUS9oZXN1L1Bk?=
 =?utf-8?B?VlpJRzdITTNBQjFKL01ya2JuUzNTVkcyc2RCdDJmSWVHbU9Ibm01UHhOcHkv?=
 =?utf-8?B?MWU3TkpIT002R24zckgxUllTbXF1VnE0VGZ4d2IvVExWRjB2emVwa21tYjIz?=
 =?utf-8?B?TXczd0lCYjFLY245VGpGYS9tN0Z0TVdDUVpPS3c2cHdKdlJBQmIvWFJqUWJu?=
 =?utf-8?B?QklidWl5NzhUemRYckNyZ3VpYkRHT25OazJFL29HMExOcGRTb0NDQVBzTG03?=
 =?utf-8?B?aUxiM2dPdGRJQWdCOEVYRUE2WU1EV1pMMERGdkJWQ2VFU0c4WWxsWWJjZU55?=
 =?utf-8?B?QW8zSVYwMEdkN05mRWVSTStydFRDL3U5ejhrQTQ3UlJWU3hic3FhcmtrMUVt?=
 =?utf-8?B?Y2FDOTV1Q2M3bXVmZkRaWHArYVFoY3dYMWtubTNWOGxEeUlVaWhaZCtiQm1P?=
 =?utf-8?B?LzhURXAxTkxJNGdqb3BIejJwU3dENDd3bngvaXFRTWR2UWZVOUs4citlR0xq?=
 =?utf-8?B?OU9XRlZ1OWVGaVBPdzdqUjRCK2lBVExYT3RJYnBtQnFCQ3NDUG9lOTk4Z210?=
 =?utf-8?Q?GI+st01gwSLkM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVqaWVRVk82eFpSakZ4SmF0Qnc4L013bHlBZE1FT2V5cjR4Q1dkZ01zcUZv?=
 =?utf-8?B?NVhaUTExLzgyQnBNYVVUVUZlVyt1NVlIazUzcjZvVFhXUytvYTF3dGw0TnA1?=
 =?utf-8?B?ZXREMENPUU52RHprU1gzS2swRDRUS2dPUGRib2lzbDlHZG9HR04xR29yODF1?=
 =?utf-8?B?ekRubGRYOW5oL3RZd2lRd2YzSEZJTTBTd2FIQjJGcytqMWJ1VEdDQmhRbnln?=
 =?utf-8?B?RFh3OEdGSFQxbWp2MVBmQ1JaeUozamg3TVI5UEw3UXF3QWViT3dVYk5BNDdD?=
 =?utf-8?B?bFBqVUxSQXV4anNQMDNOS2oyYWwvckEyc09ESldDcHJ2MWRobUQvUjl6OGtP?=
 =?utf-8?B?U05MYVM1TndFenVIbXJxaFAvdzRjWWJOcUhuVThTeXh5MnRUbVp5RDE0ckNm?=
 =?utf-8?B?aFVGemluQXRBZXNVVUJUMEVNZGFySi95MGJ6N203SUxaSUtINHdrS1l2MG5Q?=
 =?utf-8?B?RlhtTU5WYjRLVk9uZmdOU3BFUncycHIzd0xjTUJ6ZEwvQTNyVC9sazJrQnda?=
 =?utf-8?B?NDQ1clF6NnB5cEMrUTRiWmFNQ1UySmpKZUtoQVJ4RHlSVDNuRG1iZlNpcnhF?=
 =?utf-8?B?dHRHc1JXNmtUK2MyaWRJVk01dC93M09IdUVMTGZ5d280UC84M3p2MEViSlhG?=
 =?utf-8?B?UWoxb3ZEbGNlOUt4MHl6OGQwKysxUVBIM2x1bkUzajl6WUN5Ym83NzREU25Z?=
 =?utf-8?B?K3ZSSzVOcWJLMGVBNkx3MWRCQ0ZNZGE2UkE1dVdtMEZYaHFWWHBGMkhlNnJ3?=
 =?utf-8?B?UjNqUUhxMkJvQjQ3YWs0eXFLbnZZMVJvbGNzUHUwdUlaYTluZ0d2Tm9jNWZN?=
 =?utf-8?B?RHFpWms4ZXMydGNtOTMxZnhTTGdHLzFCUEViNlJTYlgySHlXeFNDRVJUcEJU?=
 =?utf-8?B?Y1JQb2orVXlEaENoblhJcU0zMU1xYWs4UjMxeVE0STFNMndLZ0Joam9GMi9z?=
 =?utf-8?B?MUZQOFFpa2VvKzZWa1RQeTlKc3lFWUxIM2cyN3h0eGdkb2Ura3AzdWtUbitn?=
 =?utf-8?B?WmR1aGRsVmo0STdMYnIzZklGTVlVZkZGbU9wUDR1TXNsdXZnMXpSaHBoQVJV?=
 =?utf-8?B?dVVHRnFNZkdWZmdOdVlyQVVxMDc3NW5OT3hUK1RFUk42eFZHU1BRQ1NQVUZ4?=
 =?utf-8?B?TVJQYXJtL1JOQ05ud3I2QUNqVlVYa25lMWFILzJMR0hQQmw2V1dSZ2tqWmZV?=
 =?utf-8?B?R0VkRFpkZWpJaEtKVDgzWURXYnBqZkNuenNDTy9zd1ZPNUkzTE5sN2RyT3dV?=
 =?utf-8?B?MGttWlNtbEdMeEFIZXhSWmVlMUxxdXE5Z3hiRVAxS0FvaFB1aDZjNDQ2OVRi?=
 =?utf-8?B?TEdkaWtjTDh0Z3pCeDhMeXpHdVdMMzFVWFVjSklENXlxcm5mZE9VRnpKbWgy?=
 =?utf-8?B?bk1IdG9YekFkVTlrN2pwUTB0L044Rk9Tb3lldnRLeXFyQlNuSjhsTUxJNXdE?=
 =?utf-8?B?TnpaaWNKV1oyTk8vTU1VSGtrYVB6bmI4RkNrUUM1YWxOSkwwUEM2a3NBU2NJ?=
 =?utf-8?B?bFhPbFJjcWlIYXJsdm9TcGVRZjhSMWljZUVzSFdYOTM4OWNCclFpYTVRZllF?=
 =?utf-8?B?ODRZTnFWYm8yQ2FpU1EraUJucEM0ZFpseXI3aWg2bXViZFBRcmNyVHFaRmVY?=
 =?utf-8?B?cC9lZlRFVkhZcmZKeXg2cnUraDJySko3aDhqQnBFVkgwa2JyV1c0NHpDSDk0?=
 =?utf-8?B?UG1jbk5sWHFtNXNBalpOdnFoNnI0a2c1N0l4eE1yV09LN1JRNmxRTm5hdGlr?=
 =?utf-8?B?TFZOa0IvZmc3bWdmUGZCUnRpQm5uMnJYRlIwWlFUK0lvclRwdlV2QW56a3RJ?=
 =?utf-8?B?YW1TUmRnMGo4VFJoQnNhYmhhdkh3UWJVcVZac2QyNFdOaDhHc2hxUXVVcGw4?=
 =?utf-8?B?VHJ0UVNQcVRxdzlhS29RdVdGdUVWOGcrZlpCSVk5R3dhOVFhdGV3N0wweGlN?=
 =?utf-8?B?VE0vMVhkcERncGFTazkxUTNmQUlIcWNLb3FOWkNPbmRDRC9jeEw1RUtLbjc4?=
 =?utf-8?B?bWZncjNBL1QzZGhHQnNRQW9LNUZnSENzOUpwQ3RtUjFxUXFLVEtFWGJidHRv?=
 =?utf-8?B?L2VwQlc5dFFpN1NrcTV3RG1MaVIzR0JnZ0NiaUQ2WnNOQk1HK05vcFlrVHR5?=
 =?utf-8?Q?Kna0anx6Af+wTblYiVjI/+uaK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5905659b-0c2c-4214-e514-08dd46cb9828
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 16:30:40.2721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AklUJfGIUfXqnvsO+BzFcbRkLboySdWTNJixCiXIuEPdBGuOY7ILPqkqYEigkrRrHvKlJGzjpIF5GkfG93gFvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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


On 2025-02-06 10:14, Lazar, Lijo wrote:
>
> On 1/29/2025 8:50 PM, Eric Huang wrote:
>> In some ASICs L2 cache info may miss in kfd topology,
>> because the first bitmap may be empty, that means
>> the first cu may be inactive, so to find the first
>> active cu will solve the issue.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 4936697e6fc2..73d95041a388 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -1665,17 +1665,31 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>>   				int cache_type, unsigned int cu_processor_id,
>>   				struct kfd_node *knode)
>>   {
>> -	unsigned int cu_sibling_map_mask;
>> +	unsigned int cu_sibling_map_mask = 0;
>>   	int first_active_cu;
>>   	int i, j, k, xcc, start, end;
>>   	int num_xcc = NUM_XCC(knode->xcc_mask);
>>   	struct kfd_cache_properties *pcache = NULL;
>>   	enum amdgpu_memory_partition mode;
>>   	struct amdgpu_device *adev = knode->adev;
>> +	bool found = false;
>>   
>>   	start = ffs(knode->xcc_mask) - 1;
>>   	end = start + num_xcc;
>> -	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
>> +
>> +	/* To find the bitmap in the first active cu */
>> +	for (xcc = start; xcc < end && !found; xcc++) {
> It seems there is an assumption made here that a CU in one XCC could
> share this cache with CU in another XCC. This is not true for GFX 9.4.3
> SOCs. In those, a CU in XCC0 doesn't share L2 with CU in XCC1.
In KFD topology we only report L2 cache info of the first active cu in A 
XCC, which could be XCC0 or XCC1. It is generic for L2 info in the 
certain XCP/kfd node, and not specific for every XCC, so it doesn't mean 
the L2 cache found in XCC0 can be shared with XCC1, it only means there 
is L2 cache in this kfd node.

Regards,
Eric
>
> Thanks,
> Lijo
>
>> +		for (i = 0; i < gfx_info->max_shader_engines && !found; i++) {
>> +			for (j = 0; j < gfx_info->max_sh_per_se && !found; j++) {
>> +				if (cu_info->bitmap[xcc][i % 4][j % 4]) {
>> +					cu_sibling_map_mask =
>> +						cu_info->bitmap[xcc][i % 4][j % 4];
>> +					found = true;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>>   	cu_sibling_map_mask &=
>>   		((1 << pcache_info[cache_type].num_cu_shared) - 1);
>>   	first_active_cu = ffs(cu_sibling_map_mask);


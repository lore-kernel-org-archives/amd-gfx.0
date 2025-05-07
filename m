Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C598C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 10:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1F089137;
	Wed,  7 May 2025 10:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PyWWshcw";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2636989137
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 10:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2rW/nivRTMblzCNss8rYTpA5DM18WVI1vltNhWDAnAqtrkzZO3AMUgHlz6daLqknA05mu1m53tJeHu2+Kl2GsieDAoc3jKQDIju8iu9URvtnYOtMX28EDZUkdW033T8W2uFBZGsI7+E7K+pir+EXc5i5zWZZzt1GzRlXTsiFozDqJj3tTqYW/XY6EEODj8dQJY6hUm2/btzbPqUt+cw9RwrAe/Pl/xiWHpL3X4HODqum4Rw79HBVTpEbb9E2bxkpSm9Z5V6moo5CCpCaYS2q8ugAIiaVBB9DjbYWoOumtRoBUvW3cyJiUZKHBfkxedAZSnHfRQ5jjne34Xt2K+b9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuDcPoNnj3z8BBXQyMM/dQd4TqQ4oMmD9QHF0RPjgaE=;
 b=F9vH6IyChvEuUDx/2HXDWqgAJp6gXfPBa5ZiJNfLfAUmk7n2JcdzOdDSEPzYjwOAo1EZja/hDaFGGD2sCkxjmlr2Vt3xFO6irqomGPsR0SwAHy5d74vzGwMko2AtRA/KHIMwQavCYjKSEdPBTMPOL2NWShBk1GYzLsEbRLxppKgrbOWbymE67zpzbUdHDRNiXwAumJOKt7+FSIB1uxquNwV7dBkzVb7wZgPqtUcuMsh+lp2toTjsRs+B1j66KER3Jr9SL97HQOL5tPXON5Fe0vwL9qcqStaglNZX4NbNOl97MyBKExTrmawgtRz5SBFiuEIme3IHBjRCvwx+uYqm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuDcPoNnj3z8BBXQyMM/dQd4TqQ4oMmD9QHF0RPjgaE=;
 b=PyWWshcw5rVouLUgdRGaBPW9kxC/b1TD1thKFTKW4P12E7uLNUWkTHq00xVT0t+UZlWTzLNbpPXwAvU3cWuBAFRtm6Z6rWT1gRcWWw/cd/o/U5ymt3GnMCWDLWGAN4XSpA1aDzpfqHdP6UBDBGfHoIUCl0AOXrO9zb8rKqeDVjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 10:03:27 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8699.019; Wed, 7 May 2025
 10:03:24 +0000
Message-ID: <5a80dd63-3dab-4117-afd1-b25a2a8d1725@amd.com>
Date: Wed, 7 May 2025 15:33:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
To: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
 <354d063e-ba67-469f-a945-d8c6467f6c11@amd.com>
 <DM4PR12MB59371DC0E9B611C568CE395CE588A@DM4PR12MB5937.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB59371DC0E9B611C568CE395CE588A@DM4PR12MB5937.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf38ac1-ee67-4494-669c-08dd8d4e67a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2dsVkI3Tis3TnRMeWRRUDFRS3EvbEpwRUVUaktWUzRGQTdQaWNVOHJCelJh?=
 =?utf-8?B?UkhCdHJ4Tm9OanVVUitqbTZvL1NDUmVramVjUzZQOXVsQTgzaWRVTkZUdHZS?=
 =?utf-8?B?SVl0T21FeExUenRUc1pBMTcyVTJBdUgwcEdnSWovTnpYY2crN1ByajlicWNS?=
 =?utf-8?B?NG90d0dBa3cwS1JVVW9CeDFPZHowTzJ5cVB6S1kwejgrbjdRdGdndlVtcFNz?=
 =?utf-8?B?T3g3aWQzYlpFaTVGTkFEOWRpM1pRZFN0SjZrNDFmSEtRZ0x1cmtCUkcyTlRG?=
 =?utf-8?B?V0M3bE9LZGI3dTFQSFpYWkJlU3VoT3NXK3FiWHUzTVc1K0dJaUlNdDVSZ0ZM?=
 =?utf-8?B?M3p5UDlLZlhsQkEyejZYRUVWeitKZi9mN2VXOTZkL0U4OHFsNzVtNlVOY3R2?=
 =?utf-8?B?NUFydGw4RXBBS1hreUpVbTZrNldYVitoRkNaWnZGK1o1L0J0cEV2MTUxaDgr?=
 =?utf-8?B?Y0tLWHkvazZXRkJMcGxYUVU4S3pSVXp3ZjJhTlRtcURZZ2NmQmZtcmN3bTEy?=
 =?utf-8?B?TUZLU1REWTBEaStBVkplVEN0VjFXWjlFUFF1dEZCa0pYS21wNWJZdVhQbzFy?=
 =?utf-8?B?OTU5REZUWUlhVEM2dXEyb3MwQTlqdDhqK0NCekRnMng5ZG5OWTNmcmVBZTB3?=
 =?utf-8?B?Y2NnR0didXhnWlMrSmpIcnlqdTRxV21KaURNSGpOUzkwbVpmZmN2WTlqMmRl?=
 =?utf-8?B?ZXdOaEtuVmd6alRmTmZSOEREWkljSmI0TkdCbkxrR3JSdHN6YWZiVkF2NHo3?=
 =?utf-8?B?dTNtV0RWUEtKMFZidDZYdHl0eFRBaXBjcHpZZi9hRTVLWXNvN3pmNGNGc2tE?=
 =?utf-8?B?L0d4TWRhZHRYejFHMzJEZTlwbFAvL2VYd3pXZjlxVWFhS3I2L2psWURqYzhw?=
 =?utf-8?B?L3p0WENyNXdKL093ZkFubkxmcU5zWWNSOUw1TXlwRnRQTDlQNis2WENCL2hm?=
 =?utf-8?B?a2NzcTRkd0ZUdWYyN1E2S0pZRlJPU2UrT2FlVDcxend3eWd3dmcrVk1jVHZO?=
 =?utf-8?B?YWROeDJvQ2lRZ21XNVZxa1lheFNYcEZoaWZyMDI4TE5xVkVsaWZvdHc2TzY2?=
 =?utf-8?B?Q2wzOUhDVE5IeE5OcWdWL2QyRzZMVkpENW5vNzh6YXdrZkMvOFlEZDFrTTJ4?=
 =?utf-8?B?NlRIVk5qNEoxcjVSWEtnYk9HWGNkZEFQbVdyd2RLWUxQZmtzUTJDUU9UOXJ5?=
 =?utf-8?B?bmc0cjRUL05XdGZRcFptajMwQUt5VXV1cUx4aTdaVktrVWFUdVh2Rml1YldI?=
 =?utf-8?B?a012YzFuYXF5aW9scDlMSFZjUVlMU1JMZW1nS0pPOFRzMkJ0d210YXljakEx?=
 =?utf-8?B?ajZLV0R2RnlZVFRxNGR0ZlpROHdSUDBoMUFHY3pDUTV4N2VQK0Y0YlcvNy9y?=
 =?utf-8?B?Yk9CUmJXSENQeUd2SHVtL2t2UGd6OCt6TVdwK2xmb3Q4eCtWcWE4Tm5CQ0lr?=
 =?utf-8?B?bFBoT3hhN1VPcS9jb3hmZnQ5RzJZQ05WQWRWTWwrcWdyRzQ0dm5LazEzdXN0?=
 =?utf-8?B?SCt0Rm1ZaWFSblF5MGRWWFZuNVZzV1ZXcnpMc0Qrc01pRkU3VitaZm1pLzB4?=
 =?utf-8?B?M3hveHJYL2pGRnlwODc0VGRrMHYvSmV0OEU1cEZOcVBuTzgyZGoyOTZIYWNE?=
 =?utf-8?B?Q1VjWGR6QUZXWTAyNFNFNTZ6d0dmdmpoMjYvV2gvbm5mTVgxQm5MSERkWkUz?=
 =?utf-8?B?N2JHTm5rU2RXUTE3eEpWcDJHOGlJVmRyWnE1c3ZNUm9IUC9oUm0wNU1kNUZV?=
 =?utf-8?B?WXZPbkFJNnhlZjBzVW16OHNKRGhmQWN0ZWFuczF6ZFExajA1R1R0U0llaDNa?=
 =?utf-8?B?T2tJL2lJajgzWjkvUjB4NjNocEt3MEI0aDk0RXM2dW9YNE9EV2UwM2tMbFVq?=
 =?utf-8?B?cks4ZTJZSG81MmVVN1I5clg4akxZdWQ0T1NTVjAra0ZwSHlXSlBqK0k3cmMw?=
 =?utf-8?Q?2kSoueywYVA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3JEdDZYTm1IOHErOTQ4MUMzOE9zNnpZUU1sUXdjOGtGMG9oUmdKSUdQRjhE?=
 =?utf-8?B?dTJuQWdTWGU0cThqZm5JQzh1UHVsM0xGRFI0Q3RVSjZ5K3ZrMXIyeG94d3lU?=
 =?utf-8?B?eklFdzQveG1IVWI3VU1NV2ovMEgvQVBjS2s4dzRFc0NVbW1kM1pMd0tSeEkv?=
 =?utf-8?B?TlVrQjNaNGh4UWZsNnZlaVJ6d0pqUVVzV2lLZklLZG43MDlrQWxCcFZBbkdQ?=
 =?utf-8?B?UVlMTGVrcnJEZHVHSWVWeEN4UjV4cDNiaEs0bS9NWTFKSi9BUzZMUTJzNFE3?=
 =?utf-8?B?TXNLRDhXbjQwZUZPR21sNGFqTmJoU2krcUJObXlSVU4yMTcyYUMySFFrRG5a?=
 =?utf-8?B?YUQ0STl2aCtlSWhIcVFIQk5aS3dvQTc2ZGdLaExTZG5wanA0bUg1NU5jRUh4?=
 =?utf-8?B?VjY1WXR4QklQOVNQbEU1ZDRiekJEbjFyc3FFV3pFYXhnZHBPTUpXZEhFTUVG?=
 =?utf-8?B?MGE2ZUJWOTg4Q1NrQkM1eEJxUk1PdDB3VFF0cWRuRXhLdFlBakJOeVVaRi9D?=
 =?utf-8?B?cmRGUGo5T2NxQmIwTG5LQWdWS1hOQnM3ZUJ6STZNdW9jaW1KQ09VMWdLc3g5?=
 =?utf-8?B?aDNZZ0NBdXBDaFE2MWVtUGdYbU03R1psQndJVmVleWxCVy9pMFRmeU5Ka2xu?=
 =?utf-8?B?RmJBOTZhbjhkeGJ0OStsT2d6YVNkWlo5YkN5KzNSdGU2UWpJUTdrc2pNSFNs?=
 =?utf-8?B?cUowNVM4UitzbjVoNUhBZ1M3L0tKOVlnejljUzhUd1g5aXVxSEdMSXFkSFpu?=
 =?utf-8?B?bjJ5V09BajRtbGZ0YWNkU01xTlQrZWxrck1TTTVObU5iVDN1Q253c1Rxdng4?=
 =?utf-8?B?ZTBDV0diL3JnVUMzV0FlWVZaK24yMUtzQ0ltd2I2Yi91Q0VianJmUVZJbHpF?=
 =?utf-8?B?ZVZmVXA0SkJaaDFlYllIOVQ3TzFMRG54eEFSZ1ZDVkRQU2pFMVN1Vm1kdTYx?=
 =?utf-8?B?UlY3Mkp4MHdJSXhGd09uYklPUFNaalZFTm84azM5UTR4NWxiSU9HOG41OG1w?=
 =?utf-8?B?Wmd3OTFOY2NxZ1JVb3lFSlFMU1N1NlhBN2RJZlJ0MS9pT3hCeUplUUdFdkpY?=
 =?utf-8?B?RlBYNFZHTzArMmRDMHA2bTkrRitpTVhmQUtsUE9WRmpnL3RBWFZSQ1NIemIr?=
 =?utf-8?B?UmRHZnZmSVhXbjR0MUd2NXdQMDBnMmdRREJwVCtJZTAvUm9YaHRYOUVSMmgx?=
 =?utf-8?B?Rlo3UDIzNzZmem92ZDkvUlRxL1gxK2Y5M0wyalJ0TUU5ZVpRdDNUUmxWWVlp?=
 =?utf-8?B?bkVqZitQL09HM0NENGF2S1lVTTlkYklkYlMwQTc4Qk1vRWhqWkluUWRaQkIx?=
 =?utf-8?B?ZC9kUTdzSW5NenhMY3NlekFTUUJHWlV5RjVzQi9KbVlWV2JJYzlKZUxnSHV3?=
 =?utf-8?B?T0dwRkhscnpCT2d4bzgwT1k4dUVxY1dwQXhXcGpoa3ZOWjdnTFpVQzYvcnp6?=
 =?utf-8?B?b1oyK1A2aUdWb2Y1WmI4c0FDcVBGQVRvWmFjS29qamE5SU1EWGlSdWJoQ1Zk?=
 =?utf-8?B?bWJrUjR6YWI0bURjTko2Rk9ybk9oekhyQjFLVGtLeTFNVlM1d1RuTCs3amJz?=
 =?utf-8?B?K21BZTRLTU1zUlRUaGdOWTBnVHpBV2drOFY5ZWRCNVBXSUl3VytTcnRWSjR4?=
 =?utf-8?B?TWpwTGQ5YkVOajBRSWtIZHJodUt5VGYwSVJOMjE1NlE0R01TOWFwUElNRGR4?=
 =?utf-8?B?dEhkMzkyYjRqdUdOdHJaM2FZZjFzVmVNcnZ1Y2tpQm96S013QWpsUXBOOFN6?=
 =?utf-8?B?TWxvVWNGcURnY3BySjZZYzRyNmh3R2k0clFGOTV5TVJkdWJQcE1xUDVMYUVE?=
 =?utf-8?B?dzd5NEYzTmo0ODlENm85aUR3Z2xIQ3VSQzNUdDNPZmY0SWV5S1J5UGhlQ0da?=
 =?utf-8?B?aVlKNkFEdVJFYjc1QnFGNVpWK0tpVTArWDA4VUpPQWpmbEdYWkl3VlI2K2J1?=
 =?utf-8?B?aENWckQzdFVzLzg4VE1JRklXeXJWaXEyYTNtN2R5WDB1b0VRTWUwdWcydi9C?=
 =?utf-8?B?RC84Mm9OdElNd2RjSkFod2t3a2tnUXFMYVFzVkpXTHFwSzhmQit0MEJNRkNx?=
 =?utf-8?B?ZU45SVVYcmp1L2c0SFRnbys3QlNMTi9EY0VvQWFqaGQyT1J3M3VOZElTYnYw?=
 =?utf-8?Q?jqQ1zCffp0sy46l6WnIDLz3gV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf38ac1-ee67-4494-669c-08dd8d4e67a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:03:24.6478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaJajkHYC858uKGSDnQm1iVjPt603zKxCx9VF2Tlb0IYEnzMDRMub5nY0LZVZq0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
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



On 5/7/2025 11:52 AM, Zhang, GuoQing (Sam) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> 
>  
> 
>> Please keep in mind that this is not the only scenario addressed by the
> 
>> driver - for ex: a resume sequence is executed after a device reset.
> 
>> This patch itself introduces unwanted sequences for other commonly used
> 
>> usecases. Please rework on the series without breaking existing usecases.
> 
>> 
> 
>> Thanks,
> 
>> Lijo
> 
>  
> 
> Hi @Lazar, Lijo <mailto:Lijo.Lazar@amd.com>, Thank you for the feedback.
> 
>  
> 
> I also think the new code should be inside a check so that new code is
> executed only on resume with different VF and do not break existing
> usecases. Following is the implementation of this approach I can think of.
> 
> - introduce new field `prev_physical_node_id ` in `struct amdgpu_xgmi `.
> update the fields on resume.
> 
> - put new code inside code block `if (prev_physical_node_id  !=
> physical_node_id )`
> 
> 

Can this happen only with XGMI under this condition? Any other method
possible like preparing a 'unique signature' and matching it to identify
if it resumed on an identically configured system?

Regardless, instead of having a direct check, better to wrap it inside
something like
	if (amdgpu_virt_need_migration()) or something more appropriate.
 
Thanks,
Lijo

> 
> Is this approach acceptable? If not, can you suggest a better approach?
> @Lazar, Lijo <mailto:Lijo.Lazar@amd.com> @Koenig, Christian
> <mailto:Christian.Koenig@amd.com> Thank you!
> 
>  
> 
> Regards
> 
> Sam
> 
>  
> 
> *From: *Lazar, Lijo <Lijo.Lazar@amd.com>
> *Date: *Tuesday, May 6, 2025 at 19:55
> *To: *Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc: *Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun
> <HaiJun.Chang@amd.com>, Koenig, Christian <Christian.Koenig@amd.com>,
> Deucher, Alexander <Alexander.Deucher@amd.com>, Zhang, Owen(SRDC)
> <Owen.Zhang2@amd.com>, Ma, Qing (Mark) <Qing.Ma@amd.com>, Jiang Liu
> <gerry@linux.alibaba.com>
> *Subject: *Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id
> and GMC configs on resume
> 
> 
> 
> On 5/6/2025 3:06 PM, Samuel Zhang wrote:
>> For virtual machine with vGPUs in SRIOV single device mode and XGMI
>> is enabled, XGMI physical node ids may change when waking up from
>> hiberation with different vGPU devices. So update XGMI physical node
>> ids on resume.
>>
> 
> Please keep in mind that this is not the only scenario addressed by the
> driver - for ex: a resume sequence is executed after a device reset.
> This patch itself introduces unwanted sequences for other commonly used
> usecases. Please rework on the series without breaking existing usecases.
> 
> Thanks,
> Lijo
> 
>> Update GPU memory controller configuration on resume if XGMI physical
>> node ids are changed.
>>
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++++
>>  3 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/
> drm/amd/amdgpu/amdgpu_device.c
>> index d477a901af84..e795af5067e5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device
> *dev, bool notify_clients)
>>        return 0;
>>  }
>> 
>> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
>> +{
>> +     int r;
>> +     unsigned int prev_physical_node_id;
>> +
>> +     /* Get xgmi info again for sriov to detect device changes */
>> +     if (amdgpu_sriov_vf(adev) &&
>> +         !(adev->flags & AMD_IS_APU) &&
>> +         adev->gmc.xgmi.supported &&
>> +         !adev->gmc.xgmi.connected_to_cpu) {
>> +             prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>> +             r = adev->gfxhub.funcs->get_xgmi_info(adev);
>> +             if (r)
>> +                     return r;
>> +
>> +             dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>> +                     prev_physical_node_id, adev-
>>gmc.xgmi.physical_node_id);
>> +     }
>> +     return 0;
>> +}
>> +
>>  /**
>>   * amdgpu_device_resume - initiate device resume
>>   *
>> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev,
> bool notify_clients)
>>                r = amdgpu_virt_request_full_gpu(adev, true);
>>                if (r)
>>                        return r;
>> +             r = amdgpu_device_update_xgmi_info(adev);
>> +             if (r)
>> +                     return r;
>>        }
>> 
>>        if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/
> drm/amd/amdgpu/amdgpu_gmc.c
>> index d1fa5e8e3937..a2abddf3c110 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct
> amdgpu_device *adev,
>>        if (!mem_ranges || !exp_ranges)
>>                return -EINVAL;
>> 
>> -     refresh = (adev->init_lvl->level !=
> AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>> -               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
>> +     refresh = true;
>>        ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>>                                            &range_cnt, refresh);
>> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/
> amd/amdgpu/gmc_v9_0.c
>> index 59385da80185..1eb451a3743b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct
> amdgpu_ip_block *ip_block)
>>        struct amdgpu_device *adev = ip_block->adev;
>>        int r;
>> 
>> +     r = gmc_v9_0_mc_init(adev);
>> +     if (r)
>> +             return r;
>> +
>>        /* If a reset is done for NPS mode switch, read the memory range
>>         * information again.
>>         */
> 


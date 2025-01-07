Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717B8E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 22:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A35910E7C8;
	Tue,  7 Jan 2025 22:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vb1Tsj3v";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C0410E7C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 22:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0u7qE7DgQoWal+V368H0D+/Zkm4lHWhGFrbIpgdmVligKJIgq5eYKfAEpp1/yrfrZ9nQ8iZdW31zrbfFTUEkruQGVmuHsinRKaD3G4s1DQN8r6qqjmiNGQMHpti6B3tO+GEJkoomxPGBZgZ2CI1MRyEpS/HXyL6hOVAaNTUFYGuToKNU8ZRmPTLFV19NLtl+ouzvJJt6RFmu+mR2m6towZ36yN+6IH0kJNSLh0Vmd+UTYJtzYYWkZXQ1kBeFnM1jXZL4VHi6Kc1p+8KyuiiZwiTzXyiVyXJQAzEUv77tv+Enz8p+ve/vXvcB5RfPXln8eN0OlxRplunSC0+MoIP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peg1xmkC3J0PfQqZpqIE9G3+Yz/Cqb8GMNy7qgifPg8=;
 b=sB96DFkqoxYEo6fkEK+5qcLmmU88LqBEf3/u5QIhPC46WciEsft8lEsJGlcBZ7/9XOCYtEV16Qphe50IS3QM5uxFaisx3TEDgTJhsw44zZtcAy/AEWfACnVdkx7inKqRmYEAuCao9sswMa2qcnKSnOI7BQTF/AZsrJnbiY0td7exNCxgwK74ARspWwEIObidhIvlsCYFNKfHNa4q+5RMGf7UCxRXb3P2KrsZ7XPQwcZtrkLG3xiDuCOAJUJ7Vb9iOp3sTNOtuNUd+lpkYprFrIIL15lIGNPHVts8xxCJcLT3y72OzO0ncFitiJP26G7L6kfZDwWoD0jVtax0TBGFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peg1xmkC3J0PfQqZpqIE9G3+Yz/Cqb8GMNy7qgifPg8=;
 b=vb1Tsj3vSAz+ad8thFaURyjaq3ajI4dvskbWRISM/i8V6gBnMHBHGTzsPZ75vFn4iFMsK198weKPE8aU5dHJhgRJrEXSPAOzS3N/wZXBe04Lvn/s3xVW5j5vGBXVN38lXt1AMOpQXTdyQ3QF4aXET68zEVYLJkM5JVuppQOQKwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:53:12 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 22:53:12 +0000
Content-Type: multipart/alternative;
 boundary="------------HC054N5zxk3fXCH6t092efCc"
Message-ID: <995bdc6c-2051-400f-b717-38cbb645aa8b@amd.com>
Date: Tue, 7 Jan 2025 16:53:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] amdgpu: fix possible resource leakage in
 kfd_cleanup_nodes()
To: Jiang Liu <gerry@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 lijo.lazar@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com
References: <cover.1736044362.git.gerry@linux.alibaba.com>
 <70f5963233c8a34354ec8a9efebc3a7b4c7940d4.1736044362.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <70f5963233c8a34354ec8a9efebc3a7b4c7940d4.1736044362.git.gerry@linux.alibaba.com>
X-ClientProxiedBy: SA1P222CA0116.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::20) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 53436d3f-5211-4ecc-77b8-08dd2f6e1047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RSt4Q0wwcFB6WHBzdUp2M1FsanJEbms0TnJoQTJFR3ZtZWtCZXpXaStCejNu?=
 =?utf-8?B?WHpnT0JIcmFLM3AvRG9YTndnVTk3allTeVNlQjgzMXZhem80Wk9ZMWxkeGxi?=
 =?utf-8?B?Rm5jTTZoWmdZU2NqVkJ0ZkJCdUFoMjhIbUtXOUR0QlZBd1h3NEZsRzdlQ04x?=
 =?utf-8?B?MTdDWDhtS0k3Ujl2c0szeDZpRTRWWFF3aXFqVGlRWEhRUm4xVFBWTG54N2pZ?=
 =?utf-8?B?WDc4Y2FNSTV2YWNDLy9oaytnL2toTzBqTnp4UjZQNlh0bkF3M0F0Tm9BUnVj?=
 =?utf-8?B?TlNFMHdEcUt2QS9MRUpqUVZoOVJUY3RYdWZraGt3SUhBMFhFTnJVeGlVdGJl?=
 =?utf-8?B?V3F2M05sZWZFYWJxdEc0Ujc5NStMMFpyOFduRXd2R21mMW1MVGpuZFBoZjNo?=
 =?utf-8?B?V0VtLytlQnJieXVUNUdJTkF5TGQ0eFBFZXV6Sy9MUlpxNU1SN1lQWFc0Nzlx?=
 =?utf-8?B?MmozWGUxK0daNFpPTFlkUCtreWdndTNSZnFrOTV5QXZTai9XYUlzOUtQVjhN?=
 =?utf-8?B?NnlNWVN3SGNJYm9BNVFNVTlsU0I1c1c3a2VZdFcvZkZSSVlTbnp2N2JJWkpT?=
 =?utf-8?B?cGt6UkNld01ETncvYytnbVpuOGQyak4zWWFiQmVnL3dxUmNCU0k1UDk3WVQz?=
 =?utf-8?B?RWpLZ0RUYUpmbGIveHpVUjg3MlAzczlub1RxQzBKOEpIUUZrMGhRdDZIVnhX?=
 =?utf-8?B?dDhRTU1aaDFxMUtDRDEzb3hLNklmVk5LaU1SaThzWUxpRk1LQk44Q2tnU1pD?=
 =?utf-8?B?WnRsSENtdnVyNUVRQStTZ21WRlVPVGx5eS8wbm9SWThSdlIwMm9CTUsvVTNR?=
 =?utf-8?B?Nk1EK2ZpUTJBRlpnY2VrYlE3OFkvZmdHdncyc1JpeFRIUlNONy9pY1AwdTRZ?=
 =?utf-8?B?ajJ5MXU1VDlmeXViOWhrWWF1dEFWQzVWanZvNVVabmJYZTl5dW1CcnkxclJw?=
 =?utf-8?B?UmdnYzJoTFFSZzh2cnR0NGllRnY2akN5NGEvckMwS0pCTDh5ZmcwMnBKNkR5?=
 =?utf-8?B?NnVSSTl4RHpWWGtWc1dlSEUvVndwbk5JcEczamZ2cUpjYlJmbEtGQkp3OS81?=
 =?utf-8?B?bDA1VkZLTkxjYk0vS1d0OU1BNFErU2ZyR1F4VUtQRHdkL1pKNzhPNVB1dmhh?=
 =?utf-8?B?QkFKTEhxTW5EaHB1RHM4L1VUQlBkVmdQWTZPYjVFVVpxeGwweEwvSzUrTHBt?=
 =?utf-8?B?MTA1Sm1yU2RZcU1MVWxRRDA3cXFLVUVXNWFZU3piQmxxVEhuMVBSQ1lNUTFB?=
 =?utf-8?B?NzZ4cVJyc2JQSWhlOHlBcnBBcU1uSm50b1BZYzEyQk9iYnh4c1ZDWDlQWXR4?=
 =?utf-8?B?Q25ubVVlUnJ4aGpJWmtVMlByUzh1alY4N1Voa1p0QlY0M21tM290RW1uYzhV?=
 =?utf-8?B?UVFsZHNQbjBNM2dxUHhteUJxVmdPS1RHWWpzYTlKM3JYRENhQUd1R21RaEc0?=
 =?utf-8?B?Unc4c05KU0V6ZHRXT3BjQm0yRHBydGxqbXJvdk1nenJnMUlEeEFwYjlqR2RJ?=
 =?utf-8?B?VU1IUFpYNHZxV3NSU1lCVUZuWFFmQmtNcDdIa2xKUElzVi9GYW8zNHNiUUp5?=
 =?utf-8?B?MW5hY3djSHZqM0NDWnNqYVpmb1BMWEZUMC96UU91VTBKVUFORzg3TlpBWjdZ?=
 =?utf-8?B?cUowYmRXTXgra3JtZnhZb1BGM0NIWHBKaVFrUEp2K3N6S3hTeGU2dXRmUFFZ?=
 =?utf-8?B?VFpISEkreTl4M2hMUmovQlJiY1hJbFJsU1JhaEFMUlNBY3B1ODdwV0NVQXpD?=
 =?utf-8?B?WnIvMUN5b1ZJbE1MVjZaV0dhMzgwYzBuM2YrOHVLNmEvSm1ia0tmdWFSOHRE?=
 =?utf-8?B?YnVURVg1VTU0WVNhTSs4SFZtZ3ZpU0FqNCtDZ2k0MXhKUXUyQjNud1B2RGZq?=
 =?utf-8?Q?XefUiTBSQ0CFW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEQrdFc2OHIvdE84Rk1XWFRMVVFHelFYdEUzS3FQTkhaeHpBZkMweGR2N1Fl?=
 =?utf-8?B?Y2E1Y3J4NHRVaW1MQzFQQUYyVUpmRGFjeWsxb1libmJUdmlRUUFBQmdFVkpl?=
 =?utf-8?B?S3B6Nkoyc3dGYnFWYURDWVNqZ0xQY2xFTXZ4czVHNlNMMXRvNzdPV2lwWmlO?=
 =?utf-8?B?bEF6Ym9QY3JvRWlLYlNOR3VsbFJPbXdVV3NIM3YrK1lZb1lNMkFIUUl1czcx?=
 =?utf-8?B?cWE3bTY4RzJJbkpJWDlXcDlaRHNIM2pqOXRhd0k2L09vYnRkRFZxOWI4aUVK?=
 =?utf-8?B?cDZMTXNwc1hMNzVqZ1VuUFQzODVYeXVGRnpqQkNPSi9STm9TUG9IWjQyQ3dx?=
 =?utf-8?B?eldTUU9wTHZBVVBQUnJtem5xeUV4Q3JLcG9uKzhmNkZwN3IyTVN6MzJqZjFQ?=
 =?utf-8?B?d3M2QnJKWjhyMDFYaEhLNjFySEtTVGwrektlb0Z0eVZiZGorTE5mM0Jod2Q5?=
 =?utf-8?B?eUIyNWJUV2FmbzlPWm5ScmRTZ2hlWElyY3FsSG0rT0dCN2xXUnRpcDl0eE56?=
 =?utf-8?B?VkZnRUFIRDhUeGRyM0pmV3pvL2loMlBpd3hzZXpnSC9oTjNrbHBwVGdsRDBV?=
 =?utf-8?B?M05haGRaUmZ2QmtYaE9haEtIWGIvZDlJTXpsM3hlN2ZmMnR0akJwMWF5MWdK?=
 =?utf-8?B?c2hrdHEwYjRLL1FOSGw3OHJkYWE0TUt1OG1RNVhZNHY1SmNHckM2YTkxdjQw?=
 =?utf-8?B?RFA4ZHE0QXE5RUQzd1pISVVodGZTUmVIdkltdTNEcDE5VlFtakdFSVVwWS9F?=
 =?utf-8?B?SEQ5OFVIaDRTbElSWVQvT1h3WjBrdHJ1OFd3SysvWkJYTXVDRzRNUTJkVThh?=
 =?utf-8?B?K0FycnhLcUsxTExYeXh2ODlLUUo4RFEyU2xSNnJyUHFCcmhHdXN6TWpTU2E4?=
 =?utf-8?B?NmdBVVVYNmNUM3RlenZwd0lad2NKRW0zTGRiV0FjeXh0cXdiSWwwTVk5Tjh5?=
 =?utf-8?B?NHpYbGtrcTNwamZlU2NnUWphd1dpSlg4R3Jub05Tb3k4STljWmozYm9ac1Vn?=
 =?utf-8?B?SVdtZE5Ya0VSNk4rSkR2aUpyakdud0dIcU1US0NoUXZpUkh2RUVnYlNadk9S?=
 =?utf-8?B?UFA1MXdOcWZGck44d0lCRFJlcDUraGtTVDZxTWJwYzFaZjdlYVBxOHZKWmdU?=
 =?utf-8?B?S2lycFhyTGlvWC9NTlJodWpmd0FPTC9aZC94bC9reW9CdmtmZFFUQXhkeWx5?=
 =?utf-8?B?WUQ5SDUzZDdCU2xxWjBqeDdTRzNZZ2l4cFdIYXdIQnBya0RVQ0JIVGxHdU5p?=
 =?utf-8?B?VzlpMEs4Y2Y4MGY1L2pUME52VjZrS1FFb3pNcnRrOUY3NVpwcC8xZ2dVS1FQ?=
 =?utf-8?B?SjdaV3pCaU5WVnpRaEdPbldTTytmNXpvZExieDNpVlZPbUFxMks3ZVpES3RF?=
 =?utf-8?B?UjhTWHI0ZGpSeDcxTWR1ZkhqaDNveWVyZ2dHczkzZ2JJYTFrU0FSb3c2eldN?=
 =?utf-8?B?aWVWbWtjMEJ5V3pXTGwzcENHQjJkeFd4WXl4N2w5enFVOE55NVR6eUQvL285?=
 =?utf-8?B?UmJaOTFMUVYvUFdBOUxkVFNEbWptRm9jc2FmNkhJcFphSW1YWk05U3pzaVMx?=
 =?utf-8?B?Yy90VElTcHB0TGtYVnVweHYvaEIwaGw1Wm1SN1M3aFhRS2kxbVhEQzQyWVgr?=
 =?utf-8?B?L1U1RnpSaFQxeGd2TWFLZWJqQUpsY09sa1FKYm96MzhRR2w0eE1TYXFxMDJH?=
 =?utf-8?B?WWNQL3ZmQ1RPaXdxSVZEZWpCNjlBdXBoZ1paWExNeDQzOGZDMzNPRGQ0WGpD?=
 =?utf-8?B?eE1OMk16TFBKYy9SSU5rL25pM2FRYXg3UU5oQmlLZnROT1Z1UXFiaFozSTNK?=
 =?utf-8?B?ZEszUUVsRzB5RmlscDlsMS9objRmSTFLK0hicXREUjUxUzFweVhuMmMvWUY1?=
 =?utf-8?B?QlJsOXhObUVkeTR5aUhJM0xFdG9MYjlUR0F4aXcvRHRNLy9NbVBsZ1ZxZVN2?=
 =?utf-8?B?MkNtK3dsRk5SbkdFelV5SFZETUV6ZmVWSXRmZllGQjRUVHBGSmlPNVVQQ2RB?=
 =?utf-8?B?TGNxWlZFcUdmWGxlSmxjUktXZkFEaW9Gb04wTG5kT3pSMzBEb0xRWlljaGdV?=
 =?utf-8?B?ZHY4THpIVEV4cE15ZXFUb1dMVnlhK09OaE5SeVRoUGErUTduZUNIK2pjL0xa?=
 =?utf-8?Q?WRKw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53436d3f-5211-4ecc-77b8-08dd2f6e1047
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:53:12.3972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pW/KmknGkHK1baiH6LZojUl6sAsw1ZbppMOFgyext/WrmRuXo4YFkeabOFBGUYjV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
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

--------------HC054N5zxk3fXCH6t092efCc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/4/2025 8:45 PM, Jiang Liu wrote:
> Fix possible resource leakage on error recovery path in function
> kgd2kfd_device_init().
>
> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index a29374c86405..fa5054940486 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -898,15 +898,15 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   		if (kfd->adev->xcp_mgr)
>   			kfd_setup_interrupt_bitmap(node, i);
>   
> +		spin_lock_init(&node->watch_points_lock);
> +
> +		kfd->nodes[i] = node;
> +
>   		/* Initialize the KFD node */
>   		if (kfd_init_node(node)) {
>   			dev_err(kfd_device, "Error initializing KFD node\n");
>   			goto node_init_error;
>   		}
> -
> -		spin_lock_init(&node->watch_points_lock);
> -
> -		kfd->nodes[i] = node;
>   	}
>   
>   	svm_range_set_max_pages(kfd->adev);
> @@ -921,6 +921,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	goto out;
>   
>   node_init_error:
> +	i++;
>   node_alloc_error:
>   	kfd_cleanup_nodes(kfd, i);
>   	kfd_doorbell_fini(kfd);

I think this change is not right: if kfd_init_node fail it does clean up 
for the kfd_node that it is initializing internally. kfd_cleanup_nodes 
does not need to clean up the kfd node i which failed to init, just 
clean up the kfd_nodes that were initialized previously.

Regard

Xiaogang

--------------HC054N5zxk3fXCH6t092efCc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/4/2025 8:45 PM, Jiang Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:70f5963233c8a34354ec8a9efebc3a7b4c7940d4.1736044362.git.gerry@linux.alibaba.com">
      <pre wrap="" class="moz-quote-pre">Fix possible resource leakage on error recovery path in function
kgd2kfd_device_init().

Signed-off-by: Jiang Liu <a class="moz-txt-link-rfc2396E" href="mailto:gerry@linux.alibaba.com">&lt;gerry@linux.alibaba.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index a29374c86405..fa5054940486 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -898,15 +898,15 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		if (kfd-&gt;adev-&gt;xcp_mgr)
 			kfd_setup_interrupt_bitmap(node, i);
 
+		spin_lock_init(&amp;node-&gt;watch_points_lock);
+
+		kfd-&gt;nodes[i] = node;
+
 		/* Initialize the KFD node */
 		if (kfd_init_node(node)) {
 			dev_err(kfd_device, &quot;Error initializing KFD node\n&quot;);
 			goto node_init_error;
 		}
-
-		spin_lock_init(&amp;node-&gt;watch_points_lock);
-
-		kfd-&gt;nodes[i] = node;
 	}
 
 	svm_range_set_max_pages(kfd-&gt;adev);
@@ -921,6 +921,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	goto out;
 
 node_init_error:
+	i++;
 node_alloc_error:
 	kfd_cleanup_nodes(kfd, i);
 	kfd_doorbell_fini(kfd);</pre>
    </blockquote>
    <p>I think this change is not right: if <span style="white-space: pre-wrap">kfd_init_node</span> fail it does
      clean up for the kfd_node that it is initializing internally. <span style="white-space: pre-wrap">kfd_cleanup_nodes</span> does not
      need to clean up the kfd node i which failed to init, just clean
      up the kfd_nodes that were initialized previously.</p>
    <p>Regard</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:70f5963233c8a34354ec8a9efebc3a7b4c7940d4.1736044362.git.gerry@linux.alibaba.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------HC054N5zxk3fXCH6t092efCc--

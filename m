Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D39EC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 08:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060AC10E51D;
	Tue, 22 Apr 2025 08:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Hd5Sz39";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADCEA10E51D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 08:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GR30/8Phjw+Iyfhegzyjf6RUQ1HE3n7mslb2n9Sma1aWdqpYejtlBe7i8/bTvpn/15hEKnZYSwNhVV4mFaHr1J7hH+z0dId2zfPjoUnqQR1fVjtaGajrDpidJFAeW+NZV5fk91HuzL+7Cx1cxieQ8XA7MC4GcqPYpJo5UPpdalvUS2RhydeahScJupdqGoDjWBV1cfyV89fIPamDalq/eKHMC/6Uszo6ceISniDfaRb5Xtu82OpXmToUanJJv83ER/sZMEtTVmBuC9i3F4otPeYPnLvG/D8ijo6h/eAnYDiAVJdUZ7hT5W6SiiFpUGRDY17kDITiZnmCxtHNh/J3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dplEak01DVObtuWpprCiD/5AsHEzd991IZGOxGTOPts=;
 b=S3XjCkNmizZcXMOeX/RvrrZGzS6q/0MfNsIdi7wagq0jtWakmfYgx+IVq1aNH27Tes2tlhnB4uXTLOZMYovWEts014pq1W2fnrunLfgyx1MXzO6zTGFbh4UTetTbNKPxh2vkBoUqpWi/f/TaXdHczOXnBOmMd11ZtngX4B0bRVYvneAAfzcgvYM+TgwpP9JDnKq1/vibzC0QaYzYVJHqPzb3NGUk+dpTsrDhtPFnSZrBSllL0Zkp2+uDs4pIg3VdLrYFmUgZLYxlpcIXCJrzsAVzLHQA+zBJIJWtMoWYOzEvdb7KxnUPpwEJr0slojcteNpC/2FCdGZQxO+SaKRs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dplEak01DVObtuWpprCiD/5AsHEzd991IZGOxGTOPts=;
 b=5Hd5Sz39pXiqXMnTlB7zApKqgcq+iD+su97Ruy9vY8b/LR4IgevUzX0mJaNWIQj48+dantSBvu3gduk1gVT96T74z6DOemWwRVQ6nBuEgc7hCm26vFCKEvE84NHMLh4I4pgoTVhv/PQTjG3KvH8m+Ss4gAs07fTemqcfvfN4AuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 08:06:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.8655.025; Tue, 22 Apr 2025
 08:06:02 +0000
Message-ID: <730ddd76-052b-4ae8-8745-26bc61c2622e@amd.com>
Date: Tue, 22 Apr 2025 10:05:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fail DMABUF map of XGMI-accessible memory
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250417163707.1288027-1-felix.kuehling@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250417163707.1288027-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: d34906db-45ea-4a92-d326-08dd8174862b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3MxdGNHeVRFRVlMY0dwZFhxanlKQ3E1U0p6d0ZNQW5RTzcvV0tldlp5QlNl?=
 =?utf-8?B?RXc1UnE4QVpudGIwem92ZHA1UmluaGtzQkR4RWlBRk1mSG1EdTdGQUNrVkh3?=
 =?utf-8?B?ZkJhc0ZzeUovdEk5SXh1TXFHOVRVbVcxbTZXZFR5bG1kK2RMblNKb251M0FP?=
 =?utf-8?B?S0docTBIdkFEUk5TeTg2QU9zK2pLVmFMUmQ0KzNqaGdLRm84aGkxNHhOdjZM?=
 =?utf-8?B?OEprcndpVlpLb3BIanZIdy9temRzOTY3NjVjNjkyV3hLeFBud0Fyb3JSVUVY?=
 =?utf-8?B?SWFYRVhaNlROdjBHRGRxNmZ1Q2NhbjBOL0E2Zk1qYTZtWWtCeU51NDZRZUdx?=
 =?utf-8?B?WG1kT0k0bDlETUU3MnRmNWdmYW9aWWd2ZFYycEFLWDIvM1Q0Y20vTFpTd3I1?=
 =?utf-8?B?ZGZpcSsxUDNUalA3bjdFWjI3VW9GU3VSQXhyZnZQSXh4REVPYW1jaEgxcDZt?=
 =?utf-8?B?NU5kVWVUUjgra3JZNTliV0ljbzBXaXI1QlVKK0Yzd2xhUHk2VGFrcGZLSEZh?=
 =?utf-8?B?RS85V2EyRGJXamdHYkZwTC9XQUdPTlFJdzlpVDhYRVBDRzUxR1B4SWdFcUpa?=
 =?utf-8?B?MzVrMXNiTGpzOFUrQVlvUlBTRVhwbEJnTm85MzdxT3RoUSt4K1hmSzY1NXpk?=
 =?utf-8?B?ZkNVSzNqUVFUZlJWcGJ6SWx2N2VDbEF1RCtDU0N2aVdudk41amc4dHB0cE54?=
 =?utf-8?B?aFJaYmRZQzNKNEFXU3ZXeTBqVlVabU1ub0NhTGR5d1g0a1ZpNHdTd1EwTlBB?=
 =?utf-8?B?dGJiZ0YxckJaSWNSNGtFLytUVGl2aTFtSzI1TExsdmR3SEEzK09GU2EzK1ZI?=
 =?utf-8?B?V01CbGlaVUdvV1lSTDdNUkY1Vm53aWc1aVAxVTVGM2VnSnd6dmtmQTRkbXU2?=
 =?utf-8?B?bm9lNzBtNWJnTDQ0RmlKOFM2V2MzczJCbHZBUXhXYk1WMVNNZHZGUDlCempU?=
 =?utf-8?B?TEJoc3VRSlRjWUJlQkxmWGt6ajBqY1lMN2FDT2FuZVNnVHR3YWdDTFVQbnR2?=
 =?utf-8?B?TDBjd2U1Q08rSzU5ZzRhQWhwSnZUdzJPVXg5ZW5Ec1R2WXJLREpSS1AxZVA3?=
 =?utf-8?B?QmtoczJ6OG5pNFRMdy9ZYW9kZVBSL2Ntbm0xN0d4ZkpVRnhiQ25DT01JanFN?=
 =?utf-8?B?RmNFUlc2dUFxQTVDR2M5N0owVml5Ulp4a1ZodndrcGxVdmhlWHNaQlplNDNh?=
 =?utf-8?B?RDM1Y2FRUU9DN21UMGFkL3ZEOE96YU9INE1UelphcUJFMjJvdm9BUis3VDlx?=
 =?utf-8?B?aXpHU296a2ZZWDA0MFVwdCtuV01qR1hXbDdYNjBva3RURnNHUUNjeWp1Si9r?=
 =?utf-8?B?R1VxaU1JTUpEWDMzOTlLb2JpNkloaEZxZHY0OGJqekpLZUdPNlUyT0REREVI?=
 =?utf-8?B?SklQa05JWmdJZXBicnB2dGttU3dTN3Y3YWxNM0pWRXBIVXdPTTVnd1k3VWtR?=
 =?utf-8?B?cGhxY1NPVHRkZVBnMHpYWUc3TTQ1SktaL0tDd0UvNmFCZmpQRHliQk5qZkpJ?=
 =?utf-8?B?TEtLZVpEVmZzQVZHN09mOXkzNDRYSGk3NmRwYldVNDlWeGl1Q0RsQUFNRFJC?=
 =?utf-8?B?QXlTMTRMVDZVcFpGZEpFRElieWx1YkFrcDJ5emNNMWZQQlFvQ2hWem1YVmh4?=
 =?utf-8?B?ZUh0WUlJRVZiSHVRTiswbitEUTM4eVpBRWlLc1NNTG5OMG1Fa2dZRmZBK3JS?=
 =?utf-8?B?VnhPU2lMMlFEa3hYK3o0elFxaHlRRDhTM0o3OUV1RkJ2ZXB0NGg1OHNnQUR3?=
 =?utf-8?B?N3JMVEZaRmFOZ0Mvc3Raa3ltMXdZTnhBbFdjY0dva1Q1WkRQMEI2NUJLUUJw?=
 =?utf-8?B?Rk0rQjdLdlNEMlRNRmJQNEhzUG5EN3lCZk9TNm9lUTMxaTkxcFRUQk1nUnJM?=
 =?utf-8?B?RWlVblVPZGJPZFYzMlhFVWlXeWprbEZPaTlSOWhmOExsdllzL3Q5V1N5Umpi?=
 =?utf-8?Q?iNjx/VuXj3g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJvMWQvb09tdVQzOXdPdGdIbFBQYmFIbzZINTYyNlpSOXd1NThVR0V6aU14?=
 =?utf-8?B?L0hYMUlGdGs5NmFLQTJnckk5ZktDUXdoMWJteW4yK3BUOVRTSjk3dmhZZ3ph?=
 =?utf-8?B?UnY3Yy9EUTRydmx1VVJteEY3ZEpzdFF5UXBHVWpWeUZPS0VWeUJsVmtVT1Nq?=
 =?utf-8?B?dG1ZaFIxMndQZVh4WjlrTWFQZ3NNWXVtWXlhbnRjckRBV2dYbE8yYWw2M3ND?=
 =?utf-8?B?Z2ZlV3ZFa21DeWZybVZJNDlsaUEzdXdnRytqWjNrWDRmR04xN1l3T2drb0hN?=
 =?utf-8?B?TWdReTBuMEFCblgyelo5MnZNdGFUbEwxRFNmSDQzeWt4bDhmeWlJemhTZ1NL?=
 =?utf-8?B?WUJFQytsN3VBTjloTzRIRXQ0anNFY2RUL1VlSWVlRXdkYXFPUFNKNzViM25R?=
 =?utf-8?B?MzdXZDVXMzNrY0tGYmxTd1VSZEhXTC9qUWRXVVNFak1NTzVPVG54K05CUDYy?=
 =?utf-8?B?SGRzOE92SlNhUThJTTR3elBJNm4yQzV6VlIvSm4wNGZHbWNhTGVsQU84clF6?=
 =?utf-8?B?VjJqaE1lOHNDWnZpT3B0b09wTFNoNTl1K3BHd2hoNzZWT2E4aG4xZUJmTXRt?=
 =?utf-8?B?bzNacGlLeFpwM2cySnR0dHozYXlHc2pVRGsvb1ZUbHp5NGFSSDFjWTlGdEgw?=
 =?utf-8?B?enZMWVJHQXpXb2VWQ0MzR2owVS9nd2F5dWZGQlpJL3VwbGVwZW1GdGY3VUwx?=
 =?utf-8?B?blVUTXNYYklzVCtsNC8ycThmalNkMlZsaWtqdlZ2OFFmUkg5RlFXOERYQ1gr?=
 =?utf-8?B?Y3lNczRpVEMrWlAxOTlrb3JmOUE2L216eUJHYThGa2hFblc3SFlxWWRSZDBr?=
 =?utf-8?B?c21sZ1hiRUkvdy9IZlpHdy9KblZQU2hpVGpJYnVzbVZXcFdvbEZXZ2ZNY0Q4?=
 =?utf-8?B?dndEem81dVdJd3lLL3Q5SlRUbVEyZHBRM28vajN4OHU2MmcveHZldVdreFZZ?=
 =?utf-8?B?OVo4YVNpK0xyOU5TNVRUUThIdWtzc2NuSytpNTF2QlI2S1pjcHRFd2c5aEEv?=
 =?utf-8?B?SW5ndkp6Tm1qT2hyNUxQYThJSnRvTmJUeURWSFp1dXBPNkQ4RGloWjVrdERy?=
 =?utf-8?B?Y2xjRHRZdG9NalJ0S1JmdjhxT1FYb00vdVhHdUdHOXdqQjlEek54QXRpM2xq?=
 =?utf-8?B?QjAwTFI3elY5SVhKTHBVQVVQRTV6MmwvbEd0aDVPSXU5OUg5Q0VwNHFnbzRC?=
 =?utf-8?B?STRpclBlYWMxY2tKMEtWc2t5dEovK2pkYUFIaHY2dXpTV0hodVR1RzVSaC9I?=
 =?utf-8?B?c1F3Yzk1K1lpSDhmQUdMaUxqUXRUblV1TXdlbVR0citCeHJoUk5sVi9iSkFI?=
 =?utf-8?B?b3M4c0ZkdTZjWDdJcHp6cC9iRCs4SzRHczhUaXJTaUxpb3VXWGV4bVhTVjFV?=
 =?utf-8?B?dFdCV3hSTEttLytVQ1ZRdVdwYzRJc3l4VEVPU0dzN2FIenhFZHZCU1BZZi9o?=
 =?utf-8?B?QnkrUUVYaXg4V21iRU9ERTN0ZXYwc0tyVXR1Y2xkYzZBUG5pWHFZUXk2cFhK?=
 =?utf-8?B?VzVYdHpMdWtZQkJZS1dnaHhXc3lUUEVmRG02U2owbHJVY1VGWmNjeE5rc2hM?=
 =?utf-8?B?TUJ1cE5vRTN5WUFmeHA5OXVaS0pDTjdJSXFBeC9DSFNPRHIzNittNzBia0xX?=
 =?utf-8?B?M3F4Z1NrM0ZaWHVFUXM3Qk5VNzN5YXkzcEF2cVR4Sm85RFMvcnRnVlpvLzh4?=
 =?utf-8?B?VUF6cDV1Y1BKclBwNXg3NkRPTnJwT05xeXluZ3ZtaDhVR0lDZTZCNStHY015?=
 =?utf-8?B?UTlFd2ZmaVI4UkIrMCs0NW03bWNkdXlaWklyTEZwWE1SdEF5YjFVTnhIZERm?=
 =?utf-8?B?OXlrbmRWMVFSdHpkVUFDdUoxVjZ1dnoxNitnU3ZiMW1wblYzTVRyTXVFTm0y?=
 =?utf-8?B?NGZJSUVaa2tRYW9kSEw1cC8rSjVMV2VQeTdIZHhsN1pqVEwrNCt3OGNVVDI0?=
 =?utf-8?B?dTByZTVpNGx0UjdHVXFBRHp3OHdUUGsrbzNlc2Q4dlg4OXBhMDJOSHB3dHBF?=
 =?utf-8?B?eUE0MjZoQ01mcFRzSDI5ZUgyTjkrYThXU3pTN2dSVzFCWUxhUE9UMnJMV1cx?=
 =?utf-8?B?MENFNG40L2grdU9uWTFBdGhyN1pCczFMa3A1dGcvQWhidFZzdytmUDllcG01?=
 =?utf-8?Q?3dR8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34906db-45ea-4a92-d326-08dd8174862b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 08:06:02.7077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAk+4AQ2n2lXpmpCKk3sGfluETWkEeMiqk2WzSlcgMYzEO0Ih81Uv4VRqZc/7n+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
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

Am 17.04.25 um 18:37 schrieb Felix Kuehling:
> If peer memory is XGMI-accessible, we should never access it through PCIe
> P2P DMA mappings. PCIe P2P is slower, has different coherence behaviour,
> limited or no support for atomics, or may not work at all. Fail with a
> warning if DMABUF mappings of such memory are attempted.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index e6913fcf2c7b..44e120f9f764 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -199,6 +199,11 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>  		break;
>  
>  	case TTM_PL_VRAM:
> +		/* XGMI-accessible memory should never be DMA-mapped */
> +		if (WARN_ON(amdgpu_dmabuf_is_xgmi_accessible(
> +				dma_buf_attach_adev(attach), bo)))
> +			return ERR_PTR(-EINVAL);
> +
>  		r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
>  					      bo->tbo.base.size, attach->dev,
>  					      dir, &sgt);


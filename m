Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8968C05052
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 09:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C5D10E0BA;
	Fri, 18 Aug 2023 09:02:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F036310E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 09:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKvDjKEjBXfK+vUTjia2la3kuqKqB64WHENuw84UBMAwyYHCRaUSjAkYX2yT1Ioo3gJQSO2rek6MDTvQemQtKZ+9z3UCmaig3cGB2SDLzxtoO/YsdDpHMB85mRzFN3IqGFF8Wrof+ENlXvlOUgmwMAmeb4y17NvkwNN+TdZhuo4JkIKaY4svjTkV1/7k3Tvxl7IAsK9xb2LXkdC5Ru9d5IrdrnYR7faGaF0EBCOBvEBAntGD0XSm4pFRWbUTJUCr9uzrK8c4zhdUPlvSIYg/fTx+6IP+PKYKpcxtx2Gr3yCpfLXK1ZENtabXOeFgTGTFLPXItqPfuc44PYuLwylrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upfP59o3iYVQMHB9dmzzxFo1+9ZQoQ857QHGWzbChNE=;
 b=nOPfrUlcbZwluIpqtVExo5JtYmmv/PmaxuENNp8u4j1NP2x2q8yXtyrdP3Hnbx+Z8B+gMY4S3fVdEat7lebJ6RE5c/h71zSEqKN5e14GiZpKBlQCxmnsVOYSSI4xtqIO1PTU27w5fy3HSnDBsj0py8IOArP/ph568jhOAXEvFxYh15a+b3qNPVj7MN5fdKJFhaFMTEmKZ3unJeYIWa5MNOrOOvmR2vHWyb1cKDAAnh/YQdFd8hOcw86h0LUkMpFMMwAL75kWDUimM6mXG6//TTz3IvCdx+4tmaLFMLYOamfEIKjwEnSY30bEB0f49ctWR1ddOpkraxekHzfxcydUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upfP59o3iYVQMHB9dmzzxFo1+9ZQoQ857QHGWzbChNE=;
 b=3tknpREH+5mWSiNcRKGf3ltZhaD4b8Nksj778tAJm0AxLHDY5bxSdUL8Rs0/mdYMz/C/1teoi07dlT6wQipeaHPF/lJWPaoCpYCp84g2Dd2Haavm6X+/LeVhC9pz0AcEAaBdTJdFrHo/ftm0cH9ZiCxOPt/5WprAVTtX4rGw/uM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 09:02:06 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 09:02:06 +0000
Message-ID: <4501482e-3279-2597-d8d2-469f4cd31c26@amd.com>
Date: Fri, 18 Aug 2023 11:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amd/amdgpu/amdgpu_ring: match type used for loop
 counting
Content-Language: en-US
To: Joshua Peisach <itzswirlz2020@outlook.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <MN2PR14MB332833921E3C32103154BB23B21AA@MN2PR14MB3328.namprd14.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <MN2PR14MB332833921E3C32103154BB23B21AA@MN2PR14MB3328.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 07761bda-2feb-4a90-7409-08db9fc9cb64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cm8ZXwXZ1dkX6y43BqFA/7OspUI+et0HFuWvxZM7abBsuDk5Pld5iIphCswQ+nEOEFCDcAKA0wqtJBaXBULcGePdPPSxlYMSvlb/W5UqtPA0X63XcOqtUD2eYDfxg+1Gn0EOydwIonsG5h+byaiR/ekky0tSXlCHzYQvTdhkQNVgI+czBDB11h4xR4peaJukRod9aAxvHoVFRHUldsWoa/vlHcQl6OJ+9OPslAClipMzWD2WZTQp/AKAACs9fQ/4sBMdSoMhDhLduGGSfYA4/bcx8RR8XPDXeV4+muqXZzrNuN1RhsFGIjB7eWqLV63vsUYpaDs6p7Xrr2DYOQ35HRo+zIOfqFehOEMxLMfjRb0+1Y2PcSjTqzGFpZrTU7mA05bgtmDutSbwmV0dkttCN/autK3pBKzUcW1G/GhSuEQWWHE6ExzWXIxMF0Ivrxw1KCr6Pi0WvGFUpN/eux05h5CjQJqaaBX4wGygpSg6OOp4MIH+iBKn7u2rUwOatzjB0GPf3cnvYKMVH0nvMkDnO1UwP8Z7+gQOffmuBWBsSinQlfbiJZUwEPKxF1H0YsckDGw342it9txU5yYtuuDG+5I2ZgkZTpezQqSsNxWMVkEUHZhTYMaHzj5XLc8FOivQRLSxNl9tp0FVFApNjvrFGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(83380400001)(66556008)(66946007)(38100700002)(316002)(66476007)(478600001)(110136005)(45080400002)(2906002)(41300700001)(8676002)(5660300002)(8936002)(2616005)(6512007)(6666004)(6506007)(6486002)(26005)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXpBZk1Ub1FYNjRZRmFuOG0zQ3FhZHJwUDd2ayt5Y09aa1p2cTQwekdlK0Na?=
 =?utf-8?B?Q0xHVEpFakt6MTNzY253eDA5NDNRSUlFYW9NSVJZaWZibWZWemdicXFEZWxa?=
 =?utf-8?B?UzArWVp5WjF6K0xvUTJOUWMvQkY5RWdLWFVrVHBzUlEydVNmbmF4eXRCRlZu?=
 =?utf-8?B?SXNOL2pmSGswejE0eFYwa2wwOUNFcVlqbXpkcGtyb0hzZmhyY2xIcU1JZ0Qz?=
 =?utf-8?B?Ky9wZmpUbFFtcmtnZ3pNdE5kTjljNEFWb3d2M1ZnREtIYS9SWXl4VWNKb0tN?=
 =?utf-8?B?bmRmMy9FWVNIdFladjRLSlNCbGl0ZkNvMUZocjV4c2Q2UGpVRjR3azYvMFdu?=
 =?utf-8?B?anhHNktITEcvaElPN0NYbWJlRytwK1ZYZ3RMUmlkZkptaEc1eG91d0c5Tk8y?=
 =?utf-8?B?dHFwbEpzdTVidzZkdXV3Z1NEK3g1TXlzMkdzaWhaWFUxRFJRNzdIUzdpdDI3?=
 =?utf-8?B?NEkvYTVjRkhmOW5oQkdkUzJNb0RhMnIvejR1eTF0V0c1SFhweFdJS2R6dEZD?=
 =?utf-8?B?WDZ2R21VaVVGeE56V2paQWg5N29OeSt3QklucC9PbWdvanlxdW5FcitjVHN3?=
 =?utf-8?B?Z3YrU3ZJSU1JNkxpRjJ1UkpUblJRUHBhQWd6c0U4Q2xQbjVnMi9lZmJVaEdU?=
 =?utf-8?B?NXlGWHpOcnZOVUx5c05SZDJDdE5NQjNObGRrMU1QQXdFOFpyV256andwR3RO?=
 =?utf-8?B?ZmJDQWx5Nml1SmR1NWdUU1FJbEFvYVNyTE9CSkZ1VDNGb0szelVCRlhIRGsr?=
 =?utf-8?B?Y05sRW5SK2V3MXNBOEtmclFwTU5jeWRydHpoTXhXVFNnUVhQMFBCdms1UnFv?=
 =?utf-8?B?RERLWkNtYmFqMUVzQzdYRnV3czJCWElzQUxkWXRkNTFuVUdkV2VlNm0zd0Vq?=
 =?utf-8?B?WUcvMU1PTTEyMTdYRVd2eVZRNVpqRjhQQ3o3bThsSm9JNEl0Y2lhelY4eGYr?=
 =?utf-8?B?YWRNaFVDaWl5TkRCakNRWVdQQktvMXhCUmdTZ0VnMUwyNGFjK3pocHlkd3I2?=
 =?utf-8?B?bDRTOXhTWis3WUwyaVlNNm50dTBwMmhuOEZFL1N2Y1JVV0JtUm82V3hnbDRY?=
 =?utf-8?B?Y213bmxVTUJUb1l1RDNSbFNDWG9HblgxMGZhSlFQejQ0ckZvYWZRN3orY1NZ?=
 =?utf-8?B?bElHY0NGZjczN1NEZ1VMWGZLVHpkM0hzWEtCeEZ4aDBjdkJrVGJtc1ZKN3Mv?=
 =?utf-8?B?dzVhOENiNnRXUWMxQTdJc0dhcUNJTTkxS055UmpseHorcFA4M3lxRll1dGNP?=
 =?utf-8?B?RDFOK1pFdWNrQlZJU0tIaEx3Z3lkazhXNEM3aytFd1QwbTkxQzRLdllBRW1z?=
 =?utf-8?B?anBDRW9hZUM5d0lqWWc1OGJjVTRWOHRVVFp1RkovSDZ1aGRCb2YySFZQQlZQ?=
 =?utf-8?B?NEk0WHBXbnR1czZ3R0g5QUd4M3AxWGJSM2lnay9VVkpSbWNSRlVJQ2tjUzBa?=
 =?utf-8?B?b1phb25hQ0VpeDBPd3VxYXgxNGpMT1RiaGFOdnF5V25oT05VNUJscEZFUUk1?=
 =?utf-8?B?dzF5YlVWYTJPeHV1Vk1HTWdlSEJjVnZNU09KRCtIcDV0TlJsR2hEa0MwVWhR?=
 =?utf-8?B?TlJac0NocTJDNmE4L1V4bE5qT2ZQekl1TGlnK1NtSW5pWHJsaVdaMk44dkpZ?=
 =?utf-8?B?YTIzQXVONDFQVFNHcDJPQ05ZZEp6N0V1dWlnNFdlV0ZERDBSZ1NabnBYT3d2?=
 =?utf-8?B?UTd3eDhPL2VKakpjNEt1R3kyeDZuS0c4SUpsK05rUEtPSmRHRjJtc2JCQ3Qr?=
 =?utf-8?B?UWdGbllyMW8yS1dTdXlJTUlFUUJVS0xEdjFoUzBXSys3VXJDcEZBbjdCOXJW?=
 =?utf-8?B?NmMwN1pJREE3MmlNRjR6OWpJdGJpMHR3bmtrWkhzVjhGRWh6YVlTaTNVWit4?=
 =?utf-8?B?cHB2U1BsdDRtMHpIZlVoUnVieTVGTGRVdm11ZmQ2ZkdadCtMMlAyVnB0dW0w?=
 =?utf-8?B?VlVWL2VWRGl5RGcrVEVieXVJS20zcFJRRU5FNWp4TmZmK1hxVTZMNWdMc1dN?=
 =?utf-8?B?T3l6Nm9DNWZ5ZWc5eXpqKzNJVkdzSzFjcmZGTGR5OWRDTmtEUU1zU3V1VnVR?=
 =?utf-8?B?elFlalBDUTNGbUFjNC9SUWVlV3JZeG9zL0VjRlVrNER2aTVicHZ1VDg4aC9B?=
 =?utf-8?Q?caVC+IDcHlm4CJqpKCTM5qflt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07761bda-2feb-4a90-7409-08db9fc9cb64
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:02:05.6580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJ2hVXJ4/p89HgW0ge7/ywAgyB6v//4o47DCFLIZPnKeip86Y5JKubHVLK+3wjMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
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

Am 17.08.23 um 21:42 schrieb Joshua Peisach:
> The argument passed to _insert_nop is a uint32_t, and the loop
> counts to a regular integer. In the event of the argument being
> larger than the maximum integer size, the regular integer would
> become negative, and never reach the count number.
>
> So, match the type to prevent an infinite loop.

Well that's not really necessary. The number of nops inserted could fit 
into 8 bits as well.

Christian.

>
> Signed-off-by: Joshua Peisach <itzswirlz2020@outlook.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 80d6e132e..273894441 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -108,7 +108,7 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>    */
>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
> -       int i;
> +       u32 i;
>   
>          for (i = 0; i < count; i++)
>                  amdgpu_ring_write(ring, ring->funcs->nop);


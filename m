Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65400C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 14:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED1910E09C;
	Fri, 10 Nov 2023 14:30:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4136D10E09B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 14:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mou5JFjrrTIEo7cw7E7348qeQGIBXtdQ5PA8PBrBRKSETCDJmx7fwXI+KBL+GNA2//PY/4NSg4vARd64bhH7XzQW3ru54s7H7nT2xgLs3QgmnJFuRA+yyYwL/lupEkFfCEDu1VEgN5BZ8fEp2T1vZF7UYJG52saqo0TVHmIrzKuaIcn0QR+OoeQgOXsGYCiBdsGKbQbhxkXSVtsursm5gdO9kBI8cjFkOIPkQLBW1R+FZnGzAEaXamhmvsr9qCtOozb07NuqTVXxfzw/m2Q3QdsccBtbptT3z0uHd3e8c9t6akZr2zFIfpvlvmbPqXF9zPkWLB+Apac/TDUG51EexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7lMnP3lbK6K4fe7NQKKUWvI6iDcHOEN5AeUVdP+vXA=;
 b=dKl+UOPkW3vnoarjdhGGzXpejNDv7ygpRYHISXWFLU/xFNgzn6gWOFdhuE5yWacr3uZWybFaE809zYmiJu5fGNtzssGjxM8VgXC4mgxbkEkCi9rSQgUJxCqrI4CD+vscSnjiFgoFB+d0smQwlcs6gz5Gjt1vHXLO5q3lq/L//rURBkw7geWrU+UuyDfGxRhBcHwhmv939EN1ERPK+ilocs4XypHc7vZ/BbQMIyyHAA+GyJOEzWCvRre0sOo7OdvlyBOy9TH5Us/7yaMP6eFlur/Oomv5lBtxUvaQjcuIoGl/1kmdVt5os7pjVNHphTWhZFq8p7un0buc/nECHWN7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7lMnP3lbK6K4fe7NQKKUWvI6iDcHOEN5AeUVdP+vXA=;
 b=sBKwCe3AUfxkvgy2uwZCnLKiB9fuDOmyyjQwu+S+7+3WjpHH84TYS/qvDIpk/RqXLsYD7HaDvWYct71ZV4HCiN4euObHMhQ/7ywrcZbVc2OPTY5FlgbUIp66+RNEMRmi1jWrBvEePbtGVa/pBYsnfGDievdLB2LBEOQ9L0Z9z50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21; Fri, 10 Nov
 2023 14:30:49 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%6]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 14:30:49 +0000
Content-Type: multipart/alternative;
 boundary="------------yqH8Dw9rABKMAJFESQrRAKtf"
Message-ID: <a5a370f0-674e-4cab-b86f-be6dd0a268a3@amd.com>
Date: Fri, 10 Nov 2023 15:30:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset
 for AGP aperture BOs
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231110125225.2512174-1-yifan1.zhang@amd.com>
 <82453041-8033-4d14-be82-ecfe7fce9f27@amd.com>
 <BL1PR12MB51448085CD4ECFAD5D00779DF7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB51447D133B187D557131B8B7F7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <64d13d64-d745-47da-99c8-3f941fe52d72@amd.com>
 <BL1PR12MB51446545ED2B94B3F82BEC9BF7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB51446545ED2B94B3F82BEC9BF7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: d14747dd-5e71-4f3b-1834-08dbe1f9a26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SZRlkYOCaDluL/jtog+sJaLsv6LCvFuy4PQ+JqQ3tyNniz3EPAhK8+yehWdDilsPFOVOtRmvNGF65blNDe3A8NClWQ8QdeTHVgcIKYuPoUgz8mz+QuR29zdRN8sk8t1JtIXLOSJQiuK4Z3YPCQTTvghAlzfTKQXKs0Ov/63bVrpGavcJftvL0nTwAfsY274b1KtRy+xjdjVhkF8YI/YipiaSozvW9tsaPY+5raP1C2eKJTkED4H/DVMbN9sVNRQoReFX8cpeh9k2kQ/VH7m7CFhx4OwXYByczoPxMZhzX18DhrFGbtil4h8df+pf34zfPFMzCuDX991VmpX73pHf+m0QSMGv+5VbNX2UbtRSk5h0taCdgQbv8MFXo9PwGXFjXzxTEi/uvq2sH1IdVsUphSiLV3oSEhtAZVNbqo8BBXWc2i8B4IBo3G4iSXubjny9OHXaGO/7vmaymbbNJCFPM52wmyeXnLqqzVjhbFJVJ01h3n2xYAtAW4JFYhJ4YKFN6tVb0YAqChM2qbXK0QY7zwvUb7M1zsQ4hQrQzzHhKJgiDK592v4FDiAaSV6sPGFqoPVtKeqsrNNV9QL1qs8NL44mBPy4dHk2Howt1GP597pQcXuyaLByxhEpwJpPHWVPYB6YMHOLAemc4nwhJv+sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(30864003)(5660300002)(41300700001)(2906002)(83380400001)(26005)(19627405001)(8676002)(4326008)(8936002)(31686004)(316002)(2616005)(66946007)(38100700002)(66556008)(66476007)(110136005)(53546011)(6512007)(33964004)(6506007)(478600001)(31696002)(6486002)(36756003)(86362001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUtlTVRsRjZnYW5PTFlRcVNwUFVIbXBqblFOOTlkejRvWnBOdE9kbkhZWHdj?=
 =?utf-8?B?RWp5Zk9EMHNzTVVqa2ptUDFVN0pSaFNMWlhhRUs4bktWcUowSklqN1hLWnEw?=
 =?utf-8?B?a0ppNnFYa2VmdUcyOWNYNDFLWnlxNVp2WGxxRXBmSTE2d3B3eEZUeU5WQXZK?=
 =?utf-8?B?dHJWM2xESFFnVU1aQ2lYNUxVTWVhcTBzRG1NUzFsaGRMNGxaK1FaY0JVNjBo?=
 =?utf-8?B?QXU2QjZycTg4ZHQ3d1BDNW0wODNZSHIrZUdFc0tGNzdacGRPbXhqKytDcjYw?=
 =?utf-8?B?cGM3NzUzTkFJRFB1Y3JDZkVROG56a21XUVRDMDVtWUdZT1hWMko2L05qWHhj?=
 =?utf-8?B?YjIyWXhDUTVVRW45bExpVHJmRTVDNVVNNjlFcTFsWEI0U2hRSno5U2FSTDFD?=
 =?utf-8?B?eHJVM0wyZE83SFIzbU5QcWpTcldjU1A1STRNVW9pV2htT2ZpR3VlbDFVNEpw?=
 =?utf-8?B?emUzSTBjMWsrakRqbEZWTUwyNkRCZzRkdGhDMVZud0kreEdCSEhEM3lmYVg5?=
 =?utf-8?B?MENIMC9QRG9GNkg5SVVlUmdzbzNTa09iWlZDbFJoNzlyWmxBZy9Teis2ai90?=
 =?utf-8?B?WUxqelY5cjFVdVU5OG41OElLanVvZ3dhdmUxRkhodVExQ2FTRVBtaFFCWnRD?=
 =?utf-8?B?bkozY2N6SDBMTXVvWHhPb0EwVm54VTFLaGxIUFNPbUg2UjBtZU1OSThob004?=
 =?utf-8?B?Qy9BbTZ4OWcwWitZSlR3eXhrSjMxd2lnbDlxRzNtRFZ1bDluc0tYRkJGVjQ4?=
 =?utf-8?B?QU03VTVXYVN4M1d4UTR4M1hsREhMYU5mMWlzWjVSNkNvdTFZTUdYNXZTSm9I?=
 =?utf-8?B?YzIxYUhrZjZHUThuUWF4ZFZKTjRobmE5L0RIY09kNGJacmMxbHo1ZW40eThJ?=
 =?utf-8?B?ZWV4LzNHU1ljdFNiZ09GSWl3YWpBUGlmcEs3VWx3bGUycHlWUFpPUWc2K0Mw?=
 =?utf-8?B?c3l1NVY4L3U0NFNaOUdZVjNDYkpLc3hVNjNVVEZRVkcwV0p3cHdhTExJeTZP?=
 =?utf-8?B?YUlzdnhVSTUxRU43MHpSQUFKZlpHTTZBQlJtMGVnSDRaNXFsS1BPVGlDb3N2?=
 =?utf-8?B?UmhkSnh1NzF0a1VIWWV1UGtKc0RkS1BtSTNRNVBxdDFXY3gwZ2NwaEQrRUtP?=
 =?utf-8?B?YVdCN3I5WTJDNnpabHN4SG9IcXErb3dYWUpCbjVxQmJyQXA3ZENZcFUrTlV6?=
 =?utf-8?B?c0YvUFEwYVEvMWZVWkpscUVUYkRIVm1JcUNSVFFGaUlpVVplNEZWOHBtVlM5?=
 =?utf-8?B?cHo5RjZ2UmhvNnhNTExMQzRUYU0xNFhjMlVHMXNMQVA3L2Vub3lXM0IxK3VD?=
 =?utf-8?B?cCtPb0syUlF1eTl1YlZLdWxCMkwvVGM1Um1ndHJEN3Njd1drdEhMZnNIQWEw?=
 =?utf-8?B?Wkp0alNXdXY4cWxONXV5bnZwMjl3UFFpc0xQbjdaSnlSSWEwUllqS0xtV085?=
 =?utf-8?B?K3M3Rzk2d0ZVOGRreUZPTzZheHdobVhoOXc5b0ZIVmY1OU9HKzlvWW9kbFE1?=
 =?utf-8?B?VFBRbzd1S3U1dlJSaU1zcWN0Ri9YQlpsWHo3TC9XV2N2T0NrYjNjcDZTaFlw?=
 =?utf-8?B?TElYL2pVb1JFSkVodExRUUZkZUJNV05jNjNjZXMvZkJWWDlKY2lwSjNreFBy?=
 =?utf-8?B?RVBiUG9FOG8rNmRjY3ZjRmpub2VrMklmYlNoUWVVbXpqZHEySHVGSGx1M0Fp?=
 =?utf-8?B?dXhkQUVGRVhIUys2czh3dWl4aUtPa1FucUR6Z0dvMTBZZysybzd6L2l0Lzl1?=
 =?utf-8?B?RUphMzlLWmFyTEJtQlFwTjhiLzgvRnFaemQ2ZXl0QkpJaklpaUJBWElBc2VQ?=
 =?utf-8?B?K0ZwSlc2eEI4anVVU3BiMGkyd1h6MCt1MWFiOGRpQUpYV0t0YWhRZUJCZ0VM?=
 =?utf-8?B?ZjlIcmY3d3dtNjBxKzBOVGpGdzRDclJlR2E2U0dJNzJCc3VBUmk4Yk5SRjEy?=
 =?utf-8?B?RmJZR25GVFRTQTR3d1duOFVFUVRYd3c5b1dickFNdmNUNmw0WXhWUjNxaHBm?=
 =?utf-8?B?ZHl4bEppZlpPbTBnMVhUU2Z3M3hOanM2VHVleXRHdGFVdFUydnE4U1QrTHlk?=
 =?utf-8?B?R1lQMklnQU4veFR6VXYvT1paRTRrS1ppSUpUMVZPM2lDVmt6MVRpM0xiL3hy?=
 =?utf-8?Q?XqofCrgM+hIUJ7x65bwwhHVnf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14747dd-5e71-4f3b-1834-08dbe1f9a26c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:30:49.3374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVsgHiRSy3JtOr+/F2g1DH3RU4ULqCcm6zXjhcUhHeGs5MVQJ/w1CXLBKXM30fh6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
Cc: "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------yqH8Dw9rABKMAJFESQrRAKtf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Just call amdgpu_gmc_agp_addr() and check the return value for != 
AMDGPU_BO_INVALID_OFFSET;

The problem is simply that we can't cache that result anywhere because 
bo->resource->start is essentially the offset into the GART and not the 
MC address.

That must have been sneaked in years ago when we removed the MC address 
in the TTM BO.

Christian.

Am 10.11.23 um 15:27 schrieb Deucher, Alexander:
>
> [Public]
>
>
> In that case, how do we know we can skip the gart setup in 
> amdgpu_ttm_alloc_gart()?
>
> Alex
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Friday, November 10, 2023 9:20 AM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan 
> <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: exclude domain start when calucales 
> offset for AGP aperture BOs
> No, that's broken as well.
>
> The problem is in amdgpu_ttm_alloc_gart():
>
>         if (addr != AMDGPU_BO_INVALID_OFFSET) {
>                 bo->resource->start = addr >> PAGE_SHIFT;
>                 return 0;
>         }
>
> bo->resource->start is relative to the GART address, so we can't 
> assign the AGP address here in the first place.
>
> What we need to do is to drop this and call amdgpu_gmc_agp_addr() 
> fromamdgpu_bo_gpu_offset_no_check().
>
> Regards,
> Christian.
>
> Am 10.11.23 um 15:17 schrieb Deucher, Alexander:
>>
>> [Public]
>>
>>
>> I think the proper fix is probably to just drop the addition of 
>> agp_start in amdgpu_gmc_agp_addr().
>>
>> Alex
>> ------------------------------------------------------------------------
>> *From:* Deucher, Alexander <Alexander.Deucher@amd.com> 
>> <mailto:Alexander.Deucher@amd.com>
>> *Sent:* Friday, November 10, 2023 9:16 AM
>> *To:* Koenig, Christian <Christian.Koenig@amd.com> 
>> <mailto:Christian.Koenig@amd.com>; Zhang, Yifan 
>> <Yifan1.Zhang@amd.com> <mailto:Yifan1.Zhang@amd.com>; 
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> 
>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>> *Cc:* Zhang, Jesse(Jie) <Jesse.Zhang@amd.com> 
>> <mailto:Jesse.Zhang@amd.com>
>> *Subject:* Re: [PATCH] drm/amdgpu: exclude domain start when 
>> calucales offset for AGP aperture BOs
>> It happens in amdgpu_gmc_agp_addr() which is called from 
>> amdgpu_ttm_alloc_gart().
>>
>> Alex
>> ------------------------------------------------------------------------
>> *From:* Koenig, Christian <Christian.Koenig@amd.com> 
>> <mailto:Christian.Koenig@amd.com>
>> *Sent:* Friday, November 10, 2023 9:14 AM
>> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com> 
>> <mailto:Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org> 
>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com> 
>> <mailto:Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) 
>> <Jesse.Zhang@amd.com> <mailto:Jesse.Zhang@amd.com>
>> *Subject:* Re: [PATCH] drm/amdgpu: exclude domain start when 
>> calucales offset for AGP aperture BOs
>> Am 10.11.23 um 13:52 schrieb Yifan Zhang:
>> > For BOs in AGP aperture, tbo.resource->start includes AGP aperture 
>> start.
>>
>>
>> Well big NAK to that. tbo.resource->start should never ever include the
>> AGP aperture start in the first place.
>>
>> How did that happen?
>>
>> Regards,
>> Christian.
>>
>> > Don't add it again in amdgpu_bo_gpu_offset. This issue was 
>> mitigated due to
>> > GART aperture start was 0 until this patch ("a013c94d5aca 
>> drm/amdgpu/gmc11:
>> > set gart placement GC11") changes GART start to a non-zero value.
>> >
>> > Reported-by: Jesse Zhang <Jesse.Zhang@amd.com> 
>> <mailto:Jesse.Zhang@amd.com>
>> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com> 
>> <mailto:yifan1.zhang@amd.com>
>> > ---
>> > drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  7 +++++++
>> > drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>> > drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++++++--
>> >   3 files changed, 16 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> > index 5f71414190e9..00e940eb69ab 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> > @@ -169,6 +169,13 @@ int amdgpu_gmc_set_pte_pde(struct 
>> amdgpu_device *adev, void *cpu_pt_addr,
>> >        return 0;
>> >   }
>> >
>> > +bool bo_in_agp_aperture(struct amdgpu_bo *bo)
>> > +{
>> > +     struct ttm_buffer_object *tbo = &(bo->tbo);
>> > +     struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>> > +
>> > +     return (tbo->resource->start << PAGE_SHIFT) > 
>> adev->gmc.agp_start;
>> > +}
>> >   /**
>> >    * amdgpu_gmc_agp_addr - return the address in the AGP address space
>> >    *
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> > index e699d1ca8deb..448dc08e83de 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> > @@ -393,6 +393,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device 
>> *adev, void *cpu_pt_addr,
>> >                                uint64_t flags);
>> >   uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo);
>> >   uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo);
>> > +bool bo_in_agp_aperture(struct amdgpu_bo *bo);
>> >   void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct 
>> amdgpu_gmc *mc);
>> >   void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct 
>> amdgpu_gmc *mc,
>> >                              u64 base);
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> > index cef920a93924..91a011d63ab4 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> > @@ -39,6 +39,7 @@
>> >   #include "amdgpu.h"
>> >   #include "amdgpu_trace.h"
>> >   #include "amdgpu_amdkfd.h"
>> > +#include "amdgpu_gmc.h"
>> >
>> >   /**
>> >    * DOC: amdgpu_object
>> > @@ -1529,8 +1530,13 @@ u64 amdgpu_bo_gpu_offset_no_check(struct 
>> amdgpu_bo *bo)
>> >        struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> >        uint64_t offset;
>> >
>> > -     offset = (bo->tbo.resource->start << PAGE_SHIFT) +
>> > - amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
>> > +     /* tbo.resource->start includes agp_start for AGP BOs */
>> > +     if (bo_in_agp_aperture(bo)) {
>> > +             offset = (bo->tbo.resource->start << PAGE_SHIFT);
>> > +     } else {
>> > +             offset = (bo->tbo.resource->start << PAGE_SHIFT) +
>> > + amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
>> > +     }
>> >
>> >        return amdgpu_gmc_sign_extend(offset);
>> >   }
>>
>

--------------yqH8Dw9rABKMAJFESQrRAKtf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Just call amdgpu_gmc_agp_addr() and check the return value for != <span style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; color:rgb(0,0,0)">AMDGPU_BO_INVALID_OFFSET;<br>
      <br>
      The problem is simply that we can't cache that result anywhere
      because bo-&gt;resource-&gt;start is essentially the offset into
      the GART and not the MC address.<br>
      <br>
      That must have been sneaked in years ago when we removed the MC
      address in the TTM BO.<br>
    </span><br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 10.11.23 um 15:27 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB51446545ED2B94B3F82BEC9BF7AEA@BL1PR12MB5144.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">In
            that case, how do we know we can skip the gart setup in
            amdgpu_ttm_alloc_gart()?</span></div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);"><br>
          </span></div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Alex</span></div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Sent:</b> Friday, November 10, 2023 9:20 AM<br>
            <b>To:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Zhang, Yifan
            <a class="moz-txt-link-rfc2396E" href="mailto:Yifan1.Zhang@amd.com">&lt;Yifan1.Zhang@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Zhang, Jesse(Jie) <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: exclude domain start
            when calucales offset for AGP aperture BOs</font>
          <div>&nbsp;</div>
        </div>
        <div>No, that's broken as well.<br>
          <br>
          The problem is in amdgpu_ttm_alloc_gart<span style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; color:rgb(0,0,0)">():<br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (addr != AMDGPU_BO_INVALID_OFFSET) {<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;resource-&gt;start = addr &gt;&gt;
            PAGE_SHIFT;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            <br>
            bo-&gt;resource-&gt;start is relative to the GART address,
            so we can't assign the AGP address here in the first place.<br>
            <br>
            What we need to do is to drop this and call&nbsp;</span><span style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; color:rgb(0,0,0)">amdgpu_gmc_agp_addr()
            from</span><span style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; color:rgb(0,0,0)">
            amdgpu_bo_gpu_offset_no_check().<br>
            <br>
            Regards,<br>
            Christian.<br>
          </span><br>
          <div class="x_moz-cite-prefix">Am 10.11.23 um 15:17 schrieb
            Deucher, Alexander:<br>
          </div>
          <blockquote type="cite">
            <style type="text/css" style="display:none">p
	{margin-top:0;
	margin-bottom:0}</style>
            <p style="font-family:Arial; font-size:10pt; color:#008000; margin:15pt; font-style:normal; font-weight:normal; text-decoration:none" align="Left">
              [Public]<br>
            </p>
            <br>
            <div>
              <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                <span style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; color:rgb(0,0,0)">I
                  think the proper fix is probably to just drop the
                  addition of agp_start in amdgpu_gmc_agp_addr().</span></div>
              <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                <span style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; color:rgb(0,0,0)"><br>
                </span></div>
              <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                <span style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; color:rgb(0,0,0)">Alex</span></div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Deucher, Alexander
                  <a class="x_moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                  <b>Sent:</b> Friday, November 10, 2023 9:16 AM<br>
                  <b>To:</b> Koenig, Christian <a class="x_moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                    &lt;Christian.Koenig@amd.com&gt;</a>; Zhang, Yifan <a class="x_moz-txt-link-rfc2396E" href="mailto:Yifan1.Zhang@amd.com" moz-do-not-send="true">
                    &lt;Yifan1.Zhang@amd.com&gt;</a>; <a class="x_moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a> <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                  <b>Cc:</b> Zhang, Jesse(Jie) <a class="x_moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com" moz-do-not-send="true">
                    &lt;Jesse.Zhang@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu: exclude domain
                  start when calucales offset for AGP aperture BOs</font>
                <div>&nbsp;</div>
              </div>
              <style type="text/css" style="display:none">p
	{margin-top:0;
	margin-bottom:0}</style>
              <div dir="ltr">
                <div class="x_x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                  It happens in amdgpu_gmc_agp_addr() which is called
                  from amdgpu_ttm_alloc_gart().</div>
                <div class="x_x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                  <br>
                </div>
                <div class="x_x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                  Alex</div>
                <hr tabindex="-1" style="display:inline-block; width:98%">
                <div id="x_x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Koenig, Christian
                    <a class="x_moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><br>
                    <b>Sent:</b> Friday, November 10, 2023 9:14 AM<br>
                    <b>To:</b> Zhang, Yifan <a class="x_moz-txt-link-rfc2396E" href="mailto:Yifan1.Zhang@amd.com" moz-do-not-send="true">
                      &lt;Yifan1.Zhang@amd.com&gt;</a>; <a class="x_moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                      amd-gfx@lists.freedesktop.org</a> <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                      &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                    <b>Cc:</b> Deucher, Alexander <a class="x_moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                      &lt;Alexander.Deucher@amd.com&gt;</a>; Zhang,
                    Jesse(Jie) <a class="x_moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com" moz-do-not-send="true">
                      &lt;Jesse.Zhang@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdgpu: exclude
                    domain start when calucales offset for AGP aperture
                    BOs</font>
                  <div>&nbsp;</div>
                </div>
                <div class="x_x_BodyFragment"><font size="2"><span style="font-size:11pt">
                      <div class="x_x_PlainText">Am 10.11.23 um 13:52
                        schrieb Yifan Zhang:<br>
                        &gt; For BOs in AGP aperture,
                        tbo.resource-&gt;start includes AGP aperture
                        start.<br>
                        <br>
                        <br>
                        Well big NAK to that. tbo.resource-&gt;start
                        should never ever include the <br>
                        AGP aperture start in the first place.<br>
                        <br>
                        How did that happen?<br>
                        <br>
                        Regards,<br>
                        Christian.<br>
                        <br>
                        &gt; Don't add it again in amdgpu_bo_gpu_offset.
                        This issue was mitigated due to<br>
                        &gt; GART aperture start was 0 until this patch
                        (&quot;a013c94d5aca drm/amdgpu/gmc11:<br>
                        &gt; set gart placement GC11&quot;) changes GART
                        start to a non-zero value.<br>
                        &gt;<br>
                        &gt; Reported-by: Jesse Zhang <a class="x_moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com" moz-do-not-send="true">
                          &lt;Jesse.Zhang@amd.com&gt;</a><br>
                        &gt; Signed-off-by: Yifan Zhang <a class="x_moz-txt-link-rfc2396E" href="mailto:yifan1.zhang@amd.com" moz-do-not-send="true">
                          &lt;yifan1.zhang@amd.com&gt;</a><br>
                        &gt; ---<br>
                        &gt;&nbsp;&nbsp;
                        drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; |&nbsp; 7
                        +++++++<br>
                        &gt;&nbsp;&nbsp;
                        drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nbsp; |&nbsp; 1
                        +<br>
                        &gt;&nbsp;&nbsp;
                        drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10
                        ++++++++--<br>
                        &gt;&nbsp;&nbsp; 3 files changed, 16 insertions(+), 2
                        deletions(-)<br>
                        &gt;<br>
                        &gt; diff --git
                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
                        &gt; index 5f71414190e9..00e940eb69ab 100644<br>
                        &gt; ---
                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
                        &gt; +++
                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
                        &gt; @@ -169,6 +169,13 @@ int
                        amdgpu_gmc_set_pte_pde(struct amdgpu_device
                        *adev, void *cpu_pt_addr,<br>
                        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                        &gt;&nbsp;&nbsp; }<br>
                        &gt;&nbsp;&nbsp; <br>
                        &gt; +bool bo_in_agp_aperture(struct amdgpu_bo
                        *bo)<br>
                        &gt; +{<br>
                        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *tbo =
                        &amp;(bo-&gt;tbo);<br>
                        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                        amdgpu_ttm_adev(tbo-&gt;bdev);<br>
                        &gt; +<br>
                        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (tbo-&gt;resource-&gt;start
                        &lt;&lt; PAGE_SHIFT) &gt;
                        adev-&gt;gmc.agp_start;<br>
                        &gt; +}<br>
                        &gt;&nbsp;&nbsp; /**<br>
                        &gt;&nbsp;&nbsp;&nbsp; * amdgpu_gmc_agp_addr - return the
                        address in the AGP address space<br>
                        &gt;&nbsp;&nbsp;&nbsp; *<br>
                        &gt; diff --git
                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
                        &gt; index e699d1ca8deb..448dc08e83de 100644<br>
                        &gt; ---
                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
                        &gt; +++
                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
                        &gt; @@ -393,6 +393,7 @@ int
                        amdgpu_gmc_set_pte_pde(struct amdgpu_device
                        *adev, void *cpu_pt_addr,<br>
                        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t
                        flags);<br>
                        &gt;&nbsp;&nbsp; uint64_t amdgpu_gmc_pd_addr(struct
                        amdgpu_bo *bo);<br>
                        &gt;&nbsp;&nbsp; uint64_t amdgpu_gmc_agp_addr(struct
                        ttm_buffer_object *bo);<br>
                        &gt; +bool bo_in_agp_aperture(struct amdgpu_bo
                        *bo);<br>
                        &gt;&nbsp;&nbsp; void amdgpu_gmc_sysvm_location(struct
                        amdgpu_device *adev, struct amdgpu_gmc *mc);<br>
                        &gt;&nbsp;&nbsp; void amdgpu_gmc_vram_location(struct
                        amdgpu_device *adev, struct amdgpu_gmc *mc,<br>
                        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 base);<br>
                        &gt; diff --git
                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                        &gt; index cef920a93924..91a011d63ab4 100644<br>
                        &gt; ---
                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                        &gt; +++
                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                        &gt; @@ -39,6 +39,7 @@<br>
                        &gt;&nbsp;&nbsp; #include &quot;amdgpu.h&quot;<br>
                        &gt;&nbsp;&nbsp; #include &quot;amdgpu_trace.h&quot;<br>
                        &gt;&nbsp;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
                        &gt; +#include &quot;amdgpu_gmc.h&quot;<br>
                        &gt;&nbsp;&nbsp; <br>
                        &gt;&nbsp;&nbsp; /**<br>
                        &gt;&nbsp;&nbsp;&nbsp; * DOC: amdgpu_object<br>
                        &gt; @@ -1529,8 +1530,13 @@ u64
                        amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo
                        *bo)<br>
                        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                        amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
                        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset;<br>
                        &gt;&nbsp;&nbsp; <br>
                        &gt; -&nbsp;&nbsp;&nbsp;&nbsp; offset =
                        (bo-&gt;tbo.resource-&gt;start &lt;&lt;
                        PAGE_SHIFT) +<br>
                        &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        amdgpu_ttm_domain_start(adev,
                        bo-&gt;tbo.resource-&gt;mem_type);<br>
                        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* tbo.resource-&gt;start includes
                        agp_start for AGP BOs */<br>
                        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (bo_in_agp_aperture(bo)) {<br>
                        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =
                        (bo-&gt;tbo.resource-&gt;start &lt;&lt;
                        PAGE_SHIFT);<br>
                        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =
                        (bo-&gt;tbo.resource-&gt;start &lt;&lt;
                        PAGE_SHIFT) +<br>
                        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        amdgpu_ttm_domain_start(adev,
                        bo-&gt;tbo.resource-&gt;mem_type);<br>
                        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                        &gt;&nbsp;&nbsp; <br>
                        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
                        amdgpu_gmc_sign_extend(offset);<br>
                        &gt;&nbsp;&nbsp; }<br>
                        <br>
                      </div>
                    </span></font></div>
              </div>
            </div>
          </blockquote>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------yqH8Dw9rABKMAJFESQrRAKtf--

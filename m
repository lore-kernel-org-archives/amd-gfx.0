Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED60C6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 05:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BCB810E30C;
	Fri, 23 Sep 2022 05:14:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0746C10E30C
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 05:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7bh7UarZd2R7a4bpEgb3mQX8iNld2KzoiEYIvvZi61K7oszbh8Gjp8JhEm+Fx5WLZp9pB+J5j59vtO1SW25hwk4K0HkXBwmI8cdPv67usBOKBQ++CY0gMvaVggYb2n+DuKuSKnG9igsmmHlAQ9WfBeikgtFX+EzXrGytbfath3YU1VT61Ez0/aQheX2MO7s6s1yPCHZoNsKlCAp/s+YFgM9LSSyEAQcxEPgLYVn81E6HjC7SvPUpQlCBRiTwSxrxZUXb6d7Bg6C18suZA5SAJW5qE6LhmpWyZXIT3jHnHyCmSeg6dilsSki3bgPWjb/ZHKZhQirkE1U5RCtRSFk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8RFcSxUxuC6LflKwoA8dZR7roZctJ9eUsiL5Itx8DM=;
 b=CviZil8wJBWNxJh92IYOCR9tpjhZBO/1ZTJiKS4IDt+D40s0qZ2kdXR0r55Ha6CbCH7eCSatSEqsFMud0WLluyEAACRN4tPj/fGJPBLoPTdiD7N69XNfCkI3vJn4zcYLeqiOp3tzUC0g9Xbac3dw+vwa5ZKyAkJYHlmD18jEnrpUBrU/4CrOeLe83c7cj0/Jf7LRstTinbWyP3NrBrLstzZzYYKmjMDbmc9RYmwzBDvs2Qsx3D1R8NfYnjHkeBLirs81INGZzY33CfHzbXE3rCAHBC9f6ct9NuwT7Un/wyjA1Mj1eTBtDTQ5+FKtbrRY/e2Ij2Crzx0oDK09RrUAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8RFcSxUxuC6LflKwoA8dZR7roZctJ9eUsiL5Itx8DM=;
 b=oHNfz6LKsC37M02si5+15hsSvA7eMDTTwgxyWITui5GIJ2k0G9ulu/IYZg6m6w+hWbWbxnZbwaWUXkPlfiOczBGwSCxZzA1qIYGdcGdeydd67KvrLQn2EBrQkwD1guC0zMvJT315HcN+M/dSqWy/YaAzySEUWUt6RpWNO06bKLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 05:14:42 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 05:14:42 +0000
Message-ID: <7526e4ba-1022-d921-9138-257c369cc172@amd.com>
Date: Fri, 23 Sep 2022 07:14:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Always align dumb buffer at PAGE_SIZE
Content-Language: en-US
To: Lepton Wu <ytht.net@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20220922230452.3903316-1-ytht.net@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220922230452.3903316-1-ytht.net@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3095ba-16be-42c3-a9dc-08da9d228536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQip2ICNCuWQsqW1rXcSA/+YZawgTWkOPJajZUpmU3Epz706T7NMbhD+iO4K/J3Pcsb4luIhiv67XZ/q3LAJaetPQ68oh+SS3DB215h2TJat8S2/pOux3FDcy6Qi0nFnSEz9pwwh97nQBjfJiPma6FQabiD7+eTharfe37Jlf8G/xI0Y67atZlkm1ql8ykz52KkPEP5qwIH56GccnhSIHrrOVTjTEnVD5sLjAUAzf3NLKP2tNyRN8sG2IfeDZogGriBPp9OmPyW0OI+OApL151ETp2kPgVYllG3s1yRmFnWQRGmfTpBmSMe3QytijJqlCkYPcmwi4snMKXpDzxAt5Ddrm8yX/AWphAtejLf+TRURGLypP0uSDzT0yMwDV+haDYKyduWnYUABdFjbi/XeH2s5s5JfAvsKqtBVf1sZT9q2Q/OQP2fYLnVWzsBk4lVD5WETnjF6g35q5XTAP3S6H7Im0nZ3rapeTuqV/Xu8L1EtC/ybYLA68MqBjTIPH/75rkaHFu38uSt7iXQkkhWIpkL0UUkuYdyO0u2Dzq6TVbTmpzKeilMXAPXLuJfwFD+ztI0dKykkl3L0cIbK957nHr/GlKUAAIOyl9pg4uMVgscqwY6abX2yKrlwYVBnATuh6XkhTEgeBVwEt/oQ7yHnanS2L6VLP7Y+QRYGSxPWtR0rvhHiyVv/hY2+9uD6fVPkAL6aaxKu9kqxGkane4aW99a6Qe5nlCkaDON7afy4DshbdqFWPT6syCm+NOUd5XcO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(83380400001)(31686004)(6506007)(5660300002)(38100700002)(66476007)(66556008)(6512007)(316002)(966005)(478600001)(2906002)(36756003)(41300700001)(6666004)(4326008)(8676002)(66946007)(2616005)(6486002)(186003)(8936002)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um5sZjV4S2NrSDYvcFE2QTFiVXhyandETC9pSjBqb2FldDJQQVpKSlJsYmZF?=
 =?utf-8?B?Zk1hNW53VHAxVU8xazd5N1FBSGVHS3J2dTB2R25ublpaeWxMTUJlSFNMTjg2?=
 =?utf-8?B?aWJsWGVyUkJTMmNsMXBmamE0NS9SVlZKNEVwTUpuSVVwOGVxNWdlWVh3TjFQ?=
 =?utf-8?B?bWVzRmJpcXFOWkkvbkZwdk9yMUFPOVB4WWNVTzZ1UmlHWmRpRUZFait3eVBC?=
 =?utf-8?B?cWd4QU41SFlnZ3NTV1RiUjhPdzFzRlJ6T0V4aVRBeXNaYU56WmMwemlyazJw?=
 =?utf-8?B?STJDS1BZR3hsMVdMa0l2TWhxK0gxclZaWHgwRlFtaDFHdklBT1BkNmY5RXp2?=
 =?utf-8?B?WXZmV2ZJQWdPQ3JBS21JL3JHUk9VNHhWUVdFcUxTUmREeDJ6ajArdTBrZE80?=
 =?utf-8?B?Ykl0Z0hmTkIxUFhabWl5Vm9VOTN2TjdmZm13bFZFVUdtbnlJQkIrdy8zQ2xz?=
 =?utf-8?B?eEhoaHVWd2c0VVZxWnBibzNBaTZycW00YWZJZFF5Qmc5bElpenhFZlhVQnoz?=
 =?utf-8?B?amVuT1RHdkxoa3p2b3hpaGJSSUlrOGtrbzdJMHFzSmN1eHROZWZ0NGxweEFh?=
 =?utf-8?B?RzFFdmhyY0tybzdFODZBZjNwMm05ZEtiZEl2NDhFcXhVY2xCUXlVcDVuY0kx?=
 =?utf-8?B?Q0Rnc0tNbEh1bk13TEw5Y00yK05IRTRINzBjTjVFOWhFUXp3RUNyQzUrbHhB?=
 =?utf-8?B?OHE2M0ZRbjFTbGp3eVhiK3ZyTlM1TUJmQXRVaVdOQzNEZjVjaHNKTTgxMnJz?=
 =?utf-8?B?UnY2RmtreGxibFI5SmFPSTBBZldYL3ZHMk1VWnY5UkdFMXhtSGZVMWZUWTA0?=
 =?utf-8?B?YnZnQVRuUkU0N2JwUlh5VWt5dlFtRzkxVXVYQ2dGTTloYjRjM1duTExna1FJ?=
 =?utf-8?B?VGoxTWZwdEt6b0E1WE1Ca3laQnM4YnphZGdnUGJHK0Y4STV0RDIyM0pGVmNR?=
 =?utf-8?B?NXR0Vkl1dzVzZ09QQ0d2YW5namRzVUc3eUtsYTJvZVkvWWQyQ3ZVcXV5clVM?=
 =?utf-8?B?ZFNsN3RsSjRCZUE2MXE5VGNjcVVnRkgyTGJ5UlBiUTdrRWFydE9xOTFxQ1Az?=
 =?utf-8?B?ejF2dVFYdm1BQlFBWFdRZWFOd0NNU1Z5SkthN0w3a29mME1xZHBOOVJMMmow?=
 =?utf-8?B?RkZCV0x5U0hHakc0S3kyR1RmcklLMjhZVjZrTG9UVXVvbTVQSURNeTFjemtE?=
 =?utf-8?B?WDNaZVhZeis0RHUxbHlISEhRcC9lYkhLSXRUaUFxVWF6aFBSVXpZdklHdTdz?=
 =?utf-8?B?SVdGWHRmOTlBSTZuMGxTRVJUWHhwWCtxYmNUblQvM2U1NFQyYSsvckdXSUwx?=
 =?utf-8?B?bmRtTmplY1E5UlAvb0E4SFJ1S0lkNTZzd0tHS0ZFcnYwVXFZdVZWbDNmSnBv?=
 =?utf-8?B?UStibmgzMW8zQXlOajBGdkZQZjZlUUJhREZLTWtFSldSdkJFZXBscDA5ZmpS?=
 =?utf-8?B?anZKd2NWVWlwOTFHQ2c2ZEpneVJEMFpRSStGMSs5aFNPSmJlU3MySzJjWXd6?=
 =?utf-8?B?M25wOHRtWFExUGRTVWFhYmgrcmFITjdMYjIxazE0K1Z2SlYxbTc4RWxOL3Iz?=
 =?utf-8?B?NlNDSm1JK1E2MzJTdndqVEFKbGJjdGZLQlVFdVgzQVBOQzBXTldhZUFqVURY?=
 =?utf-8?B?R2ZHZE1HZVZHZjNsNmlIVlNYN3NXMi9xQ3pmbVJiZEV4V2dWUTNGdUo4Q1F2?=
 =?utf-8?B?eGJodzNFakFDMmx5UFVFVGwyaG9QdTJEZm9EMThIME5EOWJIMktOT2tiUmI4?=
 =?utf-8?B?TVNHRkFzK1ZLNXVscG9CNXlpd2Vxb1ExMlI0a0VXcXVubVhJSGxYb1lSM3Fr?=
 =?utf-8?B?SmVITHVIVDRORDh5RDVzQ3BHUTc5YkIyNk5TVGxPK09rNFJKMGJ5VFp0TlVx?=
 =?utf-8?B?dmVvMU8yZEJ5VlNpY05VQUgyRFRsYVlkbUs1MjJGQUVZM3RiUGFoMXhlVUFq?=
 =?utf-8?B?aFM3N2VxMTZtbWp4NnUyNHFhdlp4blFsODRUaytwOFVucjJGQmVKOEp5SmVC?=
 =?utf-8?B?TEYrVmRxZVJkWGtKc3lFOEtxaUwzN0hEOE9wMmxJSFpOeU9kVGNGcVBacmww?=
 =?utf-8?B?UmVMVG1obWdBanhTVktRVmhORG9xVVp0OTJtS0JFai9BYjhJdWRFVUtvaFlL?=
 =?utf-8?B?WTUyNlJQTnNVZGI0Q2VReVJ1TmpITmU5Rk9FeWdWeFdnUUZSaUpsWlBFUDdF?=
 =?utf-8?Q?LaKCeicP4dldxKrVm7rXaFuOBd9qYGyhksNU+8O4yjFS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3095ba-16be-42c3-a9dc-08da9d228536
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 05:14:41.9028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY4qZRWe1eKUetxdYChSF6EV3OkZV97Fp9R8z8gAGpb7bOjsgBgl1Z9Tfq125GHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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
Cc: marek.olsak@amd.com, bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.09.22 um 01:04 schrieb Lepton Wu:
> Since size has been aligned to PAGE_SIZE already, just align it
> to PAGE_SIZE so later the buffer can be used as a texture in mesa
> after https://cgit.freedesktop.org/mesa/mesa/commit/?id=f7a4051b8
> Otherwise, si_texture_create_object will fail at line
> "buf->alignment < tex->surface.alignment"

I don't think that those Mesa checks are a good idea in the first place.

The alignment value is often specified as zero when it doesn't matter 
because the minimum alignment can never be less than the page size.

Christian.

>
> Signed-off-by: Lepton Wu <ytht.net@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8ef31d687ef3b..8dca0c920d3ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -928,7 +928,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>   	args->size = ALIGN(args->size, PAGE_SIZE);
>   	domain = amdgpu_bo_get_preferred_domain(adev,
>   				amdgpu_display_supported_domains(adev, flags));
> -	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
> +	r = amdgpu_gem_object_create(adev, args->size, PAGE_SIZE, domain, flags,
>   				     ttm_bo_type_device, NULL, &gobj);
>   	if (r)
>   		return -ENOMEM;


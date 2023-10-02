Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD6AE7490C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 19:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C0C10E21F;
	Mon,  2 Oct 2023 19:09:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F8710E21F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 19:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EevCO914ndvu0+Mw9zrCd+2alhjcwXPr2XS8CUQVWA0QL4+CvCe3DxYSKQq3M+zEuTqSMKKq9VFj60xOz/ErYeclbdp2PC1BpH3qNPb7GEU4Z8KCsn9cePp0RAwjt5EMuRGywkNLXGlGUtsgWxOLdqED9CsmOmvb027oUt5wgF90Ztj25ti//BH6NbXn5U1it07EytIfFvowG6XsC0B+5C06H6SUuA4wB9na6pK6vSjPqR9W/qmj8iUqFtK9L6xzNi2R1fPhqibj+S8vPSsVCala0Gx8bJpkxlfTbVl8i8EM1XO5sRldOmVnLhgh56TyF/xAjTP+CnR8Gi95ugQSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65D6DEqRC62x0IzGNyQSS8sz2RIkhR0zETD0ZMAGjdY=;
 b=GwxHeYjWUn/c4DnXltDAi5snwGQhBB8JlGDjEmnhwTIUNUOdSElWshlh3neNlEuTL7CuyrEhkEyFT6rqzMqffCz7S4etk7PqXl2qNt+3I/4gcWH+4yXEgz5vxImSb8s+dUVQ+Eko5FSrHv7DRaR28NLHmGoS3L7lpEjQdlLCe4VIka/gpW9ozikS0GcsOCejceiEvd53Ap/F7QLk/L/dGY8BtN7k2olhZeteh0gQtuhQ5JKgyJPWaecXDxYxrR0Q2vYwMU17J4H+9AJIfylbDkiTX++iBVi0xWnYGUATCTOgXzVMuFSjNK2R1TZIdMREh8/c/v0zGGf9AKKl4S8LxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65D6DEqRC62x0IzGNyQSS8sz2RIkhR0zETD0ZMAGjdY=;
 b=VVcWgje/CjI8/N2+XCRuFe1eg4N2qPQQozcRNFXvEqyHGXWk/z/Qz7XM4SxjFfdq8gAsLSA+3SqJpanv++K6gF2d3mOKTsWisczlE3ZVy9H8aeymPAGzEtWASrrUhWaeqjqWrl1lvcM/zrgIfKWbWbCt29r9oeuq+wlc1VRD1mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 19:09:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 19:09:42 +0000
Message-ID: <89fd99c4-04fe-4c5f-84c8-6f0eb00eb13c@amd.com>
Date: Mon, 2 Oct 2023 14:09:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [2/3] drm/amdgpu: fall back to INPUT power for AVG power via INFO
 IOCTL
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231002184919.77753-2-alexander.deucher@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231002184919.77753-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM8PR12MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ea8e9f-7a16-46ef-1e6e-08dbc37b21f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PlWFCiNDb6/jkJSEELo4yk9LQQUBU74iGO/UmjxLXJ9+ZoD5FN7Hd7pT/awdpO6GSztvlAIp4YvIqt/tKxHORDGJfjjn8ucJwhnWdjAEuFoPSoVofDIUtFJEy9iVCeVoXyhwf7ur2c3qRC1+WMjx7/U66cvfC3anmYJewdDtzAQa8u9ygj0MgmHpbChjnXm9SaG8QP2eh1cWFCVtjBOVv+FyBs1sw12w4W6hSQJwZXyvtR+IGp3rAoLJDLfda5NxoZLWJkpXjyxDI00M/XEQFcRV9AYB0Gd0VLQJRGmcQ85KJ1iZ+ix1qS06CiSQjKBoQHRiUlrSIKCBqSGIkrgXC9l646CWPerismWqvj68OJLxqL7lniKgXTt/RdvOSyhon/QaUTM8hQHEFpDkIniQYzOh5I7HdnFFIwG/vXF+CMP008Vk7oIo0pz+j95XsbiNhJ0Zj59NFMXJ0nhMMuis1twlJ1LMB8f+A7oAHzZlcMmKTF2Ii6KH3pMaI9QlxfvEGLAmA1v667gpS3WSACLC9LdC853fMqDcO/2O3O/ZcLCCKhFaNd/rnVwt/lQ/8AX3saMrwDdwjKQx46TM3w5m3Re1JJUEZ8s1ebJ+pmXI+WOcZuzOUKHszT4+uXdTQZIx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(2616005)(26005)(36756003)(38100700002)(86362001)(478600001)(44832011)(6666004)(31696002)(41300700001)(8936002)(31686004)(8676002)(5660300002)(966005)(6486002)(6512007)(316002)(2906002)(53546011)(66476007)(6506007)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU5BR2N4dGhmYkpUWExydGlncW93K1BKZGxTR1c1NjJGQ1lhbEs4Z3k0dEJl?=
 =?utf-8?B?eXQxUnJKUjJzdW5EeDQ4YTdhYkE4bzBaMndoeEZqYncyK0ttczZpN2ZiMGp4?=
 =?utf-8?B?bG5uSWlyVE9NbnpXMFZPZUdPb0ZDb0RLd2xqdURpY00yZEJaRFE3ck5IK3NF?=
 =?utf-8?B?eW55YzJFMk51eEdjeFdSazR1MmhnRXlNaXV6RTR4TVN2ZnU4WHhrY2wyR3R6?=
 =?utf-8?B?YmhoUXV6dzdhenZrbTBHakQwM1lUR0RjeXpWV0VweC91YjVuL3VZcjgyYUUz?=
 =?utf-8?B?UGtMclplNWtzR1ZuR0dKVkZ0a3czZ1JGbDM2RlJwc1Zxa29ySkRWVWx1MEVs?=
 =?utf-8?B?SjBZUzlTekZQK0VVc1hmb3lkWnR0bzBIN05WRnhnQ3JOZ25qL0NDT2FGU1lV?=
 =?utf-8?B?MSt6cTI4TCt0dnA3aFdQd2Q2RzU1YzNJRlJWdjVxUVl4THVhU3NHK2pGZCsr?=
 =?utf-8?B?U2VNSDduWktCYjdlckxmdUpCVmQ2alJYN3E3a1B0bVVaVFh5M2xMcjFuZFEw?=
 =?utf-8?B?R09tZkRteDdFNWdIT0VqQ0lRRysvZnFTMkZnRFJLWmdIS3IvUkpxWUtnb1Zv?=
 =?utf-8?B?VTdlbjhPOWF2dEY3SnRzYVQ5b25RcStOSmFrNTllNmFEaWpXVGZUdTZ2MW1j?=
 =?utf-8?B?cmhla1JmTUNRVHFGU3JzZ0QwWTY4UTh0c1JxcmQzRE1IR3IxYnVxR2o0TDRz?=
 =?utf-8?B?R0RaSThiNXBaYVFFckQyempqQmtXSVpqT3hiTzRERWJIMFhCZEJWbWoyVkpN?=
 =?utf-8?B?TCtRUEZ1azlBNkhvc0dndUJ0d290M1hRY25QekZVOGRpVHBNZjViYXJHbVJl?=
 =?utf-8?B?Z1p0dzR6OU5sVmppSGpWM1h2amNURm5NUkpMeFJRaksxWVZkN3IzWDk0amtB?=
 =?utf-8?B?RmhJWUI5VDJBRHEvVHRwdUhIRjFWeDY5TFZadjZpbVZobU1pbW9DOFVZY1R0?=
 =?utf-8?B?WjRKR0N5Mi9adkxIZDZPV2JEY3R2UzJ5QitPWHU0MmxqYmJzMlB4L1ZUSU5o?=
 =?utf-8?B?aE5NaFlhSytTN2NxOEhLT2h6MmtOdGhtSitvQ0RkT1h4OWFCZzVmM1BVemlZ?=
 =?utf-8?B?WFJYTHo0Q1UxYzUyQytNU0pCOXVZdCtZZWVFMk9xV2piODRVcXBDNEdZNk1J?=
 =?utf-8?B?anhqRjFQbEg4Ky9DVmc2UFdsRFB2bzNwK3pqazVSc25OaWxRS3VZcnJQcjFk?=
 =?utf-8?B?ejZ3aG5TbGx1REd6em40SGV4RVZmRUZxd2oxSDZKMEh2NTRLT0NHeEZSTEd5?=
 =?utf-8?B?WUU5dm5qYmk2b0N2TCsxQ0MxSnV5Ym9vSHI0RjVpT2ZkaHBmbGZrd2ZKalVs?=
 =?utf-8?B?YmRvMTRwZlh4Y2NyWkZSeTlHbnhhbEEzM1RtWnpSajVnZ3NQVDNWYVp1cW1X?=
 =?utf-8?B?RHBZeFdTS3ZRRU1qdklkQlRlTHBPZTg5UjlzcFJNemY1UGt0eEVaOTZJWmxt?=
 =?utf-8?B?clZqNzNqTWRhVWtET3JpeTVoMm10S1pLWU1GQjBmUmlhV1IwYjR3TmgyMGhz?=
 =?utf-8?B?OTNBNGY1RlFXckNvZzdWeE9hNjdYYStwVXF6a2gzQ1cyamV5a2FhZmE1d1pV?=
 =?utf-8?B?ZjdMQ01UKzBMY0x1NmNQbE1PS0Q5cHNsRG55NDFaT3B1NCtRVC90blg5ZXZM?=
 =?utf-8?B?ZnJUKzBRNDNYcjY5VHBMZi9oa1VOMG94TmFaWUZ1UVVTZ2dweC9oWjNsak9o?=
 =?utf-8?B?RnlWYUdKRzdkRU5QZWdtTjY2UU5PcUZiT3VWQ0hhMVBzMEpHS2NPa0pJS1Yr?=
 =?utf-8?B?V1M0ZWlVYUVwODNoMDVBUHJISFVwbWdscU5nT3Qzb1lrS25BY09zcHErNGVp?=
 =?utf-8?B?UnVTZW00VXA5eFo0M1pTRzFCZ2dPRTFFaGF0UmRRcDFhMDR3ZjNHdUFZQmFG?=
 =?utf-8?B?aTBOTjltcHZobFlIVXpDbDY5dnhhVUNtcGNoWFN5dnBhcXU2NFkrU2ZsNDJT?=
 =?utf-8?B?Wi94K1d1dmpkQk5iOVpNaFdCS3VYSHNYY2hLVXZqencreTZGMSs1SlBCdFFu?=
 =?utf-8?B?NFA5Q3Jyd0hYbGE2cVVleWEzaVN2VEtZTWp3K0lzT0ZxQUVZRlkxaElPRzhZ?=
 =?utf-8?B?MUp4cmxzRjBTWWNkZWFUZmxZbUpoWWliYUJpd29xK25mSnM5cG1SOVlibnpP?=
 =?utf-8?Q?e7EkdZzb84r8eW1NAiwQgDLAm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ea8e9f-7a16-46ef-1e6e-08dbc37b21f5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:09:42.3181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pdjr+6OhHogQPMFeHjg+jEFTjde7DApnhrPfxUgY1SussPssyrZHNl+yAJfoRgyLaX43se7U924JLgg5UYQN0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
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

On 10/2/2023 13:49, Alex Deucher wrote:
> For backwards compatibility with userspace.
> 
> Fixes: 47f1724db4fe ("drm/amd: Introduce `AMDGPU_PP_SENSOR_GPU_INPUT_POWER`")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2897
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 081bd28e2443..ce71f853931a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1077,7 +1077,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   			if (amdgpu_dpm_read_sensor(adev,
>   						   AMDGPU_PP_SENSOR_GPU_AVG_POWER,
>   						   (void *)&ui32, &ui32_size)) {
> -				return -EINVAL;

In order to encourage userspace software to move to the new dedicated 
IOCTL, what do you think about having a dev_warn_once() here?

> +				/* fall back to input power for backwards compat */
> +				if (amdgpu_dpm_read_sensor(adev,
> +							   AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
> +							   (void *)&ui32, &ui32_size)) {
> +					return -EINVAL;
> +				}
>   			}
>   			ui32 >>= 8;
>   			break;


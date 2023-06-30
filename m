Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C75DEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 11:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A7C10E452;
	Fri, 30 Jun 2023 11:38:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6701C10E452
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 11:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tcy7OiAdcBpM3DdxydNrQp6RSujKxY9Dm767n/rAoro06BNmJECvNa+JWIK6bZlF0k2SgGaIHPAAkfJAB7h8IgdcDDJ9FVHt62UlXc65Nbyiny0k0cuWWuvWhu8mTP9DwQU1aHUIsO9WGSd3AR8xvY3CTxckGivQhgByNNPMo4cxWJ7Je7ydA6MAkISy+uIGSQHWvnLHi8ve76Gh2K2C1CtSvEHRpxucBD5URlVnl3lq5ZceOZhXVRV537s17UJgOsj9vnD0PM7L2UyB/YIl1BacoLERNTNkYzHjZxgbf7R5ym1+7aZevhmYGlg2Oy7N7+puGjCaHFwHxA0q+XM59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5Km2mFEf5jVRWCmjDJSMnFKZWNxamEDcBmmUwXGHdY=;
 b=REJ5t655NSz1Hofnvm8hHnpkjttgh0CoaOlkRmUXGSscwNe/I55c9CUMNicNeTZdOejVRo+votOxEvjAW6pLdp5oG6vuqdshB7I6M3JtVjGAPq1KOWsxE9Q/0jr08Kf22/cCBSLaNN+qmWN5w/u23es9DS2t4LuXO+8gyEsP0s09BUP2syJO31Hox5y8Inj1xl6RuS055mk9dysx0oHqZrSVMZuT5eNFz3a4FCfulzEdTGZt8FYTK3qpgdrO/0h8XvBjy1+5WT7kUNkLN/eD7aEM3L3nWwKinJxmdZgIMwkOxWZuitPY1tISlLns7mAk0klQHiTzEZJbef7Gh7zScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5Km2mFEf5jVRWCmjDJSMnFKZWNxamEDcBmmUwXGHdY=;
 b=t5NGZ9DKgPuPt1EN9vn1m07Yboj+p/jE/4Ts4+016fbKufnpg7NUuT2vhZHcRcRsNgu29cCfO4ob9AiCaI0gealkX1jJbyb0ag3jIGViYEun4KatjMSSw3uLLxmt+tM9KCPmvi5BsjYe4jjfpgTAMzgH62mesbJ7e936CUhvjAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 11:38:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 11:38:18 +0000
Message-ID: <9c19a828-15ed-c37a-2c07-acf29f489541@amd.com>
Date: Fri, 30 Jun 2023 13:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
Content-Language: en-US
To: Horace Chen <horace.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 "Liu, Leo" <Leo.Liu@amd.com>
References: <20230620132950.1121406-1-horace.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230620132950.1121406-1-horace.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c501c1-a8cd-48ae-5804-08db795e7ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RAoB664dbBYm5/4C5pKEZ0K+TtCVnCavdjepLsHqWgMKpzTEaNzwhK1GyHcP8TCtHuvMQwiYoax3yFtGD/EFAmixw201I88wHY7grqhS0D/tKDKXS7xgpPw5w9Y/mhWp/eMQ6WE3mTSjGK216Y3Me5UXo/f8jIJrDHUndla4EN2+S02gsrXNvxXrNQVDXs2FEWdW5yDYF5u0HLEeshqnUAR+kFz8m/qjzao9WQsnxAIhEgfmdJZ40AkC61p2/W9RHDWJCXCIGFjnJHbRp+I38GrHFw40Cu1cNw64wBEMR7h6iWn8GJMgVzf5B+Tu51lguGuCFYpcaLSguZzjQJYp5cA/AY0t6QuL7TSOUHMLSKG9FftPb4YcpbfEoYQdWtfxMg7DwFRSS4YZT1Nl5GW75XYa3UzPP2MT1hNWFTv8Xk5sQ5g3vq4Wedgoo7HpMK705dVY5Xdl37zWyKO3lW8m79x3h9QS0rx1i/p5xSB+ZHwl3nGLvSJcI51cdMdTkDSTcj8Br0Z2+FbVvf/a5QBcx14qV+vVnIRUrjuSYIYSsWx1Q8U4ZhMOAGUSJPJva29HdcoLSVxostW1pOmdXTz8hx6GdmNA/X/lXTUTKkeUw3GfXdjxUI4kI2CoCNTlzv/mWAiwib2VU/ceH9hOW1PWXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(5660300002)(66476007)(66556008)(66946007)(316002)(36756003)(2906002)(6636002)(31686004)(4326008)(8676002)(8936002)(478600001)(6512007)(41300700001)(31696002)(110136005)(86362001)(54906003)(38100700002)(6486002)(186003)(6506007)(6666004)(83380400001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0FCUVNURHJJMU9TNjBZTUFYNTlxQzhOQXo4TEg1TE9kSDFvWHQzd2lYSWRa?=
 =?utf-8?B?S2RoNlNFdnVxQ0dLOTh4MDZNWnBwYUJYRlFpWXp3clliTmUxUVp2eWZlZUZz?=
 =?utf-8?B?ZjlzQWNsaS9LUzhPZnZpcWl4cFpmSWF0K1ZWRi9GS2NyeS9mM2NYdnYvNVY3?=
 =?utf-8?B?QlorN1pEMzE0UFd3UURNdEZQNnRVSHRISUQ1YmtvQlFYYUlvMS9jZFVmbTZn?=
 =?utf-8?B?dGR5Rys4U21YUlBBWWdHcGRNS3g0Mks1WnRtRHJMajVsc1JuOUc1blQyMnVI?=
 =?utf-8?B?SGV0N2dIUTZ3cW9QaEpVZ1VsUGwvd2g1d2RnZjdxcmxnMnZOMWxnaG1sTW5l?=
 =?utf-8?B?dWJJbDhoSGpLbGxXb0ZmNEZ2MmIyTCszdFhCN05CVHJzZnNKU3VuVGExb3Jm?=
 =?utf-8?B?eTN5QVJrdng0M0llYmpQVUJtcS9LeXZJWkxiT0xlVWVpaWMyUitEVVk3cUt3?=
 =?utf-8?B?aVA2OEZNVW4rbUh2RnVScUVOT1M4YmhOd1ZNemtCcUVxa1dwTisvNGhjbTRD?=
 =?utf-8?B?TWpEbWFHL1J0Z3hOeTJBdGRUblkxU2YzNzltLzI2bmZxUk1hdUVoNkR2UEJa?=
 =?utf-8?B?ekRELzEwbkljNW82bENvVmJlaW93QWxWMlZrRzJJNENocVFRaEE2c3FFdlNl?=
 =?utf-8?B?ZTJsS2xOZGFPcHVMczJPQUVsemhqYy9HYkc4aE51ZzR0a2VZZGZST2NBR01N?=
 =?utf-8?B?Rko1MXY1NDlOVU9NbXVaS2FJRURlZk5PUmZZNXFtVU1HSlZ0OHlhRGdtd2tW?=
 =?utf-8?B?NzRuZ2FEdjFRNHNKYXVZazB6TnVKalZDUFBHV3NaTCtJbHlHa0p3U3ExOUhN?=
 =?utf-8?B?NGg5RHA5TEVSUjJXeW9RNmlsUys1ZTd6TFZFbldyNUpmcll3ZkpsOERmYXBz?=
 =?utf-8?B?R2VhMHA1VFZHZlo5UlRMWFdmT1EvdVVKaVpnck5uRWYrdTBSR2pJbjdPRWt6?=
 =?utf-8?B?MFBTWGlkN2xmZTZWL0d3VUZrQkc2VmdqMXZMbTNhNkVNVTJXaFRPemVKVFZi?=
 =?utf-8?B?SlY3WERJVURDMUNEYjUvMzlZNTJNRGM4NmU5ZDFyRjlTb3Y5TFd3WDY0NEVY?=
 =?utf-8?B?cmlTYnJaQk8xNjhhWGRycVV3akxTWHcwa0pURVRlY3MreDF6OUxNTWNTTUFS?=
 =?utf-8?B?UFg1TjZ2cUhvS3F1QzVpS0JqRXgwVWtOMG5lVC9aWEhVM3ZPcVhVdVBQV1Iw?=
 =?utf-8?B?S2RUNXhuL25PN0kxT1RvaG1nYkRSMGpoNzA0U0JIMUJ0L1Y4NlVKOFBLMzVY?=
 =?utf-8?B?RGl3ZldCSTIwZ2xoTHVLMVBnbVZrNllXenc3eDlRRlc1MFAvbElId0hPc1h6?=
 =?utf-8?B?R3o5cmJ4Z3ZoTzBESVdNeExpNVBxNmplTUhPRjRoTkU3WkdKTE8wY0Jkc0tU?=
 =?utf-8?B?dGowTlN4dlpoMVVCbzgrUDgzQWtxS0I0cWd3NEhtY01CcmNBQ3dNR0FPeDBC?=
 =?utf-8?B?OXkxdVhJWGZHR3F4dmh5eHlBY2pzNHlrMXM0NDRkbWYrNmlnMDZuUXozVnFB?=
 =?utf-8?B?bzFTdHc2VXZWUERsQWJOMWltK2JhOGw1anAyZG9TVHB1M1lheHFKRkJSNmwr?=
 =?utf-8?B?a0ZwWGk5a3U4SkUyZTBDM2tLbDdTSFpLbytzQ25JRmxXSE8zMFdycGljcmJW?=
 =?utf-8?B?WXpBZDRYYjFKMTQ0dzNBYTRjTU9XVThEQXhFRzZWUC9lYUZQeHJXSU9Gb3VH?=
 =?utf-8?B?RmZQU3o5UElHVG1VRVdvRVc2WXNXakZKSUNJNjlCbDVMakFaaG44eG10ZlhW?=
 =?utf-8?B?bjB2YVZOZnJqeEZGMkNDelFBVCtCcFUwS2VIZjhENTNScmIxT3pKakExVE02?=
 =?utf-8?B?RlEwOGZlS2RhOHMrYmM1MHpjVSt5WXM4QVA1TjJVV1VoUUlabk9GK2NuVEFm?=
 =?utf-8?B?d01raklrQUFXYTlkTVNUUzU0UURtTFpTNDdLbFRCM0ZmUkEvOFFaSEpvOFFi?=
 =?utf-8?B?clI0dzIzaDc5TGVLMTZpRXlBanVtNnoyb0dRMU16UXR0Sm9WVTJxTUpzWUxQ?=
 =?utf-8?B?N2tIdEt5UG5zUzhmeU1oVHBTN2w5bDZXZzF5MzFFMEovNzU0UTFzNnhlZmsw?=
 =?utf-8?B?NXVjQm9zRUFNc1NtZmhhOGoza2pyQ2dLNFV3U2ZuS2FjaXZWcWptWHBhUVh0?=
 =?utf-8?B?a1pJU3FtV2ZES25ZSXNHY2kzdWJvY0lPdHdKUllFUXJ0eFdBWjFSL1pFQzVX?=
 =?utf-8?Q?X/ccTmkivc3cOovmzjLuEy7bm0oE2girsgTdnmbScI2z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c501c1-a8cd-48ae-5804-08db795e7ff0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:38:18.7307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s41vUU0fEMN9lwxAGboOF9h6r5ktzNqtfoo4xsgjFECHAaOqG8MyR1GEvR+Z4oac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Haijun Chang <HaiJun.Chang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.06.23 um 15:29 schrieb Horace Chen:
> [Why]
> VCN will use some framebuffer space as its cache. It needs to
> be reset when reset happens, such as FLR. Otherwise some error
> may be kept after the reset.

Well this doesn't make sense at all.

The full content of adev->vcn.inst[i].cpu_addr is saved and restored 
during suspend/resume and IIRC GPU resets as well.

See functions amdgpu_vcn_suspend() and amdgpu_vcn_resume().

Please let Leo's team take a look at this and review the change before 
it is committed.

Regards,
Christian.

>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index b48bb5212488..2db73a964031 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1292,6 +1292,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
>   			cache_size);
>   
>   		cache_addr = adev->vcn.inst[i].gpu_addr + offset;
> +		memset(adev->vcn.inst[i].cpu_addr + offset, 0, AMDGPU_VCN_STACK_SIZE);
>   		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>   			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>   			lower_32_bits(cache_addr));
> @@ -1307,6 +1308,8 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
>   
>   		cache_addr = adev->vcn.inst[i].gpu_addr + offset +
>   			AMDGPU_VCN_STACK_SIZE;
> +		memset(adev->vcn.inst[i].cpu_addr + offset + AMDGPU_VCN_STACK_SIZE, 0,
> +			AMDGPU_VCN_STACK_SIZE);
>   		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>   			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>   			lower_32_bits(cache_addr));


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C76C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 13:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F0910F0AC;
	Tue, 29 Mar 2022 13:21:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0E110E9A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 13:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFLdd9ZsRyfsryjdGn4F/bgRqKFfkuiSQImk7LGnrK23Sdtff/ypJYfnhKe5i17Ycgqkkqy33tXihg+CJG+x97HHugGDskBYjcDEgIwuh4xW9g/Zcp6RPVp6sMEBGnNqKtzEqGAnGzZUy5lDmlQrS19hFxhpu62dbLsj+V7vxlB1Hd4gpDoXmssqMt6VVzdJrvA3DbOCE1LIY0cnN51WNdodyoFc8FuKg3m9w6Qqi1dijZmFRL2zV3cL1TvnXGSeRfjttJL6kIt1P3NjGswIHGY7ZscRovjNdjHmBym2U69ozYd5Pb4DdrSpdzMb2eC9kRQNa2gjnhlZ9oSAxLY1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNYmeJNMCg3PMx++27uZrVAqonMz5tarIybpSwGaLp0=;
 b=WalsZrx28CxJE6pWvaR8IzL9PINZjfHNzZLsz5U1Kivk6ZIjodGKuRpmX/a7sso7utZ3nS+99dRqo+41n7+0l1khuQpW1iRpJkg2ajpydzWs9ukqzVujCu4+kJdummkIhvO9v249NPSX8ZPJeXZcOJo+iiXn+LheLSVLlD/4Q0IelVFm5Ke896YIz4hUH/rj1oK5G4iKjBHUfS44+/xP7oZTDMBt8BVvSo8bwXqSLZNA8xZ3xqQRMyXOrBgKdrRwOPq2lbmKd335/cCTd2ksyZFDXlyJ0FApL8q5EL+BsyFru+N+6PBBJqr4QcIeQC8A0xKo9rmy8nqJ5IzmFKIB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNYmeJNMCg3PMx++27uZrVAqonMz5tarIybpSwGaLp0=;
 b=sE9T9ouoC+v42CGK5XS42MjIlA3siSJyhwpjrDZzJSZFEelXWsyrfNHmWP/24PZJng2syfRRH7EEgh9LnY4bL8i6l6DrmOKTjt1STE+oy54ldCRS1HCJeGfyHXFujiBxuwcOs63lJvXuH8S8H4QyV9BF70fsUWPti6MzRg4uUXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3470.namprd12.prod.outlook.com (2603:10b6:208:d0::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 13:21:02 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 13:21:01 +0000
Message-ID: <206c79ce-a3a5-bbe6-89ea-21f7b51e509d@amd.com>
Date: Tue, 29 Mar 2022 15:20:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface
Content-Language: en-US
To: "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220329073843.772795-1-YiPeng.Chai@amd.com>
 <BN9PR12MB5257F539B80934D112D1D481FC1E9@BN9PR12MB5257.namprd12.prod.outlook.com>
 <CH2PR12MB4215A7C562267ED64F7FA2FEFC1E9@CH2PR12MB4215.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CH2PR12MB4215A7C562267ED64F7FA2FEFC1E9@CH2PR12MB4215.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P195CA0096.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::37) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a70f631-6fce-400b-9e94-08da1186f84e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3470:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3470F6E5A0B1E170FD50D3FA831E9@MN2PR12MB3470.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R92XTl4pBdYmlvQYaMsMHLmc8kAPP+z+kfRPTj0YqJblsjpxM4oXQerjpDLW/nsdQi+Gid3NUUKUap7ngQOWhCbvwf0zwjNypqCVv2RYQxjJahiIRd1XUlxLtxs0CNABZkx3FUGmklnESLUT4NgczSSwliEgAXNZIj9+n/pU+Dx8fsgvfFT9wCQ6etBhj2FRfxNEPnGVyk2A67FcebavXmZkGj45yF0rCsPMTtg2Ow1W6CYHzktrQ+KE+mFZpcaDsXi3pJSsslryO1tz6Qf891ESPot9Evl+Ea2xwOPS+MlI7omZsc8pIhImvqIRIuxmCTimF8+xyDd+mp2HZ9/lCpPwVdf1mXA5b2aiOLNDYEQ4Nqf7kVBnEwEJAP+pERXXFJQBilgizo9ryWbBbMdm56pWhAK3NlHRt1qMeDQmYmKksHPzoy53DXbdGMQrwDQE1ZCfo4zp8Io+BQl5tFPn0OPYKGuWRT8H9hTXCFHDUD+wYcfJ7kt3abYujXXvWoilGByL6JPyTxuatfDNhuNX88NhaI2FEktxI34FAOkpohv//FLJUcbxi3fCs+q5pbQm8fzoNWz/7C9RSnr0Ih0DgaDHty70DeaVsSXIX+eW1BHuzKwJpArJJJ9yyXATlfyX4HbxFcFvVupG/ZAK64orvDnPMae5sX5AZJu6tWbSDOudvJ59Hjr+mCk08/bFOGbN1SmGRMTO5fO6EbPZN4a/hDFVNDvUWW8dtiVwr/GwxFXkpkyQq2l2elP/LRnBAqhy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(86362001)(31686004)(2616005)(36756003)(83380400001)(508600001)(6506007)(26005)(6486002)(53546011)(186003)(6666004)(4326008)(66476007)(66946007)(2906002)(8936002)(66556008)(8676002)(316002)(110136005)(5660300002)(31696002)(54906003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUhEZldkVnVyV2NudTdraXVKRkNQK2NUb013ZzdRWkNaL3JXN0paZGtpOWwz?=
 =?utf-8?B?cmx3dHdUR0JyblNXQjNhT0VYTXBOMVpFSDYwMlZVMjhRM3pWYThsOVZ0cXdD?=
 =?utf-8?B?amVjRGNXN2kxc0VtZ1dwa0ZTWVlJT3Mza1EzU0ptRFRGSHZuR2Vra0lQTHpl?=
 =?utf-8?B?OWI4bk9UYmcxSEZRUUVMZjBLOXNVYSsxaEVmT2NGbTJTUHo2cXJwTFVCc2Np?=
 =?utf-8?B?cmQ1MmlTK2VhMmoxL25nU0liNWZ3NmNtSThlaGt1TUpheTJSWFJVMkhKY3kx?=
 =?utf-8?B?TW1Oa0kyc3UxV3lYTFprSTZURWJLUW9KQzF1RjNidWJLS2R4bU5SMlFTVk13?=
 =?utf-8?B?NEpWZjI4OXdGaHVTNmU4eFdvS0h2U29ScUphNEVNM1RneDdmTDZ5SVFlVTVa?=
 =?utf-8?B?MjNIUUpQUHVFRTRyRlg5WUdWTDlKT29vMFljVHZyOHR1U3RCVDlxYmI3YkhG?=
 =?utf-8?B?ZmptK3JBYmM2Qk96WWNROEkxZ0VkYUhsNmN3TnRJRFdwWWh5bXYyMU44dERY?=
 =?utf-8?B?OVZrem5ndnJiVjdXS2gvME1TUzY4MHVmN091RWZoWCtqbDhBaTlSOGNOdG9C?=
 =?utf-8?B?UDFKM29NK1U5TjRpZk9NKzFpY3FFY3c3VTRMZGcvaE1BYTcvcmlkb2FsQmhu?=
 =?utf-8?B?ak1mZDd0S01HQUt5WGZ4RFJlbzFtV2FmbXRvOUEya0NCZnBLRmxSTWptSnp2?=
 =?utf-8?B?RGhkdlRILzJyOVVPbWNhVG0vdytWdSt3Z2hHZGRFQ25Ka25jZnQ5Q1B0TzBL?=
 =?utf-8?B?MVRZRGVZOHZkMThaNnNRRjlRR210bkxBY0Q1ckV5UEcwbEF2ZGxOR25aWm1V?=
 =?utf-8?B?RjJaNzQyV0prUmF1YjhhdWVOUUdST1dubkt0MlE5L0kya282M1owWm9vd0hB?=
 =?utf-8?B?NUtJWGw1cG91bmt6d1ZDZGJVUkJpYzdpZjR3MkhJYVVYdFVkWHJ0SHEvWFlY?=
 =?utf-8?B?NzVNcUo2anRjMmh0MTlUOENkcSsrUkNCU0JsWkxMLzR0Znl5TmgyUG1ZSkk0?=
 =?utf-8?B?NWNyTndPc3E5aTZyOWExb0IwWk1rT2dOV3dSL1FzSXBHT3RMTENXTXI3TjVB?=
 =?utf-8?B?WkZDUFJsRDAwSVJZNEgwODVsVXJBWWNMVFppa2xqNlRuSE1TSzlYMWFGelYx?=
 =?utf-8?B?eWorM3ZlWXR0cU40Y3VMVjRvYllrS3VDUythWCtOQTV5K0V1ZjF0YmVoWnFw?=
 =?utf-8?B?c1dsaS8veTFBT3pFUlVORkt6V1ZlZ2t2dHhEWElkZURMcG9pWUNranNWYjlp?=
 =?utf-8?B?WlFiNmdnN2dBaTE1WlFjZ0haKy8rWlpjSHRJcW52ZmNqaU1la25HUSs2OVFE?=
 =?utf-8?B?dFFVVWt4MGp1OVl0emlpN3JiWm5xTFFScW1pUzY5Ym9XcnM2VCtxMXFvRjBT?=
 =?utf-8?B?N05uRTRoTm9LVjlhNHFNazJWNm5LT2lkRDMxNHI1dzNQT3BmczBrU0NoelFI?=
 =?utf-8?B?TGxpWGplK3MzVWpPNk9hcGYvOGs3c1VuVWg5V3QrbDV4bnU3WDQ3OW14TWtu?=
 =?utf-8?B?Tk1xUkd2SHNTMjZtQXhIZmlCb3VGcEJyMERlQlF3OXY2WldHS2ZOUDVpQTQy?=
 =?utf-8?B?RTFENW5JaURSVEo1MGwzRms5Um1UbFh2WTU3WXkweUF0R01nQTEvYk9SODRz?=
 =?utf-8?B?UW5pQ3lzRnpYaGFyRStuTGxIY1I1c3hoRWNka3pTbytZdU5maVE2TmV2bUJk?=
 =?utf-8?B?eVJpZWF4SlRLSkhBY2JJWXpkMHR5c0k3ZmUyZjAxTXlQUFZ3dFlZK1BjTXho?=
 =?utf-8?B?bEpOaGRXMXZuNDEwQlFLUkIxMXpvM3RqcFdUNXdrN2MvSnpLbWtyVXV6aDJz?=
 =?utf-8?B?b1hldWp2bjU0K08wUDJlelZFbUozM2k1N29hMXExRTFQOXY4Um42dGcyb3M2?=
 =?utf-8?B?ZVRKbFgrWmpnYUNwd2c4ZGhYR3pFK2xUSC9UV1FUS2s4U09BNWxFMVRVVUdZ?=
 =?utf-8?B?ajVWQkJHeUV2MmFhaGF1ZnMvbFh4ZndJZGRxSVVHd0dsWnJwY0lPMDdsZkMr?=
 =?utf-8?B?VHlRQ2ZWWmxuQlZUM0thYTRCRHNzUkE0eTJ6enc2ZHRqb3ZiMVRwY0htV29Q?=
 =?utf-8?B?cXU5b0xaY29VcEJXem9zTjFvRk03Mmo2am5QOUZjMUJhRHg0eGtveW5BMERT?=
 =?utf-8?B?a081VmVlNzdMMUJORVVUVHY4d2VORVFGOEJUbmhnWEdNeWMzb2ZvL2U0SUZx?=
 =?utf-8?B?RFNPRmM4UmRtb2ZQWW81SGJoN0lONTFZSnZ2YkhFWThqK0lUY2dSQitSSmhz?=
 =?utf-8?B?UVJWSTRhVzV4bU9aelBEejg5Yjk3bHYzTVFPYzZTbENVV212QmtCQnZvSVBK?=
 =?utf-8?B?Rm82SForaDZWem1wQUhsMHpBWTB2ZzVIWFVsTmlsVXB1dTNWYjZzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a70f631-6fce-400b-9e94-08da1186f84e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 13:21:01.8350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnCnyoGDtI9NdD6oyZq+ioCvcQASjvcdPUmSe2MsnNpQJDTC+dsM6IPe7J6Dp28X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3470
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well that is a really bad idea.

Tools should only use sysfs functionality, not debugfs since that isn't 
stable.

And I totally agree to Hawking here. As I wrote on the other mail this 
patch is a no-go.

Regards,
Christian.

Am 29.03.22 um 15:18 schrieb Chai, Thomas:
> [AMD Official Use Only]
>
> Sorry for the confusing commit message。
> This interface is only for amdgpu ras tool new function. There is no impact on currently existing tools and scripts。
>
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, March 29, 2022 4:33 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface
>
> [AMD Official Use Only]
>
> I'm not sure I understand the fix correctly - It seems to me it is trying to stop user/test cases that initiate error injection request back-to-back? But anyway, we shouldn't make the change or leverage debugfs for that purpose, and there is no guarantee test scripts/applications will follow the rule as well.
>
> I guess we need to identify the root cause case by case and stop the invalid request in kernel driver.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, March 29, 2022 15:39
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface
>
> Some AMDGPU RAS debugfs operations like UE injection can cause gpu reset. Before doing the next debugfs operation, the application should call poll to check if the gpu has finished recovering.
>
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 ++++++++++++++++++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  6 ++++
>   2 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 4bbed76b79c8..337e3e247a45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -452,6 +452,12 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
>   
>   		/* data.inject.address is offset instead of absolute gpu address */
>   		ret = amdgpu_ras_error_inject(adev, &data.inject);
> +
> +		if (!ret && (data.head.type == AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE)) {
> +			struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +
> +			con->ras_ue_injected = 1;
> +		}
>   		break;
>   	default:
>   		ret = -EINVAL;
> @@ -464,6 +470,30 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
>   	return size;
>   }
>   
> +/**
> + * DOC: Support AMDGPU RAS debugfs poll interface
> + *
> + * Some AMDGPU RAS debugfs operations like UE injection
> + * can cause gpu reset. Before doing the next debugfs
> + * operation, the application should call poll to check
> + * if gpu is in recovering status.
> + */
> +static __poll_t amdgpu_ras_debugfs_ctrl_poll(struct file *f, struct
> +poll_table_struct *wait) {
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	__poll_t mask = 0;
> +
> +	/* For UE injection, wait for gpu to finish recovery */
> +	if (con->ras_ue_injected)
> +		poll_wait(f, &con->gpu_ready_wait_wq, wait);
> +
> +	if (!atomic_read(&con->in_recovery))
> +		mask = EPOLLIN | EPOLLRDNORM;
> +
> +	return mask;
> +}
> +
>   /**
>    * DOC: AMDGPU RAS debugfs EEPROM table reset interface
>    *
> @@ -503,6 +533,7 @@ static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f,
>   
>   static const struct file_operations amdgpu_ras_debugfs_ctrl_ops = {
>   	.owner = THIS_MODULE,
> +	.poll = amdgpu_ras_debugfs_ctrl_poll,
>   	.read = NULL,
>   	.write = amdgpu_ras_debugfs_ctrl_write,
>   	.llseek = default_llseek
> @@ -1837,6 +1868,11 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   	if (amdgpu_device_should_recover_gpu(ras->adev))
>   		amdgpu_device_gpu_recover(ras->adev, NULL);
>   	atomic_set(&ras->in_recovery, 0);
> +
> +	if (ras->ras_ue_injected) {
> +		ras->ras_ue_injected = 0;
> +		wake_up_all(&ras->gpu_ready_wait_wq);
> +	}
>   }
>   
>   /* alloc/realloc bps array */
> @@ -2279,7 +2315,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>   	INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw);
>   	atomic_set(&con->ras_ce_count, 0);
>   	atomic_set(&con->ras_ue_count, 0);
> -
> +	init_waitqueue_head(&con->gpu_ready_wait_wq);
>   	con->objs = (struct ras_manager *)(con + 1);
>   
>   	amdgpu_ras_set_context(adev, con);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 606df8869b89..aea6bbb71501 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -379,6 +379,12 @@ struct amdgpu_ras {
>   
>   	/* Indicates smu whether need update bad channel info */
>   	bool update_channel_flag;
> +
> +	/* UE injection flag */
> +	uint32_t  ras_ue_injected;
> +
> +	/* Waiting for gpu ready work queue */
> +	wait_queue_head_t gpu_ready_wait_wq;
>   };
>   
>   struct ras_fs_data {
> --
> 2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD92EFA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 15:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE8A10E676;
	Thu, 27 Oct 2022 15:01:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E72E10E66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 15:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLJ8/YuqXS2t9vMcA864Va3WjHulaXvRZabR83OgV4fq7+aThatdH+xmlPO1EbrgzZLeK+U7wMEyqscCtz+Ac6ivZZtNQtoBhz12xJlCjjZidEXXYZavgWRetrXzEB3s+CrqjfDTaDNyTkegS2T+Ikc6YbPratSUVEGDxnbkMyqaw0/XB2V74HWGkq5I+QvwEHD6yAOX1/Ye28HycijcUl9MCDfU7GTUJORoAvQwlLm7gIwzBC636dLJZzLMs+YxEorvA4Kiohy6cN0pmARShhE+guGiwbwwDw3XBpaoSSpiDji1G8lZ9sUo24pA2RDk1AguJYZJsEmlE+3Z6kur3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66guXA7e3oZWssF2yIkG446Wzq1Qf2uHoA0rLnCnDw8=;
 b=T8kwhnW50X3r3dtuujmOE78oATqrlYJDR5msobLDKTgTpfpPBcUq0jZthhghGm1LX0glxF7HnDQJspXgVS7zd+5N4mh9aM9aBaBpqu1Qqap4jjS6LxA6AWAlLEX/H/sS2ScTqKymwOfUI39hQqOqaKWYenye0J//XwEZZ5V86r1AFmMsbAajTLiwWXYhS1PBlnr/RCGJSJG2kITIoID6n5sZMqFEYCMsmBO5Y/HFpZ+0Eh+xSb3fXDgPt3p9q9IUbSNZkl8ceNTVNLMgdTy3PQiPFI+b22DClWmofPwISp0zyZ9dMyDO2h+DPulB/g1uDu1bBGo9GnZotXArSmIH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66guXA7e3oZWssF2yIkG446Wzq1Qf2uHoA0rLnCnDw8=;
 b=LfL7A39rkPd9aBucVwsJ2Lp6UR/6PgNhIz3+GjKP5+WHor1VRjYFZTd0hkRZE+SpIZhratcDSsZm8Y2PYxGBCt3gAjX1VcX1EBdkRVy5U97YLlzgEy1+GueXsI3HfptZZUGMH7IDdFehyMAEd4nQIvQagXbis5Gd85qzLiWFOhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 27 Oct
 2022 15:01:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%7]) with mapi id 15.20.5769.015; Thu, 27 Oct 2022
 15:01:53 +0000
Message-ID: <a61d3844-59f1-d75c-f006-8eece23b8e40@amd.com>
Date: Thu, 27 Oct 2022 11:01:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: force read discovery file if set discovery=2
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221026031354.3230715-1-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221026031354.3230715-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0031.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: e332f960-bcc7-48e6-cb99-08dab82c2edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+tErCxXRS3a9WGWBXxxQ5dxy6px+EDB8jU2Re+8wThO1BrmaMFUB0+UrY04XQgLXQgAa/314F6qqxWD/czgyrPTjKSuHVhUEnlpHOrBj3j13qSK1mP2wuMNyBVx8TTcAPsshse1yf1tO+PR63yHRgUkSKnOtXA9MejATaqbbmsQDSo/br2XArAmcNqmUwJhquzmKggYcmLhGidhW+2jOhSKI1RZSug2NQrN1fPC8T1Qb6xc7NiZUj+X4tmqMAZRwBFX1kMIvhCClAmQy+NZb9pbtJbMzbh8nMNcrTqmiQ4x0EJR6uUa3+9NyxaZsXWtbq7nfgOvy7KJv5bnNOLRaP8O7lo4vck+kap6HdUTgdABgjXVE+yWWfvfxgWtZNzWGP+9/9ENfiftIiL8eIFmfE8RK3anf12TqZmTHE78X2JK65CrcaZfntJDBe2KItNlDkAVwuKpsmBzVn6GiEgm62BSIrcRCuYd8nnzSpKt4w9PC7iWtOTSZ5tbK1t+p7Z9KsdZf0TDSldUgHPW1cg4+Cj8uQefKlbJ80azhbpkNXBwJtEgrjAPMB674fgNvO8M4b2WSFvneLJT1B9NVmTwqYQZO3eCF6aGJt5nyyyym9vx0paD4EV+0iS1jFK6G9F0Ayc2Kelh2WNnCc8PwUQCqcU7A6mG7pBDGSzF389m9VwcioIpfwO+bcLMGVBfkxhEzaqjKQmxkbCne6AhR6TTz+WFRbk7P6k51QZYno498nvEoGLFewbWawxNg5Bz7Y3rJ9VGhRGKnX1LSVXNHCZSvxMcNbu1K6IbUp8SYiOOHO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(6486002)(8936002)(5660300002)(83380400001)(31696002)(41300700001)(38100700002)(4001150100001)(2616005)(66556008)(66476007)(8676002)(26005)(44832011)(2906002)(6512007)(4326008)(186003)(478600001)(86362001)(316002)(66946007)(6506007)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1dwc2h6aHpBVGRucHRmY2tLTHhTY1RmMFdYU0JWLzRqb0VYY1d4ZkxZRGdQ?=
 =?utf-8?B?c1JFT3MxanUzWkpob1FKZXVraXQ5a3NEeldvUCtuMFU2UFFzYzY3OFB0UHVj?=
 =?utf-8?B?WEI3VTJpNkY0ZUp6ZGQvbVZiTTBmR0lzTTNWWVZwNVZaT2F3aUpTOStmUkxn?=
 =?utf-8?B?NlhoNVpoc2YxRzg4TzdYR0d5MDA3WURwZDU3NFc5R01hQUVBNmdmZWFmVVFy?=
 =?utf-8?B?RFp2UDVlUDJXZGF1d01lT0E1cWM2QklRdUdNaTA5VDA5bUJ2WkhUaWU3UWkw?=
 =?utf-8?B?Y1hQa1pOYXZPUHhTa1hBMzN5Wjd2ZVV5VnloaVNVOGZKZ3FiNGhhdHFXVkVE?=
 =?utf-8?B?eWZ5cWJyM2dSZFBYQkM3Y0hqVHRteG1CcTlsUUdtbkUxVTJFMXBBeFlJQjZR?=
 =?utf-8?B?V2s2NWxqdkpIL0cvS1VYaFdaVkx1UmZyNXJuNXdDVzFSNDlHaEdIT0VienJL?=
 =?utf-8?B?cGFRQlozbEhVbGp5ZzZVUklqd1gxTUMwNEJra0R0ZUphTUVvNEFkZ2paUzI3?=
 =?utf-8?B?M0tKRUI1cUkwOHJzNjNJcFZ5dTJZRTlabnI3QnhzZnNSMUYyUVVYYSt5bGQ4?=
 =?utf-8?B?UWpJMXh4UkozM09VMDA5cDgxOUo1Q0dKMTZVZVpuVlQ3aGtEcy9POUQ5UG16?=
 =?utf-8?B?MGdoaFA3UXVMT2NXK1NXc2JPcXhDUGtTNmdySkdheFlONHB0V3FIN01CYnNY?=
 =?utf-8?B?NFJIRHVabFNPTktNQnBvRE9LakFES0twekxVUUV5L2tZWnB3bVFxZTE1Q05W?=
 =?utf-8?B?SFdKc0puZkJDSDhqK2lXcnJaTXRzeGVIaFllUU5JbUNUWk8yL2RJOHdPZ3pQ?=
 =?utf-8?B?dVFCUU16WDBSVFNyTzM3ODlDNzJoa0tYVUtUd2luS3IzSlkvWGpmY1N4TXJH?=
 =?utf-8?B?YUxQNDVFVktON0U0N2NrZHUwMmJUQlVaQ2RIS3hDQThRZjZKeVVERkJoTEw4?=
 =?utf-8?B?YUxjVWFyblRlQjBwaFNTaFB5Ymdha2Q2eHlsV1pGNUlvSUE4Tk1jRDBOMmE1?=
 =?utf-8?B?K3ZyTGZhMG5tYkMwdkdXRG4xblBGZm1pM0NwRzVJL2dlNEpld2tad1BMOTZT?=
 =?utf-8?B?QWRMMnlRSDJqeHEzSnVBR0MrNGR5Wm9hWjZrUHBHUG1UNWNMYVBZWHYyc1Z3?=
 =?utf-8?B?T2xXODAyQUp1K25hTzVIejJPelFycDUvdXIvb3NaV09lWmorMnVLVU5kZnpR?=
 =?utf-8?B?QXh4Mldua3AyTm85TlhCTTVsTXQyN0JkZUc4ZDlWY1RrYTQ0UG01QVdWYkF4?=
 =?utf-8?B?blh1Q1F4dERyOEQwV1JJeDNzdThEdjcwZWVBYyszNjloeW1LNTNOY3NvK3Bi?=
 =?utf-8?B?RFNtWjUvTEtnY3NUaDBOek1JL2R2Y21ueURQMGhrS3kzdURnQjEzcXlFQUx3?=
 =?utf-8?B?WDFZUkwrTWhheDVSN1c0QUg0Rkh4OTR0eHAzVXUzR3U1NkZTUkMwNG5UU3pC?=
 =?utf-8?B?VXVqTGsxUWlxTGZyVmUvVGZoSkdnQVhQTEpHSDdJZStrd25EZW5qdWJ4WEZy?=
 =?utf-8?B?RE9JTC83bVdWQ1g2R0FISnFZb2pOSlhGcDZtVlRxdGQ1OSs3Z2lYSXB1N0cx?=
 =?utf-8?B?WWRLdURoYjYrbi8wUGJPNkFzTnQvTXM5THJmSjRsdGwrNEk4Zm5mb2t5b2o2?=
 =?utf-8?B?L0FPU1Z5UXF4VkRrSWlvMnNGeGtUR2twdlB2cmtpblMwMnJBejZENGZ6cGpm?=
 =?utf-8?B?UWx0K2F1T3BRcndmOHJ2WldFejZ5dml0RGJmU2RCeEFKNDhvZ0JEcmFaaGNS?=
 =?utf-8?B?UmFUR3hQZmxFM0dETHB0NGs2RmgwZ1g5VVRkVW95REN6MnhkbDFnTlpsQlR5?=
 =?utf-8?B?TG83OHFyOGZLTit5QjIwS3VMczd5cDV0bjRzekc0bk03L1dKVUtkSDcyZ3lL?=
 =?utf-8?B?VFlSMlFmSVJuWVFCT0VtenJ4b2o3RnhpZWl3Qk9VcVdmTjlOd1V2U3pQRTRH?=
 =?utf-8?B?TGdwMFNIdVhmT1U3TFJFbzdNVHJFeVNOWW55RjNVOXdDbUtxQ3BITkZnZ0Mz?=
 =?utf-8?B?cDNjQ05FYkhJRGdkNk9pa0Q4R1VRYzgxdkU3QjZCbmJpQy9iSDRhNWczZ1Rp?=
 =?utf-8?B?ZmN6cDVTdnBpVmUzdUxFSndBZE5lenpicHh5QjY4N2s5aWl4N2Zzb1Zad1U0?=
 =?utf-8?Q?VVgg58mcM1jCrYMNP+i5J5Cek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e332f960-bcc7-48e6-cb99-08dab82c2edb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 15:01:53.2449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/Xo50f8pA+A1EU654/1RyTGQMVW64XHMYhOAUhPC0wWf7z8+9RSR/1iefuzVKWaWvLT+ZihOenfBgh4f3RDhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Aaron.Liu@amd.com,
 Xiaojian.Du@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-10-25 um 23:13 schrieb Yifan Zhang:
> If discovery is set to 2 in module parameters explicitly, the
> intention is to use the discovery file in FW rather than the one in
> BIOS, usually because the latter is incorrect. This patch to force
> read discovery file if set discovery=2.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 3993e6134914..5ea9afaaf4f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -305,8 +305,13 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   		goto out;
>   	}
>   
> -	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
> -		dev_warn(adev->dev, "get invalid ip discovery binary signature from vram\n");
> +	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin) || amdgpu_discovery == 2) {
I'd change the order of the conditions. There is no need to check the 
signature of the one from VRAM if we're not going to use it anyway:

	if (amdgpu_discorvery == 2 ||
	    !amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
		...


> +		/* ignore the discovery binary from vram if discovery=2 in kernel module parameter */
> +		if (amdgpu_discovery == 2)
> +			dev_info(adev->dev,"force read ip discovery binary from file");
Missing space after the ,

Regards,
   Felix


> +		else
> +			dev_warn(adev->dev, "get invalid ip discovery binary signature from vram\n");
> +
>   		/* retry read ip discovery binary from file */
>   		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin);
>   		if (r) {

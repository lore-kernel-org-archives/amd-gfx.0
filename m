Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2965C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 12:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567FC2388B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 12:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567FC2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981B66E81B;
	Fri,  8 Jan 2021 12:17:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82CA76E81B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 12:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsqKlJtrGyDj+OhZc5674xbOi22oYrsUqEDiEaJ1ZNarz0p1olhH8KB10B/om56WpVPDP3Gl1i8esPPaRt/GzVFPV3Az1px1p3yNio+DeyD9+zj09eFO0U0r1lV46nV6jbwSVBg1KlbHgdbC2i7F2KIhY77RaAEEV38qqibaDgEaZ8XGiNhKoTiD71Y5q6Xi65TQ5w6fRpklASzLJIY8mNHRXm14CWCHWTJBTYiPx4j5K+dGy15pijV2ksm2qGCVtJqnlk+QEPEKxvbIpu5IPVkpKz6o4nk0hDC15vbB+2cLYnv8LsAXWx9/n8ZkhuwdjIi3rQVtIPLyalcnFlt2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kOK20F5fg2SIzP9Rx32YvRMVc1ioqWqO8k25oJDkMo=;
 b=judKyg/yZaObZfqFhjUShyVeV0zmV474+UsCNcu5R6/cMIMr/JTQiUXykWhDZN8M22McK4EBI7M/IL3ieUoNiut+wrDZTKD7E5pTXQgakhwIp+uo4DdD6/ECetXDJSNLUSoKrVTMRm75G1QKG2k+4cXsHbZtQaTNgc9IpPbWo8DGEE/ZS5IaFcIp2jHlQFih7zHWmQ5zWMmkakljhekrtfXjJ5IiOp8EQQz5zUUbU5IL2cEajDu8ix7rTyopLZpne4rIRKgEIJM82l8Spe8dyBV/chizW89yPUQpRqYo2uqpA9lLH3Mkg2V7fs+0pqSs4Zc4nMKIrLBm35jGbrbs/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kOK20F5fg2SIzP9Rx32YvRMVc1ioqWqO8k25oJDkMo=;
 b=UzfjCYMZAfDeP5qUdI3JdvUCZ4VNZM/WpIWABSlN9rnXllvOdUNAfaF/iIBpIkDe00YJgl7Wf+utoPv6MLOa4C6dMHFJ26Y/abNKrehZoP+036sO+ODm/AX83d0jR020R23heDI3ueb6P4M8qFeWK0IdbXdYOO5zCAb0rJAdc6o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4660.namprd12.prod.outlook.com (2603:10b6:207:34::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 12:17:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 12:17:40 +0000
Subject: Re: [PATCH] drm/amdgpu: fix issue when 2 ring job timeout
To: "Chen, Horace" <Horace.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210106124258.31129-1-horace.chen@amd.com>
 <CY4PR12MB1573ED17C8D9078A8F1A4D65E1AE0@CY4PR12MB1573.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7b946fa5-9113-2a0a-694a-955da138368d@amd.com>
Date: Fri, 8 Jan 2021 13:17:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CY4PR12MB1573ED17C8D9078A8F1A4D65E1AE0@CY4PR12MB1573.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0161.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0161.eurprd02.prod.outlook.com (2603:10a6:20b:28d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 12:17:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ce003e7-f9ce-41c9-1162-08d8b3cf64f9
X-MS-TrafficTypeDiagnostic: BL0PR12MB4660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4660BE3124AAE16D3671D18B83AE0@BL0PR12MB4660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNvrUpJmYgMMQKVWAobDnbT4BZQ+upyg6aJAUMYtQkj0Ek9UN7jbCBFcpQE07a3tUXKZ08zqZXqvgcO85dn2G0LlD6YRknePBPPAEen6uWCRU26ujKrGImPfrjClfLo3tLnN0L+6xaJ+66a0LPT1aLeQuaW9F4HjG1rkb33a94BPmAFiAgA6Ohl2c/w5Ae0ICmxjNmR/DySsoXrVhKt2MXBfg49ovUQGElCXpJu2evTM3KpcUMWKyM7pk8OxiKSDghXTT6XNZw6jKJscogkoAc2uHad+Pftq2pKJqZGT8LykNHX/qhEKsW3MrHHv1rMydDOTbrHeZjRc/E5NSO2JG+eKmdsKHoF0fGX5NvJrkQOTDIOasxfGdUwWZ2HUHLiKSfV6qqXBhwb+MvqSm8ZXNzABVCZVhrUdOpXNnRJUrB8QwDnqo4RUCm+MwjpkhMvd5Ujece9FG2z9LrXe/++JRb3wJhxQdKzyE6ZmGobfeps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(66476007)(66946007)(31686004)(2906002)(54906003)(53546011)(6486002)(52116002)(478600001)(110136005)(4326008)(8676002)(66556008)(31696002)(36756003)(2616005)(16526019)(186003)(86362001)(6666004)(8936002)(316002)(83380400001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SjRHdWxwTmhYYjNwNFFuOFhWUG05ZnRneTZBTUpwbjREUExySW40S1RCM05q?=
 =?utf-8?B?bS9BTmVmYUpuZldMT0N0NHVNeWp0ZWgvRHBrd29NZjRuVmxWN1ZEaFh2aWN5?=
 =?utf-8?B?WE95YWxmZWtwY1UyUVY2SUkxMlJRUnRZbys5SmlWN3JzQlFENFF4L1dianBh?=
 =?utf-8?B?YXA5UEpwMzZvbStrT05mMkIrYklpK3lmYml2M3JnVkgzQi9nbzZteXcwajdM?=
 =?utf-8?B?UEhNZkNaQW51a0FXVG4zUG5Fd1cvSXNsbHBQMHlSTCtSZVpuUGxwWWVXT1Yz?=
 =?utf-8?B?UzRxMzh5NzlkMTFnUlgrbEVPK1RRV092bFIrcTZpMDRwUlF4MENiSGxtTmho?=
 =?utf-8?B?M2FydDlkR2djUThWOE55UjNPZzJscHQxdnZNa2kwdnAvenJhNHU0UStkNzI2?=
 =?utf-8?B?RTM0SzFIa0FTUjVQU0FhcGc1ZFpPcFY2ekxxbUsvYmdRMkFrWXdtcTFDOGxl?=
 =?utf-8?B?bWs0VjRGUEg5R0x1QUxSRmFSU2JsU3lYd2d3NzJFQy9KY3BNN1VtZWRyN3Ux?=
 =?utf-8?B?dFI2anNLdUhJWWtVSnBKcWwweC92OVNmb3BnSEFCdWd1cDk4TnpWVzQ0OFNV?=
 =?utf-8?B?cWZlenhSSEVZLy94cnMvSGI3dXZPM1ZXU2thU0FtY3JhbHFlUEFRMy91NXRK?=
 =?utf-8?B?WmN0Ymhrc1Q3UllQVmhtanNvU21LVFlRQXoxemlFbzFKQUhrV0FESHdUNHBs?=
 =?utf-8?B?b2lpVjFMczU3TnRPbHpEVEtmTENTTGpzSnZ3aEpsdHBUOWNyS1pKUGJ5R05u?=
 =?utf-8?B?aEVpWHJuQ2NnR0xKWHhrZWNvaVdOdFRRWlJ1OHRtSytSVUtSeUZ6cStDY0M0?=
 =?utf-8?B?NW0yN0l5V0hQejh5ckNSOUVqL1ZNK3k2NWp2dmxNaHYrTUhVUThxWVFjNjVx?=
 =?utf-8?B?a210M0FJM1RCN2F4K3dlcUZPSE11VW5XVUU3LzlJSXVpSFVKTGd4ZGF5OHh5?=
 =?utf-8?B?RE51MW1xM01kZk9UZkRJYjArQVJHSm9OVjlOMTdDaVpYYUNXeU9UT29TQ3Rz?=
 =?utf-8?B?ZU1SSEZ3V2FUNjZiVE9OVWRFTEN1VmRXWmZCSHQ4WkI4VTg4cmJpdGNlYS9q?=
 =?utf-8?B?L1lkbU5QNitjZVRUUWlIS1dPQzVmZTBHem9NM1lzbjZpUWtOUHJZaHBMcWor?=
 =?utf-8?B?QjdWMURnVENsaThPWnlYU3FmaVFoZG1qeWswcm5SNjdwUHdlTVlyZi9xNEFQ?=
 =?utf-8?B?QU5JODB0MFFkWTZZTXV3YTB6d0RYQU1jQWlXRTF4ZWYrQUVRVlpUNVpmRHhQ?=
 =?utf-8?B?RkNzcXNiR21PNzNrUWZnZWl3R3MraGtzOFZtM09ZNVZhcHVJTzRTZDhNUXVU?=
 =?utf-8?B?SUdtQW0yWDFjYXJVZ1hOeElCN3ZQSm1MWGk0WjVnZnJDWjc1N3ovOGhCNEFk?=
 =?utf-8?B?WHgwY1k1N2I0OElQdnQ3d1ZIMkZvUjZ0U0lnUEdQUEtPaVo1UmFkWUNpQlBW?=
 =?utf-8?Q?Izn+9IhQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 12:17:40.4353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce003e7-f9ce-41c9-1162-08d8b3cf64f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cac9IGmjwgTrb/paZPyb0aAaTFjaUxGHs3o/CA7MDDAgaYn1ayFPV7PwfpWfAGn9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4660
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Horace,

Andrey needs to take a look here since I haven't worked on that code in 
years.

In general I still suggest to unify the reset code for hive and non-hive 
code paths which would solve this quite gracefully.

Regards,
Christian.

Am 08.01.21 um 12:34 schrieb Chen, Horace:
> [AMD Public Use]
>
> Hi Christian,
>
> Can you help review this change?
>
> This issue happens when 2 jobs on 2 schedulers time out at the same time. Which will lead 2 threads to enter amdgpu_device_gpu_recover() at the same time. The problem is that if device is not an XGMI node, the adev->gmc.xgmi.head will be added to device_list which is a stack variable.
> So the first thread will get the device in to its device list and start to iterate, meanwhile the second thread may rob the device away from the first thread and add to its own device list. This will cause the first thread get in to a bad state in its iteration.
>
> The solution is to lock the device earily, before we add device to the local device list.
>
> Thanks & Regards,
> Horace.
>
> -----Original Message-----
> From: Horace Chen <horace.chen@amd.com>
> Sent: Wednesday, January 6, 2021 8:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>
> Subject: [PATCH] drm/amdgpu: fix issue when 2 ring job timeout
>
> Fix a racing issue when 2 rings job timeout simultaneously.
>
> If 2 rings timed out at the same time, the
> amdgpu_device_gpu_recover will be reentered. Then the
> adev->gmc.xgmi.head will be grabbed by 2 local linked list,
> which may cause wild pointer issue in iterating.
>
> lock the device earily to prevent the node be added to 2
> different lists.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++------
>   1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9a3cb98d03be..233dae27c8eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4620,23 +4620,34 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	if (adev->gmc.xgmi.num_physical_nodes > 1) {
>   		if (!hive)
>   			return -ENODEV;
> +
> +		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> +			if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
> +				dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> +						job ? job->base.id : -1);
> +				r = 0;
> +				goto skip_recovery;
> +			}
> +		}
> +
>   		if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
>   			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
>   		device_list_handle = &hive->device_list;
>   	} else {
> +		/* if current dev is already in reset, skip adding list to prevent race issue */
> +		if (!amdgpu_device_lock_adev(adev, hive)) {
> +			dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> +					job ? job->base.id : -1);
> +			r = 0;
> +			goto skip_recovery;
> +		}
> +
>   		list_add_tail(&adev->gmc.xgmi.head, &device_list);
>   		device_list_handle = &device_list;
>   	}
>   
>   	/* block all schedulers and reset given job's ring */
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
> -		if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
> -			dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> -				  job ? job->base.id : -1);
> -			r = 0;
> -			goto skip_recovery;
> -		}
> -
>   		/*
>   		 * Try to put the audio codec into suspend state
>   		 * before gpu reset started.

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

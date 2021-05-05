Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5296EC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 02:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04F461168
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 02:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04F461168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7216E0AD;
	Wed,  5 May 2021 02:14:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5ED06E0AD
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 02:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0D2HywYQ0EAlxbki+MAXo8iJJD5cp6uH8VjpdKCii2jb6udMKh387lwBikt2N83SC1nDag85nZUOoBSNyjXRF68QtaG1+wiogUh7PLR7qnkhw15I2uDiUTdrZIk2H4xJ7Q/0RsTHc3SmMRcYoiDQucW3PEBJkOjjeUI6QvtZkmNvjyY0hoD9/MF4tw0/Uz3Umc6JOCAB6RPrrw8ov+lsmrqaM4vZ6Y6Rwj8fgSR5di6BeWllODQd+TwhOIVYAFc7mxz56Wd+KuMKGj/gIPRAjPt68uYmN2JDHtAdq7mfpvst4HBYS32yoUQTu+nN9aNC218QYZwjXHe3nK3/nabkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtNVTf30edOytYrRd5ox9WkpHnifMU1zI48MMhfduk0=;
 b=AnZNdJLxhZneC+Bc6gZswj3C1bcnXRXG93XSYbOwDgquzVUPWZdt7G3aEDU53uDHMoc0/kIWVh3P4kd1eL5R8PbrF07Nbe96WntLBpsQl198ABKHevEGZPihJYopK37F5lHKw7LqVgNr8XcfrAGvBCphSk8L/KdUglJtcWpIY28AEdbeOIW0i5Fel4mWatLTZku3Hw7Zjl26s0eZjzIN0Lsi8grJQGsuk6CalxkO3bNH9gsNXUPxRPmRettinqYdbIWaeFKSEagWrIKB8Yi4Vz0kYSULa6Lg6ppFye2k1jhA5OEAqhdc8htnJFyueDiIJNWLMmqi0bU4Sm0+X+AwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtNVTf30edOytYrRd5ox9WkpHnifMU1zI48MMhfduk0=;
 b=siWYBTIuQe00dEeTgLpsmGIz6u43AUtNc4MWwnUaEnDo+EN4NQGKH4X6I+j6KiqgUUJxEWRrXhew/GjDCGG/w8epSGgpVO2ms0TakAwevFK01w/ZgKZkId3luDOJYDnap/jGT8lJHi8rDKuTc8SDLc9R+G2ET3tCou/D9mrV9mI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB1562.namprd12.prod.outlook.com (2603:10b6:4:d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38; Wed, 5 May 2021 02:14:41 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::576:3b2d:76db:55ab]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::576:3b2d:76db:55ab%3]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 02:14:41 +0000
Subject: Re: [PATCH] drm/amdgpu: Init GFX10_ADDR_CONFIG for VCN v3 in DPG mode.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20210505012749.1803406-1-bas@basnieuwenhuizen.nl>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <f9ef6f14-8f59-9b41-2b65-6191ddb3097c@amd.com>
Date: Tue, 4 May 2021 22:14:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210505012749.1803406-1-bas@basnieuwenhuizen.nl>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:c022:fa05:8abf:ebeb]
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:c022:fa05:8abf:ebeb]
 (2607:9880:2088:19:c022:fa05:8abf:ebeb) by
 YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend
 Transport; Wed, 5 May 2021 02:14:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e6ffaff-a0b8-4fb0-7392-08d90f6b8a76
X-MS-TrafficTypeDiagnostic: DM5PR12MB1562:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB156296E41BBC6045210B5E10E5599@DM5PR12MB1562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wypVAUY7fXYpyHsup4qbGzUKQP1lrQN4hUticHeI3sk/7KCN4ruTWp/cW7xEPuCfsLrPGusqZOmmrKQUQ4166F36PDJ/0K5J86fGHRAJfI6EfBDcOqeSH1FCDR+C2jYs/bILXyCQzPzoK+bNnjoxrd9SyPA4hdY2rtrWlQTzHak5+qMCZRwoYvXxTs02VIQP4I680meuz1z5IzoKWAkvX5sLNuv7rezsNaUFbf7EmaI5CICbtifCtA4hykVR8qUf4h/DHE6iCdhe+cpuGjDJiFz/dSWYA0TzMzqcAUYOXVbvNK5HcC223v4WkVsuMAELtxwTYdCVN7nQLUmSj2j1w5K+Pwa1mWdGNuW682EXWWPw6+Kf1uKeM+FCkKYAShYr0jQBVSJFkY2RGycUNv/nwsZBtfSBoXIZHrzC2uC6kJhkNzMT2VaSNfSNww9uc8I5kfXVLVlCRyTnRhPENwzgaYLnaO5mByWXtD4TTlBXC/wn2Cf7F0Yx1kCCj3YMAQACLp6CItz5F9Wz+CXOjnLyiDDKmANjT8h2cYp7Ko0ZE2eP3M17aWOsamRNMRR5SNtB3J6K2ZD5w+cYRfyZZgsp72MGV+CDj2zCFtuJK7/FwHiSOWwiewgLLzak652ipzkmpL83hVbHQq9La0BTWh1XW+9aXY+z9tFjCqYmD3Gg+nN4lskeVF7a9cYIOJbCkCRG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(52116002)(2616005)(16526019)(31686004)(8676002)(38100700002)(4326008)(478600001)(66476007)(66946007)(66556008)(8936002)(316002)(5660300002)(36756003)(31696002)(6486002)(44832011)(53546011)(86362001)(186003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WGdYaVlQNDcra0twTFJTUVVlNmRDYks2MXpTdi9RVlNkQTJyUExPQ3Q4Y3h3?=
 =?utf-8?B?YXRhSTlxVnJBY3k5YUtiNGxxTUoyU1o4bmYvVTZtNTBxek85dE5yakliQVJ3?=
 =?utf-8?B?Q0hzTEw1V3BmY0tkNzlKZG1IK0ZLR3QyRU5OZE50bG1Yb09TR0VlZElUUzFs?=
 =?utf-8?B?TEIyTlhTK0ViZ2pQVmQrb1ZmdzlFcHVFNXk3WlpmTm45TGNueVgyeFMxVmNt?=
 =?utf-8?B?dUFJZkRQS04zNDdPREJEQTFoaWlmeFZJYWFDc3lNQVE3ZlQrTUdqUkxKWUNT?=
 =?utf-8?B?d0YrY3lBcEV6WFg1SnpVa0Yxd2VUNG1QNWZ3em5kSVJoQ3hBR3Y4UURXcXVI?=
 =?utf-8?B?Qk9FdXBPQ2hwLzRwRitZckl2blgyTlpSSU9XS29BQTMxdzdseHJBQUVDVmVX?=
 =?utf-8?B?dVdvZDAyOG40Q0tROHFjNVVOQmQzS0hmVkx1WE1QakFKY2MrenBIOWFvU2hw?=
 =?utf-8?B?cmsvSlRCMHBlRXFGZ0lVMk9SV3lzQlY0VlErMDErZ2VLVERpZWZEOXZBQUlZ?=
 =?utf-8?B?bENMMmVpakNDc2hrUEY4UWY5dUkzdjljWTBJYWRHVGkxZWZkWWlOSzAwWFpt?=
 =?utf-8?B?NUZZSm54MEI3V1Y5NEEvWUdVakVqdmhDckw5VXp4WXE0Q0UzWW9rUm8zR09Q?=
 =?utf-8?B?NmNLSXpza0FCN2p2UWp2OEdKU1lDRHVLaFdRVnU4UGR4Qy9BUXNjRU1VT2FB?=
 =?utf-8?B?ejd0TFRpczcxSGQzMjFOTU5iZG9mdGNRTTNXME0zaWZBak9nV0VTeFZmRjhL?=
 =?utf-8?B?cjVTZzlWQTkvQ1poTDhobWdFelNvOHBhTlcxWWN6MDRXRXgyQWwzeTdGbWVO?=
 =?utf-8?B?ZUVRenI3MFVna2g4dmU5VWRFYlVmWVArZktNMEI1MXdnWjNpNnRoOHJKVnRz?=
 =?utf-8?B?MW5UMHpvWFFHakZiSSswL3ZnczhnUFFrc2gya2hqWjhZbTB3OWk4cWs2ckZm?=
 =?utf-8?B?cXQxc2QwQ2wrYXgzbDEvbG1MVHF0SXhxWmFhOWo5dTVZLzVGREVMb0NLQTBZ?=
 =?utf-8?B?TFF6YmNMNzAvT1l2dktXUUJWZ2V0TE1PNTA4eWp2Q0NHQU5RNXJjdWp3anFE?=
 =?utf-8?B?c3FiUlBrRThpcDZQRGVMVFZmY09UcEREMUJSd3JqODJVdS9jVGs5c1RXVmdr?=
 =?utf-8?B?UHVtb3A3QURTckwxOWdaSDRodVBXeC9OVmhBa3pNalc2M0NSa3RhcVdGeEJq?=
 =?utf-8?B?Z0hWVWk4S0ZsYytsZTA2ZS95bUVmblJ3R3JmZUV1RTFPVXNlNUJWSG9CMTZ3?=
 =?utf-8?B?ZnlqV3ZpQitseWhWMTZjY2xQRURwU2t1ejlWNjVCZ2dYRUdaQ3RFKzkycnR5?=
 =?utf-8?B?QTRqT0s2RTlWMDg3cVFQUkNKQk1Wb2EvOFJsWXBzQW8xeGJuVjVObjhUaTFp?=
 =?utf-8?B?dElpVFhOVTFudXFWNElzYkJ5Z1FrZ0lZdVZZYVplRmMzR05oZHlqOEwyY05M?=
 =?utf-8?B?aDd5b0M1dkFxQmt6ZFNMMkR3Umt2ajBUc0xzaFk5Y0xTRThhdnhOVWM5K3Iy?=
 =?utf-8?B?UFBFZmJjdW9qVnhhRGN5b2RtYW40UHlPMWIzTTZrTGw0MHpmNlBGYmxWT1NP?=
 =?utf-8?B?bmpWTjVHdGR4SzhhckxZVjU1VEFhekV4ekxBR0o3MGxIN3AvM1ZQT1J3MEs1?=
 =?utf-8?B?bCt1VzRPZmExcjlTTTl0LzZwQWt3dmlqUmhoYm5UTW1xbStIc1BhbVg0cnU0?=
 =?utf-8?B?cWtZZVc0L1FlMUxSSFcySzFJZHpPQ3ZiWGN3L2dlRmtJUmVZOHVBeHJhRWha?=
 =?utf-8?B?TU84Z2h5SFdWKzZlSXdxNVIxVDNjMUlxNSsxelc4MWJFMDVpakpwTHNMQ3R1?=
 =?utf-8?B?UGJhZ3l3d2VIU2M3NWZEeDFpbCs4UFFWNTY0dkl6MXlSN0hQYnd0TkU2ZGRw?=
 =?utf-8?Q?wz8PklP+zxsO+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6ffaff-a0b8-4fb0-7392-08d90f6b8a76
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 02:14:41.1140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBBiLGRHBPeABcV2x5cqDmWp+F/tsQy0JDrvaHN6mwGbHzhtcAsdnbMDqtxio2Fi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1562
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
Cc: alexdeucher@gmail.com, boyuan.zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-and-Tested by: Leo Liu <leo.liu@amd.com>

On 2021-05-04 9:27 p.m., Bas Nieuwenhuizen wrote:
> Otherwise tiling modes that require the values form this field
> (In particular _*_X) would be corrupted upon video decode.
>
> Copied from the VCN v2 code.
>
> Fixes: 99541f392b4d ("drm/amdgpu: add mc resume DPG mode for VCN3.0")
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 3f15bf34123a..cf165ab5dd26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -589,6 +589,10 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>   	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
>   			VCN, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0),
>   			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
> +
> +	/* VCN global tiling registers */
> +	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
> +		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
>   }
>   
>   static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

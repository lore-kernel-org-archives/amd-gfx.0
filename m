Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B69BC4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 02:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007DC10E0DC;
	Mon, 27 Nov 2023 02:42:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7436010E0DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 02:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeu8r2ENYcvEHJ4uZl+6fht5zNUi3x4zF1Aa6RRcxh24ZZi4D7wLDJ5V2inYq9UjYMI0sxr7QcnOJlc/c+1Yfbe/L/zwFgNBxVrdNakTHHIIgYAjx+NACvnz0xHzkgkdMNcaUFRFdl0rWzHjljRi7S12MDFCV3enn4taCcBV0torGjjtNH3JvLJ/kX0rptIsFMg++0IzOhRdCbIE4qXWWVZzVCqTaP4t+aQoumZGmotX01YSZDr0yKnSEm8NA7OoYizNz361fiX/+nSTrTuJpKmoD4Vxpo20uiRMSek1Mg/4SASLsFzdw5QtZugyZwuzS5k3hNnSub89fRToxVbxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvMIxZOyiexHaRFW48mvm/x+OwlEaloOGLq5hoZQe7g=;
 b=b4nTwS/bOLtEfjd/9i48jlqMkpqKBOXLrlcBngOhYxgq/TerL1GSzS3LIRT2nmeUV+eSRRzmtuF3j/ykbyZXBO2vtetqG6gJwXvgXBEdwnzB+p4T1nb6wDF2vtfYJ/ks9uLqSQ/LPJgh5ftwbhnD81tstf7w/0d5YYYqirzFIr0m2krel9Q8wo8/PTwo0eK83mUB4oucPIfW1BRUbegnKhf+jysL+v5UipeNkUwuXl1otsTO34aqZsDBMQdQ0nhBkge0DMM5J+gSWn453u9nvDp7w2opNXpgL4TS+EKPDdPFNwb8rO4sH7f8/5cklXo0qY156ekKJw3DMs1tG6NdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvMIxZOyiexHaRFW48mvm/x+OwlEaloOGLq5hoZQe7g=;
 b=32fMhcb2axxZvYiZxr5S9lFkpF1wGwaqm8kG3Rtxw0lvu6Xq1xPF3A3yy41Lk6kSkbXRIX9Y0QQwF5m6XavHC+eMJvnlJHutEDdHJoe1ClVXK6UzVCXb/OL57p6dSAJ4NimvitKjmyvWI5y300nBERw0+T0fwlWe2QXpWO7CK4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 02:42:44 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::cb63:20d5:2aeb:f1ab]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::cb63:20d5:2aeb:f1ab%6]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 02:42:44 +0000
Message-ID: <3a94bd18-bd1c-9608-9b14-413a13e854ae@amd.com>
Date: Mon, 27 Nov 2023 10:42:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amdgpu: Skip access gfx11 golden registers under SRIOV
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org,
 yifan.zha@amd.com, horace.chen@amd.com
References: <20231123085714.254103-1-zhenguo.yin@amd.com>
Content-Language: en-US
From: "Yin, ZhenGuo (Chris)" <zhengyin@amd.com>
In-Reply-To: <20231123085714.254103-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To MN2PR12MB3663.namprd12.prod.outlook.com
 (2603:10b6:208:16e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: d54aac8e-cf46-4c43-e821-08dbeef28819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9M77tlzHiGZbd3StqY3U1vHE1Wo/CbHqHct6M6YZOVwy0gcKbf4jxrBhywWiwFXKRx0O9rIlKpm/y+LRXHX7QIUzd0GoWXBvX1+w+y505n8YyvqZ9PMl1vRCwj3kz74bvOX8NSaGPoNl4HXqc7TXI7W3ZPQgBFnJxaqqJIrQ7UD9vWZGfLCAG7ITCwSPUCQHUwwyKxNfTdMtlumbrkvKhG/XomMtN5+8hyNmzt/funEG10eqwJJKr8g+1VEysagyWQp2kSMQ22WHmsuCu10UTeGk/sodUYeWEQg5GPtnILSDJEejnPZe06LEH0wCGBOyqlOgGMNPXprW+mLNic3A+FFbkWsNHOf4R2/vcc8HMtMV4A6A4KdjxHrcB4fSfZbU3fj6AGFGjMosky/iDVF5jVDRrj9ClxDVzlsF8gIYUKG8esCvOW4vy+KWQQQY+cQQgW8M5AxQHuDk/ZRg6OQYYDvGLpEgtDNXMQsS1IhfEf/+d4kAsFlb/+UxOZ1rhcGl1f8KHdRG0JyS41RCuChiXqgLmTWCWBQTrn4D6OWxNKj09LFq4wfgoSvvawUJM/UuGwCV8H/RQyG2twrTlxjZyv1JpszjXAhWyTXrGsg4RUPgK3abfMvdeCf3BfTuZGfTwc650ydOb5cBs+fRBsHOmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3663.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6666004)(8936002)(8676002)(6512007)(6506007)(53546011)(66556008)(66476007)(66946007)(6636002)(316002)(6486002)(478600001)(2906002)(4744005)(36756003)(38100700002)(41300700001)(31686004)(26005)(31696002)(2616005)(83380400001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHJKQlNHMHk2QkZzUjBCWER5RVlpRG00U0lYeWtnaEpkNUVZaDVRb1JYOUJY?=
 =?utf-8?B?MTNJa05CV1prNTMxYndGOXFKWk0xaE9OTktMWXRJT0pJRVI3YTdNTlFyOVRU?=
 =?utf-8?B?Z1hubSt2NzB3TWY0VWJZS3NJaHA1SktHMzRiU1hDS2phcktIeGtzMHp3L1Nn?=
 =?utf-8?B?MG53U24wQlg2Q0xSZEloU2hwWllnTnQ2R1RhOWxNaEdtR293cE4xZzU0c0VR?=
 =?utf-8?B?SW9BV0YzMmdIRWlkODl3SXppdTg1TnNhd3psRUEwTVo1TjJVQmhBUndwb0dT?=
 =?utf-8?B?eW9maWxhVXJhMllSVCtPT0JuWkRQcnM0YXRxRkEwNzJUNlJDckhrQ0FncWRO?=
 =?utf-8?B?Q3J2UHlqODgyM3YyRHFkb0xwR0tlRXZLZTllOUhWaWI0VnNWd0lyNTRxMTRh?=
 =?utf-8?B?Q25HL3I2OEw5WFMzRzYzL1lkNzE4V0o5Z2tNNXN3NldLMEZxbmpvS3MxN1lp?=
 =?utf-8?B?UW8wYm1pcXh4djllOFlod016WnlUWUo0TUZ3K1pZQlR0c3VBa1JycVNOSjlL?=
 =?utf-8?B?T2ZvaGZ5T1ZvZGlWYkxQTTFwUU5EL0xXNDNBSVFaNTI1MEZReHhndGdQSGU1?=
 =?utf-8?B?SzViY3BXa3AyMDgvYlFINVB5SExSS0VYYlV6OXZMWWVhTGVoYncraEt0ckJD?=
 =?utf-8?B?Y3hyTEJsanMzUks4dmp1VjJRSWNNdFhOTlJ0eWdzcUdmNXUyZHZnMmJ6N043?=
 =?utf-8?B?dEsxb2wvMXpQdWdjRW9EYmFTU3ppa0VvdHUvVmYyaXJHd3orMWk4N0RhMWxK?=
 =?utf-8?B?Y0g2d1NHcFBXZ0NJQmxOZjBwc3B1TjFMeTBEZHIyVk55citEemtkSnI1THpN?=
 =?utf-8?B?UHBKdU1kS0dGRnFWTlZKeCtuVzdaaHd0NHk5ZUJnUnJVYXB2Zms0UHRKZzNX?=
 =?utf-8?B?YTYrMEF6dlhvTmg2SVNRRUt4empmcU8yTy80ZnA4cDhSdG1YQlRiVlVrMU1t?=
 =?utf-8?B?UFRBZExNY1NtYTR0WFNITEROa2xTcGlvak5PZ0VERitnT1NXWkR1dEE3MEc2?=
 =?utf-8?B?Zm5jZXRkV0JhZWJkRmxRcGZuUmRFQTZxdmc3dktiYlN0bytWRFVlK1FGSEZj?=
 =?utf-8?B?UnlJWFcxS3FUOERCeWVtcncxYWJmamtqRjFSeC9sMThINlp2UFVZcjN2Z2Yw?=
 =?utf-8?B?THNDb3c4Y1FjWkNMekpQNHlXb3VMd2toc1hrK3hnYlcyZ1QvOTV1c0hTYmZ3?=
 =?utf-8?B?NVZhWnVxbTJhYzFuWHF1ZE8wdGJ4Yk9ZK1NxYTUvUWxseU9CL2lweDRoYVZm?=
 =?utf-8?B?Z3lDeUc4T1ZEVEJsSllmZVM0TFJ6Y1YvdXRPUXVzVE9ZTUNqK3llcEcrNXMw?=
 =?utf-8?B?K0ovcm1RYVM4Y2VkYzFMNURsUnBWTHR6UlMxTWlDUWV6QWkvVlpsenIxSXdY?=
 =?utf-8?B?ZzRIWkllTWoyUUpSOWRkTFVEc0NETE9UMWxOejZnWEpieVJKQ1VsdmdxTXll?=
 =?utf-8?B?b3dzNkRYVDUxMHcxNXI1YnVITVhrZFVJQkdBYURqZFpxc3pOY2dLMXZ2NGQv?=
 =?utf-8?B?ejNPVmNGdkxkbVBJY0tBUEFvN0VRRVV0RWNJSTZnU3EwRGJ5bVdYT2lFSldC?=
 =?utf-8?B?bUxZLzE4YmFVSmZwNWkwZWRyUnF2TVFEVHlSMVdUVWZGYTVzcEIvdFpOQjlP?=
 =?utf-8?B?SExwNHNaSCtYWjNyWFhJWWtqS2U3UXEyMnJiSi9iTXFEVWw3eUhrTW9SdHd6?=
 =?utf-8?B?NE8yZEVJOUV4MzRTMlpsbXpCb0xVeDg3VlJaWHNFRHVQajFnaW5samdsdTVx?=
 =?utf-8?B?V1ZIV2FxVkx3U2NJN3FTMmd5V2VvTTR3SFMzT20vSGZHcW9PV2UybzlQOE0v?=
 =?utf-8?B?QVhKYldKL1JGU0NBMHh0RFZyZWprai9NVEdPeXlGSU9kcDg2TnhObmVheEV1?=
 =?utf-8?B?SVFsL2ZvVSs2Znd0MHlRRmtjZ2lVQWQwd1Rxa1lvSVByTCtLajk2UDB1bkZx?=
 =?utf-8?B?WTF2Yk1kaEg3V2VxdmxlVy9VNDN6NndBdG5Bbm9ONVB1NzQ1aWc2OEJMUjVq?=
 =?utf-8?B?UTJoRmFvT3llQTlkNVpUbUJKMzdPY3pOSWFtMFcydjBrdmFxWkpjMm1UdEg0?=
 =?utf-8?B?R3Y2a2ZFZlJDQkV1VVRySWIyVy94bnJ5bU9LWFQ4SWtTNHRURDdIdWtZd2wr?=
 =?utf-8?Q?zMEnvYO/eVv4rARWbe077LNhL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54aac8e-cf46-4c43-e821-08dbeef28819
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 02:42:43.7380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPWrUBdbY5KQs8NoQbcdzPWTShADy6UXkYCQeYgQUocZAQ6XvNpzAlsLFoupR3OmrXUiTS5rpEMLacvsDMl08w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417
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

Add potential reviewers.

On 11/23/2023 4:57 PM, ZhenGuo Yin wrote:
> [Why]
> Golden registers are PF-only registers on gfx11.
> RLCG interface will return "out-of-range" under SRIOV VF.
>
> [How]
> Skip access gfx11 golden registers under SRIOV.
>
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 8ed4a6fb147a..288e926e5cd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -293,6 +293,9 @@ static void gfx_v11_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
>   
>   static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
>   {
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(11, 0, 1):
>   	case IP_VERSION(11, 0, 4):

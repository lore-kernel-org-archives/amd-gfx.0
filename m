Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C52BC77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 21:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B9810E382;
	Tue, 16 May 2023 21:50:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A7D10E373
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 21:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyUhDuanI1osJCpfqvsTafrH1zhiIFH6VecbCyFViBFoWGQc/4lnrhVmpLT2fcr5VwHhzhKgYezi7cnGR7s8VKxIH5wLm79FwMKsj2diJltBKlMKALbcNloyk7l4o3Zj5TLPZp3JfkG6kAVXnkHONh+YGHZp3pkX08PwN/eGYHRbZrE2kLvWgYaktldIbDf9L46C30qSG6LcV12S/pbqazcMqcCugKz09iXui9CTPXcgg94+X0vQ/+758baLccIPTLtYLM1jdzDON3QPda3HirlP+lXFk238MDbG/WL2KdP9aGjG6suKUHXpdFcmL4TqPKOwiNaIUSWakxmRMANuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV0nchh8lPtO2SBtpST6/W//Zd3rU5lCcZZNbNxAtu0=;
 b=LS/MsG1W5eFudHniZB52iNNiG+l/lB+7OSxrzrJcbc8cJWkSiZ/fLDmcpnz9BZnvXpXl4WdrRNPFq8Mui27/rDFEeA9xleZqBVaaykZFKli0z5AqrKFcQAc+bSdfaUyskRMMll/8+pcm6rlWzYC7p2kh/ZoQBtLZ44hk1fAxvIMca0LV/viWEAH72D/kuCfWkd4qNqYFJOxFHsxUfG0zh1iLTZ4AYHcCgiwJDQWNsb8TXEruSSQF2Wi30FKKbjFJHF8V31Xto/r/b5QdrsgBFJSLhwz2lzrIPWTXvqfvzxb6VG9iOxh2hTNQd2v/0R1UhHbIwdn1Q79eQyLqU3WDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV0nchh8lPtO2SBtpST6/W//Zd3rU5lCcZZNbNxAtu0=;
 b=so4GHjnltPrzH1ZCglQEv+aZ5091/s6nE5B4C96YdG4J+RcyF/J1mUNM4sJvnL3nH/vc47lLUHxALppybiLZrP2udgzMyZsahlHz2VMjFnVxVFcCFruc7d6w9eiyG5K6YCmOJ1/DOYOpyPI5Gxy1dItA3e8Go67D/uaFZOas4zs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 21:50:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 21:50:28 +0000
Message-ID: <fb607620-cbf4-e6fe-be24-aad12f530f66@amd.com>
Date: Tue, 16 May 2023 16:50:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] drm/amd: Add safety check to make sure RLC is only
 turned off while in GFXOFF
To: Alex Deucher <alexdeucher@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20230516175214.3491-1-mario.limonciello@amd.com>
 <20230516175214.3491-4-mario.limonciello@amd.com>
 <CADnq5_OH5vRico9MuegyEAM2SfQchdiXVgCSRLdf6jYmhTYO+A@mail.gmail.com>
Content-Language: en-US
From: "Limonciello, Mario" <mlimonci@amd.com>
In-Reply-To: <CADnq5_OH5vRico9MuegyEAM2SfQchdiXVgCSRLdf6jYmhTYO+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 46781b4a-9d30-47ae-3ef2-08db56578f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8q4ROaFz2AzxhkXyG2Zc8dnk6SnKGyVF0RHS2GBi+wnDoEVNxJzwMgVpBFV1oV+htoKg3AjfBYQ6ANT+lb2S0iMn4vMstwe+XNHRyza7zUtICXS7EQTqZWWQxXDZ9vlMTmz85FXdmiH5LVKieo512PF5unczVrMWXJQnfg5ZHCfeUOeK6OtL/i2kXrryoFyBLjrP1vqxI2aDaJMuBD7HOQ1UImxB1ErX8SVxvXovJnyv6whYeA2jgi9nRCG9dmVQfMHZLL5Gx8oEE5Ctl34k7ZwJ60uyTJ+2+wkxvL7foz0oZBDeCRS+T5fZGuC8AC/i5DkGEXBjS9C1e+AVZAHC/iGZIz45Qi/EBzYmmhvqPbySLJbDmcW6AyPJopMMc/MC0KC1OErp7sTSUJNm5A7ShgTobPw6VgzWANihbcEKdJRhbvrDCBjrGEAt83QxSO/VH6lAMVPaWJGRPimGSr/aV7D+Q3nJ4Xm13l3aiYS4MHZ+ZflDW3b5bj57lYSHsFHxqJqDAkH0tKzq3ZlshokjjBg+xTon960jbYbgEzh4J0oYWPB6kCX5vnHpoDpxtm5vOwSbmW9CrP5ZrKTaA4BHmk/MLHOV/sqKzTdpcEWB8FMfiGX4UwUtH34XlUgIQLK1HsRcFokiz8q5H14rWNViOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(5660300002)(41300700001)(36756003)(83380400001)(2616005)(2906002)(31696002)(38100700002)(186003)(8676002)(8936002)(6506007)(53546011)(66476007)(66556008)(31686004)(66946007)(6512007)(478600001)(6486002)(6666004)(110136005)(6636002)(316002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmZoNUl4b2ZEZFNZL1ZBRkxKc2tCcHNqb0dUay9EZ0VZNVBLT1VidkNlOWtJ?=
 =?utf-8?B?ajVIRDI5aVZ4UjdJc2tRQ01JbHg1N0VHSm9NNGkwOGZwVjJURWYvcmYreHdN?=
 =?utf-8?B?SEdFd3JrdXlVMTdnaW9oak52SXBFeHlyemN2YytTdFJTUWdRMmFnbEl3dVE5?=
 =?utf-8?B?MWsrSithZTltbVJpNUt0cVdhcUhxM2VqblFUTTF3bkVFbWI4T1ppeVU1Tzg1?=
 =?utf-8?B?dlRNdXZGSmlVZTI4azJlQXdKWHNZNnRSSU56VGxkZzhSbXN4N2Q1MUcxSFBI?=
 =?utf-8?B?dlJHZ3h1b0djWDV4YnNWbC9Hc1Y0bTN2bjN1RkVzRHdNU2xoTjAxYVk4VnVT?=
 =?utf-8?B?RTJHTEUwc3NxVlduNytlckhIc2U4dnVGM0FMSngxeFRlcnF2ajRzYU5DRHZl?=
 =?utf-8?B?cEZBL0VsMGlmT2grcHl5eGsya050T3Y5Z2RVbVN1Tk5uUWhQRGJpWnJVSHhD?=
 =?utf-8?B?UjA5S2V0ZFRLSWVUL0NTeEhDbFhiUXEydzhzWVIya3Y4Z24zRVRKM3ZKb01H?=
 =?utf-8?B?SDVjNmozYjJWdllnUXhYV0NRN2Qra1pwVGkzVWlLTzltdWlHMGR6dTd6ek52?=
 =?utf-8?B?bUxwNTRML2lleU5hdytvZ1ZYRFQ0c2xyanRXZlRKS3Z5SnI4UFVBcFk0NHFC?=
 =?utf-8?B?eVlMaXhnQjJDV2VJWkFFbG5EMjVURTFMc0lGdDU3TW5UV0JBMVRxUDgvbUc1?=
 =?utf-8?B?cnZYWWtUL3VhbXFlQmJqek5zQStUazNsbnNUYlBscXlKM2NMSXJaS0l0Yitl?=
 =?utf-8?B?c25Pc3g2ZEpNRDRhU0tpUHc4NzEwY2FVMkM0ZTdCOXYxL0EvWVlzb1hESFFG?=
 =?utf-8?B?Q3d3YjBoSmY2Tm1jenpzTVRLdi9Tb1dBdEhkcXJpRnR0VGpHeFRvRnYzY3Uw?=
 =?utf-8?B?My94SExvMGhLSlBGRTNmWFBBSkxJd1hoekxZV2hSS1ZyaTlFMzFEZjF0dkFo?=
 =?utf-8?B?YUhzY1pnYUhqSktQamtVa21TVGFBcThoSnN2MFAxazRoRldKZDFqVHhGQmZJ?=
 =?utf-8?B?Q0pjWFdRUzdjK1FDMGxnUVpwbFpXRjBIL3JvcWNjUmU3ZzN2SHBNRlZQY0E2?=
 =?utf-8?B?U3VWYzJGZCsxSlRWaDlIc0dKQUFucmhNTE1QUTdRSVM2cG1mQVhKRnA2dHFy?=
 =?utf-8?B?WE1YUmM5UXA3Y2ZyOVZNaU9LcWJ5NGNreHMvbW5aY2QwZU1pS3Z3SkF5ODF1?=
 =?utf-8?B?eTVJbWtaQThObnBRMWxrSkJxSEFxVU9hclV3di9KQ05OMXNhanRJck50MW02?=
 =?utf-8?B?dXJvR2gxR0Z6TTFJcmlUYi9aV1NickJQcUpGV3VFWFlrbFdRZWpnMlNSQks1?=
 =?utf-8?B?WlUrU1NHVHlta1R2VzFzc0hMN1JmRzRac2g3SjMxN1ovenc1dkJWdDNYWnlj?=
 =?utf-8?B?S0kzdXdVTWx3cGh1L2diU0FyT2NTNlNHUlRPdmFSUzdvUXY5SmRsQUJhaGlB?=
 =?utf-8?B?a3dJMXdWMEpXNnRlR3hySE9SNHNmVFJrVlM4QkdQVXJlV2k1Vlc2eG91U2w1?=
 =?utf-8?B?V0F5NVFxNldxMnU0Ti9lSktNQjZ4NFAwY3lKYUNXaWFYR1h2TnBvZCs3RFlj?=
 =?utf-8?B?ME5uSGt4dWRBalpGemtmQTNWaVpETGM1YUhvWURmYlZWNUNNM2RoMVlTMUtO?=
 =?utf-8?B?bjR2Q3ptMjFGRW96OGRGdVRNamtTQzBxeHJDWHEvZWxoQml2VC9DSkVFdVhs?=
 =?utf-8?B?a011TlJsNnp1T1JLZXphYXRwMnZCNWtJTjBqYkk2ZDhELzg5dkM2b1E2VXhM?=
 =?utf-8?B?cDEyODBZRUtnVWdZeFRsRUFwLzJveDFDTWJETkZPcVpMN25PTDNscEFXZmZK?=
 =?utf-8?B?blZXUTVIS2QzdnF3VlZqSWJEL0xLWExkcjRuVG51NWlTbWJ4SnN0R28reGU1?=
 =?utf-8?B?R2xjb1dNL3JRbHJ4TGRoVlA1TTdkMHoxZ2pPSldHMTRjMWtEOE1MWkhGOEg5?=
 =?utf-8?B?Y2Q1ZnFBSnAzQVFrTGNmdzhNaGYrcE5Oa2paUVd6dXl6dGY3Q0pLODUwQ3JJ?=
 =?utf-8?B?c2V4bmlmcWpjTUx6UmZvaXhINEJWYlJieFVjM2VKaEw3U3FBY0VuOUw3Skdj?=
 =?utf-8?B?VmpHZEFiaVVianhGSkt4ckxIZjdnUmplSmVsT2lsdERlU3NTSjJ2NS8yZk0w?=
 =?utf-8?B?TDVGa08wYm0rRnE0dGYvTy9tLzlvQnp4UVhlRmhkbEtRZ0o0aXR1YnZqLzZn?=
 =?utf-8?Q?QOERHYtaWNtUhFw6HXv1CbU5Y2BBTuStO09qMzthaSuo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46781b4a-9d30-47ae-3ef2-08db56578f9d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 21:50:27.6739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vctv82RyQikBIg6/eqAe1uXw+aEjx7D+lm62opBXijTsFkwmv0HLXZ5+D9/cOEngyt6kTRSvh/26jp/LemVX2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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
Cc: anson.tsao@amd.com, Juan.Martinez@amd.com, richard.gong@amd.com,
 amd-gfx@lists.freedesktop.org, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/16/2023 4:39 PM, Alex Deucher wrote:
> On Tue, May 16, 2023 at 2:15 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> On GFX11 if RLC is stopped when not in GFXOFF the system will hang.
>> Prevent this case from ever happening.
>>
>> Tested-by: Juan Martinez <Juan.Martinez@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index dcbdb2641086..f1f879d9ed8d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1766,6 +1766,10 @@ static void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
>>   {
>>          u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
>>
>> +       if (!adev->gfx.gfx_off_state) {
>> +               dev_err(adev->dev, "GFX is not in GFXOFF\n");
>> +               return;
>> +       }
> This should move up before the RREG above?  Also, I think it would be
> cleaner to just not mess with the RLC in S0i3.  Can we just return
> early in smu_disable_dpms() for the APU case?  All of the DPM features
> are controlled by the SMU so that function is mostly a nop of APUs
> anyway.
>
> Alex
That was what the original attempt did when we first identified this issue.
Unfortunately though just skipping RLC (without patches 1 and 2) means
that GFXOFF still either doesn't get toggled at suspend entry or isn't fully

off at suspend entry.

This leads to the graphics core behaving erratically upon resume.

So if you're OK with patches 1 and 2, I'll adjust patch 3 to also skip 
RLC for
APU.


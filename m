Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859E1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 05:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC7B6103A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 05:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DC7B6103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD9389DD3;
	Tue,  9 Nov 2021 05:17:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8598C89DD3
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 05:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBAVnZVNfQK2j1js9Rx5s6SeVJ+tNSWPr7oYxgqfgxT2xDPgS6K7WfNiKLHSUo4S3Mll0tOO1kesHcDbTRUvCq95kbDEIXIeDA6QwB7j4KDOBPkLp9hfeVOZ+92nG+V+GPn3RkjELUCpyOSXMaAmpIkNWoD5oq2gE4NuJbOLyddpEyizo4SZoGbgmOmbgR3vrmKjVV0yMPxovOPdaOHQ3KxOQtJb7VBuRvjs8cUDpywcnAWcRAPeeFqZCI/PCjyqNPk7NmMEnRoeegiLOF/zf2XUXbTvhrteHQqtID25NMHu6FjgkCIql/9o9gBh4Mj2PY/aVPFblDkWogVLRaxRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MN1pRJn2vfVjHq5aY0txt7QySpe3x5PZxAdpIV9LPU4=;
 b=bq8PehXYHfBihkZEQNHsy77XJzQexfw9G+SunUNZYJDdMc00onEcA9LtdNJyHDZ1Uj3N1Xl5i1kJIP/TZpM7xxN5LcfXNedfozRA95zcHQZad1e3yA1zBuTI+0NfoOLm8GW+r3PTn5Nr6xP2TOCGEFS3ZkcsKWiZZOYBSMNvC6cYPwiUo/z1kqvVI9lkQnMqf97GcnyycLtHqBWP/Ul34iQwB8DNBzyqkx7xogGxJ3Bd0DqNrmwp0ztij9WQIlGnU8YbAgyN5M9j2Cz54G70c6lAfoSGh9EU9Ze1flPyWyFlitCNXiHh275EA3ESg+sMOfM1cPA39kj48o7h1hRrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN1pRJn2vfVjHq5aY0txt7QySpe3x5PZxAdpIV9LPU4=;
 b=P8uM2DFzq3HeSfEZt1PFRzGuI+QlVFXjk8f2shgERfefbEDONBFSnSKpbvkEnv90ycDVLerpCWVIZV/+CyBOu+cuX+WZgHiRtzdB1vbqafkzBjOMYXyG0kNb73QGWg6UNYKkzxm78+9ob9idCFs2HVmaqp7goN87slH8/v8jTkA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by MWHPR1201MB2557.namprd12.prod.outlook.com (2603:10b6:300:e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 05:16:58 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7144:b327:ded5:3f50]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7144:b327:ded5:3f50%12]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 05:16:39 +0000
Message-ID: <46a13e10-c2d1-96d8-5b85-7170ccfdf371@amd.com>
Date: Tue, 9 Nov 2021 10:46:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: log amdgpu_dm_atomic_check() failure
 cause
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Shirish S <shirish.s@amd.com>
References: <20211108084054.11162-1-shirish.s@amd.com>
 <d85871bd-72af-d02d-5c23-f3c13ccbfd52@molgen.mpg.de>
 <af95f11c-c70c-352b-da5a-3a185426d696@amd.com>
 <d4d96a2d-11c5-ab58-efb0-262ef75d515d@gmail.com>
 <91abff88-da03-695d-e8fa-3096f6e2895a@amd.com>
From: "S, Shirish" <sshankar@amd.com>
In-Reply-To: <91abff88-da03-695d-e8fa-3096f6e2895a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::16) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
Received: from [10.252.253.146] (165.204.158.249) by
 PN3PR01CA0065.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:99::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 05:16:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9db8bd2c-e6d3-4d69-4d82-08d9a3401ba6
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2557:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2557A7262B9F199B02ABC57CF2929@MWHPR1201MB2557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Z4Pr3LHk4Tn/A7n1sYgHXDp00lh3J+w2MHmka8QKe4WLdzaB25spL2H2qpW3EU4GIpN9Q9J/3oVjR6xnsgvhmdtFoMQQpcOPDYVKlCpDWL92TL8AhOajJTRFhrlf41ZWvaIG3ku02NNHxqYQdaVPH+6bwo4TmswY1Otaue/NIS3LYxdG8lHAbt4DDxzxSbeAx5M4wvTtKJhONq/ZKHg7ueYuQSkYHgaPnVO4/klSaMjhd6fwdxAaKHSn6ecemx8eN2UnEtdehKSAVvzJ/j65q8m0KMUJu+ACJF1NlIGydcIx4rfsRg9DUT0lNjwDSewtn9BQwlCRTF7IqsxiL0mSdym8yXHBdMbwKRijlg8jh5GnpuUzlNSNdPDgqb7hxq6ilI4o4TUKhCnsQJZSn/ZZGxgExxuiGp1BYsGO8tcPgIqCsji7FoqETRLPtiP4npx8QtIDmLc0nzfFTGpY83FiqzOy7VUyIbmEifB7JwG0bF4vUyQYErAd+rlQjiNvh1Fnqa/02gw6CHnK+s6g954t7m773QJahXk7kESdUjOyhCRFXoO2Efw5od4rN5u+mQ8ge0eIGTCbwwfMUCNHQLMBqAtxA0uXZ09cgkRWs3vbDhV0CVKOXhsktXQOG1Uz8KSU4qd97tfaJuxh/wVPX/DWku5rgbRY8TjKtGM8XKlDmS6wWMH/V/w4JcOYMU3BOCl6OVhkCL62zyBBMZMfqR2Bxll5nef8YW8+T7jSiFCh6+otIXSEMC7510Zen949haS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(31696002)(36756003)(66476007)(110136005)(2906002)(54906003)(8936002)(26005)(508600001)(2616005)(956004)(83380400001)(53546011)(66574015)(6636002)(6666004)(66556008)(38100700002)(31686004)(5660300002)(6486002)(8676002)(66946007)(316002)(4326008)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmpGK0NVV2hyL2c2YmJyVklZY1pMbldNUEVPRWV2U011aUJnTGcxR1dXTW5P?=
 =?utf-8?B?Q255NEFzNUFYblF0YnpaSDFYTjhnYUd6c1M0N1EzYU5ub3ZpRGdOYlRXenkz?=
 =?utf-8?B?aElzK25KWWpQNVdXeHBqTWVWZjN4b2NzV21LV1YvT1ZzdnBvd0tjM0ZyWjMz?=
 =?utf-8?B?VkEwdXg5MlZTM1RIN2FRaFMrRGVzbkVGaFd3cGZBazNSR1p5NDZLaktZVWZ1?=
 =?utf-8?B?aGduem5qVVltWUFUN2xKalQxMW80VXIzb0hWWHBoSXhHQ1FWVzg5Rm9NTk9L?=
 =?utf-8?B?ZHBmZzVKWFR4UTc4RzY2QnpvRXBnNXVVWEh4SjRvaHAxZ1RjSzRMRnkyL2VU?=
 =?utf-8?B?Y3hPdFhxSDhXa2lrR1A0NHcrZmpQNDBnTEpKc0VheTcwQnZod0lsdlNsc24y?=
 =?utf-8?B?MkVaTWF4OStmNnJHaGhBSWpCaWZQQXBKbDdkb3ZoV2pNbk9UbG9DVkNRa1RR?=
 =?utf-8?B?dkllSit3WXVlN1o4UURYd1NIc1Q5RUVDQyszaERjYWtSOVZIN1VuNEo2YkJI?=
 =?utf-8?B?dU5sNkNISnhvd1dDUHVCeHBDcGE5S2txZ3ZtY3FNb1IzZDRDbjVhQnJQTTdB?=
 =?utf-8?B?QzhiUDFiYk1UQUU3RjhWR0N5ZC8zTnpyRWtIY1ZkUTd1TDVxYTlXc3NEMkJZ?=
 =?utf-8?B?SXc0RnY5RURkTVBwQkdDdDlQamt6LzFFc1Q4ZzloSHZONXRtTGRiOUthcFpl?=
 =?utf-8?B?WTlBRXN2WkloOHFDWWpzMFRvUEQ2UmZBQVM1cGpBUlpKbDEwdmwwNDVSZXVy?=
 =?utf-8?B?eExWMjhTZDU3K0N6THRac1ZKTkhpSFlRQTRMZjlibUJpOHIyTis4R3hxaFBG?=
 =?utf-8?B?NkF2aWVPSUpZbGVtRE5lT0kzLzA4OWNYc2VDSzNSU0VFeGpHNUt4aWFVZFZV?=
 =?utf-8?B?RmR3cTdaM21WVVFYSk1ISnhYS1puL1hFNUQrYzVQTFArNVhJV2dmQWFsL0dj?=
 =?utf-8?B?SzQvUnFXTGNFYXFGVXpwRjhpUUZIUXdwVVNqYTJOR3NaSStxelVjbkZ6bzBJ?=
 =?utf-8?B?cG5sbFlvMGxvd0tXN0tLTWlPNUM4YkRreHJXcmVxYTUvUGI3VkJmRlVEMXpN?=
 =?utf-8?B?UWFtRytsbDlsRHJiQlJrNXJvbnQyT0ZFM0ZPTjdzeGNha2VCMEtDaDk1Y3dE?=
 =?utf-8?B?S3RIZG5tQm5KUkRjbHBXRSt6VWNpS3JaRGxnVUljRHFGdlYzbVNKN0swcUd2?=
 =?utf-8?B?QURwNjU2enVaSllCaHMyb0NPTzVEZXA1bFVSclNKSE9VdmlVY1Q2WFBFdXpu?=
 =?utf-8?B?Ny8xWHdTN0loN3UrbjBsUkJQb0JLWnVrblVGU1NnOFFjS3VJVTRpN0Vaa3lO?=
 =?utf-8?B?SklaSVpXU3dmWG9lSjFZUDA1bDhvQUdhajhLVGZ3Q3hHcGRiWkhuUTdhNzV0?=
 =?utf-8?B?UVZKYmJSWjhVbjBUeEZEMThxckYvWG9EUkh0Yk5sOXZpRHZMMkxlNFJsWnpY?=
 =?utf-8?B?OEdOSnlmcVpqTEdRZ3NoZ045bm82TGdDdlJXaTQvU2NUSzZCYmE5QlQ4YzRP?=
 =?utf-8?B?bURsWjZ5djY0QTNtYWp0MmswSFRmZHNhb1N5Sjh0cXFvbDM5MU9NQjY5YU9z?=
 =?utf-8?B?dWpod2ZsK0FqWFR3dCs1N3IrK2Z0OGdhR05jSGVpTFhGOUZ5WUk1WDd0c3Ft?=
 =?utf-8?B?SlZ4NldCeHVVMUVxcUJnZTh0TSsvNTlQSWlWQ2VsY0lqYWlKNzhwcEd0RzBx?=
 =?utf-8?B?Z3BYR2haR3JEQ2ZtR1duaVVUcU1TTnh1bWZ2SFpBUENybmFiTlAxbTFzOFFw?=
 =?utf-8?B?eERncXkzTXVQWmtDZHo0S0NRRzVZVHZmaHR2bVlEcHBrRTZLa2ZWVjdWSWkv?=
 =?utf-8?B?UnNaWWd1SUw3UEtGQTNRVVkvcDdsWTkxVTUyQWZiL2d0Q3dKWXpmV0hKZWVH?=
 =?utf-8?B?cGJUcDNxalNtOEphOTB0OTFPdWVnWFV1M2toTWcvVTlWc3RrelB0aWlWL3BT?=
 =?utf-8?B?aFU4MmVnWlhudklwZVF5WHluZlhUbEN4d0g2cU9jQVl4SDRaYjN4ajRzbStB?=
 =?utf-8?B?SHJqcXI5OTFac200ZjJlRytqcDhtRm9VRURMSEtjYmRGZWovNkhFaDVCNkM2?=
 =?utf-8?B?Q0xjUWJERitCWlVGRlo5bHhKaWk0ZU9pZEdkQzNFTDNCV21HTjVZZW5tMUlN?=
 =?utf-8?B?T2pRc2ZKRVdHd2hoa0hxTEVzUmVrbkRzR3Y3UWxxUFZ3MWZ5SWhBdEViNUls?=
 =?utf-8?Q?lZWVFo9By9Uq2jsABmMpCo8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db8bd2c-e6d3-4d69-4d82-08d9a3401ba6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 05:16:39.1092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwjozJTdWq41O31xXaFrOhimlwiS+ajSi1c8n/4WWp98qG6PXjtDwfyhL1f40cr2atOD2l5kj2ZtKZaiOxVzgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2557
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 11/8/2021 8:27 PM, Harry Wentland wrote:
>
> On 2021-11-08 06:23, Christian König wrote:
>>
>> Am 08.11.21 um 12:13 schrieb S, Shirish:
>>> Hi Paul,
>>>
>>> On 11/8/2021 2:27 PM, Paul Menzel wrote:
>>>> Dear Shrish,
>>>>
>>>>
>>>> Am 08.11.21 um 09:40 schrieb Shirish S:
>>>>> update user with next level of info about which condition led to
>>>>> atomic check failure.
>>>>>
>>>>> Signed-off-by: Shirish S <shirish.s@amd.com>
>>>>> ---
>>>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 70 ++++++++++++++-----
>>>>>    1 file changed, 52 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> index 1e26d9be8993..37ea8a76fa09 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> @@ -10746,8 +10746,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>        trace_amdgpu_dm_atomic_check_begin(state);
>>>>>          ret = drm_atomic_helper_check_modeset(dev, state);
>>>>> -    if (ret)
>>>>> +    if (ret) {
>>>>> +        DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_modeset() failed\n");
>>>> Does the Linux kernel provide means (for example ftrace) to trace such things, so the (generic) debug lines don’t have to be added? Or is it to better debug user bug reports?
>>>>
>>> ftrace requires additional tooling, am trying to avoid it and make the error reporting more trivial to the developers, in case there is a failure in atomic_check.
>> Yeah, but Paul is right that here looks like totally overkill to me as well.
>>
>> And especially calls to functions like drm_atomic_helper_check_modeset() sound like parameter validation to me which the kernel should absolute NOT report about on default severity level.
>>
> Atomic_check is also expected to fail as userspace might want to just query whether an atomic_state can be applied.
>
> Debug messages might make sense here and would help with debug. These shouldn't be error prints, though.

Thanks Harry, have updated the prints to debug from error.

Regards,

Shirish S

> Harry
>
>> Otherwise you allow userspace to flood the logs with trivial error messages.
>>
>> Regards,
>> Christian.
>>
>>> Regards,
>>>
>>> Shirish S
>>>
>>>> Kind regards,
>>>>
>>>> Paul
>>>>
>>>>
>>>>>            goto fail;
>>>>> +    }
>>>>>          /* Check connector changes */
>>>>>        for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
>>>>> @@ -10763,6 +10765,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>              new_crtc_state = drm_atomic_get_crtc_state(state, new_con_state->crtc);
>>>>>            if (IS_ERR(new_crtc_state)) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "drm_atomic_get_crtc_state() failed\n");
>>>>>                ret = PTR_ERR(new_crtc_state);
>>>>>                goto fail;
>>>>>            }
>>>>> @@ -10777,8 +10780,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>            for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>>>>>                if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
>>>>>                    ret = add_affected_mst_dsc_crtcs(state, crtc);
>>>>> -                if (ret)
>>>>> +                if (ret) {
>>>>> +                    DRM_DEV_ERROR(adev->dev, "add_affected_mst_dsc_crtcs() failed\n");
>>>>>                        goto fail;
>>>>> +                }
>>>>>                }
>>>>>            }
>>>>>        }
>>>>> @@ -10793,19 +10798,25 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>                continue;
>>>>>              ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "amdgpu_dm_verify_lut_sizes() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>              if (!new_crtc_state->enable)
>>>>>                continue;
>>>>>              ret = drm_atomic_add_affected_connectors(state, crtc);
>>>>> -        if (ret)
>>>>> -            return ret;
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "drm_atomic_add_affected_connectors() failed\n");
>>>>> +            goto fail;
>>>>> +        }
>>>>>              ret = drm_atomic_add_affected_planes(state, crtc);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "drm_atomic_add_affected_planes() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>              if (dm_old_crtc_state->dsc_force_changed)
>>>>>                new_crtc_state->mode_changed = true;
>>>>> @@ -10842,6 +10853,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>                  if (IS_ERR(new_plane_state)) {
>>>>>                    ret = PTR_ERR(new_plane_state);
>>>>> +                DRM_DEV_ERROR(adev->dev, "new_plane_state is BAD\n");
>>>>>                    goto fail;
>>>>>                }
>>>>>            }
>>>>> @@ -10854,8 +10866,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>                            new_plane_state,
>>>>>                            false,
>>>>>                            &lock_and_validation_needed);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>        }
>>>>>          /* Disable all crtcs which require disable */
>>>>> @@ -10865,8 +10879,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>                           new_crtc_state,
>>>>>                           false,
>>>>>                           &lock_and_validation_needed);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "DISABLE: dm_update_crtc_state() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>        }
>>>>>          /* Enable all crtcs which require enable */
>>>>> @@ -10876,8 +10892,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>                           new_crtc_state,
>>>>>                           true,
>>>>>                           &lock_and_validation_needed);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "ENABLE: dm_update_crtc_state() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>        }
>>>>>          /* Add new/modified planes */
>>>>> @@ -10887,20 +10905,26 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>                            new_plane_state,
>>>>>                            true,
>>>>>                            &lock_and_validation_needed);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>        }
>>>>>          /* Run this here since we want to validate the streams we created */
>>>>>        ret = drm_atomic_helper_check_planes(dev, state);
>>>>> -    if (ret)
>>>>> +    if (ret) {
>>>>> +        DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_planes() failed\n");
>>>>>            goto fail;
>>>>> +    }
>>>>>          /* Check cursor planes scaling */
>>>>>        for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>>>>>            ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "dm_check_crtc_cursor() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>        }
>>>>>          if (state->legacy_cursor_update) {
>>>>> @@ -10987,20 +11011,28 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>         */
>>>>>        if (lock_and_validation_needed) {
>>>>>            ret = dm_atomic_get_state(state, &dm_state);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "dm_atomic_get_state() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>              ret = do_aquire_global_lock(dev, state);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "do_aquire_global_lock() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>      #if defined(CONFIG_DRM_AMD_DC_DCN)
>>>>> -        if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars))
>>>>> +        if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars)) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "compute_mst_dsc_configs_for_state() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>              ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "dm_update_mst_vcpi_slots_for_dsc() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>    #endif
>>>>>              /*
>>>>> @@ -11010,11 +11042,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>>             * to get stuck in an infinite loop and hang eventually.
>>>>>             */
>>>>>            ret = drm_dp_mst_atomic_check(state);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            DRM_DEV_ERROR(adev->dev, "drm_dp_mst_atomic_check() failed\n");
>>>>>                goto fail;
>>>>> +        }
>>>>>            status = dc_validate_global_state(dc, dm_state->context, false);
>>>>>            if (status != DC_OK) {
>>>>> -            drm_dbg_atomic(dev,
>>>>> +            DRM_DEV_ERROR(adev->dev,
>>>>>                           "DC global validation failure: %s (%d)",
>>>>>                           dc_status_to_str(status), status);
>>>>>                ret = -EINVAL;
>>>>>

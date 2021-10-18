Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19655C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 09:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEFB610A6
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 09:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFEFB610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35EED89EB1;
	Mon, 18 Oct 2021 09:15:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F1D89EB1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 09:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aej4kfv8sRmrdMnoyWA2EvR6d083/y1jPUvHsdARWmHWGtQGLFeUL0yfsf6JmHwfsKRQ6NijZlV6qV+t0A7Sx1zcxKwh6vFnO+SKEhGF+Fu7xeqJWcyDmpeluwkHySjpwqXLdURa3GwEMfzki4J/E4OckIURaupI2yEijzdOmuVBPl74Mrxu5TiZRpKTwXr3YCjKICkbh1ZU9ZxN6mCd/AeELCUcK3H4VSO1be47DqOsz+Vco41AucTUsHk/0qFIomKzHUjuVlLGh6ZYtOOHgN66+JS+SyoN5kpmpGD6luMII+jRsZ1I1KeZR0Rbk8z+CifC/vPMSFXpy8Nba1hHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS/Nf/83P5BZG69e8ridgbI0stwYyuXClX5t/M0Kfos=;
 b=lubyT51ABftwv4njaVPWRW3dr5oKJGbTz4NkQOV/5BxJCKbdtYTCt4NiZM3h0r+re3B7o0RLL+XHjeJATnrmGalRJP7AyrbOZqrgN93P5seZE4NcG9h6/KAnk53WxqWHOYPHZzcqmLayqBqOrhFewSQUGzSnt03Bgg0NiBuMv8+WvVh2zUp3lufXd1+PTbPr+nnqI+8eoM+2GiPaf+8nUCeuDv4smlR9mS+r6e3Hdui+2lEBYA2SP75djKFSshakCPGoP/96WFdClSzGNQ2oWuYBBnxcHK9gA5qwiAy1oVTrU+6x7977IW9TbkellcKLi3o31bjhEfV+WXoyBVdKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS/Nf/83P5BZG69e8ridgbI0stwYyuXClX5t/M0Kfos=;
 b=asZHA1fp+PZXMuyA+hqYcEG1ODsgkp2XAT+De/b1wZaUzTBjZxqXBLxK/Gmi1iL54qxCFjPyjKi6HthEezstg9aCMOwj4xRnjgqLryMMZoSnst2Plv7x+bLZf0nYAHKiyeyLv9kQgSaC4QvhpU3t8/x/q9opysr8SI3UO0xeaW0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (10.255.174.19) by
 DM6PR12MB2937.namprd12.prod.outlook.com (20.179.104.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Mon, 18 Oct 2021 09:15:41 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 09:15:41 +0000
Message-ID: <1d90960d-78ac-3174-a546-cce470dc0d8d@amd.com>
Date: Mon, 18 Oct 2021 14:45:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu: fix Polaris12 uvd crash on driver unload
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
References: <20211011082812.742688-1-evan.quan@amd.com>
 <DM6PR12MB26197E608C4A9739D1E0855FE4BC9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <fe64d815-45a9-1560-d92a-2c1fc207f0b2@amd.com>
 <DM6PR12MB261909FB884248959DF113A7E4BC9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB261909FB884248959DF113A7E4BC9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::23) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 09:15:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c242d2b-2672-4d3d-61ac-08d99217db08
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2937E1F060BDF3D469F360A297BC9@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJdd6Qe2ruiCbcHKk00FFM9+h983xc4dvx4gejWEHfdm1Q4jEx+pebrWlSWstJmxe+n2+S7x35AQQwNnLomeABugZJV+1kaYEIpdcpadprK5amBSySLMu7leQElWQVByuGGw/Hky9cNK5aojZcTtodb+Q2Q8gUUM43Uipm7DJ26GafGyeyq4sEw9afNNQiZjpKScMT1ImiTfz3XShzsjsYNRJ55yUhoH0yUWhClEp57M8PL2JXa/C8JbJKByF4dvsfyhhKmvP6LVry+3Cfo/FDMcxHWqKaRXhlkKfS2X12et8epLmg/lcZYHx6Fnn+lF12ghnVQ6hQxipZid8uadvHdTW1RZI5929AV1v/JJ9CpF8/PU+FWbbHPswQgZrPEhww0cyE8sBf/1KS9g7bLsSKY0i+LiSTTwubG7q51sh4OdkU2QRjWhnhJVR4tklxiPFwLWbX1duXbdtk/bXpkQfc/hTph1DSynufGORP7SZLXp/ZAd4m52Pi9YMZOEdPnSx3kyWRlDCiYKJoMVtjP3PQ3thnxhWlK6kem48+Mhuo8RekiqPq0wMtqeQwxbjxLPtfOCFjZ+no7XpojZc0y6A1PgVFROJwSdtQ83WfG1rLslcuGizhb6Lju/l6u9NYxCv7bbDsj4kD7mQz4zuO7qFQOur4Us1vh5wRW+ybDXm4KFx62ZKJduJi8Ax+feTVnpfDbGCZDyGLpHtqY4LAxA6tpGqkOuLirfChz6t2QPJ04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(86362001)(31696002)(5660300002)(66476007)(26005)(6666004)(53546011)(508600001)(31686004)(956004)(186003)(66556008)(8676002)(66946007)(316002)(2616005)(83380400001)(8936002)(6486002)(2906002)(110136005)(36756003)(4326008)(16576012)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BzeXV0WDdOQmFtTGNZbVBjMXFRWjNnMDdUdDhLWXR3cFh3SjBLYjhrZHNQ?=
 =?utf-8?B?aW5TcExWbTdlQ0VqY1NBYTBZYVlrWkN5YkFxSVBNN3RXTWlYMUJYVVYxVm9N?=
 =?utf-8?B?alFYUG1jdytteUMzdEg2c2hjc09lYjh6SVgxaVJwdVJFTjZrbVZiZTgzVUlI?=
 =?utf-8?B?L3MzUTJVS2ZrZFRQeFdJaXdySWxucmJTVkQvQ0Jla0x1YmFaT3hIK3h2Tmth?=
 =?utf-8?B?aXQ2ZDFzODZ3RVpDRGtqcjU1UTlobXI1TkZvQWhjdXFMSlQ5QU1UQk94Zy9H?=
 =?utf-8?B?MnY1eDF6N0YvaVhJVzlzN3hpaEc0aTJqVDlQdUpPdVNZczd0OEthOStXRjdS?=
 =?utf-8?B?Qk5HcnNGQUxFSDZtb2lYUSt0Q05zOG8zTGRhQzdkL1RiZW5CbWZOSThpTkJk?=
 =?utf-8?B?aTlkUWFKZ3FjSldheHVpaFdzQjUwaHRINUpHMmN5RnlEQXI5Y2I4a3FIaGp4?=
 =?utf-8?B?T00zVGJsWVpJNXJ0cUh0NlF2b3BsNjYwTWpTSi9EbjA1dTRnaUZSMlNXb2dv?=
 =?utf-8?B?S2tFd2lZSGtpU0twTSsvd1FUK3lxQUk4Qk5GM2pUc05ENExQaStWMmg0T0NL?=
 =?utf-8?B?K1FZVTc1dU9nQUtaazNtakZpZ0dtRitBdlMvYUl0NnFDTzJiU0dyVDMxWWdI?=
 =?utf-8?B?ajFFTzFidTRRQlF4TjVGNkl3WWJWM1M3QzlPblN5Wmw2MExsbmdiODNhem1D?=
 =?utf-8?B?dXoxcnFIbWJWdVA5NnVYWURQZ0FYc0NTVGo1ZE05WXZTTnlFS09nZklURnpt?=
 =?utf-8?B?REtaNElzZzNGMnRhRUZRbHdOQjE2OUx5Zks0N08rZVRjc2hJMVN2N3RPUHJi?=
 =?utf-8?B?SE5WZC8wUHYzL044R0ExRTNUUG9VT0pvUGJybDlRUEN2dUJYbXpvOFh3cXJ1?=
 =?utf-8?B?MnQrMTVqcDZ5SkVWRkwxUmpOOU4xbklzdkhxSmtUeGJkaDJmcURQQmlJREpF?=
 =?utf-8?B?ZS9hdFp1ZGxhcENNRitHdkdGeExDWlJKTHJoa09IdnM0dkcyRWNRRlVnL0NI?=
 =?utf-8?B?UjhxbEl0SlB5S1BjUkpCbmpMdVBWUmJDM2RiVURteFpOeTVEbXRwSEsxMGxH?=
 =?utf-8?B?OUhjazNtYUdtUkVqNDJKdnYxYmJLMmEvMEJVRkdaMWhBSm5PdTlrV0FkVkVa?=
 =?utf-8?B?S1M3YTIxRHJ2VFVRdG1DVytUa3ZhQmk1RUo1NTRmdzA4cFpGRlZacTYyYjFB?=
 =?utf-8?B?cGJhWC9zMkN6cXUvR21iYjBGVmExdjEzRVJteVE5MUF1NTVYTzF1RTc1alNV?=
 =?utf-8?B?TExleEJteXRSall1bjZrUytOOFBQV2RvVS9sSHM5TEtPTHM4ZUprTGlUYkJJ?=
 =?utf-8?B?aE9LKzFiZ1N5ekh3R2xCZUVDTkxjbExZMW5wenpSS09SRTV1bXduUUNQMkJk?=
 =?utf-8?B?aHZjeGE5V1Q2MlBSV0pGYmQxUFNROW5nZktaQlhDVmtEa1lvZVY3UUNUK1VI?=
 =?utf-8?B?YzJ4UURMSjlwSjB4NXNFTDJwb29ISzc0V1FBNHFlaERpVlhSWmNvN29BSDNl?=
 =?utf-8?B?c0hLZmttR1RMOE0xYThsVms1aFVCUlV3VTc0MVdodHIyWXdMWndHZ3dMeXZV?=
 =?utf-8?B?Q1JpQWFNU2pEUjdZN2dyRVB0L1V6Qm0yL3loZEZIY1dnZlZNMENqU2d5NHBt?=
 =?utf-8?B?Nnk3R3BYMXRobTZjbnR5NGxsNUZraE5VSXNDbXRBWHI1Uzhkd0V1VklwcTNY?=
 =?utf-8?B?WkpFUHdNU3NYbGdhY2g4RGI2d3d4UTI2UGt2K2trbUZYcm4yc0pJRjErWGdX?=
 =?utf-8?Q?qRRxZnKEaui1RC52GZ7CUuHCFhcSb5OSiiKuiyw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c242d2b-2672-4d3d-61ac-08d99217db08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 09:15:40.9856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXW+XlCoJ/oNVerKBTRG2Nx29YzJ05YqpBeTFizAJgTc07lP5g1tAFOCB0hgGcO3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
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



On 10/18/2021 2:38 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, October 18, 2021 4:05 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Grodzovsky,
>> Andrey <Andrey.Grodzovsky@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix Polaris12 uvd crash on driver unload
>>
>>
>>
>> On 10/18/2021 1:06 PM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>> Ping..
>>>
>>>> -----Original Message-----
>>>> From: Quan, Evan <Evan.Quan@amd.com>
>>>> Sent: Monday, October 11, 2021 4:28 PM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Grodzovsky,
>>>> Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan
>> <Evan.Quan@amd.com>
>>>> Subject: [PATCH] drm/amdgpu: fix Polaris12 uvd crash on driver unload
>>>>
>>>> This is a supplement for the change below:
>>>> cdccf1ffe1a3 drm/amdgpu: Fix crash on device remove/driver unload
>>>>
>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>> Change-Id: Iedc25e2f572f04772511d56781b01b481e22fd00
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 +++++++++++++--------
>> ---
>>>>    1 file changed, 13 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>> index d5d023a24269..2d558c2f417d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>> @@ -534,6 +534,19 @@ static int uvd_v6_0_hw_fini(void *handle)  {
>>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>
>>>> +	cancel_delayed_work_sync(&adev->uvd.idle_work);
>>>> +
>>
>> To solve Boris' issue, this patch should be modified such that DPM disable
>> done by the idle job shouldn't be executed during hw_fini.
>> Preventing powergate during suspend is not needed.
> [Quan, Evan] This is not intended to fix Boris' issue. It just adds the missing in previous Andrey's fix
> cdccf1ffe1a3 drm/amdgpu: Fix crash on device remove/driver unload
> 

What I meant is - this cancel delayed work job has the potential 
(depending on timing) to create the issue that Boris faced during 
reboot. Additionally this and the below steps will fix Boris' issue (at 
least I believe so) once DPM disable is skipped in idle job during hw_fini.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>> +	if (RREG32(mmUVD_STATUS) != 0)
>>>> +		uvd_v6_0_stop(adev);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int uvd_v6_0_suspend(void *handle) {
>>>> +	int r;
>>>> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +
>>>>    	/*
>>>>    	 * Proper cleanups before halting the HW engine:
>>>>    	 *   - cancel the delayed idle work
>>>> @@ -558,17 +571,6 @@ static int uvd_v6_0_hw_fini(void *handle)
>>>>    						       AMD_CG_STATE_GATE);
>>>>    	}
>>>>
>>>> -	if (RREG32(mmUVD_STATUS) != 0)
>>>> -		uvd_v6_0_stop(adev);
>>>> -
>>>> -	return 0;
>>>> -}
>>>> -
>>>> -static int uvd_v6_0_suspend(void *handle) -{
>>>> -	int r;
>>>> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> -
>>>>    	r = uvd_v6_0_hw_fini(adev);
>>>>    	if (r)
>>>>    		return r;
>>>> --
>>>> 2.29.0

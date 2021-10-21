Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526E0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 15:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF2361052
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 15:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0AF2361052
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1466ECB3;
	Thu, 21 Oct 2021 15:18:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D511D6ECB3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 15:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJf27zj8ewKYv/kTer4mFVQ9yU29VDDWjeYoadrGSF7hh31trPUT/iEzCJvN69OuVuQ5QgFvyiLP5cERm3SmtlxpcqxaHVCcgitLYW210qPMocnqD+5kgs/1ohnvaX11tVml52iKx47yxQCsOIlkh7FmHxd2rNL11sUSeA0tlVu+UG3Z4yzXSzivv8G8v5dRVOTSKBjGs+2ZkIwY6PpWeBalqgs7TS4P+VNy6JshRsHS/517WGPGUSwOcTBT56RJyX2GyQ3qM7lzIVpHQdUUuhNPL4wtCJ24J73egJ9LcJMKEhsAKcZJp1XpSrwVsqqO/Cz4kmgWRlGKYW4P3M6hTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9WbsfgsyvU2F7ix/L5P/6XYh3MzLjYYx/RCQbf40uA=;
 b=H6Lsgn3JzPiJLsWSbGOFmUe7xRWyXB77JbOmnB5bBsX5PXJC2mEAzTDk7MFzeZlFS3wPQsTf0GwTMERGxsAPRYMVWQfdFumZWGHq5BEvya0TvCmnDEdTL5QavAcpyv+Tb6QoYU7/l0uHltrckbvwHRAbr8AH41R5nx5wChEuuzS8bWEar/EHsjc2zTxT1b06EkJDazjBu+2/N21eYo1uLxL1lqa3WtwbkTOu4zYlEPt3OOwlOiK3EfvokbPKVKNs+LmEvn7rZM7rJdBg2QDU2KjoKIf22T5YbCcDuOyPVEVxmWr24o5A1JQGd3sxq8idl3jjRqerpDDvzKU3HSiO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9WbsfgsyvU2F7ix/L5P/6XYh3MzLjYYx/RCQbf40uA=;
 b=Zc4EqCrgpQEWuoKq9PcK9mQlTi42JJwheSi6NsssDtY4+D+TOfjH3db8JsOKNm9wHeLVCEEXxl0biJ97T90P0PTVcX1JXWVniu1Vwj1pXsbWMmi+uQi++opR2qAG5yFKtZm9XK+94lahceOp4Wx4/rvisSm2VUmqHqlI9+H1RJ8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4974.namprd12.prod.outlook.com (2603:10b6:5:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 15:18:21 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4628.018; Thu, 21 Oct
 2021 15:18:21 +0000
Subject: Re: FW: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
 amdgpu_device_fini_sw()
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211021071750.2912140-1-lang.yu@amd.com>
 <DM6PR12MB4250B78B1C9E96581C88310EFBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <6c167e41-dc20-95dc-6f71-839255cc2b25@amd.com>
Date: Thu, 21 Oct 2021 11:18:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB4250B78B1C9E96581C88310EFBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::31) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:48ac:a03b:8abf:f465]
 (2607:fea8:3edf:49b0:48ac:a03b:8abf:f465) by
 YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 15:18:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a415294-f02a-4dfe-1290-08d994a604a6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4974:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49746442B19AE8AC61B728DDEABF9@DM6PR12MB4974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CR05lW16A1/AzEmQ8zHfZETwHTVUiGTMbPZ8ViSjIMnIEkajEzZYSw9VbaY9lDk3xnwwI6iYrFAWwK9qtRxFLSN11PjNaf6k43L88WAYC+RLi8Dgi6ddJoO4YpvfkR8iMrSgnL/RTh8FZgRWytiHa+PIrv3G8Nn2/8ZsjUoi11ESW21Bl/MChrDS0a5x56DzrYTjcsB34KWFBXUcWjO7iQW/ZlkxpyNTySRoOB2D7Yp9qdOdluvZk3pOM6jDXX4bnZ6KRDhcu1fM/6knDRawa66ZWf7VBoFoRPmeUHHKasIFFD+iXBdfGnlm+Fb2vwWV8jTwXOuKJcR/JaF6oYIC/0+xn4//njew+z0jDrZm/AjG0OakP9EKk/bmulMDFJz5vMipFOfwPCiNzCGEt2PhZMwid4ZUt9Og+9jrOHDqnMGP2Bf3quAknaV5z2n1OPerhaUsGZkefim1NABB5/J59I6u69euzFdzDIAPCmrCue+mxOiPXNMVp4i/9j/R/01AJNSP3rQ5qC+42VrEQUEJkAcsfjcAyWJG68WpORDdPdAIQa8HIJaqBIJDKqg/SrrzMy5Xurpz4b7ALzhZxijpumvqaM0vOtiYljhtS2kihlMIIMdrofut7aGadeGQ3+3ZtYUbtBVAH/Iq39QdLG5Heab3r5nivNby2705feNbEjBfhNZ3htV5gLohYR6HrB5u7qx4sdm9qEiNP40MDxLPGnnc2ECKM0c94JbXVr91PA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(66946007)(2906002)(6486002)(2616005)(8936002)(4001150100001)(186003)(508600001)(5660300002)(8676002)(316002)(53546011)(110136005)(31686004)(31696002)(86362001)(38100700002)(83380400001)(36756003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aURYaU9aU2kwUkZRVnJqM2dBMENiK2h4WHhCZzBKbFZCUVZtTE9jdUU5eTVW?=
 =?utf-8?B?NDA1T2dYQ2ZjdW1LUEZLM1lWWWhqaWxqWEgxRHR2M1kzenlqSHh5L3JpYjVp?=
 =?utf-8?B?RFhFdHgrbjBBQTdlaWgya215RzFVbkgrcXU3bkU4Y1U2UnhwTUhwNUdob29I?=
 =?utf-8?B?d1RkMmY4VEoxeDRxdU1HbmJhenVURWtOWnFJZ0JzYmd4RDVTa2h3MGI5bEV1?=
 =?utf-8?B?ams4QSsySklSSk9ZQzFzRG9QVWlzUzhTcENVeUd4dVdGKzBiL2VjQmJlTTZC?=
 =?utf-8?B?S0ZvaUFlZVd4TUZVdDAzRnNjbEh2M1h3cC81VEsrbUhJaUpiam00UWZyMzlR?=
 =?utf-8?B?ZGhMOTFlelh2USt3eGlRT01WaEowY3FaQ0tadmsyTjFqaWtlQjM0K1FpbS9p?=
 =?utf-8?B?SFlRMVpyQk9jVTBtdVZOQmtYNlFpdFNTbTVxUkdadlB5bVRFWTZ1NzFZa3NI?=
 =?utf-8?B?QUZaUXZqNGRFSWxIb3d3VjhERllaQ0VDL3BGRFFPWHY1d3g1RXZRMXUvZkxJ?=
 =?utf-8?B?eDY4N2dIWGlwU0RkOUw5K2YyZktadWxldXZBMGc4Z3AwZmxHbkxZWDh6VnRV?=
 =?utf-8?B?elNVeHBsaFcwa1U5VS9EZHNERXBHb3Y3N3g0YUFEdUx2aHVtZmthVksyQnpk?=
 =?utf-8?B?SnYzaEVPeEFpYWs5Y0YwYk9zZHNOd2xzL1BzNU00eVlXUk5oYk40R1FPUzBQ?=
 =?utf-8?B?NHNUQkRqc2RqUDc1RXlubjI2MlltMHdLSG1zUEcxMHZqc3VuZStKUUJVeDBO?=
 =?utf-8?B?bUYxTGxpYjE3dlIxWk8vRVJ0bmJuWEJlTFFtOEg2TVhkZjYyWUlERDdkcEo1?=
 =?utf-8?B?VWI3cnVmazYyblFSTHlVUy9sNDdJTXg3ZEtPemtqNFc2VnNvdG5PM2Fia0k4?=
 =?utf-8?B?NFdhVm5rbzFMdFViZkJUWExXWG5uRjhldGlmeGtBZ2VsL1lWQ1hmSVdNczJH?=
 =?utf-8?B?VE9adDNLdEV3dkhudUIrL0tGdkxKWmhISGFreUNTV0svTXF1T0lDUUw0WnlE?=
 =?utf-8?B?ZmROTmRkR0V2YVlIVWk1ZlpzYXVtcmRlNkdXMUtVb3prbXlLUDFIelFLUFVh?=
 =?utf-8?B?d3VzaUVoVmR6TkxmdEd5UldmNWdBdWJVSnkrNUxYV1lIbkdzRnNmd0V3Q3do?=
 =?utf-8?B?eGpURVdVWms2OW1SV3FSVnlXdXM3ektzTnBwOGpxSEdjMjg1MlBLT0VtS1lx?=
 =?utf-8?B?aFdlSzlDQ2pPa2ZPVTJpZ1BCYlhhTTZJaVo1OEhZN0psWVRWSDVWa2hCQXBw?=
 =?utf-8?B?d2F4Q0x4WVY1VU9RalpmNUR0K0pGTnhreVFpZWhaa3N4YzJTYzJ3NzNjS21P?=
 =?utf-8?B?Q0JNUzA4OU12ZlpJd1R0V3Z0TFd4VUJ4a3hkdThQOXA1UEZwV2pacFpWTTlz?=
 =?utf-8?B?UnY5Vm9ITTc1ZG85a2Nicklycnc1Rk5jUXBNcmMzOTFuTks5T1hzRm1EUHh0?=
 =?utf-8?B?UWhjbzBUeFlqRTMzZ1lUd2VnVnR6VXFzSmlvWGtGNkNHTzJoaGhUR2UzN0VV?=
 =?utf-8?B?aFJuTFpwajYvTmpWMjFzRkhsWGk2N3FwY2RLcFZzWS9hb2JWR3VLQVFGUXVN?=
 =?utf-8?B?Tnc0SDNRTXZuWkJid085WUdUOXlsSDJZRE5LTjB2MEpDYTNDMjhBbURzTjI1?=
 =?utf-8?B?UjQ1a0RoYlF3VmV1L25XMDZxMVNnTE4xQ3Y5WUl6dTRDRVlpd3ZOdDExcGxr?=
 =?utf-8?B?OXIycEJKbXdxRml5R1BTbXFmaTBhb1RWb3psNFR6VFNGaU1wWHgxb3pCbXlC?=
 =?utf-8?B?UGpmSGpnbHpKVW52WEZ6OWtuMjRtbkVMazFIQ3ErNm1XUDVVelJFUXY5bEp5?=
 =?utf-8?B?TnZTcTYwYThoVVVEVmxLTWorTXJuK01YOEhjVE9YQmxPTFlrYUZTR1BGRWpa?=
 =?utf-8?B?a3pZRXc3T0JSYmhCRlVkbG9PZktDT3gvc2hTYlZZeit5czJhUjBoYUk5UXZ6?=
 =?utf-8?B?dXRiTjV4TUtIZ2lTWTZ4MFZUejZFZHdCdzJGUXp0cEYxSGIvYVd2aVhUMUl4?=
 =?utf-8?Q?bYmvg7+Ms1ssqWHwxEGMYUl/3MkiuA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a415294-f02a-4dfe-1290-08d994a604a6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 15:18:21.6758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agrodzov@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4974
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

On 2021-10-21 3:19 a.m., Yu, Lang wrote:

> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Yu, Lang <Lang.Yu@amd.com>
>> Sent: Thursday, October 21, 2021 3:18 PM
>> To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yu, Lang
>> <Lang.Yu@amd.com>
>> Subject: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
>> amdgpu_device_fini_sw()
>>
>> amdgpu_fence_driver_sw_fini() should be executed before
>> amdgpu_device_ip_fini(), otherwise fence driver resource won't be properly freed
>> as adev->rings have been tore down.


Cam you clarify more where exactly the memleak happens ?

Andrey


>>
>> Fixes: 72c8c97b1522 ("drm/amdgpu: Split amdgpu_device_fini into early and late")
>>
>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 41ce86244144..5654c4790773 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3843,8 +3843,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device
>> *adev)
>>
>> void amdgpu_device_fini_sw(struct amdgpu_device *adev)  {
>> -	amdgpu_device_ip_fini(adev);
>> 	amdgpu_fence_driver_sw_fini(adev);
>> +	amdgpu_device_ip_fini(adev);
>> 	release_firmware(adev->firmware.gpu_info_fw);
>> 	adev->firmware.gpu_info_fw = NULL;
>> 	adev->accel_working = false;
>> --
>> 2.25.1

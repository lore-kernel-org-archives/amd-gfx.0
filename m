Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C068AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 08:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CC861076
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 08:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88CC861076
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1EA6E987;
	Mon, 18 Oct 2021 08:04:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526046E987
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 08:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B074ZPNAxUN/ZnFTv2A9vfTm3WoQqWXpU3L6Lw8dOhiH6pECs77tgtwStDbJRMpWMciKk/WHR+PhXe4XBQU3cl5ZBSaXH0snJzMOyLN3Ymk3ixVTRPLBUmruvgwZ+7ahi+SUZ4msSOgO8HHlKlrGJdGH8173x4c6P1eE84Rl1XgMOrEquHvysWGJmwpYoiFbblLZz9wphISMeTBxHG/UVv0bfy/3H9ILMLnO+idLQPM/9sD19PHWWjTv/4Hbdok+UKl3SBvAwG7NoWL/XNagraOrM2n4gTN6/kvag86F0JUWFmYwLlJE/4gQuTRcukaAVq+M3eQbtlMeYA/8kyxu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUWZyzBR/G1jqphlq89FghYWXfS6Jdid4RWaGmAJxcc=;
 b=kG5uRN7jOvho8X+mU4syrJH9pklfo7XtwLegjU3k3VmKfJ2gMmBXl5/4PvcpDoaQlEXuH29w6zIC9Yp4D2CWbDYwrnrgKu8BY8sPV5KBWY4QoB74gXUlL8zNaMQytGLL7+N8kFiXM6UkrYQnpO8P2TLr7tKJabYgiHpbhfWYMSSxyB77Qz7pm3qEOi3ikDZcjloG3T6tzvvbU2vYdvavHinuyV+ohU5+GsGuqkCrV1d1eKByiNGdqqMqgQCDF1WCrL3r+BQEWixdLF4qjerIdQfU6W6lWiRaQHeDTqKbw17kbzo9A36FfmFM3fTdcn7wAVFzTFtIGj8eLeHpfn4nBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUWZyzBR/G1jqphlq89FghYWXfS6Jdid4RWaGmAJxcc=;
 b=IaS80V+MxY1zlUPr+I9AQ7JuaJVt27WwCbRPjNUCgR22rb7M4TygHQpYdGS22MYTF1R9hvLPQxe4i7mTsM/VL5FDSDUc7xY23CZIqLsuC8k3K5KfiB/nYaTGLmVBC8uu2eNhnWN/0KzXS6nQNtNOx20DzHuFPKor+37RfECKRwA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 08:04:50 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 08:04:50 +0000
Message-ID: <fe64d815-45a9-1560-d92a-2c1fc207f0b2@amd.com>
Date: Mon, 18 Oct 2021 13:34:36 +0530
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
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26197E608C4A9739D1E0855FE4BC9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::32) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0117.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 08:04:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6678c16b-e8de-4086-74ed-08d9920df5b4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4388AC1DF47831213AD17F0097BC9@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1aZy+jNZFUo78QyvgcB/LOjXj7OXhPasLwRVpeZo7A40enSVRTsMZitNkUk2qR1b8rxtE/YboTMCjv705GCy6DPfhD1WG8I2fDDVL3SyE1bXzTgUSDITOopffDi6+ipLLkGlpN44jxyK+d9XYANpQGpAp1pJJ0jtuxJOJFbbiRhWxB0vAIcMUXjMlCT0Og4Pw3Aa/efm0Pu7w201wCUe8cDW7SYBsAlXddCzo1NBoKCwi+TOOieRkkL2s34d1qW/SJHpSPyy/w4wpiKJkVodxpwzw8hzlLkwd6nNIvC+RWjmMdfxDRLN3WlSXBhk9bTYYhNxhrCnExiDl+4l3ARsSRFRUy89mxooZMFw3rZOqHZAt35BcX5lbQcVA5J/9OfQfgw3AREa4MDOQt+xpp3wDSzjQbXlO0EX9LSGLbOydFxkhX5vAcS4+XDFSu5NlI9OorIkim43sfJEgrPKBDpgCcaun3pTngbLwjReZO6bSYfccPrgWR0BWsc5wPOkcMphnTW28cZ4Mm3A/sk/p1UPJpkk+FT27HHOklsJDqz0z+NTqJ/0WIdOKaQOj36cKBjDAhJiaJfo/zaflQWDF4jmLvK2XQiWz8rB6sw/Uda0YFpi1dZI+bSIKvQsZx9w3ueouz8hisCpRAN5lfqc4sA8+iXEE8xfg0mWJWgsVc2FXqpOPg2SaupSkBYYBJ3cVlW7KK+ix320hJcoXAQACuIQeDDlB299PalbYqd3vWndxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(83380400001)(956004)(6486002)(54906003)(316002)(66946007)(186003)(31686004)(110136005)(38100700002)(26005)(66556008)(31696002)(66476007)(16576012)(53546011)(6666004)(2906002)(5660300002)(36756003)(2616005)(4326008)(8936002)(508600001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFmZktrZk85RWRCNnZOSEtzR1M4OVNOakY2bEszWWQwRm5ubkRSYW5rakxP?=
 =?utf-8?B?bkVENHU0ZXdMRktCYmhJM1ZIM20rSGdnZjUvaVpyM0xhbTBMZ1FWaG54ZmZV?=
 =?utf-8?B?T0ZSNHZoTGZxay9NZEcweXZDSWtpK0VWQ0ZlQ2cydVNreDZiYmcvTG9ITkdp?=
 =?utf-8?B?bGhYT082YmoxQStSL0hoOEFIdjBlMlR2UTZXOVlUbHcrSXFzMlZsVm0yOURR?=
 =?utf-8?B?aVNyOHRRTm5ZSFo4a0ZzNDhkQ1pwNDQ4emlPbUY0R0t2ZFFkN3FSdHFXNzha?=
 =?utf-8?B?bEJSYlBxVjZXbEJSTkVBQllDQXE4SExsOGwvVDBVRUlwL1gyZG13ZTErQitY?=
 =?utf-8?B?cE9EMEhnRGd3MWN4YXhCQkVJUEFUb2xqSGljM25KWHhpVU91QkduWFp5UzRs?=
 =?utf-8?B?NElEVGp1NWMvalZzZEo2T3NlTGJzVzBLa2hIbFNmQldMQk5FY0R4MTlaSHQ3?=
 =?utf-8?B?SHdyZ3ppOEZLb2I3dTN4eExIYzlod20zVTBnRERiWEJnYjhDN1ZUdnJITjQ2?=
 =?utf-8?B?T0dXTU5ZR3p1bVdpejczTWxsUHVQQlAxSFdqMFlsN25NaTlpT2ZVQXNFVmdw?=
 =?utf-8?B?dGV0QkI5Q2l5dGt4bjJPSUcvYzM5dEtWTEhVWUw0bkV3R1pkQmNlSjZZTmVJ?=
 =?utf-8?B?S2NOS2FQNlBCTk9yOVlKT05Od0J1MVRSbUR6WkRYV0FtUlVRblR1SXc0STVI?=
 =?utf-8?B?MXM0ZGVvZDdoSnF3M3pnZ1BDYkx0Tkk4UDJBZlpuYlBWR2RXRzFWS25BWElE?=
 =?utf-8?B?OGVrSjZ3bWZGcFVtc0JiSGdtT25rb2UxU1Ywa1pzWlhEVFhpcXRMMzIzQXIw?=
 =?utf-8?B?WndmOUJPWmFtMDB4M1J5VHp0VjFQT2NtVklySTRHUHV1UlJYRTNvOEFrNWlZ?=
 =?utf-8?B?ajlIaENjczZVb3VTRnpla0liVzJncWQvTlhoelNQc3hMNXcweEwzSVBwbTNQ?=
 =?utf-8?B?cVhPSW9LTHpJQ05jTDkzdjBrNSt2L1VseWdvVWI4Mk1QYWIyd1FzbjhCb0pa?=
 =?utf-8?B?cDgvUnJ3dlhrcDdVYVAwYTJCaUhVVDRmdmlSZVg0MjJmanNreVo1L2hkMERj?=
 =?utf-8?B?Sng0M01ReHN3ZFlrQmRsV1ZiRTZJMzhkQVRXdklmbzZMTnFScTZEbkdJcjJQ?=
 =?utf-8?B?OTlkcTA5Q0V2STdEaXBnYjRMSHE0bDVzRmFDQ2oxZmZoZG9JajVwNmU5RllD?=
 =?utf-8?B?ZllKd21vZjgxSXgzK2JXVHloekFFL3lMWUdjREZZQWtJK05FaXkvNFBKczE5?=
 =?utf-8?B?dmdMU1lCZVpTc1dvNEw0d3M2ekRZY3dhVlUxWXc4SWNMb1JoOXpEWFhuUFZx?=
 =?utf-8?B?WVc0a1pYSzJ2cTRxSk0xcHpNSjRlUHhGellFUVA4clZ2YlVzU2lXR2d6MmUw?=
 =?utf-8?B?MWdXWFJVM0IrV1ZpNGhGOThRWU9GdTVBUk56T1ZLSi9BZklEdzJNSmVkNjI1?=
 =?utf-8?B?YTVWek5FRjBiaXZPNzF4UVAwZEwzdmEwRkhleXBhamRPME0yNDhRRC9nVk5T?=
 =?utf-8?B?MTZJNnRMeUJxeXNaZFhnaytTT3Q1dFMxK2h2L2RmVmF4cEFEWGs4bGZoQWJB?=
 =?utf-8?B?TzRBSUZKYzRVMEtvSTRrZjFvLzRWSjZCR1pUbjZQSnNkcHlDdGpUZlBQRVRp?=
 =?utf-8?B?YkdiRGZhb1JHMHdKbzNIQ3BuWU5UaUFackQ4T2JOMjZqektzT09PdjVvZkh3?=
 =?utf-8?B?OFZhY3ZsMkR1cEhtLzA4Y0t3aHNXdUhUeUtpcUZKMGc3djFDM1ZSMzlUM3o4?=
 =?utf-8?Q?huQ2S5v4UiS0rQvinY+4pmBfZAGFYBrn0sephv3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6678c16b-e8de-4086-74ed-08d9920df5b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 08:04:50.8147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R83RQLnAXCfTqMEROGvS+Fr2YtUYiikweLwNH9REGpuEyqZWRZMozcHM5s67NuHB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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



On 10/18/2021 1:06 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> Ping..
> 
>> -----Original Message-----
>> From: Quan, Evan <Evan.Quan@amd.com>
>> Sent: Monday, October 11, 2021 4:28 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Grodzovsky,
>> Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan
>> <Evan.Quan@amd.com>
>> Subject: [PATCH] drm/amdgpu: fix Polaris12 uvd crash on driver unload
>>
>> This is a supplement for the change below:
>> cdccf1ffe1a3 drm/amdgpu: Fix crash on device remove/driver unload
>>
>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>> Change-Id: Iedc25e2f572f04772511d56781b01b481e22fd00
>> ---
>>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 +++++++++++++-----------
>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> index d5d023a24269..2d558c2f417d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> @@ -534,6 +534,19 @@ static int uvd_v6_0_hw_fini(void *handle)  {
>>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>
>> +	cancel_delayed_work_sync(&adev->uvd.idle_work);
>> +

To solve Boris' issue, this patch should be modified such that DPM 
disable done by the idle job shouldn't be executed during hw_fini. 
Preventing powergate during suspend is not needed.

Thanks,
Lijo

>> +	if (RREG32(mmUVD_STATUS) != 0)
>> +		uvd_v6_0_stop(adev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int uvd_v6_0_suspend(void *handle) {
>> +	int r;
>> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +
>>   	/*
>>   	 * Proper cleanups before halting the HW engine:
>>   	 *   - cancel the delayed idle work
>> @@ -558,17 +571,6 @@ static int uvd_v6_0_hw_fini(void *handle)
>>   						       AMD_CG_STATE_GATE);
>>   	}
>>
>> -	if (RREG32(mmUVD_STATUS) != 0)
>> -		uvd_v6_0_stop(adev);
>> -
>> -	return 0;
>> -}
>> -
>> -static int uvd_v6_0_suspend(void *handle) -{
>> -	int r;
>> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -
>>   	r = uvd_v6_0_hw_fini(adev);
>>   	if (r)
>>   		return r;
>> --
>> 2.29.0

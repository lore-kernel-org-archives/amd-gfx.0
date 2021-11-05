Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CCBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 15:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD366008E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 15:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CD366008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E9B6EADA;
	Fri,  5 Nov 2021 15:47:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8546EAD9
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 15:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc27QPs4Y14rHgtXjTnTTP7TzUa5Z+goNxYZXQEu1sgqa5qyNY4QjrS614xCsJJA8cIoxarBwTLtFvVD1Dx/70ht3Mj8bJsY0J2Lc3uOgwp2CILOiSpthFW+axZJXn3ah4OlF7/hzPWA15OXjaEt7YEy+65a7Dk3TuJgbKmytjalIFLjC29vxFtB3Rk2qTERurTOMnyO/uDCUvdIyXMRy9dod+9scFb0O1misC2KfrQ4/V690yvYVsVqvhUsrWdekX10ntyRS32nBbiv8eDyB5I2IzlxPgfpkSwgsuRkumqWdiWGBBhZAcHMXjapnCmwRaWP9ZdXZy68mER3pzdMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF4qzvVWj8Igky5VTOpC1KpTg6IdFiEvbwKVY6KshSA=;
 b=g1Fn5rLLiVaVVwchzbbvFNz3ORnanQCfjSe9bpLLAwQkqxxvw9r8Tmjlq7gQ/taIPpiUOBUUZv79RjMFPc3KCXXZsQkuXDQVS0DDFTdWEgQEzauT4gOPFJwFEnmtM2gLxSFvLwfpVywYVIpSA/1JTuiR0vWhQOf5uMceSiikAVbchL61D8wIl4vvrE4p1pP1Kv/VojurKc9SvkWBWhn0mCJ3Oz/xY0uY3hClYX6rWqEhr2A6H60rymgioGMVjFqbv40dXUp11NOptpOW8HNC3DHtm2TAt7PXJbbG0XtIukPiqOct55BFFYjihsfd55aWDZKONzNS1OyK6Gop8gH4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TF4qzvVWj8Igky5VTOpC1KpTg6IdFiEvbwKVY6KshSA=;
 b=tLQXytLhhsOYKyZSRhxckm/fWGW6IsPRrtRV0vIGZ5XTQi4ikRnxAKXENhzPcZ17UC/NwoBI9heAyMtchaPpRvoUDgQzUSodTUqABy4GJYrDBM8F66T25WWSxTURImrhMdneVv7jlITocMw6EKBDqdt+qvRsvOuXnHU5FhkFR0U=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 15:47:55 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::e95d:8a23:c590:e07a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::e95d:8a23:c590:e07a%9]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 15:47:55 +0000
Message-ID: <9b8fb73d-1d6b-669e-a96d-637a47a22e30@amd.com>
Date: Fri, 5 Nov 2021 16:47:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH 3/3] drm/amdgpu: enable HIQ in amdgpu without kfd
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20211105140912.3638-1-nirmoy.das@amd.com>
 <20211105140912.3638-3-nirmoy.das@amd.com>
 <CADnq5_Od6WAjaKp0i4kB3Z60qOHnRZ5J6sGX4REy0Tf_Lr8K5w@mail.gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <CADnq5_Od6WAjaKp0i4kB3Z60qOHnRZ5J6sGX4REy0Tf_Lr8K5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0078.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [172.31.54.68] (165.204.72.6) by
 AS9PR04CA0078.eurprd04.prod.outlook.com (2603:10a6:20b:48b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Fri, 5 Nov 2021 15:47:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b40c3776-3c1a-4017-bd99-08d9a073a210
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5246410017B954AFF50BD6EE8B8E9@DM4PR12MB5246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GDv1aq8pAOLaBqhVX1PM0jBT/vkMAHQSHugwq5SRFSHqKVvTqOZKGpM8QqLjU6JAdelc8Db1G4gKb6hKAWHwtOcjoBmLypsoKaSlDukjEgkjcqHY+TDyyf+vTbpe8W/CCuiEPKsXHnshY0VMBeVQ1tPJv+evMlahEveaUa7TB0Kd+wNaZQZA2glTNZEMOAsNipqVPW7GPIpmqKOWPDp1yNqXbKVOqIu2d2q8FpSjO+uG80Ob/xzRIQ7LF4BfRZNw1L9ldCRlD9yiCSl2gN70HE7nH/aGcIADkyRLnMcubt4feN1ndRs92eeZE/NKOqOJXxtHyPZlNC1EaNnGpovsRIUa5DJkHtMNnMgx+XxlDFWz9T6/w6GzR14gjJYhhYQDVP+qEIoL0mL4sh7d+ta+U2ABXp7I0eadS7yPNJLI4woYa64sB3to2QM8CQejbC2o+jPHSPAhZAL5OheolFj2yuubaFpu6Z4jpoD9neid/tqdtf6KO3S/PUSDjmyHV7tw+3JnxJFViO8EbJYv5v9snsdjMgBRV+SPrlX/leLdMsRAAxUjOi4xx7rRBXRr0JsO1N9mgS32ZknHzfrdTYhm6i71c7A0FpK2iDKMkusAvIqo25cMtQqCtQZByDk8J9AzMqNsNXjS8IknRBVZEEMG4XY8CHSPLOGdWe/PmspzOUjRR1Ne226lTgGLnHT4Io2sPPTbCK+fZ6GXJ+P5RJPJvrIbAFHCOzL+b+dOrZV6Fg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(6666004)(6486002)(8936002)(31686004)(38100700002)(5660300002)(316002)(16576012)(54906003)(53546011)(31696002)(36756003)(8676002)(186003)(2906002)(508600001)(6916009)(66476007)(86362001)(83380400001)(66556008)(956004)(2616005)(26005)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXNjRnJKNE5ITWdWVmpKU0o4NmZia0VjMU5WSHRLQUllM1ZPS01vbEFMcjJD?=
 =?utf-8?B?clZjUklvR0gyZlJNOU9tVUpYTkVyS2c3Vk5RN05Oam9XVERpSytzUTNIMEpJ?=
 =?utf-8?B?ZU5CcnQ3aDBaT0ErYnVtSWFnT1JzaU1Ba0IwaVNBT0NFU0tMZlVISkNGaGh5?=
 =?utf-8?B?UmxtVzVkenB6bHdzUjhya01OU1ZiTkVwdFlUWEo5UkhJT3NiTWhZdkVxTGNn?=
 =?utf-8?B?ak1zZ1UzaGdSdUlSRU1vaHJ4V2xERzFaWDY3OWJseE13SGJSN1VqT2w2YWVw?=
 =?utf-8?B?UnlQNjdUSHFOV0FWbVd1dnNLMTNIcnJ6aWpJVGhBMUpEdFBJcyswd3pwZlhK?=
 =?utf-8?B?QVh3MVlkZXB1UElHS212VGQ3YW40K3VMV2hvaGRRditpTk5BVllHVFJrT1pH?=
 =?utf-8?B?V0ZxTkFsMEpibE54LzRjTWh3SGkyRDVhTzdGZFZwMmFFUEVmcUhOZTh1WjlK?=
 =?utf-8?B?S1FZU3JscFZiNkZpL2lOcjRpUytuUVZmYXFtM05VQnVrTCtGQmlFNk1GOGlO?=
 =?utf-8?B?TlJvMzBEVlowc0VxeUFRT1FZNVJqVFlkVHhUT09MaFVHWW1qWEpLeFlvRFAv?=
 =?utf-8?B?SjJTc3RlUUN3K3hpcXZZNzFmdUNjSHZPQjlHdVRKM2tFWG9rWHpvWlRqbXlE?=
 =?utf-8?B?anRWbmZTTS9PVGN4dmdwTWRnRENvbGVPSlpCaGV5K0JJZkZHL2xhS2hZcEh6?=
 =?utf-8?B?anF5dWxia0VGMUVadjBTQjdWYkE5UURremFDUjVsWWZrYkk3ZFdpNFFQY1M5?=
 =?utf-8?B?eGlObXA5ZGdQcXNDYVB1N291YWNydGZUdXZnc2FyampjZWpqMjMySEpSZ3BJ?=
 =?utf-8?B?MHVHWTNGMmgrdlRNaG9LcUR0UXlGNEdGK2dEV0VGblNvd3IvbTFpQmJ4eHRo?=
 =?utf-8?B?R1ZSYUo4ME0ySFVFSTRiM2U0TDNsWEFPekpmY01CTUE3bzhUbVN4Wm5BM01R?=
 =?utf-8?B?RElYNVcxTklYSUVTQW15eGpmdlBab3FJYnFHTTFqNER6NXgzYWZvN0VEc21R?=
 =?utf-8?B?K1BuS0RkQ2UxUS80NUF4VCtVVGVSMGRCdkdLa2VKR1JoTEZ3MnVXTjl5VExx?=
 =?utf-8?B?cEhERzNSRHhrdUxJM3JnZWdrdVViaVdXYVJqMmg4enNMRTNkM3hSdGRBWm56?=
 =?utf-8?B?S1kvdnZXTkczd1YzRU9hRk1DYjBrUDNSQy9SNVU1UmNSMTBrV0tpUEN0WDFU?=
 =?utf-8?B?Zi9vY09MTjNUbHlrQXZnandlTUZxY2Q0VW5oRXpFbjArakVEaTViUHVmWTdX?=
 =?utf-8?B?dXcrVERYbWdUdjdWRGhwSEdEemlnL1dxV0pMRVp2d2xmZWtRVElwNEdBdmtG?=
 =?utf-8?B?dnZnWmVrSklXMWFjRk9HenI0aFJIeHlPSjZudVcxVVZlK0Y5TnkrWFBUUGo2?=
 =?utf-8?B?eS94cXZwOTJWTDBvR0YwZHRaUmJrWVN6QzJTeG1iaEx6WTJ6LzNPcFVOMzFO?=
 =?utf-8?B?L014bGpVdXNXS1RGWDNsZjVsUUNYVEZJemZUMnBTSjRZV3VEdldzaExsYmVm?=
 =?utf-8?B?RmRGa1VzZzdsRFBDTmcrS2w3clVoRlJxMVlBSzFkMUVybUcwKzhGejVkUTVT?=
 =?utf-8?B?VjZtTmVBbUtnYlQ1ZndEYk1nNWhKVUM0bXMyUXl2aHM4Vjh4SndFODJ3aHVO?=
 =?utf-8?B?VDFleGFHck0zUkpQSzI3aHdWVDhmU0kyQmJ5TVpOTnpCdkJJYXVEVUJhUWxQ?=
 =?utf-8?B?WjQ1R1FOL1k4WERPcWpWZ0xyOHE3Y2hpR2RHS1VJL3hJVmNBZ09VQmJxVHh5?=
 =?utf-8?B?UlZlUFBXaUNFNVJQY3lEL3JQUDRIVkUwVEJ5UitJMk0rNjl6QjgzZlAzMGFJ?=
 =?utf-8?B?TDB6STFyOTUxRWhVWEw2WnNmMHZ3MmowTUNCL1AwenZRTEpZcGdtV1ZUdTNL?=
 =?utf-8?B?cnp2S2c4UGVNYVVFR0xFYkZ4VmZERWgrSWluNzZYZE55OEIxTFZHMnBINkxx?=
 =?utf-8?B?OWcySUJaTzBvL2FLTEk2STN0VnF2YUtHQU9mQllCVUdnSFdtZmNmNmNmQitD?=
 =?utf-8?B?YzI3YTNSRzAyVXZ1TXJiV2tnbm5HbVp2M0ozNGFIc3NrVHJWRXhjeUdpV1BB?=
 =?utf-8?B?c2tCTUExekh4YTdRTGZ2Z1crcmZaR3VzYlJFTU4zUFp1OFNSMGRSdW9sTU04?=
 =?utf-8?B?R3RyQXlnODJHclVoQW44eVk4V3NHZ2cwWFdNM0UxdWVMZHd5Y1YweWxMaXNt?=
 =?utf-8?Q?957kvYf7BEcVIah6BfnUx1I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40c3776-3c1a-4017-bd99-08d9a073a210
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 15:47:55.3660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UomfvvRkHZvi+2VRTgBBrgJ9WOuZE2vw6whT0aMcNFZYr9GFuWQv+44ztzDHrFTg3zEXQ3qa8In0cly0Q7exbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <pierre-eric.pelloux-prayer@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 11/5/2021 3:17 PM, Alex Deucher wrote:
> On Fri, Nov 5, 2021 at 10:09 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>> There is a HW bug which prevents CP to read secure buffers
>> with HIQ being configured and mapped using KIQ. KFD already
>> does this for amdgpu but when kfd is not enabled amdgpu
>> should that for itself.
> Can we just move the HIQ init/fini into the KGD and then have KFD call
> into the KGD when it needs to interact with it?  I'd rather not have
> two code paths to maintain to handle the HIQ ring.


I looked into the kfd code a bit, AFAIU kfd deals with struct 
v{9|10}_mqd instead of amdgpu_ring.

I could try to expose a function in KGD to map HIQ with a mqd struct 
which kfd can use.


Regards,

Nirmoy


>
> Alex
>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 ++++-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 77 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 80 +++++++++++++++++++++++++
>>   3 files changed, 170 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 053a1119ebfe..837f76550242 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -519,7 +519,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>>                                              AMDGPU_GEM_DOMAIN_VRAM, &ring->mqd_obj,
>>                                              &ring->mqd_gpu_addr, &ring->mqd_ptr);
>>                  if (r) {
>> -                       dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
>> +                       dev_warn(adev->dev, "failed to create KIQ ring mqd ob (%d)", r);
>>                          return r;
>>                  }
>>
>> @@ -569,6 +569,18 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>>                  }
>>          }
>>
>> +       /* create MQD for HIQ */
>> +       ring = &adev->gfx.hiq.ring;
>> +       if (!ring->mqd_obj) {
>> +               r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
>> +                                           AMDGPU_GEM_DOMAIN_VRAM, &ring->mqd_obj,
>> +                                           &ring->mqd_gpu_addr, &ring->mqd_ptr);
>> +               if (r) {
>> +                       dev_warn(adev->dev, "failed to create HIQ ring mqd ob (%d)", r);
>> +                       return r;
>> +               }
>> +       }
>> +
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 538130c453a6..9532f013128f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4794,6 +4794,7 @@ static int gfx_v10_0_sw_init(void *handle)
>>   {
>>          int i, j, k, r, ring_id = 0;
>>          struct amdgpu_kiq *kiq;
>> +       struct amdgpu_hiq *hiq;
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>
>>          switch (adev->ip_versions[GC_HWIP][0]) {
>> @@ -4923,6 +4924,18 @@ static int gfx_v10_0_sw_init(void *handle)
>>          if (r)
>>                  return r;
>>
>> +       if (!adev->kfd.dev) {
>> +               r = amdgpu_gfx_hiq_init(adev, GFX10_MEC_HPD_SIZE);
>> +               if (r) {
>> +                       DRM_ERROR("Failed to init HIQ BOs!\n");
>> +                       return r;
>> +               }
>> +
>> +               hiq = &adev->gfx.hiq;
>> +               r = amdgpu_gfx_hiq_init_ring(adev, &hiq->ring, &hiq->irq);
>> +               if (r)
>> +                       return r;
>> +       }
>>          r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v10_compute_mqd));
>>          if (r)
>>                  return r;
>> @@ -7215,6 +7228,54 @@ static int gfx_v10_0_kcq_resume(struct amdgpu_device *adev)
>>          return r;
>>   }
>>
>> +static int gfx_v10_0_hiq_init_queue(struct amdgpu_ring *ring)
>> +{
>> +       struct amdgpu_device *adev = ring->adev;
>> +       struct v10_compute_mqd *mqd = ring->mqd_ptr;
>> +
>> +
>> +       if (amdgpu_in_reset(adev)) {
>> +               /* reset ring buffer */
>> +               ring->wptr = 0;
>> +               amdgpu_ring_clear_ring(ring);
>> +
>> +       } else {
>> +               memset((void *)mqd, 0, sizeof(*mqd));
>> +               mutex_lock(&adev->srbm_mutex);
>> +               nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
>> +               gfx_v10_0_compute_mqd_init(ring);
>> +               nv_grbm_select(adev, 0, 0, 0, 0);
>> +               mutex_unlock(&adev->srbm_mutex);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int gfx_v10_0_hiq_resume(struct amdgpu_device *adev)
>> +{
>> +       struct amdgpu_ring *ring;
>> +       int r;
>> +
>> +       ring = &adev->gfx.hiq.ring;
>> +
>> +       r = amdgpu_bo_reserve(ring->mqd_obj, false);
>> +       if (unlikely(r != 0))
>> +               return r;
>> +
>> +       r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
>> +       if (unlikely(r != 0))
>> +               return r;
>> +
>> +       gfx_v10_0_hiq_init_queue(ring);
>> +       amdgpu_bo_kunmap(ring->mqd_obj);
>> +       ring->mqd_ptr = NULL;
>> +       amdgpu_bo_unreserve(ring->mqd_obj);
>> +       ring->sched.ready = true;
>> +
>> +       amdgpu_gfx_enable_hiq(adev);
>> +       return 0;
>> +}
>> +
>>   static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
>>   {
>>          int r, i;
>> @@ -7252,6 +7313,12 @@ static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
>>                          return r;
>>          }
>>
>> +       if (!adev->kfd.dev) {
>> +               r = gfx_v10_0_hiq_resume(adev);
>> +               if (r)
>> +                       return r;
>> +       }
>> +
>>          for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>>                  ring = &adev->gfx.gfx_ring[i];
>>                  r = amdgpu_ring_test_helper(ring);
>> @@ -7557,6 +7624,11 @@ static int gfx_v10_0_hw_fini(void *handle)
>>   #endif
>>                  if (amdgpu_gfx_disable_kcq(adev))
>>                          DRM_ERROR("KCQ disable failed\n");
>> +
>> +               if (!adev->kfd.dev) {
>> +                       if (amdgpu_gfx_disable_hiq(adev))
>> +                               DRM_ERROR("HIQ disable failed\n");
>> +               }
>>          }
>>
>>          if (amdgpu_sriov_vf(adev)) {
>> @@ -9470,11 +9542,16 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>>          .emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
>>   };
>>
>> +static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_hiq = {
>> +       .type = AMDGPU_RING_TYPE_HIQ,
>> +};
>> +
>>   static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
>>   {
>>          int i;
>>
>>          adev->gfx.kiq.ring.funcs = &gfx_v10_0_ring_funcs_kiq;
>> +       adev->gfx.hiq.ring.funcs = &gfx_v10_0_ring_funcs_hiq;
>>
>>          for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>>                  adev->gfx.gfx_ring[i].funcs = &gfx_v10_0_ring_funcs_gfx;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 2b29e42bde62..9653ea8743d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -2309,6 +2309,7 @@ static int gfx_v9_0_sw_init(void *handle)
>>          int i, j, k, r, ring_id;
>>          struct amdgpu_ring *ring;
>>          struct amdgpu_kiq *kiq;
>> +       struct amdgpu_hiq *hiq;
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>
>>          switch (adev->ip_versions[GC_HWIP][0]) {
>> @@ -2428,6 +2429,19 @@ static int gfx_v9_0_sw_init(void *handle)
>>          if (r)
>>                  return r;
>>
>> +       if (!adev->kfd.dev) {
>> +               r = amdgpu_gfx_hiq_init(adev, GFX9_MEC_HPD_SIZE);
>> +               if (r) {
>> +                       DRM_ERROR("Failed to init HIQ BOs!\n");
>> +                       return r;
>> +               }
>> +
>> +               hiq = &adev->gfx.hiq;
>> +               r = amdgpu_gfx_hiq_init_ring(adev, &hiq->ring, &hiq->irq);
>> +               if (r)
>> +                       return r;
>> +       }
>> +
>>          /* create MQD for all compute queues as wel as KIQ for SRIOV case */
>>          r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v9_mqd_allocation));
>>          if (r)
>> @@ -3911,6 +3925,56 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
>>          return r;
>>   }
>>
>> +static int gfx_v9_0_hiq_init_queue(struct amdgpu_ring *ring)
>> +{
>> +       struct amdgpu_device *adev = ring->adev;
>> +       struct v9_mqd *mqd = ring->mqd_ptr;
>> +
>> +
>> +       if (amdgpu_in_reset(adev)) {
>> +               /* reset ring buffer */
>> +               ring->wptr = 0;
>> +               amdgpu_ring_clear_ring(ring);
>> +
>> +       } else {
>> +               memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
>> +               ((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
>> +               ((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
>> +               mutex_lock(&adev->srbm_mutex);
>> +               soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
>> +               gfx_v9_0_mqd_init(ring);
>> +               soc15_grbm_select(adev, 0, 0, 0, 0);
>> +               mutex_unlock(&adev->srbm_mutex);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int gfx_v9_0_hiq_resume(struct amdgpu_device *adev)
>> +{
>> +       struct amdgpu_ring *ring;
>> +       int r;
>> +
>> +       ring = &adev->gfx.hiq.ring;
>> +
>> +       r = amdgpu_bo_reserve(ring->mqd_obj, false);
>> +       if (unlikely(r != 0))
>> +               return r;
>> +
>> +       r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
>> +       if (unlikely(r != 0))
>> +               return r;
>> +
>> +       gfx_v9_0_hiq_init_queue(ring);
>> +       amdgpu_bo_kunmap(ring->mqd_obj);
>> +       ring->mqd_ptr = NULL;
>> +       amdgpu_bo_unreserve(ring->mqd_obj);
>> +       ring->sched.ready = true;
>> +
>> +       amdgpu_gfx_enable_hiq(adev);
>> +       return 0;
>> +}
>> +
>>   static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>>   {
>>          int r, i;
>> @@ -3946,6 +4010,12 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>>          if (r)
>>                  return r;
>>
>> +       if (!adev->kfd.dev) {
>> +               r = gfx_v9_0_hiq_resume(adev);
>> +               if (r)
>> +                       return r;
>> +       }
>> +
>>          if (adev->gfx.num_gfx_rings) {
>>                  ring = &adev->gfx.gfx_ring[0];
>>                  r = amdgpu_ring_test_helper(ring);
>> @@ -4027,6 +4097,11 @@ static int gfx_v9_0_hw_fini(void *handle)
>>                  /* disable KCQ to avoid CPC touch memory not valid anymore */
>>                  amdgpu_gfx_disable_kcq(adev);
>>
>> +       if (!adev->kfd.dev) {
>> +               if (amdgpu_gfx_disable_hiq(adev))
>> +                       DRM_ERROR("HIQ disable failed");
>> +       }
>> +
>>          if (amdgpu_sriov_vf(adev)) {
>>                  gfx_v9_0_cp_gfx_enable(adev, false);
>>                  /* must disable polling for SRIOV when hw finished, otherwise
>> @@ -6986,11 +7061,16 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
>>          .emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>>   };
>>
>> +static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_hiq = {
>> +       .type = AMDGPU_RING_TYPE_HIQ,
>> +};
>> +
>>   static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
>>   {
>>          int i;
>>
>>          adev->gfx.kiq.ring.funcs = &gfx_v9_0_ring_funcs_kiq;
>> +       adev->gfx.hiq.ring.funcs = &gfx_v9_0_ring_funcs_hiq;
>>
>>          for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>>                  adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
>> --
>> 2.31.1
>>

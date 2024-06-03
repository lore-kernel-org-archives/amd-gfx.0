Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8D1C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 11:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E448B10E1E8;
	Mon,  3 Jun 2024 11:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qZF2F/M8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1471B10E1E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 11:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8sQcvzHEborYbSO+Qd2CBrFqJAm1STEiHUl2pQnWk2u6oQmkgiJqnSZ0B0PBpQS4nuQ2YJjZT1zS/6F3r+78CEkI4lNqN21VqZ2TsPYoPJm2pmr0wXZoZJwf4cdxuD/N5K+qgao+IxO2/06VEeXKkFVK8NEHRifnmcgr44QAHFFxFfSA1n5hoYTRll/uYvwnfL+OXUAkWMayYDLN2eJXFAMDSRRgJhwemkI2XRBz6YjvdGGm8F2SmuifrLqBtc24sDIaDASFZKxwCmZsRtt3tbZz7olIsM6Z7YZZ632aaLcmP/yXzZjprLFJDkfZsg3IKSZ5qHE0NwlSqoBjGb25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4NMd+4WJl2/RqHf0IR+clALd6msA3QQnHUDV9OPysc=;
 b=D25RgFYACkkHR6M5hS2tVw7Ko8Em6bNlQ5Ge3TocpL9VWFGMHV05pbfinPtFmDWc8Ib2r9CivGLupeQfsC215ziYF319029T5XJV1yIEVuGaXE4uz7q/LlZRn6KLEJdUBoYlkh3hPGSpt7zaovzwLHo7e4Pn/qYldWHorzkPvosy6Dx4MPNKclFoVTzZ9jo26tj/fgq4CqdzN7dAAnQJ7rZPHQ+6QFcWWYtyBoVKmbeg0vGAC+juTTxu3A/tjVjy2gFUfT2SqVjz3BHpyA2kGT959QMzOraAPO3mwKtHwziZRGV6Jq9sxr2ry6ao6i+K6g99YStlk16ROBk/4PVXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4NMd+4WJl2/RqHf0IR+clALd6msA3QQnHUDV9OPysc=;
 b=qZF2F/M8NMhnMHUXfZIrfrELMTMCwPGfsBagMc87PV+K8QmdQeUYcepOiSrkGqrdIofSacZoJ+AvFcp/6zWLLTGYoZ3IwFbj379NAwS/9YxYzhbjg0Dv7xggDUhSChdviIA4ANbPOF7WYXcSWcYSc4GogJSSNX1/+B1tGfk+h0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 11:10:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Mon, 3 Jun 2024
 11:10:56 +0000
Message-ID: <faa146e9-c2cb-4831-af0a-539dac51d912@amd.com>
Date: Mon, 3 Jun 2024 13:10:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: replace int with unsigned int for imu_v12_0.c
To: "Zhou, Bob" <Bob.Zhou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Huang, Tim" <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240603055925.353172-1-bob.zhou@amd.com>
 <643687ee-4f93-4448-8d09-c841e1ce2746@amd.com>
 <CO6PR12MB5394B8D4CCD80B551FFE43EA94FF2@CO6PR12MB5394.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CO6PR12MB5394B8D4CCD80B551FFE43EA94FF2@CO6PR12MB5394.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bb9c5b-6f2b-47b6-3fac-08dc83bdd756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUR1WStpTXY5YWNJdEROM0dzTVJzMHFLQlpMc0JKank2Vnd1MWhHdDFBdTQr?=
 =?utf-8?B?dlBFL3I3UUJWTEk1OWExOEp1bHdzclVRKzlWa1VYWktjSitQWTBWNjhpbCtT?=
 =?utf-8?B?bnJBVnY1N0VxRDcwYytsRW1uQW1DVXdFcnU2R29wYkpHQjhmWHZpaTM4bzRQ?=
 =?utf-8?B?Ti84Nkk1UXpJOUhuMm9Gc2xyVkZ4TExSTmg3VmJTN0NlVTY1dEVXMzFSUThW?=
 =?utf-8?B?YnNKanQ5YytxVXZab0RBNjN0c0sxQ29MdVc0M2N4N1F0NWs1a2tEM2M0dnhu?=
 =?utf-8?B?MUdaZmI5d3BBUlA2czdKSWRVS0RCWkFNcURLWURES1NSclpDalVaNzBTdXJz?=
 =?utf-8?B?ek03Q1cvdC9hZjV1QlFBaXdSeGF5Y2lXd0t0Z2RxNGgxSklzOG0zY0ZHNlJP?=
 =?utf-8?B?RDJVS3o0SzZxLzAyRDcvQndvQzNMbzZNZnV4bEtGak80aVZ6dHdydExWWk5O?=
 =?utf-8?B?cEp6Y01XOHhmWmF6YnhMQ0VjZHF5eWIzdStjbjNnbUhGMzA5SFF3YmdSV0Ji?=
 =?utf-8?B?SitXY2cwYVZ3YkZCYm90VlVNeHRyYWRUNTlkdXpqYzArOWJjSGZqMnpGbU90?=
 =?utf-8?B?Q0FxM3VzUmFVVG5ySnlQeWdFUitvOTA2dHBVMlNLRDk3aFhHNjlFeXJRdy8y?=
 =?utf-8?B?NS84bEg0WU1KUzRUOGpmNjJpKzJ6M2lXSkJXT2xyOEFvNk80UmZCYmlwck5W?=
 =?utf-8?B?dWhKdG55Nm8vZ1ZSWUhxZVpwamNrVmRtaUNnUkdEeWFMUjNrMUtCUnpKa0ZJ?=
 =?utf-8?B?NFJwMzJkZGlCVnVOVEs3Vlp2NjJZaFFEazg4cTBmbkxLd01DREJ1LzYyWUMz?=
 =?utf-8?B?RGZsUGFFaHFhQzhFN2hlMStEWXA1V1FmQ1Y2VHlMQ29rY1Bqa0pTVW9ON3dw?=
 =?utf-8?B?aFlXVmVPRXljd2hUQ1hNVTdxQjhmZ29OR016TElReVB0RjlHYnEzdW51MG1I?=
 =?utf-8?B?K3YxRXdYWFBTU3NPTUZGS0dLdERzdVJoMVhOWVpYSkJHM1YwNlptSXhRbHJF?=
 =?utf-8?B?cDlnYmxkYnhpSlVRRExiRnVZZG1zZUl0Zk1FK0pZOGF2cm8ydUdKdjdRT05q?=
 =?utf-8?B?aFRjakhxRHdzd3hURHBNS0xiM25vOFVpczlJUU9Cb1FwZTZIcmhmMFh4TTZz?=
 =?utf-8?B?cTYwOTlMYkptMU13bWIybnF5NDE1bGlSa2F2WXRZMUVlYmtrdjMySWQrZzZC?=
 =?utf-8?B?VGNYcVlKSlZ2dFRBR3RpWFZoRVJIMTZ2RVZDVGUxYWZKTTFQSGlCKzkwOWJQ?=
 =?utf-8?B?WlY3SHQ1eFNmNzRGcDZVUlJyQ0pid1I3SW1RbjVXdERMMi8zZ2ptYWdVZjdI?=
 =?utf-8?B?cW9HUjZiYUhJRUREOUpia3RmYlp0T1dTZ2pGd1pXZnR0TzVRd2xvbFdsd0Ft?=
 =?utf-8?B?VWFCSFRuS2pvRFNUSWdtV2t6Qk0xRjllUlZ4U0RYUnpNRE1LVE12VVZFZGhQ?=
 =?utf-8?B?R3JLNzErWVJ4TXE0c0c2NFpKb0M4Q3BpdHo3Yi9tQUNFRnM3ZWZaYmRuKzM0?=
 =?utf-8?B?eW1tcHV3RDdQSTlFS3U2SjZ2Y3pjaS82eVFyU0NUWGlYMjJoMmRrcXRRbXhJ?=
 =?utf-8?B?RFhoM211WllpaVBXVklGOTI4RmZIK1Q2T0J5U0tFWU8xS0taQUh3cVBuN0pY?=
 =?utf-8?B?UUlLV2NnQXdWV3gvcXhIdmRtR3phK0xlaFdETi9Ca2tNWWFXWmZwamFlM2pa?=
 =?utf-8?B?M1J6T1o4NUY4REM3QnNrQVBoU2NGWjdKV1l5by9vWkNFbUxWM0VHS1dBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU1GcXRSRTVNbHFCR3EyT0Q3NkM3WDhWWmVKN2I4UTh5NXBEQU9TR1FQenRD?=
 =?utf-8?B?M0NjODlaYnlZSlhkcDFHU3gvdjJUZWZySWNRVjNRWmZKUWFweVN1ZkhvM2d0?=
 =?utf-8?B?WG1QbFp3Z01zK2NHaTRoazY3RXN5Uy9PNytGMGFmS043aFNDWDYzdFBwMEE3?=
 =?utf-8?B?NHN2LzdtbWk4L0FsUlprTlpXQzVuUnY4dS8yNzYxalhYOWkxTHBpaEtJcTBI?=
 =?utf-8?B?WXlrQmRuRzhVdjIwRmN4WFNudmt0cTJKeHMwRk52YnEzclpmMElJV280azho?=
 =?utf-8?B?emtJT3RHK0JSaklhOFNEeUtXcE9UczB5M0tjSmY2WUloQUVNTVBmY3B2K2VC?=
 =?utf-8?B?UlBUa1NFaUhaamE1N1hGSTNWR3NSYWw3ZW1BOUpzRUtjdGtOWW9ZOVVkUzVK?=
 =?utf-8?B?ZEFGZ0I5NFAyVHloZ09xQkZxZlovWXpqalg5MHRCTzBGVFVCT3d4TkxMR0Vy?=
 =?utf-8?B?RmNwbHRTYnJIL1U3N3dNZTArUU1QU0I3L0VqcWRKRUREU0N5ZG12SjNsejUv?=
 =?utf-8?B?UlhjckxRbGRQTEZ6QnZieFlMSGhHOVBmbjhTWDNZMXJCL3VNVnRIa3BmVzNW?=
 =?utf-8?B?czRnSTdqLzFZWmF4WkpnSkMwRlpBUzJZVlBucElSREJXWVhWVDFEVm5mdmZt?=
 =?utf-8?B?aGpYUURmdWN0Nk1qdkJjVkp0bmwzTkdVNWxOS0FnNUtlT2Q3OEo1UTB5WDhQ?=
 =?utf-8?B?OGpoeFNUVHl6dzd2VEUrR3NNUVhmMDJWTldMbDh3SThjM0o3NTBwS1pTU2c2?=
 =?utf-8?B?bmhJVUlaOWJsclQzUmd5K1JVUDJSQjI2amJKblBDUyswdGxVQVZTK1k2Z1po?=
 =?utf-8?B?c1lWd1RmQnp2MktpMnRteWRwejVWcnJxNWV5WXh5N0pHNlB4SHRzL25QZm1j?=
 =?utf-8?B?TW80Mmd1OGxjMWh6V0pjZWd6QUNzVnBiL2JneFJ6VStDMUZnTzk3UTFRbndx?=
 =?utf-8?B?MXNvK0ZVbkU5dUtFamZMM0JWdm52elBFSFZBMVRYajE5WVlaT2ZDVThESDNR?=
 =?utf-8?B?WlZLY3JEQTZVdThkRXNMdDArWEkzTzYzeUpsWjZ3VkNBMW5CcUJLb3A3ZUlv?=
 =?utf-8?B?UTY1RCs1cDB4WS9BOExhbHp6d3FVckpxR0xvMzU3U2pDUElsOTJyQVZkRGVk?=
 =?utf-8?B?K204NUwvQVdoOGFOZEo5dEFVSE4yMVFxNUE1SlV3YWZJNGdVZTZ6c2FjZHB6?=
 =?utf-8?B?U0o2NkFZbStRT3NCaWV2STIyTUV0YVgvOXV0TzE0MG5UbVNFZTVEbjYvSkMx?=
 =?utf-8?B?UjEzL3AvbjBodGJQMkluYWZrbGp5S0hKUXZhVDYzbnc4cmhJYzNaSmprNkNV?=
 =?utf-8?B?d1J6bDV0RWh6UERhdzFVNllqakczQ21NUXBSUXg3QnQzRFptb0hjSmFzNG9p?=
 =?utf-8?B?Q1h5WmxqY09lRGg0M2cwZ05DcGpJVHZNSHhKZmJDTWUvOStsTlNYdGpKdzNB?=
 =?utf-8?B?cklsdEY3UVA2S0x0T2VWM0gybDdDbVUvWFZOSThaOGE0VE5hNGw1cnVMdVRu?=
 =?utf-8?B?UlR5Wjlya2dybXd2alg5YWJZY3BDNEtIcG4vQm1NUTdnYm9KTHN4M2UwSTZy?=
 =?utf-8?B?NlJkU0JBdHlFZWl2cnlzb3hjekc4RkVpMGRrVEZGalNwMjdqQUd6TFdPSFMy?=
 =?utf-8?B?OTZMcEowcGJreDRRNzNaQVBxbnkzdnJIYjhYZ1ZpS2Q1bXgrcU96TTBZMVMy?=
 =?utf-8?B?OCs3dEhaci9IZGcvVmpXVkpGd3NxQ2ZWeWpmY3F1L2dXdDVRdDlaUXBnbStU?=
 =?utf-8?B?UElYYTVSNnpyQlJqNmZLZm1vLzJsOVR4UlpjQzZWY3hWWHppN3RRMEg1KzRG?=
 =?utf-8?B?ZkVXbnB5MHFOMmp5TjZPbkNkNWNUYkQzc2wyelBlM2dOV0FRblU3RkthTHRP?=
 =?utf-8?B?Mmlhdk5iMGhER3M4MUlvR1RtWXdlSVZwOFBRUVNMclR4NFI3N1gxWk15ek0y?=
 =?utf-8?B?dGUzNXlJYjhWK0l1dzhMeGdFTE1LUVZZZjl6TFRKY3Jsc1VBclp3NjBMbFF6?=
 =?utf-8?B?NzU1OTB4WFR1a3RQV0poM1R4T0o5YTJUUzlrTjJVM2tKbW5Wa3M0aHM1WE9X?=
 =?utf-8?B?MkR0dXZkeVFJTWFiVkM2WnVuTndxZ1hqSklBWkVQZVFtUFRuVFVuaS9TRW9N?=
 =?utf-8?Q?EggQgrt4cr7HZao3Ri/iSyibK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bb9c5b-6f2b-47b6-3fac-08dc83bdd756
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:10:56.7239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+LlKBYu3s67jU7kYzEzSYHai/TDyVOAQEslOJDwcU9DaChVfPSo++sW9mwy2cQ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
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

Am 03.06.24 um 10:53 schrieb Zhou, Bob:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Christian,
>
> It fixes a potential Overflowed constant (INTEGER_OVERFLOW) warning reported by Coverity.

You need to mention that in the commit message.

And I haven't checked the hardware docs, but it can be that this isn't 
the right solution for the warning. Instead you should probably use the 
RREG32_SOC15() macro with a mask which only leaves the valid bits around.

Only when the register is really 32bit wide you need an unsigned 
datatype and if that is the case I suggest to use either uint32_t or u32 
instead.

Regards,
Christian.

>
> Regards,
> Bob
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: 2024年6月3日 15:56
> To: Zhou, Bob <Bob.Zhou@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: replace int with unsigned int for imu_v12_0.c
>
> Am 03.06.24 um 07:59 schrieb Bob Zhou:
>> The return value of RREG32_SOC15 is unsigned int, so modify variable to unsigned.
> And why is that an improvement?
>
> Regards,
> Christian.
>
>> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 6 +++---
>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
>> b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
>> index 0c8ef908d112..2d6f7549c2af 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
>> @@ -119,7 +119,7 @@ static int imu_v12_0_load_microcode(struct
>> amdgpu_device *adev)
>>
>>    static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
>>    {
>> -     int i, imu_reg_val = 0;
>> +     unsigned int i, imu_reg_val = 0;
>>
>>        for (i = 0; i < adev->usec_timeout; i++) {
>>                imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL); @@
>> -138,7 +138,7 @@ static int imu_v12_0_wait_for_reset_status(struct
>> amdgpu_device *adev)
>>
>>    static void imu_v12_0_setup(struct amdgpu_device *adev)
>>    {
>> -     int imu_reg_val;
>> +     unsigned int imu_reg_val;
>>
>>        WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL0, 0xffffff);
>>        WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL1, 0xffff); @@
>> -157,7 +157,7 @@ static void imu_v12_0_setup(struct amdgpu_device
>> *adev)
>>
>>    static int imu_v12_0_start(struct amdgpu_device *adev)
>>    {
>> -     int imu_reg_val;
>> +     unsigned int imu_reg_val;
>>
>>        imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL);
>>        imu_reg_val &= 0xfffffffe;


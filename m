Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B1DD3F29F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 21:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E17E10E139;
	Fri, 18 Oct 2024 21:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYm9FbEe";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36F110E139
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 21:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udwiO8VpXLcmI3xzu+5tjpe5K9AIhmU4O1J2bXltbBn7ukIMio4E2DvrPHzq7jGMIAmNvYiQkCqocBOjww80og6ogHMG9Bl1Jrv62gr2DzTC8rdevZC8fKkmp1xYpQ7u7AlyIrgc0UBkfLn2VCVfgrW6qlUPFFDzjzmXGainAQ031N2Kfc3sRDY/kLGmMr2k1AZKCapI1ATtN7nqewcPYtzOzBiBR5btwAuj8QgpXfPKF/EF+FR9ol7GGL3ZdYjRvfcy0N6WUAu1XYoZPu6sV784pWjwRF2D/z0TzN7kukwFhaAbgq+Bnopsj6qmtIFdUl8EFUwRFQyo4NOm87LgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQe2Z1oK4Lico6G3zMv2PiNya47XnaTk9sMnMLi8urY=;
 b=VzKDr9yduR3tF3PNHk6pE/T2NkzPG5Z8QXgSHBMPqu45LnWAXpIzkuudUwNxdmAEhjRyClzGSq4lsA4ExRnz/LxemO+FCB0nsOLrTZGx54GSefbhclhN7Nm690Q8sXyv+QjrRN8TpXZ+uo/oxbadJUiehM7dceR1iTdpfkN8QfQ+s16eKmOMHJYp699gRC0tK70Yv127T9xR8WrQ8sQ8qnGbJYrPBQD0YMPNXClcoWL2kr0/Mb1cuLLHHuTzMvZKP+2sgsVPguzYZw13mQss+dGU3NhfzSrvqDxn9UopiCaazgFro9PnWo8bnK9XWsMdegF6Isggvdmc8Xk4ZCYNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQe2Z1oK4Lico6G3zMv2PiNya47XnaTk9sMnMLi8urY=;
 b=EYm9FbEeOdd+FAmqGi4bGxO15Zs/WloLRULTfyxYDqGIM1PvVZC3ajE4RvUHBxt7gU0WQfBSu08XCBS2lHwR5TOLiXeEWNqdpymZgykBiqAKZwp2bUf7WZ5naBwi2d4xsAZDLRxbSQBavPTYKy8YxvQlHijGkyBOE/SmFcLQWPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Fri, 18 Oct 2024 21:31:37 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 21:31:37 +0000
Message-ID: <acea0adb-b21b-4e90-848a-2309293b4183@amd.com>
Date: Fri, 18 Oct 2024 16:31:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Add kfd driver function to support hot
 plug/unplug amdgpu devices
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, christian.koenig@amd.com
References: <20241015212139.63500-1-xiaogang.chen@amd.com>
 <003ddddb-9a6b-4e62-9980-da923f7b889f@amd.com>
 <32f7690e-f379-4f28-b747-2d0f59a5156c@amd.com>
 <35f6c795-66a6-4c9c-ba8c-df47242a783e@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <35f6c795-66a6-4c9c-ba8c-df47242a783e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::10) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: e092ded1-a429-4123-2d91-08dcefbc3f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFArQmk2S0ViLzFxU1J2YW96Z1JOZDhWaVY2bWdiVS9udnVMbnBhY2FUTHZB?=
 =?utf-8?B?V2crWVRNK2l0MERaZHVxOC84b3lkMmF5dnc5Qk9nV0VxanNFQWdoT2tNV1Ar?=
 =?utf-8?B?Yjd3T1lndDBqNU1yUTQvUi9PNEVZMU5VeVY3VUVVTFpXa1JYQStTUU5aQzNu?=
 =?utf-8?B?a00wdjhFSHRvM2Zpdld0TkVmbjd4R0UvRTUrU3dsV3R1ODNhSSs0ZWZaRnd2?=
 =?utf-8?B?WEloSkhid3NrNzZXN1BMQVVZbm8ycDRja1NkQ2toZjN5YmdQeWVhek9VSWNW?=
 =?utf-8?B?MXAvVUNMc3ZEQVZOeTFKUFI1UkYwRVZkNXJrZFlqRURhdm9Tc1Rvc0RIT3NU?=
 =?utf-8?B?RWxMZ3gxSXAzcDByeUxvUUs3R2dDMFFzRmYyajRLWWRTSUhXS2F3U3p0dGJu?=
 =?utf-8?B?SE56bEVLRnhCN1pseUFDa0RIT05VeURWU1hxeWNydXZQS1hnK1cxMUZ4YkNZ?=
 =?utf-8?B?ZW9jYWNRRnpsYmYzcGRZdVBsMVJwMUtZVm1aWG8wcGl1NEJiSk8xekhqN0lm?=
 =?utf-8?B?Z2REK0VRd3ZLbjhqZkNTRWJ0dlNqZWVDejJOVnNSNTlsOVFMd0JweWd1R1Zn?=
 =?utf-8?B?RUNBMVZyYlFZVVB4YTlDRkJqVXlIa0pmWERXMzN2RVJPaE1neHM5dGI2QWd2?=
 =?utf-8?B?TitKeWJHVVp3eTFQU05qcVRjdmlzRTRRb1hzb1l2cHRKLzFQVDE2OFFwSWtk?=
 =?utf-8?B?ZmFQSnVtK1A4WkN2ZmFIdndpN05MdkhGN3IvVXVYVWRvZzkwNWRrZk5QbjVp?=
 =?utf-8?B?WHBmMVprWkZ0Vi9uSUU0cElEOHAzeW85T3lnL0hNWitFMGtIWUQxemRPYjN5?=
 =?utf-8?B?OHVIUWRZSDFmM3l1ME5UZ1puQVFQM3JDRGhIUEFPaXhhSGFUeVpSc3JmM3pV?=
 =?utf-8?B?R01iYVV6bFpob3loZGJPbWN5a0IrNlZCc3hnMk04NVJBSXNDYnVFZWRYVWlN?=
 =?utf-8?B?UlBrNThGMEx6MW50ekJwMlBuSnB6S3BPeU13OURZeCtscFdWaG9XTnYvVGVM?=
 =?utf-8?B?ZU9QR1FLOC93RUQ2TUZuQnhhajZGZEtLaEVyeUVwbGJUam5HdjhENHc5ZitK?=
 =?utf-8?B?ajlxTFFZa3Voc2RGbXpXQjhPa2pPSktpK2dCUVJiZ1JxOEg5MVk2T2xacFJw?=
 =?utf-8?B?bkFjTzdaUThUKzNOOFhlOU53Qldxai9oeHpPckVIMGRZeXVGYkZEM0dKVDUz?=
 =?utf-8?B?RDlDejI0YSttVHc4UGIzaG9IV0FyUkY1UTczc1VHREtxSk9mZ1dVMXZBOFlC?=
 =?utf-8?B?bDVSaE1jNnpCSjdIY2lUOGd3U3ZNSE5SR1hPQnJDRXRTNTdiNVRBb01yV25o?=
 =?utf-8?B?T25xdFJjME00MmRmdS9ZSGp4N1hraGZzQnJRTjU5c0h2U2lPdnZZQ05RYlc5?=
 =?utf-8?B?K202Y0o3YTFYYmZ4MmxaanlYQlA1YzJzS1ljcFhLbUpXYjdBU1dpTnZvZFcy?=
 =?utf-8?B?OGNiZnRtdDEyKzVRSUt2TFRUTXF2MTV5OUZvNnNiSDdSV09hQmZ6YWJhNzIz?=
 =?utf-8?B?Ykg5YkNmcUFSNjNDcm5SZVVHV0ErQkhadVhKZHI5SFZnVS9VV3cydXdDY05Z?=
 =?utf-8?B?UEtPK0hRTEVkd3c5RHNvZGF5UVRPdi96eW5YbzlXMnluUHcxa2JiMFc3cWNl?=
 =?utf-8?B?YUxlQmluSzRKbklQbExQckwwUWgrSk5YQkxUQUwvRzUvaXdkdmdUdmZmN0Zu?=
 =?utf-8?B?WXJndTZmQndvajMrMXcxMXhCbUVjQlQ3cTRrdTh4K3JRMEo2am91QXpXQzZ4?=
 =?utf-8?Q?MCaR1fjdGlbTNNKKfvFkYvLcl4boHuX+fV7Hvpz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEw3RkRvV2g5QTJLcy9SUnVhZ3lXNW9Hc2k0b0NyakU5cDFWY2VGYitUWXJW?=
 =?utf-8?B?Vy9EdGx1V0xTQmk0MTE0UlM1bUJqK081QUN5TVBObFR2RnIvWlU3cEMxRFJK?=
 =?utf-8?B?ZHlnZHU1ZjFvakhkeE5TVXF4UUR4RlNVbDB6dWkwWFBIQUQ4bWpYT2hDQURa?=
 =?utf-8?B?WDJLVmxTOWg3TjRqcXlXZHFBb3dCK0FvM3pIdXNvc3dXeXRhdGFOOHBGdHdy?=
 =?utf-8?B?ZUZVYlcraTRrcERkdlJzOExlZDZFN21vMU9JQW1YSXJtMC90OEswc0hIVjdI?=
 =?utf-8?B?aCsvcUF2UHAxaFFmU0wvMmUvVlJhSEpqbmRTQWU2Sjh0WFFEQ2pSQjN6NG1a?=
 =?utf-8?B?QzZOajVWcjY1cDdBd3YzSWdnRG9GMGZzeXRPeFlIbUhrRE94aWF4MkVDYmd6?=
 =?utf-8?B?N1k1aHAxck5TYUp1QXZuWmkrR2ZDTitFVHlFa1lROEtKK1hpU0F4cjVEdjAy?=
 =?utf-8?B?cTJnenNaMVB0QXMrU1E4TWI3aHpreVJHeGZGUElBZmw2bEE1NnoxdUY1eENN?=
 =?utf-8?B?OGs4Zjl3d0xGMXVoS2ROdFkrbmROUWlGalFqMHJxVzFFUlc4aFdWWENZTkdx?=
 =?utf-8?B?NktKZDNhR0pnS205b3RhN25JdnNiUm1YVVFtL09MK2dNNGpoR2ZHM1Y0ejJO?=
 =?utf-8?B?RElJU1hPODhXTkt1bHV5aEZkbzZHMkJRT1d6aGJKRFc1c0orTWlZNVpIdFlP?=
 =?utf-8?B?aWZRQk40RnBSMUltSWU4ZWJnRDhGUEFpbFNUeDZRUlorRDZ5WUhmZW9MRmhk?=
 =?utf-8?B?WVdtdGRWUmV1M2tHOEFrMTFVNGpRN2liOWMyVzdTQjgxbm41K2xOSUZVR2VC?=
 =?utf-8?B?d2t6S0dxWlBoUFZjNTR5cy96bzFJV1U4azFvOEttRmNvWUowMm5aYUlLa0xl?=
 =?utf-8?B?T3VSeGJFblg0MlZHdllUbmptUnQyZUZScHFSdDVlUStTWmJuWW1DTmFRWjhz?=
 =?utf-8?B?d1EzZ1pQZUdiY3pyMjlYM1MzdmorekcxOVhxc1l5MjlkWEdWYVVscmJGREV2?=
 =?utf-8?B?V3AvY3RqZWpzQUpLYm1xR1p6a1hrNllMYVVsZnlRdzlWb3owUVRhMHBqbHJr?=
 =?utf-8?B?OUw2Wk5UTWsxbG10OWtNWlczc0xtVVBvcXJQcFl0bHEyL1dzRmRPeVRZNUtp?=
 =?utf-8?B?QkhzWlhQbVJqdFdVb3RpMFJ6dU42aDc4MWVmOWFYZ2pualllK3BIMzhtMEZC?=
 =?utf-8?B?MjdhNHJObEhjZTQxc2Voc3RiTmtoQUp0eDBTeDcvRnp1ekZNL3g4TGp6dVJZ?=
 =?utf-8?B?RnFTMk9kb2lDcmFJRnhoeHpRQXhSYy96SDVWMk1ZMnBPZ3F6VWp6WXY2OWQ1?=
 =?utf-8?B?bWNqYXBEVkd2N0xuNENKZDZaL1hxM0s2ek5KQzNPSXcxS3RkZWRpY0M5aWxF?=
 =?utf-8?B?M3RlSkxTUEtaZXo5TS9xZDBXYlhZd2lrd2xxTkpWUEFraHFnMHhoYXptNzE1?=
 =?utf-8?B?RUVSU0ZjcC96RlRIRmRUZk1SU3kxMlpEeWJmMlhjaWJBRDRJc25GMU5HNVQ1?=
 =?utf-8?B?dExCMGUxVzBYQlhlVmJCZ2VmMEVlQmhCQ1BmQUxibmpqMVpQWFhpT3pMaVJv?=
 =?utf-8?B?WFFyQWVIZnpkQjdySnkyNlZETmFlc290OG9JeEV6cGVUNjRwN0FpUVY5N2xF?=
 =?utf-8?B?Rit4NDZtNTJlN2ZpcUg4UXZqL0RSTVhUOWFKY2pvRVJYKzU1Rk1yL3VjSGhW?=
 =?utf-8?B?aW1ZRVJtbklqT1hZMTdHKzd0eGI1Ni94N1pkekdiR0lhaVEvK1IrOGdQeWVO?=
 =?utf-8?B?QkdaU0Y4MGlydElJQjQ3eDZnbnphZlVKS2JDeHJPMGFKSU5YNFc1RHRWUzJ2?=
 =?utf-8?B?UUxlV2xwM3E2QjltMnlodThRV0ZBR1VPdjJuZXUvSmlXK0tHQS92WHNzcG5P?=
 =?utf-8?B?akJJQXlDbjkrYjR1NXBUNWN4bDZFQkl1WFhiWjdjWDVIWG1FQVpGbFVjZTdO?=
 =?utf-8?B?ZVUxY1NHQ3hyNFZCbjlKZnZRUVFhaCsyT1VDbDh6V3NTYk1mcHRwR2xpeENm?=
 =?utf-8?B?NEh6bUVLY2l5bkVFd0tGNG5FbHo0TzJIWVp4b3pSN25sektCS1dDb3M2RHhh?=
 =?utf-8?B?SVdabjBXQ04wSHZJRTgranhzeGoxdE9OdnIzUkozMkpTWW94MzF6MHVSSVlW?=
 =?utf-8?Q?r2yc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e092ded1-a429-4123-2d91-08dcefbc3f3d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 21:31:37.5722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YklO3RoHYGTyhT0/LKpvH7RvmsTrlD+t6BM6MffhH8oQ+RU1x1amVCyxVIoIiwEf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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


On 10/18/2024 12:57 PM, Felix Kuehling wrote:
>
> On 2024-10-18 10:09, Chen, Xiaogang wrote:
>>
>> On 10/17/2024 4:04 PM, Felix Kuehling wrote:
>>>
>>> On 2024-10-15 17:21, Xiaogang.Chen wrote:
>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>
>>>> The purpose of this patch is having kfd driver function as expected 
>>>> during AMD
>>>> gpu device plug/unplug.
>>>>
>>>> When an AMD gpu device got unplug kfd driver stops all queues from 
>>>> this device.
>>>> If there are user processes still ref the render node this device 
>>>> is marked as
>>>> invalid. kfd driver will return error to following requests to the 
>>>> device from
>>>> all existing user processes. Existing user processes can still use 
>>>> remaining
>>>> gpu devices during/after unplug event.
>>>>
>>>> After all refs to the device have been closed from user space kfd 
>>>> driver
>>>> topology got updated by removing correspodent kfd nodes.
>>>>
>>>> User space can use remaining gpu devices that are valid at same 
>>>> time. When all
>>>> AMD gpu devices got removed kfd driver will not allow open /dev/kfd 
>>>> request.
>>>>
>>>> Unplugged AMD gpu devices can be re-plugged. kfd driver will use 
>>>> added devices
>>>> and function as usual.
>>>>
>>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +-
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 78 
>>>> +++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 43 ++++++++++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  6 ++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 +++-
>>>>   .../amd/amdkfd/kfd_process_queue_manager.c    | 24 ++++++
>>>>   9 files changed, 183 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> index b545940e512b..651ae0775f80 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> @@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct 
>>>> amdgpu_device *adev,
>>>>           kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>>>>   }
>>>>   +void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd)
>>>> +{
>>>> +       kgd2kfd_teardown_kfd_device(kfd);
>>>> +}
>>>> +
>>>>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>>>>   {
>>>>       if (adev->kfd.dev)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> index 7e0a22072536..bd241f569b79 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -152,6 +152,7 @@ struct amdkfd_process_info {
>>>>     int amdgpu_amdkfd_init(void);
>>>>   void amdgpu_amdkfd_fini(void);
>>>> +void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd);
>>>>     void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
>>>> run_pm);
>>>>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>>> @@ -431,6 +432,7 @@ int kgd2kfd_check_and_lock_kfd(void);
>>>>   void kgd2kfd_unlock_kfd(void);
>>>>   int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
>>>>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
>>>> +void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd);
>>>>   #else
>>>>   static inline int kgd2kfd_init(void)
>>>>   {
>>>> @@ -511,5 +513,10 @@ static inline int kgd2kfd_stop_sched(struct 
>>>> kfd_dev *kfd, uint32_t node_id)
>>>>   {
>>>>       return 0;
>>>>   }
>>>> +
>>>> +void kgd2kfd_teardown_processes(void)
>>>> +{
>>>> +}
>>>> +
>>>>   #endif
>>>>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 1e47655e02c6..4529d7a88b98 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3315,7 +3315,8 @@ static int amdgpu_device_ip_fini_early(struct 
>>>> amdgpu_device *adev)
>>>>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>   -    amdgpu_amdkfd_suspend(adev, false);
>>>> +    if (adev->kfd.dev)
>>>> + amdgpu_amdkfd_teardown_kfd_device(adev->kfd.dev);
>>>>         /* Workaroud for ASICs need to disable SMC first */
>>>>       amdgpu_device_smu_fini_early(adev);
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> index a1f191a5984b..d246f72ae0e9 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> @@ -327,6 +327,13 @@ static int kfd_ioctl_create_queue(struct file 
>>>> *filep, struct kfd_process *p,
>>>>           err = -EINVAL;
>>>>           goto err_pdd;
>>>>       }
>>>> +
>>>> +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        pr_debug("gpu 0x%x is not available\n", args->gpu_id);
>>>> +        err = -EINVAL;
>>>> +        goto err_pdd;
>>>> +    }
>>>> +
>>>
>>> Instead of duplicating this in all the ioctl functions, could this 
>>> check be done in kfd_process_device_data_by_id?
>>
>> Yes, that makes code simpler. Also, need add same check on 
>> kfd_get_process_device_data.
>
> Maybe not. kfd_get_process_device_data gets a kfd_node as parameter, 
> that callers typically get from get from a call to kfd_device_by_id. 
> Maybe the check should be in kfd_get_device_by_id so it doesn't return 
> invalid devices.

kfd_get_process_device_data is used by queue operations. They use "dev = 
pqn->q->device" to locate kfd node from queue structure, not 
kfd_device_by_id. Then locate pdd.

and yes,  at kfd_device_by_id we also need check returned dev->kfd->valid.

dev->kfd->valid means this kfd device cannot be used now(or being 
removed). Its resources(kfd_dev, kfd_node) are not released yet until 
user apps release all refs to the adev.

>
>
>>
>>>
>>>
>>>>       dev = pdd->dev;
>>>>         pdd = kfd_bind_process_to_device(dev, p);
>>>> @@ -578,6 +585,12 @@ static int kfd_ioctl_set_memory_policy(struct 
>>>> file *filep,
>>>>           goto err_pdd;
>>>>       }
>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        pr_debug("gpu 0x%x is not available\n", args->gpu_id);
>>>> +        err = -EINVAL;
>>>> +        goto err_pdd;
>>>> +    }
>>>> +
>>>>       pdd = kfd_bind_process_to_device(pdd->dev, p);
>>>>       if (IS_ERR(pdd)) {
>>>>           err = -ESRCH;
>>>> @@ -621,6 +634,11 @@ static int kfd_ioctl_set_trap_handler(struct 
>>>> file *filep,
>>>>           goto err_pdd;
>>>>       }
>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        err = -EINVAL;
>>>> +        goto err_pdd;
>>>> +    }
>>>> +
>>>>       pdd = kfd_bind_process_to_device(pdd->dev, p);
>>>>       if (IS_ERR(pdd)) {
>>>>           err = -ESRCH;
>>>> @@ -704,6 +722,9 @@ static int 
>>>> kfd_ioctl_get_process_apertures(struct file *filp,
>>>>       for (i = 0; i < p->n_pdds; i++) {
>>>>           struct kfd_process_device *pdd = p->pdds[i];
>>>>   +        if (!is_kfd_process_device_valid(pdd))
>>>> +            continue;
>>>> +
>>>>           pAperture =
>>>> &args->process_apertures[args->num_of_nodes];
>>>>           pAperture->gpu_id = pdd->dev->id;
>>>> @@ -779,6 +800,9 @@ static int 
>>>> kfd_ioctl_get_process_apertures_new(struct file *filp,
>>>>       for (i = 0; i < min(p->n_pdds, args->num_of_nodes); i++) {
>>>>           struct kfd_process_device *pdd = p->pdds[i];
>>>>   +        if (!is_kfd_process_device_valid(pdd))
>>>> +            continue;
>>>> +
>>>>           pa[i].gpu_id = pdd->dev->id;
>>>>           pa[i].lds_base = pdd->lds_base;
>>>>           pa[i].lds_limit = pdd->lds_limit;
>>>> @@ -901,6 +925,11 @@ static int 
>>>> kfd_ioctl_set_scratch_backing_va(struct file *filep,
>>>>           goto bind_process_to_device_fail;
>>>>       }
>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        err = PTR_ERR(pdd);
>>>> +        goto bind_process_to_device_fail;
>>>> +    }
>>>> +
>>>>       pdd->qpd.sh_hidden_private_base = args->va_addr;
>>>>         mutex_unlock(&p->mutex);
>>>> @@ -981,6 +1010,11 @@ static int kfd_ioctl_acquire_vm(struct file 
>>>> *filep, struct kfd_process *p,
>>>>           goto err_pdd;
>>>>       }
>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        ret = -EINVAL;
>>>> +        goto err_pdd;
>>>> +    }
>>>> +
>>>>       if (pdd->drm_file) {
>>>>           ret = pdd->drm_file == drm_file ? 0 : -EBUSY;
>>>>           goto err_drm_file;
>>>> @@ -1031,6 +1065,10 @@ static int 
>>>> kfd_ioctl_get_available_memory(struct file *filep,
>>>>         if (!pdd)
>>>>           return -EINVAL;
>>>> +
>>>> +    if (!is_kfd_process_device_valid(pdd))
>>>> +        return -EINVAL;
>>>> +
>>>>       args->available = 
>>>> amdgpu_amdkfd_get_available_memory(pdd->dev->adev,
>>>>                               pdd->dev->node_id);
>>>>       kfd_unlock_pdd(pdd);
>>>> @@ -1090,6 +1128,11 @@ static int 
>>>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>>           goto err_pdd;
>>>>       }
>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        err = -EINVAL;
>>>> +        goto err_pdd;
>>>> +    }
>>>> +
>>>>       dev = pdd->dev;
>>>>         if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) &&
>>>> @@ -1202,6 +1245,12 @@ static int 
>>>> kfd_ioctl_free_memory_of_gpu(struct file *filep,
>>>>           goto err_pdd;
>>>>       }
>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        pr_err("Process device is not valid\n");
>>>> +        ret = -EINVAL;
>>>> +        goto err_pdd;
>>>> +    }
>>>> +
>>>>       mem = kfd_process_device_translate_handle(
>>>>           pdd, GET_IDR_HANDLE(args->handle));
>>>>       if (!mem) {
>>>> @@ -1266,6 +1315,12 @@ static int 
>>>> kfd_ioctl_map_memory_to_gpu(struct file *filep,
>>>>           err = -EINVAL;
>>>>           goto get_process_device_data_failed;
>>>>       }
>>>> +
>>>> +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        err = -EINVAL;
>>>> +        goto get_process_device_data_failed;
>>>> +    }
>>>> +
>>>>       dev = pdd->dev;
>>>>         pdd = kfd_bind_process_to_device(dev, p);
>>>> @@ -1384,6 +1439,11 @@ static int 
>>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>>           goto bind_process_to_device_failed;
>>>>       }
>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        err = -EINVAL;
>>>> +        goto bind_process_to_device_failed;
>>>> +    }
>>>> +
>>>>       mem = kfd_process_device_translate_handle(pdd,
>>>>                           GET_IDR_HANDLE(args->handle));
>>>>       if (!mem) {
>>>> @@ -1567,6 +1627,11 @@ static int kfd_ioctl_import_dmabuf(struct 
>>>> file *filep,
>>>>           goto err_unlock;
>>>>       }
>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        r = PTR_ERR(pdd);
>>>> +        goto err_unlock;
>>>> +    }
>>>> +
>>>>       r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, 
>>>> args->dmabuf_fd,
>>>>                            args->va_addr, pdd->drm_priv,
>>>>                            (struct kgd_mem **)&mem, &size,
>>>> @@ -1616,6 +1681,11 @@ static int kfd_ioctl_export_dmabuf(struct 
>>>> file *filep,
>>>>           goto err_unlock;
>>>>       }
>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        ret = -EINVAL;
>>>> +        goto err_unlock;
>>>> +    }
>>>> +
>>>>       mem = kfd_process_device_translate_handle(pdd,
>>>>                           GET_IDR_HANDLE(args->handle));
>>>>       if (!mem) {
>>>> @@ -1660,6 +1730,9 @@ static int kfd_ioctl_smi_events(struct file 
>>>> *filep,
>>>>       if (!pdd)
>>>>           return -EINVAL;
>>>>   +    if (!is_kfd_process_device_valid(pdd))
>>>> +        return -EINVAL;
>>>> +
>>>>       return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>>>>   }
>>>>   @@ -2990,6 +3063,11 @@ static int kfd_ioctl_set_debug_trap(struct 
>>>> file *filep, struct kfd_process *p, v
>>>>               r = -ENODEV;
>>>>               goto unlock_out;
>>>>           }
>>>> +
>>>> +        if (!is_kfd_process_device_valid(pdd)) {
>>>> +            r = -ENODEV;
>>>> +            goto unlock_out;
>>>> +        }
>>>>       }
>>>>         switch (args->op) {
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> index fad1c8f2bc83..019567249110 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> @@ -893,6 +893,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>       svm_range_set_max_pages(kfd->adev);
>>>>         kfd->init_complete = true;
>>>> +    kfd->valid = true;
>>>>       dev_info(kfd_device, "added device %x:%x\n", 
>>>> kfd->adev->pdev->vendor,
>>>>            kfd->adev->pdev->device);
>>>>   @@ -919,6 +920,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>     void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>>>   {
>>>> +    struct kfd_process *p;
>>>> +    unsigned int i, j;
>>>> +    unsigned int temp;
>>>> +
>>>>       if (kfd->init_complete) {
>>>>           /* Cleanup KFD nodes */
>>>>           kfd_cleanup_nodes(kfd, kfd->num_nodes);
>>>> @@ -929,6 +934,20 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>>>           amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>>>>       }
>>>>   +    /* now this kfd_dev has been completely removed from kfd driver
>>>> +     * before kfree kfd iterate all existing kfd processes, if kfd 
>>>> process
>>>> +     * uses any kfd node from this kfd set its ref to NULL
>>>> +     */
>>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>> +        for (i = 0; i < kfd->num_nodes; i++)
>>>> +            for (j = 0; j < p->n_pdds; j++) {
>>>> +                if (kfd->nodes[i] == p->pdds[j]->dev) {
>>>> +                    p->pdds[j]->dev = NULL;
>>>
>>> Could this be done in teardown_kfd_device? Then you may not need a 
>>> separate "valid" for is_kfd_process_device_valid. And any accidental 
>>> access to a device associated with an invalid pdd would 
>>> automatically trigger a kernel error message with a backtrace.
>>
>> At teardown_kfd_device the adev has not been removed, ex: there are 
>> user apps still refer the render node. kfd dev(kfd nodes) is released 
>> at kfd_cleanup_nodes of kgd2kfd_device_exit when all ref to adev got 
>> released(user apps close render node). During that time kfd 
>> nodes(pdd->dev) are valid. We still can access kfd nodes data 
>> structure though their queues got stopped and kfd_node->kfd has been 
>> markded as invalid.
>
> I'm not sure why that matters. The fact that the there are still other 
> pointers to the dev doesn't mean the pointer in the pdd must remain 
> valid.
>
Ex: when kfd process is released we call 
kfd_process_dequeue_from_all_devices to terminate all queues(the queues 
have been stopped after unplug the adev), we use pdd->dev to locate kfd 
node for following "Clears all process queues belongs to that device"

At teardown_kfd_device the kfd dev(its kfd nodes) has not been released. 
keeping pdd->dev is convenient when need locate the kfd dev from pdd. 
Otherwise we need use other ways to locate kfd node.

> On the other hand, there should be code in kgd2kfd_teardown_kfd_device 
> or kgd2kfd_device_exit to clean up _all_ the other pointers to the 
> invalid kfd_dev and kfd_nodes. AFAICT the kfd_dev and kfd_nodes are 
> not reference counted, and there is no guarantee that these structures 
> still exist by the time the processes terminate and run their cleanup 
> code. You can't rely on kfd_dev->valid after the kfd_dev itself has 
> been freed with kfree in kgd2kfd_device_exit. By that time all 
> pointers to the kfd_dev and its nodes must have been cleaned up.
>
> A quick survey of the header files shows
>
>  * kfd_dev pointers in kfd_node, kfd_device_queue_manager
>  * kfd_node pointers in kfd_dev, kfd_bo, queue, kernel_queue,
>    kfd_process_device, kfd_*_properties referenced in lists in
>    kfd_topology_device, svm_range_bo, mqd_manager
I had same thought when did it. Here all queues on this kfd dev are 
stopped at first, and all kfd nodes from kfd dev got marked as invalid, 
so not serve any new request on these kfd nodes at api level. Any 
existing operations that use kfd node check if it is valid.
>
>
>>
>>>
>>>
>>>> +                    break;
>>>> +                }
>>>> +            }
>>>> +    }
>>>> +
>>>>       kfree(kfd);
>>>>   }
>>>>   @@ -1485,6 +1504,30 @@ int kgd2kfd_stop_sched(struct kfd_dev 
>>>> *kfd, uint32_t node_id)
>>>>       return node->dqm->ops.halt(node->dqm);
>>>>   }
>>>>   +/* tear down this kfd deve */
>>>> +void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd)
>>>> +{
>>>> +    struct kfd_process *p;
>>>> +    struct kfd_node *dev;
>>>> +    unsigned int i;
>>>> +    unsigned int temp;
>>>> +
>>>> +    kfd->valid = false;
>>>> +    /* stop queues from kfd nodes in this kfd dev */
>>>> +    for (i = 0; i < kfd->num_nodes; i++) {
>>>> +        dev = kfd->nodes[i];
>>>> +        dev->dqm->ops.stop(dev->dqm);
>>>> +    }
>>>
>>> If the GPU was unplugged already, what's the point of this? Won't 
>>> this trigger a timeout?
>>>
>> pci base driver will find that the device has been unplugged, will 
>> not call amdgpu driver's callback for pci device that has been 
>> removed. So that would not happen.
>
> This has nothing to do with PCIe callbacks. dev->dqm->ops.stop tries 
> to talk to the HWS firmware to remove queues. That will hand or time 
> out if the GPU has been unplugged.

Not sure understand that. Inside kgd2kfd_teardown_kfd_device the adev 
has not been released(adev got released from pci system after 
kgd2kfd_teardown_kfd_device return), so can do dev->dqm->ops.stop. If 
user tries unplug same device again pci base driver will not find it, 
then not call amdgpu driver. Misunderstanding?

Thanks

Xiaogang

>
> Regards,
>   Felix
>
>
>>>
>>>> +
>>>> +    /* signal a gpu device is being teared down to user spalce 
>>>> processes by
>>>> +     * KFD_EVENT_TYPE_HW_EXCEPTION event
>>>> +     */
>>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)
>>>> +        kfd_signal_hw_exception_event(p->pasid);
>>>
>>> This sends exceptions to all processes. It should only do this for 
>>> processes that use the unplugged device (i.e. have a pdd that uses 
>>> the device). This excludes processes that don't have the device in 
>>> their cgroup.
>> ok, will iterate all existing kfd processes. If any kfd node from 
>> this kfd dev got used by a kfd process send the event to 
>> correspondent user process.
>>>
>>>
>>>> +
>>>> +    return;
>>>> +}
>>>> +
>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>     /* This function will send a package to HIQ to hang the HWS
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>> index dbcb60eb54b2..b8dd80ee17be 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>> @@ -378,6 +378,12 @@ int kfd_init_apertures(struct kfd_process 
>>>> *process)
>>>>               continue;
>>>>           }
>>>>   +        /* kfd device that this kfd node belogns is not valid */
>>>> +        if (!dev->kfd->valid) {
>>>> +            id++;
>>>> +            continue;
>>>> +        }
>>>> +
>>>>           pdd = kfd_create_process_device_data(dev, process);
>>>>           if (!pdd) {
>>>>               dev_err(dev->adev->dev,
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index 6a5bf88cc232..97e7692ce569 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -371,6 +371,9 @@ struct kfd_dev {
>>>>         /* bitmap for dynamic doorbell allocation from doorbell 
>>>> object */
>>>>       unsigned long *doorbell_bitmap;
>>>> +
>>>> +    /* this kfd_dev valid or not */
>>>> +    bool valid;
>>>>   };
>>>>     enum kfd_mempool {
>>>> @@ -1055,6 +1058,10 @@ int kfd_process_restore_queues(struct 
>>>> kfd_process *p);
>>>>   void kfd_suspend_all_processes(void);
>>>>   int kfd_resume_all_processes(void);
>>>>   +static inline bool is_kfd_process_device_valid(struct 
>>>> kfd_process_device *pdd) {
>>>> +    return (pdd && pdd->dev && pdd->dev->kfd && 
>>>> pdd->dev->kfd->valid);
>>>> +}
>>>> +
>>>>   struct kfd_process_device *kfd_process_device_data_by_id(struct 
>>>> kfd_process *process,
>>>>                                uint32_t gpu_id);
>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index d07acf1b2f93..c06eb9d8008e 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -1157,8 +1157,6 @@ static void kfd_process_wq_release(struct 
>>>> work_struct *work)
>>>>       ef = rcu_access_pointer(p->ef);
>>>>       dma_fence_signal(ef);
>>>>   -    kfd_process_remove_sysfs(p);
>>>> -
>>>>       kfd_process_kunmap_signal_bo(p);
>>>>       kfd_process_free_outstanding_kfd_bos(p);
>>>>       svm_range_list_fini(p);
>>>> @@ -1173,6 +1171,11 @@ static void kfd_process_wq_release(struct 
>>>> work_struct *work)
>>>>         put_task_struct(p->lead_thread);
>>>>   +    /* the last step is removing process entries under /sys
>>>> +     * to indicate the process has been terminated.
>>>> +     */
>>>
>>> This comment doesn't provide any useful information. What would be 
>>> useful is, why this needs to be the last step? Without that, I see 
>>> no good reason for this change.
>> ok, this change is not related to the patch. I thought it is better 
>> to update kfd topology at last step after all kfd process resources 
>> got released. I will remove this change.
>>>
>>>
>>>> +    kfd_process_remove_sysfs(p);
>>>> +
>>>>       kfree(p);
>>>>   }
>>>>   @@ -1536,6 +1539,12 @@ static struct kfd_process 
>>>> *create_process(const struct task_struct *thread)
>>>>       if (err != 0)
>>>>           goto err_init_apertures;
>>>>   +    /* no any kfd_process_device can be created */
>>>> +    if (!process->n_pdds) {
>>>> +        err = -ENODEV;
>>>> +        goto err_init_apertures;
>>>> +    }
>>>> +
>>>>       /* Check XNACK support after PDDs are created in 
>>>> kfd_init_apertures */
>>>>       process->xnack_enabled = kfd_process_xnack_mode(process, false);
>>>>   diff --git 
>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>> index c76db22a1000..eaf4ba65466c 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>> @@ -124,6 +124,11 @@ int pqm_set_gws(struct process_queue_manager 
>>>> *pqm, unsigned int qid,
>>>>           return -EINVAL;
>>>>       }
>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>> +        pr_debug("device 0x%x is not available\n",dev->node_id);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>>       /* Only allow one queue per process can have GWS assigned */
>>>>       if (gws && pdd->qpd.num_gws)
>>>>           return -EBUSY;
>>>> @@ -498,6 +503,11 @@ int pqm_destroy_queue(struct 
>>>> process_queue_manager *pqm, unsigned int qid)
>>>>       if (WARN_ON(!dev))
>>>>           return -ENODEV;
>>>>   +    if (!dev->kfd || !dev->kfd->valid) {
>>>> +        pr_err("Process device is not valid\n");
>>>
>>> Would you expect to see this message during process termination 
>>> after a hot-unplug? Should this really be an error message, or would 
>>> an info or debug message be more appropriate?
>> I will change kfd_get_process_device_data that will include this 
>> check, then this message will be merged at !pdd case.
>>>
>>>
>>>> +        return -1;
>>>
>>> This should be a proper error code. -1 is -EPERM.
>>>
>> Same as above.
>>>
>>>> +    }
>>>> +
>>>>       pdd = kfd_get_process_device_data(dev, pqm->process);
>>>>       if (!pdd) {
>>>>           pr_err("Process device data doesn't exist\n");
>>>> @@ -567,6 +577,10 @@ int pqm_update_queue_properties(struct 
>>>> process_queue_manager *pqm,
>>>>           pdd = kfd_get_process_device_data(q->device, q->process);
>>>>           if (!pdd)
>>>>               return -ENODEV;
>>>> +
>>>> +        if (!is_kfd_process_device_valid(pdd))
>>>> +            return -ENODEV;
>>>> +         vm = drm_priv_to_vm(pdd->drm_priv);
>>>>           err = amdgpu_bo_reserve(vm->root.bo, false);
>>>>           if (err)
>>>> @@ -612,6 +626,11 @@ int pqm_update_mqd(struct 
>>>> process_queue_manager *pqm,
>>>>           return -EFAULT;
>>>>       }
>>>>   +    if (!pqn->q->device->kfd->valid) {
>>>> +        pr_debug("device where queue %d exists is not valid\n", qid);
>>>> +        return -EFAULT;
>>>> +    }
>>>> +
>>>>       /* CUs are masked for debugger requirements so deny user 
>>>> mask  */
>>>>       if (pqn->q->properties.is_dbg_wa && minfo && minfo->cu_mask.ptr)
>>>>           return -EBUSY;
>>>> @@ -679,6 +698,11 @@ int pqm_get_wave_state(struct 
>>>> process_queue_manager *pqm,
>>>>           return -EFAULT;
>>>>       }
>>>>   +    if (!pqn->q->device->kfd->valid) {
>>>> +        pr_debug("device where queue %d exists is not valid\n", qid);
>>>> +        return -EFAULT;
>>>
>>> EFAULT means "bad address". Probably not the right error code here.
>>
>> Will use -EINVAL.
>>
>> Thanks
>>
>> Xiaogang
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> +    }
>>>> +
>>>>       return 
>>>> pqn->q->device->dqm->ops.get_wave_state(pqn->q->device->dqm,
>>>>                                  pqn->q,
>>>>                                  ctl_stack,

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD92AC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 14:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44AB410E343;
	Thu, 23 May 2024 14:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qjKw0go0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E0910E343
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 14:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTkhSuU8/Fd3s/JkBTO3/5+PPkg9z+rMVX+aG1T0NnDZQszY93ewnoTftRRiiWWbT1C8Hv99Hn0Heh3PxYvO8LpTctALUzkNuPzK6SGX86xEdmBq/PGhaCQIq+udFzR9ohjTWExB3Moq0WATLbdtfiYz9qeq3GKhfysaEMwE+Q7h3ECDZzKdzQT2Y4Hw7s6cNxPpUYaZR6uvyLFfQk85Xc4UhXK0fvNNlSvqVlce/zRBa0vog5KDgefDRyqDrJjRhks3I0ZZpeF2cDGu8xgPdATY2EkDntj7B6vRwUnxB9Pl6UE7i8cDj5XBlFjSntFsDMg4JYvBW+CFv5Kl80so4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R17O5+47X9ZP1WxMHZETevhQ9jM3RRIXFKUz2Ft+gSU=;
 b=l+CtHvtUd4lbfwcX6MKa2Id/zrRlJQi58F80XrbRJhu/15WjMk2O9DGi/Ehe6OpiLHiKkUU/wm2etK4yhj3okuIrS5MV0It2mRG2/Ecq+JBbM/qLsRm4Y1RR/8AeB6RaJ6j8fSwbZ1mR/kITkfSWy20K2nT6nhpa8qlz3Tsolk+2tNC4OSryvYCOc5uBdQbQNg9SZp9dwSG/OkaIbv1yn7eth7n88MIAj1nRAdvXGBK3h/ozHEJAIcMnn0V43hbWOnjBgwGFd66xedcCPfBfPYTx22o+dYe/SFL9LBjnDTBqEVNmfXVyB8NJ1j6jcJuOYDDjzqMFV5itDhiUcNxy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R17O5+47X9ZP1WxMHZETevhQ9jM3RRIXFKUz2Ft+gSU=;
 b=qjKw0go0X80iC91uyFiqxYJ9Pb61Hys0K3AAJcGDoYqva0xxr/5gLXRseMpMM7P+HaK5Jw+5fn1UK5IGDbzc2DTtQLlOlnRpQ4ZyViM9wkaOvcwFobPCn6IEQZaUSYMFIFaSRwqLiMhZiPHPOeU0TSgKObkKu0cOObwvAUO+c/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 14:53:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.037; Thu, 23 May 2024
 14:53:12 +0000
Message-ID: <38598dc3-c815-4328-afa5-6eaa9997c755@amd.com>
Date: Thu, 23 May 2024 16:53:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
 <20240522172721.14085-4-Yunxiang.Li@amd.com>
 <5025dc06-8471-4f74-affc-1070fc7e6dca@amd.com>
 <SA1PR12MB8599116F019C2EFFF427C50AEDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB8599116F019C2EFFF427C50AEDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 810a4ee8-d47b-4446-972b-08dc7b3811bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzF2NUl4bm0yS3JDZG1EcmdwajU1OHdKRExnaHF4OFA3bzZva2gxODBRQWtQ?=
 =?utf-8?B?L3VydUdqODNKNVZBUmEwZEFVNy9adkd4R1NwVzgrTmt5eldidUNmRzRNTDFs?=
 =?utf-8?B?Z3J1cjhZcWVRMTJJMTFUamJFSHVVeTMvMnNzbkU2ZCt3V0NZU3FMYXhVd1lx?=
 =?utf-8?B?Y3pVUEVwODVSMDF2UXB6cjRKbmY1Snl6VWxseEl4VTRqTVQzNHhRdzNYSEZx?=
 =?utf-8?B?N3FYVVZOYytzeDJGdC9UVVR4aGYyNW1TS1I4Ui83MnFJV2FLdm5lMkM2cUh0?=
 =?utf-8?B?S0R6cnMrQmpoRFA3U2p0QnZqamhxQUFuc210WTdqbVBKYXMzVGE2N1N3am1J?=
 =?utf-8?B?Nk9KUVlSYm5FNkxUT0pkV2VXcVZYUno1YVNUbXlCdTMraDFTT3RwOUVwNXVX?=
 =?utf-8?B?YVo5Y1QvdGFlZzdjTlBmbGNyMDJucDFEU1hURnVoMW9qMlJBZUhTWVNSSG4z?=
 =?utf-8?B?QUdLdVFqTkdueE5RSURaQ2UyelhZQ0czNzhtRXdySmhmWlhRUVg5QXVCbzFa?=
 =?utf-8?B?Uk1hd0p4WGdEMnVKMDJlaml4VStXRGZoWm1FcHpObXFUenRjSGwwSW5mbHdF?=
 =?utf-8?B?Q0w0b24ybmltVTVSWDNYNlkveU90OGg0bU41T3g1eVFienRqbC9sUjZxRDRz?=
 =?utf-8?B?VWx3aTdjbUJ0TGE5aE9Bekx5TDh0aGFvQkZzK1NsbndKYXhVNThIUnF1QWt2?=
 =?utf-8?B?Q05BV1dDZWJZdXhpK3dFRUM0YXUvOHh3TEgwQm9oSFhwWkN0MW41RTFybEJl?=
 =?utf-8?B?YzdCRVZ6c2xDOUVsdnRzTHZnbjlRS2VKWVowdXN5TUdnTkN4b0tUeWhzYnRJ?=
 =?utf-8?B?TUVxNTFRS0k2Z0lyOEV3MmE2NmZvK2NtcitwZW5qTEozZmlPaTk0QUZCdExH?=
 =?utf-8?B?cXM4c2JHS3ljRDlmYm9wU1lUT0xIL3hEWk9FbnpIUnZNaHdIcTM4ZmJSZVpZ?=
 =?utf-8?B?UjlwVklhQkVyc2U1VTljMkFHT3JYVmY4MHBXMWYzSUlReVZyZ1VVZFZPN1ZH?=
 =?utf-8?B?TnFwRTU1V2tNL2NpandXMnlzMGMvdDZPK1J3aGRTUStpNjU1QVBXUXdTd1ho?=
 =?utf-8?B?Z1VOUjNjek1kWkUveDQzWU5mbUc2WnRMYWVHWDdVNDgxdzlJYlRaUG9XZ25P?=
 =?utf-8?B?UjNqZHYwWUdqSkVwSkk2OWRHMHVsUkJHUHRNOFg2SWs0QnRpSTkybGRzd0tt?=
 =?utf-8?B?c2tPdXdYQUN3R3hwcmNUNWFGSWpVL3pHODA1NW81dDd6Y3k5Q3pyb1UwMXhJ?=
 =?utf-8?B?MVlhWG1jVnVJSkVvdFRaZ1o5NzRkV2dTNmdwUkovSVhNTFZZNHlkc1hpS1c4?=
 =?utf-8?B?dGp0RkRVamV1R1M1M0tVVnBOZXVleTRWVnFHcmYyWVNucjBVL1VSQzY3OE5p?=
 =?utf-8?B?Mno1UDZCMjBFWUZ1Z0V1dzNsNnl1L1BvcEI1d2F6RWJFRzlDWGhjQ1VMOW9l?=
 =?utf-8?B?eG00Zi9tdytvdndWd2tEckZPUWVTQ1ZJVTNqL3RaQ0xiMlhIQU4wckM2Y2JP?=
 =?utf-8?B?RkVVSVl5Q3NXd2orWmdRLzlibnhXNTZINTU3QXIwSms2UFZ0VkJxbVZnUlNN?=
 =?utf-8?B?TFJsNDVNSmRKM3NJMUJaRXJIdXYvTjV6dTJEUzZxYUJITERxRzIydHZGUkhs?=
 =?utf-8?B?REk0VUFXS1BUUlh5bG9pZzFTZDdHd0l6MlNubEZRUlhKWWwrc0pNdU9WbHlP?=
 =?utf-8?B?WEVPWUZySUpqcDBGUjQwdVpQRExXWGZ5TUZhd2R3WGo4VGZlVS9yWTdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZlVnVBMEJSMENXMlFiUElDeXRHSEJ4dUx3ZmNGV25mNm1jZlhCTUJMTUY4?=
 =?utf-8?B?K2FoaGtNNHQ5dEZmY0pyR1UwU3M3TzhXdWViaTBqeS9vZXZzS1lOMWlJaUN1?=
 =?utf-8?B?ZExOenh6cjhadnRTeUlwbFNKYVdZYUE3NVVWY282b21rL0NsV3VEQ1BKYXRH?=
 =?utf-8?B?cy9mYUVHZS9qZHpWS3JYQlFRQzQwUDBad1djcEcrYWdWY0crUVRZWEFicWJU?=
 =?utf-8?B?RTZ6SkNIazJXcXdnZmIyZ3NXY0lraEFSYVV0ZFFab2RGQW5WdklYSWN1Q2ZQ?=
 =?utf-8?B?RmhJZ09WRVVrWHY0d3ZucHZFQ1ZKMHVrbmFFUEkvdHdmSGFGcElYNjFXUGs2?=
 =?utf-8?B?Y2lWb2VIQjBTUWI5TEtCRnZwTmp3Y1Q2MlJ3UUgvNXZ2TzR2a2VtRVJXREsy?=
 =?utf-8?B?NzZFc3ZZOXlTR2ZuT1hZTVE4SE9XcW5PVHN4MXM1c1BUMHp1T093cHdlakJo?=
 =?utf-8?B?T293RTJMV3EzVitWNUZCYVlQSkltT1lNcHIvZ3VMd1ozL3o3YjdtSlJYNnlk?=
 =?utf-8?B?eUlJOFRCMXVyWTlodVlrd0ZtQnZoWGZJSlRlY0lhcFRnT3Rma1lhb2NZNGhN?=
 =?utf-8?B?byt5R3hncGFyWUZOUjVhbTVuTHpOVll0aExTRFV3ZWh5amlyZnVhMUZhTFVT?=
 =?utf-8?B?ejI1SklRWGM4c3hGdzVBa0MzKzhFejZxMklsSXpidmFjcGMxZkNKeFp0QmtS?=
 =?utf-8?B?NERpTnhKY25YTVJNek5hOVQwZmdVbFpRM0I4NEVObnpBYUxtN1BKbHczSlMw?=
 =?utf-8?B?b21RRnZnMytkb2FYQWV2VktpczNZVFE2WmwyRmJ1djFVNWQySUFUM3cyL3R0?=
 =?utf-8?B?aE1Kd0Mvam04cmNvWlA4LzNta1ZzRGw1MWpTd2ZucFNONXEzQ2VhNVUrV096?=
 =?utf-8?B?bklJUGdzaHpYbWN1cEFzUW9pbmZadFlyb3poOG55bGt2THllNitUYWlYb3FW?=
 =?utf-8?B?WXVxTHA3ZENGMTliRjdqcExoZFJyQXNHcDlUUUVGUERSenRrNzZGdDlZeEt6?=
 =?utf-8?B?Tml6dE9WYjBLY2tibEYwUDRZYlRMQW1BdGpGdzJvcWtwVHZyNzFhMXk1bkRr?=
 =?utf-8?B?MGNHMTVSd2c5VDNFWENnYmprS1lvMkRCQldNU0V2QlQyQi8wbTZCTUtVRXRS?=
 =?utf-8?B?QzY5bnVxeGc3VUIrczMrV3EyUW9vVnBmN0pNKzhkaTBCRHBPdFVlRlpWZFBq?=
 =?utf-8?B?QXMrZk4reWI3dzVkWThzbmhnMUFnV0tLdmpFekVlN1YzajZ0dytzVU1nQmtW?=
 =?utf-8?B?ZWZLd25Kb3dvVFNXVU9sTDRaUmZwdFJhRnVpSlpYU1pWZzN6UW81dFBna09w?=
 =?utf-8?B?Z3o2b0Vrd3MvNnNkS0prR3FaaStBTFFKWnZjYmxnY1hYMWNyckZGcWFORmR4?=
 =?utf-8?B?QWpkVzFUOVZuQ1RFaUlCWWZPOGVSdUl4UFdhdTZYOGh3RzZOVXl6V2xSOWtQ?=
 =?utf-8?B?bndWNVBsaXZ4WGdYSERkZ1ZBbmtFSE1uVnNydU5PUE5kZ2lqT3lJZFRQcVJk?=
 =?utf-8?B?QkcrdlBKS2VRb0lmbGxoRnk5Zmt0eFdZcEQ2NDFrOWhna0gzY08xUDhXNW5M?=
 =?utf-8?B?U2UyTGZSUGtTNGlDOTg2M2d0SE16QmkrckZxM3JqSlpXRHhkcXZBTys4SVF5?=
 =?utf-8?B?VGlLamx6TGRsUjkwK05JTDR0V3EyK3YybHprWGk0cEFWdEhNd2xNbldoL0k3?=
 =?utf-8?B?U2Era3VaZWpaU0gwNFI3Q0RKQTg4QlJKc2x2dCtPRUdSV0xDcTVHeFNBbEFO?=
 =?utf-8?B?VnJGVm81bmkxbVFSSTBhV1Q0SGFiUXBDUG83clZJU29vMlpuQmluSUh1emgx?=
 =?utf-8?B?aXVmNllseTVtdDA2SkViYldUOXRENkFtOTZoZFNuR3J1cDF4Ni9UUXZueHJo?=
 =?utf-8?B?SmVMK2ltS3BqMThOZ0hId3Q1UU1CSlBIVTA4dzdQanlWa3orazUxcFJFdEVn?=
 =?utf-8?B?bVR0aGVSVXd2RTlwdU03WjVUNXcvVnpQUEdGS2Zya0Vla0JIZnp6K0R6bm43?=
 =?utf-8?B?bFhZeGZ5dFNDY2FHRHpOSlA4Z2FRMEp3NWlKZms2MmpkeEtFU0MyeTdPT2Fr?=
 =?utf-8?B?REc5ekd2OW5PWXBVQm1JcVp0TUhRL214WTJXSU1HeVZjTDlRY0tIL0tTbUpY?=
 =?utf-8?Q?7pbw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810a4ee8-d47b-4446-972b-08dc7b3811bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:53:12.7066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiA4KGCw95Mc6qf0vckkBQxakKeggZIrZKAyMA4qZg4n4eb0LCupmC1/OaX30BrH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
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

Am 23.05.24 um 13:36 schrieb Li, Yunxiang (Teddy):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>>> +void amdgpu_lock_hw_access(struct amdgpu_device *adev); void
>>> +amdgpu_unlock_hw_access(struct amdgpu_device *adev); int
>>> +amdgpu_begin_hw_access(struct amdgpu_device *adev); void
>>> +amdgpu_end_hw_access(struct amdgpu_device *adev);
>> Don't add anything to amdgpu.h. We are slowly decomposing that file.
> Where would be a better place? I just wanted to have them next to amdgpu_in_reset

amdgpu_reset.h if you have time feel free to move amdgpu_in_reset() over 
there as well.

>
>>> @@ -5816,6 +5816,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>              goto skip_hw_reset;
>>>      }
>>>
>>> +   amdgpu_lock_hw_access(adev);
>> That should already be locked here. So this will most likely deadlock.
>>
>>>    retry:    /* Rest of adevs pre asic reset from XGMI hive. */
>>>      list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>>              r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context); @@
>>> -5852,6 +5853,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>               */
>>>              amdgpu_device_stop_pending_resets(tmp_adev);
>>>      }
>>> +   amdgpu_unlock_hw_access(adev);
>>>
>>>    skip_hw_reset:
>> Don't add helpers for that, especially not with that name.
>>
>> We don't block HW access, but just prevent concurrent resets.
> Here is taking a different lock than the reset_domain->sem. It is a seperate reset_domain->gpu_sem that is only locked when we will actuall do reset, it is not taken in the skip_hw_reset path.

Exactly that is what you should *not* do. Please don't add any new lock 
to the code. This is already complicated enough.

If you think that adding wrappers for reset lock makes sense then we can 
probably do that, bot don't add any lock for hw access.


>
>>>      uint32_t seq;
>>>
>>> -   if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
>>> -       !down_read_trylock(&adev->reset_domain->sem)) {
>>> +   /*
>>> +   * A GPU reset should flush all TLBs anyway, so no need to do
>>> +   * this while one is ongoing.
>>> +   */
>>> +   if (!amdgpu_begin_hw_access(adev))
>>> +           return 0;
>>>
>>> +   if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
>>> +       amdgpu_in_reset(adev)) {
>> That check doesn't makes sense now any more.
> same here, the two checks are for different scope, although I wasn't sure if the original check is correct or not, is there a possibility that !adev->gmc.flush_pasid_uses_kiq and !ring->sched.ready are false but amdgpu_in_reset(adev) is true? and to we want to take this branch when that happens?

amdgpu_in_reset() in used incorrect in quite a lot of places. It should 
only be used inside the HW backend code to distinct between initial load 
and reset.

All other use cases especially the ones in the IOCTL front end functions 
as well as here in the midlayer which isn't used by GPU reset are incorrect.

>
>>> @@ -684,12 +684,18 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>>>      struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
>>>      struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
>>>      unsigned int ndw;
>>> -   signed long r;
>>> +   signed long r = 0;
>> Please don't initialize local variables if it isn't necessary.
>>
>>>              if (adev->gmc.flush_tlb_needs_extra_type_2)
>>>                      adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>>>                                                               2, all_hub,
>>> @@ -703,46 +709,42 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>>>              adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>>>                                                       flush_type, all_hub,
>>>                                                       inst);
>>> -           return 0;
>>> -   }
>>> +   } else {
>> That the locking is missing here should be a separate bug fix independent of other changes.
> I will split this off into a seperate patch, initializing r is needed because I consolidated the return paths to drop the read lock.

In that case better set r when it's not initialized in some path.

Regards,
Christian.


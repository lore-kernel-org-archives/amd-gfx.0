Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DA0D3F2BF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 22:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7482510E9D6;
	Fri, 18 Oct 2024 22:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PGoJ91jI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7221710E9D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 22:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uudDSNa4l/H+wV0/bLhWKgr0/WgEYr19rO/0WsTH3+AbEkb2dYQ90O4/NIXd0HWY6tdwpM/b04ss57/DbyHTWTc941RmaVfa+L59NEKMHekYLga7W4TRf86x+ALbzMW690o+Urmc2kP5PrWGa4niSXQTC4KlV83Z8QHrCcLqOwk/SyYzgKO01oeooyXEAJ7ktzEU2om5stU5C5f42/yo2gbcTmAo7fSl54a0AAg/4vDWdHDL9TCtuMALETwAzjPrTn8Hj5bRkMLdzohi4VkWVwTfevq5GgjppFt21DMEb9VyUkl7U8AVSBud6BygtWGR6soENKy+vRDcTFOccV6hqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpLFvTf5ztLNSZy6L9+gmsr5P7V2hFuwbGdendXJEY0=;
 b=cW8RW2JfmA1s0K9WSwtEVYUZB0FMHdMpE73sNYDahdPKQDkHhtg3KPmDJv37QE4x+deVhFVoRF08Lu25tgVzPFaol74Qba6Wf1Vp+TVxJgdhZ2gg0UiCIVpMP8Be6lmAO+QpEFX/8MpQtiMT1PhHOiaGt0ochNAIdms1qMnpfARPUdCTm4e6qcxmigFtj4/LJYWNKCYhkUUV6cCPtTJV9XEQ7mlOmf8GqNrRP18ApcAxZG+ox8hoeXto2ym1dYOSVrV6MBhp/0UCYpfo0cM0XDLr/vajQY9lc4L2db3UEqEdK9bDDL4WYWTmRVAQrONJhFy5SFQOCeiX5AtMOHc+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpLFvTf5ztLNSZy6L9+gmsr5P7V2hFuwbGdendXJEY0=;
 b=PGoJ91jI5RYrRmBzXo99JEM7xocuHl56U9dZeeDn8Z/gGbIFQACRT11Yt5gYO1/K2sZggBwefRN/yUDKk7iv33V74f+PWMxYh51DkweQsQxs6abH+UjcFjv8Y1+DCMLs20D1FBnpfXT/OmQyw5u8YrCoIDl68nzY73APQtfCN0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.24; Fri, 18 Oct 2024 22:26:37 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 22:26:36 +0000
Message-ID: <68bd4e41-7353-4cf9-a407-0297d50417e7@amd.com>
Date: Fri, 18 Oct 2024 17:26:34 -0500
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
 <acea0adb-b21b-4e90-848a-2309293b4183@amd.com>
 <024ee138-cd9f-4c67-adb7-f2b2a44e6a00@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <024ee138-cd9f-4c67-adb7-f2b2a44e6a00@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0230.namprd04.prod.outlook.com
 (2603:10b6:806:127::25) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 454d1058-82f5-4a6a-f77e-08dcefc3edd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blJONmh4Qk9hNTlWSlVWUXlCU3lSdHhnMkxwMnIrMld1VVRvUWRqVU5DZUFo?=
 =?utf-8?B?YnVFM3pPVmxpOGNabis0dEE1SllSUHRRTmJEdEpBQWV1eHlMb0dEWXpKNHNz?=
 =?utf-8?B?Mnc1WFFCRHlrM21iMEV2SWFCVEtTZTFXQWpEYmtPdGNnNmJBYTh2WG1aY0lo?=
 =?utf-8?B?bThWU3laY0pXTWE3eS9MM29yeks0YWlPNWk5V0dBMlhvTnhLUzZRUjViTnAr?=
 =?utf-8?B?NU1JYXpOUjAzdnNKSU53dVg5Z2g0VjZoNTFRRzRJQ1ZiT3kxVWQwTWdaRHF6?=
 =?utf-8?B?NlZ4aC9QK2xCWHEvU0J4WXIydTVBSXdEc3cwclV1SmlKWndOanhsTkVEV09O?=
 =?utf-8?B?MkQ1bzRLWXNTbW1mbWNZdkd4cjBCano5c0JjYzhVRnVrbFR2S3VMR3VyUk84?=
 =?utf-8?B?TmVuUHZ2Y2N4cGw0MDNSb1gwNFVWSnZnMlhxaVVzbE1FQVVISUNBajZqUktH?=
 =?utf-8?B?dUJSdDEraEw4aUgwb1YrUDhxRHM0M2tMQ3pCRHY3UW05THlXeURHM1o2eGx5?=
 =?utf-8?B?UC9UWVpLeFVMdHoyczAzK2lOOGxQR3Q0S2ZMTWdkTjlGeUpyRzQ1c0g2YXZm?=
 =?utf-8?B?dVVXZ2FxVnpITklUdW5DeGxwY2pQOGd6a2VJTEpLb0V3M09OL3NmNHN1YitQ?=
 =?utf-8?B?NSt0bXI4SkpTdnNEazhrY2pzNFlWWFRQS2VUb0s0MGhlYW9DQzNoeEp0bGwr?=
 =?utf-8?B?MWVNSno2UEhDYnpyd2QzeGVOYUg0OURqTlFndC9jK3FJQ1J1bFk2dndrUldG?=
 =?utf-8?B?L2hvM0JzbTdZZDFmbW54cWhWVlJqZHZyczM4bTdsbHNOKzZPb3p3b3NaNlNu?=
 =?utf-8?B?WXdpeGxMNEU5dk1OTjVPTUpBc3hneTFpWjZkeHpJVWZ4K2hMeG95bzdIbnlv?=
 =?utf-8?B?bUR5YjNVV0lxbUV6Q3J4dWNHQnNyaG9Kdis2RW5MRmRabHlFMHliVU91eEk1?=
 =?utf-8?B?R0w2ODJRN1IvZjN3S0QwZ1dlNFFSZEc2cTdvS3RaT0FpUHVoV2FMdWNxNEp5?=
 =?utf-8?B?enc2WHJpME9GaldmRXhXVWtESnR3emJxSUs2Wlc1WnhabWQ2MGFTUTcvS0ZK?=
 =?utf-8?B?OGEwdGdJdGRmMmQ1ajNvSzFBSXdSaEdiNkJFRmg5ZXBSUWJiR3JEY1Nxd0FY?=
 =?utf-8?B?aUF6L05Rd1cxWDQ1OENLd2dQSUsvSmxhOE4xQ2cyMms0ajkxd25CZ3Y5c2RF?=
 =?utf-8?B?S2YrUDAwWkdVNy9VWVNPc3dIMUI2aFp1SXV0TGMrQ2p4SldmVTNLWloxYnNK?=
 =?utf-8?B?aGs0TU1qRUFnQmJiVWJkMXlPeXhMSE4ycVozeUNieERLdjhXeS9aV1VMRktB?=
 =?utf-8?B?bXBjRXRKQTRhdzJadm5uWDdTL3MvZlA5eHBDb2ZLT2djeWNGaXBRU0dCMnFi?=
 =?utf-8?B?RmpPSDZWT1cwZXhKTmJLTTUvTXdXYmlEV2JGU2VKMVlUcmdOUllzd2lpaFRh?=
 =?utf-8?B?TXFwWXErOFRYL25iVEd5WXdwOHNKbDN5ajFtRFhDeUJHOU0zMVBKWEMyY3N0?=
 =?utf-8?B?Q0ZjQ3pNNkRDQkExZjdLQlRUalZHdXQ0WEtEV1F1UjRhOUU3Mmk4VUQ0eVho?=
 =?utf-8?B?OXBKeVVNaXVlSm1KOWd6em9Tc3o1aGtQbmp2MFNxdlhUQ0d2WWp0ckxET1RJ?=
 =?utf-8?B?Mk1ybkRkZmdFWmQ2dlpzWTBuRGR6MjluZXV0WTJ6eUV6Q0dBUk5oMXhQQUgw?=
 =?utf-8?B?a2JoWEd3aXJQUXlnTUpFWm9SK29UZndqQmwyaGc0L2NIVUVKQ0prUmxEUWxn?=
 =?utf-8?Q?S8zODQDSJVAnYDakJCRO5faYWUHeaR5CHE2Cuau?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnhEOXZNTy9Lay82Q0Y1RTZvNVVtYlg1UDkySi9UeXdmQlNGMWdkK1JrM0gx?=
 =?utf-8?B?ckFsbS9WbGlzTVgxbXEyMkhPblUvaE00aHArbkpGNGxzQlM5czVDR0tQSUxL?=
 =?utf-8?B?cllXdFFuRFNTd2FMNWt4UkNLZksyRHRPR05IbXJCRFFOL1RHd0Zxb3BSZEgx?=
 =?utf-8?B?RVhoTzJpVmRpMjdhcE1GWXJnOXFPVXgxL0R2U2xDSGEvVU9xekhSSExQU1BB?=
 =?utf-8?B?c29tdC9RbWROK3Z0ekZkZ2puY0l6cllMVFpzemVOMGV6WHlIc1F3MjY1N3A0?=
 =?utf-8?B?ZDlGN3lTYTJHcVA0Ny9SOVZNTCs4TWc5a3RRYnRNTHV4YTdyT1VvcFZONkNC?=
 =?utf-8?B?QThKK0t1ZGJxRWdvNHdiVDJBWWVJcWMxRXpPSVZQbEx0Ukw0emZEN1dXZlpi?=
 =?utf-8?B?SGdzaUZTczdBdlgwSTljSnZ4cE5FbmJaMUYwWXNtbTZKd2l0eVBhdUovTktW?=
 =?utf-8?B?NjFLTFlXYkRaTTRXK0JCNDRkTnJWNTBkZmwrWFFwTFNEazhnUnJGc0VvZTVJ?=
 =?utf-8?B?TkNDMUU0T2NPSjluOVVzczFPZnhNZ1UyL3ZRdkVRVUF2d21qZE4xTnpWcGZr?=
 =?utf-8?B?cG1FWDhNSkZ2M2E5MnpVZjA2Y214RTRqQ0NWSXhRY28zN2QxR2pZdC85enBL?=
 =?utf-8?B?YUc2SFdjTEY0YnBvYkdvS2lrMURFUXVUdnI2OStKSksyMTJoY2NIbG84MUx3?=
 =?utf-8?B?NzZjRW9ySE5vbmdMK0FMUkVJZlROQnhQL241cW10WXErVFR2S0hZcXJOQUs5?=
 =?utf-8?B?dDlnRUthdTU0UHZPOHN0c0k5VWtWd01nMDVhdEhUS3h2M3llUnhEbFY3WTRx?=
 =?utf-8?B?cUgvUW04SHZNeVFIdkxZWk56a1JKREszbEd3cE1IdjUrbXhrVlVoUWVlcEYz?=
 =?utf-8?B?K0o4VWJPVyt1Qm10ZE9RZnpjdlNva2paS2RtNVhpa213YmFLWnBsL1hIRGVP?=
 =?utf-8?B?YVNiMDRHNU42eHc4YW1UdVh2V1JRZ1JsUi91UVNKY2hjeUduNHV5T3YrR3Z5?=
 =?utf-8?B?SURnRmM3TkdxUmxrekF6ZjZFRWx5cTdRb1d3MDRKMTNtaVBOVUZOSzIrbE1V?=
 =?utf-8?B?eE5qcmV5VnVncEl2ejI4WW9vRlZYaklWbEJnczFucURRZUFFbTFCRnVheHpJ?=
 =?utf-8?B?aEZkWXMyWnpmam9MQzAzalJxY3lnR3hGb2RZUmJwWmZ6THVQdWxFalhqanFh?=
 =?utf-8?B?SDFSNEo0bkl3UXk1ZDdwTm83dGViWFpSZS9UT0NBZ3FqRE1XcG05eGNxODNU?=
 =?utf-8?B?cVAxK2x5QURMRnNnUXJpQlJRbEI2cTZqaU9meUhlTGxVUDlJZWZqbDJvQ3VZ?=
 =?utf-8?B?RVEyWnVFbXQ2L0o5Nm9PZXhPV1BJeUNQN2ZWNjU1OE92R1ZCa2pPVGYzN3hq?=
 =?utf-8?B?NUlaYTZOcW9DZ0RlbE1POHhCNTdZbEtVK01yT0Q4allCd2RnaHQvY25FbXRP?=
 =?utf-8?B?U0ZVWEJVT25HQlBuakRidTNvM0hiUTFCUmg5ZTJoaGx4bEFveXpURlN0bVFI?=
 =?utf-8?B?aTN1YjRWWmF4bWRLRWRwcHJab2J3b0RRejd5OEgzY2YvWW9oUjZrc3JXakhK?=
 =?utf-8?B?MFlHRk8vbk5lZXVEaEo0dTJtVExCZkt2K0k2T2g5eGc4MElCbUI5Y09UOGpK?=
 =?utf-8?B?VDdWSjl3c3dCVDNtVFJpKzcyVzhMSDdWUWVsMUl6M2t3VVdTblBxdUcyQnVt?=
 =?utf-8?B?emFPM2E5Y3JKeWh5WjN6N2hJbElOZUNSUHBGV3BXZ2tvY1hxNFh0b2d0NGNR?=
 =?utf-8?B?Zm1NMzBtcXBiS2tiVTlsT0laYUlNSXBQV3NqNWh1eWYxSDRXYk93TzU1djBi?=
 =?utf-8?B?azl1NnlXUm0ydkdxSEVWS0pSL2xHdzE1eVcyeUZTeXM0cnMrYzNoQkZscGhD?=
 =?utf-8?B?OHZ6dnR5dlJhSFFTZUYzdnlQbmJoYkpWNVZKSWo0amdzRWMvcmlIK2MvbGRG?=
 =?utf-8?B?N1pCUDhzaTV1c2h0a2RUeG5NMXRFSm15bGRlMkQxZGpMY0VZQXlQZTVYV09I?=
 =?utf-8?B?NnpzSld2M2lqNVM4Mnl6U0dsb3NBUUs2UzNJOHl1ZitVeU1pR2hOSFozcVNY?=
 =?utf-8?B?aUlsT2VIYTZtSkdCT1J4NHk2d1RBaDhRVXNzeEVKYWNacEhnOUZhT1lCWnJ4?=
 =?utf-8?Q?DG2c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454d1058-82f5-4a6a-f77e-08dcefc3edd2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:26:36.9154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9iear7UfzAgf1CPLCctjLMuw/Dm5jmLKu3fpR3EG94xJ/R24J3BWl+94x4rB530
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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


On 10/18/2024 5:07 PM, Felix Kuehling wrote:
>
> On 2024-10-18 17:31, Chen, Xiaogang wrote:
>>
>> On 10/18/2024 12:57 PM, Felix Kuehling wrote:
>>>
>>> On 2024-10-18 10:09, Chen, Xiaogang wrote:
>>>>
>>>> On 10/17/2024 4:04 PM, Felix Kuehling wrote:
>>>>>
>>>>> On 2024-10-15 17:21, Xiaogang.Chen wrote:
>>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>>
>>>>>> The purpose of this patch is having kfd driver function as 
>>>>>> expected during AMD
>>>>>> gpu device plug/unplug.
>>>>>>
>>>>>> When an AMD gpu device got unplug kfd driver stops all queues 
>>>>>> from this device.
>>>>>> If there are user processes still ref the render node this device 
>>>>>> is marked as
>>>>>> invalid. kfd driver will return error to following requests to 
>>>>>> the device from
>>>>>> all existing user processes. Existing user processes can still 
>>>>>> use remaining
>>>>>> gpu devices during/after unplug event.
>>>>>>
>>>>>> After all refs to the device have been closed from user space kfd 
>>>>>> driver
>>>>>> topology got updated by removing correspodent kfd nodes.
>>>>>>
>>>>>> User space can use remaining gpu devices that are valid at same 
>>>>>> time. When all
>>>>>> AMD gpu devices got removed kfd driver will not allow open 
>>>>>> /dev/kfd request.
>>>>>>
>>>>>> Unplugged AMD gpu devices can be re-plugged. kfd driver will use 
>>>>>> added devices
>>>>>> and function as usual.
>>>>>>
>>>>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 ++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 ++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +-
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 78 
>>>>>> +++++++++++++++++++
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 43 ++++++++++
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  6 ++
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 +++-
>>>>>>   .../amd/amdkfd/kfd_process_queue_manager.c    | 24 ++++++
>>>>>>   9 files changed, 183 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>> index b545940e512b..651ae0775f80 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>> @@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct 
>>>>>> amdgpu_device *adev,
>>>>>>           kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>>>>>>   }
>>>>>>   +void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd)
>>>>>> +{
>>>>>> +       kgd2kfd_teardown_kfd_device(kfd);
>>>>>> +}
>>>>>> +
>>>>>>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
>>>>>> run_pm)
>>>>>>   {
>>>>>>       if (adev->kfd.dev)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>> index 7e0a22072536..bd241f569b79 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>> @@ -152,6 +152,7 @@ struct amdkfd_process_info {
>>>>>>     int amdgpu_amdkfd_init(void);
>>>>>>   void amdgpu_amdkfd_fini(void);
>>>>>> +void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd);
>>>>>>     void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
>>>>>> run_pm);
>>>>>>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>>>>> @@ -431,6 +432,7 @@ int kgd2kfd_check_and_lock_kfd(void);
>>>>>>   void kgd2kfd_unlock_kfd(void);
>>>>>>   int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
>>>>>>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
>>>>>> +void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd);
>>>>>>   #else
>>>>>>   static inline int kgd2kfd_init(void)
>>>>>>   {
>>>>>> @@ -511,5 +513,10 @@ static inline int kgd2kfd_stop_sched(struct 
>>>>>> kfd_dev *kfd, uint32_t node_id)
>>>>>>   {
>>>>>>       return 0;
>>>>>>   }
>>>>>> +
>>>>>> +void kgd2kfd_teardown_processes(void)
>>>>>> +{
>>>>>> +}
>>>>>> +
>>>>>>   #endif
>>>>>>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 1e47655e02c6..4529d7a88b98 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -3315,7 +3315,8 @@ static int 
>>>>>> amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>>>>>>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>>>   -    amdgpu_amdkfd_suspend(adev, false);
>>>>>> +    if (adev->kfd.dev)
>>>>>> + amdgpu_amdkfd_teardown_kfd_device(adev->kfd.dev);
>>>>>>         /* Workaroud for ASICs need to disable SMC first */
>>>>>>       amdgpu_device_smu_fini_early(adev);
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> index a1f191a5984b..d246f72ae0e9 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> @@ -327,6 +327,13 @@ static int kfd_ioctl_create_queue(struct 
>>>>>> file *filep, struct kfd_process *p,
>>>>>>           err = -EINVAL;
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>> +
>>>>>> +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        pr_debug("gpu 0x%x is not available\n", args->gpu_id);
>>>>>> +        err = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>
>>>>> Instead of duplicating this in all the ioctl functions, could this 
>>>>> check be done in kfd_process_device_data_by_id?
>>>>
>>>> Yes, that makes code simpler. Also, need add same check on 
>>>> kfd_get_process_device_data.
>>>
>>> Maybe not. kfd_get_process_device_data gets a kfd_node as parameter, 
>>> that callers typically get from get from a call to kfd_device_by_id. 
>>> Maybe the check should be in kfd_get_device_by_id so it doesn't 
>>> return invalid devices.
>>
>> kfd_get_process_device_data is used by queue operations. They use 
>> "dev = pqn->q->device" to locate kfd node from queue structure, not 
>> kfd_device_by_id. Then locate pdd.
>>
>> and yes,  at kfd_device_by_id we also need check returned 
>> dev->kfd->valid.
>>
>> dev->kfd->valid means this kfd device cannot be used now(or being 
>> removed). Its resources(kfd_dev, kfd_node) are not released yet until 
>> user apps release all refs to the adev.
>>
>>>
>>>
>>>>
>>>>>
>>>>>
>>>>>>       dev = pdd->dev;
>>>>>>         pdd = kfd_bind_process_to_device(dev, p);
>>>>>> @@ -578,6 +585,12 @@ static int 
>>>>>> kfd_ioctl_set_memory_policy(struct file *filep,
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        pr_debug("gpu 0x%x is not available\n", args->gpu_id);
>>>>>> +        err = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>>       pdd = kfd_bind_process_to_device(pdd->dev, p);
>>>>>>       if (IS_ERR(pdd)) {
>>>>>>           err = -ESRCH;
>>>>>> @@ -621,6 +634,11 @@ static int kfd_ioctl_set_trap_handler(struct 
>>>>>> file *filep,
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        err = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>>       pdd = kfd_bind_process_to_device(pdd->dev, p);
>>>>>>       if (IS_ERR(pdd)) {
>>>>>>           err = -ESRCH;
>>>>>> @@ -704,6 +722,9 @@ static int 
>>>>>> kfd_ioctl_get_process_apertures(struct file *filp,
>>>>>>       for (i = 0; i < p->n_pdds; i++) {
>>>>>>           struct kfd_process_device *pdd = p->pdds[i];
>>>>>>   +        if (!is_kfd_process_device_valid(pdd))
>>>>>> +            continue;
>>>>>> +
>>>>>>           pAperture =
>>>>>> &args->process_apertures[args->num_of_nodes];
>>>>>>           pAperture->gpu_id = pdd->dev->id;
>>>>>> @@ -779,6 +800,9 @@ static int 
>>>>>> kfd_ioctl_get_process_apertures_new(struct file *filp,
>>>>>>       for (i = 0; i < min(p->n_pdds, args->num_of_nodes); i++) {
>>>>>>           struct kfd_process_device *pdd = p->pdds[i];
>>>>>>   +        if (!is_kfd_process_device_valid(pdd))
>>>>>> +            continue;
>>>>>> +
>>>>>>           pa[i].gpu_id = pdd->dev->id;
>>>>>>           pa[i].lds_base = pdd->lds_base;
>>>>>>           pa[i].lds_limit = pdd->lds_limit;
>>>>>> @@ -901,6 +925,11 @@ static int 
>>>>>> kfd_ioctl_set_scratch_backing_va(struct file *filep,
>>>>>>           goto bind_process_to_device_fail;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        err = PTR_ERR(pdd);
>>>>>> +        goto bind_process_to_device_fail;
>>>>>> +    }
>>>>>> +
>>>>>>       pdd->qpd.sh_hidden_private_base = args->va_addr;
>>>>>>         mutex_unlock(&p->mutex);
>>>>>> @@ -981,6 +1010,11 @@ static int kfd_ioctl_acquire_vm(struct file 
>>>>>> *filep, struct kfd_process *p,
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        ret = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>>       if (pdd->drm_file) {
>>>>>>           ret = pdd->drm_file == drm_file ? 0 : -EBUSY;
>>>>>>           goto err_drm_file;
>>>>>> @@ -1031,6 +1065,10 @@ static int 
>>>>>> kfd_ioctl_get_available_memory(struct file *filep,
>>>>>>         if (!pdd)
>>>>>>           return -EINVAL;
>>>>>> +
>>>>>> +    if (!is_kfd_process_device_valid(pdd))
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>>       args->available = 
>>>>>> amdgpu_amdkfd_get_available_memory(pdd->dev->adev,
>>>>>>                               pdd->dev->node_id);
>>>>>>       kfd_unlock_pdd(pdd);
>>>>>> @@ -1090,6 +1128,11 @@ static int 
>>>>>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        err = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>>       dev = pdd->dev;
>>>>>>         if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) &&
>>>>>> @@ -1202,6 +1245,12 @@ static int 
>>>>>> kfd_ioctl_free_memory_of_gpu(struct file *filep,
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        pr_err("Process device is not valid\n");
>>>>>> +        ret = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>>       mem = kfd_process_device_translate_handle(
>>>>>>           pdd, GET_IDR_HANDLE(args->handle));
>>>>>>       if (!mem) {
>>>>>> @@ -1266,6 +1315,12 @@ static int 
>>>>>> kfd_ioctl_map_memory_to_gpu(struct file *filep,
>>>>>>           err = -EINVAL;
>>>>>>           goto get_process_device_data_failed;
>>>>>>       }
>>>>>> +
>>>>>> +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        err = -EINVAL;
>>>>>> +        goto get_process_device_data_failed;
>>>>>> +    }
>>>>>> +
>>>>>>       dev = pdd->dev;
>>>>>>         pdd = kfd_bind_process_to_device(dev, p);
>>>>>> @@ -1384,6 +1439,11 @@ static int 
>>>>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>>>>           goto bind_process_to_device_failed;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        err = -EINVAL;
>>>>>> +        goto bind_process_to_device_failed;
>>>>>> +    }
>>>>>> +
>>>>>>       mem = kfd_process_device_translate_handle(pdd,
>>>>>> GET_IDR_HANDLE(args->handle));
>>>>>>       if (!mem) {
>>>>>> @@ -1567,6 +1627,11 @@ static int kfd_ioctl_import_dmabuf(struct 
>>>>>> file *filep,
>>>>>>           goto err_unlock;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        r = PTR_ERR(pdd);
>>>>>> +        goto err_unlock;
>>>>>> +    }
>>>>>> +
>>>>>>       r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, 
>>>>>> args->dmabuf_fd,
>>>>>>                            args->va_addr, pdd->drm_priv,
>>>>>>                            (struct kgd_mem **)&mem, &size,
>>>>>> @@ -1616,6 +1681,11 @@ static int kfd_ioctl_export_dmabuf(struct 
>>>>>> file *filep,
>>>>>>           goto err_unlock;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        ret = -EINVAL;
>>>>>> +        goto err_unlock;
>>>>>> +    }
>>>>>> +
>>>>>>       mem = kfd_process_device_translate_handle(pdd,
>>>>>> GET_IDR_HANDLE(args->handle));
>>>>>>       if (!mem) {
>>>>>> @@ -1660,6 +1730,9 @@ static int kfd_ioctl_smi_events(struct file 
>>>>>> *filep,
>>>>>>       if (!pdd)
>>>>>>           return -EINVAL;
>>>>>>   +    if (!is_kfd_process_device_valid(pdd))
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>>       return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>>>>>>   }
>>>>>>   @@ -2990,6 +3063,11 @@ static int 
>>>>>> kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process 
>>>>>> *p, v
>>>>>>               r = -ENODEV;
>>>>>>               goto unlock_out;
>>>>>>           }
>>>>>> +
>>>>>> +        if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +            r = -ENODEV;
>>>>>> +            goto unlock_out;
>>>>>> +        }
>>>>>>       }
>>>>>>         switch (args->op) {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> index fad1c8f2bc83..019567249110 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> @@ -893,6 +893,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>>>       svm_range_set_max_pages(kfd->adev);
>>>>>>         kfd->init_complete = true;
>>>>>> +    kfd->valid = true;
>>>>>>       dev_info(kfd_device, "added device %x:%x\n", 
>>>>>> kfd->adev->pdev->vendor,
>>>>>>            kfd->adev->pdev->device);
>>>>>>   @@ -919,6 +920,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>>>     void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>>>>>   {
>>>>>> +    struct kfd_process *p;
>>>>>> +    unsigned int i, j;
>>>>>> +    unsigned int temp;
>>>>>> +
>>>>>>       if (kfd->init_complete) {
>>>>>>           /* Cleanup KFD nodes */
>>>>>>           kfd_cleanup_nodes(kfd, kfd->num_nodes);
>>>>>> @@ -929,6 +934,20 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>>>>>           amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>>>>>>       }
>>>>>>   +    /* now this kfd_dev has been completely removed from kfd 
>>>>>> driver
>>>>>> +     * before kfree kfd iterate all existing kfd processes, if 
>>>>>> kfd process
>>>>>> +     * uses any kfd node from this kfd set its ref to NULL
>>>>>> +     */
>>>>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, 
>>>>>> kfd_processes) {
>>>>>> +        for (i = 0; i < kfd->num_nodes; i++)
>>>>>> +            for (j = 0; j < p->n_pdds; j++) {
>>>>>> +                if (kfd->nodes[i] == p->pdds[j]->dev) {
>>>>>> +                    p->pdds[j]->dev = NULL;
>>>>>
>>>>> Could this be done in teardown_kfd_device? Then you may not need a 
>>>>> separate "valid" for is_kfd_process_device_valid. And any 
>>>>> accidental access to a device associated with an invalid pdd would 
>>>>> automatically trigger a kernel error message with a backtrace.
>>>>
>>>> At teardown_kfd_device the adev has not been removed, ex: there are 
>>>> user apps still refer the render node. kfd dev(kfd nodes) is 
>>>> released at kfd_cleanup_nodes of kgd2kfd_device_exit when all ref 
>>>> to adev got released(user apps close render node). During that time 
>>>> kfd nodes(pdd->dev) are valid. We still can access kfd nodes data 
>>>> structure though their queues got stopped and kfd_node->kfd has 
>>>> been markded as invalid.
>>>
>>> I'm not sure why that matters. The fact that the there are still 
>>> other pointers to the dev doesn't mean the pointer in the pdd must 
>>> remain valid.
>>>
>> Ex: when kfd process is released we call 
>> kfd_process_dequeue_from_all_devices to terminate all queues(the 
>> queues have been stopped after unplug the adev), we use pdd->dev to 
>> locate kfd node for following "Clears all process queues belongs to 
>> that device"
>>
>> At teardown_kfd_device the kfd dev(its kfd nodes) has not been 
>> released. keeping pdd->dev is convenient when need locate the kfd dev 
>> from pdd. Otherwise we need use other ways to locate kfd node.
>>
>>> On the other hand, there should be code in 
>>> kgd2kfd_teardown_kfd_device or kgd2kfd_device_exit to clean up _all_ 
>>> the other pointers to the invalid kfd_dev and kfd_nodes. AFAICT the 
>>> kfd_dev and kfd_nodes are not reference counted, and there is no 
>>> guarantee that these structures still exist by the time the 
>>> processes terminate and run their cleanup code. You can't rely on 
>>> kfd_dev->valid after the kfd_dev itself has been freed with kfree in 
>>> kgd2kfd_device_exit. By that time all pointers to the kfd_dev and 
>>> its nodes must have been cleaned up.
>>>
>>> A quick survey of the header files shows
>>>
>>>  * kfd_dev pointers in kfd_node, kfd_device_queue_manager
>>>  * kfd_node pointers in kfd_dev, kfd_bo, queue, kernel_queue,
>>>    kfd_process_device, kfd_*_properties referenced in lists in
>>>    kfd_topology_device, svm_range_bo, mqd_manager
>> I had same thought when did it. Here all queues on this kfd dev are 
>> stopped at first, and all kfd nodes from kfd dev got marked as 
>> invalid, so not serve any new request on these kfd nodes at api 
>> level. Any existing operations that use kfd node check if it is valid.
>
> That doesn't help if the kfd_node and kfd_dev structure were already 
> freed with kfree. Before these structures are freed, you need to make 
> sure that you don't have any dangling pointers to them in any of the 
> data structures I listed, especially the per-process structures.

Before kfree(kfd_dev) I set pdd->dev = NULL, and 
is_kfd_process_device_valid check pdd->dev is not NULL:

static inline bool is_kfd_process_device_valid(struct kfd_process_device 
*pdd) {
         return (pdd && pdd->dev && pdd->dev->kfd && pdd->dev->kfd->valid);
}

that may not enough to cover all cases  that kfd driver accesses kfd 
node/dev in different ways. I will reconsider that.


Thanks

Xiaogang

>
> Regards,
>   Felix
>
>
>
>>>
>>>
>>>>
>>>>>
>>>>>
>>>>>> +                    break;
>>>>>> +                }
>>>>>> +            }
>>>>>> +    }
>>>>>> +
>>>>>>       kfree(kfd);
>>>>>>   }
>>>>>>   @@ -1485,6 +1504,30 @@ int kgd2kfd_stop_sched(struct kfd_dev 
>>>>>> *kfd, uint32_t node_id)
>>>>>>       return node->dqm->ops.halt(node->dqm);
>>>>>>   }
>>>>>>   +/* tear down this kfd deve */
>>>>>> +void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd)
>>>>>> +{
>>>>>> +    struct kfd_process *p;
>>>>>> +    struct kfd_node *dev;
>>>>>> +    unsigned int i;
>>>>>> +    unsigned int temp;
>>>>>> +
>>>>>> +    kfd->valid = false;
>>>>>> +    /* stop queues from kfd nodes in this kfd dev */
>>>>>> +    for (i = 0; i < kfd->num_nodes; i++) {
>>>>>> +        dev = kfd->nodes[i];
>>>>>> +        dev->dqm->ops.stop(dev->dqm);
>>>>>> +    }
>>>>>
>>>>> If the GPU was unplugged already, what's the point of this? Won't 
>>>>> this trigger a timeout?
>>>>>
>>>> pci base driver will find that the device has been unplugged, will 
>>>> not call amdgpu driver's callback for pci device that has been 
>>>> removed. So that would not happen.
>>>
>>> This has nothing to do with PCIe callbacks. dev->dqm->ops.stop tries 
>>> to talk to the HWS firmware to remove queues. That will hand or time 
>>> out if the GPU has been unplugged.
>>
>> Not sure understand that. Inside kgd2kfd_teardown_kfd_device the adev 
>> has not been released(adev got released from pci system after 
>> kgd2kfd_teardown_kfd_device return), so can do dev->dqm->ops.stop. If 
>> user tries unplug same device again pci base driver will not find it, 
>> then not call amdgpu driver. Misunderstanding?
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
>>>>>
>>>>>> +
>>>>>> +    /* signal a gpu device is being teared down to user spalce 
>>>>>> processes by
>>>>>> +     * KFD_EVENT_TYPE_HW_EXCEPTION event
>>>>>> +     */
>>>>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)
>>>>>> +        kfd_signal_hw_exception_event(p->pasid);
>>>>>
>>>>> This sends exceptions to all processes. It should only do this for 
>>>>> processes that use the unplugged device (i.e. have a pdd that uses 
>>>>> the device). This excludes processes that don't have the device in 
>>>>> their cgroup.
>>>> ok, will iterate all existing kfd processes. If any kfd node from 
>>>> this kfd dev got used by a kfd process send the event to 
>>>> correspondent user process.
>>>>>
>>>>>
>>>>>> +
>>>>>> +    return;
>>>>>> +}
>>>>>> +
>>>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>>>     /* This function will send a package to HIQ to hang the HWS
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>>>> index dbcb60eb54b2..b8dd80ee17be 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>>>> @@ -378,6 +378,12 @@ int kfd_init_apertures(struct kfd_process 
>>>>>> *process)
>>>>>>               continue;
>>>>>>           }
>>>>>>   +        /* kfd device that this kfd node belogns is not valid */
>>>>>> +        if (!dev->kfd->valid) {
>>>>>> +            id++;
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>>           pdd = kfd_create_process_device_data(dev, process);
>>>>>>           if (!pdd) {
>>>>>>               dev_err(dev->adev->dev,
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> index 6a5bf88cc232..97e7692ce569 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> @@ -371,6 +371,9 @@ struct kfd_dev {
>>>>>>         /* bitmap for dynamic doorbell allocation from doorbell 
>>>>>> object */
>>>>>>       unsigned long *doorbell_bitmap;
>>>>>> +
>>>>>> +    /* this kfd_dev valid or not */
>>>>>> +    bool valid;
>>>>>>   };
>>>>>>     enum kfd_mempool {
>>>>>> @@ -1055,6 +1058,10 @@ int kfd_process_restore_queues(struct 
>>>>>> kfd_process *p);
>>>>>>   void kfd_suspend_all_processes(void);
>>>>>>   int kfd_resume_all_processes(void);
>>>>>>   +static inline bool is_kfd_process_device_valid(struct 
>>>>>> kfd_process_device *pdd) {
>>>>>> +    return (pdd && pdd->dev && pdd->dev->kfd && 
>>>>>> pdd->dev->kfd->valid);
>>>>>> +}
>>>>>> +
>>>>>>   struct kfd_process_device *kfd_process_device_data_by_id(struct 
>>>>>> kfd_process *process,
>>>>>>                                uint32_t gpu_id);
>>>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> index d07acf1b2f93..c06eb9d8008e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> @@ -1157,8 +1157,6 @@ static void kfd_process_wq_release(struct 
>>>>>> work_struct *work)
>>>>>>       ef = rcu_access_pointer(p->ef);
>>>>>>       dma_fence_signal(ef);
>>>>>>   -    kfd_process_remove_sysfs(p);
>>>>>> -
>>>>>>       kfd_process_kunmap_signal_bo(p);
>>>>>>       kfd_process_free_outstanding_kfd_bos(p);
>>>>>>       svm_range_list_fini(p);
>>>>>> @@ -1173,6 +1171,11 @@ static void kfd_process_wq_release(struct 
>>>>>> work_struct *work)
>>>>>>         put_task_struct(p->lead_thread);
>>>>>>   +    /* the last step is removing process entries under /sys
>>>>>> +     * to indicate the process has been terminated.
>>>>>> +     */
>>>>>
>>>>> This comment doesn't provide any useful information. What would be 
>>>>> useful is, why this needs to be the last step? Without that, I see 
>>>>> no good reason for this change.
>>>> ok, this change is not related to the patch. I thought it is better 
>>>> to update kfd topology at last step after all kfd process resources 
>>>> got released. I will remove this change.
>>>>>
>>>>>
>>>>>> +    kfd_process_remove_sysfs(p);
>>>>>> +
>>>>>>       kfree(p);
>>>>>>   }
>>>>>>   @@ -1536,6 +1539,12 @@ static struct kfd_process 
>>>>>> *create_process(const struct task_struct *thread)
>>>>>>       if (err != 0)
>>>>>>           goto err_init_apertures;
>>>>>>   +    /* no any kfd_process_device can be created */
>>>>>> +    if (!process->n_pdds) {
>>>>>> +        err = -ENODEV;
>>>>>> +        goto err_init_apertures;
>>>>>> +    }
>>>>>> +
>>>>>>       /* Check XNACK support after PDDs are created in 
>>>>>> kfd_init_apertures */
>>>>>>       process->xnack_enabled = kfd_process_xnack_mode(process, 
>>>>>> false);
>>>>>>   diff --git 
>>>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>>> index c76db22a1000..eaf4ba65466c 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>>> @@ -124,6 +124,11 @@ int pqm_set_gws(struct process_queue_manager 
>>>>>> *pqm, unsigned int qid,
>>>>>>           return -EINVAL;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        pr_debug("device 0x%x is not available\n",dev->node_id);
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>>       /* Only allow one queue per process can have GWS assigned */
>>>>>>       if (gws && pdd->qpd.num_gws)
>>>>>>           return -EBUSY;
>>>>>> @@ -498,6 +503,11 @@ int pqm_destroy_queue(struct 
>>>>>> process_queue_manager *pqm, unsigned int qid)
>>>>>>       if (WARN_ON(!dev))
>>>>>>           return -ENODEV;
>>>>>>   +    if (!dev->kfd || !dev->kfd->valid) {
>>>>>> +        pr_err("Process device is not valid\n");
>>>>>
>>>>> Would you expect to see this message during process termination 
>>>>> after a hot-unplug? Should this really be an error message, or 
>>>>> would an info or debug message be more appropriate?
>>>> I will change kfd_get_process_device_data that will include this 
>>>> check, then this message will be merged at !pdd case.
>>>>>
>>>>>
>>>>>> +        return -1;
>>>>>
>>>>> This should be a proper error code. -1 is -EPERM.
>>>>>
>>>> Same as above.
>>>>>
>>>>>> +    }
>>>>>> +
>>>>>>       pdd = kfd_get_process_device_data(dev, pqm->process);
>>>>>>       if (!pdd) {
>>>>>>           pr_err("Process device data doesn't exist\n");
>>>>>> @@ -567,6 +577,10 @@ int pqm_update_queue_properties(struct 
>>>>>> process_queue_manager *pqm,
>>>>>>           pdd = kfd_get_process_device_data(q->device, q->process);
>>>>>>           if (!pdd)
>>>>>>               return -ENODEV;
>>>>>> +
>>>>>> +        if (!is_kfd_process_device_valid(pdd))
>>>>>> +            return -ENODEV;
>>>>>> +         vm = drm_priv_to_vm(pdd->drm_priv);
>>>>>>           err = amdgpu_bo_reserve(vm->root.bo, false);
>>>>>>           if (err)
>>>>>> @@ -612,6 +626,11 @@ int pqm_update_mqd(struct 
>>>>>> process_queue_manager *pqm,
>>>>>>           return -EFAULT;
>>>>>>       }
>>>>>>   +    if (!pqn->q->device->kfd->valid) {
>>>>>> +        pr_debug("device where queue %d exists is not valid\n", 
>>>>>> qid);
>>>>>> +        return -EFAULT;
>>>>>> +    }
>>>>>> +
>>>>>>       /* CUs are masked for debugger requirements so deny user 
>>>>>> mask  */
>>>>>>       if (pqn->q->properties.is_dbg_wa && minfo && 
>>>>>> minfo->cu_mask.ptr)
>>>>>>           return -EBUSY;
>>>>>> @@ -679,6 +698,11 @@ int pqm_get_wave_state(struct 
>>>>>> process_queue_manager *pqm,
>>>>>>           return -EFAULT;
>>>>>>       }
>>>>>>   +    if (!pqn->q->device->kfd->valid) {
>>>>>> +        pr_debug("device where queue %d exists is not valid\n", 
>>>>>> qid);
>>>>>> +        return -EFAULT;
>>>>>
>>>>> EFAULT means "bad address". Probably not the right error code here.
>>>>
>>>> Will use -EINVAL.
>>>>
>>>> Thanks
>>>>
>>>> Xiaogang
>>>>
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>> +    }
>>>>>> +
>>>>>>       return 
>>>>>> pqn->q->device->dqm->ops.get_wave_state(pqn->q->device->dqm,
>>>>>>                                  pqn->q,
>>>>>>                                  ctl_stack,

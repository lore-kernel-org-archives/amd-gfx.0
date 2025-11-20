Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C530CF8862
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 14:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ECB210E29E;
	Thu, 20 Nov 2025 14:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QhQTJIF7";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F278E10E29E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 14:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJGlCNWvrqy9665TnGPm3FAJ+1Ye08m3HkvKI3ryGsOUu6OF2V9vaMefa3XW3tpIsER1JqxfKQec0V7sC8u/K40iLmwVYjP4YkjNnbr4Q9MlIec5y4jR4siaQL5MkzcuBhVDm9k24nVi2bMEB9wAX/cZfGZqapFM0dqXNzhWdvIkt9wFWHLWjh0xKSeXfTXF4KgRvFLOBnTS6AuvgnIUP9SEAoc84FFICYWXxOiIU4xLSEYsLY19RsPqgs4TubxcHY9x37inAVa0EPsi80Dv7arY/NphdfqDmFqtuTF4ZUC6dU0zdA3vn7oe0L6mEzklTkeZe7GsJkgzIwAlm57ixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSUjyJpthefAjyzSTgELc1npingc3rdFyvwoenA4TZs=;
 b=f96M58rW/sCXa5K3PXs28gGLDtt7CfPe5YZk22GM8lp3NYUvYriTGc15q4OMPFTCiUL7/fJ84IyHncKj8yDwCq/TwkjPm9bGCB/UEuUPkHMoBeqj4FHbFPrtBouqCBiNm9MvalIn1ecqm/ySw6vJO703ulOdPGxUedxkqZp2bJi1OYY+FniQoHTWe1F+s+N/giSZ8sUATzC1PmVTHFDJYCMnMIp5JkO6K/NnEqKl2XKJt+5Rm2NCrSadPx/h0cmGISVbIRB6l8kv/cjpoAJ2Ot97zMYhURRUGpyriihqBZjeZtKknQaC0qHhIAoJ8z8nmjYnEWt27jIhk77kJWe0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSUjyJpthefAjyzSTgELc1npingc3rdFyvwoenA4TZs=;
 b=QhQTJIF7YwozfmvHfft2sFeMi7ZdniQYEpI3mPffRGAyOKs4A1U3xCurIcg/zAPG9hu7Xlwj1Lvtjd9GZFMPWxfgJ0iR2bnAVSKK2WMAghyGujF2m/RyTaCV8eDJezzcp2Oy00VNMEV9rw+MIPMTo35lx5OtMIzBaSCd2a6knpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Thu, 20 Nov 2025 14:18:04 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 14:18:04 +0000
Message-ID: <50847ed9-bc6d-4523-9b8f-ca96b658b56f@amd.com>
Date: Thu, 20 Nov 2025 08:18:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Use huge page size to check split svm
 range alignment
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251118173228.1873433-1-xiaogang.chen@amd.com>
 <8382d7f5-4743-416d-87d8-8b892dff4976@amd.com>
 <e2801bd9-3a63-4c94-9e4c-ef64b2fcb67b@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <e2801bd9-3a63-4c94-9e4c-ef64b2fcb67b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::14) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 22967e60-8f2b-44b5-81b2-08de283f9eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzlHb1Q1RE0zMnFjSEtzb1Z0RU1QWUFYaGlFSWE0N04vZVdHK1MxbmFGYVkr?=
 =?utf-8?B?SWtHU0UyQlkwRC9RdXBqcDl2dFNHd0Q0Mk5GVGhNMXdqbi9ieGVGdDlXa1E3?=
 =?utf-8?B?VzlUcHdEekdTdnZENWhXeVVQYlEraC91Y1M2dGQ2SWxIT1I0WlhLaGVwQVFl?=
 =?utf-8?B?RGVrSjY2WmRJc2IxZlI2YmlZQlIrbzFMYVVUZzg3WVJTZ0FFK1ZYYzJaSHdR?=
 =?utf-8?B?VmdETXAzblFCaGd0TXZHQWIxMjBMa0ZzR3Nla1A1Q3FCZGdUQ1pzTzdNQ21z?=
 =?utf-8?B?eEZBUERTWU13SzIzSGxra3N5cWJnTDV2WHZPRzNYMjhLcVZBbGhiVXo4NlRT?=
 =?utf-8?B?MjNQK3A1VmtBWG52TFZ6T3dFTUdPbC9HTWFaOEFONm1VeHRwbkxpcnZoMEw1?=
 =?utf-8?B?aTVITEpscmhBQjNTUHR4QVlrNHp0akljaTJzN0d3RUJsS0FQMlhnVUhxT0x1?=
 =?utf-8?B?Q2JpUUlUTlFVTVJLeXhPMGFZb09tYUFIalJQZ0lSUDdRcEozdnpkWk5OQ0JZ?=
 =?utf-8?B?YkV1KzYzTDdHb08rd2hEaTF6b0hOTUJkN0ZxUTgycDJhSDZDTlhiZEpneTdL?=
 =?utf-8?B?NldMblpJMlRnY0NWVHhmNEtCQ2JEZjlUNG8yWUVjMGdxcytIbW5wSXNGY3N4?=
 =?utf-8?B?YjV4YUNHbWVZOUFCZ0NQaENzLytGYnNQZlgwU2s4eDkxaDZZWFk4aW9oZEov?=
 =?utf-8?B?SWJNSDVjS0hEZzNYRVlaamxFT1pRWFBtRW4yN3FXNWVHMm9NaFViKytzZnpC?=
 =?utf-8?B?Q0dUalVZWitza2l6YWp5a1VXZ0FxT0w4ZTF0dW55Sm14dmFHVmhpWHNaYmVn?=
 =?utf-8?B?SWhId3RtZy9wZlk1NU93Tk5jNW1rRGcvNjVYQkJLZk9zcjB4V2R1elZyM2N4?=
 =?utf-8?B?VEdRd3luMlRwa2dHN3BOTFJVeVRwblg1Q1ZSd2F5ZC8zSDJPT2tNM0wxNXpK?=
 =?utf-8?B?dmpma0krbkZZWDIxK2JiZkxkTWUxVkg5UzdlNTlXR25RWGJhTzJ6akNWZXcy?=
 =?utf-8?B?TmUxNGJ5cml4amt4QWMrempleTd0WUVXZXl0NmNKS0VhMjNoTXI2MnJyTS9m?=
 =?utf-8?B?ZnlReWpObFFDbUVrNUE1Y0tCTzVtaXN0TktjeTdLeThLYXI4Sy8xeWxHaTZm?=
 =?utf-8?B?UHRxMUFQNkJnQmVkcXpGVHUyREZ6OTFvM1IvSll0OW9WaVhjWFI1VzNaMFhK?=
 =?utf-8?B?SWJLcGJTaWttdDVpd0d2Sy9qMGZHY0tGMnhtNThvR3FGNkpjT0VXcG0yTEgx?=
 =?utf-8?B?NE5ldVRqODk2UGdwVFloRFFwb25qdndaTURGVWZZbCtNdWxRWElmQlNnNnIw?=
 =?utf-8?B?cjJ3Yk1NeVhybjhLM085VlBIY0RaaXkrdFFlWU96c1pQcS8rWTZHOEhlMEZy?=
 =?utf-8?B?a2tNbmRoekN6ZU8zZDlkeGpnaU5EOCt4RUVkRUlabDk2OUhBVkFtTE1WNFBx?=
 =?utf-8?B?eGpwUnREOUNmRlBvZWRReG5iMi9UY3BpWE9hbkdrdEFlRnNuMEtmWXQ2S0VI?=
 =?utf-8?B?RkZqa2orbFFsL3psdHNqYXNRcFh6UkFPWGc3VEx0djlDMzZaYkYrY202SnVp?=
 =?utf-8?B?L2VYbmNvR2ZUS3dxZ0RVeFhOWFArU21TeUhwZHVnM0RUZGlhb2JIdDRBQTNW?=
 =?utf-8?B?UTFEUVpjQTA5ME9FN2xOenNZTmlFZUd2bDZJQWwxTWF4bnJSR0RFbDB4VXRj?=
 =?utf-8?B?MHZINnBOZ1AwZURlN3A4VlJnOTljamRlRGU0MHZKZmRwcFBRU0NITXJOUnBW?=
 =?utf-8?B?eUl6eFFLVGJDajZTdFZjTVd0YTJJeTVieE1ucmxMYS9Na1N6RVJQS1k4SzVP?=
 =?utf-8?B?K1NkcFI1bWVhdzBiODdSMms4b2ZBNlFBR0prb0s0emVNNnFWQUpPaGlJUmw1?=
 =?utf-8?B?dldmY243Q2JXc2dkb1YrbEx1Qm1CK0RvWThvS0l5byszM3l0VmtTKzJUNEx5?=
 =?utf-8?Q?ABCwqX2TT1w0wHv4HI1li7u828V5h29O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGlKYk5rTDhpbWVibXdEM2tMUng1cmdOaXlINmRCcTVJRzQwQlRaeTY1RkJk?=
 =?utf-8?B?dXJ1RXIzRFpBRjhhTjFlRmZmODFCRkM5NEhqWkpCbzE4TW9FWCs1T2w0SHpT?=
 =?utf-8?B?b2c4alV2b2Y0MkpxamFqSUhHTVZWNXd2ZGRhRytlQ2tJOUdFWVQrdmRJWkk1?=
 =?utf-8?B?V002LytLVWFFakRRVHNMVW0wdGZKZkRQbEw3OUZpb0FnL2IwMkRQWDA0NDFC?=
 =?utf-8?B?b1dJNDNJZ3BXM3IzS25rb1NRQnhrUjhFNU1UcDZWUGNzMWZkOHB3eSszVUZ2?=
 =?utf-8?B?WWZkOHNZbGRXRjFmS3lCS0FEZU9xS2p6WERiTXJNamJFVXNEM05XanFMYXB4?=
 =?utf-8?B?WFRKVDZIaXJJYmlHbTduY0prUkpUdDVkQjdiYUxRN00rVXZVdkhNaEtFYy9Q?=
 =?utf-8?B?M1ZRWEZNWW00RmxJeUthN2FxeWpVUlF1VTBGTDBWaXJHcElubnlFaVRjSWFL?=
 =?utf-8?B?djMyaXJHSk1tNDhQS0svRm5uTzRDNVdsd0VPK0JubGNiTmJES3hETTExaGEv?=
 =?utf-8?B?bGVsT0pxTWc3UkpaN3VxT0J3VnovQ2RWM2dHWXVzcFU0NUVVd05vRkoyR1ZL?=
 =?utf-8?B?K2NvTTVPOUQrMTdhTnpQL29ucTdTY3lVR3Fhc215SnI5V210bFpVUzVlZlgv?=
 =?utf-8?B?Nzd4TGNHTjljNXFJalVkSGVkSzZPbFIrQUh0MW5FaGdtU1Rta0U2NlBTdGow?=
 =?utf-8?B?RG1HTFNhc1VCTUNCZldlODhiVy9DQ2w5aXVHUnNVUEltSkQ5ZDE1cWpXQzR3?=
 =?utf-8?B?ZmZ6cTVUb3FyVEcydXNNQmlvMFpmVXhFUm5WbUFKN3Y5VngxR1ErTmFicUVF?=
 =?utf-8?B?Y2NPR29GbE1JcU56ZGhhN1BEUGZDREY5aE1DSkJrcUx0K2doOTFPRTltTndx?=
 =?utf-8?B?empXeFBkQTJ3UWhkMHNsSEx2WEhOTlIwN0tSY1VGc0psak5JbjFuM0U0djVU?=
 =?utf-8?B?NmVzVE1UOHNDUEVzNzJlWmlrTkw0ZmhyMEdqd2J6UzVoMVBzQ2ZBdjZ5SmRW?=
 =?utf-8?B?SWZaU1p3cTBUR1IxRUZ3SmZGMjJqTStoVkpHMUI4cjkvdk0xKytHNG9ucHJh?=
 =?utf-8?B?cTFnczdiS25WejYrRUZvZEpHbDhhUWFDcCtXRzNtVnpsRU1TdENMUDhjREdq?=
 =?utf-8?B?Wjh3cVBVZVBDWEp0QlR5dHFhbWtvT2VmejYza0JjRmQ3aDhRRnVORTRXUS9P?=
 =?utf-8?B?RWNKbE1QdUd1dGhrVVppY0E2REpvMGszTURVQU8xUVY4SWVNeE9neEFsd0lM?=
 =?utf-8?B?NVVtM1ZnTnVHR1VDVWsxUGYxZCtsN0NNUCtSR3c2U2lIQlNYTXRxSE9ibHAy?=
 =?utf-8?B?VjBidWd1cGZ2VmUxZmkyZkhRajBkaWErMmIyd0h1OE9ackhKdEw0TENsYmNp?=
 =?utf-8?B?bUMrTVl1c1NMbHMvQXUwNlpJVzhUWVViamxySWlpcURleXlIWVg4SnFqV1p1?=
 =?utf-8?B?TnphVm9YVC96L1R4aWN6OTIvKzh4dkZxaWdoTElYSXNObmszTjFwS01BZ3F3?=
 =?utf-8?B?YTRrV1lBMGtKNk9Yd1VxWTVobTQyczk0aFg2YXZGaFBqL2FVR3RkZFgrZ1Vu?=
 =?utf-8?B?ejltWEw2RzMxRHhuS09MRTFicjJkWGo2NkVzTUJNc2g5UndmUm15VUV1aSs0?=
 =?utf-8?B?QnJQZzJYc21NSGZtTElHdEtnNmh4OENZR2xodC80ek9IckpSRWVFOU9uV2xr?=
 =?utf-8?B?NmlUZ29UenhsaVhnUS9JY2F1ZUJVRDBUVUVnNVp1NGhkZWdkNzJYWmJraS9S?=
 =?utf-8?B?QytjMitDOCtxcDhkWGZQaW5uNU5IeTlKVytmYTFYdXgvUm05MTV1VUViVU96?=
 =?utf-8?B?YmVLWCtKVVBzMUhMSS9JQk1Ba3JVT1RhR3NvRUhrdnMrdjQwRXhHRG96S0N2?=
 =?utf-8?B?b0N0V29OVG83KzIrbzB4YlFmelpqSWZ1TUxqWFRaOXNZWlAwa1Bzb2ozNmQ5?=
 =?utf-8?B?QUJaeVV3dUo4cHE3Qitrd0Fqc3EyNFl5QWErLzRSakkybUpFSnpuZVQzeEla?=
 =?utf-8?B?VlpIY1JlM0JILy9HSjdZQ0RScFpuaDdZUzZHUUgrRkFTRHJwZDYvY0g5Uk1M?=
 =?utf-8?B?eEJUNEFCd2xlYUU3U241eEhnUVlWeGVyVTY1bGN4YURhR29kZmhZSkFvdE80?=
 =?utf-8?Q?A/Vc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22967e60-8f2b-44b5-81b2-08de283f9eb3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 14:18:04.5626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8/wJ7lh65JstsXc7gUMfbgAJi4+r317mDYEIgJLslgC/KqYP0kJizZairTHzBAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
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


On 11/19/2025 6:22 PM, Philip Yang wrote:
> resend, to fix the code format issue.
>
> On 2025-11-19 18:33, Philip Yang wrote:
>>
>> On 2025-11-18 12:32, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that 
>>> have split)
>>>
>>> When split svm ranges that have been mapped using huge page should 
>>> use huge
>>> page size(2MB) to check split range alignment, not 
>>> prange->granularity that
>>> means migration granularity.
>>>
>>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>:
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 63 
>>> ++++++++++++++++++++++++++--
>>>   1 file changed, 59 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 521c14c7a789..7bb94555e5f9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1145,12 +1145,39 @@ svm_range_split_tail(struct svm_range 
>>> *prange, uint64_t new_last,
>>>                struct list_head *insert_list, struct list_head 
>>> *remap_list)
>>>   {
>>>       struct svm_range *tail = NULL;
>>> +    unsigned long start_align = ALIGN(prange->start, 512);
>>> +    unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
>>>       int r = svm_range_split(prange, prange->start, new_last, &tail);
>> move this function call after variable definition, easier to read.
>>> +    bool huge_page_mapping = (last_align_down > start_align) &&
>>> +                 (last_align_down - start_align) >= 512;
>> >= 512 is redundant because start, last already aligned to 512
>>>         if (!r) {
>>>           list_add(&tail->list, insert_list);
>>> -        if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
>>> -            list_add(&tail->update_list, remap_list);
>>> +        /* original prange has huge page mapping */
>>> +        if (huge_page_mapping) {
>>> +
>>> +            /* tail->start is inside huge page mapping but not 2MB 
>>> aligned
>>> +             * or tail size is smaller than 512 pages
>>> +             */
>>> +            if (tail->start >= start_align && tail->start <= 
>>> last_align_down &&
>>> +                (!IS_ALIGNED(tail->start, 512) ||
>> split from the tail, new range is the last part of prange, don't need 
>> check size
>>> +                (tail->last - tail->start) < 512)) {
>>> +
>>> +                list_add(&tail->update_list, remap_list);
>>> +                return 0;
>>> +            }
>>> +
>>> +            /* tail->last is inside huge page mapping but not 2MB 
>>> aligned
>>> +             * or tail size is smaller than 512 pages
>>> +             */
>> tail->last is the original prange->last, impossible inside prange.
>>> +            if (tail->last >= start_align && tail->last <= 
>>> last_align_down &&
>>> +                (!IS_ALIGNED(tail->last, 512) ||
>>> +                (tail->last - tail->start) < 512)) {
>>> +
>>> +                list_add(&tail->update_list, remap_list);
>>> +                return 0;
>>> +            }
>>> +        }
>>>       }
>>
>> to refactor the conditions
>
>     unsigned long start_align = ALIGN(prange->start, 512);
>     unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
>     bool huge_page_mapping = last_align_down > start_align;
>     int r;
>
>     r = svm_range_split(prange, prange->start, new_last, &tail);
>
>     if (r || !huge_page_mapping)
>         return r;
>
>     if (tail->start > start_align && tail->start < last_align_down &&
>         (!IS_ALIGNED(tail->start, 512))
>         list_add(&tail->update_list, remap_list);
>
>     return 0;

ok, that makes code concise. Thanks.

Still need add tail to insert list:

list_add(&tail->list, insert_list);

Regards

Xiaogang

>>
>> do the similar change for below split head.
>>
>> Regards,
>> Philip
>>
>> @@ -1160,13 +1187,41 @@ svm_range_split_head(struct svm_range 
>> *prange, uint64_t new_start,
>>               struct list_head *insert_list, struct list_head 
>> *remap_list)
>>  {
>>      struct svm_range *head = NULL;
>> +    unsigned long start_align = ALIGN(prange->start, 512);
>> +    unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
>>      int r = svm_range_split(prange, new_start, prange->last, &head);
>> +    bool huge_page_mapping = (last_align_down >= start_align) &&
>> +                 (last_align_down - start_align) >= 512;
>>
>>      if (!r) {
>>          list_add(&head->list, insert_list);
>> -        if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
>> -            list_add(&head->update_list, remap_list);
>> +
>> +        /* original prange has huge page mapping */
>> +        if (huge_page_mapping) {
>> +            /* head->start is inside huge page mapping but not 2MB 
>> aligned
>> +             * or head size is smaller than 512 pages
>> +             */
>> +            if (head->start >= start_align && head->start <= 
>> last_align_down &&
>> +                (!IS_ALIGNED(head->start, 512) ||
>> +                (head->last - head->start) < 512)) {
>> +
>> +                list_add(&head->update_list, remap_list);
>> +                return 0;
>> +            }
>> +
>> +            /* head->last is inside huge page mapping but not 2MB 
>> aligned
>> +             * or head size is smaller than 512 pages
>> +             */
>> +            if (head->last >= start_align && head->last <= 
>> last_align_down &&
>> +                (!IS_ALIGNED(head->last, 512) ||
>> +                (head->last - head->start) < 512)) {
>> +
>> +                list_add(&head->update_list, remap_list);
>> +                return 0;
>> +            }
>> +        }
>>      }
>> +
>>      return r;
>>  }
>>
>>
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A6FC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 21:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE32B10E2FD;
	Wed, 29 May 2024 21:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zF3e+jjr";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7C610E2FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 21:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huWfVb5FhloDyLYkWEsz6JY5UMW/cPcVvXD5Ng8imia+BHa3obOUGOzxt+xgus9OkX93yukbFt1uxLEM/2QYYyCjzls8UhWqtSvvbKF5ZlEElodCO9R7pS+8JAE+2XFYCCpKjksKLiDKGrmvWSpnOlFSHMkASlKzj1yAj+5QsGf2R43C2SctwiNu5kGowgxAOLjcCR3pBT6jKLgluAlC3Fx17JZpEcO1Nunq4joeXuj1+Z8QOo1EuRYQ9JXgDtnQTCZflTgvLircbshv9LyYNe2DA0711JZurLj3Sq99gAHvhjCzr5ygS7nXu2ifHClOwJW9GlZmueSN/E8eKOI0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iknhAEOoWTuhaCHZfO5BmOXVvQtZihiF7vEAQ4k+PMA=;
 b=iN8sKv8Q3oXMm77e87KveJt+h17Z9RKYZPNJra7/FY46lAulHPYghpobBeEEzuP3g2s03USeY+FtK70aMwWvSDDU7TWtNEsxVgxlgZjFj5mViIhPs8Nk80mBrQWBYUd1/xcWajlWJJsvWFt02B+XFDC3j6zuA8gKpm65DYwQtCrEvGTw4yNWtenqo0fCLsRPGv+dKuZ83ajqbuBmmeONNRDYaV4DZxLrh7jz1N1u9tOpn4gnijfclCJxVsaYSfiP49wkZqPqeCkrWQGJHGUP6YRG4ENydiKNmZH9V2gXbXjVSbdEYJNYbh9ADGY/X6IMeU5GTMbLdZ41AlPL891SRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iknhAEOoWTuhaCHZfO5BmOXVvQtZihiF7vEAQ4k+PMA=;
 b=zF3e+jjrbu4OabpM6HhXnRQtOJa7bfq/p6uEC1OFKpuqB5Smsbus5+zvRaS6XnfYE1O8yWAFwUY+11myNEpwrDPHu+lu0mgfDA17stWrIR1xW/KAvEeEfeBAOtKF0WoBnlIWwWY4UBQOZNtw5Prc/9Frkvn61I4eNPp+2Hty09c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB4595.namprd12.prod.outlook.com (2603:10b6:408:72::17)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 21:59:08 +0000
Received: from BN8PR12MB4595.namprd12.prod.outlook.com
 ([fe80::dea7:afcb:c33f:eeee]) by BN8PR12MB4595.namprd12.prod.outlook.com
 ([fe80::dea7:afcb:c33f:eeee%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 21:59:07 +0000
Message-ID: <fc875e3a-29ef-4b9a-9d06-67085400393a@amd.com>
Date: Wed, 29 May 2024 16:59:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Handle deallocated VPGRs in gfx11+ trap
 handler
To: Lancelot SIX <Lancelot.Six@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240529193546.817200-1-jay.cornwall@amd.com>
 <8e841161-f811-4758-a279-fe1c1f261cfa@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <8e841161-f811-4758-a279-fe1c1f261cfa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To BN8PR12MB4595.namprd12.prod.outlook.com
 (2603:10b6:408:72::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB4595:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: e485b041-eed6-4670-31d2-08dc802a9036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mk1NU3Q4dENVRHFMRWR6bSszZUlMK2lCMnJodWdDamRkVkdOZnl3Ky9JRHVr?=
 =?utf-8?B?eERwaUNwRUl2MHlmN3ZUWGU2RG1NakJ2T1RNRDJGcFFJaEU3NkpVWlAvdFll?=
 =?utf-8?B?SzA5V3VkYmVNSjNueXUzQUwzblFzUWRSQkMrVzVUZiszVDNVWHREenB2L1NN?=
 =?utf-8?B?Q1BOTXVJcXBHQVlLQ2d5NldtUmp1cUtzRmduV3B1MlE5RjFqNDNFVitwenVJ?=
 =?utf-8?B?UzBZUU1UdDQxdmpseTg2NDF6YTBnb0NCcUpuRFR5TzVPTFM1RVptdGVDL29T?=
 =?utf-8?B?Skx6YzdnU0NYc2F3SWtTL0Y2V25YWXZvWGdLMDFXNGFTcXBmY1pLem82ckN3?=
 =?utf-8?B?TGFqRjMvK2tXUHVNN1JMMy9ZNmNXdlJvQURJVTRsUG9qSllwYk9QcnlqWmJu?=
 =?utf-8?B?YUVYTDRsei8wSmhjUVFPS0ZnY2l3TCtITWtMdDE2emE2U2daUmJmTm16bjVj?=
 =?utf-8?B?RGpka05qdGxWZTBHR0YvVDB3QU1DaVlJYTRSVmo4Slo2bTB4blhzUHhNWTlC?=
 =?utf-8?B?bWRKNGxyOHFUYXdueUdNK2VQSys5anJUeDEvZUVYWk13S2dmUi9lRTEvejhi?=
 =?utf-8?B?Y0RvWm9DbStOU1JrN1ExcVVJbUFlb3g3RXdkQU15TjkwWUtoYmdXa1ZWVkRn?=
 =?utf-8?B?S1E0TmNOYjVjcmlyclUzQ21GMHRZUGpib3owOFVXbW90MzZwUTJTMnEzNW42?=
 =?utf-8?B?SFhCY3VXS2l4ajBNd1dZOHprUkJJeDNrUVQycytoNkdraUlWMHgyMVVtOHli?=
 =?utf-8?B?dmtBZ1FpaU9GMVRRNmhwU2I0VVljeVZJeURtellVa2lBSUFSdVpURjgzYWF2?=
 =?utf-8?B?aXNxUGZXTjlKd0ViT2Q2ZWphejVTeE05Tzl0QmpHdU9nRmRsa3RFakRtb1JS?=
 =?utf-8?B?TjdSYWk0U0I5eHdXN0Q1ZnIvdWVqR1ZEK1pHTy9uaFFkUm5lSFFlclQ2aGk3?=
 =?utf-8?B?RHJKUUZPTlNxNHNhV3pYTkwzWGUyQXJTUlptc1FkeERRWlZtaG9wMHl4bFcx?=
 =?utf-8?B?UDZ0dkNjTlpnNVpZaWhFYzJNOVhPTDFsblpNM1hpcGRYcjJCYURaN3JCTHMy?=
 =?utf-8?B?TjN2bDQvOVdVbzExWkpLSlBSWEpiUUg4Z2ZBdTBIMjc1U3c2UmdndFd1TU1n?=
 =?utf-8?B?K0V0SDR3ZENidnJ2S0hEK05rSGlCWFVSMWJnRXlhMG56RFl6RkpyR2h2UlJu?=
 =?utf-8?B?ZW9JMy9jeVlzdmZqTHF1VEgrREw1OGljR3l4ZWhLbWdjdWY3Yk9md2VLdnpB?=
 =?utf-8?B?MXZWWnpwbUZVTysvbG1UTk1ZZ0dTYkFBYlEydEJZTXVac3VzSTBQUmxzeFZM?=
 =?utf-8?B?NHpmWGxVa3ZJNG5kY0gwUkZYeVFQZGFJK0gwTnRSNjlsWUlsaUxwNDhha3gw?=
 =?utf-8?B?bUluaGp6UFRQTlNidHZtZngrYWpGbHpPa3FLZUZzRDlXN3hIcjIyckdRY3BK?=
 =?utf-8?B?YmRvMmtsMXU5TjNwanpiTnJMWGYwaysrWUtvMTFFUEk5aFFnMUM4cWV6RElw?=
 =?utf-8?B?VTJ6WmVQWjlpVUVLSndhM2hWdkxRaDBNMEU2U3NIWlM3ZWt6VFdIVVVUdFdm?=
 =?utf-8?B?WXZ6VEVwdzhKVTN1ck9ZcTBWb09JNjM0NU5ZYS9zQzdzWGdzV3IzVEswRnNm?=
 =?utf-8?B?cFRNTzh4Y3NzYWNnQ0V6OVQ4OEdGNlRzeDg0UW03WGFQZmI2Tmg3Wk85LzB4?=
 =?utf-8?B?ZjZubWtyS0FYa2FycmZlV2RaL096aVBwdU5memRXcGl0YzNUVzZTeWNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB4595.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZxSEh5ZkJlZ1FKbEdUREovRXFRWFB2VUo3WG1MeHNCSDJkUkR1dWFOMGRJ?=
 =?utf-8?B?MElwV28wajBNRU5FdTYwL0RwdVNNaDlvdnBHSGs4V3Q5dHRXdW52ZGtXOXBp?=
 =?utf-8?B?a2xIUkorYnpycGwzL0hvTm00QWZnNms0V0pJSWRKWmNaWDBPbE81WWpraG12?=
 =?utf-8?B?aC80QkR4dloxVENGdGtsUlJHRWpFTGZmVk9jTkdrUnorOFpWQWNOUENpYVFz?=
 =?utf-8?B?OVZwWFM5bGhldFdhdENRVGZNRERJeXhMU1ArSDhkSWlvMDYybjN6VDJiY3cx?=
 =?utf-8?B?N0pGcTArbkl5T0ZMOCtGaWhKQnBVVkJVV20ycnZienN6dzBpLzV0dlhybSt0?=
 =?utf-8?B?b2RJLzBaMHN0a0x1bHhsb1VhZDBRdEZUMXhja3Z3WCt2VlQrQUZUbTlGbkVi?=
 =?utf-8?B?N2hyZEhtK09jcUp5T09yMXR3ak9WZ2ZSQWcveUswS0wwbnhZMnJrbXIvSkpC?=
 =?utf-8?B?Y1BEU3hyTXRWemR3cSs1ckl3a2w4UlRlemdyUkVuWTdqRmV2MW0yM2VjeDdS?=
 =?utf-8?B?NnUzRFUrc0I0ejVsVkhibVlWWC9ydk9zNjBReTlKMW5mMmRscW1NUGFzVkVJ?=
 =?utf-8?B?SU1Cb2xNU29PRFpVQ3o4QnNJRXQxcHh5cnVTYmJuQXZrcW05cjRzMmpVS2ls?=
 =?utf-8?B?d3ArTFk4NlZuMElmZEVPbHc4cFNTWWNrM0ZIYUdGV251MFE5dE9NRnQyN0U3?=
 =?utf-8?B?bDZtTlFrSjRqVFRWUW9iNEVkVUYvQVBLaU1wYm8yRThiTnRYcnUxOGViT1Jw?=
 =?utf-8?B?bU42d1M0OWVRaXA3bEMwYU5iRms2YXB4QTNQMEJJMG5sK0RsdVR4YkpsZXpy?=
 =?utf-8?B?Qm85OEg2cldKTytOL1RYSTlKRTI4UnRsR0ZiMmVmQmFPWUFiZzAwR3FOcTM3?=
 =?utf-8?B?RUs1dm8vU29uUGo5c3FXMkVQdGhXblRCOHhVbjF6Y01aTVZpNkxESmFPYzd4?=
 =?utf-8?B?WERjTFdNd0tDYUFtZ1BFWHZpM1ptNVM5Zlg0Z1BiY1o0VXpPak93WnR6eTF2?=
 =?utf-8?B?bnpFaEk4enY2djFLQzduLy83dGhsRTBFSktXQ2VTYUNKQ1pobTVHZ244OUFH?=
 =?utf-8?B?YUI5YzY1QTNXM3hZdGJ3dUM5OE9Fc283NXZ5VHJIZHd1UjBybWJ4eUdQazFF?=
 =?utf-8?B?MCtaL0hXVUhZL2hoYzgyQ1NaQldQY3ozdlBSck0vanlIbXY3aXlHSzF2SUpL?=
 =?utf-8?B?LzRFdVJBQkIvemorNm8zdVRhdzZYMlFwK3IxMVI0VzdsUVBhelBmRGRhNTl0?=
 =?utf-8?B?ODFsKzNzVVlpYWJReHNnQkJKRWJFSnhLZjR4QndjSjZqbDEwM2VZR0hSdHgx?=
 =?utf-8?B?WVpOYmFxbzBjb2IvVkh6Z1hKVFFiTXY2dWJRMlZqZFc2bldPNkFZSjBFbHZY?=
 =?utf-8?B?NitpdENtdUhmajIvQUhtdGxuU0ZXaXdhT3d2WGVjMUxDK3U1STc3VGNDTHJs?=
 =?utf-8?B?aFhyQWR1ZkZIOFVKYWNBbnQxNUZBWGdrdHZkSFRSVW1lRkVhQ2lONXFtZzRy?=
 =?utf-8?B?RXRYbDAzaGx3V3B3dHBtVHliRkgzS3c0Q0xobWRoZ1YxdERKT2hJNE1XbEpI?=
 =?utf-8?B?VHVqYlMzZ0pBQWxUMVlKdGdaRXhTRDJHNW5YV1N6TVBDelE2ekllNHY3RWta?=
 =?utf-8?B?VGc4Z2FzQ0kzdlkwaXJ0UjFYbXY2VWd4bFdPR2dpcUM4d3UvZE1SOGRXcHQy?=
 =?utf-8?B?L2RiMHMyUDZ2bWhJVWhva3B0Rk1nNFdpVTBXT0hHeTYyeW1iTG80aTZUNDZE?=
 =?utf-8?B?OXpEZVVxU1NaTWIvQXNEdHlwcEZQUnhQOS91ejNGczY5SFBKVEFibzZlUU9L?=
 =?utf-8?B?T2YyOXhCUlNQT20rVURjLzRHVHRXbktZV1BMdEtlZnN2bjUwdXZpeUtXT3Nr?=
 =?utf-8?B?YmJnZmxqUVEzSHEwVHQ3RFBNQS9qY3B0VzBVUTdyeklGMWdETGlrL1dVa29U?=
 =?utf-8?B?SWtrdmR6RzkyUzRiVGhmOGtuSTQ0NldOVUdDR3JQMzlkb2NBTm9XNlFPNThB?=
 =?utf-8?B?S2kzTzZNT2tKRERJd3JFMkVQZzB1YnllVkhDRlQ4ZVZLYUdLR2NzNGdYM3lS?=
 =?utf-8?B?RjVWUUVrUlg0aysrR0gvaHRGRjhXVlZ0RDhKMHJSTWI4cUowd0pHVWtKRkJU?=
 =?utf-8?Q?fi46iDdJCrGZ3egqL+tsEn99J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e485b041-eed6-4670-31d2-08dc802a9036
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4595.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 21:59:07.7424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xW4LPVzcB71tiu2gw7QBafsJ01JRRCiSe/iaKinfcjGZh1HH3lbqseSOez2WPFTnv0tfT9C9epRvzPh+/qzfJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
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

On 5/29/2024 16:07, Lancelot SIX wrote:

> On 29/05/2024 20:35, Jay Cornwall wrote:
>> A wavefront may deallocate its VGPRs at the end of a program while
>> waiting for memory transactions to complete. If it subsequently
>> receives a context save exception it will be unable to save,
>> since this requires VGPRs. In this case the trap handler should
>> terminate the wavefront.
>>
>> Fixes intermittent VM faults under context switching load.
>>
>> V2: Use S_ENDPGM instead of S_ENDPGM_SAVED for performance counters
> 
> Hi Jay,
> 
> Thanks for the V2.
> 
> FYI,as far as I can see, the .h part of the patch does not seem to apply 
> directly on current amd-staging-drm-next, but I guess we just have a 
> different bases.

Sorry, it's parented to the commit below. This has been submitted but is 
working its way through post-submit testing.

Thanks for the review.


commit d6449614e21cc166f888b3d5fc59cd1156ed7e7d
Author: Jay Cornwall <jay.cornwall@amd.com>
Date:   Thu May 23 09:00:28 2024 -0500

     drm/amdkfd: gfx12 context save/restore trap handler fixes


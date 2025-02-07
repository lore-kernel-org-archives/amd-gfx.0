Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B08C02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 08:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3F610EA69;
	Fri,  7 Feb 2025 08:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FQ8wKhU/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A5510EA61
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 08:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bh+dgxUI0TZly5w5yAWnq7qRtiG/X94G1cC73/ti3EAPu7cp6Ju+hA2IMaofxnAugMa2eNYd0kECexb2uQpfcgYUONxJQfJaDR4GycvIrYwu9XJbC9D7hGVBMbr9hZY7pHQXVC1/TzdNBMqXnf8Yk779+Cjmagdo1i7E65o669Sax39CanZYLmTc3dLgJcrDAcPs/CP/ECjYint8ZRfWsU5SeuC8yGSt3+sE+K5cO3h5DgnOebmFA1XNmqN5Ol10VgXXUUpRd9ZkKsPW9fLilJQhd8zHsAPbuqFEjQ4U15DaRB4q/tgh9/iIt1Au3QsLKmmwxVqsnfbtjyzGiI9K3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPqutiMJDOVGib3maWvEioMLCG0lxE+idlAUB+nc2VY=;
 b=W02pgEMBRoozVq2oHaZOMXtO6ZIvhqd0Pi6bn+ELJWVGDkutZhJbMSiGepSndr23W5pmla3dSPHzrP7CDJSRXzT0LcsaspYJM4kdbYSOtclOz7lEIkWVzIeyZAW83s0VuaoK7VAplNIq305Eb1CoLVSIyRbVgYvspVHsT3vkVJokFiuV/UVU6z840X9qtjjvHDlI45zRUX1QAV3lJq2kpyxga4OzY3OumokDgOUn+eVtAm/thYV1VX2UEfSPIeoTwUuDtAmNLohxA5DGAqfJapVhYmtbhOqEST42TWfvklT8hjJg8f+ZtQi1H3luEdpMFQve0YZ7NMQg3IGVkbkhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPqutiMJDOVGib3maWvEioMLCG0lxE+idlAUB+nc2VY=;
 b=FQ8wKhU/FVTnNC3jkof/+wOAPCYcR9HNzkS/QPLk52A+8GSJZ6Kfto7KBUaeRQM2dFSU/W6Xc6NKWgpJ2J+gYd6MGL6VXDYUyqp6zKTUib8mEGlfI9LRRSiow+WkvwEhUHrAoo5nG3/HVx+siY+WcxqX9cnGajJX6UY7VuWaeGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Fri, 7 Feb 2025 08:34:51 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 08:34:51 +0000
Message-ID: <251b979c-2f22-4da6-af64-1bdbb8e35054@amd.com>
Date: Fri, 7 Feb 2025 14:04:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 2/4] drm/amdgpu: accumulate gfx_off_entrycount in
 smu_suspend()
To: Gerry Liu <gerry@linux.alibaba.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 "Koenig, Christian" <christian.koenig@amd.com>, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1738910203.git.gerry@linux.alibaba.com>
 <9253f9f4144fd2e126e6b7307c63eb75764dce21.1738910203.git.gerry@linux.alibaba.com>
 <f751810b-a238-406c-a03c-9ee290692ed0@amd.com>
 <AE910E1D-A1AC-42D7-B865-97B272036EC3@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <AE910E1D-A1AC-42D7-B865-97B272036EC3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1d8f64-ba3a-4298-5251-08dd475249a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUo5WHRQalNuS2I4OWRhR0U1WkVDNGlBYVNWN0dDandzendha29OS2dwUWdP?=
 =?utf-8?B?M0h6TGR0eTFBVHFVaUwyL3VpQ2htZXJZRnM3dGE0RzJmQWV2aEdTcXVzOStj?=
 =?utf-8?B?akVvb2pOUWJscFNLS0tmQlZGaEw1NHdZRzRnVVNQRjR2QWJBekUyT1lTVDYv?=
 =?utf-8?B?Y2EveTlPL2FBY3g1TFNraUtVaHRmQnpibjVRcUdtNEpWbUM2U24wRGpaZmla?=
 =?utf-8?B?eUx4MjRFUHVZbWwvY0dGOE5aWi9JZmtSd3dqZVo4RmJ3QmNZQ1ZSeUpxV2Fk?=
 =?utf-8?B?QUhiSUl1K1I0L29oYlNNYnFjem5Uc3pPSHZFVmsvNFlvamhlRCs4dG1ER0lT?=
 =?utf-8?B?cGJSLzgyckZZU2JZSlQ3Ulg0UlI5MWFyY3R0ZW5paGVXNlBhMjk2NllvMWNy?=
 =?utf-8?B?VHQ2ZHRjNWd4NU1LQzVzUzNaUnVuQlBTaG05cFlxanljTDhjcStIbXQwY1BE?=
 =?utf-8?B?NjBLZUN1bUx3TFdLRUNUUUZoNGx5NEtTMnJERkd2RUlWd1dpZ3dNd2JSUlNN?=
 =?utf-8?B?SXJ2UUFvVkhoRGVwSW5DclpZQ3Z2eWFPczcyODlrRmdnT1luWmozZ3luajNo?=
 =?utf-8?B?UVoxKzFaaVFvK1k5bDlIaFpZS1lGUVQ1aVhQb2lZekdGK0w0RzRYUW9JTjh6?=
 =?utf-8?B?dzZlcjJ2MWlUWXlBSitDSTdNMFdldkw0ZU9oa1NETnh2SU1jdFFXNlFEOUZ2?=
 =?utf-8?B?akQxUVhUZEZOWUhEb0g3czRnVHU3R1V0V3ovbDdRcnhOMHhObTQ5QnpPY2Nq?=
 =?utf-8?B?SisvYUpJdlB2WEx0KzRzWG5jdWZkd1dGUUgzVFAyOG9rNWpGNHcyZ1AzTVUy?=
 =?utf-8?B?M3pOVm8yR0FxZ1ZnMnh3OFhmNkVJN0hoQnMwdWZvd1FBSkZPRTVJQmFtNit5?=
 =?utf-8?B?RDZZaENiV2p5aUVrT3ZmcHJsMGtUVHR2aGVDMWtOS0RMWnpQL1luNHQ1b3Vz?=
 =?utf-8?B?dGtaSXhSbXE1OXBnamxlMytwUWg4WlUwdUs1TFpXaEdIemRPOTNpK1JDV1BP?=
 =?utf-8?B?V0Nld3ZTMytVQ3RWNFVzTjdvYUdFTnBtRzgvSCs3Q0NPZk1PbTlUTnFwVC94?=
 =?utf-8?B?YkZVNDBEVThWRGJsOTVMMU54TDRwU0Nvc1ZuSE56bkhxeGdaMUlZSFdNZll6?=
 =?utf-8?B?S21VSDRpRVNISng0U2VBOTFJZnNIcUNVLzVibmlRaVFEWndPbzQrbGw4bDF5?=
 =?utf-8?B?Qll6dk0vLzNnWTE5SXAyVlB6OFIzbm9MTC9WLzNISENTU3FDMGYrMEdLYlZK?=
 =?utf-8?B?eTRmbzJDMmtWMUVpMTZ1Q1pTN1g2UEdadE9ZVk1HendhNFdYZVE2UHh4cFVJ?=
 =?utf-8?B?RVBvbEdKb2VBNmZjQXhnTU5yY3lIWG9ab0pVaElkYy9GS3I3MDgxSUtOOWll?=
 =?utf-8?B?dEJDZFZCaDREeGJvRkdUam9zVkNvYjJIQlF0WnpJQzV6anJhRWM2VFd5a2xF?=
 =?utf-8?B?YUNVQ0Z6cHo2aUNwQVJocGhQRmFCTzcyZXhyWTltZVNrOTZKVWJGYnpEcjBi?=
 =?utf-8?B?RzJrWHdvQXBDdjhQcDBiUnZuK1RpYXRCeUMvZm9CaVVuQ0lUMDNVYkJMU21h?=
 =?utf-8?B?T1VBYm5xa2U1b2tMZ0NLeE5KaFhPQXhMenRoWUd4cjNsMjNRVVR5UmFWbHdz?=
 =?utf-8?B?YlNiNjkrWXAwWnJDaFNpN2Nad1MyRkFoQVNxdS9VYVRXRmdzN3F6K0RydW1L?=
 =?utf-8?B?NUo3MXAwcmV2UGhwVUFiaTlRWkh1ajVXdFBaMlYvMm9YYStKWk05WDd5QWwr?=
 =?utf-8?B?d2V3bG1iVlpRc2ZGRGtHV3JmRXpnbGJrWERkN043SitOTFZYaXZaZ2sxMGJW?=
 =?utf-8?B?U3dqVWRQNW8xZHFNOWVPaHNHU2c0aXpxcDYzWmpLK01MazZ6UEg1UXBwUG1u?=
 =?utf-8?Q?1EHFBTu4xWz14?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJvVzdxSWNkZU5KcHNtY1hjQ1ZGU2NMRW1FRUZiK3dKZTcrTStLMWdlVnla?=
 =?utf-8?B?aUJYZ0dhakNiMWhvRTh4Yys3aHIzRFcxQ2F5NkRKbzNhMnFPVndTK29VS3V1?=
 =?utf-8?B?UjZIaTRMd1ZJYThJUEJxaEZCcDdKSDAwcFJvcVFoS2JOWUhaQytEaDJJZkdE?=
 =?utf-8?B?VjhrbkVMVUlPOW5mRUtybWJzeWFIdUZkT3FqcTVmRm43STNSUjk5aDhhU3c2?=
 =?utf-8?B?MUdQZGtKSU1xclltZmhGV1dBM2p0ZytHbHVSRWNtazExMkRad1dueFBndFpo?=
 =?utf-8?B?TjcyaHdlSnV1OVFkUlZvV1k4bmk1ekY5eUhmdkY2V2RHMGRzWS96a1ZhOVpp?=
 =?utf-8?B?Z3o1dTFsYkZzS1p5TnpnMkFWQmQySWpKdENSY2FmSE1PNEM4bE9ta0dJWGhE?=
 =?utf-8?B?WHdXeGF4dU9TVVNyZC9rU1d4a2JzMEtmMmtES2YyQ3pUN0R3ZXpsdk1YQXN5?=
 =?utf-8?B?MkNLa3RDbUVITDR5Rlo0TGhzNE9yU0kzc3V1bVR6cEdmSVUxcmRrNXZGK00x?=
 =?utf-8?B?NEoyNkJBMWViS2p0eWR1bit1aEVCaGRZY08wTDBtOTZmMzRIU0p6cFZnSE1k?=
 =?utf-8?B?c2tUVXJML3RDMHVoR3liUXBpL1l3TjRvaFd1R1ZBRVAwMCs5am0yWXBIOE5S?=
 =?utf-8?B?dlJLeVdIREFMZWN5VU5hejhvR0pmR0V3VGxrUzdaampIRmRjTERlRmdPRkxO?=
 =?utf-8?B?UGJ0Qm1KT2dkUU1tK09URC9jMVhzNVIvNTUvTUhxWXFWKzBDMGV0bkM1M3ND?=
 =?utf-8?B?Zm0rVXRmSnJvSDc5Y3JuQU1jQXY1WFVRekNLbjg1MHpXOThXR1NscjZnekVP?=
 =?utf-8?B?R1NobEZUenlNMnprU2s0ME1tTXBKZlJ4ZUJIelVjUUw5K3RFMVhHcE0yelVL?=
 =?utf-8?B?QmRjNlhwNWtaSHpxd2pOZ2tyeFptYmRjT0N0ZU8xRms4bkZ5OURZanA4Ui94?=
 =?utf-8?B?cFJwcDZRZUdpbjFPdVpWTDNLU2hza2xnWjJURE1HaGR6Tit6b2g1VEdBblZX?=
 =?utf-8?B?dFo4TGR1NlZTenpmbHJBaU5wYjhVZHVVK2NmRGM0dVR5d3pjSmdmbTlFTDE1?=
 =?utf-8?B?NU0rbjlnRlJVVHIzU0Zoa0tMZG1Vdkh6eVdiUHd2MFltRkM2eHIxS0dwdjNR?=
 =?utf-8?B?cWJRL2ZCcjVSVzAxUUN0bU04d3d6SGZ5RjJiNG0yVXZabWgxd0ZZRjVxRk0y?=
 =?utf-8?B?aWVkWFVHZEFQWk5QbEg4TnpPdXhUOXNZU3Z4eE1LUENFMkpLVExTem5xblhl?=
 =?utf-8?B?NXpUVytwMG12eGFEaXF1TmVZWFRzSmJlOFVwWHdsL0haTFdZYUlyYVRINUdU?=
 =?utf-8?B?RHQ2WkUwZC9MR1pIem9zRUovOXRvT2gwcWFiQzd2Zno3aGQ4ZGI0bmp6U2ZD?=
 =?utf-8?B?aXgxS3FOWi95UzdWVlNRa2g5Y2JoU3lMa0hmdDhSMWhyY1FNRVYwOGNCS3ZS?=
 =?utf-8?B?R2R1NTUvTWMrQUExeUtWM1VYcjZJZ0t6aHQzbXdGaDVyRmxMbVd5WGVMTG9Y?=
 =?utf-8?B?SUhxSklqemlldnp1alZJQ3ZTVitlNmx5UFVCQ3ppYXR4OUMwMVVTL0ZPMXZ6?=
 =?utf-8?B?Y2NoZGZjakwwWE0wOWZnYUFTUzRIMHZISUs0bFVwOFcvZi9CL3pVTXZOVmxN?=
 =?utf-8?B?T0lCNWVSMXY1bVczQ2EvSk5rUlJQdzQ4MllSSkMvMDhCZTI5d0FWYUppQWti?=
 =?utf-8?B?bjJ3aGxidmRNUThjWDR3ZVEwRmttQ24xOE4xVjQrUzdvN2YzNnJHdnU1aTdF?=
 =?utf-8?B?anlRQ25ja2tHSTBOZ3d0ZDdoQXVNQWo1eEROdkNFT3ZSL3BPenVURmxjTitq?=
 =?utf-8?B?bDhvUVduYlVRY21kcURFMGd6TFZTQithUnJvWEJRNDFBalhmWVhuODQyN09x?=
 =?utf-8?B?RDlOazljV2ZTZDZoaUVJcXVBSnZPUTRHWS8vMlZsQXFKbW5JWlJOekRxYUZG?=
 =?utf-8?B?djNtUVVidWdNYU5zQXZ6VFM1MWVNZU9zWXNUR3UzZFhhb2dYcEhxV01OdXdE?=
 =?utf-8?B?SUw4bHplaW5sTDhzQTEyUmlPdXpYYXRVVW5UWjg3QmhFblhBcDQzQ1A4UlRT?=
 =?utf-8?B?Smo5VUpzSy8xNGJNZkZVQkZTVkdQSXVOZ2VRN0ZNTWpXWDFPeC9FdjFkR296?=
 =?utf-8?Q?/92Mn2CxfpX1ReKT4pR59HbaA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1d8f64-ba3a-4298-5251-08dd475249a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 08:34:50.9043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o26XwPd5wG1mAu0NcNMTQiFwnfFsPy3WleZrKCnoUKx+fQpRX7je6z7tJP2/YXn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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



On 2/7/2025 2:00 PM, Gerry Liu wrote:
> 
> 
>> 2025年2月7日 16:04，Lazar, Lijo <lijo.lazar@amd.com> 写道：
>>
>>
>>
>> On 2/7/2025 12:14 PM, Jiang Liu wrote:
>>> As pwfw resets entrycount when device is suspended, so we should
>>> accmulate the gfx_off_entrycount value instead of save the last value
>>> of it.
>>>
>>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>>> ---
>>> drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index ed9dac00ebfb..70a5ab649e5f 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -2134,12 +2134,12 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
>>> 	smu_set_gfx_cgpg(smu, false);
>>>
>>> 	/*
>>> -	 * pwfw resets entrycount when device is suspended, so we save the
>>> -	 * last value to be used when we resume to keep it consistent
>>> +	 * pwfw resets entrycount when device is suspended, so we accumulate
>>> +	 * the `gfx_off_entrycount` value.
>>> 	 */
>>> 	ret = smu_get_entrycount_gfxoff(smu, &count);
>>> 	if (!ret)
>>> -		adev->gfx.gfx_off_entrycount = count;
>>> +		adev->gfx.gfx_off_entrycount += count;
>>
>> This is slightly misleading - only Vangogh implements
>> get_gfx_off_entrycount and its implementation,
>> vangogh_get_gfxoff_entrycount, is already doing something like this -
>>
>> *entrycount = value + adev->gfx.gfx_off_entrycount;
> 
> Because we have not restored the hardware counter by writing back the value on resume, adev->gfx.gfx_off_entrycount only remembers the latest value of latest suspend/resume cycle. And history information is lost, so changed it to accumulate all values.

What I meant is that accumulation is already done in the implementation
side - check implementation of vangogh_get_gfxoff_entrycount.

Thanks,
Lijo

> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> 	/* clear this on suspend so it will get reprogrammed on resume */
>>> 	smu->workload_mask = 0;
> 


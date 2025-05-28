Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1157DC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 21:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CB110E642;
	Wed, 28 May 2025 21:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k1uEkkcU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E3010E642
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 21:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgch2TWr5fz1XMrdglgjMyrttphWkaPZn+appMe8czVknpoZe6JKfwGXKCltgNV5Y6RTx1x+aNEkMOr4/dmmLEYi79y9N/aXqw7e2VtMiYaMyziyYZ6dXzpPoHIi0wPH2Kyd1rAoeSDyT4M9t8Nkoh4WJIvzn4npEvyT0PTatdY6B8qdWWNbxWd2XgkBrwO4NkZ93nUvtZ6r9obO0S5YW2ZaxEgo2FeAVAeIcAFjw2MfNAOCDm6g1b+GnGZh4vC1q54/GREer+28tNhBytU39ce5naQc30kuRV9dr5SHbhKPMAGjkqHzo6CWuQSQRqIummqQW26hA2IfhVh04x2GKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69CfHKi5ruKR6RMHpntVTGOk4F+DXW3ZEyF1tjDdjNo=;
 b=Xtf+s3RQnyJ6QW9j9lvg3yMU5vWDqPVnWb22Nx+xfzwAHDH4ca/EEOLYKZnt2sjNaPK5SLCY+sDeL/Ryh8r/93SBaycWtPL6gi0cvIOeOuA2C/y3JDmI3wUds1tQhdWOXBijtgr0jUvjqxiK5CRdk/far2mIgmFt7yCv2vZ0d2cNWak3tb4iK+WjWUNf5LaU3uQ6EuILwhuhq9nAFwuBENAkMMi44aG0idJTRLVC3qRv21eimVMJ8Cji6LfA1XckjiO1jBJumpsiKKgAn3ZhWeeXZeIScapWFur3uazNFTE6wsGFtE3gx1u1ffBqqUQAH5o7Wc8SPaLcFFa3P59lIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69CfHKi5ruKR6RMHpntVTGOk4F+DXW3ZEyF1tjDdjNo=;
 b=k1uEkkcUKnx8vFNQGv/ln9agS82pD8znyYAm552e3KwRYWJDFA7p7k3ZFg9CuFyVAOzrfhrpzQOfVb6F137j1bcJisqJUFv9UzMxBYV8IRP4rK2a0tSGln/SXyAWcHLsLYqTAiquKy7UBH5lfvk9Pi61QMwoy50oLi0y8g7wF2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 21:22:34 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 21:22:33 +0000
Message-ID: <6fc24340-ab05-cb66-95f5-4b496a21c365@amd.com>
Date: Wed, 28 May 2025 17:22:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix kfd process ref leaking when userptr
 unmapping
Content-Language: en-US
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250527153517.14533-1-Philip.Yang@amd.com>
 <CY8PR12MB7099E100E85B3FD1377E3DC88C67A@CY8PR12MB7099.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <CY8PR12MB7099E100E85B3FD1377E3DC88C67A@CY8PR12MB7099.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::47) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a747c33-9668-43e8-b58c-08dd9e2dc2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTBTTFZ5R1RMdlB4M1k0Yi9XeFJFcEtxZ2lTOGFxTk9FUytXRElrYzZFZXBo?=
 =?utf-8?B?RWY2aGJlQjYrNGJraE91ZTRyOHVyMWkyaUtzYnpESTVjYUdQTDhrK0tndGhu?=
 =?utf-8?B?dll2NVpvemJtMklXOEx2KzI5bGc2dDJtNFFtZnRCano4b3VDMjc2SHp2bm9P?=
 =?utf-8?B?ZVh6RGhJOU44blJkaEgwQy9ZejlOWTlWQ1NHS1FZeVczOW04VE1qSi9Ra0dy?=
 =?utf-8?B?QWttajRvdk44c0VEZDRQTm9RUFNZelRyR3YzcXpNYjVydUJaUDVpZDZLV3Nt?=
 =?utf-8?B?TmxRbllmVW5IbVJxVGlpajY0SUNYY2ltQmxzcDh4TWxIWjFjUG5Fd0pXYjlF?=
 =?utf-8?B?dXRndmJ3Q3pHTkFvMys0Rm5Ud3N6cHRxRzJ1OFpDbHE2UWR0UFJqbGh6QjB4?=
 =?utf-8?B?aENJRGxIOGYvb1JvckZ1N2lnckJPbThyQVRicVBpcGk1TFBkUHRvL3Q5d3Vi?=
 =?utf-8?B?NjVNZHRHajFYS3VwOS9DUGY4OHVkTkpkMWhGNTVPcWZ2cXgxYnp2MGg4dnlO?=
 =?utf-8?B?UmJ1cWlaUUtyczlIQVk5dTQvVnlURkdWNTdPeXlmNmJWMm1nSERRdTBrcDVh?=
 =?utf-8?B?dEdvM051ajNkV1R2ZXZiV1o5NXovbnk2eDJWQnl0L2o4M3JwZUJRVG43am02?=
 =?utf-8?B?QVZsc25FUWpVUzB5aDJxaUdyS1l0YmhGc3RxazNaV1VxSWlFdFdlT1Jyb1or?=
 =?utf-8?B?V0txVXh2RFdoaFAxeUV2NDE3K0JaZDRUK2QvS1kvSkQ4SVNZY0pZSDVkWWkz?=
 =?utf-8?B?M01EVU95UzdtaGcxZk92ejhrY21FRVN2R2VRVXd4ZDc0ZXhkOG9xY1B6MXRY?=
 =?utf-8?B?c0YvZWo5em5iRnRuQ0lCeDE4cC9HUHpQelc3STBhaHg1RGpGL2t1Z3Q1UDNJ?=
 =?utf-8?B?SWJQRUZuajdHNkhuNlM3aEc4YW1nODk0eUxDVkhpelJSWFc2Y0w5R1JHYkRx?=
 =?utf-8?B?MFhyY2picDdwTVRaUFY4aHlrNGlOcXducFZUcGpMNWNvdUhYdGRsRS9Vd2hZ?=
 =?utf-8?B?bDEvKzhyR0hJeTduTDJRN1JmektQMWJtZE5NQlhkS2xUN0tWTklaSGJSWlVR?=
 =?utf-8?B?UDRCKzU3NElGWncwbFZvUzhlbEt3ZUMwVE9Db0xBNDJ3dlJyYndZbXY0UDBr?=
 =?utf-8?B?QmxScFBTSFFSWFpidWxhdXVHLzJPc3pQNStTekhpcm53RWdUVlpaVjdxMXpQ?=
 =?utf-8?B?VmdVdElzRFIwcXRwZnl0ZitGZWxPRDNPREJjRUtOYUc2bGtsdlM4RG10cThm?=
 =?utf-8?B?UFRuTnZFZU44TkQ1K0V5VCs2OXg4VmdsVFhBRzdWSmxCUEVUajdkL1V2cElr?=
 =?utf-8?B?SGtFS0NwRzVUTkZsZjluSmNFdU9ZZTk1QkNybU5HK1IyZzZXdkxpbS9Ra253?=
 =?utf-8?B?R0QrYzhVK0I5ZFF3R3J1c0hXNzBDbjRpd0dsOEx4Qmo0M2IyeGlmWldzaXJn?=
 =?utf-8?B?U1R0OCtGN0cvRFRyejQxelQ5bDFJcVkyK0daa0FLQXh6SlZPUTBtYkJPdzVk?=
 =?utf-8?B?RzZRc0E1K3BaSk5EMjZRQ09RMytUSmwzNDNUdGxiUEYzaktPbm1ocURGd2hO?=
 =?utf-8?B?Tm56cFY0ODhXc0dOWCtIZWpTdXJGbUxoL0o4bG51K05PQkFYM2tWWnZpZ29Q?=
 =?utf-8?B?NlgrR0dzaG1XV0YrQzkrVUI0dHltQ2JUV0F0VkdQVnRmRzhKQnkrMGUrV3Fq?=
 =?utf-8?B?L1MwQlA0TWlyN3lxOXg3WE45MEFnWHZ6T2tXOGYvcklwek9JVnhTVGF5TTIv?=
 =?utf-8?B?ZVpYOVdSemQ0M2lQNEpMYnhtOUVFUTBlbStpT1VHOGJyZGtLMnUreU45aUNw?=
 =?utf-8?B?UDFyVVR3Vk9Pd2JDQW54MEZFQlFqQmZkQk80ZE9ONU9udFZFWmRwbTdLa0NT?=
 =?utf-8?B?OURxTmpPZUpxT1hwdXV5YXhvY3lHV0oyVFI1QVhGZ2YzOWdybXFJckxxKzRT?=
 =?utf-8?Q?rxnc1rhh/uM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3lKalVpZ1lVeVZ0akFmVUxSQXdmUHBFRTVqNmdldnpKZ2hjNEV3SWNtLzlS?=
 =?utf-8?B?Rm4zbk1oNm9uQ3FUVVhyVDJxMUFXM0tMM0xiRnZ5MWZJTVBKK3IvOHhEL2d5?=
 =?utf-8?B?UFJrNTFibGdnOWZGdEdLcUJvanN1WEpFUHczT254QmxsWmh1RlVFSGcvb0lV?=
 =?utf-8?B?bXc3U0IxL2diMjhLcTY1RXZmK25KTjV1NGpLVVpHUzgxY2Naak91NFZPVURq?=
 =?utf-8?B?c2huVlg2clM3VnF5VXFXYUZxb2NyZUc0by9RNTlWRFFWZStDNDJpT2svTE5H?=
 =?utf-8?B?bW5SeEdoNHE0UFQzVjBvZDZJZFJ6aE50eGVlTHVmL28yaXlBbjE1V29kdXBS?=
 =?utf-8?B?eS85dm02dHVyVFNyZXJPYmpldDdzeHoyMEVCRnlqdGFUNWc0anRJQ200TTlG?=
 =?utf-8?B?Qjd2T1NlcXFJUE5TaTRZVVE0eXlXVGp2MytxK1drUTltNVlmMVVyOExiVU5X?=
 =?utf-8?B?QWFaZDlabUhBd0JrRXUraDcvRnBpK1FyeWVzMEk2NkRrekFnYWtFaWVtZklN?=
 =?utf-8?B?YkJIZHZ2ZUF5cm5YNmVuVkpzWUNHUDFQWHYwZTByQ01zTzd0MHhrZ2s2TTNj?=
 =?utf-8?B?WkY0Ni91ekV1RmM5SmIySnVucEpMS3Y0ejJDcFFzK0FyT21GUHlDd0tSWU9V?=
 =?utf-8?B?QWxncnhsQXJBclc5RXEvWjBWQkF3eHZ6M1FZR3RTWDhIT1ZBczhucXRBbU5W?=
 =?utf-8?B?TDhycE5UUkpSU3d3Qk00MDdFRHppQzNFNEF0eVhyMDUrT3BGSDg2YUlQNGti?=
 =?utf-8?B?R1N0RDJJRWt0VzV6WXF3RzhoTWl6b1kxalFTS2pZd3FnL1pFN09BZUhCUW0r?=
 =?utf-8?B?N0Vob1R5Q0FuNnBhS3ljWkJtZ01XQ0x1b2lYYThvWUdYQzBBT2NVb1hUUUc2?=
 =?utf-8?B?b2lHcnRnWDlXdjlrMDJwUmFkbXNhNWpQakhLa2RWUDlHQjgvcXVQRkhOZU5Z?=
 =?utf-8?B?RkY0eFY0QUpHVHpwL05KZmUrTzZORmY5eU1hQnlieGdsOWtMc2xFM2lOQ2pp?=
 =?utf-8?B?TnR3OGhtdkhTUmVKOWgzTVU2aVR4dEhVWlc1dEVyazRzVTB4V20wa0RCSHMw?=
 =?utf-8?B?OERTNi9YOEYzcU5Yd014bWtjL3lJdVM0Wk1IcDBack1mUG96Z2duSlZtbUov?=
 =?utf-8?B?VkllRExtd0dwRUE0dmhTU1FjLy9Ka3kva3ZEak4xZm1RaTBMVW1YbmpaeWxI?=
 =?utf-8?B?VHkwYm9FcTh6NjlaRGZybjJMWjEyNGJjNWpScHdKM2VRd1BWOEpZZ0VSeGor?=
 =?utf-8?B?V0ZSWjZwK3Z4T0pHbjhQbkZaMXduRi9IeEVEOWdqUXlzcldPUWo4TlRaUVJQ?=
 =?utf-8?B?MlZEYm15cmN0bnpoSDFtay8rWjNXc3RCME5pbTUxOVdxZWg4a0VnQnJyaEFl?=
 =?utf-8?B?L3dMYTJ6L2NtMnJBMjIxNHVZRXkzSW1EYUcyNHF1aEFHUU5QOHZpL01Db3lk?=
 =?utf-8?B?ZW1rTnpMZmRHaVNOMUxXQmFFalRKeW4yeGRSNW5kMng0bTlGL09YRXpsT1ps?=
 =?utf-8?B?SXRVazI4OHNpT2E3WW1PeWRwWkd1YWhxbU5nR3dRNlFxc00yRFppQk10V3Nk?=
 =?utf-8?B?NzNiL3N5QWtORmRiK2IyZ1RzRDV1QmxkUE9LOFZBVjhVMDFQRWsvYktiUG50?=
 =?utf-8?B?MTEwWm5KZTF3T3dQSFBsQVRoUlcwd3JsWlM1WWUzck0yNVdDcmc5SmhQZlE5?=
 =?utf-8?B?N3NqUnFnMXU1SVRQMVdnZkNHbUxKU3pWSTZLRk9YUXMwaEowZjR5YTBxaTB4?=
 =?utf-8?B?QnVGRElDak9PS2FKWGtOc1ZLUUd6dkFiRFRZcjlDRyt6YlBORUFKWm10SGNm?=
 =?utf-8?B?QldlRGhQbVpBRmNYQ1lDTlRBemNqZlJkNnVXSFMvY2g1N3lLZUM5TjFXcTM3?=
 =?utf-8?B?clVWTU83c1A0d1ZmTUNPa2NmazY3RHBBcXM2SmMrS3RrcWxoYlUxNEFzZTBk?=
 =?utf-8?B?VUxNeHJ0Tno1a2VFZXhkSFR5R3BkQWxaY2U4bmFNdTJuYlY3NUh0SG12YUlT?=
 =?utf-8?B?OVE5UG1JU2lFWlNvK015NGxjaHdjdlNFYktxKzdYOERmWTlwaTVZZ3dXaEg4?=
 =?utf-8?B?bHhCM3NmcHlYMGlhQlZXMGZnNXR6aUl6VSsvYURmVjlWTndXaEQ3Yys3b2ZB?=
 =?utf-8?Q?Y3pCpvAaUrwr2fvo7gtQ8tdXO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a747c33-9668-43e8-b58c-08dd9e2dc2f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 21:22:33.9063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHeOJUcgERQJdOcLx4W+aUdTyZZJz6m6c0DdTqMynVbXfwCO7LNfGOHlj9pVmkXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
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


On 2025-05-28 14:24, Kasiviswanathan, Harish wrote:
> [Public]
>
>  From the code, it looks like you want to hold reference to the process to ensure that it doesn't get destroyed while sending the fault event to user. If that is correct, then your commit message is not reflecting that.
>
> With commit message updated, this patch is Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

calls kfd_lookup_process_by_pid() as function parameter increase/hold 
kfd process ref, but don't decease the refcount, then kfd process 
refcount will never becomes 0, the kfd process left to hold/leak 
resource after application exit. NULL pointer check is also necessary as 
kfd_lookup_process_by_pid() may return NULL pointer if app process/task 
is already destroyed.

Regards,

Philip

>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip Yang
> Sent: Tuesday, May 27, 2025 11:35 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yang, Philip <Philip.Yang@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix kfd process ref leaking when userptr unmapping
>
> kfd_lookup_process_by_pid increases process ref, the refcount is
> leaking.
>
> Fixes: 7a566d7f56f4 ("amd/amdkfd: Trigger segfault for early userptr unmmapping")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 260165bbe373..99a32bc9bb89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2563,12 +2563,17 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>                           * from the KFD, trigger a segmentation fault in VM debug mode.
>                           */
>                          if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm_userptr) {
> +                               struct kfd_process *p;
> +
>                                  pr_err("Pid %d unmapped memory before destroying userptr at GPU addr 0x%llx\n",
>                                                                  pid_nr(process_info->pid), mem->va);
>
>                                  // Send GPU VM fault to user space
> -                               kfd_signal_vm_fault_event_with_userptr(kfd_lookup_process_by_pid(process_info->pid),
> -                                                               mem->va);
> +                               p = kfd_lookup_process_by_pid(process_info->pid);
> +                               if (p) {
> +                                       kfd_signal_vm_fault_event_with_userptr(p, mem->va);
> +                                       kfd_unref_process(p);
> +                               }
>                          }
>
>                          ret = 0;
> --
> 2.49.0
>

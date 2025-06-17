Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA04C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 09:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C226210E1DB;
	Tue, 17 Jun 2025 09:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mh8yFAKq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7515B10E1DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6yegmnXCnNkMAOXUqQtFt7SBzT2MjRxRqW89QtrVwaJL3wscx0daaTCJb8BzUjvugqkk1XnTuKORbGvsHHQvNmT324dFUibuq0ZABQo0AhlgM4UltJjp2K7zv9OGvkjUhU1HuuY43dheaPS0ciuAVe73EK8xislpRPBxcavFlWdktBgM39oaQGBDtMBNy7vNfyRyYd5F3bRBQWYNyBPzwrxG31HH88q7Av25mOv4u+rTDfEDpBi08M9Y6pV8fQd7fQZp2moKuJtHLI7rauHlFT/Wec46x55UtdgF2HyyQDGvyW+EC4jNfu9W6j6xja/6Acnn90ToaubAL+NjdbQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN7iPZMYBj5O91g/nEWCPb4kyE6IU+kPgimpYERmvsk=;
 b=ry8KGMeUb095AJ3GBnwrWDZT5FpEJmQXvjMELcr7UqCA9yesSXdDFx+J5CYJk2PVCYX14Z4+OqW8K/Y12RuOhhZbPphg+XhweE9aJGLXt3fA/GeU2XXH48m1NRw6GMoW5jzQTPtOYw2PwWkYfEv2ZOTkZpfEgp5fRZ66h1wqUJ7/JuMWfkAfwBX3WccWS9ZwZu0i8dr6idv3IDMBdhuG8v+EnfZBuOSRLsp+AoRm/CsVZMloA9EbHA/xCmozkj1TQcvBMN9Y6+i1Cz5UxfHJc2owlLMFd3FLROlCujFwMHzm7P6p0wF0t8bJRl0SG2uWkE4pwejaLzkmOIpR8SVbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN7iPZMYBj5O91g/nEWCPb4kyE6IU+kPgimpYERmvsk=;
 b=Mh8yFAKqaVOdOaxZ7AFxS1jRc1zsahIEv/CbP5uBXP4utM+xRF0GgEedwU/qYTGxuBzWrIi90ivSkDbDCEye1EIXGsSv8u1qM5hwylFFcQOwtuVOp3Nu/H+9U8GkKJgtNwxnB4Poq3PAzkZ6OEwQJgf8HHju7c3Dcd6GaSHOKzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 09:56:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 09:56:38 +0000
Message-ID: <69db08d7-4976-40e8-845e-b125efa9fa9d@amd.com>
Date: Tue, 17 Jun 2025 15:26:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 8/9] drm/amdgpu/userq: add a detect and reset callback
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
 <20250617092243.2769580-8-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250617092243.2769580-8-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0037.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 673495d5-72fe-4d03-1573-08ddad85403b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUpnSnlmMzBhSGxIUW9xL0dGbWtoYUVhZTF4dTZycVNLejRkeURzSEd2RTlF?=
 =?utf-8?B?bTFwSUl3MnZGY3NzSzRISlJpNUZjd1c3YlBJN09uSjZrSmFlSTRhazg5L1hK?=
 =?utf-8?B?TDVSUWNvMjJXS21BQ0FrSEVLeFpUSVIrNGxWQ3A0dXRxSWw5Rm8vZURMOG9B?=
 =?utf-8?B?SE9tUk02MmxBRXA2UlphWmhZK1ZxTVlBWlJxMFMyeXQwcDQrRXBQYmZ5bXZT?=
 =?utf-8?B?WUducng2dkkxa3VhVnNzVlgrTlRTNndzNHo0MjFXNUo4ci9uTThoekx1Y3VQ?=
 =?utf-8?B?WmZHdEtvMVdoSWxNdVN6ZzY5SmdZVDBxQ0tDeEs3eGorNEEwMzVqaFRjcGZO?=
 =?utf-8?B?ODczL2owR3l1RmIvQm0wYy9rd1loT005VWZQWlBHVkkwNkNnZ1pRdW1ESkdT?=
 =?utf-8?B?YXhRSENkNC8xam9vamNmc1pIUWxvTG1BQjJpWjVJcllvTVZiU2hEOHQvZFBp?=
 =?utf-8?B?ZFBNRGNyLy9mUndVaTFYQ2hoa0p2Q0MyQzdaVTJRejExS3pGRlpJUyt0cWc2?=
 =?utf-8?B?Q1U3bG9VdGNVTStzeEgwK2RBUnQ4TXJvYzZ3UWNaQXRDRnU0YTJrOGtZMmhT?=
 =?utf-8?B?K2RLMFFpclg4bng3QnUvTUlHV1piUy9SM0x1ZVNMcWZUR3FlelhVc2l3Nmlj?=
 =?utf-8?B?MzJ4bnBVTU9uOHpwS1A2dVVtWnFjRUZ4MHFtQzVHMmNDdkQ2dDBUOFJ0R1dy?=
 =?utf-8?B?VGpvWTF0NkFNVmltR1FZa2lNZyt4b2tCYk95L3B6TUJnU25tWHdkdEJHaExV?=
 =?utf-8?B?UEx5dit6d3R1NzFkUjh4Y1h4WHJRenBCNDNwbHJFYlRORlVXTHNYOEFTNkZa?=
 =?utf-8?B?TGF1RVhqSUZoTVFsMlVZaVFldTZpUm83YnJzeDNOUFE0enFwb0ZmcnZQeWJy?=
 =?utf-8?B?ZWxVYjFBRjJBYVM0NWFrRkY0UXFvUzVCRHA0V2p4T3E4WlVuQ1Y1QmhtZGkz?=
 =?utf-8?B?U3VzZFhUaTZvUGtGMXZySmtscTJvLzIyY0hHSXNERTlVUFJkZVdkbXhHbitq?=
 =?utf-8?B?VkpzUVR2d0pUSmx4UUk0dGRSSzdha1A3MnFjT2xUaUVBWFE3WHVVRnkyODZz?=
 =?utf-8?B?UVplQk1nZDh5QlhkY1lsNFdHVnpWRHpBUDMzN2dnSmlTTndXc2RGWW1MaHVl?=
 =?utf-8?B?ZC84ZC9aY1RpZC9IeFRrQ1o3STBtd3I4dmdzeXBFQzl3YU5uMm1TQUZYMG55?=
 =?utf-8?B?Ukc2aXdZbVBCeVNmOER2blZoVkJrV2JIMk5SZUZjSG52emNVTEY3cGtnaVFP?=
 =?utf-8?B?MjVrUWk5RHdNdTlDNGdOa2gxODl0N2tSTVpUeVFpTEl6b3NTbHk2b3ZPcVd1?=
 =?utf-8?B?NjNiMms2VGRYOHV3U0VweGdTb0xIQVNIdWYxTmt6dUN5NndNM0YybTlzWjR1?=
 =?utf-8?B?bG45cnJzUlZ3RFBCS0Zjdk1LVUsyVmxBSkZwcU5tZlFieEJ0ZTcwcmdyQzd2?=
 =?utf-8?B?RDVQNFVWc096SXpVWWtaTUlTQ1J6QTBuM0ZMOXRmVHljWVh5WlUrMURRL2Qz?=
 =?utf-8?B?K3lGMEVFbUZwMFV4akVVWUhyWUJpMkc0OFVrVURWOUl0Y1BLc3VQeW1sNCto?=
 =?utf-8?B?aDNFekhMYkxrNExaRUxYT2lDdEhWdUlneWZjWmNpWWVPc1FHS0JBaDYzcGoz?=
 =?utf-8?B?YmtoU29WbENKRUY0TWpCY1MrUndENzlTa3NNNk1nd0V0eU94WDRvbit1S1lj?=
 =?utf-8?B?OXMySmt4ZDY1QWpzQXBhYzU1ZExsQzZTWjlrazROQ1FSWVNHRjNZeG00YXBE?=
 =?utf-8?B?TUVEWHQxdVBubnhwWTBZTTRQMkJQV3FLd3RUK1I3NnFVQTZGLzJqdmQxMHJw?=
 =?utf-8?B?VFdKc3B6ZU0rTHJzMVoxcFlqYm91Q2w0UjlIYUllZXdzc2JOZXlYQlo2VEd3?=
 =?utf-8?B?ZllmS1FNRk94emZlaGUyMXRUL2VSbmV1TnRxdFlSYzYrNU04alRzb2dJanZU?=
 =?utf-8?Q?JoQh2H9DLMY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZ4SXJZWXYvdE44VHE5VE56cGFMY1VMVzV6NW1XZzZGZHZydUZRRHVwVmJm?=
 =?utf-8?B?QTRpNHA2ai9GdTVIb1BWQ053VmRTbUg5aWFHRGVpYmRsbm5JeUlHWkZGRE5F?=
 =?utf-8?B?VzlGK3RTQXZwalZ4SnZXY0FiSmV0eEFzZlBuak85Rm1lRWorZFE0Q1p0bm15?=
 =?utf-8?B?VGpGSHlicXo3THpab3E2NVdrK2pZOUpOL1Z4eHJIbWRNWnBKOEhZMTh5ZXZO?=
 =?utf-8?B?My9wMkR4eFNtak1ac2FBd053bk5rZURZQjMzRXQ0K3dRZGRDc3M0alNYMDdV?=
 =?utf-8?B?TkZPaDU3NVh4ZGo1OW1iRVpJanRESEVLL3lpNytXQTVhcEQydkE3YW0zMHd6?=
 =?utf-8?B?QktqdUkvb0J5NG8vWjlKbWxVTzNncno0OEZSSkJnaVNhdjdYU1AxRCtJRUNE?=
 =?utf-8?B?clhWZ3AwV2pOY3lKV0Q0dGJIT1VEVVkzRXJOQUlsQm5YSDhWT1kwYnFLbWxq?=
 =?utf-8?B?OGQxL0hTWnhXVXlzNnUvY0o0SlpZaFRMdE82VnJzZFA4RDdUVzhwWXkwM2tm?=
 =?utf-8?B?UXBacDBKTFJaTzZtQU1zWHVsUXVLdkNOWENZbEIwT3NEcnAwb1FraExVYVBj?=
 =?utf-8?B?SHJXM3drdmZhcm9uUVNxY2gzeGtzV3QyVFJZN1hST3hxbXNIeXNUc3l5c1J1?=
 =?utf-8?B?TTU5U0lpaVpQclZ2UTNBQU1pc2pPZmRGMWxoaUJmcURJTzJucjE2L2xEb1c2?=
 =?utf-8?B?dnhFS2JOVmJBWlQxK2NOM1YwaTJNVmJvVThuS3crVkNHWnQxTm9vQW9hS0R1?=
 =?utf-8?B?blVpaE11NFY5Nys1WC9lS0EybmVCQU8rYzBnNVhnelI5ZHZiVk1CSVdQZlk4?=
 =?utf-8?B?QXRtOHBCdzZreExVdlBmVVczSDBYZnBMZWprQWpyMGN0cWlDeFltemtEcEJi?=
 =?utf-8?B?WVdXSUl2aEpsM3FXNW52RGZiOWRVMHY0cUkyeVoxZkpTZjdsL09hZHVIZVFM?=
 =?utf-8?B?aXFES29jSmh3anFlRUUxZnBYODhzanhCdU0xYW9YYnBqUE9nQjV6T050VEVi?=
 =?utf-8?B?WkxORU1zZU9iV2VtVjkrQi9QdVBacVorZmhlNDNKZ3NmZmx6RHBLSlQ1QVpz?=
 =?utf-8?B?SkViYmZ4a2xrNDlLcG5tUVBHWDROeHdwb2FodDE4c0UrK2JvZzFleUlaT2lp?=
 =?utf-8?B?QlUwVTg4aDY2Y2NtaGdiYmFnWmdPMlV3eTdpK1ZqcTAxL1J3OFhSN2lFSkdD?=
 =?utf-8?B?RWNKUVRpb1RzQTdXVFAycjhvV0wyY0tMbk9OUitnZ3dkdjJVR2pCYmZMaUth?=
 =?utf-8?B?L0JoQUc2aW1YRWkvcW1hQTMreGRtT0Q3NkxCRmlFZG4zS1h6b0xUaEJUTEFu?=
 =?utf-8?B?eXBybm81a0NNTGsyMDhSUEFxMWYvOWN4L2RIZ3YzcU1DYUx3YUJCK2h4akFK?=
 =?utf-8?B?Mll3dHJGY21DbXNyeDM0ajZOV1FCZzJuRG5qczBpMFBjK3loRjhGREtYTUd6?=
 =?utf-8?B?bXJmVWUyNXNyVTlxWnZScHF5VUQwWWpsSGJNTVdiQjhnNVRoWno0WnBpc0hI?=
 =?utf-8?B?eVJrRkM1S29WcFNBVXlFZVZxV2xPMmo3dTkxQVgwWlpIa1N0K3hldVJUN0Z1?=
 =?utf-8?B?MlYxNkszSlVROTA4Rlp5bHY0cW1OYWl2YVhtUkt1cVhRMTFka2V5MnVJZWtp?=
 =?utf-8?B?Sm90dU9keXhsREdLYUVINEVja1dTQ2tsbnpSbWU0M0tweWJQYWJkdHowK3lw?=
 =?utf-8?B?cklOVkFuQlo2aHU2bHNFdTVvdHkxRVl3aGZpeC9aUWlodjVESS83czhMakNX?=
 =?utf-8?B?M3hyNVhVZU5NL2tsT2tkY3diRG90aUsyOWZGS0dCK1IyYkpnd0xZMStBdld0?=
 =?utf-8?B?WG81b3Y5V1ZnRWJMT3U2T0NoV1RrS0k5eGhSQmZwT1JydmJXRHFJQ0VzUWgy?=
 =?utf-8?B?dHA4UGdPYmRyNnNhZUphOGFtQlJUL2NBR2JkWkZaUktaRysxRFBIc1FjbXRN?=
 =?utf-8?B?RE1lZDVKRUJ3ck9yUmFSWWxLL3hxeTlNcXZXOTVKdnE5NjNuYmlXU1NVSkNF?=
 =?utf-8?B?bDhDdCtYcHdselV4cnFxdllGRytaSk13S0dLWEM0eTdZbm90a2k5SkVVRVpE?=
 =?utf-8?B?Vm9sZ1ErYUl3NlRvOExkVXNwMGdwcDY1OGt4WTYwdnlYeGNqdy9wQnRoOHVV?=
 =?utf-8?Q?EQ3/p4bq8w6z3TnPANj8GvbPM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673495d5-72fe-4d03-1573-08ddad85403b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:56:38.3991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZ59TSY6MGUF73tFBqfi5Fyrrhtqla5KtZAutn/u6+fSWbhVMSHe6+bCI68xJYMg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
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



On 6/17/2025 2:50 PM, Jesse.Zhang wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> Add a detect and reset callback and add the implementation
> for mes.  The callback will detect all hung queues of a
> particular ip type (e.g., GFX or compute or SDMA) and
> reset them.
> 
> v2: increase reset counter and set fence force completion (Jesse)
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index ec040c2fd6c9..0335ff03f65f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -77,6 +77,9 @@ struct amdgpu_userq_funcs {
>  		     struct amdgpu_usermode_queue *queue);
>  	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
>  		   struct amdgpu_usermode_queue *queue);
> +	int (*detect_and_reset)(struct amdgpu_device *adev,
> +				int queue_type);
> +
>  };
>  
>  /* Usermode queues for gfx */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index d6f50b13e2ba..52d438b5dcef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -21,6 +21,7 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include <drm/drm_drv.h>
>  #include "amdgpu.h"
>  #include "amdgpu_gfx.h"
>  #include "mes_userqueue.h"
> @@ -198,6 +199,55 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>  	return 0;
>  }
>  
> +static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
> +				      int queue_type)
> +{
> +	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
> +	struct mes_detect_and_reset_queue_input input;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	unsigned int hung_db_num = 0;
> +	int queue_id, r, i;
> +	u32 db_array[4];
> +
> +	if (db_array_size > 4) {
> +		dev_err(adev->dev, "DB array size (%d vs 4) too small\n",
> +			db_array_size);
> +		return -EINVAL;
> +	}
> +
> +	memset(&input, 0x0, sizeof(struct mes_detect_and_reset_queue_input));
> +
> +	input.queue_type = queue_type;
> +
> +	amdgpu_mes_lock(&adev->mes);
> +	r = amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, false,
> +						    &hung_db_num, db_array);
> +	amdgpu_mes_unlock(&adev->mes);
> +	if (r) {
> +		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
> +	} else if (hung_db_num) {
> +		mutex_lock(&adev->userq_mutex);
> +		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +				if (queue->queue_type == queue_type) {
> +					for (i = 0; i < hung_db_num; i++) {
> +						if (queue->doorbell_index == db_array[i]) {
> +							queue->state = AMDGPU_USERQ_STATE_HUNG;

After a reset and force completion of work, why is the queue state
maintained as hung? Does that mean no more work can be submitted even
after reset? Where is this state checked?

Thanks,
Lijo

> +							atomic_inc(&adev->gpu_reset_counter);
> +							amdgpu_userq_fence_driver_force_completion(queue);
> +							drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
> +						}
> +					}
> +				}
> +			}
> +		}
> +		mutex_unlock(&adev->userq_mutex);
> +	}
> +
> +	return r;
> +}
> +
>  static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  				struct drm_amdgpu_userq_in *args_in,
>  				struct amdgpu_usermode_queue *queue)
> @@ -352,4 +402,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
>  	.mqd_destroy = mes_userq_mqd_destroy,
>  	.unmap = mes_userq_unmap,
>  	.map = mes_userq_map,
> +	.detect_and_reset = mes_userq_detect_and_reset,
>  };


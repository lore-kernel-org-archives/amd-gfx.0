Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5CAC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 16:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27DA10E801;
	Mon, 13 May 2024 16:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pnHVu92Z";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D58410E801
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 16:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7QRtGGeSO3Y7Chfr9yUIpSb2coADmjA3zkOZWf03BXLcw2dqPRoIGcTbX5OzcIwE/N1/ZVLMRmxuGG8Uf0wk5WRxKuNsNtBf00yXcHgnsseyT9dj4dXvlCe9gHoQG5c8OGfPgjma8TtL/8k/JO7nJ/x5v0n8rIG1w1qjD/6dwtJKVz1wDupmUet75OO+QxXpPEX1T8dMVHscBR3uADENE7Im+g2H5/PA+ewJSJtP976OiL2rRMYmqKs6VaPBMCMQfaBlBcNzyohp/AYbDC6RbWG2V/6OAMq3bm2W3M2ASDVEk96QL2BZkWYpnh7Y+MOn9AhhciEUl8m84181bharQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rS5neeNFij6xQyOhDHWL9LgDhxZ5Todm8OYxX5qUKE=;
 b=Zu5LOk32AbYs7kH64c4hWYcW3YGHYcnFgOO9a+2GuRpJG1HVnsCKr0F0Cmz6piV9v7D2Nc4nlMoGsPWgekFdl6TXXZhX6x3bPobGu17Mxiw4jT7Xt7KrhSAJgIAs9m+f3WMIRUQJFfsz4U6QQnNugYZWda3m6+RWD06AJVrasjubPI1xlXqahwbpXpebuPltpSnD5vXNvuBTgb9ROigfpoFcwwqrzuLojgjvCfOgOIHs5lku6JGcvBN9r+Obhp8kvJjyAT35o+LuyRwUgVkuDETdQ6Lqo3Sznnt2KpdWP+8/lCltst5IK5+CvKNAnyeO+cuhezvdxNsVaKMwUaOQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rS5neeNFij6xQyOhDHWL9LgDhxZ5Todm8OYxX5qUKE=;
 b=pnHVu92ZZO5VlVpWvSd07wNMM4d39plLGJLJ5Or6BZ+E5r+K52S8IsHsdgBP/F3YMwu08o6jkw0nTcAM8ykYntQ57y5NHdtFECcebc0Q032jPQ+8iSrU61URWbdvgYnVk1XBDcl7uHs9PirLYjit6YnTQzwrTR2G2nz6CQza7xI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 13 May
 2024 16:00:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 16:00:16 +0000
Message-ID: <bfa5cf75-8e01-4f81-bf40-d89314373ddd@amd.com>
Date: Mon, 13 May 2024 18:00:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/6] drm/amdgpu: Enable userq fence interrupt support
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
 <20240510085046.2718-6-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240510085046.2718-6-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0122.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: eb037e29-55b4-4323-c1e0-08dc7365c815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2lGTmNLYkFMdy9yOHMxOE9XYVByRnRGNHowNDJKVkM5OE9jZWdjb1pCbmtL?=
 =?utf-8?B?MlhxSEhPcmhzODlsQW13eHRhRXI2Ui85ZnZwYnBzb0dhZVJuUHNNVC95NjJR?=
 =?utf-8?B?amZrR2ZuaEtkZ2xGQTFIT1ptRVBsK2R5YmVhVU1idEdsQjVQNm4vR0lOSDEy?=
 =?utf-8?B?Tzl3LzgrTGtwRThleWl4bisrV0pGbFNsQmpTVkN5M1lSMUhGSCs1dEZyTEl1?=
 =?utf-8?B?RUFYZURReGhIQ2N3MTcrZWxldGZKZmJKL2YyUG95MmJTRkhZUFNxY3V5SXBE?=
 =?utf-8?B?alc0aUxRQXoyblJlYXlYdWJXVy9KMHdsZXpLM0kzbHJYaHdkaUZvS1FMVXhE?=
 =?utf-8?B?VWJGTER2MHlUbjdjcXE2Y1dRRHZaeGUwQVV2N2R3ZzNNV0ZjSFZueFVxVEZk?=
 =?utf-8?B?aHV6TlFtWHhkNXJETW9WWkhndEFmcnlNTlZveFBaSDA5cEd6a1hxdkRMUjFk?=
 =?utf-8?B?NHFYQ3NFNHl6YmNDN053Z0Rxc2pXU2IrYi9FUnJEQ3dQMXBldlAycXN5LzJN?=
 =?utf-8?B?MjR1NExEbXdHaEVnSzBEZkE2ZTYxNDl4bUp0V1VtQlZ2T3c3Q1ZJMHNCRE5h?=
 =?utf-8?B?akFHTjlONDV2TGpLSHFzZlVPMUc2YTZHK2NWR1I2d0g5RDA1UmFBc3RGekxI?=
 =?utf-8?B?S293R0NFazR6aFhaR3pPbHFxSkJtTkFCUEpFTWpRU1N1T1hyTHZGKzd0Vm02?=
 =?utf-8?B?OWtYRjZ4c3JCSW5TVlc5UEtMWG9FeEZIdCthc3dZbUxvOTlnNkdpaE44ejMr?=
 =?utf-8?B?NGMrWlFqQnJhRmt0N0twbzlPOGNRc1VJc0lWR05rZFJ5YWxpT1RJb2srRjIy?=
 =?utf-8?B?SGhnSDJLbGxDenB2Ynl0dVFlajFpK0xNTWJOQW9YdG1vS1dWQ0FjTUZscGhu?=
 =?utf-8?B?MEJCVUhHajlkTW42d0pNeHFhamZpaVZiSFpIWkQ1WVpDZFF4M0lkbTJrK0Rl?=
 =?utf-8?B?d0VLNVNqSWlHSW0veDd6Zkd4bmpBRnZBalFiT01TV3l4Zi9hc3hrYkM4Vmta?=
 =?utf-8?B?b085Q29RY20yTWZHemJ5VEhBbThyZHYrMUhlVHA2dVZ6dWtGeEl6VGJLVEJw?=
 =?utf-8?B?UW9JWUhiWW9IUUtSU3dRcE1vd2t1RitBQ2F2dGpGSnpwUU9tOENDYzJJU0d6?=
 =?utf-8?B?a1BXMWhVQmFYaWxEL2pSY3pWYUtVRFRLWnJPdS8ramlObHR0TVdqTTUyYWty?=
 =?utf-8?B?aitrNWlXTWxOVS8wUlB5VnVLWThPVU13Z05KTmI1S2tTbnZueDFvSzhaVFlM?=
 =?utf-8?B?aGlsUzAzNnNiRGtEZmRyVGNiZ3RmQ21ZSW5vcC9TbU14blF6emtvT0tFaUpH?=
 =?utf-8?B?dUxUV2h0eUtPUjRTUDRuV3FmRzRmTVlEc2NyVU1Qdjk5MmlOTUpDQ2pyZktS?=
 =?utf-8?B?bjJERXZKRU9teVFzMkZrZEFua3BNNzdvRS9lVUpzQ1lSUlp2TjV6ZFpKSDVr?=
 =?utf-8?B?WUhQOWdKU0pyNkNqU05qTVNCVDIvS0piNUYxVFVsNG9BOCs0Y2VkS09SMVdj?=
 =?utf-8?B?c1ZPVWloVGJtampIQnV3bnFEam9wZ1Nkb2JMaTNxdGo1YWEzN0ZIUGJWSjVv?=
 =?utf-8?B?Wk5GcXdxZjVkSG96bk5teHp5YXo4LzFOd28zV2ZnRWlVRCtMSVVUQktoamt6?=
 =?utf-8?B?WGR2TVBPYlFYMDRYdTFWWTExVVhsRlRoTktJaGNMMVUwRUlzckIva3VwR3Nw?=
 =?utf-8?B?SHpuUlQxazRCWUlDNVZGbUlWMk5qVHJqTDEwak04SlYyVkxoTWRudWdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWQzYXJ0UEd0TDlCZmNxZDJkTEs1c3Z5ckhxQnFxTkx6OXJwR2VuRytXdkYy?=
 =?utf-8?B?Y2orc2ZPOXdkcWVzNDNhYThMSkhubjkzbUtEdmFYN2NxM3dIL24wSkRyUFpJ?=
 =?utf-8?B?bm9pc21Uak1TQzVPT3hQcWdjR0xMQmF6UUhMQysvQUlSZUY5Z0xOWDRxMkxS?=
 =?utf-8?B?QTZIa1BxSFc2cmhISWg3VlN2QTcvcStZWFE0NUoxUGU0SDdzK0Fsd2R5N3dN?=
 =?utf-8?B?bW43YkNCbDg2V2xEOEVlTm1DdlMrajhUOGRJdExibEIwVldMYVFRajlxeDF0?=
 =?utf-8?B?eU5KaWxKdWpwdGpXWkdIS0tpWmxxZmdsRmdWUTIwSlZiMTFkc3BkVW9Yd3V3?=
 =?utf-8?B?aFhqTENaRTFxQUowZXplSE43TUJCcTZDVkRDQlBGcFlhMVloUTB5cGR0RjV0?=
 =?utf-8?B?OFlaUlQyaFBFWW52UmU2citCTnI0ekxqYzY4bDVUajA4emt0ZmQyeWdEb25y?=
 =?utf-8?B?Wk1xdjdIMlZjQ3ZHeUtNRGZvMG1YZUMwSU9rQ29LVHJPV1VQVmh1OVVjbWpR?=
 =?utf-8?B?R291N3lZb2o2WjRuNUZXaENFN210Zno5bW8wUW9RZEtTWDRUbnJkUEpqR29i?=
 =?utf-8?B?aGZYV0d6dFcwRmV3dm0zNFBVV0JldVVoN3dSb2pFYXRDTHM5TkhKeC9YWlJR?=
 =?utf-8?B?dlJoUURyWjZEKzVtYUs5djM1UnZITG8rS3RBd3BaOVplbWR1L0dFd0M5Mkxy?=
 =?utf-8?B?ZHo1bURVTGljMlA4Tk9Hdk5Vck0zZFJKQWs2bDlVajhodW9PMDRZWVlrMUJt?=
 =?utf-8?B?NG5hR2Erc2FRN3EzdUFtbVJBSUZYY2xCWXg1Y1NRUElEZERlalhRUzhsbmtx?=
 =?utf-8?B?SVFsM2dsTEhVZkVEbVhpS0tlZmZVcDJ3RGxEZXovVlM0MEVQNHM5RGY5RWxj?=
 =?utf-8?B?S3dYcExDb0preXdVU3F0ZFBINEFGMGRIcVl1SkdoNE9MRkpWYXVhekl6L0RH?=
 =?utf-8?B?R05mVGs5OTB0WnU3UnB2dHZzc1k5MzNlK25taFRFYVNwdmFCamhza3dURDZw?=
 =?utf-8?B?Yk1ZOENzWDhuWU1qME0zT1V3aUJweFM0RUR5QlJEVk9IOVZiejdKVkpKMjVw?=
 =?utf-8?B?QVpFV3NCZzZaK0dNRTZJbmFkMlJvTkFpUkJlTzFyL3BRR2w5WFFMaS9rdlVp?=
 =?utf-8?B?S2l4SitzVnl1TjRGNFRsSitSY2x3V0NyZmliaVJsZnF3aUN4aVJzc2EycFhV?=
 =?utf-8?B?Y2hrR0Z1U0tyVytTMFZVelRnV1JvYzVPRjc5UnJzTStUTE9FWFhKdjQwRUxn?=
 =?utf-8?B?RFo4Ni8xQWt2SmpvSzRQd3FLc1IzNWZOalBLWThFRnJuRU90Q1M4WldDbmJ3?=
 =?utf-8?B?Y3FoYzJucEJGOTZDQ0ZsOXA4M1UxWWg2WnhBVzdndnAxRlVXcE14NEVhSW1l?=
 =?utf-8?B?UWxJRjZlR0RQWDZYbFRXZ2hBcThDS05SQWRNT2NKbm90UzZxS3F4SktXbmN6?=
 =?utf-8?B?azBkUDFKVXJ3MC92RXl1SUw5MjlUU3FBemR1b1Qvd0k2dm1Ca05wQUR0WlF6?=
 =?utf-8?B?UlNGN1JOOThiWlV6OEpnOGg3UzRmblpESjdpNXFmNld5cUNvdGloMEYwQXZs?=
 =?utf-8?B?bXA3SUJtSXZ5Z0JNL2p1NzY2Ry9NS2IxVGpHS2pxK2h2bzlLTzAwb3pSQ1JV?=
 =?utf-8?B?dU10aVNCeHF6Tm9TM0FoaDVTUkFUZlBPcWNiTlRKZHIzVitCS29BQW1WaHZy?=
 =?utf-8?B?K2wxZkdKRU5BRmx6dG1YOUJQd1Btc3lLdFdrdTFnQVVEbHBDWnlBWGFzSUxX?=
 =?utf-8?B?VXVCVW9rWXNiQkZaM2g5bFFCV3AvWStMZGxrY3BPVDRFdW1SS1RDOXFOZzBl?=
 =?utf-8?B?SGVWTEt4TmhUTm01azBkSmJEWHY5ZjZYcTFNVkRIeEdTZEkzZVJDeEViSjA3?=
 =?utf-8?B?T292aXZld3JKWTUzK3lMaWxPNE91T1FmMXl5a0F6L0dOWCtINGlQdloxb2Iy?=
 =?utf-8?B?aWJ2VkpXNUVZZXVEZThVSjA4SjE4OUJldnZwZ2dkc0srdmhaRjVjSFZldGtS?=
 =?utf-8?B?dmZGNzRmTUdJZWxMSmwyZlh2VFFxWlU2ZklEcU5DNE5reW4zR2pVY3llOUJV?=
 =?utf-8?B?Q0hpeGgrcjFzK3FvK2g0RGZBVXhGNm11aTdvaXdjRHVoVjlEdDhvbjBPQzRV?=
 =?utf-8?Q?my8EqAggOC5uQYkubAjkKnV38?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb037e29-55b4-4323-c1e0-08dc7365c815
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 16:00:16.6755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjIh1hYHPwXgmryViOqJP62XiwJo8Qo0EZv5Aw4oTAL6IMZxZrJkkkbFRqt0B/mw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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

Am 10.05.24 um 10:50 schrieb Arunpravin Paneer Selvam:
> Add support to handle the userqueue protected fence signal hardware
> interrupt.
>
> Create a xarray which maps the doorbell index to the fence driver address.
> This would help to retrieve the fence driver information when an userq fence
> interrupt is triggered. Firmware sends the doorbell offset value and
> this info is compared with the queue's mqd doorbell offset value.
> If they are same, we process the userq fence interrupt.
>
> v1:(Christian)
>    - use xa_load() instead of going over all entries
>    - keep the xa_lock until the fence driver process completes
>    - create a separate patch to remove the MES self test function
>      call.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 ++
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 15 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 23 +++++++++----------
>   4 files changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4ca14b02668b..2d5ef2e74c71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1043,6 +1043,8 @@ struct amdgpu_device {
>   	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>   	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
>   
> +	struct xarray			userq_xa;
> +
>   	/* df */
>   	struct amdgpu_df                df;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2d9fa3d0d4a4..fd919105a181 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3982,6 +3982,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	spin_lock_init(&adev->audio_endpt_idx_lock);
>   	spin_lock_init(&adev->mm_stats.lock);
>   
> +	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
> +
>   	INIT_LIST_HEAD(&adev->shadow_list);
>   	mutex_init(&adev->shadow_list_lock);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 339d82d5808f..4cbc25595226 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -70,6 +70,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   				    struct amdgpu_usermode_queue *userq)
>   {
>   	struct amdgpu_userq_fence_driver *fence_drv;
> +	unsigned long flags;
>   	int r;
>   
>   	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
> @@ -97,6 +98,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	fence_drv->context = dma_fence_context_alloc(1);
>   	get_task_comm(fence_drv->timeline_name, current);
>   
> +	xa_lock_irqsave(&adev->userq_xa, flags);
> +	__xa_store(&adev->userq_xa, userq->doorbell_index,
> +		   fence_drv, GFP_KERNEL);
> +	xa_unlock_irqrestore(&adev->userq_xa, flags);
> +
>   	userq->fence_drv = fence_drv;
>   
>   	return 0;
> @@ -147,8 +153,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
>   					 struct amdgpu_userq_fence_driver,
>   					 refcount);
> +	struct amdgpu_userq_fence_driver *xa_fence_drv;
>   	struct amdgpu_device *adev = fence_drv->adev;
>   	struct amdgpu_userq_fence *fence, *tmp;
> +	struct xarray *xa = &adev->userq_xa;
> +	unsigned long index;
>   	struct dma_fence *f;
>   
>   	spin_lock(&fence_drv->fence_list_lock);
> @@ -165,6 +174,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   	}
>   	spin_unlock(&fence_drv->fence_list_lock);
>   
> +	xa_lock(xa);
> +	xa_for_each(xa, index, xa_fence_drv)
> +		if (xa_fence_drv == fence_drv)
> +			__xa_erase(xa, index);
> +	xa_unlock(xa);

That is rather inefficient. We should probably move registering a 
fence_drv for a certain doorbell into the userq code instead.

> +
>   	/* Free seq64 memory */
>   	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
>   	kfree(fence_drv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index a786e25432ae..0a206f484240 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -49,6 +49,7 @@
>   #include "gfx_v11_0_3.h"
>   #include "nbio_v4_3.h"
>   #include "mes_v11_0.h"
> +#include "amdgpu_userq_fence.h"
>   
>   #define GFX11_NUM_GFX_RINGS		1
>   #define GFX11_MEC_HPD_SIZE	2048
> @@ -5939,25 +5940,23 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
>   			     struct amdgpu_irq_src *source,
>   			     struct amdgpu_iv_entry *entry)
>   {
> -	int i;
> +	u32 doorbell_offset = entry->src_data[0];
>   	u8 me_id, pipe_id, queue_id;
>   	struct amdgpu_ring *ring;
> -	uint32_t mes_queue_id = entry->src_data[0];
> +	int i;
>   
>   	DRM_DEBUG("IH: CP EOP\n");
>   
> -	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
> -		struct amdgpu_mes_queue *queue;
> +	if (adev->enable_mes && doorbell_offset) {
> +		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> +		struct xarray *xa = &adev->userq_xa;
> +		unsigned long flags;
>   
> -		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
> +		xa_lock_irqsave(xa, flags);
>   
> -		spin_lock(&adev->mes.queue_id_lock);
> -		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
> -		if (queue) {
> -			DRM_DEBUG("process mes queue id = %d\n", mes_queue_id);
> -			amdgpu_fence_process(queue->ring);
> -		}
> -		spin_unlock(&adev->mes.queue_id_lock);
> +		fence_drv = xa_load(xa, doorbell_offset);

It's perfectly possible that the doorbell_offset is invalid and the 
fence_drv is NULL here.

You should probably check for that.

Regards,
Christian.

> +		amdgpu_userq_fence_driver_process(fence_drv);
> +		xa_unlock_irqrestore(xa, flags);
>   	} else {
>   		me_id = (entry->ring_id & 0x0c) >> 2;
>   		pipe_id = (entry->ring_id & 0x03) >> 0;


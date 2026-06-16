Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7335CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 10:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DE810E74E;
	Tue, 16 Jun 2026 10:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DkHPwDwk";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6AA8826D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 10:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i885eiNrL0/wmYOa7IuATb0lkdhhRcP7i42p1TZZ1vbuDFaL5hRGAp1mJGE2H+9H61/7lGd8k95BiitQ4AceIyoEqLIgkPgmQit6yTnp4U6nSP61ybIhS7iVpfBe64EEtcjVVfeGZxOfDuCikwGUqlodK73INVK1YHFQoRuwB5XcN55C/Dpm5hygvTNwXEymZJvW3+87HHcR47jl5tofgDJqIpOR8xqFkcErkT8eh7iT1e8wVKcPXasAGilzBSKZnkC0lAfonkZpe8OaWFVNHfTmKE1ETfHjv0pEl+EfXjn7iryDlTpWrbIro+VU53ARfwnFeu355Ue0v1xMe8ok+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBEwOMZDfFzUVxLPLz+ETCFjW09CQPhzJXm2J0mLdJQ=;
 b=wCa7ruTeiUJDl4dNeEnmy/Tgz4BmL8SDCSUEpFt6CGi28MLo27DC8Pp3l7mvWTpLZmu3ozw7Bfc8iVxcrO/BWtSxuXUtON9TQqGJmn7qQcomUDb/G0z86ci8ibvbaQK8VrPFBDhFDM5C77hgkI2xCGMsdI1R/8DIOAl2wRu+Wk24udCyJQySnMy2t6fGAJLKr00L5tDKmTp82O1isgwHhgaIppwD0XOFBGy/sAcXMohODyySgGTziyNDvIBpijOXKfdwd9yHEF6M4gs5MM43ce3Oc61f9fkINuxvU0NFROjB8awBxugVtJg5L1yEPgrXQXcC9sNkbySL5LbLNAJwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBEwOMZDfFzUVxLPLz+ETCFjW09CQPhzJXm2J0mLdJQ=;
 b=DkHPwDwkO8XggM46DomIBSZONBVRjeaVMljZBNNF6Tv9DdOhMsK0HtrEe9Cg3AWieXtfC8OcPlP/Y6dImNVF4qADkIWCjagUNB3AtJ46xfCnvL7ula3lqhdQWTCZzRcAR5luhjh0quVHt1Gb2CdvftHeGUBjAYbHBEcvqaeoATU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.17; Tue, 16 Jun
 2026 10:34:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 10:34:28 +0000
Message-ID: <8fd9b9ee-9b18-47e3-ae16-620d56aa8ee3@amd.com>
Date: Tue, 16 Jun 2026 12:34:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/amdgpu/ih: Add retry_cam_ack IH function pointer
To: Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lazar, Lijo"
 <lijo.lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <20260525114507.24566-5-timur.kristof@gmail.com>
Content-Language: en-US
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
 Amir Shetaia <Amir.Shetaia@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260525114507.24566-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 628d6b43-2d4e-4bac-6514-08decb92d7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aIomrFGiwe+A5hFBnm6mqgkb5AlpDuiOBp+GZ4ujrjvk8U+RjNNpuZJHAzsetcZzEVl9Rcd7eHetpih8jzsXAxqeHDxrxyOTGvveULo1SjJpXI49weXKeu/dHEgUfY2lUeBQP+wRQjTCbIBwkFdcwMY9gErhka0hAlEMdvXM24c5jKfsmTBHwoaSwM55XuRrRbLqZcIpDh0HkcKBqMexaa+24G5ts803dUVSLqjz0KS/UGJ7a3CtEX8gvuI8c3Gi4rbsBS8fcbmrypdEfTHPYuiyAsgsusMes9kroA32XQmnYhbQXeullCNLHcZa/FEjCVYMuEafKEkOvmVZjmeE00iFFFJK9f0tZ4UvHbM0cuB2aITdOzAl/olih6Q7O83XNjE1YYfxq8l0nUYORP7wM8MvgE9WP8fOL4D/epQLFg5gsfyLKOZC0THaA9POFQaMHQFAi4AqUWGROlIrrxqD4w0yoRqmTnRLJIPlZ83gXC6wg5Jbsfwm2AC3+jXdbOhclqTp1CfLybwkle7QsifbIYY3JQqto1QOLIkK7IoSFu34YRFz+LqKUf2YEz2wt9Cv363lTxPXyxgTWokqPROs88uZ/VksNnzqOGkZQgPs0uYg4f8QUlq42qqGiAKJIV93KjQWTJtwC5qdMb1ssIGrn/ErntCAs+MouLgtLiCQtVrV9fd0bKSn9SPgUmPdd/iB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZ2VnA2ODhPNVRldGlrYWdYUFZXenBEWndYaFpZQWxaSXdjRlprNkdZMmtB?=
 =?utf-8?B?bFJ1emVuREhWK2V1VXNDbDlkNFJyRXcxRDVOQTdYMFJoN1Rla2luUEYrWFZl?=
 =?utf-8?B?SFVoWGdzMkhxNytzcTcyTTRxeU1nQzlIOWRFcHJKM2tPYkFzemNuQ3diTFNz?=
 =?utf-8?B?Y0FXa21KUkN6b3h1d3FreUZNOHZGdjE3OTZsSXJLdWpaTFZkWTg3QlZtZXh3?=
 =?utf-8?B?ZnFHLy81d0I5alJvMUMxV3dYenByYkJiaTMzKy9SdDlPYUdwY3Vrd3lXR3Jh?=
 =?utf-8?B?d1NJU3NBekJWRmIxUWR5TFFBY0NVWnhzV1pPVVRUalQwSDRYSi9ibU1TQXMy?=
 =?utf-8?B?cGNEZXlsbVc0TGtxZnRLbjF1VzZRTEZsbG9lUFZmUzJjWVBvTlRxVXh1QnZu?=
 =?utf-8?B?Wm02T2k2UUJjY0VJLzVlTlZvdGVxQzVDeEhrWitBcjVCc1d6QzRjZ2wzR2U0?=
 =?utf-8?B?a2NpSElEcWVBQzhxdy9QdmNFRHVvdmNZSVJGRnNLdWlCUnNxdU1KS0hIc1F4?=
 =?utf-8?B?TTdNMFRhdFBqOW1rU0Y5UG1KUHJZYmtZMUJ5SzlYb2ZEMjV1Mk5WaVRDM2JM?=
 =?utf-8?B?ZjFGbW8xRW02ZGhuRE1iWjBRbEJlTG4rS1VWTGhhcXdvZUJFRXdaTmFPZTRH?=
 =?utf-8?B?eUpqdUJMWWxFSkpEVG9tVEhXN2FNVlEzOG9vQ0JZbXVBYjMrZDQxUVVobGls?=
 =?utf-8?B?VTdLSTIvTVlMd1dQM05PMUVMVFNQRTRyK0NoajQ2NEdpRDJSNXp5NzlwK2hF?=
 =?utf-8?B?RFV1NktIOGV3K2JBc3lpd01jWlB2ZEIrWWpVNlNxMTFCaWRZZVYxMmlnMlUx?=
 =?utf-8?B?U2JzL0doVUo1anJVc2FzSHMvZjNNUDg1bGcwSTkwTEY3VEZidnNud2NtalJN?=
 =?utf-8?B?dVVzMTc0ZVV5ZE9TYkJZSFAvN2dpaFByRklIaHFTZUVUdUF2SERkaWswSG1w?=
 =?utf-8?B?UG1maEMvc0FmMzEzMUM0VWlEQVYrb1hIYmZHQlNxbTUxZ0NMKzdOYlhiTUxp?=
 =?utf-8?B?Tk9UM2ZkdUZpUllKVE1DNmJCSmR3VDhqblVENHlEdklpTWtqRjc1bGtaV1dp?=
 =?utf-8?B?UHZPOHVId1BxZlhPMkN5Q3pJbmZob1cwRGZpVUJCZnVrTFBEb1hKdE9YZ1J3?=
 =?utf-8?B?UHUwTVdVMmhLaDFJNGtXYzRLbm9QOUt5aXE3WC9oY3R2UVg4elgxOGlQaVJZ?=
 =?utf-8?B?ZW91QXExZ3FZSzFwa216MkRmWTF3WWxkSDZDOE9OSlpLRklGem8rOHkwK3NV?=
 =?utf-8?B?Q3d6RWFyZ3hUV2wvVmtXdG54YXd3ZE1pM1JKVUFiLzRvVmJRNU9uVzNJbFY2?=
 =?utf-8?B?STA4aG1yQTRmdkdwSzZkNWcrYlJMbXMxZnNVcm9ZN1cyTHFGNUlKRlYzMjE3?=
 =?utf-8?B?MjEwOS9qQnVhWHV3U29zRnVjVTRaT0dpa3pCUndYQVcxQzhxRDRrdklhc2Vr?=
 =?utf-8?B?TEEyM2J1b0Q0Nkp1YWU4RHpQWE94MjVvWHVNUE5Wd1pWQWE2bHRyTVFvNGZz?=
 =?utf-8?B?Q29iODdVakhtOGMyS1Y5eDZuZjc4bmhCdDNSc2NZSk8weWhENUpJaVhlZU1C?=
 =?utf-8?B?cXE0SXo3QUtNMUUxYmE3SGZvakJ2aDl4a3U4MHF0K2xCUnlBNFNrM1NkNDVh?=
 =?utf-8?B?SmtvSmNyYk1GV00wUmZqYVlQcXVUMXB0WWg3NnhHRjFySDFST2szR2FSRTN5?=
 =?utf-8?B?NHdBa1NvZkszZUMrYm5HTUZEMVZCNHVrV2FFMkI0UlYwRFVHaXNuSlV5VUNC?=
 =?utf-8?B?UndrOElMdGdrenRzMjY2dnpRRThPc2FJRjF6am9WbkFGUldnSWdWdHdkZFBK?=
 =?utf-8?B?azZqNG1jbWFOZWsyRUpjRDZFNXg4Y20yblJKVFhBQkhjQnNYZVZwamZPaUl5?=
 =?utf-8?B?d0tYNE9kcVMyRkRqS0NXWVB4MitDakJHNEREOFFBS3htUGNxYVRLMnhkTnBl?=
 =?utf-8?B?K0FSMmdrV0hZczRvZFpuZHhya3VLL0NFd0ZwVlFzenlxTzdrN0RNNG9BRHd3?=
 =?utf-8?B?Ylkyc1RwRkdQa1dOU1Rra2tObGpiVFI5bG5RLy9CYXIwVndnZmluaFpTNVpV?=
 =?utf-8?B?d3lJUHRkdWRRYTJWVDhaYzNqQTNjejVYRUR6d0FNSnFCdEJ4SThyekhadXFB?=
 =?utf-8?B?czFIeHVxcWlQOVVCY3lOWEpueS9ERWplZ3Uxd1Y1UTJacXJLWG1nUzJYaW1Z?=
 =?utf-8?B?NFgwdWxDYkNoYzdOZGV6V04vNnp1Uzg0UHVFVithYTdGUHQxR3p0aHJYK2xJ?=
 =?utf-8?B?REhGUXoydlBWajJVL0lia1g4QnNCNVNHNlA2bURhZzhWNEFYa0hFZzh3M1Zu?=
 =?utf-8?Q?OPjX5dJRlKH06OcuOp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628d6b43-2d4e-4bac-6514-08decb92d7b6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 10:34:27.9203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+oKpWfdv2VTavHSCxB3K6mD0DzrMSefIZaNXTMK8FX70jBW/n534UuC43H6OD9e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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

Hi guys,

who is familiar with the implementation details of the IH CAM which filters page faults?

Timur stumbled over some differences in how that is implemented on different HW generations and somebody with more HW background than me needs to take a look.

Thanks,
Christian.

On 5/25/26 13:45, Timur Kristóf wrote:
> Instead of writing the doorbell in amdgpu_gmc_handle_retry_fault()
> directly, add an IH function pointer which can be defined in
> a different way for different IH versions.
> 
> This is to allow implementing the filter CAM without a doorbell.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 1 +
>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c    | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 8 +++++++-
>  4 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 52258f1341c2..d790b7619ccd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -565,7 +565,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
>  
>  		ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
>  					     addr, entry->timestamp, write_fault);
> -		WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> +		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
>  		if (ret)
>  			return 1;
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 444437c30088..e6e34f6e86f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -97,6 +97,7 @@ struct amdgpu_ih_funcs {
>  	const char *(*node_id_to_die_name)(struct amdgpu_device *adev,
>  					   unsigned int node_id,
>  					   char *buf, size_t size);
> +	void (*retry_cam_ack)(struct amdgpu_device *adev, u32 cam_index);
>  };
>  
>  #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index 6de9e87e04e1..c2431f4c2671 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -289,6 +289,11 @@ static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index)
>  	return val;
>  }
>  
> +static void ih_v7_0_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
> +{
> +	WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> +}
> +
>  #define regIH_RING1_CLIENT_CFG_INDEX_V7_1             0x122
>  #define regIH_RING1_CLIENT_CFG_INDEX_V7_1_BASE_IDX    0
>  #define regIH_RING1_CLIENT_CFG_DATA_V7_1              0x123
> @@ -858,6 +863,7 @@ static const struct amdgpu_ih_funcs ih_v7_0_funcs = {
>  	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>  	.set_rptr = ih_v7_0_set_rptr,
>  	.node_id_to_die_name = ih_v7_0_node_id_to_die_name,
> +	.retry_cam_ack = ih_v7_0_retry_cam_ack,
>  };
>  
>  static void ih_v7_0_set_interrupt_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 85846fd08ce4..30a82fff3ff7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -293,6 +293,11 @@ static uint32_t vega20_setup_retry_doorbell(u32 doorbell_index)
>  	return val;
>  }
>  
> +static void vega20_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
> +{
> +	WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> +}
> +
>  /**
>   * vega20_ih_irq_init - init and enable the interrupt ring
>   *
> @@ -738,7 +743,8 @@ static const struct amdgpu_ih_funcs vega20_ih_funcs = {
>  	.get_wptr = vega20_ih_get_wptr,
>  	.decode_iv = amdgpu_ih_decode_iv_helper,
>  	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
> -	.set_rptr = vega20_ih_set_rptr
> +	.set_rptr = vega20_ih_set_rptr,
> +	.retry_cam_ack = vega20_retry_cam_ack,
>  };
>  
>  static void vega20_ih_set_interrupt_funcs(struct amdgpu_device *adev)


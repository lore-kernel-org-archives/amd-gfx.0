Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BBFC369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 06:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D1710E009;
	Mon, 14 Apr 2025 06:22:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4eOILtiA";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D0210E009
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 06:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsRh3k0RW0hQFBUjlvm2hYj3q1nDkiPHJyTDj6oyZGkpQDx7P/kNhpQyIsEPZDpcZkNpQXGeB6vHczaCfDE/3FZPjv8Z/3tnTSO8R8jpCWYYBv9iFCPKXT3RsqsIDmdjZNFkTve9puFdxrmYlsRJUEWw1FF3+brBwwGVsfbtkMq/XG7sEjTkI4FqSyvF9Qcr/+i9JbX+YSy5QWnW8khWvi4+s2/mbJCC4DBIA5DLb9PXccM5wDNg4LwL6ELw8A2tJWJROqXqjSlXRhQ7FPypcxRlaUc/+bB3l4Nui15x7nPVRU3W02Fse5ivlPecKel1any7NLMuOTt6VRTUTiT5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN43tsvaT0HPssnJy+BHCEdN0cpbqmPpeU95fiCvItI=;
 b=kbmAk6SANYy6k+SM5LrRnoPOFNwO/Y33PSJMfAwjocpwjNhRDw+GuWWxtr6L/OTK0vSYK9itpFqEIV4P2f8Ys/qeZW706QzmgkheX9Ko0RGNBTytu/CXeo3Voq7pa8Q+2MvJ75y/LKX2ui4gnozVJv/1TUuzuOOOxH1jz5o93VvIFalwuXNlBP0wA7k0GIPZ95+8K7Z9rMqeL57FUsdspB5MvtXRQVKN6FjzupNUnDjfxABFrgBZUTjijHHb96J91NjXJXrOgRng65mmEvtKUsKQY+XZ7JnqAv2jBOPMTIr1QUQBIkXFakmp5IYVmAPZCPAeBlFE8D5YXGQLQKgJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN43tsvaT0HPssnJy+BHCEdN0cpbqmPpeU95fiCvItI=;
 b=4eOILtiAaxEYsMBLK/iqWfb7ZuwKv4BTVk7Wl2i8eo3HzUcfxSOvQb9IN1iqJyl/dBR9SB5xRkXBlRJcT22xpwTAwJRurrdag4373wdeGSX67/9lwqEvS1Qtkg3s4cO0nkuZVNfqXG/qrdFHDbGoyXeWopt9jhudMKvCTmmUoTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 06:22:13 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 06:22:13 +0000
Message-ID: <f058f728-5d87-44b0-9e11-9f621216495f@amd.com>
Date: Mon, 14 Apr 2025 11:52:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/10] drm/amdgpu/userq: add helpers to start/stop
 scheduling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
 <20250411184825.2890189-9-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250411184825.2890189-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017E.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4e) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5076ab-bd34-4b22-94b4-08dd7b1cb1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3ZWb3BDMGJabEM2UzVCQ1dvdmZpWUlHUDUvUnJycEI2RkpBSDdHOG9RTWZj?=
 =?utf-8?B?VkR2MVA3Rmt3Y2kvd0dEZkhWeE1uWTdzMjFLSjgrTmk2K0JJZ3FsTnluM0Jq?=
 =?utf-8?B?NmVvUGxkc3Y3eit6QzBJQlRON1BkQ20va3F6dGJDckYzdjE1LytobU1RVEpT?=
 =?utf-8?B?NGhEOWVwYXhvL25XaUwrd3F4bGVsMFFzTHN6elhVYnBUMnFBRXRsb0dsaHR6?=
 =?utf-8?B?WHMrN3RlaERGTHRFbHV4RDB6cytDWXM5d1lJaWs1WDFiUjVwUFhCM3RZQkhB?=
 =?utf-8?B?N0g3R0dwK0VuWmZmQlJCRDBQT204Vk9QTDFzREJhcGh1WnhXTlFqWHRtSklD?=
 =?utf-8?B?VGJHRGVJYmpXQldyZUpFTXEvYTJiSnFnN0haM2cwRUpBdWZiMTMzV3NTSW8w?=
 =?utf-8?B?ODhqS0FtMTdUOU54ZjlCRG5ObzBYeDZHdjJZbCsrMkhBeEZYSXlva2tHOTFZ?=
 =?utf-8?B?Z2J6bFFzTmdzcGxTeTBacUM3WmxQclJxV1ZsQzZUVWt2U3g3cjRtd1l0VnV5?=
 =?utf-8?B?YW1GTVBwdWYveDJWMGJRZnJKQytiNFc3T3lybTNnK1hOV3FrTDdiNnRWTmtJ?=
 =?utf-8?B?T0JjN05nbFdVMFFRZmxCUHRyWE9VdlozbGhTVVJTNWNTQjBIR1IxZmtzSjlE?=
 =?utf-8?B?c1VVemt0dk1CNCttczE4V1g3cGN6dHZoeTFwY3F1N1QwUlVIOVdIbUV0Y3V1?=
 =?utf-8?B?SFF1ajZ4RHRNUXJaQThsZXJJcmtZaUNWckpqLzR2TU50QVdLSTliMHpnekNw?=
 =?utf-8?B?VGM1SVNRTHhBeGZVOXBpb0tKS0hYR0t4TU51WitSOVgyWGcyZ3BGZlRvM08x?=
 =?utf-8?B?ZUo4ak03UjhRNUNGa0NPemRncWo4MDgzOHVWQU9acEZNbVVTSFR3QTQ5dklS?=
 =?utf-8?B?YmhuWkgybFpWSVJhM2hpbzlwU0pWSW0ySWNFU2dHV2wvMkt3bytSc2gvaHJa?=
 =?utf-8?B?cWxpZEpZV2ZZRXNtM2VMZkJHZFVLWmNoS2VJQnZtWGQxbmRMQmhPeDJxVnNk?=
 =?utf-8?B?cFYzeEdmcnVSRkZkdUdlcE94c1NEQ1JCUnpOUG53cDRlVk1uMXUyeGw3ZTJK?=
 =?utf-8?B?VzJuOGZvOE1GdU83Y053NU5PbE02bDcvcnpiZVZzSXN1dzNWR3MwUXI1NFlN?=
 =?utf-8?B?RWIzUlVncmVhVFFkK0djek1XK0gzU2Z6MGxxazFTa0IvMUFlbStmb0NYOWM5?=
 =?utf-8?B?TkxMcVM1citZYnpWRWU2Vk9aSkM0VjA0aGU4SEx5R3dWbktRUXhKYytjOG4r?=
 =?utf-8?B?VU9sbTh6MHpxUzg5ZWlvbnhnRFJndUhwb1dPNld1dTBCeEV6RFMzUlB4MG1K?=
 =?utf-8?B?NDBmbUJsYVFRbUtwaGlKaCtNTmlacXZLVXRFK1l2bzlaVnBSVElBN056UFIv?=
 =?utf-8?B?VklIdkVERE16Y0xpZlVtVkI3dEVHMk9zVENsMEhLYml1MWlNMXhWV3JVMGdE?=
 =?utf-8?B?dGNLQzNwOE5WYkJqSU1HQ294UmVDRlFJdkJnUHJwU1Y5bVV6WmNoUzlRd05Q?=
 =?utf-8?B?NkxvWW9maFAvVzhSNnBjWGxjMXhBNE9LUmdiMlBxdmE5aU81cTIyc3BDcDBr?=
 =?utf-8?B?KzJKVDUzOW54NUl3QmdjOUprSlhORkZxdFQ2SFY4UktjYTg2TnpzY0lmejJU?=
 =?utf-8?B?UW00MVdDdGZSNno1R1psM2YvcTlqak9wK0phOHMyTWdqSEJldU56eUNaUkdl?=
 =?utf-8?B?K0htMFRlMk9DNG5VMDlnN1RPL21Oc3ZzMHpBUzJ6NE9hOXE0a0VDMjFFZmw3?=
 =?utf-8?B?MjZ1QThsczZXK2dFVmlsbGhIOVZZU1BEbUNYZjVhVXlkYWUraGFGcDVhMWtG?=
 =?utf-8?B?VUczWXNvL3ZNYnJYVWYxc3pFa0oxREJ6YlRkQkp6NFJvVnBTZlBMekFFNExv?=
 =?utf-8?B?Y3BtZnFOeklLRE1sS242YkhkZDkrZ1pPbFR0NUVGZnVBdU5GYTdUNjE3S0dJ?=
 =?utf-8?Q?HCykOSdGhfE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZOSzVvUHhhWUR2alQ0NG1hZGVRT2RpUTFMa01BSG9rdHRNNmdiRUl3bkFJ?=
 =?utf-8?B?ZjNRaHUyRVk4UU1EQVo5ZjJNalc5c0F0NzlJZWw4a3RMNHAxdzgydUd0T01o?=
 =?utf-8?B?eGxuam5RS2NtU1hmRTNJSGE3UWptaXZoV3dTcmQ4QnFtU3pOcWFEQ0ptUkFw?=
 =?utf-8?B?SnpscTJxeitDSUpUNnZQdGhGR3FTTlVWc2o4V1BlK2plWWJGeURIUGpFYUdn?=
 =?utf-8?B?VkEwaGVNVHI2NlRCWXhuam9jZ2lpMU5qL2xUTWtIKy9RVjU3MDBEUHczRSty?=
 =?utf-8?B?c3JsaGZJZjM2ZUsvWUUwanpEemc0QThpR2xDTVN3U0RYN0NiaWZlWmI3UGh0?=
 =?utf-8?B?bGpWRmtseGYzVy81R1ZSandPTzAxbGovL0FBMUg1WDJheXBHazJBOEdEZnBs?=
 =?utf-8?B?WjE3WDI3b00waUVFVEI1ZDU0QnZHNUR5bWlHQ3dCbFhOdkhIL2I2Yno2TU1N?=
 =?utf-8?B?Q3o1a2phUGgvZnN1WmF2ODVQKzZkcnJsOC9EcGV3dWdwaTY1VXFvNTBsc1Fl?=
 =?utf-8?B?eE1Da2MrOFNHNUsyOWFUbm9nSXNoQ0lWNHkyZDdoZU1UZ3YrcEtSQS92WXRN?=
 =?utf-8?B?ckdFNlptQ0pjWlMrMUlsWEthaTVMTDdTL2xzSHNwM3daK0wvZDViTFk4YmFi?=
 =?utf-8?B?NS9ocXUyZWE1Vml1b2duSW5EamxXbzFrQ2VYTWVKY2FDS3hNY2dMdytFUXoz?=
 =?utf-8?B?UVhvTzJlclk5cWxXZzJoNnBxSkZ5dGQzOENuZkRFalkweFlNN2xYSlhsazE4?=
 =?utf-8?B?TGR2NDRoZ3hrZmRucVIvOXlKZ09PcElsT3J5eXM5WThXazRNa1RMMVRpVlo4?=
 =?utf-8?B?TjJPNDh4VlZ5YXdkcHJpSjBYSThacjZBdXQya3JheGpBWjZGV0pCc0VuU2Nn?=
 =?utf-8?B?MkxkWklNcWRrajc4Q0kxUVlCUVBFVms3bW1BLzB0YWVkL1FiOS9HcitRSldM?=
 =?utf-8?B?elQ3TkxyVWUwY0RlQVlCRGo3Vzl6NTR6WFVjT0dERlNBb1FVZEd1c2FJR2Vu?=
 =?utf-8?B?SEFZOGNFN25qQk1hVmN6QnZOMWdjR3F2STF6NHMzVlhkcW5GVHErUjdXdHlV?=
 =?utf-8?B?Q2JpNUxZRmpCZDM4K0hmNTM3WDF0WXJSS040c1phNXBmazFhZTJTRzVCWE00?=
 =?utf-8?B?bU5HZktjODQ3VlR1MXlWajdzUUxxcEJITUdYYmJzMUd5akoyOFpyalVCWGFw?=
 =?utf-8?B?czZVcTI4SFAzVE1ha2lvblUzeGVJRnlpbkZqYTYxVExtM280dHRGdXBnUEVC?=
 =?utf-8?B?M1FOaVRUcWpkaTd1SmdlTFIwa3VxdXNPUGFaZW9MNWt4bUhKOHpwNC9NTWJp?=
 =?utf-8?B?WGwrV0hPQUE3TmtmbGdPTnB1cmZaZkVxWjJDOE1jM2Q0OTVTRWJiclc2aDM0?=
 =?utf-8?B?cWVoRlg1TTdzQjBFZnFkQ0ZGS1ljcWhMRXhFV290WlJWSENKSzY0R2JJU2cx?=
 =?utf-8?B?ZDJqcVJLRVBwWi9RVE00QjRJMENJZ1lTTHlURzRtak84dC9PQVVNNzl2RVNF?=
 =?utf-8?B?UDZsR29UUHBRRE03VHdEOG9QMkNjVS9NSjdscHBWMUVKb0tVSGh1cHE3U1lC?=
 =?utf-8?B?cnJBYnFJeTFJM3M0STAwUExOWG96dVY2TGwxV0ZWU2RYQ3dVTmU3T3RxQ0kz?=
 =?utf-8?B?UlBVakxMTmxNTytYZEpla3kzYlR4dnVSUmp6a0N0NW5ZbmRCejAzci9CbC9m?=
 =?utf-8?B?Y2g1YkZpb2loMGs2RUxydlhFNW9sWWlGT2FlM2VHNUl1dXdwWHV1ODBwbHZS?=
 =?utf-8?B?YWR2TlorMlZtb0tkMTJUMHhBQkN0dGN6cFlCYWVCM3Y2UUNaSGc5QUVUT1NM?=
 =?utf-8?B?NE9OeWZ2ZjVWZDArYVQySTNVNWh5RDBEbnRsWGE4NWJ3aHBGbytwQ0M4dXRi?=
 =?utf-8?B?YXJxcXJ4Vk9Uc3RoSk5vNzE3MnFXZC9zOVZFcElEVWc2RHlDaUJFc01WaHpS?=
 =?utf-8?B?Z25QcmxUaER0a0syUElSeFNyMFF4UEtOZTlvZ3dFRVJEODNqYk11KzMvSlJh?=
 =?utf-8?B?REpOVlJGQlM1OE9GR1lKalFzN0FlazhON3B3YnlwZjZDZGZSQkpMSVpXZUZD?=
 =?utf-8?B?R0NYL2o1YmptcXpUTGsva0F2eU5oZ1lKUUc3eUZqQVZ5dDdtaHZYOWtOczFQ?=
 =?utf-8?Q?8OnJO6hohT+G/Fu8rnMY21f6B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5076ab-bd34-4b22-94b4-08dd7b1cb1ee
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:22:13.5136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fekK+DZMxc5YN5p53z0DzwuN1iT7yfVSw2M6yRd4vUp17PyzyWEbzSItZJBdPPMo3ii2MggktCgUSAaH3DLAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/12/2025 12:18 AM, Alex Deucher wrote:
> This will be used to stop/start user queue scheduling for
> example when switching between kernel and user queues when
> enforce isolation is enabled.
>
> v2: use idx
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 72 ++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 +
>   3 files changed, 68 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b156e31ac86ac..30c485f529d17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1249,6 +1249,7 @@ struct amdgpu_device {
>   
>   	struct list_head		userq_mgr_list;
>   	struct mutex                    userq_mutex;
> +	bool                            userq_halt;
>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index aa7222137c31d..5f02df239c5eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -335,6 +335,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		goto unlock;
>   	}
>   
> +
>   	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>   	if (qid < 0) {
>   		DRM_ERROR("Failed to allocate a queue id\n");
> @@ -345,15 +346,21 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		goto unlock;
>   	}
>   
> -	r = uq_funcs->map(uq_mgr, queue);
> -	if (r) {
> -		DRM_ERROR("Failed to map Queue\n");
> -		idr_remove(&uq_mgr->userq_idr, qid);
> -		amdgpu_userq_fence_driver_free(queue);
> -		uq_funcs->mqd_destroy(uq_mgr, queue);
> -		kfree(queue);
> -		goto unlock;
> +	/* don't map the queue if scheduling is halted */
> +	mutex_lock(&adev->userq_mutex);
> +	if (!adev->userq_halt) {
> +		r = uq_funcs->map(uq_mgr, queue);
> +		if (r) {
> +			DRM_ERROR("Failed to map Queue\n");
> +			mutex_unlock(&adev->userq_mutex);
> +			idr_remove(&uq_mgr->userq_idr, qid);
> +			amdgpu_userq_fence_driver_free(queue);
> +			uq_funcs->mqd_destroy(uq_mgr, queue);
> +			kfree(queue);
> +			goto unlock;
> +		}
>   	}
> +	mutex_unlock(&adev->userq_mutex);
>   
>   	args->out.queue_id = qid;
>   
> @@ -720,3 +727,52 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>   	mutex_unlock(&adev->userq_mutex);
>   	return ret;
>   }
> +
> +int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx)
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	int queue_id;
> +	int ret = 0;
> +
> +	mutex_lock(&adev->userq_mutex);
> +	if (adev->userq_halt)
> +		dev_warn(adev->dev, "userq scheduling already stopped!\n");
> +	adev->userq_halt = true;
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		cancel_delayed_work_sync(&uqm->resume_work);
> +		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +			if (queue->xcp_id == idx) {
> +				userq_funcs = adev->userq_funcs[queue->queue_type];
> +				ret |= userq_funcs->unmap(uqm, queue);
> +			}
> +		}
> +	}
> +	mutex_unlock(&adev->userq_mutex);
> +	return ret;
> +}
> +
> +int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx)
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	int queue_id;
> +	int ret = 0;
> +
> +	mutex_lock(&adev->userq_mutex);
> +	if (!adev->userq_halt)
> +		dev_warn(adev->dev, "userq scheduling already started!\n");
> +	adev->userq_halt = false;
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +			if (queue->xcp_id == idx) {
> +				userq_funcs = adev->userq_funcs[queue->queue_type];
> +				ret |= userq_funcs->map(uqm, queue);
> +			}
> +		}
> +	}
> +	mutex_unlock(&adev->userq_mutex);
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index db79141e1c1e0..f9e6c4b728930 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -115,4 +115,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   int amdgpu_userq_suspend(struct amdgpu_device *adev);
>   int amdgpu_userq_resume(struct amdgpu_device *adev);
>   
> +int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx);
> +int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx);
> +
>   #endif

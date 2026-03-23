Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F5BF46104
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 13:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6319410E3D7;
	Mon, 23 Mar 2026 13:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bf/jWH9r";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE27110E3D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 13:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msgfonNe6Nbjho72C/RwJRDSNAltuHcueCBDm5Jh8vmqa5U1Ry+bochAnlEqGxHGUOm4dxToRi4xvwIGi0RAPMMfjzDrbitTrUETqc1odmaY3atX4ZjrN51rThutIPuPkKiwXTrfNL8PBFq+hk9LiFixDo0T8wbFk7r/SOkEK+lUzDjFzhaSL7y9se5AxZSUS0db3lT3eBTLDbQfSuVAj985vp+znQ/IQBjtneklu70dHTblzKFqR9oErUfRS0BytJo2wajrJhV+oL5dfWp0gZKZpcdvSHrFuibn8xct88KDBdTyuGUqatjbLCAkgRLVTFWUUAzAZcsgBbY9IcAs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGnGfkAE0uULd0vB/Ry9ddIGnXuKFXQjM7NL5IB3Xjs=;
 b=lezH+He2vUUl71C8bYb7Ygk63BunWBpYkVfZied6lhjfwpTNRiLuokH7WzJbGubYBJL8R/AcaRJ5eT1U2SuxDoROvMfIAgi3IYJjCAkW8/RR92Olqyr8B/4hubFyOFH+J7Hn6ZVJCR1hBq68yEDAOb2LvWQnAH+XL8SFatHVYP3K/h8Cd5jlCRw9xGHXoKGF94u9t9I5Qqh8A/tZ83POKE1UVYzRmGBGP7OJZoLtUTeVWG9Rd4zgPjFST1T5zWt+zX1KrUfUu3L+PBkP8sxcbNvt187j55Eb7OxbvMF0kDcr7aMy+2Px0PnaPAzXk7nc8+bWIgbhTc/Pz5/DxT12fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGnGfkAE0uULd0vB/Ry9ddIGnXuKFXQjM7NL5IB3Xjs=;
 b=Bf/jWH9rztNvNLvsTECwOOlNnhlKy7bQoJltGHN6rBRbBhiV5wI+T62Yr0ABLXUV3mgKPxz+/vL8kDlACet+1+VuwBy06LpO9MUTZlnE4pR7q7Jlah8Yg1QCibXIaWzenkaF1wSuq5fw1f7C2yqqBvv5CHQ58g67EM8aLjoTH6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:04:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:04:37 +0000
Message-ID: <3a5ed765-3a50-446d-bd26-aa09dfe3d6a2@amd.com>
Date: Mon, 23 Mar 2026 14:04:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 3/6] drm/amdgpu: Handle GPU page faults
 correctly on non-4K page systems
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <1e6240945c2fcb53b6703ae62d4b36f5958ca8a6.1774239489.git.donettom@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1e6240945c2fcb53b6703ae62d4b36f5958ca8a6.1774239489.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:36e::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: f68dee2e-d155-4cd4-11fb-08de88dcbc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BXAmsdU6HAqtgFkBDH6mAnJD4gBG5DccgN+qDFAJR2IT4kB9rnAln6y7dMiWi6hOTuXGmvAAgxcYghoFm88R+7eQxF/DBVjRb4ird00BEncS+s2dfrk/agfPqxH0bmYJFoSXRdQgo8yaOjlVsGH3rJ7win9EGxddxuAmXL6Q20N0rH3GIGBoXViMIq43CK1+Ia7ccHGMXqmFqsaNOGih56ugYAVSeWOEI+/bC7kNpVG1M5ApMZYjKUZVD1mCIb0LirLHJKf5bRKQDbSvDBBg3fzLR3ME2C0enFCABlJIpsbKDbuKtNgjsJXBadkILpT1pamAIwIlVnE7JXNVgQByZ/Zy0Ic813ABN2ZeqSXO4l6lS/2f2yF41hb4oW+eTZKwfSa7qylV3Qn9rHqJalMf+nzjYFapTbOjJFFMqnNSfrmYi+xyogyGmXmbXdPMc3svERJs+avWUSQWrBVfwFIUZn1xhpRi5yBmZOEYz8WG076VmkIWp7+XaOUXwfDSn2jwd4vz3/Slr7E4ALqN3gPyq9niamfpfoZk7bGqq8eMIRJOxPhd2w8ZmQnrELR9OiB7J22k+AnGYQCgLJc6tQc4z0l8ek/heFoZIHFLObZPoxJoBTlgx/yzNZOyqAuNfrJ1dGhMDpMsIvoNbjW7Kn3WRgMYrksmW25pXnhorS1SHyTnpCxNYsC6SNwjPMYItXjU1C72CmWXoTG06DIT+zqrxyxvW08DuVFQdyKponWkKkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlNNQkdHQXNQY20xWDA5UmZKeGFmTG9YYzJHNTdPUXhRdUJTZjd3WDVzR1R2?=
 =?utf-8?B?RDNjelk2WXVvVDFFRE5TUDdHdnQxVDl5VnpSUk9LM3ZuSzFhUVVjN1lWRjha?=
 =?utf-8?B?MEdCdVNGZWh5dmlJNzZaaHNkOHE1SDU3OUIzczJFcG5XTjJxWUVwaWxySjM2?=
 =?utf-8?B?aUhGSmhIQ05LbXdidmpKMTB1bkNjRzNJRmtVdGNlUEpyMElPZDBndm45VXRn?=
 =?utf-8?B?TmFyYkt0YklmQ3FqdjBNV0xKQW55ZHNXY3J0RjljYXZYUFFaTDQ2NjdWbjVL?=
 =?utf-8?B?VG82VGJZYk5JMVQxTERreXR6YnFNU1VacnYrNlkyTHhtQTVRWTB0emNkdVp0?=
 =?utf-8?B?Zkxuc2JrN0l2a0U1Q1BzM2lUcEFpN0ZBU1YwTmYrOWdkeHFMUGRSUlV3Wlp3?=
 =?utf-8?B?bmpJbDJSNkpJTFdNNlVHNlJ3NEJvL2tJTGpWN0o2Y3gvazIwVFpRK3dRMHQr?=
 =?utf-8?B?S3N5akt0bG9rd1YxTXcrZTVQRlYzM0ZUcC9IaXpLaEQyNEZGSnkyMENMYlNH?=
 =?utf-8?B?SUhCdHN1SXAwNXZVQ2liYVpUSzIyRldCc0h6RXRlR1RBUmc0T0JSY1VyVGoy?=
 =?utf-8?B?RG9NRER1YzZKOGF0T1U0REJhZ0d4d1M5QS9wTkNrWWJyenhOOUE1MktwY1JB?=
 =?utf-8?B?TmI1UlJhS20wUUwzemhCVmFEam9FMXQxeEJKcEdnTWlDeDNjK2o4aEliSjcv?=
 =?utf-8?B?YlVZTzA0czRONm90T0hPclNQUEVKNEZLc0xKR3Ztb1l1bDV4Qm1kOXQyT081?=
 =?utf-8?B?Q01ZUTR2SURBWXhOYTNMUndBaTZYcDc1WjFQTDFvbXF5VGt6Sm02ekNsWmJR?=
 =?utf-8?B?QzM1Y0FtRlQ2NlNsdVZsdThPWVpTcHNLbGt2cllrZTNqYnJETlVFN1piS1J4?=
 =?utf-8?B?QUdZR0wzQy9vZlNjaFFoLzFoc3NFMUNUSE1XMWlNTkJQc2lBTnBOSXE2UnJN?=
 =?utf-8?B?YWNVTnF1QlRoNW8yMGVhTnFSR3o2VTFDUUwvYnk1THduVFlpZ2VmV0UveWhz?=
 =?utf-8?B?MzBZakNJdUFBTTRmeHdYTjlFd0wvSmhlNzlXTVQvdnZINy9xZlNHcGd0RFhO?=
 =?utf-8?B?Y0ZRbTg4Q3ZwUWNOOTkzSjFlbWdLUXNnTG1LNGVMV3BFZ3l0R0g0SnJDaWhU?=
 =?utf-8?B?RjdteUVkdnV6L3ZqdDFzdVArSDY0bGJvdDlHeXFqNS9GcTJmeXlRV2VVMkRi?=
 =?utf-8?B?ZWtYNDExcXJIRm5oZWx5dndsV2t2bFBKK1drcGU0TEY3Mm1yeDhESGppV0VL?=
 =?utf-8?B?UjlJOTFuRW04a0xUcy9VWm1VZzVIZTZoRlpuN1RRWTN6VE9maWFpNU1GeXlB?=
 =?utf-8?B?YXBJVFFjMjNDYjNST1I2a2tUV3hZcG1GTkp5Zm5ybndHS292UWhuakFCT0NC?=
 =?utf-8?B?Rk9VT3dOcmNIWjBkcUM0RWlTYU5ORWFyTWFVSEdvWStaTFZIa2cxK2FhVnA0?=
 =?utf-8?B?ZkpHOFl1SGpUTjNOd1NKTTBETXR0b2JLVmM1UWttWFpnYTdqa2VBeE52b0xm?=
 =?utf-8?B?MitETEduTmZ3QnYwVTBvUy84U0toY3JoYitpZTljYWZRVnZocXZIelRlLzRr?=
 =?utf-8?B?OGVBMXE0K0JtNGdjeHJoeEttWFZCUFZHWC9DSGxyV0FTczd5WlFJMmpOTTVE?=
 =?utf-8?B?dmhUZVQycStsWndxQ0NmVnB1NDVkbEMzL3k1a1NEM1pONnMrLzVyeVhrTTJl?=
 =?utf-8?B?Vm1RQ3ByQzJWdlp6ZW9kV3BBaHloWmFnbWhwMUVEcWtURHVkU1g2VlQ0SGZU?=
 =?utf-8?B?TGxPTXcvS0dtdi9zamxuZUdMU0N5RUo1S3ZFUUUxbEFFYlZnOEw1aWNDaVlD?=
 =?utf-8?B?TkFlR2Jrd3BUbXd5eFJMVTh5MW5qWW1ZWGhLRVNFcys1ZnNrWDJtaXo2SCtB?=
 =?utf-8?B?SndkWWZzQXpxeWUxQi84N2N6UUhpbGlSZGtRVU02NXZuSkx1R2RZWkw1VTB2?=
 =?utf-8?B?a2FZM1BzMmtOSW15OTJRMGRMa21nMW83bGtxSzFlQVJPOFd5L1JsdnVsbWtV?=
 =?utf-8?B?c0pBWUZKUjZ5eSt2dVJTazRFV2pjS2hEWk1MR2d6a25kbExxYk5VeXhKeURw?=
 =?utf-8?B?US9DSlUwQ1plN3YwSTVGdThXY3JwdldOUXJFclhyTVVzUVFnZDRha29LZG4y?=
 =?utf-8?B?MDgzV0FhVFNMSlFGRGk4cEMwWXNkNEx5RWJzN1Nzd1NmdEdlM29pL28zek9l?=
 =?utf-8?B?RGRabFptYi9kUGVpemdXbkhsMU0wUHdITWhNdCtiaU9BaDVubys1QTB4dlVx?=
 =?utf-8?B?SnRkR3NGTEk0aVFGNytZMGN2dFd3NE5KZjNHeWEwbVVMYVM4ZTc3NXNXNEtG?=
 =?utf-8?Q?n4Ukc54yH1yRAp93IM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68dee2e-d155-4cd4-11fb-08de88dcbc7a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:04:37.1054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZB06T58vHb537o1w5E5Zmkg9IfU0JE++9B1A32T3h2nkB7YLWfAOFPFkcq3UMLOV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
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

On 3/23/26 05:28, Donet Tom wrote:
> During a GPU page fault, the driver restores the SVM range and then maps it
> into the GPU page tables. The current implementation passes a GPU-page-size
> (4K-based) PFN to svm_range_restore_pages() to restore the range.
> 
> SVM ranges are tracked using system-page-size PFNs. On systems where the
> system page size is larger than 4K, using GPU-page-size PFNs to restore the
> range causes two problems:
> 
> Range lookup fails:
> Because the restore function receives PFNs in GPU (4K) units, the SVM
> range lookup does not find the existing range. This will result in a
> duplicate SVM range being created.
> 
> VMA lookup failure:
> The restore function also tries to locate the VMA for the faulting address.
> It converts the GPU-page-size PFN into an address using the system page
> size, which results in an incorrect address on non-4K page-size systems.
> As a result, the VMA lookup fails with the message: "address 0xxxx VMA is
> removed".
> 
> This patch passes the system-page-size PFN to svm_range_restore_pages() so
> that the SVM range is restored correctly on non-4K page systems.
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6a2ea200d90c..7a3cb0057ac5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2985,14 +2985,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  	if (!root)
>  		return false;
>  
> -	addr /= AMDGPU_GPU_PAGE_SIZE;
> -
>  	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
> -	    node_id, addr, ts, write_fault)) {
> +	    node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
>  		amdgpu_bo_unref(&root);
>  		return true;
>  	}
>  
> +	addr /= AMDGPU_GPU_PAGE_SIZE;
> +
>  	r = amdgpu_bo_reserve(root, true);
>  	if (r)
>  		goto error_unref;


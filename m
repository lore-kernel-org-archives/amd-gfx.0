Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DB7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 21:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DFFA10EB92;
	Fri,  8 Jul 2022 21:00:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17EE110EBCB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 21:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfFI+vQKFEyCW6Dhl50TjrEicqRsPeHnk23SNKmvNGFOnQOX7evAnrTnaHIWf6jUqSzDlYVe0Rlp6capG9fEyinIFxb8GSAULUocnjAAhu96Xgr5h3ESc5AsFtBRKzlqSwUGIH8SlcHzvnsF0UqIwv5EuX/Pa4u9ClgFRw3WxiRpU3JrzsAMCNuA3PRjRPMWyUkCgLGiu7Crp+F3rhWml8qTC5xcHaRZSYJghu/vTW/Vv/R5A/R8bH2DZO6T9VD69V4XHsNVLOKmlal8uRmJsFm7tGlOtO2zWtmmxpxR2jPNHmMaRkn8W9NRBDA8iqdUnyLpDDdcmvXJVcz6xOdHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMbMB5R7G9IHjg4xTk1aARu0tLCqv7NO9vAxIiAoY14=;
 b=Mrjtw5RM/5UxjpFF1LENrezeXkdOzIGwbDAYFjDvwjsLPULY/B3nIuPor+lg8ffxT8kU6qlQsJr6k8E3mptuADqan5zwG+UZ2MYaMtUcBdOUQ5WcR9woINycIV3N3jVAfY5auyDK/l0UayGahO0PVOGeJWWXCcfoGOv4NJPs0k7dpJP9NwHHhgr4rCPZlQMVXArbtVv3KR/mBnIcaLvOqbWHMqjWxMNEktojhHLCYVzRbEcb/V10+Wg/wfayGmwQ80DtbS4/U4+ugFypubZxuQAECw4TVmTGX6u8ziYrZ2bjzGoj3Umgwx3XUl2/R3JkyZKDxhE+nHf80JkJlqsemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMbMB5R7G9IHjg4xTk1aARu0tLCqv7NO9vAxIiAoY14=;
 b=jG6XbMk28eXXSA3BdewLBQhQB7IM9C+rxWqJJwG+SkanIrYrS5qxbAageEm3DeGadxy72sLPLZDPR3Zg7g/Y22ETqDSUjNOTpLi3wOZJBZxy7EB2LPkd3mytksCwJp3MAYLExeA1vYY6W0DHh6se0PJK3KQiDWKsmoLVTZIm5QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN8PR12MB3123.namprd12.prod.outlook.com (2603:10b6:408:42::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 21:00:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%3]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 21:00:55 +0000
Message-ID: <a0ebed48-08bf-9234-e418-2c6579d0f18c@amd.com>
Date: Fri, 8 Jul 2022 17:00:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Remove one duplicated ef removal
Content-Language: en-US
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220708015346.3027-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220708015346.3027-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:610:b2::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a891c35d-9ec3-4e9c-8426-08da6124f301
X-MS-TrafficTypeDiagnostic: BN8PR12MB3123:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ul3URpCexOGBeeMbHYQPOvuPRkhzmicD3tD6MEAd2PtDxxJzB6aYutgPfclFdfPjB8ava9L/Htm5AuZeSiojAhXMnRH9sYmj6q+CJsKiFyO89BuzH+WheT0wVWWwpllN0BnPUKBtcY/wx9wQrPi9gmAVS+wp4KVg5lMlFopCGnY7n83gz2xnUpe+veL5RJ63VPDDWLPEB2mfhy0htOnjPhPXh8XlfiM09WMHiUPwMaQezhz6CoaZsTe3lsNWb5n6p8hNlZAPJ4LGjGb6vQDScoiEcq10PYijqLGdZCFusfffTrRS4Nn6+Qyr7nyBF97+5+up7MtE9ew2ZIf712MZNLggyNtIr14gQRBdMFv4eu4whpY6FtJmoInvvtOCGH7bM5i2+qc/OvzHACYwD3ZZRFk+XInNFiu1c5xi+vyoksvbal+PheUSaL8gHMK9c/FPRz0jmly/RqgJKOj5JekKj2nKQ8tlTUMgIpSN58qbdsN6ks0D3ZNMxeJGqM5J53h8aPpLCHAnncNlNWYhIGrFO4xYgIW/f8wSTzSgf2f4LL5yWwbZynS++lYHxCVxrlgcfj6FXGpup7VVHznsS5+uKm9MbxxAzrpJEyjkoCp/bfjq+7bDD3JD/UfVv3SCVgsHugtkRj1y91HDQ38t/HOYN7p42JyMxfNbVAlnacGE+WAnu+IhuKbLq8ihYnc+vvvUfQyqSLOl2LDKM8TNfJTlRvSqlzhiFdt8ucc+4fHre4T1K9FoIZ5rcML+UGhippHHOhmCfN7rqx11PkU0asxibKQtLiXVx1d1O6I0KsO7QroARaQa391BDYzmPR1UUSatJkbI4Cd4pt0sAOfJh+OW8fdCYS1jIqw4YvHRw79aRbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(86362001)(38100700002)(186003)(44832011)(6486002)(31696002)(41300700001)(2906002)(316002)(2616005)(4744005)(36756003)(66556008)(66476007)(8676002)(4326008)(83380400001)(5660300002)(36916002)(66946007)(8936002)(31686004)(6506007)(6512007)(478600001)(53546011)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWdnT2hPN29sRmdNZFRpN2ZQbWtYMFBtRGpVNi9QS1lkdjJjc255em5tQWtu?=
 =?utf-8?B?T1ZhS1g2RnBPOWcxeFd0SGI5MkhuTWpLUUVYZFBzeWhuQ2p1U0s4eUFvRGVn?=
 =?utf-8?B?YlVueUozQjMzWHFsZ2RsZHNNc09OOWlZVmdMNXJWS0RCd2VwNlBVbm11b2Zt?=
 =?utf-8?B?Yy81bDRNdDBCOHY4d2luc2QzSVR4ekE0eDRjV0R1Yko4QktUeWkyUUFGdU82?=
 =?utf-8?B?cDNLUG0zR0lBWWZ6NklSdVJHcWZYUnRsWjkwclhjZmVxaXB2d1dKa3lwK1Q3?=
 =?utf-8?B?YnpMM3B6ZWlYQVA1Ylhma3JHVHFzSUNxS2ExK0toNUVYOWVIYkNxcjhiaFFr?=
 =?utf-8?B?cTQ5TDdLR1IrdVR6T1VaNS9QcTNuOVNyaTdnZ1NHV1NWVmYyS3F6bURQYVBV?=
 =?utf-8?B?dzJRMEF2dkgvQUFnY1g5My96eGRoOUtsY0JCRHdlT2tZanhqVHdzd2ZlVlhP?=
 =?utf-8?B?ck8yMUxHcGNPdTRnTUdYdEg1Mm5xbEIvMEw3U0c3KzNSR1JvRVFOS0FuUU5j?=
 =?utf-8?B?ak1HV25QMmZJQjFxcUF6L0VnZjk3WGdsSi8wLzF3aEcwNUEvRVVTQ29uTFUv?=
 =?utf-8?B?UUVrc3NnQW9jaUtFYnZOV2V4eTNUUjJFcWVvamR6MTF3RkxpUnhweEROVHhr?=
 =?utf-8?B?eFV6bEdwbHVFMjJqOXE3ZjByeUdwMm1nK0FQYWNVODNPU25mL3c3TnJJVDZZ?=
 =?utf-8?B?aW0rZW5Yd2xpZll2a0N0NE00OGxwcE1kMnUrMEk2NTBkYTdua3dZUStaSTgy?=
 =?utf-8?B?V2huVnpJTlpJR3h4cXRielZ1Tm5IZGhIS3hDdFBmbjludXNFWVd6SG53Z1gy?=
 =?utf-8?B?MFFpeG91ZkZUU2hKWVgyaFNUaGtGTitjeGdFc3ZYMlpQVVRreUdqQXZ6c0pK?=
 =?utf-8?B?S1hiY1puTzNjMmlneURKcnBaY3RZM0tiTy9nZmlKU3p1Sjg3THlyNmFndjZy?=
 =?utf-8?B?eGVCL3JVcFVOSmlaRXFSd21YdGVOZXNrUTIvRW1vaUpTNjhUUlNFMDhsNldk?=
 =?utf-8?B?QmVvb1FteXdvSHBTbGJ5a0pSa3djV0w0SDRkY29jS3RRS0ovdWhoUmRSOTdF?=
 =?utf-8?B?cmhscWNTQkt4ZENZdE1BWmdqZGJ3TnBDdFR1QS9TVlZuczZxVEpFRHZTM1Vl?=
 =?utf-8?B?dkVWcHVVeGNUcHNFQUFSQ3lhUW9LeUJFMU1HWXVZWmVkeDZSWkVlTm1iRVNw?=
 =?utf-8?B?MFlIVmhnYTB5REpxbTFJWlhHUmZvbjg1dHpmQ0ZlS2pkSUZHWk85aXVzY3pF?=
 =?utf-8?B?MWY4UnNmVEVLRWl6djZFbExiZ24vZ1d5VWlKSGtIT3d4YmJDVTdQeWRoMnlY?=
 =?utf-8?B?Q1dMSEdSNUFpQXFKbHRwR21sV3d3U0R2dFp2VmlZY1lKMXljUHc5SHY0T0FE?=
 =?utf-8?B?blhqS2dka2Z4cUR0MkNMdVZGNG13dmpLUjdnNnN6VnZ1VWxNSWdMUFcwZVNX?=
 =?utf-8?B?OFh5a2JISzJCMzVabkhVRkVCYXNVOVRXaytXVkJaMUxQcXJCWDFDTHlsV05L?=
 =?utf-8?B?STFxM0lwY0lVQ2FJZzhTemFQQkJIaXhCRFlrQ1VkRE5zcURmcUM3NHczYlFL?=
 =?utf-8?B?a0xQNG1HUVd1NmFKd0dvMkowajQvdUxIVEwzMWd0TVpWWnp1Qkd3bWMvZzhK?=
 =?utf-8?B?SHIvMzVTbkUrL1k2SCszQVU5bThnQkVLcnNEdWFaRDFKYlRQdmtGZFpwYkZv?=
 =?utf-8?B?NDVQRklrczl0aitlcWdYRGpZcmltUXE0Y240ZVNnQVBCQ2wyTzNZY1I4K21H?=
 =?utf-8?B?dVRUYk9DdkwySmt0cFc2UjlZMUErTEtiMjdMdmhud1JtbzBEMUJLWEE3NDJi?=
 =?utf-8?B?VHRqZUtQdVkrNEJzZU9KWkw3SFFJaVpNbHE3OGtXb1VlRmM0dUFBRGUvWWxz?=
 =?utf-8?B?WUhFSFYxK3RYQU45QUVOU1JuUks1bzBZVGQvOWxCNk1rTFhMREZ5QjBURVRM?=
 =?utf-8?B?cnVOdmZKbzQ2RVRTR2VFUWdqd1pTNzRZaXgwbzBJRCtEL2Y2QlFPWUJ6UStp?=
 =?utf-8?B?dFpPRDl3L011VjBCOXlWYWk4QlY4TmJtQWtJK0RoNmZmNDBWYStvcEw0OStD?=
 =?utf-8?B?SG1acUdFQXNvb1dEdmRtSDhPQTFhdkU1WUM5YTBvNnloc0NrMFowVDNqTkZq?=
 =?utf-8?Q?bhDjhDKx61mG3EaiKpKM5yu7X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a891c35d-9ec3-4e9c-8426-08da6124f301
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 21:00:55.1119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGv0nliZEpphyxKtocFEcBphWM8I5lGCeB+yBE+NZUgBeromaTwigDayeewg9JXU09fM5wBpJdvCdtVn2kQ9nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3123
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-07-07 21:53, xinhui pan wrote:
> That has been done in BO release notify.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0f9811d02f61..49536fa8d269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1583,11 +1583,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   	if (!process_info)
>   		return;
>   
> -	/* Release eviction fence from PD */
> -	amdgpu_bo_reserve(pd, false);
> -	amdgpu_bo_fence(pd, NULL, false);
> -	amdgpu_bo_unreserve(pd);
> -
>   	/* Update process info */
>   	mutex_lock(&process_info->lock);
>   	process_info->n_vms--;

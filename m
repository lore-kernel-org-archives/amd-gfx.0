Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB10C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 19:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBD26EA16;
	Tue,  7 Dec 2021 19:26:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D36B6EA16
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 19:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFE2P9cbCXoNf9K5RuMc8s1VRvaZQFaxPw6acAZore5w7zqG18qJQZE8e/wT1jI264mPvGGo+KtMsqXjmuP9UFsZLccTRtymmtKvzHrAXE5lvz+o/XKm8LNUgrIxuAs/4kMSUmL+GlU3J7IVohmdnItYQVbypgp73ruZDyrs9k7NP6csU8a6CciEGDKxBNXZ70KDSaMy9+dOerPtf5/0Nf/yp+9Xju/KCBa+045qFlwywgvdYIeHxkWayoWVSjqVbZCvAmgahNE0vxZn5NBFSISLvhkljZDPnH8zbG9pQWq2064Yc30AdFZFoZxUL/MI31bRR+n+O45F/zUzRoqRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkEGE/x/sm4I/s0YOy/syW6zjf+YB6L4mChirQl+xIs=;
 b=NoSJsseHgjyLoOsaLOSzq0FSKGfTO9Y7jlcfEXsEiZdlS2h0yYYF6yCKvEkfi89VkPV04nz4THItIqBhUXpE/GMXj+MnV2n2h97azn0v+FPeG6Re/8WfrlG8G14IAhXs18ululehzlT1CAmHOH9eP5d1+eCqXAStq5JL5+jIta+XqdlQUJj5EZsFuyyNM0qai8InGy7qDeb7tEn7kFYnySmziFLI5jtml1mlTD7qJw9W6TXVga5hHp1v5/CmK1Un6EFoR42mwfI5YJZQLOzmKCSaOOIyFgMv0Oeis5vbbHWrOLVddjMYcrmvsRrxOeZJJXBxK1RplyqaWzsr2Jeelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkEGE/x/sm4I/s0YOy/syW6zjf+YB6L4mChirQl+xIs=;
 b=HBSenfYMz1vTV7jUXcdXSbzF+8sH8fh5ZB3DcEPmHiF1auOHCLT6m8KUSHqEMYzkoAIrTxh5nGtN8xrKDu8wkr87tx85JSMPH5Cx7+pkHrclFf8nRQDc6HJxXulsVwCfpnv5WRiqvLm/DRf6OKGFdzBAQqGnIlG0iXnUFrNTcGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 19:26:22 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98fd:4e9b:b4d6:64a3%5]) with mapi id 15.20.4734.024; Tue, 7 Dec 2021
 19:26:22 +0000
Message-ID: <04b1bc16-0547-34ee-b3e2-334db09967fc@amd.com>
Date: Tue, 7 Dec 2021 14:26:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1] drm/amd/display: Add Debugfs Entry to Force in SST
 Sequence
Content-Language: en-US
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com
References: <20211207185541.349209-1-Jerry.Zuo@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <20211207185541.349209-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0033.prod.exchangelabs.com (2603:10b6:208:10c::46)
 To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 MN2PR01CA0033.prod.exchangelabs.com (2603:10b6:208:10c::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16 via Frontend Transport; Tue, 7 Dec 2021 19:26:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a62600ba-8341-469c-56dd-08d9b9b773c6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5086:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB50868B4A9E0923C150E23846EC6E9@DM4PR12MB5086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DMk0mrne+xsJRX9zBlL0bSZBiPUSADJpmnucB/UtrHyn4dnun05M4qSg9xCDp95tQIJtLvxEdhVIwq4ZPtQ+OzT0b+gBt5WCPe/0z5IG2/o35jJ51lxywkigLZzQn+1oiD3yuY6rgubcLuXGrbUYgnA3Ol2uJIcvV6ZSmMC+SDccNaH0SekZdNJQ9GN19ERKWahaaCfwYIb3c/zTp2qEeR7yOQ6XvwkCYgMCTTgcM24LD99QImlVYsSg1OP0XRQvPCo37fnusfnyLnVi7wIz2atO7e7Dgi8zA9Av3oRhcsmuZBiETwaKjlCbzOLPv3HkxS9+QbUKBq7K3Q7XJxwYsKIXbnIApZzFTshoQ6pLTIPD8y3YX9AfQOI7WdHtdtlQdcXKYXoudgbYWGI0ofTo2afLnytiSySdYfjngJjhfNph770RFVqiZqNyCE9onhIWejt3DJhA2TOst8z1TVsV36KU2tMESaN2Bfbc1CAifSmFN7o/6tW33Xtz5nOlPAeQF3FqWi9eTT6gyZJvVfHCp/WQdOxWex1PLF77zqak/7zBXDWw5LmO5ARlzD9HNwxLSNYuZEVZjc/5nRYX05/tKrl7SLF7fn4zWn9oNOgNxyCxr9U5mzv41cky6xFDO9tqTS69L/v4EOSK55+qi5ZZ3Z9beowZwt1H1W+qDbuSPL7Gbi7gqXRZpKxApvezvL+hKf5+eLIGM4r755FjlgWnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(6636002)(36756003)(8676002)(5660300002)(316002)(508600001)(8936002)(6486002)(2906002)(16576012)(66556008)(66476007)(53546011)(2616005)(956004)(86362001)(31696002)(26005)(186003)(83380400001)(38100700002)(66946007)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TExpL3YvR05GT2lxTWNZdEhRdWVDamhxUUxmNllOOVQ5dnduR29nNjJMcFE4?=
 =?utf-8?B?ckdnbkN2U21RT3VwckRNNERzSFBkcy9SWHFVTTZweHU2bDNEbXVwUVhtWUIw?=
 =?utf-8?B?UGtkNlRTMVRoVVFaREc2Y0hBamhFallGVHZoS000VnlTS3Y3dXV0OFZnQmFE?=
 =?utf-8?B?bEZtcy9KdmJURnhWRTM2NE9tWHV2SmZ0TnVrUjM0WVVLZThuMHNVU0IxSk5K?=
 =?utf-8?B?bmNQdTYvRzMwbzZsbUcvS0V6OHFzd2pyWndYNld2b0dYTXZzQXhZbFJFbkJw?=
 =?utf-8?B?UFkxZ2xzK0U4bk4yd2lwNnhWTUZSYjZJNFF0VTJYY1FMb1pZQWIrWVE3TGFp?=
 =?utf-8?B?SmV2UDZvWEtrNzIzM2pFVnlkajZUYncwdCt2WEl0dFVVeWdLWjgyUVJWYk1t?=
 =?utf-8?B?ajhvUTdrRkZaOUpQaHkrMWhxRTZkWUd6UWxnbjRxSVIvWWVmU3o4S21SWWxx?=
 =?utf-8?B?czNxRTBHa3lGb1Zoc1hjZW9qUkpvbG9IS0dHaVpEeWdFSGxhRUFSb0wvUnd2?=
 =?utf-8?B?MVQwTEN0SzYzWjVoMW5vQmRUd1JRREZhb2g1d1hBTkJ2dldicHVjL3NDNFY0?=
 =?utf-8?B?WERoYytENGtpaHVFV1FaMUxuUFo4TFdtYWgrN3ZObGdXYzVWVG1OYUk5alFS?=
 =?utf-8?B?bjVYblB4TjdDRDFsa3RPeFg3cGI0dXFQcktIdXpMblQzemFUNFI0VitDNFA5?=
 =?utf-8?B?dERpNnpZc3o5aGNVKzA4UWc2UDVwOUpBZU96RVZhSWZ2SE9DSVQyQ3ZMODNQ?=
 =?utf-8?B?TkFYMWNKdWZ2OTRQeG45TlJFVVJzSTB4aEFBZzVYYlZVWHo0OHViQWRoZkNh?=
 =?utf-8?B?U255TFlHcnJ4Y2tPR2lBSWFWVXlCaWJUUk1WN1FJbjMzQ3pEMW1LcUVRZ282?=
 =?utf-8?B?ZGR2cE91T2VJOWdWNnQ3OS9GcjlqL2hjbTV1U2gvT2R1a0hiSmduVEQzaWxu?=
 =?utf-8?B?SUxYaFVaZmJ4N3VKVEZaUENnSnUvMnFwdHhmdFE3ZFpjK1dPN254Z3ZpN3gy?=
 =?utf-8?B?SjlISTMwaE92amE1eTJvajg4UnlZRVpVK0M4Vko4V3NuYURRVDdMd2cvK3dl?=
 =?utf-8?B?bWE0S0VTRGIwd2lZTXdQNlBQTllOaFlseWFBNXBXUXppWXZIQUZJcHh2L0FL?=
 =?utf-8?B?K292NFVkeFNTRU5HZXVuNlNxeFhpL3BLVGpRMEJUbjZnTWxtenBXcmhSQ2xx?=
 =?utf-8?B?d0xVdGZWczVpMGlUNFJrM0lPZjlwRldHQ3hTSjBDSmVrQjFwTmNKUmJkd1hl?=
 =?utf-8?B?am40czZoTjNSTy8rT0d4RjlvbUR1dDR5YWRvN1dpbmlLY21Sbk0xODBMRUZQ?=
 =?utf-8?B?Ym1sdnRjRjc4aUVLWkl4SXd2bVdyOEdhTlZ3MG8weXFBcHdsbDZvbVc0Y2R1?=
 =?utf-8?B?QlJ6WU01b1pPbC9oQVpCZTQ5VGVCRkhXcTI1OHdPK20wR2w1cUF3N3ZpZC9T?=
 =?utf-8?B?YWFSYUZpYTFsSUJsbFp3b3lSSHpML1VZa25PQ010enhESHgzUWtlQ3F5ckoz?=
 =?utf-8?B?OWRXNlhwclV6aU1Kdk9KdzNwYnhmK0QvSFYyNm5IeVF4N0Y3NEgrOUJSYVk1?=
 =?utf-8?B?VDdWMklyMWhVbmlvS0xHRld0QXBVSXFidTVCc2pzL1RtRm5wODNZYWZKTmNx?=
 =?utf-8?B?RktGMVJPSW9wSklsUUFwM2lVbTRWZk1YZjNnSE53blVYZUdHVGprVjJRK0dq?=
 =?utf-8?B?Vk9jMzh1c3lyT0xVa1RtTW9UclVGekNuWW11WVBmV1JCMkpCZE1hYVF3WjdV?=
 =?utf-8?B?ZTZ1dVk0ZmthTjlMUURFUjBtenNTVUhxMFZHaEJKVlcxbkYzS3JkcDN1OHpB?=
 =?utf-8?B?d0NBMjl0THN5MzJyY2x0UExoNkpYUElSN3FNcENod1NqZkNiL2xhSWxncXNU?=
 =?utf-8?B?aW9lWnRGT1VySjhuZEJCeS9NQ1Vid3lodkNpeUZMMHlxZFZ3amhUOHIrRzQ0?=
 =?utf-8?B?MGhEWlFSZFkycVpnU2J6K1ZNVkU1WnZOQXJkYWxRcXlaOVFyRUQraTBxMXhI?=
 =?utf-8?B?UVEzanJnM21FeFQ3a3VMdXprOE1LVlMwM21QZ2dhSS8vUGxmdUM3V3lHNW1q?=
 =?utf-8?B?VFdDVzAvbWtIWVB3MkNOVDlhR3h0L0ZqaUYzb0JOUHRsdi9QeDV4cmRuZkVu?=
 =?utf-8?B?TkpRdUJtM0hnVXJpQzZvVzEzZ2pLdGNHcU1QcHZycklyK0dFMGU1N0hLbzRj?=
 =?utf-8?Q?/rheiVglmfa2ns2hUKaUve8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62600ba-8341-469c-56dd-08d9b9b773c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:26:22.4188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8F+TuzIvD2gB06RhAKH6kM/HyKn7XXFaaUe36qd7IJS6y+/UyxQEy5DHgCtoqYpXUBN++9w4MDWMtVf5oB/k/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
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
Cc: wayne.lin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-12-07 1:55 p.m., Fangzhi Zuo wrote:
> It is w/a to check DP2 SST behavior on M42d box.

Isn't this useful beyond just the m42d/dp2?

This should affect regular DP MST support I think. Adding this debug 
flag is okay I think, but I think the names should be updated (inline).

> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 27 +++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 31c05eb5c64a..9590c0acba1f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -3237,6 +3237,30 @@ static int disable_hpd_get(void *data, u64 *val)
>   DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
>   			 disable_hpd_set, "%llu\n");
>   
> +/*
> + * w/a to force in SST mode for M42D DP2 receiver.
> + * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp2_force_sst
> + */
> +static int dp2_force_sst_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	adev->dm.dc->debug.set_mst_en_for_sst = val;
> +
> +	return 0;
> +}
> +
> +static int dp2_force_sst_get(void *data, u64 *val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	*val = adev->dm.dc->debug.set_mst_en_for_sst;
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(dp2_force_sst_ops, dp2_force_sst_get,
> +			 dp2_force_sst_set, "%llu\n");
> +
>   /*
>    * Sets the DC visual confirm debug option from the given string.
>    * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_visual_confirm
> @@ -3371,4 +3395,7 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
>   	debugfs_create_file_unsafe("amdgpu_dm_disable_hpd", 0644, root, adev,
>   				   &disable_hpd_ops);
>   
> +	debugfs_create_file_unsafe("amdgpu_dm_dp2_force_sst", 0644, root, adev,
> +					&dp2_force_sst_ops);

"amdgpu_dm_dp_set_mst_en_for_sst"

...might be a better name.

Regards,
Nicholas Kazlauskas

> +
>   }
> 


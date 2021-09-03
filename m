Return-Path: <SRS0=/nsf=NZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64078C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 07:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CA660724
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 07:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10CA660724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7FB6E84F;
	Fri,  3 Sep 2021 07:53:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3C36E84F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Sep 2021 07:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwveZyUmQpY0POGoPE0VyXT0agqJUQIbj3ZaDf42KOFbX3LnGGVyr+qiUgmD9U4DqovufjPYmx22kxnYkW44J+YgLvxOv6kG6xysVywQr49rqwhyUcFTOng8N7S5sqJd3nK3SGVCHLVo1yxfL4O4Yz3JG/OWVijRYGX+XiAAi01GJSPWI3HkWkTn7EoK7IA2ewgoqX/pRvDOw1Nt+ugf6Khzbb0tXzJnbekjuge3B1wfIHxwczSBicxRJdhkZ6fn6c/oYDw8IuSSN0yndSsD38YNQpzWflkxXiFyZc4CuGR2ImdFKXUVrBPIkUF6VVi649kt/3BdQusfmJdvFlsJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=syW/pk8G14/Emt1YIAdLUqTI53N0+wK1mZHHqX6RoVI=;
 b=QVENyvsmvfbzbGf7VWcTQfMsjqUBLKSiqK8N3lZDQBzyE8rvvPReR4ryVjYT2i9nmKrqoqXt80YySSI4oZ4FkAuEVB8plyLMt30quOtX1lBZdFn0J0SmpPdQFp3hsrRPFsv9LO71DBmR5AjhZYppaXMkIP3hNQzohtPqTw9yBijENS+TwPE0odTQu7L7Ce3cNShTY8r/PBX7y5/x8bD5qAF2XKZukfxowwKMgnEjCLoW1lVrzA8P4/jibLylKwcIJAj8ulW8RMkJljXBT+D4CcQCU6Y9QQVCofLsl+77AB/kEIPCXwIEh6WPAYT5o3rYi24GdbB8MBFMzOxIQpx4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syW/pk8G14/Emt1YIAdLUqTI53N0+wK1mZHHqX6RoVI=;
 b=B50jFruOID/BQbNZl9Q6Mtay3paFL8cd3EEGe3khKfMDrklkQ1vZk+oZpvB71ay4op8dQ6+9q3czbXBYW+BRCjEnIKlHShq8je6B/vP1pXxCqJp84cPIIEMtC85dgUmUrg4dR7Q0CAbCnj3lXezvmgpdfK1653LouqY8CmgyX8U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 07:53:47 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 07:53:47 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: use IS_ERR for debugfs APIs
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210902114459.3866-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5aeadf99-0864-1e45-63fa-a9f299d373f7@amd.com>
Date: Fri, 3 Sep 2021 09:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210902114459.3866-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0190.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 PR0P264CA0190.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17 via Frontend Transport; Fri, 3 Sep 2021 07:53:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e903e4cd-513a-4cfb-ea14-08d96eaff597
X-MS-TrafficTypeDiagnostic: MN2PR12MB4390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43909AC241AAA38231A82DFA83CF9@MN2PR12MB4390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH+dvtJRB+bZA+EQsJDoZapHSHB3bFcbkaq8Q1J5GwoyZP10VGBseBFAdjRbZbrABH1EdkO1Hw56Qtnk63TvFF0CjemkTZ5LptIHMEzfzA8fS8aAMbvCtMZ7PVfo56kps783EzmyZErZfSBovgq1TIdmj3HamDA4vkfQ9bOOWfkDqfkqbpz4WxpPMY/vJc96Stg3D/Hw3ks01okDR0GMEI/5qrp8NxlMZFatFkR94PZ3T08Fe6pRUuJiL+RBqfAswpwV4JU0rS36qjWjt3D9pezW/XA3kMDn7ABXQlLt9lLdRnfLZFmXkWeJuMjsUWignx0QEF+9J5E3mDwN+Qz260NEIQLYoNwNkMdvKdppTiJboRt30wmpfPUHXfbqkKncCLY6lZ24iRB6JR9C/U4cJ4rkTJDmX5EoydUY35A4Zq9gU6crmt2qT0o+gozFMUIx7GUGeVhhvMt6yJgtDhZ6eFlqibLJFq1MnXl77cgz446GU2fkpa4H6KsT7KJF/IVwuqlRpHn2OxhWRjBAkQzXrVSGyRoM6NqUJv1hso1Jr4BiKFLGzie9YJzpzL63y7w15VeiVCZVk9MYDmR73ceG3IDvsl4l5g9mzNNg0yNRJQ4fnzlLb9koWw9Uuh4lFy9xd77FUfiLHgbbKOOofGd3XTIc/bfYG+NWk3nEMz5n8ARHc78U63CCfmuVJLtmyUWq5zcCrfPXuHT6hmlc5CPsBnHHxnMhbXwx42L2eqXYmzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(956004)(5660300002)(2616005)(478600001)(86362001)(16576012)(31696002)(66946007)(66556008)(66476007)(6666004)(2906002)(36756003)(316002)(83380400001)(8676002)(38100700002)(186003)(31686004)(6486002)(26005)(966005)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkhjN1pXNkpmcmtXS3dzOHlub2hzcGQ3c0pTcm94ayt5dnZSOUJ0dmlTdG43?=
 =?utf-8?B?RGtLWE12Nm1HM25neTh1VnFic0ZTMzRrY0J1cnZhc0hlVTEwOXVxVGhTWUZ4?=
 =?utf-8?B?bVYzNm9IVjVLbTVNNktHczJWQUY1RVBmUHQwR1RMMzJPMUxKcncrWlAydE4v?=
 =?utf-8?B?dzh2NnlSZVlZcEIrTk9wcGdYZzhmbDRiaE5xYWhtT2U1Z3g5SnVteUZ4bjFK?=
 =?utf-8?B?bmM4NkxvaUdmWE45dnpzSGpPRDJpTXlIbjF1bzhLNHpnT2prT1JnQXR4Ymp3?=
 =?utf-8?B?Z09pY1JBcWdnOW03NFZjRVpWWUJNSk0zeXkyd3pJeW5ZRmViNWlWQzVyK0ZT?=
 =?utf-8?B?NHlsSEJxZHB3eVF2L2N1d2MzeVZCeFc2TUwrZ1FVb1dYSzVLVFV3bFlORk10?=
 =?utf-8?B?WjR1YnJ2ckxHZHFGNXpDVk5CTGVmUXd5c3V1Y2xWbGpRREJQUGFlclJzTmth?=
 =?utf-8?B?OWhPU0t6K0VOWGE5Z2d3SkkzdWFMdTNjNkJjMHNjbGVhN1gzTlRweG1oeHNt?=
 =?utf-8?B?NjVQVlFHRUFkdFpadmxBaG5DTVltOGRwK2RlS0lZdmlGN2llRXVvbTVnTkRp?=
 =?utf-8?B?VnJMS21zVFJDS1o5aE9aYzJOVkZBbmVKK2t4U3hwOW9yejdvczU5SVI5bWtw?=
 =?utf-8?B?T3d2Q2ZtbDc4RFpKaVo1cFFmaWs3RXpwaXFYQmN0ekUxV1RwNlYrMlRTUUhW?=
 =?utf-8?B?bCtKSHc4VFljSjFVcWpBVERkeUdrWDBFY05SZHVOOERXZUxuc290WUJ5Ukhr?=
 =?utf-8?B?aFNaNHByY1hudHlVTkhTb0g3THJWT2tlUlA5eFp1MWgveUlCNlhKNzV0Z3VB?=
 =?utf-8?B?V0Rndy9xKzRRaldhSzJnSGdScnNrOHRlc0llOXdnNERrQlZ6OFZsL3lRb1J0?=
 =?utf-8?B?TUhKVnZCRk5YV3NhdXlpSklBYlU2dGx1dVJIVUpBeENmTzBDMjd0UGtUajJZ?=
 =?utf-8?B?SURZV3gvSEtGeWZUd0tRbm4xTzF1VVluWWgvbVh2ejJFa2h5ZmtOMllCYWhB?=
 =?utf-8?B?MnpoZUc1bytKdkI2a2JDWm9NcE1XTFhvRCt0SjFwZzFMVXUxWHJ3WDJnZmVE?=
 =?utf-8?B?ZVJIblZPSnl3YklqdWNVYlZVbG9pS09QMGkzbkd5aXZsTnF3V2F3aXQ2K2kr?=
 =?utf-8?B?U0F6MXVZdDhZSU1SRUVtR1AyeVFSMjNiUjVUZk9zOFF2eTZEQ3RYc3hHaVYy?=
 =?utf-8?B?bXpOd1Ywejk4OUZBK3o4ZGk1YU1YRVNnYWpwb2tYZmpOcE5hbnREV2NZN1Nt?=
 =?utf-8?B?TUxhSzdJTjkycVo2YVRDa0EzS2JvQnBkejUvT1BRRXlvUUNxVEkrbkJRdEF3?=
 =?utf-8?B?WGhzYTlRclF3VWZFb0h5VWxTeVExZHVCSUs1WFpVSW1DZGRqVldJeVdpbnlu?=
 =?utf-8?B?OGh0aTIwVXpkOFl1THY5YnVNeXN5bGNjN2FCQmJmVld0cUFoR0J6c041MWY3?=
 =?utf-8?B?MFpTQnVLL1l4ZjI3MWVDdHlrS0FyS1lIbXZJUVBLMHZ4L2ZVTGh0WU5qc1BQ?=
 =?utf-8?B?SFI2ZFd3QVhwSHRGVDFYWmNxK1h0SWttOXdrWFluWUNCeWg0WTRtanJmb0g5?=
 =?utf-8?B?MXRWbjNFU0dJQXJVQnNzZEh1MDQ0VkZTMnl3dHRnT1RuL3A0NGU0NWhNRnls?=
 =?utf-8?B?bVZPajhCYXhtWkovRVFLWkRsbnhZcDVrb0U0V21KSVdJanlpZWJYbkZyK0Yv?=
 =?utf-8?B?cGUrK1VJSTNhZStnS08xYkRjc08zTjIvSW5IbFo2UCtpa1U3VDBZSi9qNklG?=
 =?utf-8?Q?drcFb3qHbIOe+HPVo6Dd6Q449WaSmFYkddXfqwa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e903e4cd-513a-4cfb-ea14-08d96eaff597
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 07:53:46.9581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tovIzy7xGyhnPtC5OYAMVXVaY4S4DubqBMnczzLqD0+DAP1FOZZaqZlywmNFFlqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

Am 02.09.21 um 13:44 schrieb Nirmoy Das:
> debugfs APIs returns encoded error so use
> IS_ERR for checking return value.
>
> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 2 +-
>   2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index d256215ab2c7..077f9baf74fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1696,18 +1696,16 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	struct dentry *ent;
>   	int r, i;
>   
> -
> -
>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
> -	if (!ent) {
> +	if (IS_ERR(ent)) {
>   		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
>   		return -EIO;
>   	}
>   
>   	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
>   				  &fops_sclk_set);
> -	if (!ent) {
> +	if (IS_ERR(ent)) {
>   		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
>   		return -EIO;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 7b634a1517f9..f40753e1a60d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -428,7 +428,7 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>   	ent = debugfs_create_file(name,
>   				  S_IFREG | S_IRUGO, root,
>   				  ring, &amdgpu_debugfs_ring_fops);
> -	if (!ent)
> +	if (IS_ERR(ent))
>   		return -ENOMEM;
>   
>   	i_size_write(ent->d_inode, ring->ring_size + 12);


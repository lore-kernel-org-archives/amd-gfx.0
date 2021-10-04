Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7FBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 18:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29B361409
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 18:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C29B361409
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627FF6EA93;
	Mon,  4 Oct 2021 18:44:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D30C66EA93
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 18:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmZReYALHFg1MFdwFIEMjYstXqIVNE1YgJd4wdDFSv16hTV3pRrF6jVdWHM6G2KmrUuiQJJfQQxT+hhh5cna/Hjz+ylWibEruideTh4iEYJ32uMJ5XPPoB6zMiqApCYexVnZav0wlZ45QcG4oXS1gq5sJn+KQmCHzJkK8hqPcQzEIJJzSATLZHj6uaxEsQJp1pMfXrdpKq6czBp+rxtSkSpJXXnZQnc8gfhVohcQ3e6B0hWs3Ziq0cEchsiKwp4ocXQIcdGpXXSeLHRMnOt3kHeTYJWQJoUK3PK69PIC6U6hOxxPVI2/RS45BmahdORzeFC8eNoM/Gl06ZLNv3iGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7qp2HZuqL0Fh5MQGxinaQBVW834NDsSdwjARiU2Bvg=;
 b=T8tfZGoy6OXLHyC+lTWG+h6XxOyWGlWg38lvq/r+PMFCgukmyts8voN0I5F7RJErdDq5qSEL0HMwlGrTOIbw3dYGCrJWxsqwExLfYrWJlU5WgjxAmcFMAOg7YXkYRZ32bNJE4+Z/57V+OE5H9uk6ZWip8Baulc/PzUK7i0cq4NewRZV+YAq46Okywr21jQJM2Pg4hGW81CohClyBuEBngW/AGO26opfXcdWvAHdVoMM5/epm79cqZ0wKphh6fbhvB8TY87sS2Sxp7mB+prLJ0wYK7EvRfV4ToPfzqfKUHTNvRJULt2Y8y/FcQR+ao/ABwPGv/8rB09lh+2etQWoKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7qp2HZuqL0Fh5MQGxinaQBVW834NDsSdwjARiU2Bvg=;
 b=FiTiOp+XMpHY/+QuICdIljtDkOsmp+urz7ssdzs7H3kFJGDLGa0YPYOP6nr5K4uIufB/Mkzf6uS2lj3hBJkpiLx2m7OjftRoxgelMY8Cbuxdu9N/f79Id9LXy6eGbTr14SfBEPzrUiDd9uMKlimxgy5woZS3Wup5JKPKdXx/S5U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 18:44:42 +0000
Received: from CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510]) by CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510%4]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 18:44:42 +0000
Date: Mon, 4 Oct 2021 14:44:38 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu/amdgpu_smu: fix IP version check in
 smu_late_init()
Message-ID: <20211004184438.4owtyxbcgffkoc2n@outlook.office365.com>
References: <20211004181438.2371925-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004181438.2371925-1-alexander.deucher@amd.com>
X-ClientProxiedBy: BN1PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:408:e2::28) To CH2PR12MB5564.namprd12.prod.outlook.com
 (2603:10b6:610:65::24)
MIME-Version: 1.0
Received: from outlook.office365.com (2607:fea8:56e0:6d60:566:7ada:f470:5877)
 by BN1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:408:e2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Mon, 4 Oct 2021 18:44:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b47def46-e4d3-4b8c-1432-08d987670702
X-MS-TrafficTypeDiagnostic: CH0PR12MB5107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5107B58E1F4BEB02AC664A5498AE9@CH0PR12MB5107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cIgRbPOghDKEf4zVetC1s3VjQMIZOLAhafYZJRME/oVynLiyhYdfiD6qq42gzhs6IRM54AThw56OyYYhdynU9syTqP/Iv5kAmcE26eUSnhIy4vK6iSsrV1MrzuqlxTdKkaID7rOtS09cm0h9a5KXiB2FBG3z+orjw2UYZIfD21FI1kbFqyDYucAsa4r/2UpGMLqIX4eubyBhiSrYn8H21cW9A3SAhxZQya/2gxWZ9OC0556zRpabAz367zy9HY59Mt8NXD71x1nOJpB1JdsN7FZ/oLrlQAC+3V/jrOoULMAHLSZtRZ5SeJtUbGkjd4DB7aNVX+VoR2BWtfnRKTQwTq7SmospiqP/fuiu7nnQBTvrSg2GpzdV8qqk4Cl1Erxb0BEBqPe+aPAWmL/6JdR/uet2tGyTIdmiSAnZ9Z8deyJuN0YGeeDL1ROIgbgDq/iOU9xxqMM9A74K2buPETI4quOovwYAVo9ts3+bTc1Hb7fiwKi9F5PJ+4k+DkQHmnw/B1wd7xefzbDSwnJMVpuQAX1QAwOVsDa2Izf9aXgYUh16ws6MMkR/wtCfHPZ/DNxRHW6GGZQDitZkJazRzck0RsudqhylyFFzYlupwu6g1LGXjpVO9jDSrLW8+vB7EWr/kL0fhRUgFCbW2HvwHRGRh4RJRfbPpgphx7nSZecaAvtzGWHBXcwMFTCKUJEmRsY4Eqz/klKZN0CU2cUdEHasXlLLZLlk3k818hwb2tmh7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5564.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(6666004)(2906002)(66946007)(52116002)(7696005)(66476007)(66556008)(55016002)(316002)(966005)(6862004)(4326008)(508600001)(5660300002)(6506007)(6636002)(86362001)(83380400001)(186003)(38100700002)(8936002)(9686003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?91tnDdsUyp24R0zw0ou8+oK1wH4nOeEPNm1XvQlCnofChw1Cm4t6KjhX4CPg?=
 =?us-ascii?Q?jnWpRlcrxjbh/UZ1w6JQfLwVWI4/47GjcJFj8ia+PVV2bnuAFi3otj/8gSsO?=
 =?us-ascii?Q?pCruDxhnc9v8tCG86pHpuqV9h4JYbCOFFXZt27xmt2IFKWxn+0IL9TNm+mcE?=
 =?us-ascii?Q?tANCmyW9F0ySt2enx65/bxGm+IKWXqlsZ1pk6WYE/sPpN7JsqcTk2XkX2jTh?=
 =?us-ascii?Q?uUCwPbscyIq/gl7IEhOZ+PL869bqjCxYf1ZzQJ5DzRxxzWNutTJ2z4tggw+9?=
 =?us-ascii?Q?t6/plk/c4zB/+LdGWvynQt+IqnIHKPeVwvMpHHgP9IqZ51PVZ+rxmY2uf7nQ?=
 =?us-ascii?Q?5nG39O/1oDPkSC+3YBs3V3a9ojJukXt6E9wQlyOjTeawCthVOsMorBISc3MU?=
 =?us-ascii?Q?7SS4xXwTfg21LxMUAMSKp1aChzfM8FsPz/WI5qM1aqbLhK2cJGQUZEL+hKAQ?=
 =?us-ascii?Q?wNq8vS8Z+3RtFEOGCI3/7u7fgD+a0n5DUlzLw6TL4efKdBgnpqSbyeaZd6pF?=
 =?us-ascii?Q?WGsLzCvdzj8m0QKjI3IyhwNeMaQa4Na6AFPTpIYfV7/qnf6jhnBHe3QWsFiW?=
 =?us-ascii?Q?4NN7l9qqbIU7cjuQdWtEP/NciTICLwoRoc1X7x5w2mqD43ELobfPyYjHrCf6?=
 =?us-ascii?Q?mXeKeoA8ZgGS1xUM1/ketQSCQh+x6c5tFzAiDINbNuX4wn7Lu661bu6bqyp7?=
 =?us-ascii?Q?zk6zjhZaN8TYHHgcJ0xfwjXUkn/R0VdVCksuFxSnDw4TAkLQqpqoPcd+9TPS?=
 =?us-ascii?Q?qSQpmDSjyQXJy8FafNgjzI/esZ4aSLGaEpYhWUdNPxp/VjIV+qGMhpXdpRs3?=
 =?us-ascii?Q?I61hrufEQ6dGPV5yXnH2N8ZJ141er7gGwxJ+1BJOSC+Y5JhFkjIhVPtv5ITy?=
 =?us-ascii?Q?eUyDcjDWVW++edwYSzn/tz5ExesuWTjbqbiROWno1Cr0LDMvj0YBDbs49/LO?=
 =?us-ascii?Q?Z6ZkEiWP+j8H9qCfqa4QtFB+lkkqNLtQZJZsCw3qlIR+HRMmNIgTVxvz6GVi?=
 =?us-ascii?Q?8GXJesrkxMROPo8zfXI+8Gxxnlx7Gkmi87ANX0ovvpB1M9Jg857k8iX0ZYdW?=
 =?us-ascii?Q?hOoNNSUtHWH2uFzNSN47yCUnfdxRqlSdl3jIV9rrTC5jF7WZ12h5MCV5FpwT?=
 =?us-ascii?Q?ov1hmV6aXySdleCkpO+BHw4g0xZD/yErCBt+U5gKTOYtBCXx3sJx0GpaTvaX?=
 =?us-ascii?Q?m/80H+N47KQyMF0uLgRbb/BA3s4XKzMN/GVG5VVYiXsIKiSBAZ2wHVVYqW0T?=
 =?us-ascii?Q?08w8j1MEN1UQjXGvRA8hsgKbqFM6F7eZt7i+VuwBWTqwY6YuvYL8sbNZVgEG?=
 =?us-ascii?Q?fIW/wBi5PeaDmggfJqKZtyDht34T1uEg/NbkwL9oqN7NBW+64MlknxYv4uvU?=
 =?us-ascii?Q?2Bol3s+Aw34MLbnyhlHqG30ES/W7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47def46-e4d3-4b8c-1432-08d987670702
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 18:44:42.0256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3A5lQfW5dP/UPOBDr+DuSPe7F4QXCN/D0Cy9Rrvw5opyg0zmJg1DZ36+GzpS4xNRxqDjbYUqx6Wl5h5/YveeOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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

On 10/04, Alex Deucher wrote:
> MP1 IP version is different on newer silicon revisions.  Check
> for both revisions.
> 
> Fixes: db95b2bd598d1a ("drm/amdgpu/amdgpu_smu: convert to IP version checking")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index a2a2a8398cd7..b633f202b466 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -695,7 +695,8 @@ static int smu_late_init(void *handle)
>  		return ret;
>  	}
>  
> -	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 1))
> +	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 1)) ||
> +	    (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 3)))
>  		return 0;
>  
>  	if (!amdgpu_sriov_vf(adev) || smu->od_enabled) {
> -- 
> 2.31.1
>

Tested-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> 

-- 
Rodrigo Siqueira
https://siqueira.tech

Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26139C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DC920706
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nRbtjTKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DC920706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CF689DC1;
	Wed, 24 Jun 2020 14:21:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD6089DC1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/PyVMqV8D/h+ojswgZNgqR2w3jbh29TUPHR+Xw9fLjzTTGxhKpRZa3FZiZ2P0T1Qbv2aZDyQhYH4n1tl1LoR9r2agLmE5MLnKrfWRN3u7sRXDjf5CIli+i5sSOOfRWZczfV8lPaGo3515ESAxfs2uzfkpPdua1TjdBz2zR+TUW497DastgRh0bY0VSidSCNfqQ1D+gG2a/VNhTnEsr5i9OlLWxm80rP8H77ovS4DzhLGoj6QnB6aveFhpY7wDbHmmhB6nkR+GOpWwqkDqqO/LMvMCKSKB/bUQwcTFyo9LXJKxQgCHcWRnoOILXiO9kpDEXrteIIVT71fNmHzlNhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IENfkOr35mNDipFVt5TZuetxwnOU1SPM+W8Db5nBAk=;
 b=QsuMXwuQDYhjyXeiZ7gbywZAi61s8DfWUUx3X/xLEE0bGB1mzWpx18+S8qg+IvC1JbBBqiWuR3uHiq57kRv0yDBqCywK2+QuUsfvyaLmR0bbQhUsSJqJH+hhp0s7luUiBWBNnz1zwoxEJv77ZXe/nsn4/vPmkBFo4K2pMWrRttbEa+4Boiri44v8gaGK4H4qs7JaDWfMeXvx2P5uh2cLT8XTKXJKkDFzR7ID+eIo/2G4QiisiJRkvEe3cfygaSwG/dvzvmT9MR4R//5j3A41406VjWO0FxkxXi0gi+MeqOYHnaOQdGM/F2E+ZMZmpNDxDuI1/JQcplq0TK0oQO4RRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IENfkOr35mNDipFVt5TZuetxwnOU1SPM+W8Db5nBAk=;
 b=nRbtjTKo9GZCapQodbqRPXIe5wtoHxT/wtMIz+xoH83DxxRO06X7NPBuoyTSTsqKtQlt96wYnnxfXHuwIJAFypODqfOZqAyjDzHxxLQ+LN5NAG2KZ1pYkabbEXNEX52W4vrIMlZ9glNYb5V4u9c1y/LpS/bGiuUzQcZczKGEago=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3788.namprd12.prod.outlook.com (2603:10b6:5:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 14:21:40 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 14:21:40 +0000
Subject: Re: [PATCH] drm/amdgpu: make sure to reserve tmr region on all asics
 which support it
To: amd-gfx@lists.freedesktop.org
References: <20200622214113.969491-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <6746fef7-e469-f46d-2c2c-24da84876f5a@amd.com>
Date: Wed, 24 Jun 2020 16:23:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200622214113.969491-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0143.eurprd05.prod.outlook.com
 (2603:10a6:207:3::21) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.121.20) by
 AM3PR05CA0143.eurprd05.prod.outlook.com (2603:10a6:207:3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Wed, 24 Jun 2020 14:21:39 +0000
X-Originating-IP: [217.86.121.20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56f45f00-881e-4339-9d88-08d81849e971
X-MS-TrafficTypeDiagnostic: DM6PR12MB3788:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3788A1F5B6F9ADF89EE633E28B950@DM6PR12MB3788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctAJvRv5mHfuZmAIXbhHqs7yt2abBYGL/LwAsDl4msF4Oz9mlXhFfv04nQNaMl9az8CMm/8eSo4xnnApBsl47nU0PiSJv1EPEVxG7rX1NYwusmSyJnDtYGS8nBz9tLGeDXODcW1n82nYoA8X2kX8Wh2CTMGBG+XMfzRIHONjwTiX26feZqFGRKRwiuGt2bNoKM80KuZM/H2tm3S2L2P201BupC0M7Nh7MOj9PHwdeAQXAJb098exhQ91gtbBqhMwHrDzRGFkcE5YVtHgCd4bWeu4F36W+7uEAX+ehvmJ5m0AwgIqEp2r9evx3v6FCJPqc1+GNd6ZPEdcJc8DZx9GmOTtP63QkTbPUrXUKwFwDvzPBNoZrT9MJnze1ukQMhtD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(8936002)(2906002)(53546011)(36756003)(26005)(16526019)(186003)(83380400001)(316002)(52116002)(478600001)(16576012)(8676002)(6666004)(4744005)(66476007)(956004)(2616005)(6486002)(31686004)(6916009)(66946007)(31696002)(5660300002)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LlKAg+YaQ4dpqb7sxC7WGbxyihn+TnIXcG+qzcFGgQDAzIehUtYFzrL+0plwmCp9hIQSvPOaD77+e7QyrvTMJjUO2mZKnZtDr2w0AFLGaYcEjPnJNGMFWHYiVUMK0Wy+AgGDFrSvA34/d9XbgRMBseLRSHK3jV8yazC9D2s8QXojWvjEQJSD5LBu8DaWPvHLo0vxSKt1upoHMAUTnKoqRCi/4X9Cne7wYq2kZTtN/z7mH0UafOhQAqS8T5zxVYveqXHruM42R2uUPCE8Wf6BP/OAStgMyslWKXvZICd5Axllz8WmCZQP812udWSZhy16PfW0N7i0td1thEMpfwi1cv5HLT16Jk9mJoSOrUz80dd9HOi/NSl4mUnCe0xrluiYkBizIcLNRA6zUQgafeD5k44qQovcveHB5z0pPswNXot7erAPFS8WHj3UDrto+/jsOa4CWXQ68itdbM9XMRvP6IwNge9Zx/Pvv0nJXiRKbNY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f45f00-881e-4339-9d88-08d81849e971
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 14:21:40.2800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XICrmvSALw795zhoJ4lEwgE8ceqoSB6VBm/UsDPLbdS/wP18UiiJEozARh8HKdbD8cj9Lh5SrtAq7gwMFPp2bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3788
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 6/22/20 11:41 PM, Alex Deucher wrote:
> This includes older APUs like renoir.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index f1855a8323b2..7d51768684dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1974,7 +1974,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	 * If IP discovery enabled, a block of memory should be
>   	 * reserved for IP discovey.
>   	 */
> -	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_discovery) {
> +	if (adev->discovery_bin) {
>   		r = amdgpu_ttm_reserve_tmr(adev);
>   		if (r)
>   			return r;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

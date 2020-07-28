Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F14C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5644320672
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0zPYGmd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5644320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99656E154;
	Tue, 28 Jul 2020 18:04:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CA86E154
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 18:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMHj1wTzHDv6M7lXhNNRgN3uqhFvj+6T50Q3u8l3ASWJl5rG6UNLwWH8ah5lLEbBHnyz8Eyr1qYjN0L/NZQ2EwI3jiZXW6Yu2P2kR1tHhXHP7tk+7iz+qqgWgHhaeLo68dxwhHChRn8tnr9U3qhUcUth1NQsmkMyT1dkFXW6r/XKwWdfIes77sAhpmUSzAA4OuRV1Po5jumU9be0dUkMc1mveZkNM13fIFcQ1JLagN2lj0Znd4eX8ettTFP/07LfI8adtQP6ZszqXsAAYTWEEjd/ts2AfCPU89dTbBrnqaFXc+c4oVZrIBazzYADfHVuaNVFkERRRdy49zQscBYTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld5a/OxtQd622RL7/rQJKr9bUU79HPreG4ep8mezfck=;
 b=PkVcvRVfcJ92xuEKm+07vWud0Lv4SCtgQ1lATRo/oSZdQ0ZIt539e9ajTzP4Ryu0+23gVqFFAcVprK0wx9X8ht3TQX6DwwLq3KkBDMHYoMZeg3TIpyMS70dmD0dqe9w3A9rcm4vvOPE8qDIV1Tc5pCnQGKMw4NfrZrpXiPjNF9/4Q0hyngdNaRdQxzn8ps/F9h7VM632WTMlrL6kUGQPpx5RveNMeolJYRMej8c3HWm8EjDGj+xBHQ6EAoYJObOz12MFPB34KNjjJIa3N/5YY/2JUsrWiGc8dAhejRLH4P5FCDfQD1crjB9tmlmX7p/P4uUeww9rfXg/tA/pzt0oOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld5a/OxtQd622RL7/rQJKr9bUU79HPreG4ep8mezfck=;
 b=0zPYGmd4Luz0ABTxoUtL7cgJ7/7vxW80QWr36tHrAJ6Qrz/m++iT5VJZpV8zni65EW0QX8LM1/onVtvUu1LWCqCVO5tVgHijSmxhCy2g8CvND+is2OGSAWmBJd3lAb+efZclppAfOLko+xhTi19HtdBpoVT0UUZyQyBWIvJJ2Rw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN6PR12MB1441.namprd12.prod.outlook.com (2603:10b6:405:11::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Tue, 28 Jul
 2020 18:04:09 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d%4]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 18:04:09 +0000
Subject: Re: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200728022929.411527-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <e9cfded6-af16-0404-ca7b-afcc4a285427@amd.com>
Date: Tue, 28 Jul 2020 14:04:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728022929.411527-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19)
 To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Tue, 28 Jul 2020 18:04:07 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2460088e-0309-417a-f046-08d833209fd4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1441211DE1D903B65663FF9899730@BN6PR12MB1441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3M/VHlRdMHGhBLb3Scqz7dy/PSMRg1O2y537bsyLjfvI4GSVyFcpD8WiAqUt4YPHn1UTsio2Xo2x1epcIHhEIoxHlSvJc6qBtGN8yddDk+tMzxzg6RrNca23FepVR8DUy3guAGAQ5Tl3Q+vrVps4/dI6ctINfvGgwhpmrV0jmjndL/CX6B+mJtm/gTgrc2QuJVPXShuddoTwdIKqzvcVYXJo5QWvUjNa8oHCtb82z7K9vZnLU8aD0qhTQwc7ebNTQkdRN+ErGBI1ll2qkWAQhnOMkBJbzWEL7OrnP3O3JfdE+Yq9ajMCT6K3kr51Mlifm8iQRN7vsXDynIUeOvGbFtrBC65eUQZMSvmMbpFwJ1hvtUYSmWpNvDmgi00ySST
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(26005)(53546011)(186003)(16526019)(52116002)(316002)(956004)(44832011)(5660300002)(66476007)(36756003)(54906003)(6506007)(66946007)(66556008)(2616005)(478600001)(2906002)(31686004)(31696002)(8676002)(8936002)(6512007)(83380400001)(4326008)(6486002)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WJVii/RabBhd9hVoRRuvNLIU4cdRdsIRNKrrdXpi+9Fq0FnZGaWQqkun/1HfbSdc/LYhK/W/ZHUN/z2tDjwl9Qp6cDd7t3mHtr0lRgDEZnlcJkjzoZLsrFvQXAWk9SZk6ES4hCApKjlTJTE/sYtFLGPHOZnmYfsdXPU3SQlilJGE2Lw0QRv1nUia/fekJblUaKNwkbf8dAkXpPGxSResyiQk8TmsmZhxqfp1meGyXRSHlTP6Nn+mr0laJAtW6jF0xwOcCNlJUKDCmpqooSG/kFrODqmvOi3p03hvMWieaVQx2BAFIgZzKPWE8K8e02r8Um6atNbnlwFnGy9KuLcqS6OswC9UnqFlWKtK8TkDIwGTSvU3s5k1Ftvu3YCAKTv1C0W9yshZLIh+DxQFbFrtHAHYQix/ol8IO66ThGhtd5OtyFYPSemLRmNfgpAcqMI1SNRRinYYmvPfOylMppr3z/FI8Z5UycCkKmvUq8CGlW7TEsk38jgcVWbAko6dwFEW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2460088e-0309-417a-f046-08d833209fd4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 18:04:08.9865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfG10nlshyDEaz6nifR94iN8bvd9aKM1vkWv4VO+TNxBaaXiBhwqvpu8vrnL416G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1441
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for removing the braces.

On 2020-07-27 10:29 p.m., Liu ChengZhe wrote:
> the block->status.hw = false assignment will overwrite PSP's previous
^^^^^^
You want to start a sentence here. Capitalize "The".
Also don't use future tense in commit descriptions (and commit titles).
Simply use present tense. Using future tense makes it confusing if
this is what the code used to do before this change or if the code
is doing this right now as someone is reading the commit in the future with "git log".

> hw status, which will cause PSP execute resume operation after hw init.

I've found it best to describe what's being done as if telling a story.
Break it down into "tell what's happening" and "tell what what's fixed and
how it affects the rest of the system". Something like this:

	Assigning false to block->status.hw overwrites PSP's previous
	hardware status, which causes the PSP to resume operation after
	hardware init.

	Remove this assignment and let the PSP start when it is told to.

Check if the above rendition of your change is correct, and use it if so.

Regards,
Luben

> 
> v2: (R)remove the braces(.)



> 
> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62ecac97fbd2..5d9affa1d35a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2574,6 +2574,9 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>  		AMD_IP_BLOCK_TYPE_IH,
>  	};
>  
> +	for (i = 0; i < adev->num_ip_blocks; i++)
> +		adev->ip_blocks[i].status.hw = false;
> +
>  	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
>  		int j;
>  		struct amdgpu_ip_block *block;
> @@ -2581,7 +2584,6 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>  		for (j = 0; j < adev->num_ip_blocks; j++) {
>  			block = &adev->ip_blocks[j];
>  
> -			block->status.hw = false;
>  			if (block->version->type != ip_order[i] ||
>  				!block->status.valid)
>  				continue;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

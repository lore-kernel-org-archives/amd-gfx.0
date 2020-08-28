Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBEFC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 07:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A4C20776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 07:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3lRWSq7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A4C20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14296E323;
	Fri, 28 Aug 2020 07:42:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1786E323
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 07:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKq3DK45OCG1x5l4vVsjhzpUkYo3h8iyxQH7uaOTVA1nJEc0wPQbdl79mMywK/AlqYsIzOd5ECq/4TA6h2gIcHTKHN81oYcOe2Ny3ATyp8Oj/ufRl+04uCCj0htsHSQkXPCX83QlgE39TUJjtAEIeMxfX7yVwpCt0Q9Tsy5q1LVLxPi9ADOIlHpy48KX5SZcib21K2WNmFEbZEsNYD918JrpXkdMkjkOpNmf7jAxETGFIhUdo0Ngn3+Zrl3xcloeb4bh4H+jeauJasqoFvtWenoomvIFtAoaky8h62Ok8Dex0QJrmX/HVtkWwWRSyWNSB5bzhIiC2mbvywTVmJRacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4bQ0BuiUJKbQQ7Y854xhtp5+KdWIyGRPMG8M4nsPvI=;
 b=Mz9erm9lfJ7mytCL4XE0wy0YW3n7G0RN6A9WrXGCT4YlT4sshZdPlCiPQZNEUQss69FUAbZcK+JrhVxoi9RZ3HsdVGlFh2zgVC2JwTSlG3pTXrcMQl7nc5VKFIJ4yftl//++uUdmgTGilrZ5XmtE8ZA3KdSF7bdG/JMk4zPc78XAzNmCmWeQcWSulvjGw3EUAPvfxcyGxDZCZrZmzPOWTeWTexGX2KnhRa0YzoraXhC4wdxUZ8ruPBdEU0YpDRsHbMb0mu1gZOHaDCCspuzEyy/CC8WUHqs+aFw8IMzumQaz0N59gHWDiKCApNXwPocr4KjPdjsloN86gcFw1myjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4bQ0BuiUJKbQQ7Y854xhtp5+KdWIyGRPMG8M4nsPvI=;
 b=3lRWSq7vzI/dYAopODkMcBjexCkV+mcfsJ3bM4gxO4pIvGRTMKTPgo1VS+9VsktTNpx8DbkSLsSAh49uKL3ilR4j+W4dC+hHIBkMO4mbpqMePBo+F3ih8JPxPcxwJeWmzT27OtjIDFJrSHqOHIsZrNiX5MqJcgo182+ILV+U/oA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3785.namprd12.prod.outlook.com (2603:10b6:5:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 07:42:16 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 07:42:16 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
To: "Liu, Monk" <Monk.Liu@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200827151858.55326-1-nirmoy.das@amd.com>
 <DM5PR12MB1708A7B24C9A36455E45A89784520@DM5PR12MB1708.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <3b347339-d8c9-811f-b75d-b1d74b82f1c0@amd.com>
Date: Fri, 28 Aug 2020 09:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <DM5PR12MB1708A7B24C9A36455E45A89784520@DM5PR12MB1708.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BN8PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:408:94::24) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN8PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:94::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 07:42:14 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad95d244-058d-4d93-39ad-08d84b25e280
X-MS-TrafficTypeDiagnostic: DM6PR12MB3785:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3785EA6417C4C2FD68CB53158B520@DM6PR12MB3785.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hITFlF0/aFY7wIfqDLC2Faf8ybJ8zgzFNbBuYpcw7MOh6UcKAqZOcItdePil2Qqzn6yfgzX7rBBJHbMGVi+Lrt78ZEyF1Pq/d1Gy8Qkw4OMj0lUL6teJXvzpNnIoTzfcaOeyFX7Kco8tZMs/mXM4fIhsi5LvyZJfLHjXbWDT5WkuMS9BHkh6Eyrv8lLvhazz5sKUCSMmyZx/gEPkksp/c1zjjwmR0qX4urgTblfWLojxXkxOPs5hPhDBpD3YKtaO5lvdZi16oNMRn7veH/ZgzzyHWHug46TQtDC6j6TbF1LAiR/fqlsyLIl0UzZemt5id1BQPOXJu3Z7olLkea7G49cpYW81YEWg/nw3wrc5ulMltqVVTkBN+jF+hR/Nbjw9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(4326008)(6666004)(52116002)(956004)(316002)(66476007)(54906003)(8676002)(2906002)(6486002)(478600001)(66556008)(66946007)(53546011)(110136005)(26005)(31696002)(8936002)(186003)(36756003)(31686004)(2616005)(83380400001)(5660300002)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nppbftW7IMCA8k8CANphMj+XtHhGgqTeo7qzxXCCxH+fxfNx+3sEUF6Z9Xw0S36427rVBuYiz4rACYaHDD01XxlUIZO6CnAY8XDWPv304Ier+bcP8k/zb+3tnnAajT5Xl9JRJw8GfnUlpR5NnSV6xeU+livmeJykDP2BkTTP3gTRwsBvWHvW0J6atDuqfvi9F1IyHwizO15y+iGV3waOeVmWA5RCzXY46yNw1eLe9z9Rh0Osu9cFmstDZ5KKV096KIoCPePKVoad7N+Hz7x0DGSc35QJlSPZsGog+hHYCW0IGHfjJlNDwg23LAEO9lYWfryIM5htSDILiXWNBUFeQsDAUtydPkfmtcZ6tXRVVUktp6w+ET1qUD3tr1MgG3lECuJSbewszoqe1d/zeb5y2u8vOX2zPPRMgSdyV/xprZqfsXji22jF7M+eRCUu/pLY+vJG1KMr0ydQeef4pgVhOzG3ptna5B70q7q2Nt0rTqgJKVPw1a7jDPFpc77/ea/MomcFpHvi+8E4LLXTFLFxjBr93eeNW3Laa7i5RoiNoR7r00D1Md3m+20FXaTX0AWfCGCqFHnpcl8xGrDLxN04uYjUvk4MaccNpGmcHSVZHb6btDaiTIiI8hU2lS5b78tZUCLK9DskAONQVlpo/WLE0w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad95d244-058d-4d93-39ad-08d84b25e280
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 07:42:16.1331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21fhkEdou/RbACeUsGG0wqf9QBiwB7DCDKqfHaOeHHgJxc9QLW2xsemVU86jPhEQ9X7UhWup2k+mwgNcPlDWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3785
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Gu, JiaWei \(Will\)" <JiaWei.Gu@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/28/20 9:29 AM, Liu, Monk wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Please don't change those code unless you have a full stress test and a solid reason (what bug fixed or what new feature introduced )
>
> Otherwise if it's a pure personal refactor or cleanup it will be not necessary


Hi Monk,


The patch was to fix the previous inconsistent optimization patch.

I don't have a sriov device so definitely wouldn't merge it without a 
tested-by tag so I added all relevant people.


Regards,

Nirmoy

>
> _____________________________________
> Monk Liu|GPU Virtualization Team |AMD
>
>
> -----Original Message-----
> From: Das, Nirmoy <Nirmoy.Das@amd.com>
> Sent: Thursday, August 27, 2020 11:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
> Subject: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
>
> This patch removes some unwanted code duplication and simplifies sriov's ip block reinit logic.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 117 +++++++++++----------
>   1 file changed, 60 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 696a61cc3ac6..0db6db03bcd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2587,77 +2587,80 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
>   return r;
>   }
>
> -static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
> +/** amdgpu_device_is_early_ip_block_sriov - check for early ip_blocks
> + *
> + * @ip_block: ip block that need to be check
> + *
> + * Returns a tri-state value for a given ip block.
> + * If an ip block requires early reinit sriov then return 1 or 0 otherwise.
> + * Return -1 on invalid ip block.
> + *
> + */
> +
> +static int
> +amdgpu_device_is_early_ip_block_sriov(const enum amd_ip_block_type
> +ip_block)
>   {
> -int i, r;
> +switch (ip_block) {
> +/* early ip blocks */
> +case AMD_IP_BLOCK_TYPE_GMC:
> +case AMD_IP_BLOCK_TYPE_COMMON:
> +case AMD_IP_BLOCK_TYPE_PSP:
> +case AMD_IP_BLOCK_TYPE_IH:
> +return 1;
> +/* late ip blocks */
> +case AMD_IP_BLOCK_TYPE_SMC:
> +case AMD_IP_BLOCK_TYPE_DCE:
> +case AMD_IP_BLOCK_TYPE_GFX:
> +case AMD_IP_BLOCK_TYPE_SDMA:
> +case AMD_IP_BLOCK_TYPE_UVD:
> +case AMD_IP_BLOCK_TYPE_VCE:
> +case AMD_IP_BLOCK_TYPE_VCN:
> +return 0;
> +/* invalid ip block */
> +default:
> +return -1;
> +}
> +}
>
> -static enum amd_ip_block_type ip_order[] = {
> -AMD_IP_BLOCK_TYPE_GMC,
> -AMD_IP_BLOCK_TYPE_COMMON,
> -AMD_IP_BLOCK_TYPE_PSP,
> -AMD_IP_BLOCK_TYPE_IH,
> -};
> +static int amdgpu_device_ip_reinit_sriov(struct amdgpu_device *adev,
> + const int is_early)
> +{
> +int i;
>
>   for (i = 0; i < adev->num_ip_blocks; i++) {
> -int j;
> +int r = 0;
> +bool init_ip;
>   struct amdgpu_ip_block *block;
> +enum amd_ip_block_type ip_block;
>
>   block = &adev->ip_blocks[i];
>   block->status.hw = false;
> +ip_block = block->version->type;
> +init_ip = (is_early ==
> +   amdgpu_device_is_early_ip_block_sriov(ip_block));
>
> -for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
> -
> -if (block->version->type != ip_order[j] ||
> -!block->status.valid)
> -continue;
> +if (!init_ip ||
> +    (!is_early && block->status.hw) ||
> +    !block->status.valid)
> +continue;
>
> -r = block->version->funcs->hw_init(adev);
> -DRM_INFO("RE-INIT-early: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
> -if (r)
> -return r;
> -block->status.hw = true;
> +if (init_ip && (ip_block == AMD_IP_BLOCK_TYPE_SMC)) {
> +r = block->version->funcs->resume(adev);
> +goto show_log;
>   }
> -}
> -
> -return 0;
> -}
>
> -static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev) -{
> -int i, r;
> -
> -static enum amd_ip_block_type ip_order[] = {
> -AMD_IP_BLOCK_TYPE_SMC,
> -AMD_IP_BLOCK_TYPE_DCE,
> -AMD_IP_BLOCK_TYPE_GFX,
> -AMD_IP_BLOCK_TYPE_SDMA,
> -AMD_IP_BLOCK_TYPE_UVD,
> -AMD_IP_BLOCK_TYPE_VCE,
> -AMD_IP_BLOCK_TYPE_VCN
> -};
> -
> -for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
> -int j;
> -struct amdgpu_ip_block *block;
> +if (init_ip)
> +r = block->version->funcs->hw_init(adev);
>
> -for (j = 0; j < adev->num_ip_blocks; j++) {
> -block = &adev->ip_blocks[j];
> +show_log:
> +DRM_INFO("RE-INIT-%s: %s %s\n", is_early ? "early":"late",
> + block->version->funcs->name, r ? "failed":"succeeded");
>
> -if (block->version->type != ip_order[i] ||
> -!block->status.valid ||
> -block->status.hw)
> -continue;
> +if (r)
> +return r;
>
> -if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
> -r = block->version->funcs->resume(adev);
> -else
> -r = block->version->funcs->hw_init(adev);
> +block->status.hw = true;
>
> -DRM_INFO("RE-INIT-late: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
> -if (r)
> -return r;
> -block->status.hw = true;
> -}
>   }
>
>   return 0;
> @@ -3901,7 +3904,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   amdgpu_amdkfd_pre_reset(adev);
>
>   /* Resume IP prior to SMC */
> -r = amdgpu_device_ip_reinit_early_sriov(adev);
> +r = amdgpu_device_ip_reinit_sriov(adev, 1);
>   if (r)
>   goto error;
>
> @@ -3914,7 +3917,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   return r;
>
>   /* now we are okay to resume SMC/CP/SDMA */
> -r = amdgpu_device_ip_reinit_late_sriov(adev);
> +r = amdgpu_device_ip_reinit_sriov(adev, 0);
>   if (r)
>   goto error;
>
> --
> 2.28.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

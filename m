Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2712AC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 18:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D7120702
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 18:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q34jYNMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D7120702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A02F6E3F0;
	Mon, 24 Aug 2020 18:09:24 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680048.outbound.protection.outlook.com [40.107.68.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 428476E3F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 18:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXvuTv63FwPbRr2ZLuVNPGdVslGfAjFHMQATNgNLk1rNlpOGEg6l8AunMQZWKxh9VmMrK+C+e09eE0BvDqnvvIx4gxCQQvKjBhsVRETOnQf9ZBH13QWpEKbdRLCvVdrH/ud1I24e6359FM0mDM90jZehn/HTWfHOlzNakeP1MzKARVgwxLAqMGvJAL8r9XsUn75HpW7JUgSqh6uVegzjrosNKibNZ0ZKg8HRhCOCkbw7I1LWrwwyVPqD/lX/5L8G8Sps06zTTpwFe8VgyS70r0vDilXdPve8NJjndvrIB33WWMar16Ai/oyMMJbFxY9yrf9ANV/aNfgNWfaPhf7afQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g+fNkRROq7spI7yfvmDsUVCjYizIoCIyole+iBg1ns=;
 b=ku4pkzpEHxlZeHTI6DaCHxq4DcJhudXumrnmRVPDd/LXUiVzfdSUhvPT0QQCywvZ6Vgtb2FdK/ZZx/VYcoKJ34pCSejOE4e8VmIYXdIJufjJmVCVZqr+/gllGEIYkOfHw/Qt7/MED42NZosTcMXUKZjsb9BY7bRGuLZ3Powde5td1epm3Ord4P25IP+o/vLDE7FsArH7SFLlaBWcURQAwpbPG1SPnHYVHT4pCGU44JTUcy6q1fc3yvEWxUhn2Q13K+pc0+1LBy82FMZ8NAA4+bOeiE0eKzV2za/MCuzfBxcA3FAdhc7es15z6Yz7YhcCsklFfQlC7vIZXCrPzFU+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g+fNkRROq7spI7yfvmDsUVCjYizIoCIyole+iBg1ns=;
 b=Q34jYNMZImuV92hB3JPwW2v3bPUwUiyTRIp9hU41x2t7+7wzJChB2GFdyHKkiqdz1Ooex92n4PKqOLXZegqMOO56Dq+5w4ylCy0Eg2ZqYOP4EIt8Fsd0zm5LN28rPP237CceweosMEqIq+UJQv2m51Md6pfV/9zuV/dr5Ez8YE0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3788.namprd12.prod.outlook.com (2603:10b6:5:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 18:09:21 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 18:09:21 +0000
Subject: Re: [PATCH 8/8] drm/amdgpu: add a wrapper for atom asic_init
To: amd-gfx@lists.freedesktop.org
References: <20200824161527.2001591-1-alexander.deucher@amd.com>
 <20200824161527.2001591-8-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <00da450c-b20a-1466-9797-f0f3eb8bbc56@amd.com>
Date: Mon, 24 Aug 2020 20:13:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200824161527.2001591-8-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 18:09:20 +0000
X-Originating-IP: [93.229.39.123]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c6c40ce-c2a7-44aa-b1ed-08d84858d359
X-MS-TrafficTypeDiagnostic: DM6PR12MB3788:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3788FBCFBDDECB216CCC4E9C8B560@DM6PR12MB3788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8L7OVD/7nqp7DY08Q4BPls9i1zNqmwZCUiH8gYCZ0Rsulud3BQ5a5R/NOeEVkrZnz9BpTa+YSWWhpoT/J6ZfCfxsXkeZd8WYYKb7TYRGMvsEVN03CvfxmT0X2EKN4qjB5ji/GtKH9iY3gckH0x3SdxTq9PsAsjhyXWQ6gfuXSpfy+SaC9bYRJojD76vTiSc2EPN2r/Go2eMW4KTyeN2fJmmhDPt1uCJ7SEXSj/Q3/UYHfHOVZEhMptx3iVo8aTj4saP21PhfjYsV37JTNbSXdlXNyuOIbaxRgEgWMkNCXJSlg7PmnC6786Om8PX2TTn3oz6GK7ZqzExxD0lXnK6K98AvGAqk4Rf0f9GrilRApixs4e5V/rEGz5I9Y9piKG6W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(5660300002)(26005)(186003)(8936002)(53546011)(31696002)(36756003)(31686004)(8676002)(52116002)(6666004)(316002)(66556008)(66476007)(6486002)(2906002)(478600001)(956004)(83380400001)(6916009)(66946007)(2616005)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SioPuM1fgOBBNMtivBZxuoIglMjQY1+VVpUfginCTJWzv1s+LQ8ZCfJa0Lm+c12zSGxk2t6BIkZ9D7fKmGhghZtoI231J/J+C1qjqtW0e5Zit7JS3AWppHFKyr/5Q2wNWMNUXZ1MdhHT33d8otfvHM5fk9AcfWYpaqF6omgE1KAodJUchltUfw4vmz4LxX9KsKdE5PFYm/bXPCmeljyvBrNhkPguUewjNzHMuM4e4ZwF9n01M1RzeiU/EN/Vs8ofZGAwalYmvyjxohMD2sSVdVpaaik8PtYIdBytzxsdcJh0wMKtLqWO40vII0ZqbTttp4JZZ6PtuAtJgIHrtkiV65CkBiS2jRizbWFi03Eu96JHKiW79ZL1+oKsRuPSEGefbkaZXqEJaCvsgctwLfiEk9R/2Kp6r0xdKEbmEUJnSVgajJD2GqpYjLXp3W2GBhMcVhYm06oiQh3/LAZRWsYilcYYBRG2m0LRrfsl5Sw+e2jJ8tu/i/cVt1e1PyG45tdIpB8x/WPfD/T2xLDd18sJU3qv5Jz26oyduG/lo2Vq9NmAdTeHiH13AfkQrfuZv/weo9moBclYJoCYffLG4N87Z8Twvc3ev9AzHIQDRRQL9BJwq/ErZg/9+ie0micBh1EMnFRsqAygzhwvGrLCed9OsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6c40ce-c2a7-44aa-b1ed-08d84858d359
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 18:09:21.5526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHDTVdkIMIzThvVbcR5i/7Hp1BPAVkFnJRB3yUIbFA17CDFjY7LINqH78kb8hF5BKuF9ypUK10CT1/1G2JGd9w==
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

Series is Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 8/24/20 6:15 PM, Alex Deucher wrote:
> This allows us to add asic specific workarounds for atom
> asic init while keeping the adev specifics out of the
> atombios parser code.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6573e1112462..e41aa1e885ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -653,6 +653,20 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
>   	BUG();
>   }
>   
> +/**
> + * amdgpu_device_asic_init - Wrapper for atom asic_init
> + *
> + * @dev: drm_device pointer
> + *
> + * Does any asic specific work and then calls atom asic init.
> + */
> +static int amdgpu_device_asic_init(struct amdgpu_device *adev)
> +{
> +	amdgpu_asic_pre_asic_init(adev);
> +
> +	return amdgpu_atom_asic_init(adev->mode_info.atom_context);
> +}
> +
>   /**
>    * amdgpu_device_vram_scratch_init - allocate the VRAM scratch page
>    *
> @@ -3203,7 +3217,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   			goto failed;
>   		}
>   		DRM_INFO("GPU posting now...\n");
> -		r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
> +		r = amdgpu_device_asic_init(adev);
>   		if (r) {
>   			dev_err(adev->dev, "gpu post error!\n");
>   			goto failed;
> @@ -3552,7 +3566,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   
>   	/* post card */
>   	if (amdgpu_device_need_post(adev)) {
> -		r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
> +		r = amdgpu_device_asic_init(adev);
>   		if (r)
>   			DRM_ERROR("amdgpu asic init failed\n");
>   	}
> @@ -4109,7 +4123,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>   		if (need_full_reset) {
>   			/* post card */
> -			if (amdgpu_atom_asic_init(tmp_adev->mode_info.atom_context))
> +			if (amdgpu_device_asic_init(tmp_adev))
>   				DRM_WARN("asic atom init failed!");
>   
>   			if (!r) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

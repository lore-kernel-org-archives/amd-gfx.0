Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C036C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 16:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E0320722
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 16:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gt7F1UQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E0320722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857FF89FCA;
	Mon,  6 Jul 2020 16:22:51 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D0F89FCA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 16:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8tR6gSb/JAEKAQjd2Q48qNXvMUhabC0XRIg4uR8qkMZyCrQx6PheryPrIZ9NHLUNt+SciA59WReJxq19AD71SIOMGymSxEWG9eBAo/HfzEtzbtEzu1uiPhwWwssUiHIVa91ZIYMOhxVoP5r6ydSKsJhI5hSXJ/Li8x5eViKUFWPcPS3cJr0sy5pI0D7tESPKrDFZqgtGw9UwGw/G88YmHFn3eqZ6Cke+rU+9XCJ6a4qu7D31YC6O6W1Rtdx7+JaF7v/kEPtZBKF7m/qwp8iOplAGnYmBc3VgHJyV23aR8e4VHjeUdGl/iYjtXRETZKlhLsjJK82Yse8+at4uJm1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlnA/OPqYb2NltFWCfrGVO49EQccR4AZEtTJAjaJ7qM=;
 b=PCPvEtaCva0BCjmBegKnTzNfcfsv40Sr7bAFUB8blvmF7bSEiM0a/ky8X05qrRWO2XbAfeYqb6e7uCd1xs3P8ZJoR43JP73qxL4Ge7GnO+frdiUWdxeqhgrOG93B69U0EfkjADxQ1hdpaPxdpnhnx+K6xTD2otgFPrfnVcZJKvc3HA6/KxpVFKBRHHzcngqP6e+SbHPDiPM98tYqYRVZZffpZ/LJ9FycX95skTFaFVErVmhe9nsXcp4pOT8iQV7YgglaFV8qvSUeBUJDbPzTirj5+6DCGnFFaTNCW2EZbgTKHKcAYWdYJM67FHX7p9tT+BFQKZ++rW2ZsU4AfSHnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlnA/OPqYb2NltFWCfrGVO49EQccR4AZEtTJAjaJ7qM=;
 b=Gt7F1UQpd3MCcmsGa/zjFAwlQK4ey56hqV+6eeKxaLtqVkLUf2jQZER7tQdn73L6mrs8ga64J80GXeulikttDH75zMjBHvaeqMpDa5ic0xwa8aTeZwyPclCvCuX4X2w4CESIiW0d4QiWz+FyEf0R3/ZsE9dd7YeSlD1XltHX9ws=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN6PR12MB1346.namprd12.prod.outlook.com (2603:10b6:404:1e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 16:22:47 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::d0d4:708e:e217:fa27]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::d0d4:708e:e217:fa27%3]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 16:22:47 +0000
Subject: Re: [PATCH] drm/amdgpu: Moving out the mutex lock and unlcok outside
 of the "if" statements
To: Alex Jivin <alex.jivin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200706161046.8063-1-alex.jivin@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <744c2b30-2383-9f4e-a80f-1c368681ea6a@amd.com>
Date: Mon, 6 Jul 2020 12:22:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200706161046.8063-1-alex.jivin@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: BN8PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:408:c0::33) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN8PR15CA0020.namprd15.prod.outlook.com (2603:10b6:408:c0::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 16:22:46 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1508d183-72cc-46aa-1f8c-08d821c8d1bb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1346:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB13463956EBFD32D2E77D2A8299690@BN6PR12MB1346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sum83xDD6YhBo23C4PqiZedvmIeY9zjwbBvkX96Q6eo2b/3uqQLDHF5ej1/sBEGrr+aH32sQletxXmgyTHZ5Mqj4jVvivXeoyjmWntImuxnKaaGW1C2X0IXPB6cPaRY6NWAr0TKlltNoXjul9AKps+TDmuYrdob0cfRaN752KPgIKUteuVzyfhZxZM+xZz3guFmuKzvCSlZ+6JgegpWXzq7iye62UFb4PFqwZScGTnLr6l5B6rBM3B+6QiX3wKqkc0AAWFJVEKG9CrYPiuf9vSX6KMEbX4VgiK544XgRFAl3UmKXA6zTnXv5aQ7m7UwM5K5ScBe6zE/4qwQ2LWILBq8yW/K76FSwuggEDCQed+moFOtpJQAq0pJL+sPlrgJLMAYEt2lkJFvqK+IXkcuL0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(86362001)(4326008)(5660300002)(8936002)(478600001)(316002)(54906003)(31696002)(83380400001)(36756003)(6512007)(186003)(16526019)(8676002)(2906002)(6506007)(53546011)(26005)(31686004)(6486002)(52116002)(44832011)(66946007)(66556008)(66476007)(956004)(2616005)(21314003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kvsDip6CkP6weOZsRNdKakHoupuwyozeL2mVLYtjy9WOxdVX8dwz+mMgEE/IEnlj2YjaID5pZ7q1VCUStkaVYewzIyBGS5X/1rVrRRMMmkO4qdIqSsp/EcjqVIKrrmcXvBFyzQHyctlUteRKq5df/zpFmjl8cGVTq3txvGduRjKH+8qKTTbvXkIZm5yDDXYQygdg+3BpRxjhMFrjL1JtCzPbYe6R0kEOpILglzZLzERrTtalgVologTbsCmnIMBhZFvyZ9l3RFS7lb3hyq1AvVoGuDeMZZZAzm/AICBLmlKeH3XsGit3s2uafK12gpR/EDzYXkDTZGqf0GMBm4oepe70mMD83wSkEuxDP7wEDAUQL6xEBUy6IdqV5DU/3IctbOQhkcYLaW1hBGAhpN/0A3qY86FeYitwqQ2INQiBvHp6pzRizcElIYSc2DwT4ig/uIrOAa7C4Zp/sYhQWFJ6GamIzRGVkMvv6UyaA4hYxuE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1508d183-72cc-46aa-1f8c-08d821c8d1bb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 16:22:47.1081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQAeYEMAPsS71j4hLtwG0gFw6LYLQJCti6u/tjBvZoNjm86KvpAdB3LqdsRDX3hd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1346
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the spelling mistake in the title of the patch,
"unlcok" --> "unlock".

Use present tense in the title and in commit text:
"Moving" --> "Move".

Shorten your title to fit within 80-char limit.
A Git hook checks for this and complains about it
when doing a git-push. I suggest:

	drm/amdgpu: move the mutex lock/unlock out

And then you start your first sentence of your commit
message with the title as a capitalized sentence:

	Move the mutext lock/unlock outside of the if(),
	as the mutex is always taken: either in the if()
	branch or in the else branch.

The commit message text should be 55-65 line width
aligned as Git indents it by 8 spaces when viewed
individually or in a log. (Modern Emacs recognizes
that you're writing a Git commit message and sets
the wrap at 55 chars.)

After all those are fixed, you can add,

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2020-07-06 12:10 p.m., Alex Jivin wrote:
> Moving mutex unlock and lock outside of the "if" statement as it can be shown that
> the mutex will be taken and released, regardless of the value checked in the if statement.
> 
> Signed-off-by: Alex Jivin <alex.jivin@amd.com>
> Suggested-By: Luben Tukov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 838d6d51904c..d2401379bd33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -3559,16 +3559,14 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>  	int ret = 0;
>  
>  	if (adev->family == AMDGPU_FAMILY_SI) {
> +		mutex_lock(&adev->pm.mutex);
>  		if (enable) {
> -			mutex_lock(&adev->pm.mutex);
>  			adev->pm.dpm.uvd_active = true;
>  			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> -			mutex_unlock(&adev->pm.mutex);
>  		} else {
> -			mutex_lock(&adev->pm.mutex);
>  			adev->pm.dpm.uvd_active = false;
> -			mutex_unlock(&adev->pm.mutex);
>  		}
> +		mutex_unlock(&adev->pm.mutex);
>  
>  		amdgpu_pm_compute_clocks(adev);
>  	} else {
> @@ -3596,17 +3594,15 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>  	int ret = 0;
>  
>  	if (adev->family == AMDGPU_FAMILY_SI) {
> +		mutex_lock(&adev->pm.mutex);
>  		if (enable) {
> -			mutex_lock(&adev->pm.mutex);
>  			adev->pm.dpm.vce_active = true;
>  			/* XXX select vce level based on ring/task */
>  			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> -			mutex_unlock(&adev->pm.mutex);
>  		} else {
> -			mutex_lock(&adev->pm.mutex);
>  			adev->pm.dpm.vce_active = false;
> -			mutex_unlock(&adev->pm.mutex);
>  		}
> +		mutex_unlock(&adev->pm.mutex);
>  
>  		amdgpu_pm_compute_clocks(adev);
>  	} else {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

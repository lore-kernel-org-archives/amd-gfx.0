Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16C5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 13:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8504120732
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 13:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PreekHUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8504120732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B036E02C;
	Mon, 22 Jun 2020 13:39:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE756E02C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 13:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4N/LYxK+eRpyZE/WSppLw6mx2rmDPx+I0pRon8H08mcxqFEuM0FFxBp7a/oFLuVz3bciVDAsmR+6hvgxcr+AJ7POm7/39cY5Te5xRWeAraI8pIX/iTMAnag09ScOVJ2VWNRjFIeDj4qyOu4tnYHZeRvSOOedzeOenLQxPJem9YoTsQvlXs3OU/eWC7pFXVMGItimwwRfloQUvQA8Tg1s8PW2HNvnnBLWvMvrbORFwfPlV9iDXKpV9uuncfyspxiXZXjesA0xufo1Ydzy7ANkvFgfQ9Bg1msxMIHYNPhlSy2ot88+BTiTNB1J1rq/v5fqll0aGkUb1Rk3GFyrDl+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFXvwuVH8OnX/fqSh3sDx4TWwqz6btV+lsiQipxVNg8=;
 b=cuSxGBd1TqFon7bFgtW88zxlGOWFJTckbY0LK7iHetya0z0hYE+g7Xob0FOuuvRtNkWM1wUr5d4R8UgHJa8FusgPH1wUR7KYHWIfrlyH8VvMgRqRZ/0GQhNhsH3lKkJGGJauFux3k3bAsaOTx7/LaWy8TTV6i0uxorsI4IW7ThEDobWM+a0YsVB8VmDKYSWfZgWqjrX1XNMQ2div6KQB+Qt5SyozhwZNYqTqlxXwwaV8RcrnFAw0f13FA49UwgBdb088gk3Vi8RZaa+ysgzcOEzu8KW6NeXW+VICbQCtrPjBiTUL3+x+Tu5erN06/Lc7am6/bpsqFwzw9+vpkmOVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFXvwuVH8OnX/fqSh3sDx4TWwqz6btV+lsiQipxVNg8=;
 b=PreekHUrIvNr4JdgkVvgxzxEgNtpWu8xvKhDDgBJdjKk8EJtEQcQvzWC+UZSRQWjXmWcxa0uk7+PohlsyAnPFfHuE4vnUy+Uf20amaMXQE9BiDTesV+BnUxXbOzIth1C+RxOU1c86rTgJmS1JO+6WqQpVMJmwQD7Ns9kLhgbA7M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM5PR12MB2454.namprd12.prod.outlook.com (2603:10b6:4:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 13:39:11 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1%9]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 13:39:11 +0000
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Warn about disabled DPM
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200619185009.12966-1-pmenzel@molgen.mpg.de>
 <20200619185009.12966-3-pmenzel@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fdcc2c10-26cd-3183-42c6-daf36d5df1e9@amd.com>
Date: Mon, 22 Jun 2020 15:39:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200619185009.12966-3-pmenzel@molgen.mpg.de>
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::31) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 13:39:10 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f62f836-4ef5-4eea-cd58-08d816b1a53d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24548670FB676C578F2F0D6C83970@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dwwL/MWrZU2+O86PFlhlbt8B6YxaU1vMj8WFcoLGhoer7WyR7vEVYw/3UZ6Gwb6caK2L7hk9JPIbnN0JeXJpjMFByxZkbUTNEHQHEwGGc96rEsKV5b0PA11lJ+UQ0TSrvvcbCnVR4SsSxhKixWqS5VisklIEtYxHtzQvTzVKNhiguvwsV6RwQrh3aMYtjTAyBhVlE1kZERfctsyIPGBNjdyv73n2JTPzFqe9FXk0Dpvkx1Z6BZgfPyf9BWpCsu4mo+vFZiq3drZ5kxKVvA/VkLgmOiaKobXozj8CzzVmvscvVZXrLt/yJKlc28UqBDSwzOLVuMn5/17nrNJ3R588h/XMyL0BTeFwbY8lGagsUDrWAT/dEncX7QqoYr0+KgcJS8cpITKSNN4mgbbbmWwALOO3JqR6NBOpE4K8ScwKwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(8676002)(83380400001)(66556008)(316002)(8936002)(31696002)(186003)(16526019)(31686004)(2616005)(86362001)(110136005)(966005)(6486002)(6666004)(5660300002)(66476007)(45080400002)(2906002)(52116002)(36756003)(478600001)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yKIC9b3TqgLrn0bvuCUmKGyKaPNx6CABNwPKplLf7gh+WEAOW9N77fmsvITTGGJT4z7xqoVRmVXd78JymP7MwRNYOy3zj009JVxDRr4lKTF7T8wCOQdXRpJzDcIecE7BRZrz63EyiZmH7D5EU0LUbQh2SSSbG/Xub0iLVMgBsxRZVFjaJ40D19CciI6cKoE/ZUA9pKqcaClqEVTTd+ejgc7MprnphY0D7Uw5osKFnCSrw/LRuMMUlC547yBdoTeq3CHzoDU7P+KDgShT42GrM/0q8w7mWHSSmXKCizTDBTLL8fX4551JBuuVxTgbEIyc5niPIz0Aq0XB+CCojGbV/DnVrWHmqjpUOH4wiLObavftYJo+2Z1Pd6q+FLeaUB2duVSaId+sis3r/pJnHUNk1JNfloR5AWNcRVmGEU+mrP4I3FljFJOnmiH7tkaHD+U1yA/sZXPO5Gs0Ezc+O3nOkUPUW3MKiEO+Ou+ewD0R8WNdPYZgYcms8rCToN0R1K6ANT+UsQUo8P9LAumlqK3h6c8ZSq0sGQn0ydsK35FILfxTG0ISKgzAhv9OdDok3qse
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f62f836-4ef5-4eea-cd58-08d816b1a53d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 13:39:11.3096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oM8yAnfz5k/nZo6uBoKtOylOvxyHyvv/qTyv6RVZFZ0HqgEdarPVtFJP/j+x/f4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
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

Am 19.06.20 um 20:50 schrieb Paul Menzel:
> Currently, besides there is no explicit message, that DPM is disabled.
> The user would need to know, that the missing success line indicates
> that.
>
>      [drm] amdgpu: dpm initialized
>
> So, add an explicit message, and make it log level warning, as disabling
> dpm is not the default, and device performance will most likely suffer.
>
> Resolves: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1173&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Ca93f6121c2ab464b7c1908d81481a24a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637281894303394855&amp;sdata=lbcpB8H9TnbISG8VFfciKh%2FKGC7YwkVYxUf4Y7dDVt8%3D&amp;reserved=0
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2: Use new print helpers, and inform user about effects.
>
>   drivers/gpu/drm/amd/amdgpu/kv_dpm.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/si_dpm.c | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
> index f054ded902f2..c601587c6d59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
> @@ -3014,8 +3014,10 @@ static int kv_dpm_sw_init(void *handle)
>   	adev->pm.current_mclk = adev->clock.default_mclk;
>   	adev->pm.int_thermal_type = THERMAL_TYPE_NONE;
>   
> -	if (amdgpu_dpm == 0)
> +	if (amdgpu_dpm == 0) {
> +		drm_warn(adev, "amdgpu: dpm disabled per parameter. Your graphics device will run with lower clocks impacting graphics performance.\n");

I'm not very keen about this. When an user specifies that DPM shouldn't 
be used the driver doesn't need to inform the user about this once more.

In other words shooting in your own foot is supposed to hurt.

Christian.

>   		return 0;
> +	}
>   
>   	INIT_WORK(&adev->pm.dpm.thermal.work, amdgpu_dpm_thermal_work_handler);
>   	mutex_lock(&adev->pm.mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index f7edc1d50df4..1f35d5a36300 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -7687,8 +7687,10 @@ static int si_dpm_sw_init(void *handle)
>   	adev->pm.current_mclk = adev->clock.default_mclk;
>   	adev->pm.int_thermal_type = THERMAL_TYPE_NONE;
>   
> -	if (amdgpu_dpm == 0)
> +	if (amdgpu_dpm == 0) {
> +		drm_warn(adev, "amdgpu: dpm disabled per parameter. Your graphics device will run with lower clocks impacting graphics performance.\n");
>   		return 0;
> +	}
>   
>   	ret = si_dpm_init_microcode(adev);
>   	if (ret)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

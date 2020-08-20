Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C36C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 09:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D576C206FA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 09:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gzW4MjVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D576C206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8606D6E088;
	Thu, 20 Aug 2020 09:00:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 507AE6E088
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 09:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OleNiIMSEBRzsy7rH29orMASdQukSRYlY3DMTw7NETo6680aJLIn/U+65fPY2loyUkvlSkcXnw6tbkrYFqwebKwpXEVq1FKlBFGCFlUj1ONXhgcIDBAyRCkro2wF6b+7yobHzX1oo0UGUPd024MZtyosudPuK0cqtycn/Uh3AQve5og2AWzo6qGxCgpcJs/6gd8SKjIyysjmbcgZqGOlGVCGjuXTW7KugDfND11OOEKvFSq5UWYehDR5NECwp8hQb0XMXyFywYuCjXAjsCCPugH2bHcUJd81ehftXWh6q1XWHvZI9u3CyZX3F9663s/vxgp1yc9V7pxMn4n/8DhcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBIu7tDn935ZsbCSJ+HCutnud6n+CX8zz7bLk6q2On4=;
 b=fwQe9IFsw9c2JQPkpj/7wExn9ZFVJ216sjSZjlQIThRh77G8YzsRG/9UTkAOMS4Kx8tiCwhsNKwnD78sojAUvYI5CIWkk95ABsMrHMKwlrNYUyi54GasnyodnIUel4Ridw9Yy9xXZT88MzvMbtlr/yNLPQyWLCqpK9W2uwgCz/uVMlqc9RbbLrm6vjkoiBC3V8O9jyPh4jnkEvFEBBVPo3R7HgxWWvhx8zhka11KW/SrdYPl/rFdARpMLV1PB+gjh1FtqPXJDSw5wJI/TkPCi4pqDouB+xtCXyAtUapcrM36zx2/QyachcfKS/mxydUgauzAdE5kSjO4FIQFkL9x+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBIu7tDn935ZsbCSJ+HCutnud6n+CX8zz7bLk6q2On4=;
 b=gzW4MjVK2KBjaKA9uf5va/PkPwrGbdQ9QRsrY1b0uPlZKaZY5njEwNKqJnPLVRIW32n0Sm3gA7yBhVohGz6CzMRhVrsxPses13jxGUPHC/6TeW852PpBe2A73eNJO5UxsrhIA+KFcNCCrRDKjEZijhJE0ZqkAtUzMpj7Xei5Kjg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3677.namprd12.prod.outlook.com (2603:10b6:208:15a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 09:00:04 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 09:00:04 +0000
Subject: Re: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU
 recovery
To: "Li, Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20200820022041.19161-1-Dennis.Li@amd.com>
 <DM6PR12MB407534C794E66240356AFAD1FC5A0@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB2533F50DFC7A07A94EAFEABCED5A0@DM5PR12MB2533.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b2981e9f-98f2-f2bc-d968-394145f18601@amd.com>
Date: Thu, 20 Aug 2020 10:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM5PR12MB2533F50DFC7A07A94EAFEABCED5A0@DM5PR12MB2533.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0005.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:208:3e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 09:00:03 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97b57836-8273-402d-6f7a-08d844e76da3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3677:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3677E5F20862F0C1A16A87F7835A0@MN2PR12MB3677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THJkb15M1QFs825n5JWq+N+0KDILmkwPMXt25Dq5Cyq5b/X+dp2sMAXClNE0ZlbumxuEHRuAG49/o5ktcvzjkM6KHpixP47s5JVP7BXxmWPglZvMFMBaZGUFDuCEPi/RiarEfyWruDOh4Lrtzfa41AYXj+nDcDwKWN6GP4AxFold7x9VLB67BAfS+TGRg9deNbBSPbjrxx4ViwlswQjpyZE9styqO6LDfLl6zM8ENodEIohq71CHyM+V+VmL085gQdMYwdawNR1Ulw2dEST/rs/Cl1yV8vXS3vzK3nuumUIH9XPuKVEMyvY6i+yabBe+bklz5kxB+8pu0jdgohIfyZok1mdo+jZNCUfUNkpDm2ABwiW9DyCgFJ5yASM8Jt7t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(6486002)(2616005)(186003)(8936002)(5660300002)(6666004)(53546011)(83380400001)(66946007)(6636002)(36756003)(478600001)(52116002)(66556008)(16526019)(66476007)(8676002)(86362001)(31696002)(110136005)(2906002)(31686004)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 41n2jKeVAhI4veIE7/rEn9M8wEyMUH7+Zt1k4KM4MzYfERv7axcPoMEgkLoD4cNJPU4PILXIorfkq/g16aCNavC8E23XyVxSLmDu/faChefrkx2vX++n5hrn7DCwkCN07Rx4IV62SxZGKXe66s1BBIKGexa+74V9N3gfrqGKtiXz9rQnIKRh/9ok+vwIZEw5vF35QQp2uf4D/uvMdeNJTUr1PCbyE+vJyf5hx7X0b4hikl+qwVowBlaiMUHi542O7Vb89mdKWMmxJlDyvLEX3GDqekJmkqVU+ojQ2HBvzubTCbjiZVqp0wSu6okKXUb+ENaQBLYtrYU2MBZY6Sy3fiQV+nxfK1ZE2iT/yOhaDNB+I5FskglnH9rQnkIEGLp1VptTwyoMDMqVh0O0rVLrQwutnKpPGs5lTQqzhzQpdb4yodq4SK0ExB16c6K3q+Yt1pJxI8v2LB1UuWFjrOdaL3UswPdj29eEkHQBWVjynBtqiRzsTeBRazLBUkGHlMW206E/MySCgCeQJUNKBiec0bIf7BxlwjEwun7IjRqk+CYzhUpB1ecgytKoToIYLuDAEDsbZm/jWIDa10K6D1STuiuMKLQh5J378WvVhLn4fRITA40gbOz+h6zBDuH/LOpajKwiqSXRNvPMacBPqGaI2WF7vcX+wQKxsrAoFEL31ZsbS1q7YY4IGDZ1sL67Vy+B5zXOHW7QH0/qrWKBYby7xw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b57836-8273-402d-6f7a-08d844e76da3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:00:04.2475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BbFCSTbLAZTU+UEG9AS8A30mydl4IKZfSvo+S5yLIZ3KQwAh4bgxJoZR3bNfRnZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3677
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

Yes, that is perfectly valid. Same thing for multiple timeouts from 
different queues.

Christian.

Am 20.08.20 um 10:40 schrieb Li, Dennis:
> [AMD Public Use]
>
> Hi, Hawking,
>        When RAS uncorrectable error happens, RAS interrupt will trigger a GPU recovery.  At the same time, if a GFX or compute job is timeout, driver will trigger a new one.
>
> Best Regards
> Dennis Li
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, August 20, 2020 4:24 PM
> To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Li, Dennis <Dennis.Li@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU recovery
>
> [AMD Public Use]
>
> Hi Dennis,
>
> Can you elaborate the case that driver re-enter GPU recovery in sGPU system? I'm wondering whether this is a valid case or we shall prevent this from the beginning.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Dennis Li <Dennis.Li@amd.com>
> Sent: Thursday, August 20, 2020 10:21
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Li, Dennis <Dennis.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU recovery
>
> in single gpu system, if driver reenter gpu recovery, amdgpu_device_lock_adev will return false, but hive is nullptr now.
>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 82242e2f5658..81b1d9a1dca0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4371,8 +4371,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		if (!amdgpu_device_lock_adev(tmp_adev)) {
>   			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
>   				  job ? job->base.id : -1);
> -			mutex_unlock(&hive->hive_lock);
> -			return 0;
> +			r = 0;
> +			goto skip_recovery;
>   		}
>   
>   		/*
> @@ -4505,6 +4505,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		amdgpu_device_unlock_adev(tmp_adev);
>   	}
>   
> +skip_recovery:
>   	if (hive) {
>   		atomic_set(&hive->in_reset, 0);
>   		mutex_unlock(&hive->hive_lock);
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B3DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C865420714
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OshN+qPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C865420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7180C6E20E;
	Tue, 28 Jul 2020 07:55:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02BE6E204
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZf8fLCo584HGhHPwl9I4Wed1syKrSjRM/po9sss9upIhwHyv2wIrGLBDTrXXc+q57W3LJa2YRamVIQxWGG96Gnr4kP7MuUshBHYMfT0y6UZ2P058vwpRPpVWdANtnnj7oJ6EzBCA3WJ+r2jUA+IylK82g5bqC72OvIoNJJSh5iA4plqUxXRDK3V5Eyfj4b+P4wYT7ksnjR7w8Jf87RfczQme1oRx461DuyvGaGtSeYfJb/EKA66ykmMNJDHD81xkRDxCsyeqhLwlTcU2wN6FqZFxehusScHNmAvKN+ItosYdZmM+pFhNfmiw7K3EBeJPcrfHSnxiA7cem3GBNB/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bctjx3mXtLLl89qzyorVU6PJUB7jvLSAjOqu+hUEt0=;
 b=SIErQg+3lC+UHmuAYa6EjM7ZizsgDwdapVw59VE0D8b5rG6tcpknImsdcSh+hZgpvbysR76ySace2PFwXseD6j0MDyG+8SBZPYdzUAiGYfQ9bZrctS0qlsUmIgyenWgZvLSyoeIdQPz8x6BJnp41ncoa516dlB67KEwrvsKKlE8Lawi3Xw0O8VQN57eT6FoXTc++XMrYLZlqo2Fl1Oal/0Ko1Qg91WcxpA4BFpRCbAZm03YPnBt/93PfjL88pWnA+f5+kT+FbSQAOYze8wnfHXv4yxShgdL+VKpNbeUf5G8ZcBDgRjoPhBg6SqkfHmZsyd90ibs5DG1PM8WSumjoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bctjx3mXtLLl89qzyorVU6PJUB7jvLSAjOqu+hUEt0=;
 b=OshN+qPR67gTCnpYYqZj1+L+1gZhAR7RC24WixEvXrfTbzu0246cUTD+AYUQuWv3mseHSj2x6eZwYRxYnxYgl/v4O4U+EXOzrsgAPrY/04nSrV+g8Yzg+4CyJWwfoR7Zv7MaEMHMQ5xHlsvUcGobY1QW2Ng341wzw7vdJxmSPtg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3776.namprd12.prod.outlook.com (2603:10b6:208:167::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 07:55:27 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 07:55:27 +0000
Subject: Re: [PATCH 09/12] drm/amdgpu: define one macro for RAS's
 sysfs/debugfs name
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 andrey.grodzovsky@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com,
 lijo.lazar@amd.com, stanley.yang@amd.com
References: <20200728074934.12490-1-guchun.chen@amd.com>
 <20200728074934.12490-10-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3a8a1c02-8248-997e-f87a-a111e86dd0ff@amd.com>
Date: Tue, 28 Jul 2020 09:55:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728074934.12490-10-guchun.chen@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0116.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0116.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 28 Jul 2020 07:55:25 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bb00d618-40ad-4d7b-023f-08d832cb9751
X-MS-TrafficTypeDiagnostic: MN2PR12MB3776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37766EEF95E045253AE9F18883730@MN2PR12MB3776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZfGtdPfOEKAs19OKaqq5Bds7zFebJjbF+GjAzQNczasjmx7YuPTC+AzUk/17hBGmoufwVKL0smIqyRLbomcXdsUklICHIV4qKb0A1ukQo9wff+218VTkvVUvrAmtYRjHkvr4VLpN+qq5pzEv80EuwMIde4tQY4u5BM3QVekExm7qcEVTOSoNEpFgduqMNaOKjlFXNuWSMqisEDfgZOA2QWkgdqY16hseRHeFjJendmLjZxFckVFHxibsLIouCI1KPNR5ZwhyRSVsyECmQfPKMvtpAo5Sv4E6AkIEIRdKmsMaL2DQRspInoKVYFtZlG5p38gqLpAZR6hAkrM4MukGIOVFoKDj3D3xEhM+9ZMhkGcSZ8JobGejsqGnArhC0eCD403nIjHfJmRHNXnFdebJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(478600001)(86362001)(31696002)(36756003)(83380400001)(5660300002)(31686004)(8676002)(52116002)(316002)(6636002)(8936002)(2906002)(6486002)(186003)(66476007)(66556008)(6666004)(66946007)(2616005)(16526019)(921003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vzQ0q/IsLNlk6tiBK5U0sB8TB2NfwHHCtlRXdBbQwFLSNexy6lghL5e6egVxPby2a4+WNsL45szX/zl+1YsqprMI3ROZHDkV+pfbPK/dhLNyPcaszjqjyoQErrdsRGB8yCXmV/+CWk0yujmvSbfgNBSXVRnYZPOK07bHyptu6BCZwNbj2Z2xJ6mwPyuKOfvSvtzw3oNePlflJBlT1aH09S2uzp+7LnmMrTmXOiuPeDaa8e0deqLKyanmn3lrS9v3C8vPrCsF2WySPsOYhuu3NQhjNOs5F6V8cmszeZBeWtKUugwXUuB0K3adxVnMthL2anQqcTFYWH0FRIztpJybFApsRcYNNaFOZVLgSIXF0a9YYd+KUyN6z9LFeDNgHOWZCvDf6Egrccc9k22T+ct1qaV3jfybedIzNeDTyUUinnAcqAjxyXyEkDm1R5UuRcM1jv+qnTe0Z3xc9vTUQP20yLCexhz3lrJl2nRSQm92ed0Ob1KissTqjSyfajUw08/HYpRLXZKlpC5g5B2DnOoyZ80iulT5KJF0Cf//CwxH7ZbGu6b2iACc5Fv2iVd2VTtE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb00d618-40ad-4d7b-023f-08d832cb9751
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:55:27.2752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f/BfFM2TU+KXvNhOY36Ihq/K2CQAcSlEwXJMVCnE3IHq68HoK/59JDPqwa4+BGg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3776
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

Am 28.07.20 um 09:49 schrieb Guchun Chen:
> Add one definition for the RAS module's FS name. It's used
> in both debugfs and sysfs case.

Maybe better do this with a "static const char*".

Christian.

>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 2cc09aa67423..c1ed0074a52b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -34,6 +34,8 @@
>   #include "amdgpu_xgmi.h"
>   #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
>   
> +#define AMDGPU_RAS_FS_NAME "ras"
> +
>   const char *ras_error_string[] = {
>   	"none",
>   	"parity",
> @@ -1037,7 +1039,7 @@ static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
>   		NULL
>   	};
>   	struct attribute_group group = {
> -		.name = "ras",
> +		.name = AMDGPU_RAS_FS_NAME,
>   		.attrs = attrs,
>   #if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
>   		.bin_attrs = bin_attrs,
> @@ -1080,7 +1082,7 @@ static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
>   		NULL
>   	};
>   	struct attribute_group group = {
> -		.name = "ras",
> +		.name = AMDGPU_RAS_FS_NAME,
>   		.attrs = attrs,
>   #if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
>   		.bin_attrs = bin_attrs,
> @@ -1117,7 +1119,7 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device *adev,
>   
>   	if (sysfs_add_file_to_group(&adev->dev->kobj,
>   				&obj->sysfs_attr.attr,
> -				"ras")) {
> +				AMDGPU_RAS_FS_NAME)) {
>   		put_obj(obj);
>   		return -EINVAL;
>   	}
> @@ -1137,7 +1139,7 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
>   
>   	sysfs_remove_file_from_group(&adev->dev->kobj,
>   				&obj->sysfs_attr.attr,
> -				"ras");
> +				AMDGPU_RAS_FS_NAME);
>   	obj->attr_inuse = 0;
>   	put_obj(obj);
>   
> @@ -1183,7 +1185,8 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   	struct drm_minor *minor = adev->ddev->primary;
>   
> -	con->dir = debugfs_create_dir("ras", minor->debugfs_root);
> +	con->dir = debugfs_create_dir(AMDGPU_RAS_FS_NAME,
> +					minor->debugfs_root);
>   	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, con->dir,
>   				adev, &amdgpu_ras_debugfs_ctrl_ops);
>   	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, con->dir,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

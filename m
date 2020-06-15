Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC335C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 20:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811202078E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 20:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3hCVMDGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811202078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246886E504;
	Mon, 15 Jun 2020 20:44:48 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750041.outbound.protection.outlook.com [40.107.75.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730DE6E504
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 20:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKFsD48U9Ow/JyICVvfI7yadJjLcicSywH4cp7XEyHcW7Oz+nRpdr2y52KT2r1tkYN4XOOK0alS0RvFpj4LfgLt+dE5jVzVUrmWGXPiD9GhO1+6ULo5yV12BxZwAnE+10+rEBp3biguWoQOoCtmjA+ZxeGEnROLUZCpyjo4PQCKi5ShZDiwEMYFew22+3e/1oCazc9H6x3op36hj9rUq5Zbw0qA/d65kjbQVDlC0jOMubb8iImlZnXfzNTQr7hJRyRnsA65V2Qtv3IpLT5EwvnEX8fOTqSUlkOxchXxLTrbqoZ9RwtIdy0jzgm3JSbySypgTPhaGkg9G21vWKz30pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiQaPtEAZTchsC/4FE2fbrosZaSgdgNRuaSIunKxLGI=;
 b=LbANgW0o4nbXGXUwKlZl2KXS53o8L/MQpYCvP2QXcwghDk99oGeoy7nmXt6MYSRPxLfL6KR0jrrW6ZH7uKSxW5jPGiinWYyGAuJ4b9CwE6dfIN9jOFUuTsWl/xFgHgWPtrUwJMinuSqv7XDIByOvnX+uXC2r2WpCsS7e/N188zE67Op36FViRbiODfCsq33IUS6Ez7q5XDJ431EqMUVJaz2F1imWGAnUl6rK26O/bzkrHqKloAHwt5Gj/LreorHK2Th22M6At5YbWWAreRHNlwNZ7sF/Jgf2RZ3I3Rrv1Z5JK74VN5M0zW5a53EeUeBjH0CRvAKDXOjI8p2FVoQ8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiQaPtEAZTchsC/4FE2fbrosZaSgdgNRuaSIunKxLGI=;
 b=3hCVMDGpxulVd3C3vySOHjSDpjGQsD21HxJglTTB9QmoF9wFw6zCKSBPD6lmr2GsxQJxq+vsqnH5BlzjzsUGv8QLlEYAkJ4z1zO5Hu1/yOj60OcTi/VNBFrmP17Anl5r7faHagNAQRWqSwVwJsOfhJVABipZJQtbKnt3k80rKvg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 20:44:45 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 20:44:45 +0000
Subject: Re: [PATCH] drm/amdgpu: fix documentation around busy_percentage
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200615204001.2477190-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1d337f72-0a94-fff5-8ae9-980bb7363b81@amd.com>
Date: Mon, 15 Jun 2020 22:45:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200615204001.2477190-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR22CA0065.namprd22.prod.outlook.com
 (2603:10b6:404:ca::27) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f1d:cf00:1537:110:ee74:9484]
 (2003:c5:8f1d:cf00:1537:110:ee74:9484) by
 BN6PR22CA0065.namprd22.prod.outlook.com (2603:10b6:404:ca::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Mon, 15 Jun 2020 20:44:44 +0000
X-Originating-IP: [2003:c5:8f1d:cf00:1537:110:ee74:9484]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6aee1784-9a87-4dac-243a-08d8116cf004
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36631A08D736EF95085C965F8B9C0@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3z0DyiTW1kz3wAlZzoogwbb5a0bNX4tKmFmsOnuPstYY+mjyB+XlTCZiar43UO/2h7O6jagMo8jX17T6cvgerlHSwKLPDGB3z6ESQeefL/mz+CSd+rIYOctMJIZSZX/OHMiAHhlMCd0tSCcpYp8lSeVEEK4NCdrRtVTQCk7PV3Rwv1qiYWyZj27DEn0ArXjBCedomMYa/8M2N53Xow7zVHJ3G6n/iYT4V7ADBF979UWII1OtNT8E+RBazEutIr0TU8SYYjBXrpAmqi5bs8szF3We3I8ZjVeoHfdQU/yFrDabBqVDT9aPQx6ubvbtrzPV6eCNcMBrlof+LSVXFf6gcGoR4ijEuPIBDFMTtlEpmLObkxEweB2fxWEE+5ntoFBF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(31686004)(66946007)(66476007)(2616005)(31696002)(6666004)(66556008)(4326008)(8676002)(36756003)(83380400001)(2906002)(186003)(16526019)(8936002)(316002)(53546011)(6486002)(478600001)(5660300002)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 19D1M3iLNkdRle0sfys/1NJ8I9YBynAqgnM7TjRgsoAyZkXMxBAdZE5Op7FdMF0ZcOPgdfAm09zNbl0rD2oCcwxq6SzQagiOayIEnnOAvh5MyJtfytmmA5+dNYETpWxTzonrl3WqK/6awrSfs1o34+mdBWpKCuj/CIB2F10Q0Pk1WhjpcORYg2xw+4vMOZlo8A2O2UE3JzkBS39MN/i+lCuCo36DLbkqBnJBuohvYvCE6NI2pdTAcs8Va9oI3GICm9cb+h/j66X1gBZA4rjvYyba04MlSyrz8rPqSrQqcWHKsr+u/wqf8G6kUB0QK0xlwRq30Iulj0xdaJVzgUCA1gOwZo9nrS98eAzHPZGVEZ9zOMED6M2P0EqM2ZhJwKIyK9SGPkK5H4GlLVSN8QhNR2gTB0WCbzsnn+RxRBAR+Q/JyDkSDhxc/EEvtgQUQ6s0UupZHuGRvtrgzn2Fz6+RI1isajWCyxSJE0kTobk0KxxSQzmgfTfE3qdFKV5yTPKRQ1v6ykdtE0TN44mWZqkeCq7o3bOZhKw3cr51XAPy40Y=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aee1784-9a87-4dac-243a-08d8116cf004
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 20:44:45.6177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgSxBRZ9bbURcxjOidjT0g38Oxd6gcI/gc1PcX7lMD5I6t7+8d9Y8W0dH4AqQICAQLzSI1ptbgWgii09SkaPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

On 6/15/20 10:40 PM, Alex Deucher wrote:
> Add rename the gpu busy percentage for consistency and
> add the mem busy percentage documentation.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   Documentation/gpu/amdgpu.rst           | 9 ++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
>   2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
> index 4cc74325bf91..17112352f605 100644
> --- a/Documentation/gpu/amdgpu.rst
> +++ b/Documentation/gpu/amdgpu.rst
> @@ -197,11 +197,14 @@ pp_power_profile_mode
>   .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>      :doc: pp_power_profile_mode
>   
> -busy_percent
> -~~~~~~~~~~~~
> +*_busy_percent
> +~~~~~~~~~~~~~~
>   
>   .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> -   :doc: busy_percent
> +   :doc: gpu_busy_percent
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +   :doc: mem_busy_percent
>   
>   GPU Product Information
>   =======================
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 5a8e177e4f56..42bbdf49458e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -1668,7 +1668,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>   }
>   
>   /**
> - * DOC: busy_percent
> + * DOC: gpu_busy_percent
>    *
>    * The amdgpu driver provides a sysfs API for reading how busy the GPU
>    * is as a percentage.  The file gpu_busy_percent is used for this.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

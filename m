Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574B7C6377D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 14:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185B261244
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 14:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185B261244
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCE06E8B8;
	Thu, 22 Jul 2021 14:14:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C86D6E8B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 14:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUBYuoEXRqgxFznjpAXU9iHreu0yKbgVGsPa6IDXG2z/9WQdksyEgTzliKfeI/zq9BKKgBpaD9Jtf687mmcRgs1UgM0fzjqWoZR76UYimtcsR8Un1NoI2grE4T4azDwMwcxFW8J47mgo5LRJ0guk5AnV/Ai0U5Qo8uVpf5TvTZpOEi6P9WO/Fm0yRCq4pNghdjbWlr27lFUR2bfvKy6tby59i690Pb2aZmE8mREFvnnxgX+Rzh4QaKlyvH5dyq320Wk8qQbT6krpJySnLaLmxgC/YYZxwmIUwMM8XrFZHE6VXdsE08LAOLZ4yA6cCEIprLGaJOjPJQtpu5M4/IDdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVrn0R37RTvJIxg24/46vnayNcPx7DyMb7dmuFBZxOU=;
 b=cJr10NxvM/BPOPg5PDfxf0ZqpHkt/PBKADBI2dO7t0LWNgCRguhxMo/xbXA+iCQVo5fMfLyDBIQv61RlUTuHa/OWb/XyC6LR6ycc/4wFVF1M9JioJX/zqsfYIOD4gTRR/WeR6YkUNp1JJfIoWqyvHhRwyoWkjejT9L99iMgTbk2A9lGdvYYsYiJ2m98tjmmpqIDlKuQlXzYqI5J6wIn7qZmCHwr+L0j7Rq9n01KKS4P1jSBVz+Le5Ff73JvU1vemqRp+95PXyztLsaDR+39JLNL43kXpOg9kPuECJUdgzgFtrhwQXHm6XdkvdVFdYXpANalNutIeSDhtW6Id2madNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVrn0R37RTvJIxg24/46vnayNcPx7DyMb7dmuFBZxOU=;
 b=f2W1KOm1dhqFQfH1jDosnjFLuHVArMGoaHSFZVT42QpPGHxAMBVDJVwNTnwC1FWzdL/Ys2vWVN8sc+64i0rIFRYJ3BBS8vDp+waK2BMQ/1fgP3z4BhFQexWCKWqH85jMX3ZCY+vBj9yiRko/l+twyimAJEDR1UeE/XHMl5n8/QQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Thu, 22 Jul
 2021 14:14:23 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 14:14:23 +0000
Subject: Re: [PATCH] drm/amdgpu: fix build error
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, alexander.deucher@amd.com
References: <20210722092537.27624-1-guchun.chen@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <31ab5df1-3692-f9af-2467-4c8dca0b5c0e@amd.com>
Date: Thu, 22 Jul 2021 10:14:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210722092537.27624-1-guchun.chen@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 14:14:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80c8c961-34e3-44e5-68bf-08d94d1b0112
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4337E07C853C9E32B3B3725699E49@DM6PR12MB4337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOMMqHuRbHQQinpnIQYxHR29VoOyN4vaROFzCkEkar3j3iWdmS7BXGJ615odo0Axs54s4gcAk8lKJz+AIS7dpeUQHVF6NS/BZ8IfEak9T1Twcud28Hg78rYTgMQIrOtVzUPRURPrSb098jYJ1ymkJA5/YcDcirUcyG73Dq31aET4FBpQcK+hQba6t9JE1Lqj1e7rqCZWGZEcezyn6hPn9e1SCZAxRGU/FrF/QVTLSIcrbDEqS9zJxmEPaoArw1hG8IgQbl/69jcPoPr0/XlhqMBJx/vUO0AQmR7+o8tgMK2nHkXE9umLc0yurF3wvQQYtKHW4TbRmcwt7/+I436d9wiikhC3KkIUUa8nqXzGtaMnOSPVUhn7TRwibUmqjlPP83Zx2bibXL8l8xl1OG+iDBMEqsE7Jjl7li1Q1Ty56uIqfyyN5eCwzggAF8Y8cltvuIv0RmwSvuYS6XNVQ7IbG+3IlGULMZZgnhgR/N4sMk4A82NjICrAr/16vMJUy5S7EDs/HoJs78i+yf64MC3saZejUnQVnr2Q5rJFaZtN5Sav/ys0pJ1CtMsq6PDNvAkd/MvZFUs7C/5K/it8PlOjMzlF99sy+9gS9Av49djy/l64iPUjyKnyr0HkCHJlw3a6PkKajctLmUF1DJScsSDgeP3pWwuBL8PFxkb5X2YA/BgDWmgCKl85ag9bQq8ac24xA41oOCL4Hq17Rryp0Fvsna7hV2e8DOjR5sPMKqg8gZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(6506007)(31686004)(53546011)(5660300002)(31696002)(86362001)(36756003)(478600001)(316002)(8936002)(44832011)(66556008)(6512007)(8676002)(38100700002)(6636002)(83380400001)(186003)(66946007)(2616005)(956004)(2906002)(66476007)(6486002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymd1R2NqUVg0UDlmUGVpTThkNVpVa3hvNHVlK2g1UUYrYWNGVk1MdmFYN0FM?=
 =?utf-8?B?WWcyOGZhTjlnQ1JLK3lYYTlucjEvUEVGVkJ1ZndaYXJIcFpPb1RUbVU1UWdP?=
 =?utf-8?B?eTlhdUUzOENzdWhXTFRGSVQzdThkK0huTW5FSmx6V01SYmdwdUlZRDhCZEp4?=
 =?utf-8?B?ZXBqczkvU1ZQd0tBeGkrdEFqa2VDREZKWjFYRjBXTDY5U0oyNjFubHlibllY?=
 =?utf-8?B?SjRodWxiMlhmTTkzelNqdmlnZzMxcE5HcXFYUEt0NUNEM3ZZaGx6THV2QkI0?=
 =?utf-8?B?aG4ycVZrWlgrL3FjSy94MXNMcG54K3RrbG94SDJwTHVhNjRCVnI0RzEwVVNm?=
 =?utf-8?B?QjFpMTZ3R3VYanA2OFVSUGg0aklZemtnUEFYdk1MTlRwc3BzZkVyVFpPRncx?=
 =?utf-8?B?amtyZ1Awei9janV6RXdtdjVyWkZ1cldUVUJsR200K1J3dHE0b2NyVFpRa0VU?=
 =?utf-8?B?RHkrdEkrQ0YrVFZQZVBpWFFSWjN0NTIrR1pMeklWNXh2dXdxYUlJYzVZU0NZ?=
 =?utf-8?B?WUFjcDdYcTkxUVducVpYK1AvVCtKZEN6WmR2NEhtRGlob01sSnNUNHl0MEti?=
 =?utf-8?B?bFM2bXpxZ2UrZlJ0MWJqMkJvYmY1d0QrNWpxRGtLWXN3dGdzam9yZGd4ZlR4?=
 =?utf-8?B?UHp4Sm5vc0F2QStmTUx3MHVWOXgxekh4N2FzSUNLNjhPRmM5VkNyNlVkaVBm?=
 =?utf-8?B?SUdldHhuTkZRdGhveWQ5Qm5ld2RQdi9JY1hFV2RQdTFKOU1KYWtHZnVETWd4?=
 =?utf-8?B?emJnT05tYU9DWElBM1hsNXRyMDFBMXRKMTlvQTNhUXlLbGxobERIelRlclBo?=
 =?utf-8?B?MDBZb3Nid3BYeDdUOG56V3hKYzhtUGpJcEo2aWJlTzg2V2c0SDFqNGJLRHpt?=
 =?utf-8?B?emlISGtiTDJKcHdOMFZ2WTFwVWc5UVdOL3c3N1Y2SHlvNDRjaG5DZ2E3QjVh?=
 =?utf-8?B?MWtqUkJkZklGZFY1YmxYd0hqWlZkRmNETTB6ZklJaWJRcENYL2VhV3JFeUFQ?=
 =?utf-8?B?V1hkUnBtSFpUQUlzYTI0L095d1VNYU1sVmpxQlBPWWxOSmFjV3RCK1JBa1Bk?=
 =?utf-8?B?Sjg1a2R5T21vNXpTRWdDYzJoeUsxYWpBUDluSGdOK0REK3NvR1JJWjBmT1Vo?=
 =?utf-8?B?U0JDY21oM0JYQzdwZ3phWFU2NlJxYW9XRE4rd05VRENmcTdQamhreFYzOERY?=
 =?utf-8?B?bUE1Sk0rc1RiSWgxVjVUaHFzQ3dLYkN5djlTSjhQMGRjMlR0bmVqYStyZTFo?=
 =?utf-8?B?bUI1Rlp0bktuYzd4OTlDRWNvNzlBenA5TjBYMEtCYWp1bHEvaU5aVFB3aTlZ?=
 =?utf-8?B?QjViZjhvNUdsMzc2YkUwNnBpUEw1TFh3QWs4eFd4TFRzbkVPcjFhMTdDL2VG?=
 =?utf-8?B?RHBHM28rTG1KKzVsL2FHbnVaQUM3K0E4RmJIRDIzSzVoSmQxOGZTbkNWUS9H?=
 =?utf-8?B?cE5CeGR4MWplK3lhbFZzRTYzOXAxQUUvdTliUHlDRHlLMFNpNnVBVENCdXlB?=
 =?utf-8?B?NFJLVHE1NzNXOGJwV21TQnVtLzU1cWkzSTlqaVJvMWxyUW5ubG1WS0R3UWVq?=
 =?utf-8?B?U0JnN1djR2owVEtmWXJvbHpwN240NXl2WVhQVys1VjcxS1hCMHA3K2N0QnBG?=
 =?utf-8?B?U2lscjA1VmlaKzgxck1kdFdnSGVLMTFDbzhuSDFNNHJveDRrR1UybjREYTJS?=
 =?utf-8?B?Rm5sTHc0U3llUW5TYzVOTEtGeTQ3K2dzSk5QNGNnQ1dpOW1Yams5cGlodkpS?=
 =?utf-8?Q?T729uZ8lwRqsco9Q4SXWOJ6aquSuighB7YA4IlP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c8c961-34e3-44e5-68bf-08d94d1b0112
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 14:14:22.8854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt0aL7SeN9TqNR2osj883UpjI8DuZ58uuKLS/l72Wj3MCwJnW6Dp1wWfEwdQpcBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-07-22 5:25 a.m., Guchun Chen wrote:
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c: In function 'smu_cmn_send_msg_without_waiting':
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:259:15: error: 'struct amdgpu_device' has no member named 'in_pci_err_recovery'
>    if (smu->adev->in_pci_err_recovery)
>                ^~
>   CC [M]  drivers/staging/rtl8192u/ieee80211/ieee80211_tx.o
> scripts/Makefile.build:272: recipe for target 'drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.o' failed
> make[7]: *** [drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.o] Error 1
> scripts/Makefile.build:515: recipe for target 'drivers/gpu/drm/amd/amdgpu' failed
> make[6]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
> make[6]: *** Waiting for unfinished jobs....
>
> Fixes: e070ba49f3a7 drm/amd/pm: Fix a bug communicating with the SMU (v5)
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Generally, there is no empty lines between tags.

Not sure what happened here? Rename? This compiled and worked fine on my machine.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a48f18932357..a0e2111eb783 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -256,7 +256,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>  	u32 reg;
>  	int res;
>  
> -	if (smu->adev->in_pci_err_recovery)
> +	if (smu->adev->no_hw_access)
>  		return 0;
>  
>  	mutex_lock(&smu->message_lock);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

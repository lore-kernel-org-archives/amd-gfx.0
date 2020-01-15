Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF15C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 10:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67381222C3
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 10:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ws5eygHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67381222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC91E6E906;
	Wed, 15 Jan 2020 10:43:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B0EE6E906
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 10:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOWrBrlz4GFAVhRXfl9gaZmWOXPnd/+NQNV9aTH/V1q45DZSVpyEG8dYRS6mVc38S/qXWEHkz1pRpZikj0fiXVfcUjy1AxXpR22BqUjG3rxgDxIPHlrUt6fvAdPUqZrOAE3vT+107Dge/2FxoEiMmrlWEV3aN9S56A/uVLRw85/LZ26rbothTPk0WZLRLcZJ3REPig71/iKjnOvFkCkpHRAI7jdtspi6iR1vXG3U+P6TITPCMsPGmJGHo4gI60FfNRisZ/h7cEZ/vgYW0q2eevVnceS9EJxyO3seavqxfmxYwY8USyz1pGHUt4ndUemP8vFAZP6ntP1L6DITTKelbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFm5dbtbPD9XzBTHoniXHqIMJ4IAJgGlEywREM+VaHU=;
 b=WXImbd4KBW7Z6GXKQ5HKZ+GXci7s2HhbGNUZJeWq9k3LuyYsbqMoGLYZnNhKEjk4SuFAaqb//SV0uoA2V8fU2ROgdw17xgiOaSWlGIjZtzztCKfSfDs5t943wwNBi9/7kaQlFGnAHeoKhw83a/7u79ymRSOXYQxMYIs0DStELcz52BYEKV1Je6Dvt8Y6HPF2H06ftP6cXSKE61DNRIr0p7qI7/pGZBUzNVqBLhiucnmsxpBcP/FZU+1nhNacL5DrpyxmIaB1/f1UrUl/YoRYYi2Qkger3ZagXcR/0kyMF06D/6sL48pNMYxY6IbnpiLw3PwjXHaD/RgeKYl86PStGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFm5dbtbPD9XzBTHoniXHqIMJ4IAJgGlEywREM+VaHU=;
 b=ws5eygHBEH7vkf1wgezkp/03ub0blvi4LnHtw6LlFxVzJV04NTwKnOdavKVSRw7koU6JBpoMxCSi8gh4XHqQnSvQKWCFlVXx27d1UIjzUKhCQVDCGy1s1buCOpgLtVTOgainDN5XpR8+xRsFiszenCyhVZ4JSqkT9JE9fGdvvlU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1323.namprd12.prod.outlook.com (10.168.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 15 Jan 2020 10:43:01 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 10:43:01 +0000
Subject: Re: [PATCH] drm/scheduler: fix documentation by replacing rq_list
 with sched_list
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200114095819.8373-1-nirmoy.das@amd.com>
 <MN2PR12MB3087E571C762E686584D3EBA89340@MN2PR12MB3087.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <ec795344-9fe3-8c89-6f7b-779f83609739@amd.com>
Date: Wed, 15 Jan 2020 11:44:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <MN2PR12MB3087E571C762E686584D3EBA89340@MN2PR12MB3087.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2b:bb00:33a:7193:ff09:7830]
 (2003:c5:8f2b:bb00:33a:7193:ff09:7830) by
 ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Wed, 15 Jan 2020 10:42:59 +0000
X-Originating-IP: [2003:c5:8f2b:bb00:33a:7193:ff09:7830]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d13c52e4-faf0-4ec8-8f53-08d799a7b160
X-MS-TrafficTypeDiagnostic: DM5PR12MB1323:|DM5PR12MB1323:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13234F743526E8BCB6EF2C368B370@DM5PR12MB1323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(54906003)(53546011)(110136005)(4326008)(2616005)(6486002)(31686004)(8936002)(81166006)(81156014)(8676002)(66556008)(6666004)(31696002)(66946007)(52116002)(5660300002)(966005)(45080400002)(316002)(2906002)(36756003)(66476007)(16526019)(186003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1323;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhX4AjoMBpVRGivxn7WW4yrhzBcZVjQLVP0LOG2z6uOHpvzbarsfSvbEwSEx1sEyaUyMe7NAtKw38hyb/XC99oLcQuNGL1b9/amv1QrZeyd8EgCNUNi7X2WB4+w+45j/YqBeOipQ7PJKJXvgBOkbJAJXfKrZDXnwvZo7JlIy6iXfbWWVRAnHV1Tf0PveUO18CGoOysw7k09n2R8F7xTzL1FIjdE1cQa5WqYF4jB8mvnaMM5JVMPfxKI1KAF1iS4fqej09mpwjbyFdPSrLqOMN7WqRYrY5FuHUtlAa0F6/hlnAYud0R3kzICeq/uDEb9ra2jDOueI3q1PXhEjw+w2FKOkJ6MhZ6NeIBemYOQaj67+sHKL4LnZTAP5dsdQ7lHzw7SQ3IjVoLizBfkj046fuvAXJ2kS7TiJwa1j/ccXm9sPpuhyihLaYEPERGGrLwGD+nTGmBckPNIlnPWbK4D8JXpIjfKOXBppXDqtp+mUv/s=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13c52e4-faf0-4ec8-8f53-08d799a7b160
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 10:43:01.2087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJaGebCZEE2PIgIVmmgYcQNOuPVcbgQTTIkJwtYbR3H2cfrCBZQBB6vQED/Ch5d9wZHsQ229YNwN3jo8eVbI4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ho,
 Kenny" <Kenny.Ho@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/15/20 3:14 AM, Yuan, Xiaojie wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Nirmoy,
>
> Seems like documentation for struct drm_sched_entity@gpu_scheduler.h need update as well.

Yes that needs fixing too,

Thanks,

Nirmoy

>
> BR,
> Xiaojie
>
> ________________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Nirmoy Das <nirmoy.aiemd@gmail.com>
> Sent: Tuesday, January 14, 2020 5:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander; Ho, Kenny; Das, Nirmoy; Koenig, Christian
> Subject: [PATCH] drm/scheduler: fix documentation by replacing rq_list with sched_list
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 2e3a058fc239..62bcca855c69 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -45,7 +45,7 @@
>    * @guilty: atomic_t set to 1 when a job on this queue
>    *          is found to be guilty causing a timeout
>    *
> - * Note: the rq_list should have atleast one element to schedule
> + * Note: the sched_list should have atleast one element to schedule
>    *       the entity
>    *
>    * Returns 0 on success or a negative error code on failure.
> --
> 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CXiaojie.Yuan%40amd.com%7Cb5b5e9e4c2a34ac6b50308d798d81903%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637145926254946780&amp;sdata=ZgkmwrForbuXnPGGHz2UVE67anyILWedAMNlcSA%2BvUw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B166C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 14:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BCB64F5E
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 14:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BCB64F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBCE6E57E;
	Wed, 17 Mar 2021 14:05:02 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700068.outbound.protection.outlook.com [40.107.70.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1F66E57E
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 14:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg+2kfM0ae3NmT5xNkpDFlG7ioompQNWKWJkw3Wh6diYbrdAPt3i675g1KcCGebCvGC+3/DWmSpbHszPx9uxKRyjpaR+z7KJnrQbSgrwy19p1lSwUNQcLYFWm3LQvXYvoRaKX+pDeT0fGfecoRGLPXOxRarnGyzGY1tO0NdZrd4bylU6N7lgvKPlc4sIBo1ZRPbMYCu1Xu77Lwtpz6tF6n/NZUUgLZnvT3Dr3iE9NHGNWMb9Axss3xMimWuy3K4WWDgRTSlUmNecJ5fZqCo5QmdNwtekgXJ7fNhygE/zgLSPqT7xslYGqr434wossyL/Y+SrXuHKk+NcBgFNe4X+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNH4K3VnfdJZ9Svo6yRIqKZYItVkMaNyIE2f+CcXMbc=;
 b=dszynUOmfz+vqLlCLG3S+YycdB51wt9/d59EYHhZY6snPe8PSWoDuSEemyT6bUhfjqle5gdpCh1Uv1lck36pXTkJVcAhH5hhLOKmPnAp+qPmavIkfJaB+dyYEK3WM4Vd4Ng0cFMRdyqx7jRNV1ZEnyfyMgXdvB6K8NT46V+r+rdIviDgHhNgnpMseYPTtNDwNZb9WaStx3XhTBvta/8xEkRKy/R8BsE+WEbLbJLjp7RV8NTuPooYUpHPE2FekyqO/rsPzHeHX0S0uxMnexdvL02y7VhgK9psT18PvOd/E3Mu+Y1KBpzwnkUVAntr3osh71NDTb0b9aBCUSqWeu62mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNH4K3VnfdJZ9Svo6yRIqKZYItVkMaNyIE2f+CcXMbc=;
 b=2yhTBO+6/15xtuB1ApC6IvWymth9Du89cRpDOxOqU2SrR3SlSqsyE7VZ5mXICWNpCbECkhEZkQbk7gGeQ0EA6CjVt++Zq9n6I9ajVHDTUiU5jjey6eDVjXSsmilugxIPJqIYyrkD+gr0Alu8uitDachujfy2+4OYwA3EMWjpTLk=
Authentication-Results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1360.namprd12.prod.outlook.com (2603:10b6:300:12::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 14:04:58 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::8c0c:5b9b:fec6:e12b]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::8c0c:5b9b:fec6:e12b%4]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 14:04:57 +0000
Subject: Re: [PATCH] drm/amd/display: check fb of primary plane
To: Sefa Eyeoglu <contact@scrumplex.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210316215006.18769-1-contact@scrumplex.net>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <7706e621-78ce-1330-b2f4-e6beacd022cb@amd.com>
Date: Wed, 17 Mar 2021 10:04:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210316215006.18769-1-contact@scrumplex.net>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YQBPR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::30) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YQBPR01CA0130.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Wed, 17 Mar 2021 14:04:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84b08c85-4bcc-470c-1e3c-08d8e94da5c4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1360B8ECAD490C59CD9E432F8C6A9@MWHPR12MB1360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Px77cqTwP2qqdJHUrHto7g0iPslAo2/Sar5UJgw+TLnHy7QrDff8fWLPbqJZtyfEjhvsJjGWyUdybC0kLB0yUROLSIDimeCh2P9/Yl0BtGh3UF2TT3HDv9Iz/5MLFJdAx2Rn6KAx2GlKa8c2hv9ddSbJIme31Dkmxc2xkxTibEPrEcpQApp2cGmofgGRB2qCedbtG96+rk4AAmR9qiBY9vwfUwODOZcgJF6T+FjiRV941jPpbIr8lNcJHYXmPj3cjPfHM2F4gZ3ZnQK3rI4CE5zgyDHvE2w6HZ6auIOnrvuFri/zeSLNFjYCe1tE8o0SiyXzcOikHNIoffPnP+uuMUYmzyv6UqV3ujvFVL1rCzte2GQ+ZUYQ5rdy6yeW0FJMmHwbIUD0xpvPwDk0bYIFMEMILiFEJ8eG3tEdzADaefAp6f4eI9h/siMimCH6iHOGAN8/UgMC2hMbXfdOUqVlFHUQa1bH6mmkUSegZv0Yp1cyEN0l9b6Gxx+FCn1t8AKJTGWOaPJL4xetRudHJfibc+2JZOlVA/6MIeaxI3G7tc4UDXQ0rN/EriFJNnCV292UW05dgsYv3JaVRsR9wOTesqPwQjR+e+GwJv4PabGXFZEsTLdq2JhNUX/nUCnCNyA//e2kt3HinxZ4UAv7NkyA7sLrHgM3fJ5szELIH+xsvNT9oNsDnMIIFlk4UCUZTQR+SMo/zekFtNEBggkvhpRCxHsCZYoauDjhhrFdP92oaGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(66476007)(5660300002)(44832011)(6666004)(8676002)(66946007)(66556008)(6486002)(16576012)(16526019)(53546011)(36756003)(2906002)(316002)(26005)(4326008)(956004)(186003)(110136005)(478600001)(86362001)(966005)(8936002)(31696002)(31686004)(2616005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TitmeUZtMUN5a0tidGlGRnFSbE9wUnB6SUt6Mi9rb0xaZFBUb2hMOTcxdXdW?=
 =?utf-8?B?TTlDUU5tV0Z3UC9taTV5VjZ1K3FiZ2lDYzdoYjZRNlU5TnR4K2YvTkt6Y2Rx?=
 =?utf-8?B?TTdDVkdxRzJPUlllV0tqUFUvTzVBaFlGNXo5VFhES0dMOEtOVHNRYWJEd0Jl?=
 =?utf-8?B?Wmt4RjAwMDlRN01ZUWR4QmZQOWoxZExjWjlvek5mbkRVZ0I3NTlVKzBKK2p6?=
 =?utf-8?B?U1UrazBxQTdNU21EbHpmU3EwcEcxMTV4UU1WZUxlOHNrR2p4c2NiaU90RENV?=
 =?utf-8?B?Nk13WVdUZDNua1RzcmRydDR3STdjOU90UXJUeDFwUEU1dzNIcEpzM29lTkps?=
 =?utf-8?B?ZHdseE1wUmRLdkZhUUtVbXU3MitESnloOFpyNVZmN3RRK3pvTUhFSGNPQk14?=
 =?utf-8?B?N1lRUU9mWnNGM0lPVW5pRmlVNWpJekdYOStWeDFRZDNmSzBna09FSFltMDhC?=
 =?utf-8?B?QzdzcWdKL05yL090UjloZFV2YnM2eG1tS2dXSUY0VHlkNUE0WkF6VnZMRUlU?=
 =?utf-8?B?a1ZJMkVUZVkzQkp4S1hyVXJqTVBsamRhdEcrQUhzcy9LdG5uK3R1MFlobG1S?=
 =?utf-8?B?ZTUweVlGd3Z6NHlDWjF3c2xLSXVSRTJhRkFEOURqQTFvOTJxUTJTRWZsZng0?=
 =?utf-8?B?Y1luRTN2YjNKV0RzSm43QWtkaUpHQmlBa0RlbG1mdDhOME84WEx3ejI0U1RU?=
 =?utf-8?B?Q3p0bkg2SmxZb0dlNlc3RTlFcHU5eHptSC9ZR09QMnJrb0tvUlYwUEVlZkJQ?=
 =?utf-8?B?cmZxUVJFdy9UU21GUzlLUjdCaFpDQ3JGVTEyd0g3QlVDM2N0WU1nSTRPZTVN?=
 =?utf-8?B?UHNjaVJISG9ZU3RFa0U3SGltRWpBMWo4aW1zWklZR3doRUVOOEJncEJFMGFz?=
 =?utf-8?B?bFI2UzBjOWZMWHpua282WGtKbDBzbHJpZ1JZSjVPT090NXRUbzhlQW9tSzhz?=
 =?utf-8?B?bWNJVWFFR1RFMUFDUU4wSFk0MDEzeHhlb203VFZrQUZtd0FEZ0c3eHJDVHRC?=
 =?utf-8?B?ajVwYXduOG00RWF3VXZKRTladkM5M3Fjb0tKN24rVmFtTjZjREwwVzdqZk0x?=
 =?utf-8?B?OWJ2T0xSRG1lMFZtT214em5BVGNCSzdFS3JWb3pVMUJFSldtMFNvS2t6NFZP?=
 =?utf-8?B?YTZIaHJBTjVPbnhlb3BSSXloQWJzNXRsY1BPaWtoa3dvdDhacHVLa3JSWjhP?=
 =?utf-8?B?bTJGWkhHUktPRGJ6Tkg1Q2JTbkY1OVo4ZXJaVjBNcXZ4NUtDYjZDcFhhUHBr?=
 =?utf-8?B?L1YxVjRSVlRCeklON3FFeGxOREIxVVEyK0VDeEFIN1RSRjhyVjR5ZmxMUWdn?=
 =?utf-8?B?ZVBSL29uSE9ZU0p1b2g4aEV5STBkYVBibEZjZWc0WDNMS3pqUWtJRnc4NFky?=
 =?utf-8?B?TFozckVYRDBybVQyaVBUd1RvUG9rYzB3eFJNMi9mL2RsOXdUNWdnMjVJdlA5?=
 =?utf-8?B?VWdrYVYrWmRiUytNL1BvU0xIUEpzT3JNL0dkVnB5Ukg4ZE1KMGxtS09WOHdi?=
 =?utf-8?B?RFMydC9ON0hqTWdoK1pqc1RWNEk3R3N0S2lOa1Nkd1JyWXdnYk1tM1RpQndT?=
 =?utf-8?B?UlMxeVJqOVdZdnBxTE80WVZyTjVrMlo0WFVjejJtcThFQ3p6V2VzQ3hrSENy?=
 =?utf-8?B?TmtzdkdWNzlXc1JuWjhLYy92WjlIdWt3enNJeTBWbzlRUjZlZmJYeXo1dmZt?=
 =?utf-8?B?Z01JekFFMjZGV1dvZW5EMnZ6MGUwOXNNMUlycmNKaUN3VllBWkZuVHUxMi9J?=
 =?utf-8?Q?YZJtS8tIZwg96vuGqEh6/In9a0M0qxRK1+fcPAP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b08c85-4bcc-470c-1e3c-08d8e94da5c4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 14:04:57.8121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/3/R10UalTTXI9Sc+xvQz2qpqEHd3clwk9B0GLZKlzUVm5JdXlAl1iGx4KwFyYZqxvDO38pgMXMVzDg6/kjZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1360
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
Cc: Simon Ser <contact@emersion.fr>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-03-16 5:50 p.m., Sefa Eyeoglu wrote:
> Sometimes the primary plane might not be initialized (yet), which
> causes dm_check_crtc_cursor to divide by zero.
> Apparently a weird state before a S3-suspend causes the aforementioned
> divide-by-zero error when resuming from S3.  This was explained in
> bug 212293 on Bugzilla.
> 
> To avoid this divide-by-zero error we check if the primary plane's fb
> isn't NULL.  If it's NULL the src_w and src_h attributes will be 0,
> which would cause a divide-by-zero.
> 
> This fixes Bugzilla report 212293
> https://bugzilla.kernel.org/show_bug.cgi?id=212293>> 
> Fixes: 12f4849a1cfd69f3 ("drm/amd/display: check cursor scaling")
> Signed-off-by: Sefa Eyeoglu <contact@scrumplex.net>

Thanks for your patch.

It is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 573cf17262da4e11..fbb1ac223ccbb62a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9267,7 +9267,8 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   
>   	new_cursor_state = drm_atomic_get_new_plane_state(state, crtc->cursor);
>   	new_primary_state = drm_atomic_get_new_plane_state(state, crtc->primary);
> -	if (!new_cursor_state || !new_primary_state || !new_cursor_state->fb) {
> +	if (!new_cursor_state || !new_primary_state ||
> +		!new_cursor_state->fb || !new_primary_state->fb) {
>   		return 0;
>   	}
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

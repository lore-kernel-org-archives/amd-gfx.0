Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34874C33CAA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 22:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D1221569
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 22:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fUpGkry+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D1221569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA366E15F;
	Thu, 23 Jan 2020 22:28:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F646E15F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 22:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxMlBNNbvkuW6NyIZS/QgRzkAyI30FrRURHRRoFkl3+6njVYOB2g4nnPhKC0A38xgA+dX9gOgoJH9gAkzyE8yVQqELJP99pnnWQxZZ9Ef2E6TZ6i9K8J0AzhJWa4Vm7HPvdqxGBw7BJ0yOBjZ+T4Y4/RnCC7/32q6B62DW7hhH9OVvJKAkslJR3hZCZpwhE1K+uAX+WJHck/uH6BBeEHUT+tRARkRNLaOkV712aQbJT61bjyPkKZK8MEjOpO+pxsmWl1VKXAxRAaUbrYuosfJ2il/qH8rsYYj1Pdtm92ee/WfKBk+3N+I5TsaK3ZPaMIvvGifrRxi7JDhwKTb12HFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziNnGytSb5dJM76ZldQDiNUAvLFIaPoXcLmV8/ao4ow=;
 b=LyBD8ZfR+czQhqjI9eHMEv0Pl0yR74OyBjGAmpal9p6k80PtwAh7LaO4RLxk5WnZcjZtxBK7MtJKRno4AwT76OFmVvtNbNrtd808SWEak0+NpVkieBkkHaVGqd4wajdMK0Zu/bZX319gepxHkJ4E8kdaNQsB3DVRi7GZLv8CIzgQFl94tfkcYAAxKsp9+jX/4lwT5CtbzxBVupMKcKlyO7aFFpAj6tuJOY2HbpzL/k7tbyw28bLKVQVr/MdMfODnewt/RDaZdny2n7leLRishexyDfmqq5vSv04PQKEZ2O+eoms2h9HFhM3dhEgQ7wDGusGNwASJFyvxB45uNfsneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziNnGytSb5dJM76ZldQDiNUAvLFIaPoXcLmV8/ao4ow=;
 b=fUpGkry+Q1ra8juMrewxKPrG5A7ndfLaoZNGfp/vMKl9S0RP+PHbd+iZ/7iXyA1H3mzjORngcZE3isUjlDMn8KH+dIj8TTHP2asoscIhU97CEvWDvvfyqTWBuEBwmz6mIySH0Mm6cTI2xyvT94dcMXyqo9ksyeZFKNG1HcCkLdI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0104.namprd12.prod.outlook.com (10.172.78.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Thu, 23 Jan 2020 22:28:27 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f%9]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 22:28:27 +0000
Subject: Re: [PATCH 2/2] Revert "drm/amd/display: Don't skip link training for
 empty dongle"
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200123194526.17967-1-harry.wentland@amd.com>
 <20200123194526.17967-2-harry.wentland@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <5c67cab2-ebd4-44f0-2fc7-7752c6097a72@amd.com>
Date: Thu, 23 Jan 2020 17:28:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200123194526.17967-2-harry.wentland@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::47) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 22:28:26 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0fed206-00fe-4788-f08d-08d7a05390dc
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0104:|CY4PR1201MB0104:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0104F809BFB11C690B4B1B428C0F0@CY4PR1201MB0104.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-Forefront-PRVS: 029174C036
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(31686004)(54906003)(16576012)(31696002)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(4326008)(5660300002)(2616005)(956004)(53546011)(2906002)(36756003)(52116002)(81166006)(8936002)(8676002)(81156014)(186003)(26005)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0104;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJwgLLdjoFLItCxiuZMFxq2KVv+qvY54rs7qUFtwV1qiJ+5Udw1kJuhRmJF8dow8qSojFfN7eayP848ysjwpWn8a49fxb3IurGQwMsNGVRjcO8uJcPpW1y9ctp2qQGiRTS0b/JdA6wCBpiAbcaME4EzSuSttLgAm8ifV3RM0WYJ7SHtYlsgtmHWcYsKsGhzDaRCph77rx6tV55yjwm1nbZswclrrXG9Y4rs3uaRg/AJh+n8y7cprJ00VjcYkjCxYhFyMUqxn+u7UoZhyY2wHCSiQWaMIwgm2TjJxlGyUKjdHlRwXMIhlGabknuDoPqUbKRSd336U9FL6/RKwtH5WBnazW6lJzeWjNNLpyFdIhlyKY6p3wTWK8iC7JBa+ZdNcIU9okzbxRf45WGn43f10tsuUX9wUb19jy6vUKlMvvOUpN71gGyfdyGXRssA+wY9y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fed206-00fe-4788-f08d-08d7a05390dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2020 22:28:27.1791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15V43dH4e2Z5IwRWLKfnkPDQhVMXnt+1Zw9ffvp2lQ1YK5LDyIvhzNOB670WhinVOeorQB6Bm4Pi0NWDfCG9Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0104
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
Cc: Hersen Wu <hersenxs.wu@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Louis Li <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-23 2:45 p.m., Harry Wentland wrote:
> This reverts commit 80adaebd2d411b7d6872a097634848a71eb13d20.
> 
> [WHY]
> This change was working around a regression that occured in this
> patch:
> 0301ccbaf67d drm/amd/display: DP Compliance 400.1.1 failure
> 
> With the fix to run verify_link_cap when the SINK_COUNT of
> dongles becomes non-zero this change is no longer needed.
> 
> Cc: Louis Li <Ching-shih.Li@amd.com>
> Cc: Wenjing Liu <Wenjing.Liu@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Eric Yang <Eric.Yang2@amd.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Both patches have been offline reviewed by Wenjing. I'll merge them with
his review.

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index cc2e05003595..a09119c10d7c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -851,18 +851,12 @@ static bool dc_link_detect_helper(struct dc_link *link,
>  				if (memcmp(&link->dpcd_caps, &prev_dpcd_caps, sizeof(struct dpcd_caps)))
>  					same_dpcd = false;
>  			}
> -			/* Active dongle plug in without display or downstream unplug*/
> +			/* Active dongle downstream unplug*/
>  			if (link->type == dc_connection_active_dongle &&
>  				link->dpcd_caps.sink_count.bits.SINK_COUNT == 0) {
> -				if (prev_sink != NULL) {
> +				if (prev_sink != NULL)
>  					/* Downstream unplug */
>  					dc_sink_release(prev_sink);
> -				} else {
> -					/* Empty dongle plug in */
> -					dp_verify_link_cap_with_retries(link,
> -							&link->reported_link_cap,
> -							LINK_TRAINING_MAX_VERIFY_RETRY);
> -				}
>  				return true;
>  			}
>  
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

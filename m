Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA2C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 13:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BC520679
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 13:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rWnL6cYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BC520679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C0EE89BFE;
	Wed,  3 Jun 2020 13:34:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7969E89BFE
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 13:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAV49pDGChzt/G4m168/W/QR+iN8XS6n8Q/RvHRBg1E9qa8vMvIb2yHgAHJjNCwoTD+adAH26ioRCyXHsyLt+IyFD910Zrb/LO3tVeR8SyCRfY0kY2p+f/dQ/+5Vs9cJOPO1jOiPQYopbom/BETMwiT91gbkoW9NFPU9qBC0GWMr2+X0oWyp6zijWyv+xpbDIzdd6Iaqd3tUDrJAK7oi1x3um4MlkIsnB+/acDGZa2bZ/KXtzl0cjAl/27GD3PmeliudCHKHUHVPwy0WC86zrneokE1s/dVVnfhWYF7mpUR/eDgi+cLYtPMi6JoBNTE+11e9brOT+xUmSaxkgfeaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulfUqio10wNemMmlAch9mxp74qAKXdC1j2OaKH3gR14=;
 b=k3Hv64Kkn1IrRJ/WBl7UI8zGdwFCz7wLm69yV4iI3I8n8B61oVQdzcRwl1ZBo+1UjxveQqYQxV/lc02UCiR7Ahjlke2K4dzbrfobNUoatoMSQ9+5o7CnTqqdXlRY+tW4pyjyy3iMsmmMCTttIaLt5yNN4onNm8B99gNkLftZn8s85vySvaTKEPLn4I0nOV8ORwHjFdQ5oRx6o0gHHl7S10ZHxoGsMFCuLq1YXl8oR6uhV2r9FYjT7O1ikUtfTexBFBb4V/zbkk/fNF2tjlb+qiaMe5PbghWJzxSfro4AkCvEBzVQus5drf8h0dzLodQkMhzCQPX9ZVJ5N3VN9cqE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulfUqio10wNemMmlAch9mxp74qAKXdC1j2OaKH3gR14=;
 b=rWnL6cYW9ms7rXmRR69cqyxkE7bK4gQc+G6xjeChzxdP6vEBlvqOk3hgQBxIDBltnINUSHLaPvFvACg2shzzzFflRhmzCYogBArK4eBJHSxkf8vhNW0OgnwtHukGTyFr5UZwlNTQT0aFSDLUXtImjPmauN3gTlaivClTH26tZY4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 13:34:49 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 13:34:49 +0000
Subject: Re: [PATCH] drm/amd/display: Only actually breakpoint if
 DEBUG_KERNEL_DC is enabled
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200603133210.5238-1-nicholas.kazlauskas@amd.com>
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
Message-ID: <09e8e4aa-488e-6f96-f57b-0f0f2768e061@amd.com>
Date: Wed, 3 Jun 2020 09:35:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603133210.5238-1-nicholas.kazlauskas@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::14) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.23] (99.254.88.27) by
 YTOPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 13:34:46 +0000
X-Originating-IP: [99.254.88.27]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc1009c4-9ccf-4e26-ead8-08d807c2e241
X-MS-TrafficTypeDiagnostic: MW3PR12MB4537:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4537729CE0BEC36F266643088C880@MW3PR12MB4537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0s1I/bG6xnHc4hEYbsptg2cPjq5FmUtg5FbUnEFrs50clX+O/RjWV8l7mCiowK8YpUg24JuYIu3deK1ANu26wzAJzHTplKi7JVK6pXTonModmUED+3h8V2n1Hr66zefQmmXPJZRdd9ULLf45C2hxjFdB40jyyHQTZzJmua+p1dVaDJGTnBVrVX3qyrXbqcWy9ZkQB70K7MVC5nHkPo8QhVdBjFzqNizlzvO2yAlVf4YRNaA1uQgyii324Ov/lONKT3XTN/j7/BIXmToLFvaLNrv/Ok1X7QevDc7lwYQXhANKsiMRTy/udtA0BvYFRGSrd3Xp0WKR9TA2+WmF7rbqCZS49cD52XoCFryLwVH4Dk6Su7ZTSs3vwoa70v4JHps
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(66946007)(36756003)(66476007)(6666004)(54906003)(16526019)(186003)(4326008)(956004)(31686004)(2616005)(2906002)(6486002)(66556008)(31696002)(52116002)(26005)(16576012)(53546011)(478600001)(316002)(8676002)(83380400001)(5660300002)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cm0krQ3WpPQAvcTG7BdYBQYPemzI59IhxO3oFE5gvaevWcbue8tV/5R1AdrYIFJnu3oaheeg3yIghFzFdbXxzLFWqvRwAk4SK7RuIQG3GTu3+Oh9J9qEbOmXG8BWbkaXeqtyrYRlwO9vJ3q4oWn8p8aR2etcLYS1W4vlbxbVnxq3pOYOJZ78VovbP63KpwZziph5gIQA8WurUTzvA9CUVkIChFGA41UT/5bm39IS+LCUFpQ0i5iT5AvYbKnJAWRXQ4WOFxNshoBjhiiySR85RNzGmY3dAMGE0MHwDwGyrMmPuDjWoK0Kqe8gnehbvyF+XlIw+hlZZmJMX6UWthc7Ovjp3mhMGGVPiL9neGpNKMohS2mgBUy8u+P2+XcP7ycRQVKEVMhQCUZOrgbHEhdnegdkqGBGxdAM7R4u5Ohkqtj91+7WBYp5YOkJaIL4NBJUfFtI428oMrZER9noF37chJMSyHXtqRAmhGzwSxwo9GA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1009c4-9ccf-4e26-ead8-08d807c2e241
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 13:34:48.6251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grcq/nL162Ux4xmwZu09S6TPxZ8OsOBl6FiN3ZiIELsoyvUorPmrXnUdoouJjH1ZVmd/WVaQHpa7I7kHA0iRJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4537
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
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-06-03 9:32 a.m., Nicholas Kazlauskas wrote:
> To match previous behavior and to not hang the kernel if someone
> accidentally builds with KGDB enabled.
> 
> Fixes: 4324a1752045 ("drm/amd/display: Make BREAK_TO_DEBUGGER() a debug print")
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/os_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
> index 604ceb6c0375..c3bbfe397e8d 100644
> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> @@ -111,7 +111,7 @@
>  #define ASSERT(expr) WARN_ON_ONCE(!(expr))
>  #endif
>  
> -#if defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB)
> +#if defined(CONFIG_DEBUG_KERNEL_DC) && (defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB))
>  #define BREAK_TO_DEBUGGER() \
>  	do { \
>  		DRM_DEBUG_DRIVER("%s():%d\n", __func__, __LINE__); \
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

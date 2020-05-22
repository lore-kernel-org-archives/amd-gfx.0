Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625F7C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A070206D5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D7VfxOcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A070206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09746EA27;
	Fri, 22 May 2020 18:21:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA316EA27
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 18:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx4R3ySDMBj10OuHqJFdn/4EmBerGRkKDumcHSEa+94dsHQi9FuQSlA3iTGbaI0i7J9/eOSNfCYlKndHYor1yNWNPXdw/tv54035FEFTBORU8qC5mQy7T9gNOdm0KCKjqijnq4e2dekNfa2LGFAoxE1YDa1flzzmUgIuULiq84D6kOL3zq1eOmT7dmMJQpJfPJysKeK0XCDStk3TOsYRz5/P5wSOaIKCkIOEad1vzquJ8S2x7FU++ijz9ACr5q9qVFVunWoVIyqiciTwMVe1LbpY03e8xI+6vpmPz/h1Ai2jlsIKtvST6zmSsu1Qfzyj8I+/pOPQpxNg3UydNVNPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df/ndJOsKkBMidk3wEpHq0MNkOAPjVvHfnAtr6JNJ3w=;
 b=ZCyDACnT1mfcCpuCNxwXaLEz5LrU3kZ8DMeCiJEmgT7kCuaqNy6geDPq1dRivNOAJt/Yg/nKQ1FLUjolExb69+1CA2rF11ZvnUWUepHpgeogguSKtpeOB/265HVwf9YsqSWUFJBAZNSo6DixVFsUpIv+rJocAMjx97+zSqNITJSPcIrvXzncJUsDlS+re2Zx3d6nYhiFIlARNpt+1eDSa+fnMnCBnVv6B3Bo9c7FCoReTv7n4MxcgHQyxx3PP768/h4kziE/SjfWerfDZfVchjSeJXAj3NGCTkxNsh+9p3swHW2eVhGgok7LfEoc1atEZSFiGyyu0Z/eFqB1zhNbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df/ndJOsKkBMidk3wEpHq0MNkOAPjVvHfnAtr6JNJ3w=;
 b=D7VfxOcQse+bgTO82W55WN7Yyb9hf2K9DNP5WlvMWLRqXjb8Dyi6v+/E62feenV5Xtum8t+0ODnzSuMVkml2R9H1+CJtXrP2Vp/JwvJfbP4fLEzvMgje1KLLxG8/WfU+jk8hvMSEYdY4iKM4aOwV1fB6T4mQ+0AHHHXES4wKxsA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 18:21:48 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%6]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 18:21:48 +0000
Subject: Re: [PATCH] drm/amd/display: Make BREAK_TO_DEBUGGER() a debug print
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200522180326.5325-1-nicholas.kazlauskas@amd.com>
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
Message-ID: <35b4b165-5af0-55d9-1418-b6d5fb884714@amd.com>
Date: Fri, 22 May 2020 14:22:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200522180326.5325-1-nicholas.kazlauskas@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:405:14::25) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.5.125] (165.204.84.11) by
 BN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:405:14::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 18:21:46 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99642db3-f1e0-4481-5c0e-08d7fe7cfdd3
X-MS-TrafficTypeDiagnostic: MW3PR12MB4538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45381F2DA1D142FF62567E578CB40@MW3PR12MB4538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84yybc/SSlMXm3hSLz84CRc6KQY8CzaQcKI3rTrjWdm0VzndJxFtjTh8SeE4fSoW7/88i2Q9iLrhtREreHX3CnxpCbHWN27ZEmyvkuX5As21miOBnA/T8jhJJIdm35hGLbyKXiS6SzINANVwoteE3MGyKKciUYnvY694y+ZniGxl+pknd0mBKpoJICfMAfoGy3DxecgzcHXIdg7KmKXcfiM3A5MiU42Yh27OBIe3WQ55WGwV7QBqur55hDkOQNrv5b2JR1TGdlLlRzNYUnW38LjzM/HSTd3z4+jCDVa62hZvxYSyAT7Se/hpZmidapWeVXr4ghWT5nlt38IkCwiVMGZ6uXEve21eNwz8YKy3ZGm6ShAfp6StQv7/p+v5ljgd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(36756003)(956004)(31696002)(66946007)(31686004)(66476007)(66556008)(5660300002)(4326008)(6666004)(26005)(2616005)(6486002)(53546011)(8936002)(16576012)(54906003)(16526019)(52116002)(186003)(2906002)(8676002)(478600001)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zY0rd6cnjHedb5li0nW0VG8qUlGK9p1bGWJhhBXg7vPa563h8XfL2SC9kYLnRPXvxR8nEfITxLo91CO7eQF7XWZoQKQuhy2zGPvVb8qsLC4w1HQ66J5TI7kcXiJ7iRuRqSE+M5Q0kmeYIip5t9jhIhv0SaWo319I/7K3hsV86jhdJEbGWQ8Rjpnb7z38Nqy3WRwzMhmFph/R4Q7bkPlt90juzs+fhF8n/32DVUBG/Wtb60uQJvfDdkwPFHAwQCX2YsY37pPUa502B1+lN/sV8s40bZrJpvGuMUUlSLPb7vtS6CJySu+JFEYQb6Ya8sU6/7B0cSXAame2kp0JNMV/ubcnYc8EFPquGNRam6dVSKyWHlxY9ed47Sa3bjTGojVORO5eLQZ2nFZllcv/LdjxqDgsAvbjJ78wgC9yFbqGyHSgavpFP2D+E1XaXKKBUzCrC2jU2V3YG3aDyvySl6L6nBUQ2Cy94kOewRwgILVoMcVNbqRlqizPpbYwDTbb12w7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99642db3-f1e0-4481-5c0e-08d7fe7cfdd3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 18:21:48.6750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOEA92vV8AWGnQ+IjEdH5tABUeGh1n/9GF0Y0NRcZyRCAmj62JhZmLbEsRnzLrf/rApfHzT7Aa72VblCvPRgKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538
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
Cc: Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-05-22 2:03 p.m., Nicholas Kazlauskas wrote:
> [Why]
> Warnings in the kernel are generally treated as errors.
> 
> The BREAK_TO_DEBUGGER macro is not a critical error or warning, but
> rather intended for developer use to help investigate behavior and
> sequences for other issues.
> 
> We do still make use of DC_ERROR/ASSERT(0) in various places in the
> code for things that are genuine issues.
> 
> Since most developers don't actually KGDB while debugging the kernel
> these essentially would have no value on their own since the KGDB
> breakpoint wouldn't trigger - ASSERT(0) was used as a shortcut to get
> a stacktrace.
> 
> [How]
> Turn it into a DRM_DEBUG_DRIVER print instead. We unfortunately lose
> the stacktrace, but we still do retain some of the useful debug
> information this offers by having at least the function and line
> number loggable.
> 
> If KGDB is supported in the kernel this will still trigger a real
> breakpoint as well.
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/os_types.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
> index 6d7bca562eec..604ceb6c0375 100644
> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> @@ -111,7 +111,15 @@
>  #define ASSERT(expr) WARN_ON_ONCE(!(expr))
>  #endif
>  
> -#define BREAK_TO_DEBUGGER() ASSERT(0)
> +#if defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB)
> +#define BREAK_TO_DEBUGGER() \
> +	do { \
> +		DRM_DEBUG_DRIVER("%s():%d\n", __func__, __LINE__); \
> +		kgdb_breakpoint(); \
> +	} while (0)
> +#else
> +#define BREAK_TO_DEBUGGER() DRM_DEBUG_DRIVER("%s():%d\n", __func__, __LINE__)
> +#endif
>  
>  #define DC_ERR(...)  do { \
>  	dm_error(__VA_ARGS__); \
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

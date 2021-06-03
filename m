Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D3C47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 13:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE175613B8
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 13:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE175613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 622496F477;
	Thu,  3 Jun 2021 13:11:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70376F477
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 13:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJywT9hGyOCM90IibuSMb88tp1hWOEHSOF7GH6uZtbojiYSRt8L+AW5f5ReSXxexd2gBGc8ZOojCnw9uEHf1fl/xiY1j0pHjBFYT97LW8YsmDKcZKJnXhYofUpMOX8AEVHQMsV4cW+SKKvsnZc7VK+ESrv6Jg5X/r7VmB3oKvaFaZ07WJTvosaUAiwq/DjgMpRzb40R1af/msSaBTh6e52pLtt0ejjcCfj1yugLCWSjmDxl8iWWIfXgDqjBsbkSmc0StZQKmzrOhP3OaEVTajkP98CMl347perkCfbRsIb6gPREDNCP60ikD5an4I5e4kROCENQEGQMr5B1w8ktbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCFECkXG9DFUVpwzuz2xHevcQD3hKgjvhAY6umKCvr0=;
 b=eCh1WqmWHyncXqy0YfDNOWQA+D9+Kx9eCYtDqyipS5aEs+4qJjeZ1gXvgxSNEl6yMlVa5CGNy+mlS89QbQgyctSbueEmvS9M5D4mjmknOAXYikgh5PVEw39INwC1HzzgGfcqUauNgXLIwf7nWCSMesJs43eSEtMqKCK5cq3vuCZ9IPiasQ6Q7ocbhfxgvdxJWkn+MjLiI3+QsvZpTzDym3LGpcWkTma/iIDjK7xQ4BpYL2YvLlZemM44vnowCT35UHamz4JYfh4w5bz6Zc7P7sWzmocFg15oHvWnhmx+ePUKDL/mitnxp2gwEH7COHwDEHkYnTaH+JIABcDBGYUgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCFECkXG9DFUVpwzuz2xHevcQD3hKgjvhAY6umKCvr0=;
 b=y4u8IgnzaUZREaKgI1RWFbjXn2d7PxT9jzUdWIsVfBHJH82kwaR+k2ps0eH7InpWJ4SSaJUiTYeXUqgaYZyH9727vOTuyxNUrKBZb8WzAha4KEub9QuanirIjoes4yacKWLvN3ZUYxsWhGmdiDjWWqS/I3MZ645MCbvETD9lCMQ=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4928.namprd12.prod.outlook.com (2603:10b6:5:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 13:10:57 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 13:10:57 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Topic: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Index: AQHXVxHnOs5rKx+Wikmn/4L8wjao+asAI9aAgAIf2AA=
Date: Thu, 3 Jun 2021 13:10:57 +0000
Message-ID: <DM6PR12MB30676D0E36B54D85296A685F8A3C9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
 <20210601181231.24773-4-Graham.Sider@amd.com>
 <DM6PR12MB26199099168565AAFB6690ACE43D9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26199099168565AAFB6690ACE43D9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-02T04:37:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1160a2c4-c7ad-40a2-846e-0d6c59d370a7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:1020:cb:6db9:3c91:43ce:5016]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44d83043-7097-492a-37d8-08d9269106ed
x-ms-traffictypediagnostic: DM6PR12MB4928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4928C947A4B1577D86C052048A3C9@DM6PR12MB4928.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eg1UYeJYXnhSJSTEiB9X6HO/e2WpQYLu4TTyLwgOm9Vi+1X6W7iCZ5J5xYVFVlLqkyBtYVdl0xI8X3vTVVdUYeoIbjj1JclwGxeZMYZKVcTePqZHYPbyS62gIq5G5CTgBhV6jAmVM6m7KKQR79rAfaLJBOfPLjln7zBqGkiVJcVCQSIkRaRjBjncTvNNHcyLHOkwMGKZu01yFP+lvDXdfgM5DrdkVAKeVrNXokNVLr1Dg1PpFbOIKfWi3ZmHSmLfrIqZ+kG7CJ9d2teIB1zsMyRHB5Aur3sepIlWU886LKQK3yPgoz8Sx1tOXQGuxUU9Dpd6QEgyPzwW4TslNZI2PQMxH1qVd0Wx7JTTGj0hnHyRUoIM5MjHTackx8QtUOkyrEbu8r1ROpdX+mBGt+wZWqMH0Yy5du7nZCMcatbdQfMhJO7OQpAsZGxvsV1XgFXsUZYuGf/hLnMYw+ZmPEKH50MAWgxpz40guzZF8XbsxZIMjAO0sTuC+Um2dV+ynuSd4+IH0ZxRb3+EzXddzSEy4L+PzpAgR3039oPgdk7FtZbcs0YdYNECcK31LcvSTVFaWa87lN1LQxM0vDFHzEfYKRcE9NsemTUDmjBqhkHPaYxdKtFtUjJXNKacpmt64iOpDDn8PG4P8bCN75K1k6ae1ewVDyxAZLMbhj4mBo1TkIVuNuBY6wudJDvgsfRaLzeAPLoW2cA6rcieKVPqh1bCkPyXuU4vH1hV36DJPvXTTcaXzyUAOKbRybq7EnL07lzTs3kj/EhvzlQU+uOaFANPXw0OCtKIgtvnK5L/VAt/Cz8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(54906003)(110136005)(316002)(76116006)(55016002)(9686003)(71200400001)(8936002)(2906002)(8676002)(86362001)(52536014)(5660300002)(122000001)(83380400001)(38100700002)(66446008)(53546011)(66946007)(33656002)(966005)(64756008)(7696005)(45080400002)(478600001)(66556008)(186003)(6506007)(4326008)(66476007)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+9Exw4IiZOiEForIHh5EEuajcf5iQ4VMfB2hYIxZPfi1RCrlKP5NUZFmGKD/?=
 =?us-ascii?Q?CfYyuLMNIYwJK2yKFYKM/EKEK9xVsVUDj774qfzHoeQLoZ/h1s1EMypJi128?=
 =?us-ascii?Q?+vZN7HGgBji5eLfcKnQX9GOv/9LNcqWybeVG2q7X8zV2dDM083PdDOZJIKsC?=
 =?us-ascii?Q?DmsUXEiS1la+iOPo8LbczjipBn1VgOtUWH0B3ESY02M4n0UU/Nf1DrEwN3Hp?=
 =?us-ascii?Q?8qmmMMqkyfdQsoiytNAb4ZhAuY99cklKFVnj10h8w9XUJa/C3X5HY8Us7utN?=
 =?us-ascii?Q?ukpYpT8H6x/qcWB4bW1KaNZWb81XyAJiH/oHtR+bWS2ifza2m9SL7uSx9eRG?=
 =?us-ascii?Q?x7jEGsuCjLwMcgxG7R86ZvTigBbNieBQDZjQaUye/n4WkG/Zp1fl8Xo0ct4B?=
 =?us-ascii?Q?6iLXrUOO4p7Ta9t4SpDK3eOx93OYNihdmu1uOMSuhecM1nf/yctbEyTogyQv?=
 =?us-ascii?Q?nH1SoINMzEWKrQUUzB2EeDsf/I9NPs2esp9LWIBoGjnZcDjH0S+8lQ/VNa+b?=
 =?us-ascii?Q?8cjSULVjaZ3tZwkUzDJhT5aKx30UmkpPGDjmiLmVgZCb3H6Zu5Yrn/otxCRz?=
 =?us-ascii?Q?45aKTM3YEIBq/u0ndZFLQ3hktglwam9TTCet9HF4cuQH6fFPsERGfX8yQuYq?=
 =?us-ascii?Q?jJ780EDMMy04iBPbo0afMLn6WBfQxL5199tbgxMMGPuo81SNej8YT46ojJyd?=
 =?us-ascii?Q?4C+tXyxsFiddF528ht6GmH8dfl7naFoythgUXwawrUYwXFQQfd2h3KgjqU4D?=
 =?us-ascii?Q?JfqV+dKY3VDhYRr60duYjANPzDMTWRR6+D565Cm91mDDojcnRNXP2qW7D9Uj?=
 =?us-ascii?Q?sDQpyOEBgWYkpAWNWk1QbedF/HQLIM9qrBlm0Tx7EjzQqO6Fj8nfbp7Jm9Em?=
 =?us-ascii?Q?oOABt+cKB9Gx0KtLGTB9TBdPurXPzBYG9b8z0tajzH86t65EaIIuush263AX?=
 =?us-ascii?Q?ZSRmrvXJecPvICtSSlI0bViWAi9ULVAXgEGzlIObPmx7OpXj3CTWAnzZA7RA?=
 =?us-ascii?Q?79JGf3iHb5K4xIm2GIoGxKcKcQyXWleBHo10sXC2wJMR8p+VVncV2SJKZBRG?=
 =?us-ascii?Q?Bsqu/kwsC0tn6mRv78Msm9ZcGK0MQFKm2QH1gNalw6EsIkqVuiL5aZkYtI6k?=
 =?us-ascii?Q?2PW9huUc3MblwSTfEiefFYAd+SdAxHLwDku0idgdicudq5jIO3FdnKiP7My9?=
 =?us-ascii?Q?B43MxIVwcnWItZYxEqRFirJRSwHh3+J3VhkXAzW0LcK0/SPnm9AqmummPbf6?=
 =?us-ascii?Q?kvaoHP7V6WTlrtoQ3VKte0KPtwJPepwUh2LyAUPcdTCcIY9RmMb+me98nVkE?=
 =?us-ascii?Q?+sgKcNGsN/NKXHlCfuyPpQRZq/FpTxQT7f+2mKqZMIKA2i49fyKM1vUmQE1b?=
 =?us-ascii?Q?PyAqx5ba0RM6dpDovNDyW6zjm7ce?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d83043-7097-492a-37d8-08d9269106ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 13:10:57.3791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rs84BzNfkgHo7ydxdILFmMCXjDzkPTJLdLhgzUOguOdFXAqbkwRp4VLpJ6eSU8KwhzzJ8+Mc4XAsjlCu08R6oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4928
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Sakhnovitch,
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some ASICs use a single VR_MEM bit, whereas others split it into VR_MEM0 and VR_MEM1. To avoid confusion, we've combined the VR_MEM0 and VR_MEM1 bits on those ASICs. For consistency we did the same with LIQUID0 and LIQUID1. 

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Wednesday, June 2, 2021 12:37 AM
To: Sider, Graham <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sider, Graham <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Graham Sider
> Sent: Wednesday, June 2, 2021 2:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish 
> <Harish.Kasiviswanathan@amd.com>; Sider, Graham 
> <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) 
> <Elena.Sakhnovitch@amd.com>
> Subject: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
> 
> Perform dependent to independent throttle status translation for 
> navi1x. Makes use of lookup table navi1x_throttler_map.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43
> +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 78fe13183e8b..bf376b1be08d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -238,6 +238,28 @@ static struct cmn2asic_mapping 
> navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
>  	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> 	WORKLOAD_PPLIB_CUSTOM_BIT),
>  };
> 
> +static const uint8_t navi1x_throttler_map[] = {
> +	[THROTTLER_TEMP_EDGE_BIT]	=
> (SMU_THROTTLER_TEMP_EDGE_BIT),
> +	[THROTTLER_TEMP_HOTSPOT_BIT]	=
> (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
> +	[THROTTLER_TEMP_MEM_BIT]	=
> (SMU_THROTTLER_TEMP_MEM_BIT),
> +	[THROTTLER_TEMP_VR_GFX_BIT]	=
> (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> +	[THROTTLER_TEMP_VR_MEM0_BIT]	=
> (SMU_THROTTLER_TEMP_VR_MEM_BIT),
> +	[THROTTLER_TEMP_VR_MEM1_BIT]	=
> (SMU_THROTTLER_TEMP_VR_MEM_BIT),
[Quan, Evan] I'm wondering why you map the two ASIC dependent bits to the same non ASIC independent bit. Instead of defining two non ASIC independent bits.
> +	[THROTTLER_TEMP_VR_SOC_BIT]	=
> (SMU_THROTTLER_TEMP_VR_SOC_BIT),
> +	[THROTTLER_TEMP_LIQUID0_BIT]	=
> (SMU_THROTTLER_TEMP_LIQUID_BIT),
> +	[THROTTLER_TEMP_LIQUID1_BIT]	=
> (SMU_THROTTLER_TEMP_LIQUID_BIT),
[Quan, Evan] Same question here and for Patch4.

BR
Evan
> +	[THROTTLER_TDC_GFX_BIT]		=
> (SMU_THROTTLER_TDC_GFX_BIT),
> +	[THROTTLER_TDC_SOC_BIT]		=
> (SMU_THROTTLER_TDC_SOC_BIT),
> +	[THROTTLER_PPT0_BIT]		=
> (SMU_THROTTLER_PPT0_BIT),
> +	[THROTTLER_PPT1_BIT]		=
> (SMU_THROTTLER_PPT1_BIT),
> +	[THROTTLER_PPT2_BIT]		=
> (SMU_THROTTLER_PPT2_BIT),
> +	[THROTTLER_PPT3_BIT]		=
> (SMU_THROTTLER_PPT3_BIT),
> +	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
> +	[THROTTLER_PPM_BIT]		=
> (SMU_THROTTLER_PPM_BIT),
> +	[THROTTLER_APCC_BIT]		=
> (SMU_THROTTLER_APCC_BIT),
> +};
> +
> +
>  static bool is_asic_secure(struct smu_context *smu)  {
>  	struct amdgpu_device *adev = smu->adev; @@ -524,6 +546,19 @@ static 
> int navi10_tables_init(struct smu_context
> *smu)
>  	return -ENOMEM;
>  }
> 
> +static uint64_t navi1x_get_indep_throttler_status(
> +					const unsigned long dep_status)
> +{
> +	uint64_t indep_status = 0;
> +	uint8_t dep_bit = 0;
> +
> +	for_each_set_bit(dep_bit, &dep_status, 32)
> +		indep_status |= smu_u64_throttler_bit(dep_status,
> +			navi1x_throttler_map[dep_bit], dep_bit);
> +
> +	return indep_status;
> +}
> +
>  static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>  					      MetricsMember_t member,
>  					      uint32_t *value)
> @@ -2673,6 +2708,8 @@ static ssize_t
> navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> @@ -2750,6 +2787,8 @@ static ssize_t navi10_get_gpu_metrics(struct 
> smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> @@ -2826,6 +2865,8 @@ static ssize_t
> navi12_get_legacy_gpu_metrics(struct smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> @@ -2908,6 +2949,8 @@ static ssize_t navi12_get_gpu_metrics(struct 
> smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cf05ba28afbe0417ac
> 54008d925290dc0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7581680520671680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> PzZzTHlRh0ygXIJdQeN8%2Ff4ojC9KcCy4Ia5POPGw1nI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA4C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 04:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA48610A6
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 04:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA48610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8508D6E926;
	Wed, 30 Jun 2021 04:32:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 333C56E925
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 04:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqKEZ870CLu2CQjz7L2A3Oq4SIuPdTJiEx8tledOyRrX/fSh8yDh7rlaazlcGvTJ/2lu0INO66eV+7T+f78KJs+PrWAolEiPmpDqGD5B2uJRJDoUXF1fgIrl6AtSiI7YSj2Y+Pat5J4BlmgkSYmf8LfmXgfElns9yRC/P3COI1ti4Gg4VdhLyvAlpm5N04fU5ObfszhA6etoMuOoYsHJF06R+cU7FAnELEeKWjvwrwA5PhWGqEbAdKt3cTbim4OPMNmJ5UXh7tbUxrBzw7rYmNpfaaNfsasUnYiJh0P/MTvVfMTralZxv8N61lZxSk8Fiz75Rqz1+YCULefqeMHNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/fQ53Iq1pdebtXWeMpSwouJbFbd6N5c9WNtxS/A1xY=;
 b=bUm573Yp6j39U80BUDFiJZNocKuv4mK1mMAIe+Nf9xChXEMPUX5yehrgDvAC2giKizSgoGP8Q0KLR9GnVcj4mvPzBlxZERm4seA2rPe5825M67KAJzeLbD1fjIC2Kbrw2yPjkwNOjjEWPkJqBASPYF/bWd+8P0XiYm+K2Wn9S0uqhNrARv9MKgt9ypx718osJr0f7QQsmD1YYLU0fEzi/LBkQ3VzglcYYBwRvsTLUluwoE6XZfdSlsraFFjESNGrN2BvbnBbfmDcaA6n6/B3DjQiIdEoV/0rGDE6ZVNOI9vwL/0ullwYQgEmE21r7hhuMje7xFEBe7teVLOPzQxCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/fQ53Iq1pdebtXWeMpSwouJbFbd6N5c9WNtxS/A1xY=;
 b=wwvk1+yao/yIESl8SUcqtWGMPCq4vsJZxNxi0MH6WDqSrKC8Ieicmgq9jmylkb/dbss4TFG+uv8Gc9DCJZAQjWJr3c559qW2tJVuGnuEVDjlvnyfvRmX9PLO/OpysbyrIOsRlfYRPwIH+xs5pprohplUH5QxDZd5XO157kXw1rI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Wed, 30 Jun 2021 04:31:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 04:31:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving
 for Sienna Cichlid
Thread-Topic: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving
 for Sienna Cichlid
Thread-Index: AQHXaZnS3tnW57ggTUOcbwWfISbVqKsrBOCAgADleECAAAkBAIAACQFQ
Date: Wed, 30 Jun 2021 04:31:59 +0000
Message-ID: <DM6PR12MB2619A0EA3FAE7FBB3EDF2957E4019@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210625081203.978006-1-evan.quan@amd.com>
 <bcef032d-507b-e04c-efa8-1f63e4a48707@amd.com>
 <DM6PR12MB2619CF378B8CDD0856459A29E4019@DM6PR12MB2619.namprd12.prod.outlook.com>
 <e1548530-f4be-d58d-e107-15c39935b812@amd.com>
In-Reply-To: <e1548530-f4be-d58d-e107-15c39935b812@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-30T04:31:56Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c7acd549-b5a6-4661-9594-b1568be522be;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cf72ceb-fd87-4a55-a249-08d93b80003b
x-ms-traffictypediagnostic: DM5PR12MB2502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2502C605AEBED1B415DC24C8E4019@DM5PR12MB2502.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vLqkXp/YslQDz+QsMOnjgwIHtY/Gh9tjsasA/31rl0J8ljbNnpwjKP3VwNVbf0JDk1lEyTXUHjHANeMCiIEfMXeQb84/ZJ2SYvVb/sYEspGD9VZIdxx2HKUBf1Aar686q0GOQjTTGVnj7LoEiGRtsdREjTNbc4293z22CyqEJ7GBnwNJ0U12cL3CUKoks+Dt1PVUNbw7qj2ViSEybYNvsx7yEeUr9ySo5t+l4KPk0fna3qg6frAk804xjryEjY3cCwf9+3KY5G7wwUBmYY8WdJMQT1PmUmyb6o1r8R/2dJOgk8gOI9aI08banqxODv8m4CHWhFWfoGsICqc7zyC50ONiaafiYnbJ9l5Q7hKEeWzAR3cNH2AeSJeByGOyj6x84s2Rs9lwSTJhwHi1HjdJC4ByapoN9qomOAoo9t9dPGsxd82XGWsUP50imRBmUBGF1KZFBWlUILAeds1DWWkDPlwls8ofAGyk3yUt24+BhoyYuUSGl8/VPRbI0QrYc1BMFEof+ccKLnFR+BVv239rvxmgc0K5pTmm9eBqSSF1YbDUKn1MEMeCROGqy0gkE+IwhX5LHd3Z/Kg4Wzw7If3ERL3zGepBCzYnjwj2ulAUjyv9nS44Kjd9kQSgY71DpwNjvyIFNotQFKepZUqZYodPQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(2906002)(53546011)(30864003)(52536014)(6506007)(83380400001)(76116006)(66946007)(316002)(4326008)(122000001)(86362001)(71200400001)(38100700002)(8676002)(26005)(66556008)(64756008)(55016002)(8936002)(66476007)(15650500001)(9686003)(186003)(33656002)(110136005)(66446008)(7696005)(19627235002)(5660300002)(478600001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjB3MUlxL1prY0Zta3pVR3ltOGVtdWlSKzNkc2lxay8zd2dMZXFmVEJreTh4?=
 =?utf-8?B?RHVlSVdzbW9HblplaS9RdkR6ZGFSZkpEOElGSnFLcjczTXJTYy9FSzBnWFNI?=
 =?utf-8?B?UHZvcDdLTU4yTlRNQmZMZkl1bk9udXRhVlJDSG1GOHFsUEpCQ3pycHlFR080?=
 =?utf-8?B?aWM0c3VYbWp5d0tZcGxJNmZnbDhrU21aVmJJbnQ3cFREYm05V09XcmY2bzZP?=
 =?utf-8?B?T3VVM3JoRy9NNnZmNHhtUXBJcjMwaXNBRGdTbytzRWo4RGVUVHdlWnJlUmZx?=
 =?utf-8?B?V0dUa1RML1BONzgwV2NrV3ZleXM2dlFaU3c5Y0lBVExmM2FxbjhqMjljU1Jy?=
 =?utf-8?B?THFjVVkxZk5vS3I2T2RuUzRhUUFhK0NpQ3ZNZXVZWWFBVEhTNFh1RnlqcGty?=
 =?utf-8?B?cjRTMEdtWTdPNWxTNk1wZlZRSzNrMkFOSlVNYUdqYmR2VlZSNCt0c3UxVkJH?=
 =?utf-8?B?Tm00YUkybHBvbkh0TmJxWk9BT3R3d2Y5bHQ3Q1VlTjhLZzhtV2YyMkxyL1Ns?=
 =?utf-8?B?a3FtcDFIc3pBQlViWVhYdDduc1RMeWRKdzdsS0h4djRpR1FiUlRDMjVLdUdl?=
 =?utf-8?B?UTVUTkJVK3E0Smt6VVQ0c0FrbURGTUo3ODIrUkc2bzV6MlJwWXYxeHNBNFNK?=
 =?utf-8?B?Q1Y2aEsyOVVSUTluZWZHS3JObEt0Q2xrdFNwWC90OG55L000eU1TMWIzR0JB?=
 =?utf-8?B?ZFBpU2ZIbDBxMENrN0gveS9ScDAxL1pFZUJPVEIxNjFkSmwwYndQVUp1WUQv?=
 =?utf-8?B?NTNYdDVMUDBRbFpYbzJqZFBNQTNsOTVpcTJlcmp6RWxtMUFESHBvanluUzh6?=
 =?utf-8?B?dEVqN0JlYllHNzFuaUZ5M0Z4ZjNsdWFSVlY1cEs1TmNEblJ0aXJIUGhlZ3VW?=
 =?utf-8?B?dVE4cmdkQTNUQ29ZYkhZZ1pENEFLNXl2WUJVWlphc2pNOFR0cHRKMWd3bGd4?=
 =?utf-8?B?T1Iwais2NnJGYUZLc092WTNhZDA4c3BlRHFseDE2bkFFdGFURWxsOE1tTkU4?=
 =?utf-8?B?RnRyNWxaeTc0cE9mSm1wNUQ0NjJ1MzUvSlZkdjZoaStzNnBLWmdydGZRcG9E?=
 =?utf-8?B?VXVYQVVQMk02cWRDS3FxY2RlV2FQSnNUZVU1SUxRWitjQUxGTnlUVVUrdXhS?=
 =?utf-8?B?aFZqSzVRZlBzYlRZNGQxTlVrRDJYekM1YWFiMWFTbWsrd0w2b0xGUUVQMS9P?=
 =?utf-8?B?dElsbUtFTFhOQVBDMHNnWi92S0k0SFBQZFErQ3dwVGhKZmZROGFVbmkyN1pR?=
 =?utf-8?B?ZmZjTTE2eVZSODQvN1NuL0Y2UUdYdUJaeGhHYzI0ZzJYWHBPZVo3V25VdXdS?=
 =?utf-8?B?SUE3ckJyMzg1UVN6NWFjVWZYRTFlclFXYWREY002MjdHQTlzSlBMRExSUGFD?=
 =?utf-8?B?Y0JXM0NrMWU4amN4NXZKSEZRREpBeSs3N0dqdkFqMHpxOEx2bUUxZTlyeUt4?=
 =?utf-8?B?bnBDR3E3WSs1WGNyeVpWTUJ3d3d0Y3R3M09USU96WTJNTGk2YlU4YWhaMFNv?=
 =?utf-8?B?cFkwdUlJWXhkcVlnTk5oUFJXTkJhM0g1dVkxSFlzeW96MWgrVVUzdmVPYU04?=
 =?utf-8?B?TTlmNE4wSzBTUlZ4OFliWVV6YStpN0ZiRzRNOGdmVGtHWXA3dG5JM3E3L1JR?=
 =?utf-8?B?ZTd6NkRqUEp1WmR1UkY5NVRBb011VTFsSDU4U044WnZQMDI0OUxIbjgyTlpj?=
 =?utf-8?B?UzBtM1JHMUFzVU0yWEN2R3RTeCtwK1M4dGF6ZXUycHkzY2hxT0hOL1hLbE9O?=
 =?utf-8?Q?hn0g1o/ZO5KxzydRC920f3rqC2UKXoyRDdvJkxZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf72ceb-fd87-4a55-a249-08d93b80003b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 04:31:59.3607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIxYFE4gXcqOs+lyZwSPHEBndsLDVYpd55iVmk/91et21+ZLXhfOIV5dl2AdkKyc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, June 30, 2021 11:52 AM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 1/2] drm/amd/pm: update the gpu metrics data
> retrieving for Sienna Cichlid
> 
> 
> 
> On 6/30/2021 8:56 AM, Quan, Evan wrote:
> > [AMD Official Use Only]
> >
> >
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Tuesday, June 29, 2021 9:38 PM
> >> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Subject: Re: [PATCH 1/2] drm/amd/pm: update the gpu metrics data
> >> retrieving for Sienna Cichlid
> >>
> >>
> >>
> >> On 6/25/2021 1:42 PM, Evan Quan wrote:
> >>> Due to the structure layout change: "uint32_t ThrottlerStatus" -> "
> >>> uint8_t  ThrottlingPercentage[THROTTLER_COUNT]".
> >>>
> >>> Change-Id: Id5c148b0584d972ae73fb9d7347a312944cec13d
> >>> Signed-off-by: Evan Quan <evan.quan@amd.com>
> >>> ---
> >>>    .../pm/inc/smu11_driver_if_sienna_cichlid.h   |  63 ++++-
> >>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 234
> ++++++++++++---
> >> ---
> >>>    2 files changed, 222 insertions(+), 75 deletions(-)
> >>>
> >>> diff --git
> >>> a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> >>> b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> >>> index 61c87c39be80..0b916a1933df 100644
> >>> --- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> >>> +++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> >>> @@ -211,6 +211,7 @@ typedef enum {
> >>>    #define THROTTLER_FIT_BIT          17
> >>>    #define THROTTLER_PPM_BIT          18
> >>>    #define THROTTLER_APCC_BIT         19
> >>> +#define THROTTLER_COUNT            20
> >>>
> >>>    // FW DState Features Control Bits
> >>>    // FW DState Features Control Bits
> >>> @@ -1406,7 +1407,67 @@ typedef struct {
> >>>    } SmuMetrics_t;
> >>>
> >>>    typedef struct {
> >>> -  SmuMetrics_t SmuMetrics;
> >>> +  uint32_t CurrClock[PPCLK_COUNT];
> >>> +
> >>> +  uint16_t AverageGfxclkFrequencyPreDs;  uint16_t
> >>> + AverageGfxclkFrequencyPostDs;  uint16_t
> AverageFclkFrequencyPreDs;
> >>> + uint16_t AverageFclkFrequencyPostDs;  uint16_t
> >>> + AverageUclkFrequencyPreDs  ;  uint16_t
> AverageUclkFrequencyPostDs  ;
> >>> +
> >>> +
> >>> +  uint16_t AverageGfxActivity    ;
> >>> +  uint16_t AverageUclkActivity   ;
> >>> +  uint8_t  CurrSocVoltageOffset  ;
> >>> +  uint8_t  CurrGfxVoltageOffset  ;
> >>> +  uint8_t  CurrMemVidOffset      ;
> >>> +  uint8_t  Padding8        ;
> >>> +  uint16_t AverageSocketPower    ;
> >>> +  uint16_t TemperatureEdge       ;
> >>> +  uint16_t TemperatureHotspot    ;
> >>> +  uint16_t TemperatureMem        ;
> >>> +  uint16_t TemperatureVrGfx      ;
> >>> +  uint16_t TemperatureVrMem0     ;
> >>> +  uint16_t TemperatureVrMem1     ;
> >>> +  uint16_t TemperatureVrSoc      ;
> >>> +  uint16_t TemperatureLiquid0    ;
> >>> +  uint16_t TemperatureLiquid1    ;
> >>> +  uint16_t TemperaturePlx        ;
> >>> +  uint16_t Padding16             ;
> >>> +  uint32_t AccCnt                ;
> >>> +  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
> >>> +
> >>> +
> >>> +  uint8_t  LinkDpmLevel;
> >>> +  uint8_t  CurrFanPwm;
> >>> +  uint16_t CurrFanSpeed;
> >>> +
> >>> +  //BACO metrics, PMFW-1721
> >>> +  //metrics for D3hot entry/exit and driver ARM msgs  uint8_t
> >>> + D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
> >>> +  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
> >>> +  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
> >>> +
> >>> +  //PMFW-4362
> >>> +  uint32_t EnergyAccumulator;
> >>> +  uint16_t AverageVclk0Frequency  ;
> >>> +  uint16_t AverageDclk0Frequency  ;
> >>> +  uint16_t AverageVclk1Frequency  ;
> >>> +  uint16_t AverageDclk1Frequency  ;
> >>> +  uint16_t VcnActivityPercentage  ; //place holder, David N. to provide
> full
> >> sequence
> >>> +  uint8_t  PcieRate               ;
> >>> +  uint8_t  PcieWidth              ;
> >>> +  uint16_t AverageGfxclkFrequencyTarget;  uint16_t Padding16_2;
> >>> +
> >>> +} SmuMetrics_V2_t;
> >>> +
> >>> +typedef struct {
> >>> +  union {
> >>> +    SmuMetrics_t SmuMetrics;
> >>> +    SmuMetrics_V2_t SmuMetrics_V2;
> >>> +  };
> >>>      uint32_t Spare[1];
> >>>
> >>>      // Padding - ignore
> >>> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >>> index 0c3407025eb2..f882c6756bf0 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >>> @@ -80,6 +80,13 @@
> >>>    		(*member) = (smu->smu_table.driver_pptable +
> >> offsetof(PPTable_t, field));\
> >>>    } while(0)
> >>>
> >>> +#define GET_METRICS_MEMBER(field, member) do { \
> >>> +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && (smu-
> >>> smc_fw_version >= 0x3A4300)) \
> >>> +		(*member) = ((void *)(&(((SmuMetricsExternal_t *)(smu-
> >>> smu_table.metrics_table))->SmuMetrics_V2)) +
> offsetof(SmuMetrics_V2_t,
> >> field)); \
> >>> +	else \
> >>> +		(*member) = ((void *)(&(((SmuMetricsExternal_t
> >>> +*)(smu->smu_table.metrics_table))->SmuMetrics)) +
> >>> +offsetof(SmuMetrics_t, field)); \ } while(0)
> >>> +
> >>>    static int get_table_size(struct smu_context *smu)
> >>>    {
> >>>    	if (smu->adev->asic_type == CHIP_BEIGE_GOBY) @@ -489,13
> >> +496,33 @@
> >>> static int sienna_cichlid_tables_init(struct smu_context *smu)
> >>>    	return -ENOMEM;
> >>>    }
> >>>
> >>> +static uint32_t sienna_cichlid_get_throttler_status_locked(struct
> >>> +smu_context *smu) {
> >>> +	struct smu_table_context *smu_table= &smu->smu_table;
> >>> +	SmuMetricsExternal_t *metrics_ext =
> >>> +		(SmuMetricsExternal_t *)(smu_table->metrics_table);
> >>> +	uint32_t throttler_status = 0;
> >>> +	int i;
> >>> +
> >>> +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
> >>> +	     (smu->smc_fw_version >= 0x3A4300)) {
> >>> +		for (i = 0; i < THROTTLER_COUNT; i++) {
> >>> +			if (metrics_ext-
> >>> SmuMetrics_V2.ThrottlingPercentage[i])
> >>> +				throttler_status |= 1U << i;
> >>> +		}
> >>> +	} else {
> >>> +		throttler_status = metrics_ext->SmuMetrics.ThrottlerStatus;
> >>> +	}
> >>> +
> >>> +	return throttler_status;
> >>> +}
> >>> +
> >>>    static int sienna_cichlid_get_smu_metrics_data(struct smu_context
> *smu,
> >>>    					       MetricsMember_t member,
> >>>    					       uint32_t *value)
> >>>    {
> >>> -	struct smu_table_context *smu_table= &smu->smu_table;
> >>> -	SmuMetrics_t *metrics =
> >>> -		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> >>> SmuMetrics);
> >>> +	uint32_t *data_u32;
> >>> +	uint16_t *data_u16;
> >>>    	int ret = 0;
> >>>
> >>>    	mutex_lock(&smu->metrics_lock);
> >>> @@ -510,78 +537,100 @@ static int
> >>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
> >>>
> >>>    	switch (member) {
> >>>    	case METRICS_CURR_GFXCLK:
> >>> -		*value = metrics->CurrClock[PPCLK_GFXCLK];
> >>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> >>
> >> One problem with this style is the need to track the datatype of each field.
> >> Why not use the old style?
> >>
> >> metricsv1? metricsv1->field : metricsv2->field;
> > [Quan, Evan] With that, there will be too many "if{}else{}".  Also I see there
> seems coming some new changes for the metrics table. I'm afraid the
> situation will be worse in the further.
> > With this macro way, we can keep the code clean and tidy.
> 
> I was talking about something like this, not with if..else. v1 or v2 is
> assigned to be non-null based on FW version check.
> 
> *value = metricsv1? metricsv1->CurrClock[PPCLK_GFXCLK]:
> metricsv2->CurrClock[PPCLK_GFXCLK];
[Quan, Evan] OK, i probably get your point.
> 
> The number of condition checks are same with the macro as well (it only
> hides it and probably this one also may be hidden using a macro). The
> problem is if newer datastructure changes the datatype of a field, then
> the current macro won't be reliable. Anyway, if there are more changes
> expected in the metrics table, let's wait.
[Quan, Evan] No, this is not an optimization which can be performed later. Instead it's a bug fix. As the new metrics table bundled with .68 and later PMFW is incompatible with previous version. That makes the fan speed retrieved through metrics table incorrect.
>>> +  uint8_t  LinkDpmLevel;
>>> +  uint8_t  CurrFanPwm;
>>> +  uint16_t CurrFanSpeed;
I can go with the way you suggested if you do see "newer datastructure changes the datatype of a field" as a concern here.

BR
Evan
> 
> Thanks,
> Lijo
> 
> >
> > BR
> > Evan
> >>
> >> Thanks,
> >> Lijo
> >>
> >>> +		*value = data_u32[PPCLK_GFXCLK];
> >>>    		break;
> >>>    	case METRICS_CURR_SOCCLK:
> >>> -		*value = metrics->CurrClock[PPCLK_SOCCLK];
> >>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> >>> +		*value = data_u32[PPCLK_SOCCLK];
> >>>    		break;
> >>>    	case METRICS_CURR_UCLK:
> >>> -		*value = metrics->CurrClock[PPCLK_UCLK];
> >>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> >>> +		*value = data_u32[PPCLK_UCLK];
> >>>    		break;
> >>>    	case METRICS_CURR_VCLK:
> >>> -		*value = metrics->CurrClock[PPCLK_VCLK_0];
> >>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> >>> +		*value = data_u32[PPCLK_VCLK_0];
> >>>    		break;
> >>>    	case METRICS_CURR_VCLK1:
> >>> -		*value = metrics->CurrClock[PPCLK_VCLK_1];
> >>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> >>> +		*value = data_u32[PPCLK_VCLK_1];
> >>>    		break;
> >>>    	case METRICS_CURR_DCLK:
> >>> -		*value = metrics->CurrClock[PPCLK_DCLK_0];
> >>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> >>> +		*value = data_u32[PPCLK_DCLK_0];
> >>>    		break;
> >>>    	case METRICS_CURR_DCLK1:
> >>> -		*value = metrics->CurrClock[PPCLK_DCLK_1];
> >>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> >>> +		*value = data_u32[PPCLK_DCLK_1];
> >>>    		break;
> >>>    	case METRICS_CURR_DCEFCLK:
> >>> -		*value = metrics->CurrClock[PPCLK_DCEFCLK];
> >>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> >>> +		*value = data_u32[PPCLK_DCEFCLK];
> >>>    		break;
> >>>    	case METRICS_CURR_FCLK:
> >>> -		*value = metrics->CurrClock[PPCLK_FCLK];
> >>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> >>> +		*value = data_u32[PPCLK_FCLK];
> >>>    		break;
> >>>    	case METRICS_AVERAGE_GFXCLK:
> >>> -		if (metrics->AverageGfxActivity <=
> >> SMU_11_0_7_GFX_BUSY_THRESHOLD)
> >>> -			*value = metrics->AverageGfxclkFrequencyPostDs;
> >>> +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> >>> +		if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> >>> +
> >> 	GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs,
> >> &data_u16);
> >>>    		else
> >>> -			*value = metrics->AverageGfxclkFrequencyPreDs;
> >>> +
> >> 	GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs,
> >> &data_u16);
> >>> +		*value = *data_u16;
> >>>    		break;
> >>>    	case METRICS_AVERAGE_FCLK:
> >>> -		*value = metrics->AverageFclkFrequencyPostDs;
> >>> +		GET_METRICS_MEMBER(AverageFclkFrequencyPostDs,
> >> &data_u16);
> >>> +		*value = *data_u16;
> >>>    		break;
> >>>    	case METRICS_AVERAGE_UCLK:
> >>> -		*value = metrics->AverageUclkFrequencyPostDs;
> >>> +		GET_METRICS_MEMBER(AverageUclkFrequencyPostDs,
> >> &data_u16);
> >>> +		*value = *data_u16;
> >>>    		break;
> >>>    	case METRICS_AVERAGE_GFXACTIVITY:
> >>> -		*value = metrics->AverageGfxActivity;
> >>> +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> >>> +		*value = *data_u16;
> >>>    		break;
> >>>    	case METRICS_AVERAGE_MEMACTIVITY:
> >>> -		*value = metrics->AverageUclkActivity;
> >>> +		GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
> >>> +		*value = *data_u16;
> >>>    		break;
> >>>    	case METRICS_AVERAGE_SOCKETPOWER:
> >>> -		*value = metrics->AverageSocketPower << 8;
> >>> +		GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
> >>> +		*value = *data_u16 << 8;
> >>>    		break;
> >>>    	case METRICS_TEMPERATURE_EDGE:
> >>> -		*value = metrics->TemperatureEdge *
> >>> +		GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
> >>> +		*value = *data_u16 *
> >>>    			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >>>    		break;
> >>>    	case METRICS_TEMPERATURE_HOTSPOT:
> >>> -		*value = metrics->TemperatureHotspot *
> >>> +		GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
> >>> +		*value = *data_u16 *
> >>>    			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >>>    		break;
> >>>    	case METRICS_TEMPERATURE_MEM:
> >>> -		*value = metrics->TemperatureMem *
> >>> +		GET_METRICS_MEMBER(TemperatureMem, &data_u16);
> >>> +		*value = *data_u16 *
> >>>    			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >>>    		break;
> >>>    	case METRICS_TEMPERATURE_VRGFX:
> >>> -		*value = metrics->TemperatureVrGfx *
> >>> +		GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
> >>> +		*value = *data_u16 *
> >>>    			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >>>    		break;
> >>>    	case METRICS_TEMPERATURE_VRSOC:
> >>> -		*value = metrics->TemperatureVrSoc *
> >>> +		GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
> >>> +		*value = *data_u16 *
> >>>    			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >>>    		break;
> >>>    	case METRICS_THROTTLER_STATUS:
> >>> -		*value = metrics->ThrottlerStatus;
> >>> +		*value = sienna_cichlid_get_throttler_status_locked(smu);
> >>>    		break;
> >>>    	case METRICS_CURR_FANSPEED:
> >>> -		*value = metrics->CurrFanSpeed;
> >>> +		GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
> >>> +		*value = *data_u16;
> >>>    		break;
> >>>    	default:
> >>>    		*value = UINT_MAX;
> >>> @@ -3564,68 +3613,103 @@ static ssize_t
> >> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >>>    	struct smu_table_context *smu_table = &smu->smu_table;
> >>>    	struct gpu_metrics_v1_3 *gpu_metrics =
> >>>    		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
> >>> -	SmuMetricsExternal_t metrics_external;
> >>> -	SmuMetrics_t *metrics =
> >>> -		&(metrics_external.SmuMetrics);
> >>> -	struct amdgpu_device *adev = smu->adev;
> >>> -	uint32_t smu_version;
> >>> +	uint32_t *data_u32;
> >>> +	uint16_t *data_u16;
> >>> +	uint8_t *data_u8;
> >>>    	int ret = 0;
> >>>
> >>> -	ret = smu_cmn_get_metrics_table(smu,
> >>> -					&metrics_external,
> >>> -					true);
> >>> -	if (ret)
> >>> +	mutex_lock(&smu->metrics_lock);
> >>> +
> >>> +	ret = smu_cmn_get_metrics_table_locked(smu,
> >>> +					       NULL,
> >>> +					       true);
> >>> +	if (ret) {
> >>> +		mutex_unlock(&smu->metrics_lock);
> >>>    		return ret;
> >>> +	}
> >>>
> >>>    	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
> >>>
> >>> -	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
> >>> -	gpu_metrics->temperature_hotspot = metrics-
> >>> TemperatureHotspot;
> >>> -	gpu_metrics->temperature_mem = metrics->TemperatureMem;
> >>> -	gpu_metrics->temperature_vrgfx = metrics->TemperatureVrGfx;
> >>> -	gpu_metrics->temperature_vrsoc = metrics->TemperatureVrSoc;
> >>> -	gpu_metrics->temperature_vrmem = metrics-
> >>> TemperatureVrMem0;
> >>> +	GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
> >>> +	gpu_metrics->temperature_edge = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
> >>> +	gpu_metrics->temperature_hotspot = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(TemperatureMem, &data_u16);
> >>> +	gpu_metrics->temperature_mem = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
> >>> +	gpu_metrics->temperature_vrgfx = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
> >>> +	gpu_metrics->temperature_vrsoc = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(TemperatureVrMem0, &data_u16);
> >>> +	gpu_metrics->temperature_vrmem = *data_u16;
> >>>
> >>> -	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
> >>> -	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
> >>> -	gpu_metrics->average_mm_activity = metrics-
> >>> VcnActivityPercentage;
> >>> +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> >>> +	gpu_metrics->average_gfx_activity = *data_u16;
> >>>
> >>> -	gpu_metrics->average_socket_power = metrics-
> >>> AverageSocketPower;
> >>> -	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
> >>> +	GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
> >>> +	gpu_metrics->average_umc_activity = *data_u16;
> >>>
> >>> -	if (metrics->AverageGfxActivity <=
> >> SMU_11_0_7_GFX_BUSY_THRESHOLD)
> >>> -		gpu_metrics->average_gfxclk_frequency = metrics-
> >>> AverageGfxclkFrequencyPostDs;
> >>> +	GET_METRICS_MEMBER(VcnActivityPercentage, &data_u16);
> >>> +	gpu_metrics->average_mm_activity = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
> >>> +	gpu_metrics->average_socket_power = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(EnergyAccumulator, &data_u32);
> >>> +	gpu_metrics->energy_accumulator = *data_u32;
> >>> +
> >>> +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> >>> +	if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> >>> +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs,
> >> &data_u16);
> >>>    	else
> >>> -		gpu_metrics->average_gfxclk_frequency = metrics-
> >>> AverageGfxclkFrequencyPreDs;
> >>> -	gpu_metrics->average_uclk_frequency = metrics-
> >>> AverageUclkFrequencyPostDs;
> >>> -	gpu_metrics->average_vclk0_frequency = metrics-
> >>> AverageVclk0Frequency;
> >>> -	gpu_metrics->average_dclk0_frequency = metrics-
> >>> AverageDclk0Frequency;
> >>> -	gpu_metrics->average_vclk1_frequency = metrics-
> >>> AverageVclk1Frequency;
> >>> -	gpu_metrics->average_dclk1_frequency = metrics-
> >>> AverageDclk1Frequency;
> >>> -
> >>> -	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
> >>> -	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
> >>> -	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
> >>> -	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
> >>> -	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
> >>> -	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
> >>> -	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
> >>> -
> >>> -	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
> >>> +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs,
> >> &data_u16);
> >>> +	gpu_metrics->average_gfxclk_frequency = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(AverageUclkFrequencyPostDs, &data_u16);
> >>> +	gpu_metrics->average_uclk_frequency = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(AverageVclk0Frequency, &data_u16);
> >>> +	gpu_metrics->average_vclk0_frequency = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(AverageDclk0Frequency, &data_u16);
> >>> +	gpu_metrics->average_dclk0_frequency = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(AverageVclk1Frequency, &data_u16);
> >>> +	gpu_metrics->average_vclk1_frequency = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(AverageDclk1Frequency, &data_u16);
> >>> +	gpu_metrics->average_dclk1_frequency = *data_u16;
> >>> +
> >>> +	GET_METRICS_MEMBER(CurrClock, &data_u32);
> >>> +	gpu_metrics->current_gfxclk = data_u32[PPCLK_GFXCLK];
> >>> +	gpu_metrics->current_socclk = data_u32[PPCLK_SOCCLK];
> >>> +	gpu_metrics->current_uclk = data_u32[PPCLK_UCLK];
> >>> +	gpu_metrics->current_vclk0 = data_u32[PPCLK_VCLK_0];
> >>> +	gpu_metrics->current_dclk0 = data_u32[PPCLK_DCLK_0];
> >>> +	gpu_metrics->current_vclk1 = data_u32[PPCLK_VCLK_1];
> >>> +	gpu_metrics->current_dclk1 = data_u32[PPCLK_DCLK_1];
> >>> +
> >>> +	gpu_metrics->throttle_status =
> >>> +			sienna_cichlid_get_throttler_status_locked(smu);
> >>>    	gpu_metrics->indep_throttle_status =
> >>> -			smu_cmn_get_indep_throttler_status(metrics-
> >>> ThrottlerStatus,
> >>> +			smu_cmn_get_indep_throttler_status(gpu_metrics-
> >>> throttle_status,
> >>>
> >> sienna_cichlid_throttler_map);
> >>>
> >>> -	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
> >>> +	GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
> >>> +	gpu_metrics->current_fan_speed = *data_u16;
> >>>
> >>> -	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
> >>> -	if (ret)
> >>> -		return ret;
> >>> +	if (((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && smu-
> >>> smc_fw_version > 0x003A1E00) ||
> >>> +	      ((smu->adev->asic_type == CHIP_NAVY_FLOUNDER) && smu-
> >>> smc_fw_version > 0x00410400)) {
> >>> +		GET_METRICS_MEMBER(PcieWidth, &data_u8);
> >>> +		gpu_metrics->pcie_link_width = *data_u8;
> >>>
> >>> -	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version >
> >> 0x003A1E00) ||
> >>> -	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version >
> >> 0x00410400)) {
> >>> -		gpu_metrics->pcie_link_width = metrics->PcieWidth;
> >>> -		gpu_metrics->pcie_link_speed = link_speed[metrics-
> >>> PcieRate];
> >>> +		GET_METRICS_MEMBER(PcieRate, &data_u8);
> >>> +		gpu_metrics->pcie_link_speed = link_speed[*data_u8];
> >>>    	} else {
> >>>    		gpu_metrics->pcie_link_width =
> >>>
> >> 	smu_v11_0_get_current_pcie_link_width(smu);
> >>> @@ -3633,6 +3717,8 @@ static ssize_t
> >> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >>>
> >> 	smu_v11_0_get_current_pcie_link_speed(smu);
> >>>    	}
> >>>
> >>> +	mutex_unlock(&smu->metrics_lock);
> >>> +
> >>>    	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
> >>>
> >>>    	*table = (void *)gpu_metrics;
> >>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

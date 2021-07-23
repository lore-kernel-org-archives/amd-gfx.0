Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFA2C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 07:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6422060E90
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 07:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6422060E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037D36FA49;
	Fri, 23 Jul 2021 07:21:03 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF4A6FA49
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 07:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6fXoWtG7iIuRWUashIOtMLuqZPMhCTLTGrWch4mc/2KLax9AWAbWf8IrhRh+9Et/tM7ceRZEl+ej0tmJ5tykvpBfe4seN+Ecr6s2fb4+M5oL6y6u9TihQtxFDO4PZRLZTLCU4lOIEX1odtpSU1GQ/7G5TxguALSXctkoOzgXttimPsui82nOP/YKn0co2bc/TUhjYMUVgH//On46nXbugPoyMXXxS1Itj5deHNVCX85mLLQi5kCodIeAaFEmrGIygobEwI497uORY7FwkysVgNmgbaQuKJBmamTJC+kBnR+Tlu1LoWREjy4E1XdRTf5h1nqTRwfhBGtcIgOsFl8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFbDJORTG7ICGKLByilVrxFpWpRZNuxsZDy5FnqItQA=;
 b=GN+S8JXInhbrv8eFJ42ZiLjMxGFbNDOuLCk1HfsfcKsG+A7YhuxM+ZEVzxSGnEUCeVwPgSOeNMGFt69xY8c9TLAABkQiupGYTPuTT7jQEWKOSvo3M+BA1qzPHr77oZ/PwxDYI8G/5BPAaydiuNHADsYtclV4o5rNcn9y8LzgouZ5pQhHlpymgHX1IVMETb2bmeWQ1lGHvAdly+iW+QMNxHBQZVpaLAoTBVsJZRz4mGctrS9DK+CFqOHoSfp+nIqONQP/4pnrBOhtm2tZv4snrM2xmxX/qE50P7RmpW7ynzPpXEK6qdEqEXVmpLHJs/0LNzlHxHlHqip7KN43MFlT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFbDJORTG7ICGKLByilVrxFpWpRZNuxsZDy5FnqItQA=;
 b=PcCTw5cc0hEI49pWTdFvgZ7jC1a7f19ZnSHcXubqD9wivPkSwsDHQMEWGGnjHtN1u213byhmkK22Lw4kBt8kUvQWYW42TXAst5ACazxr1WJEkf7G/NlBqVAaCboQ13r3f6yhSQyHecLSQMDcwKDTQ/vkB0oqgqMNjlEYRXdtTQc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.28; Fri, 23 Jul 2021 07:20:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4331.034; Fri, 23 Jul 2021
 07:20:56 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Topic: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Index: AQHXfqifeeLDV50fl0aVa8y8c1VYEatOpKWAgAADICCAAAvBAIABaXAQgAAKZaA=
Date: Fri, 23 Jul 2021 07:20:56 +0000
Message-ID: <DM6PR12MB2619A913DFA1F73B8FE32532E4E59@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210722032046.767094-1-evan.quan@amd.com>
 <b7ded1e9-08ae-212e-7fa4-2f797bbd228e@amd.com>
 <DM6PR12MB261987F64682AB6A0A337A30E4E49@DM6PR12MB2619.namprd12.prod.outlook.com>
 <47ba61d1-d76e-b10f-acb6-fa25bb4c4d44@amd.com>
 <DM6PR12MB2619A8E359A153660B23092EE4E59@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619A8E359A153660B23092EE4E59@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-23T07:20:53Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=12f0aa7a-45a4-4996-9001-1fe9ae08a9fd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86b7e2d0-04ad-4fcb-2b2e-08d94daa6a19
x-ms-traffictypediagnostic: DM6PR12MB4337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4337497BA50CC77F5D42F9C1E4E59@DM6PR12MB4337.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OCyQCwi8+76XMBLKbt+FDN5YWvXzqeYr+hUCFrawfyMcDiwZW6/rxUvN2WKX0Sfjx362H/47cwW1DzSATmwstQ5+2gjCf4+dCJbvoIvbxE5H4qGeLXbDKW6hLDp1OsA03WjdydHGejlEFypPlLFuSH1UbutmpE3613O5sDeCq8BHuIkM3SUG7yAd/RIScV4wMXf4bcmtzogs839HbtWcBq+27foNrLha7oOTNCsgk6RgX1r1OVUB9xR2EVvI7KJXaq4I/DRlF66uua0WDsFidR/asmPVqiSAQe7hDcRjVmpejL7laEJ0rKimMHt4mBj5pglySg9ULGVPz7MoPPfhXrQ0ay0bKcWF0Dr9h6P+JfvR+pzGMd2ZiNSwfgJoSBIAV/87bRqFS33rNNR1f5RFn9R2Z19PseQl0CB8yghq11zyyd3BSWFHEVpfWYyEh/f6cE2fZynCfUUbZujx+45txAbKyK2baAw4oX/mkl/JEJO5Veztv647SCB1bwkc2eOM6mWnfEaXYpYg6cMXlpt0U6bWO9SxnbNBmD+04UsnQBTeRGvkbq+BegUR7teuvKQTGJaHjELDzr9YoE1415VMPxPCLAFpFQ1tOrTjIB1WUwAjaNcpPAjb/lC0zQv2tDnBatejhwaHkDWNCyEw1OiFG35RX4pz6pDBKlHK6s55oMt/WblSWg8ZjS8I04HJxeYYcQvvzQ3tTChyndSAeKi+QW5K278X/1/mBiGzSdEpBjE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(30864003)(83380400001)(2906002)(66556008)(8676002)(66446008)(64756008)(8936002)(4326008)(186003)(5660300002)(316002)(33656002)(26005)(66574015)(52536014)(38100700002)(122000001)(66476007)(2940100002)(86362001)(110136005)(7696005)(71200400001)(478600001)(53546011)(9686003)(55016002)(76116006)(6506007)(66946007)(32563001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1ZidGhrNDRVZ0U1QUZaTkxDVkVqbXN0d0ROMG5BbUhKSExuamNGVnJ2Q3Fx?=
 =?utf-8?B?MU51bUtSL0ZraHBTeHRrcTdnK2pORlNuWENIUk14REF1eWlRVThmZzkxTmhu?=
 =?utf-8?B?WFloTndTVkVHUVoxS1R2a093dUhsZXNmcU5pdk9sVmc1d0d6UDJrc1ZkWTBu?=
 =?utf-8?B?WE8zQzR5SyswR2locnJ4UzBTNGpwc0M4L05lbHllb1pUNE1xTDJWOUhubUFu?=
 =?utf-8?B?clVXR3c3WEJRNTBaTnhPQ0dTWXVZczBlazZpaTFkZCtFSXprYjMrSFZGVWdC?=
 =?utf-8?B?RWRYQ1ppRytURmlVZVhnUWE2blptZkMxSG9SQWJhaGVpYlVlZUFVVm11dVJN?=
 =?utf-8?B?dFVvZ1ZrOFJKSnpKMTJtMXRaN3ZVcE5ZaFlUZzM0QjJoQ3dQRlRScnYwY0pI?=
 =?utf-8?B?UTlhSTF2aUw2SXAzWmRvd05VdFZwL2kwdWh6MW1KTTRTc1AzbFFJczhJZE0z?=
 =?utf-8?B?cWVkVzdSM3NzQ2ZTTGJwYktNMlZvaVVPQm1ZeXJhb0RiMmdISThxUWtuTnZ2?=
 =?utf-8?B?WWNIK1NxMUxZc0pPY3JZNVB0b3RwczBvSWhBUFYrYmY2YWF6c2FPNVBjL09l?=
 =?utf-8?B?ZXlqeFNvYVQrTzJyQlE1ckJYNXp1c1g2NUoreVhQSGlaNi8wUnk1TFFSTkh0?=
 =?utf-8?B?WXZhVXQwM0J3WFpxSFVCemtnK20vcHMySlo0d0p4a25LM1o1MkhzTlhSdHFO?=
 =?utf-8?B?ZHJoWDMwb2ZmSmNIZ055dCtXQ29XWGZkU24vMHlpbXZ3cm8xcVVoU1JEeTJR?=
 =?utf-8?B?aHZHVHkwZ0V0L0NVVy9aN0RWZERhY0pCOUU5Wk1CYnhMeWlhdHIybDJwR0JN?=
 =?utf-8?B?T3FQOXF2eWZSS1dRMC9iSU0rTW5tZWRGM2xvUHJwdjN6L3ZJQ3duODMrVDVl?=
 =?utf-8?B?dEc1ekVPcy93Z3FSM3FzZVNtdFR3NWJFbHZmWkJqbnJ0dzRoTEVhZEZwNEph?=
 =?utf-8?B?YkxtUGN2UHN6emUzL3hZSkFWZmk5Mm5rOTJsbm1LaW9vNUwvNmltclRsN0dp?=
 =?utf-8?B?VUJMZjJQKzZTbGZSZUFmUU9HSnB3SFk5ZDlIZDJ1VDBCSkM3NndhN0ZlcUM5?=
 =?utf-8?B?K1VJaDdQY29rS1FZaEVOdHlmVWhzdmFXNFBwZ3MxVU5iVW03WVZ5cjJqRGg4?=
 =?utf-8?B?bytyNzZnRFpFRW16Q3pEbTdKTStBa2tydDRmOGsva2l0NlN3YUQzUnB2ZUJN?=
 =?utf-8?B?T3ZwQzZ5Q0l3aXlBRUFqRHphdGQ1S2QrRlYwblcyb3JsNG1ITHhIRUhqY0kv?=
 =?utf-8?B?NEVCNmtXSGVmcWMwZGY2Z0xqa3QrYmxEQ05vQWRaNzZOd05pZmRNLzc5NkR0?=
 =?utf-8?B?bW9zSlA2emlPa2h4MjBWcWhtMnVZZXVnVFo0eitMMnRnUlc2dUZsNWE0anps?=
 =?utf-8?B?a1MyZ1JGUEp6YkF0R2xUeUVaZHRKaUdKZHd1cUtFbWdpR2czYnB0T0hqTTdh?=
 =?utf-8?B?eFBNTW5JN2JneGdFYm1IdjhyYkZQa2dEbVhsbVBlcEVMNG1wN2pQc21XcGJ1?=
 =?utf-8?B?dDlXMUo0djlSeFBpWTNXSnJRSTZ0QUdyL0RVNHcrc0VhUWJ4VElRTEFXQ0I1?=
 =?utf-8?B?bXNTajltcTArWU9PUnN2RHBuQTBJMVFJVGJNRkk3WFdkUnNySFpYN2V1TEVk?=
 =?utf-8?B?R3FtSC9UTGZpZDV5VnlhMzRmcUJBcXN5YWovQjE2MTVlVWNQV0NUZXI2VEU2?=
 =?utf-8?B?S0dpbWFzWXFWS1U1T1puaklRRHA1dFZ2WTF4VHRMR2VqTFhqYXJJZ3lRMnFR?=
 =?utf-8?Q?SzoC82lLO7xykNQx3y98T6DkpmIlEXR2WjsS4KL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b7e2d0-04ad-4fcb-2b2e-08d94daa6a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 07:20:56.8000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztHPD/XoHerpMnDBESITlaGopQsGoyIRHaLTSu03B15YPy6bTIxHX7a+oadKHv6+
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Lijo,

Sorry, I doubled checked. The implementation of Navi1x is right. 
The original design for "restores to default settings" is a two-step process.
That means for "case PP_OD_COMMIT_DPM_TABLE:" we must distinguish whether it's an usual customized od setting update or just restoring to defaults.
And my current implementation for that is as below. Any comments?

+               if (memcmp(table_context->overdrive_table, table_context->boot_overdrive_table,
+                       sizeof(OverDriveTable_t))) {
+                       smu->user_dpm_profile.committed_od = true;
+                       memcpy(table_context->committed_overdrive_table, table_context->overdrive_table,
+                                       sizeof(OverDriveTable_t));
+               } else {
+                       smu->user_dpm_profile.committed_od = false;
+               }

BR
Evan
> -----Original Message-----
> From: Quan, Evan
> Sent: Friday, July 23, 2021 2:48 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
> properly for NV1x
> 
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Thursday, July 22, 2021 5:03 PM
> > To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD
> > settings properly for NV1x
> >
> >
> >
> > On 7/22/2021 2:03 PM, Quan, Evan wrote:
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > >> -----Original Message-----
> > >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > >> Sent: Thursday, July 22, 2021 4:10 PM
> > >> To: Quan, Evan <Evan.Quan@amd.com>; amd-
> gfx@lists.freedesktop.org
> > >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > >> Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD
> > >> settings properly for NV1x
> > >>
> > >>
> > >>
> > >> On 7/22/2021 8:50 AM, Evan Quan wrote:
> > >>> The customized OD settings can be divided into two parts: those
> > >>> committed ones and non-committed ones.
> > >>>     - For those changes which had been fed to SMU before
> S3/S4/Runpm
> > >>>       suspend kicked, they are committed changes. They should be
> > properly
> > >>>       restored and fed to SMU on S3/S4/Runpm resume.
> > >>>     - For those non-committed changes, they are restored only
> > >>> without
> > >> feeding
> > >>>       to SMU.
> > >>>
> > >>> Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> > >>> Signed-off-by: Evan Quan <evan.quan@amd.com>
> > >>> ---
> > >>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
> > >>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++++
> > >>>    .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 52
> > >> ++++++++++++++-----
> > >>>    .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 12 +++++
> > >>>    4 files changed, 69 insertions(+), 12 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > >>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > >>> index 3e89852e4820..8ba53f16d2d9 100644
> > >>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > >>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > >>> @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
> > >>>    	uint32_t power_limit;
> > >>>    	uint32_t fan_speed_percent;
> > >>>    	uint32_t flags;
> > >>> +	uint32_t committed_od;
> > >>>
> > >>>    	/* user clock state information */
> > >>>    	uint32_t clk_mask[SMU_CLK_COUNT]; @@ -352,6 +353,7
> @@ struct
> > >>> smu_table_context
> > >>>
> > >>>    	void				*overdrive_table;
> > >>>    	void                            *boot_overdrive_table;
> > >>> +	void				*committed_overdrive_table;
> > >>
> > >> May be rename it to user_overdrive_table - OD table with user settings?
> > > [Quan, Evan] Actually "overdrive_table " is  the
> > > user_overdrive_table. It
> > contains all the modification including those not committed( the
> > commit is performed by echo "c" >
> /sys/class/drm/card1/device/pp_od_clk_voltage).
> > > The new member added refers to those user customized but committed
> > only settings. That's why it was named as " committed_overdrive_table".
> > Any good suggestion for the naming?
> >
> > As far as I understand, the problem is overdrive_table can have
> > intemediary settings as the edit/commit is a two-step process. At any
> > point we can have user_od_table keep the latest user mode settings.
> > That is true when user restores to default settings also; that time we
> > can just copy the boot settings back to user_od table and keep the
> > flag as false indicating that there is no custom settings.
> [Quan, Evan] For now, on Navi1x the "restores to default settings" is also a
> two-step process. That will make "copy the boot settings back to user_od
> table and keep the flag as false" tricky. However, it seems that does not fit
> original design. As per original design, the "restores to default settings"
> should be a one-step process. Let me correct them with new patch series
> and proceed further discussion then.
> 
> BR
> Evan
> >
> > >>
> > >>>    	uint32_t			gpu_metrics_table_size;
> > >>>    	void				*gpu_metrics_table;
> > >>> @@ -623,6 +625,12 @@ struct pptable_funcs {
> > >>>    				 enum
> PP_OD_DPM_TABLE_COMMAND
> > >> type,
> > >>>    				 long *input, uint32_t size);
> > >>>
> > >>> +	/**
> > >>> +	 * @restore_committed_od_settings: Restore the customized and
> > >> committed
> > >>> +	 *                                 OD settings on S3/S4/Runpm resume.
> > >>> +	 */
> > >>> +	int (*restore_committed_od_settings)(struct smu_context *smu);
> > >>> +
> > >>>    	/**
> > >>>    	 * @get_clock_by_type_with_latency: Get the speed and
> latency
> > >>> of
> > >> a clock
> > >>>    	 *                                  domain.
> > >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > >>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > >>> index ebe672142808..5f7d98e99f76 100644
> > >>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > >>> @@ -416,6 +416,15 @@ static void
> > smu_restore_dpm_user_profile(struct
> > >> smu_context *smu)
> > >>>    		}
> > >>>    	}
> > >>>
> > >>> +	/* Restore customized and committed OD settings */
> > >>> +	if (smu->user_dpm_profile.committed_od) {
> > >>> +		if (smu->ppt_funcs->restore_committed_od_settings) {
> > >>> +			ret = smu->ppt_funcs-
> > >>> restore_committed_od_settings(smu);
> > >>> +			if (ret)
> > >>> +				dev_err(smu->adev->dev, "Failed to upload
> > >> customized OD settings\n");
> > >>> +		}
> > >>> +	}
> > >>> +
> > >>
> > >> Just thinking if there is a need to handle it ASIC specific. The
> > >> flags and table pointer are maintained in common structure. So
> > >> can't we do the restore of user OD settings directly in this common
> > >> flow instead of having each ASIC to implement the callback?
> > > [Quan, Evan] The OD settings restoring is ASIC specific as it
> > > performed on
> > OD table and that(OD table) is ASIC specific.
> >
> > I was thinking in terms of final logic that is being done. The below
> > structures are available in common table context and we have a common
> > logic to update the table. If there is no custom OD settings
> > available, we could handle it with the flag.
> >
> > +	struct smu_table_context *table_context = &smu->smu_table;
> > +	void *od_table = table_context->committed_overdrive_table;
> > +	int ret = 0;
> > +
> > +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> > (void *)od_table, true);
> >
> > >>
> > >>>    	/* Disable restore flag */
> > >>>    	smu->user_dpm_profile.flags &=
> > >> ~SMU_DPM_USER_PROFILE_RESTORE;
> > >>>    }
> > >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > >>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > >>> index 59ea59acfb00..4752299d7f91 100644
> > >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > >>> @@ -2296,39 +2296,45 @@ static int
> > >> navi10_set_default_od_settings(struct smu_context *smu)
> > >>>    		(OverDriveTable_t *)smu-
> >smu_table.boot_overdrive_table;
> > >>>    	int ret = 0;
> > >>>
> > >>> -	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> > >> (void *)od_table, false);
> > >>> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> > >> (void
> > >>> +*)boot_od_table, false);
> > >>>    	if (ret) {
> > >>>    		dev_err(smu->adev->dev, "Failed to get overdrive
> table!\n");
> > >>>    		return ret;
> > >>>    	}
> > >>>
> > >>> -	if (!od_table->GfxclkVolt1) {
> > >>> +	if (!boot_od_table->GfxclkVolt1) {
> > >>>    		ret =
> navi10_overdrive_get_gfx_clk_base_voltage(smu,
> > >>> -								&od_table-
> > >>> GfxclkVolt1,
> > >>> -								od_table-
> > >>> GfxclkFreq1);
> > >>> +
> > >> 	&boot_od_table->GfxclkVolt1,
> > >>> +
> > >> 	boot_od_table->GfxclkFreq1);
> > >>>    		if (ret)
> > >>>    			return ret;
> > >>>    	}
> > >>>
> > >>> -	if (!od_table->GfxclkVolt2) {
> > >>> +	if (!boot_od_table->GfxclkVolt2) {
> > >>>    		ret =
> navi10_overdrive_get_gfx_clk_base_voltage(smu,
> > >>> -								&od_table-
> > >>> GfxclkVolt2,
> > >>> -								od_table-
> > >>> GfxclkFreq2);
> > >>> +
> > >> 	&boot_od_table->GfxclkVolt2,
> > >>> +
> > >> 	boot_od_table->GfxclkFreq2);
> > >>>    		if (ret)
> > >>>    			return ret;
> > >>>    	}
> > >>>
> > >>> -	if (!od_table->GfxclkVolt3) {
> > >>> +	if (!boot_od_table->GfxclkVolt3) {
> > >>>    		ret =
> navi10_overdrive_get_gfx_clk_base_voltage(smu,
> > >>> -								&od_table-
> > >>> GfxclkVolt3,
> > >>> -								od_table-
> > >>> GfxclkFreq3);
> > >>> +
> > >> 	&boot_od_table->GfxclkVolt3,
> > >>> +
> > >> 	boot_od_table->GfxclkFreq3);
> > >>>    		if (ret)
> > >>>    			return ret;
> > >>>    	}
> > >>>
> > >>> -	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
> > >>> +	navi10_dump_od_table(smu, boot_od_table);
> > >>>
> > >>> -	navi10_dump_od_table(smu, od_table);
> > >>> +	/*
> > >>> +	 * For S3/S4/Runpm, no need to install boot od table to
> > >> overdrive_table as
> > >>> +	 *   - either they already share the same OD settings on bootup
> > >>> +	 *   - or they have user customized OD settings
> > >>> +	 */
> > >>> +	if (!smu->adev->in_suspend)
> > >>> +		memcpy(od_table, boot_od_table,
> > >> sizeof(OverDriveTable_t));
> > >>>
> > >>>    	return 0;
> > >>>    }
> > >>> @@ -2435,6 +2441,14 @@ static int navi10_od_edit_dpm_table(struct
> > >> smu_context *smu, enum PP_OD_DPM_TABL
> > >>>    			dev_err(smu->adev->dev, "Failed to import
> > >> overdrive table!\n");
> > >>>    			return ret;
> > >>>    		}
> > >>> +		if (memcmp(table_context->overdrive_table, table_context-
> > >>> boot_overdrive_table,
> > >>> +			sizeof(OverDriveTable_t))) {
> > >>
> > >> Shouldn't this be - compare against the edited settings and last
> > >> committed settings, overdrive_table vs committed_overdrive_table?
> > >>
> > >> Basically, user_od_table can be initialized with boot_od settings
> > >> and the flag gives the indication that user_od table is being used or not.
> > >> Before updating, check if the edited table (overdrive_table) and
> > >> the current user_od table are different, then commit the new table.
> > > [Quan, Evan] Yes, I also considered that. But that cannot handle the
> > > case
> > below:
> > > 1 user made some customizations  -> 2 the customizations were
> > > committed -> 3 user restored to default(boot) OD settings(by "echo
> > > 'r'")
> > and committed Although there were some changes between 2 and 3,
> there
> > is actually no real customized changes compared to default(boot) OD
> settings.
> >
> > On restore to default, just copy the boot_table settings to user_od
> > and keep the flag as false. We are using user_od as the latest user
> > preferred settings and overdrive_table is only used for intermediate
> updates.
> >
> > The flag decides whether to restore or not, but at any point we can
> > refer the user_od table to look upon the latest preferred user
> > settings (default or custom).
> >
> > Thanks,
> > Lijo
> >
> > >>
> > >>> +			smu->user_dpm_profile.committed_od = true;
> > >>> +			memcpy(table_context-
> > >>> committed_overdrive_table, table_context->overdrive_table,
> > >>> +					sizeof(OverDriveTable_t));
> > >>> +		} else {
> > >>> +			smu->user_dpm_profile.committed_od = false;
> > >>> +		}
> > >>>    		break;
> > >>>    	case PP_OD_EDIT_VDDC_CURVE:
> > >>>    		if (!navi10_od_feature_is_supported(od_settings,
> > >>> SMU_11_0_ODCAP_GFXCLK_CURVE)) { @@ -2499,6 +2513,19 @@
> static
> > int
> > >> navi10_od_edit_dpm_table(struct smu_context *smu, enum
> > PP_OD_DPM_TABL
> > >>>    	return ret;
> > >>>    }
> > >>>
> > >>> +static int navi10_restore_committed_od_settings(struct
> > >>> +smu_context
> > >>> +*smu) {
> > >>> +	struct smu_table_context *table_context = &smu->smu_table;
> > >>> +	void *od_table = table_context->committed_overdrive_table;
> > >>> +	int ret = 0;
> > >>> +
> > >>> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> > >> (void *)od_table, true);
> > >>> +	if (ret)
> > >>> +		dev_err(smu->adev->dev, "Failed to import overdrive
> > >> table!\n");
> > >>> +
> > >>> +	return ret;
> > >>> +}
> > >>
> > >> As mentioned before, not sure if this is needed as callback. Even
> > >> if, this can be something common for smuv11, there is nothing ASIC
> > >> specific in this logic, right?
> > > [Quan, Evan] Yes, in patch2 of the series, it was made as a SMUV11
> > common API.
> > >
> > > BR
> > > Evan
> > >>
> > >> Thanks,
> > >> Lijo
> > >>
> > >>>    static int navi10_run_btc(struct smu_context *smu)
> > >>>    {
> > >>>    	int ret = 0;
> > >>> @@ -3262,6 +3289,7 @@ static const struct pptable_funcs
> > >> navi10_ppt_funcs = {
> > >>>    	.set_soft_freq_limited_range =
> > >> smu_v11_0_set_soft_freq_limited_range,
> > >>>    	.set_default_od_settings = navi10_set_default_od_settings,
> > >>>    	.od_edit_dpm_table = navi10_od_edit_dpm_table,
> > >>> +	.restore_committed_od_settings =
> > >>> +navi10_restore_committed_od_settings,
> > >>>    	.run_btc = navi10_run_btc,
> > >>>    	.set_power_source = smu_v11_0_set_power_source,
> > >>>    	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
> diff --git
> > >>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > >>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > >>> index 0a5d46ac9ccd..28fc3f17c1b1 100644
> > >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > >>> @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct
> > >> smu_context *smu)
> > >>>    			ret = -ENOMEM;
> > >>>    			goto err3_out;
> > >>>    		}
> > >>> +
> > >>> +		smu_table->committed_overdrive_table =
> > >>> +			kzalloc(tables[SMU_TABLE_OVERDRIVE].size,
> > >> GFP_KERNEL);
> > >>> +		if (!smu_table->committed_overdrive_table) {
> > >>> +			ret = -ENOMEM;
> > >>> +			goto err4_out;
> > >>> +		}
> > >>> +
> > >>>    	}
> > >>>
> > >>>    	return 0;
> > >>>
> > >>> +err4_out:
> > >>> +	kfree(smu_table->boot_overdrive_table);
> > >>>    err3_out:
> > >>>    	kfree(smu_table->overdrive_table);
> > >>>    err2_out:
> > >>> @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct
> > >> smu_context *smu)
> > >>>    	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> > >>>
> > >>>    	kfree(smu_table->gpu_metrics_table);
> > >>> +	kfree(smu_table->committed_overdrive_table);
> > >>>    	kfree(smu_table->boot_overdrive_table);
> > >>>    	kfree(smu_table->overdrive_table);
> > >>>    	kfree(smu_table->max_sustainable_clocks);
> > >>>    	kfree(smu_table->driver_pptable);
> > >>>    	kfree(smu_table->clocks_table);
> > >>>    	smu_table->gpu_metrics_table = NULL;
> > >>> +	smu_table->committed_overdrive_table = NULL;
> > >>>    	smu_table->boot_overdrive_table = NULL;
> > >>>    	smu_table->overdrive_table = NULL;
> > >>>    	smu_table->max_sustainable_clocks = NULL;
> > >>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

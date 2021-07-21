Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF89C07E9B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03376109F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03376109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866206E83E;
	Wed, 21 Jul 2021 03:38:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859316E83E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 03:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSTYPvKUYMbmf7jn+wU4gdgl3tTrP/7R/yVhq0y84Jt0jiToALXpT+c/tDJUaSrbuvF/1jDaMo7lgUyh9gDWjp3acy5tTzwa2UaWigKLGb1D/t7blEIHKtoKp7CI43eBzoIka6LBpc5cHjOuNOaNKmzChB19v1fV5i+E6kAbE1jQ/gfTR1VkRmgtYynE0+ueWP7YpVXJXuuVXlAiL6vUXB1hxKrqDOisOnY/jhwYugNenpwuZvPCDRGIwcZNm5F+FMQw2e+lbgLBKfT/fTpsox7AyFdWOVE2YPLBpt2HNVaxMlJpSAOCwBP0+jZmOWRS3ud58OBEhA9qRmVnJTl3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7jL3HGiL/QsMhR0Ei9qRxEsoWR/TzkY/ZjtpozGtsc=;
 b=MQc1F4RwbI4aTu009DuurpHVI71AY8bePXiSXl6X+rH8bz8Ji0kKcbuaw8o6Eo/ks6lFj33GzTn9Tey5BDEhJcbZBwerbCuHTowPpX4LP2MV8K+90f4B4aIvbAJEdN1dY+ZBMDYC6qpDFkwWL0Y63glA6BYci8lKHXrNL8+gWUZCqJaolIvfE6Ng2HIayQNqyw6S1CsRi32bIj2FjeDzT3BlWNKCf9eWvOmwrfVSWztfs3lEfiF2aRmaWX4xOjs6s2ZloP45/mXcIlJiAL3Dx4N4NAEnpg9g+tsmri4aKmmyUzL2cPi9T5n8y4nUd64uVmrldVdCZsl4nlU/oiTzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7jL3HGiL/QsMhR0Ei9qRxEsoWR/TzkY/ZjtpozGtsc=;
 b=0gfu7Js/+xSrZ1iz+XCrnopvH3Q5VOKyS8KPk7JqojnW8k67VSqPkjt7rmUbiiquuBM3Aqiq4T3CWmDTd7iwChCTqTpcrr2ec+gdEpgJbXKtCDsjuUuCMU9UW1FBLBUxrbtwooRYyUqTMf8r+eypAe0lscdx7lbpqcisK7IcYjM=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 03:38:18 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::a1a7:610:55c6:fca9]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::a1a7:610:55c6:fca9%7]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 03:38:18 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: Add information about SMU11 firmware
 version
Thread-Topic: [PATCH 1/2] drm/amd/pm: Add information about SMU11 firmware
 version
Thread-Index: AQHXfYL5I301kMVnxkusPD2sGopvv6tMuRiAgAAJEYCAAARFIA==
Date: Wed, 21 Jul 2021 03:38:18 +0000
Message-ID: <BYAPR12MB32387A0A705C19D83EF1082BFBE39@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210720161808.18690-1-mario.limonciello@amd.com>
 <BYAPR12MB323804F0C5D873A19E7BC36CFBE39@BYAPR12MB3238.namprd12.prod.outlook.com>
 <dc659492-3fe0-29f5-0153-8fcff7af3774@amd.com>
In-Reply-To: <dc659492-3fe0-29f5-0153-8fcff7af3774@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1062e922-ed6d-451f-829e-a6d530dc4833;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-21T03:36:36Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e39f0343-4ad8-432b-321b-08d94bf8fb1e
x-ms-traffictypediagnostic: BY5PR12MB4308:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB43088A4C67C7E02B0F4F1261FBE39@BY5PR12MB4308.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dGPmACSXMmUfVzJWAK9eVOH+T0Dlzv+ElYdYvUULvHUqwkbgOT+1ErHWtA3Cw/MahvKN/17IqnfHYOmPlGP1GcQJozpwEWc+h7nZeq9shiw4DTTu8CLTmCDhfCotSWvpGXWxCHWytNc8soGBC57HScZ6LrmF+ErV7ICf1qBdfydEkhJ0AB3U3I7fHMHTw3SZDHQVRMcBlGnFMJcoeuFK6hX9cePEo43cicKb+l9reAFuhBswKhxRjDYpG5tH2WwnAIIWGaqTrsYZ6Z4uKICb/cTfCc842cZMTeus5k6WGDM14eTX3fq6dchm3EOwACGGnEPeYt3IP/3RxQW9o0lO66LfcyYtiL/AqTEwoJYLxyxFItmFwv576jcCpBuVKh7T0G1qmyg0p7nUupl/nL7ZarAzdBY2UYa9JdiD08RT8886KDlP+pAKV2XfqEv9G8oik1vZ2vwfNV4exkgUoOwuoh3QfIWPPlxhpvH9m4FIXS4qkGpsElTEbLv3/JV34JqjoSvR3qCj/wWdXCEGoJMsILEZiW1SPRWw+evJlrXjE7mQcGxzj/f7gjDqmfY74ApWpI6xbphWnIC2XDn43NM5ECYYHwqCauQD9rtsxDRTFLUF4yLAcg9VJJGcMevr2A4mDgL0Fyp3b+eU5RHYf5DCSIB4Tml7wEygUhd4vh0yNBTK53uKPX8obTREJq2ry30jZmM7f3Y/ufgEzzxszfR+XhynzjRgwfX1HFDoA0NNH2F9oqUCTdj8YOSe8aIvB+KfGjZXVsmEOsD8nD3VuVUb6gCqK4NkTNGlYEC8f/nORgU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(2906002)(33656002)(316002)(966005)(53546011)(8936002)(26005)(83380400001)(5660300002)(9686003)(186003)(110136005)(86362001)(8676002)(66556008)(66446008)(76116006)(66946007)(66476007)(64756008)(38100700002)(55016002)(122000001)(52536014)(7696005)(6506007)(71200400001)(478600001)(45080400002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTNENmtTZ0NEcUdsd29PeE94N243QVhCRVZ6SFlPQ1B0b2Z0bDJDaTE1WXpO?=
 =?utf-8?B?QXJ0cG5JdFBId1RnWU54K0dkemZhNG1tdEJKSGxpUTVncXd1c2QrZzNLK1Ju?=
 =?utf-8?B?eDg3bFgxYTYyUE1oSEhVamsvTVJ5bUc3dWViN0V3cnNnbUdCYkJmRVVhY0dt?=
 =?utf-8?B?V255ZFNJWTcxS2J1bTRJMk5HSC9seTU5WkNhMEY4U1RkZ0htcGprbE5SZmxB?=
 =?utf-8?B?QUplajFsRHNpNk1yRVNhc09KdW1BZnE2cGc2ODhaOGxWREpFSnFDblhOSFAr?=
 =?utf-8?B?R1hhZnA5cDRKbDNsai9mQTZiRkhnMVRaSHlqQXVRQTJmdDRpMFpFNVBVT2pO?=
 =?utf-8?B?cnNwSHRjWkNZWGpNdkhnVFZxd3BndjJ6ajJZdS9yNWNSM2ZJYkE1TVFsZG5R?=
 =?utf-8?B?eXNGcmRJeDZmcHVxUWZnN2EzYkFXQkVwSW84TUxKc2pQeFk2dlQ3NUpKUlVx?=
 =?utf-8?B?SVN2Y0ZTSzVnVEZuRU42cHdZbko0YWpPS3RUZzhvcVNFLzZKZzZSa1J6QmVq?=
 =?utf-8?B?VGpwLzQ0NDY2eE80RHFQNWVzNWRJaDA5S2lmUkplUElEM2NRSVpSTmJXRkN1?=
 =?utf-8?B?WnVaQTEySDg1ZXJOaXlSdUVaeEFjNU1sZ2FDMHoxejZURk9iVTQ4elErcnI4?=
 =?utf-8?B?UDVpUEs5NzdDSE45dCtlVGk3bmR0NVB1QzZHZTFKNi9uc0FadjRhdS84ZE5u?=
 =?utf-8?B?YnozeWRMRGhIRmR6WEUxWGNZTzhZbTRaVitJNXFjQTlYM05qTHozZnEzejJN?=
 =?utf-8?B?V2lJME9uVmRRTElXQ0pyUzlSa09ZKysvUkFnTUNPUkd1MVVPT3Z4dmVLVVFT?=
 =?utf-8?B?c2k5QkY5SEFWOUQ1RmV2OU51QlNsQ0orVG1QWGRPNEJHSkhQNVV6SjQ5eUJ6?=
 =?utf-8?B?NFlrQUtraWtJVWJmOWNRc2hLMzZqbHZ5Yzh0bUNRYWRteTMzYzJ5Sm53QzNN?=
 =?utf-8?B?YXdpRHMxRVpwWDRKZCs5cTIzWDdTanc1cWtEVGNIT2hObXNtc0lHZkNMRmdT?=
 =?utf-8?B?b2VNSGpZNlg3ejFwQzhrbWMzNUJwdlVpS2J1dWVWZ0w5OVlFL2h5M1pYWTZJ?=
 =?utf-8?B?a0V5NUplYmZtUUxUY0s4ZHNocVhEZWkzeVc3T0hhT1d0V1MyZUpZMzN2NG1H?=
 =?utf-8?B?SWpDOXZrYmVnSFNjeHQzczQ4blFvbmd4R2JwR1RNd3BteWZvTU54czM3ZkEw?=
 =?utf-8?B?SXhRN05KazhmbVFrM0lGOG5zYVpVZ0lqQlBIb25ZTDE3VVFPR1BkT29IcnRQ?=
 =?utf-8?B?bGM0aEMxdy9CQnRNNTlxLzNZQmtZZU1BRkJnWFVCZmZ0NnlTaFYzT1Frc01l?=
 =?utf-8?B?bmc4VEoxZnZPMWdGVzloU0tEcnlHNEFxa1UrMGNybjBFY2kwdTNjbktjelgz?=
 =?utf-8?B?bDk0eStFWGQ0YWpScUMyYnFzU0RkeWg4WjhkZjlhejVFK0pwZGMrR1pJODJI?=
 =?utf-8?B?NWpVTlpaOFQ4cTRaTHlPYXNKWGd0M21JMTNWdko5N2ZxdFhudzN1L2h0clBy?=
 =?utf-8?B?SWpsR2tjUmp1aEhobEh6MGtFUlA2THp1UWVESFV2ek12VDVZL3VGNlZqNlFz?=
 =?utf-8?B?RFlIQ2Z5UFkzSm1vdGk0cmNUbS9RVzMzRk54cmhTR3JjamowVmd2ZHlsdTlz?=
 =?utf-8?B?bm1kV1V3WmJsMHQvcUpQWHJCMk5VQ0lyZVRpbzNHYWJ3WmZZOWRmZGNPMU8v?=
 =?utf-8?B?Nm9jYnQ3bDFMY0xHeFlJQ1M1VVVCU1hrRzhuZGtRUG1YbVp5SEE3R3ZRQkVu?=
 =?utf-8?Q?NFsfBo48ZjawsNGhQ6YNUc0ZTA+8ouA7yu7cvMc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39f0343-4ad8-432b-321b-08d94bf8fb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 03:38:18.5639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0YhW35dRCCzELZ2bCOGlMHAjzYpN4PXHTDZRjQonbBR02HeDNtE47TaKC9YXXDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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

[Public]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, July 21, 2021 11:15 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/2] drm/amd/pm: Add information about SMU11
> firmware version
>
> On 7/20/2021 22:07, Liang, Prike wrote:
> > [Public]
> >
> > In the SMU issue troubleshooting process we also can check the SMU
> > version by reading MP1 scratch register and  from long term we may
> > need put the SMC version collection in the debug sysfs
> > amdgpu_firmware_info
> >
> > In this patch fashion, we better use dev_dbg instead of dev_info for only
> debug purpose.
>
> Actually SMUv13 files have it at info level, which is why it was modeled this
> way.  Perhaps v13 should also decrease this to debug then.
>
[Prike] OK, that seems not great deal for setting print level here. Besides, now base on you patch we may also need clean up the SMU version in the header mismatch print info and just throw out the warning message like as following.

if (if_version != smu->smc_driver_if_version) {
                dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
        }

> >
> >> -----Original Message-----
> >> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> >> Mario Limonciello
> >> Sent: Wednesday, July 21, 2021 12:18 AM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> >> Subject: [PATCH 1/2] drm/amd/pm: Add information about SMU11
> firmware
> >> version
> >>
> >> This information is useful for root causing issues with S0ix.
> >>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> >> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> >> index 0a5d46ac9ccd..626d7c2bdf66 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> >> @@ -272,6 +272,9 @@ int smu_v11_0_check_fw_version(struct
> smu_context
> >> *smu)
> >>                break;
> >>        }
> >>
> >> +     dev_info(smu->adev->dev, "smu fw reported version = 0x%08x
> >> (%d.%d.%d)\n",
> >> +                      smu_version, smu_major, smu_minor, smu_debug);
> >> +
> >>        /*
> >>         * 1. if_version mismatch is not critical as our fw is designed
> >>         * to be backward compatible.
> >> --
> >> 2.25.1
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
> >> ts.f
> >> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >>
> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C62180964b7d24208
> >>
> b59908d94b99f971%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> >>
> 637623947521949203%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> >>
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdat
> >>
> a=ACcymqjRA5e1wmQmBCPW5cwsM1tF5QXOXQRukuAgkeg%3D&amp;reser
> >> ved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B9AC4743F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 07:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B7A61285
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 07:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B7A61285
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815726E288;
	Mon,  7 Jun 2021 07:10:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BAAF6E288
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 07:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvG0pwyvhUaqeNcW+muHGfYy2X87eHhA/1SvgCdrKhou8d6nKNJL2GEULBOG9gyqyEWjFeIEL7PoP9E1mbh03Pdcupdy/QNK79mI/yC/IhxEo1cBxAokv8nBvlT7YUJ9f4L9hFSkJHRwJ/I+L00XnGTKXJokOk780+y4RJeyfEa7VnpHmyInVavdGtfj6d6hSDXJueO1Fim713Aij1TZTNOx3TAT8NM5PcvGftQael1zCX6AvSo36WACkfMAvAYK2MwTiPkspiqbbv5jqR2WGYz+LtJxvxIdwInELy3RA6GR4QVLUUmnRU+eRipkShgUDm1zAb3KTtmOpr6ZtSr4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eDWgXAoGnmiK+CCk1YMmGOgVranMli3eIx0Gpvk3Hw=;
 b=VNuSVjdoKJawteCgNwph8S3x2GNR1g7tZdGCQyoykANs84ruOJswRoDgcuggO87I8UiGvF/UuMR5JvyKO3F7wsxKYq538MA4bPk35/treKcquNyCBNBMCKzwPXCgeQoES7pr6W7LgJMqi2wU216OzRLvEBMkGx48O4T/F7gM9qNlMXP4Wf8KBKayJda7t8yEhOkMRV1P3C15vTI1CYNQ0qsOM1C2QZx71hPCKgTeb7pLVqMcpZX7D3uXwctgXPP2TPSaazmAUI08dPSvoLfcu3hW4CMDoyUeanZY1xFfGGkOxV6MZRhBW4jZpb/5Hf39hm+lnArZemC4r+sdO/MueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eDWgXAoGnmiK+CCk1YMmGOgVranMli3eIx0Gpvk3Hw=;
 b=BIidQQX5PFcSNWyJjDYL+jFILIGvutPtp46dw3MIXpIVOvNE+5+q9qhpVO4/Gpzmw/eB4pLL2F13ghy268fQ3xst1zgXrT7TcurgsPtn5uTBur/SoEwZuGUOROPcQogmaVu4GVWdTPfewmEsbhlTvsgU680s9O9K7hxiD1uppPQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.27; Mon, 7 Jun 2021 07:09:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 07:09:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial
 Dstate
Thread-Topic: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial
 Dstate
Thread-Index: AQHXWShI2cmU50EErkCn+1pTBWP5HasDxpMAgARYN2A=
Date: Mon, 7 Jun 2021 07:09:58 +0000
Message-ID: <DM6PR12MB26192ED08114610E8BDAC953E4389@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210604095823.1403271-1-evan.quan@amd.com>
 <20210604095823.1403271-3-evan.quan@amd.com>
 <b55d9c52-cadf-fbb3-1ed0-8b99dc972b6c@amd.com>
In-Reply-To: <b55d9c52-cadf-fbb3-1ed0-8b99dc972b6c@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-07T07:09:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2f68b287-531e-4357-9b1a-ba75e10c90ea;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94363917-d9f9-4a7a-8be5-08d929834291
x-ms-traffictypediagnostic: DM5PR12MB2357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB235703DEDEB0E07F644B24E2E4389@DM5PR12MB2357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNiIuKuLN51Xn9c+Qob7e4HvwGNc+lVaQcs+jjdB/v4As7WXpldbip4Nc/XDhVyS9fHIn38E6Fwilu2/3jJAtQ2OGJXB00hZrF2CxKY0kmArjBumPYCKF+DZlpkBPcfBibf0tRsrqvSYbSbOCb9iq4r20h3EOWwTGC82qEsDENc1Lqsr/HS9v5WB+S6dZ89WHB2PlqM7/eEmx7v2GecspOVFi1GHx7M4ab5PVGY2RkwLCj0KRMbniTtP8Q6tC4+NUwoYx7LK7dxANEhwc/9/KIocv5SCwaMY5HA2c0cyJmWUWwC/JiqcopJN19m+1Cneqog87AZHmxwuP5EVcrJwXYkZmZm55o/o29OpSKH4/6WGHhc6D955OlsVbHJbSaTkGBoXtVYq0odFmrwJrR30YKdfW0NCRFfB9Wz3Ky13bopcZ0ZUCZCShlfakRtO3XV0JjffNjOhFQGgJjGjqeCgv9N3lriczqNryr5HuT0osnoG6xjAOw2OVu+V1ntq7nTksBj0+dq4E5e8B2ZFjJ2iqDKac/bsj0771XzhFbOaKIE5Zk2TErsHLvFFFumLD4zOd1Qd1U/KyBC83HIhYpfI8NPA9yWdUCHPtoJDWV63hCQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(52536014)(186003)(9686003)(110136005)(33656002)(316002)(8676002)(8936002)(53546011)(26005)(6506007)(55016002)(7696005)(86362001)(2906002)(83380400001)(38100700002)(5660300002)(71200400001)(76116006)(122000001)(66946007)(66476007)(66446008)(478600001)(66556008)(64756008)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?TXdSYmZSTjJWdUlTZHQ5RlVrWWVNU2R3dldWMVRjK0RLSUdCenVDWlJ4Vm9U?=
 =?utf-8?B?MlZ4N01lWGVOT1psZXFNTHFVZnJrR1Q3OVhjMElHZHNuSUZhNGRnMkhXMzUy?=
 =?utf-8?B?VU5XdnlKaGFxalBwYnJWeGdXS0JBN0dUbEtoZFh6WlcwRnZsYlNINnU1ZVBY?=
 =?utf-8?B?MTRuOS9UR1pNb3pyRlM2dTJUcGJ0bHFINFlLR3ExQzdSRFhzSnhoL3VyMGtC?=
 =?utf-8?B?M2d2bFA2N3p3YXBaSUpKU3hKekRwOCtQMGhSL3cyK3RPSlgrWFp4K0piQ3l0?=
 =?utf-8?B?UjRUYXNET0tJRVFzL2ttcDg0dlZucWl1WTZ2S0NvTTBIWnJEeUJjSUNXdGR3?=
 =?utf-8?B?ZnUvdFVYdVc4UHFiTjkvdGlNSmVBWmlkNEp6L3hlTWNDQnR1UUIyaWhKeDE2?=
 =?utf-8?B?R1VoMEI5c244dDA0K3g0UzVjWUtDZjl4MTdkSC9JRUltUU1LakNKaGVkbzBr?=
 =?utf-8?B?VTNkSERCS3orQXpKNVlLYlpwUzZtRjhhWkdHbkxzTEhVbEl4bHZmbDlac1FW?=
 =?utf-8?B?KzFXUzV4VUxEbE1BakNZYW1nTnZxMUxkUVpUR2NCZ2FhSStnNnRKa21mb3VJ?=
 =?utf-8?B?NXJ6Ni9BR1J6VDNxSFFVSXVvMGZaOG0zeGNwbEI2NW45MC84b1E5TTgydnhO?=
 =?utf-8?B?NHlCUVh1NHpRRmtwcUNheFhiMHFobnZ3QlBYdnZyWUFXUGNsZ1MzR2dNbkhj?=
 =?utf-8?B?YU1wN3IxcnZWVFM2d0tRK0V4SnFJcVQxZFRQbndDeHE2MjdBc1FrdW9Va3hM?=
 =?utf-8?B?YUZYaHNyL2NCMVVGREljLzdDNXF1ZkxvdndhSnFwbStsOHNtZk5xdnY3bWhr?=
 =?utf-8?B?em80VWhtM0R0RnFDRC9MT3VnY3IweWI4NXkyMEZtSmJ2K2h6S1diemV5Vkt2?=
 =?utf-8?B?ZlJoWkc0SDVlQWtBVzlvbS9LVDVBVFdYUGFyNWdHWFIwOWtWY2VzNGc1NGow?=
 =?utf-8?B?NjlCbUczVlZlQzZuMnRqRlc5bWRFT2hDNWI3WEF0RkFud04rM2dZZ2V2LzAy?=
 =?utf-8?B?bUIvMlFsZ1M2MmRhcTR5L21QRU84MWc1RWZWOHMxWGYzVHVoMExZY3cya1k0?=
 =?utf-8?B?V1EwS0lEVjBLSDkwTi9idWJuUnBjYWxqNnNtcHFRbXIzUXhrVm1IUUl0ajU1?=
 =?utf-8?B?QVFpYiszZ2hEMDdSUDZrTG85NlZhRDdXaElMRVVJUEY0S2p6d2xoRmVjbnhX?=
 =?utf-8?B?ajJtRUYxVGVHT09HTVN5dW56ZHNnL0k2NTVlNy9VSUFEbDJyVHREVkhBQ0dR?=
 =?utf-8?B?MHFXTUV0aWx5bUpLWllHbW9WOTVVYTJlSjZtdkMzQ2NLMlVJSEMvUmtVOUl3?=
 =?utf-8?B?cTZORUVTamtrNTY2ZmhSRXgrK0JtZnFUaWRVYTUwZFJSbk9CUWt1dFFvNTBi?=
 =?utf-8?B?NjM4dmtNMEIxenFXYmhRZHVieEw4clRiK1hPUjViTmRRODN5aURoNTVISERH?=
 =?utf-8?B?ZVFvN3h5SmNVZU9RRUxyU2JFd1FZRmFkQU05OHlCYXFqdEhhWkxEeUxnci9B?=
 =?utf-8?B?QXRNRjFaU2grWWJHWlJHWlBwQnFidzIyaVJXdVdXaUFXT3YzSWZQOU5Cci9B?=
 =?utf-8?B?WlRLbUh3dnd1bHd1ZlBSYzBTZmU2d2wzYUhJdUdYbnB3SlB3ZGoyUnYrUENE?=
 =?utf-8?B?RWp4Y1NDZTVPckhrNTZUdTdjZ0JGajVxTHo1VWFhUC9TcU1RcG90R3Z4WFBO?=
 =?utf-8?B?Y2VJbjRGQ3JYQUR6anRYNzIrazJIbWQ0eVRIV2V6OTA3Y1luOGpsNlJ4VnZ0?=
 =?utf-8?Q?kuPFVziCvZMYWQtKrvC4F65SBTryelmvCgROqxJ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94363917-d9f9-4a7a-8be5-08d929834291
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 07:09:58.3205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThTASfX8DX6BsptXnX0YQygOnJoGtcqCHatVuG8fF9egpCr01y8oMCxp7DaPf2+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
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
> Sent: Friday, June 4, 2021 8:24 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial
> Dstate
> 
> 
> 
> On 6/4/2021 3:28 PM, Evan Quan wrote:
> > On driver loading, the ASIC is in D0 state. The bundled audio function
> > should be in the same state also.
> >
> > Change-Id: I136e196be7633e95883a7f6c33963f7583e9bad1
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> > V1->V2:
> >    - Lijo: include the code in a seperate API for better readability
> >    - limit the change for Navi10 and later dGPUs
> >    - comments more about the background
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 40
> +++++++++++++++++++++++++
> >   1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index c354ffa62483..e9f2161738d1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -123,6 +123,22 @@ void amdgpu_register_gpu_instance(struct
> amdgpu_device *adev)
> >   	mutex_unlock(&mgpu_info.mutex);
> >   }
> >
> > +static void amdgpu_get_audio_func(struct amdgpu_device *adev) {
> > +	struct pci_dev *p = NULL;
> > +
> > +	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev-
> >bus),
> > +			adev->pdev->bus->number, 1);
> > +	if (p) {
> > +		pm_runtime_get_sync(&p->dev);
> > +
> > +		pm_runtime_mark_last_busy(&p->dev);
> > +		pm_runtime_put_autosuspend(&p->dev);
> > +
> > +		pci_dev_put(p);
> > +	}
> > +}
> > +
> >   /**
> >    * amdgpu_driver_load_kms - Main load function for KMS.
> >    *
> > @@ -212,9 +228,33 @@ int amdgpu_driver_load_kms(struct
> amdgpu_device *adev, unsigned long flags)
> >
> 	DPM_FLAG_MAY_SKIP_RESUME);
> >   		pm_runtime_use_autosuspend(dev->dev);
> >   		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
> > +
> >   		pm_runtime_allow(dev->dev);
> > +
> >   		pm_runtime_mark_last_busy(dev->dev);
> >   		pm_runtime_put_autosuspend(dev->dev);
> > +
> > +		/*
> > +		 * For runpm implemented via BACO, PMFW will handle the
> > +		 * timing for BACO in and out:
> > +		 *   - put ASIC into BACO state only when both video and
> > +		 *     audio functions are in D3 state.
> > +		 *   - pull ASIC out of BACO state when either video or
> > +		 *     audio function is in D0 state.
> > +		 * Also, at startup, PMFW assumes both functions are in
> > +		 * D0 state.
> > +		 *
> > +		 * So if snd driver was loaded prior to amdgpu driver
> > +		 * and audio function was put into D3 state behind PMFW's
> > +		 * back, the BACO may not correctly kicks in and out.
> > +		 *
> > +		 * Via amdgpu_get_audio_func() below, the audio function
> > +		 * is guarded to be in D0 correctly.
> > +		 */
> 
> On a second look at the comments - should runpm _get on audio dev be
> done before doing device_init (so that it's in D0 while FW is getting
> loaded) and put done here?
[Quan, Evan] It does not matter as long as all those are performed before  .runtime_suspend() kicks.
The issue around here is : if the audio dev is already in D3 state before PMFW alive, during .runtime_suspend there will be no Dstate transfer(D0->D3). Thus no interrupt will go to PMFW and PMFW will be not aware of the audio dev D3 state. With the proper audio dev D3 state, the baco state will never kick in.
Via the amdgpu_get_audio_func(), the audio dev is put into D0 state. Then on the succeeding .runtime_suspend(), there will be Dstate transfer(D0->D3) and thus interrupt for PMFW.

BR
Evan
> 
> Thanks,
> Lijo
> 
> > +		if (amdgpu_device_supports_baco(dev) &&
> > +		    !(adev->flags & AMD_IS_APU) &&
> > +		    (adev->asic_type >= CHIP_NAVI10))
> > +			amdgpu_get_audio_func(adev);
> >   	}
> >
> >   	if (amdgpu_acpi_smart_shift_update(dev,
> AMDGPU_SS_DRV_LOAD))
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71690C4708F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 04:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C22E61406
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 04:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C22E61406
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 715086E044;
	Fri,  4 Jun 2021 04:22:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6CA96E044
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 04:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4/a/v7+XQkkn/u9fq1dtljHI6Mbw4D8W0wmDRm6EeR/zNV0Fv1gs0+fDkhbF1Fxgpsgo8MXZujfyeM8NECQdxdMDNuBXKAFLSbh0HuXo09+Yhkgaa6sjgO18MhjKjIwkB4NeQlhSrIQ9SYCD4HsqN1lvncsF6XD2i/TdRw95Oc9S3XJhO+qUltCJCAOsKOrh3bMJ8LG5piOykp3SffBzEYrkzyUdyFWaVjOxqTwwjXGERfjOilHZzV7gQ5L5Iz7vLWWlVllNKk7/bSgG1KSReWk5JFksxOo+Qvg8seiGuTVoLVo3lVt2bmjyNJh2YFoM0YNi6+javkFSF8YhVYhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3va+k7LrJm/yyqiOXFvq5kPIqc3TNfEyRSbXIcswco=;
 b=nNFxiBNS1aaFR5PXwZIJNhJKBK1nySHUeXqVZKfcwwmlXgJPTxwhg4ot3TjGy9RaMDOfJXH6m9tvNx04RzFEBR+g8gd8tYxzw/xpnPovtlXHaGgityD14IdCQXVFCydZH+kcUbo3q7+LZVm8CsTVt0zcXBm7brMYFhPva4ruCBMa+MtvEb69Y1axaeylnOB+PFGqVuooDJxp5I2j1ypsgWuszGKly3x1IxiZGXKGGZYTGgFHLG8c/jm9ZajFFJH2UGWKgNHZca++tcruik0kZxq/Bzjqr1Rsh98d/78YhKGNURCdNgl5Y2VPH4olhJ0yAIWjPpwkoRafRfdLFEnIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3va+k7LrJm/yyqiOXFvq5kPIqc3TNfEyRSbXIcswco=;
 b=sDZ2TmiHRWohcm9KH4NayvkFwuMhWvtqaIXuNCuQLarmTpIGZr1Irs7/XkwLK44paiLGEfVKvNJPbonsCXsV0fNYFfyV+1Jqd5i4BEwsGG4xDQIDRw7SuFLFjp/zosbJkp6NiSei7g6DE3RwBLKXQjATndUH2iDC6wEIhFwbnbo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Fri, 4 Jun 2021 04:22:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 04:22:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdgpu: correct the audio function initial Dstate
Thread-Topic: [PATCH 3/5] drm/amdgpu: correct the audio function initial Dstate
Thread-Index: AQHXWDTTWz0IGzbDGkW0w4PJG8L7+KsCITCAgAEgn8A=
Date: Fri, 4 Jun 2021 04:22:38 +0000
Message-ID: <DM6PR12MB26199243298ABEDEEFC3496DE43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210603045603.977998-1-evan.quan@amd.com>
 <20210603045603.977998-3-evan.quan@amd.com>
 <fe0205f8-55a3-076b-954f-9902f876e906@amd.com>
In-Reply-To: <fe0205f8-55a3-076b-954f-9902f876e906@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-04T04:22:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=31557fe8-ea27-486a-8b54-b73494e67a01;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9609a7f-24b6-45c4-bea2-08d92710631e
x-ms-traffictypediagnostic: DM5PR12MB1708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1708D0970563AC260AC57616E43B9@DM5PR12MB1708.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZeIz7I+QTv0c/F2T6I98+u/8A/l8MKVVO4dT/h4SwgqzulHD9zh2WRatQ2mvjx7ukZbdyxg80OwAjZic4sy4iAj0XIjvKR+dmaSSdWSb1dWKrLkIp7WO5D5BMoDoVMuGIwCEo6y9pHcYz3YbXDf1r1DHtUX3ve1SgBUS39OiYUfBWfNkpHPgHd2dxR43TA2oQMyWIb4MGdTMha8oWk/8C5uuPEKbqbmDJfVxU748V/jaUdyj35Q6pnk8+8uGIKtqC4aGuPAOX1mrrb+in56iEq51t3lLSChyDbeaSoGiMxTG5mnUhbvHKWwmuMYRiZWjSB7KkhMYze6nJKwUiiZJzcgWxo6MS7W8aSXmBJ8nhO4I21BjgHh1I7W6JOI/9guQncUrzCMOkz99zsbNGiMjd2TkTsle1KXW+y1vjYvTh+9AJiRfNH9jgMrBuL5XVOVrMu/vRnv/FJS2L9Sgx1tkKVa2cpwwqpqgwJbrRF4ws1tWJKFWzaZGY0gz5FkX+EsLZOrfV2z8PTzNwwRHvTM1k2G3FmARx6zwox1lEmpS4DqRQQHdgb1LXBmdku0m5XUKT0Qbr3VNp+xEMx4Nq5j0/WhgYtT4C1HZ4gD/ZTZeU8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(76116006)(66446008)(66946007)(66476007)(64756008)(66556008)(52536014)(55016002)(86362001)(5660300002)(83380400001)(4326008)(478600001)(9686003)(2906002)(33656002)(8676002)(8936002)(110136005)(26005)(316002)(71200400001)(7696005)(53546011)(6506007)(38100700002)(186003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?d3lodjhaS1dBVUR0L3B6UVBnZ1N4cnB1eUlnMitMTjBXYm5heWRHZGxlcE5r?=
 =?utf-8?B?ZGNFQTBJV1FyYnB4UUE4MnlSQ3NhWUdjT1JFbk52OWhEZDZpVlYxKytPc3Fv?=
 =?utf-8?B?MlJabE9oQ2RpVHR3RGJZVnBJTGN6OFVOWjFiK0Vsa0dMbDJVZUxVeFI2MUZN?=
 =?utf-8?B?RWQ0Yk0zMlZLdk1RMHBVR0NVZUwzNzhNVDU0aTQ5eUh3dmUvQ3JQRU42YjJi?=
 =?utf-8?B?ajBBOS9QazBCaHE3bk9vVGtnR2YwNFErRTJpVGtiVlExSkR1K2srbUd2U294?=
 =?utf-8?B?Nk0rSk4vL0hjUzlNWEppQnZsS21uTW9tTUJMRmxnVEVobG9WSVp4Q1AxOWRr?=
 =?utf-8?B?T0IraGR4OTBONXMzaTFzczFXOEtaOWVFNWduWllwRU43OVJWeDZjeTZGeURk?=
 =?utf-8?B?WUhUMDkzTmdaZWZwd2M4Y1l2VmVsTUFKOE4yckt0T05KSU1Wc3hhZFdsbmda?=
 =?utf-8?B?ckR6RnR0SE1MbnBUc2pla1pOQXFydFgyMWlHUjkvZk5oZ05jWDRyZkVFeFBw?=
 =?utf-8?B?ZXVONUpncHY0TVZmZEQ3ZTE0SjNoQklQT2Jna0VacWk0WDJaN1ViaHdEREwy?=
 =?utf-8?B?Z0JxSTN4TWdJNFdYQlpLdUhWVlZuV0IxRmprckMwaWJXNmhXaTlnNHR0QmNN?=
 =?utf-8?B?RmRvcDc2c3J4RU9Ed2FMRVVVRitFaTVzOExXMi9ONGNyZ28rSFI0ZTFyMmJU?=
 =?utf-8?B?aTFUK1VEa1Z1bTRzejRoQm9GRUhPLzk0SG5zNDVjWi9QeXh6bFhodUlEanIw?=
 =?utf-8?B?QW1CbDBUUytDeGFHZDdsbnlIclV2dG9IdWQ2S0lWeExpWHVTZjl6eTcvRGor?=
 =?utf-8?B?emdRRy9jcHRnZzRJa0ZYZDZlazNWY1VMMVhhdlJXTGtTWGFSV2lvR3BJRHl0?=
 =?utf-8?B?MDZsOWM3dWsydlBBQkl5bkVnaGtDcC9kRkZIek1GVDE0M2Zia2ppNk40cEM4?=
 =?utf-8?B?aG5BZDRMeUt1N3I4elRBdFAvVEVzN1JFQVg2MTM2S0xSbXlKMUNZMGkvWWs3?=
 =?utf-8?B?c2Z6NnNOVHdqeUVpQUFBZTZnMllIVE9odFUyNmVnL1VYVTdqVW1FMms1UUFh?=
 =?utf-8?B?OFZsdkVZTFFhaVI4bFV0blJwYTNreVM0TkMrckhJUEdaYkR3ZUl4UnlQWFN0?=
 =?utf-8?B?dG5QRFRNRmtUSmhZU3dZKzBpRndZa3ZuY1lPM2dWMExJaFFpQ2Z3YnF1SDhl?=
 =?utf-8?B?R0EzbXA0MlZLQkE0LzlxcUlMdVlQa0RRR2hWdGg0NFpNRUFIWG5Fa3Z6d3Y5?=
 =?utf-8?B?enRUZlRNNW8weDVEUVVTZ0loQ1NLK2NhMFBjM0o5SUNvUWE0UnlzUnBXTWFl?=
 =?utf-8?B?N2hpK0xYM0FXak1veEJ0RzN4d3cyU0ZkRkMwOEdNOEVVbkpRaStNQkJNWkZm?=
 =?utf-8?B?eVh1VFhGZHI4UkNYbEtUV3V4SGNCUFQ5My83WFZ2SVFyeUZQSy9FdmhVQUdy?=
 =?utf-8?B?MDArNW9nUXBJSHZSRGNUZXNtV0J2MDdRemVYN3dtak9oQ0h0TkM0MTRqR1lQ?=
 =?utf-8?B?VWVaSkxTQ2ZZTTZTS3cvZmo3NjB2TFNWeXhJMndzNHNFT0p0a2MzR1hrVFhv?=
 =?utf-8?B?U1pBblc5L2hHMVhyM3JmdjhVYmpoN20waUVzTWljQ2ZGUklScjRZb0FqaTMy?=
 =?utf-8?B?MnBGY3NBbUgxR1I5enE0RHdQL3lXZWQ4UFNRRmFRKzY2TnNLNDZEUjc1VFdT?=
 =?utf-8?B?WjBibGlOOHdBdUd3VWRlS2toUEdUYmlNZ3BYeTE4N0hxTTNDZUlkZEpGOVFM?=
 =?utf-8?Q?Ko5X3y2O3ivmliATRX1KqJdMyzYVMHEHfFVsHUZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9609a7f-24b6-45c4-bea2-08d92710631e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 04:22:38.3326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CiM6RnfE2BLt0aDkUwWIEfsWU89JTnZzPCprwZhJrVuFnDn/BdPP6UHnu5dlZcVj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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
> Sent: Thursday, June 3, 2021 7:09 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 3/5] drm/amdgpu: correct the audio function initial
> Dstate
> 
> 
> 
> On 6/3/2021 10:26 AM, Evan Quan wrote:
> > On driver loading, the ASIC is in D0 state. The bundled audio function
> > should be in the same state also.
> >
> > Change-Id: I136e196be7633e95883a7f6c33963f7583e9bad1
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index c354ffa62483..9d497b4f8e34 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -137,6 +137,7 @@ int amdgpu_driver_load_kms(struct
> amdgpu_device *adev, unsigned long flags)
> >   	struct drm_device *dev;
> >   	struct pci_dev *parent;
> >   	int r, acpi_status;
> > +	struct pci_dev *p = NULL;
> >
> >   	dev = adev_to_drm(adev);
> >
> > @@ -212,9 +213,22 @@ int amdgpu_driver_load_kms(struct
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
> > +		p = pci_get_domain_bus_and_slot(pci_domain_nr(adev-
> >pdev->bus),
> > +				adev->pdev->bus->number, 1);
> 
> For the sake of readability, it's better to wrap this as get_audio_dev or similar.
[Quan, Evan] Sounds good to me. Will update it in V2.
BR
Evan
> 
> Thanks,
> Lijo
> 
> > +		if (p) {
> > +			pm_runtime_get_sync(&p->dev);
> > +
> > +			pm_runtime_mark_last_busy(&p->dev);
> > +			pm_runtime_put_autosuspend(&p->dev);
> > +
> > +			pci_dev_put(p);
> > +		}
> >   	}
> >
> >   	if (amdgpu_acpi_smart_shift_update(dev,
> AMDGPU_SS_DRV_LOAD))
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

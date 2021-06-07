Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF5C48BC2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C099060FF1
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C099060FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7A96E847;
	Mon,  7 Jun 2021 08:18:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66A86E847
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 08:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8uJflErghJ/t7f+GriYTmkylF2GRKGhbCMAU0/NmwIelpcUo+GiCwtVELyYd6sDXnICOitcL8BW5K2pdHAO7R6XALP28f7AAgF4U2YQ9fKPpFuMvtqtN5oVUhREf65TLmIS/s1WtdLUkSUb96Y5D/5DXLuseDWeEfAabt7x+ZWZBiiI35IdLrrdTf8sLGLcaNzrIRBr/mzXKxhLGrPPZC4o36YXPgiOWvghdLI86fXJknAhfhzAR+iqbHTWR0hF3ne7jAj64RwHL6Wt4C17sRbIMDXquwqcTCzjdVCq5QSZ4ZN0sFrIKWrrTJ1DsHpri5k2QEdABVOJFGiZ6e6QSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmxYx+tJpa/3VleooPsgSsESFAy7YnV6phVeKNvSxJo=;
 b=Lm72N/ipfPqXAoBK2ZFCOnKplCZkzSaTjt6SAoGJEqR/pajhWUNDA8KzSBN0dJft0gUvUSbUy/n879wbSG4hDnHu7tVMqw3BdwocK7Ec+b1V4IUeXxKzNZExVpDHM4nVpveoi+xJ2It9FR9iu3DdyDj6daly3DmV6glSmfrPZnRRmlrE8Zxwua3oPCUfXqeOUq0zm/YjSd3/vrpJ2sjUb11fq9URQd5RcqSH30QZJPMXjNbNrYmBGT5eB3wfYVT2yFPqUsvF9dSfCSj/RQBO9mQ48d0Cr+fnVt+EhkK73/Rl5b/6CsFsDY4BqB0rD93/CBbSvP3Jvi6I8Ufqxf+AKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmxYx+tJpa/3VleooPsgSsESFAy7YnV6phVeKNvSxJo=;
 b=GCLYq8xfiF8XfM0t2yHdeXUxem+pOvR53UVJOyiIjCFcklLBe/kd70ehCAIDuGmnRAx0rQSSkW27whP73+3lOqf8glN9mLR3eEFNyTsfTRe43jatId4jJbqZCGLzW4+RpgcuiAwNOqe78ba14d2tQS4hW6q2knMRWXhpqXBJx1U=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5268.namprd12.prod.outlook.com (2603:10b6:610:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 08:18:43 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 08:18:43 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial
 Dstate 
Thread-Topic: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial
 Dstate 
Thread-Index: AddbdTZp2Jsw9pV6Rwe3Mtg06CdvSQ==
Date: Mon, 7 Jun 2021 08:18:43 +0000
Message-ID: <CH0PR12MB5348105E602AC9F5B4E9D09497389@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-07T08:18:37Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1b9b25c5-3d9b-4edf-88a1-d8621b5a5a77;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.222.150.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8feb8c1-1fed-4f46-eeb6-08d9298cdd94
x-ms-traffictypediagnostic: CH0PR12MB5268:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB52682FC3EA56A65777FBD01E97389@CH0PR12MB5268.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a/WU18DWBL0kv2sZByue4Hkd2D31AoM20S0y2xW5vz5cAsgCrCunkTWjy2pquoxL3dHdg76RbNwW6VQkON7qrJBELPd5WLbMLQbnYzRHsoMNsDRRTQdO/zR1uItR0bpLkvry2czlACfIcrTMAwshbxCXcHJmKzdU3eXbK+lD8x78qwDgIi47y7rTY2uze3dgGdJxGnBBJJp+WBe1EzC1ksb7UD/51fy4+fYNqc0w1y1ZbYygoEvJ93xyIdu9N6LMd4WcNj/ALjQyky4ISkrlDGJTIyEMwNDCr+w0kgKqX5jtgj2ncllrNmmzJoqH3nIT0m9rHM28n9EdWSto9r19MwofGDnpj+Tjh37JMWczuD7XrdAP2d+rTd/QGyeA4zoOR3ZFAGkoX0SEzxUwa9IO3nThtJNzYkgkqYqrVpVAIiGIIwF9vqsJrvYzOcTL9S2+C0XCuwQ2MJ4o1Hrw9auscs2iuJau8JGDlPwXXEm4g0LukXN59Kxnx7yioWpT2wNAbzPWt1tWIzHpGzivgaiA23B1awwFDT2cU0BWp6E/Q9aWmf50wgnZ/uCb/VxzmYPQuhYXseLOTGObrMDljKcKM+W2BIWtGniFZoC0lEXdMgo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(2906002)(8936002)(7696005)(122000001)(38100700002)(4743002)(76116006)(8676002)(4326008)(478600001)(9686003)(66446008)(83380400001)(186003)(52536014)(53546011)(66556008)(64756008)(316002)(110136005)(66476007)(66946007)(86362001)(71200400001)(5660300002)(33656002)(55016002)(6506007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MzB2ekJLelhyVVBXbjVyWFdCcGtUVm5hMlJvd1E3NE5MbWtzeURab3doR21T?=
 =?utf-8?B?YmdmaUN2TEIyZEpUUENQSzBHSURLRVdWMzlvYVkxZTk0ODQ4QWM5V0F4dFRs?=
 =?utf-8?B?clJPZnMxOGF4RFc5V0daeHdkL3p5UzZCRlRXVml0RFdhQjVneEw5UzkxMWJt?=
 =?utf-8?B?eVYvR2lxem1VM2dqMjY5UGRvV2pVb052SXF2dzlQbXN3bENTL1pJOEtqM2hU?=
 =?utf-8?B?L01lVVBHUEV6cjU4WVFScmdKSWdKcHJuK1N6emhNNDdocHN5VFRVaUxGOWNO?=
 =?utf-8?B?WFkvQTUrUS9ZOTVjZit1NVd5amRydlhjZVUwdDRZTGxWV2l3ZVNKVVNFN2wz?=
 =?utf-8?B?RXhzdmM1K0E2d2xMNWZyd2lPckFvL3RsRlFpVVVuRjRuRGptclkxaEFXbWV3?=
 =?utf-8?B?MHRXQTVyR3dZVlg0M0JTSFN1R2JhdjRMaXcybFJhNWZrczN0UU56RzhIV0pJ?=
 =?utf-8?B?U1VKREc2ZlgzSVdBbmdOUE93Yzdsa29PSncxbnJXeTZzeE5IZjFCazgwQStx?=
 =?utf-8?B?am50YU9NK25OWFRtUHg1RGp4ZUdkY0ZBdHc5azcvcEtYVkIvMTl0bW85ekIr?=
 =?utf-8?B?c2NHUDBhWm0wUWVTMnZRVXdvRmx3NXVtVC93TFc5VU5ueE5WdkcvWFNGK3o2?=
 =?utf-8?B?cERCeGNkNUdveWMrczV1ZXBzQXJ1eHpiOTJ6cnRoS2Q5K1I3bzVGTFBDVW1L?=
 =?utf-8?B?cEVaOU80Mm9YRjdKZXl6b1pwNFE5VTMzdzF6emdZdmtCYk16L0tobExCYkxM?=
 =?utf-8?B?Q0p0Y09kOEpKOENRQU1NalpKSTdKUFNQYTF6T2tJdHlJMWRVTkpyZzlFZldN?=
 =?utf-8?B?emZLYTBUVXdiZ3JMU3VVZWJtbVcvTlBWdk84MWlqZFdpdmpBbUZWVFBCVmNB?=
 =?utf-8?B?bVUxK3RWN2xscERIdHd1eG52c1hTV004SHRrQytuTHlDczEvRlZ5NC9EYy84?=
 =?utf-8?B?aGtlWG5zRWMzTWJlcjR6NmV3RHk4V3dOeVFmV0VtWFYyTUZ5R2MvamVNNU9o?=
 =?utf-8?B?bnp6eTdFSmFJNzF2U2Urd2IvNldiSlRrWW9Qb0hXRTFJWHBUVE9sUlo0MFQr?=
 =?utf-8?B?bW44ZloyZlNSMXlwUEVNNTg2VnhGQ1lTbHo5cXY4MWFBMm5vK0U2SHRWcXlr?=
 =?utf-8?B?ZndwZ25EakExWmt0aVJINTFpelF2dWEzWDUvbFBhUE5nWlRpazRzTUdpQmdr?=
 =?utf-8?B?TDlWQ3FkeWVwV0dQTmF2NjgxNEtTRFBEOGQ0bDBDTnAvMjhuUi9CZW9YK2Jy?=
 =?utf-8?B?MGV4NlBtdUxJcjZVeDlyQ2RNTThqTkhpZ0w3VmZ4K0h2YWFSdVMvT0pndWd0?=
 =?utf-8?B?L29nVkU0dWhwNHN6L1hudkZ5YnZXUnl0cTVYOGhZU2N5dVBXazVEYzRCY1BW?=
 =?utf-8?B?UUJCdzkyRjdwcW05OUwyd3ZKR1dsd1Z3MXNZa01SNlprZ0JNWVdDMzRNMU1r?=
 =?utf-8?B?Vi8wUFNXUzZSQk9QMkhhcjY1ZVVhOExPN1pxck96a0pURWlhTWpTR0FmZlg2?=
 =?utf-8?B?ZDFDTG5teU9WM1FNRVFObWZRVlhObmgwOXhGMitQRTVkWW9QbFB2T3NiWWNo?=
 =?utf-8?B?THA5M25NNFY5VU9wejJjSFd3LzQzM25kdGExQ3hDblVhK2FTSDJySWpZRnZx?=
 =?utf-8?B?NXlOVXhFcHhmRmF1WXRlR2dqaWJtdUhpUXU0SEdXaGp6Mit1ek81MXY2Ujhx?=
 =?utf-8?B?OHNGcE1HQnB3b3Y0d1lYTmxsVnNhanFIMnhyTmNpalIwR0FvR2l3Y0FwejdH?=
 =?utf-8?Q?tSR3piBfYIi4Ul7+D/GundCC4t5sAnyoZsBCpDN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8feb8c1-1fed-4f46-eeb6-08d9298cdd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 08:18:43.8674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6aWGgpbqZFNSKf9QtZzbLEfrur2+4yAwec13WvWYKCM3cINFOzxTpa6HzgbbHe9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5268
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

[Public]

Thanks, that explains.  

You may modify the comment to something like " amdgpu_get_audio_func() makes a PMFW-aware D-state transition to update audio dev's D-state in PMFW" (now it gives the impression that function makes audio dev to stay in D0 state).

> > +		 * Via amdgpu_get_audio_func() below, the audio function
> > +		 * is guarded to be in D0 correctly.

Thanks,
Lijo

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, June 7, 2021 12:40 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial Dstate

[AMD Official Use Only]



> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, June 4, 2021 8:24 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH V2 3/5] drm/amdgpu: correct the audio function 
> initial Dstate
> 
> 
> 
> On 6/4/2021 3:28 PM, Evan Quan wrote:
> > On driver loading, the ASIC is in D0 state. The bundled audio 
> > function should be in the same state also.
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

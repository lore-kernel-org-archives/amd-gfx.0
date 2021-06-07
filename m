Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8151C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8306108E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8306108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF076E84B;
	Mon,  7 Jun 2021 08:29:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21DC6E84B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 08:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6KwLAwqL6njGbZTZ3FOq+KlnW7Roqc/5cVhcb877jelA2FN7o7G7vjUunNn4FE5T5k69EMiEu8UzOcoce5deFy/E8HtwucOzOHJrq6xYgGYkKBDG9ZZ7GXBNZ5pOAN6prnZrmUvIgpX1usq4phKBIIz6wWxpfLmsFxyjBhT1WkQG1PZ3XzI4hrkL9Qh3cmKaxDwZ27pz1eywL9fj8LuL5EV7Z16gurny2LhA/yA1Kzrx/OCFEvCyhkqK6S8gl7ufCeLn4kjFglG8Dxtf2DPIhDQTk8t2gkI/GK6uwFBhRu0+rD6FeW6eVq0nte7XczyfMUZHECQO/HcogRZgnDabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/nEXG3ZCrr/rf+bpLli7u03TD9wV8DCUcmhwwoKfzw=;
 b=MCkhCfqInLpVPfepmp2ELbZii0iC6UUMeJZGhEG0yCJrY8zrnBhmQL7tnQxesvxfZzrI22WUa4rIbXi4qTI4INf2dt415lAOChVH4JVekVezh4iNGa25y1PAuote3osb/CCikW6L1l9szKW7H28Fi7ygk4pUTLRSoI+Ngc34zEdn8WisD02QMG+nsOJGfdo6KdUeX9dJO3CLFirTt8X15CAwRg/hLvAg96eUxAQSD5V7J+ZapLbmqaRmLkQP1UisdHe4u1jmS4W1GLRjhSiYmQF0fxw5+ZcjWTEzUChYe5G90Aty8R6df+jtrN3qNwyS5yIC8bIjzQJqBIUYtw5jnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/nEXG3ZCrr/rf+bpLli7u03TD9wV8DCUcmhwwoKfzw=;
 b=qU2/10jtx9USCPOMX9Vjz0Ettd0fXGifASKSMefR6WSh44c40Y5OGaJ/B+LI7YfE174hTwBp2S/qq8/gu5s797yeNFoyCT4wwWHa6JTJRctDsJU6KbEDOQKUjJJz46jXRZuFv49rDJ8hWVj+YNsgitGUC/cUsgSUJtroA1GeA6Y=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Mon, 7 Jun 2021 08:29:35 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 08:29:35 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial
 Dstate 
Thread-Topic: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial
 Dstate 
Thread-Index: AddbdTZp2Jsw9pV6Rwe3Mtg06CdvSQAAfMCw
Date: Mon, 7 Jun 2021 08:29:35 +0000
Message-ID: <DM6PR12MB2619C68E2B8CBFF28756A3ECE4389@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <CH0PR12MB5348105E602AC9F5B4E9D09497389@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5348105E602AC9F5B4E9D09497389@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-07T08:29:32Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1b9b25c5-3d9b-4edf-88a1-d8621b5a5a77;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 095de346-cda4-40a2-64f7-08d9298e6206
x-ms-traffictypediagnostic: DM5PR12MB1452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB145260AE743C961EE4BFCF16E4389@DM5PR12MB1452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 574mcLKxRdwjPeCCf6AauMfoMWT9S10cM4G/xJ7cfqDM4FepBEo5gBCZqRHdPxduhv6G0HZ4dUwHOETbAez+tCa/AB22tV2deI01XbBArMDfJBQWb21663GQBxtVW1UrbUGxUXiRx+fAd8IXE5VR+WUzJobzn3djgVAddbJj3zti9hUSYsiAjA+/58ZcaBGt57pEnSElnZ+BZv1uzcLZHWASHdvOxtfLBjGjL1gYKJx6PvxaAtUT8fBZiPJYR6UW7pzMjb8ZFKezFjN9cBAdO+IBOZZeJ18XOKVATDVa2ZWAI2WY6cAJ3BWjTAR0Cp6Mu/X5lF3Gr+tuKT6GG93mlWgTmEOdoOH/iwbvaVEFQbrGPiozMNLHquFVlfXci+0oWcLHO1ZgUy5aFAh/fYB96HExRwHYzqT0wFtntJlX2YaE/Kw4VIeywa8ncTI0MGX2V43LHgdjUwPZTxeyq3cEQy7X2WznQteWwQy/0iUmomabR3k3UY1ac8qmwY5vR8OcynNkpCqgRVxymuwpw3bQwCl6KklEwWgPrl7KGFG0onbPVCi2i9tloZerSbAul66m3cDXpRn8LaqMfIKVwutT3PECVGM3W8Wjvj+vTX+cYFU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(71200400001)(186003)(26005)(8676002)(66946007)(64756008)(76116006)(66556008)(66446008)(66476007)(316002)(6506007)(110136005)(2906002)(53546011)(4326008)(52536014)(478600001)(7696005)(38100700002)(9686003)(122000001)(55016002)(4743002)(5660300002)(86362001)(8936002)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?aE5xWE9EckNFYVBjYThHSU55K0JLVEE4eDI2bUd5SUhGTG5vS015K0xtay8x?=
 =?utf-8?B?RUxXUEJkdkRKeEdab3UwSC9rZHNnOHMrcnVMT1hiY0kxKzhKOUhqYllWbjRV?=
 =?utf-8?B?NVk5YUwyaDc0SU8vUlBISjBHdWltZS95SVZpNzNLTUs4VkFBOGFzQ3AvUFR2?=
 =?utf-8?B?djBTaXY3UmpCNS9iUlFtU0M1ZDE0Zkx6L3RYeVR0N2lxSHg5NVk4aGM0SmZa?=
 =?utf-8?B?dmFvalJjQVJxOFNLcS9VUU9uUVpxT3k2U2ZtZ2VoOUxVRUNFZGQ5WkNwQ1hm?=
 =?utf-8?B?eGxqK0VNZFN6Vm44RGQza2xEeHNGdW9ScHJyc29wWThoaDlRYTJxQythcnRR?=
 =?utf-8?B?eFgzMDFuTnAwc3l1SktPazhpNGh4cnZNeCthRC9CN3BrZDVNL3BGc2NGaVJF?=
 =?utf-8?B?UjZ2Vjh4SU4yNDhlK0dxK1hLTGFNOHVEN2ZEMXNSTkVWNjlDeUxLeWdVcnpw?=
 =?utf-8?B?TmZNbk9pMzd1VFc3WWFEanRBRitqTUVlMjZ3ZWNLVVVzbE5HQXpQRlp1emZI?=
 =?utf-8?B?MGY1eVlKUDJUdFFOcTQrRklZVXg5azk3bkR3bTAzeXFPa2VtTHhxSFhqRXhR?=
 =?utf-8?B?Q05nWk42TEZacjVQYVI1UkRaUU50OHgvL1llK0dmMnZ6RXFZRnE4WHNZSkJ6?=
 =?utf-8?B?VjdLWDdoNUxBK1g0bGtKZG1icjYxcllTME9mWmRQZ3R2R0RzRlNpUHI1VDVm?=
 =?utf-8?B?L09ZTFc1LzdsWmp5UUhtT0g1Nnl1YTFOWS9SdFVzVkRiUXlnTHJyWCt6TzdK?=
 =?utf-8?B?b3doOEU2RldCOEQzcXlKQ0htVVV4Z1RtUFpBWFIxaVJkK2xsQ3NqTkxtblB1?=
 =?utf-8?B?TFArbjdzVVdheFNnd3J4aHlwNUxrYTZFRndiek9nYXVMYzdCSCtNc0JDdHNp?=
 =?utf-8?B?WGszY3RMN2VJU3docUt0cTFzekM2c3prVlI0WVUyZzV4K2d1N1RtQ2txVTNo?=
 =?utf-8?B?bE1DN1dXUEhEYzk1OUFRbHUvQi94a3gvT2VCbm1LaTVLbTNuQSsxNSswZmFo?=
 =?utf-8?B?T0daRzA0UFhHbE5nOFVPRzJ6L0wxY3R2dmVVSU5FRkZmdUxEQkdTUzIzY2RN?=
 =?utf-8?B?RDRVRE1JQUV4RmkwNk4yZDdCc0hoVTlibWNPM2VyVmJUZlY4L3BFQXBKU1Ja?=
 =?utf-8?B?VjcxUTlLejQySGRvcUtaOGRvTUJvNmYzdGlyZDRqejlXT2J3WFFyaTl5SEF3?=
 =?utf-8?B?MzFvK2wwZXlpOXNjOUEzandaNEhqTUk0SlJvcEtFbmNDbGM4K3NMZDIvOENV?=
 =?utf-8?B?dnBLUlM5L2FNN2laZm91QnhFM3VrZEhGR3A2TEtQOFdzcXhBeHYzZnc4dFVz?=
 =?utf-8?B?UWw5UUVsRkNwRVJ0QjdOZzk4cFgxWnJ2RVM1ajhGRGordkRZMWx0SjBwR3ZW?=
 =?utf-8?B?NTVZM1d1Z0ViTUdCQTIzS0t0a2tPcFRCNkttTXFaMW1ETWlxQlVCT1RCa01Q?=
 =?utf-8?B?S2djZkc1NGRXRTVzT1FqL2RFNmVhK0tpb2Z1L2RFaVc4MTRRVEt2WUtUUHFR?=
 =?utf-8?B?cUFzUldUU1g3TUt3QmhRNi83ZTlRVHlRYkVROVBRN2dNQ28zREVKSE9KVHg0?=
 =?utf-8?B?UDgyN0h2di9LZk9Uckk5TXJLSFllb2hSeTZzdmk0UnVETG45RWFJcTk2bTh1?=
 =?utf-8?B?aUpzUzFQSmZCdkJpbU56UTBRM3EzQW1pK1FVNHZPUTVoVjNKTXNJOG5xRW9N?=
 =?utf-8?B?QU45bjZ4RHpETFpmK1NxTS9FOEhmcC95TEJHcFRhbk93RXM4QWxOaktsc25X?=
 =?utf-8?Q?fBGHbCs2ocd+y3A+3cfIIGcg1Dth3gAXvzJ4L4V?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095de346-cda4-40a2-64f7-08d9298e6206
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 08:29:35.4897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/b2Bt+ibU9gziW0JHSKkykwrCR+7KRguSNUFUUJ5JzuOGORTUE4Gi/8HGrdZntt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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



> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, June 7, 2021 4:19 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial
> Dstate
> 
> [Public]
> 
> Thanks, that explains.
> 
> You may modify the comment to something like " amdgpu_get_audio_func()
> makes a PMFW-aware D-state transition to update audio dev's D-state in
> PMFW" (now it gives the impression that function makes audio dev to stay in
> D0 state).
[Quan, Evan] Sure. 
Thanks,
Evan
> 
> > > +		 * Via amdgpu_get_audio_func() below, the audio function
> > > +		 * is guarded to be in D0 correctly.
> 
> Thanks,
> Lijo
> 
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Monday, June 7, 2021 12:40 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial
> Dstate
> 
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Friday, June 4, 2021 8:24 PM
> > To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH V2 3/5] drm/amdgpu: correct the audio function
> > initial Dstate
> >
> >
> >
> > On 6/4/2021 3:28 PM, Evan Quan wrote:
> > > On driver loading, the ASIC is in D0 state. The bundled audio
> > > function should be in the same state also.
> > >
> > > Change-Id: I136e196be7633e95883a7f6c33963f7583e9bad1
> > > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > > ---
> > > V1->V2:
> > >    - Lijo: include the code in a seperate API for better readability
> > >    - limit the change for Navi10 and later dGPUs
> > >    - comments more about the background
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 40
> > +++++++++++++++++++++++++
> > >   1 file changed, 40 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > index c354ffa62483..e9f2161738d1 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > @@ -123,6 +123,22 @@ void amdgpu_register_gpu_instance(struct
> > amdgpu_device *adev)
> > >   	mutex_unlock(&mgpu_info.mutex);
> > >   }
> > >
> > > +static void amdgpu_get_audio_func(struct amdgpu_device *adev) {
> > > +	struct pci_dev *p = NULL;
> > > +
> > > +	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev-
> > >bus),
> > > +			adev->pdev->bus->number, 1);
> > > +	if (p) {
> > > +		pm_runtime_get_sync(&p->dev);
> > > +
> > > +		pm_runtime_mark_last_busy(&p->dev);
> > > +		pm_runtime_put_autosuspend(&p->dev);
> > > +
> > > +		pci_dev_put(p);
> > > +	}
> > > +}
> > > +
> > >   /**
> > >    * amdgpu_driver_load_kms - Main load function for KMS.
> > >    *
> > > @@ -212,9 +228,33 @@ int amdgpu_driver_load_kms(struct
> > amdgpu_device *adev, unsigned long flags)
> > >
> > 	DPM_FLAG_MAY_SKIP_RESUME);
> > >   		pm_runtime_use_autosuspend(dev->dev);
> > >   		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
> > > +
> > >   		pm_runtime_allow(dev->dev);
> > > +
> > >   		pm_runtime_mark_last_busy(dev->dev);
> > >   		pm_runtime_put_autosuspend(dev->dev);
> > > +
> > > +		/*
> > > +		 * For runpm implemented via BACO, PMFW will handle the
> > > +		 * timing for BACO in and out:
> > > +		 *   - put ASIC into BACO state only when both video and
> > > +		 *     audio functions are in D3 state.
> > > +		 *   - pull ASIC out of BACO state when either video or
> > > +		 *     audio function is in D0 state.
> > > +		 * Also, at startup, PMFW assumes both functions are in
> > > +		 * D0 state.
> > > +		 *
> > > +		 * So if snd driver was loaded prior to amdgpu driver
> > > +		 * and audio function was put into D3 state behind PMFW's
> > > +		 * back, the BACO may not correctly kicks in and out.
> > > +		 *
> > > +		 * Via amdgpu_get_audio_func() below, the audio function
> > > +		 * is guarded to be in D0 correctly.
> > > +		 */
> >
> > On a second look at the comments - should runpm _get on audio dev be
> > done before doing device_init (so that it's in D0 while FW is getting
> > loaded) and put done here?
> [Quan, Evan] It does not matter as long as all those are performed
> before  .runtime_suspend() kicks.
> The issue around here is : if the audio dev is already in D3 state before PMFW
> alive, during .runtime_suspend there will be no Dstate transfer(D0->D3).
> Thus no interrupt will go to PMFW and PMFW will be not aware of the audio
> dev D3 state. With the proper audio dev D3 state, the baco state will never
> kick in.
> Via the amdgpu_get_audio_func(), the audio dev is put into D0 state. Then
> on the succeeding .runtime_suspend(), there will be Dstate transfer(D0->D3)
> and thus interrupt for PMFW.
> 
> BR
> Evan
> >
> > Thanks,
> > Lijo
> >
> > > +		if (amdgpu_device_supports_baco(dev) &&
> > > +		    !(adev->flags & AMD_IS_APU) &&
> > > +		    (adev->asic_type >= CHIP_NAVI10))
> > > +			amdgpu_get_audio_func(adev);
> > >   	}
> > >
> > >   	if (amdgpu_acpi_smart_shift_update(dev,
> > AMDGPU_SS_DRV_LOAD))
> > >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

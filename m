Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EA2C07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 05:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DEC61CAA
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 05:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DEC61CAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FBF6E81D;
	Wed,  7 Jul 2021 05:18:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C39DF6E81D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 05:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuJRVaahXGgN4I60Fy+IY8xzpV8BByF2+SRUtAfFbKw3DXBZusxlw1NcyTR8NWcK9kMRDZlOaYH3OJgVZDdicTn/dT404PYhOkuW5sYe5l9plaxHPMcNyksIA+txyqhTVKJeZxDMASdNsdw9M+lLW+hlanUXHUVL2I4S2+Y/kjMADBTSSBAuHluqbEyfqJD0BBCaSoBdi5znILmErwUPAw0E6K3fQo8i7SIDszAaodZtZufwWEOiSgZumd5MSSZ5L3wAKioZEQfaIs0umW1iXGYUQBsd7OklU/vtkySwFJo9BGd4sYYdLt9navWSAPiY+sgTYXlmdx12LpGLSucEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p88R5BtsZAJZ+dh6n532qaw5/P5t2YdQalxuPmB420s=;
 b=DpmdoccYz2bJYQWEWXAtCFhen7CH/QKJ5XbCVPrPclNnCru0NE4Yv/CHC+2mN5wVPGTSN1G6/xJq4Otqh+hbz5J76bedJw7tbSJIAqyoBPE368Qr4tSjLRtSlf3Li0VhRkRDcvF1ALMCje7Lw+7MZTKbsMGO8Etj8PCKkSLQiCDNXU6R8hx10lEEjcwKR6JjxPuBHWi7J9FtP1UoURbHgSA4FhhXiBDn73nMvjFQLAf0jKRHjM+bmXKbJ1PFdNNaF3NWH3/dHlEXUcXep7/0Oh/OF5FIB1WsIdHnTgpHCkzmchi8cYiKglfV+Ksz7N6W+2RGI9ZUioJLJ5smEy4FsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p88R5BtsZAJZ+dh6n532qaw5/P5t2YdQalxuPmB420s=;
 b=Ynxktz1pceH/ZwAxmJhDe1l8F3D7ZSFXxQcwxsXSNiUvjwOtiH2ybl5U8QFIlI2pM6VPVlppZwZufkH7nJkEPWvzWxOf3oFmU4v1r6i5xUiijnUbfoS2tsPHwJOvOj4tSPjS0L/mElOigV8sMGoWrUf+FpNytl84FsXpc2HyIRI=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23; Wed, 7 Jul 2021 05:18:45 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 05:18:45 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amdgpu: Restore msix after FLR
Thread-Topic: [PATCH v4] drm/amdgpu: Restore msix after FLR
Thread-Index: AQHXbvGhnuYipNXqoE+4z83Utsa1kasz5b4AgAMbAYA=
Date: Wed, 7 Jul 2021 05:18:44 +0000
Message-ID: <DM8PR12MB54785093E0B8A80674125FB0F81A9@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210702032318.27215-1-PengJu.Zhou@amd.com>
 <5a48ef83-164e-8203-8945-b5dbb1ce9ad6@amd.com>
In-Reply-To: <5a48ef83-164e-8203-8945-b5dbb1ce9ad6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-07T05:18:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=64d02e3f-3d9e-4c69-bc7e-49ea4c129a00;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 953ce7f8-f8ee-4cdf-a3b2-08d94106b154
x-ms-traffictypediagnostic: DM4PR12MB5151:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5151F09EAA4CC388D719D7C7F81A9@DM4PR12MB5151.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +xHMBVWSHnoEhHPzc/3mYEK52Nj42YN/sLPW0G/ZH+L20zGK3gFBn+IY8GNbQLusMw35Fr3KToZ/SYm/Yu62mG0vy4ukmfrB6/skOw+nIVLtrj2JWzTuTg/qsOJKURt//PUyJSkI4f1+SRsasb7xUCrtiOCoytdMPJSclZc0rPlqm6Yz8C2iPqCo8Wc4j1GNS7tz55xtdnrAnmzcXs+8xzK1SmGXWxh67SQTR2JgvLUy5KhEZLxHJQNLa39ejEgFhEnoWvAUHwUQ5LDPbR+h95BzZ1OZ0pSzJnMNg5kcvnDntnVCdyPi9BcduHh1uYDRul7AeugwKI85sm+sEiTU6TvL3IWac5ftCybY/dg7990cGsOlljljzI+N8ApmrxUmyKtfuh8vyctiL9J8C39ZQbL8lGNwIafgMG8cX3qgRZGBd1J5XT5mjZSZNgVLA5pVEGw66+Qn91psuqYirpaS8aM5IwsDrdXL+5em27ztp/w4DsaVAw5P4cpQGQ9dV66xgwbBrbZ4FV6KYifc+YWS4KJPc3sw/5oKiy1IhudJ2/y5ThPWd7ELe2UwdagBL3Eza6kVH0SRvm/wc8/cAWI7vKMKi3m1AmFlntSEYvvBTZMyEig7/aWlkeiS5FW0pIf6d4yhFbFEx6yZP1PqSSA84g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(33656002)(8936002)(83380400001)(86362001)(8676002)(122000001)(71200400001)(2906002)(38100700002)(64756008)(53546011)(66946007)(4326008)(6506007)(316002)(7696005)(26005)(52536014)(66446008)(478600001)(66476007)(76116006)(110136005)(186003)(55016002)(66556008)(5660300002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG11NFQ5MG83TmprVDIyUzBHL3ZSZ1F3R0NoZ0dvYU10T2g2TGFFQ3p6eGNI?=
 =?utf-8?B?eFZISTBPY3VIU1liSEpmYk9VYW1pZ0pCS0YwekNhQ09neit1cHFxVFNSaDB2?=
 =?utf-8?B?VUpFTmJpTSszTEFQcm1mWVcraFE3ZFR4SGlPMlFVQ0ltWDdBS253S1pzSGht?=
 =?utf-8?B?Wm41Q0kvU2RMV1JBZDNVS2JLYzRtUHdEREo2TXhrZitnV3dxejl3MlU2RUQ1?=
 =?utf-8?B?Rk52UzNZUEpYRVcwRmpTcFVZUkZVajBzMGY2QW00ZHhndE1vMFNUWHdMRzBV?=
 =?utf-8?B?a2t3TGk5OEJiU09zeklPK1cvNVFIQlIySUxETStKWE1LdHBNMVV1eFYwZkxl?=
 =?utf-8?B?dE9vVlJNeDJrcGNvQzI5SEp3UEVzbEN2aGFodnk3QXpPMmVCNnM0R3Z4QUJW?=
 =?utf-8?B?Rk9jOUVJWTdiek85QkVGbFVEaWlSdGh5N1ZEeHNXWnZ1dUc1SDFYYVVEaElD?=
 =?utf-8?B?WlpKY3FFak9iaXhsUUR2RE9zRU1abXRtOStqaUpCQjBSU094UktkTXA2ak5X?=
 =?utf-8?B?bWM4bEh6N0M0WHdYVkdFck1mNjd5SFJxNXUvVC9XNi9PQm56SU5OLysyN1RB?=
 =?utf-8?B?aklsZ1hEL2hvZndZUkdIQmRLdkVCb0JVR2R2ZHVXOTdjY3UyVGg1RDQ5RXgz?=
 =?utf-8?B?R2FqaHZqaVl1N1RaSkE2ZUdlZ0tuZUxmWGFqaGlLeXcvNUVidzdGL1F3dmlW?=
 =?utf-8?B?a1FPbnRLSXdUOGlmSHhHeUxpUm44aFBiMnA3dW1JbVVvczdSbEF3NXFjbnJi?=
 =?utf-8?B?bzEzVS92Q09XMnkrNCtBcktKbWsvbjFrWFl3cDhmQmE0OTEwbkRSMFFHaVpU?=
 =?utf-8?B?UFRBZW5NMFFWTjRyMWJwc0NCSkhDb3R0Szd6c3Z1S3d5NFFoVGoxbkY3UEhh?=
 =?utf-8?B?MFhCYURFb09iL1hQQ1pZUisxYjN6U3dkcWdlcFBUTlppVGNVeDdkWE9ERjM1?=
 =?utf-8?B?QTVtWXJ3ZzA0em55dC94N3cyZUxuWktwU2xHbkllbVdrZythVjNJNkozV25B?=
 =?utf-8?B?citTeUVJNkVIZkNIOUJreTlxVnhzaDRST3huR3BlQTUvTW16UUg2Y3VNcVdW?=
 =?utf-8?B?bDNQaVhvZldCQXNHTk5lWVRmREo5Z0NvK1g2SGY5NVBrbEh5NzJacStXT2lX?=
 =?utf-8?B?RFdYSnoxb0NqNFAxcjdzdi9ZTUhubHArcXpJSWdlZWY0NXBmWXVGSU9aSDlh?=
 =?utf-8?B?M2JLWW9MbndGUHZjZHArRzJxNWp4b1V0QjAwOUdDME5Fd3pyRStJZ3BjcWNj?=
 =?utf-8?B?WjdVVlB6RklRR2t0YUF3ckVGWnNLVXhGYU4yQ1FZVDkvUTRtN0d3NTl6YjRS?=
 =?utf-8?B?RWlEOWRNN0l5aU9tcEJ6THBaeFArcTZJNFFBWVpVbzRxbDlRb2VjWFZtQ3hz?=
 =?utf-8?B?dWhQaUtQOVNxZnNURk1xK1h5bmNMLytCOWllaDJnVDlUSXNjYUlUN0o0RDJ6?=
 =?utf-8?B?ZnlaWWFlYTJaWVRIdG1SV0tnODBMN3doTFhWRjNpd292TzlIM0NHNnYyMExV?=
 =?utf-8?B?ZitSZGM4NFk2VmFhNHZkZEtEQi9HeFFQMU9FTVNLNnZOT1lQSFZIT2RzQ2Vt?=
 =?utf-8?B?OGdKK2s3TXc4clhnMk5zNzR3MTFPbzNRVTFuMXB1Q0tzTitpT0h4STl2NEpk?=
 =?utf-8?B?em5rZ1pzVllmdzJTYkJIak42R1I1b3NqaFBHTnB6QUNtL0FkN2RzalpVNUhS?=
 =?utf-8?B?a0dKbFZnaENtRHljMG9uNFVQaGYyMG1rZTVtS2VIUzNHeVpCR1N3bnNBWnNI?=
 =?utf-8?Q?uY/UfSj6TgOPWra8eGwdAGuVWhQCzGuOaacfMMK?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953ce7f8-f8ee-4cdf-a3b2-08d94106b154
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 05:18:44.6137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APDAv3y7EVteDSrkKys40CRlaId+07Cy/BxPrGqFOPQZ3sMBNlaQ26afcfpmODDU97q6CO5q7BoGtlseSx1tXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Adding VF check and static for function, patch sent out as v5.

---------------------------------------------------------------------- 
BW
Pengju Zhou



> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, July 5, 2021 1:52 PM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH v4] drm/amdgpu: Restore msix after FLR
> 
> 
> 
> On 7/2/2021 8:53 AM, Peng Ju Zhou wrote:
> > From: "Emily.Deng" <Emily.Deng@amd.com>
> >
> > After FLR, the msix will be cleared, so need to re-enable it.
> >
> > Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > index 90f50561b43a..034420c38352 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -277,6 +277,19 @@ static bool amdgpu_msi_ok(struct amdgpu_device
> *adev)
> >   	return true;
> >   }
> >
> > +void amdgpu_restore_msix(struct amdgpu_device *adev) {
> > +	u16 ctrl;
> > +
> > +	pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
> PCI_MSIX_FLAGS, &ctrl);
> > +	if (!(ctrl & PCI_MSIX_FLAGS_ENABLE))
> > +		return;
> > +
> > +	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> > +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
> PCI_MSIX_FLAGS, ctrl);
> > +	ctrl |= PCI_MSIX_FLAGS_ENABLE;
> > +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
> > +PCI_MSIX_FLAGS, ctrl);
> This field behavior is determined by PCIE spec and toggling is not required to
> enable MSIX. Also, FLR will clear this field on PF, so the ENABLE flag check to
> see if MSIX is already enabled doesn't make sense for PF case.
> 
>  From the code logic, a rough guess is this code is trying to reset the VF's config
> space field in PF after VF FLR and enable MSI-X back. If that is the case, make
> an explicit check so that this is only done on VF devices.
> 
> Thanks,
> Lijo
> 
> > +}
> >   /**
> >    * amdgpu_irq_init - initialize interrupt handling
> >    *
> > @@ -558,6 +571,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
> amdgpu_device *adev)
> >   {
> >   	int i, j, k;
> >
> > +	amdgpu_restore_msix(adev);
> >   	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
> >   		if (!adev->irq.client[i].sources)
> >   			continue;
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

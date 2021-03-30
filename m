Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6A3C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 02:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0973361959
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 02:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0973361959
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FBA6E81C;
	Tue, 30 Mar 2021 02:27:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2557F6E81C
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 02:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpab6gI/YJD3fYWkhauCclx31HuhIBJlSTd9QGc3Roife8/sCpROaVnnyQctj+qRjhUkx8h3lUJEqArJt7qti3XraZtGM3lWJAIz/LNzp5S2hSoJy2FJuWTSAXFnnPUCYr29BOX5Qm7lEZo+Fb4F8AniQkDqPafFjEumbO4q3e+PTWRWgXEgSn5n6cn199BtAFbDAhymcV98kCpxcO8O1EWvyoKuRfaA10mUdowz4lbnxoliiPapwhLVpdQ+5XNE9OtMA163HjMiuwnDsybwDePueQjiDZi27zcOrihHBvfvBOqZpIXHLGJaXVMMeo3ZuXVAGjXP7S5dD1UEFqH4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouYqURTMZuK+P77M8X04LIQowqhs6rG5/kLnMZ8WKV0=;
 b=TLMhdLAcfk1We/sHn89SNFhwv942Q1szWZ3DcNTLpsysUZTWnkziCnTXRx68vQ0p/c8/z15ra7mMbKbHhbiExsChnHXD0IFRZ2iXa9y1mFZXd0MEpEZd3G/t2rv6bDRnDs7xbVhVHTUZbKySE8g6t1kxEadHerE8AsifdH5RmmkLojjeMZH57dYMu7V5Io814EMVjIXJpBnnQSP0ZT80VyG6GO+8twvXYU73tj6lBuSqNa8tYFbFDgIXJzEVUv/V5xFMPFBGIyMg8fwu3T0KLrWaX2XfNhwOHZrArnKoWNB3drAYXHN6bfV6FnkroQ7SInnHMnIfdoJ5Fk4rRIMgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouYqURTMZuK+P77M8X04LIQowqhs6rG5/kLnMZ8WKV0=;
 b=TLWpRLW3o98Vf2AgcM8RCDGI0Z8Hwzr9oC2Ldftg/15g10/la15P1VDQUEt+ZZse42wMl7J2mVXBFO17CEUmCLCG/OpcIiVDkrPu573x2TjVDDZhPHwVi8CfYAXNrWLAGibOc7GcytPvUtU46biAxOTPjheaKDDIlHg7jBHDTp8=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 02:26:57 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 02:26:57 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Thread-Topic: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Thread-Index: AQHXJHAZghLHQn95OUCyOFB/oxhupqqbCiEAgADFJCA=
Date: Tue, 30 Mar 2021 02:26:57 +0000
Message-ID: <BY5PR12MB4115E76A478C40C179C62B258F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210329074935.10822-1-Emily.Deng@amd.com>
 <20210329074935.10822-3-Emily.Deng@amd.com>
 <MN2PR12MB4488F8904F0D73C01F42A0E4F77E9@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488F8904F0D73C01F42A0E4F77E9@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T14:40:42Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=109c6dc9-9831-4745-9cd8-100458ff64e9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45fbcfdf-ee86-41ca-cc9a-08d8f3234a9d
x-ms-traffictypediagnostic: BY5PR12MB4115:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4115C0719A8071313E983D698F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1nGZGYh32erH65iG7uLO63vZBN5+wqoLR1nrB4WGJMcG1yxwNLtu6dA+XR+sgQVZIHZBbMdIGkdhpKZWXegucLM89PYgp4aZWGyxkqI4h/4jlFhbsI4lSNFBilRVOywpvDXcdzSIWTPjDwyLcw6PoAx+PJSUpjvdXWOf08uS/1/ucTLr8J1xtZynH3AGyphy+BiQXep0EQvulSUKJcQQtWLE/6IKV/agVtNfoVRC0HGPrqWteQwToB0i8WyH20EUoAxWwvmSCyrcvozzBLqboU+gNuPmMqaTtG60ZVBHor+xQMqBScOZl5VmSXkVQ3I6JwBQuoKgNzgUmANX+/0taGDZhTDTOolQCR/vcRLTXr1pZ83qwHFi8kpwwuIttBdizW/IK7W+ZY77NHkvrmfsqlv/bEsSjMdJEeKekeqfubW00RUu6bQq3Lziv7ghcnN183ckPLnnK1ttYz0glM4PUhib98oQIg2rEatZhiusRcAq3K3FYvNBMM3ke38jhRHgXOWD1ytakUwT8sNwm3qeNGzYKk3L0DoU2Ig4UeD7a3SxwxZepFQcjGwrSurXNtMHtFaU8uWmJWD90KGRaPaFQuQxJ8sr8IJRzLJQCEQc3pAzVrCHKLuTvYvDbuzPNwDrLv1qJHBRbTMctVJerenEq4PBfovHG2q/p0KI2iPa+uax8UcgLAgkpY0rz+XlICbUI67lOEbJoU4pZSYGa3E59cdbFPG1OIlxmzuxV/Re0zQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(86362001)(5660300002)(6506007)(66946007)(66556008)(64756008)(66476007)(66446008)(38100700001)(110136005)(53546011)(316002)(9686003)(2906002)(26005)(478600001)(71200400001)(966005)(186003)(7696005)(8676002)(8936002)(76116006)(83380400001)(55016002)(45080400002)(33656002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sdRA/fQfkda8YWufak/mmlUEGhLN2MVODxbkHofOcLrAOF6Oq8wWZmQQ/nEg?=
 =?us-ascii?Q?znmipmCnv3XulZ85qx1CTtDZnnATm9q6OTpLC2zx5qVH6O1pwUBkvvZSOAJ+?=
 =?us-ascii?Q?XrFMl8sBp2ndQPp6owKykJWOOv/0/BlKqvOQdJNkYlAcR2Tl+ZPOlHZcUxBu?=
 =?us-ascii?Q?qFk6oIMnMzQ1fg8XDQr+aOxuk7oeu55fUyt3DYpzEZMMZnfvKaQxRCGqT0nD?=
 =?us-ascii?Q?fZKk4imO4wR0hYpWB3UUAylC+7zRNfTVClVwaaGIcZ5lloxfHaZckBLv8mkX?=
 =?us-ascii?Q?pPe0fgdi0+5bnOfZ9g72qeoJ0uKzwvjxdGNd6GS/ib4sPDH0N92tenaRFKtj?=
 =?us-ascii?Q?yUv63s2Hn5EAyn+CJSfqeULxhxsejK5cmr3yvt9eTNE57NjcNT4Pt9KeO2e+?=
 =?us-ascii?Q?g6CyH+kmM86ua+VQp3ESXe1t1VYzHtwVaAPzYgawNO5HmIN0K8+D1q0K8H3p?=
 =?us-ascii?Q?FOQd2BKVVotl2kZ7EkLlMDmDMigEnBIc9TMpMLZtREwK1QKq4QJG9aZ+rUtK?=
 =?us-ascii?Q?txO+2Kn7azEhEIp386Qg7fCR8fUlpjH4F3SArxw7jk/l2GfLNtCDiX5fRTzd?=
 =?us-ascii?Q?DqDdw3E0aj3rX0cVfAb3JxkKGh2KdMBnN6qIXaW5mOqFbP0cGw20950dASMn?=
 =?us-ascii?Q?FVr3fDGY6uJ+IrLaD0oG47JTGBJi8LoKPdm5bRKuchWs2k4dfcyiG8V9Ke+s?=
 =?us-ascii?Q?CORR9Bmyml69Y8anys+UA1zFwoTyQLnJyxqPXewRnDkGgi8iU721oiA2xgW6?=
 =?us-ascii?Q?wgrLh+jsgiQZhclznINyN8hB4MtguHautYmxd5+cbsv50Ym5ah2PlpWUccju?=
 =?us-ascii?Q?cAqSv7cxsETA7/xxwgkpkThmCdK/kmPM2Emt/lBcuIYfcrHUK+38NX/UIqaU?=
 =?us-ascii?Q?ackJoVQiRCwojGVi8tnX8OOYg05M/icdUNvGbvLTIUFg1aJnuZjgiEtOtQfv?=
 =?us-ascii?Q?f8POcKX/O2mXP95+AYXU/NGUIL7O1O0Zmw4hDtK8sGvn0Yq/zxTuiyf/+4Qc?=
 =?us-ascii?Q?Z8Ab1V+xHSvciXPI3R1J9Xts1/a0i9/iXYBvWHQOK05+pLbGOeqrCCj5Kovf?=
 =?us-ascii?Q?/d9T0AdssU34c08E4qA5y28lKDHDRMSz+2W08SBdNyHkk+p+vZmAmUYHKCd0?=
 =?us-ascii?Q?ESKbP1fJQjcieaJZtIAnneexP4ePsltE1LAadlEqqTqIPTqUagQ3wqd380vQ?=
 =?us-ascii?Q?7jkg3wF2rJJCDx1klVUMcebR3Bhfl9eDe6hEYYOeFlnuUUD/rOb0zOEnpPI5?=
 =?us-ascii?Q?RlDteZ9gywWKJ5wvoTuMP/JFwcylrxdDJmpTBuXUbJQmaeJ61EG1V7LULkBQ?=
 =?us-ascii?Q?mjyO+HcnVVPbGPvYd0E7mdoK?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fbcfdf-ee86-41ca-cc9a-08d8f3234a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 02:26:57.2990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00lcWZAvx9dHvYmFWdVF2KITDQKVV6U/ywfBOxQAX6wgL+LmHjRX1k2VzSyc5v2j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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



>-----Original Message-----
>From: Deucher, Alexander <Alexander.Deucher@amd.com>
>Sent: Monday, March 29, 2021 10:41 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
>
>[AMD Public Use]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Emily Deng
>> Sent: Monday, March 29, 2021 3:50 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>
>> Subject: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
>>
>> From: "Emily.Deng" <Emily.Deng@amd.com>
>>
>> After FLR, the msix will be cleared, so need to re-enable it.
>>
>> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> index 03412543427a..f24263120f3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -277,6 +277,18 @@ static bool amdgpu_msi_ok(struct amdgpu_device
>> *adev)
>>  	return true;
>>  }
>>
>> +void amdgpu_restore_msix(struct amdgpu_device *adev) { #ifdef
>> +PCI_IRQ_MSIX
>
>This should be static.  Also please use the amdgpu_irq_ prefix for consistency.
>Additionally, the #ifdef should be on it's own line.  Moreover, can we just drop
>the #ifdef?
>
>Alex
Hi Alex,
    Thanks for your suggestion, will modify and send out v2 patch to review again.
>
>> +	u16 ctrl;
>> +
>> +	pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
>> PCI_MSIX_FLAGS, &ctrl);
>> +	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
>> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>> PCI_MSIX_FLAGS, ctrl);
>> +	ctrl |= PCI_MSIX_FLAGS_ENABLE;
>> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>> +PCI_MSIX_FLAGS, ctrl); #endif }
>>  /**
>>   * amdgpu_irq_init - initialize interrupt handling
>>   *
>> @@ -558,6 +570,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
>> amdgpu_device *adev)  {
>>  	int i, j, k;
>>
>> +	amdgpu_restore_msix(adev);
>>  	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>>  		if (!adev->irq.client[i].sources)
>>  			continue;
>> --
>> 2.25.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
>> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C422d42ec3
>>
>d004b207e5908d8f2873f6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
>>
>C0%7C637526009994486807%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
>>
>LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
>> p;sdata=0gZJU2qgZ1H%2F08YNVNN4RVAcgzXDbMZOw%2FuGvrimYtg%3D&a
>> mp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

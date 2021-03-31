Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231F1C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 01:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1D761990
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 01:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1D761990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08CD6E105;
	Wed, 31 Mar 2021 01:46:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A336E105
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 01:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRufHlf/TzPd/Z+TKua8/deo/MDq1VmunnefQslkxZ1u9XHkY9IqWx7mrf4Xj29hmEbeNPIBmjQCMc/hbCtl4zw6aLIJi6ECsyWTbwF3mkwqLSF4OUJSR6qPWtqpknPzMf/PDWRo7FFjh4ExDKwrET9hGFtNEDP85iortIo9cpsJ3QmJfh+zA6H2GOKRkslmiIixeEUdNCKyykOkVPqgHeFCMLa9RALG1Gb8/Xrm6jWz796c4EvgQqJEsVfn5CC5K4t8+0lo2XW1l59v+F84vEf+NlUcCQunT/12GJmAvkXEbEjEM6DhUh7oAotqXfIhNIJx2mPEh8966yuT59W6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhPiqySyAQBQR+k7AzklDuP5gU6xtqs8W6lGSyzD1Ew=;
 b=gsaD+XTWQa5rAvhzCcLOB093xgsP9nZv2TuVu9y8gKdljIIoBLDRAiehwPJF73cCw4BoK/yPTAaRM9CxFArezn462Lsrnz0LZ7TJVy99H5UDvAIhglHQaC5L7EMRAEW6iKe9E2kLnblsTXWWUdSABgylkYoytFuac7jxj4o/OL83oW0tTRj9JtGSJJ3GlReQe54nSkbvgEMXF3HbtS9dbBYaH4uVzwg71K3zjGcuwcji6XtG5d5KDz1uCeHVPClyeoS8IdYigTLdr6oR/kbURjjRAawPemOLyO1DmR6JSPOTf2LS/Qm85YhtGI7qInGLZYczMRiRFRcSRBRmdaQmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhPiqySyAQBQR+k7AzklDuP5gU6xtqs8W6lGSyzD1Ew=;
 b=YDIbl1H2AphY0LdZsn9a+b+70ZWmqWGudXHnkUHR2ML+mVRz42wjy98dYFOw0wAaNPh6b8mL2v8JovdprtZ8//cFKb+p/EPYafK/jwQmMSCRuhQCgpNFuf5uRr0uXsc1XGlzYwH3n2s6CJXq4RJUvcUEFDfLrq749Q+ccatH6CY=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 01:46:34 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 01:46:33 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Topic: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Index: AQHXJUkHjQ3O8F/sT065IKansoIo16qdVLwg
Date: Wed, 31 Mar 2021 01:46:33 +0000
Message-ID: <BY5PR12MB41158DE5C490F096C4B7849D8F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330094235.69090-1-Emily.Deng@amd.com>
In-Reply-To: <20210330094235.69090-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5d9d7a1e-cf20-4d26-80a1-002df5757ca4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-31T01:46:22Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d06d7d7-35da-4195-5c5d-08d8f3e6d08a
x-ms-traffictypediagnostic: BY5PR12MB4164:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4164421FB53A15D711EFECD78F7C9@BY5PR12MB4164.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hanmqm37+Ut2+U74HEEi0nkEscGOpyAzkg12Ey1aXr9oJ4I9T/LKT/Akxc4iaVk00ZKe1b/XG3b90m6Cy6wYwygNqDFIEitd0fFunUi6/5PWvnBeGv8YT5MYe8j1dSSOdppGaHjsT/OpzLPTJy3YCZuIYVPB2O0PZnKX5s7tWy5mr3iZV4i4UdOawvqeUiduCsLdvTstSwGSLbqxZgqbkaYVbQrw44I3rhEBVWvMb1JPisuQrO9+FGdADI+KuTh1LpU6NnmwKRg+PU78amhLMdFr+qWoQ8rPI7S365nZh3XGOd7Y7YUn5JKpbl6Rry5D6ZORTgQjYPpGapDsyH5ODYQeanIpTcHp1dEDgkgSfuSIg8f0UQkrgW57HR2LhXyKbV0vhtlfGQIJaU9ZKP/Lj1qtljJ17nADKC2O/1sInYGdBmyo9gsYl8ERuWufrXvF9JUykkQaUJt2TueZLCEBHhb1Cy3CEmeyRpEfAyh/07VlHQ5Qzq4doOMM9j7wV0Gv1/53ddwnG/KRZCF2AklmX9QyLC3jjCn4hPWjd70yVhpNCaqSRno8KvqxHEn1Q8QSEsnb/FlbA4TtdigU/R4jIvkFvCcxaNIuAIii3G5PncLWWMS8jry6kSSkPjsaiUsqsvd+M4pNGSWUWn3p6lqXz/7yW8DxCn2nuXdmRVFJkTU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(33656002)(8676002)(9686003)(76116006)(316002)(64756008)(66476007)(6506007)(66446008)(66556008)(66946007)(5660300002)(110136005)(478600001)(8936002)(52536014)(83380400001)(26005)(2906002)(71200400001)(86362001)(7696005)(38100700001)(55016002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1pFlnLJNY1cMLueZfYsEEatqGKLWLcsPasYhS/4hNdjxy3Kh9O1cy5aDTZTa?=
 =?us-ascii?Q?RPQfkeiKYH6QtaRH5s7uauTRlb5vBf6SvZf9i/qILjlkM05wzrLtac5KUt0U?=
 =?us-ascii?Q?DZox97LJ0DuNxBdrLcFp3rmEzbv6S1orgQ/jqrVjwbsiYG+yDKu0Vccea1d2?=
 =?us-ascii?Q?NPJR+gGumUj2xwWKtUurs5HTck3L7zMEXLbBzAoznST2qsMoxURJf73bMl8W?=
 =?us-ascii?Q?594oomCIi8ReXjC/BqTigE6HZs99F5lIgIk0irIUAUS6MHTyWgf2Cn4/fd+e?=
 =?us-ascii?Q?az9Zs5VdSJ3EY2E3bbkVOQbnldzw4JzsHZ7tLmGd8xYQsVAUH36uO03xdbKn?=
 =?us-ascii?Q?DtqyEjqnsOvWbvBrgAIk5I+rw4b045meR3BXv5E+7hl9Hc9oUAbH9qxnHV6Q?=
 =?us-ascii?Q?zHYM5ymXMQ2SrsMw8Gr+c8qogFdCVrJZdM3nTTiAF3hvYhA1n8H4NTQFlz1J?=
 =?us-ascii?Q?yAvJI9O0J0fOnSYKrLApr93drIRyRETIDOyOsl8wk+tivPtkqkjcrjJCqmXs?=
 =?us-ascii?Q?Cl7fHHLos11VH1BzwhnEdniIuHFKqKQ+VnPKPooPwux73X5g46yT9OEwYhOF?=
 =?us-ascii?Q?tRIl1CRoMmcaEcv3yVFOVG+RMx5FxB9RtN5ETkPL/TlGKznglYsZz0CAnJwB?=
 =?us-ascii?Q?VzGaSXtVNCTDyHKQy1IbfEQqLJEnY5nqH2t7j8ajiLII3j2y6A37JovqDdk8?=
 =?us-ascii?Q?xIdN+Qri9JpEipCxqjRCNoczKnyuPYwAiPCdLZ+hxK2RHfRCWAuoiQX+bhHA?=
 =?us-ascii?Q?5YC9PnR9dV9JQ25/zlrSuzhj6tZMiGd7Mkbns4wgyUpYQPL/F4xYVVqhgsj9?=
 =?us-ascii?Q?/+dDjDpHJ7s5KpzjE4a89akcIPbnLlN7/hXyQEqYkamBBT/Il/PbsSjMfT48?=
 =?us-ascii?Q?KVsYdiBNYbVSerOmMBY9Lpqfn4MjOtLsPhzI0QDtfS3JLGRxd4O/Mq/wuVrh?=
 =?us-ascii?Q?r9VnF10MwfBo7M0CLA6hgIQVoReccJH+tiEEPpDXnyaKjCtLSmEbTQmwzYXI?=
 =?us-ascii?Q?/dEiOp2S2c4N1gqjsWoBaj6myjLYnxtpB7XP4mBRVwyauzNxOYu2v3NrRSts?=
 =?us-ascii?Q?cVe5MZk+7F8yXz1dNmdSaP3mvSX02gORyt5dDQ30hq1EyajUocqYo770m2QC?=
 =?us-ascii?Q?tAEPHScvbhkuOORqilYnZl8a9LHjYIyZDa5j+Mz6ENMoZ0PqjEJ3HiQ3OLIB?=
 =?us-ascii?Q?CoEPll/nTs/rjERfBDkgTkmsq6TrTFC/sMD0/tAccHLwbQdP8Px9KKv6XZH7?=
 =?us-ascii?Q?1i737Z8NzznEihaS3JHGZ850YaAyKt0I7tTBkciyz/1R76gI2KeTOeULY289?=
 =?us-ascii?Q?00Cs/HJVfe9d54P6DlH9JbNh?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d06d7d7-35da-4195-5c5d-08d8f3e6d08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 01:46:33.8715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrwkk4KoaxdGkSufNBXKBYYix6uQL8pbeo4uNFH05LVcAe5c8WB88Qb60E3BS5V5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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

[AMD Official Use Only - Internal Distribution Only]

Ping ......

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, March 30, 2021 5:43 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
>
>From: "Emily.Deng" <Emily.Deng@amd.com>
>
>For vf assigned to guest VM, after FLR, the msix table will be reset.
>As the flr is done on host driver. The qemu and vfio driver don't know this,
>and the msix is still enable from qemu and vfio driver side.
>So if want to  re-setup the msix table, first need to disable and re-enable the
>msix from guest VM side or the qemu will do nothing as it thought the msix is
>already enabled.
>
>v2:
>Change name with amdgpu_irq prefix, remove #ifdef.
>
>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>index 03412543427a..3045f52e613d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>@@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device
>*adev)
> return true;
> }
>
>+static void amdgpu_irq_restore_msix(struct amdgpu_device *adev) {
>+u16 ctrl;
>+
>+pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
>PCI_MSIX_FLAGS, &ctrl);
>+ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
>+pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>PCI_MSIX_FLAGS, ctrl);
>+ctrl |= PCI_MSIX_FLAGS_ENABLE;
>+pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>+PCI_MSIX_FLAGS, ctrl); }
>+
> /**
>  * amdgpu_irq_init - initialize interrupt handling
>  *
>@@ -558,6 +569,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
>amdgpu_device *adev)  {
> int i, j, k;
>
>+if (amdgpu_sriov_vf(adev))
>+amdgpu_irq_restore_msix(adev);
>+
> for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
> if (!adev->irq.client[i].sources)
> continue;
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

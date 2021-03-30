Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A632AC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 09:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E666196A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 09:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E666196A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA816E887;
	Tue, 30 Mar 2021 09:39:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B736E887
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 09:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka/uxaK9kyNQh+wMlnrHUBcgyGUrpc0eico4xyYlYSca/a4Y7ObQ9dW9jh3Wj0Xtvssh2OuQ5vN+SL85TreKTK2Ap5g34Gkuk4FrgQRVYQ7Nojo9n2VM0+7lcR4OM5gQh/WyhoBfgkipsZyq1umB7wyt2S/Fxx3N/z2iG2s1Ka57y/CfLJZ8ZgotnATCE6TitOvtdGLJyaoig+KGcut8KPqc0V/ZqWXZDyu3FsBfFVbSnCd+sHXwJYw5QMd9w/mJT/nFPDrCi0GZyCrOhSVlbP7rDXSusUP1wLc9yTmrbTSvWFSOyB6qfB4m7dlwvzRNzwUupEEae1/p+ysrs3vTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swxM1P2c4QklM1tp6A2Amzb7zh4b5xcVC1e2U49wbZU=;
 b=BzKVH2kbTQS3k8s7MyQOvJYLsJBh0BC+AUN674DhOfp3puUt4YBUbMj6ik5LmmV3g0MLSnYrZ+1Ja+RLBPRu8UIvR6KVGmE+iHRY6U/Vy1li+khHZtDQ6qapDQzLhRtD2geC/BPCl1TuZ5JLnar4/Bl24cIhwc4ATf4wEISMUVoK4TnVCbiRqdWjXT+6HtFPfJb72jyPCM1rPziFdRNCgaP1ckoWYxUptZI/Z4f8hXQIj4akguJ6l/KfKaLNB2ovL9YrHFMPXwYRko+Fk5f1G86MOvDnVmFTPo3LrBXI1IGHn1JcHfe2HfnpBhN6c6lDNZhdpvEftg3ejNccD3WLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swxM1P2c4QklM1tp6A2Amzb7zh4b5xcVC1e2U49wbZU=;
 b=K7+JBzsc/uPrO6hmsHMZqWPukaU7Xg7EwBdASQjZ+UgZYCmddmaBd2PlWaxAOf+I0LTNJ1doCo7Ymswgl+zBRg2wrliwlAqrF/wh1jaapvFW3zDvSkDulVw9pAd44Baa/LkMzj09Coku8nD9piDKd0yx4CIbpNs34yBL4VY2Soo=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 09:38:59 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 09:38:59 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Topic: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Index: AQHXJTy/ur4/DvyQa0GX3tgOhdxKyqqcO0UAgAAED7CAAAW2AIAAAVLw
Date: Tue, 30 Mar 2021 09:38:59 +0000
Message-ID: <BY5PR12MB4115A14ADF57E43C4D9C86AC8F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330081441.61418-1-Emily.Deng@amd.com>
 <53edd04b-97a6-3f79-16e3-9a58704f8e28@amd.com>
 <BY5PR12MB41150ED0401BB65844C252218F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
 <539f12e9-1bcb-23af-4a07-3b9ad5061385@amd.com>
In-Reply-To: <539f12e9-1bcb-23af-4a07-3b9ad5061385@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=93ee0605-f9bc-493f-8526-9352231ab40c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-30T09:38:19Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3660f7a4-f685-4f67-c7ba-08d8f35fa57a
x-ms-traffictypediagnostic: BY5PR12MB4276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4276A19BE937B7A644E310748F7D9@BY5PR12MB4276.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gu556OrGb3UX0OGt8/4ptSjaaQv+JGj38HBiyhv++0/ZvqTsBj9N11I9oLAvK+Xk3MqpM6sNXGqBSudx3D1xqaxqEwDj7DcQcDiO/UPQuFTGiJ5mMNzawuxrCnvaDPBfTUCQ0MTXWYDYwu1lzg9wb3gXffHZBynmmim/DB4awx2jvCIII9AFni6kiVOHwa+n2TAWaYefUFfZ9+eKpC1ZmefXCZm99o10BPIw5vQO3UDuNAMJ1tmNc1Dryrn7ky2nurmVsvH+PLWS+fjUmxnewtC7zKtuxoh1FgbcbvMJOYydQpM0iwc67zENuGzCt1CAhCsSBReKD1FDcoh5pKHPznVHkB0IBPjVGlXqO1tksvyK8HBq6nynPh2VTRW+38IQSPu9G+tl/8TEmMZyIEA4WbsZyAibNQqd7T0wASl9qbG0ECdTAYza6xmWeLug16vECwzPo87yI0874tJr58r3/QDDJ7UEr2T4cwJr2W/JS5rZNIqwI52dtHxHIw0PdK5Wkn7sq2AJpS5UdJv0j4j6TTJd3v4NZr0r5EOwd2xGbXHF6T29AKrGz8A8D4v5F0XGER2PPbdQF35doTxu02TTCpaBO7D+5vklc+eNMUDS9Bpxw6muFbEuXdJfGiwA8goFzZxrmn6iAfLRR2Uv8nDyqN/AdENOBSTf2mqhYgJuccU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(8936002)(316002)(38100700001)(110136005)(5660300002)(76116006)(66946007)(83380400001)(66476007)(478600001)(66556008)(6506007)(53546011)(7696005)(9686003)(2906002)(55016002)(186003)(26005)(33656002)(64756008)(66446008)(52536014)(71200400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?WDJyYkV1Z2RkTllPTnBNZ1dscjdaVk5iWEUxVzRKUi9lV0o2WUJKcCtBMHpx?=
 =?utf-8?B?VEhScmtOVTVZZWtVaXFUWEZDU3haYWQyaXpTdFlkWnVzbEpUdnkwb0JsTWF3?=
 =?utf-8?B?aGhoYVkwYkZhMWJPZ3R4Ky9hN0lPanYvdExiNDIzMGluQ1VpZkxPZFdwWWN1?=
 =?utf-8?B?OVJQME1qWjlpMGRZNWZIWWYyZEs4OXM4TW5aT1hoN1lBY0QzL3RVUUlrcXdm?=
 =?utf-8?B?WVRnMFVjMWpYc0NEbjJPMGVQeUtiQmRNRnVuOXBjbkh5TFZ3bzBjUzk2Zzd3?=
 =?utf-8?B?WWoxNUtabERUQ3Fkb0VQT3BzbWVJdzROUU82Zmh4Y1Q1QXQ0a2c0OVQ3RnZI?=
 =?utf-8?B?UnFETlpUODlKT05jTzFuZjQ5dHBRSnhlVklyUXU1RXZ6RGIyZGtUakt3OUYr?=
 =?utf-8?B?UTNMUWREYUErazFJR3huUVYzRCtXTnVvQVNMWkcvVmxQM0pNUTQ5Wk0xQUYz?=
 =?utf-8?B?V1ljdDRqYVpNN1Ivc1dFWTJINW1yK1dkU1FnOHZva3hDK2ZVYjJneTlTWWJW?=
 =?utf-8?B?aERaeW9TVnd2eWJ5djgyN0pKeWdmL2xicFB3OEZ0N1BNWjRlMGxxOGNDdkU1?=
 =?utf-8?B?TEdCRE80SncwODcwbjlHa2pGZkpneVpOcXNnck05SWY2SWV1dW1RVTNzZnpF?=
 =?utf-8?B?dDA4dTRTQUpUOU5xQnVOR3llSWhPcXFnYSt1UmNmVGgxVGVYVmVtbENlNlNV?=
 =?utf-8?B?UE1Sa0pQMGZESWFoc1JxRHBiRU04MGRodFdXT0gxeVlnTnZRdzhnekNsYXN0?=
 =?utf-8?B?WWJua1E0bi9tTWdBd0N1QURWTkR5T2JBaExod3IvaEZiRVBBWWViMWFxRGcz?=
 =?utf-8?B?Y25INjRKclFEdmN2TnFraDhlUGszV052RXdTdmJ4STRaNHgvd0UwSExkMTVr?=
 =?utf-8?B?YzJZQlVjbXFaODVjeGpQSDFxcTNxVm0zamdsYUtGcEtsSzhETGpCZFhjNjBI?=
 =?utf-8?B?NlJDVGVtRjA2Tjh0ZzJ4QUxkQmQzNTQ5ZFAycksrSVpSQnpORGVuN3pqd3lJ?=
 =?utf-8?B?SnVJb1d2Y2FyOVdJYXM4eDJOa2JQemJSWG5NNXl6Ri9uckZNTndFOTE0ancr?=
 =?utf-8?B?dUxQMTI3eWo2dHVWTDZlNkM3U2hHekx0bDIzSGZCaVRreElvS2kvY2s0VU5y?=
 =?utf-8?B?eS9sL1Z3bzlVUDF4cEgrYUZQQys2aEUxZEgrYzJZKzRjZFIwSDhmNlFuYVN4?=
 =?utf-8?B?NWZJSmEyd0tIaVVqM0pDVElOM2d4SERQNGxNZitUV2hoY3VzUWNaLy96OEJQ?=
 =?utf-8?B?T3d0bGZkM2doS2VXcEdxbjBlZHRtZ2lMdS8yL240aGR1bTJ2WUgwRWlqenpq?=
 =?utf-8?B?TVBLR2grZFBLMXVhNTM0dlRCUWpoS1JXRVVtV1hlS00zV0llZWR3M3Nyamd0?=
 =?utf-8?B?Q1NlVTY2K2RmRjJCaWNpSm5hcmh1SUJhcTY2aENlN2NpSnV1TG1ZZGcrbXRI?=
 =?utf-8?B?bnNJeUZKWWxTd29QNG5rWUphcTRGOUtpN3d2aXB4ampqRGVRK1cyQm9VUUpB?=
 =?utf-8?B?ODNENkV2NXZoNitTWUpSWmJBR0V1MFppK1gyYWlKSWw5YWRGc0x0Njhmck5j?=
 =?utf-8?B?V1pSOC9iL3BSWm94NTB6dW4rcm5LZHpSbWNMeVA2UjlqT1FqYzlWRHR4TmpL?=
 =?utf-8?B?emd4TThPVmFIWUxOcHVYWnFaLzk1ektjRFVCeE1TV1VjWnArNS9Zc3Q3Rmkr?=
 =?utf-8?B?N2NqMTJMN2p2T0NoRnh3dUNnRmVqZ1pZOStPWCtIVWVESlRkOXlqd09DOWxr?=
 =?utf-8?Q?5qiRcXAHqiPHWm4KRLrCquA6GmPYP5E8xoXTWBS?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3660f7a4-f685-4f67-c7ba-08d8f35fa57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 09:38:59.5171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/JWQsVsJi88mMfkGZ5C3f8w8eJ+gjUvpuyo+RxftB4Tq8GAl4coInFNL/jS5vtN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

>-----Original Message-----
>From: Das, Nirmoy <Nirmoy.Das@amd.com>
>Sent: Tuesday, March 30, 2021 5:34 PM
>To: Deng, Emily <Emily.Deng@amd.com>; Das, Nirmoy
><Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
>
>
>On 3/30/21 11:29 AM, Deng, Emily wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>> -----Original Message-----
>>> From: Das, Nirmoy <Nirmoy.Das@amd.com>
>>> Sent: Tuesday, March 30, 2021 4:59 PM
>>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
>>>
>>>
>>> On 3/30/21 10:14 AM, Emily Deng wrote:
>>>> From: "Emily.Deng" <Emily.Deng@amd.com>
>>>>
>>>> After FLR, the msix will be cleared, so need to toggle it for sriov.
>>>>
>>>> v2:
>>>> Change name with amdgpu_irq prefix, remove #ifdef.
>>>>
>>>> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>> index 03412543427a..3045f52e613d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>> @@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct
>amdgpu_device
>>> *adev)
>>>>    return true;
>>>>    }
>>>>
>>>> +static void amdgpu_irq_restore_msix(struct amdgpu_device *adev) {
>>>> +u16 ctrl;
>>>> +
>>>> +pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
>>> PCI_MSIX_FLAGS, &ctrl);
>>>> +ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
>>>> +pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>>> PCI_MSIX_FLAGS, ctrl);
>>>> +ctrl |= PCI_MSIX_FLAGS_ENABLE;
>>>> +pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>>>> +PCI_MSIX_FLAGS, ctrl);
>>>
>>> Why write 1st clear and then set the msix flag if we know that msix
>>> is already cleared
>> For vf assigned to guest VM, after FLR, the msix table will be reset.
>> As the flr is done on host driver. The qemu and vfio driver don't know
>> this, and the msix is still enable from qemu and vfio driver side. So if want to
>re-setup the msix table, first need to disable and re-enable the msix from
>guest VM side or the qemu will do nothing as it thought the msix is already
>enabled.
>
>
>Thanks for the detailed explanation, Emily. Please add a comment so that we
>know/remember why we are doing this.
Ok, will do this. Thanks.
>
>
>Nirmoy
>
>
>>>
>>>
>>>> +}
>>>> +
>>>>    /**
>>>>     * amdgpu_irq_init - initialize interrupt handling
>>>>     *
>>>> @@ -558,6 +569,9 @@ void
>amdgpu_irq_gpu_reset_resume_helper(struct
>>> amdgpu_device *adev)
>>>>    {
>>>>    int i, j, k;
>>>>
>>>> +if (amdgpu_sriov_vf(adev))
>>>> +amdgpu_irq_restore_msix(adev);
>>>
>>> Is it possible to load amdgpu on guest without msix ? If so then we need
>>> to probe if msix is enabled.
It is decided by host driver, not guest driver.
>>>
>>>
>>> Nirmoy
>>>
>>>
>>>> +
>>>>    for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>>>>    if (!adev->irq.client[i].sources)
>>>>    continue;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

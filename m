Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C470C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 08:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3053F610A0
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 08:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3053F610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08A66E3B7;
	Thu,  1 Apr 2021 08:36:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9093A6E3B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 08:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho78Ugn2GaJn9PPoYQfqmW+aht3OHJZax1BS8VClA/s0+krV6W2I52o//0RKpk7nNj3FrFcTY+nilReowUVvT9R5nTsdCn6qAfSAsORoIVYdA7Ey5OYje9mX5qIx8tBKrYCZ9BkNgjGDiSA46OGgxJbtqB+BDNjSDx222EJpjTDQ8lpq8Ih3Z9O7g1zsjGh9IseqOPEzvlX1arUadVvdGl6Hnp13wFdb6ofOfXNiGnSCVzfoApNM45YWzaopC/TY/HcftYB7nIfSODdcuYEolj+p0WdoD3IIgmWxPSXhAkj5KsNcEKiT7Fe5OFVd4ayfXZtxWunj9KamAemM/N0gTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVTrpqu0e6lRnBMtkNhwOepNXwwiZxfDcMkEl5eYAtc=;
 b=ocYgVUSnozsOrtbgqxCptsNazw/FECHHYi/3QizROVNsIFswVfUnlbRM0KFXxxccDRIbffg8ooEM6BjC5o0sWshqTx7ZEcyAFlfp5oYeyIwEPv1ld0lfy7TIMnqJV72d/gGc+8HLhAuSCEuxdqZkI14rREWUQ+XkSYV4OKBVF+6WLvKvhMEORGDyupLXM/+wkOP7ogEHFfS4tA3yTaD21/mcgw8Cn9SDMSGtvjGdRO6i0JSyJ5WLDY0GrBjLmzpXrHjnZYdq+6UtjIfiC4UkFHgUmtSd8WWr2Lh8Nxxcl8PWLIf9/BSSr5MN+qF2uFNnk4921Qv70jlpadMlizMqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVTrpqu0e6lRnBMtkNhwOepNXwwiZxfDcMkEl5eYAtc=;
 b=ViwZL4e1wW/IC9uVNGjDXtWv7pS0VmKuDZGNzEUpDYaY0bU1IKAjAcN4AWEUljm0q1yG8ZmnCvLZKT+sTCPZXfF5wjVXBF4EYB38EIW66SLdheEY/24b5IiA+rh5me1kbnfKyXN2iXiw/nSyKSzGM4OzEsOeTTRdSClAP90OeUw=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 08:35:53 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::94be:52cd:b165:3ef1]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::94be:52cd:b165:3ef1%10]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 08:35:53 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Topic: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Index: AQHXJUkK6n1YweJUbkmsUq0v4h4SSaqdzmIAgAFglgCAACptUA==
Date: Thu, 1 Apr 2021 08:35:53 +0000
Message-ID: <DM5PR12MB17085ED44F7C3FFE064E6178847B9@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20210330094235.69090-1-Emily.Deng@amd.com>
 <BY5PR12MB4115E71D30C636258455A81B8F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
 <BY5PR12MB411574146B6118CFFDA0FCEE8F7B9@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB411574146B6118CFFDA0FCEE8F7B9@BY5PR12MB4115.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-01T08:35:48Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=266b6fb1-4d85-4d1e-ba21-b0d02abb0e1d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: My manager approved sharing of this content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 431bd82b-55f4-4cfa-68ed-08d8f4e9296b
x-ms-traffictypediagnostic: DM5PR12MB1770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17701E8D80820D4B5616435C847B9@DM5PR12MB1770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ACGuEG2slgZRo/riEl9q2fiFrdWdutfwk7fs8RR7Hcv3wpQzNGOTg2tfgzbGVFnPksIfXwn21XSw/18hZbw4a3221Qb9EsVU31bMc07HFDjNbskQDH9hnh2ZJ72wxWDWRYNKvBec1EU9Pa78xclBC3bMOX5EJGjH8dH7Wft3WuLTNXvPifA+F4k1js3GEISuoLoDIeBq6lVQEPCx6Eo0FyPm8PQ355bafXFcg7kLrleXQwCv7GLvnT8RrHDWolYRVpmjO/8gcgQcwdaoBHVeAud0PObBi7oxXM4oGv0SnVUSro2sjGbxcSAvYTIr4PotLlN5ywq/7tNhBeDrLiZALuuSvzLgWkfYvyyV+xx4lNMRX5xwe3Qy8uX73/Hf/8tHK+bty8Xp2gdMKEzeBEnE9dGwmSpYa0nhdwk9SGHralebQyBdGDlE9OfkoKdBfwxv6dwJjWaUcCCtZHKa+6LJUdzOySqPkfitZOTu5PUP2DbkdrsnEef1HOkPGYT5VJPVQ1r0eQRHwt0NDyzT7QXOHSuTDBfLsZHcdnwgeqIJKzdTu1sqwDgpCphDswY5fP0CAuSbIWU+J6JO5/bRnmB2m1ptB9YvMx/Jr+UyTkIJAjpuaa3jkGT79nf7poFMpi7XmqUQBmUj+AgF7RZUWTRw3f+MotAzgupzsmeCQIbuVoc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(86362001)(66476007)(2906002)(478600001)(33656002)(7696005)(76116006)(64756008)(66446008)(66556008)(66946007)(83380400001)(316002)(5660300002)(6862004)(71200400001)(6636002)(6506007)(8676002)(53546011)(186003)(9686003)(8936002)(26005)(38100700001)(55016002)(52536014)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bb6YJJmXaihyqlIbHrPQYKuVEG3eJ/OohicWISvLyI/ZXDYW47gRDbOafZXL?=
 =?us-ascii?Q?HSm9oAaWk9CH2ebR07Udl9RLwBKBQRsEHPRHfa4zAppPxc8ciNnKkKrsP8gZ?=
 =?us-ascii?Q?UXkkS5+o7Pmb7l8gS054PcnPQNUcO5/AooBqUHZzaBtYwqw4nTjt3sInGxdD?=
 =?us-ascii?Q?Dn9QT0BxjcGtYwiAvBeFMiNK1FFWtBtbm2DnkSwIEFmSU3njXH+x0R3SdCBU?=
 =?us-ascii?Q?MJjACIb8V3JujrPB++/zWmTM6mMAphiN2XoXZLiDzjLId0awnvk/7PBiurfZ?=
 =?us-ascii?Q?EoLMGYcjMCGTtlydGH/2NNME8kn/QtCSkNJ7uwuazf1+CAW3AefRHOEW5ur4?=
 =?us-ascii?Q?1pejyoHFqEXwJtUbUgITksy/rUjJOpLMILJoJPge6rJQxeg9Psdt9V76hSWK?=
 =?us-ascii?Q?x7/OwqPgFq/QQpS3cYGzY9VFMv8oAKX1wJcQQ54zoB0j1UOJh5/L8SxAXKZk?=
 =?us-ascii?Q?aw7dExk4p7oduE004l0TaFz3nBMfP9rlB6MF4ciHW2ZxIaiXR69Ef3gEh6Fy?=
 =?us-ascii?Q?mnDsTPCCmNOed/qpysMrcxI5OpABHgiZ8/ONFK0z2C0yEmNFY9jJhVW2B/li?=
 =?us-ascii?Q?fIlUqqJJGlkYKOrE3K2zKAdM1aqrGBPGcUWX/4sxwUfKfrjQ7QIAHqJHdomd?=
 =?us-ascii?Q?8kK0a6Ve3nafPzkFIUIBbh5FfH5sT/eA3hC8iF1gHnpLHoN3dikEZ/a2q4pM?=
 =?us-ascii?Q?vhiYFJpjzhIHoOoDDgXEdiBs3iRMDRnmPsFgSHIvpokFOR1Pau9RqNmR6hUa?=
 =?us-ascii?Q?1ROTd15Vn8rGjLUYLRFMb4XphDzSgmn3fHhsWztjTW+mkvyoF/OK/n2FXE/L?=
 =?us-ascii?Q?o46w+66YxzzOnTO1gWqdmMErezjsJlyR77/cKJjauzvsYfi5dOaZ93G1/pHx?=
 =?us-ascii?Q?0Tgk0hOP3seHBxmJdwljto3zs4asRykMrk9XaOzsDvgOuFcSJEEUszN2WoaX?=
 =?us-ascii?Q?OBDOGBHy3hUHVhTI1ZNFLtSYhiC1Wp4bWep19YbDVgAWGfpa8AKY8r8PSGRu?=
 =?us-ascii?Q?bp0OSfsWVE9cT/0iCrrzNLFKwDl1UKoqzkJu3jtvslb+j3fLz21wP5r+4HJG?=
 =?us-ascii?Q?j6W7+Dkkp4WVPXmowVODDvaGbKb7EGzFiF4aCBui3G5CUaNtIZmGtlK/A33K?=
 =?us-ascii?Q?KdlHUOWS/avayELacCT4IMuGD31iXua/HQZtyz1h7vGa176neIn2HE6AGSH5?=
 =?us-ascii?Q?467Kv4U3Hx1pLqYWsCu0iJudsjgvyNE93ANaR0gxqmD/T1XIrsnCpyMspmD7?=
 =?us-ascii?Q?x9SyUsJbStMrklk7R0RabgtwF8aAXyd2xrvFJMS5aidLo+MRC4Yg9kNCHgQc?=
 =?us-ascii?Q?hQWw8ruX07laVmrJ6nHJL+D1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431bd82b-55f4-4cfa-68ed-08d8f4e9296b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 08:35:53.0728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dC2kHVg1ntPVYAuFv7PCL+aB7NzG1gatxU+gFo0nek7AOLtDfORo+3G6XttyPrnB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1770
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Deng, Emily <Emily.Deng@amd.com> 
Sent: Thursday, April 1, 2021 2:04 PM
To: Liu, Monk <Monk.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov

[AMD Official Use Only - Internal Distribution Only]

Hi Monk,
     Could you help to review this patch?

Best wishes
Emily Deng

>-----Original Message-----
>From: Deng, Emily <Emily.Deng@amd.com>
>Sent: Wednesday, March 31, 2021 5:02 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping ......
>
>>-----Original Message-----
>>From: Emily Deng <Emily.Deng@amd.com>
>>Sent: Tuesday, March 30, 2021 5:43 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>Subject: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
>>
>>From: "Emily.Deng" <Emily.Deng@amd.com>
>>
>>For vf assigned to guest VM, after FLR, the msix table will be reset.
>>As the flr is done on host driver. The qemu and vfio driver don't know 
>>this, and the msix is still enable from qemu and vfio driver side.
>>So if want to  re-setup the msix table, first need to disable and 
>>re-enable the msix from guest VM side or the qemu will do nothing as 
>>it thought the msix is already enabled.
>>
>>v2:
>>Change name with amdgpu_irq prefix, remove #ifdef.
>>
>>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>>---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
>> 1 file changed, 14 insertions(+)
>>
>>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>index 03412543427a..3045f52e613d 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>@@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device
>>*adev)
>> return true;
>> }
>>
>>+static void amdgpu_irq_restore_msix(struct amdgpu_device *adev) {
>>+u16 ctrl;
>>+
>>+pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
>>PCI_MSIX_FLAGS, &ctrl);
>>+ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
>>+pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>>PCI_MSIX_FLAGS, ctrl);
>>+ctrl |= PCI_MSIX_FLAGS_ENABLE;
>>+pci_write_config_word(adev->pdev, adev->pdev->msix_cap + 
>>+PCI_MSIX_FLAGS, ctrl); }
>>+
>> /**
>>  * amdgpu_irq_init - initialize interrupt handling
>>  *
>>@@ -558,6 +569,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
>>amdgpu_device *adev)  {
>> int i, j, k;
>>
>>+if (amdgpu_sriov_vf(adev))
>>+amdgpu_irq_restore_msix(adev);
>>+
>> for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {  if
>>(!adev->irq.client[i].sources)  continue;
>>--
>>2.25.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

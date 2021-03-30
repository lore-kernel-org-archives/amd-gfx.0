Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3915C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 09:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C686198A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 09:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C686198A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC886E888;
	Tue, 30 Mar 2021 09:29:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF856E888
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 09:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adT5wjoLybQ7wjKl8P2fJUrJ7ilZ34sRqDcVarDYZ0/hvk+rtzGV12p/sZSK8RrNpm0vZqAhLwwYO5RbYWJ251I6fK+d2ufilt4tyXJppXKseY1DPJDbQE5+grSSxE1X1R5nfRkVkCR7XbIkegmNpeAhcR0GXr44EzStE3715kq0DuWgYNvIzBTiE/Pbaam4hfwrAJB0ZsyYdCeEA03F8blGlwErPNtE0qtMEhWrBKIupil2yiDt1OaunNTUJ2gwyMnHIOoJArxo0jV/tuhpywDaZTEaG1vfJgfllcYn5Mj+49Zed2JPpxe8VA2w5giwR0krLKgNU1ArRc6PB/Rvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BVhsYmYxL4nPGRK/W3Jcptjdkh26YaB410npfLXRrI=;
 b=VI1HGgyWtaWnmM2Dn0xIfM5zOCs/opraJBKS6VksSnTMdkjTaIMTQtgTEAyZFU9VlgLG3MA6HxVcOCoIZOMmh1GRHJ3buILw2l+TX16/klsVCEQ3fVt5iN7J4eahdxYgXI6IMUPP89/5WP0g0aXNUAWkRHp3/xyz8MtfZDbrGhW09L0N1WFkpKpHr5ENdGdpKijSm7n7F4c5H6ptVgChbDJRnYdOTswPvdlpypAvAVhiSnPh6foywcQG08uGz+E+mgk074q63HopTwgFLjtJ05u4zI1mm18WjqnLq11ZP0se44iHek99o3Lsv4oknXrAXqvhztAa5dhi1EL9DJd1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BVhsYmYxL4nPGRK/W3Jcptjdkh26YaB410npfLXRrI=;
 b=lLs2P+I5qbPCFNTJsZxrQVgQpJuYi2aVbitMTgLZ8FCoJ33rGIRmI1y53ZJpovyndtYOX+ujOYO2w+7KiUGwGPg+o75Stg5HdjNZbipGPqJPOgcdKD1GcTf20vV8k/kIY/uiTZ9wF8tsmkbo2DTqhgkIGgYAayixt6IWs2lNLyI=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3335.namprd12.prod.outlook.com (2603:10b6:a03:dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 09:29:12 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 09:29:12 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Topic: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Index: AQHXJTy/ur4/DvyQa0GX3tgOhdxKyqqcO0UAgAAED7A=
Date: Tue, 30 Mar 2021 09:29:12 +0000
Message-ID: <BY5PR12MB41150ED0401BB65844C252218F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330081441.61418-1-Emily.Deng@amd.com>
 <53edd04b-97a6-3f79-16e3-9a58704f8e28@amd.com>
In-Reply-To: <53edd04b-97a6-3f79-16e3-9a58704f8e28@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=940a4fba-854e-4deb-a22d-42d593f73b46;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-30T09:13:09Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94d1db18-54f8-418b-2d55-08d8f35e47c1
x-ms-traffictypediagnostic: BYAPR12MB3335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB33350DE1D55DAD0CF2247E288F7D9@BYAPR12MB3335.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wsOiqdDC6+z9B4JWRbf8ZH/LRTdj7aj2YuwokGGPi5ROTO1SyRpnL4SYOAfkz5efm10TSjXMtFnbRCUXslXi8XFB+gA711B8KPm16LFFa9rpQQwPieGKJsL8bqTe2FBH6YzRMD5513O4FKi7hLPGgALdSKrbH55N23+BO8p0OilHtKGRyUBf+IlHCyz9OLUjr+H3FJdbuqMYvwYr7x4yoFQEG+XSPuTBh7RIWCX6ql5N/jlApInrDW8fNF+Wq9Yr9xz/ALpjmnVlHQvHOh3UuL92SOK1DL/qrBTbe+NLq4eErneobBUpb2A+AUJ6YavMKiOxRwnOCCA87PBf0LTOWBcXVivni7C++xkf5neXo3bw9F24j5qw43mZt0ypbiqiHXZCK/84nlWv4XGqw8M2YkIZ1P7278qir60PRFxTg0YUy+U28zDX2rgfwBK6rOtBfT6lvkDun/rs8w7nCvxvMBZpekR5JI/o1w1H7snehsvpQzGAwzduV/Kqizxh8HJrxNkoSie4DZCFsHGZ3onrUgVWnYlV5O27xd/M+oYiUZZSOXK3yg5Nwq3in0+2H9WOXKaaPCBHMtLBYE3mNHO0xUgnr+0Q9GPteB1CvLB09OFvehMc8SHPmW9gDBbGdHRDL1zzdKwlwV/zJ4WeNAt8fqnDtKJBbEE2/IKmTQrF0+w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(2906002)(86362001)(6506007)(38100700001)(110136005)(5660300002)(83380400001)(9686003)(52536014)(26005)(8936002)(71200400001)(55016002)(66946007)(33656002)(64756008)(7696005)(66476007)(66556008)(76116006)(8676002)(186003)(478600001)(316002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?dGRNL0pSbWVwZ1VFOFVYRVFiUlM5SzBLTE1icW9QOUtlcUp5Z1NKbms3bkFu?=
 =?utf-8?B?eiszZlpKeitNVDFEZmN5blBIbC96aG9XaldJc2hoOXloLy9TL0VNamJMVDRZ?=
 =?utf-8?B?Q3Zjck85TjRPLytZRkRmZnRJZWlHN1BCVGtna0pmN01sNXN5RGNlNEJMMXFD?=
 =?utf-8?B?KzBYWGkxYjBLUldtQ2RnNUthMU0zQmkwVEY0ZWVPaWY1OUNHbkkyN2N4UGVB?=
 =?utf-8?B?L1B5V3FmTUZSZWhGaVlmc29hQnVrdWVzRGsydWRGUFRQNXI3bG51bmVwRHpI?=
 =?utf-8?B?cUVIZVYzekR3THhiWTgraXJ6SjRGejVsMEtha29MY1RoMmJlMC9ZeUhmZEdp?=
 =?utf-8?B?Q29iS0I1NGRSdjNhT01RRVVvSnBjTGhPaEMwVmxvNHlRc2FYb1BvQmNSL204?=
 =?utf-8?B?YngzRnJzR1ZBbUpYZWV4WE8xSGdWYVdxa0pJSzJZTmdrbmt6SjB0NERvSXNp?=
 =?utf-8?B?UTFON016Z2N2TDgzVWw1QTVLRnZRM3g0SmhQbUdmeUxSZnBubWdMc0xDT2U0?=
 =?utf-8?B?OVJlWE13L2xweUQ1aFc5OFMrYUdXeTBwQWhGQ21IamNPZ2lmZkYrWFA3TmVO?=
 =?utf-8?B?ZENiU0pycElURVNkOW95QmEzaFZOWTRjdjRuaGxFN3lwYlJHTS84UEV4V2xr?=
 =?utf-8?B?Zk1CU01YemRScVg5ekVoQ0JFQkEyRGtRSUdtblpXUUVDZkRoNGF4MTVqc2xn?=
 =?utf-8?B?b0lQdnRkN3lSd2tjOUZ4N3ZabDZHdHM1ZERCMk5FNkFqUEVVSWRPbGovZGY0?=
 =?utf-8?B?ZDEzbTZZTUNpWUJhVkx2Ym5LejY5M2ZaQWdabVVKSTM3eTFvTjk0RjJJSWhY?=
 =?utf-8?B?WmhOYnFYdTN4ZXdrSTlZT1FHL0ZtS2VjQk43dTNEeWpYZDBwblFpV0ZsZmNz?=
 =?utf-8?B?Z0dPUTd2SHdLS1FlWXpDdVptUnQrL2Y5dUVxRVo4OWoxRHlqeWp1UnExdkNM?=
 =?utf-8?B?M1llYWQyMkVLUk1LbENpU1dneFR6emtMa1UwdGx6Q2lwYVpRaE9LckdpMnhv?=
 =?utf-8?B?M0xZcjlWclVlVzR6ZFozNlBaV1c2OGlOODlxV2R2ejNMeDBOWVVDbzZFa2ZR?=
 =?utf-8?B?U3ZFZkZHdDd5Z2YrYUtJMEljaThQS3hFbHlzQXVnbUpYeUxDRm1UQkFGZzNh?=
 =?utf-8?B?TVpTZW14bDBQOGlOUG43YlVUSTZtUE40dWVUeFZBVlNoNWNBb1p1Z0Q0Q0Zl?=
 =?utf-8?B?eFZkZUFuY1FmWStPY3FJTDN2SndLUG1UMGlRbUhubkFkamhteFdCSncxaWlJ?=
 =?utf-8?B?dXJpSlhFR1RWL1BNaU8xbExYU1phYjd6QTdHeDUyUGlMVG5OalBQOVR1WUdM?=
 =?utf-8?B?S1R0YU95SHZyOVV4NjhzZEI4QmtJMzNuZ3loeDhVSVFxT2R4OVRabDlqcTJq?=
 =?utf-8?B?V3lYSU9BRDh1c0ZvQjlLMU9JeHcra3pOaC9PS2NIbkxCV25Uemp6TFBEZ2t5?=
 =?utf-8?B?OENXRDBqZFJNVURocUh1RkJidUtLcUluVndtc1hXOU5rcWowYy9kakJNZEx3?=
 =?utf-8?B?Zitta3lXdE5LT21nTmtWNmtrWEdwbUkwYlhlcllDenRTTE9pK0lDN0VUUkc0?=
 =?utf-8?B?TmIxbUlTdVE0Z011d0NkRkkvVUhqNy91ditFWUVYdXNlRllxM2pML253RnNI?=
 =?utf-8?B?c2dFbWZJMVZXMVVCQUU2YXlpQ1lLeTRvNVMrQ3VWU1hsakJPVWNBSzcrRG1K?=
 =?utf-8?B?ZmJuRFhkTkFTMVZtbTZYRjNWRU04aUhzWUZwMnlaUVZJTmlUNS9TWFRjajAw?=
 =?utf-8?Q?rxKW7veB80jh6ZbnRO7oQUUt+TEPk7UfRYo6XNL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d1db18-54f8-418b-2d55-08d8f35e47c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 09:29:12.8336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/wieMQ2w3PUaz8SaH9UxAFJfXskAmKbpWNSTyEqXKLamCtW9ZzLcBXay9q/o8BP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3335
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
>Sent: Tuesday, March 30, 2021 4:59 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
>
>
>On 3/30/21 10:14 AM, Emily Deng wrote:
>> From: "Emily.Deng" <Emily.Deng@amd.com>
>>
>> After FLR, the msix will be cleared, so need to toggle it for sriov.
>>
>> v2:
>> Change name with amdgpu_irq prefix, remove #ifdef.
>>
>> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> index 03412543427a..3045f52e613d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device
>*adev)
>>   return true;
>>   }
>>
>> +static void amdgpu_irq_restore_msix(struct amdgpu_device *adev) {
>> +u16 ctrl;
>> +
>> +pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
>PCI_MSIX_FLAGS, &ctrl);
>> +ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
>> +pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>PCI_MSIX_FLAGS, ctrl);
>> +ctrl |= PCI_MSIX_FLAGS_ENABLE;
>> +pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>> +PCI_MSIX_FLAGS, ctrl);
>
>
>Why write 1st clear and then set the msix flag if we know that msix is already
>cleared
For vf assigned to guest VM, after FLR, the msix table will be reset. As the flr is done on host driver. The qemu and vfio driver don't know
this, and the msix is still enable from qemu and vfio driver side. So if want to  re-setup the msix table, first need to disable and re-enable the msix from guest VM side or the qemu will do nothing
as it thought the msix is already enabled.
>
>
>
>> +}
>> +
>>   /**
>>    * amdgpu_irq_init - initialize interrupt handling
>>    *
>> @@ -558,6 +569,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
>amdgpu_device *adev)
>>   {
>>   int i, j, k;
>>
>> +if (amdgpu_sriov_vf(adev))
>> +amdgpu_irq_restore_msix(adev);
>
>
>Is it possible to load amdgpu on guest without msix ? If so then we need
>to probe if msix is enabled.
>
>
>Nirmoy
>
>
>> +
>>   for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>>   if (!adev->irq.client[i].sources)
>>   continue;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

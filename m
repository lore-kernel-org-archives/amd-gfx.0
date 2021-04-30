Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF4FC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 17:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCED61458
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 17:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCED61458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A69D6E8D1;
	Fri, 30 Apr 2021 17:50:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C50A6F587
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 17:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6Ct4avGZ2Xze7EIA6k/zozfdaZ0MVyCZR6QQfqU+7RpViKhtShPUMUricrWi1YpX2U1IO54+PK6Wy0ZGeCboDOlpInB652C0pbwSTqh2GQ1XVqFp2vE6t+ZwmEN01/BBqTJuXicKyJla6kBzhiAHDOAwbk+7jRUCsYLf98LkoAGa7i/SrSGH8H3dRwRpQAOxVDaHLiI/PLK6DzEowDYfPZxTwCzxW42MoGo+fgRbr9H51Y4GU66HdveJsICHL/1a+3JuzR+KWH1hsFV41dTEqCYbOkA6yStDeQ1jDuNo7B23bcD4w7jSonta1HRm5naT9hvUSYctS5yPe5UV5h5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HCa3qi4e1e0TCGAE9DyveBVlhN8kT6KsbZquKuqlHU=;
 b=NQG46vq1QNbC5ruH1h+wnlS+XvqiuH6CvR6RUTizMsa6NDvmsPB6ClMbJ7dL4HLI7yswWJcddPnuvEdHeKIdRhDmtg4EObvjhr8A6M8UzboCta4t7Hr0lcTxuiqj4PhV9GUGYJNuGG5Ph6S2fkqThrAZdDs6miR8qm1Eb7RcQPOXzcyH8j+b32sE0dxByRYJfo3MzL86HptiLuoSnq3lGe1gB6ctTh6Wv+rYbPUnhMG0JCbnZI7N/lH11DtEf+keZob4LvHJAYm1Jqw/bMDPV7ytF0rmksvau9/k8RIpyGBwmohM7Gm6ByD2cWhDojVbR80b/ekCs+qHfES8KBWqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HCa3qi4e1e0TCGAE9DyveBVlhN8kT6KsbZquKuqlHU=;
 b=A8ZMjNK9xxmiO0V3afRs1495K79w1LrgRdjLPhiRQnr/s30fH76r3LK0W55sVkqYCy8BeOIJ/BeRJOvVIB1UuwQ59MS1fFO/yebKn8PdMvtQ4zKHG5IySqVm5CZ2tOl8Bx5EKJIehM2QaWLUrg+dunCNY/iAJOmlQxobKby1yQ0=
Received: from DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31)
 by DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 17:49:56 +0000
Received: from DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e]) by DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e%7]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 17:49:56 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Add a new device ID for Aldebaran
Thread-Topic: [PATCH 1/1] drm/amdgpu: Add a new device ID for Aldebaran
Thread-Index: AQHXPSZIgnt/JT29HU2lYdUZj9VrMarL0+OAgAAANyCAAYLGAIAAAQgA
Date: Fri, 30 Apr 2021 17:49:56 +0000
Message-ID: <DM6PR12MB33087D71C3EED74425A32326F15E9@DM6PR12MB3308.namprd12.prod.outlook.com>
References: <20210429183351.17914-1-zhigang.luo@amd.com>
 <a8683018-e0db-579a-943d-d4e08b053654@amd.com>
 <DM6PR12MB330837936F1191BCE7FD835BF15F9@DM6PR12MB3308.namprd12.prod.outlook.com>
 <308e66f8-9847-8910-1b6b-7c6ca662c70d@amd.com>
In-Reply-To: <308e66f8-9847-8910-1b6b-7c6ca662c70d@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c4bea019-3a23-4281-9bc0-051992721c3c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-30T17:49:01Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.8.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 539a9834-c4b5-4332-601f-08d90c005df1
x-ms-traffictypediagnostic: DM6PR12MB3516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB351679FC87587ED22398A089F15E9@DM6PR12MB3516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CcPuPs4IMW11DibHjoNu6BeozvJxm8/rkAWATHRDmXYA7um0ESN8GRW8IXxu4PBDetAx73oWrPzSUJkl2O8IQQEzSflVy54DU5wdVYCaXXJFgRCiLbaQBuO+po8QxZOPU5v5A7skEqHvhvT899pO2mppspxkG7f+cLMjN29Kzn/XnI1Zj9ZNpk+vSTEGpK43ijraSjjfAit6jfwxMWDBGdF2M/WsdCwXZLwjGLvARWOkCYxS5j1wVm0uNJBvwDCV/nVMjUEKYCMXoT62u6I37Ib+siS3HY+EgtCRiLQkPziRWEC/CwEoov4DZK+O4JHtpNWZj+JIxkxrOJTBkfZ6j8ToO/cuE6KBvzgk8t4DdM/yDYfB7SgAnwtZOyjKIpD2EGalSDlGozbC08EepE/bhZ5s0QhgrEC+/nyCU9HF+JV5PIEXutOT23MMILVmk4PN+ud6g33vlNJIOh6M8tI3+ofxGFKH0RQMa/t61hX92wDVg8u4o7lDLye5Ge2IUqXGziD4hjqS//unmwDJT7/3XfZWCVZf4iFv2qegzUEloz0dD+Qr5CozySMrb/LhxmZpY6rmlm2JK9pVw6MTHR1OKeFNhPv6+iF9iyowDICUhRcc0h5YdpEpoFqXP5I26QtlVIpN9UKPPvY0QEfVN8nlHUYfEUKtctSFXMo1/oEj0N9QhqDqw5MX6AtRJHU/kXU0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(110136005)(66946007)(316002)(122000001)(64756008)(33656002)(66476007)(83380400001)(76116006)(7696005)(8676002)(55016002)(5660300002)(9686003)(38100700002)(2906002)(53546011)(478600001)(86362001)(26005)(71200400001)(6506007)(966005)(8936002)(66446008)(66556008)(52536014)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YVE0TG13SjlTdXJWcFVJSjVSbndqRSswQ2lwRTBFQSttdExnWTIwL3p4OUda?=
 =?utf-8?B?QmRmZ1dOUHYrbGFWcTJYYVJxTW1jZCtWUzJ4eE10QWxUK3FFK2dOUUZqSEFu?=
 =?utf-8?B?cGpLQmFkNnFCdUpobDRMS3ZZMGpsa0pTSUtJSlpGeWlTQURsa1dyZDlMS0Rp?=
 =?utf-8?B?emFra3BYOVQybnhPWGt6amZqaFBxNFNqUFBSMXRUdmR3d21pUG1OaGNITHdm?=
 =?utf-8?B?ZytGRFY1eFJTT2JIWVdMZ0tmZ0d0TUxhbUJWbjVoTXFVRUo4eDlXdlVLUSsx?=
 =?utf-8?B?QVJxVUpURk5kUEFRUDE2RE9Janc4c09nTDByMVJPRkc4ZkZVWlVhb21Mc2pV?=
 =?utf-8?B?MXZ2ODR3ckYwMkJLTGdxR0ZUYzJ0R3liRW9yMVYyd3lrYXdVUHkyN09YbzBQ?=
 =?utf-8?B?MXdFM2czMjhTRlk0TWtmcnZHQlBKeHlqUjluVnhqUVJHNjFTU1JTeURPNmxw?=
 =?utf-8?B?SDZuRXgxWFlBU1FCQkppdFBjbmVyanNjZjhNaStqQnFlMXE5TklSN3VwdUsw?=
 =?utf-8?B?b0xjUVNBSXE3WkVuMHI0NURxdlgvTERXN1E1dVh6b0RsVlE4SmorVkNmcXpo?=
 =?utf-8?B?YkJ5bzhjODYwUG9QUWZTMzZndFVOeUxPVXJnb1FYSTVFbzU5S0l6aVJYaFRH?=
 =?utf-8?B?dFZiZUl4cXNhYVpKeWYzQ1VLb0JzNkljVytzVm1WeEpBZkozRmhSZkMyUFMy?=
 =?utf-8?B?NlJNT1E5Y3E1T2plcFUvMVR5OThOWXZiVG5USExXTFIreUpjR2orK1VmYjdZ?=
 =?utf-8?B?L0t6NE9PNElTbjNKb0dQUnltQ1JESnBaR25pVWJDb2NqR0kza1lBSVVyVTVm?=
 =?utf-8?B?Z2VhYXpPcDFqaDRLVTl5RTNRcFlwZ3pDcGlvcEZtY0NCSmVmV2VTZ1VFTXJO?=
 =?utf-8?B?WjljQWdGLzVSYjd3VmwrQTZ5MHM5MkNMZVVlakllektRK2ZJM01EbVJIbmJn?=
 =?utf-8?B?U093VDhFQzQ1ODlQSCt6ZzlBZlJPaWIzUUE1RDliaFRrSU9abmdQR0FyTDNk?=
 =?utf-8?B?VTl4bTJSTkl2eTFUWmhQSjJXeTJFSkIrTWlhSmJNZGR0Z1Nycm4zOTI4NVk0?=
 =?utf-8?B?eGJ1UjdZcUZIKzJMOEFyUk93OFFxeU96dHo1YzRvbVFaYjZtYitUM1Q4bG5C?=
 =?utf-8?B?REpVcVdpS1NEQ2dadm1ucjdZSllDSnlSSWMySDhtYm5zeGRrbEYvZTkyVFlM?=
 =?utf-8?B?eURGS1ZoSHFSRjhVYVoxcUh1R0w4YWZWODg0NDNoR2MxOGNqQTQ3a2VQWTRv?=
 =?utf-8?B?T0pYQ2xtQWFXcnNkTHRQQnNZL1gxV3hOandiRkk0Q0xHNTg5NE11Q2FaVk8w?=
 =?utf-8?B?eGJBREFXSnlxV29pUDVYSTlnSnBPTG1Pa1BZblhReUlubDZRR0F6VmFiTVB5?=
 =?utf-8?B?YkR0UnVDMW05V1lJR3ZRRWJjdmlrSHk0Z21IaStCVC9lSTJGZDdxMjBTZ2FO?=
 =?utf-8?B?N3ZpZUdmZzRPamt1a3p2QmJoTGJrcjRuZEJOY1Y5b0xYblVBVGZrMlIrdWZa?=
 =?utf-8?B?QzlRSUpkOVQyNzl1cEZJaFpQMW9JUndEckhtUGwwV3EzdlR5cVdOWTRxdTVN?=
 =?utf-8?B?TVBjU0I4WHpsNFVGWGxLcmo1WU5hVUhDRTEvYU95cDlvYUhOamxaTy95Mnpr?=
 =?utf-8?B?eVFYRkVPMDZGY0wzc1NYRERkdFI3NXFiZEhPRjlwcitDcTRweGtYankyWGkw?=
 =?utf-8?B?UEVHN2FnUzZReXVyRFhlTVVoOVFFMlk1cDcvbnlsNllDaEhXRFRvTXhHVEk5?=
 =?utf-8?Q?RfhHEODmgae0T1wqHK3oG9TnlpK4AQWZjJ96c/5?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539a9834-c4b5-4332-601f-08d90c005df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 17:49:56.4139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ri/PaTcW4P8RiCvUnpBqWJ2QlstmQ53V2eJH6UQ9uoq8kh0cStBlfsDaF6LXOTHX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3516
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

Thanks, Felix. The change looks good for me.

--Zhigang

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: April 30, 2021 1:45 PM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/1] drm/amdgpu: Add a new device ID for Aldebaran

It just took me two minutes to do this myself. The commit is up for review on Gerrit:
http://gerrit-git.amd.com/c/compute/ec/libhsakmt/+/518573. Please review and test this.

Regards,
  Felix


Am 2021-04-29 um 2:46 p.m. schrieb Luo, Zhigang:
> [AMD Official Use Only - Internal Distribution Only]
>
> Thanks, Felix.
> Yes, I will sent out several patches for Aldebaran virtualization support soon.
>
> Thanks,
> Zhigang
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: April 29, 2021 2:40 PM
> To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/1] drm/amdgpu: Add a new device ID for Aldebaran
>
> Am 2021-04-29 um 2:33 p.m. schrieb Zhigang Luo:
>> It is Aldebaran VF device ID, for virtualization support.
>>
>> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
> This patch looks good to me.
>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> I believe you'll also need to add an entry for the VF in kfd_supported_devices in kfd_device.c.
>
> Regards,
>   Felix
>
>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 0369d3532bf0..310e1249e64e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -1186,6 +1186,7 @@ static const struct pci_device_id pciidlist[] =
>> {  {0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>> CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
>>  {0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>> CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
>>  {0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>> CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
>> +{0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>> +CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
>>
>>  {0, 0, 0}
>>  };
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

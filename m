Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC99C48BCD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 02:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24272613EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 02:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24272613EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB2C6E427;
	Thu, 10 Jun 2021 02:07:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC1A6E427
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 02:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILD3OYmQjKKEj25KRnJT/asZgsy709GgrI1kgBinu0e06dMvfYpn/9p7ojoKHe/f77t9D1FaUsxZIcNvUdUFdwysRfUYPIPAtp048KzLQt++wcB4bmBoyhtqkPwSoadxSb0VUUllErvAmI28lybnxuVt/Ki6G518wlOaIvMRV1DCvcXj71sc/9CRbsglE0pIJmmiBXHQfue088Jna61Ex0QOWSeQzvE/X6zIgN/W8eL//yCWmpX7oV/S5Cbwfzt/wHY2FFhWrKChdMrFfWqFWw2BjBTk+A9nJMwGaXnKIsPVz7IkPhU3gDHnIjTWd7yFneCqsmAeAA2lJt1E39Ha8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCZF9oT4/5aGJKvZXmfaZwe976gf1xH6vhkkRmeJVWI=;
 b=eoNbZ+TSFJfkjWtPPW+rslmFqAHJXx6Pfl2wsc4yF8iN4VbkAuChwE3tvxQyImhbvCuZovEp2te6RiEVxc15E+nm0rCViXTdQTCho9LPFLnJRPW2lZwtkThboIfLmS2jIzfbVv6uDHZ5YApxUAGGjbr/pmaSFjeE2JJ/ME3tNobk1lWVLhLyzbg4EJi1fW+0ZKCCqs/MvlWYhIq1TQPejhzl5A0uwIiPR3hy+4zbzs9EPtkWcrIZ93r4GvSlhjgC2Ab1KsoAr1E5LFHVBoQhcaH4w7veF7f7/Nl0X42nwUCJwuw7MhfX8WKN/xq4mSNk1Vp8tQwG84GfZO2Cqax6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCZF9oT4/5aGJKvZXmfaZwe976gf1xH6vhkkRmeJVWI=;
 b=R2bHTIXMRhfy8F5StUkNKEhHa3dycFKoLcnA56Al7BF4U+RoQ7tmBOKcAokoljgIpsix9c0dbqnkN8CEDANgEYX0PFg4qe8D2fcDHo0PoNu/7lkatjHL0WXq0VJdmk2jCtzjxfkBFFbafGexEd9gkFfgv9aqM8QmzOG6Jnl07Hk=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 02:06:56 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835%4]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 02:06:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device
Thread-Topic: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device
Thread-Index: AQHXXREkewr9BNziyUm5RrCSEBKvcasL0NcAgAAYawCAAJbmMA==
Date: Thu, 10 Jun 2021 02:06:56 +0000
Message-ID: <CY4PR12MB12872CED51FB3C9426A97D8AF1359@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210609092323.32650-1-guchun.chen@amd.com>
 <CADnq5_NAfrOiHwx5D3SHsvvrzCbh_Rwju=AV8DT434oJm5vjUw@mail.gmail.com>
 <1a2a6f03-aa3f-a4b2-d49e-39e054337d50@amd.com>
In-Reply-To: <1a2a6f03-aa3f-a4b2-d49e-39e054337d50@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-10T02:06:53Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=af27bbce-8834-4af4-8c23-cb5ea9425a00;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1525a238-ea8a-4a5f-4266-08d92bb46caf
x-ms-traffictypediagnostic: CY4PR12MB1639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB16393409739932340A534AD5F1359@CY4PR12MB1639.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GeCZDrY8ZuAafl0UMmBDWPUXb7+YPDg5eFn6Fl5s9xEDpAlkO0YtPPMN2HCq4VJUWyOlWSFVxnKnWHE4fnol5fDBBSo+0N6tYdgLkBTWYDPGctS1queDEfNZvVlSP6WL2qAHgDkURhNsXQbo649p1suVZfTVQulZ009CYjCBRZbeGFBZ+ERGhu74SNBR/NKKge/RxixExnA+gfOi92DuB/b6lI8x5n/FD60yIKdmO/F60jYcM8X2R/x967UCqpEEKG/UYRTsMcDSkXlsKFi15V/57NfstH99q7zXsUrQjX7QR7kAEKag5zkmFsgDcwd9iNe6CYRn9svWvEQ8MBlx5dLYFZPSGdDL1vQln0g90qRQJLZYgU7lNMr7DeVu3J9f0E6VnUV7iAivV4u3UI3RT0xX3D+vauhxpa4rlzYfLoKj+mr9unOgdTbgjxKz/otHrm9T5Nf9CdFASZwt082KdW/r9Z2Ib4gKz8qYkaDV+JlSe8E5P/aX7gCp7d0g0NcOhrQuBR8q4b+kKGV010e37NaZ9opGoYngbySIs1hsXK1IiMjOv+X8XtyFbqQ4WRhfLYkkU4r+g2VhAQoWe0pg06Z0XGBmIQx0EtF8fJTUiGqj7PNUbsB5GzE/KQTd4XM2FKLzci9xqXCDOOqStSwnUnsOZNMn4z+UueNeMYHx4Ho7DV5nVa2pEgIJOzZb5TDiDM1c7lv78sfEnXdcsbEOLkpu/AlfR7wOp+fEQQwT9u0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(33656002)(71200400001)(83380400001)(8936002)(7696005)(6506007)(66446008)(478600001)(53546011)(64756008)(66556008)(66476007)(86362001)(966005)(52536014)(8676002)(66946007)(76116006)(110136005)(2906002)(122000001)(45080400002)(26005)(4326008)(5660300002)(316002)(38100700002)(54906003)(55016002)(9686003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTVLK3NyYlpUVStYRDhlQXl3Z0VLY2lwLzJoQ09ma2lwVkp0MlMwWUVyMVhZ?=
 =?utf-8?B?R0pGVVcxSkxEK0NLcldFbWpIeWw4eEVvU1o1eitkQjc2MmFsRHNYeERWWGVZ?=
 =?utf-8?B?eEhnMXZ6SVBGU0ZMeHBkT1cyRWRnMVhqTVB2TjYrVWhMOTBxSDNKbEtBbUhH?=
 =?utf-8?B?bnVjM1EwSXhteVgwMm5PRHVOSjlCZFJRbG0vbjFFeXBPRVpTYmZsZHdBQnJQ?=
 =?utf-8?B?NnBadlVZdDU3WXNaeVVick9BT0Q2MCtRMGVLWWQ2dVNvYmNlYkRrNzNHdkpa?=
 =?utf-8?B?ZFVkdG9BVno5UXkvdGNkVGw1OHpTOGgwN3BNYkV2U1BYMk5zTVQwbVhBS3Qv?=
 =?utf-8?B?V2UvSmRzMWxhbENFRkpmRHc3VEtDK1RISlIrQy9ZbnJDVkhDZmtnb0dUbVlu?=
 =?utf-8?B?a0xZTVNFNm1KMHlzNytzd1Bzc01qNzYvSXpacjNqSWdlNXdhKytuNUFrT3py?=
 =?utf-8?B?V1NIYUNHK1ZoWkJnRnd4aDBPaDkvQzA1ZEhrSkxRc1JuQ2FtaUVwSHFUbElx?=
 =?utf-8?B?dXg1TVhlbGlGUmxmbWZrTm43NkRhaFZGNUlPS24wVDRuWlhHWGJoRXNUWkM0?=
 =?utf-8?B?UzZ6SEpOY24rbDNMT0txdHVSNWk1dW1OUjd6VFB2THdtWnA2bUVCT3JvMlp2?=
 =?utf-8?B?Vzh5YnV6S2hTQ1dUOGsvZGZvcVpBRktjZG1VOUFmTC9USU9rTXdYMlg3QjBJ?=
 =?utf-8?B?ZHNjcEhaSkZZdDZHeHdaejVQZnJKay9PbkpMZFFMMHhYbnNwTG1iSlNDZE5j?=
 =?utf-8?B?UVFqRFU5Zi9Pd0FSbVRUSGhmeDFjU0IvK1lOVy9OWWpZS0xGYm9MQ1F6SnNF?=
 =?utf-8?B?RGVCUWlFbEtWbXg0ME1CQ2Q3cFQrV2E4aVBpQkdPVkw3M1VwdzFoU1h4bGUx?=
 =?utf-8?B?djNWbmpNZ1dVZFBIVEdjYlpFdXlsdWhyVDY5T1FKUWVyTm1FU2luMWNwUWpS?=
 =?utf-8?B?dkhnVnp3emtMQVdKaDcxRitLb1pML2ZpV09iSWpHWXEzT0dRNUNHNDYzTCs3?=
 =?utf-8?B?ZkpRaG9EMS85aHpvdFMxQTdNY0hKY0c1OGc4VXljdHZGS3ptZDl2L05weXk2?=
 =?utf-8?B?QlI0Z0djNVZ5c0cya0tCSEtNWVdubkg3U2FsY1daMCswQlI1UFM0aUliZjN0?=
 =?utf-8?B?RDZDR2ZMZkIwckJQSkxLbUJZb0pycWVHdXpUbEN3amZvNXVYNFRQbzNJa25V?=
 =?utf-8?B?THhIRlBJMDVGQ05yUTNDaFlQcURSTllJVDhYRzFXOEdXZndSWHREL2ZJaktC?=
 =?utf-8?B?eXdtb2hFUDlBck1DSDViOHNvblZvanBNanMyWCtuUGdMdXA5TDArTmRYZXFF?=
 =?utf-8?B?eW9DMHZPODBjV2hyMUpOcVNKN1ZmcEFKZ2JTV29kVWlDMzVlS1BhaDdZOUpB?=
 =?utf-8?B?bUhrdnRPS3BwSEtnSDJlMG8xc01FaWNDVklKSlk5NnFLbTJUTURiU2dpQlJI?=
 =?utf-8?B?dTdpMVBSYzBzTGJaYmtoMTZKcVZ1eHlET3MxVlQ3c3NZZ0Y4VDRhT1lTQS9K?=
 =?utf-8?B?bTBUZkxkaGhhZ08rYmRYT3lrRHMwb3daaWkrTWpFdTRPbFl5a1h2a3JKZmZK?=
 =?utf-8?B?YmMzSCtJNGh4OEVqN3NUbXZOSGxqem1RWWIvbUwyaGRva1FralN4bWpUdVps?=
 =?utf-8?B?ZUdCc0gwVGViSGYrOEJ1ajQ1NEsvblplQ0tJRnlFRkpVaEl5YTJ6MVVzQlBR?=
 =?utf-8?B?OFVRM0VaWXppTlluU1Y4T25zeXJ5OXllUlVNSzd4RWZxaG5iMW1mS2JVUVZU?=
 =?utf-8?Q?Swj/g50xIXZfqCPlUTXEGWZ8e8ME6MrYgFvbKNN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1525a238-ea8a-4a5f-4266-08d92bb46caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 02:06:56.5389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqkldIIhWaC5L58uVBgZS6e2VBJTaFBVFlo7CnPc3vhppVBCasDJ98AERKPQdLu/M6wOxV2r3Rs/XkuMt8SLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1639
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Thanks for your kind feedback, Luben, Felix and Alex.

I will send a v2 set with your comments addressed and RB added.

Regards,
Guchun

-----Original Message-----
From: Tuikov, Luben <Luben.Tuikov@amd.com> 
Sent: Thursday, June 10, 2021 1:06 AM
To: Alex Deucher <alexdeucher@gmail.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device

That's exactly what I said, but can see that 1/2 of the responses went to amd-gfx, and the other half to brahma ML.

Regards,
Luben

On 2021-06-09 11:38 a.m., Alex Deucher wrote:
> On Wed, Jun 9, 2021 at 5:23 AM Guchun Chen <guchun.chen@amd.com> wrote:
>> Fixes:
>> 9faf262c32d3 drm/amdgpu: Add DMA mapping of GTT BOs
>> 090f3a60d7e8 drm/amdgpu: Use delayed work to collect RAS error 
>> counters
>>
> drop the fixes lines and say something like use the adev_to_drm() 
> macro for consistency.  With that,
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 016815b7a773..fb6bcc386de1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -639,7 +639,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>>                 }
>>         }
>>
>> -       gobj = amdgpu_gem_prime_import(&adev->ddev, mem->dmabuf);
>> +       gobj = amdgpu_gem_prime_import(adev_to_drm(adev), 
>> + mem->dmabuf);
>>         if (IS_ERR(gobj))
>>                 return PTR_ERR(gobj);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index ec936cde2726..bfbcb9ff2453 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -2122,7 +2122,7 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
>>         struct amdgpu_ras *con = container_of(work, struct amdgpu_ras,
>>                                               ras_counte_delay_work.work);
>>         struct amdgpu_device *adev = con->adev;
>> -       struct drm_device *dev = &adev->ddev;
>> +       struct drm_device *dev = adev_to_drm(adev->ddev);
>>         unsigned long ce_count, ue_count;
>>         int res;
>>
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
>> ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7C
>> luben.tuikov%40amd.com%7C04e4afbe1642484eb15008d92b5ca67d%7C3dd8961fe
>> 4884e608e11a82d994e183d%7C0%7C0%7C637588499214061155%7CUnknown%7CTWFp
>> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
>> n0%3D%7C1000&amp;sdata=DvbjnGu0Lafx%2FgCIejsFJgMyngl9bKIvIdLjTngQrCM%
>> 3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

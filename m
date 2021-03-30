Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959F0C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 09:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38EAD6195D
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 09:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EAD6195D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC79C6E88A;
	Tue, 30 Mar 2021 09:33:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA5489E52
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 09:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbfgyE8yvVBQLrY0TTRgnFgsFNVD4ugciePOjL6cGrmAf889wYqWx77ymaCZgPxVmfLW/ZuZRHQ64GvAnDKxBI7OWHRAVS4w9lgDrCAaNRyyTz5yr6N9pg4b79NJZRpEXBek42SHBEFwe/FYP2GAn7VwMDfrarZCOsuYGJ84RjdQPvMGlZmgcUU9LMMAbbx5m/2u0thal73D+rmL/QhapQD7NmTptFz2Oq+Z2yXuUD2AqOtltgOVhJc7EFWWIBIuQ2p+lOh0hOqmu0DSLgD2vMGNovYPlfiLhgsynAJiFV3dfSRsUgw2snLjeBBTetiFvWAuGWOTJFkLqv5QcaShbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDjq4ZVnCYrSdBpAmPx8Ard2eo+pqriS/wWua2QijgE=;
 b=AB7DJNEvFEkSYlT0Rt/yrWwCfUzTQmMQQcbpVAInCkzgQQjraBP5sppF6hJFUNqZisA0OugsN29Zn3FsVtNz7pA0rROlv/8Jo0M0boihe9Q5G+RY7D1BZeps+xgvoZZq0xXe8lhZ3+aMDp2GJYllSHiMPdLp+LWGK1+tbrjMkQseTTQyI6HKii5N05gPXsPa5bvD1m0hvgstO5KFXuXdvnTkbbbvtMyQZ9Sp343cvFKgXoh8r2GQiv+2PmvwP65M85XNfFYHKnynUh8df6DL+OED+PWZuFt3Fx3ryYpWnjdhE2kpQlqAHJw+smXREOacS6nE7DEdn5SxOR2VDa4YJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDjq4ZVnCYrSdBpAmPx8Ard2eo+pqriS/wWua2QijgE=;
 b=nhjFdlW8K0h7SVILWTaxeazmhL7nvy8uSdo0ZF+Vj0EWB0ymWrshv/3gvMnjPxTkEcST5a/Z4sy/cPG3KHH09QW9boUhvcidImb7dk3zns9dQvpuXRotWWay3lOPegBcneaTmjpmhngcNR00tKror7/RyGeJX+q2KVyxyfZVq60=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1829.namprd12.prod.outlook.com (2603:10b6:903:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Tue, 30 Mar
 2021 09:33:41 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 09:33:41 +0000
Subject: Re: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
To: "Deng, Emily" <Emily.Deng@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210330081441.61418-1-Emily.Deng@amd.com>
 <53edd04b-97a6-3f79-16e3-9a58704f8e28@amd.com>
 <BY5PR12MB41150ED0401BB65844C252218F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <539f12e9-1bcb-23af-4a07-3b9ad5061385@amd.com>
Date: Tue, 30 Mar 2021 11:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <BY5PR12MB41150ED0401BB65844C252218F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:408:fa::29) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.5.65] (165.204.84.11) by
 BN9PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:fa::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 09:33:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1b67d90-ab48-4bcb-d6be-08d8f35ee77a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1829:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1829B05094D04384070D3C848B7D9@CY4PR12MB1829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOXQ3FfC31+X6n9rbW7uI8XetvsVKabirvU7SKilyPCclUnp0eDJSxt/cCJwWfyMe1eeq3UyBkmn6BD0xIZRw01WE1f9NSnlh2UZJyCFveX6L8UiSq/wo1J217mTNSru2EDp+VcLkSqZv5JuXtnuRUwQxAUo7lnisP5sOZjVVEFwgG6+Ugp/u2M0yxTvgj3+BkuCxikn4KeD5ku6mkxgHthhoUqbQEUcRdfps9QkBYI16W2BN/QofVww3BtPInq9b48Ty4OTPyzGKqxP0bc+XlkKoTb7DXyLs6Fdme3axQtpC9evelRq8AExDxwuq1DU5CsWpqmdjHoXIHbBqSHsvw4La1yZrsjSsggvuqzUb+MKibKMqb3/6p7bMePwwddWLjlegvLjw0bj2HsphWc5zNiPS2OWM7rhEKvA/YOUWRKZmami0XiCYDGBPpu9g6oLkdolrAhPH5dhqNTB2/iWYkp21N7a70WdTA9p7XjCL4ys410Y6KG0Qt7zj0hsY5H/xDO4SbLya49R5fGe2+la8Wy5rHZkoV8+EAICsnsn1pfYNTHPve0ygqPFCYYv4Bozq5Sl4cjEDb0CLnK3OrpvBR8zGU4eHk/fKMa5G251se9GeM/SPZ5iByN+Yw6OUFa4rdMlDZZSEEFUc2794I0XtXLDzCq+m5oTozbL8A91ystgB9OJZqMpJrlz74FwJKeq/MqkbtIUwqo9WUIGWWI/2P93ZLDaATmlUd4zYs9crgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(110136005)(16526019)(16576012)(316002)(6486002)(8676002)(478600001)(31686004)(26005)(66476007)(66556008)(8936002)(186003)(66946007)(5660300002)(31696002)(2906002)(53546011)(38100700001)(36756003)(52116002)(83380400001)(956004)(2616005)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aG5Id1RabjdGWVJUejBsUVFNclJhbEczcmc2a3hBc3FDaWRZaFJQOHl1aVlV?=
 =?utf-8?B?eld6YVVvTEJnMVFGeDZvc05DSENYVXdYSGdpN1RaTnZ2WVhwUmxRdU1la1Fl?=
 =?utf-8?B?M1RMQ3ordGQ1S1Z3L2FOU1NiWjlHYUtpc1JGWnU2K25Ud2dIME5oR295WC9l?=
 =?utf-8?B?V1ZBeGJlUDF2b3VneTFRa25odG1yODdvMW0yMFd5SHdsRTRNNUV4WFNxdnNH?=
 =?utf-8?B?OWVmR25FTU1jdS94WEpLNnd0dUlmYUljSTBHSGRhUWoyR3ArYVhNSi9iSnBq?=
 =?utf-8?B?d3pQL1dLMnZYU0IyYmRXb0dSdUFlTSt4Ris2eDhzd0lxcEowU05qbkNSai83?=
 =?utf-8?B?QkdxVU9mdGpXV3ZqcVpsRWVXVXlhWG43WnBzZ2haUmxPZnZYZ2lYZzdWSnBa?=
 =?utf-8?B?SWpaNWpiSmtpL3ZrYyt3TTEyVE4zR3ZvZFJlbi81cFJsT2Q3MXNHYm9MZFRY?=
 =?utf-8?B?S2xnWnJuelhqbnRYRlE2eFk1cWNPL3BWOVltcE05d1p5U0RWZkN4OTFRTUVZ?=
 =?utf-8?B?T2FkQjdJNktvU3hIUDIrRnN5S0lQdzBUL254aHJXK2VZV01TOUl6Z1RELzJa?=
 =?utf-8?B?bER1RFdObUt3Zlk0N0FNYm5aa3Y4cjd6d1QxNVlpVlF1N094S3JiOFRXTWVF?=
 =?utf-8?B?ODd2d2lzUjZ3aFJqOXVValNyYWd3c2JmREIzM1h5YXg1OHF4QklPcS8wK05K?=
 =?utf-8?B?a0dxR3pzSERSTUJEbmdEdG4zTytkODJqNTBEeWNvWVNhSDFLLytpOVRMZ1gy?=
 =?utf-8?B?R3hqMG9tNmg5a2Y2ZTRuSENhZEw2UUJVTXdWYjlpbzUzR2l3SU5BYmd6L29s?=
 =?utf-8?B?Q0tsQnBRQWt1OHl1TjdNVVRPS205Zjg2NHEwV3NORHdLR2ZLVTdRTExwc21N?=
 =?utf-8?B?Y0d6cGI3bG5zWWFNL1dSTkhVdGZUSG9vYlVmUUdKUWVxZFVkRmRxOFdmRkhH?=
 =?utf-8?B?NVk1WGxhUTZrb2dmcy9pcVhhV1BwelQ5T2RkRUxGTGNhellNOUR2amNNdjVx?=
 =?utf-8?B?MXVOYVZPeldKblJlWkNrdWhtWEpVMUgvRCtrcHd3SFlhMldrSHB2MHN4S3dF?=
 =?utf-8?B?Nk9SODNJaVk1bkJnOXBmYkxHKzIveEZlN0dFY3d2bzlhZ3BsMndpSTJNbmdD?=
 =?utf-8?B?M3Q2VmJIK1M3SjlxVlg3Zkxac2dVYTFKVFJDazJ1bERyQlNLQW02ZDRDamlh?=
 =?utf-8?B?WkJYNHNrSHArMEgxQWR5ZEsxbVcrcFRxUk81N3hhU1hZMm1Mc2w4TlhXUno3?=
 =?utf-8?B?UzllWjFrRGhZbVhYRldmdmJDeHRjd2VZV3VuVXBqditmMjU2eVFqdyt2WHht?=
 =?utf-8?B?dER4RysvRzZIUmZ2emE1Z3UrMFJ2WkJDYlhWR0FHeERkMGxOUHlaaUlya0NH?=
 =?utf-8?B?WVM0Y1RwMmVuUzNSd3lnVktYeWUxZkhWTi9ITXNXTEtZbzhmMWVoU1I1STZW?=
 =?utf-8?B?WkRBSnVIaVZCYzZMUS9XNlBPTjZuSkh3R0tzNTBCSUpPRTVOcG1DV0h1R2Fw?=
 =?utf-8?B?N2laZUNLR2RyMy9qVnhyTXNtQzNGZG9kcjV1T1h0bEppZThpdGdoNkNwVFdr?=
 =?utf-8?B?cHBBRUpreTgyZkx1QnorR1dVK01hYmZmNTF6L3d3aloyT2tXWmNvdC82Zm1M?=
 =?utf-8?B?dVpQQ2U0NkZVbzd6b0VBY3pncUpDMXhQZWdqMEdWWjNMV1d1T05BcEF0d1dn?=
 =?utf-8?B?WUJveHIzRUFoNHpvU1pIcitPZzZVNFJEaUlUY1gyK29RSng2R1RWNk9LZ0ht?=
 =?utf-8?Q?jhdVtXivYnPRzDCXAsteQaFaiWbdbbBew6gPuK0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b67d90-ab48-4bcb-d6be-08d8f35ee77a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 09:33:41.0587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqbAUhESQaYS3iFP7lXTEibKnBXn4BaMjFYYHZexmeN6qvjbZmMIF6af+Ens6CRCn5vctM1sPmh9bDsO2f21SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1829
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/30/21 11:29 AM, Deng, Emily wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
>> -----Original Message-----
>> From: Das, Nirmoy <Nirmoy.Das@amd.com>
>> Sent: Tuesday, March 30, 2021 4:59 PM
>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
>>
>>
>> On 3/30/21 10:14 AM, Emily Deng wrote:
>>> From: "Emily.Deng" <Emily.Deng@amd.com>
>>>
>>> After FLR, the msix will be cleared, so need to toggle it for sriov.
>>>
>>> v2:
>>> Change name with amdgpu_irq prefix, remove #ifdef.
>>>
>>> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> index 03412543427a..3045f52e613d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> @@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device
>> *adev)
>>>    return true;
>>>    }
>>>
>>> +static void amdgpu_irq_restore_msix(struct amdgpu_device *adev) {
>>> +u16 ctrl;
>>> +
>>> +pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
>> PCI_MSIX_FLAGS, &ctrl);
>>> +ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
>>> +pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>> PCI_MSIX_FLAGS, ctrl);
>>> +ctrl |= PCI_MSIX_FLAGS_ENABLE;
>>> +pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>>> +PCI_MSIX_FLAGS, ctrl);
>>
>> Why write 1st clear and then set the msix flag if we know that msix is already
>> cleared
> For vf assigned to guest VM, after FLR, the msix table will be reset. As the flr is done on host driver. The qemu and vfio driver don't know
> this, and the msix is still enable from qemu and vfio driver side. So if want to  re-setup the msix table, first need to disable and re-enable the msix from guest VM side or the qemu will do nothing
> as it thought the msix is already enabled.


Thanks for the detailed explanation, Emily. Please add a comment so that 
we know/remember why we are doing this.


Nirmoy


>>
>>
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_irq_init - initialize interrupt handling
>>>     *
>>> @@ -558,6 +569,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
>> amdgpu_device *adev)
>>>    {
>>>    int i, j, k;
>>>
>>> +if (amdgpu_sriov_vf(adev))
>>> +amdgpu_irq_restore_msix(adev);
>>
>> Is it possible to load amdgpu on guest without msix ? If so then we need
>> to probe if msix is enabled.
>>
>>
>> Nirmoy
>>
>>
>>> +
>>>    for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>>>    if (!adev->irq.client[i].sources)
>>>    continue;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C598C77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 16:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A275510E10F;
	Fri, 28 Apr 2023 16:24:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D173810E10F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 16:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOm1SP1mpdLoIroCPCdF3CxTWzUY1O8pKg1aliChOYm4kQSxA+pac0HekjviGQSLpxWzxV1/1odoTNgQq5m53q7qn9pkF93IY2FqHFH5rQrduQ1Kg4lS5yeYEKh/R6nIykENYoqOYvbpg6SqAcSYpl08Fd9saDdweBam5Jz4ykeLRi8CVNtm25percANiPkJyPfpM269b5DY8ulnorMEHXi+hstNW/2idpynGvlewg6QgOXVc58BCayiCSUICr/6EY3mPaPEtmGcrYRdNWhmTj/AoKRd23egNby04qMuVok4lIPEQW0amHXVHRVelxdr/5o+Y5n1OpjjRKP4aLxj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEeZHpL/yadfEdy7YR2iZc5FRjXUyopAVvZQH+zAYlc=;
 b=QqCKyWamH0liiduSGosk/lWes6pdyVqrev29cKzrPG4rGMNKFAjms2r13keUDsClElK7J3mVXbBIe2b+grzPmQZw3ZOdtFdGzgzOSq28XkQvUfFHKhZvl4lUBrb5fPsvWqGmrfijZZ4HEJN/w17HkE33fEX3rzr1DRfyIPImD3TSNy2MXvOj/rFsBYtKX/EZ2dZA++r7AAG+VChKzW9kape5Gs2oU+eMeYX7COG5PSsJmB/LRwDBp8blcEr1fQ3/ZFnbXiVXGszCOmjHLbgd9dJM+wxqzFeHBsMdk8KTMjhMnarAUS8ENPwib/+l1WEp3AcbEyFe5w2xIdgaEPTyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEeZHpL/yadfEdy7YR2iZc5FRjXUyopAVvZQH+zAYlc=;
 b=TxOOI81bPFF7HM4oKPVMJem2fBMUNwJk7Qi+uTlKHEAcW0y4bWoaulH8zhIQRUgiexuDf7dUiMcp/rpx4VX9J2+8hEOqUXjKDpSOm/nOZiT+97pVecjTnCdGAWy4f1QyTCWTv0dx3OUwfJuliQJwPpcCUxTqAbkMlSkg+xiA/g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 16:24:24 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::2b62:38ab:7af2:a4f6]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::2b62:38ab:7af2:a4f6%7]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 16:24:24 +0000
Message-ID: <e0dce26e-8f1f-bc14-2020-32a85fcbdc59@amd.com>
Date: Fri, 28 Apr 2023 12:24:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdkfd: Optimize svm range map to GPU with XNACK on
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424193808.10383-1-Philip.Yang@amd.com>
 <a893e01c-af20-e591-35cf-6ec708cb9cfb@amd.com>
Content-Language: en-CA
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a893e01c-af20-e591-35cf-6ec708cb9cfb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b4d048-2fe7-4c10-92b0-08db4805078d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Wb1GvKD47FkTrHcBD6FMtylIY44iC7YeqGh5ddkJXf/UQyF9EG/PBpmGOXx6cJ4VKfmBQHvXKae3daE3wMzK2zNc2vhRRvjcQGkoYNPkiV6gjNDRn7zvzKTsHkbBxzo5yb4+yXjg7/IGhXvdKPzQRMdSfcAiZ70GNSfnwELVys70hdOw6eqdcR1flXOA/HgcwmG9L2ur4xcOwlPn+TjPyJT+EhVMScunQacenuX0foKLJzUvRz7HU+GXk47wHZJDw9Zhj1ITxttDkH8fI6bWHRmxf9yn5wK+86YxuU775YWRquapGp9jjjOLCgXnALxofs4GVOYWB0N6CSLj5nhXGO7olKAfcOZFTobiwOkUfIpnjxVf1GaFoXbMbC8dOMFOY9ruQEBZSXlilaSwnhtvkR7+Lk7EoTeztX0VGwASoj03Q7LNvIednVsSu9tONBcuYWTASo2pBM9+ASybV0ov9xG+8vzketAQQfiUwVRfXIsCfjXuvN37L1xGsIkNal7/2KuLtdZkXTPHNt2bZQiBgliQnjLTJZ9/9JO2uWwlt0l1Ad0bJ4o10H9R+IFwTVMgJ73L4zEUAlw9k9SVPqg4OP9eYBmPZnlUuFRcvAk9f5YBasFyFrTKNa4fYvaEJtBI9eEI8L5Pk5X4lmX14OfcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(31686004)(83380400001)(2616005)(186003)(6512007)(53546011)(6506007)(26005)(31696002)(316002)(66556008)(66946007)(41300700001)(2906002)(38100700002)(66476007)(478600001)(110136005)(6486002)(8936002)(36756003)(5660300002)(6666004)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3lpQ1djbkh1VTZ5TTBJV01QUENqdzdhdjY2a0VncmxjZXJISnIwRktXRXk2?=
 =?utf-8?B?VE1NVTN5SnRMaC9RaFZ5VVhqOE9zYlRrdDBrdFoyV1BtM2dmMU1ORWJEM1JK?=
 =?utf-8?B?d3RPOHhKZGRoSTNOcHRDc3NPd3kzMG82VHJzTEJUTnBMRDF5SU9QMkN0bW53?=
 =?utf-8?B?RWNIZDVDclhUb2VJOTJqdDBCaGprRW5pNnA1RE5vZHNTcXhiMDZoS0JuV2lP?=
 =?utf-8?B?OUpBOHRaYnN5QWVKOHYvOHhlbzJtRjVnSG03L3A2OWFnMTRFamtOTkJoU2RX?=
 =?utf-8?B?QllGbi9zOFJXd0hCekhKaW51UmF5UUQ3bGhqL1pVektEN1R6M0VtTjNWMjh6?=
 =?utf-8?B?MDhXanNuajQ1bnRjMTRKZXJNZkRPdjF4dWtQdlAxMG9ZS3NWcXl4ejJRMllk?=
 =?utf-8?B?b3ZHMk5TRER2WTlqdFdPdFo0RlNncjdVbjFvdjcxSk9QMVhSUE5EeFlCWFk1?=
 =?utf-8?B?emF4RFdsVDUrakk0NDJpQXVkWlFuMFdQRnBmVjhTcDFnWE5oWjFzUEZCVmF6?=
 =?utf-8?B?V1BKRTBRNm5oSGZCVjNNZTFWZkdMTktpc0crVUFrejdRYnR4aXdGaEZVc25B?=
 =?utf-8?B?dWwzWWtWejRzRm1DV0RTNHY3MlkzeHVMQWJ1dERqcE5NWUZnVnBMREFTT3RT?=
 =?utf-8?B?SWE5SElGbnNDZjhtUkk0NUduSmNUV1NVNS9FbHd4VkVON2l0R3lkRDM1d2dD?=
 =?utf-8?B?ZmE2YUI1U04zNmgrOUtHUEtWaWV3SmRldUMrYmhKaHYyb1NOUWdkdW9BTmpm?=
 =?utf-8?B?ckcva3kyQm1XdHlvai94eWJBMURUS0hHYTRvUXNsRnV3Z3U2ZFozZjBUUGtx?=
 =?utf-8?B?WW1EZkNsZ2ZJZFJQdkFzbGIvWUFuekJBMm9WdlNlekFBaTBSWmdOYzJVdUlt?=
 =?utf-8?B?WHk4V1N1UEF6NVJKSHQwb0ZqUmFBTHJKK25XbDlha0RvVUkrellPMVFDbnBR?=
 =?utf-8?B?d1hQZm9CKzF4MHg1b29hWVQ5ZHJNRlNoMEkvYmUySzhTYm43N3hXbzk1U2Fp?=
 =?utf-8?B?dGJzZmUrc2p2anJQeWxiOGtKaXI4S05VbDl5N1hmTTU1Z2x2cmE1WkFEbzMz?=
 =?utf-8?B?TU9ETTNhYlhCQVlXVk5xU2lOQURDQ28raGJPZm1Jam8xR2o5aDJIYWNCdGti?=
 =?utf-8?B?bkJFYXF0VTJ4QXdabkpEYVBJQVBoUXpqZkZ2WVRoM1pKdDZMcXIxc0pTajZx?=
 =?utf-8?B?QXY0dnl5R1ZrcEtTelBSQzdXalI2aFl4eDMyM29rOGFoNG4xejUwRFhnR05M?=
 =?utf-8?B?Z3N2eVkvaG1GTW1XT0U3dGxGWjFDR3p6MHBGYnBoZ2g1KzU0OUJqYm5kU1Mw?=
 =?utf-8?B?RnNyK3FmNUc4OXNRTEpuakJRR01EWlBta2Y1d0ZxdmFjV0ZVY3lSZ09sZndy?=
 =?utf-8?B?elFRS2NNcSs4azFHbUlsYXZtTG9KbTFmSGdtSVhPK1ZLc2JpYXlNSzl0cGI5?=
 =?utf-8?B?Nm0yOU5PRXV5QmRSWlNsa2I0VWhmczNWemZnWlFKY3FhczBWZllPVnVtZHdQ?=
 =?utf-8?B?dUEyR3pZOE9GLzhvRVB4bVBHcEZsRDh4N2tUOXFMd2taVGp0STdBY0RtaDJL?=
 =?utf-8?B?Q0doVTNZN2dPd1VOSTVScDBYSGx4bk9YN3ZhNThFaEZYOEZ6dVBodHRaTFNm?=
 =?utf-8?B?V0I5ejUrVlEvT3p5dXB1THR5dUtrakc3SG1ES0xScVZwZW5rc1VFVVNxbXp1?=
 =?utf-8?B?bWhtQ3huTzNsMTB3aFdUQ3VzMStZWWpFZW9PTEhTZ1FVb0IrbS9PZ0V3dHhl?=
 =?utf-8?B?dWhVK3FEWFpzUEwyOEp3ZnFHZ3cyVTI1SGtiV2Fja3JWTGdaTjcycmlsQTUz?=
 =?utf-8?B?WDA0VzMzcWxHdXFuOG5WOExmMUhkN0NHV1haWk9nbWR1N2MxWXJwdExZT0l6?=
 =?utf-8?B?d0lEUk51UklVaGI1MFZ6c1RGa2JrbHgyRXVPbU50dzEvK1VLUTkxRmY4RllJ?=
 =?utf-8?B?MCtsTDJHdmFuYndhcThlWWdvVVZoZ29JeVZoVUlUZ0VxaE9BNFliVjE1N2ND?=
 =?utf-8?B?dkx1c3JDZmIzeHYxSDhSQ3A4QnJXY3pvSWxVR0lMeENySnpqZzJ4ZEFCT0h1?=
 =?utf-8?B?c25YME9Gc0lLNG42eW05WHJJTWl6S0JxMHFwQUtsbWw4WmpuV2F2RWtpelR4?=
 =?utf-8?Q?6neo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b4d048-2fe7-4c10-92b0-08db4805078d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 16:24:24.3678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EG0vjekuGUIPKsUaIiFers/8KToUw9tpmsUT3v91nyA5HS+y1Op3MzWsXefcuBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-04-27 12:35, Felix Kuehling wrote:
>
> On 2023-04-24 14:38, Philip Yang wrote:
>> With XNACK on if svm_range_set_attr set the range access or
>> access_in_place attribute, we don't call svm_range_validate_and_map to
>> update GPU mapping. This avoids prefaulting the range pages on system
>> memory if the range is not prefetch to VRAM and not mapped to GPUs.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 129ef44f41e9..af7594b1b4c6 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -734,7 +734,9 @@ svm_range_apply_attrs(struct kfd_process *p, 
>> struct svm_range *prange,
>>           case KFD_IOCTL_SVM_ATTR_ACCESS:
>>           case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>>           case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
>> -            *update_mapping = true;
>> +            if (!p->xnack_enabled)
>> +                *update_mapping = true;
>> +
>
> For NO_ACCESS we need to update the mapping to ensure that the PTEs 
> are invalidated. For ACCESS or ACCESS_IN_PLACE we can leave it for a 
> page fault.

For NO_ACCESS, there is todo comment "TODO: unmap ranges from GPU that 
lost access", this should be handled by another patch. This patch only 
address that for XNACK ON, we can setup GPU mapping after page fault, 
without prefaulting and mapping to GPU for ACCESS or ACCESS_IN_PLACE.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>>               gpuidx = kfd_process_gpuidx_from_gpuid(p,
>>                                      attrs[i].value);
>>               if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64437C76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 08:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E404910F129;
	Fri, 31 Mar 2023 08:28:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B65B10F129
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 08:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfiYGuoUZ9sNpCxMq71uYlOI26kyUTvFiHG0Z8nF1U1WprA/JHIFnxeM28iN2/MQSZoQI/gGhdp5ir3xj/hlEd4kyDJRv1Hn8PICA5zMOvbBnmmLFy00OIT9cboUcIvEGgqo55BcuEfGd1SXFA13jTFEdF5Yz30Dw9+Oy7lObjKtZDip7zslsmbhrc2F0a/1/pXotlwk7FW/+fgzfT4hBF/s1CpgQcxfe6T5l+FmfJNHbGKZx+D0h2hRdhV0pLAyeO99MLpofUxQ2UPZZTHApicGpbe0GyuWxstSepeGKdiRnMT1ARIHbxkodxa/Qpu0nEHSSsXtJf889HfQniZDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQpMavwUqeO7bDXxzZFJhV/f8vdzZYj5+eKBOm5Lku0=;
 b=JHXeNRRXSCZSZyGaPx+qMQmdLJcz6vGYom746xv4BP8Y3Iwp9Ft8rMlaSJzv3Mhbr8ZSVZtcqBSTl/KMznFipXB0QpAtGEj2/QGi5V+YJH+LBHznFcnuGuHfQZxfQGYOxtIcXS+U77tKM6DnzXFMI0clqtvcAdZ+VhhTSRCF0bP+aV5ZFoIPwyp0AJDDWRsUaCkkrRu7Qddx4wWyEiZB3Upeot/TtDapHS4/sUVELwECediFdEl9VKb89PyhddewZkxBlhnXWBlmAzez6/DRkL0HS+5KazOeHSQ9eprdCJteDRsKlyEuIK/myugukZxDXhFGDN0F50t2FKX50aAG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQpMavwUqeO7bDXxzZFJhV/f8vdzZYj5+eKBOm5Lku0=;
 b=eHo3jUc1glB/kEuy2OYeEn5OaYuCivENlvaUAiKFI4xVMp7Wm+swvdpTpudq9SsnEud7FPei17bZ3IL/N7oB1GiQsYUGo8HF89VaHzIT6Y+rY2G/AzaxD/2wyppSG6baT7wtBqvtOVXt0anVcWTY4bUjaUr1rQHs+M9JqoPmhgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 08:28:19 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:28:19 +0000
Message-ID: <933db25a-2acd-eae1-0c44-1d64bcc7a6dd@amd.com>
Date: Fri, 31 Mar 2023 10:28:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 13/16] drm/amdgpu: use doorbell manager for kfd process
 doorbells
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-14-shashank.sharma@amd.com>
 <CADnq5_Ow4ehDKQEdkqndkXFq093-1k5GwPLAvurBzBb2ejvfjA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_Ow4ehDKQEdkqndkXFq093-1k5GwPLAvurBzBb2ejvfjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: efe4896f-fb4a-4b4b-2829-08db31c1e217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2I1t8iXwU07rCMMt2XjyPgUvuptVRC157h/5jYktTs85ywW7S0SDEZFgrtOiQPoz/Lv0NII+nv3+P+e7MghfN5pCDWANGtn237R7Cf7Kgw+nnxpKPxQU5jn/55BUcTeQzVytwyC6ZcvbsJmbRMcoeFLqzy7LPjw+XBUlrOyR8fhH64qV02NaRq+Vgsg+nEyG4av5U5yA3nyDUk3Bdm11MZsjR8pwnyv3o+b2oih3y+PVf6ngJsLLj+RlqtazSmn4TOP9oJ7wiCe7HLI82NF8QWblY3KQUFclgzNbZl57QfUBv0R8xM3XUSbthcuuYz4Sa5UZE8DnVJBc1Y2+f/tO6KjeKom/iOD4JQ3aGXZLqb+n2uZQ7IiiQql7zOoREogLdXTb+Sx6o1DiK0KPl/XjMy/HU7LLvtiTN/UnmF5Ix2mBzRYprlBFzYGBoqvFo7zHVwC4u9cTWcgerCoqHwkgO4sWGChxAEBvJu2whs1UxMn+PLg+qnugwYRDIpx++CqAHoMWUHFS4jozRpnmOX3iX8yW0/0RIefnqODEUYV9ixpb0r9e68XqQygqoMrK0S2PrDkMrQ4SP8pzUdhQ7flVe4RyZLRpGFHdXmZb2bKfDH03crrZBQqB7NbbgUGrkyZM0MRPMxoPX8ptd+KrI3Pubw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(66476007)(186003)(4326008)(6916009)(66556008)(66946007)(8676002)(2906002)(44832011)(36756003)(8936002)(5660300002)(30864003)(83380400001)(41300700001)(2616005)(26005)(54906003)(478600001)(86362001)(31696002)(66899021)(6666004)(38100700002)(6486002)(6512007)(6506007)(31686004)(53546011)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkE4MzFWcXZMaHk0OUh6VEpGR0IrZ1dZZUJIOG9xZ0VYb0xBUmNkUTgrTWlB?=
 =?utf-8?B?ZGlGRjBzRThSSFgrVlFZZldrNTFPM2tlUEtNeTV3bVEvditCcW84akp3a01M?=
 =?utf-8?B?OFhxRnNYbk8yTTJrd29vT3JwNnhLbmRYNTFnUFBUbnF6ZWVGMCtLZTU4SEtS?=
 =?utf-8?B?SzJ2c1dmUTh2VW93T1lQWkFjMjRZYU8zazZOY0swVlJGRXd4TURiWml5NWhX?=
 =?utf-8?B?QS9rV29oV0Rzb0wxWVc1VkFKZm45N294dS9GNmpEL2pVOE1US0luSHg3ZnNP?=
 =?utf-8?B?KzVhMEsyQXd1Vys5Ylg4UzMrb2ltSW9GMjdHcUJvcGJZL1FjbktpRndJNG1r?=
 =?utf-8?B?QldJQ0U1Z3dWTlpaSHVrRGRCcFlHR2V5MlQydkZuS0NDRVIzSzh4VktIaFdT?=
 =?utf-8?B?TFNLRHdCNTBFQis2K2ppUjJ6SGFHcGNGVCtKMVBROEh1SSszSU5JTzRqQzlF?=
 =?utf-8?B?d1AwbFlXYXk5YUlyOEFjTkxRV0p5aVFFVSs1eDBLUW5LN3hWckw2WnBtLzds?=
 =?utf-8?B?c08wVUdvQTR0QldKbjFNem1hQlgzaFhtV1F2MWRQL25NSkg1QVZ5eVVWRHZV?=
 =?utf-8?B?M3VHOExQcmU0NXhwQ0UvcjMreDM2U1pCZ3pSeVBsc3ZjRkxISFlTQkxSTXRh?=
 =?utf-8?B?V0N2REE1Sm5zcTVVak85aS9XdlFDTU10aDdjN0MwRktoRi9FWW80My9NVEpt?=
 =?utf-8?B?YmNFaytYUXZodlB0bDIyalhoaW1rWXc5Z29wMHJaQ2cyQTNIVzJZaitnV0FX?=
 =?utf-8?B?NTNFTEFQWm43aHhWZjlrRnNlcjhUMHVxSERQd3FXT1ZFdFpMZGFQOGQ5L0l5?=
 =?utf-8?B?SUMrSmFmZ2NKTkpYRGhrTVk1TVFHTHo4cmdRZ3l1MmhmVldsRWl2OTUrUURI?=
 =?utf-8?B?SUUwaE9CRUZuSFYwSEoyb29oQVNFYzArdVNtNTdWRExadkRSbkZHbFJWVFNZ?=
 =?utf-8?B?UEQrQlUyeER6aUFBNmZGTmZNdDAzczV0dHlodk9wLytJYTBzd010SUVZZTFW?=
 =?utf-8?B?VzZ6OEZpdlMzNjVuQkk4UnVLKzlnVDY0eDBLdFdBaVMyNWRqdW8yUlllTmdP?=
 =?utf-8?B?d3h3OHRGV1lnNlhlY0piSDNCQXpBOUNBSTJneFVoK0RyaitoSEdrWmMveEhT?=
 =?utf-8?B?NDIzd3o4TlJGRENWeFR4a3huTmtETFJZYko3YlhIU2FrUDlhNXk0WFF0S3hL?=
 =?utf-8?B?cjZydFdWUEcrMXc0WXVmVkx3cHRjN3V6VjF2VlM5MHpsTXk0TEZIYzJvWEVX?=
 =?utf-8?B?VkVPQmg2RytkZW9DVi9BOXRnbjRBZExhNXVINHNGS0hmZXlhSmJ2RGttU3Jx?=
 =?utf-8?B?TjAzbStFL0UxQXVUMlplMEY3MXNjNG4xUmI4dm9zbkZSbWdWZzdDU2h5SXEy?=
 =?utf-8?B?eWhkZGhDWjlJSEpWSFlGSFhOd0hERHNvckp2U3F5c1laUU15NEY2RkF5Rjla?=
 =?utf-8?B?MUNZdVdRaUlJSFNwbm1INU5sRW90a3M1RFNRTjRRZ0l4YjdGVVUrK1krYlRu?=
 =?utf-8?B?aGlQaURSaWRZN1hCU3JHUi8zdFpYRjFPL1NVOFowSFRvakxQenc3WTE1Nmdj?=
 =?utf-8?B?M1MrSExQMEo5SmVVL1lIbGI0WVNRRFdQR1lDWU9kcWFOS1QxTEJTcWR4MlFh?=
 =?utf-8?B?aWtSaFVtSHFVZ3BYWlc1Sm96bFE0WkU4VFdGcGgwYWhqRjY4S2JBcUNKNHY4?=
 =?utf-8?B?UkpmT2IwanlLU1lmbEtBRzZNVlJTOTdTb21MdmtqNGIrNlo5L2N1dDNydWEw?=
 =?utf-8?B?U21Ba0lDV1IvVVl4ZTF6YTcxTlJkNm8xcUJjbmlaMGNobmYyWkp5UTJwTGtw?=
 =?utf-8?B?Z2pxbk9aYnlrWStRQ0t3VWZyV2FQRVZJdlhKWGVCcmVzbWkwWmZzaldxcnRo?=
 =?utf-8?B?eWFTR01VZ2MzUFRoVTJDVGZZa1UrTW4vbENuaTNvTTBYQ1EvTWFWRjNiRFlF?=
 =?utf-8?B?TnkxK2NGeU1aNXoxc1IwdUhxY0R6Y2xPN2RDVXQzYjlUZG5OdnlTbjU1Y3U5?=
 =?utf-8?B?STZwcEY2Tmo3a0F1TkYyNlRxRlQrN0RmaDE2b0JQS3FXbFk4ZkZqVmk0RU5n?=
 =?utf-8?B?ZFViNUpXRzhTSFMyN1h1bjFQbWwzSmFlREFwQUExaU5wWkdpZEhodVFSRXhS?=
 =?utf-8?Q?a8wLme3kfEkpQ2V3rWw2LM354?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe4896f-fb4a-4b4b-2829-08db31c1e217
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:28:19.7468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwGaE5V/mJkL7guFkxXbMeJVx5AwBiXpoXkLVCLiRBHseWX8r4Euj2EJNeho9QzHrb7JMvW1N+2CnfXEyfwzqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 22:54, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 11:48 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> This patch:
>> - adds a new doorbell manager object in kfd pdd structure.
>> - allocates doorbells for a process while creating its pdd.
>> - frees the doorbells with pdd destroy.
>> - uses direct doorbell manager API for doorbell indexing.
>> - removes previous calls to allocate process doorbells as
>>    its not required anymore.
>>
>> PS: This patch ensures that we don't break the existing KFD
>>      functionality, but now KFD userspace library must also
>>      move to creating doorbell pages as AMDGPU GEM objects
>>      using libdrm functions in userspace. The reference code
>>      for the same is available with AMDGPU Usermode queue
>>      libdrm MR. Once this is done, we will not need this
>>      patch.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ----
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 16 ++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 59 +++++++++----------
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  8 +--
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 26 ++++----
>>   .../amd/amdkfd/kfd_process_queue_manager.c    | 16 ++---
>>   6 files changed, 58 insertions(+), 80 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 6d291aa6386b..0e40756417e5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -327,12 +327,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>                  goto err_bind_process;
>>          }
>>
>> -       if (!pdd->doorbell_index &&
>> -           kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
>> -               err = -ENOMEM;
>> -               goto err_alloc_doorbells;
>> -       }
>> -
>>          /* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
>>           * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
>>           */
>> @@ -410,7 +404,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>          if (wptr_bo)
>>                  amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>>   err_wptr_map_gart:
>> -err_alloc_doorbells:
>>   err_bind_process:
>>   err_pdd:
>>          mutex_unlock(&p->mutex);
>> @@ -2163,12 +2156,6 @@ static int criu_restore_devices(struct kfd_process *p,
>>                          ret = PTR_ERR(pdd);
>>                          goto exit;
>>                  }
>> -
>> -               if (!pdd->doorbell_index &&
>> -                   kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
>> -                       ret = -ENOMEM;
>> -                       goto exit;
>> -               }
>>          }
>>
>>          /*
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index ecb4c3abc629..5827db9b18a8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -362,7 +362,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>>                  /* For CP queues on SOC15 */
>>                  if (restore_id) {
>>                          /* make sure that ID is free  */
>> -                       if (__test_and_set_bit(*restore_id, qpd->doorbell_bitmap))
>> +                       if (__test_and_set_bit(*restore_id, qpd->proc_doorbells.doorbell_bitmap))
>>                                  return -EINVAL;
>>
>>                          q->doorbell_id = *restore_id;
>> @@ -370,20 +370,20 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>>                          /* or reserve a free doorbell ID */
>>                          unsigned int found;
>>
>> -                       found = find_first_zero_bit(qpd->doorbell_bitmap,
>> -                                               KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
>> +                       found = find_first_zero_bit(qpd->proc_doorbells.doorbell_bitmap,
>> +                                                   KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
>>                          if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
>>                                  pr_debug("No doorbells available");
>>                                  return -EBUSY;
>>                          }
>> -                       set_bit(found, qpd->doorbell_bitmap);
>> +                       set_bit(found, qpd->proc_doorbells.doorbell_bitmap);
>>                          q->doorbell_id = found;
>>                  }
>>          }
>>
>> -       q->properties.doorbell_off =
>> -               kfd_get_doorbell_dw_offset_in_bar(dev, qpd_to_pdd(qpd),
>> -                                         q->doorbell_id);
>> +       q->properties.doorbell_off = amdgpu_doorbell_index_on_bar(dev->adev,
>> +                                                                 qpd->proc_doorbells.bo,
>> +                                                                 q->doorbell_id);
>>          return 0;
>>   }
>>
>> @@ -398,7 +398,7 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
>>              q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>>                  return;
>>
>> -       old = test_and_clear_bit(q->doorbell_id, qpd->doorbell_bitmap);
>> +       old = test_and_clear_bit(q->doorbell_id, qpd->proc_doorbells.doorbell_bitmap);
>>          WARN_ON(!old);
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> index df259f2cc58a..7d29653bff81 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> @@ -228,46 +228,41 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
>>
>>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>>   {
>> -       if (!pdd->doorbell_index) {
>> -               int r = kfd_alloc_process_doorbells(pdd->dev,
>> -                                                   &pdd->doorbell_index);
>> -               if (r < 0)
>> -                       return 0;
>> -       }
>> +       struct amdgpu_device *adev = pdd->dev->adev;
>>
>> -       return pdd->dev->doorbell_base +
>> -               pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
>> +       /* Return base of the first doorbell of this process */
>> +       return adev->doorbell.base + pdd->qpd.proc_doorbells.start * sizeof(uint32_t);
>>   }
>>
>> -int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_index)
>> +int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
>>   {
>> -       int r = 0;
>> -
>> -       if (!kfd->shared_resources.enable_mes)
>> -               r = ida_simple_get(&kfd->doorbell_ida, 1,
>> -                                  kfd->max_doorbell_slices, GFP_KERNEL);
>> -       else
>> -               r = amdgpu_mes_alloc_process_doorbells(
>> -                               (struct amdgpu_device *)kfd->adev,
>> -                               doorbell_index);
>> -
>> -       if (r > 0)
>> -               *doorbell_index = r;
>> +       int r;
>> +       struct qcm_process_device *qpd = &pdd->qpd;
>> +       struct amdgpu_doorbell_obj *proc_doorbells = &qpd->proc_doorbells;
>> +
>> +       /* Allocate bitmap for dynamic doorbell allocation */
>> +       proc_doorbells->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
>> +                                                       GFP_KERNEL);
>> +       if (!proc_doorbells->doorbell_bitmap) {
>> +               DRM_ERROR("Failed to allocate process doorbell bitmap\n");
>> +               return -ENOMEM;
>> +       }
>>
>> -       if (r < 0)
>> -               pr_err("Failed to allocate process doorbells\n");
>> +       /* Allocate doorbells for this process from the PCI BAR */
>> +       proc_doorbells->size = kfd_doorbell_process_slice(kfd);
>> +       r = amdgpu_doorbell_alloc_page(kfd->adev, proc_doorbells);
> Same thing here as the previous patch.  Just call
> amdgpu_bo_create_kernel(..DOORBELL..) and store the bo in the process
> structure.
>
> Alex

got it,

- Shashank

>
>> +       if (r) {
>> +               DRM_ERROR("Failed to allocate process doorbells\n");
>> +               return r;
>> +       }
>>
>>          return r;
>>   }
>>
>> -void kfd_free_process_doorbells(struct kfd_dev *kfd, unsigned int doorbell_index)
>> +void kfd_free_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
>>   {
>> -       if (doorbell_index) {
>> -               if (!kfd->shared_resources.enable_mes)
>> -                       ida_simple_remove(&kfd->doorbell_ida, doorbell_index);
>> -               else
>> -                       amdgpu_mes_free_process_doorbells(
>> -                                       (struct amdgpu_device *)kfd->adev,
>> -                                       doorbell_index);
>> -       }
>> +       struct amdgpu_doorbell_obj *proc_doorbells = &pdd->qpd.proc_doorbells;
>> +
>> +       bitmap_free(proc_doorbells->doorbell_bitmap);
>> +       amdgpu_doorbell_free_page(kfd->adev, proc_doorbells);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 0ed33416c35f..c97ed8e7e02d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -658,8 +658,8 @@ struct qcm_process_device {
>>          uint64_t ib_base;
>>          void *ib_kaddr;
>>
>> -       /* doorbell resources per process per device */
>> -       unsigned long *doorbell_bitmap;
>> +       /* physical doorbell pages */
>> +       struct amdgpu_doorbell_obj proc_doorbells;
>>   };
>>
>>   /* KFD Memory Eviction */
>> @@ -1006,9 +1006,9 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
>>                                          unsigned int doorbell_id);
>>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd);
>>   int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
>> -                               unsigned int *doorbell_index);
>> +                                struct kfd_process_device *pdd);
>>   void kfd_free_process_doorbells(struct kfd_dev *kfd,
>> -                               unsigned int doorbell_index);
>> +                                struct kfd_process_device *pdd);
>>   /* GTT Sub-Allocator */
>>
>>   int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 51b1683ac5c1..68d0310c2d53 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1037,10 +1037,9 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>>                          free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>>                                  get_order(KFD_CWSR_TBA_TMA_SIZE));
>>
>> -               bitmap_free(pdd->qpd.doorbell_bitmap);
>>                  idr_destroy(&pdd->alloc_idr);
>>
>> -               kfd_free_process_doorbells(pdd->dev, pdd->doorbell_index);
>> +               kfd_free_process_doorbells(pdd->dev, pdd);
>>
>>                  if (pdd->dev->shared_resources.enable_mes)
>>                          amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
>> @@ -1449,15 +1448,11 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
>>          unsigned int i;
>>          int range_start = dev->shared_resources.non_cp_doorbells_start;
>>          int range_end = dev->shared_resources.non_cp_doorbells_end;
>> +       struct amdgpu_doorbell_obj *proc_doorbells = &qpd->proc_doorbells;
>>
>>          if (!KFD_IS_SOC15(dev))
>>                  return 0;
>>
>> -       qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
>> -                                            GFP_KERNEL);
>> -       if (!qpd->doorbell_bitmap)
>> -               return -ENOMEM;
>> -
>>          /* Mask out doorbells reserved for SDMA, IH, and VCN on SOC15. */
>>          pr_debug("reserved doorbell 0x%03x - 0x%03x\n", range_start, range_end);
>>          pr_debug("reserved doorbell 0x%03x - 0x%03x\n",
>> @@ -1466,9 +1461,9 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
>>
>>          for (i = 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
>>                  if (i >= range_start && i <= range_end) {
>> -                       __set_bit(i, qpd->doorbell_bitmap);
>> +                       __set_bit(i, proc_doorbells->doorbell_bitmap);
>>                          __set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
>> -                                 qpd->doorbell_bitmap);
>> +                                 proc_doorbells->doorbell_bitmap);
>>                  }
>>          }
>>
>> @@ -1499,9 +1494,15 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>>          if (!pdd)
>>                  return NULL;
>>
>> +       retval = kfd_alloc_process_doorbells(dev, pdd);
>> +       if (retval) {
>> +               pr_err("failed to allocate process doorbells\n");
>> +               goto err_free_pdd;
>> +       }
>> +
>>          if (init_doorbell_bitmap(&pdd->qpd, dev)) {
>>                  pr_err("Failed to init doorbell for process\n");
>> -               goto err_free_pdd;
>> +               goto err_free_db;
>>          }
>>
>>          pdd->dev = dev;
>> @@ -1529,7 +1530,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>>                                                  false);
>>                  if (retval) {
>>                          pr_err("failed to allocate process context bo\n");
>> -                       goto err_free_pdd;
>> +                       goto err_free_db;
>>                  }
>>                  memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
>>          }
>> @@ -1541,6 +1542,9 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>>
>>          return pdd;
>>
>> +err_free_db:
>> +       kfd_free_process_doorbells(pdd->dev, pdd);
>> +
>>   err_free_pdd:
>>          kfree(pdd);
>>          return NULL;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index 5137476ec18e..693688d789d3 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -348,13 +348,11 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>                  /* Return the doorbell offset within the doorbell page
>>                   * to the caller so it can be passed up to user mode
>>                   * (in bytes).
>> -                * There are always 1024 doorbells per process, so in case
>> -                * of 8-byte doorbells, there are two doorbell pages per
>> -                * process.
>> +                * relative doorbell index = Absolute doorbell index -
>> +                * absolute index of first doorbell in the page.
>>                   */
>> -               *p_doorbell_offset_in_process =
>> -                       (q->properties.doorbell_off * sizeof(uint32_t)) &
>> -                       (kfd_doorbell_process_slice(dev) - 1);
>> +               *p_doorbell_offset_in_process = (q->properties.doorbell_off
>> +                                               - pdd->qpd.proc_doorbells.start) * sizeof(uint32_t);
>>
>>          pr_debug("PQM After DQM create queue\n");
>>
>> @@ -858,12 +856,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>                  goto exit;
>>          }
>>
>> -       if (!pdd->doorbell_index &&
>> -           kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
>> -               ret = -ENOMEM;
>> -               goto exit;
>> -       }
>> -
>>          /* data stored in this order: mqd, ctl_stack */
>>          mqd = q_extra_data;
>>          ctl_stack = mqd + q_data->mqd_size;
>> --
>> 2.40.0
>>

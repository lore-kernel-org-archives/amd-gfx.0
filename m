Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720C9C678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 18:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE97610E13F;
	Wed,  8 Mar 2023 18:39:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3744010E13F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 18:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7RNk8lJd0gd2YqcXo117iSDTqXJBXz3X2II9Ox0J60XCKOhF7tOXaeUT4moXXI5XerPbIJ9ZEy0Bp0ONnGGFosTdTRV7LDgQSTkMMyJ9DyPf0qB9TndrSyxRhWQnUoCOLddGZKi7DoKh+eDX1HUnI93q8h6O+fBV8UPdk23tkz2XTV4YXPEYG2ozCr7UAT4JU6RLwgg0wV9N9yG7a07RfNHWb6ShjKrkg0k7WHEpXoAWRsAWRKXStRQGPtgDTUbTnTg2k/w6JuYNGvmE5NYjGNwQRCKUAzYEo8YeAzafUXY5oF+PC5p0dS4hNn+hHRo2gY1axxKSmNXDTRH7N6WZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TshMZawfKhE8/o3Kn6kmm0yvxJxN2qp7BKmaTC5Pks=;
 b=bIgM+RdK7e+XjF2WRR3NdnDmFegoHIOid+8hOpJJOVQDvKRT+Ypd/VP04WJEWRBxIaeu/YpbxCGPLQxhlQSNWXP5L/GtRpHy1EsQTjm5jO1+coY3ofLNnIT3WKiATj0I4vNKhkkkMrAoIWTR3Bm15MzYkezZP/X0ijaNGQeEkWocXq1WgbBqKM9Nuz9QkzYCyaL8XHGguj2ZvunrCbGBere3FMrsyufpolTGhKqtgTRCXpPuiVxBMbjf2SYtNJuVOwVerWhXCJ8FvYqOxp6IK9XIV41Fcw+mEse9nNJKe+13xETe3tTpZ/NR+nR9tQoLvJvTjT0XMcFPt0wNj0Tzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TshMZawfKhE8/o3Kn6kmm0yvxJxN2qp7BKmaTC5Pks=;
 b=yUvZByB+AYLvJQISPHBoIpTknSTAV1tEAksdkFBMREZoI3mpneu5mJbnoU8HiomgVx7NuNTFRosDdHvEIDgrbDbEBeoDQ9UZJxjkag/Ie9eG/RGf+FyRQDuft44a4Ary3y9ha8YksQxw0vlgx/Js0AnxneUP/QAzxa0SzG+bNnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 18:39:33 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::dcbe:dda5:a90d:eba3]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::dcbe:dda5:a90d:eba3%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 18:39:33 +0000
Message-ID: <5725a5c8-6fa9-bf48-4c7b-ec3b34d495a0@amd.com>
Date: Wed, 8 Mar 2023 12:39:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdkfd: Get prange->offset after
 svm_range_vram_node_new
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230308074509.264478-1-xiaogang.chen@amd.com>
 <35f07147-85a0-a204-b0b1-394459e2c728@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <35f07147-85a0-a204-b0b1-394459e2c728@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:208:23c::13) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8d9b42-5492-45c5-0270-08db20047591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f06mV14k3lzPLrAA1Q6oddwMJmN0ULMQel4Hq7gfxQzU2kih1ePLe/L9/wF2Y8vSmuzhVA96vx8PTFNr0F2qFPEh/oEjSUZCzVbZTbJhH8mmaCPbaOZqKcz4dPP9PP4QrJk0qZ0QQ01LMPfuTXtOMcuYNEnk4EHf5jGiZVV4Ti5ODtj39O+OX92pV46xmeiOQyALFkM+JAG7gA+7V+B82+xGf8cwOsIpw1ILjQXfetASRjva2k2nAuL10QIjZNpxc51Pdx3X/mMkE/Rhawd1vQXNFtvpCFmBS8O8NFLnh5ULzz8qIzlK5xEZumFPCzHeF4f+meWbj0grLDY+n0KlLzWRRC+5+ssMsk8DxG/VZGqJJ7ERsGjyDVPzDNHPo4TXOh/U1EEp//8t8MtjyTXoU3kv0GDrS1xDBU3gwbDtWIUKul5cgfEID6kdC4J0nwMnQzVajjRpzFk4dWHeLcDdgXWCqLSkhgFbVra6vRFqSDbhIqlZqeCw22OUtUu1zBZdPNzfob32mSgsjnB5e3sCc03vswxgQRoNvo/uUZuaSAhwoucwdePVo1+rm7zn/IohgKfuJeJq+CdBm8M7XU7acrW40xTOfInw3nuRw2/LUhXONFFbWdWqXOXrJW4MU+uGjE2pSa2UA77T5FU0fe1cDC4MOSq+9vHCi2wCd+IezE2A63JKiJj2WUpiJoFcS7LvBJGqrkomycFKIHif8cAK04YgWWhh6EgT9XBlXxkSYDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199018)(31686004)(86362001)(31696002)(66476007)(66556008)(66946007)(2906002)(8936002)(41300700001)(5660300002)(8676002)(38100700002)(36756003)(6486002)(316002)(478600001)(83380400001)(26005)(186003)(6512007)(6506007)(2616005)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDVaYnJyZGNCaVN0ZmVzcWpxZ0dyWFh3SUJkZG1iSll5Z2lQdkV5YjFZaUNm?=
 =?utf-8?B?RkZrYm9JTDRKSTBFdzMycndOZnBxMENnN2ZhUTlMOStWc3hWTFJWN3RnY1pq?=
 =?utf-8?B?cG9tVWUwN1dkY2VzUDllVjUvODJBalF4M2NpOHN2cDZleFpZZEl2TC80Rlg3?=
 =?utf-8?B?TmpIdkNwdUtpZUZxLzc1ZElvbHhlc251cVB2Sk90MllUSHgrQ0pZNTJEbU1r?=
 =?utf-8?B?R2lIS3pmRWJlS3JkMUZGQ3R3SVdzeXN0eXkyVlVHVXlqUmhUbHZ2MzVHNjky?=
 =?utf-8?B?MmpzQm1pb0xoOUdkc3FRT0Y4SDBETXZZRDlCKzBDQkVkTHh0dXpqTlZGVnR5?=
 =?utf-8?B?NFF3cXBFTngxRDIzYkQzSzZ1aHVwREJ4L1VzcXJDVmpWN2JrN1poemZLbmdy?=
 =?utf-8?B?Sk12WU1ad3Arc1JBY09XaFAxSEJkcHpLY0NMMjAyN0Jpbm5MaG5DQzBTd0l1?=
 =?utf-8?B?bnZaNStrU01zNzZWSkRmdENDbE1WZEtGU21CdkhSREx0V0pYNXYvMnJrUnY3?=
 =?utf-8?B?a0d5eW5HendJZE1xcDMwVWJmM3hoUTlDNC9zM3pzWWgzRVVqQWwrUmt2MWpt?=
 =?utf-8?B?ZjdDb1JRSVVhNGNkTURDTmd3NFpkaWQ3d2w5ZlhJTU1ETDR4cXkvaUlmRXMz?=
 =?utf-8?B?WUovbDFXaUlSZ041SVJhLy9UU3JiRXFYWTlXaXVzaXdlODc0ZkR2QnU2Z2Va?=
 =?utf-8?B?a1JMdmc3ekh3eDhvS3l3eXordVBTOEhGUzllNmhncTIvTHNxdkRqSnFMWUVH?=
 =?utf-8?B?VVNueFVWZFVCcGExRVQvNi85S3ZKY1FRcWJJaXZkZlZuYnlYZE1rbk8wbHJv?=
 =?utf-8?B?NUtFQ0VIa3JMWDhaSGp5SUswbmtnb3REYm8xQnpyK1h3VzRvMUtEcG5veHJl?=
 =?utf-8?B?Q29TaUJoUndFZ2dLYzBsTnFBOHJJQThFVmxyaFF3enUxdTZtL29IY0xnb2gy?=
 =?utf-8?B?L1lNR2R2ZXhtay84TmJ4QVBTK3NnVzh3MUFTSjdSTVZQRGdVL2dDSW42WnZQ?=
 =?utf-8?B?UlR2UmwyS0JCWFpOUTc5WUhPMnFQUDNxZFErSUI2Mm9aaDVlQWZvc0pwVHNk?=
 =?utf-8?B?dEZqNDhrdVJjYkY3RlY1S25OZE9kT0xkVDFybkN0czI2aGpTbWJjZEE2Q3JV?=
 =?utf-8?B?cUR2bllLUWM0SFFWV3ZkRGI1dE9BS0Q4SGw3TlpXUlN4UjhhaHUyNUpLaEs0?=
 =?utf-8?B?K0w5UkxnTjUzS0ZaREF5Q0Y0OTI2Zll5RVZDdlVGNzUwMGw2KytjRklVVCt3?=
 =?utf-8?B?WCtrOFVBbUw5MWpwTy9QQ2NUbmtqRzF3dEtjcXd4blpSekdtVis0NDBhVVZY?=
 =?utf-8?B?SGpVSE1Xait1bmxwOWJDQlZVeDZ3VDh0NDR5SEFEWHVpM0p2L05mWDFyb3Ex?=
 =?utf-8?B?M3NCZmRwdCtZcEYvT1BIc1hDZjdzZmJxY004OWRmUGVHeG5xQWpnQTg2WkZz?=
 =?utf-8?B?T0FEVVF2aEE3NDdlYVBBUzYvUzhNeFpoU0kvZjdTYnlFUFdMT3pVSXdXTDgv?=
 =?utf-8?B?WUpLWFF4UCt3M1VITVg5WDF1QUtmaWhHVWdzUzkxQWFPcDc3ZGtKQmdadVR5?=
 =?utf-8?B?anlzQWQ1U1dNRVQ5bTFQbkgwSlFrTXBValIwcFhyQWNkWnFCRk9YbHJ6QTlp?=
 =?utf-8?B?Rkp6dEdZT3h3SC9SRDJoVFJFMUplUHpoazNOUzdlbXpXcXV4SWYxVzM2NWFt?=
 =?utf-8?B?SHdGUjUyNE9pUzdtdHd3S0hPa2gzWjhMUm9wNlVHbzlrYUMvOWU3YmMxVjVx?=
 =?utf-8?B?bGlHd242dGxvcnBWUVpUTnFnNGorMzQwdm9oQS9rWkVMUko4Y0VMOUptVkh1?=
 =?utf-8?B?UUhMd1U1WXpyRnFxOTd0T0IreUdIYWV0ZS9od05yeUplTXRpbHZScy9Ob0VX?=
 =?utf-8?B?THZxOEJTN09IYi8wM0VJeVg2TTVJS3V5dmI0cjNHTW9HdE5LeS9qbWFJUFBJ?=
 =?utf-8?B?R3p1OHpFSG1rOGJheWNBcUhaYi9FWGN5NGtBdDRkajhabFpMb1U5R3FLeXV2?=
 =?utf-8?B?SHZDejMxNTdTR1VHUm9WY1E1dHU5V2xZZlRkMnIvc1dRTGNDUnZCb3lQZ01v?=
 =?utf-8?B?TVVQc0c2Zk9iRkhETno0dS9jQSt6dXFsd0w2SjZLUG1Oa0MrSGNlUW5Sak9P?=
 =?utf-8?Q?wkX0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8d9b42-5492-45c5-0270-08db20047591
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:39:33.0421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8Gngrus9NCBCtV64TT+yGEhlWkkVWNQ44NJCjb3ZfP9tBiDNocFRRKlcdrNJJ1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
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


On 3/8/2023 11:11 AM, Felix Kuehling wrote:
> On 2023-03-08 02:45, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> During miration to vram prange->offset is valid after vram buffer is 
>> located,
>> either use old one or allocate a new one. Move 
>> svm_range_vram_node_new before migrate
>> for each vma to get valid prange->offset.
>>
>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>
> I'd  prefer to keep svm_range_vram_node_new in 
> svm_migrate_copy_to_vram. Logically the memory allocation should be 
> after migrate_vma_setup. If migrate_vma_setup finds that there is 
> nothing to migrate, we should not allocate any memory.
>
> Does this fix a real issue, or is this a theoretical fix? I think it 
> should probably work correctly without this patch. 
> svm_range_vram_node_new sets prange->offset to 0. If no VRAM was 
> previously allocated, it should already be 0, so nothing changes. 
> Maybe we just need a fix to set prange->offset = 0 in 
> svm_range_vram_node_free.

A real issue is same prange migrate vram->cpu, then cpu->vram. During 
vram->cpu pragne got split, so prange->offset got changed, then vram 
node got freed by svm_range_vram_node_free, but not update 
prange->offset. It is the case KFDSVMRangeTes.MigrateTest. I will check 
by set prange->offset = 0 at svm_range_vram_node_free.

In theory, getting prange->offset after svm_range_vram_node_new makes 
code logically clearer? svm_range_vram_node_new handles different cases, 
we are not sure what prange->offset would be before call it.

If migrate_vma_setup fail for a vma, we can svm_range_vram_node_free the 
vram buffer got from svm_range_vram_node_new.

>
> Regards,
>   Felix
>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index fd54a00e7229..15791490c23e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -310,12 +310,6 @@ svm_migrate_copy_to_vram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>       src = scratch;
>>       dst = (uint64_t *)(scratch + npages);
>>   -    r = svm_range_vram_node_new(adev, prange, true);
>> -    if (r) {
>> -        dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
>> -        goto out;
>> -    }
>> -
>>       amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>>                npages << PAGE_SHIFT, &cursor);
>>       for (i = j = 0; i < npages; i++) {
>> @@ -525,6 +519,12 @@ svm_migrate_ram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>         start = prange->start << PAGE_SHIFT;
>>       end = (prange->last + 1) << PAGE_SHIFT;
>> +
>> +    r = svm_range_vram_node_new(adev, prange, true);
>> +    if (r) {
>> +        dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
>> +        return r;
>> +    }
>>       ttm_res_offset = prange->offset << PAGE_SHIFT;
>>         for (addr = start; addr < end;) {

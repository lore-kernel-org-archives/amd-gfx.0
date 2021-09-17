Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7EBC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 14:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B937E6103B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 14:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B937E6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598A36EC82;
	Fri, 17 Sep 2021 14:06:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93036EC82
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 14:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzXkwI+9PuU/9WlaSR/MnjFqTgTGheIEVg5JJxBRH+0/Vzlhci5kPouDz2ErM9XNwXLd97lXqXN/0Lw4CKRmd582aaDd0g6ReqShEHuhY2YE79nGCtqN+r+EuEzpLpIwdMymUuaCx3Ek94uq4xs3TaFYjvl+DQXeWyy3RukyFgG0IlehkLoZC02OFf4GSnjwi3YuDY3uhTvgjJIcugEGcU3GuGRjRwRN1yA0TthkrP48AYVpNIL23Da1bomC6y5WmHDrlR9AhaQin20Z1jPT552EuJ1T5QIzyGcKTFwrGYC5RMGbCTTB4YavizpXhEO1AjEBXmBgOBPYh1hRvJskJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NfWWf9bSvGvvu4byZiIV8kfsbHHxVVCGqGIgwAyop1A=;
 b=T7sCPcY5nyt3Pt95nedGecvzfSmH3oQfH0y7tdhkY1i+Gcu5RCHE7timUAO2nnsVyfSbVLvmqDReT9A2b2Tc713p1c16LjXbSLuDcBefQsvTjEOcDn5sr1yaqfQM2fNjjJJeUZhwas0dMy4FMA5IC1FSfhsmXSe+WZJRBDHNheOXmVpfPqbND6Tt3II/c3qhXg2YDNndsKSMAl4h2JEn6atiwVULF/GNwIeC8+uLBspbKeiDtusvpirl8+wNb+xL9DCLI7wTGlWhsyQalRr+1Sp9o616GmzrLXJy8ZIlkaBegL2624kRZ46GJqmKjqcnrwzcGmwnpLCULf9nAg+bMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfWWf9bSvGvvu4byZiIV8kfsbHHxVVCGqGIgwAyop1A=;
 b=0jjCu9JoNlAvXQJ0sQImJi3CqDtRvqwi/fmJscHKtGY3Eo/wTzuYWlqsgPyr9uf/5g8Ry9Sp/UsUkNmE/ZrlPFVv/Yv0j5sCD7ScHB70+WzftBFMT9g5y9gNqtU93eE2+9vyZ5IOknsSODxqEHhrdJje/0hzMkgZhhiWAL6oS0k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4615.namprd12.prod.outlook.com (2603:10b6:a03:96::21)
 by BYAPR12MB3270.namprd12.prod.outlook.com (2603:10b6:a03:137::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Fri, 17 Sep
 2021 14:06:31 +0000
Received: from BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::209d:702e:6613:9d27]) by BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::209d:702e:6613:9d27%6]) with mapi id 15.20.4523.014; Fri, 17 Sep 2021
 14:06:30 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix MMIO access page fault
To: James Zhu <jamesz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210917113045.22194-1-andrey.grodzovsky@amd.com>
 <9472de33-c1ba-e273-16e4-9c6d1764b0bd@amd.com>
 <02f26a0e-7de0-9b1e-8e4d-4315cc420360@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <5719f692-4fa3-a32e-4090-8b5f1161adb4@amd.com>
Date: Fri, 17 Sep 2021 10:06:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <02f26a0e-7de0-9b1e-8e4d-4315cc420360@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To BYAPR12MB4615.namprd12.prod.outlook.com
 (2603:10b6:a03:96::21)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:a21:4904:2446:825e]
 (2607:fea8:3edf:49b0:a21:4904:2446:825e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 14:06:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c920a36-71e9-47e2-f4bc-08d979e45912
X-MS-TrafficTypeDiagnostic: BYAPR12MB3270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3270743BE4074951FDC65E00EADD9@BYAPR12MB3270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7LwdiTGCayPgvQwNkDlrBnnfIEhZdy3Piu8MXOicetrL4Ktwyq3jpaQWOtlRpEmOt8AW44+Ul7dbVy04BknUuUAc6jGyBYEVDg8y6HhAIh8I5d+HVruoHx9pcCp3CkucfcE6PhvY4zR9d5zbaep4JbfZLG4s0Hz6xQ1DvWICWZzd/M4sp/69NDsxdSee0mAY+sFLrguBm83qwsBGAOLMH/DGbl7zHMErwZK+IRtteCt4lyBaZOsOiiEh1Pkbr3/BIsn0eIBwyZIhYXDFFkTqBX6yMc9YP4KsVw08+kCVOr4kN4UfME98FYE78F9HybTQp2/74lI4/gCjzIFWH/kbb7hDOdVKgOCLfoLvZWxlVr/Vhi3+rfI/OgBPm9EsoezVRguvwTYMXRA3VVFhAAfFx59g2yU62FcIOWGPQahtvYnws0u9r4H+MVtrDN98ExaXlZaIGDlC84GDPZh4XDnFgzZQwMbZ+5JpbzeDINcom1NNr2Ffax+lwm5RZgPf7eTwQG1QmrjOqTF+FK7zEJWf4sqhAP1tSkAzNHBAeQ2XVH31IIgM2Q27U4mtcxLW11kUIf7i+U2XMxf9qcEbi3/xPiVdyQklqvhUQb/Rhri6uzp9vLZCaTyQ2+C2SVfmU313tDEmMI/4nck7nBw66DIGE60b8VNJUNAPveumbx6TzM7RGQxQsOK0F2qoU2gp7UxKEJky3F+pXbS1yWWJQDm9dwZOH0ZVXsAK8y8xKcYXkTRvdHDSPB8t4jTsIzEnYakV3YQT1tgY9PR1Rx+nxN6Oh1kLcEGdNACbQMUbJaNk0PUAV2yZB34DREsk8Vycakf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(53546011)(86362001)(45080400002)(6486002)(36756003)(186003)(2616005)(38100700002)(5660300002)(44832011)(8936002)(316002)(83380400001)(31696002)(66946007)(66476007)(2906002)(66556008)(478600001)(31686004)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJlVCtqRitGeTBiNHpwY3EzeTNES2p4dUQwRVI5OGJWKyt6TlhUM1dsbG9m?=
 =?utf-8?B?aytnVldxRE1CbWRacUtuaFpNYTZmR3FQQk9RMTBWcHdqQjNFR2tiUXplcHU1?=
 =?utf-8?B?U3VicDhDUHJYOFFyZjBxcWJobG9NTjRxdmY1K1dveitlYm8zQ3dkbzRrejI5?=
 =?utf-8?B?OS90dHRIUjloL25rc1BKR29LejluSkQyREZlQnVieTdLUTdsdVU0VUU4YW1p?=
 =?utf-8?B?WmRZMjlCbFBsdkltS2tScHNBK2F4K2VlY1lUclBWQ08xamNCOXFrQjhDd1BW?=
 =?utf-8?B?SHRBLzZ3Z2l6bGQzaHRvb1dhMlR0eGNLcVNRWWN6MjJiNFhMYmtLTkw1a0lZ?=
 =?utf-8?B?T055RnJ6RjhRNFBwejk1MGZ4Y2dkbkxoZVBBV2ZqdlNLSWlzMEdtTHhkbXlk?=
 =?utf-8?B?bW1QZlc3dkc1REVCODNVMVNoNFZhVFhiY0VvWUpsbFNpOWtWeThuVmxQVk5C?=
 =?utf-8?B?UDZieS8zOENxT2lSSWt3akxOZEEzU0pzZjgycEsrN01YOWdpVVlYM0UrUFhx?=
 =?utf-8?B?UWtWWkJNSS9aaE5uZUlCMkZIVndSbUNnNmxZci9saFVuUnNlVFJXSGpQUEhx?=
 =?utf-8?B?WWRhNzR3U2xlWmhqZDRic3MrR3JuUWQ5SDArNHpBeG4yNE5zcXNNTURaK2F4?=
 =?utf-8?B?M1ZzYzVsLzZneFEyVk1nMS9HTHhTS2dFMHFWYXJyL09sNUtiSkJqTU4wU1lv?=
 =?utf-8?B?dFh1NXFrcDUvS3dkTG1DMFFkRklJZDlCSGhYMUNCWWZxK1hNY0FBZ0REeTht?=
 =?utf-8?B?QzNBbkJhbDBwVzRONngvWk1idmtPb2RRQlU0djZ1TkFScUdLNUJxUFFzL1pG?=
 =?utf-8?B?T1l3cU52MU93TjhUYTlCWTN5NmhFUS9VUG0vRUlSblljSllrbnJhOExQQ215?=
 =?utf-8?B?MnRGYXUrVUNMMytRalU5L2xxUFp1NVFabHFVbjg5bW92MktjOXp4Q3QvN2dS?=
 =?utf-8?B?STRtY0d5ZDJlTXQwMllFUzAyMHI1Y2RRMSttcUZDL2VyazV6MGFocEl6cXIz?=
 =?utf-8?B?WCtUS3J0K0RxaE51M3RMN1REWGFIVEVtK0dWTUh1OVQwUjEybWpFZC96WlZk?=
 =?utf-8?B?Z25qQTRsS2ZmZGZNVjdtWms1YjFPaXg0VXRRd2dQTU9Md3VTQkZJVGxmUVN4?=
 =?utf-8?B?SUFIZ1FPcUp5UmFkTnJmZ1lvaWxiK09aQmdHS3VnNDBKemNkdllmVkFTVjht?=
 =?utf-8?B?RXhyYTd4b3A1MlZsRHRFRUxONDBkbnJQVE54R0pldlVlb09PcFExVEErNFVk?=
 =?utf-8?B?VWxCeVU0K1EvZzlCZllSQkdsRlVRcERsUWo1SWl6TEdBUEducTk2aGVOYWlB?=
 =?utf-8?B?K003bWNqREo0aHBBdXF2NXpoWWlzK0ROZEVWVlRCaTExY2IySi9zb0FzUmZ0?=
 =?utf-8?B?aUk1emxuWTBFS2ZsMDA5OUpKQ1RkaTByQUZ6cThyaEFncVdheHdnYWNiVXN2?=
 =?utf-8?B?NjluMVN6RW1Jdm9EcXRaUDlNcGN0MEVvSXlPMS9pSmFNZ3dPcmwyMnpRN1c1?=
 =?utf-8?B?d0J2TThUVi9tNmpNN2dzUmdBVkwxSlV0T3hDT25QQzFOOHphM2F6bHVNdFBw?=
 =?utf-8?B?YWM1V2oxZksrWXIwbGxxNThZNnpVZHVIWGFLR0ZKWWpkWGVWbGlkMFJkTk0z?=
 =?utf-8?B?M1ZFczlkR0c4ekMwRTFyVEdpMlpLeHdneXhlTGpWU2FZNzdHK1ZRNnJxb3Z2?=
 =?utf-8?B?b2VKQzBpN0RFQWF3a2M5TngzQlR0d1Z4RFV5MVFUT2hMeit2SGtOSGlXNU14?=
 =?utf-8?B?aG5YK2Z1K0M0Wm5FVS9INjJCczVDUmpnSGNJNGdaZW5aLy9CSVlDWHAyMm9G?=
 =?utf-8?B?K1ltU1U4djRYRG1GU293cWdVeHk0TGdYNjhUSm5vR05kYlF1UzVBWGd5LzRP?=
 =?utf-8?Q?aDs3cD2X4tt4b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c920a36-71e9-47e2-f4bc-08d979e45912
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 14:06:30.6942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYVSu2q0HTHf8azyy9fwZTAlmVrbrR7mHIa2+2T7NOnR4EN+DTI2BqdLaY7xZx6HE/7BPF90Tfc3spBNx3G4jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3270
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

Note that it already has this protection.

Andrey

On 2021-09-17 8:04 a.m., James Zhu wrote:
> typo. vcn_v3_0_sw_init   -->  vcn_v3_0_sw_fini
>
> On 2021-09-17 8:00 a.m., James Zhu wrote:
>> Hi Andrey
>>
>> Can you apply this improvement  on vcn_v3_0_sw_init also?
>>
>> With this adding, This patch is Reviewed-by: James Zhu 
>> <James.Zhu@amd.com>
>>
>> Thanks & Best Regards!
>>
>> James
>>
>> On 2021-09-17 7:30 a.m., Andrey Grodzovsky wrote:
>>> Add more guards to MMIO access post device
>>> unbind/unplug
>>>
>>> Bug:https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugs.archlinux.org%2Ftask%2F72092%3Fproject%3D1%26order%3Ddateopened%26sort%3Ddesc%26pagenum%3D1&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C209112865fef455dba0208d979d35e93%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637674771021422447%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=pskUESxJBYWMjGxbTqb5W%2FwpXUpui9c%2FyUEl7HX9PA8%3D&amp;reserved=0 
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c |  8 ++++++--
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 17 +++++++++++------
>>>   2 files changed, 17 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>> index e6e9ef50719e..a03c0fc8338f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>> @@ -22,6 +22,7 @@
>>>    */
>>>     #include <linux/firmware.h>
>>> +#include <drm/drm_drv.h>
>>>     #include "amdgpu.h"
>>>   #include "amdgpu_vcn.h"
>>> @@ -194,11 +195,14 @@ static int vcn_v2_0_sw_init(void *handle)
>>>    */
>>>   static int vcn_v2_0_sw_fini(void *handle)
>>>   {
>>> -    int r;
>>> +    int r, idx;
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>       volatile struct amdgpu_fw_shared *fw_shared = 
>>> adev->vcn.inst->fw_shared_cpu_addr;
>>>   -    fw_shared->present_flag_0 = 0;
>>> +    if (drm_dev_enter(&adev->ddev, &idx)) {
>>> +        fw_shared->present_flag_0 = 0;
>>> +        drm_dev_exit(idx);
>>> +    }
>>>         amdgpu_virt_free_mm_table(adev);
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> index 2e6b7913bf6c..1780ad1eacd6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> @@ -22,6 +22,7 @@
>>>    */
>>>     #include <linux/firmware.h>
>>> +#include <drm/drm_drv.h>
>>>     #include "amdgpu.h"
>>>   #include "amdgpu_vcn.h"
>>> @@ -235,17 +236,21 @@ static int vcn_v2_5_sw_init(void *handle)
>>>    */
>>>   static int vcn_v2_5_sw_fini(void *handle)
>>>   {
>>> -    int i, r;
>>> +    int i, r, idx;
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>       volatile struct amdgpu_fw_shared *fw_shared;
>>>   -    for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>>> -        if (adev->vcn.harvest_config & (1 << i))
>>> -            continue;
>>> -        fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
>>> -        fw_shared->present_flag_0 = 0;
>>> +    if (drm_dev_enter(&adev->ddev, &idx)) {
>>> +        for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>>> +            if (adev->vcn.harvest_config & (1 << i))
>>> +                continue;
>>> +            fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
>>> +            fw_shared->present_flag_0 = 0;
>>> +        }
>>> +        drm_dev_exit(idx);
>>>       }
>>>   +
>>>       if (amdgpu_sriov_vf(adev))
>>>           amdgpu_virt_free_mm_table(adev);

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 12:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7496611F2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 12:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7496611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C34F6EC2A;
	Fri, 17 Sep 2021 12:04:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4991C6EC2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 12:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/yFomlIgfBg1KrbcX44B0+CHXgaYGEoULbRoSCtUCks3sGiFlZgmp8M+5vd3H7gL6Y8mg2/3mTz0BgHsAIx0WedwEZnNlU9thHOMFf6zc1Kl/rgMWIqsK4pi6Ki+cDX7Me62ZTPscDfccgccbg942ixnvZ0TBD7R8ap24QMb4q8LEZuFYBpbcNwahRdtNxfpIMHrKLk7VUY+AnMiD7Of8X1DbuwO3BaJ0QmbEHsMu+ZkDLMA0es06ZabhGY4SrwpFzBUGalDn55dHhAYtgit1k6SqogDxAQI90XZ7aD2fdrXs03TCJ1xQ8XdLnEN3UXBNZIE0PCzPs+UculDH4byA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=uPL5IBmLtGaFvApxfsBemAEGsbjgSQek7zcaWDE8XeA=;
 b=lqumjY0zKYtBXyHzKpcYO53/qOwiOlmrJvpKgCnkpMVrBjOA/vea9GCnlv+QtQCYjYAsVfqQM9KzScQiHYhbWhm0v8FTtlO8hzjyu3/nY6Hbjd4NbUB2LAG+cmSZJSvCYCBccMvGOCAYkp+1H54mTVr6F1OlpD686F0lhl2dtDw7Fadw27lTFMgjiar2SJcOakO2OMl/OC4NgFlwlf17U7rgYhVltFuOGPheBxKTw7iz4LT7frm3lZ913Q3OYwpQzDTugV8pGmb+UiYF5m4f4pL72P3XN/ee60zlQRhzItMip0d41LptVdYTR7gs/eOinVtRWEcffIPQLVtxO+msfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPL5IBmLtGaFvApxfsBemAEGsbjgSQek7zcaWDE8XeA=;
 b=vRYCtXUY8x6lZ0F5zEgohFxYdqc0E7RJIkGzO/cT9JZSrUhAyMvxnwuhLsp2FBG/oPNhTwxAlrcSDR75l/w4R8zCc0lXtYNpG7VXGICroR1VZHw9QtqE6mp3LrcqCfq7476Jzon/eBLU0E+YQvZI8+leG/6/NDGe7iG4m3ZupGM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4731.namprd12.prod.outlook.com (2603:10b6:5:35::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.16; Fri, 17 Sep 2021 12:04:52 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::e1d2:cc87:74b9:397d]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::e1d2:cc87:74b9:397d%7]) with mapi id 15.20.4500.016; Fri, 17 Sep 2021
 12:04:52 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix MMIO access page fault
To: amd-gfx@lists.freedesktop.org
References: <20210917113045.22194-1-andrey.grodzovsky@amd.com>
 <9472de33-c1ba-e273-16e4-9c6d1764b0bd@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <02f26a0e-7de0-9b1e-8e4d-4315cc420360@amd.com>
Date: Fri, 17 Sep 2021 08:04:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <9472de33-c1ba-e273-16e4-9c6d1764b0bd@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::35) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 12:04:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fed0e54-6c8e-4aff-f5ea-08d979d35ad5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4731:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47311344F18178BCB55BCFB5E4DD9@DM6PR12MB4731.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4Liw9RoQqZ/BhKXbsEnM1mvE2ULJQQ7autcXJ8TjPPu0qqyygGR5XoItBnqVHN49QbeJp0Vh092UQ4n0fIEx+kF3cSdxQ1hbT4AUBkWf9+GwbgR91YYtt3deqegovpEVDb3Jq+MEVBlj3bCyUK1yc4sTu8iFAK40q51dbpfCsOGRyEiOr9LFXe9VDsYJuEbCOBSZxaKtBfBRnifpeMkp7Yeak4A7K+1R5AyTah4DVFjro3HNwylyFW0yfjgt7rA05JtLpdAZJICUpT0h39PnDyfhOsJ1BamMaWSGqk+ouAQcxG0826n7+TlAEvcr1vARDOBoPHb4hgyS749KhYqQRjgC4m2vF/HirilepZvIMNTLwvwlPcl1uMSXcfoudUByKynEZ3xW+z+XfolmnIP12Ui/Kvff3VIxGcVxpV8d89PV0+kcC0ObeS+brgE0pSrZ5Oa3sPgmB0s6a6WrdkL570uy9MawAKzF2aDuaWjNEFaYjfNd+OgzubINujcRqz10N1H7S4aGhoYsa+glVrD94hXJ20PfS5z52VFOoGZ58KqYIR6M7Cg8Ck/3qcAZ4IckwYgaHH2QcdnkSDTGY5E5+OgKUtXTSTRmLJHj+trzHxMWzEXRq91prMoZWdvxDJV1BVCgjC7DDOdobsSo+cuBfXTTWfwznxV3KFDv4ewSe+ptcuafaSzzpVpNlViwC50arKxnwoEQudz9WeQAVQsgSNaEGPCwdp4mPHL1JX89xsR4XwJXkMM2q8a0bhihU78xtnMN4D4yxdA1arpgAJmGPFH05v+UUTq0x5TCyui0mSjiofHiGsxaJO6uyu7uBIeQlaiGHqZTdlRixs7fKFaT37XRWIyQAEWfbo0HZKAQ1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(38350700002)(38100700002)(956004)(36916002)(52116002)(45080400002)(8936002)(6916009)(66946007)(6486002)(2616005)(66556008)(5660300002)(66476007)(316002)(83380400001)(2906002)(508600001)(31686004)(8676002)(31696002)(53546011)(186003)(26005)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDNlbENESmNrcDRQNFljU1BwMVlUYlFKOGF2TmVpRFhaOWtXQVRoUkFhUDh0?=
 =?utf-8?B?UlBoS3FCK25TRFNpelJZZ0NxTHF4ekRZbFFsU3hRTmd3VThuZ3VTczkzMnBJ?=
 =?utf-8?B?MTB2RUc0aXRqTVBBbEh3dzRmTEZxVW1BRUxnUEhVRTJjc0RXS2hQMjFwUXds?=
 =?utf-8?B?RXhDTlcrSzBzMDJxcXpSUHRGM0xBUzZnV09DdHpoWmR5bXpxanFmYlFQRTRC?=
 =?utf-8?B?TTJQNVlvaE9NdTZldW11bFlyd2pKM0dkODhURHFrZjJDd3pVQ0owQ0VyelVC?=
 =?utf-8?B?R3lPZjZHQ05kd0dXeDQ4bjMvR3ladDEza050Q0Q3RW4rQVdjQldSS2g1dHRh?=
 =?utf-8?B?cmlSRU1ncUEvdjR4ZTJIbCsxS0Z4WjArWmxKVmRjNExpRFRUQU9qdGs5V0lB?=
 =?utf-8?B?UFRFQkZPeHAyaStuSE1XUEV0ZWczYmtXS0ZxWStPbVVLWUtveXV4YW9aQm5K?=
 =?utf-8?B?KzhuRXRzUjJ3OWpSeGp6QWtRNEUyOGltZVZDNkh4VU9zTkd2R29DZ1pPa0VV?=
 =?utf-8?B?azBiNFZIYTl6U0VTWWp1RHloM2RaM0l6MmdWTnNWQUVoOCswdnc1emlYZ1JG?=
 =?utf-8?B?RlFsT3hncXBPNTdjSnQyV0dNOGkxVHZaSnVxWFRMSEYxWFJaRERkTlZaTGF4?=
 =?utf-8?B?UTF3SCtvNDFVS3l4aHFRdTlrTUY3ZzBSMTR6RTlRQlBlNlphbzBHQy9jd2hz?=
 =?utf-8?B?WEhkTWc5OEtuMkZwSkRLN3NPem9iNDBLUWpmZnR2UUM0SU9KZVBrc1ZWRW9J?=
 =?utf-8?B?WEhwdGNQOTlCbDZ0NGp4UENCUWNaTm5uSGdSc0RjdzdqTlNVUzBRRUl3TlBw?=
 =?utf-8?B?THRDR3NOcDQ1ekd0Z1NDUmZGWHNSQ25oWjI5UHE0dUlGVWVNQWVyWTQwOGs5?=
 =?utf-8?B?SEJpaGFNTDc1bGh2V2k2MXZqYTB3ZzJCSHM4YWR4V2dZMk15UUVkOUZ3WjVZ?=
 =?utf-8?B?WkNsQXJncEE5MGtvV1BJSUlQS2k3MHNHTWxNbzFRUUwrb2tjc3RMbE8wQi9X?=
 =?utf-8?B?WW9TY0U4RnZCUFB1OXY2cjlXWkZSa3ZXK3NwME9UNXUrc1dUUVBaYUtCMklE?=
 =?utf-8?B?NWtDaFFhYWx5VVJmcEpJMWxGaStubWN0TFVmd3ZYQkdPczlFVlV4U012Nmsz?=
 =?utf-8?B?VVJ5ZlVyL09pNXdHVCtZNTJFbVFMcFlYUGs1R3dCQVZLQXJjUU1IQmw3eFRs?=
 =?utf-8?B?S29LQ2owdUJ5YmxLR0NyRG9pRGN0L3J0bXhqYnRqelNqdmdhTGlhLzNIWUtz?=
 =?utf-8?B?MlBYL1kvaGxZbHNmUVluWnFzTXFQV3MwdDc0ckZ2bVZNblNCNms2Z0dQWXVs?=
 =?utf-8?B?VVhYV0E0V1djT1pXR3RmV2p1N0ZKZlR0Zm1qQ0dNY1lsZ1RKMS84dGJqUXdL?=
 =?utf-8?B?bm82SzZRMjQ0WHJRYkJkcVEwNEhIL09jUkNyWEJUMDJrZUljcHpnQzk2dXpY?=
 =?utf-8?B?c3FWcktwVlNTZ1VvODdnMXNEZHA2NWNzVzRYRzZEWVNJMW1OLys4WTlDd0ZR?=
 =?utf-8?B?QUcyTmplMzlxdVVuS0lNSk5aYlllVEVxZUc1TW9ONDBTT3BzVS9kTnc5MGx1?=
 =?utf-8?B?TTBvV3hDUm0zZTh1WHRYWmlvRTA2dTNiMkRhL3p3b00xV3BZWER6TjlVUld6?=
 =?utf-8?B?ZnhldFcwYndBQ29NTnZEUEdKR3NrMjVMR29INEh2Z3Y4Z2pVekNBOTZpMVpH?=
 =?utf-8?B?ZFFEU2NaU0kzcFA4cWFOT3N3YjlkSERoazdRU2NvZXJYNWt2V25yMW9BUnAy?=
 =?utf-8?Q?S3xfrO9TF8DY6nOSVFFmH+k1RWCwnCrDEEHy2pE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fed0e54-6c8e-4aff-f5ea-08d979d35ad5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 12:04:52.0126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mP12Xsa9KcVpYMjTHIBx9+bTKZR7XFaMn/nCXL2YJrjVUlPSxrW5bvMgcaZbwU1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4731
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

typo. vcn_v3_0_sw_init   -->  vcn_v3_0_sw_fini

On 2021-09-17 8:00 a.m., James Zhu wrote:
> Hi Andrey
>
> Can you apply this improvement  on vcn_v3_0_sw_init also?
>
> With this adding, This patch is Reviewed-by: James Zhu 
> <James.Zhu@amd.com>
>
> Thanks & Best Regards!
>
> James
>
> On 2021-09-17 7:30 a.m., Andrey Grodzovsky wrote:
>> Add more guards to MMIO access post device
>> unbind/unplug
>>
>> Bug:https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugs.archlinux.org%2Ftask%2F72092%3Fproject%3D1%26order%3Ddateopened%26sort%3Ddesc%26pagenum%3D1&amp;data=04%7C01%7Cjames.zhu%40amd.com%7C79fe530a08c049d250c408d979d2c56b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637674768432274237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=RsLTZM0ajMSf0GQpGYzVrvBNdAAEBSUTZ2qw2M2o0w4%3D&amp;reserved=0 
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c |  8 ++++++--
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 17 +++++++++++------
>>   2 files changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> index e6e9ef50719e..a03c0fc8338f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> @@ -22,6 +22,7 @@
>>    */
>>     #include <linux/firmware.h>
>> +#include <drm/drm_drv.h>
>>     #include "amdgpu.h"
>>   #include "amdgpu_vcn.h"
>> @@ -194,11 +195,14 @@ static int vcn_v2_0_sw_init(void *handle)
>>    */
>>   static int vcn_v2_0_sw_fini(void *handle)
>>   {
>> -    int r;
>> +    int r, idx;
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       volatile struct amdgpu_fw_shared *fw_shared = 
>> adev->vcn.inst->fw_shared_cpu_addr;
>>   -    fw_shared->present_flag_0 = 0;
>> +    if (drm_dev_enter(&adev->ddev, &idx)) {
>> +        fw_shared->present_flag_0 = 0;
>> +        drm_dev_exit(idx);
>> +    }
>>         amdgpu_virt_free_mm_table(adev);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index 2e6b7913bf6c..1780ad1eacd6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -22,6 +22,7 @@
>>    */
>>     #include <linux/firmware.h>
>> +#include <drm/drm_drv.h>
>>     #include "amdgpu.h"
>>   #include "amdgpu_vcn.h"
>> @@ -235,17 +236,21 @@ static int vcn_v2_5_sw_init(void *handle)
>>    */
>>   static int vcn_v2_5_sw_fini(void *handle)
>>   {
>> -    int i, r;
>> +    int i, r, idx;
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       volatile struct amdgpu_fw_shared *fw_shared;
>>   -    for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> -        if (adev->vcn.harvest_config & (1 << i))
>> -            continue;
>> -        fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
>> -        fw_shared->present_flag_0 = 0;
>> +    if (drm_dev_enter(&adev->ddev, &idx)) {
>> +        for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> +            if (adev->vcn.harvest_config & (1 << i))
>> +                continue;
>> +            fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
>> +            fw_shared->present_flag_0 = 0;
>> +        }
>> +        drm_dev_exit(idx);
>>       }
>>   +
>>       if (amdgpu_sriov_vf(adev))
>>           amdgpu_virt_free_mm_table(adev);

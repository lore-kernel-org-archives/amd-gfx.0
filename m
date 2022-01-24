Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE16CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 16:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FAA8994A;
	Mon, 24 Jan 2022 16:38:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193FA8994A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwDCZR/lk19ZVMlXaKyngqTtD0QQhdUjvtRmT6FvH3i1t4+uLRV/UgU91KjfqsOMRNT2UYMBMY/HPZbvnhV3ggCiq+OR25h/QSU+SFq+FtvIMHbQHXYEvrwc/puUEf6Dy6Sb0DUvkpzTH/WyVGkrNJVlqt71cED4UuiXI7Ts9FZasUr95ofD5fSLBgJ3+Szfh3iNsMmK0HjH/flnxvy4cV1KtskIV8JVX31pYnkybJv+KqpI44dlY1qAY6jBHRrKSd94se8+gBym4peIDwQuHV7XxyJ2956NEp4GhPMkOxFThCB27CiWAKdehd/X/R+i2jtjJAbEVuMGMewveOGYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu7D0sp1KnZGZDtmgXGlUINEt1q/+n2MaFU0+e7DZyk=;
 b=dyDiGpyVa4xFT+BhxPfR0tIcdyAQ4le6uSd+Nwz9vLvdstC0hQGs06bs5OChUrW0eUNiDsfWxcMBibqs4dLej6pAuaBYaylD+4l9SXPGvm4cbDSL4+4ZO7W/WVAshjgTE3fet3sTzlADX/bSBL0hAxKHaBKy/Gxbc/iEY0eyHxOAnGNU2dIl6pp6cUbF1pgire9fOxv75xciwWqgM/gOvJYVXgGVN7HaqHckRtIcMM2g6hQXF8zQLxcFBF72lt5thzDxCWBs7Aff1nlTXAokrAmx2XNaseotmn5s9hoTkfc+9d9Rrz3kndRs9VeWlvzpb2st1WwsggoCxXFjGGlp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu7D0sp1KnZGZDtmgXGlUINEt1q/+n2MaFU0+e7DZyk=;
 b=YYvgSIVOV8G5o1I6claqzscM4LuREvBLzIZO/XCvtyAAOBBXzAURxXpNbLQfMOytdalI74Kpv/OIdUaU4NrYNjlvPRNzR+ipMs/jWpiIr9/d+MzxynjTeDXl3K3WHN9jf2/OPVH7AFPybHbn7HozzJv13SWZ897LyBd6qHXpwBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BYAPR12MB3079.namprd12.prod.outlook.com (2603:10b6:a03:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 16:38:31 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:38:31 +0000
Message-ID: <d98e2702-fe42-dfd3-64d6-0eb67a07ca7f@amd.com>
Date: Mon, 24 Jan 2022 17:38:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <e3a18180-7c02-c10d-157e-8c4b6c6736cb@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <e3a18180-7c02-c10d-157e-8c4b6c6736cb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0602CA0008.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79322e0d-53f9-40f3-335b-08d9df57f48e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3079:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB307905635971272652B911FAF25E9@BYAPR12MB3079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTn8URTI7lv79r13kNbMe0+bKhJrhWN+IAz0+IpJmr914g8AaYz19W3UlvcvMpwQ2P7ghn0pKM1ugXagf6pNgxitQA7uY0j84dG6Y84Dbuyw2j0z3RM4ollHSlTqofokWBRa0SJdPsztvEMFCsr/o85w5Cqw3h5lZbCBFDrs0AD33gVr6nSNkzJL/DUpHyILPW2WeAl4RT7NFyW6k9uTtdqDjLu0Rs39gEDJwqPyJuORmisZsq2X8meBO1wbzxACowhQqVXnTpmTtdIlf4FA5uNFEH/I4fKk5Q86XrR8hdSxEzir8IjOL0JG++T200+uoSgT3X8LdVhNRWO8dlhZC2+sTeEzVZNRoQIWczWbsHRUoF7oClEzCV1NbzzjJySc/3y4Nn8xzZbTZhoweqcpgu/7lY2qWhRy0JjwKGK4RhTu5G5FIdBUi20DJKmM1ZKWFj9r02gcMBGcUTO9ZL4J2RUfdakvtDJN5JGJM9QBO8KX4nTL2tinTA1VKsApqPoE5S/TADo+AakGq4gPeWO8mQ7GQE8DoFGuHimuvGE5Uk5m6TbFiJVDfWpUAN3yBFIE6NakzJAVnNmnD4eU6PqoF5LoIHbjXhA0HIcwmmoPifKtdhwG6bJ55+ibOgBI1oTKTup5aKlbMRH+PZaF0MoG/Hm1eBZo/DLq07itda3XZ726cUbVeCVRlEER/zjejJlcNo4E9MoY5TgMth8NPUsp6JwKgdZOIeHWTeOGOdtUZQ69H+GUtQmX0YATL7dq0ykg/wpbRXTpkCkEBPewd6tnYyeKWUAyfAuxQyR+ie2gE4nALDRMUA+o2ra10+jKh75x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(8936002)(83380400001)(6486002)(966005)(66476007)(316002)(86362001)(53546011)(36756003)(6506007)(31696002)(186003)(5660300002)(110136005)(2906002)(4326008)(6512007)(6666004)(66556008)(66946007)(38100700002)(26005)(8676002)(54906003)(508600001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS85MmFqVlh2QWZxTnZrRGdWL09JbDJQNG96QnlxVWgwNDVvdlR3d3I0OC9q?=
 =?utf-8?B?UVpaalFSc0VHYTVtcU1rcHdja0p0SkdDSVJnS3U5bzB4OG5nMURJTERGZFho?=
 =?utf-8?B?RUhkLzNoMjBOTjJDVzRya2pUU3RXcW5COGFWR2VyeGt2S3lFSHQzbERGS0FN?=
 =?utf-8?B?RktzOXdjRVFKa2twUW5ZUFA2bzUwK0o2ZnNwOUF4U0kxWEdpaFhXeHBjUzBB?=
 =?utf-8?B?WnNLb05sbnJRY0tVemtHeTI4VjJlTnN2d0JPQUhOVHlacnpqbFNZMGxNWHdN?=
 =?utf-8?B?UVN4MnRNcU1uSU1vVzZxSzBDTGlMYnk5NGkvdXFCdUl4LzhWVFNSVWNJUmEx?=
 =?utf-8?B?d1k2K2xVZUFMVUV0cS9rMGtPZ2JZSDBCZnlraXJIaFk3cUFCaVUvL2g2STZr?=
 =?utf-8?B?azhsaElGRVNlWVVwZXFWTzBIYk5PNlN6Ri8wdDhSeXd3aUp5cWRlNk51d1U2?=
 =?utf-8?B?UW1admVIZTd0empOYmFHQjhSUEVjdTZaUVByaU5Wb3ZvTnI4NVRnVnlBQXVK?=
 =?utf-8?B?Z2NkTDlkSk92Qm5Ld1hLRGlmMnR4VnZkbjJRSGhQaGV6WWxtY0Z5RjVRakRI?=
 =?utf-8?B?WUprYVBJd1NQOGhkeHNhUXVyQ0tOQTN2RmJXL3JuZGVTNGtlZUJ6SENTNEQr?=
 =?utf-8?B?RGFVRkRpd2tZUEM0SDNyMktvUFM1d3lYTUk2L1lFcktGMHJJQ0xMVXBhOXBQ?=
 =?utf-8?B?aXRkSEpIdTAzZG1pYSticUVxaTMzSFVIeFdSSTlBSGVMeWhuSUhjSlkzaXUv?=
 =?utf-8?B?VFVkZDdVQ1RqbWNQMnFnNTZaSGJsMlc4QnVZcmdYZ0VBQVYwRWwyT2ZTdlBz?=
 =?utf-8?B?QWZqbXUvNkpseHhRTjlLL3loV2szWFgxVHhrUnJUYVdJNFc3Nm1HMWRRNy9B?=
 =?utf-8?B?ZFNWT0VTaFhJZXhpRlIzY056WmdXQnRmMWFZd3M1YTJKM1V2Y1hRS0lQL1Jj?=
 =?utf-8?B?V2NkbE9EbUk0bVhFVmxndzlBeGZ0eWtUb3AxNVNMV1h6Nkx1MTVqTCt5ZUtz?=
 =?utf-8?B?UTM3dGVVencrRUtJbXo3T200SzVTc2RHdG9Sb20wTUYvQjJyaXdsQ0U3ZzNp?=
 =?utf-8?B?VHJrZ2RzdXJTZE9lV3J3RzNLSXA2c0xFVnlyKzNwaDFVa2JFL2I2aDFIY3BL?=
 =?utf-8?B?RlRGNkl1RncyQ2hESWhUOG5UMXBzbmFMempTTVZjQnlhSzVYeGNVTFZvTjR1?=
 =?utf-8?B?d0hTaVBIcnJmWnRaUHBNWTlGck9yb1hyM0k0dWU4R3hYR3g4WVdFd3dRblZz?=
 =?utf-8?B?TzNwRnh0dDJVdFdSaUMweWRUSG9mT3BYNHVyaEpVQWg5ckk0Ri9UNzlKZEcz?=
 =?utf-8?B?REl1NEJPMldRRlU2Qzh6SWdsZ2NUMWs2V3VFOTllZmFBT1U1SXRnWlNLMkhY?=
 =?utf-8?B?amlXa0g2TFp3enI5NTNjV0R4MVhQRUkxZDMwckxUYWQ0UWZYaWt1azBCTUFP?=
 =?utf-8?B?aFBFMzNyNk84ZllmY3hQTTQ4VVZ2VjZ3VzAvenczOW9wWVlOcjFIMS9NQzNs?=
 =?utf-8?B?NUpDYi84UHM3OHZMWTA3Mk5JQm1EMGhlSThta0RxSzVWMXR4QWlidkV5Z1ZU?=
 =?utf-8?B?K01wSTZVMUE3d0NjdklwQjY5VEFsK3FqaXhibW42MXhjRVM5VklmaHQzUTFj?=
 =?utf-8?B?V1JzM01DK2tqTWVNWTNob0doZ1ZwV3ZNcldWaytmZHJFSkNtbVNYSFd4eTkx?=
 =?utf-8?B?YjMrZ3RkR0tBYlVna0V1S3hMOUJrZjBIb1RidFJ3WjRscjV2NWxURDBpcGVp?=
 =?utf-8?B?MmhvY3ZDcWtzeU9xdXZrNGJxYXpvU3M2Mmt6Z1NhVThIWUc0SUlGaEp4N3oy?=
 =?utf-8?B?NXFlU3NWeWQvNUIyS2VlRVZsejk4U2Y4alpnc2pwZCtqdHhWOG1TR0ozNzJa?=
 =?utf-8?B?S0x6bC9GVHh1Zms3WTVmeXdZVnNHRW5EL0xlOGdZN0R1Sk5LWFVJL0syUmp6?=
 =?utf-8?B?SjZabENScG9yRkVmMi9kNjFQYmEzZXRqbE41LzhjaVh4TENqR2pCMFhmM2ZO?=
 =?utf-8?B?RWtDRTFsUGErL3NxY3NORjV0TXliS3UvM3pvN3V1ZGJIdmNVZTZ4N1hsa1RC?=
 =?utf-8?B?d0dsZGhxdWJVQ1R4bEIveVpjUW0vK1NsWG1rT0F1OTZTQTNJL0NrRmdCYkZN?=
 =?utf-8?B?eG9kZ2pvZXExUWZ4NWZXT0c3UWwxNG16NzRVNmFQalFkTW1VdVVZbGdtTjNX?=
 =?utf-8?Q?oEat6JibOFtwSZ3D9r+z3TA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79322e0d-53f9-40f3-335b-08d9df57f48e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:38:30.9952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3vYHyTrKFGx9lzzSqBgPPkmTypsTNVViLM/uLx9sF3vCvg7PcUWumQAAeUcqAYbRxlBDVaRk97cCLBAQsGEdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3079
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Andrey,
That seems like a good idea, may I know if there is a trigger for STB 
dump ? or is it just the infrastructure which one can use when they feel 
a need to dump info ? Also, how reliable is the STB infra during a reset ?

Regards
Shashank
On 1/24/2022 5:32 PM, Andrey Grodzovsky wrote:
> You probably can add the STB dump we worked on a while ago to your info 
> dump - a reminder
> on the feature is here https://www.spinics.net/lists/amd-gfx/msg70751.html
> 
> Andrey
> 
> On 2022-01-21 15:34, Sharma, Shashank wrote:
>> From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00 2001
>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> Date: Fri, 21 Jan 2022 14:19:42 +0530
>> Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>>
>> This patch adds a GPU reset handler for Navi ASIC family, which
>> typically dumps some of the registersand sends a trace event.
>>
>> V2: Accomodated call to work function to send uevent
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index 01efda4398e5..ada35d4c5245 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>      }
>>  }
>>
>> +static void amdgpu_reset_dumps(struct amdgpu_device *adev)
>> +{
>> +    int r = 0, i;
>> +
>> +    /* original raven doesn't have full asic reset */
>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>> +        return;
>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>> +        if (!adev->ip_blocks[i].status.valid)
>> +            continue;
>> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
>> +            continue;
>> +        r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
>> +
>> +        if (r)
>> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +    }
>> +
>> +    /* Schedule work to send uevent */
>> +    if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
>> +        DRM_ERROR("failed to add GPU reset work\n");
>> +
>> +    dump_stack();
>> +}
>> +
>>  static int nv_asic_reset(struct amdgpu_device *adev)
>>  {
>>      int ret = 0;
>>
>> +    amdgpu_reset_dumps(adev);
>>      switch (nv_asic_reset_method(adev)) {
>>      case AMD_RESET_METHOD_PCI:
>>          dev_info(adev->dev, "PCI reset\n");

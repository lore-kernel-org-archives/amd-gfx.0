Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF5C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 17:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F55564E93
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 17:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F55564E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B2D6EB5B;
	Wed,  3 Feb 2021 17:05:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00D86EB54
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 17:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy7R1XHIyIq3YRjR5XMAwmccFrjSOnDrQhMEEmxckN8NB7ugcKnv/fvl6nqcLWo0lLz1kVV2Jb8Pgude3efiBkGRM2eUb1V1OCoJrFkph5GFEwDN1f0A6W2xz8nEaDM7hIQHiucwxHUxUZvfLWmK79cTekPPFKrXkFUkzXv7mxmtdQRna9b7lQszO/p/4N12ELnmK1APOjnhUgY8D4+rpeWq2ffbgkZfkU1PHrDmajsT3omK500g1DwmB73c3JZAoFqtF+MFLaMcmvPJ67pnfMSHNzprhzQ/NxP7pJJC4soqcFnFRUyTjDSWarNaya4n7pdjTwdf3PrNwIRjZc0Csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lojy1M8cGkPkalMC64YqTPhCiAZDAPu7uIH0zFoSi2Y=;
 b=ARZZYXSrBpmRXpL0jpFRTs7AqEnAnD69cM4UYllSM6Lkj7S9esL9csPg/Ga+6Ze4IVC8JgovmYo4I56T+l5KQrovhr4blk+DTuQ0Op6Eu0aJ8wo+YXXqfyXoj9kq/u9Wczk2M0XRmQmzk2OLHYNc5uJFsadaZKPo3uZ+2Rn+WMpwkEsE3RlniFsoELWAjwmcMIUnYcAOsmCPrj5iVDLThZHoZvmX2wIz1dii/FrleC6oq5ovWlqBHmt1yZZ45FFiV2Z9pVKMWrVbQD+TdJ3ePlDg6+LPHwKsBJo5H5WsQ9h/OKSqoJopFs/B+Nh347TaCn4AqIKHJ4cMR0o3yh/r7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lojy1M8cGkPkalMC64YqTPhCiAZDAPu7uIH0zFoSi2Y=;
 b=cPKb9p7iSnlmimfu8SD1Eyi8OLHUTSxMvJY6SSPtW1Ung/5RW5e/+1Jztib5fwO7YZNkTFwLkHVjiiM0SFLf1B5WHB2V7ZY/tNSBOeSQWce4GfiCrPBxUkSCCEApv1ZiVAt6Yfd/MdEV5PHYltjHHQRa4iX64h+kc0JwLdxBqI8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1194.namprd12.prod.outlook.com (2603:10b6:3:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Wed, 3 Feb
 2021 17:05:27 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 17:05:27 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: enable wave limit on non high prio cs
 pipes
To: Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.das@amd.com>
References: <20210203160723.98588-1-nirmoy.das@amd.com>
 <CADnq5_Oxd=oBkh7AMEQgVQxhJpuxCRugb8OfZC_w_OmkMTgUbw@mail.gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <110d646f-d3b5-2c7e-7747-164913833bb3@amd.com>
Date: Wed, 3 Feb 2021 18:05:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CADnq5_Oxd=oBkh7AMEQgVQxhJpuxCRugb8OfZC_w_OmkMTgUbw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [93.229.33.84]
X-ClientProxiedBy: AM3PR05CA0112.eurprd05.prod.outlook.com
 (2603:10a6:207:2::14) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.33.84) by
 AM3PR05CA0112.eurprd05.prod.outlook.com (2603:10a6:207:2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 17:05:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca8e9aa1-9abc-45a6-1fd8-08d8c865e71b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1194:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11944176C100A887391D9C388BB49@DM5PR12MB1194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9COtp9Yvld1vzc8iTLYdnxTInKXndc06az1P8T6/hUi6JCbAOgayQo6/lyHaPmimqrzWucjoYZ4ogxal/be9q7VsYFARXHlQpf5QejiDDj0VwDv2Td9tDC75DBhIsfzRewICd7hLXLe9KLxyiRH0QhC3wu8musAXo6U8e0WKXI5BVhL5m91Z59C5C3PKiSCnV9g45wvvfdvNF9XFZMN94m7x29yNtGup89zrPy+de1gGkfJJIQEm+pHMZsNWyraAjwsh7b8QHeQQSYKOUPnnA1iVz9OlmzSh6oM26jr5i8mZN6VfatC9x3gyjbMviNApcNlod7LXKt343JgWmRDF6LLhwkErd9Sjd541sCyn96jOattMe2+M20KnnixWd0qjpee4acPA91l/WTWB5VXrdtW6H8G+VKn5lKnJz8wO6TMUH0JBj/YsUJMac089EyznkmGT1DwajHSLbyL7EvM0ldKD04FQjUwvthX2xzbqDi3EG+XzUHWXVgdzA1c0nM6id2CqfVX7wal17Q2OXO13LtGoYrtLy6n38P7uAHIu2DlpnEuUJ4Xi/NOnjgXWWFv6/ZHLwybmp+vV3sh94oMzYp9BlVWhywb/p56RRMyPtyOhthXQ6T77yK4vjCjCDB1RnaRp2wUWQNhZt/Gw19W7PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(31696002)(53546011)(478600001)(16526019)(4326008)(110136005)(6636002)(8676002)(186003)(52116002)(16576012)(54906003)(26005)(8936002)(45080400002)(2906002)(5660300002)(66946007)(966005)(6666004)(31686004)(83380400001)(66556008)(66476007)(316002)(956004)(2616005)(6486002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?citSaDRlU3U4b0FrZ1E5dWhLSjU5dTI4aHRPbzRrc2U0anF6cE1PSXFTYkZa?=
 =?utf-8?B?WVl5d09nMXhsMVIvTzJKNEQxc1NrSE5zczdwODJiQVZIREpXRFZwY3d3bVBY?=
 =?utf-8?B?NVkza2t1MENDbG1RcWVpNmE0OXA1bDUrNWMzbGxlSWZLKzROVkZUMVhkbnZX?=
 =?utf-8?B?TUJiaU9rWk1lL3lESzlaUUNoSG5sZERmNklwMWJVY3E2dVVVQVk5WFU2R3Iy?=
 =?utf-8?B?c1lWZGM2KzRHdHZFVHNyZ2ZQaGlWSEhqNmNMQ284QUs5UnBhd2psMkZ3VXhD?=
 =?utf-8?B?bU85REF5OE55cEYrZGRIVE1VSEp3bWdwZk5peWs0WmVkVWp4OVBwQUxSNElO?=
 =?utf-8?B?czlPdzd2a2FCa2pIZ3BOWHUwOWQxd0RGNWx2MWtlVS9iQ0J2ZHYvZnhBcGh0?=
 =?utf-8?B?bHg0aVVoeGk0ejN2TXlGbER5WW9wek5pcU1zV1ZoRnVwcFpFcmxaRytoc090?=
 =?utf-8?B?aFpzZWJ0NDErdGpnaGRxRDd4MzVOOExDdkpFWkdXRk8vcWVNbUZGTHhCaDN5?=
 =?utf-8?B?QjZtbmFOeXVoQTRjeGNxQk5pUTloVUMya09mR1BCcmNTdVorei9hblQ4aVdU?=
 =?utf-8?B?WlhDVUVpZ1lhUzZ1dWZKNFdCTEJML3p1Y2J5MjVhaVc3OGw4a2ZPUHhXamsw?=
 =?utf-8?B?ZlFJNWNyMkN5dmxwOGFka2JWWFAxb29vVnd5YVQ0Zm41ZnpzVndzL1dYRWtW?=
 =?utf-8?B?M3BGb29uRkdJT2UzcjUzczJ1SW1qbjdMWTFLWGRSYWNZQUZOdE1laTFyOWFH?=
 =?utf-8?B?T3NkK1hGT2hEWXJzR1BqenM1Slo3V3A5Z09sdmk2a3lTMFBML0E4LzRHYlNJ?=
 =?utf-8?B?UkxnU2xQYUpQSEQvUHJYQTVXK3RzYitLRkh1Z25iWjh4bFRscUtwU3Q2eDhp?=
 =?utf-8?B?ZmFheEFkeDdKV0U0c1ZOTjJ6YnZiTDNNNGFpZU5qSGxRWTY2dVBqZjROSDZa?=
 =?utf-8?B?bU1WRUE3by9PZ0FKbC9hL0NaMzFieXRJenV3MnkwRXp2Z0FicEZnYUtFa3BE?=
 =?utf-8?B?Ti9sb1lMb1Y1L0dKaDhvTm1SckpkZmRPN1FsbHpzTklJR2tmcE9UTUR4ZzdZ?=
 =?utf-8?B?L2d5M1VZT0s4am8xV251MXB2ZTN6alVHczNjZHQ1UmwycXZCZ2liU3BpWTZa?=
 =?utf-8?B?MzlSUmNEYU1nbWFZdURVRmV1RXNFYlNGWjNyWEFMWWl2NXNQT0F6SkNyNzR3?=
 =?utf-8?B?a0lpUzdkbXYyQ2F0VHlmUUJYeGtzS2Mwek5YSlVLVEE1dmZONU5EOFU0eU5o?=
 =?utf-8?B?SzJEYVZlczQ2bjltSmFOWlJ2cGRyMzMxUVE3bTNub0p3bEROOEJkNzJoWG11?=
 =?utf-8?B?b0g4WFNjNXNiRmdQaGZsT1l2TDdvdVJoQzEwMW9TRUZ4VDRIenRZSHUzcWRL?=
 =?utf-8?B?ellWaFpCOVlKd3FRcUtHUE0vcDIzdWFqM3BYcDNJNWhVVXlOUXJ4NDhac3Vu?=
 =?utf-8?B?bEE3eSszckhUbHBYUUI0dy9MUGFGTDhLaWF3STBERnE3SExxVy9iN1Bhalp0?=
 =?utf-8?B?cWUrVHJRZy9DY21tY0NxUlVMMlpZdVE4SUVOSittUnlXdU5iMGhaN0ZQTjF5?=
 =?utf-8?B?cndWbHREQ0xEME10d09WYjdwYmErbjhvNlJsSm4weVcwUVhlTTZYNTNWSHox?=
 =?utf-8?B?OU9MaCtLV1lLcHIxRWQzSnpQdyswS0pjako1TlNqYWZJOC9rRG1xRTByVWky?=
 =?utf-8?B?THZ1TGVkeUkvMVo5SUVGTEFMNjdJVkNydlNtSHB6VmJ6Vk1HRXN4bHJBa2tO?=
 =?utf-8?Q?5DPMfDiBFX2+7Z7KGXbwQ8Ouybkjc+lZUdT42rB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8e9aa1-9abc-45a6-1fd8-08d8c865e71b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 17:05:27.0350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8DbpAMmOn8CRua5/4CGfG8CO/iRujofLa5x/ZrgXGWKg/mRP+3gYWESflG26LCHUYO3P8gH066nRyHMt4Onfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1194
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
Cc: Alan Harrison <Alan.Harrison@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Huang Rui <ray.huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/3/21 5:56 PM, Alex Deucher wrote:
> On Wed, Feb 3, 2021 at 11:07 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>> To achieve the best QoS for high priority compute jobs it is
>> required to limit waves on other compute pipes as well.
>> This patch will set min value in non high priority
>> mmSPI_WCL_PIPE_PERCENT_CS[0-3] registers to minimize the
>> impact of normal/low priority compute jobs over high priority
>> compute jobs.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 49 ++++++++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 46 ++++++++++++++++++++++++-
>>   2 files changed, 93 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index bdfd29a22b3d..28dbce1083ab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -6846,10 +6846,44 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
>>          amdgpu_ring_write(ring, 0x0000000A);    /* poll interval */
>>   }
>>
>> +
>> +/* mmSPI_WCL_PIPE_PERCENT_CS[0-7]_DEFAULT values are same */
>> +#define mmSPI_WCL_PIPE_PERCENT_CS_DEFAULT      0x0000007f
>> +static void gfx_v8_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
>> +                                       uint32_t pipe, bool enable)
>> +{
>> +       uint32_t val;
>> +       uint32_t wcl_cs_reg;
>> +
>> +       val = enable ? 0x1 : mmSPI_WCL_PIPE_PERCENT_CS_DEFAULT;
>> +
>> +       switch (pipe) {
>> +       case 0:
>> +               wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS0;
>> +               break;
>> +       case 1:
>> +               wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS1;
>> +               break;
>> +       case 2:
>> +               wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS2;
>> +               break;
>> +       case 3:
>> +               wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS3;
>> +               break;
>> +       default:
>> +               DRM_DEBUG("invalid pipe %d\n", pipe);
>> +               return;
>> +       }
>> +
>> +       amdgpu_ring_emit_wreg(ring, wcl_cs_reg, val);
>> +
>> +}
>> +
>>   #define mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT     0x07ffffff
>>   static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>>   {
>>          uint32_t val;
>> +       int i;
>>
>>          /* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
>>           * number of gfx waves. Setting 5 bit will make sure gfx only gets
>> @@ -6857,6 +6891,18 @@ static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>>           */
>>          val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
>>          amdgpu_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
>> +
>> +       /* Restrict waves for normal/low priority compute queues as well
>> +        * to get best QoS for high priority compute jobs.
>> +        *
>> +        * amdgpu controls only 1st ME(0-3 CS pipes).
>> +        */
>> +       for (i = 0; i < 4; i++) {
> How about using adev->gfx.mec.num_pipe_per_mec instead of hardcoding 4 here?


Thanks Alex, let me resend with that change.


Nirmoy


>
>> +               if (i != ring->pipe)
>> +                       gfx_v8_0_emit_wave_limit_cs(ring, i, enable);
>> +
>> +       }
>> +
>>   }
>>
>>   static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
>> @@ -6943,7 +6989,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
>>                  VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */
>>                  7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
>>                  7 + /* gfx_v8_0_emit_mem_sync_compute */
>> -               5, /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
>> +               5 + /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
>> +               15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
>>          .emit_ib_size = 7, /* gfx_v8_0_ring_emit_ib_compute */
>>          .emit_ib = gfx_v8_0_ring_emit_ib_compute,
>>          .emit_fence = gfx_v8_0_ring_emit_fence_compute,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 027997e95e46..e44487ae15dc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -6668,10 +6668,42 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
>>          amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
>>   }
>>
>> +static void gfx_v9_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
>> +                                       uint32_t pipe, bool enable)
>> +{
>> +       struct amdgpu_device *adev = ring->adev;
>> +       uint32_t val;
>> +       uint32_t wcl_cs_reg;
>> +
>> +       /* mmSPI_WCL_PIPE_PERCENT_CS[0-7]_DEFAULT values are same */
>> +       val = enable ? 0x1 : mmSPI_WCL_PIPE_PERCENT_CS0_DEFAULT;
>> +
>> +       switch (pipe) {
>> +       case 0:
>> +               wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS0);
>> +               break;
>> +       case 1:
>> +               wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS1);
>> +               break;
>> +       case 2:
>> +               wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS2);
>> +               break;
>> +       case 3:
>> +               wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS3);
>> +               break;
>> +       default:
>> +               DRM_DEBUG("invalid pipe %d\n", pipe);
>> +               return;
>> +       }
>> +
>> +       amdgpu_ring_emit_wreg(ring, wcl_cs_reg, val);
>> +
>> +}
>>   static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>>   {
>>          struct amdgpu_device *adev = ring->adev;
>>          uint32_t val;
>> +       int i;
>>
>>
>>          /* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
>> @@ -6682,6 +6714,17 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>>          amdgpu_ring_emit_wreg(ring,
>>                                SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_GFX),
>>                                val);
>> +
>> +       /* Restrict waves for normal/low priority compute queues as well
>> +        * to get best QoS for high priority compute jobs.
>> +        *
>> +        * amdgpu controls only 1st ME(0-3 CS pipes).
>> +        */
>> +       for (i = 0; i < 4; i++) {
> Same comment here.
>
>> +               if (i != ring->pipe)
>> +                       gfx_v9_0_emit_wave_limit_cs(ring, i, enable);
>> +
>> +       }
>>   }
>>
>>   static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
>> @@ -6774,7 +6817,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>>                  2 + /* gfx_v9_0_ring_emit_vm_flush */
>>                  8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
>>                  7 + /* gfx_v9_0_emit_mem_sync */
>> -               5, /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
>> +               5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
>> +               15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
>>          .emit_ib_size = 7, /* gfx_v9_0_ring_emit_ib_compute */
>>          .emit_ib = gfx_v9_0_ring_emit_ib_compute,
>>          .emit_fence = gfx_v9_0_ring_emit_fence,
>> --
>> 2.30.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C94ee191a465b4aa441d008d8c864bde7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479682338092636%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=g8wQEFZDuLBfYH8nzrKh6tPgbUqvnyHjM%2BrJHqvbybA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

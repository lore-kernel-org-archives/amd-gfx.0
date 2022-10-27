Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F6CFA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7994210E6CF;
	Thu, 27 Oct 2022 18:56:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0093B10E6CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/XwvXcMNWPRcqvR9R2QLAfXmiV9wh90iXRs+5UtnlbjZyF0oVENoeLw4gUJ5foyLRlOIWwYfhdHjABzjko0kdZpeljnwFqPHYqNdq03wxBcH66KxJiskGLyYTG18YKK2FKl8DVAojAh4aDbpGym1Ix2lqv0kd3LQj8SjjXpvS2VVuHWYqHabf2M05iQ8KR/eDSol2MaQDo2g7MtP+1w8IDQz9WocdysF86iCEu3YLPT64MIjhNYW1KPhh8ciqOqLC4EiQ9Dv5+TiSaqb9jVzgqvvAB8mW9Uh787j6sQSnXAmKk1jV4YAEdtLRv8WiZ8YS1KIErv9TrhQZDVDSw65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fsdwcF1H9cIQ0DMJPOmm0l4Hr4eSC2K29IxJpsNLf8=;
 b=LRdkR2kzz5JtIikgtBFRbSYXoXuHZjxnNF1ngO3pfH/1O6vnPMSrTYwwsi2OGpa44T0+dAYNTLibXu1P+7wb4anRPz+CKbUBIdx9JQWvwXfbzDWbl6foLJKcxFbq2obq3E4b9a/Sh4ZzCmSTdrtEQNCEB1PzhjidwUmHI9kcQgBomvaTuliABzRm4b0JRQ7OdAH7By7dIJZX3c5ZI89fRDiPwDUoT5q7DjASlIAdpViHb/SQPzAIN4PYeVtDGLUxsFZJXGA/TAjNVHk4AHiu7RdhufZm9MdfNm51K58OUqH+RiOla8v91D6Gly7eiXz+cDXPEoIVXK3wgqjrrne4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fsdwcF1H9cIQ0DMJPOmm0l4Hr4eSC2K29IxJpsNLf8=;
 b=K5fx8OB0DDJUmHbSFzleBAywv/Y53sj0y9wWkVt4Jkw9HxOBtCo6qjr4ytldkrN8EJaYzHgXT9ih/El5KzPu+NfXoYd3u9SRvhvN/xLfc4I7mf2KsMByh9yCYuLQb+6TUBPcVlmIRZl4M0zkjWPcpQx4FAtVeqy0WJyj7usQ7ZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 18:56:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%7]) with mapi id 15.20.5769.015; Thu, 27 Oct 2022
 18:56:07 +0000
Message-ID: <75618f90-0e29-d4a4-34b2-934fdb71921f@amd.com>
Date: Thu, 27 Oct 2022 14:56:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: switch to select_se_sh wrapper for gfx v9_0
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20221011212820.2669221-1-alexander.deucher@amd.com>
 <CADnq5_N95f0zOYzsyU86Dqz6bZa=RMtg+ef0ePdjd1zvB8OEvA@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CADnq5_N95f0zOYzsyU86Dqz6bZa=RMtg+ef0ePdjd1zvB8OEvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c75091-b1b0-4fb7-af01-08dab84ce7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rr96sT2J2swxzhlxYFPb3QXDJGTEeiOVxBiLmIfMyLp5l7TvUHw8ZdaKo6yXIOJI9shWMpkIUIHh0D79Sh9pzMBrHgnl6lhtp4zv857jf0i0Pko614IuND+1sKWsa/iOTm+56APn1ynzDzbd6UIvdo/9caZ7AunjYzUPrV6mivrm1Dam+8PitNVn8dKngkbJf+MnvIafXw7fcuLXKnJzn1S+HSO1aagz+VvpyBC/rpndluEjkDnV96QDhS6Ju5FnL88Z3TexAHC+9tw6Ka7koekEDKT5YgZkxAmJzyyAFCOYujbvepmeYOPVtgtHno7P6DgXFJ2ASPyDRz/hBfMcD/tD/wHPS96+W2jeXf3tIx44n8QWNwRVsMBgXr2YrA070w0QdMN5v5k1oo5XLQmOToTyxrVPpN2zTBSEvC+KkTbvIGqyiffCSSfhB5W9b6MogilfPGyf0kUGyf+Lvrc3VueJTbLXYNFOGCS5VBDjrcM1up1fmzKayIPayiO7P8ygjeJZO+o4VIqHhCijEexIVSHY2jlH+4FA9LBTNpznKdXbCp9QOwwioABKsjCdkJ7DlmufqaYQvWqiOuuy1Ptc3on4SC9tT7ig2+ouQAniQ8qA0nIkATSEYrr2s6o4spqayj30xTWN+c2yAg1yhCJ+QGOvW3UYWNitnpgjo2wpoG2qx0o2m97pi04B4SwbwLiqzW7ZOUS9Wk6KYCE0CgFYo0ZLqzR2D10JMmi5APcM8U52522C88CaGZBgR9tTkryLssEHaK1MdI3oe0bKigFQWBguATZSN6ccILpJDdWF4q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199015)(6486002)(5660300002)(38100700002)(478600001)(66946007)(31696002)(41300700001)(66556008)(86362001)(8936002)(4326008)(66476007)(8676002)(36756003)(6636002)(110136005)(316002)(31686004)(54906003)(2616005)(53546011)(2906002)(186003)(4001150100001)(6506007)(44832011)(6512007)(83380400001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVBCdVRWVitLOGNtR3pkNU1MN3lweHVDYUNjbEN2OEtha3pHNGtoWHRLYlRx?=
 =?utf-8?B?cGpkS24wOUtEUXRobTk3SzFmVVgxU1lDMVVnWnptRGlCWkQwN2c5eXFpMHRM?=
 =?utf-8?B?ZTBTOGpXV01DUEp3S3FaR3ZVTTZrdzk5cEFzNGVxcHpSelpBMzJ3bk5Zalp3?=
 =?utf-8?B?K0I4MTFUbDEyQm5wdC92NGNJWXU0NWd6dmh6QjRzbXIwdjY4bzJQc0N1bHpO?=
 =?utf-8?B?YWZZcEJ2amR6eWJMckx1TXhwN3YrU01ZSVhqQzV2bU5rK3dYWWQ5clJ6WGhY?=
 =?utf-8?B?OFBvZUhpSDdZSVNjZ3lGVGNiRG13MzVsanhwWE5mVkVPUk9ONFMwcmVRUDc5?=
 =?utf-8?B?bGhrOWI4SlhPMmVVMHFiYmNJTnNMRGtubktrbVp3OHNMWlREQTNaUitqVHly?=
 =?utf-8?B?Tm8zbGNNWkZzblFTOHVQT1ZVeWZob1RVbnBwUGlPUEdzYlo1U1FKVlRxdWdt?=
 =?utf-8?B?cG9aeWp2UHNqc3lvMGYveS9iZ1lKdk5OVkdXcE10ZDRacnVqRzRTY1pkVWZ5?=
 =?utf-8?B?bHBxcTBaRXcwVXI3RHpCaUdmeFZ1OHdHVlN5alZpSUlhZmkrQW9YTXlyMzNn?=
 =?utf-8?B?c09YVWF1N2dncVlnVk1mWnZEKzdzbUNNL0dYcDQxUkhncXRpbWZUZEMzRjk1?=
 =?utf-8?B?THNRaW9hOEZDdXRkQkhNT2MyeXpma25GSGdEMUN6TlpJRk1vRXA0NDJkdjBm?=
 =?utf-8?B?WjBUbStJaG0xSG91MEpWRzV0SjEvY1RaNmUyUkZhWVI2UmlrT0pwQnhCMUg5?=
 =?utf-8?B?TDhrY2s4NkhyRFhWTHVjOU9kZmZESFJsTFUrTXZzUEVPd25lMlBCNG5UTkcx?=
 =?utf-8?B?S2VZalJXSWVyMHVtTjQ0em1jZ2syYzZ4MDBWK1c3T0szNVF1VXZhdTFRM1lz?=
 =?utf-8?B?QW1iZjB4MUYvQUYwOFY2TnQzWjc5Qi85c2FMVFNrd0JFZlBZaE5yMjRNbFVO?=
 =?utf-8?B?RkVXekZ0SHMrbVlHUWtlSnk1RnRjK1dqNE5NaHdjZnE2cEpmK1hjT25QQ0pB?=
 =?utf-8?B?ak1hSVVqbnBqZk1KSzFQMHF2cEZCeXM4aGw5QTMzTzUvMkdvZnlIVTBMSmJF?=
 =?utf-8?B?ajQzU0FveVhxNlhSS0Z1bk9NTmo4dS9tSTJBakNBbnQ1c2NSZ2RQbTA1RjVZ?=
 =?utf-8?B?ajNoL01mOFhWTHY2dHJ0UUU4ZWVWTTVuVndZWTlZSE1PcVZkU29DSGZLTzJu?=
 =?utf-8?B?QXdCaG15M1BHTHMxK3V0UStQREhlcGV5UU9IUGtwZUVtODYwOHNDUzVSdS9a?=
 =?utf-8?B?ejJESkJQaUU3ekdNcE9DS25GdkR0V2J2WU9OMktuajlkSUYyUW1aN0ZaVktI?=
 =?utf-8?B?eHE1Ris5V1p0c0ZZejlEeVNEUkgrOG15WnRpd0djV1k1N0ZNbFc4L3p4cEtu?=
 =?utf-8?B?YWJvUU1EZjR4eUJGb0s3aVU1OXZmb3JkM0lNc1laNm45UUNZNXY4cndacytJ?=
 =?utf-8?B?NlVPU2pvODIrd3hQQzg4dEs4YURTdTQ3ZU5vV2p1ejdwT1haakdlYi9COUd1?=
 =?utf-8?B?Wm1aRzZKYUtybllIbnQyV28wZFZ2MVl3Vkxabi9PYUV5Vnhqd3k1SGVnSkFT?=
 =?utf-8?B?LzczWGpBR1IwMTV3T2ZxSlY2UEkyaGt2SGQ2M1FpZE83ZzlGSEo4KzJjek9p?=
 =?utf-8?B?SGNEMHpodkFTZlU1dUxKczM0SmlIL3JmNmd2WjdEc1ZiV0xCSG1ZRng4S0gz?=
 =?utf-8?B?Q09QNWhIT3YvWnlCN2IvOWVVbHp5ME1FYTE2ZnpQeUpXYytsTEVBclVndEdF?=
 =?utf-8?B?VTh1UmxkYmVHcmpSMEJNc3JYS2YyR3VEa05ZKy9rZVdXY2tqVGQ4WWxncitN?=
 =?utf-8?B?Mi9kdG5OWmdacXhkck40MVFiWnFhU1cyZkFFTUtRRm1vQ2c2UDdSenR6RkFI?=
 =?utf-8?B?czh6ajRQWlZwN1RMN3I4VlhycXVrekNZcXlrS2J1SEVZWWZCVTRwdFFrV0N2?=
 =?utf-8?B?aGdsWVBwSlZPWEFPZlU2SHpnaWNLMlFLVmFOVmZtR3RJRUkyS0JsQ1NteCtR?=
 =?utf-8?B?emJ0WXVhbmVzN2txRXA3VjgwNHNiTDB4eDJqay9JcEtzTFpBU1FseGRYRUFy?=
 =?utf-8?B?YTJVNkp0VS96b1hnSnpPaXpNT1NKaEtEUEtTaDdJcyt6Qy9wSHJFSjVvSXhj?=
 =?utf-8?Q?fZE35fwUVtksL3b0N1gwQx7qC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c75091-b1b0-4fb7-af01-08dab84ce7eb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:56:07.7009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vf1XtlpNjUhWFl4HvJVpukmwsT5u692xKDhlFRvp0hPU0pf7Du9fTf1IdkAZ6b5XBuYfpfzVW+jI/L2gcQGe9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
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
Cc: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-10-27 um 14:01 schrieb Alex Deucher:
> Ping?
The patch already has a R-b from Ma Le. Anyway, the patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> On Tue, Oct 11, 2022 at 5:28 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>> From: Hawking Zhang <Hawking.Zhang@amd.com>
>>
>> To allow invoking ip specific callbacks
>>
>> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
>> Reviewed-by: Le Ma <le.ma@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 28 +++++++++----------
>>   2 files changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>> index 81e3b528bbc9..e92b93557c13 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>> @@ -787,7 +787,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
>>          for (se_idx = 0; se_idx < se_cnt; se_idx++) {
>>                  for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
>>
>> -                       gfx_v9_0_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
>> +                       amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
>>                          queue_map = RREG32_SOC15(GC, 0, mmSPI_CSQ_WF_ACTIVE_STATUS);
>>
>>                          /*
>> @@ -820,7 +820,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
>>                  }
>>          }
>>
>> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>>          soc15_grbm_select(adev, 0, 0, 0, 0);
>>          unlock_spi_csq_mutexes(adev);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 0320be4a5fc6..456c8e189b7a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -1564,7 +1564,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
>>                          mask = 1;
>>                          cu_bitmap = 0;
>>                          counter = 0;
>> -                       gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
>> +                       amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
>>
>>                          for (k = 0; k < adev->gfx.config.max_cu_per_sh; k ++) {
>>                                  if (cu_info->bitmap[i][j] & mask) {
>> @@ -1583,7 +1583,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
>>                          cu_info->ao_cu_bitmap[i][j] = cu_bitmap;
>>                  }
>>          }
>> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>>          mutex_unlock(&adev->grbm_idx_mutex);
>>   }
>>
>> @@ -1605,7 +1605,7 @@ static void gfx_v9_0_init_lbpw(struct amdgpu_device *adev)
>>
>>          mutex_lock(&adev->grbm_idx_mutex);
>>          /* set mmRLC_LB_INIT_CU_MASK thru broadcast mode to enable all SE/SH*/
>> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>>          WREG32_SOC15(GC, 0, mmRLC_LB_INIT_CU_MASK, 0xffffffff);
>>
>>          /* set mmRLC_LB_PARAMS = 0x003F_1006 */
>> @@ -1654,7 +1654,7 @@ static void gfx_v9_4_init_lbpw(struct amdgpu_device *adev)
>>
>>          mutex_lock(&adev->grbm_idx_mutex);
>>          /* set mmRLC_LB_INIT_CU_MASK thru broadcast mode to enable all SE/SH*/
>> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>>          WREG32_SOC15(GC, 0, mmRLC_LB_INIT_CU_MASK, 0xffffffff);
>>
>>          /* set mmRLC_LB_PARAMS = 0x003F_1006 */
>> @@ -2324,13 +2324,13 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
>>          mutex_lock(&adev->grbm_idx_mutex);
>>          for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
>>                  for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
>> -                       gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
>> +                       amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
>>                          data = gfx_v9_0_get_rb_active_bitmap(adev);
>>                          active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
>>                                                 rb_bitmap_width_per_sh);
>>                  }
>>          }
>> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>>          mutex_unlock(&adev->grbm_idx_mutex);
>>
>>          adev->gfx.config.backend_enable_mask = active_rbs;
>> @@ -2467,14 +2467,14 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
>>          mutex_lock(&adev->grbm_idx_mutex);
>>          for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
>>                  for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
>> -                       gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
>> +                       amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
>>                          for (k = 0; k < adev->usec_timeout; k++) {
>>                                  if (RREG32_SOC15(GC, 0, mmRLC_SERDES_CU_MASTER_BUSY) == 0)
>>                                          break;
>>                                  udelay(1);
>>                          }
>>                          if (k == adev->usec_timeout) {
>> -                               gfx_v9_0_select_se_sh(adev, 0xffffffff,
>> +                               amdgpu_gfx_select_se_sh(adev, 0xffffffff,
>>                                                        0xffffffff, 0xffffffff);
>>                                  mutex_unlock(&adev->grbm_idx_mutex);
>>                                  DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
>> @@ -2483,7 +2483,7 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
>>                          }
>>                  }
>>          }
>> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>>          mutex_unlock(&adev->grbm_idx_mutex);
>>
>>          mask = RLC_SERDES_NONCU_MASTER_BUSY__SE_MASTER_BUSY_MASK |
>> @@ -6482,7 +6482,7 @@ static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev)
>>          for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
>>                  for (j = 0; j < gfx_v9_0_edc_counter_regs[i].se_num; j++) {
>>                          for (k = 0; k < gfx_v9_0_edc_counter_regs[i].instance; k++) {
>> -                               gfx_v9_0_select_se_sh(adev, j, 0x0, k);
>> +                               amdgpu_gfx_select_se_sh(adev, j, 0x0, k);
>>                                  RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
>>                          }
>>                  }
>> @@ -6544,7 +6544,7 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>>          for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
>>                  for (j = 0; j < gfx_v9_0_edc_counter_regs[i].se_num; j++) {
>>                          for (k = 0; k < gfx_v9_0_edc_counter_regs[i].instance; k++) {
>> -                               gfx_v9_0_select_se_sh(adev, j, 0, k);
>> +                               amdgpu_gfx_select_se_sh(adev, j, 0, k);
>>                                  reg_value =
>>                                          RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
>>                                  if (reg_value)
>> @@ -6559,7 +6559,7 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>>          err_data->ce_count += sec_count;
>>          err_data->ue_count += ded_count;
>>
>> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>>          mutex_unlock(&adev->grbm_idx_mutex);
>>
>>          gfx_v9_0_query_utc_edc_status(adev, err_data);
>> @@ -6963,7 +6963,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>>                          mask = 1;
>>                          ao_bitmap = 0;
>>                          counter = 0;
>> -                       gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
>> +                       amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
>>                          gfx_v9_0_set_user_cu_inactive_bitmap(
>>                                  adev, disable_masks[i * adev->gfx.config.max_sh_per_se + j]);
>>                          bitmap = gfx_v9_0_get_cu_active_bitmap(adev);
>> @@ -6996,7 +6996,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>>                          cu_info->ao_cu_bitmap[i % 4][j + i / 4] = ao_bitmap;
>>                  }
>>          }
>> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>>          mutex_unlock(&adev->grbm_idx_mutex);
>>
>>          cu_info->number = active_cu_number;
>> --
>> 2.37.3
>>

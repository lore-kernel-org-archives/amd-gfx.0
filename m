Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9949AEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 10:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8DB10E221;
	Mon, 17 Jul 2023 10:11:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC2910E221
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 10:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YazoBifEZcpFiZpHN7C36jQZvZtpZs5HQGs0AK2AAw98oQDLLBN3a8jD+imyr0WwcIgJ75x0eIPoKxnY5mItQk/YmdO5iW7kbAcaAhpG1s82wsEFyqod6FCxiwWclGez7Ul87udvqvOdRV7rcaPVJ0joPDeQSnVi8cxUJgZVOboJc3jLmXXJzFMCN7OKwUAGBZf/z5WPBohkQijCbgwvyROIpYjCFRVSSGYw0ssdTKg7VsFVRotunvzxPsjrW8+FeEc8eBY4e0DwVYzeok2C3mGm+rheOa91RBO2wt5e+9Qc8dUSIsie5KSSIg0zrOYYH5JhKXhjWF8h8O3mLzMkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVgxXrswIiizm3+zYyowGOKEAkKqsIFa8N93SUasVOc=;
 b=AB4SfGJRgNMkyTDW3Yx/tdvJLdvSkAlG/c+rrMD9yjv9srT5USHG6rZu5Ih7n2Sl7+0SDhwfO0IC/KkVS+DQ0Ry0S7tYGTSSV0BzGoXlwbVxBfxnd71eYVLYG5m5W4MNKAjASfOoZsdJwlhmHCmcLuRtxcNeTTNVV4P8ZZ6cHJreA0f0Xd3Xlq0xGYzi9NKGr0EQWLiEuzLs8ElEynYSLswRYO2AiBHOnVpKcCJp3p8OIGGht2taogSxvLK8HUAr9DN86YUwfwia4JKuEPHy0mJ22piRckimRFgUhKAMlZPsawe5MR9gCgIk18k60pZ+QTS29Jzvd+FxRfUMXn74UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVgxXrswIiizm3+zYyowGOKEAkKqsIFa8N93SUasVOc=;
 b=ajxKk+KD9Q84XYuBEZC8AQ7sbs8R+YuUvJ+Gv8YXheKvauTeiCIQzBiI6l0sE5zeCQg126Lmem1YDLjqdMjfOqkt2WsdemFXIHUivRAUXwqhLVgMkXZgmSdjqWTFyCMhoNWN6fasrU7cvHpFveskQ52mB2XJW95E16Jq4GvHHDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 10:10:59 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::4aa7:3431:dc3:4388]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::4aa7:3431:dc3:4388%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:10:59 +0000
Message-ID: <9519a041-b384-ddc9-57d5-8287e269cee0@amd.com>
Date: Mon, 17 Jul 2023 06:10:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] drm/amdgpu: allow secure submission on VCN4 ring
To: "Guttula, Suresh" <Suresh.Guttula@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230714094448.3178171-1-Suresh.Guttula@amd.com>
 <f4d3835e-f22e-3403-e917-c23b595784c6@amd.com>
 <CY5PR12MB6648350EC2B84CAD1D68176F933BA@CY5PR12MB6648.namprd12.prod.outlook.com>
Content-Language: en-US
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <CY5PR12MB6648350EC2B84CAD1D68176F933BA@CY5PR12MB6648.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::28) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1fd9dd-5161-45c3-b307-08db86ae1e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20qeptMkfycwqf7MLpOu8xysChXyyRNCf9piZ4bgKWeAvNpk6urj/EQxuk+zYobxMh7L377aK1MYHMkWbAtJkzjxEMnZyiOaiqDNm6JlE9oMbp2hE2lLYZRMugHQz6DaeoBJ4ItbEc+YaQnhPqjKMLfO5qCqmRU3vD8/Sktyejn+CLwl3QEbDAZezHC8Pe1dwWOTQ/nRHIzWuFnwKY96S1udvlh34PQr8V+enWryjyrTe8Fw7F+SCMTOUDS1PammcZ7BOLQXz3tFHjDMl+HAlMFxGZc5ybTpp2/qFkCfTdsQc0G4W5utFHthWzm5EVZQYclNlgFbCji6MxtlWkmYbSv4UNU3gcKkWJ7C5HqtIEs3kBJb1xMPGcgPrUfLoMtyOdrF9pvFeXecexS8wvFRbsA+KFyoXdQm0LxYmzDgut1xpVEjr2+1uTTDXAWRE04Vg5bX/8n186fGvrUmAPoJtYmRUqtgf/sh0f/0BKGgjezVNYBu1ykzbgA0H7Wg3WhzJljJqcuGfWnpjEdmK7T7IGPljK80ndTbUZ1h6BD8q2q5UbDrfED1VSbVoGaUtx3y/QIapbxINycScSX1ljMxzOn6GgWmeIWPPRCVnG/TqSA7XVy6d3PbyHGn1OkcbEyQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(186003)(26005)(6506007)(53546011)(966005)(31696002)(5660300002)(36756003)(8676002)(8936002)(44832011)(478600001)(6486002)(110136005)(316002)(41300700001)(66476007)(6636002)(66556008)(4326008)(66946007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXhpM1l4SCt5aUcxa3hjeTlUVHlLVTN2ZTFFYTBtQURHaWJ5M3d0QmQxQ2Fl?=
 =?utf-8?B?L0tTbE1salpxVlFCVFpMbHlNV0JpSFM1REwwandNc2szWGdxRDFXTzFsQ25U?=
 =?utf-8?B?L0gxTjE4WitxQjg1SFdOVzlXT3MwYkM2WTBZdUZGcGVyUmdVeUdVYTFIWlhM?=
 =?utf-8?B?K04xWnpMQ1FobDBBK3FUcHQ1MU5leEsxdkRGdDVSdGdQcmdMNm9nS0NnazU4?=
 =?utf-8?B?UmRMOEE0enNXaVhuZzRsQUpEZ25pRHhkQVgzdUpsK0FydWFXdjZCMmpNY2Zx?=
 =?utf-8?B?dXZJVUg0bjF0RzhHaldJbG4vdmJvd2wvOWJvUDkvdWpQMnJjRjVXSE5OTlVq?=
 =?utf-8?B?M2JDNHY2T2lRWW1GTlpxRmkrK3ZodmFyK0FRUzF5UmpBM2swcm80dm13U1FH?=
 =?utf-8?B?YklBSzZhR3RhV0tqSnlXSHhQajFsN05PRWJDUkVSYjJ0VFBPWnVQbVdJdlJH?=
 =?utf-8?B?V3c2aE94UlBpN3N1ak10UnBabVNCaVljd3E1ZHJqclJCL0ZTdXgyYW1xM3Y1?=
 =?utf-8?B?dzdzK290K0JUZ3RIR0V5cU9ndnJsZW5xZWlWNTl0UlRUa2xScGpsK0l2clBH?=
 =?utf-8?B?b3RRSC85bnozSGFIeGNCUyttdlI1UVBhWHlDYmUwa2dQUWlpZ1M0a3BMbUl6?=
 =?utf-8?B?T3Z0QU54cSt5Wm5Ob1RlaTVBM3JmcXBvaXp5ZFl1ZTIvRnZ3RUVjZ29RS2Ir?=
 =?utf-8?B?Q1dtbXptTU9WVlJ3eW9MQlpFU1VHdmEyNGZ1QkUwamNieGdVVjc1WThOV0h5?=
 =?utf-8?B?eDdoWFkrU1IzNUQ5Y1ByN24wTkhHYlVoV3RGMHNHWVlYV2pONkFSYTJPcW9X?=
 =?utf-8?B?VzNoYlVzai9oYzQrVjRscHpqRnhibDhVRWhSYjJiS1VkS0R3R3VmWC9HVnNL?=
 =?utf-8?B?T09BMmt4MC9rY2s4VDdFMTVINzNMWW5kZTZtYWhwbWtLVko5QmNCbTZiMVRN?=
 =?utf-8?B?SWcwUlZNVWRoUnhUeFE2eTZOOFNDZ1R5WWlqaUhBaGt5ejYxbGZ4UHVPYUJ6?=
 =?utf-8?B?YUpRUVBnL1IzTzJRdVpUMzlDVWlpTmdjUWR0OTd5OUFVQXczN3VrMWV5U0lV?=
 =?utf-8?B?SXQ0Q0cxeTBPWmpmZE8yckNkcXJDMmxLVFlGWFR0VXRpUjlWL05EUFk2YzJR?=
 =?utf-8?B?QnI5VXpVS1FjVHRuZWxUOXB3MzBuMzl5ak5RMUF3Z3EvT3pRQUtoRDVZTmpX?=
 =?utf-8?B?M2FrZWEwU3hDRWprZVlEWExyNGJud2hMM1BlQmtWb1hhaVpWSnJPaUdTWkNX?=
 =?utf-8?B?QlJxL0IyUGgwTWlXdXRkZkEyVVQzVk95dUw2Q3JLZWMwc1RreTl2cFJjT0Yy?=
 =?utf-8?B?MTAvMHNKUmhFM3FxQVVob1IzM0dyVlN2QzFSbTNxV0NmLzhoMHB2OGtSd0Vv?=
 =?utf-8?B?RnNMRWFydXh5dHBvdGdyVVVpTzdkaEhsQTlJQkRjQUMzaU1UN3ZKTFR2WmZU?=
 =?utf-8?B?UUpoMU1vcUhKRWpVekZLU1k5dGt3WDlMOXU0andPcVRyUVhEMW0rSzVKWFUr?=
 =?utf-8?B?cDlNRDYvSXppR0VDR1pvbFdQZGprR2Q1WHZmekF1VjVYSk0vQWVrQy95cnFC?=
 =?utf-8?B?aXpCeEp3QWF4NGdGM0xqZTVmUzdEZk9FeVdyd01pT0hOeTdLWW9udUFmWkEx?=
 =?utf-8?B?c0VRWlFYWVRWWVV5RmhVaitlV3NUbHBEcVAzYng3VldOSTZNaVo5NjlTOU5P?=
 =?utf-8?B?WkxKOUFwOWRMQlVFK29sS3lDcjdUODZTaHpCTlpDMEJ1V0FDRGc1L2VXY0sv?=
 =?utf-8?B?WE9lSUNKQXowdVl6MDZpUVlPYTVPTXRqTkZvMzlKWnR0UkJDTFlWTnhXcTNr?=
 =?utf-8?B?a3V2M1g4b05uZEg3S2ZYMGFYVFhpTUpIdkpLWkdCTnRsUmF4enVHVm1QWVpw?=
 =?utf-8?B?THpIeStjU01vRTYxUlE1VXRwRjZJc2ozOG16cUc2cStYUHFMSTBxVkx5S3ox?=
 =?utf-8?B?YnY5b1g3UUZmVWQ5d3puS2tuaHRxZnJuaG83cUNCdU91dXYyVmdzMnVlbys5?=
 =?utf-8?B?eG1iV0ZYN1prRUJPRkpaU0RXM1A5MDlLbFZvZEM5R2xsaXM0SFlTRFFRNzhJ?=
 =?utf-8?B?cDkyUFlzUFFyaDZLb05iOWNjZTdUTmNQM1ltbDVqaGczTUZVMUgyT3pIY2tn?=
 =?utf-8?Q?3pYE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1fd9dd-5161-45c3-b307-08db86ae1e39
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 10:10:59.4349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpmziAJMZpi58R/X0MBC7IE9c4p6CupHr8B2NV1sTQ7sMCIYaBRcoCzHvTu/XxhO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since the changes will affect multiple ASICs, if you only tested with 
VCN4_0_4, please just apply the set to that HW.

Regards,

Leo


On 2023-07-16 23:15, Guttula, Suresh wrote:

> Hi Leo,
>
> There are two issues here.
>
> This change fixing the Crash while secure playback and we see below error:
> 2023-07-14T15:51:24.837592Z ERR kernel: [  129.255823] amdgpu 0000:c2:00.0: amdgpu: secure submissions not supported on ring <vcn_unified_0>
> 2023-07-14T15:51:24.837601Z ERR kernel: [  129.255827] [drm:amdgpu_job_run] *ERROR* Error scheduling IBs (-22)
> 2023-07-14T15:51:24.837603Z INFO kernel: [  129.255834] [drm] Skip scheduling IBs!
>
> The second one : https://patchwork.freedesktop.org/patch/547587/
> Fixing the garbage/corruption.
>
> With both patches playback working fine.
>
> Thanks,
> Suresh G
>
> -----Original Message-----
> From: Liu, Leo <Leo.Liu@amd.com>
> Sent: Friday, July 14, 2023 7:08 PM
> To: Guttula, Suresh <Suresh.Guttula@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/2] drm/amdgpu: allow secure submission on VCN4 ring
>
>
> On 2023-07-14 05:44, sguttula wrote:
>> This patch will enable secure decode playback on VCN4
>>
>> Signed-off-by: sguttula <Suresh.Guttula@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> index e8c02ae10163..d199f87febd1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> @@ -1804,6 +1804,7 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>    static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
>>    	.type = AMDGPU_RING_TYPE_VCN_ENC,
>>    	.align_mask = 0x3f,
>> +	.secure_submission_supported = true,
> We should set it to true  with VCN4_0_4 only for now, and check either this boolean or VCN4_0_4 with your implementation from patch 2
>
> Regards,
>
> Leo
>
>
>>    	.nop = VCN_ENC_CMD_NO_OP,
>>    	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
>>    	.get_wptr = vcn_v4_0_unified_ring_get_wptr,

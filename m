Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D1BC2FC32
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 14:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3FA10E48F;
	Thu, 17 Aug 2023 14:07:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0498310E48F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 14:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFMvEvKE4IyZf02HBz6R8nQYEIkrgC0njtCOjbq0ge7p/wXUtnkGQI+mKI3raQiQb2+iHh3O0asHa7li72K/ASvxEK9XM92BICWDidh0gOBQsoIfV8OqKqWgwG++B8OGHYlHghBoZYp55Y2sS9sYUDLTBMtPVHS2uJStTDD6E2D5SWoOBYSTYa6BkeM9Er8ZMhaqB6oX5+nRoTHXNkapq2I7Oe92CiKN5xBuBKigOfEwanJB5T6+80M7ZBoysyQm24/ktRrM/QSDLR4wCDLglIn4VNmndHxkwCrORHHDKyYY2McPipO6mglbyyidouwOjzEm7VIeUU0z9Uk1y59tDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtJ8XBmkJQUPw6mw7x/+U/U5CHoM/j5ALAQiaKCJASU=;
 b=JFQgscm4Ib0Few/mos/VEurxHTL3lD0VZlH4Cc7tLpmyjW2/LyNevXGbP+S7QXmOafGq5L+K4U3/EduMHVlnWoARBdEzILS5/rCwPnfs7AVRLBJMKDGhD8Dkj0B1WVhEG1KCetRnoE2sTdPlIO5V39k9TkUDTxg87empGcktKktSOCC+pH4PXdKjMxTUN9QhbOGKED5kKflmkmfw5K5BCgpMzwHTdE99+iQadFk5lq77zJBF2hwhpMtlRUwBhTfWKBJdfnttyNet5GH7Hh1jWD/qqaNn/pbpZf+5MvPdTti3rgXuKkbhoullztHL/rtKwTfj/Ua7LzXNUD74GiYV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtJ8XBmkJQUPw6mw7x/+U/U5CHoM/j5ALAQiaKCJASU=;
 b=Ge+Rq9Srfz4mdQS6CjIExXkiJ6wS0vzy5wUBIAPvI4e/D2w4YvfXITjX0/tqADZUat186FpQP86JwpNiKHhJCXrQYClJq/FbQairjVa8/WUrnJNaugYrxHLwN95lGmmWwshEHWGSOxZcFKJ+oICoML4MHjvjKLBcJskh3/TiIDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 14:07:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:07:04 +0000
Message-ID: <1ab90013-a6c9-4d67-bb58-f82ac953b8e2@amd.com>
Date: Thu, 17 Aug 2023 10:07:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] drm/amd/display: Create one virtual connector in DC
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Alex Hung <alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
 <20230816212626.987519-3-alex.hung@amd.com>
 <CADnq5_OD1Q_QOM38-JrYUFjkbQmH0rjww3p-fS36u_sn3_4=wg@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_OD1Q_QOM38-JrYUFjkbQmH0rjww3p-fS36u_sn3_4=wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::38) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe7af0f-8e61-4d7c-2c92-08db9f2b3c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2m/PcaIJFSw5cGCkgG5Bc6oB/mmmABtKHw+Exm1UjGpXaSJg6PwFoczyyu76nEBJBq9Gzsmho+k0bjXUCxHlr12cyqYIh4FQZPjBoiWGqim+DOy7EqvXJ5/AUObf1fPZ0OfoIt8m/msOql4ZogeIi5cUKr1T8XmvLpEQRj2GQ1wApSulFyjH5IgIrmgCQqFpZeF9rT1W1y3FxPhjc3qzoyFXt67XFxnZ/Q9NB6fL6cvoMhtuuVj4dBGFwFY/7T7gc1g/4VSQ3cbs+LvQ5MUCcStI+BXO1o78KSn0OGikqkvxonDldUmTfbGhyDOOPuAgjOC6rhZYUoiy6+ScLfuawijxvzlshxd2qgwYSSZkknG0OpRFjXakxfJRZE44pmjODXgsnhKpzdA59NUsoFHcaw41ZZW1JzbjugXLWYDvipw2pXCW/FfBkkXCn05LYUxbNg26gST4UFKhAlUXXou92ZLlPtlxNEgvGuIeVKQsDmnMWl6y4MJdN++c66Ut7Yk4ryesLmEKUjUOXoDAkjtm0Iu6LkbCrzXto9N/zW3fwYKeYP4JC9k2H2GApHi1HXyNycOL83Oku5q8DgvmJ0rGasl7ogDeltyq7BgN1jNpuBNHlZatSnQN5PClmh8vIp0GA2odao3KDitMmlh0zO/Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(36756003)(6666004)(2616005)(6486002)(6512007)(53546011)(44832011)(5660300002)(41300700001)(6636002)(316002)(66946007)(66476007)(66556008)(110136005)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXdGYy9FaTVvQ2pBUEtneDNrbElxYkdVRzlkYUZTb0UxM2k3dklPMjdWZEJu?=
 =?utf-8?B?NDBPYktGT2daV2szY0VsTXYyczF5VzYzVVlidzlRWEM3N0NMdGltNXduTGFi?=
 =?utf-8?B?VisvNkJIME1vWEx1RjZDNUpqcmdmSTFCSmtmWGhNR2N0bGlZb3Q1YW45OTlq?=
 =?utf-8?B?MkQ1R1VDNmtFMjZnaGlSRHpXK2dUNDZETlhLbTFLNzg1U1JlV3BpVmZEcGhX?=
 =?utf-8?B?NXVqU084VUZnU3d3QjRYVzFFaE5GbEhaRDBpL2Q3Z1g5K2pMelkzOStVTlVx?=
 =?utf-8?B?YkV2QUd0OUtVbStqNE4xb3hWaVBkWFB2SE4wL08xTkc3RjlxbUxEYWdKQ0pV?=
 =?utf-8?B?d1lKcmMzR1hPaGplZk41MXFJRVVPZWN0NDRPTDJLeTRldE9wUldDYXZCNjhT?=
 =?utf-8?B?ZFU0Nno5TkJYY0ZGeUd6ZnZCaXo4cGxpR0pjd0pzWE5POXI0dXE3UTJ4Mkxv?=
 =?utf-8?B?Z0pxUkQvWjBiSU1ZaTNCZGRjcjM0UGs1ZEdHSWJKVnNjQlFSRTJDZEk1VVdG?=
 =?utf-8?B?d2dIQnR2WGZZTHFtYWJMT25jQjczbGc0ZFpLZ1YrM2g3ejN1V1RHMGkyclQ5?=
 =?utf-8?B?aVVaSDhiZEptdi9PcVg4T2QrYzVSNDloSHVxWEhBRC9ya2QrbkFQbkgzQWg2?=
 =?utf-8?B?Rjc3Z0czZXZpL1ZreFRmY3VvK0ZwV2lxNEVXbXRjdWJZd1ZDd0NyeGF5SEFw?=
 =?utf-8?B?VlBiQjAvbGM5Y3k3SjlPcmhOUG1WZTRseGtnWksvSm9ZWDRZcXJ1LzlFRDZw?=
 =?utf-8?B?V3I2WnBsWUNML3EwemkwQkRIS0RycHpoTU9Hb0Z3Q2F1WFV5REZod2xpZkxQ?=
 =?utf-8?B?eTBEMWRsR0RLUTFvRDBSRXA4bkdnTXJsVHAzVGRZZW5OVitqc1hwbFFPRk1n?=
 =?utf-8?B?OXRYNXUwNnNDNnhrbmtNdEE2RFQrY2piRVpzWmZSeWFIV05FTE9TSHkyMGtK?=
 =?utf-8?B?TWx6WVhOU3JyNWNUbGp5NkdrUi9lUURycE5OcGFQVTRoMFdneDQ0NDVHMWdk?=
 =?utf-8?B?a3VUQjIySG1BdnZMVitLbE8wL21EbXA5bUdObSttSVcwcDUvTG1kSEtQUkww?=
 =?utf-8?B?R3V5OFVqTWloT0oxRmlNVmpIbllUZVNYaG9hUWkzSnp0SGFTcG5aVXpHRUpX?=
 =?utf-8?B?QzRJcUpPYjNYUHArYkJEbXRLTEg1TnFUSkthZUVnSW9OYzQ0ZitPZ3djTmhQ?=
 =?utf-8?B?N0w0ZS9DS2U3Qm9OcTJ2MjdwSnhOTEgxTzFDTDZ2SlgzNytuODdnbHBSTkV4?=
 =?utf-8?B?ZnlEUE5iSDhHdTI3TVhwb29BcU50L2RzZ2lkdTdiQmNGdFRKbFRLdDBHYmMv?=
 =?utf-8?B?aThlcExYc1Z2ODllQ0NxdXZTNUpocSt2ZUpCRk9hR2ZFb2kwNVVvbWxJbEdp?=
 =?utf-8?B?V0ZKT1creXZZdEZleUdCL3hwa3VyNGl0NThRMmtORnU3eE5DZTRwbjNWeHNW?=
 =?utf-8?B?WFUwbGR6OFJuRERSbWZTWDZHbFkraFVvUUNrcjU4YktnMEFsZFllUlFtelZj?=
 =?utf-8?B?b1R6TldSSlIyQUlmUmpGQjNXQ3F0b0s0aExwVE83bmdQeHc4UnRQWFM5TjIz?=
 =?utf-8?B?ZHM2dUVEU1psdFpCNVM5U3IvQTljUmRwQUhhUDYzOU5oRUFLc1RVWWt6bXc4?=
 =?utf-8?B?VU9zNDRIWFZXOWFILzRJa0ZsZ2tsSFNiSkRabnRkSWVvenZiSWpoZ2FNNmE1?=
 =?utf-8?B?TkZ4WWkycCtSV3BCb0R3TjQrZm9zWnFyMFBzWmEzRlFaZ01KTEJXaFcrMmd5?=
 =?utf-8?B?dTcvU29ST0dGcXNGazhSa0FlWE5Rc2E0Z0E5UGYxVjZLVkkxbWJFSnJteWpv?=
 =?utf-8?B?VEZqeTc2blAvUm1xZFo2VzAvbDQwMnA0d0ZpeUVNR0tTb1F4WTh4WU1WNW0v?=
 =?utf-8?B?di9NYk55bkY0dWZPR2xjYzg4RGJjZFpvNTMvUWNsOVdrUFpES1RSc3VSbVBN?=
 =?utf-8?B?RUlUOFFISWpxalYxNFltcEJ0V2JyZHhiT2ZheFhPcmV6eGNNK0NQR09yenNI?=
 =?utf-8?B?Vm9ZZG4zRWV0ZkVNNjVaRVU0M3dHbXYxRjdsUVdPckgrWDgvbno0K1hSd3lo?=
 =?utf-8?B?ckVuZjNEbTdnV28yRmdnUVlZUXMvcTc1czBLczcvQ1J4YmhMN2I0WjFYbXZQ?=
 =?utf-8?Q?EWDyeXU5x0rXcCRHONiT3Uicz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe7af0f-8e61-4d7c-2c92-08db9f2b3c48
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:07:04.8916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+Jgh3VcKmru6rk4xojZrDLyxrUh/99cGQzyGtA5A5e0rdlfo1XwSehi8XErlNhOb6LMBJXrayContrAgJYyQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-08-17 09:58, Alex Deucher wrote:
> On Thu, Aug 17, 2023 at 8:45 AM Alex Hung <alex.hung@amd.com> wrote:
>>
>> From: Harry Wentland <harry.wentland@amd.com>
>>
>> [WHAT]
>> Prepare a virtual connector for writeback.
> 
> I presume the main point of virtual connectors in DC is for writeback?
>  Would there be a case where the virtual type would be mis-interpreted
> in DC as something else?
> 

Yes, the only purpose is writeback. In theory one could also use it to
expose a virtual connector, but I'd rather keep that as is, with
amdgpu_vkms handling it.

Without DM making use of it DC shouldn't really be doing anything with
it.

Harry

> Alex
> 
>>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 11 +++++++++--
>>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |  3 ++-
>>  2 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index b1245b732cc9..00254fdfa1f7 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1675,6 +1675,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>         init_data.dcn_reg_offsets = adev->reg_offset[DCE_HWIP][0];
>>         init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
>>
>> +       /* Enable DWB for tested platforms only */
>> +       if (adev->ip_versions[DCE_HWIP][0] >= IP_VERSION(3, 0, 0))
>> +               init_data.num_virtual_links = 1;
>> +
>>         INIT_LIST_HEAD(&adev->dm.da_list);
>>
>>         retrieve_dmi_info(&adev->dm);
>> @@ -4385,6 +4389,11 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>                         continue;
>>                 }
>>
>> +               link = dc_get_link_at_index(dm->dc, i);
>> +
>> +               if (link->connector_signal == SIGNAL_TYPE_VIRTUAL)
>> +                       continue;
>> +
>>                 aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
>>                 if (!aconnector)
>>                         goto fail;
>> @@ -4403,8 +4412,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>                         goto fail;
>>                 }
>>
>> -               link = dc_get_link_at_index(dm->dc, i);
>> -
>>                 if (!dc_link_detect_connection_type(link, &new_connection_type))
>>                         DRM_ERROR("KMS: Failed to detect connector\n");
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
>> index 2a7f47642a44..65e8504e6063 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
>> @@ -96,7 +96,8 @@ static void enable_memory_low_power(struct dc *dc)
>>         if (dc->debug.enable_mem_low_power.bits.vpg && dc->res_pool->stream_enc[0]->vpg->funcs->vpg_powerdown) {
>>                 // Power down VPGs
>>                 for (i = 0; i < dc->res_pool->stream_enc_count; i++)
>> -                       dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
>> +                       if (dc->res_pool->stream_enc[i]->vpg)
>> +                               dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
>>  #if defined(CONFIG_DRM_AMD_DC_FP)
>>                 for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
>>                         dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
>> --
>> 2.41.0
>>


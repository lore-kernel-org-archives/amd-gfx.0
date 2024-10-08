Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C1ACF0429
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 22:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C1710E5FB;
	Tue,  8 Oct 2024 22:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aI8nTCph";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6D010E5FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 22:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlN2Nb+K6mLWTnJLx7lfsh14SgQsefp6DDGn/FMvLs7JtKkXABs+WQ412PipFzt/c7dsq+2eXGNT1c2FbobD7RnV5cuO4vhPYivANCyqGR82NGyRN3orFqU1RlODKjZD3uZ++i2NMky6/nXofs8rhFb3KslUunB7ZCor7HhkeD0X/7MGzfxCIgLoO2P8Wg92doygXYG6OKLdrXvHyP+Jox65kZo6QQTleN/k/vvPjX5W6Ce535t7cjELfawa8dzlOB4hWSH955EScLo0ykBBuyN08fZgrnoQybRvt+SQiSPVxOwspNmg6G8wEjQEMpO54xC8IpaJDtOnq+HL7WqIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPPvEHYPY66xatLx90OXJFfW7BOfKReDrAMzmCWBQKc=;
 b=am3eEPSuWrtPhad/0nY4u4ZUPIo1I2qlxQhmsJb/O45cuG2WVx06P4/vKYJecy5f9LLzPOqFLbdXLiPMn+/mcEk0Tnau3br0rldkZz2FhIOdWCIz35LEW0VKJ4htXIFGz9ER/UkjJEWDbYSwOcA0g/ocUtRG00R2lbB5mPoNCc3EA7ss2xq/SYK+lDwUdWMaTMVJcxT2f0yhZnFWdsL9mi2apCaFtHNPtg86h5B8aoOCyS0NcejeS9gG0Y+e/+pBB3hI/O9SIOEA4UpEqfWm5Jgxd5rh0bcGeJj5w64ZyrOzFANJXcQTrvpVncZe7rxiNfAju5FlALJHtIdsJr1PBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPPvEHYPY66xatLx90OXJFfW7BOfKReDrAMzmCWBQKc=;
 b=aI8nTCphVHBVORw8r7fV2vpxUa3ubec9gUuc003nBiaYDvTGOaYo/MWO8Utn3VnIhHIYhcdTvtaU/+gvXwZOQcTql2scUOmmkHVgxkUvASUWOeTnahRE9cqVN4SBquZXC9Cl0nikZcZBrktANZks+iRYMSQUifl4Tqws8DVF5SU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:06:14 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 22:06:14 +0000
Message-ID: <509608c2-630b-4315-993a-b9671a6671e3@amd.com>
Date: Tue, 8 Oct 2024 18:06:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] drm/amd/pm: add inst to set_powergating_by_smu
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-5-boyuan.zhang@amd.com>
 <CADnq5_ORfYpPigB4z+a0fKbksW8URCsP-Me28yTsE7yg2T72mw@mail.gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <CADnq5_ORfYpPigB4z+a0fKbksW8URCsP-Me28yTsE7yg2T72mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::23) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 41074461-8f7a-4bf9-e130-08dce7e56ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGZMaG5SajdaYjBndHFCR0JvZ2p6dW5FNlFRQkFMYmJzQS9uK1JLa0xqclRl?=
 =?utf-8?B?VFJSNjZ6TkZiOFpoN0tzWnkxWFNjVzl3YjhvdUIwc29UN3dLd1RFSmhsT1JJ?=
 =?utf-8?B?a2VnbjRuMCtHUno2RWVPRDdlNWdUZ0pjMzkvTzBsVEpwN1BlYWhtWHBGN1hr?=
 =?utf-8?B?QVhxV0FhQ24xRVZOdUVwSmUyOTY2eGZmZllCTnIvZFBkb0J3Nm1lRDNFZGZB?=
 =?utf-8?B?L3hyMEpYTzAvSjNLWVBUbDRvM1JZRVFaZWhReGRpd2Vlb2JCdHZFdk5NNUpn?=
 =?utf-8?B?QjBsS1hwZStrd3h6VzErVDFob3JIZTZGRGNMNkZHQ3AyQ2RtYi9zNHNGOTlQ?=
 =?utf-8?B?SDlBeFFvVllnWXJnclgwVkVIV01NTEV6YzVzNTZoUXc1QS9JNm4yTXdpam1x?=
 =?utf-8?B?cUNwaFBUTDlxYWRKbDlneGZuTkNnUW9lNFU2OEtHQ3VtTGZSRGo1bHVSZEtJ?=
 =?utf-8?B?MjByZ1ZXbUdFZkJobkxkUjRmQVQ5UWR3c09WNGsybGJ2SHFVdHgwZHRXOUs5?=
 =?utf-8?B?MUpuMVZIRytwc3ZlUEI5QmtmUEM0eGpWRGtjYit4ZTJoZEdTRkg3SisvNDJt?=
 =?utf-8?B?SFUxUnhTbDZYSFB1a0lsTktNUmxhZjBvbHBDY0o4ZityTEJXRGhMQXhJWDJ4?=
 =?utf-8?B?eElGVTRqT1R4aG5ibGR0ZXI1Z2pHOXZLL0dubUR3WExJbm5vZzhDdWU0OVVo?=
 =?utf-8?B?R0RiZm11Q2RTMGVKSGRZZzJRR3M2NTB0bjhuRk45Z3F3YU5wQ1c3VzE4N2Qz?=
 =?utf-8?B?VkVBbDlremlaYkJnaVBvLytVeUpIMHRLS2REWVI2ODUwMHllb29DbjZZRTkw?=
 =?utf-8?B?cEUwYW0wUTJXSDVmT2RnQ2pKcFJaak05YXdMZjlvSnE0ZWwyTlppY2FhZ2Qy?=
 =?utf-8?B?NVN0dkc0RjVFeVM5Um9kYmRRdXpvQ1RYUkhncTJEUnpiWnlISzZMSXNOMmFm?=
 =?utf-8?B?Q05lYTdCQkh2T0Y0UGpWeGZNWXRYcjg1Z2tjeVpKWGpreE9nZ3lxY3luUm9Q?=
 =?utf-8?B?eitzdFo5cWVFRVY2dkdUUHQvUXRuaVB0YUlwOEZUZ3lUK2hTckNjR1ppY0ly?=
 =?utf-8?B?SXc0YkhFY0wrQmZQMWdCK1lKQThwTHlwRzlLbHM4aWRaOEpoYmFKTEtiZ2xm?=
 =?utf-8?B?V2Qva2NOYmwwV1F0THFqVXJxYjlTbm5TT0pVOWZUWFd4bHRrM3YzOExEN2pG?=
 =?utf-8?B?QWJBazNwTWF1VTgwSjdaMDh5Skd3WC9oWk9YQXhMM1RCNFhOL3pVWUMyZjRv?=
 =?utf-8?B?ekVodGgrZFdHdjN4VzE2YWkwMkdUVE9IYzhpTlRhUnI3MU1GZE1aWExkb3A0?=
 =?utf-8?B?TG5HLzlVZDJXaU1QWVpGb2xVL3R2ZUFKaG1UeDZScjQ3NFE1c0ovbS8zN0Zs?=
 =?utf-8?B?TnVWc0FKdS9RcDVYU2FEeDU4c2t2SVZlOTlWNUVwUFZ3d3Q0VHR3QTVjNy96?=
 =?utf-8?B?aCs3a2Z5QURDZURGT09CNmNzaGRFbWJvQU9TdFRTQlRvNmJWbHMrb0RabTU3?=
 =?utf-8?B?dlErMlZuVlB3Qzk1STRua3NTZ045NnBOLzFidW5SWEtKZEhSRWhLUkxReit1?=
 =?utf-8?B?M0FaMU1sYytDK2M4UHYwZGFYM3FqdWZXWHhCbzBhWlVzRzJaM0h4SDRDODlo?=
 =?utf-8?B?bXRmd1NtMGFEcnNzMmxvc2QyYTVNL3ZrSDVNTGRkdm1RNHFYWDBvME5YV1ZJ?=
 =?utf-8?B?UHhETDFOUytmYWgzRDZ6UXArc05vRGlMUE9oVlF1WTZoZlRxaXlJMkxRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0VKbVdUZVNjNmpUZEZmK0NkQ3lJSUNZNk9LbWt3c0FIZ2RPWHc5QWd4RHRM?=
 =?utf-8?B?NkFMQnRmdkN0QU0rV2ZkK3BBMWt6SEovdEdYWFZmMDR2TkhVYmJ6LzRYaFRW?=
 =?utf-8?B?dFJBVHB3cG9IQi85QldOYit1bVU2cWgzTExIVHJIaURIYlArZ0pEcXdjK2NQ?=
 =?utf-8?B?cjFwUlpjdngxcHdpb3NBZkpKMEZzR3RUTDhDVi9wZjlsMVE3ZnRYQzlaaTc0?=
 =?utf-8?B?Z0ZvTGNVUEdxK1I2dm42NVNhMExaQ3IxenQrY000bXpxZmIvaW1BaXNINTVH?=
 =?utf-8?B?dDdPaS9UUld4VVdiVVlHblduYmZLd1liUUxSRUU0enppSGRtNnJBN0Jqb09o?=
 =?utf-8?B?WFdia3ZwWExwVzRlTjNMQ3NEdVZmTzNmR0IxcEROaC9pNzkxc014VzRPeFd1?=
 =?utf-8?B?K21oUVpLT2NvQ1YxcVdoSmF5Nk50K0lLNFhRWDRibUg4YktWd1FRSDFwbjJB?=
 =?utf-8?B?ZHBpM2V2NXE4Wjh4NkkvOWpST1ZTUVJzVWhNTERzcktxdnVpdnhpci9GZ1l6?=
 =?utf-8?B?NHZKSHYwUnNVeW1ITUxyK2d3NDBPNlpQbVVsRGhWbjY2WElkRGV4ejlxZHlh?=
 =?utf-8?B?eE0rVVY1V3FsOW51YVNRcG5hMHlrRUdCNURSVWhmMDM5YjRQL001REZhOW5J?=
 =?utf-8?B?NjVFUUVBa2N5SVNjYmNtdytXWm82UWJiWk5xUWNBNlU3YlVROVhhTTEvSDdY?=
 =?utf-8?B?aWFqNUhhTFNIVmw0UzlTamhZMlcxdHdoTldLWC9JSW1PdmhJQ3NNMVV1QSt4?=
 =?utf-8?B?VEVESDZ6aFhOcE9IQytMWU4zT1I5OHFZaXRkTmUyRlByZnBKWEk5Vnl3QVpD?=
 =?utf-8?B?SUtMRXNxVDBaWEhuQkpTb3prYWl0RUJCaDNTZU1yd1ltQmJOUUxySm50YWRi?=
 =?utf-8?B?d3RZaGZjczRYdlNxWHp6enkyQzU0YmZwK0M0SFRDTExEN3MzdTdKWDE5UDEz?=
 =?utf-8?B?YUZJeEZrUnVLczVpQTdqZVNONGdEKzY2OW1FM1E1cGd2VWE2TVJDTlV5TTFQ?=
 =?utf-8?B?YTVWU0h5RSs3UHVQcXdEZTlES2FFMG5ORXpkZjlVQ3M1TW16YVFwSmVVajBt?=
 =?utf-8?B?VnJrak16RGY4eTVvcmVGakJEODdOQWJkMm10MUJLL2R2TGcwK3AvaEhLM3F4?=
 =?utf-8?B?NzI5V0FYRmhQeHUyMVJaQkZmL2RhTFcrL0FiNk8vNGRFNERXK3JadzliR0hF?=
 =?utf-8?B?eEd3TklhVURoR2RHZG9peDNiMVp6aWMzSHlWc2NVR1RvaE9JdUJQb0dNWXNz?=
 =?utf-8?B?RkJmOUNZb0NlM01yOHFJbi9ZMUdTQXRMWTM2TTdoRjRNZDExOUFTTS82YkdC?=
 =?utf-8?B?ems5d3BTM0RLelVLUlJLaGF2OEJteTFYaTc5RVNtNllaMlpxeDFMdkFuYUNX?=
 =?utf-8?B?Rmc5UmZiWTBQT2wzbDQzVEg2UnNHbUZxN1A5QWtsMU1jT3ZGSStqTkpBSExC?=
 =?utf-8?B?VVo0ZjQ4ZnJ3aHFiNVZNaDZPb3JHSFJXbTdLQ2dIMWhlT2hidFdoRmJYZmlN?=
 =?utf-8?B?cW1mV0JhbERmMUQrRFIrU283NDAzMEJjMWlrbDNxSEZZMGwwZDlmMTczZFBW?=
 =?utf-8?B?TjN2Y3VMVGQwTjkvdzgySG0zZHJIUnF1OGFibHd4NzhaWE9OWnFrdCtieUtS?=
 =?utf-8?B?Mm1UbS9yeTMzbmFTOUpMNmFhVHkyWHFndGQ3OThaTytSL0IvaXVFN0hyMEJw?=
 =?utf-8?B?MkJBQ1dYV05QZUw3d1F0WTludlJpVUlCNENqUFRoN1p4d3ZzT2dEUkx3dksr?=
 =?utf-8?B?Sk5xRWdid1o5S2dobUlUOTVlc0lYc1VCaWppeWdPMWs0TjJEMkEvNitqNTlt?=
 =?utf-8?B?WEpmUDhRaS90dk9IaElaV2lTaW5Pb3JBZFFOUVVFMVRBbHUrbTlPQ0hvQito?=
 =?utf-8?B?QUI3V2hKZlhqd1hIV2JMVVRqV1ZOV1BHSGtXbkJ5WFNSSHpTZTQvdTN5Z2M0?=
 =?utf-8?B?b2hEaVI2Ty9CT1RQa3FDbkd2NnVKWWltTE1vUGFKVTNFZUZyT2FQa2hZRTlQ?=
 =?utf-8?B?SjR6dEd6L0NZZUV5K1IxYnJPaWFjVVo3Z2JpM1NpVm5DV2RQNE5DZ013RUpj?=
 =?utf-8?B?WVA1QTRIanc0RFhsWHFkMlF0VDArUE83TDEwR0ZWcmxjZThKSEdkRWI5ODlh?=
 =?utf-8?Q?hgj71nibCBhEDl0nTb5MBbQlJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41074461-8f7a-4bf9-e130-08dce7e56ce6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:06:14.1883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kW+xkxvG11FPvFjfo+PG5DsuTh8b3tlvLSWa3tcVQpfuimHfiabjY7QHCM3cqxV4dwx6S8kCGjwIB3Et9iNAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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


On 2024-10-04 15:14, Alex Deucher wrote:
> On Fri, Oct 4, 2024 at 2:45 PM <boyuan.zhang@amd.com> wrote:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> Add an instance parameter to set_powergating_by_smu() function, and
>> re-write all amd_pm functions accordingly. Then use the instance to
>> call smu_dpm_set_vcn_enable().
>>
>> v2: remove duplicated functions.
>>
>> remove for-loop in smu_dpm_set_power_gate(), and temporarily move it to
>> to amdgpu_dpm_set_powergating_by_smu(), in order to keep the exact same
>> logic as before, until further separation in next patch.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  4 +++-
>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 10 ++++++++--
>>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c       |  4 +++-
>>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  4 +++-
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 14 ++++++--------
>>   5 files changed, 23 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>> index 2fa71f68205e..f24bc61df9a7 100644
>> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>> @@ -405,7 +405,9 @@ struct amd_pm_funcs {
>>          int (*load_firmware)(void *handle);
>>          int (*wait_for_fw_loading_complete)(void *handle);
>>          int (*set_powergating_by_smu)(void *handle,
>> -                               uint32_t block_type, bool gate);
>> +                               uint32_t block_type,
>> +                               bool gate,
>> +                               int inst);
>>          int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
>>          int (*set_power_limit)(void *handle, uint32_t n);
>>          int (*get_power_limit)(void *handle, uint32_t *limit,
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> index 9dc82f4d7c93..bcedbeec082f 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> @@ -88,7 +88,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>>          case AMD_IP_BLOCK_TYPE_UVD:
>>          case AMD_IP_BLOCK_TYPE_VCE:
>>          case AMD_IP_BLOCK_TYPE_GFX:
>> -       case AMD_IP_BLOCK_TYPE_VCN:
>>          case AMD_IP_BLOCK_TYPE_SDMA:
>>          case AMD_IP_BLOCK_TYPE_JPEG:
>>          case AMD_IP_BLOCK_TYPE_GMC:
>> @@ -96,7 +95,14 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>>          case AMD_IP_BLOCK_TYPE_VPE:
>>                  if (pp_funcs && pp_funcs->set_powergating_by_smu)
>>                          ret = (pp_funcs->set_powergating_by_smu(
>> -                               (adev)->powerplay.pp_handle, block_type, gate));
>> +                               (adev)->powerplay.pp_handle, block_type, gate, 0));
>> +               break;
>> +       case AMD_IP_BLOCK_TYPE_VCN:
>> +               if (pp_funcs && pp_funcs->set_powergating_by_smu) {
>> +                       for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
>> +                               ret = (pp_funcs->set_powergating_by_smu(
>> +                                       (adev)->powerplay.pp_handle, block_type, gate, i));
>> +               }
>>                  break;
>>          default:
>>                  break;
>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> index 2cd6cb991f29..af7da780b58b 100644
>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> @@ -3287,7 +3287,9 @@ static int kv_dpm_read_sensor(void *handle, int idx,
>>   }
>>
>>   static int kv_set_powergating_by_smu(void *handle,
>> -                               uint32_t block_type, bool gate)
>> +                               uint32_t block_type,
>> +                               bool gate,
>> +                               int inst)
>>   {
>>          switch (block_type) {
>>          case AMD_IP_BLOCK_TYPE_UVD:
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> index f193c77cc141..de5ee1c5503f 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> @@ -1241,7 +1241,9 @@ static void pp_dpm_powergate_sdma(void *handle, bool gate)
>>   }
>>
>>   static int pp_set_powergating_by_smu(void *handle,
>> -                               uint32_t block_type, bool gate)
>> +                               uint32_t block_type,
>> +                               bool gate,
>> +                               int inst)
>>   {
>>          int ret = 0;
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 786241fa8d2c..0da84e390d0d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -353,10 +353,10 @@ static int smu_set_mall_enable(struct smu_context *smu)
>>    */
>>   static int smu_dpm_set_power_gate(void *handle,
>>                                    uint32_t block_type,
>> -                                 bool gate)
>> +                                 bool gate,
>> +                                 int inst)
>>   {
>>          struct smu_context *smu = handle;
>> -       struct amdgpu_device *adev = smu->adev;
>>          int ret = 0;
>>
>>          if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
>> @@ -373,12 +373,10 @@ static int smu_dpm_set_power_gate(void *handle,
>>           */
>>          case AMD_IP_BLOCK_TYPE_UVD:
>>          case AMD_IP_BLOCK_TYPE_VCN:
>> -               for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> -                       ret = smu_dpm_set_vcn_enable(smu, !gate, i);
>> -                       if (ret)
>> -                               dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
>> -                                       gate ? "gate" : "ungate");
>> -               }
>> +               ret = smu_dpm_set_vcn_enable(smu, !gate, inst);
>> +               if (ret)
>> +                       dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
>> +                               gate ? "gate" : "ungate");
> Might want to note the instance in the error message.
>
> Alex
Fixed in new patch set just submitted. (patch 04)

Thanks
Boyuan
>
>>                  break;
>>          case AMD_IP_BLOCK_TYPE_GFX:
>>                  ret = smu_gfx_off_control(smu, gate);
>> --
>> 2.34.1
>>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E132EC64EC4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 17:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E66C10E9DF;
	Mon,  6 Feb 2023 17:01:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D17A10E9DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 17:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLYbmIpWz4wOXu1X62G3wvqXLnWlTDc3YQeWpRLejJJ/L3aPBVW0Bk5D/2Bu5gRfs5Wm+OljWJYiWno2xUMUdO9vIEOFZKZeTKVTiobLXEgWuVpVxVy+vOvXBacL18zykxSvUsmm16OBCSYgfo412DtLBYt7HtROEXbv36CeVNFYtdgsi0Wm4LJ2JxWi0QXxw27nyBA+5Cx/VVAZ8ivJ8PC+Y8KIiy21sY30rjQRaaG+gfN/PJdqUd+HlhNeH1eKpiMsJsQM+o98I3JHtfqb2+egdAKTftlJadHHC9/PFc+tN82bazh9nRxoLaGU0PbXffu7yVv1Z3brAaQUwil8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8wGLbMaYHlAkwEGGNFjLx28/HViiX99P9b3niITz6s=;
 b=QKKW8yCS38+i0+o0j/gHmVJ7uB9qedY8yTLaxBPO9IStssiARcm3g4hrd/EeKbZJGAbJC45go7q6McJK/MCTtwAbaMgIaUdt5PDavf+nL2sw9BPjiW2SYNUcqIHOzY6MC1B6+IhCskcs/cYwh1AELqHVJUHZFY1wPbizoBKuIOVmUvUYAN9L+nOwmf6DGaJ3vnStn2hDH6Nue027ORmbpUr+chuvHH/b1oSTk6nuGwqn7ojQ317skepcWdTxzqCAB0urhdWZoGuFQhqxMqcmdB9SyA7NBaqlURgkGaLKbFmCK4ZiV005nd7BwWg8BeiDCGV2W/V6XJ8uKyTFED9uGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8wGLbMaYHlAkwEGGNFjLx28/HViiX99P9b3niITz6s=;
 b=W6ksrerXdB/X7QQoKsAnmEkacfvY4L5sFPH1UudJo7gZx/72vkaiE1FkhSG81aBN8sU3QIH236OynyEYOGaeB+1YIR3vmq7JOopj7Hvl656CtJWGSbsxc2Eu+90FSOk1tzzzIBgE+NQpM1fVsl6HsJpijQMPxadpvjeOP0H9Pyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 17:01:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 17:01:26 +0000
Message-ID: <afce1a57-8007-5d1b-0715-9756d7d07153@amd.com>
Date: Mon, 6 Feb 2023 18:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Shashank Sharma <shashank.sharma@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-2-shashank.sharma@amd.com>
 <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
 <95ac9ea3-47c8-744c-7fd7-ddc54b19926f@amd.com>
 <CADnq5_M9q0R=d=KU8P4oVOCY0Gw97Uhzy6Mrg0GgxeROGn6xrQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_M9q0R=d=KU8P4oVOCY0Gw97Uhzy6Mrg0GgxeROGn6xrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcc2345-a938-46c3-3330-08db0863c860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 501N9khGzTeW68bvmcuK3iF6rfwRCzFzeQYAggkBASjrpp3AQH7sYJ9ih1Iy/ycvHsGdVPY+z5PdtDd2sw/Zya8msCn6LIbV3Lj6ZPC2ZM4iMa5E5QrXnDA499LAk5kSmvow9AVrk6f73nvhIr5SdJV3Cip7Gt8T1AwnwBQXpH/bJwUHugonLqgften1Hv08qw2EHso7hVc0opbSDHjxab8D7vvP0L+wuLk7F8grfH43BjmsPrj8Oq0RJ1VGztNkYC6fP5tUrcZihW+9ezN28bLhatsHlxS7BltBFAuLh8RGt3Wugk8/pRT0cNRZSaN/FfR2LsY6O8fqgbgopkgdGOtYQcXJmJdAwfNKAiRQJijOLwup4dV8bl4b8Fo7tnEkG07Kdxknq0RVNLTJIvoyPS2vfEAjkowAwxh9Jwet4HGttwlVoQIEmnS2qRDvii8thXydFJOiSLalsRE/0NOR8kxzgXsrcjyJzKXZif7/CHIW/Myk4LNAHMaFm5TZy9oDs2sxQeBbWhhqO7VlaAFqza0d2qdbUp9U3s3flzujlX9NtOcWIjjrRqUvxbill7O0cUlLJ7Pkfj6QJZK7jAgX0fZ3SKTH+tQLryCz5UUwVWmsep4W8OV/+bHvzTQU/rBuHyLoKfgn8GgbsvefVDH964mOzYuyfWZQigvPVcemGdHGWarrCwb0REXBUSWmhmvyhvBEpIhoN6zBOk1iEE6X7n0VyOK4Xyd9RwFQHxMAFK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199018)(86362001)(31696002)(36756003)(38100700002)(41300700001)(66556008)(5660300002)(316002)(8936002)(110136005)(4326008)(66946007)(6636002)(8676002)(2906002)(66476007)(83380400001)(2616005)(6486002)(478600001)(6512007)(186003)(6666004)(53546011)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0E5YUlrU21pdHZLQ2l5dWdQK2hEbitPaGlvRXVwMVVKK1duNG9jN2s5TEJW?=
 =?utf-8?B?cDRpaExRc1BaVTBkQWNrWUNzSktrZXdJaEl5QjNqNmR4S0t6bTZ5Z1pWcTMz?=
 =?utf-8?B?dHVrOFpyWWpOWkVRcHpNSmhXRnRFKytqRGFzdUM3QXRhb2ZWRitWcG9TeHNy?=
 =?utf-8?B?NjF2dXo0YUhSenoyc1BFVFc0eXdua3hPYnFnSm9jSTBvM3JHem9zMEZXbjBV?=
 =?utf-8?B?TDF0WFVRaEhzSWlVa2FLN3NCcnNSUmRIRTdVb0hNZ2ZUWTEydm8wK2dwL1Uz?=
 =?utf-8?B?SHNISDhUMko2d1ZUdFlDSEE5TDQ5Uis0QXE4MTZwL0xkSnNVWjRZNEhnaUJT?=
 =?utf-8?B?OGFlU0h5UDNmRkpCYXFBUXRJSHhnaXJNSzRIRVpPZ3Y1a2JWbHdSY0QvKy9T?=
 =?utf-8?B?c0N6TUR0M21lZkoyZDdkYmZJbndYeHNMYW9CZ3RXSzBuc3JGY1FVZnREeml2?=
 =?utf-8?B?cWZmT1FwbW9CaGEzbS9pamoxU0RlZHpWWklaN016bitCT0NjU2pWZ0NmRjJ5?=
 =?utf-8?B?MGtnQUwwUytwdzhmUzY2OW4wdzg5VFdHY25YdDZMaFJzTzdNMklKaWl2dlFs?=
 =?utf-8?B?UDl6U1V4UnRPTDlVK3d3ZUduNk55Nkd5WFpLUEdKNktyZkpQYmgrNm5BT29E?=
 =?utf-8?B?MXAvd3VjYTVOdFVrVmRLMXRsV1hTdXIyeG15Sy9UM1FWMzZ3c1d3eFBXWHVG?=
 =?utf-8?B?SHRnOUFwSUpabDJvSDVuQnk0aUN6bWJlcTU1Q0pFS3ZIZkUvYkE3WHdIUnpO?=
 =?utf-8?B?Q1duaTkyUFZxemFZYXRWU3htMkhpRVpXRFcyUFNJMFYxWkxPOHk1VGplaWVy?=
 =?utf-8?B?Y1RyY2hXUWcwN0hNZEdsQnBqR3o4QTB3ZTBoSm9kd3luQTQybmNhUGFhNnpu?=
 =?utf-8?B?K0dhOVZCSmpGbjEwb0s3UHViTTRvNG05UXEwUmYvOU1QQmVZTm02SWFpcm5U?=
 =?utf-8?B?TlFiNVpsRG55SjQ0Q1dNMjNDNTJ0dWlHWFhLUkZhWVduNHdRYVpubC9XYnlR?=
 =?utf-8?B?alhWdWdqbko5eUNXWS9oTWxhejhzNjQ5enBnSVZMNXZhUDZIRkhDNkE5d25E?=
 =?utf-8?B?aFBmQy9FdGJUMlpjOTNQTGJkQ0g5YTkrUG5KQnVkZzgwNkV1YWpsL1NhQldt?=
 =?utf-8?B?ZmJWYytQbTAySlpoL21ZUkUrZ1RQWXA1WXI0bHpDTHNadVBvQWRHTUJzTTlG?=
 =?utf-8?B?SmMvVXVoQmwxakV3dEdFY0tjUlpaMEZtM2xVMTFiNkk0RmNGSDd2b2prbjVY?=
 =?utf-8?B?Z3FoMmlzNGdxYk15L3RhR3dIRjFtQndOdENIUllIQktDR2tjSExFOVZ3NDd3?=
 =?utf-8?B?M2xSaTl6YXZaaWZHamo4YnZzQnBaWUlsa09lNU84VTNUZHZNYUdJc3dJTldH?=
 =?utf-8?B?MEZXS0JEUE05elNEZklnUjlqZ3c2ejFOOUtrYlFGRDBWY2JtalRCQUNnV2hB?=
 =?utf-8?B?NEZLSWIrcXN5SkFzdGg0M2N1ZVJCcGFxTmlhOFBuUUxRVSs3VTF5bVF3M2cz?=
 =?utf-8?B?N3F6Tm9EaEdFMWFUUnp1NmozbjJaUUZDeXdVVU5hUGVlVW5ieVo4N1NyN1Yr?=
 =?utf-8?B?Z1VvSmVueXV4dVVoUUxWcVZuK01kbVdFZy82eWlzbk1ZaDRCeFVZdkJGUmRF?=
 =?utf-8?B?VjI3ajI5VW1RYVE2YVRYdGxQc2YyT1doNlZKV0gxWGo1OXVRamlkbEpyM3BE?=
 =?utf-8?B?ZVQvdWNqM2hsbU9jQjZvaWRTT283M3ZNMjV1NEpsdnJIOFVLRnhsOXpxcHY2?=
 =?utf-8?B?bHVOMlUxTWdTVytGYVRVR2dJYm14RDNsQlE3emxGNml1c1ZqMWxIMjY2S2pt?=
 =?utf-8?B?NUxpM0dqYmRnOW1OK1FtMHJpQ1VwOFh2ZnUyZlVJQkpqVUxHY3N5cGM2Vmpz?=
 =?utf-8?B?aVo2emFVdit2L2dNaWMxTGJwdGV5eUlWR3lwZ09RVnM3bU1aVUI1NzZKSm9a?=
 =?utf-8?B?RG1uM2IzYVE1QXZWUlBmUnhKVUhGbkFJQkJ2R3IvbjhweW1oV1NIaUN4SFNz?=
 =?utf-8?B?S0hqMmtuSmltKzBna1VUWWpnaHkvODlaSTY0elJsTUFuWHMrbHFCb0xMM0dI?=
 =?utf-8?B?OGQzcEJtWER2eHJrSmdka1BXMFljRmxvZ04zakRwVFpkNG1aN1RjMUtBVlJp?=
 =?utf-8?B?cTlNcUhyRTlWSXpmRkdlb2x1bUd3aWRrK2JQbVdWRnNzbUdFdEpVOW55RW5Q?=
 =?utf-8?Q?Qk+UJRfE+Jo0WtMERVkgL5Nno0oAHxN9TgKymGbk4VDC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcc2345-a938-46c3-3330-08db0863c860
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:01:26.0995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eH9yDof1H7/QZ2Tm0LMMkThRmIftVZpMdYKY4BBwMnbYpej8IWO17cDYPB4Gj8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
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

Am 06.02.23 um 17:56 schrieb Alex Deucher:
> On Fri, Feb 3, 2023 at 5:26 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> Hey Alex,
>>
>> On 03/02/2023 23:07, Alex Deucher wrote:
>>> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> This patch intorduces new UAPI/IOCTL for usermode graphics
>>>> queue. The userspace app will fill this structure and request
>>>> the graphics driver to add a graphics work queue for it. The
>>>> output of this UAPI is a queue id.
>>>>
>>>> This UAPI maps the queue into GPU, so the graphics app can start
>>>> submitting work to the queue as soon as the call returns.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>    include/uapi/drm/amdgpu_drm.h | 53 +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 53 insertions(+)
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>> index 4038abe8505a..6c5235d107b3 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>    #define DRM_AMDGPU_VM                  0x13
>>>>    #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>>>    #define DRM_AMDGPU_SCHED               0x15
>>>> +#define DRM_AMDGPU_USERQ               0x16
>>>>
>>>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>    #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>    #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>>>    #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>>
>>>>    /**
>>>>     * DOC: memory domains
>>>> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
>>>>           union drm_amdgpu_ctx_out out;
>>>>    };
>>>>
>>>> +/* user queue IOCTL */
>>>> +#define AMDGPU_USERQ_OP_CREATE 1
>>>> +#define AMDGPU_USERQ_OP_FREE   2
>>>> +
>>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>>>> +
>>>> +struct drm_amdgpu_userq_mqd {
>>>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
>>>> +       __u32   flags;
>>>> +       /** IP type: AMDGPU_HW_IP_* */
>>>> +       __u32   ip_type;
>>>> +       /** GEM object handle */
>>>> +       __u32   doorbell_handle;
>>>> +       /** Doorbell offset in dwords */
>>>> +       __u32   doorbell_offset;
>>> Since doorbells are 64 bit, maybe this offset should be in qwords.
>> Can you please help to cross check this information ? All the existing
>> kernel doorbell calculations are keeping doorbells size as sizeof(u32)
> Doorbells on pre-vega hardware are 32 bits so that is where that comes
> from, but from vega onward most doorbells are 64 bit.  I think some
> versions of VCN may still use 32 bit doorbells.  Internally in the
> kernel driver we just use two slots for newer hardware, but for the
> UAPI, I think we can just stick with 64 bit slots to avoid confusion.
> Even if an engine only uses a 32 bit one, I don't know that there is
> much value to trying to support variable doorbell sizes.

I think we can stick with using __u32 because this is *not* the size of 
the doorbell entries.

Instead this is the offset into the BO where to find the doorbell for 
this queue (which then in turn is 64bits wide).

Since we will probably never have more than 4GiB doorbells we should be 
pretty save to use 32bits here.

Christian.

>
> Alex
>
>>>> +       /** GPU virtual address of the queue */
>>>> +       __u64   queue_va;
>>>> +       /** Size of the queue in bytes */
>>>> +       __u64   queue_size;
>>>> +       /** GPU virtual address of the rptr */
>>>> +       __u64   rptr_va;
>>>> +       /** GPU virtual address of the wptr */
>>>> +       __u64   wptr_va;
>>>> +};
>>>> +
>>>> +struct drm_amdgpu_userq_in {
>>>> +       /** AMDGPU_USERQ_OP_* */
>>>> +       __u32   op;
>>>> +       /** Flags */
>>>> +       __u32   flags;
>>>> +       /** Queue handle to associate the queue free call with,
>>>> +        * unused for queue create calls */
>>>> +       __u32   queue_id;
>>>> +       __u32   pad;
>>>> +       /** Queue descriptor */
>>>> +       struct drm_amdgpu_userq_mqd mqd;
>>>> +};
>>>> +
>>>> +struct drm_amdgpu_userq_out {
>>>> +       /** Queue handle */
>>>> +       __u32   q_id;
>>> Maybe this should be queue_id to match the input.
>> Agree.
>>
>> - Shashank
>>
>>> Alex
>>>
>>>> +       /** Flags */
>>>> +       __u32   flags;
>>>> +};
>>>> +
>>>> +union drm_amdgpu_userq {
>>>> +       struct drm_amdgpu_userq_in in;
>>>> +       struct drm_amdgpu_userq_out out;
>>>> +};
>>>> +
>>>>    /* vm ioctl */
>>>>    #define AMDGPU_VM_OP_RESERVE_VMID      1
>>>>    #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>>>> --
>>>> 2.34.1
>>>>


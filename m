Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67986C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 23:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A441F10EA59;
	Thu, 15 Feb 2024 23:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xk8l2Hw8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362D110EA5A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 23:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaN/z5cREBKa3KlPNm28zhA6KEDW3Bc4m3BMACymjqm6tOiAHKcq6yezU3NGun8/m0SfS7W8zV6G9zpDA1Ky1qR8vHmWbgd4dffGRKVxXAEUDw+QWIE3gwcM+PzMh1tigrsK00FMNwCGnY2sxqYXYhORGG+U9rAl5T8eTMfPbKLxFR2EiXxYUTBH4MXBLmD47CF3GDXZbDRgb2hCyVB+Qws6VIXivr6TB4rKJreqDtxlL4ixsbmjt48DxHcAkS+QA43B5XrQ1sfcNpYeQa3gA4jYQAvT28DQUnk3cE4kQXj+1JW3VGvFpUprF1Cf9GGzYQ8kvhzi4zb6FbTQWN1VaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDUqoCpTBO3y89WFz4NbpxG7y1Uv+TbXchjt8jDqzmI=;
 b=MdUrymIMxViWCF47OKsgkxTev7t6KWtzOfUuTBD8+4wKkw6sPA9QD+qK10bkL/7NOGRvUa79RAVfnIGOiZhmO8aDnnVenKsA+yLee09f0uCcL7KGm++DuXQaDtr652XBkorMdDJx320G6o8dztBXP98j+LphrMo3kMObLno5TVZJj0EwIJq5O0QhKMOf7ljWS8dU58Km1MF2GcvjBY/E86UaCF7NhXC3XGITdY1AD5kqRqci3vwhsXrgGs109BoTLxGZYE+omH3AAWLGMZWUkguujuKCq9Tr8fhMKz6xJLJFEdyF7MKNY+/5mRvxQ6iPC6ODnVKWhjGijtEwi4YLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDUqoCpTBO3y89WFz4NbpxG7y1Uv+TbXchjt8jDqzmI=;
 b=xk8l2Hw8tlPFv3cIkXTAJCvGAW1NpTy8cUmNaQNbCCtjMEZ1WgziRHWgHuCOF7uKekYWBuWKHXLG/Q1qh0KOYLd4uMpH+ZhyM9kj5HsfJ8c38Y5C9RY3+oLAywa9WwktOUVhNRFCtPK2Ksg7eOqeJLS7nRnRzspS2fSbpY6LrYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Thu, 15 Feb
 2024 23:04:53 +0000
Received: from CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::3e7c:a57f:1919:3ed3]) by CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::3e7c:a57f:1919:3ed3%4]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 23:04:53 +0000
Message-ID: <1fea1273-f5ba-52a6-85db-2b828982f8b7@amd.com>
Date: Thu, 15 Feb 2024 18:04:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/amdkfd: Document and define SVM event tracing
 macro
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240215151830.22416-1-Philip.Yang@amd.com>
 <22db7ab1-c48c-c982-8c67-f2418becdda9@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <22db7ab1-c48c-c982-8c67-f2418becdda9@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0190.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::17) To CH0PR12MB5138.namprd12.prod.outlook.com
 (2603:10b6:610:bd::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5138:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5af5e1-4cde-45b3-7852-08dc2e7a8525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHhgB1of9w6APy03JuHxWGSUZJ2R8OaDOL23nTRQs6gbX1sIZTL4SqRkTiPncCvrFeqGxXX8/i68rSrTnB2u6t5sEgeeG/34teHy9JoIN2tZs9umrB2vpPxdfNalf9O0AWI2RR2u6TNeJApwlax39Clp6DTmqwcr+NCU8RzE8xlsDXHAMhbkstULHVzbkLoWJ+IHfQDZHd+9u432PzYGtmQ+tfCzDJ8d9pV34Wxi29Wr2Djq7bgH0awslVXbUeFLL0/s1/IVxcBA5290ov6dvaLjMBoMYOs79rkA0I35kQqHdE4Tfco2uMSAizf5KRHoFexDCAQEHFHWXRaTrkKZglTi/qOzxWN73mE6CQM6DLgc0VDGkRJuMDTAIh1KZ+CbdK5NLAS7LrkYf7s5Vh3cf5qGXPeTMYJnGwJ9BIJiIAWOm/KMPkf5LwvqIYUJx2z45sMBBDr+/tmpDWu0DSuDweN5UMi1c0xq3FmEqNe/gO8W8Fs3o3hzF7R9vXOiciY68j4kmAJ2H6mj4rVpLBAbIq9NadYF6k/8KMmzWDCN0YyRVqxxSVTwj7abHWMTyq17
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(30864003)(26005)(6506007)(6512007)(53546011)(36756003)(478600001)(2616005)(38100700002)(6486002)(31696002)(83380400001)(4326008)(66476007)(8936002)(66556008)(66946007)(8676002)(5660300002)(110136005)(316002)(31686004)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkpmdFFSWERzVTZUcU5SMHp2RTFadUg1Z2trNmdsVkE0UmhkZ2hBRFJKR2dx?=
 =?utf-8?B?cXFpQVZ1UTN1R1V1UTNqc3dKY1RyMzczNE5vOW1aY2xhbXIrcEZJYXJXZ2dE?=
 =?utf-8?B?ZmVIa3NMcTZCcWMzL25heGphbWRQcThIQ0ZuN1YyeUxQRlpJMG1zWnh2c1V0?=
 =?utf-8?B?Und2dmovdXh6N2s1MFl2TUlCbTR6Rk1WOGdzVVg4YWVhcWhMeVBVNTVXRGxQ?=
 =?utf-8?B?bUs4VE91c1VzcVBBLzJKSmlzc01WdElONWlkTTQrR1Q5TmlTTmRZZW1pMHlY?=
 =?utf-8?B?ZHg2SVQxUmpqaThReTNnT2k2VjZxdU92blpmZVlMcUJEbVBkQ1FRU1BZc2RG?=
 =?utf-8?B?YmdzS09WS1hNeHJFeVRrNFkyazUzODhCU1RiL1d6U2tneFlYR1dGT0gyUXN5?=
 =?utf-8?B?WDRFOGtCN1ZLdUsxUm81dEh5YXlKdmVWZHAwQnZ4bzJDZ1NESHhTUnFPS0k4?=
 =?utf-8?B?MjR1MGtBeWJmQ3BDelVYWDR1RUdpNFNwNWU1WE5CK3BvRHo1Y01zVUlDWHAz?=
 =?utf-8?B?RjhCZ0Zybmd1b2VmaWU0N2xzeGUvZms1bXRLM3VqY0EwcmRUQ0JaMm1pTzNT?=
 =?utf-8?B?S1lYTm9DMFJSRXF2aGtxejA4ZWREUjFFK0drQXdUZWl6REk5REczMGVSUWhK?=
 =?utf-8?B?ZUVOVk44eGZSQkN0S0I3L1ZDK2xwRGJzRC9ySFVuWU5Mbm9HWnBIaXJNaVB1?=
 =?utf-8?B?Y2liMzArRHB0WHBpUUg2aHM1enFMRXRnaGxKRkU0eUtyOE1FelNoU3UrWEw4?=
 =?utf-8?B?dlhCcm9ES3FTVkFEa3ljNXJsZkdEWXBCTkgrMk1oZll2T3NUQ1lIVGdRcjls?=
 =?utf-8?B?bGV6ZGNtZ0lLNm9zd1pVeWJ2Rzd1UndqT2s4dnd6amNleENEdVpVdzh6b1pU?=
 =?utf-8?B?ZzFEY0NXdldCY1R5c2JSMmVpYWlXQ3BQMWZhME1uTUIxS3FuMU5WMGlzbjFq?=
 =?utf-8?B?SGUzYW5KTXNWWTdYY0VMVnF1ZmQ1SUYwNzRMTmVETlVxMm0rWDV0QTIwQnJi?=
 =?utf-8?B?VDZnTHV6YkxSWDk3b0Q1UXpsYmF0R2kyQ0hUSS9NWnhoY0pmM3NnRWE1ZkJV?=
 =?utf-8?B?N05RdjRyTmlNVGtLMCtZUzVnZFZOaEVjeVoxZWJvTXR3VTBjSVdrckhpQ0Jx?=
 =?utf-8?B?WGZHM2J5dmcxdnFYWFQ3UnNUSDliNzZCekQ2QkltWUQ0OHJGdlBnTjRrRWUy?=
 =?utf-8?B?REtZSjlJQ2c3MkprcWpudG9GN1hUdVNsMk9ENGV4Mk5IaXl0OU9sekV4L3ND?=
 =?utf-8?B?R3JQNG1wQ0NuaHhQKzgrd012UUNObVo4QWxkSXo2ejM1a3pDNFI4VVRXUkpk?=
 =?utf-8?B?bzVqcTNuRWlxdjUwMm9KNXo5MTJ5MWM4bXJNTG15WC8waDNxQWE4MnN3SUto?=
 =?utf-8?B?ZEtyUzU0cTVOSXN4N2U1VEdhb1ZBT0ZoYWU0d0gxcXdxYUNZZk1WY2hDS1Zv?=
 =?utf-8?B?R0oyL0Mya1N4cXdzb0tIbmhQcEdybEc5OXhyNmx4OXhvMzFBaGExMjNSRUVF?=
 =?utf-8?B?MHFrQkhFSzUzOTgwOTFVMFZTMVV4NVFSZDFhYk5rSUZ0T3E3VWZsYlBIT1R6?=
 =?utf-8?B?cEM2U1Yydk9LOFNQclZQVnd1UmIwQTdIelBIeVRxK2dOWmN2ajdCYXFnS2Qx?=
 =?utf-8?B?UFRTcUo0RjFRQytTelcxVVIyVm1DdHd3dVJGNmtYaCtMamxuNUk2TG9TaFZX?=
 =?utf-8?B?OC9MelFWNGdueWVlcVFjNUVWckx6RlJ5dy9BeVZ5NENtSlpTalV3WXNscUtH?=
 =?utf-8?B?YnZ3SWFFMnViVEtpY2Y4R1FRbGJCQWZmVWNkRWJKSEJVYmhNRk5jUVl3YUdP?=
 =?utf-8?B?aHBESWtlWUZya04wdFpJMy9RaWpHYXFiTm9PbHpIQUZyNWJmYkY5cnJxcDk1?=
 =?utf-8?B?Qzh4SnNXNkhEdEVNSDljbnA2Yk9Ea21oSk8wNzVlQ21iQkZYd2g2Q3BDNEhx?=
 =?utf-8?B?WW8xWUVYNG5lWW1rYW84ajZUWWo4THlDZ1NoclgxY2ZjVEE2dWlmZXhIWUtq?=
 =?utf-8?B?MXBsc0ZvUDNvYWNhcEhaN3JhZ3NwK3pLdFJrV0EvaTFZQ0U1L1F2OVliN1g3?=
 =?utf-8?B?dkZGUHVNRXNXODdNaXgxMDBHRW43RSszNUwwSW1IWDFDcVQ0bCs5OFVJTm4y?=
 =?utf-8?Q?57Es=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5af5e1-4cde-45b3-7852-08dc2e7a8525
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 23:04:53.6553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydbw/ibjOr+ikqOusKyB6Ye5ldYMR/V4OBQc/ab822n+Y0Y1uh5Iqdv3cVOKCNMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-02-15 12:54, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:22db7ab1-c48c-c982-8c67-f2418becdda9@amd.com">
      <br>
      On 2/15/2024 9:18 AM, Philip Yang wrote:
      <br>
      <blockquote type="cite">Caution: This message originated from an
        External Source. Use proper caution when opening attachments,
        clicking links, or responding.
        <br>
        <br>
        <br>
        Document how to use SMI system management interface to receive
        SVM
        <br>
        events.
        <br>
        <br>
        Define SVM events message string format macro that could use by
        user
        <br>
        mode for sscanf to parse the event. Add it to uAPI header file
        to make
        <br>
        it obvious that is changing uAPI in future.
        <br>
        <br>
        No functional changes.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 51
        +++++++-------
        <br>
        &nbsp; include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 77
        ++++++++++++++++++++-
        <br>
        &nbsp; 2 files changed, 102 insertions(+), 26 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        index d9953c2b2661..85465eb303a9 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        @@ -225,15 +225,16 @@ void kfd_smi_event_update_gpu_reset(struct
        kfd_node *dev, bool post_reset)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event = KFD_SMI_EVENT_GPU_PRE_RESET;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++(dev-&gt;reset_seq_num);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, event, &quot;%x\n&quot;,
        dev-&gt;reset_seq_num);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, event,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_UPDATE_GPU_RESET(dev-&gt;reset_seq_num));
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; void kfd_smi_event_update_thermal_throttling(struct kfd_node
        *dev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t
        throttle_bitmask)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev,
        KFD_SMI_EVENT_THERMAL_THROTTLE, &quot;%llx:%llx\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttle_bitmask,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_dpm_get_thermal_throttling_counter(dev-&gt;adev));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev,
        KFD_SMI_EVENT_THERMAL_THROTTLE,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_UPDATE_THERMAL_THROTTLING(throttle_bitmask,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_dpm_get_thermal_throttling_counter(dev-&gt;adev)));
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; void kfd_smi_event_update_vmfault(struct kfd_node *dev,
        uint16_t pasid)
        <br>
        @@ -246,8 +247,8 @@ void kfd_smi_event_update_vmfault(struct
        kfd_node *dev, uint16_t pasid)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!task_info.pid)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT,
        &quot;%x:%s\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info.pid, task_info.task_name);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_EVENT_FMT_VMFAULT(task_info.pid,
        task_info.task_name));
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; void kfd_smi_event_page_fault_start(struct kfd_node *node,
        pid_t pid,
        <br>
        @@ -255,16 +256,16 @@ void kfd_smi_event_page_fault_start(struct
        kfd_node *node, pid_t pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t ts)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node,
        KFD_SMI_EVENT_PAGE_FAULT_START,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%x) %c\n&quot;,
        ktime_to_ns(ts), pid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address, node-&gt;id, write_fault ?
        'W' : 'R');
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts), pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address, node-&gt;id, write_fault ?
        'W' : 'R'));
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t
        pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long address, bool
        migration)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node,
        KFD_SMI_EVENT_PAGE_FAULT_END,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%x) %c\n&quot;,
        ktime_get_boottime_ns(),
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, address, node-&gt;id, migration ?
        'M' : 'U');
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, address, node-&gt;id, migration ?
        'M' : 'U'));
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; void kfd_smi_event_migration_start(struct kfd_node *node,
        pid_t pid,
        <br>
        @@ -274,9 +275,9 @@ void kfd_smi_event_migration_start(struct
        kfd_node *node, pid_t pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node,
        KFD_SMI_EVENT_MIGRATE_START,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x-&gt;%x %x:%x
        %d\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_get_boottime_ns(), pid, start,
        end - start,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from, to, prefetch_loc, preferred_loc,
        trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, start, end - start, from, to,
        prefetch_loc,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preferred_loc, trigger));
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; void kfd_smi_event_migration_end(struct kfd_node *node, pid_t
        pid,
        <br>
        @@ -284,24 +285,23 @@ void kfd_smi_event_migration_end(struct
        kfd_node *node, pid_t pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t from, uint32_t to,
        uint32_t trigger)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x-&gt;%x %d\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_get_boottime_ns(), pid, start,
        end - start,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from, to, trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(), pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, end - start, from, to,
        trigger));
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t
        pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node,
        KFD_SMI_EVENT_QUEUE_EVICTION,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x %d\n&quot;,
        ktime_get_boottime_ns(), pid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node-&gt;id, trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, node-&gt;id, trigger));
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t
        pid)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node,
        KFD_SMI_EVENT_QUEUE_RESTORE,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x\n&quot;,
        ktime_get_boottime_ns(), pid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node-&gt;id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, node-&gt;id));
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; void kfd_smi_event_queue_restore_rescheduled(struct mm_struct
        *mm)
        <br>
        @@ -317,9 +317,10 @@ void
        kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = p-&gt;pdds[i];
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(p-&gt;lead_thread-&gt;pid,
        pdd-&gt;dev,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_QUEUE_RESTORE,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x %c\n&quot;,
        ktime_get_boottime_ns(),
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;lead_thread-&gt;pid,
        pdd-&gt;dev-&gt;id, 'R');
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_QUEUE_RESTORE_RESCHEDULED(
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_get_boottime_ns(),
        p-&gt;lead_thread-&gt;pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id, 'R'));
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(p);
        <br>
        &nbsp; }
        <br>
        @@ -329,8 +330,8 @@ void kfd_smi_event_unmap_from_gpu(struct
        kfd_node *node, pid_t pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node,
        KFD_SMI_EVENT_UNMAP_FROM_GPU,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x %d\n&quot;,
        ktime_get_boottime_ns(),
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, address, last - address + 1,
        node-&gt;id, trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, address, last - address + 1,
        node-&gt;id, trigger));
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
        <br>
        diff --git a/include/uapi/linux/kfd_ioctl.h
        b/include/uapi/linux/kfd_ioctl.h
        <br>
        index 9ce46edc62a5..430c01f4148b 100644
        <br>
        --- a/include/uapi/linux/kfd_ioctl.h
        <br>
        +++ b/include/uapi/linux/kfd_ioctl.h
        <br>
        @@ -523,7 +523,8 @@ enum kfd_smi_event {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_PAGE_FAULT_END = 8,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_QUEUE_EVICTION = 9,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_QUEUE_RESTORE = 10,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED = 11,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_UNMAP_FROM_GPU = 12,
        <br>
      </blockquote>
      <br>
      Why change KFD_SMI_EVENT_UNMAP_FROM_GPU from 11 to 12? That breaks
      existing api with user space, ex, thunk use
      HSA_SMI_EVENT_UNMAP_FROM_GPU = 11,
      <br>
    </blockquote>
    <p>yes, this does break the existing ID API, patch 2/2 change the
      migrate end message format, also breaks the existing API, will
      send v2 patch to add new event ID for both restore rescheduled
      event and migrate failure end event.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:22db7ab1-c48c-c982-8c67-f2418becdda9@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * max event number, as a flag bit to get events from
        all processes,
        <br>
        @@ -564,6 +565,80 @@ struct kfd_ioctl_smi_events_args {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 anon_fd;&nbsp; /* from KFD */
        <br>
        &nbsp; };
        <br>
        <br>
        +/*
        <br>
        + * SVM event tracing via SMI system management interface
        <br>
        + *
        <br>
        + * Open event file descriptor
        <br>
        + *&nbsp;&nbsp;&nbsp; use ioctl AMDKFD_IOC_SMI_EVENTS, pass in gpuid and return
        a anonymous file
        <br>
        + *&nbsp;&nbsp;&nbsp; descriptor to receive SMI events.
        <br>
        + *&nbsp;&nbsp;&nbsp; If calling with sudo permission, then file descriptor can
        be used to receive
        <br>
        + *&nbsp;&nbsp;&nbsp; SVM events from all processes, otherwise, to only receive
        SVM events of same
        <br>
        + *&nbsp;&nbsp;&nbsp; process.
        <br>
        + *
        <br>
        + * To enable the SVM event
        <br>
        + *&nbsp;&nbsp;&nbsp; Write event file descriptor with
        KFD_SMI_EVENT_MASK_FROM_INDEX(event) bitmap
        <br>
        + *&nbsp;&nbsp;&nbsp; mask to start record the event to the kfifo, use bitmap
        mask combination
        <br>
        + *&nbsp;&nbsp;&nbsp; for multiple events. New event mask will overwrite the
        previous event mask.
        <br>
        + *&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS)
        bit requires sudo
        <br>
        + *&nbsp;&nbsp;&nbsp; permisson to receive SVM events from all process.
        <br>
        + *
        <br>
        + * To receive the event
        <br>
        + *&nbsp;&nbsp;&nbsp; Application can poll file descriptor to wait for the
        events, then read event
        <br>
        + *&nbsp;&nbsp;&nbsp; from the file into a buffer. Each event is one line
        string message, starting
        <br>
        + *&nbsp;&nbsp;&nbsp; with the event id, then the event specific information.
        <br>
        + *
        <br>
        + * To decode event information
        <br>
        + *&nbsp;&nbsp;&nbsp; The following event format string macro can be used with
        sscanf to decode
        <br>
        + *&nbsp;&nbsp;&nbsp; the specific event information.
        <br>
        + *&nbsp;&nbsp;&nbsp; event triggers: the reason to generate the event, defined
        as enum for unmap,
        <br>
        + *&nbsp;&nbsp;&nbsp; eviction and migrate events.
        <br>
        + *&nbsp;&nbsp;&nbsp; node, from, to, prefetch_loc, preferred_loc: GPU ID, or 0
        for system memory.
        <br>
        + *&nbsp;&nbsp;&nbsp; addr: user mode address, in pages
        <br>
        + *&nbsp;&nbsp;&nbsp; size: in pages
        <br>
        + *&nbsp;&nbsp;&nbsp; pid: the process ID to generate the event
        <br>
        + *&nbsp;&nbsp;&nbsp; ns: timestamp in nanosecond-resolution, starts at system
        boot time but
        <br>
        + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stops during suspend
        <br>
        + *&nbsp;&nbsp;&nbsp; migrate_update: the GPU page is recovered by 'M' for
        migrate, 'U' for update
        <br>
        + *&nbsp;&nbsp;&nbsp; rescheduled: 'R' if the queue restore failed and
        rescheduled to try again
        <br>
        + *&nbsp;&nbsp;&nbsp; rw: 'W' for write page fault, 'R' for read page fault
        <br>
        + */
        <br>
        +#define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%x\n&quot;, (reset_seq_num)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_UPDATE_THERMAL_THROTTLING(bitmask,
        counter)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%llx:%llx\n&quot;, (bitmask), (counter)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_VMFAULT(pid, task_name)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%x:%s\n&quot;, (pid), (task_name)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_PAGEFAULT_START(ns, pid, addr, node, rw)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%x) %c\n&quot;, (ns), (pid), (addr),
        (node), (rw)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_PAGEFAULT_END(ns, pid, addr, node,
        migrate_update)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%x) %c\n&quot;, (ns), (pid), (addr),
        (node), (migrate_update)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_MIGRATE_START(ns, pid, start, size, from,
        to, prefetch_loc,\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preferred_loc, migrate_trigger)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x-&gt;%x %x:%x %d\n&quot;, (ns),
        (pid), (start), (size),\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (from), (to), (prefetch_loc), (preferred_loc),
        (migrate_trigger)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from,
        to, migrate_trigger)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x-&gt;%x %d\n&quot;, (ns),
        (pid), (start), (size),\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (from), (to), (migrate_trigger)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node,
        evict_trigger)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x %d\n&quot;, (ns), (pid), (node),
        (evict_trigger)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x\n&quot;, (ns), (pid), (node)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_QUEUE_RESTORE_RESCHEDULED(ns, pid, node,
        rescheduled)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x %c\n&quot;, (ns), (pid), (node),
        (rescheduled)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_UNMAP_FROM_GPU(ns, pid, addr, size, node,
        unmap_trigger)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x %d\n&quot;, (ns), (pid),
        (addr), (size),\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (node), (unmap_trigger)
        <br>
        +
        <br>
        &nbsp;
/**************************************************************************************************<br>
        &nbsp;&nbsp; * CRIU IOCTLs (Checkpoint Restore In Userspace)
        <br>
        &nbsp;&nbsp; *
        <br>
        --
        <br>
        2.35.1
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

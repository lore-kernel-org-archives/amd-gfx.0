Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECED6C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 18:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B20B61357
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 18:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B20B61357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397EB89E2B;
	Mon, 12 Apr 2021 18:01:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7308389E36
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 18:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjU16LvknR7SqtnfPm69eYUatv5rb6toHO0o9RG1aQpIBqpZWEmNlfSh93MWOkEHVCVGOzXjvljp2rnX62PwbjcC6m4xIFqHoy5dbZL0GIywm55Y97zZXZleL8HxleW5Z03/avlWazg+PNxg//ln17gVzyDobH5P2o2HlVmh/NtdZ8WKuFjYDusCDlvlm8+SURZs9SEyz6S7vw+wzxLAPJrZZJIynPEIaxLQlI7M2bDLDSRLDRuPqsYyUPpX2ynSfLJ7bPDowag2vd0CjfWhZbTUyE/PoORuQU5IWhHwszkMEsknX5pdTs9tb6D+jWkB7DgMzhFj0T/RtFz1Xu+1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BWXuCa9902hzG3c780U+8eWgdxuxsN811Mizx2SaS8=;
 b=i1/VSqkas5WpZ97kvgUXj8mN4AmnRJFdl348WTf83RKSbzou5LoZStn4tmwk1eMFsaJUTbo8IHEo5KDm0Gtmp9uuEfdkVLExsMSsPV+8vnlJ4CeOJm6Wi2UNbIg0piII8V9iQ+4YLWd5auF6aHxS38STPvbYFnfxWQ9MoHdmTyMAnMeLnM/crmU4Tg0cQJ+ybVL4pAGq3H3QeM7MJlsutg6G5Afg6+MrBm5HSPsI+px0uWbty6nzfDfXmwrgx/lGecuqe8chiVXnLlV4oDdUv3r7q81sNEiEtVtxw0fLy0Mj6Om1ACU8kDrwS/YXfDSBUNowdHKRD/eXCNeSvxlF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BWXuCa9902hzG3c780U+8eWgdxuxsN811Mizx2SaS8=;
 b=ouBSDpXkUk6VjBu3RLIqIWCoEHxLPYy5qWxLLRlsjf+9ywlVfB+zUE+2mOjyqlmPQAVzw+aag1hLKpPmSy9b/37h/ZhuYre0HeHhdL3KS4+1erSKjpqbtGK3304ydg8+9vXKb84DWsG/vOCCPMtBPfw9U7ZTEDpClFk1mlZ1pyQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2749.namprd12.prod.outlook.com (2603:10b6:805:6d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 18:01:26 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:01:25 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
Date: Mon, 12 Apr 2021 14:01:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
X-ClientProxiedBy: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
 (2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5) by
 YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22 via Frontend
 Transport; Mon, 12 Apr 2021 18:01:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a4a65ec-5c60-4f82-1c4f-08d8fddcfd41
X-MS-TrafficTypeDiagnostic: SN6PR12MB2749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27496004320F21AB771CF0A2EA709@SN6PR12MB2749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGupwn0+M2UpmPv7KRGtfQ4WjWGFAGEWORRoM7HhiDIBXeFKhYL7/66Rw34rrbubPk1BBMaIOfQSjFzZrZ8+MmbQG80Dxc4GKrok2ZMY01gUHrExDlZF6i81JJKFw5B4rhm2Hh6/AxtxqKQM7W3DfI0GgqJDJ3Svenvf+3j0dnIjwwrkcJqzOnb6x4XXm3VlBYUh/MSDQzfpkSHWZZ5ABdZTnvpDAtwDy60V7KDUWSwwrHWTLQIr0KD3pHFZOQD65oB29gDRTvbAe9e3Gp/tMrktNcylrrNg/JAvgSilTl4BOyJqimwrei9eNCF9eI8odkXfDL9EfgS4XCOztP7wPvroTOi6dzXmotEIQayM7y5TRURdQJPyzGmdfjg1yvfleUeKvEngjt9CfGwxyEB1/iEDOLgSQBi08qmX83bykoh8F3/vMtOOFcBGPv9tWmygTfle7yfiZVYjB4pODiwNwMdQEGd9/y1OrJslwkIC0eFRRNhrtTTyZBKWXwqvprwDwLeNvf6U0GnGqQRJa7WciJ7Vy+nfx6HWwKnslbmHdlu8zB6QX1y0IpoH3n/maYOlNAAgsc9Al2i4MGPGVRTUmwpGgnOndyxwIoldYDxDjWzznbkyK8y7pIh0ESpsCA8OVFV2XFGBtbxuOOGRf4wSVo2m22x5MViwicRpWXRJKVOaB7JvYyFCUMmDeRT18irxiesNBeEbnIOeZkxVWsh2CS+xvyEchsK80MemmZW97pV22y0mpCvHTJ+2h9eCXdFN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(166002)(186003)(921005)(6486002)(33964004)(66476007)(2616005)(52116002)(44832011)(8936002)(66574015)(6636002)(45080400002)(31696002)(38100700002)(53546011)(66946007)(316002)(478600001)(36756003)(66556008)(86362001)(110136005)(5660300002)(2906002)(83380400001)(16526019)(8676002)(30864003)(31686004)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dk9ERk8rM1pxODZMVk9jOTViLzFqUUdnTXovd2twN3p5dkRnK20xdlU0ZitG?=
 =?utf-8?B?M2ZTdEdxbVJqZjhrWTNQdmo4ZlV3SG4wWmh3QkZYQzd2cG5Gd203ZlYyR1Vu?=
 =?utf-8?B?cFVBb2Z4Tndrb1BSNm04aWltMytsQVVSUDYzbDA4S0JnMXVGL3BTSnZBQkg2?=
 =?utf-8?B?ZVhLYzBEUkhWdGdzd0xCMGtCVUNhN2svZ3dRbmxQejF2NnQ4QllMbVpFSGVz?=
 =?utf-8?B?UmsvdU1tNjFxb2pLM05KZ3lSMnppaUpYWHpNK0xyeEpvOE9UYWRIREFFSkNG?=
 =?utf-8?B?c2J6Tzg1MzlhYWtBekQyYXRNbktBOGVnUkxzOGVDT29HOWliMy9WRmk5Wkxj?=
 =?utf-8?B?NGhNR0c4cVpPd05LY0FLNi9vVjBJTzc5NCtBenBuMGtISmJSYzF1SitJQ3FG?=
 =?utf-8?B?bWdDV1JiNTNkSHZZTDh0MWZMZGdESFcyVXVydHFaZUNDZC9Kb21FM2g5bE1B?=
 =?utf-8?B?TU1tWVRiSDVldTdCODE1SjZ2bDgzYU43dGJuODVIcmxzcVFBbU80Sko3VzZa?=
 =?utf-8?B?QnM4SG02V1ZxWXAydzZ0ekRuM3hZcXNHQTB0SGRQL3NVekFNN0d2bDV1Q2ZE?=
 =?utf-8?B?RnRUSjhqdHNhTTRGUEhUb1d0dVFjWEUxTEhWVmtDSjdDR2pQc0NXbk5YbHBW?=
 =?utf-8?B?NVJEMEtmemFRNi9vd05BM1ZvcFk2YWQ3ZU5Ga1lCdTdlNXVNZkQwR28vYnFL?=
 =?utf-8?B?YmtKN2R4RGQrblpSQ1JrbTR1N084SjhwaXdZM3ljSmFtQ09mWVo4ZndFSlRD?=
 =?utf-8?B?ZlhYa3FWNDZ3TVIzQnU4L0pUbkxZd2tna0VxeTRwS01SdklBZ2RNcHZadzNH?=
 =?utf-8?B?MnVSWXFKTXpRaFF2bi9aNVNjM3lneWZ1SDNnT2hOdjNtU05iWi81RlRsejhj?=
 =?utf-8?B?TCtFRGJObWRCRGE3YXNiMG9QdWt4czVhdkNmWFVPSlNDR0VtbXE5Y0FuWVJz?=
 =?utf-8?B?cm1sclQwZGtTL1huakg2V1hRWXZleit3UHA4b1d6eEtPUlQxTGttbGwvSFNH?=
 =?utf-8?B?RWR6aFhtcGhyNWxGSEZndnh5ZWsvSURvWm9JWEdjSEFPVFhDNTQrTXNlM3dW?=
 =?utf-8?B?ekZXMmxsK08vSU81cS83bnVmckFpdjAwRkFFUEh5R0pGMzNpVEtKaXQ1V3lQ?=
 =?utf-8?B?a0Qyc2syL2Jpc3JYVVFBbHIvNFRGekVQN2lHcUc4R2RYY0lZT3JFWWk5R2Mr?=
 =?utf-8?B?N2xkekEvc1VDcXBUbmtjcWQ2NEFHK1dTU2p3NndQUXhRaXlkSkR2Y3hVOUw4?=
 =?utf-8?B?em9OeXcrWUVGSmZDTUQ3c0dhTSsyREUvb2l1T1pjMmVLNytjNW5SRG9aMkNT?=
 =?utf-8?B?aWkrczRzN2hMeDNpNlA2bnh6YTVsWUNJaURMQ2JhejNsc2M3MUtadENtdVha?=
 =?utf-8?B?U1ZteFFIQ0NPZVZ3WTV2ODNIVDhHOERlODMySGVmN3JyOTQ5VFBiWXRsNUxH?=
 =?utf-8?B?OWo4KzVtS3RXM1o5ZjNDVjA3U3dHMmlFSHFCb2dHR0tMU2k2QlU5Z2VoZUZ0?=
 =?utf-8?B?T0RZbUtxaGNQdkVWTXhCMDZLRDU3Mzk1RzdKSXJVRkNRUzAxMHV3bDIwZ2gz?=
 =?utf-8?B?NHZIR1lMTk9vanlmQWY4T2h1UWI3b2RQdGJGME5hNWRsbDhWR21US0ovRll4?=
 =?utf-8?B?aTRaUy96eE1CZFBzdTRIdjJ5aGRtUExINFJrbzd5Ymh3RFFScFBDSkt4K2JQ?=
 =?utf-8?B?WlJrY21jOFNKZ2oraS9wbncyWktlbTlyMXo4cUhCWXpGZ25ueFBkeVZxRDFx?=
 =?utf-8?B?cVR4Wmovd2R0Y2lmVmVEa3RVT0NUd1ltcW9aQ0dYVW1CZW1vNi90ZHhaV3BR?=
 =?utf-8?B?K05SZ0w0VWpST3NpNmFIaWQ1bEwrbGxnYVBnVHlmZjV4alRKNVVSUlFwL3BV?=
 =?utf-8?Q?Zo5aFS1iqx+h1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4a65ec-5c60-4f82-1c4f-08d8fddcfd41
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:01:25.8169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rsO4Qlq02h4J/uttLBUNGlVM1iX+hKwliR+TQpf1A6gBQ4nEMbkdSxQmsj1TO5ZME092+LMmUL19ATDa8Cm+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
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
Content-Type: multipart/mixed; boundary="===============1317605113=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1317605113==
Content-Type: multipart/alternative;
 boundary="------------26B96F4CE944EF1219FF2DB5"
Content-Language: en-US

--------------26B96F4CE944EF1219FF2DB5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-04-12 1:44 p.m., Christian König wrote:
>
> Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:
>> On 2021-04-10 1:34 p.m., Christian König wrote:
>>> Hi Andrey,
>>>
>>> Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky:
>>>> [SNIP]
>>>>>>
>>>>>> If we use a list and a flag called 'emit_allowed' under a lock 
>>>>>> such that in amdgpu_fence_emit we lock the list, check the flag 
>>>>>> and if true add the new HW fence to list and proceed to HW 
>>>>>> emition as normal, otherwise return with -ENODEV. In 
>>>>>> amdgpu_pci_remove we take the lock, set the flag to false, and 
>>>>>> then iterate the list and force signal it. Will this not prevent 
>>>>>> any new HW fence creation from now on from any place trying to do 
>>>>>> so ?
>>>>>
>>>>> Way to much overhead. The fence processing is intentionally lock 
>>>>> free to avoid cache line bouncing because the IRQ can move from 
>>>>> CPU to CPU.
>>>>>
>>>>> We need something which at least the processing of fences in the 
>>>>> interrupt handler doesn't affect at all.
>>>>
>>>>
>>>> As far as I see in the code, amdgpu_fence_emit is only called from 
>>>> task context. Also, we can skip this list I proposed and just use 
>>>> amdgpu_fence_driver_force_completion for each ring to signal all 
>>>> created HW fences.
>>>
>>> Ah, wait a second this gave me another idea.
>>>
>>> See amdgpu_fence_driver_force_completion():
>>>
>>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
>>>
>>> If we change that to something like:
>>>
>>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq + 0x3FFFFFFF);
>>>
>>> Not only the currently submitted, but also the next 0x3FFFFFFF 
>>> fences will be considered signaled.
>>>
>>> This basically solves out problem of making sure that new fences are 
>>> also signaled without any additional overhead whatsoever.
>>
>>
>> Problem with this is that the act of setting the sync_seq to some MAX 
>> value alone is not enough, you actually have to call 
>> amdgpu_fence_process to iterate and signal the fences currently 
>> stored in ring->fence_drv.fences array and to guarantee that once you 
>> done your signalling no more HW fences will be added to that array 
>> anymore. I was thinking to do something like bellow:
>>
>
> Well we could implement the is_signaled callback once more, but I'm 
> not sure if that is a good idea.


This indeed could save the explicit signaling I am doing bellow but I 
also set an error code there which might be helpful to propagate to users


>
>> amdgpu_fence_emit()
>>
>> {
>>
>>     dma_fence_init(fence);
>>
>>     srcu_read_lock(amdgpu_unplug_srcu)
>>
>>     if (!adev->unplug)) {
>>
>>         seq = ++ring->fence_drv.sync_seq;
>>         emit_fence(fence);
>>
>> */* We can't wait forever as the HW might be gone at any point*/**
>>        dma_fence_wait_timeout(old_fence, 5S);*
>>
>
> You can pretty much ignore this wait here. It is only as a last resort 
> so that we never overwrite the ring buffers.


If device is present how can I ignore this ?


>
> But it should not have a timeout as far as I can see.


Without timeout wait the who approach falls apart as I can't call 
srcu_synchronize on this scope because once device is physically gone 
the wait here will be forever


>
>>         ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask] 
>> = fence;
>>
>>     } else {
>>
>>         dma_fence_set_error(fence, -ENODEV);
>>         DMA_fence_signal(fence)
>>
>>     }
>>
>>     srcu_read_unlock(amdgpu_unplug_srcu)
>>     return fence;
>>
>> }
>>
>> amdgpu_pci_remove
>>
>> {
>>
>>     adev->unplug = true;
>>     synchronize_srcu(amdgpu_unplug_srcu)
>>
>
> Well that is just duplicating what drm_dev_unplug() should be doing on 
> a different level.


drm_dev_unplug is on a much wider scope, for everything in the device 
including 'flushing' in flight IOCTLs, this deals specifically with the 
issue of force signalling HW fences

Andrey


>
> Christian.
>
>>     /* Past this point no more fence are submitted to HW ring and 
>> hence we can safely call force signal on all that are currently there.
>>      * Any subsequently created  HW fences will be returned signaled 
>> with an error code right away
>>      */
>>
>>     for_each_ring(adev)
>>         amdgpu_fence_process(ring)
>>
>>     drm_dev_unplug(dev);
>>     Stop schedulers
>>     cancel_sync(all timers and queued works);
>>     hw_fini
>>     unmap_mmio
>>
>> }
>>
>>
>> Andrey
>>
>>
>>>
>>>
>>>>
>>>>>>>
>>>>>>> Alternatively grabbing the reset write side and stopping and 
>>>>>>> then restarting the scheduler could work as well.
>>>>>>>
>>>>>>> Christian.
>>>>>>
>>>>>>
>>>>>> I didn't get the above and I don't see why I need to reuse the 
>>>>>> GPU reset rw_lock. I rely on the SRCU unplug flag for unplug. 
>>>>>> Also, not clear to me why are we focusing on the scheduler 
>>>>>> threads, any code patch to generate HW fences should be covered, 
>>>>>> so any code leading to amdgpu_fence_emit needs to be taken into 
>>>>>> account such as, direct IB submissions, VM flushes e.t.c
>>>>>
>>>>> You need to work together with the reset lock anyway, cause a 
>>>>> hotplug could run at the same time as a reset.
>>>>
>>>>
>>>> For going my way indeed now I see now that I have to take reset 
>>>> write side lock during HW fences signalling in order to protect 
>>>> against scheduler/HW fences detachment and reattachment during 
>>>> schedulers stop/restart. But if we go with your approach  then 
>>>> calling drm_dev_unplug and scoping amdgpu_job_timeout with 
>>>> drm_dev_enter/exit should be enough to prevent any concurrent GPU 
>>>> resets during unplug. In fact I already do it anyway - 
>>>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;reserved=0
>>>
>>> Yes, good point as well.
>>>
>>> Christian.
>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>>
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Andrey
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>
>>>
>

--------------26B96F4CE944EF1219FF2DB5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-12 1:44 p.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com">
      
      <br>
      Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:<br>
      <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
        <div class="moz-cite-prefix">On 2021-04-10 1:34 p.m., Christian
          König wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com">Hi
          Andrey, <br>
          <br>
          Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky: <br>
          <blockquote type="cite">[SNIP] <br>
            <blockquote type="cite">
              <blockquote type="cite"> <br>
                If we use a list and a flag called 'emit_allowed' under
                a lock such that in amdgpu_fence_emit we lock the list,
                check the flag and if true add the new HW fence to list
                and proceed to HW emition as normal, otherwise return
                with -ENODEV. In amdgpu_pci_remove we take the lock, set
                the flag to false, and then iterate the list and force
                signal it. Will this not prevent any new HW fence
                creation from now on from any place trying to do so ? <br>
              </blockquote>
              <br>
              Way to much overhead. The fence processing is
              intentionally lock free to avoid cache line bouncing
              because the IRQ can move from CPU to CPU. <br>
              <br>
              We need something which at least the processing of fences
              in the interrupt handler doesn't affect at all. <br>
            </blockquote>
            <br>
            <br>
            As far as I see in the code, amdgpu_fence_emit is only
            called from task context. Also, we can skip this list I
            proposed and just use amdgpu_fence_driver_force_completion
            for each ring to signal all created HW fences. <br>
          </blockquote>
          <br>
          Ah, wait a second this gave me another idea. <br>
          <br>
          See amdgpu_fence_driver_force_completion(): <br>
          <br>
          amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq); <br>
          <br>
          If we change that to something like: <br>
          <br>
          amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq +
          0x3FFFFFFF); <br>
          <br>
          Not only the currently submitted, but also the next 0x3FFFFFFF
          fences will be considered signaled. <br>
          <br>
          This basically solves out problem of making sure that new
          fences are also signaled without any additional overhead
          whatsoever.</blockquote>
        <p><br>
        </p>
        <p>Problem with this is that the act of setting the sync_seq to
          some MAX value alone is not enough, you actually have to call
          amdgpu_fence_process to iterate and signal the fences
          currently stored in ring-&gt;fence_drv.fences array and to
          guarantee that once you done your signalling no more HW fences
          will be added to that array anymore. I was thinking to do
          something like bellow:</p>
      </blockquote>
      <br>
      Well we could implement the is_signaled callback once more, but
      I'm not sure if that is a good idea.<br>
    </blockquote>
    <p><br>
    </p>
    <p>This indeed could save the explicit signaling I am doing bellow
      but I also set an error code there which might be helpful to
      propagate to users</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
      <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
        <p>amdgpu_fence_emit()</p>
        <p>{</p>
        <p>&nbsp;&nbsp;&nbsp; dma_fence_init(fence);<br>
        </p>
        <p>&nbsp;&nbsp;&nbsp; srcu_read_lock(amdgpu_unplug_srcu)</p>
        <p>&nbsp;&nbsp;&nbsp; if (!adev-&gt;unplug)) {</p>
        <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq = ++ring-&gt;fence_drv.sync_seq;<br>
          &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; emit_fence(fence);</p>
        <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <b>/* We can't wait forever as the HW might be gone
            at any point*/</b><b><br>
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; dma_fence_wait_timeout(old_fence, 5S);</b><br>
        </p>
      </blockquote>
      <br>
      You can pretty much ignore this wait here. It is only as a last
      resort so that we never overwrite the ring buffers.<br>
    </blockquote>
    <p><br>
    </p>
    <p>If device is present how can I ignore this ?</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
      But it should not have a timeout as far as I can see.<br>
    </blockquote>
    <p><br>
    </p>
    <p>Without timeout wait the who approach falls apart as I can't call
      srcu_synchronize on this scope because once device is physically
      gone the wait here will be forever</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
      <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
        <p> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.fences[seq &amp;
          ring-&gt;fence_drv.num_fences_mask] = fence;<br>
        </p>
        <p>&nbsp;&nbsp;&nbsp; } else {</p>
        <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dma_fence_set_error(fence, -ENODEV);<br>
          &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; DMA_fence_signal(fence) &nbsp;&nbsp; <br>
        </p>
        <p>&nbsp;&nbsp;&nbsp; } &nbsp; <br>
        </p>
        <p>&nbsp;&nbsp;&nbsp; srcu_read_unlock(amdgpu_unplug_srcu)<br>
          &nbsp;&nbsp;&nbsp; return fence;<br>
        </p>
        <p>}</p>
        <p>amdgpu_pci_remove <br>
        </p>
        <p>{</p>
        <p>&nbsp;&nbsp;&nbsp; adev-&gt;unplug = true;<br>
          &nbsp;&nbsp;&nbsp; synchronize_srcu(amdgpu_unplug_srcu) <br>
        </p>
      </blockquote>
      <br>
      Well that is just duplicating what drm_dev_unplug() should be
      doing on a different level.<br>
    </blockquote>
    <p><br>
    </p>
    <p>drm_dev_unplug is on a much wider scope, for everything in the
      device including 'flushing' in flight IOCTLs, this deals
      specifically with the issue of force signalling HW fences</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
        <p>&nbsp;&nbsp;&nbsp; /* Past this point no more fence are submitted to HW ring
          and hence we can safely call force signal on all that are
          currently there. <br>
          &nbsp;&nbsp;&nbsp;&nbsp; * Any subsequently created&nbsp; HW fences will be returned
          signaled with an error code right away <br>
          &nbsp;&nbsp;&nbsp;&nbsp; */<br>
        </p>
        <p>&nbsp;&nbsp;&nbsp; for_each_ring(adev)<br>
          &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; amdgpu_fence_process(ring)</p>
        <p>&nbsp;&nbsp;&nbsp; drm_dev_unplug(dev);<br>
          &nbsp;&nbsp;&nbsp; Stop schedulers<br>
          &nbsp;&nbsp;&nbsp; cancel_sync(all timers and queued works);<br>
          &nbsp;&nbsp;&nbsp; hw_fini<br>
          &nbsp;&nbsp;&nbsp; unmap_mmio<br>
        </p>
        <p>}</p>
        <p><br>
        </p>
        <p>Andrey</p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com"> <br>
          <br>
          <blockquote type="cite"> <br>
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite"> <br>
                  Alternatively grabbing the reset write side and
                  stopping and then restarting the scheduler could work
                  as well. <br>
                  <br>
                  Christian. <br>
                </blockquote>
                <br>
                <br>
                I didn't get the above and I don't see why I need to
                reuse the GPU reset rw_lock. I rely on the SRCU unplug
                flag for unplug. Also, not clear to me why are we
                focusing on the scheduler threads, any code patch to
                generate HW fences should be covered, so any code
                leading to amdgpu_fence_emit needs to be taken into
                account such as, direct IB submissions, VM flushes e.t.c
                <br>
              </blockquote>
              <br>
              You need to work together with the reset lock anyway,
              cause a hotplug could run at the same time as a reset. <br>
            </blockquote>
            <br>
            <br>
            For going my way indeed now I see now that I have to take
            reset write side lock during HW fences signalling in order
            to protect against scheduler/HW fences detachment and
            reattachment during schedulers stop/restart. But if we go
            with your approach&nbsp; then calling drm_dev_unplug and scoping
            amdgpu_job_timeout with drm_dev_enter/exit should be enough
            to prevent any concurrent GPU resets during unplug. In fact
            I already do it anyway - <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
 IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0</a><br>
          </blockquote>
          <br>
          Yes, good point as well. <br>
          <br>
          Christian. <br>
          <br>
          <blockquote type="cite"> <br>
            Andrey <br>
            <br>
            <br>
            <blockquote type="cite"> <br>
              <br>
              Christian. <br>
              <br>
              <blockquote type="cite"> <br>
                Andrey <br>
                <br>
                <br>
                <blockquote type="cite"> <br>
                  <blockquote type="cite"> <br>
                    Christian. <br>
                    <br>
                    <blockquote type="cite"> <br>
                      Andrey <br>
                      <br>
                      <br>
                      <blockquote type="cite"> <br>
                        <blockquote type="cite">Andrey <br>
                          <br>
                          <br>
                        </blockquote>
                        <br>
                      </blockquote>
                    </blockquote>
                    <br>
                  </blockquote>
                  <br>
                </blockquote>
              </blockquote>
              <br>
            </blockquote>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------26B96F4CE944EF1219FF2DB5--

--===============1317605113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1317605113==--

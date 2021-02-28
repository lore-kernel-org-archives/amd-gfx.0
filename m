Return-Path: <SRS0=JjkA=H6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B27C433E0
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 13:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1EA64E76
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 13:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1EA64E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DB088437;
	Sun, 28 Feb 2021 13:59:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7865088437
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Feb 2021 13:59:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVuWA9JCSLovkd8BnthC18j4uP2HEPY2+kttn4BuhjfM14/4r18/GfjcZdJre3ZMYpNKw38JxINbvBfIqK3TtJA6r25RlGlct9z8XmF8NeVdNbvRGfGphWUaap38CBNDY7QcVQjjbNjuYRAQkx7ndcSKRHDLVBItMJIHw2rY+i7R6++1SMfivJXGXoJZqcoLbVgDwA8usGoh5ox18D1X2b6XoVSdmOkpjv9zGurDJuaT2zedF3I4h+BTYMioz9ml2Fo7rxv2BmPtlPF4I1/IseAlF5BMp3fJRWDDwKt7Ajg+qo+0yOYexrsV0mfd8WD1omdJzlyp+cXKB+A1OAzHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4whfcvDOaD0BwZK2l4LzCELFkwZl9JLAViAjteTn/M=;
 b=P+DnC0YbciB2Y1Huff5d7sCUg+8a1nzKOERZxrfjfgc2Kwzy8dk0tIB6w7TfPnksPg4BjgRiHGEC0aq+Y2AKeTG+cOMyS0ZocDPe39PmK5PVELAXtInsupUzhR+v0ppkQRaBY7Lrx7DWzkbJw562IWyqzar1SYxQhziO6go/EuA1QtuYhWhNFM5DNlIbb99c3ybWw9JRcjVKghjINKJKKPeBYO7gBrefkUZ2/FEEGhk6NvG9qEUEdELvJXp1eAbqqGdBkpnOat0MsQ/DHXkdu+Q3OhkQFQcw8YNh+gGz4JJwp6vvPoObOzdo5xQ1uv6EwSD0V1NJ7AR7HUj+eqDUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4whfcvDOaD0BwZK2l4LzCELFkwZl9JLAViAjteTn/M=;
 b=MYbVaIaBUuyYixSxuBeJ6ymwem0fH+lcZRP2X+LlOE4NPLHOQTAr2MknK8t8q/734ZDkRIdzdhGFO/kkUmdTJn53lOoNqTaukyYkArFDKz4V7dzkLjemKr3q3KuHGwPiezCUzjKCkSLtkVXUx941zZsekn+VgQPdipNIs2dvWkU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Sun, 28 Feb
 2021 13:59:53 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3890.028; Sun, 28 Feb 2021
 13:59:53 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUkZDXSBhIG5ldyBhcHByb2FjaCB0?=
 =?UTF-8?Q?o_detect_which_ring_is_the_real_black_sheep_upon_TDR_reported?=
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <f65d8f80-a283-933a-82bb-97b415689460@amd.com>
 <DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <eb07f03b-0ea4-f9a1-47bf-4e8b65ac7081@amd.com>
 <DM5PR12MB1708A26CFB637B10A7C7F6B7849C9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <d0fb9566-49c6-cfda-f38d-740bd032ca1d@amd.com>
 <DM5PR12MB170892C661DF1943780049EA849B9@DM5PR12MB1708.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <f0a46368-c17a-558f-bce1-bb84806135ad@amd.com>
Date: Sun, 28 Feb 2021 08:59:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM5PR12MB170892C661DF1943780049EA849B9@DM5PR12MB1708.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:1f10:eb39:4a6b:30f8]
X-ClientProxiedBy: YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::48) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:1f10:eb39:4a6b:30f8]
 (2607:fea8:3edf:49b0:1f10:eb39:4a6b:30f8) by
 YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20 via Frontend Transport; Sun, 28 Feb 2021 13:59:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d581485c-37b8-484f-3683-08d8dbf11f2e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:
X-MS-Exchange-MinimumUrlDomainAge: lists.freedesktop.org#0
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2493CE7278C2428DA6782254EA9B9@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkyBGdw5b8jI/6WePIIfMkfIFdAnRmHrFvEC58rH9BUOlQ75xgLHHfwXQzzlgEhRWZY/sPh0v9MHEfkLO6LlKPmP0Cd0P/F7TR9x3/k3keyXdy8NiNK+kPNPq5nL0YvbP7Dq3Sc/SS/420u8A07DZmkV88VY8kqWNF+AvxADXkVAAXTD/hxnOCRLDOjcQYKe7rOsGin/kPlktYAMNMc0yn3X2Mv6PzTbuHYZ4hTAt8naqZ3G9dSIfaJL2uTLS2ozaVQLF+x0MoqYVwhHloJgHFllFyuItkDlPtytWe+ZjLaXsNZDDBwjP3Mb51xrYdC8Ggy/E+U8bbqlOOeSpwtJ2epCNXSF8GSGwIh3A/mKu8k1jyP9PIOibOdIlnTiYJmkCZlcl/nBuKIlbYkpDrndaBr2v5Qhqve1gAU2QzHAZY0K+ot5gBqWorG6bOj8/ehmRB0TF91vE0JWYocfHXpK1/7SLAsnW3nhK5lcpn9QR8rNCfL9qpFl39hhoqm/1Y/XlpdggcKat7qD46rBesKRcdsQzZOhsf3P7ZB1bfhmeuRqSHeT23YhXNkyWHvZMBdQwSlRBz9wwGT6RK59zK9G2mcMZygpDc9LGacfyoYnNzCeSyYIWzhxfYGQUhu8/HikWS+S2b5KCs10n7NlNx7BLJD2aZUDkvEKKgLdH1DhMuzEKvMmOKQ0FRwtXZu3SGet
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(86362001)(33964004)(53546011)(52116002)(30864003)(8936002)(2906002)(36756003)(31696002)(83380400001)(66476007)(66556008)(166002)(5660300002)(66946007)(31686004)(224303003)(16526019)(186003)(316002)(4326008)(966005)(6486002)(110136005)(478600001)(54906003)(2616005)(44832011)(45980500001)(43740500002)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dVliUGhuejd6dVo2VDRLSVMzY1N3TmJreG5ubytLMTNUb09jdm82cXRpR3Fv?=
 =?utf-8?B?U2xFNGJtcTlhVVRvd1hoK3pONkRlSGUxRk82WHQ4VUErQ1NzUlJKMzFTVmho?=
 =?utf-8?B?TVp1ZEJzZURpUGZEOEZ2b0g1RzVyTnlHL0M3Y0NTNlR6Y2d4OXhDQ3BUcUg4?=
 =?utf-8?B?Q2tIK2FXSi9CQXJBVllrckd1MGFIRHZlSnZCb3V1L2YxWFVLTjJ3VTZuU0pM?=
 =?utf-8?B?bFVsN04vYXp5Tno4MTlKRHRzN25BYzM3aGhlVnVhNHRSaHJGWEtDZkttakVZ?=
 =?utf-8?B?WVNrU3UzMjg2b1Rvck5Kb2p6STgxYkVDVWhmbnVNa28wUWQ3TlJDVi9OUGw5?=
 =?utf-8?B?T0Ywck5qK3Q3NXhoeFNrZkt4bEpzdUI0NmdqMFJPRXdMOG5zSmdKNU1wcmVP?=
 =?utf-8?B?ejJNSkc4Y2g4N0F5a2xJMStOWE9hNjVLeDRoMCtHOUJadktmejg0RDdrVGVo?=
 =?utf-8?B?NDUwcXpxUGUrczFRTlR1MHlKNlRaTlJTc0dvanJZV1RmNEhZYm1CemN5N2ZM?=
 =?utf-8?B?SVhEZVM2RUZFd3dYU0RJZlZQTzNvN0ZWYU1IYXBxR0xWQTdkb1FEcm9FMVRQ?=
 =?utf-8?B?NlZxNDZObXpaQjc3S0tzdUk4Rm5XbFpDbmp5Y1FQOVJpNTE2YjEyS25iYThX?=
 =?utf-8?B?eDdwdW5oNnJScHpJU0ZHOWhTYjJDTWo4d2Npa2swcFFSUDlmUzBQT0IrT1No?=
 =?utf-8?B?eThzVFd2QWhPYXJtak9nbGRRdTVyU1JjSEE5U3F0Vk5YU3ZRYnlMZmlhekdi?=
 =?utf-8?B?VU5WaHVOQy9KQkc2ZEFVejc1dFpZc3RNOGtkck94SEpCNmtVcUQvbjFsOE1n?=
 =?utf-8?B?cldlSVhpdmVweThkUFN6aXd2OTBrSTRvL0hRZU1oUURBOWhpQ3MzU042cFBz?=
 =?utf-8?B?cTlmTWlpVGhYMXBkWWJ0MmxvUUl3U3hoQk5UZEc2UHNEQ1Y5WFp5Z0JQcmxW?=
 =?utf-8?B?VEdsY1NxOEpuWEsvR2x4SlJhdG5ISS9lckJwallwRHFQY0w5S3dDNjZSMWhV?=
 =?utf-8?B?ekRxZWE5ZThwNmFPZmRIWS90R0dzSm0xR2huZjhTc0Z0QnBBRmFkSGxYN2FE?=
 =?utf-8?B?TGoxZkZnNHI2aEN3K3FPeG1LT1RYOFp3djNqVFZVdmgxeFZNUW1MWkFmTEVH?=
 =?utf-8?B?UG5uQkRQZXFPTDdpUWdFM2UrejROUUVMejhpZlhJQXR6Zy90M2RVQmlON1l6?=
 =?utf-8?B?MXEzN0VpMGt5NkVBZVFycUE4a0dmc0c5YlByVnlQeWVZbm1rb3gwL1RZZDJJ?=
 =?utf-8?B?R2o4VHpFU3g4WkdUMjRTWUJkZjZiN2ZSbG1WRTMrVnZGRGJ5ZzJGNXdJdkQr?=
 =?utf-8?B?cnI0SG1GOEs3Z0IzYS9NRVpMZWZXYWxuYzYvK0hwSGgzVzJ1eHhxMFB3L09P?=
 =?utf-8?B?SHRzVWQzOS9GdEdKaW1zSXVUb1lqVStETjZTMG9vOUxnenB2bkN4NXVlL0RG?=
 =?utf-8?B?Z3FLU0lLSEtwNWZNM3NRVWFqejA1dWRObmFjekhzVUlCUnd6OFRRMjFJVFVh?=
 =?utf-8?B?bkliaGJUUVFWZ1VLcDFpRXlRWUUrK0hWa3V0OTdhNW5kSERoQWhKOHFYandN?=
 =?utf-8?B?bHNmVWxYK0E0T2J2RGkrNmNHL0VlZ1p3RTBYdjVabWIzQk1uYnU3b1A1Vi8v?=
 =?utf-8?B?WU8yWW5XMEV0R2YxZmp0K1JhV3BGK0NwNCtzZHR1UE8rcmZQeHVjempkZFhr?=
 =?utf-8?B?eWRHZEtFcW5oeWk5TmpES0tUakdmMWJOeTI3dHM1L2E4VzBJVTREQzJUS3lD?=
 =?utf-8?B?QmN3Rk90bTZIRGgxWjB5ZmhqcHZsTEVBWFNNZmRXbldGT3JkelU1TmE2N094?=
 =?utf-8?B?RFJFOXRjN3VTT1UyRG1uaDhRM2RVK1Zham1oNFBBNzhqR2VIci80OUgxYStr?=
 =?utf-8?Q?zLu3sTsui6UWN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d581485c-37b8-484f-3683-08d8dbf11f2e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2021 13:59:53.5075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKVS7pZpE1vkgATiMTzWr3AMZq1LpEkyoE2KsO33Cin/H24IRdlTDkgwT0zOXdlbZzzVD8fpy1DJTFX38DfpZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: multipart/mixed; boundary="===============1386584785=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1386584785==
Content-Type: multipart/alternative;
 boundary="------------F2B8AB8DAC49784B56EE598B"
Content-Language: en-US

--------------F2B8AB8DAC49784B56EE598B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-02-27 11:10 p.m., Liu, Monk wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> >>So gfx job hangs because it has a dependency on buggy compute job 
> which already is hanging ?
>
> No, there is no dependency between this gfx job and that compute job 
> from a software perspective , but the CU is shared thus gfx is 
> affected by the bug from that compute job
>
> >>I am still missing something - we don't ever delete bad jobs or any 
> jobs until they are signaled, we reinsert the bad  job back into 
> mirror list in drm_sched_stop
>
> Oh yeah, it was still kept in the mirror list, I thought it was 
> removed once for good in scheduler…
>
> then my question is why we need to remove it in scheduler part if we 
> always need to reinsert it back?
>

See explanation in the original fix in this commit 'drm/scheduler: Avoid 
accessing freed bad job.' - the problem with that fix was that while it 
solved the original race issue it created another issue where if the 
driver was prematurely terminating the reset process due to guilty job 
already being signaled (optimization - like we have in non amdgpu 
drivers) OR reset lock contention from multiple TDR threads (like we 
have in amdgpu) then indeed we would remove the bad job but would not 
reinsert back as we would skip drm_sched_stop. For which issue Luben 
proposed a state machine approach to the entire job life cycle handling 
(can't find the patch-set now) but during which review it was decided 
that the optimal approach would be to stop relying on the job and start 
relying on the entity->finish_fence to keep all the info (What Christian 
mentions in the beginning of this thread).


> And even for other vendors the better way is still
>
> let vendor driver decide the heading job.
>
> The real issue we hit is : sometimes if we run a quark test (it hangs 
> kcq ring with a bad shader inside), X server will occasionally crash 
> with a GFX ring TDR report
>
> Root cause is still what I described before:  both this innocent gfx 
> job and the guilty compute job are all marked as “guilty” by our 
> driver, so even they are re-inserted back to mirror list
>
> But they are all abandoned in drm_sched_resubmit_jobs() due to they 
> are all processed by drm_sched_increase_karma()
>

I see now, in this case the main issue is indeed that we cannot rely on 
head job in mirror list to be the actual bad and guilty job and this 
then requires some redesign (e.g. along the lines of what you suggested).

Andrey


> *发件人:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *发送时间:*2021年2月28日8:55
> *收件人:*Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> *抄送:*Zhang, Andy <Andy.Zhang@amd.com>; Chen, Horace 
> <Horace.Chen@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> *主题:*Re: 回复: [RFC] a new approach to detect which ring is the real 
> black sheep upon TDR reported
>
> On 2021-02-26 10:56 p.m., Liu, Monk wrote:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     H Andrey
>
>     The scenario I hit here is not the one you mentioned, let me
>     explain it with more details by another much easier understood
>     example:
>
>     Consider ring you have a job1 on KCQ, but the timeout of KCQ is 60
>     seconds (just for example)
>
>     You also have a job2 on GFX ring, and the timeout of GFX is 2 seconds
>
>     We submit job1 first, and assume job1 have bug and it will cause
>     shader hang very very soon
>
>     After 10 seconds we submit job2, since KCQ have 60 seconds to
>     report TDR thus SW know nothing about the engine already hang
>
> So gfx job hangs because it has a dependency on buggy compute job 
> which already is hanging ?
>
>     After 2 seconds we got TDR report from job2 on GFX ring,
>     sched_job_timeout() think the leading job of GFX ring is the black
>     sheep so it is deleted from the mirror list
>
>     But in fact this job1 is innocent, and we should insert it back
>     after recovery , and due to it was already deleted this innocent
>     job’s context/process is really harmed
>
> I am still missing something - we don't ever delete bad jobs or any 
> jobs until they are signaled, we reinsert the bad  job back into 
> mirror list in drm_sched_stop
> (here - 
> https://elixir.bootlin.com/linux/v5.11.1/source/drivers/gpu/drm/scheduler/sched_main.c#L385) 
> after sched thread is stopped and continue with the reset procedure.
>
> Andrey
>
>     Hope above example helps
>
>     Thanks
>
>     *发件人:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>     <mailto:Andrey.Grodzovsky@amd.com>
>     *发送时间:*2021年2月27日0:50
>     *收件人:*Liu, Monk <Monk.Liu@amd.com> <mailto:Monk.Liu@amd.com>;
>     Koenig, Christian <Christian.Koenig@amd.com>
>     <mailto:Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     *抄送:*Zhang, Andy <Andy.Zhang@amd.com> <mailto:Andy.Zhang@amd.com>;
>     Chen, Horace <Horace.Chen@amd.com> <mailto:Horace.Chen@amd.com>;
>     Zhang, Jack (Jian) <Jack.Zhang1@amd.com> <mailto:Jack.Zhang1@amd.com>
>     *主题:*Re: [RFC] a new approach to detect which ring is the real
>     black sheep upon TDR reported
>
>     On 2021-02-26 6:54 a.m., Liu, Monk wrote:
>
>         [AMD Official Use Only - Internal Distribution Only]
>
>         See in line
>
>         Thanks
>
>         ------------------------------------------
>
>         Monk Liu | Cloud-GPU Core team
>
>         ------------------------------------------
>
>         *From:*Koenig, Christian <Christian.Koenig@amd.com>
>         <mailto:Christian.Koenig@amd.com>
>         *Sent:* Friday, February 26, 2021 3:58 PM
>         *To:* Liu, Monk <Monk.Liu@amd.com> <mailto:Monk.Liu@amd.com>;
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         *Cc:* Zhang, Andy <Andy.Zhang@amd.com>
>         <mailto:Andy.Zhang@amd.com>; Chen, Horace
>         <Horace.Chen@amd.com> <mailto:Horace.Chen@amd.com>; Zhang,
>         Jack (Jian) <Jack.Zhang1@amd.com> <mailto:Jack.Zhang1@amd.com>
>         *Subject:* Re: [RFC] a new approach to detect which ring is
>         the real black sheep upon TDR reported
>
>         Hi Monk,
>
>         in general an interesting idea, but I see two major problems
>         with that:
>
>         1. It would make the reset take much longer.
>
>         2. Things get often stuck because of timing issues, so a
>         guilty job might pass perfectly when run a second time.
>
>         [ML] but the innocent ring already reported a TDR, and the drm
>         sched logic already deleted this “sched_job” in its mirror
>         list, thus you don’t have chance to re-submit it again after
>         reset, that’s the major problem here.
>
>     Just to confirm I understand correctly, Monk reports a scenario
>     where the second TDR that was reported by the innocent job is
>     bailing out BEFORE having a chance to run  drm_sched_stop for that
>     scheduler which should have reinserted the job back into mirror
>     list (because the first TDR run is still in progress and hence
>     amdgpu_device_lock_adev fails for the second TDR) and so the
>     innocent job which was extracted from mirror list in
>     drm_sched_job_timedout is now lost.
>     If so and as a possible quick fix until we overhaul the entire
>     design as suggested in this thread - maybe we can modify
>     drm_sched_backend_ops.timedout_job callback to report back
>     premature termination BEFORE drm_sched_stop had a chance to run
>     and then reinsert back the job into mirror list from within
>     drm_sched_job_timedout? There is no problem of racing against
>     concurrent drm_sched_get_cleanup_job once we reinsert there as we
>     don't reference the job pointer anymore after this point and so if
>     it's already signaled and freed right away - it's ok.
>
>     Andrey
>
>
>         Apart from that the whole ring mirror list turned out to be a
>         really bad idea. E.g. we still struggle with object life time
>         because the concept doesn't fit into the object model of the
>         GPU scheduler under Linux.
>
>         We should probably work on this separately and straighten up
>         the job destruction once more and keep the recovery
>         information in the fence instead.
>
>         [ML] we claim to our customer that no innocent process will be
>         dropped or cancelled, and our current logic works for the most
>         time, but only when there are different process running on
>         gfx/computes rings then we would run into the tricky situation
>         I stated here, and the proposal is the only way I can figure
>         out so far, do you have a better solution or idea we review it
>         as another candidate RFC ? Be note that we raised this
>         proposal is because we do hit our trouble and we do need to
>         resolve it …. So even a not perfect solution is still better
>         than just cancel the innocent job (and their context/process)
>
>         Thanks !
>
>
>         Regards,
>         Christian.
>
>         Am 26.02.21 um 06:58 schrieb Liu, Monk:
>
>             [AMD Public Use]
>
>             Hi all
>
>             NAVI2X  project hit a really hard to solve issue now, and
>             it is turned out to be a general headache of our TDR
>             mechanism , check below scenario:
>
>              1. There is a job1 running on compute1 ring at timestamp
>              2. There is a job2 running on gfx ring at timestamp
>              3. Job1 is the guilty one, and job1/job2 were scheduled
>                 to their rings at almost the same timestamp
>              4. After 2 seconds we receive two TDR reporting from both
>                 GFX ring and compute ring
>              5. *Current scheme is that in drm scheduler all the head
>                 jobs of those two rings are considered “bad job” and
>                 taken away from the mirror list *
>              6. The result is both the real guilty job (job1) and the
>                 innocent job (job2) were all deleted from mirror list,
>                 and their corresponding contexts were also treated as
>                 guilty*(so the innocent process remains running is not
>                 secured)*
>
>             **
>
>             But by our wish the ideal case is TDR mechanism can detect
>             which ring is the guilty ring and the innocent ring can
>             resubmits all its pending jobs:
>
>              1. Job1 to be deleted from compute1 ring’s mirror list
>              2. Job2 is kept and resubmitted later and its belonging
>                 process/context are even not aware of this TDR at all
>
>             Here I have a proposal tend to achieve above goal and it
>             rough procedure is :
>
>              1. Once any ring reports a TDR, the head job is **not**
>                 treated as “bad job”, and it is **not** deleted from
>                 the mirror list in drm sched functions
>              2. In vendor’s function (our amdgpu driver here):
>
>                   * reset GPU
>                   * repeat below actions on each RINGS * one by one *:
>
>             1.take the head job and submit it on this ring
>
>             2.see if it completes, if not then this job is the real
>             “bad job”
>
>             3. take it away from mirror list if this head job is “bad job”
>
>                   * After above iteration on all RINGS, we already
>                     clears all the bad job(s)
>
>              3. Resubmit all jobs from each mirror list to their
>                 corresponding rings (this is the existed logic)
>
>             The idea of this is to use “serial” way to re-run and
>             re-check each head job of each RING, in order to take out
>             the real black sheep and its guilty context.
>
>             P.S.: we can use this approaches only on GFX/KCQ ring
>             reports TDR , since those rings are intermutually affected
>             to each other. For SDMA ring timeout it definitely proves
>             the head job on SDMA ring is really guilty.
>
>             Thanks
>
>             ------------------------------------------
>
>             Monk Liu | Cloud-GPU Core team
>
>             ------------------------------------------
>
>
>
>
>         _______________________________________________
>
>         amd-gfx mailing list
>
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--------------F2B8AB8DAC49784B56EE598B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-02-27 11:10 p.m., Liu, Monk
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM5PR12MB170892C661DF1943780049EA849B9@DM5PR12MB1708.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML 预设格式 字符";
	margin:0cm;
	font-size:10.0pt;
	font-family:"Courier New";}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.HTML
	{mso-style-name:"HTML 预设格式 字符";
	mso-style-priority:99;
	mso-style-link:"HTML 预设格式";
	font-family:"Courier New";}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle25
	{mso-style-type:personal-reply;
	font-family:等线;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:503861270;
	mso-list-type:hybrid;
	mso-list-template-ids:1492292582 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1279491622;
	mso-list-type:hybrid;
	mso-list-template-ids:-1736673670 67698703 67698689 67698703 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1655448059;
	mso-list-type:hybrid;
	mso-list-template-ids:-1584207202 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p><span style="font-size:10.5pt;font-family:等线" lang="EN-US">&gt;&gt;</span><span lang="EN-US"> So gfx job hangs because it has a dependency
              on buggy compute job which already is hanging ?<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">No,
              there is no dependency between this gfx job and that
              compute job from a software perspective , but the CU is
              shared thus gfx is affected by the bug from that compute
              job
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">&gt;&gt;</span><span lang="EN-US"> I am still missing something - we don't ever
              delete bad jobs or any jobs until they are signaled, we
              reinsert the bad&nbsp; job back into mirror list in
              drm_sched_stop<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">Oh yeah, it was still
              kept in the mirror list, I thought it was removed once for
              good in scheduler…<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">then my question is
              why we need to remove it in scheduler part if we always
              need to reinsert it back? </span></p>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>See explanation in the original fix in this commit&nbsp;
      'drm/scheduler: Avoid accessing freed bad job.' - the problem with
      that fix was that while it solved the original race issue it
      created another issue where if the driver was prematurely
      terminating the reset process due to guilty job already being
      signaled (optimization - like we have in non amdgpu drivers) OR
      reset lock contention from multiple TDR threads (like we have in
      amdgpu) then indeed we would remove the bad job but would not
      reinsert back as we would skip drm_sched_stop. For which issue
      Luben proposed a state machine approach to the entire job life
      cycle handling (can't find the patch-set now) but during which
      review it was decided that the optimal approach would be to stop
      relying on the job and start relying on the
      entity-&gt;finish_fence to keep all the info (What Christian
      mentions in the beginning of this thread).&nbsp;</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:DM5PR12MB170892C661DF1943780049EA849B9@DM5PR12MB1708.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span lang="EN-US">And even for other
              vendors the better way is still<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">let vendor driver
              decide the heading job.<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">The real issue we hit
              is : sometimes if we run a quark test (it hangs kcq ring
              with a bad shader inside), X server will occasionally
              crash with a GFX ring TDR report<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">Root cause is still
              what I described before: &nbsp;both this innocent gfx job and
              the guilty compute job are all marked as “guilty” by our
              driver, so even they are re-inserted back to mirror list<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">But they are all
              abandoned in drm_sched_resubmit_jobs() due to they are all
              processed by drm_sched_increase_karma()</span></p>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I see now, in this case the main issue is indeed that we cannot
      rely on head job in mirror list to be the actual bad and guilty
      job and this then requires some redesign (e.g. along the lines of
      what you suggested).</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:DM5PR12MB170892C661DF1943780049EA849B9@DM5PR12MB1708.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span lang="EN-US"><o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0cm 0cm 0cm">
              <p class="MsoNormal"><b><span style="font-family:等线">发件人<span lang="EN-US">:</span></span></b><span style="font-family:等线" lang="EN-US"> Grodzovsky,
                  Andrey <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                  <br>
                </span><b><span style="font-family:等线">发送时间<span lang="EN-US">:</span></span></b><span style="font-family:等线" lang="EN-US"> 2021</span><span style="font-family:等线">年<span lang="EN-US">2</span>月<span lang="EN-US">28</span>日<span lang="EN-US"> 8:55<br>
                  </span><b>收件人<span lang="EN-US">:</span></b><span lang="EN-US"> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>;
                    Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  </span><b>抄送<span lang="EN-US">:</span></b><span lang="EN-US"> Zhang, Andy
                    <a class="moz-txt-link-rfc2396E" href="mailto:Andy.Zhang@amd.com">&lt;Andy.Zhang@amd.com&gt;</a>; Chen, Horace
                    <a class="moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a>; Zhang, Jack (Jian)
                    <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
                  </span><b>主题<span lang="EN-US">:</span></b><span lang="EN-US"> Re: </span>回复<span lang="EN-US">:
                    [RFC] a new approach to detect which ring is the
                    real black sheep upon TDR reported<o:p></o:p></span></span></p>
            </div>
          </div>
          <p class="MsoNormal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <div>
            <p class="MsoNormal"><span lang="EN-US">On 2021-02-26 10:56
                p.m., Liu, Monk wrote:<o:p></o:p></span></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p style="margin:5.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7" lang="EN-US">[AMD Official Use Only - Internal
                Distribution Only]<o:p></o:p></span></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:宋体" lang="EN-US"><o:p>&nbsp;</o:p></span></p>
            <div>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">H
                  Andrey</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">&nbsp;</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">The
                  scenario I hit here is not the one you mentioned, let
                  me explain it with more details by another much easier
                  understood example:</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">&nbsp;</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">Consider
                  ring you have a job1 on KCQ, but the timeout of KCQ is
                  60 seconds (just for example)</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">You
                  also have a job2 on GFX ring, and the timeout of GFX
                  is 2 seconds</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">&nbsp;</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">We
                  submit job1 first, and assume job1 have bug and it
                  will cause shader hang very very soon
                </span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">After
                  10 seconds we submit job2, since KCQ have 60 seconds
                  to report TDR thus SW know nothing about the engine
                  already hang</span><span lang="EN-US"><o:p></o:p></span></p>
            </div>
          </blockquote>
          <p><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p><span lang="EN-US">So gfx job hangs because it has a
              dependency on buggy compute job which already is hanging ?<o:p></o:p></span></p>
          <p><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <div>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">After
                  2 seconds we got TDR report from job2 on GFX ring,
                  sched_job_timeout() think the leading job of GFX ring
                  is the black sheep so it is deleted from the mirror
                  list</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">But
                  in fact this job1 is innocent, and we should insert it
                  back after recovery , and due to it was already
                  deleted this innocent job</span><span style="font-size:10.5pt;font-family:等线">’<span lang="EN-US">s context/process is really harmed</span></span><span lang="EN-US"><o:p></o:p></span></p>
            </div>
          </blockquote>
          <p><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <p><span lang="EN-US">I am still missing something - we don't
              ever delete bad jobs or any jobs until they are signaled,
              we reinsert the bad&nbsp; job back into mirror list in
              drm_sched_stop
              <br>
              (here - <a href="https://elixir.bootlin.com/linux/v5.11.1/source/drivers/gpu/drm/scheduler/sched_main.c#L385" moz-do-not-send="true">
https://elixir.bootlin.com/linux/v5.11.1/source/drivers/gpu/drm/scheduler/sched_main.c#L385</a>)
              after sched thread is stopped and continue with the reset
              procedure.<o:p></o:p></span></p>
          <p><span lang="EN-US">Andrey<o:p></o:p></span></p>
          <p><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <div>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">&nbsp;</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">Hope
                  above example helps</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">&nbsp;</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">Thanks
                </span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:10.5pt;font-family:等线" lang="EN-US">&nbsp;</span><span lang="EN-US"><o:p></o:p></span></p>
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0cm 0cm 0cm">
                  <p class="MsoNormal"><b><span style="font-family:等线">发件人<span lang="EN-US">:</span></span></b><span style="font-family:等线" lang="EN-US"> Grodzovsky,
                      Andrey
                      <a href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                      <br>
                    </span><b><span style="font-family:等线">发送时间<span lang="EN-US">:</span></span></b><span style="font-family:等线" lang="EN-US"> 2021</span><span style="font-family:等线">年<span lang="EN-US">2</span>月<span lang="EN-US">27</span>日<span lang="EN-US"> 0:50<br>
                      </span><b>收件人<span lang="EN-US">:</span></b><span lang="EN-US"> Liu, Monk <a href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">
                          &lt;Monk.Liu@amd.com&gt;</a>; Koenig,
                        Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                          &lt;Christian.Koenig@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                      </span><b>抄送<span lang="EN-US">:</span></b><span lang="EN-US"> Zhang, Andy <a href="mailto:Andy.Zhang@amd.com" moz-do-not-send="true">
                          &lt;Andy.Zhang@amd.com&gt;</a>; Chen, Horace <a href="mailto:Horace.Chen@amd.com" moz-do-not-send="true">&lt;Horace.Chen@amd.com&gt;</a>;
                        Zhang, Jack (Jian)
                        <a href="mailto:Jack.Zhang1@amd.com" moz-do-not-send="true">&lt;Jack.Zhang1@amd.com&gt;</a><br>
                      </span><b>主题<span lang="EN-US">:</span></b><span lang="EN-US"> Re: [RFC] a new approach to detect
                        which ring is the real black sheep upon TDR
                        reported</span></span><span lang="EN-US"><o:p></o:p></span></p>
                </div>
              </div>
              <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <div>
                <p class="MsoNormal"><span lang="EN-US">On 2021-02-26
                    6:54 a.m., Liu, Monk wrote:<o:p></o:p></span></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="msipheadera92f4c5c" style="margin:0cm"><span style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7" lang="EN-US">[AMD Official Use Only - Internal
                    Distribution Only]</span><span lang="EN-US"><o:p></o:p></span></p>
                <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                <p class="MsoNormal"><span lang="EN-US">See in line<o:p></o:p></span></p>
                <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                <div>
                  <p class="MsoNormal"><span lang="EN-US">Thanks <o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">Monk Liu |
                      Cloud-GPU Core team<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
                </div>
                <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0cm 0cm 0cm">
                    <p class="MsoNormal"><b><span lang="EN-US">From:</span></b><span lang="EN-US"> Koenig, Christian
                        <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>
                        <br>
                        <b>Sent:</b> Friday, February 26, 2021 3:58 PM<br>
                        <b>To:</b> Liu, Monk <a href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">&lt;Monk.Liu@amd.com&gt;</a>;
                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                          amd-gfx@lists.freedesktop.org</a><br>
                        <b>Cc:</b> Zhang, Andy <a href="mailto:Andy.Zhang@amd.com" moz-do-not-send="true">&lt;Andy.Zhang@amd.com&gt;</a>;
                        Chen, Horace
                        <a href="mailto:Horace.Chen@amd.com" moz-do-not-send="true">&lt;Horace.Chen@amd.com&gt;</a>;
                        Zhang, Jack (Jian)
                        <a href="mailto:Jack.Zhang1@amd.com" moz-do-not-send="true">&lt;Jack.Zhang1@amd.com&gt;</a><br>
                        <b>Subject:</b> Re: [RFC] a new approach to
                        detect which ring is the real black sheep upon
                        TDR reported<o:p></o:p></span></p>
                  </div>
                </div>
                <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US">Hi Monk,<br>
                    <br>
                    in general an interesting idea, but I see two major
                    problems with that:<br>
                    <br>
                    1. It would make the reset take much longer.<br>
                    <br>
                    2. Things get often stuck because of timing issues,
                    so a guilty job might pass perfectly when run a
                    second time.<o:p></o:p></span></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US">[ML] but the innocent ring already
                    reported a TDR, and the drm sched logic already
                    deleted this “sched_job” in its mirror list, thus
                    you don’t have chance to re-submit it again after
                    reset, that’s the major problem here.<o:p></o:p></span></p>
              </blockquote>
              <p><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <p><span lang="EN-US">Just to confirm I understand
                  correctly, Monk reports a scenario where the second
                  TDR that was reported by the innocent job is bailing
                  out BEFORE having a chance to run&nbsp; drm_sched_stop for
                  that scheduler which should have reinserted the job
                  back into mirror list (because the first TDR run is
                  still in progress and hence amdgpu_device_lock_adev
                  fails for the second TDR) and so the innocent job
                  which was extracted from mirror list in
                  drm_sched_job_timedout is now lost.<br>
                  If so and as a possible quick fix until we overhaul
                  the entire design as suggested in this thread - maybe
                  we can modify drm_sched_backend_ops.timedout_job
                  callback to report back premature termination BEFORE
                  drm_sched_stop had a chance to run and then reinsert
                  back the job into mirror list from within&nbsp;
                  drm_sched_job_timedout? There is no problem of racing
                  against concurrent drm_sched_get_cleanup_job once we
                  reinsert there as we don't reference the job pointer
                  anymore after this point and so if it's already
                  signaled and freed right away - it's ok. <o:p></o:p></span></p>
              <p><span lang="EN-US">Andrey<o:p></o:p></span></p>
              <p><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US"><br>
                    Apart from that the whole ring mirror list turned
                    out to be a really bad idea. E.g. we still struggle
                    with object life time because the concept doesn't
                    fit into the object model of the GPU scheduler under
                    Linux.<br>
                    <br>
                    We should probably work on this separately and
                    straighten up the job destruction once more and keep
                    the recovery information in the fence instead.<o:p></o:p></span></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US">[ML] we claim to our customer that no
                    innocent process will be dropped or cancelled, and
                    our current logic works for the most time, but only
                    when there are different process running on
                    gfx/computes rings then we would run into the tricky
                    situation I stated here, and the proposal is the
                    only way I can figure out so far, do you have a
                    better solution or idea we review it as another
                    candidate RFC ? Be note that we raised this proposal
                    is because we do hit our trouble and we do need to
                    resolve it …. So even a not perfect solution is
                    still better than just cancel the innocent job (and
                    their context/process)<o:p></o:p></span></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US">Thanks ! <o:p>
                    </o:p></span></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><span lang="EN-US"><br>
                    Regards,<br>
                    Christian.<o:p></o:p></span></p>
                <div>
                  <p class="MsoNormal"><span lang="EN-US">Am 26.02.21 um
                      06:58 schrieb Liu, Monk:<o:p></o:p></span></p>
                </div>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="msipheader251902e5" style="margin:0cm"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100" lang="EN-US">[AMD Public Use]</span><span lang="EN-US"><o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">Hi all<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">NAVI2X
                      &nbsp;project hit a really hard to solve issue now, and
                      it is turned out to be a general headache of our
                      TDR mechanism , check below scenario:<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                  <ol style="margin-top:0cm" type="1" start="1">
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><span lang="EN-US">There is a job1 running on compute1
                        ring at timestamp
                        <o:p></o:p></span></li>
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><span lang="EN-US">There is a job2 running on gfx ring
                        at timestamp<o:p></o:p></span></li>
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><span lang="EN-US">Job1 is the guilty one, and
                        job1/job2 were scheduled to their rings at
                        almost the same timestamp
                        <o:p></o:p></span></li>
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><span lang="EN-US">After 2 seconds we receive two TDR
                        reporting from both GFX ring and compute ring<o:p></o:p></span></li>
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><b><span lang="EN-US">Current scheme is that in drm
                          scheduler all the head jobs of those two rings
                          are considered “bad job” and taken away from
                          the mirror list
                        </span></b><span lang="EN-US"><o:p></o:p></span></li>
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l0 level1 lfo1"><span lang="EN-US">The result is both the real guilty
                        job (job1) and the innocent job (job2) were all
                        deleted from mirror list, and their
                        corresponding contexts were also treated as
                        guilty<b> (so the innocent process remains
                          running is not secured)</b><o:p></o:p></span></li>
                  </ol>
                  <p class="MsoListParagraph"><b><span lang="EN-US">&nbsp;</span></b><span lang="EN-US"><o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">But by our
                      wish the ideal case is TDR mechanism can detect
                      which ring is the guilty ring and the innocent
                      ring can resubmits all its pending jobs:<o:p></o:p></span></p>
                  <ol style="margin-top:0cm" type="1" start="1">
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l2 level1 lfo2"><span lang="EN-US">Job1 to be deleted from compute1
                        ring’s mirror list<o:p></o:p></span></li>
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l2 level1 lfo2"><span lang="EN-US">Job2 is kept and resubmitted later
                        and its belonging process/context are even not
                        aware of this TDR at all
                        <o:p></o:p></span></li>
                  </ol>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">Here I have a
                      proposal tend to achieve above goal and it rough
                      procedure is :<o:p></o:p></span></p>
                  <ol style="margin-top:0cm" type="1" start="1">
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level1 lfo3"><span lang="EN-US">Once any ring reports a TDR, the
                        head job is *<b>not</b>* treated as “bad job”,
                        and it is *<b>not</b>* deleted from the mirror
                        list in drm sched functions<o:p></o:p></span></li>
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level1 lfo3"><span lang="EN-US">In vendor’s function (our amdgpu
                        driver here):<o:p></o:p></span></li>
                  </ol>
                  <ol style="margin-top:0cm" type="1" start="2">
                    <ul style="margin-top:0cm" type="disc">
                      <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level2 lfo3"><span lang="EN-US">reset GPU<o:p></o:p></span></li>
                      <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level2 lfo3"><span lang="EN-US">repeat below actions on each
                          RINGS * one by one *:<o:p></o:p></span></li>
                    </ul>
                  </ol>
                  <p class="MsoListParagraph" style="margin-left:108.0pt;text-indent:-9.0pt;mso-list:l1
                    level3 lfo3">
                    <!--[if !supportLists]--><span lang="EN-US"><span style="mso-list:Ignore">1.<span style="font:7.0pt &quot;Times New Roman&quot;">
                        </span></span></span><!--[endif]--><span lang="EN-US">take the head job and submit it on
                      this ring<o:p></o:p></span></p>
                  <p class="MsoListParagraph" style="margin-left:108.0pt;text-indent:-9.0pt;mso-list:l1
                    level3 lfo3">
                    <!--[if !supportLists]--><span lang="EN-US"><span style="mso-list:Ignore">2.<span style="font:7.0pt &quot;Times New Roman&quot;">
                        </span></span></span><!--[endif]--><span lang="EN-US">see if it completes, if not then this
                      job is the real “bad job”<o:p></o:p></span></p>
                  <p class="MsoListParagraph" style="margin-left:108.0pt;text-indent:-9.0pt;mso-list:l1
                    level3 lfo3">
                    <!--[if !supportLists]--><span lang="EN-US"><span style="mso-list:Ignore">3.<span style="font:7.0pt &quot;Times New Roman&quot;">
                        </span></span></span><!--[endif]--><span lang="EN-US">&nbsp;take it away from mirror list if
                      this head job is “bad job”<o:p></o:p></span></p>
                  <ol style="margin-top:0cm" type="1" start="2">
                    <ul style="margin-top:0cm" type="disc">
                      <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level2 lfo3"><span lang="EN-US">After above iteration on all
                          RINGS, we already clears all the bad job(s)<o:p></o:p></span></li>
                    </ul>
                  </ol>
                  <ol style="margin-top:0cm" type="1" start="3">
                    <li class="MsoListParagraph" style="margin-left:0cm;mso-list:l1 level1 lfo3"><span lang="EN-US">Resubmit all jobs from each mirror
                        list to their corresponding rings (this is the
                        existed logic)<o:p></o:p></span></li>
                  </ol>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">The idea of
                      this is to use “serial” way to re-run and re-check
                      each head job of each RING, in order to take out
                      the real black sheep and its guilty context.<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">P.S.: we can
                      use this approaches only on GFX/KCQ ring reports
                      TDR , since those rings are intermutually affected
                      to each other. For SDMA ring timeout it definitely
                      proves the head job on SDMA ring is really guilty.<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">Thanks <o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">Monk Liu |
                      Cloud-GPU Core team<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
                  <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                </blockquote>
                <p class="MsoNormal"><span lang="EN-US">&nbsp;<o:p></o:p></span></p>
                <p class="MsoNormal"><span lang="EN-US"><br>
                    <br>
                    <br>
                    <o:p></o:p></span></p>
                <pre><span lang="EN-US">_______________________________________________<o:p></o:p></span></pre>
                <pre><span lang="EN-US">amd-gfx mailing list<o:p></o:p></span></pre>
                <pre><span lang="EN-US"><a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><o:p></o:p></span></pre>
                <pre><span lang="EN-US"><a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></pre>
              </blockquote>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------F2B8AB8DAC49784B56EE598B--

--===============1386584785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1386584785==--

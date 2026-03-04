Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AB8EF8FEA
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 14:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2375E10E18B;
	Wed,  4 Mar 2026 14:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TwfwUDaX";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2F110E18B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 14:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv7g2PmFj/vEqfOYBRFAaSQX7U8shIRxKf8cV1YcCUyubGX4SpZfyNlUetMpFsJPj2/fqgkmtVTxl+FJ8zIwxNIfc7lLsVb0Pq/wFNsghl+v/l5nibp3kleP6myXVw557c956nTOLym/ujukqA5q2UXADfBSGi3+Mk2+NpeFMM1Gfs50ZbxIOcJqKudl7BP1glhf09Qp+h7uaHUyOBkLtFNazBMj/82atlqDkpne94PWw0SQ09r7Cb2YTFUtNYWlS2bLzqg4RiwrDrsvV8Osc29G+KqdYs5zCCWSd/M/AbT9h51FmI3eczs2cJi2FqYqxmWrX0ek5DTcC+m/vINysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXcFzpSBP+fj/mX8cNzjr3rc5CtlXtAJFo6y/WyrNP8=;
 b=veV9gCDAQnjUwEaXZPNcSsQ0EzQAD+c7SsHVZf/9uLftnF1hsAkK9jXJwC3Q5RXbciW0gIinQZrrQhl0SEeeatrjRhC8GdNSXcIVEyLc9QzQzZ9Bm7RDBh6OwVb9JmiQ+o207pgMaOYR8fLZg7A9L4HXW9rz1wJnZRStlJz5snmU6lOyEIs/jEe+vzZJ5xcROSQUcBQ8yg+WYxZ6sNYQ7OK6P40EbLhqfYpsGxY0eucBA2PjScNg3SQ14Cp3VQlpyNhzEGcdkW2AAVC+qorcHk60pvEKkkcikz/AxmwL/QLvjcrgGqA6qEJloEIyy3ljgd1KliApAcAUJO7aQp5t7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXcFzpSBP+fj/mX8cNzjr3rc5CtlXtAJFo6y/WyrNP8=;
 b=TwfwUDaXTVuboPDVnrzOOXL/0pDHWir146BRpHvszTEqUuEbKVMaNXrGksc3anTtY34AaXCgvbsMNUBk3Psq2m95FZRIZfZoE9w84/aCpoy6zbDQesVYMVgBm9pRfRB016QfTAsy+RMoKaMe42/AMr59MRM5t6Eq36WTurZ2mT8=
Received: from BL0PR02CA0091.namprd02.prod.outlook.com (2603:10b6:208:51::32)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 4 Mar
 2026 14:20:59 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::86) by BL0PR02CA0091.outlook.office365.com
 (2603:10b6:208:51::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Wed,
 4 Mar 2026 14:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 14:20:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 4 Mar
 2026 08:20:59 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Mar
 2026 08:20:58 -0600
Received: from [10.254.95.60] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 08:20:58 -0600
Message-ID: <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
Date: Wed, 4 Mar 2026 09:20:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Michele Palazzi <sysdadmin@m1k.cloud>, Shengyu Qu <wiagn233@outlook.com>, 
 <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <siqueira@igalia.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 3747c969-8bb6-44c6-68b7-08de79f94205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|42112799006|82310400026|36860700016|32650700020;
X-Microsoft-Antispam-Message-Info: TzaLRvpMsrtqva2MBf/ejPAHq1lNVQ8fjTKCzSEwiZyMXaW4p+dvj3zwEVBQ9fBdDKpUymuMPB9MD/ZongLfyfWXaByKKum1kmxZoJv6Bor+xLnSB4wVsjxSre5z3eJvKqV4hjWKPYPmoRkTKVZS0zLpW95yaEzMsbC+OVtjybLdDo83Ue72HV4A/mAzssLIaIwUdFMaYqX8VPN/TnOUHIewEneKMP7vSDFY92FoPiAXD+20p9T48U29m2motQ5p7t7yLQomMR+Lib5Jk2hOE4o9NNH+MHJ5WiT6MayQpVGzEW7ye2qBgT6Sx9O9TZ/2Rl3+EaghBjWbujHlCYRTGLCszprxnBqUyJ0cjZTfK54o3/rb4BvKrcRaN+jGG8vWmfjuBfGWu0U7gvUWPz19r/KcTGmNMFgjqC4YshVMHxGpnXtA6+GANyjK7ZATQQCXVNj3maF9Ea+MhxqIogV5CGR+hr/01xr1UN7G2QIB1ayS1KlmL/1Autxr+VzHsoEEAFrSM4bIA8tC4/mwMOvfhxQvfz8Xnt72Cui+0TNknEWs6yYdIlLRkRCVoHxWSFtq4jHJXaYJEho/aNwuA/TmIVJ6xnlYkHWKCvPSrJRz2xq/B+trTTaQUKa0CNbzSUdaHLtrUeTf4AipAtQxqkGK3q/kJz9ivLHIKJ4hPn46fyBx+22Mr1w/deXgASQbOb6WATt55XaejGtM6kj/tfXYJZ2sFWeXdyp4m0jJXtp1unLOhZtaPOA6yixjUMdDadavHEYrX7gEPecmt5+3GSAbrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(42112799006)(82310400026)(36860700016)(32650700020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cy4CMraHCLfsLNCWZbbcbvQZezVe1xFXhY/Xv2+lCezxvfuKSJsVQT9+yq+wkS0hzc5a7pruZZeB10axioNitJ0HVNUqW/7clngKdzpQF8I73SU9YAmd4RDlxB2MXGTS9cA9wU+RpaPcE1bSSq/vI8/RAYBPpvaPvkXQtHUJCW1FvyKNpRYPF8k5j+M4WNXabi00YWAW9DN5KXM8dcpGpfFsjDjfYzoZrV0aEZzThISG9C8VFTcEyDtSoGjJZWS3nBENIr1GmYC6DzOesIQ3ZMn0mhGLRqO2TznjB8lUFK3yQg6zuHF8DSESuJ7HcGFL2Jb+7SCFzq+OrAk19ktbh0PjiVq3whNmYYFqYbnU51H8x1iAV6b+P1Xt+RMkVHynQvjbVXdyBc8/u0voITf5DKv5Bi070Is9dWb8oXZknHyeVCtYRiE5ELdC/6i+fNsz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 14:20:59.4161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3747c969-8bb6-44c6-68b7-08de79f94205
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D
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



On 2026-03-04 09:00, Michele Palazzi wrote:
> On 3/3/26 20:07, Leo Li wrote:
>>
>>
>> On 2026-03-03 03:17, Shengyu Qu wrote:
>>>> Here's a patch that inserts a few trace events.
>>>> https://pastebin.com/dpLnVSbu
>>>>
>>>> Could you try to reproduce the hang again while recording these trace events?
>>>> Using trace-cmd (with stack trace enabled '-T'):
>>>
>>> I think Michele said that the timeout issue would be masked by drm.debug due to overhead?
>>
>> I'm hoping that enabling a few tracepoints would have much less overhead than
>> enabling drm.debug. Depending on which debug flag, there can be a lot of dmesg
>> output.
>>
>> If tracepoints ends up masking the race condition, I wonder if there's a way for
>> bpftrace to probe the lines where the tracepoints are inserted, and print out
>> the event's pointer address. If so, that's a viable alternative.
>>
>> - Leo
> So far i could not reproduce with your tracing patch applied, i could try to use bpftrace instead but it will take some time, i am quite busy these days.

Understood. If you haven't tried already, maybe dropping the stack trace (-T) flag is worth a shot.
- Leo


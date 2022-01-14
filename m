Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B97C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D3710E1CB;
	Fri, 14 Jan 2022 20:37:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15C610E1CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ0wKkkEGyYFDwdPuprcAQDJ051BK1GHh/8vlE7cWVgqEWer869SsjHOVccaCsRakPt0S2nT+9fxBPRF8w/eUH7bOyPtU/IR8qoIfJnBSEN/cJPZlTuJ88eGz7w8hdSmvyFfrnKqyEaJX3tXLVfqxLF32Eu8HYs6Ov6E31xM57aHfgDT56DV/GJWiksIDUhif7k4iJq6H2FGH9DvwV1LMUfHt+bTjPR3D7RTAKe3Sb9QakqYdeeTnm8qYX7AOD48//bYyNSyBwCQpDLIry9kFSrMPB4o3u+QP1nLFMcZAIir8s+acKB3ORQ+7tzEsu2H6nT0UCpptomHAB1d3zf/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egTuy+nVmEwNCnDvoPOzVpfkVKo3ZQ4n9iVOg5jP0RU=;
 b=N+Idzh9vyy1BHpTQVUmMG0cZ7cYhNutRQusXZutm4I6yYM3S2Ro/eaIgQL1pj7b8y6cWdcq286acLGw9zqFsFSKY5GxdyNBuJFlJPYiNex8m2Fejoj/2B8izVj1ja4/WZq92tVXja3gu9rh0iLJf+clXAQTWmuvkYH3/Rni+x4S4VgXLZFajmW+Yk2XZJuAm50ita5/qIHxJSwI7wUHa8mN1XtZdXYD6ylBWPbuKL5GAXT9eXgkpDSlJrsspFRFyC20JpnybHzGiM2n+oRgU/PM9TtBneAXyBHADqzQc/e0n70BvQ0tg6PbOcTEM75JqWnkv2CpnUwmRfF3aTsXlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egTuy+nVmEwNCnDvoPOzVpfkVKo3ZQ4n9iVOg5jP0RU=;
 b=Xy2RjZOHF+YwTodkyLK8MW3LTjBNc2Bjcj63SqGAoGjJjkPJogIlHVCAn3sYCvUIR1fPFFjZ2GiXux5A5yWk40Q21uPIVnz779cjHZpCi4NZhdL5jlbUCo8HM4h6muGLPSPyUzNJ9wavPChGq0Sn2pTKkBneO5nqsLU2AkcCCiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MWHPR1201MB2493.namprd12.prod.outlook.com (2603:10b6:300:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 14 Jan
 2022 20:37:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::14cd:f56f:bac0:a862]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::14cd:f56f:bac0:a862%7]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 20:37:05 +0000
Subject: Re: [PATCH 0/5] HMM profiler interface
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220114203256.19821-1-Philip.Yang@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <f4b8c692-c7be-3d86-8bd8-59215a30ed9b@amd.com>
Date: Fri, 14 Jan 2022 15:37:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220114203256.19821-1-Philip.Yang@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:610:76::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8718e1ac-94f1-4ef4-9079-08d9d79da038
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2493:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB249392F1FAAF240F59611506E6549@MWHPR1201MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NF6EfAVN8sn1v1wGfTbebiTR5Je0nxvdjuy+pXv3Q0YTAeyVXh1dPgFWpcIT72iFmUFtGaaB2qwnF1MEaEruJPVVBUYfDZIkWvDsY3sQlaOPgMI8Q1qQ+UZNA5RjNR5zl6ijuYhszN4wFpByNq74HB3oTEhexCLgQWZLI1J5KAp4ak4bjMFDSHwulWWA+srBCQqCSY/EDSXt90Aymi43IuxrCjm1K8OLAniUwrORmDXCy5vtNGpEGourwBBOgyX+Dl6Fpck7uLfVPmU2BYWVtdPTLP8ANnWiXo9V/tZsRpjA/CS4T0u8rOWeUh2Cj9wzO6ganm+xGJtbB4hKEy+TpTk3OOOPq2crtS8RyTY9KYDvK1YN2b7U+O4JpHPo9Q5lWM5PxhcFobFlz2oiiMCJ7g8qTuRgH8UMyIEsAnzWo3Rdo10pNOwxpgeyTdklpKqCwj5aTICoXfhwTCSYvN3KtVzjCQPl345DaTHrKjXgrEpFvk8YoUoMNiT3JY1HFLgrMWkEw5LvN6kjlv4Y84kewdK/PJlDHJjulED1MQWSfy6ORO8nXvudOrOiabQKq3/19Uq6nCRwaOIAMnq3hVTgx7LKqm8xD3CSeyOBPxYe1UDcZQ7uwQezN6108aqQNR7TRSZfIcARhVnNAckhzHZ7A7Qg7YmIChnHNOSoypGdhNFsC9uv616KIzvShkDVQBIfyx+mxII++XimhdJDyr/rdpS+wObpMj0jE5VzjjCvtAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(186003)(53546011)(83380400001)(31696002)(8676002)(6506007)(36756003)(5660300002)(31686004)(508600001)(2616005)(38100700002)(66556008)(66476007)(4326008)(316002)(8936002)(66946007)(6512007)(2906002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sjk0bVA0K3Y2c3FZSlFYcnQvUFNSVzJvOVM4WVhyYUFsTnZIYzIvMlhQSDIw?=
 =?utf-8?B?WUxiUXRpVGdZbENhbjB1MVVES1kwb3lhanNHU1NocmlMVWV2UkczRW44ajFN?=
 =?utf-8?B?bUdzc0pQb0l3S1o4MzlRaXpsM3JoYTFEWUJoRVU3NVZiemYySzkvbWtVMkNM?=
 =?utf-8?B?TVpPWXJ6dURCbnVTdUNkTldHMm1BWkpkdUJjbHNUWkplTTR4RUlWaVlSNW9M?=
 =?utf-8?B?VWVlOG5SamhBczIvYlpWUXNNVENmYlhIVHNLVnNUTndzVHN1NGJMSEJ6L3pW?=
 =?utf-8?B?dmRLdFE1c29HTXRsVDhHMG1YdmZhUUtZNDdsaUJRQlFBdE4zTG5zOG9mOVAw?=
 =?utf-8?B?NW93Z3JxS2t1QzN6OEc0QVlhSS9tZWloRGQ4ZTdWS0ptWFYxWndleElMV1or?=
 =?utf-8?B?Vmp4ZDNKaVgyZUZxaVN1WWtjTUJYdHgxeCtMdHRGYlRBT1dTMUVmN2ZBWjhh?=
 =?utf-8?B?UGF1SXJnTUJkWm5EZVVNandBOFJGdGpXeWNFSXMzWEFmVGxOQmQ2UEdYcWND?=
 =?utf-8?B?MnFCUGxLU2FvbWNDODZxQ0F4M05zUllrK1Q3eTY4cDlEOFFkOEhMKzQxUTM0?=
 =?utf-8?B?VC9QS1lsQkNkRXZtYmVRRzBOVjNNejdTeUhQUzErankvUm9vanZyeW90UVd1?=
 =?utf-8?B?YVo3Mk9QZkp4aWtnUlVoYVI4OWcvY1pKalhMZGFaZTR4bW5NZ0NtbGppMG1X?=
 =?utf-8?B?WVZ2ODJFWTlObmJvem5BdE5PM05XQ3U5aWhvR04yMjNCWUF0OG9vNDJZUXNk?=
 =?utf-8?B?eDl0cXNNWGVjcXE2ZjNHOXZvSmR2YXYvcWNZT3UzdlFjR2hObEZsYlVHekRl?=
 =?utf-8?B?SGh5dlAxa0xJeUNOOUR1bUZUTGQ4cWtRYWpWMG9ycVdTeFlQWjBvWGNLajdn?=
 =?utf-8?B?V3RXK2hiWjNyeUJVMG9LOVk2S3dINEFyQ291Y1RSaDZCNlF5ZU91aXoxc1R6?=
 =?utf-8?B?aTlpaEhkOGlNb0dGRHVIeUpxTThaU21WL0pKTXN0WVdCL1BsaW41MHZGREhC?=
 =?utf-8?B?d1kxclhYQ1FXdHA2OWNuWFFJYnZBMWRmbWsrR012SVUvbW8wOW5RT0hOdmNu?=
 =?utf-8?B?Y0dQNHVOeFBpMUZiUXBPMm56TlFvRHIvcDcyaUQ5bW54SWdBRis1dFJXUU43?=
 =?utf-8?B?TllROXc5TzFGR093dmU1TkV6M0dTV0xlVXVnSzlkWFVtMjlmVEFmeURLZ2FT?=
 =?utf-8?B?UzRSTjg1ank4MUVLMmFyU0NPWTNOdHZVNFpEei9IRXptbjhQQVVORXJidWJm?=
 =?utf-8?B?N1lUelVTZVhUSlJSTlVGNTRML2diMGpSa1BKSWN3WC8wYkpCMkVVbElVVFVY?=
 =?utf-8?B?cldCeldJUWZCZWRGcHMxU09iZHE4TEhUZmpjd3YrNFhpRjZOSnFLWjk2Y3d0?=
 =?utf-8?B?NzhkNk1iUmR2c0tVYzBUZlE1QzRrMitCSWpwV0NxUG1lZzc5NkNQMzQrOC9v?=
 =?utf-8?B?bXNVR2dmaGF4NmRSU09nQjJsamc0R041UHd4Vmg3NjFQRjRtQ0taTmMrSWVv?=
 =?utf-8?B?QzhZdGJiNXdIeTFib3ptT3NzM3A5alRqVXROYW5xZ1UrSVdiYzRSMkJId2ZR?=
 =?utf-8?B?UlBrejFQTmVuTkZjMVZaT29SWHdHSkdLZ3ZmaUxiRXJNVkVtZi9mdm91VlBn?=
 =?utf-8?B?VTIrNktESlU5MXg4SG5LRDJtc013ZVRQejlJZG9FYTA4Z0tkRTNPSVcvcUJm?=
 =?utf-8?B?ZFltcjdJZE84MjBITnp2WHdFb3VubFFwN3UzTWZOYU1TdlFid3loWFo3WStO?=
 =?utf-8?B?NUdxU1g2ZkNyc0xxdTBWUzVpZkFoZHhxdXR6U1hCUVRuY3RFOW8vaC9zZENJ?=
 =?utf-8?B?L2VrVUJsb0NzdmYxdTVIR2NVVldwVzRlSm5DWnNLamhLWjFoL2tuSGNJa3dV?=
 =?utf-8?B?dWRxcU9VcmM0ZFh4Q0V1c3gwU09MU1dlL1VCSFg3UXZwN0xVZm1SZnRWaVpY?=
 =?utf-8?B?UHFRTEd4SW5EM3FMMUI1SGhQa29laWZWUlRSdlg1UC9XekM4NWxza3JDbFJX?=
 =?utf-8?B?YkIwTGFBVkRnZ2t0LzJqU1NCa0ZlMEx5SEljcmJJZ295N2lhZHJuZzJtajJD?=
 =?utf-8?B?MHBPSVo3SVFVK1FLN0hERUhsN0cyQTRVMHVIR0JxeC80RXpOQ1lyaXpNZVk5?=
 =?utf-8?Q?Lp8I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8718e1ac-94f1-4ef4-9079-08d9d79da038
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:37:04.9096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rw3SO5Os8cHM6Hi/wwpI2ttlemxL/pmEW/svzK8sqaJutdk16eaqQMEax6OQeBV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2493
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Please discard this, I will resend. <br>
    </p>
    <div class="moz-cite-prefix">On 2022-01-14 3:32 p.m., Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220114203256.19821-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">The ROCm profiler would expose the data from KFD profiling APIs to 
application developers to tune the applications based on how the address
range attributes affect the behavior and performance.

Per process event log use the existing SMI (system management interface) 
event API. Each event log is one line of text, starting with event id, 
and then name=value pairs for the event specific information.

Philip Yang (5):
  drm/amdkfd: svm range restore work deadlock when process exit
  drm/amdkfd: correct SMI event read size
  drm/amdkfd: enable per process SMI event
  drm/amdkfd: add page fault SMI event
  drm/amdkfd: add migration SMI event

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 67 +++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h    |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c    |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 98 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  8 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 42 +++++----
 include/uapi/linux/kfd_ioctl.h              | 27 ++++++
 7 files changed, 198 insertions(+), 50 deletions(-)

</pre>
    </blockquote>
  </body>
</html>

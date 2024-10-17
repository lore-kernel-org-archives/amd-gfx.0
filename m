Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7A1D3C52C
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 19:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B5310E224;
	Thu, 17 Oct 2024 19:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hXffGFYk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A8B10E33B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 19:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msUC/HGPQtCsE9GWwsOfathdowcxuf91OyMu1kPWGSy7MGR9R830ZIaOiP9A3sKCWfdpt06NhiW3hPDVEklE/K/d6vzpPe/z9ZKvCFScZ43P6qIh4ENYI1Sm6rck7BTQfbMSW25o17Fd1avwoyCWsXVxw8ADHQkuL/6S5JlMIZTuOf3i7fvLkfH4zdKhSwpWn+qkYlahp/LDUZTvfim+r2Q+OG97PluW07zdQQmxn2uEEv8/03zaCisxXHIVmEXzDTenmpf9e2yUsUS9la0eN48sV8I/WkWvveT1L+u8mgo78dLQitbPNh4I/H/6wr/pwVT5DQNEkrPnbEhsXpKe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+BmExK9ssmV769D2NXGJwos6PDDRERTropPhsxVBck=;
 b=VZ6pQ/ShEGOcTSU+wRwpWwPpBeRc4Ci7GWn0ibaMsJGPBSNcOVILKtpF/DeAKNYd7EoegI3sQWhSIFJfBUNttrkjHwhNrhm2dbrtWuMDyDMUvlbfWJ2G+CzyrcCc4sOgxZi6RlCkhVrd4VpEaBzNf36oxPNdyKxXkKwuMIqfZwxzUfgIAJoLaTbB7lq+FGTlpT2ad3fDmFVNa4qgAaeF1FW6pD9AZ6StvCDKVncibjBKuxcJBPNqb3hh5xsCbedkZlcxneYo7m0QRsTq2qPK35Kg+QBk6J/BYOi/yzPD7/tHx+Z+AvpATbE4tbBl1JdUSMcK4NGil+FbiJRc6eUEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+BmExK9ssmV769D2NXGJwos6PDDRERTropPhsxVBck=;
 b=hXffGFYk/wfi/n55du7jhfuqSm6FCgq0Og+38pL1p4fqZ6LS+qQurCP65rp6Lk6np9nbA65CxCXRkVPO1K2lBWZg5A+VeXYmIIc7aFaZDAfPX9HrkIvxZ+tMyJuwwoDRfpFM91JK5Y5ZsG2icDK2e7cqg+XePb8KBb82mXjYmt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Thu, 17 Oct
 2024 19:46:54 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:46:54 +0000
Message-ID: <04c177ec-efaf-a178-b46c-f05200db5ad3@amd.com>
Date: Thu, 17 Oct 2024 15:46:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/amdkfd: add/remove kfd queues on start/stop KFD
 scheduling
To: Shaoyun Liu <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241017161216.739111-1-shaoyun.liu@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20241017161216.739111-1-shaoyun.liu@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0317.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: d5788b2f-bae5-49d3-b73b-08dceee473e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjlkRzRWbVB6MjZSRDd0ZWZnZktWbkZzc2Yvek5PdlRGRUZmRGJyU0Exa1JV?=
 =?utf-8?B?b1BYZTdRRlVKUmswNm1FV2IrR05Ja2dwZ1JSNEFQZmlOTENhVEo3MnRmUEJw?=
 =?utf-8?B?dUpxemt4S2pTR3NsT2VoR0FCZmNOVkpZNnFGdE9KMDR3b3o4WDJ4ZjdiWFJE?=
 =?utf-8?B?Qk82ZEJ2ZWlsRlFyTGloNCtWYWg5bjJhQksrYmd3alRFeis0UElzbjBJQ0ta?=
 =?utf-8?B?REtHTWpWY2Z5QnR4Z2lMNlZMZExzSTVneE5oK0dWNkhZRGJRWGN1TkNaYjI3?=
 =?utf-8?B?bG5BZ2RhVkVzQTlzQU81dWQvQUJTcHY4V1FBNmZUcFhzeWJXWnFVTllncW9Y?=
 =?utf-8?B?OUdUQU1oSG8rVFVjS2l3Skl0aExHU1ZRdHhYRXc0SUViUjB4bkFrdGZmNEYw?=
 =?utf-8?B?eXQ1QzVoWk8rendTbEt5dkwzemFjRVJsUTVZS0psUkUwc1dDbUNLaGQ2YjFC?=
 =?utf-8?B?K1owSU51dmFaOUF6K2pSU2E1bWlnM2lld1ZtZkZFdzVEaWRYYzF5TFcyR2RI?=
 =?utf-8?B?Nnl1RXJTcGt2MUF0L3owR3NUaU1KNjh0cjBsL0FrZHRmM3NST2dXUlFGTzZm?=
 =?utf-8?B?VUZSRGFMdHZCc083U21IUjNXdVRVaFhXUzcvL3FQZFNNeEFTNk4rYVdtZHdP?=
 =?utf-8?B?a0drRmdDRW5pd2ZWak5sbnZ2Rm5xNWhJMUN3YnBVbWNzOU5DdEhIWnRlRWRK?=
 =?utf-8?B?SEc3RTNVUitIL0JLM0kyZEt1eDQxNXJZTE5WaHJLWm1IUzZEemFzanRLcWhI?=
 =?utf-8?B?dkFYK1FIb1BKUzlQMzF6S3dPVDM2UkhhWDJZSTA4UzdEa1hPci96UkN5MW1l?=
 =?utf-8?B?S3BacG5zM2NmTWJpVXUwRWdFZUJJU2VWYlhZekVTNkFxL0NlQ1BzVFFkTjUr?=
 =?utf-8?B?U29mcHNhSjMzdmFyY2pLazYxeGdhM0FxbWo4UUZrcFR6WG5Dd2Zadk5vcVlm?=
 =?utf-8?B?NlBpOGNlQWtJa2RqWHk3UGhqc3haNlFuVEMxSnFhYWdLY1Q1T2NEbVVtaDY4?=
 =?utf-8?B?RWJWWUhIZ0hwNDM2OWlWa0VteHVOM20rcEZPcTdHMFhXbDFjZHYvb3h1SFpy?=
 =?utf-8?B?QU44dnR4VHh1VHN5eGNYY3FXdG9FQWJGbWMxZUtEVCtnYmRzTm16bkJwb1Fw?=
 =?utf-8?B?L0U1cmVQWERIN1puNWZlS2tkckZhdzE1dDBRU1lBRU8yVzRzTTBoVlN2WDF4?=
 =?utf-8?B?YU1kMXptMi93enNuRFRZU0c1anMrQ3B2VUlKTGlIbHFCcWIrd0paMWRFNTNE?=
 =?utf-8?B?ZU1udmpvdHFQSFhXWVZUdTIvUzk4ay90NUsxRkFaUDIzMm4ydTgxdjVibmpM?=
 =?utf-8?B?d3Q2b3lBZGd1b3UyclJ2eDluenEwckY0cGdNdGNoZUk1ay9uZ2RMLzZJWFYy?=
 =?utf-8?B?RmpUWm8vSjFQTzdPTGxrd3NTN2REQ3BKZlhzZVVOcFNLYkFkYlhmaVRMRDgv?=
 =?utf-8?B?U1ZpSDh1aWF5L0FFWVBid1IybVFrcUNiTjM5WXdNQW95NEFTNkp6eC9mSmVU?=
 =?utf-8?B?QzR5bHEvRVJOMjd1TE9HNGFTazhzeG5wZUNmS2UzcFhReU1FR2hRSUhITmgy?=
 =?utf-8?B?eXZscmd4WCtnRDVCOExPWkg1Vzk3Ti9obDdPWWVudmQzMnQ5VWtpOENBMnJR?=
 =?utf-8?B?Q2t2MlJIWCt5UE5xUXJaR1RIYnlDZTl1TENXcjhyVDB1RjJpcGJ3bXRwR0dj?=
 =?utf-8?B?MkdyWWwyaEU1WjdaalBscFZld0kzV0xiQlBBcjBqK1phSGFSaWZBSUVPMXNs?=
 =?utf-8?Q?Kx/wXiyfgXTxn9tAUW3TqnMXSgKPpSlUjpeR7m1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkF2eWgybmZ6bFBnRW9zY3BSNjBCRWptUjBISmk4bURFZVZtSjRKb01aaFZR?=
 =?utf-8?B?VEg2K1dXUUxjSTJWajZuLzZzczVxSzNuVVdYcEQxbDRGblRnNEVWOUpDWHNP?=
 =?utf-8?B?MENsR3pDNjQrd3RqQm5FMFFjTjdtOC9kRyt1ZlNwWGRzKzdkb0dsaVU2MHVZ?=
 =?utf-8?B?V1JYZEJnNGtQSlY2RCtMbENUL0dUR3E3RjBDenJZSkRLbWNuZVRCYzdGYU9K?=
 =?utf-8?B?aEQyRit6M0N3SFdkVmpGRzVUMEk2V25TNTdiVEpYZWpOanJ1VHZuKzRYZWpk?=
 =?utf-8?B?SkIyM1dLQjFwWjdGTjB0OHJXSk85Q2JEMUNJajVzbkxaNTJqeHlEa2h5NzNF?=
 =?utf-8?B?bzF3dGY5VFF3Q2o5RTVsTlVZL0FWNVp4WktrTmR2UDI2VkFTeW4vVXhFZHJk?=
 =?utf-8?B?L3lzL3RnQXRRNzFHSGJNVFZNOGN1dTc3U3NlV1UvbzBkck1oandPbkV4Wi85?=
 =?utf-8?B?eXVjYS9RdTh6R1RwemFybWk2Wlgrb29wM1hJTE9KbEQ3T2NteHRmOVl5U3M4?=
 =?utf-8?B?a1RTS09GZlZPeGNOZVZtWmRXdW5YbVdiVWQvb2t5RkhkandUbkN4aFFKRW5M?=
 =?utf-8?B?ZG1iaHNBTEthMWJURENHdldidWZ5Y2VkUktsSFN3VUZ3WjF4ZXhLeVFpLy81?=
 =?utf-8?B?WVZSR2ZKOXZhcEZIOXZjZEEzRVlaTFFhdENOc1hudkFqcm1PMUFVUUczTHpk?=
 =?utf-8?B?U2pHTzBwT0FjeS83TFRlYjdiaUU4bHd1QzNMQVJPei9SNG9WQy9pczlmQWxs?=
 =?utf-8?B?b2tpUzZ0eW5TOTU1NUpnRUNKWGkrL1ErZkRORTNaSDlqa3JkaTRLemI0cmZy?=
 =?utf-8?B?UDBnd3NuTmdnaTY1YlJQT25iUTZLOTFXQjZsdEhsU1FlR1pqOU9yMnliNG5q?=
 =?utf-8?B?czBScE5Jc1NLT09qZ2VxVEFnSnkzWHVPVGcwUGlKM0F5NENyeUM0U25YRzhu?=
 =?utf-8?B?K1V1V1ZKRWUyNmlURHJmNUVPUitPWWVET2RHZzFPSVRDTHZBeGgrUWNhRXh3?=
 =?utf-8?B?eXAzbHM1elpuRGNZT1FMNjRKb09wSitqS25WcllBeS9qL0hLeUVudlpybkZ3?=
 =?utf-8?B?Z0RGMzEySUNhRmJlcVAvZHZiOWNGdkt6L2pHTkZFMHBGM1FRZWRFd2hLQ0lD?=
 =?utf-8?B?MG52ZUFqSzVPVnlkWGxwTEVOdW43VFB0OVVZSVRIVnJ3TnpUM2c0OVNscE1I?=
 =?utf-8?B?UGNHejFlSEsyR2RhdnpIR1VtNm1rSkdCVExxSzVhNXp2eTN5c0JtNXl3L3R2?=
 =?utf-8?B?alJKZ0VqdkwvZjFVdUc4bVErSUVJYnpNNDlzZURlc0dhZnR0eld0SVc2WFhw?=
 =?utf-8?B?MzJSWXZvNFZ0WDlQQVNOaEJPQU9CSEdLZWg4THVuM21aRG1ZTkVMMlNqdEZm?=
 =?utf-8?B?R2MwK1RCKzNJV29EUUJVMkRzK2tTMDVXT2lEbHRXSU1PSmJqK1ZWU3JRZmYz?=
 =?utf-8?B?aXVPa1FQc3Z2czd0Wkl4eCtBVlF3N0NVN2tna3FJUy9wN1NvMzg5VHNjQ092?=
 =?utf-8?B?QmVhS2pqcEM2V0VGTjlsSUtDWE1xN1pRdTR5TzVKNGdZa2FTRWJ6NEc3RFAx?=
 =?utf-8?B?L2hyNkwzL0tsZm1QV1ZhQ2diRzRmVVJCQXhvUXBUQit6OUp1L2Z1QzJBN0VS?=
 =?utf-8?B?cWwzcld1QVA2Mi95SFpYZ0UzQnZObzdZOXNqNTI1TlJocnkwWXZxOHc1Vk9E?=
 =?utf-8?B?enpNSXRQTEhWbW1FdHdjME80SG15NldtWWFlalFDWWVCckl3NEk1aWRDc1I0?=
 =?utf-8?B?TkN1KzRRa1pISk5qOTY0dFEvUVpEUWZTVzBtTUpuZnRNaFhvc2xjdncrYjBJ?=
 =?utf-8?B?aEVSNmQrTElLVFRhbnJCM05BVWtPNTl1dzYwRlI3WU5PZmoxaUxLV3VjaklT?=
 =?utf-8?B?WEFZN3Jzbmk4bWlYM1lpdUYyeDgxTTl2bmFad1Zyb2w3QjVKdFMzZjBzZjdx?=
 =?utf-8?B?OFlsbmRaTjdqemMxb1NzU2RtY0xUYTVERzJ5UnI4ZXJ3MWVYMlV1d2NPd3dn?=
 =?utf-8?B?cWVtRjdOQjBzT3J0Rm9jT3FKdFFYc3FLdGc1Y1JGUXZkcGVBUmhoOXZzRWZN?=
 =?utf-8?B?a1YrVEJvWGE3N2tVeTNPdWJBMmFzbWYxbWdMQng2b1RxUHBQUlR3TG1HdXhj?=
 =?utf-8?Q?Wcbo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5788b2f-bae5-49d3-b73b-08dceee473e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:46:54.5512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9rVfqjdIgZVQTrT0/H3Uu4q7lgNmIpKNYegZwVS5D5GOkzSq3LSByeGjrUfo3eJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
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
    <div class="moz-cite-prefix">On 2024-10-17 12:12, Shaoyun Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241017161216.739111-1-shaoyun.liu@amd.com">
      <pre class="moz-quote-pre" wrap="">From: shaoyunl <a class="moz-txt-link-rfc2396E" href="mailto:shaoyun.liu@amd.com">&lt;shaoyun.liu@amd.com&gt;</a>

Add back kfd queues in start scheduling that originally been
removed on stop scheduling.

Signed-off-by: Shaoyun Liu <a class="moz-txt-link-rfc2396E" href="mailto:shaoyun.liu@amd.com">&lt;shaoyun.liu@amd.com&gt;</a>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 40 +++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b2b16a812e73..542363b4712e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -204,6 +204,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 
 	if (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))
 		return -EIO;
+	if (!dqm-&gt;sched_running || dqm-&gt;sched_halt) {</pre>
    </blockquote>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_domain-&gt;sem);
    <blockquote type="cite" cite="mid:20241017161216.739111-1-shaoyun.liu@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		return 0;</pre>
    </blockquote>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
    <blockquote type="cite" cite="mid:20241017161216.739111-1-shaoyun.liu@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 	memset(&amp;queue_input, 0x0, sizeof(struct mes_add_queue_input));
 	queue_input.process_id = qpd-&gt;pqm-&gt;process-&gt;pasid;
@@ -272,6 +274,8 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 
 	if (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))
 		return -EIO;
+	if (!dqm-&gt;sched_running || dqm-&gt;sched_halt) {</pre>
    </blockquote>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_domain-&gt;sem);<br>
    <blockquote type="cite" cite="mid:20241017161216.739111-1-shaoyun.liu@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		return 0;</pre>
    </blockquote>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
    <p>It is simpler to move sched_halt/running check outside reset sem
      lock, but not sure if it is safe.<br>
    </p>
    <p>Regards,</p>
    <p>Philip&nbsp; <br>
    </p>
    <blockquote type="cite" cite="mid:20241017161216.739111-1-shaoyun.liu@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 	memset(&amp;queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q-&gt;properties.doorbell_off;
@@ -292,7 +296,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return r;
 }
 
-static int remove_all_queues_mes(struct device_queue_manager *dqm)
+static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
 {
 	struct device_process_node *cur;
 	struct device *dev = dqm-&gt;dev-&gt;adev-&gt;dev;
@@ -319,6 +323,33 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
+{
+	struct device_process_node *cur;
+	struct device *dev = dqm-&gt;dev-&gt;adev-&gt;dev;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+	int retval = 0;
+
+	list_for_each_entry(cur, &amp;dqm-&gt;queues, list) {
+		qpd = cur-&gt;qpd;
+		list_for_each_entry(q, &amp;qpd-&gt;queues_list, list) {
+			if (!q-&gt;properties.is_active)
+				continue;
+			retval = add_queue_mes(dqm, q, qpd);
+			if (retval) {
+				dev_err(dev, &quot;%s: Failed to add queue %d for dev %d&quot;,
+					__func__,
+					q-&gt;properties.queue_id,
+					dqm-&gt;dev-&gt;id);
+				return retval;
+			}
+		}
+	}
+
+	return retval;
+}
+
 static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm-&gt;dev-&gt;adev;
@@ -1742,7 +1773,7 @@ static int halt_cpsch(struct device_queue_manager *dqm)
 						 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
 				USE_DEFAULT_GRACE_PERIOD, false);
 		else
-			ret = remove_all_queues_mes(dqm);
+			ret = remove_all_kfd_queues_mes(dqm);
 	}
 	dqm-&gt;sched_halt = true;
 	dqm_unlock(dqm);
@@ -1768,6 +1799,9 @@ static int unhalt_cpsch(struct device_queue_manager *dqm)
 		ret = execute_queues_cpsch(dqm,
 					   KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
 			0, USE_DEFAULT_GRACE_PERIOD);
+	else
+		ret = add_all_kfd_queues_mes(dqm);
+
 	dqm_unlock(dqm);
 
 	return ret;
@@ -1867,7 +1901,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	if (!dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes)
 		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
 	else
-		remove_all_queues_mes(dqm);
+		remove_all_kfd_queues_mes(dqm);
 
 	dqm-&gt;sched_running = false;
 
</pre>
    </blockquote>
  </body>
</html>

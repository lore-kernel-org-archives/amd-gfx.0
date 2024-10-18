Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABC4D30011
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 15:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CC010E94A;
	Fri, 18 Oct 2024 15:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="48I20Jbu";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14A6310E94A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 15:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL9L3kPwXom2wKkN0AOit5+ieR5U5gUrCq16igW5hBPql/NbOTMGBou7LLiAcmoCNpn5fD/Fcwy41ZBepq17cIWoWCQu5Ksgtc1jvATwLddcnM3udcluWFRr8CeW4eo7uZNDpedCRGXWEkxWVdDE1daw4f13m9RcG1AUjW6XXwJ1zdQ0urlAPcr0hAGm9UHhMX0mqRqaweBLhVsEuFt/Rg4Dd5pG79NhRE095FDfVBaOsR202O+SrE78Ghyg24xl/5wO1nFJePtSyGUpreKJ9E8Yaxvq7H+747mGzvcHH9HBK/QW7cQkmf1uVS6GZUPsfLrk2GPvmudTdB6KKrDlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnLFlYmKGR4OyUmWCi1pDbraInFwpf8zRX0kUH/8Yug=;
 b=lX96YzUhRFyjUkiopqJpn+VtBxfRG1bNNKk96R14ZsIwlMrFWseTAA+hRYn8ANPkq6rJ9UZr5nZLJbWJi4LFJkqs49IJQdcSFJZm9O4p7DNooQ+a3KOlp5UpEbfHOaIvyRY7WwgGEa6pwelh7zmlIs77EqAfe954w7IxFYtpMD/aDAw8vmMrtICDxPzOQ6YDld5WjpcbdvlZ0Esv3iSnB+H/nxifNbwmlP2hzyL0lSDTFRlNoWMBb1j3UewaIRrZBbrLBwjA2fiQUw4KFZg52EBroe8Jd7CJNHaArk9VDmhanJjRnmHopyu2EZCdsfUDvHiOMSq9zX0/xNMVcK3Yew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnLFlYmKGR4OyUmWCi1pDbraInFwpf8zRX0kUH/8Yug=;
 b=48I20JbuhfjV2p0Oq86712Tyn2osJRWnfVxWn5Y7xzYcis1CFbddLdEp9Xjix+LnKqp2ITW4CqmZXj2VnhaZMerBac2LrWFY+rSJCWfp3LJttu1Pg078n27RShZTwtzIlbChnkqqEkhGSvl9fiL6K+PfpUCUG1S1JGjaZvmIHjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Fri, 18 Oct
 2024 15:13:52 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 15:13:52 +0000
Message-ID: <15e0a44f-e396-9f1c-4265-89086112cfc7@amd.com>
Date: Fri, 18 Oct 2024 11:13:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix the hang caused by the write reorder to
 fence_addr
Content-Language: en-US
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20241017083457.183631-1-Victor.Zhao@amd.com>
 <DM6PR12MB434046E7907D855106E4475DFA402@DM6PR12MB4340.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <DM6PR12MB434046E7907D855106E4475DFA402@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: a67aad61-d790-47bf-03c4-08dcef8779ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHg2bmdhZ2hKcExURmNnWWRRK291UW5mNlJta1hrQTFzalg2RDlWOGNNV2Nx?=
 =?utf-8?B?empNb3VIeTJuY1NNb0FKTVlOSkYrcnU2aHBWYURjUTEwNG1IbHVnc1NKbjIw?=
 =?utf-8?B?Z2cyOGV5Z3lPV1VMTVhMUW95QnpUa3FBMHBjeGtKYU1XMy9lSytDUWZjQk14?=
 =?utf-8?B?U003L2dQN0xPUXpTZ2grTXhhVHlvRHRIMVVzVTdHMjNWcnN2OGdSWUhpdmQ3?=
 =?utf-8?B?c0NaN2FaVzFaOFJMLzJWL3IwdFY4MDJDM1BBU0NsMm5EaHQ4TFpydFFsYWtX?=
 =?utf-8?B?UGRwUEJDMVN2VE5XUEYybDAycW1FaTBXN0ZLR1dZeGZveWJxY0VBeHpucjZF?=
 =?utf-8?B?Y09BM3RMLzE5eHBSTDhPUGN3Z2pJRGxKMmhhWDZQWC83ZUZkRS8zcUpEeTBw?=
 =?utf-8?B?cmxlN3lFV1NRbjcrU202amdoWCtwMGVPbWtuWVdxcWFNRmJndUtpbUlQMElQ?=
 =?utf-8?B?UkN2UStxR3IvUXdpaG0zUCswdVhlVHR6eUNvN25pUStvU0Mxc0pETjVlUnlC?=
 =?utf-8?B?R3k0QlM2ZzdHelFFU094TjdjODNwWTNLaDhDdHFmSElIc1FkVW56UkpWeEFj?=
 =?utf-8?B?dFRBUmNHYWdWK0w2R3dQUW9UT0ZUZnFHUnVWY0gvaysrTmZYN2NLZmhIcEls?=
 =?utf-8?B?akNJTTJwcFpEMjQzdmhzVXlaVksvQzczbjY1bE1Mdkd4MVY0VnU2Z2wzcThC?=
 =?utf-8?B?L3BEa0NoeFE0aWZXQXV4RmlGUkhnTzBDYjl2dmlRQVI0Ujg0dklibGxZWlQr?=
 =?utf-8?B?czdOZER3OWlILzZlNE05bEhIZzNIUFFLMlhJeVp1SE1XdVpRYmVHVkRvb0o0?=
 =?utf-8?B?NzJMVVJXOVoydzZpY3Q2dHVSUFN3NVZoSVRST2RabE8rblExRk9YQnIvajhE?=
 =?utf-8?B?VmV1UHh3NlZyZDJUYW5JVWNaT3FHcmZaTFBERU9YUittMFZQRjFSNEZDZER4?=
 =?utf-8?B?Zzd6WHM5WUtFVU4yM2ZpdllCV2Rob09ndkFPQXRlVjRBTzcxMXFRNTQ0Vko5?=
 =?utf-8?B?Y1RVWWFGNUVpcGNldWxxcHJKdTJ2MXRteHpTMm9WTzBHSVhoRW9RbUNLWGwy?=
 =?utf-8?B?bDBudGMzeE0wVzJRUjRtOGJwZkZpdDR6L3BWZC9qbEtMQm1jSHdUaE1EVXlU?=
 =?utf-8?B?Ny84NnJJZmRTdnlqdDZrQWdLbEg5NzhtRWFBZWlkS0VUd1VtQzdPWm1hbHpz?=
 =?utf-8?B?Sld3Q3lvUGhiQ0diVXdqak45RkU4Q3pKUnN5U1MrMlRiNmY1d1dOSy9oeVBS?=
 =?utf-8?B?UjM2R2lzMURHci9ncFhVMUdYdGloR3pIODRVWGpieVFNTDVTNGRtTnplN0Ny?=
 =?utf-8?B?azZGN1hnQjMxOU41amlrL3AvQXFjMWRPVStGN0grMnBrWks5SU9tamwxRzdU?=
 =?utf-8?B?TllZY2l2MUVCSmdNVEdQN1VNZjJCWGxmWVlBVmNya2Rjc1pqeUg4RWtVa1k5?=
 =?utf-8?B?amRqYXpta1NQSXlDWG42eVNidkZieVJjUzZjdFJXcHpvaW51MTB3K1NKeGtj?=
 =?utf-8?B?dHdhRmhjdWxaK25xV1U5NFRTcEdhRzdHOVdRbUtxOWlxc2pHQ1c1USs0b0Fx?=
 =?utf-8?B?NkpxaCtWZ1krOTYwMko0R2RDWTRRTWFJVFhtYTY4ekJLRGwrdDd4MTg4M3Yv?=
 =?utf-8?B?MU1tNC9GaVFnQ0p0SCtXVndnUHRxZWdxL1NhKzl5dmY0cVZrL3FBakhzOW9L?=
 =?utf-8?B?bHJrZjRML25kWXBXbXlzUjJqeFdYRXZMZVREZHlnUUcrVTE2Nk5WZm1wOGd2?=
 =?utf-8?Q?07M8nI8gNaX5Q41dMA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWtEdE1kNzNzK1ZPdVdxdEZQdXBtZXdHZjAyazRQRFcralpseEVrNUpmSTl4?=
 =?utf-8?B?UTQ0d3RrL0R5UXc3ZWZ0cVdTbjc5VDg5RzFVbjMrRjZoUjdrVWFCeVJ4dlRs?=
 =?utf-8?B?dSszbmpWTGViamNJcEh5SWI1YXBMZ3JtR3VSZ0duM0NQT3RnaWx5Z1o5dzha?=
 =?utf-8?B?a2UybVRaU3dIWWpoTDFyY21nbnpyNHNwelJXM3JBODF0b1habDdFZzlES3lt?=
 =?utf-8?B?ZUhvaTM2dUxPZWozMU5YQTRSampTZ1oveDNUeHBNUlNmOGl2Sll3TEhFTVR4?=
 =?utf-8?B?MjA0QkRjalZweE5Fb1dOSFVuZXFwMVBmOVFpWGg5a3UyM3IzN3oyQ0ZQeXhY?=
 =?utf-8?B?ekVlWXY5bjJiTG03VHRzV2F5SVUrZklzSnR2eFc4ZEs2ZTdSckcxRWhkMTI2?=
 =?utf-8?B?d3hUc29IMVgyUFdBTkVVbjJ5R20weEsxakhFazlMckVtakhYTFNEaXpTOTUw?=
 =?utf-8?B?U243a0h0QUF1MnUxckpzVWdUeFNnKzNseWFRYTJWTDZYK1pEdzFkaXVDUEJK?=
 =?utf-8?B?YXBoZXlZZWVtbEhsZG9YYkFlcnI5UFhNR25BQkFXK284Ylc1dDJneU5qdlNo?=
 =?utf-8?B?aGpPV1NVeTdQMEk3dWFITzN5RmhMWFpqNXF4OS9zeU5IenAybUJ1c2I4bWVG?=
 =?utf-8?B?RDEySFFYNjNBZTVFd21uVGttRlNPaDdxS0tpcDlHS0UyWk5mQitxeXk1Q2xE?=
 =?utf-8?B?b3JMQWVhb1dJMzJTQkRXdndFUlpnT1hDNEw3U3NTQTdnOTdkeVdIQmlSUVdi?=
 =?utf-8?B?WHlkU3llRyt2MXg4NkVYNS9XRldVTGlvQWJEa2RzdGQ3L3UvbndXYU5MaUFz?=
 =?utf-8?B?WXd0ZFU0OERHMTVoVWV2ODQvZzREUkpNelZ1amhXWmNXUHZKMjIzUHJWMWU2?=
 =?utf-8?B?V25qVzZyVUFJUFRKbEU5M0REUlQzZUFCZWRTMkdPejNLWDhDQ1EvYXYvN3pG?=
 =?utf-8?B?ZjRWbjhMT3NmRzlPUm9abitLOUt1a0FoK3lKT0Y2eTFUQ1B4ZnR1MVlxUHlv?=
 =?utf-8?B?Yzg2TlNoRy84ZUpyYzNrOWFDKzdtQXhIWGh6UkhXdXdQdTVIN0VyNjZTeGxn?=
 =?utf-8?B?TVVYdEZNOVJoMitQcTl5YnErOHIyWHNEYWFqZ044QkdHbFJubHBEKzVtcGl6?=
 =?utf-8?B?dWsvcENDY2ZzREgyT3k2SDc4LzdwVnkwM09BcjJVUlFUaTZvUzdTYlR3NFhY?=
 =?utf-8?B?aGdjMjdJTmxKZjhOc0JmUjU3TGk0a3M3N1I5MnB2SGhPOFd1SUVhMUF3cXA5?=
 =?utf-8?B?c1cxYi9FM3g0bWp2Q21rT0s1dFEwR2duTGc4TE5MOEUxWFd2MU9EZHlaempT?=
 =?utf-8?B?MEpBRWtSYWlsRThTNFFST0czWDhWTlI2K3Mwa1FjdkdzS2RnZXM3T0ZMa3M5?=
 =?utf-8?B?a0VNUVU2amtFZHMrcHJydmhKTGdvMjNPaGxRRWdUZUc2VU4wRXVWOXQ1NEly?=
 =?utf-8?B?N3BtUW4xMXAwY2RMcGRwbWd0bXlEYW84OTlyMlJ1WEh3OUlKUEFyNUlsckRo?=
 =?utf-8?B?eTVIa05ueWxQRE5QVXY2STdOZllGQmYvMnlYRDhDYWJYc0djVmpmLzNZbmFv?=
 =?utf-8?B?ZDdDMVZaMVk0eldPcUIwZ3NlYXI0YkRiNjNKZTU3V3pKcG5Qam9lZXRiRE5Y?=
 =?utf-8?B?MzFibEM1cDNnVTJnNDhSVGovQ0ZrZDhXcEpoL2o2MW9BREV6UjZjb1JrU0pt?=
 =?utf-8?B?cllQTjdvRFVSZ1dxYU5pbjgrUmlvSE9SdGVoN0tNWko4bkZYbElOME9ocmhO?=
 =?utf-8?B?dGhMcDkxWE9EUlE5aHY1ZFlkZjgyRzhlcmtkUDNMaFBhNzJEcWViYWxseWZH?=
 =?utf-8?B?VU55NlRYeFA5cVFXZ2F0amFFSjVXSDhZSlZ2QmJ6QlhXNFN4eGFPYUVUbGRo?=
 =?utf-8?B?Q2orZjB0a3dxbktuMGpkQm05SktUZm1KT3J5Y3UrLzd3SzhVOG8xa2JsVERG?=
 =?utf-8?B?ZFc5L0dWR3dmU2xxcVE0RVh3Mk9QaEIrWkZaNXVBZ3poZmIrTVpjOWVjc0wz?=
 =?utf-8?B?UHQ5NlBzK0ZFeWQ5N3ZmSlErb0ticm9aOWdpUUduek1yL1huMk1LRnhuMFJk?=
 =?utf-8?B?amVROEFrYy93aFpuaWFvNDg0Z2pPRmJaMHYzNy9IRjZzK3l2cGZxdHczTE13?=
 =?utf-8?Q?gm+pZn0APlDGvI8BVrQgXAM7r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67aad61-d790-47bf-03c4-08dcef8779ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:13:52.7920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHHjwGyrt+xyFRV8mWXq7UBVdcDD+buwMpOfZj7zgbuObkB6ziQo2Z3rQwfhUm3j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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
    <div class="moz-cite-prefix">On 2024-10-18 01:31, Zhao, Victor
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB434046E7907D855106E4475DFA402@DM6PR12MB4340.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

Ping. Please help review.

Thanks,
Victor

-----Original Message-----
From: Victor Zhao <a class="moz-txt-link-rfc2396E" href="mailto:Victor.Zhao@amd.com">&lt;Victor.Zhao@amd.com&gt;</a>
Sent: Thursday, October 17, 2024 4:35 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Zhao, Victor <a class="moz-txt-link-rfc2396E" href="mailto:Victor.Zhao@amd.com">&lt;Victor.Zhao@amd.com&gt;</a>
Subject: [PATCH] drm/amdkfd: fix the hang caused by the write reorder to fence_addr

make sure KFD_FENCE_INIT write to fence_addr before pm_send_query_status called, to avoid qcm fence timeout caused by incorrect ordering.

Signed-off-by: Victor Zhao <a class="moz-txt-link-rfc2396E" href="mailto:Victor.Zhao@amd.com">&lt;Victor.Zhao@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:DM6PR12MB434046E7907D855106E4475DFA402@DM6PR12MB4340.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b2b16a812e73..d9264a353775 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2254,6 +2254,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
                goto out;

        *dqm-&gt;fence_addr = KFD_FENCE_INIT;
+       mb();
        pm_send_query_status(&amp;dqm-&gt;packet_mgr, dqm-&gt;fence_gpu_addr,
                                KFD_FENCE_COMPLETED);
        /* should be timed out */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 09ab36f8e8c6..bddb169bb301 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -260,7 +260,7 @@ struct device_queue_manager {
        uint16_t                vmid_pasid[VMID_NUM];
        uint64_t                pipelines_addr;
        uint64_t                fence_gpu_addr;
-       uint64_t                *fence_addr;
+       volatile uint64_t       *fence_addr;
        struct kfd_mem_obj      *fence_mem;
        bool                    active_runlist;
        int                     sched_policy;
--
2.34.1

</pre>
    </blockquote>
  </body>
</html>

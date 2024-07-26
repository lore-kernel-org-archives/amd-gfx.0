Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69666C3DA64
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 00:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA2B10E050;
	Fri, 26 Jul 2024 00:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j4KoMiNC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F77410E050
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 00:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wj5kiJBydB2vBj+uB3qfFj0oaJ4ps8Hz8+cCycNrlbzUNxZwQHAGToHeuEURELoA1ugH9Rq0gWyVSEG7x2JYFTDDpbhKiei8V79MSYnw7FiLAx2HOfEdTfWEPZMCEV9achryxA2M57QsqENUpjMMO0m5SrsUrIA/Fyw50mx32dJnJULHWiijKqoXkzHj/FDxly+X2IrLACR4xoySn4ze1StJtuILqKVf4tg1hSIJI+Vq5F9H/uX/sXLzUlIA6naU7DhFzr+oH+CclctKvVQNrrXWSKalfR5FBwtClGRaVzlfywxxSsy1uc/cp19MANXD2pzQS628xViNtFPjnsyq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSygcJh70SPF7eXyq+Vt0Oe3TgIP47Rn1JAV8Pho3hQ=;
 b=fnR10wsNkBf++Yi5ItpkVvhRGogbMnQX8WxIUjQLXGfqMHDGVhgx1CQ2/J1DQLEjWkPaJg8I8QfU6u+DZKZGAhs2yLVm/LOjQPTv3p1xzgu9ebSR7xvPakphT+tjzo3y8keGbY3z7N9wxMXu5FFyx8K7tCKIUV2b9sSZ6XNj9bg0EoM4417kJrpg96IMnvXvhnEnGv72KKRCB9Cjworm52N+J+W6nYKZ/oUiYieG3RiP6Dbb1Tl024IJSP1hdgCyX3YiJ1PO4PL62D/YuNouhW52cVvZ289TG0kiFdkDnO0avIj1AldseRuYFi8y+Up3S+w1iud1nMI9QySckmG8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSygcJh70SPF7eXyq+Vt0Oe3TgIP47Rn1JAV8Pho3hQ=;
 b=j4KoMiNCyXFTYKtQa/mWHFhfZxY5DCkXk+vZD4XEd6TUHtnjmdwhJs0596zI9ynQz2heesV1AzUeucCVvazJ7nHHeYn3TkGZPQKivcknEOWPOvPfc1Jt1hM2leDorObZua5vjZJCn6XmrNp2D8ubqYRmwa88DY+df/YtaG69xdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 26 Jul
 2024 00:57:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 00:57:05 +0000
Message-ID: <95a41b3d-9761-fcff-fdcc-3f3ce04451a4@amd.com>
Date: Thu, 25 Jul 2024 20:57:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Change kfd/svm page fault drain handling
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Philip.Yang@amd.com
References: <20240725181909.8099-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240725181909.8099-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0187.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfd059c-9f9d-49c0-1e7f-08dcad0ddde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0Q2KzNFU2xrUkxrYldJZWZMR1o4UWxaYWN0NURZTUdPT0xSNWFvSTI1emVt?=
 =?utf-8?B?KzRzakJoQW1GRWQ3UzJNa1FXMnBGMHJ2dHJlMG8zYXJ6Vmp6c2xZRTRQWUNQ?=
 =?utf-8?B?eHVETjRqNkNtNnBTVTc3cE5YdnN5OHg0OGVRTUEySTBTeUgrVTF6Ky9PT0tY?=
 =?utf-8?B?WmpvN2IrYllGWWNHZExKRzhrME8vWTdjOFd3TVVpSDlITlFqeGI5S0JjU0c3?=
 =?utf-8?B?M0NrS1dkdHdtWGN0dkZpODRhbkFCcHk1ZEkzTEFKbXIxUmw1aGJ4OVQ4ZmZ6?=
 =?utf-8?B?VENZQ1kvbnJsNko4N2VQdG10YnBrT1p6aUk4ekxyNC9MbFF6OUhiUkhCendY?=
 =?utf-8?B?WnFQTi9vUHVVa2F1TzZYKy9pclhlUFdGVWRZZHJtYmpKdmwxbG9lb3Joenl2?=
 =?utf-8?B?UnBGOGNZd3pWK04xQ09UUUZBSmtQSEpqVCtlYnd4dDA3SkJuYXQ5Y1IzdUVL?=
 =?utf-8?B?Mk1paGlDdzN6dHk3K0hTZUpsaG1nNklCTnk5b0tXaE9SMGY3YnVtYVB3OFVi?=
 =?utf-8?B?Tmd2Q2lKdkxzeXJxOURDaXVkaU85TDRVTlNSdWhwODVKZDZ1SDNtSkQ2bTla?=
 =?utf-8?B?eHptczRiQjZmem94Y0FmUXBRTGdkeTdDbkExclhXKzAxMTFDbzNNV0NNaXo0?=
 =?utf-8?B?bFRGRDhPbUFuczNsc1Q0RldXd0NERFd1ckozUGo2Y0s5UlB3cE9tTi95YUs3?=
 =?utf-8?B?dXFEV3UyaHFGd1dyRXIzcDdPM2xZZDVja3MrNlIwNlZWWi9QK1lVMC9ESU5t?=
 =?utf-8?B?eXpiYzFtUktNTVVlb1FvbmF5SE9wOUxBS0l2dXZMclZqbFBKN2JRcUd4TFJJ?=
 =?utf-8?B?ekxyM2VqRGxxNURPYzJlU0lCcVdvSjZXTFh6Q1J6cFV5N2dTYnpEUkExY095?=
 =?utf-8?B?cU8zaUJLWmR5aGNWbk40ejUwVlNnMkZERnQvb0hZdkRkMkNiMmRvSTVVZlFG?=
 =?utf-8?B?Qk9QQldmTzRMdk5ENVFtSS9VSlY3QUF1YUpmMHFDOTZ5OEYxem0vd0dnTU9u?=
 =?utf-8?B?U0NFRHlRcFBwcGIwYWdGY0l6VWpCczFpU2wyOERFUlJER25VM2Nha2p2OWFt?=
 =?utf-8?B?a2tpYkgxb0VOOU91V1V5dFNobWlGU1g0NUI0RDN2cktBdXVlZnlWVVFzVXRa?=
 =?utf-8?B?dHYvbjc2dXlGQ2NYbjR0NkdWYmlQU2JYbUxZVkZsM09DZEp1OGxPRUVMRTdO?=
 =?utf-8?B?WURjaUYzS3J6RkgxSXlhR3B6M3JoY0dNVm5GUllucEtoekZGT0dKaldNVGVR?=
 =?utf-8?B?V21naktDWGd6aEpjcVpPdExjUlRPSnJGOWxRSkJkajNrTzV0c1pNM2xmci8v?=
 =?utf-8?B?YTZ6a3FBT2l5MXp0UGNPQzNDZHN5YStMRE5BSi9KMld3QnJ2ZXoxMDU5aHZR?=
 =?utf-8?B?ZFNkSkRwclZlQmN4SkVyaTQ1SDNTUkprdU9CanFITXNtckdzRzRrZGZySUdM?=
 =?utf-8?B?SjNhbjZBTHpBVU9ibmdncTExN2R3UkFnaU1nVVp5eGovWHkyNnVwREQ3L0FP?=
 =?utf-8?B?aVBWb2t4YnkzcFBUdFVmYVh4WDgxSy90Um5xS1p5L0J2WUZRbXZJUGpVVnl2?=
 =?utf-8?B?VHB4VGViQkIrbGxUeEYyQis3RndpbDBpTDJLVXhFTFZuL2YzZnJ4SEY0RW1B?=
 =?utf-8?B?dC9VVFZlSjU2QU5FRFhNbXdUTXZXVFl6c2RGVlBsNzRKYWRyRUx4ZkFlczRj?=
 =?utf-8?B?Q1hzVm00UjRxY21iY3ZlNm56VDhacFpvd0wwbjd1ZjVBL3JoWGxjaE9VM2tp?=
 =?utf-8?B?VkV0NmxzTVJOUnZLQnEzTUJLbzRJdDRLNWc1K2ZrbThFLzV6Q29YSG1COFBG?=
 =?utf-8?B?VVhFOXphZGM3bks0Umh2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHp5dnVtWXg2ZnR4V0diUlRtYWVsbGtGOXJWZGc2bWYxaWhMd1l1Rjg5ZkFk?=
 =?utf-8?B?eXNyWmR5YTFVUTRRWXFRM0tuekJiS0dqazdTMEZNUWxtMEF1Q2J4ZUU3cGVC?=
 =?utf-8?B?U1JRVFBHRjJiUlFHSnJCV0drYWJweG5PekwvZXpEVTc1R2owa2dmeERFMjV0?=
 =?utf-8?B?L21KbzFtdzZBU005Wm82dDNNNGxZQ1ZjcFN0NGtaRWJNWm83aFdjVWhUR1B0?=
 =?utf-8?B?cFRzcHBQbHRtSzgrU1FGdTNVaE5FRHo3WFR2Smk3ZElZVENZVWJCK2VMMEsr?=
 =?utf-8?B?NEJRc0RYSXkrZnNtbko1ejdwdGpZSzlHZGpqOUVadUxyZmFwSXl4Nnp4djFt?=
 =?utf-8?B?OVhwTld5eHFlTzRxbzZqVGxiN0dtVVJxVGJVTDRCclpmcjMxTTZDK1VCbHRH?=
 =?utf-8?B?WENPVFcreVFQUFZUUU9uM2d0djhWTS81eUFwc2VnSUFuT3BCZGdyY0VMYXZV?=
 =?utf-8?B?dnA2RHBYWElQWFZvNXUyQWNob3RBTWpjYmpMNnFmaVhzcTIzbThrYmlacFhP?=
 =?utf-8?B?bEx6bGlKMGVTNmltaUZjMUMyTERqMUZ0N3dQamVnSGFMZXgzZ1NrWWcvTmZa?=
 =?utf-8?B?WE1aOXlOQytrR0J6Z0g1Vm9rVmljUE1hdmVIUWVPSHlmMkkxMW4vVHJPMm13?=
 =?utf-8?B?YWNqaURCQTd2djJkUzgyQ1JPaWMwT3ZzdDk0dFFIVkk2bFVrVk9DYkpQMTdx?=
 =?utf-8?B?cmw4TEJvUTVTb2pkaWREK1hMaVVvRHM5R2h0Tzh5aG5zSWtDM2kwcVpOcFNm?=
 =?utf-8?B?bS9ZUFpmUVR3SStzdUFhMmw4SEdiZEdiTW5OQjlyeTlHNUljQVJYaUFSWEtX?=
 =?utf-8?B?bW4yc0hoQzBSMmpkUVN6WCswMUc4MGRRcHlybmFENy85M1ZsR1lScHIrL3g2?=
 =?utf-8?B?ZFFoLzRBMFZpYnVPVVF6b1RKM0Q4dUlINTlueDBwTnBoY2FWanVXTC9vVnV5?=
 =?utf-8?B?QThYU1EvOGNvRlRhUjBtU1AxUXlSbW5GOEt1Q0ZGL2pmRm93QlAwMUhaUE40?=
 =?utf-8?B?MUV6UDNxYmNCSTdhWk5qQ0w1VkE3WW9HMmV6NUlucGJvUUR5dHJ6K0krTW5M?=
 =?utf-8?B?T2JZYTN3akw5OHZDb24wVHVUbkxxdXZCeXUzR2FqV0pQeVhwUHd5SDhpSTRK?=
 =?utf-8?B?OG41QmZOTzZiWGQ5UDQ5b2M4Y1J6NG4zR3NmZGphdDNqOGh6Tk9GdFQySWo2?=
 =?utf-8?B?N3lDUWgxTFNXeGhraXZpSFZ0R3dYVTEzd2dEWEdRdG5MSXBWZndxeW1TVUxF?=
 =?utf-8?B?MU16bWhqZ210dk9JZXlZNURueVVkVURVZm9Ydmw5MCs0UFhsNm9lbHZQc3hH?=
 =?utf-8?B?bUhacEhmdGdQejBTaFRacmV0Z0RxckkvU1lHbzQ5VVV4RXN4SXFZMElrZVlq?=
 =?utf-8?B?VDFVb0RZZStTZXN2YkZVQll3K0l4NEd0Q01TMUNHM3ZDaWR1MlIwcjEwc29M?=
 =?utf-8?B?ZTFxczFQdXVaLzFwaTRsS3JXOFJIcDNLVXBjYVo5U09xNHVlemwvV0NjZml6?=
 =?utf-8?B?dHEyZ0hML202UU1NeGRFcFhYc1E1bVdRZlZWUStXeml1VjNDRFZJQU9hYU5Q?=
 =?utf-8?B?NUlNUjUyU2dGMDVZOGI3Q2s2ODFmSVdqak1IVzFsNmlpMTE0RHk4ZDBCekFl?=
 =?utf-8?B?MlMwV0R1VXV1ZXRzYzFHMStpUzdSNXcySnRHTFUzUEk1NnJRc1VGMzZYNjBC?=
 =?utf-8?B?WWExWVlWeGJ6TXZHaGhybFBLcG9tam52M2ZFQ0xVb1ZPS3RIVFlOZTJNb0F3?=
 =?utf-8?B?QzU1ZThWbE5rWXRyZDBNazVpM2FOODkyYWhONXB3UnloQWFEdHlxT250TEd2?=
 =?utf-8?B?eFd5VndmKzhTSjdIcGhsYzVabCtZRlJya1lBeEZRQm5oMTdkZTkrdXVRVVhx?=
 =?utf-8?B?S3hpenBtT2xUNDFjWC93Smcra1JHRW5OemRiS1NxdXNzUHB3SmN1amRyQkdx?=
 =?utf-8?B?dVplQ25oaDg5TVoyUjMxWUk2SWJaUUVmb0hMSXlrWkMvUFowckp5R2padWR5?=
 =?utf-8?B?bElIOUg5cno5K0Z2dzFVbSs0dG1HMFIxaWM1MXI1cjg1Qmk2czhxUkJOM2hk?=
 =?utf-8?B?YWFqNDMyUDhXamJBNjJ5eDRDaDE1SVJFdHRrQzc5d1lPeEh2aSt1UXVCRDl4?=
 =?utf-8?Q?DMsU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfd059c-9f9d-49c0-1e7f-08dcad0ddde9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 00:57:04.9933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvGr55hoER77dgY8Vamk6teI5UQiPPINe5HfGX4NE2jQTMpm7iOUfZdAxLNihdc+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
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
    <div class="moz-cite-prefix">On 2024-07-25 14:19, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240725181909.8099-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
not handle any incoming pages fault of this process until a deferred work item
got executed by default system wq. The time period of &quot;not handle page fault&quot;
can be long and is unpredicable. That is advese to kfd performance on page
faults recovery.

This patch uses time stamp of incoming page page to decide to drop or handle
page fault. When app unmap vm ranges kfd records each gpu device's ih ring
current time stamp. These time stamps are used at kfd page fault recovery
routine.

Any page fault happens on unmapped ranges after unmap events is app bug that
accesses vm range after unmap. It is not driver work to cover that.

By using time stamp of page fault do not need drain page faults at deferred
work. So, the time period that kfd does not handle page faults is reduced
and can be controlled.

Signed-off-by: Xiaogang.Chen <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 102 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
 7 files changed, 79 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3abfa66d72a2..d90b7ea3f020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2763,7 +2763,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault)
 {
 	bool is_compute_context = false;
@@ -2789,7 +2789,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context &amp;&amp; !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, write_fault)) {
+	    node_id, addr, ts, write_fault)) {
 		amdgpu_bo_unref(&amp;root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 312a408b80d3..1d6a1381ede9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -548,7 +548,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
 void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d933e19e0cf5..3596cc2ee7e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, 0, 0, addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, 0, 0, addr,
+					   entry-&gt;timestamp, write_fault))
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 350f6b6676f1..ac08d9424feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -595,7 +595,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			cam_index = entry-&gt;src_data[2] &amp; 0x3ff;
 
 			ret = amdgpu_vm_handle_fault(adev, entry-&gt;pasid, entry-&gt;vmid, node_id,
-						     addr, write_fault);
+						     addr, entry-&gt;timestamp, write_fault);
 			WDOORBELL32(adev-&gt;irq.retry_cam_doorbell_index, cam_index);
 			if (ret)
 				return 1;
@@ -618,7 +618,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			 * tables
 			 */
 			if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, entry-&gt;vmid, node_id,
-						   addr, write_fault))
+						   addr, entry-&gt;timestamp, write_fault))
 				return 1;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c51e908f6f19..771c98e104ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -850,10 +850,13 @@ struct svm_range_list {
 	struct list_head                criu_svm_metadata_list;
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
-	atomic_t			drain_pagefaults;
+	/* stop page fault recovery for this process */
+	atomic_t			stop_pf_recovery;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+	/* check point ts decides if page fault recovery need be dropped */
+	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..fb0e883868b4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2263,16 +2263,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p;
-	int drain;
 	uint32_t i;
 
 	p = container_of(svms, struct kfd_process, svms);
 
-restart:
-	drain = atomic_read(&amp;svms-&gt;drain_pagefaults);
-	if (!drain)
-		return;
-
 	for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
 		pdd = p-&gt;pdds[i];
 		if (!pdd)
@@ -2292,8 +2286,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;, i, svms);
 	}
-	if (atomic_cmpxchg(&amp;svms-&gt;drain_pagefaults, drain, 0) != drain)
-		goto restart;
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2315,17 +2307,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			 prange-&gt;start, prange-&gt;last, prange-&gt;work_item.op);
 
 		mm = prange-&gt;work_item.mm;
-retry:
-		mmap_write_lock(mm);
 
-		/* Checking for the need to drain retry faults must be inside
-		 * mmap write lock to serialize with munmap notifiers.
-		 */
-		if (unlikely(atomic_read(&amp;svms-&gt;drain_pagefaults))) {
-			mmap_write_unlock(mm);
-			svm_range_drain_retry_fault(svms);
-			goto retry;
-		}
+		mmap_write_lock(mm);
 
 		/* Remove from deferred_list must be inside mmap write lock, for
 		 * two race cases:
@@ -2446,6 +2429,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
+	uint32_t i;
 
 	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
@@ -2455,11 +2439,37 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n&quot;, svms,
 		 prange, prange-&gt;start, prange-&gt;last, start, last);
 
-	/* Make sure pending page faults are drained in the deferred worker
-	 * before the range is freed to avoid straggler interrupts on
-	 * unmapped memory causing &quot;phantom faults&quot;.
+	/* calculate time stamps that are used to decide which page faults need be
+	 * dropped or handled before unmap pages from gpu vm
 	 */
-	atomic_inc(&amp;svms-&gt;drain_pagefaults);
+	for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_device *adev;
+		struct amdgpu_ih_ring *ih;
+		uint32_t checkpoint_wptr;
+
+		pdd = p-&gt;pdds[i];
+		if (!pdd)
+			continue;
+
+		adev = pdd-&gt;dev-&gt;adev;
+
+		/* check if adev-&gt;irq.ih1 is not empty */</pre>
    </blockquote>
    /* Check and drain ih1 ring if cam not available */<br>
    <blockquote type="cite" cite="mid:20240725181909.8099-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		ih = &amp;adev-&gt;irq.ih1;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih-&gt;rptr != checkpoint_wptr) {
+			WRITE_ONCE(svms-&gt;checkpoint_ts[i], checkpoint_wptr);</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">			WRITE_ONCE(svms-&gt;checkpoint_ts[i], 
				amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);</pre>
    <blockquote type="cite" cite="mid:20240725181909.8099-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			continue;
+		}
+
+		/* check if dev-&gt;irq.ih_soft is not empty */
+		ih = &amp;adev-&gt;irq.ih_soft;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih-&gt;rptr != checkpoint_wptr) {
+			WRITE_ONCE(svms-&gt;checkpoint_ts[i], checkpoint_wptr);</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">			WRITE_ONCE(svms-&gt;checkpoint_ts[i], 
				amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);</pre>
    <blockquote type="cite" cite="mid:20240725181909.8099-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			continue;
+		}
+	}
 
 	unmap_parent = start &lt;= prange-&gt;start &amp;&amp; last &gt;= prange-&gt;last;
 
@@ -2900,7 +2910,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, bool write_fault)
+			uint64_t addr, uint64_t ts, bool write_fault)
 {
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
@@ -2910,7 +2920,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	ktime_t timestamp = ktime_get_boottime();
 	struct kfd_node *node;
 	int32_t best_loc;
-	int32_t gpuidx = MAX_GPU_INSTANCE;
+	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -2930,12 +2940,39 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	pr_debug(&quot;restoring svms 0x%p fault address 0x%llx\n&quot;, svms, addr);
 
-	if (atomic_read(&amp;svms-&gt;drain_pagefaults)) {
-		pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
+	/* kfd page fault recovery is disabled */
+	if (atomic_read(&amp;svms-&gt;stop_pf_recovery)) {
+		pr_debug(&quot;page fault handing disabled, drop fault 0x%llx\n&quot;, addr);
 		r = 0;
 		goto out;
 	}
 
+	node = kfd_node_by_irq_ids(adev, node_id, vmid);
+	if (!node) {
+		pr_debug(&quot;kfd node does not exist node_id: %d, vmid: %d\n&quot;, node_id,
+			 vmid);
+		r = -EFAULT;
+		goto out;
+	}
+
+	if (kfd_process_gpuid_from_node(p, node, &amp;gpuid, &amp;gpuidx)) {
+		pr_debug(&quot;failed to get gpuid/gpuidex for node_id: %d \n&quot;, node_id);
+		r = -EFAULT;
+		goto out;
+	}
+
+	/* check if this page fault time stamp is before svms-&gt;checkpoint_ts */
+	if (READ_ONCE(svms-&gt;checkpoint_ts[gpuidx]) != 0 &amp;&amp;
+		      amdgpu_ih_ts_after(ts,  READ_ONCE(svms-&gt;checkpoint_ts[gpuidx]))) {
+		pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
+		r = 0;
+		goto out;
+	} else
+		/* ts is after svms-&gt;checkpoint_ts now, reset svms-&gt;checkpoint_ts
+		 * to zero to avoid following ts wrap around give wrong comparing
+		 */
+		WRITE_ONCE(svms-&gt;checkpoint_ts[gpuidx], 0);
+
 	if (!p-&gt;xnack_enabled) {
 		pr_debug(&quot;XNACK not enabled for pasid 0x%x\n&quot;, pasid);
 		r = -EFAULT;
@@ -2952,13 +2989,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	node = kfd_node_by_irq_ids(adev, node_id, vmid);
-	if (!node) {
-		pr_debug(&quot;kfd node does not exist node_id: %d, vmid: %d\n&quot;, node_id,
-			 vmid);
-		r = -EFAULT;
-		goto out;
-	}
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&amp;svms-&gt;lock);
@@ -3173,9 +3203,11 @@ void svm_range_list_fini(struct kfd_process *p)
 	/*
 	 * Ensure no retry fault comes in afterwards, as page fault handler will
 	 * not find kfd process and take mm lock to recover fault.
+	 * stop kfd page fault handing, then wait pending page faults got drained
 	 */
-	atomic_inc(&amp;p-&gt;svms.drain_pagefaults);
+	atomic_set(&amp;p-&gt;svms.stop_pf_recovery, 1);
 	svm_range_drain_retry_fault(&amp;p-&gt;svms);
+	atomic_set(&amp;p-&gt;svms.stop_pf_recovery, 0);</pre>
    </blockquote>
    <p>This is called from kfd_process_wq_release to cleanup outstanding
      svm ranges after process exit, kfd process is already removed from
      hash table and restore_pages will not find process from fault
      pasid and will drop the retry fault anyway. So we don't need drain
      retry fault here, then function svm_range_drain_retry_fault and
      flag svms.stop_pf_recovery can be removed too.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240725181909.8099-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 	list_for_each_entry_safe(prange, next, &amp;p-&gt;svms.list, list) {
 		svm_range_unlink(prange);
@@ -3197,7 +3229,7 @@ int svm_range_list_init(struct kfd_process *p)
 	mutex_init(&amp;svms-&gt;lock);
 	INIT_LIST_HEAD(&amp;svms-&gt;list);
 	atomic_set(&amp;svms-&gt;evicted_ranges, 0);
-	atomic_set(&amp;svms-&gt;drain_pagefaults, 0);
+	atomic_set(&amp;svms-&gt;stop_pf_recovery, 0);
 	INIT_DELAYED_WORK(&amp;svms-&gt;restore_work, svm_range_restore_work);
 	INIT_WORK(&amp;svms-&gt;deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&amp;svms-&gt;deferred_range_list);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 70c1776611c4..5f447c3642cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -173,7 +173,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			    uint32_t vmid, uint32_t node_id, uint64_t addr,
+			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
</pre>
    </blockquote>
  </body>
</html>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9925FC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 14:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1915910E0DE;
	Thu, 22 Aug 2024 14:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u3ISZplo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB97710E0DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 14:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quUguaXfgdXFTM28poPL/qkmvzeACvGCrYl5oArPzaGichqQQqAuagJP3t+XZBVPglP20FQ71v7RL2UoO1mQ38At9HXbUX7AlLRKfKE37PK6VqOVS7x7tYKGMJvEuovGe5lXE5tqRFydOeozhcz8KHY7FCYKF8B73ZLPXeKnXPHBlpHIZIX5OuB4e9T5fkAvARASepDfeBXjyCfj5GfqmQBfaKK0AZn6rKMbvLLJQJVyEZWKFEORYWOmav5It80DGxsWwK9WQLyT3K7u920gTWncWPlinXE1f84BKwLaTnCPD71tz4SxRayoXFq6mCr/AhShe8ZtAVkRtmCXqZScFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba2QrkJfNpGjj0C/dfVLq8UDjp2jASPPzTmM8vV32jo=;
 b=u5FujzjBSG74//iepxWRN4n6Ue+cNPCsU0JmfYYG7c/7VOfkNs/UdyEHeIGfkCxRVh94GMZf+alU2y2Ce/FdWAkEZYK60ryaOp3cy5riuyJQUpdhvvD+wz10K/jkj6N2mfZkN04Y6TfkhS2YSdN2MIJr7BqvoCW/0ysBnX6oAOl3UDo373Qqpz59WW1ouC7lU6TX/VKsu2WHvei+9qw7ONQ/lfhmyMlQYngqwKKhPwx4chNRXvQ/Wuf2sdXe28Z62zfydp13cnlvKt3EvlKb6bNq6zKYwVBDzHjxGn5E5JhnwAtBvhfvseGvg9FDM2qxBQ3Z86EqEWkirIOol6tq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba2QrkJfNpGjj0C/dfVLq8UDjp2jASPPzTmM8vV32jo=;
 b=u3ISZploe1jvDs8cISX6xY+WPrkxIPsG7B69FvClwsa4U03QgxBe3LE93j/SD3QD4Z3Lht4ftf6tBibUSnSZLnQ8teZzMCfeKgWIGwYM6IXtsG4vwtkwVhSNlgjSsUtF+Dw/SznqysGATfcjT09Z5RrKqgrBk1rHlFZ2hPc7h54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Thu, 22 Aug
 2024 14:27:59 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 14:27:59 +0000
Message-ID: <b822a10f-afe7-2422-8a4d-f02e1f003eef@amd.com>
Date: Thu, 22 Aug 2024 10:27:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Surface svm_attr_gobm, a RW module parameter
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240821232252.230791-1-Ramesh.Errabolu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240821232252.230791-1-Ramesh.Errabolu@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: c0364424-2bda-4c16-557c-08dcc2b69f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eS91bHhCVUd4T2s1NlByK1J6NHhWN2d6K2FZWWZTVS9LZkRCdGptcDJ4cUsv?=
 =?utf-8?B?ejlHdzU4blRnMU9TellSbnI3WjVWNEpxY3RSZDloa2QvSUZwa2ZJcjgyN2FS?=
 =?utf-8?B?RnVRL3NCQVZHdTBxbUl1V3cvL04wNWJucWJQbGpxSTZzQjZxbjRwZUY0cUNX?=
 =?utf-8?B?a2tpeTMwWUdBLy9yRWt6ZjFMWDhwV2FzUVlwZEhvdDAxWkE1U3E4dmVxYVZP?=
 =?utf-8?B?Q3hITjBhamI3NXlaejJRd0J3bU1wZ0FtL3BrYUN2K2lhOFp6ZzZBM2ttT3FZ?=
 =?utf-8?B?OFBsT2c0YksyVDNCUXJ6RXdIMTVDUEwwY01xZkEyZk8wRUtsUkpybWhMTEdv?=
 =?utf-8?B?ZzlXcXE2cWozRmFuYlVYQzFXRnZpU01NdjF4UmhtcGEyY01RL2IyM2pyYWRo?=
 =?utf-8?B?MytFcWxnb0wrUVNtTFIxQVl2cFVnSXhPNWF5elhNNTZKUnVYRDkzdTY3VklY?=
 =?utf-8?B?RFpZVDRNM1A4Z01UQldJc3ZhQWF0NnNSbWRRdWE0L1RuMnRPS2x6bHJaWjZW?=
 =?utf-8?B?bUVGbXJONFozc2ZVYmszYUNDbkdBRy92VVZ4cXBjZ2thSEZzUXRkaFNKY1Jx?=
 =?utf-8?B?YUloUHBJUmtNYTVUM0tZSThSbDNaUXQ2Rk9mTDZiNWlWWG15S2R5SVJRTXVu?=
 =?utf-8?B?M2lnYUtObnJyMUg5a01VdnNZdkZPTGUwaGJ6aW56UmRIamJZOGF2TkkwMDdM?=
 =?utf-8?B?bGJzZXBIa2syZUtFWFZkaXN1bXlFQ080UnBJQUxtdktxcUFGenU3R2JBQXFP?=
 =?utf-8?B?UWV0SG5pc0sxVmxyalZpbmxFN3VXdFZ6dmlmVTM2M1NqY1F2ZlUrbzNuT1JG?=
 =?utf-8?B?b2xXa2RBQXovT2JEdXF0RTJwUG5sZFNKRVJnNzFVSXhiNzJsc2RSeW80dDM4?=
 =?utf-8?B?ZkttclNXTldHYkgxYXdSeFdwQmdwekVsRmN0RTRhUFhjU1g1Zy9oQUVTcFRj?=
 =?utf-8?B?M0x4Tlp2L2dvajJ0alhGK25ud2t2eUdpRzk2SDk4WG9xa2pXTVlOS3FrNVNB?=
 =?utf-8?B?MkNpM2drVmgrSUhjQUExZHVyOUUxYkR6ekNXeWtVdm9Id2JZelkxSHhyYXl6?=
 =?utf-8?B?MFZ1Wi83alVpbzJyREtRcDVDeXh0R2tkZzJjbEpaMi9qSWQvZU8xYjN4bzRD?=
 =?utf-8?B?THBIaVA5VHcrVktXREEvNEs4VVp4MVdnUVRzMEg0UW5aQWxiMlVKYkJGYWEw?=
 =?utf-8?B?am9tK25CdmpOOWZwSENWQzcxTk84c0R2NHVkdDBnL0tkdUMyWDRaVVlPZklp?=
 =?utf-8?B?M1JGTHpidWRXZTRLdk9tSU5zRzJ5UE5xb3NGUEJGd2hKZ2dOaEM0QVdvRlhx?=
 =?utf-8?B?SjhWb3dmdkdJZTVoRFNPdjFLVU9mRDJDdFZSK0hhd1REdkp2V1BtdFphYU8v?=
 =?utf-8?B?d3dTUitybFlaVUxMejk5S3FKRGdmWlI1cVFVRjJNL0NyV1ZBZXQ3emQ3UGJV?=
 =?utf-8?B?ZFNpeW5WcHFhZzNPNFlqeXIxL2xxU1JsMkp6NTN4T1I2cElqVnExSjU4L0FL?=
 =?utf-8?B?bDhXU0V6dDUzczBmeWtTNWRtSkZ6QUkrdTdEdkRuQitGRVhybU5BdERZK3VX?=
 =?utf-8?B?SmR1VnJ1c3g2WVBjdEw5M1R2TkllNW1OL0QveVozVm9aZW13eml2djVvRlho?=
 =?utf-8?B?SE1zU29BdFoxeFlEdGM2QmFCSE10NlRRWWl2UXJ4T0pCbVJpWTVBYlA5cTE0?=
 =?utf-8?B?STdHOG5FZGxRMFpSQyt1aUZlUkpNeDNtSDI2UVZ6QVJ2cmdjOEw4T21DK3pN?=
 =?utf-8?B?UlEvckh5QUJqZEpyZGNBdzBUeEY3RFN1Nno0c2IxbldOR2hreUM3MFZJYkg4?=
 =?utf-8?B?cWpDZ1ZZNExXcDFwbXRDZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlAybGZCTEFyMkc5THYyenJLTjMvVExQc0pKWE9jbmRRc1lrcVQ5L1RBMDIy?=
 =?utf-8?B?SmQ4S1NIYm9LOXhURlgrQW1ZUXJjZ1pFeDRZcjEwU29tcTd2cXRpbXRrN2p0?=
 =?utf-8?B?bEpjRGVrN0hVcWFEUTUwcHMwVnlBSzlIVVJhUy9vdFZTZnF4cXNXUFFGSWtV?=
 =?utf-8?B?anJJbXJ0YjdNNFBHNHgxWnZra3VHWERycSs2SUhSK0ZYdUN2RlgvY21BRTQx?=
 =?utf-8?B?QisyT05QWHFyNGFJOUZVdGs4QzZnSkhhckJuR3BkYm1KTWVDUU8rblY0UERH?=
 =?utf-8?B?OWttU25IMEo1VlZtVXg0a0tUZHN0OEoxbTJ6clp4LzZGMHprR3NzSG4zd2py?=
 =?utf-8?B?VjdJYTZZN2c3a1pMRmJzZnNQbWwvaVBrUVpBTlFlTEpsYWxsTVIvRnJqN1l5?=
 =?utf-8?B?Qjl2eGxkT2d2NTlYYkJjT2duRVNSMUEySk9CZ0JnVytkOUw0Z280MUMrV1l4?=
 =?utf-8?B?SlFRdUlZN0pjdWFBdXVMMG1CSUlsUzRUYlFMNGI0NHVKb1daTnY2T1dMUEpQ?=
 =?utf-8?B?SVhCK3ltZWhJcVdnWlQzbGhMaStuQXA2MVJDNlI1OXhuUFJtTFhMcXhLS1cz?=
 =?utf-8?B?RHlybjdPalpBMEppVHVjRWdFWjRMeVFtM1ZEUzNjOTVsTlhzOUk4dUpDYjdz?=
 =?utf-8?B?bTJ4Znp6VWJvTFJqSkE2VFlXUlNXWkoxYXFEQnVtSUw5RXBWekVzOWgvelFa?=
 =?utf-8?B?T09FL2NJRWNMVXFYVnBRN0thNFJPd2lnbGI2RW9RZVJMMXlEanFKRXJITkts?=
 =?utf-8?B?TmlzRlJpT3RjdHdscld0K0U5SU40RC9Yd1dEdHJXeCtoeThWZzArMXJkZ1VS?=
 =?utf-8?B?bk5vUEZvSU9hUmNsZ1NqbHljZWNzQnJOTDdkQ2FpanR5T1U5OVhGRGpFaHVC?=
 =?utf-8?B?QVpCbHhrTkFXN0M3YUxWcVM2VlMxMDBBREtUc083VzFWWUM1UXNYMGtFazFO?=
 =?utf-8?B?b1RyVy9EL0RZQXd6bFcvWmkrd0NReHZaTG8wdjRqVmJ6QlByNytrSWN5WVVQ?=
 =?utf-8?B?SnlYbWNRVGdIdmVuazdxMWxFRGVqVjBPMWdFZVdJZVZ6UXVHRlBOWXhZbW1m?=
 =?utf-8?B?ZXVMaGtIMVNPNkY0bFVTdjJoa25aMm1Bb3BHam1jVW41M0NjaXpQcDlDT0ZE?=
 =?utf-8?B?M1IxZlNHSzBlczJ3SjdYaTFOS1VlYUplYmo4bEVYV0dGQllPRnF3MkgveXZP?=
 =?utf-8?B?UG5BL0E2VlBkT1o1UTdQM0ZxdHNaNHZ2dnFJMERKaUkybksyU2RhY3E2MHhM?=
 =?utf-8?B?ajR6a1NDNjFYNUxlaTlYUWNoeVlORUo0dGE4MnRxMnpLSE4wZjRxaFhmaTds?=
 =?utf-8?B?TjBNTHZUdm5rVmVwNUtCS0hOWmt5UHovMmdaYjNVWlJYWGtjRU9WbTRhSDZl?=
 =?utf-8?B?M0NWL0UxVWwycUdjZFlRWm9xdUFTc0JtK1phVHVjWkE3UlIzSXU4cWQxWDhK?=
 =?utf-8?B?c2VOMGN4MHIzVjUzNXlOdFdpOWtNNHJaTVBndFMxbnVMclV0cU9LWmovOXVE?=
 =?utf-8?B?WEdXS1lObnhySlBiSzFaUVlmWFlpVVFXcUVCanJkRGtlRlRzWW1rTjJKOS9X?=
 =?utf-8?B?aEw4Q0p4OTBYa0luVlA5ZHdWSGlydHNUT0Y4TlRLYjhHTEdrSVAwTUlaMmlr?=
 =?utf-8?B?UW9VUXg3OTlGejArRm11T2xpd0JsL3NHeVJ2SHNsbklmcEg4VUloUEVZT0Rw?=
 =?utf-8?B?M2RpR2wzb0s3ckJPYlJkLzBTM05FclhxaU1hQ2tCblFSN1c3SXkvYXhVbFlh?=
 =?utf-8?B?RHZESEhwWUxVamNvT0RRTzMvYXJ0L0NIdHh6aEZ4VmZubDZMYm5BZnRlSWpJ?=
 =?utf-8?B?dnF3a0ZvamtMYUlIL1ZaZE5QR2RoM20xMGV1cGRqb0RNQmliY29NM1pqcXpY?=
 =?utf-8?B?eGZERjM3aENsQmVvK2NmRkx3YllGVGFja1dSUmpIQmtHMjhhSUVkcUpXcGhB?=
 =?utf-8?B?czhmRFgyVUNtUitvNzBDOGp3UlpINGQxWmdac3F5emJ6QWZndWhrUFEzNlli?=
 =?utf-8?B?S0hFdTZRVndnQ3NvQ1ZCSnNHUHpIZkY2RjlSRG9CTzA5c1lseVBGMFN6Zm85?=
 =?utf-8?B?UjF2OHllYVpsbTZiMTREM3VIV1k3UXZwc0oyZzNjalliaFJSUFFrZUZRTFo0?=
 =?utf-8?Q?I2/g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0364424-2bda-4c16-557c-08dcc2b69f4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:27:59.3122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQqbHlHHi/BF5q+O+LU1+F6wqSCkgomHgU7knF1L7/y+oBoz+Uc6athYlggsPj/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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
    <div class="moz-cite-prefix">On 2024-08-21 19:22, Ramesh Errabolu
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240821232252.230791-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">KFD's design of unified memory (UM) does not allow users to
configure the size of buffer used in migrating buffer either
from Sysmem to VRAM or vice versa. </pre>
    </blockquote>
    <p>This is not true, app can change range granularity attribute, to
      configure the buffer migration size. This module parameter is used
      to config the default range granularity.<br>
    </p>
    <blockquote type="cite" cite="mid:20240821232252.230791-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">This patch remedies this
gap, albeit at a coarse level, for workloads that deal with
unregistered memory

Signed-off-by: Ramesh Errabolu <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 29 +++++++++++++++++--------
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e8c284aea1f2..73dd816b01f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -237,6 +237,7 @@ extern int sched_policy;
 extern bool debug_evictions;
 extern bool no_system_mem_limit;
 extern int halt_if_hws_hang;
+extern uint amdgpu_svm_attr_gobm;</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20240821232252.230791-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
 #else
 static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
 static const bool __maybe_unused debug_evictions; /* = false */
@@ -313,6 +314,9 @@ extern int amdgpu_wbrf;
 /* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
 #define AMDGPU_SWCTF_EXTRA_DELAY		50
 
+/* Default size of buffer to use in migrating buffer */
+#define AMDGPU_SVM_ATTR_GOBM	    9
+
 struct amdgpu_xcp_mgr;
 struct amdgpu_device;
 struct amdgpu_irq_src;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9529948f2b2..e195e1cf0f28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -169,6 +169,15 @@ uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
+
+/* Specifies the default size of buffer to use in
+ * migrating buffer from Sysmem to VRAM and vice
+ * versa
+ *
+ * Defined as log2(sizeof(buffer)/PAGE_SIZE)
+ */
+uint amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;</pre>
    </blockquote>
    <p>/* add explanation, GOBM : granularity of buffer migration<br>
    </p>
    <p>Use u8 type, the same type used in prange-&gt;granularity</p>
    <p>u8 amdgpu_svm_default_gobm = AMDGPU_SVM_DEFAULT_GOBM
    </p>
    <blockquote type="cite" cite="mid:20240821232252.230791-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
 /*
  * OverDrive(bit 14) disabled by default
  * GFX DCS(bit 19) disabled by default
@@ -320,6 +329,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
 MODULE_PARM_DESC(msi, &quot;MSI support (1 = enable, 0 = disable, -1 = auto)&quot;);
 module_param_named(msi, amdgpu_msi, int, 0444);
 
+/**
+ * DOC: svm_attr_gobm (uint)
+ * Size of buffer to use in migrating buffer from Sysmem to VRAM and vice versa
+ */
+MODULE_PARM_DESC(svm_attr_gobm, &quot;Defined as log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB&quot;);
+module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, uint, 0644);
+
 /**
  * DOC: lockup_timeout (string)
  * Set GPU scheduler timeout value in ms.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7bba6bed2f48..07b202ab008a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -866,6 +866,18 @@ struct svm_range_list {
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+
+	/* Indicates the default size to use in migrating
+	 * buffers of a process from Sysmem to VRAM and vice
+	 * versa. The max legal value cannot be greater than
+	 * 0x3F
+	 *
+	 * @note: A side effect of this symbol being part of
+	 * struct svm_range_list is that it forces all buffers
+	 * of the process of unregistered kind to use the same
+	 * size in buffer migration
+	 */
+	uint8_t attr_gobm;
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 10b1a1f64198..fcfe5543a3c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -309,12 +309,11 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 }
 
 static void
-svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
-				 uint8_t *granularity, uint32_t *flags)
+svm_range_set_default_attributes(int32_t *location,
+			int32_t *prefetch_loc, uint32_t *flags)
 {
 	*location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
 	*prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
-	*granularity = 9;
 	*flags =
 		KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
 }
@@ -358,9 +357,9 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
+	prange-&gt;granularity = svms-&gt;attr_gobm;
 	svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
-					 &amp;prange-&gt;prefetch_loc,
-					 &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
+				&amp;prange-&gt;prefetch_loc, &amp;prange-&gt;flags);
 
 	pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;, svms, start, last);
 
@@ -2685,10 +2684,12 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 
 	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
 
+	/* Determine the starting and ending page of prange */
 	start_limit = max(vma-&gt;vm_start &gt;&gt; PAGE_SHIFT,
-		      (unsigned long)ALIGN_DOWN(addr, 2UL &lt;&lt; 8));
+		      (unsigned long)ALIGN_DOWN(addr, (1 &lt;&lt; p-&gt;svms.attr_gobm)));</pre>
    </blockquote>
    1UL &lt;&lt; p-&gt;svms.attr_gobm
    <blockquote type="cite" cite="mid:20240821232252.230791-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	end_limit = min(vma-&gt;vm_end &gt;&gt; PAGE_SHIFT,
-		    (unsigned long)ALIGN(addr + 1, 2UL &lt;&lt; 8));
+		    (unsigned long)ALIGN(addr + 1, (1 &lt;&lt; p-&gt;svms.attr_gobm)));</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">1UL &lt;&lt; p-&gt;svms.attr_gobm</pre>
    <blockquote type="cite" cite="mid:20240821232252.230791-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
 	/* First range that starts after the fault address */
 	node = interval_tree_iter_first(&amp;p-&gt;svms.objects, addr + 1, ULONG_MAX);
 	if (node) {
@@ -3211,6 +3212,15 @@ int svm_range_list_init(struct kfd_process *p)
 		if (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))
 			bitmap_set(svms-&gt;bitmap_supported, i, 1);
 
+	/* Bind granularity of buffer migration, either
+	 * the default size or one specified by the user
+	 */
+	svms-&gt;attr_gobm = amdgpu_svm_attr_gobm;
+	if (unlikely(amdgpu_svm_attr_gobm != AMDGPU_SVM_ATTR_GOBM))
+		svms-&gt;attr_gobm = min_t(uint32_t, amdgpu_svm_attr_gobm, 0x3F);</pre>
    </blockquote>
    <p>to simplify, remove the if check and always use this:<br>
    </p>
    <pre class="moz-quote-pre" wrap="">svms-&gt;attr_gobm = min_t(uint32_t, amdgpu_svm_attr_gobm, 0x3F);</pre>
    <p></p>
    <blockquote type="cite" cite="mid:20240821232252.230791-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	pr_debug(&quot;%s() Granularity Of Buffer Migration: %d\n&quot;,
+			__func__, svms-&gt;attr_gobm);</pre>
    </blockquote>
    <p>pr_debug can output function name if adding +pf dynamically,
      __func__ is not needed.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240821232252.230791-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
 	return 0;
 }
 
@@ -3738,8 +3748,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
 	node = interval_tree_iter_first(&amp;svms-&gt;objects, start, last);
 	if (!node) {
 		pr_debug(&quot;range attrs not found return default values\n&quot;);
-		svm_range_set_default_attributes(&amp;location, &amp;prefetch_loc,
-						 &amp;granularity, &amp;flags_and);
+		granularity = svms-&gt;attr_gobm;
+		svm_range_set_default_attributes(&amp;location,
+					&amp;prefetch_loc, &amp;flags_and);
 		flags_or = flags_and;
 		if (p-&gt;xnack_enabled)
 			bitmap_copy(bitmap_access, svms-&gt;bitmap_supported,
</pre>
    </blockquote>
  </body>
</html>

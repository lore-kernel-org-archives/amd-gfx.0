Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A919C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 14:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6E710EB0D;
	Thu, 22 Aug 2024 14:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fGLcaYLg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C40610EB0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 14:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jundN2bpf/qMuhqOIiyAgSTASmlxyqrwKH4txYCQdzOcgi/ASJoZFqN8EzAhZoOgJX+ImHUPNulAeR7nwdYpsyy+q6xPOPxbyTITWE1bYHt4INS+mY/lsC6N26V2lzxM1xm8e4E5G2KmGdWT/3OlV7nnLvp2CXc/6h9ygAUAZ8hI4gDwMOiU1WPsCdHK5zyDoUwLKytRr1CEY8oJKpyhPeYd5k6UOZBmlEgpukayNuy8HWmWel/wp38wZoQcHSg7v8dBaN5LaChdWhZ2a4hDzFkhvBIA4RvsYHOQMAXWWlJnCC75KGBFFU2qjijZ1S+sVjpsSzGLiOuIA6sTuKg8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+ma46HwHjrBp74JppWrui4vGP6j7kd/JfE9fIOyz70=;
 b=YjptPirMPK2610uAv1fTNqLNekVCi4QzJ6Fz8TgwcNDMdIPn+ff41J+BRFVDLqnSKD4zHhYKSSAB1Xby2GCGf3xvx7gxYk2qxWY1RNZ7QJlsUzGkV/H3pqqoxTHHYVXYWbcbfWbP7VXSVJDxBx2+DHuz3RT+HAVuUdxv2t7FkY+gLVYKg8UrMNwt2UMUl0WXY0ay8r4vgip2tTsH52/X90hD4wzJ+9pfqrrhRdyPFl2nR7qmaB2se0puy3toHjb8d+M84bD4Qx6B9PQ25bzs05j/hPmLDRs3haogdTn7eLuo/kcU7p+czp5mHVf6vUqA5eBrbVN7XQQ3bcenha236g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+ma46HwHjrBp74JppWrui4vGP6j7kd/JfE9fIOyz70=;
 b=fGLcaYLgy+3THPJUDZrRMf86EE5CmpZU9XBtIyex3+D6sw3qyGZv8F7bEXgaRpg13LD9EfvmAtnsAFqwnk+snF2PatYFICopbiHWWEAGHAEkELoY2IPZWpef+zsTF2ar4denvz3C6/BrVFfshkL+NT5dPIJ5bKYDmdhLI9h1a1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 14:53:48 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 14:53:48 +0000
Message-ID: <4ac84461-14f3-1f49-c2ad-1c28080a592d@amd.com>
Date: Thu, 22 Aug 2024 10:53:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6] drm/amdkfd: Change kfd/svm page fault drain handling
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com
References: <20240821220133.25975-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240821220133.25975-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 7622e775-fa92-47da-99af-08dcc2ba3a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0xNUzM0U1g2Zk1LZmd0RzlCWFhJQTdmUElXMVN4SHJWUkQ0a3VCczVoS3dV?=
 =?utf-8?B?VmJraUFhSFZuWWlSL0srcGFWWGVORklmcmpOekJSaGNKRkU0ZlRJdzRpS2tP?=
 =?utf-8?B?S25VS1BzeXFWU3pHdE1HYVJwNGVNbk1tNzBtRXRQUU9GSE1QaytpWk1sWjRL?=
 =?utf-8?B?ZmdFS2plTUFzVWdtSnNJaGo2ekhPNHl4bTJIM0xoMXA0VVJLTVFMdUhtdmFm?=
 =?utf-8?B?ZFYraHJiSVM1Q1BFM3VFc2thcW9MUGNydmduVmFzSUx0bCtTUXdLaUtxaXRG?=
 =?utf-8?B?NWZNRWEyaWJVVWVrNXFGTnBVd3JNYjZYdWtWdGxlRkF5a3gyVDMxR0cxUEdo?=
 =?utf-8?B?WUhVT1NsbnliWEQxUVVOcW1CTXZjdVZ1Q3VhUnE0REJ6cEp0UVpMS09HYjdU?=
 =?utf-8?B?Ry9XR2VLQlFURUQvdDV3alJvRUJvSjlGUWROTXBrNWROUWRRRGYzQkhPYVFl?=
 =?utf-8?B?RytXSVJzZDZjeEFxa3Y3NFM0Q3NybDlZbTVnM241cW13UjdIam50anIzNjY1?=
 =?utf-8?B?STJ4RjNvQ0dsS3B3d0FjMkUzVTFNSk53cEVwRFFkc1BZdXhaV3Zncm0yKytq?=
 =?utf-8?B?QUlBUWVvZGM0RURXellhVmMra1FOZHdYMjNOS0FmSWkvT2RXaE0xUnpabFRH?=
 =?utf-8?B?M2ZzNFMwdkFwOXlsYUtUZ3N2aE5wVGJFN3RweEZsTGs4VTBOT0habVJaREJk?=
 =?utf-8?B?eHQ0eXludXY4cGV5SzJkQWdleFFpVWw5YWtiTFVYUkJJTlFtbzBSd204WXA1?=
 =?utf-8?B?YmlQaCtKTDBUWVFTRnZMTXVBdmhDTkVmVHNveGxTVWt5Mk0rMmdXMEp0bEhZ?=
 =?utf-8?B?OU50NVlEdExsdWU1Q1NCRTQzbnc4UUsvSktodkhnUGtHa1h5ZVdsaVVLaWkx?=
 =?utf-8?B?SVVsTE42cVZ2OHpsQnlIYW02YXBpekFtR3Q5VTdIV1RJS0FxRk82L2plN0FX?=
 =?utf-8?B?bEs0ZmgvbGtDbzBSYkwrRDRNTjJaUklGb3pxdFZqekwzQUx0dXd5UzdueFI0?=
 =?utf-8?B?SS9ib2NaVktWa2dpMXJmQ1VEckc3Unh1QjlPV29jUDFrd0N2Uk1kMWVVOHhG?=
 =?utf-8?B?d2g5anlyV0IvRkwzWndLQnlXY05JM2ZMa1RpN2ZJU2p2ZGw1WWwzemVWUXdX?=
 =?utf-8?B?L1dXRzFHbWtsNTdqR1Nya05qN0VBZ1psekJrWXJVTE9JTFlpUUJSWVovdzRt?=
 =?utf-8?B?S0g3cVlYT0JSTzNwbW1NSjNBVkpFTTRvTU1YSk9lRTA2SG1hOHNhYTZQS0xk?=
 =?utf-8?B?UlJaMWRLbERxSE1kRjQ1UnlnQTBOazBBbGxzNG9VbElLanBnWDNUUVhSejV4?=
 =?utf-8?B?eFlXSGVYa0FILzZyb0J5bSsvenZ3dmJSNVZLRVBLR0JtbTBhM1hHWFhTRHZZ?=
 =?utf-8?B?VkdDcTNoRHo4ZXNBL21DdFRHYWlORDZOS3p2WHlVZzdtcWxvN3Z6bEtKdjly?=
 =?utf-8?B?dEtycG9INlNCaDQrTFFjbkRSN2FkYUkwYU1hVFRNdVhpVEFCc294Qi9GR1dF?=
 =?utf-8?B?ZzlGdGd1dVBCaEJTbVBkbC9xd3BwN3BMaktBdU1oYTQ2UDFEWEtLR3R4N2pp?=
 =?utf-8?B?R1FmTm80S2lvMWVPeHVNaExhdm5leDNEQy9oaEZZR0dFd28zTXJJV3BiSmYr?=
 =?utf-8?B?emNDS21hOE5KTGJjZlk5VHpZaHQ5NFlNQ293RFYxeWo0UkIzOE9TS0wvbDNp?=
 =?utf-8?B?ZnZwZFRQcFEzMXQ4QVhoM3BmRG1WWko4SjJRekhqQVV3NUtWZUhJMEZ3dmVO?=
 =?utf-8?B?YTAycDMrcUZva1kxaHNwOVp0cjNJSExCWXdpWjg0Q3RuV3Q2U3dCSGw2UExS?=
 =?utf-8?B?bGx0dzNYVTFXQk5nWDZtdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDlZYXlka0xwR01ZSCs5MWZyM1JuYkdhWTY1TlRoaEdNSThtWXhkZ1NkWUd3?=
 =?utf-8?B?MjdSb2Q5MEpLS0dScjNramprdFNBamtLdW9zaUtRVDdzNStlY2h2Y2VxNWx4?=
 =?utf-8?B?WG55bDJHb29DMndhd2pCNzNVQlAvZVkzUzgyMmRtMlQ1cVd3UzA4KzU0RmhQ?=
 =?utf-8?B?R1dOT0cvaGdnbFo2ZitxMzhybVdQWU9abkk1MmhTWndicm1TTnIvUVBUWkQ5?=
 =?utf-8?B?MEgwQW5GcWF6dWdoVXBnL1NqQkV5QktpK2Q0OGhnMHdjUFZZL3U3RTgyRXlN?=
 =?utf-8?B?M0M0TzNnZ2tEelhLbkNyNHc4dDFzNHA3SHFSb3FiNXhwSGhwZTRFVHhPQXJu?=
 =?utf-8?B?bjFHbUlnSDZhMmQyTTJENjFnQmFycXZ4cDQ1Y1ZDL0Z0eVBoRHZTRnJFaVZk?=
 =?utf-8?B?M28waFlsSG1ucXRzT3JBdjJXVEs1S3BKSXV3MzZuU1dvMTF2dERPWUxBdElD?=
 =?utf-8?B?bW92cGhsQk9oWVBpd1U2SmRxbjBLK1RtVmo0amNUdm1RTytmNzJkQURWdEtE?=
 =?utf-8?B?ZjRRL2k5dzlCRGVQRDg1SmtHTGdBMmI1MS9VcWZBazdGZkoza1R2dUIvcGFL?=
 =?utf-8?B?V1VRVFRkajdIak90WWt0NzYvQS9NaDdsVzBBblhNRmdxWjlOTUVtTTZwMmoy?=
 =?utf-8?B?c0JYQWtYWHJldSt4dWFPZ1pNb0IyTVVXd3lyeS9HcVliODNqYnVZOXhFL3FR?=
 =?utf-8?B?dUlYL3lNb2sxT2pvTVp3N0FVYXRZWlo1TnlabFFLSTVaUGFEVmU0ZHo4MGhn?=
 =?utf-8?B?TU9ZM0p1RHZmWW9sWEVIUWd4cEdsc3JJUlcreEd0NEZuemJXeFUyeDRpd1ps?=
 =?utf-8?B?YklVVjE5TmFCaVV6b3NtcldJT2QxYzJkSU93dS9xeHZzU0JrdkpWMjAvWC9W?=
 =?utf-8?B?RURYMXhhUkJaOEs5R3hRb251UVRNVkRkL3JBN1kwaC95YU5WVTlNdittbjhh?=
 =?utf-8?B?MDdYUmdiTHl0UWh2bE5tcEQxcjZ5djVuQzZkY0pGdStUS3N3T3ZZUEhMTEpB?=
 =?utf-8?B?MVVBTWlpTkxFNjZzYkFzaHNoZkI2TkdPWmZveEl4UmtVZWZDVkkwQUxRN2Y2?=
 =?utf-8?B?T1pYQWhxd1FFMExvYjQrY3QvWEgvWkRzMjhhQmxFUkZ1VENBL1Bnbjk1N2Zq?=
 =?utf-8?B?bUFZZnBlZUNnQU9YK1pudjR2ZjJFMzB0ejdVaFBPRW5XYVFvMU12TUdvR1pN?=
 =?utf-8?B?bWpiZmFCODVFVTEzaVdMdGdhL2wzbGUxaUMwTUlEYWRpUXRJQjNoaEhlTUE1?=
 =?utf-8?B?UVl4OEhzRkhpdzNQMHpDVlNBaXZyZWxER0JYRWRGN0JHL3E5T012UGNhVThh?=
 =?utf-8?B?Nm5Ec0crN2RENWFFMjhjdSswelJEcTlnMWZmVVhreURXbE51OG1ZandmY0RV?=
 =?utf-8?B?OGduTXkvSURtbzI1TjFIQUNEWHVKTVo0ME5qRmFKbW80ZW52SDFxRFZyMkdL?=
 =?utf-8?B?MTFLdERRVkN6WG5qUWI4dDNkcTlZRWcrU0FRN1hPNWhpRVdCVzFUQ0hiU01T?=
 =?utf-8?B?NlRxV0Y1Wk5UR2hSNmt5YnA5OWs1SHE1K1dFWitrYk5jZGhZbk5Bai93RzhV?=
 =?utf-8?B?MkN6Qzl1Um03QW9FUzdCRjNqOTlqbTJ1cmttSytSQXJZd2owd1c1MWVRT09J?=
 =?utf-8?B?MVhreDNFN3hTL2s2VWx0dW1zOVcvMHIrRDhlcGJxZjRtcnRadVRVVlV3SHZm?=
 =?utf-8?B?OENxWXBlWWYxWFRvVjloZGZRNkVpKzgzN2g2WnFpU2Z3aW8wL1paeHJSWlFy?=
 =?utf-8?B?amNKSGt1VXNiRWF3YkRaY21BdzJhd2xIQnNpV3preWNSTjVkZVZSTklXTGEx?=
 =?utf-8?B?bUs5eW9WWkZxSUhhWElnWUZjeWdYUTJhSFR1TmtmSXhreUhlOTg3am9nbG4y?=
 =?utf-8?B?ZWZBbm9aTUczTndSUXVwbHdjM0ZhQ1M4bkRNWHpnWFFXbHBJaEx6ZXFMc0h1?=
 =?utf-8?B?OXZ2Z3ZIaFVzL0c1d25NNXVUdnNsa09GUGZwZXlKQmVYOEc4VTR6K1l3NGlI?=
 =?utf-8?B?SG9xNnBDVWk4RlNnZkxxNUdxK0xsc2lrd3FsWlFwbkxvK08zUlR5MytOSDA2?=
 =?utf-8?B?S0JMMFlVZm0vaUdUZG9aR3I0RG5laFF1QUJUTmk4Uy9nSERFa1V0RjdXSnVR?=
 =?utf-8?Q?ikVM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7622e775-fa92-47da-99af-08dcc2ba3a57
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:53:47.9473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxPfbWC9+FpXRSsf8QYcB8kBf0grWQTW1In2TuLuAm6GWljCwBB3qTpwb1iRtDkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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
    <div class="moz-cite-prefix">On 2024-08-21 18:01, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240821220133.25975-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
not handle any incoming pages fault of this process until a deferred work item
got executed by default system wq. The time period of &quot;not handle page fault&quot;
can be long and is unpredicable. That is advese to kfd performance on page
faults recovery.

This patch uses time stamp of incoming page fault to decide to drop or recover
page fault. When app unmap vm ranges kfd records each gpu device's ih ring
current time stamp. These time stamps are used at kfd page fault recovery
routine.

Any page fault happened on unmapped ranges after unmap events is application
bug that accesses vm range after unmap. It is not driver work to cover that.

By using time stamp of page fault do not need drain page faults at deferred
work. So, the time period that kfd does not handle page faults is reduced
and can be controlled.

Signed-off-by: Xiaogang.Chen <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a></pre>
    </blockquote>
    Some nitpicks below.<br>
    This patch is Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20240821220133.25975-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 98 +++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |  2 +-
 7 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a060c28f0877..d89a4c14bbb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2764,7 +2764,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault)
 {
 	bool is_compute_context = false;
@@ -2790,7 +2790,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context &amp;&amp; !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, write_fault)) {
+	    node_id, addr, ts, write_fault)) {
 		amdgpu_bo_unref(&amp;root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 046949c4b695..d12d66dca8e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -558,7 +558,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
 void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f0ceab3ce5bf..9784a2892185 100644
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
index b73136d390cc..c76ac0dfe572 100644
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
index 4190fa339913..288ebf02fa1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -863,6 +863,8 @@ struct svm_range_list {
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+	/* check point ts decides if page fault recovery need be dropped */
+	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 10b1a1f64198..e30c644e44a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2256,16 +2256,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
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
@@ -2285,8 +2279,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;, i, svms);
 	}
-	if (atomic_cmpxchg(&amp;svms-&gt;drain_pagefaults, drain, 0) != drain)
-		goto restart;
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2308,17 +2300,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
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
@@ -2439,6 +2422,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
+	uint32_t i;
 
 	if (atomic_read(&amp;prange-&gt;queue_refcount)) {
 		int r;
@@ -2458,11 +2442,37 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
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
+		/* Check and drain ih1 ring if cam not available */
+		ih = &amp;adev-&gt;irq.ih1;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih-&gt;rptr != checkpoint_wptr) {
+			svms-&gt;checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+			continue;
+		}
+
+		/* check if dev-&gt;irq.ih_soft is not empty */
+		ih = &amp;adev-&gt;irq.ih_soft;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih-&gt;rptr != checkpoint_wptr) {
+			svms-&gt;checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+			continue;
+		}</pre>
    </blockquote>
    continue is not needed.<br>
    <pre class="moz-quote-pre" wrap="">if (ih-&gt;rptr != checkpoint_wptr)
	svms-&gt;checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
</pre>
    <blockquote type="cite" cite="mid:20240821220133.25975-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	}
 
 	unmap_parent = start &lt;= prange-&gt;start &amp;&amp; last &gt;= prange-&gt;last;
 
@@ -2903,7 +2913,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, bool write_fault)
+			uint64_t addr, uint64_t ts, bool write_fault)
 {
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
@@ -2913,7 +2923,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	ktime_t timestamp = ktime_get_boottime();
 	struct kfd_node *node;
 	int32_t best_loc;
-	int32_t gpuidx = MAX_GPU_INSTANCE;
+	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -2934,11 +2944,38 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	pr_debug(&quot;restoring svms 0x%p fault address 0x%llx\n&quot;, svms, addr);
 
 	if (atomic_read(&amp;svms-&gt;drain_pagefaults)) {
-		pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
+		pr_debug(&quot;page fault handling disabled, drop fault 0x%llx\n&quot;, addr);
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
+		pr_debug(&quot;failed to get gpuid/gpuidex for node_id: %d\n&quot;, node_id);
+		r = -EFAULT;
+		goto out;
+	}
+
+	/* check if this page fault time stamp is before svms-&gt;checkpoint_ts */
+	if (svms-&gt;checkpoint_ts[gpuidx] != 0) {
+		if (amdgpu_ih_ts_after(ts,  svms-&gt;checkpoint_ts[gpuidx])) {
+			pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
+			r = 0;
+			goto out;
+		} else
</pre>
    </blockquote>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
    <blockquote type="cite" cite="mid:20240821220133.25975-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			/* ts is after svms-&gt;checkpoint_ts now, reset svms-&gt;checkpoint_ts
+			 * to zero to avoid following ts wrap around give wrong comparing
+			 */
+			svms-&gt;checkpoint_ts[gpuidx] = 0;</pre>
    </blockquote>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
    <blockquote type="cite" cite="mid:20240821220133.25975-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	}
+
 	if (!p-&gt;xnack_enabled) {
 		pr_debug(&quot;XNACK not enabled for pasid 0x%x\n&quot;, pasid);
 		r = -EFAULT;
@@ -2955,13 +2992,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
@@ -3176,9 +3206,11 @@ void svm_range_list_fini(struct kfd_process *p)
 	/*
 	 * Ensure no retry fault comes in afterwards, as page fault handler will
 	 * not find kfd process and take mm lock to recover fault.
+	 * stop kfd page fault handing, then wait pending page faults got drained
 	 */
-	atomic_inc(&amp;p-&gt;svms.drain_pagefaults);
+	atomic_set(&amp;p-&gt;svms.drain_pagefaults, 1);
 	svm_range_drain_retry_fault(&amp;p-&gt;svms);
+	atomic_set(&amp;p-&gt;svms.drain_pagefaults, 0);</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">atomic_set(&amp;p-&gt;svms.drain_pagefaults, 0) is not needed, as p is freed afterwards.

Regards,
Philip
</pre>
    <blockquote type="cite" cite="mid:20240821220133.25975-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 	list_for_each_entry_safe(prange, next, &amp;p-&gt;svms.list, list) {
 		svm_range_unlink(prange);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 747325a2ea89..974bbc6b14c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -174,7 +174,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
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

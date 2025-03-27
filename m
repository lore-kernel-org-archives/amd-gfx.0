Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1456C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 09:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8A810E0F9;
	Thu, 27 Mar 2025 09:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VDAQ1irS";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EDF10E267
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 09:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXzCas0+THc4FCVBo9T1dQSUVKGQ7AcgP1poXu3T8cviEMRPUBU6X6+N0UtdbGkLtLslCF2i8Yfhw30UAAwBr+tEkp+28QITV5LihwcdBm9yOGLk7O2Jtuv21hGYug+oE2QW2FjGZSXLgieDdA8ZffBx32uGSm0MUuAj8OBpi2giwv/tnANVRQaxMe1sA5UNlG6Pze1xE+bIgFSrOrZCok6Wlp/AsHTwgYnjFLzdYOJveeo/hqMJJzO/eU6+Xbvk2xTBze/5YeR4OixNlKtMzCUztgNPZYOyo26wABSnoVpNNL4NdnhrvxxYB7urAAQjnTCNXaJV5sPqckbVrDG2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVY/7KqHACKGwL5sdU2W4wsUVWFgku6XckZEwbm/g7w=;
 b=ZOCkdk8BA+tdgYV9hJIDM/nEH1qOfx00r8oCGQpzdFmOsEbBReL9SYbrvvfBLRDfLKnpAMfnTRiBwvxDAhYcJSxuHRUNV1zf2B04eF8PwR6pGwPUdXy7pSLs9kITMhWvojOLrRR03a0gJBVWLBH1L7houqF+TYIWvQ+u0h8ITbURZMK1zo+em0vqcTTc4c9THJRfOvLPIgUEH3P2K+6tIv4N5/dlFVqtvWAprTMdYvg/PFDzBCc+l7pjCBll1bj6BrTuDjSv+YgL10EiIclfB4X8N5sQGkA9wJdYR33XE9e8o97v7O3aNVGStwbbfHiYrZ506xJEYmAN/whzu0EWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVY/7KqHACKGwL5sdU2W4wsUVWFgku6XckZEwbm/g7w=;
 b=VDAQ1irS7PwDz1YqiIUfRZ9xPSqfRD6dR4pQMxV431luHiyFZcEDTxMk++/jHuMFH2U4VYsdIj3amitnvzGsCOm9WXZCJdcwSV4Koz7TEQJbc7IfpCOy2zoRa4Gx1t+CWUFfk6B0mOOITqOgXlDwhwMCT5+SsvIJaIwSDv+QUSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 09:24:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:24:31 +0000
Content-Type: multipart/alternative;
 boundary="------------gT89kP0weIzns11Qk5BqE85o"
Message-ID: <fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com>
Date: Thu, 27 Mar 2025 10:24:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix Manual Execution of Cleaner Shader in
 Gang Submissions
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
 <b30810ba-3e16-4f52-8b4a-070bda1bc129@amd.com>
 <CADnq5_PcPDULfTjtkWGXRVpuJ3Wc770Be3QjrxkRDsw1E-VUeQ@mail.gmail.com>
 <740940f4-055b-483b-88b7-072907539167@amd.com>
Content-Language: en-US
In-Reply-To: <740940f4-055b-483b-88b7-072907539167@amd.com>
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: cd48dcdf-2813-4b83-897f-08dd6d112e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2xRYjErdlg1dEFBcWNGY3VndzhVRDNRVmM0UmI0U29BRi9sRlQweklGcEQ3?=
 =?utf-8?B?SlRkSURYSE1OVUVLNDVtdGZoVDNHdiswakoxWTJmMFJ2RWt6bENTTkpOZzFL?=
 =?utf-8?B?cW1KWVdzR21FMXl6YXRvYml3Qkdjem9VTnNOMTczMFM2ZVNKZldzeUxrbXhw?=
 =?utf-8?B?Mi9UNUhnZU1IWjJHVlhwK0tOV0lJbzU3TWpOTVluYkJHZlZFdHVFd1RXdlFJ?=
 =?utf-8?B?bWlFUGRJNmxvSVlySVNaeGZTSHJGTlMxSTFmOWhpenIzVGVEQTJDWlhhY2Vl?=
 =?utf-8?B?SHNucWhnMkFFVjlaNzB0WDVrb2lyOW14NnN1b1pjSHB0b3BxSjhYQ0R4MUIx?=
 =?utf-8?B?OWU1L2packUydWZndllJSStwcjFNUlBiZ08xMlRRYkJMZEY2RXlKTzV1M0ZY?=
 =?utf-8?B?SXpscjUwNVNuZnVNcHJFaWovSjNmU1VzNlJHaVN5aUJOTUF4SVRFTERkUG9X?=
 =?utf-8?B?YXpCOUp6UWFKNzJsUUNuRlUwVlJybEhvaXQ5S1R5SFNFOEFMdFhXNWFJK1E2?=
 =?utf-8?B?MFZDZ1dDaUxwSFZ0WXNHdkZreGhZZ3FyejUzZWdnWVFXS2Z5VDB4SWtZa2c4?=
 =?utf-8?B?Q1pCNmdSZHZVVnEvTTR4SEsrUWpPTjFRc1ZIY2E4akVmQ2JSWkd1aE5FakRL?=
 =?utf-8?B?UjB4STVyUHlha1lSTS91TmlhZ3ZjN0xCcXRDVkdmL0lxWldMZDhTZVhJUmJC?=
 =?utf-8?B?aE1vaGJyL3V4QXV4TXNuRVZxK2hLRnU3amdiNzJtL0JpUmUxT0dHYlJBYjJ5?=
 =?utf-8?B?T3duN25VVU5BOUNjb056VlB5ZFN0dWRxbW5nVUN0TVV3WDhlZEZGUmQ3cVRa?=
 =?utf-8?B?UlYyOTduUGZPVDdCbkFPV3l3MGV1Wk5acGdOTjE1RzlyVXl4d0h4UUtwY2lY?=
 =?utf-8?B?YjlLQXlqcmZQYnhqN2NqeHpUMng0T3VvOU0xK0NwcktNd1BXZ0h4V2pUVzI0?=
 =?utf-8?B?aUZmMjAxYVFxeHFoNmVpWTFLQjlNdXZMZTdqY3AxaWNTZUJSTzd1bDNQMExF?=
 =?utf-8?B?ak9BN1lFQmtxdTYvVDJnNkVoTlJQYlEzMUJ3dDlxYXhjYXo4blpWbFYyUEZa?=
 =?utf-8?B?TFNyRVhCOEFFQWszQVZadngwd1lwY0JPSDRWT1AvRWg2bW14ZmdodGlhcXNp?=
 =?utf-8?B?OFZDV1hQNDA4Z1Q2ay8vSGl3TllveHJONCtYL1RuRzNWVkRBdlNMd0NEd0tS?=
 =?utf-8?B?TGRTQVlnM1BXb3YwejRIMnVVSmpvdHg1K0lOTmtvcHlBalhRaFNPVStxelNN?=
 =?utf-8?B?SWdCV2FiUjdjTmdIdUhQaVBCQjRJbVVVY1l5V05CTFptUlVjeGVXVCsyQmZh?=
 =?utf-8?B?SzlZZHhSaDVUdTRLaG1ybytBM2N5UEFyNHN1RHhqNitHay9ZbkZjQkh2OGZi?=
 =?utf-8?B?NUJoWGUwdVBxVk5ibE1EMit2c1JsdjdndU5vbnNJTVRYeUVTY2pJQ3BEaFFr?=
 =?utf-8?B?cExkb1NiRGRCdTU3NHlvS1p0RUFBV1RrT0VHZGNsT1hyNlF2ZmFJaHRWL3NH?=
 =?utf-8?B?dzZ4TTNNSXZOUzdNZ240em9iQ1RZZVBrT0xRbi9ERlhrbnNtaUNNcC9xcUdM?=
 =?utf-8?B?SkR4eEZ1TFMydC9EYjdBdDh1eG5uQ3RNK1RRcytSNHRXcm5vZEEvTzkvVWd4?=
 =?utf-8?B?SUxwWnFIRGEydGxrL2F4Mk5ORk41R29udWVNVUphZ3laTE9FQkJPQzZwU3VG?=
 =?utf-8?B?WVFVNXV0RytBVTlhd2JYVm5RUWJHeGJRWWYxL0pjcVdVRE1NY1Y2UVVJckRS?=
 =?utf-8?B?TGZnYzBJSFRVQmZyd2dTdWh1OWRQSFVsbUx2dnhXQkhoaHpienJqb1E5dHRS?=
 =?utf-8?B?dlhGcDgwclRrcWMvUmFSUk1wQTlSRWorT1RiU0ZDMFh1YWd5T2NYUGtSZFBy?=
 =?utf-8?Q?l1Bo5YN/stbeN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRhb25EM1VqV3BIa21ZNFlCREViL1E1TytldnJIT2FFcGdKREZOWENiUnpH?=
 =?utf-8?B?NXQzMW9lSnRzbU13ekFhNWNETEYzTHNTSGRsUTJxUnRqZzZxSEdXM3pLbjBS?=
 =?utf-8?B?OWJmUEwwUlNXRE5ZTFVGNjNJb081T015eC9XdUE2TTBRY2I1UnVPWGZVOGps?=
 =?utf-8?B?aTFWdk1hRHkydy9nVW5qUTJHdHI0OHMzNlpmbTMwNjFBS0NTMmE3c0xqblBK?=
 =?utf-8?B?UU1MTXN2SGwySGJIMWhmdXJTamRFd3ZUcjdtMnc1TFl4SUZTelJTRzhRR2lH?=
 =?utf-8?B?S0hPWFRoYVZtRS9pUTU2V3lpcWxGL3ZMcWlSR0FTU1BCVE1PcVJKRy90aXRq?=
 =?utf-8?B?VkdhNW1XMG1KeHpKNUtweVo4QjVoSzJOQXo3cWtremNySUVaRzFZc2FVTGFO?=
 =?utf-8?B?ZTRnd1U2U0k0OVVmOGUyaW5PdDQzUTFsaWo3QjNnTjZIZlRySEVCY01ycFcy?=
 =?utf-8?B?dlNYMHBnZXFiRFpkS1I2dTBMSXdndEJDVkFpOVdOb3hVbjhwajQrSTBXMXRE?=
 =?utf-8?B?SGVaRHhSUUQrY0JRY0lLZzVIeUhCTytvU3hGWjhNRnJOa29tL0dWSWttSHFO?=
 =?utf-8?B?cTJoU2R2YTNSREN0cjlERTN0NVFoYnF1MkI4S2xXVHNuRHgrYWJlbStlUnR5?=
 =?utf-8?B?RWNmWHpsSWZkWGgvOUZuaHNBeVVGWTJSdW9HRHBLVU0rNFYzWkowWksxT20y?=
 =?utf-8?B?VERjRkhQVGMrR0RMOWcwMHgrMnFlZkltS0d0cUNvUHJHZ0Nva240eitFc2VR?=
 =?utf-8?B?aHlyTnRTRDBWV0IyaEo2NWhWYWMzdmNuWVM1ZWF2K2NyOTd6L1VOT2xhOWpr?=
 =?utf-8?B?bjVqN3J2ME9jakd2anZGNVBvWDFWQklzemJhRjRTQThIUUp1OFU0eUl6KzR1?=
 =?utf-8?B?Z1RwTlBwMUxNcTNYOVEvUGFZRmFIdjZINm5GZUJ0VmwrOU9GUW0xY0hyNkdr?=
 =?utf-8?B?RnkwOUVTbjBkVTNjQU44QlNPT2FUQ2puYmlEenU4aVgwUlR1L0pzRG4yYTlh?=
 =?utf-8?B?dzEyZENBN3Bma0sxc28xMkJDRDA0NElqcTZOZ0g3WlpjRlBiTGNTVE54UTZ3?=
 =?utf-8?B?NnYxck9mZkZ5VndzN09LbUUzYkJXcVV4bVFuT0V5UFFna01YUHJuRW9pU2FL?=
 =?utf-8?B?cHpIT251Ni9zY3oxMlFJTFBZTjlxbXZ5R2cvMkIzdnRxZUwrSWNxemI5RWZk?=
 =?utf-8?B?VWJEOW5ieDloTWZFUGxicExsaUpxT25pUXBMVlNEL2dINGRpazJzNk05RWV6?=
 =?utf-8?B?TzVBYWV2TnlDS3RIYXFXMXNoTjBuSjdzbm9UMWFGejJoeFFYcHhzZVhWcVZq?=
 =?utf-8?B?SzBkMlNGWjh6dUt4YStIbnhzQVdERmVTcHdhQTBsSXNyeURoWEFEWjRjMGJ1?=
 =?utf-8?B?dHZLc2k1T3FBSkxsQ1ZRdCtKd0tZa3dCZ0JXWHgrN096Q3ZmbWdTQzFSOXJR?=
 =?utf-8?B?cjVPM05WbnhoMFNVSThvL0pMZmNSSzlPdTV5a0dlQW04M1VSRENEU0MrTEl2?=
 =?utf-8?B?WnVQVXpJamRwUnBUVGNuMDN1OUZOVTRiUWZMSklScmtEdjZTelNMa1NVemtY?=
 =?utf-8?B?RUhoRFFpbnlIMmVGVGhjZk9PVlNIWUV1dGlFMmk1bjdadkZmMVVNSm5MOHN5?=
 =?utf-8?B?MnF2V3V6dFE5eDFITHROTGxvRXUzMVgvZmkvekJnMWE3Y2htODZEbERMTjk1?=
 =?utf-8?B?MXlDNkRNbHJxZDdKUHQwRGRsaGtkbjBHR1JFTUNrVFFoSFNVdC9CTEY5WDVU?=
 =?utf-8?B?K1dkT3RUMXgyeG04dDVhZ2xubzR0MStGYWdJYnV6L3hYVXFUaUhQMWZ3aUFE?=
 =?utf-8?B?aDZSWUlEMEgwQXc0MnVBZFozODl6b0F4SDlHOCtGbzJwcTlWTVNKcWs4L013?=
 =?utf-8?B?TFk5QUcxV3h4MTZHbC82ZEFzS3h6TTJFT21zbXNHZG9VZWV3clM2K3hXeURt?=
 =?utf-8?B?dk5WK0I5WHNyZEFVUEQvdmFLZ0hVNmJKS1VySVRKSEdsZ1pxZ2wrQlNHM043?=
 =?utf-8?B?dmFGSExzcFVvN0g1Z3YySFNqbS95UFlKeTlwSDN5MFFqT1NpZ0NIWHI1U1Ni?=
 =?utf-8?B?ckpNRjlGM1RTc283UFlabWl1QXRaNjQ5c0hEZFBIUHdFTGdlME1JTTJGRFgr?=
 =?utf-8?Q?PwstH1aZLq1mFlDHs8gvEN0uD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd48dcdf-2813-4b83-897f-08dd6d112e31
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:24:31.5026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnmALURldTMc7khP1ppFrGU0XHHxITENltsmBz+p+SSuWh1kZtlainA97vNZARLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
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

--------------gT89kP0weIzns11Qk5BqE85o
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>>> Over all this change doesn't seem to make much sense to me.
>>> Why exactly is isolation->spearhead not pointing to the dummy kernel job we submit?
>> Does the owner check or gang_submit check in
>> amdgpu_device_enforce_isolation() fail to set up the spearhead?
> I'm currently debugging exactly that.
>
> Good news is that I can reproduce the problem.

I have to take that back. I've tested the cleaner shader functionality a bit this morning and as far as I can see this works exactly as intended.

Srini, what exactly is your use case which doesn't work?

Regards,
Christian.

>
> Regards,
> Christian.
--------------gT89kP0weIzns11Qk5BqE85o
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <blockquote type="cite" cite="mid:740940f4-055b-483b-88b7-072907539167@amd.com">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
</pre>
          <span style="white-space: pre-wrap">Over all this change doesn't seem to make much sense to me.</span>
          <pre class="moz-quote-pre" wrap="">
Why exactly is isolation-&gt;spearhead not pointing to the dummy kernel job we submit?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Does the owner check or gang_submit check in
amdgpu_device_enforce_isolation() fail to set up the spearhead?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'm currently debugging exactly that.

Good news is that I can reproduce the problem.</pre>
    </blockquote>
    <br>
    I have to take that back. I've tested the cleaner shader
    functionality a bit this morning and as far as I can see this works
    exactly as intended.<br>
    <br>
    Srini, what exactly is your use case which doesn't work?<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:740940f4-055b-483b-88b7-072907539167@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
Christian.
</pre>
    </blockquote>
  </body>
</html>

--------------gT89kP0weIzns11Qk5BqE85o--

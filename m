Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADD1D262AD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 23:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1004810E687;
	Tue, 20 Jan 2026 23:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FrcI0rvQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E360710E694
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 23:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc8B9GD0m+EWHvlk4ADBCa9H8B+NeMMwHPT93p0VB1uCHFlqf5ptecyKQPPbu9no/XZHnI2F5SEqvY8a9Gj6a6eLwPc3gdFruTKs65j0sMTlHvSGc0RSAK0HwLLtuuBUdi3eFv4QuRtwotXTImvoHAdhEPhAhGf8lpUGKIxm8HwSOI/m8+3E5FFmNjmOuZKylVL/Y7G/Kd64Aco9zdbWNKcP2sDzxqt0OGp01XIkraItBrckWG7NUKB+miQvJLe6oWzOk2UcjVXi70W0W7xKkQDVyYwaNh8IHRwumiW9PH5scB9jLaYf806Y9RU/eaoz9oP+Kp2bBSk6uo3QaXvWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5DUncVfgWmfWfK24+eEo0RXiODM9g8pMvfk8H15+og=;
 b=t//iTotB+oOjsV9HJK4fEaHiJzV8nZ9Qk/HO81DrfEIcz2GGJHoIY5DwJHjpOp6UZphE7JNq7xhhfXOyKNyS0HalmcY3N6TZpsbWx8+rvPoUM0DR1j1AVtSHIMZ1vsPgwnIX95zw6WnBUaQtJ0spzVwxrrDlGkjWyDMGsG1+IVvs8zSYNeQNrCwNwqddeONCf4P34Jp8oKHl8C1jEcSbrOKR0PWLdESkSNxWEZzlddMY18AOYIe9+1QYU5AGlvy5Zcw6zolS1PKh7xNplfA0dDsHVsttehUhynP69j4lqeukt1TMIR8fP3jGD4S2DUTT8lHXxNn7mSG8jMvMx/rw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5DUncVfgWmfWfK24+eEo0RXiODM9g8pMvfk8H15+og=;
 b=FrcI0rvQaV29b1u1A3rvV28OS7k+DgL91RK5uhkLvnlgjJMkzq1NkhKmR8i7qLZgqkm8SVeCFcQ+IAENXDxH9ilkPzadac4FAIT+ZtrP3XoNWTcb/INNik4oSpHpF2zoUJX6oP8UeZPgTa4MWZajofJbbOZ4isxNcHtcFlUNcBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 23:30:17 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3%3]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 23:30:17 +0000
Message-ID: <1471efbb-6431-4a3f-8361-2666efa485c8@amd.com>
Date: Tue, 20 Jan 2026 23:30:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdkfd: gfx12.1 trap handler support for expert
 scheduling mode
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Vladimir Indic <vladimir.indic@amd.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
 <20260116203932.988704-5-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20260116203932.988704-5-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::6) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6bdd76-8f89-49e0-b0a3-08de587bde36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUdsMCtQVjA0eEZYRnNXaDl4ajROTXdWVFFkNGhMb002YkJVNUVnVHQzZlFh?=
 =?utf-8?B?R0FmNk42M1ZXNVQ2a2VNN2UxVTJhYmJ2b0Fxd3UwbVVBckNvQkNrdVNyVitw?=
 =?utf-8?B?UWtCLzZxaXdzejNBSFBQMVgyb2dKVC9LODJZeCtoQ3RjZVp4R08vaWtZTnow?=
 =?utf-8?B?SGl4MnlLdFhLL1dUaEp0aUFRb01lR2t4SDZYenB5SEV1Y0M0Y21PN2tIOTZZ?=
 =?utf-8?B?ay9TdXJFczMwZVJneHBsbDRmdS9rT1M2ZXlUR1lOKzBZcDhyTHdWWEpEd2Z1?=
 =?utf-8?B?dkZERlFZRkRzdWlpMzNGRitjaVo1ZGxYc1N4a2hiMEozVjdKWHE1KzN6TDdP?=
 =?utf-8?B?ZllBbzBqdjhsSkh3dTVaYnVKaTRlcC9tWlIxdDU2UmZCYjBjMjZlanE4K05L?=
 =?utf-8?B?VnBySnJ0Q2o2ZWpSaUM5Ulk0THlxZVAremorNkQ5VFBUa0tGQStNa3ZQaFEz?=
 =?utf-8?B?dTdEUjQyY3MzWmFiWWN6RkdadWpwY3V0ejc4SjUySDBCaExUa0w2ZDNUV1BL?=
 =?utf-8?B?YWI4aTNFQlBEb00rZDFUbHQrSnFaYU10SExHSGhCeEp5VGFzaVc0QnlrY0o2?=
 =?utf-8?B?U0lUMVlvNjIydnUxWmJwdnhuRkZIMkdXaU1XRnppbjFxTUtKaExzTTlPYzM3?=
 =?utf-8?B?UkxTZzhBTnN1aEFEa3hsdDZXdHIzTHZrZ2lHcmcwTFRndkJLZCs3WDh4UGF2?=
 =?utf-8?B?SG8rVitiaXEwVmZPZWhiVWl1TGUvNmtSaFpXaVJsc2kyVG9mTjU0QU92Y1ZW?=
 =?utf-8?B?Y25LTE9jOVJONCt5MVN6TXZYdDFHNm1XcXRQdUk5OUYrNUp6di8yTmRjc05z?=
 =?utf-8?B?djE0U2RmUndwUVl3cnc2WkRTQ0pqOEhCWSt5OVJDSWhwUnNJWXRVOGt2RTcv?=
 =?utf-8?B?SUppTjA5dzIyRnhZTk94Rjl0U3A3ODNsNGxBdDBLdVkwOGpsSUFheFRCYi9P?=
 =?utf-8?B?VUd4aGJFV1JHRDMxeVZEVDhaSDVmRnA5MldJYlBmc3NnYzZFQ08xSXYrYlNp?=
 =?utf-8?B?RHZKV0pOUUJrM0FoRk9mTS9pNGZPWFFmeWVuNHZTK2JQVDV5NlY3SUJyWlZs?=
 =?utf-8?B?ZUtlem9VOGY2OEIrT0pYb0tmcE9iRGVjcyt2Wlk4K1BoUWdzSlFFSWt0WldU?=
 =?utf-8?B?N2FMcFIyOXQ2UkJ6V1NoWHhoVDJwa2VlUGxZSXpjUnp2L0x1NWFteXg1R3RP?=
 =?utf-8?B?TU5iL05TS2RjMVZSbXFTYnkyWVhrUTNYVGpTNXRmT213dkZQb3MvNGxyRVY5?=
 =?utf-8?B?YzUxS3pBUmh6eFR3NGwwR1lVeTBiQXdEWHExWk9uRm5UN25EbUcvN25WeFB5?=
 =?utf-8?B?dUhOeXdxL055Sm5ja011eEZMd3haQ0JRbWttRkJZbVFodEl6b1JiTitTV0Vn?=
 =?utf-8?B?ZXlBbzNRblhqSlRuazJUTkkreStYY0RwOUtaM25mRUtSUEhCY0tEWVA5NmNH?=
 =?utf-8?B?Tjh5UzdJS0d0M1FGMnFkWCsxYWxFem9RZmJVY0tQVmlabXNSTFA0WFRqbVhV?=
 =?utf-8?B?UzVkUGtrMUJEQjZmbnJsZEo4bUViQ1E1MmtvK0lKU0U5SHJEVktiWG1FV2dZ?=
 =?utf-8?B?Q29YRHhkb1NFU2xMK1N6M2ZvYndsTFF2cEE0bnVUTHRQcWhicjRBeXNKZlV5?=
 =?utf-8?B?VGo4ckRwWVdsSVcxa0FwZzhHcmVCK0pnQ0xzK0hjK1JxMExwS3AyQm8yRHF4?=
 =?utf-8?B?NUtJKzhuQXFpcVJOMC9nSXZMOXlLZnhReEUxSDBXdFNrclRydTd1OGsvTWZE?=
 =?utf-8?B?c2lJcnpiRnNSK0ZrOTBpb2FMMk9rdVZaLzc4QWFkM2d0YVV3cEhJRGErMktZ?=
 =?utf-8?B?UFJDbE56amZqamFqRlNOSUhIZWMrWGxhQ0lSVmlMRTBoZzNRZnFnanY0MG1u?=
 =?utf-8?B?MnZWMkNZdGRIcEp1bXVzRHJIOU5IVlNCd3QrUW9ZQmd3WDFYT3hNMTNTTGJ4?=
 =?utf-8?B?Mmg0YnNOd3pGOFZacFFHenFjRVZLRnMwWWVjYnRJbGVGT01NSzRYb25uTVhq?=
 =?utf-8?B?NFJUampLeTFMY2pFSW9GZGRxVjJNVGJZQ1JlUnR0SWRQR2VlN0lVN1RPc3hI?=
 =?utf-8?B?cWNuWG8vMzFjTDJMYzZaTnUwL3l3M0l1RTRIcHhnNmEwMXptSi9uVmwvaWZV?=
 =?utf-8?Q?jaCM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUM5NlA1a0NFNWw4UUZOM0dCSW1YZXhVUVUxelhGSkpyakU0Y21xa1F1YTlD?=
 =?utf-8?B?cXpUUmFLekNXRG9IM1VzTjJkakpXM2JMN045S2RUOEw1VWlRc2I0MEZ6VkR4?=
 =?utf-8?B?cFlCTjVOcVhRSDlXcUpJRERncWgzU1FHcnBzeXNlZHJxWm9qU2ZKUGRGR1c4?=
 =?utf-8?B?QXpOYlBybmpzK3BYbVNWM0ZSTmJwMTlXbmZkenpLbTN6cElQQ2dERVRlS0JT?=
 =?utf-8?B?c09UQTBqTWlqcFp6WEdxNklkVkhEY0lJR0lPT1R1UzZCQ3crakZkRzlsWDYv?=
 =?utf-8?B?MnoxcVJraS9jTmlMTUN5ejBVeVFxOCs4SUVqZGtUUGhIWi9MRDFNeUdrZDZ0?=
 =?utf-8?B?VHN6eks4SEFhRFVZbmgyZlJ5ZEloZTZnNEgyS2pkeHlOekZQZGswTXE1Tzdr?=
 =?utf-8?B?MlJzVjFnZXZXUlRxRVdsMVJVWGt1OWQwWUdidEdidlRtUkdUOHhhR1hRSTJD?=
 =?utf-8?B?NnJlNFAxQTFGb0VqRUZIUU8zSlZyZzhrQ1FTZlZodjByTTIxaVJkZDVMdVhj?=
 =?utf-8?B?bS96YlhCSzVCZllkM01iNmE5VmlyM25lQk90NUhKVVdKdmlyak1RQlZXaFV1?=
 =?utf-8?B?WmorZkF0QXJKZlgxQTRtVFpHN3AzSlRyYll3WmF4R2w0emVHNmxIRERjVGNS?=
 =?utf-8?B?NllRdENRakJtZ2pnb0E4ZEZWZDJUaFpJNXB5VXAzS0J0eFlraDhlRUtlamlu?=
 =?utf-8?B?VXFvWlFidkRhN25Uc1cwYzJuWFdSVk1keEYzNlVQTFMvR3lwKzVXUW5RZUkv?=
 =?utf-8?B?SjQ5NCtBN3JYQkZ4KzdCMnZ2KzVlZzNMbytpTnZPZmRmS295dVl4R3V1Nm0w?=
 =?utf-8?B?ck54cEpCTG5GQWZLdTJXRU1RZVpDRmdXeG5PZVNtNWNVYzMrRXpVVFNGYTN3?=
 =?utf-8?B?S0tPcGZOemltY2xScEJ6NlVHWmZBdG44OW8xdGxtdG1KbldvbXgvQ044SHp0?=
 =?utf-8?B?WGtWNVM4Z3pYVGx3UFhUdmpFZnc1Um9yc0NrOE9NRGlzN3FJcFFlSStheXp1?=
 =?utf-8?B?Rmc3SVR5MkJ1dndZQjhvdURPaHpFQkxRZGtkdHFuWk02bTJHYzkxNWFsOC9V?=
 =?utf-8?B?Y1Vzc1VJMkd6cXpzdFRaSmdwYnBGYzdNeWhkUU9VWWphYmR2T3lqV1BtdDlp?=
 =?utf-8?B?S3RxNlpvbm1LVy9Rc0NmMmRnZUljZzR6ZGVBWmNKWVJjZnVJUnJxK3V5d3NC?=
 =?utf-8?B?bDB3cUg3bGF2Y3Yyb0hxSGtHdEh4YmlrbG1RTUFxU2ovbUFCa0xPNXhGQkFU?=
 =?utf-8?B?djNDRy9hSFpyS3NraEU3YVEybm9BWG1USXBQM0xmdlFMcmhCRkhSNDJUVW5W?=
 =?utf-8?B?SVFlMlh1b3AwOWdTSTZlaFdnb3Ztb3dCQjJEQmdoaFRxeW1DemEydjRBdXpJ?=
 =?utf-8?B?Z09YRG53MUxTQ3lubnFoeElmTkZVUGhablB0TUpneWNwRTNZL2ZYSS9vOGtr?=
 =?utf-8?B?dkZUTTVsbkRkSWlMNmdyZkd3cGEyVXJKcUZvVDZkK0YvcUF3Wkp3T0psSTNR?=
 =?utf-8?B?TkJDWlpjeVAyaW41U05SaW0ySldobDNpZkdiQXZuVUd4am4zRXUwbFRHc01I?=
 =?utf-8?B?bktzTmszRVpIa05lZkJueUYwdFlXNUJpZkY4L2wwa0x0ZTU3N0xPc2l4dWd0?=
 =?utf-8?B?ZnZzYk0wbktMVTM3L0NrS0Zialg1TXNVbFo1NlZWSktQQWF4bmNZREt5dGNw?=
 =?utf-8?B?ZCtnWGQrRFFpY0l4N2ZQemRGcURZN3FWYnc5NzY1QWh5MDVBNUdFL0lmSzhu?=
 =?utf-8?B?R3dYWVBLTzZ2TkFpcVByZGVmZ2RoREVwRWJMcElnclpvNFZrMEczeERLK083?=
 =?utf-8?B?VkxiMnNuallvbDd0TDJOcFg3c21SWjNMS2ZtYjNlVGJQUWRnZDBpbFJjdGUz?=
 =?utf-8?B?Q2RDZTVOZjVVQ2owU2ZMbDc5NWJMcXRSeHFzR3lNZE1hayswUE1ZWEl5cWt3?=
 =?utf-8?B?R0tRcXp0U2x0Q205blJMZ1RvL3pISUNaYWFsaG0rMDFrRVNYQzJPSmRDM1I1?=
 =?utf-8?B?eDM0ZmZPMUV5NGp4S3pKakU2a2tyWHNBcStlMFpHRkl2bXdhbXJrS2tMRG1H?=
 =?utf-8?B?aVBwcWRRaTh1YnJKTTBIRnk0OXkwOVpVbVl1RXk2NDFBSkthWTVtK1dTK2lq?=
 =?utf-8?B?ZktnSDBxY3RKMmdjVEwzM0pRdEJVVGhVK0wySnRzZ2xGaWRzdGR5UkM4M1Qz?=
 =?utf-8?B?MGQwejVxRWI4NHh0cWFidlgvb1pKYXZnd3YyczJEbjJBQ08vWkVwL3A1K2Vv?=
 =?utf-8?B?U3ZTN2xhYmdWYUl0cFZGcy9GdURyV1VVbWVrVm5GOEZEM3lkam00WHg5RUZL?=
 =?utf-8?Q?etaBNE7K6tMhNdqZnE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6bdd76-8f89-49e0-b0a3-08de587bde36
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 23:30:16.9884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8uoRNkXSvrdgSaox/vhgAt+wXKhwM1QM552+d2B49v1ru4JIi217kbK472MOVqsdgiEkGvHZ4fYVwkuXn+YEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
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

Hi,

Thanks, that looks good to me.  Thanks.

Best,
Lancelot.

On 16/01/2026 20:39, Jay Cornwall wrote:
> - Leave DEP_MODE unchanged as it is ignored in the trap handler
> - Save/restore SCHED_MODE (gfx12.0 saves in ttmp11)
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Vladimir Indic <vladimir.indic@amd.com>

Reviewed-by: Lancelot Six <lancelot.six@amd.com>

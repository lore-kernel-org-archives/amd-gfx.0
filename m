Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4C2C02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 11:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923C910E05E;
	Fri,  7 Feb 2025 11:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CwBrA2zT";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69B4E10EAC6
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 11:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9AccjJa/ePP8wk76EFkpkPPBmaSR9CPgJLzYBSaFaLa6pcLYnFTLM2rddgSQoGR/7TFh7K3jqpyRFm7P5sNwsaHy0golPwg0Oa1+I9p0Fu447z1TF9dagbXWTo881T+mI1vwyqzMf7BT4JJmOShHmMz4TYiqXhDKYfHcIyQac1EMqUH5iIzRQWexsndDTeog5uk7qNEQksbMXHhhvu6Yazh+ilFcz+UvSiT7hML3wmgTz96ad72d9WF6RiA6w1tEVaEXSfklsC0p38JJ6GKKqnLDgP+xqqau095fpxTzMXYvgnzLb1ekmHmcnuV8dDi67Q1Vjkk4BKzwdlxJf4b4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui6CWNoUwGSSYgqJ31aNYuWQHiVNGIVhxWKRE/kq2o0=;
 b=YKaE9Q9A0rwRvWCyxY64Ok1D6d206w8SIQGcQpgTXj62MUe9YAcVJEOSwc57DvobnW9xnwAIZUBQ9g748i82e1gXj7BdhFsjQq/rdLyNTza4cETeriK3B/BzH0Sa0zd/JZ6dhnM0/bOllfAVOTDCm8aPYlMB976EzCQlOYbSILcQ8/Hp/S3nqv9WHZgNJlJTljoVjBv7pGA8hFscPWRXl2KLXOKwN5f3y+YW3R1k5sh17rL8r1EzRzYPyfoBnaUU2/+8efDr5QceCO3ggY+Ajdgb4+CvjBQ0MnlfK1Jz3v6m27qjCwK/Mac4pa5GFO1HnJXRlKg/lESPASZGhB76Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui6CWNoUwGSSYgqJ31aNYuWQHiVNGIVhxWKRE/kq2o0=;
 b=CwBrA2zTjU+pfrw76zgwVyO8CxKVbKTaRNiNZztiCpQlXoSYZRzQ7Ck0pXhSyt0c8m8xiMFu1a5GN3HEYOTNURS3gwL3Sk1DuhgUdqIHY5x2ucasRT2Br5kKgI1OL1JFGqYcS2DN/EQtaowKAjj8HWmys/Nvn/z6j6WJiouRkGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Fri, 7 Feb 2025 11:06:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 11:06:04 +0000
Message-ID: <2c412261-20df-4b2a-9cf2-cae0688d3887@amd.com>
Date: Fri, 7 Feb 2025 16:35:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 3/4] drm/amdgpu: bail out when failed to load fw in
 psp_init_cap_microcode()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1738909308.git.gerry@linux.alibaba.com>
 <d6d0b42a335784ae16500664ed3a0fc17bbe0476.1738909308.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <d6d0b42a335784ae16500664ed3a0fc17bbe0476.1738909308.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cef6ca-1f59-42ff-e85b-08dd476769fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2lkL3hFM01vSi9RS2ZCSkNDK0gvbXVvVG5mQUZaNjh0RUdMWE85WHM0WDFM?=
 =?utf-8?B?YWdiNmhUTE10RmpZWnVvanVpR3M3czNvYzZBeTE2NHd6YUc1akFKTlYzQkFH?=
 =?utf-8?B?MUNtV1lRUkNWNyszcDg5Lzd6eDBiRzIvNXN3NkFtOWtwU1JZOGRSb0FwV2ds?=
 =?utf-8?B?MEMyL2hSZGFkVWt5QUhOVE16ajJQekNVWm90cWdRUHhhTFp5TzJkdUtyTm8v?=
 =?utf-8?B?bU85Z21pcFU2TlBpUkVmMlgvSjNQRGFaZk15c01FRU55RC93R2hiME1TY29Q?=
 =?utf-8?B?dDFwZFpYY3Q2OXp5am1HaFUzWFNVVjJyNGdaYWNoVWlrVSs4czdYMEU0MEFi?=
 =?utf-8?B?TXFZK0g4M3VMelgzVnFGWm1PRnJIUHNwUmlTNTJLSVhoMkkvZGN0aHhQaTNL?=
 =?utf-8?B?cGZNVWloNEFxWTF4TXJ5L1VHVTNtTSsvWFhnN1ZLMVhRK0xIWWJoTjJWdHd5?=
 =?utf-8?B?ai90cGoweXB1bnhiUTdBRWdKc1RXbHhiNHh5YTJFdHdMRlg3UllJMVFieGpi?=
 =?utf-8?B?WWpHRkg4bUs4VFNxbGZJaGpRVWZXRzNDZXlZdkhSdVMxWmtxOTlKei9ZVktm?=
 =?utf-8?B?RTdidnNsUTVXWWFKS21teDY0T3lvdmtYazliUEthSmZ0bVpYRnpCQTFJeGFQ?=
 =?utf-8?B?YlV4akVzMHZzTitRM1R6L25OK0ZzYk9POHVJTFJMVU1NQjBHR0VVWDVoYkgv?=
 =?utf-8?B?STVFanplT2NzR2F2WXp6T3NodlM4bnpKaWZGOVN1T1ZsSE1HQXZ3ZENsWlRq?=
 =?utf-8?B?MHp4RGh2dmhoRlBtUGMwNnZiMmpRUk1jaXNKQTdRMDIxSWNnS1JpUFdrQXp6?=
 =?utf-8?B?QjNZbVR6clVJS3d3eGluaVNqcEp5UzNycGt6S0IvY3RNdGNjNGxQLzFxOERZ?=
 =?utf-8?B?VmNQUFRXWWdrV01BYUkvUllNVzE0aEtEMk9nUmdKdHd0alhqZE9SR09Sd0Vw?=
 =?utf-8?B?NFJqMTBEQUEvb1FhWnUwU0VxVDA3TVVUQjd6bkhMRFRRZExIbGF5Z0k3Y0J2?=
 =?utf-8?B?SFk4RElLOUJDVmVYUkhpV0R1WE42OG8xQXRKellaTldhTysvcldiK1ZaZTNa?=
 =?utf-8?B?dkNSZVZCbXQ4RGM0WWVTRU1nSFhqcnJpYnRUOHhqcXR1dXZqcmFqdzk5ZU0r?=
 =?utf-8?B?cngrUjNIVkt4RjNad0dGQnFIWk5QR2dqa042eU1SNjBRSWppWmNQaXI2elZI?=
 =?utf-8?B?VTZjb2pqN09UZ29qU2lhWWVNaVFnVDVkcGVsQWNKMTI4TGV0WDVBdE5RYnlJ?=
 =?utf-8?B?dXl6ck5Fd2xQU3ZLbFM2ZUJOZzlnWXN6UFVWT01rUjg5RlZNVDAxN0JUYlFm?=
 =?utf-8?B?d2gvQ3BZUXpBVitnZ0Z6ZERFWEZIWDhGc0w4TnpKK2hBc29SVHFTNGptT2RK?=
 =?utf-8?B?YklUU3pjaE1sTlVOcE5GRjVhSFZSZFBVeFN2VjdzbWZUUkxMSXVZSG4yODR0?=
 =?utf-8?B?R0VyekZEelBqSnpxUklqVTlyRXhxZm8vYWRjRDJHM3FaVXNGZytSWGcyYzJm?=
 =?utf-8?B?eFpiOEdmQ3lGY2IxRnFEcldyRmRnOTN6RkswZkNUNUdNK2dvNFVDOSsrd2cy?=
 =?utf-8?B?UjhFV0JYRWYrY1c2aG5pYStZd3I5Qzc0ZmR1Zm1EMVMrbEk3MEJEZ3c0YjRs?=
 =?utf-8?B?UWRvcUNSZktKbURvWmpFb1YrTFdINFFpVlBSOWdEZm8veEFiYWJMU0pKMWpM?=
 =?utf-8?B?c2hEZUY5OHBQWVhteWo2QzVSaHVQZitRVVp2YzdpS296UzdaUlRrOTJzMzRp?=
 =?utf-8?B?VVltelJWSXZ6WDF3NnF5VEpTMlp2UmNHQnhlb2FjYTN6WUtpZFE0MUg5ZFp3?=
 =?utf-8?B?WkNvL0ZLRWtmRzV6SFdqQzFuTWs5ZzFpTXJPWXkrNjlETEloQ1hXOWN6aENq?=
 =?utf-8?B?WDBxYlV0RGxld3lBeEpwcWw4WmhtODE0QktXeXhLVHlxZjRWZVd3cFFzSnpF?=
 =?utf-8?Q?aUuK872vdS8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjZGeHBXTFBuWG5EUitPWnFGNWg4MnlNcXo1RkJnWjJLMnVwc0RHNUxEZVN6?=
 =?utf-8?B?c01EdTZrTTYyMkUva0tzU1pkak5lWXBsaFNCaHh0N2pSY2V1Y011TVBmbXZM?=
 =?utf-8?B?V1BBdXJ3WEx2aGp5Z0JvMnJiRDlpVURHRm8rcE9ERlRXQnRPbmsrd3VzZW5y?=
 =?utf-8?B?SkUrYnZuN1MxeTFhckF4MXdqZndEQ1ZJalZReXRmeXhHckZ6YmJiOG91c2tt?=
 =?utf-8?B?V1F2MlRVZlhmdzBGWTIwb2pxYlQxcUFMYkdLdzM2Qm1HUE1lM2V5MzZQaUww?=
 =?utf-8?B?UFRYa0c1Mko2ZDBDZ01URUJNejVXUzdWRjRVaGlwRUJZTTEyaTVudWtQMlJY?=
 =?utf-8?B?clpzMm5zUTRSVlpqMlpkUS9tdnpiZ2I1bFlqbGlIbEI3UGdoSVlkdFJUTWRa?=
 =?utf-8?B?MTd0ZVczV0xhaVg3KytYV2ZEVVVZWGNEUFU2L1VwZkxwejRYdnA0cWJNSXU1?=
 =?utf-8?B?aFFoSGNrMHRBaXVLQjk5QTIyVDlvclE1R0o1dmFyZ3BDa0pTakt1cWgyeGR1?=
 =?utf-8?B?YVhidjBmVnY4UE5pUnprUUZqVDVXOWdmQXQyMkxMaXh1N2lSRktrUExISTZa?=
 =?utf-8?B?Tk1acTA5aWhkV1RLVDJxNDdVRmpoQk0yUXFPVXk4aDR0UUp0eTZ5cFhCTmtY?=
 =?utf-8?B?M1I5SUQ2Tm1qUEcyclF1YVRoZ3ZtNUNjRE04bnhQSXJPSmRrRzR5RW40cVFY?=
 =?utf-8?B?UVQrS3Ivd000STMwc3hjakovWUhiSElodDhNaXB0TzZ6OUxRNS96NHA1K0Fp?=
 =?utf-8?B?cEJ3R2pHMWlLWUxGUzdmZXlwbGVySmNpR0gwNmVVakFRTkRseFYySHBCeno2?=
 =?utf-8?B?NUxHTGpmVkoza1RXRnZuc2dvT3dOZTJNdExHY21Jc1d4RXZtTlhza0J4WUd3?=
 =?utf-8?B?ZS91RHBwaGJBTmRNSEsvNVRKRDJ1Nzc3S3F3VlNkQjF2Uyt3SWNrMG1JTCtX?=
 =?utf-8?B?ZnRDdjRmeFI3UVZOeVNIVVk3MS93ZzNDcTFtV0ROVEF3TGVUUFVHaHBhV044?=
 =?utf-8?B?aDU3cDBGODZOTzlBODZqd0xiRlRTTDlHeklxb1A1YXRCcDlkem9pbkN6N2di?=
 =?utf-8?B?TGVuMXlOZko5amdZU25Bc2ZqWjVFMWFWb1A0MFhLK2xBeDY2V1ZRWlJ0YXQ4?=
 =?utf-8?B?R3h2WFVBWWZyeXVGZmQ4TW1DVXNXYzBlSlJuQUxIRGVLWEliRVlZc0QzamMr?=
 =?utf-8?B?K3lkeTZka3lSNkR0a3hFbzFTMzQ5clU4aStzeFBuMkJ0ZmZQWmRiOWlja3VN?=
 =?utf-8?B?bGZJNVJxS3ZNM25DOWVBLzhVcGYyM3Y0TjlqcFZYbTRWYlpIdzNYTFJUN0Nz?=
 =?utf-8?B?RUdJU2xvTExiQmx0Y2lPT0dTUU1lN3hpV25WanA3UDA5OENOaTdwa3dtbDFM?=
 =?utf-8?B?eHhHaU9nRW9lalZKaWxQMGY1cXZKb01RaUYyOUJUeko5MnRnajlxT0c3MmF2?=
 =?utf-8?B?Vk5pS1B3TGlzSmtCbXVjTnV3NHE1dkdIWEVQZFh6bFRmOERTTFVPZ1JoQkY4?=
 =?utf-8?B?QXFjTXcwa3lLYzFrNkd3c0dQb005NHJTazRMQ01ndWhhTjZpZFZEUlZMSjAy?=
 =?utf-8?B?OFNHLzNQYmxqRFNGMHN6VGNrMFNtQWRZdUJNS0N3L3dkZVVKR2pnUThpRlE3?=
 =?utf-8?B?bnZsVGZkV1oyZWFNZFNtaUI1OHNZaWh2ektwb1lGVmE0akdmbWs5NHZZbWZX?=
 =?utf-8?B?QkJPWkZXMFk0bW1RcVlkL3ZqbGJpNy8vM2tjS2FWWXU2azdDODFmOERoRURn?=
 =?utf-8?B?MHl0UnBoUWFybkhIU1psU3dEZVhjMUhwdmZkdjdLVVdLMjhHbVRWU3RPSGc0?=
 =?utf-8?B?dFZsYmNxYlArTU82NEhkSmU5RktUWXd6WEdnZkxSYTZ2YmdRKys1L256MlJK?=
 =?utf-8?B?dEJUYUkrakpFNnVjMkMxV25rYjFGdktUV1NXNnMycW93ZjlwbFZraXEvTUJD?=
 =?utf-8?B?bWc2ZllYeUNBZ0NuMGl4WHUrY3NyelZKZG8zOFJMUE1NQThZU2xlei9DSmdG?=
 =?utf-8?B?cUxGV1VMS2RhRzhJb2VKZjdFWm9ITkxobmxmN3dUMjdPemNPYUpxRG5pWlNh?=
 =?utf-8?B?b3JMYWsrVk1vWGxwYmZGWWJia1BFMTd2SjN2WThodkRJNThXc3NpT21LaXo0?=
 =?utf-8?Q?puXBrkoqcPJ1vBZ6SYdWm9rHj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cef6ca-1f59-42ff-e85b-08dd476769fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 11:06:04.6160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6TjeftNwntGLBiz4tFimZ1F4QYlGmD5mMbP93Ss5ty+X7pZ2GnAuUFPKsBnU4pP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
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



On 2/7/2025 11:58 AM, Jiang Liu wrote:
> In function psp_init_cap_microcode(), it should bail out when failed to
> load firmware, otherwise it may cause invalid memory access.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>

You may also add

	Fixes: 07dbfc6b102e ("drm/amd: Use `amdgpu_ucode_*` helpers for PSP")

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 0d1eb7b8e59b..952da6c7943d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3838,9 +3838,10 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
>  		if (err == -ENODEV) {
>  			dev_warn(adev->dev, "cap microcode does not exist, skip\n");
>  			err = 0;
> -			goto out;
> +		} else {
> +			dev_err(adev->dev, "fail to initialize cap microcode\n");
>  		}
> -		dev_err(adev->dev, "fail to initialize cap microcode\n");
> +		goto out;
>  	}
>  
>  	info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CAP];


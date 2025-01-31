Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FA4C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC8210E39F;
	Fri, 31 Jan 2025 16:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xZQoXtyW";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE70C10E39F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnsndTUn5yNHbg0SMOI9AajEnkLIAVXALdFYQsYJsQBftQsvmiwCJ2anOCD8Ny2WJQvByQTrKn8roShfwdmyRVOWJzh2sLVKcHdxQYhwVFYQGniJ2sIxHJ4TM9w/MuVLSTmWhI59Ux+EzIJUGgSHdJgBBo2T+5qQ4EWQyPQ+SotQGa6z/XGFvVanM2Fvl+sh1FF6mLcIccANFqGduEvxLYpFcRb26OSasci2YJL6VxpqGKbS0mmAg34ueF4vso39ru3thaE+ti8jurbw2buR/Jukr+MJXAUNC6w84GGPfQOwOoqbApwoD3PKssTyJxzY9OMtlqrlg0Gqs098iAXeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFFfkuJEaF9jPQMTIgwzNIqIN304RUDZ8KQUNgV5eKo=;
 b=Z64U8QZhpnWo1CS44/H5kGxOh+sRkDNa/ELReHU0CvHNlr5qZUW57XZos08tKoHJYyyPOBbA0wc/AdnQqKIEPf09d0Apg+oP/EUSjsPs5goadDljqKKar1rK6nS7EzNMgmFqFmJ7q1IFZPLqNTsmEFwB62QCcHIrDxeHafeji/CEcUfjptu6OGYEOnjZoGssbeclvm06yj5AU/J6/bJd/meqV4mqYxCYUS0ws2L2oTPL7lpup+667WE1LZ5ayxOYhPzOGIMBYtlTuHk2jn2aU2eYS7BPFYHmEg+knIIpFSjRz5bLlqQeGFqRYkrOTrrC046V23Kcqv9DvPvjqYFSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFFfkuJEaF9jPQMTIgwzNIqIN304RUDZ8KQUNgV5eKo=;
 b=xZQoXtyWbD+/Vin44zoTKtCC7cyJbmlxHhPjm5p9pE526fow/u/1Aszb5CmxPuxqTxm0gZXyYyi1eNimg59AxyvTdIN8oy1u6Vfcei18smbRhufVSKEtseVh+39BWspMkWqt5ru+qqB3woulmNogqSmCzD338lhG74a8ikRYlZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Fri, 31 Jan
 2025 16:46:58 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 16:46:58 +0000
Message-ID: <f152e8ad-f547-2db4-e1b2-c2edf0a8ea62@amd.com>
Date: Fri, 31 Jan 2025 11:46:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] drm/amdkfd: use GTT for VRAM on APUs only if GTT is
 larger
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250130205110.811511-1-alexander.deucher@amd.com>
 <20250130205110.811511-2-alexander.deucher@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250130205110.811511-2-alexander.deucher@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 263f446f-7562-4632-dc7c-08dd4216e087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTNOOGVpMnhPdVozNDZWelVnayswOUhyZDFEWDF5RHQ5blV2bk1ReGgzS0Fl?=
 =?utf-8?B?aEFhdDRGSmlNbHdYcVRiNkR6eTJtMlJyb1lIMEZ2MVF1K0s1V1l5bmxzNGxH?=
 =?utf-8?B?RDhSVlR4ZGpZaVJrYUZQb1A3eFlHeUhMK2QwSDlxOG9LY09ZWEJOVGhJREU0?=
 =?utf-8?B?RkdITnIraEIwRHNOSFViUGxjeW1UQTlDM01hR2F3YzlJa01IZWdqN0dyeHpq?=
 =?utf-8?B?cmFQdmt2NDk5QnhQY3ZlZUhyU1ROWU5mTUs4OElrQmttU2E5V2JTc1J5cHVp?=
 =?utf-8?B?aEpUNUFPOXlWYjZsR3ROSFJDZHBHaVZCR1pSOXh6aW9Wc2xRL1VNUXdIY1ZN?=
 =?utf-8?B?K0tncm5IYSs4NHMyelU0Mk5remJUbk9QamZoY3ByRjJ3VDVkTGFYNmFBSWRR?=
 =?utf-8?B?TDdNdjh5WGUwMnJucnM0VTR3djl2MmI3NXhPNDR6SDRpaFFUSkxSV1l4RnRN?=
 =?utf-8?B?QVhzSlJQUUIwcjZRSy9rTkN1ZGNMbmZqYlBTVmJNNkhSRmdGc3Bod05EeUtT?=
 =?utf-8?B?QUVBWklEOUVYdXZna1FVZWpkR3VWcEowT2k2bStMSmtReUpNR1ZwVm5RV1VX?=
 =?utf-8?B?NEdWZlNIQ2tsK2trc1ViMDMvbkFaNFdsNGcrdXJpaGNISzNTb2duTUlPUkpl?=
 =?utf-8?B?MWF1d3RWQXBGa2o5WHJMcVZFWVczb1JQRU5WSEJLYmR0L25BSnhPY1hWSG10?=
 =?utf-8?B?SHpmYkZTMHJDd3ViYUJLdWxYWVpvVXZUWHVrc3ZINDFWMXVFL2JiTlhWQjdz?=
 =?utf-8?B?QWNWSExHS3JEWS9sc0ViWVg1VnFDU29VYTVmUWN1NkpWcXowbXJJNHY5VHdz?=
 =?utf-8?B?VjlIRjQ2c3BYNmRvMmQ4QUxUTHFGZWkzL0NWdzdGL1E0R1MweWpuU2U2elNB?=
 =?utf-8?B?VEt4OVk5NndqSVFZRVF0SzdCcE9yendZNi9OOW03ZXU1aytkVHlDbmkxN2RW?=
 =?utf-8?B?QXJ0NWkxN3YyVEtPRy9wNDVqc05mb3B0aWk1eDd5WnRhSVRWeHM3T3JRUVky?=
 =?utf-8?B?eGdESHZEN0ZxaWVFNjAvZzJKQWFLM20yT1ZIUHk0dnJubzVZUFBNNU5wZExG?=
 =?utf-8?B?NVRSZFJFdlpPUWphRFZ0akxSOFZUUTk1OFVqbzRDR2l6bmdQcEM5Q0hzbXM1?=
 =?utf-8?B?MW5LTldyRnE3KzJhdGVxSFltRWVaWTdXYkFqUHhVblJucG9tT0xSQXJaWHlJ?=
 =?utf-8?B?a3BiYWkzWEZjTWtaaFNaZXByZDRmVjRnUDhYTWFJSE1uVGRtT2tHdFBKREJ2?=
 =?utf-8?B?cHg2djlocHBuNTlNck1aVDd5RUs2RmtVck9DZW9CS0FieTE2YWFqSys1UzVi?=
 =?utf-8?B?ckxZMm00OU5PZWFnUWNITEtsS0lHeTN2dnVDTW4wdzVITUZFUW1QUXZNZXBV?=
 =?utf-8?B?bDBCTmlseWRyKzE5YUFuK0pqZ3IvLzlhMmJaMlRSQkU5d0I2MmdpM1AvUEs2?=
 =?utf-8?B?V0RrVmFOYi80THpPd0JxaEVTbjZCazgrc1NwTlMyZDVBcThPL2RDMVpwdkds?=
 =?utf-8?B?Um15VU5WNlJtemZsSmJvYXBvK0d6Y0Zyek1CTGlBZ2Z2d1pQRUxDanVmZXA4?=
 =?utf-8?B?SG50UUVhK1k3dlRvZ1ZpOXM4ZTNlNDMrdDJFUWNrSmdBTXQ5MERhN0ZvMFNB?=
 =?utf-8?B?bVRHVllKRmkvdGpiZS95UHBGZm9MN1lCaG1CaUtVbVFyazZMaEVRQUJhMS9P?=
 =?utf-8?B?Vjg1Y2IvNEZHZ0tBSm1zN2pIbk56WXdCVXB3VFl2VTdvdG9zWlZuZXFmMEJx?=
 =?utf-8?B?bDFxdFVkcURYSGt3TWQ1U3g1cG41NklGVlFzUTZxWGx1cnpvbVdsQ1B6RkJ6?=
 =?utf-8?B?NkhEVXhCZnQ5ZGt3aEpLUDF5ZEh0Z05EQ2V1eWJIQ1BhMmEzTU91am9DMzN6?=
 =?utf-8?Q?xZO4mjt2oDsT3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azQrTHpQNmFFTUxUS1Qrd2UxMEg4Rm0vV3l4RWtWTjc2OHBBKzkrdU9sbkpY?=
 =?utf-8?B?Z3ZEeDBacHU5ZzJxY1hIdTROR3VPTkFZZytOOC8xM0wwRWI2bEN0YkJkWXRq?=
 =?utf-8?B?OW1tcXVLN3llbHkvTU1aS3haelFjT1l6T29XSGxpdzA0SXgrZmNCa2MrMkFy?=
 =?utf-8?B?RkRCK1RPSU1BaXhjeG5vRlpvRWpnTDM5aGVnS21US0RDcE5RZnlORzhDR0tI?=
 =?utf-8?B?SEJrOXIvL2hucm5TRWhrc0Fza3hOS2dyNEhmQlJOS2dKbkFRYjQ1dDAydjVY?=
 =?utf-8?B?WUxEMW9tRVhkdnd5dmR2WTNxU3lmSnBTaGRUOWN4TW90YjJ3bk5GQ1JjRlBY?=
 =?utf-8?B?cEVxZEZ3K1BzYXpIYy9GZmdrRFZrcjJNVUlPNHdBUFRGMWhnUmg0b0JkbWtp?=
 =?utf-8?B?NnRwV2h3Q3BwYVBtMXhBd1lNNGlFSTBHcS9rODE4eExZQk9uQ2JUendORFN4?=
 =?utf-8?B?Y2wzSHE3RnpJSlNMd2F1UERUOEFVYTB3SFVwV0REdDZmK0c0Z0pTOVFRUnZa?=
 =?utf-8?B?Q1ZLSzdyNkJkQ1Y2SXhOZG4zUG1QL2pjZmxXaHF2cFZMaTZuODFwdTVvMktt?=
 =?utf-8?B?ZTd0U21ySmxDRGlFMWVGdmlpTm10TkJ3dUF2dTZiMFk0NDhZY2xZMTYvWnNE?=
 =?utf-8?B?NzZOaHY3TWJpV1hiYXl0a1pHMHJxLzBSZDBFaUtKOWlRRXdDazJ4SDFqYnNW?=
 =?utf-8?B?TVF1NE00YmRSRDR1QzRSN0plUTJsTjFXYUpKTFVxd0d0c3Nna2dlU09ZK1g1?=
 =?utf-8?B?U2IrdTBPb052a1A5c0pZejlOMWpmWjdmSVVUVStUTFdWVXdCQzAybVpSTkYz?=
 =?utf-8?B?cmcyUEhXcTZZYVl6UXFFclZLTXBKaXEyeE02cjlma1BUNnJhQmlpYmt6NFhG?=
 =?utf-8?B?REt6SjNwQ0pNbXh3dncwL0x2NTVjcHFyWmRyeTNkOHBaQTI2L0MydVZEQlgy?=
 =?utf-8?B?d2dZbTEvTzFHQVZWa09mVEp6VVhhM3pSYURscEk1c3B4bm53WW8yS2Jjd1Ur?=
 =?utf-8?B?Uko2ZDhEbm1wL01iWk5jRTFwMXA4RkRmM3hWWkVyYll1dldqMGRZRHVjRnJY?=
 =?utf-8?B?SVIwclRiUDF0SGtnbjJSajB3bHUyWXl2a2xQVjg3cXVrMU1KRUo2YjNIRHpB?=
 =?utf-8?B?SVhqUFQ3VE9tKy8wVEhodWZYRURGWCtJckFlL3VXTHVrZXlTU2w2dGZJRStt?=
 =?utf-8?B?S0VaSU5tbmJGcWhsU0VLcUdwM2s1Sm5Uc3F1NzFKdWFzT1N6d2tWZktrTzB2?=
 =?utf-8?B?cmJ3Qi9vRjVmUFdvdThobmFJektQSTdERkpwZDRRbStiRWd3c1NBNFp3L3FQ?=
 =?utf-8?B?bUh6UXc5VTNOQmdreTRqeWIrQ1JmS1hUSGkzSTd1WFVZZlpoMWtZK0lJRlRI?=
 =?utf-8?B?dnkyWXdiNWMzM0I5YnloWnVzZFA4YjhmYXYzZUxRclpGK2JZR25sOUZZc1RR?=
 =?utf-8?B?VDdkVktrRXNkSWY5cWZ3cGpORzVjeE1XMk1MZGVrdGw4MlFGRjBDaXJNTkF6?=
 =?utf-8?B?WWJjN1h4cTYwY25HMzQvV3ZISmFLV012YWVaVUx3MkpjTGRoYy9uOWFhQTA2?=
 =?utf-8?B?U3JwcC90SDIyUWlUaFI1SUdsMHFPNGhjRm5sTlphbjRVNlZoT01VK1FLTFNa?=
 =?utf-8?B?ZURxSGZzWWg2bk5UWVh0ZGttNHZQSXg0L0k1ZDNCNmllTnZrdm8zcmdrNysx?=
 =?utf-8?B?eW9aenZNWERoSDlHVGk2SVNOQkN3UUIzcytlVVp1QVY2dU9wdk1EcmJHQlJr?=
 =?utf-8?B?RS9VMTg5SHpuc0FHbVhJMmdHR01KUTA3ZG5YOWRSajVOVzhwRFN3Rmd5VENy?=
 =?utf-8?B?d0tOMGdtNEtYTWE3WGU3YzRURDBPbkpiSkwzWkxlMlJmbm1XNjQyVXE2VjNU?=
 =?utf-8?B?bkdpOXZNTFJHbkR4eXE3bENaMi96SzZxZ0owc1hDNzdocUJnRERqYTdwcTM0?=
 =?utf-8?B?NTVueDlTcU1jTGJHT0NtTFZkalgzUllQeW5uTzBrWmtIRFUraEZ2bUloQ29C?=
 =?utf-8?B?amwxTytoUGFGNklGWEQ5NEVEbThCM1gveVhmTjFyTjd6SldjTldBLzduaG94?=
 =?utf-8?B?TzZWWFNUYlkwRDJrY2QxbFpJZTJUVU5jMURzMEN3U3RpL01IcWR6WTVuVWxD?=
 =?utf-8?Q?4m/i+n8P2TkHWjyBQvyajey29?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263f446f-7562-4632-dc7c-08dd4216e087
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:46:58.2009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ap6XPFPJzc3/PpuTet0x+2P1/UOes0I3fon44Pl996ZvL8FqSebRiq74O4fnKS2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
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
    <div class="moz-cite-prefix">On 2025-01-30 15:51, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250130205110.811511-2-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">If the user has configured a large carveout on a small APU,
only use GTT for VRAM allocations if GTT is larger than
VRAM.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9d2a3e2ad9df5..96ec26946db60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1985,8 +1985,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO(&quot;amdgpu: %uM of GTT memory ready.\n&quot;,
 		 (unsigned int)(gtt_size / (1024 * 1024)));
 
-	if (adev-&gt;flags &amp; AMD_IS_APU)
-		adev-&gt;apu_prefer_gtt = true;
+	if (adev-&gt;flags &amp; AMD_IS_APU) {
+		if (adev-&gt;gmc.real_vram_size &gt;= gtt_size)</pre>
    </blockquote>
    <p>This will not work for MI300 large APU, maybe the condition
      should be reversed</p>
    <pre class="moz-quote-pre" wrap="">+		if (adev-&gt;gmc.real_vram_size &lt; gtt_size)

Regards,
Philip
</pre>
    <p></p>
    <blockquote type="cite" cite="mid:20250130205110.811511-2-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			adev-&gt;apu_prefer_gtt = true;
+	}
 
 	/* Initialize doorbell pool on PCI BAR */
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev-&gt;doorbell.size / PAGE_SIZE);
</pre>
    </blockquote>
  </body>
</html>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A38C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 16:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B9910E3B2;
	Wed,  5 Jun 2024 16:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PnnUO9i0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB59110E3B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 16:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARHzuZLE8w87ZfK5Uzu2AJV6TsGPXf0i7tm3vKeOSMoENJpMBy/ibpXx9dzXKN9Bs6VyBig3+jkLwkPkQr/IF3xbmWsAEGwr6LqSE7YQ5D9wQ/YJe1VWg1oOBGvw+KCryeAilTc0Te52quy843vqJR6T0SJrGmlSFEOZDQX3Bou1k5AOK/yiM/G1hib/atZKBihX7VhC/gAB0cuxlgqwE8k3iW69HVsfJkHz1GgIXi6WKUwGeby82Six3IxiOv2adF+sRGbfVDuVWc3E6HUr5b2pw9CJ9kxpDigXWVp4/p88kSvEqteaUCrkZKfZx6rm4sMo1WXHgQggOdXjuX5rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/zNwEH7MOEnWHNHhrRYyFJ3lbZC6xb7ciIftMDl0Gw=;
 b=laOoidgpqaBz8QTgWWQYzGxuy/jq3HlNGCsL+hJZdzNLkmlZFGPJLiBRKwshErROVPWofiSnZMFPnseOLr+JLbF1XxB0+ktSrMESD7Cv/hO5SkwesW82SzYMU8cQfuDXiMo/eC/5ahDxLY9po2bOSs+dUKI0pUaTb3o8lkJlvk2ov3E39x8HfZqQT+9yy3AzRV7EEdfMOahgfOtWhnRrTQJCepDjjzBGYqRube1HPdSLkepkl4y5Ga5KOirZHoVomckw47oUabfBsohYV4/9C5NwtvQAD9aYZwi6ItjeGwNASVosYoWZICeULtY4B7ILG3etblr1gBa/UXHDeOR8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/zNwEH7MOEnWHNHhrRYyFJ3lbZC6xb7ciIftMDl0Gw=;
 b=PnnUO9i0t5j2oIXD/OT9YCN0dUQyJAz5XMwyaDYPdSm5DjHBAk/6LHFEFAaO0nkTCgdce5lzOcXvzd6SBSl4TQrOL5cYM171Rubm7k07KyMyoxgum2iy6+Pm5uwScWECm6dQlR1sd27pSHYPzXc4xVxsFktRQe/kpQRfNtkrowg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 16:56:02 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%7]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 16:56:02 +0000
Message-ID: <80f2bf41-53b1-4409-8a28-da350d40d836@amd.com>
Date: Wed, 5 Jun 2024 12:55:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/amd/display/dcn401: use pre-allocated temp
 structure for bounding box
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, George Zhang
 <george.zhang@amd.com>, Arnd Bergmann <arnd@arndb.de>, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com
References: <20240604202606.697979-1-alexander.deucher@amd.com>
 <20240604202606.697979-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240604202606.697979-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0253.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: efe15e4a-3e09-4724-f1e9-08dc85806187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlNBQzE4b0VoRFhFMmlER3VHWitWMW1rUUdSUTNERTBFN0tmZFB5cHkrRXA1?=
 =?utf-8?B?eDBUTWI4WUZzR0FGMUI5VzNBWUpza05lazNJbS9uall5dTJ1Uks0KzRLOU1i?=
 =?utf-8?B?b1JuVjk4d3FHZVJZa2JOdW5zdXNIa2YyOTdhM0JlVmFwejI0VDYvYkJla0Jw?=
 =?utf-8?B?aHpzbVlOT1dJNThOSUdnb1NJN2xSV1dTNFdTdUV1dStkRk45WDJzV0ZodHZL?=
 =?utf-8?B?YmR3TGxZNFdYUHU2dHVxNDBFcFBzRnFUR2h5NlhyRldYRUhLV2xWTWZzMlI5?=
 =?utf-8?B?aWRmQXRDcytqSDJKWWRJRkJLT1dqd2tQRm81K2NrbG5VWG4rN050a0N1OFZG?=
 =?utf-8?B?b241WjF3SW5FVkUyOEVIRkdSR1MxanJUK0h6WTNaY3BUVGc1aWRjWU1RNlcw?=
 =?utf-8?B?eW9oVTRQU0M5RVduSmd6d24ySG5xOEo4OURFQWh3cURVWEd6QlBaU2pIT3Qr?=
 =?utf-8?B?TWxSYW5UQXp2U25QV3owN25EM2ttdHg3Mk1WaXpMQmJscUZ6d01mRWZheFcy?=
 =?utf-8?B?NWQ5S1drZGxmZG1BcnpiQll3eXhjcFdLUktEVVUzS1NucWQ2YkN3Q2kzMEp3?=
 =?utf-8?B?R3EzdlBHdTB4M3VXa3RuZTArK2tKYlJNNmJ0c1NMZ0ZnNysxMVhqOUxjSUtY?=
 =?utf-8?B?NlJ2Yk92TFUwQnZOb21XQUVjOWx2OEwvZEp6eE9vQk1DdzBLQ1VsbGIxNS9q?=
 =?utf-8?B?cHJFRC91bkF1R1Z1U2RwK1FleWljSjczMXRzbmNwSloxU0U3V2t4SDhCUGxX?=
 =?utf-8?B?TDNxN1dHMWJuLzFyVHdSanEwRGxRcHE3RWZJbFNLSDE3bkRLOGxoUHRsVzJ5?=
 =?utf-8?B?MlN4MFZaOVlmYzdCSVVtOUxwTDFiZDhwRGhZWTQ5RjFWMkdxVkpPaFFtc1VC?=
 =?utf-8?B?Ym9OREVnbHdjYnFSbnQyaUd5dkp5ZDdTYnlzTk4waEs1blZxdmNraFdhQ1ZZ?=
 =?utf-8?B?ZXdJS0k0WThsRSs3UFNGS3ZtcmN5cGhoN0lRL01LbWxRZnJWRDdXNkIvVTZN?=
 =?utf-8?B?cEdJSFFHTk5DNGxka3F6cWtXODlZQUhDUzhNTms5OUtuR2ZLNFNmUTZDMmRl?=
 =?utf-8?B?bUU3NWRQMFZHclhOQTlMV0R5Wk9sSnBRSmUzYkVFRTRCU2pIVGs4dEd5bVgz?=
 =?utf-8?B?RkI3VFJycElpWXM2YkQ3V2NBWU5oZ3VWOG9WSGtVVmtCM1NnYlp6R0k0aGox?=
 =?utf-8?B?MlU3TExaOUswUFFabEtsNTJFUFgzVU1YS3NGTHhNT09BcUE1clJqdXNjbUdm?=
 =?utf-8?B?OTJzaUtZQW9hRUQySEtDT0JSOWg1NC90OWx0VzRHSzBtV2ErdUNoUXBRd1p0?=
 =?utf-8?B?cFllR2htT2tJaGxWVlhLVHU1Ynd5dDNPNUlIcjRPNzZQeXZSTW5aK3NYcUdZ?=
 =?utf-8?B?N3lIQ2dhVUgxeTNEN052WXh5TlZsZDJUcWs4R1VGa25wSE5LMHRwazZDT2tR?=
 =?utf-8?B?Q3hmTU1aWnlVbGwrcVI2MnhPNzdaVThzTEhtb1h1WEhQOUVmWFFaMVo5dWs5?=
 =?utf-8?B?Si9MWHJ0OExXN3NBVnhia2JqamNjWVczNmZHdmt0K2ZUaFJ3Mm41Szd0Wndw?=
 =?utf-8?B?STdaYkNJWkVXYzIrYW9TMHNvZWFmTXFwQU00WFRMdlJZWG1VNG1OdXR4eUda?=
 =?utf-8?B?REh4cDI4OVBpU2pSVVN2UnFFTXcvTlRWZ2kvSUV2WkpYV01BY0dkWDVqakV0?=
 =?utf-8?B?VmlDSkhuVnk2eHJtRjRMbEx3eS9kRG02b0FsWnBLZGNTbFpJZzNEelIzZ2dq?=
 =?utf-8?Q?4xUGtO2Fb3rfqyxJgbLHs9RLC1a1VbNlP3cv3AO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWFmNzk2TGNFZkpsQ2VmVXFSNTZqUmhEMTdySE94WkxoQ2R5SGlZYUlrUHlF?=
 =?utf-8?B?TWNaYWtnUlN3VFBrL0JEUklVN3RqbGJHTWlIdzVOT3c5TUNzalBrbHJ2YlFN?=
 =?utf-8?B?OS9kUkNFRE1Ucnl3azRSV1RWT3pwZmVIYjZDTFN0RUpqT3dwSmNyNjNWQUtX?=
 =?utf-8?B?WWQyV2d3bXRmVjdCTmhlWmkyZU40S0ZhdGZGdHVtVmE3dzN3MUdEWm4ra1JR?=
 =?utf-8?B?U3ZtNFhLMkUvajF6QjUvWVNoYVUwc2loY081Qmtwa1dIczRKTUg1eFZ0QTZE?=
 =?utf-8?B?Smw2ZVBxekxLd2JoV3dwc2Z0Q2l5VWdUVG5LQ1JMUE4xZ0ZxQ05oWFFpUlhC?=
 =?utf-8?B?TytUOFBkR21md2sycFI1TGx5MHFKWitEVkYrTmlCcW9ZeGZ4Qmo5S0YyeC9F?=
 =?utf-8?B?VW5CdCt4WmpYdXhvUW0xMG5XVm9IYTI1bWluMVU0bC9FS1lET3YyVzA5UVhT?=
 =?utf-8?B?M3ZKMVVqQzVIVW8vanBCMjAyczVNMHBDNTdhaHZ2L0VLMHV1Z2wyV1JOeVRN?=
 =?utf-8?B?S09sY3BJbk4zeGJ1V2xGcDB2d2NMb2RuZ291NG54eFBaQ0FFTy9Fem9zcURE?=
 =?utf-8?B?M2V0VmtqamhVMWc5aHdlbHd6VjVnY0YrYnJJaENCeFg3Qk1jQmRNdXJnak9R?=
 =?utf-8?B?MERwWUNua1hHOFpDVFhWaEZLaW1jeGtPUnFlQ3dIOTh1NW5HT093N0dEdEt2?=
 =?utf-8?B?Nnd1WFlJTlJhdThRQjN2eWo2ekcyR05hQWtJVy9JNSs5RUN4b2EvZEtTZzBs?=
 =?utf-8?B?SXJ4LzFxUTJpSmwyL3U1b1d2VnhMbFZnL1FGVm03THo3VWVCZGVqeDE2MXQ3?=
 =?utf-8?B?aUhsVTJiWk5vdVdXdmtWcnhtMC8vUTZmTDNzQy9rZUJDRzlmVEdjSzIwZ2hU?=
 =?utf-8?B?VDdXakRDd2lXZTZJWVVkaE9aa05Bd0JvVmQxUjAvekRNcmdMdkRUZDFIL0ls?=
 =?utf-8?B?aEJuUFJ3Q0Y4RFBrbHZEVzN4Z3RqZGZVb3grNGtXNEdKR3hvYjJsNTQ5djVu?=
 =?utf-8?B?TTRoTUpSQzNJTml0U3B0M3R1emFDK0ZkdjArR3dNQVMxM1BWdWdsUjVFcEdC?=
 =?utf-8?B?VDFuY1pvOW9ESlVCR3AzZE5iUElCb0lIVGxHc2VkcW1TSENQai9TTDd5aFNj?=
 =?utf-8?B?Ymk2enI1Q2o5OVRVbGorbHF5M0NOU1F5T251N1FoaDRmdzUzTTVoMmZEZ1NE?=
 =?utf-8?B?QlpTRTJmZytYSnVmWXlSN2UzSWFWcVlza0s4R2p5YklLbFRUVk9wa0k0WnA4?=
 =?utf-8?B?bzlCM3B6QURmdWZoOWZqQlJhY3BDd21vM0xkWkZpM1FVSUE2eTJ3YlE0T0NK?=
 =?utf-8?B?UCt5T0dpRXV3d2ZEZTNNTGhJTEJzYTNpaHhTazY1TTc3Tnd0NGdrSUNKaEpU?=
 =?utf-8?B?ZVNvZEF1WXJ3VHlubU9VUm5QeHplaDJ1MWZwMTgxYjdmYjhQWDh6dEZxMEEy?=
 =?utf-8?B?YkppOGdrUUZWemgyNzZJTmF6T0hxMWw5Nm5SYnVjMWlGOFVSL2x4d2JnZmth?=
 =?utf-8?B?ay9wWVZrRjh6NVJtV0JTYnB0Z1JMKzhxZzNMVWlxVU80VUpUSGdBdVl1eWRx?=
 =?utf-8?B?dlY2dnVMY0lkWkp5Y05Gd0hmQ25NUnhnOE5zbjNwNGozVkFaODlJcExQNWtH?=
 =?utf-8?B?bmZsVVlqK21SZVhESXJOVzNRM05lckx5Wi9uWkJzVlZ5T053UjMzd3c1amtF?=
 =?utf-8?B?d1dHWlJZekIwKzVxM2o1eExEbE44MVJpUHptQWNjajRSeFlpZnFMVDVDazMw?=
 =?utf-8?B?aHFJSkE5RGM2K3NuOFZZOE85citiWVVjeHZLZTNKOGNEM0I2K3g0d3Uzcjdr?=
 =?utf-8?B?NHd4bEF4NUZxSTBHNUhyeFNKWjNrbGZNUWFDa0dXaVVQck5aMGs2dXZLeGJx?=
 =?utf-8?B?WkZVRUFtcDFPS2NOSEFWOXBMZEsvaU5MWTMxaHpmU0tKWmRodnZJWFBBU1pO?=
 =?utf-8?B?R3RrUnVFSkxGQVVMMzMxNmRkNnJNc3I5UE1YeGRMYlY4OWNaM3RCTGxZbktn?=
 =?utf-8?B?VXJPaVNld0x5b3Riczd5VkMzMnptYkZPb3VDRmNZTUZGb29JSUZnVm12aEww?=
 =?utf-8?B?QlJkbFpwbHlnVlZyY2taYVl2NHd0bDVibUtBZ1V3R1V6dWRBb0xhVkwyck1E?=
 =?utf-8?Q?dsnlkphDuMEw0q+tHXzirjGwS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe15e4a-3e09-4724-f1e9-08dc85806187
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 16:56:02.0214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYgnf8NVRHrrTL5k8U2/0rLLhb5yuq8XQJroOde4TEy0zeRzVNkoNk71V6XHJZ0Q+vwHnO40zdawOkTQLiIzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
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



On 2024-06-04 16:26, Alex Deucher wrote:
> This mirrors what the driver does for older DCN generations.
> 
> Should fix:
> [   26.924055] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> [   26.924060] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1022, name: modprobe
> [   26.924063] preempt_count: 2, expected: 0
> [   26.924064] RCU nest depth: 0, expected: 0
> [   26.924066] Preemption disabled at:
> [   26.924067] [<ffffffffc089e5e0>] dc_fpu_begin+0x30/0xd0 [amdgpu]
> [   26.924322] CPU: 9 PID: 1022 Comm: modprobe Not tainted 6.8.0+ #20
> [   26.924325] Hardware name: System manufacturer System Product Name/CROSSHAIR VI HERO, BIOS 6302 10/23/2018
> [   26.924326] Call Trace:
> [   26.924327]  <TASK>
> [   26.924329]  dump_stack_lvl+0x37/0x50
> [   26.924333]  ? dc_fpu_begin+0x30/0xd0 [amdgpu]
> [   26.924589]  dump_stack+0x10/0x20
> [   26.924592]  __might_resched+0x16a/0x1c0
> [   26.924596]  __might_sleep+0x42/0x70
> [   26.924598]  __kmalloc_node_track_caller+0x2ad/0x4b0
> [   26.924601]  ? dm_helpers_allocate_gpu_mem+0x12/0x20 [amdgpu]
> [   26.924855]  ? dcn401_update_bw_bounding_box+0x2a/0xf0 [amdgpu]
> [   26.925122]  kmemdup+0x20/0x50
> [   26.925124]  ? kernel_fpu_begin_mask+0x6b/0xe0
> [   26.925127]  ? kmemdup+0x20/0x50
> [   26.925129]  dcn401_update_bw_bounding_box+0x2a/0xf0 [amdgpu]
> [   26.925393]  dc_create+0x311/0x670 [amdgpu]
> [   26.925649]  amdgpu_dm_init+0x2aa/0x1fa0 [amdgpu]
> [   26.925903]  ? irq_work_queue+0x38/0x50
> [   26.925907]  ? vprintk_emit+0x1e7/0x270
> [   26.925910]  ? dev_printk_emit+0x83/0xb0
> [   26.925914]  ? amdgpu_device_rreg+0x17/0x20 [amdgpu]
> [   26.926133]  dm_hw_init+0x14/0x30 [amdgpu]
> 
> v2: drop extra memcpy
> 
> Fixes: 669d6b078ed8 ("drm/amd/display: avoid large on-stack structures")
> Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: George Zhang <george.zhang@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: harry.wentland@amd.com
> Cc: sunpeng.li@amd.com
> Cc: Rodrigo.Siqueira@amd.com

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_state.c      | 13 +++++--------
>  .../display/dc/resource/dcn401/dcn401_resource.c    |  8 ++------
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> index 8ea9391c60b7..06b22897137e 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> @@ -192,15 +192,14 @@ static void init_state(struct dc *dc, struct dc_state *state)
>  /* Public dc_state functions */
>  struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params)
>  {
> +	struct dc_state *state;
>  #ifdef CONFIG_DRM_AMD_DC_FP
> -	struct dml2_configuration_options *dml2_opt;
> +	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
>  
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERNEL);
> -	if (!dml2_opt)
> -		return NULL;
> +	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
>  #endif
> -	struct dc_state *state = kvzalloc(sizeof(struct dc_state),
> -			GFP_KERNEL);
> +
> +	state = kvzalloc(sizeof(struct dc_state), GFP_KERNEL);
>  
>  	if (!state)
>  		return NULL;
> @@ -217,8 +216,6 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
>  		dml2_opt->use_clock_dc_limits = true;
>  		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source);
>  	}
> -
> -	kfree(dml2_opt);
>  #endif
>  
>  	kref_init(&state->refcount);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> index 8dfb0a3d21cb..029ad7bd7b5b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> @@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs = {
>  
>  static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
>  {
> -	struct dml2_configuration_options *dml2_opt;
> +	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
>  
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERNEL);
> -	if (!dml2_opt)
> -		return;
> +	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
>  
>  	DC_FP_START();
>  
> @@ -1600,8 +1598,6 @@ static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
>  		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
>  
>  	DC_FP_END();
> -
> -	kfree(dml2_opt);
>  }
>  
>  enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *plane_state)


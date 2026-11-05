Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314FE606A33A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=ubfXREey
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C207E112C99;
	Fri,  6 Nov 2026 09:26:02 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn19010002.outbound.protection.outlook.com [52.103.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5091124F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 15:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVyEGMy9uoV9ZaNHHx4n8O/PPh0nTK6vUOOlT85SG8gWlFQ2yqlkpjznyZTg1mZB9Yg01nE0t+yAyeMFZCtEzJpmFzCDyGqMAHt7lb3OTPX0RrEfoaVrjQeiBi5EsqYaRppm3SH9OO+Me3DRKCZxy8MHUbv1/GoYed8cYJ6aItKmJAb+HE2lfu4njhYSJBRQ2dkscH82iJOy2v6K2d4PZ7CzGK1gOhfodX/iAZg7P2sHOkCl9+jbywNAEwyPkmUQCMmhqx0wQ96NccPfoMftrskc4RZ2NAeDOKL1qB7upSKvrUUUOGBsO8oBoyNeAR0oD+u6s4bMpQdvLr4c1dKNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXgjtV7eWmgSnzIV0FIFPjsL/Df7X1BHwf+e2ks3FgQ=;
 b=Lup0INTGKLp+0b5SkDgmlZzLjyUl51LYm/PxiM+9YK8I/aScnzX1qjBBWIWhUlmvyIRghcuaJGDEQ9yMmUfUNjivvRKQVyfBgqRpknJ7A01TbrGXXOaWa/4X/9jm1AdYYC9JAs63ji5TjpfsQk9s0+Qu2mnmxLd6TVcfmQk0Sh4XXTgYGFd0SIJLRF6n1JJ73A9Tqs3DEliotFdMAquEUV1yuEnucrtyj809xjyc4ZsZE9JncTtvBz2pA9tIJaEDU/0Mndd0810fCc+FC9FyitqkDfR97362bMd/aTUlJ0mxkJgUIQsUUEe1wDX+SwqSZlE46Adc/uPNrlrp0ZYvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXgjtV7eWmgSnzIV0FIFPjsL/Df7X1BHwf+e2ks3FgQ=;
 b=ubfXREeyufp7EfUF+BBKecB6gkF0pa8khtnl2pQjQG1LudhBE+krr2FIJoEtfngGW5p0zKrm4ARwGcP5I6QSOPJ29OgBqVkmT6nRBxpWfgpyDR+i6ZBAf0HHtv+O9HWCE5f26ROG7qCo1dAI0VCRPRZf1YBtsjkxoS7kKc5mzlwV3vrA944pROyX88I5YXkPkM1w4YnfOsuhJfZix/Zo35HSS29rqYhz+5bX0oZ2irJ5u7KaSwVONc83GtlqVddMrbd96XI6wjGsU3/0CUyzpILQuMb6+WfZMcFGaGpikhuCXV7SeAC6th+mRQ0njJXxv7fEJ3auWjZfSa3GYPVBng==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TY4PR01MB12750.jpnprd01.prod.outlook.com (2603:1096:405:1e2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:24:40 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 15:24:39 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: [PATCH] drm/amdkcl: use DMA iterator in PRIME address fallback
Message-ID: <OS3PR01MB102518A543E274E19D5FC0000E7772@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <Chengjun.Yao@amd.com>, <bob.zhou@amd.com>, 
	<Yang.Su2@amd.com>
Cc: <kent.russell@amd.com>, <amd-gfx@lists.freedesktop.org>
Date: Thu, 5 Nov 2026 15:24:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TP0P295CA0035.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::17) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <d2dd605b-318f-4dcd-ac66-007d639be54c@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TY4PR01MB12750:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c85e766-652c-4082-5ed2-08df3b50e850
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|22091999003|5062599005|24121999003|41001999006|25031999004|6090799003|23021999003|8060799015|15080799012|5072599009|24071999003|20031999006|39105399006|24021099003|19110799012|55001999006|25010399006|4140399003|440099028|3412199025|10035399007|25131999003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T29RSExSclllYklyVFUwc2JmOVA3NGJrNEVmK0EvODNCbExMZlFrWm5kNXQw?=
 =?utf-8?B?L2dURHRwU1E1ZmtPRkczVDhFMkhmZmVGTXVGWWYyb2t3UG1WdnRlV2dHUFlk?=
 =?utf-8?B?MENyR2EwMTVzOHRzZGpqamdvaGFIMEE0aFl1Q0lpdTV3THJXUzFsV0UxTUFu?=
 =?utf-8?B?Mk8zZmkrYUV0S3hIUlViZkpLRkRBVjcyTHJRdTFVMHlydE1YM1UrZjlqZUln?=
 =?utf-8?B?U1ZiaTNkdjlDMnEwWHBBUXRoUCtIYUNQT3lCcU9aWi9EUm11TDBqODArV3Z0?=
 =?utf-8?B?YXh1MGlLM2xYZ1Z4bDZHQW5xVW14c056S0hFUHNHN2UwYm1hNUZjM2pWRWhv?=
 =?utf-8?B?TzlKVkQ4U1AwRzNLeDcvZWRWcUhtMlZTSE1xeW16V0VUK3lnN3pYcWZHQ05z?=
 =?utf-8?B?d210RCtxQ0ZKRGc0VStFNkFzMUxGOG9BSEN4Y3BnT3FTRXdGaUNwbysrZldr?=
 =?utf-8?B?UDBhVjEwcHpMWmdSU0hUTGMyTXkrWTRJZTYva2diRzFPSVM2c1pockM1M3hE?=
 =?utf-8?B?clg2TFE2bkFOcytSVmM1TDdKK3ZYWGI3TDJSby9sVSswZGkrVTBjOWR6UElJ?=
 =?utf-8?B?Yy9HYlFOZjY2TzJYMGp3ZnJORG5pT1JkUTdpSlVFK3hYQ3Q1L3phS25zdUhl?=
 =?utf-8?B?UWdQc2hURVhuU1FRQjlmNmlwaDltVUV4Q0xncnU2cytQbW1GcHJjZVJoOXIr?=
 =?utf-8?B?K05XWGN3eGt4TXZSQnhITE1zQmRzRERXbEV2TTJjYzE3TFphRlRmaWFuT29h?=
 =?utf-8?B?dXhhdVNpbUo1YXZWL1YrNWp2cG96TEF0U2VYdkNuYWEzNElCbVkzdTJUcjMz?=
 =?utf-8?B?WEhtU2wrT1U1dFZzZzdwL2g4WU1jY3pORytLM3pqbWFpMzlETkl0WFlaMFpr?=
 =?utf-8?B?QjUwUzMyWVFseUcwQ0xiOUJvc2kwQlpSVHd4UWQrL3FzQVJxUGdHUWdpazBn?=
 =?utf-8?B?TzIzeUpMdjBWZVQwUlpCcjIrWWJzeEMxZlVxQkkxdUJUay9zaTUzckZObVJD?=
 =?utf-8?B?QTAzWkpGb0s5SkQyM2hiK0FkRWQ0VTBmTncwdGtML00zYUxaUktoKzhXcWJ3?=
 =?utf-8?B?ZzNDTUhlZlNFM1ZmaEE1RklWZThWaDdvS0xRUkJsSnRFSHV1czRXMTNWRm1K?=
 =?utf-8?B?QVFBVldhelFEb3FEQng4UnNaN0tZRVh2MFZ4Z0ZuMjVldzhnVStTc2lNL1Nk?=
 =?utf-8?B?MnE0Y0MreXZya0Jnc0lnVWt6YW1VTEtJdFFFaVEyZXpyOWJ0dC8zd0g3cEtt?=
 =?utf-8?B?ZSt5dnh3SUtuYU52MVVtSmY2Um9yNVVqWXE2UVNlVnVUQW9WNXc4OVpBS2pE?=
 =?utf-8?B?NWhGNHVXeSttdzB4RHFyYkpkaVE2QlBGMXo4YXpLTGg3TFB5NVhCYmppQWJZ?=
 =?utf-8?B?TE83YVFKNWpYODRUeWV5OGhVVUFHTFRNbkw2Vk02eG50aUk0a2EyZnByOG5W?=
 =?utf-8?B?R0hFQThIaU9WRU9LdGVnVkdmN3RROU5tOG9udDIwU1lLcGVraEpFZVZqZ1hL?=
 =?utf-8?B?WU5pU2NncUxZdHY5SHI0VXpKbnlKQWpRR3J6Z2h5WElLOS9MUi9LNDUxUHBz?=
 =?utf-8?B?WVAxSm9GSU9oRlpDU29ldlV4WmJmcFh0aHZGQXFWL3FHcjc2bldVcUJDd2pk?=
 =?utf-8?Q?TKcRtF54z87OLO6yt0n633l6Ejf5r1Pz3CQGkq+5cNlk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3JvMjljUTNuRXhPbm5DeHpKaS9tdVpsVG5KRGdEbmpma3BReEMvU1JhMzl1?=
 =?utf-8?B?WVI5M1o1TWI3TmY3MkduWTUxcisxTmNSY3Q3SUV2TjNtNUZDZTNWdjlxSDd5?=
 =?utf-8?B?YkZZOXNCSWRZY3dkMlNtSjI3dnBmZ1NraVc2dWU4a29JcWFHckxoTzJiYTRt?=
 =?utf-8?B?WmVSNVB4MUxmUEJhQnRqbSsxMUZ4eVdoSUw0NFg3U0dDMUg0bnluK0hPK09v?=
 =?utf-8?B?eFArYXBPVThFQ29EVmJmditYTnNqaGlWMW1aUUNxaUZyalFzQ3VjVG9EbHZh?=
 =?utf-8?B?ZmFESmNPYSswckppdzRRVDVmdGY0U0xhaURMM3dBemJhOU8wT21kZEMra0dD?=
 =?utf-8?B?Y3plMzlpZ1ZDVmJXa1BpaUJVcmlXQ3pWMkNtVmhRQ3BxOFcwOVV4d2FzZkY3?=
 =?utf-8?B?MXVVcnFGSkVoaWZPcTVnOFVWL1U4WlFqZHB5VGxSNXRZSlBMM1M3Nkg3M0lD?=
 =?utf-8?B?bWE1ZU4wd0YwUVJDSlZmSmUrV3lVZWRuc2FLbzJzNXUraEk0a2tlRXlWWERX?=
 =?utf-8?B?TUthenZFMER2bmV4WmNLZ1IzN3JqYUpVYzFJcjJ2N1ZydVBVWUtON2ZQTlMy?=
 =?utf-8?B?RnhTUDA0Y0gvSkdQWkpJeXk1djJvTG52SUJoTUFqM3NlU0RWWkdGdTJRRVZU?=
 =?utf-8?B?S3Y3SXVUVXFhZ0hRVitESmd2ZVBEekRGV3VudG9vM1ZKT2k5bmc4TFYyWXNy?=
 =?utf-8?B?UmsxaDVZQzc5UE5ZYUxVcVN5OXBGR0tFa1pJeTVVWE02eThtTFdQQmcyc0pP?=
 =?utf-8?B?SEszekZRcnplVjdpN3NySXE2Z0JNTFRSVk5paUJTZjJjSlJXcDRWRGNTdGtG?=
 =?utf-8?B?REZUSlhnTjBvZ0JMMklqU1lKbk1JMnpyYTJsZThZclI3WWtlZWEyRzBXcEUr?=
 =?utf-8?B?ajdMbFR2dFo1bjVtVjB1RHFTeU1vbkJjUHdQM1Z6dytTenZZalhucEkzRkNr?=
 =?utf-8?B?MTU1MXh2ZnFkbUhYelJ2enovSEQxeEVuUjljcUtrTkkrMi8wU2NvejJZVC9q?=
 =?utf-8?B?eXQxUU12dzZZb1dOeCs2OFBaQms4bytJemRlS0xCN2c3d0RtUXo0UUtSYXRV?=
 =?utf-8?B?RTh5VVh5VXdwMVR5eFg4RHg1U0xXa3V2R0xRR1RHZ3RBcUJzSnFQVDc2VSsx?=
 =?utf-8?B?UGFZRlQyVENyQkVtOTZlVXl6WGhIeVhzNnZNYnY1aEsraldCZk9aV2lkRnJQ?=
 =?utf-8?B?dGdEN0hYYWhkWFNBN0NIbTBaRFAzeWw1VHVvTFBpK1JXc2RPdTd2T3I5ekhi?=
 =?utf-8?B?QjEyWjhRRUFNT3drUFBwN0NvL0hMSmo2N3FTcThLT1BSV2hTdXV1ZkFZSFlt?=
 =?utf-8?B?V0RyRkxmSGJPRGpTdlNwV0x1bDlaRVdZUjVsblUrVWMyRkNwaXVRR3R3Y1h3?=
 =?utf-8?B?a3pGOGRXZGI5djV1N29TS0g3UnVyNit5WUxQanU1ckk5TlNWRGVDbWpob1px?=
 =?utf-8?B?aVg1eWE4MFhiL0FZUk9TNzRaM21pZG1kNTZCUnU0VkV3S2lqLzZvVEpTWGx4?=
 =?utf-8?B?blgrUlh6cGtUWGlGSk96V0twaHlsQk1YYW1YOXFTMXdpTGxNMVExbm94Q0Ns?=
 =?utf-8?B?THBSNlVKU3BCa2dKR2JFdzZGZXgyRk81ZEpPM0NqTnpRU0J0S1kyV253dkVS?=
 =?utf-8?B?ZjZNaldNZktUVTVJV1B1ZWFTc0Y4eVZwMVVXS2o0Nm5NdWZibHc3WTRCRkRQ?=
 =?utf-8?B?SnYyUlI1ZWRUNXg2VmhrWng1dWxsVzdmUE00NmtNeVBxUlBIeU9QVnVaanY3?=
 =?utf-8?B?dG9tMzNYbkpUWjNIWC9iUXAzMW83S2VPRjJhZDNoNnh5ZWNnQ2I0cTRIZEZa?=
 =?utf-8?B?T0dSK3Fha3E3dnpQMTFNNk5jNWhGTWl3RXhBOTN5Q1Q5U0c3dXgrMTR3YzFx?=
 =?utf-8?Q?soIQ5YYeOBERc?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c85e766-652c-4082-5ed2-08df3b50e850
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:24:39.3093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12750
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:26:02 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The KCL fallback for drm_prime_sg_to_dma_addr_array() calls
drm_prime_sg_to_page_addr_arrays() to extract DMA addresses.

Older implementations of drm_prime_sg_to_page_addr_arrays() walk each
DMA address range using sg->length. This assumes that the physical and
DMA views of a scatterlist have identical layouts. That assumption does
not hold when DMA mapping merges entries or when only the DMA view is
valid. In such cases the fallback can leave DMA address entries
unpopulated while still returning success.

Use for_each_sg_dma_page() to walk the mapped entries directly. This
uses sgt->nents and the DMA length of each entry, matching the semantics
of the upstream drm_prime_sg_to_dma_addr_array() implementation.

Tested on Linux 5.4.18 with an imported DMA-BUF whose mapped scatterlist
provides the DMA view required by the importer.

Fixes: faab963d4035 ("drm/amdkcl: fake the drm_prime_sg_to_dma_addr_array")
Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
Hi,

This is a KCL-only fix; the upstream helper is already correct, so there
is nothing to send against amd-staging-drm-next. I first opened it as
ROCm/amdgpu PR #231, but that repo is a mirror, so I am sending it to
you directly as the commit history shows you maintain KCL. Kent, CCing
you as the contact on that PR.

Kernels without upstream c0f83d164fb8 ("drm/prime: fix extracting of the
DMA addresses from a scatterlist") are affected, and 5.4.y still has the
old code as of 5.4.302. I hit this on a customer-pinned 5.4.18 kernel,
importing a DMA-BUF from an out-of-tree PowerVR driver: the import fails
without this patch and succeeds with it.

As far as I can tell, ROCm-supported kernels do not build this fallback,
so this is not urgent. If KCL review is not the right place for it, or
these kernels are out of scope, please let me know.

I used an LLM to help investigate this and to draft the patch and this
note. I reviewed the result and tested it myself on 5.4.18.

PR: https://github.com/ROCm/amdgpu/pull/231

 include/kcl/kcl_drm_prime.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/kcl/kcl_drm_prime.h b/include/kcl/kcl_drm_prime.h
index c55e8d05c031..5eff9102aa18 100644
--- a/include/kcl/kcl_drm_prime.h
+++ b/include/kcl/kcl_drm_prime.h
@@ -12,7 +12,17 @@ static inline
 int drm_prime_sg_to_dma_addr_array(struct sg_table *sgt, dma_addr_t *addrs=
,
 				   int max_entries)
 {
-	return drm_prime_sg_to_page_addr_arrays(sgt, NULL, addrs, max_entries);
+	struct sg_dma_page_iter dma_iter;
+	dma_addr_t *a =3D addrs;
+
+	for_each_sg_dma_page(sgt->sgl, &dma_iter, sgt->nents, 0) {
+		if (WARN_ON(a - addrs >=3D max_entries))
+			return -1;
+
+		*a++ =3D sg_page_iter_dma_address(&dma_iter);
+	}
+
+	return 0;
 }
 #endif /* HAVE_DRM_PRIME_SG_TO_DMA_ADDR_ARRAY */
 #endif

base-commit: 820212794d184710298efcecce42c0215bfc9c6a
--=20
2.56.0



Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84575606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=IgBFY7ld
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B05F10E312;
	Tue, 10 Nov 2026 01:44:13 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn19011038.outbound.protection.outlook.com [52.103.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164F610E5E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 01:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXQiedNHfgd5uDDUgL80l43dp7/ufzbobw376Bdhp2VNxaIHmDv0tsYvYLzBVHJTrIqBScUNjV4j59C+UpkinIiwSczwu/7Dk4JNtIunsQ+3Iu4H4bxexvpIDzjXyVeKluKf60D6VcvmAIvd2nxPQjvdhVZUTNId8BLt252GZsCNEzhY2CNLYFWyoTQ2dxk5ZgD8dseAnqsYrFyXcY7Vp1HTzRqVKJi3DLbBw+VurVjkZ/e/zx/p+ZQRtNfXYEYqmcDLa4InvvB/G2rMcttiU5F/xJ8FhHqCaic3JLu6ukDVp+0+poAdXGSArTTydQCkUTX/BtxwfE49yX7IB+LptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxwrUdaojappybQKQzeacuWPKtoDK5/syxXRjkM8Cbs=;
 b=eNgzcGRg9+3AtCFZbTOj0Eky1KKcvniuDKfKpn9cjnCAddydkmkP7yQPDQziskiu06cLKA35GTyMgKZRCnlBjoabgtrouVQoZCbbVCcNxQB0geGn9qq1+S7X6mKRcapqMtJJ8gA9VfrwUMteTEA681lPSB0Ty6VFuqTgkwr4QCkcJt5tLHFFmCQQpLo5VXPy1ebbPU7fQ88V3NXV+zkXT67sgMT4S7Xt2M+6PxD91LFgOGeW81eXhHDQLDuOqsvjco6CF/J96plqeqW4/hsf68ZYMYvZpNmQ0FDpksjr5OyHEHyw4i0/Ns0Hs9WPtSwBWk+Wisj/vAVKuZbcgeLr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxwrUdaojappybQKQzeacuWPKtoDK5/syxXRjkM8Cbs=;
 b=IgBFY7ldc4XVs7D+GxFNn/0RmyFaIdxCQIH7RGJWnOv9azBuVCcBMbDXBC4zTUd2iX8sCjgIEAaBlTkHbUeWbWIY3Lo/VRIbl+wrRvJfBFweCx2jisIvOQ6JMShjNPF7NjAhL5HuhXqZIkeDb72xHkLdjIXlf8+w+KEqcI6NiQlNrPI/XjBAA9R2zElRmB+QGDT+fyQNKqDjb7StcfgitIRAox+4pO48Qn43ah3rcFH7bibyaQSWqodem4urhYvMezYxG42OXhCr5OX5weHxNRu5m8HyzjtoCBY4IEpO5ib/1U4oTGlkSzgSBIw298GeQSq/KsGYdPl1NkwD+c1wlQ==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TY4PR01MB12957.jpnprd01.prod.outlook.com (2603:1096:405:1e8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 01:44:02 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 01:44:02 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: [PATCH] drm/amdgpu: unwind module init on failure
Message-ID: <OS3PR01MB10251D938EF380DBD083891F5E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: "Alex Deucher" <alexander.deucher@amd.com>, 
 "=?utf-8?Q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>, 
 "Kent Russell" <kent.russell@amd.com>
Date: Tue, 10 Nov 2026 01:43:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TP0P295CA0037.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::9)
 To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <7bd70283-2faf-4c05-b474-ab2af942ed6d@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TY4PR01MB12957:EE_
X-MS-Office365-Filtering-Correlation-Id: bc24bd9d-6ee9-4500-6e87-08df3ecc18bb
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|41001999006|55001999006|19110799012|24021099003|25010399006|4140399003|22091999003|15080799012|24121999003|16041099003|6090799003|5072599009|23021999003|25031999004|5062599005|40105399003|53005399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnpmN0NMOWR0N0tmZWsrREkzRnp4enhrRHUvTUtOTXduTkpZcUZEY3czTWZT?=
 =?utf-8?B?bzZiVklyazI1clZCVU9yMEljaHFMaE5NUTlkZ0FZQ1JyZkNoV3E3dzI3NVZT?=
 =?utf-8?B?OUphUGlUM0FHemZlYk9IVFRsUTNQdEw0ZzVsWGFOdnN3TFVPczJGYVV6SFkr?=
 =?utf-8?B?TGRUMytJd3krRkJJZFNSNzcydXR4b1BkdEM2U1hoaXp1Y1FMOWM0cG1MdUxy?=
 =?utf-8?B?dXlFRUlTQklHL3VQK1FqSm1oZ0wwdSttUVRMWDZzK29jc0orZzFMeHh3a3pG?=
 =?utf-8?B?RVB6YXk1ZTg5eDBka3Z6RnE1OTJyN2l5MmdobnR1YW5FZWlhakYyYnRlS2Rs?=
 =?utf-8?B?Vy9jTnVBL3ZobUlack5KRE1ZUUsyLzNhenM5Vk5URHc0TEVNd0Z6U1BXaVZu?=
 =?utf-8?B?NEQvT29MMi9VOEFWQlRVT1hlY2JNaWU2Nnk0eDBqaGdMNEFNYldjRGZIdHpG?=
 =?utf-8?B?K0tJVXd4L3dxQndVeTNMczZmeVVoQ29reWg3WTNreXh2UGdBcWhUMDdLY2pz?=
 =?utf-8?B?bWdUWFhGMmlxTzJwVzFObS9Ba0xLbWVwSUpqMWh4MStwQ1VmRUtWaXFZVUJu?=
 =?utf-8?B?UDRiejJTeTYyNjQ2ZVIxTTZreitmUkZIMzFrY2ZRa2htS2VnOG9SeWU1bWFz?=
 =?utf-8?B?bEJHWnIvQktiOTRSMi9Pa2lsSUtRT1VRM3FkWUozZXRJdVRhMFBYZ1c4eFFi?=
 =?utf-8?B?b1lxbGV2RUY1WWxGV1VCbzgzNUNrVnA1cFVKMWFTa3JJYk1rc2lDSFhNT3hO?=
 =?utf-8?B?RHB4YzZqYWFsT0o5R01wcWlnMnVwd2YrVGk4MFVZQnJ0UXVMYU9OWmV2clZt?=
 =?utf-8?B?YjBkRlBURWRvMFZzU3Z6TUdJRkZhOWs3Wk5paFA4eGFZQjBsaDFsbE9DNWJ6?=
 =?utf-8?B?ZDE5R1FoNVZYdkFSSGQyYXJWdFNDdHJKUFNuT2dPMHdDTDR3MlhRdzNLQi9i?=
 =?utf-8?B?NjA0QlBQYVBjL2RHNldCOEk1VzRWODVFeEY1VlplbFNPZ2VTcm52YWN5Vlll?=
 =?utf-8?B?RnpRT1RiV3BzaTZOMkZwV2pockdnR0tMcjBNNU5laSs3UzFwL1MzUmUvTVlX?=
 =?utf-8?B?dFN5TlY0TFZrSk1iY0h0NWlQRGZiQ2JEVnVYTEw2V0c4dEE2VEtXWFNoSlI1?=
 =?utf-8?B?NDVhdUo4YUFlVk9Sei9iaWhLTDlCUWRvbW5iSWZtcVk1YkkzazFFYUpGOXNB?=
 =?utf-8?B?Mm56WXZ6eTgrTzIzRzF0cmJTUjdGNCtEbmVoMHZOdi9OOGxIQnNDVEpob3dJ?=
 =?utf-8?B?NkxTQ25qSkttcDB1bHFKbnFtYkkrNGxkUDFaZFVGbjY1QjFIZzlTbmt2UFpL?=
 =?utf-8?B?RExDZkhDTFJJN2xrZTZMSkdZbkordlZFRzhySVpZRWdtdk1uT2tjR3RjNkhC?=
 =?utf-8?B?bzh2eG1Uc2xoanFqQVJIQzQ2cUZaK0l1UVVWNmVIb3k4U2UycFdKdWs5THVK?=
 =?utf-8?B?ak05cW5tSzZUY2E5MStINURoNVR1SWdERTkyd1cxM1pkYTN4WFRZNGJ6alVR?=
 =?utf-8?B?azh0T28xVHF1SDYydlFQOTNIZVNWZDJtZi9yM0VaU1VjS2lkc3hSWStGM0My?=
 =?utf-8?Q?Y071kzHlBmPfbm89kpvHczQXyI+dnomPCn/Tp8L7DPVZju?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk1rN1grWVhITGR2NUNGY25yWTlqQWJVU3VXQ3pnaTErLzQ0MHFyd1V0ZFh3?=
 =?utf-8?B?Rk5QTVMrelhCcXQ0RitvemtUenRob3hqUERIcmxtZFR0SzduL2hJbFRmRTJj?=
 =?utf-8?B?TXN6bGt6T1ZZL1dvOXpxSkRUTVhvQzg3cERtYnBucTA5cGdiay85dmtnWE4y?=
 =?utf-8?B?MnN2MFk2cnQ2SytjdG1xVWZtcWZwNUYvNGxoRGgrcGdjaml6N2R2Qklua0V5?=
 =?utf-8?B?RUwwSVhrU2ZIZW5pa0hVTWdDYTZ1WXJRdFFmUit5ZHY5Y002R29nQ2JmVjY5?=
 =?utf-8?B?eFpUOGVwdzNUY05ob0xidXBJdUJQWnhxRVZkUlFoenpTNFdzbCtrYXVhclp2?=
 =?utf-8?B?dmFvelcyUGtQeUc5TS80eWZrbGtNS09wUlQzN1VLNlphSkRjQmVTZVJhc1BV?=
 =?utf-8?B?WDJ5WnBiR1A3OGJOVjlNSVJNMXRrc0xTZkt6cmhNdWdrM2dla2dSRHQ4bFFZ?=
 =?utf-8?B?N3BJS2p6SGIrRVdYb2JqVUZ5clA3Y20yMm91TGhFNS92L09kWmxCeno2QlpP?=
 =?utf-8?B?cmpDZmhCRFBCaGRqcGg0U1BQWDFUc2NUN0VFV05OK3g1TG1POTkzbU5aWjBL?=
 =?utf-8?B?MCtpMndtcldZbndOL0lpc3pQWnZBaTBsYjk1bmVIeHpQTkVnMG8rZFlwZU0v?=
 =?utf-8?B?UXhVelV0azc4a1ZFdDg0V3EzSS91UTAyNG1KK3BrT2R5Nkx2YXRDQm83c0ZP?=
 =?utf-8?B?bXN2NlNCalBua0ZkeXlqckdQR1hZK2JOZkJ5dGtKaXNnMDBnVVZkMlFFTjRL?=
 =?utf-8?B?aUFnZzVLRnBRL0dvQ3ZNa0tpNThqRXZZQzlZbmpRaDBRbmtaSUVXMGZyYmw1?=
 =?utf-8?B?a3E5R0RzOVRGZDBvSUxsMjlWcjFSUlhmWmNKZzJ5Rk5EV2JPZmdKOUlxR1BZ?=
 =?utf-8?B?TG9rc2NmanUwUmcwU1M5UmNaa0RpNXdjL0F4dHlTMEdpYVgwSTk0MFlkNEx5?=
 =?utf-8?B?RUN5Mm1OdGkyVERXRU1MK2hGdFF2SnlLZC91aUtzZTNIK1RUM3Z2KytZc1l5?=
 =?utf-8?B?U3RFVHFrVkhUdWpXWWgvWEpNQWNuRUJlUytJTXN2QXhpang5MXlUa2NYcERr?=
 =?utf-8?B?Q01JeG5JL3lDWXlYRmxQRXNweUg1TDI5Q0RoREhPVzhQNjFqRzRKSk1iUzRy?=
 =?utf-8?B?V3RmWVJ2eC96RGV4aDh1QVlXMUROYUdwZ0VWL2FQMFJLYmhiTTQySnpGTU5I?=
 =?utf-8?B?SUpjWXRYM2NQNmhDV3VvbkZVZW5qZGgvZnVadTBlK01JRDZaZHp5NkI2WE5L?=
 =?utf-8?B?VmVpdlRDNGt0MHRZMjM0SmZpUnJNT0IwdTcyNU1YV09GODE0RDlONUZGT0hD?=
 =?utf-8?B?V1NZbkc5TGVTRlE0MVE5Y2doK0pXMnZHS0I5R3owQnZ0ek1NTVd0VkkxM2tl?=
 =?utf-8?B?NEJYNTh0L2M4YWVRSiszVFRmSjR0ZkYzTHBoT0FoSHlZbGtGNWFTRVAvamdO?=
 =?utf-8?B?YlVXZTBtWlREVUNqMFp1TU9aN055WDVxb1NWUDYvVHpmd08rS3lqdFc2OGg5?=
 =?utf-8?B?c2VkdlV5MW5Xckl1RkZVRFpDeEZPYjQ5UTRoOThSWmh5YWNkSDdjY1RYN3k4?=
 =?utf-8?B?MlBJZGtQdXkxMFZLOWhRbHg5Y2hVMStrdWtMeUNCMW02TExQd01EcDkwUEhn?=
 =?utf-8?B?WUY3alpCbnpEbGw5cDM3c24rUkI2YjlybVlqTHZSZHc1QkcvNE1INVZodFRP?=
 =?utf-8?B?UzFnanJtVTBxa3lNWVVCODdVQ1B3Q1lTdW5lVWM2RTE0dmVXcmxQbmgreCty?=
 =?utf-8?B?d1plV045UXErMmtibVozQTNnQ0dHNWdpMVp5c1pYT0g4UjhDdENXRmhadVIv?=
 =?utf-8?B?bmRVUVhxRmkvSXl5NU5OZXROWndpSVkzNjM1MVpROTg0SDlyYWQwbVEvc01i?=
 =?utf-8?Q?uLOaaSUhZp7Zt?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bc24bd9d-6ee9-4500-6e87-08df3ecc18bb
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 01:44:02.2045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12957
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_init() registers the ATPX handler with vga_switcheroo and
allocates the ACPI XCC/NUMA info before it initializes KFD, but its
error paths do not undo any of that:

- when amdgpu_amdkfd_init() fails, only amdgpu_sync_fini() is called;
- when pci_register_driver() fails, its result is returned as is, so
  KFD, the ATPX handler, the ACPI info and the sync slab cache are all
  left behind.

A failed module init frees the module, so vga_switcheroo keeps a
pointer to a handler in freed memory and /dev/kfd keeps file operations
that point into it. A later amdgpu load cannot register its own ATPX
handler, and vga_switcheroo_enable() calls into the stale one.

The KFD path is easy to reach since KFD init failures are no longer
ignored: kfd_init() returns -EINVAL for an out of range sched_policy or
max_num_of_queues_per_device module parameter.

Unwind in the reverse order of initialization, using the same calls as
amdgpu_exit(). amdgpu_amdkfd_fini() is a no-op when KFD was not
initialized, which covers the ignored -ENOENT case.

Fixes: 4259a25341ab ("amdkfd: Only ignore -ENOENT for KFD init failuires")
Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 72b3710..322c296 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3220,7 +3220,7 @@ static int __init amdgpu_init(void)
 	/* Ignore KFD init failures when CONFIG_HSA_AMD is not set. */
 	r =3D amdgpu_amdkfd_init();
 	if (r && r !=3D -ENOENT)
-		goto error_fini_sync;
+		goto error_release_acpi;
=20
 	if (amdgpu_pp_feature_mask & PP_OVERDRIVE_MASK) {
 		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
@@ -3229,9 +3229,17 @@ static int __init amdgpu_init(void)
 	}
=20
 	/* let modprobe override vga console setting */
-	return pci_register_driver(&amdgpu_kms_pci_driver);
+	r =3D pci_register_driver(&amdgpu_kms_pci_driver);
+	if (r)
+		goto error_fini_kfd;
+
+	return 0;
=20
-error_fini_sync:
+error_fini_kfd:
+	amdgpu_amdkfd_fini();
+error_release_acpi:
+	amdgpu_acpi_release();
+	amdgpu_unregister_atpx_handler();
 	amdgpu_sync_fini();
 	return r;
 }
--=20
2.56.0



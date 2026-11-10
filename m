Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE59606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=K51OWuID
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E49110E2A3;
	Tue, 10 Nov 2026 15:15:29 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn19011025.outbound.protection.outlook.com [52.103.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDCE710E2A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 15:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVYeBauJBroDPySwmorlr3NOZ6SHEiNsjOHNBeDk1fk/F/EQKQnBZU/ZQj61rS6aOsntDFc6Dgnrj1d/bK39aFXsunk7DHWzWRJdFrArExryJ/JmMgXrfHhSA0VSW/lqtXF391mHeGN8bxXqqDoU3ZPQ6SGa0w8kG7zglH0lnBu21LF/ZtcR+1Ath2jvNhwF8IBwa/BpbjXYfwFBGXLV0TVIsBTWRxTeVuDxYEml7XG+B+pCK4MxUjjJiwqCqknfDBvQSpTyXx/1EINcwgRT9ik7DuL/lwDhYuDdjjUcbS8ykOAQ4JFB+KbhWeorM/r1pefrQsposnTEtIKyZvRndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCDumYtY3bEwrKmquUwQNYAgsRLWQZ0q4GgSPJ4JeLA=;
 b=JeLSfXyueBZ4e1LCLSMMLCKXAyCS0ICV/3Lpp9MwVb2wSptnMcIy+hCj94306IAIlYojQ8Sj8wo2NBG3g0BTc2IF5GnXNc9Joy6rCzOAyTYkOsJDHdGZwWzlzvWpksXde7scEAOtZalAIJhehVXT3wvF+gR/qjgtL2Z5yWD6bho8TPKzYduJh8r0ucb8Rode3VjQkT7KHmh3zZlDPLvM2dIrf152HGAGeVjGYjSG+ir9mRhS1zi1HOoeXwxcsKzEjyq1i9cZH0koMpX4RdjQ9U7fKM7C/xNkKtzH08GnDlIzZgvimqTxQVEIMRFXEHdKMeErcBprXESMd9sfp9Gzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCDumYtY3bEwrKmquUwQNYAgsRLWQZ0q4GgSPJ4JeLA=;
 b=K51OWuIDZ1Louw9ie6hE3CkZZtPzSOBnGvV2pvOCPYRPRNuWMxLAiOw6SKzxUAJQ1uAX+lxLn6u/HE5gBVTqnlSES1eE+1ZvI04nQrprDfHG6Oqa2Cgi/JxciEUkVncnoGRbDaePShGVGfUrjmUiyyzaOIC/q7/5zuON4jKZIfbjXUE2YA9kfOmWWpnSKKJCXm0vZ/EhbtakVeYU3tHllcyBObGBTtqW4/SiNR+rAYnaSMjR7ATPcGYJs/yk3V+2xoKulYalhPLYdBhmBNEGYAPWedTMMBANWsTEAprXacm3w66JEgOfzEzIB8kevK40YsNMkBUxAxWREAkjWvCAZQ==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by OS3PR01MB10090.jpnprd01.prod.outlook.com (2603:1096:604:1e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:15:18 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:15:18 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: [PATCH v2 2/3] drm/amdgpu: undo module init in reverse order in module
 exit
Message-ID: <OS3PR01MB1025181BC3BDB659AB8B03C96E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: "Alex Deucher" <alexander.deucher@amd.com>, 
 "=?utf-8?Q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>, 
 "Kent Russell" <kent.russell@amd.com>
In-Reply-To: <OS3PR01MB1025124AAC2F9492FCB206AC6E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <OS3PR01MB1025124AAC2F9492FCB206AC6E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Date: Tue, 10 Nov 2026 15:15:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TP0P295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::17) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <97856273-cfd9-4d3c-842c-8e56e3dc114d@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|OS3PR01MB10090:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e535b3-220e-40d3-837c-08df3f3d6dab
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|23021999003|24121999003|25031999004|22091999003|51005399006|5072599009|15080799012|19110799012|8060799015|55001999006|24021099003|25010399006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUNDZXlWajJMS1hnUHc3U2NsT2JJVzF6d3lGcTZIVi9XRWF3ZkNzRkFjamEz?=
 =?utf-8?B?SGhhQlQydGszTHJYRWY3U3JBK3pja2FhVkZidnJvNkpHRGN6QXBFZ0IrNGtV?=
 =?utf-8?B?SmxDQ25tNjl1NEM1WUtpZ1BjM2tGcU9LekoyV0luMjBFV0djL0lBOFFhSW5v?=
 =?utf-8?B?TFN4L3R2Uks2ZjFWb0RMTjJXNk1ydndTeFJBemtKZUxCVEVqRnhZRXlyUE1Q?=
 =?utf-8?B?YzlFV3kvTmxJQ2hQUEN6UlZMVHN0UFR3UHhtOFppNmNQSWgvdk5LMnRrSDll?=
 =?utf-8?B?N1ZWU2MyVytoN01JL1c0aUpyM2pkczducmdjaWoyT1hVcUdNUittY0dvL3A2?=
 =?utf-8?B?UVlYdHkwZjI0aW5SU25TL092NXdybllhQkFWN051R3B2SFMreGlqMlJvT1Jr?=
 =?utf-8?B?bHp1ZFZrMmY3OU04RkE4UjFFTFdoa0ZOS3lnOVBxOU5ZUG01ZkpmZ1NEMy80?=
 =?utf-8?B?enZ2a0NORCt1YThFOFNOellHMG9WeGdNeGVBWDRQZkErNEhDd1NPTnNMbzQv?=
 =?utf-8?B?VTU5cFZ0anRVamJlUzQ2TWdhNGNiQmdYblZoYU9DZjVCTlR0RUtGTTBvcmJK?=
 =?utf-8?B?SEFlK0R5aU0rcW9wWUVWVXJydFdSOWRScmVtcStEQUxCeUZVTFBNblJqbTVR?=
 =?utf-8?B?QWI5cENyYjR3cEVnMk12TVpCdDBLKzlkQXZTb3dMMGFiV1g4cDZVY3VQSTAw?=
 =?utf-8?B?bCtUbjRSKzhZRWc2MnRPMDM1NERtbmNKY3cxeUFCdEY4dW1KT3c2cmJHQjZp?=
 =?utf-8?B?Qm9UM1FIWW14VGczUGNlNnVwekcxN3FEZjBIaEJ4NkdtaXFudytodFdqdDJ3?=
 =?utf-8?B?R3ZqQ095K1JNdWZTZUxJREF6VkNHbUtzanVwVDFsYjNzUnQ2R241ell5WFUr?=
 =?utf-8?B?eXBIekV3WVNSQkF2ZmFsUWFwNVdzdlNLNXJEUWlXWktpdTF0WEF1QzQ2MXJX?=
 =?utf-8?B?aHovRm4zTE4wOStmNFRPcWIyRERsTUt3UWY2SnFYRStoZTZhaWpkVlRRZ2s4?=
 =?utf-8?B?cmhldjU0aG03YmpVSm9IL0VVSUhJUGlSanlPME4zcWpjK1pSM2FGVFhiUytq?=
 =?utf-8?B?VmQ0V05aNE1nWW9KZUdNZGZxekMrZkdaNU9Mamw4dURXWjllbWY1ajZDakpz?=
 =?utf-8?B?Y3B1dEpxMUg1VFl1RU5VWElxZzFQTEU5SW1ybWJWRFY3T3JoTVp0cjN3ZU12?=
 =?utf-8?B?U1ZJdmRySkxlR0gyQk5SRHJnemF3aTlGZ2U3TldiTHBxMlJZV2JWcnNYZ1E2?=
 =?utf-8?B?enR2UzMrcHBGSVlsVk1VQ3VJeEZmcmFlY0VSSm9vKzZwM1dlN3hpSmE2TEtv?=
 =?utf-8?B?TnVoN3ZKSjY2QWlZa3ovWWZaUHJ4aUZ1Rjg2dEg4SXlZU0c2UHVaSkM0eTlF?=
 =?utf-8?B?SVBtYjlYZjJXZzB6eTVod1dTQ1BxeHVvRlJKOWEreUpFdU1qMFBUKzJLSHF4?=
 =?utf-8?B?MC9NdWNoVE5LQlU4L0hXdlpvU29tVGxuVEJIN1hCcnVITEtzeE5HSVVnWW5j?=
 =?utf-8?Q?WjDg38=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRMVUJpUFArUkR4NEs2dmhLRkVkOVM5bjlMMEtpSUxYK28vd2RWYTd2S2Yy?=
 =?utf-8?B?TElEYW9SNDNleDhBRFd2djk1VUliaGdCUWYydzdwMHY3dGh1dWI1SVJMM2Mz?=
 =?utf-8?B?OVRWRWJML09qcEU3Z0grcmduR295QzlQMmhJZGFwVDNoNGI2UUxVWVlqbXpl?=
 =?utf-8?B?d0UwRGcwaUlUb29EUVRzSjNBZWw3RnkxNHVQUWh4cTI1SlJxTFU2MjNjeVNH?=
 =?utf-8?B?VlpTQ1pGR3g1UEZsYmpPcUlpRmpRcytVQnlEUk9uQlhaS0tiaWN5bUVYZGRv?=
 =?utf-8?B?Z0dGSTdEM0c1QktoWHAwTVRYNUxsTXpXODNWaTlOMklHZlZ0eUxDYXk0aFVa?=
 =?utf-8?B?QW50YWhNWDY5Um9aSENQVDNkaXRNeWpJeXZnRnRCeTVJQ3BEclRFMU1zU0d2?=
 =?utf-8?B?cEIyMHlwSS9GU3ZhNXRGK0Z5MVlzbktLN3pJR3RUZU84a1JsSXlmQnNQeE94?=
 =?utf-8?B?dHhueFNydWM0QzY1NXZjVXAzYVNBTlFsWVVvK2dINEtXM045YmszZEwvUzhp?=
 =?utf-8?B?dXdwRWRUa1pTbTA1ZkZISFZyTU0zdllqVkFJSGoycFhVS0dOdEhhZGR1U2Jp?=
 =?utf-8?B?d2RadFZZTE9MTU1ya0FJQXh4Zmg0bGcwdnNvcEpad0NndlVjclZPWkpBb2c0?=
 =?utf-8?B?Q0RCR2REc0d2SmRtaTl6RGJvWVZUbDhoY202bVB0WUdpMWl0cG5MRkxUZlFO?=
 =?utf-8?B?KzF3RnRjYzlrRWRtbzkzVjRVQVBvTjU3a3FMZVFZb2dWV2FVeXRHdVJhRHg4?=
 =?utf-8?B?M1psLzZqWmkvaVBkSy9Ba0VTdFcreE5zSXVmZGtwQm1OcG9OenJDRWI1RUN3?=
 =?utf-8?B?SnRvSlZ6VWhTSE1lNy90eEtFLzg3dFhsdVVRTDNrNlJRbnlwd2RORGl5eEI3?=
 =?utf-8?B?bDcraTZBSGtaVktSN3Ftb0s4SjBqbEU5cGh3d2RoQTl5VWZVV2RETGtJdENP?=
 =?utf-8?B?dlZ3OFNMWURuUEZJWHo3VXFYVG14Um5lYzBpMXV3cUJNNmVGZUtlUFRLaDBK?=
 =?utf-8?B?dTZoNW5LMTNEbDRaN0xvL1hOQjVST28wdmR0MWluQnEvWU84WXNGWWs5dzk0?=
 =?utf-8?B?VVNMY3BKSTVleVZob00vdGdXUXVWY1Q1VmtLdUdhNGZweHl1M3YzbzdOS1oz?=
 =?utf-8?B?SldHTHdLNGhWYVZyOUs5bzVURGF2anFzQ2dLbEdiNlpRZXhtV3FUWkFkYW9L?=
 =?utf-8?B?M2FIOXRmditmK2pkWmx2TEw2a2xnQnhOS1dRMWJGL3MvN0drbEVLZHc2QVNM?=
 =?utf-8?B?WXJZZDZiY3krdnp5MFFXQ1lzUGpXZ3A1Y2JlUS94R1dmK25zRXBhbzg2cUpN?=
 =?utf-8?B?ZmRhNEdnOTg3bG5ZclFwRHB2cGJvK0dlQXBYSWV5VzF0cmFUamNJOXlCOXY1?=
 =?utf-8?B?Y3E0eGYxK3JVeU1nNTQvWG42Z2UvQ2grZXN3ZWFuamt2d3ZjN3dDUGxGQUNm?=
 =?utf-8?B?Zng0WUh5Mk1TL0xtSTdyNCtjbzhqamk0TTlpSkxnOFJ2enFhM1NacDFkNHQ3?=
 =?utf-8?B?SkQvL1lOcmxiQ0RpUEJiZGRiWDBzYlNCSU9TOVdmU0drcWdsTUtaN1hSU2w2?=
 =?utf-8?B?UUtzL3l0OHptVHV1aU9qK0RRZjBSVENFTGRYWmdXM2xDbC9UNVl5eGx5bWZK?=
 =?utf-8?B?bHVyOFFzTDVXV1M2K1hqSUVqQnFOV1JoVzBjdzl3TXYzanhIK1V1WjBhN3RZ?=
 =?utf-8?B?Vjh5OGlzUDhzMys4KzMwby9qeVRxcjN3SUE4Z3VSWWVZVlhsTlRhN09kZmNu?=
 =?utf-8?B?R2dUTEJUOFVrZmV1ZTBTUUVoS2l0Rjl0M09vZm1sWUlhWXZPazFHeXpJYWRh?=
 =?utf-8?B?NEZ6cnV4TkgxYWJxMHVrWVpabER4WTJUNGtXWXNaZVZKUlo4TVMrV2d2bnpN?=
 =?utf-8?Q?92KB/YiWRCnSc?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e535b3-220e-40d3-837c-08df3f3d6dab
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:15:18.2978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10090
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

amdgpu_init() registers the ATPX handler before it detects the ACPI
XCC/NUMA info, and amdgpu_exit() also unregisters the handler first.
The two do not depend on each other, so swap them to release in the
reverse order of initialization, which is also the order the error path
of amdgpu_init() is going to use.

KFD and the PCI driver keep their order: KFD is initialized before the
PCI driver is registered and is also torn down first. That is not an
oversight. A primary KFD context can outlive its /dev/kfd file, and
amdgpu_amdkfd_fini() releases such contexts while the devices still
exist, whereas removing the devices first can send SIGBUS to their
processes and wait for the KFD state to be released. Add a comment so
that this is not "fixed" later.

No functional change intended.

Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 72b3710..564dc24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3238,10 +3238,18 @@ error_fini_sync:
=20
 static void __exit amdgpu_exit(void)
 {
+	/*
+	 * Undo amdgpu_init() in reverse order, except that KFD goes before
+	 * the PCI driver. A primary KFD context can outlive its /dev/kfd file
+	 * until the mm of its process goes away, and amdgpu_amdkfd_fini()
+	 * releases what is left while the devices still exist. Removing the
+	 * devices first can instead send SIGBUS to those processes and wait
+	 * for their KFD state to be released.
+	 */
 	amdgpu_amdkfd_fini();
 	pci_unregister_driver(&amdgpu_kms_pci_driver);
-	amdgpu_unregister_atpx_handler();
 	amdgpu_acpi_release();
+	amdgpu_unregister_atpx_handler();
 	amdgpu_sync_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
--=20
2.56.0



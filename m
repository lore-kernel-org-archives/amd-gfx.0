Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9806A606A320
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Vx8cyqUK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E29610E120;
	Tue, 10 Nov 2026 15:19:27 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn19010023.outbound.protection.outlook.com [52.103.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF48210E120
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 15:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kd7IeALG9R+q8DVYH8Yht59hLm/GGeLscOLieipwh+cOqg8yMKeE4UcnWbHdgsVDVtCaV2DtXiP/KXkEv2A07wr1xlZkKtDepTFDjUZ5TcOfKZnpRg0UoAlnr1m5ZSpuCRup+bYm3dZY7VFDe/HJSczX9LAtOcbVdHLTFgTS3VCRzl7pRhmTSLkvviiszKlIAffyBPJ16XqXu3ESfQorfnGrpuU48rAzm4fRL07xVlU5GVF8QuIB1vXAD4CCEdWH57VoTLTW2UXCGY3ZWBVylPUU8TMk22GR7YJS4UqAmgdimFip9nxpApuxXPBXROLwh2FVCCiHpEZZ4BbX50A42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlY+eQtiVHtc5wICa1O8X07AP4bdEJFT9bygK7EDJ4k=;
 b=auXK0ORUhi2TH7XlaT3O0HAqELQtcjaWIFw/BJdYjkUSk6Odgy5jVvdYM+o/nPp0AbsndNyoxYuFHd6VXRAgh5OWwtQq/oAdzCrsWUTnjaAYhsMXDtsbIBGbxrS/yE4peQkjNnjsseu6PYaA3wSAq+OcU92B2QbOGg50yPbR1X7HbexJEav6Fn9SF7pF4+gOP5FiN0nyh3Q0TU0ln6CqTy1VNBABhDB5AdrLTdZjcWfCUmUnv2q/Ek3eNebtFV2WB/oQUpAmHP087ybKx5DlGkncBaWjDcMJ2CD7JXOBehWBrj0E/0IYMYMrOi0VtEixTsPZDCMerfusaIKmAXXlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlY+eQtiVHtc5wICa1O8X07AP4bdEJFT9bygK7EDJ4k=;
 b=Vx8cyqUKiRZFTdCdII8KbtrhqljEdcYGgPjPMmtAXasBK9jPYhwL8rF9vZfvAY2K9d62PlpmVS9vY1nwhsH1SYqWJqQ+pgifyGZ2ulCMLNq7zPqJ+ZbnjsXfvHC+s4dNME/0BKOBO2Cg4MOisuLjysyUrUX2s4P8+MXjONntuG2mVZ3N3Ta47Qt+2exOdFFZN9xkfScLFst5O0KWNfXaHwbcpO6EfPVdvf9pZO3vYMEATJRKdaXGvG7n49ekKXfu6K4zzUgbtGA8S5nFMkCcp3+IJRWc0gOHKUvNm2Xm/GuFVo5Gz7NOZhk7EwY1cZsH0v5rj14Ei6+kDRxWvFMDCg==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYCPR01MB9587.jpnprd01.prod.outlook.com (2603:1096:400:194::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:19:16 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:19:15 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: [PATCH] drm/radeon: only unregister the ATPX handler if we registered
 it
Message-ID: <OS3PR01MB102512A4873E4DCA42A648069E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: "Alex Deucher" <alexander.deucher@amd.com>, 
 "=?utf-8?Q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Tue, 10 Nov 2026 15:19:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <d5684278-c5ee-4af4-89b7-72b93ad3a200@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TYCPR01MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9d4b1a-161d-4d7e-1d6f-08df3f3dfb7b
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|15080799012|6090799003|5062599005|8060799015|24121999003|22091999003|41001999006|25031999004|5072599009|23021999003|51005399006|24021099003|55001999006|25010399006|440099028|3412199025|4302099013|1602099012|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZytVVFYyL1pMNXlUYTJRNGlENzd5VkhnWUZpemN1aFdvMlk3M3hPeGlJZjB4?=
 =?utf-8?B?a2FmZnlnQWpEa2g0N094U0F6ODFySVZINEt0eXl3aEN4L3UwWGJxci9FZjRv?=
 =?utf-8?B?dFhNakRHcXZVRGpOM1NmRC92SFdkSGpnbTFBWjZTR3FKdmtSMHAxVXBsWkNW?=
 =?utf-8?B?b0tqelJma0hjQkJPNTBON3dMM280R05LNmZLYWw5YkdnRjhsTHVOYlh3Vmht?=
 =?utf-8?B?YjY1TjQrVit5cldXZmxaWFliZVdBTEZBcG9BQkoremlNNjdrNCtIOFk2dlla?=
 =?utf-8?B?cWFxTHpKOU44NHF6UDF6MW56WEE5T3h6NzdMdWZEeEVJT284R3I4cFdwdDVl?=
 =?utf-8?B?WGh6WE1KQnFjN0J2WnBkYlVJUHlDOUU3eW5iWVQrSEhFVU9DUmRLOVFXMld2?=
 =?utf-8?B?ZFNWRXE4anRqcFU0MTYrajZpTFppQnRBS3lvSFk1K3k3dkI0bldBbjEvQzdz?=
 =?utf-8?B?SzFlQzJSQkdOOWF1NldMcUNUaHNubTZjTCtsTktBL21qMndidER3dTE0Y2Ja?=
 =?utf-8?B?QWZjOHJ1ZHhWV3Y0L1pHY3RlRTNxMzJXU1R1QlF3Zml5aFZiM3VUNzlrRlg5?=
 =?utf-8?B?Yk5naXpDREJrMjlxdmNCcktsVkQwR3Y4UTVVc0lVMnR0Tk1qcTVocW9mM2dL?=
 =?utf-8?B?cEN1MXd3eXE0SE4ycmV6cWp6dHgvcVZOeXZiUU1WaVN6bzIwekUycEN2dlFi?=
 =?utf-8?B?YW4wZm1CSWI0U3FjL050WnplbERxNmR2ck14TVBtaVY1ZWpSZmJxZ0lpb2l0?=
 =?utf-8?B?NHRGZkUvQ1puekdYS3RvcUJlODhJQnpyeVBLbTUyRFd6NE1HZWRNam1CR2pv?=
 =?utf-8?B?TXV3Nys2ZEZKQ3daL1JRbldrd09OVjNxbHp3K0YvVHBxd1Q0aS95MG9TYmN4?=
 =?utf-8?B?ZStxZCtqUjJJU3RBMzIrME9oM25HMndaZlg1VTJkNmF2QTJvNW1DVVZJQVpS?=
 =?utf-8?B?am42MVZObHh3dkljSFViQ1BSM29VM0dYSjRsUC9OZTUxODdscVV1Q2Q3ZE5B?=
 =?utf-8?B?YnhRRjIwOURyUkpPZVQ5UWpVVHFuLzk5UmJYY24zVkFmOTk1Zy94L1h5a2l4?=
 =?utf-8?B?TGROZ2RTUEsxTWRFd0ZwcnVkcHpnMGdDNG9TTXdYOGQ1VklnVENWTkpYWEph?=
 =?utf-8?B?eDdlaHlvZHh4YXBuckVYMk5LVHdGbEZKamliUUp0Z29OUnVNU2g2OW1yTXFp?=
 =?utf-8?B?a0RoV3hDcnM5akRycWlGRFN3Zk1LQSttRno4MHlZc09lVU9NSmJkeU9EcmVB?=
 =?utf-8?B?ME5PZk1PdGhOQi9qS0ZhNkN6eG9lL0FwbkFiaUxHbnNpb0hpNUtkZ3dHNS93?=
 =?utf-8?B?VDIzSUxMRHFzYXJKWW9keDJnNEdNWk5hbU5aMnhiS25xeUREVjZ3eGhsZXNP?=
 =?utf-8?B?WTVuaUVGcmtJVHlUY1FTSTdEU3NTQjFiei9hQUprUlUrWU5sSnU1dkFsaWZi?=
 =?utf-8?B?aWZRWDVQTEkyakRCNEwreEYzSkdMZnRxUWVvckZIQTgyT1VTZjk0YjZTTkVQ?=
 =?utf-8?B?aENQS0paUTJkZDJyTlNSOVlFdVdDRkU1K21MVEFzRFpzdnhiNSszckNDRTZk?=
 =?utf-8?Q?laXTK299cBQxF4VNhhKP6L2/9+BMmTpsS3AbctBw9v0N86?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWNIWEo5bzdZVVVTUEdmNk5uUjJCdUZzWm5NbWxaemJXNVlRTzdTdU5SazNC?=
 =?utf-8?B?S2xTT2k1amVTUHJJRFdSMmZDRU0zMmhTS0JSYzNnZitpVEM4aFNteXo1K0Nu?=
 =?utf-8?B?QUQyR3hWUXFzMlJXdmZIc2lTOTdZRFFZZW91ZzBJZ2pnSFRKVk44eC9uODNa?=
 =?utf-8?B?Und4UFZ0ZWZTRjFRdnpNbnNZQXh3YkNhQkx2WUlHYlAxbjVOTHgwQnpJWTZH?=
 =?utf-8?B?ZFJWbWZGVVZlM0JsSDh6bnk0TE5QWk5qZ3dIY1BZS2tUdnJSWHRMdVAzRjBt?=
 =?utf-8?B?S1IrOTNvcHNKNGgvWG1lQ0VpZDUxbUZDQVVEcG5LWStXWlIxbHJZOW93T0RC?=
 =?utf-8?B?aXhjLytoRnpwS1ZOb0dyZzlqQjU0TklvdzJrS01Ncy9heWxBanhXTlVHWVBj?=
 =?utf-8?B?OHd0RTZialJ1YnBYSkFaazdVQmVsV1NmRXFWY3F4Y282K3k3bEt3SkJPRnBL?=
 =?utf-8?B?L0tkbml1TzNLc1l6TW9qZmdBeFZuL2hOekdsOFFCMS8wc0wrWTBVYzBhelQ1?=
 =?utf-8?B?bjVPdURMcTdDWVVqZ3k2SFZwVlAwUXJyRFZNa1hvc3hoZ1NuNVlYY1QrM3VK?=
 =?utf-8?B?ZkVRdEFNTXY5dnU4ajhzT2tuS2swRzlnN1RPR05hWlR6QlJVcU9sQmMrUzgz?=
 =?utf-8?B?QmtEdFBjYytadWd0QUdEY0E2WnMwQXo5TDg4SzVuQTVlbzUxSWphWkg4d0Zs?=
 =?utf-8?B?aGkzQnVaVjlxYXFtMHlsYXlXSFlzMmZkRVJzdlJOa0V3REdQdllpeitPbm9J?=
 =?utf-8?B?b092V2UzYmxBcm8rbkc3ZHA4QkdXSmxWRHJHc0EyQWtrQ0Fzc0FiazQ5QjU0?=
 =?utf-8?B?RVpic0lCdHpsUFIwNkRUN1gybHBYcmRCRjNUaU9IeWFNTXBpNC85SEVhV3hR?=
 =?utf-8?B?L0JqSTZrVGdWMStocDhuWHVJR0hGbE5hWDBhZUYxYnVRLzl3ZDcrYVNoR28r?=
 =?utf-8?B?azZLeGR5bmtybDZreDltTnpJc3JlZXhMWVlDMEIxaFlndFVSSHFUR3RuR0ZS?=
 =?utf-8?B?VEFONStHa08vdzU4TXVmYzRKZ21NcnkrTHZOYmNEaGdyQ0p5TlhLMFJlbk9U?=
 =?utf-8?B?TkpBdy9ndzZyV25aRWtCaFBUK0dUUXBOYkVpYnRPNmcydnBBNWxaMUFzMVh1?=
 =?utf-8?B?LzBlNk1US0xlcjcvNTJONlpFV2ZYRnJwb1BSNElPazNtL0xFRFhXWVpCRlZW?=
 =?utf-8?B?WG1MSjRjQnN0dnZCRk5KMWdYVnFYWi8xMDljTUZVOUtxbWNPdFp0aTRFRllZ?=
 =?utf-8?B?TVFpNFprVUZJZ3dVZk1saXNYaVhiUHM0R1NxTG1PSjRTazluYnUzTEdwVlpN?=
 =?utf-8?B?U1h1UE5PRDJVbXBKRGhEV3U4ZXYxODhoWFArbFFjM1kxSzczWkNiMDRJTlN0?=
 =?utf-8?B?bll0dUpzRHZrQThoZ0doZ2VMNWd3SmhobkNTbS91ME9PVmh2aENIVzZKdGEr?=
 =?utf-8?B?cjBVbWJrRThTRDZENlBCTXZuTVdlazFuY3ZGOHZYK3pQamttVUQ1T21POExh?=
 =?utf-8?B?b2UrNzgxZ2MwOElWNUozbmJpdG14YVg1Mk5rWm03NWp1QmYyMGgzeVgrWHRQ?=
 =?utf-8?B?NVR2L1M1cVg2ZjN1ajU5WWVUNmx4QkNxUkt5N0RSRUZvTlMwa1VwVzkxa0lh?=
 =?utf-8?B?Tk1TQmFnOEZmUkJzVHd1NHBUcFlVeUNaZXJraWp2WmdQRFd0Uk1MeE1hRFZC?=
 =?utf-8?B?ZTFZVERLMGM1UDdmVjJLbEFROEcvc2N1MWZOYllDU1R0V2ZnZk9PRmF0bnRY?=
 =?utf-8?B?U1VPcDczK2tqNXNSMFFNME9yVTlhRVYxbkxJUGJQVVBFWXNXU1BCWkIyQVJt?=
 =?utf-8?B?bDQ1eXBETDcveGFlUnU4UlVYblRPRUk2bHZLL3grbVpkSkRrZ2NHS2NrNThY?=
 =?utf-8?B?bWpod1BnMXBUVWxoRzJQVDlBRWlmYWZaOGVTRDVJdVhPQ3c9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9d4b1a-161d-4d7e-1d6f-08df3f3dfb7b
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:19:15.7695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9587
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

radeon_register_atpx_handler() registers the ATPX handler with
vga_switcheroo only when ATPX is detected, and ignores the result:
vga_switcheroo has a single handler slot and refuses a second handler
with -EINVAL. radeon_unregister_atpx_handler() calls
vga_switcheroo_unregister_handler() in either case, and that clears the
slot no matter who set it.

So unloading radeon removes a handler registered by another driver, such
as apple-gmux. No Radeon GPU is needed for this; loading and unloading
radeon is enough. amdgpu is another such driver: when radeon and amdgpu
are both loaded and both detect ATPX, only the first one gets the slot,
and unloading the other one clears it. Afterwards vga_switcheroo can no
longer switch outputs, and a client that uses the vga_switcheroo runtime
PM domain, such as nouveau on a non-Optimus machine with a v1 DSM, can
dereference the now NULL handler during runtime suspend.

Record whether the registration succeeded and unregister only in that
case. amdgpu has the same problem and gets the same fix.

Fixes: 6a9ee8af344e ("vga_switcheroo: initial implementation (v15)")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
The amdgpu counterpart is patch 1 of this series:
https://lists.freedesktop.org/archives/amd-gfx/2026-November/157097.html

 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm=
/radeon/radeon_atpx_handler.c
index f557535..9ed75c6 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -34,6 +34,7 @@ struct radeon_atpx {
 static struct radeon_atpx_priv {
 	bool atpx_detected;
 	bool bridge_pm_usable;
+	bool handler_registered;
 	/* handle for device - and atpx */
 	acpi_handle dhandle;
 	struct radeon_atpx atpx;
@@ -605,7 +606,8 @@ void radeon_register_atpx_handler(void)
 	if (!r)
 		return;
=20
-	vga_switcheroo_register_handler(&radeon_atpx_handler, handler_flags);
+	if (!vga_switcheroo_register_handler(&radeon_atpx_handler, handler_flags)=
)
+		radeon_atpx_priv.handler_registered =3D true;
 }
=20
 /**
@@ -615,5 +617,14 @@ void radeon_register_atpx_handler(void)
  */
 void radeon_unregister_atpx_handler(void)
 {
+	/*
+	 * vga_switcheroo has a single handler slot and unregistering clears it
+	 * no matter who set it, so leave a handler registered by another
+	 * driver, such as amdgpu or apple-gmux, in place.
+	 */
+	if (!radeon_atpx_priv.handler_registered)
+		return;
+
 	vga_switcheroo_unregister_handler();
+	radeon_atpx_priv.handler_registered =3D false;
 }
--=20
2.56.0



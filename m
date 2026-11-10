Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D8606A330
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=ZLMqIxxz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3506510E253;
	Tue, 10 Nov 2026 15:15:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn19011013.outbound.protection.outlook.com [52.103.66.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10BF510E253
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 15:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAHE0ISO0xbP4FPqPI1PVkMvLGWzQk97lgWUlPMJFiEVA8YmiwGefjyQIZ3fSPsyi09650218sqSqUq3zYjWSTdsU1B7HVUtP0S6szM88ntGQaOJ1icxOpkR4YJvhWVMIOQoOxeow5hYK4BTs86vhKxZeUNLqXDwWerifyB2FtOLUL0dAi1wx5M1L9rMmFANGcXKnWd7ZLe3I/MoxxgGOJKNZHGYfXMNYhe5Jmn0ZhXA3Yu1EOzj6vkDLOxNP6RO1vYNYaVeHLsJL3pRErGhHXcsEP/+WsFwF0rPZLQCvTxqwQ3Hye/hOtDGFTL1eGqJa2qKO1UJ+LkivrtlhVV+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4FZEeZfAPLwzNSPEcDHE3DYX3rdsZLtrwYxQixv4+Y=;
 b=tiSMRjChrgpGkcp4ELxJgNxvHdmwIC0P+qJQJOJTKp5K+xNBAV6zfVb7EeH2Zok3V1O6/0gOJbSFJAYSd/hacJNp27KNIqbxMb3VxUZPiPccWz+8QsIrCkkn2x0EEx2x7dI7+OHxUDcUMTpJ38xdrUMyhFCBMQqzl3hVWPSkKXIrjxKf41f+U/Cze34stGQ26rXb17sAH8I15g9SSDA85ku1kacF1Wf7bN6dP4wt/t9DccONcRRCBbbBr8TKJdvKVxAXDMv31/CM/ymDbSZ0zAZkqHpCaVjtBFA/OnsMuBxk81m1vbUBcxOFH04o++8zU/kZPtmQlxziSdD9A4ok2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4FZEeZfAPLwzNSPEcDHE3DYX3rdsZLtrwYxQixv4+Y=;
 b=ZLMqIxxzYlzwuQsoHFgtoQfUhNH3VeeU8XEeO4BgeCWukAWPxt4azH7VOKUbK2g4wgt7UmgMjd7dIhHl9Gq4cBdTFHHgWb9cF8amoDAlUsK+RzhXSGmGLZLlJC6bJa7cU3Q2gChstKQF7mf7+5nFOqGTMdPWSMK7cNBY693LpbPQlM2XVA0XPSyE46OOnxKFLLYzjcHjnsjs5tIa61m7y4wxlgslxa/B8DHrTVlr1UxtSKDVwMYIPoXMwOCKqvKZ5FGbttopfRCUDWlQ6xWqxIrWdQD7nSVV9kIl0AErv7ozJlNJWcMJo+N+sual76XH4e5RBLRZPQzjMbKDOSTu6A==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by OS3PR01MB10090.jpnprd01.prod.outlook.com (2603:1096:604:1e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:15:04 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:15:03 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?[PATCH_v2_1/3]_drm/amdgpu:_only_unregister_the_ATP?=
 =?us-ascii?Q?X_handler_if_we_registered_it?=
Message-ID: <OS3PR01MB1025119A8F2474A82F12BD98FE7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: "Alex Deucher" <alexander.deucher@amd.com>, 
 "=?utf-8?Q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>, 
 "Kent Russell" <kent.russell@amd.com>
In-Reply-To: <OS3PR01MB1025124AAC2F9492FCB206AC6E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <OS3PR01MB1025124AAC2F9492FCB206AC6E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Date: Tue, 10 Nov 2026 15:14:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TPYP295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::12) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <ccec99d4-ae80-40fd-aa9f-0c973bf69e04@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|OS3PR01MB10090:EE_
X-MS-Office365-Filtering-Correlation-Id: 13163f23-248c-4c8f-13e4-08df3f3d655a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|23021999003|41001999006|24121999003|25031999004|22091999003|51005399006|5072599009|15080799012|19110799012|8060799015|55001999006|24021099003|25010399006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkZjd1JVRkNwV2JrTUlCNmhvT3FRUHM0VlRNTUdwKzk1UFpzMUJFUmRpemIy?=
 =?utf-8?B?aFB0V3ZHT1ZXc1dHQ1BEOUFpSW1jdng1dGR5TXFBTG4vWDJuRS91N0dqM0R0?=
 =?utf-8?B?dWVVbkRsQVNIVDhmdTRaUXI4UEwybHh2SjkzRlUxaU9EelYxKy9ESXJEOEt5?=
 =?utf-8?B?OHZsWkdKRGVjY0N0OGhMdHlMdE1WOEJhS2FnazAxKzFmS3dLeVhvN3prK3U5?=
 =?utf-8?B?aHFlYmJzRHpvS0pUWEZFTDhlWW1ZSlk4UGQ5VkdJci9GVGMzMWw4VDllVm9V?=
 =?utf-8?B?YmorSk5mQko4VHJickR5QkMvUEc0SDZLc0JVeEZIb3Y2cjl5THVXWjYwakJi?=
 =?utf-8?B?dVVkelpBbGk3TUl2SG1Qc00yWm5BREMyaUZsV1M0bEs5ZGZ0K2FJa3RqVWZX?=
 =?utf-8?B?M1FBV1JFMVRaUnNabG1vUTI3V2NIU1RyZHFXVGFyNnpjZmx0Vi9kMUpLb2tn?=
 =?utf-8?B?Zkd4ODVBbUk0dmlldFRpOGU2blNEMzRyOG40VkhNVzFEU1FMQS9mUGVNSE9N?=
 =?utf-8?B?Zlk4MmF1UXNVcUR3VHlOMXBOakJYcVZSOUl2OGZBMVhMblhaRGRTY0lULzR1?=
 =?utf-8?B?MHVqMFZ4K0h4MHBYcGp4RlZNOHVWRFM5ckRhVWQyUFJMV2R3UHhwNVhaZ1h4?=
 =?utf-8?B?OUN1enFCNTFDRE5ZNHJBZlA1T0JKenkrd1o1ZXJwN3JXUEV5S1RJc3JwWjY0?=
 =?utf-8?B?OVRBcUlrYytIRDhhUWRIZUkxYXEvSWg3R2FvM0ZxKzZ6V2w4dmE0YjBCOWxM?=
 =?utf-8?B?NUJpZW9nSXBLdjI1YVRFdzBsNFFWVGxsTnV5eE9pRXRPaXl6UW5xdjhXZEdu?=
 =?utf-8?B?ajI3NDBCdi8wNG9NK1c2NHdQNklLcGNhTTNDK0d1a0Iyc0ltOUNrT2RxQnFG?=
 =?utf-8?B?YmhZcTVKTUdLYmg5SjRweWtScDhHL2crM293VGRUTEZsWnFFSjBDZVR3U1hv?=
 =?utf-8?B?UEUwS2hzM2tSWmVnNE9RUE9ENHJCSWVhVE9Kd0JYRFlGb0puRUw3SVpJaDB1?=
 =?utf-8?B?WStyRUt5eFoyKzdzQUQxeFV2cFJBTVNxNUFwL3FweW13U2p1S0NWZkpOYXF4?=
 =?utf-8?B?YTBVT0dkeXJTYUV6eTBqNTZMclM0S0FGUVBYTjY2TUlVOHVnYTAxVTB6ZThr?=
 =?utf-8?B?N3pFNVhKd05MeGFTWWVsL29WR3c1c0xIY2dpeUpQTUVOQUs1R1JLR1l3cUpU?=
 =?utf-8?B?anVFVFM2SUZLV1hjTXlXYVFYSVB1cDBRZzBTQXBTQXZycTVpU0NnSDVIWWVt?=
 =?utf-8?B?amM2NHVERXV1RGo0YTd1OHZFeU81a3JIeWtOVEkvM0dITm1NNmQ5VUZaWUo1?=
 =?utf-8?B?cnduLy85TEFPSzZxdTFiVjlzU1VPNnlJR0xSRWprYVo3bFRneTNEaHN3azdo?=
 =?utf-8?B?Y0pvVlVlQU5SK2Q4WUhhOVRQWUlLUE5zaWpmdEwzUFpTc1NBYVNTYmxvLzg3?=
 =?utf-8?B?WFg4OVlpRVh0eG9hZS9uOTgxWWVaUVhzSGUrcW9ZM2xNbVZNaHRkSEFucC9X?=
 =?utf-8?Q?F0j4PP4FfJ5Zw03wVWRWWlJCikv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFBtNVB5TzdvdkovYUZHYmw3SzFSZUp6YTBrRHFEbk5xQmgwbmJnNTRxT283?=
 =?utf-8?B?SjZzR0dBUnFVY3l4cDVSamJaZC85NjhxclhaMjBaZVFDZWpWNTJVbGF1VWN0?=
 =?utf-8?B?RE8xajFkWHBVdWJiVklpTm03K2pIaHcwWCt4eTY2R0V6VUN1K2phdm1JbHFZ?=
 =?utf-8?B?dFdoZWtObkJsNURVdlNRbXVYZmx3SWlTOFNKSTdjVkdvbU4xNlNGVU83WVFy?=
 =?utf-8?B?NDk2L2tsZzl6bTduV1d5NUczU09lSVUzWU9RelFUSGRnZUY3emhJVXFDQkNn?=
 =?utf-8?B?WHRpa1BzbmxrSk0wdTFzSms3MkVCM1lHblZqOEtpZXFBWjBTSUF4Ymp3R1BO?=
 =?utf-8?B?a3VkZE85SUd5dndsUVZzTkY5SWhyLzJMQmJNWWFiZmpiejkyWVdETU0yUllJ?=
 =?utf-8?B?czhabXlkVDErc1NLZlN1anVwS3FjYXVSdmg1NUNGWVlxVVJtTVh6VDhUd3Q0?=
 =?utf-8?B?bUFJQ1Vna2pjVEQ3czErSnhPQ3FsVWxUT1E5N0EwV0E3ZzR4MDVBdGliR0Mv?=
 =?utf-8?B?QllrN0t4SFBlVXdPY2xHM3QvTmMyclRuMkoxYnBVRFBNNDd6RUt4SE5nQ2JW?=
 =?utf-8?B?UCtwV0t2VWdtamRrRUNmbnlMRlBZbmlRZnB6RUhMU1lFUkxZblRyVnkrQlF6?=
 =?utf-8?B?RFgvYzcvUjFBNGo0OUZxcTV1K2hrTGRSUXFjV3NxdTdic2h5cEhkcFdVYlNi?=
 =?utf-8?B?SjFPNjZTTGtRTlZ3RjBUU2FIWitveTRKdXFWVDZPSWNSNW1JVUNjS3JFNzZa?=
 =?utf-8?B?YWZJWTd1QnNVRGwzbjRzcTVwUGJ6ZEtvQnlZTWpSMHBEdjZNV2NNaEh0akp4?=
 =?utf-8?B?TGFsWmlTRzZIRCtvaTZVV0p1N0RaWVZ2YXdCb0tOMFFRY3Y0MHZ2M21OSStx?=
 =?utf-8?B?ZDdnZ0ZLRzVjcVQzZDh3Y0RnaTRUc1dUL0duQWVLY0JEV1NYaWJJKzVnYzd3?=
 =?utf-8?B?bld4VmdpTWdQNkgzeHRkTitZTkw4aGh4akVwRFc1QXIra0RLL0w2TU1rRUpQ?=
 =?utf-8?B?ZUdPMXlIa0JFVWxCcmJZakJEOXhQYXlmOU90aEltL0ZpeHZISjUxMW5CeFdO?=
 =?utf-8?B?ZW1qVDZyTk9acWJTNFFHWmx0WXdWZFVJTCtXMDM0bkZWYldRM1pheWNQenJz?=
 =?utf-8?B?ZnduNmR3dnpHNGpUUjc4SVlxOTdkUDl2bTRoVGhRalovK0l3R0VZTlJmclpT?=
 =?utf-8?B?R3BEczJIWmJRUDcyc2U3N0NSU0d2aDZRR1IxNUZvUmJKZnRhdmJMTjQ2d0ZS?=
 =?utf-8?B?UW9OYkdEWTc2a0lucGpxZ3NyNlJEbml5cEJNUUlDam5QdXE1WE9ySUtNOE41?=
 =?utf-8?B?dHF0VGdZQzVJaVY0bDlwZzZJQ2pManhXQ0diaVlLbkNtaTRnOERkZkVHUjlF?=
 =?utf-8?B?QmJtRFpaZ1NYWUxCOWthaHEybjFJaGJWYXBXbUs2K29IeWxsc3c0eFhNYlgy?=
 =?utf-8?B?N3lwMnFrMy90eHlMRmN5UzRyZnZ5Vmg3V3pYSnJMSWJKMmxNSmo1MXR5ZlRZ?=
 =?utf-8?B?SFJIOVJsNGN3VVRDUG91SVlKRXpLTHFKbXY0dWdxa1ZmQTdxUXliam9mZEQ2?=
 =?utf-8?B?WW43MngxMjh6RE15UW9EKzlDUTRqU1p2M2NUSkV0dE1sQnB4M0QwSXVnMmVo?=
 =?utf-8?B?SmpQT2pTVUJjc0psUy9JM1gzVVpkdXhhZnJUWUV0ZlBCYWhRZFlNcDdEejBk?=
 =?utf-8?B?STNEUCtsUFc3Z0o3U0MrK3lZOEt5ZjlxZmFjcmxTVUhGL294WlVTRVhBR25j?=
 =?utf-8?B?cE0vSC95SnBzNW95Njdxbzl6UVlhYTNqMUZmc0hCajhHdCtxalNYamFveWFH?=
 =?utf-8?B?VDNiOVVXck1VazdvY0ZaMlY2QTc1WE9HUzRGb2NDU0xvbVBkZ1Uwa1NnLzJl?=
 =?utf-8?Q?BRSBikStWvcbM?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 13163f23-248c-4c8f-13e4-08df3f3d655a
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:15:03.9053 (UTC)
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

amdgpu_register_atpx_handler() registers the ATPX handler with
vga_switcheroo only when ATPX is detected, and ignores the result:
vga_switcheroo has a single handler slot and refuses a second handler
with -EINVAL. amdgpu_unregister_atpx_handler() calls
vga_switcheroo_unregister_handler() in either case, and that clears the
slot no matter who set it.

So unloading amdgpu removes a handler registered by another driver, such
as apple-gmux. No AMD GPU is needed for this; loading and unloading
amdgpu is enough. Afterwards vga_switcheroo can no longer switch outputs,
and a client that uses the vga_switcheroo runtime PM domain, such as
nouveau on a non-Optimus machine with a v1 DSM, can dereference the now
NULL handler during runtime suspend.

Record whether the registration succeeded and unregister only in that
case.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atpx_handler.c
index e2a4644..f946778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -45,6 +45,7 @@ struct amdgpu_atpx {
 static struct amdgpu_atpx_priv {
 	bool atpx_detected;
 	bool bridge_pm_usable;
+	bool handler_registered;
 	unsigned int quirks;
 	/* handle for device - and atpx */
 	acpi_handle dhandle;
@@ -663,7 +664,8 @@ void amdgpu_register_atpx_handler(void)
 	if (!r)
 		return;
=20
-	vga_switcheroo_register_handler(&amdgpu_atpx_handler, handler_flags);
+	if (!vga_switcheroo_register_handler(&amdgpu_atpx_handler, handler_flags)=
)
+		amdgpu_atpx_priv.handler_registered =3D true;
 }
=20
 /**
@@ -673,5 +675,14 @@ void amdgpu_register_atpx_handler(void)
  */
 void amdgpu_unregister_atpx_handler(void)
 {
+	/*
+	 * vga_switcheroo has a single handler slot and unregistering clears it
+	 * no matter who set it, so leave a handler registered by another
+	 * driver, such as apple-gmux, in place.
+	 */
+	if (!amdgpu_atpx_priv.handler_registered)
+		return;
+
 	vga_switcheroo_unregister_handler();
+	amdgpu_atpx_priv.handler_registered =3D false;
 }
--=20
2.56.0



Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943F606A336
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=rFMt8YYc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D364310E3BD;
	Tue, 10 Nov 2026 15:15:47 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn19010005.outbound.protection.outlook.com [52.103.66.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2855210E3BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 15:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTbCwbIFzNomsZ2cM0dyz54W/ByV76LfhOS77y2yTzDrkI+b0Z5R3PYH6MY2wIV51uHMSW7J0NFrjyEt8wMrLjf9qdLLo02frE92Sfd9WsxP2jV8XtEY2QJIi/5+dnjvj2rYRRRjDjZmDL8mLlH01HNs67mMORL5UGeRB1JMr/cZKCz7NQ+1k4EDDFwjgO4bqa6vCxQKErCZZ8PF5xRhguWUr3S3vWHsoIkozNTna7ODkCtvJztVbWYKNvcyIHCnlYTKhJCa7JTE0/EwVcexqN8+IZk5IUYjUMf4IfAQnVJ3D0i/hr1fVYHUKuWDKFYLb+gTnRbRdf5F4to8T/UsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FsoKV1UlqZH+nMGWf20k6RiY8tQS00AK+fknzdW7Wk=;
 b=p4RW9vlS7r/F0eugh5QS/wmQAhiI7aaAq5YLxidwQdQqTZguGUKo22uvsljNlHQgZyTrbuVDqvP9Yki8DOFeMIHfjTIdNrzx1qX+OjOhqQm3LfeQArdU2qhOp01goV1QT6dQ0oAogdIpyqdPyp/939A3Iljc7DASwKKDaIZyqQrEYsMg7bzqMTo/uIbIPQYFMtShsNv672UsTROpxoxEkG72LuUHotK6UbOmDAgaDDVoSXbDqRhD1k07EsRwbeTLBimgJSLDLyFcbW08X6Q5A63NUGdhKI807Tp1gvDsC2BCyEqpPXmchl5XT6Lbi9HrInYZIYk1Dd+DQGVctUZnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FsoKV1UlqZH+nMGWf20k6RiY8tQS00AK+fknzdW7Wk=;
 b=rFMt8YYcku9qm1ugeV14rtzPOHeyMnpcmF/GlV6jLiu3+rLOz6uTicU6x9gkUDWeK68hREruQrBHREFS9Eo0YQH9ii5o2les3AJt42q2+/JjjHt43oeM5zC3pSVWcaWzbuOnc+pK0N4kNPcvJ6x3c73Wps4aoRogl3OTFGqxu1TRgj3H09nBu4eFVh+oU6WGOjT/llyeSh/qcGgH5TDlu/OScrH4Njkhmg40qj1tp1NdTEEpMZAwvd+4V7iwa99FcaeaWZ9MHrJPI0D2zW8nshKc7PnEWj1b7KcMKklyynFD1TU0WFdVjOc80abB3wc0zPibh+3dzcmdudwYeim/6w==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYVPR01MB10637.jpnprd01.prod.outlook.com (2603:1096:400:29a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:15:33 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:15:33 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: [PATCH v2 3/3] drm/amdgpu: unwind module init on failure
Message-ID: <OS3PR01MB10251DDCCB8C7F7DB85CA9289E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: "Alex Deucher" <alexander.deucher@amd.com>, 
 "=?utf-8?Q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>, 
 "Kent Russell" <kent.russell@amd.com>
In-Reply-To: <OS3PR01MB1025124AAC2F9492FCB206AC6E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <OS3PR01MB1025124AAC2F9492FCB206AC6E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Date: Tue, 10 Nov 2026 15:15:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TPYP295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::19) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <2afd84d7-259f-440d-9189-2cbc423fedf3@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TYVPR01MB10637:EE_
X-MS-Office365-Filtering-Correlation-Id: 11626b41-5514-442b-ca6d-08df3f3d76c0
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|55001999006|24021099003|25010399006|6090799003|23021999003|15080799012|5072599009|8060799015|19110799012|41001999006|24121999003|25031999004|22091999003|51005399006|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUdWajVJbURhRzhHNGN3N2hFNmVvZXk3WXFUNTZUZFpRM0YzSzZFR1hHVGxS?=
 =?utf-8?B?dVRhNGVaTlpUOGhUWFhhSEdLSjhYcFB5VW1OMGJtb0lDWlNnSnNoSUpGdnVF?=
 =?utf-8?B?ZEFIeDRIcVVsWnkzT1cvNjU5MzRWMnIwbHQ1ZXhTQ2QxMXEzVEFJM2JQNmxB?=
 =?utf-8?B?dnZ3YlJhN0dCUXNBcUVEcWJDdnFkQ3ZoYlNvR0lQcDN6eldQUGF0TjZzTjZ0?=
 =?utf-8?B?cFV5NTdiZFlVV2hLVXB2MDlNbGFvZnplZHpsL09DeGxtblNDck0vQ1NJeHdM?=
 =?utf-8?B?K2JERFZFeDMvMGFGbjd6UmdsSlAwMGNsNFhTY1l2WU5EcDBhQ25zS212eHl3?=
 =?utf-8?B?cWUxTCtGOHpoYlJrdnppbmdOSThsTWNnQWlUSGg5TjQzRmwwN2RUazh5UktG?=
 =?utf-8?B?YSt3TGNxeHM4WUQ2S2VIYzJGZW5oc2ppWitkQkkrSFd5MmZjdXFEMndHQjYz?=
 =?utf-8?B?OWMzL1Q0aFN4akFjczZDbUFXaExFc3hub0lWMzQ3YmExNkwvQ1liVHVMRkg1?=
 =?utf-8?B?ckNHcHhNTVJ5TEJDU1hFWEdiaHlZRXZtdjNaWTlWd1VZTWV4M08wOVFVK2tp?=
 =?utf-8?B?NG1GYlIrNnhKNURMMVBLZXBxak9sZU1KdEFHQ0o0V2t6QlZCb3RtY3Y4b3JI?=
 =?utf-8?B?UVNqcDBuTXFkYlpkN0tPMWlSTkFUSmswbTZDb1VsVXhvcXRWWUR6ckMyK2VR?=
 =?utf-8?B?V0hwY3pRRGFUSDlZenJyNzgrVDRRb1hSY2U0Zml1OEE3eVhROFdUTGtmSmtT?=
 =?utf-8?B?Y2hzWkV6WTRKNjlIYWUxV2RDVnBsQ1M5K3dhK1RIb1UzQWxJSmdSbCsrL2Vu?=
 =?utf-8?B?UTd5TGt0OCtueE9Lb2NhV2NpRVArYVJIVitIUTArWTZRbUhHRUt3dVN1MW5u?=
 =?utf-8?B?T05QQ0pheGpqR0F6bTZDUE1hS2JJQmZjcDVnSmlpV05odXVwWWlTL2wrRDlj?=
 =?utf-8?B?dXJQeHhqMlFyT3IyVHY5K0NTOVdmdGgwQXFCcjlMcnFURXdEZDlwZGRyZ3Bn?=
 =?utf-8?B?clJOL2p4eGQ5bkhUWlRrRlYrRGlEYUhhemY1ZHFNc0x1TlJZa09TZHloY2hs?=
 =?utf-8?B?dlRpYU5VSCtkaDFpNGlDTWZEM1BzeXVxZG16MW1hQlJtMmZuMmpValZORkpF?=
 =?utf-8?B?dEhrVHBxRWJmQll3OEFlcjBYSFVONHgybzQ1bDNQMVZLUy84eG5BYjFsQXdS?=
 =?utf-8?B?azhLM3JzcTlPTzhqRUc4Z3VWbmN1MkM1WEpoU2JaTUVxNnMxRlQrUHlrdjZj?=
 =?utf-8?B?WDdVWmhvTjFpTUhmZjlWclk1VFoxbVQydGhlcjhBNE5yZTc1VEJzaFpyaWQ1?=
 =?utf-8?B?am5PTkk3YU9YdU9RY3RCYjdocjZHZGVCa1QzdHQrcDI0c2lKVVVKNm1OcThK?=
 =?utf-8?B?NzRuUXhNc0VxWWJzSEZKb2Y2ZmtOTkJ5eTRPZlUyQnFEVEhBdCt6TFdGUE5V?=
 =?utf-8?B?a3A0OFNyT0FXenVZWDZOVlEwVGpManJ0NFRyNHU0UmJlemc4Q1k4c29kK1Mr?=
 =?utf-8?Q?l9CQbk2YFkPmS8Q3poBO62rrCqa?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUY3L2laVzYvTldTeiszbzJXWnM5aHlFeDhIblJmb3I0S0U5Z2tCd0RwZXU0?=
 =?utf-8?B?M0xUcGhsL1BZaFA1Smh0SU12akpZa3daNy9Lam1QUzNDUDZKTkxocW80c29k?=
 =?utf-8?B?R2hxUEIrWVgxNmNvQUVNMHJyaEM1bGd4aGw1NWJZckZnWEFaSng5M09vUXBj?=
 =?utf-8?B?MUNRYis2Z1c4QTFySmY5aWlqQnY5TXBXTmF5L3R0ZjZNK3pGWWRWQURRMWc2?=
 =?utf-8?B?NC9nazM1T1ZGRHhrRGh3SjhXVHUya1BCT1ZPSGs4bDM0K2RrUDB2anNaYTAy?=
 =?utf-8?B?OVZOdDV1SytTajRQaEI2ZThrNDlkV2JjYVBPdXZBTHZzMjN2RjV6d0pEVjFw?=
 =?utf-8?B?eWhJS2d5MzU1K3JYd0xDaGQxVXc1eU9MSzQ0UENGdFY3WEo3azRtdWFPdVg0?=
 =?utf-8?B?S3NZbDdZNk9meGtFNHR5TzYzL3FTdFltQTc2ak82RzM5ZmltNWcrN05ISGZ2?=
 =?utf-8?B?ZFdqU2FhclF4UU9uY0tnZkFmbVNkSlhFUzJsR1pCYzJ5c0xqMllWUUl1NmNa?=
 =?utf-8?B?L2hOM3lla0lkOEtrRERhYnlTbUZGL1dsK0pmV3RabUw0dlJ3NHhZVVY3L3A2?=
 =?utf-8?B?SGxwdkRld0VWM2lzRVFKRDhIem5IQVdaaWpncDJ1SWhKQmFiMTdsTTBmQWQ1?=
 =?utf-8?B?eTErSjV0K25zMjVsaUt0NzJ0eVRic2dLUlQ5VzMyRXdPV0NJMHplODdaLzFB?=
 =?utf-8?B?U3dmdldNaFl1S1VZbXV2cnhRbkdxeTc2K3A3cGZtQXNJeDExbWRqNVFVdzBs?=
 =?utf-8?B?OUpxSmhCaGJRYjdMVEI1VjIrKysrb1hIbytQVkdxelllNkM3MnMrWFV2UlFl?=
 =?utf-8?B?S0IxOEQ5UnZQL0p3Zk5FR1J6OEdDYy9Ca2tYd2tqd29BTU56YjJzSm1TSzlY?=
 =?utf-8?B?Qjk3MUNVdnlKbW5neVBxUEs3ci9UQjgzaVF2WkxGd0RwYUs5eGNUWjl1Q3hC?=
 =?utf-8?B?NFFJTlM5OTA3S01UZXlndmZWSlF3NzhqamhTNzBEMlJuTkRVRlhQL2N4VWdq?=
 =?utf-8?B?WWVhc1JYUnV2SzA4b2ZFRDkwOGxCZGxjRFlTRXg4MDkvVFl0Ky94a1VSVVE2?=
 =?utf-8?B?ZUtsTUp6RUtJcmdCU3FaOUkzMDRhZTNBTEpJYTZXWjl2SXIzMGlMSmxKVkx1?=
 =?utf-8?B?TUtYTWpQSGJlSXc2cUZOaE83cHUrdFlic0RIVkxwd1ltMStjcklsaUR5UXpp?=
 =?utf-8?B?SHEvQUVYUWtMNXJUdUFFZzFWVkVHTUY4QnJrc2NFbFlLNW1JcDdHbWxlUmhU?=
 =?utf-8?B?dXVHOUZlN0UvcWE2ZXZaUDhldER6K1lLMVpQMCtaWWtHOE91KzA1T1FsemZq?=
 =?utf-8?B?WVlhS0Jqa2dHdGQ2QndWSHV4VHlpNzVzaVBSclhBKzN1RmY1UUg2K3V2bkpT?=
 =?utf-8?B?YjQ4bVFJaXlLUml2L0psWmZhSXFTTExsNGpLMW1DaFlMMXN6TFpGbTdLcXJu?=
 =?utf-8?B?UVFqcVlLU2t5UTUzTEw5K1JXd01ITWM3MnViL2pXTzFJRE1EaTlUUjkzYkMv?=
 =?utf-8?B?SFI4RFE4Wk1HUnB6WGpWdVpqTjBDZzBCcXdIQ3Y5bTdNUldPL2RscmY1Vngz?=
 =?utf-8?B?SkdYUkFSL0xNc3dvRVJ4U3puK05DUW5LR3ZBbnorKzlOdkIyYW9oQm1Dc2gx?=
 =?utf-8?B?NjFQai9ZaFU1KzFGWjV6WjErWnVTV2JJNTFUQStwaFlmbURRemJKQWVpc0ZO?=
 =?utf-8?B?VElyMjRLUFJpRk1vMHVscjhUYjFQTkVKZmU3ekE0WFJYOExYZDI5S2pQM1Bm?=
 =?utf-8?B?alF5aFZEeEZnc3RralhiREtMZU9oak9TVlUxR0dMSkVmVVhSOXN1bUZjQUpL?=
 =?utf-8?B?bHZtR0toSFVoaGFmNTVubk1qMS80RGdRcEpTNDhNd3lYVWhzU3ZaSVBwZ0Fv?=
 =?utf-8?B?Ukpob05CY1JPczR0cVdvYUQvT2pwTGJJRnduSnMzcGFvM1E9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 11626b41-5514-442b-ca6d-08df3f3d76c0
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:15:33.0365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10637
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

Unwind in the reverse order of initialization, starting from the last
step that succeeded, with the same calls and in the same order as
amdgpu_exit().
amdgpu_amdkfd_fini() is a no-op when KFD was not initialized, which
covers the ignored -ENOENT case, and amdgpu_unregister_atpx_handler()
only removes a handler that amdgpu registered itself.

Fixes: 4259a25341ab ("amdkfd: Only ignore -ENOENT for KFD init failuires")
Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 564dc24..a6db7f9 100644
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



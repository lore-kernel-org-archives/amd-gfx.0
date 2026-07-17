Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59020C4451B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 16:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B2C10E4BD;
	Fri, 17 Jul 2026 16:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RelqKIw6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B547E10F5BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 16:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PinbmK2vceDECBTF/e2LXNUWlwas4Dl8UKuga3itpv15v9hhSJJ4ZAeRHk9pXoQU0EMfemD1ObbLiMEuewjgOlmgcnvpZrgaPFxDORvNLB803LimuBKi8UPmEyU1NCy2u6GZfm9Do7mMYAL7O70Fd6NI1BkiLiZMfQy70W2SLk88Bb/ZlZrKJV+bRQ1qfk2SSrCGt/b8KErF4xosPpi9nUHw3i63U4RLOgQVJXBmGjNawI4PqtBrPfb3HsnVKdjyZvru2xeq3auEzURFHTupY2F/5yUFc6G6nRbWyEYM7GTJ1BdKoItW1L6HYAqpTCzt6pBpuvh14T6NsvkC2HLLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMvJGsl4CGrirrVD+rTAtiIo349Qzlvm7y8ElW4muwA=;
 b=devGexiQwDEFRPmJESxokmtMUwWvnFeWp8e4oV1TOOmnZ65kDsy+WzA2HYrTqnazWG8SLUcFq24/FEPmgL1mHKze10LfdvsUNDfgtTIYChqx5WwipqeWxOxSovqPM/TfmiD0w7J1y8PmRdhSgAyzg46KAHkOnJhUlKs/fzZ9Ot7uV6mtlXhoGn2GoitkxykBa+jCqSD/i/5274vvsiZ/7IQO2X1vkNWVlU/ooi2/ElpsN0ZTP9n7iGLzJlXad/WHVG1xZ+Rtvi13DpZqX8wmpDMsxwzG+eNpLKv/tEG4laNpY9ZjaBTcfaf1Q3L/DoCLTKqIYyloAmwwwpreson3jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMvJGsl4CGrirrVD+rTAtiIo349Qzlvm7y8ElW4muwA=;
 b=RelqKIw6ReADFAWRsti3Yv9mEOPSblMkRLTpUWhmA6GQpRYAHpMSjWGZV7U/Wm/J9Q6ul69s4VB5nBUr86ZsHyAoCYzrfPlfYkNCmIAb5pTwdUmkW97aw7XT8fxjHktKdER4g/qwi/N39OQ7bOol/KzfPfwLKK9P0a9ZnnHotGw=
Received: from SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 16:04:27 +0000
Received: from SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0]) by SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 16:04:27 +0000
From: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: fix QID bit leak in pqm_create_queue()
Thread-Topic: [PATCH v2] drm/amdkfd: fix QID bit leak in pqm_create_queue()
Thread-Index: AQHc/pvT5ClGBwC5gkq0xEhfw51mGLZyDn0g
Date: Fri, 17 Jul 2026 16:04:26 +0000
Message-ID: <SA1PR12MB8600221AFFB709854500D0D59FC62@SA1PR12MB8600.namprd12.prod.outlook.com>
References: <SA1PR12MB8600B7A9323EB2698E2C20A49FE42@SA1PR12MB8600.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8600B7A9323EB2698E2C20A49FE42@SA1PR12MB8600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-17T21:02:26.1860000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8600:EE_|DS7PR12MB5813:EE_
x-ms-office365-filtering-correlation-id: 1cbce3e9-f5d9-4719-58fb-08dee41d13c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: qzHXPyd9v7xFOWbgnJCIqzEAl9CZnhCpvyOlWYdvQfWFcrQOUyPdKHiTjQ2cE1wE3eY3sJwYXsHeDn7Sqea1XCAC39Er6DrE87Kj88l32B3vdlGFc7WL1l+iYdjPYPKZd1HP7vQtmbBa2h+HsdBcgujx9bNN4kIGAIOWnLAFTvAexYrjzL5Y9VmlBSzEAGXpItFPYfTXiOFcVbp4xsN3ImF55xO4tcuvq3peEMwi18XwkPMAM/dlxCiSBgW55FMfh1bo0Ve/F32iuWpmxB6oKBF4GpG8Xc0qBFUcKVBthSWWPTZAk5+xMoUHFIEAxjTUfk0QZ40Xo5In26qjK9zNh2L240Il1AC7SpK0KuxFV/hzydzzc5g6fGYDSQ3gjGgQxqeiXZW0tMa2aTO2wCXlFbDNW93V5dwiGdxjuwtAhfeIFuC27m9ih2CGLsm7GxobWENjFD53+0DMePkWxJGu41zDBvxbpbjPi+bgfFCNlqPJEEUNKkXRjovbDGmKuLbu6GVjWN4yJ8ytdSp0o1IGfxbIGqbgm0xBaKDR6vpu+LLWIw+iI8/TnMunqZIzQcqZRQ58B+NeveH9wsjoEGELueC/f8ZKLRY8g3wnLxHCsDqOyPqDtBWtgdHW+2ZHTvrr0XCobvTOn7DoKVeFoZtZCWr2aR7UGJIasV40jJh9iXNLqwbogNfSeSz9Uy3ZnFK3VZoL6SpWTN9df8frcJJvFV8kNqyH59patUXihCy6ISE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s4KM7aL8liQHaprhjbEv/PCpCR59MnuZoG98AMRn0ap91U1t7lyyiLGaac?=
 =?iso-8859-1?Q?6gob0tkzNHTXHKSHMIYWRY3rEyeDyJ94nEzI8H+KpD30GBe10eU1ar0dXV?=
 =?iso-8859-1?Q?W1SCsIs7YgHVYmZlq5/vgg8l73SjEi7HGcbUXluLXePA1wu8bY8O6eWxbz?=
 =?iso-8859-1?Q?11neBtpUEfhW1NTdAFjLb2lrwpPCidhrW4nh0UxehL3X2If3mCY3GGe7yh?=
 =?iso-8859-1?Q?bejeM+JHHd4YlV6IA4wHDASRam8Zr108wmMAviKP7KC64MBeNrT0agf23V?=
 =?iso-8859-1?Q?l3kllonlNW/RgagHz6ZdrknFiZ+pJ0GdRQ0rs+KClt/CkiCqTa59+qKkvw?=
 =?iso-8859-1?Q?vdt8F4i+pwPBh/UKE4q5M777JlMKVNA917PIilvtdlsE59+5wYpIENSpLE?=
 =?iso-8859-1?Q?A1SkRIGLkEgUgQInPZLZc1BXs7wfdIaLP0W9MGcJPoD7zKMpijTc0muKBa?=
 =?iso-8859-1?Q?yCeGHvCmDpIRJNY9Fj73A9snUto1r645DxCERlpz+QdDE2U6U3kyShwWtb?=
 =?iso-8859-1?Q?SsokwvNiCgDAM9A2p/tRG1h+TwJHUXJbGX5EqK+atABt44e6/NcSImBACv?=
 =?iso-8859-1?Q?IJ06RYXnLOcrcJFfZQEQwhXAN4wZhBUz0Vb+ItKPDVgtY6BlJO+FR8XBsj?=
 =?iso-8859-1?Q?0ia6U5euT4msUR2iwWSnNbTwv94qxiPHNC1vm7vDCfZyfU7qkPqAr1Bixr?=
 =?iso-8859-1?Q?tzeWLDaDaptuVzKoBzKUNsJxiJMeJiNr1Td47IJp8506g8DBzgs3XjFwjx?=
 =?iso-8859-1?Q?9dvkMqSvN3tsgnPplGMQmofZdFFvC4mF3Kxrq70x7RRyf9orbjp4+E3sHi?=
 =?iso-8859-1?Q?r8+9xIG+eFWpdHYRFqR5WaTgTIz3lf43/emfv4mpU9ER1zfi0VxQ5nPYyx?=
 =?iso-8859-1?Q?c8HvWvqglRcZgfTt3VUH4ejhrx/7mHQeur0pTSiOgTSJ19WBg8auNCya4Z?=
 =?iso-8859-1?Q?N5W7YB51hZlOPjWuanxqxp/GYmJKKgDEqa4WFirX448x/pCvM1SB12JkhM?=
 =?iso-8859-1?Q?aNG2i3eCS6AcH7ByhnaChmH+qXUYTdJy3KCaRVKZ15Sa+5vL/sFwJfsMAP?=
 =?iso-8859-1?Q?v6jWYEyydwOQA3R1UWv4qW7XI3p2PlaIQBO2jsdZptI1il9dkwzubHrPcl?=
 =?iso-8859-1?Q?cM6R+SAABtEf0wDv+xOQ5rFRsrMBu8xxBqD37x0NaG3L9U5rcD8jnsAXeO?=
 =?iso-8859-1?Q?gzVc96TEdXx3B8oLaQYgq8JHecPy0yLA2gJ9mzAVp/DVaS1d6QfpIrHBe+?=
 =?iso-8859-1?Q?hX9mQtTqBeoYOHy7q5XC3U94hSY+kO68des9AcE6trVUUlijpmHwbgcbob?=
 =?iso-8859-1?Q?gB92IxwWg+vhRlxwfIB6GXMusgA/ZQmahdohH+YHW2WWu1iG+S2Xc0vWND?=
 =?iso-8859-1?Q?uxxhdSn5JS/zOx7go9oWuaF/ALas8mv2GTa+MHYe7eu3G3ZdCx8933cffb?=
 =?iso-8859-1?Q?rwmkcR1E6oogZ/NqTTAiUDW7gi/Kya1pOrnkwsy4kiF9Fja9yKs+EsgeSD?=
 =?iso-8859-1?Q?PDRMnRAz/M+c6Yxxz+Vam9gnkzIxoi0G7IqPDcUZTXEjAWlQvf7qbEUXst?=
 =?iso-8859-1?Q?yXPv2ahcrrtLeQuYvlJo42NhH6nIr7deGYR5TYCfXARs4zkgzBil42xLQu?=
 =?iso-8859-1?Q?zaYJbdx6KvxH8S+3bO3tJyuDGKzSvaoTlmpRs9ZzyTrgyjvWNyF18njdAT?=
 =?iso-8859-1?Q?0v5n02RZ/hLH3kw/zQDP036EMCY6SqqyxoLQT5xyfqiI6PEgtr8Url1gPX?=
 =?iso-8859-1?Q?iT1IzMLzdKByBARv+uUd2DtY3LHUJMHVgFlPKJbBtVrCEU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbce3e9-f5d9-4719-58fb-08dee41d13c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 16:04:26.9385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geQPye6E4YTOUTvwxbigkESE8oYuzU78EHZt6JqV5O2d4JrCYRZ+7rozLEptzpbGoI+5A6RLBu1/f+bJiyyk7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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

AMD General

Ping,

Can I get a review on this change please?

Kind regards,
Vladimir

-----Original Message-----
From: Marioukhine, Vladimir
Sent: Wednesday, June 17, 2026 5:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH v2] drm/amdkfd: fix QID bit leak in pqm_create_queue()

When MES is enabled and amdgpu_amdkfd_alloc_kernel_mem() fails during the f=
irst queue creation for a process, pqm_create_queue() returns early via 're=
turn retval' without going through the err_create_queue cleanup label.

This means clear_bit(*qid, pqm->queue_slot_bitmap) is never called, leaving=
 the reserved QID bit permanently set in queue_slot_bitmap.
Over time this leaks QID slots, potentially exhausting all available queue =
slots.

Fix this by replacing 'return retval' with 'goto err_create_queue'
so that clear_bit() is always called on the error path.

Fixes: AILIKFD-813
Reported-by: Deucher, Alexander <alexander.deucher@amd.com>
Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>

Changes in v2:
- Fixed author name format to First Last order (suggested by A. Deucher)
- Removed incorrect attachments from mailing list submission

---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 1234567..abcdefg 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -378,7 +378,7 @@
                                                     false);
                if (retval) {
                        dev_err(dev->adev->dev, "failed to allocate process=
 context bo\n");
-                       return retval;
+                       goto err_create_queue;
                }
                memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
        }
--
2.34.1

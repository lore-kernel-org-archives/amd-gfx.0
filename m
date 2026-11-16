Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE625606A322
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h4WMj/rt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724E010F43B;
	Mon, 16 Nov 2026 20:21:54 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A9D10F43B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 20:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7GyW1VK27II1eljgderZOz3l+2EdRczPhpHvzyZQu3ue8r7l7xJUluop4XZYIx7jcStlywswBBgJ+pUYeSJsdLERpj8KhrPwio5dz3VkLqTnOejbvwIvHP4GgM1O5SJTVMHI0Qk5FNSLyVcZt02Hv65U5ms3jwUGo0/aCQ1t6FlPOqbRUAtNUcrY/Jn9EKvbn2VoH9MZjh0Uxc3Z6ld3wcTsIuM2Ep6Gw2zQ0QbavvojJlQ4bAE9uRPxIMklwC9wIneTN7vqDw7jEYo3NnYuFA2MDdr1wHjlxfdJa1OE6STJMUw+u/WXEXbe50ZEu65wHC1mgRJknN47i1kb1+nEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEuOBccp9OqkqdKC9dTDJ9K2vhSbX1W7rw1kc6TkEBQ=;
 b=G5/BX7pTH9Fc4ShY1CzgU6zFhfVZWnu9JL+gYjeYWMM4yz9J1KVmQ9DCcsLst1S5cIxsIw84x3h7+vckMGk/Pr+UtKXCBqT80v4jf6LIoGd9Ku++ZxkQUA/hHIa1aCViw45vDA2adxLYnXVS5ITh/GYKipa9Btl1sLyxmK8RejAyjff/rz7saPQ0N8Mw6A15D0v4eOaLFhiDu28alE74QUwXbk21xPDr1RRWCuQl2+51Nqi8OKveR6RuFwhPCl8ih9zbi2sEB0tr0g8K9W/V8yDkgVOs90xzdjD9oLJOGlLVLcyC6vRPtgPNwMx2fO4d6SSAcjgKEGyD2H/3Dpaudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEuOBccp9OqkqdKC9dTDJ9K2vhSbX1W7rw1kc6TkEBQ=;
 b=h4WMj/rt5OsV+Hf1mnhb2UmiAKaLpMu04vFbTK3dvLPb6BsHdVasfcaGHs3+d+nQZQm2EUhwEiUKlkgrDwg33ZiXYdhMMda/rVWEI+gjBQjZTwRwEJNkNV4Zr5uX7F0NRxwPHQJUW4O9p8CBDLNkJd6mXVQaWwj+De2RlfF66MA=
Received: from DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 by DS4PR12MB534619.namprd12.prod.outlook.com (2603:10b6:8:50a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:21:43 +0000
Received: from DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0]) by DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:21:43 +0000
From: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: amd-gfx Digest, Vol 126, Issue 488
Thread-Topic: amd-gfx Digest, Vol 126, Issue 488
Thread-Index: AQHddf5teS6Ku7gje0+IWeqcRoqTiLcxI8UM
Date: Mon, 16 Nov 2026 20:21:43 +0000
Message-ID: <DSVPR12MB4490959E38A5265F79E9EDAB80817C2@DSVPR12MB449095.namprd12.prod.outlook.com>
References: <mailman.24703.1794856330.6452.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.24703.1794856330.6452.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T20:21:42.917Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSVPR12MB449095:EE_|DS4PR12MB534619:EE_
x-ms-office365-filtering-correlation-id: 4c271893-23cb-42e8-1f85-08df441f3b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|6049299003|376014|23010399003|366016|1800799024|38070700021|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|8096899003|4053099003|4013099003|13003099007;
x-microsoft-antispam-message-info: qQNDbA5QssGtUkyUA/hOf7EsSr6ryaJH5DO2ImERhrGfTkYHmSLic1300Wxp1ICTJS9wHCqAh8cGa7AC9atJ4qLaTB1/6hZ6CK9VTzgwX9trAX5XSvfRUOsBdiRhRRbelJZ3OYp6RhIKfEXP8JzdnCk+jPns22x8OS3s4QsEMQKelbiuveNEn0ycbR7a4MC3qnkaGMyu6u//KF/EBZTHK96LsL6Ukr0LtGCX6yewa2YlZGv2QachwTibxcWCPUWH7WAepwVyIBQW7sMOse4boud3tjTFPvXuuASKZOdZ1zNObiU/rfyqge501ZEaOxxm6F/P9zvMlpjcOhQN1rW3Totbn5dBZTcD2YPtDDCEtrwXpTADotf2L1OyeVJgGnM0SM0Ggo22EOh3kXRhKAzlCa7LuL+J4yUtKVDCOVkQNSiRhuJyZ1IDjzmeF3cqrkdfAIjL3Pk+hAN2BzbvIynU4wdrWKfjbxS1fr1vm76GGG9VisQDUxboMOY4Vtt3UOwUlidRn8wbtURIO6m6eJxS8bXMO2SE31NZXGt27/57zrEIiJXFSN6NH/OKtYzf2+Tb8lajGS6SfnCLzW+tlCmNILvLXW9eLZUq6CY+H2QJT5MGE0WtwFmkwtLNOmToUw4lghuJgEehpm90U/womYOe1NAGU9GMtx2dNi4Ek9iz8aF42ItQt1tmuZ1OQJK+UGiv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB449095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(6049299003)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(8096899003)(4053099003)(4013099003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?imr4Tb4ZPQrH1VxzOMQBuZi3Rhda0hT/RJNnCN75/hF8NDhG/wbcT8L1au?=
 =?iso-8859-1?Q?velIu8yFTq4LLzpRGwYYihgRq+4m4S6cHuDpUN5WcVUVt5xFDuDHNsE5Ga?=
 =?iso-8859-1?Q?KkIghRcjmUXvdWpxctWPqYQKukSfKuF6i1qipdAXFTq6RTZNFw/DSOt2kQ?=
 =?iso-8859-1?Q?ohARafA6fNt+4iVwCn5l2i05+qvwkyaQKKt8hPIBbfFObXkReiwTe56bPH?=
 =?iso-8859-1?Q?Lyen52pYbP5RiX21VbJ3ouZWahp+cY9BSdvy49XO+xHTENLNvAeit5OoEv?=
 =?iso-8859-1?Q?hnpE+I65bzndPfMV8DfpAT66tCay89ETtMpTWKc7Qd8JimfX2anx1QXFHo?=
 =?iso-8859-1?Q?AgWK7gx0EwdIJukphDhsXlfKYWTw1fk3gk3j/VQW8tEQGe2d+cI5wHG/ZV?=
 =?iso-8859-1?Q?O2PhyyhnnpCDQTOn+bruedjgIjNmxDNllWlbMBDv8HqH5a8Lt4h/MSMUfb?=
 =?iso-8859-1?Q?rsomcgk/6X4ONofP7Eq8wRpjFIaiP7VKC2ZEiX9zIy7AfxsZwlaljLvIbr?=
 =?iso-8859-1?Q?kddCMqNVOPI5VnnNoNOtoA7EBHrWATr7GGHzYsgnaK2O6mYp9QOptKIrHe?=
 =?iso-8859-1?Q?vR8lts8k6wE62NdyY+zpMik3Htg4QGIqcv0h++e+fE1SKQqkXNGIFmIybB?=
 =?iso-8859-1?Q?hhhQN2RHCDkgA06pJzNZVQe/i3w1Ruil7ar4/C6MZg3sHmvog3lPSXLCy8?=
 =?iso-8859-1?Q?WiTR15f+S1cjVoKngMRcGYIlvh3pP+kbPth9GFqmOj2vz/NaXYgzZo2UAO?=
 =?iso-8859-1?Q?1zUsrIO0Yj+7A7+Zqq5gg8CaWTp2WuEk6k8JpBXR9J6Ol+gLQg6RctVO6I?=
 =?iso-8859-1?Q?Vad1s1dA6qnj+0/2E8l7C7XTJTmjGnEKy5SQMORLlfFvMZL9mg7LOlcecB?=
 =?iso-8859-1?Q?GA2d2b5q+phxp2jNq1FZnVJlULjhGQ2Z0bHqKV8iv4sT+BLf5qN64prC6Y?=
 =?iso-8859-1?Q?U6UjHGOCM2co9hZbIk1AN/14kJrgS6RmU4UAY+KtDb36gXoQDW9p9uhMmq?=
 =?iso-8859-1?Q?1t79ls6hvmGvUDEJxNH7C13HSaWSCfYTNJAghU0TwN9cfI9hzJuLassXTf?=
 =?iso-8859-1?Q?0CzIEdN1uVzQmWQO5TrqfOh4zcxNY8iEzPUFMenJhwdIlbx+mrYNh8weI/?=
 =?iso-8859-1?Q?kUhKJSYebibiMCi7jHtqjDnlrvSPsW+yRpIrgAztCaVqpRtfGmGwfn6o1p?=
 =?iso-8859-1?Q?tgz43CP0Vbv6oNUcQFvydtOUybFfEjZLL6neO8LWenPDZJRtgf4nfpdwws?=
 =?iso-8859-1?Q?iwKDq7Q59rFJVh0GmplNFbneUqvFHqL0PsAuDI4GVR0kCuw9ZLidoANqq2?=
 =?iso-8859-1?Q?rkjy/gzX9Ze3G7itv0hYnnkrDxhNh1pUVKWQP77NCnSdQ4SR9UBeIE+BN8?=
 =?iso-8859-1?Q?LHqUfQupIwHa7yrY08TVG8Nq889ueio1V1FaO3gw80K76NUF3Xx8BFHSq4?=
 =?iso-8859-1?Q?HU36zmJBGaLV2JFG6qpS3jyYmeGK6TxeuU+KJTyEHn18wMH0RKXSlDyI1b?=
 =?iso-8859-1?Q?vO4Y/mlgsN+uwQQYjRv6X2dA9Yu/Go/C3qWJ/VRRhe2VFTMfYSafiGu+XL?=
 =?iso-8859-1?Q?cQJRKGPkpwn3BgEV+aqsLSlQn4JM9w8h1gDKwBwTkN3G9q4KlL8brPfK58?=
 =?iso-8859-1?Q?hTu/w/BxCJqQ61PvJLIXV0CFtNpzyQGXWB2skbKkBHE1Ynz9kaJng4AfTj?=
 =?iso-8859-1?Q?NgyEyt2YkHM+jJHLQWDVp3rn3UeOWOKs+JByrCctIXKejs4I+F4zeMPVnJ?=
 =?iso-8859-1?Q?5e+FPaA5Fi0MeNBBcjhM5q3f5BD/efUZVcX+C5L4OxE49s?=
Content-Type: multipart/related;
 boundary="_004_DSVPR12MB4490959E38A5265F79E9EDAB80817C2DSVPR12MB449095_";
 type="multipart/alternative"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB449095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c271893-23cb-42e8-1f85-08df441f3b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 20:21:43.4306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWDr1/3Nl+uJanlatKnv4PWX4fmPOUB4B8Oek3rqwB3fyHsh4Mhy6WJlqyQi2V8TlGW1K+/+X0isXWHVQwZ1SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB534619
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_004_DSVPR12MB4490959E38A5265F79E9EDAB80817C2DSVPR12MB449095_
Content-Type: multipart/alternative;
	boundary="_000_DSVPR12MB4490959E38A5265F79E9EDAB80817C2DSVPR12MB449095_"

--_000_DSVPR12MB4490959E38A5265F79E9EDAB80817C2DSVPR12MB449095_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General



[cid:506ed06b-241f-4790-892e-ee2dacd24342]<https://outlook.office.com/bookw=
ithme/user/5be71e58d07c492d97048217b901df8e@amd.com?anonymous&ep=3DowaSlots=
EmailSignature>
Book time to meet with me<https://outlook.office.com/bookwithme/user/5be71e=
58d07c492d97048217b901df8e@amd.com?anonymous&ep=3DowaSlotsEmailSignature>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of amd-gfx-=
request@lists.freedesktop.org <amd-gfx-request@lists.freedesktop.org>
Sent: Monday, November 16, 2026 2:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: amd-gfx Digest, Vol 126, Issue 488


------------------------------

Message: 4
Date: Mon, 16 Nov 2026 14:10:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5 v2] drm/amdgpu/gfx9.4.3: program the RLC SPM in
        RLC resume
Message-ID: <20261116191022.1955106-1-alexander.deucher@amd.com>
Content-Type: text/plain

The register needs to be reprogrammed after a suspend and resume
or a GPU reset so program it in rlc_resume rather than rlc_init.

v2: pass xcc_id when calling

Fixes: 7c0f7ee00c7d ("drm/amdgpu: add gc v9_4_3 rlc_funcs implementation")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index da031caa4e9e6..7b8ff043c99ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1395,10 +1395,6 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(str=
uct amdgpu_device *adev)

 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
-       /* init spm vmid with 0xf */
-       if (adev->gfx.rlc.funcs->update_spm_vmid)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_mana=
ger.spm_vmid);
-
         return 0;
 }

@@ -1588,6 +1584,10 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_d=
evice *adev, int xcc_id)
         gfx_v9_4_3_xcc_init_pg(adev, xcc_id);
         amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);

+       /* init spm vmid with 0xf */
+       if (adev->gfx.rlc.funcs->update_spm_vmid)
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, adev->vm=
_manager.spm_vmid);
+
         return 0;
 }

--
2.56.1



------------------------------

Message: 5
Date: Mon, 16 Nov 2026 14:11:41 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: <jay.cornwall@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1
Message-ID: <20261116191141.145348-1-kent.russell@amd.com>
Content-Type: text/plain

This feature cannot be properly supported, so disable it both on the
amdgpu side and the amdkfd side.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         |  5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       | 12 ++++++++++++
 .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c       |  7 +++++++
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 08d3ff61edcc..d0ede277aa85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *ad=
ev)
                 gmc->noretry =3D 1;
         else
                 gmc->noretry =3D (amdgpu_noretry =3D=3D -1) ? noretry_defa=
ult : amdgpu_noretry;
+
+       /* XNACK cannot be enabled on GFX12.1, so keep noretry=3D1 */
+       if (gc_ver =3D=3D IP_VERSION(12, 1, 0)) {
+               if (amdgpu_noretry =3D=3D 0)
+                       dev_warn(adev->dev, "Unable to set noretry =3D 0 on=
 GFX12.1. Keeping noretry =3D 1");
+               gmc->noretry =3D 1;
+       }
 }

 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_typ=
e,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c
index 1f57d0fa2c04..034cc3fd07f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_=
device *adev)
 {
         u32 sh_mem_config =3D DEFAULT_SH_MEM_CONFIG;

-       /* GC 12.1.0 A0 requires RETRY_DISABLE in SH_MEM_CONFIG. */
-       if (SOC_V1_0_DIE_REV_XCD(adev->rev_id) =3D=3D 0)
-               sh_mem_config |=3D 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT=
;
+       /* XNACK cannot be enabled for GFX12.1 */
+       sh_mem_config |=3D 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;

         return sh_mem_config;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 3d2136adb62b..3b62b9e5ecda 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1766,6 +1766,8 @@ static int kfd_ioctl_set_xnack_mode(struct file *file=
p,

         mutex_lock(&p->mutex);
         if (args->xnack_enabled >=3D 0) {
+               int i;
+
                 if (!list_empty(&p->pqm.queues)) {
                         pr_debug("Process has user queues running\n");
                         r =3D -EBUSY;
@@ -1780,6 +1782,16 @@ static int kfd_ioctl_set_xnack_mode(struct file *fil=
ep,
                         goto out_unlock;
                 }

+               /* XNACK cannot be enabled for gfx12.1 */
+               for (i =3D 0; i < p->n_pdds; i++) {
+                       struct kfd_node *dev =3D p->pdds[i]->dev;
+
+                       if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0)=
) {
+                               r =3D -EPERM;
+                               goto out_unlock;
+                       }
+               }
+
                 r =3D svm_range_switch_xnack_reserve_mem(p, args->xnack_en=
abled);
         } else {
                 args->xnack_enabled =3D p->xnack_enabled;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/=
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
index 525989371378..63ba13a60b98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
@@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *=
dqm,
         struct kfd_process_device *pdd;
         struct amdgpu_device *adev =3D dqm->dev->adev;
         struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
-       bool xnack_enabled;

         pdd =3D qpd_to_pdd(qpd);
         qpd->vm_cntx_cntl =3D hub->vm_cntx_cntl;
@@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager=
 *dqm,
                 qpd->sh_mem_ape1_base =3D 0;
         }

-       xnack_enabled =3D KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev) ?
-                       pdd->process->xnack_enabled :
-                       !pdd->dev->kfd->noretry;
-
-       if (!xnack_enabled) {
-               qpd->sh_mem_config |=3D 1 << SH_MEM_CONFIG__RETRY_DISABLE__=
SHIFT;
-               qpd->vm_cntx_cntl &=3D
-                       ~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVA=
LID_PAGE_FAULT__SHIFT);
-       } else {
-               qpd->sh_mem_config &=3D ~(1 << SH_MEM_CONFIG__RETRY_DISABLE=
__SHIFT);
-               qpd->vm_cntx_cntl |=3D
-                       (1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVAL=
ID_PAGE_FAULT__SHIFT);
-       }
+       /* XNACK cannot be enabled for gfx12.1 */
+       qpd->sh_mem_config |=3D 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+       qpd->vm_cntx_cntl &=3D
+               ~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE=
_FAULT__SHIFT);

         qpd->sh_mem_bases =3D compute_sh_mem_bases_64bit(pdd);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 546721b4d59a..059e22cd7f1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1670,6 +1670,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, b=
ool supported)
                     KFD_GC_VERSION(dev) < IP_VERSION(12, 1, 0))
                         return false;

+               /* XNACK cannot be enabled on GFX12.1 . While dev->kfd->nor=
etry
+                * should propagate this requirement, adding it explicitly =
here
+                * will help cover any possible future reworks
+                */
+               if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0))
+                       return false;
+
                 if (dev->kfd->noretry)
                         return false;
         }
--
2.43.0



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 126, Issue 488
*****************************************

--_000_DSVPR12MB4490959E38A5265F79E9EDAB80817C2DSVPR12MB449095_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof" data-signature-name=3D"Book =
time to meet with me">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<table id=3D"pbpsiglinktable">
<tbody>
<tr>
<td>
<div class=3D"elementToProof"><a href=3D"https://outlook.office.com/bookwit=
hme/user/5be71e58d07c492d97048217b901df8e@amd.com?anonymous&amp;ep=3DowaSlo=
tsEmailSignature" id=3D"OWAaac4ba39-bdd9-2d01-4310-4fd788a3ae92" class=3D"O=
WAAutoLink"><img size=3D"528" data-outlook-trace=3D"F:1|T:1" src=3D"cid:506=
ed06b-241f-4790-892e-ee2dacd24342"></a></div>
</td>
<td></td>
<td>
<div class=3D"elementToProof" style=3D"color: rgb(0, 120, 212);"><a href=3D=
"https://outlook.office.com/bookwithme/user/5be71e58d07c492d97048217b901df8=
e@amd.com?anonymous&amp;ep=3DowaSlotsEmailSignature" id=3D"OWA3987d045-1174=
-4be4-0734-e3ffc8e6fd20" class=3D"OWAAutoLink" style=3D"color: rgb(0, 120, =
212); text-decoration: none;">Book
 time to meet with me</a></div>
</td>
<td></td>
</tr>
</tbody>
</table>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on behal=
f of amd-gfx-request@lists.freedesktop.org &lt;amd-gfx-request@lists.freede=
sktop.org&gt;<br>
<b>Sent:</b> Monday, November 16, 2026 2:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> amd-gfx Digest, Vol 126, Issue 488</div>
<div style=3D"direction: ltr;">&nbsp;<span style=3D"font-size: 11pt;"><br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Mon, 16 Nov 2026 14:10:22 -0500<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 4/5 v2] drm/amdgpu/gfx9.4.3: program the RLC SPM in<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RLC resume<br>
Message-ID: &lt;20261116191022.1955106-1-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
The register needs to be reprogrammed after a suspend and resume<br>
or a GPU reset so program it in rlc_resume rather than rlc_init.<br>
<br>
v2: pass xcc_id when calling<br>
<br>
Fixes: 7c0f7ee00c7d (&quot;drm/amdgpu: add gc v9_4_3 rlc_funcs implementati=
on&quot;)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</span></div>
<div style=3D"direction: ltr; font-size: 11pt;"><br>
</div>
<div style=3D"direction: ltr; font-size: 11pt;"><span style=3D"font-family:=
 Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-s=
erif; color: rgb(0, 0, 0);"><code>Acked-by: Vitaly Prosyak &lt;vitaly.prosy=
ak@amd.com&gt;</code></span><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----<br>
&nbsp;1 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index da031caa4e9e6..7b8ff043c99ec 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -1395,10 +1395,6 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(str=
uct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init spm vmid with 0xf */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-&gt;update=
_spm_vmid)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, adev-&gt;vm_=
manager.spm_vmid);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1588,6 +1584,10 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_d=
evice *adev, int xcc_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_3_xcc_init_pg(ade=
v, xcc_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_exit_safe_m=
ode(adev, xcc_id);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init spm vmid with 0xf */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-&gt;update=
_spm_vmid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, xcc_id, adev-&g=
t;vm_manager.spm_vmid);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
--<br>
2.56.1<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 5<br>
Date: Mon, 16 Nov 2026 14:11:41 -0500<br>
From: Kent Russell &lt;kent.russell@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: &lt;jay.cornwall@amd.com&gt;, Kent Russell &lt;kent.russell@amd.com&gt;=
<br>
Subject: [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1<br>
Message-ID: &lt;20261116191141.145348-1-kent.russell@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
This feature cannot be properly supported, so disable it both on the<br>
amdgpu side and the amdkfd side.<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 7 +++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 5 ++---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; | 12 ++++++++++++<br>
&nbsp;.../amdkfd/kfd_device_queue_manager_v12_1.c&nbsp;&nbsp;&nbsp; | 18 ++=
++--------------<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 7 +++++++<br>
&nbsp;5 files changed, 32 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index 08d3ff61edcc..d0ede277aa85 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *ad=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gmc-&gt;noretry =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gmc-&gt;noretry =3D (amdgpu_noretry =3D=3D -1) ? nore=
try_default : amdgpu_noretry;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XNACK cannot be enabled on GFX12.1=
, so keep noretry=3D1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gc_ver =3D=3D IP_VERSION(12, 1, 0=
)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_noretry =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&g=
t;dev, &quot;Unable to set noretry =3D 0 on GFX12.1. Keeping noretry =3D 1&=
quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gmc-&gt;noretry =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hu=
b_type,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c<br>
index 1f57d0fa2c04..034cc3fd07f3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c<br>
@@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_=
device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sh_mem_config =3D DEFA=
ULT_SH_MEM_CONFIG;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GC 12.1.0 A0 requires RETRY_DISABL=
E in SH_MEM_CONFIG. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (SOC_V1_0_DIE_REV_XCD(adev-&gt;rev=
_id) =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sh_mem_config |=3D 1 &lt;&lt; SH_MEM_CONFIG__RETRY_DISABLE__SHIF=
T;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XNACK cannot be enabled for GFX12.=
1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sh_mem_config |=3D 1 &lt;&lt; SH_MEM_=
CONFIG__RETRY_DISABLE__SHIFT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sh_mem_config;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 3d2136adb62b..3b62b9e5ecda 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -1766,6 +1766,8 @@ static int kfd_ioctl_set_xnack_mode(struct file *file=
p,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;p-&gt;mute=
x);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;xnack_enabled=
 &gt;=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int i;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;p-&gt;pqm.queues)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_de=
bug(&quot;Process has user queues running\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 -EBUSY;<br>
@@ -1780,6 +1782,16 @@ static int kfd_ioctl_set_xnack_mode(struct file *fil=
ep,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
out_unlock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* XNACK cannot be enabled for gfx12.1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; p-&gt;n_pdds; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node =
*dev =3D p-&gt;pdds[i]-&gt;dev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_GC_VERSI=
ON(dev) =3D=3D IP_VERSION(12, 1, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -EPERM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D svm_range_switch_xnack_reserve_mem(p, args-&gt;=
xnack_enabled);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; args-&gt;xnack_enabled =3D p-&gt;xnack_enabled;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/=
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c<br>
index 525989371378..63ba13a60b98 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c<br>
@@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *=
dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device =
*pdd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dqm-&gt;dev-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub =
=3D &amp;adev-&gt;vmhub[AMDGPU_GFXHUB(0)];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool xnack_enabled;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D qpd_to_pdd(qpd);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;vm_cntx_cntl =3D h=
ub-&gt;vm_cntx_cntl;<br>
@@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager=
 *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; qpd-&gt;sh_mem_ape1_base =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnack_enabled =3D KFD_SUPPORT_XNACK_P=
ER_PROCESS(dqm-&gt;dev) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;process-=
&gt;xnack_enabled :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !pdd-&gt;dev-&gt=
;kfd-&gt;noretry;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xnack_enabled) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qpd-&gt;sh_mem_config |=3D 1 &lt;&lt; SH_MEM_CONFIG__RETRY_DISAB=
LE__SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qpd-&gt;vm_cntx_cntl &amp;=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~(1 &lt;&lt; GCV=
M_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qpd-&gt;sh_mem_config &amp;=3D ~(1 &lt;&lt; SH_MEM_CONFIG__RETRY=
_DISABLE__SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qpd-&gt;vm_cntx_cntl |=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; GCVM=
_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XNACK cannot be enabled for gfx12.=
1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;sh_mem_config |=3D 1 &lt;&lt;=
 SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;vm_cntx_cntl &amp;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ~(1 &lt;&lt; GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAG=
E_FAULT__SHIFT);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;sh_mem_bases =3D c=
ompute_sh_mem_bases_64bit(pdd);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index 546721b4d59a..059e22cd7f1a 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1670,6 +1670,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, b=
ool supported)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_VERSION(dev) &lt; IP_V=
ERSION(12, 1, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n false;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* XNACK cannot be enabled on GFX12.1 . While dev-&gt;kfd-&gt;no=
retry<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * should propagate this requirement, adding it explicitly =
here<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * will help cover any possible future reworks<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br=
>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dev-&gt;kfd-&gt;noretry)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
--<br>
2.43.0<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"OW=
A7105a83c-99bf-4256-e22e-6725de0e1833" class=3D"OWAAutoLink" data-auth=3D"N=
otApplicable">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br=
>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 126, Issue 488<br>
*****************************************</div>
</div>
</body>
</html>

--_000_DSVPR12MB4490959E38A5265F79E9EDAB80817C2DSVPR12MB449095_--

--_004_DSVPR12MB4490959E38A5265F79E9EDAB80817C2DSVPR12MB449095_
Content-Type: image/png; name="image.png"
Content-Description: image.png
Content-Disposition: inline; filename="image.png"; size=528;
	creation-date="Mon, 16 Nov 2026 20:20:11 GMT";
	modification-date="Mon, 16 Nov 2026 20:20:11 GMT"
Content-ID: <506ed06b-241f-4790-892e-ee2dacd24342>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAcpJREFUOE9j
ZAABr6aJDHqhuQwMDIxgPrHg19d3DLP91Bk+P3sD08IIN2x1hjPDy7NXiDWL4T8nM0NA33wGWRMP
hg5NJgYGhv8gvYwMFdf/MYAMu3twP9GGISssv/qLYVdzMsP5FYthBv5nmO2pyfDzzVuyDEw/eJ3h
xNyJDEenNSMMJMskJE2Hp9YxHJ2CZOBUM1GGz5/hAUuS+UVnXjOcXDCJygbOm4TqZUpcGDJjJcPz
S1eoYyAvrzDD58/vGRgY/iHSYcX1/wykupBXWpghe89reEbY0RjNcGHFMkQsk2pgwYkXDBz84iiR
16EJzmWghE26C8uv/mZgZGJBM5AZ5HXyDPRo7GMwCCuEG/jj40uGCRYS5LsQpNM6q4TBOLqE4emF
gwxrs8NRI2WynSTD19cvSErQOBQzMhSdecvw8vophqWxngQNBCWTrBMvMMIPpnF7dQQjA6+UCEP2
3tcM//7+Zvjx8QNOQydZizFk7bvNwCepgs9iWIHKyGAYEcPALaQEUQwq3mBplQmi5siUBoa0bRcZ
hBT18Bj4n7QSWlhGmiF19xOcBh6aVEyagSCTQEEUNf8Ag6CcFjyn/Pz8hmF9cQjDg8MHAaiKxp0e
iZJ4AAAAAElFTkSuQmCC

--_004_DSVPR12MB4490959E38A5265F79E9EDAB80817C2DSVPR12MB449095_--

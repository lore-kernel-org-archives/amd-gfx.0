Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07778606A329
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0iVA/x8M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9078210E517;
	Mon, 16 Nov 2026 15:39:25 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888D010EA24
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 15:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWLSyDlD/LOyhY+5cmvq/2oORpsEQREy7zeQpr8/iOZnURKLhhFS7o4baIGoNWuckXNtinpKvljD499i3E+1HxXCbojT9G9y5ZBKKpZt+JExPuCHIuuMSuvXEkDjW3iOM9MllPQt3tFuYmrVa0Bd/d1HEaQ2WSAJfSsVONEuMN64Zryr9QEtuW41LICRV2XWT8I4HzDQnBYTAWdj0okI9634xLMi4NAX+yNp5T6DWz43V25/9h5pHgwxf+UouSYCx0r8jAIZwHquYC16AkdBF/p4EKfoi0Y+suJBuggXqpdfAEjXOEqViO9LlEil8gv+USZ6Sxnr5z5rw8uGYj/TvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce2c6Oqzzp/1mUFvjXBo/lzgD10AwfhWWMcxmqos6m0=;
 b=P1BS2XikD0PJWVmVGN5+zZTzc+LoNmSCcle7xM2DbTVA7l1SS7O9Mt5OYAyAMKHmID7nFKOpPE0sGb29SiwvVaIzR2+u4+2Acc61rcZY/4HnpWgfhszqGsJcAvxGwQGuj4kAwzhnxEf8KG8LaM0Qw9G4viz4XEh5DzrFXTNATO7rKgllQsFzHk5L5ZEzJAA7RGvtN8ENWzCEODE4X0wje3ZTbGdto6LR+pu8trbXXHJGcX+AzoOgzwQ5v9oMwajjnhFCsLidqPiuyIAdiwlH3764fI+oR2k34vJRsykZbAJNqkWOAQgOhnRLrcs6qOru9eperDTamLZt8Q0cQRCWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce2c6Oqzzp/1mUFvjXBo/lzgD10AwfhWWMcxmqos6m0=;
 b=0iVA/x8Mfa/8kCgtNuaxGQvPqM/9fzExp7im3CGqQ9eZSpEu7kAiJRGJ004Bqe2BHW76QgQSHls/YyrMa6MzhdzQeEEehk//jZOnS4zrRg7QQGW0T7KMyEAjq4zK1NSX2ygIUWED0KfYSA8qt5nWFFIb5NRTWbfeDFdBo4k68qs=
Received: from CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:39:10 +0000
Received: from CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55]) by CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:39:10 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chen, Michael" <Michael.Chen@amd.com>
Subject: RE: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to
 SET_SHADER_DEBUGGER
Thread-Topic: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to
 SET_SHADER_DEBUGGER
Thread-Index: AQHdcRQamFUiMPqAKUCsb82hHG/5CLcw3tZg
Date: Mon, 16 Nov 2026 15:39:09 +0000
Message-ID: <CY3PR12MB96315B4EC5D0B0EB56099E14F47C2@CY3PR12MB9631.namprd12.prod.outlook.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
In-Reply-To: <20261110130440.474374-1-Prike.Liang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T15:38:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY3PR12MB9631:EE_|IA1PR12MB8466:EE_
x-ms-office365-filtering-correlation-id: 96057153-67a9-4fa1-1d59-08df43f7c1e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|261009221227099003|261009223027099003|11063799006|260925022911599003|260925021911599003|260925021311599003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: IXy+mjj/7iiMkxMogcd3hrrgUeqxoUayOPO30SfQVUUoUAu9PhpW1xg+1BXbGHXoNRAw9DAIVMWzMQVVLpS4S6bhu71WQjf/gWm1JRc+A1PUdMxAOtppql6nD9E2SHv5knSCcjtcKHKXg+WbiV4ZKifq8rlzZ9AtY0FtkRbQ5hT1i9M5BEhRQAs4ghhc8uhtg1kYjgAaA7I5xSVXQJiKSzUNpkqoDWd+nBXVeC/MnPUO4rj6EIP9uQonsPLI1+8g4H2TwZ96CMKzKGkJTLAVxpWE3Ti4Ddnz4DUfZNHq2Yz9/X1mKrIbn7zloEk7wY5jo+yaN4VVQ8hEU9VOOM+XSYiV8VUF6gDiDxcSu0hvb1AYWTsXEdIgVdcBPphWoEZIbq0XoZP2FRa5opEy3i37ncHlx9CRkCQqA0rkq243JlOnku+hDUteVKACBUNLLmKysGUvS3JfnZinUKb/5qXYN8UfalcyPOH+qJHnMUxva59ZazdaipdVhWJiCpOidwphYlOZElUMUJutsqaCoDiiqNRnSzAutMcBsOekVu9hfzpHqzRbNVooKIoRL/nvk3D9xgQcux08kqVj6vNtHRPd91svxpvW2eriJH/NEt+FA/hr3GjUNGHi1B5md7gcT3CNXA/qypwNZGXAQAqPGM5731CpcvFBgWr8e0zB07ivNROmmzCdKGCYHGL1AMmSGGDNr8d16QC3r13DEmTeqJT7DeCG8/uM2U36v0sywuiTyDM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9631.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(261009221227099003)(261009223027099003)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9n3SCx3uW4oabgna+SpPX43c51Kx9AVZos5Ln+Z8PhX91D6QXNOiujQCcW+J?=
 =?us-ascii?Q?S2fzH9V3zT3YkNYTcLkhJRQfiJ3LFI5TvKugbEhaV35EfPPU9uen0knW5/CO?=
 =?us-ascii?Q?KbxptLo39fgaHppZRULhjR4RxpSp8jrY6B7yFiG8/8ZuOSeO2oZfROc1XElc?=
 =?us-ascii?Q?KLzbag0GoPWaUvrnGN7dqqqiqIvA3HQTvBLea7TO8h/kGeAfU116oekh6TZX?=
 =?us-ascii?Q?482b+msJOUdmGYTQJGkLgXwEV2xPwGTNeiUqm1IJaXsBhis+9996XxhJz8av?=
 =?us-ascii?Q?JbJK45Vi4pqKKbPUp1mK3kK1QnbT+N7wCTmmK9k1kA6HcQouH1Zj+9/uDbzc?=
 =?us-ascii?Q?0OxLM7JG1vwxbvaJIGZbVyIF6g6a7qtK3xa3tLMxt6phVxfFqKpKNqtlMri3?=
 =?us-ascii?Q?xK0fdGZkf3LZOenQcJwwMok5+WtwN3AO1jRG66NWwYDH7sweF7jEZdXxuK0q?=
 =?us-ascii?Q?var4zybwE8bPYzV4rGnqxWz32eKPNgfDo8xnV2UgBzyysEdJFFXhuczppUJ/?=
 =?us-ascii?Q?jgSTWtcc0a8omW/L9Xee6MCyQDlVuG/cd+UOU+CedlBHPz/giUgnnpWXOE4i?=
 =?us-ascii?Q?YOtmdb2sIqygZvHIg7IquwsngA/1zfLO+m981VckVHiNUILGShr4aRWdWNGc?=
 =?us-ascii?Q?Ph/NoU147O46HWUe8gWHFMKTKPh26z4w5RuTEJtXByHL5aQOnVJn6XIGnAjH?=
 =?us-ascii?Q?P3+ygPjCWMBiUH4c5t8Fz7q+gS1v6dSeIMTq1tT2YEXRjya7P5JoUdfVOFnR?=
 =?us-ascii?Q?VkZecW9NdWwGMt4Pqt1jMs9Y8rYSzXPCrIRnXhU3T8SttNjcVekYJg9c+Hse?=
 =?us-ascii?Q?cDG+ulbT2UvBZeqd2buaUQXf1uC1erxdoOOti80otriZxM4ca39stp7w5Vfb?=
 =?us-ascii?Q?nnrTFeKEzUomdy0ofWAbgYt4j9RyTOvnzycS7AHMEwipn2tImoF44NrARmn+?=
 =?us-ascii?Q?O6ZGpsH1Fcc8diGLRy8qpaCYUN6fGoivSWpMVExdbZefvlEffxhKUAedM2tx?=
 =?us-ascii?Q?86ifKJkS29mUocIrzcW99oD45uZxRIiESCf2QCF+GF2i/B+2BwwgVdVvgexk?=
 =?us-ascii?Q?bWw/xzvO0PO3ySI5SR6sED7EevkOEXGLMC3jfUMywwlxshopTxL/JWHaQOko?=
 =?us-ascii?Q?NIzzgU3pd8omc54NH5g1HZijn1MIvXl5Ec+6MyNwaF0dOCw7M/16Od9C3iIa?=
 =?us-ascii?Q?2k4Wo+f8BYv/blzfWNEDZNHr4k2NhSPB4wxXonyZXYKPAX8xpLewMoSSXQZs?=
 =?us-ascii?Q?5j2IeTlyOTMeZVwAOkdx+ZR8UZOLU7N0CsHbfggrYh9ktaE5WrFKNNpYGs3H?=
 =?us-ascii?Q?sdTmhsEUptk+wi5qMoDVCGOdYADPAxQOfl9j+teuA0VbIUgmO4nP5S9N/dVC?=
 =?us-ascii?Q?mva+VKKdG59sGkBFZeTS5qveDGGFn+3PhkV9W+KVkGitEOb/jcm9zV9Uy35T?=
 =?us-ascii?Q?tmAJyER9L8rNxnkXUR9dWPEYy/2dl3nH2/TzTzlTlqzAccuGpHC6Kw+IC6zP?=
 =?us-ascii?Q?1rBj0fX42gOPqHpH1fpngCgNwpRUj/h+0kJn+m2BfiIyyEfwPY2WcLL4t9o3?=
 =?us-ascii?Q?fFCYflQTusxwNI4s0A8yiQ7VaxWpKjSIo7eHtY5PnNjhOR/bk/05FLdc29GL?=
 =?us-ascii?Q?Ces+MJvKwwqsNHLqtEDrB2GCcR44ROymkUwbM1g1eDywmQjyA4F6Jg0AuBC6?=
 =?us-ascii?Q?a8ZI9NgdoDEbAwIm+jdP6fzlQoGylxCcDg1nm8tVxIQjQSKi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9631.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96057153-67a9-4fa1-1d59-08df43f7c1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 15:39:09.8548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6N+qbu9OHfdcT7FqEDXOYNaw/sp2Rowij5rD/45k+Vxjt94eiKQydjFZ/kNLgpG7CEGWEEATXgJ1mtnRiCt5ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Please also copy process_context_array_index in mes_v12_0.c and mes_v12_1.c=
. The v12 API has the field.

Regards
Shaoyun.liu

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Tuesday, November 10, 2026 8:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu, Shaoyun <=
Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to SET_S=
HADER_DEBUGGER

With MES RS64 process/gang context loading, MES keeps the process contexts =
in an array in its local memory and looks them up by the slot index the dri=
ver passes. SET_SHADER_DEBUGGER has a process_context_array_index field for=
 this, but
amdgpu_mes_set_shader_debugger() and amdgpu_mes_flush_shader_debugger()
only pass the process context address, so MES always gets slot 0.

KFD sends the flush variant of this packet for every process that exits (kf=
d_process_dequeue_from_device()). In RS64 mode the flush therefore hits slo=
t 0, which belongs to whichever process allocated it first, instead of the =
exiting process's slot:
 - the owner of slot 0 loses its process context while its queues are
   still running, so its next GPU accesses fault;
 - the exiting process's slot is never flushed, so the next process
   that gets it starts with a stale context.

So the KFDIPCTest.BasicTest failure on Navi3x was caused on the case when p=
arent holds slot 0, the child's exit flush wipes the parent's process conte=
xt, and the parent's next access to the shared IPC buffer faults.

Fixes: e32b68c6b135 ("drm/amdkfd: enable rs64mem for kfd queue")
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h                | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                 | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                 | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 7864afab5b40..99b803f95c56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -763,6 +763,7 @@ int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)

 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
                                uint64_t process_context_addr,
+                               uint32_t process_context_array_index,
                                uint32_t spi_gdbg_per_vmid_cntl,
                                const uint32_t *tcp_watch_cntl,
                                const uint64_t *watch_addresses,
@@ -782,6 +783,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device=
 *adev,
        op_input.xcc_id =3D xcc_id;
        op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
        op_input.set_shader_debugger.process_context_addr =3D process_conte=
xt_addr;
+       op_input.set_shader_debugger.process_context_array_index =3D
+               process_context_array_index;
        op_input.set_shader_debugger.flags.u32all =3D flags;

        /* use amdgpu mes_flush_shader_debugger instead */ @@ -811,6 +814,7=
 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,

 int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
                                     uint64_t process_context_addr,
+                                    uint32_t process_context_array_index,
                                     uint32_t xcc_id)
 {
        struct mes_misc_op_input op_input =3D {0}; @@ -825,6 +829,8 @@ int =
amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
        op_input.xcc_id =3D xcc_id;
        op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
        op_input.set_shader_debugger.process_context_addr =3D process_conte=
xt_addr;
+       op_input.set_shader_debugger.process_context_array_index =3D
+               process_context_array_index;
        op_input.set_shader_debugger.flags.process_ctx_flush =3D true;

        amdgpu_mes_lock(&adev->mes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index e5dbcf8ef890..9358090165aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -450,6 +450,7 @@ struct mes_misc_op_input {
                        uint32_t tcp_watch_cntl[4];
                        uint64_t watch_addresses[4];
                        uint32_t trap_en;
+                       uint32_t process_context_array_index;
                } set_shader_debugger;

                struct {
@@ -653,6 +654,7 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device =
*adev,  int amdgpu_mes_hdp_flush(struct amdgpu_device *adev);  int amdgpu_m=
es_set_shader_debugger(struct amdgpu_device *adev,
                                uint64_t process_context_addr,
+                               uint32_t process_context_array_index,
                                uint32_t spi_gdbg_per_vmid_cntl,
                                const uint32_t *tcp_watch_cntl,
                                const uint64_t *watch_addresses,
@@ -660,7 +662,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device=
 *adev,
                                bool trap_en,
                                uint32_t xcc_id);
 int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
-                               uint64_t process_context_addr, uint32_t xcc=
_id);
+                               uint64_t process_context_addr,
+                               uint32_t process_context_array_index, uint3=
2_t xcc_id);

 uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *ad=
ev,
                                                   enum amdgpu_mes_priority=
_level prio); diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers=
/gpu/drm/amd/amdgpu/mes_v11_0.c
index 60b27278a598..2617c2b7f101 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1043,6 +1043,8 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
                                upper_32_bits(input->set_shader_debugger.wa=
tch_addresses[i]) & 0xffff;
                }
                misc_pkt.set_shader_debugger.trap_en =3D input->set_shader_=
debugger.trap_en;
+               misc_pkt.set_shader_debugger.process_context_array_index =
=3D
+                               input->set_shader_debugger.process_context_=
array_index;
                break;
        case MES_MISC_OP_CHANGE_CONFIG:
                if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK=
) < 0x63) { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_debug.c
index 71b34a57c2cc..cb830f985536 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -373,7 +373,8 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_devic=
e *pdd, bool sq_trap_en)
        }

        return amdgpu_mes_set_shader_debugger(pdd->dev->adev,
-                                       pdd->proc_ctx_gpu_addr, spi_dbg_cnt=
l,
+                                       pdd->proc_ctx_gpu_addr,
+                                       pdd->proc_ctx_array_index, spi_dbg_=
cntl,
                                        pdd->watch_points,
                                        pdd->watch_addresses,
                                        flags, sq_trap_en,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index b68e884b1c37..d3149e6d40e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -96,6 +96,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_d=
evice *pdd)
            down_read_trylock(&dev->adev->reset_domain->sem)) {
                amdgpu_mes_flush_shader_debugger(dev->adev,
                                                 pdd->proc_ctx_gpu_addr,
+                                                pdd->proc_ctx_array_index,
                                                 ffs(pdd->dev->xcc_mask) - =
1);
                up_read(&dev->adev->reset_domain->sem);
        }
--
2.34.1


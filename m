Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70F8D35673
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 04:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E6010E0FD;
	Wed, 28 Jan 2026 04:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OJThuEyK";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D525F10E0FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 04:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJH9MLuz8POBFkbr00aOl1NvzIsDeiBIMPr0acNvBSXUibPwpNbK2qDENRKGl5OGgALiju4G8pmoIVvhDXgswr6jOC2aakkG72O3OU3lI1luiHECSs4aedhKCxLfsGVVDl8Ltn87sS2zeeQOW1xN4XGp6J7z2SD+mazL3hHEdqY1SamIfZ04R8PhkedIZA/nmCp5hifUqF1Yyi6UKF4SbLIpkUu7HOa69TzVol5g6LFRlo+LiJQmvdtt9xKVuIThMHeK/udlVARj1ifmo9AbGmZNOQW2WPIPjMO+5445f199N7Y/1wgw4x8i+M8YUp184DkQB3O7PUm1K5ujrnoNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD9117TNQZ9VRSR8gvnh01S2NF9mFS6leZ1bloI45Lg=;
 b=srdJ38if2Z8mhTb+hnkD56wJIMximznQUdRHrkbWdTlHO85lAM4FnHsZX3hFx56I8ngvvw5/yFEdruVQONvTN8RsYodSi4Hz2v/TATjinNLVNQvu2n7Eqb2V65/BYIqRqsaYwi7YrM5lH2RAfjQRJ6th5dRg/lC6g1CASxFP7N7tfEz78/WmmIVSgQytspJU8WQMbIYlAzHjYvLqsVRldp/oJajjbcUzuF2CXrLTq7qbgeP6L9Pk8QcskSdLfw5IQBIdMsZjL3e/QRzyRoFyKX04mYZvUbOocIsxhSRrMR7aRecJrHsDQgcswLjK2jlO0cBi0MfMANOg7ZEhEWLUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD9117TNQZ9VRSR8gvnh01S2NF9mFS6leZ1bloI45Lg=;
 b=OJThuEyKkGiBs/Bi30Nm9L2lc5K0J6ubBc6heQnYu4sbFGINOfSRLPxQL/F5KanEBhpaqFsJgyL/Y4Wm255BYE8r3PbzHpuVRfpuZ2ULglAXnq5Q/W9eoYm+5zVnJvuhf293+ggPyp7z75/unKzdydOauNLssE9T4fRkg5z58EI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 04:59:25 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 04:59:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Belanger, David" <David.Belanger@amd.com>
Subject: RE: [PATCH v2 1/4] drm/amdgpu: Add a helper macro to align mqd size
Thread-Topic: [PATCH v2 1/4] drm/amdgpu: Add a helper macro to align mqd size
Thread-Index: AQHcj/zOy4re9pxahkmkE9IZURXcqrVnBaiw
Date: Wed, 28 Jan 2026 04:59:25 +0000
Message-ID: <BN9PR12MB52574633148A3FA6CE0A5C9CFC91A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260128022111.281082-1-lang.yu@amd.com>
In-Reply-To: <20260128022111.281082-1-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-28T04:59:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB7751:EE_
x-ms-office365-filtering-correlation-id: 3e3f5025-0fdd-4a73-e0ac-08de5e2a0234
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JbVLYkV4Al5pxt6Mw94bjuKpEqO6Ynzyau2c2tJz2DREuVQKqw3hETM3foAl?=
 =?us-ascii?Q?K0jfIPD5vF9o7CZ6Ue5JFcVvDIZZ2UwBXqlS4qR/FKWdBKd/I1hBh1sAcjIS?=
 =?us-ascii?Q?IuaKLiOVbRx8Ybp6IwtuBeqK+i32/EWUnyxlwnn6kUOx40o21X8VssSawRs3?=
 =?us-ascii?Q?q6vMyQ57R96f+2XfRf/u4r3B/mlaAE2C5VCUvHhJYWNQLRpaMkyjSXqm8X8G?=
 =?us-ascii?Q?PPr+EyCmE/lhuKzG2GAgg2eyfFr3ssPcaE2wIsjGDd6gqRONLOhI/ADL30MC?=
 =?us-ascii?Q?7liisej0q8OBcQbed2jMs2acOME33ZjI922P4pcN0JklEHkDRf+Xk2n0sI8C?=
 =?us-ascii?Q?jbGvU4Tfc9iks451aGrgPnIcIs63oLWdqV8Ed8TVjshsiiCWi+5h2YTLIqyj?=
 =?us-ascii?Q?sjZizkYNyEwjT/JCxyMHaWsKNAZ/naDCqNDxWANrbnXQTvKX/YTov1AOX7K9?=
 =?us-ascii?Q?YIcflVdspdw8SdRsl/N1c7rlpGVf+aeM4H9pMo0kDOj0gHevRtbJXnnlDpHn?=
 =?us-ascii?Q?fs2Dd8rMBYdrcRcJhDjTvspni4NN1J6Cx7HrL4CIwJDokw4lGCInPD602Doy?=
 =?us-ascii?Q?5L9J/JDslk6Ow4dazOcmqoTnqcVgKSXpojSZYc7AXPNmm1cZYT4g1mB+M6J9?=
 =?us-ascii?Q?WN1rCtq13jgkPta7RcaqBpMoVt/GzyNqBzP4DqER9ZK/IkmBOiEdQVwFayMh?=
 =?us-ascii?Q?zty9cdOn3iw4LlmH7Zwh+XfTRBNNAs9WxkBVS0eVBC0lSZ5cbvLkrqP7Xwnd?=
 =?us-ascii?Q?fmFAX7d1GM3CCFFUtnZk4+hHdaBBwYLudb+W6VaCOf773CNVTpU9tfLnO5Qe?=
 =?us-ascii?Q?3bYhoCXD2ySXXMiJ0dxtgqb2mxaZ82c0i4qDdZ+NZj9StjnCyPU6O32iBdgg?=
 =?us-ascii?Q?s4A+hLW8YcqqW7pY6WhtYK2iwQtj69isp8cv5Sh8aYnWAYM25PDUUA5Vn4Tk?=
 =?us-ascii?Q?2TIo4JFbxeuubQiEGYC99xVvS3+5jK/y9qqzSdrAGku5Xo2rNrN1mafvkv8B?=
 =?us-ascii?Q?TMkIBOsbw9X7fhhb4hfGs3nF6jLTe6q/2XCcFcNucx4vP0bJ3Z7cWdBrE8AN?=
 =?us-ascii?Q?GRj4UF/xMhLov5pahIelOsPG/d25u1pzXow2XzGqi3lfe+IWEQoxWnsZ2AjG?=
 =?us-ascii?Q?4hVBeWJbFThvWQJpuc2KW0MwJ7di+E4KFSQtbDCqxFAgEOZPB0NoFeKXquLE?=
 =?us-ascii?Q?FAhpYgzk/ZBUg/u70bo07djKFk3ztasfAalOCm7vWghBrGvLOxh/Sa8+atFv?=
 =?us-ascii?Q?/lNZDq9W1MdHnPFYuGBbuFdtDHJ9GrLF5yx9rtZb4bbhMYy22GfD9HLl5agg?=
 =?us-ascii?Q?xjKR6doUC55RPiQd5DwehzkTzU87eFPKyyYcafppNBntWtTxfeMAy3Ni6KJV?=
 =?us-ascii?Q?9kXX5LyS3sLrPNqwb6nafoT10UCz1pkD/8ChD+/Yen64pFBVw+2bz9E/wHEA?=
 =?us-ascii?Q?DjiSUQMf8E4vvMTRzOs/nWFf0jlPMbJIf6m1siksI4SG28aP5jlA5CVlrCZd?=
 =?us-ascii?Q?J5UhF21XmWJoxGUfH0FBumN5lTjh8T+/S+gFG7OGkviAK0Ixjy0DCWJpqE/u?=
 =?us-ascii?Q?KMOJq+LSfvpyJFczHmV4zDKCSPsgGb+w5Q1hynXsU5HPwOb3Ug4QH0aaCCqw?=
 =?us-ascii?Q?5Kbow4pje2EEiExb5J707/E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NqYUkt+IcIl/wv+3AYtIU8iVGNenFjYpD0qjYoREEiSLjZIaLSANwL7mqJtf?=
 =?us-ascii?Q?4z/jrdRlxBTV8QFVlRb6arxhbTyQufhCoZKaDf7h5tyAYpl32y+GwlI5TNBh?=
 =?us-ascii?Q?usebzzMeQl1taFGJDCZc9fZbCdAP+c6iOHAdhA0sIXEqgdy0pMKeZhGuWJ0c?=
 =?us-ascii?Q?2I2Q6kxes4e3msxo/orIWhxYY1VlgIGJksW89eFev2/jKHjK7luhpd0V37mz?=
 =?us-ascii?Q?eaCRilw+/AlOUs5HrAA2idM+UhTB252MWsZuw6lgJOCCIArNRTFwGwWl4dQ4?=
 =?us-ascii?Q?08zDCvbHvK2/gZgfWjHjA1LU1/InhHPiANG0ZMQnSymgqNjRMqHRKAg6N7DP?=
 =?us-ascii?Q?iP1EgMuBE1gb5phXgsjhpBzmhUZZt5raDvyfB3CAcMKeyOM3253IMmgzWZVD?=
 =?us-ascii?Q?Sbbt8fvb829Kbt6TRBX01ZjlrYRBvP38SpJ+aI8lKCt1ZTua905tOapld8Jy?=
 =?us-ascii?Q?NaTvTTLH8gTLsJNYw6v2b7jiw2LZ+XvAqzbz96xrdfrsLvEwv5PKgSweQsv+?=
 =?us-ascii?Q?iWI/osffkhOuykwgNFKL5DZVR5AXlyBBDwVoxswISAw75SXa1WJ/cyY+gelB?=
 =?us-ascii?Q?u6ipV2agE2mBxwikKKPjJ7ZXy7FpUTzkCQKSJS7s5M15j9JWENsJIfr6E5ZQ?=
 =?us-ascii?Q?dyds0Viazy5RLR37Ut04cWWuoh5RGACN/K69ZBAyvDGWmUZY4cddQj0PbmiO?=
 =?us-ascii?Q?NFGQY4qSEtRysn9anBjYeEhYSwDOn/oNJ/yxPzvdMDEiTYNpyG3FwGfrmPQg?=
 =?us-ascii?Q?uyMFDExdSyQ6meS2ULc/UxEAQAFz2vh3mySukmFOvjgkZs/LbpoEPg3TN/8g?=
 =?us-ascii?Q?S3GXQxRsvSI1N9wTB0+Yg+yHyVNAShUnEZufYtUywaajse8NvrirsDmIl93L?=
 =?us-ascii?Q?Y6fWPPBiXLOGl3fEifmb57X49haRSEEiEkmtbF6/tzo23DDGxa8kfRkrYTj5?=
 =?us-ascii?Q?d8MOaKri0kBNw4SrvwLHleBQV/+jtyhuXDNckXCuzkt73usdDMAl3Aween0l?=
 =?us-ascii?Q?/zlLHNnA2fLc5mNxuacdgJhKXN6vXCFF1QBsvPFS4w4ciucXcmw6XRFSkhb2?=
 =?us-ascii?Q?4Ru7+ymmxThVrCTOBivUS6fMJk5fXlF/6K6vknPS5Hz27Wxg2ukiOU++0ztB?=
 =?us-ascii?Q?yl3TfLO1lJQFssBiWQaUXUa9u9cQGgxItynLHszPYJgodmfO8SWnd0UPVScz?=
 =?us-ascii?Q?EwgJsH9d3aAoSNmq2C0BX7s+J6AYXCNXWsxxZOkJh0K1bNQz2pWh4ML3GQoB?=
 =?us-ascii?Q?qgbgb6T43bGiP1OgFI7va0ZBR1lrxUQTyt6NMgxIHvPNww3vS699GRZnJD1M?=
 =?us-ascii?Q?qlPAGPZ+ZfJwcVecumlQzKWVnbJZieOdsqyp4tIC2kSjSmB5BwBp8Qzd8dUo?=
 =?us-ascii?Q?4xlE5dBv9+rFq/sjgY+RwyBMixlczKoMOpD/HxRSgebkqwhZc7coy2l1wKZA?=
 =?us-ascii?Q?Pl/LXmlDLtuoy8YVSINbBSFHejqPxPDPCX5a0DOusdHdirUs35fldzvyjTeR?=
 =?us-ascii?Q?WTtCQJlBGEqUeku5EsPIsynSnDH5Uti7E4AXoPVoVF6X1K19Rm2ALMyy14Yq?=
 =?us-ascii?Q?xFQUl6FczbET+VFb8vefWaSKBcry8eg/aC7ZEXpsQJpGJrnJnopG1ugrZe1l?=
 =?us-ascii?Q?LdPQIxYPrB7QTnp/LhGaoioZBgBULiaC0VobV+wG3ge4gahfuNvMACeU93UD?=
 =?us-ascii?Q?GihsWkLqKSZzd46M8xmwHzYPKUEA6Y/LnwpS2eyCuFIwDqUX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3f5025-0fdd-4a73-e0ac-08de5e2a0234
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 04:59:25.1269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLmHWvWM00HzmccVpraGuw+AwVKkRXeZ7Pk4hh+VioygkewqeCwmoAAe/XMQDUHU6KboKgFb9AbwwNHfTx7WDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Wednesday, January 28, 2026 10:21
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>; Belanger, David <David=
.Belanger@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Add a helper macro to align mqd size

MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t)) as =
fence address and writes a 32 bit fence value to this address. Driver needs=
 to allocate some extra memory(at least 4 DWs) in addition to sizeof(struct=
 mqd) as mqd memory.

For gfx11/12, sizeof(struct mqd) < PAGE_SIZE, KGD allocates mqd memory with=
 PAGE_SIZE aligned works. For gfx12.1, sizeof(struct mqd) =3D=3D PAGE_SIZE,=
 it doesn't work.

KFD mqd manager hardcodes mqd size to PAGE_SIZE/MQD_SIZE across different I=
P versions to solve this issue.

To avoid hardcoding in differnet places and across different IP versions.
Let's use AMDGPU_MQD_SIZE_ALIGN instead. It is used in two places.

1. mqd memory alloction
2. mqd stride handling for multi xcc config

v2: Use AMDGPU_GPU_PAGE_ALIGN. (Mukul)

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: David Belanger <david.belanger@amd.com> (v1)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 9c11535c44c6..8c6edb0f58dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1239,6 +1239,14 @@ struct amdgpu_device {
        struct amdgpu_kfd_dev           kfd;
 };

+/*
+ * MES FW uses address(mqd_addr + sizeof(struct mqd) +
+3*sizeof(uint32_t))
+ * as fence address and writes a 32 bit fence value to this address.
+ * Driver needs to allocate at least 4 DWs extra memory in addition to
+ * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for saf=
ety.
+ */
+#define AMDGPU_MQD_SIZE_ALIGN(mqd_size)
+AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
+
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
                                         uint8_t ip, uint8_t inst)
 {
--
2.34.1


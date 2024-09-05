Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049CFCD5BCB
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 15:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A432D10E906;
	Thu,  5 Sep 2024 15:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TwyLRZnK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4355310E906
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 15:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLsECmGgk/dTWKuJ8ZLK5HgT+1kNDKBS9V1ylEcFPGcYvPp5srFfsJS7EIQMz7wELau2I+iuBybW4ptTu+tyvJ0T382bBGsmNZ+PaZpGM6g6Pq8y8VtPAGYUpkbgVqfvwP9lTN55UL+hRHRubokhocAoxN/DcPCG+wrtRk43VwpH9INUZVsDLB+ISrboya9WeFMMujQ++tSE6DAExq/u0gz5if41IG/B2tBmRvv4mDuyfj2EYYN6ladIZ0uMW7jWhJwaVMFgx5PiBd8RJmfYKJGNvGzoGqZSclRXq2QuHjwycP2NXtxjub224cR5N0UbPFgMOWN2FzCflE8AXFjc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez4gINvWDIsWceLBBVN2fFS/x3u0oQDAN72fv1JUW8Y=;
 b=VoXRrj7YkR16bcn+fngndOzLfYmdSGso+gOQpG4MAb1pQ+5bpgyNq4Uymzr3XEg6ZKH3HeJ1UAm1ChFbarTpIA9I0Hh/hanCLfPHR5K8XOB3PA+ImbVQ6Yze8cV0HxpeoKhdKW0ZIFXXFojddGkY5lfH+FmAsf45mgiTfQ2pMm5mh7APDlBVPPQ8GhZsF/PWzDB3gtrPURnBleOsgVeU/SDYpoLamNBiqnxAv8ACVHRGyUlxXf4dJL0Xr9fL4eZU4wPerfaiMCUkfhHOJgBDpPtO2UjhU4bvbZJmpIzVuSV0Z6+l4rN2KtwQNmKu+cl5tTnZqjMFc1p1f2aBJqkRYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez4gINvWDIsWceLBBVN2fFS/x3u0oQDAN72fv1JUW8Y=;
 b=TwyLRZnKlaDFGdxa8+9lKYk5eMYqneio5XK1dob26DtIeyAQXspangXC1vxFxEiuGO25Ra2qLt/ghj3rVpWfHxlpzdLqC3jdYTcDyvUYoNkEs+5+teyHSLb5QD6JW4CohfVmog1v9bJ6OlCPjIEaHdzoifGEut4GP6UOvVLB/Fo=
Received: from SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 5 Sep
 2024 15:23:12 +0000
Received: from SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783]) by SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:23:12 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update golden regs for gfx12
Thread-Topic: [PATCH] drm/amdgpu: update golden regs for gfx12
Thread-Index: AQHa/o0BzGQsCVXA/0iS8pr7O/PHXbJHHV/AgAB+GfCAANZHcIAA31+Q
Date: Thu, 5 Sep 2024 15:23:12 +0000
Message-ID: <SN7PR12MB69321FD7560AAF65A45EF0C6E99D2@SN7PR12MB6932.namprd12.prod.outlook.com>
References: <20240904053844.16075-1-Frank.Min@amd.com>
 <SN7PR12MB6932F0EE6B6551AA1263C2D1E99C2@SN7PR12MB6932.namprd12.prod.outlook.com>
 <SN7PR12MB69326E152F81556F0DBD4906E99C2@SN7PR12MB6932.namprd12.prod.outlook.com>
 <DM4PR12MB51819C8A7CF5C6AF899620D8EF9D2@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51819C8A7CF5C6AF899620D8EF9D2@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a289e013-e7ba-4179-bfba-19ca893326ea;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-04T05:42:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6932:EE_|CH2PR12MB4261:EE_
x-ms-office365-filtering-correlation-id: 4bc9cbdf-80d0-4d4a-fbe2-08dccdbea7ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TjvSHH7MmhMknDcC5Dgn2RnO0o8ALNUD19TKpdJSsV7G1iBAynf1p4LboTii?=
 =?us-ascii?Q?6fTqQ67qwF4+ReIu7fAlY/ne0SeZpQBdos7lO137yK841wzfc6SAQ7xjf1Iw?=
 =?us-ascii?Q?ztClcNpLBHxnMBbNuOqsKItufw2mQiq42Ah+WTERl+IGqKZErF7ruDok2i/D?=
 =?us-ascii?Q?lcs67FV9FpUI4k0Y3CQFVJvm7lD12rF0Q3ek7WWEnId5dF0fhGYNQgM2CVxs?=
 =?us-ascii?Q?pSH4wy0fWiFvhe5HAvbR+qZrh1kiTOyHs7tc3KAUt2gzWv4CCMOgZNuEGe0O?=
 =?us-ascii?Q?+8o6tTZArOhnipAxysCuFzIR4HrFhOEV56aBooUV+Zl7WdTFxZbr+NAj5H41?=
 =?us-ascii?Q?tdTGoZRcTvBOPZ2pYi5DnxbrSg9JbR+m7PZFIzSG2gubKq/nhtqlGl5ZdQSs?=
 =?us-ascii?Q?dGLWp5Rik2G4Q8IQWNAxQRASzsaowFaEfzU95POkHF4m2040osrRh7ifRIC7?=
 =?us-ascii?Q?lsMj7fjN9tEeANjgNMClBmnAzn7oM6QggYR1kMGIIJ5HYUX3/rAExrBnqSH/?=
 =?us-ascii?Q?mkuaTxcDHIh4hRObO1gyZ30Gawy5O2U6teQ+NBNkI1v4PAKhHce+I0GLmIqJ?=
 =?us-ascii?Q?w9pg8U1U8GsxffipsO9qLY29AOwvy3d7Bwq/UkJOBm5sR0zvy4Z76pspfWrg?=
 =?us-ascii?Q?SCu2zf9BlmMThbCc9UjX/aqC6n31WfDqQsqfb3pqiD8nPxb91bVuh51/OTQ4?=
 =?us-ascii?Q?xvLPL7YuPVy7kTYfKVEfomv++gbpQb9T+Tn9IqZtLA4z5FvdupJoIqQl84K0?=
 =?us-ascii?Q?RyDos5UlsFOV7EO0Ipgi41OAAD/OVPPXj420u8NLu+17Gu7WhhcH7l/pOGMU?=
 =?us-ascii?Q?dmvZbRxRcz8BkC4zcSmko3zraCW7KLotFqthgXdeMNEyOd/zMtaJRB2bycWb?=
 =?us-ascii?Q?ryyCyNcprxaEg5GoRa5iABaRj6vOk1FB49UTY+yeAoFP1Dp1FElEY+zDPINH?=
 =?us-ascii?Q?5/s7Iu9MsgAOMP0U0OnDJVbtJ3vkzRol1UMEE49pTw8AxdiiEshhpJ8vQxTG?=
 =?us-ascii?Q?Yexk54Xzti5Uqyw5da50lL6iADG/HpsqpYrHNM9L05ztzTut7TeID9JGXXFt?=
 =?us-ascii?Q?9iJfK+uOEfhKqtpAxDesAeEpyx+ob9lVP59SQsHknnOxrRRRqj5H6p65vzSo?=
 =?us-ascii?Q?+PgSeWZfR2KTYVrU7k98LhhFO3lYQY50XTFG6r8ohg638lvew+AN0oZKEkFj?=
 =?us-ascii?Q?Kr1gzPQMaDvTBO3VG6CRH1CIwXlHe1QnpRy57mTvDQBzcXCg/r8Bk7EiP8hr?=
 =?us-ascii?Q?7cIYlLgOAnmJMrgoisnSHv8z7fhfFck0xt5x1THdags40Wv9m9sKiKvmY9oa?=
 =?us-ascii?Q?1Jr4NhSbiFLEA0eIiOyuLBS5v1aFvRUaT5wrCaV7WOHfW50vo+vDLpjR86rf?=
 =?us-ascii?Q?1cOtY0PDhuE/HdgLhfqLCiF6aUpRHYfQ4TwDUQgenO23OJHvXQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6932.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hjf/dJzwRi0HC3Wbezl+6sCGdsQhLkwPwSbBMVOp0nNJJ7pffkX46717jc1G?=
 =?us-ascii?Q?51vLAkmYDpj1Z9Ir2kCdN8NH9yJ21Z79K286tb38BGhDAmjxPxwF7jx4qRkG?=
 =?us-ascii?Q?KWuxpR7vAJLJrGLRsbUtV8yJM8DM4p68iX8qJ9kzGH8MiudSozSozYhGpYDN?=
 =?us-ascii?Q?0T3pf12Sp7RhlvS/VeSa4khjiS9eo5IsEMCgIqRC1CQ1x/eQ5czkgACuR3SW?=
 =?us-ascii?Q?Y6O0kZSxSFX7bMRNZCEFXgjjSYmDz8w7+s6gd2luGAn9w4TlnGSG0ocg5W4O?=
 =?us-ascii?Q?VDYKzALaglOrNi0f2OQ5TpuDnAUhL1pWiJ9Uqws1HbOck60VtBm0BAHquVhR?=
 =?us-ascii?Q?upyT933KPCkoo91bCjKovojAQeIKFOnf2ftwF1dqV8EOvSQmszP0libCenYo?=
 =?us-ascii?Q?7olD+IQ20ABgLkeV5/R0Y+CJ07VISsxBKEuLweEmyc/Iyuh0dUKNvK0aZ5wT?=
 =?us-ascii?Q?bTDhvOwtFSqVWi+Y1DjbuZAU0rytukxN12ghaBaYzxsY66i0qJhybPPy9zX5?=
 =?us-ascii?Q?C+O6aDATdatjqCx+spn2rgS6ECaI6FTRV9MZA4A/7Q68/YG7AjPCmmwR0v2g?=
 =?us-ascii?Q?ww9qaqq85OoNIT4XrLUKg/YHGZRWsT1YNEgO3rGPsRWL4Zmm8mI4fpT9LXdD?=
 =?us-ascii?Q?gNYysaR7mPpFXfaCrgBt/G8t358TVd4lA6BXk9YFj/lE5MhEVb0B5Om8gG9J?=
 =?us-ascii?Q?AvQSm3AzIExx5mFZUQrUUehRu6zEgegPQ7aTrafUA07bb6KijzlXGTuhle4Q?=
 =?us-ascii?Q?uyO5dOKPE97Nt0J/CJtKF3CMGgvX3Lamm+m5F1rRDAihXrWj9svPQaY8LIp9?=
 =?us-ascii?Q?sd9W2sZC+TxLF7V8K8fzeTcGi8HtDprZ9U74VG56PZjCsPJ4yP/faLDyPd0D?=
 =?us-ascii?Q?bMyWEPLGPHvmJUuvQOJmzovor5qLN0ZJQElHHMAJK53LqA1EZDz67hRxVA0d?=
 =?us-ascii?Q?YmfTA2WlEeQHvJZW/6WJGEV39sZeO/TnTCeQM+wNWSPOH4odFHNZksA/G+ky?=
 =?us-ascii?Q?4h5zlRt7BHqswskFtsdi7iSqYr+dFgv39Hk23zIYyBX9ig/rvqfb+/i21OEQ?=
 =?us-ascii?Q?3/JoCmZN8YjMyR3G0nL+++8J9RyTlB/d0SBJiCSLVzILxWmXnyj4tkrgXwpP?=
 =?us-ascii?Q?9BBYMgALg1os5VevDJbVn+1BPrFG3znDhW3LK1/ux4sRXqMGIQDA+WebmDsH?=
 =?us-ascii?Q?vlUH2ZmlzP2O7ln9Cpy59ySx5F4eHxSWzozt8fgbdqg+NjxCgfeiRvg+ClQD?=
 =?us-ascii?Q?Oqp1Ny5DtNpS1sE2lYAPCR5zB+GqixQ2HgBnABDy8nkearjsdHfSsGX1D+Tg?=
 =?us-ascii?Q?26SlF9iVlPiIwawsB/97pase9GM7D8mJFa3GfE7iJE4kmwWkHDLitNmoTAWJ?=
 =?us-ascii?Q?YeyxID2w3qHmRj9UXexNFZDfsRq5PSAJTmK+ohkrsgSb/XI+AmCO7/OcPxEo?=
 =?us-ascii?Q?Jp+RIOzDj+aYhrqvX7r22a8QgUe3fOqXzTBXGR9xCDxqSUq4LBJHIszfcQJb?=
 =?us-ascii?Q?stx1gbHZKU6gUgtePWDGnzh6TO7YwRVMKL8nBsUC5dxZgiQWeO6rZ0mq1NSR?=
 =?us-ascii?Q?Xy+07daHS62hrxdZa1c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6932.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc9cbdf-80d0-4d4a-fbe2-08dccdbea7ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 15:23:12.1943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZaDHORuZYUYCx0TTVA9jGPwn6ACfsdzLVoldkCKYxSAnxAA8dKoKPDWg214KXxDm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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

From: Frank Min <Frank.Min@amd.com>

update golden regs for gfx12

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index d1357c01eb39..47b47d21f464 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -202,12 +202,16 @@ static const struct amdgpu_hwip_reg_entry gc_gfx_queu=
e_reg_list_12[] =3D {
        SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ)  };

-static const struct soc15_reg_golden golden_settings_gc_12_0[] =3D {
+static const struct soc15_reg_golden golden_settings_gc_12_0_rev0[] =3D {
        SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_MEM_CONFIG, 0x0000000f, 0x00000=
00f),
        SOC15_REG_GOLDEN_VALUE(GC, 0, regCB_HW_CONTROL_1, 0x03000000, 0x030=
00000),
        SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL5, 0x00000070, 0x00000020=
)  };

+static const struct soc15_reg_golden golden_settings_gc_12_0[] =3D {
+       SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_MEM_CONFIG, 0x00008000,
+0x00008000), };
+
 #define DEFAULT_SH_MEM_CONFIG \
        ((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
         (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE_=
_SHIFT) | \ @@ -3495,10 +3499,14 @@ static void gfx_v12_0_init_golden_regis=
ters(struct amdgpu_device *adev)
        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
        case IP_VERSION(12, 0, 0):
        case IP_VERSION(12, 0, 1):
+               soc15_program_register_sequence(adev,
+                                               golden_settings_gc_12_0,
+                                               (const
+ u32)ARRAY_SIZE(golden_settings_gc_12_0));
+
                if (adev->rev_id =3D=3D 0)
                        soc15_program_register_sequence(adev,
-                                       golden_settings_gc_12_0,
-                                       (const u32)ARRAY_SIZE(golden_settin=
gs_gc_12_0));
+                                       golden_settings_gc_12_0_rev0,
+                                       (const
+ u32)ARRAY_SIZE(golden_settings_gc_12_0_rev0));
                break;
        default:
                break;
--
2.43.0




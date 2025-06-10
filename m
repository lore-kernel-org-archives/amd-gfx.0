Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C03FC5B552
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jun 2025 02:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2461310E051;
	Tue, 10 Jun 2025 02:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lg+GXJR8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50ACB10E051
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jun 2025 02:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udrGnmlQXZNFbyEKBzi3u0HwpoRwZxCh/nJebOpl4CKAU1EXg5rQDJSSjgFOAfFpc4gmVHd+iaU7oM5wIs6ru+gsc3w2xcL5iNEU/GrTUU+VXZC9/x9S/mJAyZk7s5VnMLKJxESpmBUGFk3S8endTFk3LAadv2wbhkrM5aibCqrAbaYrcE/3FFI1TRoL10Ji7A29L0q2aLR+yfYajEP7HsZnriVtTJX6JEFm3uE+e+VlFtdxYadDUTZTz6P+39pyKN4dFcBh7yH7D33E55k0e3C/13njz8FpwTcvBqC73Jg2PQaTUPiE1M4uRlyVmhqqcMmoHMq13ufJLC8olugFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3tskR1OxdTUXnlOfA9TWD0n/qE1oU2nKcBlL1Kt1LE=;
 b=g4XvI/0fX6QUcCwreFP6p4cPT4YXLdP0x+k1hCnL054e3blfvbgZ3pzZt5Dgajy//cvkJmQ68mHR5ZCS6OBdhGFuRnGhFO+K/EheAR1lKlz9z4RPRMUyINDYBYcvZCaXjOYJlpPGSD7FXGX/9igkPimLhMe1tvKPW+zjlHLlyiZyWxlimJ4jZsYZlBEPehbL+yDeq7WnxQ5yVnZlVyGM6YJMjrnKbX8etTs5/BkwroJKiIdExS8x5Rffsfe6LQgGKHy8MpbDv7na3SHfGvoykP0Mi5lzJrVKGUdH1T7Migv8Mim5SMV20OA2XULkzrqmkkKzmhUNGD9qyXJR6GvIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3tskR1OxdTUXnlOfA9TWD0n/qE1oU2nKcBlL1Kt1LE=;
 b=lg+GXJR8ByOxkoH7klpf0oV9KQfb3P/hy9NrQQEFdwgm6sb/k8ggRSAR7o5/QoZ14anoEsSOIG7b/1QHLcu3vPpvFTyr8t79mpKMdVW2DnffjsZE3HMEkqeYDCtHCr5RNjLmZPmilrCOL9By/Xh6JvXbYXXsB+CoV7bd9Gr8eUE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 02:04:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 02:04:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add debug mask to disable CE logs
Thread-Topic: [PATCH] drm/amdgpu: Add debug mask to disable CE logs
Thread-Index: AQHb1pkF6yycAwP4N0OHLhEDLUC1r7P7qthg
Date: Tue, 10 Jun 2025 02:04:54 +0000
Message-ID: <BN9PR12MB52577EEE53EA111FA7D84B2EFC6AA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250606041041.57630-1-xiang.liu@amd.com>
In-Reply-To: <20250606041041.57630-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=33d733e3-2540-47f8-aca5-4e4088035f30;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-10T02:04:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB7325:EE_
x-ms-office365-filtering-correlation-id: a4cc0f2c-fd0c-437e-224c-08dda7c33199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xOlBRrV79yJ/1DVVL/HEg9+TN4g7XvKMsjAfhXYoXhNT7y90md6jxoflTGqR?=
 =?us-ascii?Q?66SzQUIlHvoceL7k29Q6jOdU2yWs9800q6zLkbJAtyz48B6UX0eijB+WcL+w?=
 =?us-ascii?Q?jx+jdd3UZyITvUz97/hYKF8QY0ctrdIS3kS6NO7lQR54+qCNNS3/FBd1h19i?=
 =?us-ascii?Q?XtTsO8eWuSxGeW4L95H4jlB/lrgsjuRVy0++bsMeHK39/k0NhQHNbvZem3ag?=
 =?us-ascii?Q?aMGyt6ewfcT0EaPh0G34uRC322b0jeX+e91sUVMiVgBLEw7eWKE196KuS2fe?=
 =?us-ascii?Q?AdVCNJgagWecIvEnw1kIt6z/KrKGPCShGlj3sdRtwNwwsE9q9/L2JwsYuU1+?=
 =?us-ascii?Q?TJh41UGwTp1Ip029EBNPRMVwOCcszvg9KWHWaxpgyumRuXdmMhPPKlQFGeFE?=
 =?us-ascii?Q?6Agu/hGUnNmIpPOKF2dbUoMPz61o7+VHOcIQZ/EigP3NzKxZvfMIFB876nPK?=
 =?us-ascii?Q?oEPCkYrlH5E5sLF20PT5THlw9mxt+0NSo4E7CMlvDWPDPLcEQOMajgyD56jJ?=
 =?us-ascii?Q?yTNvQ3oex2kIRrbS4U2kX/3w1tMcRDbaH3XZEDA1YH+IJXYwuFwffFFA9WI3?=
 =?us-ascii?Q?CEyGyW8LVv0LHt0xg/jT99+umBqnRv7u1/zog5uqLeC9X/tfaazWDuOMf52A?=
 =?us-ascii?Q?9X792INVpWer1hNH+ch2DkMJWp7ivcUG2hdtVuT/ob8D7IDkQJwN+LtsOQJm?=
 =?us-ascii?Q?+Mpr+hzstjIPEtUxWWxDRBLqBPPdUMqH/GeL3Wk0tDdC9IPev3GeCcxdjZQ2?=
 =?us-ascii?Q?YPoUfZUwwUB5IMH5iqUDFynGLZLDg0IGW9xgzbSEnw2HQ9i3YJxES/RmYN82?=
 =?us-ascii?Q?CH/dUlYn9qjKM69zR6i/FXkDxXzTxXt6PDmKyNYhFcdP6vAE6DwRCTGhgN5O?=
 =?us-ascii?Q?94u8yBEN8bdWeZpF9Pw1ABVt9Pl1Sy6Owg9L9wEABJ36li+uvo8J2Pfehvui?=
 =?us-ascii?Q?LN+gATgUf+kcNh0apJsynyiLeqqefyBQfZo8s+jq3DoPzOU/1uMtooLtBES/?=
 =?us-ascii?Q?yx1Bxb0GnfXKm2moJB4jlQN8NEbjqvW5E+ouGmrc2v/868HjpYcT7KXmRdUV?=
 =?us-ascii?Q?MeB3UTCKj6HI5TySVpMjIDbAGRxfWLbcmHbUn2vLRf14oME6NpUVeAYi4uWb?=
 =?us-ascii?Q?919XefYL5xzo2tJpjb2hPFigmukWu/oiXrYXWYY8f8gR9TtU0ySDke0CW6jT?=
 =?us-ascii?Q?AIkNhavdQhwaRXnHjt3A3Gj3K84YbWeSH71P4vJUvRhiM02g49XlWTzAGKL2?=
 =?us-ascii?Q?iUv+3eOB6jl99bmerW5KUa5ON3qvYZPpqmDlB67gwy3+EtrA9Tx7+MJrenwO?=
 =?us-ascii?Q?HK32WTPKQlm0XWV4DXkWGXJpvSgJiSTYCSErp5QDM/n79ws3rZ/bhg4LPqRh?=
 =?us-ascii?Q?DAxYc5dobdYhYqrrmuaJEyV3rtR6f06K+fdslC3GB3164GUr+8NbV3Qk10yc?=
 =?us-ascii?Q?i57Tc26qvPAi47MUzCqy2alVx73RDKMpL/nnvTxf+e/T0RUEh10prLvLewAu?=
 =?us-ascii?Q?WutynoxGv6LxANA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V0FJRYZVK2P/quOnQP/RbTn6XmpjWuEYGct329BYBxB+gwOVhv2Qq7nu/LZe?=
 =?us-ascii?Q?XaVo4FRKenWdFQpHih5518VhWTNzUgnUNaGkzX5Dmuid1G1LgAbY5AFc6RD1?=
 =?us-ascii?Q?On2hmsRIiO3J/bKyaNnln73brCyvhrQnclviS5oe+wb7Txt6/6U6JHUZEKqD?=
 =?us-ascii?Q?toATekR66XezWMRo/TjC/OJ3DhVwv2oIMfpoC8Z6M6uKmcPLfe+bPByHcsu3?=
 =?us-ascii?Q?ItoUU6S/viILz2yDsgwlL4rthQJlkLd/+NDN+gtsRKa4HeeppQxz52TPsehR?=
 =?us-ascii?Q?BQWQ8PWqI23e7Q/wIjaZFCvsAVl0P223ZRz3kOGAXFSLr11SxGI8M4USMzRq?=
 =?us-ascii?Q?888pLdeAUffaI7lvoRhZF503fMqS2hyACZ3NaxVivf/RojLBNXw+RCC8aK8N?=
 =?us-ascii?Q?ecbTkz5VECdcaQ9CBF9q8Bo5lMAqo1cJQgul2glJoRa3/HL+XNOIwdUwmF1e?=
 =?us-ascii?Q?Pp+KzEVL8u2fGPcWK+xvQNtoS9C1zYr+dvMj2so65HZ8vs6CyEVFKFtmQMvp?=
 =?us-ascii?Q?sKE/cgYmwyW7FU16q5s2eitD5tEOtwxRCxdtDkDSSx1O1D1cCY36kemPml40?=
 =?us-ascii?Q?q6+FDXmg2zPFT3mbCrx3BsAAgJPIiXkT55JVETtxz1i32PRAuKv48PYdpwaQ?=
 =?us-ascii?Q?y9rZwerBvQ+nRud6c2fxUXSxEno9qj61iuj9W2JAUyOZTDy1xGGm6xMkbWf0?=
 =?us-ascii?Q?iz+OuksqA+kUChdAPmz0TLo89flFCX0fw/Sw6IBslLlMMCnIjGl7/8WW1Asj?=
 =?us-ascii?Q?/j/0TDE0sTaujIVnIdwx81/KnV2ndmH8ncXWahxFA5eCu9AiKdRMzPrm4sv+?=
 =?us-ascii?Q?rkmEoA01RrvFf/8sv4k5z5eKnaBbsjiq7SeGgjg0D5cD0eY0xzr+2WL9ily9?=
 =?us-ascii?Q?V4j9fv3QM3TIldLCCqaYpat+hGXzHBYDEGq4kg/YsipQZjJDqxzfXiY5p8Zv?=
 =?us-ascii?Q?4ou1IXg5+tVtVMoK7FZWic7h4aWbHS/a9r1ECKsLt+sEC1aDBX4e1k5RVa65?=
 =?us-ascii?Q?JHgpNN9TmQAkJ9JoS2Ui/9wAi5GwY/a8inf4GuYiQ3lEO73caC7VGwZazs5w?=
 =?us-ascii?Q?pwOAIvvqq+JIlGXMTlMAPgqnGXffQ3WXAyFxUpLnI2UWgz6QuZcO/nnRBjJD?=
 =?us-ascii?Q?kddEhlrQXX6OeB0Cv0nwJkVBo2mi0RIAYQvtFraXpOBqiu5GqDEzXj+EPL+C?=
 =?us-ascii?Q?qpTwiiCKEFjTG8mfkpo9KQgd7QRJmYthZ0qIT3CfqEuYOe00MhSFiFEQK8EX?=
 =?us-ascii?Q?2sHpNMA0wOSb0F6/XChBBZd6/ypynUKuNLvQHGkyUQms51SyDY4o4fnWbwgZ?=
 =?us-ascii?Q?sXXaD/y3UhPeBppNqp57jPP8uEBzqu4aEaetM5sDhvXCHTt9vKYsytdbJxWn?=
 =?us-ascii?Q?mCbPvvLY1kL8urFpgwpjP02HMPfyPhgvaJhdwioADgrIrb1u+2bpqgPx87k7?=
 =?us-ascii?Q?n27jFHWrV3mJB1+5TsccTqlIeD3jjlP132O5ghVrII7Jf+E6UXKG6/zTmnW2?=
 =?us-ascii?Q?JQJEDchK6wFnrDSaLZ+my9t8eLbtyMmWKlCQ6hUmKZ+YXBhcmb3/tzqJ4/Bk?=
 =?us-ascii?Q?CbxnUzdGSmq5uCo8oNr1mPYuXYF80hWtz4xKGeiN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cc0f2c-fd0c-437e-224c-08dda7c33199
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 02:04:54.9039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNhKX6+WT9ZQYh0qrRgEAWWJ1TFe1/T3fq9AOEKNSg7DwNgfrQZQN/cAfryCMqccGDPRB5Mt/c0hFS3QK5YYqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Friday, June 6, 2025 12:11
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Add debug mask to disable CE logs

Add debug mask to disable kernel logs of RAS correctable errors, including =
both ACA and CE error counter kernel messages.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 5 +++++  drivers/gpu/drm/amd/amd=
gpu/amdgpu_drv.c | 6 ++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++=
+
 4 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 9f7284ab5ab6..d0982dbce31a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1309,6 +1309,7 @@ struct amdgpu_device {
        bool                            debug_exp_resets;
        bool                            debug_disable_gpu_ring_reset;
        bool                            debug_vm_userptr;
+       bool                            debug_disable_ce_logs;

        /* Protection for the following isolation structure */
        struct mutex                    enforce_isolation_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 3835f2592914..cbc40cad581b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -115,6 +115,11 @@ static void aca_smu_bank_dump(struct amdgpu_device *ad=
ev, int idx, int total, st
        u64 event_id =3D qctx ? qctx->evid.event_id : RAS_EVENT_INVALID_ID;
        int i;

+       if (adev->debug_disable_ce_logs &&
+           bank->smu_err_type =3D=3D ACA_SMU_TYPE_CE &&
+           !ACA_BANK_ERR_IS_DEFFERED(bank))
+               return;
+
        RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architectur=
e events logged\n");
        /* plus 1 for output format, e.g: ACA[08/08]: xxxx */
        for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++) diff --git a/drivers/g=
pu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7249f815feaa..fbd0e3a030de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -144,6 +144,7 @@ enum AMDGPU_DEBUG_MASK {
        AMDGPU_DEBUG_DISABLE_GPU_RING_RESET =3D BIT(6),
        AMDGPU_DEBUG_SMU_POOL =3D BIT(7),
        AMDGPU_DEBUG_VM_USERPTR =3D BIT(8),
+       AMDGPU_DEBUG_DISABLE_RAS_CE_LOG =3D BIT(9)
 };

 unsigned int amdgpu_vram_limit =3D UINT_MAX; @@ -2302,6 +2303,11 @@ static=
 void amdgpu_init_debug_options(struct amdgpu_device *adev)
                pr_info("debug: VM mode debug for userptr is enabled\n");
                adev->debug_vm_userptr =3D true;
        }
+
+       if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_RAS_CE_LOG) {
+               pr_info("debug: disable kernel logs of correctalbe errors\n=
");
+               adev->debug_disable_ce_logs =3D true;
+       }
 }

 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned l=
ong flags) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_ras.c
index 6565dc7ff9cd..505850f415ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1107,6 +1107,9 @@ static void amdgpu_ras_error_print_error_data(struct =
amdgpu_device *adev,
                                              err_info->de_count, blk_name)=
;
                        }
                } else {
+                       if (adev->debug_disable_ce_logs)
+                               return;
+
                        for_each_ras_error(err_node, err_data) {
                                err_info =3D &err_node->err_info;
                                mcm_info =3D &err_info->mcm_info;
--
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0791C0015E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 05:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5A310E345;
	Tue, 25 Jul 2023 05:53:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837EA10E345
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 05:53:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKfLD/vpJ0OAf8fhnApOUHKQhRU9tXN4o0NhgHJUOR/8EdNZlDnWHz7WDOhVImMuLYQrVR95W/CcD/yCMeCzFy6eIkv/236RCwsUSAuQbg7afX80E2hyqFKJstuQOITiZJdzc/b0v6no0YlmxQ6NeZUSZJS2dk5LocZf5LKNnGWC5EkZJjMbq4/fGhGiNUXK7j9ZdH9Hp8AC2zSzChz29Cl14hvFzXyJnzND8nN16LNkrSRuie67Ic5HEOO71qTgHe/o1zv7sigwnCyK4TK+utGItcUs2rLWZLVuLkt7/+LZ+BGJOTpSnEGoqvtqsF3RM2e/jvIF6r3mAoRovC2fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGNVSj8SWXt43PWtqCYjTfh5tr4GsA2WMsf7nXDr+NQ=;
 b=fRn2YpLZklKLp2nrirH4DpvviaQjO1CrUpofeAooWoMBLjrG29awBxElN/iFMMOB/z8dUqaJPOUCpR3M+VXXfjSZPY52KACyipoQPnmfyiP0Rm9efIc5wH6Af7zys6WAH9R/syCK7G7QZ2izld19JnZsSy3Kw7DRlLgaEJ2lrJjCtLzuiyquJ5HJIUgxmUOY/gJJCMWqpAmpGnLuOH23a3S53WG1HWJi1uBJZAmhry5l7tsBL3NayWCCmJZJCDjSmwvlYuOE3KfVY0e39BnEpDxkT4/aMsPAjrDgWtVKMZI43ybS3tjKFnyA5H1ZN2k2arg6JjCUv9W1b+qO0CqMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGNVSj8SWXt43PWtqCYjTfh5tr4GsA2WMsf7nXDr+NQ=;
 b=FNrKbuckMRswsSAd9wS0L53U/xRJclzkFDkSoMixdq6jdnQgPHAtmhSo5n7MwJM4e7znaTOTIpA1lr6XVMjGDQWoXUnQrC4zsZHi+mm6fGgrLx22lP1gSSxjxRvCkunFak0aCvSDRABO0ZK/hkUW/tzCfgcAPQxlpWM3I5GgFCs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 05:53:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 05:53:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Restore HQD persistent state register
Thread-Topic: [PATCH] drm/amdgpu: Restore HQD persistent state register
Thread-Index: AQHZvrtR7kRD4mx+cEmoQI1NVDzd6a/J+xMA
Date: Tue, 25 Jul 2023 05:53:22 +0000
Message-ID: <BN9PR12MB5257B87F32FCDE34AE5A4A44FC03A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230725054554.3188083-1-lijo.lazar@amd.com>
In-Reply-To: <20230725054554.3188083-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a5d44ce7-5c5d-40b5-aed4-faaf0a6b99e6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-25T05:53:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB8734:EE_
x-ms-office365-filtering-correlation-id: d8667904-b713-44f9-6224-08db8cd37466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MxkHe5NJzUWS8cWz1p74leh2Sr0Yyq0Rk7VXi7n11texLvD4eVRqy12AUGMo3PGOFuHIs+k5Oo659HvaXJUg7Fbo50lRb7VtFRH5aRQ9cbZSYaF0dF/wDBWX9N4g5aIO0KoILJ1v20QDMgcajEjrqS3lNYKkfwghrpPkiCizFhScugO3v/5qrwK8y6gPY6wsBkakLxsaJhY1mtUMpv8Txn38+3CFVNK0OnZ23YPU591EDVumiH3zRNedvC1Zvg2z2OblhjEbt55kYUo7f5S/+fM3dd7LfvrecPSfnc9qF06bOoivWy3ErIEy68Vrx/a29qs3f4Du0eCPPSLb6PtO4n/ivArnZhYo0Vqmk4KUZu6EpOlS/9AhXkX38rVlBUOJ854x8C9T1kV/hCmvOtBI0j6tHaF6eOUeZnSeXWOacLanO6FQ3Q/R8Xi91fALzifIoH4KAcwEw5BZEcay1Qm6bTRw3WdT6LAYJSU7I5h+GCaDlPFneNPpCCW07mxYYkZ1LaeJpiMvH4D885kVcK9fsl0YUzf0XTgSwGcXRCV94jCmqDkBpnXJG25+7ZITzDSFs0pvoOlmCVdSYhAncNKRHfZH9KXHlXKFI9VnpgfuuYj3inO2Dc0blvdE40g7ru/7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(8936002)(8676002)(316002)(5660300002)(52536014)(66446008)(66556008)(4326008)(64756008)(66946007)(66476007)(122000001)(76116006)(110136005)(38100700002)(54906003)(38070700005)(26005)(33656002)(6506007)(41300700001)(53546011)(83380400001)(478600001)(186003)(2906002)(9686003)(86362001)(7696005)(71200400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PykBJ9+9MJQyXBfedPxdxRDKtnNlN+z8YzNLaEodkGyJh3WH1nBZU5hesRbK?=
 =?us-ascii?Q?nlKuaDkPLypmY29wbGKohRcoJuAmRK8u+fN+NOHmiHpPSkzOf6Ux0FFCyuio?=
 =?us-ascii?Q?8Ib0iebXgiB43cnZV2EWg5Jx2vuYO4uJQ0rrYDIQr+p3BQjD6WvYyztM9sqe?=
 =?us-ascii?Q?Kkd7tfaf01PSWhc/d/sAQO+xpzFvOfjVToergOEB4JethYH6/sXtH+36JZMy?=
 =?us-ascii?Q?Q0jfJfgMJgOGqYu/qxciL0NqcXs+y7QR9Frx+SOyF1h/x9XpNK2oM7VJCwBG?=
 =?us-ascii?Q?lnejh566fXPWEhDtcfZzrtwBhBNAjMysf5bthGbukN5Zhx6sJGkJrsHdk3dV?=
 =?us-ascii?Q?KRw+Bvz32boUHdTdjI3gV4B/pS0v6wEB1gvJkueNA7tqpnRv5Xj+DOYr7psU?=
 =?us-ascii?Q?ilsgjkX5y9qAFbBRaamnr3FoRqg32thcmYkOSjOTz166z0r8tA2VKmv58wCr?=
 =?us-ascii?Q?ADtLE7lFEZhv1JMIx2TEWUp596VD4O1qtkl74OFuez1YHOdrrvDOttCkrtV0?=
 =?us-ascii?Q?r0SgJm2L8Q2+4aZaAFQTZJlCmAEkw6A0CY/RcJir1XGGNqPXgJq3O1Czkt1B?=
 =?us-ascii?Q?9GxoSJADnKMCo6/nPJD+ApTrMBR45uqmd7SHdzovMFudZ8ZGmEJgK1+xDl/o?=
 =?us-ascii?Q?R/berIIenR+scdBscj1l4wmvrqPtdPV8qQNlUxcRlKX7hj2yKJD5kFW6EKcj?=
 =?us-ascii?Q?weBHM6GTxtXG9bVzrx1r/Q3kqN1bMGJpouKAS8khenJ1ks3QBqBD6p49YKuW?=
 =?us-ascii?Q?qMxB5xB5M9fzdmr8eC/4FQAkMBHQfJB1dGClLTFYVpNygTydP4dt181ia7SX?=
 =?us-ascii?Q?fIFmH6XpehB9NBjbuqaqCNzpsP3e6PQJDRJw5+gaPSf1jCR9YZS/yiSeuyeT?=
 =?us-ascii?Q?hBR1k0K4IUwjoIVifE+mua3qN1BoOeJVr7nV7QfMLjuyZ6qPK3+k7y7LS09a?=
 =?us-ascii?Q?vDH0rUiARG5vRXvl3DQC5t5dihajr7xxrA1DuM9BKyfweC+k3i5kxRd4/9HT?=
 =?us-ascii?Q?Kv255pkpH2nOVnugzZA8UbMPgC17d7y4BCtbxlzyYpkTO8M72zKOqQppyKDk?=
 =?us-ascii?Q?JWBcgY3gdiDKQ7/EcSQ5ujAYi3cqvFJBi8RxDYJ7y+BggZ++Eg+aG+Z5tf3c?=
 =?us-ascii?Q?RLDI0+1QgSF0/laWLDFFY7oDoNsBhwIf7o9B74pvqNkqAOx0taFdzH7mgtFi?=
 =?us-ascii?Q?iRAGiZoc+1SZrEoKUG9M6HKAaHvWtjx2BmzZtrnr/YG19vrcbmU10d+5726a?=
 =?us-ascii?Q?fAiUgx0meuFo15Q8HuZthvFYgu5pu836t9Me8HPjL0xGHg3ZiBxm6TcJ3yYN?=
 =?us-ascii?Q?6KtFI18hmXCRKZvIQMIN9g6yVvaurPsqzqEhqRjGzFBg+tOn8DXG/0D4Qd5O?=
 =?us-ascii?Q?uEZeFI9OA8/Sq7jNWTG70D+zvGrOjnQ2koQIuEK8akL2cSNgQixjkeja4Wct?=
 =?us-ascii?Q?d0rr3tUB5TlatvV1KTc7rr+gdI026Te1c4wPsPf34SDx5iGww2KOxqSoiwCZ?=
 =?us-ascii?Q?OiJxrKKA44PAAsQ//A94ZdDVpB1F7CxXEI4mPx9LwyXBMtiPH5S3+pIl5Ets?=
 =?us-ascii?Q?/bHxtDFw3vw1Ix07JuN5ltPQMMMFClFCjeufR3CQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8667904-b713-44f9-6224-08db8cd37466
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 05:53:22.1314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THrbVYcmhLp2td1gVfmryEDC2U7muoT96A0m6taYPnPLuEADArr+5lvMhh5VayfAIv/bKwjT9QF+ON2SnQcS7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, July 25, 2023 13:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Restore HQD persistent state register

On GFX v9.4.3, compute queue MQD is populated using the values in HQD persi=
stent state register. Hence don't clear the values on module unload, instea=
d restore it to the default reset value so that MQD is initialized correctl=
y during next module load. In particular, preload flag needs to be set on c=
ompute queue MQD, otherwise it could cause uninitialized values being used =
at device reset state resulting in EDC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 8b361aa87d01..306dc6533397 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -46,6 +46,7 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L

 #define GOLDEN_GB_ADDR_CONFIG 0x2a114042
+#define CP_HQD_PERSISTENT_STATE_DEFAULT 0xbe05301

 struct amdgpu_gfx_ras gfx_v9_4_3_ras;

@@ -1726,7 +1727,7 @@ static int gfx_v9_4_3_xcc_q_fini_register(struct amdg=
pu_ring *ring,

        WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_IQ_TIMER, 0);
        WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_IB_CONTROL, 0)=
;
-       WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PERSISTENT_STA=
TE, 0);
+       WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PERSISTENT_STA=
TE,
+CP_HQD_PERSISTENT_STATE_DEFAULT);
        WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CO=
NTROL, 0x40000000);
        WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CO=
NTROL, 0);
        WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR, 0);
--
2.25.1


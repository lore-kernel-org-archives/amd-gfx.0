Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E276BE81DEE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 12:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A1310E4DB;
	Fri,  6 Oct 2023 12:36:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0590810E4DB
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 12:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONP4lgbEddCHJ9G9r+uVZRFmMKTjIgYXjNYXgnpBujB0bn2xZxzrgwLUjoM+HOpH6lPhBJm9UTRgV5V7tP3q8TPZrZ+m0m7SzAkSNCSZF6rIkucd85wrE3mFEsz7BP0lgBAqQOojVFCPM8/C0HVasw6tvr1wz7xusKhijPqWwtltVVKFuTv9JgvNFFczRrpVPGhuJRmVKX/QU0xEyUQgcfltqbdNNM8diHmDOAcOc+RviG0H+Bf44BWq1aYLUguJwFORg0pY7HEs/PH/aqly+GBhPuLb30pBsqSD3KeD4WYxWqIRgAvN8Fgh2ZB0ABUjkCBxZxztNDXDRn07nTHmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gqh2dlQ31cpUUDzKRq6e/mSaaskBbRrzi0JahVuBim4=;
 b=VvDzdrqZIGAryEKabzDFzbqp6tAkNeYqbf+h2RVlC4TtVjKliEW78QSyo6743qmbZh1u/Jnwkp95+XE3WhDNh2rE0fTzbn3xqebHsBRmh3txa4UH4vX473zd4xMJrFKbWxDYNrgmD0262JdXvymejks1ZnhJzaux+TQynk85wHE7fff/L+BdnZXcNAVPClVFIklhLAZdztxhffs/lGtqKfI9dJiUjqTBt6yLimZl2c7v5UGnKSpBqXWeGSyqWNQMeDne6JDdb6/3swJmDgIEGpf7pS1DG0EkdpwxLKJWhSkOPBVLmbgpTsyT5nnM/SeW1PwLo+S2RHwlSZEoc38wgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gqh2dlQ31cpUUDzKRq6e/mSaaskBbRrzi0JahVuBim4=;
 b=QtqxMpXt/xkzM3MqLnYHIsTtnmOTKIZJ36d2zYybEDD8oy567Vr4NPwr3bRj+/QNQ0+En5zpoKv04M3ZqcjUXV+wmKVNSUXYRbo87SyDIdXBP1xt+Xna38Ssj5j4ObmYP8VsnATpRqq68fd7tXCIRREGjmjcXCpf6xkCxjL1yec=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 12:36:41 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 12:36:41 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "StDenis, Tom" <Tom.StDenis@amd.com>
Subject: RE: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
Thread-Topic: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
Thread-Index: AQHZ+BT/0fqBx/cja0qrrrgrwPZdo7A8otkAgAAP89A=
Date: Fri, 6 Oct 2023 12:36:41 +0000
Message-ID: <BYAPR12MB4614CB22B5E7598DBC5F401797C9A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
 <PH7PR12MB599741EB6BA789C3D349682182C9A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599741EB6BA789C3D349682182C9A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Tom.StDenis@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0bc6a3b4-fead-4828-8d2e-2787ab0dd4e1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-06T11:32:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|CY5PR12MB6251:EE_
x-ms-office365-filtering-correlation-id: c9c52f1c-b94a-4d96-90ab-08dbc668e49e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WAcexLRvhSZiHaGHIM4Lk9qbLk+YxewDcVLLgiYEnOeQCBmmnKFyIPfZ+ePAQ0/ayjEmrS3y1x6nOId2lU8FPr9Km9cUZXX2cU7LmT+UT2CWqJksMHWn3CYJAksE9TPZWHL0mzVyDXNaia/XD3GqGYpWj8FEMkV/m5aGaH0qNeqykz/gmep/A1Y4AEHrKCtXqEsxDz5qijrlBlE6NgPFOj8qN1rE6N6CWO3vv7+TuiXRqVJLN+ZRuD4f4nllrdMF/k1AFdd3XFmmH2qVlLrbNhEE/AV58cwrDj0Rittq5Gy7ML4noPPW2zCdiK2jJZCr8KB5tTt0FPN8PvWV0vUbcHkze5h7N0Kbl+fDdOOrl8xKIkbxyvfxEpiM1ghYD93Dch5vNnPZiOynjJgyT+HKytOHooWPf/cqiErxRcYNr5GaZm8Z3G7x8XISw7wDfF8I8CYZPjOmMdDU0X+Bp+Pl4V4NSJugQj3VJT2GxTFN02ZrW75oB7YYDhmCPSDejt0Z3fEm36SWd38BC85jH/g/qAuMdj0lbSKC5vCkrsCGu026eQbZn8e9J1XfKYkFrWHTw5kBeDZHCb/W/nphpPemNKIYls0NrNy4H7h+T/Zfm5oxiGJqUkSOMIMZkv+xI3uI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66476007)(33656002)(52536014)(5660300002)(55016003)(4326008)(86362001)(8936002)(8676002)(2906002)(478600001)(122000001)(9686003)(26005)(38070700005)(53546011)(7696005)(38100700002)(6506007)(71200400001)(83380400001)(6636002)(110136005)(316002)(76116006)(66446008)(66556008)(41300700001)(64756008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6/HspSFMqpuHmjzJ/QuK5qd2tVIGL9BoJX2ZJWRlJZVHlGosov9MUnyVxI7Z?=
 =?us-ascii?Q?mO7SSCRX5VX+15JIBp6ANCEOH5UApoQqUdao4fgXM43UW8COUqIss2Stc4M1?=
 =?us-ascii?Q?Qsgo/2CrZnOuY9S/mh/3GOcIIKCWAl5lnPMtoMya2xDHsgmKAuXfxFXMPmPO?=
 =?us-ascii?Q?f1i0cu1uek8bU38d0H0FQfdh7y18Ip0YWgBFhsYZITdL5GzDyKuo/KZf1K3w?=
 =?us-ascii?Q?hYvkl5Ifo9MQ7Ou99uXVtE3BoWZgqAwEdrpFV3vqoP8I7EPbxkn8+m1G5JTH?=
 =?us-ascii?Q?gzDlTuRxX06jFS6VhOB9rR4S8+T0Pphp7wn8apcqTKuOnxEwHtDo7pQY3Pah?=
 =?us-ascii?Q?20vkXOtyCqTVaPwAT0yfS1v4y/rLJOfv7iNq6qiiP7LOQgc5tHuByypgyunj?=
 =?us-ascii?Q?AIsXbP9dpKF/vmrc/UUjpRmMJzbX2pJf5bdWj1YyQNuRM3yVYfY8qmDPZ4sm?=
 =?us-ascii?Q?x1oJgF/gZ9t55Uwk4pNPC1Mh8eZNusXstdwY4zWyq5HR/Eql4v03/TLBLQh+?=
 =?us-ascii?Q?5V9prd1lo4TfIUi154dnTPBBvNgKuh5zRBzsfeEBvGtqIVab73/RBU1T+LZ4?=
 =?us-ascii?Q?rk7BeipAo5FV3a6RjhO+LNYZugcAmW+8ajRVKb3hPZReQnM4NqRUuBbxCtbx?=
 =?us-ascii?Q?r+37qXfkRvLBU8fLJnN66UeWEp2dxKYE+ez0Pi2NTy+KqPd1yKUONtnppb67?=
 =?us-ascii?Q?y8++g4FP5wYbThRe3NJn0v4owlhYLZUO+c3JQ3uI1qKjW17pRGSqf9TA2zOd?=
 =?us-ascii?Q?uYtn9k+lRT3KynxXnTjDnVeD4paX8sMtxKXrXpqWfz6eeI2XxZBtDauvzwrN?=
 =?us-ascii?Q?z+tob3xc+PxtADN8k2tJ5hXppEQYDtQG4L3H2QCdWivcG3da7wNVnjo62i26?=
 =?us-ascii?Q?zJaT6GNfZyznlsq7zlKgKK2b+5lRVHUyj2Iga5UYRtqESVu/yWENyPA/olYK?=
 =?us-ascii?Q?tkgDZxtTPa6RWdAhjNbAviwIofCDkSdcVirgBO+mLQ+Wvv/9ap07z6b6FpiP?=
 =?us-ascii?Q?vC/3BYmaeHNb/K6yyDbDlxSnXYQzkWWl5qng4euhiqk4Vru+QAONkuaadGu9?=
 =?us-ascii?Q?mwyYkBsuSy6q5axdz1VFErsdgWVaipj8M7Wj6wF3uxbn3Mi61aMG0Btcokqw?=
 =?us-ascii?Q?m2rzGyxp7UZhUwYVEBZ47NYd4Fnr8eqtHT5Brrxe6I5YDaeTlER6GCGb1Ynk?=
 =?us-ascii?Q?kk0Mmb0Qko09HuV/5G8ld1tGv92/tKNQfTmSM4H8cy6yZ4SGrKVueGqqbNC2?=
 =?us-ascii?Q?l2v7WqkLpj2ysTtYg8sfgvnWyxWOpsfKwdysdUkqILeHAnxZu8Ow9RGfzSHq?=
 =?us-ascii?Q?v1JaWj0iiudgeQOfhK3zF9X+4TN5upcxJyKZbSY5fybyTRn1YNSOMLeckKJc?=
 =?us-ascii?Q?Y2MZny0RJU00gu5wNG2wuazm4SsHiAS8s7ImDptXIVlfmZM1dCxiBnSHELSA?=
 =?us-ascii?Q?TfT+b2l9DRUmY2DnNzSR6Ih9GmQhUp8v5thzdwTktgEDoMbrbA7FQi3k49fB?=
 =?us-ascii?Q?G+0o/BxhThydeioSvrsmj328/d2uN16BhuEJ5bOIELGKsk/IBPMMrzB7fiVP?=
 =?us-ascii?Q?0zPd37/EbFvfJ3Q6Ae8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c52f1c-b94a-4d96-90ab-08dbc668e49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 12:36:41.6935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ilFsk+4h9IqJPA0+LYchbXknNFXIO7bukpW763R9uIR1UbUdcFX/1zMiVq4ZxoJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Presently only a byte stream is intended. If version is needed, uint16_t pa=
d can be converted to format/content revision.

@Deucher, Alexander/@StDenis, Tom, any comments on keeping a version?

Thanks,
Lijo

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, October 6, 2023 5:08 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition

[AMD Official Use Only - General]

Hi Lijo,

I prefer to add a version field in header, which is used for compatible in =
the future, what is your idea?
When the user attempts to parse this node, they cannot accurately determine=
 the format of the content.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, October 6, 2023 1:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Deucher, Alexa=
nder <Alexander.Deucher@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition

From: Alex Deucher <alexander.deucher@amd.com>

Define the pmlog structures to be exposed via sysfs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index e0bb6d39f0c3..9905228fd89c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -980,4 +980,19 @@ struct gpu_metrics_v2_4 {
        uint16_t                        average_soc_current;
        uint16_t                        average_gfx_current;
 };
+
+struct amdgpu_pmlog_header {
+       uint16_t structure_size;
+       uint16_t pad;
+       uint32_t mp1_ip_discovery_version;
+       uint32_t pmfw_version;
+       uint32_t pmlog_version;
+};
+
+struct amdgpu_pmlog {
+       struct amdgpu_pmlog_header common_header;
+
+       uint8_t data[];
+};
+
 #endif
--
2.25.1



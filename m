Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94B1E81DE9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 12:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D88B10E161;
	Fri,  6 Oct 2023 12:51:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F3C10E161
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 12:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TR5Eb5F1crYGiYnzjzzKJ+zgW/Az7FSzSRo5Etyggct/pW4237SyTbiblr6T6BtOagEbFBR7QdLLtFtfu0VAZulyLqrmUf51XwWOZpEQ1l6PgCVBuAVu6C4mWnH7xQg4wqcIg/J+Xe8BUe0MQ0p8Q/OqpHjiB0LV2wHpBiOLSwnY6fFCnJFV5GLx0TIHdpMa6CQ2ow/RQFHolexYpbtt0oWmgt9ckuOhkchxTqQIS+jaffNGCWNBFQJrNkCfzU/BVNvqeFimDzbvMeUpsX5dj1e9vfWTCuLwI2lsglNeXwtN/RFLTxf6A3kyziQ/3+cNe5vIUGJmRe2r2z2Qp9uIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTdn901RAC2d0zHkAYUlOGYpoOpc0J5EAtzU9+X7hj8=;
 b=GT49OYSLP6zgmUlUz/QmdQZ5Bd8wa0VxyVa0HWoYIE8dA/aM18AGkry4Wpq0ci3+3aW1udOHZHUJjyfpLs0PXkjXM/HH2cbdYtR6Jz1d3zJxQg03sCAUOx8mcn5grjzonl0NL7BmbPIGFiOyIWDReqwY0etA+Pt0g/9bAe4Kgt2Of2J0uiKHF+7gdIpqdGD+SXpHdRBRy8QH+7jqeCQrofRPkNivoKylh/omIwktYTHBMuQ3awsSgRGs/uisxcJnBNOWcwyWOHe8gd9CFuN4HH4CG8Bt3HGuuUrFFWKQxjTJHYW+6/IZuw5y5krBKI46pneYH/KBBZTRUoeRPQz0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTdn901RAC2d0zHkAYUlOGYpoOpc0J5EAtzU9+X7hj8=;
 b=HqkGIQ5S6IurvAe8tk31d3egAO/Nb9LhDaxpqYLky/zvEfKUlhOP8X3FTeSZnr4EEtYLzgsGRUl81Zr5546tZcEcC4RJzUZJEQ5tJ8LpiGH+h2w5AT1q5iJeoIkWS+Gwr7P/385o4uWXg3+A+fmAZSoZc8F3vIIriKlI9GaIzKU=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 12:51:38 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::e5f5:ea6:6420:87b0]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::e5f5:ea6:6420:87b0%5]) with mapi id 15.20.6838.027; Fri, 6 Oct 2023
 12:51:38 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
Thread-Topic: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
Thread-Index: AQHZ+BT/0fqBx/cja0qrrrgrwPZdo7A8otkAgAAP89CAAARkmg==
Date: Fri, 6 Oct 2023 12:51:37 +0000
Message-ID: <DM6PR12MB3547B76D8F43ECC6953404D7F7C9A@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
 <PH7PR12MB599741EB6BA789C3D349682182C9A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <BYAPR12MB4614CB22B5E7598DBC5F401797C9A@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614CB22B5E7598DBC5F401797C9A@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-06T12:51:36.891Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3547:EE_|BL1PR12MB5207:EE_
x-ms-office365-filtering-correlation-id: 2236a38f-86f8-48b7-0f86-08dbc66aface
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gAQJQD2bAn2fzFpKe6ylH0Z40GynvTHpd+cj2h2srna64kG4RxNy4TrT8kObY3mM1WYM7zpc5jqbXkSWBcOrXmeo3J/ueTYbxNZEAWruViEOQL7JSiiwp1qqFrnYNuOtI8zrzNcPmTTF8k8GXkNDq2FFNHIiz5my3FBWJ0IWKR2SO2S3JYQXNBhEUjjcUmIvvRAuOFxFFGmvXDsXRfFeRt0jHHtmj19rkY8rm+0MdqcGSVOJKrWaNhyTjCu2MjNSotKxI8bEucX8IP4Nyw91e/ueSHAcjzeaQiSA8WdjKCxd8I8BW9Qv9sxp3hPhomqVrk6aREpXfGKnLT+9i84vKfaGeqXPD9tjYlFF30+lpoY04v4D3q8cNzVjNXYJ1GgN/fvbKCb1OLkSNn5HTH0xOq3z45i2sCfQrAPcfDU552kksl3qnh4T1PClCBnGESka2v8SFU1B/7F8wo6PVGFBEmy4uaxh0hBV4nzG+BBUNWxSDzAah16zCB+XcZ0VR/vp0OiHqumuPvHXoZEk/JICF14ncXuGRB38X932KRlDv6dmcIL2B2vWEtv8xuD5spg0i4GqSutGDIfj8wv94LIDMWzeuiJx86BM4K9Xlt0f3Ufy6D3CP/94PFHyQyqXooGM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(7696005)(71200400001)(6506007)(53546011)(478600001)(38100700002)(86362001)(38070700005)(33656002)(122000001)(2906002)(41300700001)(316002)(83380400001)(26005)(9686003)(6636002)(66946007)(66556008)(66476007)(66446008)(64756008)(5660300002)(91956017)(110136005)(76116006)(4326008)(8936002)(52536014)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AwbBc5trhh0Wb9FJJdqBgUk4BwNr34SYxUfcPqGTXL8MDiWmmyoeBST6qB?=
 =?iso-8859-1?Q?s5MRA+jtDsoWzjI2iveHYQWHV+lm8xbQdKkR0KsTNKUC9dmelKoneZuGa9?=
 =?iso-8859-1?Q?tRVd8uahsimPZaFHKSs5uOW2F7rS4lAGZTjIdI9b/frkpeVOmfgrbh7d/N?=
 =?iso-8859-1?Q?kpHMzoFYkAcKtR7d3qyY9vE0PprfI4pZUvjgdOmzSfKwPhjkVUB5TSs0Pf?=
 =?iso-8859-1?Q?4ZHJMS43aYS48Vl3bEy4B82q1B1G6l59ERDYpG/EGeeIM3O5d3M4Ukj2O8?=
 =?iso-8859-1?Q?L5qXobUTHOfKOTxpMvFWFj6xSYYiH+1aQDgKyJEBbA0s2btu1S8+cs5mfU?=
 =?iso-8859-1?Q?eSEQUrmPXNsGe9WJsD94X96JICsF01ridQv62OcLvL52pQcBLE0aQD9KRf?=
 =?iso-8859-1?Q?KVorddFgSiAhpDe70vM7KcivxTzvp0SPW3S/upEIfiCwjulAG3v+4wEM2Z?=
 =?iso-8859-1?Q?+pWNZU8lPBRSuaVt7C/dbcvbz+q4LH0Bl81M6dzpQwbBCp9ESiygXZOxYJ?=
 =?iso-8859-1?Q?gjI044eyyFKLX2FqN+AR9W4oBltFtQMXwash4RLou7DPmLQCToIk+2wzmb?=
 =?iso-8859-1?Q?oFLV+7U4IZ+DRdyB3vydqLMuXnjC5Ba6TDO3Mta9eYkQqusO/sqLkIo0p0?=
 =?iso-8859-1?Q?yFkMcdhMC1aw5ov6FlOFpKJF7AIpH1+D66ViukosoxEJD0cUJ/2ZOkKMaL?=
 =?iso-8859-1?Q?pwUl26xKwIRPaqEc1b2AXDXwLWnB8D1EFiO97lUHDdN2aMDzecn5vRPYck?=
 =?iso-8859-1?Q?rfMCqsBnuf5DiX8kQ6mVM+BE4VEvgnKDEQOXTw660WD+s9XTsja7lr1czm?=
 =?iso-8859-1?Q?1XzBSg7zzIgaawsQ4d1mgdZnIuFm9zK5SyZISWroN17tyH7gq8PO9RemoK?=
 =?iso-8859-1?Q?EW6SHrUPf1yRBmai8Rdz8SLiw18gOKTXV6dRQMOIsRFuh0A7g3VoxJd3AT?=
 =?iso-8859-1?Q?an1+YfYfuXODUdnSRxq0ARQKyeEsdvFtHnZXVvxd2UYk7R7wd0C5n4i7GN?=
 =?iso-8859-1?Q?MCdxdaYO4cbSEGLMu66wg8FPHPVcEQp8uSJ0IXPp43YJoQH4KmvvGqTDmt?=
 =?iso-8859-1?Q?2W8iOCUcsepw4R3S3hKsX1kg2e5vy4ON9NrG7Pko7no4pTTt5askkWr99m?=
 =?iso-8859-1?Q?Hgntg5TtaF8H6s4KToPlQSCuTb4JIHqFienDM2r1bwKNMwOuRVjv2mqxD8?=
 =?iso-8859-1?Q?zE/wx84etzpzfbNDbqfivVq5daigZSM8oXPsnB4j7HlI5OC4BjPgGRmihH?=
 =?iso-8859-1?Q?H9QXIgQenN/3GXxYwM8PaWxoWDov4WEJxv6wMYsWz2teAgkcc9wZGsH5vB?=
 =?iso-8859-1?Q?zPVId2oIrPsnBjpfSBlgjjM8mAPFA8CT3G3wtMu96tl69zP+Ap24Uuykr5?=
 =?iso-8859-1?Q?leMQE93Vb4lCDP7/UEOG4nH0ShN+tKc8WMc9rhBWmoBA1RCZiK0TfpLKap?=
 =?iso-8859-1?Q?yKSoDS+lNV+5vT43lkeMR6eEcFSF3og6/4P/v/TpN90ShQuXt5UhNsfBck?=
 =?iso-8859-1?Q?HqCOnkxjnNdQUjINceGoLpVG9Nk3Di7tkS8kyrlobfNTCXiI+xI60GUVNS?=
 =?iso-8859-1?Q?LV8HHoOEJipWnyOFRIGb0PmknTWtp1WZl76TYicKDu9mY74si0mcFFSUr6?=
 =?iso-8859-1?Q?cO6n9820K4Eso=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2236a38f-86f8-48b7-0f86-08dbc66aface
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 12:51:37.9247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQV1B+HE5xS9q6Vp5YWNlN8JJupAUBzTAIxqWlLLnB2IudjaI51g0Fc0+biGoj4+FiIsVdiFAubc0ihkyQgAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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

I'm lost are we talking about the pmlog?  umr currently just uses the pmfw_=
version as a key to find the correct decoding table.

Is that value not specific to a given table version?

Tom

________________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, October 6, 2023 08:36
To: Wang, Yang(Kevin); amd-gfx@lists.freedesktop.org; Deucher, Alexander; S=
tDenis, Tom
Cc: Zhang, Hawking
Subject: RE: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition

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



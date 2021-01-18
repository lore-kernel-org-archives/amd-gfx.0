Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD09C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 08:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EF022525
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 08:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EF022525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A215489DE1;
	Mon, 18 Jan 2021 08:17:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AAA289DE1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 08:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2HDWHC8CG2hWL13GTHYRJDATWrRHigxNPj91gx6+Us+aDZLpQY3DRTdNjbtd1DYyZPHhl9iHn4OZ+uphCgsq3uB0Xsd87sMDfJROeGlXFUcBgQsrB5oXVoh6Q3mcCQSDg1Oz+Oqv6OlR34i8+iWoVORNPq03ffa0OFoDH4PPYR1+TCAK1wKTiPwvj7KaVlfDoJ3ZQs3z0sOGZxEQe7hkEa3HiNm9bZAfFbLukbnqbMyXXxq5/fN2ZrbTL1WeRveNq8rxLKvi0gsOQQ6mI8SXdUg3WvJdCV56UKjX4jD3N5Hnd/E269C3NuOU3rJ/vr6oo6ntPHhZp9WaEYTgHwgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PT+JjLd2jFcao4/QMIIk3Lo4I8QrS97533Yl+zmkT0=;
 b=NBhGF4fPaGfLoLHqrCwdcMNnc/Ed2U1E8IJ659dDBEvGuDZ/PTZ4oXe8OfTck5CtJElDWXtWxJuDrUPIwUFHEEolfDrpZUrfC0tnEkQnXgwnTVDifbhlOUzB2itQmhwVlffhFCJSRsEc35bezXyJ9RQln+jc0eg6xz81E9FkyMQHIHLO8W/E3hbr/w03E2Xzc8yELbxZ3picSganM268MWXhrqnaX0Xlp8uM2o2UvJ2VxJy3iTXB41XHLSuJgXdLJkkVp6LHCPmqeKxNr+HQAI8vjOPu5z5fO2pnHax0GnWvlcZQcex2Fnh1871p09mZohsClgH5DEQ/1R1MOR2+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PT+JjLd2jFcao4/QMIIk3Lo4I8QrS97533Yl+zmkT0=;
 b=CMOhUFg3DG13g9knJGfK7/Ol/H3JUgYTPrdWIXt69k9pI+04M8NZsDIMFt83xzydBUzXO7YKejrvrIW1lO3moZFJxY6GkHfGnkOFTWNmkZzpqeuGxzLKWtRaGEX1/gAzgbs5FntmXAzXitlitNfVviZOOeO5yOb2sDG1NUfcdMM=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB3796.namprd12.prod.outlook.com (2603:10b6:a03:1ae::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Mon, 18 Jan
 2021 08:17:02 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c%8]) with mapi id 15.20.3763.011; Mon, 18 Jan 2021
 08:17:01 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving(V2)
Thread-Topic: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving(V2)
Thread-Index: AQHW7Tz6lVz5DIql+E24tZbiOvZE3qosyw6AgAAaiYCAACOXQA==
Date: Mon, 18 Jan 2021 08:17:01 +0000
Message-ID: <BY5PR12MB48856FC1B600BA177F038F4EEAA40@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210118015452.418724-1-evan.quan@amd.com>
 <MN2PR12MB45490B1639A0735C9694257A97A40@MN2PR12MB4549.namprd12.prod.outlook.com>
 <DM6PR12MB26191181233FEBD385CB3DCBE4A40@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26191181233FEBD385CB3DCBE4A40@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-18T04:31:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=75c1b52c-cac7-4e7d-95db-d4ad8c28562b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cea61323-5d34-4319-14a8-08d8bb896ef3
x-ms-traffictypediagnostic: BY5PR12MB3796:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB379632E44574E4CF5E93AA21EAA40@BY5PR12MB3796.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWILvassbvgpUvuO6+gJYcyWZmwdjGm8Do9SAGqyXinJt8ud3zTCWsx29owkiPcHcX7nkoU+u8ypn+65MOCWPnrXNs6pz844b1/onh9++bvHydJDXQGsjFRi2hVUeZ0YrelwoUdZ6vMjMVVtXbhP8oIs2KsG2eFNDmO7+aI3JMszn1eTtH9bPfH64+f2rNYIRLoldYuzn+eHP2j1PdtTbuUSRBXSjAu12gGK32cVYoXlGHfBt7yqNS+M7OL6dSUeCDK7h0mRLeZHu40YIw2AVGMNdUz9i3oXoUZvhVIRn0/a15JIdG8MBt8jx5+Yzd6PcBakQCLAoRxPk1RHA9w0uzTthw+34uZRuEEoxeQiUSSNIZJEvtRSNjIq9ANDsFvEeU8n0xFL+Ry+gqlM2Xrq9Bgq1mJkM4rylwToMI3yg0HyOt+iVWxVa2hwjS9sS/nd362LURvrwgQKKISq+5Bjv4cJiYz6MPTKQRVIeMLK3vkTdxZ9hf6iaaMyGKabOOLU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(83380400001)(316002)(186003)(8936002)(55016002)(966005)(33656002)(26005)(7696005)(9686003)(5660300002)(52536014)(2906002)(66476007)(478600001)(66556008)(54906003)(66946007)(6506007)(86362001)(76116006)(71200400001)(53546011)(8676002)(66446008)(110136005)(64756008)(45080400002)(4326008)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6p2joVx9xzuDSq2ASV2okrIgSWWOYljk8pAi2wXUPirojwBF1x9KXCtW1Ab+?=
 =?us-ascii?Q?fTDSiwzG+yqwr2mXXI3O65RyiFgAucQRrCVW7xII1ZxXFfr7waH1emh4hSrz?=
 =?us-ascii?Q?eB+Ph+mOYa1eubuExk7CwX2Du25fHTtU6poYzAIReCwx0hTxy4RdPIWC7byI?=
 =?us-ascii?Q?oZ4bdp9z3PgufsEj6sCojfnxJThdN4FC5ATbaBU3sJ7DYlsL9FdMxZHMh9pd?=
 =?us-ascii?Q?/BKzcnMKzJdcDppyTjfWmOuDDe9qrxnLTZaxYf4SGU1divqnBebC6AwBUmbl?=
 =?us-ascii?Q?0NugUMdEvAPuU74KIUuhdVQWKZaAizGVWuGM5jmmItvC+JUJULLFMGO6/Ozx?=
 =?us-ascii?Q?ExPtVs+J7CG671EyD+uhMNsFIwptFacXBo70HMShAHOy5CV6fO/fcJ/YYoGM?=
 =?us-ascii?Q?8e25lm8xrbUu+YUXgXMg/kX/+o9zRePJrIxMR9pIWIVvXbzNkQePGkDNyzIK?=
 =?us-ascii?Q?M6qBH3twDr0TFKCLpkmlWJ3xiKIVH0nz/qRS256sPC4M2PGyMwG3Vw5iSwuE?=
 =?us-ascii?Q?o9xEn8sNzbAEJA+chJ6Wg1f8Pv8e6a6PiZgHTR1o4co7aoC4XWCy++g2D2zJ?=
 =?us-ascii?Q?sNZd+cHBAicrqNCG1U0BdX/x3YEKtZ5b+aB1HksVWp56RDO5aidlsddLP5cU?=
 =?us-ascii?Q?Uew2Oz0h0lLtEj07+pWBlyKCXFRdq4t1Rt+kNZMyFJ+Li7D/2lqBf6bOD55j?=
 =?us-ascii?Q?uY4Pee0Z18QVT7RuBEwKLibOPetZK9KIemahcn14lIWfli1x1Zfm7NpETPvE?=
 =?us-ascii?Q?OXzW5k6stCGhYVjCycKaXG8x20JOV8S77aqWI/pJ1ccpvENh2QSSCAc2FOw4?=
 =?us-ascii?Q?wRaFcw6sCzzIkakDB+3NN2IkKWeS2nDJfVxvACfUGnV23HiTbcSvCUTiPUoh?=
 =?us-ascii?Q?awfZ9Els3l3fkqAWWbjmpi/mfbDX/lj8UVxlf0v9JEnxgWzzzKNNDtgECSqK?=
 =?us-ascii?Q?3VutlqOFWbiBkt+IJuYgYVvNEK98vuHIKuG4X6hPADc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea61323-5d34-4319-14a8-08d8bb896ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 08:17:01.7610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6steuL6nLqMwySUgX4/vp68sxf557hFDjvcl4yDeN003tOJz0OVckT4r+q1esu0LmDDJz4x8mT1S0JP67b8Mmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3796
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If it's just for dev usage, why don't use UMR tool instead?
~/tools$ sudo ./umr -r *.mp*.mmMP1_SMN_EXT_SCRATCH0
0x00000040

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Quan, Evan
Sent: Monday, January 18, 2021 2:06 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state retrieving(V2)

Considering the gfxoff status is always in dynamic switch, it's absolutely right we will never have a reliable way to know the exact current gfxoff status.
The status we can see is always the one of last moment.
However, the case we want to cover(also the one we see mostly) is we know the asic/gfx is totally idle and we want to know whether the gfxoff kicks in as expected.
Under this scenario, this approach(gfxoff state reporting) will be greatly helpful and reliable(asic unlikely transit out of gfxoff state without stress in short period).
I believe that must be the reason why APU team decide to introduce this routine. And we dgpu team should follow up.

BR
Evan
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Monday, January 18, 2021 12:31 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state retrieving(V2)

[AMD Public Use]

This is not guaranteed to work reliably. By the time driver fetches and reports say status 0 (in GFXOFF), there could be a doorbell interrupt which changes the status to 1 (Transition out of GFX State).

If there is no requirement to report the instantaneous status, better to avoid it.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Monday, January 18, 2021 7:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state retrieving(V2)

Support Navi1x gfxoff state retrieving.

V2: some cosmetic fixes

Change-Id: I57aa506b82dc122bbead708c580a4720e536cfce
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 22 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 102a0cf12d7a..4d346f289ed8 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -287,5 +287,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 void smu_v11_0_interrupt_work(struct smu_context *smu);
 
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..93a3b6b60c8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2482,6 +2482,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..730a4880af08 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2127,3 +2127,25 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 	return ret;
 }
+
+/**
+ * smu_v11_0_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: smu_context pointer
+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu) {
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t reg;
+
+	reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
+
+	return reg & 0x3;
+}
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7Ca04f0d6191004233156108d8bb772e28%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637465467847289460%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=z60%2FfkH2d9QOAuoipQ0Py%2B0JW0DX70R37L0VFPLAmjA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7Ca04f0d6191004233156108d8bb772e28%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637465467847289460%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=z60%2FfkH2d9QOAuoipQ0Py%2B0JW0DX70R37L0VFPLAmjA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

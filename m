Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0346C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 06:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A676C22512
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 06:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A676C22512
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298A089F53;
	Mon, 18 Jan 2021 06:06:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A0689F41
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 06:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp7Q7O68mwc1khIIhHgSEFoil7rccLZtHrric49g96hZQ0F4WMADBg/ef70ykDsvvlU1Rj1Bo5gmoE2/Fey1KtvL/W8Cma+d5zygiY1m/K5GfXzCLKiA3puPoj5jgxUgr+CCJmErhXeHk6SvDi15DVgkgGq9PMGSLDsnu2QZ6QDJR1fzu92ns2enhxyYLyjSyqoJKkmDr7WeRfajoTfCfaJb8eZIekvT379nH1kRNUNy56XZdBXxnW/h0wUnXCeFUiaGJ7+GsJmyfLAPx6L3Lvx8dF3eNC05MdVMusQyamnhJhdObeY/kr+QxgYNBA00ie03DAHbwXiO3u6HgXYYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/8Txe72j8dkb6p2UzgSYKZttoL2ZTj49IzigtHKa8U=;
 b=gRj018bkgvsJtcsQkgKNWbr1/224PO2FIHxsCevk6uDVg4Y6RhhI6MN2Rrun0pwDKDgtv299Ae3wVL7Uc2IkowClQAIzvCYMCSJseAii1C3stjLWkMCANEofYuihhd/yKas/pth4wFK8bPR4i3uhB3tr7+TxZd4vLLxmwymOV/JyrltoHuUppdP0ENKyPnJC1O0WWTAmj9hd8OEHRSEGXNL+cyYF0SvGPoY53U7yqPW4XDuUZLoK5rqhewVlpgYxXaizTKSfBzhWvvpE0hELCMeoSziHovb5KltXw6vyoIfchq4wOzPLHLRmPiAjYYmaw+vjr02IQQ8lR7dWj3Qr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/8Txe72j8dkb6p2UzgSYKZttoL2ZTj49IzigtHKa8U=;
 b=G+VuqOyjk+Mz1w3THpIB0w56xc6MXkK9lsRbBR+JG3L1cfQDaB4VTQJ4M10juRXiGwr+W9meu8w+cWaCUqTPFIWCemVXZV/xNno4knNyZ5Etp/vYBl4STLNuGRD2DLRfmQVyFzES5dxMM4xK14NeGuRxg6gjLvB6MXLjc+5odEE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.12; Mon, 18 Jan 2021 06:06:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 06:06:17 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving(V2)
Thread-Topic: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving(V2)
Thread-Index: AQHW7Tz1mGfSZ55b00Ke/TUMv+1awKosyw6AgAAUt4A=
Date: Mon, 18 Jan 2021 06:06:17 +0000
Message-ID: <DM6PR12MB26191181233FEBD385CB3DCBE4A40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210118015452.418724-1-evan.quan@amd.com>
 <MN2PR12MB45490B1639A0735C9694257A97A40@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45490B1639A0735C9694257A97A40@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
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
x-ms-office365-filtering-correlation-id: e7fcb17b-e220-41b4-994d-08d8bb772b98
x-ms-traffictypediagnostic: DM6PR12MB3083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3083805EF33A3DEB95711C0CE4A40@DM6PR12MB3083.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfrZqEBvdBaZ71wTTGxWuXvAbh/74JcylzlwSOPe6A8ffg5gkQIUawEMI+igNkkFAsS+N7jmNVwG7EduOZysTA/a4vxrbDpC+uBEhf5waicXateWEKuzu0+f6jYLvSneaTBDMAIC0fitfZ/gGbnBaChhsRTYurE/6SL/lNOizY/DRA6Sos0T9ssB8nx/mXKxvdTHbrcB0Nw7bSKSVokxjE9Sps5mIUUjfMbFq2/44u0srNbPkMrB8+aUIjriadW8/b1r96rKC6DJYXdfRhkVRK3aUeTKeC+7wgG2RlG3TRv9WuZAlAOY2xwRXPipihBeTjimWONcRsDByTo+U2KiehUjdWt+mDBQflLRP/1wq0tuil5f+NgBtBWh0zc9EVHbLAf4ozMqPcg63sqNl7Uh6y/XFJJU97jYuasAZQo3jQ9tWC7GUAmm6Lp0vith4zXZ1e1cSsSKIxWNRS33x78TBcq12oI18K5lBpweDkup+qhqJZuc0d4CLcKp4YKbcqIf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(53546011)(9686003)(186003)(2906002)(86362001)(6506007)(5660300002)(71200400001)(66476007)(8676002)(55016002)(478600001)(54906003)(7696005)(110136005)(76116006)(316002)(45080400002)(52536014)(66946007)(4326008)(26005)(64756008)(33656002)(8936002)(83380400001)(66556008)(966005)(66446008)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2wJZ6kbD51kpFWkINZmHpJQV4NqF/Vm3f2ruPysm7vk48KLIAWma/eXpuwud?=
 =?us-ascii?Q?DLxTrpn1ir4Kf/bDoMytfx1ZgACYq9v83xEmTOE5b/s/00X+lncCOfWvqiFb?=
 =?us-ascii?Q?jzP3Zbst90xsmZwDXNHcvHcAjWGx41lA2qoOWVNMxZcLuujxSMEqC1bvFkMB?=
 =?us-ascii?Q?SXaOCyDUOVWlRfOHBQakiUrYhYvnqnIPwVYNfn5XaqbDh41ryfdGxXJMIH6+?=
 =?us-ascii?Q?0SnfFps9oX8Sg4v+g73wfVz67Ssh6jasLYAokqi9E8AoxciXpHx0xKVbrfXE?=
 =?us-ascii?Q?AYSU6K8w8AmbPJb29bfHFHK9MUUdp3HwX6c5uJBBIQvYPR/MvPDGYz2Bq6zR?=
 =?us-ascii?Q?1eqS3SQtSmIhKfhKIASjFUhvwQmcaAztdgScpPFpaGnC+/Eacj/9DJcF9aJi?=
 =?us-ascii?Q?TxbrFWb5KF9gtU9YJtvbpGP6PJ4Dkf08IZJJP2QyC2xzhgHHVkdov6wP6Drt?=
 =?us-ascii?Q?wNssfF++mJRsYGULhEnjlZV/Xi4PsqIByithykOj6Fy3M0iR0U09BzSVdji4?=
 =?us-ascii?Q?JcqQf5zfRjpfJC1uWLRHslPXfC/rwO0sw+aqv1M0CC+21fNFZtDatbhjnhfI?=
 =?us-ascii?Q?OhJiogkIS4TCzC7UHdIlpZ2+QEy5jycTofYa22PR3gwoEK1VZIFirYnAqcrX?=
 =?us-ascii?Q?QqW2JL8LovEsNVyLngPPEvJa8BNYlThPuVw9JBp16CYYRzR/7NjmcBSkX5lB?=
 =?us-ascii?Q?WqVadlsbz0W3UHID8QID2aRffw3SZPVkpBbCUX6yBPWjF+pkhoedQCWE7Go3?=
 =?us-ascii?Q?3HWJQprxNqzcNeB2RmoNn9ebv0KvdwPqMEvWLgvJhgE+cafuLEliHp0cViQ8?=
 =?us-ascii?Q?gALLBT2k5qOPL7XLwaQJoJ0DBb9FwRgEGmgoxL3WbJ2tQl5mNB4qiwUsrZNs?=
 =?us-ascii?Q?DQI0wclqrhM06iTsCMknF+mgi/pPL9RpEF5tNqi6Nm+CpyQuygz8ALGSfh+w?=
 =?us-ascii?Q?Q0YLb7DmbMsYCYOzOI7WME3hrRh2bplnRa/lWM/I5mI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fcb17b-e220-41b4-994d-08d8bb772b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 06:06:17.8589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCagy7GDK5dfXr9htFbq3ekp+xWe/ffGhxjFjfKI9Lomc4ONuykZJ6SJ3L/aBXRl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cc151c052c37046e6745308d8bb541c99%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637465317233388908%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=AEi%2BA21xfZI5Wv2SjPCatiShlKGVa5ZHOtGR%2BIBjXfE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

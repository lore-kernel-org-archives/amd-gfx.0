Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB2DC2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 12:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E0B208C7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 12:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3T9/xR0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E0B208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C3E6ECE7;
	Wed,  4 Nov 2020 12:17:49 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1EE56ECE7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 12:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMaUauFos4Lo+xRAJnscaGw2ESBNBFUszMIjk8gDveKVtRPGAwNrdXe7rYjFg2oTkAjPqwEzCjVF9LAF+WefbU/3eN4/D0lRY2sftG+UwrwHWUHRjiRULfp0cCPAuaaKDwSIvnE2rVMc8pzqzm+7jmaesHg44OtFXq9K5Tg8kwmFlw7zr/JyCLE1LXMNl2cJ34BbILWT16t0IvQj6qaqIRUygP3r3nuRo8noYMQXU4Tie1wcWlyJuf1Na+7VHyEpzEz3nFGhOCoPrxN2SF+Fv8rJWLa9i96mjyT4VDaAjlTGYbf1cvhn0VMd7LcyJaerDEoJIaDixTdIoESvpdZCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOPapvattSmkKyA4sYwVc4xu5OxAdg6LJRWVVMNrRwc=;
 b=MNToE4crSEeakV240pmQVG6HNaICO2x/KYUvwIV53I31xGUEyiyDJR9abeOwcjPY9cMvrNVw6mt7/qRNlv4PqR0XYQMlP00Tmyi6ckhQDiHnKvl02oqw9QM82p4ppVUBdUnY4SY1YKKtwXeq7PkE+lDoj3dW2/KQ0COGAsMa/vJdk3M+x67JaQOTVTYOkqOgTm2awOd/rkxnQjcTW3ZWHMFdIUCO6EWdLmfAyM/4+RmkOpFPQqQN4AFEhcQwb7ALXkItDi8+K4HGilttavQ/ZNUIZoBtmHVJsY1JTj3jwkzyBJp0cZsASN3VcdVoHeAUHd3Yv+LfxHajzYRcOtoiiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOPapvattSmkKyA4sYwVc4xu5OxAdg6LJRWVVMNrRwc=;
 b=3T9/xR0hj+k30FcNTFlDcZo7DbCiMdQoJSHWSSyabaMw1x2z7Ek9sic5hmlGKM8YmHptlcJSePBz4mLq9MvNYf8k0gAYq8FDuQpRl/N/nI6INfSJTr+pBjMEw+OI2NAzHXhPlYQtJ+wwbT7ADoBV+GWU+8HAzKWsxbxle9aGq/0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.24; Wed, 4 Nov 2020 12:17:41 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 12:17:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add missing clock gating info in
 amdgpu_pm_info
Thread-Topic: [PATCH] drm/amdgpu: add missing clock gating info in
 amdgpu_pm_info
Thread-Index: AQHWsn0gqICNerbfrU+G07J38FjG7am323EA
Date: Wed, 4 Nov 2020 12:17:40 +0000
Message-ID: <DM6PR12MB4075149010CBB182853D6FADFCEF0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201104073533.26365-1-kevin1.wang@amd.com>
In-Reply-To: <20201104073533.26365-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-04T12:17:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c901be86-45e6-4497-a491-00001902fdfb;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-04T12:17:30Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d8a17185-9822-48f9-b15a-0000a17da11a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-04T12:17:38Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 59f05afb-c29e-4753-9391-0000033f7fe9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3a1915e-8a72-4c75-0fbe-08d880bba054
x-ms-traffictypediagnostic: DM6PR12MB4958:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4958785DA0BC83F488023494FCEF0@DM6PR12MB4958.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSBEWxwWpkf4INLQzunWVhb5vKgRAVNNqS7xFhrUzy+QGfgCP7AUjzbrhsv+vbH0yxoaT3rnA5HtOhUJ3FshKQjlJepCKIWy7rN9uVZyvoUELc1BaMAzkSCgV2vLCq6m8zmMp6CfslzEtU0alyq5SLBSsrSLr647Vz+8dWsCGIRp1DdczJ27UjOmDqnsGos9a+b0dNBEmsDih1QCAXmwPBpqP/+vPzOid/V1lPnXKqDffl6cwKliOlZCo43loF6Rqd7q6vaDjPAb4hBv6kwmfN+pfOe0nH4j5PH/nH7cVEg/D4rXfezeXlPQ1W+F9XW29nymwpFtdwTkFgp64ZfX4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(86362001)(83380400001)(66476007)(110136005)(478600001)(71200400001)(33656002)(52536014)(316002)(5660300002)(8676002)(64756008)(76116006)(66556008)(53546011)(4326008)(66446008)(6506007)(2906002)(9686003)(26005)(7696005)(8936002)(55016002)(66946007)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: bYYkYkgnmxo6Ps0SCtimJ3xHA75N/9JWpReA1WbEKQuZWo/YA1ibb/u103Hza5eqEIo3FKFt2qpzEvO0qXbZP9W7JPBS/OhUOGGs1UjeNl6P2+ju0lQn+an7wj0a9x6cazaPcMkAWar8Vm+1Nr0I2ZSjsuSpCPby1Ay5yIn6QMOxHYrxjBejP04NiJBIS7cgx7E9YWQIKJMPg6oYs8ZuC5u5eQ3vxK5jARnYDxAfE9lQitdzm8UrxpMvBjCa9FljtbojyabygCMvF7v9O4Ov062+pKfwCaMzLPCMNFLViGg+G/D1t9vfEPTgEHpydXvdELOIZYx9APJ6hahlwMAMjmtaGfFaAZYYIz3xNDmI1i5KEYHkvTqA+WdCrZOAQRIsWpypSEI5fO6R/jO5ABeBZt0z1g4SGYxYAcHl9KvFbds0i9hfdpOFovDPQDx6QeIDHNKjr87DGnTW8QSosOGkumbPpTo7+Yx0CHr2IQCtGSQJAjCEUWmgludBkGEl0c9WsNVgJckbfHmTFEDiS60INucrKHD6MIfcfR3Okwvo+elTaIc/94Bl+ibpcMjkh5FcKGLPVOc1iGqPuMCXp7ghHm9E03OhtYrwSeYUqsDFsjfNRqpy2nrQJ/EGiDYj6XM73h0cOrIPeqXGIT9fqe/0WQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a1915e-8a72-4c75-0fbe-08d880bba054
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 12:17:40.9749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrRZLw+Fbfrgd7sDn7yPNBAaRA7z1bmh69odNBdThPx9NEKgYTx/Ack0MTTMNRJsz/rMqbXSq/Tii8+pSSrOpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Wednesday, November 4, 2020 15:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: add missing clock gating info in amdgpu_pm_info

add missing clock gating informations in amdgpu_pm_info 1. AMD_CG_SUPPORT_VCN_MGCG 2. AMD_CG_SUPPORT_HDP_DS 3. AMD_CG_SUPPORT_HDP_SD 4. AMD_CG_SUPPORT_IH_CG 5. AMD_CG_SUPPORT_JPEG_MGCG

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a33b1cc50008..7b6ef05a1d35 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -64,6 +64,11 @@ static const struct cg_flag_name clocks[] = {
 	{AMD_CG_SUPPORT_DRM_LS, "Digital Right Management Light Sleep"},
 	{AMD_CG_SUPPORT_ROM_MGCG, "Rom Medium Grain Clock Gating"},
 	{AMD_CG_SUPPORT_DF_MGCG, "Data Fabric Medium Grain Clock Gating"},
+	{AMD_CG_SUPPORT_VCN_MGCG, "VCN Medium Grain Clock Gating"},
+	{AMD_CG_SUPPORT_HDP_DS, "Host Data Path Deep Sleep"},
+	{AMD_CG_SUPPORT_HDP_SD, "Host Data Path Shutdown"},
+	{AMD_CG_SUPPORT_IH_CG, "Interrupt Handler Clock Gating"},
+	{AMD_CG_SUPPORT_JPEG_MGCG, "JPEG Medium Grain Clock Gating"},
 
 	{AMD_CG_SUPPORT_ATHUB_MGCG, "Address Translation Hub Medium Grain Clock Gating"},
 	{AMD_CG_SUPPORT_ATHUB_LS, "Address Translation Hub Light Sleep"},
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

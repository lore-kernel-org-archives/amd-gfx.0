Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B8C34022
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 03:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C079520801
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 03:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a5DtuZYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C079520801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B7C6E11C;
	Tue, 18 Feb 2020 03:01:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF04489B51
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 03:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHs+mFbeGC4U9+Qh+9xTLTreJOFMe26bkRJJdJyIOOGC2V+mCuTL5amPrbYHeKJ79g+SNtRzTxP8LUzGVtYXJXRGQeoCoc8u+8BZmDnGG8Tt3rdZUwWzh0AEAVfsylHovo0oKJovH4je7IJOttUcDpmaXxa5Eev+HdkUkarOUjbOAieh966ULJwB3O6sjEzyukksF31TaAu0yjmgKLt5f8cR6KV44h3ymE3bLORoD4yJ5zp/Kh8XviZqWpw8i/8c/yf0uiDIjCa+gYrM0tjEdcu3VKfuk4QnAQdQ7lMhkMTWYkD4+twA2U4e3q52dcuK4hP/Fj39zl12L9psVYarkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERiqksx8+DQ9QDmsNeoaNmObXKurSqEgcp6dp70cGPM=;
 b=VpdBxi0a3pkoMR0RLswjB5tArswmmgJftfqNAxG4Rbi+1EgwGbIebsONo5B1h5OwEsEG1bVzvpjZ0PR3dLPxMtPqALqPS/EV6rschi1Vc829ExqwuIkfBs/cM0hQrpM+WJq3Fmsc10Prd7F9eJJL79Uv1WZ7VA2sI2tk6pcJ2TFEpPuIBTG2DkRV569hUh5rGzOdnkOTa+sccQDL7HdpI5a8Fu10uaiDvJkD0sPUIVv6gGwl2q6/Gs+p9fe8JSmo1bTlKw7d22mhwBT989nLq1xgv199S6jX9qrMnIs++PZN60VOZDUj9RzE4g6nrhHQMQQntum9tveH1lFdI5Ethw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERiqksx8+DQ9QDmsNeoaNmObXKurSqEgcp6dp70cGPM=;
 b=a5DtuZYENhVyG4UhxMxlPuf/eTQFmBCc59BDkzFZmTQGpP15wDOLei7pkWBgC1lbSTeBzEoJpfOR9xKZdlP3VzHuyVrqpD9daYxpswz874cK/rGiBjtktjg2XFZWDotFw1wRPizllbnbVxOPHb9jN2127aUaiBzEljuBjGcJ1+I=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3005.namprd12.prod.outlook.com (20.178.241.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 03:01:23 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 03:01:22 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/smu: add an update table lock
Thread-Topic: [PATCH] drm/amdgpu/smu: add an update table lock
Thread-Index: AQHV5dqPc/7ASnyGs0u43w4hTPiJDaggQ4kA
Date: Tue, 18 Feb 2020 03:01:22 +0000
Message-ID: <MN2PR12MB33444C333C7032B4F78BD581E4110@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200217213730.1413533-1-alexander.deucher@amd.com>
In-Reply-To: <20200217213730.1413533-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e959e0f6-e6d8-4572-a649-000044fc35cb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-18T03:00:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a51976a8-cfe0-42ae-819f-08d7b41ed615
x-ms-traffictypediagnostic: MN2PR12MB3005:|MN2PR12MB3005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3005312ED914D04656B2C4E7E4110@MN2PR12MB3005.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(2906002)(4326008)(53546011)(52536014)(5660300002)(110136005)(45080400002)(33656002)(6506007)(71200400001)(966005)(478600001)(186003)(15650500001)(55016002)(26005)(76116006)(81166006)(81156014)(8676002)(9686003)(66946007)(7696005)(86362001)(316002)(66446008)(66476007)(66556008)(64756008)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3005;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u94Va7VTuMXdw/i1Rr83CjxDNebrwnOsEvjsQkapg7j6EmhxNQfg9Hp6KIHJHGA1YVC6ULaiscDyzOAhlFVDbgALNSFU6Cv2qJLebo9/T+bETQn2Xcm8iLeSpndif/W7e5ukCk8yVuQM9aHj7rHs2p+qWwSn0b7CX5Y0+RI9Cc7sCtjoAQMR5je/mOMs3zU1fi817vfYXELtwKQ8BcOZUwjw7quur/eJU2oPu2HtM9cVLAnUyFzODXWehmx/aHueW4NfQJinGPbuLmPyjoJC5EVWeCqpWFHsnNKU2cthfuibPMT6htATkh5sCHqOIhF33QyzbKrt9Xh8t490gMYxFlCqfIeAuIvztk5qHiZXacuO8FxsdBfjA1LFzoR665s0JaQdiWTr9Ono++Ivz4g2rwmcAxLGI5QCPT1uY2mBJmIOzjk3EvOvvrYeY5l3EnCJaFLXwNzdq4PbkccE4UhO78mxy2cWeZeC2dCmWf7+85UxglqxSpTJDb9E0kHASJhfyDN3j+EZMaOgmyCKQtzjOQ==
x-ms-exchange-antispam-messagedata: MXOgoHflCT9PGPkBKtxJ+p2N20POmCwPkUFCfigsutwNRiMbQjdZXO6JkaR35IwRkMrC1GSZ7qwM0C61y7xBW09w74KFnr/m0MKx7qVLlDhj5bMHUuSP+/c7V9+YdhbfpLRgV2tmXxOCmZPHRmkKJw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51976a8-cfe0-42ae-819f-08d7b41ed615
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 03:01:22.8577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wLKEspOJslE/KP/mPyjncWQ4Qc09gzOFmoVP4emdnjusNu2I3RNsmRijKkhD3Jh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3005
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

Hi Alex,

Did you seen any issue caused by this?

Regards,
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, February 18, 2020 5:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/smu: add an update table lock

The driver uses a staging buffer to update tables in the SMU.
Add a lock to make sure we don't try and do this concurrently
by accident.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 7 ++++++-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 9f2428fd98f6..437a3e7b36b4 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -530,6 +530,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 
 	table_size = smu_table->tables[table_index].size;
 
+	mutex_lock(&smu->update_table_lock);
 	if (drv2smu) {
 		memcpy(table->cpu_addr, table_data, table_size);
 		/*
@@ -544,13 +545,16 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 					  SMU_MSG_TransferTableSmu2Dram,
 					  table_id | ((argument & 0xFFFF) << 16));
 	if (ret)
-		return ret;
+		goto unlock;
 
 	if (!drv2smu) {
 		amdgpu_asic_flush_hdp(adev, NULL);
 		memcpy(table_data, table->cpu_addr, table_size);
 	}
 
+unlock:
+	mutex_unlock(&smu->update_table_lock);
+
 	return ret;
 }
 
@@ -900,6 +904,7 @@ static int smu_sw_init(void *handle)
 
 	mutex_init(&smu->sensor_lock);
 	mutex_init(&smu->metrics_lock);
+	mutex_init(&smu->update_table_lock);
 
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 97b6714e83e6..506288072e8e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -362,6 +362,7 @@ struct smu_context
 	struct mutex			mutex;
 	struct mutex			sensor_lock;
 	struct mutex			metrics_lock;
+	struct mutex			update_table_lock;
 	uint64_t pool_size;
 
 	struct smu_table_context	smu_table;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cbdb09232f91649c08af408d7b3f1ab89%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637175722941118202&amp;sdata=2%2FNzcPGthFtelyfXNiiIL3BV3c%2Bvoy%2F2Cq1oFWuZ4%2Bc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

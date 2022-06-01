Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880CCC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 00:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F263210F8D4;
	Wed,  1 Jun 2022 00:49:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2D210F603
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 00:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwuuNu75aDWZaB0W5gLhTXFJSNaf7SWyLW1+ntqtgZnB6u7LuQhXZsUH4IgSLUSgUAtUVq1Xq3xXqYP+nnDcjmmNIXaKR5lCi5llTVQgKUdU7ZUTFO4rsYOuNpi9lK4rc9nh8TqB8Fmo1HfDg9x8GCkhL1dGQc7PwETRcJCz6iwsQZcct/IQYC21lOn00sezC8msyaifDNnQjSeFv9cGhZlapXU9SOEbYGyOInAI854U8UnbYf69jedp82JY0ud6POICS9qdg+okiT/xX30Jj9fCJzU4vTtOgrl842du0gChMUqIUfahKcSByGwJpLRSbleNAKQflREWcGPCbrI7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGDLRWbi8jOESlgFaiD6XAsELfh8N6dI2pwFomzPHjk=;
 b=CrizVqSHqH8S0DHrT5bU1uI3qBAv+6kxo0o3CsZPa/CBRRufiDa0DFg80FRUVPj8935c/OiwmAXfeOp80b7a+rBlnDsKwvZP0+PZLXh2FA6hQN8VQYp93FTkyZIRgw8oIvVwxp3GBmsYOfb8t/0DQBUaZxfOg+4HjaOGp90k2MG6dt+tzbNNoF7G3BKhT+DeYodch9lwKiseJjZe/digUTTA2Zw8J6348U5BdQho4U5IQztETpc+mP6QkwrTCOBAxbKGU7ersdFhGey2BsQAgTz5Oc11D51eyiDPCgud0O6yTBjABYHFcYIm3oCkrUmukf7xjnBkizaPRwkR0kcdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGDLRWbi8jOESlgFaiD6XAsELfh8N6dI2pwFomzPHjk=;
 b=GcOUQzTX89AxrFFl3cd0w8vN3CypPLpOTuqSuAZ989/CPSsNhA3lre2Do+tMAdht3ZhQ+KS0ZTLvyEpS6RUr8jXYg30bRzhQpHCW/jztOOt4fGJV+l+4k9zCBWQmA9Dcjct8n4gx+LVAEYpK+xfgW6kgPeNV4MHz5JNG5L7/Vl0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 00:49:04 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::5108:cd17:1f53:8f88]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::5108:cd17:1f53:8f88%6]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 00:49:04 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdgpu/swsmu: add SMU mailbox registers in SMU
 context
Thread-Topic: [PATCH 2/3] drm/amdgpu/swsmu: add SMU mailbox registers in SMU
 context
Thread-Index: AQHYcSqKhu87D1WDHEWkJKwVmpJLsa05wBfo
Date: Wed, 1 Jun 2022 00:49:03 +0000
Message-ID: <PH7PR12MB59970C2F41A4B8FA2C358A5482DF9@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20220526180027.3044740-1-alexander.deucher@amd.com>
 <20220526180027.3044740-2-alexander.deucher@amd.com>
In-Reply-To: <20220526180027.3044740-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-01T00:49:04.518Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68bdddc3-4cfb-405f-4fd0-08da4368869a
x-ms-traffictypediagnostic: MN2PR12MB4390:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4390F5656421BA1BCF6380CF82DF9@MN2PR12MB4390.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKGxpiClcReiPpZ2zrr2MJSzLerL9oz6kguxkHF6bqQU4fm8Dbr+2RqVZue9cDgJpoeP+b0NtEyHKdZMUlDVfDFhfzuoEIqezO8UzZvk5ABvm5YIckT5w3sGj9gYNbyL63q+G25SORsWcxqEUFtRWI1BhhPsiq7vbzGrfO8u90Mqo+xCXMRismNlRNoa1MP8dxyyHN+F+VXME5hdadCQXD5JmoNYm+dKYuApkqIWxddkSbsTFY3Ht/OjVpIGKXLq/K37gxUQfIiep5e3aHJgvNCYw+Umt5jDHGL+veARzXTKD04n5phW5syxMvDM+I0FxuqweZYu5cQWPdiVIcTwxnPw/qa3sXlddom1hPhs977GZts+94YrwIknxI1Gxo4MJ2WMiEEVzNOh5vLmZIeTFC4XAaDjAGEOtk4b+7/TmrD+8uPrqaJ1DU7H63UXmWgc3OOUhVP8XuqbBX19Q+hEtY2h3cgzSpEYFQS/xNt9eA1kX34hXhDzIB522wyrxshshP54YNfsNSj7pjRCk59hbcfAYLyIYiEWve0I+znTM0ijV4I6jOQ3EHHNI25gy1NM0t123kVXAOYXVA8HYPFYpUfgknAipc/aDJgDJ+yHCZ3zdeprmW8UbNH80YpUYud4/4QcMjGPwFPOw2rYOQvwe/7/m5wGXrUV5f/EKPcZUUXcd9K3KDTh8i54xaDzZxpc9L6+rh1LU2HYv5cj/41f5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(19627405001)(7696005)(122000001)(52536014)(55016003)(2906002)(15650500001)(38100700002)(508600001)(86362001)(8936002)(71200400001)(8676002)(316002)(66446008)(64756008)(186003)(66556008)(66476007)(30864003)(76116006)(91956017)(9686003)(26005)(33656002)(6506007)(110136005)(38070700005)(53546011)(5660300002)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I95jbk3ZH3mbgCjXbvszyHcrFLxeiRw6DiTNIyFacGi9bB2k8FjwY5imaV?=
 =?iso-8859-1?Q?qZwGyq/BKp827vzz5xQgD9jui/o6qDW9o2MLpdJbu/VkQAAU3+21fqXbfZ?=
 =?iso-8859-1?Q?zqpI1upHPudOo0Dr0vy09RuEhLZ47P6ckZ0C1/g8fkJT0VzIOh+LWDUpZq?=
 =?iso-8859-1?Q?DO1/i034ofZB5h9tC/E9dAKP4QQIgDbkzxBGLhxk5tbTeB7cboT96rWtqb?=
 =?iso-8859-1?Q?2aNLDlQ7NCR2dPZmf19Ga3lwO9TaXr739sO87lr+52WxZ0Wn1mUUZ/XFeV?=
 =?iso-8859-1?Q?Bd6kkNHXmlSLH/Wlpx06Sw0gmzJTNgvhBcdzhLjhm341e4NFRKxe1YuxyV?=
 =?iso-8859-1?Q?V0AEOYWpEailg4YE1M4y1J4srMNY9ec99qAQ6G7cBReYJYmeCyPNx4rEq9?=
 =?iso-8859-1?Q?L6IMnENkmy4Rg1GpxI/lsuatU2aO4NhboQrlj/rcRJizMJ7atq3R2raxdo?=
 =?iso-8859-1?Q?8n37oCYkD4ZPQnwK42tF09C3j6FOpoqq16qmimw0r8mxwtW29qAGSUzYoE?=
 =?iso-8859-1?Q?EoK7reMEBvX88hOvWdUHrgPXBa4DU/KPO84EJsZfpTMEJUNJ7aORagrlAr?=
 =?iso-8859-1?Q?x13QJjf8GB3ba+epWy60RE3/CMo/rt9Uihunqr36zcnamme82Uo2X3AUYV?=
 =?iso-8859-1?Q?VHRr+DZ6LfY/PB6dUGDipU3pAppOAZpTJIGUxKEhUCbuviCRVkqYewgLzX?=
 =?iso-8859-1?Q?dajeXVnz8+jGX5H1s4ac2nUtfuNJoikF6HrHHz9b+RCmofPkB1j7Bq0Ccc?=
 =?iso-8859-1?Q?sFTBlNSCRDlneBK3OBuDcdc99EAnQYUpreWw/JTKphUAurVfPQflCJ36Sa?=
 =?iso-8859-1?Q?8xopzgRNpir35TH5/kXr26KXdYKeP1XtO4wklqLGu03Z67ok8apX/zDrq2?=
 =?iso-8859-1?Q?3cBCwqtSh4yIc2wSoG5IMzcZypAEuJhXaFZRMAuvkMZhG15KrxeWt9felK?=
 =?iso-8859-1?Q?GvT/9wky9LX1ZPwSd8Hz1kOTdX6pUI/MF3QCxtxn9+9v4axTjXmzgBHXqe?=
 =?iso-8859-1?Q?4hAkPtrPSnvUMlEAR88QoUNSbwyM1kyYPZxML957u7p++5fFT2iD1EH4vR?=
 =?iso-8859-1?Q?zanM5myUbucn2TDzqIGzit+PInivdBYOxDmv73sBbBHS0uCEUPyoffg8/j?=
 =?iso-8859-1?Q?SkcRt8I73hxk1tdM2ivz19+XQ0Q/AC2Sq8Wdj7gnWkOW2HSZn/ITSAJaHR?=
 =?iso-8859-1?Q?45PQP7DrMqPu9BazZu+ENYI0O4RIcgKf/MlReWYBQ5fBPSqTWpPsegZSQy?=
 =?iso-8859-1?Q?E6TyDSsvYlO49l1cyVv15HWZBTD/AJUpR4ZwU0EU6qsD+qqzwueUvQWNw9?=
 =?iso-8859-1?Q?jCm25/yNVp5y2r0GE+y+b2gJ/ex4CIFWVkQES2wr11JZj2gr/YQGwAAGet?=
 =?iso-8859-1?Q?mmyGqqAvYDSkK6PdAgp4bYwdzBqR8UXHw6f6rmsfdrMZx48IenuH2GEtfX?=
 =?iso-8859-1?Q?yf6yar1pw/F2oCZHn1ubUcRS0houKP+i5VyPSgMARH4j0eSv+ZZ4jGCZLx?=
 =?iso-8859-1?Q?7gjPVdEflVS+fFgBNkc1HXXOgAHKNkdWZ+UZDB+9XEpOW9M0E8caoDHIaq?=
 =?iso-8859-1?Q?oWeNUEM56bZXXGGFIJQ3moeJBu5C5XvseVuu2eaYcScFtB+k1csCFi2ULP?=
 =?iso-8859-1?Q?1dk1S6wjNyamYElY8LaCUDWqh+DJm40aHjQnHDcoV1ad9qjHKtK/vtmly1?=
 =?iso-8859-1?Q?j1+7G1QqFI/Z7sE6l10q8WkPcjx5+D5Y153kYjnTwOVdGPG9sVsciN97vi?=
 =?iso-8859-1?Q?xWrUosCRgdjH9GLLIPFfrUOGgHaiGZLHwpWmRJEj5PAtIt?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59970C2F41A4B8FA2C358A5482DF9PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bdddc3-4cfb-405f-4fd0-08da4368869a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 00:49:03.9797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cospD1zb/c3TTxeAnJD1fO/6YW/CXxJ6GasLEI4IJ4MqQ+rl9VLZSHbFyYkaWNQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

--_000_PH7PR12MB59970C2F41A4B8FA2C358A5482DF9PH7PR12MB5997namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Friday, May 27, 2022 2:00 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/swsmu: add SMU mailbox registers in SMU con=
text

So we can eventaully use them in the common smu code for
accessing the SMU mailboxes without needing a lot of
per asic logic in the common code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  4 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h   |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  1 +
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  1 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  9 +++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    | 14 ++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 18 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   | 14 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   | 14 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  1 +
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |  1 +
 17 files changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index a6a7b6c33683..36af1f417dcd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -563,6 +563,10 @@ struct smu_context
         struct stb_context stb_context;

         struct firmware pptable_firmware;
+
+       u32 param_reg;
+       u32 msg_reg;
+       u32 resp_reg;
 };

 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v11_0.h
index acb3be292096..a9215494dcdd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -316,5 +316,7 @@ int smu_v11_0_handle_passthrough_sbr(struct smu_context=
 *smu, bool enable);

 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);

+void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index 036fd2810ecc..f60dcc4f7e75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -298,5 +298,7 @@ int smu_v13_0_od_edit_dpm_table(struct smu_context *smu=
,
                                 uint32_t size);

 int smu_v13_0_set_default_dpm_tables(struct smu_context *smu);
+
+void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 201563072189..bfabcd3c45aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2509,4 +2509,5 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)
         smu->table_map =3D arcturus_table_map;
         smu->pwr_src_map =3D arcturus_pwr_src_map;
         smu->workload_map =3D arcturus_workload_map;
+       smu_v11_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index f1a4a720d426..ca4d97b7f576 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -591,4 +591,5 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *s=
mu)
         smu->message_map =3D cyan_skillfish_message_map;
         smu->table_map =3D cyan_skillfish_table_map;
         smu->is_apu =3D true;
+       smu_v11_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5f22fc3430f4..0bcd4fe0ef17 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3580,4 +3580,5 @@ void navi10_set_ppt_funcs(struct smu_context *smu)
         smu->table_map =3D navi10_table_map;
         smu->pwr_src_map =3D navi10_pwr_src_map;
         smu->workload_map =3D navi10_workload_map;
+       smu_v11_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6b452e3f5ee3..f6f21b516fd6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -4357,4 +4357,5 @@ void sienna_cichlid_set_ppt_funcs(struct smu_context =
*smu)
         smu->table_map =3D sienna_cichlid_table_map;
         smu->pwr_src_map =3D sienna_cichlid_pwr_src_map;
         smu->workload_map =3D sienna_cichlid_workload_map;
+       smu_v11_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index b87f550af26b..974b8fe1dbb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2197,3 +2197,12 @@ int smu_v11_0_restore_user_od_settings(struct smu_co=
ntext *smu)

         return ret;
 }
+
+void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+
+       smu->param_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+       smu->msg_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+       smu->resp_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 5551e1426ef5..e2d8ac90cf36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2213,4 +2213,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
         smu->table_map =3D vangogh_table_map;
         smu->workload_map =3D vangogh_workload_map;
         smu->is_apu =3D true;
+       smu_v11_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 012e3bd99cc2..85e22210963f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -41,6 +41,15 @@
 #undef pr_info
 #undef pr_debug

+#define mmMP1_SMN_C2PMSG_66                                               =
                             0x0282
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                      =
                             0
+
+#define mmMP1_SMN_C2PMSG_82                                               =
                             0x0292
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                      =
                             0
+
+#define mmMP1_SMN_C2PMSG_90                                               =
                             0x029a
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                      =
                             0
+
 static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] =
=3D {
         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,    =
              1),
         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,  =
              1),
@@ -1447,6 +1456,8 @@ static const struct pptable_funcs renoir_ppt_funcs =
=3D {

 void renoir_set_ppt_funcs(struct smu_context *smu)
 {
+       struct amdgpu_device *adev =3D smu->adev;
+
         smu->ppt_funcs =3D &renoir_ppt_funcs;
         smu->message_map =3D renoir_message_map;
         smu->clock_map =3D renoir_clk_map;
@@ -1454,4 +1465,7 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
         smu->workload_map =3D renoir_workload_map;
         smu->smc_driver_if_version =3D SMU12_DRIVER_IF_VERSION;
         smu->is_apu =3D true;
+       smu->param_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+       smu->msg_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+       smu->resp_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index fb130409309c..2e6a93869be8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -2117,4 +2117,5 @@ void aldebaran_set_ppt_funcs(struct smu_context *smu)
         smu->clock_map =3D aldebaran_clk_map;
         smu->feature_map =3D aldebaran_feature_mask_map;
         smu->table_map =3D aldebaran_table_map;
+       smu_v13_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 7be4f6875a7b..6fd3216b91d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -60,6 +60,15 @@ MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_0.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_7.bin");

+#define mmMP1_SMN_C2PMSG_66                                               =
                             0x0282
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                      =
                             0
+
+#define mmMP1_SMN_C2PMSG_82                                               =
                             0x0292
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                      =
                             0
+
+#define mmMP1_SMN_C2PMSG_90                                               =
                             0x029a
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                      =
                             0
+
 #define SMU13_VOLTAGE_SCALE 4

 #define LINK_WIDTH_MAX                          6
@@ -2386,3 +2395,12 @@ int smu_v13_0_set_default_dpm_tables(struct smu_cont=
ext *smu)
         return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
                                     smu_table->clocks_table, false);
 }
+
+void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+
+       smu->param_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+       smu->msg_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+       smu->resp_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5c74a72577c6..418480e0c077 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1651,4 +1651,5 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *sm=
u)
         smu->table_map =3D smu_v13_0_0_table_map;
         smu->pwr_src_map =3D smu_v13_0_0_pwr_src_map;
         smu->workload_map =3D smu_v13_0_0_workload_map;
+       smu_v13_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 5a17b51aa0f9..8ccda593fc50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -43,6 +43,15 @@
 #undef pr_info
 #undef pr_debug

+#define mmMP1_SMN_C2PMSG_66                    0x0282
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX            1
+
+#define mmMP1_SMN_C2PMSG_82                    0x0292
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX            1
+
+#define mmMP1_SMN_C2PMSG_90                    0x029a
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX           1
+
 #define FEATURE_MASK(feature) (1ULL << feature)

 #define SMC_DPM_FEATURE ( \
@@ -1034,9 +1043,14 @@ static const struct pptable_funcs smu_v13_0_4_ppt_fu=
ncs =3D {

 void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)
 {
+       struct amdgpu_device *adev =3D smu->adev;
+
         smu->ppt_funcs =3D &smu_v13_0_4_ppt_funcs;
         smu->message_map =3D smu_v13_0_4_message_map;
         smu->feature_map =3D smu_v13_0_4_feature_mask_map;
         smu->table_map =3D smu_v13_0_4_table_map;
         smu->is_apu =3D true;
+       smu->param_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+       smu->msg_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+       smu->resp_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index b81711c4ff33..47360ef5c175 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -42,6 +42,15 @@
 #undef pr_info
 #undef pr_debug

+#define mmMP1_C2PMSG_2                                                    =
                        (0xbee142 + 0xb00000 / 4)
+#define mmMP1_C2PMSG_2_BASE_IDX                                           =
                        0
+
+#define mmMP1_C2PMSG_34                                                   =
                        (0xbee262 + 0xb00000 / 4)
+#define mmMP1_C2PMSG_34_BASE_IDX                                          =
                         0
+
+#define mmMP1_C2PMSG_33                                                   =
                             (0xbee261 + 0xb00000 / 4)
+#define mmMP1_C2PMSG_33_BASE_IDX                                          =
                         0
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
         FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -1049,9 +1058,14 @@ static const struct pptable_funcs smu_v13_0_5_ppt_fu=
ncs =3D {

 void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu)
 {
+       struct amdgpu_device *adev =3D smu->adev;
+
         smu->ppt_funcs =3D &smu_v13_0_5_ppt_funcs;
         smu->message_map =3D smu_v13_0_5_message_map;
         smu->feature_map =3D smu_v13_0_5_feature_mask_map;
         smu->table_map =3D smu_v13_0_5_table_map;
         smu->is_apu =3D true;
+       smu->param_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_34);
+       smu->msg_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_2);
+       smu->resp_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_33);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 4e1861fb2c6a..bdea7bca3805 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1594,4 +1594,5 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *sm=
u)
         smu->table_map =3D smu_v13_0_7_table_map;
         smu->pwr_src_map =3D smu_v13_0_7_pwr_src_map;
         smu->workload_map =3D smu_v13_0_7_workload_map;
+       smu_v13_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index feff4f8c927c..70cbc46341a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1203,4 +1203,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *sm=
u)
         smu->feature_map =3D yellow_carp_feature_mask_map;
         smu->table_map =3D yellow_carp_table_map;
         smu->is_apu =3D true;
+       smu_v13_0_set_smu_mailbox_registers(smu);
 }
--
2.35.3


--_000_PH7PR12MB59970C2F41A4B8FA2C358A5482DF9PH7PR12MB5997namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Series is</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Friday, May 27, 2022 2:00 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/3] drm/amdgpu/swsmu: add SMU mailbox registers in =
SMU context</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">So we can eventaully use them in the common smu co=
de for<br>
accessing the SMU mailboxes without needing a lot of<br>
per asic logic in the common code.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h&nbsp; |&nbsp; 4 ++++<br=
>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h&nbsp;&nbsp; |&nbsp; 2 ++=
<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h&nbsp;&nbsp; |&nbsp; 2 ++=
<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c&nbsp; |&nbsp; 1 +<br>
&nbsp;.../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp;=
 1 +<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp;=
 1 +<br>
&nbsp;.../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp;=
 1 +<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |&nbsp; 9 +++++++++<br=
>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp;&nbsp; |&nbsp; 1 +<=
br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c&nbsp;&nbsp;&nbsp; | 14 ++=
++++++++++++<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 18 +++++++++++++++++=
+<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c&nbsp;&nbsp; |&nbsp; 1 +<=
br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c&nbsp;&nbsp; | 14 +++++++=
+++++++<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c&nbsp;&nbsp; | 14 +++++++=
+++++++<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c&nbsp;&nbsp; |&nbsp; 1 +<=
br>
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c&nbsp;&nbsp; |&nbsp; 1 +<=
br>
&nbsp;17 files changed, 86 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index a6a7b6c33683..36af1f417dcd 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -563,6 +563,10 @@ struct smu_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct stb_context stb_con=
text;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct firmware pptable_fi=
rmware;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 param_reg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 msg_reg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 resp_reg;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct i2c_adapter;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v11_0.h<br>
index acb3be292096..a9215494dcdd 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h<br>
@@ -316,5 +316,7 @@ int smu_v11_0_handle_passthrough_sbr(struct smu_context=
 *smu, bool enable);<br>
&nbsp;<br>
&nbsp;int smu_v11_0_restore_user_od_settings(struct smu_context *smu);<br>
&nbsp;<br>
+void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu);<br>
+<br>
&nbsp;#endif<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h<br>
index 036fd2810ecc..f60dcc4f7e75 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h<br>
@@ -298,5 +298,7 @@ int smu_v13_0_od_edit_dpm_table(struct smu_context *smu=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size);<br>
&nbsp;<br>
&nbsp;int smu_v13_0_set_default_dpm_tables(struct smu_context *smu);<br>
+<br>
+void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu);<br>
&nbsp;#endif<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
index 201563072189..bfabcd3c45aa 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
@@ -2509,4 +2509,5 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D arct=
urus_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pwr_src_map =3D ar=
cturus_pwr_src_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_map =3D a=
rcturus_workload_map;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_set_smu_mailbox_registers(s=
mu);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c<br>
index f1a4a720d426..ca4d97b7f576 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c<br>
@@ -591,4 +591,5 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *s=
mu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;message_map =3D cy=
an_skillfish_message_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D cyan=
_skillfish_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;is_apu =3D true;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_set_smu_mailbox_registers(s=
mu);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
index 5f22fc3430f4..0bcd4fe0ef17 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
@@ -3580,4 +3580,5 @@ void navi10_set_ppt_funcs(struct smu_context *smu)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D navi=
10_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pwr_src_map =3D na=
vi10_pwr_src_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_map =3D n=
avi10_workload_map;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_set_smu_mailbox_registers(s=
mu);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index 6b452e3f5ee3..f6f21b516fd6 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -4357,4 +4357,5 @@ void sienna_cichlid_set_ppt_funcs(struct smu_context =
*smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D sien=
na_cichlid_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pwr_src_map =3D si=
enna_cichlid_pwr_src_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_map =3D s=
ienna_cichlid_workload_map;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_set_smu_mailbox_registers(s=
mu);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index b87f550af26b..974b8fe1dbb6 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -2197,3 +2197,12 @@ int smu_v11_0_restore_user_od_settings(struct smu_co=
ntext *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
+<br>
+void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;param_reg =3D SOC15_REG_OFFSE=
T(MP1, 0, mmMP1_SMN_C2PMSG_82);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;msg_reg =3D SOC15_REG_OFFSET(=
MP1, 0, mmMP1_SMN_C2PMSG_66);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;resp_reg =3D SOC15_REG_OFFSET=
(MP1, 0, mmMP1_SMN_C2PMSG_90);<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 5551e1426ef5..e2d8ac90cf36 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -2213,4 +2213,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D vang=
ogh_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_map =3D v=
angogh_workload_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;is_apu =3D true;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_set_smu_mailbox_registers(s=
mu);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
index 012e3bd99cc2..85e22210963f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
@@ -41,6 +41,15 @@<br>
&nbsp;#undef pr_info<br>
&nbsp;#undef pr_debug<br>
&nbsp;<br>
+#define mmMP1_SMN_C2PMSG_66&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0282<br>
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_SMN_C2PMSG_82&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0292<br>
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_SMN_C2PMSG_90&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x029a<br>
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
&nbsp;static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COU=
NT] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TestMessage,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TestMessage,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSmuVersion,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetSmuVersion,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
@@ -1447,6 +1456,8 @@ static const struct pptable_funcs renoir_ppt_funcs =
=3D {<br>
&nbsp;<br>
&nbsp;void renoir_set_ppt_funcs(struct smu_context *smu)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;ppt_funcs =3D &amp=
;renoir_ppt_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;message_map =3D re=
noir_message_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;clock_map =3D reno=
ir_clk_map;<br>
@@ -1454,4 +1465,7 @@ void renoir_set_ppt_funcs(struct smu_context *smu)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_map =3D r=
enoir_workload_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_driver_if_vers=
ion =3D SMU12_DRIVER_IF_VERSION;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;is_apu =3D true;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;param_reg =3D SOC15_REG_OFFSE=
T(MP1, 0, mmMP1_SMN_C2PMSG_82);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;msg_reg =3D SOC15_REG_OFFSET(=
MP1, 0, mmMP1_SMN_C2PMSG_66);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;resp_reg =3D SOC15_REG_OFFSET=
(MP1, 0, mmMP1_SMN_C2PMSG_90);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
index fb130409309c..2e6a93869be8 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
@@ -2117,4 +2117,5 @@ void aldebaran_set_ppt_funcs(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;clock_map =3D alde=
baran_clk_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;feature_map =3D al=
debaran_feature_mask_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D alde=
baran_table_map;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_set_smu_mailbox_registers(s=
mu);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 7be4f6875a7b..6fd3216b91d0 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -60,6 +60,15 @@ MODULE_FIRMWARE(&quot;amdgpu/aldebaran_smc.bin&quot;);<b=
r>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/smu_13_0_0.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/smu_13_0_7.bin&quot;);<br>
&nbsp;<br>
+#define mmMP1_SMN_C2PMSG_66&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0282<br>
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_SMN_C2PMSG_82&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0292<br>
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_SMN_C2PMSG_90&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x029a<br>
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
&nbsp;#define SMU13_VOLTAGE_SCALE 4<br>
&nbsp;<br>
&nbsp;#define LINK_WIDTH_MAX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 6<br>
@@ -2386,3 +2395,12 @@ int smu_v13_0_set_default_dpm_tables(struct smu_cont=
ext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_update_tabl=
e(smu, SMU_TABLE_DPMCLOCKS, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_tabl=
e-&gt;clocks_table, false);<br>
&nbsp;}<br>
+<br>
+void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;param_reg =3D SOC15_REG_OFFSE=
T(MP1, 0, mmMP1_SMN_C2PMSG_82);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;msg_reg =3D SOC15_REG_OFFSET(=
MP1, 0, mmMP1_SMN_C2PMSG_66);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;resp_reg =3D SOC15_REG_OFFSET=
(MP1, 0, mmMP1_SMN_C2PMSG_90);<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index 5c74a72577c6..418480e0c077 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -1651,4 +1651,5 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *sm=
u)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D smu_=
v13_0_0_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pwr_src_map =3D sm=
u_v13_0_0_pwr_src_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_map =3D s=
mu_v13_0_0_workload_map;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_set_smu_mailbox_registers(s=
mu);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
index 5a17b51aa0f9..8ccda593fc50 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
@@ -43,6 +43,15 @@<br>
&nbsp;#undef pr_info<br>
&nbsp;#undef pr_debug<br>
&nbsp;<br>
+#define mmMP1_SMN_C2PMSG_66&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0282<=
br>
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
+<br>
+#define mmMP1_SMN_C2PMSG_82&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0292<=
br>
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
+<br>
+#define mmMP1_SMN_C2PMSG_90&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x029a<=
br>
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 1<br>
+<br>
&nbsp;#define FEATURE_MASK(feature) (1ULL &lt;&lt; feature)<br>
&nbsp;<br>
&nbsp;#define SMC_DPM_FEATURE ( \<br>
@@ -1034,9 +1043,14 @@ static const struct pptable_funcs smu_v13_0_4_ppt_fu=
ncs =3D {<br>
&nbsp;<br>
&nbsp;void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;ppt_funcs =3D &amp=
;smu_v13_0_4_ppt_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;message_map =3D sm=
u_v13_0_4_message_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;feature_map =3D sm=
u_v13_0_4_feature_mask_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D smu_=
v13_0_4_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;is_apu =3D true;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;param_reg =3D SOC15_REG_OFFSE=
T(MP1, 0, mmMP1_SMN_C2PMSG_82);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;msg_reg =3D SOC15_REG_OFFSET(=
MP1, 0, mmMP1_SMN_C2PMSG_66);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;resp_reg =3D SOC15_REG_OFFSET=
(MP1, 0, mmMP1_SMN_C2PMSG_90);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c<br>
index b81711c4ff33..47360ef5c175 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c<br>
@@ -42,6 +42,15 @@<br>
&nbsp;#undef pr_info<br>
&nbsp;#undef pr_debug<br>
&nbsp;<br>
+#define mmMP1_C2PMSG_2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; (0xbee142 + 0xb00000 / 4)<br>
+#define mmMP1_C2PMSG_2_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_C2PMSG_34&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (0xbee262 + 0xb00000 / 4)<br>
+#define mmMP1_C2PMSG_34_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
+#define mmMP1_C2PMSG_33&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0xbee261 + 0xb00000 / 4)<=
br>
+#define mmMP1_C2PMSG_33_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
&nbsp;#define FEATURE_MASK(feature) (1ULL &lt;&lt; feature)<br>
&nbsp;#define SMC_DPM_FEATURE ( \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_MASK(FEATURE_CCLK_=
DPM_BIT) | \<br>
@@ -1049,9 +1058,14 @@ static const struct pptable_funcs smu_v13_0_5_ppt_fu=
ncs =3D {<br>
&nbsp;<br>
&nbsp;void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;ppt_funcs =3D &amp=
;smu_v13_0_5_ppt_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;message_map =3D sm=
u_v13_0_5_message_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;feature_map =3D sm=
u_v13_0_5_feature_mask_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D smu_=
v13_0_5_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;is_apu =3D true;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;param_reg =3D SOC15_REG_OFFSE=
T(MP1, 0, mmMP1_C2PMSG_34);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;msg_reg =3D SOC15_REG_OFFSET(=
MP1, 0, mmMP1_C2PMSG_2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;resp_reg =3D SOC15_REG_OFFSET=
(MP1, 0, mmMP1_C2PMSG_33);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 4e1861fb2c6a..bdea7bca3805 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -1594,4 +1594,5 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *sm=
u)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D smu_=
v13_0_7_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pwr_src_map =3D sm=
u_v13_0_7_pwr_src_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_map =3D s=
mu_v13_0_7_workload_map;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_set_smu_mailbox_registers(s=
mu);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
index feff4f8c927c..70cbc46341a3 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
@@ -1203,4 +1203,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *sm=
u)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;feature_map =3D ye=
llow_carp_feature_mask_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;table_map =3D yell=
ow_carp_table_map;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;is_apu =3D true;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_set_smu_mailbox_registers(s=
mu);<br>
&nbsp;}<br>
-- <br>
2.35.3<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB59970C2F41A4B8FA2C358A5482DF9PH7PR12MB5997namp_--

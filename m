Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C323C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 09:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B074E22CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 09:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B074E22CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C2389AAE;
	Mon, 21 Dec 2020 09:14:43 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF6F89AAE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 09:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n03pgrXYCmnnkTLoGQDhwhCknCGyw3FvYiNzinveTD1WZA0iHH+JLZxHdIpk1IASVtrgyYagBGxFGnicEP8hPJqDiiErB9vRZI6B8VNKILMaRxnbWiBceXLdj87WTvfm8yr3IxYVCryVpehBIbT3vVf6Z7TFAqYaUSYRYYvBZm+0KCKGh8Iwpz9mpxK+7e0QeLzneOL6pdI40iq/ryLu8uTcVD62tyV2CXC+wmoipdEOnWT6bS14Dcrqf8346Y3UeQ1HxBN1pQzFPHEeeT/v2S6AF2tisgPvMgr34i+ivezMpGglyhRbsrwNDVBRZydmeLLqSb1e2Rp9fNK9zp1jJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWLGbux/EOYBN2dJK0M9b6haFh1ZCbDyuJwsmnSJjWw=;
 b=h4vQiJ7cq7mA6b7IbZcUyiazSJFMsM7bsoWzQ0ZffNSiJV4ieTRIA8oRnvkqjbfOfBEtDgE64ch8tsjZn+Rp4fbHgRQipI+a4e5aV1smXAbGhY/7HlqwL4HI1EHAl5SmJw024FOXwaAJaKR/COthGpWiPJeZFCucq8cFr7XW3NDIcErMcrGwBD0GAwjqReQ6yyYct/XIIPOlBPNSkhz+xSqvKmxgp6jEcqQgVxx+gkcdykxb+qJ/LQmuUM5dXIUAUR5o6S18N6qpRvGwRaUPlmdmMndnBms+Hzh8IfkR+JzkZqGozQR43K7WNKYcNo7i9PNi4nldfsQU8+V/2zVimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWLGbux/EOYBN2dJK0M9b6haFh1ZCbDyuJwsmnSJjWw=;
 b=NBqbgZsLM24LUvxgkhJNA3h+xAnQa0JEwH8c4ZxyRi7E9HBPjX9ELlhk9XHJFNv9T7Zv/tvvGpPrx+z1WM+tSreEaAXpYpwN2eg+qzFFK+8MNvB1VLn0A3luOEMzUDvcwdywzWCNfIFDINLyk5CqJ1AMJUW4YBurPh4Vy1q6H+Y=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1877.namprd12.prod.outlook.com (2603:10b6:903:11c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Mon, 21 Dec
 2020 09:14:39 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 09:14:39 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to
 match latest pmfw
Thread-Topic: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to
 match latest pmfw
Thread-Index: AQHW1PiC9K2UeBg1MUOEPIei2JbHM6oBR/0AgAABHRA=
Date: Mon, 21 Dec 2020 09:14:38 +0000
Message-ID: <CY4PR12MB12875AF35315E1F598D6CB45F1C00@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201218044411.109708-1-evan.quan@amd.com>
 <DM6PR12MB2619401D9555CBE9933D9816E4C00@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619401D9555CBE9933D9816E4C00@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-21T09:13:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=14fa0059-346b-4db8-b4cc-00002a2d1884;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-21T09:14:36Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: fef4bff5-c95a-41f8-b3ba-00009e6773ba
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30089e2a-4045-488e-8267-08d8a590d7f6
x-ms-traffictypediagnostic: CY4PR12MB1877:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB187732E316BD570E1A4CC6ABF1C00@CY4PR12MB1877.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTgj0RMdX8I23VEV6NVLEINYivZkE9Ok1wB4IfekeoYYm1Noq5yesnX7D8qthtL1DCjLLZgkoiyInpmx9HfKILufhgW5U0MQp9zh4WoLcDXE72MEHUh10RW893kyp4xBBYt64CvOp/B62JC35MQrfScftEiMkp2+PWvlWL1DxiIak/p3UitQwLgCacD0nDEjzC/Tc/HsH1urv4rvcBf73KalpExqFGaOGyvShYTEd20T3JAGOODw8xsVSX0c8cwgoV1K+ae4gmqZynTHKUuJIDL/wuPxcUWnpLBCG2lfLgOmyTbW7uBXe1iEhyhffXvXdHArfUT0xROKlqxWwegVpXHd5OogeBHTEopU0PpNurPtxORKDUH7ZwdE5KtRpANB5x28up5N8+mWEafUKFS7Rlm0Tx3eCuB56abobnWavUs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(64756008)(186003)(66446008)(66476007)(26005)(66946007)(83380400001)(76116006)(66556008)(4326008)(71200400001)(52536014)(5660300002)(8936002)(45080400002)(8676002)(478600001)(55016002)(966005)(9686003)(110136005)(316002)(33656002)(53546011)(2906002)(86362001)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wbu3zSAFt6Cej2NNvA1COWkkz+6cJj+yOl5x+XRLq+2QGwpCO+fRJrHmUhQK?=
 =?us-ascii?Q?6Jh+jKultBCQlmGeV3zBzPhWvnvr83L0FzecdBgwSmxwsZk3XRsIg5x65rbj?=
 =?us-ascii?Q?AYS7naHJIgl5lNG7eZ2Lgk3Qex/kGnkDAtlhDb0VTNNebLBCt9vnZ1WvsiHb?=
 =?us-ascii?Q?W6CuOkhU/zzwDya2NyxapL1/P1GR1oD/f2M987vk4WnwmQkdhX83STgoqrQk?=
 =?us-ascii?Q?/bjVzKruab+/EaI7thzpLFSaFnYg/qcZXoKqFj269RLHTze5zhypVqNF9j1e?=
 =?us-ascii?Q?yJXbGoPFcT2J1Ef/CMu/jLNb6X54JukR3rE75jaetO1Q0I6/dbUhK9jF5V5X?=
 =?us-ascii?Q?fBA9Mwv2AU34BaOHwOR0Ak2UBazBK7tYhm76V+xOD+kjl/QAydnLHSXXoefa?=
 =?us-ascii?Q?KLbaPeZm3w+ikFPJ0cpBeimbckG+UsSbdWvYTo1rVbvQQFnuDyP8Fuqvuf2v?=
 =?us-ascii?Q?j+bXmSaL7RIzr4dC6AV1zM86v/K5A/DsepYnBk4gvX38iUDicJqBbEwYZxpd?=
 =?us-ascii?Q?w2l8grZPaOjh/6OVbN/mkQl0hGsajo6uKu9qQAmoun4ihkmr5IUi/HCpDg3X?=
 =?us-ascii?Q?SFLND3iMPIsho5FHyNOZoIqZKcaFWKreLscwOprQcJLDNDd5dvDuZDcpTvxk?=
 =?us-ascii?Q?r3T73xskAt2m13uUhdbL+11fjfecRmMA6jyHlPfJfthwUfGBBSMePY4qRVD7?=
 =?us-ascii?Q?/wxfNYK3PvI7EKyn+vW6nNw6VhldZJs5Ud9RtomDO/hNERUJ+XjTFV2lSEl9?=
 =?us-ascii?Q?8RCpLHnxDs3DwTC6jILhdvQ81AY4ub+tfNK+JqF4wKUNTkmkUIBsnAfHRsWr?=
 =?us-ascii?Q?gbah0T/IsFASIRFcM51tGrO7fM66EpjZEiHs5iml5gZWp8xLUyma2nW61biw?=
 =?us-ascii?Q?0IbzDbLJbalnra7PeFh1UVbcmtnpvjP1BQQJlW+llGicDUbPlacM2mF81GuJ?=
 =?us-ascii?Q?70hnf3Jn2BY4Nbi4PpVxwS8hje0Oe59lK8TKN7oIPidWNxCHLudo0Oqco3PC?=
 =?us-ascii?Q?OlQ8?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30089e2a-4045-488e-8267-08d8a590d7f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 09:14:38.8296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPE709cOPwwR2TGZ4DKE3qxEpSYah0JgNQxXsVn8IpBAMl71WeI9Yxej0aU3spGMf092NGg0t2LEQDTxyXSEZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1877
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

It's better to remove Change-Id in the commit message.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Quan, Evan
Sent: Monday, December 21, 2020 5:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to match latest pmfw

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Ping..

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, December 18, 2020 12:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to match latest pmfw

This can suppress the annoying but unharmful prompts.

Change-Id: I50bc5f9bd21572f51af4ff4c9e1946d1a441b714
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index e5aa0725147c..13de692a4213 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36  #define SMU11_DRIVER_IF_VERSION_NV12 0x36  #define SMU11_DRIVER_IF_VERSION_NV14 0x36 -#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC  #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02  #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C3bfbf93798c14d0aed2508d8a5901db2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637441385692140693%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=X6yX7wPmMvj0MpQhLZVz40uoZvQKQpm6MXAcIaiKICU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

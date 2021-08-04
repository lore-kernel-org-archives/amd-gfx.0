Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFD4C4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 08:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BEC60E96
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 08:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7BEC60E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371D76EA2F;
	Wed,  4 Aug 2021 08:07:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33EF06EA1F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 08:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyvOgjnq/mPHinfd4ApEQcreoPHzXUOYsgmD3PZu+60DRqSTZb7YkU7mY7xDT/MfgwSpHc7uOSGybHx8B65ikuZJjyOdzaYmt0Su6ARehnFFRhi4ZygzKp0Cni0a12gbW2pc8MLLMN2FS3wWzJZvUaxk4kPS6kt4DnGL1XwlE1wEIbDq+UmjKkktRypX1mubBF+nOltjlwQ0RyZcoiZy8ZIjdhuG5iEIy7nAWw8yqOr2tXCIQq7THchslzDf3g160xO6qdtvE0ov1JSra9NQB1DH9Awm9UTgC6VgL3C0YTmKE2ekuAWD6qYeA/RTdPJfVI1RkVYjATMn+PJB/QesOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF06B6Obh68/ntAz8KGyXMfeHbfLgZ1AgXJtqKEgNr4=;
 b=LFx+yWHzYtbbGHVeoXkr5CG6WtyKFTRL5qcelK1STgLRaADIBFxLyQw5F74+UPxMh7ZVglKIUfaDhBW0Ekn2Pw6JterIpHhgE8rytbdhQVL/MrTv+0mDHoyzodrV4XSWHMhOS2czsdLZFRa9Z4G+tbErfJ44jsdrlQGoM7cofpN2sRbLzx3LCZgDbhOtiYGDSo2m+gYD4ytuD82NGXO6zAQSknYyg7aG0ygjSiPoELFhFsi6852N2RRvuH5vKtXy4FZbrhJkxB6kmIVdypsPCPo8s6zETETc/u+nduC51Sm7HkKlvKtuaVqwvYVOHuU+v1q+BD3kybgLtLzdUq4A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF06B6Obh68/ntAz8KGyXMfeHbfLgZ1AgXJtqKEgNr4=;
 b=mlfrL+hRje+NnzkrFn7DZNJFaXZidn8wUVTakXSy4gMtW9ZgX3Ul814v9A+j23vlB1g8n5k5eIpBmxsJkgyBD2sc9Ec38Mp5YgkyV9jaiesGh29+vZPIh4EbW0dj6oq4Re6IOTj0CZteCvFtei0JI2aX+Mc5X8O/ObK8XxuzTBY=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH2PR12MB5530.namprd12.prod.outlook.com (2603:10b6:610:35::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Wed, 4 Aug
 2021 08:07:30 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a463:c1c9:af2b:7574]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a463:c1c9:af2b:7574%7]) with mapi id 15.20.4373.027; Wed, 4 Aug 2021
 08:07:30 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Nieto, David M" <David.Nieto@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
Thread-Topic: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
Thread-Index: AQHXiQVtEMExS22O/UmEEi2kycEOx6ti/Plw
Date: Wed, 4 Aug 2021 08:07:30 +0000
Message-ID: <CH0PR12MB5156021023502CABB4EAE1F8F8F19@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210804075024.9407-1-Jiawei.Gu@amd.com>
In-Reply-To: <20210804075024.9407-1-Jiawei.Gu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-04T08:07:28Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6fff13d8-1b1d-48fe-a29d-d2c9d9653d2a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd2a9a2c-6865-473e-cdd9-08d9571ee829
x-ms-traffictypediagnostic: CH2PR12MB5530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB553093B8DD3519EE3EFBB149F8F19@CH2PR12MB5530.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxOGgfhGLSqVJIsbkBkzdh5Vj2EJyBe/GPmtaxvnCqBCP/onooMFHbVG6tKMHzUNxa+3D0Lnn72drwY6f0bJxdxrBydn7WG4pX4bYvdwNxnJ8gvZhqBUEUtVytkSOD9tt/g46PBlP3Flx7oFewb0wsr2l9DQZB/acSjGYOvs1yJbKMyVfg1PTHR8+ngPC9xavjPAi3nfyh5GOgj/u6vGOaxK2U7NybKRrqSPCUmzWrIA5AehrUfPPx9TqkSfE1TgwSn+OGado/2rbNVG/RQRng767JA7f3wsPRBCq+H+eD9mCOieGDCzGkPbmGXrlbuNzhBqZrEpxFKcJPzqKF2KpK7j5kvDuF4uDLLd+c7qsaKkVoLUPhYhmwin4B8BC3zjPBLg6U6h/+DK8RDLUzZSR0bFu7oBUueqeguVG4kX9ADN2SkrAv60MgdLtY/gKmYyKA/PETTXWnEvm9DWHjp5TdYsWJv5F2Ly82d/vLaQp8NBcAvFUSmwarY3fVv7GCEJuT5fhO6ChCKpg9aumSg5u8v7q7aFQdpdXgszx1VKiuMcLaHyZHIit9D1uv/QAp9hyi9wi/cz0Lj81eeLHZkM7XQEzVImunTxn5JFvbDrF8zGVa6nBcII6EdLilQ4pzkhQfTXc9mEvEkSIODcvijvydPPnaWXw4HBx4kfUUeFzWEK4ZbhwvoSMDOC/kvywsyNd85eT4Y00H7aISRvQ+mhRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(38100700002)(2906002)(8936002)(83380400001)(54906003)(33656002)(110136005)(52536014)(38070700005)(4326008)(122000001)(7696005)(9686003)(8676002)(5660300002)(76116006)(26005)(6506007)(71200400001)(66556008)(55016002)(186003)(316002)(66946007)(53546011)(478600001)(64756008)(66446008)(66476007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ouaoW1OLvpDdDn1Mr5/n8uLmPkYpHUwja9Dajcx3FwwV6maCACnCMjOdXi+?=
 =?us-ascii?Q?gpKGyfyGI4PrsldUQ0Ac2Cr7sCOU6Q17jJ/bi7TowlRaIugGxm7IL6GcxzA7?=
 =?us-ascii?Q?uSnKJFsnvjKTQzXD/Sbi+sJyBc3+9wknetclbPtd6OARvAk9908MS6h8hqGa?=
 =?us-ascii?Q?gjDZyL9PdtTsys5esApycluIqmieJKDIuOlWCs4dxxDnv2mgf3AffexlbuRL?=
 =?us-ascii?Q?gVvhX0AE0kIAuQfbaUxtDaaXPxZevLTQ1LH7MNHSq4qHyx7dzyYerFyMgACC?=
 =?us-ascii?Q?AdkIGBPTxD5hry7lcqp6xPzgv9m1FGkjD1j4ipX4bbjvoXHKxNbQyQ1AvGS8?=
 =?us-ascii?Q?+EHAAxbTJdO4aM5N+zRiQmbS7b7MjvaJvqwLFoc1RSY40vAwecmPKae+cgmq?=
 =?us-ascii?Q?0n8gao+P8TFpamCRGGoZHXj/rMfowAobkur2KSdjupQkWdULlAXcRXMkTBA9?=
 =?us-ascii?Q?34qtr2uPTuT9xJOSFD01nF9rnZn2MsMbVo1DBDnRrjzchDextfVN52O7zDno?=
 =?us-ascii?Q?fEmPX0RJ7SH6mOu23xPvkIwGqQVW2/h5GqOlKrScEtX2oZhv9wDNtnS9lnpc?=
 =?us-ascii?Q?xxM+ZhHF/wcyGGwhe1TlcUgcmj+NhGHXrSnBOvwHwMb4EamwwLVSmjgyTLUp?=
 =?us-ascii?Q?UwWQE2ET57UPb/N776WUhtLAR+aNb9yJEWxsRaHddOW3hpksyDYBuPeoGjRB?=
 =?us-ascii?Q?S02kBLSM4dPmDuydtkO/lKY5zSWSi8yREpws5tK3t5WEH1jC94e2JN8rMlOK?=
 =?us-ascii?Q?6QJg0vOQr7toZ+UzTWO2DxsWaRNwfw0cKUuL6GuH+Pe3mayKQpmSGJYZhZSU?=
 =?us-ascii?Q?rV4hYlyMXLg2f32SPlXCcFK7yvSXHHLT/T27WmDKE/68J5U7UoKr1bE061YO?=
 =?us-ascii?Q?FA40Czs/EZjB5fajDhU3PTyoowBeqNx1FNjbRzHH4r7mmkEfL+B8zHyKxVq5?=
 =?us-ascii?Q?SmZL2j7ALm4s3ec7QWSrtx2kuSCrLjd4yYZyjGfYTx9Yy8DbgYieHZY9mOmQ?=
 =?us-ascii?Q?m4mBVmGbMq0w3LzpYoKgxOVgJWkA8kLBpcXWshK4C9lvJfFEuMhpo67bWCkU?=
 =?us-ascii?Q?qXCTHTnyhtxsCzr+WMhYHWFVDNEUOL2nvhCapFykdnw62SCRPTswqEcmC9nF?=
 =?us-ascii?Q?rTMz3R8LZEnvcpAmL6nnYIw/WXdYDHGNtDb1HOskRqY3MiKuG9ZjT7fM3Z2K?=
 =?us-ascii?Q?ZYhwglPvMfdal6z2cwLyW4QIrWf/jCAZAYodxXZIHmq2+EVPX8tIbdhzZUvJ?=
 =?us-ascii?Q?F9WChnMtON3FGReu2EoIeWDskmRds1NnKq6bM9LVrKcZWVLwXwsMeTPrT3j5?=
 =?us-ascii?Q?QDI4Istoa0HaaTTTjhQrKWbP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2a9a2c-6865-473e-cdd9-08d9571ee829
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 08:07:30.3741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qI+P2PixwkK6Nq6B+xtSGdLA7DAlxYvbzvEygoveHifN/zK9FhvRlUeEhP5QEdZ7/nw6ZDqjL5e+X2Ky/TTDKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5530
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

[AMD Official Use Only]

Add Alex.

-----Original Message-----
From: Jiawei Gu <Jiawei.Gu@amd.com>=20
Sent: Wednesday, August 4, 2021 3:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily <Emily.Deng@amd.com>;=
 Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode

Enable pp_num_states, pp_cur_state, pp_force_state, pp_table sysfs under SR=
IOV 1-VF scenario.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 769f58d5ae1a..04c7d82f8b89 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2005,10 +2005,10 @@ static int ss_bias_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_  static struct amdgpu_device_attr amdgpu_devi=
ce_attrs[] =3D {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF=
),
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|=
ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF)=
,
+	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
--
2.17.1

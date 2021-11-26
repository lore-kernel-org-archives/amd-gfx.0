Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD8BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 06:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255F26E150;
	Fri, 26 Nov 2021 06:06:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8FB6E595
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 06:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctnSA8FbFVets3qMMEhhhw/ZWjB0/mtFGZtYKsDdXrKGl7lv/C7GfIuuf4a6luc5Wnw+a+nxjYk6FyHyrznGZ71+gt+DVeG/qpMVqoQWH+9EOVyKTItG8C5OmY5HX09WbnNGt/ZfRCVUzpv1tmrOZ62q6MzDS2EAOqYLXd6uINazuSdZ6MqAiHi8Lm2Ney1u9gIZdfm6AmGboLiT4sGS7QMH1mBJukjRBzBmJGI6aT2zTTA0gYCfDCIai2fGOprdBhDWxahnT/F7Euc3Q7PYc0x30deaQktLZMku5Vley+9O1s/Rbu+tdYeA8Tzfx3GPsVkOHcOSWo9I6GJa1C7m5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TH/+FoKY7c3PV8XjIsxgp+qejvaPEYIW4oNCd20vsE=;
 b=KJtyH6Izj/Ng/LS0hU/jWtv+f6EqWrcdrz7JWTRw8t1fgKPbdvIbMbIUxrbhPShGh2gg+XOOxCM6cK1XH+Kam3eQQepcqke1Cb7Xm4DBbJxPROeLaa6UV4rP9ePrI4hKol8tRu4iEthEzRsHgwE8dy6PnoKje3yQQJKz5C0AQt5MYdJaDymHKvk97gqpbgvZYcYJE+kdZ21ZW9G0wMJo7/fOD+wRlyXw0X1KSrmwdPvP4cTPZ8yR5wEThoJQ7duBbpg9KJ/wrJ0EHlkif/QjEW5FMOyHu3BYGBDuMvmbixiO6YwssWpp9+z4RjvlOC4WNOyfM/qmJ9gOWknI9k9p2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TH/+FoKY7c3PV8XjIsxgp+qejvaPEYIW4oNCd20vsE=;
 b=W2PwEn5g/iQeZAAQ8VWVDlQnfydT7PbDWDSkXbinmGf56hD5JFFWKd/UdAPk4gbAPhS1aP80ut1SaWHf8zmbH7sYpji+niH54fbutBxvwZUlHb3aM4aM6d+lpTOW9s9Veb9FB5/woC+XLDKtbSqWFhw9cuyjQYzhFR5JNuu5Vxo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1642.namprd12.prod.outlook.com (2603:10b6:4:7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Fri, 26 Nov 2021 06:06:42 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 06:06:42 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: Add warning for unexpected PG requests
Thread-Topic: [PATCH v2] drm/amd/pm: Add warning for unexpected PG requests
Thread-Index: AQHX4oYJLI35RziIA0mzGLBfTRiCiawVUmyQ
Date: Fri, 26 Nov 2021 06:06:42 +0000
Message-ID: <DM5PR12MB2469DDCE2F7799E454AB47D2F1639@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211126052502.134980-1-lijo.lazar@amd.com>
In-Reply-To: <20211126052502.134980-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-26T06:06:36Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0ed88b68-2503-40a6-b078-d182a24274f6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-26T06:06:39Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 8250b7d4-e099-4ee6-b4d0-5fa3d537bccb
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4e70951-c8a7-47b0-d058-08d9b0a2eb0c
x-ms-traffictypediagnostic: DM5PR12MB1642:
x-microsoft-antispam-prvs: <DM5PR12MB1642D3FFE01BD27255A9432CF1639@DM5PR12MB1642.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x7PXTSZ1WFCMTyUyFM0MTqPCc6gBkiYYnLKHYUsL4AYjZL+yDLPJaAUfRpafH4mPr6RUWcwFBZpLa3ZBjXvD4WQiqwBuhDP+43FFb86RkqA1aRKMw9UU07v/xcESPTamk5BnBsVDlPT55VF10N5mRl/VgJ5K540in+fUbkTx+MNvWuSwPWAYswB/by97K7eAzTXJ7Cmr4COeG+6Ls2qtV52sux63WeiAQUJeESxb+rZAWgAMA9NRDLciG+btc3GFzUY4dWq3gauHE2EQ5kxTmtzgzwcJ5RYMsFoYaZCICwFL2RrwGPx5Er53PaZRtf6P7S2h4LjrbVbhCuBI08ziNc77cOLyk0uxmAoztZ+wVr6bJtgsAD0LCbU0A+uAiDziE24BtFghz2QEQQ40zfaxfI6SdQVNzJ4fRxyarASlL6rTjch1CQ9d7fphZUVzF61bKkx88tDcdBUp8ZJNlLIcfwgichCnkIrU5oHLqrhqN/dl9z03s5eEyPnmUesfC01xZv7pQ4h27Ap9hlMqKtikibOxbYEm0HpnlIzXLoFdGpO6dSpFzQbRfQhHSsC09G+dQ5J7hAIqGG7/wvHFADsFXdZ6+dELaAdEQkU/LMa5cNs2k5U13lc+IHeeau+ZVbtQFHvnOe6+5BX1ZZKvdfORI6OmbtHd9nI8qrIR/9QB4q80X/9LJFGTEMmzuTETuY7pnkvRVQhWTxNMzgWuRE71Cg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(52536014)(8936002)(5660300002)(66446008)(66556008)(64756008)(66476007)(66946007)(8676002)(508600001)(76116006)(122000001)(186003)(86362001)(53546011)(6506007)(26005)(38100700002)(83380400001)(38070700005)(33656002)(4326008)(7696005)(55016003)(9686003)(2906002)(316002)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kCtnGD8wqC1dh7PC/N5LGft/Po59l4HVPGAMhhTZN6RLfZ4skWxPtYE/WdqT?=
 =?us-ascii?Q?ACJtwRCPRZ+L1qeI61sCEKfEruw1Xmyk/z8Z/75VfVCeK70yLeivrBQOhp7I?=
 =?us-ascii?Q?VOpwAXbfGfTkUNTxj3VoIDOQR7Ed/a1YzXvWbMNOVj8pCQ7oSNelrGV5XOSi?=
 =?us-ascii?Q?oiItiX55c3UNypflmx3QuAeApHTXxyPQYpKdHFbVtuu8VNrHcRvQRkvXMswU?=
 =?us-ascii?Q?qFzlzK9PCdbVKyYEoWKAY1uPfoLZTaYgHM6Ic12ZPBkQh19RhWXYl+bvfHtw?=
 =?us-ascii?Q?dIdaohOtF74BXy8qQsvgJ3DE6tLusD2z5MvSwU4vQq+vZODSMccXb/fDKCpn?=
 =?us-ascii?Q?Igk6LeXgzgxpslYYaxyT95hnyrnDmkAZeDNGJ7g5tz/FN/DIajyg7KgYkMnf?=
 =?us-ascii?Q?CLQeBDvaafmROn8cFECmQ1OijIsYQXvkJCQpSNl4SG7bPJj40RG6zEsOKmPa?=
 =?us-ascii?Q?1KpS7+YoKD0xW7hhMCRyramx/xF2uJlL0fjRh5aezYenRQaUQ6cxJdfULhJM?=
 =?us-ascii?Q?RUCpmkXnl7ZCGa4hCN6FbZO4eA0o+zXtE4rjtkf285cBA+1AQ2UqC9dd8Zy7?=
 =?us-ascii?Q?vtfzIsxiU5hwTogNL9EjM+IRUPXKP+1gNx2iubgMqCTbIRRekLV6WBXDgBl5?=
 =?us-ascii?Q?7B++rfzcdeHFDXniPFP4HPsBAFp7Ypnw7Hb/DEXZrgLSblr0NjOVbUQah1dA?=
 =?us-ascii?Q?tXTIQiggAy7k+4EaaxuB+9mtB3ypRYIEmue+WOr1C6xqyOknxsCpFsF8KcGX?=
 =?us-ascii?Q?XMbO5IjbJSvomuIDp8IBbq7YpEa+5oScyck3redEJGmR5MvFyrMbmcSHZlQy?=
 =?us-ascii?Q?5jvqoqeSFCVUPhR6mKqwyEb6EE1qTTVtZFpgLCOmYwUAgDqh1scCnsIXGIC6?=
 =?us-ascii?Q?eoAmuqWvyE0ohdpmnCgSEaR3zzzwY1riviAZesEvaUPgCH0kEHKvk9z0xAAj?=
 =?us-ascii?Q?5xccDQ+MUEsoLrSJsRvC+jye658GjJVeGT33V1DDJ/ZKnapYgmf11xJk5IxW?=
 =?us-ascii?Q?Fu/UtgaQ+DBY0qjzEBfdOU1vWZp7GCFv/Mb764z23xlffDheatOhwdf37G7a?=
 =?us-ascii?Q?llseoSS0/dLI53sWA96o3abALCRdlUcnIh40TfWTFColDtO7pDFxqQ0xxZDw?=
 =?us-ascii?Q?YaTN3s+9pWVlDMb6rfAcSy+qkwgjeuGuAnQUr8+Ei8QYBYiwyPJJZ3NL0Z5o?=
 =?us-ascii?Q?kvWjDNQA9nubBRUR+3L67SvJbrD4cTgGID2lO4ujhcRuIvb07cNRhx8XxOF7?=
 =?us-ascii?Q?MlombkCxgicpt6OEvTSnk60sCBRN7a36RO1ar+tl8UKvuzoIsluqQDUfRq99?=
 =?us-ascii?Q?1kwYNCk9RpA6WCHZYavGFAz3wOU5Ax1xn8NFgjWyEYX/JQ46LGtrg02QniyY?=
 =?us-ascii?Q?crJhS08QiP4JidO5tGf/2rfZzf+K5ffa7RMIHVwGK0scQzk5Zjs7bclAREgg?=
 =?us-ascii?Q?15RjxLsvb1jn2FfgxO0h6valp4xhyb0PsOGHic5zUKgmgSK3rYBG24Oi/iX8?=
 =?us-ascii?Q?xG9YwRdCQIGrc2x4qhafmbi5nm8tWS1ITOolD/V1WmlZWT0MKZ7+YDyujXga?=
 =?us-ascii?Q?JaMr90Tvf0oVd9gI0T0he0xeiLUqAd3yvM0wRvfSI62PHJ3r8NKnx0Hg8bFZ?=
 =?us-ascii?Q?U2EjlteWyK7cVgA4zyk6H9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e70951-c8a7-47b0-d058-08d9b0a2eb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 06:06:42.2502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4Bkixwea0PsSpqFvUsjx7fFm/tgFnbs/2DGoEEJiQ2mc+1wToyO2pEU7mw+kTjBeSATvLe4Srf6XzBKEJ6Zog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1642
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, November 26, 2021 1:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario <Mar=
io.Limonciello@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH v2] drm/amd/pm: Add warning for unexpected PG requests

v1: Ideally power gate/ungate requests shouldn't come when smu block is uni=
nitialized. Add a WARN message to check the origins if such a thing ever ha=
ppens.

v2: Use dev_WARN to log device info (Felix/Guchun).

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index e156add7b560..ea99afb38d2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -277,8 +277,12 @@ static int smu_dpm_set_power_gate(void *handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
+		dev_WARN(smu->adev->dev,
+			 "SMU uninitialized but power %s requested for %u!\n",
+			 gate ? "gate" : "ungate", block_type);
 		return -EOPNOTSUPP;
+	}
=20
 	switch (block_type) {
 	/*
--
2.25.1

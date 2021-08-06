Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DD0C4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 03:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3ED9610FD
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 03:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3ED9610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B786EB6B;
	Fri,  6 Aug 2021 03:00:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE076EB6B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 03:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvCCeKlJ05V8ZBP+GY985URiBM2qVwX2XlrT2chAnencIfW9kTXqaykODRA93zlgJvCO9XC152W73DzWcKLlL5OHcUin4qDGQIjWWpI0aFze2V2puWxKKLLK+hwxyt+RC/YLT7YQlfHVjHTmN++KSlwqR3JOBH5ymqnwjaDAF6/h0cbsaN4BYcIAgemSh8aiTw0iCJeYWAnwq9f7ZaCi6TSf1Ivc4iz3IuwRyfA4RB3f8RpNS+GhPb5jqHLisGMMNv33RTrYxoLBG8IfUJP1hiLPmRu/T8EmJhHMTTnmeZkk10xl7TymGV72x6GYQvKvvsPNEUPS2QwhRu4cH7l/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX8widstp4qchniqUY5DWTWZr1l0vkiW8Y1iuskJ0mo=;
 b=Rp77qhqvM6ng3Iih1AtvCHXos8aTpIEomk6D6jmJtQo/6P76k3kHAAVo45xDnq0qnFqc6d5kjxI5QocvfdydyoZpnnJ5UfZilDl57feuK0MFFDKV6Y6Bft3y1wGPHiC6htAJxzEV30zNAyNyQH1wELgJ7Dearyvi50Wbv/Qd6381Jobhp5Cv+IoX71tt+LXth95FrGWj5NJ0+AacF/UE5j315fbTVCW8uh8j/mxc2H9K8IyiTketxCAcy9hJ+kT5lHuVd+jmU5ShalzMWneX5+74afWQe5CKfbQVaNBH+D1Mx5ByO2oCbV/s8GvYwqscCt4dVKIhVAE3g6risrhupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX8widstp4qchniqUY5DWTWZr1l0vkiW8Y1iuskJ0mo=;
 b=beRkcAQPlkMFQa5OKAWa6gIgt5Qd/yqc91FS1jpfWAtr0iV2nIvCIcO6umpoNa7n9DHFxoic9oV+EFxVlDx0/rn7UAFzPUzUCzord3Bllo0wO/Z08hW2T830AXKYP8/pDGalJfBh6CZfM4CIc7Alz/xaYtDO7QVvS0gMnHKobVM=
Received: from BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Fri, 6 Aug
 2021 03:00:05 +0000
Received: from BN9PR12MB5244.namprd12.prod.outlook.com
 ([fe80::74c4:7446:14e2:1439]) by BN9PR12MB5244.namprd12.prod.outlook.com
 ([fe80::74c4:7446:14e2:1439%3]) with mapi id 15.20.4394.015; Fri, 6 Aug 2021
 03:00:05 +0000
From: "Gui, Jack" <Jack.Gui@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: bug fix for the runtime pm BACO
Thread-Topic: [PATCH] drm/amd/pm: bug fix for the runtime pm BACO
Thread-Index: AQHXimvqwfRitNW8+ES7zSxyxWDqR6tlyTuA
Date: Fri, 6 Aug 2021 03:00:05 +0000
Message-ID: <BN9PR12MB52442644ADB787D11DB91A558BF39@BN9PR12MB5244.namprd12.prod.outlook.com>
References: <20210806023523.29078-1-kenneth.feng@amd.com>
In-Reply-To: <20210806023523.29078-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-06T03:00:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7e84ff9f-63e7-4a28-a7cf-9e5ab0779475;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3089e3b-bca4-4bd6-edaa-08d958864b18
x-ms-traffictypediagnostic: BN9PR12MB5322:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5322CC211EC898DACF144BF98BF39@BN9PR12MB5322.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3twm6hAJVYzrmxsJiErvseZerjTCSsdR7rU7YSGsaqrYQo7jaDkunPTVy1/qJaBG9tnQHrqO5MmilYUfo3ubIS3EKBRyDJnY0R59p2uEtLJn0BMDCO9pF5GbHtdDfBsCEEM0DTdNuO2boQ9hKfIEsytr/8HOBSCM6n1klVntEJ85c7eJszQei/RGFLTVPay3s/zZtxcWstaqFnZSDHKfnIwoHkrgIUsVyJrwGuNP7jliR31t5e+qPhYbgzch8Ip8NxcAkiCor3AasQMqK5p7Q2n7emtQuRfqueWpLGB73NXOmQifhV5yG2q8nbz5g18P2EhCQtVKeetq8OrxHQ//a81UkL3OI2nOciIJl3uoxwf6q1UZ64d7gd5mu9hT2l+8kqR8vft8gSf9GGnpzJwMIILiJ4JtzBSIgVhAKlkfTHH32m48gjyEsIuldnrgKPHzyQlmZ/CHzair1JkMdeE24wfeZS32D12TaoZwRB7xBVzqwVl9ny4EuNPcM0yHn8wc/0NjPb7WxMTr2Sj3AfH7FfLAN1KdKwZpcGA61q2UGYB3HRceu7dFRGufLB9h/80s/lpVrcls2lhhDPdPSjZp6nTyVjuyfo/9z9JDxp4Qm8nvw7hn68l8nKPN8ID0CEelNkktmt+b/TtBYI6ooizBoU5EJ3F5HrKYCY87tvJyMu90MBbRUUifjk2AeQzl6BddMrhoA7DmeOJpsG1MzLtAwA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5244.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(33656002)(52536014)(5660300002)(66476007)(508600001)(8676002)(26005)(53546011)(6506007)(7696005)(8936002)(186003)(316002)(110136005)(76116006)(122000001)(64756008)(66446008)(66556008)(66946007)(9686003)(38100700002)(55016002)(83380400001)(71200400001)(4326008)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h+AAgsVD8sgvvdnpdYQLJHlLEoh8cGPewjSfDm5W5XhoMASvLATrfx3E7nRg?=
 =?us-ascii?Q?IWDKpsLta3pW+SukDJuPO3GXH3YYba85Pj0pUxNrtR1Be7oU1XxaZiSSJSLF?=
 =?us-ascii?Q?d3K6V1xB/6zEvo2/OPZt8JVT369n8aPaTK9vcKORo1GrrOmJ8X6unWS//2gR?=
 =?us-ascii?Q?cZRBEMvzV4GR+hM4fSslUr4bc9xrJt5+nuvphWyJ2CpKvWNtQicGf1e9imZs?=
 =?us-ascii?Q?J1HReZeFk7ocXcuCS+geceRH1bkgk7ijyFJDse40NI13ELX1tlE9uiCCoipb?=
 =?us-ascii?Q?1USZyXFR1AozgaE0iLffGMIYlP82/uhhzR44NPOkg6EGZIxroH51tL3emgSN?=
 =?us-ascii?Q?CLUKn7nzi+dJDQiDQZpViTuvxZs9YYof5JfHvunM7HHnQznx+xxh/Wlb6Nac?=
 =?us-ascii?Q?bp6EBfzrqFKoNw5P9INBsp57kZDKNsxA6qheci5NbtdGFNpgLjHFVlzV9rXe?=
 =?us-ascii?Q?5bjVKExX3Lbi3xnZsA2L15YwIXYjBbH18+NJ4V+jdJE9D3BRyKlf6e7mSovx?=
 =?us-ascii?Q?anh2FxRyzPbnIXOCQC5dKKp+VsHeQBUWxuz1VQs/ulbgoaLH9fmf+E16gUH0?=
 =?us-ascii?Q?2f9YJGgfuUpAwPnaQdPWyjFL/RepddyKhVJhFTSCClCok9Endt2VFtwx2Upf?=
 =?us-ascii?Q?alJ7/tZV4MN2sj0qYHf4hDfvPLYMBMqAhi2C8Pev5Rpv9ST3k1UZFsgPjHUZ?=
 =?us-ascii?Q?cVrSyxpyryjk23wWAFSGUg7XYpQ1Dj/aSreH6E7AdTaxw277OfyYALA3SuQF?=
 =?us-ascii?Q?W+nbOZkY/POqgv00FXg5Fx6dh8pKzpQyIUt7RyhD2xT3L5m+Ia4ltwUg3YaE?=
 =?us-ascii?Q?rY8Mlmgs96epZNV8STl0Cqkm39WRUgYL5s7lyV2Nk39Fh6TD+sCfsovjcDUt?=
 =?us-ascii?Q?zPKJrZ7rbakQrp2K2YBCfom75r031vQ2xok+JIxVrxZEuhcuuLO8gSWRpGw+?=
 =?us-ascii?Q?OswUIvxyGBQObwzyxR4uXKQVlJlDjswmhSPz0XlyLLzcGLsflTXdMZisC9+r?=
 =?us-ascii?Q?ktrhf0/Kc9/djV4VAhbz6P29Unn3WRL3AGdHCu0M2EnJTDKvY/Q+UmwHm28N?=
 =?us-ascii?Q?BwsHoFUarZO4mo8OFOvt/b1qiM/HpyXBZFx1ZdUUdqoF/u1jBE9pQv/RMmzH?=
 =?us-ascii?Q?e2TqF94k0ez8QkhqxxKS6mEqiDUJo4onNmgil3QBjTgSGBRdTPKXpgJIQiHO?=
 =?us-ascii?Q?IEUw6BnKAb4huAseSe1r6nEQDc+fiMyeuOdWATdUSb2P0bwM43LGF35jXpoN?=
 =?us-ascii?Q?mn1GBI5ZtV1qasl8UDQy3ZoxoW7VhmWeouxUZ6ZP1gEmHEgyF3J2ptjISE+9?=
 =?us-ascii?Q?enPyRcAuCIM2Nt/QV9IfXyCZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3089e3b-bca4-4bd6-edaa-08d958864b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 03:00:05.7875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MaxAqOeB5KGL+38Tt7p/4KSIcUwOpuOfkpq4Wzh4vIIcxPYJt+IDO+Fh0Cxo93I7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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

Tested and Reviewed-by: Jack Gui <Jack.Gui@amd.com>

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>=20
Sent: Friday, August 6, 2021 10:35 AM
To: amd-gfx@lists.freedesktop.org
Cc: Gui, Jack <Jack.Gui@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: bug fix for the runtime pm BACO

In some systems only MACO is supported. This is to fix the prolbem that run=
time pm is enabled but BACO is not supported. MACO will be handled seperate=
ly.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 90e40aacb8f6..261ef8ca862e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -353,8 +353,7 @@ static void sienna_cichlid_check_bxco_support(struct sm=
u_context *smu)
 	struct amdgpu_device *adev =3D smu->adev;
 	uint32_t val;
=20
-	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
-	    powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO) {
+	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO)=20
+{
 		val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
 		smu_baco->platform_support =3D
 			(val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true :
--
2.17.1

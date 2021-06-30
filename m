Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A73C11F67
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 02:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3B161D70
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 02:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3B161D70
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA1C6E108;
	Wed, 30 Jun 2021 02:20:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF806E108
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 02:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD5lil1Q8nbmnoyVy87vssdA6FGQ03j25XBg7JuEYLg6e51PMzBRYrI6DZ40ZFGEzJqQ5gernr12NZiN2Iccp/4gMYpclw6fimPARM+0oRSqPrcVdaf1/U/JboQ1bvCneGhLoWvsYPcqkdVaiJveN/nWsLNyjNRpGVi6Op5C2gpa7nRmYVHPNJdEMKyeZfH4/BwQ3ubpG6E25FXd578x9fLyEVps/vJiPoRUwIWIdaEX0yw3Fpti5+myNetkBjUWnU2dYEgy7pIurOdUfaapaOYMmf256zo9jyFEYeGYfS4Ea6qwxoZPEBd0/FKpEcEIErCqysXxGR6cFnnaOY8+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEcfN6dF221GUtBytmufHBiLyJgY6xHcfW3ZAoSOlqo=;
 b=A/RJjRbGjh8dYvemfK3EkmYqJTSeWocmd3WoKtT5gpLsvqzew9cgo9t+eBOcG8EU8rMoVquWRvWfPXlMyJ3jHyeWJtFwEWXrnVAR6fquG+lQwGik0yHRGoXduGjO1PPQ2fTmQat6NPJ6IJ+hRkpRVvu1iaCJagx33rk91SHqZTSI+wyEvs8fE5lBdsDPMj4sNuziM7x2jsuN+wpqtVJH9djtdmkIhtB11UNL7A4HuA32pSZ+/khlRiGNtyI93LCcwKGzZMtqOaTxW4VdMwduYY63yjPJV9h9t6AfA90ehZIPiIZJqR4A1FCSfPqr7sqgXzK7b5aTeRIiFxoROUdjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEcfN6dF221GUtBytmufHBiLyJgY6xHcfW3ZAoSOlqo=;
 b=ORNE13ppeCLPhL5hOAqRv8aYpUTjxdGvhS+637mXMA/vexMpbM4fvualKmuf1rpCc2xLHY9Z2jnQK2yHVIMERDATNeVooydkCt+eOLqRFgd/17Fx6LNDshUV7AWQolGAUCoGt3pezHofI12+NIpYEYH4E/ISldr4YqJxjtOAQFM=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 02:20:19 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89%8]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 02:20:19 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Conditionally reset SDMA RAS error counts
Thread-Topic: [PATCH] drm/amdgpu: Conditionally reset SDMA RAS error counts
Thread-Index: AQHXbUZl8+CTVnQG/E+onf1Gah8tk6sr0gRQ
Date: Wed, 30 Jun 2021 02:20:18 +0000
Message-ID: <BN9PR12MB5226179195B5E54259D302FDFB019@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210630002451.13214-1-mukul.joshi@amd.com>
In-Reply-To: <20210630002451.13214-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-06-30T02:20:09Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=50cf162a-a9e8-4c9a-a3a8-3eec16780ceb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5524e924-4776-44c4-ac8e-08d93b6d9b30
x-ms-traffictypediagnostic: BN9PR12MB5339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB533982F90BB35A91384AE7D6FB019@BN9PR12MB5339.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:268;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Zl5xXnD/azXXJouwvuHZ+2aHOC/BMD8WRaD/R51j9xJl9coeBu/7shRVkGOf5xtcgbK+EH2X9aWNiGbTgI2BdNiqvx52OsTlJuWHwpUZr2Ifb2ENLb7WdryqZuugK6k56iSK7x9XLWtdgZfPkdMMdJBPYjWTXP9SC9daYJKzN71LQLVg4uQ2k8G8ejSLOA0xZfqE8dpqj1YG+VQJAWtrrMD93/44GeA9/MUywrLYMUGhUO2WecKdW3fpM3JAAhuGrEvTNwNVOneXzF3nG95Kz2njmXG0E+/jnRzjig4ioBmwRY12G1atJfPRM+dLGS19AGdot9xcVJo7R/6pfUYG//XLrgqW3StT3TJbDmbHHNfNi86L7AuyZ6nBMqPSX4+pTTd4FZtmtKSnt4GFb82v5orBmLYIw1943x6n6VIEUumZ1RVeulH1NofqwtEh927a4d527KJo057aIRhZ0gYCNhVkvvIm7/JIXQ1h4TQQSj3EaMtWHA5Az83AsHeTkYy5cg9gbPSYZwJy9DIvyVyDKAOEG71b7fMcLi6mdWd77b/x8D/IPBGafaUjhAdGfch3rYyOWE8sSPRWc+SmHQ8SfwELv2e8QFHDfIuKEmjXBYdqcKEMK/puzodyyyBxPZnIgZft3lcrZ4Ak9XOLnZPhg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39850400004)(396003)(366004)(71200400001)(2906002)(8936002)(110136005)(4326008)(478600001)(316002)(38100700002)(8676002)(122000001)(33656002)(52536014)(6506007)(53546011)(76116006)(7696005)(86362001)(186003)(9686003)(55016002)(66476007)(66556008)(64756008)(66446008)(26005)(83380400001)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RT3gEWy6imXRXztQMnuWJ3Idi97DwTBYpTEk3yWmEYc/D3US91vB2zz/f7++?=
 =?us-ascii?Q?KUAfehU9fPVN/r3Qn1I0tQHHPh2cXJI1S0FFgwKsX35Y17620pxmx/G97h87?=
 =?us-ascii?Q?/gGaejfzwKZ3Yseyvr13w3Up17e6Amg8BFxaLVxEgakMvfyh7z3DkdHJuwDL?=
 =?us-ascii?Q?f7ialo5CZD5uXwqvPqY/ZPBcQ5exNngcd4Jt1xHNJR01c2ikoGHbLvR1bsxi?=
 =?us-ascii?Q?r8EinmL6KcaQWEWwm/RRNJBQ+omkwE7U5e8bRQOJnG3fuza+s/nPZYCVbsZp?=
 =?us-ascii?Q?3eGFQTysAWo39xHCz4NYafBUSzwoDtGn2y+ic4wvwWmgywXhkEOUttYeKz4E?=
 =?us-ascii?Q?zPxNW5L1VUNMsX2X3dAO2gLtMe/kOqcZwv6VPN98n6w7n4J9JAlkiPY+WIHN?=
 =?us-ascii?Q?167a8o698DH2ZeYoCStlzehH45aIaMPh9xpUevGUhdJothIvQNHJD++iMwIJ?=
 =?us-ascii?Q?t5jjQNjEONie9u3bn2baBUUVpeCqP7IzyLMxvbp0dHPcOfmiMwJlnWjFE3vu?=
 =?us-ascii?Q?3GNwIydWnEnWB/jeWmmCJmEbBPKS7QtoDwJTRri17toIZ0V309x6+CwbtvhM?=
 =?us-ascii?Q?ZCP8+7AcRwjs3qqCEcjwpXlwdhN9NOUpRtqcTY2qeikefzyAi/+hFSrkd3MF?=
 =?us-ascii?Q?qfs2o+gKQiae4h2A542VcMdWENhotRu+05oerS2/Xob1gcKmmxg9vP/eSWe2?=
 =?us-ascii?Q?b6+eAc8ttvbI+nRai0991y5dmSZIsYg7gjYrgkv9S81M+ATU5hO2434JvPY9?=
 =?us-ascii?Q?6XGG+pBiD8AD5IRu70PB/L6cQFiyF6eo8Qx/ff87AYuSjPTYjQG0dfsFNiV4?=
 =?us-ascii?Q?LV7SFr0If/iJ/og2aBWW12tZu+/cxtVHTqmAZ69MedFAMsQnKNlaOq9LNa8P?=
 =?us-ascii?Q?JJKF+P/2UWaQ8LPkHg7GcJvOozbnBROarRQf/uidtrJpy5tJ91UycwO94tlj?=
 =?us-ascii?Q?vjj4422ihqVYdw9lvV5PYjbaqh4QFk4Mf9rcZi74YsUaAox6LhyG8gL/87ay?=
 =?us-ascii?Q?5dkRqf6IXCBfZxprNibAxuzoHVKIQovO+tTs30pgbmqL0CwV6CIbhXYcl/Ea?=
 =?us-ascii?Q?SfrQ8cK1UH2gMXxFkW1GGJRBW+0tFHhnFjM74LA/e7rYVNixB5kYNphuYvki?=
 =?us-ascii?Q?pLECBv+PXsuO+6rldKY8zlXJEW0XHWXao+OXNjC7+VFa28fjw9j1+YPh2PdH?=
 =?us-ascii?Q?C5FCdS+D3QA8oTDQ4RF6XVAiX9cCrKCI3UjhibX2oeAfjySUPyAuiDAWwvCq?=
 =?us-ascii?Q?CoB2AYxefgYHcsb5M261KiLkCrEW98TmYO460hr3Z6o5Dw1bFcm+aagfDNEC?=
 =?us-ascii?Q?pGUx56kTi7QyfmduSTSs5FZc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5524e924-4776-44c4-ac8e-08d93b6d9b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 02:20:18.9712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q66P63dYnHOrEF5+8ITcETbPC/9sEOennFnAWVxYlCkjiK3jLzAErkBNNZIEJcw+j3KRj8+wbIJRtDTbg29ctA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com> 
Sent: Wednesday, June 30, 2021 8:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Conditionally reset SDMA RAS error counts

Reset SDMA RAS error counts during init only if persistent EDC harvesting is not supported.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f6881d99609b..8931000dcd41 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1896,8 +1896,11 @@ static int sdma_v4_0_late_init(void *handle)
 
 	sdma_v4_0_setup_ulv(adev);
 
-	if (adev->sdma.funcs && adev->sdma.funcs->reset_ras_error_count)
-		adev->sdma.funcs->reset_ras_error_count(adev);
+	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
+		if (adev->sdma.funcs &&
+		    adev->sdma.funcs->reset_ras_error_count)
+			adev->sdma.funcs->reset_ras_error_count(adev);
+	}
 
 	if (adev->sdma.funcs && adev->sdma.funcs->ras_late_init)
 		return adev->sdma.funcs->ras_late_init(adev, &ih_info);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

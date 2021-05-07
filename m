Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71259C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 13:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12F66145D
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 13:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12F66145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8856E07B;
	Fri,  7 May 2021 13:05:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1093A6E07B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 13:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/7360DPUlPe04b1FQIU144COzAz3DCfZTByaboHhZ4wSSk7cQlOMFbDbPpVcJWCjgw8poeAMfDwTSLUaE1HDCcvkHLmELJWl9WgpIBJIg0ECa0/3GOlw3Eefm2/qAE+tI8bPZCykC8YrLvIhD2HIKn4WYJK9iHfwxPy8Z6mBtktMm0Nq+UQm8siiF73F0F9I43nHn87OPFcFw7jYwyT6XxwUpX/ahFh4EyGXIkEgJF9Wjs/ayQWO2KE5LG1iw2/B0OetUoCM4u4f3KKd0EB2FWO3z/jEpqdetL1LjREl5EDX+0DCDBmSR8N0ZIhByfT7IZ2UbmH3rT6/H/LoD+q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WB0osWx3SGnJt1JCNLiPBPYOmFo1fpSBbh7KU7dYfU=;
 b=U/bcTVb/zS5kWE5LPH/VLUVJaeDQf/d+Kwddl4tIkoUqPK7Fpv02+hPgXrakSP8A6i/aBF211sDrZwQvAgIBBgXKMm3SMOlatdPxbpKGo6EL/rtBYokfrvSO8srVSiLKFutWk/ntGHJIqyhQ4qb4btefaMuqTV9j9GWQgK8yYWB+clLSjxYKjqthaZebTeC9LIVLbUm8cbqVZtU5EPIvaBlZ3Bh4a+IJIQMDhBIPlbMR4qcIkA8e30f1aXPx4EDm3rgWp3gTRh9RnpevLimMg1i568+lyWx1YzZM8HNOZzPgsFkV5BY37PUjub8FLU3pZRU25Iaz7q4qw3gnUN/b5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WB0osWx3SGnJt1JCNLiPBPYOmFo1fpSBbh7KU7dYfU=;
 b=E5StKQrtgHIoeA3qozHd6DMqyFkb3MGoYguEsePF8W5WeqVUYCXuCeT8G9Tst2zWeKaskl1MCt9qxepSNKhh3IMqMIs4DX7hB70ROzYYtoRv9qxcQ2097QqgpOsillZ5xM7VnKPEKJfU8v9qmYsrJvTlxKB0wfTE35Qv5dPAMwk=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 13:05:36 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4108.030; Fri, 7 May 2021
 13:05:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Quit RAS initialization earlier if RAS is
 disabled
Thread-Topic: [PATCH] drm/amdgpu: Quit RAS initialization earlier if RAS is
 disabled
Thread-Index: AQHXQt5lHxTwcQyoLEKnPHwctuHzQ6rX/SMA
Date: Fri, 7 May 2021 13:05:36 +0000
Message-ID: <BN9PR12MB5368CC933FDBA85FAE4A9391FC579@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <1620350085-22406-1-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1620350085-22406-1-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-07T13:05:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0a645886-85da-42e5-8ee4-8423806884de;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae3ed6af-feb6-4752-2ddc-08d91158ce55
x-ms-traffictypediagnostic: BN9PR12MB5243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5243ECA8191719CC86F96E9BFC579@BN9PR12MB5243.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xavVIKbMuSHVhx/VFIRHLI05ZeJGLBGFi1Tko4Or7lV5JTe5lqmKC2F/AZk/MC9y7qKioE+knyk5XOuPPKYq5pLnHnOocYm6zcjnd3MgcON1GwHHnpq944tG24EQ2K7yLYD9/3ZWaPc1QFAPTSUIlSLxCk360Leo9dEtmB608ERZ+3Itufj7wLjarGlil+OoXvB/AZVEATWG3l40teoumoyv2Rm9UiMMeQweBqRKRiEseGOb8/0OVdcj8MEXsulURYpnpDXDxufSsXCalvA3uLe5I3G+lyCpZ87DkU20imO9biHiOcQGQOPjjaFhn6MgItstLzyQSRZ/1TVBnYIA5LBTEXxRHNgJxMOtpTFcAvoSMMrNlYr5FG2clGswasJhbqc7+n6IMJXvjk43ApN6fglB53fBNxsU0zcWmPdx2q9UtjcFE244CbPeWbespom9huUrca3p1GfxoBTzqAzb0EQIwUD8GKfZi4tHAbyk7IGFPZH/XY/sOlnGeU54hqSAX2mQ+aHHEoclTdw9bbS6EAvg4/O9mwEMGzd9n6XEbvS+d57atOFMf1/NY/S+gqAl4XVqTR+hNcJhAPTI+59o+i9IzIbMSEFwKbOXOavzo+w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(396003)(136003)(376002)(366004)(71200400001)(86362001)(122000001)(316002)(76116006)(54906003)(110136005)(478600001)(38100700002)(2906002)(52536014)(7696005)(33656002)(5660300002)(8936002)(83380400001)(6506007)(4326008)(66446008)(64756008)(66946007)(66556008)(9686003)(66476007)(55016002)(53546011)(8676002)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GidOr0ZMk56G+wXjBCPl6nLrdEqC92wsuP8COa/lo3eLiYMglOC6yTt4qEWm?=
 =?us-ascii?Q?S7BT9DiXY9pbq1u6biWohT8IkY7MAsl7phVPFcQxdn9hKAnK+Ga/UEID9rXF?=
 =?us-ascii?Q?srZbIeCv/iIx8lhzP1bcd9W4GWhlnUlbP8za3NYJHgYdnOdBuwTkJ5eEqxCG?=
 =?us-ascii?Q?v6b3hHzKS/eHhaE1fEdbrDupnQWn2HC2g8V6dFAIoW1cAy7v7YC6lPTIii6O?=
 =?us-ascii?Q?gLLPJ86GYpNLxpc/MeF1QPjX6KVidaSkailcj2jvSd7w3wxsRB5GQK8aL66O?=
 =?us-ascii?Q?Wv0hrBZ9QSDnywjE7iNGoms8+3f+mHQsyck4Slr4dBW9v4Yz63I/g04zkroI?=
 =?us-ascii?Q?GMoHxfcxE0DCYXuc0+r55DcQgNP2GUsCTQalEOmEmIu5xFBKctBSxcyuDcUm?=
 =?us-ascii?Q?pPY/m3kzZgoY+tsXNcW+4ooPNIGS5pBUw1/TDBcXxmV7SrTepVIBnyMwbBQE?=
 =?us-ascii?Q?LlGZ7TJXEcq/eqfTsFyM0MmHYh74CIfHfyxvbp90Odie/1Pxo0SVLXTQUpKY?=
 =?us-ascii?Q?n65Y119Hg9znVuBWGi0AeTWQ4kZ1GzfDVFTyucN8On2Q+AYf3UhWXghk6BEM?=
 =?us-ascii?Q?Wis9WoKv8MPrBoIDkOFqe5FKbMQoBBaZfi0ucVThTR7iyoWkvPPjGNjoN93/?=
 =?us-ascii?Q?TbWw+ZUpqgLh2Giv6JdqD0hHVAP26yW/Poa2D9n3OueDrEilP1TVe1bIgccW?=
 =?us-ascii?Q?QaXbn7N0dEvie245m8C9S2REZPD/R8dNkbu47C0Pjdremg7bUEKUeGa2R/2U?=
 =?us-ascii?Q?OKMcrRK0x1RIY4052f2Po8lRayqlJaOTdznN5u28GM4zUd3PCrV5ck/x8zgH?=
 =?us-ascii?Q?RZ7pzmBLGLAVG/1fuZGy6AdqMIbhz3jFOQOL16yjkSQGzlgFtbeVztFiE/US?=
 =?us-ascii?Q?krQx/BBlrNyGJeoFXRrkPMzYCXzlQ1eCs2uHB0HLjGN0do116q4V/c6tPGzk?=
 =?us-ascii?Q?jAZhDykuOHmriNq6u6hkxYlF2lhsnHBEOxdU4/MXeosT5L+RjlGsBUBTsTwy?=
 =?us-ascii?Q?m1Ayy3Cd0eZfDzt1Fp1Idlj9fxt6ARW/zPeEgS613DOLJqbjqnKqWr3K4ieX?=
 =?us-ascii?Q?FfkkQ54TGXoeIkE6ieG8AK45RqxRYjlPSpu8BNsStKlXom9U9HseNhRxSN+6?=
 =?us-ascii?Q?6h2+7j04TwhgOzoGUOq77ySI6Ek4xGxeNv6Botho4h895ltahK+l0AL+jTm1?=
 =?us-ascii?Q?lrEwcYRL0TTICnHVKBjLD5wSeBr7/lJy47xp5ujGFzDv64ILSug2+A/KuADk?=
 =?us-ascii?Q?pffI6OEtu6TS4lyFnzT2DUwpci7zKcvt6/rc4u/xhY5Jyd3IeU5wWLW6urTf?=
 =?us-ascii?Q?s9vRP607jTKP83WcbFoxp5Oz?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3ed6af-feb6-4752-2ddc-08d91158ce55
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 13:05:36.4954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+1bvMzeBy7LSgjW0l9BdTeYvQyvXN/7EHkQdpLf1C0ZuULKlzBZJ0DcwX2QagBDjQ+tsWBYqcp1HFV1oKNcrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zeng, Oak <Oak.Zeng@amd.com> 
Sent: Friday, May 7, 2021 09:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Clements, John <John.Clements@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>
Subject: [PATCH] drm/amdgpu: Quit RAS initialization earlier if RAS is disabled

If RAS is disabled through amdgpu_ras_enable kernel parameter, we should quit the RAS initialization eariler to avoid initialization of some RAS data structure such as sysfs etc.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebbe2c5..7e65b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2155,7 +2155,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_check_supported(adev, &con->hw_supported,
 			&con->supported);
-	if (!con->hw_supported || (adev->asic_type == CHIP_VEGA10)) {
+	if (!adev->ras_features || (adev->asic_type == CHIP_VEGA10)) {
 		/* set gfx block ras context feature for VEGA20 Gaming
 		 * send ras disable cmd to ras ta during ras late init.
 		 */
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

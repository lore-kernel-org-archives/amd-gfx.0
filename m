Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F791C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 06:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76BB64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 06:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76BB64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B4E6E455;
	Thu,  4 Mar 2021 06:54:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 911166E455
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 06:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvLygkncEPdSAQfcQWunAt8qs4JOztiZSQHneX59mi4XD1LYbNqelANY0y2XYymFNz9Pi7gHUTgNPdoFf3HgnnLP1eY1qzsrGYvtZCLRRtQvVU5VpPKoWcCdXEGZLeczbNfh/y/V6jdvuRcy+S3yGblXmagwF493mrWHD6BrORavrDHbRgSv/OcWGj8xNnBzX4/j50T0F/sANLC42E8N2cFhX8ToCYzX/c2wwt9zLv4tpqZyDBXR+RUuufw3janF+JL1cLLcXY58Rymwq3+XrlC7cNUR3m6KjTHR3PZ52uGunvQy9Z1ttpq9ojM/NPOmRe81wE5sIATqVGeHus3P/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC8hQhTHXG50p62FBh9C+GcShtjXma7vXQGM/mGfwaQ=;
 b=CK2Qou+T7nnFPvw4SUy+3tl/1441pRd9kp5NxYERATBbSSbIwDwE0ZbK8tsj9WnPraSzZQD/iBw5EqSi41CveOa98v9ZW9HOD3HkyTvW/rYEiQp0LVueJ3i66HbC6Se1qk/DXUtUFhhdJTpXMV1l7Wf5ZVbALQOw9XH6ozR/YtWgzyKXIiBK6258W1EF8CpMvDL8jce5h2njNpLIvD/UgjSUtCoQtNPYPbRWM3qsZBCT3AXUAax4PHHDxKl0Fu5kohW74rF+p8rZ914OQhdlRXr9iRPDmUdmcvBukAshvpMz7x6QM7rgMKi2GRG4hOI9+4YRJi4sIPQ/3A0yhcW+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC8hQhTHXG50p62FBh9C+GcShtjXma7vXQGM/mGfwaQ=;
 b=uyrRo7wQTtPDkCFMRFkTOcWr5gMc3ioqIXEFGJ56wkUY4O3acYsJEPVAZMpAPyyNHTbr76nHQF+47MQaVRyR89u+Eea61MZESl90igZtNQuaUiPZXVi2xd3jxjOXMND8hOEawCyVWwFHlmJTuq6l17nbA/UDiuSwCu9LYz7IimY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Thu, 4 Mar 2021 06:54:07 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 06:54:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: soc15 pcie gen4 support
Thread-Topic: [PATCH] drm/amdgpu: soc15 pcie gen4 support
Thread-Index: AQHXEKkHWKAOkqgsm0uJShJJrcmQ+qpzVG2Q
Date: Thu, 4 Mar 2021 06:54:07 +0000
Message-ID: <DM6PR12MB4075D16A2343C3AF0D846A84FC979@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210304034644.37610-1-Feifei.Xu@amd.com>
In-Reply-To: <20210304034644.37610-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T06:54:04Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=af364918-0716-437e-ad1b-6775e1a82544;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b75e670-9c01-48fc-e070-08d8deda4ec2
x-ms-traffictypediagnostic: DM5PR12MB1162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11626451509788419F9AEE45FC979@DM5PR12MB1162.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+W0+b/K7Me+U2JSAaeclTf+S5KV9Lj2W9Hq5P6jzg72ItZtqEKvFJGy1RFQ/zH9GuhImN1xfsa6thQt88xOla+JlBGHr+HyiBZpGsLNhsQP7k7FLZwoKqvG5HKWe42GvIRF58qPvl/8jd+fcb6uQSQ0aj8nUa/26XVOiTJcmaty03An40nRoTO75qmD+RUBoHy9Cjsr2nIy+mVjCzalpUCffhblZ9OfuET15W2NK+lgcOqZVQxwBQWG4rlkfH1r//kyhXUxAdc/mzrB3LktLmw/pZdlDCIqzVO1+kZpsPHddJ/i15Yrbs7nGppGjIeza1EmS7q+q98n6hYipDxw6jN5K60WL8v4BgFQFDHwsKj/+XU7iFSPhdUA61l16SULjMRFVQVoHIlRHhTXEvJKuFix96YfNtJLVQotpn6RwexbhG0H/6scybvwRtuXSJ5dImb7cQlmDSELDzJuh3rJi+C3+69fIJd30yg8ozo7g39O1qs4gi3CJeirTWpwUNB/DR73fv8zhsVgQJRVusiJkQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(76116006)(66446008)(66476007)(64756008)(110136005)(66946007)(66556008)(83380400001)(478600001)(33656002)(7696005)(2906002)(6506007)(71200400001)(52536014)(8936002)(9686003)(55016002)(5660300002)(86362001)(26005)(4326008)(186003)(8676002)(53546011)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Thj1b3ErYNP58a+pwAPl6+17dwd1aTN4JxBnw58fTY1qiEHYExnLS7Qo/5n4?=
 =?us-ascii?Q?sXWD79YfSiy6jhcPu19tYaR1bc5yI9p4cu5m8GHOhupnJYKV4Y56AbuNC8s/?=
 =?us-ascii?Q?ZFMHLYQU3A6y+VwOhfpQxzz+fqfLQGs/NfZidK/OkX6YbEwzTRnHJBonqLOC?=
 =?us-ascii?Q?xzR8yU8W2Ftr9kRCTXJKUn+BH1RYF3RSgCLtA809KL8iX0qUw5Zldwe7p481?=
 =?us-ascii?Q?BXHpeGzme04TlmcPUS9bv9ZwzaTfhW+8GDpFyvzsYcDXVOqkIQJI+wp9Dvsk?=
 =?us-ascii?Q?IOSju43NlyeuI/E+OyaZREO0QXw+T8Sqdzlp1rYuWnotXpnBNuZzrKMuGpQ/?=
 =?us-ascii?Q?Y8tk/IQb3GwwThZs7yCkkiuJ/+VMQjz+H79H/3ucV16hl2JMk5XZLPXOiOLV?=
 =?us-ascii?Q?GosIRAgWyfW3qlO9Ny0apQ0Ddx01AgW4qpcEbbAgGAW0Msfzpbio7iXC7rc/?=
 =?us-ascii?Q?IVYYdidxBGH6E/skqNPq3sbIJfi4TiO1AyjXzHyefCGIoXgSW/hHMA2gDG+H?=
 =?us-ascii?Q?2eGAjdp1O06OurXkQp7SxoJhMZop9hwAWJsV0n6ciW33V1QXSlBgu4dVUmkf?=
 =?us-ascii?Q?GFmbfG+rc+gmAutX+iJOZBeAar3mJebbgstWxNq5zdraR9SWVq/YbWz+Obe8?=
 =?us-ascii?Q?aUfsBdWNCN4Grer2Ov//+V9ymI//xqWHdxnCnESwsRL9t5QiB/4OfRqWVEom?=
 =?us-ascii?Q?tPWsdZwGU8eOw8wlKbk+tSwflPK+/Z9vS06yGYg8ZRYo+A5XpLfiXUbb/7MA?=
 =?us-ascii?Q?RvqjLSmJub2PKkJf0PzjShPiq2tAeE81s7TJ71ph1wVwsOYgHL0qJcEVSBNh?=
 =?us-ascii?Q?rgO8FUMCUSFkneNqLm0pdGj46SekpHxtdrr2aHTqHTFXNYMmcpDX6KONTt+r?=
 =?us-ascii?Q?v2N2dPbG5CypZBhZ6eBvBtUlfqtdmFbh/qob9EZHy4YOIsT+E/BwG9LewoM6?=
 =?us-ascii?Q?xPwWwdiMd8peOIIv/HD9pC7l6kakF3OLMLyMA+QQXCeW2IN01Pt+dIKJr39o?=
 =?us-ascii?Q?2ZOSBDIsftneCR6xnLHy4eOq7VPjCt6VYEcQKbq5qKkRR8riWYuW49HYDdNR?=
 =?us-ascii?Q?O7MkCTNCMqkEzYcafwR52tfopJiEIE4NMOGZQcsADF68E1h6IDq+JrJiDRX+?=
 =?us-ascii?Q?DBbpRktgINALCe+qVDcZOw5u7ow8/54uMDLXGtnRUFmJyir99ibVEBWrhbcq?=
 =?us-ascii?Q?BQSvSDeRSncUjJPVDy9wgZPb6vLR0ktB39C/usUVRfxQq+zzaqD99UgncEVn?=
 =?us-ascii?Q?Hk1aFgyz5/i47YXRdFhq5M99puLoK9EFu889WnN3bJ/45DaXm83bkMqiumbr?=
 =?us-ascii?Q?RBLlZOWcTJhZBrRVdmNo0ARk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b75e670-9c01-48fc-e070-08d8deda4ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 06:54:07.8048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: plHg2n+MwmXvles7k9du2nZTe90kib859NyJzK6WM/yX/mZwDAApIQ3bwHp+/hxiynrKu85fh9MQVni/9H4P4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com> 
Sent: Thursday, March 4, 2021 11:47
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: soc15 pcie gen4 support

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 28b991904eaa..437cdc56bdc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -569,7 +569,7 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
 	return 0;
 }
 
-static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
+static void soc15_pcie_gen4_enable(struct amdgpu_device *adev)
 {
 	if (pci_is_root_bus(adev->pdev->bus))
 		return;
@@ -581,7 +581,8 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
 		return;
 
 	if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
-					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))
+					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3 |
+					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)))
 		return;
 
 	/* todo */
@@ -1374,8 +1375,8 @@ static int soc15_common_hw_init(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* enable pcie gen2/3 link */
-	soc15_pcie_gen3_enable(adev);
+	/* enable pcie gen2/3/4 link */
+	soc15_pcie_gen4_enable(adev);
 	/* enable aspm */
 	soc15_program_aspm(adev);
 	/* setup nbio registers */
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

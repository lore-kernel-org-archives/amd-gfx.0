Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77D1C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 06:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97D8613C0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 06:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97D8613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FB06E45D;
	Thu, 10 Jun 2021 06:06:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7456E45D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 06:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoxEtmwmFjBXiiO0bSyFRxOmDT9e3co3GBeOvgoiq1nWWK6RkM6oBs2JLlzK6N2fXFTSKW1FvlXEMchoR/qHKUp2xZwbdW0l7cj75InaodUDyQgW0HA1pNLbGP6AV1MFszS/TUZiEz4LVFtoOZTenFQ+8aa254DqliQyrDKOuwNgTw9iesw2ZYoVGjU3SQ83twW4jr3MgvE5P8htlaEceCujLXg5dR+FrBHhN727+m1prTDToPpsmAOidZvDPqVA9RllCFqeniFimmhHgiwEMra6N7wbQ6matqoNw0YFfHz7g+m0YIRxNlg0k8VF1wGH5qPVTSt2Or/QpldO/jV+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyK76c0Z7/uFigOZAOXMdHMmAWdWyixU3noQXZMN+zI=;
 b=anlVxpCeT9wmuc0eTw35pkno4DPwkaZ+qFDf91EipHP73BwHE9GdtgHhxImIvcEqaerjPF1OUNnrFcFRJYlaN0LKzEYQtpaJCo1qKfKouvQo5g/11kVkDJPe3OfMmBN552fcm7Ub3iKYGbWsgf4/h/dqCRY1Eg35WSe0vEWe0O9TUSqcqcxW7Voqdx4HE7S74oo9dzwQMZQYlWpZlgoHdSGwfOe1DZVems2s4fV3/rgsTaQG94R3ied+EzyyUHV6OOSJs4MJPKBsdOrJaEXlExQb0Vx6v1Gj7JtaOGK5BgL0URuaSEquop3tpxgTIjkELbqU2hXOCfl2UptACIlwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyK76c0Z7/uFigOZAOXMdHMmAWdWyixU3noQXZMN+zI=;
 b=x4GPjj+aJLIZaeP7KWeNKiwE9/ILTzAyiajU3RVrfG6WxRQ/9U5Lljrq8jgaEKZ4oKcnOoTS2LHCHBc3AT3Gt4MLVytoQirU6D+KYRni5f3zaJuv6iY+tH7NNNOA0DvvhIOYe1ybxlR7cd/UFdvFQLDIHhdPvshLL6r5Ffl0xto=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH2PR12MB5532.namprd12.prod.outlook.com (2603:10b6:610:6d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 06:06:09 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb%6]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 06:06:09 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Pawar, Ashish" <Ashish.Pawar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: PWRBRK sequence changes for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: PWRBRK sequence changes for Aldebaran
Thread-Index: AQHXXWAMuPWpZT2wZE6I8VsqxQS8M6sMwn0g
Date: Thu, 10 Jun 2021 06:06:09 +0000
Message-ID: <CH0PR12MB5348B69B0D4183C73AC93B9B97359@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210609184758.2556918-1-ashpawar@amd.com>
In-Reply-To: <20210609184758.2556918-1-ashpawar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-10T06:06:04Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0b4e3e08-6b58-4954-8209-d3cc76be7d0a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.222.146.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 875617cf-47f2-49a4-d711-08d92bd5d796
x-ms-traffictypediagnostic: CH2PR12MB5532:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB55325DEE9496E98EFE8A7BCD97359@CH2PR12MB5532.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgKvYsPIYbB8nudlIBNEjv5DAa7l0EanzJgafgQlLZCosRKPcXmHCYRDo/3mWaQ9UHHv4l9JyUdqR0V9j85hUKjYaao4+PHNNsVetAXUj6Hiuc3BD/aUFfhmViaWl7qEGG2JRh1J3oVjp8pwlAFPfyrxRLild/eNBboQLI0qB9+Id4mY2r3iRH4oudfWHYnfWzLxNnQ9PABiAObN2D/GDbv9SdeQFFjFTAP+OmhDPBAX4K2ZcV9PNpMyF3cA9bIVn1Q0ppT7PJXpPRGrUj+2TP+SmzgK6vZaqjgo4oQWH6Yw3ph0xWUz786BoHdRLyCIcP1vnhOvhHCjzLqdx3pTbjJfE1YBzc+AC7WVwAgiu5ALaEjOeH4/akxwVESS4Jdiw7naFeVVU3HmBpNwg/Z8ezw6Iz2ceu/4jZH+lx0kkjdWxn8VffRPdxn3h/KQE1taNxwtBWWBeg0jlpjwiKpDxOHQEEOLrv3HZuVkvYqw3zbk40rnaOfm3HZmB4bk0y6uUyJx3VSIsz4s6nWuTyH75jBEPa4ckoBYZJt0FZn6BlIWyaHdI7DG+QpGHxpmTMs3xMHV6764+xfGYpObacm3VTyAALko3W4x84sbpToTycA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(53546011)(110136005)(38100700002)(6506007)(5660300002)(86362001)(54906003)(2906002)(55016002)(9686003)(478600001)(64756008)(66476007)(186003)(66946007)(8936002)(71200400001)(8676002)(122000001)(7696005)(83380400001)(316002)(26005)(33656002)(66556008)(76116006)(66446008)(4326008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h5onHf1vrySGqFXwqWc81jJmKaCihBx67XwbsxlNuec0NwsRtxInQTDJiKyI?=
 =?us-ascii?Q?QgSrgf78TYYOpMPp1Zmgvi87VkX+Wjiy4v+cZcRKOPv6rWPYRN0z/bNPbsJz?=
 =?us-ascii?Q?YyebG8tA//W5/Eig/GWwK59qMEEihXjnEhxJefyWhhzhAL1OP6Ou/6OaOnfc?=
 =?us-ascii?Q?VKcJyjuWo54gZ8eh48BeBnfd+De/HufPLaHyss1wy/3lbbryo/MTabpC9eY9?=
 =?us-ascii?Q?j+3KXWLAh7ZQug23Ry+TSsRcPFi7JnSp0uTYkG4nId+qwCLf/Gs32WfDzUms?=
 =?us-ascii?Q?1yOWIDBSIwKhUNAiw3/HY/CfwtbJRUKbKWNNuUC9xA/aJiedPsLR3B5tPiXR?=
 =?us-ascii?Q?9h/IBhBHVrQzObc3p3w9LqlSQz5ebbL3UA86Agm7JNMysDNDOmOF5kGHEpCS?=
 =?us-ascii?Q?QFfWEJbLeMFadj/3Oz/CSSJMdtuy1he8RSg5zOTXPsM6ahxyWSgkXTkdw/fO?=
 =?us-ascii?Q?F68qQtzMXyFFvlVoMJTDOVWsjYlEjPoHTenvKGk2osFIrAumenDNoIYBmysR?=
 =?us-ascii?Q?nWTvkeM9yI76GIFLXk3QfXprbm38B4Bjw55c88gb5BV59muwNWplpiOV1PG+?=
 =?us-ascii?Q?xgIqeU6RgmU5DB0jiosmpnrS8x/YSdbv55fKJRbaYvmOZ2+voULh30NSQtwU?=
 =?us-ascii?Q?oE8mWO/dyEwe0xdjG02T+9EC0SeZI2+CDjcnfmhRTV5gGU33NaJ00GIl3axE?=
 =?us-ascii?Q?sQjJGkXyAmCSfgryLBhmN0Jet3bHqUMta9W9mH4fbbPbqKz+dwAUuBFw2mEL?=
 =?us-ascii?Q?uB7n3Zxt9HWVCKWBEuRCBb5dinM+Jwf22wRJl5bKtOejhZLp7n3dZ6JL1j+J?=
 =?us-ascii?Q?MNdQul9Rcnt9GrIExK1a22zx6jipLXoVLPTCa868coWSXAbJVKFw37xUYJbA?=
 =?us-ascii?Q?rw62xBFSDHBlZt+ls4vUGp8JjirDlSrB9Ok7xQCdVdeKoa/AEtMHq4RM6hQl?=
 =?us-ascii?Q?qlR2wwyiYIkKNmdGNnkH0LEudlZNHxNvJiiXXLcxI9u9DQdWJlSuLHfREdrD?=
 =?us-ascii?Q?GbJ0gcdnCspchHB/FFPJsfXAIAI9Y4AyHMPB44U+8BlGsGS35j8iKPJI/qzn?=
 =?us-ascii?Q?2Y0/rjwVb8XegwDY3vZ37ns8maYKQayoqGTgYhQiZ6CF61DlhUsQOBJLjkpu?=
 =?us-ascii?Q?ZHvsYrHwEyXJPMuFWlibKcUAkXlDVEz4wY69e8YAOL0GerHKqVBmfSU/5iUM?=
 =?us-ascii?Q?HyaArbzlfFpM4IbHWV2JdkiG074a+LmBtibMXs/jjMRzw3AQOnGrrGivu/Zd?=
 =?us-ascii?Q?OAxL1tmCKBdpvsnLAfjHEVxHo7N1K5SoimC6lbdBHmzBJaPGmryXpXxdkcX1?=
 =?us-ascii?Q?oxX2FIR7UrkynUIN53yQrGYc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875617cf-47f2-49a4-d711-08d92bd5d796
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 06:06:09.3675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIFGuBs4E1N0RJfGUqy9Xqry1qlOUzvq20CwyJ42lV0Uywm6uJMPq/4frBtPrL9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5532
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
Cc: "Pawar, Ashish" <Ashish.Pawar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Ashish Pawar <ashpawar@amd.com> 
Sent: Thursday, June 10, 2021 12:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Pawar, Ashish <Ashish.Pawar@amd.com>
Subject: [PATCH] drm/amdgpu: PWRBRK sequence changes for Aldebaran

Modify power brake enablement sequence on Aldebaran

Signed-off-by: Ashish Pawar <ashpawar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index c0352dcc89be..1769c4cba2ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -782,11 +782,6 @@ void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, GC_THROTTLE_CTRL1, PWRBRK_STALL_EN, 1);
 	WREG32_SOC15(GC, 0, regGC_THROTTLE_CTRL1, tmp);
 
-	WREG32_SOC15(GC, 0, regDIDT_IND_INDEX, ixDIDT_SQ_THROTTLE_CTRL);
-	tmp = 0;
-	tmp = REG_SET_FIELD(tmp, DIDT_SQ_THROTTLE_CTRL, PWRBRK_STALL_EN, 1);
-	WREG32_SOC15(GC, 0, regDIDT_IND_DATA, tmp);
-
 	WREG32_SOC15(GC, 0, regGC_CAC_IND_INDEX, ixPWRBRK_STALL_PATTERN_CTRL);
 	tmp = 0;
 	tmp = REG_SET_FIELD(tmp, PWRBRK_STALL_PATTERN_CTRL, PWRBRK_END_STEP, 0x12);
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

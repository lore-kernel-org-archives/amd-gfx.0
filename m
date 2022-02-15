Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF11C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 17:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CB310E4D6;
	Tue, 15 Feb 2022 17:00:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA9B10E4D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 17:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na99Pa4MX/rU1XUdHBnxcbRsS0jDwXh/Q4n48ix2t1EGeK+s8TFO8+rFI9aELDBJA8pYRzBfAsnCa8SOHu8Mv60/PAPKfRYBrDrELFHaItvFxTzgM0PTSaJxrB1rjk8Ngty+W2GFZKmWll6+vpd3IeSt4Zxy0HlwbRUrZ+JxNa2ucWt5KavelTvhwmXdTNINYqv8vrsQ4adS/JEZDum1LgSOTCj6TolkA23xjearWeinv5WtETilzKH4JbGkgrfVy+iA2qi8jrortqGpw9K0DJxcPowEcxijPmVvF8QzVK7Rie4YQYEpxLkY0uSG6FHnCi/yUpU5GukIzAyqufjtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uBroYBk+0jNUNbpWe4OpzbkNaGtShAQaB+Eh0TwLzo=;
 b=RDsNPH8m3ouGuuwEK57p3okQxA4wrgj9+yGz7y35ly6zBaNYtnjQ7OhZ8i1+y0/we1/+8teafTK+pS/re6Wbu9qoPZlFvtJcPFkv4Qzvk9BZouUst1JNad1uuD+AKBlVZw42I+27UZXxT2xABcZe3cUdW743JPrjXnJgexbeEyq6KdScyYmQBINwcpGnlUhAkeMdW0BtMeoG3xU/0LsuEjt+kMZazWLMSTX54XqeoksvO/C3aFuzAlI6Y6GGvjhRPUAyE3u78/vrHGVJi+KiC1B6XpKQF65hB/sfbdu+1ZAD2x2z85xnWpJov+auKfWj0Kx9mz9snqWweVZwm3MQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uBroYBk+0jNUNbpWe4OpzbkNaGtShAQaB+Eh0TwLzo=;
 b=OeIRStqeZGxr21W+nGKNZDwoXEgxq+72cLppDbj0Y5b/6GiQp6YRFyd7rMHWHJ4G3LjRQ7mTPYTk6eSz1OclCZAIvJMdfOHdvCflTUv3kfeYS12QfRwfqXzUco4We5cfMEqw2NHRQDABkltwXMGiad0jptfRjBCCY6sFz95LuDM=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Tue, 15 Feb
 2022 17:00:04 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::2dcd:d54f:4409:f1ff]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::2dcd:d54f:4409:f1ff%7]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 17:00:04 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Zhang, Bokun"
 <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix wait for RLCG command completion
Thread-Topic: [PATCH] drm/amdgpu: Fix wait for RLCG command completion
Thread-Index: AQHYGUSr1saRIXC33E2OsmSa9FJxf6yTm54AgAE6WQCAABH44A==
Date: Tue, 15 Feb 2022 17:00:03 +0000
Message-ID: <CH0PR12MB5372F0D34DCB5C3B88693DA3F4349@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220203212525.12738-1-victor.skvortsov@amd.com>
 <MN2PR12MB29570E798C089D8BCDBEF3ADF4339@MN2PR12MB2957.namprd12.prod.outlook.com>
 <BN9PR12MB5324CD23FDB86F765A3DE12E8B349@BN9PR12MB5324.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5324CD23FDB86F765A3DE12E8B349@BN9PR12MB5324.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-14T21:08:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7f65bd2e-5151-4039-8183-af86cb5a44ab;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-15T17:00:02Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: feb8a700-1261-47ec-aad8-b393e05f6350
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f67698ca-2a49-47fb-f981-08d9f0a49c9d
x-ms-traffictypediagnostic: MN2PR12MB4048:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4048F1596864A63888311C55F4349@MN2PR12MB4048.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRcnHftMfR2Y1EU6KOVf/O9TsMQsGE5mK+3jjnplwVyYkzZra+/axVWe8P8bJ8lVKEEHjMgXaB6PyLPlssq746ndh4QE3jaIttqSBSlv3OumXCiHVRNggnppfkI2YZmXlxumk8tH6DJhRT4urSBqczMS1TXwAF+M2W5FKEf8SX2sS4HiuOiTnyH/UHu5aX6Jgn+8rW93U7WYFnJAApcWjWyDKjhtnBixRJbYu6cToy9Avs2CIe/h/CM42XSOSr1UR+Lrydhr368llkKqjKTjqRdCgXEu+4NQLRi8G7jl9FfV2Eu7NYIl1NrxyhBu+w11uBiynvBzZuCuf75zz1Zo+rkyCWLROZfuZv6vkYj3tk6bFPYucve42WFqcxykYf7YBc/zhryileY9Omv/S+WuTvkDDwKcxf4fpzGesKg0Dvny7ud4eMZMNGRpzPnWAksXE6U+nVxsQqdn9OKg0r4sf1FW6Uh9ea70wEUKPWLxX5+Zpeeb2M48fIYDJKhq4wM/3URoeQdcaTgCRuUrnODiYr+HlDjgxICLyJfAzJGX51dG0IM2mMkfWv63a2AWm2lMyc+Ucy0zyPMTMGtDHOczTvkZ/u2XYXtQeyOJzWkSwtXrBmTQXmZ/BwW/tNZIohLT4AQ/rfODb+uMjYC0wOomjAlIWGFGRURk18hfVj+gNs5iopBnvLml6KfFpaXmZKqzxywnY9LAMJa2fXH2MjqYyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(64756008)(66446008)(38070700005)(316002)(76116006)(66556008)(508600001)(110136005)(33656002)(66946007)(86362001)(38100700002)(122000001)(9686003)(2906002)(26005)(186003)(53546011)(7696005)(71200400001)(6506007)(83380400001)(5660300002)(55016003)(52536014)(66476007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iJRHm1zuQCiIpNo3SD3yURUE+y6laCOuFh1+e12RvXKlRDcrCRLjPW5iIZwn?=
 =?us-ascii?Q?OU9cY5RDQG0TaeJHEaI9XKI5Fo+gkI4uf7245mtI2vzrB2qH22oVc+IOKDfg?=
 =?us-ascii?Q?92G11NmLUaYX8+bHaM32YfPlssQtP2fha4UVo+tkaLtKW1Mm5esgi/YA9TQ8?=
 =?us-ascii?Q?YW1tQ44lxPKwsAI6y7WH7DGWDBZod7Zo0snnPVNXpoQ1+QnwktwKVR77pyDT?=
 =?us-ascii?Q?cxCXfR0kMmoawoc+Da32OOVHNok7SuiaTg1wYRPtHnwXfngXrfXC8uJCQVLP?=
 =?us-ascii?Q?EPxgUgjVq5ah5qjOjnA705MlmYFIj0yefij/NPwqawTTHaWIy6MoKXms9esS?=
 =?us-ascii?Q?LO+/Gfh5wjaORyftafwRWYpSJzQw6BcqRLcjxDGF/thIrZFv4+Dj+0+/ss5W?=
 =?us-ascii?Q?QmGX0/tWxJ1oTvEqesoBoo80KpfbCT0snf1OQi3QhIJXIhyNXMZipv5362G9?=
 =?us-ascii?Q?Qh9BlTGE6S2TAZw9lc/LDq/JoGSA5CA6N6tgt1JAoyN3JmEpZtT8ubFAvAkM?=
 =?us-ascii?Q?30ci5md7P4cxHL6kR2Mfj2ja60gDSQQBVv96UGZhoWS78GuAuV7DC28kVJeV?=
 =?us-ascii?Q?5bQykfyqhvnDfMgqgkhni6ssvLkSX1e2qLbBKmHyC46iQTKH4cWmftWO/ELh?=
 =?us-ascii?Q?eZTGyIuZVHInC4rrQdqBp18PgAMHsiJSzzhhpQmR+DxfLfHtPssXtmla1nwR?=
 =?us-ascii?Q?cJQ6ntjTxh7gF5VFu4sSr/fwDPSoXh8dl73CY0L1+5PvF6hZH9b1pdbGuPWx?=
 =?us-ascii?Q?L6qoT5+MVjZ4UM1SUDe87n1VyDxpi6bXc1Z7RnDGIVI3lZVxEkyhUO5XmfXj?=
 =?us-ascii?Q?A2NE9ULVZU/9bAtBqmObC8NpccAh7ciO5jSBz0mQ4kC3SE2+EoYmzKTyQ9PP?=
 =?us-ascii?Q?gD4f6ogm+RqsEMTWgqlySNNlqf4+ph4p2IZf3lx9K6Dtub2KEEEImdRxJqnA?=
 =?us-ascii?Q?lXYwcFq+bky3aze/n6bkS/1WlaJOeyPnyaPFo/nnRUW6ynajXuIj10QxUl8I?=
 =?us-ascii?Q?I0oArQ2L0zGI2r0evelReefeMAf/X8ZyB0rwvQvRzxWNuMDrnEXBcZilLqkp?=
 =?us-ascii?Q?0BavQkuvr2LzNy3grj1DZpt2ygXwzPS3pa7AmQ4GXWYhxxbkDskw3A2GnSDw?=
 =?us-ascii?Q?y127G38Dc8osOw13toxflP9qlBhaOuqA3XbDZann4Na7ii3kVzYHtSpBmwSV?=
 =?us-ascii?Q?Hgp1TgblkVf82BKij0BVAza3/rKavwjbQzJB0Rgtcf5HXY/iRNmQORP+ERhj?=
 =?us-ascii?Q?ePcbeaVEN/VnmtjpR8cs03IccyBAcHBYjEVHhcniRtRfJ3m2HRAuArcGN8B6?=
 =?us-ascii?Q?2Gg1qCGeJLiWcTTnOMK4XjPCdksKtA2eni8GDJo4Zw+4Zaz8jdlMn9/SrrGU?=
 =?us-ascii?Q?BV9qOKaqiU02YDS08ojdLluRh5WJcc+dJ/0R9s1/7iTm6qEg+lD4pBNB8k7W?=
 =?us-ascii?Q?aigo+vXqQ7J3t1jY6Zv6rvIN3tTdA2YZjydRgPSbEygbONnaZ9xRrLQt2dD7?=
 =?us-ascii?Q?GSZmxXAEJDq0vFDR+ce7e0WCw1+dxFoAltwoCEElnsaz5uqYyHcnSVwBTED9?=
 =?us-ascii?Q?stZMv3nSCzulrgKSZwi191K2wyNxt0C7KaW/TSP7/1kjo2Tb0OYoX/cCTyf+?=
 =?us-ascii?Q?qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67698ca-2a49-47fb-f981-08d9f0a49c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 17:00:04.0337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Hk7WJcuW8VKmjMZdHY+BpZO44T1r65Cj5oagTXnXft6IrXEGBPwmFLUML8kIFeC3sPycpexQ+tR+zgv9SmBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

So driver will use the flag on write but use the new way to check on read.=
=20

Looks good to me . Reviewed by : Shaoyun.liu    <Shaoyun.liu@amd.com>


-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>=20
Sent: Tuesday, February 15, 2022 10:54 AM
To: Zhang, Bokun <Bokun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Liu,=
 Shaoyun <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix wait for RLCG command completion

[AMD Official Use Only]

+Shaoyun

-----Original Message-----
From: Zhang, Bokun <Bokun.Zhang@amd.com>=20
Sent: Monday, February 14, 2022 4:09 PM
To: Skvortsov, Victor <Victor.Skvortsov@amd.com>; amd-gfx@lists.freedesktop=
.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix wait for RLCG command completion

[AMD Official Use Only]

Tested-by: Bokun Zhang <bokun.zhang@amd.com>

The test configuration is 8VF with 100 loops of VM reboot.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor S=
kvortsov
Sent: Thursday, February 3, 2022 4:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Fix wait for RLCG command completion

if (!(tmp & flag)) condition will always evaluate to true when the flag is =
0x0 (AMDGPU_RLCG_GC_WRITE). Instead check that address bits are cleared to =
determine whether the command is complete.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_virt.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..a8babe3bccb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -902,7 +902,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device=
 *adev, u32 offset, u32 v
=20
 		for (i =3D 0; i < timeout; i++) {
 			tmp =3D readl(scratch_reg1);
-			if (!(tmp & flag))
+			if (!(tmp & AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK))
 				break;
 			udelay(10);
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 40803aab136f..68f592f0e992 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -43,6 +43,8 @@
 #define AMDGPU_RLCG_WRONG_OPERATION_TYPE	0x2000000
 #define AMDGPU_RLCG_REG_NOT_IN_RANGE		0x1000000
=20
+#define AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK	0xFFFFF
+
 /* all asic after AI use this offset */  #define mmRCC_IOV_FUNC_IDENTIFIER=
 0xDE5
 /* tonga/fiji use this offset */
--
2.25.1

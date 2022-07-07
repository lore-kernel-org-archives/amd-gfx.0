Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BE1C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 20:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB6E14A768;
	Thu,  7 Jul 2022 20:30:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90FEF14A774
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 20:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1TZABENM0zS3yx96Aek30tBfWh2nNjFLeNOc4orjF7u2iL2rEiRtF0Qb55bgvso3x3M7e0ujEfJj974xEBs0EzCMfQAG720tHM9NNezw3by1j/9y9np7Nq21KWB/jCvaB2C8cNxjqIFpAc5SaIYv3YuekK1CoZqvhPvxab2Eyx9IxJs4aR9bS5uhOJ4bVJCAtPabvMS4Fz21AvTT5rx76vRhXLAVYTC2aI2Fjx+XMuLu38rvhnJLtUaWQUIJi1PsJN4fYD0tN4uJ/ZHNyGPh1gAjyQKakO/DCYhrU0AiuRKyXdVe0ZC5n7qF99ytJfLWflxwA+lQZueyudEdrDeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpjVCb/1CYJr6TgQ8q/0skP6zJrDjJQ8xZcQ4YcFlys=;
 b=c/ELeEr+boDQF9eZKn8OMG2KeBpyR/6DqDFrF1ZBjJ6dly+791B0UJI570GT9LYLVCqrl8Cm0IvdK8/tNBX5JqLyZHIK4QPPeiBkpzrxtUJMRcOvUYB1BoQsyBn10mFed131UN1l7fSjIy6lqsni6jmGSom7YEINGq4hAbyQeSxXMgo6TCKWmmCv6+6Srlfe/shlf1NF0vl3VagcTDvtlT5WZnbSfDe0l7oa3tezkElUrzuevCr/3owjIHJ3pYGA9/ClCYftyTiBfloJH4AhbFVG2HZFYUpW4gDzc9rzTGin1GbMwTirwnoPDZxYywDk7oh41uVbp1DqdeSNrcy2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpjVCb/1CYJr6TgQ8q/0skP6zJrDjJQ8xZcQ4YcFlys=;
 b=gQVmGYIzgitNllCJDCLqxc+n6ssavVjrKz65l0plmt47bDuxSpVS7b35tt6ztvQ3GkdA676TbINOvDFH7YujtvCvLz3fyyQUp9N7+CuUohD1TvpxwuRj9Ix0ANYxQDvXwsBXbRqzPbr0Tvmf6HHNZcOQJAbl9DqfswSFq1b7jZc=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by MN2PR12MB3262.namprd12.prod.outlook.com (2603:10b6:208:102::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 20:30:24 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::b857:1b2f:d637:9b8d]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::b857:1b2f:d637:9b8d%7]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 20:30:24 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Select PCI_P2PDMA and DMABUF_MOVE_NOTIFY
 instead of depending
Thread-Topic: [PATCH] drm/amdkfd: Select PCI_P2PDMA and DMABUF_MOVE_NOTIFY
 instead of depending
Thread-Index: AQHYkj3LUbJ/mYLaeE2nI0fJTIWtnq1zW4UA
Date: Thu, 7 Jul 2022 20:30:24 +0000
Message-ID: <SN1PR12MB2575AC720C83FE2193811981E3839@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220707201135.5070-1-mario.limonciello@amd.com>
In-Reply-To: <20220707201135.5070-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-07T20:30:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=09844f98-b49f-446c-8757-8104b83a56fa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-07T20:30:22Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 329c4679-ba51-407a-bc6f-2d61dfd971ef
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aac473c8-bdd3-4918-c144-08da60578582
x-ms-traffictypediagnostic: MN2PR12MB3262:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itZxrGdLsRQTOOf+ipsDLvuv2R5yeaAWNL2YgoubKJeVTNCTQb6Zih+pbFXWo78bOXmvbg+AFdrW4Gw5+wexaaolx6+R6XpNvaCLH9jhmz3bsnVJveLzjr4r4w9uWwNGXDogGlih4XASrZmHNA+gadump4wwigdC14JbYiQU22rbLWjcszGJRHAWBuNLlDH/N7cpDK/86lnfQZlKYOEPXbv0+2Z+ztd3mnLPL511ylvHY7o4IxHlo39VAGddnzLJkaZL1eXTWR9ZHBnpVpe48kr7rFEZhenrZQAHs063Wavasstq186e6i6+osrEQgfJ4UXSICsWrNC2eKZSvrSDDWLuI7asX1gM8ZYOzifnIy0f7PT2C0DEObRFZa4Vxbee7ArxygOwi06l8g2Wznt5kWu2D/NtPx2THV50HMgH1x1Jt8dnBSYWmQOQo/tn1h7xcgKQ7kjplQFNLpvWrBvxVdjMnpmYJxy/vPYbMSTmOzK32J+dfMU6OFwEHIt/vJdy6MG5PQmS9dwfxmpk7qjxCjQuc2ATxgTEKX3Ym6BA+YoXfL+FbOOTpSWDsMv7AdCUYwLZJxtvXU/jFSGSvR0qMEpLa931xffDNXQmGcRGdMpHEqulhD1ZiMoBkIpuB78VolGcCKFYVsFElqU+xRkRL8krI9KVs6AyHPBwKUHrDDFOCoeyIZIVSR61LV9/CPj1TpJpw+Xkk2DVL6z3V8kHX98QcLuf58g4rJe6gWaKno8PWs9nv1f4FFapLG3PLCo/ahS4SoVV1YugLoOIhghEMiJ2IlmPcsU7WZg9OZQHQpq1oqlMSyJJN70p8VpFrkLQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(38070700005)(186003)(110136005)(6506007)(9686003)(478600001)(26005)(6636002)(316002)(7696005)(71200400001)(4326008)(8676002)(8936002)(53546011)(64756008)(2906002)(66476007)(38100700002)(52536014)(66946007)(33656002)(76116006)(66446008)(66556008)(122000001)(41300700001)(86362001)(83380400001)(5660300002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AZRA3uVr2BeSsReP5fgDdwCpgW0bmZweUXb/97fcg4DTu3OnfHZ/WktbrKmN?=
 =?us-ascii?Q?VpwzqIITj5NXUpite9T9ZtCmi+bZdxYxJsBIufIHosdhW8RDZFTSX8OmF/Nx?=
 =?us-ascii?Q?W8n8gRpL9kdhx9eFn2G1GEVXZvUXPzJUnQ+yzz+ivD0+jOYzm+xOX8f/BkvJ?=
 =?us-ascii?Q?s74yMemogUAAzqHCwJuqbNFReDEQiKGivKhHFPmONDaZ8IXhhGNzA90J0R+Y?=
 =?us-ascii?Q?LAU/2a+q/VGLBSukE/9n2pXCAVliSCRH8r+3k63NRI+aPcJkwU1y4xo1e/2a?=
 =?us-ascii?Q?vyk60Q2UbJ+xzRayIVEi8HP0Q4DS7LCdIPTx9BgSuicr4cMpNCoBZEWo5vSI?=
 =?us-ascii?Q?Rt5Txyzun9Fu47PdVv+sbotelCfGCMEFTlLmAszQq9jcW9P0GbfroVQrXCBy?=
 =?us-ascii?Q?P+yU9QAHRfZN204BLxhl5FelvgDok8ZnT0hRtxPQKNCs2CJiKGXoVdITZybO?=
 =?us-ascii?Q?Pk0jMThtCHudnia2qiHvLGAchqTHE0bOPq623zeFBJ9pJEoDAdTcSwtFgB3f?=
 =?us-ascii?Q?iI0fB6n3yBQn6pNOUuj7Y7le7RDiJBANivQhhhmOvC0JbZakxLRewImj7Fzc?=
 =?us-ascii?Q?4WAZ3vItEyKcYksddnBHU8NwrEpkNA5c3+UZPkH5C8Z/2tzCrysQwzJ7ULvT?=
 =?us-ascii?Q?g7yflJE7b2pobV3cVvAE2Tsy3PPn31LTV7qUWKm7J5syaJMN81hCim8UJLTt?=
 =?us-ascii?Q?eXEpEWOv5SDY2qRVyGu6Jk+DS8iOhVU9NY0oh7Xf/zY6gpAKs+XrmFB7WHjK?=
 =?us-ascii?Q?rs9bm3h5/OaJuaBUKJoabKC3wtsQR29GZi/q12KC3cloIX5OTy+G0UN9kyLE?=
 =?us-ascii?Q?v/BBy+LtGA5BB4wDDPx1LXe0R+mWnTLTkjx6r3ZdLivUi09Fgs3aVm+10qjc?=
 =?us-ascii?Q?P7oFwmuLASuTI352HnhCgIAzzzbn8v1llx3U+D81mtcAoweL78Un/08fqqFp?=
 =?us-ascii?Q?8gXyz2e5Gwl0J7w0yz7xK6Z41FvKK95ficifrf3X1sw0MYV4K58zAdSbvSVh?=
 =?us-ascii?Q?2wKTbmlagk4Ew4GJKGtVpkUXzjTy8qjLNJUNdsf88o+Cbe9bE4m3f6SjmBn6?=
 =?us-ascii?Q?HMF3GsYpkmBDTk9bRsLJMVQBy4uXYcmOGyFbpjbR1NEwCC9tgHGvlQud2GsE?=
 =?us-ascii?Q?lkZLzMhilnf9kS2JBpsBgsBAbYuw8E7R3BsQELukkm+F4i3P546GBnEDOs/Y?=
 =?us-ascii?Q?oEgKrNCnrECg6yKRAcDYaRwaVCRPdiIqwEq23zR8s0IRBNRUsqj8CZffV4TG?=
 =?us-ascii?Q?87xiMKYkpTyStRpX1hC5BkDGi/TI6V771ULMmyfIAduER6un/M+MIVvu6MGv?=
 =?us-ascii?Q?Xx0xMmu4k8wxUfKOr4cqwCRJh5G6sCy+B69n/K4J4Szlz2GFcHsZwDHn79XB?=
 =?us-ascii?Q?xBI29VurW6qIyipt5zJ3pmhVeJ7zJoXAbwoQPuwq7GOLwb8T7+6gRFkqJRBs?=
 =?us-ascii?Q?wZA4Cj9+OLo+8BBmyUmZCZS0LzhVZYbPh10HFf+K4I1S63q5o8lyKNh0XGqW?=
 =?us-ascii?Q?T4Yv6VCbIR8TExMqlFBLYST/DfMMlZdluD+UedxtkT+5LBdbM9dWoaB2IytW?=
 =?us-ascii?Q?u46PHgPPzssd0HFL3vc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac473c8-bdd3-4918-c144-08da60578582
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 20:30:24.4081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGzzSTcuKF9gO6TrT5VaeyZjvSuTQRKCgLXiGDxfTmn59Qr260RVK3qkvT3MtQS/J2k7SL4k4tqrw2J1subNVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3262
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Using "depends" prevents shallow binding. Applying "select" can cause troub=
le.

Regards,
Ramesh

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Li=
monciello
Sent: Thursday, July 7, 2022 3:12 PM
To: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amdkfd: Select PCI_P2PDMA and DMABUF_MOVE_NOTIFY inste=
ad of depending

[CAUTION: External Email]

By having dependencies on PCI_P2PDMA and DMABUF_MOVE_NOTIFY the option HSA_=
AMD_P2P is not discoverable.  The kernel menu configuration hides it if the=
 dependencies aren't satisfied, making it harder to find.

Instead select these options when enabling HSA_AMD_P2P.  This way distribut=
ions and users can just enable HSA_AMD_P2P.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkf=
d/Kconfig
index 93bd4eda0d94..b153c26903ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -28,7 +28,9 @@ config HSA_AMD_SVM

 config HSA_AMD_P2P
        bool "HSA kernel driver support for peer-to-peer for AMD GPU device=
s"
-       depends on HSA_AMD && PCI_P2PDMA && DMABUF_MOVE_NOTIFY
+       depends on HSA_AMD
+       select PCI_P2PDMA
+       select DMABUF_MOVE_NOTIFY
        help
          Enable peer-to-peer (P2P) communication between AMD GPUs over
          the PCIe bus. This can improve performance of multi-GPU compute
--
2.34.1

Return-Path: <SRS0=keof=MB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044F1C07E99
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 20:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B394661357
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 20:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B394661357
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F46B6EA8A;
	Fri,  9 Jul 2021 20:28:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C14896EA8A
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jul 2021 20:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCY1fOv1kC2gjb5rdMtOEwrKs9T0Iqc2moM6mg+QnjsS/DkxwM1g4ytJe9wX35pHsAmW+ehW7cTsY5D9rA1QlpJakUhElq67X33/LmPXIEcuVcm2LIcNkErmRTJiAhm4JB0xB+uw/ZVnmnK5B7NiXxIKaiJS9OF7jt0SO4ytiHC/vNkv0GPLYfPlcMPP6LzC4in9L7THKmRnIRVZap6qGzmjX35kdRdwZ15lqFh282S+fYnms2/8oC3sIEtfVnG4wFLabPIEcs9nUkUKfCtPPLgaOqEN2sscCqoYw1oz+MdvVxPmELy4vU0Atsd8DCERm0OvQeJ0yKpR7D306uuwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b301DUQoCve4FLlo8/jFsTZXnOyZKOTWsH+iTLabOXg=;
 b=QahswoYwhLPY5cB/VU3wmudnb0WVZ+kuIs00Lp8fQF0sndrThtVbPpqOuMgJc7c3tFNEMQP08F4ck+SeVMVdJ7WYmbeMvBHeUel3RcVm0Xfjuv93vdNuhRlFP6dzevi6a5nnDMxSbqwq4C4SIUPYmchmkPtfOoGgKO5tGzY3mHIm/LbZk91PK3kCguu82L/OyAZX49o/rMe3ybnN3oe/gS3/lgvE28vRL6/TOMzj80Rv/80EkbLnbqxntGei3wteMXTPt2nJuEXIsWN/jsqFIYZQ3Mu5NfNRxESiev+z9RV8ZKeVroLjHaEkkAaMMDgwHLo+vOHhLsE/lRumoH6jcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b301DUQoCve4FLlo8/jFsTZXnOyZKOTWsH+iTLabOXg=;
 b=0zpiPh7Zb4fFG2ZfmSQodaH8Y81YoOJQehtB9Cn2BEwfPIblcpCkufukKaU+zxapSTq8zHPzjkTMKEw+AeH/VigCrNDB+2iPfUJOUqjS3rpnmHalEpXENjzvQwpaiFK3SFiTORX2TWDAeLI3Wq5M8tGNpPFynDAsh377gM1BjLQ=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20; Fri, 9 Jul 2021 20:28:21 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::d5fa:cf71:ef58:bdc7]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::d5fa:cf71:ef58:bdc7%7]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 20:28:21 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdkfd: add direct link flag to link properties
Thread-Topic: [PATCH 4/4] drm/amdkfd: add direct link flag to link properties
Thread-Index: AQHXZtMGkWO08QURkEqMrr3mv9cOnqs7NBNQ
Date: Fri, 9 Jul 2021 20:28:20 +0000
Message-ID: <DM6PR12MB2761B916532265D3553C20748C189@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20210621192348.2775943-1-jonathan.kim@amd.com>
 <20210621192348.2775943-4-jonathan.kim@amd.com>
In-Reply-To: <20210621192348.2775943-4-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-09T20:28:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=415a80e5-7e91-4f0e-b7e8-b8b3635a01ea;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c007359c-c522-4375-fcb7-08d9431817f8
x-ms-traffictypediagnostic: DM6PR12MB4925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49255C56230958A483232EF28C189@DM6PR12MB4925.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HhpXEXaIdj+1YR1WP3afz78zHI8VwGOxsH8tJW30d2nDfiLmyj6lzQ3g5frcKh78H8FO692nFH/2jAZk5d9EFAnbNlMkxNps8peIDRpc6XPM4O8xy20l4tX32DUJi+Mo9nhCE1c0Kyab1UtPfKwHeNR/ZYuLpioZ6DKDTAo4cUSKGRomxczTrXREatKM9/WJpg+EHh1e3fJ9x5c4C9fwO3dFg+vPOUgnSlzDCbuvxILVtkqVrphWdJrzrP4H9xb5dXF8/Qop9TMBAwYC0TULIbIcWBDCfLDLH+mW8Qoa+4ZQSjmwLHS54fsiQsx4xsWkTd2WSPl2w2Lo2swfoRLUySSvhKOApUaVlrPzAJbmbVFA7XaffkX93oz/bp5FljXiV8nQyC+Bnm8Rd1Ah1uXEwd3wXMQujeBYxfvDbAQDSilRWzX+dZ3idTVf56VvIL/XL3FtS9ltAbUKOIB0KWX5/A3xrh+HgW13xiQ/MAKfOLDFXf8NupYKCODfsQRgKxo7SP3z64hlE3eTwSwtbQU2F3y1KOxEXMovKd6KoqpbNG1hntCJ5MJ9vbRZyJH0rETzpuD3WQpQaSjOJ/ePnazldJZ+c+n4px43xW1Iw5jORHuWXCtj5iLZdzN9faAyHpt9AHFdrjKc66rtWwya5XOdRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(66446008)(7696005)(33656002)(64756008)(66946007)(966005)(55016002)(66476007)(5660300002)(76116006)(71200400001)(2906002)(66556008)(478600001)(45080400002)(8936002)(8676002)(52536014)(83380400001)(38100700002)(9686003)(53546011)(6506007)(110136005)(316002)(186003)(54906003)(4326008)(86362001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?puu7aFQk2KBBeMNOKdvbCr0LXDy5KBVxnbZ0bMBifUTuumKEOBH1nYS5QRnm?=
 =?us-ascii?Q?mw5hFqxgOCkdg6caDmBUyK6veHf/AyBwuSX3GRH23A+hyMIX32vx3lFVHVN2?=
 =?us-ascii?Q?UavrzWhbyhzaMrhNQK2Ykx2/qqTT1F5P2iZyGW/TOUxwA6E9G4PStO7CHTdd?=
 =?us-ascii?Q?rLlGvmTEQdepuewYWDOK1H8zuwXUGvX1InsFrfbGsgwEhfYuWvPBsfbM2atL?=
 =?us-ascii?Q?lAc8FGR5gBIJuVUG4xadEXtTNfSkQM+uvdxsXK9HpnJ2LQFCFaZuSQTH0827?=
 =?us-ascii?Q?8JZK76HSNnmmDwhCgB25BNYfc5zVrVJKRV1wholYGmo2I7N2Bu7H4ciP2cWS?=
 =?us-ascii?Q?vJ7NqLGmMhGrWLrZPeR158V0SoFD/qMbnJ1+k9QoWFAJ7KzBrr8xhBr0rLlR?=
 =?us-ascii?Q?9oLHFvQoBXG3dymO06AJ8jQV4FAdjFrXwTsnLdAuWqeLqKdbs4cOg3NF9gb0?=
 =?us-ascii?Q?lJ/3x17YKHToEbSCrlHxwn1UPdtzDVspNGtyvvaK0fs3/O6Emfiep0aAzF4U?=
 =?us-ascii?Q?ZqbZ/OdOElM5sEdh2kimjxlxY4KAWLm/10Uvdn6HDaJ6VHqStN7vQ3qMTfE/?=
 =?us-ascii?Q?zlSA5ZfLnfBWRKFBi6f1f5TB++BMkucZETZTNQSUPZJQssnjCEiDVezG3uta?=
 =?us-ascii?Q?YxkcmbEIWWoP7n9rgEJmaKGJzsZaics8gqmmpbJbkuUvHR0rZtnNOIaiK7x9?=
 =?us-ascii?Q?panfWP+axCKB15tobKbhUeCWlnca3qCn2Sh26Kqbl5vJQSoDvWq3ov/XV4lM?=
 =?us-ascii?Q?3NYM3ojZYBg2zRLA7nggNlj9/nO5LRBgup3cw1tFJH0wWP6kn+YOm+hNGzJH?=
 =?us-ascii?Q?UwIK1jNJyTMdUf9styEvUIUrGpVCG8levE/vbhkgGa5Oss/qniTR8lf9e+SM?=
 =?us-ascii?Q?dlVDPwuMFvDz4zmzrT5UJf6kGs05DpCS53iIc8WTxefTZzDUX93GeEbi8PVB?=
 =?us-ascii?Q?zb+UNqkA1t6GLOA0MEupmXUjMIdNtzwh5di7tdBOJ0o51pH2+PyFmGlxhdCh?=
 =?us-ascii?Q?e1tFtBgxP393lxyFYjGWabEJ6rexQ/ZFBF3w8PHJ0+Rl1GfIjJ0kpA7xqnM8?=
 =?us-ascii?Q?PvqEc0IX5/fe8HjncSZAHjSqkISZS9wNSoJ2o4Skq0myBMMNx8jnJiSA0wA0?=
 =?us-ascii?Q?59tyw/hUcmlkLbWReL/mQ82GHFosEdK/CobfupvyGZoZmq0zibHKSfvBVgdu?=
 =?us-ascii?Q?lKEkdzSl/LK8P7PQsEWmWeG/XZ8c1vFOX2u2Ji3H0RcVNSP3dZskY4jv+EBr?=
 =?us-ascii?Q?2eL1v/LO1O7rlNeAbmoUrrrhJQ5g2Wug9xEBKVLv1bysweKpo4TkOAHmHhHW?=
 =?us-ascii?Q?eYks9qoDJFH2jHZDRN0XW+I0GmgjRJt1ky5YDEiDMmNd5gXmWNaud+Ht2Olo?=
 =?us-ascii?Q?hPuE6A0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c007359c-c522-4375-fcb7-08d9431817f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 20:28:20.9725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWKTR8t3YolN2MrqndqVTHrnsBN+pgfDHP2F8Loq6EiqfM2bPzw8N11MAP65kak3grFCXOa7o0XX5lEBqXJuQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

This series Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jonathan Kim
Sent: Monday, June 21, 2021 3:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: add direct link flag to link properties

Flag peers as a direct link if over PCIe or over xGMI if they are adjacent in the hive.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index d1f6de5edfb9..0d661d60ece6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -232,8 +232,9 @@ struct crat_subtype_ccompute {
 #define CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT	(1 << 2)
 #define CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT	(1 << 3)
 #define CRAT_IOLINK_FLAGS_NO_PEER_TO_PEER_DMA	(1 << 4)
+#define CRAT_IOLINK_FLAGS_DIRECT_LINK		(1 << 5)
 #define CRAT_IOLINK_FLAGS_BI_DIRECTIONAL 	(1 << 31)
-#define CRAT_IOLINK_FLAGS_RESERVED_MASK		0x7fffffe0
+#define CRAT_IOLINK_FLAGS_RESERVED_MASK		0x7fffffc0
 
 /*
  * IO interface types
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index b1ce072aa20b..037fa12ac1bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1244,6 +1244,15 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
 	}
 }
 
+static void kfd_set_iolink_direct_link(struct kfd_topology_device *dev,
+					struct kfd_iolink_properties *link) {
+	if (link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS ||
+			(link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
+							link->max_bandwidth))
+		link->flags |= CRAT_IOLINK_FLAGS_DIRECT_LINK; }
+
 static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)  {
 	struct kfd_iolink_properties *link, *inbound_link; @@ -1256,6 +1265,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 	list_for_each_entry(link, &dev->io_link_props, list) {
 		link->flags = CRAT_IOLINK_FLAGS_ENABLED;
 		kfd_set_iolink_no_atomics(dev, NULL, link);
+		kfd_set_iolink_direct_link(dev, link);
 		peer_dev = kfd_topology_device_by_proximity_domain(
 				link->node_to);
 
@@ -1270,6 +1280,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
 			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
 			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
+			kfd_set_iolink_direct_link(peer_dev, inbound_link);
 		}
 	}
 }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Charish.kasiviswanathan%40amd.com%7C92cd10a23764408da0ec08d934ea2680%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637599002557866754%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=utRekyrx5G9DD4TSayfxKwLFWv%2FnFlgzSErE7m6zdEw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

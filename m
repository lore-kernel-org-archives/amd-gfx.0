Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D95CA0EF8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 13:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4450510E311;
	Thu, 21 Aug 2025 13:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TywMx3t2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B880F10E311
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 13:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpX51sH3tYIYHNT+iZN/xLgyVUUvI9rGt8Nk8kUXO82fVqwLHnSUO/5ySHbZMYtzIqUmD00nblI+WrnN4gvNsvy8qTj0hKN+MMsU4AlIOa5Hqai6MY0Xde8yivrsQkZRnYQE7mGdyBQ1ph60xi4sQD6aNIsrEA/5MFUT8ePZAO7OK34Kr7vQypHqDwGKPdr52NKT0jE63Xem5NoqfY8ZPggkDLviICNsX2b3QdNJxikZ52zOj1wBHiSiotbmne+xNhlr7YsdacFOcXMzDAzk5aXZMjMLxC8fcNVqhtbUS/4WjwCptZcIPDKXhbDO8PfW5goyPuiHjFwSgOykPzC6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8Bu3raL8CBs8/Z+Udlw4hSLahMKx9RX9CcDNxdQCbY=;
 b=Lio9kEC8YZQ8oa6q0wPycmXTTezGV9T+jlcxSmU0MzMaxVWsNV6f8Y+3ePbsdVuV0RzMUc36VBdlb255w/YdFTZ/BYV1c1+POf+2RbQK0+V41lLDN8VLjI1tUuG+t9dGC5lSHD1D0ZP35QDxcvjei1J12iumAuquubDDbPBHiIasvJYUnGYngVjj8UwMSfnjE+k29S4G1DArEIMfaU9+WGoCdS3togoJcH3vq+gWG9uLyDfuknCOwsv8uXKMUuLoycyBrjT6rW8dOhXzGfIUY8+xm0aj2iXuNcXgsNfPBsFfAeIQxeczP6egT/7VLerh+iWDYREcXO3hb+5IZNR+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8Bu3raL8CBs8/Z+Udlw4hSLahMKx9RX9CcDNxdQCbY=;
 b=TywMx3t2jyaAmitWd1fHuw5zoM+5aFWIdc0ZDWYvGhbEFHjruX1HCNGDR8aK/WSCvXwXkUaJNV6CW2IU+PH3HNk/dHsnfcPwyW5cjNs+1M7YpuoDRveQkCp5WHJJDM1zgry81Swf0GVXupH7qgyuXEllRT3ssln+zZImXP68kTo=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.20; Thu, 21 Aug
 2025 13:48:13 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%6]) with mapi id 15.20.9031.021; Thu, 21 Aug 2025
 13:48:13 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Allow device error to be logged
Thread-Topic: [PATCH] drm/amdkfd: Allow device error to be logged
Thread-Index: AQHcEeHTRNKPEGaaKkmUQm22ZA6G37RtIKAg
Date: Thu, 21 Aug 2025 13:48:12 +0000
Message-ID: <CY8PR12MB70991EA1219CF19DA68850578C32A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250820145032.2150006-1-Sunday.Clement@amd.com>
In-Reply-To: <20250820145032.2150006-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-21T13:47:55.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SN7PR12MB7274:EE_
x-ms-office365-filtering-correlation-id: 203da022-80d3-42cb-4d33-08dde0b95f5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YEr1HJ4FY7sZwQChGqq0EAJXK/CDobFPs3gafBn8YP52r3ulD9ykIw2lGPD4?=
 =?us-ascii?Q?K13u8UxieqA1oMZglpHu+ZhW2u643LUxU7cI2asZtvJYZwpxgcQ7hfAX+fbi?=
 =?us-ascii?Q?mxSAPvWXJveUjlqd2gT3wbwPsdMB5PYVobX2qdgML1ga4xhokzkCP/0IFqp3?=
 =?us-ascii?Q?pF0p69dVq9LHmSaf/IvJBFmiuCIUHS5LMfqlMsmooX82yyUYZ9UyyMQJn5pv?=
 =?us-ascii?Q?/sCAhiLfex01foZW5+d24DF3BndWeEp8QN+Kgu3WWZTHxLGQ0R1vtm/Or0Rv?=
 =?us-ascii?Q?0xAsnmWIHYLXjisYHbSww3ZGVDkBLDmxE9qaVPnJcTuVYVacRTu/QO9AKsSA?=
 =?us-ascii?Q?htp3lyrgBBVHJnvOvk6wRvyOMF7P3iQW2sTgIcl7Xwd7+Z0bthknjiIPd+qI?=
 =?us-ascii?Q?qvgU3SsqcxlKFBJ8gGQB2ygsjg+awdXckVeTfMZNNQnl/wrYlgNPPkohvBfC?=
 =?us-ascii?Q?y3+lrYz7YEesfotpJoa3RHFcmpLZ+EP6rbViJZh2+48UraPs4zyOvW8JK1sB?=
 =?us-ascii?Q?BzQ3XfCuoDPbaPdocj7wLcE2pVskOGRoMpdbjcVzrls1BzPcNoNcD8BVJl9S?=
 =?us-ascii?Q?uUC8W/e70CR/foE0YcGDdoHQ7j2ULMa4ZIssjFKCYEb2nDW7eH/5KhN8k+0X?=
 =?us-ascii?Q?K2zEIONae0+EadRQ/OPzjimeSbMXgprZ4No9Ig5W3UMz72NEqcS+X/PvPyS0?=
 =?us-ascii?Q?H+iImj0fzQ/O8yCMhChnYTa/7dDUPUtt8uHHd6w5g8o01GO1YuDyAxR+EeF/?=
 =?us-ascii?Q?E/26ukjUdVShV28//145C+yFXBYKxuH2HbpGzjsQktfCtzcHtVyxRqKGm7uY?=
 =?us-ascii?Q?wjQu/Ia7n7IUKSB2pF0QAa63u/a5QO1IT3vKS2oX9biUJIXpaZS0r8xAQuBd?=
 =?us-ascii?Q?UTq1m6BK7c8mjrTJ70HSqm210qQyRoh1nX5nqTdjVPjKfZxBVTs6EI5XNzsy?=
 =?us-ascii?Q?VcQvNGiMifUd2rnzJC6hNgHQEvqKnO/Tzs+r62FKh/Ofl8CxfFulNOCkLtWz?=
 =?us-ascii?Q?zZqX0aTq8KUxtdnIb+t7bFLdsaINYdvQcv3oOqcS49y9Q83VLIrO3iHKPheL?=
 =?us-ascii?Q?mVQ5GbTlUlxf1SrWd/TOagqy85SbpwML9h3X9nKFiv8VWT3pldg5vX/8eD+D?=
 =?us-ascii?Q?yB2qKB1ii1d+QcrLTp3Pox0FTC5DG16IUJU4hY+mKrxANlrqJ3R+MdaqFDdk?=
 =?us-ascii?Q?T3BCJT1lZmkjhWFF3oMjlEkVTdka8jApmT5IKNioIkM3qHOjHr9/n74/ox/C?=
 =?us-ascii?Q?7ERNCF8sNTWUeqiEGjxdf3j4MtrXsccegIrW6V2kUJYR9Ukgn9DVrgfXryLv?=
 =?us-ascii?Q?5qmg2+dEFyXkAYAUM4JoMLZKk8Ym6+9+cVQ59FWLOVRm/5amrgCmm1lA1kAH?=
 =?us-ascii?Q?PLLhDnYT4+QcEekD+MPAZ/RxDoMHDcdL14dd5TT9P7L2dUr3XFe8WivDwrIq?=
 =?us-ascii?Q?QtDcWarriWHVDNRirVjZ26LxYj9MxbkNboWtLrlqmZcbYRvKUAP9Se4F096m?=
 =?us-ascii?Q?2jZc8lHVVcCkfbw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dGH+0ZEObqhJOwOR0S1NKheZKrGevDvKH1zYySnrhA1b0qbn/K7R+rff+x9i?=
 =?us-ascii?Q?v2wnw8okISrDk0mRAJZXfrcVdBYaX9NV9T6jiQRUmGdRu801SGVuHQEOqt1R?=
 =?us-ascii?Q?PZcl8UZ8q9MrdV8gOr0EGTM9B2aaWN/P7j8kYhePOvooOn73jImq5naPU2ZQ?=
 =?us-ascii?Q?Z1V2jZKhQKESAumDt+cBjyNPGjeoWytvg+AqBzDaTPycUuuWOILWcJZ7tOUY?=
 =?us-ascii?Q?xyLWRlfW1K5tNDsMZzleN36ZHDk/iVzFc3twDa6EzWZbhxVop/tWJ0d5LzIk?=
 =?us-ascii?Q?jmnMfcf1WjsW7LzGY7ihtzKVBvpIEIfq3ZHsWyI+KphOiUuX5pgWx2IdLBss?=
 =?us-ascii?Q?0G/O2hzCC/1k+a8ZL+4Q+mhwU5DzNx8M9WWhsG77FnPjxV0K1AR5FBjkzOYH?=
 =?us-ascii?Q?/GDcchGmcLmpDJBUpbfFCVviR7k9K6OKtQZCv4D+1/9cnR33JTB1isfrC5qM?=
 =?us-ascii?Q?+K/q2WNHidPtNK1CHa5iLXIaRrkTq2OEKnJxbTX+xoGBihSVQ7sqq+v9Gns9?=
 =?us-ascii?Q?ukg4Oids5hO30zMAgtULdVCGtI1cl/HaFecRIT07QPkPo6QcjVSA3KLZ1w63?=
 =?us-ascii?Q?AQGg6zIwtAd7Aqeagh7gTn/3ojQRMXdXMimkJussNhIQgFLh5j4Sl3GVHY3N?=
 =?us-ascii?Q?CSjcXFyEIrfjxjiIibwAUgs6SYrzCy5KFFPUuxeuqEtK5mnY/ngSRvc+yDER?=
 =?us-ascii?Q?OoqlkvsNBQMpMcAJIkg3gRFHbZoXSBJhvAw30UPRfVSgbqX7lKmWNpjCOct5?=
 =?us-ascii?Q?uH/xGDrgDjBkUTAOzOFKZoSTEbCgFJsXrKB+XiK/XJ7XNJRx/m9yO/+iBAZF?=
 =?us-ascii?Q?FHo/bbXjcWozVyk4+3xN9dgXlpw5xWREmBA4Nd3GvI/FbF7P5B8mGhQu4eln?=
 =?us-ascii?Q?MqR3WyN9qs8AUHrb7BoOHwvk1vk8MkCZgaJgxFP8pmuqHNOLBAE990GfFgi1?=
 =?us-ascii?Q?kuEJ3vLqhqkkcCDbFsU+fEITv29Q3wSrTPtv1FjE2l6FcWNyyDH5ytQ6oaTG?=
 =?us-ascii?Q?FHoxn25JndNvgRWQnn+uXeXdHFxmVsC4Wmzw0+wEiQl90nBf2S3mf0+fHg+q?=
 =?us-ascii?Q?cYNn58KmfduSI4QBmW1wo8yQ2xqdw4EDjLODL4PeHxZng8xFJ8ZK0WrP10mX?=
 =?us-ascii?Q?oAgbJvHHQzYbaWLvzqEDSLbSMybqtOWgXLbExtd7mgblx9KfKBmn/1fdLYCw?=
 =?us-ascii?Q?w92tKtVYhimw5BO1yf3WrebWrcI2ja4zx1llm0gikPfTdxmSgFGr1NtGH54P?=
 =?us-ascii?Q?rpVwRKVT2mz6Ejf9fcNNt8ECHqpgQ1HjO2CELpuO5YCpMClzRzLLTAtIkEux?=
 =?us-ascii?Q?fv0HppDgGIOyXH4bCkhupbxHBRrSI+jQE2ytSuMzd6eqJnFKAI+LKujsLy5o?=
 =?us-ascii?Q?hv3LnwP0IRZ9IxstiQlmgaYalywLxZjK0859/xAJ0imbIx02jThwXOXXkUD/?=
 =?us-ascii?Q?xsA6QrarSI/27jqLUk1SXLm6LDD40aN9qpt7Be5SgP/ho5O+gn2maujrD5cM?=
 =?us-ascii?Q?T726ljpO7bUyOMeCblvIQUR1mxS5mJWGhoWUhqKsS6wd3yGG9jStmbDHvTdh?=
 =?us-ascii?Q?W0sgRx0NoUWFsZdGZfM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203da022-80d3-42cb-4d33-08dde0b95f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 13:48:12.9444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odnWKmTPciKnovd6kGTYLcrk1nNTLNfGlQoTIMg7E8YnyeDT6fS8bwTjD28rKCHFf6ampdcfwA/vvwfvOiGJ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: Clement, Sunday <Sunday.Clement@amd.com>
Sent: Wednesday, August 20, 2025 10:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Clement, Sunday <Sunday.Clement@amd.com>; Kuehling, Felix <Felix.Kuehli=
ng@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Allow device error to be logged

The addition of a WARN_ON() check in order to return early in the
kq_initialize function retroactively causes the default case in the
following switch statement to never be executed, preventing dev_err
from logging device errors in the kernel. Both logs are now checked
in the default case.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_kernel_queue.c
index 2b0a830f5b29..fb3129883a4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -46,11 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struc=
t kfd_node *dev,
        int retval;
        union PM4_MES_TYPE_3_HEADER nop;

-       if (WARN_ON(type !=3D KFD_QUEUE_TYPE_DIQ && type !=3D KFD_QUEUE_TYP=
E_HIQ))
-               return false;
-
-       pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ=
,
-                       queue_size);
+       pr_debug("Initializing queue type %d size %d\n", type, queue_size);

        memset(&prop, 0, sizeof(prop));
        memset(&nop, 0, sizeof(nop));
@@ -69,6 +65,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct=
 kfd_node *dev,
                kq->mqd_mgr =3D dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
                break;
        default:
+               WARN(1, "Invalid queue type %d\n", type);
                dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
                return false;
        }
--
2.43.0


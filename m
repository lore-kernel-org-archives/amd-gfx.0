Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8575BCCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 334FE10E152;
	Wed, 29 Oct 2025 10:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MkfGoQ6c";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A2C10E152
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCe2C4an/4wgTRJMfXa+dupoZIyo+s0mqNm3/tpD+uFAuaNfULCgl0LWid8GLig7/F0Wuo9CaYk6oh31DlykJvIYXuxcoMeqJf6uNG49N+rIeC4RDsUudd7SYm2D8Hmgu/W/LA+FBfVJZ7dBQdceWLp0lZlxHtx7Viu4FWiDc5a6ofxo1Q3W/okWfT2zQ7j98kyLkKzfM8iowQSjm+y6uFrN9SHFAHi2MxMZI1dUqjeYXQQhxV89jmmZgcQbVBfxDU5w/qTBDhqN2cNRzWpIkrXn1gIwMk46n9J9Zk/2ODih0O1F3YJtZdUU9t0czwGZMzy6aCVArfaKCsbe5RPHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZKluKGNEsj4fYfdAMPZ+c1s3mUajHItkbz38wQX3EI=;
 b=S5HIvPKFzNtm0zqNF9dxcKhS2QCjUKEDbZFS4Rju/jEIHB4kt8iExVAjYc5aRV5GLjr3Ii4fhMNAeebfYjkktT6zLLJiARfFmy5RQsmtvUCgxrj4By4UM8olVhA6HnaNERa+4ufggl03QY73jRIFCrDACtlPEl1XAAXObU7GxEAqQ+BZkAV/OlSzhqvi1+aLvuyX92lF7lszw+64iJUZkAqrtppysNfGe7a7syIqcV0IaKVLdZFmQURiMTzoGpPoB/1E0+LU5Q/mW3Wq+6jJ4XEaEnkx/AscphWPQBoWIMxE7D3gmEFY7F7jYYS+GUbbtA1THOPoguyFI1ZXiTTXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZKluKGNEsj4fYfdAMPZ+c1s3mUajHItkbz38wQX3EI=;
 b=MkfGoQ6cOMfUp1I0M+QoultpdT2i73wegj7jQ2jTtutfDOow7fohTI92LC7Q+hNgG9XUxe/+jS00sbalmyCdKndK+CYJSXo7mevOkJERFJWKJ2AK26rB8StXpNRbJU8nhNJwKWxnZvTD4BA+fupDKjGuZbpSNLJeeKu0SfgtZxA=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 10:15:53 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%3]) with mapi id 15.20.9253.013; Wed, 29 Oct 2025
 10:15:53 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 02/10] drm/amd/pm: remove smu response check
Thread-Topic: [PATCH 02/10] drm/amd/pm: remove smu response check
Thread-Index: AQHcSLDDcuJSwsViL0K1GFFFT8HUTLTY1RWAgAAS4AA=
Date: Wed, 29 Oct 2025 10:15:52 +0000
Message-ID: <MW5PR12MB5684C9756A6AABB617BB68EFE5FAA@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20251029084751.1701305-1-ganglxie@amd.com>
 <20251029084751.1701305-2-ganglxie@amd.com>
 <PH7PR12MB599743F04F465AD3DD257AC782FAA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599743F04F465AD3DD257AC782FAA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-29T09:05:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|MW5PR12MB5598:EE_
x-ms-office365-filtering-correlation-id: ae89e392-3851-43ad-60d5-08de16d42437
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iS+o2OxkoVxdBEOhkBkOJlkGlZlf6bAoC+72XGPpcexvRGv9XMDsn6iAfYAq?=
 =?us-ascii?Q?dse9XeSVsvTkeM67ZwB3KMIa6vnG61mglpnITrcRx8ZVl91mgXtTo/sPlqHQ?=
 =?us-ascii?Q?Lmn76BijR47JrHxNBq1xk5dZBp79djHas/VpEO2xC0UlkHGEr+tcbdG+Z2dL?=
 =?us-ascii?Q?oThvSHpsst4IvHj3Yi+uetYol3pCBcO8m2QcI+we7ZqNoqZC0iFzJbQ/I0pR?=
 =?us-ascii?Q?Zhvyt6qWjAZ6gJEe0y895cL1YqeU8O4KrlINBsUivc4FGGshj2LY1zy+NBZw?=
 =?us-ascii?Q?HfKMnOKxIT/qNbPmqgwJApXdvaZSx4xGUGpYJkKKbTMlwwx6DkjrRXzLGJes?=
 =?us-ascii?Q?Cv1/ePdymfVaR7BCk94hh/uE3m6bQ0FXL+c5dY31ZGkDXnCJ5ILYT8WyYg8G?=
 =?us-ascii?Q?kLiDHnfNQMpq38YrisRctLIzlaoz1wEMx72FFJVWab6nwmfG9SfOW2Kn/i2v?=
 =?us-ascii?Q?J12wETeEelzmO3RUCZQmWny9q1MuDTHBet6QNA+g1vg9u0gYV7cv2wrqcB+i?=
 =?us-ascii?Q?DNbHks6NwWG38y/ju5IofhgWbvIcAbti3oO0jSiz3iX7RVet+DToPL2ifbWj?=
 =?us-ascii?Q?w5bdxrn0MlXWLOUwFXw5eKGC2pJO5ljl1fX8iclpaICUxw0cNtoKQ+eabgdR?=
 =?us-ascii?Q?gP7s/o58WltfS8DbMfRUrlA/Q6xu/ZNCoMuCQ7V6ZRXoYoRku47JgO/Qmm7i?=
 =?us-ascii?Q?DR+ATumqeMJwMq47F652VAzqvMXorZOPbcDALPejnci4Istl+g7tZFKIePBg?=
 =?us-ascii?Q?E+Qd5f+gOdkmzhMqjKrQLg/4hDzHsPduiUFC17wkUyEvfdStGaBw3+N+2bfT?=
 =?us-ascii?Q?KEXWo7+aJof7vw+ZEiC2TKexcRQYkwXTtZapyo5qhKlFzqcqnc6cav2yZr3D?=
 =?us-ascii?Q?QApl2UBJt7ORH94GyY8betZFoIwOubwnE3Ks4YcdZROLYPHGZ19jl3LObioD?=
 =?us-ascii?Q?gsUh1I+q6jitXep4g22lnczinKw6zMyHQTvAKXxdTr9LFh3JsLRr9mjpRigW?=
 =?us-ascii?Q?R5WwuUZ6wvkydieYhuUP80rH5psQo6XqYwtlF+uUxcYjf6hfPuetcDf4EzCd?=
 =?us-ascii?Q?BcpK9HCBXVVLQmEhi8Swpw9J4cG78kPnJkl/vPp4U2vMCQgxfJ34rCVsH/g6?=
 =?us-ascii?Q?cZo8BP3xSmupRFeRK3FQiXJ4VWRpLcqIdAcT5CfNhgA1dDjiPqpcO4qRX4Nh?=
 =?us-ascii?Q?6lJp6NRASeQgKOfIWNMjxC1Vl0LbUxxoaBnpF9vHb7tf/P2iA2b+z0w7TCBE?=
 =?us-ascii?Q?ST3bh9w9+ioiGWZ8gU6I9jMDd+PhgAex4D6fuAsBiGzjoOWUSJvaLS0cFa1h?=
 =?us-ascii?Q?2WEdxrvm4ZOXOBV6pRFYdHzYhNH1Tam8jF1N9wbOGW6ky/LSoHTIp+QDYSSf?=
 =?us-ascii?Q?FA8imWhWaV3fyUFV38H8WTb0KyzYQJU2Xos/goKmqrwxB0wJYBxfq1S15F1K?=
 =?us-ascii?Q?twPIIoMpQp/Gf73Kwv7CTq2Q6tLoQ8L8otBXxMLMkPmVWbrKa9hGGGbeEM+g?=
 =?us-ascii?Q?aqHUkk2368q0ZjP/7smZbleywgp7vjoq+pt1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zo7kXvSKGDk3h0RacOZfIMBobw1eGtLWiTrAj1STURubZTF3iBecQJYk4e1B?=
 =?us-ascii?Q?ujBeAf2B4JJeMJPQ7tcddZOmBRs/ismb2QCx74gWovS9bsyJRTG0fnXL55ET?=
 =?us-ascii?Q?C9f9GzfhFb/Jt17zALUZbKOrBLEdELQOkaKFRYPV2xvZWxSGKauHn8W2HZ3H?=
 =?us-ascii?Q?8nWjem9kTqoXJtwvS64nNkEo2Xag7XIlcJfZG2RVj/w47Ff4+gECqDf22vMH?=
 =?us-ascii?Q?8B0HwRd4KsF816DBO88I35verUa+922zuH9zeIrk44qVCgQ11ZRWFUypm86y?=
 =?us-ascii?Q?7yKTljXIA1o2iW8v/IrlSiDR1550fCmEqh9olEvxcm/RTvNH/WjI4wP9u9aq?=
 =?us-ascii?Q?tuEwf/K0tXv4+ROJfS+dOXjPpb/qAC1apktM97bMaGlQMdLjCfBiZ/7v+Cqu?=
 =?us-ascii?Q?vByH8GMn4rOLZo97ANllQu78Gor/Rm3nTSxyGfBs/ihy3WzQWirjnqXdkirW?=
 =?us-ascii?Q?LZwy6TdrgAe7U9QqHsn2GUA8z4K4tMK6g5KXo9u2n7Nbrxf0DTakMORj586e?=
 =?us-ascii?Q?s2v8xBLdGWE156NjmNcDnz2U4s6N/wjXc6zXX7steCsTS0O+xoLAJJSS+OW9?=
 =?us-ascii?Q?EYz53Bpcq2ooV13/tcM0kQjoOgX/0dcak7tn18eyjc0XLBSOCZrPurNBDMxN?=
 =?us-ascii?Q?FpYC6pIJiHYWZeEnHkIEeEvC5BULKs/udT2Ml/Exmrkt/OxIE43DeNFxsfW3?=
 =?us-ascii?Q?ngYxpTQyWqFZWJnm9zyCKg5neqmJGDNT1uXQaKOlkp97Eg/51RV0JaDu/iZz?=
 =?us-ascii?Q?FMoCyIalDre3NCHe4hqOBWNIgA90XS7ZepTgu+wxFlT1NwcVIftLIU8dZkAm?=
 =?us-ascii?Q?QrNW1M4VwfGdU+niV+NQmNQcIgxcxmQKEdyL3r/TZ3kg9xvd0GW51J8a/gfs?=
 =?us-ascii?Q?3Z7IeQsNgYR+TtddSirgrsyudu+56E4bVyN2/O9iVEieQ+qHcbhfjpbgHnXJ?=
 =?us-ascii?Q?bIsDbAn8225pjQrZ7LHPPQoXeDVpvJon1R7ZwsbSHOHPXO4KfpEojkH5viud?=
 =?us-ascii?Q?fq0RvGr9Vr6Oa2ZJJ7V9PQRYRvOX3f5E9bwzIL6bhM+hRZJGpM7Yu/UvwDRk?=
 =?us-ascii?Q?Kgof1kTWxOzdcPrJE2sxPXk9FU/IGCv6lRMiHLwCAIek7/vfffyi9/tS+hRL?=
 =?us-ascii?Q?+3niv6Y0TWVoJY5lhOICwT2UwKxi12808JjxLLf4IzAhHXnl4QrteJpUTF3/?=
 =?us-ascii?Q?JbXzsOVQLgA+celG4uk2QAmDBK8RNpo+PnwESZ10YVRb4xDE7UPK3sXBJwmZ?=
 =?us-ascii?Q?9OzWAMnMsqScqM44QP4W/w7J0nSj0RJmw+u4JyZo/jKHNJG05BXAx+LF9hyt?=
 =?us-ascii?Q?wQM93xjk/GzbV3R+L0NHVGAkEz1WnIkRipTQPhNXn6FDA/qMczYize/3kOuJ?=
 =?us-ascii?Q?vK7rHSSW1G0B6f6Ss1gnK0aVVsAe+pba1t87vkIqm11+5m8mjA7WnByPf3e1?=
 =?us-ascii?Q?t+oen9b48B0SyCJvnNMa//PMiOiGKhx+lZkdjfe7eCrd8PMD+h2a8IEoXMeG?=
 =?us-ascii?Q?rCOlcBo5FE62SZJioRPvA3egLXP9sPb9MFsxbNwsjCZ/k8gWDiLdXYeIIfoZ?=
 =?us-ascii?Q?+9S0Jd3paukiApNoqBk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae89e392-3851-43ad-60d5-08de16d42437
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 10:15:52.9266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zne7tKbG9lLQVinGL1XTpdRzEhu0oNcyk/BLcvqFzXLwMNHIm0sWV3pxyLjhy8MUe8psWrRp4aNxjU2sZuxebw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
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

Thanks, Kevin
Will remove this macro before submitting

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, October 29, 2025 5:06 PM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
Subject: RE: [PATCH 02/10] drm/amd/pm: remove smu response check

[AMD Official Use Only - AMD Internal Distribution Only]

-       case SMU_RESP_DEBUG_END:

Please remove this macro together,  with that fixed, the patch is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ganglian=
g Xie
Sent: Wednesday, October 29, 2025 4:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH 02/10] drm/amd/pm: remove smu response check

Remove switch entry for SMU_RESP_DEBUG_END to process it in default entry a=
s a generic error, because its meaning may varies among different socs.

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index a8961a8f5c42..eea5ff69e5ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -168,10 +168,6 @@ static void __smu_cmn_reg_print_error(struct smu_conte=
xt *smu,
                                    "SMU: I'm very busy for your command: i=
ndex:%d param:0x%08X message:%s",
                                    msg_index, param, message);
                break;
-       case SMU_RESP_DEBUG_END:
-               dev_err_ratelimited(adev->dev,
-                                   "SMU: I'm debugging!");
-               break;
        case SMU_RESP_UNEXP:
                if (amdgpu_device_bus_status_check(smu->adev)) {
                        /* print error immediately if device is off the bus=
 */
--
2.34.1



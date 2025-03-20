Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E226AC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 06:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C0910E591;
	Thu, 20 Mar 2025 06:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t6EqRU+6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9B110E591
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 06:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFIO50YpwEHzT1bHWFWAR//9VO0+BAuczUhmDM5bqlxFQnuKqDIwgb1YyDZW+nT+CmnXa4jSMpaWoROENLY1xTtqpDWaxdhEszkdRJVgg+m2+8dKB4+YTpgmFyVbeDW70I6zbCT6J9GPnwL9IQf9iK9SJ2vgw0kT79O1f+Sl3euMX/zKd+kt+dJeljv4O6oGPF4p33U5sb7McnEqkurI0Vpk7uc4+k/U5IvmhsMCoU9pRv9cyi8TqNdPb+LGLkxFdS5TfxGQwJ7SGeFMgcNEvNROwLDjJWGrZ20dIXAvHvEN5JtQBWiYUQjnEQy40nUonvSIfezkMuhHSimG7MP3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm5UxyG79T98hq8bzwRc6xsPrtJaJ6LSOndg3AVf5Y8=;
 b=qniJD+ePToiGDelzPBYLIyqKgulteycuwQAiZQIvf7gfRk2LiQfrB1ZOJry7Kmacjo1tiJBPpMyANLSuq3QRKTLs1TRPIY2DB6IoFc+0Exs0JeDWWQAuPczi80o2mIjAYRmMMlYbCx4jXAQVeaggb7dzSXQEuU9hhioFAIbQ9KSEMhPQuqnnu8n0e6NpOKcNAbmXJcAOUysKYPE53tc9Ox3VdtQ+1DiG+rSrsOPgQMQ3Z32YkbtRLvIl7O8E8Jk1Ynll5LPKupAZQSYj+5Leeb/znMGrpcCa2O0o0iL1yfL3xfTxt6hLLHTnxelDgJ/XzeFOqGNJ8i1DT1GAlBpW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm5UxyG79T98hq8bzwRc6xsPrtJaJ6LSOndg3AVf5Y8=;
 b=t6EqRU+6w2RsvV6TxjuDSNi/LOihoE8rYcENX1jDn4oEAlRwu2N+pU+YEZ9aw8qdlBdjzo4y3i1lSyaP99VaXGQS4nezwJwR933dbzLMgQayx9T+qYZ4eh+swv1fdiSATc/bmheLf7ZdRy8H8MPKty10Al5tLHjnzl6l87AXpJE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS5PPF6BCF148B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::652)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 06:26:42 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 06:26:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Use dev_* instead of pr_* for messages
Thread-Topic: [PATCH] drm/amdkfd: Use dev_* instead of pr_* for messages
Thread-Index: AQHbmVWQuddPElLCEEG3UBhDq1kue7N7jxxA
Date: Thu, 20 Mar 2025 06:26:41 +0000
Message-ID: <BN9PR12MB52570DE556F1C207B537C37AFCD82@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250320050404.362969-1-lijo.lazar@amd.com>
In-Reply-To: <20250320050404.362969-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cb7cb546-2eb6-4d7b-aaaf-45b3f1cea220;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T06:25:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS5PPF6BCF148B6:EE_
x-ms-office365-filtering-correlation-id: 8c300b91-2bbb-48bd-8aaa-08dd67782dcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MdkC5kQhC5/eV5G8CsM5Jac8oPwBsyxQZf2KbjNZAkz0IsH5CoKUofmmaGZX?=
 =?us-ascii?Q?j612CK/JI7eWguUzhMgvHPj8iSRP5zmC0kBLQy//6OZFycEYdWXcn5WWcW7j?=
 =?us-ascii?Q?8hpPGMyrWj3UJmA9nXxKariv2svU5ilfT3omqkOEElVnkEPDKmIhABsS2/Xm?=
 =?us-ascii?Q?uAx56qiPMBioZsIOhDS5EwdPxj/kbJLq7HxW/EBpapNaGtIT1J+maBBubnq1?=
 =?us-ascii?Q?edxa8fflWlO6uCMMyitp6n2nj9Oi0zOWObSuqZCsGOSVI31hSQkuXPtFtVcv?=
 =?us-ascii?Q?rer3hcEwpDs3LLiPKLuba/3txnGz/hZ1IgLOG7uGiWmfaOvtn/g+wWPpKHB1?=
 =?us-ascii?Q?4ZeuyS9hkYH7bjVu8T8z979JhNDBe0WxSYJEbBo5cTVd26J20chVe9N9ZZAB?=
 =?us-ascii?Q?N/LVxfxkGTNswuCrmxs91focx471eX9Pp2YpY45+aQXbZZeAsVopMiPvUOQj?=
 =?us-ascii?Q?3/W1MtJZv/i0L37IKR337pG5b9hBLdLRFFpt7eL7HWxM435/JozS1vLMYBlx?=
 =?us-ascii?Q?ksb0DQ8iq5P0ia0n86SsMHnYlITf+zLv9B4wIJS1QRbjL/RM7hM065DtftLR?=
 =?us-ascii?Q?4XWbrzAH1GeAlY337JZVqGJtGjCwdV776W3zjixAW7K7HnWlSrf8zDcf80wF?=
 =?us-ascii?Q?YA800P23FMcIQnw+G/azvcysdOa9/oduxfmHFW8cGDr7LsKXsN5uRgUoMWw9?=
 =?us-ascii?Q?OywaQlL8jn1d0hEqLD2R2EbPpQhHKC+D3kx/JSxgfprLHqg5e6sBXQ0Ff0D9?=
 =?us-ascii?Q?lYbJ3ykvaa/jkM8ocwSj1RhFIp2eevdkT50gIIiQn0mMKxCw6PgPxhvSIOUi?=
 =?us-ascii?Q?aGsvoK6hlwim9MBDYZ6HJ4QLLcnowLjFxyr2qbPoS5BzuIC6npq1Ms7hj3v4?=
 =?us-ascii?Q?XvCToG0HdI8RrFZFHq1oiCNY3t7cjpCC9Z9jy/bIKBZ4ex+E4TZMc3kyczdR?=
 =?us-ascii?Q?H7E3RWgyNDPS2QoG5NTFKYIxHvnItfFv7itu/UYHM5iUCb/MNAY0ZLGq5nQq?=
 =?us-ascii?Q?HCR0LtAr5re8BvAgbes56tow6d0MwG51+8gA6G1MnPnAPpDCor9Xbj8oH23I?=
 =?us-ascii?Q?X/UYKGdAOdgiRrT9hThH9R8Eg2j7/FeBiJPB0KGbG8K9p5Bo0nOPRVKlxSn/?=
 =?us-ascii?Q?W04zx8OMbXb+BJvbMa0G1ABSHnV/C50R81WkmIYv79fv70GGaQr8EWPTw37y?=
 =?us-ascii?Q?BeJbjh/pn4Gtgrs0l6lO3kW/Ll0bwGoJU4hZft0iXUpdms7sWS+x3Spkd2kv?=
 =?us-ascii?Q?rXB0Tolu1FDI3Tk6uStqzQju6VJiT2qfLBnGZGDsqsdFxPkycuj9T33ZgpFO?=
 =?us-ascii?Q?dEXyGJUDhyw7cXFzrO075MJenlznUEQkIPu4x5mZTZQF4hUeZqka92hIojVq?=
 =?us-ascii?Q?mWqPrY1cna77fw5tjxQMxJu8ac75uax7JuHop9noDF1hosOtTLSecdaia27/?=
 =?us-ascii?Q?jE5R3Iy/uomJWjUOMh8t/tpx6pkcYjLZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PixFlM2GWiAs34WWJBRz3K7mTMqndmWZWhHdyFus/TNhroWABrcoeqByxFBZ?=
 =?us-ascii?Q?TUZFS7BecZgK/SaHX9FB+Lrt6YvUjDXSJ3YU4U0/QRRw0WerhDhiR9ot8U35?=
 =?us-ascii?Q?Z+UnFU4oEWr06DuW+W8M4KNjeE6qzOTYMm/sx+RiJ6Htu/GVjPl+QE9vBRkx?=
 =?us-ascii?Q?rqjgCnl32luJGRxHjoCmwZBNKa8A+ucCvjIb94wJWtaa5qhX+zQsGhi+Pcaw?=
 =?us-ascii?Q?h3D6pSiHtt5cN2fqHj2y+YeglxdGRcsBzUF/lvYk8gdtvZfGai1kG0ONp1LY?=
 =?us-ascii?Q?srEUrfg/Zj3e60z4gVKYIV8cXDAeiCZKZ3sS+154tOyz+vIxz5EKSrjzFvvR?=
 =?us-ascii?Q?Os0gc/Q1der/dNRa9qPNxk5ooltAcYnZuMR40KnnR67mkYZZZJq1lX81RYEF?=
 =?us-ascii?Q?OU5m6bKt524am3svw5vt62IaaheBHexMQaYxjLTkrMJ87sbRCkDuDXHm8KaX?=
 =?us-ascii?Q?1Wpe1NcrojH0hUFbKVIPcN6TgzxkNp/HU16Xs0T04HtxxoJ/XYbPk0Wf6C1M?=
 =?us-ascii?Q?7QJex5chShfOeUqdt+iJ4zqsRuN97EVLEnb2V9bRIaQy0DTOyjGPki1hbQMk?=
 =?us-ascii?Q?SRugnbOkWH1CNt44FFpu7h5KLc/579httF4b0k0VTsajHsBLiE+Gw+xwbzYu?=
 =?us-ascii?Q?WJF4Y34vd05hrsXRSJdq7cARvP5Ptqp6ionbuZndcmFn4y7IveKxCNcnIuox?=
 =?us-ascii?Q?VAtda2/ETulhpxQNPoLgYcf0vX19oKi9QNrGtzvXKRlF6/wAavEZevaRuaCB?=
 =?us-ascii?Q?BeM4GNemU5UhPvGMKxrAO0jyATNVCD/NhwRK9LUKvpSuQp7HS3dUC2MRQzZr?=
 =?us-ascii?Q?aSWnOIGvOzRfL5sA2pmPeQrgmsCDrAcgzlFPNgNtwFdZsmvi0e4/G1kaGuy2?=
 =?us-ascii?Q?0yHbpJdE12B+hiqeYtYHehCb/jQImcJltEPXj15NMr+g6Knd3hwD+TrhJCTZ?=
 =?us-ascii?Q?L5wLzQHvfhh8LnZ1IL8tb31lLb+pXp7XYTwfF5C6dOSb4RNAorVp/hTnNuYs?=
 =?us-ascii?Q?Dq/f+AV83kEvLf6+f32bqh2774ikmUz3XmQ4N4CagcwU7kWD7jco1NdkvxTp?=
 =?us-ascii?Q?JegMRde+dwwX1+ws3TlCIbuFTdSdWMY179Y59QxfWE4c2OMgY7FiUHBR/hWG?=
 =?us-ascii?Q?xKn1C3DF7pXHo5DIvaCOOCt3yQS8Sti9dfna4DV+vv6VbsQGkOBOzC1MEosM?=
 =?us-ascii?Q?WmuZKiBDiJSxVDaIrtbglY6XPTl8L3Xp6dhZH0yP+ku+CDQbwwjYqiN07Jb/?=
 =?us-ascii?Q?RFPmb8Ud4kB+94K81CZxhrNs5nGkyOgiy0l3KVcmYB/jIMd4M0oNe6GzeYwt?=
 =?us-ascii?Q?wlakMXyAxL1r3wN3F8xN3XV9CA0nJisrqZjSd/bpzrSIIPydb8PuVzBNulrz?=
 =?us-ascii?Q?r10Bq6UpIwHALf4PNFEBgwDD+ZYIPVNCLAMfDaRYBZAbRc92v1Of+hFlTz2O?=
 =?us-ascii?Q?2RoGlPjNDOYDu7v+euJ1vEdiXzvHmfxlXUF0a5xKevjhWdtGhJasaQnyoFCD?=
 =?us-ascii?Q?DxNwqkfmvjCzwZ5LHuKIeKHcY7rFCKb07zJqeZf1WEqm9RNt5S4qLsz4HfoG?=
 =?us-ascii?Q?sTt91Klhf9dAovDWMyWXHtW5KKn4oM2DEtnxV/7g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c300b91-2bbb-48bd-8aaa-08dd67782dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 06:26:41.8137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/tSknbzInq6P3C5Pa/1xo9mSiOJ15y4qZGEFRqxfKzsY6dqUng1yFlRHtM9CSNLjG3nbswJNuTxezbxnkYV5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF6BCF148B6
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, March 20, 2025 13:04
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; =
Lin, Amber <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Use dev_* instead of pr_* for messages

To get the device context, replace pr_ with dev_ functions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 142 ++++++++++++------  ..=
./gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  92 ++++++++----
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 142 ++++++++++++++----
 3 files changed, 263 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_int_process_v10.c
index 37b69fe0ede3..54870b4c5000 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -168,11 +168,12 @@ static bool event_interrupt_isr_v10(struct kfd_node *=
dev,
            client_id !=3D SOC15_IH_CLIENTID_SE3SH)
                return false;

-       pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw da=
ta:\n",
-                client_id, source_id, vmid, pasid);
-       pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
-                data[0], data[1], data[2], data[3],
-                data[4], data[5], data[6], data[7]);
+       dev_dbg(dev->adev->dev,
+               "client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw dat=
a:\n",
+               client_id, source_id, vmid, pasid);
+       dev_dbg(dev->adev->dev, "%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n"=
,
+               data[0], data[1], data[2], data[3], data[4], data[5], data[=
6],
+               data[7]);

        /* If there is no valid PASID, it's likely a bug */
        if (WARN_ONCE(pasid =3D=3D 0, "Bug: No PASID in KFD interrupt")) @@=
 -217,37 +218,66 @@ static void event_interrupt_wq_v10(struct kfd_node *dev=
,
                                                SQ_INTERRUPT_WORD_WAVE_CTXI=
D1, ENCODING);
                        switch (encoding) {
                        case SQ_INTERRUPT_WORD_ENCODING_AUTO:
-                               pr_debug_ratelimited(
+                               dev_dbg_ratelimited(
+                                       dev->adev->dev,
                                        "sq_intr: auto, se %d, ttrace %d, w=
lt %d, ttrac_buf0_full %d, ttrac_buf1_full %d, ttrace_utc_err %d\n",
-                                       REG_GET_FIELD(context_id1, SQ_INTER=
RUPT_WORD_AUTO_CTXID1,
-                                                       SE_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID0,
-                                                       THREAD_TRACE),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID0,
-                                                       WLT),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID0,
-                                                       THREAD_TRACE_BUF0_F=
ULL),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID0,
-                                                       THREAD_TRACE_BUF1_F=
ULL),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID0,
-                                                       THREAD_TRACE_UTC_ER=
ROR));
+                                       REG_GET_FIELD(
+                                               context_id1,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D1,
+                                               SE_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D0,
+                                               THREAD_TRACE),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D0,
+                                               WLT),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D0,
+                                               THREAD_TRACE_BUF0_FULL),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D0,
+                                               THREAD_TRACE_BUF1_FULL),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D0,
+                                               THREAD_TRACE_UTC_ERROR));
                                break;
                        case SQ_INTERRUPT_WORD_ENCODING_INST:
-                               pr_debug_ratelimited("sq_intr: inst, se %d,=
 data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
-                                       REG_GET_FIELD(context_id1, SQ_INTER=
RUPT_WORD_WAVE_CTXID1,
-                                                       SE_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID0,
-                                                       DATA),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID0,
-                                                       SA_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID0,
-                                                       PRIV),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID0,
-                                                       WAVE_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID0,
-                                                       SIMD_ID),
-                                       REG_GET_FIELD(context_id1, SQ_INTER=
RUPT_WORD_WAVE_CTXID1,
-                                                       WGP_ID));
+                               dev_dbg_ratelimited(
+                                       dev->adev->dev,
+                                       "sq_intr: inst, se %d, data 0x%x, s=
a %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
+                                       REG_GET_FIELD(
+                                               context_id1,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D1,
+                                               SE_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D0,
+                                               DATA),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D0,
+                                               SA_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D0,
+                                               PRIV),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D0,
+                                               WAVE_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D0,
+                                               SIMD_ID),
+                                       REG_GET_FIELD(
+                                               context_id1,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D1,
+                                               WGP_ID));
                                if (context_id0 & SQ_INTERRUPT_WORD_WAVE_CT=
XID0__PRIV_MASK) {
                                        if (kfd_set_dbg_ev_from_interrupt(d=
ev, pasid,
                                                        KFD_DEBUG_DOORBELL_=
ID(context_id0),
@@ -259,21 +289,37 @@ static void event_interrupt_wq_v10(struct kfd_node *d=
ev,
                        case SQ_INTERRUPT_WORD_ENCODING_ERROR:
                                sq_intr_err_type =3D REG_GET_FIELD(context_=
id0, KFD_CTXID0,
                                                                ERR_TYPE);
-                               pr_warn_ratelimited("sq_intr: error, se %d,=
 data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d, err_type %d\=
n",
-                                       REG_GET_FIELD(context_id1, SQ_INTER=
RUPT_WORD_WAVE_CTXID1,
-                                                       SE_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID0,
-                                                       DATA),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID0,
-                                                       SA_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID0,
-                                                       PRIV),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID0,
-                                                       WAVE_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID0,
-                                                       SIMD_ID),
-                                       REG_GET_FIELD(context_id1, SQ_INTER=
RUPT_WORD_WAVE_CTXID1,
-                                                       WGP_ID),
+                               dev_warn_ratelimited(
+                                       dev->adev->dev,
+                                       "sq_intr: error, se %d, data 0x%x, =
sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d, err_type %d\n",
+                                       REG_GET_FIELD(
+                                               context_id1,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D1,
+                                               SE_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D0,
+                                               DATA),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D0,
+                                               SA_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D0,
+                                               PRIV),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D0,
+                                               WAVE_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D0,
+                                               SIMD_ID),
+                                       REG_GET_FIELD(
+                                               context_id1,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D1,
+                                               WGP_ID),
                                        sq_intr_err_type);
                                break;
                        default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_int_process_v11.c
index c5f97e6e36ff..eb88ba8d8b01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -148,44 +148,69 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 #define KFD_CTXID0_DOORBELL_ID(ctxid0)         ((ctxid0) & \
                                KFD_CTXID0_DOORBELL_ID_MASK)

-static void print_sq_intr_info_auto(uint32_t context_id0, uint32_t context=
_id1)
+static void print_sq_intr_info_auto(struct kfd_node *dev, uint32_t context=
_id0,
+                                   uint32_t context_id1)
 {
-       pr_debug_ratelimited(
+       dev_dbg_ratelimited(
+               dev->adev->dev,
                "sq_intr: auto, ttrace %d, wlt %d, ttrace_buf_full %d, reg_=
tms %d, cmd_tms %d, host_cmd_ovf %d, host_reg_ovf %d, immed_ovf %d, ttrace_=
utc_err %d\n",
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, T=
HREAD_TRACE),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+                             THREAD_TRACE),
                REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, W=
LT),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, T=
HREAD_TRACE_BUF_FULL),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, R=
EG_TIMESTAMP),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, C=
MD_TIMESTAMP),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, H=
OST_CMD_OVERFLOW),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, H=
OST_REG_OVERFLOW),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, I=
MMED_OVERFLOW),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, T=
HREAD_TRACE_UTC_ERROR));
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+                             THREAD_TRACE_BUF_FULL),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+                             REG_TIMESTAMP),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+                             CMD_TIMESTAMP),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+                             HOST_CMD_OVERFLOW),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+                             HOST_REG_OVERFLOW),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+                             IMMED_OVERFLOW),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+                             THREAD_TRACE_UTC_ERROR));
 }

-static void print_sq_intr_info_inst(uint32_t context_id0, uint32_t context=
_id1)
+static void print_sq_intr_info_inst(struct kfd_node *dev, uint32_t context=
_id0,
+                                   uint32_t context_id1)
 {
-       pr_debug_ratelimited(
+       dev_dbg_ratelimited(
+               dev->adev->dev,
                "sq_intr: inst, data 0x%08x, sh %d, priv %d, wave_id %d, si=
md_id %d, wgp_id %d\n",
                REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, D=
ATA),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, S=
H_ID),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+                             SH_ID),
                REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, P=
RIV),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, W=
AVE_ID),
-               REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1, S=
IMD_ID),
-               REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1, W=
GP_ID));
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+                             WAVE_ID),
+               REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
+                             SIMD_ID),
+               REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
+                             WGP_ID));
 }

-static void print_sq_intr_info_error(uint32_t context_id0, uint32_t contex=
t_id1)
+static void print_sq_intr_info_error(struct kfd_node *dev, uint32_t contex=
t_id0,
+                                    uint32_t context_id1)
 {
-       pr_warn_ratelimited(
+       dev_warn_ratelimited(
+               dev->adev->dev,
                "sq_intr: error, detail 0x%08x, type %d, sh %d, priv %d, wa=
ve_id %d, simd_id %d, wgp_id %d\n",
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, =
DETAIL),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, =
TYPE),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, =
SH_ID),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, =
PRIV),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, =
WAVE_ID),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1, =
SIMD_ID),
-               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1, =
WGP_ID));
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0,
+                             DETAIL),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0,
+                             TYPE),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0,
+                             SH_ID),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0,
+                             PRIV),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0,
+                             WAVE_ID),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1,
+                             SIMD_ID),
+               REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1,
+                             WGP_ID));
 }

 static void event_interrupt_poison_consumption_v11(struct kfd_node *dev, @=
@ -255,11 +280,12 @@ static bool event_interrupt_isr_v11(struct kfd_node *d=
ev,
            (context_id0 & AMDGPU_FENCE_MES_QUEUE_FLAG))
                return false;

-       pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw da=
ta:\n",
-                client_id, source_id, vmid, pasid);
-       pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
-                data[0], data[1], data[2], data[3],
-                data[4], data[5], data[6], data[7]);
+       dev_dbg(dev->adev->dev,
+               "client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw dat=
a:\n",
+               client_id, source_id, vmid, pasid);
+       dev_dbg(dev->adev->dev, "%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n"=
,
+               data[0], data[1], data[2], data[3], data[4], data[5], data[=
6],
+               data[7]);

        /* If there is no valid PASID, it's likely a bug */
        if (WARN_ONCE(pasid =3D=3D 0, "Bug: No PASID in KFD interrupt")) @@=
 -353,10 +379,10 @@ static void event_interrupt_wq_v11(struct kfd_node *dev=
,
                                        SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCO=
DING);
                        switch (sq_int_enc) {
                        case SQ_INTERRUPT_WORD_ENCODING_AUTO:
-                               print_sq_intr_info_auto(context_id0, contex=
t_id1);
+                               print_sq_intr_info_auto(dev, context_id0, c=
ontext_id1);
                                break;
                        case SQ_INTERRUPT_WORD_ENCODING_INST:
-                               print_sq_intr_info_inst(context_id0, contex=
t_id1);
+                               print_sq_intr_info_inst(dev, context_id0, c=
ontext_id1);
                                sq_int_priv =3D REG_GET_FIELD(context_id0,
                                                SQ_INTERRUPT_WORD_WAVE_CTXI=
D0, PRIV);
                                if (sq_int_priv && (kfd_set_dbg_ev_from_int=
errupt(dev, pasid, @@ -366,7 +392,7 @@ static void event_interrupt_wq_v11(s=
truct kfd_node *dev,
                                        return;
                                break;
                        case SQ_INTERRUPT_WORD_ENCODING_ERROR:
-                               print_sq_intr_info_error(context_id0, conte=
xt_id1);
+                               print_sq_intr_info_error(dev, context_id0, =
context_id1);
                                sq_int_errtype =3D REG_GET_FIELD(context_id=
0,
                                                SQ_INTERRUPT_WORD_ERROR_CTX=
ID0, TYPE);
                                if (sq_int_errtype !=3D SQ_INTERRUPT_ERROR_=
TYPE_ILLEGAL_INST && diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_proces=
s_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index b8a91bf4ef30..4ceb251312a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -314,11 +314,12 @@ static bool event_interrupt_isr_v9(struct kfd_node *d=
ev,
                                        & ~pasid_mask) | pasid);
        }

-       pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw da=
ta:\n",
-                client_id, source_id, vmid, pasid);
-       pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
-                data[0], data[1], data[2], data[3],
-                data[4], data[5], data[6], data[7]);
+       dev_dbg(dev->adev->dev,
+               "client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw dat=
a:\n",
+               client_id, source_id, vmid, pasid);
+       dev_dbg(dev->adev->dev, "%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n"=
,
+               data[0], data[1], data[2], data[3], data[4], data[5], data[=
6],
+               data[7]);

        /* If there is no valid PASID, it's likely a bug */
        if (WARN_ONCE(pasid =3D=3D 0, "Bug: No PASID in KFD interrupt")) @@=
 -379,28 +380,82 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
                        encoding =3D REG_GET_FIELD(context_id0, SQ_INTERRUP=
T_WORD_WAVE_CTXID, ENCODING);
                        switch (encoding) {
                        case SQ_INTERRUPT_WORD_ENCODING_AUTO:
-                               pr_debug_ratelimited(
+                               dev_dbg_ratelimited(
+                                       dev->adev->dev,
                                        "sq_intr: auto, se %d, ttrace %d, w=
lt %d, ttrac_buf_full %d, reg_tms %d, cmd_tms %d, host_cmd_ovf %d, host_reg=
_ovf %d, immed_ovf %d, ttrace_utc_err %d\n",
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID, SE_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID, THREAD_TRACE),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID, WLT),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID, THREAD_TRACE_BUF_FULL),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID, REG_TIMESTAMP),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID, CMD_TIMESTAMP),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID, HOST_CMD_OVERFLOW),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID, HOST_REG_OVERFLOW),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID, IMMED_OVERFLOW),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_AUTO_CTXID, THREAD_TRACE_UTC_ERROR));
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D,
+                                               SE_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D,
+                                               THREAD_TRACE),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D,
+                                               WLT),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D,
+                                               THREAD_TRACE_BUF_FULL),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D,
+                                               REG_TIMESTAMP),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D,
+                                               CMD_TIMESTAMP),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D,
+                                               HOST_CMD_OVERFLOW),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D,
+                                               HOST_REG_OVERFLOW),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D,
+                                               IMMED_OVERFLOW),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_AUTO_CTXI=
D,
+                                               THREAD_TRACE_UTC_ERROR));
                                break;
                        case SQ_INTERRUPT_WORD_ENCODING_INST:
-                               pr_debug_ratelimited("sq_intr: inst, se %d,=
 data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, intr_data 0x%=
x\n",
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, SE_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, DATA),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, SH_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, PRIV),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, WAVE_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, SIMD_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, CU_ID),
+                               dev_dbg_ratelimited(
+                                       dev->adev->dev,
+                                       "sq_intr: inst, se %d, data 0x%x, s=
h %d, priv %d, wave_id %d, simd_id %d, cu_id %d, intr_data 0x%x\n",
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               SE_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               DATA),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               SH_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               PRIV),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               WAVE_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               SIMD_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               CU_ID),
                                        sq_int_data);
                                if (context_id0 & SQ_INTERRUPT_WORD_WAVE_CT=
XID__PRIV_MASK) {
                                        if (kfd_set_dbg_ev_from_interrupt(d=
ev, pasid, @@ -412,14 +467,37 @@ static void event_interrupt_wq_v9(struct k=
fd_node *dev,
                                break;
                        case SQ_INTERRUPT_WORD_ENCODING_ERROR:
                                sq_intr_err =3D REG_GET_FIELD(sq_int_data, =
KFD_SQ_INT_DATA, ERR_TYPE);
-                               pr_warn_ratelimited("sq_intr: error, se %d,=
 data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, err_type %d\n=
",
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, SE_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, DATA),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, SH_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, PRIV),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, WAVE_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, SIMD_ID),
-                                       REG_GET_FIELD(context_id0, SQ_INTER=
RUPT_WORD_WAVE_CTXID, CU_ID),
+                               dev_warn_ratelimited(
+                                       dev->adev->dev,
+                                       "sq_intr: error, se %d, data 0x%x, =
sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, err_type %d\n",
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               SE_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               DATA),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               SH_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               PRIV),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               WAVE_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               SIMD_ID),
+                                       REG_GET_FIELD(
+                                               context_id0,
+                                               SQ_INTERRUPT_WORD_WAVE_CTXI=
D,
+                                               CU_ID),
                                        sq_intr_err);
                                if (sq_intr_err !=3D SQ_INTERRUPT_ERROR_TYP=
E_ILLEGAL_INST &&
                                        sq_intr_err !=3D SQ_INTERRUPT_ERROR=
_TYPE_MEMVIOL) {
--
2.25.1


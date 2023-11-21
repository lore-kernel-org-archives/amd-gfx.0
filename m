Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BDCC54FB9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 06:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B6B10E0D0;
	Tue, 21 Nov 2023 06:57:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A847110E0D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 06:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ9wLQuyKaK0PMvAz7LOfKfxGPG1MkgobHIFd4R125f4Nc7gJSUMHzdrhdOhyMZA1WTWaKT66wYNwDnaD4mZOAuwniMpdXM+vndBtVLSgyjFIC9SsFFZDNhVaFvCMlMuQAX5uOzrZqhg/glDjh7ZV54Wwf0stoaxnN4QCFGm9XOnf5gQvHlvYvPkZ6Y3yD5ZLEqYr8w/PQAix1PzZvYT3u5QGUTp6L+lmSoLspw2QVSyb2Ant3jt2ialQIt7iDHoBmtobG+iFB5M+QrGeFlV13t3vKcyldqqA5DzWuVLnn1xrEL0cy2Y2Cy3xqlAo2srWHEe5efn6BohMhQfSKvsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d2lqNcVl01PLJVclCEcRlx1TxDz0fsFlcTp/ILn4QE=;
 b=PdsyiUBxPYvJG7v2v5zo61jMD10CCscNRuC7mHxk0TrW0K8ZQLqLMyJFTIUg5PFui+EBDTKRJG1HeN9zK1P5SUgd3MESyO1iEypIQyTP6/isO2iOqeYtyxfsPDYJNVIBI3tMv8JCtoO2UkoMP3vJ6Ned1rpleP/WUbUQ5DxZrPx0PzDTqZfnW3UK00NlmUCeenav4StiTxokiaRLfU9SeIVal0p9lu9gpyt7K1vw/rFw/M3+wonFsMARLdTDaNk1Uk+u7R4QfBMbLnvzL2zf2FAwMDcLk59f2rfeqA/alX4wSA/kVzUp8jAw2sfhr7qbwuGBWaVtzof1ebiJ+tRgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d2lqNcVl01PLJVclCEcRlx1TxDz0fsFlcTp/ILn4QE=;
 b=3ArtZVUOtqruoWm1o0BDw9Q0dsFQyDZNTsj4Qr2BiaZhZzj0efkspMJKeOMMt5Aq0T1XWL3e3SBvzoWGMJjo+ch0hQ1r13v6kNwbtbl7tbkMBFo2jNMFXGocEB297b2n2HwlclIgt9qk1xHogH+YCklIZtouK5am//UaWJdlwj0=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 06:57:02 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 06:57:02 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix memory overflow in the IB test
Thread-Topic: [PATCH] drm/amdgpu: fix memory overflow in the IB test
Thread-Index: AQHaHEOfQZKUHlimFUuK3ZQgyS3E37CEVkjA
Date: Tue, 21 Nov 2023 06:57:02 +0000
Message-ID: <CY5PR12MB6369EBC6193C0EDBC7695B67C1BBA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231121062533.664725-1-Tim.Huang@amd.com>
In-Reply-To: <20231121062533.664725-1-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ffd80dfa-6f3e-45d8-89e1-3723cb23cbc4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-21T06:53:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM4PR12MB5056:EE_
x-ms-office365-filtering-correlation-id: ead3df2f-2067-49ca-d8ba-08dbea5f10cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OywB+8Wz/g9oOsbsA4v6aO5coaRRZWnhUsGkoyxQ3kJ4h3c1Xgnq/J5ZP7NCJTJgwIvV+BAEljJwnSm3nfEph3LM+1QO7yXMMSgDq0ybwVudF6SZReqdxX/MVfKGPzlpqkzBDu0yI58La7UrU0rcIGEvdOUuUVDCzci4hASs0ivXFnyPdstt6xk+M2tGDnAOj3bu0IH1BnEqqNOPEBLCsh+MVuuFz9jL7zzT3pgEdQkDPhb95hg3GMiXudlTY1vd8Rz42bhjnFHdyyRiC0CvbDiL8jmzrLtMsks4n5qejOq1DDHjaEtcCyS5is5Ln6V/j0ObdoTYeH+irCOmW6F38fmaWIOPuQiYdlZfC89/zAz11lBDcLX5lf2qc4OYrhng+0qDY5ZgGDF4VE0q9oQyxlOTumk6sKMLwWBEKUZWuYmPzhzlsqeIkgn/xVrwjyEUUZkkJXD04FXp7vqPAsBLH4c9PEJcM4hWSKxphO7OhIxzrsQMRogNpJL879tiQTHcP39KMAHGsyW1zObGU+4q9cmX8DROcPElkB3KRdNqu6ABZmyckzyN5r38husvAJ3ZXv9Fh1l8bphHGQzvY6JTxSSptzqXrp0Ra57Y8CeuRA7zGCAhnOFFT04HvempPWe4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(7696005)(53546011)(26005)(71200400001)(9686003)(55016003)(316002)(478600001)(122000001)(83380400001)(66946007)(66556008)(110136005)(66476007)(64756008)(76116006)(66446008)(52536014)(8676002)(8936002)(4326008)(86362001)(38100700002)(5660300002)(2906002)(33656002)(41300700001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mwi0LUrxTEK6fAp91DIXzR9LcE2W+o8sLA7USwjCqf6VYNcNLSzrXO/cGiZY?=
 =?us-ascii?Q?KIJVpcINF3ne2/Agt8aLZjFFiYGO8Fv9j7YZvNwohebkcnl2PPvlzQR2hlqL?=
 =?us-ascii?Q?RujhZdzmHJfDfdY3oA3CJ01XPZVQW+WAk7CGLmt4RkCBnOJVqJhGqrrO4k03?=
 =?us-ascii?Q?6U5HeVVZP3P29K4F0pVn6i+x/613uYN/pd5mW3tb7Fp+V4ICLLCGnODdCsNd?=
 =?us-ascii?Q?ohqe/JfgWL0ihU72Q2QpO9S3RicVEMKnTt6q4hrLc4Sw37r639f8wwik87vQ?=
 =?us-ascii?Q?kDxL3X0RiKkuDQjFkLGyuQJ9Rh1Hnt2JAox2Qdi2VAN43H8QChLGYyPETxlG?=
 =?us-ascii?Q?dOgGfhlmXdLncC9yhvOHYS659Tc9aamMVuBOXeMCsJOMRz6oCjWV3YpfuOHv?=
 =?us-ascii?Q?1JyCcw2rf2bbOUVAi5lKQVd00TUzDyCcYq82HDQXBXg0s9Zt0lu8H7IFHYH3?=
 =?us-ascii?Q?cL74bdcnClGup2zwCoZlZe/GEAe1Odhaiy56UDuxYV5J8MpQaExbqCQKLNiV?=
 =?us-ascii?Q?TGiKMnzWu8di1IWsAYvHyFq2SSeToIqt8fXl6jj8mTdhO52mqrxf8+vH5/hv?=
 =?us-ascii?Q?8g+g/7SBmYJEhIMD7vZ2o7JNPMQrT4H1QIBM4aj92yL+COCVB8LHJgkNHJ8z?=
 =?us-ascii?Q?AxFAOPFyFI+5FOmmsK9jVikA9ZdeAzq7vIE7tnspXlmst7oWMzmZMbYGIxW0?=
 =?us-ascii?Q?45Xesu4SdyhGicuKxtXk3lRSiODT9r/7foEUunmWJ9wuKfMcXd6WYF05EF4K?=
 =?us-ascii?Q?z4MvULPFWnTFSqtHSGsqwccD56AYKuD6oN2RZT3m3xZ3y7Iq9FI1Ni2KKPql?=
 =?us-ascii?Q?dqztVU//owvBcPYs2DFg3J3QPyxi4WY3GC8WoL+MwhLX7U0C2l2neeEe06TN?=
 =?us-ascii?Q?pHGDKS9jl5+QbxEvyUcVmFMkvzfZQYKRcHumvnFG2hwMfQeqiC3FB6xbwHUj?=
 =?us-ascii?Q?GxTUNueFTA+1iY8DNGziX9AX+8A7jnE5ejLW+JDteyGRy6Bus8td+NnGcFiW?=
 =?us-ascii?Q?7wHKBEehVS5ADq+NQme40Fn2Fy+uNgo4FmFgaZBA6yL51RMIcescyOm1tA0y?=
 =?us-ascii?Q?prGExHtQw3HyKgxaBzTYbwLeOnZR+6YMYvUS+C5DIA8Y2d1ioykr5z8ZD0aw?=
 =?us-ascii?Q?M27g9nZ/cZRYpYz5n0PgZ69+YfWJUu7Z8Oz0gYdQMBnK8guqmrH6vXBjFi8e?=
 =?us-ascii?Q?AT1fCO3CMWl8gnMeA4a9nA73qxw8cOEnXnJntYbckbBQYmLO+ZxV2jQQ8BYs?=
 =?us-ascii?Q?Q8IR2U8Kn+uDvWpE1rEHaYtFTX8ys4xJogjT+JVXwNC6NjE3pe3YW2Xq+m1A?=
 =?us-ascii?Q?Vesj4E2KyAZUxXCuIYKKwywU7LMmwACgxuOHRrDdqRuEeQtk1eFAQKpAYwl3?=
 =?us-ascii?Q?EOp94wmpHaQvA1qbT3tDOVN9kfkd6wVbZR6bXQc88I/xmues6IeMqGc+ClHw?=
 =?us-ascii?Q?O0MzZ+w3HwnwEQ7Kz0+eAY2xqgLuhzX5Z7KTx3dtLM9nUkBQ6fi8ZYhTCm/R?=
 =?us-ascii?Q?saKYmestuM9gGtj2YeO3tQECuE3YQCbkmRrSV2tL88X+MqlWeqjmhF7zkQbG?=
 =?us-ascii?Q?Gai3pgoY93kWuwQ0s5M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead3df2f-2067-49ca-d8ba-08dbea5f10cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 06:57:02.7320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bjn5on3fNg4HXbfeLog3OZM0ZujSePn/Sy5JJU5jLsgdBqfYdBbItNyUi6ytzTPH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>



-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Tuesday, November 21, 2023 2:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix memory overflow in the IB test

Fix a memory overflow issue in the gfx IB test for some ASICs. At least 20 =
bytes are needed for the IB test packet.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 0c6133cc5e57..f281eecaeeec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -419,7 +419,7 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *r=
ing, long timeout)
                adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
                cpu_ptr =3D &adev->wb.wb[index];

-               r =3D amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, =
&ib);
+               r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, =
&ib);
                if (r) {
                        DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
                        goto err1;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 885ebd703260..4b0eda46405f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -883,7 +883,7 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ri=
ng, long timeout)
        gpu_addr =3D adev->wb.gpu_addr + (index * 4);
        adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
        memset(&ib, 0, sizeof(ib));
-       r =3D amdgpu_ib_get(adev, NULL, 16,
+       r =3D amdgpu_ib_get(adev, NULL, 20,
                                        AMDGPU_IB_POOL_DIRECT, &ib);
        if (r)
                goto err1;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index e3ff6e46f3f7..a55710bf6e01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1039,7 +1039,7 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *=
ring, long timeout)
        gpu_addr =3D adev->wb.gpu_addr + (index * 4);
        adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
        memset(&ib, 0, sizeof(ib));
-       r =3D amdgpu_ib_get(adev, NULL, 16,
+       r =3D amdgpu_ib_get(adev, NULL, 20,
                                        AMDGPU_IB_POOL_DIRECT, &ib);
        if (r)
                goto err1;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 40d06d32bb74..603988e49cd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -297,7 +297,7 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *=
ring, long timeout)
        gpu_addr =3D adev->wb.gpu_addr + (index * 4);
        adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
        memset(&ib, 0, sizeof(ib));
-       r =3D amdgpu_ib_get(adev, NULL, 16,
+       r =3D amdgpu_ib_get(adev, NULL, 20,
                          AMDGPU_IB_POOL_DIRECT, &ib);
        if (r)
                goto err1;
--
2.39.2


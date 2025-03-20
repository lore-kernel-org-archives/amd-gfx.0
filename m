Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F293C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 15:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C495710E643;
	Thu, 20 Mar 2025 15:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y64Ub/Kw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905B310E643
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 15:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNW5zdhXSEAkjiu13oz9+S62mD3V78eWPnCLxzPTPJVFRzPw5EjUSlhOEloU/MOwqZlG3Wp9dfsJ/MBrf4QXH8xmDPqzDOTey/LM+hNP0ocs8uMNxRw7wFSHBpackW5d3A2IBktwPQrUGVvaC36J5gjRPCrss142sWBAFpOor65yadQWwdxg5Yg3a3LT1lbh+h2sSbbxIRTuBGubBSmPgorT7FKyB7j9Vl3dMaw7mB/VJVaubxHLSBps1i7jJ1S5Luh2CStGd0E2BLfQ8tuHG2DrRNYA+f0c+OWp5FK99Ya4G9JwIhLiumzzHvK7RWwW9l5S1XxxZmeisFFh4r6mdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYl3KTprUsIXy56QBeeID7h64GBRSSxOWxHCKYJ5dg8=;
 b=UesVNKsEB8vjrhmpqCXbZ61jIGqNtvt/LYyVVAC+VN5dLuzAHIgNVyFscdw/fA9ReEEsgKuOZCxlK6+6YZUnz1gJpEoqj3ryKrJ8TAFzP838iZttPELnh8s7sycK41KWn7YFfb2tplazemfs1wLLR05notuBF0/LT9es5sdMKiIazxRVy++fS2+HVwWNEDRcV3P50GmP44Kx8XNyIDTzZ32XUmW660H++5/hfYdsob6MeCWbSgv+CzlOFr0bvzRku/m0QGCEWrznpiJsrWMVAVhf1oqH9U3ZBsD6zIB8/IOVfDorCPtaQovHFgtcJyUnVsRsMkAXeONxiKSelvTeIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYl3KTprUsIXy56QBeeID7h64GBRSSxOWxHCKYJ5dg8=;
 b=y64Ub/Kwc4fZU+Me4wGOakNsHVg3a5vwEEtamMe1ZgDzMaTLTjdvUE9mboxn0ISTufX37z0fAfIbbY8SLIYkSwAe7WkrxHKrAOeAr6I6eLqftYOWT5DP396ToqE+SR3OPH4vg6dQXrgQJi2Pa0FIeWHj181Ux0nYaRqEqPe1Z1o=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 15:43:28 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:43:28 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/mes: clean up SDMA HQD loop
Thread-Topic: [PATCH 2/3] drm/amdgpu/mes: clean up SDMA HQD loop
Thread-Index: AQHbmaOsLHRoOfwJiEOmnBOHYvdwRrN8KWJw
Date: Thu, 20 Mar 2025 15:43:28 +0000
Message-ID: <CH0PR12MB5372D263C10D2C2ADF33D19AF4D82@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250320142306.1135063-1-alexander.deucher@amd.com>
 <20250320142306.1135063-2-alexander.deucher@amd.com>
In-Reply-To: <20250320142306.1135063-2-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7e179ed9-82f6-4f6a-9d7e-5629585d6457;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T15:39:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|MW6PR12MB8759:EE_
x-ms-office365-filtering-correlation-id: 36fdf4d1-040f-46c3-055a-08dd67c5f588
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3wlNsNRxlVHkGs0QblffpHbebyhVeBwfcRu3LpN570ZCrHcXsKVDJORiw5oi?=
 =?us-ascii?Q?nFbrdCjlbEdNvKmsrYQ0iiw6Rb0kMFsBiYKjQFr4U6tRrMjRKCh4OmYmOjh3?=
 =?us-ascii?Q?khEbvp7W80tr1AGBic/6uUn3GNOgap+1tEruJ3hgUcBy2ulBMrc+g+/r2N4L?=
 =?us-ascii?Q?PWrxLJujK8I1cWsX5ZvYF1XSHtrGu/d8fyJs9x9QTuex8Mulf4KaDY/QjukI?=
 =?us-ascii?Q?zLdR7Jozx99dONYF51L8ya0IqKth6U+tSSjIFs9mWqb/v/JwaXMhpbQNQcmB?=
 =?us-ascii?Q?Wh2Jnrk5L4GmSZ+twm5EJFIlXKn21TcVXSRrrTRmsehPLAhUAlWDeCReboyO?=
 =?us-ascii?Q?bCO18FmL0TVjbnRBKtiLr+sQva0ZHndXPok23wO+eoS2WRhFPqK9OSiXQycn?=
 =?us-ascii?Q?9MP7iVB2Z1wlxxI01oVTqH3crneMpypCQUwsTydjLoApp3soqiCyizx0T/Fz?=
 =?us-ascii?Q?azYvSXF3mAKOodXObNmSC1pxRh6eFGZBK0Th0dybxZbjKyOKFXdY9LiXlJRx?=
 =?us-ascii?Q?CboAOXDIoTrWIl7/zzNKMGk7vXPtQqaNbg879cHng9wsDoMk7V8FAK89R+Kv?=
 =?us-ascii?Q?B8bisoEAdxa2QkkduwEdo5sPxRro4GgpB21ATabtmprBcw/tKo5PMQeADfhc?=
 =?us-ascii?Q?EHOXswSb0js2k3wry3it0GptDbBojH+dicDXFuR7kq7M2UrkHFCL2QZNVOrZ?=
 =?us-ascii?Q?OdFZARnpYR0B585LPtJ19GiTRKR+drbgvd/icJkTRPMQTImayH/hasSoEDAX?=
 =?us-ascii?Q?UJq8yaIRNg9e75OWre7UcqFrhQCgC0IXzlNQqdY8Q/gTH2YiLyOX3Mp3op8j?=
 =?us-ascii?Q?i/scKWW+i15Vcthj3szhN4URS1FFs3mfMqu8MqLLyxYaW9TunPdRtQAlVMrm?=
 =?us-ascii?Q?SYTJAMFmQPsh8tD3wxipbTsekRq+pe2B/fpRwhPYO1nLtka8f+6Ui/ifPkvp?=
 =?us-ascii?Q?dWidzO8aB2E0nopLwQJBGHEOUqXH5UOVzec6Prc1GKD1K+7IG00BYpH2uHk6?=
 =?us-ascii?Q?SO3WK8LH7Nkl89TPWklS72fc/6DNr/Tv5nSvjL091yv+ZhOU3VJ3+BpsdZ4F?=
 =?us-ascii?Q?dhcRvlOLGr3iIwButs/82CEJh0XX9Epe1FsMfrXXMwWCozGxOan5n69u/vc8?=
 =?us-ascii?Q?DmQYVegFbh3YYcGo4AcR0k3hlfVLewh+GuiwDNBv9YeNKssSqQHXAgIIRJN+?=
 =?us-ascii?Q?qHkC+nB1xwF16leJpYLrMft0BpJjkM7D5Pdn7AESnxsgTpD2rZkE8U9eLSDq?=
 =?us-ascii?Q?99DbKH8NICvuJRxU+yrg6+BBAA227eBpcyvrfeaxl8f8lkKqn7n1TDm1UbgP?=
 =?us-ascii?Q?paZd4vmOOTgAb4UeXUiu0MUAHWnjl5snrB/iNrB7ai7gblwyZ/3bkIsGhRvL?=
 =?us-ascii?Q?P5GsVhN2Jj712aB8Gu1bCZzAZAsTfYDaWKG9hU04UO1YmSDF4kY3aIpm71Re?=
 =?us-ascii?Q?5LMelTz4adsHfpE5xj0XpHLs+QavmB+P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AG5dVxTLS0ubnW1zl7TvWK5NaKGXLEtUei0ch5G0LOhNTh20I41MgdeR9mdN?=
 =?us-ascii?Q?t5ZlkKuMKZlK9f0Gq+64ylcJhRPJlrrWIhEAgFQJUf1GhG/kJvdZ8b5g/IDg?=
 =?us-ascii?Q?a+TvB0QlRACD2CvlP7iFoPylQQK75rdipzy0IhpXKaPmbLCAEkCpzGj+TNU4?=
 =?us-ascii?Q?NkAlxEk+c7TNY5svlGb/9RJrFxXGXn1tC/NMW/GN5UVMcsItmdFiXTYUpqS6?=
 =?us-ascii?Q?cLXUauEcFtff/DqBKnxhW0hdrMt/aWdh6Yzgg2ZJ7N5OfkE6WP90WWsnqzeD?=
 =?us-ascii?Q?IKAKVnbmRQdggGHG0ogteLBrMPvFAg9Xq+Wc3UO6zOapu4mUmecriYRIO4Oc?=
 =?us-ascii?Q?5VRC2wz+L+02gaPaqpXSMp4bJWV4FeuqnICIdzQUA/xfnA/2NI3FIL/tR9ju?=
 =?us-ascii?Q?MJL4aQly2kyFdNfhbhdrUUPMfDrinwuJWT4xCIO5dfaYRrernsk4WZit/z7E?=
 =?us-ascii?Q?NAY5f4cZ3ZExInE9noqLjCtvXrVNoagKWFmJ1kJAc7gQT/7KXWq5vwzB6QLR?=
 =?us-ascii?Q?jD5fYUeUuvdDGgQ3oWoF4n+M1xoWUaWFV5WgbfUWxXBhd2pKkGzrM9LDW6BS?=
 =?us-ascii?Q?3uSanIxaH+NRNu82frAYTXUeHTK8HJTtL0TYClTYJtRgiW2ZjPuW1K5gfajo?=
 =?us-ascii?Q?bXI2R/vp0UpUlS82tCwlrkyFlqXZvrirb9RlsG7lXtcoZRMbBMCJ64WJYRvs?=
 =?us-ascii?Q?67b8gLLgYrujE8W4N0mwo/jya7uALlp8feTXL3ZVAx/Oe6JmmvUkvvjqYBsB?=
 =?us-ascii?Q?qKPiNmBt4XKXQ2655h44LKdpFz8RH5caS1UI+rb9zr6o+0j4snUHTxgWnkH3?=
 =?us-ascii?Q?r2S8vsSpGglunIiqoC4u04DKKIsXSrxiHUFAhOQW3GtZIyT2pgitKUn8aJu9?=
 =?us-ascii?Q?nedqcfG1mSe36dTctRpQpSO1ZQvaNQ+8eLB7A/Yr9IqQcuy9xqhtJbmDoYZW?=
 =?us-ascii?Q?yXyTq/HIOVvXwjw2bK6Z4OH88F0LJoC2WLoqinv6Iuiuvk14E4VhxaGHmmSb?=
 =?us-ascii?Q?dUIH4PT1iF4iei8h1ElXMEyyipJwFScAOOjJmJP2m+J1gFxGgv6z9006w9li?=
 =?us-ascii?Q?67pg8WgEhuCrTAmAa2ofpocU77qwcfBKS8Asd+dbqVctEpyNlGQZkQMt2zB+?=
 =?us-ascii?Q?ehMNbJZNBmFwBUQe7QG3mOEgrQ114zAjGfh90dlO/LwjEnTplJMrQBXX0oIj?=
 =?us-ascii?Q?OR81fGAzywawqpeAAovm1eckYiYZb5BbSygXDv2t49iQA3sN1ZgrY3EFZzQn?=
 =?us-ascii?Q?LtxIQI0cTPqrl4rXRF+jMGPxPh9LFQWS1QZ3nvjCQLDNCfTibq3gr5pMs+jf?=
 =?us-ascii?Q?xn71PUKSt0ZGPabrjGdidJwUYV1/GH2iekCMuGQN8T0FINg8fQ7qTji3FIwR?=
 =?us-ascii?Q?ZeG0bNZVpXQSB/8ULww6cY2H4z/6MuJeTAXMwBUhegyg7RzOBug1jd5m677z?=
 =?us-ascii?Q?2BECtRNuPTmyW7YtngOP3Gzv+Xwrs2820wkgf9/KEEAl5N42uXw5SMSIGYv+?=
 =?us-ascii?Q?b6m9zZJdiHZTd7VJrYGXlLjomxPBNWMR0RYpfPrSz+BGIX1KiaRTZL/XKrJ4?=
 =?us-ascii?Q?cZh/QKkllOhY8aYLvFg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fdf4d1-040f-46c3-055a-08dd67c5f588
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 15:43:28.1879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Z4/T8zPYuss9srayB9tSbqiz8U2O3Zr30qTGURWqo1cPRb5y+AiAYo+W9Fak+nBLK4sx4zmq0Twml/O7C3gTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759
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

Should the SDMA mask be  ASIC specific ? I think some ASIC might need to be=
 set to 0x3fc .

Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, March 20, 2025 10:23 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Lia=
ng@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/mes: clean up SDMA HQD loop

Follow the same logic as the other IP types.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index fddec5d1f2444..016af4e9c35fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -136,11 +136,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
        }

        for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-               /* zero sdma_hqd_mask for non-existent engine */
-               if (adev->sdma.num_instances =3D=3D 1)
-                       adev->mes.sdma_hqd_mask[i] =3D i ? 0 : 0xfc;
-               else
-                       adev->mes.sdma_hqd_mask[i] =3D 0xfc;
+               if (i >=3D adev->sdma.num_instances)
+                       break;
+               adev->mes.sdma_hqd_mask[i] =3D 0xfc;
        }

        for (i =3D 0; i < AMDGPU_MAX_MES_PIPES; i++) {
--
2.49.0


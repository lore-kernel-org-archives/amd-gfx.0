Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C84C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 09:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFD810EC07;
	Tue,  8 Mar 2022 09:56:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8723B10EC08
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 09:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1+hM5RZ2X7pThiOsOPyYaakMGfGC5BmFRk3i4pcZKgStaWWxnrVJBb2M7/v1MA+SLzOCmmOJ0ZMYzkhobA+oO4HYMhF9jzGV3A4FWvYCn5xP1Y+XR9Eueg+Uxjeb6nLIMesYxCNKVnz566XdqrUvH+rx8MahXNdnietzUEl+KPX3y5SYWuahFt+XdPeR77cD8tjXUvaNAlEYBLP7Xe5ZWyXL87iPHkpl7DxzeEpb/+L7sieW1cpUNnsVn7joIg2WqTSeucv+AV9h2uPoCsoLHayVdWl7Dfr9T4rUTcXthUvm0LrbPCLpT0y1qrs9tkbHx1WOvr1yxGQqdu/9RUr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIQIr0ZUjuQb44QVnnTbjxIklsPNNuz0YEM9HfV1+hs=;
 b=fyWoTv+fKUhglXtfAFK+3KAD36PBn08fcv3M4IiTl8RkUgsD7jmn4btSThhBzvE/4oaWz0p9VNwdLCqn2uDbeADsND/qHPledOy6OPaMPKJUBkzPcl0+251RFU0+1pl7P/iYl9g1ke7RgfKIXNDEgM0d1UtFUfurfLopfitVOfUrWpjsdMdhmetPKGu9vpvnTKZQM6dHYSBPPX79YqBrUHnETgZMYnJ/0gJbzzChLDuLM01jHIkxSZ60eoKLeUARGVh+dMeZLo3snv1z1czL41GAlCRK9xsbXfO6wO0JDCyOWcSC8sGLsKcY5N5TwUwBkP/9qbUwI9DZp3ntKgfW0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIQIr0ZUjuQb44QVnnTbjxIklsPNNuz0YEM9HfV1+hs=;
 b=Rntn5g57CVAZUxkB49YpUK4s77GAWpWubWY+VsTeobZh/Fv+/W4N1oGUkM26EnM0oG9T8mP77UKgcD/O+KFW4lRPKTe6JBEMKdCiVglFWS9npDwgYMoGTI/avhbJTkurgFmIEtxfSX3E//THYPl9eoETIFQRjAeLWaHUCVqm1s8=
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MN2PR12MB4656.namprd12.prod.outlook.com (2603:10b6:208:182::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 09:56:10 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 09:56:10 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: align ip discovery naming with legacy ASICs
Thread-Topic: [PATCH] drm/amdgpu: align ip discovery naming with legacy ASICs
Thread-Index: AQHYMrTBuZhXcZ7twEyQusM0RKuJEqy1QAGA
Date: Tue, 8 Mar 2022 09:56:10 +0000
Message-ID: <DM5PR12MB2504AB1655BE50F06A6C0763EC099@DM5PR12MB2504.namprd12.prod.outlook.com>
References: <20220308062043.2128688-1-yifan1.zhang@amd.com>
In-Reply-To: <20220308062043.2128688-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-08T09:55:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a8f69567-cdc4-4b26-a840-fbcffee7c875;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-08T09:56:07Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: e2264eac-7dc5-40ef-b13a-3371f1b012ad
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 765a588b-dd57-49c0-b0b2-08da00e9df6a
x-ms-traffictypediagnostic: MN2PR12MB4656:EE_
x-microsoft-antispam-prvs: <MN2PR12MB465684A6B67F8CD36D129ABFEC099@MN2PR12MB4656.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5snwJpPTsnrjsx22Who4XYGp1Jr8o7j02fWqkgz3zfGqdN5Ll4hh+03mGhBcI2DffXlnfG7Uk3SQYW4wBbaua+z2/XVu5FiyVEXRzrs3yKDFVxRDoHePedyLfbUF5EyFpFd5Uo8+ILMrvWmbX6ZMJ0y8K6g86uSKYW02aZqqt6GoZKPyovXt61kjKTtmxhP871LaFvtR8f8YeaWm93RIoJFfEwAdqwpohA/+YnG1RdcFT1l0vyLa2mjXFydHy/PJjpLKcdZ0+DKmkTd3ZEADHdWUnanSVYz8yDiWlUTYzqbS10hD3SDNfqUCR13nTDyQlPpP19qTryDUM65vj2w1Ag8Ue0I6/rO8DzbdFv+dRCPfKacfijcxm403pyiopR2+7md86fzbwkJ6Bf0USuN1yhlpQ8rW1aHGxxXw//1+RgTxwZ7re5eoSMbGRkeA1qAgdW4W0oUQxKF3/gIh/Ew6R5DuUlf/Qzizxq/ZiLiamcBk5LuXsU8xOVwoWPPP0t+dR1G5PnXKfwmjQL2m5MzHp0UkOllc89DLVCY4ZYPPmCSGIQHz5IngRaivdpmC9EwteL7OP40psGlgoWAKi7EsGL4GhHezZ+xPcp7cHXDN6eSS6K4nkCFeMKZM1dpw4/V+LaXiVQ1HQfJ0M2pfPDfV6ytCU6Vbm7HHul7oXLlHMPJewyD5+rDhmtuJ01vLQZELphXNaJdbEFfPJGxXQZVUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(8676002)(66446008)(4326008)(52536014)(76116006)(66946007)(66556008)(38100700002)(86362001)(64756008)(6506007)(7696005)(508600001)(9686003)(5660300002)(8936002)(110136005)(316002)(53546011)(2906002)(71200400001)(186003)(38070700005)(26005)(83380400001)(33656002)(122000001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8t52/PdFvjK76/kSdfuPGBzJ3Il/W8c2TJzqRs5rUiAqSCyv0UzxNKcF9SZ1?=
 =?us-ascii?Q?6oEXfsAKoYDRVYMX59nhVJcm4KQSwZjRPObrC8tHj6WiEUc8yfKvcN96weh1?=
 =?us-ascii?Q?bPUFLNO+Hfp/7JQRy6T2NSal0UT78Eqey5jNTiirnv0F+Nsu8EXpEInJ7MLm?=
 =?us-ascii?Q?JbTxk2Oazdm5XKuJB5H6lOYrLlgs4Cnn9qIGFNQIzSBq2gMLbiwZYWClyO4B?=
 =?us-ascii?Q?wpdrPQg2iVzx+7TebQAXQiyqZ2mB+v1PCRMQ/pLVkckXehu/O78SMbelUOSv?=
 =?us-ascii?Q?64cVWlpKw9Da/ywjaqOpQXPnTBI2HtnYwIZ7fy9itnmfR4p7+Jss2cvgdmwC?=
 =?us-ascii?Q?A8ExKBQoLUtEnFCsl6wjykbmOcYjxBDnml92sFPkNkfTDH01RMY6V6zafOPR?=
 =?us-ascii?Q?sB9eGTJkF8y9hhk4ANcDMiOOemggnZM4AP+EePPTOV+9HUVsnVPb2rEcVFpU?=
 =?us-ascii?Q?quqP41/alRJVzTsgkRL4QAjYsTpJV+0KV9U16mB7B4qm6DN/v6+JjanhV/i/?=
 =?us-ascii?Q?Y4ZsDOn27H1XABhb4I/WZWMEbVRLnZy/yvi/qmlm1fqeTj0KP7l2Q937YO1n?=
 =?us-ascii?Q?coHt+LRER+r+9F0HEM28+EJmSoQJrX0nD8lmsojXw+wGjc6uhWrfRzBpqWf+?=
 =?us-ascii?Q?ISJJG1jrl52vEQbbJE3ZMw601+bcv8zjwjnZpQPFXjbLxl2/unm8Q2X7bUQ2?=
 =?us-ascii?Q?3LKQ1KQc9J0mo5uiDVFJbe7G4qqU1UsBlA0b7PB0MiMUYb4l8TchARB8w7Ed?=
 =?us-ascii?Q?PLHSykDngwbbQja1NHAeHoARdlUGR3lysuYXMI+rpnNcecdyRd4RYx9MYgPA?=
 =?us-ascii?Q?CWB32KhHpnJ0k7w38qt+DYI3IDtWKdl80a/LTQoo0ctydI12P2UITX+dj/Hg?=
 =?us-ascii?Q?+JooxlPX9NE7T7TH91efbeKVNrkVH953oYXQw40C9L4YmIhsfmpnCqGPGMj9?=
 =?us-ascii?Q?e1k7klNYfoeDw1w/iZoXZoMiQiLcg1SrdSvifKDZS15TVVCH+Ccx47ZUtJ3b?=
 =?us-ascii?Q?eoltmUruVdn0Y3odhQFZRk6lAdSSGO3jV++Z9Eo0XCxVQnvB2PG3ABJlJucX?=
 =?us-ascii?Q?FbzjnCzdSGuq5fWTlmot0PS7q+RBciL68doVqlu/T0RExV4gf4LoL4KHNWp7?=
 =?us-ascii?Q?vHFYToBSvIoM6B2SvfyL+a5gIuZcBl6Vyy/2u7sH5JSDDL4rcwv+RcRh88hu?=
 =?us-ascii?Q?5cVtxBTj6a5OEMgofjCROhGMCAhU63u1wdK2qg3lLU74ABNyzVda1B8V1iQg?=
 =?us-ascii?Q?Jj4+dxcwkOPTG+AVymqQZMglr9LOKEAWq6JKYl7cDFmME+n548OM7o9RwM6l?=
 =?us-ascii?Q?dPEd4IRfFyfE7x6hbDeLm2oQJIa4FPzR8jvS2XoQyABXgnh+fDywhWoJG11Y?=
 =?us-ascii?Q?GMCQTiQ7aHBSQrN/H7Wz2JzWpOo7ZFpE9lY1kAT/D/N00dpI3VLFBtUJazG2?=
 =?us-ascii?Q?dDJ86bD1IfOI0CHm7tRjxzql6+rHZW1bFjctPQEITCNKT9SH6FWlQeGCH70T?=
 =?us-ascii?Q?6+rcpnv04ULn9RsCVGG8iCDxFPzqqrP3XzB/k58sMv6C/5/lJB99erjHukji?=
 =?us-ascii?Q?9m3tCTXQYAYxxeg2PsLKKtRY3vZrABUOEVMg3hl2cWWdbYUyIZcpFgNT+zgu?=
 =?us-ascii?Q?+DGuSSOdaAgEEbXDnMDPhAY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765a588b-dd57-49c0-b0b2-08da00e9df6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 09:56:10.1568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+L05SmHF5aI/kpVWhTSJOPJTi9jgnHsEySRjoHLfb2gggYbkTPMPoqgfwi9SXFryGQmB7uB8ltMo9/1gu3ZpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4656
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

[AMD Official Use Only]

Acked-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>=20
Sent: Tuesday, March 8, 2022 2:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: align ip discovery naming with legacy ASICs

There some code assuming ASIC names are non-space character.
e.g.

runKfdTest() {
    if [ "$RUN_IN_DOCKER" =3D=3D "true" ]; then

    for hsaNode in $hsaNodes; do
        nodeName=3D$(getNodeName $hsaNode)
        if [ "$PLATFORM" !=3D "" ] && [ "$PLATFORM" !=3D "$nodeName" ]; the=
n
            echo "WARNING: Actual ASIC $nodeName treated as $PLATFORM"
            nodeName=3D"$PLATFORM"
        fi

        getFilter $nodeName
}

 getFilter() {
    local platform=3D$1;
}

if launch run_kfdtest.sh on a ip discovery ASIC, platform in getFilter will=
 be "ip"
instead of "ip discovery"

$ ./run_kfdtest.sh
Unsupported platform ip. Exiting

Replace whitespace with underscore to align the naming.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7abdf5e3dc05..0a66f724a4eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -123,7 +123,7 @@ const char *amdgpu_asic_name[] =3D {
 	"DIMGREY_CAVEFISH",
 	"BEIGE_GOBY",
 	"YELLOW_CARP",
-	"IP DISCOVERY",
+	"IP_DISCOVERY",
 	"LAST",
 };
=20
--=20
2.25.1

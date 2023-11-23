Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07C5C61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 18:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6503410E331;
	Thu, 23 Nov 2023 18:40:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27F710E331
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 18:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/U1Ec/F4Grph5tiyWH+CIJhpWjck9uAZ/wKSKKm200C++7Rh2YxeENGk7Kq2OcG5QWXlGnscRm1pkBeGpZDY/bfYdxB+zz6f2pLhw4SSvL0QiB1uIJu62MHS3RblOiwb/ld8g3ziYB/V3ARWM0ja8sXi8laqXQKrejVKuDHPXsJvs2/AbG/K3eTdYb32R1WxGwJZD+QkEZq9umR05mF+/kZ+ZaVJetaZKT+vDhw0kPozCjqS4qhvDrBnmPgZchuejO0TUszkq4dDflh4DTae14MjMvG3/Kjcs7PaP70WbFzR8EHlLMmt5/EobaZJNMemq3oAfZ3SG6qShSlFTKTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvUQ9M8lw9XcQ08x7potxFwOebqIql2le76cEYXkSTg=;
 b=BCRdTGFhkxQLurerGGMZBDlHTFPH3vJJVrHMYZHEukTze0+vhs38S/pLwO0SU4VwZRwE9+lZ9jt1LC12WPZCVPDskLb6SlXBYW4FJFpmLWd7itsGSpHv4objWtINmViMGKyzZ5YTtoXIPvpQbFpb9uDBx01HPKDpWW4GQhNOqNGBVVRbtBttVCOz8OZnlc/hOXS0SgmrskidYwqzQQjoK+YOx5Q7zH7h+ScrBn4MmZ+P3PfsvqzKACAYTEVJQdbVHMtr9VLRoKHnCtx+vTfVndKcf5IpeLYGk2zvxkGgLokkBSf4uOY+riOkglUemhYcVvNtn+bsxFhGohvcrZNK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvUQ9M8lw9XcQ08x7potxFwOebqIql2le76cEYXkSTg=;
 b=ISmv9318pJbJqpyYg+P9Gq3Wcy4QLGXYPRl95lWUP7U12NrKlaWvQOJq7P+y2JEmP3x5saRdYQMuIY/r+nym/7FklfMKiAF1xnJqUWXQexDKQtaO+hV5sQ1nvkpClqxZ+vSk29a1eMoqLFlLC8r+ydHzlM7ciFy3VPH2QFQZK6I=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 18:40:51 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::51b3:cf1d:7ab5:5b61]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::51b3:cf1d:7ab5:5b61%7]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 18:40:51 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Use common function for IP version check
Thread-Topic: [PATCH] drm/amdkfd: Use common function for IP version check
Thread-Index: AQHaHYKXcQa81RYBsESum4vm7bqe27CIPaxA
Date: Thu, 23 Nov 2023 18:40:51 +0000
Message-ID: <CY8PR12MB709929D8ACE87CA4BD087D328CB9A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20231122202851.1177584-1-mukul.joshi@amd.com>
In-Reply-To: <20231122202851.1177584-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ddb29f8f-9c97-4e2e-9882-807654825562;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-23T18:39:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|PH7PR12MB6609:EE_
x-ms-office365-filtering-correlation-id: 2fee91fa-9f26-4cd6-e6f5-08dbec53b7c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /O31RGlz5uiio60fJeUXJNPK2enGmMALhnEOPYNErlgrRjmcjwXZGYPqEev7bpA8+l/E5Zn4olb38ywkJu2naU+PRpYRoPxhVjfDEwJCI1v9i7qaIyU+wrc+53LEYwbRacRAw3nsG0k4JA6qpIofGvpUAODfE+skCUSkWB2a68yw0iYOOi6KhzZMlNdh2uRyFT++XF8mhqpX4Xu0haxvSQxfjJFnGahnQ30+8lyubNIqjsoDIOI0EzTCw3/mT1wWIUpVJukXH2F8s0EHHrcrLK6REd75jLKgXV9k9c0RdxuG2Ln0KbF6IlQkox3kdOAUzfmUR5tCcGvWShAYAs9nbdlLYHJOwY8imNW1RHBOIrSPYAEVOlPCB6u5c52XVU11TBuE+ihaD5Okh8KBS5Xm5clRcnovjNSM0fT/V//CsBwB3qfAFYYFvOYHh1hqusegYBtf3T288sTUSJu9MQIXQD0rU8HFu21mPbbUdOSzfLIaPRoXMplGLANrDXm5lUxrkgR9eJkCGdZfdDmw9yhkXTCFTFFGr6Sv8/CcpuSJvSlNrb/pv7optLodN800tZznQDuWYbnbLtGW6U7QlV+aFlflL/VS0EUgZpOzIJzyF68qS2tZYMbxkP92/lJzRco1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(2906002)(55016003)(52536014)(41300700001)(8676002)(8936002)(4326008)(64756008)(316002)(66476007)(66556008)(54906003)(66446008)(76116006)(110136005)(66946007)(7696005)(26005)(71200400001)(9686003)(86362001)(6506007)(122000001)(83380400001)(478600001)(33656002)(53546011)(38100700002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t4Eq+mlIEggtN9BZjtbFBl6McDu8yoad6QLDIsgpftilqQhTQl+vA5V17HZf?=
 =?us-ascii?Q?UTCPvbjgdZBgdshx8fDsi0R4wCuUuW7/hyla4wz9LPN0iXmZvvo9t+HeZsCz?=
 =?us-ascii?Q?zX8HroIOQbBTb4gLRWMPX8v71iHxKXhcuqdnTpXCt5CuYEGPy+DFvKktSANV?=
 =?us-ascii?Q?F45eFc9dlge6Sej4blxYqFgt0PX8I4Bzgeh+BozGK5YfPbo7LNBcm9gVrBin?=
 =?us-ascii?Q?RWYl2vL9hBfizwvy/RLI3usH93c74KAJYo5HE1xrCPdYPo21kKX+VUpPP/w+?=
 =?us-ascii?Q?CxOCiefZB8XqfB4b8WdplXe9Y5YzsWg+SbhWrnXLcKqHwiBADFTpdL5I3/Xa?=
 =?us-ascii?Q?4U/SCLGn/6+Jt3hsLVJNQHPTqFc7uAGLBHLqi3Tw/Hemo0+TKaivbRWcdmD8?=
 =?us-ascii?Q?NLN8sXTAVE0eDmAeqm+r07B6tfULNBW0N+3a/DMhkoC6QSaVW8Zz0pGLqkIC?=
 =?us-ascii?Q?kb5rHlI+OoZdkvjXQPRhTXxyJWXjPzbpZjr59Lot3KqEsN2b6keHl+KLvfmJ?=
 =?us-ascii?Q?Tq5YH0NVgGVcGZjsBNtx9mbCCuDXzPWWye48sKBqZ/VN+FTq7nWKUFKBfFlF?=
 =?us-ascii?Q?gqDCMc1eUjAOV1TFtORki9tlKD7aUeUhHJENzTu+l1ln3Hnru3t68luL136g?=
 =?us-ascii?Q?Zt+68Iqnvs8Uw3sG+fUNe5C9kdAHziAapZCqkfgOEf2bOfzkdDTbSbqVlQFg?=
 =?us-ascii?Q?quDuPWMC0ZG9wKP3Afm55dxyssVk62bUplDWs6NxdLkSwe3626kXL62PNAGc?=
 =?us-ascii?Q?3/m1PrSC4396q447cYMoj+AupX1esl8SZk3kwvI+pzraXD68/nTrI31HBAvT?=
 =?us-ascii?Q?AdnzmzRhanQTkEZ32TFip1XIpqWlnfrmQrfoORDZOAqFrrCyeQ8IL6DtUnZC?=
 =?us-ascii?Q?/bhOR5p0f1yE6sr9GYmLW97czKq3y9iFRZE2nJTwr16hqbuVf3s2j5K7trI8?=
 =?us-ascii?Q?cVLwbDkSgrRFfRKJMmjYFV8KNucNMY38ddRVX8WilK1u1fmVC10ulX3dCy8J?=
 =?us-ascii?Q?8e6Sstw6EVrvq/38ibtLxvfLUnOZ1Yki3l4sywb1f+Px45IpB2FvOP3sRMxf?=
 =?us-ascii?Q?hVjTC/oc3q8awUulzk5mtBn5wsslsuskEX/xcBbrViBRVkCCZ/0FbvUsQqBv?=
 =?us-ascii?Q?fKFKYlzTzIlvwHAu0Yk9ny3zHM3hF5SSnXfh71+2YpvYko3VgUlOT6FtMQAr?=
 =?us-ascii?Q?O2/3Ck7hFivZY7qEGisbeRO7lqHCzsfiULlmrE21FIQJk5a5OAiAOlVAfB63?=
 =?us-ascii?Q?PySJKCh47i0G7ZtiNuRpXAnfn0XNIbfq0oj3Y99x0NkRpXgaGn2WzRu/9iKF?=
 =?us-ascii?Q?LYilVKwTei7Sy3rKZ6NymacdDr+3g7QTgu5Ou9RUPCjQHKl7L3/5TqCmywhG?=
 =?us-ascii?Q?op80ab5iZ5Y9BJfgPA679FKylngw3qz5bCzq+B3v5RFCO6bcId8XGIiD8ZcU?=
 =?us-ascii?Q?k3n+Q/S3oAryx0LmVTidLWPkRmTi/1PF1cKjLo9WK236RCrQufqtxvAy/niK?=
 =?us-ascii?Q?mEXjgfGKWCooCmrCNdL8lsYb6qkTsrD/7TRfB8nHpR7I0mNV5cDOd0DtRzkx?=
 =?us-ascii?Q?qIat5j4R0inBQD7QRXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fee91fa-9f26-4cd6-e6f5-08dbec53b7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 18:40:51.1995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWp5v2MJiv8mpGIw7OKyJj6Nh75hoC5lit80njIC4nF12a57Ns54xvl8rakq9hGGZaYZZ2a84luIpJMZMgLm0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Wednesday, November 22, 2023 3:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>
Subject: [PATCH] drm/amdkfd: Use common function for IP version check

KFD_GC_VERSION was recently updated to use a new function
for IP version checks. As a result, use KFD_GC_VERSION as
the common function for all IP version checks in KFD.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index a40f8cfc6aa5..45366b4ca976 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1127,7 +1127,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(st=
ruct amdgpu_device *adev,
        struct kfd_dev *dev =3D adev->kfd.dev;
        uint32_t i;

-       if (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 3))
+       if (KFD_GC_VERSION(dev) !=3D IP_VERSION(9, 4, 3))
                return dev->nodes[0];

        for (i =3D 0; i < dev->num_nodes; i++)
--
2.35.1


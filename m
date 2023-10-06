Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8113BE81DE8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 11:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D29010E1F0;
	Fri,  6 Oct 2023 11:37:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2EFF10E105
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 11:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLoR/LHqMz3m9rTkP0uGZUh19hq3Oe85L23FlRu6nMWUa3Z4dR/6mEEc7KJP3e0guoSf8973uRTpMp+f3JfD4LUoFAD0Oqr9eYUYXgOmizAvUrh+SI+o1KAzQ4XYsxBeZzYGyMa7P4kUqGXKyXt6ahBc9/Tm1Y4lCtOzvUISYSROV4QqvZPKqnwRY+kMO2etw2Z6hgOhVubNB4UVP8WVfO6TuKLpfUP7G8yD/vrNQLobughO4es+P6FfSfuwxQPa/Gty8QqIH2Z90X+a+JPujnvaoAIhZmn1Xqsusw5j030x6QZBfcaOy6kVW74GF0KwU4FGnELhKrS0VxU/rIndiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZJbpZq76GWo8aOZqlYn0/Ls1ViO1+64I9ralJQ8opo=;
 b=meP7sf7GMe+V1DJL44OdL9gvTA6mBYfkLm9J9IcWcEwllaAoSRnksTyYOg6RZL6npwm2tTk9zyyyEOcp7UthtnP9tl6parW58B4/bAW12SuYn7bpJYgVa57Uh1/OUlbpfSrK5M/pxNRxRXL2zTDMgErgxGu3sl8XU4ocRs8yn59BzvNq9fkhH2FUdrBeFhpAKIOcNmmgUJB7aF06OjaZejSz8t4Emay3bMQ+TFUC893KJXaZdLhV7iNRTGySzVTlPpn1zkkR05jePMrU4qBRnTynG2pdXE5KdM6QzmrdWfDkwLTtrwFHLC1jDDRDy9N5RvsB2xRpd+MFh6ER+Dn1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZJbpZq76GWo8aOZqlYn0/Ls1ViO1+64I9ralJQ8opo=;
 b=Jm9n72qv2azL7mz6EKTkBwd3ZOxyj0w6jyIuQ4OfecTyvYRDZ5whBrouPQJSr9je4nAS/Cz79sYSGww0N8htUohdd00+/yJyvy7tcHVF307BfzeDJ2YwFFmFypxYVKnIbYfkrgg/Xd81VLDCZbiC8SkXYIPOcm8INiWHeJUa/Mo=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Fri, 6 Oct
 2023 11:37:39 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6838.029; Fri, 6 Oct 2023
 11:37:38 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
Thread-Topic: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
Thread-Index: AQHZ+BUOXVQtxemOjUSKRumZqe7aA7A8oYWQ
Date: Fri, 6 Oct 2023 11:37:38 +0000
Message-ID: <PH7PR12MB599741EB6BA789C3D349682182C9A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
In-Reply-To: <20231006052149.1566154-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0bc6a3b4-fead-4828-8d2e-2787ab0dd4e1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-06T11:32:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA1PR12MB6484:EE_
x-ms-office365-filtering-correlation-id: 0100aa4d-aab2-4ed7-0e76-08dbc660a4de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a7HuuCD3meKcF8U3Ui/5GZdMVDVhfJxXGf2CRUYO0/Wht3O+K5Z9OyunpXuq0rhX1A+RHts0doTwvSWL++N1NUInn9pzfTpHYB6FWP1//psBhmNsGi9qgCunrNfLmWuQ7HOo1a7Ss7uZ0SKDoBkGBKwYDkteOx5al0G2zmKRtz7Yl9QalM4p25nJPROq/Jkv23if9U2+LthNgkQD0+mrVugg+xELJnRNoMwX0PX2Prjv1/GGrFaB9pxV37ujGn4CLc6mBrUR7ljq3d3LZNbX9lI3LLlHTLH+WhU7Na8Z/gd8t4rut46oT0In0Q+NyWKQE0xcnZSjXtsB4yTYffi7wE49Y9c6p4QrVpo0JDeb5JMZLQ7pvqpmw64mcGzl2aAvpZca00BopqpxDzNqB1HbqFtjfwXW2RwpAbsR/HyaRF941nO0hdjoBHcLyEBXHxPxv5jq05CHdHXmeX37c2dKYlI5Lo+Xm692NzYqPAWSiornhV5WtfssHw+Qcdgjosy+5I7/AKQY4o9PSbZDmYrpWG5vlk+QWxm6SE6lU6/aJqqKMn63lcU8bY/eRWBjlSqwgIWVhMuavJm5f6rrTIjyWQKyeAT0I+gs6PlDYl7RDt2POxZNfg0zTKC2TXZ7K6qp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(41300700001)(9686003)(7696005)(6506007)(38070700005)(38100700002)(122000001)(33656002)(86362001)(2906002)(83380400001)(5660300002)(52536014)(4326008)(8676002)(53546011)(26005)(110136005)(478600001)(8936002)(76116006)(64756008)(66446008)(66556008)(66946007)(316002)(71200400001)(66476007)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1qXnIVm3MT9hisiDvlaEvqRwOZ9IuFO4v/1jslhJaXWEbEQfcbt03VSc9wwk?=
 =?us-ascii?Q?sWU9dea1jShnHIWmHElHh3xGWRtyB2qwxFMViieIoCxjiAOrhonhthKJ3oAv?=
 =?us-ascii?Q?4j97apIpFmpThrGF6YZNtXaR8Q/uzPPBUcxbtfYsFVN5+aos2Bq+f8G8Ydk0?=
 =?us-ascii?Q?+6PUvRhhgNxqTzeuv/vbE7W9yNXucU3frYJQN4Mz15Tq9+yrUZGHxzvSfwCx?=
 =?us-ascii?Q?UsqEeExedYzr4OdvFNCkqY4EfDZ8Uy7yiZaSE6d+QHGip9Zcv2NDCB5g5c/c?=
 =?us-ascii?Q?3mmk44XN3CRKfJ0X7sOW9u5mSJgDTE+Fezc7P3iOcdmmQboFp/7mOHDZI8Id?=
 =?us-ascii?Q?zqH3ScVhnrOGSO69lNULcS0ao3rD2M/BfbOZRRA3ODtMopS+EfSUboTLTBno?=
 =?us-ascii?Q?fdG0enmH+nXzVsYZCTweslJRyJ3O/HRaWmG/PbZSm6bzAVeFb2yW3WyqCOWq?=
 =?us-ascii?Q?U2ZyvdvNvF1u8VyNo6o5J3Skl42PktJJ4wVR5JNSM3cu18NV9PplTUIHYDTK?=
 =?us-ascii?Q?dreTc5EVF/TRCDvtjd24C8Mt899/4J0Qw75KCh/1JSlpIqMR7oDrdOG/I2TG?=
 =?us-ascii?Q?fDaXHqr8BdsEfZuX+lhDyxIvtvg05XNWwunrWTuzQjAlSDP7PJqu5eC4B75O?=
 =?us-ascii?Q?d/PH/xdVhqHXjIQN0vyiSMg8rOz5IlGpE/LGP89FHIZWE+hH8LD+Deppin8V?=
 =?us-ascii?Q?JQMzjAuK0URGZmMYz0Pwb0RWvAobmYRLB5gA9Nh0jmshCPLBFRjhjx1oh6gK?=
 =?us-ascii?Q?yRB8IGSjyBIeiZNymsa99nrQ84Lb02+fQdb+gfPBekv+EElHaGx/mayUugHA?=
 =?us-ascii?Q?MJdaAVRGtbF6u2v6dZlPyEV7qFPCfl7o8RC0ptU02uqGtUnysyTzRpNahpul?=
 =?us-ascii?Q?adVDpnNRhPlNjI09N/aJNyj/4B1Lke/3g4TR5Pht08YzgjLDTnx4NZpSkMBS?=
 =?us-ascii?Q?2DtQmjepm5X8i/uf8OW4OPNyyv0UV+rC2MlEPmyv38i2sJQukXFocDfB/nPs?=
 =?us-ascii?Q?xWktrsUkMjQ2/ZybrZrVojxJ9jVp2uXeOXl+mAIjZKar6kwRgKwriYZjOviT?=
 =?us-ascii?Q?pIX5EKgxUg+ij4mh3IqB/NDLoPLGZwtz/slY7KLoDdvyLUP/AEHVBf/Fgp4V?=
 =?us-ascii?Q?hLe4WifDQQ2Hbs4mUhADwheoygFYPW6DfURZlLPVoGhJjmuoCVicO8KZZWaa?=
 =?us-ascii?Q?TJaVXmERvonHHG01uFWwh/TYeGu295pSe6JmS/WX+/rSZJ10TqqrFBOsSs7d?=
 =?us-ascii?Q?ncP2z2pGM2E1pvS6rbZ2f+VJL0nxib76bQ1r+lE1uRTbaesd5V0nj7IvhdW+?=
 =?us-ascii?Q?C4bm/aJmWEeNDglMHWfd98Y3cokAfkg5aoZhuMzDr/3/HtW44zk8l9Lr0lGW?=
 =?us-ascii?Q?R0F1PM4W9QVDCKoSf7t9Q/a/aZ0rruLFkUTDIphMRIZnVGxo+ZedeA7+7U69?=
 =?us-ascii?Q?DwJWNk9YG8u4GjFa7Mv2eQ2prTsnbbDEBhmw6WLUbN3RbzLERMENNfSPZJps?=
 =?us-ascii?Q?4W+9teW6kRwRQk0voiYzr8DPD26yxW9ELqhiT/t7cG5/Mx1kCMUH8IbZpAch?=
 =?us-ascii?Q?t2O05OwvjglhVe5qO4c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0100aa4d-aab2-4ed7-0e76-08dbc660a4de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 11:37:38.8165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyAiII9HSFLX0osvnFxqpEtmrlG4w2q2wI7IpMOGC2KCm4oX6HuI8e9OMUexonDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Lijo,

I prefer to add a version field in header, which is used for compatible in =
the future, what is your idea?
When the user attempts to parse this node, they cannot accurately determine=
 the format of the content.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, October 6, 2023 1:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Deucher, Alexa=
nder <Alexander.Deucher@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition

From: Alex Deucher <alexander.deucher@amd.com>

Define the pmlog structures to be exposed via sysfs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index e0bb6d39f0c3..9905228fd89c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -980,4 +980,19 @@ struct gpu_metrics_v2_4 {
        uint16_t                        average_soc_current;
        uint16_t                        average_gfx_current;
 };
+
+struct amdgpu_pmlog_header {
+       uint16_t structure_size;
+       uint16_t pad;
+       uint32_t mp1_ip_discovery_version;
+       uint32_t pmfw_version;
+       uint32_t pmlog_version;
+};
+
+struct amdgpu_pmlog {
+       struct amdgpu_pmlog_header common_header;
+
+       uint8_t data[];
+};
+
 #endif
--
2.25.1


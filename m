Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104E3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 07:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D08113F2D;
	Mon, 25 Jul 2022 07:29:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70030113F2D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 07:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9L+jd0ErCn+j5f9lg9ZqReVfjbYMQz/h/+Gb8J0e0OgpVLAa43a/zkt3aIZnZ23YUT8SbdBvjacpjdw6hFskSmLp+f8sGjlK76MIKW+XAdnFCaCusDwaylvfDhjC2Z7BWE2XJI3n7gzszxx7cbG1J50FEaaJ8+FfwviAqYqPrsblcaFIRJkDgllkjiCpZW1KIvUj3/gTKR7zlVPqlaOJenO4l1D4V0duz8cmllD7HDXEEBQwg0OeVXfi1ehExQquZYWUaL1NB22H5FxY2HCYiKtWSlKttt0bhee77pPvbb+HwvRGGwzUgEuxRc6GLxrG354W1eQk2uBBAP+yoqHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maH425aD8VQ2uKJpJNmlYjoDzQTOscBQQFeQICmUT58=;
 b=lCimynAOhGzvtTlNCQ4J1AOvsAFZqPzyOP6BXvr8BFfthTUuXAXJz4eplOMQ8Y/3DEmFvb7MCJ8pVl9GyLxqHayVvAvjZXyq/yvevQtC/VkbA47wvM9Ir+HKehmwZnluhWrO44sVsr5gb0BPAD98//Mj6oOYu7NflfpB5N0Tv0o+XgrOclZOV2xLM7PZ6+fTKkUausFaz4lg/hwj6rNnTlUqbXna4+uIAOr8gd1CXQ+7AWC7gnAhLEdDx+qnb3MxU8IIR3S410F/NDm4YcJCNwdZg3Vqkd/u/pZGpp5Gz239Uvmu1R5sU8U18KvJTH5b+vPlQlAk8Ra+1fESpohrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maH425aD8VQ2uKJpJNmlYjoDzQTOscBQQFeQICmUT58=;
 b=BrI9BGSRfPyuKZ/zXoVjig2/VoRBOp0wAsSXD2n8xhL168wIBZDVBu5sKTwgaoVjFcZ/H/MJTkXxWT6YZRWV0dHy8S0mCTnHV81yM368akR2aOxjuW+i81uhpVVZE1Va0JR5AQgPUUY1u7dmjmwdx5ta0pxVH62jV8Ogzs8gypQ=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 CH2PR12MB5003.namprd12.prod.outlook.com (2603:10b6:610:68::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.20; Mon, 25 Jul 2022 07:29:36 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::ac73:1fda:f26b:f1d]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::ac73:1fda:f26b:f1d%9]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 07:29:36 +0000
From: "Sun, Roy" <Roy.Sun@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix the incomplete product number
Thread-Topic: [PATCH] drm/amdgpu: Fix the incomplete product number
Thread-Index: AQHYnYd/NAXia2/lGUuuXq5CrG8zKa2OtXpQ
Date: Mon, 25 Jul 2022 07:29:36 +0000
Message-ID: <DM6PR12MB5534F34CAB5A844675A344D6FF959@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20220722045646.106225-1-Roy.Sun@amd.com>
In-Reply-To: <20220722045646.106225-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-25T07:29:32Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bc17c0c9-c04d-4c85-8736-92eb5c456b52;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f77cd162-52bd-439f-d31e-08da6e0f6d8e
x-ms-traffictypediagnostic: CH2PR12MB5003:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blrb8DZIXZVoEQfCy9wXHiij6qHnKKq3g9HX+edGWZAX9/y6PPC+6h/8tcyy/PC6X1AR+a8/qLrtmCgIFojqdUZn7c6UV1zJqLMM4ccRwfw8oNEiWjRgjjBMgcO5bfRSFWfniqHACUxyVDDkTU97NXavsr/PsAB+pauTnobAqgFst2teoSYV48JzsppQU6ciYp6axdEepI61V6TJJaqCtYkaoYKeTFdAIFTFWDK06aZ38Q8MEcv51qsfAjjU6GocdoA6ho+KKcsHN7hejNgsfatF76KAD4/7EN4IEBgBBNnXloxX9TyotgyBvChc68Nd5Yohnbrn3nQDzEMjFrGW/yr+dDrzvFG9J/vFpqhzxydwG3TuWD3A3rmdOEGgZngbKc4PqlRMSMn0cKN5SYf2uCM66288gdQr430qvvXW6s9f/cq63vR5OUW1OGOsxNNuryvsLw+9gcRwl+teRigNmlexbcSWGJOZkFvX6l61m4P/VxqX/nVaeDGEwkgBVADDHI1qf+RnRiAfh1PrYa6gJw1AsRZ9N1ssjf/NwcduM3Ajv8q4WgdfBc4Pd2RQnpunXWoAZ9MhaUR+AyjCF7DzoI2O25QMschurtkZudnmcoHjFlEgGw/VFMZH4KX8r1g4IX9XhkK/NZELZjLJ0iaW+NiVuSnRSLJGC17G/v0ZbLAW0nI/MZiMOns/2Qnl1pjxb5BCCKt4hMUNPo09FMHnd+frIuYVTSl7FZjcWpE0MNOwDn3KwLshKoVRixlnGkl5cY6i90F5nl9P6Y0xOXy3siO+ngvHV7Pwg/hiLL1nXVqp2vgdTDdJLRg1FkeFU8ox
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(122000001)(83380400001)(38070700005)(38100700002)(66556008)(76116006)(66946007)(5660300002)(2906002)(316002)(66476007)(110136005)(64756008)(8676002)(52536014)(66446008)(8936002)(26005)(186003)(53546011)(478600001)(9686003)(71200400001)(7696005)(41300700001)(86362001)(6506007)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5pscGTe/XuCZ6Fv0AnOpHhFGy3nKVXHPEC3qpX6rihnsmADZ4NmZLPCoiIO1?=
 =?us-ascii?Q?u4hu2HX7pfO4KJJcmKVgstuTHbbTPElNdeAp6Q7fuV6jqhGGDWH7faXV20xZ?=
 =?us-ascii?Q?DJLLcmADuZX0060NhmaAkZt1zQZFLUJwQuVR5dUAViXz/ga7N6x42tezoXOf?=
 =?us-ascii?Q?ZDapyQuHmXfjsuOMQpmRXxKCUhXVUXMQOvMipTVWpbuwQZKx1tyERF0FiK4Q?=
 =?us-ascii?Q?ShKYgjXnHrcqtGgWHWqmsXzzo03lk7+0tO69FIJuGItiO/bSyBpk5/YzbMK8?=
 =?us-ascii?Q?XDZTiuXSThxcjdQhiVGuYA6WFdNUn1LjIq0hizWOMX26XEHNiC6Py8wutNCF?=
 =?us-ascii?Q?D/FAXCz9FgboyDEh4pC4tL7pI19zH/m0tbs68yGRvr78PHLCDCxC8nzXQI4j?=
 =?us-ascii?Q?1gkl6g6McoPdLBVpl4tOMi45bUOLJK+rHKVKgl+FK23dZtfpDy1My8AedWfK?=
 =?us-ascii?Q?2UBMKVraW5ojI+tEkL9cqMWeOMi6Dl3BU4MWM6yPZuY31FunKOV0DdZOTyse?=
 =?us-ascii?Q?nOUfqhjGGoWIqr6McFPsRCCH6+bb7Byl6xJWJBDi6s+iw6HCA80TjoumIr6s?=
 =?us-ascii?Q?Tm+mwF/0m7Z2IhqSRX+FuhHHiBEcW5XCcTUi2GaXvFN52g9GzKOze18DLby9?=
 =?us-ascii?Q?vtQv+r8UToKsu8ZUC2lcmGvADxS13KXN5nktb0EmV7krJTcfrU1o/8gIhGq3?=
 =?us-ascii?Q?Hdo0sv30stLkPl4TIsiJjCjfMDwXeJjq+z96RitjFTkZ1mweHe9y1UbCLm5X?=
 =?us-ascii?Q?FcU3OQeCLEL0B5np75F4WtQxm5t8v1iB3uUWv2Vu4Q0WHS1TKQsIEf7oeMQ9?=
 =?us-ascii?Q?VWUSA7+rV9OswmlVn1kr+bFPE4WZfcMd8WNzHkKX1yb069z2cUhmcJ3FBcET?=
 =?us-ascii?Q?zRWvOFiFkQiI5NRZSm8huhMJVhFAqFWwZArhhfepikKWIhSAU9WvvRgPd1I1?=
 =?us-ascii?Q?aXgnGqM/iQaF5f7sq/PNdxDZqbZ/qpDim/ZhOJDhqTEl9+ikBOi7okwQttCd?=
 =?us-ascii?Q?SJsnQ3a4/flq6ESDTIxpk6tg+TTPfvG6pUhzVvq3jJuLv1beKpQMm2ssCHQG?=
 =?us-ascii?Q?3ww0rMCOeerLALJalyLpKI1LLaAK9rq6V+XoFtd3XS3tw1iYHnoojpXVF2pv?=
 =?us-ascii?Q?cCDDg3fR3ti5Cj/5e32D7MoJSoGEF6z4+whvpamWDG8oL5dbKtLBHWsui8Ml?=
 =?us-ascii?Q?F5pNO+cjwNqLKQZz8Xjm1x5j7g7uoS/tDx3OMlfa/022x/7bGo0v85Q8dCdT?=
 =?us-ascii?Q?Fkx20v8smOlSsB4E4PNXiYQrUtL9NBPzTn8cOw5zit+Qk3hDjJRrP/gCSqzb?=
 =?us-ascii?Q?U+97F0HZMJLyA4gWIz9ttojBkuOeCeGZs6ZQmMjFpIfmk7f4tBQi7VouFpL7?=
 =?us-ascii?Q?zqdvxOTXU72uMrNZF97XHOMIjFExigl9WYBpPvEaUsCFLaFFWOftji8p2oBI?=
 =?us-ascii?Q?M8IoVg9wbg1Cv92h4aSRUkAePsLzwou/zXHeZbMbpd0NrmiJ5MAUlSa/M9kV?=
 =?us-ascii?Q?tdba6JsZno5VSwXWjfISnGHnEx3Yaencv/pKJfDWk2n/RtWl+hR2lheElb7n?=
 =?us-ascii?Q?8jP+cYDe3g9HcOk0YHoBigCgX7FSFdWwcRLVYO/T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77cd162-52bd-439f-d31e-08da6e0f6d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 07:29:36.7519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeE2c4glT2AOm3BDdUk309gOKxyIgxJUzPW3V4ZLN0LlAXJgtlJC5AHuF0Iw3p94P/hIKsg03hWNgsT+YOiNSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5003
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

[AMD Official Use Only - General]

Ping

-----Original Message-----
From: Roy Sun <Roy.Sun@amd.com>=20
Sent: Friday, July 22, 2022 12:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sun, Roy <Roy.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the incomplete product number

The comments say that the product number is a 16-digit HEX string so the bu=
ffer needs to be at least 17 characters to hold the NUL terminator. Expand =
the buffer size to 20 to avoid the alignment issues.

The comment:Product number should only be 16 characters. Any more,and somet=
hing could be wrong. Cap it at 16 to be safe

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 9f729a648005..187e3dae3965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1019,7 +1019,7 @@ struct amdgpu_device {
 	bool                            psp_sysfs_en;
=20
 	/* Chip product information */
-	char				product_number[16];
+	char				product_number[20];
 	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
 	char				serial[20];
=20
--
2.34.1

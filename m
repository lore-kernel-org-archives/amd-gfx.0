Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111F3CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 08:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9182E10E44A;
	Thu, 12 Oct 2023 08:03:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DAA810E43F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 08:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bL4upR4fntjdiEJOUmtU1zgzAJkPb5lCWXgNbnzKTFBfm1iXealTVUEnvrj0pGYA74FYQ6RY67wILLu431GwOdI9jQRy9Ir0dZV92RYOs4uv0k4STrRLjipv78NMn6Sh1LwgJkrsqSnBpZv9VsNL1/+p91pLI9rrWMpMJFTg+M81haJAtoCou1nnBJvxUqICTzCcqfA2f6v+5ZhVB1COmPiJDTOd4iOxyLTcM2haJxu/6XOMw4QWXM9S2E0A6c/sXCDKHNobhBBlGG1eCA3sNQzL5NmFqB3n8oq7VhRC3giiw4aume98/4Yc00x7Ntrt2RCY6ATmqXobFwFffYyY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE4/xWZZnlZUCpKuN2oRGwiQFBs/Q5YM2LZ6hDdU+/I=;
 b=MhOnRUFClV3+dKxdXnN+a8D2njiBFu1owuuZHrUPzA5yYw9fe1lqT11UIzKOvOFCd3xPaIyVua/77Ht03pizAoISelkpP6JvW5hKcebEIgpb7tk+qj2PiNIPQ17AT43uCjFWFIM93fwnRUhdyJy/wGzrlGGv7DcF3fZ06Ew/wDqi5afznIVX63aL5tiGM0w8WAe8fKFQqFrpgA3V0+atAEM6XuJe3zPQBHeVNqf8PgQHhpu03XVHVaZfO1345RBOv/zGKJYZ5yZ5+PgE8GyGs/ERtJPYCn9ZkEmBAJoqBTHTizjFhQ8qPAnP9B8P7jU5k9SxbT/r9SjOzbkKRH0qpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE4/xWZZnlZUCpKuN2oRGwiQFBs/Q5YM2LZ6hDdU+/I=;
 b=Ya5JoNtEmMaEAODTaievdp05a43syjMtIwWUXW3GyOIvwkjTS1OLCv3RNpDw8u8842e5DcIGmVHQIn5AK64uvM7ByF6aU6g/9EPoQMe3FbJYpE9YFrWEjvfzjTV8xXIRdyncoVg5LhBfFi0Ve+oHq45szsd2TEk/sq8BzClZpUI=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 08:02:55 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6863.040; Thu, 12 Oct 2023
 08:02:55 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: don't use legacy invalidation on MMHUB
 v3.3
Thread-Topic: [PATCH 2/2] drm/amdgpu: don't use legacy invalidation on MMHUB
 v3.3
Thread-Index: AQHZ/N4/TN/Y1jUFtk6AZsgxLXHZVbBFyxhw
Date: Thu, 12 Oct 2023 08:02:55 +0000
Message-ID: <CY5PR12MB63692C04CDDC968311B8BD56C1D3A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231012073145.1076131-1-Lang.Yu@amd.com>
 <20231012073145.1076131-2-Lang.Yu@amd.com>
In-Reply-To: <20231012073145.1076131-2-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d16b3370-0040-42d5-a2bb-00ace13d04f5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T08:02:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SA1PR12MB8141:EE_
x-ms-office365-filtering-correlation-id: 50655f03-e0b9-4377-fca1-08dbcaf9a46a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLkdfTTYHkJkMF4PWWlF99YAUvZOCACYJ7G0cFSfg6h52RbJU6MJUAw2KcNvwVt7erGKo/S73+h/hgoBqDesR+tA4gnN6IVPvrBsGCKNtqke32M5dA8p7i18A2N4z8XpKWmT4sta7IjK/UbHrVAaZa0bhcPt/5jsm38vmBmj4DzN7yL7SCgN4U/dGSYDYgbtpP13qo+vBTbGGtlbndT+FFfd/JmmDj1QevT/nbHpJvj300Is/NbiiU10CiM6KBsESsKXWbuQp1DZsDOm6THRwYudHYZtSxcikDrO6xz77QDTXCANY1/kZ5n9+ZkYX1uY8q3euUdm/ZCT7T2UV4DfR89F587J7f7fddgnkaHoXjUZ/exaJxzXVIDayEqvJgU7zyIs55J1iOSmnbnI/hwNMHjkxmIEYD4Ms5BrrPjl3jqtN5u74sSa77LsmsrsPIaErkZ6XhVFQv3fhNAiDNlFqGqhVU+Fc44xgTyc+q32ZIMa8g3ioVTG4Bey8zATEuFoGqxQAef9rBcyRq4G8v3iQVFT+G3R9cweAUwE0UJYFNsHO3sRmJQDdK29EzY/WOYa2yxPkfz5ITofFRPDmq/GbSY/QD/mvJbEXv7CWBFSHE37v9xe76itFM912hVcc5tX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(55016003)(9686003)(33656002)(478600001)(86362001)(6506007)(7696005)(53546011)(71200400001)(122000001)(8936002)(5660300002)(4326008)(38100700002)(8676002)(52536014)(66446008)(64756008)(66476007)(66556008)(316002)(110136005)(66946007)(76116006)(2906002)(38070700005)(41300700001)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ANsMUuPTpBR+hIS3GwNzRqQ/tsFAfho93HAeRYXHhXZdZFEHDSor3wRMtGrn?=
 =?us-ascii?Q?1w3DxVIYiDC3IYTL+X8VdyQQgx8ctdujNbN6oN5ioXYKGUTpQq3VkzIqUqy6?=
 =?us-ascii?Q?xHA2qq7HxJfyzZ5lJ8BqufBOMxMmliyxPXHK49c7l69n59x3kPoMhOX2F3xm?=
 =?us-ascii?Q?VhFd+c+IVPFM0fpIa6p1eOaBsL7hQK6Xm3SArKW63pouaBKlhKq+DOfIXd7i?=
 =?us-ascii?Q?NDxTqUOJ7VlccNumYhoRTgWFom7aJHuCaiig61bPHSyI3fqoExlA1CF79u9C?=
 =?us-ascii?Q?DNMSrCRV1PHpu1zVkj7GrQSvAg/ZWWiorLabSFognjNqkg59xMsG4/8Gg7hd?=
 =?us-ascii?Q?xQ1GNwin69llTxCqjedhuUq0SgPE43wVRG8cp2t3z9j+1vkl35EmFFYreuN4?=
 =?us-ascii?Q?28f+vKegFBouBw34id1wO2usN1Zs7Kxy9gd20JiVWLhKGjFt+tUCb62RMgvF?=
 =?us-ascii?Q?hpgteI/0T5jXhGpWP0Xp8h4AhrECtCSHbX92h6++Ch/OlpWZcpT3cLXBKhpe?=
 =?us-ascii?Q?qj7Mbm7ibJfadZeGo5ETV7uDKNJCcAfVREWNMBeg+xLdED1Aej09uZWn6s++?=
 =?us-ascii?Q?vzwNxSiHoD+JuN+z8dNmeY055BfIRazK5F1LCuXZg19Gd7HjntceWUBJC2qF?=
 =?us-ascii?Q?L/IK4wi7EKt1OW/ViPQj7Q1K88pVGoT1P17FTEZ3TL3iGxssgld5vatZEIIm?=
 =?us-ascii?Q?dWrbcDIklLK4/134nmltbFR4rDI//XZai4JHrOfrMNDxNOGx+zSCBsj5Kn4Y?=
 =?us-ascii?Q?4kKs9FTuN45CTLmy3GK3HowlMbbQA5w3K18kNHdrf2gnqKZoraLCBWgAGqsN?=
 =?us-ascii?Q?GSzaV8TVsTbQ3wSduBtwKK0XVD8MSp45jm2QP31qSaI2Cf86a3hz/B/cNkqy?=
 =?us-ascii?Q?o36V3GvSDbX2ySpZ2CAErxP88cIC8/MbwFW0yIKdWr+iP3KqDWUjwR9JgFiC?=
 =?us-ascii?Q?g8bKTScRNcgs4Ivhlixdlj2Jj83uDc7VzH0ChpTrzBcqIQN5eZXeGoP2710p?=
 =?us-ascii?Q?Hu62NxTxjbdDveoGXkWxBf9O/9gPc9ED2OFeMNfkh0Y/2P/jlCejbXIfqZh5?=
 =?us-ascii?Q?fqIgE69TkczScMO73/xU3uK85yIsey8DqUBP0nZ5/1W1yGh9Stxw/oS8BUnf?=
 =?us-ascii?Q?mtIOXQS2RzBQR51ZoV4+69BBxCMj9rv1oTBqNE17+hvMqBZXPcTrCc1M8ppm?=
 =?us-ascii?Q?LvL1Y+3di9WU5/15G4yLruqG7Dp4STumMp3WURDgWS04A/gyROBYKZ9bu2nt?=
 =?us-ascii?Q?zUYDUNTUDEYlFVWhOnxV+mwPunRAfaLXqJLwlvixzT8bn/GTX5RBiVn/vScX?=
 =?us-ascii?Q?V0jDjXjUnJKwRrHRRQzr4tLpd/0PlGkai/BOTbrKWWpXFW06DYyjzYESRoJ5?=
 =?us-ascii?Q?WRvmybPBti/LWEs/+QUTcjJQqo1Gv+yKyGd8Fee9wLNFcO+5vyyMnDXU4qls?=
 =?us-ascii?Q?0BckNexBqTgV0RFYxGlFW+fDvIRRSH/p7i4l2lpdBwPJT3HSjfCXebF8xiDo?=
 =?us-ascii?Q?QZqYRMN0bdV9tnRAnMjJm1cDFGadfHRYFWglhZ8vmDtg4K2eGeD3C9S96c1f?=
 =?us-ascii?Q?OfJ9hJ7tRvfPKMDZ+eI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50655f03-e0b9-4377-fca1-08dbcaf9a46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 08:02:55.7069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3eMv8BNaRI2SLxnvGc+9cq6/3q24qWG1n0Yj7zRBjrToElAifvmsJLbaQy8umOy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

This series is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Thursday, October 12, 2023 3:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: don't use legacy invalidation on MMHUB v3.=
3

Legacy invalidation is not supported.
This is missed during rebase.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_3.c
index 76b12f015d1d..dc4812ecc98d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -68,7 +68,7 @@ static uint32_t mmhub_v3_3_get_invalidate_req(unsigned in=
t vmid,
        /* invalidate using legacy mode on vmid*/
        req =3D REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ,
                            PER_VMID_INVALIDATE_REQ, 1 << vmid);
-       req =3D REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, fl=
ush_type);
+       req =3D REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, fl=
ush_type ? : 1);
        req =3D REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_=
PTES, 1);
        req =3D REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_=
PDE0, 1);
        req =3D REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_=
PDE1, 1);
--
2.25.1


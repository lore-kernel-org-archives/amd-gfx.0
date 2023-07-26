Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CADC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 12:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6592C10E465;
	Wed, 26 Jul 2023 12:02:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B82410E465
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 12:02:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7uWVlGMF16tmgbVDUTzZR9DFoej3AacfvFB0e1kkq4dOj/gV3I+/NyZQXt1EENMTJPE5boQnkOabhJJrNrduGZI195z1PoIZoMU2WrfTrImX453yLSEA1avEE2GFVzP+6VGnlyLg36IA6EQ0pAdhyv+SASXw3SsBYZpgCe+zceWc4IGBsLwjAo63MJoSZFg/aF7QQbUca2By2vykayY6kxlgoLw+LTaUuOa9tHErYuLzeBVUlO4KCRZUhM4rZwuQMvLh0sRwmSBDuQ6xqLhx/YkmKnc1fJVvytxdb5JLqLnOt+ci1Qotloi5wuPq4uWwdI7UUaf6QnGCldnccTe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pmqp0IZ+ZinnMdI55eLprVGalZjJxPjRVYgbIrwRhw4=;
 b=c8NURZRoiqjn2okPvKCziGNCezursh2JjhID3UxN92dhqO2MHbxmR1Mu5JxwDDEYRm2fiRUkVT9xfqtOa8nsySbgI7pi3g8pdQdIc+tcc2ZGx4LM+eA642gRNlCz0N2I3XslaBppVCySCXGcv9A0Q5yu6tgydhr79j2nGgHxdhQg297V8oylcZZVZlgjk6C4diq8EYfIoCkCRC0/lBukEG7wAFfzBQXC1BgpEKgDGqspSZQJT0FMHcb2Ek+GSyMtg4YBLk7JHa3J9ZIwq3Zaq0iQJgwLHuCXOh10Yl2avG7EgPk45+lq3+yLjXD8HxsK7qUsIdfdl87Maw+4ptrRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pmqp0IZ+ZinnMdI55eLprVGalZjJxPjRVYgbIrwRhw4=;
 b=v6m+tO+ffNz0+x7gILEgpPndAmBnv8bS2+p4yVGY8u3DEG+1/RTfE/6fpGnGfwhkdWyomio+a2KvYB8+BtZyIG2p1YE3SsidoZkbYNB5nW3gDMq1s+MZDJXHf7pHbzU3xQ0HlqXIMNbWOLKe8EM5kAj0YBsdFfb0pQQIufzuWDQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 12:02:32 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 12:02:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping
Thread-Topic: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping
Thread-Index: AQHZv7PW0entoNuCNEGQaWONAy70lK/L8ihQ
Date: Wed, 26 Jul 2023 12:02:32 +0000
Message-ID: <BN9PR12MB525798EF052541B0EF1E518DFC00A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230726112446.653625-1-Lang.Yu@amd.com>
In-Reply-To: <20230726112446.653625-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: YiPeng.Chai@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=07298222-9798-4e79-a706-bad4ead32963;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-26T12:00:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB9250:EE_
x-ms-office365-filtering-correlation-id: c6ddad29-514c-44a0-1a0a-08db8dd0315f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3zUuxqyF0Y6TFjgDurlHHkluapxlMjvaOqw2hPBblNO3NxWjAPK3tmPsZTC+SuLDEpSXkTz21bBfqBTl6ZCTa5S4CVNyGCNt9RNR8Wb48gTDblo/m1U1opWiRc1O+9kuzihD6IoNjSac8K9KYRceyj6ruwGvjMWCM/MVZ9EWJkXcTzGUHhPwRd+LFNHq0SfIE0hnJtX2SMrR+A26mUkew11uS4EzL6WH5mu8Z6STf6oylrpW9gmp0lb64aJrGj3PcPPXjOF0CjMeA97e+jlQy+3SeaR0P8H13cY/hznoxPRYLAREyUxUd5rNNbsnSZw3mlO8VbIE6KAMH29jzhKtV2Aoe/fuD47wCrAIWLqyc0lMP6oN6wuDTDRG6RmIo4FBcTouRYg/Gzw66pHEx270/DcflVwHWLvM38EXS5hwAU83ajtVPxzQ1LETcXPZ/vPU8/436hu5sLD8TCDAX1/gGSOymmeODIrI74RZFvKolHBU6E+o5+WLXHBFNrsMNamTfLoKS8oBUhGtmSFpdk0xL7mNCPjk8MFpoIAYPK72/Lrj7rHuRIfuYDtlOiO+e1ZrHWtu+4KeovRICLhAW749tFPVwv83rXCFx2ErMpZ1K888IRfKzk2+XPWGTgWoNbYv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(54906003)(110136005)(478600001)(7696005)(9686003)(83380400001)(33656002)(86362001)(55016003)(38070700005)(2906002)(66556008)(66476007)(53546011)(186003)(6506007)(71200400001)(26005)(66446008)(64756008)(122000001)(38100700002)(76116006)(66946007)(6636002)(316002)(4326008)(52536014)(41300700001)(8936002)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kM+iurzou8WPURmfBQeW/3UDfTbpyMLv9l71kH0tEXUgUUZGSgvSoG+3KoqM?=
 =?us-ascii?Q?IEzR54NtdtOosOr7M/otDQvntobGHhSlMkGaQRYI4fnqPDnP7ATbCeEHEItZ?=
 =?us-ascii?Q?J6TLHVaAjelVZQbaeF/Ay3eFrxUY4ugrFM7W185OX9ydOJgA4RWyhBM+a+ef?=
 =?us-ascii?Q?j559c1XCs2pB/Z04YaVn8xTCcTDXfBY5Ay1mMyCaZgl/auV5k1kT3DG2zC2d?=
 =?us-ascii?Q?XEPqUqB6pPoKEPZUsmHDUrHIwO46eE/sqtsmkA4uCN7ZIEs19domXyiXyF/D?=
 =?us-ascii?Q?rO4ZyGM7BCii1oT2kRPAqD3nO8y6xIVSSghn29Zm0m/lO3r0pMG1Cevxiwik?=
 =?us-ascii?Q?NEe6MhJcpckcF+Rn+32RdY1lBdqOcstGGKI8spG/TtEd8OT6HziShyVzeRsx?=
 =?us-ascii?Q?TkBYlicAQdx5sVJX7tj4W1DRhZ54fGHREyKNJAY4O5hh3E4yIjGwvgvc+eFR?=
 =?us-ascii?Q?e+AzUTOQRv+v1k0wBk54AvhTEp8uNdvzUTFR8pGyN15u1p4cD/3pR30o6QIg?=
 =?us-ascii?Q?NstxhpU3nDVg4j5I3F4jhXAiz16OrmMJxYytxwRahWuEZ6QFSGmbSULnI+0t?=
 =?us-ascii?Q?34GcpMkIeJssLxm8NDNggGnTdusNS93qQfv9+aiUODSNfFEa6T/asAlkngRu?=
 =?us-ascii?Q?JpCSz4Y87MeqdjWKcYb0XxTongy+Pt/OwHu0dc16xpVxituoczsP9pz9Z2FN?=
 =?us-ascii?Q?cCoXOi2CpOJ3sO7g2UpPll/H3EbotsCeyHUvmDwl+03PKalT83JrbL7d03Cc?=
 =?us-ascii?Q?8DBUlNx0RScsTc/jiXT3o6CUEN1pxw7s7MShydFKeYxa5q9XSUagy2VezluM?=
 =?us-ascii?Q?inXV2bkZpGgb/6ov3WpRrH4JX4a884cL22gL106wG7twSjKxhZyuVjw3omcC?=
 =?us-ascii?Q?CwqFYhn7/jmLFrdkr49FvE1V72Rpn4sYb0wgfMZS/9NQP/dkQpNtOTG+sGiH?=
 =?us-ascii?Q?V3lQcSjGQ5v4M773nFjx1jstavbLkx3pwoARoLNRYjaSKg9aT8DFKwTuXFkI?=
 =?us-ascii?Q?Xo7ItsHP8+vQLYfhjLDrq1xw2RHDnKuwnUuuVRmsnfhaQ7dzvvfysLBlxaaj?=
 =?us-ascii?Q?DiJouyM3drocWApj4kxGKe8zjldyxLtjoB2WsVvmLaWPYbHFmJ1pa3yHI0qi?=
 =?us-ascii?Q?GkMR8JMaR6sulj77Zn6mihJQ55UWbTDdhF8OLQc5UF+twgJyBRXbwnkm5a8j?=
 =?us-ascii?Q?FPWa/F37T8oUTpbdGxeikZgr2BPQ1DgmuQaexJETAydVRoIkkffPQsIIhmM3?=
 =?us-ascii?Q?yIrzSuuBgCbOsUSorhRHmNwXuC0DqZJgTQJnvSxhzs518GYgTDC9f5QFLXG1?=
 =?us-ascii?Q?YL9Rz9CJb34spRzYmUzgtI+7yCgykNgvn2m3ZnDsEFbBWNhO0Dna6BPh/DlP?=
 =?us-ascii?Q?u2yalAi9VcIZFL3vpfZ+lwdORlFgY3BFxTO8eySPVUrn0eO795rI9DpZW4+T?=
 =?us-ascii?Q?PrPbAe0K0S1+fBfH3msjdXS07NDrLTCt2cSk/U9NOqA78R3jQPQvaHAMBlHy?=
 =?us-ascii?Q?rhvuXWLuLBICYfHcto0Sn/NPY9WM3MYN1EM2GrjpDzbgtNbpBUnSUDt9D8UE?=
 =?us-ascii?Q?Z3yrZu/kdla+kNeFHrc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ddad29-514c-44a0-1a0a-08db8dd0315f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 12:02:32.3959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xsij45qmhBQcfbByuuEF6EyYqw7v9nJSIarGp0vzIiQVDqd3OB7PftQ5p0A/YTeyJnn2TioC47dW0LBkrwW25w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
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
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

@Chai, Thomas sent the same fix for the review if I remember correctly. Mig=
ht check with him to see when he push the fixes.

Regards,
Hawking

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Wednesday, July 26, 2023 19:25
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd=
.com>
Subject: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping

Align with new vmhub definition.
vmid_src 0 -> AMDGPU_GFXHUB(0).
vmid_src 1 -> AMDGPU_MMHUB0(0).

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-  drivers/gpu/drm/amd/amdgpu=
/gmc_v11_0.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index 6b430e10d38e..9c4e084da99a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -102,9 +102,10 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_d=
evice *adev,
                                       struct amdgpu_irq_src *source,
                                       struct amdgpu_iv_entry *entry)  {
+       struct amdgpu_vmhub *hub =3D
+               &adev->vmhub[entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GF=
XHUB(0)];
        bool retry_fault =3D !!(entry->src_data[1] & 0x80);
        bool write_fault =3D !!(entry->src_data[1] & 0x20);
-       struct amdgpu_vmhub *hub =3D &adev->vmhub[entry->vmid_src];
        struct amdgpu_task_info task_info;
        uint32_t status =3D 0;
        u64 addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 604522f70d03..47f5ced12ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -99,7 +99,8 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_devi=
ce *adev,
                                       struct amdgpu_irq_src *source,
                                       struct amdgpu_iv_entry *entry)  {
-       struct amdgpu_vmhub *hub =3D &adev->vmhub[entry->vmid_src];
+       struct amdgpu_vmhub *hub =3D
+               &adev->vmhub[entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GF=
XHUB(0)];
        uint32_t status =3D 0;
        u64 addr;

--
2.25.1


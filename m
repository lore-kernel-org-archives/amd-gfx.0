Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5F9C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 17:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B7610E0F4;
	Mon, 17 Mar 2025 17:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d5uLXTVd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4298010E27B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 17:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wntm/u1YrKwCzynNqAG1x32JynPGYQdTPg2AB7DmTeDIl2SHt/H1XXqKLXK8OZoX5eVI4c4V0Yb0PFBf9MyGY0ITqWT4pom1WOA3SKiFLH0LEXdK9jQwLMr6WCmjeVEkb7uxT/I7Qf7XvrqgY8fE0LIPp3MTglrBuPfiHhKafONScMJKw6PGkO3Eo+yX/JLobchKQLm8uufHl9W1AIiEWumAt+MSsjIz3o/rI1ayRaIJkqqVIHOluSwAp9pzzCdPsuUpaOeBGBXRPo7VWQZKpCINOyFmLtnm8fXhEp/RiZD2DZHeK/FRgFSOZiYP3GfGldNdEseQYQn70fy5NJSaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoQMucxxu8Cm8rOQZFQDjyCEriqM6WSND9IM4ien4cY=;
 b=DE+bKWUMkcQ5Nd/EkUCwbfGAmNlVuNgZ7YSlsqXe03lrSzHsSWoAOTceQ5/I+TfxfoTBxiwtHYkk8zVRI7PcPNTH/YObYs3LdhgQ5kvetfjcQc0Q5QLyEcU9Fehjjp/ytBl4QXzttqcnFA//JiRgwBI289ostWfPUIQWOVPAS9FkCQw+r5yf47nUSYZej657FKDncVOqysb6crjU+Ha3e0ETjAbxLoLSXL2OxsaJNjYuayDP5enl5d9g7ljrmmAddtn4rjImfNnJZmnbSfzU9Yu8LXUkcfO6b3vrPorPNmt1mTmz2sONxeIiGmYFIyCwlFAqDW8wEz+8MxUV/A+1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoQMucxxu8Cm8rOQZFQDjyCEriqM6WSND9IM4ien4cY=;
 b=d5uLXTVdnVYao/m0XOL7jLGj0hQ+5yBSe1t+WvNZvvAAW7jUr8BA0LnEPVDAG/mTupg03lLMoVAZ8mJYa/A51YsZzobnfItMlX3qrJkXIrPNVX2SsiKJZNRI73I0TRZoVqyIrzB1PrpBCR3/0C5n/lLRE5GzHyxTqyejyHXZXWU=
Received: from CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:39:30 +0000
Received: from CY5PR12MB6034.namprd12.prod.outlook.com
 ([fe80::4d3d:786:6806:c34f]) by CY5PR12MB6034.namprd12.prod.outlook.com
 ([fe80::4d3d:786:6806:c34f%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:39:30 +0000
From: "Rehman, Ahmad" <Ahmad.Rehman@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chander, Vignesh" <Vignesh.Chander@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add support to load PSP TA v13.0.12 for SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Add support to load PSP TA v13.0.12 for SRIOV
Thread-Index: AQHblvVdQ9tIu1Gtxk+X3oV6yQStPbN3mG9g
Date: Mon, 17 Mar 2025 17:39:30 +0000
Message-ID: <CY5PR12MB60340DA7739A74626F93BBC28FDF2@CY5PR12MB6034.namprd12.prod.outlook.com>
References: <20250317043037.1131095-1-ahrehman@amd.com>
In-Reply-To: <20250317043037.1131095-1-ahrehman@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=98c6576d-3875-4efa-af2e-37de992f0ea8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-17T17:36:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6034:EE_|MN2PR12MB4222:EE_
x-ms-office365-filtering-correlation-id: 5e5b285c-19cd-446c-596b-08dd657aac48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Iytz4qHyL0wzgj/ljwIc++oGX1IfBKejMYT2FSLp9SK7cf7YJ1NJnykaDs0R?=
 =?us-ascii?Q?qzufpxPCF1OcdYnJCO+pEJUe1euZyB/L+xRyBGDoPixhvaYh6DS+tt+eY811?=
 =?us-ascii?Q?sjnykVGfJKEUmOzU4s1S9txlIEPinomdx33jM/CKtBB/9iMX5+9jGyYhBUr3?=
 =?us-ascii?Q?gaOp0+f4/stkRH8+/Hov8XCWtyFbso+KXsrZ00zmfnLx2Tl3wOVcH1VKL0i7?=
 =?us-ascii?Q?YHwNZNuNJ+UDINGbTXxPAiPoXixg96V7E6Mt3FXZGicFLvOeIuEzLRBYTqc6?=
 =?us-ascii?Q?BDryZqdbl+ywKpD9odwffuQYe99pZ7nxrUO6esEyLzUHgZdAfJKFC+Rf+XER?=
 =?us-ascii?Q?ND8DgQmxf3uPGtlkrjPmwFBpktMa7l+VgdC9bRoEqq/01s/eWhF1oLtVO2Hp?=
 =?us-ascii?Q?oGuEmSg0k7U19YdTbIYsCOhy+iyP3l3J141uw+c9IxCF+isGBYCMNo2/tkwY?=
 =?us-ascii?Q?qE2eaNP18njbhQ03jRHIVQu9t+sbcvKxmIBPc72KkSUhEqioiiVCR0OEvCsx?=
 =?us-ascii?Q?rVqRP1k87g2lKEfbLYE7LKTzxbHRHURwpGKXHJsflLcBlo5hz7cj3w4mAzVk?=
 =?us-ascii?Q?ljX3qlEauvQabCKj6qM/+hUzY2j/MHvU+bXYq+p6vy0mfjJFlpr60INubCAa?=
 =?us-ascii?Q?TDx5ogw6nb2nVB4qlUhXYZqakqt9/7t/aMaVnb3JO9PTY7kMhoCXuWhFIQvm?=
 =?us-ascii?Q?CBd8FMRJs1Bi2m8koAalFjE8MvhSRKGZ+3BGctPk13YPxUYg6IzFcOBIu6zn?=
 =?us-ascii?Q?+jzmyEd9oJH4cQy2DDhVEZx6ICMU/N66JpGWyWOvM7/xunqI9/yjneCpzzZJ?=
 =?us-ascii?Q?dMlcuTKbsNZi3zdTs1t5ZjDjxqvAHZHgbont3S5931jYCTmmMPLwtdqUB9AZ?=
 =?us-ascii?Q?UEpg5aOMGBQ4tcbVBv7wB6I7NCPaT34xhZxPl9ROhHyQpkopkFzDhOMJr07X?=
 =?us-ascii?Q?1Z13w3jOtQ8iRMHAKBaSud/sA9c/ywA8W/NQYdHfpDmOXtjKjMXhJ8hDFnev?=
 =?us-ascii?Q?8JxEZ6ym9j1PcJYxnS18ZZr561czp/aSzXbL93/pVKjJ90S8F2cReV1jp0jW?=
 =?us-ascii?Q?z6NNqcwl/0aUemBpxNNV8Z9FC3tUosErEnN6EE2C5S1kUyH2vo8nhTJxPldo?=
 =?us-ascii?Q?KTwAB/dkGkeKu0q8qIbijIkSSiSAvpn9C9OKqLbzOmSeFF9BZAoYMnpMErX9?=
 =?us-ascii?Q?VYkIL3XbEahDFm5AK158IY7WCT58rUzmIPNFOMTlqvATU2uscvfjJ0mCb2l1?=
 =?us-ascii?Q?DvrzSihP6vsqomP3ugmVeqO2SgakBYgM2cVV6BCZbNiYn0ssXL+Va9DYpmeS?=
 =?us-ascii?Q?DVHto8t5hvYCI23TVg4W3qjB3bga1Ur1LDDG5UfHRbtPbkeSDVper/1FwRE8?=
 =?us-ascii?Q?T/uWyaKxtAw9R0+/qzhTs7ToWKiFreNXwSeBhSv7Qum1tdol1cZQb+glwV1C?=
 =?us-ascii?Q?MqnJzhOTmgnhg0N3xzpag5wMGGKflxUP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6034.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r3QPWQ0nP8z9DoiYE7K1UV5LM2LbrjSuHvbAZGX7Evqtxcf/82ntKD8wrOc0?=
 =?us-ascii?Q?Bvy1ua0iN4Li5RaIT5zYC2Z66yI8cTO/XY/5YbsYTBWtzbRfsonePdm7X0um?=
 =?us-ascii?Q?e8ROadpKsQxFcdx/3V9Wrvrq1872Qhd30zd2+u9PHZCY9YLfMgW9HkWA7vMD?=
 =?us-ascii?Q?ZWOV3OUoVln/7IoGKVIx8uVcSGn4qZLJY7/QfUjannM1MJQ3AFnPsNRrKx2R?=
 =?us-ascii?Q?fcFNSVynijw72Kq7XOX/fpLJRcN2YHpaluxNfrUd3Ya67gaG35kefIZ2p5fk?=
 =?us-ascii?Q?wnVjOjQhANswhLJRyPOMgHJoC1hkdMFxhc+mdIQADcY40sNye8XRhCk+bQpj?=
 =?us-ascii?Q?JhuPc2tx0ZAngXNepuZYh9fcxD0o2+Du6XBREWTG+mm2jkfn43dHH+qMNmli?=
 =?us-ascii?Q?SuvqUMHbhVNo/qo3NdeqQz8ZEVT62sd2HwGol/HNC9SscYNHSo9e3B6AzP1l?=
 =?us-ascii?Q?FdmT42rX7RhzQ2EBt1YtegaHD8mW7wkM1A4ZbOf9Y8vVRWDVkrZ/h/3VGWl0?=
 =?us-ascii?Q?EeO3oGRFNwhfVjl6M3SbMCsiQADyDmpMVW/h39tpctHzJk8+H2NwwPUK6uE5?=
 =?us-ascii?Q?MN1eNclKd7SUzslzNuvsNQowLZMuKdxj9fwEtR/Kh3QT0hwFHk21o5q06QXn?=
 =?us-ascii?Q?kUpD8AaZcxJvbbgqjWXbNoa9+qt7pnqoODASGuhuJmDgJtH92c1V+C+UAuLp?=
 =?us-ascii?Q?TgJIiaSf4dveP7RNRwLgGxf7a4AL5933GlPKSF2BfBy4z7dToNRzN2eShywt?=
 =?us-ascii?Q?kzfIMxX1tdyWWbR0OyrJnGTO2zOsRlXpjGtRrzdHAMqYLUkYtsafS+e5D+YS?=
 =?us-ascii?Q?0FEFH89ZchJ1fbY6pRmsAVgKb94cYRHTuwQTN0zdXY8no8xy5OyWibohBruv?=
 =?us-ascii?Q?4bg5j7kT3/aMs6h2SRBIlDENHPUGHpcZf+zRvxDp+xbasO17kWxBukebgNwr?=
 =?us-ascii?Q?/qMDhPe1EDShdPHmIOSzf2odcoGX8ZcfmZK0hRA2DaiZg2bWlPJMA6d5sQ+g?=
 =?us-ascii?Q?rP5iR4n+9gCN/+YhM+es7wypCiICOjF21WD5UFu5kbGC9VSMp/m15ptdhJxN?=
 =?us-ascii?Q?UtM3RUXowRd4gDLZ7UY4XnmpvlqEEU/c6JrQkcrSErHTx+wDrUICw9WswmhO?=
 =?us-ascii?Q?0VxkeLNHulol3kLeASii6iv+AnUdRHd8zUw50rHBc1IjxeNyoAALg7AA78Mo?=
 =?us-ascii?Q?kNtgCbiiT8IP8ZL3Ygqplv1IwygiC2XE0Bmj5QzgqYDRWsuGzTbWrp708fOK?=
 =?us-ascii?Q?+q/0RZnjXs87lIkiCSyxHu1CKyo/X3HqfOorAKhStYmrOYNykJkWxbA+2ioA?=
 =?us-ascii?Q?713bJcwK0E7ehqLbLsV5Wi1RKAMuG+EarzSvmn8rbxLr+Zeq7QOotoVn639D?=
 =?us-ascii?Q?lqT7+liOBiVUTmBJnLxKkWF7vF0cGd4lzIqGE8pOgyW5kCB1SOpOSzbITRAQ?=
 =?us-ascii?Q?7rr4svGX6eVVY4MWOgx+vLb5X9NsQv9BDTqLdS7YnIRuCbyvm1n3f0R4/+AO?=
 =?us-ascii?Q?O41jyzQHG3uwIIbqMGk2X75d6zYbAmyRPt4ULJ/2VKfRy3gnm9PJ+0uCUh/2?=
 =?us-ascii?Q?ndATu15Lbo/VCroUoO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6034.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5b285c-19cd-446c-596b-08dd657aac48
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 17:39:30.7277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQouWu3uuzm7KXr3tK+Q4d2st3w7r1R2Tu0lc2zTPLGbcI1H6hebFDpj+kjwoDbvpSKvljgHgAo/tqesMzx0IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

Signed-off-by: Ahmad Rehman <ahrehman@amd.com>
---

Reviewed-By: Vignesh.Chander@amd.com

-----Original Message-----
From: Rehman, Ahmad <Ahmad.Rehman@amd.com>
Sent: Monday, March 17, 2025 12:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Rehman, Ahmad <Ahmad.Rehman@amd.com>
Subject: [PATCH] drm/amdgpu: Add support to load PSP TA v13.0.12 for SRIOV

Signed-off-by: Ahmad Rehman <ahrehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 79dad75bd0e7..04a186d0c236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -153,6 +153,9 @@ static int psp_init_sriov_microcode(struct psp_context =
*psp)
                adev->virt.autoload_ucode_id =3D AMDGPU_UCODE_ID_CP_MES1_DA=
TA;
                ret =3D psp_init_cap_microcode(psp, ucode_prefix);
                break;
+       case IP_VERSION(13, 0, 12):
+               ret =3D psp_init_ta_microcode(psp, ucode_prefix);
+               break;
        default:
                return -EINVAL;
        }
--
2.34.1


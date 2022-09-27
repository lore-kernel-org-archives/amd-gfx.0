Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF38C6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 09:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA48C10E3D6;
	Tue, 27 Sep 2022 09:35:56 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6353810E3D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 09:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxWwQy5kuDeEf4hrdGBuKKVEYMkCvS/a4yjPEgBpZ2JZI4HJYB8KSKqvb3mlDBMoNSctH7RLKDIdgpnlTG+t2bmgCXuQ7rzKDUwgqVxVIx5gMJjCHf+Ss6fv9Bnjy5MytDx1G3otsFyc790DMrCWKx8vvG+aEEC5FnXuOhduki/Ec6haDavhdAnSX1e+GnE/zLy1pXPe0ZTg4b5p9if7sifDr08P6gErtppKb3xGL8DXjG9VJwOTumCcJ+fRHf6hyVu+CAslBLfA35X8y7rKOW4GSHAk78WDCU8slkQ4aT+80tvcizNpkOYpKhBDy/cukKJEebCVpRynKTqpERBPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA1LrHGwTGjfRJeVISdNFljavSXU1sIqrMsX2gXFpHI=;
 b=QvEC95AHTcYf+M1/gQHvhzpd2axhoDF+sr72mtQMJvZt0mba+dnMRnH+M7CvycPWZGE04GcBwfFhP4Jo+eXCOT0ZfuHV5F13umOiaN9jF/PQmR3uc95qHPLyKjWhYIf3xE5IgIrBBxKXsWS6fdYMunJNP6h61zcZa3lwU5ivzBP2KlWoUAhhRhENFDmuVZ1QaCemOPmcoIh9WXq7PWJtNqVQFeZeiUPWf0mHqQYsTpZhZcs3q7UvqZSQu0oRzmfsFZESPzyajemRWNPzNnkOvaL+vAg4M+w+5qlNm5y5db74G5q3kXRlyYm2ZSgb6xS82GbdzlJJm1deh8LUQDJIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA1LrHGwTGjfRJeVISdNFljavSXU1sIqrMsX2gXFpHI=;
 b=HFCdRudYSAvAuCNZ9lpjNorn/yi0xBUHrt7rx+e10NXiWQlFfgQtyYmfmjo9xwP76w3q9k7SIhGp4p0IJwsk+E/lamInj5cDOMcXu70ON+DJGxcl49aKXRBMN/f4rV3P3X5x7z0E3NRmZgd+N1cixhDxJJ3sY2f02fN1kRyyzqo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 09:35:50 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%4]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 09:35:49 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix compiler warning for
 amdgpu_gfx_cp_init_microcode
Thread-Topic: [PATCH] drm/amdgpu: fix compiler warning for
 amdgpu_gfx_cp_init_microcode
Thread-Index: AQHY0lOUNichBNMg7Ei42n+8JDByvK3zA+kAgAAAZHA=
Date: Tue, 27 Sep 2022 09:35:49 +0000
Message-ID: <BN9PR12MB52572700623A78D6965B8E09FC559@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220927092841.3135548-1-likun.gao@amd.com>
 <DM4PR12MB51819408B6DFFFAF9AFABDE4EF559@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51819408B6DFFFAF9AFABDE4EF559@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-27T09:35:47Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a27adcda-daec-4139-8a1b-0e041d7a60fb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CO6PR12MB5410:EE_
x-ms-office365-filtering-correlation-id: 66c6d2df-ac22-4aeb-d83c-08daa06ba9e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /0w1vZhNcFj34T8hf3L2yRwfs5t2ScItcUJThGXm+s1PYrxiEwEmGBGGtQs9HgZDPOtxDmJK69gCb3DCHeObvnD99oyZFyX1IJZKIWv64B8b71F7irnaLiWEfAfFQsBnZurZLrRJ7/j+dhGSiFS4/LoyFak7TW+5S0h5g7eLLm8tsz/z0IhanLhEfg0UhuRvWUUHh6VcSZk4qIwmrao4rGrUMlq/J5Stq/NUrkwmj0qq4e8ZXIv22XgTfmcYxyMLbI4Rp8G7/aGdvpD/8Ic0958wSbCGY9G4dPdX9HL9kb3zylCPyHYeJ5ZWa0IFvKTbopAfYzLzYmzJaSu74Kbb/Mkg8cD8LRrqrer9Gx4Yuk03a6bIlaSk9LDlDzKQ/z6lcBfGEQH+W6swXuGhIdHclDuK7eXM3X1dWhqptCEVEjcLKUco2yhXjThlnpx1nY9IFSPo6GJkPLEK7EVOisCS9T88Azua891mJ+MxyQvoyeamq6sAIKA8b9Oi4r/73yPMm6RrnjluH3zKkabOnXRsUOoGKm7hivIgWHuA+jCxbUu1VtszKr+zf4A4AJmqcSlUS6qsTM9EFni5e1RfyciSxj/1siY599RMgn5cUjmbtJv4y4d3oZ7LMdqKSm2fxhjkQrLvqrttnSi51HFxXjtqVbvVTFSs9PcLpZXjvZqSgOt4vHeo87ebg3PjUJkz8elD4Oe+rXCBLURtxE7eyj6pbYEdJ9CksgaoMa7s/TZt6Rg8ougmD2Q4VOfGCZGubmvLapH4q2GQOqW6WALTsc10Jw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(316002)(110136005)(55016003)(38070700005)(64756008)(8936002)(52536014)(33656002)(5660300002)(8676002)(86362001)(66556008)(66476007)(66446008)(76116006)(2906002)(66946007)(4326008)(41300700001)(9686003)(26005)(71200400001)(478600001)(53546011)(6506007)(7696005)(186003)(38100700002)(122000001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T4o+7iW3LG4CKfKV27F4m7NpDIcxXkf7jbSttIX2n9dvFoH0AYw3XYzHTaQs?=
 =?us-ascii?Q?uXVUO0LYO2ce1BEiiEtq0kS4X1zsKVD8s/3k8qgu48fMsA/52IuPvx3sWKSe?=
 =?us-ascii?Q?hE1QRf6SM6NuPzU0XnQ7MOf8Q/il3acEE4F6eAW9lHgPdT7ip0OZF+4giSgR?=
 =?us-ascii?Q?nm/z6xLEsGvWRIRBQGUwGka0DZFrr5W5yxa7qHIEpYzRklI0Dd96ibpfObCn?=
 =?us-ascii?Q?qxgYM6rZVEwPKNLej+ej/+N5yH0S5nGrKRYX3N+nH0mPkzxgQmDojEOhsu91?=
 =?us-ascii?Q?ywYzweuHPgtF2USGKXC/NpF8R3rBRR34Dw49S/U+Btcgr5qwxcyjkPN+/y0m?=
 =?us-ascii?Q?6jZG7zroZj2oG1GQ+hVrpECwsXffx4kXbXLog9X+1odI4UB8PHc0AR3q6xjt?=
 =?us-ascii?Q?BkavuCRoIAkFx/WW3hFyGhPMKVyFImUgvEnXZ8DXX3WyxB/WFFocoOHwGSe6?=
 =?us-ascii?Q?MpBCocjkcKzkCXlq5qii2vejUJJspoojH/Qn9m3j6DdJalFwsM8m1iHTjCjD?=
 =?us-ascii?Q?a//hwCxg01cQnbXal/7QEqWDGEwaOOJc8uYS3c8xmVFYyXo4Gda1bfhP4x+4?=
 =?us-ascii?Q?eNBCCITZ4Gbauko7edXave98szQKmtCVcSb+myTc03JVzy5mwnXAbrSlCZ90?=
 =?us-ascii?Q?D1z9TEOjSTozhkDNkruS5iMxAvWGSxPme4Doz4K6rmFSck2bKyga/WGOhh5X?=
 =?us-ascii?Q?4GPqgwYLn0RYjRAP+9pxdfiuwHsujzQc76qHSnH903wRJvffMylVVMUI0JRW?=
 =?us-ascii?Q?zLJzN9f0x6lDtBEYQl41erj67njmTul1aDbwQvv8++/IfQl4q0Ek0e6JjSiE?=
 =?us-ascii?Q?yCKGRUWypb9GiQvyA68D1W5Rq8D/veRoVB2ZMZGHuM7TO506cvyR0BsfcBQU?=
 =?us-ascii?Q?087VEGSnTo2vv+JW1ku2/2hvojHD/Zcp0+ld23SoPsh+x6ipWz09UgsH7Kn6?=
 =?us-ascii?Q?z/AKvhKDv5D5KOuQwbyjXuexTv7tJ8YGXSpkSwuchcOROBF+Tg3yWPU/4YaO?=
 =?us-ascii?Q?phxX8bTCz8iwx6yiSCYUZi3Aem77ZON+3snNcDELQyD6aYGIsXFWQmPYPsG0?=
 =?us-ascii?Q?tv68Koic1Jvn6gMlwzUJyS6d7tcIeBbpvMh64yfQ5XcdpPqNhQKJOKqELE3x?=
 =?us-ascii?Q?Rd0e+ybp5PRYsjIRvAcXyk4lvClDq8b+2S68C9Fwg+Ccicd1Dsr36LJUs+Lb?=
 =?us-ascii?Q?mTLkETufQJyHg8HQSLaENjHRteOl+z82nR9D+olL91YhugqO+Hs1ypaq86eZ?=
 =?us-ascii?Q?bpzrT3or8id/FgcLSR2a1rN5TUh/UE5p6dOUsa4jCPh6bz1hnHZPZrTw2Msy?=
 =?us-ascii?Q?WDsvGKcbprdtheME/k8qDQSD08a/yKWrZUyhVNC4apxKS8CVDQpB3zF2zJqh?=
 =?us-ascii?Q?jY5CXY+TBfMNtIZZjr3gVKluFr+c0230E7h77FFEfQADNTml/jfNy1V4YtDm?=
 =?us-ascii?Q?qwceYPcZ2Qb44zTeCG9FWgGuaky4BycEqxkTybWOPLGizGvs08CkbnXXHOzi?=
 =?us-ascii?Q?4cX7zoUamI4uYpO7bS19ma7yTaqE3aKfthsq4zi+c6l54q8fbJWaHtgpvypD?=
 =?us-ascii?Q?QgANSZxr8kCm9Dz3NdNaIRTm9GSqqo3iqc2Fn3wv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c6d2df-ac22-4aeb-d83c-08daa06ba9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 09:35:49.8194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIu9zYo28FzT1gSq5IOxcoa8yNYGD8iKA10gdEhJVXpspZ7P1zNUFi99z4w0wL8Pn3S2FJAZhlBVd/NHh2cDaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>=20
Sent: Tuesday, September 27, 2022 17:34
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling=
@amd.com>
Subject: [PATCH] drm/amdgpu: fix compiler warning for amdgpu_gfx_cp_init_mi=
crocode

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Change the type of parameter on amdgpu_gfx_cp_init_microcode to fix compile=
r warning.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-  drivers/gpu/drm/amd/amdgpu=
/amdgpu_gfx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index e3535a963c5a..9546adc8a76f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -868,7 +868,7 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev) =
 }
=20
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
-				  enum AMDGPU_UCODE_ID ucode_id)
+				  uint32_t ucode_id)
 {
 	const struct gfx_firmware_header_v1_0 *cp_hdr;
 	const struct gfx_firmware_header_v2_0 *cp_hdr_v2_0; diff --git a/drivers/=
gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index e9087f83d764..832b3807f1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -426,6 +426,6 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *a=
dev,  uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);  =
void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);=
  int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev); -void amdgpu_gfx_=
cp_init_microcode(struct amdgpu_device *adev, enum AMDGPU_UCODE_ID ucode_id=
);
+void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t=20
+ucode_id);
=20
 #endif
--
2.25.1

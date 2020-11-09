Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8696DC388F9
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 02:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22304206D8
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 02:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wJuWgeSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22304206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91598933E;
	Mon,  9 Nov 2020 02:27:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C958933E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 02:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZDwq8gTP8WgBiZI5bJGbsPM3K6PemlHLKMxNKovAfXr9oXNsBWrNvhpdZFWnVIEZxkGX7wqPQPXurVIi4DDFXrf2WbJqzhIbL9Edr53qmE4EPgVlCZsmGNbkAdq1tjnQjrg12StdvqT1xwdq6bazcQnjf4yTIc1GdMIQmnuHAKFlC7lo1XXpQqyglTTcR4esXbNGep+mnvPV5nVuyy8iqQazZjnVJiFy8f1svFhngrVhNcAYHEqdkKj2CG8aUfUzImIuYQOLiEWwmvxK5HRd9l9jAsdgWbINQ3CHK0c3vd19kLTQCyrSlAa/NvDmauVrZZq5ntrRmx/ukDopzWq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZic0/Uhtmh8uZYsLO/2Uy+mTAa2nMjCrLWwLBrvbis=;
 b=VJSoCDoYGr4N8fs86u6rQdZ42hsEvnhunoq7536VGaQBEDq9QXAUwgItwb93NN61CtnTXnUqouqPY5yyBYBP6Im01SzGifANFl3T3GjkVmph1lSU88ZgD2AF6ZXqxQYUFfcKJ51TASfhz+bnOadh04/CK8WdTw6No2ZJWEFh2BKcwsvyOLPXnwnJHhR7GS9URVFU/TSYwbHDpvN+ql4lW16DcdHzhCYhzZdEHgeeSlNLY/NsOW/2oUz3F3meOpOqByzeQaR8BsBD7OGRy5cnb0dbVZYK3cfcz9PysBQ9kF2/yM+m4HkJ5Ihyl3EC9FhVK1oCqOwpJCqGBY1QSBEi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZic0/Uhtmh8uZYsLO/2Uy+mTAa2nMjCrLWwLBrvbis=;
 b=wJuWgeSJWwdGaDUuJSvSh8cMglHOkOMic6Ik/OwtyGgzuRnpNRNvKw43w+6v+Cx22QvtLEp9iQcqnU/vBjKMfaL5zlkmza6Pz0MSy3+NFypISYlBjJ8nmNx0UVmlmetQkyBnP6cnDIpuhK1FVPz6+jBlTfWxrnRg5XgTbQCa6xY=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 02:27:12 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::61a5:a549:4cac:37e3]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::61a5:a549:4cac:37e3%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 02:27:12 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix incorrect logic to increment VCN
 doorbell index
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix incorrect logic to increment VCN
 doorbell index
Thread-Index: AQHWtKozEc9O+boyIEKiGbtlhyU/pKm/Fjqg
Date: Mon, 9 Nov 2020 02:27:12 +0000
Message-ID: <DM5PR12MB170801252FB4389FEA9237B784EA0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20201107020239.61768-1-Bokun.Zhang@amd.com>
In-Reply-To: <20201107020239.61768-1-Bokun.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8ab754a2-b776-46e6-9b75-0000e12adbef;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-09T02:26:50Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f1df0e0-4789-4d6f-d15f-08d88456f791
x-ms-traffictypediagnostic: DM6PR12MB2890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2890F84A7A7ECE0E55869AB184EA0@DM6PR12MB2890.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6S/VGH+1tiY1978uyF1SwXbPyuB7+K3ifNQt/YZO41ZvIp5tC8qKbvVArhf9GhUwaAUdVPIoA6HW8RJFEeh/YB4MbS/SXVlbfY0sH8qi3Q4pZRzO3DjtO1Io03VyBgemIwxkp/zUUQcuk0Cord7qnfHRwZNDbQ0NvDOuw9UtYEYYhjF8/T444Rd1MqbztvTP9OZ7G5orpff51+izVupvM9+7PHunhqDMLnp7pCiV6L0PxPKOnIhCFGSZkNi0AFn6KTzw1KdMPedtknhovXGP5unD80vobx5xzB8hhVnSCKMvv46exR0mBH001kiMP25oYfYLsWn4a7XkFEjjBifsnvZ2B++cA/qELGXwYKZZeLU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(33656002)(71200400001)(83380400001)(6506007)(53546011)(26005)(186003)(7696005)(8936002)(8676002)(45080400002)(4326008)(478600001)(64756008)(66476007)(966005)(2906002)(86362001)(5660300002)(55016002)(9686003)(316002)(66946007)(110136005)(76116006)(66556008)(52536014)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: p8zd9Fz0rI7aNB4nqs0rF+mZVnEBnESlzyz8HjOjr8PXUboj5Y2QdVGGnsokwEoG5TNFmXGdqL5lny8RSTQumq02w2d87UHZ24Edmr3Xr4cnxiGGIqER8e1U+P1hw87U2yPbvon7EzEXQO/+BEfbwVhwqnSKVwzyh8Rr2IdUR5OEhrqhVNW4pBi3BBCOxEHa+9LhgrnVQX+NZAO5cgDzgNkfAROk5kh1xt1IAq8R0D6JXJnyJXiiTgR85ucK+VYAV29CMWIiOq6Eu1DFlkoRtiLOS7MlN/dSdKvxc3IlpygLrfHoAOxIhsqJOUo5XvhIQrwOvDZ5Nm/EZCqJAG3jZlcZ0o2bPw4nT5byTK3xIhh1vp/T9QXLD8GA5TgTcFBQ+3h3ZhuKw9Kp564HjMeZt9SPS2+B8lCHJVvBXK49zRVo6vuW9kk2+DFgmpyuPXw6TB6/EjDdhVzKxrMLIKTfOi6vi4v0xOQgwTzvzp+P2+Qxq9UeqtrL8vxuXZxvg0SAcxHAgo/uUUem5zZnoDMolihbi4+1h9JJjp2A0XxHIfmFWFmrToOelZbH+siOH04/KvlgaiwB3Nsp3TRjwxC8OA53l30DN5zESKP1oScX39zLkQ1gcI2KeAF63OV7pWrgD+KrHpvBdrQla5OynZinDA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1df0e0-4789-4d6f-d15f-08d88456f791
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 02:27:12.6938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8OPyKg0t3Tq8MEzr7h2EWqrSMMzKCnCIwKIAysbaNZLjgfWECl1GdXXOTr3odwj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun Zhang
Sent: Saturday, November 7, 2020 10:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix incorrect logic to increment VCN doorbell index

- The original logic uses a counter based index assignment,
  which is incorrect if we only assign VCN1 to this VF but no VCN0

  The doorbell index is absolute, so we can calculate it by
  using index variable i and j

Change-Id: Ica36b2bc80efa896f3753f2f2e2539ca2ca6649f
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 269002816109..3970a0ccb6a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -155,6 +155,13 @@ static int vcn_v3_0_sw_init(void *handle)
 if (r)
 return r;

+/*
+ * Note: doorbell assignment is fixed for SRIOV multiple VCN engines
+ * Formula:
+ *   vcn_db_base  = adev->doorbell_index.vcn.vcn_ring0_1 << 1;
+ *   dec_ring_i   = vcn_db_base + i * (adev->vcn.num_enc_rings + 1)
+ *   enc_ring_i,j = vcn_db_base + i * (adev->vcn.num_enc_rings + 1) + 1 + j
+ */
 if (amdgpu_sriov_vf(adev)) {
 vcn_doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1;
 /* get DWORD offset */
@@ -192,9 +199,7 @@ static int vcn_v3_0_sw_init(void *handle)
 ring = &adev->vcn.inst[i].ring_dec;
 ring->use_doorbell = true;
 if (amdgpu_sriov_vf(adev)) {
-ring->doorbell_index = vcn_doorbell_index;
-/* NOTE: increment so next VCN engine use next DOORBELL DWORD */
-vcn_doorbell_index++;
+ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1);
 } else {
 ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
 }
@@ -216,9 +221,7 @@ static int vcn_v3_0_sw_init(void *handle)
 ring = &adev->vcn.inst[i].ring_enc[j];
 ring->use_doorbell = true;
 if (amdgpu_sriov_vf(adev)) {
-ring->doorbell_index = vcn_doorbell_index;
-/* NOTE: increment so next VCN engine use next DOORBELL DWORD */
-vcn_doorbell_index++;
+ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1) + 1 + j;
 } else {
 ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
 }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cmonk.liu%40amd.com%7C0ec09d9e179b4721263608d882c13981%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637403114148624558%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=Bn03tzCw6gyiI%2Fq78gJ%2BQQUGAJdABHG1Fup87tgSP0A%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

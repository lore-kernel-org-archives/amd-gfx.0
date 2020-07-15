Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E18C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 14:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31622064B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 14:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AkyXmfA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31622064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1EF6EB72;
	Wed, 15 Jul 2020 14:22:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538736EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 14:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/v6APf3QjZieOYVngdSt/48RKJfc14TzbSoFeh2mrOyV9A8EBRwFF2kQBSyV7f5ELN4CjKk7g0H4TZFXi9Tsc5HMbjHVJMjcYH0GllGwHbwilYwvzZMA38kO4nCHr0d5zJwIZF3A54dUVUShfTgmNkJpNVDUzT5T9UELC17nO6igvSPbCngm8dzm/Clmril9DkwJwPr46eciQboGdkt/cFKQ3NJzXoetzIGwjykp283lG0h9laFZqkPWp57kpw78cQud11HLPbo6wodZzNK+L52geBwNq2q1FI5XFylD/TkWa749Iv98tFVDHx9gABI/jKS1QuFBjs0A7BA1ES/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s19mhoWiVVKPcEbydxs1F7cEqhpA6w2BQ+u/LL6x3sE=;
 b=hZJyeoJXOzW3D0fShPbykF6vvZz21wGehL4H8w6dMAH85LF1QXO6erTzYVpTIa+/KeTOILe1tUv9X1luG078fE5LSMbsNQEBb8TTIx3lJTR1JwGJ/BiXOUKbUmXJF8Q9ii6gDQp9Xd2E9KGbdcnOGqJqbo+0xFDFgisLBRle9PaEsgcTsuAo4VutUEarPzOMzLH4UXJcqo89OOMBuiOb0RaxJ/peVye4kTG8PdGsFtZ60DgA4k4bDyfG7IG+L9HIaOiBWO0wO/Uc6uCiAb6P0EjXaXdl/+wuZRn2cTXziio3jozqQq5C/BEUMBqhIOxMtQl/odLjv9PIL1U9bLWH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s19mhoWiVVKPcEbydxs1F7cEqhpA6w2BQ+u/LL6x3sE=;
 b=AkyXmfA6/VoVYuUMACIq+HlhDHOhkONep4fr35JTNACcb1lYIgAcxJe4aofBBJZz9AoF7DagRNA5mgIHGV6QSWwbHY7fopLdDF1oIGeNSYsor2Lo1M5xdsthwY1VAu8v5P3CvmeXA5aJRvh8Y+r+YbKxcyzhk8StFx7CWZRKTiE=
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB3945.namprd12.prod.outlook.com (2603:10b6:5:1c2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 15 Jul
 2020 14:22:31 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::f4f8:d7fb:5d5d:e4e6]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::f4f8:d7fb:5d5d:e4e6%4]) with mapi id 15.20.3174.025; Wed, 15 Jul 2020
 14:22:31 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amd/sriov skip vcn powergating and dec_ring_test
Thread-Topic: [PATCH 5/5] drm/amd/sriov skip vcn powergating and dec_ring_test
Thread-Index: AQHWWmvUHpelOsPnDEmpRmVsm8ksu6kIsYCQ
Date: Wed, 15 Jul 2020 14:22:31 +0000
Message-ID: <DM5PR12MB178772B1227639A2C49DB550E57E0@DM5PR12MB1787.namprd12.prod.outlook.com>
References: <1594792176-12913-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1594792176-12913-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:a3c0:203:d987:6d02:1f21:2185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05dffbcf-e797-4cbe-f040-08d828ca82ea
x-ms-traffictypediagnostic: DM6PR12MB3945:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39452E494A3575668ED61906E57E0@DM6PR12MB3945.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XyKJL/fOhMZt64hvDEtPCqjB7RO0ekdOlQB24Qda7eD1pT5X7RcwXDjSiOBzqe5B1dE7yYG1rzu2MaatkvNrK/wsv6a89IgUQYZf4FVVtIiiRf/mAC6hTML2QEKaxzo9n58Cgy6rXOZYbHjqrwQJ8Vi+YUYcyOL/u8qBRUT3RnC0AZWu9BPvtPXNJGn+DehOmh2HJY7CTXN3+ZDys2TFnNIcoQnVdMyaNHnS61Rs45BXEjc3+jyaMwn6A0RlQIZIXXklTfP97gfu2lGe3YB/ujlnmd2gVkHCPttFHc0l9frWR8ENJHN6exkHHDANvXys
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(86362001)(52536014)(55016002)(316002)(33656002)(8676002)(4326008)(186003)(478600001)(8936002)(83380400001)(110136005)(7696005)(6506007)(53546011)(66946007)(64756008)(66476007)(66446008)(2906002)(5660300002)(9686003)(66556008)(54906003)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: QUhohlBnh95o5YyNgnSC8Nqsa87uR/iYi/eiifKCDKlWUc40/JUhgVu1OcxHl8eAnVw/9yj7IA+5uwgNhvDtaBQ08zELVFEDycgFtqiAdZDoN8TQPXhcIVqHxPcaUhGYF+Bs4ZqZesDNW9toAuYO2JX7gxlF5fOf2xZpLEEfjxVQrk6jPwbKHYU+wBlQnC5q6DV9xbpzs252P+BepmS/y/Nnxe+lHY7db3ZtOAQ6F4CtZTkNx3QPN/Rb+LDNgOv9qKiuDDtlGhsi0YIgbTyP/23XLJSwTpx6G9ny98qjyAcmlmI89Zvc+lm9E852BJywlBWYOoRxyk5E7soQ+kDZAQdWfTSyJEcy4S1lAiv5CjkHcZ6/LiDJDGQ3NDEOcyyOSceBR6EGPARS2o7ecSRao1ZBWnbpWrVmgV2HP7hSCS5ID3Uh/ddMmiD5l+UwGgiNirLZkkGSIkGmukDNIOu31+DFjRt2EYnqO3G2lkyg4T4iv6W9BbULAZGqEu4U7JTD1nfcROA+v4RrIjOttVUaLy4rCSot96bKe1Bu1werXtbT6zYXjExEojLUFHPlnLSa
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dffbcf-e797-4cbe-f040-08d828ca82ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 14:22:31.6525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fms9xrMJypANBGpI15L8U9SsFvN1gXEuPOKcYg7a5Etqd3gZcJEgCuBrkxTfrOpQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3945
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: July 15, 2020 1:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Leo <Leo.Liu@amd.com>
Subject: [PATCH 5/5] drm/amd/sriov skip vcn powergating and dec_ring_test

1.Skip decode_ring test in VF, because VCN in SRIOV does not support direct register read/write.

2.Skip powergating configuration in hw fini because
VCN3.0 SRIOV doesn't support powergating.

V2: delete unneccessary white lines and refine implementation.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 21 ++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 15ff30c53e24..92a55e40bc48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -421,6 +421,10 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
+	/* VCN in SRIOV does not support direct register read/write */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0a0ca10bf55b..910a4a32ff78 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -354,11 +354,13 @@ static int vcn_v3_0_hw_fini(void *handle)
 
 		ring = &adev->vcn.inst[i].ring_dec;
 
-		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-			(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-			RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
-
+		if (!amdgpu_sriov_vf(adev)) {
+			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+					(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+					 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
+				vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			}
+		}
 		ring->sched.ready = false;
 
 		for (j = 0; j < adev->vcn.num_enc_rings; ++j) { @@ -1861,6 +1863,15 @@ static int vcn_v3_0_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
+	/* for SRIOV, guest should not control VCN Power-gating
+	 * MMSCH FW should control Power-gating and clock-gating
+	 * guest should avoid touching CGC and PG
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if(state == adev->vcn.cur_state)
 		return 0;
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

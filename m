Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA079C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 14:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD82208E4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 14:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ej4iAgWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD82208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CA36E311;
	Tue, 10 Mar 2020 14:42:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD066E311
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 14:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn9UyhZ9H+omZwqIL2eLyfaml0bDPcAa/qbGN1+8D7bsxOIPl1zNvQgUvetjW18/8CFHrhMPn0+aK34vQJp9nm8H7TusfgTr+i4x4VYRaM7LYZPozhPFv2uDd6gXB26x2V8TX7fEw7ZyN/xxAdoMpgZ+WGdc3W2bCGoAONOSex/eGC/UazhRMoAEAptn0Ec6GtWaWihAT2g5l+PDD0e08id41YT0UmMeCnnRtkyYx1pW9p8MOPdyJeEH9FYeDwcoKFK8hZGQOQsjFFx+CuiLH3pa7qNieR6nj7wkmSPMv4JJEDiUmyUlpVAQwDJx+qcuVEmlLtYt99YuQMguuQGM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TBxNyhiYAYw6vqfQ4sZt1eI54wLZFZrQCSY+3em6Yc=;
 b=AnWSlouPH4d23MIoBJmfkm7Cqn0GL14ik/7x6qY5kOb7ePtRW19VofqQiKNxKz1Gh6vUpJukVt6MPS8uQ/c+y19z4FxhI2CaObglcDJla5XzwrmFfD0FS1sMXvchQ99lcj27DoyE1v2r/Ml3bnaDNUOoU0t/CV9iK7fEf+8EoJL6IQUD0gfs2un6laIp6cejBJUaJ8jnaQER0QCPYLvxqOnUO1L6BDIsAsXl1XANITsi+nWRpFWDXuAQSgyY2fGsjsZVJTQ25zfGWZjbUnepCKjUS64zVtg6ouc9WNl8QsWbDnY8qj7Of7rAwjTFylmUdCWIrHsmw4GLqeP0TlmRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TBxNyhiYAYw6vqfQ4sZt1eI54wLZFZrQCSY+3em6Yc=;
 b=ej4iAgWvzAJPOdowNvMyZFDaMIiZzRgAiBPjqSlLfWtHIuS+hBMcSZzZi39HnWIFchQcR3uJzot2I5jyVn2C3on49wEoceZPVdxDAX0mN8uaenM5HUi6z3KqrekG09e7cQjJ7iNAtn4fN5u9CV4uchDDhQkDZ4YVm0Ftht3c/ss=
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (2603:10b6:610:2d::11)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 14:42:50 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::a4c5:1445:5bf:ae2]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::a4c5:1445:5bf:ae2%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 14:42:50 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov refine vcn_v2_5_early_init func
Thread-Topic: [PATCH] drm/amdgpu/sriov refine vcn_v2_5_early_init func
Thread-Index: AQHV9to8HKbeeKS8EUqQNM2M0wXyJqhB5pQA
Date: Tue, 10 Mar 2020 14:42:50 +0000
Message-ID: <CH2PR12MB3672F909C9613C518FA68BEBBBFF0@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <1583844514-28921-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1583844514-28921-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b2dcebc-da33-4460-ca5f-08d7c5014eee
x-ms-traffictypediagnostic: CH2PR12MB4104:|CH2PR12MB4104:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4104E54BA1298F8BC7948D3ABBFF0@CH2PR12MB4104.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(189003)(199004)(71200400001)(966005)(478600001)(33656002)(86362001)(81156014)(2906002)(45080400002)(8936002)(26005)(81166006)(186003)(76116006)(8676002)(9686003)(66556008)(52536014)(64756008)(66946007)(66446008)(6506007)(7696005)(5660300002)(66476007)(4326008)(53546011)(316002)(6916009)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4104;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Vwm7Ef39bpw49nT/cAHZ4qZCl5t7yMhNXPX4OsiVdCvz6S0esZyarVqmCYyjxqrML6ljDcopVq5Fxl8V0mXzszyp/K0Y1wtMqj0hs5qRwIjX78y1eXjE5hcD26J74SahUiaOGWy3JVHjbbg8QCJQGxheyFsSfXoJZsFnHaytWt6iIaA+PcNy4mdmGB/ln8lMbh117lYNK4tb/ZeBawDi8j6Dzdye6R7NVCbBpT+jEU/7z1i9PzlFU99GkqYtsYH/HVdBzx0IQOR9GYDq0tFtjHet57Y2cNoHzrR9jiXQLuPTy467Fnxy5+c3vSOxHXwhqvwx5YLUWsQtu+TL8RTHCFepND51nBHkWonPzHmk/fBDrknxJijT32YDbN8DU7zMDGOTUty8B1L5TmnY729tnm+Ic8dwJhpHBLJAEPC8gxnJFJ9b+Re/lAwgXdZDxYHOFNtlWuTCOLWY3nhtefNvl4+FzPbRs0wNxoArGLPKVr+7tb/6zfRXfk4/eIiAB9zdG0AQWg+YDyq/ydG/je9vg==
x-ms-exchange-antispam-messagedata: jL9Jf9dShcFY9D1arC2bX82SqRjeE5YgSWK068RSYy2Po+Plh73BF/b5a0hR3rQNFxRtISvtytLSPiGszSQEpd7GQ0GQp8VLd3v7eqp6K3Ge76AXQuJPspMv854v9xIdu1CGQMHSVzEQ8fJZtMGGxQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2dcebc-da33-4460-ca5f-08d7c5014eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 14:42:50.4686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXEGACIdphmlpemVDUt6xmP4WFOBHlWh4wzi1+lgbLWfjYXDaPiMAarhg92S8Ydo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping...

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Zhang
Sent: Tuesday, March 10, 2020 8:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu/sriov refine vcn_v2_5_early_init func

refine the assignment for vcn.num_vcn_inst, vcn.harvest_config, vcn.num_enc_rings in VF

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 2d64ba1..9b22e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -74,29 +74,30 @@ static int amdgpu_ih_clientid_vcns[] = {  static int vcn_v2_5_early_init(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	if (adev->asic_type == CHIP_ARCTURUS) {
-		u32 harvest;
-		int i;
-
-		adev->vcn.num_vcn_inst = VCN25_MAX_HW_INSTANCES_ARCTURUS;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			harvest = RREG32_SOC15(UVD, i, mmCC_UVD_HARVESTING);
-			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-				adev->vcn.harvest_config |= 1 << i;
-		}
-
-		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
-						 AMDGPU_VCN_HARVEST_VCN1))
-			/* both instances are harvested, disable the block */
-			return -ENOENT;
-	} else
-		adev->vcn.num_vcn_inst = 1;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.num_vcn_inst = 2;
 		adev->vcn.harvest_config = 0;
 		adev->vcn.num_enc_rings = 1;
 	} else {
+		if (adev->asic_type == CHIP_ARCTURUS) {
+			u32 harvest;
+			int i;
+
+			adev->vcn.num_vcn_inst = VCN25_MAX_HW_INSTANCES_ARCTURUS;
+			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+				harvest = RREG32_SOC15(UVD, i, mmCC_UVD_HARVESTING);
+				if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+					adev->vcn.harvest_config |= 1 << i;
+			}
+
+			if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
+						AMDGPU_VCN_HARVEST_VCN1))
+				/* both instances are harvested, disable the block */
+				return -ENOENT;
+		} else
+			adev->vcn.num_vcn_inst = 1;
+
 		adev->vcn.num_enc_rings = 2;
 	}
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CJack.Zhang1%40amd.com%7Cb499c8855c4e497bbeee08d7c4f15e1a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637194413257832189&amp;sdata=Tw6BCqhv%2BteHBneDLesEYilaiu6%2F8oKQX4KKRAlYdtQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

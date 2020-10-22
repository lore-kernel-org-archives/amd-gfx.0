Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0CBC2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 02:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7765A22249
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 02:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V92lb2/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7765A22249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC33F6E041;
	Thu, 22 Oct 2020 02:50:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243906E041
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 02:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVQc/Kw43ZfoA9TGFHLWoiDQ6aH8yzwkuXCTlwb8ziJjGmB70J833BHlkuo6xpZ2UoE5PXghgvaQHuIGFWPzJEOT/H2wf+Bl4t/bQvrOemGfw78lZfRVhlYF9o4LxDEqPWs4hiaEPtIcur9ZpLv019+8yHDgE4yOFxZSt+XSwi8hK5DjcGW7vVfIJQklsFxk8kKzvLY0qiiRAmJ2ESZarvrVaO6e3Z5W6/N0IjgdTwMGMeBbXdj07nXKahACvxQxEipjWP6VoA5cZizQ43agg+7uNUJ1t+4GXLHpPhvaLYe0I7bAoopYiUNRr26MSxi0mgbQawS2KKwp2U2rtVLIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkGvxq/gX0ADfEmcrL21RDEn5aFdEDxgp/aesXs5zlo=;
 b=dbVvEd0kjy6FqpZ5QF4O1Am42vCyWMU5bzyOKhaJlV6vVT8Bzs+klffB2NxgIGFV6YRx12ibsTOXJlAvXlWjgYBb8Kjt7rQC6/QONhUFCQScRji22h3VwKL73y2+aBvlB/6BCLWJBsPqWFcrD+OzPffVHagzbyjhpoBVp6mKOqSvTNxxyvGkOnJED1lUcMGZCvzPorRjGuEuAXzZC/mNHVVUhBu9U1y8Lu8+Ss653/Xw+IaTSdNCbkBsCPl0a3rzaAE32X+r19E1ppgnwWmpD5yiKTLQObmMkYr9n97R2JVStcz2MRCpfx7A42t02Atc+tk9g7CbRzw+BUpENIBNlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkGvxq/gX0ADfEmcrL21RDEn5aFdEDxgp/aesXs5zlo=;
 b=V92lb2/iq1vrbUMMHByKS+lCLR15kZDit2C3+WrtFCI/Xprv+aDT67wzsr5gMwkz7MV0jBesCUcTxGEqOyaCs24ooElyyDUPA43MFcej4Ll2va9nZAjpJZYB249gRwY3xUjQtEoeZzKexjeKuiDlgMFpmpH445Iju/SLc0iiRa0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3580.namprd12.prod.outlook.com (2603:10b6:5:11e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23; Thu, 22 Oct 2020 02:50:45 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 02:50:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct the cu and rb info for sienna cichlid
Thread-Topic: [PATCH] drm/amdgpu: correct the cu and rb info for sienna cichlid
Thread-Index: AQHWp8sEBaOwuLRgCE+uYvg4LF8BGqmi7JTw
Date: Thu, 22 Oct 2020 02:50:45 +0000
Message-ID: <DM6PR12MB40756F1CFA0DA6CF564D9EA0FC1D0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201021165524.888802-1-likun.gao@amd.com>
In-Reply-To: <20201021165524.888802-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-22T02:50:42Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1543e825-ea8d-4c68-8c8d-0000878b17d6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-22T02:50:36Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 05feae6f-aff8-4f57-83e6-0000953efc7b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-22T02:50:43Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 56d22e68-3cec-4e39-9e13-000041385915
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be6a2b2a-4dc5-4bef-d53e-08d876354633
x-ms-traffictypediagnostic: DM6PR12MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35802607BA921A8284EF1970FC1D0@DM6PR12MB3580.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0U0J8YHwHlRKnhFjRjoWVCiiQoEs9qDrD5fD5iuHruq2Eh5l23lsA2f35PL6fy2BJDxmxFYeZg4bPPtTCmEZ/TTyhQVN/2TQ9ae7nqYMEJxxAHk2AhynBFSHG8nyFBnmZZYC/uDeKsEwr1fshJ1W9vbDgu+QCk2sdQOH9KSf+d+gxakPJzQTcq1etJrlT8t6yFct+M8JpUZUIjc8R1cOWR1xfJ9kdExMdMxfcSRx3yii8gKLb3CUE9AGndLn/S8K3Bp2rhrTEoJlpApqEt9qEzW+7OTwbqQSQt/+rT1/oFdSEwzUDhV5AM/0BETGzjQRLpQKClZ7APg0QQxmCTHt/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(6506007)(55016002)(76116006)(7696005)(316002)(110136005)(86362001)(186003)(8676002)(33656002)(26005)(53546011)(9686003)(2906002)(52536014)(478600001)(71200400001)(83380400001)(66556008)(5660300002)(64756008)(66446008)(66476007)(66946007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ei79ziWPddaoleAveKhngP81tVWL7SQhV7Ue8AQhvQ6Iubv8eN8qb/P3LHkHslXiHmrc9gmiPm+u4AlvMj0GU0yN+pUlvL/Pozou1xmjs4I3u4eXx0fpNG0VR3D2rphayW3Y5SXMhCRRlX7qvPORUFu+JZviUrkIFCtq/pN5+gNo7XlBCfQvZgS38r8kSxo5C9sOhSXzqTO3HN0/gSjC4zi1oJaGLluPQeIj8OgC5upqPSDfjBZqAaUmx+9+tI7pT+8GC1fcJyFLDR0Xx/wA1fwIsrRXSBjaIIJrjloVevx8lbKFIFcpRL+MsO+IB+9yzqE7VMiyFpeT99ip2sFavcGv16G5K6+8NQFdlI+LbSXjQKKalp87LVu9Gr/2MaZ8nXUHOs1wSYw+JxdOi+Ad/6+O+YNExoPoN25QawFzGwuZZ9X6QZ8Z2i9RKHeVV3ofhrkPHMS6Yy9DyOks2jJK03t6zHz959ymHIELlWPhknwLywiVYJL++mmgS9ZKYXWnIOM6HKRCtFofuHi0n2ILUXMze6u7k945E/kGhIEq6eIx/E7uvUrtltYKBFWa2hJx1dFOS7P90eCpnNZlTYG/xSwzutNn10/gLAmHX5Q87SPGt4jQaZdV8PSVta4wsvu1W9PERXGCE10Ww7BVVwlMdg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6a2b2a-4dc5-4bef-d53e-08d876354633
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 02:50:45.5558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfKm2fvKOCH6Y1q9J6r7AK129cq7i7DC7ObhcrpLyH53PsU8aS7lfv9oWvWfrXrsq1nZTyCfdmH4hrmJ5ZjzIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3580
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Thursday, October 22, 2020 00:55
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: correct the cu and rb info for sienna cichlid

From: Likun Gao <Likun.Gao@amd.com>

Skip disabled sa to correct the cu_info and active_rbs for sienna cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I271682e11f3472cb5ba882e04329976059e06a13
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 402fe623c5d8..49ce4aaa2bac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4579,12 +4579,17 @@ static void gfx_v10_0_setup_rb(struct amdgpu_device *adev)
 	int i, j;
 	u32 data;
 	u32 active_rbs = 0;
+	u32 bitmap;
 	u32 rb_bitmap_width_per_sh = adev->gfx.config.max_backends_per_se /
 					adev->gfx.config.max_sh_per_se;
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
+			bitmap = i * adev->gfx.config.max_sh_per_se + j;
+			if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+			    ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
+				continue;
 			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
 			data = gfx_v10_0_get_rb_active_bitmap(adev);
 			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) * @@ -8829,6 +8834,10 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
+			bitmap = i * adev->gfx.config.max_sh_per_se + j;
+			if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+			    ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
+				continue;
 			mask = 1;
 			ao_bitmap = 0;
 			counter = 0;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84BEC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 11:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F21206BE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 11:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sTRr0Zxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F21206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128E96E1F9;
	Mon, 24 Aug 2020 11:09:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 551806E1F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 11:09:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exY1phz6PwCvgLYBWZY9U+jnj3YgTtXoLM2CKrjlQqY0XGv6EAWCiGk75jVK3jowwX96au+/ZmDJlohAssTtsZFhMUP70dNdiGxoWWo/OfOVNt8Ae7CzYPvl6GI4guP8R8/RCmmbzCcNmDigV5UYdRPEGM3EyMRnu4Q9iZ9ue0N0m/rnGokcaDF3707dk1IFbr1cHHxDzmiDy8nZdX1aCpoa02tOousSYWM/zDmmYKMhDto0tOrNLrjxJRhjX+4LNsFpyXh9NI6b8syH2uQuMJKuprUUTvQLR1iACDf4LfntIH+8pY3GHIX4UUwTm08EfuaPgqz4WYvdzHnw6TqGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFxLroH5ygTHJI3SQZCgH+voW6F5ZOT7DAakZFfmwDk=;
 b=hw+/dIGnmo53BXBCa5tTAMEnlA3dCzWnlXDj2mvsheW4u+coKDyIRq7Iod0z50R9L90JbnLIqbeAdtwIWByoODMTbKRSAjZXDIJ9OUR3YvTd6Gz3psbNwXjeUGDkGsW0c/VXnyG0Vx1rapTLr6PVpX93zDXnIdxE3W5gpJEzBYO7xfm3I3R156K3ESNfVQxHuASTiWTQkK8DJ7YwMHv+NygW/sWx3ZKHUHeTA+0xigLyiBlgRYNTcRBOi5mYqLC2wicgl/CPdRn2XjmCtinE0JrwAyBI3XS4ocVCXgvC4xLXpYJgSj0Ww4dZl2+9xk3eIy7a6E+1o3okV0auHB4olA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFxLroH5ygTHJI3SQZCgH+voW6F5ZOT7DAakZFfmwDk=;
 b=sTRr0ZxunPlA70UUQXd2gDHbQBdzGGEm1J7gk35rQ7gjHtagnIJ2ekBvGfdpVSKGDVtJBrS+Mwif5wt7EOaKEfRltiV0ZPgAVcIWddDJ+9CZE1SXeHrzlAu3GnrB/VUu6qZuZniAfDAgCvB4Lylny0kI1XAD9T7x6EBbhCesK8k=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Mon, 24 Aug 2020 11:09:46 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 11:09:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx10: refine mgcg setting
Thread-Topic: [PATCH] drm/amdgpu/gfx10: refine mgcg setting
Thread-Index: AQHWegWb2163jLeO9UuwbYuy/aCeK6lHGfPw
Date: Mon, 24 Aug 2020 11:09:46 +0000
Message-ID: <DM6PR12MB40759F0D5F1EFF65E44830FEFC560@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200824105859.4217-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200824105859.4217-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-24T11:09:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c52545de-b346-480b-85da-000092b9df97;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-24T11:09:36Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3d7fcdfa-00e8-4533-b8ab-000071c68325
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-24T11:09:44Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 3146c2ce-2ea4-4729-b6a4-00007d2c45a8
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce346151-cfa7-4943-ea01-08d8481e3607
x-ms-traffictypediagnostic: DM5PR12MB1355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13555287E6873DBF2AADF0A0FC560@DM5PR12MB1355.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 566K8VcGPUfWsuCB4VuC9lXypDybWE5FFhjwltka0aQYgR7o2gnolOuCdI+Sp3WjQGH/e2jpYfbtSsPyXaYU0gQ1A6YuvmAT12MsqdRCbB62NNq63tAgnep8rtXEXfDusFMf9Lauz48ZLP1Ji3r+WtQ4lpcqLf3L7lfZfXVZMb1DCR2Ck+FfjnmLZfqf+uAjA7uNaI9VJEcuzjSe4/y3jwSz1h2HIPJiYuXe3eLMX1l0T68M7oXwDG4/N/Z3Bi76WsokCfkxjYOkOPE7qsNYSGJAkhKLIjmiEsly1w6AaZ6a6g6/AEJdAw+nAZ1w/MMr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(66476007)(316002)(7696005)(8936002)(71200400001)(5660300002)(53546011)(52536014)(66946007)(66556008)(76116006)(26005)(6506007)(83380400001)(186003)(66446008)(478600001)(2906002)(64756008)(33656002)(9686003)(8676002)(4326008)(55016002)(86362001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: i/5GY4A2VDO7Ia2TC5uqFlwvgxXSd2js2FqyTZS9TOvx3LAOfp2go1OBx5ESTJ5AsZhYInHUYHWdfnBHEmMzo4ov/cGYpG3QUFCxoMLu0rkAcH21v69EuTO30cKJox4QSRGGbp5EHEX+MIfiqqTzeaR2GECVE7brMm87Bwj+M3zdnzb27P0EkrkLNuq6uGOke/WS9VlFMXeLoYa1gMETjO82peWW14Xp55qL77Ubg4eOrC7RCMRUotfP7rkWoumYY1+A6jlCvLCitnAlVHsrRDqhMP3WJHGBr3n4hAVOTGhG9aWFiLPjx6/BlAjt2Kn+HWJ4QazHXCgzg12SHWPvJg7hR8T0x5rrBtpdqRLzsrD0EJAJUbzziUQMivA9E0yZv/1IUH+jAdTTbhCUW+QbHS+loAxzZ8/e4e6z3rvVMndWr72ErJXDPnK6BC05BgqaZTdubynNqPzVj2eAYfoVO4wb74Vrq/4+JIP551NxvW9XBLkDNaAs/uRAcCl58OGexTg93ACoC9AUpN3YmJ2JDC7zJXgyHxThwHYy+Td9yD7wGB8lxU5lbovJVrMjvPdxUgv/Y0t9CtkAYYaQMhtjmyuhZKakZ5w+sjpjcKwRnSMK633t0FsOYSinkxOhD4MdOKQrMFkWwTo6u2yUP5spMQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce346151-cfa7-4943-ea01-08d8481e3607
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 11:09:46.5243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzDijlInxm2JgYZhktoXAQF6NYxqxm+tivjAx2k+betD0Ch6PObLAY+ziM5DD7CVJvvjSKSOI4yXcBSG6SU2yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Monday, August 24, 2020 18:59
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: refine mgcg setting

1. enable ENABLE_CGTS_LEGACY to fix specviewperf11 random hang.
2. remove obsolete RLC_CGTT_SCLK_OVERRIDE workaround.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Id52d45ba48159c5e1c9ecf658c5b52f7fc72eb65
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d851fe80eaf4..2db195ec8d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7285,10 +7285,8 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK |
-			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK);
-
-		/* only for Vega10 & Raven1 */
-		data |= RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK;
+			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK |
+			  RLC_CGTT_MGCG_OVERRIDE__ENABLE_CGTS_LEGACY_MASK);
 
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

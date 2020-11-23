Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F3C5519F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 02:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0512076B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 02:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bmV/C+0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0512076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7B689817;
	Mon, 23 Nov 2020 02:35:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9492289817
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 02:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEHhusflWo1SfXmcD4csOlBwjx5XTpUER6fNerSAOi6Ra0nmQi+U7iVEhUQAkQFezzkMPPToQ7EtQV1I1oSBMNGn7vnGkmNLiHCXfPYEjfZVy8zBeCAjDs8llkSUnDTZWB1AkeortWN8lBrn+8SmfNTjmVt6dnzQwymyviSIAXrSofbfYiCD/n9FrMZNYmjGt263Vok1MfAcyPa0FOo7iLxcYbY3ka4WPNxbiE2OdFGmWmY3LqjI0zRZ94fzQbbmoHcpvlGO0szoZE32IkZA1z4JtcgR6kXSu6XkUW1/Asth9PQGZbATR/DUrZOLU1P+JprAhFMVglIHbk9Xe5RuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bO8mgptiDfh2wk9Tvekq2jY8ufRr8HcZZNAY35V7Oc=;
 b=V2yQ4iCZXyRB7sSgg4BQLXfXiUNtciOWOEeryyCPPncD2GHi76Fq2WSSiuNPLfUcl854k3DrFeNo2D8BW4fYJ48JaZehLG7oDAuN6+IdBLpyhkStiCwamo76Vjjn8+davWUTaUlbpu/li078iSPo5wm8dQCCbLjgOPOU+8MquJ3TNrj4gs6RWysyX1gsdj4UtyZMKBKaBiQ9bUHaqeGQvwlKkfz+zry5AVgilDCB+af3R9EaoUytr35wNoukr+kQRZlKLqqI4LpboRX7Gk9dnEPF/T7GuuOOzIL9Zcy6z9GVvLX086Iv2gOuq4h5Q3Q3Mj1e4DWX4QvT+xGFCMjcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bO8mgptiDfh2wk9Tvekq2jY8ufRr8HcZZNAY35V7Oc=;
 b=bmV/C+0f8P8puV9EhLwEcaEQa2viDllEs1WA192uJx6D/tC2DGaHePyGgAmWkzDmEUqv6Fqyms6smBW39P7jfF5kPBt53YMz1oFCRjLw4CQ5PL1I6PmEbxPWOwZgZt0e8hFxS9uUfv7t3oue31GePFWaOgzb141mrqh2RxoSBEc=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3769.namprd12.prod.outlook.com (2603:10b6:5:14a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.22; Mon, 23 Nov 2020 02:35:17 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%7]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 02:35:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Thread-Topic: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Thread-Index: AQHWwUDei1pzdKGYCUm6rEAFrgr5ManU/9gg
Date: Mon, 23 Nov 2020 02:35:17 +0000
Message-ID: <DM6PR12MB4075CDF06A3F1F44C4E35084FCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201123023202.120670-1-likun.gao@amd.com>
In-Reply-To: <20201123023202.120670-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-23T02:35:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=626f8ca2-8a77-4b20-8091-00000293a444;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-23T02:35:04Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9faf6e80-87a8-4beb-90af-00007047adee
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-23T02:35:14Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d722ba96-697e-43ae-925e-0000fbb9fd19
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08ce1154-fdbf-4e46-de1c-08d88f586a50
x-ms-traffictypediagnostic: DM6PR12MB3769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37694F6DF2C6E56887D4A366FCFC0@DM6PR12MB3769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQPSqnmDd2kpD+0SGV5HhrUUwkVf+XohLs0Tb/SnS6Dy1R1DBclImm7UxUoGux7aFIcJxJr8zw10OPEOmjSrpberSQ5yY7DiFZIEvzQ0dMab9c2FIxllROeyCtnYLxTqWJcNCjSwkU28l36EppnccMlQLvJxGBPujD3WicEbDosHvzTawU4euqLfLT029sFarrQ5WZy7/0FEu7FvtZPkS9cK1gYJZYjs+ZMZdR3iQwxqS4jnvVzxYho7oqHKbUP/XRv9c97F4TyrS58kk7KeHIb+7BhWbIFF0/gMs7E7muLVVTHgmRLMxlOehsjpL+WHTxhd1dAMavblKcyJ9AL98A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(8936002)(2906002)(53546011)(71200400001)(6506007)(5660300002)(8676002)(66446008)(66476007)(7696005)(86362001)(66556008)(64756008)(66946007)(76116006)(52536014)(186003)(55016002)(316002)(110136005)(33656002)(26005)(15650500001)(83380400001)(478600001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RWCexEiAW69C3zoX50lybp2buGHHOzi85+wLukN5X6dZEtr57ng1M2VPzND0VVodpsIj4YRObwcWpi1sN+sTqNSPYRqvnwvJ3gId521bG5mbCyg6juAtPQ+rKpOg8UStAtUjosy5ES4db+1g32g6FJpfuGFuYWvJ6GtPcZrxyw4ScT8VF4zbh1ybnxVJ5vG5b8dbjGPX1X4KNTugwuNwZRoI7vov2rGQ3o3Ro7Zt9ix5NCJl+ivsCrBU5x/Xig9++CXvP3QqEIAjezIc9afgqqF/O1GT2ChWHZauu4gji+pjpVTaqyNm2A6cVBFviX1Psj2e+cQgQuWwBj+sgyZ7sK9wJp+JsewMfL3Er/WDtZH2SaZevZV2/67wGthvjmrD4H5pgSbxztVrrE8uZkczudyAILyYDhCYIihZhXFuPRe8TP36PnJez3MUqbJ79qgYbXr63DyRp+O8EXuNSio2lTxvIwRMK9vQUNvbXOuQ1onCFM+daPKF2yxTyxbJjjxbv2ogXF8wP14cwSqD3N1y5Sb7kUiW+H4ZEY9iXsvdeTRptCoKZ3D/Ds2hba4ACL3vAVowQUoQhqSeXuVDqQhI4oxcCjjexBQg/yuZrKlMK4kOuanFAv+lhzpqf+QSKUC1BCjqGrtw7Cc3fpXlxWHYIO2bFfTp0zbvOSlAOFHQ4lkxlyiaAGELTM+PM1VH1RO+iLZLlGJuOCurNJrASXw4xo9Jqw7C1j4R7LfFBgqiBUAy2e7rnlhXMF3G1biwSd4Lx/NnHhcPGQ6kUGZFpzZFweg8MndZ1w2Mgn2jmvsdpHkbU5wA1h319wHDHG2oJdsYaG5mUIumxUDWgi5pD7Fhwym7iPiDPOh4x4M06plV145AjPtSx2JYQxTJjkfItCBbis5zcJu1+tz5emYxniz7Aw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ce1154-fdbf-4e46-de1c-08d88f586a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 02:35:17.5567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqhTQInU2+NpCyY0UftV952x0UrOkDrYTxprk1fYdedA/HdRlADFFlhuB9ChcVdrRsBdkJ0dHoshpGz/OEWaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3769
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
Sent: Monday, November 23, 2020 10:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I2f107ced1540c9ec145950cf8b58664c6127756d
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a6d03931f7fa..2bd6e40d5833 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3148,6 +3148,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0 ,mmGCEA_SDP_TAG_RESERVE0, 0xffffffff, 0x10100100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCEA_SDP_TAG_RESERVE1, 0xffffffff, 0x17000088),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xff000000, 0xff008080),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCVM_L2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xff000000, 0xff008080),
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4120C352A3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 16:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AB420661
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 16:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C1hksI+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AB420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563496E9C4;
	Mon, 10 Feb 2020 16:51:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0DBF6E9C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 16:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cndcVEu6U9SFqEYFDmjqFBTHeczU2eKFY8g3QRN9ZkzdmyF/0/n5E6AECF5R+cqPZu0O3vSK7mppAAKr5ePy+6YCXiYwL4C+hth+kFLjkU+Jsj9GQttg9bqFrzSigjGFQsxxSp3s9tO1VUq/x+Fo7pc1SLVSxYX5ouKKE5crL4rgieb14NIB96fJyRQUuE6WxYIJaYkAIxf2vLuHFFVbR+PQke04jKsZSiq684SgvP86Q2Z3z1WqnIc2lRQWwdwwwd3j32cXPVPG+ssLgK0XO2qveqOgePShbfVDTG/0aL3zS1btIBn7eVoeTiaEXoBvzz85hp4HyoAZs3zq17+piQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtUF3KmeUpqdIT9cnVxkRL54uVn3MLmkGhXxFM28G8Q=;
 b=etWowH4eJIPsa/Gtwyc+QmRWm8FmDyvkH1VOeCNrsdkRP+sUj65r+aon+yAfrf8H5AlMSk/ZRMGl/Xyy+UY+9ukod2WdO9eokGc1ZujRv9HTbslzrk+L1K8RAF6A0TZm99jWXYDGyOzdayRZFcf0qMY7ksumfe63cISrvWgsv7f17SJ6bbXGE4L3JXbCED2KWUndV57ly8sam5vsEVQerf/D0atwGzlFVSFT+myYVH26gms1FeqgS6vUsCOWaEUNNiuMplVYw4AR8l7XIJK1bIjO1e9zaAWBjJ9mnjcnqhQTFedJzipHgLwm4UbIG5HRVaBhtcc105aSNqw1dehJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtUF3KmeUpqdIT9cnVxkRL54uVn3MLmkGhXxFM28G8Q=;
 b=C1hksI+wHaO/kRmyOiYRbHtee36JTZnOYUwRAV3mM8YXOiTOC3Gjr+fmGTOVF4isugFw4Uf2hfJ/edGlsUCc6Wpd8fV7J29SZ8HcZLniBqcJ1QJIwL4ob+soKc0mOakudl80BODV2gD4ZBd0tl4t7HPZBNC7j93ApPBo9J/Iuko=
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3081.namprd12.prod.outlook.com (20.178.198.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Mon, 10 Feb 2020 16:51:47 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 16:51:47 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable VCN2.5 DPG mode for Arcturus
Thread-Topic: [PATCH] drm/amdgpu: enable VCN2.5 DPG mode for Arcturus
Thread-Index: AQHV4CfDGFrGZGwcSEOMmU44oA579qgUpFQQ
Date: Mon, 10 Feb 2020 16:51:47 +0000
Message-ID: <DM6PR12MB3914DD17C099D3AF09612AF0E5190@DM6PR12MB3914.namprd12.prod.outlook.com>
References: <1581348930-25085-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1581348930-25085-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10f263e0-7d0c-4bc2-e035-08d7ae498466
x-ms-traffictypediagnostic: DM6PR12MB3081:|DM6PR12MB3081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30812E9BB8DE98BFFEB12E76E5190@DM6PR12MB3081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(966005)(478600001)(316002)(45080400002)(4326008)(110136005)(55016002)(9686003)(7696005)(8676002)(81156014)(81166006)(8936002)(2906002)(76116006)(52536014)(26005)(5660300002)(33656002)(64756008)(66476007)(66556008)(66946007)(66446008)(86362001)(71200400001)(53546011)(6506007)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3081;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VWqB4NpJkg1iWRnLb7lWl4Cf/5bopDr2n+ifUoyQNERYcmvnwlxtMPv2kiQQn8/k3kVROcTMf3eGgAhk97cTAOHPN4cpeFe3uRcwsquSVSLO7SXcPdYvDqjBr7OV8ayTgJ92idpJTPn9yopEKhK4jA/aSkXrRVR3GYmCAzSz+E2BR9Ow3/zm2WrLO8++h90bvwCNGTMG/+EJmM6QfUmpA7AnHu8aALvc2r0RW53P2uG3RJ9dkYKnOhctiKGvownjzsRUjz16Gl6u7WIMQERFlan14zDdNOx/Z79ooSbeQWnP3r4PF8xApHCY3AmkzKOtMWe3wS8QldXx1Qb65bbKUhHbWIsHkrL1uNbsPzf2SqQfu/OZ58+gWMWGsHx0b2U9gcgt4uRpdm/Or7zeAH3LsNecaaO828IKehBk8JDsUoEmmHNZb6kv634yFAhw4aAcsJrKfuKxfWmV2vrCtEIhis362eCXM4JogdWowO7EbU2M0jevWatChCDU18n+U674rNu9YifJgz1L7q4OdzcIMQ==
x-ms-exchange-antispam-messagedata: rtUFPu5e6neXycEoCyTlE1jw9M0jOYaD/MKXq1Kopbm2zgSuHTpgxrWmMrYwHwJnHfk5um2vNMeF1hXet6n3ONwPW0DIuCsg+0zOr4iTddhhgbatqzwd09fjFia5EjByXKbeBtSwbjgufYK2PwmE8A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f263e0-7d0c-4bc2-e035-08d7ae498466
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 16:51:47.2735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggFqBuOZwSFhnWUhe7oVGl58WugoGzFcU0FUTe97JYpM88CL8w0CyMFsxQJ+Zpt4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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
Cc: "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of James Zhu
Sent: Monday, February 10, 2020 10:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, James <James.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: enable VCN2.5 DPG mode for Arcturus

Enable VCN2.5 DPG mode for arcturus after below items are applied.
ASD: 0x21000023
SOS: 0x17003B
VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revision: 16
VBIOS: 23

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 15f3424..4cecd59 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1186,7 +1186,7 @@ static int soc15_common_early_init(void *handle)
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
-		adev->pg_flags = 0;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN | AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x32;
 		break;
 	case CHIP_RENOIR:
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7Ca8fa7ece0c9c41f7ef8808d7ae3ee3ef%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637169457470191990&amp;sdata=wD1hx5o1GgrsQMEXwnn%2FJHcpDIrTpVBAFzj1qk2730c%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

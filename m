Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE3CC4363D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 04:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167D82084C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 04:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QUdHeGIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167D82084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5642D6E12C;
	Wed, 23 Sep 2020 04:29:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85CA96E12C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 04:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGkBKy9+JSdY2qIFv0nkEoDvIs9GQ1dvPiXn8K9VYahHrBz5AC7qjvZS8/hsFWDKjLqUDGrlSOWv9By3nLLnQbPvwU/+ZMiVSjDT3OG6n3aI/+yTW5RytfR6ALxXOfmM85FMPTVs3r1bkAIwOy0eroIjbdTOVYnYNY5nr31F30LTuqS3eA0MUb5r7Nz0pe5vnHrCh7VJjKAjs+gpPY09AtMjRYcnHDW43Kcijz7WQfcOf/FGfwydRRQb99Ck5CX7MLv4UijifJHsJI1Z4W7qrgE7m8q3ectL/bNIUALlow8SzhXB0z2krYnV+kAfNXPTK6VAizwOGlvTdj/OlWRYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snvKnOZiHjLfSyvmBDby74NPife8IUDSG/7CEHqHJtk=;
 b=LEsRYT15XwKQiw/G4+s5ZGMKC/E+ZletpLQHtZ4FsYZRtiyviYhYaL7U6WUqk1ACqaeMIV+KuQNbF2tFZ7Epgt/7hD1PoKotQ84cLXrHXAae40GJn8XX8a6KDuWIL8S0tEJtPGUzgKwwD395Y+A6+HqohWhaGB140cTE/dkiifyxHnJFfLW4HJzEbsb6JY7Px9Ls3JPu2Hy+or9SWCkHEszCoUGdaTTxA/U7VJkw0tWW5V9fuE1UBCarGkcpprfo8WK7rQcWfdmc+li/5ah3aK3Wy6mRkXY3mEVIyE7urum1vkBUubYfiNj35AB4VJ3CbXIB9eclYumSqeNGsvzfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snvKnOZiHjLfSyvmBDby74NPife8IUDSG/7CEHqHJtk=;
 b=QUdHeGIUiosaSh8EEV1IDBWKDrEGBna2FOCYNJMJzRyfdnoffMCyUxxgcv9DJU5sp3Htw8Oq+ZcMNJbG3/G/7A5rJszoh22SnC6elxLDdTU5jCWOuI6BdjmcMGLIhSsXOy+TYyAY4mSJ4eyTq+Aw25NPpO9WmZOQpoCP+hdyAHA=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 04:28:04 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::4956:743a:1fbe:e0d1]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::4956:743a:1fbe:e0d1%11]) with mapi id 15.20.3412.020; Wed, 23 Sep
 2020 04:28:04 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove gpu_info fw support for sienna_cichlid
 etc.
Thread-Topic: [PATCH] drm/amdgpu: remove gpu_info fw support for
 sienna_cichlid etc.
Thread-Index: AQHWkV+a83lWschUTUiFHkQZlavNxql1oNeA
Date: Wed, 23 Sep 2020 04:28:04 +0000
Message-ID: <MWHPR12MB18540415BBE69EF60E03604FEF380@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20200923041107.53799-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200923041107.53799-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-23T04:27:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3c65e7ca-801c-4320-8c13-0000404fbaec;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-23T04:27:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2813a917-b4dd-4974-b73e-00007c13d59d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-23T04:28:01Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 64f983ce-add9-43bc-8ca3-000007631a2a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ad5f836-2692-43f3-aaa0-08d85f791085
x-ms-traffictypediagnostic: MWHPR12MB1854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB18541EBBFF226DE3CAF46CF7EF380@MWHPR12MB1854.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MuMO4nt9+ZFE2dLjIMmbnZ2dSAh9iOh/m+hVdwpzkgxV1SsUT+ZiI5dNkZEpXDDBEEfST55qRk4dxqIbZPthg1Po6JzdsciQglo8VEdUX1DITNYtSozpG/q/V1OiY2Nte5u0TI1QwOMd8J9jmMRltNOyG740ewcm6elTbwgdyHs36VQ52GhZdVwTL85E7qMtS4Nfn8o5p7+ybO+zcU7GGxTvGFLRPhLdSxEN94cMEaFjETduBo1qZEFM/Scp4EqX3Tv2w2Ml3lw7e5UlHPTCSwGqW5C2bKkz3DI9MelKtFYInUA0x7CYaP2BA/rw0m2eoAMoGdXN4ipqAdO8uwOdsruu/iOfcVf2ReRMEZL3fo4c/Z79NTN0zSRfVQgFzhw3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(4326008)(54906003)(9686003)(26005)(6506007)(53546011)(86362001)(7696005)(83380400001)(478600001)(186003)(66446008)(66556008)(66476007)(52536014)(316002)(110136005)(66946007)(71200400001)(5660300002)(76116006)(2906002)(55016002)(8676002)(33656002)(64756008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: FNu8j+BRsZ7062Es1ZkglJsWjeOHjtTZTFmWtyLBn1bKtfn5itMhVcCk/rOunFAyNWj3w+cVAVaoTIpXf44ZPnYlmKF1ZtwUpbchY5wdsI2eGrX19t9kWSMR1NiK3CCWqkY+bjQE4EqAtTPAapV5t6bz7LP6V9kqg0lGN7o1XZeMjmlZFFBfONdhs8anXfEsxwXPATY2EXxNmOya5eT7pYsI4x9hhqzImMy4545hvm6ed6u/LVhcKVJPW5flm+LRmqQvQQdAZU+apwDoNX9Hi27DMl3Damwjrfa71umRigQdw7E95en2PEaDrk83cImEBBeqd8A/qsIFuU8EX+iJ5xTVBO09NbbCR5bOv/IJvr0bLbp+CTL1cw0iuBPm9KweGSHa72a3OCadUr40z83SBmJEpQk3sxM7ZCHFbNcpY7HrTleogUL4/440yFM0LaaXn3clfzdp6DfARPML7IgA3OQ5mts6JEzmX1lwj18+dmoa+9fiYX79kJRkDoIa4E8stFadhrcrFQ/PW41DKn5ltWhzuuUV+waj3CLo6OK1wazZqN3B9dCfl9obG6IXa07inrZ8ERIv5CTjfSU270xhC+AG7o8nWE27GghvSWcOBBtiWF5vOJJDYvTaGqwr9Rvh7jk33LzqkoLR3Nrd8BafrQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad5f836-2692-43f3-aaa0-08d85f791085
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 04:28:04.4172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElfhrIUCvMynZMA+RfrsXj/fnU4kidGoWtjrGNZwhvPaQsZLnj6aMSiPK3Z0gOFV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1854
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Patch is Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Wednesday, September 23, 2020 12:11 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: remove gpu_info fw support for sienna_cichlid etc.

Remove gpu_info fw support for sienna_cichlid etc., since the information can be retrieved from discovery binary.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I4cb42aae5d680f28209122bb37962a2291ef785f
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c2eb46e9b71..a174431268b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -80,8 +80,6 @@ MODULE_FIRMWARE("amdgpu/renoir_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/sienna_cichlid_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/navy_flounder_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 
@@ -1669,6 +1667,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
 	case CHIP_VEGA20:
+	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 	default:
 		return 0;
 	case CHIP_VEGA10:
@@ -1700,12 +1700,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		chip_name = "navi12";
 		break;
-	case CHIP_SIENNA_CICHLID:
-		chip_name = "sienna_cichlid";
-		break;
-	case CHIP_NAVY_FLOUNDER:
-		chip_name = "navy_flounder";
-		break;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

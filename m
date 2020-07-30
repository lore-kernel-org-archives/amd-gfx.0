Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91F5C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 10:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDCB72070B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 10:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aIW4AcbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCB72070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D176E1B1;
	Thu, 30 Jul 2020 10:36:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B646E1A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 10:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsZVQP9TzJpMm4ZWF78UuArQicBNw6rHxB9DKmgwMZlowo4PYbhNJ3lkggYmldyzO/y82XiOC8Kk0JqPu6wvNcEByoKfS4/OOT7lKekzHouM7dOF9X9YaXTNRhedHk1UCKmgdyU/fH8S81SIDKcmDiP1WrE8Dd5vgcQRW1LIQl8u7uufBsHErPTPCD+DkIDRsryuKlIJbrBeX21WuJ6bI5Y0v+V2fmiXONk/a/ZrTlg06GnTv2IFUTeE+1U/jjSxaGqxJvDYNQBHpLkiBQSL7O1I5Gjv1fMZLOMKihNtNriYrPNBcGopFrlGJm3kx37Xcd58KgQn+wIYrGKP0cGlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir/TOrePhaTv8Lbm4mGU56tZO7lHqxKMPsYbBIfwLKE=;
 b=RQ2HPpaq5E+S19AZk6xCKH5aX5ESqdoTMNP2woisT/OoOHErfQ3N7XQsCub4S5BncnkM+kxVc655yN+1CAx96K7XcnOm7MDggCdr9xUuzQsJ2OcYFjxEu/ssbyWxfiKtkYP2ACjxQhvpaE0MEDPWbHJ5yLb0pNix8r/NvvVkxwBsKOpKyc16DZfGPsbRQHQYlbMCV+8dUgRIfhQ+JNo/bcYLVs6gpbZUC6t2JFd5+7qA0SKzBJH3VPsoTN1yqmOgWlC1Us5Wqp46dcDCVqDLX0bANoavAWvbQzcMO6joTv78KCmZdRu4bJjL/4I+/BhQYmtMSmKK4Npcf1B72z9x8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir/TOrePhaTv8Lbm4mGU56tZO7lHqxKMPsYbBIfwLKE=;
 b=aIW4AcbM7CxzbxTRsSnbhu21t1TYaeP+uOj+Mz88zAShBV2aU8Ks3c2n2Tc4NxOGrMUx60CSoXip9CZOVP7ovrzCylyD0ZiHbUPUGUKYoLQ+Y5eqxrEg9zC1RtNV+JTal5tOikgp52SkT7bcBm77oYbqv6cDAXQ12f1J39tYf0Q=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW2PR12MB2393.namprd12.prod.outlook.com (2603:10b6:907:11::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 30 Jul
 2020 10:36:11 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::c83a:4059:70c4:3911]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::c83a:4059:70c4:3911%9]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 10:36:11 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable GFXOFF for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: enable GFXOFF for navy_flounder
Thread-Index: AQHWZlonv1oLrFUfEkyuDjZ8Z8Ijsqkf7PIQ
Date: Thu, 30 Jul 2020 10:36:11 +0000
Message-ID: <MWHPR12MB1854E370C11FE7984685693CEF710@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20200730101345.3424-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200730101345.3424-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-30T10:34:08Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4199db07-d4c4-42d8-862f-00007ffff6f9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-30T10:35:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e7bce033-9452-4752-ad98-00004a51cd9b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86aa86ee-5f44-49f1-b920-08d8347460cb
x-ms-traffictypediagnostic: MW2PR12MB2393:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB239393220C67557E9E02B0CAEF710@MW2PR12MB2393.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5tLj8s3XEc0iRqprXAQLrPrXl+FxZp4LH+hPUqSqLPpyipFd3CIhdKirpghuuOh4YyZl3ImaigA+84O82Z11YvC/9rVjRTKcMc7fKadMTlKD6xeSdtrWs+SwFFetujg1L1X89h7b4evptBsV1V+evfjVu68QSenM+a5z/X2kVvZ6cXO22+Ld2YxRSWRjE0+ijWFant/9Iyr7iY3wwPvr31lRL4rTo6xClNs3k+/aUPig1uf/1IyuGR3YMuJO5Gx0CgDk5pQs3zemnLeawJW9S7iUiyZger0UNK+5PugpGejpKai/0zL02G9R7VsjoWgr+R+22QFjqyP0O7vsSjhbVT1ZddvwRbGmk0ImmwDNung=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(86362001)(4326008)(66556008)(66476007)(64756008)(9686003)(66446008)(76116006)(66946007)(83380400001)(26005)(186003)(55016002)(2906002)(45080400002)(8936002)(316002)(7696005)(966005)(110136005)(53546011)(54906003)(478600001)(71200400001)(8676002)(33656002)(52536014)(5660300002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +kAnvjoWzr3+GR4ZnVAMhEUT+wA4YxBK9Fh/Z68MG6v3DohDdPLjcQ43gBUXx/NQ1Gi+c919MjozVEkjY6U6FSQXZTYeRw0xWtWJmrYu1lS44WAwHWmlTikfPzIcFCCzxqdDy8waXNWyPMEmqefuBd/B4rnGCe6wnuScvsP6e7wxszVQOTc7LYJtIzJ4J6rkd5ggfJTCOjCHqH05PmYXYbhDsQaXNLEEJjCtZQ3tNtJMp1cKUQASPBoXJuV3cG8mKa1S3r6FZ1MFodg0q1H9zqQNS1HBfuZ0JbM9k/BI0X7C/wbBszwCtGQOKXkfUvb23uUgQOqMJ7AEKTFenweBbIONcCLJziRZtkuV6brSr5AfP5nDXiq+0VbZLQ2jnjm4shV9CQRlp6PaM1HlPno5gTdbivzlF0WZJ9BsLUSyW8FoG9oDsB8YHiYyGw8fmrwJ5Xv7jN26+5WWO+hCeahCbPCXaFnqVE4oSkSG0CSiZhrgs/XQFF7qNxPJUTqJMRF8
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86aa86ee-5f44-49f1-b920-08d8347460cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 10:36:11.5690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVHz1yYyNptHEtC/6Cpkhc/33JsJ1/QcwcXQ6rMvWiuLqgdAOc/3PmUNPLRP3FpG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2393
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

[AMD Official Use Only - Internal Distribution Only]

This patch is Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiansong Chen
Sent: Thursday, July 30, 2020 6:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: enable GFXOFF for navy_flounder

Enable GFXOFF for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Ia49c1ad70e3521447b9db101f5c0eae70b1df665
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ca16f01956d3..fe8ccc9be682 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7529,6 +7529,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index a9453ec01619..7d7de854a826 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1029,6 +1029,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CLikun.Gao%40amd.com%7C807a80497ba54f52dfca08d83471477f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637317008444002971&amp;sdata=Ti00sNdv39%2FleSVqkDw1Q1oaBJKoUNw1%2BeQEKSuj7Jk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

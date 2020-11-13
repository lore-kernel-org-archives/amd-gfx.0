Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E7EC4742C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 09:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2072F2145D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 09:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QO06Bxn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2072F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D576E44B;
	Fri, 13 Nov 2020 09:23:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A306E44B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 09:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDvrcSihDuO0MZL8dGYsJWfX/6yaLoD3UYYD/kGRjvB9nCmTUJqIwzaoml5bV+b834wqSFD/1ecXHBh9JlN7Q3HTUMF5ZqgjNjctucRDM0ypdxG91TYJc97J2WgUAZnzlXmB+W2SPvQ3wT7E7L88BS+ZHUwCjRFGDeWgcEmaOblLPdl7dilMGSGNZCW4tCd+a46t7ezqt/FJzGvtHM1ufAL/UTkaZWWmeGqQ84NeHpXzNVo74zudYgoNJuIbKrYpPLx6Qry1DOYS36ou71Xfthzhn+RH3/ZEiW37QoXfs8jhs++GtKcvJl40j5uSWFmzbYM65iLSCD+NTdCnuZjLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWEEGeRJT3MWqo6J13XdgbEQ+mKKdAZAvkCqTKLBDjs=;
 b=O4uO2V4itG4IhUaUBvr639Xc9NL9ihA7IOp7fh6Jy2HHyZtG6kUvIsJiX4U7RnRYra3Qwe72v29N7uRqSBddWEe0L6JkLPFTUe/J2h4jg/kwrkDzNqhB5m9ZECoejmahyHWLbJ+siV1oF5hERJ7uu8pgeapIya1ZIvYjRVEup+D07BaSFLvfyBsopdaZhB9Rh0bOr+wc8lAfFy3pvZLv89gh9JseocZr5JnLIQe50F2aVBv07JKd7wrBab81DbBNzz/D9CHH9tBuRPfS9gvBaDXoOckdieU+ZSBp4nOkppQXTk5mTpF8bhIDwuDpdW8tGT1oLuQOPTUyWi9bUc3jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWEEGeRJT3MWqo6J13XdgbEQ+mKKdAZAvkCqTKLBDjs=;
 b=QO06Bxn2caFkOHDfX4orhC9DFVpfeISiLc31sCtjNOmmFUxURjpiZE8Ad3fmfpLf7CFvGPtw751nmgw3gft61/cMg6I/GFLYXYNeikdNyOm3FmQb1id+4Fse4sBGIs/zQdpgDMrtdSGC2wlLbp8avyJzF6pBohB2thNFiZRsw+Q=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (52.135.43.84) by
 BY5PR12MB4965.namprd12.prod.outlook.com (52.135.43.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.22; Fri, 13 Nov 2020 09:23:16 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 09:23:16 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish
Thread-Topic: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish
Thread-Index: AQHWuZohIEYTC5nYBUKcC7D0+iDn66nFyfKA
Date: Fri, 13 Nov 2020 09:23:16 +0000
Message-ID: <BY5PR12MB4885220C7E95F01CED8F8CAEEAE60@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20201113085052.11234-1-tao.zhou1@amd.com>
In-Reply-To: <20201113085052.11234-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ed0e218c-c306-4f23-a93d-0e85b174a2a0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-13T09:22:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e440fbce-1089-4227-ab66-08d887b5c0f5
x-ms-traffictypediagnostic: BY5PR12MB4965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB496527775E8664C62878037BEAE60@BY5PR12MB4965.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: La1AJc6VNeHEuCpL7xxCPYtNTPmk5zlvKCqGkdFqU4F2Pdl/unFWvhTswmnoZSzoJ8aSyVST9lFFjO0P8RvIzJZbTZmtzXNahGR6ScKNsnfM2zFfE/WkH1bC1tF8ATFFm3LfCWsMykv/DUuOYB4p8qBx+0nBuVC/Jl6ubZ/zHa890N2EsJ7JGWB/HYTbJiFMvXCpe4UjDmtT1ZmK1AI3FsiFMmcGJKwMDpyK4DOXAG3ZOtRXbrUrqEUekyRF0WiGgQ6FUAmVRS3K8QefYxnmlzkEIP253t0zcOg1w0pli294Ohf/FkkKdKJ+YbBFqUY1J9TQy9Gje4PUwM0aD/P/AQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(2906002)(8936002)(15650500001)(186003)(86362001)(26005)(9686003)(6506007)(53546011)(55016002)(83380400001)(33656002)(7696005)(478600001)(5660300002)(8676002)(316002)(52536014)(66446008)(66556008)(110136005)(71200400001)(64756008)(76116006)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: e90M9+oj+PCSsHSQ+0kIvUiMpZuzGJ0I14pAhcPQTZNrw1IurPWzJzl2/c/wI0kdXd4rVfghbt3jnJliz/8waorkanQpkxqC69q0/8N0bqL0eaJGUZVr8EFGO4nL/RTjZd6Q31A8EECbvgQ8Gq7AUdB0hZYEg+sFYFlM8UPyWSMWpHYqSCadW42kkMPhaIWF/vlhNhhJ2kjXE2Z+w/hyA4UEDCm0SzfrN3evCTRXRC2SX8H7q+U8u5kNPemeZ52kN0opn0cSF18Vj/KHN1BB+13JYrwq8XXNX03Ko1ktkDQNwlqHuo15fMYMhcqbX0aB6hcwdG8zOhzFyhHyQZit/bL+taSflnA7VSMwO7IyHa68yTa4LEy38tZ2EJFLev1v+UTAzyE4/0+HYdXcX6CPbXFCCZ3iHH0RNHTCmIdvck1wC0/AoTQGKUWeU60WWh3rg0L2B3GpqeLhNNbAsRER2Mgi6zXTw/cpDF1wgf7f6tfHU4aUiuzsc7Sqax8kTEYUZDoAOaxsvHAWyuHNmCzMQ11gLp/8AS+YZJvF/wXN6GjxXQQgy5s3pCpkLRqbYUkklI4TGjDWlOsJB6gPr2ohxsBRr2gAqt3+oMXisHaOeHC56+hpV6+0q/U3jj3G2CdcsG437iFg/1+wkNy7Sp+Tzw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e440fbce-1089-4227-ab66-08d887b5c0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 09:23:16.8613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJHHeWDHCVdmS9vAZCqqaEFgGnbSc0/2UGqWdCqrFxK/MdNUZYLg7qMcKKiHPBSm247g+TgFFPE1uiF2RS3sWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, November 13, 2020 4:51 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish

Per PMFW 59.13.0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 5ad693312187..41bc919dc9f4 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,7 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3A  #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5  #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02 -#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xB
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xD

 /* MP Apertures */
 #define MP0_Public0x03800000
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

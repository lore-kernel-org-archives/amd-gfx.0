Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D724AC4332B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 06:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E5720722
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 06:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gNB45jhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E5720722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249A96E07D;
	Thu, 19 Mar 2020 06:13:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7EC76E07D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 06:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP6/967I5oFi9tT9tmHuYj01lXxmf4h9kzbeU6B4JUZxKA/gCRmGURTuKZw7fAv2te7RXzWWlzNqn9+7Sk5VBEWsjw1ceqe9KqaTdAos1Fm9VxptyLGxbkYN32n4UCTWz+WuV+iEia2m4TyTM+wrjYn9W/hG/j8ByPalV2/OEZW+TPQvep0BnN6QCzPxWTzH0HXOF27Ri+RDoTvWChxEH51MZoWNzWyprtJ45H5U3Hf+FKA32gs376tfkfXtHhdBeXOmHJ4BU3HhcFHNMu/rqvPLja/g69CeMmF4Eiq/9dotLmY6QM1GxGM3BMvilNA48zG2ggLTHK9Izu68elBGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiWfIwJXOMO3eYmuaWTEjDm3EkayjG8FqI+GuU1fWGQ=;
 b=nACbCBD+DC1igS4YVr8DIvEZtbnGEHmPbQOILD0hvdKH2BnkxZwpdH1a1x5yWmEzfNH8Gh87kRaCleTu3rurGMMAls9TwrEYOaL3f972j7ybKxHajbPoUmYNCY/YewYkNRJyGup2t7iUPKepFlEVU2FUviFGuAgO4htT7K7uCaXFU5ukhA4lxRznt6YO7F5Ue6smLDStXi53jM4+cVrL07shWAVWBka3oNfZ1fc1QSlU18DoINnXaC/OPTRUj0xMM7RPLZ4RsqKGEKMIwTOmQZyqH7erqGZ3gqpB6Rt4xmMTwlw/2H4Ep9Ax3LyvRb/Krkf/71bSBuBnREzWwtYlnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiWfIwJXOMO3eYmuaWTEjDm3EkayjG8FqI+GuU1fWGQ=;
 b=gNB45jhXo9wxY2thgDrRRM3YIA8DvAJ4NG9R9HvmyuVK3FgKYlttRH8ldzePjige5PhDJ8wMi+8gwXpq/CxTlAGTYKIYonWsyKF7PEwuRl3JooSjyUUMWWekLJaZ/maxK6TwfYhz9gJ+dMGeOb7M5V7lThnZa34ipuzMCTfArJc=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2666.namprd12.prod.outlook.com (2603:10b6:5:4d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Thu, 19 Mar 2020 06:13:06 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 06:13:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov : Don't resume RLCG for SRIOV guest
Thread-Topic: [PATCH] drm/amdgpu/sriov : Don't resume RLCG for SRIOV guest
Thread-Index: AQHV/H0GYmplXmPJwUuSONC4VcVDXahO37iAgACSH8A=
Date: Thu, 19 Mar 2020 06:13:06 +0000
Message-ID: <DM6PR12MB4075EF06388D3F3BA25E458DFCF40@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <1584464097-12866-1-git-send-email-shaoyun.liu@amd.com>
 <DM6PR12MB32412071520ABF09642DD44CF4F70@DM6PR12MB3241.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB32412071520ABF09642DD44CF4F70@DM6PR12MB3241.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-18T21:29:46Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b439c43c-ffe1-4619-99ed-00002838ee86;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-19T06:13:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 027f0c49-0856-46ae-880a-0000347eca39
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 610a4157-0b80-408f-f757-08d7cbcc96f0
x-ms-traffictypediagnostic: DM6PR12MB2666:|DM6PR12MB2666:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB26666CAD87957EEE7C57CEBDFCF40@DM6PR12MB2666.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(66556008)(8936002)(76116006)(64756008)(55016002)(498600001)(9686003)(110136005)(33656002)(86362001)(66476007)(66946007)(7696005)(5660300002)(8676002)(71200400001)(66446008)(81166006)(6506007)(81156014)(2906002)(186003)(52536014)(53546011)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2666;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fxGeA+jh29FZ8KjPRJKl+ejL71HI1fMvz7EGw5JB9OefWtcyab52UiuRYZthhC8WkYyoWO69Q2fkEdEdCjtzb68pDZBUT0Zr82vCvWLm37owAmI3R3kHJsHpt6mPiPUftaAMsHh4vtBglwIfTlV93dfsmfatocpFAPHilJijwbUWoeihD94D1xymVVj6bijthBuDSegZoTJnqczY9YD9DhsSpkgVUr88wc4X5yzd/H0T8spJRIdWbw5mNyd4GNIfh+ztU8h8/89ql1kFuw1OCzEy0Q2KUoePnQI3PI669JG5LwtoxR8mcmYIOoDkaGk4eiJHVn4w2RIyFec7lCrLdVGL6xm3MwvrHa0varwHqDsxF9UqAFlzbmUlnoUAtKOFUxJeX3nSwqsO6XGAqHig7YrKWmgBZJZ4L0qHh04xpK/c2s99Jlye/TYNS1vsDIKS
x-ms-exchange-antispam-messagedata: XKqLHPwW2ioJaJJDzcbpfbgbw79BYhrP5NppBC1kolxnmOwQm8MrChCbmq+rMR3NndQ1IKAJmlkbFFbfj779F6TPCwFm2gPc+q1Cq3QBTT2gU+N9NDlr3wMwiK1Ai+5gbdFsmJ8kx6SE1UuBZ9HJRQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610a4157-0b80-408f-f757-08d7cbcc96f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 06:13:06.0991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sstmPv4nOwZUmMnkcWr6dXrGgq36v7NuIjTKgSjiCgOMVD7RNhBQlnKXEvU5NwpyZgfBByAvY20bqPwKxoL/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: Thursday, March 19, 2020 05:30
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sriov : Don't resume RLCG for SRIOV guest

[AMD Official Use Only - Internal Distribution Only]

ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: Tuesday, March 17, 2020 12:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/sriov : Don't resume RLCG for SRIOV guest

RLCG is enabled by host driver, no need to enable it in guest for none-PSP load path

Change-Id: I2f313743bf3d492f06aaef07224da6eda3878a28
Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d1cdcb4..e134bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1940,6 +1940,11 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
 			gfx_v10_0_rlc_enable_srm(adev);
 	} else {
+		if (amdgpu_sriov_vf(adev)) {
+			gfx_v10_0_init_csb(adev);
+			return 0;
+		}
+
 		adev->gfx.rlc.funcs->stop(adev);
 
 		/* disable CG */
-- 
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F0BC55178
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 12:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB14720757
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="euciEn5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB14720757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 636F96E07B;
	Tue, 27 Oct 2020 12:47:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB796E07B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 12:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYXefp90pmGC7CMPy3DtiVxgrnvq5IRL+fRD5RGg3uE3PLBmh7XOj4R/LBw96bl1B5xzHPJiFaBBDImKeGQ7GBxQ4WU+FKUH25DKt99lxUb8/DL49j6txf15E4omc+ftGiWUGdp28ZUfXtW9U2dVJbB45Ml6/BRo+S5Lx1FsZUsC/E4BSgLgVmjYMc1ZAWQ4/7w9lChg9X0p9zeBxe4KqY7RglcHjQhRbagjzlpb5YzdnjMXip3mwcV+6SUTzcr6HGLJaZ9O20FVDoPWjCF+zU4JpkdWoLAaVS/A83LxTZbp6qwhY5n1Gg7sbsANcn3yNPaxkaqAaEZsqHpWblPoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+RcGoT2AV2urIU//4r5Jsvpc/T8KOYllNhCLdgERqE=;
 b=fBYjGge5dDVBlndD1FEPWbgk2B5c1E9JGvgl7p8aIA8OYGdeDwy8clnZBik1Je/1kHqoV0CAjox91nWpj2etwUQg0NeIjpFwZyFCdN3sxo6toYhdLkJCeMH+kj2DoDb+mRKH+oCdO9VqGgCN/bOPm59q3KyMJPgHSPphI6OKf8PjpZcFEamVA/HsYAEvCxJEhnWMjdNPuTvu4HmkH1V0xW5v2Spns8xfehZPao9JBzlYOhOHyxEzHhJdDCQzkxtQKMIwXLnH7Gf5Rdo1BAVnzbfOjGGu+TOaGQG6egeudKn0NKnGdRgCZS71VzKoDWWTITspNG2czTurGmfvhyKgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+RcGoT2AV2urIU//4r5Jsvpc/T8KOYllNhCLdgERqE=;
 b=euciEn5nUiGH1RsuldJwphDEk2FtcKhL77kvAEk9CX2Q3VCah3wCW4FmjapLG65+KnsrNN+Yb7+1uat6mJjG9+71+CZKftEmQuxVF0lL8cndaSBErWYcgUVvyDgQ2+UYtEswYpKhWQCFTU4ZBCyWM0RZccXe9r7mGMZ25m9wq8Q=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Tue, 27 Oct 2020 12:47:10 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 12:47:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 0/3] Refine the codes about reseving bad pages.
Thread-Topic: [PATCH 0/3] Refine the codes about reseving bad pages.
Thread-Index: AQHWrEAiPVFqFPSsgUGwwlYsCyiMUKmrZdOQ
Date: Tue, 27 Oct 2020 12:47:10 +0000
Message-ID: <DM6PR12MB40758CD90C5E3D9C5C945D39FC160@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201027090347.3476-1-Dennis.Li@amd.com>
In-Reply-To: <20201027090347.3476-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-27T12:47:07Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f0329977-9a50-49cb-9084-00004fea3822;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-27T12:47:01Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: cc1fd9ff-b39a-4965-8082-0000fd20de31
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-27T12:47:08Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0b163b10-4f2f-4f89-b2b3-0000fb8c20da
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc95cbab-354b-4dbb-63ea-08d87a766c01
x-ms-traffictypediagnostic: DM5PR12MB4679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB4679D6945F6EBE4E473AA0FCFC160@DM5PR12MB4679.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3i63uLcBCGsD1EttWHPWSFghTVp0d986qHuxgaj5gcIXYvpy6YGP4AusDwqBUcqfAMTDxGlG+3fyCBaGUWqmm4BJTLByKoGNAIhgMXPjUNg9eKjysOR3NKa9t2Ms6ybyp+sCgh7XEOd/w2fcjo9is73cUOJRVYY1iHfeE5OQ6dc3ERK7sgR76ithNB1Hg8p4OTcMuX5vUXXlxhqlAMPV76Z4JE9Cx+y5scsCM9Zsk+cYJ62BgYwd9DwTLi/23hquVrFHvWt4EgoMaTJiYwtamsOoOLnlYCtz95CB9xy3ni3EIk8K4TI/rtexEw50Ub/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(5660300002)(66446008)(478600001)(64756008)(71200400001)(52536014)(66946007)(76116006)(83380400001)(66556008)(66476007)(33656002)(6636002)(26005)(316002)(86362001)(110136005)(2906002)(9686003)(4326008)(55016002)(7696005)(8676002)(6506007)(53546011)(186003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vU1n3aZ6voj6GWh23FWY2p3hg4oRZCjutlDq7xLCaDMwiUMB0QJDgXNjKWSvmS7lU5Zr3Ghcfa4rfLrEeYj7tIeQpJoMBYGHi6drBWgCRykbzLcvYDhns3LezDsz1Ci0nt6kAlHKA2TGwJ2qsF+xky/2rQ5gh4wq89S4ECWXa8PUmESBPbSFP9u2z8kKfDQ6Bnc2wPPQN1jOUQOlUHtn7g/GrhMhimCODq2vNB8WEyvi6fW+H8/tmthQfoq7g3pX775VKbtoiMLO088V99x92SsBIlWOoOb7tJXPcib01Wf7193AY2TooJoTrUPl2+jFsvSHTBGXQ28BxU8+q+xU+w/mIwlU5DBA+UbhaMhQrJepzPI/CvA5WynkUHA/KBv6nSh9bYAqKr+o02ABLZb+bIQOIENXTUeWZz4hpu8rD38T4p9sguIW/zOUVRE39YwpICpcqfpC88e/y/rVT3+nGxJ4Lbx9mEn5VJ0HBnwXRrS9CYNYKK30pPIW+3ibeVZbr4coGjnFp1q12izVTVyV3ITShxpjkG1VRxTrckvrKv3LSRTim8QcUiy5a0rbdtlIK0BklL450zI2fCBgn3EHAFS+WApKFYj4ZXuOfB2kioEXG/I4HvAUXBTMbn2ABTKSqraoAQFEO+fvyQQ5mCTS7A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc95cbab-354b-4dbb-63ea-08d87a766c01
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 12:47:10.8181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOJeAuvcdBFkJy3rB8Au1PxrBGiY/H42RVaAe4aB1CWc5NN6hsQhkjyEcOx5md2DLyEo2Au+JqGB4LeKnMxBVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4679
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Tuesday, October 27, 2020 17:04
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH 0/3] Refine the codes about reseving bad pages.

Beside umc, others' UE interrupt callback could enter into amdgpu_ras_reset_gpu, so the first patch change to save bad pages in UMC error interrupt callback.

When bad page error happens, the bad page mostly still be hold by some process, therefore driver will fail to reserve the bad page. The third patch will reserve the bad page when freeing it, make system has no chance to allocate it to other proccess.

Dennis Li (3):
  drm/amdgpu: change to save bad pages in UMC error interrupt callback
  drm/amdgpu: remove redundant GPU reset
  drm/amdgpu: fix the issue of reserving bad pages failed

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 155 +++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  17 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  16 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 115 +++++++++++++
 6 files changed, 164 insertions(+), 150 deletions(-)

--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

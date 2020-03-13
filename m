Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F03C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 03:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE5020723
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 03:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PWkxCSfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE5020723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A6F89C98;
	Fri, 13 Mar 2020 03:34:37 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700071.outbound.protection.outlook.com [40.107.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5652789C98
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 03:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoY8MG2/smlHlYsEMueQ7UOuBs2izAoasdQIad+bzLgEIAnHqq1+L580L8W3mhXYVcNAzjrZonYogZFr+r7VDcVkUJs5pFNKZdiVfwLgKmBOT9hI4/IWmjZMy9J5vqAvpNPb3nJlDBJPZmnRb72bt7VYm04HjMzeSwff8pYMDllY6bMLl7SpyYZ56ufQWKA9bQ1lK/v25tRhPAAVJu/B1MgiONWZdmbHUDSkxYMiLPCe4uURG7z2Hfbhr1E788RSce0XfzJCG9pbEgs/Zn/GUVlitbxbzx/QPOp9z84DD9gMhvjOzTgo2BvyqEdT5d74qp/pGQucAjpBqS1Hnt7qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk9ljP4XszFUCh8giT5sKb4ufFi21S26VWWt7MOaegY=;
 b=ScNMSHZ1TNu/RBR5699keYebart2EZylmjMOVb8SYW8JRwRKLzBq+HZRKBbHb/+sqiXKzIkvzIvMlRBZjUJYfdYYPlFPO0rDShpEGG5Nlfzo37XtX1lqWpUbsuL2pE7JKq1QyrXc04fkLHuLWJwoEVmE6nxQiZFol0ITVPvbGvo8NHYeSU6D15vy4Uubm1eCEHKNHnbGbk8k/W7iHQpZ21bvLRtqdRGP0L5p9tPsDUAMyqu+1/2zXzmxnrEty2dVs+kZ3ag92Eb/aAziGp7r1ihQK9pdJRyIb7yv+m2B15wVAz5rCpEjFinXYGPsIh57m5FvaEb3RwOk3Wl779AmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk9ljP4XszFUCh8giT5sKb4ufFi21S26VWWt7MOaegY=;
 b=PWkxCSfP7gi71kU8+au5zCXQw2mILMFje+fwmYzgS1dL4zUnhT440mabx5eMbOAcnMBDkaD0Fcl+wMkfNIW5ir2w1QNzAd0MKXuc1IaNXsQyZux7xig8LMkXU/4qsL/vdEQ4KUaZsQFOpPyOdIBqdPkoQgDSsGqbZ+SsEd1AHzI=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2922.namprd12.prod.outlook.com (2603:10b6:5:18d::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Fri, 13 Mar 2020 03:34:33 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 03:34:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: add codes to clear AccVGPR for arcturus
Thread-Topic: [PATCH v2] drm/amdgpu: add codes to clear AccVGPR for arcturus
Thread-Index: AQHV+OakofvpKCLUW0u79q/HAFGpEqhF3oZA
Date: Fri, 13 Mar 2020 03:34:33 +0000
Message-ID: <DM6PR12MB4075C9F283CF3D8DC39C1F8FFCFA0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200313032222.9799-1-Dennis.Li@amd.com>
In-Reply-To: <20200313032222.9799-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-13T03:34:30Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d9b442c9-a22a-4b6e-a300-000070fc04b3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-13T03:34:30Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 10bb1d69-043a-4701-9cf0-00009fe6c04d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb412675-a783-4e47-4eb5-08d7c6ff7276
x-ms-traffictypediagnostic: DM6PR12MB2922:|DM6PR12MB2922:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29228444D003CD6CA59B6804FCFA0@DM6PR12MB2922.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(478600001)(9686003)(55016002)(26005)(4326008)(110136005)(53546011)(86362001)(71200400001)(2906002)(7696005)(6506007)(316002)(76116006)(33656002)(186003)(52536014)(5660300002)(6636002)(66446008)(81156014)(66946007)(8936002)(66556008)(30864003)(64756008)(66476007)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2922;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NBphpS087tX2MmzMU89w70YZ77SCN2eqffJxmcp0p2FtZo6AkZueP1EXCTjKw1PzDK/6sXsdjoiQUmBrrcolPBeZGSdboyL9VPv819uNgJJQ3wrnDtVZnFJ+i72eAkEyEbTXCd3vxb+ZBeNi71IL5sFVZa8lBc6gq/CtROixesQrC5UUf3M3L5N2ddajRPhX1GniBafzJAh/cokKPnQBPA/n90nWbFro1tVOOCd/NzSGUZPjGYOmLl1XF0FDhtdZiEmq1Fc0zyzOukEL+oW7PrWPpBRM3v/1HGsfBfArZwGZdQEgGZD1UTOtJ/pkLW+iGHNGNBeGAca8Bbbs0NMmg6I56bWmSBJc8rPSbg3xRm/CweeGsEmZqAqgh+RVxld0r9w9Y2lopOEMduc4qs+eWtGfXU/1mnlMznx+vvHO+oPO1Bk5QOPbR8kGhzece2aY
x-ms-exchange-antispam-messagedata: /A4oZW6cRiZp5dUFPZ44lOMktg9prSExN8Sk7Je6OSesvvQTgcVD/rqUFNUQxGvEtg8tqzFrtUTTex9nZAMkhOA7QMLWZ+o2VI+4NKzKEHvR4KykxaFrGn6Wly02FEG7BwLMKyDkrpz9w+yreKJpJQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb412675-a783-4e47-4eb5-08d7c6ff7276
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 03:34:33.4166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcGgAVPVO8GHcSxcK2SqCz4wkz7h0HJQ7eFCMGMlyixoyuBqEj2gpKyeBMpeH7EmqNifG44TO37qJiqRP/i43w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2922
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Friday, March 13, 2020 11:22
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: add codes to clear AccVGPR for arcturus

AccVGPRs are newly added in arcturus. Before reading these registers, they should be initialized. Otherwise edc error happens, when RAS is enabled.

v2: reuse the existing logical to calculate register size

Change-Id: I4ed384f0cc4b781a10cfd6ad1e3a132445bdc261
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
old mode 100644
new mode 100755
index c78ffdc51373..324838baa71c
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4144,6 +4144,101 @@ static const u32 sgpr_init_compute_shader[] =
 	0xbe800080, 0xbf810000,
 };
 
+static const u32 vgpr_init_compute_shader_arcturus[] = {
+	0xd3d94000, 0x18000080, 0xd3d94001, 0x18000080, 0xd3d94002, 0x18000080,
+	0xd3d94003, 0x18000080, 0xd3d94004, 0x18000080, 0xd3d94005, 0x18000080,
+	0xd3d94006, 0x18000080, 0xd3d94007, 0x18000080, 0xd3d94008, 0x18000080,
+	0xd3d94009, 0x18000080, 0xd3d9400a, 0x18000080, 0xd3d9400b, 0x18000080,
+	0xd3d9400c, 0x18000080, 0xd3d9400d, 0x18000080, 0xd3d9400e, 0x18000080,
+	0xd3d9400f, 0x18000080, 0xd3d94010, 0x18000080, 0xd3d94011, 0x18000080,
+	0xd3d94012, 0x18000080, 0xd3d94013, 0x18000080, 0xd3d94014, 0x18000080,
+	0xd3d94015, 0x18000080, 0xd3d94016, 0x18000080, 0xd3d94017, 0x18000080,
+	0xd3d94018, 0x18000080, 0xd3d94019, 0x18000080, 0xd3d9401a, 0x18000080,
+	0xd3d9401b, 0x18000080, 0xd3d9401c, 0x18000080, 0xd3d9401d, 0x18000080,
+	0xd3d9401e, 0x18000080, 0xd3d9401f, 0x18000080, 0xd3d94020, 0x18000080,
+	0xd3d94021, 0x18000080, 0xd3d94022, 0x18000080, 0xd3d94023, 0x18000080,
+	0xd3d94024, 0x18000080, 0xd3d94025, 0x18000080, 0xd3d94026, 0x18000080,
+	0xd3d94027, 0x18000080, 0xd3d94028, 0x18000080, 0xd3d94029, 0x18000080,
+	0xd3d9402a, 0x18000080, 0xd3d9402b, 0x18000080, 0xd3d9402c, 0x18000080,
+	0xd3d9402d, 0x18000080, 0xd3d9402e, 0x18000080, 0xd3d9402f, 0x18000080,
+	0xd3d94030, 0x18000080, 0xd3d94031, 0x18000080, 0xd3d94032, 0x18000080,
+	0xd3d94033, 0x18000080, 0xd3d94034, 0x18000080, 0xd3d94035, 0x18000080,
+	0xd3d94036, 0x18000080, 0xd3d94037, 0x18000080, 0xd3d94038, 0x18000080,
+	0xd3d94039, 0x18000080, 0xd3d9403a, 0x18000080, 0xd3d9403b, 0x18000080,
+	0xd3d9403c, 0x18000080, 0xd3d9403d, 0x18000080, 0xd3d9403e, 0x18000080,
+	0xd3d9403f, 0x18000080, 0xd3d94040, 0x18000080, 0xd3d94041, 0x18000080,
+	0xd3d94042, 0x18000080, 0xd3d94043, 0x18000080, 0xd3d94044, 0x18000080,
+	0xd3d94045, 0x18000080, 0xd3d94046, 0x18000080, 0xd3d94047, 0x18000080,
+	0xd3d94048, 0x18000080, 0xd3d94049, 0x18000080, 0xd3d9404a, 0x18000080,
+	0xd3d9404b, 0x18000080, 0xd3d9404c, 0x18000080, 0xd3d9404d, 0x18000080,
+	0xd3d9404e, 0x18000080, 0xd3d9404f, 0x18000080, 0xd3d94050, 0x18000080,
+	0xd3d94051, 0x18000080, 0xd3d94052, 0x18000080, 0xd3d94053, 0x18000080,
+	0xd3d94054, 0x18000080, 0xd3d94055, 0x18000080, 0xd3d94056, 0x18000080,
+	0xd3d94057, 0x18000080, 0xd3d94058, 0x18000080, 0xd3d94059, 0x18000080,
+	0xd3d9405a, 0x18000080, 0xd3d9405b, 0x18000080, 0xd3d9405c, 0x18000080,
+	0xd3d9405d, 0x18000080, 0xd3d9405e, 0x18000080, 0xd3d9405f, 0x18000080,
+	0xd3d94060, 0x18000080, 0xd3d94061, 0x18000080, 0xd3d94062, 0x18000080,
+	0xd3d94063, 0x18000080, 0xd3d94064, 0x18000080, 0xd3d94065, 0x18000080,
+	0xd3d94066, 0x18000080, 0xd3d94067, 0x18000080, 0xd3d94068, 0x18000080,
+	0xd3d94069, 0x18000080, 0xd3d9406a, 0x18000080, 0xd3d9406b, 0x18000080,
+	0xd3d9406c, 0x18000080, 0xd3d9406d, 0x18000080, 0xd3d9406e, 0x18000080,
+	0xd3d9406f, 0x18000080, 0xd3d94070, 0x18000080, 0xd3d94071, 0x18000080,
+	0xd3d94072, 0x18000080, 0xd3d94073, 0x18000080, 0xd3d94074, 0x18000080,
+	0xd3d94075, 0x18000080, 0xd3d94076, 0x18000080, 0xd3d94077, 0x18000080,
+	0xd3d94078, 0x18000080, 0xd3d94079, 0x18000080, 0xd3d9407a, 0x18000080,
+	0xd3d9407b, 0x18000080, 0xd3d9407c, 0x18000080, 0xd3d9407d, 0x18000080,
+	0xd3d9407e, 0x18000080, 0xd3d9407f, 0x18000080, 0xd3d94080, 0x18000080,
+	0xd3d94081, 0x18000080, 0xd3d94082, 0x18000080, 0xd3d94083, 0x18000080,
+	0xd3d94084, 0x18000080, 0xd3d94085, 0x18000080, 0xd3d94086, 0x18000080,
+	0xd3d94087, 0x18000080, 0xd3d94088, 0x18000080, 0xd3d94089, 0x18000080,
+	0xd3d9408a, 0x18000080, 0xd3d9408b, 0x18000080, 0xd3d9408c, 0x18000080,
+	0xd3d9408d, 0x18000080, 0xd3d9408e, 0x18000080, 0xd3d9408f, 0x18000080,
+	0xd3d94090, 0x18000080, 0xd3d94091, 0x18000080, 0xd3d94092, 0x18000080,
+	0xd3d94093, 0x18000080, 0xd3d94094, 0x18000080, 0xd3d94095, 0x18000080,
+	0xd3d94096, 0x18000080, 0xd3d94097, 0x18000080, 0xd3d94098, 0x18000080,
+	0xd3d94099, 0x18000080, 0xd3d9409a, 0x18000080, 0xd3d9409b, 0x18000080,
+	0xd3d9409c, 0x18000080, 0xd3d9409d, 0x18000080, 0xd3d9409e, 0x18000080,
+	0xd3d9409f, 0x18000080, 0xd3d940a0, 0x18000080, 0xd3d940a1, 0x18000080,
+	0xd3d940a2, 0x18000080, 0xd3d940a3, 0x18000080, 0xd3d940a4, 0x18000080,
+	0xd3d940a5, 0x18000080, 0xd3d940a6, 0x18000080, 0xd3d940a7, 0x18000080,
+	0xd3d940a8, 0x18000080, 0xd3d940a9, 0x18000080, 0xd3d940aa, 0x18000080,
+	0xd3d940ab, 0x18000080, 0xd3d940ac, 0x18000080, 0xd3d940ad, 0x18000080,
+	0xd3d940ae, 0x18000080, 0xd3d940af, 0x18000080, 0xd3d940b0, 0x18000080,
+	0xd3d940b1, 0x18000080, 0xd3d940b2, 0x18000080, 0xd3d940b3, 0x18000080,
+	0xd3d940b4, 0x18000080, 0xd3d940b5, 0x18000080, 0xd3d940b6, 0x18000080,
+	0xd3d940b7, 0x18000080, 0xd3d940b8, 0x18000080, 0xd3d940b9, 0x18000080,
+	0xd3d940ba, 0x18000080, 0xd3d940bb, 0x18000080, 0xd3d940bc, 0x18000080,
+	0xd3d940bd, 0x18000080, 0xd3d940be, 0x18000080, 0xd3d940bf, 0x18000080,
+	0xd3d940c0, 0x18000080, 0xd3d940c1, 0x18000080, 0xd3d940c2, 0x18000080,
+	0xd3d940c3, 0x18000080, 0xd3d940c4, 0x18000080, 0xd3d940c5, 0x18000080,
+	0xd3d940c6, 0x18000080, 0xd3d940c7, 0x18000080, 0xd3d940c8, 0x18000080,
+	0xd3d940c9, 0x18000080, 0xd3d940ca, 0x18000080, 0xd3d940cb, 0x18000080,
+	0xd3d940cc, 0x18000080, 0xd3d940cd, 0x18000080, 0xd3d940ce, 0x18000080,
+	0xd3d940cf, 0x18000080, 0xd3d940d0, 0x18000080, 0xd3d940d1, 0x18000080,
+	0xd3d940d2, 0x18000080, 0xd3d940d3, 0x18000080, 0xd3d940d4, 0x18000080,
+	0xd3d940d5, 0x18000080, 0xd3d940d6, 0x18000080, 0xd3d940d7, 0x18000080,
+	0xd3d940d8, 0x18000080, 0xd3d940d9, 0x18000080, 0xd3d940da, 0x18000080,
+	0xd3d940db, 0x18000080, 0xd3d940dc, 0x18000080, 0xd3d940dd, 0x18000080,
+	0xd3d940de, 0x18000080, 0xd3d940df, 0x18000080, 0xd3d940e0, 0x18000080,
+	0xd3d940e1, 0x18000080, 0xd3d940e2, 0x18000080, 0xd3d940e3, 0x18000080,
+	0xd3d940e4, 0x18000080, 0xd3d940e5, 0x18000080, 0xd3d940e6, 0x18000080,
+	0xd3d940e7, 0x18000080, 0xd3d940e8, 0x18000080, 0xd3d940e9, 0x18000080,
+	0xd3d940ea, 0x18000080, 0xd3d940eb, 0x18000080, 0xd3d940ec, 0x18000080,
+	0xd3d940ed, 0x18000080, 0xd3d940ee, 0x18000080, 0xd3d940ef, 0x18000080,
+	0xd3d940f0, 0x18000080, 0xd3d940f1, 0x18000080, 0xd3d940f2, 0x18000080,
+	0xd3d940f3, 0x18000080, 0xd3d940f4, 0x18000080, 0xd3d940f5, 0x18000080,
+	0xd3d940f6, 0x18000080, 0xd3d940f7, 0x18000080, 0xd3d940f8, 0x18000080,
+	0xd3d940f9, 0x18000080, 0xd3d940fa, 0x18000080, 0xd3d940fb, 0x18000080,
+	0xd3d940fc, 0x18000080, 0xd3d940fd, 0x18000080, 0xd3d940fe, 0x18000080,
+	0xd3d940ff, 0x18000080, 0xb07c0000, 0xbe8a00ff, 0x000000f8, 0xbf11080a,
+	0x7e000280, 0x7e020280, 0x7e040280, 0x7e060280, 0x7e080280, 0x7e0a0280,
+	0x7e0c0280, 0x7e0e0280, 0x808a880a, 0xbe80320a, 0xbf84fff5, 0xbf9c0000,
+	0xd28c0001, 0x0001007f, 0xd28d0001, 0x0002027e, 0x10020288, 0xb88b0904,
+	0xb78b4000, 0xd1196a01, 0x00001701, 0xbe8a0087, 0xbefc00c1, 0xd89c4000,
+	0x00020201, 0xd89cc080, 0x00040401, 0x320202ff, 0x00000800, 0x808a810a,
+	0xbf84fff8, 0xbf810000,
+};
+
 /* When below register arrays changed, please update gpr_reg_size,
   and sec_ded_counter_reg_size in function gfx_v9_0_do_edc_gpr_workarounds,
   to cover all gfx9 ASICs */
@@ -4164,6 +4259,23 @@ static const struct soc15_reg_entry vgpr_init_regs[] = {
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },  };
 
+static const struct soc15_reg_entry vgpr_init_regs_arcturus[] = {
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_NUM_THREAD_X), 0x40 },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_NUM_THREAD_Y), 4 },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_NUM_THREAD_Z), 1 },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_PGM_RSRC1), 0x81 },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_PGM_RSRC2), 0x400000 },  /* 64KB LDS */
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE7), 
+0xffffffff }, };
+
 static const struct soc15_reg_entry sgpr1_init_regs[] = {
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_NUM_THREAD_X), 0x40 }, @@ -4294,7 +4406,10 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 						adev->gfx.config.max_cu_per_sh *
 						adev->gfx.config.max_sh_per_se;
 	int sgpr_work_group_size = 5;
-	int gpr_reg_size = compute_dim_x / 16 + 6;
+	int gpr_reg_size = adev->gfx.config.max_shader_engines + 6;
+	int vgpr_init_shader_size;
+	const u32 *vgpr_init_shader_ptr;
+	const struct soc15_reg_entry *vgpr_init_regs_ptr;
 
 	/* only support when RAS is enabled */
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) @@ -4304,6 +4419,16 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	if (!ring->sched.ready)
 		return 0;
 
+	if (adev->asic_type == CHIP_ARCTURUS) {
+		vgpr_init_shader_ptr = vgpr_init_compute_shader_arcturus;
+		vgpr_init_shader_size = sizeof(vgpr_init_compute_shader_arcturus);
+		vgpr_init_regs_ptr = vgpr_init_regs_arcturus;
+	} else {
+		vgpr_init_shader_ptr = vgpr_init_compute_shader;
+		vgpr_init_shader_size = sizeof(vgpr_init_compute_shader);
+		vgpr_init_regs_ptr = vgpr_init_regs;
+	}
+
 	total_size =
 		(gpr_reg_size * 3 + 4 + 5 + 2) * 4; /* VGPRS */
 	total_size +=
@@ -4312,7 +4437,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 		(gpr_reg_size * 3 + 4 + 5 + 2) * 4; /* SGPRS2 */
 	total_size = ALIGN(total_size, 256);
 	vgpr_offset = total_size;
-	total_size += ALIGN(sizeof(vgpr_init_compute_shader), 256);
+	total_size += ALIGN(vgpr_init_shader_size, 256);
 	sgpr_offset = total_size;
 	total_size += sizeof(sgpr_init_compute_shader);
 
@@ -4325,8 +4450,8 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	}
 
 	/* load the compute shaders */
-	for (i = 0; i < ARRAY_SIZE(vgpr_init_compute_shader); i++)
-		ib.ptr[i + (vgpr_offset / 4)] = vgpr_init_compute_shader[i];
+	for (i = 0; i < vgpr_init_shader_size/sizeof(u32); i++)
+		ib.ptr[i + (vgpr_offset / 4)] = vgpr_init_shader_ptr[i];
 
 	for (i = 0; i < ARRAY_SIZE(sgpr_init_compute_shader); i++)
 		ib.ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i]; @@ -4338,9 +4463,9 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < gpr_reg_size; i++) {
 		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(vgpr_init_regs[i])
+		ib.ptr[ib.length_dw++] = 
+SOC15_REG_ENTRY_OFFSET(vgpr_init_regs_ptr[i])
 								- PACKET3_SET_SH_REG_START;
-		ib.ptr[ib.length_dw++] = vgpr_init_regs[i].reg_value;
+		ib.ptr[ib.length_dw++] = vgpr_init_regs_ptr[i].reg_value;
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
 	gpu_addr = (ib.gpu_addr + (u64)vgpr_offset) >> 8; @@ -4352,7 +4477,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 
 	/* write dispatch packet */
 	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib.ptr[ib.length_dw++] = compute_dim_x; /* x */
+	ib.ptr[ib.length_dw++] = compute_dim_x * 2; /* x */
 	ib.ptr[ib.length_dw++] = 1; /* y */
 	ib.ptr[ib.length_dw++] = 1; /* z */
 	ib.ptr[ib.length_dw++] =
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

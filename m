Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75BAC3F2D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 05:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E0E246A0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 05:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="li3BTfxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E0E246A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CACB06EDE4;
	Fri, 28 Feb 2020 05:29:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B2E6EDE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 05:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFtjIxHATs7qLIhFu6fqvGOc54MKzxn2/Ezegk/ks0gvw59IDhrHGFamHk+GNL1yj5usOZ06haqHLKs78fIjSZlHjw3YTDgRqQAB/GVq0dWXVPmEVpZ7OYyGxhBbRd0HcaEJHC07lWHliIqiexYrQShKn3j1jXCCela66dCA7JXv0EgfdX2fAwZHqKeol8tM+7tyw+94V5vwv0K4zYnUOS7twZDLbfocBGUEY4vomgaKf639O9cCUJLbaJ1NzM/L3oxNy4xapmvHifuNFe35iHEOOfHO0dludA3XDPDTUeL1SgLixIra7Kk26kfCqjarwWZ0RgnKHOvsi1JqqsG9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpi9Er5M+Z2BKdtag1w8rCUGYgVTtYyQQ8daIBB2QYY=;
 b=Lt4/n96mNobk6HVzfvelMLdGS7Jmlijf5UQNdkgqjXTfl4HVUhhCQoEkVv3R2KfmXqh4unrFnai+igc29IP1umwW0i5qikwNW5/riE0YTOg4ZN5BkSDs00OX74QJZ9X0wD06cgZ4dIiMzDJoNSULruoal2i15RtjAFrVCSSnOCxRpXksfZnwSi8SwacH0AkR8xDtvEYHABqLgstVQb4gHTEg2/qz0becM3yzB3cvot/+zGZ2n6z4kJqpOC7b1gcMN0RulsiMuP1nnALjGDssjErJbdKd09c/smnxH1qvpFVnv0pgBLLpilSEjxGH43GDJDr9kvG26NBe268BNmsU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpi9Er5M+Z2BKdtag1w8rCUGYgVTtYyQQ8daIBB2QYY=;
 b=li3BTfxIpTqq31HFwZBQTEuGs8lGC1KXQEtKNlgBAtj2aQ+i6CRR/LrvnabEmNVoGzE1pH2KAaWwqjcXWgY188GbuBwVT/l9oRe/ajFaxiUKj5XF4O3Icp0poHTJV4PK6c8XEsnxK8nrwY56zCqQwXX+SbvgaaWagJuJhjwkK6g=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 28 Feb
 2020 05:29:35 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb%7]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 05:29:35 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Write blocked CP registers using RLC on VF
Thread-Topic: [PATCH] drm/amdgpu: Write blocked CP registers using RLC on VF
Thread-Index: AQHV7E7kVKXFJqas2024cwvvgPZ2zqgwF17g
Date: Fri, 28 Feb 2020 05:29:34 +0000
Message-ID: <MN2PR12MB39337436F6E05FEA1227EEA484E80@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20200226024526.16710-1-Rohit.Khaire@amd.com>
In-Reply-To: <20200226024526.16710-1-Rohit.Khaire@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [240e:e0:b16d:8000:c092:194e:2579:2313]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7571740d-4cb7-4ea9-9012-08d7bc0f3257
x-ms-traffictypediagnostic: MN2PR12MB4533:|MN2PR12MB4533:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4533EE76F6CD93C0A669C69484E80@MN2PR12MB4533.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(33656002)(186003)(5660300002)(2906002)(81166006)(86362001)(81156014)(7696005)(76116006)(478600001)(66446008)(966005)(66476007)(53546011)(66556008)(64756008)(52536014)(6506007)(66946007)(8676002)(45080400002)(15650500001)(316002)(110136005)(9686003)(4326008)(71200400001)(55016002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4533;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 16VmJEsTvzpdAzX09d6HsQKb6gzs0n1A6Azg9H90SE+tLGFNoor6UhtLznA3yLOBxfFbhDWjxawo/sg2UPmJJUXuU9sysk/j2OUJ4L2V+Y2mTFQkVjONULIlwJyKIMkYbCe+bnr6/XEE5hKF1mt2R+st6V5J9yGYGRKuDrb7AOJu+wsJs9VXVudNMM5mIdAi5MtrlN6jDvRUkZ9LsomsOwuq3L0flIGjHWs/6cjg2d40SCYxhFd4yL9W0kM96jC75u1z3NtxtTGme7hZBH7zii0adpqASWSAD9yWmXeX3jrsXlwg3ARHTuVJvoO1S2hWqC4+yFONdzIzDjYdmruSy/xt8SYYDrnu/HyErZf5yEHZokgDlx1wia/9LNg3QfZY23dq9IoxIA6guG5IKEX3DEe1IXFolN27m2y+HDAgQ2OwFRgYhBk8Pd9RfbAFwymSI1siMoyivK7A90BpNAz2smwUBe+EI1CRBPZ6yo1rgUU=
x-ms-exchange-antispam-messagedata: jyEZHWjqfzPsP32AdbAhy/7sHMxtgHE9JhaxPc1qIDlNSpSUu4qrKa8r/Qxk2ZelPmVwExrvLd6cVB/6SlBGTThiiUaxOE+FhmZFwBc8tUCj9FPUB1dlYefiVKTVY0F/91VFxfDIbeDbbJHO57VM2BGfS1Trc/3u0uS1wJ62pQCHa92DPe+vxr0/3wKC5PkregrGrxqNzc7Ojq9S8Bpa9A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7571740d-4cb7-4ea9-9012-08d7bc0f3257
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 05:29:35.0285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wReya4nwjtxlpPlJenUmZbpVHpLuL7its6pcW5UEduZlQGfAtdgVt1tEacnf09BE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
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
Cc: "Khaire, Rohit" <Rohit.Khaire@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Rohit Khaire
Sent: Wednesday, February 26, 2020 10:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Khaire, Rohit <Rohit.Khaire@amd.com>
Subject: [PATCH] drm/amdgpu: Write blocked CP registers using RLC on VF

This change programs CP_ME_CNTL and RLC_CSIB_* through RLC

Signed-off-by: Rohit Khaire <Rohit.Khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 44f00ecea322..8f99bc6163b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1783,11 +1783,11 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 
 	/* csib */
-	WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
 		     adev->gfx.rlc.clear_state_gpu_addr >> 32);
-	WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_LO,
+	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
 		     adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
-	WREG32_SOC15(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
+	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
 
 	return 0;
 }
@@ -2395,7 +2395,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 			adev->gfx.gfx_ring[i].sched.ready = false;
 	}
-	WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C623a44a5ca41457bc1bc08d7ba660464%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637182819663774681&amp;sdata=zyLVEDjoZmkh9zEGtR%2FqWNA7J0aO4wl3jnYqrvwBn1Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

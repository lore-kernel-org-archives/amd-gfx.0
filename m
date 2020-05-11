Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBFAC47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 06:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE5E20736
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 06:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OYmi81Qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE5E20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B316E1BA;
	Mon, 11 May 2020 06:29:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C781B6E1BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 06:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB3BGpwgEYhNWXlEtui7u4UjGVecwDW98oU9o0oo3ROd+7s9tkKRCPWhNMeFS3NyfmuAm7zI921XZgmV0vbAf4+aa8KJfMtI3NHJxRspckd3T03odxwbrRJ4uAsXalndifU3OgRr+onmVs0WjOagzpK6gJetCZZOR/hunmrvoulTaadtSneRCMNPmIviyOAra2U2S6d+6vDvuRmq4nXK/b27BvPJDv+c70cRIBapO+otuhiRgA6LwKlhPczhBvUrbgRqLAA1VAi2AwJEYJFca7hZWS89ZFPweRFhCTj4V73MjLkHEbqhuRz2zk1P3O9UYOEW1Ncw3nyBrnmaVxqLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tULq1bC/uaNMR/CrM6dMvhJDPtzLwVN002P2yuNSQOE=;
 b=bKXIrGBf5SKtbCr3+URXUwGyuSyoF/lPcC3l6kmO97T+RWfOCwBLl6nZY8Z4llwR+MdtyFaJcMsKxB62D3+dKLewFPVQ5nXsvLVHHs9sBmzjZ1cVH5E1mObcGMz75s69ZqdG90AoiydigPs7sarUutaqZRBxrTEIjwOVCjqf7dpM0Uf7HVh8axBxvr9MtbsZbHMceR0wHlSEsXcZAbfVoaLEMDItJUaIVSOpbg9Bs8dj8pqpDUspgi1+ao8tbRO6ycuffI32W388W5yG7iyQBUwEyfBDmCQrv3QHX5Z2b+u9uxVumDA6uwGk1TR9yIr9ooUnF+wbHnLRhEiuXVYGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tULq1bC/uaNMR/CrM6dMvhJDPtzLwVN002P2yuNSQOE=;
 b=OYmi81Qf3jmOqFlEjDXYFREbpvKfdmJx740rFgXvcuBodW4PBQyEk4ctfoyQ5eeYQ01/KwCghNMtV8Tr7LoKEa/KRiwdRCrmxxDj7h+dSNp8bue79aHtpZgDDkkk45JFFAhvA5hFcrKSenAfia8u+J9W3+c6EFtveBcsmxO6wSA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2922.namprd12.prod.outlook.com (2603:10b6:5:18d::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Mon, 11 May 2020 06:29:34 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 06:29:34 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: skip judging if baco support for
 Arcturus sriov
Thread-Topic: [PATCH] drm/amd/powerplay: skip judging if baco support for
 Arcturus sriov
Thread-Index: AQHWJdjGJ80Bf+QGFE2IBnn9sYFu5qiibmMAgAAA1CA=
Date: Mon, 11 May 2020 06:29:33 +0000
Message-ID: <DM6PR12MB2619280194A396D8DFC6E4C4E4A10@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200509080633.4506-1-Jane.Jian@amd.com>
 <BY5PR12MB3652092EA8ED7FCBD34DA165FFA10@BY5PR12MB3652.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB3652092EA8ED7FCBD34DA165FFA10@BY5PR12MB3652.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-11T06:25:59Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c4e03e14-386d-4bab-b862-0000d91534ec;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d68bd12-7fef-4b49-8e68-08d7f574abb1
x-ms-traffictypediagnostic: DM6PR12MB2922:|DM6PR12MB2922:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2922DEBFC44107AC5129FD59E4A10@DM6PR12MB2922.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLGXd3vgN+vqSqFQ+V9B0FPQQeIDC9OmEMzewtrMddnhHYq6sEcUP3LXaz+wTSpmzxuIyPdpMgvwVd24/BLs37F2nfF7/NL+w3L3gPA6RFsvMhiBN30i3vMbizTdItXj+64Y2L6Pjm6qPMQfvDfAd0kHYqHWgSneYW2gRSPKMmQAEDcuYDH4k1tDoDjERG9VyObvCh+3VJz1XzaLjK+snuRHE3a//3ewCZyKFwGyGqR5/wbYq8m1LIKpIJUZsHJGxW12U3JvSuffaw8+KAijtw92/sfWeuyqmOGpyqfKLQ2ktXXYM4SVPvIRzKLT3G3mAhKxHP9QBXBZs2cLPwA55SKNsvgCSZosesi2ZAKwWaL71RXLd0VqXzL2es4HLB+GQaIX/hEK6n3DKDdmAAp5dmOMxDsO8xhtbFPmk0zItlL4xFgE6hIb2SKhVS7jyByxgMgxPU9T4Er6Lk9nAfemvZJ/VQvH0DAav89qlEdL9gOHVu2KhNhNdGCJ/uq9sl49HxPCMiB1nMeHHrWPSpGZIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(33430700001)(6506007)(8676002)(53546011)(26005)(8936002)(4326008)(66476007)(86362001)(110136005)(66946007)(76116006)(5660300002)(7696005)(71200400001)(66556008)(64756008)(186003)(52536014)(316002)(9686003)(55016002)(33656002)(66446008)(2906002)(33440700001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ftIF4xU8O1MLxvP6PDd+rQXVkrivFYu48ng2+POlNFKP3TGSCOJdnnrxbxuV5fkdrcXOR/OXQABqIZJYaSqo6AprAOgF2dPeggEuA3dAsDBXTFlsgjm/nl21DlYIHK6lAAgFKgSxgSvjq4nDup6jyPERt1dGeuXmNckgV6lTrjbTn8Y2W8zBRBLxdCFfrcHEsrToxZGHjkIepp71a9+JHJF7VANoMKcgj2blyRE0E92wkno3IAIGfJnVKaMktnV2Wq+8p+eYdrpQews7mpl5KZYFByM5VK3vcJbYFElh0vNfbUY6dpZAL8rTtGHgGvaAkogoZHU3sy0GOsF826yMNdDqgTY6I90I1dG+zuLEfYp3VzwSYVI5bJ5vlzc3YQvWfyjaFETIALIA38iM9YgLd/H9RAF8oI5rKXCFSdyo5MBXGQQzKGrH5DmyWiBU6lubRauDpAea1PyBOUfo4amnD3CSLvyn1Ux1PxqzD6nq++UtrUfKOZiVZKq5shH6dIzj
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d68bd12-7fef-4b49-8e68-08d7f574abb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 06:29:34.0097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNiyGxFIZQUZwAkjQW+kzSH5NIWI3U/gqVCEw5l423KbYjYudgNm2IOMx+lsWj5a
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
Cc: "Min, Frank" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Jian, Jane <Jane.Jian@amd.com> 
Sent: Monday, May 11, 2020 2:26 PM
To: Jian, Jane <Jane.Jian@amd.com>; amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>
Cc: Min, Frank <Frank.Min@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: skip judging if baco support for Arcturus sriov

[AMD Official Use Only - Internal Distribution Only]

Hi @Quan, Evan,
Could you please help to review this patch?
Since this is previously your patch here.
Thanks,
Jane 

-----Original Message-----
From: Jane Jian <Jane.Jian@amd.com> 
Sent: Saturday, May 9, 2020 4:07 PM
To: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>
Cc: Jian, Jane <Jane.Jian@amd.com>; Min, Frank <Frank.Min@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip judging if baco support for Arcturus sriov

since for sriov, baco happens on host side, no need and meaning to judge is baco.
also, since kiq reads strap0 in here, if kiq is not ready or gpu reset(kiq resume) happens after this read, would fail to read and wrongly set baco as true(1).

Change-Id: Ib67f837edfbf09263133d5614f6dbb890cf27b12
Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1c66b7d7139c..cfae4bcaf32e 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2251,7 +2251,7 @@ static bool arcturus_is_baco_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
 
-	if (!smu_v11_0_baco_is_support(smu))
+	if (!smu_v11_0_baco_is_support(smu) || amdgpu_sriov_vf(adev))
 		return false;
 
 	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

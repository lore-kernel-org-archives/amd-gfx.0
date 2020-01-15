Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15D7C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 06:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940C52467C
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 06:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uWfPDGYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940C52467C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68206E856;
	Wed, 15 Jan 2020 06:26:43 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690040.outbound.protection.outlook.com [40.107.69.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06E16E856
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 06:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl1UDoqK4WFw+b0f5mpGRiUDBe6SXyjFIzJZSc3cSIchf3z4AlBTFMHBsivBb4Z5n0R59Z8JiTGAGEBqbyN/MDVkTHZv/MwgmlJ5quvxB7oSQsaZBMALW3lV3wxES5TCtJMB9vloDMyPfAuir7X4Gpmeh327bxPP9IQiYfaYnKisSkjD9ZYFcVD5/45feESQg4Ivpq8Bezi87fxz6yja3dWNPDNjMm1gpE34OXNpZerpoM0YeNBvpmYPy8FceiwEvPcFGW63alxg3E5GjtQnzDf93b2WzrIGwQ/sH+pa37AJ6cjwSpAePWngMRWrsC9HYyzCoU7FGsD3hr5NApSpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=357IRS9i0aw/UsFhHsw8fvFxog38NDwoPRdVdyli4bI=;
 b=mF50xgqrJ5DjclNM3oRDtUhqGRpGXpv/ghmlbOiUrpim9bT5uNmGsvOzxcyS7pbJSJyw018WXnYmkXvDG4qe8U4QgBlniM36UNsPCn/DNtpwZ1w/lpAcezMBjHF0acLQQTiIsqh5jOQX0ADbMOTHqMqZXQuKfk2SeaeDNUhe74Ixrum5OBMds7biJlA6a3jqT/eL7WMkbK/cTPfR636OLKZeyo92X4vbqDz+NTwYFEzTLcEGkbVEu/3LFnx/1oAMKmxBLQiGIConArWRVdio9SQP5cNF17fasxAquQjhrsRwWen+KyJWm/rxvz4BVytvuYqXpkjJNBK5Wla1KG0+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=357IRS9i0aw/UsFhHsw8fvFxog38NDwoPRdVdyli4bI=;
 b=uWfPDGYxrQqX8ayvmB+cOKaLcd7Boyso3jt7WprlLfGlltENCEzIEJibfNSHGySrKwQSGZnbSK690l7zL76eVBKN1SV9QhKvvCGD1hrpcKkZGlDJZLKTyjxl2IVnSxrz7hIZNGAtvm9Z4HXQ01EOmR+iC3clplUiaq329Zx+nmM=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2829.namprd12.prod.outlook.com (20.177.250.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Wed, 15 Jan 2020 06:26:32 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::a0d7:f7a5:5d2d:752b]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::a0d7:f7a5:5d2d:752b%6]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 06:26:31 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: flush the fence on the bo after we individualize
Thread-Topic: [PATCH] drm/amdgpu: flush the fence on the bo after we
 individualize
Thread-Index: AdXLbKeaC2EQAJ7nR6eaEXnBydxCEw==
Date: Wed, 15 Jan 2020 06:26:31 +0000
Message-ID: <SN6PR12MB2800D9829487F03471B416C787370@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cf287aac-f682-44b2-8fe6-000005d55540;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-15T06:24:47Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ec2407c-7141-4329-c9c2-08d79983dca3
x-ms-traffictypediagnostic: SN6PR12MB2829:|SN6PR12MB2829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2829DFBFB1C7745346706E2687370@SN6PR12MB2829.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(76116006)(55016002)(4326008)(2906002)(9686003)(66946007)(7696005)(33656002)(71200400001)(6916009)(66556008)(316002)(86362001)(66476007)(6506007)(186003)(52536014)(5660300002)(81166006)(64756008)(81156014)(66446008)(478600001)(8936002)(26005)(4744005)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2829;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYSMKhWQizBF+imIQWOP6ckz9/akO/kOFbt5N+xVISPbpqgtNx2bqWcRwLOcA+m/1wTHGECBe3mx3DwQTvYSTvDRVRFaMDxxDsTLJTP9lG5EusFftZU169VBWP+v8DfylhOsWV3u/p8TJLeViqQpyahydaSx95oo+TImgmuzkGwDFzWnIq2kI8m7GUFu5dgNxnZ4l8WGFgcoI4DB0VNGMiV7o82hC7cEIuDx3GBJ+4XHenwZlEfrub8nLw1nPldG93FWLFhrjO41aVuGK/QmdR454y9R1l7mF26cuiApt2HZDVZKux9TdjCr2fUm9W5WtwpqndDpmSia4oq5a41hS1IFNw4CM1N/Fpvzm4BF3Gb6F6D33zzY7mSGD0fB89gKh2fqVecNq6ftc8iLbkP6b75O3KBxtolkNaZRzbRe8Q0PXp+ozcjgwgZm8kJQexZP
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec2407c-7141-4329-c9c2-08d79983dca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 06:26:31.5380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ny8OsvunEt99FzjhJ5/xnTL2LpQCbZBWGMmtDGvNQO1fK7ZNNndZ7UT+IzxqiKX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As we move the ttm_bo_individualize_resv() upwards, we need flush the
copied fence too. Otherwise the driver keeps waiting for fence.

run&Kill kfdtest, then perf top.

  25.53%  [ttm]                     [k] ttm_bo_delayed_delete
  24.29%  [kernel]                  [k] dma_resv_test_signaled_rcu
  19.72%  [kernel]                  [k] ww_mutex_lock

Fix: 378e2d5b("drm/ttm: fix ttm_bo_cleanup_refs_or_queue once more")
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 8d91b0428af1..1494aebb8128 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -499,8 +499,10 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
 
 		dma_resv_unlock(bo->base.resv);
 	}
-	if (bo->base.resv != &bo->base._resv)
+	if (bo->base.resv != &bo->base._resv) {
+		ttm_bo_flush_all_fences(bo);
 		dma_resv_unlock(&bo->base._resv);
+	}
 
 error:
 	kref_get(&bo->list_kref);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

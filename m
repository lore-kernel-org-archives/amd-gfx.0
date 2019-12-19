Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D057C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 12:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC03227BF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 12:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EwEbyK10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC03227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841CB6EB56;
	Thu, 19 Dec 2019 12:35:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770074.outbound.protection.outlook.com [40.107.77.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C70F6EB56
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 12:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBvAXSitwkhM+kfeyFDE9jRgW/MHdAOlIzpJKhI9qBWYHtIh47Bnpo2gPR90bZCARaroETOOCD5Hwnt9QKMQ9w4WzDC1w34Zod2TZlbI9iYRo490OImz+vF07pq2sFWx80K07qlWqscQWclHDiPMhOKUfCe5RWp7RS+91SZ8nPTNY25V2w59DBFqy+c5RlBXkuz2jRsu2e8LkC1bUe8NN1RuXqk4kyQ3ruNT5h4oy0LTskPbYwF0boYbqwob5aSI59zh7PCjhKglWc9KRTioi4GRzH1OEjLmbp4wIMBC48k13beV4HaUhXfZLz2wi+nBKygXOBLqKardTw6Em6T03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kIxIuOSpb69xGBzzcBKRlTvscsALZxmh9371VFXWVg=;
 b=RjwwujuqimCMTkn0/PgDrdynkP1pf8aImLpTAYKIVPQmXwYZv47OQrZ/1NIKYn3uckmenT1lbgnyTDXWcchH2vlbpPU5jbBzMStmf6wgdN+9p57c4vsae/Y818sQ/3iLYv3BAyx4/paZ/52GRraj2QtAYDhCh3nIEryhON2Iz3JNZdPRZUj4IQ0OffLwRPL94NF61czZ6J8dhV3tcISrjZWjnSFwi23dOXXSOOPV2OkTDBludSjhFxiQ1tRygoLKOGdjZIShRGdnsrKG1jWErdST5pgcw23AVafsm2gmYcCUWJfdDqSd8EI5i1s5MxYiIrI/2IRFC9pXzYS9TYlN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kIxIuOSpb69xGBzzcBKRlTvscsALZxmh9371VFXWVg=;
 b=EwEbyK109lC7h3N7fY7XlGPOjt4K/aGYwYY+QHiIDciWeGqIO3A+bj10Y8LhWdqiSWAXpLl+nrtd+aJG7EWrQ8gt6bRqxkGSBC54ut3N7kIWKYP8/8+vjF3HFAqO9UQXhBBDVnrkHeBcXOfqDXavSWUz3R/tXW3Eym4TnNni+pc=
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1545.namprd12.prod.outlook.com (10.172.35.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 12:35:47 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::ac23:474e:6736:bc53]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::ac23:474e:6736:bc53%6]) with mapi id 15.20.2559.016; Thu, 19 Dec 2019
 12:35:47 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn2.5: Silence a compiler warning
Thread-Topic: [PATCH] drm/amdgpu/vcn2.5: Silence a compiler warning
Thread-Index: AQHVtig+WZyFX60ZVkarea/hCtDPN6fBZUBQ
Date: Thu, 19 Dec 2019 12:35:47 +0000
Message-ID: <DM5PR12MB245642C3B8C049FAC9064EBFE5520@DM5PR12MB2456.namprd12.prod.outlook.com>
References: <20191219045217.266476-1-alexander.deucher@amd.com>
In-Reply-To: <20191219045217.266476-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
x-originating-ip: [2607:fea8:a200:445:453:6453:8d60:ff11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 698b2b22-0686-4969-cf4b-08d7847ff95e
x-ms-traffictypediagnostic: DM5PR12MB1545:|DM5PR12MB1545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1545B55B39CAD5925E6A95D0E5520@DM5PR12MB1545.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:363;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(13464003)(199004)(189003)(966005)(86362001)(478600001)(64756008)(66556008)(66476007)(71200400001)(66446008)(45080400002)(66946007)(52536014)(76116006)(5660300002)(4326008)(8936002)(186003)(53546011)(7696005)(2906002)(316002)(33656002)(81166006)(9686003)(110136005)(81156014)(55016002)(6506007)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1545;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vHAsqdTKwLbVe3P3PSUsZwoCyPgLJhkYLJL1mYcA9FfKgsw38MCXeivSrkmJtDrbrPBA7V8qeupE9PGw3zzTfeOboSXEVzLnseECTfinpYa4n6ZFp0X3NEoxCNQ037jXA56ge0aOe23nboVQQ5o/KMZfyBgegi73Q0cneMTrcUevc4hIbQguDzoEM3lLVixN3ORfK+qu++KMt9bzYdXQD8/Ww2WfAZ+2fUns3/0MWEeoi4sBIpPJPrKc5loDwcQV3kT1OsCDVteOBEUnA3itvW36rppR06SJPGD5w+sHKOFQFdYQKnQlLRbKK1lABA853QPtilDMpZNueBarLjk1zGSotonwYY6XsdwXkmxmf3+BooibsMeMACMySJZ6vOS0TJEMq5T+AWUP72zFjYLl+esq2mqrSA8IMXTSrCKBMGgc9eyRkpvqn1hqOxMUZ0cH38quMky7KD4zWN6xbsfEWRqqCND78r6bWcAfZtqqIZue0aUjNBGjDC0Kxv0sD/TUyb7iz1SOZhBrtzqKVUM2IQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698b2b22-0686-4969-cf4b-08d7847ff95e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 12:35:47.3399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8htOBxWbHj/36TNRrO+oDmjnsdiDJu32K2Hnm5QUuEKeGHgNu7vQlTOc4TeS7jau
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1545
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: December 18, 2019 11:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn2.5: Silence a compiler warning

Set r to 0 as a default value.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 3271de38cb08..4ea8e20ed15d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -250,7 +250,7 @@ static int vcn_v2_5_hw_init(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	int i, j, r;
+	int i, j, r = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		r = vcn_v2_5_sriov_start(adev);
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7C922f8df051e341f03ba008d7843f41e5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637123280044261581&amp;sdata=J4O0i2nvakYyyTP%2FsJospqbWP%2F%2BkWxxV%2Fv3vxabBJts%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

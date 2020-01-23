Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9E7C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 18:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B1821569
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 18:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GKaDcOW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B1821569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6EAD6E0D3;
	Thu, 23 Jan 2020 18:35:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CC06E0D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 18:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etDonlzIpnNmTuGlz40IndANAx+xh75QNjTkr5GTtefAZ3WnEJ27JYJ0fETULZG+KHPMj7XqzgO+MDdJ6kL+oUumxGypJeH6R8gioLB9DArmO/qGK7/2EphppBdPIhfX816IO59l3SUFWxWGcxKmgmYyGsQXb8v7TFnU06BMHDqt6InImcEZtM19kY6WUfOzKBWmzkpQ40UZZ//Ncs3fIFVXp2iecUzvK3u6Jl4GG0TO7f1BIei/XvGDJtc699ASWgDiAmkJW17dj+us4EYpmH0Ydc2v65YgAd5gDKYcMvu3DO5+XgcYFWfNuQ/nlG7l93ujbGH9bBk24GhS+1yTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv3sF/5M8zIBDOEcN8y2yHsKeX1IKF5LS3IOKWqCAS4=;
 b=ajtQIAX6Mphjg1u+CEAJArkImkpEbT3y1oZpgnPPzHB7+zbkbwtYjyQB96ZpVIcSxdcCNNCgDyZStdEeN9IO9ZXZap6c/URtnhWjbkNWUC81G1UjooYMTm8Fvw98OTQ9QldTkQC6/b3JJsJSIQEFNbmAkDwhD0Hi4pTVIBO2nYkoQJBCqS41Wem8xACCIXYMc8hKUusMg57VJw6WDqdAXTbvLk9USkzt17eoj4XJmXxRMcEtgZ5IpLU38Jwq3Sg4u3Ki52jku3q+JZK0p3hhGWb/a0+GHHb/e0+5o3dgsbZNiHZltK1XBgy68lVNAMMklrNe/qMIp/NG1D2/0ERlzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv3sF/5M8zIBDOEcN8y2yHsKeX1IKF5LS3IOKWqCAS4=;
 b=GKaDcOW3JfNuM83hEuOcNETRQOV5zMN41yga5VNfQmA04aVLG1H+DjWG1i4HYAU8dkQalUMke3ohpfZI21qNEYdk0qnsbdi1CC6rj7KV0y1cEWZnq/CFSClbOjfmR6Os68NzXqGd8+Tq0fCmvxDpoyS8fokqP1wf1GQVUCBdWXI=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1499.namprd12.prod.outlook.com (10.172.36.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Thu, 23 Jan 2020 18:35:14 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 18:35:14 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: original raven doesn't support full asic
 reset
Thread-Topic: [PATCH 2/2] drm/amdgpu: original raven doesn't support full asic
 reset
Thread-Index: AQHV0g9nDvHrrv+yokm5WWD9ALwEOqf4k23A
Date: Thu, 23 Jan 2020 18:35:14 +0000
Message-ID: <DM5PR12MB14189BA1BA3A1C951571F0F1FC0F0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200123170549.4179-1-alexander.deucher@amd.com>
 <20200123170549.4179-2-alexander.deucher@amd.com>
In-Reply-To: <20200123170549.4179-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-23T18:35:04Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=35674def-77fe-4a58-903e-0000a90e5ac8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-23T18:35:11Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c6a4b32e-6409-410e-86e7-00003a745ae0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4db0d477-8afa-4f7b-b8d0-08d7a032fcae
x-ms-traffictypediagnostic: DM5PR12MB1499:|DM5PR12MB1499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1499BBBCAB7297C8C19A719DFC0F0@DM5PR12MB1499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(199004)(189003)(55016002)(110136005)(9686003)(966005)(316002)(33656002)(45080400002)(76116006)(5660300002)(52536014)(66946007)(66476007)(66446008)(81166006)(64756008)(81156014)(478600001)(4326008)(66556008)(8676002)(86362001)(8936002)(186003)(71200400001)(7696005)(6506007)(26005)(53546011)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1499;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xc4TUYsnZk3kbbJVUe3E4ZcM5jBQg/zrbtsJtNIx3Yj6BsJ6CAWl9KbDGXucHzYqtucGVQjT8Ck3cLBOAzf3JfFsssq24o7sW6VHsuNlGlpG2hVGsB52SuEfC6TDOzC/98QHnwbvNs471cF15knRST3K+RG8lhmP6W8FooVgFGCOtIjZ9RUg0ZjjX+txXqtKSZT/aT9matwKBLHQF6yjRtWCytyLmpoYxMcOhxf9WCdw1v5ARTMk5UhHzWMDE4FMUFBbpsWqhDQXx7FYM16BGO76YkP3no+evMm8wxx4GTNRuty1I3bk59BpakXeR7EI6aPbUXj8IPbBuMdWZxAVnc9w1DztTC0zNO3XcesK8A1D0/daXgh9AHy2as/4R7o7feS/sRiidPr1KJ4d8BOm9OdX4Bvunid1K9BgSNHaL8IoaMD+ZkADWV9nqHHMDUOE3FUSq7ky8ZU6xPUB067t4WQK7kMMeE5sqDgpLOb8qFw=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db0d477-8afa-4f7b-b8d0-08d7a032fcae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 18:35:14.2403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQTrTWAmW5bkTMNJYC2lK/dvCGxxGnZXp/X0LqsVXnUa678ZFa7qrEhkkK1aHN7tN5sGYrTb6Ch5JEbwIfMUmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1499
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

[AMD Public Use]

Series is:

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, January 24, 2020 01:06
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: original raven doesn't support full asic reset

So don't use it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index af41ee4c9639..15f3424a1ff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -537,6 +537,10 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 
 static int soc15_asic_reset(struct amdgpu_device *adev)  {
+	/* original raven doesn't have full asic reset */
+	if (adev->pdev->device == 0x15dd && adev->rev_id < 0x8)
+		return 0;
+
 	switch (soc15_asic_reset_method(adev)) {
 		case AMD_RESET_METHOD_BACO:
 			if (!adev->in_suspend)
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C69ec6c70e45d46e9bdf708d7a0268592%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637153959680502484&amp;sdata=iKzyHyCwnqWtauduoGmuJv3sHwweJo%2FeG8UdaCvBuDs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA0C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 16:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B7D2073D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 16:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pVsYwOpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B7D2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BE26E9FC;
	Mon, 20 Jan 2020 16:37:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A976E9FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 16:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co/Sn4IJlR06NRDnqElDuF87lzxMYFRdVc19TaPjGMQTymp9FVozPVFGeNsid2QmsEMZf1I36kQzgtXFIEke6wwrRgpzT/zalT/ybpIsJn16JHncpToLPOmoGH1PUlLahBOFozv2QJwZKBf0prV7xXgJHfJgn9+llfcQHNEpXSwywP6N5r95NEff2gLwaM/rigm6Ijjgof8Z+5l3mE8WBtAknJP+qyufCl1dj2BToZPN2ack/FK+XorVTpH3yMegdrE1AGUvYP/yPoo9U6VPtrsLJiHxkG04myIg4yn/ahbnEP2yeGvFx7GFV3Z01EDiP5Bo8DcVJ3LZW210jFd3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvn7QlHnV0mQ1m2ToQWU/ribstEPumiCz57Iqlmgdwo=;
 b=iNyx2e4jLqoGwWRxJj/SEgrIIvCrzC1d4sATfAJnbI7JBKO6CktB7pwjoJFDh4Czfut42AcE2C59FMzJV7Q4o921DwC1SnDPwRk50pzXuzCsSi011eugppgCEblYlBp/u5cD5UB1FYWGIm/oWt8dxj7V48KllLuVA6k/4H2Pqme/5u9jjGzFKvN2B/wZtQ7Sygl8rkgwytefR+jTA0AXlUZV4fz/3s/WokHvmLL+IUFPZlOynPGbssYr9cnegsrPfnimNTjL9ewiq6+m4ppWUfRsAoNtWVZCPfrrm72CMrZkbmp39oWfshKEYzS/wMRJUffzz4o9iUw2ofXU/9VBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvn7QlHnV0mQ1m2ToQWU/ribstEPumiCz57Iqlmgdwo=;
 b=pVsYwOpzeDKtS8I/XDbwW55bugMLFraeELokIEFhFiZ0QoovSdUN8Xg1jsCBjR7O6gmPguia+xIxtlJgzr16/6muEoj/+m7BdhESLOEt4s1DwKBCCsYav3lLczxG9/CEYofoRWeu6ogwGuwiztcXNAwhKXRu6bMa9tVnFql/vFQ=
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2529.namprd12.prod.outlook.com (52.132.11.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 16:37:48 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::2927:8ef9:d2e6:98fb]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::2927:8ef9:d2e6:98fb%3]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 16:37:48 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Use the correct flush_type in
 flush_gpu_tlb_pasid
Thread-Topic: [PATCH 2/3] drm/amdgpu: Use the correct flush_type in
 flush_gpu_tlb_pasid
Thread-Index: AQHVzZ/5HyvVXt+H/kWgS2EMe7iFZqfzxI1w
Date: Mon, 20 Jan 2020 16:37:48 +0000
Message-ID: <BL0PR12MB2580C6F303D2EA595017914680320@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20200118013735.19361-1-Felix.Kuehling@amd.com>
 <20200118013735.19361-2-Felix.Kuehling@amd.com>
In-Reply-To: <20200118013735.19361-2-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-20T16:37:46Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e9cc62c9-991e-4a9b-b789-00001e608b24;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-20T16:37:46Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: dbe15066-3fad-4bc8-b0ce-000088d132ba
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33a6f4d3-07d9-4144-2106-08d79dc715e3
x-ms-traffictypediagnostic: BL0PR12MB2529:|BL0PR12MB2529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2529D0C928D08FD4B476E90080320@BL0PR12MB2529.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(478600001)(966005)(53546011)(55016002)(33656002)(9686003)(86362001)(66556008)(66946007)(64756008)(6506007)(76116006)(110136005)(66476007)(71200400001)(5660300002)(7696005)(52536014)(2906002)(66446008)(316002)(45080400002)(81156014)(8936002)(81166006)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2529;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tltV7iJelWKHlHKo9MuYrGJ0PDGHlZnHZ+8XdXu00xc/HNeM8TJV+xh6gKP+hiu+P9GG2NFsqCvHd1ckTIcFSA93a2H5YRU5ix/cA/aZm26zLbgmflvzEpU1M7DgByOHm31NKOrD7llU6dzEH+pjQNyzRJMcYJOD/6ACacTkJtccRkAFr50UoOVojw3IW1KP3xtqxfNvs0TkOOLFuHL01z+9iKC6ZAqaHoE3arnJQu4LOLsPnsgsm5wsxHMWm3Q9TDJo3TgQQCIXUcJcYSYq6PPvUkyrLb9X+w/8aigzR0U7twFIrccsHpR44m2kpG7k8XXYpV52VR5qTrTkG1fa71iyb1gzmoLurEQNyaPrHHd1CEvVBjd84NPj6riLn1b8OWTb5IhNhQRl4NkBz1eiBJRb9zaWxwUjZtJd2XT9KwNUirvNv9PculDwPg35SV4H2o6zPZKildUjvNApfqkg/KQHlo0ZHm+vTlt/rXENcu4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a6f4d3-07d9-4144-2106-08d79dc715e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 16:37:48.5894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FkUXb6rpdtFdwLjwMOJRDe3xVnsKcPIFoeMCK8wP0E05/Y6ekG7p2CbVsLGQv/b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2529
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

Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>

Regards,
Oak

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
Sent: Friday, January 17, 2020 8:38 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Use the correct flush_type in flush_gpu_tlb_pasid

The flush_type was incorrectly hard-coded to 0 when calling falling back to MMIO-based invalidation in flush_gpu_tlb_pasid.

Fixes: caa5cf78387c ("drm/amdgpu: export function to flush TLB via pasid")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 ++--  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d914555e1212..a1f7bb42e6b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -443,10 +443,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 			if (all_hub) {
 				for (i = 0; i < adev->num_vmhubs; i++)
 					gmc_v10_0_flush_gpu_tlb(adev, vmid,
-							i, 0);
+							i, flush_type);
 			} else {
 				gmc_v10_0_flush_gpu_tlb(adev, vmid,
-						AMDGPU_GFXHUB_0, 0);
+						AMDGPU_GFXHUB_0, flush_type);
 			}
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6d95de1413c4..90216abf14a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -602,10 +602,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 			if (all_hub) {
 				for (i = 0; i < adev->num_vmhubs; i++)
 					gmc_v9_0_flush_gpu_tlb(adev, vmid,
-							i, 0);
+							i, flush_type);
 			} else {
 				gmc_v9_0_flush_gpu_tlb(adev, vmid,
-						AMDGPU_GFXHUB_0, 0);
+						AMDGPU_GFXHUB_0, flush_type);
 			}
 			break;
 		}
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Coak.zeng%40amd.com%7C21f63466ef6e4931800f08d79bb7185d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637149083047847133&amp;sdata=zacZX9gCwsZSHopHhk%2Ba72D2Piq6M8%2FMrZlEvJ0Iw70%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

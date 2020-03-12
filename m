Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4FFC0044D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 03:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B6220734
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 03:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gf6Kj4f0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B6220734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8254A6E239;
	Thu, 12 Mar 2020 03:14:17 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809696E239
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 03:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHAuVr0s0SzrZhBf9GbyFEBn5UuYCtCYtD9t0yfqd6qtZdVwC+KWSUxdftCLl7KPUaJBZyT40tLhO39uR4mE+5aYS68d04req7IOcK22MMA63XfLt4q38+KszHoYuqmqp04CooRJqgBLFNbvJQWSR30RLj4KYgNO4v5eD+aCQnT3QIrQvY0R/IYU6DijVhjASasItbbPyB2dGRMZ7XxvSvUyXAkRjUD0S2gABY9yUqubDFEWT4nkplke1e8fk/vAoZvFP17+us71aScaZTQ9/1Ncq+FTzC1EKoz9WsDgqj00GkKCXWbs5xKVlzVEY68DoUEAp6Jkyq+XIfkGUwvdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmCbTz76G6rdJ0C1Y1gOZxkGM3uWd0GWLh40c4Jmz24=;
 b=PB5pDNF+abrX0dG2z1hiY5zQ3mPC2NHjQfrlohw5tFBnZ8sSYxv0Jbfq52MD9AIckvtBEQ01i0C0pjRxlg7Ib6wCZ9cMfPbJC9+fYHw0900K5AbxPslNhd/9vRMYHuYLh9ArX5xs/842/Bd3nswtkC9qZntpWkERhshK9AlJbsWrY41S6f0Ovf1Kxmq71dVH5l8ARIH/0eC1ZjTaEXjg4Ncrha/wP2jY65w1LndkqdMLiqKn0otKxU9VvuGCKLFR3/IVeD1A6aMtjpSFT/PDbgdHnBz6N6uxGTzAEs1eW94qjlE0oPE8UgfyhotsA8yOvXReDkFz5uL815oI02d43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmCbTz76G6rdJ0C1Y1gOZxkGM3uWd0GWLh40c4Jmz24=;
 b=gf6Kj4f0dl9XLB8FCGxcqsP2t/u4wqGfE4cdVyx35cj3x/L3K7CD+V8/zd6VbH6vGfHgLr9fNawI0tfJigshYX/59nvHvvdf9YOqJR/wuXAC4X1cwlFqYwxBFQV/coBiT4+4vKxb8ZcyVX7kmnvlcTltrAZJ6qp02VwbN7tDQcQ=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 12 Mar 2020 03:14:14 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 03:14:14 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: remove mem ecc check for vega20 and
 arcturus
Thread-Topic: [PATCH 2/2] drm/amdgpu: remove mem ecc check for vega20 and
 arcturus
Thread-Index: AQHV+BmuNcH6RZD0BEOREsYx+XsoxahESCyA
Date: Thu, 12 Mar 2020 03:14:14 +0000
Message-ID: <DM6PR12MB4075A98F875EE9C20A9CD8CAFCFD0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200312025447.21000-1-guchun.chen@amd.com>
 <20200312025447.21000-2-guchun.chen@amd.com>
In-Reply-To: <20200312025447.21000-2-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-12T03:14:12Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0a88139b-4ff2-4375-9869-000033fbae93;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-12T03:14:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b83609c8-052a-4ce4-ab34-0000f3c9b761
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82443762-bba1-48fd-e76a-08d7c633714c
x-ms-traffictypediagnostic: DM6PR12MB3737:|DM6PR12MB3737:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37373E284F905C0215E5C227FCFD0@DM6PR12MB3737.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(110136005)(81156014)(7696005)(5660300002)(81166006)(8936002)(52536014)(478600001)(64756008)(86362001)(66446008)(66556008)(66476007)(66946007)(76116006)(8676002)(71200400001)(316002)(6636002)(6506007)(2906002)(33656002)(26005)(55016002)(9686003)(186003)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3737;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYwXv+kewSK0by43UpVlVI0TZiFHiaHUVrpWItOfFbSBsmPJe1Xd+TGilSg10uh6ye37YcceaB7eF22AoJTjrqol3tlU9LvkbuwmabwdVFapgAEWCsTm/X7cXh0mKWvnq53pgnYSB66tK3iSIgKi8kjGfUVvzvKmP5IWdeXWclP+Wg7r4cvtbx3K5sz7T3fReZfkPDm2SsUOCr/Z4rpRyHVH1NFjdcCNZ+SmxSlQ5g8RzEVJgX6wOFcO6eiuMs43DYR/mWYNyLCygZvT7aomuU4tmiGD2WgF1a87boT6/sAZRDtCuyn9GzfEgc/5PR03zfLkkf3IYh2+1Kmvzf70U23wGdChCuzXNmj3jEmfwFIDIuLmT5vzZ2L6zcIriPrLe3mQtE1jOOkrEhtcXCintk3kqYV8feaU2fXOp0e6s6tPeKuKKgTPpXbGSQOZJSD0
x-ms-exchange-antispam-messagedata: 7s+gtZ4qlkNt6sjpt0iI6xQ9FEnH7z6ZK8iCd9kxcJOBTPcdAxjCLfSRzUd4qCyKiZHokrIEOTCHcSeOqwWnVy8Fvvhdd3Mcmcr1CMPUflfyuxftXZen/2oL0zDXHZum2UZo1XLTS/jZNS/eK4XrZw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82443762-bba1-48fd-e76a-08d7c633714c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 03:14:14.1566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrNOeY7bdAiRN3h7cTTCt+UwFr6H7WVwX0aMMpL/bwAFH0mrD4AiLWcd4JGTK58CFg1HTzwcIH64TXmW9xgjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
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

I think we can merge the patch with first one as they are all refine current logic for querying ras capability.

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, March 12, 2020 10:55
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: remove mem ecc check for vega20 and arcturus

Memory ecc check including HBM and SRAM has been done in ras init function for vega20 and arcturus. So remove it from gmc module, only keep this check for vega10.

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 90216abf14a4..9bde66a6b432 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -887,28 +887,20 @@ static int gmc_v9_0_late_init(void *handle)
 		return r;
 	/* Check if ecc is available */
 	if (!amdgpu_sriov_vf(adev)) {
-		switch (adev->asic_type) {
-		case CHIP_VEGA10:
-		case CHIP_VEGA20:
-		case CHIP_ARCTURUS:
+		if (adev->asic_type == CHIP_VEGA10) {
 			r = amdgpu_atomfirmware_mem_ecc_supported(adev);
 			if (!r) {
 				DRM_INFO("ECC is not present.\n");
 				if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 					adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-			} else {
+			} else
 				DRM_INFO("ECC is active.\n");
-			}
 
 			r = amdgpu_atomfirmware_sram_ecc_supported(adev);
 			if (!r) {
 				DRM_INFO("SRAM ECC is not present.\n");
-			} else {
+			} else
 				DRM_INFO("SRAM ECC is active.\n");
-			}
-			break;
-		default:
-			break;
 		}
 	}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
